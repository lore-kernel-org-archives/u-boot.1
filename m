Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C03C624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D9E180FC6;
	Wed,  2 Sep 2026 13:42:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YOjBh3aoXVI8; Wed,  2 Sep 2026 13:42:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788356550;
	bh=s8WcAu5dpeIWRaqYcYpRKPntOW8SV7IlcygdeD0uPc0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v+npI2OUxLiP9IBCETlCPH4eIfCfUh8WqdCn3HpIpUUrd2ZjizKq75ceR8MeKf+Z6
	 nUKpyuQS5KPoe6b8y3oCdq30O28NyPn80rqMPxclTH9dvFE2QKJcStmTVOLdehSXlO
	 U74t6Nzn+qOFd4qE91eNtiGAoQAfMu4T+qgkRNECrA3OLvddBlGjSOEaD80nvIQzM4
	 z33aNFg+28CeaFoSZ+GsW8sm4J5ov0kNSH+YaHS6O6fV37ydNA7tWcEG01hKoTg+pt
	 17CdZ02arMJwlSDxj1SKUEgDr0zDUsJyohx8uW4jjsOCubLbqU0eYFoFwqlZMmdmnM
	 wKS5wR8q9uGfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C7E580EEC;
	Wed,  2 Sep 2026 13:42:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 29A86498
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B3C14006F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:42:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ERAAHGTurlSS for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:42:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=ehU9QByk
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 123404004D
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:42:25 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 539251A195E;
 Wed,  2 Sep 2026 13:42:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 277396053C;
 Wed,  2 Sep 2026 13:42:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7D76E11C792E0; 
 Wed,  2 Sep 2026 15:42:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788356542; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=s8WcAu5dpeIWRaqYcYpRKPntOW8SV7IlcygdeD0uPc0=;
 b=ehU9QBykdxVWewgdJQ6Cp4iEFOhCYertIdalO2f1rqO6kmRx+xACKinNw4gfqII52VTJI2
 hnkVoJXVbubxYRDTj3tb/g0rfuRPW4m05EaZM2sfoDLD9mJTNpxBocKfpCjxEZjISydz9l
 c1Mwf/IJ7svdnoM/nzGP5/pFqFD5xhBoqAybqlKtRcLgCCyPlayJ0yubf6GPG4baXrVZSm
 bI02242yEKss9ubKHhsL3WfVgEfz3di9WGQ90LNibgDVUxtnlvdsVPvcN8aSwlRuOYkbPz
 YDEf2NuLmqIIi6uxGxhkuBPXDh1X/p7ZtGZe2XCOGNDu+6Nmhy2p9g9gBVhkfg==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Wed, 02 Sep 2026 15:41:34 +0200
Subject: [PATCH v2 7/7] binman: test: add code coverage for nxp_imx93cst etype
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260902-imx93-secureboot-v2-7-5947b92a5072@bootlin.com>
References: <20260902-imx93-secureboot-v2-0-5947b92a5072@bootlin.com>
In-Reply-To: <20260902-imx93-secureboot-v2-0-5947b92a5072@bootlin.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christophe Guerreiro <christophe.guerreiro@non.se.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6687;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=PVxckJoGYSHJHRSpuIM0Pu+vZjbH6wMSZjEMyybi9Ek=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqmCeVCOm2XjTApUCbZ5sPhht8n8bNVcNKmRefx
 ds/SKCoRMqJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCapgnlQAKCRArAF6gG1qP
 A8XZD/9P4ipQLxypeXXonN0MPak++oORoh8YToU/ALCF2mTyOpheywhaFKMY5xns8SBnyKhLRbr
 BLBpkBvCEGsf2+lRKwo/elhekrTfbF5FyaugthAEYtpV8rEVT/VW/TQZO9P7flGTPQSLxyF4DkS
 k6IKC7BLZwCVTIWx3P/kC/OnVEBeKcqvl1IZnmLUrfMFCp+m6pLs8X2WRaYxPi2qgRNJgp//ael
 7VOI1LnDFLMzH/z79Twgc6vi+eWVWVJDsC0Z2/pTq+QgMpSUFa/SFV+Z6Ze4JyCNAJ15K6yLD5b
 f3JdvIxSmeEgVrTs1GAbacdIDarSoH2ygkiLluuklALWBgXyEWbdX3yVorZvtdSVENqSGeWXmsQ
 umjFeDIBdtUxIdyNxjvzbjt8SLgLlEuL++81aTv93eunbPXut7xCGfHTKgv7La/HBfOGmhw173N
 Wq6/xUcFjNzAPKu3UBQJfcwDDHpVvw7birJvUt6K0AxwHRbZUWCcOxw8arqDdR4QUPZ62a43By8
 M1OvXHYRgtcZddn9YpVPbWfGqMIeOWjGNxSckW6xUKsMMf14eJdrYxBvdvbfYOM/FRdPwhWkhkn
 fffc4d5r8ZzSRIJOEIP+8gSvH8ATiyqLABAw+bTaLeKqitSfxqE5tyoHmbNoiI3P3udHSsKy3FJ
 NXUFJWUZ85KTARg==
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add test methods to cover all code paths of the nxp_imx93cst etype,
reusing the pattern of the nxp_imx8mcst as done in commit 0cab35362d77
("binman: test: Fix code coverage for iMX8 and cst bintool") by Simon
Glass.

This brings nxp_imx93cst to 100% coverage.

Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 tools/binman/ftest.py                              | 85 ++++++++++++++++++++++
 tools/binman/test/vendor/nxp_imx93_csf.dts         | 18 +++++
 .../binman/test/vendor/nxp_imx93_csf_imagename.dts | 24 ++++++
 3 files changed, 127 insertions(+)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 5f0de4c74a7..ce012b415ff 100644
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
@@ -8152,6 +8153,90 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
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
+        """Test CST signing where the SPL container starts with the ELE FW"""
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
+        # The pass-through branch returns the input data unchanged, so the
+        # produced image must be exactly the 64 zero bytes
+        out = tools.read_file(tools.get_output_filename('image.bin'))
+        self.assertEqual(out, b'\x00' * 64)
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
+        # The output must be the fake 32-byte CST blob produced by cst
+        self.assertEqual(data, b'\x00' * 32)
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

