Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7352CCD379F
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 16:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A6B0887EB;
	Tue,  3 Sep 2024 18:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="vwp9MANd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 230A588B68; Tue,  3 Sep 2024 18:39:21 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1014B88606
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 18:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c260b19f71so2197108a12.1
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1725381558; x=1725986358;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BSys6W4xTl4FjjQmu96nsFoYikPQuFzrJ1acsm3r6iQ=;
 b=vwp9MANddnh//vWcrkcCnEssjRS40dfeShPBhuyiQq9QSlOOcwAssR+n5z/wNCTcS2
 q0eeVu1Rs/VpkwajZn1Y3VDjAjdMQDNCDStgpGOj8/mjnrgfU+ZGJu2uL0VuclAKBgzk
 m2fUYdny7IohnTWsP8tgAY9XIGTHMR1SEXueBeIAp+QyEwsEZW872MAiHX/EFAt4TZ7o
 CTbc6zMOwx8BiWLQT/eLaz/1if3b4F1qvaxZuA+cc2MRNL2FKt85zFL6d+ElRaRV4Km5
 gWQkrSnEUIpAB/eZCRNYBLn/OREAen1FUbdUuQf2x9+g4s8DLrQQwb/bhxRrpF58qOQZ
 wa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725381558; x=1725986358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BSys6W4xTl4FjjQmu96nsFoYikPQuFzrJ1acsm3r6iQ=;
 b=gUCIqhf/a7xlUcF5qtjaCfaVRaVfyLgwYI6zd99pSnqNC4+50U5/hqciWxd+bWJp/f
 BMyaiU2nlfmU6MAxFOYD0dO1GdDsfpzFtwAAWuzhmoOc9dcTfd2DYwZiBGsAY5j/WC8Z
 t93484drI76q0toSjmU3LTL+iMdEIMQjpaAxWQYsa4revnGR7gcDZSfT23cYsnzLHMUB
 eo4/74PAW2+hotEA9p8KHjLLQApAU9nW6aObZQvOdlowsct1y0ma6KApM1LvvsaWmWRZ
 3jjHaQzjtRYB2kz+wBvMwrhrU/d/7JYLBceh4wwo3GfeOUrmIbmCD4VcaYD7+ZfMq2ox
 67BA==
X-Gm-Message-State: AOJu0Yx/h6EBOHz60+aJF6/MLG3rNpRko1Qw2CAUbo1/IiwTEZcah+9a
 mJZwfVLlHX+Rm6IYsSpsaOyJ7fVfRNU0vLe8jQHbKqb/JSgmnvswiMDsR2KUOXTAtgW+fFVax6z
 /
X-Google-Smtp-Source: AGHT+IHdzHOsgbtg4ymgKNtNg5gcVhYF3HvYBjz2opnka9hYRKxkGLyB91Y17tkBf0VPumim7l8V0g==
X-Received: by 2002:a05:6402:13cc:b0:5c2:2b1f:f759 with SMTP id
 4fb4d7f45d1cf-5c243731257mr7631120a12.10.1725381558135; 
 Tue, 03 Sep 2024 09:39:18 -0700 (PDT)
Received: from localhost.localdomain (178-36-242-203.dynamic.inetia.pl.
 [178.36.242.203]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c24b5ad63dsm4177197a12.80.2024.09.03.09.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:39:17 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v2 0/5] Rockchip: Allow to silent TPL/SPL debug console
Date: Tue,  3 Sep 2024 18:38:53 +0200
Message-ID: <20240903163858.1155218-1-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
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

Currently it is not possible to completely silent the debug console
in i.e. PX30, what might be required in some embedded devices
Disabling DEBUG_UART results in errors, due to missing symbols.
In particular, rockchip sdram driver performs calls to debug_uart
functions (i.e. printascii), defined directly in serial driver.
This patch series fixes the dependencies in Kconfig and provides
dummy implementation of debug_uart functions that are linked in case
serial driver is not used.

changes in v2:
 - Update commit titles
 - Create separate SPL and TPL symbols for RAM_ROCKCHIP_DEBUG

Lukasz Czechowski (5):
  debug_uart: Replace debug functions with dummies if CONFIG_DEBUG_UART
    is not set
  ram: rockchip: Fix dependency of RAM_ROCKCHIP_DEBUG
  ram: rockchip: Add separate RAM_ROCKCHIP_DEBUG config for TPL/SPL
  rockchip: px30: Weaken dependency TPL/SPL serial
  rockchip: px30: Fix hard dependency to DEBUG_UART_BOARD_INIT

 arch/arm/mach-rockchip/Kconfig            |  5 ++---
 configs/anbernic-rgxx3-rk3566_defconfig   |  1 +
 configs/neu2-io-rv1126_defconfig          |  2 ++
 configs/roc-pc-mezzanine-rk3399_defconfig |  2 ++
 configs/roc-pc-rk3399_defconfig           |  2 ++
 configs/rock-pi-n10-rk3399pro_defconfig   |  2 ++
 configs/sonoff-ihost-rv1126_defconfig     |  2 ++
 drivers/ram/rockchip/Kconfig              | 25 +++++++++++++++++++++++
 drivers/ram/rockchip/sdram_common.c       |  2 +-
 drivers/ram/rockchip/sdram_rk3399.c       |  4 ++--
 drivers/ram/rockchip/sdram_rv1126.c       | 10 ++++-----
 include/debug_uart.h                      | 16 +++++++++++++++
 12 files changed, 62 insertions(+), 11 deletions(-)

-- 
2.43.0

