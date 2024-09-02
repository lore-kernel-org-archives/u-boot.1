Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A436CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 13:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C637C88C1C;
	Mon,  2 Sep 2024 15:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Pnl98jT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84D9088A3C; Mon,  2 Sep 2024 15:13:37 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA9A088C1C
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 15:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42c7a49152aso21059795e9.2
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 06:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725282815; x=1725887615; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bE63JmFfQ0+Ab7/OwcOGltljG+c7yJ/ppoXquDcYrR4=;
 b=Pnl98jT47zdg83qWU8mZhtUP0KEuQu9+LaVAE9Rdq8CNKuUd4+PlA8TPb1haBQOHPf
 7idhDhij4gEkw/K28MiQHfPb5kTh7XwhWtTVHNBGOrGV1dgdbgGlEMwq+YrYUl+ERAsD
 OD16ylYgJDoRvNGmpGNBwruyjdyq+a//thBJ2cDBc8qnvtN3GxBfx6x2r1W5IApuU9pS
 XLlTas6fwKzd38ueKJ+e1h/wDWwurRdIbxNTZTIeQ/uU6JEdmCnz1zRiT+VD/3efBoWt
 PSiy6nEyvWOsjGOw9cnVULPrs7CHVInb7IoAiohLZyBcZv5dPDnlE1qTT77pxiavCVl1
 SBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725282815; x=1725887615;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bE63JmFfQ0+Ab7/OwcOGltljG+c7yJ/ppoXquDcYrR4=;
 b=nLAT2dr7tFQPEv4jT04zkzY0KX1Km73tZVB5fu49fOvplvz/WMae0CcbpYBo9uu9fE
 EGgnfsEywvfHnN5g4cas72DjM+eZsSYcfusUZFeGPgE4e8PE+hmdHiWLUkLq/uc0zn8t
 KTs3hMukZM/CihsSJzs6kFH6b75zrTCoL2r7gQ3eIJJM6qZmcXxnVcA9Dv39A0g2OKn0
 lv1vkNSo8KvpXuEhhppKhz3Sox3Fr5HiFM5Ot6w6ve8X8cO73DzglxNYt2CQCNVwBr3q
 U3AmvQ5KjRkXkT7QazOsxRp91QZqkPt79IKUMK34r2BWR1lMfAa/bw6iu19n0e7qT/3z
 BrTw==
X-Gm-Message-State: AOJu0Ywy3a7H0foi/59ltrRuolXt/HA2lVF+DjtNs+VZy1VxvHboNn+J
 T+5a74McvTNBEDGrlE1ngEjgrjlF2tfJQfSujdgu3xY4qYQcs4xQjOOozyA0Rk0Y4C63G4rzhT5
 3xqclBg==
X-Google-Smtp-Source: AGHT+IHigYj+I6SKsKS2oi1nOwaLrUniVo03ZbILbrCvIM8jSo6sod7v41roYNe5fRqp1XYYhsmjRA==
X-Received: by 2002:a5d:570e:0:b0:374:c318:2190 with SMTP id
 ffacd0b85a97d-374c3182363mr3839831f8f.59.1725282814724; 
 Mon, 02 Sep 2024 06:13:34 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c08e07b6sm6229388f8f.63.2024.09.02.06.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 06:13:34 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 egnite GmbH <info@egnite.de>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] configs/ethernut5.h: define CFG_SYS_I2C_RTC_ADDR
 unconditionally
Date: Mon,  2 Sep 2024 15:12:46 +0200
Message-Id: <20240902131246.127897-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

The PCF6563 RTC driver needs the I2C address of the chip on the board
to be defined as CFG_SYS_I2C_RTC_ADDR. ethernut5 selects this driver
but defines CFG_SYS_I2C_RTC_ADDR only when CMD_DATE or CMD_SNTP is
enabled which is clearly wrong. The condition should be on the driver's
Kconfig instead (#ifdef CONFIG_RTC_PCF8563), but there is no harm in
defining the symbol even when the driver is not selected, as all other
boards do. So just remove the condition.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 include/configs/ethernut5.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/configs/ethernut5.h b/include/configs/ethernut5.h
index c327bbbe07d..338306dfe08 100644
--- a/include/configs/ethernut5.h
+++ b/include/configs/ethernut5.h
@@ -55,9 +55,7 @@
 #endif
 
 /* RTC */
-#if defined(CONFIG_CMD_DATE) || defined(CONFIG_CMD_SNTP)
 #define CFG_SYS_I2C_RTC_ADDR		0x51
-#endif
 
 #define I2C_SOFT_DECLARATIONS
 
-- 
2.40.1

