Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA18CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 14:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3310839DD;
	Wed,  8 Oct 2025 16:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IT8oBTF4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC8F83C91; Wed,  8 Oct 2025 16:09:13 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABACF839B7
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 16:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-79f79e37c04so5121591a34.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 07:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759932549; x=1760537349; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yq9ePIsus4bzVBmcQchHVU9xDhEOZ2Jzks5ha9Rf7pQ=;
 b=IT8oBTF4T5Vp7gAC6XG+qDWxNPHgbYYlV1sKcuIRQG6zC2gCB+CytRxeM++iCj++TC
 RhOQQAFf0DNXtIRFynrIeaIV8gaUHpGh5NraBkEx1HOcIkHLg+GNVRpj0KQKDB2QHkgl
 14zXjVUzvqgctZ7Cq51vB8N9nG6VbY3cGqL58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759932549; x=1760537349;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yq9ePIsus4bzVBmcQchHVU9xDhEOZ2Jzks5ha9Rf7pQ=;
 b=F/fjD3TEDbLF/gkqN6XaSRVSJeASvzM6AhupHicPsCMnPZCTdKTkxZOnYveXdC+eFE
 glZ97YE00gLS+Nr9Vje9WYBujeJ8hruty9QB16nXtI+s5u7VkQBNZkiNeJajZERMWICa
 AGXr4YOOC856L/NYivuxEKQLTfhdhO/KSCegLt88zpQXYE7AvEMjBaBgNsT4gQuEpyZa
 1IIWV82aerAh8bBG0H5J9qplgp6vXjU0TifzUA/JeOnz9FdHl0g30LV4SAYPBNzb/q81
 OQbehknjGMZNS/Jydo7GdRgjYmySdEZH1xY/1rb6oD0Tg4LHSygDdNCIFHRumT/qWVL5
 EISg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMePZIlndufyOA/IXGLQZD/Q6jEphTAHXfwRClcX9/N70iWE2LKyeumdmDmr/nw9+1go8pKNY=@lists.denx.de
X-Gm-Message-State: AOJu0YyJRAl4dugiMKNthUYl9Zk6eZL1OCY8uv5Bu0xLTFbrTYamPscv
 oQ6gIgChgkhdx1uTpwN8T/3962upBUU4xxawd2rMBK1cVR3E8OETTZNblLAdmsA3nA8=
X-Gm-Gg: ASbGncvgId9psB0o4cPB6TfdYvvF+TrN0Ob0sTtt9ROhV4C0huDeK7KrU0EZPPlqUyA
 /2ij4XowMvilVxwYOwuwiTo25fCQWtcQx1EDXifWkt4h51fkAOZlaXtIXlLvTDANbXQ0Gqvkccr
 vm+6yNSuOe9YGqiORRbKaD/UbOfqomRSofV7oBLmzvQRDQOh53llmLwRwZOVO3RUjdKzUrxKQPU
 X5w5lPNWKWSmMK0rbzxi9uGG7f6YqMeOTmpt+BwrSOycKVmBFduvwlhtAruqDEabqwm2dj0fK5O
 ztlTykm9Z6yx0DVSdUliZjaoFGLjUuihxJ/yqCcylVoVCmhamIR050cbo+PebYsym24Q0YPgIme
 wc/0mDmAMQ8j9b7u4UciZswdEU2BWhRJfkGf4phgpQEEx3bW2PDB4cqIQBuBvIxjOXblv5UV/uW
 GCT0gIswtTLg==
X-Google-Smtp-Source: AGHT+IHDUQgyzEU7KvdXnd5vnafWVVw1aD1ytHsxnRbV6/H2q9yepEm/wFowgIcMyKq8uRo8Nig8Hg==
X-Received: by 2002:a05:6830:82d1:b0:74b:3422:f33d with SMTP id
 46e09a7af769-7c0df5ca9a0mr2665168a34.0.1759932549126; 
 Wed, 08 Oct 2025 07:09:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf435ed63csm5790605a34.32.2025.10.08.07.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 07:09:07 -0700 (PDT)
Date: Wed, 8 Oct 2025 08:09:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Kory Maincent <kory.maincent@bootlin.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 06/16] board: ti: Convert cape detection to use UCLASS
 framework
Message-ID: <20251008140905.GS298503@bill-the-cat>
References: <20251006214428.GD298503@bill-the-cat>
 <CAFLszTgLd7gHoU04QKAgHWNFQz_CS_XfeJCBkn58fu3UxUyurQ@mail.gmail.com>
 <20251006234240.GF298503@bill-the-cat>
 <20251007113213.75efa663@kmaincent-XPS-13-7390>
 <20251007141148.GJ298503@bill-the-cat>
 <20251007182938.368bf435@kmaincent-XPS-13-7390>
 <20251007164207.GL298503@bill-the-cat>
 <CAFLszThB=o9Wq1K4XP1K_Oj+6db2ZuzK8kLw7KyGqCVqDBX7Gg@mail.gmail.com>
 <20251007201336.GQ298503@bill-the-cat>
 <CAFLszTgX+BnH=wVjVb_5e0TifUP_At37Pz5500aPgsMb5bgRoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5QhyCWa7IzZM5F2g"
Content-Disposition: inline
In-Reply-To: <CAFLszTgX+BnH=wVjVb_5e0TifUP_At37Pz5500aPgsMb5bgRoA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--5QhyCWa7IzZM5F2g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 06:54:09AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 7 Oct 2025 at 14:13, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 07, 2025 at 02:02:53PM -0600, Simon Glass wrote:
> > > Hi,
> > >
> > > On Tue, 7 Oct 2025 at 10:42, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Oct 07, 2025 at 06:29:38PM +0200, Kory Maincent wrote:
> > > > > On Tue, 7 Oct 2025 08:11:48 -0600
> > > > > Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > > On Tue, Oct 07, 2025 at 11:32:13AM +0200, Kory Maincent wrote:
> > > > > > > On Mon, 6 Oct 2025 17:42:40 -0600
> > > > > > > Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > > On Mon, Oct 06, 2025 at 05:30:15PM -0600, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 6 Oct 2025 at 15:44, Tom Rini <trini@konsulko.com=
> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Oct 06, 2025 at 02:38:23PM -0600, Simon Glass w=
rote:
> > > > > > > > > > > Hi Kory,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 3 Oct 2025 at 10:34, Kory Maincent
> > > > > > > > > > > <kory.maincent@bootlin.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Migrate TI board cape detection from legacy extensi=
on support to
> > > > > > > > > > > > the new UCLASS-based extension board framework.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin=
=2Ecom>
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > > > > > > > -int extension_board_scan(struct list_head *extensi=
on_list)
> > > > > > > > > > > > +static int ti_extension_board_scan(struct alist *e=
xtension_list)
> > > > > > > > > > > >  {
> > > > > > > > > > > >         unsigned char addr;
> > > > > > > > > > > >         int num_capes =3D 0;
> > > > > > > > > > > > @@ -31,7 +31,7 @@ int extension_board_scan(struct l=
ist_head
> > > > > > > > > > > > *extension_list) struct am335x_cape_eeprom_id eepro=
m_header;
> > > > > > > > > > > >                 char process_cape_part_number[17] =
=3D {'0'};
> > > > > > > > > > > >                 char process_cape_version[5] =3D {'=
0'};
> > > > > > > > > > > > -               struct extension *cape;
> > > > > > > > > > > > +               struct extension cape =3D {0}, *_ca=
pe;
> > > > > > > > > > > >                 struct udevice *dev;
> > > > > > > > > > > >                 u8 cursor =3D 0;
> > > > > > > > > > > >                 int ret, i;
> > > > > > > > > > > > @@ -78,22 +78,20 @@ int extension_board_scan(struct=
 list_head
> > > > > > > > > > > > *extension_list)
> > > > > > > > > > >
> > > > > > > > > > > I suppose that a method called scan() could be added =
to the uclass
> > > > > > > > > > > and implemented by this driver.
> > > > > > >
> > > > > > > I don't understand what do you mean by method? Is it differen=
t to the
> > > > > > > UBOOT driver scan ops I have designed?
> > > > > > >
> > > > > > > > > > > >                 printf("BeagleBone Cape: %s (0x%x)\=
n",
> > > > > > > > > > > > eeprom_header.board_name, addr);
> > > > > > > > > > > >
> > > > > > > > > > > > -               cape =3D calloc(1, sizeof(struct ex=
tension));
> > > > > > > > > > > > -               if (!cape) {
> > > > > > > > > > > > -                       printf("Error in memory all=
ocation\n");
> > > > > > > > > > > > -                       return num_capes;
> > > > > > > > > > > > -               }
> > > > > > > > > > > > -
> > > > > > > > > > > > -               snprintf(cape->overlay, sizeof(cape=
->overlay),
> > > > > > > > > > > > "%s-%s.dtbo",
> > > > > > > > > > > > +               snprintf(cape.overlay, sizeof(cape.=
overlay),
> > > > > > > > > > > > "%s-%s.dtbo", process_cape_part_number, process_cap=
e_version);
> > > > > > > > > > > > -               strlcpy(cape->name, eeprom_header.b=
oard_name,
> > > > > > > > > > > > +               strlcpy(cape.name, eeprom_header.bo=
ard_name,
> > > > > > > > > > > >                         sizeof(eeprom_header.board_=
name));
> > > > > > > > > > > > -               strlcpy(cape->version, process_cape=
_version,
> > > > > > > > > > > > +               strlcpy(cape.version, process_cape_=
version,
> > > > > > > > > > > >                         sizeof(process_cape_version=
));
> > > > > > > > > > > > -               strlcpy(cape->owner, eeprom_header.=
manufacturer,
> > > > > > > > > > > > +               strlcpy(cape.owner, eeprom_header.m=
anufacturer,
> > > > > > > > > > > >                         sizeof(eeprom_header.manufa=
cturer) + 1);
> > > > > > > > > > > > -               list_add_tail(&cape->list, extensio=
n_list);
> > > > > > > > > > > > +               _cape =3D alist_add(extension_list,=
 cape);
> > > > > > > > > > > > +               if (!_cape)
> > > > > > > > > > > > +                       return -ENOMEM;
> > > > > > > > > > > >                 num_capes++;
> > > > > > > > > > > >         }
> > > > > > > > > > > >         return num_capes;
> > > > > > > > > > > >  }
> > > > > > > > > > > > +
> > > > > > > > > > > > +U_BOOT_EXTENSION(cape, ti_extension_board_scan);
> > > > > > > > > > >
> > > > > > > > > > > Can the extension information go in the devicetree, s=
o boards can
> > > > > > > > > > > select their scheme that way?
> > > > > > > > > >
> > > > > > > > > > Since we're scanning to see what extension boards are p=
resent and so
> > > > > > > > > > what device tree overlays to apply, I don't think that =
can work?
> > > > > > > > >
> > > > > > > > > My understanding is that the scanning process is board-sp=
ecific. For
> > > > > > > > > example we would not want the Beagle mechanism to be comp=
iled into
> > > > > > > > > rpi. The idea of scanning things in a board-specific way =
seems like a
> > > > > > > > > driver to me. Note there is also the SYSINFO uclass which=
 can do
> > > > > > > > > similar things.
> > > > > > > > >
> > > > > > > > > The overlays being applied here are additions to what sho=
uld already
> > > > > > > > > be a fairly complete devicetree.
> > > > > > > > >
> > > > > > > > > If this isn't possible, then where is the information kno=
wn?
> > > > > > >
> > > > > > > Oh, so you would prefer to have something like the sysinfo dr=
ivers.
> > > > > > >
> > > > > > > > You're commenting on a patch to the TI specific code, that'=
s only used
> > > > > > > > by TI SoC using platforms that opt-in to the externally def=
ined EEPROM
> > > > > > > > format for these "capes". Perhaps your feedback would make =
more sense in
> > > > > > > > some other part of the patch series? But even then, I'm not=
 sure it
> > > > > > > > makes sense?
> > > > > > >
> > > > > > > I am ok to move the cape scan detection code to a standalone =
driver with a
> > > > > > > devicetree compatible match. Just wondering what are the adva=
ntages to use
> > > > > > > standalone drivers instead of having the code in the specific=
 board code as
> > > > > > > done in this series.
> > > > > >
> > > > > > I'm not sure there is an advantage. Especially since in theory =
we could
> > > > > > have more than one built in, and if ti_extension_board_scan(...=
) doesn't
> > > > > > find anything (because the EEPROM is missing/wrong) we could st=
ill then
> > > > > > call rpi_extension_board_scan(...) and look for that formatted =
type of
> > > > > > EEPROM and then chipanddip_extension_board_scan(...) and look f=
or that
> > > > > > and so forth. These extensions are nominally discoverable and s=
o don't
> > > > > > need device tree compatibles, was some of the point of all this=
 I would
> > > > > > have sworn...
> > > > >
> > > > > I think, he means a driver for each type of custom extension boar=
d scan
> > > > > functions (4 until now). The U-boot devicetree would be like this:
> > > > > extension_scan {
> > > > >       compatible =3D "bone-cape-scan";
> > > > > };
> > > > >
> > > > > We could avoid the build of several extension drivers using Kconf=
ig choice
> > > > > symbol to select only one builtin.
> > > > >
> > > > > On my side I don't really have opinions, it is a matter of code d=
esign. For now
> > > > > I don't see real argument to tilt the balance except to do someth=
ing like
> > > > > sysinfo. We need more arguments from Simon.
> > > >
> > > > Yes, and needing to go back to modifying the device trees seems a s=
tep
> > > > backwards here, and something that will be hard to argue for upstre=
am.
> > >
> > > How do you define the mechanism to read the cape (etc.) information?
> >
> > Well, a cape for the TI platforms has to have a properly formatted
> > EEPROM. I forget how the CHIP/DIP thing worked, but I believe it was
> > similar (since it originated in the same era). I also believe Pi is
> > similar as well.
> >
> > > Presumably it is using a device which is already in the devicetree? So
> > > it is the actual extension mechanism that is not present, perhaps?
> > >
> > > How does Linux model extensions?
> >
> > Last I knew it doesn't and much discussion was had to arrive at that
> > point a decade or so ago. I believe FPGA stuff has been allowed since
> > then, but physical extensions not, and it's a bootloader problem. Which
> > is why we've been solving it for a while (it was more ad-hoc before Kory
> > did the current implementation in 2021).
>=20
> OK, well the compatible string above at least allows a driver to be
> selected and all the board-specific stuff can go in there. Perhaps re
> can just reuse the sysinfo uclass? Perhaps we could talk about this in
> a future call?

I don't think we need to introduce more complexity here and Kory should
just v2 the current design, given the comments he noted in the other
half of the thread. It seems like some future kernel version may support
this use case more clearly and then maybe there'll be some compatible
string upstream to key off of.

--=20
Tom

--5QhyCWa7IzZM5F2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOZwfQAKCRAr4qD1Cr/k
CgrvAP4hPcs7aRpcdBAFVt+IFrywUXKx2Lc7iRy5/ID5ozN7GgEAoTF+kWSE5l8J
Ma9mfQ1FDFUGESCyd8lofyYSTaeCVgc=
=wzLN
-----END PGP SIGNATURE-----

--5QhyCWa7IzZM5F2g--
