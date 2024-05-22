Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D336C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A633885DB;
	Thu, 23 May 2024 01:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TYiCG2g3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DCCE884EF; Thu, 23 May 2024 01:32:09 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 715998850F
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5b295d6b7fbso3198272eaf.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420722; x=1717025522; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yowz9gtF+7MQm8ABe2CZE8QGkTQU0AboL0IOpqT329E=;
 b=TYiCG2g3cPj44aDh9kcQ+wMv12SdgsdADgL76kYWDPcI0Dx+OlVYKkEwKhPIgIrokJ
 LpF0IAaCL5ze/ZBcTM2vt2ky92zQo1LFujquVZFw4d347DNZNsdjlGJd1s5D0INUBABZ
 mUn27O3egUzL2ej7WkYFG/OIa1hxI9EF02tHlVshAuMZPYFF5tHCWgccbOF2d2Ws22Q1
 GADaiTHY1hnAbXHkxjhv0c54pwGt8HoEm7qqfNKBx5P7gkGdOh9MvjdQBrLTIAV84JHM
 HlHFR9AyK7Y2dUighWnL59oyAuIloDVG5RvbynuvgUXbeYyURX5lUL1o+hH/JIRvUlj4
 9jRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420722; x=1717025522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yowz9gtF+7MQm8ABe2CZE8QGkTQU0AboL0IOpqT329E=;
 b=aEQyl94Jdlbppaq7G3r5lCn0kwNvfMWSezFF5MspL9rlUrssAmLH58wrztBNh6Ra4B
 PR/eEVqgCYnGwNcfW5ldvmqI4yf1bBkEVKhWHKEpvNpNclmJqHrUh7lQsixs6ymgmKnG
 5t0ohZO/o6evMqA54EpkY3GDxizePdHvdzc9jOrZb1YUnKk00FvlULqR/qc/h7R1GcZd
 U9V98pdELY5FAVX1U9hCEdxdRuBGyDZ1HN6u2w1/A7TmAcKoQYRQ/6ffC8BAnKZ5foBU
 MI8XI3Sug0nWWelIG6desUtXBY70orS4iOERlZEr59jcBIgsmfa1BTbpjykHYCY3BPHV
 2lFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVR6h0VVj8NaZ4za2u4HxHJGczTYe2AkCEnE1zz0/ozgbkUCYbAd/ux7QxKvAh/FZMevuqill87HgHXDSBnQtKfQrbig==
X-Gm-Message-State: AOJu0YzHF1E7rJYH1GJtKmjGXQ2gfHp7bc8CFiDp6jVegdJIAxRssak7
 GuV/YaH8+xWRTBfukE++1slijHc275vXQiJPLyzE/ugvbvxnwjvoJzmvK+vPu80=
X-Google-Smtp-Source: AGHT+IHgtnwjdQKGAeBiZrww81j2FwltxlhtG9pAvQd67/HK0gwWVOiSDL/IGY7QDHExHP9GVDF2sA==
X-Received: by 2002:a05:6820:d0b:b0:5b7:1979:ec49 with SMTP id
 006d021491bc7-5b71979edf6mr2300025eaf.0.1716420722101; 
 Wed, 22 May 2024 16:32:02 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5b26dd8ea7csm6228102eaf.16.2024.05.22.16.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:32:01 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH 30/42] mmc: exynos_dw_mmc: Move quirks from struct dwmci_host
 to chip data
Date: Wed, 22 May 2024 18:31:23 -0500
Message-Id: <20240522233135.26835-31-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522233135.26835-1-semen.protsenko@linaro.org>
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
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
 drivers/mmc/exynos_dw_mmc.c | 13 ++++++++-----
 include/dwmmc.h             |  5 -----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 8a307c9c123b..91300f67b9fe 100644
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
+#if CONFIG_IS_ENABLED(EXYNOS5420)
+	.quirks	= DWMCI_QUIRK_DISABLE_SMU,
+#endif
 };
 
 static const struct udevice_id exynos_dwmmc_ids[] = {
diff --git a/include/dwmmc.h b/include/dwmmc.h
index c69c7952b930..a7e8709b7b05 100644
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

