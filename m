Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66603C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:46:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AA07882B8;
	Mon, 24 Jun 2024 23:46:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NHf3r1m1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC4EE883CD; Mon, 24 Jun 2024 23:46:36 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC95F882DC
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57d07f07a27so5304891a12.3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719265594; x=1719870394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/duPHX5qTXPdT/KLbVg6/OZgBv39AqLU25LRC4IUDLY=;
 b=NHf3r1m1RJDGMQSbLCG17aWjDRwXDdvbjWIvBbpJQFvRqv/4cNHURULqAkCwKeWjJl
 u4V6HV/60weTp9doBhLCUKVIHtH9noYENx5sGOlsL5IIQG29RccXxDBtChOQPO4cLvjE
 8v5/W+1/Wd5umw1ZjmNRmA6KcVEqtZGrXKlIGuWY0ERAxVtsP0oR7I7a5MzgHiHIP1W2
 z92u1RSf1knraqBHocf0ZvxUXhbCJnAyPSkyDoBeG6qL823rHn+lGboY33PO0qlj2zJd
 7FaHNTy+NS5knNukVlDI7vHmaRAsf6ImcTuytjjEJ0APUcBQhPaeZSQcZEXBGCbRKXxv
 gjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719265594; x=1719870394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/duPHX5qTXPdT/KLbVg6/OZgBv39AqLU25LRC4IUDLY=;
 b=hyMwAb9kfbdBanbXVXbhHeFMJ+QsL0cpZI8mNvTU2/yHy02vcS4pdTmjRSf1fdUYXe
 ufA29FeEIpYiqOvPRt1T5lbipM/7Rru63zfsYzrbpzveM4CtjyMS2a7WAH+9nIeg3l34
 U1fA6hTDvqdbk29Z2cWRMMDquvyfKL8Jsm2IJH8PcqWIC/sG2jXRF/hcrqF1gDSf997R
 Lt7nsfN5ry4lCb59rvs61mICWH+h7kDSYFr1PRMl0l+VqKeKjLENsLuG2f7NLYsSAZnH
 RtRO40s9v3oQ0ia3uNtJqnt8sqHG7q7AsqLvWv4l2fn24JmNMyxOEKPih25wnsBd6hbg
 jUGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvyqnZXj5NeoUm9X9JUg67CMiFZ+4KvMZL4JIXk8LRx5Ibf8FWnD6aWX29Rqlj81PQrEylOyokqrvoqGJ14ZqxUNpsKg==
X-Gm-Message-State: AOJu0Ywt0TvfIi7giBZN5wkt9gWNSpnHyKtagBpbbWmfmfea1GgvC6KZ
 HU0CIhPSNYESgCEAspN+8TfrFMpRRIeG+rJF+Zr6PeqX9OCwXaeQIMT8wA==
X-Google-Smtp-Source: AGHT+IFaubgxj4TaKfO2HhZnjyD5RPlUTB7DLanvaWsP8HoRpQPu8Cl+tp2Q+S7aFgSrDxq+1r7VjQ==
X-Received: by 2002:a50:c01b:0:b0:57d:10db:488e with SMTP id
 4fb4d7f45d1cf-57d4bdce9eemr3605643a12.30.1719265594064; 
 Mon, 24 Jun 2024 14:46:34 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57d303d7b1bsm5100588a12.11.2024.06.24.14.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:46:33 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 0/9] led: introduce LED boot and activity function
Date: Mon, 24 Jun 2024 23:46:10 +0200
Message-ID: <20240624214626.24336-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
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

This series is a reworked version of the previous seried: 
misc: introduce STATUS LED activity function

This series port and expand the legacy concept of LED boot from
the legacy Status LED API to new LED API.

One thing that many device need is a way to communicate to the
user that the device is actually doing something.

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
HW blink, expand the GPIO LED framework with support for SW
blink with the new Kconfig.

Additional Kconfg are also introduced to set the LED boot and
activity. Those are referenced by label.

A documentation for old and these new LED API is created.

(world tested with the azure pipeline)

Christian Marangi (9):
  led: led_gpio: add support for SW Blink
  led: implement led_set_state/paeriod_by_label
  led: implement LED boot API
  common: board_r: rework BOOT LED handling
  led: implement LED activity API
  tftp: implement support for LED activity
  mtd: implement support for LED activity
  ubi: implement support for LED activity
  doc: introduce led.rst documentation

 cmd/mtd.c                |  19 ++++++
 cmd/ubi.c                |  15 ++++-
 common/board_r.c         |  25 ++++++-
 doc/api/index.rst        |   1 +
 doc/api/led.rst          |  10 +++
 drivers/led/Kconfig      |  54 ++++++++++++++++
 drivers/led/led-uclass.c |  28 ++++++++
 drivers/led/led_gpio.c   |  56 ++++++++++++++++
 include/led.h            | 136 +++++++++++++++++++++++++++++++++++++++
 net/tftp.c               |   7 ++
 10 files changed, 347 insertions(+), 4 deletions(-)
 create mode 100644 doc/api/led.rst

-- 
2.45.1

