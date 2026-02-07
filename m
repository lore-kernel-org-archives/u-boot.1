Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D840EE0AE8
	for <u-boot@archiver.kernel.org>; Sat,  7 Feb 2026 21:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29A1A83B0B;
	Sat,  7 Feb 2026 22:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gjYchQXZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5C26838FA; Sat,  7 Feb 2026 20:48:20 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A30F83642
 for <u-boot@lists.denx.de>; Sat,  7 Feb 2026 20:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-45f194e9a98so1009981b6e.3
 for <u-boot@lists.denx.de>; Sat, 07 Feb 2026 11:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770493692; x=1771098492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eSbIC1+1/ry00Tvwe1WeQouhbbevN5sVGdD01haiRsw=;
 b=gjYchQXZLzSMc1CScJ0WHKglM2/SuC2lvBee01F34seYcCSfKcEFzBSRVrdJGksTu0
 t4KW8YXr+5WLQuSDMfsIRpLzLc5GMNgp1rs3IRKfZTGJhiQU/UfvsPWmDjZ5IBVKPHaS
 aAxa9yyDArcMkW/Zho9/VKVXr/kh6mr70ites7O/J4Z+o7riEaaTkn3G8qFCQC/xOUpq
 sUul5jAa7tVgFNNUJJReQZt1dt3M/Ha/I1BqcoZWyjfzcE1IwaID3+IsQtSScqbdngZh
 rftDsigCVlTaFOWnXJNeBJPUvwhhWz42QnQAmj/bWm7B9OFoHHbKJVjmfu7Kkg6tnLOK
 V4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770493692; x=1771098492;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eSbIC1+1/ry00Tvwe1WeQouhbbevN5sVGdD01haiRsw=;
 b=aqS117ST0nVW7/wAsLu1mJ+ASxoD7YYFSfcSu+idMHp6cKig1HsJGMS0jPr5L+riny
 hUdviOrf1GFwHaDMN/HcOnf/fyAWtbqgFT6c0FBYwCd7bBl1VuYb0WNqToNCIIdmqkYK
 qwpDuH46qq/WLaeH54RTgmkkga3p1zY23x3/W4FcTdZAGnedv8QOb4WBtKYnRds4b3Y7
 bx54V8kxbDoUI71bZRHZyQIwh00rYkRuALV6PfQsJCEParqisr3to6XQDfxmmJ7bh1RK
 a9R8q/LFJIKStIPaTJmsy3r6Hypi8AP+OXySXvbJd4ohIXiJEudd8FSGjMzrxS/fLvL8
 C1tA==
X-Gm-Message-State: AOJu0YxeNMV05FKgDsRUs9U/qli8VC7ZlUNZ8v3R0y6jQBeYbFBZTI7S
 OiyjqdvkmJDuYcSWPfbDFAogRpcO6jhc/mtpz+Xa5nXdOp/4DLRgUXa5tFnmtA==
X-Gm-Gg: AZuq6aJQHKw1nP6XzMpNHai+4UlzSBOiDiAooIWIAD/OZ/ASY1/Ea7uxO7s3xQfrgCa
 FqNLdBcwQPI3/JH/CNSXEx1vMKNUEQ0KeQSIGpDL4HoM28w3WNTxPkfLERbr/H93k4xENPVHl+V
 DJsoBBwvV9y/NNbojp5uqV9XODPyYgmUTO1/Z5NfwzaOhorQ+w0eV1ScjDknQS6e8IucrC+2GKm
 GveQAD22papUhHxH+4faZ33VA1BvBfGOKwgUdTxbqmdWccNSZb9iXXVm5Tj+VT+QnZfz8J2Txmy
 Mq9WPOOIM27aEvlYpbwwYeYLVyS1OQwlbErAURQACRgbto3VBHvHPu3I5Rt+wEwTG/tnbqMpzco
 gIJ2XijbCh136H00xgbl6bvZ8FUFrkqxsrNHvOxp3NYB8/IJk2+2H9uDsSfo5ORgyjIqyogp5MP
 LvgKjgIovBpyh2XiXohweE14yfsbd8LqotvhY+DKTc6AqXMd8NXQ+uwXJ5uYlfcyHZw+waV96Xi
 LTy2b7u4LOZfdIYqPakHc8B7w3TUGgHH8qb1CsY0EeDN+GfdoM=
X-Received: by 2002:a05:6808:640f:b0:45c:9f35:8e00 with SMTP id
 5614622812f47-462fc9e75f7mr3630282b6e.13.1770493691735; 
 Sat, 07 Feb 2026 11:48:11 -0800 (PST)
Received: from james-x399.localdomain (71-218-105-26.hlrn.qwest.net.
 [71.218.105.26]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462feb4fac7sm3707490b6e.15.2026.02.07.11.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 11:48:11 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/1] gpio: sunxi: Don't clear pull settings when setting
 input
Date: Sat,  7 Feb 2026 12:48:00 -0700
Message-ID: <20260207194801.4128903-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Feb 2026 22:51:09 +0100
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

sunxi_gpio_set_flags() always programs the pull register when
switching a pin to input. When neither GPIOD_PULL_UP nor
GPIOD_PULL_DOWN is requested, this writes 0 (pull disabled)
and can clobber an existing bias configuration applied via pinctrl.

Only update the pull configuration when a pull-up or pull-down is
explicitly requested, leaving existing pull settings unchanged.

Fixes: 35ae126c16a6 ("gpio: sunxi: Implement .set_flags")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - remove no local pull variable
---
 drivers/gpio/sunxi_gpio.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/sunxi_gpio.c b/drivers/gpio/sunxi_gpio.c
index 094c45a6927..9acf1c2ecab 100644
--- a/drivers/gpio/sunxi_gpio.c
+++ b/drivers/gpio/sunxi_gpio.c
@@ -295,13 +295,10 @@ static int sunxi_gpio_set_flags(struct udevice *dev, unsigned int offset,
 		sunxi_gpio_set_value_bank(plat->regs, offset, value);
 		sunxi_gpio_set_cfgbank(plat->regs, offset, SUNXI_GPIO_OUTPUT);
 	} else if (flags & GPIOD_IS_IN) {
-		u32 pull = 0;
-
 		if (flags & GPIOD_PULL_UP)
-			pull = 1;
+			sunxi_gpio_set_pull_bank(plat->regs, offset, 1);
 		else if (flags & GPIOD_PULL_DOWN)
-			pull = 2;
-		sunxi_gpio_set_pull_bank(plat->regs, offset, pull);
+			sunxi_gpio_set_pull_bank(plat->regs, offset, 2);
 		sunxi_gpio_set_cfgbank(plat->regs, offset, SUNXI_GPIO_INPUT);
 	}
 
-- 
2.43.0

