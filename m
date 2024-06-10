Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1697C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F02C87D46;
	Mon, 10 Jun 2024 03:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LKr1USlH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB24088468; Mon, 10 Jun 2024 03:12:34 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91120883DA
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-250e4c4d650so2008847fac.2
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981951; x=1718586751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9nd4em9gOiHJXkkv3B9uErPXnC9QG1DOG02CNBUp5pw=;
 b=LKr1USlHpNMm36Qc1+isZMo5BWNlAHL4pq7bcrS67Sc9Fsd/rMKT/eWUohqieFrN9S
 iLaju9D6spvUHOFlDXLB4au/iCMSlpwUBXo1AtM6+f9nxwU6JqHaLChqHN3HQNmC2/nB
 mL4/hTUMVXHpYR7ks6KX8dDMrv7H3IiIQuJoSOG4HyuWYMUuZhyYp+lsnAW0No4yqRSg
 e4XCi90soIfo2LZLN3D2H997e9S8tJFQqYRs/pbQprwyR1xAZiU0sGpYWpKHpkbl/NNc
 lbCqexS9I4pCqAyIYea0x8R4I3K0mpsDSZeR4gwn1gSUEV71sus9b8fjO+dmfao5SlIE
 5Uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981951; x=1718586751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9nd4em9gOiHJXkkv3B9uErPXnC9QG1DOG02CNBUp5pw=;
 b=g7ZQMu1nwOmdXH00NPKbnFTC/omxiQmgycAnghKWVF4ULwcCG4sqDMy7NbGgO5Qmyj
 wScRM1VN6E4l0EpBAAMOWmwrP3Vg4WguQNnUKXf6ID2jsgaxDAyIARxr5B+td0x4GBYN
 RrhLGR7nv+8RgF9rcma1Tb5o8O8RLtyWy5fbCy3IitCSbb/QXhfGZFp3aflRqH9pe/V+
 UEX+7bG4AFqP6n5tW7YzD9Bf0DeZzqd+84ZdAS9kmIUT75ChkJlGjM1wW0SQnSYN2Hrc
 Aobbvg07NVvlVIFUn10UpD3I5hZKc66Hy0OR2GkOSKYFaji61qlIsqmqOv9sLq7zJsQN
 fCFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViJx6+NlBwESGjytn3QlJZbnnqktqIPrymju08CH5VwGZWV2OlyN+RMm0vrH+7f6xAzINsbtdHY3ahbjA7/vEJi+A9gg==
X-Gm-Message-State: AOJu0YzdH53TRl7WZnsgMD20FUmzkpN+1obUi5gYnNADkpPraajUlDDw
 yEnGQI0UQzL/ffyBntOamR7feLQZjqNPM5k2L3YGHoqtzA5xXRPY9A3B5IYeRSA=
X-Google-Smtp-Source: AGHT+IGng2mIUi8baggMyu6zSO7Bx0xDxtVRYsSiwe9iCzx46x3FI6QqyMKoBfhQX9gkmt7R7uTFwA==
X-Received: by 2002:a05:6870:d187:b0:254:bc92:9b97 with SMTP id
 586e51a60fabf-254bc929e3dmr2682273fac.57.1717981951145; 
 Sun, 09 Jun 2024 18:12:31 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25448138e4asm2062822fac.57.2024.06.09.18.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:30 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 06/40] mmc: dw_mmc: Extract divider update to a separate
 function
Date: Sun,  9 Jun 2024 20:11:52 -0500
Message-Id: <20240610011226.4050-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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

