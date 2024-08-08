Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2EAC3DA7F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A302288A3D;
	Thu,  8 Aug 2024 05:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R1RK8ZW0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38D4C88A6D; Thu,  8 Aug 2024 05:14:53 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EF698874E
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7091558067eso254255a34.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086887; x=1723691687; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVLQcVSfl3rm2iwTcFthBnCn85I461ALqaeyLfaSK2k=;
 b=R1RK8ZW06TBpEO+blvsjhJjAGbdieACxhsaxQYy3opjLbSv6gUS2X/3E/1IFwgBjR8
 Tk4lz09tvG6w2P7asx8CCYw2VLeLppoE9YZ+cNi6BCwZx8QVdzLCu1oLhSTiRfXH/e2N
 UHUE3qEe19Asg7QqTdlRmQrxUwfq7un4xsCzZXOBuXsHSGw4Q3G+nl3QUQMtvKCS1D20
 k0U+ZrN8p5rt2THARfUMgUOYHKQOTalcw05YaOVLYH05tfTbFfP+2f3nPRPTdzocVZdO
 KO7ao2cp21Kqvl4c29bmggjTyHKiJ7wSFSix4peii4Q7tZsEtg2TNxLH9gLGCni4Hm/F
 UeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086887; x=1723691687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eVLQcVSfl3rm2iwTcFthBnCn85I461ALqaeyLfaSK2k=;
 b=kJ02aR45oSEmsfCiOhhEUYvjGhi+SbkRCYZGNLDL/xwNQqU0FjvkhrUvcMZ5p1JQPU
 vKXM+h7ndUGVp39NKnxTeOg3DATJYiZ4gIPlwADxdTSNQVpaALVG8wMP86wh06Wso+Wn
 K6y5MSfaQnSB/nsoiRwPucmWrkZNrWXprKghJJbifFbWx53fh9Qkw0J9AJfDdCO4kFy7
 KH1H5l95zgSoC8b7jHa265hHiPr3U30erPg1kkgrgHKuskWL2qP6rDCkpbrc9owrqgV8
 8UWca/eJcLRkhkeDJmTwdQt/it1iuc4WcqskelO7a4stFQb1JjB9X+LkuqFybxckhFB9
 4FkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0L/AysKUn18q4wzzPTuJQ+Jnlfux/IXv7l7ldExIxbrD69iXfo+OhEmdYE3M87dggetYY29lGHvRAibss1YFQqjn+0g==
X-Gm-Message-State: AOJu0YxlME8XzZmfxEYWY5bZ/xilsEwOVaL3Yq5Jxfi2gFlt7baXFE3E
 rhxC58sjXRaXVoonxB8ujYEB98o9QTjlfkEEit4yQmrJwFdIgzLndUCqoYVAaYk=
X-Google-Smtp-Source: AGHT+IFsO1V0NR7MLiHPprWsr7AzvmNPZj/7KZf8agGTsRZkq4jk4ku72zXui9A2N/aw1+uj/AVhlQ==
X-Received: by 2002:a05:6830:6989:b0:709:4507:6b37 with SMTP id
 46e09a7af769-70b4fcb15a6mr713707a34.31.1723086886782; 
 Wed, 07 Aug 2024 20:14:46 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31d9e011sm5154015a34.1.2024.08.07.20.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:14:46 -0700 (PDT)
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
Subject: [PATCH v5 02/38] mmc: dw_mmc: Move struct idmac to dw_mmc.c
Date: Wed,  7 Aug 2024 22:14:08 -0500
Message-Id: <20240808031444.9619-3-semen.protsenko@linaro.org>
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

struct idmac is only used in dw_mmc.c, so move it there from dwmmc.h to
avoid cluttering the interface in the header.

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

 drivers/mmc/dw_mmc.c | 7 +++++++
 include/dwmmc.h      | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index f4ecd7422cef..45665e517068 100644
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

