Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F67C54E64
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 02:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DAEA87F70;
	Tue, 26 Mar 2024 03:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="QWHQmdld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B47487F7D; Tue, 26 Mar 2024 03:30:18 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E272187F69
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 03:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-60a434ea806so55332907b3.3
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 19:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1711420214; x=1712025014;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=paavA9sLtxn0i9ch2Vv/gHx3HMlLnuMHjfV5gfIve+k=;
 b=QWHQmdldrSJXN3yN0xYPuf85oMWHf5TBf2fi4lFU5dXgcR4BqD4+S1BTr9qwjdAeTY
 3YlUiSFhoFmUtd651J80PSHeB+GvzR8kuIdta8oBPhBTDIiPNzYRdeDtN5kbE46IMBf4
 G9L5oEL0JtvOf9EyMeSpQDekWeoDFuO8xS62D7pwyhA/odw/kJKGIbCkdm24dECRfqiz
 9cPECDKVvZ+l4rYK6stKhNLVYZLCI5CDCeK4xFjzq8Ng4+KVqmIGNpKbFt8qCwQ/xsQn
 R+qEEfppzWGGMbFWpJm/zvQsh93kpOmLzecNYUZAqwochXLtDp0Vr477NrXnWx4ZY8D3
 99rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711420214; x=1712025014;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=paavA9sLtxn0i9ch2Vv/gHx3HMlLnuMHjfV5gfIve+k=;
 b=MsRK7ZiqvSAs+1VKcY2HurXrNDkzExHIzRRvVpsfbrhPduHMuE/CjCZkyXcTgkAeRg
 1qFvJb4WaKhvj32+h2jPUPKi3kpmJ63o+TRC13zdZOqp/liM43RgCmaTov3DtJYDZ7xg
 mk+DDXEcbBBZ/CZfaI/oKYqkvDtSZQE051liABuotOjrFReYsT2ndWkkaYEj6rsBtLXR
 4cu5K0IbDpuGfvvCpRqe11z5JvwTCFrJIK8ynr7IQ2DvU5jpobxmqFx7nE+oI7Wb2Di7
 0nsr/G8pXZk+VfD7HQFRKzPGwD22FcWlabS4s5ya5XCF+5sQtAnVlFWMNnkGV/5HpsRF
 oYzg==
X-Gm-Message-State: AOJu0Yzu5zgtXEbj98pSQZusDKFtEFNM8t/l3h3Hz6J5TbV1aOyfkRJn
 FVFfbmEZbP0ZdKWJZJ1zCeANITu92XtjMJ1H2OgV140joRHGvUavy1h6ptaAK19tluOtS4ff9y9
 cpQ==
X-Google-Smtp-Source: AGHT+IEK5FqeJEAHMJe59PV5mbKBgXan1JD60s1r4rfoeNF7s+4GtrZWdOyW5a2e5eo/oeOwFmUHvQ==
X-Received: by 2002:a0d:d588:0:b0:60a:1897:7de7 with SMTP id
 x130-20020a0dd588000000b0060a18977de7mr8625972ywd.7.1711420214567; 
 Mon, 25 Mar 2024 19:30:14 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 em11-20020a05690c2b0b00b0060a379ff698sm1256285ywb.33.2024.03.25.19.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 19:30:14 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Greg Malysa <greg.malysa@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Geis <pgwipeout@gmail.com>, Sean Anderson <sean.anderson@seco.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] mmc: Support 32-bit only ADMA on 64-bit platforms
Date: Mon, 25 Mar 2024 22:28:08 -0400
Message-ID: <20240326022812.2723-1-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
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

Some arm64 platforms may include SDIO host controllers that
only support 32-bit ADMA. While the Linux kernel detects which
size is supported and adjusts the descriptor size used dynamically,
the previous u-boot implementation statically selected between the
two depending on whether DMA_ADDR_T_64BIT was defined. Because the
static selection is already in place and effective for most platforms,
this patch logically separates "64 bit addresses are used for DMA on
this platform" and "64 bit addresses are used by the SDIO host
controller for ADMA" in order to support the small number of platforms
where these statements are not equivalent.

Using 32 bits is opt-in and existing 64 bit platforms should be
unaffected by this change.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>

---


---
 drivers/mmc/Kconfig      | 18 ++++++++++++++++++
 drivers/mmc/sdhci-adma.c |  2 +-
 drivers/mmc/sdhci.c      |  9 ++++-----
 include/sdhci.h          |  4 ++--
 4 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index cef05790dd..4538286c64 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -495,6 +495,24 @@ config SPL_MMC_SDHCI_ADMA
 	  This enables support for the ADMA (Advanced DMA) defined
 	  in the SD Host Controller Standard Specification Version 3.00 in SPL.
 
+config MMC_SDHCI_ADMA_FORCE_32BIT
+	bool "Force 32 bit mode for ADMA on 64 bit platforms"
+	help
+	  This forces SDHCI ADMA to be built for 32 bit descriptors, even
+	  on a 64 bit platform where they would otherwise be assumed to
+	  be 64 bits. This is necessary for certain hardware platforms
+	  that are 64-bit but include only 32-bit support within the selected
+	  SD host controller IP.
+
+config MMC_SDHCI_ADMA_64BIT
+	bool "Use SHDCI ADMA with 64 bit descriptors"
+	depends on !MMC_SDHCI_ADMA_FORCE_32BIT
+	default y if DMA_ADDR_T_64BIT
+	help
+	  This selects 64 bit descriptors for SDHCI ADMA. It is enabled by
+	  default on 64 bit systems, but can be disabled if one of these
+	  systems includes 32-bit ADMA.
+
 config FIXED_SDHCI_ALIGNED_BUFFER
 	hex "SDRAM address for fixed buffer"
 	depends on SPL && MVEBU_SPL_BOOT_DEVICE_MMC
diff --git a/drivers/mmc/sdhci-adma.c b/drivers/mmc/sdhci-adma.c
index 8213223d3f..474647c3fd 100644
--- a/drivers/mmc/sdhci-adma.c
+++ b/drivers/mmc/sdhci-adma.c
@@ -22,7 +22,7 @@ static void sdhci_adma_desc(struct sdhci_adma_desc *desc,
 	desc->len = len;
 	desc->reserved = 0;
 	desc->addr_lo = lower_32_bits(addr);
-#ifdef CONFIG_DMA_ADDR_T_64BIT
+#ifdef CONFIG_MMC_SDHCI_ADMA_64BIT
 	desc->addr_hi = upper_32_bits(addr);
 #endif
 }
diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 0178ed8a11..b27ce57d96 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -900,11 +900,10 @@ int sdhci_setup_cfg(struct mmc_config *cfg, struct sdhci_host *host,
 	host->adma_desc_table = sdhci_adma_init();
 	host->adma_addr = (dma_addr_t)host->adma_desc_table;
 
-#ifdef CONFIG_DMA_ADDR_T_64BIT
-	host->flags |= USE_ADMA64;
-#else
-	host->flags |= USE_ADMA;
-#endif
+	if (IS_ENABLED(CONFIG_MMC_SDHCI_ADMA_64BIT))
+		host->flags |= USE_ADMA64;
+	else
+		host->flags |= USE_ADMA;
 #endif
 	if (host->quirks & SDHCI_QUIRK_REG32_RW)
 		host->version =
diff --git a/include/sdhci.h b/include/sdhci.h
index a1b74e3bd7..07b84d6715 100644
--- a/include/sdhci.h
+++ b/include/sdhci.h
@@ -294,7 +294,7 @@ struct sdhci_ops {
 };
 
 #define ADMA_MAX_LEN	65532
-#ifdef CONFIG_DMA_ADDR_T_64BIT
+#ifdef CONFIG_MMC_SDHCI_ADMA_64BIT
 #define ADMA_DESC_LEN	16
 #else
 #define ADMA_DESC_LEN	8
@@ -319,7 +319,7 @@ struct sdhci_adma_desc {
 	u8 reserved;
 	u16 len;
 	u32 addr_lo;
-#ifdef CONFIG_DMA_ADDR_T_64BIT
+#ifdef CONFIG_MMC_SDHCI_ADMA_64BIT
 	u32 addr_hi;
 #endif
 } __packed;
-- 
2.43.2

