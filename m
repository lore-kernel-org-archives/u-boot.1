Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702B3C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 23:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0380A80F6B;
	Sun, 26 Jan 2025 00:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X6tjO0G/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC56680F77; Sun, 26 Jan 2025 00:38:39 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FB2B80F4B
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 00:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-851c4f1fb18so88673839f.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 15:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737848315; x=1738453115; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kd/IklRVZj6b8DomFR5fMH6TEjOkxyr8cwb1Ow7esH8=;
 b=X6tjO0G/rxhjgU337+rLEgz2QivFBISqIUcqVkEtT8+lGC4be7h8WiHP2GMd2G7ck0
 raTUK1eQjD0fi50zKv5NSvVeLbu1P0JS/2jm/Y/zWjuP8mCxTQKzl6VhYTaQplcDW5Ac
 atu6+gBdenPep2H4okdPOIh5L/ZrrmYXm126I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737848315; x=1738453115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kd/IklRVZj6b8DomFR5fMH6TEjOkxyr8cwb1Ow7esH8=;
 b=fvWerGHREWsMvRF7Iafoz3khMkRwNe9Zh6INKyHnB5BtGh/6p2fL/GvcbQ22YFA9Xj
 diVp2dZtIHztA/Nx5cjEHlQLxIpyNh5SC6+Jdg/Ybed/2Gi0O+R3m/gN7edKQzvSc6O6
 g27Fmt/JddLCLR750WZ4OQZ9J+dXDWq7FUf2VWFV3UIcvHuYgt/ymuOnLJphGj7HKBGA
 EFuT2NvR+ihEeQS6wIPlgFq/ItSuaJA43qFWiDEpcRbeIQmVPDW8q2NP5+jjSZZZOP5O
 rTc/6HwrxDIKgaUOCIKeWmSXW8eINy0U/nxQwyU/Hj7Qc9UXhwtc2L58gnQKM7axRup4
 Zc+Q==
X-Gm-Message-State: AOJu0YyD5TNky5dSY40R2dcPSMi+v3nkGMddfE/Ae3cNTCJ+TGEJtG/o
 YlZHYD0k+cDqVNUGWgs4RpfKvWlL4yX7BJk6hk8Bme3MpgsOP/ORjd4ORdsSvROXYv6eQjiGU9c
 =
X-Gm-Gg: ASbGncviNghevCvGwnjg+Sp3oO1V5fGBv3lzg08bvRChSZyiN5XA+8tTZ3bLcXBY9o6
 F680QfuUwwFN7CjdG/urPnC/ec3JTixB+zLwlN1hATDiJJt9TfDuewNJJQF+joVHwr9PT9bBw2U
 NU/VAAHQRCo9EXRLYaYSQcAhfZyo4ByfYIKSgDtLIgS0hKZqkxFywunr0f4VgryRxcuJi3diw90
 cNsIy/AoMkAE4BwEG029r8tndrrTKhBgiPd9EY87IlDmnqoQRQ1HxPLWgbj0tRb3h6yY0/RUUmy
 UQuHCz7sq5CIbFDstqwwb3TSTRKqnhZd9eB8rvBETYccLAqDpzDm
X-Google-Smtp-Source: AGHT+IH5dSKr9Wa82uljpdQ5iO8n/H73aOQwfNe78ijK4W4lG+1GreW4VAvzD7RvTVUaL9ZGYTt3cA==
X-Received: by 2002:a05:6602:600a:b0:851:efec:53ad with SMTP id
 ca18e2360f4ac-851efec5d03mr1847503939f.7.1737848315485; 
 Sat, 25 Jan 2025 15:38:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8521de11161sm171496339f.15.2025.01.25.15.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 15:38:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] binman: Honour the skip-at-start property more faithfully
Date: Sat, 25 Jan 2025 16:38:12 -0700
Message-ID: <20250125233826.2173192-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250125233826.2173192-1-sjg@chromium.org>
References: <20250125233826.2173192-1-sjg@chromium.org>
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

A discussion on the mailing list about dealing with block offsets and
binman symbols made me think that something is wrong with how Binman
deals with the skip-at-start property.

The feature was originally designed to handle x86 ROMs, which are mapped
at the top of the address space. That seemed too specific, whereas
skipping some space at the start seemed more generally useful.

It has proved useful. For example, rockchip images start at block 64,
so a skip-at-start of 0x8000 deals with this.

But it doesn't actually work correctly, since the image_pos value does
not give the actual position on the media.

Fix this and update the documentation, moving it into the 'section'
section.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/binman.rst       | 47 +++++++++++++++++++++--------------
 tools/binman/entry.py         |  3 +--
 tools/binman/etype/fmap.py    |  4 +--
 tools/binman/etype/section.py |  2 +-
 tools/binman/ftest.py         | 26 ++++++++++---------
 5 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 381e55686f9..e27054a9c67 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -823,24 +823,6 @@ multiple-images:
             };
         };
 
-end-at-4gb:
-    For x86 machines the ROM offsets start just before 4GB and extend
-    up so that the image finished at the 4GB boundary. This boolean
-    option can be enabled to support this. The image size must be
-    provided so that binman knows when the image should start. For an
-    8MB ROM, the offset of the first entry would be 0xfff80000 with
-    this option, instead of 0 without this option.
-
-skip-at-start:
-    This property specifies the entry offset of the first entry.
-
-    For PowerPC mpc85xx based CPU, CONFIG_TEXT_BASE is the entry
-    offset of the first entry. It can be 0xeff40000 or 0xfff40000 for
-    nor flash boot, 0x201000 for sd boot etc.
-
-    'end-at-4gb' property is not applicable where CONFIG_TEXT_BASE +
-    Image size != 4gb.
-
 align-default:
     Specifies the default alignment for entries in this section, if they do
     not specify an alignment. Note that this only applies to top-level entries
@@ -957,6 +939,35 @@ filename:
     section in different image, since there is currently no way to share data
     beteen images other than through files.
 
+end-at-4gb:
+    For x86 machines the ROM offsets start just before 4GB and extend
+    up so that the image finished at the 4GB boundary. This boolean
+    option can be enabled to support this. The image size must be
+    provided so that binman knows when the image should start. For an
+    8MB ROM, the offset of the first entry would be 0xfff80000 with
+    this option, instead of 0 without this option.
+
+skip-at-start:
+    This property specifies the entry offset of the first entry in the section.
+    It is useful when the Binman image is written to a particular offset in the
+    media. It allows the offset of the first entry to be the media offset, even
+    though it is at the start of the image. It effectively creates a hole at the
+    start of the image, an implied, empty area.
+
+    For example, if the image is written to offset 4K on the media, set
+    skip-at-start to 0x1000. At runtime, the Binman image will assume that it
+    has be written at offset 4K and all symbols and offsets will take account of
+    that. The image-pos values will also be adjusted. The effect is similar to
+    adding an empty 4K region at the start, except that Binman does not actually
+    output it.
+
+    For PowerPC mpc85xx based CPU, CONFIG_TEXT_BASE is the entry
+    offset of the first entry. It can be 0xeff40000 or 0xfff40000 for
+    nor flash boot, 0x201000 for sd boot etc.
+
+    'end-at-4gb' property is not applicable where CONFIG_TEXT_BASE +
+    Image size != 4gb.
+
 Image Properties
 ----------------
 
diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index e506b552a8d..bdc60e47fca 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -392,9 +392,8 @@ class Entry(object):
         """Set the value of device-tree properties calculated by binman"""
         state.SetInt(self._node, 'offset', self.offset)
         state.SetInt(self._node, 'size', self.size)
-        base = self.section.GetRootSkipAtStart() if self.section else 0
         if self.image_pos is not None:
-            state.SetInt(self._node, 'image-pos', self.image_pos - base)
+            state.SetInt(self._node, 'image-pos', self.image_pos)
         if self.GetImage().allow_repack:
             if self.orig_offset is not None:
                 state.SetInt(self._node, 'orig-offset', self.orig_offset, True)
diff --git a/tools/binman/etype/fmap.py b/tools/binman/etype/fmap.py
index 3669d91a0bc..35ca8490f79 100644
--- a/tools/binman/etype/fmap.py
+++ b/tools/binman/etype/fmap.py
@@ -65,7 +65,7 @@ class Entry_fmap(Entry):
                 if entry.image_pos is None:
                     pos = 0
                 else:
-                    pos = entry.image_pos - entry.GetRootSkipAtStart()
+                    pos = entry.image_pos
 
                 # Drop @ symbols in name
                 name = entry.name.replace('@', '')
@@ -75,8 +75,6 @@ class Entry_fmap(Entry):
                     _AddEntries(areas, subentry)
             else:
                 pos = entry.image_pos
-                if pos is not None:
-                    pos -= entry.section.GetRootSkipAtStart()
                 areas.append(fmap_util.FmapArea(pos or 0, entry.size or 0,
                                                 entry.name, flags))
 
diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index 020fd57d704..5e11cf58d28 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -801,7 +801,7 @@ class Entry_section(Entry):
         if not entry:
             self._Raise("Unable to set offset/size for unknown entry '%s'" %
                         name)
-        entry.SetOffsetSize(self._skip_at_start + offset if offset is not None
+        entry.SetOffsetSize(offset + self._skip_at_start if offset is not None
                             else None, size)
 
     def GetEntryOffsets(self):
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 156567ace77..fb99c185c80 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -2297,16 +2297,17 @@ class TestFunctional(unittest.TestCase):
         fhdr, fentries = fmap_util.DecodeFmap(data[32:])
 
         self.assertEqual(0x100, fhdr.image_size)
+        base = (1 << 32) - 0x100
 
-        self.assertEqual(0, fentries[0].offset)
+        self.assertEqual(base, fentries[0].offset)
         self.assertEqual(4, fentries[0].size)
         self.assertEqual(b'U_BOOT', fentries[0].name)
 
-        self.assertEqual(4, fentries[1].offset)
+        self.assertEqual(base + 4, fentries[1].offset)
         self.assertEqual(3, fentries[1].size)
         self.assertEqual(b'INTEL_MRC', fentries[1].name)
 
-        self.assertEqual(32, fentries[2].offset)
+        self.assertEqual(base + 32, fentries[2].offset)
         self.assertEqual(fmap_util.FMAP_HEADER_LEN +
                          fmap_util.FMAP_AREA_LEN * 3, fentries[2].size)
         self.assertEqual(b'FMAP', fentries[2].name)
@@ -2319,27 +2320,28 @@ class TestFunctional(unittest.TestCase):
         fhdr, fentries = fmap_util.DecodeFmap(data[36:])
 
         self.assertEqual(0x180, fhdr.image_size)
+        base = (1 << 32) - 0x180
         expect_size = fmap_util.FMAP_HEADER_LEN + fmap_util.FMAP_AREA_LEN * 4
         fiter = iter(fentries)
 
         fentry = next(fiter)
         self.assertEqual(b'U_BOOT', fentry.name)
-        self.assertEqual(0, fentry.offset)
+        self.assertEqual(base, fentry.offset)
         self.assertEqual(4, fentry.size)
 
         fentry = next(fiter)
         self.assertEqual(b'SECTION', fentry.name)
-        self.assertEqual(4, fentry.offset)
+        self.assertEqual(base + 4, fentry.offset)
         self.assertEqual(0x20 + expect_size, fentry.size)
 
         fentry = next(fiter)
         self.assertEqual(b'INTEL_MRC', fentry.name)
-        self.assertEqual(4, fentry.offset)
+        self.assertEqual(base + 4, fentry.offset)
         self.assertEqual(3, fentry.size)
 
         fentry = next(fiter)
         self.assertEqual(b'FMAP', fentry.name)
-        self.assertEqual(36, fentry.offset)
+        self.assertEqual(base + 36, fentry.offset)
         self.assertEqual(expect_size, fentry.size)
 
     def testElf(self):
@@ -3535,8 +3537,8 @@ class TestFunctional(unittest.TestCase):
         image = control.images['image']
         entries = image.GetEntries()
         desc = entries['intel-descriptor']
-        self.assertEqual(0xff800000, desc.offset);
-        self.assertEqual(0xff800000, desc.image_pos);
+        self.assertEqual(0xff800000, desc.offset)
+        self.assertEqual(0xff800000, desc.image_pos)
 
     def testReplaceCbfs(self):
         """Test replacing a single file in CBFS without changing the size"""
@@ -3778,8 +3780,8 @@ class TestFunctional(unittest.TestCase):
 
         image = control.images['image']
         entries = image.GetEntries()
-        expected_ptr = entries['intel-fit'].image_pos - (1 << 32)
-        self.assertEqual(expected_ptr, ptr)
+        expected_ptr = entries['intel-fit'].image_pos #- (1 << 32)
+        self.assertEqual(expected_ptr, ptr + (1 << 32))
 
     def testPackIntelFitMissing(self):
         """Test detection of a FIT pointer with not FIT region"""
@@ -4751,7 +4753,7 @@ class TestFunctional(unittest.TestCase):
         entry = image.GetEntries()['fdtmap']
         self.assertEqual(orig_entry.offset, entry.offset)
         self.assertEqual(orig_entry.size, entry.size)
-        self.assertEqual(16, entry.image_pos)
+        self.assertEqual((1 << 32) - 0x400 + 16, entry.image_pos)
 
         u_boot = image.GetEntries()['section'].GetEntries()['u-boot']
 
-- 
2.43.0

