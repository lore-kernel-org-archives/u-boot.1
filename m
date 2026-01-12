Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A507D26D97
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 10:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E0E483B5E;
	Mon, 12 Jan 2026 11:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="dT/Ze5c3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0607483D77; Mon, 12 Jan 2026 11:19:48 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E83878352B
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 11:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64b4b35c812so10110466a12.0
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 02:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1768213185; x=1768817985; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rx2X0LE5XgmWJbQ1QJnx0SU1wv6a7Igv/hvzvxi5usU=;
 b=dT/Ze5c3uvQJtobioqR0pcq2H9CUQaTh6WIOMlBKUIbVAMDQSXxI710WG8N79TjFy8
 Z5r9X7Li4QgfMx1jQsVsYVuKrXvU52Urx7Z36JR+PsDAtqzl9WVymeimtopLumfKu0xg
 3dyWfW6UZMaFhR6gCNAjId+cqT+SHUmaI/f7Ki6PftoQDPx9RfU6dNf81JcmCR2arNae
 P7yWElFcWHQb/36OgdnS/Sf6I+bKPHD1GaIoZ2qXEafs890VHSThhcANLRV9GEjh4K17
 0mNq5SlsGqws63kp/eRevGlJuP55N6lL/G75p0kaeE/+0fp2+MxqLDTo7+U3kHSKk1fN
 +xGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768213185; x=1768817985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rx2X0LE5XgmWJbQ1QJnx0SU1wv6a7Igv/hvzvxi5usU=;
 b=iMzL1swma8SjiLIA6s8xf3NK/9seaRgDjnanm5L43vUcRsVPxfKhWXDXam7H7k0W1h
 ohEshAPRmoXqh6KYrGRdwdbtof3eDyhsMUu3WKZClQzqd8QcdKEzgMzLJIl6TK42Imdl
 xxHncVwRZgbv+ApI5PJVftmw++CdxZxMutdQZhm+cp1d7xvfNSYUuP5KohYLPlKJPa9H
 6Xvk5QuYvOShvTQrSImEk+GrznZvLb+fFPsrjQ0FFbSOi7+6vwTcge5sV5qe4f7pZ/wJ
 CYkZzihR/F3n+fyAe3bPs6+NgRNDJFK0gFRz/gc2yg/4sIKsOd0Nvt1RQrLRpc+RxA27
 ymhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwl2lEaYz4nCiqDImyk5loW9hp2YZbGe1rE5Sb0UE0uwtCHDJk8efXifneiJ/FNLHqi+HJtWk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5ykxEqkWfUJyMUEJ6jeaAGqe87kF23vEYXhH3/XZPCtcbuM6k
 c5lGhq0D+zDUcTl/8FQxHwU78VDzW/bABXRqoluz6e8v/3onJM0c2n2O1wehjRZIHvAIO56tEYk
 RrGXKWNndflWITeEC+KeMnFeoKixx7UERx5/gzBo2U13Xt1wBKwSKc4JgaQ==
X-Gm-Gg: AY/fxX6EM6sFSOq4B+bXpK7b1ZpSbDVs56/QY0b5FXZS5GpqJDpdQ+wmaODgXrwEbff
 9WlksvW7tdDltqwWxh4dDsfcmph8nbLibUBd0KUYRy5if+BSU7tEIlu3PTeS8Dad8zxBxf9y8Pd
 lMVIw7Xvtt0nbvzlYqNNlcuYzS3pe9NYLnMWvhklEQtEuIlvkOEFZ17iGXsGFaX4N84ACNhrzFl
 aVGE+11G/3XJKpiUz3wK0on6hj1letYYUn84aqiJvUMZIo7TgEW/2w9u+hqo7qP3hpNGUEUnpAZ
 cLdHKCu5c86zh/04llFrAGU7BEZSK4MV7bNU22aCwyHCKMreBA==
X-Google-Smtp-Source: AGHT+IHIbCk/ijdAIoJRg5vMDgMZUcXb4rOFkdPhpi20jcoA/vWDWysJxxtmQ6eaoT4+P5D2wbHZ/rDqJViQ6BozSSU=
X-Received: by 2002:a05:6402:2114:b0:64c:e9b6:14d7 with SMTP id
 4fb4d7f45d1cf-65097e5ee3dmr14937509a12.24.1768213185240; Mon, 12 Jan 2026
 02:19:45 -0800 (PST)
MIME-Version: 1.0
References: <20251230210201.496403-1-robert.marko@sartura.hr>
 <b95c93d6-7a50-4fb3-b94e-ffd72b825cfc@linaro.org>
 <CA+HBbNEStuFC0zh4TAqREWrLEqRFEwSc0YP_bwf=T-95n1Roag@mail.gmail.com>
 <1a443069-2c90-43a6-9c9d-c00ae214386d@linaro.org>
In-Reply-To: <1a443069-2c90-43a6-9c9d-c00ae214386d@linaro.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 12 Jan 2026 11:19:34 +0100
X-Gm-Features: AZwV_Qiotgy1uvStQuyv_qdpYh9n0_8UHvc0DZNJjP-4dtnm9pMACZ5IHNpWP7Y
Message-ID: <CA+HBbNGouwDaqunppwBPC6zGu58r4dHw0mamb18eut=0jdLAzw@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm: at91: move atmel_serial.h to
 include/dm/platform_data
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: luka.perkov@sartura.hr, trini@konsulko.com, sjg@chromium.org, 
 hs@nabladev.com, u-boot@lists.denx.de
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

On Mon, Jan 12, 2026 at 11:13=E2=80=AFAM Eugen Hristev <eugen.hristev@linar=
o.org> wrote:
>
>
>
> On 1/12/26 11:52, Robert Marko wrote:
> > On Mon, Jan 12, 2026 at 9:46=E2=80=AFAM Eugen Hristev <eugen.hristev@li=
naro.org> wrote:
> >>
> >>
> >>
> >> On 12/30/25 23:01, Robert Marko wrote:
> >>> Move the arch specific atmel_serial.h header from AT91 to the generic
> >>> include/dm/platform_data.
> >>>
> >>> This will be used for support on Microchip LAN969x.
> >>>
> >>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> >>> ---
> >>>  board/bluewater/gurnard/gurnard.c                               | 2 =
+-
> >>>  board/siemens/corvus/board.c                                    | 2 =
+-
> >>>  board/siemens/smartweb/smartweb.c                               | 2 =
+-
> >>>  board/siemens/taurus/taurus.c                                   | 2 =
+-
> >>>  drivers/serial/atmel_usart.c                                    | 2 =
+-
> >>>  .../include/mach =3D> include/dm/platform_data}/atmel_serial.h    | =
0
> >>>  6 files changed, 5 insertions(+), 5 deletions(-)
> >>>  rename {arch/arm/mach-at91/include/mach =3D> include/dm/platform_dat=
a}/atmel_serial.h (100%)
> >>>
> >>> diff --git a/board/bluewater/gurnard/gurnard.c b/board/bluewater/gurn=
ard/gurnard.c
> >>> index 3275803226a..71db6409721 100644
> >>> --- a/board/bluewater/gurnard/gurnard.c
> >>> +++ b/board/bluewater/gurnard/gurnard.c
> >>> @@ -29,7 +29,7 @@
> >>>  #include <asm/arch/at91_rstc.h>
> >>>  #include <asm/arch/at91_rtc.h>
> >>>  #include <asm/arch/at91_sck.h>
> >>> -#include <asm/arch/atmel_serial.h>
> >>> +#include <dm/platform_data/atmel_serial.h>
> >>>  #include <asm/arch/clk.h>
> >>>  #include <asm/arch/gpio.h>
> >>>  #include <dm/uclass-internal.h>
> >>> diff --git a/board/siemens/corvus/board.c b/board/siemens/corvus/boar=
d.c
> >>> index a8714e055d7..7a70a7dfc8b 100644
> >>> --- a/board/siemens/corvus/board.c
> >>> +++ b/board/siemens/corvus/board.c
> >>> @@ -20,7 +20,7 @@
> >>>  #include <asm/arch/at91sam9_smc.h>
> >>>  #include <asm/arch/at91_common.h>
> >>>  #include <asm/arch/at91_rstc.h>
> >>> -#include <asm/arch/atmel_serial.h>
> >>> +#include <dm/platform_data/atmel_serial.h>
> >>>  #include <asm/arch/gpio.h>
> >>>  #include <asm/gpio.h>
> >>>  #include <asm/arch/clk.h>
> >>> diff --git a/board/siemens/smartweb/smartweb.c b/board/siemens/smartw=
eb/smartweb.c
> >>> index 6fa3ca573ae..ce16aad3b98 100644
> >>> --- a/board/siemens/smartweb/smartweb.c
> >>> +++ b/board/siemens/smartweb/smartweb.c
> >>> @@ -25,7 +25,7 @@
> >>>  #include <asm/arch/at91sam9260_matrix.h>
> >>>  #include <asm/arch/at91sam9_smc.h>
> >>>  #include <asm/arch/at91_common.h>
> >>> -#include <asm/arch/atmel_serial.h>
> >>> +#include <dm/platform_data/atmel_serial.h>
> >>>  #include <asm/arch/at91_spi.h>
> >>>  #include <spi.h>
> >>>  #include <asm/arch/clk.h>
> >>> diff --git a/board/siemens/taurus/taurus.c b/board/siemens/taurus/tau=
rus.c
> >>> index 252b0787124..690c00046fa 100644
> >>> --- a/board/siemens/taurus/taurus.c
> >>> +++ b/board/siemens/taurus/taurus.c
> >>> @@ -24,7 +24,7 @@
> >>>  #include <asm/arch/at91_rstc.h>
> >>>  #include <asm/arch/gpio.h>
> >>>  #include <asm/arch/at91sam9_sdramc.h>
> >>> -#include <asm/arch/atmel_serial.h>
> >>> +#include <dm/platform_data/atmel_serial.h>
> >>>  #include <asm/arch/clk.h>
> >>>  #include <asm/gpio.h>
> >>>  #include <linux/mtd/rawnand.h>
> >>> diff --git a/drivers/serial/atmel_usart.c b/drivers/serial/atmel_usar=
t.c
> >>> index 0b35582aaa4..d6c3d4cbcc8 100644
> >>> --- a/drivers/serial/atmel_usart.c
> >>> +++ b/drivers/serial/atmel_usart.c
> >>> @@ -18,7 +18,7 @@
> >>>
> >>>  #include <asm/io.h>
> >>>  #if CONFIG_IS_ENABLED(DM_SERIAL)
> >>> -#include <asm/arch/atmel_serial.h>
> >>> +#include <dm/platform_data/atmel_serial.h>
> >>>  #endif
> >>>  #include <asm/arch/clk.h>
> >>>  #include <asm/arch/hardware.h>
> >>> diff --git a/arch/arm/mach-at91/include/mach/atmel_serial.h b/include=
/dm/platform_data/atmel_serial.h
> >>> similarity index 100%
> >>> rename from arch/arm/mach-at91/include/mach/atmel_serial.h
> >>> rename to include/dm/platform_data/atmel_serial.h
> >>
> >> Hello Robert,
> >>
> >> These patches break the build for some boards. e.g. corvus_defconfig
> >>
> >>
> >> drivers/serial/atmel_usart.c: In function =E2=80=98atmel_serial_setbrg=
_internal=E2=80=99:
> >> drivers/serial/atmel_usart.c:44:20: error: implicit declaration of
> >> function =E2=80=98get_usart_clk_rate=E2=80=99 [-Werror=3Dimplicit-func=
tion-declaration]
> >>    44 |         usart_hz =3D get_usart_clk_rate(id);
> >>       |                    ^~~~~~~~~~~~~~~~~~
> >>   AR      spl/disk/built-in.a
> >>   CC      spl/fs/fs_internal.o
> >> cc1: some warnings being treated as errors
> >
> > So, somehow during the SPL build, the following is not evaluated as tru=
e:
> > #if CONFIG_IS_ENABLED(ARCH_AT91)
> >
> > Which is rather weird as u-boot.cfg in the spl dir has:
> > #define CONFIG_ARCH_AT91 1
> >
> > So, this is some CONFIG_IS_ENABLED interaction with SPL that I am not
> > really familiar with as
> > #if IS_ENABLED(CONFIG_ARCH_AT91) works just fine and gets the header in=
cluded.
>
> IIRC when the spl is being built, a dedicated config is being created
> from the proper defconfig by selecting CONFIG_SPL_***

Ok, now that makes sense, CONFIG_IS_ENABLED basically will check for
SPL_ARCH_AT91 which does not exist.

>
> You will have to check why the ARCH_AT91 is not selected for spl, which
> is strange indeed

Well, after looking at the expanded config there is a bunch of generic
and ARCH-specific symbols that do not have
the SPL_ variant generated.

So, in this case use of IS_ENABLED seems more appropriate.

>
> >
> > Regards,
> > Robert
> >
> >>
> >>
> >> Please have a look,
> >> thanks,
> >> Eugen
> >>
> >
> >
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
