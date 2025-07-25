Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5A2C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A88483957;
	Fri, 25 Jul 2025 14:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pQ+m3hSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F3CF8396E; Fri, 25 Jul 2025 14:04:31 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB0838393F
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b7788749b0so93259f8f.2
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 05:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753445068; x=1754049868; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J61oznRTc6xUqpwqnkdhihpmbSQJZ/T5lVvzOYU9BGQ=;
 b=pQ+m3hSszdTVsARdTy19+TZEfsVjA8EHyxQ3CBG/Tk1iRhQ9KJdVut6Xm6570fJHAT
 fDPOiCmRWt0UP0ehBn4qJ9AkLhJQyrdk4aVyX4sJD2h4lrvU4TfhUmuTDFtC3a5msUBG
 dC62ygVasrGLRTBaLfIAsmd4KgS2UNdgEYtmfIukCtDpj+VB+3wwj5XSp8LZTZvmSZok
 mrLw4DTHxvBEzdkdZ7ChHwI/x/m3pjnWhgevf25Uy13+IJlChxM0opp3VNdR9FgIPUb/
 w2rAIMlIwTkdBPUjBcMiMa/ozHLFX5JHHB4HvDeUiaH4w66t7u4DE6iDEDtVDKt6u/wo
 pbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753445068; x=1754049868;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J61oznRTc6xUqpwqnkdhihpmbSQJZ/T5lVvzOYU9BGQ=;
 b=NcJRB9Y4cjUac8ty7mmICZSbBT2tPXntVO/L8zsNNJHsyb7t4gBt2ZRLCYRPJRenO2
 oahIN3R0UVbgcxdan0TZDtyVyHnCXQfTXLdDy6bcc1Vvcx3xkFBm072izd1OK+PH+x4H
 tksZS+DpT8VSfE5FlBKxJrc1PxxXwMLl6BCHpFksElZH9nlY5fkqlIrjH1D1hx7HtVdc
 aWjgjnu4GCrQZZr+iUm0RebpRZ80mcEZSv0+CGUHezWaBj4nZDOne2EYZmBayASRR1my
 6roG6W8mAbdz2qUMBp/WxXSDhTUVQ1FQsq3iGG3vLAWxlBvxd5sJ5a02SIcMn3/74mAm
 +FkQ==
X-Gm-Message-State: AOJu0Yx5s0j8N5CLsuzstfNfBgn6Dm1VeOq8jpn430GUJDTcXjYFQWoy
 7g2tGjGHNn/2usu5ezuPICFIeequtIVNdpW1OewusqIIWzvnhVE+O5jbpeHFUYoLtf71QT9yoxt
 w8m7DTaY=
X-Gm-Gg: ASbGncv+e5PnvEXKsIW4vfaTKYyvojTtUhc3yK1m52HBemHOHsZcLaIZOM6CMRZLqyX
 EljjiZ2jNS7RA0wP3jdehjY/3vlnhvdG98n0sZ84p3b8SwR613JvOKpHB4bllwdX7Tqt3fttP7o
 DAzWzhbgoN2K2QhK79qwTWirpJQf4zAFgFLOKeFowWz8AdnqfR0CP+Y8yfPLwscNje01YaJ14Cr
 GENnYqCP2tSAlAFOFskCGDHzlgNbzK6LzGM3q/wYsu4Kllj7GH1sOS1K5EA+FF0gPLA+6j+dN/e
 5sNiFdRI3Rgpt+BCk2lY9hwSnxq6208WscyJ7eUwxvyM7r9p1WGGhRKS4UHODloi+Z8+MdrRQNf
 GSWnJvqilZtx/iGvqHBW9RA5G98GVi3tMApHj8L52gfO5zGx+4A==
X-Google-Smtp-Source: AGHT+IHxEC9n6HOuZpN9Yt6sNdsquDKwqD3LxH1bBBcU+cJLgjDiOM2WUwb5K9QFwc5UqcL8o6vNuQ==
X-Received: by 2002:a05:6000:4308:b0:3a4:fc52:f5d4 with SMTP id
 ffacd0b85a97d-3b776780e64mr1587861f8f.47.1753445068024; 
 Fri, 25 Jul 2025 05:04:28 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:707a:1ff:4c94:1748])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fc6d2e8sm4844613f8f.20.2025.07.25.05.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:04:27 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 25 Jul 2025 13:04:26 +0100
Subject: [PATCH] gpio: intel_gpio: Initialise or0 and or1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-intel_gpio-v1-1-20a917eb1cf6@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMlyg2gC/x2N0QpFQBBAf0XzbGutFutXJC13MMXSjKTk3+/ye
 Dqdzg2CTChQJzcwniS0hQhZmsAw+zChol9kMNpYXRqrKBy4dNNOm7LOOFdU2ukshxj0XlD17MM
 wv8nq5UB+xc440vVdmvZ5/oPTwWZ1AAAA
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In intel_gpio_set_flags the two variables or0 and or1 may be used
uninitialised. Correct this by setting initial values in the
declaration.
Also there is no need to use '|=' when the initial value is 0 and there
is only one assignment performed to each variable so just use '='
instead.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/gpio/intel_gpio.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/intel_gpio.c b/drivers/gpio/intel_gpio.c
index 0ab6e8a90bc..ac2fb8bc2cc 100644
--- a/drivers/gpio/intel_gpio.c
+++ b/drivers/gpio/intel_gpio.c
@@ -116,26 +116,26 @@ static int intel_gpio_set_flags(struct udevice *dev, unsigned int offset,
 {
 	struct udevice *pinctrl = dev_get_parent(dev);
 	u32 bic0 = 0, bic1 = 0;
-	u32 or0, or1;
+	u32 or0 = 0, or1 = 0;
 	uint config_offset;
 
 	config_offset = intel_pinctrl_get_config_reg_offset(pinctrl, offset);
 
 	if (flags & GPIOD_IS_OUT) {
-		bic0 |= PAD_CFG0_MODE_MASK | PAD_CFG0_RX_STATE |
+		bic0 = PAD_CFG0_MODE_MASK | PAD_CFG0_RX_STATE |
 			PAD_CFG0_TX_DISABLE;
-		or0 |= PAD_CFG0_MODE_GPIO | PAD_CFG0_RX_DISABLE;
+		or0 = PAD_CFG0_MODE_GPIO | PAD_CFG0_RX_DISABLE;
 	} else if (flags & GPIOD_IS_IN) {
-		bic0 |= PAD_CFG0_MODE_MASK | PAD_CFG0_TX_STATE |
+		bic0 = PAD_CFG0_MODE_MASK | PAD_CFG0_TX_STATE |
 			PAD_CFG0_RX_DISABLE;
-		or0 |= PAD_CFG0_MODE_GPIO | PAD_CFG0_TX_DISABLE;
+		or0 = PAD_CFG0_MODE_GPIO | PAD_CFG0_TX_DISABLE;
 	}
 	if (flags & GPIOD_PULL_UP) {
-		bic1 |= PAD_CFG1_PULL_MASK;
-		or1 |= PAD_CFG1_PULL_UP_20K;
+		bic1 = PAD_CFG1_PULL_MASK;
+		or1 = PAD_CFG1_PULL_UP_20K;
 	} else if (flags & GPIOD_PULL_DOWN) {
-		bic1 |= PAD_CFG1_PULL_MASK;
-		or1 |= PAD_CFG1_PULL_DN_20K;
+		bic1 = PAD_CFG1_PULL_MASK;
+		or1 = PAD_CFG1_PULL_DN_20K;
 	}
 
 	pcr_clrsetbits32(pinctrl, PAD_CFG0_OFFSET(config_offset), bic0, or0);

---
base-commit: 021783860f7e628f7c4e0c101707cd4250e6d61f
change-id: 20250725-intel_gpio-592996809013

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

