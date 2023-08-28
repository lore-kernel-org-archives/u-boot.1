Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E137C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 13:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 552098056A;
	Mon, 28 Aug 2023 15:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jtSgEAdn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EE5580275; Mon, 28 Aug 2023 15:23:55 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40DEE805C8
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 15:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cryosay@gmail.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3a850f07fadso2434334b6e.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 06:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693229031; x=1693833831;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=brFoLEhX9gxCANbDLrVJl9Ef0YFejHxrcApmJ1qqEP8=;
 b=jtSgEAdnntAt/TWqndC0tiF3TapkMLIsMA0KVbk7Nehp11RsXUiQjx/uzatxkiyclF
 o4V9lZVpAmqqNKyNrQQxiOTntQbGjRW2uyJz/soo2/1GfYXhjSpNYXpUSU3ZGKyUu9cz
 +Vpj2AbSNGvvuxk5y8zYNBaNL7RXc4rx/17s9apnm3DJbNAfhdbys9pTybPr3b8YxQDq
 1AqUEQnbqR5szzKh65yxx2DA9THJOVI191h1L5+BncNmr4dN+/OEiI4dBYYDUiKgdvoC
 Yj7Coe8IQWx+lGMkBLJ5R1s6ghFgRVGvfJqGwS24QNZcKgRKJGHMzBluYz992d/HmrSq
 urHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693229031; x=1693833831;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=brFoLEhX9gxCANbDLrVJl9Ef0YFejHxrcApmJ1qqEP8=;
 b=EhLjpuKKeKYnI59/hHMvjYhUJMXFpP/5T3auX3cbJhaESudL+Au/MuRrKsUU08FZZv
 arI8mFkmVyOvdKUTO/Md1bwkIwutA1j5cUBdxf7fsW93NtT2bA9DBmhXuGxUazlX8lgy
 WkC8AynCKUXw6Jw0LPEmtu6xPLlYfw854dmXB4aHy5WzVhha/UzHzwhX6F6tx5ag6ZDK
 kqWWXtnpjGk6zw6hpaYidDiGYXvPXjqJIo+g+p0pBYzZRSMS05TfoXS6rZszCpth7VTj
 yQSKYA7S0wvQUPOJUTjCyDgBTJxjYfnnVCb441hUJ/rhVj7FS58V6bv2GEAA8HVPie4/
 NCKg==
X-Gm-Message-State: AOJu0YxLVU+H3v7KePraE2U1ZKcYSQdhRVjKpGK+RQC/5U/f4ao8fydQ
 rbduqc5oC5GUQY7B74piD9Y++/KzKFiP8kui5Hc=
X-Google-Smtp-Source: AGHT+IE3rQc/o6ltvXcsHN/PbJPPJwdy9bzuJSRcc9UyRk8a+L1zP8rphMU/rK5YNbqqfsnvy1cU5bgu8FyMGr+zicA=
X-Received: by 2002:a05:6870:a687:b0:1b7:4a32:4ac6 with SMTP id
 i7-20020a056870a68700b001b74a324ac6mr12440521oam.31.1693229030803; Mon, 28
 Aug 2023 06:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230823120021.50146-1-oleksandr.suvorov@foundries.io>
 <65aced18-8116-9501-07ad-13281a3498b6@denx.de>
In-Reply-To: <65aced18-8116-9501-07ad-13281a3498b6@denx.de>
From: Oleksandr Suvorov <cryosay@gmail.com>
Date: Mon, 28 Aug 2023 16:23:38 +0300
Message-ID: <CAGgjyvFqP0NC=Mp83BRQBSQ26T_NnBjoor+tCL0BP4uG_G3=NA@mail.gmail.com>
Subject: Re: [PATCH v2] spl: watchdog: introduce SPL_HW_WATCHDOG
To: Stefan Roese <sr@denx.de>
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, u-boot@lists.denx.de, 
 Igor Opaniuk <igor.opaniuk@foundries.io>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Paul Barker <paul.barker@sancloud.com>, Roger Quadros <rogerq@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
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

Hi Stefan,

On Thu, Aug 24, 2023 at 2:24=E2=80=AFPM Stefan Roese <sr@denx.de> wrote:
>
> On 8/23/23 14:00, Oleksandr Suvorov wrote:
> > Add SPL_HW_WATCHDOG Kconfig symbol which can be used to enable
> > non-WDT hardware watchdog in SPL.
>
> Hmmm, my hope / plan was to completely drop HW_WATCHDOG at some point.
> It's some old relict and if I don't miss something completely, it's more
> a "normal" watchdog that needs to get triggered very early in most
> cases (PowerPC etc).

Oh, it's a good approach, thanks.

> So adding some more *_HW_WATCHDOG stuff does not sound appealing to me.
> Could you perhaps investigate a bit, if your HW_WATCHDOG use case can
> be converted to the "normal" watchdog support instead?

We just need to be able to exclude a hardware watchdog from SPL to
save some memory.
So I resign this patch and we'll wait for your work and then revise
what we have again.

> Thanks,
> Stefan

Cheers,
Oleksandr

>
> > Co-developed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> > ---
> >
> > Changes in v2:
> > - remove mistakenly included unwanted changes
> >
> >   common/spl/Kconfig        | 1 -
> >   drivers/Makefile          | 1 +
> >   drivers/sysreset/Kconfig  | 6 ++++++
> >   drivers/sysreset/Makefile | 2 +-
> >   drivers/watchdog/Kconfig  | 4 ++++
> >   5 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > index c5dd476db58..07d9dac29bd 100644
> > --- a/common/spl/Kconfig
> > +++ b/common/spl/Kconfig
> > @@ -1351,7 +1351,6 @@ config SPL_THERMAL
> >
> >   config SPL_WATCHDOG
> >       bool "Support watchdog drivers"
> > -     imply SPL_WDT if !HW_WATCHDOG
> >       help
> >         Enable support for watchdog drivers in SPL. A watchdog is
> >         typically a hardware peripheral which can reset the system when=
 it
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index efc2a4afb24..2eb8ec0a894 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -62,6 +62,7 @@ obj-$(CONFIG_SPL_USB_GADGET) +=3D usb/gadget/
> >   obj-$(CONFIG_SPL_USB_GADGET) +=3D usb/common/
> >   obj-$(CONFIG_SPL_USB_GADGET) +=3D usb/gadget/udc/
> >   obj-$(CONFIG_SPL_WATCHDOG) +=3D watchdog/
> > +obj-$(CONFIG_SPL_HW_WATCHDOG) +=3D watchdog/
> >   obj-$(CONFIG_SPL_USB_HOST) +=3D usb/host/
> >   obj-$(CONFIG_SPL_SATA) +=3D ata/ scsi/
> >   obj-$(CONFIG_SPL_LEGACY_BLOCK) +=3D block/
> > diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> > index bdbe2a95364..0d21673e402 100644
> > --- a/drivers/sysreset/Kconfig
> > +++ b/drivers/sysreset/Kconfig
> > @@ -157,6 +157,12 @@ config SYSRESET_WATCHDOG
> >       help
> >         Reboot support for generic watchdog reset.
> >
> > +config SPL_SYSRESET_WATCHDOG
> > +     bool "Enable support for watchdog reboot driver in SPL mode"
> > +     select SPL_WDT
> > +     help
> > +       Reboot support for generic watchdog reset in SPL mode.
> > +
> >   config SYSRESET_WATCHDOG_AUTO
> >       bool "Automatically register first watchdog with sysreset"
> >       depends on SYSRESET_WATCHDOG
> > diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> > index 40c876764af..e5a7fc07a81 100644
> > --- a/drivers/sysreset/Makefile
> > +++ b/drivers/sysreset/Makefile
> > @@ -18,7 +18,7 @@ obj-$(CONFIG_SYSRESET_SOCFPGA) +=3D sysreset_socfpga.=
o
> >   obj-$(CONFIG_SYSRESET_SOCFPGA_SOC64) +=3D sysreset_socfpga_soc64.o
> >   obj-$(CONFIG_SYSRESET_TI_SCI) +=3D sysreset-ti-sci.o
> >   obj-$(CONFIG_SYSRESET_SYSCON) +=3D sysreset_syscon.o
> > -obj-$(CONFIG_SYSRESET_WATCHDOG) +=3D sysreset_watchdog.o
> > +obj-$(CONFIG_$(SPL_)SYSRESET_WATCHDOG) +=3D sysreset_watchdog.o
> >   obj-$(CONFIG_SYSRESET_RESETCTL) +=3D sysreset_resetctl.o
> >   obj-$(CONFIG_$(SPL_TPL_)SYSRESET_AT91) +=3D sysreset_at91.o
> >   obj-$(CONFIG_$(SPL_TPL_)SYSRESET_X86) +=3D sysreset_x86.o
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 07fc4940e91..d696a04fc18 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -39,9 +39,13 @@ config WATCHDOG_TIMEOUT_MSECS
> >   config HW_WATCHDOG
> >       bool
> >
> > +config SPL_HW_WATCHDOG
> > +     bool
> > +
> >   config IMX_WATCHDOG
> >       bool "Enable Watchdog Timer support for IMX and LSCH2 of NXP"
> >       select HW_WATCHDOG if !WDT
> > +     select SPL_HW_WATCHDOG if !SPL_WDT
> >       help
> >         Select this to enable the IMX and LSCH2 of Layerscape watchdog
> >         driver.
>
> Viele Gr=C3=BC=C3=9Fe,
> Stefan Roese
>
> --
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de



--=20
Best regards
Oleksandr

Oleksandr Suvorov
cryosay@gmail.com
