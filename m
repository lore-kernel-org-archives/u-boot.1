Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50354CD8CA8
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 01:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F7CD849F3;
	Wed, 10 Jun 2026 03:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gfmv5tGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5CE3849E5; Wed, 10 Jun 2026 03:27:49 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67697849BC
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 03:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F0B17602CE;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DC25C4AF11;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781054861;
 bh=+uOjiKhq9rNmaQ7Lz9L2LlojHZ2+hutBVOrXGvPE0TY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Gfmv5tGHDKIWZnf/xb4+t/21OEER3JOJOpJYu1Dg3J3WBc/PQoNBQTdteait3l7ql
 vYQMW7dJHkL/toWi2DumWQJs9S/j5mjkDym9YMoJvxeQ99mI77x0LnIwARh54jl3MM
 6XioPGm2Z/NrEaxy46gU5mRlijEUGN+fLTNdoQoAob66fwCE2rsM0wrEUfNuRZ8975
 ETdaFTIQNXEaDw7rfS8M39jPQnZKxpbF/NsTMVaoQuDhcfdQ1kN7gQFyqDs3C8JybS
 7Q9fCqy/KZxEtRyeYvlz2dyhmnOcwgHiIfHRQkqVwYDOqvY0TTivOjBzhgRkXBSI0G
 gvOz6YLdGD/yA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 97552CD8CA8;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Wed, 10 Jun 2026 11:27:44 +1000
Subject: [PATCH v3 06/10] binman: android_boot: vendor-dt support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-android-binman-v3-6-710298a38fcc@samcday.com>
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>, 
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>, yan wang <yan.wang@softathome.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781054859; l=8769;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=M3z39A59L6qbN8lE1J6Ak+ujO7EigVnuIoGTDUfQGu0=;
 b=PV2jz/xZG4SAr8dZNo6pPv0NqvT5QpzABuuZQSFRKsaJEdvZIdn38tkSKnlREWq5OzhBggunT
 aWa9GmJ9GuIDKSUUE3cR/Lj5YdazSRIVRFT+kTrcNosX7L4ThPxxVWJ
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

There's many Android bootloaders out there that expect non-standard
abootimgs. Samsung and Qualcomm, and likely many others. This quirk has
been codified in the widely used osm0sis fork/rewrite of mkbootimg.

Presumably, these vendor-specific abootimgs were conceived before the v2
format was widely available or specified. The evidence for this is their
hijacking of the header_version field to specify the length of a payload
that follows the main abootimg.

At least QCDT and DTBH (both of which will be implemented as binman
etypes in following commits) use this approach.

Link: https://github.com/osm0sis/mkbootimg
Signed-off-by: Sam Day <me@samcday.com>
---
 tools/binman/etype/android_boot.py           | 41 ++++++++++++++++++++++++++--
 tools/binman/ftest.py                        | 15 ++++++++++
 tools/binman/test/android_boot_vendor_dt.dts | 27 ++++++++++++++++++
 3 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
index 8b72d90acc5..5cfa71ee981 100644
--- a/tools/binman/etype/android_boot.py
+++ b/tools/binman/etype/android_boot.py
@@ -33,6 +33,9 @@ class Entry_android_boot(Entry_section):
     A kernel payload, optional ramdisk payload can be supplied. A DTB payload
     can also be provided when header_version == v2.
 
+    Vendor-specific payloads are also supported. These are non-standard
+    v0 images with a special DT container format appended.
+
     Properties / Entry arguments:
         - header-version: Android boot image header version, must be 0 or 2,
           defaults to 0
@@ -50,6 +53,7 @@ class Entry_android_boot(Entry_section):
         - kernel: section containing the executable payload
         - dtb: section containing the DTB payload, used by header version 2 only
         - ramdisk: optional section containing a ramdisk payload
+        - vendor-dt: legacy vendor DT payload, used by header version 0 only
 
     Example::
         A v2 abootimg with control FDT placed in the DTB section:
@@ -112,6 +116,7 @@ class Entry_android_boot(Entry_section):
         self.os_version = fdt_util.GetInt(self._node, 'os-version', 0)
         self.boot_name = fdt_util.GetString(self._node, 'boot-name', '')
         self.cmdline = fdt_util.GetString(self._node, 'cmdline', '')
+        self.vendor_dt_node = self._node.FindNode('vendor-dt')
 
         if self.header_version not in (0, 2):
             self.Raise('Only Android boot image header versions 0 and 2 are '
@@ -132,9 +137,15 @@ class Entry_android_boot(Entry_section):
                 self.Raise('page-size must fit the Android boot image header')
             if 'dtb' not in self._entries:
                 self.Raise("Missing required subnode 'dtb'")
+            if self.vendor_dt_node:
+                self.Raise("Subnode 'vendor-dt' requires header-version 0")
 
     def ReadEntries(self):
         for node in self._node.subnodes:
+            if node.name == 'vendor-dt':
+                self._ReadVendorDtEntries(node)
+                continue
+
             if node.name not in ('kernel', 'ramdisk', 'dtb'):
                 self.Raise("Unexpected subnode '%s'" % node.name)
 
@@ -145,6 +156,14 @@ class Entry_android_boot(Entry_section):
             entry.SetPrefix(self._name_prefix)
             self._entries[node.name] = entry
 
+    def _ReadVendorDtEntries(self, vendor_dt_node):
+        entry = Entry.Create(self, vendor_dt_node, etype='section',
+                             expanded=self.GetImage().use_expanded,
+                             missing_etype=self.GetImage().missing_etype)
+        entry.ReadNode()
+        entry.SetPrefix(self._name_prefix)
+        self._entries[vendor_dt_node.name] = entry
+
     def _GetIntCells(self, propname, default):
         prop = self._node.props.get(propname)
         if not prop:
@@ -198,8 +217,14 @@ class Entry_android_boot(Entry_section):
             return default
         return entry.GetData(required)
 
+    def _BuildVendorDt(self, required):
+        if not self.vendor_dt_node:
+            return b''
+        return self._GetEntryData('vendor-dt', required)
+
     def _BuildV0SectionData(self, required):
         kernel = self._GetEntryData('kernel', required)
+        vendor_dt = self._BuildVendorDt(required)
         ramdisk = self._GetEntryData('ramdisk', required, b'')
         if not required and (kernel is None or vendor_dt is None or
                              ramdisk is None):
@@ -211,8 +236,18 @@ class Entry_android_boot(Entry_section):
                                  BOOT_ARGS_SIZE)
 
         boot_id_payloads = [kernel, ramdisk, b'']
+        if self.vendor_dt_node:
+            boot_id_payloads.append(vendor_dt)
         image_id = self._BootId(*boot_id_payloads)
 
+        overloaded_header_version =  self.header_version
+        if self.vendor_dt_node:
+            # vendor DTs overload the header_version field to store the length
+            # of the appended payload. Hopefully AOSP abootimg never progresses
+            # to v8192-ish or we might have some real specificity problems on
+            # our hands.
+            overloaded_header_version = len(vendor_dt)
+
         header = struct.pack(BOOT_IMAGE_HEADER_V0,
                              BOOT_MAGIC,
                              len(kernel),
@@ -223,7 +258,7 @@ class Entry_android_boot(Entry_section):
                              0, # second_offset
                              self._GetAddr(self.tags_offset, 'tags'),
                              self.page_size,
-                             self.header_version,
+                             overloaded_header_version,
                              self.os_version,
                              boot_name,
                              cmdline,
@@ -233,6 +268,7 @@ class Entry_android_boot(Entry_section):
         image += self.PadToAlignment(header, self.page_size)
         image += self.PadToAlignment(kernel, self.page_size)
         image += self.PadToAlignment(ramdisk, self.page_size)
+        image += self.PadToAlignment(vendor_dt, self.page_size)
 
         return bytes(image)
 
@@ -240,7 +276,8 @@ class Entry_android_boot(Entry_section):
         kernel = self._GetEntryData('kernel', required)
         dtb = self._GetEntryData('dtb', required)
         ramdisk = self._GetEntryData('ramdisk', required, b'')
-        if not required and (kernel is None or dtb is None):
+        if not required and (kernel is None or dtb is None or
+                             ramdisk is None):
             return None
 
         boot_name = self._CheckFit('boot-name', self.boot_name.encode('ascii'),
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 71740205c72..bbdcb721eca 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5746,6 +5746,21 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertIn("Subnode 'vendor-dt' requires header-version 0",
                       str(exc.exception))
 
+    def testAndroidBootVendorDt(self):
+        """Test that android-boot can embed an arbitrary vendor-dt section"""
+        data = self._DoReadFile('android_boot_vendor_dt.dts')
+        header = struct.unpack_from('<8s10I16s512s32s', data, 0)
+        page_size = 2048
+        vendor_dt_offset = page_size * 3
+        vendor_dt = b'howdy'
+        self.assertEqual(len(vendor_dt), header[9])
+        self.assertEqual(0, header[10])
+        self.assertEqual(self._AndroidBootId(U_BOOT_DATA, b'\0', b'',
+                                             vendor_dt), header[13])
+        self.assertEqual(vendor_dt + b'\0' * (page_size - len(vendor_dt)),
+                         data[vendor_dt_offset:vendor_dt_offset + page_size])
+        self.assertEqual(vendor_dt_offset + page_size, len(data))
+
     def testFitFdtOper(self):
         """Check handling of a specified FIT operation"""
         entry_args = {
diff --git a/tools/binman/test/android_boot_vendor_dt.dts b/tools/binman/test/android_boot_vendor_dt.dts
new file mode 100644
index 00000000000..194396a0880
--- /dev/null
+++ b/tools/binman/test/android_boot_vendor_dt.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	binman {
+		android-boot {
+			header-version = <0>;
+			kernel {
+				u-boot {
+					no-expanded;
+				};
+			};
+			ramdisk {
+				fill {
+					size = <1>;
+				};
+			};
+			vendor-dt {
+				text {
+					size = <5>;
+					text = "howdy";
+				};
+			};
+		};
+	};
+};

-- 
2.54.0


