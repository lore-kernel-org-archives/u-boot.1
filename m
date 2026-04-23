Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9213CFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22983843FB;
	Sat, 25 Apr 2026 19:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="p0YdyKCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 853AC84413; Sat, 25 Apr 2026 19:21:32 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27F24841D7
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2d8ffdc31d0so346352eec.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1777137687; x=1777742487;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPWWihH6+qR8yVOIL+ONIesalJTy1218yyCJiBCdL6w=;
 b=p0YdyKCziSCZExzXpw7xuEvHZlBR/Qbk+uW2uqb0XPUxklqq9ER/QUDRaobugQZVzs
 icX5zJ6YqwYAr5VwbpRvLi4VOGZB5qNk6DZtqYTwVqsoyTd6iuqWvWtSCirugY4B21tf
 Jrcxit/MzANyk05TCQlKkjafFc/s2olLjHCXjBSS/1KMKANFaqXzxX/QPlfsy1rmA/7A
 YvbGZvE0oeDZhAgZjasl2QHBXq0dnaGQ1DfSNGd5SSzlnHMZw04tGtBkOPjlIksUAJ06
 FATb1APubXnOqWjsGvt3gqiPuZIL0G1Myq6Of+v7YWi8Kp7jZbBRLQcxXkW8nCxuRDp8
 in4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777137687; x=1777742487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XPWWihH6+qR8yVOIL+ONIesalJTy1218yyCJiBCdL6w=;
 b=knGyAT0V/uJVogitjrYbTMcAps2fJRQjFZOYWHpBWik3fEDJ2BvMpn1hb3PalvI834
 DgM4OPxbAH61IiL/n7vhmiHmH8G3yHX3rjdVWE9Je95n5yVUTD3ZN2pNCZw9H0QDi/ea
 E1OjkuoaSNtOcFMraEhn40MuOVxKH6jWN6KIh/vkYlL0JYpTD+HwZWaupr5vdnNGiCtT
 c6cYqOEbYuz/d3nWgkET+rNWn/024PYa3sVyBLfinKxmHuNcErqDMQlw3ryTe03yJeyG
 neU3BXSEHFT0cflqZK8vnz3dt9lUIccqKxagMICV29vKgGHMzDIr1GTq7l8rNEn91NRV
 1IFA==
X-Gm-Message-State: AOJu0YxE8KUqhMfNkX+VVxU3DxP3NjszlboXqZJxYTWhXVVLcPp+PYod
 xuDbKH0tl1WT/Bp4EcLFGb5g02jC3FUetPrZa8WDA8DG0k3sFIa+9VT7muXVl7gIhZEI/VgkInT
 CB9XeR1+o8yxk
X-Gm-Gg: AeBDieun1G7w98ou29OiqF8Cxaul+8k2W67BLYX7RdtzyS8HtA1UeJNYFtHKIF5H39e
 boqdnIIqKQjYmBw7O6Jr07dI+9a8hTBJK9uSbu17EWXXDqLiwM4JSrBgyC02yyk2raTxkXv5Imr
 uQ629JhAX3s7bUeaS1OtzEJJ8JKURhhEVd891KiU3J/8uTT7oS1IATGqn+FiEeLDQT3KjZHPnm+
 hqeffhM0VwVw0IZJCY3xulFXYQfX+yYp3tj+J4MBurstVLnzt0NUFYd8qgjamPrNAOubIKLoqYk
 YLnjcPoHCxUO+AWhHI5CQjKmOtevenOSfPkZY3ktd82FYnLkV7ndXl4mlpDTZsm7Xkll3fqkV9g
 0+Z78ElmJvIR5mtihmDWuPUYgw78SB8b0o1tgT4pNvJD06ttaPOrtQ0Gt41++4XOV3BcpdSI7ik
 +/O6QO/LHBZCFC3mV2Tvs94KxhQKBtTyeCgIYjc42ZQA==
X-Received: by 2002:a05:7301:4186:b0:2de:cc07:e99 with SMTP id
 5a478bee46e88-2e464dafc4cmr14124143eec.7.1776959193243; 
 Thu, 23 Apr 2026 08:46:33 -0700 (PDT)
Received: from desktop.. ([2804:7f0:6401:dc31:4200:1760:44a0:9daa])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa5c86sm33732055eec.1.2026.04.23.08.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 08:46:32 -0700 (PDT)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com,
 y.moog@phytec.de, xypron.glpk@gmx.de, sergio.prado@e-labworks.com,
 jerome.forissier@arm.com, afd@ti.com, quentin.schulz@cherry.de,
 Wojciech.Dubowik@mt.com
Subject: [PATCH v3 2/2] binman: x509_cert: add PKCS#11/HSM signing support
Date: Thu, 23 Apr 2026 12:45:36 -0300
Message-Id: <20260423154536.768603-3-sergio.prado@e-labworks.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423154536.768603-1-sergio.prado@e-labworks.com>
References: <20260423154536.768603-1-sergio.prado@e-labworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Allow X509 certificates used for TI K3 secure boot to be signed via an
HSM using the PKCS#11 standard, so that the private key never leaves
the hardware token.

Two new make variables are introduced:

  BINMAN_PKCS11_URI    PKCS#11 URI identifying the signing key, e.g.
                       pkcs11:token=mytoken;object=mykey;type=private
  BINMAN_PKCS11_MODULE Path to the PKCS#11 shared library (.so), e.g.
                       /usr/lib/softhsm/libsofthsm2.so

When BINMAN_PKCS11_URI is set, it is forwarded to binman as the
pkcs11-uri entry argument, overriding the keyfile property at signing
time. BINMAN_PKCS11_MODULE is optional and only needed when the PKCS#11
library is not already configured via openssl.cnf or the
PKCS11_MODULE_PATH environment variable.

The openssl bintool gains three helper methods:

  _pkcs11_use_provider() auto-detects whether the OpenSSL pkcs11
    provider (OpenSSL >= 3.1, pkcs11-provider) or the legacy pkcs11
    engine (libp11) is available, by inspecting 'openssl list
    -providers'.

  _build_key_args() builds the -key/-provider/-engine arguments for the
    openssl command line. When PKCS11_PIN is set in the environment,
    its value is appended as ?pin-value=<pin> to the URI so that
    non-interactive signing works with both the provider and engine
    paths.

  _run_cmd_pkcs11() sets PKCS11_MODULE_PATH and PKCS11_PROVIDER_MODULE
    before invoking openssl when a module path is given, and serialises
    concurrent signing calls with a module-level lock. The lock is
    required because binman's ThreadPoolExecutor may invoke multiple
    signing operations simultaneously, and HSMs (including SoftHSM2) do
    not support concurrent logins from different threads.

Existing behavior is unchanged when neither BINMAN_PKCS11_URI nor
BINMAN_PKCS11_MODULE is set.

Tested with SoftHSM2 and a YubiKey using the verdin-am62_a53_defconfig
configuration and both engine and provider OpenSSL APIs.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 Makefile                        |   2 +
 tools/binman/binman.rst         |  18 +++++
 tools/binman/btool/openssl.py   | 117 +++++++++++++++++++++++++++-----
 tools/binman/etype/x509_cert.py |  47 +++++++++++--
 tools/binman/ftest.py           | 110 ++++++++++++++++++++++++++++++
 5 files changed, 274 insertions(+), 20 deletions(-)

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
index 366491089ad9..e60eb7f572eb 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -2161,6 +2161,24 @@ BINMAN_INDIRS
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
index b26f087c4470..ec477a46a3d7 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -11,10 +11,16 @@ Source code is at https://www.openssl.org/
 """
 
 import hashlib
+import os
+import threading
 
 from binman import bintool
 from u_boot_pylib import tools
 
+# Serializes concurrent PKCS#11 signing operations. SoftHSM2 and many real
+# HSMs do not support simultaneous logins from multiple threads, so binman's
+# ThreadPoolExecutor would otherwise cause intermittent login failures.
+_pkcs11_lock = threading.Lock()
 
 VALID_SHAS = [256, 384, 512, 224]
 SHA_OIDS = {256:'2.16.840.1.101.3.4.2.1',
@@ -35,18 +41,89 @@ class Bintoolopenssl(bintool.Bintool):
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
+        If the PKCS11_PIN environment variable is set, appends pin-value=<pin>
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
+                sep = '&' if '?' in key_fname else '?'
+                key_fname = f'{key_fname}{sep}pin-value={pin}'
+            if self._pkcs11_use_provider():
+                args = ['-provider', 'default', '-provider', 'pkcs11', '-key', key_fname]
+            else:
+                args = ['-engine', 'pkcs11', '-keyform', 'engine', '-key', key_fname]
+        else:
+            args = ['-key', key_fname]
+        return args
+
+    def _run_cmd_pkcs11(self, pkcs11_module, *args):
+        """Run an openssl command, optionally passing PKCS#11 module env vars.
+
+        When pkcs11_module is set, PKCS11_MODULE_PATH (engine) and
+        PKCS11_PROVIDER_MODULE (provider) are passed as extra environment
+        variables.
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
+            extra_env = {
+                'PKCS11_MODULE_PATH': pkcs11_module,
+                'PKCS11_PROVIDER_MODULE': pkcs11_module,
+            }
+            with _pkcs11_lock:
+                return self.run_cmd(*args, extra_env=extra_env)
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
@@ -76,19 +153,20 @@ shaType                = OID:2.16.840.1.101.3.4.2.3
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
@@ -101,6 +179,8 @@ imageSize              = INTEGER:{len(indata)}
                 extended certificate
               - certificate (str): Extended firewall certificate with
                 the information for the firewall configurations.
+            pkcs11_module (str or None): Path to PKCS#11 shared library, or
+                None if already configured via openssl.cnf or the environment
 
         Returns:
             str: Tool output
@@ -146,20 +226,20 @@ authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
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
@@ -170,6 +250,8 @@ numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
             bootcore_opts(int): Booting core option, lockstep (0) or split (2) mode
             load_addr (int): Load address of image
             sha (int): Hash function
+            pkcs11_module (str or None): Path to PKCS#11 shared library, or
+                None if already configured via openssl.cnf or the environment
 
         Returns:
             str: Tool output
@@ -231,10 +313,10 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
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
@@ -242,13 +324,14 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
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
@@ -259,6 +342,8 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
             load_addr (int): Load address of image
             sha (int): Hash function
             bootcore_opts (int): Booting core option, lockstep (0) or split (2) mode
+            pkcs11_module (str or None): Path to PKCS#11 shared library, or
+                None if already configured via openssl.cnf or the environment
 
         Returns:
             str: Tool output
@@ -342,10 +427,10 @@ coreDbgSecEn = INTEGER:0
 
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
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index ca5149ee654a..a23719c767c8 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -6884,6 +6884,116 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing bintools.*: openssl")
 
+    def testOpenSslBuildKeyArgsPem(self):
+        """Test _build_key_args with a regular PEM key file"""
+        openssl = bintool.Bintool.create('openssl')
+        args = openssl._build_key_args('/path/to/key.pem')
+        self.assertEqual(['-key', '/path/to/key.pem'], args)
+
+    def testOpenSslBuildKeyArgsPkcs11Provider(self):
+        """Test _build_key_args with a PKCS#11 URI when provider API is available"""
+        uri = 'pkcs11:token=mytoken;object=mykey'
+        openssl = bintool.Bintool.create('openssl')
+        with unittest.mock.patch.object(openssl, 'run_cmd',
+                                        return_value='pkcs11 provider'):
+            args = openssl._build_key_args(uri)
+        self.assertEqual(['-provider', 'default', '-provider', 'pkcs11',
+                          '-key', uri], args)
+
+    def testOpenSslBuildKeyArgsPkcs11Engine(self):
+        """Test _build_key_args with a PKCS#11 URI when only engine API is available"""
+        uri = 'pkcs11:token=mytoken;object=mykey'
+        openssl = bintool.Bintool.create('openssl')
+        with unittest.mock.patch.object(openssl, 'run_cmd', return_value=''):
+            args = openssl._build_key_args(uri)
+        self.assertEqual(['-engine', 'pkcs11', '-keyform', 'engine',
+                          '-key', uri], args)
+
+    def testOpenSslBuildKeyArgsPkcs11Pin(self):
+        """Test _build_key_args appends pin-value to URI when PKCS11_PIN is set"""
+        uri = 'pkcs11:token=mytoken;object=mykey'
+        openssl = bintool.Bintool.create('openssl')
+        with unittest.mock.patch.dict('os.environ', {'PKCS11_PIN': '1234'}):
+            with unittest.mock.patch.object(openssl, 'run_cmd',
+                                            return_value='pkcs11'):
+                args = openssl._build_key_args(uri)
+        self.assertIn(f'{uri}?pin-value=1234', args)
+
+    def testOpenSslBuildKeyArgsPkcs11PinExistingQuery(self):
+        """Test _build_key_args uses '&' separator when URI already has query params"""
+        uri = 'pkcs11:token=mytoken;object=mykey?module-path=/path/to/lib'
+        openssl = bintool.Bintool.create('openssl')
+        with unittest.mock.patch.dict('os.environ', {'PKCS11_PIN': '1234'}):
+            with unittest.mock.patch.object(openssl, 'run_cmd',
+                                            return_value='pkcs11'):
+                args = openssl._build_key_args(uri)
+        self.assertIn(f'{uri}&pin-value=1234', args)
+
+    def testOpenSslPkcs11UseProviderCached(self):
+        """Test that _pkcs11_use_provider caches its result after the first call"""
+        openssl = bintool.Bintool.create('openssl')
+        with unittest.mock.patch.object(openssl, 'run_cmd',
+                                        return_value='pkcs11') as mock_cmd:
+            result1 = openssl._pkcs11_use_provider()
+            result2 = openssl._pkcs11_use_provider()
+        self.assertTrue(result1)
+        self.assertTrue(result2)
+        mock_cmd.assert_called_once_with('list', '-providers')
+
+    def testOpenSslRunCmdPkcs11NoModule(self):
+        """Test _run_cmd_pkcs11 without a module just forwards to run_cmd"""
+        openssl = bintool.Bintool.create('openssl')
+        with unittest.mock.patch.object(openssl, 'run_cmd',
+                                        return_value='output') as mock_cmd:
+            result = openssl._run_cmd_pkcs11(None, 'version')
+        mock_cmd.assert_called_once_with('version')
+        self.assertEqual('output', result)
+
+    def testOpenSslRunCmdPkcs11WithModule(self):
+        """Test _run_cmd_pkcs11 passes module paths to run_cmd via extra_env"""
+        module = '/usr/lib/pkcs11/libsofthsm2.so'
+        openssl = bintool.Bintool.create('openssl')
+        with unittest.mock.patch.object(openssl, 'run_cmd',
+                                        return_value='output') as mock_cmd:
+            openssl._run_cmd_pkcs11(module, 'version')
+        mock_cmd.assert_called_once_with('version', extra_env={
+            'PKCS11_MODULE_PATH': module,
+            'PKCS11_PROVIDER_MODULE': module,
+        })
+
+    def testX509CertPkcs11(self):
+        """Test X509 certificate creation using a PKCS#11 URI instead of a key file"""
+        PKCS11_URI = 'pkcs11:token=test;object=mykey;type=private'
+        PKCS11_MODULE = '/usr/lib/pkcs11/libsofthsm2.so'
+        original = bintool.Bintool.run_cmd
+        signing_args = []
+
+        def fake_openssl(self_tool, *args, binary=False, extra_env=None):
+            if self_tool.name != 'openssl':
+                return original(self_tool, *args, binary=binary)
+            arg_list = list(args)
+            if arg_list == ['list', '-providers']:
+                return 'pkcs11 provider'
+            if '-out' in arg_list:
+                signing_args.extend(arg_list)
+                tools.write_file(arg_list[arg_list.index('-out') + 1],
+                                 b'\x00' * 32)
+            return ''
+
+        entry_args = {
+            'keyfile': self.TestFile('security/key.key'),
+            'pkcs11-uri': PKCS11_URI,
+            'pkcs11-module': PKCS11_MODULE,
+        }
+        with unittest.mock.patch.object(bintool.Bintool, 'run_cmd',
+                                        new=fake_openssl):
+            data = self._DoReadFileDtb('security/x509_cert.dts',
+                                       entry_args=entry_args)[0]
+        self.assertGreater(len(data), len(U_BOOT_DATA))
+        self.assertEqual(U_BOOT_DATA, data[-4:])
+        self.assertIn('-provider pkcs11', ' '.join(signing_args))
+        self.assertIn(PKCS11_URI, signing_args)
+
     def testPackRockchipTpl(self):
         """Test that an image with a Rockchip TPL binary can be created"""
         data = self._DoReadFile('vendor/rockchip_tpl.dts')
-- 
2.34.1

