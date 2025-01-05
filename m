Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94251E77197
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 20:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C007A801DE;
	Sun,  5 Jan 2025 21:37:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736109453;
	bh=+qVvaW5ZiRq8FxLw7iwVJzf8YGkL+l+WnV6kJQEI4FQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ur8smzDkpIQWE5HsUY1wTPt81267tYZDnpN62mgmyK2eo5EbymAIXgFgSW706wx8H
	 adOJ+QtLc3LlhC3YXyOuvI2b6oum0PNFbfa2s1Y+2k4sRVFyA5aBAc2/86stSBZnXW
	 UHjXxmOzdn+U2RJg9R6g+EY1/iDLuQrDaSqnRDzyb57Yf6m25eUwydFThcvfFaP0yN
	 RJbkvwt87+SL/on0atfFE+shtkBrfefNZspIOoRQPXjCUTVnbMb2zVjNTjVk91c2I7
	 1MO6WHq2wYIeyi6gJYy+MBb1zweM+C5g6nQBLVxQkmAitEJm/HWIgHdR1A0sVpL+eT
	 wO4uKkVnCB80Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A41C0801E8; Sun,  5 Jan 2025 21:37:32 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6053F801CE
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 21:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="IlzyXDpl"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3D2FE10408FB9; Sun,  5 Jan 2025 21:37:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736109448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+qVvaW5ZiRq8FxLw7iwVJzf8YGkL+l+WnV6kJQEI4FQ=;
 b=IlzyXDplx8Jov70G/4T8HuyW6Hu6erevSnJFZZi+iHU3b/P88LoCkK5Se1S2fQ358X6B7W
 8saaEA1UknCSl6dL8GCI9eURwhPUSfoMPdN3SvxqkbbZNNzdIfDXkCC+PLAWWYpfgIbj7s
 TGPaMtdMPUTeokp1zN2nTUuba+ckieHnTn989a4eK6+DI8lok6Xujd5k/gswohMkDFSfL0
 klm/PkSXMCc9I+JcsZRNRgK4V2COO9/o2zZC1doyzwKic01B//z9n8kpjNMhIqOU9PQoV7
 Igdfs/+8pGov1D/w2iuRvzE8VPtQOvOak78WnxhZwI/woCN6xrkwMp9Qa5OnOA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Brian Ruley <brian.ruley@gehealthcare.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
Date: Sun,  5 Jan 2025 21:36:42 +0100
Message-ID: <20250105203714.158480-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Rename the test .dts and tests and include the M suffix to indicate
those tests are for i.MX8M, not for i.MX8, which is a different SoC.

Update 339_nxp_imx8m.dts, add testNxpImx8MImageMkimageMissing and
update nxp_imx8mimage.py test to bring nxp_imx8mimage test to 100% .

Add 343..345_nxp_imx8m.dts, add matching tests and update nxp_imx8mcst.py
to bring CST tests to 97% . It is not clear how to test the CST output
file to reach 100%.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 tools/binman/etype/nxp_imx8mcst.py            |  4 --
 tools/binman/etype/nxp_imx8mimage.py          |  4 --
 tools/binman/ftest.py                         | 42 +++++++++++++++++--
 .../{339_nxp_imx8.dts => 339_nxp_imx8m.dts}   |  3 ++
 tools/binman/test/343_nxp_imx8m.dts           | 26 ++++++++++++
 tools/binman/test/344_nxp_imx8m.dts           | 28 +++++++++++++
 tools/binman/test/345_nxp_imx8m.dts           | 19 +++++++++
 7 files changed, 115 insertions(+), 11 deletions(-)
 rename tools/binman/test/{339_nxp_imx8.dts => 339_nxp_imx8m.dts} (93%)
 create mode 100644 tools/binman/test/343_nxp_imx8m.dts
 create mode 100644 tools/binman/test/344_nxp_imx8m.dts
 create mode 100644 tools/binman/test/345_nxp_imx8m.dts

diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
index dd9f226b751..c36a8f68971 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -181,10 +181,6 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
         upto = 0x00
         for entry in super().GetEntries().values():
             entry.SetOffsetSize(upto, None)
-
-            # Give up if any entries lack a size
-            if entry.size is None:
-                return
             upto += entry.size
 
         Entry_section.SetImagePos(self, image_pos)
diff --git a/tools/binman/etype/nxp_imx8mimage.py b/tools/binman/etype/nxp_imx8mimage.py
index 8ad177b3b65..8d14e16154a 100644
--- a/tools/binman/etype/nxp_imx8mimage.py
+++ b/tools/binman/etype/nxp_imx8mimage.py
@@ -66,10 +66,6 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
         upto = 0x00
         for entry in super().GetEntries().values():
             entry.SetOffsetSize(upto, None)
-
-            # Give up if any entries lack a size
-            if entry.size is None:
-                return
             upto += entry.size
 
         Entry_section.SetImagePos(self, image_pos)
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a553ca9e564..467f24a85d5 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7822,9 +7822,45 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertIn('Symbol-writing: no value for /binman/section/u-boot',
                       out)
 
-    def testNxpImx8Image(self):
-        """Test that binman can produce an iMX8 image"""
-        self._DoTestFile('339_nxp_imx8.dts')
+    def testNxpImx8MImage(self):
+        """Test that binman can produce an iMX8M image"""
+        self._DoTestFile('339_nxp_imx8m.dts')
+
+    def testNxpImx8MImageMkimageMissing(self):
+        """Test that binman can produce an iMX8M image"""
+        with test_util.capture_sys_output() as (_, stderr):
+            self._DoTestFile('339_nxp_imx8m.dts',
+                             force_missing_bintools='mkimage')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: mkimage")
+
+    def testNxpImx8MCSTSPL(self):
+        """Test that binman can sign an iMX8M SPL image"""
+        self._DoTestFile('343_nxp_imx8m.dts')
+
+    def testNxpImx8MCSTFIT(self):
+        """Test that binman can sign an iMX8M FIT image"""
+        self._DoTestFile('344_nxp_imx8m.dts')
+
+    def testNxpImx8MCSTUnknown(self):
+        """Test that binman can sign an iMX8M Unknown image"""
+        self._DoTestFile('345_nxp_imx8m.dts')
+
+    def testNxpImx8MCSTMkimageMissing(self):
+        """Test that binman can sign an iMX8M image"""
+        with test_util.capture_sys_output() as (_, stderr):
+            self._DoTestFile('343_nxp_imx8m.dts',
+                             force_missing_bintools='mkimage')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: mkimage")
+
+    def testNxpImx8MCSTtoolMissing(self):
+        """Test that binman can sign an iMX8M image"""
+        with test_util.capture_sys_output() as (_, stderr):
+            self._DoTestFile('343_nxp_imx8m.dts',
+                             force_missing_bintools='cst')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
 
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
diff --git a/tools/binman/test/339_nxp_imx8.dts b/tools/binman/test/339_nxp_imx8m.dts
similarity index 93%
rename from tools/binman/test/339_nxp_imx8.dts
rename to tools/binman/test/339_nxp_imx8m.dts
index cb512ae9aa2..2c8f4bee5b7 100644
--- a/tools/binman/test/339_nxp_imx8.dts
+++ b/tools/binman/test/339_nxp_imx8m.dts
@@ -12,6 +12,9 @@
 			nxp,boot-from = "sd";
 			nxp,rom-version = <1>;
 			nxp,loader-address = <0x10>;
+
+			section {
+			};
 		};
 	};
 };
diff --git a/tools/binman/test/343_nxp_imx8m.dts b/tools/binman/test/343_nxp_imx8m.dts
new file mode 100644
index 00000000000..5e76a97641b
--- /dev/null
+++ b/tools/binman/test/343_nxp_imx8m.dts
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
+			args;	/* TODO: Needed by mkimage etype superclass */
+			nxp,loader-address = <0x12340000>;
+			nxp,unlock;
+
+			nxp-imx8mimage {
+				args;	/* TODO: Needed by mkimage etype superclass */
+				nxp,boot-from = "sd";
+				nxp,rom-version = <1>;
+				nxp,loader-address = <0x10>;
+
+				section {
+				};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/344_nxp_imx8m.dts b/tools/binman/test/344_nxp_imx8m.dts
new file mode 100644
index 00000000000..c38267bb815
--- /dev/null
+++ b/tools/binman/test/344_nxp_imx8m.dts
@@ -0,0 +1,28 @@
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
+			nxp,loader-address = <0x12340000>;
+			nxp,fast-auth;
+			offset = <0x58000>;
+			args;	/* Needed by mkimage etype superclass */
+
+			fit {
+				description = "test desc";
+				#address-cells = <1>;
+
+				images {
+				};
+
+				configurations {
+				};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/345_nxp_imx8m.dts b/tools/binman/test/345_nxp_imx8m.dts
new file mode 100644
index 00000000000..0ed6e3ca9d0
--- /dev/null
+++ b/tools/binman/test/345_nxp_imx8m.dts
@@ -0,0 +1,19 @@
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
+			nxp,loader-address = <0x12340000>;
+			offset = <0x58000>;
+			args;	/* Needed by mkimage etype superclass */
+
+			u-boot {
+			};
+		};
+	};
+};
-- 
2.45.2

