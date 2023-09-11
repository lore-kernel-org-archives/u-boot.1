Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5CFEE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 10:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E2D86DA9;
	Mon, 11 Sep 2023 12:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 360EA86D6B; Mon, 11 Sep 2023 12:01:55 +0200 (CEST)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CC0386D75
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 12:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 38BA1cf4002973; Mon, 11 Sep 2023 19:01:39 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: andy.yan@rock-chips.com, gajjar04akash@gmail.com, sjg@chromium.org,
 jonas@kwiboo.se, kever.yang@rock-chips.com, FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 1/2] configs: rockchip: rk3308: use CONFIG_DEFAULT_FDT_FILE
Date: Mon, 11 Sep 2023 19:01:20 +0900
Message-Id: <20230911100121.122228-1-naoki@radxa.com>
X-Mailer: git-send-email 2.39.2
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

all rk3308 boards should use their own dtb file.

also, change fdt_addr_r to avoid following error:
 "ERROR: Did not find a cmdline Flattened Device Tree"
it happens on Radxa ROCK Pi S (256MB/512MB) with kernel built from
Radxa BSP.

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
 configs/evb-rk3308_defconfig       | 1 +
 configs/roc-cc-rk3308_defconfig    | 1 +
 configs/rock-pi-s-rk3308_defconfig | 1 +
 include/configs/rk3308_common.h    | 3 ++-
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
index a13a809c1e..2c7ac88ed9 100644
--- a/configs/evb-rk3308_defconfig
+++ b/configs/evb-rk3308_defconfig
@@ -24,6 +24,7 @@ CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTDELAY=0
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-evb.dtb"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x20000
diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
index 9a789b212f..9cb90f6ee6 100644
--- a/configs/roc-cc-rk3308_defconfig
+++ b/configs/roc-cc-rk3308_defconfig
@@ -24,6 +24,7 @@ CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTDELAY=0
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-roc-cc.dtb"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x20000
diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index cc3274a98b..e2abe4b4f7 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -25,6 +25,7 @@ CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTDELAY=0
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-rock-pi-s.dtb"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x20000
diff --git a/include/configs/rk3308_common.h b/include/configs/rk3308_common.h
index 7d55fcd975..a413af1bd4 100644
--- a/include/configs/rk3308_common.h
+++ b/include/configs/rk3308_common.h
@@ -16,11 +16,12 @@
 #define ENV_MEM_LAYOUT_SETTINGS \
 	"scriptaddr=0x00500000\0" \
 	"pxefile_addr_r=0x00600000\0" \
-	"fdt_addr_r=0x02800000\0" \
+	"fdt_addr_r=0x03e00000\0" \
 	"kernel_addr_r=0x00680000\0" \
 	"ramdisk_addr_r=0x04000000\0"
 
 #define CFG_EXTRA_ENV_SETTINGS \
+	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
 	ENV_MEM_LAYOUT_SETTINGS \
 	"partitions=" PARTS_DEFAULT \
 	ROCKCHIP_DEVICE_SETTINGS \
-- 
2.39.2

