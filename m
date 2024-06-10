Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19434C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2FDE8844C;
	Mon, 10 Jun 2024 03:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HjQTgRqk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE5308840C; Mon, 10 Jun 2024 03:12:32 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32A128841D
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6f8ef63714cso2113039a34.1
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981949; x=1718586749; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QfopE55UdYqTHl0ZSw6yaRaxTdvu4b9RkdayIjD6Dd4=;
 b=HjQTgRqkKBSKemX3+YAZdMwjpLKmWBD3rsJoMc3Ehsoyw+kaZ6wQifvzfEhuHmUCWT
 KcYWFvPVOHB2VEyBx9oCw4H5IZPf3c8FCI44CbPLU6jKQnay/SqDh5kY7t2JTbxZkY7m
 xGWBMo/8KWsQkju5s60LzeIGPdYYyt9o2a/Qn5tNkh7KmGibRPJgKq1q6N+EyHFu33vG
 RDGPe6f/PeXG4u6mRKmO2qt3vI3Y15cgg7L/WP4SiQezZcEaVC+Fj4QTAtHXl0T/1Ooq
 rF512245bYo6nG4O2L31LSe4jfnReCG8wFaunDL5wLr5bT+M+5MD0/W2G22Sjb//bb+u
 Oh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981949; x=1718586749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QfopE55UdYqTHl0ZSw6yaRaxTdvu4b9RkdayIjD6Dd4=;
 b=Djk0/7Nmz6I/o7rXDPjWQM6KFAQE+IFcIJASXcyA8jqOrp/O1oXW2+5nn9gwwXtZ9C
 C9Ig0vhi1qZAlAKRtRVEcrZkOtvhDYSC0HAFT6Sl0JD/lUKJfjHRzVQkoRkSSQR+0PHD
 hRKe59HvGbk299BeTelA24zr7y2vWEC9lrXyOBpYmDMWRIE3pX0We4PDPfsfiUpWMFQh
 Vo0OctD77ioiKBiKjgqnOJ6ZOAxEo0kOzZ5g2DNMw4B2JoHJR6oy3A0wWEJYr7IdBBhU
 T66kMeI8UFFZ8o6J3mXIfiLKkvzM32K/jnysdEPFjSeolUXp1XVcT1pgbWyV9imncDxA
 mGAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTKnys06YFv6+VXNnR34RF3Lkw595h76Y4fWhIYKwJH6l5fMaJ0Pmr+LMSKHE5D/aOtdfa/+fEAYQponOkg19QX1LFRQ==
X-Gm-Message-State: AOJu0Yzh0w5RM2BenjrnM07CHEpSYn+qTfUa2Fn7syedQeP3QyUsgXGi
 7Ealuq3ME9O19fC8X8zYWDPvPw1qZYE29Po73xSF0RsMVbYvVyDnO/mph0/ysCY=
X-Google-Smtp-Source: AGHT+IE5qU37gkUuk3uwcUWE63MJrHu3e6nUcgAE4He3UWUTk2pRJDJ2sQpJTpxsNGbMQbwgEc0zFg==
X-Received: by 2002:a9d:628e:0:b0:6f9:79bb:b3ca with SMTP id
 46e09a7af769-6f979bbb8acmr5348119a34.22.1717981948972; 
 Sun, 09 Jun 2024 18:12:28 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f9903b463fsm565499a34.28.2024.06.09.18.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:28 -0700 (PDT)
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
Subject: [PATCH v2 03/40] mmc: dw_mmc: Move struct idmac to dw_mmc.c
Date: Sun,  9 Jun 2024 20:11:49 -0500
Message-Id: <20240610011226.4050-4-semen.protsenko@linaro.org>
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

struct idmac is only used in dw_mmc.c, so move it there from dwmmc.h to
avoid cluttering the interface in the header.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
  - Added R-b tag from Quentin

 drivers/mmc/dw_mmc.c | 7 +++++++
 include/dwmmc.h      | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index e6107c770fe3..9d668b3d8813 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -20,6 +20,13 @@
 
 #define PAGE_SIZE 4096
 
+struct dwmci_idmac {
+	u32 flags;
+	u32 cnt;
+	u32 addr;
+	u32 next_addr;
+} __aligned(ARCH_DMA_MINALIGN);
+
 static int dwmci_wait_reset(struct dwmci_host *host, u32 value)
 {
 	unsigned long timeout = 1000;
diff --git a/include/dwmmc.h b/include/dwmmc.h
index 39024fb38aaa..7e4acf096dce 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -198,13 +198,6 @@ struct dwmci_host {
 	bool fifo_mode;
 };
 
-struct dwmci_idmac {
-	u32 flags;
-	u32 cnt;
-	u32 addr;
-	u32 next_addr;
-} __aligned(ARCH_DMA_MINALIGN);
-
 static inline void dwmci_writel(struct dwmci_host *host, int reg, u32 val)
 {
 	writel(val, host->ioaddr + reg);
-- 
2.39.2

