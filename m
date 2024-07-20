Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BCFC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AEA288C66;
	Sat, 20 Jul 2024 12:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IbmjHnOw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECDB388C7A; Sat, 20 Jul 2024 12:50:17 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0BBB88C3A
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4266fd395eeso17916495e9.3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472615; x=1722077415; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtbjdRjVZn+HPOrN8NDkNLwitRbi8zPwHnYtHEqwomM=;
 b=IbmjHnOw3zViZaI0BQ2DD/HBDzJE9VmWuuslZsRkew1aB+Bef4WNWqK4fDIcZQ7H19
 MtJO+ZMDMfonAGM+BkfB6hSgBZ+ziqGsUrAOKXiW89tanOB4bq8OURHrtsfQ50cr2EjX
 ceAVEPBOH3rKvhlexC1fdd4PklpjoakiR9U5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472615; x=1722077415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GtbjdRjVZn+HPOrN8NDkNLwitRbi8zPwHnYtHEqwomM=;
 b=twOyrpcrmq4d+6QmM2A/ugPE6iJjMmw1yktQoPm0R6ro6Y1D37qKAc8YXQfJwZ2vZW
 x/xTskru1Ylj5it0UhHGImp74oas1FwwvubsWvpMH+rvaYI1VewtkbMNf82qSP42SRsg
 NPxQpFDMl+hu34QogZNARgSuKsfXZRxve8kjtSQTjWr/MpHcJCXc0UMnz6rcdxMwv/IO
 RYzdvkXqeMwSS+nv0+oo3kKXyUzs/+F/qkTb3jy9hHNocb3SYy72xtlECR1Jo31irCdT
 M+XKTsDLILapmm8tdrRqTPvzMSd/sTJgjZyzKqV4MM9PLTp/Dukl2jXe7xkemrgQrTgH
 dFnQ==
X-Gm-Message-State: AOJu0YxBykcuodWxG51gxcLM6mVGkn0JwTAdahmnUIUQCf1TWT1FmKRj
 sRKWDgfKO9GjuzDm643uvL0zejE8+0qDxEtEOVyiIElHeQtuLUdLlbvmTJglwwdM4qlj6cYBLYc
 =
X-Google-Smtp-Source: AGHT+IGpHNn7q4CPYF7bVuV6+viRAA1nHGdb9jjEI84ZyytwV+QwO4TXS+pR4+4b0uqgrE1/WNqh7g==
X-Received: by 2002:a05:6000:1564:b0:369:ba89:a577 with SMTP id
 ffacd0b85a97d-369ba89a83amr835613f8f.34.1721472615156; 
 Sat, 20 Jul 2024 03:50:15 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/20] binman: fit: Allow providing FDT filenames in a
 directory
Date: Sat, 20 Jul 2024 11:49:46 +0100
Message-Id: <20240720104950.2730773-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720104950.2730773-1-sjg@chromium.org>
References: <20240720104950.2730773-1-sjg@chromium.org>
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

In some cases the list of available FDT files is not available in an
entryarg. Provide an option to point to a directory containing them
instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entries.rst              |  7 ++++
 tools/binman/etype/fit.py             | 19 ++++++++-
 tools/binman/ftest.py                 | 17 ++++++--
 tools/binman/test/333_fit_fdt_dir.dts | 58 +++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 5 deletions(-)
 create mode 100644 tools/binman/test/333_fit_fdt_dir.dts

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 8bfec8b434e..dcacd298c6d 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -857,6 +857,13 @@ The top-level 'fit' node supports the following special properties:
 
             fit,fdt-list-val = "dtb1", "dtb2";
 
+    fit,fdt-list-dir
+        As an alternative to fit,fdt-list the list of device tree files
+        can be provided as a directory. Each .dtb file in the directory is
+        processed, , e.g.::
+
+            fit,fdt-list-dir = "arch/arm/dts
+
 Substitutions
 ~~~~~~~~~~~~~
 
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 2c14b15b03c..8a25c784ef6 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -5,7 +5,9 @@
 
 """Entry-type module for producing a FIT"""
 
+import glob
 import libfdt
+import os
 
 from binman.entry import Entry, EntryArg
 from binman.etype.section import Entry_section
@@ -87,6 +89,13 @@ class Entry_fit(Entry_section):
 
                 fit,fdt-list-val = "dtb1", "dtb2";
 
+        fit,fdt-list-dir
+            As an alternative to fit,fdt-list the list of device tree files
+            can be provided as a directory. Each .dtb file in the directory is
+            processed, , e.g.::
+
+                fit,fdt-list-dir = "arch/arm/dts
+
     Substitutions
     ~~~~~~~~~~~~~
 
@@ -352,6 +361,7 @@ class Entry_fit(Entry_section):
         self._fit = None
         self._fit_props = {}
         self._fdts = None
+        self._fdt_dir = None
         self.mkimage = None
         self._priv_entries = {}
         self._loadables = []
@@ -368,7 +378,14 @@ class Entry_fit(Entry_section):
             if fdts is not None:
                 self._fdts = fdts.split()
         else:
-            self._fdts = fdt_util.GetStringList(self._node, 'fit,fdt-list-val')
+            self._fdt_dir = fdt_util.GetString(self._node, 'fit,fdt-list-dir')
+            if self._fdt_dir:
+                indir = tools.get_input_filename(self._fdt_dir)
+                fdts = glob.glob('*.dtb', root_dir=indir)
+                self._fdts = [os.path.splitext(f)[0] for f in sorted(fdts)]
+            else:
+                self._fdts = fdt_util.GetStringList(self._node,
+                                                    'fit,fdt-list-val')
 
         self._fit_default_dt = self.GetEntryArgsOrProps([EntryArg('default-dt',
                                                                   str)])[0]
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 684e960b582..6e1e1e9b50b 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -4181,8 +4181,8 @@ class TestFunctional(unittest.TestCase):
         data = self._DoReadFile('172_scp.dts')
         self.assertEqual(SCP_DATA, data[:len(SCP_DATA)])
 
-    def testFitFdt(self):
-        """Test an image with an FIT with multiple FDT images"""
+    def CheckFitFdt(self, dts='170_fit_fdt.dts', use_fdt_list=True):
+        """Check an image with an FIT with multiple FDT images"""
         def _CheckFdt(seq, expected_data):
             """Check the FDT nodes
 
@@ -4221,11 +4221,12 @@ class TestFunctional(unittest.TestCase):
             self.assertEqual('fdt-%d' % seq, fnode.props['fdt'].value)
 
         entry_args = {
-            'of-list': 'test-fdt1 test-fdt2',
             'default-dt': 'test-fdt2',
         }
+        if use_fdt_list:
+            entry_args['of-list'] = 'test-fdt1 test-fdt2'
         data = self._DoReadFileDtb(
-            '170_fit_fdt.dts',
+            dts,
             entry_args=entry_args,
             extra_indirs=[os.path.join(self._indir, TEST_FDT_SUBDIR)])[0]
         self.assertEqual(U_BOOT_NODTB_DATA, data[-len(U_BOOT_NODTB_DATA):])
@@ -4244,6 +4245,10 @@ class TestFunctional(unittest.TestCase):
         _CheckConfig(1, TEST_FDT1_DATA)
         _CheckConfig(2, TEST_FDT2_DATA)
 
+    def testFitFdt(self):
+        """Test an image with an FIT with multiple FDT images"""
+        self.CheckFitFdt()
+
     def testFitFdtMissingList(self):
         """Test handling of a missing 'of-list' entry arg"""
         with self.assertRaises(ValueError) as e:
@@ -7605,6 +7610,10 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertIn("Invalid U-Boot phase 'bad-phase': Use tpl/vpl/spl",
                       str(e.exception))
 
+    def testFitFdtListDir(self):
+        """Test an image with an FIT with FDT images using fit,fdt-list-dir"""
+        self.CheckFitFdt('333_fit_fdt_dir.dts', False)
+
 
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/333_fit_fdt_dir.dts b/tools/binman/test/333_fit_fdt_dir.dts
new file mode 100644
index 00000000000..aa778451a4b
--- /dev/null
+++ b/tools/binman/test/333_fit_fdt_dir.dts
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		u-boot {
+		};
+		fit {
+			description = "test-desc";
+			#address-cells = <1>;
+			fit,fdt-list-dir = "fdts";
+
+			images {
+				kernel {
+					description = "Vanilla Linux kernel";
+					type = "kernel";
+					arch = "ppc";
+					os = "linux";
+					compression = "gzip";
+					load = <00000000>;
+					entry = <00000000>;
+					hash-1 {
+						algo = "crc32";
+					};
+					hash-2 {
+						algo = "sha1";
+					};
+					u-boot {
+					};
+				};
+				@fdt-SEQ {
+					description = "fdt-NAME.dtb";
+					type = "flat_dt";
+					compression = "none";
+					hash {
+						algo = "sha256";
+					};
+				};
+			};
+
+			configurations {
+				default = "@config-DEFAULT-SEQ";
+				@config-SEQ {
+					description = "conf-NAME.dtb";
+					firmware = "uboot";
+					loadables = "atf";
+					fdt = "fdt-SEQ";
+				};
+			};
+		};
+		u-boot-nodtb {
+		};
+	};
+};
-- 
2.34.1

