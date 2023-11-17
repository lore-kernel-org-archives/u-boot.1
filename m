Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C80CC54FB9
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 19:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5591874BD;
	Fri, 17 Nov 2023 20:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qv2+w0RY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F7AC874BD; Fri, 17 Nov 2023 20:57:52 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2498586D23
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 20:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-778999c5ecfso138298285a.2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 11:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700251067; x=1700855867; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oExLosupoKTjDnsD5eKDc2VX/5iWMbbiQU9cEQzzHOE=;
 b=qv2+w0RYEGhpaGxDVRhGKZ1GxPRgHj0KAvKErftfQax1VaRNDkxL0P2JeD7yoakMds
 R1dwCuv7KbhJSaGfDUmocC9ocvuuadxYe0Qos+ZdnXrElG1Op1tXmJ4+dbAyh8qjkAD/
 RHAW00m5ZqScKAq/nSZjRVEHo1w9PxU5r6K8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700251067; x=1700855867;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oExLosupoKTjDnsD5eKDc2VX/5iWMbbiQU9cEQzzHOE=;
 b=rrCyw5quuJelDgcrM7SIetXqk9q03pEdQ7mukWyu4iU65siPWM+b7lFcKBdOaNbaDZ
 fphbECGY+ZgUh0OwUsEygQVy1sVThTgyFdxkmKIO8rz07FrRjNEZ8pE+COeqTf8eV+eF
 I8WVuuYqi2AQTua1bGt636mauaD37NvcyRW+VTTp3GMroOhB36GfX6cc5mqTGTiwK4O3
 S3f3kWCtLHTaJbaRI6FtIDT316sd57BHpowwtiWn4KE7VzWU5ConDoWfC7u+rmt4/Eum
 puLi/ZHF4+V8hJGzUHtHe98W7E+ptgEyD+OMT4m624gy8OeesGDP2/cqAQwQZFXOqmfy
 3Wpg==
X-Gm-Message-State: AOJu0YxqUF+aY3NSu2WOILp0ZPCLyjGHg0ujgfxrPqmvug4Z1PVNS8c1
 1noprNMCTrfe8KWiLnO6ZHb1dPYyKx29Dog/KIIOMg==
X-Google-Smtp-Source: AGHT+IHEV6AYbotSb8kjTyfj3S2UhSrbuUoZdcHyDvLKlkiue4jUmXKFcfnVc5Pk3cUrvEeL4CgOgQ==
X-Received: by 2002:a05:620a:1434:b0:775:f1bd:f75e with SMTP id
 k20-20020a05620a143400b00775f1bdf75emr574732qkj.39.1700251066875; 
 Fri, 17 Nov 2023 11:57:46 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a05620a056a00b00765ab6d3e81sm828672qkp.122.2023.11.17.11.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 11:57:46 -0800 (PST)
Date: Fri, 17 Nov 2023 14:57:44 -0500
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: John Clark <inindev@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Slawomir Stepien <sst@poczta.fm>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] rockchip: rk3588: Fix boot from SPI flash
Message-ID: <20231117195744.GA170968@bill-the-cat>
References: <20231112102705.1180714-1-jonas@kwiboo.se>
 <20231112102705.1180714-2-jonas@kwiboo.se>
 <561f7d8a-bf46-4ba7-a353-b5d3dfab95b0@theobroma-systems.com>
 <ZVdyu2vjW0LrW6Jf@nr200> <20231117175020.GP170968@bill-the-cat>
 <31e783f3-a73b-e6fc-bf25-84a8b2c4cd1d@gmail.com>
 <20231117190750.GQ170968@bill-the-cat>
 <9353ea1a-1bf2-4385-9142-0c62a49a562d@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wbVTHBB2H22vVw4G"
Content-Disposition: inline
In-Reply-To: <9353ea1a-1bf2-4385-9142-0c62a49a562d@kwiboo.se>
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


--wbVTHBB2H22vVw4G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 08:53:49PM +0100, Jonas Karlman wrote:
> On 2023-11-17 20:07, Tom Rini wrote:
> > On Fri, Nov 17, 2023 at 01:50:58PM -0500, John Clark wrote:
> >>
> >> On 11/17/23 12:50 PM, Tom Rini wrote:
> >>> On Fri, Nov 17, 2023 at 03:03:39PM +0100, Slawomir Stepien wrote:
> >>>> On lis 14, 2023 15:06, Quentin Schulz wrote:
> >>>>> Hi Jonas,
> >>>> Hi Quentin
> >>>>
> >>>>> On 11/12/23 11:26, Jonas Karlman wrote:
> >>>>>> The commit fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot fr=
om SPI
> >>>>>> NOR flash") added a new BROM_BOOTSOURCE_SPINOR_RK3588 with value 6.
> >>>>>>
> >>>>>> At the time the reason for this new bootsource id value 6 was unkn=
own.
> >>>>>>
> >>>>>> We now know that the BootRom on RK3588 use different bootsource id
> >>>>>> values depending on the iomux used by the flash spi controller, an=
d not
> >>>>>> by the type of spi nor or spi nand flash used.
> >>>>>>
> >>>>>> Add the following defines and use them for RK3588 boot_devices.
> >>>>>>
> >>>>>> - BROM_BOOTSOURCE_FSPI_M0 =3D 3
> >>>>>> - BROM_BOOTSOURCE_FSPI_M1 =3D 4
> >>>>>> - BROM_BOOTSOURCE_FSPI_M2 =3D 6
> >>>>>>
> >>>>>> Fixes: fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from S=
PI NOR flash")
> >>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>>>>> ---
> >>>>>>    arch/arm/include/asm/arch-rockchip/bootrom.h | 4 +++-
> >>>>>>    arch/arm/mach-rockchip/rk3588/rk3588.c       | 5 +++--
> >>>>>>    2 files changed, 6 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/a=
rm/include/asm/arch-rockchip/bootrom.h
> >>>>>> index 7dab18fbc3fb..f78337397d63 100644
> >>>>>> --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
> >>>>>> +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
> >>>>>> @@ -47,8 +47,10 @@ enum {
> >>>>>>    	BROM_BOOTSOURCE_EMMC =3D 2,
> >>>>>>    	BROM_BOOTSOURCE_SPINOR =3D 3,
> >>>>>>    	BROM_BOOTSOURCE_SPINAND =3D 4,
> >>>>>> +	BROM_BOOTSOURCE_FSPI_M0 =3D 3,
> >>>>>> +	BROM_BOOTSOURCE_FSPI_M1 =3D 4,
> >>>>> I'm a bit wary of two pairs of enums sharing the same value, especi=
ally when
> >>>>> we want to use them as offset in a static definition of an array.
> >>>>>
> >>>>> Should we #ifdef it (meh) for RK3588?
> >>>>> Should we add a suffix like before for identifying RK3588-specific =
options?
> >>>>>
> >>>>> At the very least explicit that those are RK3588-specific in a comm=
ent for
> >>>>> both conflicts (the ones that apply to everything except RK3588 to =
say to
> >>>>> use only for !RK3588, and the ones that apply to RK3588 only)?
> >>>> Can you say why it is so important to know that given enum is specif=
ic to given CPU here in the
> >>>> header file? I think that the enums in the bootrom.h should be as ge=
neric as possible.
> >>>>
> >>>> By using the possible enums in a static array, "solves" the problem =
of assigning the boot source to
> >>>> specific CPU. There is not need to make such grouping in the bootrom=
=2Eh.
> >>> Do we have any insight as to why Rockchip re-used those values? Looki=
ng
> >>> at the header I see RK3588 has a different SPINOR value than others.
> >>> Does RK3588 share the same value for other sources? How much of
> >>> bootrom.h is still correct for RK3588? I'd rather not have to move to
> >>> having bootrom_${soc}.h like so many other headers are, and if it's j=
ust
> >>> these values, it might be cleaner to #if .. #else .. #endif the whole
> >>> enum, and then re-evaluate things abased on whatever the next new SoC
> >>> does here.
> >>>
> >> Which c specification does u-boot follow?=A0 Duplicate values in enume=
rations
> >> are explicitly allowed in c as far as I ever have known.
> >>
> >> "The use of enumerators with =3D may produce enumeration constants wit=
h values
> >> that duplicate other values in the same enumeration."
> >> https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2310.pdf
> >=20
> > Sorry I wasn't clear. It's less about C specification and more about
> > readability. We could do, but I feel is odd readability-wise is:
> > enum {
> >         BROM_BOOTSOURCE_NAND =3D 1,
> >         BROM_BOOTSOURCE_EMMC =3D 2,
> >         BROM_BOOTSOURCE_SPINOR =3D 3,
> >         BROM_BOOTSOURCE_SPINAND =3D 4,
> >         BROM_BOOTSOURCE_SD =3D 5,
> >         BROM_BOOTSOURCE_FSPI_M0_RK3588 =3D 3,
> > 	BROM_BOOTSOURCE_FSPI_M1_RK3588 =3D 4,
> >         BROM_BOOTSOURCE_FSPI_M2_RK3588 =3D 5,
> >         BROM_BOOTSOURCE_SPINOR_RK3588 =3D 6,
> >         BROM_BOOTSOURCE_USB =3D 10,
> >         BROM_LAST_BOOTSOURCE =3D BROM_BOOTSOURCE_USB
> > };
> >=20
> > But how many of the other values are still correct for RK3588? The TRM I
> > found quickly does say that NAND and SD/eMMC are valid options, and USB,
> > but I didn't see a table that mapped back to the values here.
> >=20
>=20
> Remaining values that is supported should be same, the only difference
> for RK3588 is that the old SPINOR=3D3/SPINAND=3D4 values now map to flash
> spi iomux M0 and M1, and compared to bootrom in other SoCs cannot be
> used to determine if SPI NOR or SPI NAND was the boot source. The new
> value 6 maps to flash spi iomux M2. What type of flash spi media the
> device was booted from, nor/nand, does not matter for RK3588.
>=20
> Guess I can add a enum for the rk3588 FSPI_M0/M1/M2 values directly in
> rk3588.c where they are used, and when next SoC re-use iomux for flash
> spi controller they can be moved to bootrom.h.

OK, thanks.

--=20
Tom

--wbVTHBB2H22vVw4G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXxbUACgkQFHw5/5Y0
tywgCwv+J/jF+Pi1+awWaT0gc37YUCy8NvUkALVI4pdlD7iOV+4VdE7AuS4moIeU
H9gxKRW/7jIvSDaYcNdH734UB8sudQWbvQP8ATTHDsLJr/G6Nkvrph9GaLzRUf3r
o4VrHhVE9KsRGiQUi/jHmVt/QyeC6hrY9Li8ywF8lTAz8/nZjlnYPLxPrgyJ5ewR
VOMoEWjy6w/sxPLJSGad4VA7Sqy0Kl5ZCCR4Lm5H5Qo+F7JUf28ayyQQPJ6EZk8y
Yc60gpsavRsbVaBPECtkqjArW4Fj6nleG9Ggv0PJwEGiQuTOb6e+D7gi8838T5vw
NjMO+0J4XqxX6yjuy/qTA+SVT+ctrVnUEpVLEuxPt0GR1rRIy4vbkk7v9mgvDp3f
tT1Fl7S2KmK5qclkagomP6XRy6/GsSuyI4Te0nu0GpP9EbFUgFHPYxpGJ6Pr01d2
FfRbzNnLGlHJeLFQ1bMu8VxK8XwwXu2LQ1GwzjkwXGHjWlVMQ/4nH/sVO9bevzZ9
79YUS3Xt
=7H5k
-----END PGP SIGNATURE-----

--wbVTHBB2H22vVw4G--
