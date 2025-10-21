Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B58ECCD1A7
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 16:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8695E8323A;
	Tue, 21 Oct 2025 18:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lggadvbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 337218334F; Tue, 21 Oct 2025 18:08:31 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28BEE80107
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 18:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so3453849f8f.0
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761062908; x=1761667708; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=te/kVnAuwxpP5zRso/bFbvQ6eKCIslE4ks4TkRzpAks=;
 b=lggadvbbfGdn6UQmBl6wB5F2J/19RWc2jpe3KkjCw0NrKGMpfEr+aTu1x1uEBrdbL9
 z0A+S9LYu/GJM96zgISnD7qG7UG/O3zsuQnhnhuZU7+bet7iZZxh8ViJsuVY0cXstolb
 k1/uk52sOYWQZlTi1PYWhNwuW9glpH4L5JtFZ2vHbo+ffLXhx7PMX6XDCAdhsIw58N65
 lAVAQ3KHE5orJVK76/8NFREbN9EnysTvIbdUDWztwhL8qW5aMNMVCXLco22SRoiSf8No
 4gEzNEL/xDyjhpdf3CGz1jRDmppiwtr/QbIgLot7rhK5an8hibo46/Qs9AKsYzjmQDNK
 1cPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761062908; x=1761667708;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=te/kVnAuwxpP5zRso/bFbvQ6eKCIslE4ks4TkRzpAks=;
 b=QB4ohX9T5YqZaUxJImrQMP5WWmpM0H9Ybdtzq8JokuHvH9ousdpBcix1/UEEbwRK43
 SddDDKbuGPC089TqEOzK6Q3Qpn8/4GqNjU25E2rrfJc8B/LoSUIQDRvNtJSVgY7Me95P
 irCPa2xpmvB9yT1CazQjMoZvzbf8p0EeKGWJpYRHGObSWmoTxTb7LTklDPKwG581scbh
 UNW28y+OKpJo/0TKULG47zi3nh3zzztVBmKXWIt4VZZltamNYgIKATW7iE90otA4oG/P
 jwZYE7PEgb5v47+W+LehtaugKJwfio8MhnaPMyYclaETBvagPYMyj0tcEy4XUYlOLUZO
 /6AQ==
X-Gm-Message-State: AOJu0YwjDZZ0Y+A3laQyrPUykPAKCPcOo6ckmQyjM/SZZW4RX7ARAac0
 yR5MReeiagPkY2Z+ot/BRWI/D2Gpx1vlYRDm+wmxt8x+DhX74nx3QUs+BiGgOtJyq+0=
X-Gm-Gg: ASbGncvroXpRah5gbgrnNArkT4+UDVCa6UbvUjeGqSrFM9ylsQWx4JeN6aB1uVyjwer
 XqFnS55/cvfSkKaAkI9t+YeJ1hxyt06JGw7GIe8BMR1yK6Fh/XiAdcQj2h/IDK/bj/qHu2U1syS
 fZak3cRAkm9I6c5NkRRJF9wiM+ahJVdijx2vHafG74oMLXKTadrFZTIEuEM4W0mz6Od8T9jz830
 z/FZJtANIc88gVYXGjTLYJWLrZUDszFF1BRvAFCSnTQUfdm3YAIeNMDgsmzirszZFV/cUkcXOxd
 qV9BKEs6Ih8cjWho9aAv0/b3C8MdrveY3wfXhn1RWCdJ2SBxuPHFZPPuiOXrDtP0V6hR68EZCqY
 mSDRLq8w0KPGY8BKTXcZGqF4YcMzLjR13UMdaOQf7f/CHGVRy6uHtc8RTrUvmHYRNFAZqZohnbS
 v8eeHsGNk9OwDIvujy//PL7XhxwBywgsILAog+Sn/6lQweEi45
X-Google-Smtp-Source: AGHT+IF1xbVyxdiXGJKgEZYUnPESNqX0jcV8AZAN3jx8wLUQ0uz/wOuHWa3mH4x9o7J9VhxQ9f0ONw==
X-Received: by 2002:a05:6000:22c5:b0:425:7e45:a4df with SMTP id
 ffacd0b85a97d-42704d145dfmr12765765f8f.11.1761062908477; 
 Tue, 21 Oct 2025 09:08:28 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:ff54:533:2c9b:1f57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3ae9sm20830245f8f.13.2025.10.21.09.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:08:27 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/6] clk: Fix some error detection
Date: Tue, 21 Oct 2025 17:08:24 +0100
Message-Id: <20251021-clk_funcs-v1-0-acf51a40eea7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPiv92gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMD3eSc7Pi00rzkYt1kY1NjM0sDM+NkwzQloPqCotS0zAqwWdGxtbU
 AjxxF7FsAAAA=
X-Change-ID: 20251020-clk_funcs-c35369063c1f
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

The function clk_get_rate() returns a ulong with 0 meaning an invalid
clock rate and also negative error codes being returned for other
errors. But being an unsigned return value this cannot simply be tested
for with a < 0 test. Instead use the IS_ERR_VALUE() macro to check for
negative errors appearing as very large positive values. Fix those
places that test for <= 0. Also fix some places checking the return of
clk_register() that incorrectly used ERR_PTR().

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (6):
      mmc: hi6220_dw_mmc: Fix error detection for clk_get_rate
      mmc: fsl_esdhc_imx: Cannot test unsigned to be < 0
      clk: microchip: mpfs: Fix error detection
      i2c: npcm: Fix error detection
      i2c: imx_lpi2c: Fix error detection
      timer: imx-gpt: Fix error detection

 drivers/clk/microchip/mpfs_clk_cfg.c    | 2 +-
 drivers/clk/microchip/mpfs_clk_msspll.c | 2 +-
 drivers/clk/microchip/mpfs_clk_periph.c | 2 +-
 drivers/i2c/imx_lpi2c.c                 | 2 +-
 drivers/i2c/npcm_i2c.c                  | 2 +-
 drivers/mmc/fsl_esdhc_imx.c             | 2 +-
 drivers/mmc/hi6220_dw_mmc.c             | 6 +++---
 drivers/timer/imx-gpt-timer.c           | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)
---
base-commit: a58089ad2e41e88f81360f0e99bfd0715aceb556
change-id: 20251020-clk_funcs-c35369063c1f

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

