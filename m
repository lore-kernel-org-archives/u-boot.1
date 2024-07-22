Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9A9C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BC68886A0;
	Mon, 22 Jul 2024 19:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FoTjh3r0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55022885B6; Mon, 22 Jul 2024 19:58:06 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A230886D7
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3d92d1a5222so2748269b6e.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671082; x=1722275882; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aDqIAM4+ORVKDjdU6ZaN5Hj+XhgxoYsFlxybUSvTUms=;
 b=FoTjh3r0K7fMdrmp5BkBF3XG7a9V3fP28d9Lr/Mi8JUw5yzLgpFhbLNKwnXR1vcCk8
 0lG4D5Sp+KxTqIMDB6b8LgwqRwexJn4hLtEk8UnucuIp6C3tp2sUjB8FkQHYq2phYZkH
 mkz1rLEABFcJPi+cOfZPb0oX3lEyXjCtu/RUZAxN8OTCzb0MDpeYn51FJj1RSi6jbAl9
 EKKFy0DgQ6EJIJGz27J3kKG87Bzd0SmNZoXJgWjLDJGHsQ1WsFs/PdwPoTPAC4LA6Hce
 p3YRfuVFccuYP5Bm7GkwUW5jAqsAs3Z/Qp/MicK7EdQBQIyrGEG3QjSvssFuQ/kBGhlL
 4LWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671082; x=1722275882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aDqIAM4+ORVKDjdU6ZaN5Hj+XhgxoYsFlxybUSvTUms=;
 b=cEcMzl5n/lA7VhUuKNpAKZVrJHQRXzhaY0LC4WgPEMfcVzYbofcfwGvjjsT8k3dnoJ
 NyCYr7XOXQlzp44ndJes/ncinvXI4jpimd/Yaj4dPWUG8Nr9QGPvrKDHSsOjP8UBjDMG
 aFSvOP1K2RHEmwlxTOyVQcfjhzrOdo2MhqnifV1/G/yRwwSsAI+T1Jw/mCPiMSLS0VIG
 pdPZUJCnRjVhxRIY+14sU2IhLSHZal0IecPBr3dEQDDqqCksnijf54rbqbwdxQSi3kG1
 JNI3ToAO4Lt6L+nmJclU5vMjHPYRyFXePNp/K9vGyCTr1PA78OojdnhJheL/wdHqCR6U
 dLzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtxLXguGYmj7rN1S6oGt0ESj9iSdB/bK0O7SVq6cnh0KOB+NYspfb4GWkwJVo2I35HdK5FslV6nDTx0JocTPg5oBys0g==
X-Gm-Message-State: AOJu0Yw67G1lpyjoVKa+pKHsS63SCshMzkb5HrAq8hIVX8sKEyjb/pgr
 Mr0FSgHmXGtFiEaeIygoi0k1hF3ZaNkjofnyc6D2Pyy7/C33p5GpnUvzveJqb9w=
X-Google-Smtp-Source: AGHT+IEqB/R5N7kUrxIxGgRJefZaxEXkMkfjw5GQYzfvG2BGtMxRr0zY9Whij5lyE/KyqIkuLnTCkw==
X-Received: by 2002:a05:6808:179e:b0:3d9:231d:cd87 with SMTP id
 5614622812f47-3dafd42386bmr543318b6e.35.1721671081965; 
 Mon, 22 Jul 2024 10:58:01 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dae0969c8fsm1610698b6e.12.2024.07.22.10.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:58:01 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 28/38] mmc: exynos_dw_mmc: Move quirks from struct
 dwmci_host to chip data
Date: Mon, 22 Jul 2024 12:57:30 -0500
Message-Id: <20240722175740.6985-29-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722175740.6985-1-semen.protsenko@linaro.org>
References: <20240722175740.6985-1-semen.protsenko@linaro.org>
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

