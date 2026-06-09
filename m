Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACC8CD8CA8
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 20:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D83C8498E;
	Tue,  9 Jun 2026 22:23:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XEvQujoA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B2FA849AC; Tue,  9 Jun 2026 22:23:36 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5145A848DF
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 22:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6914b5451a3so634877a12.0
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 13:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781036613; x=1781641413; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lNySBYKI2C00KYnH0JiiW/Tgkao4mCRm27pRrd8dHdU=;
 b=XEvQujoAuiDSn3tEHOLvKQH3gvhcm6uRZkvduc5jrq/gxqP0vkR8o/9MQse7WGhPLZ
 Ai02yWxLvRf9FWe9iMaU8XuMciF6e59Ixjx86R/kpGkhMgu/yLzrWwlHr7FipO6xLSiT
 UiYABU8tkGVADdl/3KspXysSCOeRJondkq9WeLyAjxcV+9gyRPEWwiMi4+pYhIHU50fA
 iZZjIzCBrlG7J6YjImQFhKcXxI7J+K4r6LQeO0MhaaWtR6eGfj1s+ctIStRJD4zyoMJv
 VN6HkWMsY9E89/UNtJj8DULKXFmmX3I2dN8Q1wNi0Zr9JptpxIQhS9k+ADvX++k//RkO
 RoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781036613; x=1781641413;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lNySBYKI2C00KYnH0JiiW/Tgkao4mCRm27pRrd8dHdU=;
 b=PJ5l8A8d9sa0nkbVTVPbi4WNdkpo52omSJFfcrPuAK7PGfYCysQMVDarwQ4vlQgsgw
 MZA+zyY9IO1ddNvyBKgTennQX7j7o5XpL5OwFeP4pc9yi/FfVol06mTDhNPLTemiZYv/
 EGbBADScXubQSC3jkEknj8/QGH0SVO1hjwTh7TkviYB0Z8ePo6RmZCbg2WumaZ+MSZ2m
 ki8pkGnXXpiuHLPpDpYTwQf+VhIEr/cA2T4jTfDuuT49eQuC97BP+3LYoWbxokwpCwkJ
 oUhEXwoHJol3rhJfjEK80QRKOeCHWKC3L15j9paM094STncqt6X8ADE+O/oII5JeEFgD
 Opiw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/WZCDjbpwMYOs3VF0ItepvXOnzeGwuT63U6FCr3ce3AKcYq3KbW1ofgb3EyYd7UISu/Z1XYJw=@lists.denx.de
X-Gm-Message-State: AOJu0YzTPIX9KoTkh+7Q70yB57d+sssIB4KOiBF58uusyVdoXQoAZwXF
 eA+OUZw1obRJYv3W8QHovhucFOrNFrkClEYMHvrvTnpqEnQ9PPiNqr5UD/U0pg==
X-Gm-Gg: Acq92OEJDM6ygyjpG7uAQtcNrN6GvAPH6RFFXRitZNxHW4djpMKUaLOCzT0MxXmV8Ae
 K6BDycNjRGC7zc8u0mmjG0rUTuqHM2/2aQbT/W0YZWj8ywn67oSe3h4WXlkdCKUEyzPs2gLDnnV
 0ZknmP/PNQfqoTc38nTYqYjJzy9bjUWiz8s2EWcnasQqCGgMvv7nZVe5nftn3TcUdqsTNuq8bEJ
 12PZe9r//NvlcL5Pl5SbZ4FqWxFmScnQ+36eC14xqsif7dB8vG7CEOzmzWZR7S5o+hPA/cJQbZ3
 SDWQLAijVunOEDS/ITgxVju/bID8d62Sj9lcd6To8qSyKlm3EBvx6XkQnvqlT3Ch4Vrc+CuDm73
 4Ne1rIObIOf4c0NgT3LfmVGRCKo3hY5L6YE/UT3GH/PSCyaX/AfIFwIn6BHQwlaXTXl9FckQbEZ
 VUd4iOxTQFupauWmw2B8TZfNUcqhxUW1J6Ov0a1hsuxqBawC21B+AcdbuDS3yv+t1V9+RBR1SV
X-Received: by 2002:a05:6402:5243:b0:689:ac19:3fb4 with SMTP id
 4fb4d7f45d1cf-68fa4c16bf6mr5489218a12.1.1781036613462; 
 Tue, 09 Jun 2026 13:23:33 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e64e2c810sm9240626a12.9.2026.06.09.13.23.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 13:23:31 -0700 (PDT)
Message-ID: <5c0bc31f-047b-4b51-999f-7f6cebd8378b@gmail.com>
Date: Tue, 9 Jun 2026 22:23:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 3/3] rockchip: pinctrl: use include from dts/upstream
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 u-boot@lists.denx.de
References: <d5752c9d-eca6-4ee4-a0bd-52ffc8103976@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <d5752c9d-eca6-4ee4-a0bd-52ffc8103976@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Use Rockchip pinctrl include from dts/upstream and remove what
is now redundant.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 include/dt-bindings/pinctrl/rockchip.h | 47 --------------------------
 1 file changed, 47 deletions(-)
 delete mode 100644 include/dt-bindings/pinctrl/rockchip.h

diff --git a/include/dt-bindings/pinctrl/rockchip.h b/include/dt-bindings/pinctrl/rockchip.h
deleted file mode 100644
index 88544766f18e..000000000000
--- a/include/dt-bindings/pinctrl/rockchip.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Header providing constants for Rockchip pinctrl bindings.
- *
- * Copyright (c) 2013 MundoReader S.L.
- * Author: Heiko Stuebner <heiko@sntech.de>
- */
-
-#ifndef __DT_BINDINGS_ROCKCHIP_PINCTRL_H__
-#define __DT_BINDINGS_ROCKCHIP_PINCTRL_H__
-
-#define RK_PA0		0
-#define RK_PA1		1
-#define RK_PA2		2
-#define RK_PA3		3
-#define RK_PA4		4
-#define RK_PA5		5
-#define RK_PA6		6
-#define RK_PA7		7
-#define RK_PB0		8
-#define RK_PB1		9
-#define RK_PB2		10
-#define RK_PB3		11
-#define RK_PB4		12
-#define RK_PB5		13
-#define RK_PB6		14
-#define RK_PB7		15
-#define RK_PC0		16
-#define RK_PC1		17
-#define RK_PC2		18
-#define RK_PC3		19
-#define RK_PC4		20
-#define RK_PC5		21
-#define RK_PC6		22
-#define RK_PC7		23
-#define RK_PD0		24
-#define RK_PD1		25
-#define RK_PD2		26
-#define RK_PD3		27
-#define RK_PD4		28
-#define RK_PD5		29
-#define RK_PD6		30
-#define RK_PD7		31
-
-#define RK_FUNC_GPIO	0
-
-#endif
--
2.39.5

