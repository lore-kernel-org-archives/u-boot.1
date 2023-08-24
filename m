Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FED4C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE24286537;
	Thu, 24 Aug 2023 05:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ht3sTgqr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A552D86544; Thu, 24 Aug 2023 05:03:25 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6CF68647E
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34cafafa50eso11554465ab.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692846201; x=1693451001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekMqLCwercIjcp7N9w7tNofzaTl+ERxQoTGVBl9Rml8=;
 b=ht3sTgqr7Wuj3FjZXowdjvIFGDTLSnfkzsPSid7f/eVKp0dndEPiBWvw80T/xkt60I
 vMmbGPJflkEzw8fkwSA13FPFSXFK1MOpn3doL7ijPtSu6+/eIvvqt/h4xP/xkhPdTxbe
 2Ps55JzuuwoUgAjJA7jjg0IZdbfoHzEzGGl6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692846201; x=1693451001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ekMqLCwercIjcp7N9w7tNofzaTl+ERxQoTGVBl9Rml8=;
 b=Ngsvkxjr2DPJGtbbAHSAez5OrfL8zZkrmOQT7aAz8PVmzS7HJFARwR8TfKXQub7p74
 4uTvV8tCMyvwJNw50DLQlJtvqlITRUJEnjwWxgr5s0kdB5ntjP99H7p/RKVX18oGDMnR
 lCxChI/Wc0bv3pdMxbMqvYLpDm7E3mdbARmyMGS7u4hVOif/u8Q9/KqmVAt4PwhdPs8+
 XW668iR5nu2mczP53cOJ5ysu5EfWD168Az0wuvfQ9ge5Q8EcTB4U4FXTRyjw794+1593
 isb1fvbEYbtV7SwEvO1MM4k+PJtW80UOLaGoL/R+O5nb9cEYYmK6DyKhA9wLd4E61tkM
 r/HA==
X-Gm-Message-State: AOJu0YyYzUJsDmxxzv1j5v0d6p7yx/YaDBHFWGmF1W3muBQJ8mjTOq/O
 Mga3tuRpmIV7vunPDdldBaJYbP+1edEvrXptCOA=
X-Google-Smtp-Source: AGHT+IEJMsA1MhiwK24E+50tFdO+3oPmZ+QCt2zBB/vWJL4JTIgjs0AI3byucfMry2mZZAQwLV6lVw==
X-Received: by 2002:a05:6e02:1147:b0:347:7421:9d85 with SMTP id
 o7-20020a056e02114700b0034774219d85mr4129539ill.29.1692846201293; 
 Wed, 23 Aug 2023 20:03:21 -0700 (PDT)
Received: from localhost.localdomain (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 u4-20020a92ccc4000000b00345fcbce508sm4274117ilq.39.2023.08.23.20.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 20:03:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 1/6] binman: Require image filenames to have certain extensions
Date: Wed, 23 Aug 2023 21:02:54 -0600
Message-ID: <20230824030304.1555547-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824030304.1555547-1-sjg@chromium.org>
References: <20230824030304.1555547-1-sjg@chromium.org>
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

It is helpful to be able to distinguish output files from other files when
building U-Boot. This is useful for buildman, for example, which can
preserve output files when requested.

Most images use extensions like .bin or .rom but some use other ones.

Introduce a check and produce an error if an image filename does not have
an allowed extension.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/binman.rst                  |  5 +++++
 tools/binman/etype/section.py            |  3 +--
 tools/binman/ftest.py                    | 12 ++++++++++--
 tools/binman/image.py                    |  9 +++++++++
 tools/binman/test/022_image_name.dts     |  4 ++--
 tools/binman/test/311_bad_image_name.dts | 17 +++++++++++++++++
 6 files changed, 44 insertions(+), 6 deletions(-)
 create mode 100644 tools/binman/test/311_bad_image_name.dts

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index aeea33fddb95..3c24a8313c47 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -678,6 +678,11 @@ filename:
     put into the entry. If binman knows about the entry type (like
     u-boot-bin), then there is no need to specify this.
 
+    Note that image filenames must have one of a limited set of extensions:
+    `.bin`, `.rom`, `.itb` or `.img`. Others will generate an error. This is
+    so that it is clear which output files are images. It allows buildman to
+    preserve them when its `-k` option is used, for example.
+
 type:
     Sets the type of an entry. This defaults to the entry name, but it is
     possible to use any name, and then add (for example) 'type = "u-boot"'
diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index fb49e85a7634..8074f181ea58 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -10,6 +10,7 @@ images to be created.
 
 from collections import OrderedDict
 import concurrent.futures
+import os
 import re
 import sys
 
@@ -20,7 +21,6 @@ from u_boot_pylib import tools
 from u_boot_pylib import tout
 from u_boot_pylib.tools import to_hex_size
 
-
 class Entry_section(Entry):
     """Entry that contains other entries
 
@@ -203,7 +203,6 @@ class Entry_section(Entry):
         self.align_default = fdt_util.GetInt(self._node, 'align-default', 0)
         self._filename = fdt_util.GetString(self._node, 'filename',
                                             self._filename)
-
         self.ReadEntries()
 
     def ReadEntries(self):
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 1293e9dbf423..5b54239827d4 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -1107,11 +1107,11 @@ class TestFunctional(unittest.TestCase):
         retcode = self._DoTestFile('022_image_name.dts')
         self.assertEqual(0, retcode)
         image = control.images['image1']
-        fname = tools.get_output_filename('test-name')
+        fname = tools.get_output_filename('test-name.bin')
         self.assertTrue(os.path.exists(fname))
 
         image = control.images['image2']
-        fname = tools.get_output_filename('test-name.xx')
+        fname = tools.get_output_filename('test-name.img')
         self.assertTrue(os.path.exists(fname))
 
     def testBlobFilename(self):
@@ -7216,5 +7216,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertRegex(err,
                          "Image 'image'.*missing bintools.*: bootgen")
 
+    def testBadImageName(self):
+        """Test that image files can be named"""
+        with self.assertRaises(ValueError) as e:
+            self._DoTestFile('311_bad_image_name.dts')
+        self.assertIn(
+            "Image filename 'test-name.what' must use a permitted extension: .bin, .rom, .itb, .img",
+            str(e.exception))
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/image.py b/tools/binman/image.py
index e77b5d0d97cd..71dc28854412 100644
--- a/tools/binman/image.py
+++ b/tools/binman/image.py
@@ -21,6 +21,9 @@ from dtoc import fdt_util
 from u_boot_pylib import tools
 from u_boot_pylib import tout
 
+# Extensions allowed for images (keep in sync with buildman/builderthread.py)
+ALLOWED_EXTS = ['.bin', '.rom', '.itb', '.img']
+
 class Image(section.Entry_section):
     """A Image, representing an output from binman
 
@@ -97,6 +100,12 @@ class Image(section.Entry_section):
         self.allow_repack = fdt_util.GetBool(self._node, 'allow-repack')
         self._symlink = fdt_util.GetString(self._node, 'symlink')
 
+        if self.section is None:
+            ext = os.path.splitext(self._filename)[1]
+            if ext not in ALLOWED_EXTS:
+                self.Raise(
+                    f"Image filename '{self._filename}' must use a permitted extension: {', '.join(ALLOWED_EXTS)}")
+
     @classmethod
     def FromFile(cls, fname):
         """Convert an image file into an Image for use in binman
diff --git a/tools/binman/test/022_image_name.dts b/tools/binman/test/022_image_name.dts
index 94fc069c1764..2da68ab06921 100644
--- a/tools/binman/test/022_image_name.dts
+++ b/tools/binman/test/022_image_name.dts
@@ -7,13 +7,13 @@
 	binman {
 		multiple-images;
 		image1 {
-			filename = "test-name";
+			filename = "test-name.bin";
 			u-boot {
 			};
 		};
 
 		image2 {
-			filename = "test-name.xx";
+			filename = "test-name.img";
 			u-boot {
 			};
 		};
diff --git a/tools/binman/test/311_bad_image_name.dts b/tools/binman/test/311_bad_image_name.dts
new file mode 100644
index 000000000000..30192957c447
--- /dev/null
+++ b/tools/binman/test/311_bad_image_name.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		multiple-images;
+		image1 {
+			filename = "test-name.what";
+			u-boot {
+			};
+		};
+	};
+};
-- 
2.42.0.rc1.204.g551eb34607-goog

