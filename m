Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAC4E9129F
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 04:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30247831AC;
	Fri,  6 Feb 2026 05:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L5UDkH5B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B68CF836D3; Fri,  6 Feb 2026 03:48:39 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A518F83015
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 03:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-45ca17ef16eso87062b6e.0
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 18:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770346116; x=1770950916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/br2+fLex5jWRV6bGhS5WAnLB97jsJk7gMzl49dwDZI=;
 b=L5UDkH5BhgxhpspCIfqcAS/4x0GRmSj2VvoqtmOBmnlsf8IgzFBXhFNfw1+YUfo/51
 7l/zbh5INWw+Q8pKiNkaoDvGoQWW+asz0ZwX/8M1xqirfDsEj6LOJKGCmgLo+PwrzIbX
 JMeoV827xVxC1G1pd6xGY4Tfxw/3SpBhDklLsvDOMilAr/rnlGuSGd5XdKqlI9Be65PG
 PqvjP6wjqhjsDq5n7iUQhcpHN5ZGzSZjkjmImw3HxBdqjeMz/6YB2u53KfyhDYu51Kb2
 mhbOll1qMp98EI3auDOBDXp+DvPV7kL3zdUoc6GG7i4q+Aohq8NkmWpyjZFl3BAT7KhK
 +Lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770346116; x=1770950916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/br2+fLex5jWRV6bGhS5WAnLB97jsJk7gMzl49dwDZI=;
 b=pxj103HAiCc//lDq3TJ285aA6N0CTFCmfTXAYzfYXJnO5eVWuz/mitiJH4x//q1P7p
 XNPjlmF7BNRlVqjb+jiB6Aq8hfIyUNi3YxXU2np21MSdKMnckWjAGIeLUeSrQLI80FTp
 Iq+HwbIuVZviOJKcV3fHG0DL3TXUXXMqFsjLCIMyUehNTbyeCHE2HLG4aC+QBAu5/35X
 MguIBUpwt3mrNQ65C5rhvuMgjjSz5pt97cFIBXtmKiTAp7C+mB0N2zpDnrxmJmgSFFWQ
 9V4+En8LEo8hvHe4C7axz1Kry31w6139/kZhcBp3NTcs35Td1Kk81OgPeyIX0uwRsXaP
 0gbA==
X-Gm-Message-State: AOJu0Yy7BEv3lb5OvGvsKGjVtze48+Bor8D2ywb6HN9tRDdp9naZ3h+H
 F6CfNkmuN6BEVdT1fplXhdaLxUBHl1bFnGAM5fnII+xCOoEGdLtF/DYLf2B94A==
X-Gm-Gg: AZuq6aLZ5P86TgOw8aMHHd1ODY/TZKMErF71gQj+TCeKSB6TlAAw7QRWwo9DJA4UJaK
 +VWax/8tDQK45jf6LRQNAK7pa7OwTJRoZYKvgCWqJRZ4SygregEisBeO6gZp15b5j/cw3vRIMdY
 urDM0YgWGHefT47JBwlOZNHFGJE6h22U2zJ+xQUo7hhaoVC0mbxvUvgruKMc/Ydb03jNT7NhIK+
 4jBXeYrYr4FgYjZ3sRVPONwpvbAWXr3vsTG2vmvQHcN7p0PCVSytJdw7o3GgWtB62iwaLBpuOs7
 LjHv5uUKfAyW+ltghIJwNKDu/aWIdqdqbCadraAfpfNVdgp7Ap4Ef6dKrrED3aMnfjb1fjztt0r
 v4f0NG6Ykp7zHS9MKQbmSckNGtBTHy64Ip6lVBw4oTT5HYuXZFOIGetKCf+twHGtUGa5DQW3i6B
 fCVqaE9mrcXafDjAz+FEorRS57rsDU4ZYs0XxeDKKypoa/n7IKsbxTw/HBNA9+S2GRpKcXtWlk2
 3jFPHm6Sg4VWATZcYKiNqJ+D8Br8oSdDPfsI5oG6X67SOUGRQY=
X-Received: by 2002:a05:6808:4f06:b0:45c:8183:8c6f with SMTP id
 5614622812f47-462fcb6fa54mr821463b6e.47.1770346116083; 
 Thu, 05 Feb 2026 18:48:36 -0800 (PST)
Received: from james-x399.localdomain (71-218-105-26.hlrn.qwest.net.
 [71.218.105.26]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462fe9a16a1sm558005b6e.2.2026.02.05.18.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 18:48:35 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] gpio: sunxi: Don't clear pull settings when setting input
Date: Thu,  5 Feb 2026 19:48:21 -0700
Message-ID: <20260206024822.454863-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Feb 2026 05:34:39 +0100
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
 drivers/gpio/sunxi_gpio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/sunxi_gpio.c b/drivers/gpio/sunxi_gpio.c
index 094c45a6927..ad891da3a97 100644
--- a/drivers/gpio/sunxi_gpio.c
+++ b/drivers/gpio/sunxi_gpio.c
@@ -301,7 +301,8 @@ static int sunxi_gpio_set_flags(struct udevice *dev, unsigned int offset,
 			pull = 1;
 		else if (flags & GPIOD_PULL_DOWN)
 			pull = 2;
-		sunxi_gpio_set_pull_bank(plat->regs, offset, pull);
+		if (pull)
+			sunxi_gpio_set_pull_bank(plat->regs, offset, pull);
 		sunxi_gpio_set_cfgbank(plat->regs, offset, SUNXI_GPIO_INPUT);
 	}
 
-- 
2.43.0

