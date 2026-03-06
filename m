Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1294CFCC055
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:17:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD0738407F;
	Fri,  6 Mar 2026 19:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OwFqQUsD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1B248407F; Fri,  6 Mar 2026 19:14:22 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C8EB8401A
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-8cd75abd09dso18502385a.0
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820859; x=1773425659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkhNLHFPJbNUTo54bcOEJgt1uzQm2YQ8wF/nNTVbBiQ=;
 b=OwFqQUsDEbEvN3ythUMlCw/ErpfdEkeAFSJZm8kjhH7+u4TDhNV8LgvEhhrdq6f2ft
 V64t6q2mtex2l6V5nT4waC28fVz7Ws+H/i9eaNPM+C1y0b1iGlkyQoIXVdd+ipq/C7yP
 xNhFnfZWVV6h4W+iLndc6avQ343QrNqa2hG8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820859; x=1773425659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NkhNLHFPJbNUTo54bcOEJgt1uzQm2YQ8wF/nNTVbBiQ=;
 b=mIY6vsKBcBjgSEcX5cDjuagi8j/ZcM0Eiq7hp28dHRxY+hjyTmVPvWtKbX2AUduXff
 qY1qLfYqDq9yIVPxXoUZZCsJcgCAPJrM95QJbttNp6kqtt/6Hm+LbeADn+h6gKG8Mcku
 1bAfqmrilVej2BrrF6GFMVWouQODj3wG2Or8XAoUaitQ0M6zEFs0p0me2W5g75SCbyJl
 ez/MUEgR6tIlnMk2iap53WmCC1hAx5h0/FrLaYxoMgniyDiXqz/xpEE5wbt86TJ3BaV7
 TWgZuTnkeYOXgNfmF/WmNgUHQYOt+8ic3fyvTGjK2lsqMWdv7jTiedWps+eG4OnQoOkm
 YVYQ==
X-Gm-Message-State: AOJu0Yy/ccJTiC1QMlQztmBzZOaa2b+J7C3rX89efAoVd3Oy1M4a9wjV
 5CZWXdZLXkG/ykdJjS3ZLnsPaOb9f1J3ay3FlwdEBSRK2XuolEGEEjcTPKIhX9LCAo78uWnjO4a
 HIJM=
X-Gm-Gg: ATEYQzxTkk0j5yz71DR7vMBuFrgwRxh8pQntDRo17xMQF+vZ84nthzeNUlSNkwVTttP
 v7HSGym2dsO618M0Exk95G1hsq8R5Cvg3RGhh+sh+wGPOu46+Yrf7A0GhSq3n4lVmsaRW2jvMry
 rfkIa5Vg745XrEK6X0JR6bnpK+pUmxrPT/eH9s+nY48cxL0iu8vNfUKiixaiYqufNK1eH4jacqy
 UQ3QxSw4FJ3ww1sXG56xDJZQ+pFe2CLr0yituYjbQO9UnbLYSZR4tyzNhLYZlLQ7tDvy9ON7SkJ
 /ym/zvVebUTbuaJ1qRPMf4zKBtkkts2LbwftqZU84nRlLo3a5y3xU0Uqh3J03GFjdR5/VLhitLu
 Jdxoe5usneYAxJm4ccz+1XgNqqqOAMhdNgQFCr62hiKVT3q4+iAF4Se+fBFXTfWr6We+1+YcsCN
 1EcPEsuSVjk0BNe+5snA==
X-Received: by 2002:a05:620a:4723:b0:8cb:a7f1:8ea7 with SMTP id
 af79cd13be357-8cd6d42f5d2mr374218885a.31.1772820858889; 
 Fri, 06 Mar 2026 10:14:18 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:14:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 20/23] binman: test: Fix code coverage for iMX8 and cst
 bintool
Date: Fri,  6 Mar 2026 11:12:48 -0700
Message-ID: <20260306181304.2426352-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306181304.2426352-1-sjg@chromium.org>
References: <20260306181304.2426352-1-sjg@chromium.org>
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

(no changes since v1)

 tools/binman/ftest.py                         | 106 ++++++++++++++++++
 tools/binman/test/vendor/nxp_imx8.dts         |   3 +
 tools/binman/test/vendor/nxp_imx8_csf.dts     |  26 +++++
 .../test/vendor/nxp_imx8_csf_fast_auth.dts    |  21 ++++
 .../binman/test/vendor/nxp_imx8_imagename.dts |  27 +++++
 5 files changed, 183 insertions(+)
 create mode 100644 tools/binman/test/vendor/nxp_imx8_csf.dts
 create mode 100644 tools/binman/test/vendor/nxp_imx8_csf_fast_auth.dts
 create mode 100644 tools/binman/test/vendor/nxp_imx8_imagename.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 612237d0b41..9cc1a97f95c 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7899,6 +7899,112 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test that binman can produce an iMX8 image"""
         self._DoTestFile('vendor/nxp_imx8.dts')
 
+    def testNxpImx8ImageMissing(self):
+        """Test that binman produces an iMX8 image if mkimage is missing"""
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('vendor/nxp_imx8.dts',
+                             force_missing_bintools='mkimage')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: mkimage")
+
+    def testNxpImx8ImagePos(self):
+        """Test SetImagePos for iMX8 image"""
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('vendor/nxp_imx8.dts', update_dtb=True,
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
+            self._DoTestFile('vendor/nxp_imx8_csf.dts',
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
+            self._DoTestFile('vendor/nxp_imx8_csf_fast_auth.dts',
+                             force_missing_bintools='cst')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
+
+    def testNxpImx8mCSTUnknownMagic(self):
+        """Test CST with unknown input magic passes data through"""
+        # Trigger the pass-through path use data with neither IVT nor FIT magic
+        data = b'\x00' * 64
+        self._MakeInputFile('imx8m-ivt.bin', data)
+        self._DoTestFile('vendor/nxp_imx8_csf.dts', force_missing_bintools='cst')
+
+    def testNxpImx8ImageSizeNone(self):
+        """Test SetImagePos() early return when an entry has no size"""
+        # The imagename entry is in GetEntries() but not packed, so has
+        # size=None, which triggers the early-return guard in SetImagePos()
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('vendor/nxp_imx8_imagename.dts',
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
+            self._DoTestFile('vendor/nxp_imx8_csf.dts')
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
         data = self._DoReadFile('vendor/nxp_ddrfw_imx95.dts')
diff --git a/tools/binman/test/vendor/nxp_imx8.dts b/tools/binman/test/vendor/nxp_imx8.dts
index cb512ae9aa2..d9fc86635b4 100644
--- a/tools/binman/test/vendor/nxp_imx8.dts
+++ b/tools/binman/test/vendor/nxp_imx8.dts
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
diff --git a/tools/binman/test/vendor/nxp_imx8_csf.dts b/tools/binman/test/vendor/nxp_imx8_csf.dts
new file mode 100644
index 00000000000..148f4668bb9
--- /dev/null
+++ b/tools/binman/test/vendor/nxp_imx8_csf.dts
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
diff --git a/tools/binman/test/vendor/nxp_imx8_csf_fast_auth.dts b/tools/binman/test/vendor/nxp_imx8_csf_fast_auth.dts
new file mode 100644
index 00000000000..af35f2569df
--- /dev/null
+++ b/tools/binman/test/vendor/nxp_imx8_csf_fast_auth.dts
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
diff --git a/tools/binman/test/vendor/nxp_imx8_imagename.dts b/tools/binman/test/vendor/nxp_imx8_imagename.dts
new file mode 100644
index 00000000000..58dd1ca3d5d
--- /dev/null
+++ b/tools/binman/test/vendor/nxp_imx8_imagename.dts
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

