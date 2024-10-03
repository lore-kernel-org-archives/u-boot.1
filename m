Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88A1CF34BD
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 17:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 293BB88EAB;
	Thu,  3 Oct 2024 19:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1NaFtLUL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACB1688EE0; Thu,  3 Oct 2024 19:45:42 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D8AF88EAB
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 19:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cb5b3c57eso11795215e9.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727977540; x=1728582340;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rSxmpJwIbUKXr+wwb86OomSFcFjadeAH8uBTz5hMExg=;
 b=1NaFtLUL1viq6ZSEW74ALLUw+6Os8xqhkQubmRiw8vmd6hMwKl4mCN6dTVghZAhsEg
 iE8MJyPwakCoBnCLNgG8BJ+CLpf2FEZyu4Fnlg/4hbgcrXcUix3JoXecvzPU/TO9oUfJ
 MqIPFfJ9EAV/gPfYQdnhnvzn9h9XRgF4gHivQTl6oygRXS+jperCKELfh6FrlbsqMKR1
 5iR8eHz/Hzp16gVl7UMpmCCQlHlLuJD582XJPX+H+X30+As7FM2qOh4YnLXLgapagBHQ
 1G34QvI4BfhpjuH4KobdCZQFX5R3ARjNmovqemhw1+8JYwnHtz4iwEVrcCYuQJWaGmVO
 OCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727977540; x=1728582340;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rSxmpJwIbUKXr+wwb86OomSFcFjadeAH8uBTz5hMExg=;
 b=Pfrub+DoYLA0v4bXz6iNgoVdQqMEd/3viRRn4TY5pp2F7STOU7ZcSsZ2CVyooZ7IjV
 8ZXsvxH6yJ1iDSsgfGQByDhhrbmDQDH4sYYZZPAH5Rc0TdDxM4HaIvoUqgIN6N8KDEIR
 0n/eoRZ4IEKcKwBQwKp9UwLcOUarNfC0fgzIt+dBORUOoPgLc0NZ2NTZaZNw0eQcLOUi
 wG+B2g5PDPJnrtRD823258I5qIecGB73Nmks2rP/nsGDExvwTaHiWR87DY53CFI8AMS3
 5YfOWCFkQDvBDyKot+hGf6WxNFNiF6VkPwyL25PTuph9NngBdqa4Qa7l8omB0ML0V583
 FOIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUp3aUH8Xkdk8+LSvIFwanCZABNSg48Iw9xzrcvgMYmvP/rOoyWyVL6Qyp/iBayoIJEHLOtwo=@lists.denx.de
X-Gm-Message-State: AOJu0YzVdx2GVk/v/TSbbOr+l53feAXBlCnTgi2a+EzKtD8Y0boBC3+i
 EOqMTOlmnk+iKx2h7yvvWYmAnNhkZ6lC/Wx6GGgEccXneU8OdG/dkNefi+fNozw=
X-Google-Smtp-Source: AGHT+IEU2UJ/MObVxg+JF8ndlpFBWplnPqw7BnAi4f09KN7siLPTuBKoqIrV1wKnA30WMz59GSFxJg==
X-Received: by 2002:a05:600c:6b18:b0:42c:b55f:f7c with SMTP id
 5b1f17b1804b1-42f7ba0ebe8mr45921365e9.15.1727977539784; 
 Thu, 03 Oct 2024 10:45:39 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:2b24:7f52:e3f6:e4ef])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f7a01f4fasm49614725e9.38.2024.10.03.10.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 10:45:39 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Heinrich Schuchardt
 <xypron.glkp@gmx.de>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>
Subject: [GIT PULL] Please pull u-boot-dfu-next-20241003
Date: Thu, 03 Oct 2024 19:45:38 +0200
Message-ID: <87iku9xepp.fsf@baylibre.com>
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

Here are some new developments for next:

DFU:
- Reinitialize only if dfu_alt_info changed

USB Gadget:
- New usb gadget driver for Renesas USBHS
- Simplify kconfig deps for CMD_USB_MASS_STORAGE

Android:
- Provide bootloader version to android via kernel commandline

CI job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22516

Regards,
Mattijs

The following changes since commit 3a0b829efc35227b1079a444f00e0729502197ad:

  Merge tag 'v2024.10-rc6' into next (2024-09-30 17:48:12 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-next-20241003

for you to fetch changes up to c74758ccc091402b558b9aa7eaf1c50171d2f49f:

  cmd: simplify CONFIG_CMD_USB_MASS_STORAGE dependencies (2024-10-03 10:01:35 +0200)

----------------------------------------------------------------
u-boot-dfu-next-20241003

DFU:
- Reinitialize only if dfu_alt_info changed

USB Gadget:
- New usb gadget driver for Renesas USBHS
- Simplify kconfig deps for CMD_USB_MASS_STORAGE

Android:
- Provide bootloader version to android via kernel commandline

----------------------------------------------------------------
Heinrich Schuchardt (1):
      cmd: simplify CONFIG_CMD_USB_MASS_STORAGE dependencies

Mattijs Korpershoek (1):
      bootstd: android: Add U-Boot version to cmdline

Rasmus Villemoes (1):
      dfu: define a callback function for the dfu_alt_info environment variable

Vitaliy Vasylskyy (1):
      usb: gadget: usbhs: Add Renesas USBHS device driver

 boot/bootmeth_android.c               |   13 +-
 cmd/Kconfig                           |    3 +-
 drivers/dfu/dfu.c                     |   16 +
 drivers/dfu/dfu_mmc.c                 |    3 +-
 drivers/usb/gadget/Kconfig            |    9 +
 drivers/usb/gadget/Makefile           |    1 +
 drivers/usb/gadget/rcar/Makefile      |    8 +
 drivers/usb/gadget/rcar/common.c      |  478 ++++++++++++++
 drivers/usb/gadget/rcar/common.h      |  328 ++++++++++
 drivers/usb/gadget/rcar/fifo.c        | 1067 +++++++++++++++++++++++++++++++
 drivers/usb/gadget/rcar/fifo.h        |  114 ++++
 drivers/usb/gadget/rcar/mod.c         |  345 ++++++++++
 drivers/usb/gadget/rcar/mod.h         |  161 +++++
 drivers/usb/gadget/rcar/mod_gadget.c  | 1136 +++++++++++++++++++++++++++++++++
 drivers/usb/gadget/rcar/pipe.c        |  849 ++++++++++++++++++++++++
 drivers/usb/gadget/rcar/pipe.h        |  114 ++++
 drivers/usb/gadget/rcar/renesas_usb.h |  125 ++++
 include/dfu.h                         |    1 +
 include/env_callback.h                |    7 +
 19 files changed, 4774 insertions(+), 4 deletions(-)
 create mode 100644 drivers/usb/gadget/rcar/Makefile
 create mode 100644 drivers/usb/gadget/rcar/common.c
 create mode 100644 drivers/usb/gadget/rcar/common.h
 create mode 100644 drivers/usb/gadget/rcar/fifo.c
 create mode 100644 drivers/usb/gadget/rcar/fifo.h
 create mode 100644 drivers/usb/gadget/rcar/mod.c
 create mode 100644 drivers/usb/gadget/rcar/mod.h
 create mode 100644 drivers/usb/gadget/rcar/mod_gadget.c
 create mode 100644 drivers/usb/gadget/rcar/pipe.c
 create mode 100644 drivers/usb/gadget/rcar/pipe.h
 create mode 100644 drivers/usb/gadget/rcar/renesas_usb.h

