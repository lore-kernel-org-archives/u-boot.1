Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E2EC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 18:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6033889BA;
	Wed, 14 Aug 2024 20:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bUcFPQAi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22E3C889EB; Wed, 14 Aug 2024 20:28:58 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B10889BA
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 20:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fc4e010efdso79155ad.3
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 11:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723660134; x=1724264934; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=60LD6LUGaFgJNbzROtGui80RskdwwlZzARBnv/v3MH4=;
 b=bUcFPQAij5iCYx9+l7gdV9Ka8G50cg94nesJlCiyrAZDusIqGM1tuSqUh4jM1UUEea
 xry558YoTD1KVcgbq77vzGd8VO7n10FH/iU7YNvoVSfoLohdgtkryWNF38HYdbQYSA4i
 ar9h1O0jgyDtAQGUERGLOCHGv2rZEwLXzGCrTDv1xUhBCou3kU6cIvvsO38yEXOxLh3u
 ZZL7E7Z26xxOFnh6cfnuXVSDKKljgnOe2NCGTmI6SSaMPS3njBoQfNYyUwXLGatAW1wC
 p2bbBfvZ/Ao3fNWj/jGxCcH/95N+r438qcC02+GOMSN4e2QjDio5vMlyV66A1SQGmmof
 GwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723660134; x=1724264934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=60LD6LUGaFgJNbzROtGui80RskdwwlZzARBnv/v3MH4=;
 b=nub/fO0jJJcVBcMtXnhKaq59Ph7c490/0L7V0gV3RSUmU5bvhFFPYajECBDeNe9HqF
 YLPyfRlWOodX2fp4h/oSmIF4h9ljlx89sR8ykiy3qcaaR8v9QIEUIyjA3vTPVBV05eNQ
 6GQF/YPWXnk6az5FH0vDfgoRe14XMY9XwX+GsI6FyQGLHjIZIGqM2VSb33yLC7tZZCKw
 LProrWU7eyPZR/5S/+YEKzHGz57UjkfNWsTNpjaecI7LOicaDA+jlcm2IP+PaeSAuHOM
 kexW3aMdrTa3J5W4M+r4QwcYWMQ9WWrBWzgjHgXRPrnabMiI3sZi0Fg+8ux7+qOWcfec
 vEYw==
X-Gm-Message-State: AOJu0Yyj9eb5V5llYlZNoUGVw+i26IYOM+0o+39g14/qjEM4IJOr87Y7
 5+DzCCvLsvD6+i+7FaEpe0RXPPOIOYpv2I1XvQAogNFupWz8zGmlaiT8vw==
X-Google-Smtp-Source: AGHT+IFU4xD8Kc0xc4rNLlCFhffeSDYKxstmPb5P+TIXC0OFFCE6Gx2ZlMFhAIHBo46CtudAeWr8zg==
X-Received: by 2002:a17:902:c412:b0:1f7:1a37:d0b5 with SMTP id
 d9443c01a7336-201d63ba806mr24487915ad.4.1723660133686; 
 Wed, 14 Aug 2024 11:28:53 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:31ab:46dd:f2b3:633])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd13149csm32563535ad.47.2024.08.14.11.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 11:28:53 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: Markus.Niebel@tq-group.com
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/3] tqma6: Remove non-DM board code
Date: Wed, 14 Aug 2024 15:28:43 -0300
Message-Id: <20240814182845.762118-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

CONFIG_DM_MMC and CONFIG_DM_SPI are alway selected so the mmc
and spi board code can be safely removed.

Remove it to make the code cleaner.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 board/tq/tqma6/tqma6.c | 126 -----------------------------------------
 1 file changed, 126 deletions(-)

diff --git a/board/tq/tqma6/tqma6.c b/board/tq/tqma6/tqma6.c
index 445ce987b68..40369f03e72 100644
--- a/board/tq/tqma6/tqma6.c
+++ b/board/tq/tqma6/tqma6.c
@@ -19,33 +19,15 @@
 #include <linux/errno.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
-#include <asm/mach-imx/spi.h>
-#include <fsl_esdhc_imx.h>
 #include <linux/libfdt.h>
 #include <mmc.h>
 #include <power/pfuze100_pmic.h>
 #include <power/pmic.h>
-#include <spi_flash.h>
 
 #include "tqma6_bb.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#define USDHC_CLK_PAD_CTRL (PAD_CTL_PUS_47K_UP  | PAD_CTL_SPEED_LOW | \
-	PAD_CTL_DSE_40ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
-
-#define USDHC_PAD_CTRL (PAD_CTL_PUS_47K_UP  | PAD_CTL_SPEED_LOW | \
-	PAD_CTL_DSE_80ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
-
-#define GPIO_OUT_PAD_CTRL  (PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_LOW | \
-	PAD_CTL_DSE_40ohm   | PAD_CTL_HYS)
-
-#define GPIO_IN_PAD_CTRL  (PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_LOW | \
-	PAD_CTL_DSE_40ohm   | PAD_CTL_HYS)
-
-#define SPI_PAD_CTRL (PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED | \
-	PAD_CTL_DSE_80ohm | PAD_CTL_SRE_FAST | PAD_CTL_HYS)
-
 int dram_init(void)
 {
 	gd->ram_size = imx_ddr_size();
@@ -55,114 +37,6 @@ int dram_init(void)
 
 static const uint16_t tqma6_emmc_dsr = 0x0100;
 
-#ifndef CONFIG_DM_MMC
-/* eMMC on USDHCI3 always present */
-static iomux_v3_cfg_t const tqma6_usdhc3_pads[] = {
-	NEW_PAD_CTRL(MX6_PAD_SD3_CLK__SD3_CLK,		USDHC_PAD_CTRL),
-	NEW_PAD_CTRL(MX6_PAD_SD3_CMD__SD3_CMD,		USDHC_PAD_CTRL),
-	NEW_PAD_CTRL(MX6_PAD_SD3_DAT0__SD3_DATA0,	USDHC_PAD_CTRL),
-	NEW_PAD_CTRL(MX6_PAD_SD3_DAT1__SD3_DATA1,	USDHC_PAD_CTRL),
-	NEW_PAD_CTRL(MX6_PAD_SD3_DAT2__SD3_DATA2,	USDHC_PAD_CTRL),
-	NEW_PAD_CTRL(MX6_PAD_SD3_DAT3__SD3_DATA3,	USDHC_PAD_CTRL),
-	NEW_PAD_CTRL(MX6_PAD_SD3_DAT4__SD3_DATA4,	USDHC_PAD_CTRL),
-	NEW_PAD_CTRL(MX6_PAD_SD3_DAT5__SD3_DATA5,	USDHC_PAD_CTRL),
-	NEW_PAD_CTRL(MX6_PAD_SD3_DAT6__SD3_DATA6,	USDHC_PAD_CTRL),
-	NEW_PAD_CTRL(MX6_PAD_SD3_DAT7__SD3_DATA7,	USDHC_PAD_CTRL),
-	/* eMMC reset */
-	NEW_PAD_CTRL(MX6_PAD_SD3_RST__SD3_RESET,	GPIO_OUT_PAD_CTRL),
-};
-
-/*
- * According to board_mmc_init() the following map is done:
- * (U-Boot device node)    (Physical Port)
- * mmc0                    eMMC (SD3) on TQMa6
- * mmc1 .. n               optional slots used on baseboard
- */
-struct fsl_esdhc_cfg tqma6_usdhc_cfg = {
-	.esdhc_base = USDHC3_BASE_ADDR,
-	.max_bus_width = 8,
-};
-
-int board_mmc_getcd(struct mmc *mmc)
-{
-	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
-	int ret = 0;
-
-	if (cfg->esdhc_base == USDHC3_BASE_ADDR)
-		/* eMMC/uSDHC3 is always present */
-		ret = 1;
-	else
-		ret = tqma6_bb_board_mmc_getcd(mmc);
-
-	return ret;
-}
-
-int board_mmc_getwp(struct mmc *mmc)
-{
-	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
-	int ret = 0;
-
-	if (cfg->esdhc_base == USDHC3_BASE_ADDR)
-		/* eMMC/uSDHC3 is always present */
-		ret = 0;
-	else
-		ret = tqma6_bb_board_mmc_getwp(mmc);
-
-	return ret;
-}
-
-int board_mmc_init(struct bd_info *bis)
-{
-	imx_iomux_v3_setup_multiple_pads(tqma6_usdhc3_pads,
-					 ARRAY_SIZE(tqma6_usdhc3_pads));
-	tqma6_usdhc_cfg.sdhc_clk = mxc_get_clock(MXC_ESDHC3_CLK);
-	if (fsl_esdhc_initialize(bis, &tqma6_usdhc_cfg)) {
-		puts("Warning: failed to initialize eMMC dev\n");
-	} else {
-		struct mmc *mmc = find_mmc_device(0);
-		if (mmc)
-			mmc_set_dsr(mmc, tqma6_emmc_dsr);
-	}
-
-	tqma6_bb_board_mmc_init(bis);
-
-	return 0;
-}
-#endif
-
-#ifndef CONFIG_DM_SPI
-static iomux_v3_cfg_t const tqma6_ecspi1_pads[] = {
-	/* SS1 */
-	NEW_PAD_CTRL(MX6_PAD_EIM_D19__GPIO3_IO19, SPI_PAD_CTRL),
-	NEW_PAD_CTRL(MX6_PAD_EIM_D16__ECSPI1_SCLK, SPI_PAD_CTRL),
-	NEW_PAD_CTRL(MX6_PAD_EIM_D17__ECSPI1_MISO, SPI_PAD_CTRL),
-	NEW_PAD_CTRL(MX6_PAD_EIM_D18__ECSPI1_MOSI, SPI_PAD_CTRL),
-};
-
-#define TQMA6_SF_CS_GPIO IMX_GPIO_NR(3, 19)
-
-static unsigned const tqma6_ecspi1_cs[] = {
-	TQMA6_SF_CS_GPIO,
-};
-
-__weak void tqma6_iomuxc_spi(void)
-{
-	unsigned i;
-
-	for (i = 0; i < ARRAY_SIZE(tqma6_ecspi1_cs); ++i)
-		gpio_direction_output(tqma6_ecspi1_cs[i], 1);
-	imx_iomux_v3_setup_multiple_pads(tqma6_ecspi1_pads,
-					 ARRAY_SIZE(tqma6_ecspi1_pads));
-}
-
-#if defined(CONFIG_SF_DEFAULT_BUS) && defined(CONFIG_SF_DEFAULT_CS)
-int board_spi_cs_gpio(unsigned bus, unsigned cs)
-{
-	return ((bus == CONFIG_SF_DEFAULT_BUS) &&
-		(cs == CONFIG_SF_DEFAULT_CS)) ? TQMA6_SF_CS_GPIO : -1;
-}
-#endif
-#endif
 
 int board_early_init_f(void)
 {
-- 
2.34.1

