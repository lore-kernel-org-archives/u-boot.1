Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052F5C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 17:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1933D885CE;
	Mon, 22 Jul 2024 19:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wzd7XsRG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11404883DE; Mon, 22 Jul 2024 19:57:50 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 287A5883DE
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-260f4c9dfe2so2094179fac.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671066; x=1722275866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Sb+eA0nsKjqJFteQS72+wjT8H0sZbUzKqM2Sbywazg=;
 b=Wzd7XsRGYDIs7Slxn2DlNCJojOywj2pcRLz2iPW2tDl5JicYjztf74yBsc/8208YBL
 TuK3otOoKyOgKH6vcQRjNS6dzh/zIFBU7s2g0eP8ilBqdXGDwVsod3LApV2TBFX7pzRj
 dZZpe7yyZv1H6NQpTUqk6+I3Qa8Vknbk8GXo8vihoyoyxXToVnxBbUAsrj4hDUEFraew
 mg8giU1lz7dudSFwzwnB4wXtzNTg4176arJDZrxRZcEGCI/Fe44I2eHgbEDU07rZGHf5
 CwJqtTmoC0U2MahYdYnfvJQGRZ25WVEt8hRnG9OHmjBR2fYZLRkkQs0LHs2PImG9Ve3G
 zf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671066; x=1722275866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Sb+eA0nsKjqJFteQS72+wjT8H0sZbUzKqM2Sbywazg=;
 b=tT5Y5we5r41Sq2LVg/voyp14TecI6mvtvzKAKnI13UMPqEChi1obB2+uu+V4ckzTxo
 EgYncEYyYHo71TheqcENgh/v78M8iUTiL2U6r3U1ISqTR7bqYb0b0iTjo/aFJEcnkzpo
 ClzWXQQYmm/demp4/jb8ojDn0+A0mFfPRRDLX6jpxojoX+PR2dXupWN/h+mQv1BYcCDR
 XFe77+BFt0M1NUu0U9ddu9NqyYy2mUeLg0+uvLlHlPyky5VkyBPPUgSdawKUu5T0PdJu
 yu6NW8y0lQ+4Xg3QLI4pJmW1dm3umBQaBul+OIAeAkkRd8FneXXGSg5thlhI9qNlN/xt
 folg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZdWiVRMxewVBYOgQgSG+2ZD/ghfrxtwGlhJgSa4s3Woy4fpKeU7s+BTpmKxvz3v5QqwZ7AZBtYmTcyn0Ub4wvIOcPAA==
X-Gm-Message-State: AOJu0YwlvUKOxi3oCF9g5obfd8dkkrXM1iofeUNNcZf4dX+3gWAZd4JD
 Dzqf+P/8qXsMptLi9n9z2DjPo+CHgYRVS2utE3wdwwTSaiP1SspLnHtJRVaw11I=
X-Google-Smtp-Source: AGHT+IFIE7frGaMEvHZyfDCwXikeIsgIPVri0P4APiWEmu/+NT9iMBVL2b3EF9GbqQmz1BIRZBYQ/g==
X-Received: by 2002:a05:6870:9382:b0:254:a6ab:e10f with SMTP id
 586e51a60fabf-26121c07da3mr3934949fac.13.1721671065765; 
 Mon, 22 Jul 2024 10:57:45 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2610c76bf2bsm1764090fac.13.2024.07.22.10.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:45 -0700 (PDT)
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
Subject: [PATCH v3 06/38] mmc: dw_mmc: Extract FIFO data transfer into a
 separate routine
Date: Mon, 22 Jul 2024 12:57:08 -0500
Message-Id: <20240722175740.6985-7-semen.protsenko@linaro.org>
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

FIFO data transfer is implemented as quite a massive chunk of code.
Extract it into a dedicated function to make dwmci_data_transfer()
easier to read and reduce the indentation level of the code.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - (none)

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

