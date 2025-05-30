Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F773C5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 21:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA6F982C7D;
	Fri, 30 May 2025 23:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Wda1l/ba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE49082C7D; Fri, 30 May 2025 23:23:10 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAB3482BBF
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 23:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbellary@baylibre.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-742caef5896so2039223b3a.3
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 14:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748640186; x=1749244986;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=37Fe7SFytBCNtwxDfUBUq7zXSTk9xGB1vi7KAIGqLek=;
 b=Wda1l/bafGB5eaipk3n7UDX4/dKioFiLoeX+OMSmWI9nBEL6M7F/ESsximMwUpXfBg
 pump0OuzsH3W/u6n1lUqnwsGcQ3ebGTtpWXEnry1Gq6ASSqSbWcZDrYArnJy+8nPU7iq
 FB9Wk+6zGnS+oBF7vae5coMAzULrtd3T+RB5U6+TAn0hrXraIYx1BHBlVIc0ZA4dikDg
 RYL4uR76WXlywhGO0+bMUabFbHv31oEMif0qfrtKPdEqHX75nZ5DT+mBMy90RMrI7ZSO
 AWGdYFmyVBHPIGVG3i+90HQ12rsmOzv5PLaSzSCz4UFRFJjzzeugTozM3nE9fcds84Sm
 yIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748640186; x=1749244986;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=37Fe7SFytBCNtwxDfUBUq7zXSTk9xGB1vi7KAIGqLek=;
 b=F5YrK/Npy1Q1YU0ycStyOod4WzLN3BY9CSEVMrmELNtySjNull8/CWmYjDfoZycFC0
 Qce3WKLNA4ZZFAVnGLHAgCCcXocu1kZfmohr30P2cy0Mo6JipJeY1kFA9isK0u0R9bhb
 Z/xhmzppaisr4xGUOgvOO1Jw8uuw6zrpnpMkNUr0OVwXnQK9TzRG5B7E7GzOri3bQzgK
 ISpEONOZXiLnHQeRVwStJyBUgQlqKYhLiUngCa76w0ieFstnbIV6de/VxZEL5J0Wcfqd
 D0wFN+bJlFOMa9N7WIqTB4CRzdbQO9WL8O7PaWZa5EDM3sJMSp3TJLXGmrHec3wig4h3
 zVaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl+cubEya6Sbjx6NEICScNoQXS9daH0i9FqhRuamCLQXDeh3TVBBJKc3zLHKFJYvNQAkC6a+s=@lists.denx.de
X-Gm-Message-State: AOJu0YxiLMsGgBG9TsNLOUCf633ya2Cd4iAlpjnSVjmZ400bXljQPDU3
 Xs47cJ9dtK6pIvLSY9MpxtSofSTJFrLUw0m2kVapv8cIHogGCjOP7KD0nzKy4QQrRlw=
X-Gm-Gg: ASbGnctJEvB0vwBHBVUyfnkQ6us8MczJu/EbMpwU+UwR8eOwJWzNTG1CAcSaUEeTb7l
 StnQUDfd1RImmIlEkw34Pfz0HhVRMsu9eOxxS/6cvtuWtQlrzShR2lqh+AwuyN4tfvNCv9AQH6s
 +MyMGG+f3RW92soUwfunR8SZTXifp2gI+qkVATGicnHvW0Hr8RyigW6KE+cxE2PxVBTtxv3V35g
 TmyPNpsjdWr3jwe6xDTG3qqKK+JL/LecfetoRdepaASqxEbfm2yE9gBXYidaq7VIDBB8w9xrLbP
 vF6Efh8gfLQR8c86ulAyGoPUSJHcAtXGW0qj2hsMWd5b08bfHPMVG7NQC3VU0WLYkOm6B/aSb1V
 fGhWkJ7kPnY86hQ==
X-Google-Smtp-Source: AGHT+IHUomnWGve5pjDcWgIKD34DNMMmcW6+GUWiBCMxDH2I3GUyQQqHPyqVN9iNQWJEAVKfBzbBsg==
X-Received: by 2002:a05:6a00:1a89:b0:740:91e4:8107 with SMTP id
 d2e1a72fcca58-747bd863bb4mr6783898b3a.0.1748640186279; 
 Fri, 30 May 2025 14:23:06 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com.
 [76.88.115.8]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747affadf7bsm3594039b3a.108.2025.05.30.14.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 14:23:05 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: [PATCH v2 0/3] ti: Add support for eCAP PWM and LCD pin mux
Date: Fri, 30 May 2025 14:22:29 -0700
Message-Id: <20250530212232.1686613-1-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This patch series adds the support for

1. In am33xx SoC[1], enhanced capture (eCAP) supports auxiliary PWM (APWM).
This series adds the PWM driver support for the APWM feature for eCAP on
AM33xx. AM335X_ECAP0_IN_PWM0_OUT is used to enable the backlight.

2. Fix build warning in ti-ehrpwm driver in dev_deb().

3. Enable eCAP0 PWM and LCD pin muxing to support splash screen on
AM335x EVM[2].

[1] AM335x TRM - https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
[2] AM335x EVM - https://www.ti.com/tool/TMDXEVM3358

per discussion on the earlier patch series,
https://lore.kernel.org/all/20250319202516.3300444-1-sbellary@baylibre.com/
dropping the device tree changes in this series due to OF_UPSTREAM
conflict.
As we are dropping the DT patch, started with the new series instead of
V2.

This series doesn't contain defconfig changes since we don't want to
enable LCD, splash screen and PWM support by default.
Enabling splash screen and PWM support in defconfig causes u-boot crash
on AM335x based beaglebone black. This will be handled in a separate
patch.

Changes in v2:
	Patch 3:
	- Fixed the build error for CONFIG_AM335X_LCD and
	  CONFIG_PWM_TI_ECAP 'not set' case.

Link to v1:
	https://lore.kernel.org/all/20250423084249.197101-1-sbellary@baylibre.com/

Sukrut Bellary (3):
  pwm: ti: am33xx: Enable Auxiliary PWM using eCAP
  pwm: ti: am33xx: Fix build warnings in dev_dbg()
  board: ti: am335x: Enable eCAP0 PWM and LCD pin muxing

 board/ti/am335x/mux.c       |  48 +++++++++
 drivers/pwm/Kconfig         |   6 ++
 drivers/pwm/Makefile        |   1 +
 drivers/pwm/pwm-ti-ehrpwm.c |   2 +-
 drivers/pwm/pwm-tiecap.c    | 198 ++++++++++++++++++++++++++++++++++++
 5 files changed, 254 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pwm/pwm-tiecap.c

-- 
2.34.1

