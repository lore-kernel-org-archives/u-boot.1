Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E46D0D7BB
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 15:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4031D89392;
	Fri, 11 Oct 2024 17:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UD3M+A6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8E148939F; Fri, 11 Oct 2024 17:51:23 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 919728937B
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 17:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d3ecad390so1978782f8f.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728661871; x=1729266671;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nFjJGnsC6gWU++GrMe+WK/ovj8M050EAJFUXFQHBgQk=;
 b=UD3M+A6d4I5bw8jPgQY5zVKL5fxMdrNITMu/Xey6uKpcxPpLh03FRPDkkH0Ar2uQDA
 055ikavjtqhxy9tjoEgZIicURtOqoDuacitrtUOGGpvtJ3rx2TJSuAbHLKgCXGczLI+O
 /YhcOkLMpeiqi2VSTkWhQR/yqq5nALhJI0Etp0DAMU/lcBHTICXb/k2ldB+3W+g7ghVc
 cFGtZLztmpXyatqoKBEHp8dHrDBZoj7MqrK+toIEfU+rHlwTQ7UhhAoBmwlTScsF2+56
 tFufHGMSQ27PP3ATonLABRphopu+1BoAnPQEgjcZlYbamXuD//QBgu0mEIJQFtX4DTak
 anXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728661871; x=1729266671;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nFjJGnsC6gWU++GrMe+WK/ovj8M050EAJFUXFQHBgQk=;
 b=Whi2B8u8BGofRKRdWDvedNVU6N3bxVtfKO3cVTD6hiOZH0giz3H7eoaphwmaRRTG4j
 PnM1AjOxZJM2G2riNxTA1sOYsYIDxUDL/5tKXMoufAM75j29tVm9GYn+Dp8JO/HbYpmu
 ziP35y1/m9OVrz4+etr9ghTEhPQGXDlQiUP9ScEqLq4v0AgjQ8obm3JSxrz04ZSuw1h5
 Uv+WAuDF1nDDGJ+i63tacIGxx7HCRAbjFxFiz8yijT1GreIQC3/6lmowOsD2ROHqMSMf
 rQ/539H7XeugJ3+g0lgkfNxPaIuBsRHeiao84I2ARcDfu74PvzS3d481/P6qqV7VG6/0
 1hEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBXxHgJpeR0TLnT0XU1SavP4uz+92mMYaC9U6/F58PWg3VqlISbQ8gjtTTewEYv8ydq5mgE/8=@lists.denx.de
X-Gm-Message-State: AOJu0YxSpJmJwBM9wRkZxDd7F4KL2SrYx42PYZCprActBBCJh6f1y3MT
 gt8j/rTcdhXp0AL8N3x7gtWMNHJ7OnEysgZ0khNZGthS2TKyRW7t64EpMr5JazE=
X-Google-Smtp-Source: AGHT+IGhWVfXo6SmgV0cKYw/w/km0nsPPOW+VHTSBvLmsyRjPiacH+9O8FU/ieo2NqyTP3GsYbmdxQ==
X-Received: by 2002:a5d:58fc:0:b0:37c:fdc8:77ab with SMTP id
 ffacd0b85a97d-37d481650acmr5683597f8f.7.1728661870794; 
 Fri, 11 Oct 2024 08:51:10 -0700 (PDT)
Received: from mkorpershoek-xps13.home
 ([2a01:cb19:8941:9800:3dae:610e:6435:d98e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431182d794asm45769005e9.1.2024.10.11.08.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:51:10 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 0/2] configs: khadas-vim3{l}: Android bootflow updates
Date: Fri, 11 Oct 2024 17:51:01 +0200
Message-Id: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGVJCWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0ND3crS7MTyRN3E/OIC3YLEopJiXXPzFCNT00RDy+SURCWgvoKi1LT
 MCrCZ0bG1tQB0uq0HYwAAAA==
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.0
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

Hello, 2 small fixes for Khadas VIM3 and VIM3L to boot Android.

Recently, some effort has been made to use the
upstream android-mainline kernel on these boards [1].

To use android-mainline kernel, we should:
* Increase the boot/recovery partition sizes (so that it fits)
* Drop dtbo support, since these are not part of android-mainline

[1] https://android-review.googlesource.com/c/kernel/common/+/3296472

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Mattijs Korpershoek (2):
      configs: khadas-vim3{l}: Increase boot/recovery partition size
      configs: meson64_android: Remove dtbo support

 include/configs/khadas-vim3_android.h  |  8 ++++----
 include/configs/khadas-vim3l_android.h |  8 ++++----
 include/configs/meson64_android.h      | 26 +-------------------------
 3 files changed, 9 insertions(+), 33 deletions(-)
---
base-commit: a404065479be2c1fe1167c3c91367e8194a69d1b
change-id: 20241011-yukawa-aosp-parts-77d255a19cda

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

