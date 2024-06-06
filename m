Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B23C27C55
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B35B28842A;
	Thu,  6 Jun 2024 18:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GS88WLjk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3146687D9B; Thu,  6 Jun 2024 16:30:40 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B8E38840E
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35e4d6f7c5cso1066224f8f.2
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 07:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717684237; x=1718289037; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mWgXTvG034AukjzNz84/iV+vMyqgM7zUXIeuoXMeVwU=;
 b=GS88WLjk9up9R22vLu19sDO0niIX8p2NeDccN+iLTL2zndTVLH6hkv22EJDJM8QTZj
 9Fxdz2TXsXl3Xyx0Uof4RFMC7KyGSZaAWvMjvOOr+m/q/w6KwjIv9HOy7xMN23Q9GVnu
 zIWCEzmi1gUhQbKLxUh50F0SWZej0NNqGPNgeqw318pCLlP2abjG60SKAEXLdjtrok/j
 Rz8FBslI7MTfxVPSc2A+4q9Uoybo+Qw3nN0QgcdAiKZJYYI27EH8GBQfeRQXE0jpY0E6
 qZCWdEm9qJ4IUdFgSWbxLMDiduJtYKZ00adjqinOZarHNcuepZSnQzyFdNkdzjW1pS9V
 k6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717684237; x=1718289037;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mWgXTvG034AukjzNz84/iV+vMyqgM7zUXIeuoXMeVwU=;
 b=tFanJgsdKNQeIxR+giHLR6OmvMtXunEoE9iAybAnIqXEd2DpQH+l4aUQWYVE+R8Qmc
 JrKPTz9U7OfzcuSjr8zAKimoigEDzD43Eke0raITVaxrqA6JN+gAnlXA6GSgxKpMTD1Y
 /nYHKS5LqyXnL4eJHFyEdsdvZJWWiLxGSxJxMvvdTnrcvEMM5XsMxZMHmy9PtuOtu5on
 +4T0Kl1O+e25PGoSysl7ACzlHx8f+V542UwAH4eQyOcmRlDzsu3Or8L0dsJeHHun3R4l
 7PHgZwKzIG0C0Z+FdQspxoFTQH+meAVCc+Awu0xRQBMuEIB2p0MluX+vBYYJCtXA9Fce
 cyVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX66tXyUeaFj/MuhcufTxmw3Eof7Ijf38IpxxXl9Xb0D0uERS1sN1pFuKKdZqlyniasHXaibyGBuxfxDL9vsV4F1DWUUA==
X-Gm-Message-State: AOJu0YzPj+bB4djMzYtnXNZ7fkvKMH+02Jtc+ZtSR32SFweNlInKfBp2
 klpJKELcFKxQjjGzep88d1r2h5zyl4eYP533+suqaztQ+4sL7BRn
X-Google-Smtp-Source: AGHT+IGZTBDEalEUevSbQjHz0ohJOGwqo0REhfpLLGYS/DFob1xpbWmefnUDBQrUO7d9tjDT2VmaDg==
X-Received: by 2002:adf:ea91:0:b0:354:f386:d44 with SMTP id
 ffacd0b85a97d-35e8ef8f15emr4041096f8f.69.1717684237248; 
 Thu, 06 Jun 2024 07:30:37 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-35ef5e989b3sm1718060f8f.71.2024.06.06.07.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:30:36 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Stefan Bosch <stefan_b@posteo.net>, Eugene Uriev <eugeneuriev@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v2 0/8] misc: introduce STATUS LED activity function
Date: Thu,  6 Jun 2024 16:29:21 +0200
Message-ID: <20240606143024.20024-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Jun 2024 18:33:44 +0200
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

Changes v2:
- Add Documentation conversion
- Rework to Cyclic and simplify implementation

Christian Marangi (8):
  misc: gpio_led: fix broken coloured LED status functions
  led: status_led: add support for white LED colour
  led: status_led: add function to toggle a status LED
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
 drivers/misc/status_led.c |  69 +++++++++++-
 include/status_led.h      | 231 +++++++++++++++++++++++++++++++++++++-
 net/tftp.c                |   7 ++
 12 files changed, 435 insertions(+), 98 deletions(-)
 delete mode 100644 doc/README.LED
 create mode 100644 doc/api/status_led.rst

-- 
2.43.0

