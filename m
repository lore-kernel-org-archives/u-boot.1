Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C421C36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 18:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39400810E8;
	Tue, 25 Mar 2025 19:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AVEkD8Bc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF7F98186D; Tue, 25 Mar 2025 19:40:58 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D07E81026
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 19:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so113950075ad.2
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 11:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742928055; x=1743532855; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QGliZbJbVwBygEx3DgYYQn98Rxz3VZIqOB0USm71It8=;
 b=AVEkD8Bc2BiYtA+f9u8DWr2FhY7li2NCE2iq+CbruK1WYTO80En8rzQE2cnWGc4z5G
 jHsfts/WV2Pkbx4wOWfLK4IUCOp/jNc4rHOmDmcKIDZvRw7byS4YpJIDOPBrEKvt7jXt
 pJBQcyoFdYFOTvwbHgb8C/xiU0abo0HIhS5L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742928055; x=1743532855;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGliZbJbVwBygEx3DgYYQn98Rxz3VZIqOB0USm71It8=;
 b=HtRKW57ZnurFtug910avlpiPECVIJ9wSfxWbNAlnSpO39lHiSmnxZwzFr3/s11/SLn
 yJASwoQf64NcH6rd4wZ/RnDan8EkgCoMC1FBE7je4dLo0gMij/HuZn0zH3/o5c6KhDIb
 taxS+i+ZzAWHiCxjQJNCWkpCrrRDJXbK0J8yBePSxttR9rFn3fGiPXWi8vCKMiy3BYJP
 cR9qepL685qY4ehosk76yITVSm+d61HVHrxwlOgR2+7K0ETICF4LzWQ3uj35xEsSha57
 UG5Ri4ierU67Pr0HnW4ijhM4fi05EHGEz7F1snwBPnf7FAVcLbvIyOO7yur3WSMcr1WF
 Gzqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHFw7rkuEyhOtSKd7RphY6YmJhrUoggiF4jj9XV9piJVWgj4pF1/xmGQqCN0EkMbeLvYYiklw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywwg20+7lnvF9NJ7uagdnRJtOW8PBxX2D9vLyEmQL8Mf3dgYodj
 vwtT25EGbquGzsOeNKQIcnMN0b/P2j0eVUkjSFY2lJmhi1aMAJmdQpOP90h43Ifw5MOgMarpBWQ
 rXvk=
X-Gm-Gg: ASbGncv0XypxTxwcW9keZlr1LUlgbJ+ZqrWYsbyliiH/LcMbeodFXdxiirmQLG77LLb
 UNS46+3sg0LFF/DqQ5j2niU6K7flwsYLDAzor/hjODtFbZtg7Ud8HlUaiibhDxYyMPzyKfuVtrE
 D4ppD6lkZKS5+ARRo7BpxG1v4oNgmIL6906HgyfFu1pQjouFwTe0bfRB/dUn7aFO7Sq6PEqWk1v
 +lCHtBv6nMWQ3ymDL4cODyZq+xKstDUon8haIAi2lh40AJhzZJGW+agah95ok+XARlGnndenqCA
 CoPGka36+54qOvU7yxF7atJUqyDJpP/pHhknSBX+Pe0=
X-Google-Smtp-Source: AGHT+IFRKXhu08En5x84VitRYdLH2Yn0BsK86OHJthoKk3HLt1uVWS8sBOY89iSCvgETWqG84Qubfw==
X-Received: by 2002:a05:6a00:3d49:b0:736:592e:795f with SMTP id
 d2e1a72fcca58-7390598e637mr23186254b3a.9.1742928054816; 
 Tue, 25 Mar 2025 11:40:54 -0700 (PDT)
Received: from bill-the-cat ([2806:2f0:5140:4ba6:9e6b:ff:fe16:a05f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fd57d6sm10930455b3a.58.2025.03.25.11.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 11:40:54 -0700 (PDT)
Date: Tue, 25 Mar 2025 12:40:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] common: console: move break; statement
Message-ID: <20250325184051.GM93000@bill-the-cat>
References: <20250325174744.1778691-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F9zpQjzsp9VHHXox"
Content-Disposition: inline
In-Reply-To: <20250325174744.1778691-1-andre.przywara@arm.com>
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


--F9zpQjzsp9VHHXox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 05:47:44PM +0000, Andre Przywara wrote:

> In console_setfile(), there is some #ifdef'ed code, updating monitor
> functions for a U-Boot proper build. This is called inside a switch/case
> statement, but the closing "break;" is inside the #ifdef section.
> This doesn't look right: we should not fall through to the error case
> for an SPL/TPL build.
>=20
> Move the "break" to be always effective, solving a compiler warning about
> an untagged implicit fallthrough.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Looking at the whole function in context yes, I agree this is right. It
probably wasn't a problem in practice because of where / when we don't
error check or even call this function in the end.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--F9zpQjzsp9VHHXox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfi+LAACgkQFHw5/5Y0
tyyYJgv+Mujp/GCgDmYp2AbCGGAT5kZlwyEUBrrvqkLbfh9wt3kd59w+kJt/R+PM
hkdISUhMZ9SiDWXL3DpNSG3Elt/avAX8w1PEyixbEuyeG2hOWpmT/2u1kHYCHoNx
isP8SbQsgkllKY7VHZA6vfDYAnrzf1uC4AOyVZALbrljM24J8S6TZ7990BXP8wE5
t6ni4OgaEKr324R0ziVR8Nxa/Z8kPGhI2PCF1UBTqcyEG1H125F5iZPK8RvaZ7K3
ar8Hl42K8W0lgwyqmeE/IxZXR4eXGwAi8GLJtavOraY4tqgWwQrt+jV26VFQzFzh
EpWcc1T0u8YXpLRdKHLrXFIy+TNP8JcscAOjxV7AI9p/TN1Bn6p2oXhjIfzywczl
ZmEVHNpcmJClHPK7lyMKwBMz4ehBc5HWBGVDmnez/7pCtDLWn+dTMX11Mn5UMAtU
rAubzdSEFYA5iAGbst/jw8S+/D7ZvMnSVPo0d3DpCrcTDoM2UJCKbul6Rx5pqEXm
cCFxI/AO
=gpW7
-----END PGP SIGNATURE-----

--F9zpQjzsp9VHHXox--
