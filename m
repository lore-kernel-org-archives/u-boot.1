Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC2BCCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 14:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 693D683D9F;
	Tue,  7 Oct 2025 16:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g/TAdNvb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 592F483F3D; Tue,  7 Oct 2025 16:11:55 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11CEC83D92
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 16:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-30cce50dfb4so3420665fac.0
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759846312; x=1760451112; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EVNTJIkHtprlyG3h5x705GsTkoqSnM/K9OLxsYI1Ez0=;
 b=g/TAdNvbWAn6vtm5neDKqBxlZEfiAdnwkf1cER23u+3NvWOCyLN38elMuNCpP35782
 YJ7N2xCy+HBdOT5aaOQQISxadxpSTIFwPVA9Gi97TtmGeZbvAxNwfY/qX9TpSkSgiIGe
 ixJfHcxkyWA4rHB2eLYeMXEWG/l206aB0xtz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846312; x=1760451112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVNTJIkHtprlyG3h5x705GsTkoqSnM/K9OLxsYI1Ez0=;
 b=HmGu0wu/mB71owYBcgH9hK72p3/TaZNJGqnMoU6SCX6bXwYhY4i3e5vq3qADoPz4q1
 xQu+RA5GZSdw6VbdhEfdTjcUM2w25G3aKZQQvv5+/6BuvQ3d4diaa4U/O389qkZmVv/5
 ZepXQcaduXxvgYOLl/7BXsIUZq0aQXxBPv7JshD3BwRaIkfEAoky3a43AwA37s2FRsCO
 FOea+74+PDXZsfTlyz4D2Ns2IzQjMn3UT/irDIVAP72A/kruYs0bGQ6PHPsmi83f2rjt
 210eOxyj0+RAof4RG6KcE6WwbSm3lfUvOBPjnTIzG9IzP+CUCO3dtnsbAU+bGqb/EAhr
 iLTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3xqDVym57roiJUh9D51Rnuyaav0MHmSv9AAJPlcqtBdhB649Oj3KnGhQSEovzohWpeO5GkQk=@lists.denx.de
X-Gm-Message-State: AOJu0YzmnPnb+mOHqAb7aGBD+9D+YqUCFLZtWdj4k+PVnwDBu77yTUQS
 yfmcrimvDU7m10iKlrgIKoy3L7EOPQh74H7lkYJ8rc+zC2VC2304lkbN4Zn3YyFFpWA=
X-Gm-Gg: ASbGnct1nw0pYBmjENs1qSAktm7r6lrC33lMbvpGKgQEF5VYXWSjv+ASsM46c0gNxSK
 tA+j0npgj6XE6vrsyCHgU+rHoSiGGsYDDufTAAHHp3zW077bAiZEmu5533Q39hVqyixx4a0jpEI
 aoUtEcI9Qj/Go4DWT3D2tCNKguIpTq9thLbaxBnACouIPoo2e9tZl14lainlZNJqxhbAdB/m8N3
 9/844DrOSVl1QPfNs2chYMgf7evoOX5ZG+CRO9JOwDXLwjRxHIL+v90hxgYhQzX9uTHDmYwUh7Z
 p2r38qtUALgJf0BZLkS/v3HTudi5z9UrH3wsACR3QM3eXYDTVAgktOJyG/qErxeGlqiUY07JpE1
 Eh9M1Lo/r0v9x1ylxP2wCb7ekqH1O7wdibdIzROZ0OLGOC88BiUya/ZOwBf5ZIIlBWh9WVaWUzc
 09FGoj+t0J+Q==
X-Google-Smtp-Source: AGHT+IFGU3wff2NPnBfX3trLTts5G2S4/NjZ2HtlP2wS5rwHv/lcOyGG/ivH3kaWN4uvW0Gd5Ko5SQ==
X-Received: by 2002:a05:6870:c1c6:b0:36e:f8c2:7454 with SMTP id
 586e51a60fabf-3b0f9e62a6cmr9072581fac.37.1759846311571; 
 Tue, 07 Oct 2025 07:11:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab8e2ec231sm4893800fac.14.2025.10.07.07.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:50 -0700 (PDT)
Date: Tue, 7 Oct 2025 08:11:48 -0600
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
Message-ID: <20251007141148.GJ298503@bill-the-cat>
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
 <20251003-feature_sysboot_extension_board-v1-6-458b8bf85325@bootlin.com>
 <CAFLszTj3j6bcm6PG1GLAHa6FfjpKOKL12P_ae4WZsJL4hbh-HA@mail.gmail.com>
 <20251006214428.GD298503@bill-the-cat>
 <CAFLszTgLd7gHoU04QKAgHWNFQz_CS_XfeJCBkn58fu3UxUyurQ@mail.gmail.com>
 <20251006234240.GF298503@bill-the-cat>
 <20251007113213.75efa663@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DFTzScHdZjBeYbHU"
Content-Disposition: inline
In-Reply-To: <20251007113213.75efa663@kmaincent-XPS-13-7390>
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


--DFTzScHdZjBeYbHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 11:32:13AM +0200, Kory Maincent wrote:
> On Mon, 6 Oct 2025 17:42:40 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Mon, Oct 06, 2025 at 05:30:15PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >=20
> > > On Mon, 6 Oct 2025 at 15:44, Tom Rini <trini@konsulko.com> wrote: =20
> > > >
> > > > On Mon, Oct 06, 2025 at 02:38:23PM -0600, Simon Glass wrote: =20
> > > > > Hi Kory,
> > > > >
> > > > > On Fri, 3 Oct 2025 at 10:34, Kory Maincent <kory.maincent@bootlin=
=2Ecom>
> > > > > wrote: =20
> > > > > >
> > > > > > Migrate TI board cape detection from legacy extension support t=
o the
> > > > > > new UCLASS-based extension board framework.
> > > > > >
> > > > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
>=20
> ...
>=20
> > > > > > -int extension_board_scan(struct list_head *extension_list)
> > > > > > +static int ti_extension_board_scan(struct alist *extension_lis=
t)
> > > > > >  {
> > > > > >         unsigned char addr;
> > > > > >         int num_capes =3D 0;
> > > > > > @@ -31,7 +31,7 @@ int extension_board_scan(struct list_head
> > > > > > *extension_list) struct am335x_cape_eeprom_id eeprom_header;
> > > > > >                 char process_cape_part_number[17] =3D {'0'};
> > > > > >                 char process_cape_version[5] =3D {'0'};
> > > > > > -               struct extension *cape;
> > > > > > +               struct extension cape =3D {0}, *_cape;
> > > > > >                 struct udevice *dev;
> > > > > >                 u8 cursor =3D 0;
> > > > > >                 int ret, i;
> > > > > > @@ -78,22 +78,20 @@ int extension_board_scan(struct list_head
> > > > > > *extension_list) =20
> > > > >
> > > > > I suppose that a method called scan() could be added to the uclas=
s and
> > > > > implemented by this driver.
>=20
> I don't understand what do you mean by method? Is it different to the
> UBOOT driver scan ops I have designed?=20
>=20
> > > > > >                 printf("BeagleBone Cape: %s (0x%x)\n",
> > > > > > eeprom_header.board_name, addr);
> > > > > >
> > > > > > -               cape =3D calloc(1, sizeof(struct extension));
> > > > > > -               if (!cape) {
> > > > > > -                       printf("Error in memory allocation\n");
> > > > > > -                       return num_capes;
> > > > > > -               }
> > > > > > -
> > > > > > -               snprintf(cape->overlay, sizeof(cape->overlay),
> > > > > > "%s-%s.dtbo",
> > > > > > +               snprintf(cape.overlay, sizeof(cape.overlay),
> > > > > > "%s-%s.dtbo", process_cape_part_number, process_cape_version);
> > > > > > -               strlcpy(cape->name, eeprom_header.board_name,
> > > > > > +               strlcpy(cape.name, eeprom_header.board_name,
> > > > > >                         sizeof(eeprom_header.board_name));
> > > > > > -               strlcpy(cape->version, process_cape_version,
> > > > > > +               strlcpy(cape.version, process_cape_version,
> > > > > >                         sizeof(process_cape_version));
> > > > > > -               strlcpy(cape->owner, eeprom_header.manufacturer,
> > > > > > +               strlcpy(cape.owner, eeprom_header.manufacturer,
> > > > > >                         sizeof(eeprom_header.manufacturer) + 1);
> > > > > > -               list_add_tail(&cape->list, extension_list);
> > > > > > +               _cape =3D alist_add(extension_list, cape);
> > > > > > +               if (!_cape)
> > > > > > +                       return -ENOMEM;
> > > > > >                 num_capes++;
> > > > > >         }
> > > > > >         return num_capes;
> > > > > >  }
> > > > > > +
> > > > > > +U_BOOT_EXTENSION(cape, ti_extension_board_scan); =20
> > > > >
> > > > > Can the extension information go in the devicetree, so boards can
> > > > > select their scheme that way? =20
> > > >
> > > > Since we're scanning to see what extension boards are present and so
> > > > what device tree overlays to apply, I don't think that can work? =
=20
> > >=20
> > > My understanding is that the scanning process is board-specific. For
> > > example we would not want the Beagle mechanism to be compiled into
> > > rpi. The idea of scanning things in a board-specific way seems like a
> > > driver to me. Note there is also the SYSINFO uclass which can do
> > > similar things.
> > >
> > > The overlays being applied here are additions to what should already
> > > be a fairly complete devicetree.
> > >=20
> > > If this isn't possible, then where is the information known?
>=20
> Oh, so you would prefer to have something like the sysinfo drivers.
> =20
> > You're commenting on a patch to the TI specific code, that's only used
> > by TI SoC using platforms that opt-in to the externally defined EEPROM
> > format for these "capes". Perhaps your feedback would make more sense in
> > some other part of the patch series? But even then, I'm not sure it
> > makes sense?
>=20
> I am ok to move the cape scan detection code to a standalone driver with a
> devicetree compatible match. Just wondering what are the advantages to use
> standalone drivers instead of having the code in the specific board code =
as
> done in this series.

I'm not sure there is an advantage. Especially since in theory we could
have more than one built in, and if ti_extension_board_scan(...) doesn't
find anything (because the EEPROM is missing/wrong) we could still then
call rpi_extension_board_scan(...) and look for that formatted type of
EEPROM and then chipanddip_extension_board_scan(...) and look for that
and so forth. These extensions are nominally discoverable and so don't
need device tree compatibles, was some of the point of all this I would
have sworn...

--=20
Tom

--DFTzScHdZjBeYbHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOUfoAAKCRAr4qD1Cr/k
Ck9iAP0VpUVKzwaSLzYVwMNmshHaxMwaOCVPKx+TDzvq7koa5AD+M2sdvSmsc70X
RcOtdfr3mFdzliTmzWwSvZS9kYhLlgQ=
=RrX+
-----END PGP SIGNATURE-----

--DFTzScHdZjBeYbHU--
