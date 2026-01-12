Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE052CF45AC
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 16:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DE4483759;
	Mon, 12 Jan 2026 17:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XR2orTos";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 343198382A; Mon, 12 Jan 2026 17:49:02 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8827483693
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 17:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3ed15120e55so4675912fac.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 08:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768236538; x=1768841338; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vIyKQJDOu1uhKQJsqjUYTZdO6AzrEG2UVPwAnJTX02c=;
 b=XR2orTosZueEWmNLiJl8qn50hGm3SdVZYV5kP4SOt4Jv/YE4vtmITPguf71sHITlvb
 mffp2LMTFYiVsAvs625a5woWOOCfCJBNm/KMOSW7ymEkpMJECH18bNTYgqam1b2ztI6c
 y/l/tvlBXk++SHSl/b6rnj3omJEn5zDKcplM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768236538; x=1768841338;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIyKQJDOu1uhKQJsqjUYTZdO6AzrEG2UVPwAnJTX02c=;
 b=IW7k2gZbqBe9P2XF5YirE9D5F12wqHp3uZSoStHoz4uQNfjKBafcMmtVUnywcHjG1A
 N0B7xlxEMRtbxbx4fLu9u+g+qAJDm0OCBQLw3lB8V8jR/5AtjQUXfl5cEKxAQKKiTd2L
 aZGA7/qnSOBd2BJaB7qiieuIL5pvGVBIRJEdWNRhWbZjvKXBJsixgR7NK1a4pW02W6cG
 KfoVntql5oVwyHk0lAMDZxGqSXj6usohaOh9c6T+SwP6Yst3AQ8v9m54bqCFid06UFcm
 vZouTb39PF0y1s9DwzHBqEQ3uZJBIY3gCwoSh9NcI3xRMlzJn1jRphYJO4EFoFF0OPnT
 5Uaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+WUB9YIpgKrpghfcGXNQ3JIHgtILL39UNWLPXPfzFeYE01DkwkrCQE5FWQ4Rrvox9j96dnwo=@lists.denx.de
X-Gm-Message-State: AOJu0YyI0kWGM+mgYtu4/DblvrzHsyu2W0FIQ9Be5ZASqdjvc5WNvId9
 g2SuKMFx8JkUJqoYpJiBI4NdVIfwrQVxu9CWdZMc1oHCXD5BKtBrs5IZ2+7Mi4hUZOA=
X-Gm-Gg: AY/fxX6BY3oyIevgTxQBfLqAzRo4qeK2Cf1yNNLUhso8LC5h5ByEk5a3k9HZJK9OFwE
 uP6L7zxLVNKusv20nOXoON+GnaBGW7lagDcCb7pWaSf/W2uqjXtQHg6fcQWD0p1W5kUlKnA556C
 TlVrn+R/ihOU24fjgdlI/mHSsCl+17BwvQymbmrKiJf6dkC3vlYFpHWaESAXDA/YHETeMLWYsIw
 n2iz2nIVRxDc+cBtw590XKby0C3sBKGpI0GMNW61Cu77cqR9iEO2l+yQz5LmFltlFu1fQVyoaCJ
 opgGLjXSZRrZusTI5/O/Q04sBaTLGE9HhPnrDuKviSDrHRN7NY7k72by4q/8NCj89GQxbCUBdDq
 dE2D2iCmiqjZoPepGRp8HdYlPdlgaydHcDyUme2PT31Tm5sJMnoz2kBrUMmlpYDOtB/LKlomfsG
 IqhaxnSrcFVGphPXD9cljmG+kOJZaTMH5vwtFLOXneZMgHGVVx0r3Nr/EOtAcTD6b9UDEYcmAWe
 x6Mzo/xEGOCdk+jDl2XOj/WMqFUPIH6N46YUcQ=
X-Google-Smtp-Source: AGHT+IH6nPhX67uQSy1r/+332tsjvDvQ22+v0lpWOGRSxZPiZDH8rP8Sa8Mo9FahcdkYutt8QmA8hw==
X-Received: by 2002:a05:6871:79c:b0:3e8:96c0:326b with SMTP id
 586e51a60fabf-3ffc0bd60c2mr8098388fac.49.1768236538004; 
 Mon, 12 Jan 2026 08:48:58 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffbe3a6d8esm10834949fac.15.2026.01.12.08.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 08:48:57 -0800 (PST)
Date: Mon, 12 Jan 2026 10:48:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: Beleswar Padhi <b-padhi@ti.com>, ilias.apalodimas@linaro.org,
 malysagreg@gmail.com, sughosh.ganu@linaro.org,
 philip.molloy@analog.com, marek.vasut+renesas@mailbox.org,
 james.hilliard1@gmail.com, afd@ti.com, nm@ti.com, vigneshr@ti.com,
 n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment
 before DTB
Message-ID: <20260112164854.GQ3416603@bill-the-cat>
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-3-b-padhi@ti.com>
 <DFMMUHPP8BW8.3M5VVTPEB9IZL@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lW5eCSe7iCX9UoFB"
Content-Disposition: inline
In-Reply-To: <DFMMUHPP8BW8.3M5VVTPEB9IZL@ti.com>
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


--lW5eCSe7iCX9UoFB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 06:38:19PM +0530, Anshul Dalal wrote:
> On Mon Jan 12, 2026 at 3:41 PM IST, Beleswar Padhi wrote:
> > The OMAP2 SPL linker script (also used for K3 platforms) currently uses
> > a 4-byte alignment directive after the __u_boot_list section. This
> > alignment directive only advances the location counter without padding
> > the actual binary output.
> >
> > When objcopy extracts u-boot-spl-nodtb.bin, it includes only actual
> > data, stopping at the last byte of __u_boot_list (e.g., 0x41c359fc),
> > not an aligned address (e.g., 0x41c35a00). So, when the FIT image
> > containing device trees is concatenated to the SPL binary, it gets
> > appended at this unaligned file size, causing libfdt validation failure.
> >
> > To fix this, move the alignment directive into the __u_boot_list section
> > itself and make it 8-byte aligned as per DT spec. This forces the linker
> > to include padding as part of the section data, ensuring objcopy
> > includes the padding bytes in the binary and the appended FIT image
> > starts at an 8-byte aligned boundary.
> >
> > Reported-by: Anshul Dalal <anshuld@ti.com>
> > Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
> > Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35=
-g52f07dcca47c")
> > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > ---
> > v2: Changelog:
> > 1. Get rid of extra ALIGN() directive, replace it with a comment
> > 2. Carry Reported-by, Closes and Fixes tag.
> >
> > Link to v1:
> > https://lore.kernel.org/all/20260109190026.58464-3-b-padhi@ti.com/
> >
> >  arch/arm/mach-omap2/u-boot-spl.lds | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach-omap2/u=
-boot-spl.lds
> > index 3bb759d8a1c..5ad169a37b7 100644
> > --- a/arch/arm/mach-omap2/u-boot-spl.lds
> > +++ b/arch/arm/mach-omap2/u-boot-spl.lds
> > @@ -35,9 +35,13 @@ SECTIONS
> >  	. =3D ALIGN(4);
> >  	__u_boot_list : {
> >  		KEEP(*(SORT(__u_boot_list*)));
> > +		/*
> > +		 * Ensure 8-byte alignment at the end of the last section before
> > +		 * DTB is appended, to satisfy DT spec alignment requirements
> > +		 */
> > +		. =3D ALIGN(8);
>=20
> I wonder if there could be a better way to handle this constraint,
> currently we have two major problems with this approach:
>=20
> 1. All platforms facing similar alignment issues would have to modify
> their linker scripts.

Yes, agreed.

> 2. The FDT only gets appended directly to SPL binary in cases of
> CONFIG_SPL_SEPARATE_BSS. Otherwise we do (SPL binary + BSS + FDT) as per
> the $(obj)/$(SPL_BIN)-dtb.bin make target. Which means BSS would have to
> be 8-byte aligned as well as the SPL binary.
>=20
> I wonder if we could have a new make target for say
> u-boot-spl-nodtb-aligned.bin which is just (SPL binary + optionally BSS
> + padding for alignment) and at runtime we modify the fdt addr in gd to
> point to the correctly aligned address?

Looking back at
https://lore.kernel.org/all/87h65ihumb.fsf@bloch.sibelius.xs4all.nl/ we
can use dd as a portable way to ensure that a file ends with 8-byte
alignmnent by doing:
dd if=3Dtestfile bs=3D8 conv=3Dsync of=3Dtestfile_pad
and we get a zero-padded 8-byte aligned output file, and at the end of
that we can concatenate our dtb.

That would just leave the FIT images as the issue, which Marek provided
feedback on in 1/2, yes?

--=20
Tom

--lW5eCSe7iCX9UoFB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWUl9gAKCRAr4qD1Cr/k
CgXlAP0UCJkj1ccDP5Y41xHuLT6pZqtOIsdOQzmUnTwrzASs+AEA1697zoCZTqaT
SFAHJS6gEfYtZSNoVwweG1mgtcisLwg=
=4N9T
-----END PGP SIGNATURE-----

--lW5eCSe7iCX9UoFB--
