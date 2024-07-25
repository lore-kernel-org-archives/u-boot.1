Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934AEC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55877884AC;
	Thu, 25 Jul 2024 22:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R3NLLRQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 077CC88370; Thu, 25 Jul 2024 22:45:27 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1D6E88100
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7093472356dso192395a34.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940323; x=1722545123; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEaa0UgmA69sOJlXSnUibgJNWjLQa8i6ZNCcPfHIwDw=;
 b=R3NLLRQo//LXglPTVb03qNy0zQ68bXGDXjYVe3G1y+oJjHIvoM61rGUHXlgUN+UPe5
 Pa5HdcGcfdzRJoJyY5rYranNX6qrnlyO/Kd4y1HuvIHcBL5EPVAJwMJdQ50anE+Oj/O2
 neKU9F05O/F2HaxJij8ZC5JJGz6/yCP2a60B7NPuO/0u0OR+pkHfUyrYNmuoSbOsIjz+
 pZL/7KxKWto4QyLl4gmrpqUWy1jLdeF2OsuAX3PqTcjuYxkKKWPb8qNWAu8O6HwZfurK
 Si+RxniVuXdaAx6B51nDBOUdTTFCvKDXDA+LFdsZhwG+wx/VcrlMwEGbaI4sQjKVsLtN
 8R8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940323; x=1722545123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AEaa0UgmA69sOJlXSnUibgJNWjLQa8i6ZNCcPfHIwDw=;
 b=fxIv7Cx4P6ka3rTfvbAm6xcEy78GDIV09CE9u8iAWT92JYrzflBphqfZaJ6j4CKpum
 ADNNDj9fO//Ch6Pi1EvRgDE8F6UKIkVbMVLhuxIrKmqRk+tm8bDZGHiJBZRjnUiJKw/E
 e1qSoz9YrjcQkV7vb8ZuusinlwcLPOdfGpQDd+7CWE5WixyIoNLb66TOuWOYRMb7o9DQ
 +6O0PsXsv1hfy+Xh9YZfq4DKuBPYKVq1IeGLjdpv+q4eVZFm5TK1RXNL03BMGtymyKfP
 6u02LPjrFQUrPtAiNTtR1WUWKzZfFh8idXQZZWRIw6/58EyK2KVUdC7D1IY/5yQbBIx1
 KZpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2EBu511H34Zj9Js+biO5oMfMRUV5Z19r8x4I8n+m6O/qijXVM2Osf7on0JgKzWMlg7uNxq0hG55rYyGC+0o1nLJh6eg==
X-Gm-Message-State: AOJu0YyL12PB3Q7ky1NIK3atzZFSA2gZ0vnZOANLU735dzkmBDN0YriU
 0S6sGo+k1om/6khSNok2uMKsquelnXpk8YZ/bAbayIIHxot5875QYqyshESyKHk=
X-Google-Smtp-Source: AGHT+IH4tB6H09yr3c6KlcbLaLr5BrYwpoKX9AfMatRVS8fIYo9DlzAOIPfS+jMdsPngZ4ZQ+aCrzw==
X-Received: by 2002:a05:6830:6d0b:b0:709:2752:4523 with SMTP id
 46e09a7af769-7092e6c7fd5mr6331598a34.8.1721940323589; 
 Thu, 25 Jul 2024 13:45:23 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70930778069sm454759a34.59.2024.07.25.13.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:23 -0700 (PDT)
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
Subject: [PATCH v4 03/38] mmc: dw_mmc: Extract waiting for data busy into a
 separate routine
Date: Thu, 25 Jul 2024 15:44:45 -0500
Message-Id: <20240725204520.18134-4-semen.protsenko@linaro.org>
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

Waiting for data busy is a logically separate operation and should be
implemented as a separate routine. Follow Linux kernel example and
extract it from dwmci_send_cmd(). This way it doesn't clutter
dwmci_send_cmd() function, and can be reused later in other cases.

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

 drivers/mmc/dw_mmc.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 45665e517068..395b699b0a0a 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -245,6 +245,21 @@ static int dwmci_set_transfer_mode(struct dwmci_host *host,
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
@@ -259,19 +274,11 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
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

