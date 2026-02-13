Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63D4EF99E9
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 23:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1974E8367F;
	Sat, 14 Feb 2026 00:22:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P2z1bq2u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8ABD80FA1; Sat, 14 Feb 2026 00:22:56 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00E968367F
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 00:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-463960df4a8so885125b6e.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 15:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771024971; x=1771629771; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O7eAQJW/Z045a5/upqgAvlUWkxtrL8obRE/yBC0od7Q=;
 b=P2z1bq2uSctZ+krTiksd0O4J8DQpbE0WLw6bqxmXeQY2y9jk3sVnvCBpYdg0dmPuHC
 fZWzEck0nwhM7faP7Fc+nuGGqFfEjY4hbOAKISE9YhOc8dJntHDaycPCjd5oFg+D3LqO
 HhDeEz/8+yCFgmTlNgyfGfrrkEftPJ0q50iTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771024971; x=1771629771;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7eAQJW/Z045a5/upqgAvlUWkxtrL8obRE/yBC0od7Q=;
 b=dRtF/gpyt8ias78CdHXkoCfwxIWyBNnCk4LMRT5DYvCe3Br6RQXCoc726W8gEXa6UI
 Y8kNv4k6Q5suMLaA2xCjeVpPmiiruPaeg7x/iSBhNY6SoGgXAdB5ezOQbnHzrptj4vfz
 3W0YwWEcVvjnrqOn0szbvjl2w+/Cv+DtDmgPPuX+eJMw3tp5d+wVYKdCE8+sli5+Zr1z
 gupM3uJSttmlieVOwDouXi4T8MwZT7mlkWKVvUMEE027zNZ77k8YQQNKmRvwXg9/ZUPh
 vwwEu/bvbo6UzsiviWIjqUa3h0iKb4WnVjbRKEpNRECODdwrC3EfTP+3ZeZkQlGGt9lE
 6GDw==
X-Gm-Message-State: AOJu0YwZLiRONSSesyNCIZDU6QTMd3x/jihxuvfwr/X825qUFTdSMosJ
 iWI1Rjn/N+R8iXzddERqm69wG0BgVr8ZgwoXDsu1LmmcdwsMk9vahkHSkM38ccweIdM=
X-Gm-Gg: AZuq6aKgY0pnLGgnfJGQUwwjiJ/qIsO/RVrsycDRK8PZDykxRxtAT06eInO9GyRFwz1
 M8iu74qX+AaSLaA/8nCpwABww+Ur2lI9nCTq9djLlCKipjp8q++WFSl11Z9xr0q/PU7RA99thtl
 eVCAMPRRt9ZF7sV/mD+6CQRePRO4I3PlEp4m4zylNhr2/nH+BysPw8B/t4o5wXZM8N6adhoaHTM
 V9UDdafZdzRCiUfQjiQCEp2LYB/R9Na9U5pZFXVvPvKyEMe0/oLRsseh5zyLZzUVYTewVj+hXw6
 Tf/eAo/G2qPt65FqkNxLq5ZLlE0c6VT/04WE306f75xVv4XgH0iiCpQLx0ROi7XOZVwLX6NBJLv
 Hywzvte/Dv49oXOXjdhuhgEehQTvE3mWiEQGumQtl2sA6GZavDUkF1Zk+wOuF1JJOrFceH4Yoyx
 U/dPiN/HGPTcWh1jJf4rkhDA/No7wLGrtWTF3JPvS3OQG8z+v1xoQJ8dyqxKUo7zF9lfqpUv2qF
 HkE007addM7V4C/tpxBWRP3bTNuHG5+y5PxDCJy2vWLGO6h8z8=
X-Received: by 2002:a05:6808:2221:b0:463:8af4:73e9 with SMTP id
 5614622812f47-4639ef535d7mr1944031b6e.28.1771024971515; 
 Fri, 13 Feb 2026 15:22:51 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636b064cd5sm5661858b6e.10.2026.02.13.15.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 15:22:50 -0800 (PST)
Date: Fri, 13 Feb 2026 17:22:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Jeremy Compostella <jeremy.compostella@intel.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] x86/coreboot: Exclude memory regions starting above 4GB
Message-ID: <20260213232246.GO2747538@bill-the-cat>
References: <87qzr1z0tf.fsf@jcompost-mobl.amr.corp.intel.com>
 <87a4xnuljz.fsf@jcompost-mobl.amr.corp.intel.com>
 <20260206015056.GO2603314@bill-the-cat>
 <87o6m16d9b.fsf@jcompost-mobl.amr.corp.intel.com>
 <87fr74gs4t.fsf@jcompost-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d36nYpZsTRHdQjKb"
Content-Disposition: inline
In-Reply-To: <87fr74gs4t.fsf@jcompost-mobl.amr.corp.intel.com>
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


--d36nYpZsTRHdQjKb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 04:06:58PM -0700, Jeremy Compostella wrote:

> Hi,
>=20
> Is there any update on this commit?

I'll be putting it in master for v2026.04 sometime next week.

>=20
> Jeremy Compostella <jeremy.compostella@intel.com> writes:
>=20
> > Tom Rini <trini@konsulko.com> writes:
> >
> >> On Thu, Feb 05, 2026 at 10:50:24AM -0700, Jeremy Compostella wrote:
> >>
> >>> Is there anything more I should be doing? This is a bug fix I would
> >>> really appreciate seeing merged.
> >>
> >> It would be nice if someone else reviewed it. It's also been a day sin=
ce
> >> posting. I'll put it in my list to make sure doesn't get lost for the
> >> next release, thanks.
> >
> > Thank you for looking into this. It would indeed help if someone else c=
ould review it.
> >
> >>> Jeremy Compostella <jeremy.compostella@intel.com> writes:
> >>>=20
> >>> > This commit updates the RAM region filtering logic in
> >>> > board_get_usable_ram_top() to skip any memory regions whose start a=
ddress
> >>> > is above 4GB. Previously, only the end address was capped at 4GB, b=
ut
> >>> > regions entirely above this threshold were still considered.
> >>> >
> >>> > Typically, the following memory map entries would cause
> >>> > board_get_usable_ram_top() to return 0x100000000, which is incorrec=
t.
> >>> >
> >>> >     start=3D00000000, end=3D00001000, type=3D16
> >>> >     start=3D00001000, end=3D000a0000, type=3D1
> >>> >     start=3D000a0000, end=3D000f6000, type=3D2
> >>> >     start=3D000f6000, end=3D000f7000, type=3D16
> >>> >     start=3D000f7000, end=3D00100000, type=3D2
> >>> >     start=3D00100000, end=3D6f170000, type=3D1
> >>> >     start=3D6f170000, end=3D70000000, type=3D16
> >>> >     start=3D70000000, end=3D80800000, type=3D2
> >>> >     start=3De0000000, end=3Df8000000, type=3D2
> >>> >     start=3Dfa000000, end=3Dfc000000, type=3D2
> >>> >     start=3Dfc800000, end=3Dfc880000, type=3D2
> >>> >     start=3Dfd800000, end=3Dfe800000, type=3D2
> >>> >     start=3Dfeb00000, end=3Dfeb80000, type=3D2
> >>> >     start=3Dfec00000, end=3Dfed00000, type=3D2
> >>> >     start=3Dfed20000, end=3Dfed80000, type=3D2
> >>> >     start=3Dfeda1000, end=3Dfeda2000, type=3D2
> >>> >     start=3Dfedc0000, end=3Dfede0000, type=3D2
> >>> >     start=3D100000000, end=3D102400000, type=3D2
> >>> >     start=3D102400000, end=3D47f800000, type=3D1
> >>> >     start=3D4000000000, end=3D4020000000, type=3D2
> >>> >
> >>> > By adding a check to continue the loop if the region's start address
> >>> > exceeds 0xffffffffULL, the function now properly ignores regions th=
at are
> >>> > not usable in 32-bit address space.
> >>> >
> >>> > Change-Id: I8cbe0281aeea67a2f5bb9f6669456f5c7df9b409
> >>> > Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
> >>> > ---
> >>> >  arch/x86/cpu/coreboot/sdram.c | 2 ++
> >>> >  1 file changed, 2 insertions(+)
> >>> >
> >>> > diff --git a/arch/x86/cpu/coreboot/sdram.c b/arch/x86/cpu/coreboot/=
sdram.c
> >>> > index 013225f129a..cc1edd7badd 100644
> >>> > --- a/arch/x86/cpu/coreboot/sdram.c
> >>> > +++ b/arch/x86/cpu/coreboot/sdram.c
> >>> > @@ -42,6 +42,8 @@ phys_addr_t board_get_usable_ram_top(phys_size_t =
total_size)
> >>> >  			continue;
> >>> > =20
> >>> >  		/* Filter memory over 4GB. */
> >>> > +		if (start > 0xffffffffULL)
> >>> > +			continue;
> >>> >  		if (end > 0xffffffffULL)
> >>> >  			end =3D 0x100000000ULL;
> >>> >  		/* Skip this region if it's too small. */
> >>>=20
> >>> --=20
> >>> Jeremy
> >>> One Emacs to rule them all
>=20
> --=20
> Jeremy
> One Emacs to rule them all


--=20
Tom

--d36nYpZsTRHdQjKb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaY+yQgAKCRAr4qD1Cr/k
CjMZAP9rsP8Q8QvnoHOMFjbWrT4bnkQg4rBf569FEt5vPXdkGQD8CSmV5/bSsJyk
2VPG7f1gss47vBuvx3Cs+goPp0EiCQQ=
=mOo/
-----END PGP SIGNATURE-----

--d36nYpZsTRHdQjKb--
