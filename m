Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B47FCCA470
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 21:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BDFE83B5B;
	Mon,  6 Oct 2025 23:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MXyQ025d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C08283B64; Mon,  6 Oct 2025 23:44:36 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB12983B43
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 23:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7a7b084ef77so3141587a34.2
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 14:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759787072; x=1760391872; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R9ZChLijaRxpErKHwOJipv//pNQqIiHvPYN/DUkdVAk=;
 b=MXyQ025dqZQePsAak1j9r6qfR/+CC7msMxCp+nGVhWnvslPr4TNB8mLV3Ktj8hgoKO
 ppsjQEW09v5LRQgfWzPeZ9GSxvuYr/ICQpXvPbbLDGKT8LFB+08aOPtwb2ObX44VpXxE
 DjMoWx+ZeifSdP/7O6dYkkojbeLQTDGIosxG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759787072; x=1760391872;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9ZChLijaRxpErKHwOJipv//pNQqIiHvPYN/DUkdVAk=;
 b=qh1lq2vMBRUgJdtgyVL1SBmgP3Wfu2vhHBZ3qL4iUHWZK8mQ3zHB627tJB+l4AmX7P
 2yVYvZ8akrZcZUM9t7tHKBoWl7M/6KG9GzSEa11IxjL7kwlWq8iENbn1N+lr+JqKu4d3
 e7vuks3+B0y+MxFX8vzoeXq2+XV7+Siw8tAE3lh3zEYJXMTlEUn8JbOJiUK6r55lLpW0
 y9s6/L6kKJI9Ba1W/BUOpMuGRxCWh4ZWCRtfCB1sBuJGJT4EwNLdQ0Pp+m6cZhreNHXL
 4Q8OTWFGk3TNwnEkKbH4+szT4voWSDkeKLwIEs9EgbEff1YqmDEMkAC9wfrvOFNSoR8r
 MDOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsHOdLYMrLkOMq8guYjUM54gu2k9WRvqmjo3oubN9807SMvwJdvm9Dv5wMaOR048YQEQAh8qs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5zB5FNRrnIaDD3d8Q6lSyDhDbMeMtLA1BabCj8hjN156GzMPk
 c1IpktOj8Tyrk/GndlEDtJOKFrF3KShkCw8EoyYrk1e20eVpa48NsD7jC2XazKSE2Ho=
X-Gm-Gg: ASbGncvcuFjmy5pnfY3yuBuM91rh6CIfhMKvbLeTibiMHzWDUAzJSxFJYlutdi+Jnep
 kGRJzMloJkWhjEVoIbc7cYliJY8os5cDwqyZq4eVcu4bscTCn4ATz52ovcL0Ev8bU7PBbX+QG8X
 B2s05cGcny0Pb217byJmC0jIhuEzCO9jb+BLG1TA2CUz1dTjnr+F1jawSJ+AEDh64UZN8OpsDj2
 27P2gUlGuTrelxnFr/9V1WzvLJx4kc7ImYDkJUYdgQCABl59BMTWK0W+0AlbJ4RByDy3bD7mGIM
 xcBAGrIg4va3u5xWLBSH58cjMcavxfyWkZrfFinUFt8Z/NNIDjDY7KMlBaGNH6n8/7MUPRBUuWL
 MpmgNylofMGCGJGod5QQxUl1H09GsWOuddlaLRBu436lzNYXis39UVSVzMK/GWKfdWoF65YjgSK
 HnQYVOgTF3VIfq09UsByRMbf8HgAG07qg=
X-Google-Smtp-Source: AGHT+IGUb21wVDtu+EQ8RSA/aykUUNM2lmZtxciiGjLdI8tC5WAvV0Rpz/5LgNFyISke2YP4bauhvA==
X-Received: by 2002:a05:6808:518e:b0:43f:1c66:bb94 with SMTP id
 5614622812f47-43fc18884f8mr4831717b6e.47.1759787072110; 
 Mon, 06 Oct 2025 14:44:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64e18dd997csm2791111eaf.8.2025.10.06.14.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 14:44:30 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:44:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 06/16] board: ti: Convert cape detection to use UCLASS
 framework
Message-ID: <20251006214428.GD298503@bill-the-cat>
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
 <20251003-feature_sysboot_extension_board-v1-6-458b8bf85325@bootlin.com>
 <CAFLszTj3j6bcm6PG1GLAHa6FfjpKOKL12P_ae4WZsJL4hbh-HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LlBB+nx6E1yEq5Og"
Content-Disposition: inline
In-Reply-To: <CAFLszTj3j6bcm6PG1GLAHa6FfjpKOKL12P_ae4WZsJL4hbh-HA@mail.gmail.com>
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


--LlBB+nx6E1yEq5Og
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 02:38:23PM -0600, Simon Glass wrote:
> Hi Kory,
>=20
> On Fri, 3 Oct 2025 at 10:34, Kory Maincent <kory.maincent@bootlin.com> wr=
ote:
> >
> > Migrate TI board cape detection from legacy extension support to the
> > new UCLASS-based extension board framework.
> >
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >  arch/arm/mach-omap2/am33xx/Kconfig |  2 +-
> >  arch/arm/mach-omap2/omap5/Kconfig  |  2 +-
> >  board/ti/common/cape_detect.c      | 24 +++++++++++-------------
> >  3 files changed, 13 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/am33xx/Kconfig b/arch/arm/mach-omap2/a=
m33xx/Kconfig
> > index dff4f1cf202..77f7938305b 100644
> > --- a/arch/arm/mach-omap2/am33xx/Kconfig
> > +++ b/arch/arm/mach-omap2/am33xx/Kconfig
> > @@ -15,7 +15,7 @@ config TARGET_AM335X_EVM
> >         select DM_GPIO
> >         select DM_SERIAL
> >         select TI_I2C_BOARD_DETECT
> > -       select SUPPORT_EXTENSION_SCAN
> > +       select SUPPORT_DM_EXTENSION_SCAN
> >         imply CMD_DM
> >         imply SPL_DM
> >         imply SPL_DM_SEQ_ALIAS
> > diff --git a/arch/arm/mach-omap2/omap5/Kconfig b/arch/arm/mach-omap2/om=
ap5/Kconfig
> > index 5394529658b..819490a8cf8 100644
> > --- a/arch/arm/mach-omap2/omap5/Kconfig
> > +++ b/arch/arm/mach-omap2/omap5/Kconfig
> > @@ -38,7 +38,7 @@ config TARGET_AM57XX_EVM
> >         select CMD_DDR3
> >         select DRA7XX
> >         select TI_I2C_BOARD_DETECT
> > -       select SUPPORT_EXTENSION_SCAN
> > +       select SUPPORT_DM_EXTENSION_SCAN
> >         imply DM_THERMAL
> >         imply SCSI
> >         imply SPL_THERMAL
> > diff --git a/board/ti/common/cape_detect.c b/board/ti/common/cape_detec=
t.c
> > index 7786bdda5d1..23c93964dc3 100644
> > --- a/board/ti/common/cape_detect.c
> > +++ b/board/ti/common/cape_detect.c
> > @@ -22,7 +22,7 @@ static void sanitize_field(char *text, size_t size)
> >         }
> >  }
> >
> > -int extension_board_scan(struct list_head *extension_list)
> > +static int ti_extension_board_scan(struct alist *extension_list)
> >  {
> >         unsigned char addr;
> >         int num_capes =3D 0;
> > @@ -31,7 +31,7 @@ int extension_board_scan(struct list_head *extension_=
list)
> >                 struct am335x_cape_eeprom_id eeprom_header;
> >                 char process_cape_part_number[17] =3D {'0'};
> >                 char process_cape_version[5] =3D {'0'};
> > -               struct extension *cape;
> > +               struct extension cape =3D {0}, *_cape;
> >                 struct udevice *dev;
> >                 u8 cursor =3D 0;
> >                 int ret, i;
> > @@ -78,22 +78,20 @@ int extension_board_scan(struct list_head *extensio=
n_list)
>=20
> I suppose that a method called scan() could be added to the uclass and
> implemented by this driver.
>=20
> >
> >                 printf("BeagleBone Cape: %s (0x%x)\n", eeprom_header.bo=
ard_name, addr);
> >
> > -               cape =3D calloc(1, sizeof(struct extension));
> > -               if (!cape) {
> > -                       printf("Error in memory allocation\n");
> > -                       return num_capes;
> > -               }
> > -
> > -               snprintf(cape->overlay, sizeof(cape->overlay), "%s-%s.d=
tbo",
> > +               snprintf(cape.overlay, sizeof(cape.overlay), "%s-%s.dtb=
o",
> >                          process_cape_part_number, process_cape_version=
);
> > -               strlcpy(cape->name, eeprom_header.board_name,
> > +               strlcpy(cape.name, eeprom_header.board_name,
> >                         sizeof(eeprom_header.board_name));
> > -               strlcpy(cape->version, process_cape_version,
> > +               strlcpy(cape.version, process_cape_version,
> >                         sizeof(process_cape_version));
> > -               strlcpy(cape->owner, eeprom_header.manufacturer,
> > +               strlcpy(cape.owner, eeprom_header.manufacturer,
> >                         sizeof(eeprom_header.manufacturer) + 1);
> > -               list_add_tail(&cape->list, extension_list);
> > +               _cape =3D alist_add(extension_list, cape);
> > +               if (!_cape)
> > +                       return -ENOMEM;
> >                 num_capes++;
> >         }
> >         return num_capes;
> >  }
> > +
> > +U_BOOT_EXTENSION(cape, ti_extension_board_scan);
>=20
> Can the extension information go in the devicetree, so boards can
> select their scheme that way?

Since we're scanning to see what extension boards are present and so
what device tree overlays to apply, I don't think that can work?

--=20
Tom

--LlBB+nx6E1yEq5Og
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOQ4OQAKCRAr4qD1Cr/k
CqHhAPsF9T0w6trySJmye5zfYz0SIgLDjSgRqaztWLDzbiGDsgD/WEnkmQspHJ/Z
YMcP4r7xrS7BczpRN4M8yFajVTtXzw8=
=tY0W
-----END PGP SIGNATURE-----

--LlBB+nx6E1yEq5Og--
