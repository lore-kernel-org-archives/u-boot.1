Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8411AC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64C8E8853E;
	Thu, 25 Jul 2024 22:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h8bRruzB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B5FC883A4; Thu, 25 Jul 2024 22:45:28 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A5C788327
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-260f4c9dfe2so319403fac.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940325; x=1722545125; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYiQ9pkdgiLeGne+YAOXNl8tNbMdErDeetuqURGS3/Y=;
 b=h8bRruzBqLmVW3z6Oh0N2ht0rO2GwdeepX0fDmGZcdL7Y0YF49wqUbtqh8oY/dfqY/
 l9Y5Uek2nXS7W/G3iKUtUa+F+ofEdRm1BuJ/u2EtoG5ndFpUIA4Yj3LXPrG5tyk1+1iX
 rdsh8cZZHaeqSpzZWMQfzGKSMuDBT+fap00fKvjPb4GqB0C9sq4R1xY+itbZrG8e5PBl
 g1p9+5vCsZxUBYb0P9jvQ5pV/T3U4HptlJFHj7bv0Sz8y2nFPlouaOs5FNcLRM/11KQH
 lm9LRxRwJsvfV7KyMFVKvLX5OSxa/h4KLCQ15petVj8Fj0A9Q2zeGnUGthrsGafoIDcb
 5y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940325; x=1722545125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYiQ9pkdgiLeGne+YAOXNl8tNbMdErDeetuqURGS3/Y=;
 b=e3bv8Kw/5gy1iHQ5P/wTbQlY59z521pvrFJq6JRI5LXGC2M/T6StZOs9QpsRd+rR1J
 cX4vro4/RhDuAunq7Je9YF06Hk19Uv3DrajGYQtBd5m/5cNksuzbsAHbsS72oxoMZLCP
 GoEqFkPQLMU7cOqyXPDIqguXjenhO54uYG1TBq6YruOF0IF6WVHPWp5iiXjRqx1QoLF/
 12ZEMpL3ekWOPxURZ+hlQsalUyx6Q+Qo8wi0oA8mk0Hxm3UeNLfTgrV34ZLQcbCsDgDU
 TuRbqZlxFLj08uToXUsdHXPkOIJodQtfKAWV7YCzU12a/hJxDrAS2w9i3w35vRKCai6D
 C98w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjr1vJpNRVAT1Xs3rRGLZokOqBKo/TZQbSfhN36jr20BZxjX/GlC8HyLm7qo/QQDB0EuKJwGgX8jRyXc4XhF+WamRASA==
X-Gm-Message-State: AOJu0YyrRgXUi3k2WTlrdfpvl2FhVKcYzrnjq5ZOXuPHky0qbAfOUU05
 9N3dzHw7CCFm6nzG+bqt2u2JOc9qfpBj4UaZHocakoBsb4lvz4y8Qr/+od1/HSE=
X-Google-Smtp-Source: AGHT+IEVU4wXDDNWNyFWWFxyEVGM1ssr8NU4Q6kIwchCdsRLKSCYzTbX4J004hkcqafiEx547hRBlA==
X-Received: by 2002:a05:6870:970d:b0:265:5e05:766c with SMTP id
 586e51a60fabf-2655e05aaeemr1769209fac.2.1721940325000; 
 Thu, 25 Jul 2024 13:45:25 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2653e735b1asm416165fac.19.2024.07.25.13.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:24 -0700 (PDT)
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
Subject: [PATCH v4 05/38] mmc: dw_mmc: Extract divider update to a separate
 function
Date: Thu, 25 Jul 2024 15:44:47 -0500
Message-Id: <20240725204520.18134-6-semen.protsenko@linaro.org>
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

Extract the clock divider update into dwmci_update_div() function. It's
a procedure recommended in TRM, so it's better to keep it in a dedicated
function to make the code clearer.

While at it also extract the clock control code into a separate routine
to avoid code duplication in dwmci_setup_bus().

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - Moved CLKSRC after disabling the clock as recommended in TRM, to
    avoid possible glitch
  - Extracted div update into a separate function with corresponding
    comment
  - Changed the patch subject and reworked the commit message

 drivers/mmc/dw_mmc.c | 81 +++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 4a9e57165fbb..b9c14fe6857b 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -410,11 +410,56 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
 	return ret;
 }
 
-static int dwmci_setup_bus(struct dwmci_host *host, u32 freq)
+static int dwmci_control_clken(struct dwmci_host *host, bool on)
 {
-	u32 div, status;
+	const u32 val = on ? DWMCI_CLKEN_ENABLE | DWMCI_CLKEN_LOW_PWR : 0;
+	const u32 cmd_only_clk = DWMCI_CMD_PRV_DAT_WAIT | DWMCI_CMD_UPD_CLK;
 	int timeout = 10000;
+	u32 status;
+
+	dwmci_writel(host, DWMCI_CLKENA, val);
+
+	/* Inform CIU */
+	dwmci_writel(host, DWMCI_CMD, DWMCI_CMD_START | cmd_only_clk);
+	do {
+		status = dwmci_readl(host, DWMCI_CMD);
+		if (timeout-- < 0) {
+			debug("%s: Timeout!\n", __func__);
+			return -ETIMEDOUT;
+		}
+	} while (status & DWMCI_CMD_START);
+
+	return 0;
+}
+
+/*
+ * Update the clock divider.
+ *
+ * To prevent a clock glitch keep the clock stopped during the update of
+ * clock divider and clock source.
+ */
+static int dwmci_update_div(struct dwmci_host *host, u32 div)
+{
+	int ret;
+
+	/* Disable clock */
+	ret = dwmci_control_clken(host, false);
+	if (ret)
+		return ret;
+
+	/* Set clock to desired speed */
+	dwmci_writel(host, DWMCI_CLKDIV, div);
+	dwmci_writel(host, DWMCI_CLKSRC, 0);
+
+	/* Enable clock */
+	return dwmci_control_clken(host, true);
+}
+
+static int dwmci_setup_bus(struct dwmci_host *host, u32 freq)
+{
+	u32 div;
 	unsigned long sclk;
+	int ret;
 
 	if ((freq == host->clock) || (freq == 0))
 		return 0;
@@ -437,35 +482,9 @@ static int dwmci_setup_bus(struct dwmci_host *host, u32 freq)
 	else
 		div = DIV_ROUND_UP(sclk, 2 * freq);
 
-	dwmci_writel(host, DWMCI_CLKENA, 0);
-	dwmci_writel(host, DWMCI_CLKSRC, 0);
-
-	dwmci_writel(host, DWMCI_CLKDIV, div);
-	dwmci_writel(host, DWMCI_CMD, DWMCI_CMD_PRV_DAT_WAIT |
-			DWMCI_CMD_UPD_CLK | DWMCI_CMD_START);
-
-	do {
-		status = dwmci_readl(host, DWMCI_CMD);
-		if (timeout-- < 0) {
-			debug("%s: Timeout!\n", __func__);
-			return -ETIMEDOUT;
-		}
-	} while (status & DWMCI_CMD_START);
-
-	dwmci_writel(host, DWMCI_CLKENA, DWMCI_CLKEN_ENABLE |
-			DWMCI_CLKEN_LOW_PWR);
-
-	dwmci_writel(host, DWMCI_CMD, DWMCI_CMD_PRV_DAT_WAIT |
-			DWMCI_CMD_UPD_CLK | DWMCI_CMD_START);
-
-	timeout = 10000;
-	do {
-		status = dwmci_readl(host, DWMCI_CMD);
-		if (timeout-- < 0) {
-			debug("%s: Timeout!\n", __func__);
-			return -ETIMEDOUT;
-		}
-	} while (status & DWMCI_CMD_START);
+	ret = dwmci_update_div(host, div);
+	if (ret)
+		return ret;
 
 	host->clock = freq;
 
-- 
2.39.2

