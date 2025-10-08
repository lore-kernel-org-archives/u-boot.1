Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD288CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 09:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D11B2839B5;
	Wed,  8 Oct 2025 11:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="uwBmSbF2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A71CF839B5; Wed,  8 Oct 2025 11:09:00 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D35D8393F
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 11:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 9AA654E40F7F;
 Wed,  8 Oct 2025 09:08:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6FF18606E5;
 Wed,  8 Oct 2025 09:08:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5A985102F213B; 
 Wed,  8 Oct 2025 11:08:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759914536; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Z5hg/AfXvHmPIMPNecl1VzaZ8t+YbHUUNGGsg6TFMko=;
 b=uwBmSbF2FjRnUokZ5zL09GTHhxP/yHdgwtMMtGvvDTBSFRpPJQhvr8E6LLmpbIqfJiI8xJ
 PmuNMCbvyIP4RAnV28JXcQtsVXBPS6Ka3C4tTz6ejl+UxCc5StqzZyR3YXxqOFs119frfx
 XVlxqkbjlxkCAjQmdOvjmTzGThm0nNA8Tjv3E+AG8Wu8Rp6v6rryO2KgiRSmVl/GZQNPIu
 YU5PoCHvsUhGFg8AuppIi4af7Xp9uzs07SyE4XpZmMWyNUr/wyJUCAV5Lig59UkMGC8VsM
 TwFG6hSa1pZBtRm1ewf3fiz7rN0KAF+CWwQJSrwDkq3JGUmXsng6xMdpLY9+YA==
Date: Wed, 8 Oct 2025 11:08:50 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede
 <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 06/16] board: ti: Convert cape detection to use UCLASS
 framework
Message-ID: <20251008110850.43804e8e@kmaincent-XPS-13-7390>
In-Reply-To: <20251007201336.GQ298503@bill-the-cat>
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
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Tue, 7 Oct 2025 14:13:36 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Tue, Oct 07, 2025 at 02:02:53PM -0600, Simon Glass wrote:
> > Hi,
> >=20
> > On Tue, 7 Oct 2025 at 10:42, Tom Rini <trini@konsulko.com> wrote: =20
> > >
> > > On Tue, Oct 07, 2025 at 06:29:38PM +0200, Kory Maincent wrote: =20
> > > > On Tue, 7 Oct 2025 08:11:48 -0600
> > > > Tom Rini <trini@konsulko.com> wrote:
> > > > =20
> > > > > On Tue, Oct 07, 2025 at 11:32:13AM +0200, Kory Maincent wrote: =20
> > > > > > On Mon, 6 Oct 2025 17:42:40 -0600
> > > > > > Tom Rini <trini@konsulko.com> wrote:
> > > > > > =20
> > > > > > > On Mon, Oct 06, 2025 at 05:30:15PM -0600, Simon Glass wrote: =
=20
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Mon, 6 Oct 2025 at 15:44, Tom Rini <trini@konsulko.com>
> > > > > > > > wrote: =20
> > > > > > > > >
> > > > > > > > > On Mon, Oct 06, 2025 at 02:38:23PM -0600, Simon Glass wro=
te: =20
> > > > > > > > > > Hi Kory,
> > > > > > > > > >
> > > > > > > > > > On Fri, 3 Oct 2025 at 10:34, Kory Maincent
> > > > > > > > > > <kory.maincent@bootlin.com> wrote: =20
> > > > > > > > > > >
> > > > > > > > > > > Migrate TI board cape detection from legacy extension
> > > > > > > > > > > support to the new UCLASS-based extension board frame=
work.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.c=
om> =20
> > > > > >
> > > > > > ...
> > > > > > =20
> > > > > > > > > > > -int extension_board_scan(struct list_head
> > > > > > > > > > > *extension_list) +static int
> > > > > > > > > > > ti_extension_board_scan(struct alist *extension_list)=
 {
> > > > > > > > > > >         unsigned char addr;
> > > > > > > > > > >         int num_capes =3D 0;
> > > > > > > > > > > @@ -31,7 +31,7 @@ int extension_board_scan(struct
> > > > > > > > > > > list_head *extension_list) struct am335x_cape_eeprom_=
id
> > > > > > > > > > > eeprom_header; char process_cape_part_number[17] =3D =
{'0'};
> > > > > > > > > > >                 char process_cape_version[5] =3D {'0'=
};
> > > > > > > > > > > -               struct extension *cape;
> > > > > > > > > > > +               struct extension cape =3D {0}, *_cape;
> > > > > > > > > > >                 struct udevice *dev;
> > > > > > > > > > >                 u8 cursor =3D 0;
> > > > > > > > > > >                 int ret, i;
> > > > > > > > > > > @@ -78,22 +78,20 @@ int extension_board_scan(struct
> > > > > > > > > > > list_head *extension_list) =20
> > > > > > > > > >
> > > > > > > > > > I suppose that a method called scan() could be added to=
 the
> > > > > > > > > > uclass and implemented by this driver. =20
> > > > > >
> > > > > > I don't understand what do you mean by method? Is it different =
to
> > > > > > the UBOOT driver scan ops I have designed?
> > > > > > =20
> > > > > > > > > > >                 printf("BeagleBone Cape: %s (0x%x)\n",
> > > > > > > > > > > eeprom_header.board_name, addr);
> > > > > > > > > > >
> > > > > > > > > > > -               cape =3D calloc(1, sizeof(struct
> > > > > > > > > > > extension));
> > > > > > > > > > > -               if (!cape) {
> > > > > > > > > > > -                       printf("Error in memory
> > > > > > > > > > > allocation\n");
> > > > > > > > > > > -                       return num_capes;
> > > > > > > > > > > -               }
> > > > > > > > > > > -
> > > > > > > > > > > -               snprintf(cape->overlay,
> > > > > > > > > > > sizeof(cape->overlay), "%s-%s.dtbo",
> > > > > > > > > > > +               snprintf(cape.overlay,
> > > > > > > > > > > sizeof(cape.overlay), "%s-%s.dtbo",
> > > > > > > > > > > process_cape_part_number, process_cape_version);
> > > > > > > > > > > -               strlcpy(cape->name,
> > > > > > > > > > > eeprom_header.board_name,
> > > > > > > > > > > +               strlcpy(cape.name,
> > > > > > > > > > > eeprom_header.board_name,
> > > > > > > > > > > sizeof(eeprom_header.board_name));
> > > > > > > > > > > -               strlcpy(cape->version,
> > > > > > > > > > > process_cape_version,
> > > > > > > > > > > +               strlcpy(cape.version,
> > > > > > > > > > > process_cape_version, sizeof(process_cape_version));
> > > > > > > > > > > -               strlcpy(cape->owner,
> > > > > > > > > > > eeprom_header.manufacturer,
> > > > > > > > > > > +               strlcpy(cape.owner,
> > > > > > > > > > > eeprom_header.manufacturer,
> > > > > > > > > > > sizeof(eeprom_header.manufacturer) + 1);
> > > > > > > > > > > -               list_add_tail(&cape->list,
> > > > > > > > > > > extension_list);
> > > > > > > > > > > +               _cape =3D alist_add(extension_list, c=
ape);
> > > > > > > > > > > +               if (!_cape)
> > > > > > > > > > > +                       return -ENOMEM;
> > > > > > > > > > >                 num_capes++;
> > > > > > > > > > >         }
> > > > > > > > > > >         return num_capes;
> > > > > > > > > > >  }
> > > > > > > > > > > +
> > > > > > > > > > > +U_BOOT_EXTENSION(cape, ti_extension_board_scan); =20
> > > > > > > > > >
> > > > > > > > > > Can the extension information go in the devicetree, so
> > > > > > > > > > boards can select their scheme that way? =20
> > > > > > > > >
> > > > > > > > > Since we're scanning to see what extension boards are pre=
sent
> > > > > > > > > and so what device tree overlays to apply, I don't think =
that
> > > > > > > > > can work? =20
> > > > > > > >
> > > > > > > > My understanding is that the scanning process is
> > > > > > > > board-specific. For example we would not want the Beagle
> > > > > > > > mechanism to be compiled into rpi. The idea of scanning thi=
ngs
> > > > > > > > in a board-specific way seems like a driver to me. Note the=
re
> > > > > > > > is also the SYSINFO uclass which can do similar things.
> > > > > > > >
> > > > > > > > The overlays being applied here are additions to what should
> > > > > > > > already be a fairly complete devicetree.
> > > > > > > >
> > > > > > > > If this isn't possible, then where is the information known=
? =20
> > > > > >
> > > > > > Oh, so you would prefer to have something like the sysinfo driv=
ers.
> > > > > > =20
> > > > > > > You're commenting on a patch to the TI specific code, that's =
only
> > > > > > > used by TI SoC using platforms that opt-in to the externally
> > > > > > > defined EEPROM format for these "capes". Perhaps your feedback
> > > > > > > would make more sense in some other part of the patch series?=
 But
> > > > > > > even then, I'm not sure it makes sense? =20
> > > > > >
> > > > > > I am ok to move the cape scan detection code to a standalone dr=
iver
> > > > > > with a devicetree compatible match. Just wondering what are the
> > > > > > advantages to use standalone drivers instead of having the code=
 in
> > > > > > the specific board code as done in this series. =20
> > > > >
> > > > > I'm not sure there is an advantage. Especially since in theory we
> > > > > could have more than one built in, and if
> > > > > ti_extension_board_scan(...) doesn't find anything (because the
> > > > > EEPROM is missing/wrong) we could still then call
> > > > > rpi_extension_board_scan(...) and look for that formatted type of
> > > > > EEPROM and then chipanddip_extension_board_scan(...) and look for
> > > > > that and so forth. These extensions are nominally discoverable an=
d so
> > > > > don't need device tree compatibles, was some of the point of all =
this
> > > > > I would have sworn... =20
> > > >
> > > > I think, he means a driver for each type of custom extension board =
scan
> > > > functions (4 until now). The U-boot devicetree would be like this:
> > > > extension_scan {
> > > >       compatible =3D "bone-cape-scan";
> > > > };
> > > >
> > > > We could avoid the build of several extension drivers using Kconfig
> > > > choice symbol to select only one builtin.
> > > >
> > > > On my side I don't really have opinions, it is a matter of code des=
ign.
> > > > For now I don't see real argument to tilt the balance except to do
> > > > something like sysinfo. We need more arguments from Simon. =20
> > >
> > > Yes, and needing to go back to modifying the device trees seems a step
> > > backwards here, and something that will be hard to argue for upstream=
. =20
> >=20
> > How do you define the mechanism to read the cape (etc.) information? =20
>=20
> Well, a cape for the TI platforms has to have a properly formatted
> EEPROM. I forget how the CHIP/DIP thing worked, but I believe it was
> similar (since it originated in the same era). I also believe Pi is
> similar as well.

The DIP is detected reading the EEPROMs through the W1 bus.
On the imx8mm-cl-iot-gate it is more complicated, it is done on probing
devices on specific I2C addresses and reading GPIOs.

> > Presumably it is using a device which is already in the devicetree? So
> > it is the actual extension mechanism that is not present, perhaps?
> >=20
> > How does Linux model extensions? =20
>=20
> Last I knew it doesn't and much discussion was had to arrive at that
> point a decade or so ago. I believe FPGA stuff has been allowed since
> then, but physical extensions not, and it's a bootloader problem. Which
> is why we've been solving it for a while (it was more ad-hoc before Kory
> did the current implementation in 2021).

Yes, Linux does not support loading external devicetree overlay, even in FP=
GA
subsystem. Even if the core of loading overlay is present for long ago, the=
 only
real driver support has been done recently in PCI by Herv=C3=A9 for two PCI
drivers:
https://elixir.bootlin.com/linux/v6.17.1/source/drivers/misc/lan966x_pci.c
https://elixir.bootlin.com/linux/v6.17.1/source/drivers/misc/rp1/rp1_pci.c

Here the devicetree overlays are builtin in the drivers, the aim was to be =
able
to load the overlay from x86 boards.

There is also a Linux discussion (with Herv=C3=A9 and Luca) on the generic =
way to
represent a connector in the devicetree, talking about a way to export
devicetree symbols.
After some thought, I don't think we should add something in the devicetree
now, and wait for the final connector representation when it will land.
Meanwhile we should stick to using board specific code.

It it's ok for you I will send v2 keeping this design.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
