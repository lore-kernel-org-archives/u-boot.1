Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08434C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 11:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F78883121;
	Fri, 18 Apr 2025 13:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99938830B4; Fri, 18 Apr 2025 13:26:26 +0200 (CEST)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [83.166.143.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 781B382C15
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 13:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZfCBm10P1zndj;
 Fri, 18 Apr 2025 13:26:24 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4ZfCBl0wyfzS45; Fri, 18 Apr 2025 13:26:23 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 18 Apr 2025 13:26:08 +0200
Subject: [PATCH v2 2/2] binman: etype: u_boot_spl_pubkey_dtb: provide more
 explicit error for key-name-hint with path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-binman-pubkey-dir-v2-2-b6b90a765ffe@cherry.de>
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

key-name-hint property in u-boot-spl-pubkey-dtb binman entry may contain
a path instead of a filename due to user mistake.

Because we currently assume it is a filename instead of a path, binman
will find the full path to the key based on that path, and return the
dirname of the full path but keeps the path in key-name-hint instead of
stripping the directories from it.

This means mkimage will fail with the following error message if we have
key-name-hint set to keys/dev:

binman: Error 1 running 'fdt_add_pubkey -a sha256,rsa2048 -k /home/qschulz/work/upstream/u-boot/keys -n keys/dev -r conf /home/qschulz/work/upstream/u-boot/build/ringneck/u-boot-spl-dtbdhsfx3mf': Couldn't open RSA certificate: '/home/qschulz/work/upstream/u-boot/keys/keys/dev.crt': No such file or directory

Let's make it a bit more obvious what the error is by erroring out in
binman if a path is provided in key-name-hint (it is named key-name-hint
and not key-path-hint after all).

Fixes: 5609843b57a4 ("binman: etype: Add u-boot-spl-pubkey-dtb etype")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/binman/etype/u_boot_spl_pubkey_dtb.py              |  2 ++
 tools/binman/ftest.py                                    |  7 +++++++
 .../binman/test/348_key_name_hint_dir_spl_pubkey_dtb.dts | 16 ++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/tools/binman/etype/u_boot_spl_pubkey_dtb.py b/tools/binman/etype/u_boot_spl_pubkey_dtb.py
index cb196061de28610eb785fb44c887982e3979659f..3061c4bcdc4be5663696ed056ac6a55f30dc8676 100644
--- a/tools/binman/etype/u_boot_spl_pubkey_dtb.py
+++ b/tools/binman/etype/u_boot_spl_pubkey_dtb.py
@@ -87,6 +87,8 @@ class Entry_u_boot_spl_pubkey_dtb(Entry_blob_dtb):
                                          dir=tools.get_output_dir())\
                                               as pubkey_tdb:
             tools.write_file(pubkey_tdb.name, self.GetData())
+            if '/' in self._key_name_hint:
+                self.Raise(f"'{self._key_name_hint}' is a path not a filename")
             keyname = tools.get_input_filename(self._key_name_hint + ".crt")
             self.fdt_add_pubkey.run(pubkey_tdb.name,
                                     os.path.dirname(keyname),
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 5ea15b36a717a3bfe8fade3892e4039c046d2102..1b68f4b51cfb257c700abde069cc705d3327ed82 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7274,6 +7274,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                          tools.to_bytes(''.join(node.props['key'].value)))
         self.assertNotIn('key-source', node.props)
 
+    def testKeyNameHintIsPathSplPubkeyDtb(self):
+        """Test that binman errors out on key-name-hint being a path"""
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('348_key_name_hint_dir_spl_pubkey_dtb.dts')
+        self.assertIn(
+            'Node \'/binman/u-boot-spl-pubkey-dtb\': \'keys/key\' is a path not a filename',
+            str(e.exception))
 
     def testSplPubkeyDtb(self):
         """Test u_boot_spl_pubkey_dtb etype"""
diff --git a/tools/binman/test/348_key_name_hint_dir_spl_pubkey_dtb.dts b/tools/binman/test/348_key_name_hint_dir_spl_pubkey_dtb.dts
new file mode 100644
index 0000000000000000000000000000000000000000..85ebd58b6c0cd18fc385f63dd95da2e414705249
--- /dev/null
+++ b/tools/binman/test/348_key_name_hint_dir_spl_pubkey_dtb.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		u-boot-spl-pubkey-dtb {
+			algo = "sha384,rsa4096";
+			required = "conf";
+			key-name-hint = "keys/key";
+		};
+	};
+};

-- 
2.49.0

