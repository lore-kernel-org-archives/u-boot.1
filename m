Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114A3C52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3189688A9C;
	Thu,  8 Aug 2024 05:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sAZa64HT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F30DD88A2A; Thu,  8 Aug 2024 05:14:54 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D42C8890F
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-70942ebcc29so295333a34.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086889; x=1723691689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzPnAW61MjVevF12qCy9+5xM+ky0LjDVg2Oln8L34PY=;
 b=sAZa64HTe70NZ6P6lprHKZxTKzVBmfubVY/YinDQotRXQw+alVY5SgtqWCsaTr9dq8
 fNbTYguM3stK6qFlr21RsTGiw2IakGW6rCtW7FyAnIi+9cAE+AxTn749gRbH/w/KJLWN
 9j4M4Al/GsBaAznZyCGvHws/O0Kk0s/YFLZtum5lxB98fX3XlLP0kArVKRlK5q1/UI2d
 zQptkxQ6K+9s9wu4oGuMHKuHxdDAlZd4dJKgwd7a09cy/uZB7Moei9yS0UoQxNwro/PK
 bV0muY59wJqGTgSWbJ/gwhWBVg8F33FOsyggOPHv+s8WT/bD+Gea7NmPRuFR17oyNZ+V
 gakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086889; x=1723691689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzPnAW61MjVevF12qCy9+5xM+ky0LjDVg2Oln8L34PY=;
 b=u3BG6iQwI8kTEpg/U/J7yYsJmCa4PBgadfoBGZWXdS1sh9ghbqK9a6QjgPj7OJjhdd
 DQ0lD5FZmkUp0xn5nNOB/zopdp9/S9qW1WCn3wxbKvn/kxct2IcljSqox3+iOVi6OISo
 ZMI5d9rLz9do42DZEC6cv3GW9l3c0pF5aQo+e5+Fvh5P+2rUGld5vHE9wn47DncFXkH2
 fC5Ur4XLH+Up4UMJ0nUzMGZLz1D1HgMseCl0OPbFa3FGXCrcUe/F5i0iSif/wg1dGjQa
 3TNaTtmKww6I7jGNh0CKElPXpeUIMqxNz7N64EbA6W9/HKyi9opFh++0y/dHEMSAoSyf
 ZQ0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB9F4tsyLRwOIAnpIRnlDZMESZ96b7MSrtnJUWyvPiz4U5K85rOSbKc5h3zDq4XPCsMmeeQJv0kLD8fv+k6h2JoBNerQ==
X-Gm-Message-State: AOJu0YyVW7xk7qFj1oBnJTgkAVl+zzcjkVfw7AMQxez3HGiN3g9q3VHl
 IjbmZDSX+0NkntSMzG5IFivEkfXsTi3PezQtnEwuBdkblUAiVi1EPfbbpYQXIXA=
X-Google-Smtp-Source: AGHT+IEp6OCbsTf7zRBWlCiMJLpuG7ueaFPSZ1TS3tYL/37rO6G0tBeXQLrWXIcdYoCl4rL/9LA6lg==
X-Received: by 2002:a05:6830:6705:b0:709:2721:ad44 with SMTP id
 46e09a7af769-70b4fc35a9emr972334a34.12.1723086889517; 
 Wed, 07 Aug 2024 20:14:49 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a3a76907fsm5163119a34.71.2024.08.07.20.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:14:49 -0700 (PDT)
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
Subject: [PATCH v5 06/38] mmc: dw_mmc: Extract FIFO data transfer into a
 separate routine
Date: Wed,  7 Aug 2024 22:14:12 -0500
Message-Id: <20240808031444.9619-7-semen.protsenko@linaro.org>
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

FIFO data transfer is implemented as quite a massive chunk of code.
Extract it into a dedicated function to make dwmci_data_transfer()
easier to read and reduce the indentation level of the code.

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
  - (none)

 drivers/mmc/dw_mmc.c | 107 +++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 54 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index b9c14fe6857b..b99f63a6f8bd 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -139,25 +139,67 @@ static unsigned int dwmci_get_timeout(struct mmc *mmc, const unsigned int size)
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
@@ -168,50 +210,7 @@ static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
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

