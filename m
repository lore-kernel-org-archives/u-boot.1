Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8B1F3C991
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 15:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE2CC83DCB;
	Tue, 24 Feb 2026 16:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="cMSVzZE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E07CB82BF2; Tue, 24 Feb 2026 16:37:24 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99DA782BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 16:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 576D8268B7;
 Tue, 24 Feb 2026 16:37:22 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wfnNEh6voyMa; Tue, 24 Feb 2026 16:37:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1771947441; bh=Rdxbz6rijcchM6SjoAx2KjZz/4LSh+poBL0Qr8MF1Ko=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=cMSVzZE9DllWgoOKRIVyBA+hfb18PMhY9mkEqjpAyi926pwCf6dI9onSe7YOCUej4
 u9/6XVjdObUhlHKY4TCnldFH+iOXSfVaEAvBuLfktL63+jo3BW149YZ/jPznHC7DJq
 uK1WCV6A41VZHBeFuhFdEcdPiidckAvDtMPpMR1i1BxVOLeK9P05uNDGavnfmBZ2Yg
 gLRM8v3V7OKGBra7/eRjdr78Yeu0tlermXoBjyj6wiOIWyoKAFCdcE7DVPeOv2r1y4
 aefOiGKu77tvlvANh71vikoXpGOm5jkuYIrCMUVj3VmFqBWIap8G08qPhg4h4rOtli
 0FvsNN+r5VfCQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 24 Feb 2026 21:07:09 +0530
Subject: [PATCH v2 1/3] board: samsung: exynos-mobile: use blkmap for
 booting from userdata subpartitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-exynos-blkmap-dfu-v2-1-742cb9f27842@disroot.org>
References: <20260224-exynos-blkmap-dfu-v2-0-742cb9f27842@disroot.org>
In-Reply-To: <20260224-exynos-blkmap-dfu-v2-0-742cb9f27842@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Tue, 24 Feb 2026 16:37:49 +0100
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

