Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130ABCCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 16:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70ECD83A02;
	Tue,  7 Oct 2025 18:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oN7Gh9kj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0DDB83A57; Tue,  7 Oct 2025 18:42:13 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93170839FB
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 18:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7af40016ab3so4666888a34.2
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 09:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759855330; x=1760460130; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FDPYRrJaZde/N1r3TJk01fLf9XXFBAQjaA5n5MyzRfY=;
 b=oN7Gh9kj2YfCoAU2RNjTXLol3KnymYpcGFtLT+7D1i4b9jwZRWTJ2qs6oSV8+NPZGe
 FXZSswi6XNA74aRjDtAB11OHR/xpHQ6rJ67I211+PCbgN40u81317lB2XWq23T1pmUWy
 WH0mP5nbPNl+ZO7/dM1TDgDx2yZzxprx+ji/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759855330; x=1760460130;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDPYRrJaZde/N1r3TJk01fLf9XXFBAQjaA5n5MyzRfY=;
 b=wYPAO/2hmvZoQzr3WhyrWwz3qAKk8k0gyPUn+afB0PbxBf9wzyb/YwZYIQqrRYroX+
 fe5zjJCnp2uFd+c8Adn3EJmzp9bNQ5ZIDezFKrBKtwTmiuBp2cSxvab2WtLffButAJEF
 xwr5YtGKJlIl1s1xxqXfK40/sJ7AmVZVB4gxvNSHfJozZSsPUkfvKEdwRMzKFNDF1vpm
 /MapIwx2c05ik/hec/tqegR0VJwif3M2e3T/+z5P7hanGlMjZIQPopECGyq9YbWMvjl2
 S8cTQzbK8YXwYPOt2mxn38FXZITfZhzMlkfi1TAfvG79uoerOdB03s2s249rasJAOntD
 E8LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyPTrBeJdt+zW60PKqOZOQJq9rsWqm37tOhEI5GEOhImD0v93D+cXuZPAwBLXd2MyeqYykLL4=@lists.denx.de
X-Gm-Message-State: AOJu0YzZ5koF69S5V4R50rfLgBC99C1eR5XixNNUXSbpQuTWLJR7IQQU
 8RFMsCzF1rh/rCyJVtnACHqETtzgpEKI4RzSlkYSXipdHnFy9PzvSvhgKucuopgyAHs=
X-Gm-Gg: ASbGnctb9e50W5Ef3i33InCgktAHYQfo2w8QZmYu1pzs5K0m7YX3HPTrgYt1QO4K5/h
 ks4nM3s1aFjDB/jyYCpBEWnGnz+5DW8wJVEr47EXVWDfnw+t8c0vR1KYewelEMGu93ZUJOCWrpT
 qIFjzB97CdPfPmJIv1oKQiM/YMYHGB9AEl6S6qVxSWZgcnk+dTPUfSDogrQ7wa4/hRXeQgT51F4
 lP+z/6JYE8tljpUFOETVAJNHDgsZHV/dD4dFDAzujXSJi6d9ri2fALCasjZoCYpQYd0unDZq4Xa
 /j+mn/imwcGo+71bU0dJbYVDcQzMa6JbC4pFW3AJ4UhpBnG1VRpptQydnTMC1Zvq9gRP/kBsERs
 OryYrac/ahxPVcDff3xW7NSlLlFEJTjRfP5jMWx/lVU+qXtRwv6tn9ZJqlTgHTG1tKzBXWao8IH
 Tbv0/aAiGR8Q==
X-Google-Smtp-Source: AGHT+IFQ8g4/RU4AvL08pEuNY4Ko8Mtn8lxqX9+X2jvlp5wplbFXdF5mlj8NPzxbbSt1jeVe0OxlHA==
X-Received: by 2002:a05:6830:3901:b0:761:388b:ecfc with SMTP id
 46e09a7af769-7c0df7b1947mr210745a34.25.1759855330245; 
 Tue, 07 Oct 2025 09:42:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64e29b50c7asm3266637eaf.2.2025.10.07.09.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 09:42:09 -0700 (PDT)
Date: Tue, 7 Oct 2025 10:42:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 06/16] board: ti: Convert cape detection to use UCLASS
 framework
Message-ID: <20251007164207.GL298503@bill-the-cat>
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
 <20251003-feature_sysboot_extension_board-v1-6-458b8bf85325@bootlin.com>
 <CAFLszTj3j6bcm6PG1GLAHa6FfjpKOKL12P_ae4WZsJL4hbh-HA@mail.gmail.com>
 <20251006214428.GD298503@bill-the-cat>
 <CAFLszTgLd7gHoU04QKAgHWNFQz_CS_XfeJCBkn58fu3UxUyurQ@mail.gmail.com>
 <20251006234240.GF298503@bill-the-cat>
 <20251007113213.75efa663@kmaincent-XPS-13-7390>
 <20251007141148.GJ298503@bill-the-cat>
 <20251007182938.368bf435@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="us+I5cS/xIvSYl3a"
Content-Disposition: inline
In-Reply-To: <20251007182938.368bf435@kmaincent-XPS-13-7390>
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


--us+I5cS/xIvSYl3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 06:29:38PM +0200, Kory Maincent wrote:
> On Tue, 7 Oct 2025 08:11:48 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Tue, Oct 07, 2025 at 11:32:13AM +0200, Kory Maincent wrote:
> > > On Mon, 6 Oct 2025 17:42:40 -0600
> > > Tom Rini <trini@konsulko.com> wrote:
> > >  =20
> > > > On Mon, Oct 06, 2025 at 05:30:15PM -0600, Simon Glass wrote: =20
> > > > > Hi Tom,
> > > > >=20
> > > > > On Mon, 6 Oct 2025 at 15:44, Tom Rini <trini@konsulko.com> wrote:=
   =20
> > > > > >
> > > > > > On Mon, Oct 06, 2025 at 02:38:23PM -0600, Simon Glass wrote:   =
=20
> > > > > > > Hi Kory,
> > > > > > >
> > > > > > > On Fri, 3 Oct 2025 at 10:34, Kory Maincent
> > > > > > > <kory.maincent@bootlin.com> wrote:   =20
> > > > > > > >
> > > > > > > > Migrate TI board cape detection from legacy extension suppo=
rt to
> > > > > > > > the new UCLASS-based extension board framework.
> > > > > > > >
> > > > > > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =
=20
> > >=20
> > > ...
> > >  =20
> > > > > > > > -int extension_board_scan(struct list_head *extension_list)
> > > > > > > > +static int ti_extension_board_scan(struct alist *extension=
_list)
> > > > > > > >  {
> > > > > > > >         unsigned char addr;
> > > > > > > >         int num_capes =3D 0;
> > > > > > > > @@ -31,7 +31,7 @@ int extension_board_scan(struct list_head
> > > > > > > > *extension_list) struct am335x_cape_eeprom_id eeprom_header;
> > > > > > > >                 char process_cape_part_number[17] =3D {'0'};
> > > > > > > >                 char process_cape_version[5] =3D {'0'};
> > > > > > > > -               struct extension *cape;
> > > > > > > > +               struct extension cape =3D {0}, *_cape;
> > > > > > > >                 struct udevice *dev;
> > > > > > > >                 u8 cursor =3D 0;
> > > > > > > >                 int ret, i;
> > > > > > > > @@ -78,22 +78,20 @@ int extension_board_scan(struct list_he=
ad
> > > > > > > > *extension_list)   =20
> > > > > > >
> > > > > > > I suppose that a method called scan() could be added to the u=
class
> > > > > > > and implemented by this driver. =20
> > >=20
> > > I don't understand what do you mean by method? Is it different to the
> > > UBOOT driver scan ops I have designed?=20
> > >  =20
> > > > > > > >                 printf("BeagleBone Cape: %s (0x%x)\n",
> > > > > > > > eeprom_header.board_name, addr);
> > > > > > > >
> > > > > > > > -               cape =3D calloc(1, sizeof(struct extension)=
);
> > > > > > > > -               if (!cape) {
> > > > > > > > -                       printf("Error in memory allocation\=
n");
> > > > > > > > -                       return num_capes;
> > > > > > > > -               }
> > > > > > > > -
> > > > > > > > -               snprintf(cape->overlay, sizeof(cape->overla=
y),
> > > > > > > > "%s-%s.dtbo",
> > > > > > > > +               snprintf(cape.overlay, sizeof(cape.overlay),
> > > > > > > > "%s-%s.dtbo", process_cape_part_number, process_cape_versio=
n);
> > > > > > > > -               strlcpy(cape->name, eeprom_header.board_nam=
e,
> > > > > > > > +               strlcpy(cape.name, eeprom_header.board_name,
> > > > > > > >                         sizeof(eeprom_header.board_name));
> > > > > > > > -               strlcpy(cape->version, process_cape_version,
> > > > > > > > +               strlcpy(cape.version, process_cape_version,
> > > > > > > >                         sizeof(process_cape_version));
> > > > > > > > -               strlcpy(cape->owner, eeprom_header.manufact=
urer,
> > > > > > > > +               strlcpy(cape.owner, eeprom_header.manufactu=
rer,
> > > > > > > >                         sizeof(eeprom_header.manufacturer) =
+ 1);
> > > > > > > > -               list_add_tail(&cape->list, extension_list);
> > > > > > > > +               _cape =3D alist_add(extension_list, cape);
> > > > > > > > +               if (!_cape)
> > > > > > > > +                       return -ENOMEM;
> > > > > > > >                 num_capes++;
> > > > > > > >         }
> > > > > > > >         return num_capes;
> > > > > > > >  }
> > > > > > > > +
> > > > > > > > +U_BOOT_EXTENSION(cape, ti_extension_board_scan);   =20
> > > > > > >
> > > > > > > Can the extension information go in the devicetree, so boards=
 can
> > > > > > > select their scheme that way?   =20
> > > > > >
> > > > > > Since we're scanning to see what extension boards are present a=
nd so
> > > > > > what device tree overlays to apply, I don't think that can work=
?   =20
> > > > >=20
> > > > > My understanding is that the scanning process is board-specific. =
For
> > > > > example we would not want the Beagle mechanism to be compiled into
> > > > > rpi. The idea of scanning things in a board-specific way seems li=
ke a
> > > > > driver to me. Note there is also the SYSINFO uclass which can do
> > > > > similar things.
> > > > >
> > > > > The overlays being applied here are additions to what should alre=
ady
> > > > > be a fairly complete devicetree.
> > > > >=20
> > > > > If this isn't possible, then where is the information known? =20
> > >=20
> > > Oh, so you would prefer to have something like the sysinfo drivers.
> > >   =20
> > > > You're commenting on a patch to the TI specific code, that's only u=
sed
> > > > by TI SoC using platforms that opt-in to the externally defined EEP=
ROM
> > > > format for these "capes". Perhaps your feedback would make more sen=
se in
> > > > some other part of the patch series? But even then, I'm not sure it
> > > > makes sense? =20
> > >=20
> > > I am ok to move the cape scan detection code to a standalone driver w=
ith a
> > > devicetree compatible match. Just wondering what are the advantages t=
o use
> > > standalone drivers instead of having the code in the specific board c=
ode as
> > > done in this series. =20
> >=20
> > I'm not sure there is an advantage. Especially since in theory we could
> > have more than one built in, and if ti_extension_board_scan(...) doesn't
> > find anything (because the EEPROM is missing/wrong) we could still then
> > call rpi_extension_board_scan(...) and look for that formatted type of
> > EEPROM and then chipanddip_extension_board_scan(...) and look for that
> > and so forth. These extensions are nominally discoverable and so don't
> > need device tree compatibles, was some of the point of all this I would
> > have sworn...
>=20
> I think, he means a driver for each type of custom extension board scan
> functions (4 until now). The U-boot devicetree would be like this:
> extension_scan {
> 	compatible =3D "bone-cape-scan";=20
> };
>=20
> We could avoid the build of several extension drivers using Kconfig choice
> symbol to select only one builtin.
>=20
> On my side I don't really have opinions, it is a matter of code design. F=
or now
> I don't see real argument to tilt the balance except to do something like
> sysinfo. We need more arguments from Simon.

Yes, and needing to go back to modifying the device trees seems a step
backwards here, and something that will be hard to argue for upstream.

--=20
Tom

--us+I5cS/xIvSYl3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOVC2wAKCRAr4qD1Cr/k
ChigAP9mYIupPRuJdAOuoODO8epT+3Hq90zQZ3ImcloHf7NAAgD/Vbc7GWUYNv8J
pV1ZFMloQNWJa+JFuU/nBuf07CE09Ag=
=uxoA
-----END PGP SIGNATURE-----

--us+I5cS/xIvSYl3a--
