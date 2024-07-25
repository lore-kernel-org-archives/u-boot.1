Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04630C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10C64886DD;
	Thu, 25 Jul 2024 22:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z4l6rPUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A11C488636; Thu, 25 Jul 2024 22:45:38 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50628884CC
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-704494efa7cso175192a34.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940334; x=1722545134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UKZxndUm2Msgg2mExU+W8UaV4CoWdCztEVfBzyKLJLg=;
 b=Z4l6rPUGSpw7T6VbXNuFIpWKpQq+8gqymKCZGtoN2tFBLHVcJj2+mjmkHEcQNvGALA
 +deWUbhlgjB75sxGsYjbtkI/2NWcltCZvpttnagDmIjBFS8C2bXFrbxqczJhc/8Wo0GW
 6tLRYJlYuwlrJt/xTKpbJ1m0OMZ6UzkIgkDnqYPzVHsk2x1AHQKXPs1QouMsfMAL9EL3
 k86OPidBNYBoPFC6vz3popO4zQW+1Z4b4fLz7JD0hBtgxo644+at/W9D/HwX2capKqxU
 MSEtPhFUzramYvxAKRoTPd97tco8pBlxuPCcJuySK6FFwkRh7dRhuuTBCbmf14U9JHgy
 FI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940334; x=1722545134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UKZxndUm2Msgg2mExU+W8UaV4CoWdCztEVfBzyKLJLg=;
 b=uQAyQ7f7e2Pvso6o5NzGHlehQ0untJkFqI5et3Exx76/ueFPxBPcwqyoRe2q6PvHyD
 OtlYRgkuq/+XpH/DNENAj58vA/YqCdsjMywvcrxk106iFhw+jmaZ8d/SHXtlny+8hiVU
 jHOLfLXZ5HURAr4FeVaWDv3M29QM6/ciOPRNMiMi4Jerjs7xDsXWrXndRh22qXhfWSdr
 OO9AyBUfyZ1jdpnkX99JiEzWxj4gLlgTv5ekOcAexYOM2yhOX8uYYHdJuUHVq+g3ggVe
 RFQyBWxyAXrJMIxHTez5CLQzXgB345bk3KEoTScYUjCn8a5nW/I/jip5W0PAyN70HmgX
 FSew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgLO1pw1Xrw9pBN6I6E1WztrIWmlcBSngJnXBq28YfyCO5QYG4t8PL8kXr3nlBRxAn9AV51zsp+sA/Xwr9wySKsjB0EA==
X-Gm-Message-State: AOJu0Yz5nFNmVPJno9N1mfk2r2CxUMSumuqU6/xL9ZLpN1CFHMRHM+8s
 FJpIUn+7NqG+sVrwZwcQkS70IH9MpnYRDwi4unq140L8cu7kqpeL8hmtPiXOYQM=
X-Google-Smtp-Source: AGHT+IGbzvJFPZrUJKGn22lSXO6Bb+Ga7ILb9hNS7GRabxkWI44SxSMWlRydx5tnrH0HPShcIWxhHQ==
X-Received: by 2002:a05:6830:63ca:b0:703:63d3:9ef7 with SMTP id
 46e09a7af769-7093223cc11mr4167637a34.14.1721940334705; 
 Thu, 25 Jul 2024 13:45:34 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70930720f62sm453467a34.37.2024.07.25.13.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:34 -0700 (PDT)
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
Subject: [PATCH v4 18/38] mmc: exynos_dw_mmc: Fix getting private data in
 exynos_dwmci_board_init()
Date: Thu, 25 Jul 2024 15:45:00 -0500
Message-Id: <20240725204520.18134-19-semen.protsenko@linaro.org>
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

In case of CONFIG_DM_MMC, host->priv actually holds (struct udevice *),
and not (struct dwmci_exynos_priv_data *). This makes *priv pointer
invalid and may lead to Synchronous Abort during its dereference later
in exynos_dwmci_board_init(). Fix it by extracting
exynos_dwmmc_get_priv() helper from exynos_dwmci_clksel() and using it
for getting the private data in exynos_dwmci_board_init()

Fixes: 3537ee879e04 ("mmc: exynos_dw_mmc: support the Driver mode for Exynos")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/exynos_dw_mmc.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index a86d58663c1b..aa542c13fea8 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -41,18 +41,24 @@ struct dwmci_exynos_priv_data {
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
@@ -82,7 +88,7 @@ unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 
 static void exynos_dwmci_board_init(struct dwmci_host *host)
 {
-	struct dwmci_exynos_priv_data *priv = host->priv;
+	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
 
 	if (host->quirks & DWMCI_QUIRK_DISABLE_SMU) {
 		dwmci_writel(host, EMMCP_MPSBEGIN0, 0);
-- 
2.39.2

