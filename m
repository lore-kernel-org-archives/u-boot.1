Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD76C47BF4
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 13:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 767EA83F66;
	Tue,  6 Jan 2026 14:59:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yo3p0tIL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F4E83F86; Tue,  6 Jan 2026 14:59:37 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3185F83F5D
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 14:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-450b2715b6cso614178b6e.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 05:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767707974; x=1768312774; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q7vKjqKorPJoQ9ucV8ytIjamPpBWE8IFtowBLXLKJS8=;
 b=Yo3p0tILEqH0N52MoTe97OkGxo+Er/2ofi0C8hCv3nR3PnftIGbQWIVC9SYr9pSOXZ
 2QAQ5nYqdcjGspCaMjSWaYJBqDBCWhFw0p4FpLCHxpNHI7nyoWmo8ZZn7fVRLAZd73M8
 m/XQXg4w2x/88fVn4dfHsEIiCjoVl7ml3hDLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767707974; x=1768312774;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7vKjqKorPJoQ9ucV8ytIjamPpBWE8IFtowBLXLKJS8=;
 b=JPYqcrz/BGVIvlIXDUdP3kstCanPRJxyWzut7Wt7Ti2Pjyeao5QR5i/OHd1DepX0Yh
 4xIbOsn5urJnYu0g3oauEr64teuAFcLx7EQn2sJWrGHXr15xzQTb8UINnCt7pj8HQhy+
 OknJA1eSTdwpDg5p54ucpeFD92gc3Qd3cJtc2IsglEWr8jCpg9aHGsgm6kDeXPT5cq7N
 zH4sxsf1oZlQjNcxUoFeZuL4fEVA+Gg8d6I0IQ34LAwa9Cu5szFyBkpJpBpglq4sOUWV
 P026shIuQv7J+2LoC5/OUR0+kx1xWqRWi4gRll1PLdb1d9xj2ZU74CDAKtGGEmFZ+b7H
 aEmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyzLVRs4CxL7JOkPRvvmQ6A5LtRKuYIZaAyqqwmnu+eofQ14ugRXrOrbhJXqBI3hQq++f3iEQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0/meY6gwidgBgQr48jb4Sc62kCNs1uK/bQeh2qCQaXPytPwZ6
 ckaiQc1l7WD+AZRMt2EUYAVbWcMv7b321HLXqwb3v5mJQFe6WRYAGnAF2aR9rpP+pQw=
X-Gm-Gg: AY/fxX6O+aeeOpavwob2AFxPyX16qEaeVB6595TtS5Bo+CchRaTDrR01jJkF30OoRA4
 VxUpmsxEQpLbUxOsuNepSyp93vsZKTSUxlyUz31GlALua2Tpgt7bL4/CQJ/2VS9m4o40ijplvXH
 dEuZfhCGCg5lY/tf6U0/CSLscpT88vzD0EE8FipVkd60o7uoCp1k7ZB0Sm12GXH5lKrt8JO/1BQ
 wEnhvDFqyeDFoYHtwwVmZIlLPwjx4ayj0QNweZMiMd0j4tsooRfT6KE+cnP6aa1XpM6OCXCmrk8
 s9zsrcLEdyQPJxLZqNuLPTK2MW7WHJ3r4QONZXkpnAsA5ktQ7QOKnKKa4rWpCoqHIVhUfjT4+9e
 sawSUg65RKgurGScaOD/W9zwmInfIUyY+i+MeI/XZN+QdhFvhwtOH7SR4Y0dJB7gLSRKRzY14eP
 sEfhNao+Om7nEirJVF30zRbd6WBIS/cRifozUflA92IW0salYYhbml4QD/omHv4HRUq2lwSAR8M
 U3g9SiU8EhTy14cNlvBGaOMnjCUPfcXPCNha+g=
X-Google-Smtp-Source: AGHT+IEH5T/oPOIdWWXTEMRfDQFLdFU+7RPleqs4c4r4E/zeHK9nIIJKcLjKIiizzXHj5aGYYDC7/Q==
X-Received: by 2002:a05:6870:59f:b0:3d3:52b1:d731 with SMTP id
 586e51a60fabf-3ffa0c3c8a5mr1722652fac.31.1767707973694; 
 Tue, 06 Jan 2026 05:59:33 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa50722e9sm1313058fac.14.2026.01.06.05.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 05:59:32 -0800 (PST)
Date: Tue, 6 Jan 2026 07:59:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Prasad Padhi <b-padhi@ti.com>
Cc: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, anshuld@ti.com,
 hnagalla@ti.com, jm@ti.com, nm@ti.com, n-francis@ti.com,
 u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 11/11] configs: j722s_evm_r5_hsmboot: Add new
 defconfig to show HSM boot
Message-ID: <20260106135930.GE3416603@bill-the-cat>
References: <20251231173621.1069988-1-b-padhi@ti.com>
 <20251231173621.1069988-12-b-padhi@ti.com>
 <20260105141105.ykq2uaelapfqb2m2@bryanbrattlof.com>
 <f30315f1-484c-4350-b1f4-e3927c62b4dc@ti.com>
 <4c742926-05d4-4d9b-a8c7-c36209c01c6a@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Shy3RWGDdJn8z2j3"
Content-Disposition: inline
In-Reply-To: <4c742926-05d4-4d9b-a8c7-c36209c01c6a@ti.com>
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


--Shy3RWGDdJn8z2j3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2026 at 04:07:44PM +0530, Beleswar Prasad Padhi wrote:
> Hi Bryan, Andrew
>=20
> On 05/01/26 22:49, Andrew Davis wrote:
> > On 1/5/26 8:11 AM, Bryan Brattlof wrote:
> >> On December 31, 2025 thus sayeth Beleswar Padhi:
> >>> Up until now, the R5 SPL in J722S platform was configured to start out
> >>> of the SMS0_HSM_SRAM0_0 (0x0043C00000, 512KB) memory region. However,
> >>> with the requirement of loading HSM M4F core with its own secure
> >>> firmware, R5 SPL can no longer utilize that memory to execute itself.
> >>>
> >>> Therefore, utilize the MSRAM8KX256E0_RAM (0x0043C40000, 256KB) memory
> >>> region for loading and executing R5 SPL. Naturally, the SPL size has =
now
> >>> to be trimmed to be fit inside the smaller 256KB region.
> >>>
> >>> As an example, create a new defconfig (j722s_evm_r5_hsmboot_defconfig)
> >>> which removes the SPI related configs to trim down the SPL size to
> >>> ~175KB. The above defconfig demonstrates loading HSM core with SD, eM=
MC
> >>> and UART bootmodes.
> >>
> >> I am worried we will need to find a better way to handle the defconfigs
> >> which are mainly here for testing things. I agree we should have a way
> >> to test this driver but if we go this route we will have too many
> >> defconfigs and build instructions for each evaluation board to get our
> >> code coverage to the levels we want.
> >>
> >> And it really only confuses people who are getting started.
> >>
> >
>=20
> Agreed, not a fan of creating multiple defconfigs too, But...
>=20
> > +1
> >
> > Using the SMS_HSM_SRAM for the R5 SPL was always a bit hacky, might be
> > better to move the default defconfig over to using MSRAM for R5 SPL.=20
>=20
>=20
> ...won't that effect backward compat if we disable some configs?
>=20
> > This
> > would of course mean we have to shrink it down a bit, but the Sitara
> > platforms get by with as much SRAM without much issue already.
> >
> > How far is the current R5 SPL on J722S from fitting in MSRAM currently?
>=20
>=20
> It's not just R5 SPL but also it's required stack, heap, BSS, global data
> and Scratchpad area. Adding all those we get ~270KB bin. Whereas
> our MSRAM is 256KB.
>=20
> So a bloat of ~14KB.

Taking a quick peek, CONFIG_SPL_EFI_PARTITION=3Dy can be dropped I bet and
maybe CONFIG_SPL_YMODEM_SUPPORT=3Dy doesn't need to be in every build? It
might be worth sitting down and working out which boot use cases need to
be supported in the basic build for the platform and which ones it's OK
to have the user build, or build in your SDK or what-have-you. I'd
really hope we can still make something both useful and functional in
256KiB of memory.

--=20
Tom

--Shy3RWGDdJn8z2j3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaV0VNQAKCRAr4qD1Cr/k
Cv72AQDsL2cxusankkipA3/lRSfoltk0317X3f0FAYf3saJkXQD6A128VzC9jcGL
VZVUeaSndTRwbDzEdQo2aBqcoKg1dQs=
=YhY1
-----END PGP SIGNATURE-----

--Shy3RWGDdJn8z2j3--
