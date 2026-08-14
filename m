Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4A6C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 17:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73C78608D6;
	Fri, 14 Aug 2026 17:08:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mvWWG0I83cmA; Fri, 14 Aug 2026 17:08:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C07E760892
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786727300;
	bh=NUc68/AZiXvpyyjCOxCRzL+1SS7jQNb5IR9xYxKx6D0=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=bRjzA0Iy2L2h1z4J3i/9W5AK2CObpSGmiBTldQjs5XST6JXeIsOUb9vA9ChpC67Wn
	 PyJ2YeyLETfFe2K/C3bawFCnHFGtnkedbOpMl5gbdfyne/P3j3Ljw94bn0/4Idfuyx
	 BhDNYlNMDDOqkKNKEPNKJEfzAsJS+wNHWFDGU9WqKGwEcPx71haEvd1gUk/QqzWp2p
	 y5EDOvbajWx4Esr9z18NWAa5ICOu2hRvmgrcXtPRliSP6K+zpsg6xNmyahDrIr5wIe
	 a8j+xMVUU1hLXtrLM+WCnjkG3vzIZ2KXiRqR/1NUztE8FaUfJIIlScyapW03WYEGWw
	 gnlEmw6ynUq+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C07E760892;
	Fri, 14 Aug 2026 17:08:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B3CD3194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:08:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1BC660892
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:08:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id torS7gKcYdKL for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 17:08:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7D45F60837
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D45F60837
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D45F60837
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:08:18 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id BD5B11A1647;
 Fri, 14 Aug 2026 17:08:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 92BFA6046D;
 Fri, 14 Aug 2026 17:08:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3B8E711C4EF21; 
 Fri, 14 Aug 2026 19:08:09 +0200 (CEST)
Date: Fri, 14 Aug 2026 19:07:14 +0200
Subject: [PATCH 5/5] binman: test: add code coverage for nxp_imx93cst etype
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260814-imx93-secureboot-v1-5-0c3c78020d03@bootlin.com>
References: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
In-Reply-To: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Denis Mukhin <dmukhin@ford.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Alice Guo <alice.guo@nxp.com>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marex.vasut@mailbox.org>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6319;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=DrvRBZmbd4mxp+KYdC3INweCDgFmv2nw/fjAIWJHdYg=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqf0tUszWcF4EqHNaaEaX1CdZKQ5zMT+RJGdqON
 5yopGqDGHmJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCan9LVAAKCRArAF6gG1qP
 A94nEACVljBQDHDuZEoSDmqxc2yFbdEYlbTEbQYl4le/dBd1yCHvjaGRsFfjvycuK1nN2wvtBuC
 rzqPB4PV7L+51zZfBnN8NLx1S9WVEBOcdD6DhY3ZLgjoagJmN5vxhBQlYVVz4mbm0oLO+4hAdru
 6MJ53tuX34zGu8NUa0/EfGK73VUrvFJVM9Hqo8PPfX/vg66MFF+qIxzlX/HPjXPkhNiQxc4ZJu0
 OI0yXh0xfsFnFnqkQ7G5NyRcnUv5GGdk8vW325y7BCr/xMP63Wuk85LvtvezmSu8W4gHCyxjOAf
 A8+PEwlZ81GbEiKzMoUgHLhuGx75CYiBu2uk68j5uXRNkQzDYoGq5AHP2Pmlx386hMK5YbWJ2Iz
 PqzFflOxgnDpnZS/mXEO/Qd8xTV0M1nxoPY/eQDG5Kao+hzu4h7z6asgME2eVDOoJsbEqjzp+kL
 ptIJQrf9AkwYLXQsOY2DWBRlZFkEiG0sxddCdAuuPe4L2dgsofCPTmXJ6LTFqtIyGqF64LZ4+RI
 JaGMov6np1LR4h5Ti0b8lnzmKjpJgtO0e1hTNg+tcpMbxgJtY5Yf8/CtcRSRZbz75aVWvAlN3lB
 bF9ADazcXn2i/IJ1PEV50/Dyq4A0xgLydtjb0nv0Sp9LCk81LUVoJnTwY7LXZpHvTQttDzqGenY
 ZVZ6w47T0BDwv5w==
X-Developer-Key: i=jeremie.dautheribes@bootlin.com; a=openpgp;
 fpr=FB14AD9086DBB842904804092B005EA01B5A8F03
X-Last-TLS-Session-Version: TLSv1.3
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29_via_U-Bo?=
 =?utf-8?q?ot?= <u-boot@lists.u-boot-project.org>
Reply-To: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add test methods to cover all code paths of the nxp_imx93cst etype,
reusing the pattern of the nxp_imx8mcst as done in commit 0cab35362d77
("binman: test: Fix code coverage for iMX8 and cst bintool") by Simon
Glass.

This brings nxp_imx93cst to 100% coverage.

Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 tools/binman/ftest.py                              | 78 ++++++++++++++++++++++
 tools/binman/test/vendor/nxp_imx93_csf.dts         | 18 +++++
 .../binman/test/vendor/nxp_imx93_csf_imagename.dts | 24 +++++++
 3 files changed, 120 insertions(+)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 66695a83508..ee5c027e0ea 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -35,6 +35,7 @@ from dtoc import fdt
 from dtoc import fdt_util
 from binman.etype import fdtmap
 from binman.etype import image_header
+from binman.etype import nxp_imx93cst
 from binman.image import Image
 from u_boot_pylib import command
 from u_boot_pylib import terminal
@@ -8152,6 +8153,83 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             result = cst.fetch(bintool.FETCH_BUILD)
             self.assertEqual(('cst', None), result)
 
+    def testNxpImx93cstNormal(self):
+        """Test CST signing with an i.MX93 SPL container (no ELE FW)"""
+        # Create a fake AHAB SPL container: tag at offset 3, image-entry
+        # flags at offset 40 whose low byte is the A55 core/type (0x23),
+        # and the signature block offset at offset 12
+        spl_data = bytearray(64)
+        spl_data[3] = nxp_imx93cst.CONTAINER_HDR_TAG
+        spl_data[12:14] = struct.pack('<H', 0x90)
+        spl_data[40:44] = struct.pack('<I', 0x123)
+        self._MakeInputFile('imx93-container.bin', bytes(spl_data))
+
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('vendor/nxp_imx93_csf.dts',
+                             force_missing_bintools='cst')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
+
+    def testNxpImx93cstELE(self):
+        """Test CST signing with an i.MX93 SPL container including the ELE
+        FW"""
+        # Create a fake AHAB image starting with the NXP-signed ELE
+        # container. The low byte of the first image entry flags (0x66) is
+        # the ELE core/type, so the SPL container header is at 0x400
+        ele_data = bytearray(0x410)
+        ele_data[3] = nxp_imx93cst.CONTAINER_HDR_TAG
+        ele_data[40:44] = struct.pack('<I', 0x866)
+        ele_data[0x400 + 3] = nxp_imx93cst.CONTAINER_HDR_TAG
+        ele_data[0x400 + 12:0x400 + 14] = struct.pack('<H', 0x90)
+        self._MakeInputFile('imx93-container.bin', bytes(ele_data))
+
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('vendor/nxp_imx93_csf.dts',
+                             force_missing_bintools='cst')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
+
+    def testNxpImx93cstUnknownTag(self):
+        """Test CST with unknown input tag passes data through"""
+        # Trigger the pass-through path using an input without the AHAB
+        # container tag
+        data = b'\x00' * 64
+        self._MakeInputFile('imx93-container.bin', data)
+        self._DoTestFile('vendor/nxp_imx93_csf.dts',
+                         force_missing_bintools='cst')
+
+    def testNxpImx93cstSigned(self):
+        """Test CST-signing-success path with mocked cst invocation"""
+        spl_data = bytearray(64)
+        spl_data[3] = nxp_imx93cst.CONTAINER_HDR_TAG
+        spl_data[12:14] = struct.pack('<H', 0x90)
+        spl_data[40:44] = struct.pack('<I', 0x123)
+        self._MakeInputFile('imx93-container.bin', bytes(spl_data))
+
+        # Mock run_cmd() so that when cst is invoked, it creates a fake
+        # output blob and returns success, thus covering the signing path
+        original = bintool.Bintool.run_cmd
+
+        def fake_cst_run_cmd(self_tool, *args, binary=False):
+            if self_tool.name == 'cst':
+                arg_list = list(args)
+                if '-o' in arg_list:
+                    idx = arg_list.index('-o')
+                    tools.write_file(arg_list[idx + 1], b'\x00' * 32)
+                return 'fake cst output'
+            return original(self_tool, *args, binary=binary)
+
+        with unittest.mock.patch.object(bintool.Bintool, 'run_cmd',
+                                        new=fake_cst_run_cmd):
+            data = self._DoReadFile('vendor/nxp_imx93_csf.dts')
+
+    def testNxpImx93ImageSizeNone(self):
+        """Test SetImagePos() early return when an entry has no size"""
+        # The imagename entry is in GetEntries() but not packed, so has
+        # size=None, which triggers the early-return guard in SetImagePos()
+        self._DoTestFile('vendor/nxp_imx93_csf_imagename.dts',
+                         force_missing_bintools='mkimage')
+
     def testNxpImx8MFSPI(self):
         """Test that binman can produce an iMX8m FSPI image"""
         self._DoTestFile('vendor/nxp_imx8m_fspi.dts')
diff --git a/tools/binman/test/vendor/nxp_imx93_csf.dts b/tools/binman/test/vendor/nxp_imx93_csf.dts
new file mode 100644
index 00000000000..bbe8eda4b70
--- /dev/null
+++ b/tools/binman/test/vendor/nxp_imx93_csf.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		nxp-imx93cst {
+			args;
+
+			blob {
+				filename = "imx93-container.bin";
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/vendor/nxp_imx93_csf_imagename.dts b/tools/binman/test/vendor/nxp_imx93_csf_imagename.dts
new file mode 100644
index 00000000000..13009438ee8
--- /dev/null
+++ b/tools/binman/test/vendor/nxp_imx93_csf_imagename.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		nxp-imx93cst {
+			args;
+
+			u-boot {
+			};
+
+			imagename {
+				type = "section";
+
+				u-boot {
+				};
+			};
+		};
+	};
+};

-- 
2.55.0

