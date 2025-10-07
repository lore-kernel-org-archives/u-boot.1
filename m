Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE589CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 20:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25FF08397A;
	Tue,  7 Oct 2025 22:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NP4a9P71";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E1B283981; Tue,  7 Oct 2025 22:03:08 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EECE383959
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 22:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b00a9989633so56452166b.0
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 13:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759867385; x=1760472185; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uoZjLi/ifuCSNxG5NCENgUxLEUUcJziWWKrdk6obHM8=;
 b=NP4a9P71It4rgG4D8dRtwvMP5zrLndNs1aTPeDiLVR3M7B1V3Mn/oq/zXBUM+tZEMj
 oTpUAwaqeJiul9PI4QMPRdAxrz/QwJC8A5agom3NFr0Dw8orbcXZSq2+FH7UgyEslIsH
 0PghXjCkfCA9Lk7sZE5OaI0p6DnTQs4+yCQwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759867385; x=1760472185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uoZjLi/ifuCSNxG5NCENgUxLEUUcJziWWKrdk6obHM8=;
 b=xBlucthwobKMPSI/EgmQQDNVqViRGT3YCv7JCpwf37yUaUMApp6t5lw6EGcIa0Zhew
 ykiH0ClayU3IYUZ3Cs+B/5w6ma0kbV2DXauARkj6/UXWTTCvuHaOKRzJZoLzEIEMJHzw
 Mr+Wt0BOkSFTjjcGQbhQbA62NqdqlTghRq/Q46DJONmFQT318sRlYqIWd2hQy8DxePE9
 GjaD6x1ZN+fYoJU6YTYwKZzBEAXmcz/wSbPJBMfcXHc8hizfsJAWCa7ENjMmz5AIHAYq
 OD+p+mVg0sO2gs5K7ZwOZOk//ZB3fAsYgQ4oftYi4P7nGcvL0CIecd8+OG5rdaF4SO5P
 G9Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhWplvmNXEm/+MRmAmYRLWRy9VuE+I2Vtoku3jTHGzzlZFxHyCYIDo+02bSc5m6qhOky5JGU0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3cYw07750u9NomZiDufSddXXNStZ2z6YC0mng1btSl0yo/dN/
 zRrEtvQxBmjWApUh3AMTafgRNRSozq2hQS5pKLnyXq9cDP+ufp36rkshHyzosOmicMzwPQUpUaD
 UYqpgSt+vl8eyNoepoxRF7p5GLYHf7VYrZd93GS2Y
X-Gm-Gg: ASbGnctKs+DnOQyugLqgR+YYBIruhnhVd+32+tctuQOBiokpbaGnIu4BwPL/fUDW/bf
 9zDI1wlSf2szQDZ1yiaGFYt4omN+vb63+dIlY0VdS+8YJ6eoSdFW381wVteJwMLPoMTnQyeEh0A
 rek7SYRI4SztUe3iaM5BQ5iHEEcEIJBeFijJYhD62N+BjoQE4fU5f9bg02Zk1MNUntGFlcXMx9L
 hIHERATmlpYK9ZWFYogTjsrrudiKg==
X-Google-Smtp-Source: AGHT+IFSuBvApPG2VPD/ErOEq+BGEQ3SSYvQlu714aHsqU4WRpsldgXETxoCJSvPKhJLul0zOn7pXBvwG2iQ2+YZ3k4=
X-Received: by 2002:a17:907:c297:b0:b3f:f6d:1d9e with SMTP id
 a640c23a62f3a-b4f40789662mr645311166b.6.1759867385279; Tue, 07 Oct 2025
 13:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
 <20251003-feature_sysboot_extension_board-v1-6-458b8bf85325@bootlin.com>
 <CAFLszTj3j6bcm6PG1GLAHa6FfjpKOKL12P_ae4WZsJL4hbh-HA@mail.gmail.com>
 <20251006214428.GD298503@bill-the-cat>
 <CAFLszTgLd7gHoU04QKAgHWNFQz_CS_XfeJCBkn58fu3UxUyurQ@mail.gmail.com>
 <20251006234240.GF298503@bill-the-cat>
 <20251007113213.75efa663@kmaincent-XPS-13-7390>
 <20251007141148.GJ298503@bill-the-cat>
 <20251007182938.368bf435@kmaincent-XPS-13-7390>
 <20251007164207.GL298503@bill-the-cat>
In-Reply-To: <20251007164207.GL298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Oct 2025 14:02:53 -0600
X-Gm-Features: AS18NWDxDxxT4aMjZdb_-hetvkYdn5NpD-HHfPmZYPHq9qHYPGdc-R2R6ew8xW8
Message-ID: <CAFLszThB=o9Wq1K4XP1K_Oj+6db2ZuzK8kLw7KyGqCVqDBX7Gg@mail.gmail.com>
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

Hi,

On Tue, 7 Oct 2025 at 10:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 07, 2025 at 06:29:38PM +0200, Kory Maincent wrote:
> > On Tue, 7 Oct 2025 08:11:48 -0600
> > Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Tue, Oct 07, 2025 at 11:32:13AM +0200, Kory Maincent wrote:
> > > > On Mon, 6 Oct 2025 17:42:40 -0600
> > > > Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > > On Mon, Oct 06, 2025 at 05:30:15PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 6 Oct 2025 at 15:44, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Mon, Oct 06, 2025 at 02:38:23PM -0600, Simon Glass wrote:
> > > > > > > > Hi Kory,
> > > > > > > >
> > > > > > > > On Fri, 3 Oct 2025 at 10:34, Kory Maincent
> > > > > > > > <kory.maincent@bootlin.com> wrote:
> > > > > > > > >
> > > > > > > > > Migrate TI board cape detection from legacy extension support to
> > > > > > > > > the new UCLASS-based extension board framework.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > >
> > > > ...
> > > >
> > > > > > > > > -int extension_board_scan(struct list_head *extension_list)
> > > > > > > > > +static int ti_extension_board_scan(struct alist *extension_list)
> > > > > > > > >  {
> > > > > > > > >         unsigned char addr;
> > > > > > > > >         int num_capes = 0;
> > > > > > > > > @@ -31,7 +31,7 @@ int extension_board_scan(struct list_head
> > > > > > > > > *extension_list) struct am335x_cape_eeprom_id eeprom_header;
> > > > > > > > >                 char process_cape_part_number[17] = {'0'};
> > > > > > > > >                 char process_cape_version[5] = {'0'};
> > > > > > > > > -               struct extension *cape;
> > > > > > > > > +               struct extension cape = {0}, *_cape;
> > > > > > > > >                 struct udevice *dev;
> > > > > > > > >                 u8 cursor = 0;
> > > > > > > > >                 int ret, i;
> > > > > > > > > @@ -78,22 +78,20 @@ int extension_board_scan(struct list_head
> > > > > > > > > *extension_list)
> > > > > > > >
> > > > > > > > I suppose that a method called scan() could be added to the uclass
> > > > > > > > and implemented by this driver.
> > > >
> > > > I don't understand what do you mean by method? Is it different to the
> > > > UBOOT driver scan ops I have designed?
> > > >
> > > > > > > > >                 printf("BeagleBone Cape: %s (0x%x)\n",
> > > > > > > > > eeprom_header.board_name, addr);
> > > > > > > > >
> > > > > > > > > -               cape = calloc(1, sizeof(struct extension));
> > > > > > > > > -               if (!cape) {
> > > > > > > > > -                       printf("Error in memory allocation\n");
> > > > > > > > > -                       return num_capes;
> > > > > > > > > -               }
> > > > > > > > > -
> > > > > > > > > -               snprintf(cape->overlay, sizeof(cape->overlay),
> > > > > > > > > "%s-%s.dtbo",
> > > > > > > > > +               snprintf(cape.overlay, sizeof(cape.overlay),
> > > > > > > > > "%s-%s.dtbo", process_cape_part_number, process_cape_version);
> > > > > > > > > -               strlcpy(cape->name, eeprom_header.board_name,
> > > > > > > > > +               strlcpy(cape.name, eeprom_header.board_name,
> > > > > > > > >                         sizeof(eeprom_header.board_name));
> > > > > > > > > -               strlcpy(cape->version, process_cape_version,
> > > > > > > > > +               strlcpy(cape.version, process_cape_version,
> > > > > > > > >                         sizeof(process_cape_version));
> > > > > > > > > -               strlcpy(cape->owner, eeprom_header.manufacturer,
> > > > > > > > > +               strlcpy(cape.owner, eeprom_header.manufacturer,
> > > > > > > > >                         sizeof(eeprom_header.manufacturer) + 1);
> > > > > > > > > -               list_add_tail(&cape->list, extension_list);
> > > > > > > > > +               _cape = alist_add(extension_list, cape);
> > > > > > > > > +               if (!_cape)
> > > > > > > > > +                       return -ENOMEM;
> > > > > > > > >                 num_capes++;
> > > > > > > > >         }
> > > > > > > > >         return num_capes;
> > > > > > > > >  }
> > > > > > > > > +
> > > > > > > > > +U_BOOT_EXTENSION(cape, ti_extension_board_scan);
> > > > > > > >
> > > > > > > > Can the extension information go in the devicetree, so boards can
> > > > > > > > select their scheme that way?
> > > > > > >
> > > > > > > Since we're scanning to see what extension boards are present and so
> > > > > > > what device tree overlays to apply, I don't think that can work?
> > > > > >
> > > > > > My understanding is that the scanning process is board-specific. For
> > > > > > example we would not want the Beagle mechanism to be compiled into
> > > > > > rpi. The idea of scanning things in a board-specific way seems like a
> > > > > > driver to me. Note there is also the SYSINFO uclass which can do
> > > > > > similar things.
> > > > > >
> > > > > > The overlays being applied here are additions to what should already
> > > > > > be a fairly complete devicetree.
> > > > > >
> > > > > > If this isn't possible, then where is the information known?
> > > >
> > > > Oh, so you would prefer to have something like the sysinfo drivers.
> > > >
> > > > > You're commenting on a patch to the TI specific code, that's only used
> > > > > by TI SoC using platforms that opt-in to the externally defined EEPROM
> > > > > format for these "capes". Perhaps your feedback would make more sense in
> > > > > some other part of the patch series? But even then, I'm not sure it
> > > > > makes sense?
> > > >
> > > > I am ok to move the cape scan detection code to a standalone driver with a
> > > > devicetree compatible match. Just wondering what are the advantages to use
> > > > standalone drivers instead of having the code in the specific board code as
> > > > done in this series.
> > >
> > > I'm not sure there is an advantage. Especially since in theory we could
> > > have more than one built in, and if ti_extension_board_scan(...) doesn't
> > > find anything (because the EEPROM is missing/wrong) we could still then
> > > call rpi_extension_board_scan(...) and look for that formatted type of
> > > EEPROM and then chipanddip_extension_board_scan(...) and look for that
> > > and so forth. These extensions are nominally discoverable and so don't
> > > need device tree compatibles, was some of the point of all this I would
> > > have sworn...
> >
> > I think, he means a driver for each type of custom extension board scan
> > functions (4 until now). The U-boot devicetree would be like this:
> > extension_scan {
> >       compatible = "bone-cape-scan";
> > };
> >
> > We could avoid the build of several extension drivers using Kconfig choice
> > symbol to select only one builtin.
> >
> > On my side I don't really have opinions, it is a matter of code design. For now
> > I don't see real argument to tilt the balance except to do something like
> > sysinfo. We need more arguments from Simon.
>
> Yes, and needing to go back to modifying the device trees seems a step
> backwards here, and something that will be hard to argue for upstream.

How do you define the mechanism to read the cape (etc.) information?
Presumably it is using a device which is already in the devicetree? So
it is the actual extension mechanism that is not present, perhaps?

How does Linux model extensions?

Regards,
Simon
