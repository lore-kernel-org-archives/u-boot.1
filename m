Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4DBC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 17:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 439C78855C;
	Mon, 22 Jul 2024 19:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Cp+o7Z1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 874E5884FD; Mon, 22 Jul 2024 19:57:48 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C3A188453
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-706dea920f3so2179527a34.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671065; x=1722275865; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0SOWexDhZKgy98qvHFC6VGW70pjGoZQlJAvCc0MDcpk=;
 b=Cp+o7Z1TqsjGoGoWLaA7/2BiB9K18mnl5xZJMyDQtytWuq/5YjLrJYnk10ogZihz3h
 JitY3IdK7CT6TnA65sSJ9LrhR9I7izEc6K/H1P5dnD0wxq2zNabE08RLPaUOk2e103Wm
 jFtPu8ZfPnuQhKeH9a0QInvuNf8LFYIRCrgCMbvDoJEgpXQ1S74yBTGwrtVTHEhkPxMC
 xTG/TJTtCf9FjdCB3Cq2WYEITgvBdKH2g8d66KXAglx9rJDGwEPbzOj0oRrxga8MrABP
 m7GcmaQuoi8XA+Osr5ebi0pF3w+vtQsXxYdmDRjUAAXaMCLgAeHTS1IqKboVjLMJu3kk
 TH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671065; x=1722275865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0SOWexDhZKgy98qvHFC6VGW70pjGoZQlJAvCc0MDcpk=;
 b=BnSWQKekeU2NQvLy2kdpCEKCfj/gqCY38upoNP/ZqfSwsq1DM3URYzZl1mxzjyI3R1
 5CzUxZUSMfZRJaJQtTtVuvjUPpUgpPokCgWLQNOcj1W0Ml+lOTHh3AoGFczxSk4O1Kf9
 jUnMcHFd7XVF9KA9AU3yXraB/11wLniuc39xQ6lxRuRTy6lwvIhSRgc/WVAoK4DaTISy
 yQ5Yjh6Zz1aTr2FXbfgYd6q4lwQ/IQ4lOmf86ZoA0ufZJak8LOdPkjkGfTLf5InhaB1O
 wCDMfj0MS5bOrGuumvdtq7SSMXFoieul9f2RQSJxypA010DjQPSYpzXxTn4IKz2ixccU
 ZWbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUBmxEtWjBeCyUYew7Zdva2KsdFjLrEv3x3V3nK9EtcMhiaGjpepDhSwPNASeEXVUUCxejNS7yPhp8/qlPJuClzNlNxg==
X-Gm-Message-State: AOJu0YwcDvxkH2eyBvliJmg/DKBrs21EcMIEt1zALEGRwcZX/3GpLIZM
 gVth9+A+fNkFhcmoCQdV7g8ReH8rM3REFdwXlAYdkB2iD8XPcQsnCXFg7TU3SQ4=
X-Google-Smtp-Source: AGHT+IEGj7Rx2u+O4tCEdGWFHYLQH5Pu3XS7gn8nOWzr9Q4ULEEiElntoPrBdb6TEQgRNaQz+ays3g==
X-Received: by 2002:a05:6830:2aa7:b0:703:644c:84fc with SMTP id
 46e09a7af769-708fdbe2457mr3225644a34.11.1721671065029; 
 Mon, 22 Jul 2024 10:57:45 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f60c2be3sm1624885a34.23.2024.07.22.10.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:44 -0700 (PDT)
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
Subject: [PATCH v3 05/38] mmc: dw_mmc: Extract divider update to a separate
 function
Date: Mon, 22 Jul 2024 12:57:07 -0500
Message-Id: <20240722175740.6985-6-semen.protsenko@linaro.org>
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

Extract the clock divider update into dwmci_update_div() function. It's
a procedure recommended in TRM, so it's better to keep it in a dedicated
function to make the code clearer.

While at it also extract the clock control code into a separate routine
to avoid code duplication in dwmci_setup_bus().

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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
index cbfb8d3b8683..7bf3279ee9ec 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -412,11 +412,56 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
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
@@ -439,35 +484,9 @@ static int dwmci_setup_bus(struct dwmci_host *host, u32 freq)
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

