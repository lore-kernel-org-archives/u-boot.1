Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D57BC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACDEC88517;
	Thu, 23 May 2024 01:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yFcJC6Q+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D40C884EE; Thu, 23 May 2024 01:31:42 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64B69884DC
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5b2dec569e3so3098521eaf.2
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420699; x=1717025499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3gboz91R7dbgrRePpjOmuoLxx9XyCXEGmIzVeG6Gic=;
 b=yFcJC6Q+wZ32RKaTDyZTRYpi011+HHBOv3Qy7/Qw2js+jRjaLPqOEwLUhEQ8aXdEFV
 88yntpFMFBFmjdsbUqTtKxe4snAdiLhkTcYRb8r28o5NKg2Jer8geHztLt0RcluJpPGM
 cTvrBHY/WbdE7DSSUvWwgjOcYdARTMzQ3KIE0cKrUDDO52diHylRYhaNh80ii3r9dMFn
 PCZhE85Wn01pAdmVJwJYKqVsq78xKjk4KCYqPMyeMjhBRMSqjY3FUM9oqc5G6gDd7FW+
 nY5+noh3g1IRyGbU7rlO01xypGcXGIce3k2ooaMT8NZY1SUW2i6OhXKGz4bhWL25enGs
 eI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420699; x=1717025499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t3gboz91R7dbgrRePpjOmuoLxx9XyCXEGmIzVeG6Gic=;
 b=Rhe+fOKermRSXGcBdjZKnaeJwfBhyGiR9oXnfzUrMYizkAixiLr5PHlPhCHuNV8t5G
 E1032IaO75v4npFfmx/BimWznfZKAx22UEIValk8etUgd3JPCU3cpFCeaSnzSPq9IADy
 KrDnqMJXH9mll7HwIO+/miSEMubFswlFiqsbNtv+QDEHgqPUl7Y3OkMc1xJKHPkmW7hh
 G0m3PzCPbnmKl76YPD5LhftAHTtwNAHNc/H9rXbDmyQdMzRu+TIku2oueCIrxFleqKqH
 zwZBppn0nX2JK8Pkx4DAQkqnBbS1E57rwd9BpM05M8CfjO6XvvWJpO9fyj8BFvmymAoL
 0b2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHX4aKDJXhp6TZrP3CUi8rxrbVQOKAJ1K7pEoFLn++t96HvZQArxknihaXFkyB9PMYbtAyIuEETDpqF5OO5L7ksoLVIg==
X-Gm-Message-State: AOJu0YyTD+8ztDWa7bV1s8yRyn5gwO6PMs7RjTVb4ucadoaoAteeJAqa
 HeT0l0tFuXsvlVP8YRK+BYc9I1guwXp7ZHcoh7ocZqaYEC3W8BfYHuQZdjcGkBs=
X-Google-Smtp-Source: AGHT+IFnQm08dH5vzG3EmlIF9EK2M0JvGGvWs6pQHk2O1unCitWBggk5C3GCUEYZaFQsK9YEXesZBQ==
X-Received: by 2002:a05:6820:618:b0:5b2:ff69:9814 with SMTP id
 006d021491bc7-5b6a0c10983mr3503553eaf.2.1716420699073; 
 Wed, 22 May 2024 16:31:39 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5b539ff2464sm1334312eaf.8.2024.05.22.16.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:38 -0700 (PDT)
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
Subject: [PATCH 04/42] mmc: dw_mmc: Extract waiting for data busy into a
 separate routine
Date: Wed, 22 May 2024 18:30:57 -0500
Message-Id: <20240522233135.26835-5-semen.protsenko@linaro.org>
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

Waiting for data busy is a logically separate operation and should be
implemented as a separate routine. Follow Linux kernel example and
extract it from dwmci_send_cmd(). This way it doesn't clutter
dwmci_send_cmd() function, and can be reused later in other cases.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

