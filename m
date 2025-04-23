Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41D1C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 08:43:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03A64809A5;
	Wed, 23 Apr 2025 10:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ooi0ueft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D462809D4; Wed, 23 Apr 2025 10:42:58 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C9DA8082A
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 10:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbellary@baylibre.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-227d6b530d8so64115085ad.3
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 01:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745397774; x=1746002574;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HUGWyYrn3bCJ5jT+k+8Nm0n5bHvAZrujycHKE4LXhtc=;
 b=Ooi0ueftDuoGSaBiIYfQVXf2luJC1fljo60UNVQCgmywXgbupsSO18FTd3t3Pazths
 MwnH8GqR6k250Wrl7oqyXYJPAiGDn9KhkqPUXa0K0DmZEX8aOipYA44komUb2mNDOrPC
 RWwTqS7gfNEppdNUmICnXcrNv4r4mnZG0/52GidtoErRqtmHTFuciml8iovzh9fnbgon
 GYqKyQAn+u/OTotnJ73sMcOz5uaOJ+YLsYbIhoQQRvxvZjXvmAttrRzwuHaTX+K+M+Xc
 Zwvhnn05NbEvFJvdsgTv7it+h1XsK0qthuccTNQFGgPBUSdVuyMoBhnU56KacUsmevK7
 tKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745397774; x=1746002574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HUGWyYrn3bCJ5jT+k+8Nm0n5bHvAZrujycHKE4LXhtc=;
 b=XS6hyAaZUtrvC4GcFe/HfQm+6xkOQyTutqAz4JF5X2FBsGHhO1M7i0KBv06DMwOHCF
 SlRB2xBesds1Cn8VBYoAO4ycKS/bsz4S0/EkHlZga1vS5S0HHZyiPBQTaZgNR5NibCAq
 4X/AAv6rMgl9CaPgMRSjbz/xKURtJOev9dlUxuayc+spuHEQ4rnL9fsWlfujZqDCs0p1
 IDOTnWY862seMxYHAsnQdRLNGuCLdbEpYW8dl0vBhJtUSjXUnh2sht6gqmbXYD9nbgC/
 oG8e/v5ggTyKZew5UyxzRk5h2sDDCaec3aBZEjOdeMD5Ol0HZaimXMCG2tBdZfR2FL2I
 D0ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6JcREph1wH282lPa8zYEX5z5C1luJuePQc1LGBIrBYoMDqwLqInc3KQAtYzKEs969Q6flucw=@lists.denx.de
X-Gm-Message-State: AOJu0YzT9VotlRd+WwDrT1yt0VJL0q2MabSlmygE66GT9+Fd/bgkJYtb
 1V7PjhZWmu98+agYgmG5+bwr3jhMnerJBwHxizROPIMlsopP+l7eZC17ydLs8Zw=
X-Gm-Gg: ASbGncudlZrS2J6hxB27EawgCOVJMBW5YcLKq0IltgXOfGIgmaerWM+lc59Kp+/WXM+
 1Klv4nJuiKU222eJPa809x5HzlPESnpsxju5tcm9KrCcjid87yzNsx2qeYKFw/tZCY8TC8bhi8h
 aBI74c24Wp5crbKkMyml7iHvXCdkTyUTp6s7spOjFfEetX/VjL2h76VF4fNZfUYnN1qgc0jNExD
 W0i3rT3b22ck0LxhAp3g7fk0mWN294p0gfKXwtVqc5BS4z/K25X//z2EBy1v2UQTqBm3zNEeaeL
 JOYOnpODsMtMvDzY5WTrq0HvjzSoHAk9ojb3qEl3DK5XW2laCCsw/rrrQuth+KkACj7g78TUlSe
 CIoVUi2s7TQf+uw==
X-Google-Smtp-Source: AGHT+IG/zrt27ph4HRHnaRqlYSXyI3ypkifJpTf/gyLjbnDuGuz4z3R75EKEHtF1UvjG8J5oYMqSmQ==
X-Received: by 2002:a17:902:ebc4:b0:223:5c77:7ef1 with SMTP id
 d9443c01a7336-22c53586639mr276628475ad.21.1745397774158; 
 Wed, 23 Apr 2025 01:42:54 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com.
 [76.88.115.8]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdae69sm98860085ad.1.2025.04.23.01.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 01:42:53 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: [PATCH 0/3] Add support for eCAP PWM and LCD pin mux
Date: Wed, 23 Apr 2025 01:42:46 -0700
Message-Id: <20250423084249.197101-1-sbellary@baylibre.com>
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

Sukrut Bellary (3):
  pwm: ti: am33xx: Enable Auxiliary PWM using eCAP
  pwm: ti: am33xx: Fix build warnings in dev_dbg()
  board: ti: am335x: Enable eCAP0 PWM and LCD pin muxing

 board/ti/am335x/mux.c       |  47 +++++++++
 drivers/pwm/Kconfig         |   6 ++
 drivers/pwm/Makefile        |   1 +
 drivers/pwm/pwm-ti-ehrpwm.c |   2 +-
 drivers/pwm/pwm-tiecap.c    | 198 ++++++++++++++++++++++++++++++++++++
 5 files changed, 253 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pwm/pwm-tiecap.c

-- 
2.34.1

