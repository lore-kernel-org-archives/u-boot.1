Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0A7C531DC
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 15:10:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17C1588D7E;
	Tue, 20 Aug 2024 17:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HLnq3pyX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86903888FD; Tue, 20 Aug 2024 17:10:00 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21CD888D83
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 17:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42809d6e719so47698085e9.3
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 08:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724166597; x=1724771397;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q6ojB5FefNhJixGdoSnrGKFw00BJFv+UGeYIIPH1gus=;
 b=HLnq3pyXw6nqb0mGdjb98YRFGOVfQSL2hbJaausXCd8QtUdpWIxVdU0DxkqvDh39JW
 MBt3flN5wJJKaK2wCUpNvewDv8Ff6HDADOFQqUzsaRK+gA53UJ2Rotp3dE3tsAVgPSHU
 a7JOriuQkyvoPbxDsObJTtBHoX//o9FUlVfe/BzJkcqKsfQ9F7bLsciO57XX46Gya1Qv
 efngFkCtp9VlX08oJLxbbDu5nYhTG5+q7MOYHFIZC0R/sL0CYgkaVmliEvrFghU/ZD2a
 539tXs+toyJ/iyLjH9lSDKb+bST0V1D/zVq4nyQKnRDw7CHCMlf/l68I+C+euH3a6NuW
 KqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724166597; x=1724771397;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q6ojB5FefNhJixGdoSnrGKFw00BJFv+UGeYIIPH1gus=;
 b=C2Boz93lfyibJ6ospk/RBYOElHUNYzUeTdxXWfD82JAI6feWosxPm20DtKHSFgTdHz
 FllDS+oNQ6F67QsS7VAxnmJpJE5BHgAx05tqMO2wWovjMrc/1pRVozpV3TNM4SgkN2Mg
 HyeT/8J5Ux4WmGGXy8V6cE5wVg8AULzIJGnL0cICSbBrnDGEed5Js5f3alqivV7uKOEO
 QxzkMeI2Q+65s0v3exg3zYazqRryY0het954qFiS1II9AvxBIcOJc4kcNIAhjU8ekvc0
 ZxuG7bzBgBGPMCnat7kSfDo/H2wN8ABxP8YMxz2LXckX0+jo7VKr3NBy14rMANCoik0A
 UzQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdX30scVSYSVO8rRPqUPepoRMZIrH3TKyHyyqqqV8azwb2x7ImiCcvzyJC8BSdP9IO82RG5kNFELccOJVislvmswiQFw==
X-Gm-Message-State: AOJu0Yx2gMrQEustNQFWmCYPIctyXAbSNUYFp7C7f0W1U1uqN0gIX66K
 EXfE8wjMKp1VfjipKbPIOIcrDO9s4PhmQgle3d/vsD6ly3tH459JSckKo4qftBk=
X-Google-Smtp-Source: AGHT+IF1H7InasxdKg1MxF5G3+c8T4EIjvNownfCp9SBoTP9HLdzQCR/mRllk1Eldjc5xgGf50NaeQ==
X-Received: by 2002:a05:600c:1911:b0:426:647b:1bfa with SMTP id
 5b1f17b1804b1-42ab670e2f3mr19682175e9.8.1724166596726; 
 Tue, 20 Aug 2024 08:09:56 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed649004sm146377195e9.4.2024.08.20.08.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 08:09:56 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Michael Walle <mwalle@kernel.org>,
 Zixun LI <admin@hifiphile.com>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20240820
In-Reply-To: <87zfp7vf43.fsf@baylibre.com>
References: <87zfp7vf43.fsf@baylibre.com>
Date: Tue, 20 Aug 2024 17:09:55 +0200
Message-ID: <87o75nut6k.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On mar., ao=C3=BBt 20, 2024 at 09:16, Mattijs Korpershoek <mkorpershoek@bay=
libre.com> wrote:

> Hi Tom,
>
> Please find some fixes for master:
>
> - Fix crash in BCB on invalid block device (reported by coverity)
> - Fix booting Android kernel without a ramdisk using fastboot
> - Delay ethernet gadget driver init to ensure interrupts are available
> - Fix ux500 gadget driver ops based on CONFIG_USB_MUSB_HOST
>
> CI job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22057

Please hold on before merging this. There seems to be some ongoing
discussion about
https://patchwork.ozlabs.org/project/uboot/patch/20240726083102.380719-1-ad=
min@hifiphile.com/
on irc [1]

I'd like to sort things out before this gets applied to master.

Sorry for the inconvenience.

[1] https://libera.irclog.whitequark.org/u-boot/2024-08-20


>
> Thanks,
> Mattijs
>
> The following changes since commit 6f4c31c2b658358628b5b0fa801f55c7477c75=
85:
>
>   Prepare v2024.10-rc2 (2024-08-05 18:13:42 -0600)
>
> are available in the Git repository at:
>
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20240820
>
> for you to fetch changes up to cc4424db44f62edfcb96fef16102ad769a3909de:
>
>   usb: gadget: ux500: Do not redefine ops if CONFIG_USB_MUSB_HOST set (20=
24-08-20 08:08:57 +0200)
>
> ----------------------------------------------------------------
> u-boot-dfu-20240820
>
> - Fix crash in BCB on invalid block device (reported by coverity)
> - Fix booting Android kernel without a ramdisk using fastboot
> - Delay ethernet gadget driver init to ensure interrupts are available
> - Fix ux500 gadget driver ops based on CONFIG_USB_MUSB_HOST
>
> ----------------------------------------------------------------
> Marek Vasut (1):
>       usb: gadget: ux500: Do not redefine ops if CONFIG_USB_MUSB_HOST set
>
> Mattijs Korpershoek (1):
>       cmd: bcb: Fix segfault on invalid block device
>
> Michael Walle (1):
>       boot: android: fix booting without a ramdisk
>
> Zixun LI (1):
>       usb: gadget: ether: Handle gadget driver registration in start and =
stop
>
>  boot/image-android.c         |  7 +++----
>  boot/image-board.c           |  4 +++-
>  cmd/bcb.c                    |  4 ++--
>  drivers/usb/gadget/ether.c   | 15 +++++----------
>  drivers/usb/musb-new/ux500.c |  6 ++----
>  include/image.h              |  2 +-
>  6 files changed, 16 insertions(+), 22 deletions(-)
