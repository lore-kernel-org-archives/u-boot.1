Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07185CCA472
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 12:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9543B8394A;
	Wed,  8 Oct 2025 14:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DcigdCxD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 814B68394A; Wed,  8 Oct 2025 14:54:24 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 610FA838AE
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 14:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-63994113841so6319235a12.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 05:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759928062; x=1760532862; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kCOdJRuI3IpCp/B1JVBkm5wREUrvpvx4G0TcdU4BH4c=;
 b=DcigdCxDWXfGc/m9rP3hodyR2T6xKC5zwowv2fvc6mHKZ3dmUTkAARxai0qm0e7Oi8
 5/3YzkyRDzStsgeDv9pIqA6OeN9fUcQphaORJK1TvOrg+adabguZG1FI6+Aboeypbh2K
 PaBJYQpCkrXb6T6sRqhSDA3cwQwuWBK9ub6y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759928062; x=1760532862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kCOdJRuI3IpCp/B1JVBkm5wREUrvpvx4G0TcdU4BH4c=;
 b=kkvlfkMk5LIMVnbard6W8F7aorQNzZsJjenuqqtK5Sv20Jpo/nkO47nnWmlXGD8HR6
 5F4MD6D7sMx5bQsJZ6vzKAlGE3duVL0SnPsgK4cPL3KQSDcUFhgQowzpKY5/yvVKep26
 g6ppfCoD6xZ/uEQB64rJZNc+2fFMxXzaR0Ebjc9WGbqfOJ35XtMsX2ThDJCjuwgRI8rI
 GofaeDiCPl+grc8SOBOaXHpNtlkcQZiBUBe1t0vR6ZRB0nme4Z3drCPrG++K8NU67wQQ
 FHJajlk0qXjzq/WYfWlYHRuqzDqaA2HedqHFMF0zbN786KGiZLg8FUd6GpCypElS+0G/
 NJiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBba7bqv5GAT5ydCrnw4YygzWqjd1MycvU4OU8ZUUSk+SU0qoJJ6vlDN5GcmdJyf9rq+L67O4=@lists.denx.de
X-Gm-Message-State: AOJu0YzLJhohj94X6ZDI0kZ8gXIj140Qch8tHuyY9tEMOxrx8WCVuP2c
 MllJ1SVGCnQG+EIvyp3M4yjNyMo3vNY5a9SsLDutiRAkWbLQby5iJAf5VhzPRYM/cstc6oD9xpk
 VP+OhXxbtPE8LyszmZ3NTmKhcZfQaxQ9c7zsjdHcF
X-Gm-Gg: ASbGncul0CmyqsQvTRS1SLWra9wh4txuSWpwumXkcnDZKQNr8aWdXxzTiOaNRZsLx/H
 oiOpKpQ/O48VKntVbxDYdt9p3FiV+omIb8UPmClmhv1TnIp5+oliBhSKR3ZRti8iMWR7kGjPyu1
 enyOPH/qBwxMq2Hz8X+NuJGAE7T8HHZOzrZ0/vSF0hpwQTHgg8Y7Zbbjw5DhK6UVZ0COe4/Qok6
 ZGYefZhc5Wm50WhOceTFy0kZjUBvw==
X-Google-Smtp-Source: AGHT+IES38aNiUzNnlllXPUKH70O6IvtvBZgnXYU2syZuagnJsl0onKlpLpa8VFj51IiDcNkEh71CnpGf/2E+QUYK6Y=
X-Received: by 2002:a05:6402:34c6:b0:62f:a904:7646 with SMTP id
 4fb4d7f45d1cf-639d5c2ae36mr2901717a12.21.1759928061683; Wed, 08 Oct 2025
 05:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20251003-feature_sysboot_extension_board-v1-6-458b8bf85325@bootlin.com>
 <CAFLszTj3j6bcm6PG1GLAHa6FfjpKOKL12P_ae4WZsJL4hbh-HA@mail.gmail.com>
 <20251006214428.GD298503@bill-the-cat>
 <CAFLszTgLd7gHoU04QKAgHWNFQz_CS_XfeJCBkn58fu3UxUyurQ@mail.gmail.com>
 <20251006234240.GF298503@bill-the-cat>
 <20251007113213.75efa663@kmaincent-XPS-13-7390>
 <20251007141148.GJ298503@bill-the-cat>
 <20251007182938.368bf435@kmaincent-XPS-13-7390>
 <20251007164207.GL298503@bill-the-cat>
 <CAFLszThB=o9Wq1K4XP1K_Oj+6db2ZuzK8kLw7KyGqCVqDBX7Gg@mail.gmail.com>
 <20251007201336.GQ298503@bill-the-cat>
In-Reply-To: <20251007201336.GQ298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Oct 2025 06:54:09 -0600
X-Gm-Features: AS18NWD2HZTr-uj4kw79Xs6FqvexZ-mWAaJG-s2mIxY-Q9I6Lm8-xb8sgjyJas4
Message-ID: <CAFLszTgX+BnH=wVjVb_5e0TifUP_At37Pz5500aPgsMb5bgRoA@mail.gmail.com>
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

On Tue, 7 Oct 2025 at 14:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 07, 2025 at 02:02:53PM -0600, Simon Glass wrote:
> > Hi,
> >
> > On Tue, 7 Oct 2025 at 10:42, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Oct 07, 2025 at 06:29:38PM +0200, Kory Maincent wrote:
> > > > On Tue, 7 Oct 2025 08:11:48 -0600
> > > > Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > > On Tue, Oct 07, 2025 at 11:32:13AM +0200, Kory Maincent wrote:
> > > > > > On Mon, 6 Oct 2025 17:42:40 -0600
> > > > > > Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > > On Mon, Oct 06, 2025 at 05:30:15PM -0600, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Mon, 6 Oct 2025 at 15:44, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Oct 06, 2025 at 02:38:23PM -0600, Simon Glass wrote:
> > > > > > > > > > Hi Kory,
> > > > > > > > > >
> > > > > > > > > > On Fri, 3 Oct 2025 at 10:34, Kory Maincent
> > > > > > > > > > <kory.maincent@bootlin.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Migrate TI board cape detection from legacy extension support to
> > > > > > > > > > > the new UCLASS-based extension board framework.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > > > > > -int extension_board_scan(struct list_head *extension_list)
> > > > > > > > > > > +static int ti_extension_board_scan(struct alist *extension_list)
> > > > > > > > > > >  {
> > > > > > > > > > >         unsigned char addr;
> > > > > > > > > > >         int num_capes = 0;
> > > > > > > > > > > @@ -31,7 +31,7 @@ int extension_board_scan(struct list_head
> > > > > > > > > > > *extension_list) struct am335x_cape_eeprom_id eeprom_header;
> > > > > > > > > > >                 char process_cape_part_number[17] = {'0'};
> > > > > > > > > > >                 char process_cape_version[5] = {'0'};
> > > > > > > > > > > -               struct extension *cape;
> > > > > > > > > > > +               struct extension cape = {0}, *_cape;
> > > > > > > > > > >                 struct udevice *dev;
> > > > > > > > > > >                 u8 cursor = 0;
> > > > > > > > > > >                 int ret, i;
> > > > > > > > > > > @@ -78,22 +78,20 @@ int extension_board_scan(struct list_head
> > > > > > > > > > > *extension_list)
> > > > > > > > > >
> > > > > > > > > > I suppose that a method called scan() could be added to the uclass
> > > > > > > > > > and implemented by this driver.
> > > > > >
> > > > > > I don't understand what do you mean by method? Is it different to the
> > > > > > UBOOT driver scan ops I have designed?
> > > > > >
> > > > > > > > > > >                 printf("BeagleBone Cape: %s (0x%x)\n",
> > > > > > > > > > > eeprom_header.board_name, addr);
> > > > > > > > > > >
> > > > > > > > > > > -               cape = calloc(1, sizeof(struct extension));
> > > > > > > > > > > -               if (!cape) {
> > > > > > > > > > > -                       printf("Error in memory allocation\n");
> > > > > > > > > > > -                       return num_capes;
> > > > > > > > > > > -               }
> > > > > > > > > > > -
> > > > > > > > > > > -               snprintf(cape->overlay, sizeof(cape->overlay),
> > > > > > > > > > > "%s-%s.dtbo",
> > > > > > > > > > > +               snprintf(cape.overlay, sizeof(cape.overlay),
> > > > > > > > > > > "%s-%s.dtbo", process_cape_part_number, process_cape_version);
> > > > > > > > > > > -               strlcpy(cape->name, eeprom_header.board_name,
> > > > > > > > > > > +               strlcpy(cape.name, eeprom_header.board_name,
> > > > > > > > > > >                         sizeof(eeprom_header.board_name));
> > > > > > > > > > > -               strlcpy(cape->version, process_cape_version,
> > > > > > > > > > > +               strlcpy(cape.version, process_cape_version,
> > > > > > > > > > >                         sizeof(process_cape_version));
> > > > > > > > > > > -               strlcpy(cape->owner, eeprom_header.manufacturer,
> > > > > > > > > > > +               strlcpy(cape.owner, eeprom_header.manufacturer,
> > > > > > > > > > >                         sizeof(eeprom_header.manufacturer) + 1);
> > > > > > > > > > > -               list_add_tail(&cape->list, extension_list);
> > > > > > > > > > > +               _cape = alist_add(extension_list, cape);
> > > > > > > > > > > +               if (!_cape)
> > > > > > > > > > > +                       return -ENOMEM;
> > > > > > > > > > >                 num_capes++;
> > > > > > > > > > >         }
> > > > > > > > > > >         return num_capes;
> > > > > > > > > > >  }
> > > > > > > > > > > +
> > > > > > > > > > > +U_BOOT_EXTENSION(cape, ti_extension_board_scan);
> > > > > > > > > >
> > > > > > > > > > Can the extension information go in the devicetree, so boards can
> > > > > > > > > > select their scheme that way?
> > > > > > > > >
> > > > > > > > > Since we're scanning to see what extension boards are present and so
> > > > > > > > > what device tree overlays to apply, I don't think that can work?
> > > > > > > >
> > > > > > > > My understanding is that the scanning process is board-specific. For
> > > > > > > > example we would not want the Beagle mechanism to be compiled into
> > > > > > > > rpi. The idea of scanning things in a board-specific way seems like a
> > > > > > > > driver to me. Note there is also the SYSINFO uclass which can do
> > > > > > > > similar things.
> > > > > > > >
> > > > > > > > The overlays being applied here are additions to what should already
> > > > > > > > be a fairly complete devicetree.
> > > > > > > >
> > > > > > > > If this isn't possible, then where is the information known?
> > > > > >
> > > > > > Oh, so you would prefer to have something like the sysinfo drivers.
> > > > > >
> > > > > > > You're commenting on a patch to the TI specific code, that's only used
> > > > > > > by TI SoC using platforms that opt-in to the externally defined EEPROM
> > > > > > > format for these "capes". Perhaps your feedback would make more sense in
> > > > > > > some other part of the patch series? But even then, I'm not sure it
> > > > > > > makes sense?
> > > > > >
> > > > > > I am ok to move the cape scan detection code to a standalone driver with a
> > > > > > devicetree compatible match. Just wondering what are the advantages to use
> > > > > > standalone drivers instead of having the code in the specific board code as
> > > > > > done in this series.
> > > > >
> > > > > I'm not sure there is an advantage. Especially since in theory we could
> > > > > have more than one built in, and if ti_extension_board_scan(...) doesn't
> > > > > find anything (because the EEPROM is missing/wrong) we could still then
> > > > > call rpi_extension_board_scan(...) and look for that formatted type of
> > > > > EEPROM and then chipanddip_extension_board_scan(...) and look for that
> > > > > and so forth. These extensions are nominally discoverable and so don't
> > > > > need device tree compatibles, was some of the point of all this I would
> > > > > have sworn...
> > > >
> > > > I think, he means a driver for each type of custom extension board scan
> > > > functions (4 until now). The U-boot devicetree would be like this:
> > > > extension_scan {
> > > >       compatible = "bone-cape-scan";
> > > > };
> > > >
> > > > We could avoid the build of several extension drivers using Kconfig choice
> > > > symbol to select only one builtin.
> > > >
> > > > On my side I don't really have opinions, it is a matter of code design. For now
> > > > I don't see real argument to tilt the balance except to do something like
> > > > sysinfo. We need more arguments from Simon.
> > >
> > > Yes, and needing to go back to modifying the device trees seems a step
> > > backwards here, and something that will be hard to argue for upstream.
> >
> > How do you define the mechanism to read the cape (etc.) information?
>
> Well, a cape for the TI platforms has to have a properly formatted
> EEPROM. I forget how the CHIP/DIP thing worked, but I believe it was
> similar (since it originated in the same era). I also believe Pi is
> similar as well.
>
> > Presumably it is using a device which is already in the devicetree? So
> > it is the actual extension mechanism that is not present, perhaps?
> >
> > How does Linux model extensions?
>
> Last I knew it doesn't and much discussion was had to arrive at that
> point a decade or so ago. I believe FPGA stuff has been allowed since
> then, but physical extensions not, and it's a bootloader problem. Which
> is why we've been solving it for a while (it was more ad-hoc before Kory
> did the current implementation in 2021).

OK, well the compatible string above at least allows a driver to be
selected and all the board-specific stuff can go in there. Perhaps re
can just reuse the sysinfo uclass? Perhaps we could talk about this in
a future call?

Regards,
Simon
