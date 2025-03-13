Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3A2C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 12:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 359FE80756;
	Thu, 13 Mar 2025 13:21:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K+0me2/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08BA480F9C; Thu, 13 Mar 2025 13:21:47 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7C428007D
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 13:21:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e5e8274a74so1412954a12.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 05:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741868503; x=1742473303; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rEuWlPh9eW680SP2EO0pWJzR1wVF+TeCHkAb+CZf3tc=;
 b=K+0me2/+YhLjf9tf6/aeL8+g5Cp+h99QHvVbZaw47Hc1wbR4ydJ/X6NSJUyKI+aB6G
 zeVJe9pVvWVlt7h3XfSI2DuSUDJxuZN2g1ej/tSDB3cX55fyJVEzvsnrtmLL7+mxZN6F
 A1RJyuGvEDJszum6fDsi+mhxLmJMmBTlstjCY9yzb2PdKLqz8HAiUF3jqIi2CFrahF4N
 xMOEGbfUQaGhHtg+N8ZDd58INCClptpc3At0Q88FtMXjj1+GpIfnNwPQMlslZFQZPPc6
 /fE3G5wUdjbNeKuEGsZxsY+gqaW2blf43h0EM2XnXv+ZD8zdHvRx8mDSIWYWJRo7tw62
 gPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741868503; x=1742473303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rEuWlPh9eW680SP2EO0pWJzR1wVF+TeCHkAb+CZf3tc=;
 b=t0y2oSVAoufAe5m2+ziZEZEXbsK8c5B7QD3WBBv0XGR38/VduJWPO+ryKjTe7tW4zD
 zbritHXoF8Kz0e8ns9zkKtVprvtzsKv2gthf6tWHrT77JUvHOnaCjxG9nwQ6BOL/faMD
 4iiEG4tjihHlJxW0RNg87FDx4HiNDNqamCQkAJML0wFDljQTDYFjL7665vD/Z8higwDZ
 8pgSLSNM/oxdnr8sbxLlC98IiBZaqvVuASFanxvGUOT5uFFSIyfJQsxaUxavJlaGgJBy
 uO1S4h9DX8mQi4i+E8eWDSpeBr0UQOsdfXvxu/ZtunJFw2oZBDJ0oCeqiMsP/4OeBsSI
 83Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeFHEswgGcDzsFDjoeUye4k9Vx6c745FX9nOtnGz3r1jWtGj7zF0vSuvpECiFcGWRn71VSrAA=@lists.denx.de
X-Gm-Message-State: AOJu0YwYLq6musCRZy5yMCvvLLjeBrTkDyeOxQI5QJIUMZu46zfoSJ8f
 r9UB1XorJtHhXTsTG1IVzT9avOc0wrh1scmU8tIl718MwfeHACElDQrXn+WTOQ63sAR6bWuKiJG
 uKE0fa7OqbjD6Ba5+FeMG/GfiA8o7HA==
X-Gm-Gg: ASbGnctgFl0TmpQfYzlGPIiYppHbv8WCIKNdlEI8mjL6GsbylndVWG5qw/WyOO4is5M
 G9ywEPMX1sDgCh9ikhX2QesRrXUMpmrJhq73chuAUQlTPkJgOr2dkXQyyS7DueA7K0CMHOfvF5D
 wHrvyBRA6Qfa7k7XrSvVMm0nYx/XKlFHdRDeLUsYy9ID5WaYE09u5LLlS79WE=
X-Google-Smtp-Source: AGHT+IGKXSavEjVI/hchJvV63wWdp2R+o2hF00DHNwUlOzqTJqXSfIUjQBjN4dYMsNZpZer8kBjU/PTi7SXs/CbelhY=
X-Received: by 2002:a05:6402:2546:b0:5e4:d2c9:456c with SMTP id
 4fb4d7f45d1cf-5e5e24688c6mr48629678a12.22.1741868503071; Thu, 13 Mar 2025
 05:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250312175857.120313-1-clamor95@gmail.com>
 <CALeDE9PBFv1ebVBrmAzUgEtD+jnfjxDMk7grQYG1tKmD=hQMjg@mail.gmail.com>
 <CAPVz0n0o6UMr-AGHdH5YPxcOaRGwoe=4R3fcaZLej4n=rjPYZw@mail.gmail.com>
In-Reply-To: <CAPVz0n0o6UMr-AGHdH5YPxcOaRGwoe=4R3fcaZLej4n=rjPYZw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 13 Mar 2025 12:21:32 +0000
X-Gm-Features: AQ5f1JovyaQLSD5mHDPrOCDnjKWHSwnwNeVVGiikmWvstHnF6TwlU8PBqlGtQrY
Message-ID: <CALeDE9NsjDrRbs2c7zBvkkDvaHKpUnU-CaYCWkSRVD0PMabOLw@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] video: tegra: migrations, HDMI and HOST1x
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, 13 Mar 2025 at 11:58, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D1=87=D1=82, 13 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:55 Pe=
ter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hey Svyatoslav,
> >
> > What generations of the hardware do you expect this to work on?
> >
>
> Changes were tested on T20, T30, T114 and T124. They all successfully
> work with proposed changes.
>

Do you think it would work on T210?


> > Peter
> >
> > On Wed, 12 Mar 2025 at 17:59, Svyatoslav Ryhel <clamor95@gmail.com>
> wrote:
> >>
> >> Migrate DC and DSI to support video bridge UCLASS and OF graph binding=
s.
> >> Add HDMI and basic HOST1X bus drivers. Move DC driven PWM backlight
> >> into DC node.
> >>
> >> Svyatoslav Ryhel (10):
> >>   video: tegra20: implement a minimal HOST1X driver for essential cloc=
k
> >>     and reset setup
> >>   video: tegra20: provide driver support for the HDMI controller
> >>   video: tegra20: dc: add video bridge support
> >>   video: tegra20: dc: convert to use of_graph
> >>   video: tegra20: dc: get DSI/HDMI clock parent if internal DSI/HDMI i=
s
> >>     used
> >>   video: tegra20: dc: remove unused video operations
> >>   video: tegra20: dc: support binding child devices
> >>   video: tegra20: pwm-backlight: convert into DC child
> >>   video: tegra20: dsi: convert to video bridge UCLASS
> >>   video: tegra20: dsi: respect speed mode used for DSI commands transf=
er
> >>
> >>  arch/arm/include/asm/arch-tegra/dc.h        |  46 +-
> >>  drivers/video/tegra20/Kconfig               |  16 +-
> >>  drivers/video/tegra20/Makefile              |   2 +
> >>  drivers/video/tegra20/tegra-dc.c            | 233 +++++--
> >>  drivers/video/tegra20/tegra-dc.h            |   3 -
> >>  drivers/video/tegra20/tegra-dsi.c           |  12 +-
> >>  drivers/video/tegra20/tegra-hdmi.c          | 623 +++++++++++++++++++
> >>  drivers/video/tegra20/tegra-hdmi.h          | 652 +++++++++++++++++++=
+
> >>  drivers/video/tegra20/tegra-host1x.c        |  86 +++
> >>  drivers/video/tegra20/tegra-pwm-backlight.c |  12 +-
> >>  10 files changed, 1603 insertions(+), 82 deletions(-)
> >>  create mode 100644 drivers/video/tegra20/tegra-hdmi.c
> >>  create mode 100644 drivers/video/tegra20/tegra-hdmi.h
> >>  create mode 100644 drivers/video/tegra20/tegra-host1x.c
> >>
> >> --
> >> 2.43.0
> >>
>
