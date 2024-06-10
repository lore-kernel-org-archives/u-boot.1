Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79050C27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C0E1884BA;
	Mon, 10 Jun 2024 03:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vn+Q7w4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4500488468; Mon, 10 Jun 2024 03:12:35 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 157E488433
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6f9611fc320so1026268a34.2
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981952; x=1718586752; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPGi4Kzt/yp52MxH8jri7SB79TNuMSqNI79PcYdBi/w=;
 b=vn+Q7w4gyfxjgUc2ArK8cz0osZ+zNT6SbSQp0QcG7jM+a/EfB5lNzrxCYxb1Pe/mQC
 bfYJw7XlFZKr8hDkgVxStK7PUC2r++B9zaJrweC+xQddkZFAsxwvInWpRACiDCttiRME
 ZNmkhk8k8qQ2QSfThEjyAwI4yzbnU05qBMbFHeDGivQxmD/27NBbX+BqhquzUxPSM8ns
 rVrX4hbgLle7X2m+Dw0s7vlxl0ZxV5BH1+h3ah5kty9TrGpex02mVaUrQmg106sW9aLc
 6XPju9AEu4XosC6maY1i+8Bb2b5IaA9r8GRaGF4f/hOAP24b5souAPnVEvjW10/DO5Ow
 vwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981952; x=1718586752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lPGi4Kzt/yp52MxH8jri7SB79TNuMSqNI79PcYdBi/w=;
 b=wn+p5jVwrSWD9GknPurgrleoJ7ieXhKr/+QI8R5VDhtHWkpowZ3l5u+mFoEnleLF5o
 fEB5Yx9V6oac3EhUuAvzCcCeym08WTPQP10K9chqS21JyRwVW+11LAlVVsujw1DkLFe5
 i/ZpY9DrfHZLwMJnMn81ObtVW5f8gncp9gTeyRDseLyvWHhQ5upAbUtgNcFiHbkK59N/
 prVFTTdfBxBEN4SWrZ7Uy2fNFCdiAfstWLL+zCJQ4Ebt2emMrAL6ZtKmMlZiVQdI1Ktg
 p6sH6mhmEDwjXXehJXwAt0mCpBs1m5rIzoMqKe6eZWhZbCbW8ezQ2q0W+/efWJfa2CNI
 bg5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJu27G9sk3EIgEivNBKjwg3YaEQklljL0wOSXT8TcI6fN+f7iPZbmoNHWd9KNuLWCMDytanjfrzDFXnAsPfi89ZFZAqg==
X-Gm-Message-State: AOJu0YzXKPLcFXL3IViqLvYWN5VogkS7xQBzIuF9pEA42Q80YmDR3ids
 JcwEJ2Ndcs5tnGv4ftS+IkSv1QI8kbwOf/39vVrgUstkbBl90qa5yiMLAQ5idwQ=
X-Google-Smtp-Source: AGHT+IGjW6WvBq0IdfOtKkaxNDum63h6yNfCUd2MsBw9dLi2cMFTlZ30GapmUZsGM5VOqSSyORqraA==
X-Received: by 2002:a9d:7dda:0:b0:6f9:a9f6:55e8 with SMTP id
 46e09a7af769-6f9a9f6572bmr2438555a34.29.1717981951827; 
 Sun, 09 Jun 2024 18:12:31 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f9c7f4572csm80855a34.10.2024.06.09.18.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:31 -0700 (PDT)
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
Subject: [PATCH v2 07/40] mmc: dw_mmc: Extract FIFO data transfer into a
 separate routine
Date: Sun,  9 Jun 2024 20:11:53 -0500
Message-Id: <20240610011226.4050-8-semen.protsenko@linaro.org>
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

FIFO data transfer is implemented as quite a massive chunk of code.
Extract it into a dedicated function to make dwmci_data_transfer()
easier to read and reduce the indentation level of the code.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/dw_mmc.c | 107 +++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 54 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 7bf3279ee9ec..37a1125fba4f 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -140,25 +140,67 @@ static unsigned int dwmci_get_timeout(struct mmc *mmc, const unsigned int size)
 	return timeout;
 }
 
-static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
+static int dwmci_data_transfer_fifo(struct dwmci_host *host,
+				    struct mmc_data *data, u32 mask)
 {
-	struct mmc *mmc = host->mmc;
+	const u32 fifo_depth = (((host->fifoth_val & RX_WMARK_MASK) >>
+				 RX_WMARK_SHIFT) + 1) * 2;
+	const u32 int_rx = mask & (DWMCI_INTMSK_RXDR | DWMCI_INTMSK_DTO);
+	const u32 int_tx = mask & DWMCI_INTMSK_TXDR;
 	int ret = 0;
-	u32 timeout, mask, size, i, len = 0;
-	u32 *buf = NULL;
-	ulong start = get_timer(0);
-	u32 fifo_depth = (((host->fifoth_val & RX_WMARK_MASK) >>
-			    RX_WMARK_SHIFT) + 1) * 2;
+	u32 len = 0, size, i;
+	u32 *buf;
+
+	size = (data->blocksize * data->blocks) / 4;
+	if (!host->fifo_mode || !size)
+		return 0;
 
-	size = data->blocksize * data->blocks;
 	if (data->flags == MMC_DATA_READ)
 		buf = (unsigned int *)data->dest;
 	else
 		buf = (unsigned int *)data->src;
 
-	timeout = dwmci_get_timeout(mmc, size);
+	if (data->flags == MMC_DATA_READ && int_rx) {
+		dwmci_writel(host, DWMCI_RINTSTS, int_rx);
+		while (size) {
+			ret = dwmci_fifo_ready(host, DWMCI_FIFO_EMPTY, &len);
+			if (ret < 0)
+				break;
+
+			len = (len >> DWMCI_FIFO_SHIFT) & DWMCI_FIFO_MASK;
+			len = min(size, len);
+			for (i = 0; i < len; i++)
+				*buf++ = dwmci_readl(host, DWMCI_DATA);
+			size = size > len ? (size - len) : 0;
+		}
+	} else if (data->flags == MMC_DATA_WRITE && int_tx) {
+		while (size) {
+			ret = dwmci_fifo_ready(host, DWMCI_FIFO_FULL, &len);
+			if (ret < 0)
+				break;
+
+			len = fifo_depth - ((len >> DWMCI_FIFO_SHIFT) &
+					    DWMCI_FIFO_MASK);
+			len = min(size, len);
+			for (i = 0; i < len; i++)
+				dwmci_writel(host, DWMCI_DATA, *buf++);
+			size = size > len ? (size - len) : 0;
+		}
+		dwmci_writel(host, DWMCI_RINTSTS, DWMCI_INTMSK_TXDR);
+	}
 
-	size /= 4;
+	return ret;
+}
+
+static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
+{
+	struct mmc *mmc = host->mmc;
+	int ret = 0;
+	u32 timeout, mask, size;
+	ulong start = get_timer(0);
+
+	size = data->blocksize * data->blocks;
+	timeout = dwmci_get_timeout(mmc, size);
 
 	for (;;) {
 		mask = dwmci_readl(host, DWMCI_RINTSTS);
@@ -169,50 +211,7 @@ static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
 			break;
 		}
 
-		if (host->fifo_mode && size) {
-			len = 0;
-			if (data->flags == MMC_DATA_READ &&
-			    (mask & (DWMCI_INTMSK_RXDR | DWMCI_INTMSK_DTO))) {
-				dwmci_writel(host, DWMCI_RINTSTS,
-					     mask & (DWMCI_INTMSK_RXDR |
-						     DWMCI_INTMSK_DTO));
-				while (size) {
-					ret = dwmci_fifo_ready(host,
-							DWMCI_FIFO_EMPTY,
-							&len);
-					if (ret < 0)
-						break;
-
-					len = (len >> DWMCI_FIFO_SHIFT) &
-						    DWMCI_FIFO_MASK;
-					len = min(size, len);
-					for (i = 0; i < len; i++)
-						*buf++ =
-						dwmci_readl(host, DWMCI_DATA);
-					size = size > len ? (size - len) : 0;
-				}
-			} else if (data->flags == MMC_DATA_WRITE &&
-				   (mask & DWMCI_INTMSK_TXDR)) {
-				while (size) {
-					ret = dwmci_fifo_ready(host,
-							DWMCI_FIFO_FULL,
-							&len);
-					if (ret < 0)
-						break;
-
-					len = fifo_depth - ((len >>
-						   DWMCI_FIFO_SHIFT) &
-						   DWMCI_FIFO_MASK);
-					len = min(size, len);
-					for (i = 0; i < len; i++)
-						dwmci_writel(host, DWMCI_DATA,
-							     *buf++);
-					size = size > len ? (size - len) : 0;
-				}
-				dwmci_writel(host, DWMCI_RINTSTS,
-					     DWMCI_INTMSK_TXDR);
-			}
-		}
+		ret = dwmci_data_transfer_fifo(host, data, mask);
 
 		/* Data arrived correctly. */
 		if (mask & DWMCI_INTMSK_DTO) {
-- 
2.39.2

