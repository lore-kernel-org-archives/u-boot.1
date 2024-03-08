Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2262EC54798
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 03:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6827787DB3;
	Fri,  8 Mar 2024 04:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XiqRZY7X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D70FA87D14; Fri,  8 Mar 2024 04:01:19 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C49A875FC
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 04:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=benwolsieffer@gmail.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-788412a4b78so21282385a.1
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 19:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709866874; x=1710471674; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CVcVXw1dwkdtPvjQ+xAlXmU0L2G47cLiKzMs2MrUKrE=;
 b=XiqRZY7X5kpJyqKNoVadMNszDJrWgC0q6iWLx4i0As8s+q+sO1cSvUI8iIVJaVfBmp
 B8h9YPtVZODCfgBdkG+QDp4f+uvqzZ2+Yr8Y8x/2xvsor7GQcxmO3nDW6bMI1TS+63ak
 JvM1+Z6deaeqUqn+aotiuuE4zDlREBEP9M0Vhbmimil80dZIMUHaeBR//Vq4YEwquW5q
 vTMA/eOk/CNsft21GcOKJD1slGROB9K2kJYd+gg2vvZP4ct/pQZbeQI1QiwWKUuRG0Fx
 eajmH1YBETJ7l9EAxb4cUG5H/G7Q6MF2bvYXXI2AslYtoz97TreeEQXGfSfo040HJzbs
 bV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709866874; x=1710471674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CVcVXw1dwkdtPvjQ+xAlXmU0L2G47cLiKzMs2MrUKrE=;
 b=oIOJAvfuX9YT3iVQRLMT4XKyi7aoqyn0Wzl+PGeD8DomJEa5DYDK5W/v0NLTgCLCs+
 Boeq6Asb6yrbL3D3076BxpLurkjS0ES+IJTt6NwQ8GGpS1N9K6IAEccoWO7AX2EbnACY
 ON5hP9EXKWSmkLUD1DFPwxkDkxD+hZ6rLiJ7b+viPGPBFzJKmKmGfdQNczUFOOAAI/9I
 FbNRc/nHos+S/uEVcjqpTHQjxV35/NSD98eaSiAUR4TOJcwnDdolklBA1st34e+ZFnxO
 FAg5aT0P/pz/47ek3ZVQfmhdHBVN0+nDpb7I0oKFE46OS3PjrL0oVi2nSrpla79YXIpR
 vXSA==
X-Gm-Message-State: AOJu0YxpWT17NNkfspXIPNZEZa3j+oBKY9hcHmiEY7tK2Jv8WRibQVI8
 DCKOdOhLRsQtzs8/OPVEeBiq1cyKrMOztMhgbcTou1jLi0FfxY+TKcXfhvnSsh8=
X-Google-Smtp-Source: AGHT+IFJZw4SEPlxDvWixikUnNQladxeJdDJKatBHrqs/qM9URaNt7M62LLtsCKafP+NZjfKGqvOqw==
X-Received: by 2002:ae9:f507:0:b0:788:3ed2:7d9f with SMTP id
 o7-20020ae9f507000000b007883ed27d9fmr7482942qkg.49.1709866874309; 
 Thu, 07 Mar 2024 19:01:14 -0800 (PST)
Received: from Dell-Inspiron-15.. ([2601:18c:8002:3d40:7920:e10c:26cf:ff86])
 by smtp.gmail.com with ESMTPSA id
 bm34-20020a05620a19a200b007884e706335sm486472qkb.38.2024.03.07.19.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 19:01:13 -0800 (PST)
From: Ben Wolsieffer <benwolsieffer@gmail.com>
To: u-boot@lists.denx.de
Cc: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Ben Wolsieffer <benwolsieffer@gmail.com>
Subject: [PATCH v2] rockchip: load env from boot MMC device
Date: Thu,  7 Mar 2024 22:00:51 -0500
Message-ID: <20240308030051.370824-1-benwolsieffer@gmail.com>
X-Mailer: git-send-email 2.44.0
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

Currently, if the environment is stored on an MMC device, the device
number is hardcoded by CONFIG_SYS_MMC_ENV_DEV. This is problematic
because many boards can choose between booting from an SD card or a
removable eMMC. For example, the Rock64 defconfig sets
CONFIG_SYS_MMC_ENV_DEV=1, which corresponds to the SD card. If an eMMC
is used as the boot device and no SD card is installed, it is impossible
to save the environment.

To avoid this problem, we can choose the environment MMC device based on
the boot device. The theobroma-systems boards already contain code to do
this, so this commit simply moves it to the common Rockchip board file,
with some refactoring. I also removed another implementation of
mmc_get_env_dev() from tinker_rk3288 that performed MMC boot device
detection by reading a bootrom register.

This has been tested on a Rock64v2.

Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
---
v2:
* Use #ifdef rather than if(CONFIG_IS_ENABLED(...))
* Add a debug message if boot device is not found

 arch/arm/mach-rockchip/board.c               | 31 ++++++++++++++++++++
 board/rockchip/tinker_rk3288/tinker-rk3288.c | 12 --------
 board/theobroma-systems/common/common.c      | 30 -------------------
 3 files changed, 31 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 2620530e03..8aa09f44b3 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -6,6 +6,7 @@
 #include <clk.h>
 #include <cpu_func.h>
 #include <dm.h>
+#include <dm/uclass-internal.h>
 #include <efi_loader.h>
 #include <fastboot.h>
 #include <init.h>
@@ -349,3 +350,33 @@ __weak int board_rng_seed(struct abuf *buf)
 	return 0;
 }
 #endif
+
+int mmc_get_env_dev(void)
+{
+	int devnum;
+	const char *boot_device;
+	struct udevice *dev;
+
+#ifdef CONFIG_SYS_MMC_ENV_DEV
+	devnum = CONFIG_SYS_MMC_ENV_DEV;
+#else
+	devnum = 0;
+#endif
+
+	boot_device = ofnode_read_chosen_string("u-boot,spl-boot-device");
+	if (!boot_device) {
+		debug("%s: /chosen/u-boot,spl-boot-device not set\n", __func__);
+		return devnum;
+	}
+
+	debug("%s: booted from %s\n", __func__, boot_device);
+
+	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &dev)) {
+		debug("%s: no U-Boot device found for %s\n", __func__, boot_device);
+		return devnum;
+	}
+
+	devnum = dev->seq_;
+	debug("%s: get MMC env from mmc%d\n", __func__, devnum);
+	return devnum;
+}
diff --git a/board/rockchip/tinker_rk3288/tinker-rk3288.c b/board/rockchip/tinker_rk3288/tinker-rk3288.c
index f85209c649..eff3a00c30 100644
--- a/board/rockchip/tinker_rk3288/tinker-rk3288.c
+++ b/board/rockchip/tinker_rk3288/tinker-rk3288.c
@@ -11,8 +11,6 @@
 #include <init.h>
 #include <net.h>
 #include <netdev.h>
-#include <asm/arch-rockchip/bootrom.h>
-#include <asm/io.h>
 
 static int get_ethaddr_from_eeprom(u8 *addr)
 {
@@ -38,13 +36,3 @@ int rk3288_board_late_init(void)
 
 	return 0;
 }
-
-int mmc_get_env_dev(void)
-{
-	u32 bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
-
-	if (bootdevice_brom_id == BROM_BOOTSOURCE_EMMC)
-		return 0;
-
-	return 1;
-}
diff --git a/board/theobroma-systems/common/common.c b/board/theobroma-systems/common/common.c
index 864bcdd46f..585da43884 100644
--- a/board/theobroma-systems/common/common.c
+++ b/board/theobroma-systems/common/common.c
@@ -89,36 +89,6 @@ int setup_boottargets(void)
 	return 0;
 }
 
-int mmc_get_env_dev(void)
-{
-	const char *boot_device =
-		ofnode_read_chosen_string("u-boot,spl-boot-device");
-	struct udevice *devp;
-
-	if (!boot_device) {
-		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
-		      __func__);
-#ifdef CONFIG_SYS_MMC_ENV_DEV
-		return CONFIG_SYS_MMC_ENV_DEV;
-#else
-		return 0;
-#endif
-	}
-
-	debug("%s: booted from %s\n", __func__, boot_device);
-
-	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp))
-#ifdef CONFIG_SYS_MMC_ENV_DEV
-		return CONFIG_SYS_MMC_ENV_DEV;
-#else
-		return 0;
-#endif
-
-	debug("%s: get MMC ENV from mmc%d\n", __func__, devp->seq_);
-
-	return devp->seq_;
-}
-
 enum env_location arch_env_get_location(enum env_operation op, int prio)
 {
 	const char *boot_device =
-- 
2.44.0

