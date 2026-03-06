Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924E3FCC055
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E72283FED;
	Fri,  6 Mar 2026 19:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QGGgv/TH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2436B83FF8; Fri,  6 Mar 2026 19:13:56 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD8A283FC5
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-8cb39647a70so917652185a.0
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820832; x=1773425632; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CHiFHT3RwN8UIP8DtgaCCrmefE9cz1dME+yGqfBrBfY=;
 b=QGGgv/THepJwHiil4ZDtHk8WtEGmUUo28an017OIcA5xpxziZQUicFY78YpVo6m8D3
 A5DTBoRBAuulTaXZdpdj/sWZNW9GKzuqbDsOzefJ8oflXYR75qO5bUC8G+gAeJPpaGEd
 x+xp4+2PX+dSTL8f3n8LZw1eNn8F+NOMZ44OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820832; x=1773425632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CHiFHT3RwN8UIP8DtgaCCrmefE9cz1dME+yGqfBrBfY=;
 b=iA5ddAchpJQi61ssxjqdIH0pCJkCC5gKIYcPztg4NMXSaHN9+O/2MFmRuAUKdHjLmj
 FdmwSO6QYyNmvuxWBvlnAvR0VxqsqsgSk+bVz2y9Owiz6ipAn92KF3UnPKMP7Gp0Y3Ze
 lSdK90OAMZxv5GVsQRp9VY8nZlNRDsFqST9lRp4DAnG9aqwxkbcKFcBIdHE+HX/px51h
 pRGYU4EGw75KQAuL3hvMgIovak2PyLfrGwwVAxDyMj4hmgBgOnf4UCDzQGwt4+/OT+J1
 pDHdU1sRCubcN/HsYnGoxUdJGK9fTBAQPodSfX2SHbHXm001AmBM3G76Ym2loCGz1i22
 L1+Q==
X-Gm-Message-State: AOJu0Yxeu549zLGAxPolNguYNvOinft+ViNDhIaRdDpVxfaYjaYKbHEO
 NAB8bQlpCUgeJ5GY1FMVpQheSrYIJMK2YcPOtQKOIzNSc5bkL9Xg2QDKskkqhCRUWap032WL4dW
 G/oU=
X-Gm-Gg: ATEYQzw8PXuoOHV5ers7JZTOHkGOnjAKDkiKBu9sbVF5Qpd8V8o0bZWZCcoK2l+pDZq
 0thoDq0b+86kgdaZuoI4dadulRWrn9TbKxcgPOw9WpsFroCOaEO1kqQZ9oX476CyBqEIe+EQGEw
 TcRyPYIq7/3ENOVNiCFpJNl6CBB17z5arVJv1/YjH2XxkBFmx5Sx6cGODrhRF5YbQcfwCs7BP32
 QZvYbJDbXJxAJ534KJxTOD4pWMsspNCc1xxABsxKe5oDW843328OIxWh3RD7PJxKbyLqOvIxows
 7eLibZO0T3ieOpHVDfMW1P+digcgFfOG5InU6rEcba/UvUoesovaSiD7Cg+YI3Z2sRrkQGqCA1Z
 B7rNoXLuB2BsL/IXsOc56ayKU4hDjjdozQEYvJqC+71CTQK57HUyWCDZpjOFFqp+zVF0xp4vIHM
 zuB6FU179ri+xKiQpzdQ==
X-Received: by 2002:a05:620a:bd5:b0:8c8:82a1:11c9 with SMTP id
 af79cd13be357-8cd6d415927mr376666485a.14.1772820831909; 
 Fri, 06 Mar 2026 10:13:51 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:13:51 -0800 (PST)
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
Subject: [PATCH v2 10/23] binman: test: Move ChromeOS test files to test/cros/
Date: Fri,  6 Mar 2026 11:12:38 -0700
Message-ID: <20260306181304.2426352-11-sjg@chromium.org>
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

Move about 10 test files for ChromeOS entries (GBB, vblock, FMAP)
into a cros/ subdirectory. Drop the numeric prefixes and update all
references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 doc/develop/binman_tests.rst                  |  2 +-
 tools/binman/ftest.py                         | 22 +++++++++----------
 .../test/{067_fmap.dts => cros/fmap.dts}      |  0
 .../binman/test/{071_gbb.dts => cros/gbb.dts} |  0
 .../gbb_no_size.dts}                          |  0
 .../gbb_too_small.dts}                        |  0
 .../test/{074_vblock.dts => cros/vblock.dts}  |  0
 .../vblock_bad_entry.dts}                     |  0
 .../vblock_bad_phandle.dts}                   |  0
 .../vblock_content.dts}                       |  0
 .../vblock_no_content.dts}                    |  0
 11 files changed, 12 insertions(+), 12 deletions(-)
 rename tools/binman/test/{067_fmap.dts => cros/fmap.dts} (100%)
 rename tools/binman/test/{071_gbb.dts => cros/gbb.dts} (100%)
 rename tools/binman/test/{073_gbb_no_size.dts => cros/gbb_no_size.dts} (100%)
 rename tools/binman/test/{072_gbb_too_small.dts => cros/gbb_too_small.dts} (100%)
 rename tools/binman/test/{074_vblock.dts => cros/vblock.dts} (100%)
 rename tools/binman/test/{077_vblock_bad_entry.dts => cros/vblock_bad_entry.dts} (100%)
 rename tools/binman/test/{076_vblock_bad_phandle.dts => cros/vblock_bad_phandle.dts} (100%)
 rename tools/binman/test/{189_vblock_content.dts => cros/vblock_content.dts} (100%)
 rename tools/binman/test/{075_vblock_no_content.dts => cros/vblock_no_content.dts} (100%)

diff --git a/doc/develop/binman_tests.rst b/doc/develop/binman_tests.rst
index 745ca259d44..c7fa9ae6199 100644
--- a/doc/develop/binman_tests.rst
+++ b/doc/develop/binman_tests.rst
@@ -436,7 +436,7 @@ correct. You can to this with ``terminal.capture()``, for example:
 .. code-block:: python
 
     with terminal.capture() as (_, stderr):
-        self._DoTestFile('071_gbb.dts', force_missing_bintools='futility',
+        self._DoTestFile('cros/gbb.dts', force_missing_bintools='futility',
                          entry_args=entry_args)
     err = stderr.getvalue()
     self.assertRegex(err, "Image 'image'.*missing bintools.*: futility")
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index d43bb9183bb..87055a53bdf 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -1816,7 +1816,7 @@ class TestFunctional(unittest.TestCase):
 
     def testFmap(self):
         """Basic test of generation of a flashrom fmap"""
-        data = self._DoReadFile('067_fmap.dts')
+        data = self._DoReadFile('cros/fmap.dts')
         fhdr, fentries = fmap_util.DecodeFmap(data[32:])
         expected = (U_BOOT_DATA + tools.get_bytes(ord('!'), 12) +
                     U_BOOT_DATA + tools.get_bytes(ord('a'), 12))
@@ -1898,7 +1898,7 @@ class TestFunctional(unittest.TestCase):
             'keydir': 'devkeys',
             'bmpblk': 'bmpblk.bin',
         }
-        data, _, _, _ = self._DoReadFileDtb('071_gbb.dts', entry_args=entry_args)
+        data, _, _, _ = self._DoReadFileDtb('cros/gbb.dts', entry_args=entry_args)
 
         # Since futility
         expected = (GBB_DATA + GBB_DATA + tools.get_bytes(0, 8) +
@@ -1908,14 +1908,14 @@ class TestFunctional(unittest.TestCase):
     def testGbbTooSmall(self):
         """Test for the Chromium OS Google Binary Block being large enough"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileDtb('072_gbb_too_small.dts')
+            self._DoReadFileDtb('cros/gbb_too_small.dts')
         self.assertIn("Node '/binman/gbb': GBB is too small",
                       str(e.exception))
 
     def testGbbNoSize(self):
         """Test for the Chromium OS Google Binary Block having a size"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileDtb('073_gbb_no_size.dts')
+            self._DoReadFileDtb('cros/gbb_no_size.dts')
         self.assertIn("Node '/binman/gbb': GBB must have a fixed size",
                       str(e.exception))
 
@@ -1925,7 +1925,7 @@ class TestFunctional(unittest.TestCase):
             'keydir': 'devkeys',
         }
         with terminal.capture() as (_, stderr):
-            self._DoTestFile('071_gbb.dts', force_missing_bintools='futility',
+            self._DoTestFile('cros/gbb.dts', force_missing_bintools='futility',
                              entry_args=entry_args)
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing bintools.*: futility")
@@ -1966,7 +1966,7 @@ class TestFunctional(unittest.TestCase):
         entry_args = {
             'keydir': 'devkeys',
         }
-        data, _, _, _ = self._DoReadFileDtb('074_vblock.dts',
+        data, _, _, _ = self._DoReadFileDtb('cros/vblock.dts',
                                             entry_args=entry_args)
         expected = U_BOOT_DATA + VBLOCK_DATA + U_BOOT_DTB_DATA
         self.assertEqual(expected, data)
@@ -1974,21 +1974,21 @@ class TestFunctional(unittest.TestCase):
     def testVblockNoContent(self):
         """Test we detect a vblock which has no content to sign"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('075_vblock_no_content.dts')
+            self._DoReadFile('cros/vblock_no_content.dts')
         self.assertIn("Node '/binman/vblock': Collection must have a 'content' "
                       'property', str(e.exception))
 
     def testVblockBadPhandle(self):
         """Test that we detect a vblock with an invalid phandle in contents"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('076_vblock_bad_phandle.dts')
+            self._DoReadFile('cros/vblock_bad_phandle.dts')
         self.assertIn("Node '/binman/vblock': Cannot find node for phandle "
                       '1000', str(e.exception))
 
     def testVblockBadEntry(self):
         """Test that we detect an entry that points to a non-entry"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('077_vblock_bad_entry.dts')
+            self._DoReadFile('cros/vblock_bad_entry.dts')
         self.assertIn("Node '/binman/vblock': Cannot find entry for node "
                       "'other'", str(e.exception))
 
@@ -2000,7 +2000,7 @@ class TestFunctional(unittest.TestCase):
             'keydir': 'devkeys',
         }
         data = self._DoReadFileDtb(
-            '189_vblock_content.dts', use_real_dtb=True, update_dtb=True,
+            'cros/vblock_content.dts', use_real_dtb=True, update_dtb=True,
             entry_args=entry_args)[0]
         hashlen = 32  # SHA256 hash is 32 bytes
         self.assertEqual(U_BOOT_DATA, data[:len(U_BOOT_DATA)])
@@ -2021,7 +2021,7 @@ class TestFunctional(unittest.TestCase):
             'keydir': 'devkeys',
         }
         with terminal.capture() as (_, stderr):
-            self._DoTestFile('074_vblock.dts',
+            self._DoTestFile('cros/vblock.dts',
                              force_missing_bintools='futility',
                              entry_args=entry_args)
         err = stderr.getvalue()
diff --git a/tools/binman/test/067_fmap.dts b/tools/binman/test/cros/fmap.dts
similarity index 100%
rename from tools/binman/test/067_fmap.dts
rename to tools/binman/test/cros/fmap.dts
diff --git a/tools/binman/test/071_gbb.dts b/tools/binman/test/cros/gbb.dts
similarity index 100%
rename from tools/binman/test/071_gbb.dts
rename to tools/binman/test/cros/gbb.dts
diff --git a/tools/binman/test/073_gbb_no_size.dts b/tools/binman/test/cros/gbb_no_size.dts
similarity index 100%
rename from tools/binman/test/073_gbb_no_size.dts
rename to tools/binman/test/cros/gbb_no_size.dts
diff --git a/tools/binman/test/072_gbb_too_small.dts b/tools/binman/test/cros/gbb_too_small.dts
similarity index 100%
rename from tools/binman/test/072_gbb_too_small.dts
rename to tools/binman/test/cros/gbb_too_small.dts
diff --git a/tools/binman/test/074_vblock.dts b/tools/binman/test/cros/vblock.dts
similarity index 100%
rename from tools/binman/test/074_vblock.dts
rename to tools/binman/test/cros/vblock.dts
diff --git a/tools/binman/test/077_vblock_bad_entry.dts b/tools/binman/test/cros/vblock_bad_entry.dts
similarity index 100%
rename from tools/binman/test/077_vblock_bad_entry.dts
rename to tools/binman/test/cros/vblock_bad_entry.dts
diff --git a/tools/binman/test/076_vblock_bad_phandle.dts b/tools/binman/test/cros/vblock_bad_phandle.dts
similarity index 100%
rename from tools/binman/test/076_vblock_bad_phandle.dts
rename to tools/binman/test/cros/vblock_bad_phandle.dts
diff --git a/tools/binman/test/189_vblock_content.dts b/tools/binman/test/cros/vblock_content.dts
similarity index 100%
rename from tools/binman/test/189_vblock_content.dts
rename to tools/binman/test/cros/vblock_content.dts
diff --git a/tools/binman/test/075_vblock_no_content.dts b/tools/binman/test/cros/vblock_no_content.dts
similarity index 100%
rename from tools/binman/test/075_vblock_no_content.dts
rename to tools/binman/test/cros/vblock_no_content.dts
-- 
2.43.0

