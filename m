Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383EDCCA470
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 23:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B433A83A8D;
	Tue,  7 Oct 2025 01:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X/mP5KWA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB1A583A94; Tue,  7 Oct 2025 01:30:31 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACEA283929
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 01:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-62fb48315ddso9851417a12.2
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 16:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759793428; x=1760398228; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AyDwON0NkOjwafNfCXEoZmHwxGUG30mEtSKQNsazk5s=;
 b=X/mP5KWAljhrdm52sOsy5x9kVv4R87aQaM3KgsenvV/IKgP+0LijJai96lJ27c9/7z
 UgBWJ+csVaiTnl34NGV0JfEXpTgpK5za0kSdmJvHWs18mnTtsbfhMXq9p2N/zcgcIyl3
 cyWUUfhECybC49VAv4zM63XIBlrd8ceEwgnVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759793428; x=1760398228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AyDwON0NkOjwafNfCXEoZmHwxGUG30mEtSKQNsazk5s=;
 b=CecEwlIsQoTNqGEWKCYoy+KCArJVj/LUAHGBw3ffVtsdIlzEuI98TDDdVioIRlU00U
 Zq7JEYlCGlj8pzj75pNiOs92b7AZYydqesn+nOawPUWQt5xt2sucQGTYnln/wxhvpubN
 RUf9dRbYnF8cc6oPonzUrtHMQ67faYZGQxtcH1uEUZRIt+6Ga4ejGDUNOqQigzZuDGe2
 FACTwcNMHt2pLToJx6wNWbWYHZgpP1vh+wiVufdQC99egVtWRQKPJi1tdH5RM/eU6FBt
 pGEm9dEgv1cqLu8JODe74Un/YSzWSCK5hbLbyGmvY8FR5YJ6f4tViOk50v0EeutOlhh8
 Q6nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWegFggQ8enZFK3EM9LEQ6r2MsLMzz1d0+9Tn1KPuyr8GDR0YO1NdslijRfBeZ2KiaHkPf9TlE=@lists.denx.de
X-Gm-Message-State: AOJu0YwtNaVse9EwWAwdlkesrFnyOIADPOxHjaShibFrP86VhKdiU6vm
 T2413QED24HH2sr5IR7TpPUIt40Q269zl2U1O3q8Qv62gfCyKpd87oD979QzBlLlinCA9cP1dZh
 zTxnk2XsFhJhhJc6VTCQKa/cfuf8Djpn/Rezal1HE
X-Gm-Gg: ASbGncvz9inGjIxK61U/lwCpUCnE+VQ96Fxev2l3q2a6YUqp1Z4JRfkHB82WA5gCdyv
 B3OYsfL+tPlL4j7Tnrx0QwkYeUFJtH7PWH7G1E+pNaLo1d1ONCH4IeoASa/7ncbjcvTG5QC3CgG
 miLNLQ2ovmgE0Fbndy1btAkrD0K8Adwrl27CBPyrmiWR/fskwDmNjqFMFexl26/SbyO5fPVCY7u
 aqqS7+b3jnzRRDrwp68BrqKu/AqhC5I
X-Google-Smtp-Source: AGHT+IHTR9KTXOw7Z4Wq1SWRke2mUcvd7qPxZFYqu89idD6Z0Y7+WjJIuB8rmEeKMKud8csj2srj/t/lad3FJm9ETl0=
X-Received: by 2002:a05:6402:5205:b0:634:ab25:3f72 with SMTP id
 4fb4d7f45d1cf-639348f1206mr16350421a12.10.1759793428136; Mon, 06 Oct 2025
 16:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
 <20251003-feature_sysboot_extension_board-v1-6-458b8bf85325@bootlin.com>
 <CAFLszTj3j6bcm6PG1GLAHa6FfjpKOKL12P_ae4WZsJL4hbh-HA@mail.gmail.com>
 <20251006214428.GD298503@bill-the-cat>
In-Reply-To: <20251006214428.GD298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Oct 2025 17:30:15 -0600
X-Gm-Features: AS18NWAcWYjXQGalLv3vSS3Gj2ZgCtD9xoDahRAArYSGMR3HVmA_bSbJce12iac
Message-ID: <CAFLszTgLd7gHoU04QKAgHWNFQz_CS_XfeJCBkn58fu3UxUyurQ@mail.gmail.com>
Subject: Re: [PATCH 06/16] board: ti: Convert cape detection to use UCLASS
 framework
To: Tom Rini <trini@konsulko.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
 Mario Six <mario.six@gdsys.cc>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

Hi Tom,

On Mon, 6 Oct 2025 at 15:44, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 06, 2025 at 02:38:23PM -0600, Simon Glass wrote:
> > Hi Kory,
> >
> > On Fri, 3 Oct 2025 at 10:34, Kory Maincent <kory.maincent@bootlin.com> wrote:
> > >
> > > Migrate TI board cape detection from legacy extension support to the
> > > new UCLASS-based extension board framework.
> > >
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > ---
> > >  arch/arm/mach-omap2/am33xx/Kconfig |  2 +-
> > >  arch/arm/mach-omap2/omap5/Kconfig  |  2 +-
> > >  board/ti/common/cape_detect.c      | 24 +++++++++++-------------
> > >  3 files changed, 13 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/am33xx/Kconfig b/arch/arm/mach-omap2/am33xx/Kconfig
> > > index dff4f1cf202..77f7938305b 100644
> > > --- a/arch/arm/mach-omap2/am33xx/Kconfig
> > > +++ b/arch/arm/mach-omap2/am33xx/Kconfig
> > > @@ -15,7 +15,7 @@ config TARGET_AM335X_EVM
> > >         select DM_GPIO
> > >         select DM_SERIAL
> > >         select TI_I2C_BOARD_DETECT
> > > -       select SUPPORT_EXTENSION_SCAN
> > > +       select SUPPORT_DM_EXTENSION_SCAN
> > >         imply CMD_DM
> > >         imply SPL_DM
> > >         imply SPL_DM_SEQ_ALIAS
> > > diff --git a/arch/arm/mach-omap2/omap5/Kconfig b/arch/arm/mach-omap2/omap5/Kconfig
> > > index 5394529658b..819490a8cf8 100644
> > > --- a/arch/arm/mach-omap2/omap5/Kconfig
> > > +++ b/arch/arm/mach-omap2/omap5/Kconfig
> > > @@ -38,7 +38,7 @@ config TARGET_AM57XX_EVM
> > >         select CMD_DDR3
> > >         select DRA7XX
> > >         select TI_I2C_BOARD_DETECT
> > > -       select SUPPORT_EXTENSION_SCAN
> > > +       select SUPPORT_DM_EXTENSION_SCAN
> > >         imply DM_THERMAL
> > >         imply SCSI
> > >         imply SPL_THERMAL
> > > diff --git a/board/ti/common/cape_detect.c b/board/ti/common/cape_detect.c
> > > index 7786bdda5d1..23c93964dc3 100644
> > > --- a/board/ti/common/cape_detect.c
> > > +++ b/board/ti/common/cape_detect.c
> > > @@ -22,7 +22,7 @@ static void sanitize_field(char *text, size_t size)
> > >         }
> > >  }
> > >
> > > -int extension_board_scan(struct list_head *extension_list)
> > > +static int ti_extension_board_scan(struct alist *extension_list)
> > >  {
> > >         unsigned char addr;
> > >         int num_capes = 0;
> > > @@ -31,7 +31,7 @@ int extension_board_scan(struct list_head *extension_list)
> > >                 struct am335x_cape_eeprom_id eeprom_header;
> > >                 char process_cape_part_number[17] = {'0'};
> > >                 char process_cape_version[5] = {'0'};
> > > -               struct extension *cape;
> > > +               struct extension cape = {0}, *_cape;
> > >                 struct udevice *dev;
> > >                 u8 cursor = 0;
> > >                 int ret, i;
> > > @@ -78,22 +78,20 @@ int extension_board_scan(struct list_head *extension_list)
> >
> > I suppose that a method called scan() could be added to the uclass and
> > implemented by this driver.
> >
> > >
> > >                 printf("BeagleBone Cape: %s (0x%x)\n", eeprom_header.board_name, addr);
> > >
> > > -               cape = calloc(1, sizeof(struct extension));
> > > -               if (!cape) {
> > > -                       printf("Error in memory allocation\n");
> > > -                       return num_capes;
> > > -               }
> > > -
> > > -               snprintf(cape->overlay, sizeof(cape->overlay), "%s-%s.dtbo",
> > > +               snprintf(cape.overlay, sizeof(cape.overlay), "%s-%s.dtbo",
> > >                          process_cape_part_number, process_cape_version);
> > > -               strlcpy(cape->name, eeprom_header.board_name,
> > > +               strlcpy(cape.name, eeprom_header.board_name,
> > >                         sizeof(eeprom_header.board_name));
> > > -               strlcpy(cape->version, process_cape_version,
> > > +               strlcpy(cape.version, process_cape_version,
> > >                         sizeof(process_cape_version));
> > > -               strlcpy(cape->owner, eeprom_header.manufacturer,
> > > +               strlcpy(cape.owner, eeprom_header.manufacturer,
> > >                         sizeof(eeprom_header.manufacturer) + 1);
> > > -               list_add_tail(&cape->list, extension_list);
> > > +               _cape = alist_add(extension_list, cape);
> > > +               if (!_cape)
> > > +                       return -ENOMEM;
> > >                 num_capes++;
> > >         }
> > >         return num_capes;
> > >  }
> > > +
> > > +U_BOOT_EXTENSION(cape, ti_extension_board_scan);
> >
> > Can the extension information go in the devicetree, so boards can
> > select their scheme that way?
>
> Since we're scanning to see what extension boards are present and so
> what device tree overlays to apply, I don't think that can work?

My understanding is that the scanning process is board-specific. For
example we would not want the Beagle mechanism to be compiled into
rpi. The idea of scanning things in a board-specific way seems like a
driver to me. Note there is also the SYSINFO uclass which can do
similar things.

The overlays being applied here are additions to what should already
be a fairly complete devicetree.

If this isn't possible, then where is the information known?

Regards,
SImon
