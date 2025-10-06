Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B6ECCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 23:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1DAD83A56;
	Tue,  7 Oct 2025 01:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k0lxRcrO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79DE883ACA; Tue,  7 Oct 2025 01:42:48 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 307F183A45
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 01:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7a8e7ece907so3315202a34.0
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 16:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759794165; x=1760398965; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CzFcvvsivHkX1eenQX2utiUvh9GZtDAGrWufOCfjqXw=;
 b=k0lxRcrOH4oVgBGqPruL5m8YrH5LSDhVZ0R2QizHXIHQZbQFwTkvPTZZMa97CdYTGK
 eOPy0kPgRYuMwXQgukTS3bVgvA5DWfR6f5H3nDjS1R7CfnoyCf9UMGb1VtAn1RVtihyr
 syZKc+CeFXpqBeapg1bp5kulnmqwARJbsb1sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759794165; x=1760398965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzFcvvsivHkX1eenQX2utiUvh9GZtDAGrWufOCfjqXw=;
 b=mEn3/qAqSB4u7urTkToKXE6Hh+dbpiJ+RP9SZSlauynDKk+oshEoMPWXa5JRqRr2HL
 OKVlyIxCZW33vTyb5RMdeICR4gfluKfKvQRFQ1FCz+2qeOSNGnnbnS/9RDYuLiR5Cey1
 SsJNsstOnQiOU1eQr1iuk9h6L1jOmyIibZSCa5vnnUaQ5hmOJNIsIUyOYbos8k2rCz3d
 Z+IK7Oa95DcGH7DWs0Ez2FbZ456nTrpQ7nfJ+8/udj10yZhUbop1/fJ7K5XLhjxtn47V
 MbBOLvZbLwiQq1+FCIRrSu+qGKhXBZhrIu0417D24UjWgSTY2hlHre8EO6ar/yyUQxjk
 e3+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8LQYPmrLIxhOPx8ejcpFkWkWvh5FEClME/F2Kq/gOgKDOtfZnxfGRrX1ZzLQR3a6ALCae0CM=@lists.denx.de
X-Gm-Message-State: AOJu0YxuvjawvyG0QsvjL1YYLWozOsTxjGYc9Ga6N9pbVC+91hvDTrhC
 vK/5hsYGKKEch8hJzkIvIgEGUi9rknWK+VO614ceNmyNTM1YcB8WzSBDR1A0x+0r3PE=
X-Gm-Gg: ASbGnctL0vBzwU8JlJzg5X1H/IrmRDzrqLIeeoPET2Ntkwzp0gk592gA2jk3+8EJuFB
 x//w2h1D0vP2cehrVlyiQUZ8+w0fqawwNVC+ep7AxmhCzf/Dr5aoJkQFkGBDj4mrmKCpeZi3v0u
 jfbLgsOYhwkVsGj73EryVror84aJ33DEq7zxCeSd+al2cNt8CPLDgHbBXibjeCt7PcMetGINDC2
 /vc3A3Y4Jpmo5wZxi4eVhLPL8p11MTJOJ0Kj/ngyNLrKXKb0xv3VYmyehy4yUfS0u/bYGJd2jYg
 GZJF73XFp/uEzrtSyJJWjrdhEPpGoSeMOT0B8UXd0IclGL2FGB9te5wcrq5WCDX6/Gu3jIXpMe5
 A/Dceq4H4HLMPFq5RxlCOnAJnTGlgcOCBVIM0zwiIiDdJyfQVfC2GSq/hS8F0rRZzzMRXE4LPGs
 N3X3egi8pDbQ==
X-Google-Smtp-Source: AGHT+IECkKHMUHJKeNfR2gnQhwixn7O8nq9m31mBzVxpWQGqXn1v3f6F9+OA1g2uVQcU1ROXI6vVWg==
X-Received: by 2002:a05:6808:f86:b0:43f:7287:a5e7 with SMTP id
 5614622812f47-43fc1849218mr6662230b6e.34.1759794163870; 
 Mon, 06 Oct 2025 16:42:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64e18ce4565sm2795919eaf.10.2025.10.06.16.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 16:42:42 -0700 (PDT)
Date: Mon, 6 Oct 2025 17:42:40 -0600
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
Message-ID: <20251006234240.GF298503@bill-the-cat>
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
 <20251003-feature_sysboot_extension_board-v1-6-458b8bf85325@bootlin.com>
 <CAFLszTj3j6bcm6PG1GLAHa6FfjpKOKL12P_ae4WZsJL4hbh-HA@mail.gmail.com>
 <20251006214428.GD298503@bill-the-cat>
 <CAFLszTgLd7gHoU04QKAgHWNFQz_CS_XfeJCBkn58fu3UxUyurQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HMgJmSVMIDv/SQzZ"
Content-Disposition: inline
In-Reply-To: <CAFLszTgLd7gHoU04QKAgHWNFQz_CS_XfeJCBkn58fu3UxUyurQ@mail.gmail.com>
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


--HMgJmSVMIDv/SQzZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 05:30:15PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 6 Oct 2025 at 15:44, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 06, 2025 at 02:38:23PM -0600, Simon Glass wrote:
> > > Hi Kory,
> > >
> > > On Fri, 3 Oct 2025 at 10:34, Kory Maincent <kory.maincent@bootlin.com=
> wrote:
> > > >
> > > > Migrate TI board cape detection from legacy extension support to the
> > > > new UCLASS-based extension board framework.
> > > >
> > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > > ---
> > > >  arch/arm/mach-omap2/am33xx/Kconfig |  2 +-
> > > >  arch/arm/mach-omap2/omap5/Kconfig  |  2 +-
> > > >  board/ti/common/cape_detect.c      | 24 +++++++++++-------------
> > > >  3 files changed, 13 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/arch/arm/mach-omap2/am33xx/Kconfig b/arch/arm/mach-oma=
p2/am33xx/Kconfig
> > > > index dff4f1cf202..77f7938305b 100644
> > > > --- a/arch/arm/mach-omap2/am33xx/Kconfig
> > > > +++ b/arch/arm/mach-omap2/am33xx/Kconfig
> > > > @@ -15,7 +15,7 @@ config TARGET_AM335X_EVM
> > > >         select DM_GPIO
> > > >         select DM_SERIAL
> > > >         select TI_I2C_BOARD_DETECT
> > > > -       select SUPPORT_EXTENSION_SCAN
> > > > +       select SUPPORT_DM_EXTENSION_SCAN
> > > >         imply CMD_DM
> > > >         imply SPL_DM
> > > >         imply SPL_DM_SEQ_ALIAS
> > > > diff --git a/arch/arm/mach-omap2/omap5/Kconfig b/arch/arm/mach-omap=
2/omap5/Kconfig
> > > > index 5394529658b..819490a8cf8 100644
> > > > --- a/arch/arm/mach-omap2/omap5/Kconfig
> > > > +++ b/arch/arm/mach-omap2/omap5/Kconfig
> > > > @@ -38,7 +38,7 @@ config TARGET_AM57XX_EVM
> > > >         select CMD_DDR3
> > > >         select DRA7XX
> > > >         select TI_I2C_BOARD_DETECT
> > > > -       select SUPPORT_EXTENSION_SCAN
> > > > +       select SUPPORT_DM_EXTENSION_SCAN
> > > >         imply DM_THERMAL
> > > >         imply SCSI
> > > >         imply SPL_THERMAL
> > > > diff --git a/board/ti/common/cape_detect.c b/board/ti/common/cape_d=
etect.c
> > > > index 7786bdda5d1..23c93964dc3 100644
> > > > --- a/board/ti/common/cape_detect.c
> > > > +++ b/board/ti/common/cape_detect.c
> > > > @@ -22,7 +22,7 @@ static void sanitize_field(char *text, size_t siz=
e)
> > > >         }
> > > >  }
> > > >
> > > > -int extension_board_scan(struct list_head *extension_list)
> > > > +static int ti_extension_board_scan(struct alist *extension_list)
> > > >  {
> > > >         unsigned char addr;
> > > >         int num_capes =3D 0;
> > > > @@ -31,7 +31,7 @@ int extension_board_scan(struct list_head *extens=
ion_list)
> > > >                 struct am335x_cape_eeprom_id eeprom_header;
> > > >                 char process_cape_part_number[17] =3D {'0'};
> > > >                 char process_cape_version[5] =3D {'0'};
> > > > -               struct extension *cape;
> > > > +               struct extension cape =3D {0}, *_cape;
> > > >                 struct udevice *dev;
> > > >                 u8 cursor =3D 0;
> > > >                 int ret, i;
> > > > @@ -78,22 +78,20 @@ int extension_board_scan(struct list_head *exte=
nsion_list)
> > >
> > > I suppose that a method called scan() could be added to the uclass and
> > > implemented by this driver.
> > >
> > > >
> > > >                 printf("BeagleBone Cape: %s (0x%x)\n", eeprom_heade=
r.board_name, addr);
> > > >
> > > > -               cape =3D calloc(1, sizeof(struct extension));
> > > > -               if (!cape) {
> > > > -                       printf("Error in memory allocation\n");
> > > > -                       return num_capes;
> > > > -               }
> > > > -
> > > > -               snprintf(cape->overlay, sizeof(cape->overlay), "%s-=
%s.dtbo",
> > > > +               snprintf(cape.overlay, sizeof(cape.overlay), "%s-%s=
=2Edtbo",
> > > >                          process_cape_part_number, process_cape_ver=
sion);
> > > > -               strlcpy(cape->name, eeprom_header.board_name,
> > > > +               strlcpy(cape.name, eeprom_header.board_name,
> > > >                         sizeof(eeprom_header.board_name));
> > > > -               strlcpy(cape->version, process_cape_version,
> > > > +               strlcpy(cape.version, process_cape_version,
> > > >                         sizeof(process_cape_version));
> > > > -               strlcpy(cape->owner, eeprom_header.manufacturer,
> > > > +               strlcpy(cape.owner, eeprom_header.manufacturer,
> > > >                         sizeof(eeprom_header.manufacturer) + 1);
> > > > -               list_add_tail(&cape->list, extension_list);
> > > > +               _cape =3D alist_add(extension_list, cape);
> > > > +               if (!_cape)
> > > > +                       return -ENOMEM;
> > > >                 num_capes++;
> > > >         }
> > > >         return num_capes;
> > > >  }
> > > > +
> > > > +U_BOOT_EXTENSION(cape, ti_extension_board_scan);
> > >
> > > Can the extension information go in the devicetree, so boards can
> > > select their scheme that way?
> >
> > Since we're scanning to see what extension boards are present and so
> > what device tree overlays to apply, I don't think that can work?
>=20
> My understanding is that the scanning process is board-specific. For
> example we would not want the Beagle mechanism to be compiled into
> rpi. The idea of scanning things in a board-specific way seems like a
> driver to me. Note there is also the SYSINFO uclass which can do
> similar things.
>
> The overlays being applied here are additions to what should already
> be a fairly complete devicetree.
>=20
> If this isn't possible, then where is the information known?

You're commenting on a patch to the TI specific code, that's only used
by TI SoC using platforms that opt-in to the externally defined EEPROM
format for these "capes". Perhaps your feedback would make more sense in
some other part of the patch series? But even then, I'm not sure it
makes sense?

--=20
Tom

--HMgJmSVMIDv/SQzZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaORT7AAKCRAr4qD1Cr/k
ChnqAQDLnCTGi8tSQ+gxWL5A+bdvBL2GatDTcyfeiXMivFyV0wD/ZtcPamXlBHkZ
+iY35aOwZ7Ull5N2EkVVvoLwg9lzXAw=
=vTEO
-----END PGP SIGNATURE-----

--HMgJmSVMIDv/SQzZ--
