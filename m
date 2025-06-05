Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CA5C5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 20:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FA438091A;
	Thu,  5 Jun 2025 22:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="by7UbIDf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C059881E25; Thu,  5 Jun 2025 22:02:45 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21ED880050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 22:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-60d6303a11eso786030eaf.0
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749153762; x=1749758562; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F0yccsNQWBvHqdfQe3J+dHEaZZsf4+oGCrjjIeEiOYY=;
 b=by7UbIDfvXCrnLSar1fBivYs2D2QKiO0kSWN7UlaRHc/rWyg4R3Rw06mCbe3/LKj79
 6Ze8xdj8SgOXj7mBJeX5uN7srrNBIprUSkKKCwHlDu1Bhuf02rHMLQzbvi7yO1C93UAx
 CZrHD2sO4zdIj9hMPZ0RrWJby5Fd6ULa+W/f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749153762; x=1749758562;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F0yccsNQWBvHqdfQe3J+dHEaZZsf4+oGCrjjIeEiOYY=;
 b=G45vlIN6cAr+R0a6h5QURszsJpd7RHS8v08VBjeiIQmUyf2Dk9DTULdqmcgEdzkNFK
 oLQNV94rS0kpMweZN1dVydzo8Y2NuYLOwhOr7NqTD3KkTF3TacMD9faQA65OCgl0z3ZD
 n8heJC+au0+zfi0rz9I9yIUe4A+kxy9c6gLnp+w16RpRwJp9dnZwWhIKZ5xuxzJ/nCWs
 3PFHNU3kGvnOxOw8zY6RzaCvFTZHqyGyj2ahq6A+CBpG2YNrQGR6Ni+U3cbxsMVQntd9
 kGZPRfJWCG2tLVMbFCPOxnOLkyuh4o8J4vfGce6Ecrpl4VI2S9cmTObYYEGqW0sQhBOM
 i/Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1Jef/3gMxKkHRwuCz1vG/T8rnwtu4QH+JfiASPP+uyDkEl63yicifHNozOJoif2KWFhTfAOY=@lists.denx.de
X-Gm-Message-State: AOJu0YxEb3u5sWgrNmBk49YkIhSiIXxMwFCxQc3bhYcsL37vH2tfvbjU
 oPNVGeLN3ihbAD4p7IuM1hOClFZk0UBPepFuEmulujsFESk6bMp6+/xApbZ+EYBygjE=
X-Gm-Gg: ASbGncvw4l+zmd7wnoIA8gg6LOs+g1qYclR7br/qCdvLUUT/FPSfyXTmLYbA545ycqs
 wswQ0ErOZOUFJIpAgz2N5dZuTYtTjvHjeoVs32DvpcfTHsZKbOsY4EchKWKXebCqSKc7N1EUyOA
 seYl2y8JAds03PQ5ljT6SiGXAWbOWE/xTs8fz401+P+Y46Ijug8sF0yg5pRYPKpZRCtxKBj/5YE
 f+LdS7zyzDv+guxaqp51S1nNflaVwH9z1ofnsMbRGSmQRQmzxad0mJIIeECgt0NsdHgNzXyHfgy
 G9a6LGrTm71c18FEEtdgIXm8ankNUvFPilP+F7CMW2pKxPkBjRbDJYvhiMqnlLmVjW+MgcsgbFA
 orps2hSlfw+G6
X-Google-Smtp-Source: AGHT+IHT1Xay9+gXKJDAbc0wgTTrI2jQj2uzjxvfPyS5ly2ZZkQti5xgaep4TLUP7z0K9InIcTjBbw==
X-Received: by 2002:a05:6820:198e:b0:60f:9d6:bd0d with SMTP id
 006d021491bc7-60f3cf5b123mr570277eaf.6.1749153761612; 
 Thu, 05 Jun 2025 13:02:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60f3e644a9dsm2433eaf.13.2025.06.05.13.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 13:02:40 -0700 (PDT)
Date: Thu, 5 Jun 2025 14:02:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Martin Schwan <m.schwan@phytec.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Wadim Egorov <w.egorov@phytec.de>
Subject: Re: [PATCH v3 0/2] bootstd: New bootmeth for RAUC A/B systems
Message-ID: <20250605200238.GE1382132@bill-the-cat>
References: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
 <5621cd82-042a-48be-a708-a29ea96d4f7b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2mW1FX9BYmTW7eed"
Content-Disposition: inline
In-Reply-To: <5621cd82-042a-48be-a708-a29ea96d4f7b@linaro.org>
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


--2mW1FX9BYmTW7eed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2025 at 07:46:54PM +0200, neil.armstrong@linaro.org wrote:
> Hi,
>=20
> On 04/06/2025 14:15, Martin Schwan wrote:
> > This series implements a new bootmeth for RAUC A/B systems. RAUC (Robust
> > Auto Update Controller) is a lightweight update client, providing "Safe
> > and Secure OTA Updates for Embedded Linux". See the following links for
> > more information about RAUC:
> >=20
> >    https://rauc.io/
> >    https://rauc.readthedocs.io/en/latest/
> >=20
> > PHYTEC uses RAUC in its Yocto based distribution "Ampliphy" as the
> > default way of updating embedded devices based on PHYTEC hardware. So
> > far, the logic selecting the correct partitions and files to boot was
> > being implemented in the U-Boot environment. While this is a
> > straightforward way to do it, adding and supporting new platforms became
> > somewhat tedious and is platform-specific. The introduction of U-Boot's
> > "Standard Boot" provided a convincing alternative, promising a simpler
> > and more portable way of booting, even for RAUC systems. This led me to
> > implement a new bootmeth supporting RAUC A/B systems. Note, that this
> > new bootmeth is not proprietary to PHYTEC products and is designed to
> > work on other hardware with a RAUC A/B system, too.
> >=20
> > The bootmeth currently only supports symmetric A/B partitioning layouts.
> > E.g. A/rescue is not (yet) supported. The partition indexes and default
> > slot tries can be specified via configuration options.
> >=20
> > For now, the bootmeth_rauc uses a similar approach for loading the
> > Kernel and device tree as the bootmeth_script, in that it requires a FIT
> > containing a U-Boot script loading the desired distro. It could be
> > possible to support booting without a script and load the Kernel and DT
> > directly with this bootmeth, but I found the script method to be very
> > flexible for now, in letting the distro decide what to load.
> >=20
> > The bootmeth_rauc was tested on a phyBOARD-Pollux i.MX8M Plus [1] with
> > BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.2 [2].
> >=20
> > Supported boot devices are currently only MMC devices, but it should be
> > possible to add SPI flashes in the future.
>=20
> It's quite a late comment, but this implementation has really nothing
> specific to do with MMC, you could just support any block device.
>=20
> So if you could just add a config selecting the block type, defaulting
> to mmc, this could be used on any block like USB, UFS, NVMe, ... with
> almost 0 changes.

I raised this with v1. The challenge is that RAUC itself doesn't yet
support non-MMC options. If/when that changes it's easy to update here.

--=20
Tom

--2mW1FX9BYmTW7eed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhB994ACgkQFHw5/5Y0
tyzj6Qv/amWEABDvH1mk5GVZDL3r05ayCnt4mc1A03z4hjb63vofFGS37TtbMk1t
i4YL32ervAuNeY9MaMbUqCBuN3ImAMR5cr5Csenk9hHay4T74eqcZORj8XealQKV
++KhY9YC2EsREopKeagl/cR6lHEV1xf6KzyLU4Krf4HsicFWWYGo5kjP5RiMKI+R
sZ2w5h0Hl0eMtHS6vHvIT5errzWKiMgwYSxes/lzytPHzvqMzR2bFmCmYr7BOL2T
SSuZ3VLGvrmv37L29z1xDYdpDEAReYqkF7h/9NP/yLciUDCRLY1P96spKnX+ePci
rOt2QtJxqTUcbn8+iDXQXc+SMyoWBcPxai9jFT+X9JlB+YQWWSd0cRVDyrjn++Qt
Vag707FgeTooFpzrzajp5DbHxyiPc+2TCXSrWv3VHNGV2UIPBH0w8kwvt5/9CP0S
valuooT6Zi5Y3kPLaGnoujWEv5QSCd7ca0NKVzVa0wg3uEJ7wBkbzvahcab+9LhU
vYzbveGw
=wPO/
-----END PGP SIGNATURE-----

--2mW1FX9BYmTW7eed--
