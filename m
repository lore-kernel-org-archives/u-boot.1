Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296DAC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 11:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9A2882C8A;
	Fri, 18 Apr 2025 13:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43ED682EBE; Fri, 18 Apr 2025 13:26:25 +0200 (CEST)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [84.16.66.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30EC882E25
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 13:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZfCBk60c3zmBR;
 Fri, 18 Apr 2025 13:26:22 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4ZfCBj6BJJzRTt; Fri, 18 Apr 2025 13:26:21 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 18 Apr 2025 13:26:07 +0200
Subject: [PATCH v2 1/2] binman: etype: fit: raise ValueError if
 key-name-hint is a path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-binman-pubkey-dir-v2-1-b6b90a765ffe@cherry.de>
References: <20250418-binman-pubkey-dir-v2-0-b6b90a765ffe@cherry.de>
In-Reply-To: <20250418-binman-pubkey-dir-v2-0-b6b90a765ffe@cherry.de>
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Alexander Kochetkov <al.kochet@gmail.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
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

mkimage doesn't fail if it cannot find the public key but it prints to
stderr. Considering that btool.run() discards stderr, it means binman
happily returns an unsigned FIT and doesn't tell you something went
wrong.

Binman will actually find the file if there's a path in the
key-name-hint property but the current logic expects key-name-hint to be
a filename and thus returns the dirname of the found path for the key,
but with the original key-name-hint appended. This means we can have the
following:

- key-name-hint = "keys/dev"
- name = "/home/qschulz/work/upstream/u-boot/keys/"

so we pass /home/qschulz/work/upstream/u-boot/keys/ to the -k option of
mkimage but the FIT still contains "keys/dev" in key-name-hint which
means mkimage will try to find the key at
/home/qschulz/work/upstream/u-boot/keys/keys/, which doesn't exist.

Let's assume paths are simply not supported (it is named key-name-hint
and not key-path-hint after all) and raise an error if the property
contains a path so that the build fails and not quietly.

Fixes: 133c000ca334 ("binman: implement signing FIT images during image build")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/binman/etype/fit.py                          |  3 +
 tools/binman/ftest.py                              | 18 ++++
 .../test/347_key_name_hint_dir_fit_signature.dts   | 98 ++++++++++++++++++++++
 3 files changed, 119 insertions(+)

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 803fb66ea838f1f02da7fa42c121057de31ec2ef..284b19c4b882a91e4320e1c8267c3e6d935d8a00 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -557,6 +557,7 @@ class Entry_fit(Entry_section):
         Raises:
             ValueError: Filename 'rsa2048.key' not found in input path
             ValueError: Multiple key paths found
+            ValueError: 'dir/rsa2048' is a path not a filename
         """
         def _find_keys_dir(node):
             for subnode in node.subnodes:
@@ -565,6 +566,8 @@ class Entry_fit(Entry_section):
                     if subnode.props.get('key-name-hint') is None:
                         continue
                     hint = subnode.props['key-name-hint'].value
+                    if '/' in hint:
+                        self.Raise(f"'{hint}' is a path not a filename")
                     name = tools.get_input_filename(
                         f"{hint}.key" if subnode.name.startswith('signature')
                         else f"{hint}.bin")
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 948fcc02259ae61d8f7ff8d4ec8b867c7f513bbf..5ea15b36a717a3bfe8fade3892e4039c046d2102 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7940,6 +7940,24 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             entry_args=entry_args,
             extra_indirs=[test_subdir])[0]
 
+    def testKeyNameHintIsPathSimpleFit(self):
+        """Test that binman errors out on key-name-hint being a path"""
+        if not elf.ELF_TOOLS:
+            self.skipTest('Python elftools not available')
+        entry_args = {
+            'of-list': 'test-fdt1',
+            'default-dt': 'test-fdt1',
+            'atf-bl31-path': 'bl31.elf',
+        }
+        test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFileDtb(
+                    '347_key_name_hint_dir_fit_signature.dts',
+                    entry_args=entry_args,
+                    extra_indirs=[test_subdir])
+        self.assertIn(
+            'Node \'/binman/fit\': \'keys/rsa2048\' is a path not a filename',
+            str(e.exception))
 
     def testSimpleFitEncryptedData(self):
         """Test an image with a FIT containing data to be encrypted"""
diff --git a/tools/binman/test/347_key_name_hint_dir_fit_signature.dts b/tools/binman/test/347_key_name_hint_dir_fit_signature.dts
new file mode 100644
index 0000000000000000000000000000000000000000..96e2126dadb319732b2a94769f1b20eaecc045e0
--- /dev/null
+++ b/tools/binman/test/347_key_name_hint_dir_fit_signature.dts
@@ -0,0 +1,98 @@
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
+						algo = "sha256,rsa2048";
+						key-name-hint = "keys/rsa2048";
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
+						algo = "sha256,rsa2048";
+						key-name-hint = "keys/rsa2048";
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
+						algo = "sha256,rsa2048";
+						key-name-hint = "keys/rsa2048";
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
+						algo = "sha256,rsa2048";
+						key-name-hint = "keys/rsa2048";
+						sign-images = "firmware", "loadables", "fdt";
+					};
+				};
+			};
+		};
+	};
+};

-- 
2.49.0

