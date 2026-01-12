Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE23DCF45D2
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 22:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ECFE83759;
	Mon, 12 Jan 2026 23:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rosRZc49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0455A8389A; Mon, 12 Jan 2026 23:05:43 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 752D2836A3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 23:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7c750b10e14so2966887a34.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 14:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768255539; x=1768860339; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S/eOviey+AoqmocAyVveNHGAlveCip87qNef9SgaWug=;
 b=rosRZc49FnYSMjdpQYvGkzyeTgRzJW06WXejuOGvKLD96YidooRLTGCaPxTT5D8Y85
 0n9V3UTYmw1b7Q4BIJvRBQmHMr3JjSHzP+gRtK/DbUfY63+JPDNUaxP2yGxL9/nHwzCh
 jfcdnXWKTRQvrbrW5ZefHGhw4YjtMjQpmN7dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768255539; x=1768860339;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S/eOviey+AoqmocAyVveNHGAlveCip87qNef9SgaWug=;
 b=r+kB90i0I85UoYbql3IKGKujrzUjT5lqTyTuMNtkunSuC00Rwq1JayxtGr3d+kDvn/
 M7TCt93qXAIquzIi3xs6pMlNq5ke1mWbLsbfoQn1K0cnX0I3RdxUXJcgrnMtatzy+ymF
 xP12lLzODFsm59P8ftyvdrXTwRiob3e0ABfaKDYEq8mJWwCVqWGOnP2qQW4kf7IrRTVU
 hcdrCkn9x+tJkQH/kbdsWzW2ZFb1aNhBDOkox2mLtPBNeEBPL0VI9kYWAX7W0IZdO1Up
 w+ByJRki7j6Inukm36xcYAQvbp7MZxZdNT2sXSc0al1f8Z7o4jqSfWkeHY1w3DRz/CKv
 MB1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwtQ86DaesZ+C8lEMQKXhJOzENuCRP8TKn6leSGUwvTYgAzZC1AcvnMLALai4fRf5wBlZAmYs=@lists.denx.de
X-Gm-Message-State: AOJu0YzRsMvDQ6gkXczddf3RR3ztZDRnkY/v7rd/XBq5Qewel5bZ675k
 wFunR4cwUx93cplCnz4UHU8zSjNeFNjRh8PzaDbKKi9ZXD/DKxsK61AhAEQBKo7Nd8k=
X-Gm-Gg: AY/fxX4ZiioeIVer02+6KjDw6wWRz3zcBZ0YvLpaK6l+S0YODgN/sq9zRbDVQWUIp3s
 OXde853DjsWLTYqFmcmbI5fBzmrgFltpfwejmLOu/YsOoYE5kS5Rtem3ZRbru9KayXCkHpHo3yg
 GbaQgnXpA+mJLUVv5g4EOiL8+o38++K1R01WyCgmv3bp+7lcPU+I0tUR+YKxHEO+uF3Zzd2SoKn
 FZAkF+MWeNP+7pCONmYRDZjaKpu4V1TEd/AdvI2H3p4k42XcIpoP1xQkSOz0qUaxh4NORZwO8I9
 3pNPRUwXOuVT0L7DcJelZhMidY6BcqOwShOZ3n2T0p2/WdayB0TjVU4JKdsiGEaOXBwrAgHBYs2
 NL+6iCJ0ek1o6D49MB6jyo3//8i+BqNgg+JclkEKLbY4oUzfrHwBuKvAgutz//GngIh8Xj1a90T
 EeDQSvBiMbnOfv9T2NzCt/BYH91tmJUVSR0gzr5HqRktdwVFy2smeVI+56ykDs3l5YrObA5wXkS
 S5c0bb8fNq7uD6sqC+ql9tTGYRwVps1D11oIgA=
X-Google-Smtp-Source: AGHT+IE+LfW/NFPjcVBmmvKPtXTGoAAOImUR1mqYSv7hLBBhLvGO2/zQwYGEb1pXKDV9cBCyJ7cpjQ==
X-Received: by 2002:a05:6808:3448:b0:44f:ff2c:f65 with SMTP id
 5614622812f47-45a6beb9a33mr8705851b6e.38.1768255539156; 
 Mon, 12 Jan 2026 14:05:39 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478af8b2sm13437094a34.15.2026.01.12.14.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 14:05:38 -0800 (PST)
Date: Mon, 12 Jan 2026 16:05:36 -0600
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
Message-ID: <20260112220536.GU3416603@bill-the-cat>
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-3-b-padhi@ti.com>
 <DFMMUHPP8BW8.3M5VVTPEB9IZL@ti.com>
 <20260112164854.GQ3416603@bill-the-cat>
 <8eb4eeea-a755-4032-ab95-2b293f2d2289@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wv59pJTz+vFhBF3V"
Content-Disposition: inline
In-Reply-To: <8eb4eeea-a755-4032-ab95-2b293f2d2289@mailbox.org>
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


--wv59pJTz+vFhBF3V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 10:56:04PM +0100, Marek Vasut wrote:
> On 1/12/26 5:48 PM, Tom Rini wrote:
> > On Mon, Jan 12, 2026 at 06:38:19PM +0530, Anshul Dalal wrote:
> > > On Mon Jan 12, 2026 at 3:41 PM IST, Beleswar Padhi wrote:
> > > > The OMAP2 SPL linker script (also used for K3 platforms) currently =
uses
> > > > a 4-byte alignment directive after the __u_boot_list section. This
> > > > alignment directive only advances the location counter without padd=
ing
> > > > the actual binary output.
> > > >=20
> > > > When objcopy extracts u-boot-spl-nodtb.bin, it includes only actual
> > > > data, stopping at the last byte of __u_boot_list (e.g., 0x41c359fc),
> > > > not an aligned address (e.g., 0x41c35a00). So, when the FIT image
> > > > containing device trees is concatenated to the SPL binary, it gets
> > > > appended at this unaligned file size, causing libfdt validation fai=
lure.
> > > >=20
> > > > To fix this, move the alignment directive into the __u_boot_list se=
ction
> > > > itself and make it 8-byte aligned as per DT spec. This forces the l=
inker
> > > > to include padding as part of the section data, ensuring objcopy
> > > > includes the padding bytes in the binary and the appended FIT image
> > > > starts at an 8-byte aligned boundary.
> > > >=20
> > > > Reported-by: Anshul Dalal <anshuld@ti.com>
> > > > Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@t=
i.com
> > > > Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.=
2-35-g52f07dcca47c")
> > > > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > > > ---
> > > > v2: Changelog:
> > > > 1. Get rid of extra ALIGN() directive, replace it with a comment
> > > > 2. Carry Reported-by, Closes and Fixes tag.
> > > >=20
> > > > Link to v1:
> > > > https://lore.kernel.org/all/20260109190026.58464-3-b-padhi@ti.com/
> > > >=20
> > > >   arch/arm/mach-omap2/u-boot-spl.lds | 6 +++++-
> > > >   1 file changed, 5 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach-oma=
p2/u-boot-spl.lds
> > > > index 3bb759d8a1c..5ad169a37b7 100644
> > > > --- a/arch/arm/mach-omap2/u-boot-spl.lds
> > > > +++ b/arch/arm/mach-omap2/u-boot-spl.lds
> > > > @@ -35,9 +35,13 @@ SECTIONS
> > > >   	. =3D ALIGN(4);
> > > >   	__u_boot_list : {
> > > >   		KEEP(*(SORT(__u_boot_list*)));
> > > > +		/*
> > > > +		 * Ensure 8-byte alignment at the end of the last section before
> > > > +		 * DTB is appended, to satisfy DT spec alignment requirements
> > > > +		 */
> > > > +		. =3D ALIGN(8);
> > >=20
> > > I wonder if there could be a better way to handle this constraint,
> > > currently we have two major problems with this approach:
> > >=20
> > > 1. All platforms facing similar alignment issues would have to modify
> > > their linker scripts.
> >=20
> > Yes, agreed.
> >=20
> > > 2. The FDT only gets appended directly to SPL binary in cases of
> > > CONFIG_SPL_SEPARATE_BSS. Otherwise we do (SPL binary + BSS + FDT) as =
per
> > > the $(obj)/$(SPL_BIN)-dtb.bin make target. Which means BSS would have=
 to
> > > be 8-byte aligned as well as the SPL binary.
> > >=20
> > > I wonder if we could have a new make target for say
> > > u-boot-spl-nodtb-aligned.bin which is just (SPL binary + optionally B=
SS
> > > + padding for alignment) and at runtime we modify the fdt addr in gd =
to
> > > point to the correctly aligned address?
> >=20
> > Looking back at
> > https://lore.kernel.org/all/87h65ihumb.fsf@bloch.sibelius.xs4all.nl/ we
> > can use dd as a portable way to ensure that a file ends with 8-byte
> > alignmnent by doing:
> > dd if=3Dtestfile bs=3D8 conv=3Dsync of=3Dtestfile_pad
> > and we get a zero-padded 8-byte aligned output file, and at the end of
> > that we can concatenate our dtb.
> You still need to make sure there is a symbol generated by the linker that
> points at the END of the u-boot binary . dd happens too late, so you cann=
ot
> do that. The alignment has to be done by the linker, in the linker script=
 I
> think.

I guess the question is are we:
a) Look at $sym for device tree, and so $sym must be 8-byte aligned.
b) Look at end of self, rounded up to alignment, for device tree
c) (a) on some platforms (b) on other platforms
?

--=20
Tom

--wv59pJTz+vFhBF3V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWVwMAAKCRAr4qD1Cr/k
CqLDAP99TLzoYWQ6GHPdCb55WH1+lEIHt7X41EMMxxFXEah6AQD9FQw4hr1uP65a
9r7y7ntLMUufDJCjZrCz3dObwjm78Qs=
=I6po
-----END PGP SIGNATURE-----

--wv59pJTz+vFhBF3V--
