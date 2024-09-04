Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB01FCD4842
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 02:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00B4F88C85;
	Wed,  4 Sep 2024 04:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i+s+fct+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29CBF88AE8; Wed,  4 Sep 2024 04:43:51 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E89D988CAC
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 04:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7c6b4222fe3so3984885a12.3
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 19:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725417826; x=1726022626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTghTHgOL9klUjcIzsvtl5NavVZJ627+yZ7Dt+mlBck=;
 b=i+s+fct+wNIdo7k7AZ2aMb41ZrCgUX2os031h6t7k6PeWF6Pw2FPurUG31pbk75e72
 eU2TKOZDUy9w+LIZq3c1EmT5FRaixvhx6i/8uvCLLvl8pKzsibJXHAGWVahFi9nGhmtc
 dlSUNdknLelb/BjWSJG87edNBEOvbCQY4Oxilny2ZhtXDTMPfL0YPKEe/+wcIGHRsVmH
 6gdsR53gIDVLWj+9jheSmNV5Onwbc8dK22gRyhMd81TCS5wQtidIQM6HmkS7qP9+kpYl
 crGc+UtYwOaj1bf/iNEz/q6SPf26gqUyUHrJO+i8hLwej1CbLIiFK1xzaWyaeDxEqYnD
 rMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725417826; x=1726022626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jTghTHgOL9klUjcIzsvtl5NavVZJ627+yZ7Dt+mlBck=;
 b=fCJHJl8VGIl0mngdusEm6Bl2DvI1fG3a7XEftgitxffVf8EqWdVMY0m62BVzSZYxRR
 IFErFva1G4akh/Vb3O9fxPHNsd2T4RszlWMVwrlZKJyIPwbFmhDM/btL/Fx8vdRhgiel
 pJ4MieXbOdQNlOMRC6KyG/lzV1hXmBlvbnUc7KV+Afrc+o5t9tDJ+M04w4Yuyg+h3NCb
 ME/HYmmJuHlcOcYTwtu+guIQ2aB7XDC6gpe8SF7uRMpQj5KfJtzBqzpQ3mR9df4WyMwx
 wS9Fmdy0I27sHI8BXPyE+Q92ev/IvNKApfQfF8A5A0IhsBC3ZYogfgQTUBoTe6FgJbwL
 qvPg==
X-Gm-Message-State: AOJu0Yz67jRRfnBfR1zGI45rR3JV4G69LNWyObuhzaTSojXOnefiZk46
 gTnU47dVGgf9fQvtZ8TNkcJzhhx5VBdCCCFIFEu2+DR8E0CT34Z4
X-Google-Smtp-Source: AGHT+IEGn0z7gVuSCoTfsEjO4VkYYyEB/7BG2jJ7L1HFNwAl5WzpC7aR/tgOT2eYEEI31wk0btRm1g==
X-Received: by 2002:a05:6a20:2da6:b0:1ce:f2e6:c5e9 with SMTP id
 adf61e73a8af0-1cef2e6c5f8mr6262995637.1.1725417826265; 
 Tue, 03 Sep 2024 19:43:46 -0700 (PDT)
Received: from cs20-buildserver.. ([180.217.139.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2da7ba49b57sm1141829a91.18.2024.09.03.19.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 19:43:45 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	trini@konsulko.com,
	jim.t90615@gmail.com
Cc: u-boot@lists.denx.de,
	Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v1 3/3] pinctrl: npcm8xx: clear all gpio events
Date: Wed,  4 Sep 2024 10:41:06 +0800
Message-Id: <20240904024106.2030437-4-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904024106.2030437-1-JJLIU0@nuvoton.com>
References: <20240904024106.2030437-1-JJLIU0@nuvoton.com>
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

From: Stanley Chu <yschu@nuvoton.com>

Clear all gpio events to avoid unexpected interrupts
during kernel booting.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index ff49819b58..67e564f85c 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -48,6 +48,7 @@
 #define GPIO_OES	0x70 /* Output Enable Set */
 #define GPIO_OEC	0x74 /* Output Enable Clear */
 
+#define NPCM8XX_NUM_GPIO_BANK	8
 #define NPCM8XX_GPIO_PER_BANK	32
 #define GPIOX_OFFSET	16
 
@@ -967,6 +968,18 @@ static int npcm8xx_pinconf_set(struct udevice *dev, unsigned int selector,
 }
 #endif
 
+static void npcm8xx_pinctrl_clear_events(struct npcm8xx_pinctrl_priv *priv)
+{
+	void __iomem *base;
+	int i;
+
+	for (i = 0; i < NPCM8XX_NUM_GPIO_BANK; i++) {
+		base = priv->gpio_base + (0x1000 * i);
+		clrbits_le32(base + GPIO_EVEN, 0xFFFFFFFF);
+		setbits_le32(base + GPIO_EVST, 0xFFFFFFFF);
+	}
+}
+
 static struct pinctrl_ops npcm8xx_pinctrl_ops = {
 	.set_state	= pinctrl_generic_set_state,
 	.get_pins_count = npcm8xx_get_pins_count,
@@ -1001,6 +1014,11 @@ static int npcm8xx_pinctrl_probe(struct udevice *dev)
 	if (IS_ERR(priv->rst_regmap))
 		return -EINVAL;
 
+	/*
+	 * Clear all previous gpio events, otherwise it may produce
+	 * unexpected interrupts during kernel booting.
+	 */
+	npcm8xx_pinctrl_clear_events(priv);
 	return 0;
 }
 
-- 
2.34.1

