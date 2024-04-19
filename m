Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA602C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 11:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F9AD8873D;
	Fri, 19 Apr 2024 13:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vge7DvGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA05B88741; Fri, 19 Apr 2024 13:30:47 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B6B8873E
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 13:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-343c7fae6e4so1693379f8f.1
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 04:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713526245; x=1714131045; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMA6pPXRpfCgMu14vLc2snTPCZ0ZeJX0/laGYAPeHqA=;
 b=Vge7DvGdDj7AQ6+TprM1yD0UoX4PH7pYw5hwsUMMeouBgu35cmx5EsFQNB1JC/j8bw
 Pofg6uN53ySlr7ppE7DwmEIrziQshLpaYTcneWCVRiRK3dFOPn1BvE+KADmhCqzg271X
 SkvkTOTvWwWCcs27WeaY3xj0hrTWFmvsvapLQZ4wUFcy3dnER1pTbF1vXHDYRtZor+t6
 2na8F7ndbQ2WUk9Ox2jCBE58B0VIOlRgNAWciQTOwexIzLqDn9okOxeaqueUThXrZWHl
 wYLqtCIRZT1PX9nvQRr39G82zax2mm8ouhzCsT7VttNTgefI6NodD/JZR0ZwpM6Si80v
 0Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713526245; x=1714131045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMA6pPXRpfCgMu14vLc2snTPCZ0ZeJX0/laGYAPeHqA=;
 b=M/75IetciMIedZOmf//OFepUes1QyYf29e33Sq8xcNQtvcgvi7YkRnmLIBqQo0KZJZ
 D/GnQ7TqOVVvCsr8TSs+LKkgszG7W1c6CFUcE3aFaCVDdT4bCODZx5pDWrdodqy4xfxp
 10y7uyVtTw20M+UJGeMWZDFHfRCSe6x8vu6IgK3pf/GUi6OdZ9z8n7aOrF1/ApWTEnTK
 yT8Ff4+HMogD/TgA/U/lSZPNycinRwU9bKcV82uAe2r1aJg7/5DGTEoBT4/ShAMLgCM3
 cCrDcvDgpo7fnFwTLYdjjjYltMmPskzbCJQuQF2uSRk6wrAcq3PcMQeNlczDjyFY3O77
 3DYA==
X-Gm-Message-State: AOJu0YwfJNpHJ2v50jdiYd038ZMu4QE6Tbgv6mHezHwVUpjVP8Bpy5mo
 BplB4SIqgFb8keY5T5dLVSAOXTYSXVGJvh83nJHMG56p1cHsQDHzlgVQqlQy4UtfS9oxtAr2HhY
 NB4noIJmEsxgJBgBYImcWJAU8LYU=
X-Google-Smtp-Source: AGHT+IGLMZq89KCd0y4AXXR4oKcv9rpsd8o0bC6fDfcdIebTHLOloaG4IEFzHjb9Fxmk/tePI6cbHEyW7G1tnw4pNUk=
X-Received: by 2002:adf:cd84:0:b0:33e:7f51:c2f8 with SMTP id
 q4-20020adfcd84000000b0033e7f51c2f8mr1124720wrj.36.1713526245280; Fri, 19 Apr
 2024 04:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240123171633.246057-1-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-1-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 19 Apr 2024 14:30:34 +0300
Message-ID: <CAPVz0n16O0Qn2Lm0qqWmYOLmEw1jBgtcHHb4W4poedraqurVgw@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] Add T114 video support
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>, 
 Anatolij Gustschin <agust@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hello Tom! This patch set is hanging in patchwork for 3 month
without any comments. If no one has anything to say, may you
pick it into master?

Best regards,
Svyatoslav R.

=D0=B2=D1=82, 23 =D1=81=D1=96=D1=87. 2024=E2=80=AF=D1=80. =D0=BE 19:17 Svya=
toslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> T114 is not that different from T30 and all T30 drivers will work
> on T114 as well with some adjustments.
>
> Patches propose general improvements for existing Tegra DC and DSI
> drivers as well Tegra 114 video support (experimentl).
>
> Commits pass buildman for tegra.
>
> ---
> Changes from v5:
>  - backlight enable moved to the last step of setup for DSI
>  - parameterized V- and H-sync polarities
>  - added framebuffer clearing on probe to avoid glitches
>  - backlight enable moved after DC is fully configured
>  - fixed printing framebuffer pointer instead of address
>  - moved scdiv calculation to tegra DSI if it is used
>
> Changes from v4:
>  - fixed typo in max rate to be divided (400KHz > 400MHz)
>
> Changes from v3:
>  - fixed the clock divider calculation if PLLD/D2 is used
>  - removed unnecessary pre-configuration
>  - set correct video FIFO depth for DSI
>
> Changes from v2:
>  - fixed image distortion on devices with 180deg rotation
>
> Changes from v1:
>  - reworked patchset entirely
>  - diverged DC configuration per-SOC
>  - consolidated dc headers from different SOC gen
>  - initial support of DC detection (tegra has 2 DC)
>  - added PLLD2 support, resets and powergating
>  - added T114+ MIPI calibration
>  - added DSI detection (tegra has 2 DSI) and resets
> ---
>
> Jonas Schw=C3=B6bel (6):
>   video: tegra20: dc: fix printing of framebuffer address
>   video: tegra20: dc: enable backlight after DC is configured
>   video: tegra20: dc: clean framebuffer memory block
>   video: tegra20: dsi: remove pre-configuration
>   video: tegra20: dsi: set correct fifo depth
>   video: tegra20: dsi: use set_backlight for backlight only
>
> Svyatoslav Ryhel (12):
>   video: tegra20: dc: diverge DC per-SOC
>   video: tegra20: dc: fix image shift on rotated panels
>   video: tegra20: consolidate DC header
>   video: tegra20: dc: pass DC id to internal devices
>   video: tegra20: dc: add PLLD2 parent support
>   video: tegra20: dc: add reset support
>   video: tegra20: dc: add powergate
>   video: tegra20: dc: configure behavior if PLLD/D2 is used
>   video: tegra20: dc: parameterize V- and H-sync polarities
>   video: tegra20: add MIPI calibration driver
>   video: tegra20: dsi: add T114 support
>   video: tegra20: dsi: add reset support
>
>  arch/arm/dts/tegra114-u-boot.dtsi             |  13 +
>  arch/arm/dts/tegra114.dtsi                    |   4 +-
>  arch/arm/dts/tegra30-u-boot.dtsi              |   4 +
>  arch/arm/dts/tegra30.dtsi                     |   2 +-
>  arch/arm/include/asm/arch-tegra/dc.h          |  13 +-
>  arch/arm/include/asm/arch-tegra114/pwm.h      |  13 +
>  arch/arm/include/asm/arch-tegra20/display.h   |  28 --
>  arch/arm/include/asm/arch-tegra30/display.h   |  28 --
>  drivers/video/tegra20/Makefile                |   2 +-
>  drivers/video/tegra20/tegra-dc.c              | 239 +++++++++++++-----
>  drivers/video/tegra20/tegra-dc.h              |  45 ++++
>  drivers/video/tegra20/tegra-dsi.c             | 122 ++++++++-
>  .../video/tegra20/tegra-dsi.h                 |  24 +-
>  drivers/video/tegra20/tegra-mipi.c            | 188 ++++++++++++++
>  drivers/video/tegra20/tegra-pwm-backlight.c   |   3 +-
>  15 files changed, 583 insertions(+), 145 deletions(-)
>  create mode 100644 arch/arm/include/asm/arch-tegra114/pwm.h
>  delete mode 100644 arch/arm/include/asm/arch-tegra20/display.h
>  delete mode 100644 arch/arm/include/asm/arch-tegra30/display.h
>  create mode 100644 drivers/video/tegra20/tegra-dc.h
>  rename arch/arm/include/asm/arch-tegra30/dsi.h =3D> drivers/video/tegra2=
0/tegra-dsi.h (90%)
>  create mode 100644 drivers/video/tegra20/tegra-mipi.c
>
> --
> 2.40.1
>
