Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFC8CD8C9F
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 23:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 969B8846D3;
	Mon,  8 Jun 2026 01:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sR7GVL/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2E13846A7; Mon,  8 Jun 2026 01:37:21 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C8C84715
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 01:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6FA9144176;
 Sun,  7 Jun 2026 23:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51496C2BCB4;
 Sun,  7 Jun 2026 23:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780875435;
 bh=KWP1DcG4onuGbSFLiHHvcPKhl/6n3+cEVe5DtEJnQOI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=sR7GVL/FIZ02UAbkjulv/iWsHN+AA95majZ16l66EN8KRS6IphZA0f2q0nQxSsSds
 8/5Jyc/tEJNPO8v2/7A3UYHnH81mThC4bpGqAJYKmu/XNTfvyOuDLdh5ftyylX2itd
 tdHQjkwAqqe4W9xf5oCtkch5rp3/ec5YTdl/BXXPuizqVEkzokvnBTEmYzlxmSlDMX
 SK0GtlIJYioeGPktOf56eM8tUckY/jf6uq7am+2zSIVy7r/tjC4spCGti/QvBBL1Rf
 L9c69k1AaRPEuXIUq+twML7rTI73ALmLofTUqP9ktJpmFAAXHNvXgw+zaJ6hdNddXO
 skWOLbB4tJ7og==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 48FEDCD8CA4;
 Sun,  7 Jun 2026 23:37:15 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Mon, 08 Jun 2026 09:37:14 +1000
Subject: [PATCH v2 5/8] binman: android_boot: SEANDROIDENFORCE support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-android-binman-v2-5-b8203682507f@samcday.com>
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
In-Reply-To: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
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
 Henrik Grimler <henrik@grimler.se>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780875433; l=4463;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=/WsciS0SKDXkf9CJtZ4fduIOamYjNvCpNXKF6xJAtEk=;
 b=5/m8CK+djqb6/2lWYUIGqsNzstlwB06P6ro8GHkCxzwdLL9PbeF9NQ5UatKMpr5ykdjzW2inK
 wcY7/ASgakWDr6aoT8dHnCTANHy4T4Sm0RRMCbmr8CGfUYvS0w2VjnL
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

Some older MSM8916-era bootloaders want to see this string appended to
the abootimg, or they log an ugly warning to the screen.

Signed-off-by: Sam Day <me@samcday.com>
---
 tools/binman/etype/android_boot.py                 | 11 +++++++++++
 tools/binman/ftest.py                              |  6 ++++++
 .../test/vendor/android_boot_seandroidenforce.dts  | 22 ++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
index 0eb59b30312..c7acb2bb66e 100644
--- a/tools/binman/etype/android_boot.py
+++ b/tools/binman/etype/android_boot.py
@@ -24,6 +24,8 @@ BOOT_IMAGE_HEADER_V2 = (BOOT_IMAGE_HEADER_V0 +
                         '{}sIQIIQ'.format(BOOT_EXTRA_ARGS_SIZE))
 BOOT_IMAGE_HEADER_V2_SIZE = struct.calcsize(BOOT_IMAGE_HEADER_V2)
 
+SEANDROIDENFORCE = b'SEANDROIDENFORCE'
+
 def _align_up(value, align):
     return (value + align - 1) & ~(align - 1)
 
@@ -55,6 +57,7 @@ class Entry_android_boot(Entry_section):
         - os-version: Encoded Android OS version and patch level, defaults to 0
         - boot-name: Android boot image board name
         - cmdline: Android boot command line
+        - append-seandroid-enforce: Append Samsung SEANDROIDENFORCE trailer,
 
     This entry uses the following subnodes:
         - kernel: section containing the executable payload
@@ -112,6 +115,7 @@ class Entry_android_boot(Entry_section):
 
         android-boot {
             base = <0x80000000>;
+            append-seandroid-enforce;
 
             kernel {
                 u-boot {
@@ -151,6 +155,8 @@ class Entry_android_boot(Entry_section):
         self.os_version = fdt_util.GetInt(self._node, 'os-version', 0)
         self.boot_name = fdt_util.GetString(self._node, 'boot-name', '')
         self.cmdline = fdt_util.GetString(self._node, 'cmdline', '')
+        self.append_seandroid = fdt_util.GetBool(self._node,
+                                                 'append-seandroid-enforce')
         self.vendor_dt_node = self._node.FindNode('vendor-dt')
 
         if self.header_version not in (0, 2):
@@ -174,6 +180,9 @@ class Entry_android_boot(Entry_section):
                 self.Raise('page-size must fit the Android boot image header')
             if 'dtb' not in self._entries:
                 self.Raise("Missing required subnode 'dtb'")
+            if self.append_seandroid:
+                self.Raise("Property 'append-seandroid-enforce' requires "
+                           "header-version 0")
             if self.vendor_dt_node:
                 self.Raise("Subnode 'vendor-dt' requires header-version 0")
 
@@ -319,6 +328,8 @@ class Entry_android_boot(Entry_section):
         image += _pad(kernel, self.page_size)
         image += _pad(ramdisk, self.page_size)
         image += _pad(vendor_dt, self.page_size)
+        if self.append_seandroid:
+            image += SEANDROIDENFORCE
 
         return bytes(image)
 
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index c96748bd1dd..1f3e94908d9 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5673,6 +5673,12 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                                              vendor_dt), header[13])
         self.assertEqual(vendor_dt, data[0x1800:0x1805])
 
+    def testAndroidBootSeAndroidEnforce(self):
+        """Test that binman appends SEANDROIDENFORCE"""
+        data = self._DoReadFile('vendor/android_boot_seandroidenforce.dts')
+
+        self.assertEqual(b'SEANDROIDENFORCE', data[-16:])
+
     def testAndroidBootQcdt(self):
         """Test that binman can produce a QCDT container"""
         data, dtb_data, _map, _dtb = self._DoReadFileDtb(
diff --git a/tools/binman/test/vendor/android_boot_seandroidenforce.dts b/tools/binman/test/vendor/android_boot_seandroidenforce.dts
new file mode 100644
index 00000000000..dc8374f84c7
--- /dev/null
+++ b/tools/binman/test/vendor/android_boot_seandroidenforce.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	binman {
+		android-boot {
+			header-version = <0>;
+			append-seandroid-enforce;
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
+		};
+	};
+};

-- 
2.54.0


