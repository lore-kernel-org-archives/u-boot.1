Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0754C27C53
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 01:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 478118844C;
	Thu, 20 Jun 2024 03:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XlCfkt9Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1341884BA; Thu, 20 Jun 2024 01:04:09 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFA488840C
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 01:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-421eab59723so2538105e9.3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 16:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718838247; x=1719443047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zrp0t0si8zWgOmGKJCau7uAJmOjzdqLl7syrTXGGibw=;
 b=XlCfkt9ZHCwqmc+xzO+EuPO6HiehHtSj29Gb0zGG+u1ZRpvHezei1N0u65R7PMjf24
 ViDDjLmpXU2oVi7wkFSaZl5YgqouoMwBqoBNfWgKpNn1eWzEkGhR7fBZliPq+1y2eNBf
 ZmUct9u3BjUdejnvem44t/uRkqJcWmS/jn8Blfa8K/ttyjLB42SJBkKIoNHqDhsIhkAS
 0DR+2L/pi97YV/v6JKjj9fjAB+BrDdj22vqfFUwlMqQ0XqVCzGx6gCXtHI4sXs4MCVcu
 suS2Ne8a/3cEupx32lkv/8bsB1b9cRmwr3wiyXUx2t9LwTKpLDi5HGv+ROjCOarn5mxJ
 9DnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718838247; x=1719443047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zrp0t0si8zWgOmGKJCau7uAJmOjzdqLl7syrTXGGibw=;
 b=qdyn/Fy3X7+sci08J5bJWXBhnu6NqRWYdB564raXBytlk0rng7PbErkYfOHmGwgexm
 UgBgsjiG/pFM11wOXujQrRi+g9XGzBCSb6pYARyz7BWr4tsWPgZ87ExgdNl6xSA2mcW4
 V4nL+luYANB0rd0Vfq7XG5NuEE6oumai3KpMSS9YpnFTQYG9Y0e/UbKc4TbfnKeOcPC3
 MbG3YbWYk68WlSDOXL9DFiNsJvhWOSgXggAg2yxKXOoN7eNGL5AE7PlT2OYVQUsRI6ix
 hbhsT3oME4F4TzcT5mnoOKmmVJ856LA6zw92xk7AZr7TaVDqjaTSZ+7cJL8lQHCHKg57
 sPzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiwX5FH4ljvZZtc8hqkZcqd0+j7IaJP9HCXE9/+zNXwmT56hZqkbTzvTsO9I1OG18buM6wTJT3ICW9DzFTUaUJQ7/3yQ==
X-Gm-Message-State: AOJu0Ywd2/osZZysX+mOYM4bwEtPvrmBzMPv94JZATW2jfptsIYU8QPc
 vrCLKJdoPn7ZciBPuLQaInMQVQgS0Fn4NvuldC0uDa0PETu1STAM
X-Google-Smtp-Source: AGHT+IEyggoteYAY+/8iPJCKshWkqr2uK5jQ/jTbCLXFqyFjxnvR5oj3KNIneGboerdGk+WAxgUEpw==
X-Received: by 2002:a05:600c:4213:b0:421:aace:7a94 with SMTP id
 5b1f17b1804b1-4247529c841mr21625575e9.40.1718838247114; 
 Wed, 19 Jun 2024 16:04:07 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4247d0c54c9sm5410465e9.27.2024.06.19.16.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 16:04:06 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Dmitry Dunaev <dunaev@tecon.ru>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v4 0/9] misc: introduce STATUS LED activity function
Date: Thu, 20 Jun 2024 01:03:18 +0200
Message-ID: <20240619230400.8459-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Jun 2024 03:31:55 +0200
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

(world tested with the azure pipeline)

Changes v4:
- Rebase on top of next
- Rework for cyclic changes on next
- Fix compilation error
- Fix compilation warning due to missing header 
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

