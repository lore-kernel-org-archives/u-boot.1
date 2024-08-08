Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A96C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:19:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 977D688BFC;
	Thu,  8 Aug 2024 05:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P8Or0G8K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8930288B28; Thu,  8 Aug 2024 05:15:10 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DD0988A8C
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3db130a872fso388279b6e.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086906; x=1723691706; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crDJTDIWGS2LNY90dpOb7cQutAxy6tgKbBo7wBVDAbM=;
 b=P8Or0G8KoCtunzFsSC/lmeqejFCP8Gi+5X4+hO75aUxNmBYtUP08RYZnGxBhkdSwAJ
 I+jAYNvTwNuOdlcFwI5XQFNUR89/KuHRVy/B6+eNiy7d8slWM+QUq1wE3i/NeI4Y/ucd
 kmKm85PCaL3VoFLiLkcl6UmEtsrNVP6wCTAAcwlDxxQPJU8EZjKFpV/uYrj1zgVjWEHp
 05CTMuIEy44D+R6EaTzG7IWGUhTqxsu6So+/EY+wBo0K11I1i7tDjnUkfIvQHkgoK4YQ
 Ihbmzu24NPJ8NOui9nNfaxNd453Dq+IwbzhuAC2okng+G4Ig1iPcMNgbJEkoSNrqIIUo
 ZjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086906; x=1723691706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=crDJTDIWGS2LNY90dpOb7cQutAxy6tgKbBo7wBVDAbM=;
 b=h8SJt+V8FbrfBCrzouWyUK64uiVHgNbjPavbEzRVkdbGmqSaa9SHitE2BJD0bsirFR
 M/Z2QNFNXltfkFyDzXuGX39ISVLE97fZmRUrO5+siwaTG6EyzTqAte1tpW5VDsAIizfX
 pklCgnGsC/UHY82WQzTKxW6c3/14IkQzd8HRyB09DmZ3W9BcJ0gWNPNyQoLoI4tXk5+p
 ncsSgD75hMABRyCf7K8Jb/LCUBhtNWRJ14+KbUZkHIFmV5meNBqLVK+IGQezNf90q1fu
 O4Iv85IsS5LX/8iGFRK8Wn8hbhZWEpWYahC5f2QBBuEP7XZTQ7FVTMzMCHvaM3e7EMA/
 7CvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7SiA//l+MYVrbWJ+HCI/sdYKH1VVDrvou/ioQ9L6dle1E4dbVv2P49co+OHf0uS6VF6QG+4jB2YWDu56hxZPPpenm7Q==
X-Gm-Message-State: AOJu0Yy6fJH90Eoly8YDs3Oq1tfjfIwAhQ19KCvaau9U1ftFB5JRDH4Q
 ujMDqZPxEwPzHT4U3AVBGwOhJxUWf/A/jI/3NJZJ4Vv1xX2X2UQf50SnkLbhXQE=
X-Google-Smtp-Source: AGHT+IHeZuoH7hWVCfS2yP2vYAkshIFsunCP8AV/B9zNc9/Bzx4GupIts4R4TTw6IRewW1mtsz0lrA==
X-Received: by 2002:a05:6808:178e:b0:3d9:2626:c64a with SMTP id
 5614622812f47-3dc3b41c71dmr601694b6e.18.1723086905844; 
 Wed, 07 Aug 2024 20:15:05 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db563b8707sm4625099b6e.36.2024.08.07.20.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:15:05 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v5 28/38] mmc: exynos_dw_mmc: Move quirks from struct
 dwmci_host to chip data
Date: Wed,  7 Aug 2024 22:14:34 -0500
Message-Id: <20240808031444.9619-29-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808031444.9619-1-semen.protsenko@linaro.org>
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
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
Changes in v5:
  - (none)

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

