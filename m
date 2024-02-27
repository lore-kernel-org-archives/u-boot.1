Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F612C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 18:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D10288009;
	Tue, 27 Feb 2024 19:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jUX2B+/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF678800C; Tue, 27 Feb 2024 19:17:08 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2705387FFF
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 19:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-607eefeea90so392957b3.1
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 10:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709057819; x=1709662619; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X56hsMURy1kCM9rnUtpgDKvDi8LMWyXq4TCMIZ1rvco=;
 b=jUX2B+/J0ZL4TyZGFRzBZpPicjHCKuRGikz8tV+UEAtUSMzi5oBq0KME6fctNLp0U4
 L9nwh7OTtN3v9CsksZEbk2MlvSbWRMm/aBQ3GbIuPGhK3MPHIrWR0726MrICYuTBsT4m
 JuA+5hUV6KvXbv2b0hn9mXYf1VXXtkv5duFtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709057819; x=1709662619;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X56hsMURy1kCM9rnUtpgDKvDi8LMWyXq4TCMIZ1rvco=;
 b=bnO0S5HfDihXtSU19R2EkllpTJJlHyj+Kl2NQYwY+DZWZw/tkwnbeDpjl5MfruhxWu
 plub5C/sVCKbSYZe3dne/1Atphm9drG6cRVBIpWl+OMw4zzSIeoWS5AFFWr7bAHnIHT/
 s746HmxR/Fuvb4ZOWVt+M5RvVDcValOlcTZNAlY4Uqr43Tie5A4IJBIKUlmnQffwppEE
 lQ2DHwqyV3ulUGt7m6OWlq+DUCmEQRCiVvljow7QyveLwcygwXRixkoqZyDoFMNd/odo
 8C0+P5pbf4jLdq3E361iU+DZ8O+e8mnP9eKzniRdDfVzC7tqd5G2LHC1vYqzi9dmLZLl
 SBxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2eGDfeY41foqyB2LeGzC3k4WaqpBiaQFsXlsQYbMpsxfqFtCh1Z/Bz1no8NKj0GH55Fu2NyZr018pdrPsqZWcuCBs3w==
X-Gm-Message-State: AOJu0YzQYpxpeAKiMM/nC17RkakyuGi/Jl28Htb16ouiMCm2t9V6zLGN
 Bgq5mNk+iIPjm45p3BFj6bRn3GRdFkSIIbRlQhjPMeJuv2xwnwWLB+4AbHzX9aM=
X-Google-Smtp-Source: AGHT+IGLnBmC4qzMrQZ3avevxmZHjaSqrGmHIuEBehKCx50T6RDIlCMJkAFuuE5Ra9g9fCBJNAjjQg==
X-Received: by 2002:a81:f109:0:b0:608:b1eb:f631 with SMTP id
 h9-20020a81f109000000b00608b1ebf631mr123963ywm.3.1709057819639; 
 Tue, 27 Feb 2024 10:16:59 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 l18-20020a0de212000000b00608b3bacb09sm1916234ywe.46.2024.02.27.10.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 10:16:58 -0800 (PST)
Date: Tue, 27 Feb 2024 13:16:56 -0500
From: Tom Rini <trini@konsulko.com>
To: Jon Humphreys <j-humphreys@ti.com>
Cc: vigneshr@ti.com, u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 2/2] arm: dts: k3-am642-evm/sk: Enable OSPI support in
 SPL
Message-ID: <20240227181656.GL3040305@bill-the-cat>
References: <20240224001702.2283727-1-j-humphreys@ti.com>
 <20240224001702.2283727-3-j-humphreys@ti.com>
 <20240224135959.GC3040305@bill-the-cat>
 <86o7c5rck3.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7YtsBY4bRDmQsw2j"
Content-Disposition: inline
In-Reply-To: <86o7c5rck3.fsf@udb0321960.dhcp.ti.com>
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


--7YtsBY4bRDmQsw2j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 11:34:36AM -0600, Jon Humphreys wrote:
> Tom Rini <trini@konsulko.com> writes:
>=20
> > On Fri, Feb 23, 2024 at 06:17:02PM -0600, Jonathan Humphreys wrote:
> >> Add bootph DT tags to enable OSPI in SPL.
> >> Set OSPI regs for R5 SPL to address OSPI's boot region.
> >>=20
> >> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> >> ---
> >>  arch/arm/dts/k3-am642-evm-u-boot.dtsi | 16 ++++++++++++++++
> >>  arch/arm/dts/k3-am642-r5-evm.dts      |  5 +++++
> >>  arch/arm/dts/k3-am642-r5-sk.dts       |  5 +++++
> >>  arch/arm/dts/k3-am642-sk-u-boot.dtsi  | 16 ++++++++++++++++
> >>  4 files changed, 42 insertions(+)
> >>=20
> >> diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-a=
m642-evm-u-boot.dtsi
> >> index b843078243..60b219c0be 100644
> >> --- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> >> +++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> >> @@ -182,3 +182,19 @@
> >>  &cpsw_port2 {
> >>  	status =3D "disabled";
> >>  };
> >> +
> >> +&ospi0_pins_default {
> >> +	bootph-all;
> >> +};
> >> +
> >> +&fss {
> >> +	bootph-all;
> >> +};
> >> +
> >> +&ospi0 {
> >> +	bootph-all;
> >> +
> >> +	flash@0 {
> >> +		bootph-all;
> >> +	};
> >> +};
> >
> > So this gets back to what I was asking in the first series, is this
> > needed in SPL or full U-Boot as well? The bootph-* properties are
> > supposed to be transitive, but originally the tooling didn't handle this
> > and now the tooling handles SPL but not full U-Boot. Which also brings
> > back the is this _needed_ question and is bootph-all right, rather than
> > just the big hammer?
> >
> By "this", are you referring to the original phypattern partition nodes,
> or the ospi0 node itself?  The partition nodes are not needed at all, so
> removed.  The ospi node is needed in both SPL and U-Boot.  In that case,
> using the bootph-all tag is the proper way, correct?
>=20
> What do you mean by the 'big hammer'?
>=20
> Please advise and thanks.

So, part of the answer is that the documentation isn't as clear and well
formatted as I'd like (aside, include/dm/ofnode.h::ofnode_pre_reloc
comment should be reworded to render better). First, I want to point to
the schema itself:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/boot=
ph.yaml
and then next:
https://docs.u-boot.org/en/latest/develop/driver-model/design.html#pre-relo=
cation-support

And in this case, the "pre" options are a bit less clear as TI platforms
don't do the TPL->SPL->Full U-Boot dance that others like say Rockchip
do but instead the Cortex-R/Cortex-A dance for the K3 architecture.

Which gets back to what I was trying to ask. What, functionally,
requires that property to be present? And then, for the cortex-a
platforms these should be in the upstream dtb and I forget if you said
that's in progress for these platforms or not.

--=20
Tom

--7YtsBY4bRDmQsw2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXeJxIACgkQFHw5/5Y0
tywPQQv+ISS9/zAyQFrVXAhSywExPBntNG/v6YQzHZQw3RbabqLb14yvShIM1hwT
s/Kx/1oE67EhcYX32vHPOtHa86H2kbspG5cJXMVhleztcqEAoc9Kn3vDKCaTGCl5
OI2DvSMEm34LrZxBBgOQ7EMXkT6AyMrjqxTYsZihm1FCof9AzRgBMswFJTe1kzwY
0D/tp4dCQ0JvLFT/lbuzRj7bXUhb5qRsHuALvifKADccnsZqZpEMwQ+O5H7SG260
SzM26jraHE9qdesKBt/bxOOnzSEItYrVmVDEguD0aGywny4yuct0C7IMtUr0a9r2
0oj+5mRvkqpYC865sPyn1cmS+edwSPYOuZEQ35UqZidRUwRDo5ovVmRC0eARMWdC
rHXOlHk7yNUK4/7CybgA2OQf+P4f8vQpKiOVwFZWM/Na1NRgm4NA7BfU/48qJgQ6
7Vj7uIUwLHR6pdpfPzmMYUpU58BMuXtZVCuqHYiVFsg2mt49Qq2Idh+0lNac2nSe
5XfYYsGp
=2a4P
-----END PGP SIGNATURE-----

--7YtsBY4bRDmQsw2j--
