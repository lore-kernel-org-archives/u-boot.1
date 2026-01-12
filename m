Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DD2D26D9B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 09:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B5F883CBD;
	Mon, 12 Jan 2026 10:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="KrT/mupu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E2B983D2E; Mon, 12 Jan 2026 10:53:05 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 699E383CB9
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b8710c9cddbso142630266b.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 01:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1768211582; x=1768816382; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m82GLlXDlGmZyG5T3yHE4e1Z3f/RkEXv1Auksb+/Aak=;
 b=KrT/mupuSIQ0EoS0sq1u/4yWzSN4LyJyX1Mm/plP10qFEWJEG6S0KZc8NGU357p0Bz
 w2AAdgQN6P0zbv3emk4tMq4KCPKi+KFBUAZVMLgYq/HzGYbBgAQdNQU97zj/3OMu51hd
 xHqnbwstDMeuzTHZNS9soCcXR9e6Z1ZDrXg5ITu4QlrZSl8t8WThd9FOYfsYhzA+7/ox
 SJc72tak7rfYgXc7Rq/jwEqjttLKAQep1iBq9qPoYr8k8Q/Jbd8HOb63LzLVC10B3Q3d
 8CwAcawZLuxMUTjlIMOmYbAbWW3tOEUVLdeMPRUpfjUJS83Czua9jD1X5zXCXhG6HjVI
 TANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768211582; x=1768816382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m82GLlXDlGmZyG5T3yHE4e1Z3f/RkEXv1Auksb+/Aak=;
 b=Lh5CVVKWyIZhn9w3Q3Kfg3y4tZlywjsZ4MDmEYdOcPGoyHMvVqAIaFR7Z2l0xY1NM2
 VEwWAUX+dDNA+drUJGXpARbYteYyypPMsBC778vIA4rLea6YT5Y0by9/41gTp5kjMIH6
 41rv0vvcaV8YSRx1ZrC22u8nzARXaVFo0o9pa2KP0EDqztRGulNUkrrizie31ungMitG
 M1Wrwafps1KTv7x9mRKUSN6vxRJo97WHC0bTVtJnBSrnutQMe6MwdbeqlrpRuBvyI6tt
 REvMyBMIx/j5RQ+n2Bp4JXKSznrhZBV1Na76LQMbvbkeiHbP1DCjct7+QZQoVPLBUgQi
 TijQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc3g6pusNYyE1g2WV+sx7XFJtF1gJdjIuao9cPnX2MDZxUawExYHQUwdbh0cCBYZIDDUBiRmM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5tf5mbgiGCZ2meUifd+CzYmuTKgjif2tQkfwLkKESxVHldh8O
 MXv+Sb3kxQNVYcFV63xlpdREqbc5O+cYC9Z70G9X2vIcQ0xPZbYeevoa0P8oV6I7LAUuIN8ihgY
 9A1bO14kOMm50c6VNhNSz3F0z2aA98biRGrisNWyJEg==
X-Gm-Gg: AY/fxX7DXRiI6dePQVnDtwesP0oxTNsYHQhBtTUkDdwKcQ5z6UEh7nFSCX8M/DbPbSr
 ZphcY0Uf8mWe+NT7KVY3E7xa7vHYJ1lX+VjmibTKShy4jytglFbeVy5ZG1X2p5Nlk3KWDgQMz63
 SMH+P/nVMKu+7uwF/IFw4k6TKGudHR0FUEeprEoc0/fpVh7Fse6k22ErbCZzUUnQkiRSdHD7Pn8
 P/Y7KPPTea8qUYS1zB+lOwfE7H3cHEI0DojtnnUu3lFFfXPdngEfR29CjOV0jV5T/hdgq0YPX+z
 t5zrnb7+YrJwG2f/skVPDDNw03P2gzsqDVkFfcCzw61ERtoh9w==
X-Google-Smtp-Source: AGHT+IGgHHr+h2BD3AISLlX9XsteG2klSjYkOAmrHOuDGzG/A1VF0QvgTrppk7EQai1fqak8ZYgCm14rLSY+RWpQf+k=
X-Received: by 2002:a17:906:9f87:b0:b73:2b08:ac70 with SMTP id
 a640c23a62f3a-b844539fc4fmr1765062266b.49.1768211581657; Mon, 12 Jan 2026
 01:53:01 -0800 (PST)
MIME-Version: 1.0
References: <20251230210201.496403-1-robert.marko@sartura.hr>
 <b95c93d6-7a50-4fb3-b94e-ffd72b825cfc@linaro.org>
In-Reply-To: <b95c93d6-7a50-4fb3-b94e-ffd72b825cfc@linaro.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 12 Jan 2026 10:52:49 +0100
X-Gm-Features: AZwV_QgfmitZJJdI91rvk9TTn1XCV_Z8tks0yU3bQ6Yh-mjcaVWHdgca_cvf6X4
Message-ID: <CA+HBbNEStuFC0zh4TAqREWrLEqRFEwSc0YP_bwf=T-95n1Roag@mail.gmail.com>
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

On Mon, Jan 12, 2026 at 9:46=E2=80=AFAM Eugen Hristev <eugen.hristev@linaro=
.org> wrote:
>
>
>
> On 12/30/25 23:01, Robert Marko wrote:
> > Move the arch specific atmel_serial.h header from AT91 to the generic
> > include/dm/platform_data.
> >
> > This will be used for support on Microchip LAN969x.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  board/bluewater/gurnard/gurnard.c                               | 2 +-
> >  board/siemens/corvus/board.c                                    | 2 +-
> >  board/siemens/smartweb/smartweb.c                               | 2 +-
> >  board/siemens/taurus/taurus.c                                   | 2 +-
> >  drivers/serial/atmel_usart.c                                    | 2 +-
> >  .../include/mach =3D> include/dm/platform_data}/atmel_serial.h    | 0
> >  6 files changed, 5 insertions(+), 5 deletions(-)
> >  rename {arch/arm/mach-at91/include/mach =3D> include/dm/platform_data}=
/atmel_serial.h (100%)
> >
> > diff --git a/board/bluewater/gurnard/gurnard.c b/board/bluewater/gurnar=
d/gurnard.c
> > index 3275803226a..71db6409721 100644
> > --- a/board/bluewater/gurnard/gurnard.c
> > +++ b/board/bluewater/gurnard/gurnard.c
> > @@ -29,7 +29,7 @@
> >  #include <asm/arch/at91_rstc.h>
> >  #include <asm/arch/at91_rtc.h>
> >  #include <asm/arch/at91_sck.h>
> > -#include <asm/arch/atmel_serial.h>
> > +#include <dm/platform_data/atmel_serial.h>
> >  #include <asm/arch/clk.h>
> >  #include <asm/arch/gpio.h>
> >  #include <dm/uclass-internal.h>
> > diff --git a/board/siemens/corvus/board.c b/board/siemens/corvus/board.=
c
> > index a8714e055d7..7a70a7dfc8b 100644
> > --- a/board/siemens/corvus/board.c
> > +++ b/board/siemens/corvus/board.c
> > @@ -20,7 +20,7 @@
> >  #include <asm/arch/at91sam9_smc.h>
> >  #include <asm/arch/at91_common.h>
> >  #include <asm/arch/at91_rstc.h>
> > -#include <asm/arch/atmel_serial.h>
> > +#include <dm/platform_data/atmel_serial.h>
> >  #include <asm/arch/gpio.h>
> >  #include <asm/gpio.h>
> >  #include <asm/arch/clk.h>
> > diff --git a/board/siemens/smartweb/smartweb.c b/board/siemens/smartweb=
/smartweb.c
> > index 6fa3ca573ae..ce16aad3b98 100644
> > --- a/board/siemens/smartweb/smartweb.c
> > +++ b/board/siemens/smartweb/smartweb.c
> > @@ -25,7 +25,7 @@
> >  #include <asm/arch/at91sam9260_matrix.h>
> >  #include <asm/arch/at91sam9_smc.h>
> >  #include <asm/arch/at91_common.h>
> > -#include <asm/arch/atmel_serial.h>
> > +#include <dm/platform_data/atmel_serial.h>
> >  #include <asm/arch/at91_spi.h>
> >  #include <spi.h>
> >  #include <asm/arch/clk.h>
> > diff --git a/board/siemens/taurus/taurus.c b/board/siemens/taurus/tauru=
s.c
> > index 252b0787124..690c00046fa 100644
> > --- a/board/siemens/taurus/taurus.c
> > +++ b/board/siemens/taurus/taurus.c
> > @@ -24,7 +24,7 @@
> >  #include <asm/arch/at91_rstc.h>
> >  #include <asm/arch/gpio.h>
> >  #include <asm/arch/at91sam9_sdramc.h>
> > -#include <asm/arch/atmel_serial.h>
> > +#include <dm/platform_data/atmel_serial.h>
> >  #include <asm/arch/clk.h>
> >  #include <asm/gpio.h>
> >  #include <linux/mtd/rawnand.h>
> > diff --git a/drivers/serial/atmel_usart.c b/drivers/serial/atmel_usart.=
c
> > index 0b35582aaa4..d6c3d4cbcc8 100644
> > --- a/drivers/serial/atmel_usart.c
> > +++ b/drivers/serial/atmel_usart.c
> > @@ -18,7 +18,7 @@
> >
> >  #include <asm/io.h>
> >  #if CONFIG_IS_ENABLED(DM_SERIAL)
> > -#include <asm/arch/atmel_serial.h>
> > +#include <dm/platform_data/atmel_serial.h>
> >  #endif
> >  #include <asm/arch/clk.h>
> >  #include <asm/arch/hardware.h>
> > diff --git a/arch/arm/mach-at91/include/mach/atmel_serial.h b/include/d=
m/platform_data/atmel_serial.h
> > similarity index 100%
> > rename from arch/arm/mach-at91/include/mach/atmel_serial.h
> > rename to include/dm/platform_data/atmel_serial.h
>
> Hello Robert,
>
> These patches break the build for some boards. e.g. corvus_defconfig
>
>
> drivers/serial/atmel_usart.c: In function =E2=80=98atmel_serial_setbrg_in=
ternal=E2=80=99:
> drivers/serial/atmel_usart.c:44:20: error: implicit declaration of
> function =E2=80=98get_usart_clk_rate=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
>    44 |         usart_hz =3D get_usart_clk_rate(id);
>       |                    ^~~~~~~~~~~~~~~~~~
>   AR      spl/disk/built-in.a
>   CC      spl/fs/fs_internal.o
> cc1: some warnings being treated as errors

So, somehow during the SPL build, the following is not evaluated as true:
#if CONFIG_IS_ENABLED(ARCH_AT91)

Which is rather weird as u-boot.cfg in the spl dir has:
#define CONFIG_ARCH_AT91 1

So, this is some CONFIG_IS_ENABLED interaction with SPL that I am not
really familiar with as
#if IS_ENABLED(CONFIG_ARCH_AT91) works just fine and gets the header includ=
ed.

Regards,
Robert

>
>
> Please have a look,
> thanks,
> Eugen
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
