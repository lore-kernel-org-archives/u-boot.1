Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6145CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 13:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A228846F1;
	Mon, 25 May 2026 15:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="e/rj9xgS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53B2184702; Mon, 25 May 2026 15:29:19 +0200 (CEST)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6563A8460E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-575212eb419so7179498e0c.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 06:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1779715755; x=1780320555;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cT32FZ1u/zGRGpqGkYVyYu9QcjnIXyPk4Iwe1i1E7gs=;
 b=e/rj9xgSfFBznnDmBSgBPJKbuolcUTgTX+Xq2R/dtOFvHY909PPJUzZ0e1QxOqFDPt
 CbwGxQEXHCQ49idxiM3y4n2fhYji7Ccjbdbd1wZZKT87uuDeu2kdaFN8bkVEGd41e2fD
 3AcT4uyOw08HYGO9WSjoM8oygOBRyI+tlIsjgnn4RCtjWCxfFMjBKPeYPMc9MRM3V8sP
 1OY25yQ2TMLgNNjNEWZSpvq27Xcx2WlAcHuR5Qbcqzs7QlRVHFGm+a1i957cxVIBo3B+
 wswcoCtMCijrNBucKKVsyZ33Ssw89XwPW2slkUVDIZYDtjHxMS0aB/gdj2drefaxcyUc
 5v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779715755; x=1780320555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cT32FZ1u/zGRGpqGkYVyYu9QcjnIXyPk4Iwe1i1E7gs=;
 b=kISNGpIk+FNbphOP1A+/xiofieWPcNiXidMF0DkmhBHV2T7GCms9qysC053k48Mwpf
 ZEmDjK0x+7eFnlejE6+/11ZkQzIK0+RPU30M1uTAeyU8WXuKsw2YZYdqC00WxSRmQSuu
 xuZmLiqqs3xkq1vsd8BFDwFEHx6D7XQFDzhht9oeFCohUeAH8T30CBpINHUHWJK1X2DS
 ZbUzFrruJ4KSdjsif8A3BYVFhbW5z670FxQ0QashXDR6s1JMvRLOGoTXStjn/U/juxqQ
 1245Ld+zAQgP5Ehy74VrZZESD+sZan8gNCk9mx9S3zhteEOo+nKkCPvumSpkbYzxpjPl
 J8JA==
X-Gm-Message-State: AOJu0Yz3L6prKvsvvvk7PLbO8DsIQITEKd0oIC8uAfHo+vKHG/NRtiLE
 WrA6VTQJi9W3nGnqhSdDucjsKjrE0tHaS5WqypJRBUuvOlW3v1U4XpdAFUFZEtUHHcf28szvzZM
 6JyV0
X-Gm-Gg: Acq92OE1YwCCXgFisHfqXbk1w1agUH3tK3HxV1L72uGedADcijmo/xpJOtdEfiaRu0H
 nzxgbmvEXZ14btRIqIlfCzzV0C0VhFetgO70BmTt6Iu1Gmw7SXFEpNnmIwFKa1IPEkYFSsyIHVf
 wCiWsSeTLYZpgL+CLmnJKuUGjTO3NZI5pFceT0ipFfl2v1J55FTt/sBXbKR5Z6wd0lW8ufm/1HO
 9Tb6MydcwsO1OCC+6ML2dQM+l3m/Vu7pvDrUQQ1jtFHEA2pD2nJv3HhGu+RFHhgHMrZUAS1SCck
 lD2b+++FTPHq+/O3xDOOPnAi5FW1OlqsMw8qjmeUb79O0pE35pmCSpN4rlkG6HNpn9t3EAj7FAW
 LQTeZOo2Lk4kC7Em/eX3IyDMtLt9NbAvBbx2XWSJ+JqmC5/tIDNn1VLF/p3qZ0AG3K144tQ/cCC
 DmjnMSSaUuoj3l31tn5AKV41DRKjC1/YnmDTATC2ibAw==
X-Received: by 2002:a05:6122:54b:b0:56b:8ba0:fd58 with SMTP id
 71dfb90a1353d-5868efd797cmr2513080e0c.6.1779715755047; 
 Mon, 25 May 2026 06:29:15 -0700 (PDT)
Received: from desktop.. ([2804:7f0:6400:4198:c5e1:5c3b:8861:210f])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-586f791f097sm11647484e0c.9.2026.05.25.06.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 06:29:14 -0700 (PDT)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com,
 xypron.glpk@gmx.de, y.moog@phytec.de, afd@ti.com, quentin.schulz@cherry.de,
 Wojciech.Dubowik@mt.com, Sergio Prado <sergio.prado@e-labworks.com>
Subject: [PATCH v5 2/2] binman: x509_cert: support PKCS#11 URI in keyfile for
 HSM signing
Date: Mon, 25 May 2026 10:28:28 -0300
Message-Id: <20260525132828.3348679-3-sergio.prado@e-labworks.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525132828.3348679-1-sergio.prado@e-labworks.com>
References: <20260525132828.3348679-1-sergio.prado@e-labworks.com>
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

Allow x509 certificate entries to be signed using a key stored in an
HSM by accepting a PKCS#11 URI (RFC 7512) as the value of the
'keyfile' entry argument, instead of a path to a PEM key file on
disk. The URI is forwarded as-is to openssl '-key', which resolves it
via the pkcs11 provider configured externally through OPENSSL_CONF.

A new make variable BINMAN_X509_KEY_URI is introduced. When set, it
overrides the 'keyfile' entry argument for all x509 certificate
signing operations:

    make BINMAN_X509_KEY_URI="pkcs11:token=mytk;object=mykey;type=private" \
         OPENSSL_CONF=/path/to/openssl.cnf

Two URI forms are supported on OpenSSL 3.x:

 - Provider path: pkcs11:token=...;object=...;type=private
 - Engine path:   org.openssl.engine:pkcs11:pkcs11:token=...;...

In both cases the user is responsible for configuring OpenSSL
externally, as binman simply passes the URI to 'openssl -key'.

The recommended way to deliver the PIN for non-interactive signing is
to configure pkcs11-module-token-pin in openssl.cnf under the pkcs11
provider section. As a convenience fallback, the PKCS11_PIN
environment variable can be set; its value is appended to the URI as
?pin-value=<pin> (or &pin-value=<pin> if the URI already contains a
'?'), percent-encoded per RFC 7512, so the PIN does not have to be
embedded in BINMAN_X509_KEY_URI.

The PIN-rewriting step in GetCertificate() uses a local variable
rather than mutating self.key_fname, because ProcessContents() calls
GetCertificate() a second time on the same entry; an in-place rewrite
would double-append the PIN on the second call.

Existing behavior is unchanged when keyfile is a filesystem path and
BINMAN_X509_KEY_URI is not set.

Tested with SoftHSM2 and Yubikey on OpenSSL 3.x using the
verdin-am62_a53_defconfig configuration. The new testX509CertPkcs11
test exercises the full path end-to-end against a SoftHSM2 token; it
skips cleanly when the OpenSSL pkcs11 provider is not installed.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 Makefile                                    |  1 +
 tools/binman/binman.rst                     | 55 ++++++++++++
 tools/binman/etype/x509_cert.py             | 37 +++++++--
 tools/binman/ftest.py                       | 92 +++++++++++++++++++++
 tools/binman/test/fit/openssl_provider.conf | 14 ++++
 5 files changed, 194 insertions(+), 5 deletions(-)
 create mode 100644 tools/binman/test/fit/openssl_provider.conf

diff --git a/Makefile b/Makefile
index 7e87b4f65f28..f2b84336ec72 100644
--- a/Makefile
+++ b/Makefile
@@ -1704,6 +1704,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		-a vpl-dtb=$(CONFIG_VPL_OF_REAL) \
 		-a pre-load-key-path=${PRE_LOAD_KEY_PATH} \
 		-a of-spl-remove-props=$(CONFIG_OF_SPL_REMOVE_PROPS) \
+		$(if $(BINMAN_X509_KEY_URI),-a keyfile="$(BINMAN_X509_KEY_URI)") \
 		$(BINMAN_$(@F))
 
 OBJCOPYFLAGS_u-boot.ldr.hex := -I binary -O ihex
diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 366491089ad9..123c4ef631b5 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -2161,6 +2161,61 @@ BINMAN_INDIRS
     Sets the search path for input files used by binman by adding one or more
     `-I` arguments. See :ref:`External blobs`.
 
+BINMAN_X509_KEY_URI
+    URI of a key used to sign x509 certificate entries via an HSM instead of a
+    PEM key file on disk. When set, it is passed as ``-a keyfile=<uri>`` to
+    binman, which overrides the ``keyfile`` entry argument for all x509
+    certificate signing operations.
+
+    This only applies to x509 certificate entries (e.g. TI K3 secure boot). It
+    does not affect FIT image signing, which uses device tree properties such
+    as ``fit,engine`` and ``key-name-hint`` instead.
+
+    URIs currently supported:
+
+    - PKCS#11 URI (RFC 7512)
+
+    PKCS#11 signing requires OpenSSL 3.x. The provider or engine and the
+    PKCS#11 module must be configured externally via an ``openssl.cnf`` file.
+    Either rely on the system default (``/etc/ssl/openssl.cnf``) or point to a
+    custom file via ``OPENSSL_CONF``.
+
+    Two URI forms are supported on OpenSSL 3.x:
+
+    1. Provider path (recommended) — requires the pkcs11 provider, e.g. via
+       the ``pkcs11-provider`` package::
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
+    The recommended way to deliver the PIN for non-interactive signing is to
+    configure it inside ``openssl.cnf`` under the pkcs11 provider section via
+    ``pkcs11-module-token-pin``. As a fallback, set the ``PKCS11_PIN``
+    environment variable. Its value is appended to the URI as
+    ``?pin-value=<pin>`` (percent-encoded per RFC 7512) so the PIN does not
+    have to be embedded in ``BINMAN_X509_KEY_URI``::
+
+        PKCS11_PIN=1234 make BINMAN_X509_KEY_URI="pkcs11:..." \
+                             OPENSSL_CONF=/path/to/openssl.cnf
+
+    Note: ``PKCS11_PIN`` keeps the PIN out of the ``BINMAN_X509_KEY_URI``
+    value itself, but the PIN is still passed to ``openssl`` as part of its
+    command line, where it is visible via ``ps`` and may appear in verbose
+    build logs. For stronger isolation, configure the PIN inside
+    ``openssl.cnf`` as described above.
+
 BINMAN_TOOLPATHS
     Sets the search path for external tool used by binman by adding one or more
     `--toolpath` arguments. See :ref:`External tools`.
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index efa85f9553e7..c3f3026c85c6 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -7,6 +7,7 @@
 
 from collections import OrderedDict
 import os
+import urllib.parse
 
 from binman.entry import EntryArg
 from binman.etype.collection import Entry_collection
@@ -19,7 +20,11 @@ class Entry_x509_cert(Entry_collection):
 
     Properties / Entry arguments:
         - content: List of phandles to entries to sign.
-        - keyfile: Filename of the PEM key file used to sign the binary.
+        - keyfile: Filename of the PEM key file used to sign the binary, or
+            a PKCS#11 URI (RFC 7512) referring to a key stored in an HSM,
+            e.g. ``pkcs11:token=mytoken;object=mykey;type=private``. See
+            ``BINMAN_X509_KEY_URI`` in the binman documentation for the
+            full setup.
         - cert-ca: Common Name (CN) embedded in the certificate. Used when
             generating a generic x509 certificate.
         - cert-revision-int: Integer certificate revision number. Used when
@@ -88,6 +93,15 @@ class Entry_x509_cert(Entry_collection):
         if input_data is None:
             return None
 
+        # When keyfile is a PKCS#11 URI and PKCS11_PIN is set, append the
+        # PIN to the URI so signing runs non-interactively. The preferred
+        # way to deliver a PIN is to configure pkcs11-module-token-pin in
+        # openssl.cnf; PKCS11_PIN is the convenience fallback.
+        key_fname = self.key_fname
+        pin = os.environ.get('PKCS11_PIN')
+        if pin and 'pkcs11:' in key_fname:
+            key_fname = self._build_pkcs11_key(key_fname, pin)
+
         uniq = self.GetUniqueName()
         output_fname = tools.get_output_filename('cert.%s' % uniq)
         input_fname = tools.get_output_filename('input.%s' % uniq)
@@ -98,7 +112,7 @@ class Entry_x509_cert(Entry_collection):
             stdout = self.openssl.x509_cert(
                 cert_fname=output_fname,
                 input_fname=input_fname,
-                key_fname=self.key_fname,
+                key_fname=key_fname,
                 cn=self._cert_ca,
                 revision=self._cert_rev,
                 config_fname=config_fname)
@@ -106,7 +120,7 @@ class Entry_x509_cert(Entry_collection):
             stdout = self.openssl.x509_cert_sysfw(
                 cert_fname=output_fname,
                 input_fname=input_fname,
-                key_fname=self.key_fname,
+                key_fname=key_fname,
                 config_fname=config_fname,
                 sw_rev=self.sw_rev,
                 req_dist_name_dict=self.req_dist_name,
@@ -115,7 +129,7 @@ class Entry_x509_cert(Entry_collection):
             stdout = self.openssl.x509_cert_rom(
                 cert_fname=output_fname,
                 input_fname=input_fname,
-                key_fname=self.key_fname,
+                key_fname=key_fname,
                 config_fname=config_fname,
                 sw_rev=self.sw_rev,
                 req_dist_name_dict=self.req_dist_name,
@@ -130,7 +144,7 @@ class Entry_x509_cert(Entry_collection):
             stdout = self.openssl.x509_cert_rom_combined(
                 cert_fname=output_fname,
                 input_fname=input_fname,
-                key_fname=self.key_fname,
+                key_fname=key_fname,
                 config_fname=config_fname,
                 sw_rev=self.sw_rev,
                 req_dist_name_dict=self.req_dist_name,
@@ -176,3 +190,16 @@ class Entry_x509_cert(Entry_collection):
     def AddBintools(self, btools):
         super().AddBintools(btools)
         self.openssl = self.AddBintool(btools, 'openssl')
+
+    @staticmethod
+    def _build_pkcs11_key(uri, pin):
+        """Append pin-value to a PKCS#11 URI when a PIN is provided.
+
+        The PIN is percent-encoded per RFC 7512. Uses '&' as separator if
+        the URI already contains '?', else '?'. Returns the URI unchanged
+        when pin is None or empty.
+        """
+        if not pin:
+            return uri
+        sep = '&' if '?' in uri else '?'
+        return f'{uri}{sep}pin-value={urllib.parse.quote(pin, safe="")}'
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 9a3811c17322..5ee118993390 100644
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
@@ -6905,6 +6906,97 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing bintools.*: openssl")
 
+    def testX509CertPkcs11(self):
+        """Test X509 certificate signing via a PKCS#11 URI in keyfile"""
+        openssl = bintool.Bintool.create('openssl')
+        self._CheckBintool(openssl)
+
+        # Detect the OpenSSL pkcs11 provider. -provider asks OpenSSL to load
+        # the named provider, so the command succeeds only when the provider
+        # module is installed; this works regardless of OPENSSL_CONF state.
+        result = openssl.run_cmd_result('list', '-providers',
+                                        '-provider', 'pkcs11',
+                                        raise_on_error=False)
+        if result is None or result.return_code != 0:
+            self.skipTest('OpenSSL pkcs11 provider not available')
+
+        softhsm2_util = bintool.Bintool.create('softhsm2_util')
+        self._CheckBintool(softhsm2_util)
+
+        prefix = 'testX509CertPkcs11.'
+
+        # Per-test SoftHSM2 token store, isolated from the host config.
+        softhsm2_conf_data = tools.read_file(self.TestFile('fit/softhsm2.conf'))
+        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf',
+                                            softhsm2_conf_data)
+        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
+        with open(softhsm2_conf, 'a') as f:
+            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
+
+        # Minimal in-tree openssl.cnf that loads the pkcs11 provider. It
+        # relies on the provider module living in OpenSSL's MODULESDIR and
+        # on softhsm2 being registered with p11-kit globally, both of
+        # which are the case on any system where pkcs11-provider and
+        # softhsm2 are installed normally.
+        openssl_conf = self.TestFile('fit/openssl_provider.conf')
+
+        pin = '1234'
+        token = 'x509-test'
+        key_label = 'testkey'
+
+        # rsa2048.key is already a PKCS#8 PEM, which is what
+        # softhsm2-util --import requires.
+        private_key = self.TestFile('fit/rsa2048.key')
+
+        with unittest.mock.patch.dict('os.environ',
+                                      {'SOFTHSM2_CONF': softhsm2_conf,
+                                       'OPENSSL_CONF': openssl_conf,
+                                       'PKCS11_PIN': pin}):
+            softhsm2_util.run_cmd('--init-token', '--free', '--label', token,
+                                  '--pin', pin, '--so-pin', '000000')
+            softhsm2_util.run_cmd('--import', private_key, '--token', token,
+                                  '--label', key_label, '--id', '01',
+                                  '--pin', pin)
+
+            uri = f'pkcs11:token={token};object={key_label};type=private'
+            entry_args = {
+                # 'keyfile' is set to a PKCS#11 URI rather than a filesystem
+                # path. binman forwards it to 'openssl -key', which resolves
+                # it via the pkcs11 provider configured in OPENSSL_CONF.
+                # PKCS11_PIN is appended to the URI by Entry_x509_cert before
+                # the openssl invocation, exercising _build_pkcs11_key().
+                'keyfile': uri,
+            }
+            data = self._DoReadFileDtb('security/x509_cert.dts',
+                                       entry_args=entry_args)[0]
+        self.assertEqual(U_BOOT_DATA, data[-4:])
+
+    def testX509CertBuildPkcs11Key(self):
+        """Test the Entry_x509_cert._build_pkcs11_key URI/PIN helper"""
+        build = Entry_x509_cert._build_pkcs11_key
+
+        # No PIN: URI returned unchanged
+        self.assertEqual(build('pkcs11:token=t;object=o;type=private', None),
+                         'pkcs11:token=t;object=o;type=private')
+        self.assertEqual(build('pkcs11:token=t', ''),
+                         'pkcs11:token=t')
+
+        # Simple PIN: '?' separator + percent-encoded value
+        self.assertEqual(build('pkcs11:token=t', '1234'),
+                         'pkcs11:token=t?pin-value=1234')
+
+        # URI already has '?': use '&' separator
+        self.assertEqual(build('pkcs11:token=t?foo=bar', '1234'),
+                         'pkcs11:token=t?foo=bar&pin-value=1234')
+
+        # PIN with reserved characters: percent-encoded per RFC 7512
+        self.assertEqual(build('pkcs11:token=t', 'a&b?c=d'),
+                         'pkcs11:token=t?pin-value=a%26b%3Fc%3Dd')
+
+        # PIN with space and '+': both percent-encoded
+        self.assertEqual(build('pkcs11:token=t', 'a b+c'),
+                         'pkcs11:token=t?pin-value=a%20b%2Bc')
+
     def testPackRockchipTpl(self):
         """Test that an image with a Rockchip TPL binary can be created"""
         data = self._DoReadFile('vendor/rockchip_tpl.dts')
diff --git a/tools/binman/test/fit/openssl_provider.conf b/tools/binman/test/fit/openssl_provider.conf
new file mode 100644
index 000000000000..579452ca84c4
--- /dev/null
+++ b/tools/binman/test/fit/openssl_provider.conf
@@ -0,0 +1,14 @@
+openssl_conf = openssl_init
+
+[openssl_init]
+providers = providers_section
+
+[providers_section]
+default = default_provider
+pkcs11 = pkcs11_provider
+
+[default_provider]
+activate = 1
+
+[pkcs11_provider]
+activate = 1
-- 
2.34.1

