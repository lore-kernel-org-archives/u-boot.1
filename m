Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B6DCE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 19:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2307F83C32;
	Mon, 17 Nov 2025 20:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E2DC83C13; Mon, 17 Nov 2025 20:43:52 +0100 (CET)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFD5983C46
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 20:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d9J8P3dm6zln8;
 Mon, 17 Nov 2025 20:43:49 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d9J8M6fTnzrPl; Mon, 17 Nov 2025 20:43:47 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 17 Nov 2025 20:43:32 +0100
Subject: [PATCH v2 4/4] tools: binman: fit: add tests for signing with an
 OpenSSL engine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-binman-engine-v2-4-e053f683c0b8@cherry.de>
References: <20251117-binman-engine-v2-0-e053f683c0b8@cherry.de>
In-Reply-To: <20251117-binman-engine-v2-0-e053f683c0b8@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Bryan Brattlof <bb@ti.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Yannic Moog <y.moog@phytec.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

This adds a test that signs a FIT and verifies the signature with
fit_check_sign.

OpenSSL engines are typically for signing with external HW so it's not
that straight-forward to simulate.

For a simple RSA OpenSSL engine, a dummy engine with a hardcoded RSA
4096 private key is made available. It can be selected by setting the
OpenSSL engine argument to dummy-rsa-engine. This can only be done if
the engine is detected by OpenSSL, which works by setting the
OPENSSL_ENGINES environment variable. I have no clue if dummy-rsa-engine
is properly implementing what is expected from an RSA engine, but it
seems to be enough for testing.

For a simple PKCS11 engine, SoftHSMv2 is used, which allows to do PKCS11
without specific hardware. The keypairs and tokens are generated on the
fly. The "prod" token is generated with a different PIN (1234 instead of
1111) than the configured value in OpenSSL to force the use of
fit,engine-keypair.

Binman will not mess with the local SoftHSMv2 setup as it will only use
tokens from a temporary directory enforced via the temporary
configuration file set via SOFTHSM2_CONF env variable in the tests.

Once signed, it's checked with fit_check_sign with the associated
certificate.

Finally, a new softhsm2_util bintool is added so that we can initialize
the token and import keypairs. On Debian, the package also brings
libsofthsm2 which is required for OpenSSL to interact with SoftHSMv2. It
is not the only package required though, as it also needs p11-kit and
libengine-pkcs11-openssl (the latter bringing the former, only the
latter is explicitly installed), which we can detect with openssl engine
dynamic -c pkcs11. If that fails, we manually install the aforementioned
library packages within tests.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/binman/btool/softhsm2_util.py                |  21 +++
 tools/binman/ftest.py                              | 193 +++++++++++++++++++++
 tools/binman/test/340_dummy-rsa4096.crt            |  31 ++++
 tools/binman/test/340_fit_signature_engine.dts     |  99 +++++++++++
 .../test/340_fit_signature_engine_pkcs11.dts       |  99 +++++++++++
 .../340_fit_signature_engine_pkcs11_object.dts     | 100 +++++++++++
 tools/binman/test/340_openssl.conf                 |  10 ++
 tools/binman/test/340_softhsm2.conf                |  16 ++
 tools/binman/test/Makefile                         |   6 +-
 tools/binman/test/dummy-rsa-engine.c               | 149 ++++++++++++++++
 10 files changed, 723 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/softhsm2_util.py b/tools/binman/btool/softhsm2_util.py
new file mode 100644
index 00000000000..869221d841d
--- /dev/null
+++ b/tools/binman/btool/softhsm2_util.py
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2025 Cherry Embedded Solutions GmbH
+#
+"""Bintool implementation for SoftHSMv2 (softhsm2-util)"""
+
+from binman import bintool
+
+
+class Bintoolsofthsm2_util(bintool.Bintool):
+    """SoftHSMv2 -- support tool for libsofthsm2"""
+    def __init__(self, name):
+        super().__init__('softhsm2-util',
+                         'SoftHSMv2 support tool for libsofthsm2',
+                         version_args='-v')
+
+    def fetch(self, method):
+        """Install softhsm2-util via APT """
+        if method != bintool.FETCH_BIN:
+            return None
+
+        return self.apt_install('softhsm2')
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 925c39a530e..5e114d06b82 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7952,6 +7952,199 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             self.assertIsNotNone(signature)
             self.assertIsNotNone(signature.props.get('value'))
 
+    def testFitSignEngineSimple(self):
+        """Test that image with FIT and signature nodes can be signed with an
+           OpenSSL Engine"""
+        if not elf.ELF_TOOLS:
+            self.skipTest('Python elftools not available')
+        # Make OpenSSL find our dummy-rsa-engine engine
+        os.environ['OPENSSL_ENGINES'] = TestFunctional._elf_testdir
+        entry_args = {
+            'of-list': 'test-fdt1',
+            'default-dt': 'test-fdt1',
+            'atf-bl31-path': 'bl31.elf',
+        }
+
+        x509_pubkey = '340_dummy-rsa4096.crt'
+        data = tools.read_file(self.TestFile(x509_pubkey))
+        self._MakeInputFile('dev.crt', data)
+
+        test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
+        data = self._DoReadFileDtb(
+            '340_fit_signature_engine.dts',
+            entry_args=entry_args,
+            extra_indirs=[test_subdir])[0]
+
+        dtb = fdt.Fdt.FromData(data)
+        dtb.Scan()
+
+        conf = dtb.GetNode('/configurations/conf-uboot-1')
+        self.assertIsNotNone(conf)
+        signature = conf.FindNode('signature')
+        self.assertIsNotNone(signature)
+        self.assertIsNotNone(signature.props.get('value'))
+
+        images = dtb.GetNode('/images')
+        self.assertIsNotNone(images)
+        for subnode in images.subnodes:
+            signature = subnode.FindNode('signature')
+            self.assertIsNotNone(signature)
+            self.assertIsNotNone(signature.props.get('value'))
+
+        some_dtb = tools.get_output_filename('source.dtb')
+        tools.run('fdt_add_pubkey', '-a', 'sha256,rsa4096', '-k', self._indir,
+                  '-n', 'dev', '-r', 'conf', some_dtb)
+        tools.run('fit_check_sign', '-k', some_dtb,
+                  '-f', tools.get_output_filename('fit.fit'))
+
+    def testFitSignPKCS11Simple(self):
+        """Test that image with FIT and signature nodes can be signed with a
+           PKCS11 OpenSSL Engine"""
+        if not elf.ELF_TOOLS:
+            self.skipTest('Python elftools not available')
+        softhsm2_util = bintool.Bintool.create('softhsm2_util')
+        self._CheckBintool(softhsm2_util)
+
+        try:
+            tools.run('openssl', 'engine', 'dynamic', '-c', 'pkcs11')
+        except ValueError:
+            bintool.Bintool.apt_install('libengine-pkcs11-openssl')
+
+        try:
+            tools.run('openssl', 'engine', 'dynamic', '-c', 'pkcs11')
+        except ValueError:
+            self.skipTest('PKCS11 engine setup not functional')
+
+        # Configure SoftHSMv2
+        data = tools.read_file(self.TestFile('340_softhsm2.conf'))
+        softhsm2_conf = self._MakeInputFile('softhsm2.conf', data)
+        softhsm2_tokens_dir = self._MakeInputDir('softhsm2.tokens')
+
+        os.environ['SOFTHSM2_CONF'] = softhsm2_conf
+        with open(softhsm2_conf, 'a') as f:
+            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
+
+        # Generate pubkey DTB with random RSA4096 key
+        _, _, private_key, pubkey_dtb = self._PrepareSignEnv()
+
+        tools.run('softhsm2-util', '--init-token', '--free', '--label',
+                  'U-Boot token', '--pin', '1111', '--so-pin', '222222')
+        tools.run('softhsm2-util', '--import', private_key, '--token',
+                  'U-Boot token', '--label', 'test_key', '--id', '999999',
+                  '--pin', '1111')
+
+        # Make sure the private key can only be accessed through the engine
+        os.remove(private_key)
+
+        # Make OpenSSL use softhsm2 engine
+        os.environ['OPENSSL_CONF'] = self.TestFile('340_openssl.conf')
+
+        entry_args = {
+            'of-list': 'test-fdt1',
+            'default-dt': 'test-fdt1',
+            'atf-bl31-path': 'bl31.elf',
+        }
+
+        test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
+        data = self._DoReadFileDtb(
+            '340_fit_signature_engine_pkcs11.dts',
+            entry_args=entry_args,
+            extra_indirs=[test_subdir])[0]
+
+        dtb = fdt.Fdt.FromData(data)
+        dtb.Scan()
+
+        conf = dtb.GetNode('/configurations/conf-uboot-1')
+        self.assertIsNotNone(conf)
+        signature = conf.FindNode('signature')
+        self.assertIsNotNone(signature)
+        self.assertIsNotNone(signature.props.get('value'))
+
+        images = dtb.GetNode('/images')
+        self.assertIsNotNone(images)
+        for subnode in images.subnodes:
+            signature = subnode.FindNode('signature')
+            self.assertIsNotNone(signature)
+            self.assertIsNotNone(signature.props.get('value'))
+
+        tools.run('fit_check_sign', '-k', pubkey_dtb,
+                  '-f', tools.get_output_filename('fit.fit'))
+
+    def testFitSignPKCS11Object(self):
+        """Test that image with FIT and signature nodes can be signed with a
+           PKCS11 OpenSSL Engine with a specified object="""
+        if not elf.ELF_TOOLS:
+            self.skipTest('Python elftools not available')
+        softhsm2_util = bintool.Bintool.create('softhsm2_util')
+        self._CheckBintool(softhsm2_util)
+
+        try:
+            tools.run('openssl', 'engine', 'dynamic', '-c', 'pkcs11')
+        except ValueError:
+            bintool.Bintool.apt_install('libengine-pkcs11-openssl')
+
+        try:
+            tools.run('openssl', 'engine', 'dynamic', '-c', 'pkcs11')
+        except ValueError:
+            self.skipTest('PKCS11 engine setup not functional')
+
+        # Configure SoftHSMv2
+        data = tools.read_file(self.TestFile('340_softhsm2.conf'))
+        softhsm2_conf = self._MakeInputFile('softhsm2.conf', data)
+        softhsm2_tokens_dir = self._MakeInputDir('softhsm2.tokens')
+
+        os.environ['SOFTHSM2_CONF'] = softhsm2_conf
+        with open(softhsm2_conf, 'a') as f:
+            f.write(f'directories.tokendir = {softhsm2_tokens_dir}')
+
+        # Generate pubkey DTB with random RSA4096 key
+        _, _, private_key, pubkey_dtb = self._PrepareSignEnv()
+
+        tools.run('softhsm2-util', '--init-token', '--free', '--label',
+                  'U-Boot prod token', '--pin', '1234', '--so-pin', '222222')
+        tools.run('softhsm2-util', '--import', private_key, '--token',
+                  'U-Boot prod token', '--label', 'prod', '--id', '999999',
+                  '--pin', '1234')
+
+        # Make sure the private key can only be accessed through the engine
+        os.remove(private_key)
+
+        # Make OpenSSL use softhsm2 engine and configure PIN for token
+        # The PIN is incorrect on purpose, the correct one will be passed by
+        # fit,engine-keydir in the DT via &pin-value=1234
+        os.environ['OPENSSL_CONF'] = self.TestFile('340_openssl.conf')
+
+        entry_args = {
+            'of-list': 'test-fdt1',
+            'default-dt': 'test-fdt1',
+            'atf-bl31-path': 'bl31.elf',
+        }
+
+        test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
+        data = self._DoReadFileDtb(
+            '340_fit_signature_engine_pkcs11_object.dts',
+            entry_args=entry_args,
+            extra_indirs=[test_subdir])[0]
+
+        dtb = fdt.Fdt.FromData(data)
+        dtb.Scan()
+
+        conf = dtb.GetNode('/configurations/conf-uboot-1')
+        self.assertIsNotNone(conf)
+        signature = conf.FindNode('signature')
+        self.assertIsNotNone(signature)
+        self.assertIsNotNone(signature.props.get('value'))
+
+        images = dtb.GetNode('/images')
+        self.assertIsNotNone(images)
+        for subnode in images.subnodes:
+            signature = subnode.FindNode('signature')
+            self.assertIsNotNone(signature)
+            self.assertIsNotNone(signature.props.get('value'))
+
+        tools.run('fit_check_sign', '-k', pubkey_dtb,
+                  '-f', tools.get_output_filename('fit.fit'))
+
     def testFitSignKeyNotFound(self):
         """Test that missing keys raise an error"""
         if not elf.ELF_TOOLS:
diff --git a/tools/binman/test/340_dummy-rsa4096.crt b/tools/binman/test/340_dummy-rsa4096.crt
new file mode 100644
index 00000000000..c426874431b
--- /dev/null
+++ b/tools/binman/test/340_dummy-rsa4096.crt
@@ -0,0 +1,31 @@
+-----BEGIN CERTIFICATE-----
+MIIFZTCCA02gAwIBAgIUHBvjPF93z8GaT9YkFleXIvBtt+8wDQYJKoZIhvcNAQEL
+BQAwQjELMAkGA1UEBhMCWFgxFTATBgNVBAcMDERlZmF1bHQgQ2l0eTEcMBoGA1UE
+CgwTRGVmYXVsdCBDb21wYW55IEx0ZDAeFw0yNTExMTQxMDAxNDRaFw0yNTEyMTQx
+MDAxNDRaMEIxCzAJBgNVBAYTAlhYMRUwEwYDVQQHDAxEZWZhdWx0IENpdHkxHDAa
+BgNVBAoME0RlZmF1bHQgQ29tcGFueSBMdGQwggIiMA0GCSqGSIb3DQEBAQUAA4IC
+DwAwggIKAoICAQC6cUpK5P8J7E+flOwYFI2vh4qQ2mNbDvNfLG0DYMbMuWvWjwd5
+j88UuPCGdptLUL9QGsA0ZreewA3zBh2hAei0ryieYBSq6ez9kG6pAYcI6+c9VCro
+jH9Tv+w/UEtNQUsn40j5c8koAqizEqGpwThM+gm+ftWBVCQHDscI9JXac4V/69OE
+Oegf8NI4FoC/EQqLDVNxlVaSwxFC9ATEEuO9++rdaHiicmGnt27UOsgM9WO+gZpk
+BgicLUp05qFymCwSPsiM6ELT9QYSxAMUi5u6gX2V5d444lSicaaZ2nRQXzOBqnsN
+KQksObV2MiJ//jr3/M83TE23eJun6lACvu/5G/sJzJ+aqzBdpHx1DIGYKkQU5jA7
+n/FrHNAWVdyDhLYfaLOZKq7I/pcOzsjYFAjVbPnbVXqujuYj5YXsFttIo+PXTRzY
+WBsEcBojqxOhEw8SpQOoeVYgvksKrw3u5RDO7XxkogMRuyO/DuBfm0dDvDf3Anlb
+BjCsHHoJAuuOUKidGMkIK37lR6N6NcdZ4g3aSXvjl785/jCzQBl9HnrrGQV5rLHn
+PYQkNAXrW+bXil4m4LB07e0/4aUrV8A/5SMolzWpfSjeFuLliZzBlAORNmtfKmT+
+F1WrNNnzUa11iRKe9JA7X+dBtC/nbxB2liBwzl8KdWNZOAAP5zQdcJQFMQIDAQAB
+o1MwUTAdBgNVHQ4EFgQUy7zUkFMKw/hlJjHqjOYbClVCM3AwHwYDVR0jBBgwFoAU
+y7zUkFMKw/hlJjHqjOYbClVCM3AwDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0B
+AQsFAAOCAgEAGpsQ5klxd4itvbjVCCf9usItnwlhrf6GxwvGpDBEa8oJbkcQNI+9
+GHVVE+/RO3jx/hjBItLUruKK7mmauO1K2qPLKK8nwcGYV2oMTxTbhZD93a61YBVO
+KSWKi5czN8qCU2vkCc9LJM0y2aZzTjVDZCO6b7lYxCZTZcX2Ygcmt3Zv5sv3wrAF
+9h0nv8CD4soqsE31GZmfuSiZ/lfBdX7Awr9WI6t++zOKBSZmxmLhfG+Fplak10Xv
+TR+yOXHmy+aLegUbrsNgH8ktDAyvM7Aq6+EvbTD6lT06T328cA+AWrKRzYcEGjE0
+wdohmfaKoOch3oZNaXR4fiXDuwTBZ6xHsDpa0RDhvu/YhBP50CxQSqQNuURhFYJB
+qBq3E0tpM4cCABBDA8ci2i1ilYb1AeL1LMqYQJXdIa8X5YP1NMdNyMO+4Aizc1J6
+wNvBqItgShvLjBWoQGYWKiiqgz8UoWWMjp0VuKmv0fu/71rbBarg2JDMsC7U5yno
+rsfCDgcLGhemFe2EpvlLd8j+rmzjl4Kx1UGKC0EbqBFFaGj8ZlCu20KHpPYiOzNd
+p2dU6LpeQYvOfQOCMjNe6BPKCxE4FEkQpdXuF2aKq9rlbZtcVeo1W/NDn2JHaDZ2
+BhHQfv/vugdB9E6JtqoQsME4rDkE3+0AxA7qvVkWFnI0cFtHsqZD+N4=
+-----END CERTIFICATE-----
diff --git a/tools/binman/test/340_fit_signature_engine.dts b/tools/binman/test/340_fit_signature_engine.dts
new file mode 100644
index 00000000000..fd374e0edd2
--- /dev/null
+++ b/tools/binman/test/340_fit_signature_engine.dts
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		fit {
+			description = "test desc";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+			fit,sign;
+			fit,engine = "dummy-rsa-engine";
+
+			images {
+				u-boot {
+					description = "test u-boot";
+					type = "standalone";
+					arch = "arm64";
+					os = "u-boot";
+					compression = "none";
+					load = <0x00000000>;
+					entry = <0x00000000>;
+
+					u-boot-nodtb {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa4096";
+						key-name-hint = "dev";
+					};
+				};
+				@atf-SEQ {
+					fit,operation = "split-elf";
+					description = "test tf-a";
+					type = "firmware";
+					arch = "arm64";
+					os = "arm-trusted-firmware";
+					compression = "none";
+					fit,load;
+					fit,entry;
+					fit,data;
+
+					atf-bl31 {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa4096";
+						key-name-hint = "dev";
+					};
+				};
+				@fdt-SEQ {
+					description = "test fdt";
+					type = "flat_dt";
+					compression = "none";
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa4096";
+						key-name-hint = "dev";
+					};
+				};
+			};
+
+			configurations {
+				default = "@conf-uboot-DEFAULT-SEQ";
+				@conf-uboot-SEQ {
+					description = "uboot config";
+					fdt = "fdt-SEQ";
+					fit,firmware = "u-boot";
+					fit,loadables;
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa4096";
+						key-name-hint = "dev";
+						sign-images = "firmware", "loadables", "fdt";
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/340_fit_signature_engine_pkcs11.dts b/tools/binman/test/340_fit_signature_engine_pkcs11.dts
new file mode 100644
index 00000000000..60ba04c13d4
--- /dev/null
+++ b/tools/binman/test/340_fit_signature_engine_pkcs11.dts
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		fit {
+			description = "test desc";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+			fit,sign;
+			fit,engine = "pkcs11";
+
+			images {
+				u-boot {
+					description = "test u-boot";
+					type = "standalone";
+					arch = "arm64";
+					os = "u-boot";
+					compression = "none";
+					load = <0x00000000>;
+					entry = <0x00000000>;
+
+					u-boot-nodtb {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa4096";
+						key-name-hint = "test_key";
+					};
+				};
+				@atf-SEQ {
+					fit,operation = "split-elf";
+					description = "test tf-a";
+					type = "firmware";
+					arch = "arm64";
+					os = "arm-trusted-firmware";
+					compression = "none";
+					fit,load;
+					fit,entry;
+					fit,data;
+
+					atf-bl31 {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa4096";
+						key-name-hint = "test_key";
+					};
+				};
+				@fdt-SEQ {
+					description = "test fdt";
+					type = "flat_dt";
+					compression = "none";
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa4096";
+						key-name-hint = "test_key";
+					};
+				};
+			};
+
+			configurations {
+				default = "@conf-uboot-DEFAULT-SEQ";
+				@conf-uboot-SEQ {
+					description = "uboot config";
+					fdt = "fdt-SEQ";
+					fit,firmware = "u-boot";
+					fit,loadables;
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa4096";
+						key-name-hint = "test_key";
+						sign-images = "firmware", "loadables", "fdt";
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/340_fit_signature_engine_pkcs11_object.dts b/tools/binman/test/340_fit_signature_engine_pkcs11_object.dts
new file mode 100644
index 00000000000..871bf697026
--- /dev/null
+++ b/tools/binman/test/340_fit_signature_engine_pkcs11_object.dts
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		fit {
+			description = "test desc";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+			fit,sign;
+			fit,engine = "pkcs11";
+			fit,engine-keydir = "pkcs11:object=prod&pin-value=1234";
+
+			images {
+				u-boot {
+					description = "test u-boot";
+					type = "standalone";
+					arch = "arm64";
+					os = "u-boot";
+					compression = "none";
+					load = <0x00000000>;
+					entry = <0x00000000>;
+
+					u-boot-nodtb {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa4096";
+						key-name-hint = "test_key";
+					};
+				};
+				@atf-SEQ {
+					fit,operation = "split-elf";
+					description = "test tf-a";
+					type = "firmware";
+					arch = "arm64";
+					os = "arm-trusted-firmware";
+					compression = "none";
+					fit,load;
+					fit,entry;
+					fit,data;
+
+					atf-bl31 {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa4096";
+						key-name-hint = "test_key";
+					};
+				};
+				@fdt-SEQ {
+					description = "test fdt";
+					type = "flat_dt";
+					compression = "none";
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa4096";
+						key-name-hint = "test_key";
+					};
+				};
+			};
+
+			configurations {
+				default = "@conf-uboot-DEFAULT-SEQ";
+				@conf-uboot-SEQ {
+					description = "uboot config";
+					fdt = "fdt-SEQ";
+					fit,firmware = "u-boot";
+					fit,loadables;
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa4096";
+						key-name-hint = "test_key";
+						sign-images = "firmware", "loadables", "fdt";
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/340_openssl.conf b/tools/binman/test/340_openssl.conf
new file mode 100644
index 00000000000..9ab9dc739fe
--- /dev/null
+++ b/tools/binman/test/340_openssl.conf
@@ -0,0 +1,10 @@
+openssl_conf = openssl_init
+
+[openssl_init]
+engines = engine_section
+
+[engine_section]
+pkcs11 = pkcs11_section
+
+[pkcs11_section]
+PIN=1111
diff --git a/tools/binman/test/340_softhsm2.conf b/tools/binman/test/340_softhsm2.conf
new file mode 100644
index 00000000000..dabaacb15a1
--- /dev/null
+++ b/tools/binman/test/340_softhsm2.conf
@@ -0,0 +1,16 @@
+# SoftHSM v2 configuration file
+
+# directories.tokendir = /path/to/binman/test/softhsm2.tokens/
+objectstore.backend = file
+
+# ERROR, WARNING, INFO, DEBUG
+log.level = ERROR
+
+# If CKF_REMOVABLE_DEVICE flag should be set
+slots.removable = false
+
+# Enable and disable PKCS#11 mechanisms using slots.mechanisms.
+slots.mechanisms = ALL
+
+# If the library should reset the state on fork
+library.reset_on_fork = false
diff --git a/tools/binman/test/Makefile b/tools/binman/test/Makefile
index 4d152eee9c0..d5e4c0f556a 100644
--- a/tools/binman/test/Makefile
+++ b/tools/binman/test/Makefile
@@ -35,7 +35,8 @@ LDS_BLOB := -T $(SRC)blob_syms.lds
 TARGETS = u_boot_ucode_ptr u_boot_no_ucode_ptr bss_data bss_data_zero \
 	u_boot_binman_syms u_boot_binman_syms.bin u_boot_binman_syms_bad \
 	u_boot_binman_syms_size u_boot_binman_syms_x86 embed_data \
-	u_boot_binman_embed u_boot_binman_embed_sm elf_sections blob_syms.bin
+	u_boot_binman_embed u_boot_binman_embed_sm elf_sections blob_syms.bin \
+	dummy-rsa-engine.so
 
 all: $(TARGETS)
 
@@ -84,6 +85,9 @@ blob_syms: blob_syms.c
 elf_sections: CFLAGS += $(LDS_EFL_SECTIONS)
 elf_sections: elf_sections.c
 
+dummy-rsa-engine.so: dummy-rsa-engine.c
+	$(CC) -fPIC -shared -lcrypto -lssl -o $@ $<
+
 clean:
 	rm -f $(TARGETS)
 
diff --git a/tools/binman/test/dummy-rsa-engine.c b/tools/binman/test/dummy-rsa-engine.c
new file mode 100644
index 00000000000..d163e917a8b
--- /dev/null
+++ b/tools/binman/test/dummy-rsa-engine.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Dummy RSA OpenSSL engine to test whether engines work with mkimage
+ *
+ * OpenSSL can call it with 'dummy-rsa'. The only supported key_id is "dev".
+ */
+
+#define OPENSSL_API_COMPAT 0x10101000L
+
+#include <openssl/engine.h>
+
+#define OPENSSL_SUPPRESS_DEPRECATED
+
+static const char *engine_dummy_rsa_id = "dummy-rsa-engine";
+static const char *engine_dummy_rsa_name = "Dummy RSA engine";
+
+/* RSA4096 private key */
+static const char n[] =
+"\x00\xba\x71\x4a\x4a\xe4\xff\x09\xec\x4f\x9f\x94\xec\x18\x14"
+"\x8d\xaf\x87\x8a\x90\xda\x63\x5b\x0e\xf3\x5f\x2c\x6d\x03\x60"
+"\xc6\xcc\xb9\x6b\xd6\x8f\x07\x79\x8f\xcf\x14\xb8\xf0\x86\x76"
+"\x9b\x4b\x50\xbf\x50\x1a\xc0\x34\x66\xb7\x9e\xc0\x0d\xf3\x06"
+"\x1d\xa1\x01\xe8\xb4\xaf\x28\x9e\x60\x14\xaa\xe9\xec\xfd\x90"
+"\x6e\xa9\x01\x87\x08\xeb\xe7\x3d\x54\x2a\xe8\x8c\x7f\x53\xbf"
+"\xec\x3f\x50\x4b\x4d\x41\x4b\x27\xe3\x48\xf9\x73\xc9\x28\x02"
+"\xa8\xb3\x12\xa1\xa9\xc1\x38\x4c\xfa\x09\xbe\x7e\xd5\x81\x54"
+"\x24\x07\x0e\xc7\x08\xf4\x95\xda\x73\x85\x7f\xeb\xd3\x84\x39"
+"\xe8\x1f\xf0\xd2\x38\x16\x80\xbf\x11\x0a\x8b\x0d\x53\x71\x95"
+"\x56\x92\xc3\x11\x42\xf4\x04\xc4\x12\xe3\xbd\xfb\xea\xdd\x68"
+"\x78\xa2\x72\x61\xa7\xb7\x6e\xd4\x3a\xc8\x0c\xf5\x63\xbe\x81"
+"\x9a\x64\x06\x08\x9c\x2d\x4a\x74\xe6\xa1\x72\x98\x2c\x12\x3e"
+"\xc8\x8c\xe8\x42\xd3\xf5\x06\x12\xc4\x03\x14\x8b\x9b\xba\x81"
+"\x7d\x95\xe5\xde\x38\xe2\x54\xa2\x71\xa6\x99\xda\x74\x50\x5f"
+"\x33\x81\xaa\x7b\x0d\x29\x09\x2c\x39\xb5\x76\x32\x22\x7f\xfe"
+"\x3a\xf7\xfc\xcf\x37\x4c\x4d\xb7\x78\x9b\xa7\xea\x50\x02\xbe"
+"\xef\xf9\x1b\xfb\x09\xcc\x9f\x9a\xab\x30\x5d\xa4\x7c\x75\x0c"
+"\x81\x98\x2a\x44\x14\xe6\x30\x3b\x9f\xf1\x6b\x1c\xd0\x16\x55"
+"\xdc\x83\x84\xb6\x1f\x68\xb3\x99\x2a\xae\xc8\xfe\x97\x0e\xce"
+"\xc8\xd8\x14\x08\xd5\x6c\xf9\xdb\x55\x7a\xae\x8e\xe6\x23\xe5"
+"\x85\xec\x16\xdb\x48\xa3\xe3\xd7\x4d\x1c\xd8\x58\x1b\x04\x70"
+"\x1a\x23\xab\x13\xa1\x13\x0f\x12\xa5\x03\xa8\x79\x56\x20\xbe"
+"\x4b\x0a\xaf\x0d\xee\xe5\x10\xce\xed\x7c\x64\xa2\x03\x11\xbb"
+"\x23\xbf\x0e\xe0\x5f\x9b\x47\x43\xbc\x37\xf7\x02\x79\x5b\x06"
+"\x30\xac\x1c\x7a\x09\x02\xeb\x8e\x50\xa8\x9d\x18\xc9\x08\x2b"
+"\x7e\xe5\x47\xa3\x7a\x35\xc7\x59\xe2\x0d\xda\x49\x7b\xe3\x97"
+"\xbf\x39\xfe\x30\xb3\x40\x19\x7d\x1e\x7a\xeb\x19\x05\x79\xac"
+"\xb1\xe7\x3d\x84\x24\x34\x05\xeb\x5b\xe6\xd7\x8a\x5e\x26\xe0"
+"\xb0\x74\xed\xed\x3f\xe1\xa5\x2b\x57\xc0\x3f\xe5\x23\x28\x97"
+"\x35\xa9\x7d\x28\xde\x16\xe2\xe5\x89\x9c\xc1\x94\x03\x91\x36"
+"\x6b\x5f\x2a\x64\xfe\x17\x55\xab\x34\xd9\xf3\x51\xad\x75\x89"
+"\x12\x9e\xf4\x90\x3b\x5f\xe7\x41\xb4\x2f\xe7\x6f\x10\x76\x96"
+"\x20\x70\xce\x5f\x0a\x75\x63\x59\x38\x00\x0f\xe7\x34\x1d\x70"
+"\x94\x05\x31";
+
+static const char e[] = "\x01\x00\x01";
+
+static const char d[] =
+"\x2e\xad\xfb\xbc\x59\xae\x53\x35\x33\xd0\x50\x30\x76\x6c\xfa"
+"\xf6\x76\x38\xa6\xc0\xce\xfc\x76\xf7\x4f\x1e\x67\xe2\xdf\x21"
+"\x97\x13\x5b\xa1\x1a\x29\x74\x71\xa1\x96\xde\x20\xf6\x81\x8e"
+"\xab\x22\x39\xec\x1b\xee\x80\x90\x31\x2c\x11\x88\xcc\x8e\x7c"
+"\xef\x99\x73\x42\x7d\xd2\x6d\x28\xc0\x33\xf4\xa2\xad\xef\xb2"
+"\x0d\x25\x81\x42\x26\x12\x3c\xe4\x2c\x64\x11\xfd\x35\x22\x49"
+"\xcb\xa6\x56\x5c\x2e\xdb\x5a\xce\xc8\xb0\x10\x21\xce\x9f\x2f"
+"\xce\xb9\xfc\xf8\xec\x14\x25\x0d\xbb\x4f\xd3\x20\xb0\xa3\x38"
+"\xeb\xfd\x72\xae\xd6\xd2\x08\x22\x41\x4c\x00\x66\xf2\x65\xaf"
+"\x2d\x04\x16\x16\x0d\xe8\x49\x2e\x42\x96\x03\x0d\x9f\xd4\x14"
+"\x9b\x65\x34\x96\xaf\x52\xdc\x26\xa0\x97\xaa\x11\xa9\x42\xa5"
+"\x65\x82\xbe\xd9\x87\x8f\x3b\x9a\xc6\x08\x9c\x8d\xcf\x1e\x52"
+"\xe1\xf5\x32\xc5\xab\x7f\x47\x5a\x91\x14\x88\x6e\x0c\x59\x64"
+"\xcc\x06\xc0\xe8\xa1\xa1\xd6\x23\xf6\x63\x77\xfa\xd3\x0c\xe5"
+"\xbd\x18\x92\xf5\x6a\x11\x67\xa4\x8d\xe2\x5a\x74\x21\xc5\x5c"
+"\x37\x7c\x50\x17\xc0\xec\xf7\x82\x31\x61\x38\xf7\x33\x55\x9b"
+"\x3d\x08\xb2\x76\xf5\x67\x45\xe6\xf0\x0d\xf0\x17\xfd\x40\x02"
+"\x03\xce\x82\xc4\xa5\xa9\xcb\x8b\x9b\x68\x6a\x27\xed\x3a\xb7"
+"\xd2\x60\x93\x48\x55\x8c\x87\xc9\x8c\xbd\x97\x24\xd2\x2f\xd1"
+"\xc2\x7c\xec\xa7\x4d\x67\x5d\xd4\xfd\xaf\x91\x15\xdd\x57\xcb"
+"\x17\xea\xcf\xfc\x84\x19\xd6\x27\x08\xa3\xef\xdc\xe4\x9b\xf6"
+"\xea\x72\x37\xb0\xc7\xbc\xe0\xc6\x39\xf8\x89\x1b\xde\x84\xad"
+"\xb7\x4f\xf0\xef\x87\x0c\xfe\x5d\x9b\xfd\xee\x6a\x68\xdb\x1f"
+"\xc7\x9b\x23\x8f\x1a\xf1\xe8\x3f\x17\xd5\x58\x5f\x0b\x8c\x92"
+"\xf4\xc7\x5f\x3c\x71\xa7\xac\xdd\xa3\x3a\x5f\x4f\xc0\xf1\x4c"
+"\x8f\x3f\x63\x93\x27\x1b\xbe\xc9\xc1\x5f\x04\xf9\xff\x0f\x36"
+"\x62\x6c\x3b\x65\xb3\xa8\xb4\x78\xa8\xab\xae\x3e\xf5\x61\x67"
+"\xc1\x9f\xcf\x41\x19\xdc\x21\x7d\x83\xfb\x1b\xcc\x92\x6e\xf8"
+"\x70\xcb\xb4\xb2\xc3\x1e\xbe\xaf\x91\xf8\xc8\x32\x17\xad\x82"
+"\x62\x70\x70\xe2\x31\x34\x0b\xd0\xe2\x71\xc8\x8b\x8f\xee\xcd"
+"\xa1\x00\x91\x84\x18\x04\xd0\x9e\x21\xd9\x5c\xcd\xf9\x4e\x75"
+"\x32\x81\x1d\xf3\xe7\x41\xfc\x22\xcd\x3b\x88\x09\xae\xb5\xc5"
+"\x5f\x5c\x25\x65\x71\xfb\x61\xd0\x8c\xc8\x53\xee\xee\x83\xdf"
+"\x41\xf8\x96\xda\x5f\x06\x21\x87\xf8\xe4\x07\xe7\xf5\xdb\xc0"
+"\x3e\x9b";
+
+static EVP_PKEY *dummy_rsa_ossl_load_privkey(ENGINE *eng, const char *key_id,
+					     UI_METHOD *ui_method,
+					     void *callback_data)
+{
+	EVP_PKEY *pkey = NULL;
+	RSA *rsa = NULL;
+
+	if (strncmp(key_id, "dev", 3))
+		return NULL;
+
+	pkey = EVP_PKEY_new();
+	if (!pkey)
+		goto pkey_err;
+
+	rsa = RSA_new();
+	if (!rsa)
+		goto err;
+
+	if (!EVP_PKEY_assign_RSA(pkey, rsa))
+		goto err;
+
+	if (!RSA_set0_key(rsa,
+			  BN_bin2bn(n, sizeof(n) - 1, NULL),
+			  BN_bin2bn(e, sizeof(e) - 1, NULL),
+			  BN_bin2bn(d, sizeof(d) - 1, NULL)))
+		goto err;
+
+	return pkey;
+
+pkey_err:
+	EVP_PKEY_free(pkey);
+err:
+	RSA_free(rsa);
+	return NULL;
+}
+
+static int bind_helper(ENGINE *e, const char *id)
+{
+	const RSA_METHOD *rsa_default_meth = RSA_get_default_method();
+	RSA_METHOD *dummy_rsa_meth;
+
+	if (id && strcmp(id, engine_dummy_rsa_id))
+		return 0;
+
+	dummy_rsa_meth = RSA_meth_dup(rsa_default_meth);
+
+	ENGINE_set_load_privkey_function(e, dummy_rsa_ossl_load_privkey);
+
+	return ENGINE_set_id(e, engine_dummy_rsa_id) &&
+		ENGINE_set_name(e, engine_dummy_rsa_name) &&
+		ENGINE_set_RSA(e, dummy_rsa_meth);
+}
+
+IMPLEMENT_DYNAMIC_CHECK_FN()
+IMPLEMENT_DYNAMIC_BIND_FN(bind_helper)

-- 
2.51.1

