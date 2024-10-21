Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B98BD1714B
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 23:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C070892BA;
	Tue, 22 Oct 2024 01:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="aOdNA7Jg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D26D88DB5; Mon, 21 Oct 2024 17:05:19 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85E8588DC8
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 17:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so37661535e9.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 08:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1729523117; x=1730127917;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3AJp/ShFQ4+ujpvmll/KciR4DNwT7NaOo8fNK4+6YrA=;
 b=aOdNA7JgQ4y0SaVHjrnlq1r6RvX03kIZKd2mURPbCBsogzHpDerWCQaGoK4mO3pC+u
 e76K2RH6ILj+mb5796IiVvckFVjhhD3uEYrkRUvNuFpvbY2E79mHgx/KOTjJTTQkdnEb
 OjgXtcGX7zAUZVhrNvktIkDUrWsTG/MyKgewUUeIoAviP3Q+/BERGvtiuYOnAEJQBio6
 u95YgSam4cOR9+JRU2BBrGEAwuQ3uIHMXAph56j3uAyoHB7U+cW0ahSwB5X65wH5C2vJ
 /UwLeNWQHwbXu4Jpu4NyTtoo0MMkCAwLpFFKu2XmlBCE13X1aM3ptlAVKoE9AvFe8zV3
 AwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729523117; x=1730127917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3AJp/ShFQ4+ujpvmll/KciR4DNwT7NaOo8fNK4+6YrA=;
 b=G3Jy6wvLLuXVKdjoEiEHC177prpkmxv+N/ITLLkbWoqN2zEF71xWaduEqSrXj8pobV
 1W3eUgvnhEowxwUf7HAHzohSUaF5NsM1TfSbX8Pu5P/VGiF0q0O7vqfnLUTHRyOQmeWV
 hd9hzQdM5so+ISYV/jPnwzvWmg+Ym7mtKetMmjMkPWsU4ErJDcY6HwwBd4Yo3BSOgkVr
 Sgz7/kGJ/HBiTnHLQUPfw63jgllAF0r4ElvBOtZWxXKknCHjTFcpjtGoiWTT+Ag29xhE
 WpSAaigXiQvXxha2gP8QS8a92TJAKu073SQExgjdHk/9WD5NXeM8sGssLKODbktppPbY
 AgHg==
X-Gm-Message-State: AOJu0YwO4HYIYKwhceeVx3Ksc9E7ajLpUnPAEXLEj+XrwgIgTiPsoqv2
 bhpRjM581wiPagp7ywd6AbW+h1X8edeDgKCFtvqJijfy9kJhEbzwxYnVIT6dNZ0=
X-Google-Smtp-Source: AGHT+IFCcftpJS5E7M6bnoSn6IwE3JhKW7sKykEQaOVf6p/0Lr1NZs4D6So8232bT/kmNpYknF0omA==
X-Received: by 2002:a05:600c:3b08:b0:431:55af:a22f with SMTP id
 5b1f17b1804b1-43161657d65mr91714605e9.13.1729523116883; 
 Mon, 21 Oct 2024 08:05:16 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9cd48sm4525105f8f.111.2024.10.21.08.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 08:05:16 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de,
	Zixun LI <admin@hifiphile.com>
Subject: [PATCH] dm: gpio: Return error when pull up/down is requested but
 set_flags ops is not implmentated
Date: Mon, 21 Oct 2024 17:04:51 +0200
Message-ID: <20241021150451.1858427-1-admin@hifiphile.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Oct 2024 01:45:50 +0200
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

Currently in _dm_gpio_set_flags() when set_flags ops is not implemented
direction_output()/_input() is used, but pull up/down is not supported by
these ops.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
We have updated our AT91 BSP to use DM, on field testing few boards
went into a failed state due to gpio pullup is not enabled. A floating
gpio doesn't always fail and can sometimes be hard to diagostic.
---
 drivers/gpio/gpio-uclass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 712119c341..a58513c946 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -661,6 +661,9 @@ static int _dm_gpio_set_flags(struct gpio_desc *desc, ulong flags)
 	if (ops->set_flags) {
 		ret = ops->set_flags(dev, desc->offset, flags);
 	} else {
+		if (flags & GPIOD_MASK_PULL)
+			return -EINVAL;
+
 		if (flags & GPIOD_IS_OUT) {
 			bool value = flags & GPIOD_IS_OUT_ACTIVE;
 
-- 
2.46.2

