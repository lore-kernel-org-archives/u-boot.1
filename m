Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27336C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9C7288542;
	Thu, 23 May 2024 01:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NQwVI/yY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7191884F9; Thu, 23 May 2024 01:31:45 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69D51884EE
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6f1016f41e2so2689034a34.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420702; x=1717025502; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=up20KcUHKaWbwVwB7lK+qX3BMiB3ScqRXF1dCSdqfWg=;
 b=NQwVI/yYlkaV4gDmM/tI/L5k9BuLv93k7CTnDD9fZmkPBV4jFiTxr9hoIhkEgAMwZo
 LHP8IqvprpnPk+vzMJA38Ow07HkiVErSvboC5RS7nsC1Cm2KUtqCNdFqA3dWbobpHWy9
 tKA3eTONRSbdQI5E3U3ErK5i+uo3xqPNSd9jkJYYRDdBDMAtcduAgLVzFRrdoz0OEJaw
 Aid5IC3ShEe3wDt/UKs9t3uGbvlooXsmt4//TqvVeuzXQALjImjIU61y2b2F99lsxMVE
 xGM1aL9oSFc1jErxCUnRaBhyZM+KuIMTB+Ac7P4cQ+Rt9mBjCRrXfU6E3nwEsDo45jCa
 Fl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420702; x=1717025502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=up20KcUHKaWbwVwB7lK+qX3BMiB3ScqRXF1dCSdqfWg=;
 b=K6CZWsFB31B7VuxzZjHHpx9SlJw8oHIvzlijtQcDHtDevmMLazAIfut2rItWDvyX3X
 wjRf0S2mQiwKcGbuzemRTJ3uUzuwE4RqDNa1Mk1fH00VtsoYEA4RKgew+o0vMdRhgV27
 kTp2MfKH4lp0VzZP6J5S/krA4gRSo++FxCUKZ90BGT8EZ3a2UBpHvU6082YhnMa2wkv2
 q+hhE7MoS32KS7kC12tZFeizi83UoE6T6hZ8mCy6kUMfgE3CzXarkyW/pl7SLRPwMaxm
 B42F+TCPLWR0VqWV/qh81rWDzNCfdx2EhmKm9tbk/DTXUuRbVQ52z8K7gY7KlIB1PF5+
 AQQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL5pEdHGq4oWB/qVgP26jf4wf+0q6zDbekSm6zly0vELXM9qBgVlrFwgUmdPb6elwUMYo2Pxrk2KKEWQETQoc1z4mqFw==
X-Gm-Message-State: AOJu0YyYIgMJszXNGQSLUZkpYkNJo9q7nO7yqcurvx7wuyG9x6ZkQMao
 iItWweAv/oHXo7854xvZOIbkNbm36sv0U9prK5x/wbgMoplgGZZYn18nWLiu2sE=
X-Google-Smtp-Source: AGHT+IFPSKvqdnPt5S47t9WY4zMaM5qnbMbC24PeJIXAA8fKUzawC6oPVEoq+DoxW92fXI/vX5t3Rg==
X-Received: by 2002:a9d:740e:0:b0:6ef:9dcd:56ad with SMTP id
 46e09a7af769-6f66a59e8f1mr3230956a34.38.1716420701745; 
 Wed, 22 May 2024 16:31:41 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f0e7471924sm4963127a34.17.2024.05.22.16.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:41 -0700 (PDT)
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
Subject: [PATCH 07/42] mmc: dw_mmc: Extract FIFO data transfer into a separate
 routine
Date: Wed, 22 May 2024 18:31:00 -0500
Message-Id: <20240522233135.26835-8-semen.protsenko@linaro.org>
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

FIFO data transfer is implemented as quite a massive chunk of code.
Extract it into a dedicated function to make dwmci_data_transfer()
easier to read and reduce the indentation level of the code.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/dw_mmc.c | 107 +++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 54 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 40b9b034f793..144f29f09240 100644
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

