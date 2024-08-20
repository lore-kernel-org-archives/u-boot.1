Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B9BC3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 13:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED81C88D0F;
	Tue, 20 Aug 2024 15:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GDl0x7U6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E8D85B66; Tue, 20 Aug 2024 15:40:23 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A12AC88D0F
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 15:40:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-428101fa30aso44454365e9.3
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 06:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724161219; x=1724766019;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=N9AzE/hYQ2PM1y1NkUjZAfv+j9m2nW3h545v/snbjJc=;
 b=GDl0x7U68fjPrF0f0Ssgok2QMlQhU4xEnT4xBCcrix/fyftO0F9XYsNJAubWQbpFgX
 PBoRks6cTaJirqB+RVlloR1xw0gR3rH1bg76xUMy2CpU+ouDznYMhKcUd0Jv6bjnXLmt
 1/a/OibgCDo0EuFkEMz/pM4NswvXB68QqFEJBTeG2v8RnS3AvUGayRseg9SgbhuEgEzJ
 shqlsGcVKLDryYLAgYsOwSvzsAJfYQpIC3pZA0kLi70H0X31k4TVnQkjIqdCT+t3xZRJ
 S1Hj8NAYC2zZS5wHmI66fjqtBSNUxanCVeIyLASZ0Kj0NWVF+ST/mGKcJt6WxSN+JVW/
 SomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724161219; x=1724766019;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N9AzE/hYQ2PM1y1NkUjZAfv+j9m2nW3h545v/snbjJc=;
 b=evv6dAvSNnK9fr9MP3uORwWeWUzYGPOI2JNmn9QjqMzAyY7FDBX0r/CN5rRGOGOJli
 ARun8n1yKATzJGvDO3N5k/Kt2uQWu8y4ldRUaUizLzig+ycQmYBxCC8CaTgPLCGQo4PY
 zuzeZ53ILDF3kCybZrmYuKLtthfxpcTbXdoyQ2iDeB9tLNNLoSaBST3tGVx3TkShCSZr
 FEbD7XVcKUdfXVe+yCfSYfoAOCpkBo666UUK5qu5ataErC2DQWR1eIo4lS637pfVuZLa
 Rm8Ftpm+soO12IOJ7kisQSWDtnvbqbOkeos1EPD40r+4Wm9MWr02N4R42s0gH9NQKsxr
 HqWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG7ig/1Y22vkqE/K1ExEq7n0mfzV3y4tVO0oPE7AlmkKD9NkV6tM/udoUgNUSVZJPwt+05PWY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2q8W2BZXcLYJY22E+29wHlDA4BYyUjC3sjj3bgbjqgp5WWbl0
 QH+vXTcM/KUN5rwyzWYDTHYPq40B6AXh85Z3I3uhO77bAIgLYZLwE02vh4B6NXc=
X-Google-Smtp-Source: AGHT+IF9QTDGswbN1OOaKF7GIr/1nqGUb8hnWOQyF5nQ8NX8f2UGjlX2sy1WYwX8ao4w2aVo4NXNjA==
X-Received: by 2002:a05:600c:4692:b0:425:7bbf:fd07 with SMTP id
 5b1f17b1804b1-429ed7856b4mr107345175e9.5.1724161218519; 
 Tue, 20 Aug 2024 06:40:18 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded71ee3sm194756765e9.29.2024.08.20.06.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 06:40:17 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Zixun LI <admin@hifiphile.com>
Subject: [GIT PULL] Please pull u-boot-dfu-next-20240820
Date: Tue, 20 Aug 2024 15:40:16 +0200
Message-ID: <87r0ajuxbz.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Please find some developments for next:

- Migrate Atmel usb gadget to DM_USB_GADGET
- More small cleanups/improvements on the atmel UDC driver
- Change udc uclass name from "usb" -> "usb_gadget"

CI job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22060

Thanks,
Mattijs

The following changes since commit 6f4c31c2b658358628b5b0fa801f55c7477c7585:

  Prepare v2024.10-rc2 (2024-08-05 18:13:42 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-next-20240820

for you to fetch changes up to 73f5b54a589cb6ff97aaca55e7c97d68b43997ee:

  usb: gadget: udc: Fix duplicate uclass name (2024-08-20 09:36:36 +0200)

----------------------------------------------------------------
u-boot-dfu-next-20240820

- Migrate Atmel usb gadget to DM_USB_GADGET
- More small cleanups/improvements on the atmel UDC driver
- Change udc uclass name from "usb" -> "usb_gadget"

----------------------------------------------------------------
Zixun LI (8):
      usb: gadget: atmel: Sort includes
      usb: gadget: atmel: Replace printf() and pr_err() by log_err()
      usb: gadget: atmel: Fix typo in usb gadget driver register and unregister
      usb: gadget: atmel: Move usba_udc_pdata() with other static functions
      usb: gadget: atmel: Rename atmel_usba_start()/_stop() to usba_udc_enable()/_disable()
      usb: gadget: atmel: Add attach/detach support
      usb: gadget: atmel: Add DM_USB_GADGET support
      usb: gadget: udc: Fix duplicate uclass name

 drivers/usb/gadget/atmel_usba_udc.c | 256 +++++++++++++++++++++++++++++-------
 drivers/usb/gadget/atmel_usba_udc.h |   3 +
 drivers/usb/gadget/udc/udc-uclass.c |   2 +-
 include/linux/usb/atmel_usba_udc.h  |   2 +
 4 files changed, 215 insertions(+), 48 deletions(-)

