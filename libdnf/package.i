%module package


%{
    // make SWIG wrap following headers
    #include "repo.hpp"
    #include "package.hpp"
%}

%include <std_string.i>
%include <std_wstring.i>
%include <std_vector.i>
%include <std_map.i>
%include <typemaps.i>

// make SWIG look into following headers
%include "package.hpp"


%apply SWIGTYPE *DYNAMIC { Package * };


%{
static swig_type_info *
//Package_dynamic(void **ptr) {
Package_dynamic(Package **ptr) {
   RPMPackage *rpm;
   rpm = dynamic_cast<RPMPackage *>(*ptr);
   if (rpm) {
      //*ptr = (void *) rpm;
      return SWIGTYPE_p_RPMPackage;
   }

   ModulePackage *mod;
   mod = dynamic_cast<ModulePackage *>(*ptr);
   if (mod) {
      //*ptr = (void *) mod;
      return SWIGTYPE_p_ModulePackage;
   }

   return 0;
}
%}


// register the above casting function
DYNAMIC_CAST(SWIGTYPE_p_Package, Package_dynamic);


%extend Package {
   bool __eq__(const Package &other) { return $self == &other; }
   long __hash__() { return (long) $self; }  // hash: just address of C struct
}
