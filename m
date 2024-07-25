Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F63DC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2FB588327;
	Thu, 25 Jul 2024 22:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tbD3zK2A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8143883A4; Thu, 25 Jul 2024 22:45:27 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AA76879AF
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3db14339fb0so176404b6e.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940324; x=1722545124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z75UPHN+6qAxv6CWvtIqKhekWJ1e75T2VKkNBWB9X+g=;
 b=tbD3zK2AGDgAMvxtt4EPxGXK7cdnX+78hhK9yfozqMW9qAuNpT/n+X2mOOr2Rd+qZv
 nlh47lmKaJq53vqHY9A+UquErSe4w8tsdJf9EyMjqFuhpVdWRI5rtAMXpOrBsoZToq4P
 HVVOSKF5bar00djGtABiW+MyguuEY84ov9Pb/ZGy5h9W7N6caFr028ubDp5pXn4rPTUl
 jMyfpck2pIDOy3RyATyI/xcZC0j1V75+kIGcHfPqmpvJXJfRmMiim67+QMUmGwB7Mb10
 1llknyNbwnkCDNyYWgMN3XClrCubdoKgeL1HEh9i1dwacX7Y+CXnd1FWx0T1MLXHffDa
 VuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940324; x=1722545124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z75UPHN+6qAxv6CWvtIqKhekWJ1e75T2VKkNBWB9X+g=;
 b=NpQJ+TlkkAYx5KmEkKJ7qBay9B8/kEaR1sI9UrDMmW8pvEmThH+eUvcDciu84oOqrP
 gzkRWI/4/Mx5oksa2itNOPLN8M6s+7rdRTm0yWiVVm1GfwjRCsssPdzV0H72wy5Vk2v7
 TxP7dmvCvkJa6JN08HVJspJQo7QD3BmUMNaQIicvbkVOd96ffJ6+h60EnP9r0hjuY9dc
 l+D8YinSr08FtJjfQRztSBXbksxzd687lp1NL4+6cRjKWo03Z2JpCLhnuG4gTkp9MuPU
 AKPfZ4oiWbq9KpKycueHZOr3P5yfkhdRbOpdZiBc+/5eKvp+Ubu8npCoKjhbsntphJp7
 VyeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6HFz5Vd1A7HI9WS5JiurbslgX1GvgQrE7zMKmoV+ucxI5iHsa32CxJ/gcToX3qzPR9yX5NKhgVWDV+DKNSoxBlaePwg==
X-Gm-Message-State: AOJu0YzU/brcWyYj3JztgPvww7J03zpwt5udVk9zBFAeH/5qcTgGX21G
 /gZr2y1fNmsgYjFSVswNbxHu4Np5JKHNPHzGoCPOch3OGUSVgxZj1R2+ENU0o+I=
X-Google-Smtp-Source: AGHT+IFL9ON11swDweMKq4jQAP9Dyafxj/LgYymexTYxyTT1ql2FpdI7+yPdxBCn2Eu7NYd/LaPC3A==
X-Received: by 2002:a05:6808:ecf:b0:3da:a9f1:4876 with SMTP id
 5614622812f47-3db10ef68efmr4119873b6e.11.1721940324350; 
 Thu, 25 Jul 2024 13:45:24 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db1341ebbasm431299b6e.20.2024.07.25.13.45.23
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
Subject: [PATCH v4 04/38] mmc: dw_mmc: Extract FIFO init into a separate
 routine
Date: Thu, 25 Jul 2024 15:44:46 -0500
Message-Id: <20240725204520.18134-5-semen.protsenko@linaro.org>
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

Move FIFO threshold initialization into a separate function to make
dwmci_init() more readable.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - Added R-b tag from Quentin

 drivers/mmc/dw_mmc.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 395b699b0a0a..4a9e57165fbb 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -538,6 +538,20 @@ static int dwmci_set_ios(struct mmc *mmc)
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
@@ -562,16 +576,7 @@ static int dwmci_init(struct mmc *mmc)
 
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

