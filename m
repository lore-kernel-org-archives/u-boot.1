Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9D3CF9C68
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 02:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 268C9880A5;
	Sat, 21 Sep 2024 04:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M63XEOBm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5FB68785E; Sat, 21 Sep 2024 00:51:39 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE98987E30
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 00:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3787f30d892so1525782f8f.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726872697; x=1727477497; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gtjja0gaK9bMQ2q4lwt49Q2We2QuAEI0ObqB0jEI96Q=;
 b=M63XEOBmkCp4m4uR4LP0Yqit+bpbIE2b5zHaQF3Rq9YtI0FxRUijPBMRjhnA7I0cea
 phZ60+rJnkYtDDKu4tCK88VvfWUnXrGjLyb/aJkKvyx4heeUhCfJWNZJoQS556EUZPo0
 ueZKt03p1lhQd3srxnSp9sJsHB4JWQYa5RrcBHu1P+oKvFFAxKFDMGUicqqUxfrws9nO
 ANMLSDw/zCbrXjkYya68wZRZJ0DSyJSaisJXZTVzL0N8WIXsCT95Sy7+vClgFGqLmFts
 l0sJJaDEnVuztkMx1u6CuK6EF7ucHLUCxojhrVktoWQ/1D/lAQQH0dJ1a8ulQFEqlV4I
 9wTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726872697; x=1727477497;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gtjja0gaK9bMQ2q4lwt49Q2We2QuAEI0ObqB0jEI96Q=;
 b=A/TvIHrjgYqTYl0O/MRRCG8We9Q+ehgWsWtp24EJaEzy+dCKFwIvZkR+bD3pQDaLm2
 /z7uqvPDWb+JbKdU3r8m1m0DCAVB67x0DtbG+Yh6EuHp2SjLJpup21QI78mSsEs4iTDP
 leQD1gQ4T50J3V1gt8sPWEPg6XfMsVLrHH0YWddho2TWUzxOz4dwd/z/yaXX4RdK1P7h
 D4LrAcNa3SO+3B/+6OzN0hoBqtjywyK+W2dB8PAuSEXQejzN510FVEahpctYOIK+UqRB
 97yhjCWlZuYbpKeup6cVsjj1MmT2oLGfZBTOyWj6HOqlW1+F4tB015B+cdTV3tK52vqN
 tUXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqZnnDQZp+1SsRm4sVE4bzlbNeb2DaZwK3gfuYpiXNnkDfpxCmROjR58edEcZcS6Ol3LOV6Bg=@lists.denx.de
X-Gm-Message-State: AOJu0YyYZOTlUa0Jy2A3e57HGxsClkCm051B3GDzDif9ZxE+yhVz5o0k
 TUTMWiurQMFATndN8FgmG2iLscXJhIQZSO0OtllRZ3LQFGHPEP4/
X-Google-Smtp-Source: AGHT+IG04avbyPwgpVmL0qmxlJUWXiIJrFsT3Z1h+h0kEDN74qUf76x5U1x5JIBRkIQfsXb16QQ+5g==
X-Received: by 2002:adf:cd0f:0:b0:368:5b0c:7d34 with SMTP id
 ffacd0b85a97d-37a422781fdmr2777162f8f.22.1726872696892; 
 Fri, 20 Sep 2024 15:51:36 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-378e73e837csm18850516f8f.27.2024.09.20.15.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 15:51:35 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sean Anderson <seanga2@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v4 00/11] led: introduce LED boot and activity function
Date: Sat, 21 Sep 2024 00:49:53 +0200
Message-ID: <20240920225101.2008-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Sep 2024 04:37:11 +0200
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

Changes v4:
- Drop led_set_state/period_by_label
- Switch to /options/u-boot
- Rework to cache label and dev in led uclass
- Add multiple patch for additional helper
- Rework patches to limit ifdef in some place
Changes v3:
- Switch to /config property
Changes v2:
- Drop GPIO SW implementation
- Add fix for new LED SW BLINK

Christian Marangi (11):
  led: toggle LED on initial SW blink
  dm: core: implement ofnode_options helpers
  led: implement LED boot API
  common: board_r: rework BOOT LED handling
  led: implement LED activity API
  tftp: implement support for LED activity
  mtd: implement support for LED activity
  ubi: implement support for LED activity
  doc: introduce led.rst documentation
  test: dm: Add tests for LED boot and activity
  test: dm: Expand ofnode options test with new helper

 arch/sandbox/dts/test.dts  |   5 +
 cmd/mtd.c                  |  11 +++
 cmd/ubi.c                  |  13 ++-
 common/board_r.c           |  28 ++++--
 doc/api/index.rst          |   1 +
 doc/api/led.rst            |  10 ++
 drivers/core/ofnode.c      |  33 +++++++
 drivers/led/Kconfig        |  15 +++
 drivers/led/led-uclass.c   | 188 +++++++++++++++++++++++++++++++++++++
 drivers/led/led_sw_blink.c |  10 +-
 include/dm/ofnode.h        |  41 ++++++++
 include/led.h              | 149 ++++++++++++++++++++++++++++-
 include/status_led.h       |  13 +++
 net/net.c                  |   4 +
 net/tftp.c                 |   5 +
 test/dm/led.c              |  72 ++++++++++++++
 test/dm/ofnode.c           |   9 ++
 17 files changed, 594 insertions(+), 13 deletions(-)
 create mode 100644 doc/api/led.rst

-- 
2.45.2

