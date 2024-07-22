Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409BAC3DA63
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 17:58:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 797B8884F1;
	Mon, 22 Jul 2024 19:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oaZeHI/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17B6A883D9; Mon, 22 Jul 2024 19:57:47 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B73D5883DE
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5d5846f7985so402993eaf.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671063; x=1722275863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WrsM4fGIRFJZwpxDjdxpd7RZs/pDRwGsYnn/StKH7jY=;
 b=oaZeHI/+8HxdtzURHq/2zB2gITqIiAwXGGk7Jja0zVrjpjktgUFd4b5Xxf+AN1sw2L
 7NG/yRHem9vLR+s3Yj+xKaN3t+mDRUnb3SsxfHWGATAdte1o54G3/eLEmlp9GZBgy0ZB
 wDx6GPJwCHkEYuaHHBBU4SuC7VUcLBgjaW60bK2PdCeKFJbRjdRdcHaMQUEtopom9FE7
 GrGtYjkjClCaHuArkTALCh9SbZ0YiL5ZWwsj1hCUssqIIV8gIAoihiRsyHnhrylhyDs6
 eVFI2GpiuxpW6CIyOgsorV5lQWNLqajYzj1Pv0l/297ISLVN4l9yRBbvrAddgT1/9W0m
 VICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671063; x=1722275863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WrsM4fGIRFJZwpxDjdxpd7RZs/pDRwGsYnn/StKH7jY=;
 b=No66tRbkAhPb7sXpyMZQJXF8mSw9wHMtVuCyM4Gj7XJsB3z64vErsCmWHJtJC8prOT
 By3RlPGdxKdrjAtdTzRFLrx74MbaeUIEfeDz+KHqxCiSl4CkoIHw+Jy3tTOa525yuqxN
 QqBoKxY/gDh7eR6XtTGVABRgT9cg9UBq59EQTKo02DTeBIiK20q5nK7/QBUVS72ZEa8q
 QtLuWq+PgrR/UE/94/01GPL2p1H/JykBB5FosNY2MeEEFuIMvuyczsg7a41tVoKxZtOD
 UHz03nWCXnNJ722vu+eCGh0Rb5Zca9l4tDH0KD4gEvel67M+05uNHblrAGwn9D3b/DRe
 6LxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKcTucEIjEG2kRfaA+Al6bGo+jIvlfRcM7Iwpx5xIoE4pqhbWy98+ufiVN9MFXYm/dR15uszAS7VL6QyEL8n0tlwrRMQ==
X-Gm-Message-State: AOJu0YwKdukAwx2M+DEKpxTNiBJ+zgupAVgKUPqabv31Y2bwwyqiob+/
 0+Wfom2UnouxPbkU/vtFb+RaWYzptSNe5ai1zr3nd0m66kvUAFApwBcy2OLnRO0=
X-Google-Smtp-Source: AGHT+IGgaITIbKID14gVFkyhly4FL/zbI0quFTWFwHdmcDIReyi6ikYj8oelUdWy7AQfobATCj0sNQ==
X-Received: by 2002:a05:6820:4c0a:b0:5c4:e036:e383 with SMTP id
 006d021491bc7-5d56500366cmr10446736eaf.8.1721671063387; 
 Mon, 22 Jul 2024 10:57:43 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d55a831b79sm1480335eaf.17.2024.07.22.10.57.43
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
Subject: [PATCH v3 03/38] mmc: dw_mmc: Extract waiting for data busy into a
 separate routine
Date: Mon, 22 Jul 2024 12:57:05 -0500
Message-Id: <20240722175740.6985-4-semen.protsenko@linaro.org>
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

Waiting for data busy is a logically separate operation and should be
implemented as a separate routine. Follow Linux kernel example and
extract it from dwmci_send_cmd(). This way it doesn't clutter
dwmci_send_cmd() function, and can be reused later in other cases.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
  - (none)

Changes in v2:
  - Added R-b tag from Quentin

 drivers/mmc/dw_mmc.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 9d668b3d8813..a82f6a96db39 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -246,6 +246,21 @@ static int dwmci_set_transfer_mode(struct dwmci_host *host,
 	return mode;
 }
 
+static void dwmci_wait_while_busy(struct dwmci_host *host, struct mmc_cmd *cmd)
+{
+	unsigned int timeout = 500; /* msec */
+	ulong start;
+
+	start = get_timer(0);
+	while (dwmci_readl(host, DWMCI_STATUS) & DWMCI_BUSY) {
+		if (get_timer(start) > timeout) {
+			debug("%s: Timeout on data busy, continue anyway\n",
+			      __func__);
+			break;
+		}
+	}
+}
+
 #ifdef CONFIG_DM_MMC
 static int dwmci_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
 		   struct mmc_data *data)
@@ -260,19 +275,11 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
 	ALLOC_CACHE_ALIGN_BUFFER(struct dwmci_idmac, cur_idmac,
 				 data ? DIV_ROUND_UP(data->blocks, 8) : 0);
 	int ret = 0, flags = 0, i;
-	unsigned int timeout = 500;
 	u32 retry = 100000;
 	u32 mask, ctrl;
-	ulong start = get_timer(0);
 	struct bounce_buffer bbstate;
 
-	while (dwmci_readl(host, DWMCI_STATUS) & DWMCI_BUSY) {
-		if (get_timer(start) > timeout) {
-			debug("%s: Timeout on data busy, continue anyway\n", __func__);
-			break;
-		}
-	}
-
+	dwmci_wait_while_busy(host, cmd);
 	dwmci_writel(host, DWMCI_RINTSTS, DWMCI_INTMSK_ALL);
 
 	if (data) {
-- 
2.39.2

