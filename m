Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD63C27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AF1D884B2;
	Wed,  5 Jun 2024 21:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="APdEV65X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E391388300; Wed,  5 Jun 2024 21:21:58 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E760787AD2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4215b0bffe1so909735e9.0
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717615316; x=1718220116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=WTHeBlWVt9sBEz91HX8OWDFtPQsrQI/3C5lJjTUXPvE=;
 b=APdEV65X/sMXaK/9h3r066HGsYhp/C3x6x/ACj2Uj5Mf0R5HWRdIIcyQ8Aoj7RPd6f
 u+4OCIMFOTOJDCurYwV6NHsdakl+fENSl5caDrw8/UK4aFlMmdMZdBjpnbB0cA5zUo1O
 YpOyKevFx+Csb7NRvDwflibg0Y8NloZdyW0Co5ko8vyjktSjsxoWDm/yxbLIo2LXH0Dm
 EQCoEBQrfcAomezxskwxZ8uCCoRR6/cznJLyoYtIsoK73crbA3mahkEr4DnKv+w+6TtO
 VwkwO6EQIC/ROm/8ite9iCR0tke/jaOemM07AfqnHe2Ev5dJ/E/MJI0ofsYT/J5D7nYO
 lbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717615316; x=1718220116;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WTHeBlWVt9sBEz91HX8OWDFtPQsrQI/3C5lJjTUXPvE=;
 b=T90ZQ4H63YHAa+bw/+LhAsFxuLfN+6P6Ex7g080O5udyyF9iNL8ECJX+ZvjPu3T9Z0
 20kO1846BPLJ3K64C4/mprWFh7tfQigsIbFsbu/A8eDuYQ1zeN/igFgq5mDAzaKIq9+8
 rTjfF3H9d1Q+wCV5mwkA4oeg6NDKArySsQS84GOZlg3Y9GxIUGZrNslW1sRWag4TMTVX
 jvwCmHw2asxRNlXq7dmpWjQaYopkhDvV1kSgbFPgU2t2UjiVTtkF6lxdFuNlcTfI3nli
 kUcpEnuFqnafXPki3hQe7jtnJOASO88eJJx3W/j9UvLUpfthW6oLBjGC2++RjItFlPex
 HPIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqpMssZH46MV4bKsdXlNYwXb+uaukNG2nKBkQvUxjkE613B2sFTsCGPctnztB4pfeuzoWUk9q1qR/IVajatT+6vANKuA==
X-Gm-Message-State: AOJu0YwOdyBo6920+8tfbWXKnKL6VFQyvuRyOlQ949QWt0jhK5KhhXmi
 zA+d47dSikelCWqqdk7IR1fKV6J63rmywLJ9F2bCtotV1gQ74gK/
X-Google-Smtp-Source: AGHT+IH8zX9ck4U6nKvd4ZQMT8+LDw5NjuxEFQsPe/KtMMSocpYvVacO4jPRY0mfRl6uikxIneP1bg==
X-Received: by 2002:a05:600c:5254:b0:421:3be5:a6cb with SMTP id
 5b1f17b1804b1-4215acd81a5mr5155195e9.6.1717615316169; 
 Wed, 05 Jun 2024 12:21:56 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214bf5994csm36079625e9.1.2024.06.05.12.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:21:55 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eugene Uriev <eugeneuriev@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Pratyush Yadav <p.yadav@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 0/7] misc: introduce STATUS LED activity function
Date: Wed,  5 Jun 2024 21:21:32 +0200
Message-ID: <20240605192146.19052-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 21:37:35 +0200
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

We add status_led_activity() that simulate software blink.
Any function that signal activity will call this function.
At each call a counter is increased. When the counter reach
the freq value, the LED is toggled simulating a blink and
the counter is zeroed. When the counter reach the freq value
again, the LED is toggled again and so on...

Call to this function is added to the usual operation for
recovery. Currently added to tftp traffic and mtd spi and
nand write and erase operation.

This also contains a big fixup for the gpio_led driver that
currently deviates from the Documentation and make the
coloured status led feature unusable.

Christian Marangi (7):
  misc: gpio_led: fix broken coloured LED status functions
  led: status_led: add support for white LED colour
  led: status_led: add function to toggle a status LED
  led: status_led: add new activity LED config and functions
  tftp: implement support for LED status activity
  mtd: implement support for LED status activity
  ubi: implement support for LED status activity

 cmd/legacy_led.c               |  6 ++++
 cmd/mtd.c                      | 23 +++++++++++++++
 cmd/ubi.c                      | 17 ++++++++++-
 common/board_f.c               |  2 ++
 drivers/led/Kconfig            | 29 +++++++++++++++++++
 drivers/misc/gpio_led.c        | 41 +++++++++++++++++++-------
 drivers/misc/status_led.c      | 53 +++++++++++++++++++++++++++-------
 drivers/mtd/nand/core.c        |  4 +++
 drivers/mtd/nand/spi/core.c    |  5 ++++
 drivers/mtd/spi/spi-nor-core.c |  9 ++++++
 include/status_led.h           |  6 ++++
 net/tftp.c                     | 16 ++++++++++
 12 files changed, 189 insertions(+), 22 deletions(-)

-- 
2.43.0

