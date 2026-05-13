Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E69FCD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 17:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ACC784659;
	Wed, 13 May 2026 19:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="Z3xsCsGB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01D018469A; Wed, 13 May 2026 19:57:38 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 047C283FB0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 19:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2c15849aa2cso9501243eec.0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1778695053; x=1779299853;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CvSBSfduiPdgqOkx10aV4vxiKMqYIYdkmlJ/gUsCfj4=;
 b=Z3xsCsGBvK1ru0AiaYAfVS49Uq7SqiEAbeY5EyckNKXn+rC/jfZbTUQ6djhNxLDGno
 FtJ29Abf8t+1A2yeLftmd28SNQsPjc5PQoLUMsgJOQUVqBaVNMY2kVvB4jhJjzRMfKkP
 thefjtErSsw8RIuo8Pm/l9wXeXN8IAQyvdod847tU3ajXwbRMBwcbEmstbwRQy0NkLIH
 ge2dlknAuE7ClKXYn2xIWtR0uaqVqzBmxLr7+UJPpPAK5+kYNt1HxfBdklwz0ar9YzZP
 Z+7FXu5G0QtNk3JqUSoXOOVJlElUKnBVCIiXEStYB4SJ0Nc/PTwudTYdzlkdzQcZoMzm
 e2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778695053; x=1779299853;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvSBSfduiPdgqOkx10aV4vxiKMqYIYdkmlJ/gUsCfj4=;
 b=pKsQ9aKvd8LL9ylCMN2tiZCbNe7+xeXY3cNV5z2jCLuGghQ5ld4zmPDf9rTgk7kgmW
 f0/gNQ/eAmDozKv2lR3pIfqGZ7d39idg4N43BXq9O3yCnfZ+QOhP/iXPR8i6Gp7ESCBS
 jIR4okG8OravMuMusesvkwAkQYZAWrJzHJHlDUYuzoaGxr5XZ9Xcp+SZJ0mg/eI+hmXd
 pSc13RNMV6jNmoiyxJVD6n5yztjTJuZ6J0iw+zq4zQaqwlawttOU6NbKBUhYONOL7R2J
 vKWYbNrRJQAAwWm4PSg5Ynb2dQOZroKUn3SZKQR1Ni7YJ3t4QYUzMNem/yErD2tVgcVd
 XcTA==
X-Gm-Message-State: AOJu0YywDJNL5/88h4NH5JPHrtkQef0UJ0Iw5Z7tQVobAVkTopEI2cxm
 AhwiT9A3PZ7lTsdH++KdAzrNznp2PlFrFTADR5EjXSY/YMlIPBl3xA4dKQsCQpZRf5n77UEn3sB
 pqaP3HVJNO+gq
X-Gm-Gg: Acq92OHtOAPlU6eh/9GwyhWYycCkpXWx0UA3CRVKZViPWcVeyQ1Mo23FUN72TRTAyE/
 W81udK9XfEsttzXgdGmO1+bHMKvjWJGaw2njGi0cMkXA2E26KJsmHKbieIoXHHpO+caeKULIKwK
 oNfi8NKbGY4uPyLBN+bHQx5OSlXVShP3NhTZAgRaNBt2dhToF3ZkaKYGd4+c0G7osz6Va+V++qy
 cwgMAdM6q+avOT0T+knwlKULF/884aXdIep2txLR523Eoybs1RvXzjziagU+FxEWY17aOPuDbpV
 vr6qUy4zxjQ89ez9mg/2DpftDVAoyFPnV0PLRDnv9eq/Cgw0IScBVOllDfeDFXvsuKaKmlMUJQx
 hwKJUrtiv1LroA8Xpv14+FA4A1TgfeCCExP1qbarsEMF7l9B+zyACdJcQeKnHSwVwZab/sr7EZp
 aZoXoLXN13D753TtLwlRDjuN3j1BYB+i4=
X-Received: by 2002:a05:7301:5781:b0:2dd:144b:6c2 with SMTP id
 5a478bee46e88-30119299926mr2529885eec.27.1778695053128; 
 Wed, 13 May 2026 10:57:33 -0700 (PDT)
Received: from desktop.. ([177.92.163.125]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8859eb4b7sm23830642eec.2.2026.05.13.10.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:57:32 -0700 (PDT)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com,
 xypron.glpk@gmx.de, y.moog@phytec.de, afd@ti.com, quentin.schulz@cherry.de,
 Wojciech.Dubowik@mt.com, Sergio Prado <sergio.prado@e-labworks.com>
Subject: [PATCH v4] binman: x509_cert: add PKCS#11/HSM signing support
Date: Wed, 13 May 2026 14:56:34 -0300
Message-ID: <20260513175640.1830541-1-sergio.prado@e-labworks.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

A new make variable BINMAN_X509_KEY_URI is introduced. When set, it is
forwarded to binman as the x509-key-uri entry argument, overriding the
keyfile property at signing time:

  make BINMAN_X509_KEY_URI="pkcs11:token=mytk;object=mykey;type=private" \
       OPENSSL_CONF=/path/to/openssl.cnf

The OpenSSL pkcs11 provider or engine and the PKCS#11 module must be
configured externally via openssl.cnf. Two URI forms are supported on
OpenSSL 3.x:

 - Provider path: pkcs11:token=...;object=...;type=private
 - Engine path:   org.openssl.engine:pkcs11:pkcs11:token=...;...

In both cases the user is responsible for configuring OpenSSL externally,
as binman simply passes the URI to the openssl '-key' option. This keeps
binman free of any PKCS#11-specific knowledge.

To run signing non-interactively, the PKCS11_PIN environment variable
can be set; its value is appended to the URI as ?pin-value=<pin> (or
&pin-value=<pin> when the URI already contains '?'), so the PIN does
not have to be embedded in BINMAN_X509_KEY_URI.

Existing behavior is unchanged when BINMAN_X509_KEY_URI is not set.

Tested with SoftHSM2 and Yubikey on OpenSSL 3.x using the
verdin-am62_a53_defconfig configuration.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---

Changes in v4:
- Drop the v3 bintool extra_env commit entirely; binman no longer
  sets any PKCS#11-related environment variables (Quentin)
- Drop BINMAN_PKCS11_MODULE / pkcs11-module entry argument; the
  PKCS#11 module path must be configured externally via openssl.cnf
  (Quentin)
- Drop provider/engine auto-detection (_pkcs11_use_provider,
  _build_key_args, _run_cmd_pkcs11) along with the threading.Lock;
  the user selects provider or engine via OPENSSL_CONF and the URI
  form (Quentin)
- Rename the v3 BINMAN_PKCS11_URI / pkcs11-uri to BINMAN_X509_KEY_URI
  / x509-key-uri to scope the names to x509 certificate entries
  without locking them to a specific URI scheme (Quentin)
- Document that the engine path is supported on OpenSSL 3.x by
  prefixing the URI with org.openssl.engine:<engine_name>: (Quentin)
- Replace the mocked openssl test with a real SoftHSM2-based
  integration test using the provider path and OPENSSL_CONF (Quentin)
- Use 'p11-kit print-config' to locate the softhsm2 library at test
  time instead of hardcoding a distro-specific path (Quentin)
- Use 'openssl version -m' (MODULESDIR) to locate the OpenSSL pkcs11
  provider .so file, so multiarch paths like
  /usr/lib/x86_64-linux-gnu/ossl-modules on Debian/Ubuntu are handled
  correctly
- Generate the test RSA keypair with pkcs11-tool; softhsm2-util has
  no key-generation action (only --import) and silently exits 0 on an
  unknown --generate-keypair option, which would leave the token
  empty and make the openssl step fail with 'Could not read private
  key'
- Add self._CheckBintool() to all PKCS#11 test paths so tests skip
  cleanly when bintools are missing (Quentin)
- Extract the URI/PIN combiner into Entry_x509_cert._build_pkcs11_key()
  and add a unit test for it
- Document that PKCS11_PIN keeps the PIN out of the make command line
  but is still visible in 'ps' output via the openssl invocation; for
  improved isolation, configure the PIN in openssl.cnf
- Document all Entry_x509_cert properties (content, keyfile,
  x509-key-uri, cert-ca, cert-revision-int, sw-rev) in its docstring
  (Quentin)
- Add inheritance notes to Entry_ti_secure and Entry_ti_secure_rom
  docstrings, pointing out that they extend Entry_x509_cert via
  super() and therefore accept its properties (notably x509-key-uri)
  (Quentin)

Changes in v3:
- Split into two patches: bintool infrastructure (1/2) and x509_cert
  feature (2/2)
- Fix global environment mutation: _run_cmd_pkcs11() no longer writes
  to os.environ directly; it now uses the new extra_env parameter so
  module paths are scoped to the subprocess only, which is both
  cleaner and safe under concurrent execution
- Add module-level threading.Lock to serialise concurrent PKCS#11
  signing calls and fix intermittent login failures caused by binman's
  ThreadPoolExecutor
- Fix URI query string separator: use '&' when the URI already
  contains '?' (e.g. module-path already present), '?' otherwise
- Test cases updated

Changes in v2:
- Add tests for _build_key_args() (PEM path, PKCS#11 provider, PKCS#11
  engine, PIN appending), _pkcs11_use_provider() (caching),
  _run_cmd_pkcs11() (with and without module path), and end-to-end
  x509_cert signing with a PKCS#11 URI (testX509CertPkcs11), ensuring
  btool/openssl.py and etype/x509_cert.py have 100% test coverage
---
 Makefile                            |   1 +
 tools/binman/binman.rst             |  50 ++++++++++++
 tools/binman/etype/ti_secure.py     |   5 ++
 tools/binman/etype/ti_secure_rom.py |   5 ++
 tools/binman/etype/x509_cert.py     |  52 ++++++++++--
 tools/binman/ftest.py               | 118 ++++++++++++++++++++++++++++
 6 files changed, 226 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 552328f9f2c2..ac9b05668635 100644
--- a/Makefile
+++ b/Makefile
@@ -1701,6 +1701,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		-a vpl-dtb=$(CONFIG_VPL_OF_REAL) \
 		-a pre-load-key-path=${PRE_LOAD_KEY_PATH} \
 		-a of-spl-remove-props=$(CONFIG_OF_SPL_REMOVE_PROPS) \
+		$(if $(BINMAN_X509_KEY_URI),-a x509-key-uri="$(BINMAN_X509_KEY_URI)") \
 		$(BINMAN_$(@F))
 
 OBJCOPYFLAGS_u-boot.ldr.hex := -I binary -O ihex
diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 366491089ad9..b12dfe50679c 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -2161,6 +2161,56 @@ BINMAN_INDIRS
     Sets the search path for input files used by binman by adding one or more
     `-I` arguments. See :ref:`External blobs`.
 
+BINMAN_X509_KEY_URI
+    URI of a key used to sign x509 certificate entries via an HSM instead of a
+    PEM key file on disk. When set, it is passed as ``-a x509-key-uri=<uri>``
+    to binman, which overrides the ``keyfile`` entry argument for all x509
+    certificate signing operations.
+
+    This only applies to x509 certificate entries (e.g. TI K3 secure boot). It
+    does not affect FIT image signing, which uses device tree properties such as
+    ``fit,engine`` and ``key-name-hint`` instead.
+
+    The URI is currently a PKCS#11 URI (RFC 7512). PKCS#11 signing requires
+    OpenSSL 3.x. The provider or engine and the PKCS#11 module must be
+    configured externally via an ``openssl.cnf`` file. Either rely on the
+    system default (``/etc/ssl/openssl.cnf``) or point to a custom file via
+    ``OPENSSL_CONF``.
+
+    Two URI forms are supported on OpenSSL 3.x:
+
+    1. Provider path (recommended) — requires the pkcs11 provider, e.g.
+       ``pkcs11-provider``::
+
+           make BINMAN_X509_KEY_URI="pkcs11:token=mytoken;object=mykey;type=private" \
+                OPENSSL_CONF=/path/to/openssl.cnf
+
+    2. Engine path — for setups where only an OpenSSL engine is available
+       (e.g. ``libengine-pkcs11-openssl``). Prefix the URI with
+       ``org.openssl.engine:<engine_name>:`` so OpenSSL 3.x's STORE API
+       routes it to the engine without requiring ``-engine``/``-keyform``
+       flags on the command line::
+
+           make BINMAN_X509_KEY_URI="org.openssl.engine:pkcs11:pkcs11:token=mytoken;object=mykey;type=private" \
+                OPENSSL_CONF=/path/to/openssl.cnf
+
+    OpenSSL 1.x engine usage is not supported transparently; users on
+    OpenSSL 1.x need to provide the engine flags through other means.
+
+    To run signing non-interactively, set the ``PKCS11_PIN`` environment
+    variable. Its value is appended to the URI as ``?pin-value=<pin>`` so the
+    PIN does not have to be embedded in ``BINMAN_X509_KEY_URI``::
+
+        PKCS11_PIN=1234 make BINMAN_X509_KEY_URI="pkcs11:..." \
+                             OPENSSL_CONF=/path/to/openssl.cnf
+
+    Note: ``PKCS11_PIN`` keeps the PIN out of the ``make`` command line and
+    shell history, but the PIN is still passed to ``openssl`` as part of the
+    URI on its command line, where it is visible via ``ps`` and may appear in
+    verbose build logs. For stronger isolation, configure the PIN inside
+    ``openssl.cnf`` under the pkcs11 provider section
+    (``pkcs11-module-token-pin``).
+
 BINMAN_TOOLPATHS
     Sets the search path for external tool used by binman by adding one or more
     `--toolpath` arguments. See :ref:`External tools`.
diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secure.py
index f6caa0286d97..433445207ef5 100644
--- a/tools/binman/etype/ti_secure.py
+++ b/tools/binman/etype/ti_secure.py
@@ -48,6 +48,11 @@ endAddress{unique_identifier} = FORMAT:HEX,OCT:{self.end_address:02x}
 class Entry_ti_secure(Entry_x509_cert):
     """Entry containing a TI x509 certificate binary
 
+    This entry extends :class:`Entry_x509_cert` and chains through to its
+    ``ReadNode`` and ``GetCertificate`` via ``super()``. All properties of
+    ``Entry_x509_cert`` (notably ``x509-key-uri`` for HSM-based signing) are
+    therefore accepted in addition to those listed below.
+
     Properties / Entry arguments:
         - content: List of phandles to entries to sign
         - keyfile: Filename of file containing key to sign binary with
diff --git a/tools/binman/etype/ti_secure_rom.py b/tools/binman/etype/ti_secure_rom.py
index 7e90c6559409..7676f1234433 100644
--- a/tools/binman/etype/ti_secure_rom.py
+++ b/tools/binman/etype/ti_secure_rom.py
@@ -22,6 +22,11 @@ SHA_OIDS = {256:'2.16.840.1.101.3.4.2.1',
 class Entry_ti_secure_rom(Entry_x509_cert):
     """Entry containing a TI x509 certificate binary for images booted by ROM
 
+    This entry extends :class:`Entry_x509_cert` and chains through to its
+    ``ReadNode`` and ``GetCertificate`` via ``super()``. All properties of
+    ``Entry_x509_cert`` (notably ``x509-key-uri`` for HSM-based signing) are
+    therefore accepted in addition to those listed below.
+
     Properties / Entry arguments:
         - keyfile: Filename of file containing key to sign binary with
         - combined: boolean if device follows combined boot flow
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index b6e8b0b4fb09..9bfb0aceddaf 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -18,7 +18,25 @@ class Entry_x509_cert(Entry_collection):
     """An entry which contains an X509 certificate
 
     Properties / Entry arguments:
-        - content: List of phandles to entries to sign
+        - content: List of phandles to entries to sign.
+        - keyfile: Filename of the PEM key file used to sign the binary.
+        - x509-key-uri: URI of a key to use for signing instead of the PEM
+            ``keyfile``. Currently a PKCS#11 URI (RFC 7512), e.g.
+            ``pkcs11:token=mytoken;object=mykey;type=private``, allowing the
+            signing key to live in an HSM. When set via
+            ``-a x509-key-uri=...`` (or the ``BINMAN_X509_KEY_URI`` make
+            variable) it overrides ``keyfile`` for the signing operation.
+            Requires OpenSSL 3.x with the pkcs11 provider configured via
+            ``OPENSSL_CONF``. If the ``PKCS11_PIN`` environment variable is
+            set, its value is appended to the URI as ``?pin-value=<pin>`` so
+            that signing runs non-interactively.
+        - cert-ca: Common Name (CN) embedded in the certificate. Used when
+            generating a generic x509 certificate.
+        - cert-revision-int: Integer certificate revision number. Used when
+            generating a generic x509 certificate. Defaults to 0.
+        - sw-rev: Software revision number embedded in the certificate by
+            the sysfw/rom variants used by the TI K3 secure boot subclasses.
+            Defaults to 1.
 
     Output files:
         - input.<unique_name> - input file passed to openssl
@@ -53,6 +71,7 @@ class Entry_x509_cert(Entry_collection):
         self.dm_data_ext_boot_block = None
         self.firewall_cert_data = None
         self.debug = False
+        self.key_uri = None
 
     def ReadNode(self):
         super().ReadNode()
@@ -61,6 +80,8 @@ class Entry_x509_cert(Entry_collection):
         self.key_fname = self.GetEntryArgsOrProps([
             EntryArg('keyfile', str)], required=True)[0]
         self.sw_rev = fdt_util.GetInt(self._node, 'sw-rev', 1)
+        self.key_uri = self.GetEntryArgsOrProps([
+            EntryArg('x509-key-uri', str)], required=False)[0]
 
     def GetCertificate(self, required, type='generic'):
         """Get the contents of this entry
@@ -80,6 +101,15 @@ class Entry_x509_cert(Entry_collection):
         if input_data is None:
             return None
 
+        # Set keyfile (override with the PKCS#11 URI if provided). This
+        # must live in GetCertificate() rather than ReadNode() because
+        # subclasses (ti_secure, ti_secure_rom) overwrite self.key_fname
+        # in their own ReadNode() after calling super().ReadNode().
+        key_fname = self.key_fname
+        if self.key_uri:
+            key_fname = self._build_pkcs11_key(self.key_uri,
+                                               os.environ.get('PKCS11_PIN'))
+
         uniq = self.GetUniqueName()
         output_fname = tools.get_output_filename('cert.%s' % uniq)
         input_fname = tools.get_output_filename('input.%s' % uniq)
@@ -90,7 +120,7 @@ class Entry_x509_cert(Entry_collection):
             stdout = self.openssl.x509_cert(
                 cert_fname=output_fname,
                 input_fname=input_fname,
-                key_fname=self.key_fname,
+                key_fname=key_fname,
                 cn=self._cert_ca,
                 revision=self._cert_rev,
                 config_fname=config_fname)
@@ -98,7 +128,7 @@ class Entry_x509_cert(Entry_collection):
             stdout = self.openssl.x509_cert_sysfw(
                 cert_fname=output_fname,
                 input_fname=input_fname,
-                key_fname=self.key_fname,
+                key_fname=key_fname,
                 config_fname=config_fname,
                 sw_rev=self.sw_rev,
                 req_dist_name_dict=self.req_dist_name,
@@ -107,7 +137,7 @@ class Entry_x509_cert(Entry_collection):
             stdout = self.openssl.x509_cert_rom(
                 cert_fname=output_fname,
                 input_fname=input_fname,
-                key_fname=self.key_fname,
+                key_fname=key_fname,
                 config_fname=config_fname,
                 sw_rev=self.sw_rev,
                 req_dist_name_dict=self.req_dist_name,
@@ -122,7 +152,7 @@ class Entry_x509_cert(Entry_collection):
             stdout = self.openssl.x509_cert_rom_combined(
                 cert_fname=output_fname,
                 input_fname=input_fname,
-                key_fname=self.key_fname,
+                key_fname=key_fname,
                 config_fname=config_fname,
                 sw_rev=self.sw_rev,
                 req_dist_name_dict=self.req_dist_name,
@@ -168,3 +198,15 @@ class Entry_x509_cert(Entry_collection):
     def AddBintools(self, btools):
         super().AddBintools(btools)
         self.openssl = self.AddBintool(btools, 'openssl')
+
+    @staticmethod
+    def _build_pkcs11_key(uri, pin):
+        """Append pin-value to a PKCS#11 URI when a PIN is provided.
+
+        Uses '&' as separator if the URI already contains '?', else '?'.
+        Returns the URI unchanged when pin is None or empty.
+        """
+        if not pin:
+            return uri
+        sep = '&' if '?' in uri else '?'
+        return f'{uri}{sep}pin-value={pin}'
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 9a3811c17322..98431ed17d98 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -35,6 +35,7 @@ from dtoc import fdt
 from dtoc import fdt_util
 from binman.etype import fdtmap
 from binman.etype import image_header
+from binman.etype.x509_cert import Entry_x509_cert
 from binman.image import Image
 from u_boot_pylib import command
 from u_boot_pylib import terminal
@@ -6905,6 +6906,123 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing bintools.*: openssl")
 
+    def testX509CertPkcs11(self):
+        """Test X509 certificate creation via PKCS#11 HSM using OpenSSL provider"""
+        openssl = bintool.Bintool.create('openssl')
+        self._CheckBintool(openssl)
+
+        softhsm2_util = bintool.Bintool.create('softhsm2_util')
+        self._CheckBintool(softhsm2_util)
+
+        pkcs11_tool = bintool.Bintool.create('pkcs11-tool')
+        self._CheckBintool(pkcs11_tool)
+
+        p11_kit = bintool.Bintool.create('p11-kit')
+        self._CheckBintool(p11_kit)
+
+        # Find the softhsm2 library path via p11-kit
+        p11_kit_config = configparser.ConfigParser()
+        p11_kit_config.read_string(tools.run('p11-kit', 'print-config'))
+        softhsm2_lib = p11_kit_config.get('softhsm2', 'module', fallback=None)
+        if softhsm2_lib is None:
+            self.skipTest('softhsm2 module not found in p11-kit config')
+
+        # Find the OpenSSL pkcs11 provider module via the modules dir
+        # reported by 'openssl version -m'. This handles multiarch paths
+        # like /usr/lib/x86_64-linux-gnu/ossl-modules on Debian/Ubuntu,
+        # which OPENSSLDIR does not point at.
+        m = re.search(r'MODULESDIR: "([^"]+)"',
+                      tools.run('openssl', 'version', '-m'))
+        pkcs11_provider = None
+        if m:
+            candidate = os.path.join(m.group(1), 'pkcs11.so')
+            if os.path.exists(candidate):
+                pkcs11_provider = candidate
+        if pkcs11_provider is None:
+            self.skipTest('OpenSSL pkcs11 provider module not found')
+
+        prefix = 'testX509CertPkcs11.'
+
+        # Set up SoftHSM2 token and key
+        softhsm2_conf_data = tools.read_file(self.TestFile('fit/softhsm2.conf'))
+        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf',
+                                            softhsm2_conf_data)
+        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
+        with open(softhsm2_conf, 'a') as f:
+            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
+
+        # Write an openssl.cnf that loads the pkcs11 provider
+        openssl_cnf = self._MakeInputFile(f'{prefix}openssl.cnf', b'')
+        with open(openssl_cnf, 'w') as f:
+            f.write(f'''openssl_conf = openssl_init
+
+[openssl_init]
+providers = provider_sect
+
+[provider_sect]
+default = default_sect
+pkcs11 = pkcs11_sect
+
+[default_sect]
+activate = 1
+
+[pkcs11_sect]
+module = {pkcs11_provider}
+pkcs11-module-path = {softhsm2_lib}
+activate = 1
+''')
+
+        pin = '1234'
+        uri = 'pkcs11:token=x509-test;object=testkey;type=private'
+
+        with unittest.mock.patch.dict('os.environ',
+                                      {'SOFTHSM2_CONF': softhsm2_conf}):
+            tools.run('softhsm2-util', '--init-token', '--free',
+                      '--label', 'x509-test',
+                      '--pin', pin, '--so-pin', '000000')
+            # softhsm2-util cannot generate keys (only --import), so use
+            # pkcs11-tool to generate the RSA keypair directly in the token.
+            tools.run('pkcs11-tool', '--module', softhsm2_lib,
+                      '--token-label', 'x509-test', '--login', '--pin', pin,
+                      '--keypairgen', '--key-type', 'rsa:2048',
+                      '--label', 'testkey', '--id', '01')
+
+        entry_args = {
+            'keyfile': self.TestFile('security/key.key'),
+            'x509-key-uri': uri,
+        }
+        with unittest.mock.patch.dict('os.environ',
+                                      {'SOFTHSM2_CONF': softhsm2_conf,
+                                       'OPENSSL_CONF': openssl_cnf,
+                                       'PKCS11_PIN': pin}):
+            data = self._DoReadFileDtb('security/x509_cert.dts',
+                                       entry_args=entry_args)[0]
+
+        self.assertGreater(len(data), len(U_BOOT_DATA))
+        self.assertEqual(U_BOOT_DATA, data[-4:])
+
+        # Verify the produced bytes are a valid DER-encoded x509 certificate
+        cert_fname = tools.get_output_filename(f'{prefix}cert.der')
+        tools.write_file(cert_fname, data[:-len(U_BOOT_DATA)])
+        openssl.run_cmd('x509', '-in', cert_fname, '-inform', 'DER', '-noout')
+
+    def testX509CertPkcs11BuildKey(self):
+        """Test the PKCS#11 URI/PIN combiner used by x509_cert"""
+        uri = 'pkcs11:token=t;object=k;type=private'
+
+        # No PIN: URI returned unchanged
+        self.assertEqual(uri, Entry_x509_cert._build_pkcs11_key(uri, None))
+        self.assertEqual(uri, Entry_x509_cert._build_pkcs11_key(uri, ''))
+
+        # PIN appended with '?' when URI has no query
+        self.assertEqual(f'{uri}?pin-value=1234',
+                         Entry_x509_cert._build_pkcs11_key(uri, '1234'))
+
+        # PIN appended with '&' when URI already has '?'
+        uri_q = f'{uri}?module-name=softhsm2'
+        self.assertEqual(f'{uri_q}&pin-value=1234',
+                         Entry_x509_cert._build_pkcs11_key(uri_q, '1234'))
+
     def testPackRockchipTpl(self):
         """Test that an image with a Rockchip TPL binary can be created"""
         data = self._DoReadFile('vendor/rockchip_tpl.dts')
-- 
2.43.0

