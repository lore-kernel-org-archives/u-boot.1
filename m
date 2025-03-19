Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF45C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 20:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 909048141E;
	Wed, 19 Mar 2025 21:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lltW6CG+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AC878141E; Wed, 19 Mar 2025 21:25:24 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 940D9810F2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 21:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbellary@baylibre.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2264aefc45dso35375365ad.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742415920; x=1743020720;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1MzwHtKVMApYbfKN7vR6d7OwTJFXgrC7deXG+KZFVMU=;
 b=lltW6CG+y1lktHugUSuBPR4WA4MrhKLhxvFvUP9T7w2avFyTnQk/Zid+wSe2ssrD7h
 BZYlZ4l48wkhKf1SsIOZOR0O8cB2RxX9RHWXritIBUNAEqYiyts3vn26An7Vo/R4boxp
 3LislnxdqbI2HG81LscNgcer/zlMhZKQkpNM4eYDrW3fPB7VDfpYH+1dUIWf4nzq31tq
 6YXE4fPgj4Yp7tRcmnG1ETSwH8W2auQdG0SpdGudogus5FYYt0IBG9pHXcAd8qgreY48
 irsgOZyXC25Phng6AOWBU1qAs9MHGer4BXJN0ado2MqjIgyLWruAqiCbmS6dk1HYy9HC
 GD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742415920; x=1743020720;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1MzwHtKVMApYbfKN7vR6d7OwTJFXgrC7deXG+KZFVMU=;
 b=C8jCCRXNpnW42Z65GLfNYm4WWo/qxn0aPfDXqDGvQ9rLQcphQfPUuFFrRDCN8dZfHs
 KOlVvuHEK4c7mqx0vdLi35IvCaK0K7uHuhOSfYdDZD43c8YxGEU58cU2RGzps3fuYFye
 14dhWqCijKL2DdWV+PGmgUfFb+UgV96wVVaa3910ykdWbD56GX4FzuF5wvhiftxuIgF8
 0zyC7FvDznjN5QQ/9aGoLVsGJ8wxScivPLBhzaLDGr0Gw2N3zZxtgMlEZ6//9auK2GrG
 Qfx1nQ57s1Ob7kg3izCGJKIgSPqb6/PJw8qdid82/xves8ojTE6z9w5r3mq6Ov5kW1Bc
 aowA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3b02ra3DFo1QZrITObBP01EpQ0owQ/DhnFDww6kLQeRvkLKYoW7znp3sJFnVbC42nmCqNqFs=@lists.denx.de
X-Gm-Message-State: AOJu0YyOVtPMK2ByGb4zjzorqEVOGZhAZ+Vf8fHqu4APFEqjmMfkU3J3
 7XN90nnCiMqaC6G0z4ZNdUGHqsMV5OYmNInD/ZGK5eCwWEZ/R0lhCZ753cKcE4k=
X-Gm-Gg: ASbGncvkOPE8FCv74xc3/NoxfAAEWVZvKWjV9u0DQTe4lwPA7+ERh820Y3sT3GwrVdt
 aCKWw02D554p0lRIOgIr4aNvK3pOLXYp7bUHslPL9KmBTs2cxuf0lDOXjXuymVnCefXwR9xbSSK
 OwEXP2252JcmRuLShoIzM8p9swPdqB95zWTtRqhbq26HgkNv3uxurLHA+gToh9DIGZFK1BUiRt1
 2kMlbBZOdn76WPehcDpbXXLfFnGeBIPyHjwhm3PKrxqSDjL3WeDnKRQIYyNSPuZLl2cGpIqy97x
 v4YWMsVUtMchAUB4U0iATSCqKueK/vmItJAvMuwKkkiqofLUz9F8v8t6Cn8KVdiUg+0ZBwCl0eI
 Zbq49w4E=
X-Google-Smtp-Source: AGHT+IEf5XC2+zJTJfKV/KGKRFyOyUXctJ8ZsOu+jZowl3DFTwbE5EKPQYp/wx4jkZbGiLO6kIBwuA==
X-Received: by 2002:a05:6a00:1492:b0:736:5dc6:a14f with SMTP id
 d2e1a72fcca58-7377aa5cd71mr756158b3a.23.1742415920052; 
 Wed, 19 Mar 2025 13:25:20 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com.
 [76.88.115.8]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73730ca057csm8886757b3a.48.2025.03.19.13.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 13:25:19 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: [PATCH 0/3] Add support for eCAP PWM and LCD
Date: Wed, 19 Mar 2025 13:25:13 -0700
Message-Id: <20250319202516.3300444-1-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
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

This patch series adds the support for

1. In am33xx SoC[1], enhanced capture (eCAP) supports auxiliary PWM (APWM).
This series adds the PWM driver support for the APWM feature for eCAP on
AM33xx. AM335X_ECAP0_IN_PWM0_OUT is used to enable the backlight.

2. Enable eCAP0 PWM and LCD pin muxing to support splash screen on
AM335x EVM[2].

3. Add lcdc, panel and backlight nodes for AM335x EVM.

This series doesn't contain defconfig changes since we don't want to
enable LCD, splash screen and PWM support by default.
Enabling splash screen and PWM support in defconfig causes u-boot crash
on AM335x based beaglebone black. This will be handled in a separate
patch.

[1] AM335x TRM - https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
[2] AM335x EVM - https://www.ti.com/tool/TMDXEVM3358

Sukrut Bellary (3):
  pwm: ti: am33xx: Enable Auxiliary PWM using eCAP
  board: ti: am335x: Enable eCAP0 PWM and LCD pin muxing
  arm: dts: am335x: Add nodes for lcdc, panel and backlight

 arch/arm/dts/am335x-evm.dts |  15 ++-
 board/ti/am335x/mux.c       |  49 +++++++++
 drivers/pwm/Kconfig         |   6 ++
 drivers/pwm/Makefile        |   1 +
 drivers/pwm/pwm-tiecap.c    | 198 ++++++++++++++++++++++++++++++++++++
 5 files changed, 268 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pwm/pwm-tiecap.c

-- 
2.34.1

