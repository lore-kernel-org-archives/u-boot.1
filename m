Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4861AC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 19:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E5C388BD4;
	Wed,  7 Aug 2024 21:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jydtleDz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E39F88BCC; Wed,  7 Aug 2024 21:54:25 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6379C889D4
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 21:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42817bee9e8so1604495e9.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 12:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723060462; x=1723665262; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=agL8tcD0WovvcJqaPfx5OrcwS3LrB0IgWFY20vwIEC4=;
 b=jydtleDzUKUNEHIpZVN5GykLA4HBiwxJK99A4WqK2akvBBGFqSzbg38wwUizLKMgpY
 +DO7fPgj+f/+QXJ6huoHr0XTV7Sp7tZ4BmB6NfxO2mMSOHfiVoxrABL7Too/KQ21qOmc
 0vh7JAknIhzUg+r2SJt15kyM7p7TU6+c5nT0rim7fDWcfVFterfbK0YB0Q2RegpnmKc2
 X2VPwEQ0jsKmSgjZGEzQy55RfG3E2FalVEkOUpu8C/unWxlrDXIbBR1TCpOr74ZyIcLc
 4cQAsMncayAiC5eVm5bhOA3/zMhMuRZimnzIR5+h3VUbMeyCKQ/J5yxwOtnQiy2lgkqa
 e1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723060462; x=1723665262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=agL8tcD0WovvcJqaPfx5OrcwS3LrB0IgWFY20vwIEC4=;
 b=CirMdqUoy20G0HQFeCYRUXgQGkkfapwYj71B6Xkki/3eAwkXUHHluDUguYcCTwYQwi
 9g4GRakG3tV8EbIQKjal5xV0IgPm6cNIWi1FSHH0B+18CUsZ4bdBmy7vLb5Tz3LEiCh/
 fTOES8goYoh1i61xG97l5yqdwskv0nwYMRZZOzX10Fj0s+3cIoHxQjGamyQRWlgm2vpe
 sBwiqCMBAMCyDFX0EkNalMB0kIRV83CZT1mYzjtvx6/kRqMFwzwJtPp+1L8zwgNiZhmn
 n5Ky57Y9YG4c2wDIFsfYdurYD4y1hUkgaujrT70NeDeyhe7GrmTb8bYpBdmm4tksepg6
 QR7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfCYEIggDzt2FHrRllNiYovBWYUKt8yMHNxOw3+ar14/pWh6CXunAq8FksVVxo5uNcMEW3+/UKIzasXJlmxlYfbE6YSA==
X-Gm-Message-State: AOJu0Yw0W8/i+FyO+6DcJ5kLGeNWop8ZjTj9AUbFAiqiP4ggrAep9MQN
 ytzaXhDpMJydxxeC0BhqSW+5XN65fMGvGhVyCOhAjgddlolp1U9k
X-Google-Smtp-Source: AGHT+IGVKfJWf5y3eyVBRYxZ1S/64TkpwKb1DWFLhPADiwWC4nH0QYvOdufabspsGhmLE1Rd0ENSkQ==
X-Received: by 2002:a05:600c:470d:b0:428:10ec:e5ca with SMTP id
 5b1f17b1804b1-428e6b0870emr121021345e9.14.1723060461795; 
 Wed, 07 Aug 2024 12:54:21 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-429057a8802sm44383765e9.21.2024.08.07.12.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 12:54:21 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: [PATCH v2 0/9] led: introduce LED boot and activity function
Date: Wed,  7 Aug 2024 21:54:03 +0200
Message-ID: <20240807195413.30456-1-ansuelsmth@gmail.com>
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

 cmd/mtd.c                  |  19 +++++
 cmd/ubi.c                  |  15 +++-
 common/board_r.c           |  25 ++++++-
 doc/api/index.rst          |   1 +
 doc/api/led.rst            |  10 +++
 drivers/led/Kconfig        |  41 +++++++++++
 drivers/led/led-uclass.c   |  28 ++++++++
 drivers/led/led_sw_blink.c |   5 +-
 include/led.h              | 144 +++++++++++++++++++++++++++++++++++++
 net/tftp.c                 |   7 ++
 10 files changed, 290 insertions(+), 5 deletions(-)
 create mode 100644 doc/api/led.rst

-- 
2.45.2

