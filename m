Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A492C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 545398855B;
	Thu, 23 May 2024 01:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GRXLJ5XL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAD6A88582; Thu, 23 May 2024 01:31:59 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D979D88554
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5b52b0d0dfeso2087724eaf.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420714; x=1717025514; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0FlBtORU2YphyJoC9ALjRrQBtrihTvdGD8zX7T+j5s=;
 b=GRXLJ5XLPAA5WfMn7TwdrB+I24gtNDk9VhbJgSt1rDWPzvR9XbUzyFiDUeoZkWREP4
 17ZyiR/v9On81KzFtLdkFoK6jOBPml45gYYc2KwyWGrFw+tXuMPH3idijK+c0yBSrZpR
 TU9oN8A0r0l5YyYSqnEfWHEjc9mGfB7DaQ+rRit02iNMVbz8Am3VpWzdUslmRY9qi1u/
 pa57vZtnj/8DOzaVLy18n5fbyaDu/cepTrztF+xVdd2HF5QdUU6aLLk3xlv617LZb0pL
 NZ6u9/dufsuTpjcnTsTTNJI/YYwX1I/usn7fNqgyyRQKCVVIOzxEkxBqKj/vlaNmXxpi
 kmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420714; x=1717025514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0FlBtORU2YphyJoC9ALjRrQBtrihTvdGD8zX7T+j5s=;
 b=A6Qvj5G5nFbJRmBiPPJjt3i3YmAThQ2t3AaRgDMEC0ClfkYQer7XyHxsjxM6syGT6N
 ofWA3XhT9yV/Qqjh4MYPXJx2cUNEKpW62/TAB/gNAa1Nl08rkSYGBI3qVH9enYSMRP41
 Hw1sfFuvvh4cQYw7QJbV3fF1OSJhrtQLDZ1FuHJJg/ZDyef8H8JJvnQ95vA/u4H6heeh
 VZIy7tndxBiB+41CcVu7Xj9153Q2Ujmo3xOyiZEZMfYuC2OG3X9Rbpe2v4/uCK4CEcll
 t9wseDGJUcp4vfmL5EVmM7iCZxaXW+1Fp0Zk94BMC/61hp6m34j8XYAXVwdDsM9lGTa+
 jSFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIgt0dBtbvfjVX7p7xoibRmTrDiaEKQ4MlNHxTuU3206QeiMoQueOTdtD/RNPJbG9/Opya8C4rSTPYM1Xr6MLV4Qhz5A==
X-Gm-Message-State: AOJu0YzypNXVDreN10qGF9CPp+83bdR3bc3GHXdDvKjHsuzUdZb/984Z
 YfqTv/gvD7lc1K+h71y5aNgZpilgzZlpVIR67yCjE0C3ui4uOmxh0rIwuI0NjN0=
X-Google-Smtp-Source: AGHT+IElLyDM9AZ7wYrfgXqM5IpRvSaFNbWAiUQzBsFi2fbffrIJqTlXJLrnepdao1BEpGbmhJOaJQ==
X-Received: by 2002:a05:6820:502:b0:5b2:3f04:8d04 with SMTP id
 006d021491bc7-5b6a2ef48a1mr3859670eaf.4.1716420712583; 
 Wed, 22 May 2024 16:31:52 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5b26ddcc6acsm6202956eaf.24.2024.05.22.16.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:52 -0700 (PDT)
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
Subject: [PATCH 20/42] mmc: exynos_dw_mmc: Fix getting private data in
 exynos_dwmci_board_init()
Date: Wed, 22 May 2024 18:31:13 -0500
Message-Id: <20240522233135.26835-21-semen.protsenko@linaro.org>
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

In case of CONFIG_DM_MMC, host->priv actually holds (struct udevice *),
and not (struct dwmci_exynos_priv_data *). This makes *priv pointer
invalid and may lead to Synchronous Abort during its dereference later
in exynos_dwmci_board_init(). Fix it by extracting
exynos_dwmmc_get_priv() helper from exynos_dwmci_clksel() and using it
for getting the private data in exynos_dwmci_board_init()

Fixes: 3537ee879e04 ("mmc: exynos_dw_mmc: support the Driver mode for Exynos")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 1f69e193f601..8e80bd6a059f 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -42,18 +42,24 @@ struct dwmci_exynos_priv_data {
 	u32 sdr_timing;
 };
 
+static struct dwmci_exynos_priv_data *exynos_dwmmc_get_priv(
+		struct dwmci_host *host)
+{
+#ifdef CONFIG_DM_MMC
+	return container_of(host, struct dwmci_exynos_priv_data, host);
+#else
+	return host->priv;
+#endif
+}
+
 /*
  * Function used as callback function to initialise the
  * CLKSEL register for every mmc channel.
  */
 static int exynos_dwmci_clksel(struct dwmci_host *host)
 {
-#ifdef CONFIG_DM_MMC
-	struct dwmci_exynos_priv_data *priv =
-		container_of(host, struct dwmci_exynos_priv_data, host);
-#else
-	struct dwmci_exynos_priv_data *priv = host->priv;
-#endif
+	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
+
 	dwmci_writel(host, DWMCI_CLKSEL, priv->sdr_timing);
 
 	return 0;
@@ -83,7 +89,7 @@ unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 
 static void exynos_dwmci_board_init(struct dwmci_host *host)
 {
-	struct dwmci_exynos_priv_data *priv = host->priv;
+	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
 
 	if (host->quirks & DWMCI_QUIRK_DISABLE_SMU) {
 		dwmci_writel(host, EMMCP_MPSBEGIN0, 0);
-- 
2.39.2

