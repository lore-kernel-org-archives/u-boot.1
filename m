Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8BBC27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C33D588570;
	Mon, 10 Jun 2024 03:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xOje9SfQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA6CC88568; Mon, 10 Jun 2024 03:12:51 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E1458852E
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-250671a1bc7so1922143fac.3
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981968; x=1718586768; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wD3p8epdQ9qwZEXccRxToczcETxHdDyW+jAApzc0NXQ=;
 b=xOje9SfQWbuSFhUPGn4lJuOUAhI+qG9lQiVp8oyQNMo+yU37/0Aj2Y2OQnRd8k92q8
 5AE96JKWmpKLj7AoOHhOrG5UydxUJcyXgmasmVEuHNWrD0bIi8qdBKPrcgLohTwGp3E+
 hBqY95DSuiDKVSWP/C3Q5tp9q/5IhHEOeJzCO3dTcpNLnoqfpxJehv7WjiMPNiqCv6ma
 4KksCT+XvgEHJRBkmZQU86KYA/3Qc3cLeoNC7unEzsCIBf8+iyg5W1RiP2c/GMxljV24
 D4SrW1viCeQaWeMaX7E5qR8X46UlbuqvEG5XgxwYy6yENI7afvinA8s5ND86O2duJBNz
 QRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981968; x=1718586768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wD3p8epdQ9qwZEXccRxToczcETxHdDyW+jAApzc0NXQ=;
 b=sAcnf0gInKqLPFdrJsO9PPU4a+9G7p5I3YIEHlNq9zm+69x2acjN16YSPojlwn73cL
 StZf4RTErDfYQWBXiZhp4QNhhCV9HAbsvzJvyTKWMSuLJQFaYnCvqWsZGNok8LjY2O0M
 152IgHGc1h2AcsE2N/DLnn2xcDBxeIxNeYp9UPGCyxR/GONQ7Hb2F/SyEv/j60h4HPii
 32UT4FmVxQGk9e6K/ZdvW+SKAMJWSddcR0U8oiwp8bg+b43SgsZmp6HQ++rI0AhMFJ1f
 5mI66mTZ4YgeVnRo4RULoDrD+/+yf8Aw4lznm4MnaaV9OzkXJ3fJifZRm4P+6ahFw/Q1
 nPyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXilyfOv/iu6e/F0Moapq9FImiAT0X64VyYI6u9mZkcVDWD4o4LTRRxUsv5HgQEodk3TmJ2cHsHMCbVjq45giF3witLg==
X-Gm-Message-State: AOJu0Yz02VL771avKrFRI6ppcAqzKAm1tr1nV0Dr+QhgkHAC/0gND8MN
 yv56mA9lgWuIaglz6WSVg2oDwJN9VEFHLfpOul7IL78PisGOmNXRO9oXPIG3YWc=
X-Google-Smtp-Source: AGHT+IGACc10V/hGRPQ7B4Rd9EPG9lCleB7WnUL0y3sZ7xz9R5JQ1iFaSKvLoLH0f1hXGpZYyWbw2g==
X-Received: by 2002:a05:6870:c1d0:b0:254:a3b9:9753 with SMTP id
 586e51a60fabf-254a3b9986bmr4343712fac.52.1717981967898; 
 Sun, 09 Jun 2024 18:12:47 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2547e79b20esm1288935fac.41.2024.06.09.18.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:47 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 29/40] mmc: exynos_dw_mmc: Move quirks from struct
 dwmci_host to chip data
Date: Sun,  9 Jun 2024 20:12:15 -0500
Message-Id: <20240610011226.4050-30-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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

host->quirks field is only used internally in exynos_dw_mmc.c driver.
To avoid cluttering the scope of struct dwmci_host, move quirks field
into Exynos driver's chip data, where it can be statically defined.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Replaced CONFIG_IS_ENABLED() with #ifdef

 drivers/mmc/exynos_dw_mmc.c | 13 ++++++++-----
 include/dwmmc.h             |  5 -----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 5ecee403c416..69ba19e9edca 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -26,6 +26,9 @@
 
 #define EXYNOS4412_FIXED_CIU_CLK_DIV	4
 
+/* Quirks */
+#define DWMCI_QUIRK_DISABLE_SMU		BIT(0)
+
 #ifdef CONFIG_DM_MMC
 #include <dm.h>
 DECLARE_GLOBAL_DATA_PTR;
@@ -40,6 +43,7 @@ struct exynos_mmc_plat {
 struct exynos_dwmmc_variant {
 	u32 clksel;		/* CLKSEL register offset */
 	u8 div;			/* (optional) fixed clock divider value: 0..7 */
+	u32 quirks;		/* quirk flags - see DWMCI_QUIRK_... */
 };
 
 /* Exynos implmentation specific drver private data */
@@ -174,7 +178,7 @@ static void exynos_dwmci_board_init(struct dwmci_host *host)
 {
 	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
 
-	if (host->quirks & DWMCI_QUIRK_DISABLE_SMU) {
+	if (priv->chip->quirks & DWMCI_QUIRK_DISABLE_SMU) {
 		dwmci_writel(host, EMMCP_MPSBEGIN0, 0);
 		dwmci_writel(host, EMMCP_SEND0, 0);
 		dwmci_writel(host, EMMCP_CTRL0,
@@ -206,11 +210,7 @@ static int exynos_dwmci_core_init(struct dwmci_host *host)
 	}
 
 	host->name = "EXYNOS DWMMC";
-#ifdef CONFIG_EXYNOS5420
-	host->quirks = DWMCI_QUIRK_DISABLE_SMU;
-#endif
 	host->board_init = exynos_dwmci_board_init;
-
 	host->caps = MMC_MODE_DDR_52MHz;
 	host->clksel = exynos_dwmci_clksel;
 	host->get_mmc_clk = exynos_dwmci_get_clk;
@@ -353,6 +353,9 @@ static const struct exynos_dwmmc_variant exynos4_drv_data = {
 
 static const struct exynos_dwmmc_variant exynos5_drv_data = {
 	.clksel	= DWMCI_CLKSEL,
+#ifdef CONFIG_EXYNOS5420
+	.quirks	= DWMCI_QUIRK_DISABLE_SMU,
+#endif
 };
 
 static const struct udevice_id exynos_dwmmc_ids[] = {
diff --git a/include/dwmmc.h b/include/dwmmc.h
index 8c2500da9efe..6edb9e1a59c5 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -149,9 +149,6 @@
 #define DWMCI_IDINTEN_TI	BIT(0)
 #define DWMCI_IDINTEN_MASK	(DWMCI_IDINTEN_TI | DWMCI_IDINTEN_RI)
 
-/* Quirks */
-#define DWMCI_QUIRK_DISABLE_SMU	BIT(0)
-
 /**
  * struct dwmci_idmac_regs - Offsets of IDMAC registers
  *
@@ -180,7 +177,6 @@ struct dwmci_idmac_regs {
  *
  * @name:	Device name
  * @ioaddr:	Base I/O address of controller
- * @quirks:	Quick flags - see DWMCI_QUIRK_...
  * @caps:	Capabilities - see MMC_MODE_...
  * @clock:	Current clock frequency (after internal divider), Hz
  * @bus_hz:	Bus speed in Hz, if @get_mmc_clk() is NULL
@@ -200,7 +196,6 @@ struct dwmci_idmac_regs {
 struct dwmci_host {
 	const char *name;
 	void *ioaddr;
-	unsigned int quirks;
 	unsigned int caps;
 	unsigned int clock;
 	unsigned int bus_hz;
-- 
2.39.2

