Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41031D46BE5
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 17:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4630183CAA;
	Wed, 28 Jan 2026 18:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d3eTUSN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 099F483CE3; Wed, 28 Jan 2026 18:46:31 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD31F83C39
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 18:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-45effa36240so123071b6e.1
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 09:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769622387; x=1770227187; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5ws8ZZSxB00+PtbSeumDVI17I3dp3MSghhuaKD4TL04=;
 b=d3eTUSN50yUNlGd02S+6fpPxIAvCKsDsJntqD8KhmC14s0AKGMIT2UZbe2PX2+WiNy
 CD8t8lbpLkpPV8PxNKQ4r2oIyHlOdju8je4T/p4IYtdbJwDM7xrypvc4R4jhsQ/U9IaK
 thJkfZq/snScQBqKkvgjkAY2adudY5TlLwigc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769622387; x=1770227187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ws8ZZSxB00+PtbSeumDVI17I3dp3MSghhuaKD4TL04=;
 b=Ew2UYzw/PbL+mkhbL9Hidyw6c2og71+BJH7rWwkoWefYa/J4kdwuik99VB7j6peIgW
 0zrT072ivK17UAWs2DXKteLksViYAVecxATejHQZNr1Rd/Y1a8mwxvUauW4Jqxz/MVrp
 HPsW6HTgjhaC9itymp4yY57JNm9rO6OxQP7YqAMWo7TvYE+lEExuw/o9M+2lsptuL20d
 t7FcEOEZ2wW6bxHo52cu/VFDLAt/YeLFtMQ7Tk0hHa/hBaXN5yRT8vmdCGRwvtRkntol
 hpO214orA+jwVRQQohkm3ghzRZoEzQ7flOyQF/asTr2qHSS2JQcF3rUhvMv2N3/PQm8F
 IvvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV3FUJz28nY7JnepeVFHwIOyt7sdBoQM4aY2JyWCGfNjaBGNbeet1kQZw6B39JRKLlD/XbTWQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyz+qmA3I0LrZpdSZBmb9C+uABSD9euCIt5sB5BVLHN5WOjNqcA
 aon/vapCbKbWYETQQdtxVTh74Uk+ENPbjlmIV5byepNR9NdlPm19OLwWCPQBZ0lYPQg=
X-Gm-Gg: AZuq6aIXyHh1onp/JRq7RbwQFwPTi1801S6n6jO4egQ9SyyELPTn7FtLzUwagUN7Sz0
 v6d0Fxqu8t5cGKxSrxMqutiSRi5L88lqMpTkWc88vZTutWebUBmXMyiXZmaa+OuMTNJc8ig4e3E
 dYpljeynIRtan6DacN/eW3P8OwgcvRITvzaWAJS0Ui4RBBGvl7xeD43tzpOadB2WvYhoQK6eaVV
 O9JDUWB1t/34+EqRYLIkLWhLUK6T0KdrLIvVZiLRosilu86XBZzprEwnIrf4e+tEMbTUudn25hk
 rOoJdRsB4KuEhgLbcDPuVzZWw7Z+M/vpXrVa3bba6O4N56dSkMnTswEj5mnu/3H4keuutLmLTcA
 koF/f31/yaieH4SJe5CrWkDCSyGyxaQEoAA+WQYcqzwBIlY1ORk7kHQjtUkCFMffv735t+pQDvy
 sm+4ERRJNweFEDASQ7oT1wcYMTZ0eLLT0Wpv0qR0Uk3AxziZDHRyKPaO9LkXPc0oiM69FKyZzcZ
 640A3VkxPhRIUBok1a6OEiqNRGDHiO63Cd9v64=
X-Received: by 2002:a05:6808:1443:b0:45a:7773:9013 with SMTP id
 5614622812f47-45efc59fd2dmr3972031b6e.21.1769622387469; 
 Wed, 28 Jan 2026 09:46:27 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095752ef7bsm2159946fac.16.2026.01.28.09.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:46:26 -0800 (PST)
Date: Wed, 28 Jan 2026 11:46:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Mateus Lima <mateuslima.ti@gmail.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, alison.wang@nxp.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2] armv7: Add CPLD support via IFC to the ls1021a-iot
 board.
Message-ID: <20260128174624.GO3416603@bill-the-cat>
References: <20260113142303.441190-1-mateuslima.ti@gmail.com>
 <aXGZVQhGzIrtXY86@nxa18884-linux.ap.freescale.net>
 <CAP8WwTH5=Aqy+QLLRv9QGJ3RTbwyMXA88BsO4eJOB-WawHfHMg@mail.gmail.com>
 <aXbNSAUDjG83gKsq@shlinux89>
 <20260128164704.GM3416603@bill-the-cat>
 <CAP8WwTG0VVR26QxEFtpDN2s7xH_L3dR2y4PkwfwFgeSv-yV-cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7LlEPVzphO3RZmc+"
Content-Disposition: inline
In-Reply-To: <CAP8WwTG0VVR26QxEFtpDN2s7xH_L3dR2y4PkwfwFgeSv-yV-cw@mail.gmail.com>
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


--7LlEPVzphO3RZmc+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 02:06:22PM -0300, Mateus Lima wrote:
> On Wed, Jan 28, 2026 at 1:47=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>=20
> > On Mon, Jan 26, 2026 at 10:11:20AM +0800, Peng Fan wrote:
> > > On Thu, Jan 22, 2026 at 10:12:36AM -0300, Mateus Lima wrote:
> > > >On Wed, Jan 21, 2026 at 11:13=E2=80=AFPM Peng Fan <peng.fan@oss.nxp.=
com> wrote:
> > > >
> > > >> On Tue, Jan 13, 2026 at 11:23:01AM -0300, Mateus Lima Alves wrote:
> > > >> >This patch adds CPLD support via IFC to the ls1021a-iot board.
> > > >> >
> > > >> >Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
> > > >>
> > > >> CI report build failure.
> > > >>
> > > >>   CC      drivers/video/hitachi-tx10d07vm0baa.o
> > > >> In file included from drivers/misc/fsl_ifc.c:8:
> > > >> include/fsl_ifc.h:16:10: fatal error: asm/ppc.h: No such file or
> > directory
> > > >>    16 | #include <asm/ppc.h>
> > > >>       |          ^~~~~~~~~~~
> > > >> compilation terminated.
> > > >> make[3]: *** [scripts/Makefile.build:271: drivers/misc/fsl_ifc.o]
> > Error 1
> > > >> make[2]: *** [scripts/Makefile.build:492: drivers/misc] Error 2
> > > >> make[2]: *** Waiting for unfinished jobs....
> > > >>   CC      drivers/rtc/ht1380.o
> > > >>   CC      drivers/video/hitachi_tx18d42vm_lcd.o
> > > >>   CC      drivers/rtc/i2c_rtc_emul.o
> > > >>
> > > >> make[1]: *** [Makefile:2191: drivers] Error 2
> > > >> make: *** [Makefile:362: __build_one_by_one] Error 2
> > > >> Cleaning up project directory and file based variables
> > > >>
> > > >> Regards
> > > >> Peng
> > > >>
> > > >Hi Peng,
> > > >
> > > >Thank you for the test, and apologies for not having validated the
> > patch on
> > > >other targets.
> > > >In fact, this driver was not being used by any target (neither ARM n=
or
> > PPC)
> > > >and after this patch it became enabled again. However, PPC targets f=
ail
> > > >when trying to include the asm/ppc.h header, which is not available =
for
> > > >some reason.
> > > >
> > > >For now, I am thinking of submitting a v3 of the patch adding an
> > explicit
> > > >dependency on ARM, something like:
> > > >
> > > >+ depends on ARM
> > > >
> > > >This way we would avoid building the driver for PPC targets.
> > > >What do you think about this approach?
> > >
> > > It should be ok.
> >
> > This has lead to:
> > WARNING: unmet direct dependencies detected for FSL_IFC
> >   Depends on [n]: ARM [=3Dn]
> >   Selected by [y]:
> >   - ARCH_P1010 [=3Dy] && PPC [=3Dy] && MPC85xx [=3Dy]
> >
> > WARNING: unmet direct dependencies detected for FSL_IFC
> >   Depends on [n]: ARM [=3Dn]
> >   Selected by [y]:
> >   - ARCH_P1010 [=3Dy] && PPC [=3Dy] && MPC85xx [=3Dy]
> >
> > For example on P1010RDB-PB_SPIFLASH.
> >
> > --
> > Tom
> >
> Hi Tom,
>=20
> Yes, I noticed that this warning is appearing now, and before this patch,

I'm not sure what you mean by this. This change introduced the warning.

--=20
Tom

--7LlEPVzphO3RZmc+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXpLbQAKCRAr4qD1Cr/k
Cg0sAP9xCGQW9jP4Pj0dnFuupnW1FliHy7SYU4yc43id2N292QD8CEHZDVV2En2M
h2MSPQcQY9t5rnEfEOVNC+FZi3DMgQc=
=TbmK
-----END PGP SIGNATURE-----

--7LlEPVzphO3RZmc+--
