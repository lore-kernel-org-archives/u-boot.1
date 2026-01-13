Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5A5D2D117
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 15:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88E2C800B6;
	Tue, 13 Jan 2026 16:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UEox77t4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73C1A800B6; Tue, 13 Jan 2026 16:00:31 +0100 (CET)
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D29F880050
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 16:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc41.google.com with SMTP id
 006d021491bc7-65ecd7fcf36so4378039eaf.1
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 07:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768316427; x=1768921227; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dz9PYo/MGGXV7NNQ0jdVKX4i0gzyJRipy/L9ZPfCeWQ=;
 b=UEox77t4HZL9k2KdNZiz2ZIOd1ShraufydpKhAdqC7xpCWvgwjI1+Zupk1j+6XfnQe
 3rpUPDh2DdbSt7xpX0O6t0um0E+G1ewnWZTUCqm8pmUUEGHpxAO94wyhNX4dOWLbhhPu
 O1OCmrCiOFSATchQBTy2W8/R5nWH6FioL8hYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768316427; x=1768921227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dz9PYo/MGGXV7NNQ0jdVKX4i0gzyJRipy/L9ZPfCeWQ=;
 b=bLgYUAb0vYZhVc9sT6oAb+ipnT0nQbIyBY3tI669LkMKDgL+aadeGPejKhI9G7TrYW
 4svUBavZJ+tq4p7j7C2YMTdVE0HsG3UWeYyI0D76N53sd3sxqlflq5mIWjVuX0ZEpNW7
 5JTPUKEuoMUZQBg8gv9pkmYO1enLUYXnbzgbJ0c9gi4zz4h/xpZAdm2fvZeObHf16ko3
 cwggHZzYrYYAm5sr2DBuumkZPEpJ3J82pOWlFBRUpUOsbO4bcGH257r7PWHKb8QCwtFt
 TTpVvZ1z9hp2zH1r5AD4e976xxCXDFkNMLNVcXFGwvsanTHMdXW0N5qf83+CXNOJHExF
 6MxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW+WTaM2LwFEzj7UywCh8k9+lmu6x3atlIY2SKu9Zc6RT4xEx4ZCGZP6goRkQsIfm36tmZueU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxeim2EFF+zlx1QQXuHFt9pFxQpjkIOdyTibNDGvgLg5TSHZQU4
 K5sQ3NYzhHWms/h9xNnhk52g9PPyYbhnTZTvLLvX0fqqWzefRdiTglY62uJgLmGDquc=
X-Gm-Gg: AY/fxX4NUXGqyK8KRB7HL75/ycqcXlRsfOLxTBYJJJggQgaWLrVq4WngKphAZ9ze0le
 1BY5HYzJhNZajj4rNeuB2D0blaAsSdFSIt40CVMlb9LPSGyqnM7V0heP/uURItz+hEwXHDDnACK
 fda+xF67J514lPsVMXo4cscoCkpLLM7SWbrUop5wXQ56jduTgqUMUJtb7whbQhYULsd1GACEV3t
 5ve5FBAMDTKFg0pP04bw0tMU+sFUYCsE401mf5vNL5AmoDvWhDSXxy07t2Gwe/C5Bix15Ywn2ia
 RdMATVgF+B6LLrI/kmkQ21wgepvn9bvS0MT0CbgyAvdcPEcJMZ9FpqP7Mf3xYsWRDLyGLZssR8S
 a1I/zglqY4Tzub2ARnPKPtjrihUoRJcc/0M53cRXMS8VM1zL2sIYx3/i19q5LpP2vt9wE8nbTov
 7j0iMhWAm42TNRvSzfo0X+G6LwCX3irTu1W7q9/ISvRRKFLXPMcNfQXMhurni1fNylQucfwfAuM
 FvMUZdTNvMMB7TH1Ez8WsoGjl2iSRKQkQohOOY=
X-Google-Smtp-Source: AGHT+IEXwsfcpmgLkuSCFZf9Gyf5hh5ugbWJomGMEljh04IVBvuFHPGdYvSwOKlMjaBpkwsIcVcsYg==
X-Received: by 2002:a05:6820:1ca3:b0:65f:706c:72f2 with SMTP id
 006d021491bc7-65f706c7437mr4479606eaf.37.1768316427322; 
 Tue, 13 Jan 2026 07:00:27 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48cb03d4sm8906387eaf.12.2026.01.13.07.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 07:00:26 -0800 (PST)
Date: Tue, 13 Jan 2026 09:00:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Anshul Dalal <anshuld@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com,
 afd@ti.com, nm@ti.com, vigneshr@ti.com, n-francis@ti.com,
 u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment
 before DTB
Message-ID: <20260113150024.GX3416603@bill-the-cat>
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-3-b-padhi@ti.com>
 <DFMMUHPP8BW8.3M5VVTPEB9IZL@ti.com>
 <20260112164854.GQ3416603@bill-the-cat>
 <8eb4eeea-a755-4032-ab95-2b293f2d2289@mailbox.org>
 <20260112220536.GU3416603@bill-the-cat>
 <66ec9e5b-1488-4e35-9a56-91d4b70ff0fa@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XfxsQdOpC8sjQpc6"
Content-Disposition: inline
In-Reply-To: <66ec9e5b-1488-4e35-9a56-91d4b70ff0fa@mailbox.org>
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


--XfxsQdOpC8sjQpc6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 12:56:23AM +0100, Marek Vasut wrote:
> On 1/12/26 11:05 PM, Tom Rini wrote:
> > On Mon, Jan 12, 2026 at 10:56:04PM +0100, Marek Vasut wrote:
> > > On 1/12/26 5:48 PM, Tom Rini wrote:
> > > > On Mon, Jan 12, 2026 at 06:38:19PM +0530, Anshul Dalal wrote:
> > > > > On Mon Jan 12, 2026 at 3:41 PM IST, Beleswar Padhi wrote:
> > > > > > The OMAP2 SPL linker script (also used for K3 platforms) curren=
tly uses
> > > > > > a 4-byte alignment directive after the __u_boot_list section. T=
his
> > > > > > alignment directive only advances the location counter without =
padding
> > > > > > the actual binary output.
> > > > > >=20
> > > > > > When objcopy extracts u-boot-spl-nodtb.bin, it includes only ac=
tual
> > > > > > data, stopping at the last byte of __u_boot_list (e.g., 0x41c35=
9fc),
> > > > > > not an aligned address (e.g., 0x41c35a00). So, when the FIT ima=
ge
> > > > > > containing device trees is concatenated to the SPL binary, it g=
ets
> > > > > > appended at this unaligned file size, causing libfdt validation=
 failure.
> > > > > >=20
> > > > > > To fix this, move the alignment directive into the __u_boot_lis=
t section
> > > > > > itself and make it 8-byte aligned as per DT spec. This forces t=
he linker
> > > > > > to include padding as part of the section data, ensuring objcopy
> > > > > > includes the padding bytes in the binary and the appended FIT i=
mage
> > > > > > starts at an 8-byte aligned boundary.
> > > > > >=20
> > > > > > Reported-by: Anshul Dalal <anshuld@ti.com>
> > > > > > Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO1=
9E@ti.com
> > > > > > Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v=
1.7.2-35-g52f07dcca47c")
> > > > > > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > > > > > ---
> > > > > > v2: Changelog:
> > > > > > 1. Get rid of extra ALIGN() directive, replace it with a comment
> > > > > > 2. Carry Reported-by, Closes and Fixes tag.
> > > > > >=20
> > > > > > Link to v1:
> > > > > > https://lore.kernel.org/all/20260109190026.58464-3-b-padhi@ti.c=
om/
> > > > > >=20
> > > > > >    arch/arm/mach-omap2/u-boot-spl.lds | 6 +++++-
> > > > > >    1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > >=20
> > > > > > diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach=
-omap2/u-boot-spl.lds
> > > > > > index 3bb759d8a1c..5ad169a37b7 100644
> > > > > > --- a/arch/arm/mach-omap2/u-boot-spl.lds
> > > > > > +++ b/arch/arm/mach-omap2/u-boot-spl.lds
> > > > > > @@ -35,9 +35,13 @@ SECTIONS
> > > > > >    	. =3D ALIGN(4);
> > > > > >    	__u_boot_list : {
> > > > > >    		KEEP(*(SORT(__u_boot_list*)));
> > > > > > +		/*
> > > > > > +		 * Ensure 8-byte alignment at the end of the last section be=
fore
> > > > > > +		 * DTB is appended, to satisfy DT spec alignment requirements
> > > > > > +		 */
> > > > > > +		. =3D ALIGN(8);
> > > > >=20
> > > > > I wonder if there could be a better way to handle this constraint,
> > > > > currently we have two major problems with this approach:
> > > > >=20
> > > > > 1. All platforms facing similar alignment issues would have to mo=
dify
> > > > > their linker scripts.
> > > >=20
> > > > Yes, agreed.
> > > >=20
> > > > > 2. The FDT only gets appended directly to SPL binary in cases of
> > > > > CONFIG_SPL_SEPARATE_BSS. Otherwise we do (SPL binary + BSS + FDT)=
 as per
> > > > > the $(obj)/$(SPL_BIN)-dtb.bin make target. Which means BSS would =
have to
> > > > > be 8-byte aligned as well as the SPL binary.
> > > > >=20
> > > > > I wonder if we could have a new make target for say
> > > > > u-boot-spl-nodtb-aligned.bin which is just (SPL binary + optional=
ly BSS
> > > > > + padding for alignment) and at runtime we modify the fdt addr in=
 gd to
> > > > > point to the correctly aligned address?
> > > >=20
> > > > Looking back at
> > > > https://lore.kernel.org/all/87h65ihumb.fsf@bloch.sibelius.xs4all.nl=
/ we
> > > > can use dd as a portable way to ensure that a file ends with 8-byte
> > > > alignmnent by doing:
> > > > dd if=3Dtestfile bs=3D8 conv=3Dsync of=3Dtestfile_pad
> > > > and we get a zero-padded 8-byte aligned output file, and at the end=
 of
> > > > that we can concatenate our dtb.
> > > You still need to make sure there is a symbol generated by the linker=
 that
> > > points at the END of the u-boot binary . dd happens too late, so you =
cannot
> > > do that. The alignment has to be done by the linker, in the linker sc=
ript I
> > > think.
> >=20
> > I guess the question is are we:
> > a) Look at $sym for device tree, and so $sym must be 8-byte aligned.
> > b) Look at end of self, rounded up to alignment, for device tree
> > c) (a) on some platforms (b) on other platforms
> > ?
> $sym is at the end, which is not always 8 byte aligned . See lib/fdtdec.c
> for the relevant code:
>=20
> 1243 static void *fdt_find_separate(void)
> 1244 {
> 1245         void *fdt_blob =3D NULL;
> 1246
> 1247         if (IS_ENABLED(CONFIG_SANDBOX))
> 1248                 return NULL;
> 1249
> 1250 #ifdef CONFIG_XPL_BUILD
> 1251         /* FDT is at end of BSS unless it is in a different memory
> region */
> 1252         if (CONFIG_IS_ENABLED(SEPARATE_BSS))
> 1253                 fdt_blob =3D (ulong *)_image_binary_end;
> 1254         else
> 1255                 fdt_blob =3D (ulong *)__bss_end;

OK. And why can't we make that check at $sym rounded up, and ensure our
build targets pad? Going back to the commit message here, it's easy to
tell the linker to place $sym at the right spot, but it's hard to make
sure the output is padded. So having typed all that, maybe we need to
do:
d) Update linker scripts to ALIGN(8) the above symbols and have the make
targets use dd to ensure padding prior to concatenation
?

--=20
Tom

--XfxsQdOpC8sjQpc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWZeBwAKCRAr4qD1Cr/k
CoehAP9vTP1VPhnFATr0dDq9v07xDttMyWL23uyrTc9+XiB/lAEAsmtmdRFMYFvk
ku2mMjXbiYySuNJheiy5zZLmFXrAqAQ=
=ucd6
-----END PGP SIGNATURE-----

--XfxsQdOpC8sjQpc6--
