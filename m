Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6719CD8CAF
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 17:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7538A83FC6;
	Thu, 13 Nov 2025 18:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lM+mZQgF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6BD683FCE; Thu, 13 Nov 2025 18:57:07 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85C2883FC5
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 18:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-3e84d56c4b8so632843fac.2
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 09:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763056623; x=1763661423; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iemLbBv9TAMiZT1NJfh+7MSm1fO/yqTyJpcTrXIou8A=;
 b=lM+mZQgFzjfPfbtgxavSUg+emDCflpJi6ew/GLKTYTGUPk4n7iwRrI7I3pjqcP0/IQ
 N7LAvaT3EwnFEt/OaZVT/mXFQD1SPtJPc8z8emevie+wGxJ1rHo81Aubag+eyfOjtW/L
 X4tiaIPZq8Hu4IPaUuf95cMF/5+4OnI0HV3Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763056623; x=1763661423;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iemLbBv9TAMiZT1NJfh+7MSm1fO/yqTyJpcTrXIou8A=;
 b=fVTZVlxAFrx8Uurbi1ETj+ZdQxhrd1/idsb1UQluo6bmegiFPp7ji1p/ZHreeKxFE4
 taBDG2P0AF3+XImzkSl2NBYmgcH4dsCKWKQUWkrYG4TrUO/a5SHo0k6XboowyMi0I+Pi
 EG6NFj3XQN4cggX/mLLq6fXsImkNV1mFBuC1eoSPj+nRga6IRi2XCyfhj/r0cOuXaqyM
 sw/CFYIhgoS1ZaPrGjdqz+b2KOJI5gROR7hbUwJWNyth/mQs18WjxxSo8+NjJICgv/dU
 xKqldtRmrEAGB6Ykp1ITxOAnHGA/69isoOupyDjqgDqJaWHNtBxdkrpZPOFq+3KA8hXh
 UOJg==
X-Gm-Message-State: AOJu0YwmaPE7vNmR32+MixzZtsLrRKHt614xZ5h5Ei7cUPYephEgCGKr
 LQYhui8n1h+6U78BS7ihZPVmnmw8bp6XE982qj4ydn2lCeZcc58dgDCImbfHzSHSeNE=
X-Gm-Gg: ASbGncsELbO19jPuJt8/Sf1lctCQMfpqyTa83QurnvLGuBO1ROxvQUIKOt/EN21uEtV
 +du3BTXrS/KzARXv1LHNAvEKJK2MNCwO+gF7+wXc6YPymFgwXTXahScRDHB6CVNKjykevH8/NoA
 qcqhUgZurXTTiMkJd98zyN3kfW3YX1ENfyAb7A87qsdV1zoziyJqVqnFcvcjc6R12iCkQkcHsqI
 NI+nbhTaqx3gVpoUcKoHf+Wn5yUP7MJUm6wzYEImmMkWwZ2yH+botTPdhdBmgpWSRxZVsVWyP2U
 jAe20vI2Pmp6To/CZ1yl0zBafBnNOlWocn6pvNg1vvx9DngR26YuGb9J1pctUZg590xHy6tWk+H
 NrwgU6SihIsmHzKUDz3NBK6C+If4fAS8NiOaHv3wbxI+TMifkD+sPkqcVuKO8JIs5/i5pv7gVwo
 NhnVOlsNoYKY29YxnrhZQ3oYU9ZyJfXpWEp9jqGjc=
X-Google-Smtp-Source: AGHT+IFDnZp40+tMKGAIizVyjnujVWeDgmmZIs35qfFjkEj4e4FTdFBoAYWlfe/gUE01Nn0fZAiSZg==
X-Received: by 2002:a05:6870:41d5:b0:3d3:b73d:38b7 with SMTP id
 586e51a60fabf-3e868f1a992mr151604fac.17.1763056623041; 
 Thu, 13 Nov 2025 09:57:03 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e852305476sm1848415fac.23.2025.11.13.09.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 09:57:02 -0800 (PST)
Date: Thu, 13 Nov 2025 11:57:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 0/3] Synchronize DTC to 1.7.2
Message-ID: <20251113175700.GM6688@bill-the-cat>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nB3tzlVkZrROtXN9"
Content-Disposition: inline
In-Reply-To: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
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


--nB3tzlVkZrROtXN9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 01:21:07PM +0100, Marek Vasut wrote:

> Synchronize local copy of DTC with Linux 6.17 , using commits picked
> from Linux kernel. This also includes two fix up patches to make the
> DM core work with new 8-byte alignment checking in libfdt and another
> fix for NULL pointer check that is missing in libfdt.
>=20
> This depends on the following patches sent separately, which fix
> various 8-byte alignment problems in the code base:
>=20
>  - boot: android: Always use 8-byte aligned DT with libfdt
>  - test/py: android: Point fdt command to aligned addresses
>  - test/py: Use aligned address for overlays in 'extension' test
>  - sandbox: Fix DT compiler address warnings in sandbox DTs
>  - sandbox: Fix DT compiler pin warnings in sandbox DTs
>  - boot: Assure FDT is always at 8-byte aligned address
>  - arm: qemu: Eliminate fdt_high and initrd_high misuse
>  - efi_loader: Assure fitImage from capsule is used from 8-byte aligned a=
ddress
>  - MIPS: Assure end of U-Boot is at 8-byte aligned offset

So, taking a look at the test branch you pointed me at, my big concern
is size growth. On imx8mp_dhcom_drc02 (where we're already LTO'ing),
with the CI gcc-14.2.0 toolchain full U-Boot grows by more than 6KiB and
SPL by a bit more than 2KiB. This is a bit of a worst-case, imx8mp_navqp
is a bit more than 3KiB / 548 bytes, with the average feeling like
~4KiB/1KiB for aarch64.

I know there are some configuration choices to make libfdt be more
risk-adverse and perform less sanity checks, but I also think we had
fully enabled them.

Frustratingly I think this is why we ended up with:
commit 088bbc1efa8c1efe8e2714b9640055ce984aec93
Author: Patrice Chotard <patrice.chotard@foss.st.com>
Date:   Fri Mar 28 17:31:15 2025 +0100

    dtc: introduce label relative path references
   =20
    Since introduction of OF_UPSTREAM flag, U-Boot's dtc must be able
    to compile Kernel's device tree.
   =20
    Since kernel commit 7de129f5389b ("ARM: dts: stm32: stm32mp151a-prtt1l:
    Fix QSPI configuration"), label relative path references has been
    introduced. These label relative path references is not supported
    by current U-Boot dtc version 1.5.0: (see mailing list discussion [1]).
   =20
    In order to support such label relative patch references
    adds following commit from upstream DTC tree:
   =20
    commit 651410e54cb9 ("util: introduce xstrndup helper")
    commit ec7986e682cf ("dtc: introduce label relative path references")
   =20
    [1] https://lore.kernel.org/all/20250115144428.GZ3476@bill-the-cat/T/
   =20
    Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
    Cc: Tom Rini <trini@konsulko.com>
    Cc: Simon Glass <sjg@chromium.org>
    Reviewed-by: Tom Rini <trini@konsulko.com>
    Reviewed-by: Simon Glass <sjg@chromium.org>

Rather than a full-resync for the last time we needed a feature found
upstream.

There are things we *need* like to be 8-byte aligned and also the
phandle resolution thing I believe inspired your investigations here,
but I don't know if we can take the whole sync. Or maybe needing to work
with upstream to shrink down some parts, I'm unsure.

--=20
Tom

--nB3tzlVkZrROtXN9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRYb5AAKCRAr4qD1Cr/k
CvHZAP9hUWn1Q22C3W+7s7qSDSVRYjF6+OCJuOtGfr+nGpBGYgEAugctzLl0UdqY
EisolU2R9M+MptfCHS8kGtYlbEKu2wM=
=w+u/
-----END PGP SIGNATURE-----

--nB3tzlVkZrROtXN9--
