Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A5AD2F35C
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 19:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD71F800AB;
	Tue, 13 Jan 2026 20:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MGU3dtUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB552800AE; Tue, 13 Jan 2026 20:45:12 +0100 (CET)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF5CA80081
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 20:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-450b5338459so4982388b6e.2
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768333508; x=1768938308; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+nC8ZQFsG5zAyOALkI0bTs/0bRXyFXe2iiyzv3bDJx4=;
 b=MGU3dtUHz3TslWz9Dj6fkvIDaFH11OZFcsyYWflBoD29D+ok0YA1Lg26eNB19cWOaN
 zT/iqpxcxJXSUBBQqP+z9Qm8kUdXhOCbFR7vUUkVzazoRLo2Cffnm8SWHmkKUna985EG
 RPClWkCQOzKSrmcxD9Vqevxlxry7ja82ohvUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768333508; x=1768938308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+nC8ZQFsG5zAyOALkI0bTs/0bRXyFXe2iiyzv3bDJx4=;
 b=BkC/WIAsustc2h4oFKfjJVOULeLDCmK/17Y07LMCdasF1Q/mWxeEScLehGdwupDs1w
 /CD+cRNlym6yL14PbsD5d0xvvlTEEuBNOgrZ37hz9wk62vIh1Oj9EDxHOr8vT/T+IDiU
 5rHMlpuDnEctDF1IK/xJNeNlt6SSRjp8Ccl+NQ/jVaB0/nIGky9kKaf/nZEHUPREhHtP
 HfBaLpJ/UkMeo6rVehhoyvjaSYp0eN3t9NsGnDXi0qeCkwLQpdNCPyoq04YJJOVbeFjs
 CzJsrLPzUnn0+QiDvSPsQqCW3EPBOqsu9u6QygKbrnWyFkLz+NTwT5T0N1mwAjY/QeKv
 3J2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGQZWVWhphPh8cIrXbuPGN/FOdsvmuZfe+2Trg/aaqIrnCydutzr+gCnmtuZqlVx7bFkSBNlI=@lists.denx.de
X-Gm-Message-State: AOJu0YyjqjYlDb7f+HCT1EUxp5u9vkeb14d5GYgodXmnysvhOBdP7TVz
 9AclJWhAZj0LajMJTSwl0dgT08hTA91c9vqImO1tTdfpvaqwqvyiUwvQhO6Y/hS8WA4=
X-Gm-Gg: AY/fxX4p6FFNVPca7YNM4rT0/gayHleHOC/bC6EgC/o/uFKfu8WaBUWCQY9GbPNeVyx
 DCGUgXnlbSnFLCv32p1HOh+TdXC/4utNGznUxSCvBFmbaY6JWznuVnR4AkOuJuqPgwKuKt3yT2u
 NjdjUDgQqgiTbesyAcLocm+XbwwORWFRS1X9Yi6ctWtae40Kgbot6IIVydRYDCaigyPJ6V1nh6o
 qoq4mCcWW7HNph7D/arQXvhnwboWqfv3KjxPwoB9Xyw+X7IElnNUHzZVd0XOGfu4BLGVPnDejkb
 6vGmgN1QvNj4/Zrmz374bkFZOzRHD6iZqb7VJw/o3ismcthgt9SmlLZ+cT4vLIuf5rsVHYTWL8H
 NnW0hcPCPo4iCeNiFDgL62hIr1VFzA7TTxEbkK44Eq/UFsJbp3yTkcsHw5mOS/RuIZfVx/ZV5qE
 57rIqvyrLfv1hPj4WaUvGFgM0AxvFCQElgUEMUFLIJ3m08Kssjly/KwJ/eSeaDdCjiAXBjbQehk
 xcyt9oDl4cNO5IBtuw/DmBEagL7DqC06Bka+yw=
X-Received: by 2002:a05:6808:3847:b0:450:b8da:b80e with SMTP id
 5614622812f47-45c7140f238mr81150b6e.2.1768333507657; 
 Tue, 13 Jan 2026 11:45:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e183cd4sm9817915b6e.1.2026.01.13.11.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 11:45:07 -0800 (PST)
Date: Tue, 13 Jan 2026 13:45:04 -0600
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
Message-ID: <20260113194504.GZ3416603@bill-the-cat>
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-3-b-padhi@ti.com>
 <DFMMUHPP8BW8.3M5VVTPEB9IZL@ti.com>
 <20260112164854.GQ3416603@bill-the-cat>
 <8eb4eeea-a755-4032-ab95-2b293f2d2289@mailbox.org>
 <20260112220536.GU3416603@bill-the-cat>
 <66ec9e5b-1488-4e35-9a56-91d4b70ff0fa@mailbox.org>
 <20260113150024.GX3416603@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MLtV0Lbj09yuQi/s"
Content-Disposition: inline
In-Reply-To: <20260113150024.GX3416603@bill-the-cat>
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


--MLtV0Lbj09yuQi/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 09:00:24AM -0600, Tom Rini wrote:
> On Tue, Jan 13, 2026 at 12:56:23AM +0100, Marek Vasut wrote:
> > On 1/12/26 11:05 PM, Tom Rini wrote:
> > > On Mon, Jan 12, 2026 at 10:56:04PM +0100, Marek Vasut wrote:
> > > > On 1/12/26 5:48 PM, Tom Rini wrote:
> > > > > On Mon, Jan 12, 2026 at 06:38:19PM +0530, Anshul Dalal wrote:
> > > > > > On Mon Jan 12, 2026 at 3:41 PM IST, Beleswar Padhi wrote:
> > > > > > > The OMAP2 SPL linker script (also used for K3 platforms) curr=
ently uses
> > > > > > > a 4-byte alignment directive after the __u_boot_list section.=
 This
> > > > > > > alignment directive only advances the location counter withou=
t padding
> > > > > > > the actual binary output.
> > > > > > >=20
> > > > > > > When objcopy extracts u-boot-spl-nodtb.bin, it includes only =
actual
> > > > > > > data, stopping at the last byte of __u_boot_list (e.g., 0x41c=
359fc),
> > > > > > > not an aligned address (e.g., 0x41c35a00). So, when the FIT i=
mage
> > > > > > > containing device trees is concatenated to the SPL binary, it=
 gets
> > > > > > > appended at this unaligned file size, causing libfdt validati=
on failure.
> > > > > > >=20
> > > > > > > To fix this, move the alignment directive into the __u_boot_l=
ist section
> > > > > > > itself and make it 8-byte aligned as per DT spec. This forces=
 the linker
> > > > > > > to include padding as part of the section data, ensuring objc=
opy
> > > > > > > includes the padding bytes in the binary and the appended FIT=
 image
> > > > > > > starts at an 8-byte aligned boundary.
> > > > > > >=20
> > > > > > > Reported-by: Anshul Dalal <anshuld@ti.com>
> > > > > > > Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16Z=
O19E@ti.com
> > > > > > > Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version=
 v1.7.2-35-g52f07dcca47c")
> > > > > > > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > > > > > > ---
> > > > > > > v2: Changelog:
> > > > > > > 1. Get rid of extra ALIGN() directive, replace it with a comm=
ent
> > > > > > > 2. Carry Reported-by, Closes and Fixes tag.
> > > > > > >=20
> > > > > > > Link to v1:
> > > > > > > https://lore.kernel.org/all/20260109190026.58464-3-b-padhi@ti=
=2Ecom/
> > > > > > >=20
> > > > > > >    arch/arm/mach-omap2/u-boot-spl.lds | 6 +++++-
> > > > > > >    1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > > >=20
> > > > > > > diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/ma=
ch-omap2/u-boot-spl.lds
> > > > > > > index 3bb759d8a1c..5ad169a37b7 100644
> > > > > > > --- a/arch/arm/mach-omap2/u-boot-spl.lds
> > > > > > > +++ b/arch/arm/mach-omap2/u-boot-spl.lds
> > > > > > > @@ -35,9 +35,13 @@ SECTIONS
> > > > > > >    	. =3D ALIGN(4);
> > > > > > >    	__u_boot_list : {
> > > > > > >    		KEEP(*(SORT(__u_boot_list*)));
> > > > > > > +		/*
> > > > > > > +		 * Ensure 8-byte alignment at the end of the last section =
before
> > > > > > > +		 * DTB is appended, to satisfy DT spec alignment requireme=
nts
> > > > > > > +		 */
> > > > > > > +		. =3D ALIGN(8);
> > > > > >=20
> > > > > > I wonder if there could be a better way to handle this constrai=
nt,
> > > > > > currently we have two major problems with this approach:
> > > > > >=20
> > > > > > 1. All platforms facing similar alignment issues would have to =
modify
> > > > > > their linker scripts.
> > > > >=20
> > > > > Yes, agreed.
> > > > >=20
> > > > > > 2. The FDT only gets appended directly to SPL binary in cases of
> > > > > > CONFIG_SPL_SEPARATE_BSS. Otherwise we do (SPL binary + BSS + FD=
T) as per
> > > > > > the $(obj)/$(SPL_BIN)-dtb.bin make target. Which means BSS woul=
d have to
> > > > > > be 8-byte aligned as well as the SPL binary.
> > > > > >=20
> > > > > > I wonder if we could have a new make target for say
> > > > > > u-boot-spl-nodtb-aligned.bin which is just (SPL binary + option=
ally BSS
> > > > > > + padding for alignment) and at runtime we modify the fdt addr =
in gd to
> > > > > > point to the correctly aligned address?
> > > > >=20
> > > > > Looking back at
> > > > > https://lore.kernel.org/all/87h65ihumb.fsf@bloch.sibelius.xs4all.=
nl/ we
> > > > > can use dd as a portable way to ensure that a file ends with 8-by=
te
> > > > > alignmnent by doing:
> > > > > dd if=3Dtestfile bs=3D8 conv=3Dsync of=3Dtestfile_pad
> > > > > and we get a zero-padded 8-byte aligned output file, and at the e=
nd of
> > > > > that we can concatenate our dtb.
> > > > You still need to make sure there is a symbol generated by the link=
er that
> > > > points at the END of the u-boot binary . dd happens too late, so yo=
u cannot
> > > > do that. The alignment has to be done by the linker, in the linker =
script I
> > > > think.
> > >=20
> > > I guess the question is are we:
> > > a) Look at $sym for device tree, and so $sym must be 8-byte aligned.
> > > b) Look at end of self, rounded up to alignment, for device tree
> > > c) (a) on some platforms (b) on other platforms
> > > ?
> > $sym is at the end, which is not always 8 byte aligned . See lib/fdtdec=
=2Ec
> > for the relevant code:
> >=20
> > 1243 static void *fdt_find_separate(void)
> > 1244 {
> > 1245         void *fdt_blob =3D NULL;
> > 1246
> > 1247         if (IS_ENABLED(CONFIG_SANDBOX))
> > 1248                 return NULL;
> > 1249
> > 1250 #ifdef CONFIG_XPL_BUILD
> > 1251         /* FDT is at end of BSS unless it is in a different memory
> > region */
> > 1252         if (CONFIG_IS_ENABLED(SEPARATE_BSS))
> > 1253                 fdt_blob =3D (ulong *)_image_binary_end;
> > 1254         else
> > 1255                 fdt_blob =3D (ulong *)__bss_end;
>=20
> OK. And why can't we make that check at $sym rounded up, and ensure our
> build targets pad? Going back to the commit message here, it's easy to
> tell the linker to place $sym at the right spot, but it's hard to make
> sure the output is padded. So having typed all that, maybe we need to
> do:
> d) Update linker scripts to ALIGN(8) the above symbols and have the make
> targets use dd to ensure padding prior to concatenation
> ?

Now that I've got a target where this issue is cropping up, and I can
easily iterate on testing things, I *think* I was going in the wrong
direction with dd. My inclination right now is to take (very soon)
Beleswar's patch since they figured out the hard part on how to get the
linker to do what we want and follow-up with my own commit cleaning up
the other 12 linker files or so that seem to need a similar change.

--=20
Tom

--MLtV0Lbj09yuQi/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWagvAAKCRAr4qD1Cr/k
CnaUAP9lUItshb3+eS4kiZ6FUy/fuoVs3a8Kc8vK1d1pAc7aTAEA2t5K8kULxt3v
hEyP6pVr4+hXOmAfxsexkqFLR0OMTAM=
=/pft
-----END PGP SIGNATURE-----

--MLtV0Lbj09yuQi/s--
