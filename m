Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9483C52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B767088A83;
	Thu,  8 Aug 2024 05:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QBC9gp2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BF8788641; Thu,  8 Aug 2024 05:14:54 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9955A88641
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5c6661bca43so326329eaf.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086888; x=1723691688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRCqD5v1ORpY/kJffGm3A2945sYGmKt5zChbimK5q7M=;
 b=QBC9gp2t6bba8xUEeUvLAeLYKUzoT8B7whRHXTkUi3OXJAX8izhyTRIY6fXA8ZDZOV
 1uorl78+wDQNCts1aZEqKM1UsUsGJTTN5KPslUNzvv85AShIKIFmAeuhsxMW2a95FzZl
 mDCp8zLmq2nG4ZFO0KYGl0pzbaAKENkc53Dl8cEq8uzj8VECxnd0vRzmxksoYw21O4aI
 m9hplIT7EJ18B84bVkPkUJ26ZxG1w+NkpT+QvIwHAk55j0/pJ7mlapsQU1SIeeS6Y1n3
 WV/wOBhm4Wb89dmUWNqX5sSvsipgDgjWL/oUQS4KdRms0E2K8SLEGgRjHAKumRtl8vUW
 g7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086888; x=1723691688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FRCqD5v1ORpY/kJffGm3A2945sYGmKt5zChbimK5q7M=;
 b=XVBbDotl/RIRC5471aNQtJVGXKbA1OA1ZDuurFaj58G1uej+cqTmJ9vpqpf1um1tl8
 nn45Aw3kn1wLpb6046x5KGZnmWnw7eezBIrbhfZlkPza7Lz1ZwRmh12G9+QWDnwELjhq
 n1SKST+W/kwT+/XQ9MWpQPooMewb8DX/td6IaTOwNIlszkW6RqXw521OMQNEoF84/QZv
 bugPb3GWpuwD3fyD3alspm4lFuWXOp/wQL4vn+AGjgvhhhMZ2GD9lZrzlWXkc4/05jBZ
 SOf6fbqUfb7c54RUvMWW9nFzANiJZSJ2y5+ajVnDVmMAYqSzeJndDhO8EVJSikgU/8Nx
 52CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAo1zw8OL+VTydj/Y/dwelsvC6PMvTW23i+PGJeN6mfF/KnONuIhrKHWg2r+/5vlgSvhXv4LG0/T+6U7+eM53lmy9xQA==
X-Gm-Message-State: AOJu0YxV8PwFVlRcvDDEOTvDc0N101M83FKqslCW+L7ofGingsKDzOi0
 aiqAYtdmTR9akqmskPSCij0L1hE5Aev9uaWgqsZjykNP34hKJ6jzdjCoJ43S1ZE=
X-Google-Smtp-Source: AGHT+IEHWz/bE5JXHfX++OMQuVjjxPjYS9b0c/rAjQBgjLIX2Y4lC9T/+pWotCRA29r3eo1bn/T3Vw==
X-Received: by 2002:a05:6820:2782:b0:5d5:c3a9:4010 with SMTP id
 006d021491bc7-5d855bd447fmr667311eaf.5.1723086888184; 
 Wed, 07 Aug 2024 20:14:48 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d7478b084csm3481820eaf.0.2024.08.07.20.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:14:47 -0700 (PDT)
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
Subject: [PATCH v5 04/38] mmc: dw_mmc: Extract FIFO init into a separate
 routine
Date: Wed,  7 Aug 2024 22:14:10 -0500
Message-Id: <20240808031444.9619-5-semen.protsenko@linaro.org>
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

Move FIFO threshold initialization into a separate function to make
dwmci_init() more readable.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v5:
  - (none)

Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - Added R-b tag from Quentin

 drivers/mmc/dw_mmc.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 395b699b0a0a..4a9e57165fbb 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -538,6 +538,20 @@ static int dwmci_set_ios(struct mmc *mmc)
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
@@ -562,16 +576,7 @@ static int dwmci_init(struct mmc *mmc)
 
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

