Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF81CD6E55
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 04:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3865784932;
	Sat,  6 Jun 2026 06:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SeRldPu5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC518848A9; Sat,  6 Jun 2026 02:52:47 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F10D848F5
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 02:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B1A4D445A3;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94097C2BCC6;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780707160;
 bh=+Hbm6Pbvur/td6+Ofr69/UgYCwMPAzZ9xGsscWJCGpI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=SeRldPu5OcTYfMxd+G9RxmAHUbN8rNb5Q9PjlWZHuUuGohzv0u8mXB9ydwD/c+o7B
 gmAyUVgSY/TKb+T6FofYsyGaDuRUvEwgr8IbVuLogqyDHkekB3t2MShO2X9FU/CsAq
 u+WSiecK+V9LfiBSqT9s82ss7qCMQpQP4oGNINkKDOXcDHxbbmsqURPDt2LKlUgG4I
 WxbgJzh6dFRtRI8ZQvg8DXyhjXdEUXvToRdqzI7ieonslgVUmp2IKNMPGY5Mr+ypZS
 ReCjmA4QGIoqikJGWm7pL3oSqfJBIzXMVbwdgyQYgLOf4fwKGu0ksBg/43Nw1IFoQd
 G/p8f0P3gMVSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8C504CD6E7B;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Sat, 06 Jun 2026 10:52:40 +1000
Subject: [PATCH 06/13] binman: android_boot: vendor-dt support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-android-binman-v1-6-c7a3c14b8a3d@samcday.com>
References: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
In-Reply-To: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>, 
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Denis Mukhin <dmukhin@ford.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Javier Tia <floss@jetm.me>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780707158; l=8418;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=jPM8z+ieGpV/JiEvr08Kh4lQN5KkdQ755eIxfrZLmSA=;
 b=HLejM/M8RIc6N1+FxYOAxRbe6LJc3398TP9CXlcqyzmd6ydAfg7OtsiYyW7lSaLBGRuCnOh8d
 TZDg6bq7wB1Bgnc3wVcvSvRfncM1ZDfi8bMzOE3TQxjIWwYc2XCJW9m
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
X-Mailman-Approved-At: Sat, 06 Jun 2026 06:27:39 +0200
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
 tools/binman/etype/android_boot.py                 | 38 ++++++++++++++++++++--
 tools/binman/ftest.py                              | 11 ++++++-
 .../binman/test/vendor/android_boot_vendor_dt.dts  | 27 +++++++++++++++
 3 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
index adf8248ee12..fa5dd746411 100644
--- a/tools/binman/etype/android_boot.py
+++ b/tools/binman/etype/android_boot.py
@@ -40,6 +40,9 @@ class Entry_android_boot(Entry_section):
     A kernel payload, optional ramdisk payload can be supplied. A DTB payload
     can also be provided when header_version == v2.
 
+    Vendor-specific payloads are also supported. These are non-standard
+    v0 images with a special DT container format appended.
+
     Properties / Entry arguments:
         - header-version: Android boot image header version, must be 0 or 2,
           defaults to 0
@@ -52,11 +55,13 @@ class Entry_android_boot(Entry_section):
         - os-version: Encoded Android OS version and patch level, defaults to 0
         - boot-name: Android boot image board name
         - cmdline: Android boot command line
+          used by header version 0 only
 
     This entry uses the following subnodes:
         - kernel: section containing the executable payload
         - dtb: section containing the DTB payload, used by header version 2 only
         - ramdisk: optional section containing a ramdisk payload
+        - vendor-dt: legacy vendor DT payload, used by header version 0 only
 
     Example::
         A v2 abootimg with control FDT placed in the DTB section:
@@ -117,6 +122,7 @@ class Entry_android_boot(Entry_section):
         self.os_version = fdt_util.GetInt(self._node, 'os-version', 0)
         self.boot_name = fdt_util.GetString(self._node, 'boot-name', '')
         self.cmdline = fdt_util.GetString(self._node, 'cmdline', '')
+        self.vendor_dt_node = self._node.FindNode('vendor-dt')
 
         if self.header_version not in (0, 2):
             self.Raise('Only Android boot image header versions 0 and 2 are '
@@ -131,17 +137,26 @@ class Entry_android_boot(Entry_section):
                 self.Raise('page-size must fit the Android boot image header')
             if 'dtb' in self._entries:
                 self.Raise("Subnode 'dtb' requires header-version 2")
+            if self.vendor_dt_node and self.os_version:
+                self.Raise("os_version not allowed when vendor-dt is in use")
         else:
             # v2
             if self.page_size < BOOT_IMAGE_HEADER_V2_SIZE:
                 self.Raise('page-size must fit the Android boot image header')
             if 'dtb' not in self._entries:
                 self.Raise("Missing required subnode 'dtb'")
+            if self.vendor_dt_node:
+                self.Raise("Subnode 'vendor-dt' requires header-version 0")
 
     def ReadEntries(self):
         for node in self._node.subnodes:
             if self.IsSpecialSubnode(node):
                 continue
+
+            if node.name == 'vendor-dt':
+                self._ReadVendorDtEntries(node)
+                continue
+
             if node.name not in ('kernel', 'ramdisk', 'dtb'):
                 self.Raise("Unexpected subnode '%s'" % node.name)
 
@@ -152,6 +167,15 @@ class Entry_android_boot(Entry_section):
             entry.SetPrefix(self._name_prefix)
             self._entries[node.name] = entry
 
+    def _ReadVendorDtEntries(self, vendor_dt_node):
+        entry = Entry.Create(self, vendor_dt_node, etype='section',
+                             expanded=self.GetImage().use_expanded,
+                             missing_etype=self.GetImage().missing_etype)
+        entry.page_size = fdt_util.GetInt(self._node, 'page-size', 2048)
+        entry.ReadNode()
+        entry.SetPrefix(self._name_prefix)
+        self._entries[vendor_dt_node.name] = entry
+
     def _GetIntCells(self, propname, default):
         prop = self._node.props.get(propname)
         if not prop:
@@ -243,11 +267,18 @@ class Entry_android_boot(Entry_section):
         fdt.pack()
         return bytes(fdt.as_bytearray())
 
+    def _BuildVendorDt(self, required):
+        if not self.vendor_dt_node:
+            return b''
+        return self._GetEntryData('vendor-dt', required)
+
     def _BuildV0SectionData(self, required):
         kernel = self._GetEntryData('kernel', required)
         if kernel is None:
             return None
-
+        vendor_dt = self._BuildVendorDt(required)
+        if vendor_dt is None:
+            return None
         ramdisk = self._GetOptionalEntryData('ramdisk', required)
         if ramdisk is None:
             return None
@@ -258,6 +289,8 @@ class Entry_android_boot(Entry_section):
                                  BOOT_ARGS_SIZE)
 
         boot_id_payloads = [kernel, ramdisk, b'']
+        if self.vendor_dt_node:
+            boot_id_payloads.append(vendor_dt)
         image_id = self._BootId(*boot_id_payloads)
 
         header = struct.pack(BOOT_IMAGE_HEADER_V0,
@@ -270,7 +303,7 @@ class Entry_android_boot(Entry_section):
                              0, # second_offset
                              self._GetAddr(self.tags_offset, 'tags'),
                              self.page_size,
-                             self.header_version,
+                             len(vendor_dt),
                              self.os_version,
                              boot_name,
                              cmdline,
@@ -280,6 +313,7 @@ class Entry_android_boot(Entry_section):
         image += _pad(header, self.page_size)
         image += _pad(kernel, self.page_size)
         image += _pad(ramdisk, self.page_size)
+        image += _pad(vendor_dt, self.page_size)
 
         return bytes(image)
 
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index e92a231417b..80219e519f6 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5662,7 +5662,16 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertEqual(U_BOOT_DTB_DATA,
                          data[0x1000:0x1000 + len(U_BOOT_DTB_DATA)])
 
-        self.assertEqual(U_BOOT_DATA, data[0x800:0x800 + len(U_BOOT_DATA)])
+    def testAndroidBootVendorDt(self):
+        """Test that android-boot can embed an arbitrary vendor-dt section"""
+        data = self._DoReadFile('vendor/android_boot_vendor_dt.dts')
+        header = struct.unpack_from('<8s10I16s512s32s', data, 0)
+        vendor_dt = b'howdy'
+        self.assertEqual(len(vendor_dt), header[9])
+        self.assertEqual(0, header[10])
+        self.assertEqual(self._AndroidBootId(U_BOOT_DATA, b'\0', b'',
+                                             vendor_dt), header[13])
+        self.assertEqual(vendor_dt, data[0x1800:0x1805])
 
     def testFitFdtOper(self):
         """Check handling of a specified FIT operation"""
diff --git a/tools/binman/test/vendor/android_boot_vendor_dt.dts b/tools/binman/test/vendor/android_boot_vendor_dt.dts
new file mode 100644
index 00000000000..194396a0880
--- /dev/null
+++ b/tools/binman/test/vendor/android_boot_vendor_dt.dts
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


