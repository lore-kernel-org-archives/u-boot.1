Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460C2C0032E
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 12:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05B0287623;
	Sat, 21 Oct 2023 14:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="RXOsijs/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C90F187612; Sat, 21 Oct 2023 14:40:08 +0200 (CEST)
Received: from smtp-out.freemail.hu (fmfe05.freemail.hu [46.107.16.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C29987612
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 14:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
Received: from localhost.localdomain (catv-80-98-74-198.catv.fixed.vodafone.hu
 [80.98.74.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.freemail.hu (Postfix) with ESMTPSA id 4SCLdG3x7fzt7;
 Sat, 21 Oct 2023 14:40:02 +0200 (CEST)
From: egyszeregy@freemail.hu
To: u-boot@lists.denx.de
Cc: otavio@ossystems.com.br, festevam@gmail.com,
 =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH 1/1] [u-boot][master][PATCH v5] pico-imx7d: add baseboard SD
 card boot detect
Date: Sat, 21 Oct 2023 14:39:47 +0200
Message-ID: <20231021123947.434-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1697892003; 
 s=20181004; d=freemail.hu;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 l=8016; bh=x+2dJHYIdzUuxtdUzLSmzrzTXwKs5272GtoEehFTP3Q=;
 b=RXOsijs/vvC7xjDEiSy94gm20nFLfAEHkrPG5rpkoMR5viCQl3i+dHXuh2rcH5sC
 UFrPhA3J6Eqy+UBGi+PVxyqauRfYuVJcEdfoTkKOf1qjuT57lNFKMqEWA+GPi5yztCV
 SEWpiNtErEdWnPpMNLrzGas1TDnvKGhOVAOmy4guePWHSxaZewHI/WmOrxFqdo9UXnC
 tIwFcHJxtr++fsP2RLOEaF+vdqYb8Qq3ieiDNqqG7omexde/K1YvFjkXj579FXilkUa
 8vgDAgw4sl2CPHJBNxJvR0vuKJBIsNCz0lVRPO+CWHGsFX6aAj5j9TAyapeDwf6EJof
 4uQQ7vVlcg==
X-Mailman-Approved-At: Sat, 21 Oct 2023 14:41:14 +0200
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

From: Benjamin Szőke <egyszeregy@freemail.hu>

Technexion PICO-IMX7 SoM is supporting USDHC3 (eMMC or micro SD on SoM)
and USDHC1 (SD on carrier board) to use on any carrier board like
PICO-NYMPH. This pacth is intend to take over codes from Technexion
to support mmc autodetect boot for pico-imx7d to able to boot from
selected USDHC1 or USDHC3 boot devices.

Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
---
 board/technexion/pico-imx7d/pico-imx7d.c | 59 ++++++++++++++-
 board/technexion/pico-imx7d/spl.c        | 91 ++++++++++++++++++++++--
 include/configs/pico-imx7d.h             |  4 +-
 3 files changed, 145 insertions(+), 9 deletions(-)

diff --git a/board/technexion/pico-imx7d/pico-imx7d.c b/board/technexion/pico-imx7d/pico-imx7d.c
index 6e98b85b28..01a9520d32 100644
--- a/board/technexion/pico-imx7d/pico-imx7d.c
+++ b/board/technexion/pico-imx7d/pico-imx7d.c
@@ -5,6 +5,7 @@
 
 #include <init.h>
 #include <net.h>
+#include <command.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/crm_regs.h>
 #include <asm/arch/imx-regs.h>
@@ -13,6 +14,7 @@
 #include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <asm/mach-imx/iomux-v3.h>
+#include <asm/mach-imx/boot_mode.h>
 #include <asm/io.h>
 #include <common.h>
 #include <miiphy.h>
@@ -106,7 +108,7 @@ int board_phy_config(struct phy_device *phydev)
 {
 	unsigned short val;
 
-	/* To enable AR8035 ouput a 125MHz clk from CLK_25M */
+	/* To enable AR8035 output a 125MHz clk from CLK_25M */
 	phy_write(phydev, MDIO_DEVAD_NONE, 0xd, 0x7);
 	phy_write(phydev, MDIO_DEVAD_NONE, 0xe, 0x8016);
 	phy_write(phydev, MDIO_DEVAD_NONE, 0xd, 0x4007);
@@ -129,6 +131,49 @@ int board_phy_config(struct phy_device *phydev)
 }
 #endif
 
+#if CONFIG_IS_ENABLED(FSL_ESDHC_IMX)
+int check_mmc_autodetect(void)
+{
+	char *autodetect_str = env_get("mmcautodetect");
+
+	if ((autodetect_str) &&
+	    (strcmp(autodetect_str, "yes") == 0)) {
+		return 1;
+	}
+
+	return 0;
+}
+
+void board_late_mmc_init(void)
+{
+	int dev_no = 0;
+	char cmd[32];
+
+	if (!check_mmc_autodetect())
+		return;
+
+	switch (get_boot_device()) {
+	case SD3_BOOT:
+	case MMC3_BOOT:
+		env_set("bootdev", "MMC3");
+		dev_no = 2;
+		break;
+	case SD1_BOOT:
+		env_set("bootdev", "SD1");
+		dev_no = 0;
+		break;
+	default:
+		printf("Wrong boot device!");
+	}
+
+	/* Set mmcdev env */
+	env_set_ulong("mmcdev", dev_no);
+
+	sprintf(cmd, "mmc dev %d", dev_no);
+	run_command(cmd, 0);
+}
+#endif
+
 static void setup_iomux_uart(void)
 {
 	imx_iomux_v3_setup_multiple_pads(uart5_pads, ARRAY_SIZE(uart5_pads));
@@ -176,6 +221,12 @@ int board_late_init(void)
 
 	set_wdog_reset(wdog);
 
+#if CONFIG_IS_ENABLED(FSL_ESDHC_IMX)
+#if defined(CONFIG_ENV_IS_IN_MMC) || defined(CONFIG_ENV_IS_NOWHERE)
+	board_late_mmc_init();
+#endif /* CONFIG_ENV_IS_IN_MMC or CONFIG_ENV_IS_NOWHERE */
+#endif
+
 	/*
 	 * Do not assert internal WDOG_RESET_B_DEB(controlled by bit 4),
 	 * since we use PMIC_PWRON to reset the board.
@@ -210,3 +261,9 @@ int board_ehci_hcd_init(int port)
 	}
 	return 0;
 }
+
+/* This should be defined for each board */
+__weak int mmc_map_to_kernel_blk(int dev_no)
+{
+	return dev_no;
+}
diff --git a/board/technexion/pico-imx7d/spl.c b/board/technexion/pico-imx7d/spl.c
index c6b21aaa42..0192eafbaa 100644
--- a/board/technexion/pico-imx7d/spl.c
+++ b/board/technexion/pico-imx7d/spl.c
@@ -15,6 +15,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/arch-mx7/mx7-ddr.h>
 #include <asm/mach-imx/iomux-v3.h>
+#include <asm/mach-imx/boot_mode.h>
 #include <asm/gpio.h>
 #include <asm/sections.h>
 #include <fsl_esdhc_imx.h>
@@ -159,7 +160,20 @@ void reset_cpu(void)
 #define USDHC_PAD_CTRL (PAD_CTL_DSE_3P3V_32OHM | PAD_CTL_SRE_SLOW | \
 	PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_PUS_PU47KOHM)
 
-static iomux_v3_cfg_t const usdhc3_pads[] = {
+#define USDHC1_CD_GPIO	IMX_GPIO_NR(5, 0)
+/* EMMC/SD */
+static const iomux_v3_cfg_t usdhc1_pads[] = {
+	MX7D_PAD_SD1_CLK__SD1_CLK | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX7D_PAD_SD1_CMD__SD1_CMD | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX7D_PAD_SD1_DATA0__SD1_DATA0 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX7D_PAD_SD1_DATA1__SD1_DATA1 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX7D_PAD_SD1_DATA2__SD1_DATA2 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX7D_PAD_SD1_DATA3__SD1_DATA3 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX7D_PAD_SD1_CD_B__GPIO5_IO0  | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+};
+
+#define USDHC3_CD_GPIO IMX_GPIO_NR(1, 14)
+static const iomux_v3_cfg_t usdhc3_emmc_pads[] = {
 	MX7D_PAD_SD3_CLK__SD3_CLK | MUX_PAD_CTRL(USDHC_PAD_CTRL),
 	MX7D_PAD_SD3_CMD__SD3_CMD | MUX_PAD_CTRL(USDHC_PAD_CTRL),
 	MX7D_PAD_SD3_DATA0__SD3_DATA0 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
@@ -173,20 +187,83 @@ static iomux_v3_cfg_t const usdhc3_pads[] = {
 	MX7D_PAD_GPIO1_IO14__GPIO1_IO14 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
 };
 
-static struct fsl_esdhc_cfg usdhc_cfg[1] = {
+static struct fsl_esdhc_cfg usdhc_cfg[2] = {
 	{USDHC3_BASE_ADDR},
+	{USDHC1_BASE_ADDR},
 };
 
 int board_mmc_getcd(struct mmc *mmc)
 {
-	/* Assume uSDHC3 emmc is always present */
-	return 1;
+	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
+	int ret = 0;
+
+	switch (cfg->esdhc_base) {
+	case USDHC1_BASE_ADDR:
+		ret = !gpio_get_value(USDHC1_CD_GPIO);
+		break;
+	case USDHC3_BASE_ADDR:
+		ret = !gpio_get_value(USDHC3_CD_GPIO);
+		break;
+	}
+
+	return ret;
 }
 
 int board_mmc_init(struct bd_info *bis)
 {
-	imx_iomux_v3_setup_multiple_pads(usdhc3_pads, ARRAY_SIZE(usdhc3_pads));
-	usdhc_cfg[0].sdhc_clk = mxc_get_clock(MXC_ESDHC3_CLK);
-	return fsl_esdhc_initialize(bis, &usdhc_cfg[0]);
+	int ret;
+	u32 index;
+
+	/*
+	 * Following map is done:
+	 * (USDHC)	(Physical Port)
+	 * usdhc3	SOM MicroSD/MMC
+	 * usdhc1	Carrier board MicroSD
+	 * Always set boot USDHC as mmc0
+	 */
+
+	imx_iomux_v3_setup_multiple_pads(usdhc3_emmc_pads,
+					 ARRAY_SIZE(usdhc3_emmc_pads));
+	gpio_direction_input(USDHC3_CD_GPIO);
+
+	imx_iomux_v3_setup_multiple_pads(usdhc1_pads,
+					 ARRAY_SIZE(usdhc1_pads));
+	gpio_direction_input(USDHC1_CD_GPIO);
+
+	switch (get_boot_device()) {
+	case SD1_BOOT:
+		usdhc_cfg[0].esdhc_base = USDHC1_BASE_ADDR;
+		usdhc_cfg[0].sdhc_clk = mxc_get_clock(MXC_ESDHC_CLK);
+		usdhc_cfg[0].max_bus_width = 4;
+		usdhc_cfg[1].esdhc_base = USDHC3_BASE_ADDR;
+		usdhc_cfg[1].sdhc_clk = mxc_get_clock(MXC_ESDHC3_CLK);
+		usdhc_cfg[1].max_bus_width = 4;
+		break;
+	case MMC3_BOOT:
+		usdhc_cfg[0].esdhc_base = USDHC3_BASE_ADDR;
+		usdhc_cfg[0].sdhc_clk = mxc_get_clock(MXC_ESDHC3_CLK);
+		usdhc_cfg[0].max_bus_width = 8;
+		usdhc_cfg[1].esdhc_base = USDHC1_BASE_ADDR;
+		usdhc_cfg[1].sdhc_clk = mxc_get_clock(MXC_ESDHC_CLK);
+		usdhc_cfg[1].max_bus_width = 4;
+		break;
+	case SD3_BOOT:
+	default:
+		usdhc_cfg[0].esdhc_base = USDHC3_BASE_ADDR;
+		usdhc_cfg[0].sdhc_clk = mxc_get_clock(MXC_ESDHC3_CLK);
+		usdhc_cfg[0].max_bus_width = 4;
+		usdhc_cfg[1].esdhc_base = USDHC1_BASE_ADDR;
+		usdhc_cfg[1].sdhc_clk = mxc_get_clock(MXC_ESDHC_CLK);
+		usdhc_cfg[1].max_bus_width = 4;
+		break;
+	}
+
+	for (index = 0; index < CFG_SYS_FSL_USDHC_NUM; ++index) {
+		ret = fsl_esdhc_initialize(bis, &usdhc_cfg[index]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 #endif
diff --git a/include/configs/pico-imx7d.h b/include/configs/pico-imx7d.h
index 096e5bbe66..f797bd51af 100644
--- a/include/configs/pico-imx7d.h
+++ b/include/configs/pico-imx7d.h
@@ -13,7 +13,7 @@
 #define CFG_MXC_UART_BASE		UART5_IPS_BASE_ADDR
 
 /* MMC Config */
-#define CFG_SYS_FSL_ESDHC_ADDR	0
+#define CFG_SYS_FSL_ESDHC_ADDR	USDHC3_BASE_ADDR
 
 #define CFG_DFU_ENV_SETTINGS \
 	"dfu_alt_info=" \
@@ -79,9 +79,11 @@
 		"name=rootfs,size=0,uuid=${uuid_gpt_rootfs}\0" \
 	"fastboot_partition_alias_system=rootfs\0" \
 	"setup_emmc=mmc dev 0; gpt write mmc 0 $partitions; reset;\0" \
+	"mmcautodetect=yes\0" \
 	PICO_BOOT_ENV
 
 #define BOOT_TARGET_DEVICES(func) \
+	func(MMC, mmc, 2) \
 	func(MMC, mmc, 0) \
 	func(USB, usb, 0) \
 	func(PXE, pxe, na) \
-- 
2.42.0.windows.2

