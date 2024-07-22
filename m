Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3677AC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 17:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD06688403;
	Mon, 22 Jul 2024 19:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z2FOb3rE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB578841D; Mon, 22 Jul 2024 19:57:47 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83CD987E30
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5d569bee00aso1210151eaf.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671064; x=1722275864; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/szNzAHh4ooOhxwkHsXehb7GdYF2Vg4+vJOe1XuY3No=;
 b=Z2FOb3rE2lFEeOrOWdiw07jaOy0qIJ3iE0351D/JtDpkatcZ5FRGui0+t4y9Yo+VP/
 3AX9WkJy2RgZ8NIg3RrzpQaphKXa6oOZQ2BpLOXOcx7CxqlAO/nXySeTNy6JHSNMhQbM
 b25GVAy5epv9mFlVCeo5x4XvWTo9GStnUyg8oMuIqn9fVAT812wSCbhuiLEkn38Kpi37
 X5W+O8kb2Nj87WX+MF7VSR0a3jlR1aWCkFDq8if/FJN2cEedNdx8xL3oezew8AIQqrt7
 twGartUkScWIPcGKghHJ0Ts9Qivq7K0INiOUQZrzN+G0xahkEG8sh4qcWh2FMu8VPMvT
 po7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671064; x=1722275864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/szNzAHh4ooOhxwkHsXehb7GdYF2Vg4+vJOe1XuY3No=;
 b=ea4YPsHqNpoL0KpLafa+o1RhnXgPX/zXgwvBIIjT4KAB2ZIRKU33cchwnO6l8KdDMV
 g2Db1QsWQW6TQDXkwNtn1YChJ93fpHhx5Dez8MPvyfHm429V37JvgnNLn+zc7VksnOHS
 p01z8dQCPBVgK2tqhSi7yJPT++QPUVoU+L2aGa+bu5jfADeFbimpKyuPSM9+ruZNDeGP
 /bO8ZTfRdrn3hLyi6D24Fda5unKebc3slCBDRgIVZyAyb98fskDSB/VQ0G7C5kcROzmJ
 xPMt9kc5V0gtH+ahUaVyBkmXBQvTOru7EfoxOfOJFKu2WGRO7d7Nt7csWBI4J52j0wci
 7MVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd8RAnHxTJ/AjUIKqDv+//d3dRlL4sQbS0XRkKjgRTiW3iLP6Qnph6ObqRcb9HEIWSEloGNs2LnY49RFZOWBoBTBD4bQ==
X-Gm-Message-State: AOJu0YxKL++USkD5xmtYCXxeiMJOdEYEPiSGeR59Oj9p1McDgZ7uAj88
 pLa7ttf2lS8txX1oQ+d2TdsG+nk/NBjiDjK8n1P2+lBKuWviEf8qRIZggTJHJ/o=
X-Google-Smtp-Source: AGHT+IHYl0NWnLd0UeYR7IPAsmFEwygtVOzlMgtNTGqXFeuyx1E7bShAEnCfZsvl00fwL7LX9pSJKw==
X-Received: by 2002:a05:6820:210c:b0:5c7:b679:4503 with SMTP id
 006d021491bc7-5d564cfc023mr10902978eaf.0.1721671064336; 
 Mon, 22 Jul 2024 10:57:44 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d55d4eb2e7sm1325847eaf.46.2024.07.22.10.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:43 -0700 (PDT)
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
Subject: [PATCH v3 04/38] mmc: dw_mmc: Extract FIFO init into a separate
 routine
Date: Mon, 22 Jul 2024 12:57:06 -0500
Message-Id: <20240722175740.6985-5-semen.protsenko@linaro.org>
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

Move FIFO threshold initialization into a separate function to make
dwmci_init() more readable.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
  - (none)

Changes in v2:
  - Added R-b tag from Quentin

 drivers/mmc/dw_mmc.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index a82f6a96db39..cbfb8d3b8683 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -540,6 +540,20 @@ static int dwmci_set_ios(struct mmc *mmc)
 	return 0;
 }
 
+static void dwmci_init_fifo(struct dwmci_host *host)
+{
+	if (!host->fifoth_val) {
+		u32 fifo_size;
+
+		fifo_size = dwmci_readl(host, DWMCI_FIFOTH);
+		fifo_size = ((fifo_size & RX_WMARK_MASK) >> RX_WMARK_SHIFT) + 1;
+		host->fifoth_val = MSIZE(0x2) | RX_WMARK(fifo_size / 2 - 1) |
+				   TX_WMARK(fifo_size / 2);
+	}
+
+	dwmci_writel(host, DWMCI_FIFOTH, host->fifoth_val);
+}
+
 static int dwmci_init(struct mmc *mmc)
 {
 	struct dwmci_host *host = mmc->priv;
@@ -564,16 +578,7 @@ static int dwmci_init(struct mmc *mmc)
 
 	dwmci_writel(host, DWMCI_IDINTEN, 0);
 	dwmci_writel(host, DWMCI_BMOD, 1);
-
-	if (!host->fifoth_val) {
-		uint32_t fifo_size;
-
-		fifo_size = dwmci_readl(host, DWMCI_FIFOTH);
-		fifo_size = ((fifo_size & RX_WMARK_MASK) >> RX_WMARK_SHIFT) + 1;
-		host->fifoth_val = MSIZE(0x2) | RX_WMARK(fifo_size / 2 - 1) |
-				TX_WMARK(fifo_size / 2);
-	}
-	dwmci_writel(host, DWMCI_FIFOTH, host->fifoth_val);
+	dwmci_init_fifo(host);
 
 	dwmci_writel(host, DWMCI_CLKENA, 0);
 	dwmci_writel(host, DWMCI_CLKSRC, 0);
-- 
2.39.2

