Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81A5F43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 752ED842C9;
	Fri, 17 Apr 2026 14:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="UuTQEKEp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13C7A841D5; Thu, 16 Apr 2026 16:53:22 +0200 (CEST)
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E16F7840AB
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 16:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-12c63e942f3so1000886c88.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1776351197; x=1776955997;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E2++L7HIUC1x25ffDvisMk+zIeoTKfp+WO2t2VKqfno=;
 b=UuTQEKEpcRXjj8bHK1BFuaxGsuLNUVvmnNrJIhjNyl0SazhYhLMOWlLydsSvKmijut
 dgs5ZUsmJ4Tlg4Ub8N3W03as66L3W1/5kW3wqXJc/xz90t2HEWAHfu7L/jjLV3JERdKF
 J/0MSvcsYAYOKlE4wUdbIZ8kitjNX4B6/D8M8aMbDuEUxee6f1vMpo0KkgHmZVcC0gm8
 E/SyG2IcCAW7PHpXhmH+xob+I/kMhUiS+rZjbc19TSTD7r0ojIToQ4i3Xpy4377dz9en
 zaAcvcqE0LVXIMbSs/gsmbhkDyuPduGpU2aymvtGfToCvoWi4Z+rZKidQz3UZ+rz+gmm
 pe+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776351197; x=1776955997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2++L7HIUC1x25ffDvisMk+zIeoTKfp+WO2t2VKqfno=;
 b=ossIb9HRmHkYSCHsa4CvTUdPEpVCGeWMS/5PjEzrJLRSzsnp0UQnJMlHs1vwKo+/gh
 wQFle5mnoQZmtShWAl4CrOmiA2v/SDq8adNVz+Xnkf1/mxv2WFCtzfItoJCVsD/ZxtMm
 GmrQ26Mv+z3+JwCz8BUiTCVMwQWm1XJyUl3Yb4A92fNyYuZAztn4QBK6MjTiEx9jqktc
 uPwM1+vjveM1baG6Y3kz/0xZRwj/6kWcUEyqx6a9/SuDtpuEYb8AmXbb93i6bsJY6PhD
 uKVatizCSt4exfNJbWx6uvTaNx3AfT/j1XnlflcDJma9dXDm8gMgBKpIVqa3hQ1MRK3K
 DVFA==
X-Gm-Message-State: AOJu0Yzv98CebI6ges2Tmg3ux91WDIPT92WDMWP0XR8PWcNL8PBqH+Cr
 xdCoS4UZX3qINlB09wPoUGxDGrGpaeHsBW9gpIPmfWR6e/mFKf7sukDZ9O8gl10MzvHsoxGXJum
 39xWC
X-Gm-Gg: AeBDiesEP1O13GfuAIAtm+Ub8a7dMKE8Lau/ccwtTVO+QJNIR7WgfzYxjqTo/6DLJKV
 4NexuVaIxeJ/ISkgAaSeqVy0hFj+N6TSjbM0L4rFjBUGlZknrtOSB7u5OavYI/25PaeUuXHn4Yr
 B2I03ywjAlpggnCn7Pmj+VuTCjuJcOCa0jTvSnMI8U/079gkdoUnn5DKzZ6rJEJ3CueCUndFuRM
 ingsuftuJ7fNrhxDTVV5fvRBRjWZ84S54XvICdHWJXI6Uwag5rqbva6QZm5+I+wwjOnvAD4HAc+
 HycATBQJB7Hh0N7kemfyRWk8hjFL7wlsmzOw6WhTaIwO2Rf4UFZsKWT3lOAuymdeyUcuguhhVIy
 3ZGZppM553vq3RqswBQP8v6YgXuozka7TrflZLA36BHNw+GU3tpyx/Eo5lNh+ndTCTe5AIaUMHu
 2NlHJ4LPojcJB8T2DBzYh6tTZo2rZZPwvq4s8a6mnX8y4pnNbabiuOLagOwDq+QbHrYlbpaQQh8
 Jk=
X-Received: by 2002:a05:7022:670a:b0:128:d752:e076 with SMTP id
 a92af1059eb24-12c34e3f38dmr15147699c88.3.1776351196666; 
 Thu, 16 Apr 2026 07:53:16 -0700 (PDT)
Received: from desktop.. (mvx-187-111-24-186.mundivox.com. [187.111.24.186])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c5e6a8496sm6111564c88.10.2026.04.16.07.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 07:53:16 -0700 (PDT)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.denx.de
Cc: sergio.prado@e-labworks.com, trini@konsulko.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org,
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com,
 wolfgang.wallner@at.abb.com, bb@ti.com, y.moog@phytec.de, afd@ti.com
Subject: [PATCH] binman: x509_cert: add PKCS#11/HSM signing support
Date: Thu, 16 Apr 2026 11:52:59 -0300
Message-ID: <20260416145259.2985564-1-sergio.prado@e-labworks.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Allow X509 certificates used for K3/TI secure boot to be signed via an
HSM using the PKCS#11 standard.

Two new make variables are introduced:

  BINMAN_PKCS11_URI    PKCS#11 URI identifying the signing key on the HSM
  BINMAN_PKCS11_MODULE Path to the PKCS#11 shared library (.so)

When BINMAN_PKCS11_URI is set, it is passed to binman as the pkcs11-uri
entry argument, which overrides the keyfile property at signing time.

The openssl bintool gains three helper methods:

  _pkcs11_use_provider() detects whether the pkcs11 provider (OpenSSL
    >= 3.1) or the legacy pkcs11 engine (libp11) is available.

  _build_key_args() builds the appropriate -key/-provider/-engine
    arguments for the openssl command line, appending ?pin-value=<pin>
    from the PKCS11_PIN environment variable when set.

  _run_cmd_pkcs11() exports PKCS11_MODULE_PATH and PKCS11_PROVIDER_MODULE
    before invoking openssl when a module path is provided.

Existing behavior is unchanged when neither BINMAN_PKCS11_URI nor
BINMAN_PKCS11_MODULE is set.

Tested with SoftHSM2 and a Yubikey using the verdin-am62_a53_defconfig
configuration.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 Makefile                        |   2 +
 tools/binman/binman.rst         |  18 ++++++
 tools/binman/btool/openssl.py   | 106 +++++++++++++++++++++++++++-----
 tools/binman/etype/x509_cert.py |  47 ++++++++++++--
 4 files changed, 153 insertions(+), 20 deletions(-)

diff --git a/Makefile b/Makefile
index dfc95d314ddd..8d6c584b2731 100644
--- a/Makefile
+++ b/Makefile
@@ -1701,6 +1701,8 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		-a vpl-dtb=$(CONFIG_VPL_OF_REAL) \
 		-a pre-load-key-path=${PRE_LOAD_KEY_PATH} \
 		-a of-spl-remove-props=$(CONFIG_OF_SPL_REMOVE_PROPS) \
+		$(if $(BINMAN_PKCS11_URI),-a pkcs11-uri="$(BINMAN_PKCS11_URI)") \
+		$(if $(BINMAN_PKCS11_MODULE),-a pkcs11-module="$(BINMAN_PKCS11_MODULE)") \
 		$(BINMAN_$(@F))
 
 OBJCOPYFLAGS_u-boot.ldr.hex := -I binary -O ihex
diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 3f725868c8bb..ea91199b1e22 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -2165,6 +2165,24 @@ BINMAN_INDIRS
     Sets the search path for input files used by binman by adding one or more
     `-I` arguments. See :ref:`External blobs`.
 
+BINMAN_PKCS11_URI
+    PKCS#11 URI used to sign boot artifacts via an HSM instead of a PEM key
+    file on disk. When set, it is passed as ``-a pkcs11-uri=<uri>`` to binman,
+    which overrides the ``keyfile`` entry argument for all signing operations.
+    Example::
+
+        make BINMAN_PKCS11_URI="pkcs11:token=mytoken;object=mykey;type=private"
+
+BINMAN_PKCS11_MODULE
+    Path to the PKCS#11 shared library (.so) for HSM signing. When set, it is
+    passed as ``-a pkcs11-module=<path>`` to binman. Only needed when the
+    module is not already configured via ``openssl.cnf`` or the
+    ``PKCS11_MODULE_PATH`` environment variable. Typically used together with
+    ``BINMAN_PKCS11_URI``::
+
+        make BINMAN_PKCS11_URI="pkcs11:token=mytoken;object=mykey;type=private" \
+             BINMAN_PKCS11_MODULE="/usr/lib/pkcs11/libsofthsm2.so"
+
 BINMAN_TOOLPATHS
     Sets the search path for external tool used by binman by adding one or more
     `--toolpath` arguments. See :ref:`External tools`.
diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index b26f087c4470..550f318fade6 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -11,6 +11,7 @@ Source code is at https://www.openssl.org/
 """
 
 import hashlib
+import os
 
 from binman import bintool
 from u_boot_pylib import tools
@@ -35,18 +36,83 @@ class Bintoolopenssl(bintool.Bintool):
         super().__init__(
             name, 'openssl cryptography toolkit',
             version_regex=r'OpenSSL (.*) \(', version_args='version')
+        self._use_provider = None
+
+    def _pkcs11_use_provider(self):
+        """Return True if the provider API should be used for PKCS#11 signing.
+
+        Checks whether the pkcs11 provider is available by running
+        'openssl list -providers'. The result is cached after the first call
+        to avoid spawning a subprocess on every signing operation.
+
+        Returns:
+            bool: True if provider should be used, False if engine should be used
+        """
+        if self._use_provider is None:
+            out = self.run_cmd('list', '-providers') or ''
+            self._use_provider = 'pkcs11' in out
+        return self._use_provider
+
+    def _build_key_args(self, key_fname):
+        """Build openssl CLI arguments for the signing key.
+
+        Always add '-key key_fname', and for a PKCS#11 URI (pkcs11:...),
+        prepends either '-provider default -provider pkcs11' (if provider API
+        is available) or '-engine pkcs11 -keyform engine' (legacy fallback).
+        If the PKCS11_PIN environment variable is set, appends ?pin-value=<pin>
+        to the URI.
+
+        Args:
+            key_fname (str): Filename of .pem file or PKCS#11 URI
+
+        Returns:
+            list: openssl arguments for the key selection
+        """
+        if key_fname.startswith('pkcs11:'):
+            pin = os.environ.get('PKCS11_PIN')
+            if pin:
+                key_fname = f'{key_fname}?pin-value={pin}'
+            if self._pkcs11_use_provider():
+                args = ['-provider', 'default', '-provider', 'pkcs11', '-key', key_fname]
+            else:
+                args = ['-engine', 'pkcs11', '-keyform', 'engine', '-key', key_fname]
+        else:
+            args = ['-key', key_fname]
+        return args
+
+    def _run_cmd_pkcs11(self, pkcs11_module, *args):
+        """Run an openssl command, optionally setting the PKCS#11 module env vars.
+
+        When pkcs11_module is set, both PKCS11_MODULE_PATH (engine) and
+        PKCS11_PROVIDER_MODULE (provider) are exported before invoking openssl.
+        If already configured via openssl.cnf or the calling environment,
+        pkcs11_module can be None.
+
+        Args:
+            pkcs11_module (str or None): Path to the PKCS#11 shared library
+            *args: Arguments forwarded to run_cmd
+
+        Returns:
+            str: openssl output
+        """
+        if pkcs11_module:
+            os.environ['PKCS11_MODULE_PATH'] = pkcs11_module
+            os.environ['PKCS11_PROVIDER_MODULE'] = pkcs11_module
+        return self.run_cmd(*args)
 
     def x509_cert(self, cert_fname, input_fname, key_fname, cn, revision,
-                  config_fname):
+                  config_fname, pkcs11_module=None):
         """Create a certificate
 
         Args:
             cert_fname (str): Filename of certificate to create
             input_fname (str): Filename containing data to sign
-            key_fname (str): Filename of .pem file
+            key_fname (str): Filename of .pem file or PKCS#11 URI
             cn (str): Common name
             revision (int): Revision number
             config_fname (str): Filename to write fconfig into
+            pkcs11_module (str or None): Path to PKCS#11 shared library, or
+                None if already configured via openssl.cnf or the environment
 
         Returns:
             str: Tool output
@@ -76,19 +142,20 @@ shaType                = OID:2.16.840.1.101.3.4.2.3
 shaValue               = FORMAT:HEX,OCT:{hashval}
 imageSize              = INTEGER:{len(indata)}
 ''', file=outf)
-        args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
+        args = ['req', '-new', '-x509', *self._build_key_args(key_fname), '-nodes',
                 '-outform', 'DER', '-out', cert_fname, '-config', config_fname,
                 '-sha512']
-        return self.run_cmd(*args)
+        return self._run_cmd_pkcs11(pkcs11_module, *args)
 
     def x509_cert_sysfw(self, cert_fname, input_fname, key_fname, sw_rev,
-                  config_fname, req_dist_name_dict, firewall_cert_data):
+                  config_fname, req_dist_name_dict, firewall_cert_data,
+                  pkcs11_module=None):
         """Create a certificate to be booted by system firmware
 
         Args:
             cert_fname (str): Filename of certificate to create
             input_fname (str): Filename containing data to sign
-            key_fname (str): Filename of .pem file
+            key_fname (str): Filename of .pem file or PKCS#11 URI
             sw_rev (int): Software revision
             config_fname (str): Filename to write fconfig into
             req_dist_name_dict (dict): Dictionary containing key-value pairs of
@@ -101,6 +168,8 @@ imageSize              = INTEGER:{len(indata)}
                 extended certificate
               - certificate (str): Extended firewall certificate with
                 the information for the firewall configurations.
+            pkcs11_module (str or None): Path to PKCS#11 shared library, or
+                None if already configured via openssl.cnf or the environment
 
         Returns:
             str: Tool output
@@ -146,20 +215,20 @@ authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
 numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
 {firewall_cert_data['certificate']}
 ''', file=outf)
-        args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
+        args = ['req', '-new', '-x509', *self._build_key_args(key_fname), '-nodes',
                 '-outform', 'DER', '-out', cert_fname, '-config', config_fname,
                 '-sha512']
-        return self.run_cmd(*args)
+        return self._run_cmd_pkcs11(pkcs11_module, *args)
 
     def x509_cert_rom(self, cert_fname, input_fname, key_fname, sw_rev,
                   config_fname, req_dist_name_dict, cert_type, bootcore,
-                  bootcore_opts, load_addr, sha, debug):
+                  bootcore_opts, load_addr, sha, debug, pkcs11_module=None):
         """Create a certificate
 
         Args:
             cert_fname (str): Filename of certificate to create
             input_fname (str): Filename containing data to sign
-            key_fname (str): Filename of .pem file
+            key_fname (str): Filename of .pem file or PKCS#11 URI
             sw_rev (int): Software revision
             config_fname (str): Filename to write fconfig into
             req_dist_name_dict (dict): Dictionary containing key-value pairs of
@@ -170,6 +239,8 @@ numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
             bootcore_opts(int): Booting core option, lockstep (0) or split (2) mode
             load_addr (int): Load address of image
             sha (int): Hash function
+            pkcs11_module (str or None): Path to PKCS#11 shared library, or
+                None if already configured via openssl.cnf or the environment
 
         Returns:
             str: Tool output
@@ -231,10 +302,10 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
  coreDbgEn = INTEGER:0
  coreDbgSecEn = INTEGER:0
 ''', file=outf)
-        args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
+        args = ['req', '-new', '-x509', *self._build_key_args(key_fname), '-nodes',
                 '-outform', 'DER', '-out', cert_fname, '-config', config_fname,
                 '-sha512']
-        return self.run_cmd(*args)
+        return self._run_cmd_pkcs11(pkcs11_module, *args)
 
     def x509_cert_rom_combined(self, cert_fname, input_fname, key_fname, sw_rev,
                   config_fname, req_dist_name_dict, load_addr, sha, total_size, num_comps,
@@ -242,13 +313,14 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
                   imagesize_sbl, hashval_sbl, load_addr_sysfw, imagesize_sysfw,
                   hashval_sysfw, load_addr_sysfw_data, imagesize_sysfw_data,
                   hashval_sysfw_data, sysfw_inner_cert_ext_boot_block,
-                  dm_data_ext_boot_block, bootcore_opts, debug):
+                  dm_data_ext_boot_block, bootcore_opts, debug,
+                  pkcs11_module=None):
         """Create a certificate
 
         Args:
             cert_fname (str): Filename of certificate to create
             input_fname (str): Filename containing data to sign
-            key_fname (str): Filename of .pem file
+            key_fname (str): Filename of .pem file or PKCS#11 URI
             sw_rev (int): Software revision
             config_fname (str): Filename to write fconfig into
             req_dist_name_dict (dict): Dictionary containing key-value pairs of
@@ -259,6 +331,8 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
             load_addr (int): Load address of image
             sha (int): Hash function
             bootcore_opts (int): Booting core option, lockstep (0) or split (2) mode
+            pkcs11_module (str or None): Path to PKCS#11 shared library, or
+                None if already configured via openssl.cnf or the environment
 
         Returns:
             str: Tool output
@@ -342,10 +416,10 @@ coreDbgSecEn = INTEGER:0
 
 {dm_data_ext_boot_block}
         ''', file=outf)
-        args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
+        args = ['req', '-new', '-x509', *self._build_key_args(key_fname), '-nodes',
                 '-outform', 'DER', '-out', cert_fname, '-config', config_fname,
                 '-sha512']
-        return self.run_cmd(*args)
+        return self._run_cmd_pkcs11(pkcs11_module, *args)
 
     def fetch(self, method):
         """Fetch handler for openssl
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index b6e8b0b4fb09..cdeff1a227a1 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -19,6 +19,18 @@ class Entry_x509_cert(Entry_collection):
 
     Properties / Entry arguments:
         - content: List of phandles to entries to sign
+        - keyfile: Filename of the PEM key file used to sign the binary
+        - pkcs11-uri: PKCS#11 URI for signing via an HSM, e.g.
+            ``pkcs11:token=mytoken;object=mykey;type=private``. When provided
+            via ``-a pkcs11-uri=...`` on the binman command line (or via the
+            ``BINMAN_PKCS11_URI`` make variable), it overrides ``keyfile`` for
+            the signing operation.
+        - pkcs11-module: Path to the PKCS#11 shared library (.so), e.g.
+            ``/usr/lib/pkcs11/libsofthsm2.so``. Only needed when signing via
+            HSM and the module is not already configured via ``openssl.cnf`` or
+            the ``PKCS11_MODULE_PATH`` environment variable. Provided via
+            ``-a pkcs11-module=...`` or the ``BINMAN_PKCS11_MODULE`` make
+            variable.
 
     Output files:
         - input.<unique_name> - input file passed to openssl
@@ -27,6 +39,16 @@ class Entry_x509_cert(Entry_collection):
 
     openssl signs the provided data, writing the signature in this entry. This
     allows verification that the data is genuine
+
+    To sign with an HSM, pass the PKCS#11 URI and optionally the module path
+    at build time::
+
+        make BINMAN_PKCS11_URI="pkcs11:token=mytoken;object=mykey;type=private" \\
+             BINMAN_PKCS11_MODULE="/usr/lib/pkcs11/libsofthsm2.so" \\
+             PKCS11_PIN="1234"
+
+    The ``PKCS11_PIN`` environment variable is used by the openssl bintool to
+    append ``?pin-value=<pin>`` to the URI when required.
     """
     def __init__(self, section, etype, node):
         super().__init__(section, etype, node)
@@ -53,6 +75,8 @@ class Entry_x509_cert(Entry_collection):
         self.dm_data_ext_boot_block = None
         self.firewall_cert_data = None
         self.debug = False
+        self.pkcs11_uri = None
+        self.pkcs11_module = None
 
     def ReadNode(self):
         super().ReadNode()
@@ -61,6 +85,10 @@ class Entry_x509_cert(Entry_collection):
         self.key_fname = self.GetEntryArgsOrProps([
             EntryArg('keyfile', str)], required=True)[0]
         self.sw_rev = fdt_util.GetInt(self._node, 'sw-rev', 1)
+        self.pkcs11_uri = self.GetEntryArgsOrProps([
+            EntryArg('pkcs11-uri', str)], required=False)[0]
+        self.pkcs11_module = self.GetEntryArgsOrProps([
+            EntryArg('pkcs11-module', str)], required=False)[0]
 
     def GetCertificate(self, required, type='generic'):
         """Get the contents of this entry
@@ -80,6 +108,13 @@ class Entry_x509_cert(Entry_collection):
         if input_data is None:
             return None
 
+        # Override keyfile with the PKCS#11 URI if provided. This must be
+        # done here rather than in ReadNode(), because subclasses (e.g.
+        # ti_secure_rom, ti_secure) call super().ReadNode() and then
+        # overwrite self.key_fname with the DTS 'keyfile' property.
+        if self.pkcs11_uri:
+            self.key_fname = self.pkcs11_uri
+
         uniq = self.GetUniqueName()
         output_fname = tools.get_output_filename('cert.%s' % uniq)
         input_fname = tools.get_output_filename('input.%s' % uniq)
@@ -93,7 +128,8 @@ class Entry_x509_cert(Entry_collection):
                 key_fname=self.key_fname,
                 cn=self._cert_ca,
                 revision=self._cert_rev,
-                config_fname=config_fname)
+                config_fname=config_fname,
+                pkcs11_module=self.pkcs11_module)
         elif type == 'sysfw':
             stdout = self.openssl.x509_cert_sysfw(
                 cert_fname=output_fname,
@@ -102,7 +138,8 @@ class Entry_x509_cert(Entry_collection):
                 config_fname=config_fname,
                 sw_rev=self.sw_rev,
                 req_dist_name_dict=self.req_dist_name,
-                firewall_cert_data=self.firewall_cert_data)
+                firewall_cert_data=self.firewall_cert_data,
+                pkcs11_module=self.pkcs11_module)
         elif type == 'rom':
             stdout = self.openssl.x509_cert_rom(
                 cert_fname=output_fname,
@@ -116,7 +153,8 @@ class Entry_x509_cert(Entry_collection):
                 bootcore_opts=self.bootcore_opts,
                 load_addr=self.load_addr,
                 sha=self.sha,
-                debug=self.debug
+                debug=self.debug,
+                pkcs11_module=self.pkcs11_module
             )
         elif type == 'rom-combined':
             stdout = self.openssl.x509_cert_rom_combined(
@@ -143,7 +181,8 @@ class Entry_x509_cert(Entry_collection):
                 sysfw_inner_cert_ext_boot_block=self.sysfw_inner_cert_ext_boot_block,
                 dm_data_ext_boot_block=self.dm_data_ext_boot_block,
                 bootcore_opts=self.bootcore_opts,
-                debug=self.debug
+                debug=self.debug,
+                pkcs11_module=self.pkcs11_module
             )
         if stdout is not None:
             data = tools.read_file(output_fname)
-- 
2.43.0

