Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F46C02196
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7184A800B3;
	Mon,  3 Feb 2025 18:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eCYK7e9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 221F9800CF; Mon,  3 Feb 2025 18:37:13 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D78F880079
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ab39f84cbf1so873539366b.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604230; x=1739209030; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ll1rp9VO2aToU0mpTMGZKaQmjhoItd0QDhYPyoQF3G0=;
 b=eCYK7e9rZHssnzbBxVB7XqWcFDJ4vVBQl2u+AGR1QkTCriz4t52r9zsBEcYHoFFFGV
 Y8160yYJfvIQXlMdiY/0Od2wGqy+KCkkAUqC/j3ZgZftalngwKc2T/zzOhLPKqktAtiG
 nFGOeCThqBi2EeTRL0GGNt1fqkJVJg3kxs6CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604230; x=1739209030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ll1rp9VO2aToU0mpTMGZKaQmjhoItd0QDhYPyoQF3G0=;
 b=vh9L0bAmLO9kdXsR4aPe0l7yt1KJOI1ibr6gw3DJDcOedI2lSqz0ZRwhAjFjw0FrI5
 DrXxeKA89FzKEJq+vmbPyeT/p+y7JtyyvPaucMAUhIuM6yQ2/Vzsb3X765mdPEO0/0bB
 e5jm+9hNXZb+Dh9vZNOlUThELt7/oEC7llhLNhPuS+d1gf4cRi1ve7rIqHx5YAxOckge
 13R76b4MLeFrx/Kf0ZCLfLacSuUyJI/aajbVWYUTCttmUFvXKHXaJKuxQNXlD4tiG9Ws
 hLPV9y8s8UeWClHRr9TY4Dg8kn4ArtmiwEp5WRk4oL+ynBBlseRwoIYkUTAyh7XgDUOt
 GtMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGvHZ57k8qnF2xnh9a+9d04vHh4BvmWsF3+AEfv8UetdwQWZLeENk7WorvIRcVLaLv7Z8O90o=@lists.denx.de
X-Gm-Message-State: AOJu0YzGaNXNTMJm9yerKGDE2LUoD26qaNI1JDqxFvn0+R+XhjWaSUpv
 0eJZ9hl1xt1vWpqRwR9D9r/yDhn24MMRDsBJIay6DPJDOgIuRbYI3wYEh5+v09hvQXuLDj8tAmw
 qEc3ia0Rg3jigFs0H0QsAadWZSU9K4Bqjw7hz
X-Gm-Gg: ASbGncvIlvHPWLEJ7zWsz82O/ppd7z0THrfg52Ul5ifjLEMhYUQ6wcqh958+4hi2c8m
 3sq9Z/zzxkKr1eh/b5zen/WoL/X3PWzeDJU3k0Y8r/4nBiTsqkfu2mQobxv/Uc37IHf2VFjWrsA
 ==
X-Google-Smtp-Source: AGHT+IHxfqjXJtn1aWUlFmkmC4UCVbITsteh4BSSw68AfTFiE93NMIqbbgz/MB9UECqSDNfVtks2Onj2+Dj0e9vC3ec=
X-Received: by 2002:a17:907:3fa3:b0:aa6:4a5b:b729 with SMTP id
 a640c23a62f3a-ab6cfd10b54mr2061116766b.33.1738604230165; Mon, 03 Feb 2025
 09:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
 <CAFLszTj0uNqzeM61=W6xgfo5RQ4MpA9D9ibtiJUPhpqMsUOA5w@mail.gmail.com>
In-Reply-To: <CAFLszTj0uNqzeM61=W6xgfo5RQ4MpA9D9ibtiJUPhpqMsUOA5w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 3 Feb 2025 10:36:58 -0700
X-Gm-Features: AWEUYZkj_jxcAnUDa6u_kBnDMlDjlKj83WzYM41fUcwQkJfH4g9RTIO5Bl2fTi8
Message-ID: <CAFLszThs4g5ZVDveCuDC9Z6-yHipg4ZCGHDPT9Hd_k7ikywgpw@mail.gmail.com>
Subject: Re: [PATCH RFC 00/14] efi: implement EFISTUB support for ARM64 and
 Qualcomm
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
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

Hi again,

On Mon, 3 Feb 2025 at 05:54, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Caleb,
>
> On Sun, 24 Nov 2024 at 13:27, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >
> > This series implements support for launching U-Boot as an EFI payload on
> > ARM64 devices that already have an EFI capable bootloader.
> >
> > Patches 9 through 14 in tandem with another series [1] provide all the
> > pieces necessary to build and run U-Boot on Snapdragon X Elite laptops.
> > They're only here to demonstrate the usecase and either already have or
> > will be sent separately, they should not be reviewed as part of this
> > RFC.
> >
> > Initial support is provided for:
> > * Building U-Boot with an EFI stub on ARM64
> > * Inheriting DRAM banks from the EFI memory map
> > * Creating a framebuffer node in the OF tree based on EFI GOP info
> >
> > This allows for booting Linux on top of U-Boot's EFI implementation on
> > Qualcomm Snapdragon X Elite platforms.
> >
> > The primary motivation for this is to provide a more standard EFI
> > interface on devices like Qualcomm powered Windows laptops. While these
> > devices ship an EFI capable bootloader, it has no understanding of
> > devicetree, requiring distros (or more often, users) to handle
> > devicetree selection and applying necessary fixups.
> >
> > Additionally, the EFI implementation on these devices is often very far
> > from being systemready compliant, with a variety of bugs like broken
> > keyboards, crashes in OS loaders like systemd-boot, and other small
> > idiosyncrocies.
> >
> > As a result, simply running U-Boot as an EFI app isn't a suitable
> > solution.
> >
> > [1]: 20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org
> >
> > ---
> > Caleb Connolly (10):
> >       cmd: efi: avoid unitialized read
> >       efi: stub: support running U-Boot as an EFI payload on ARM64
> >       efi: move efi_info_get() to a new header file
> >       efi: stub: add helpers to populate memory map and framebuffer
> >       efi: stub: add additional types of memory
> >       efi: stub: log EFI memory banks
> >       efi: stub: add known memory to U-Boot's EFI memory map
> >       mach-snapdragon: support booting with EFISTUB
> >       common/board_f: init malloc earlier
> >       configs: add x1e_defconfig
> >
> > Neil Armstrong (4):
> >       clk: qcom: Add X1E80100 clock driver
> >       qcom_defconfig: enable X1E80100 clock driver
> >       pinctrl: qcom: Add X1E80100 pinctrl driver
> >       qcom_defconfig: enable X1E80100 pinctrl driver
> >
> >  Makefile                                |  15 +-
> >  arch/arm/cpu/armv8/config.mk            |  11 +
> >  arch/arm/include/asm/global_data.h      |   3 +
> >  arch/arm/lib/Makefile                   |   2 +
> >  arch/arm/mach-snapdragon/board.c        |  15 ++
> >  arch/arm/mach-snapdragon/dram.c         |  15 +-
> >  arch/arm/mach-snapdragon/qcom-priv.h    |   2 +
> >  arch/x86/cpu/efi/payload.c              |  32 +--
> >  board/qualcomm/efistub.env              |  11 +
> >  cmd/efi.c                               |   3 +-
> >  common/board_f.c                        |   2 +-
> >  configs/qcom_defconfig                  |   2 +
> >  configs/x1e_defconfig                   |  17 ++
> >  drivers/clk/qcom/Kconfig                |   8 +
> >  drivers/clk/qcom/Makefile               |   1 +
> >  drivers/clk/qcom/clock-x1e80100.c       | 348 ++++++++++++++++++++++++++++++++
> >  drivers/pinctrl/qcom/Kconfig            |   7 +
> >  drivers/pinctrl/qcom/Makefile           |   1 +
> >  drivers/pinctrl/qcom/pinctrl-x1e80100.c | 100 +++++++++
> >  drivers/video/efi.c                     |   1 +
> >  include/efi.h                           |  27 +--
> >  include/efi_stub.h                      |  67 ++++++
> >  lib/efi/Kconfig                         |   9 +-
> >  lib/efi/Makefile                        |  28 ++-
> >  lib/efi/efi_app.c                       |   1 +
> >  lib/efi/efi_info.c                      | 165 +++++++++++++++
> >  lib/efi/efi_stub_arm64.c                | 237 ++++++++++++++++++++++
> >  lib/efi/{efi_stub.c => efi_stub_x86.c}  |   1 +
> >  lib/efi_loader/efi_memory.c             |   5 +
> >  lib/of_live.c                           |   9 +
> >  30 files changed, 1072 insertions(+), 73 deletions(-)
> > ---
> > base-commit: 1e327ec30e48902fff65fb58337b8f80cc526f08
> >
>
> I am pulling this in as I need to get the app going on ARM and this is
> a better starting point.
>
> For the series, applied to sjg/master, thanks!

Er, just these patches:

de6dd73b4e5 efi: stub: add known memory to U-Boot's EFI memory map
8cb8d63b432 efi: stub: log EFI memory banks
cef0312def4 efi: stub: add additional types of memory
d9d2b8fb71f efi: stub: add helpers to populate memory map and framebuffer
- Updated to avoid changing the devicetree with the EFI app; fix build
error on x86

630cb84000f efi: move efi_info_get() to a new header file
e0a8bf6f453 efi: stub: support running U-Boot as an EFI payload on ARM64
88e332d7075 cmd: efi: avoid unitialized read

I will have a Qualcomm laptop so will be interested to see if this works on it.

Regards,
Simon
