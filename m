Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC6FC3DA7F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D66889EF;
	Thu,  8 Aug 2024 05:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ol+odSIO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4E6B88A6D; Thu,  8 Aug 2024 05:14:53 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D727889E6
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3db157d3bb9so395342b6e.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086889; x=1723691689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eY2rTYjkOWFBzEA+E9TVgo0yeFXWo2Z9cx2a5ssETXc=;
 b=ol+odSIOoBPwL5qoApT2uCmPVzNGpQx5bQN59YyYUVh0nQ6F9Ux2XnlRNl7GfvqrOu
 I16JIYn67BwgnE8mBqaCYOhQDZdfgi9KcGK7+61gbr7uxEYCppLYwEQHQXqZR11dW5ba
 rTHmHtl0ascjiml5P/mcd1SW51IZ148dLWAE/wO5OctzUTs87HKhD4fyU8bkM94uRMyf
 88dvtuvoBTeloSM4hoST1zDHfZAqx6srb5VoRSGlUjYfHtWFcij45ftgrEKHC/ZzmhCz
 Z2gBmWUO9jDDdoY057qO1Mim9JwLyC0LHtZaxjKYpDE7WuPNIylhUWLqmzV5hITaVd5h
 B9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086889; x=1723691689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eY2rTYjkOWFBzEA+E9TVgo0yeFXWo2Z9cx2a5ssETXc=;
 b=wxRNRKVwBPLIg3Oz9nc7vEAiNFdU2ZtxYJ5+7LE/sj6mAW66Nig7SZD17PbDutBi3r
 TI7BSrhs0G/IuF/EbmNBQ/tE0yfXz70SB+1QztpUvYgrmzL/oNSk7n9mba9aUI03QDBk
 dQkYA8MnVdp+UebtrMuYTR5sfHpVw2zPpsSRXi/YMBx6Rt/ab29qeMwhcNUzG5uq7dei
 dV5KPjYGZzQm+WE4JB7WVxFA5xQRt4ZoY8j/XIZSFV28Is3uQ68FLk4H7jhJl3wUDfEx
 xl2jiXYysk34kO7X1ENpdVW7SgYGKkOsXAbe8GDgpy2OmHK0/1j7fDP2JBMGde/Wm0Ot
 67qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCOo0BCoFsEFbp+Lca4WohbdJ/g1XFT3PlviJz0JaIPyj5fxYJFPBAIopzu00H9VYpwXPHb+9+fakKxwL6qztpeOlMjg==
X-Gm-Message-State: AOJu0YwebjP4d2qfsNjbYFjr0Cte10abaJFDH+23hmSyGfnB2nKlYmpE
 xaAmI+Yvrlc1/ap29QbB9M7b0/udbm4RVJpOd/EsazCD/lAD0fpFy/CD1SN5Crw=
X-Google-Smtp-Source: AGHT+IFEwGXIjc5mXvHVCJl0qPJXYfvBc5tKSM1l2riVqwc6mWtLghTk1TrOe/JegnILB4qYYkAMkQ==
X-Received: by 2002:a05:6808:210f:b0:3d9:dcbc:6b7b with SMTP id
 5614622812f47-3dc3b41cf8fmr771495b6e.11.1723086888848; 
 Wed, 07 Aug 2024 20:14:48 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db563b705asm4639955b6e.35.2024.08.07.20.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:14:48 -0700 (PDT)
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
Subject: [PATCH v5 05/38] mmc: dw_mmc: Extract divider update to a separate
 function
Date: Wed,  7 Aug 2024 22:14:11 -0500
Message-Id: <20240808031444.9619-6-semen.protsenko@linaro.org>
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

Extract the clock divider update into dwmci_update_div() function. It's
a procedure recommended in TRM, so it's better to keep it in a dedicated
function to make the code clearer.

While at it also extract the clock control code into a separate routine
to avoid code duplication in dwmci_setup_bus().

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

