Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E706CC55173
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 16:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B162D80E2F;
	Sat,  1 Aug 2026 16:41:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S3ulCFl9oGJo; Sat,  1 Aug 2026 16:41:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5388380E0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785602491;
	bh=lncuMr5GMDabyhZT9ERwQCJzoWwJCvA/T/U+SDtAeWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HZCi3uo57xZ55B+TT2eq4JTu+6KHUxPJ1zMJOeEPpQ4PnlzgiFn1HfOcLk7LNU+2i
	 w31fPmPthymxrdvaVQ4pD2C2ykh4RwpzW/LjsOQB6MFui1QCTBz6HzoZtiyLzaEIB8
	 TEqE/obFX9sNYDhuVs2fKFlA9zZdLnEDtz9YMHwVbvemyfISsupXzc0UP3JAalfvCM
	 GBUOaplI15NlZvQCSYrB4RQfRXGFkJ4WGBiUs/vU+YS+wJTUTq5gNJJEGQ3RWLGttw
	 M1ppxGy6Wrj84dPWY2nuFCj2p/OdfnnWDuvkzmG10xn03UhxeAXq8f2TYfPX+jdbXh
	 aw+s0odaVRuCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5388380E0C;
	Sat,  1 Aug 2026 16:41:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 240483B6
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A02C40025
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Tif3n_c6QOx for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 16:41:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BDC8740015
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BDC8740015
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BDC8740015
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:28 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso2383972b3a.0
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 09:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785602488; x=1786207288;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lncuMr5GMDabyhZT9ERwQCJzoWwJCvA/T/U+SDtAeWI=;
 b=Kgiv0X+WLygOfqaf8cQlDCcvUwKUI0JRLpD0W9o3My3HPDn2DJbo0w09Cu+vy7COXO
 b1ggn5wC/hf8HyD7Zuqic5mrQjJU017Hq7x07XrMOaI22QvGzX7nTSA2optgYySv3oFb
 LxKK3hvAeFQY1CRoNCVu+/5z8Jzyk2DAFcAoOLwm7u2ugd8dTmT0Z9P1AsxvKYxI5Urp
 V8/zlX5cxXiWVh5PZPvm+lCF5Pas9lnb8H9FKuIxnlIx7SJLwoRkDlVCrp2Cysniliou
 dfqK9AnP/THOYjVT4O5NbTimH3VMfGXXniiyGLv/uukpYSw7b5cnG6K1045lU9H0n92H
 gGqA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsymlJl+3sA1J20Tn/uInQ9mBmsKJ8xz7Op8Ndm1pnI+CG8hK9L7yrToEWM43FzhJe07Ems2s=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxifQ4HgezrA9n1l0IOS60sT8ShEJGczY3lDxXpcAGlpTT5/IRP
 RpckyF+91R9Kk3ue6jboSOyXceZTF1D8bi/AImPr7eKmSx15ZKQXNTjG8tU4MRtjbz0=
X-Gm-Gg: AR+sD11CePPBrEIHhufrEddnxPgc+h2HSCCmY971jm5s9RBpF+RL5P986l1KzNyNQw+
 U5GTkfPKHuVze3guS2Gp6NaFGBAnKUXCIwrKKlrAhSevq9Qkwuh/4utSZnUoIQx6U4zzVooIHBq
 T31XnjC28KECzP6dgzwKwtOCBhcVXBNY8yjis5Gghroz0eKumYT4h0Ny4a31j+G0l6qy4Eep6u5
 nmNFburiOxYWIn1IK+T/BXjxITHR/uPTFuJ4sbDP5N1CQjPq6ww+NPXJH4Bg7Akr8+ryxAIiC8Z
 EHKRplI2ECKFH4mSDtFZV7MiI+1SqCaiAhzsfnJUBxaBTrqsP3lgg3HPEJF0796YEq3n608PQIA
 lrQ7fTe2C14lNBACzyVtOrwZfExk1GOVWQyl17NTzo7/BRQ3eeUHKmIgApiVkFROE/Fh+hahp9/
 CgLgRoYjf8Cy2sTdisDiFUudWGtoBeAuv6GtrOxOZ4jl/ckinoa1h+E16O0QMREWB4Y80WVzx92
 6Rxsf/+aWSmWjgDzzB4Ug7ECwYUVo4homagzPgGLuO/CQZiKa65GVqPZdL9nGM8J8fRwMEl0HgB
 yGspT8O9PVtZzm2M8yYOpRHkiw==
X-Received: by 2002:a05:6300:189:b0:3c8:ead5:bf58 with SMTP id
 adf61e73a8af0-3c92a889565mr4124009637.51.1785602487966; 
 Sat, 01 Aug 2026 09:41:27 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab132cc4sm14512998c88.2.2026.08.01.09.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 09:41:27 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 02 Aug 2026 00:40:46 +0800
Subject: [PATCH v8 05/11] mmc: k1: add sdhci platform driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-m4-v8-5-e916643205f3@riscstar.com>
References: <20260802-m4-v8-0-e916643205f3@riscstar.com>
In-Reply-To: <20260802-m4-v8-0-e916643205f3@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785602488; x=1786207288;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lncuMr5GMDabyhZT9ERwQCJzoWwJCvA/T/U+SDtAeWI=;
 b=jD1v4p1DY+T8MQJ+2AeOCfJa0NXTzzYXbwCsdSnvhRHpSDwyu5tccNMtmxEi7KOKSJ
 dbUJR28AQ6pRWTxv+NEjEW+4AxvrFIQUoiLF/BQGWOWTd3hxijbx94XOaU6cjEwtkcDl
 6Sh2MSd6Sq8XyckcEOE7C1d8acN7aKBK1XY4kCZTtNkl4fUWqgYiVr/IvP6BcTeFe2Xh
 KRToukBMa6WVUAbdnv7HmzsfXA+TP0YC1eXuxFVntwkg+2D9C/hRHQGwz4YvSTLKFqSi
 juawmAJS5JnMfTSbMMJNX063sBqHiaSSJ2qkPUSGhhrJQFNsv58ZvBESt0D+/lf0dFyn
 ImuQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=jD1v4p1D
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add SDHCI platform driver support for SpacemiT K1 SoC. This driver
implements the necessary platform-specific operations for the SDHCI
controller, enabling MMC/SD card functionality on K1-based platforms.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v6:
- Remove ".data = 0" in spacemit_sdhci_ids[].
v5:
- Remove MMC_CAP_CMD23 as the CMD23 support is now a separate series.
- Use tabs for macro definition alignment.
- Use read_poll_timeout().
- Set pinctrl state based on selected timing mode.
- Add the definition of SDHC_DLL_REG1_HS400_VAL.
- Remove the condition based on quirks.
v4:
- Add bulk release operations on reset and clock.
v3:
- Enable CMD23 in capability.
v2:
- Enable ADMA mode support.
- Use CMD23 for multi-block read/write.
- Move ASR/AIB register into pinctrl driver.
- Correct pinctrl state from "fast" to "uhs".
- Migrate tuning support from the spacemit linux driver.
---
 drivers/mmc/Kconfig          |   7 +
 drivers/mmc/Makefile         |   1 +
 drivers/mmc/spacemit_sdhci.c | 673 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 681 insertions(+)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index f9f7aa5cf97d..b991a5931c0b 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -722,6 +722,13 @@ config MMC_SDHCI_SNPS
 
 	  If unsure, say N.
 
+config MMC_SDHCI_SPACEMIT
+	bool "Spacemit SDHCI controller"
+	depends on MMC_SDHCI
+	help
+	  Support for Secure Digital Host Controller Interface (SDHCI) on
+	  Spacemit K1 SoC.
+
 config MMC_SDHCI_STI
 	bool "SDHCI support for STMicroelectronics SoC"
 	depends on MMC_SDHCI && OF_CONTROL && ARCH_STI
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index a23336d7d8d7..aa05cec23be7 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_MMC_SDHCI_ROCKCHIP)	+= rockchip_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_ADI)		+= adi_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_S5P)		+= s5p_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_SNPS)		+= snps_sdhci.o
+obj-$(CONFIG_MMC_SDHCI_SPACEMIT)	+= spacemit_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_STI)		+= sti_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_TANGIER)		+= tangier_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= tegra_mmc.o
diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
new file mode 100644
index 000000000000..3e1948eb3e57
--- /dev/null
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -0,0 +1,673 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Spacemit K1 Mobile Storage Host Controller
+ *
+ * Copyright (C) 2023-2026 Spacemit Inc.
+ * Copyright (C) 2026 RISCstar Ltd.
+ */
+
+#define LOG_CATEGORY UCLASS_MMC
+
+#include <clk.h>
+#include <dm.h>
+#include <fdtdec.h>
+#include <log.h>
+#include <malloc.h>
+#include <sdhci.h>
+#include <reset-uclass.h>
+#include <mapmem.h>
+#include <dm/pinctrl.h>
+#include <linux/bitfield.h>
+#include <linux/iopoll.h>
+#include <linux/libfdt.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
+
+/* SDH register definitions */
+#define SPACEMIT_SDHC_OP_EXT_REG	0x108
+#define  SDHC_OVRRD_CLK_OEN		BIT(11)
+#define  SDHC_FORCE_CLK_ON		BIT(12)
+
+#define SPACEMIT_SDHC_LEGACY_CTRL_REG	0x10C
+#define  SDHC_GEN_PAD_CLK_ON		BIT(6)
+
+#define SPACEMIT_SDHC_MMC_CTRL_REG	0x114
+#define  SDHC_MISC_INT_EN		BIT(1)
+#define  SDHC_MISC_INT			BIT(2)
+#define  SDHC_ENHANCE_STROBE_EN		BIT(8)
+#define  SDHC_MMC_HS400			BIT(9)
+#define  SDHC_MMC_HS200			BIT(10)
+#define  SDHC_MMC_CARD_MODE		BIT(12)
+
+#define SPACEMIT_SDHC_TX_CFG_REG	0x11C
+#define  SDHC_TX_INT_CLK_SEL		BIT(30)
+#define  SDHC_TX_MUX_SEL		BIT(31)
+
+#define SPACEMIT_SDHC_PHY_CTRL_REG	0x160
+#define  SDHC_PHY_FUNC_EN		BIT(0)
+#define  SDHC_PHY_PLL_LOCK		BIT(1)
+#define  SDHC_HOST_LEGACY_MODE		BIT(31)
+
+#define SPACEMIT_SDHC_PHY_FUNC_REG	0x164
+#define  SDHC_PHY_TEST_EN		BIT(7)
+#define  SDHC_HS200_USE_RFIFO		BIT(15)
+
+#define SPACEMIT_SDHC_PHY_DLLCFG	0x168
+#define  SDHC_DLL_PREDLY_NUM		GENMASK(3, 2)
+#define  SDHC_DLL_FULLDLY_RANGE		GENMASK(5, 4)
+#define  SDHC_DLL_VREG_CTRL		GENMASK(7, 6)
+#define  SDHC_DLL_ENABLE		BIT(31)
+
+#define SPACEMIT_SDHC_PHY_DLLCFG1	0x16C
+#define  SDHC_DLL_REG1_CTRL		GENMASK(7, 0)
+#define  SDHC_DLL_REG2_CTRL		GENMASK(15, 8)
+#define  SDHC_DLL_REG3_CTRL		GENMASK(23, 16)
+#define  SDHC_DLL_REG4_CTRL		GENMASK(31, 24)
+#define  SDHC_DLL_REG1_HS400_VAL	0x92
+
+#define SPACEMIT_SDHC_PHY_DLLSTS	0x170
+#define  SDHC_DLL_LOCK_STATE		BIT(0)
+
+#define SPACEMIT_SDHC_PHY_PADCFG_REG	0x178
+#define  SDHC_PHY_DRIVE_SEL		GENMASK(2, 0)
+#define  SDHC_RX_BIAS_CTRL		BIT(5)
+
+#define SPACEMIT_SDHC_RX_CFG_REG	0x118
+#define  SDHC_RX_SDCLK_SEL0_MASK	GENMASK(1, 0)
+#define  SDHC_RX_SDCLK_SEL1_MASK	GENMASK(3, 2)
+#define  SDHC_RX_SDCLK_SEL1		FIELD_PREP(SDHC_RX_SDCLK_SEL1_MASK, 1)
+
+#define SPACEMIT_SDHC_DLINE_CTRL_REG	0x130
+#define  SDHC_DLINE_PU			BIT(0)
+#define  SDHC_RX_DLINE_CODE_MASK	GENMASK(23, 16)
+#define  SDHC_TX_DLINE_CODE_MASK	GENMASK(31, 24)
+
+#define SPACEMIT_SDHC_DLINE_CFG_REG	0x134
+#define  SDHC_RX_DLINE_REG_MASK		GENMASK(7, 0)
+#define  SDHC_RX_DLINE_GAIN		BIT(8)
+#define  SDHC_TX_DLINE_REG_MASK		GENMASK(23, 16)
+
+#define SPACEMIT_RX_DLINE_REG		9
+#define SPACEMIT_RX_TUNE_DELAY_MIN	0x0
+#define SPACEMIT_RX_TUNE_DELAY_MAX	0xFF
+
+#define SPACEMIT_TX_TUNING_DLINE_REG	0x00
+#define SPACEMIT_TX_TUNING_DELAYCODE	127
+
+struct spacemit_sdhci_plat {
+	struct mmc_config cfg;
+	struct mmc mmc;
+	struct reset_ctl_bulk resets;
+	struct clk_bulk clks;
+};
+
+struct spacemit_sdhci_priv {
+	struct sdhci_host host;
+};
+
+/* All helper functions will update clr/set while preserve rest bits */
+static inline void spacemit_sdhci_setbits(struct sdhci_host *host, u32 val,
+					  int reg)
+{
+	sdhci_writel(host, sdhci_readl(host, reg) | val, reg);
+}
+
+static inline void spacemit_sdhci_clrbits(struct sdhci_host *host, u32 val,
+					  int reg)
+{
+	sdhci_writel(host, sdhci_readl(host, reg) & ~val, reg);
+}
+
+static inline void spacemit_sdhci_clrsetbits(struct sdhci_host *host, u32 clr,
+					     u32 set, int reg)
+{
+	u32 val = sdhci_readl(host, reg);
+
+	val = (val & ~clr) | set;
+	sdhci_writel(host, val, reg);
+}
+
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
+static void spacemit_sdhci_set_rx_delay(struct sdhci_host *host, u8 delay)
+{
+	spacemit_sdhci_clrsetbits(host, SDHC_RX_DLINE_CODE_MASK,
+				  FIELD_PREP(SDHC_RX_DLINE_CODE_MASK, delay),
+				  SPACEMIT_SDHC_DLINE_CTRL_REG);
+}
+
+static void spacemit_sdhci_set_tx_delay(struct sdhci_host *host, u8 delay)
+{
+	spacemit_sdhci_clrsetbits(host, SDHC_TX_DLINE_CODE_MASK,
+				  FIELD_PREP(SDHC_TX_DLINE_CODE_MASK, delay),
+				  SPACEMIT_SDHC_DLINE_CTRL_REG);
+}
+
+static void spacemit_sdhci_set_tx_dline_reg(struct sdhci_host *host,
+					    u8 dline_reg)
+{
+	spacemit_sdhci_clrsetbits(host, SDHC_TX_DLINE_REG_MASK,
+				  FIELD_PREP(SDHC_TX_DLINE_REG_MASK, dline_reg),
+				  SPACEMIT_SDHC_DLINE_CFG_REG);
+}
+
+static void spacemit_sdhci_tx_tuning_prepare(struct sdhci_host *host)
+{
+	spacemit_sdhci_setbits(host, SDHC_TX_MUX_SEL, SPACEMIT_SDHC_TX_CFG_REG);
+	spacemit_sdhci_setbits(host, SDHC_DLINE_PU,
+			       SPACEMIT_SDHC_DLINE_CTRL_REG);
+	udelay(5);
+}
+
+static void spacemit_sdhci_prepare_tuning(struct sdhci_host *host)
+{
+	spacemit_sdhci_clrsetbits(host, SDHC_RX_DLINE_REG_MASK,
+				  FIELD_PREP(SDHC_RX_DLINE_REG_MASK, SPACEMIT_RX_DLINE_REG),
+				  SPACEMIT_SDHC_DLINE_CFG_REG);
+
+	spacemit_sdhci_setbits(host, SDHC_DLINE_PU,
+			       SPACEMIT_SDHC_DLINE_CTRL_REG);
+	udelay(5);
+
+	spacemit_sdhci_clrsetbits(host, SDHC_RX_SDCLK_SEL1_MASK,
+				  SDHC_RX_SDCLK_SEL1,
+				  SPACEMIT_SDHC_RX_CFG_REG);
+
+	if (host->mmc->selected_mode == MMC_HS_200)
+		spacemit_sdhci_setbits(host, SDHC_HS200_USE_RFIFO,
+				       SPACEMIT_SDHC_PHY_FUNC_REG);
+}
+#endif /* MMC_SUPPORTS_TUNING */
+
+/*
+ * Reference: PMU_SDH0_CLK_RES_CTRL (0x054), SDH0_CLK_SEL=0x0,
+ * SDH0_CLK_DIV=0x1. The default clock source is 204.8 MHz
+ * (pll1_d6_409p6Mhz / 2).
+ *
+ * During start-up, use a 200 kHz frequency.
+ */
+#define SDHC_MIN_CLOCK (200 * 1000)
+
+static void spacemit_sdhci_phy_init(struct udevice *dev,
+				    struct sdhci_host *host)
+{
+	u32 reg = 0;
+
+	if (dev_read_bool(dev, "no-sd") && dev_read_bool(dev, "no-sdio")) {
+		/* MMC card mode */
+		reg = sdhci_readl(host, SPACEMIT_SDHC_MMC_CTRL_REG);
+		reg |= SDHC_MMC_CARD_MODE;
+		sdhci_writel(host, reg, SPACEMIT_SDHC_MMC_CTRL_REG);
+
+		/* Use PHY functional mode */
+		reg = sdhci_readl(host, SPACEMIT_SDHC_PHY_CTRL_REG);
+		reg |= (SDHC_PHY_FUNC_EN | SDHC_PHY_PLL_LOCK);
+		sdhci_writel(host, reg, SPACEMIT_SDHC_PHY_CTRL_REG);
+
+		reg = sdhci_readl(host, SPACEMIT_SDHC_PHY_PADCFG_REG);
+		reg |= SDHC_RX_BIAS_CTRL;
+		sdhci_writel(host, reg, SPACEMIT_SDHC_PHY_PADCFG_REG);
+	} else {
+		reg = sdhci_readl(host, SPACEMIT_SDHC_TX_CFG_REG);
+		reg |= SDHC_TX_INT_CLK_SEL;
+		sdhci_writel(host, reg, SPACEMIT_SDHC_TX_CFG_REG);
+	}
+
+	reg = sdhci_readl(host, SPACEMIT_SDHC_MMC_CTRL_REG);
+	reg &= ~SDHC_ENHANCE_STROBE_EN;
+	sdhci_writel(host, reg, SPACEMIT_SDHC_MMC_CTRL_REG);
+}
+
+static int spacemit_sdhci_set_vqmmc_voltage(struct mmc *mmc, int voltage)
+{
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
+	int ret;
+
+	if (!mmc->vqmmc_supply)
+		return 0;
+
+	ret = regulator_set_value(mmc->vqmmc_supply, voltage);
+	if (ret)
+		return ret;
+	ret = regulator_set_enable_if_allowed(mmc->vqmmc_supply, true);
+	if (ret)
+		return ret;
+#endif
+	return 0;
+}
+
+static void spacemit_sdhci_set_voltage(struct sdhci_host *host)
+{
+	if (IS_ENABLED(CONFIG_MMC_IO_VOLTAGE)) {
+		struct mmc *mmc = host->mmc;
+		u32 ctrl;
+
+		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		switch (mmc->signal_voltage) {
+		case MMC_SIGNAL_VOLTAGE_330:
+		case MMC_SIGNAL_VOLTAGE_180: {
+			bool to_180 = mmc->signal_voltage ==
+				      MMC_SIGNAL_VOLTAGE_180;
+			bool ok;
+			int voltage_mv = to_180 ? 1800000 : 3300000;
+
+			if (spacemit_sdhci_set_vqmmc_voltage(mmc, voltage_mv))
+				return;
+			if (!IS_SD(mmc))
+				return;
+			if (to_180)
+				ctrl |= SDHCI_CTRL_VDD_180;
+			else
+				ctrl &= ~SDHCI_CTRL_VDD_180;
+			sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+
+			mdelay(5);
+
+			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+			ok = !!(ctrl & SDHCI_CTRL_VDD_180) == to_180;
+			if (ok)
+				return;
+
+			log_err("%d.%dV regulator output not stable\n",
+				voltage_mv / 1000000,
+				(voltage_mv / 100000) % 10);
+			break;
+		}
+		default:
+			/* No signal voltage switch required */
+			return;
+		}
+	}
+}
+
+static void spacemit_sdhci_set_clk_gate(struct sdhci_host *host, int auto_gate)
+{
+	u32 reg;
+
+	reg = sdhci_readl(host, SPACEMIT_SDHC_OP_EXT_REG);
+	if (auto_gate)
+		reg &= ~(SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_ON);
+	else
+		reg |= (SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_ON);
+	sdhci_writel(host, reg, SPACEMIT_SDHC_OP_EXT_REG);
+}
+
+static bool spacemit_sdhci_is_voltage_switch_cmd(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+	u32 cmd;
+
+	if (!IS_SD(mmc))
+		return false;
+
+	cmd = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
+	return cmd == SD_CMD_SWITCH_UHS18V &&
+	       mmc->signal_voltage == MMC_SIGNAL_VOLTAGE_180;
+}
+
+static int spacemit_sdhci_wait_dat0(struct udevice *dev, int state,
+				    int timeout_us)
+{
+	struct mmc *mmc = mmc_get_mmc_dev(dev);
+	struct sdhci_host *host = mmc->priv;
+	u32 tmp;
+	int ret;
+
+	ret = read_poll_timeout(sdhci_readl, tmp,
+				!!(tmp & SDHCI_DATA_0_LVL_MASK) == !!state,
+				0, timeout_us, host, SDHCI_PRESENT_STATE);
+	if (ret)
+		return ret;
+
+	if (spacemit_sdhci_is_voltage_switch_cmd(host))
+		spacemit_sdhci_set_clk_gate(host, 1);
+	return 0;
+}
+
+static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+	u32 reg;
+
+	spacemit_sdhci_set_voltage(host);
+
+	if (spacemit_sdhci_is_voltage_switch_cmd(host))
+		spacemit_sdhci_set_clk_gate(host, 0);
+
+	/*
+	 * Set TX_INT_CLK_SEL to guarantee hold time at default speed,
+	 * HS, SDR12/SDR25/SDR50 modes. See SDHC_TX_CFG_REG (0x11c).
+	 */
+	reg = sdhci_readl(host, SPACEMIT_SDHC_TX_CFG_REG);
+	if (mmc->selected_mode == MMC_LEGACY ||
+	    mmc->selected_mode == MMC_HS ||
+	    mmc->selected_mode == SD_HS ||
+	    mmc->selected_mode == UHS_SDR12 ||
+	    mmc->selected_mode == UHS_SDR25 ||
+	    mmc->selected_mode == UHS_SDR50) {
+		reg |= SDHC_TX_INT_CLK_SEL;
+	} else {
+		reg &= ~SDHC_TX_INT_CLK_SEL;
+	}
+	sdhci_writel(host, reg, SPACEMIT_SDHC_TX_CFG_REG);
+
+	/* Set pinctrl state based on selected timing mode */
+	if (IS_ENABLED(CONFIG_PINCTRL)) {
+		switch (mmc->selected_mode) {
+		case UHS_SDR12:
+		case UHS_SDR25:
+		case UHS_SDR50:
+		case UHS_SDR104:
+			pinctrl_select_state(mmc->dev, "uhs");
+			break;
+		default:
+			pinctrl_select_state(mmc->dev, "default");
+			break;
+		}
+	}
+
+	if (mmc->selected_mode == MMC_HS_200 ||
+	    mmc->selected_mode == MMC_HS_400 ||
+	    mmc->selected_mode == MMC_HS_400_ES) {
+		reg = sdhci_readw(host, SPACEMIT_SDHC_MMC_CTRL_REG);
+		if (mmc->selected_mode == MMC_HS_200)
+			reg |= SDHC_MMC_HS200;
+		else
+			reg |= SDHC_MMC_HS400;
+		sdhci_writew(host, reg, SPACEMIT_SDHC_MMC_CTRL_REG);
+	} else {
+		reg = sdhci_readw(host, SPACEMIT_SDHC_MMC_CTRL_REG);
+		reg &= ~(SDHC_MMC_HS200 | SDHC_MMC_HS400 | SDHC_ENHANCE_STROBE_EN);
+		sdhci_writew(host, reg, SPACEMIT_SDHC_MMC_CTRL_REG);
+	}
+
+	sdhci_set_uhs_timing(host);
+}
+
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
+static int spacemit_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
+{
+	struct sdhci_host *host = mmc->priv;
+	int current_len = 0, current_start = 0;
+	int max_pass_len = 0, max_pass_start = 0;
+	u8 final_delay;
+	int ret = 0;
+	int i;
+
+	/*
+	 * Tuning is required for SDR50/SDR104, HS200/HS400 cards and
+	 * if clock frequency is greater than 100MHz in these modes.
+	 */
+	if (host->clock < 100 * 1000 * 1000 ||
+	    !(mmc->selected_mode == MMC_HS_200 ||
+	      mmc->selected_mode == UHS_SDR50 ||
+	      mmc->selected_mode == UHS_SDR104))
+		return 0;
+
+	if (IS_SD(host->mmc)) {
+		spacemit_sdhci_set_tx_dline_reg(host, SPACEMIT_TX_TUNING_DLINE_REG);
+		spacemit_sdhci_set_tx_delay(host, SPACEMIT_TX_TUNING_DELAYCODE);
+		spacemit_sdhci_tx_tuning_prepare(host);
+
+		log_debug("TX tuning: dline_reg=%d, delaycode=%d\n",
+			  SPACEMIT_TX_TUNING_DLINE_REG, SPACEMIT_TX_TUNING_DELAYCODE);
+	}
+
+	spacemit_sdhci_prepare_tuning(host);
+
+	for (i = SPACEMIT_RX_TUNE_DELAY_MIN; i <= SPACEMIT_RX_TUNE_DELAY_MAX; i++) {
+		spacemit_sdhci_set_rx_delay(host, i);
+		ret = mmc_send_tuning(host->mmc, opcode);
+
+		log_debug("RX delay %d: %s\n",
+			  i, ret == 0 ? "pass" : "fail");
+
+		if (ret == 0) {
+			/* Test passed - extend current window */
+			if (current_len == 0)
+				current_start = i;
+			current_len++;
+		} else {
+			/* Test failed - check if current window is best so far */
+			if (current_len > max_pass_len) {
+				max_pass_len = current_len;
+				max_pass_start = current_start;
+			}
+			current_len = 0;
+		}
+	}
+
+	if (current_len > max_pass_len) {
+		max_pass_len = current_len;
+		max_pass_start = current_start;
+	}
+
+	if (max_pass_len < 3) {
+		log_err("Tuning failed: no stable window found\n");
+		return -EIO;
+	}
+
+	final_delay = max_pass_start + max_pass_len / 2;
+	spacemit_sdhci_set_rx_delay(host, final_delay);
+	ret = mmc_send_tuning(host->mmc, opcode);
+	if (ret) {
+		u8 retry_delays[] = {
+			max_pass_start + max_pass_len / 4,
+			max_pass_start + (3 * max_pass_len) / 4,
+			max_pass_start,
+			max_pass_start + max_pass_len - 1
+		};
+		int retry_count = ARRAY_SIZE(retry_delays);
+
+		log_warning("Primary delay %d failed, trying alternatives\n",
+			    final_delay);
+
+		for (i = 0; i < retry_count; i++) {
+			if (retry_delays[i] >= SPACEMIT_RX_TUNE_DELAY_MIN &&
+			    retry_delays[i] <= SPACEMIT_RX_TUNE_DELAY_MAX) {
+				spacemit_sdhci_set_rx_delay(host, retry_delays[i]);
+				ret = mmc_send_tuning(host->mmc, opcode);
+				if (!ret) {
+					final_delay = retry_delays[i];
+					log_info("Retry successful with delay %d\n",
+						 final_delay);
+					break;
+				}
+			}
+		}
+
+		if (ret) {
+			log_err("All retry attempts failed\n");
+			return -EIO;
+		}
+	}
+
+	log_debug("Tuning successful: window %d-%d, using delay %d\n",
+		  max_pass_start, max_pass_start + max_pass_len - 1, final_delay);
+
+	return 0;
+}
+#endif /* MMC_SUPPORTS_TUNING */
+
+#if CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
+static int spacemit_sdhci_phy_dll_init(struct sdhci_host *host)
+{
+	u32 reg, val;
+	int ret;
+
+	/* Configure DLL predly, fulldly, and vreg */
+	spacemit_sdhci_clrsetbits(host, SDHC_DLL_PREDLY_NUM |
+				  SDHC_DLL_FULLDLY_RANGE |
+				  SDHC_DLL_VREG_CTRL,
+				  FIELD_PREP(SDHC_DLL_PREDLY_NUM, 1) |
+				  FIELD_PREP(SDHC_DLL_FULLDLY_RANGE, 1) |
+				  FIELD_PREP(SDHC_DLL_VREG_CTRL, 1),
+				  SPACEMIT_SDHC_PHY_DLLCFG);
+
+	reg = sdhci_readl(host, SPACEMIT_SDHC_PHY_DLLCFG1);
+	reg |= FIELD_PREP(SDHC_DLL_REG1_CTRL, SDHC_DLL_REG1_HS400_VAL);
+	sdhci_writel(host, reg, SPACEMIT_SDHC_PHY_DLLCFG1);
+
+	/* Enable DLL */
+	reg = sdhci_readl(host, SPACEMIT_SDHC_PHY_DLLCFG);
+	reg |= SDHC_DLL_ENABLE;
+	sdhci_writel(host, reg, SPACEMIT_SDHC_PHY_DLLCFG);
+
+	/* Wait for DLL lock */
+	ret = read_poll_timeout(sdhci_readl, val, val & SDHC_DLL_LOCK_STATE,
+				10, 1000, host, SPACEMIT_SDHC_PHY_DLLSTS);
+	if (ret) {
+		log_err("%s: phy dll lock timeout\n", host->name);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int spacemit_sdhci_hs400_enhanced_strobe(struct sdhci_host *host)
+{
+	u32 reg;
+
+	reg = sdhci_readl(host, SPACEMIT_SDHC_MMC_CTRL_REG);
+	reg |= SDHC_ENHANCE_STROBE_EN;
+	sdhci_writel(host, reg, SPACEMIT_SDHC_MMC_CTRL_REG);
+
+	return spacemit_sdhci_phy_dll_init(host);
+}
+#endif
+
+const struct sdhci_ops spacemit_sdhci_ops = {
+	.set_control_reg		= spacemit_sdhci_set_control_reg,
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
+	.platform_execute_tuning	= spacemit_sdhci_execute_tuning,
+#endif
+#if CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
+	.set_enhanced_strobe		= spacemit_sdhci_hs400_enhanced_strobe,
+#endif
+};
+
+static struct dm_mmc_ops spacemit_mmc_ops;
+
+static int spacemit_sdhci_probe(struct udevice *dev)
+{
+	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
+	struct spacemit_sdhci_priv *priv = dev_get_priv(dev);
+	struct spacemit_sdhci_plat *plat = dev_get_plat(dev);
+	struct sdhci_host *host = &priv->host;
+	struct clk clk;
+	int ret = 0;
+
+	host->mmc = &plat->mmc;
+	host->mmc->priv = host;
+	host->mmc->dev = dev;
+	upriv->mmc = host->mmc;
+
+	spacemit_mmc_ops = sdhci_ops;
+	spacemit_mmc_ops.wait_dat0 = spacemit_sdhci_wait_dat0;
+
+	ret = clk_get_bulk(dev, &plat->clks);
+	if (ret) {
+		log_err("Can't get clk: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable_bulk(&plat->clks);
+	if (ret) {
+		log_err("Failed to enable clk: %d\n", ret);
+		goto err_clk;
+	}
+
+	ret = reset_get_bulk(dev, &plat->resets);
+	if (ret) {
+		log_err("Can't get reset: %d\n", ret);
+		goto err_clk;
+	}
+
+	ret = reset_deassert_bulk(&plat->resets);
+	if (ret) {
+		log_err("Failed to reset: %d\n", ret);
+		goto err_reset;
+	}
+
+	ret = clk_get_by_index(dev, 1, &clk);
+	if (ret) {
+		log_err("Can't get io clk: %d\n", ret);
+		goto err_reset;
+	}
+
+	ret = clk_set_rate(&clk, plat->cfg.f_max);
+	if (ret) {
+		log_err("Failed to set io clk: %d\n", ret);
+		goto err_reset;
+	}
+
+	/* Set quirks */
+	host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD |
+		       SDHCI_QUIRK_32BIT_DMA_ADDR;
+	host->host_caps = MMC_MODE_HS | MMC_MODE_HS_52MHz;
+	host->max_clk = plat->cfg.f_max;
+
+	plat->cfg.f_min = SDHC_MIN_CLOCK;
+	host->ops = &spacemit_sdhci_ops;
+
+	ret = sdhci_setup_cfg(&plat->cfg, host, plat->cfg.f_max,
+			      SDHC_MIN_CLOCK);
+	if (ret)
+		goto err_reset;
+
+	ret = sdhci_probe(dev);
+	if (ret)
+		goto err_reset;
+
+	spacemit_sdhci_phy_init(dev, host);
+	return 0;
+
+err_reset:
+	reset_release_bulk(&plat->resets);
+err_clk:
+	clk_release_bulk(&plat->clks);
+	return ret;
+}
+
+static int spacemit_sdhci_of_to_plat(struct udevice *dev)
+{
+	struct spacemit_sdhci_plat *plat = dev_get_plat(dev);
+	struct spacemit_sdhci_priv *priv = dev_get_priv(dev);
+	struct sdhci_host *host = &priv->host;
+	int ret = 0;
+
+	host->name = dev->name;
+	host->ioaddr = (void *)dev_read_addr(dev);
+
+	ret = mmc_of_parse(dev, &plat->cfg);
+
+	return ret;
+}
+
+static int spacemit_sdhci_bind(struct udevice *dev)
+{
+	struct spacemit_sdhci_plat *drv_data;
+	struct spacemit_sdhci_plat *plat = dev_get_plat(dev);
+
+	drv_data = (struct spacemit_sdhci_plat *)dev_get_driver_data(dev);
+	if (drv_data)
+		memcpy(plat, drv_data, sizeof(struct spacemit_sdhci_plat));
+	return sdhci_bind(dev, &plat->mmc, &plat->cfg);
+}
+
+static const struct udevice_id spacemit_sdhci_ids[] = {
+	{ .compatible = "spacemit,k1-sdhci" },
+	{ }
+};
+
+U_BOOT_DRIVER(spacemit_sdhci_drv) = {
+	.name		= "spacemit_sdhci",
+	.id		= UCLASS_MMC,
+	.of_match	= spacemit_sdhci_ids,
+	.of_to_plat	= spacemit_sdhci_of_to_plat,
+	.ops		= &spacemit_mmc_ops,
+	.bind		= spacemit_sdhci_bind,
+	.probe		= spacemit_sdhci_probe,
+	.priv_auto	= sizeof(struct spacemit_sdhci_priv),
+	.plat_auto	= sizeof(struct spacemit_sdhci_plat),
+};

-- 
2.51.0

