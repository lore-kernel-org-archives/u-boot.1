Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3063CCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 16:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C43183677;
	Tue, 21 Oct 2025 18:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TyY1sqRk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E77A48362A; Tue, 21 Oct 2025 18:08:34 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10D56835A2
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 18:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so3771227f8f.0
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761062912; x=1761667712; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mBTGcUWZ0zkXxZe8j6AXYvZmkNN7B+yWyptFFk9ODPU=;
 b=TyY1sqRk/zzLqndNCi3fFzX9tASgEJ4G4sHpmFlUvaeFXRiobkmh2VS8MS9H2iQtBp
 +rde7VdjXL8on30opeKKP1/UNqONDlLFaT8x6t6NPPDE8auqwt4lPGXWIqf4SGR9oGLS
 t7G1vwz0p0eQPwDAT3k0TTevjONyK34YCjb5rgW6zm0yKIOY3mROTquKVlB17eRkX02w
 f6UIZaPTlz+3qtfvDfj6dLxIemVo+2QaQjVk+IGUUDq+xoffwn3Sumwyy0lKzRu77ZQA
 EhoQPCf8OtowImebtWKvV3rM2QXjMkVJeWsGwLUFsDR4OK0DgMsgQqk5+Qq1ppArH+qW
 hJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761062912; x=1761667712;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mBTGcUWZ0zkXxZe8j6AXYvZmkNN7B+yWyptFFk9ODPU=;
 b=wFLcmJR+IdaSIK9zekGbxY4Tb1M41iF18rTG7ceIsRV+rcBKdeW1/IkWGDG9mQuQtn
 3t45sw4sh6ElxM4+/NeQ00DX1tGIxZUwJH3QryWkta6xSwZ6n2zhFBl3x5r+yntIY2F/
 dSTpWt8a83vD/N6liuUcsUHTbAA7vuOlXGffy3H3HNo5SKUaBYykgZ3aKq5vhf3N7IqK
 KxKssujOya/Ph2Gw34xEyPX+hqWuhM5uPCjSnMddbbo+QNSesSijLACfwvJN2+Uwq9Hy
 pA90iye6Y3gtoNv00PUjzF+LWVt4o7ZJpIbgRwpSuyCDvOglZKS66pCZDZ+mCLbP65Ad
 0m+g==
X-Gm-Message-State: AOJu0YxxTGW9wJ1SMKxpvjBj69Fh9AbGzpcjnToaOJIMVEwJscH/vhQT
 1uqEO2UbTcmBURAJT1nfbJrGfmXz0okbQH4GB+zwgNCqRX6+clLtaasCdVFgbs2VZYQ=
X-Gm-Gg: ASbGnctVEswzIhi3jENG+reu3GzhoC4T8NUlMO9R7/42WAfHzxezKtzTpZReb3CS4kj
 VN9e/RypgWW4yPRipim20suInL6h5eNT3u2snln7oXO9gB8/yolOd5HLVGZJoKptQ60tJ55sGSY
 7ccCPGuwpFKkCmHQUhL1/NWOXiwjaTBR80pkfkTGlrTTJVu3RaM3nElO7MgurDhmFGZlfIT3rIl
 Un2yOaytZ2yW7exxC4FQSQtl1FzeX2aKujUf2Essl71M32RIFcchuAoQwBAieIxWIHtJ4bdyULa
 ks/YkQsDaFT8gYRjj23SsfS4Jd0bVGV+ZGeCJR8BUhekDfNyZhDyyUg+585HKQrXlbnY9KC1HA2
 J08Xk+Wy6xbj2cYS4Vt7TXbDTFv+Juej0TyWgM9scRenFtrF9+SXiku1uemVxFTL9UC1s9ktowE
 lYw1m6ue8AOLxaI0mgQ75HCPGbuPvlYhcBhkNc4g==
X-Google-Smtp-Source: AGHT+IG/544Z3aD3BBU2YhgdrVB0z0vbeawGp7BLMAy8BlvLa1C1hYdNBgSBSfknsnebeaR4sCki9g==
X-Received: by 2002:a05:6000:4024:b0:405:3028:1bf2 with SMTP id
 ffacd0b85a97d-42704e0eeb3mr11604633f8f.62.1761062912432; 
 Tue, 21 Oct 2025 09:08:32 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:ff54:533:2c9b:1f57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3ae9sm20830245f8f.13.2025.10.21.09.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:08:31 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 21 Oct 2025 17:08:28 +0100
Subject: [PATCH 4/6] i2c: npcm: Fix error detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-clk_funcs-v1-4-acf51a40eea7@linaro.org>
References: <20251021-clk_funcs-v1-0-acf51a40eea7@linaro.org>
In-Reply-To: <20251021-clk_funcs-v1-0-acf51a40eea7@linaro.org>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Schocher <hs@nabladev.com>, 
 Jim Liu <JJLIU0@nuvoton.com>, Stanley Chu <yschu@nuvoton.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Testing an unisgned member of a struct to be <= 0 will only detect the
case when it is 0. So correct this error test to a working version that
will behave as expected.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/i2c/npcm_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/npcm_i2c.c b/drivers/i2c/npcm_i2c.c
index bff0d04f1a5ae2c261657a5776b38e4ab6ad4d28..d57237a6df167d579ab4b8d45f3989a8cac0fc68 100644
--- a/drivers/i2c/npcm_i2c.c
+++ b/drivers/i2c/npcm_i2c.c
@@ -573,7 +573,7 @@ static int npcm_i2c_probe(struct udevice *dev)
 		return ret;
 	}
 	bus->apb_clk = clk_get_rate(&clk);
-	if (bus->apb_clk <= 0) {
+	if (!bus->apb_clk || IS_ERR_VALUE(bus->apb_clk)) {
 		printf("%s: fail to get rate\n", __func__);
 		return -EINVAL;
 	}

-- 
2.47.3

