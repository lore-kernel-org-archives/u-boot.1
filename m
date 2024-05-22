Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A91C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6008288523;
	Thu, 23 May 2024 01:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mjumja+f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C3EA884F1; Thu, 23 May 2024 01:31:44 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D5A8884E5
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6f1016f41e2so2689031a34.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420701; x=1717025501; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nW2d4ajBUAfptcYRf7hM/6SH7SxDjRu31sqRJ6zWcGI=;
 b=mjumja+fbpkgOAco630YhlHtXH6VD46qLjLj7TMN5M6DceoFgL/9qH2choPYsVetf4
 J6vwWdwmf4EnRKTmIjDkkboB3doOPshL70H4qFtb55HNMBz3v2YTKUGiHBEvucLptewJ
 TRMseomD+0OTynMqEsNumDqVoj1ehwUyp1KUqETKYHpYF6rqD8NJ+bUgW6iC4TiCxx3n
 xQSwOmJ8bKS5JseUSKnr7VkPBnNuQ5kRUbJSGuglcfYLQ1dFXfGSPalB0sWDVlCkQYlv
 1Ud26tof9VrT9VMONpmHUn1M4Kq+Ok17oGWlhDktIZHVoMJQLoPGsd76CJdEGvaDLIrn
 Cf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420701; x=1717025501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nW2d4ajBUAfptcYRf7hM/6SH7SxDjRu31sqRJ6zWcGI=;
 b=bNZKTEerRqMDHGBH76rr7p5ViXOs0AUHxU3yMkzQe5oK2cIOxlb8lgMmcbgAyYuz2m
 jwdrfNt5FyH+bMNfPw2oIq6Gi8ovmeoVgcheimSsNX+PXShE3tO0GLASalf8TNa3EuVW
 uz235whZNfj1/nI1toK5ioDzmq2e/UsasGdE+pLKqm+YuyZGxRNgRNbME8ulgbAJBz8h
 HkxGN7BZKpEZvwadYZ7a+rBV8swDFUkqceedmH4Jt0V43+vKyRbe2ERTnO/DOfqTue3w
 BKNXh2rQFWFSL70XP07AuXFXGYcyNmYcDJ0Y4o2Grt+ha1C6bxPISqgc8KA7b3cSwPAE
 i6+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWzQ/oDqG9QwGzF5IquqDR21YRoCsLi+ovP4iCnt6rnKK++THmH6RaFKL42n+MRwmi9bcOgU5z2m/GPlKn2sS3ta2Odw==
X-Gm-Message-State: AOJu0YxcSecxvzkf5P+oEpcfDm7T7mdQjnhXk8GphLiVw3jkj4zhZyzh
 M+52f/Nwz6X5h8y3tKo+v+XmlptOOGy5RvNVUrURBc0s0sZDmrbXGSni6+tSdy0=
X-Google-Smtp-Source: AGHT+IEX+L5HYz4az/pTYCCnT3HRcyGtK3t4BTXAw5kCKHAO6oVYwFD2UiPU2v/tT1ekidV7kEwxIg==
X-Received: by 2002:a9d:6f96:0:b0:6f0:594a:5d5e with SMTP id
 46e09a7af769-6f6669a677dmr3336555a34.18.1716420700880; 
 Wed, 22 May 2024 16:31:40 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f0efd5a588sm4641465a34.14.2024.05.22.16.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:40 -0700 (PDT)
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
Subject: [PATCH 06/42] mmc: dw_mmc: Extract clock on/off code into a separate
 routine
Date: Wed, 22 May 2024 18:30:59 -0500
Message-Id: <20240522233135.26835-7-semen.protsenko@linaro.org>
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

Extract clock control code into a separate routine to avoid code
duplication in dwmci_setup_bus().

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/dw_mmc.c | 60 ++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index cbfb8d3b8683..40b9b034f793 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -412,11 +412,33 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
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
+static int dwmci_setup_bus(struct dwmci_host *host, u32 freq)
+{
+	u32 div;
 	unsigned long sclk;
+	int ret;
 
 	if ((freq == host->clock) || (freq == 0))
 		return 0;
@@ -439,35 +461,19 @@ static int dwmci_setup_bus(struct dwmci_host *host, u32 freq)
 	else
 		div = DIV_ROUND_UP(sclk, 2 * freq);
 
-	dwmci_writel(host, DWMCI_CLKENA, 0);
+	/* Disable clock */
 	dwmci_writel(host, DWMCI_CLKSRC, 0);
+	ret = dwmci_control_clken(host, false);
+	if (ret)
+		return ret;
 
+	/* Set clock to desired speed */
 	dwmci_writel(host, DWMCI_CLKDIV, div);
-	dwmci_writel(host, DWMCI_CMD, DWMCI_CMD_PRV_DAT_WAIT |
-			DWMCI_CMD_UPD_CLK | DWMCI_CMD_START);
 
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
+	/* Enable clock */
+	ret = dwmci_control_clken(host, true);
+	if (ret)
+		return ret;
 
 	host->clock = freq;
 
-- 
2.39.2

