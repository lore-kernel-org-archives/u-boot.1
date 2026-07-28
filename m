Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34460C531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A8B840910;
	Tue, 28 Jul 2026 11:36:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UFNP0JfmO_6K; Tue, 28 Jul 2026 11:36:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7BD834080B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238574;
	bh=CAzIdVK9GMGBU79xrHZrcCHmSFr5N+G7uUnWiwgaxcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MYtrCAMz1BUAPWG65WtTWskZiduPbMnYl01GivbFi/+gSV263OgV8wLhutf7PNuXn
	 IklSO6qVcsOU2MewXgs8NDW4JXqdS4s5uk2Q9pkH0x6yjUU5x8lujQFaqy3fg6rlfO
	 6iBABpqrnp5lNJDjJe1iFBaAapBwBsyG4gRbSxZN0PCtNAHPH0mvdxla2uSkg14ZoK
	 fW22vTghS16GkUbB9aF183DVQ1VHn7HUZRr+Ae4VgiKKsOrVGZA7sB0g/Nq9/mqVAB
	 b1AwJICpsZKrOK4W1y7WJ+V6qAvc4flYJuxaAUEMgltZxpnP1huqr31sHBgwhvMwry
	 1ILyqW/pvLqag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BD834080B;
	Tue, 28 Jul 2026 11:36:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2FAA2E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A47FE607EF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5LbkVoPokysm for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:36:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sergio.prado@e-labworks.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0898360856
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0898360856
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0898360856
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 338EC8494B; Tue, 28 Jul 2026 13:36:09 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 020FC82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:36:06 +0200 (CEST)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so3655206a91.0
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238564; x=1785843364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CAzIdVK9GMGBU79xrHZrcCHmSFr5N+G7uUnWiwgaxcY=;
 b=QTgl8L8Z6zBfX7uNU/Xqn2Aylmby4mscabd6G0dX/Baq0hyp1eXbjsTahlp729+zrP
 YAm7OwQNSAR7wtXZhB3/ufsD6wEB8/pOCqS6/+jQrsgaDiFlef6KfbBj2LIcoVmkrWNX
 gvOF3FNTEAn9sf/U6KsCSYTF9OyyD7N2+kuYazSQjFHKZrZiTtBM867aRdg4yGkKW7C9
 NLOkVaDcMw5V4b7Oiybp2foZCiXITYjC8vutazNsleFWgnDh4NNJLRjbJF2Cbxlv23C1
 2oZiLN0IkJs/Sq+ifQDYgz9XuW+5mr0CP4uMhHHDfIWdyTrDPJRXkO/+I9s5dgvc7c3N
 f0Dg==
X-Gm-Message-State: AOJu0Yy51EHjvUFnEfOwfclNriRL0wkhAUN0X2dzC+pGRAameceQmgv4
 /IbsPOU03EiK6vWkALJlwTrWGjtvCJ0Vn72wLMrJMigCuonAGdkCKd04vPa6UZap4B4RXOCRe+v
 LQj7A
X-Gm-Gg: AR+sD12gs5XchSdY1UMy87FsCTrkErqKh7/oFyhgmIZMS7HBhDVlzKp7dW+uf+JnxSc
 NduZ2ZHN3eRRpKqzDbW3V9BKAoTGTLp136PpRxzO0AVuS+mlKqQlFaz+8YzE6n7Y+AumFhwMeuz
 MG6IMHOfKDR4DRIidYxQfQVcZUxefY0Hcd7vkVud5uu/arOebBq99Fr7bITGmVrdBglsjpSKWHP
 8VTPVvvPasyBG1uOOK/PuU9KvllC7TFxeGYT9tUb7XyrjIEGyygHCg+dCkUMW58d88ICGMF1HvY
 WD1ueLKQD4c4ElRA/94bXF8RLyEMWRDFCwnZAwGakevaQTmm+6Agy0+3D5Z5QqgNMZnHhsriG7V
 wDlDrbcspBp/Wt7gv9VVSyDWWDswp9LsTNqMirFIqVIBlgGnH9MKwnPLkZ9lozQI36B1gb/zFAL
 3TkGZ3QEs61A==
X-Received: by 2002:a17:90b:5146:b0:38d:3ca9:434 with SMTP id
 98e67ed59e1d1-38f6a426f70mr2376252a91.28.1785238564092; 
 Tue, 28 Jul 2026 04:36:04 -0700 (PDT)
Received: from desktop.. ([2804:7f0:6400:919d:7be6:2bc2:d3d3:8617])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419c52sm42603976eec.10.2026.07.28.04.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 04:36:03 -0700 (PDT)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 pbrobinson@gmail.com, sughosh.ganu@arm.com, sergio.prado@e-labworks.com,
 wolfgang.wallner@at.abb.com, xypron.glpk@gmx.de, quentin.schulz@cherry.de,
 jj251510319013@gmail.com, Wojciech.Dubowik@mt.com
Subject: [PATCH v6 2/5] binman: x509_cert: document PKCS#11 URI support in
 keyfile
Date: Tue, 28 Jul 2026 08:35:32 -0300
Message-Id: <20260728113535.128601-3-sergio.prado@e-labworks.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728113535.128601-1-sergio.prado@e-labworks.com>
References: <20260728113535.128601-1-sergio.prado@e-labworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1785238564; x=1785843364;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CAzIdVK9GMGBU79xrHZrcCHmSFr5N+G7uUnWiwgaxcY=;
 b=j6JDf5rKHq7qKVF0yKmXdmmo0q9Wwchwdts7eAKKSNVb//ngF0IRkg7g5A7htJpVWB
 Xmv5/8xHnDASrwlu0Dd+4s95C+XCNpp5Y6tn+MuvCSwK24lAGkOhNp0jrIL3xwb/eW/F
 QvjzfqYflG9cBHRg5BjttatliIraHOVx/ShQLplx+6xLMRDKusIr22LK7QtnR5uNIXn2
 GZ7SOFm01IVGTwiBHkpUXZj40JlLa0ojJWbX4OcMiPifN7CJgR4clrPqC5Z9He9pG4yx
 jxnB2meAjSK5+lhv9ntNKFFDE9umKIG4UISksWxbmZmKL7wSUkulUIHN39sRd1oLOXYP
 DoRQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org; spf=none
 smtp.mailfrom=e-labworks.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=e-labworks-com.20251104.gappssmtp.com
 header.i=@e-labworks-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=j6JDf5rK
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=sergio.prado@e-labworks.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=e-labworks-com.20251104.gappssmtp.com
 header.i=@e-labworks-com.20251104.gappssmtp.com header.b="j6JDf5rK"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The 'keyfile' entry argument of an x509 certificate entry is passed
straight to 'openssl -key', which on OpenSSL 3.x resolves it through the
STORE API. Any URI the STORE API understands therefore already works,
including a PKCS#11 URI (RFC 7512) naming a key held in a hardware
security module.

Nothing in binman had to change for that, but nothing said so either.
Document the forms 'keyfile' accepts - a PEM key file on disk, a PKCS#11
URI, or a PKCS#11 URI prefixed with 'org.openssl.engine:<engine>:' for
setups which only have the older pkcs11 engine - along with the OpenSSL
configuration they need and the two ways of supplying the token PIN for
unattended signing.

PKCS#11 signing needs OpenSSL 3.x. The provider API and the
'org.openssl.engine:' STORE scheme both appeared in 3.0, and OpenSSL 4.0
removed the ENGINE API altogether [1], so the engine form is specific to
3.x while the provider form is the one to build on. OpenSSL 1.x is not
supported.

When a PIN is given both in openssl.cnf via pkcs11-module-token-pin and
as a pin-value attribute in the URI, the URI wins. This was measured
with SoftHSM2 and the pkcs11 provider on OpenSSL 3.4.1.

Add testX509CertPkcs11, which signs against a SoftHSM2 token with the
PIN carried in the URI and skips cleanly when the OpenSSL pkcs11
provider is not installed. Add testX509CertKeyfile too, which checks
that the 'keyfile' property is read and that the entry argument
overrides it; it uses an image description of its own rather than
x509_cert.dts, so that the file naming a nonexistent key cannot trip up
tests which just want a signed certificate.

[1] https://openssl-library.org/post/2025-12-18-remove-engines/

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 tools/binman/binman.rst                       | 52 ++++++++++
 tools/binman/etype/x509_cert.py               |  4 +-
 tools/binman/ftest.py                         | 96 +++++++++++++++++++
 tools/binman/test/fit/openssl_provider.conf   | 14 +++
 .../test/security/x509_cert_keyfile.dts       | 25 +++++
 5 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 tools/binman/test/fit/openssl_provider.conf
 create mode 100644 tools/binman/test/security/x509_cert_keyfile.dts

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 366491089ad9..86e15741fa35 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -1543,6 +1543,58 @@ If you want to sign and replace a FIT container in place::
 which will sign the FIT container with a private key and replace it immediately
 inside your image.
 
+.. _`SigningX509Hsm`:
+
+Signing x509 certificates with a key stored in an HSM
+-----------------------------------------------------
+
+x509 certificate entries (see :ref:`etype_x509_cert`) are signed with the key
+named by their ``keyfile`` property or entry argument. Instead of a key file on
+disk, ``keyfile`` accepts a PKCS#11 URI (RFC 7512) naming a key held in a
+hardware security module, so that the private key never leaves the device::
+
+    keyfile = "pkcs11:token=mytoken;object=mykey;type=private";
+
+binman passes ``keyfile`` to ``openssl -key``, which resolves it through
+OpenSSL's STORE API. Everything else - loading the pkcs11 provider or engine
+and pointing it at the PKCS#11 module - is configured outside binman, in an
+``openssl.cnf`` file selected either by the system default
+(``/etc/ssl/openssl.cnf``) or by the ``OPENSSL_CONF`` environment variable.
+
+This requires OpenSSL 3.x; OpenSSL 1.x is not supported. Two forms of URI can
+be used:
+
+1. Provider path (recommended). This needs the pkcs11 provider, e.g. the
+   ``pkcs11-provider`` package on Debian and Ubuntu::
+
+       pkcs11:token=mytoken;object=mykey;type=private
+
+2. Engine path, for setups where only the older pkcs11 engine is available
+   (e.g. ``libengine-pkcs11-openssl``). Prefixing the URI with
+   ``org.openssl.engine:<engine>:`` routes it to the engine through the STORE
+   API, so that no ``-engine`` / ``-keyform`` command-line flags are needed::
+
+       org.openssl.engine:pkcs11:pkcs11:token=mytoken;object=mykey;type=private
+
+   Note that OpenSSL 4.0 removed the ENGINE API altogether, so this form only
+   works on OpenSSL 3.x. New setups should use the provider.
+
+Unattended signing needs the token PIN. This can be supplied in
+``openssl.cnf``, under the section which activates the pkcs11 provider::
+
+    [pkcs11_provider]
+    activate = 1
+    pkcs11-module-token-pin = 1234
+
+or as a ``pin-value`` attribute in the URI itself::
+
+    keyfile = "pkcs11:token=mytoken;object=mykey;type=private?pin-value=1234";
+
+If both are given, the ``pin-value`` in the URI wins. Note that a PIN placed in
+``keyfile`` ends up on the ``openssl`` command line, where it is visible via
+``ps`` and may be recorded in build logs; keeping the PIN in ``openssl.cnf``
+avoids that.
+
 .. _`BinmanLogging`:
 
 Logging
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index efa85f9553e7..6d7883af58ef 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -19,7 +19,9 @@ class Entry_x509_cert(Entry_collection):
 
     Properties / Entry arguments:
         - content: List of phandles to entries to sign.
-        - keyfile: Filename of the PEM key file used to sign the binary.
+        - keyfile: Key used to sign the binary. This is either the filename of
+            a PEM key file on disk, or a PKCS#11 URI naming a key stored in a
+            hardware security module. See :ref:`SigningX509Hsm`.
         - cert-ca: Common Name (CN) embedded in the certificate. Used when
             generating a generic x509 certificate.
         - cert-revision-int: Integer certificate revision number. Used when
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index bf98b268ac15..10373a2fa899 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -6905,6 +6905,102 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing bintools.*: openssl")
 
+    def testX509CertKeyfile(self):
+        """Test that the keyfile entry arg overrides the keyfile property"""
+        # The keyfile property in this image description names a file which
+        # does not exist, so signing fails when there is no entry arg
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFileDtb('security/x509_cert_keyfile.dts')
+        self.assertIn('keyfile-from-dts.key', str(e.exception))
+
+        # With the entry arg present, the key it names is used instead
+        entry_args = {
+            'keyfile': self.TestFile('security/key.key'),
+        }
+        data = self._DoReadFileDtb('security/x509_cert_keyfile.dts',
+                                   entry_args=entry_args)[0]
+        self.assertEqual(U_BOOT_DATA, data[-4:])
+
+    def _CheckPkcs11Provider(self):
+        """Skip the current test if the OpenSSL pkcs11 provider is missing"""
+        openssl = bintool.Bintool.create('openssl')
+        self._CheckBintool(openssl)
+
+        # '-provider pkcs11' asks OpenSSL to load the named provider, so this
+        # succeeds only when the provider module is installed, whatever
+        # OPENSSL_CONF happens to point at
+        result = openssl.run_cmd_result('list', '-providers', '-provider',
+                                        'pkcs11', raise_on_error=False)
+        if result is None or result.return_code != 0:
+            self.skipTest('OpenSSL pkcs11 provider not available')
+
+    def _SetupPkcs11Token(self, prefix, token, key_label, pin):
+        """Set up a SoftHSM2 token holding the test signing key
+
+        Creates a SoftHSM2 configuration and token store private to the
+        calling test, then imports the in-tree test key into a fresh token.
+
+        Args:
+            prefix (str): Prefix for the temporary files to create
+            token (str): Label of the token to create
+            key_label (str): Label to give to the imported private key
+            pin (str): User PIN to set on the token
+
+        Returns:
+            dict: Environment variables which make both the token and the
+                OpenSSL pkcs11 provider visible to openssl
+        """
+        softhsm2_util = bintool.Bintool.create('softhsm2_util')
+        self._CheckBintool(softhsm2_util)
+
+        # Per-test SoftHSM2 token store, isolated from the host configuration
+        data = tools.read_file(self.TestFile('fit/softhsm2.conf'))
+        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
+        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
+        with open(softhsm2_conf, 'a') as f:
+            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
+
+        # Minimal in-tree openssl.cnf which activates the pkcs11 provider. It
+        # relies on the provider module living in OpenSSL's MODULESDIR and on
+        # softhsm2 being registered with p11-kit globally, both of which hold
+        # when pkcs11-provider and softhsm2 are installed normally.
+        env = {'SOFTHSM2_CONF': softhsm2_conf,
+               'OPENSSL_CONF': self.TestFile('fit/openssl_provider.conf')}
+
+        # rsa2048.key is already a PKCS#8 PEM, which is what
+        # 'softhsm2-util --import' requires
+        private_key = self.TestFile('fit/rsa2048.key')
+        with unittest.mock.patch.dict('os.environ', env):
+            softhsm2_util.run_cmd('--init-token', '--free', '--label', token,
+                                  '--pin', pin, '--so-pin', '000000')
+            softhsm2_util.run_cmd('--import', private_key, '--token', token,
+                                  '--label', key_label, '--id', '01',
+                                  '--pin', pin)
+        return env
+
+    def testX509CertPkcs11(self):
+        """Test X509 certificate signing with a key stored in an HSM"""
+        self._CheckPkcs11Provider()
+
+        token = 'x509-test'
+        key_label = 'testkey'
+        pin = '1234'
+        env = self._SetupPkcs11Token('testX509CertPkcs11.', token, key_label,
+                                     pin)
+
+        # 'keyfile' is a PKCS#11 URI rather than a filesystem path. binman
+        # passes it to 'openssl -key', which resolves it through the pkcs11
+        # provider activated by OPENSSL_CONF. The PIN is carried by the URI
+        # itself, so signing runs without any further configuration.
+        entry_args = {
+            'keyfile': (f'pkcs11:token={token};object={key_label};'
+                        f'type=private?pin-value={pin}'),
+        }
+        with unittest.mock.patch.dict('os.environ', env):
+            data = self._DoReadFileDtb('security/x509_cert.dts',
+                                       entry_args=entry_args)[0]
+        self.assertEqual(U_BOOT_DATA, data[-4:])
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
diff --git a/tools/binman/test/security/x509_cert_keyfile.dts b/tools/binman/test/security/x509_cert_keyfile.dts
new file mode 100644
index 000000000000..468c6b4406b1
--- /dev/null
+++ b/tools/binman/test/security/x509_cert_keyfile.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		x509-cert {
+			cert-ca = "IOT2050 Firmware Signature";
+			cert-revision-int = <0>;
+			/*
+			 * Deliberately names a file which does not exist, so
+			 * that a test can tell whether this property or the
+			 * 'keyfile' entry argument was used
+			 */
+			keyfile = "keyfile-from-dts.key";
+			content = <&u_boot>;
+		};
+
+		u_boot: u-boot {
+		};
+	};
+};
-- 
2.34.1

