Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACD1C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25AAB88365;
	Thu, 25 Jul 2024 22:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d8VLEwOX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DF7E88363; Thu, 25 Jul 2024 22:45:29 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3D9688365
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3cabac56b38so189912b6e.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940326; x=1722545126; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JyruwuYRaqPCXBmGPbE2CxHwcU1xW7seIdaP81obB0o=;
 b=d8VLEwOXA6CeLFu/YwHvclpztygdGsU4vgZ40EFVTuS/aynvPoCcD5UIRtu9k1E2eQ
 rlJ1f+KA0Yj5UimNHoPgHhMTObeEJ7djF4uQUUZp1dDZe1etljuGKg5PMNthqXpGxjS2
 qeXcoCsXxUrHUYkVVURMuYb4aT+9OPX0puGgvUT2E4D+wTrRaLgx9lSMjEEajv6BevGC
 kmWFUiheA5fjUgrUnsUHsFHAj4p4TO/i40vSVKGA/f3qvT6zuxmvU9Pq0pZF3zgTIwf/
 GxXdTcjWq/1qgzz+LJ+c0cqo7XQEGRVzbaBvVBc9ucbkczitiZXjHeFnsiTspMUZwU0s
 P6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940326; x=1722545126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JyruwuYRaqPCXBmGPbE2CxHwcU1xW7seIdaP81obB0o=;
 b=G4LCNJeZQ450KuBWviM1TAt8JI8nThRYm9ZDfSBXESvdpVyYxO71h/MRFqzuHlP4FF
 dFh6BwhZ9JGpgaw+No5OQIWTwD4LzDe6yAFsnCh6i39jQx3KDtDc17yHzlzcK4xOGH4N
 YECSxvlUecSdpptcqVMX+y3OqpVVCSEnyu7n9pIe7bNzHZ4F/k/D+bhC4O2B9TyN8/Va
 LCvl50obgirT5fju/ya2Y/2TleFd+lTg565T7tT50daP/tFVXxvZS8Anda4/sYJzp8dd
 f6kwhLousuItN1oVcgwx3Ote2ramHVcLyyziq5foTHi6/jkydGd6XpZYHZTG+j9gLrZt
 0J2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo3u++DWhNY7Is5JJbmwpDg+8Cvmnebi6sutMmynutwShR8AML1jWuNMqAMoWB+V4buDnXeLiqu9AkNOmXclamLbbUsg==
X-Gm-Message-State: AOJu0YxMc0S/bnRvk93jICzND/XQ7kYNEYkoikqaolWG1AbnG9KIw8WY
 F36hzc3s/x63rQkkGRe3IqFDDnONtXyz9rYJMo+iazWtA15VTwssXU2Q6oOJ4z0=
X-Google-Smtp-Source: AGHT+IFVapGXdEVGhbg90lPfkWdnDgYYV5ZGZTLWWRmAAYCob1pKv0wNAusnZTdCKtUo2L4nTsxeyg==
X-Received: by 2002:a05:6808:2129:b0:3da:e0bf:e117 with SMTP id
 5614622812f47-3db10ed1271mr5446031b6e.9.1721940325734; 
 Thu, 25 Jul 2024 13:45:25 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db1341dde2sm430223b6e.17.2024.07.25.13.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:25 -0700 (PDT)
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
Subject: [PATCH v4 06/38] mmc: dw_mmc: Extract FIFO data transfer into a
 separate routine
Date: Thu, 25 Jul 2024 15:44:48 -0500
Message-Id: <20240725204520.18134-7-semen.protsenko@linaro.org>
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

FIFO data transfer is implemented as quite a massive chunk of code.
Extract it into a dedicated function to make dwmci_data_transfer()
easier to read and reduce the indentation level of the code.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

