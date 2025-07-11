Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C97EC83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 558268304F;
	Fri, 11 Jul 2025 17:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mt6U316+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A72583093; Fri, 11 Jul 2025 17:20:07 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B49983092
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2ebb468cbb4so1889911fac.2
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752247203; x=1752852003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HR1XyO3qgyF9CMXCcSYtMCGuK2/jvzHYdE2jjwLHXbY=;
 b=mt6U316+0j4ylfZveW2tpU+fOKdZ5x2WHeA7m2s6RTESzoMhnGZgbtH/rC9nK8Oa3U
 CD5fhoQFisrog71anRxQYCO+UmlVyDfc8v43Gc3xdKKlPcCKm/v8UAgd/swFCZhAp83q
 ihA6D2kcE38qmOg1dSMpy1FPkwcwR2rykJgEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752247203; x=1752852003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HR1XyO3qgyF9CMXCcSYtMCGuK2/jvzHYdE2jjwLHXbY=;
 b=kSpa8s/PJMV+fFKdnpsIpBXlIvy5mwuKYhK5fGfKq3z3FL1aIyizrpRs3FbGtNHVZY
 o6wljDz9h8ols0qtQN2WiU+flaMZTDXHf92QfZnCoahgCQJer0+lkOl0B2/meM9C/r+v
 9XWIkTttqGqpzUmR3dupmWGi0j9fAS9X1jsFxyp/tBP4BqR9mGK6y37fXvv9DaAuAEFN
 +PY49Ylvm4pHMDVVlYn0FsDErr3D11Wz1DCUMf/e+EsjNXubGR+Z6nAdk/ByNdYdtkIY
 rY30FZQiex4A3nhc7VTH9HFkfL7eCquS789mn7gfjs6tAxDdGKDfFoecVewMLrZQOXLV
 LQqQ==
X-Gm-Message-State: AOJu0YzEBhJq/lvKPSoPb81V8mKasTN9sZBQe5oCZ1lAOUTsDPztQlJI
 yw2rd57uK9DAJ6+l4CBrZBJwWwHn3mYqgqILtSmH9vpyb/R9I24wwq9UG6o7w/zhI3yCM59pH6e
 dC8G+9DU=
X-Gm-Gg: ASbGncv4Idl/NqMXByDyR+iZfVfEh+ZCi+97AyhQlg8oDpABVutsfK6VA9Vg46uRWQg
 DAtpJJIO/+kypye1tBUy9YyKPtrhohM+3/m0BFAiqzzyrxjMHP0Vw7hFfqfw8XzErDgxwtfcOBZ
 bqe9mr6AtI1+9mCbXtMBl9nv0RsWuyIe3+DJIoUWly+k9ZOA8UsSDRz5Fv5rwKm1P+lvJDhZMmR
 eY6kxf7kJOpTGDRJThZXVIziYklvQco4Of10hjMB68Pu5HTHkMwFM3AOiMGxbCOe2zTRc2y+JK8
 KlEWG3xZM4xwtPbI7JiXHD0/8gPlke7TJ9bRg+ZaJZGZXCzepnqbaTfypBTElf/MBZuPOQvQGKm
 f/PNi8I2x8PZ4+iRQ1inIQFgGa1s9wSxtquUYpwsvcmIu0G7BpkzkDdxOtms=
X-Google-Smtp-Source: AGHT+IHtJ2iHIJbQ7kvRHme9ZCU1Eo+h/Asu6mx/SOCV9jTY+xvlJa2DFl24yYqXZdgOTCnDsW/TUQ==
X-Received: by 2002:a05:6870:a914:b0:2e9:e9b9:fd7c with SMTP id
 586e51a60fabf-2ff2715d5dcmr2873710fac.26.1752247203221; 
 Fri, 11 Jul 2025 08:20:03 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff11684d21sm751945fac.30.2025.07.11.08.20.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:20:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] mmc: Remove unused kona_sdhci driver
Date: Fri, 11 Jul 2025 09:20:01 -0600
Message-ID: <20250711152001.2225395-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As no platforms use this driver anymore, remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/mmc/Kconfig      |  10 ---
 drivers/mmc/Makefile     |   1 -
 drivers/mmc/kona_sdhci.c | 132 ---------------------------------------
 3 files changed, 143 deletions(-)
 delete mode 100644 drivers/mmc/kona_sdhci.c

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 845b653731f9..123bd3fa3148 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -651,16 +651,6 @@ config MMC_SDHCI_F_SDH30
 	  If you have a controller with this interface, say Y here.
 	  If unsure, say N.
 
-config MMC_SDHCI_KONA
-	bool "SDHCI support on Broadcom KONA platform"
-	depends on MMC_SDHCI
-	help
-	  This selects the Broadcom Kona Secure Digital Host Controller
-	  Interface(SDHCI) support.
-	  This is used in Broadcom mobile SoCs.
-
-	  If you have a controller with this interface, say Y here.
-
 config MMC_SDHCI_MSM
 	bool "Qualcomm SDHCI controller"
 	depends on MMC_SDHCI
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index 280187c6bab7..a23336d7d8d7 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -63,7 +63,6 @@ obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence6.o
 obj-$(CONFIG_MMC_SDHCI_CV1800B)		+= cv1800b_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_AM654)		+= am654_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_IPROC)		+= iproc_sdhci.o
-obj-$(CONFIG_MMC_SDHCI_KONA)		+= kona_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_MSM)		+= msm_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_MV)		+= mv_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_NPCM)            += npcm_sdhci.o
diff --git a/drivers/mmc/kona_sdhci.c b/drivers/mmc/kona_sdhci.c
deleted file mode 100644
index 83f141226325..000000000000
--- a/drivers/mmc/kona_sdhci.c
+++ /dev/null
@@ -1,132 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2013 Broadcom Corporation.
- */
-
-#include <malloc.h>
-#include <sdhci.h>
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <asm/kona-common/clk.h>
-
-#define SDHCI_CORECTRL_OFFSET		0x00008000
-#define SDHCI_CORECTRL_EN		0x01
-#define SDHCI_CORECTRL_RESET		0x02
-
-#define SDHCI_CORESTAT_OFFSET		0x00008004
-#define SDHCI_CORESTAT_CD_SW		0x01
-
-#define SDHCI_COREIMR_OFFSET		0x00008008
-#define SDHCI_COREIMR_IP		0x01
-
-static int init_kona_mmc_core(struct sdhci_host *host)
-{
-	unsigned int mask;
-	unsigned int timeout;
-
-	if (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & SDHCI_RESET_ALL) {
-		printf("%s: sd host controller reset error\n", __func__);
-		return -EBUSY;
-	}
-
-	/* For kona a hardware reset before anything else. */
-	mask = sdhci_readl(host, SDHCI_CORECTRL_OFFSET) | SDHCI_CORECTRL_RESET;
-	sdhci_writel(host, mask, SDHCI_CORECTRL_OFFSET);
-
-	/* Wait max 100 ms */
-	timeout = 1000;
-	do {
-		if (timeout == 0) {
-			printf("%s: reset timeout error\n", __func__);
-			return -ETIMEDOUT;
-		}
-		timeout--;
-		udelay(100);
-	} while (0 ==
-		 (sdhci_readl(host, SDHCI_CORECTRL_OFFSET) &
-		  SDHCI_CORECTRL_RESET));
-
-	/* Clear the reset bit. */
-	mask = mask & ~SDHCI_CORECTRL_RESET;
-	sdhci_writel(host, mask, SDHCI_CORECTRL_OFFSET);
-
-	/* Enable AHB clock */
-	mask = sdhci_readl(host, SDHCI_CORECTRL_OFFSET);
-	sdhci_writel(host, mask | SDHCI_CORECTRL_EN, SDHCI_CORECTRL_OFFSET);
-
-	/* Enable interrupts */
-	sdhci_writel(host, SDHCI_COREIMR_IP, SDHCI_COREIMR_OFFSET);
-
-	/* Make sure Card is detected in controller */
-	mask = sdhci_readl(host, SDHCI_CORESTAT_OFFSET);
-	sdhci_writel(host, mask | SDHCI_CORESTAT_CD_SW, SDHCI_CORESTAT_OFFSET);
-
-	/* Wait max 100 ms */
-	timeout = 1000;
-	while (!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT)) {
-		if (timeout == 0) {
-			printf("%s: CARD DETECT timeout error\n", __func__);
-			return -ETIMEDOUT;
-		}
-		timeout--;
-		udelay(100);
-	}
-	return 0;
-}
-
-int kona_sdhci_init(int dev_index, u32 min_clk, u32 quirks)
-{
-	int ret = 0;
-	u32 max_clk;
-	void *reg_base;
-	struct sdhci_host *host = NULL;
-
-	host = (struct sdhci_host *)malloc(sizeof(struct sdhci_host));
-	if (!host) {
-		printf("%s: sdhci host malloc fail!\n", __func__);
-		return -ENOMEM;
-	}
-	switch (dev_index) {
-	case 0:
-		reg_base = (void *)CONFIG_SYS_SDIO_BASE0;
-		ret = clk_sdio_enable(reg_base, CONFIG_SYS_SDIO0_MAX_CLK,
-				      &max_clk);
-		break;
-	case 1:
-		reg_base = (void *)CONFIG_SYS_SDIO_BASE1;
-		ret = clk_sdio_enable(reg_base, CONFIG_SYS_SDIO1_MAX_CLK,
-				      &max_clk);
-		break;
-	case 2:
-		reg_base = (void *)CONFIG_SYS_SDIO_BASE2;
-		ret = clk_sdio_enable(reg_base, CONFIG_SYS_SDIO2_MAX_CLK,
-				      &max_clk);
-		break;
-	case 3:
-		reg_base = (void *)CONFIG_SYS_SDIO_BASE3;
-		ret = clk_sdio_enable(reg_base, CONFIG_SYS_SDIO3_MAX_CLK,
-				      &max_clk);
-		break;
-	default:
-		printf("%s: sdio dev index %d not supported\n",
-		       __func__, dev_index);
-		ret = -EINVAL;
-	}
-	if (ret) {
-		free(host);
-		return ret;
-	}
-
-	host->name = "kona-sdhci";
-	host->ioaddr = reg_base;
-	host->quirks = quirks;
-	host->max_clk = max_clk;
-
-	if (init_kona_mmc_core(host)) {
-		free(host);
-		return -EINVAL;
-	}
-
-	add_sdhci(host, 0, min_clk);
-	return ret;
-}
-- 
2.43.0

