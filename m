Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CDFC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:50:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 638B28871A;
	Thu, 25 Jul 2024 22:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D27TE+3e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 817A788708; Thu, 25 Jul 2024 22:45:45 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AC02885E4
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7092fb4317dso293278a34.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940342; x=1722545142; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+iLLvBrcSO5LDuLUnqkfH2NnCX+IOR7efyeAaSsh4M0=;
 b=D27TE+3eQBSlU8alX97A2gha9LVVZfx/5oZuFViCB4kmgtZOBsjowA6W1N+WRXr7ug
 7jtzssRuLcSLy7FR7lgmNBVcCFrWnNo5et2DHdGwbtgPRxcmYQTgTQ/rczv3lnFjGWx4
 50VyfTW/ZU0xdrq/09FI5cszYJzs7XEqMlVo8uKSrg69sOgTVTaTKkPi52fGTzWIRkxq
 yRBAmItEtnu1zximFyZrQwX0gmop5ZI8UPFJcKeXijsDMAFQTiat5rvpZonjLaXwhsXT
 WWrih29L2iEm8pcQOoeKKR5YAzhARcvBp74+YVJyidPFoQ+BozLmOTHqjuCj5tWYDChA
 DDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940342; x=1722545142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+iLLvBrcSO5LDuLUnqkfH2NnCX+IOR7efyeAaSsh4M0=;
 b=rM4Ydd1juC9N5SlXGuhwHAfnoS1UyHuVcj+60F4ChGLHd7/Y2Tu9/QTNP81oiijv/U
 mT1FB8jtj1FrpSeVhDCWP2ZAZmKJwo+3N/9KKGtTrMvmug/SBV9WGdKDZ6EbLo9tOC5X
 7C2Gv7ktn7Z8G/b94bdNTtRZbCtYsVSoIJzwqIgEqo/sTlbiXcUthaYKFWA/A61t7wsa
 aTqz/9uxaD3aeorkTv1nUrNykE8JnHYlvlsmgD7MFiZLxC9s95nACbfPcQIibOOqDvL1
 zf81zU8IpKAvNIsvaIJhV2v6VB+wFoG8xR84hV2ZJBqhJGGaBEV26SxFIPh4RTyPYWgD
 6y9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsxizjxnkoqjfDbAaiKYY5qv/A8AtKjHyKUFbRwlS1uGU1NGSLAT/u8E4XLG0bcHJAHlrlVV3jXzLUf4fxIcqFbbQ4ug==
X-Gm-Message-State: AOJu0YzISJQzTTI+3teE1C5r4ccBLDfJQUTXbV3GE4rTI+h1kmeoM0cc
 Ydskj39k/NzsCYLjUVLtZfvKE7xuIsSX0BkXK1VzezK3NCGg2284dHcseQn0MrQ=
X-Google-Smtp-Source: AGHT+IEbO7SgeBymy+fPp6K/OoPI/rIbxnKabObRwz6weLxdlt8Yv/lZkMmzSRgso/5rkn57uunNHg==
X-Received: by 2002:a05:6830:6014:b0:703:5d37:7387 with SMTP id
 46e09a7af769-709324ea60bmr4125338a34.30.1721940342073; 
 Thu, 25 Jul 2024 13:45:42 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70930778451sm452717a34.61.2024.07.25.13.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:41 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 28/38] mmc: exynos_dw_mmc: Move quirks from struct
 dwmci_host to chip data
Date: Thu, 25 Jul 2024 15:45:10 -0500
Message-Id: <20240725204520.18134-29-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240725204520.18134-1-semen.protsenko@linaro.org>
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
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
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - Replaced CONFIG_IS_ENABLED() with #ifdef

 drivers/mmc/exynos_dw_mmc.c | 13 ++++++++-----
 include/dwmmc.h             |  5 -----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index bed8bd8a0fcf..b9d655c0d5c8 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -25,6 +25,9 @@
 
 #define EXYNOS4412_FIXED_CIU_CLK_DIV	4
 
+/* Quirks */
+#define DWMCI_QUIRK_DISABLE_SMU		BIT(0)
+
 #ifdef CONFIG_DM_MMC
 #include <dm.h>
 DECLARE_GLOBAL_DATA_PTR;
@@ -39,6 +42,7 @@ struct exynos_mmc_plat {
 struct exynos_dwmmc_variant {
 	u32 clksel;		/* CLKSEL register offset */
 	u8 div;			/* (optional) fixed clock divider value: 0..7 */
+	u32 quirks;		/* quirk flags - see DWMCI_QUIRK_... */
 };
 
 /* Exynos implmentation specific drver private data */
@@ -173,7 +177,7 @@ static void exynos_dwmci_board_init(struct dwmci_host *host)
 {
 	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
 
-	if (host->quirks & DWMCI_QUIRK_DISABLE_SMU) {
+	if (priv->chip->quirks & DWMCI_QUIRK_DISABLE_SMU) {
 		dwmci_writel(host, EMMCP_MPSBEGIN0, 0);
 		dwmci_writel(host, EMMCP_SEND0, 0);
 		dwmci_writel(host, EMMCP_CTRL0,
@@ -205,11 +209,7 @@ static int exynos_dwmci_core_init(struct dwmci_host *host)
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
@@ -352,6 +352,9 @@ static const struct exynos_dwmmc_variant exynos4_drv_data = {
 
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

