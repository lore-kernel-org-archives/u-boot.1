Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442F8C27C78
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 02:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 140D5886BB;
	Wed, 12 Jun 2024 04:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VGldz02h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E2C388744; Wed, 12 Jun 2024 01:14:52 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2925487B30
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 01:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-35f223e7691so197682f8f.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718147689; x=1718752489; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4klEMCkdukh01l8+VxsqHUhcCHl2YHYkzoK75ub9YzU=;
 b=VGldz02hocp+fZwN8xtRQAI+C1WlzEW1MjIjdP7MpcvOW+MdFx/24TeQhXTk91URiK
 CtKIKwmfFPGjIF6gvmMblH8o979seGRwjIGrUnSdWT0M00cD0fU1f/66Y0DZN09djRIL
 jVzpeztQTPSKVqPwfTDoK72yQ4sgSS8Bq3ayuMRS959dzFIoElcjjEbxmvr2rrBqWDrp
 l4mGDRNkuHx8wm5bTUCPWQFNQqkWpB1aWuaa6jaPiasOHRVtlLmC3iFRE8xNSqLZR7pi
 qpUiSKVvWIcTnvJwFMayNnizxcDXFQpd+HkUo6T4oQzg492BfKPBV78a+xmVZbXiDJT/
 1rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718147689; x=1718752489;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4klEMCkdukh01l8+VxsqHUhcCHl2YHYkzoK75ub9YzU=;
 b=ObBIbD2no/nM+KTz+zrGgCrmiMQbF4y+eWKAmQyGcxRSkF23OuXix483fLqA9AwF1y
 TwmX422rS3TFfJvgYdT94ywaHw287GXSahulLhnt2ezPeG8kFxx9TjIE3/mWCfbqT2v4
 p2smHO2cKCmJ6DdHqlkw5egbs2Pd9C+ozbA8XHjfqrXa/pKhEa91dZjZex7zl1Dh/4vH
 raUCrRgyWpY9WkIR64t6oysX2lPVATmCXWXehMYKYtSgUc5zhjdJKGzd5sEX1qMDbRpv
 x8jssKOLkA3HMuVHe2uZ/sWa9Blwfwx42+0OeSpU/bSGFrijlLjg/BgiisRt/YbsJNOb
 qhUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgCJNVfHigRbOHLvrFW/32Yo9cDFyIpQpeNqjjZBBTboSqMdOpTy64hbVLYCZikP/Qr0+zETeduEhLGu0hWG5Z4Us8sg==
X-Gm-Message-State: AOJu0YzCRkec8GpP3VS2yEiHh8WqAFbz5ic/LqgpLSxQxGV6f5uMmtCV
 XfbxtAeHOAw/dYlgWH+JJESaZGlt82Cs8FTMGAuiNfrcgYCiZx5U
X-Google-Smtp-Source: AGHT+IFUtR9BgNQcVLy7JDRkZgDeEvqwQI7nEMxF0bYDbPUkqcW9aVHWCi6+U47496TelgyxY2W/Sg==
X-Received: by 2002:a5d:584e:0:b0:35f:2ac4:732f with SMTP id
 ffacd0b85a97d-35f5db92d0bmr305359f8f.24.1718147689234; 
 Tue, 11 Jun 2024 16:14:49 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-35f231d5761sm7052096f8f.35.2024.06.11.16.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 16:14:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Simon Glass <sjg@chromium.org>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Stefan Bosch <stefan_b@posteo.net>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v3 0/9] misc: introduce STATUS LED activity function
Date: Wed, 12 Jun 2024 01:14:15 +0200
Message-ID: <20240611231435.10366-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Jun 2024 04:33:23 +0200
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

This series expand the STATUS LED framework with a new color
and a big new feature. One thing that many device need is a way
to communicate to the user that the device is actually doing
something.

This is especially useful for recovery steps where an
user (for example) insert an USB drive, keep a button pressed
and the device autorecover.

There is currently no way to signal the user externally that
the bootloader is processing/recoverying aside from setting
a LED on.

A solid LED on is not enough and won't actually signal any
kind of progress.
Solution is the good old blinking LED but uboot doesn't
suggest (and support) interrupts and almost all the LED
are usually GPIO LED that doesn't support HW blink.

To fix this and handle the problem of device not supporting
HW blink, expand the STATUS LED framework with new API.

We introduce a new config LED_STATUS_ACTIVITY, that similar
to the RED, GREEN and others, takes the LED ID set in
the LED_STATUS config and is used as the global LED for activity
operations.

We add status_led_activity_start/stop() used to turn the
activity LED on and register a cyclic to make it blink.
LED will continue to blink until _stop() is called.

Function that will start some kind of action will first call
_start() and then at the end will call stop().
If (on the broken implementation) a _start() is called before
calling a _stop(), the Cyclic is first unregister and is
registered again.

Support for this is initially added to the tftp, mtd and ubi
command.

This also contains a big fixup for the gpio_led driver that
currently deviates from the Documentation and make the
coloured status led feature unusable.

Changes v3:
- Add log on Status LED error conditions
Changes v2:
- Add Documentation conversion
- Rework to Cyclic and simplify implementation

Christian Marangi (9):
  misc: gpio_led: fix broken coloured LED status functions
  led: status_led: add support for white LED colour
  led: status_led: add function to toggle a status LED
  led: status_led: add warning when an invalid Status LED ID is used
  led: status_led: add new activity LED config and functions
  tftp: implement support for LED status activity
  mtd: implement support for LED status activity
  ubi: implement support for LED status activity
  doc: convert README.LED to .rst documentation

 cmd/legacy_led.c          |   6 +
 cmd/mtd.c                 |  19 ++++
 cmd/ubi.c                 |  15 ++-
 common/board_f.c          |   2 +
 doc/README.LED            |  77 -------------
 doc/api/index.rst         |   1 +
 doc/api/status_led.rst    |  35 ++++++
 drivers/led/Kconfig       |  30 +++++
 drivers/misc/gpio_led.c   |  41 +++++--
 drivers/misc/status_led.c |  75 ++++++++++++-
 include/status_led.h      | 231 +++++++++++++++++++++++++++++++++++++-
 net/tftp.c                |   7 ++
 12 files changed, 440 insertions(+), 99 deletions(-)
 delete mode 100644 doc/README.LED
 create mode 100644 doc/api/status_led.rst

-- 
2.43.0

