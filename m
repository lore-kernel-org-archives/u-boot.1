Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA854C47DD9
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 01:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B9A387E14;
	Mon, 26 Feb 2024 02:15:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Klf0st2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D78987E2E; Mon, 26 Feb 2024 02:15:56 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2175587CED
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 02:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=benwolsieffer@gmail.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3c1a2f7e1d2so117103b6e.1
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 17:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708910152; x=1709514952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gHRlMCDLh4G7ugNBcMd+NFiJ6+nj/saAmnP5ZRh4s04=;
 b=Klf0st2IcUF07JkOiZf1PIJqfGwZjxxr/fl9FVPI3TRWDdVhcspfXCcQcmr7x8Ytm3
 NLADhL80hFI6CWHKuhxQbasJ8v8rxZp++WCpcmYm8176CyW9VFVX/khsvcheOzU3rS/w
 D79LXYg7DUmdsg8tk1NQiYiVInVD24P627+LBYWPQwQ3UCHm7CaqbNyGZB6QF9n9ry0Q
 flyOfeKqqS6vOWbRs48sG0UKrt7IR18dbldp6dtO+x396lKyuFbpMKHU8rRPml3gFCL9
 wLhEGS+BYDBRy6qa968JGuOYZCN/nEc7Pt8N4SDk7wE4Y9HhUyL5dj8DZ5asYT3h9C9x
 C57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708910152; x=1709514952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gHRlMCDLh4G7ugNBcMd+NFiJ6+nj/saAmnP5ZRh4s04=;
 b=A6ge1iKEangE2jaFYTfR1UX8Ckjo0pRQ/BXJ53rCEQyVdR5d5b4OFNToWPZRDB5SZa
 I6TFg3079oJeDYd+4eYjRrGmVaTnk/oy1bK9gKBUqeQrwDQBu34irAS2Cl/Kbqvvwfyv
 prCe5des3ieDExf/GAzXyXcWO5Hpl5ohp3s4GtOhQPbnbAWXDTaMtgWQyPfWgSBG+vZr
 2fu0FEBVFXAtTtGN+WXxfZw3s/FcMzY8LJBqc8WS1cXJQW00z1dxLlXfsDQb3xURSa1W
 gOmlHl4PKRJbO8F3hsIaY0AMzfT5mWiwRxXuX6LQc1q8ZJ5mCEg4YD3WEjbHsWE9M28y
 CSmw==
X-Gm-Message-State: AOJu0YyQdvl+f8CvT5aYrbeilZ9+JDZB+5hhNn7HoAPvnp8F5Cw48x5m
 vgzqTw7TDtRQfsvjeMdmOpJmNNz57X9dgkaHzlBidD6iNimK6ivVligZZKK+cZM=
X-Google-Smtp-Source: AGHT+IF6qsHrEDuigi/NkATuP6C3i53OcSEE5oHo9Bt8ZVwKUHKOxAVyfLC31ooyOg2ClKu9toLIrQ==
X-Received: by 2002:a05:6808:21a4:b0:3c1:533b:55f9 with SMTP id
 be36-20020a05680821a400b003c1533b55f9mr7241667oib.5.1708910152139; 
 Sun, 25 Feb 2024 17:15:52 -0800 (PST)
Received: from Dell-Inspiron-15.. ([2601:18c:8002:3d40:7920:e10c:26cf:ff86])
 by smtp.gmail.com with ESMTPSA id
 s18-20020ad45252000000b0068efae7d0aesm2307047qvq.125.2024.02.25.17.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 17:15:51 -0800 (PST)
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
Subject: [PATCH] rockchip: load env from boot MMC device
Date: Sun, 25 Feb 2024 20:14:14 -0500
Message-ID: <20240226011413.435713-2-benwolsieffer@gmail.com>
X-Mailer: git-send-email 2.43.2
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
 arch/arm/mach-rockchip/board.c               | 28 ++++++++++++++++++
 board/rockchip/tinker_rk3288/tinker-rk3288.c | 12 --------
 board/theobroma-systems/common/common.c      | 30 --------------------
 3 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 2620530e03..04db809e97 100644
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
@@ -349,3 +350,30 @@ __weak int board_rng_seed(struct abuf *buf)
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
+	if (IS_ENABLED(CONFIG_SYS_MMC_ENV_DEV))
+		devnum = CONFIG_SYS_MMC_ENV_DEV;
+	else
+		devnum = 0;
+
+	boot_device = ofnode_read_chosen_string("u-boot,spl-boot-device");
+	if (!boot_device) {
+		debug("%s: /chosen/u-boot,spl-boot-device not set\n", __func__);
+		return devnum;
+	}
+
+	debug("%s: booted from %s\n", __func__, boot_device);
+
+	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &dev))
+		return devnum;
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
2.43.2

