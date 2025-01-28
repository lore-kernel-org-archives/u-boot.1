Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FACCC0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 22:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC49481E76;
	Tue, 28 Jan 2025 23:16:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q6EQ9p0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9376081E8C; Tue, 28 Jan 2025 23:16:08 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 220F781D27
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 23:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b6e9317a2aso12653685a.0
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 14:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738102565; x=1738707365; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ym0vBBU7asEo+xJDkYfzS71MPwXagXS/hrCAx1+41QU=;
 b=Q6EQ9p0y/dScx0TB6A/rY9xOEAYCpUdCRkr+Gs5TzvOAXA3xVYqeJ9vVxoZU5xpeYo
 9TYr3B4F/93/86J+d+r98b2eS6momTNfhKlfrnW9PK8ndSNeaaVl5Ff1NPhscqrcMZwF
 WbdzOSLLnL0FX1UrZdim2v7hTxeFXAsQKIiuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738102565; x=1738707365;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ym0vBBU7asEo+xJDkYfzS71MPwXagXS/hrCAx1+41QU=;
 b=NjWpqkyJjfo+c6kSVGCDycyGBo6FI83q8NVG2lyj6PMwHdvEMhQtc1LlQtCcFgD4Ow
 ZI/NJvOfuzjKj0oxg4zUKzmzrq3aoF6P8LQ/+qejJBXmlYFo4lLIFjB617BjhCTYeF5j
 Vt/9klxEGI/xy73Afc+JJecggSA9NIhiA8QhygX4oSn9HCovZvu5KJscEVgfJd4E4uVm
 SYL0Lx+zb+xT9w+DrDc6/hw8EVkZWBVwnZBlj0xMmoAKJUxvZzX/YJYTRavIGzvzf37h
 +O5W0Gjw8JzAbDOc6S6dwUBu40n4dcFyTd//fybPeezklSk/VBkpBTrw5yLBqcyojrTo
 nzMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO3C0txYrFqBEOeRMI2cJea8Kt334i2zYpKTNuMwy5CkveOj+K7+fyPc7Mojw3/3VTRIVt8u0=@lists.denx.de
X-Gm-Message-State: AOJu0YwmHI/WzNNKY7oOYzOmHUsYQ1GUQJxy6UXKJ9+BWg0dLBOKXMjG
 IRKgWbZxljM3XfplghvXhmAsn/APhexzm/2AzBhJDNEJ5Rm3kTw75vHkXkrjfw4=
X-Gm-Gg: ASbGncvOK5wBU30dyOOfemFhDq02WzF4BPeu4gs7NRz9YmnAC++b6pEtyFOqwjK6vCU
 pVZM8Oiv5KUOoAVmYICz0v08ZXJn100DsV162vaATfHFiamWRekDJsu3Bs9vkwMNBGTc+l2ffBF
 OYLV9RWIVT6FhZyLl+6P3BynSOMyrIEjYVA/vz7eVwL8ljtWrd/6LGlB4UOIw4RmqcMy/VWFTdh
 3dyAq0Wg3byKks/cTYnTHkNWcE8kK8nPpsBQR4tzWa+gvK0vSl5YhSxErW0tJ4PL003Mp1ERWT5
 /d6KfTKzxd0GT9U=
X-Google-Smtp-Source: AGHT+IH8x5bCpXwC4Gj5M70sCOxk6ud+OoI420FAhN8v6Ekl3Rw4ujpNnjvEvFknQfxcs3qPiDQiew==
X-Received: by 2002:a05:620a:2726:b0:7a9:abdf:f517 with SMTP id
 af79cd13be357-7bff402e337mr813717085a.25.1738102564906; 
 Tue, 28 Jan 2025 14:16:04 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9aeedbfcsm557667785a.81.2025.01.28.14.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 14:16:03 -0800 (PST)
Date: Tue, 28 Jan 2025 16:15:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: eugen.hristev@microchip.com, u-boot@lists.denx.de, sjg@chromium.org,
 xypron.glpk@gmx.de, michal.simek@amd.com,
 daniel.schwierzeck@gmail.com, marex@denx.de, alpernebiyasak@gmail.com
Subject: Re: [PATCH] lds: align u-boot-nodtb with 8 bytes boundary
Message-ID: <20250128221559.GR1233568@bill-the-cat>
References: <20221215115825.827111-1-eugen.hristev@microchip.com>
 <87edsx4qzy.fsf@bloch.sibelius.xs4all.nl>
 <20221221215637.GA3787616@bill-the-cat>
 <87len02xan.fsf@bloch.sibelius.xs4all.nl>
 <20221221230910.GC3787616@bill-the-cat>
 <87k02k2vku.fsf@bloch.sibelius.xs4all.nl>
 <20221221234412.GE3787616@bill-the-cat>
 <Z5kJyl354DO7uKCR@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JqqHSjZdGMPRHZXM"
Content-Disposition: inline
In-Reply-To: <Z5kJyl354DO7uKCR@kitsune.suse.cz>
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


--JqqHSjZdGMPRHZXM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 05:46:02PM +0100, Michal Such=E1nek wrote:
> Hello,
>=20
> On Wed, Dec 21, 2022 at 06:44:12PM -0500, Tom Rini wrote:
> > On Thu, Dec 22, 2022 at 12:20:01AM +0100, Mark Kettenis wrote:
> > > > Date: Wed, 21 Dec 2022 18:09:10 -0500
> > > > From: Tom Rini <trini@konsulko.com>
> > > >=20
> > > > On Wed, Dec 21, 2022 at 11:42:56PM +0100, Mark Kettenis wrote:
> > > > > > Date: Wed, 21 Dec 2022 16:56:37 -0500
> > > > > > From: Tom Rini <trini@konsulko.com>
> > > > > >=20
> > > > > > On Sat, Dec 17, 2022 at 11:14:41PM +0100, Mark Kettenis wrote:
> > > > > > > > From: Eugen Hristev <eugen.hristev@microchip.com>
> > > > > > > > Date: Thu, 15 Dec 2022 13:58:25 +0200
> > > > > > > >=20
> > > > > > > > Newer DTC require that the DTB start address is aligned at =
8 bytes.
> > > > > > > > In the u-boot.bin case, the u-boot-nodtb.bin is concatenate=
d with the
> > > > > > > > DTB, but there is no alignment/padding to the next 8byte al=
igned address.
> > > > > > > > This causes the board to fail booting, because the FDT will=
 claim
> > > > > > > > that the DTB inside u-boot.bin is not a valid DTB, it will =
fail with
> > > > > > > > -FDT_ERR_ALIGNMENT.
> > > > > > > > To solve this, have the u-boot binary `_end` aligned with 8=
 bytes.
> > > > > > > > The objcopy in the Makefile will create the u-boot-nodtb.bi=
n and it has to
> > > > > > > > be truncated to 8 bytes to correspond to the u-boot.map fil=
e which will
> > > > > > > > have the `_end` aligned to 8 bytes.
> > > > > > > > The lds files which use devicetrees have been changed to al=
ign the `_end`
> > > > > > > > tag with 8 bytes.
> > > > > > > >=20
> > > > > > > > This patch is also a prerequisite to have the possibility t=
o update the
> > > > > > > > dtc inside u-boot to newer versions (1.6.1+)
> > > > > > > >=20
> > > > > > > > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> > > > > > > > ---
> > > > > > > > Hi,
> > > > > > > >=20
> > > > > > > > I could not test all affected boards, it's an impossible ta=
sk.
> > > > > > > > I tried this on at91 boards which I have, and ran the CI on=
 denx.
> > > > > > > > I cannot guarantee that no other boards are affected, so th=
is patch is a bit
> > > > > > > > of an RFC.
> > > > > > > > If the u-boot-nodtb.bin does not have the size equal with t=
he corresponding
> > > > > > > > one in u-boot.map, the binary_size_check will fail at build=
 time with
> > > > > > > > something like this:
> > > > > > > >=20
> > > > > > > > u-boot.map shows a binary size of 502684
> > > > > > > > but u-boot-nodtb.bin shows 502688
> > > > > > > >=20
> > > > > > > > Thanks,
> > > > > > > > Eugen
> > > > > > > >=20
> > > > > > > >  Makefile                                    | 2 ++
> > > > > > > >  arch/arm/cpu/armv8/u-boot.lds               | 4 ++--
> > > > > > > >  arch/arm/cpu/u-boot-spl.lds                 | 1 +
> > > > > > > >  arch/arm/cpu/u-boot.lds                     | 1 +
> > > > > > > >  arch/arm/lib/elf_arm_efi.lds                | 5 +++++
> > > > > > > >  arch/arm/mach-at91/arm926ejs/u-boot-spl.lds | 2 +-
> > > > > > > >  arch/arm/mach-at91/armv7/u-boot-spl.lds     | 2 +-
> > > > > > > >  arch/arm/mach-zynq/u-boot-spl.lds           | 2 +-
> > > > > > > >  arch/mips/cpu/u-boot.lds                    | 2 +-
> > > > > > > >  arch/sandbox/cpu/u-boot.lds                 | 6 ++++++
> > > > > > > >  arch/sh/cpu/u-boot.lds                      | 2 ++
> > > > > > > >  board/ti/am335x/u-boot.lds                  | 1 +
> > > > > > > >  tools/binman/test/u_boot_binman_embed.lds   | 2 +-
> > > > > > > >  13 files changed, 25 insertions(+), 7 deletions(-)
> > > > > > > >=20
> > > > > > > > diff --git a/Makefile b/Makefile
> > > > > > > > index 9d84f96481..b4d387bcce 100644
> > > > > > > > --- a/Makefile
> > > > > > > > +++ b/Makefile
> > > > > > > > @@ -1317,6 +1317,8 @@ endif
> > > > > > > > =20
> > > > > > > >  u-boot-nodtb.bin: u-boot FORCE
> > > > > > > >  	$(call if_changed,objcopy_uboot)
> > > > > > > > +# Make sure the size is 8 byte-aligned.
> > > > > > > > +	@truncate -s %8 $@
> > > > > > >=20
> > > > > > > $ truncate
> > > > > > > ksh: truncate: not found
> > > > > > >=20
> > > > > > > In other words: truncate(1) isn't a standard UNIX utility and=
 not
> > > > > > > present on OpenBSD for example.  It isn't part of POSIX and t=
herefore
> > > > > > > its usage is unportable.
> > > > > > >=20
> > > > > > > Please find a different solution.
> > > > > >=20
> > > > > > Ah yes. Can this perhaps be done with dd? A bit of looking arou=
nd
> > > > > > suggests that this might be a portable way to truncate a file t=
o say 512
> > > > > > bytes:
> > > > > > dd if=3D/dev/urandom of=3Dtestfile bs=3D1 count=3D500
> > > > > > dd if=3D/dev/null of=3Dtestfile bs=3D1 count=3D512
> > > > > >=20
> > > > > > And then hexdump or whatever to see that the last 12 bytes are =
zero. Can
> > > > > > you please test this on OpenBSD?  We'll need some shell work to=
 get
> > > > > > current byte size and make it 8-byte aligned, but that should be
> > > > > > portable at least.  Thanks!
> > > > >=20
> > > > > Hi Tom,
> > > > >=20
> > > > > That results on a file with zero bytes on OpenBSD... but also on
> > > > > Linux.  Did you intend to write something different?  I can't
> > > > > immediately come up with a way to do this with dd(1).
> > > >=20
> > > > Ah, I typod that, sorry!  I meant (and just re-checked):
> > > > dd if=3D/dev/urandom of=3Dtestfile bs=3D1 count=3D500
> > > > dd if=3D/dev/null of=3Dtestfile bs=3D1 seek=3D512
> > > >=20
> > > > Which here does:
> > > > $ dd if=3D/dev/urandom of=3Dtestfile bs=3D1 count=3D500
> > > > 500+0 records in
> > > > 500+0 records out
> > > > 500 bytes copied, 0.00641125 s, 78.0 kB/s
> > > > $ dd if=3D/dev/null of=3Dtestfile bs=3D1 seek=3D512
> > > > 0+0 records in
> > > > 0+0 records out
> > > > 0 bytes copied, 0.000358246 s, 0.0 kB/s
> > > > $ ls -l testfile
> > > > -rw-rw-r-- 1 trini trini 512 Dec 21 18:07 testfile
> > > > $ hexdump testfile | tail -n2
> > > > 00001f0 8cdd 300e 0000 0000 0000 0000 0000 0000
> > > > 0000200
> > >=20
> > > That works here as well.
> >=20
> > Great, thanks!
>=20
> dd also has also has the conv=3Dsync option, at least on Linux:
>=20
> dd if=3D/dev/urandom bs=3D1 count=3D20 of=3Dtestfile
>=20
> dd if=3Dtestfile bs=3D8 conv=3Dsync of=3Dtestfile_pad

I spun up a test FreeBSD instance and this also worked as expected. Mark
can you confirm OpenBSD also works as expected here? It would be good to
fix this long running problem. Thanks!

>=20
> Thanks
>=20
> Michal

--=20
Tom

--JqqHSjZdGMPRHZXM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeZVxsACgkQFHw5/5Y0
tywXeQv9H3lfrl/WA4746KoAypWE0660d6MJjqbqzOJ5EpH2I7bHFozy/adklDcp
dYaOQuIpKgpuT9/quc8YFiwngf35lROG4/x3sfrjA53ZNaiS0eRIcl3pXipR4KmF
8ILh5mK8vc6+Kad5M7/KJkDGBGKjQr1MkDqnTNuicxo+fXr1GiKG6awn4gsXOF1Z
6DmdVTOLRmZ2rmOqL9RSD+30g3PiQElIYEU6175NXbTmXOHYeanE+lkQ21mLoAom
aexoVllTfTPKA1sGOGlQ1OV2oyAB1vsIu37Q6z1dlOBwn4BqzprW21Cml+s8ucPq
xX50Y4WjKDZ8RHCUNVLuhhHYhSJlieOCaEJzrUfeO47s9xvOd3PTbSOnon8FssXh
S7W9xdUrdOAL09ctBjMjjXredDPbhHqHfOzOFE7VdbttGWktVHWkdp1nHEHGUc/s
psal0k99HH6WEa8JZ5f0pnUVZ4P+OkjTCtU0THlUHdS0zCHs05+D9ncrqx1E7MKA
8d7G8NV4
=ayPY
-----END PGP SIGNATURE-----

--JqqHSjZdGMPRHZXM--
