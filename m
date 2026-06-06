Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74959CD6E75
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 04:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7999A84942;
	Sat,  6 Jun 2026 06:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NQYaeAp4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A1268498B; Sat,  6 Jun 2026 02:52:48 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E6E884928
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 02:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DA29E445AD;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD416C2BCC6;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780707160;
 bh=LGKwVEGfIC3RCfq8ie901WjPsK4N+I7b6xnLIQJLeKU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=NQYaeAp4CHP89jlzFHs3l3eZzllmBHrVDAyPFDaN0F7bzmTkbNyjVhRzSNIN4iBdv
 BBTtFUbZjfSyN3LHX8AGwFwMJaUdutMjkZw/BY/XMzNBQd3irGqQvy8sdab8+zVeas
 6SWlJfRMRnR3pVU0gLNYy/532nA95WTxs8w3kJM6WdR4TJ2x7QKq5l4suk+wausVjQ
 UqpJNKrmDeZWnZ4SyuNSpjv6SuwktxjSKP52RMAolv0V+V9R7OoEElOvF9BQvD2BKp
 jlyUOZcFLKV8KpLKoJ7Gm1xho8yII0R8c6JtnysbXNkrVip585xEUC9J6w63s+ZHba
 7ZVHLq4107IPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B21E0CD8C89;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Sat, 06 Jun 2026 10:52:42 +1000
Subject: [PATCH 08/13] binman: android_boot: SEANDROIDENFORCE support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-android-binman-v1-8-c7a3c14b8a3d@samcday.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780707158; l=4423;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=lG4YyGgMeyAkpsez/qDqni7sEvyORfqtBM9mfabuH+k=;
 b=ovdMjerWsMlNABldtRrETkzuPF2pzxg7+a5rA2nMQPduwkZic0jAopHxKVHVkq/+TOZe+kJl0
 i7sQV8kbHrmCJb+fPy5jDuWTaZdVTu5ljWslcDygwziHN53GU85yIwF
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

Some older MSM8916-era bootloaders want to see this string appended to
the abootimg, or they log an ugly warning to the screen.

Signed-off-by: Sam Day <me@samcday.com>
---
 tools/binman/etype/android_boot.py                 | 11 +++++++++++
 tools/binman/ftest.py                              |  6 ++++++
 .../test/vendor/android_boot_seandroidenforce.dts  | 22 ++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
index aa68848f579..7d4543209a1 100644
--- a/tools/binman/etype/android_boot.py
+++ b/tools/binman/etype/android_boot.py
@@ -24,6 +24,8 @@ BOOT_IMAGE_HEADER_V2 = (BOOT_IMAGE_HEADER_V0 +
                         '{}sIQIIQ'.format(BOOT_EXTRA_ARGS_SIZE))
 BOOT_IMAGE_HEADER_V2_SIZE = struct.calcsize(BOOT_IMAGE_HEADER_V2)
 
+SEANDROIDENFORCE = b'SEANDROIDENFORCE'
+
 def _align_up(value, align):
     return (value + align - 1) & ~(align - 1)
 
@@ -56,6 +58,7 @@ class Entry_android_boot(Entry_section):
         - boot-name: Android boot image board name
         - cmdline: Android boot command line
           used by header version 0 only
+        - append-seandroid-enforce: Append Samsung SEANDROIDENFORCE trailer,
 
     This entry uses the following subnodes:
         - kernel: section containing the executable payload
@@ -113,6 +116,7 @@ class Entry_android_boot(Entry_section):
 
         android-boot {
             base = <0x80000000>;
+            append-seandroid-enforce;
 
             kernel {
                 u-boot {
@@ -152,6 +156,8 @@ class Entry_android_boot(Entry_section):
         self.os_version = fdt_util.GetInt(self._node, 'os-version', 0)
         self.boot_name = fdt_util.GetString(self._node, 'boot-name', '')
         self.cmdline = fdt_util.GetString(self._node, 'cmdline', '')
+        self.append_seandroid = fdt_util.GetBool(self._node,
+                                                 'append-seandroid-enforce')
         self.vendor_dt_node = self._node.FindNode('vendor-dt')
 
         if self.header_version not in (0, 2):
@@ -175,6 +181,9 @@ class Entry_android_boot(Entry_section):
                 self.Raise('page-size must fit the Android boot image header')
             if 'dtb' not in self._entries:
                 self.Raise("Missing required subnode 'dtb'")
+            if self.append_seandroid:
+                self.Raise("Property 'append-seandroid-enforce' requires "
+                           "header-version 0")
             if self.vendor_dt_node:
                 self.Raise("Subnode 'vendor-dt' requires header-version 0")
 
@@ -344,6 +353,8 @@ class Entry_android_boot(Entry_section):
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


