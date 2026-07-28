Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05701C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C370160878;
	Tue, 28 Jul 2026 11:36:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HEedXG2Bl8cP; Tue, 28 Jul 2026 11:36:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA77760856
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238583;
	bh=+uvZ1/SbipzKhne/5uW7umSjp9RPZkz0iXuFN00qpGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vj4uVbj7UsOBSO2tG3/EWhtOwji05repbfGG8Eik9T9GrB9MhzzSnLl7+R07+HpHN
	 9glIcxZ23YTdMoecdeLaYhxCJsIshY+z/OUWoAsh9a30Pgvb0OyNqyvoHzBX9tzOoE
	 mQQTmVmIRsngPv2M1Yh205K0yzUaKkT43WPUh+nDAMIm1WFkIVq94n/iwwPdOH+Vjg
	 G8etlwjRdXUj1mrs+XfkFor5+sbTraJVyG+NrXcrAn36HrfMBZcSh0lqcMj2ix2Bf9
	 L9/0yx1+LkREusQnjdBz/5uAUXvPrNV8b/TrPO5mTKuwXjdCgpBj+PB7Kgs4XbTfs4
	 Yf6+0D5mIDzSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA77760856;
	Tue, 28 Jul 2026 11:36:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 544C92E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 46B3881217
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MsUupX8gyPhO for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:36:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sergio.prado@e-labworks.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F0B5D80F76
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0B5D80F76
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F0B5D80F76
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E15B8494B; Tue, 28 Jul 2026 13:36:18 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7EFA82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:36:15 +0200 (CEST)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cbb973e6749so4218971a12.1
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238574; x=1785843374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+uvZ1/SbipzKhne/5uW7umSjp9RPZkz0iXuFN00qpGc=;
 b=sEGDtTJHS75+S9s503NieEdIaofngseE+HoJIT/lCML2Cxr5qD/II6yAvrOX+623y3
 fjMAIaZEEwv433SnQcJ17HY6dQZTiA0VYQ4b1+IHn004pRUIIeQjHfPeCibH6yZ+0MWI
 wyq24X5591iLOe/29ktAjOLLbIt8OLetSV/vFPSgOq7ItSipr3SFz24X4/s3mFzaxsv4
 k/lNqApBdVZIIPzXfKwW+QWFSQfBGEu6xfzRz0YndLHlLGMnz794ctJaaL4OfbYG7JTj
 qGphS3id1Hhz1OKJJtTBovqCgldw1exwDStC/ZJ+h8H8r2XHuZsFQ+1ARHqFW70YiXwl
 UcrQ==
X-Gm-Message-State: AOJu0YwJzLAUcKlZNfvr64sQsY1rbMrE0tRQ27+zcd5rYkA2N2m9Mndl
 uqP6e0QABQ/kc0VVD2PKBOgZ0IMs5ZonkRv2XC7nbJZ9QbhsK59Y/qqUOSj5LoWwZxLiyo9dPzQ
 Afdx/
X-Gm-Gg: AR+sD11w0x7ymNk2au4kvD5ytHmx/OMS4p8VSNA33/8U8lrc7We+BmrGCJSCvQlfyAI
 A5ds5NSY3AI0JyrFdXCgIkSgfdIMk95Qo1lQDtamTZ9vJ5mXVGwbZqiRxgn25BXql9nZbg2N7Or
 aH3TqAZ709nog38BjOzyZMxdDlCKqM91f240FwV9tnZcxf7z17cfW1gEmhEvYUk0m3CQ6of/Ian
 gXyr3FrSWlz2CI2pEVhkA6IIzMNjGHGqJH/WqvLIof5k4TG1jpltnJyaCrmEN0S53MUwfrGJN7A
 wEo5EcJGtltKJr568H4FwKGBRz5hdL9iG/bKvbI4CqmkKNwpjeOGM/IkUzri4agxjyYeBNa0EYP
 2IpRLXbJ2wt0JaRMfjfzpygQ53USCnlqyfg6+16P4joYJBgHCv8x0TLQw5u1brV84TZjkaoNjpz
 fFNMWU/neMgw==
X-Received: by 2002:a05:6a21:6f84:b0:3c3:8ead:6df0 with SMTP id
 adf61e73a8af0-3c8b6cfe9fdmr2545932637.28.1785238574013; 
 Tue, 28 Jul 2026 04:36:14 -0700 (PDT)
Received: from desktop.. ([2804:7f0:6400:919d:7be6:2bc2:d3d3:8617])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419c52sm42603976eec.10.2026.07.28.04.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 04:36:13 -0700 (PDT)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 pbrobinson@gmail.com, sughosh.ganu@arm.com, sergio.prado@e-labworks.com,
 wolfgang.wallner@at.abb.com, xypron.glpk@gmx.de, quentin.schulz@cherry.de,
 jj251510319013@gmail.com, Wojciech.Dubowik@mt.com
Subject: [PATCH v6 4/5] binman: x509_cert: support PKCS11_PIN environment
 variable
Date: Tue, 28 Jul 2026 08:35:34 -0300
Message-Id: <20260728113535.128601-5-sergio.prado@e-labworks.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728113535.128601-1-sergio.prado@e-labworks.com>
References: <20260728113535.128601-1-sergio.prado@e-labworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1785238574; x=1785843374;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+uvZ1/SbipzKhne/5uW7umSjp9RPZkz0iXuFN00qpGc=;
 b=mtqIYf8EIeP1o6xxrclr/DMCP1x49I7tcGiEKlZgMAUNbOfuYXAd1BNmJr2i75HsS0
 +eeKBVcIiBx9jd6xyMLDeC0mTLg6phIG2G22SkqYEEAPGlJ/YRVbkydjnT4ptH42y7sR
 PAXmD2On6LdeezHFASGZXS0J8d9/68adiAhB6POX1g4ZCb56z0/7MY0tQE5/mHFy9ZQK
 0wdVmYL1Qi3SFmAisyG9zpZSYuxVRmOjM4Ev1fhrQpFe5xJbYpN5sraf0vc9jWPn+Wgp
 t34ABwc5tQWsxbPDRzYibEP5Iho7jL5CVErOWLBo6cfYF4/myWtDb1lUR8N2anC5pmKZ
 R1gg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org; spf=none
 smtp.mailfrom=e-labworks.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=e-labworks-com.20251104.gappssmtp.com
 header.i=@e-labworks-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=mtqIYf8E
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=sergio.prado@e-labworks.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=e-labworks-com.20251104.gappssmtp.com
 header.i=@e-labworks-com.20251104.gappssmtp.com header.b="mtqIYf8E"; 
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

Signing an x509 certificate entry with a key held in an HSM needs the
token PIN. It can be put in openssl.cnf via pkcs11-module-token-pin, or
in the PKCS#11 URI itself as a pin-value attribute, but both mean writing
the PIN into a file which is part of the build. That is not
user-friendly in CI, where the PIN typically arrives as a secret in the
environment.

Read the PIN from the PKCS11_PIN environment variable and append it to
the URI as a percent-encoded pin-value attribute, as described by RFC
7512. The rewritten URI, not the original, is what reaches
'openssl -key'.

PKCS11_PIN is a fallback. A URI which already has a pin-value or a
pin-source attribute is passed through untouched, since the PIN named by
the URI is the one OpenSSL uses; appending a second pin-value would
silently override it, as the last occurrence wins.

Note that PKCS11_PIN keeps the PIN out of the build files but not off the
openssl command line, where it is visible via 'ps' and may be recorded in
build logs. Configuring the PIN in openssl.cnf remains the option which
avoids that, and this is documented alongside the variable.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 tools/binman/binman.rst         |  11 ++++
 tools/binman/etype/x509_cert.py |  31 ++++++++++
 tools/binman/ftest.py           | 105 ++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 86e15741fa35..106c34efb76c 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -1595,6 +1595,17 @@ If both are given, the ``pin-value`` in the URI wins. Note that a PIN placed in
 ``ps`` and may be recorded in build logs; keeping the PIN in ``openssl.cnf``
 avoids that.
 
+As a third option, binman reads the PIN from the ``PKCS11_PIN`` environment
+variable and appends it to the URI as a ``pin-value`` attribute, so that the
+PIN does not have to be written into either file::
+
+    PKCS11_PIN=1234 binman build ...
+
+``PKCS11_PIN`` is a fallback only: a URI which already has a ``pin-value`` or
+``pin-source`` attribute is passed through untouched. It keeps the PIN out of
+the build files, but not off the ``openssl`` command line - for that, use
+``openssl.cnf``.
+
 .. _`BinmanLogging`:
 
 Logging
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index 6d7883af58ef..66c9987976c2 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -7,6 +7,7 @@
 
 from collections import OrderedDict
 import os
+import urllib.parse
 
 from binman.entry import EntryArg
 from binman.etype.collection import Entry_collection
@@ -70,6 +71,9 @@ class Entry_x509_cert(Entry_collection):
         self._cert_rev = fdt_util.GetInt(self._node, 'cert-revision-int', 0)
         self.key_fname = self.GetEntryArgsOrProps([
             EntryArg('keyfile', str)], required=True)[0]
+        if self.key_fname.startswith(('pkcs11:', 'org.openssl.engine:pkcs11:')):
+            self.key_fname = self._add_pkcs11_pin(self.key_fname,
+                                                  os.environ.get('PKCS11_PIN'))
         self.sw_rev = fdt_util.GetInt(self._node, 'sw-rev', 1)
 
     def GetCertificate(self, required, type='generic'):
@@ -178,3 +182,30 @@ class Entry_x509_cert(Entry_collection):
     def AddBintools(self, btools):
         super().AddBintools(btools)
         self.openssl = self.AddBintool(btools, 'openssl')
+
+    @staticmethod
+    def _add_pkcs11_pin(uri, pin):
+        """Add a PIN to a PKCS#11 URI, so that signing runs unattended
+
+        Appends a 'pin-value' attribute holding the PIN, percent-encoded as
+        required by RFC 7512. A URI which already says where its PIN comes
+        from is left alone, since that takes precedence over the PIN passed
+        here.
+
+        Args:
+            uri (str): PKCS#11 URI naming the signing key
+            pin (str): PIN to add, or None if there is none
+
+        Returns:
+            str: Value to pass to 'openssl -key'
+        """
+        if not pin:
+            return uri
+
+        # Only the query component can hold pin-value / pin-source
+        query = uri.partition('?')[2]
+        if 'pin-value=' in query or 'pin-source=' in query:
+            return uri
+
+        sep = '&' if query else '?'
+        return f'{uri}{sep}pin-value={urllib.parse.quote(pin, safe="")}'
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 10373a2fa899..e91768c52fe9 100644
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
@@ -7001,6 +7002,110 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                                        entry_args=entry_args)[0]
         self.assertEqual(U_BOOT_DATA, data[-4:])
 
+    def testX509CertPkcs11Pin(self):
+        """Test signing with a key in an HSM, with the PIN from PKCS11_PIN"""
+        self._CheckPkcs11Provider()
+
+        token = 'x509-test-pin'
+        key_label = 'testkey'
+        pin = '1234'
+        env = self._SetupPkcs11Token('testX509CertPkcs11Pin.', token,
+                                     key_label, pin)
+        env['PKCS11_PIN'] = pin
+
+        # This time the URI carries no PIN, so binman appends the one from
+        # PKCS11_PIN before handing the URI to openssl
+        entry_args = {
+            'keyfile': f'pkcs11:token={token};object={key_label};type=private',
+        }
+        with unittest.mock.patch.dict('os.environ', env):
+            data = self._DoReadFileDtb('security/x509_cert.dts',
+                                       entry_args=entry_args)[0]
+        self.assertEqual(U_BOOT_DATA, data[-4:])
+
+    def testX509CertPkcs11PinEngine(self):
+        """Test PKCS11_PIN with an engine-prefixed PKCS#11 URI"""
+        uri = ('org.openssl.engine:pkcs11:pkcs11:token=mytoken;'
+               'object=mykey;type=private')
+        entry_args = {
+            'keyfile': uri,
+        }
+
+        # openssl is forced missing so that this needs no pkcs11 engine to be
+        # installed; what matters is the keyfile it would have been given
+        with unittest.mock.patch.dict('os.environ', {'PKCS11_PIN': '1234'}):
+            with terminal.capture():
+                self._DoTestFile('security/x509_cert.dts',
+                                 force_missing_bintools='openssl',
+                                 entry_args=entry_args)
+        entry = control.images['image'].GetEntries()['x509-cert']
+        self.assertEqual(f'{uri}?pin-value=1234', entry.key_fname)
+
+    def testX509CertPkcs11PinNotUri(self):
+        """Test PKCS11_PIN is ignored when keyfile is not a PKCS#11 URI"""
+        # A path which merely contains 'pkcs11:' is not a URI, so it must
+        # reach openssl untouched
+        keyfile = '/keys/pkcs11:key'
+        entry_args = {
+            'keyfile': keyfile,
+        }
+        with unittest.mock.patch.dict('os.environ', {'PKCS11_PIN': '1234'}):
+            with terminal.capture():
+                self._DoTestFile('security/x509_cert.dts',
+                                 force_missing_bintools='openssl',
+                                 entry_args=entry_args)
+        entry = control.images['image'].GetEntries()['x509-cert']
+        self.assertEqual(keyfile, entry.key_fname)
+
+    def testX509CertPkcs11PinSubclass(self):
+        """Test PKCS11_PIN reaches the TI K3 x509 certificate subclasses"""
+        uri = 'pkcs11:token=mytoken;object=mykey;type=private'
+        entry_args = {
+            'keyfile': uri,
+        }
+
+        # These read 'keyfile' through Entry_x509_cert.ReadNode(), so the PIN
+        # must survive into the entry they build
+        for dts, name in [('vendor/ti_secure.dts', 'ti-secure'),
+                          ('vendor/ti_secure_rom.dts', 'ti-secure-rom')]:
+            with unittest.mock.patch.dict('os.environ',
+                                          {'PKCS11_PIN': '1234'}):
+                with terminal.capture():
+                    self._DoTestFile(dts, force_missing_bintools='openssl',
+                                     entry_args=entry_args)
+            entry = control.images['image'].GetEntries()[name]
+            self.assertEqual(f'{uri}?pin-value=1234', entry.key_fname)
+
+    def testX509CertAddPkcs11Pin(self):
+        """Test adding a PIN to a PKCS#11 URI"""
+        add = Entry_x509_cert._add_pkcs11_pin
+        uri = 'pkcs11:token=t;object=o;type=private'
+
+        # No PIN to add, so the keyfile is unchanged
+        self.assertEqual(uri, add(uri, None))
+        self.assertEqual(uri, add(uri, ''))
+
+        # PKCS#11 URI, in both the provider and the engine form
+        self.assertEqual(f'{uri}?pin-value=1234', add(uri, '1234'))
+        engine_uri = f'org.openssl.engine:pkcs11:{uri}'
+        self.assertEqual(f'{engine_uri}?pin-value=1234',
+                         add(engine_uri, '1234'))
+
+        # URI which already has a query component, so '&' separates the PIN
+        self.assertEqual(f'{uri}?module-name=softhsm2&pin-value=1234',
+                         add(f'{uri}?module-name=softhsm2', '1234'))
+
+        # URI which already says where its PIN comes from, so it takes
+        # precedence and the keyfile is unchanged
+        self.assertEqual(f'{uri}?pin-value=5678',
+                         add(f'{uri}?pin-value=5678', '1234'))
+        self.assertEqual(f'{uri}?pin-source=file:/etc/pin',
+                         add(f'{uri}?pin-source=file:/etc/pin', '1234'))
+
+        # PIN percent-encoded as required by RFC 7512
+        self.assertEqual(f'{uri}?pin-value=a%26b%3Fc%3Dd', add(uri, 'a&b?c=d'))
+        self.assertEqual(f'{uri}?pin-value=a%20b%2Bc', add(uri, 'a b+c'))
+
     def testPackRockchipTpl(self):
         """Test that an image with a Rockchip TPL binary can be created"""
         data = self._DoReadFile('vendor/rockchip_tpl.dts')
-- 
2.34.1

