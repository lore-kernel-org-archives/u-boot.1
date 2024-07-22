Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4D4C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 17:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E6398841D;
	Mon, 22 Jul 2024 19:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w2Uk2D0X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C23884CC; Mon, 22 Jul 2024 19:57:47 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14217883BB
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5c7b6c6a581so2073132eaf.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671063; x=1722275863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGaz0fs9yegy5kcV14Vpei8PrOBWPisherUF76538uE=;
 b=w2Uk2D0XWfPis60l/uDtdYWAChlC1r2Df65BpVFGg12g93fQs1cMt2eV6bAHvCABGM
 p+PC/sN647CNbFVZJ9mlPTu9M9Bdx9zZgO9h7KndV3XwVmHXoxv8FsRgQg+PROfdJS3g
 SvUo4AoFRQnIsgYf/fCeRYGP9PWL9GzNwv6I9PuwUs+/IFsHeR4QCJISwlKasL+yv2X/
 URMeYZhzhP8v3MwVP7vfcs3w+EKbGECQB3hvDgckEgcrsTZTpvKi+422Nw6NWyGs8jmA
 zYL80sS6Lcr+1rpnWjzSbnZp99BpYSx/2UYoML7Gxvx40EVluWVfAD5g17yqRAkcsZE4
 r1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671063; x=1722275863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XGaz0fs9yegy5kcV14Vpei8PrOBWPisherUF76538uE=;
 b=b9s1E9p+d4H2Gcfbc+NlxXL14Bb9bvmGjjCDh8oX/e+m0D9Arz6duin/dBeYOoTHSW
 BkNX7tQmzNc/01NBvceJ0pueFsfVkX5bxHROYSQsb4ADYxp9fyZ+mKPJIzeEUL3K3I9J
 joxR9tZzx82MEQNmfYLNF1GXcpet+RMDvf4pA6CL3mIfnVUGA1sHaCOvl8Y+/Lvk/yPR
 Sd/Fv6EWaBTNi+R165PMPcellCaKLYmL1pTCLdkYkKhv1tHAcN7yIGME3gKra+VrLWOK
 twH6Ehx+1C6trn9gLugs0yyy8ssyS4XonFHIHhWXrckaEBq9pA8ovZ10USdFOioJuDBd
 RvpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFm2/2q9rgQ0v1Ql4B2bjzQFzcRzf55CCeM7CvjK8OwbW802rsdhWr1xV+4AuHbVFALooKUELYkUbJoiUXUc8ELG1HOw==
X-Gm-Message-State: AOJu0YzOrIUEXlq4Jt9zJj7sepop8jP3q17YXMPZosbyHPSB/EnD5fV2
 tWWwUVvX0RIdNss8tz/bl3nD7wcRujXF9TKOZ+dc31E4VahjAlveJN1u9m3o7i0=
X-Google-Smtp-Source: AGHT+IG1cuUBbkDC/QkGcByV31didQemieJ/Nz67EWguvkScC1A/UpCAkq3XdZlSMySQd/wwvwTJuQ==
X-Received: by 2002:a05:6820:278c:b0:5c4:396e:4217 with SMTP id
 006d021491bc7-5d58b5b5a1fmr838230eaf.0.1721671062667; 
 Mon, 22 Jul 2024 10:57:42 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d55aad172csm1473828eaf.38.2024.07.22.10.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:42 -0700 (PDT)
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
Subject: [PATCH v3 02/38] mmc: dw_mmc: Move struct idmac to dw_mmc.c
Date: Mon, 22 Jul 2024 12:57:04 -0500
Message-Id: <20240722175740.6985-3-semen.protsenko@linaro.org>
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

struct idmac is only used in dw_mmc.c, so move it there from dwmmc.h to
avoid cluttering the interface in the header.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
  - (none)

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

