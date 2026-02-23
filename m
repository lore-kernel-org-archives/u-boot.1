Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7605EC1120
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 18:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1631283C39;
	Mon, 23 Feb 2026 19:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="PZ3T/P3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5960083C6E; Mon, 23 Feb 2026 19:39:21 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF85483D8A
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 19:39:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id C31AD27E9F;
 Mon, 23 Feb 2026 19:39:17 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FEcv5EFyehtx; Mon, 23 Feb 2026 19:39:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1771871957; bh=Rdxbz6rijcchM6SjoAx2KjZz/4LSh+poBL0Qr8MF1Ko=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=PZ3T/P3N1B1bY/6NXlCsr9OVLr73pV7C4NNFii+mqOsgI0vJyyds/Uu7DpUg0tx1J
 adFIrnJ9d2LH/HyzGlbb8J+h3nMoWrLRJjZieDrqFW9ntAtStK1E/UrXpR5Vk17zRq
 BWAZsYQnaur2mD3bCk7ihbV9wEolynMUZoAj3dNlI819knz3CjICwr8uFrhi9s54CX
 7S8KQiaDEPUhF+2yPNR0qu1QpxsWaQz5p8kH52S++TJi9DWWTopkHolEijEsnbi+mq
 5elLYd1IjCNxuz2kYPTD9xdxMiiXnRGvP16Wij+6ocdjUB5NqMFNQYf/IpByOMT3GL
 Mvv67W+4TQKNw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 24 Feb 2026 00:09:09 +0530
Subject: [PATCH 1/2] board: samsung: exynos-mobile: use blkmap for booting
 from userdata subpartitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-exynos-blkmap-dfu-v1-1-cfe615b68c88@disroot.org>
References: <20260224-exynos-blkmap-dfu-v1-0-cfe615b68c88@disroot.org>
In-Reply-To: <20260224-exynos-blkmap-dfu-v1-0-cfe615b68c88@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Mon, 23 Feb 2026 19:47:22 +0100
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

Some distributions tend to provide a single combined image with EFS and
the system root filesystem. Flashing it as-is in a single partition
(usually done in userdata partition as it is the largest) is not
bootable as U-Boot does not understand subpartitions.

Use blkmap to map the userdata partition into its own block device.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 board/samsung/exynos-mobile/exynos-mobile.c   | 45 +++++++++++++++++++++++++++
 board/samsung/exynos-mobile/exynos-mobile.env |  5 +++
 configs/exynos-mobile_defconfig               |  4 ++-
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/board/samsung/exynos-mobile/exynos-mobile.c b/board/samsung/exynos-mobile/exynos-mobile.c
index 1f61f28de5f..c5e1b186ae3 100644
--- a/board/samsung/exynos-mobile/exynos-mobile.c
+++ b/board/samsung/exynos-mobile/exynos-mobile.c
@@ -184,6 +184,45 @@ static void exynos_env_setup(void)
 	env_set("fdtfile", buf);
 }
 
+static int exynos_blk_env_setup(void)
+{
+	const char *blk_ifname;
+	int blk_dev = 0;
+	struct blk_desc *blk_desc;
+	struct disk_partition info = {0};
+	unsigned long largest_part_start = 0, largest_part_size = 0;
+	int i;
+
+	blk_ifname = "mmc";
+	blk_desc = blk_get_dev(blk_ifname, blk_dev);
+	if (!blk_desc) {
+		log_err("%s: required mmc device not available\n", __func__);
+		return -ENODEV;
+	}
+
+	for (i = 1; i < CONFIG_EFI_PARTITION_ENTRIES_NUMBERS; i++) {
+		if (part_get_info(blk_desc, i, &info))
+			continue;
+
+		if (info.start > largest_part_size) {
+			largest_part_start = info.start;
+			largest_part_size = info.size;
+		}
+	}
+
+	if (largest_part_size) {
+		env_set("blkmap_blk_ifname", blk_ifname);
+		env_set_ulong("blkmap_blk_dev", blk_dev);
+		env_set_ulong("blkmap_blk_nr", largest_part_start);
+		env_set_hex("blkmap_size_r", largest_part_size);
+	} else {
+		log_warning("%s: no qualified partition for blkmap, skipping\n",
+			    __func__);
+	}
+
+	return 0;
+}
+
 static int exynos_fastboot_setup(void)
 {
 	struct blk_desc *blk_dev;
@@ -297,7 +336,13 @@ int board_init(void)
 
 int misc_init_r(void)
 {
+	int ret;
+
 	exynos_env_setup();
 
+	ret = exynos_blk_env_setup();
+	if (ret)
+		return ret;
+
 	return exynos_fastboot_setup();
 }
diff --git a/board/samsung/exynos-mobile/exynos-mobile.env b/board/samsung/exynos-mobile/exynos-mobile.env
index aa2e89afbac..33f767319b5 100644
--- a/board/samsung/exynos-mobile/exynos-mobile.env
+++ b/board/samsung/exynos-mobile/exynos-mobile.env
@@ -2,6 +2,11 @@ stdin=serial,button-kbd
 stdout=serial,vidconsole
 stderr=serial,vidconsole
 
+blkmapcmd=blkmap create root;
+	  blkmap map root 0 ${blkmap_size_r} linear ${blkmap_blk_ifname} ${blkmap_blk_dev} ${blkmap_blk_nr}
+
+preboot=run blkmapcmd
+
 bootdelay=0
 bootcmd=bootefi bootmgr; pause; bootmenu
 
diff --git a/configs/exynos-mobile_defconfig b/configs/exynos-mobile_defconfig
index c7d206f94ac..cee468d9c24 100644
--- a/configs/exynos-mobile_defconfig
+++ b/configs/exynos-mobile_defconfig
@@ -12,6 +12,7 @@ CONFIG_SYS_LOAD_ADDR=0x80000000
 CONFIG_ARMV8_CNTFRQ_BROKEN=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_BUTTON_CMD=y
+CONFIG_USE_PREBOOT=y
 CONFIG_SAVE_PREV_BL_FDT_ADDR=y
 CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
 CONFIG_SYS_PBSIZE=1024
@@ -24,8 +25,9 @@ CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_EFI_PARTITION=y
 CONFIG_OF_UPSTREAM=y
-CONFIG_OF_BOARD=y
 CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
+CONFIG_OF_BOARD=y
+CONFIG_BLKMAP=y
 CONFIG_BUTTON=y
 CONFIG_BUTTON_REMAP_PHONE_KEYS=y
 CONFIG_CLK_EXYNOS7870=y

-- 
2.52.0

