Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360B9C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0901E8851C;
	Thu, 23 May 2024 01:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ewdw/MOF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B393884EF; Thu, 23 May 2024 01:31:43 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4603C88453
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6f1242f1dcdso3260608a34.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420700; x=1717025500; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9EVRv8bS0w3wESTaeA0XmRalvVP88dkRy96H1dAbcuI=;
 b=Ewdw/MOF4AhP8cOIoO6R77nfPq0CiuXCwVLJj9SQoW1tfO887AD4GduAiIF5QORV0H
 lL3XqvUOB1x/Ktfst6cvOH3KfnRZnxR7zgqD7qs5ynFR9onU27EbPBZC7Tz6A51dCeH+
 T4mMYxHwCZhg2Y9PvYU0LYgNXy/BMg5okyzlJM1W2wezzR/U0AgMiUGL4Ne8VQDYvJ7n
 6WgMR3I6lenVCWpXY7QLuqRNuYZSFWB5A4rjB9yLcUGaoh9+SJ6JUqBYFsnRqFRXdDzv
 nKEkDij6HHU+/lnCzKP7jMMunLds1pK6jLej1CaZZSpjijs1tiPQZovVC5BBWqlR6sN2
 KSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420700; x=1717025500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9EVRv8bS0w3wESTaeA0XmRalvVP88dkRy96H1dAbcuI=;
 b=WyNi0YOBNncMVKqFMSNlNSADtIKEGhPWJMjyT91LpAGeFAHkAHBtFSaH9XXSNJjIwv
 l+wgsz5cN5AFlCXx/Lpx/4ja22NbZLYNQEjEG+Y2GCjxrhRKVk+/0JsFxjMmXq1GU8zs
 IWSDtwESuQ1hMfA0HKyG2GpaS9kMMgY/bMvfpUJEqyw5l7W8soEWD8D+Ow9fG1SQyydD
 wi0O0mNTEf4PLVpXx0hFanmY0ZHJzGyTGRkdfAl19xiM51QRlebB1ezHnU6unECcXGNC
 DkvpZEffWsPZ65v9/3xaRq6Xtq43cY93MQrp+gpGwecTMFsb1LrraMEYOBNuhIeYKNJF
 E+Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVri1B4/zBiUiEkGZPIbSAmM0iHlQP2JL9s0Kkd5WQ6DUBzpMQpnn+P6qyOI6JIxBh64jm7aaLv17J1OYhuDg8ZSE9Evg==
X-Gm-Message-State: AOJu0YwBl6MmeU7URDkHDpaKWhBqKbi0Xv5rEzPoZMq+bNAAYBFflQZX
 N4lb14U1kjHXJigwmf9qlzgvhTJn36/b6PEUTaZsp/w1A3RZbP19I0grzWgb/Ho=
X-Google-Smtp-Source: AGHT+IG1uT154V2/r6MiRpaLFGBaBEww30oDE5u0ygtU5dAJObH/iJWTAIe8LtjTk5AeScWARtj97A==
X-Received: by 2002:a9d:7845:0:b0:6f0:cf72:5d7c with SMTP id
 46e09a7af769-6f669afca6emr3481564a34.24.1716420699894; 
 Wed, 22 May 2024 16:31:39 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f0e49e317bsm5038356a34.57.2024.05.22.16.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:39 -0700 (PDT)
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
Subject: [PATCH 05/42] mmc: dw_mmc: Extract FIFO init into a separate routine
Date: Wed, 22 May 2024 18:30:58 -0500
Message-Id: <20240522233135.26835-6-semen.protsenko@linaro.org>
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

Move FIFO threshold initialization into a separate function to make
dwmci_init() more readable.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/dw_mmc.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index a82f6a96db39..cbfb8d3b8683 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -540,6 +540,20 @@ static int dwmci_set_ios(struct mmc *mmc)
 	return 0;
 }
 
+static void dwmci_init_fifo(struct dwmci_host *host)
+{
+	if (!host->fifoth_val) {
+		u32 fifo_size;
+
+		fifo_size = dwmci_readl(host, DWMCI_FIFOTH);
+		fifo_size = ((fifo_size & RX_WMARK_MASK) >> RX_WMARK_SHIFT) + 1;
+		host->fifoth_val = MSIZE(0x2) | RX_WMARK(fifo_size / 2 - 1) |
+				   TX_WMARK(fifo_size / 2);
+	}
+
+	dwmci_writel(host, DWMCI_FIFOTH, host->fifoth_val);
+}
+
 static int dwmci_init(struct mmc *mmc)
 {
 	struct dwmci_host *host = mmc->priv;
@@ -564,16 +578,7 @@ static int dwmci_init(struct mmc *mmc)
 
 	dwmci_writel(host, DWMCI_IDINTEN, 0);
 	dwmci_writel(host, DWMCI_BMOD, 1);
-
-	if (!host->fifoth_val) {
-		uint32_t fifo_size;
-
-		fifo_size = dwmci_readl(host, DWMCI_FIFOTH);
-		fifo_size = ((fifo_size & RX_WMARK_MASK) >> RX_WMARK_SHIFT) + 1;
-		host->fifoth_val = MSIZE(0x2) | RX_WMARK(fifo_size / 2 - 1) |
-				TX_WMARK(fifo_size / 2);
-	}
-	dwmci_writel(host, DWMCI_FIFOTH, host->fifoth_val);
+	dwmci_init_fifo(host);
 
 	dwmci_writel(host, DWMCI_CLKENA, 0);
 	dwmci_writel(host, DWMCI_CLKSRC, 0);
-- 
2.39.2

