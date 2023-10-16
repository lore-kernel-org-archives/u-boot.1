Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA68CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 425CA86E37;
	Mon, 16 Oct 2023 18:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697473000;
	bh=gFBHqIA5GCiMwGkXcptTyTt0vOSJgBNT5NfKpHR1YJw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fMdD2LQ2KKxaB8LqRXtGoDbpjfaj1v+M0LuNqn4ZWULZlvtjnT9CwqROPHQ1V96zC
	 ZY4zRn4kXZ/Rp5hdWPk+EUMKBOKNlMICuV4qCySEchDHlOceBc4cG0d+lYXEZoAkbh
	 KqNYSk9zqIdkI1e/q8akeWvg30fhgnjdJ5fW9g0aDv8zMJQ4XlkNB3TLb8z4Ta+qUd
	 O2w/a2VvU5a7M9SuKJO/X5UZ5pEpheKDdfkcNtuwEsBZMB9rASVUNRA/Yvhcim8+D+
	 oWaf+D1/DgpntU+ltxu0ZGoIstBUSyyjuPqy6LtB0UVQ/tLi6yM86fAPXFg8JXg7aO
	 +j80TkHXd2PhA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6DE4886C26;
 Mon, 16 Oct 2023 18:16:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697472997;
 bh=gFBHqIA5GCiMwGkXcptTyTt0vOSJgBNT5NfKpHR1YJw=;
 h=From:To:Cc:Subject:Date:From;
 b=UssJKgrReJ9QUMjclyKILS0njMla/weARttZxPjh2C2Dop5hokemucmPDK7pcraaZ
 eu+pziQwhUcOeziO4U203opFAJtK4chN5rYhpPT/jFsXf6xoq9AJVgX3e9TXay7pCD
 W5MKZfJGQmCxiYV3x6fMlSsoijStDNWLJUuaF3c1cx+nwABEJ0BNFCnITwD0p0TYdd
 gqLJlKBQfPr737bjDJaf1Ob975z9Wb+wn/aT+WXDPzyXtw0xBolH2Zh9MI5w4XUmp3
 QMdlbgx467jAFkCYTDpEyIffCnjIQyH23su6gRLlFPyLa3A0dIK8mvRILnnCaq7shA
 WCHpqmi7y67OQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Chanho Park <chanho61.park@samsung.com>, Elena Popa <elena.popa@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Fedor Ross <fedor.ross@ifm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Qu Wenruo <wqu@suse.com>, Roger Quadros <rogerq@kernel.org>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 1/4] spl: mmc: Introduce proper layering for
 spl_mmc_get_uboot_raw_sector()
Date: Mon, 16 Oct 2023 18:16:12 +0200
Message-ID: <20231016161619.50744-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
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

Introduce two new weak functions, arch_spl_mmc_get_uboot_raw_sector() and
board_spl_mmc_get_uboot_raw_sector(), each of which can be overridden at
a matching level, that is arch/ and board/ , in addition to the existing
weak function spl_mmc_get_uboot_raw_sector().

This way, architecture code can define a default architecture specific
implementation of arch_spl_mmc_get_uboot_raw_sector(), while the board
code can override that using board_spl_mmc_get_uboot_raw_sector() which
takes precedence over the architecture code. In some sort of unlikely
special case where code has to take precedence over board code too, the
spl_mmc_get_uboot_raw_sector() is still left out to be a weak function,
but it should be unlikely that this is ever needed to be overridden.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: Elena Popa <elena.popa@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Fedor Ross <fedor.ross@ifm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Qu Wenruo <wqu@suse.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
---
V2: New patch
---
 arch/arm/mach-imx/image-container.c           |  4 +--
 arch/arm/mach-mvebu/spl.c                     |  4 +--
 arch/arm/mach-sunxi/board.c                   |  4 +--
 .../imx8mp_rsb3720a1/imx8mp_rsb3720a1.c       |  2 +-
 board/data_modul/imx8mp_edm_sbc/spl.c         |  2 +-
 board/gateworks/venice/spl.c                  |  2 +-
 common/spl/spl_mmc.c                          | 14 +++++++++-
 include/spl.h                                 | 26 +++++++++++++++++++
 8 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 5f188ab32d1..0285bbdaf20 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -276,8 +276,8 @@ unsigned long spl_spi_get_uboot_offs(struct spi_flash *flash)
 #endif
 
 #ifdef CONFIG_SPL_MMC
-unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
-					   unsigned long raw_sect)
+unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
+						unsigned long raw_sect)
 {
 	int end;
 
diff --git a/arch/arm/mach-mvebu/spl.c b/arch/arm/mach-mvebu/spl.c
index 379daa88a4d..eaaa68a8564 100644
--- a/arch/arm/mach-mvebu/spl.c
+++ b/arch/arm/mach-mvebu/spl.c
@@ -123,8 +123,8 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 {
 	return IS_SD(mmc) ? MMCSD_MODE_RAW : MMCSD_MODE_EMMCBOOT;
 }
-unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
-					   unsigned long raw_sect)
+unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
+						unsigned long raw_sect)
 {
 	return IS_SD(mmc) ? 1 : 0;
 }
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 78597ad932c..61a4245c499 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -323,8 +323,8 @@ uint32_t sunxi_get_spl_size(void)
  * Also U-Boot proper is located at least 32KB after the SPL, but will
  * immediately follow the SPL if that is bigger than that.
  */
-unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
-					   unsigned long raw_sect)
+unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
+						 unsigned long raw_sect)
 {
 	unsigned long spl_size = sunxi_get_spl_size();
 	unsigned long sector;
diff --git a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c b/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
index b79a2380aa5..d87fe3606f6 100644
--- a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
+++ b/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
@@ -193,7 +193,7 @@ int board_late_init(void)
 
 #ifdef CONFIG_SPL_MMC
 #define UBOOT_RAW_SECTOR_OFFSET 0x40
-unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
+unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 					   unsigned long raw_sector)
 {
 	u32 boot_dev = spl_boot_device();
diff --git a/board/data_modul/imx8mp_edm_sbc/spl.c b/board/data_modul/imx8mp_edm_sbc/spl.c
index 2fdd95a730c..cfc4b65e0f9 100644
--- a/board/data_modul/imx8mp_edm_sbc/spl.c
+++ b/board/data_modul/imx8mp_edm_sbc/spl.c
@@ -107,7 +107,7 @@ void board_boot_order(u32 *spl_boot_list)
 	spl_boot_list[4] = BOOT_DEVICE_NONE;
 }
 
-unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc, unsigned long sect)
+unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc, unsigned long sect)
 {
 	const u32 boot_dev = spl_boot_device();
 	int part;
diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.c
index 774a99041c8..4851dc1c53f 100644
--- a/board/gateworks/venice/spl.c
+++ b/board/gateworks/venice/spl.c
@@ -346,7 +346,7 @@ int spl_board_boot_device(enum boot_device boot_dev_spl)
 	}
 }
 
-unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc, unsigned long raw_sect)
+unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc, unsigned long raw_sect)
 {
 	if (!IS_SD(mmc)) {
 		switch (EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config)) {
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 0ab85d2168c..612b11ef5b9 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -361,10 +361,22 @@ int __weak spl_mmc_boot_partition(const u32 boot_device)
 }
 #endif
 
+unsigned long __weak arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
+						       unsigned long raw_sect)
+{
+	return raw_sect;
+}
+
+unsigned long __weak board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
+						  unsigned long raw_sect)
+{
+	return arch_spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
+}
+
 unsigned long __weak spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						  unsigned long raw_sect)
 {
-	return raw_sect;
+	return board_spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
 }
 
 int default_spl_mmc_emmc_boot_partition(struct mmc *mmc)
diff --git a/include/spl.h b/include/spl.h
index 7d30fb57dac..7ff1518f55c 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -486,6 +486,32 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc);
 
 void spl_set_bd(void);
 
+/**
+ * spl_mmc_get_uboot_raw_sector() - Provide raw sector of the start of U-Boot (architecture override)
+ *
+ * This is a weak function which by default will provide the raw sector that is
+ * where the start of the U-Boot image has been written to.
+ *
+ * @mmc: struct mmc that describes the devie where U-Boot resides
+ * @raw_sect: The raw sector number where U-Boot is by default.
+ * Return: The raw sector location that U-Boot resides at
+ */
+unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
+						unsigned long raw_sect);
+
+/**
+ * spl_mmc_get_uboot_raw_sector() - Provide raw sector of the start of U-Boot (board override)
+ *
+ * This is a weak function which by default will provide the raw sector that is
+ * where the start of the U-Boot image has been written to.
+ *
+ * @mmc: struct mmc that describes the devie where U-Boot resides
+ * @raw_sect: The raw sector number where U-Boot is by default.
+ * Return: The raw sector location that U-Boot resides at
+ */
+unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
+						 unsigned long raw_sect);
+
 /**
  * spl_mmc_get_uboot_raw_sector() - Provide raw sector of the start of U-Boot
  *
-- 
2.42.0

