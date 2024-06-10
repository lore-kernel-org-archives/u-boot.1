Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEE8C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3395188415;
	Mon, 10 Jun 2024 03:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O+ftkQ6q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42CE7883E6; Mon, 10 Jun 2024 03:12:33 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1138B883E6
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6f97a4c4588so909601a34.2
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981950; x=1718586750; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+xllyps4gbf32TUxPHwewG9pl28JW9QwciqLLGp954=;
 b=O+ftkQ6qxkhwZP58NPxx7E6f8Ecsfk3oDkMriMqceevYbJFGHDf0JHLCJ1sESVquC5
 mWCUghfdg2zf4axpKs4IQoh5T6MZNvS7rpKOt6IsYSj3BFbGsnt1a0p5LKIhrBDEb1vH
 AZa/SJwgYo7qZnRry8q4XVq/5whMEqwVSIySZN+0qY1ojG3Axoyclf4YqFnWPFMgMCgd
 bbGo0/ll+RATU4WZgmYkSvTrXmm+9lWWRcXJZQwKvhiUJ2dLTgUjXsUOq8YmvxbmQbXN
 BXpVD43EDPVEnwoT35+TiNoam8BZhbFUK90srG3V89l9USHxC+8umBy62xRyjdyUVXvV
 l4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981950; x=1718586750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b+xllyps4gbf32TUxPHwewG9pl28JW9QwciqLLGp954=;
 b=XBoz/sgIMP3RO8259YQOc5esEdi5RZYD8ho2hwoYZa1z7Y41o6br27YBbYSaTv6Jv9
 BQ3A4dwBJpjctvrMj5QV0xIyPhMHfowVrUfGGwVWoinZ0nau3ExByUSfmdmDt6yh7/dz
 FMB1ZSdeJ9dD/TQKP3iWq85OfoyY3+0dC2Ed1qStct2ksbn/r+wmUWGtSKQOc1A1BuGA
 vYYjk+TFmSb+U47fKOvdurDeOx9Z08vROXj8OnXXB5AIkVZzZwxkoHk82A2flmb8Gdss
 PF4OuTyuRoI2hjohdVz8oNpn4AnxO0TsIAvT+TCNDqwfJn1fkIAI/KkmJi2hRcD4e4Jj
 rWRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC6ydU13xNYstBlLhRnGCvIj0lNjusEHpR5GnXvagvZkRE7eYab0YWfjhVJ7YGTK5dSS7U8YqAbsUiLQkHk3fQHPnZ9A==
X-Gm-Message-State: AOJu0YwCrs3ESeBmiyuHTlXhlc6DypliZgh2bkbVoQUW+dSuGC7yFKpa
 +/qRxBS++2IfBA5cFLXDaqjgYaIQ9ajX751nXs2qmk7pHsPtpURzJlFtWJYheW0=
X-Google-Smtp-Source: AGHT+IE650wlDOkdjnJxjpheoxkUKKWxgEtyxgQxIZBu52fzkGAbf/E/GFqr0GmGZqFAFSt040nhmg==
X-Received: by 2002:a05:6870:8326:b0:24c:ac7e:8a5c with SMTP id
 586e51a60fabf-25464c3dbc1mr9448410fac.21.1717981949687; 
 Sun, 09 Jun 2024 18:12:29 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254a3d654c5sm797463fac.39.2024.06.09.18.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:29 -0700 (PDT)
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
Subject: [PATCH v2 04/40] mmc: dw_mmc: Extract waiting for data busy into a
 separate routine
Date: Sun,  9 Jun 2024 20:11:50 -0500
Message-Id: <20240610011226.4050-5-semen.protsenko@linaro.org>
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

Waiting for data busy is a logically separate operation and should be
implemented as a separate routine. Follow Linux kernel example and
extract it from dwmci_send_cmd(). This way it doesn't clutter
dwmci_send_cmd() function, and can be reused later in other cases.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
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

