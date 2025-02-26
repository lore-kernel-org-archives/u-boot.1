Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4FFC18E7C
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11DBA812C8;
	Wed, 26 Feb 2025 17:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k3M27sMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB84C81250; Wed, 26 Feb 2025 17:26:51 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F1D7811DE
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-855d6bdfe05so170702439f.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 08:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740587207; x=1741192007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sHzmSF/CHIp0tKZiHKGW54Jf7ZY8ct+6+zQD8XeXfko=;
 b=k3M27sMGkttTAbptQWY5SdVQ95swtjlPm+ytplag4YPNezFPOvI7tUHoNoGNKOFYpp
 34iE4IKkxwvSoaBDvLEseQgdo/SQGisB1VyRKchggAW5QcODKQTZAK8WDsq4yIQXZV9I
 dVvp/0nrf4YXPgv8cUKIhTvtOxaGre23B49L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740587207; x=1741192007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sHzmSF/CHIp0tKZiHKGW54Jf7ZY8ct+6+zQD8XeXfko=;
 b=Ex8HXDqKMWtqWjsx+IHeX09odi9iftXQfJDXYwwAZ6NWFmwEkcdy+EiJz2Tq5XSS2j
 +KIB6I/Bm4PANYXoBlDKmRpNuMoPuR66Y9hc4piOwUZBwFMymoiX3limm1PRgmt8Qsvb
 CFG4mVI3yzRAKVPin/FER17X/joNrYsvflRxZ8Er7qfnJiuqQaJ5CzAmsNP/IK4A3yKe
 VCGBRObZ/DGP5l466mK+yCZd8yqpCo7qjhxKcJfX1NWNH4QDoUR8/KeOA7CpD848K3Rt
 5SrybNoPZTDaeIVGKbiXyvs5JscsOHcTTYggLJbFQODBa8yJn/qaDvxhJJ2Or32usAeN
 uGGg==
X-Gm-Message-State: AOJu0YwwUKbNFmaEMJNfjz+eJPgXSQFRCJztLSzNWEPw+DrNRe9tnJ+A
 oPeSWUIB59qEp5FJBgSZDHP/tqzOS83Nzf2gK5Z2+2zCmzsqnfy2hT0N2mDPYqCe8Wn2cQZ/8MI
 =
X-Gm-Gg: ASbGncvp5NmVVO3XMzp2FVR95HdBN1BDjOcfjo5BMR2jjSOoCtVmvlwQGJj06eb9dtZ
 zwKh/RKCIDMZNI5SMIBkFNPTYuk92jS8xNsesrXpxNgicEul+K3GOZZxF3RQpg4jAKWWV0xHBX8
 iGj/ROOU2XaznvYEIV/UE2bjja6upu2dS+vGUoG5CRYh6+ea7TqPdo+DJuckrHIT1XrLtIohZ6E
 8FZa3DLGN0frxRLyZjDRmSv7vsAOVHHMVkHMIbC6kYPK6kTOQPmMYfdJFyy9oMbuoetUF0ikTII
 hHETndhLAUnm/suYwyQMRG8G9Jf6NG70A4RPHKZEAkCExAPJT426JFZ/+OaPpqE=
X-Google-Smtp-Source: AGHT+IE6ip02WOlcna3iGxauSQtrPxeyn7LhnVLRmf1YkoC0zTbioHgkYchZWE5vnH8hqfEQsJCBuQ==
X-Received: by 2002:a05:6602:2cd0:b0:855:b27c:e834 with SMTP id
 ca18e2360f4ac-85620156dddmr739966239f.5.1740587207403; 
 Wed, 26 Feb 2025 08:26:47 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85620a2f9c6sm77857539f.21.2025.02.26.08.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 08:26:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lothar Rubusch <l.rubusch@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/5] binman: Honour the skip-at-start property more
 faithfully
Date: Wed, 26 Feb 2025 09:26:17 -0700
Message-ID: <20250226162621.2681677-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226162621.2681677-1-sjg@chromium.org>
References: <20250226162621.2681677-1-sjg@chromium.org>
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

(no changes since v1)

 tools/binman/binman.rst       | 47 +++++++++++++++++++++--------------
 tools/binman/entry.py         |  3 +--
 tools/binman/etype/fmap.py    |  4 +--
 tools/binman/etype/section.py |  2 +-
 tools/binman/ftest.py         | 26 ++++++++++---------
 5 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 990fc295770..84b1331df5c 100644
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
     Specifies the default alignment for entries in this section if they do
     not specify an alignment. Note that this only applies to top-level entries
@@ -957,6 +939,35 @@ filename:
     section in different image, since there is currently no way to share data
     between images other than through files.
 
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
index d2802f67e2d..25615284b29 100644
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
@@ -4773,7 +4775,7 @@ class TestFunctional(unittest.TestCase):
         entry = image.GetEntries()['fdtmap']
         self.assertEqual(orig_entry.offset, entry.offset)
         self.assertEqual(orig_entry.size, entry.size)
-        self.assertEqual(16, entry.image_pos)
+        self.assertEqual((1 << 32) - 0x400 + 16, entry.image_pos)
 
         u_boot = image.GetEntries()['section'].GetEntries()['u-boot']
 
-- 
2.43.0

