Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E28C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 12:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD11180077;
	Mon,  3 Feb 2025 13:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bk0Hszih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBC4880079; Mon,  3 Feb 2025 13:54:55 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F24EB8004F
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 13:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d3f57582a2so10691484a12.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 04:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738587292; x=1739192092; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8nepmfWKKRCMdKTns24ThWOKXsHzBmxS4eN9UmLyngw=;
 b=bk0HszihGvMiNUTcPIxjh86Gn3mgvDkdR2j/neVTSnJTPs+xRCB9XvD3jscjyZHcTS
 crV6pde7zCc4vaH1cii1/M6xP1JUOtV/BbH2YXkjvTt6vNgF820kMSH/Q3MN4UGMVsEN
 RzT6UVHtW5EEDwJSvQxnTZDaDtLytvq0OkHD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738587292; x=1739192092;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8nepmfWKKRCMdKTns24ThWOKXsHzBmxS4eN9UmLyngw=;
 b=vqeKu2LqJPviQKk7B01f4tD3HfwKPRaLhRJQWdamNpcFQqPMCnZRbg1URZ3G08yHDl
 jz1U96tRLyr8Js31LWFMFSL8MZRFF0mo/Fu+0rkcDSz7R2vgDoW22smx0kG7uIPDZjqz
 AD6wmhiX2nmOeJ2siaPNFp+icmAzBmoT9T+nyitW8a0PwYwCCNdLUinVVnmDWEQxYylL
 uqzFuiXArnLY3gfAg1f0aO2gYyoPXsDZZ5wtpIA1gZ4hgOdN6dlNwxJ2yV0Zw9c2qSht
 BhrEkrDzinaKz6xwO2WYTY6Z5Vtklt7fmqOAOwY2T7J5QxBVmoYjbNpmscLiffEEmGuJ
 O9Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOtdKXTER1GkUKBJ1RnlhO0Fbl27RVPfgh3AKwxbe53MY2Ll3TGSy04CiG4JoPp2+rLOvmloM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0Vaby0EBS2EN6TQ/wusehTIFHSx2BChKw1oPgfhJ33RBcZ4A6
 uNniGa7Npr5Mbefv0aXmN6XUD8ljwPyZqi08p35P/5OGM1f75pkZdNUgvfif6e5I8gZ0e8kQrES
 Ure8YYW/bT0MJGqLIWEASgyXB9b2L3oEO1lPm
X-Gm-Gg: ASbGncsN4dR9wA6+eWRwBjpRTyIugSNzopD13qJQmn1erKcl++wUGhBEqCb1o2WOLRC
 oHkaNciJqhTCRN0Exqc/t2eSgRDbj//z+qHqE9Y+5hAmfRarCJ+PBrkvTO3F2iz7pHxBT/AgpcA
 ==
X-Google-Smtp-Source: AGHT+IGPM0TcN/1PzUyPthzMWKOmcxzDzUXvPGlUQs9ijIYH0tWXvJ/AkXo9ZgA9I5kYDsqUqU+gcCiK3D/6vrNMPrM=
X-Received: by 2002:a17:907:86ab:b0:ab3:a4f6:7551 with SMTP id
 a640c23a62f3a-ab6f747b5famr1885071366b.13.1738587292319; Mon, 03 Feb 2025
 04:54:52 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
In-Reply-To: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 3 Feb 2025 05:54:40 -0700
X-Gm-Features: AWEUYZmAmcBJna9KJMzqSszstiMCql8vJTytCXIt89-eNauDmLzHNo5rEb71uxE
Message-ID: <CAFLszTj0uNqzeM61=W6xgfo5RQ4MpA9D9ibtiJUPhpqMsUOA5w@mail.gmail.com>
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

Hi Caleb,

On Sun, 24 Nov 2024 at 13:27, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> This series implements support for launching U-Boot as an EFI payload on
> ARM64 devices that already have an EFI capable bootloader.
>
> Patches 9 through 14 in tandem with another series [1] provide all the
> pieces necessary to build and run U-Boot on Snapdragon X Elite laptops.
> They're only here to demonstrate the usecase and either already have or
> will be sent separately, they should not be reviewed as part of this
> RFC.
>
> Initial support is provided for:
> * Building U-Boot with an EFI stub on ARM64
> * Inheriting DRAM banks from the EFI memory map
> * Creating a framebuffer node in the OF tree based on EFI GOP info
>
> This allows for booting Linux on top of U-Boot's EFI implementation on
> Qualcomm Snapdragon X Elite platforms.
>
> The primary motivation for this is to provide a more standard EFI
> interface on devices like Qualcomm powered Windows laptops. While these
> devices ship an EFI capable bootloader, it has no understanding of
> devicetree, requiring distros (or more often, users) to handle
> devicetree selection and applying necessary fixups.
>
> Additionally, the EFI implementation on these devices is often very far
> from being systemready compliant, with a variety of bugs like broken
> keyboards, crashes in OS loaders like systemd-boot, and other small
> idiosyncrocies.
>
> As a result, simply running U-Boot as an EFI app isn't a suitable
> solution.
>
> [1]: 20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org
>
> ---
> Caleb Connolly (10):
>       cmd: efi: avoid unitialized read
>       efi: stub: support running U-Boot as an EFI payload on ARM64
>       efi: move efi_info_get() to a new header file
>       efi: stub: add helpers to populate memory map and framebuffer
>       efi: stub: add additional types of memory
>       efi: stub: log EFI memory banks
>       efi: stub: add known memory to U-Boot's EFI memory map
>       mach-snapdragon: support booting with EFISTUB
>       common/board_f: init malloc earlier
>       configs: add x1e_defconfig
>
> Neil Armstrong (4):
>       clk: qcom: Add X1E80100 clock driver
>       qcom_defconfig: enable X1E80100 clock driver
>       pinctrl: qcom: Add X1E80100 pinctrl driver
>       qcom_defconfig: enable X1E80100 pinctrl driver
>
>  Makefile                                |  15 +-
>  arch/arm/cpu/armv8/config.mk            |  11 +
>  arch/arm/include/asm/global_data.h      |   3 +
>  arch/arm/lib/Makefile                   |   2 +
>  arch/arm/mach-snapdragon/board.c        |  15 ++
>  arch/arm/mach-snapdragon/dram.c         |  15 +-
>  arch/arm/mach-snapdragon/qcom-priv.h    |   2 +
>  arch/x86/cpu/efi/payload.c              |  32 +--
>  board/qualcomm/efistub.env              |  11 +
>  cmd/efi.c                               |   3 +-
>  common/board_f.c                        |   2 +-
>  configs/qcom_defconfig                  |   2 +
>  configs/x1e_defconfig                   |  17 ++
>  drivers/clk/qcom/Kconfig                |   8 +
>  drivers/clk/qcom/Makefile               |   1 +
>  drivers/clk/qcom/clock-x1e80100.c       | 348 ++++++++++++++++++++++++++++++++
>  drivers/pinctrl/qcom/Kconfig            |   7 +
>  drivers/pinctrl/qcom/Makefile           |   1 +
>  drivers/pinctrl/qcom/pinctrl-x1e80100.c | 100 +++++++++
>  drivers/video/efi.c                     |   1 +
>  include/efi.h                           |  27 +--
>  include/efi_stub.h                      |  67 ++++++
>  lib/efi/Kconfig                         |   9 +-
>  lib/efi/Makefile                        |  28 ++-
>  lib/efi/efi_app.c                       |   1 +
>  lib/efi/efi_info.c                      | 165 +++++++++++++++
>  lib/efi/efi_stub_arm64.c                | 237 ++++++++++++++++++++++
>  lib/efi/{efi_stub.c => efi_stub_x86.c}  |   1 +
>  lib/efi_loader/efi_memory.c             |   5 +
>  lib/of_live.c                           |   9 +
>  30 files changed, 1072 insertions(+), 73 deletions(-)
> ---
> base-commit: 1e327ec30e48902fff65fb58337b8f80cc526f08
>

I am pulling this in as I need to get the app going on ARM and this is
a better starting point.

For the series, applied to sjg/master, thanks!

Regards,
SImon
