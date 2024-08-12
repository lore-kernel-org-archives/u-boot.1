Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED843C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 10:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19B8C886FC;
	Mon, 12 Aug 2024 12:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OweZXTDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9D04886E7; Mon, 12 Aug 2024 12:33:02 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D897B87F19
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 12:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4280bbdad3dso31251415e9.0
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 03:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723458780; x=1724063580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=DC0w/HkG3A+lbYDVUBoPs0Ps/TGiOzYld7bmOlX5S7A=;
 b=OweZXTDVwDdUhSjkJ8Fr4O9B4pcB/llAtb4nHSZuEiCLOCc5l9oZmLjEXmfQfr/8VP
 QnNwdaNhpW6bNVmwUoF7Gz6WLTSlH59yXIWerS1V25xom+siSDNik7lJgNNph4OdzoEZ
 /TqqBwOcUXqe8FSUYS/XwJcutcyJ4wwz1v29YlAfAMQyQ3jB51R8vcSKwTbC3E82+2cE
 tVDjyeyOAkPYb3yIQmfKj9to4hNFtf00qQYgnq7YLMk1X83R0r63Cr4AMb+zwByu64FJ
 n3yItIWDzd6jk0ohD0Okd3bUgDtI7Y2a1X66z7qaywV2uLZo/SL9qW4uk6dyJtma228E
 e3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723458780; x=1724063580;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DC0w/HkG3A+lbYDVUBoPs0Ps/TGiOzYld7bmOlX5S7A=;
 b=FItXdMxzvqACaOvpRUZ4/nLWjOdrgSqDOymAbPW3r4Eo+ypNnPPeH9MLQ34JIRZTzD
 AdK1MvswGukbICWUe8HXX8xkwKtOqCkeU2pQnLdxoaoBhNeXT118GotG6+FKc6NHTu0N
 +BWkren4PIYwauKPZybh5v8hk3iHKLIYSOrlqVRNRcexCAWIc6zmwgPSyX/3QOyRp0yn
 JYdk+R6s+AIx7jqjBlvYfgl2ImnoI4y0BOhez7IT0mdF+ZIZZFK7aRBjPjchNi/msDlY
 oAbnRLmqQBWoPvsdwLmRBGUkMaHMq9fGNoRFV8gvxMQbT+xxV/zL+MKjeu3fZTknXhgS
 HgJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQdTxM8R775ykDvDtOFjhnNu5RR2Co/XBuKvE6UoWNvUMRD+w1okhRftzq0lnAD4UaN/9YS0oYpuGY974rTAGULhw1cg==
X-Gm-Message-State: AOJu0Yxqiat4i2UMPU49l0Q381xABVarTT5jYyQXw3/yCu+yCxcRP+WR
 +ARZiQ8eHPwZmedDxdenOPlVX1U7LkS1YIvbL1IzUwMvZswWdCHu
X-Google-Smtp-Source: AGHT+IHm4Vg081sFEfJkoUGpJYz570Q1okAroiLKu9l8+IznE1XlhRtgRrh5Qlg2Re9oITHWmWdg9A==
X-Received: by 2002:a05:600c:4f07:b0:426:63b4:73b0 with SMTP id
 5b1f17b1804b1-429c3a604a9mr58471195e9.34.1723458779952; 
 Mon, 12 Aug 2024 03:32:59 -0700 (PDT)
Received: from localhost.localdomain
 (host-79-52-250-20.retail.telecomitalia.it. [79.52.250.20])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4290c77f078sm186016425e9.37.2024.08.12.03.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 03:32:59 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: [PATCH v3 0/9] led: introduce LED boot and activity function
Date: Mon, 12 Aug 2024 12:32:42 +0200
Message-ID: <20240812103254.26972-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
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

Additional Kconfg are also introduced to set the LED boot and
activity. Those are referenced by label.

A documentation for old and these new LED API is created.

(world tested with the azure pipeline)

Changes v3:
- Switch to /config property
Changes v2:
- Drop GPIO SW implementation
- Add fix for new LED SW BLINK

Christian Marangi (9):
  led: turn LED ON on initial SW blink
  led: implement led_set_state/period_by_label
  led: implement LED boot API
  common: board_r: rework BOOT LED handling
  led: implement LED activity API
  tftp: implement support for LED activity
  mtd: implement support for LED activity
  ubi: implement support for LED activity
  doc: introduce led.rst documentation

 cmd/mtd.c                           |  19 +++
 cmd/ubi.c                           |  17 ++-
 common/board_r.c                    |  25 +++-
 doc/api/index.rst                   |   1 +
 doc/api/led.rst                     |  10 ++
 doc/device-tree-bindings/config.txt |   7 ++
 drivers/led/Kconfig                 |  41 +++++++
 drivers/led/led-uclass.c            |  28 +++++
 drivers/led/led_sw_blink.c          |   5 +-
 include/led.h                       | 184 ++++++++++++++++++++++++++++
 net/tftp.c                          |   7 ++
 11 files changed, 338 insertions(+), 6 deletions(-)
 create mode 100644 doc/api/led.rst

-- 
2.45.2

