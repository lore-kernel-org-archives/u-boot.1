Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D3AFD45F1
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 22:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B79F83E63;
	Wed, 25 Feb 2026 23:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hy3VAtE8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 236EB83EA6; Wed, 25 Feb 2026 23:51:29 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 572E083E88
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 23:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-8cbb2329e7eso16020585a.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772059884; x=1772664684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otyGqAlrGjV7nRZR4qttvvvdNxJh59wEroS/J99krsA=;
 b=Hy3VAtE8G7OGWSzEZSkmC7/Vtk8uB+Sq7wBO8LS/RYqXSnZ9Ns0Ivslu7hRogAS5oP
 53mfiTFMkS0RAvXVMCNNYLvM9o2MX6NVZEd6H6FM02nXRpO72MpmeSmQGGcc3DMhIil1
 6Eb3/gClBWv4hqFEufsxMfvWyqOksNDBbUGRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772059884; x=1772664684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=otyGqAlrGjV7nRZR4qttvvvdNxJh59wEroS/J99krsA=;
 b=k9ABivkSM4shiHHyOi0rJ+uOgd4+rJhhMY8jijr3Ku+F0ZwSyFXbKOL0gPnu2QDd7g
 fqfrR/Z1wCUSIG77nFJWj7yZA3Dz9N1ihm/8qc8pTcORkWTuw1TaZg3WQFztT/l9qiy9
 FOk/ef5IMMlajQtLwNidRqNS2leMAvEIWM+Hsi3xGozo3SyfnL4o/bL4FBegICjqe1vI
 +4NjyciO5jF+dQ9aIdJMct3NB8KjxhpAb9/d/rVZVUPaMKMlprfAX5PlyZhz+QipJgqq
 b/7Jkocw9iP87X0AqhLVPUvVX3Ajcy78tslnPqj09GXS4LvbCp8Kdw4bOItIGcPHSBKf
 kShw==
X-Gm-Message-State: AOJu0YwM6i14RYwKt2OaMNTXljz1hpExoZhYQjrLxifZWRrufrgoGBG7
 VVb4VJjF/UZUG9bMvEQyw+hK1bDNK6UFkRUa30h6muQXDWQb7JXkniZ0ZdB9Q90KqxEXpYd7Aid
 bXBg=
X-Gm-Gg: ATEYQzzzkGng7X0X587sW7DgIDe2Pg2l6RxZIVE0DqP2CpoYpU0dfrJVRTnN+zydxH8
 c/0ygmwmT1tBYpX6VFpsxV2nNDpU6lUJYvgSZ1/KcIQL3PWmQT5xJWhrLGviijrRAe965cJhDG/
 5X5JrdjuSfuOO9PtZmEmomq6R7V8Z3OEDWBA+lVyXc2j/BWDdL1xDWULdLps5FRV8Pea63ChZqI
 e0yA72jHTwEVVhPmJkGlv38S2om+9oBBxBMxdZHof6sgH+dLr1r0OHHF2OKckuHkB+bbTilXwo6
 k6nG6pneUkyMLRLGlCrAyrlX+2s8+ZgfNb/7Y2Jj9wmjns1NwcitrvrzVEE1BgF60e2m1VSJvjA
 eQlswUaee+yV087yawgVScMlWzgVgrXeTlebt6xFLabagkhz95TSkT4apr8vIToPRzd97X0U/lp
 7RjA0JC31lMIOOD8al0g==
X-Received: by 2002:a05:620a:2903:b0:8c9:f9c2:118e with SMTP id
 af79cd13be357-8cbc112d063mr2688185a.32.1772059883622; 
 Wed, 25 Feb 2026 14:51:23 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf72e21bsm43730985a.44.2026.02.25.14.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:51:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 4/6] binman: test: Fix code coverage for iMX8 and cst bintool
Date: Wed, 25 Feb 2026 15:50:33 -0700
Message-ID: <20260225225040.2568118-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225225040.2568118-1-sjg@chromium.org>
References: <20260225225040.2568118-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Three files are currently missing test coverage: nxp_imx8mcst,
nxp_imx8mimage and cst

Add test methods to cover all missing code paths, trying to reuse the
same .dts files where possible.

This brings all three files to 100% coverage.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 tools/binman/ftest.py                         | 106 ++++++++++++++++++
 tools/binman/test/339_nxp_imx8.dts            |   3 +
 tools/binman/test/364_nxp_imx8_csf.dts        |  26 +++++
 .../test/365_nxp_imx8_csf_fast_auth.dts       |  21 ++++
 tools/binman/test/366_nxp_imx8_imagename.dts  |  27 +++++
 5 files changed, 183 insertions(+)
 create mode 100644 tools/binman/test/364_nxp_imx8_csf.dts
 create mode 100644 tools/binman/test/365_nxp_imx8_csf_fast_auth.dts
 create mode 100644 tools/binman/test/366_nxp_imx8_imagename.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 276b0dd77fd..296de3dc218 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7899,6 +7899,112 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test that binman can produce an iMX8 image"""
         self._DoTestFile('339_nxp_imx8.dts')
 
+    def testNxpImx8ImageMissing(self):
+        """Test that binman produces an iMX8 image if mkimage is missing"""
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('339_nxp_imx8.dts',
+                             force_missing_bintools='mkimage')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: mkimage")
+
+    def testNxpImx8ImagePos(self):
+        """Test SetImagePos for iMX8 image"""
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('339_nxp_imx8.dts', update_dtb=True,
+                             force_missing_bintools='mkimage')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: mkimage")
+
+    def testNxpImx8mCSTNormal(self):
+        """Test CST signing with IVT-format input (normal auth, no unlock)"""
+        # Create fake IVT blob: magic(4) + padding(20) + signsize_addr(4)
+        # + padding(36) = 64 bytes
+        ivt_data = struct.pack('<I', 0x412000d1)
+        ivt_data += b'\x00' * 20
+        ivt_data += struct.pack('<I', 0)
+        ivt_data += b'\x00' * 36
+        self._MakeInputFile('imx8m-ivt.bin', ivt_data)
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('364_nxp_imx8_csf.dts',
+                             force_missing_bintools='cst')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
+
+    def testNxpImx8mCSTFastAuth(self):
+        """Test CST signing with fast-auth mode, unlock, and FIT format"""
+        # FIT magic covers the FIT-signing path; fast-auth/unlock cover the
+        # ReadNode() and config-generation branches
+        fit_data = struct.pack('<I', 0xedfe0dd0)
+        fit_data += b'\x00' * 60
+        self._MakeInputFile('imx8m-fit.bin', fit_data)
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('365_nxp_imx8_csf_fast_auth.dts',
+                             force_missing_bintools='cst')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
+
+    def testNxpImx8mCSTUnknownMagic(self):
+        """Test CST with unknown input magic passes data through"""
+        # Trigger the pass-through path use data with neither IVT nor FIT magic
+        data = b'\x00' * 64
+        self._MakeInputFile('imx8m-ivt.bin', data)
+        self._DoTestFile('364_nxp_imx8_csf.dts', force_missing_bintools='cst')
+
+    def testNxpImx8ImageSizeNone(self):
+        """Test SetImagePos() early return when an entry has no size"""
+        # The imagename entry is in GetEntries() but not packed, so has
+        # size=None, which triggers the early-return guard in SetImagePos()
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('366_nxp_imx8_imagename.dts',
+                             force_missing_bintools='mkimage')
+
+    def testNxpImx8mCSTSigned(self):
+        """Test CST-signing-success path with mocked cst invocation"""
+        ivt_data = struct.pack('<I', 0x412000d1)
+        ivt_data += b'\x00' * 20
+        ivt_data += struct.pack('<I', 0)
+        ivt_data += b'\x00' * 36
+        self._MakeInputFile('imx8m-ivt.bin', ivt_data)
+
+        # Mock run_cmd() so that when cst is invoked, it creates a fake output
+        # blob and returns success, thus covering the signing path
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
+            self._DoTestFile('364_nxp_imx8_csf.dts')
+
+    def testNxpImx8mCSTBintool(self):
+        """Test the cst bintool run() and fetch() methods"""
+        cst = bintool.Bintool.create('cst')
+        self.assertEqual('cst', cst.name)
+
+        # Mark cst as missing so run() exercises the code without needing the
+        # real tool (which fails without valid signing keys)
+        old_missing = bintool.Bintool.missing_list
+        bintool.Bintool.set_missing_list(['cst'])
+        try:
+            self.assertIsNone(cst.run('test.bin'))
+        finally:
+            bintool.Bintool.set_missing_list(old_missing)
+        # fetch() only supports FETCH_BUILD; other methods return None
+        self.assertIsNone(cst.fetch(bintool.FETCH_BIN))
+
+        # fetch(FETCH_BUILD) calls build_from_git() so mock it
+        with unittest.mock.patch.object(
+                bintool.Bintool, 'build_from_git', return_value=('cst', None)):
+            result = cst.fetch(bintool.FETCH_BUILD)
+            self.assertEqual(('cst', None), result)
+
     def testNxpHeaderDdrfw(self):
         """Test that binman can add a header to DDR PHY firmware images"""
         data = self._DoReadFile('353_nxp_ddrfw_imx95.dts')
diff --git a/tools/binman/test/339_nxp_imx8.dts b/tools/binman/test/339_nxp_imx8.dts
index cb512ae9aa2..d9fc86635b4 100644
--- a/tools/binman/test/339_nxp_imx8.dts
+++ b/tools/binman/test/339_nxp_imx8.dts
@@ -12,6 +12,9 @@
 			nxp,boot-from = "sd";
 			nxp,rom-version = <1>;
 			nxp,loader-address = <0x10>;
+
+			u-boot {
+			};
 		};
 	};
 };
diff --git a/tools/binman/test/364_nxp_imx8_csf.dts b/tools/binman/test/364_nxp_imx8_csf.dts
new file mode 100644
index 00000000000..148f4668bb9
--- /dev/null
+++ b/tools/binman/test/364_nxp_imx8_csf.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		nxp-imx8mcst {
+			args;
+			nxp,loader-address = <0x10>;
+
+			blob {
+				filename = "imx8m-ivt.bin";
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
diff --git a/tools/binman/test/365_nxp_imx8_csf_fast_auth.dts b/tools/binman/test/365_nxp_imx8_csf_fast_auth.dts
new file mode 100644
index 00000000000..af35f2569df
--- /dev/null
+++ b/tools/binman/test/365_nxp_imx8_csf_fast_auth.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		nxp-imx8mcst {
+			args;
+			nxp,loader-address = <0x10>;
+			nxp,fast-auth;
+			nxp,unlock;
+
+			blob {
+				filename = "imx8m-fit.bin";
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/366_nxp_imx8_imagename.dts b/tools/binman/test/366_nxp_imx8_imagename.dts
new file mode 100644
index 00000000000..58dd1ca3d5d
--- /dev/null
+++ b/tools/binman/test/366_nxp_imx8_imagename.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		nxp-imx8mimage {
+			args;	/* TODO: Needed by mkimage etype superclass */
+			nxp,boot-from = "sd";
+			nxp,rom-version = <1>;
+			nxp,loader-address = <0x10>;
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
2.43.0

