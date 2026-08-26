Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FC5C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A38D80BD7;
	Wed, 26 Aug 2026 13:42:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4P5sZaHuUGH6; Wed, 26 Aug 2026 13:42:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787751759;
	bh=Gb8lh0h4i/FKzPEwtHkAdchxtZ7O0t5JTbUJpcEHFaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X4Cpo2ovz8Q+3H9izRCn1pRG7nS2FBn9b6v4kXBpQ7druOix+f5ZU/M/MmT7mhNw0
	 OLKzLbBJBsoEJHOH6PD8B+01GuiGpBhMsTyj6KR9P6OFpeqHTbmeeucti3tej2d9/9
	 9+aMQZA9FBsCI+7tbZkMdDnjz35XdKcOHa/q3UJLX9VyYFBAynmGWrJUgu4aKRQuIL
	 3VAL3pnzw8MTAN11MlIAsI4QNa3H8iMfCjnanc7LigrdQi82Z4TTVy2GBdLeHs+otd
	 0DulrLMSYM5Ssda6yxMhzME0kZqPib8W7V/HvqswaJ5LB+IK4ZQT4iNoD6z4I8HXBi
	 62rHtQo6WbEgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EB0580BA8;
	Wed, 26 Aug 2026 13:42:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 28159334
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A82E40108
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rBHbxdca2_pM for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:35:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=Px8AhQEa
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp2.osuosl.org (Postfix) with ESMTPS id EB5DE4005F
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751302; bh=Gb8lh0h4i/FKzPEwtHkAdchxtZ7O0t5JTbUJpcEHFaA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=Px8AhQEazC7aM5Qn1tEiHZ4r419FF3jTCLsnidiMfRDSOiwpur+xDLPiA7X138Yma9ejFHmoQt1/j6zYxZVl1Ylzt7sCvnYjUu2bzqP/k6G9wq3iBIMyRQxPNXTRxLptzO7Ma5uHIFfrW0/gDfDRy65Fy7YB2IHTlY+9HnkDH7HJyDh/2kM0W6I0qZFU4A/UU44fkfMyLCgc84G9Iea0REek7dlK7T8snwwKxxejlJWEDIW7iyR7eEazJ3kzean9GZ58SlS3zrg2nXNrrCdMcHJT7Nqrr47J614uDinymMo/R9pCILQM4weFEPLcMRjBJ2QITJhP8bxt7JBn143D2g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751302; bh=xe8Cqc1zeDYK/1Z3Yph9vk0W8tdKWPhoHOpWNzj/19x=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=VVmdjYqjerCmSOLmeAYf6n9/wPD6DG98bg3isr9qwzVoX9S5mpPAjngew/WtlKpSEZeDIgOkmtif84g7OlFGmxLKfidoT2FbPCub5wYv1CbqT0piaTq8w8k/glR4PHndJvhNoemiun92Y/eDcXOZ3esTC5ROZqd2dbHCeA7BqlL5iv9ZYpoi/7V3jqQbtBSL8OS1cxoHPRpwzvatr5zWOjoT5fR3JyN6Rt8C6irvosm4hRHOhHNxazEsPdGOTCqHa34ueRchnkxzB92uEiQNIX7UjOv28Sv1PzYGReO681HEE/6qQvdBOrmL3hl1VVhw6LU54efOuv99HP6yy5xeXA==
X-YMail-OSG: u6plXrwVM1kRLU8aDuAyY2iqQ922_.B2.KbtFIfVxJ6Ox6AKKjhEzQMkDjs_.ER
 t7UJXPfRULN28rfqaBjuaWs1ygWzRelD6mmthqkp7YgWYXbBPmAB.Mh7q3Oh7aSnpu_R5UV_5epg
 sLIgU5QYxVuBd.D5rdH0zApSsFW_SSdNWgxXjEcLqM1sU2dJ23GUUJWDnWGwTTVvhIquNNrsh3zz
 jVq7ggBNfwlQ0EutRUkjKUrWPgQHdvbQxCvdW4psiWnrXVjdkoImA.fC7UK26VYDP6qZyKfrPGlk
 8mwWWGWaSPZ9UDi2oETx9xSeYKA5PqX7IPkKdkz8hh3ZuO5ewutz9zt5Bqu8bwl58ufLrPZYBYVB
 NPfKWComtpJRk.X.vlwHTue.vBgqT1_PJKGkAuUYYUQ8mvj0pR_O54DNjHz8O9CAup.DGwH3zZhi
 RU6Z8bZXxIek9N.xSVRrC8gwcokHrrlBsiVY9unSmVjhh5LhG.ykebpRRWuOkcnui1HeYT2DakUU
 LkNerC7dpJA8yoy_xzrcrR6eV_f0jjkJRTPPed6VErzwYoq2mmpFsuZdEEaHybTUZYNAvpx7s3Ph
 DpCtapHNBdlwto8ILFOOcdYtAafU80EATi0fd3JaNQaI0UMvR3B6ODBSrg5ZWYMVeGexLNoZiW24
 .6S6EVkAoPG4GkHp.nEnHJOGjs60D6G.qHLoNcZ4Tkfjw0OykcHQMisPYhjbSG_oa7iykhpgC5_R
 jtI19nQS1Jd6dqqymLs97IF5_Blp1KA0uGdpbUfObKzGRpwh3k7vQBNEvkfjOtb1iPv8DIKX9alP
 O9MqXHAKxtGOjoir0sP5dN.fQxpedkkUQtSZ_aymuFOLcnCzKW9edjL3z1GPVtgs2Ex7.weMNesn
 wG8syx6F_DyweJtvTCUslgKoiQ4Ioh4SPY43UDONYb71W6kfxWQlQnguPN3ULgbxyIXDl.x4avAE
 4DD0kB8RewTF_N7x98MHbRZucSzPdOh14PbZwtqat7sT57wT4uYXRhdc3BfjNpu3aSOnnl80Musg
 7wE7HFiPVhSCxexER_rmjST6mpFmWWU1rT5ZGxR5bZsvPkSclTe0fQYX1sxoAQA_VomzU0hqUnFT
 7uLWO9RLa6uUr915aRsdUc0L9MuAoAkHoZ4lD1rSf._JnZQRzB8gZCNZDP_cdQ1XlcZLCNKqgugz
 QnWvrxype_SkZj1Ioq.gsUvL93rRARc_d6AeouY8cxPwxTCl6OYhWUubMUZ9DGDmDOuMIsnX8P6o
 KCZvWORdbVmqQPJ0SoEdbVJq8r_oskYoGujJZPYq850w8xynpMLIE92fQmuIpvPdOXwOH14.iyjg
 tmFlERrsGvSMGOAgPCI.D9wybfFDvTciDpqgs87xK6TjLWOtdyhnTl3Mmcs_Al4_MbQWZDpDWKCr
 o3e0K3Mj9q0HZEzyJooNJkfYI5dxXfUIx915YVyMJx.qzJaHtsfJeN49CdaBjLgQkuNJBrCuNyBE
 znmAUg2EPzokM.GDBAJgKBkMr_a_Moe5n1OkDXnEAOX9qh8VaVEjhFot3e8li3AUOnkWXc0oZozy
 kYZTn51Gmx3cAoDUtyBxrx3QIdLkBrD7RAUCWULwqgEzYNQAqGzHXvQoorHdhP9AzgoMV0oJiD4T
 6KxwmAZFUStdEfN9Xp84Pih.ue.W4Yj3_yIt1fG4NkQE68vKPTuju5ZDOFaL7XBOErmwbm2KDKoG
 AK.xZvP0YYmRXl.iVh15RWbNSL7U51AYPabkcAvsWHgwbApDfrun837ntQ_qE5PvwpdS8Y72s7kC
 JCny9c4pERs7_ZIRFP1v2HYtq3dgY2qO1_bdIFgI_FnbWtdy1Otc9iKGmBAzLiC7D0pdqfy9BZhi
 NYUY0l702lZq0RLXjKa_x_P.nqZoWMHWgUFxc.WBn3LL8zfQKjtyGsLaplfBa8P7elFBO6Ulwsbh
 BpP2_j9885YsRo_ajj0C_IT9HlyQQL4KhKPKVnCrnwiic71O28U69Qwd9VqGehYihzly2994pZ3X
 stUzwNV3Cc_nAD6ge4YrzdaiMMhiz_URIFKp7Qx8WjkSefGxAQ4M9jFdu5k1XyeXsrdyCPOIVHbl
 aZIw-
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: 60736893-e1a0-4062-a7aa-11046a5cfb3a
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP;
 Wed, 26 Aug 2026 13:35:02 +0000
Received: from dip100.lsn.sg3.yahoo.com ([106.10.223.109])
 by hello (SMTP) with SMTP ID acc4f7a299298e219e9ccf723c2619d7;
 Wed, 26 Aug 2026 13:34:57 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v2 4/9] spi: airoha-snfi: add EN75xx SPI-NAND controller
 support
Date: Wed, 26 Aug 2026 19:04:38 +0530
Message-ID: <c96838a0e72cc742ba255b203504116ab17de56d.1787736704.git.maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787736704.git.maskachoska@yahoo.com>
References: <20260825222211.712836-1-maskachoska@yahoo.com>
 <cover.1787736704.git.maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:42:25 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Extend the existing Airoha SNFI serial-NAND controller driver to the
EN75xx family: the big-endian EN7512/EN7521/EN751221 and the
little-endian EN7528. This adds the family match, the controller
bring-up for these parts, and the uncached (CKSEG1) DMA cache-window
handling the EN7528 needs for the dirmap transfer buffer.

Signed-off-by: AK Sharma <maskachoska@yahoo.com>
---
 drivers/spi/Kconfig           |   3 +-
 drivers/spi/airoha_snfi_spi.c | 412 +++++++++++++++++++++++++++-------
 2 files changed, 339 insertions(+), 76 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index cfbedd64..83a79bee 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -62,7 +62,8 @@ config ADI_SPI3
 
 config AIROHA_SNFI_SPI
 	bool "Airoha SPI memory controller driver"
-	depends on ARCH_AIROHA
+	depends on ARCH_AIROHA || ARCH_EN75XX
+	select REGMAP
 	select SPI_MEM
 	help
 	  Enable the Airoha SPI memory controller driver. This driver is
diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 769ec956..87472887 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -9,6 +9,9 @@
  */
 
 #include <asm/unaligned.h>
+#if IS_ENABLED(CONFIG_ARCH_AIROHA)
+#include <asm/arch/scu-regmap.h>
+#endif
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
@@ -16,11 +19,34 @@
 #include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
 #include <linux/mtd/spinand.h>
+#include <linux/sizes.h>
 #include <linux/time.h>
 #include <regmap.h>
 #include <spi.h>
 #include <spi-mem.h>
 
+#if IS_ENABLED(CONFIG_ARCH_EN75XX)
+#include <asm/addrspace.h>
+/*
+ * EN7528 (MIPS 1004Kc) DMA coherency.
+ *
+ * This SoC inherits its cache setup from the vendor bootbase and U-Boot runs
+ * with CONFIG_MIPS_CACHE_SETUP disabled, where the dcache flush/invalidate
+ * primitives are not reliable.  dma_map_single() therefore cannot make the
+ * shared buffer coherent: a multi-page read returns the same stale cache line
+ * for every page.  Use the uncached KSEG1 alias for all CPU accesses to the
+ * DMA buffer and give the controller the physical address instead.
+ * (Same remedy as the airoha_eth ring/frame buffers on this SoC.)
+ */
+#define snfi_uncached(p)	((void *)CKSEG1ADDR((unsigned long)(p)))
+#define snfi_dma_addr(p, l, d)	((dma_addr_t)CPHYSADDR((unsigned long)(p)))
+#define snfi_dma_unmap(a, l, d)	do { } while (0)
+#else
+#define snfi_uncached(p)	(p)
+#define snfi_dma_addr(p, l, d)	dma_map_single((p), (l), (d))
+#define snfi_dma_unmap(a, l, d)	dma_unmap_single((a), (l), (d))
+#endif
+
 /* SPI */
 #define REG_SPI_CTRL_READ_MODE			0x0000
 #define REG_SPI_CTRL_READ_IDLE_EN		0x0004
@@ -80,12 +106,19 @@
 
 #define REG_SPI_CTRL_NFI2SPI_EN			0x0130
 #define SPI_CTRL_NFI2SPI_EN			BIT(0)
+#define REG_SCUCLK_BOOT_TRP			0x00b8
+#define SCUCLK_BOOT_TRP_BOOT_FROM_EMMC		BIT(6)
+#define SPI_NFI_SNF_NFI_CNFG_SPI_MODE			BIT(2)
+#define SPI_CTRL_SFC_STRAP_BOOT_FROM_SPI_NAND	BIT(1)
 
 /* NFI2SPI */
 #define REG_SPI_NFI_CNFG			0x0000
 #define SPI_NFI_DMA_MODE			BIT(0)
 #define SPI_NFI_READ_MODE			BIT(1)
 #define SPI_NFI_DMA_BURST_EN			BIT(2)
+#define SPI_NFI_DMA_WR_BYTE_SWAP_EN		BIT(3)
+#define SPI_NFI_DMA_RD_BYTE_SWAP_EN		BIT(4)
+#define SPI_NFI_ECC_DATA_SOURCE_INV_EN		BIT(5)
 #define SPI_NFI_HW_ECC_EN			BIT(8)
 #define SPI_NFI_AUTO_FDM_EN			BIT(9)
 #define SPI_NFI_OPMODE				GENMASK(14, 12)
@@ -93,6 +126,8 @@
 #define REG_SPI_NFI_PAGEFMT			0x0004
 #define SPI_NFI_PAGE_SIZE			GENMASK(1, 0)
 #define SPI_NFI_SPARE_SIZE			GENMASK(5, 4)
+#define SPI_NFI_FDM_NUM				GENMASK(11, 8)
+#define SPI_NFI_FDM_ECC_NUM			GENMASK(15, 12)
 
 #define REG_SPI_NFI_CON				0x0008
 #define SPI_NFI_FIFO_FLUSH			BIT(0)
@@ -213,15 +248,89 @@ enum airoha_snand_cs {
 	SPI_CHIP_SEL_LOW,
 };
 
+enum airoha_snand_bootstrap {
+	AIROHA_SNAND_BOOTSTRAP_UNKNOWN,
+	AIROHA_SNAND_BOOTSTRAP_NAND,
+	AIROHA_SNAND_BOOTSTRAP_NOR,
+	AIROHA_SNAND_BOOTSTRAP_EMMC,
+};
+
 struct airoha_snand_priv {
+	struct udevice *dev;
 	struct regmap *regmap_ctrl;
 	struct regmap *regmap_nfi;
 	struct clk *spi_clk;
 
 	u8 *txrx_buf;
+	bool en751221;
 	int dma;
 };
 
+static const char *airoha_snand_bootstrap_name(enum airoha_snand_bootstrap type)
+{
+	switch (type) {
+	case AIROHA_SNAND_BOOTSTRAP_NAND:
+		return "NAND";
+	case AIROHA_SNAND_BOOTSTRAP_NOR:
+		return "NOR";
+	case AIROHA_SNAND_BOOTSTRAP_EMMC:
+		return "eMMC";
+	case AIROHA_SNAND_BOOTSTRAP_UNKNOWN:
+	default:
+		return "unknown";
+	}
+}
+
+static enum airoha_snand_bootstrap
+airoha_snand_get_bootstrap(struct airoha_snand_priv *priv, u32 *boot_trp,
+				   u32 *snf_nfi_cnfg, u32 *sfc_strap)
+{
+	int err;
+
+	*boot_trp = 0;
+	*snf_nfi_cnfg = 0;
+	*sfc_strap = 0;
+
+	if (!priv->en751221) {
+#if IS_ENABLED(CONFIG_ARCH_AIROHA)
+		struct regmap *regmap_scu = airoha_get_scu_regmap();
+
+		if (!regmap_scu)
+			return AIROHA_SNAND_BOOTSTRAP_UNKNOWN;
+
+		err = regmap_read(regmap_scu, REG_SCUCLK_BOOT_TRP, boot_trp);
+		if (err)
+			return AIROHA_SNAND_BOOTSTRAP_UNKNOWN;
+
+		if (*boot_trp & SCUCLK_BOOT_TRP_BOOT_FROM_EMMC)
+			return AIROHA_SNAND_BOOTSTRAP_EMMC;
+#else
+		return AIROHA_SNAND_BOOTSTRAP_UNKNOWN;
+#endif
+	}
+
+	if (priv->regmap_nfi) {
+		err = regmap_read(priv->regmap_nfi,
+				  REG_SPI_NFI_SNF_NFI_CNFG,
+				  snf_nfi_cnfg);
+		if (err)
+			return AIROHA_SNAND_BOOTSTRAP_UNKNOWN;
+
+		/* SNF_NFI_CNFG bit 2 selects SPI-NFI. If it is clear, the
+		 * boot source is still NAND through the parallel NAND path.
+		 */
+		if (!(*snf_nfi_cnfg & SPI_NFI_SNF_NFI_CNFG_SPI_MODE))
+			return AIROHA_SNAND_BOOTSTRAP_NAND;
+	}
+
+	err = regmap_read(priv->regmap_ctrl, REG_SPI_CTRL_SFC_STRAP, sfc_strap);
+	if (err)
+		return AIROHA_SNAND_BOOTSTRAP_UNKNOWN;
+
+	return (*sfc_strap & SPI_CTRL_SFC_STRAP_BOOT_FROM_SPI_NAND) ?
+		AIROHA_SNAND_BOOTSTRAP_NAND : AIROHA_SNAND_BOOTSTRAP_NOR;
+}
+
 static int airoha_snand_set_fifo_op(struct airoha_snand_priv *priv,
 				    u8 op_cmd, int op_len)
 {
@@ -254,7 +363,19 @@ static int airoha_snand_set_fifo_op(struct airoha_snand_priv *priv,
 
 static int airoha_snand_set_cs(struct airoha_snand_priv *priv, u8 cs)
 {
-	return airoha_snand_set_fifo_op(priv, cs, sizeof(cs));
+	int count = priv->en751221 ? 2 : 1;
+	int err;
+
+	/* EN751221 sporadically drops writes unless the CS operation is sent
+	 * twice. This mirrors the quirk used by the Linux EcoNet port.
+	 */
+	while (count--) {
+		err = airoha_snand_set_fifo_op(priv, cs, sizeof(cs));
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 static int airoha_snand_write_data_to_fifo(struct airoha_snand_priv *priv,
@@ -367,7 +488,7 @@ static int airoha_snand_set_mode(struct airoha_snand_priv *priv,
 	case SPI_MODE_DMA:
 		err = regmap_write(priv->regmap_ctrl,
 				   REG_SPI_CTRL_NFI2SPI_EN,
-				   SPI_CTRL_MANUAL_EN);
+				   SPI_CTRL_NFI2SPI_EN);
 		if (err < 0)
 			return err;
 
@@ -465,17 +586,81 @@ static int airoha_snand_read_data(struct airoha_snand_priv *priv,
 	return 0;
 }
 
+static int airoha_snand_nfi_reset(struct airoha_snand_priv *priv)
+{
+	/* Same reset value used by the vendor driver: reset the NFI state
+	 * machine and flush its FIFO before a DMA transaction.
+	 */
+	return regmap_write(priv->regmap_nfi, REG_SPI_NFI_CON,
+			    SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+}
+
+static int airoha_snand_nfi_clear_intr(struct airoha_snand_priv *priv)
+{
+	/* NFI interrupt status bits are write-one-to-clear on this block.
+	 * Clear stale completion state before arming a new DMA transaction so
+	 * polling cannot succeed on an old AHB_DONE value.
+	 */
+	return regmap_write(priv->regmap_nfi, REG_SPI_NFI_INTR,
+			    SPI_NFI_ALL_IRQ_EN);
+}
+
+static int airoha_snand_nfi_clear_done(struct airoha_snand_priv *priv)
+{
+	/* READ_FROM_CACHE_DONE and LOAD_TO_CACHE_DONE are also sticky W1C bits.
+	 * Clear them before DMA so polling observes the current transaction only.
+	 */
+	return regmap_write(priv->regmap_nfi, REG_SPI_NFI_SNF_STA_CTL1,
+			    SPI_NFI_READ_FROM_CACHE_DONE |
+			    SPI_NFI_LOAD_TO_CACHE_DONE);
+}
+
 static int airoha_snand_nfi_init(struct airoha_snand_priv *priv)
 {
 	int err;
 
-	/* switch to SNFI mode */
+	/* Switch to SNFI mode. */
 	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_SNF_NFI_CNFG,
 			   SPI_NFI_SPI_MODE);
 	if (err)
 		return err;
 
-	/* Enable DMA */
+	err = airoha_snand_nfi_reset(priv);
+	if (err)
+		return err;
+
+	err = airoha_snand_nfi_clear_intr(priv);
+	if (err)
+		return err;
+
+	err = airoha_snand_nfi_clear_done(priv);
+	if (err)
+		return err;
+
+	/* Mirror the safe vendor configuration used when the SPI NAND uses its
+	 * internal ECC: disable controller ECC/FDM and byte-swap helpers.  The
+	 * SPI NAND core still controls on-die ECC, QE, die-select and status
+	 * handling through normal SPI-MEM commands.
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_DMA_WR_BYTE_SWAP_EN |
+				 SPI_NFI_DMA_RD_BYTE_SWAP_EN |
+				 SPI_NFI_ECC_DATA_SOURCE_INV_EN |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN,
+				 0);
+	if (err)
+		return err;
+
+	/* FDM is disabled above, but clear its page-format fields as well so a
+	 * previous boot stage cannot leave stale vendor ECC layout behind.
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_PAGEFMT,
+				 SPI_NFI_FDM_NUM | SPI_NFI_FDM_ECC_NUM, 0);
+	if (err)
+		return err;
+
+	/* Enable only the DMA completion interrupt source used by polling. */
 	return regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_INTR_EN,
 				  SPI_NFI_ALL_IRQ_EN, SPI_NFI_AHB_DONE_EN);
 }
@@ -551,6 +736,54 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	return 0;
 }
 
+
+static ssize_t airoha_snand_no_dirmap_write(struct spi_mem_dirmap_desc *desc,
+					    u64 offs, size_t len, const void *buf)
+{
+	struct spi_mem_op op = desc->info.op_tmpl;
+	int err;
+
+	op.addr.val = desc->info.offset + offs;
+	op.data.buf.out = buf;
+	op.data.nbytes = len;
+
+	err = spi_mem_exec_op(desc->slave, &op);
+	if (err)
+		return err;
+
+	return op.data.nbytes;
+}
+
+static bool airoha_snand_dma_write_ok(struct spi_mem_dirmap_desc *desc,
+					      u64 offs, size_t len)
+{
+	/*
+	 * The NFI DMA path programs a contiguous cache window.  Do not emulate
+	 * unaligned/short writes by padding the beginning or the end with 0xff:
+	 * PROGRAM LOAD/RANDOM LOAD operates on the SPI NAND cache, so padding can
+	 * poison bytes that the caller did not ask us to touch.  This is especially
+	 * dangerous for boot blocks updated in small chunks.
+	 *
+	 * Keep DMA only for exact transfers that the controller can issue without
+	 * synthetic padding.  Everything else falls back to the manual SPI-MEM path,
+	 * which sends the exact column address and exact byte count requested by the
+	 * SPI NAND core.
+	 */
+	if (!len)
+		return false;
+
+	if (!IS_ALIGNED(desc->info.offset + offs, 16))
+		return false;
+
+	if (!IS_ALIGNED(len, 64))
+		return false;
+
+	if (len > SPI_NAND_CACHE_SIZE)
+		return false;
+
+	return true;
+}
+
 static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 					u64 offs, size_t len, void *buf)
 {
@@ -609,9 +842,15 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err < 0)
 		return err;
 
-	/* NFI reset */
-	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CON,
-			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	err = airoha_snand_nfi_reset(priv);
+	if (err)
+		goto error_dma_mode_off;
+
+	err = airoha_snand_nfi_clear_intr(priv);
+	if (err)
+		goto error_dma_mode_off;
+
+	err = airoha_snand_nfi_clear_done(priv);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -653,7 +892,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_mode_off;
 
-	dma_addr = dma_map_single(txrx_buf, SPI_NAND_CACHE_SIZE,
+	dma_addr = snfi_dma_addr(txrx_buf, SPI_NAND_CACHE_SIZE,
 				  DMA_FROM_DEVICE);
 
 	/* set dma addr */
@@ -721,9 +960,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	 * SPI_NFI_READ_FROM_CACHE_DONE bit must be written at the end
 	 * of dirmap_read operation even if it is already set.
 	 */
-	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SNF_STA_CTL1,
-				 SPI_NFI_READ_FROM_CACHE_DONE,
-				 SPI_NFI_READ_FROM_CACHE_DONE);
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_SNF_STA_CTL1,
+			   SPI_NFI_READ_FROM_CACHE_DONE);
 	if (err)
 		goto error_dma_unmap;
 
@@ -736,7 +974,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	/* DMA read need delay for data ready from controller to DRAM */
 	udelay(1);
 
-	dma_unmap_single(dma_addr, SPI_NAND_CACHE_SIZE, DMA_FROM_DEVICE);
+	snfi_dma_unmap(dma_addr, SPI_NAND_CACHE_SIZE, DMA_FROM_DEVICE);
 
 	err = airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
 	if (err < 0)
@@ -747,7 +985,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	return len;
 
 error_dma_unmap:
-	dma_unmap_single(dma_addr, SPI_NAND_CACHE_SIZE, DMA_FROM_DEVICE);
+	snfi_dma_unmap(dma_addr, SPI_NAND_CACHE_SIZE, DMA_FROM_DEVICE);
 error_dma_mode_off:
 	airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
 	return err;
@@ -765,22 +1003,10 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	size_t bytes;
 	int err;
 
-	if (!priv->dma) {
-		/* simplified version of spi_mem_no_dirmap_write() */
-		struct spi_mem_op op = desc->info.op_tmpl;
-
-		op.addr.val = desc->info.offset + offs;
-		op.data.buf.out = buf;
-		op.data.nbytes = len;
-		err = spi_mem_exec_op(desc->slave, &op);
-		if (err)
-			return err;
-
-		return op.data.nbytes;
-	}
+	if (!priv->dma || !airoha_snand_dma_write_ok(desc, offs, len))
+		return airoha_snand_no_dirmap_write(desc, offs, len, buf);
 
-	/* minimum oob size is 64 */
-	bytes = round_up(offs + len, 64);
+	bytes = len;
 
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
@@ -797,19 +1023,21 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		return -EOPNOTSUPP;
 	}
 
-	if (offs > 0)
-		memset(txrx_buf, 0xff, offs);
-	memcpy(txrx_buf + offs, buf, len);
-	if (bytes > offs + len)
-		memset(txrx_buf + offs + len, 0xff, bytes - offs - len);
+	memcpy(txrx_buf, buf, len);
 
 	err = airoha_snand_set_mode(priv, SPI_MODE_DMA);
 	if (err < 0)
 		return err;
 
-	/* NFI reset */
-	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CON,
-			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	err = airoha_snand_nfi_reset(priv);
+	if (err)
+		goto error_dma_mode_off;
+
+	err = airoha_snand_nfi_clear_intr(priv);
+	if (err)
+		goto error_dma_mode_off;
+
+	err = airoha_snand_nfi_clear_done(priv);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -851,7 +1079,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_mode_off;
 
-	dma_addr = dma_map_single(txrx_buf, SPI_NAND_CACHE_SIZE,
+	dma_addr = snfi_dma_addr(txrx_buf, SPI_NAND_CACHE_SIZE,
 				  DMA_TO_DEVICE);
 
 	/* set dma addr */
@@ -887,9 +1115,9 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set write addr: zero page offset + descriptor write offset */
+	/* set write addr: descriptor base column + requested dirmap offset */
 	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_PG_CTL2,
-			   desc->info.offset);
+			   desc->info.offset + offs);
 	if (err)
 		goto error_dma_unmap;
 
@@ -908,6 +1136,9 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
+	/* Vendor code gives the DMA engine a short settle time after WR_TRIG. */
+	udelay(1);
+
 	err = regmap_read_poll_timeout(priv->regmap_nfi, REG_SPI_NFI_INTR,
 				       val, (val & SPI_NFI_AHB_DONE), 0,
 				       1 * MSEC_PER_SEC);
@@ -925,13 +1156,12 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	 * SPI_NFI_LOAD_TO_CACHE_DONE bit must be written at the end
 	 * of dirmap_write operation even if it is already set.
 	 */
-	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SNF_STA_CTL1,
-				 SPI_NFI_LOAD_TO_CACHE_DONE,
-				 SPI_NFI_LOAD_TO_CACHE_DONE);
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_SNF_STA_CTL1,
+			   SPI_NFI_LOAD_TO_CACHE_DONE);
 	if (err)
 		goto error_dma_unmap;
 
-	dma_unmap_single(dma_addr, SPI_NAND_CACHE_SIZE, DMA_TO_DEVICE);
+	snfi_dma_unmap(dma_addr, SPI_NAND_CACHE_SIZE, DMA_TO_DEVICE);
 
 	err = airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
 	if (err < 0)
@@ -940,7 +1170,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	return len;
 
 error_dma_unmap:
-	dma_unmap_single(dma_addr, SPI_NAND_CACHE_SIZE, DMA_TO_DEVICE);
+	snfi_dma_unmap(dma_addr, SPI_NAND_CACHE_SIZE, DMA_TO_DEVICE);
 error_dma_mode_off:
 	airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
 	return err;
@@ -986,7 +1216,7 @@ static int airoha_snand_exec_op(struct spi_slave *slave,
 	err = airoha_snand_write_data(priv, data, op_len,
 				      op->cmd.buswidth);
 	if (err)
-		return err;
+		goto out_cs_high;
 
 	/* addr part */
 	data += op_len;
@@ -994,7 +1224,7 @@ static int airoha_snand_exec_op(struct spi_slave *slave,
 		err = airoha_snand_write_data(priv, data, addr_len,
 					      op->addr.buswidth);
 		if (err)
-			return err;
+			goto out_cs_high;
 	}
 
 	/* dummy */
@@ -1003,7 +1233,7 @@ static int airoha_snand_exec_op(struct spi_slave *slave,
 		err = airoha_snand_write_data(priv, data, dummy_len,
 					      op->dummy.buswidth);
 		if (err)
-			return err;
+			goto out_cs_high;
 	}
 
 	/* data */
@@ -1017,23 +1247,37 @@ static int airoha_snand_exec_op(struct spi_slave *slave,
 						      op->data.nbytes,
 						      op->data.buswidth);
 		if (err)
-			return err;
+			goto out_cs_high;
 	}
 
-	return airoha_snand_set_cs(priv, SPI_CHIP_SEL_HIGH);
+out_cs_high:
+	/* Always release CS.  Leaving CS asserted after a FIFO timeout can lock
+	 * the shared SPI bus, which is visible on boards using NOR + NAND.
+	 */
+	if (airoha_snand_set_cs(priv, SPI_CHIP_SEL_HIGH) && !err)
+		err = -EIO;
+
+	return err;
 }
 
 static int airoha_snand_probe(struct udevice *dev)
 {
 	struct airoha_snand_priv *priv = dev_get_priv(dev);
+	enum airoha_snand_bootstrap type;
+	u32 boot_trp, snf_nfi_cnfg, sfc_strap;
 	int ret;
-	u32 sfc_strap;
 
-	priv->txrx_buf = memalign(ARCH_DMA_MINALIGN, SPI_NAND_CACHE_SIZE);
-	if (!priv->txrx_buf) {
-		dev_err(dev, "failed to alloacate memory for dirmap\n");
+	void *txrx_buf = memalign(ARCH_DMA_MINALIGN, SPI_NAND_CACHE_SIZE);
+
+	if (!txrx_buf) {
+		dev_err(dev, "failed to allocate memory for dirmap\n");
 		return -ENOMEM;
 	}
+	priv->txrx_buf = snfi_uncached(txrx_buf);
+	priv->dev = dev;
+	priv->en751221 = of_machine_is_compatible("econet,en751221") ||
+			   of_machine_is_compatible("econet,en7512") ||
+			   of_machine_is_compatible("econet,en7521");
 
 	ret = regmap_init_mem_index(dev_ofnode(dev), &priv->regmap_ctrl, 0);
 	if (ret) {
@@ -1043,36 +1287,48 @@ static int airoha_snand_probe(struct udevice *dev)
 
 	ret = regmap_init_mem_index(dev_ofnode(dev), &priv->regmap_nfi, 1);
 	if (ret) {
-		dev_err(dev, "failed to init spi nfi regmap\n");
-		return ret;
+		if (!priv->en751221) {
+			dev_err(dev, "failed to init spi nfi regmap\n");
+			return ret;
+		}
+
+		/* EN751221 has no separate NFI/SNFI DMA register bank. */
+		priv->regmap_nfi = NULL;
 	}
 
-	priv->spi_clk = devm_clk_get(dev, "spi");
+	priv->spi_clk = devm_clk_get_optional(dev, "spi");
 	if (IS_ERR(priv->spi_clk)) {
-		dev_err(dev, "unable to get spi clk\n");
-		return PTR_ERR(priv->regmap_ctrl);
-	}
-	clk_enable(priv->spi_clk);
+		ret = PTR_ERR(priv->spi_clk);
+		if (ret != -ENOSYS) {
+			dev_err(dev, "unable to get spi clk\n");
+			return ret;
+		}
 
-	priv->dma = 1;
-	if (device_is_compatible(dev, "airoha,en7523-snand")){
-		ret = regmap_read(priv->regmap_ctrl, REG_SPI_CTRL_SFC_STRAP, &sfc_strap);
+		/* EN751221 does not require the U-Boot clock framework. */
+		priv->spi_clk = NULL;
+	}
+	if (priv->spi_clk) {
+		ret = clk_enable(priv->spi_clk);
 		if (ret)
 			return ret;
-
-		if (!(sfc_strap & 0x04)) {
-			priv->dma = 0;
-			printf("\n"
-				"=== WARNING ======================================================\n"
-				"Detected booting in RESERVED mode (UART_TXD was short to GND).\n"
-				"This mode is known for incorrect DMA reading of some flashes.\n"
-				"Usage of DMA for flash operations will be disabled to prevent data\n"
-				"damage. Unplug your serial console and power cycle the board\n"
-				"to boot with full performance.\n"
-				"==================================================================\n\n");
-		}
 	}
 
+	type = airoha_snand_get_bootstrap(priv, &boot_trp, &snf_nfi_cnfg,
+					   &sfc_strap);
+
+	dev_dbg(priv->dev,
+		 "bootstrap: %s (boot_trp=0x%08x, snf_nfi_cnfg=0x%08x, sfc_strap=0x%08x)\n",
+		 airoha_snand_bootstrap_name(type), boot_trp, snf_nfi_cnfg,
+		 sfc_strap);
+
+	/* EN751221 uses only the manual FIFO path. EN7523/AN7581 can use
+	 * the second register bank for SNFI DMA operations.
+	 */
+	priv->dma = !!priv->regmap_nfi;
+
+	if (!priv->regmap_nfi)
+		return 0;
+
 	return airoha_snand_nfi_init(priv);
 }
 
@@ -1081,6 +1337,10 @@ static int airoha_snand_nfi_set_speed(struct udevice *bus, uint speed)
 	struct airoha_snand_priv *priv = dev_get_priv(bus);
 	int ret;
 
+	/* EN751221 leaves the SFC clock configured by the previous stage. */
+	if (!priv->spi_clk)
+		return 0;
+
 	ret = clk_set_rate(priv->spi_clk, speed);
 	if (ret < 0)
 		return ret;
@@ -1108,6 +1368,7 @@ static const struct dm_spi_ops airoha_snfi_spi_ops = {
 };
 
 static const struct udevice_id airoha_snand_ids[] = {
+	{ .compatible = "airoha,en7523-spi" },
 	{ .compatible = "airoha,en7581-snand" },
 	{ }
 };
@@ -1120,3 +1381,4 @@ U_BOOT_DRIVER(airoha_snfi_spi) = {
 	.priv_auto = sizeof(struct airoha_snand_priv),
 	.probe = airoha_snand_probe,
 };
+
-- 
2.53.0

