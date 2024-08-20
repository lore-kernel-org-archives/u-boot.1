Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4D4C5320E
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 07:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4417B88701;
	Tue, 20 Aug 2024 09:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c9WFmwiJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827E68841E; Tue, 20 Aug 2024 09:16:18 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 780CF88D5D
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 09:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-428243f928fso56401085e9.0
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 00:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724138174; x=1724742974;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=L+gFY/6gbbR6jWCxAWJC8YYpAlvl5iQhbLU7OzgGvx4=;
 b=c9WFmwiJhbZmoDuGxAb6NIXn4GprI4V7sb2V2lTMaecytfAzzcKfzv5vx+s60ks1QW
 aQsfDDcVjWIF7LOtW/AwyW63KFw9IDfrumyFVI1C0TwrU+9iYmyUN+xLTTj6k6X1lZh5
 /UMi3o5PxcOSsPWoIhTL13VUsszshmniMbJSCtjvqckIgvVqP6p0lbRl+Fl1S4D06Nmi
 7WnVa8bCNQl29/a5As1+aJwk0iC62rAmKWflBYhHyLp0MGz5qs1sPabX62//NKp5caT7
 ykZRSpnUVBW11wUKQDXqmh1PuuGgwR3xeEJl/Oh7I1+mKV9HKRDPu+3/vjSLD3wzwOhE
 bxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724138174; x=1724742974;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L+gFY/6gbbR6jWCxAWJC8YYpAlvl5iQhbLU7OzgGvx4=;
 b=RSrUt0lKPKPiC6BhVlJQsT/Qw3ig0gOMz0scne+PIBI9IPxOI51LFkMk8HSPSURUbu
 J2rgHEduz+soDYODdFjHzlthVhyQzEJMLh4cCqXzRWb5pFxUIpFC+sXsqS/RBIcMnGvS
 dTWWvOJzB5KJ+VA1xG/5278g0KW+Sv3qB3Gv8SvzCaEcm3cY7nFN7n8XJI4QSwzzlQeM
 Z4pCj5gxNHTsyB8/GK1u4hRJPLs76rKa8bUW+XaISBUqt/Ka1fU4rWRg9HBE0C7l7SWh
 kW6EtE64w9tbnEeVojZ9bs+heHXfYy36agpk2HSg/EG4SGiHWwHIzTr7r3iemL6SFmY9
 MQHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6w79SebyyQ80kAWzGy0y1Il+J7b1rVT3OmqZoG0+OmPXoc5Jhpx1xmwRu1CykT8/7MkdeaB4=@lists.denx.de
X-Gm-Message-State: AOJu0YyoomGY0HX0wJRISifMYWxQH3eGwdfUUvb58qf+Jk2t/9f5ZymJ
 3tZ2tMOJppA8rtEqbXj66z40Qd8C80m4CzAYymyKhVV5oLG5eMUFBP4/stZ4wqI=
X-Google-Smtp-Source: AGHT+IE5LUgh2akYqakl/00ebZSRABznJxlP7RXD0CenED16P5r0avLWHe6/cYnN9wIbxFetvFk0KA==
X-Received: by 2002:a05:600c:4f12:b0:426:545b:ec00 with SMTP id
 5b1f17b1804b1-429ed7b7860mr106631355e9.19.1724138173413; 
 Tue, 20 Aug 2024 00:16:13 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718989705bsm12403724f8f.72.2024.08.20.00.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 00:16:13 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Michael Walle <mwalle@kernel.org>,
 Zixun LI <admin@hifiphile.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20240820
Date: Tue, 20 Aug 2024 09:16:12 +0200
Message-ID: <87zfp7vf43.fsf@baylibre.com>
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

Please find some fixes for master:

- Fix crash in BCB on invalid block device (reported by coverity)
- Fix booting Android kernel without a ramdisk using fastboot
- Delay ethernet gadget driver init to ensure interrupts are available
- Fix ux500 gadget driver ops based on CONFIG_USB_MUSB_HOST

CI job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22057

Thanks,
Mattijs

The following changes since commit 6f4c31c2b658358628b5b0fa801f55c7477c7585:

  Prepare v2024.10-rc2 (2024-08-05 18:13:42 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20240820

for you to fetch changes up to cc4424db44f62edfcb96fef16102ad769a3909de:

  usb: gadget: ux500: Do not redefine ops if CONFIG_USB_MUSB_HOST set (2024-08-20 08:08:57 +0200)

----------------------------------------------------------------
u-boot-dfu-20240820

- Fix crash in BCB on invalid block device (reported by coverity)
- Fix booting Android kernel without a ramdisk using fastboot
- Delay ethernet gadget driver init to ensure interrupts are available
- Fix ux500 gadget driver ops based on CONFIG_USB_MUSB_HOST

----------------------------------------------------------------
Marek Vasut (1):
      usb: gadget: ux500: Do not redefine ops if CONFIG_USB_MUSB_HOST set

Mattijs Korpershoek (1):
      cmd: bcb: Fix segfault on invalid block device

Michael Walle (1):
      boot: android: fix booting without a ramdisk

Zixun LI (1):
      usb: gadget: ether: Handle gadget driver registration in start and stop

 boot/image-android.c         |  7 +++----
 boot/image-board.c           |  4 +++-
 cmd/bcb.c                    |  4 ++--
 drivers/usb/gadget/ether.c   | 15 +++++----------
 drivers/usb/musb-new/ux500.c |  6 ++----
 include/image.h              |  2 +-
 6 files changed, 16 insertions(+), 22 deletions(-)

