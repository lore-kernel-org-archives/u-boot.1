Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9276ECD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 20:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B19B088118;
	Mon,  8 Apr 2024 22:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A3Xr54mK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3904B88126; Mon,  8 Apr 2024 22:07:38 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 168B2880FE
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 22:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3c3aeef1385so2680856b6e.3
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712606855; x=1713211655; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mHdR1ShJhPTlBR5KkVeri8TcYJHd9fvSL4s1/UVZvcI=;
 b=A3Xr54mKf2WVMzIrSzvAEsZhoR3Veoj/nFYvU+sjdvTEpWTD2IKGHi3qevcY8WPgze
 7EkANz1XtFIxePKL5hYOb32amw4oJ/QBM55DrfzY4AKfS+oK0sHKDgn0emjIQIxFTMCD
 oMG6OJr6UQZoKxCRS4tbRhRu4ZSzpMwFrX9DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712606855; x=1713211655;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mHdR1ShJhPTlBR5KkVeri8TcYJHd9fvSL4s1/UVZvcI=;
 b=JMTwZWJrJWGAHTgmhutseEVtMEHTZOnJ0+URorx6pjZ7rsi/ztfCoffqOA/K3iiz88
 lt267sfSJPwCPPEr1ddWOnFQNZU7dUuWvbwUFCSfkafY5vr/sjNflf9J0vZ5uS0h9l1D
 XWfErNH+oLAM9HkzQwRnvaCOuCFRlr5er3D1Xn6oG8c0valx3vDOxhEld9l9e5nipm5J
 k5m8QXAYGUPV/k8n0VLWN4oc638O1BxljwnF4ugRZj9/Bxx5A6gH2Z2AtyVAYs4Sv/NB
 tdnGv5vB/NEgumG8EalRJ2zpYIhnKB6zuEWtI0fGMvEubwXivDo715JRDL+Ui47NLblr
 cAUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzv68PFn4pYeav1+yLwdgFuIj/uX8xCKkNHol6BNqd1VFzvj103x1DRiVkIyJPy2St/IYP6F5fLw1P7SYXKIoSVXO8lA==
X-Gm-Message-State: AOJu0YzbnS1QqkS/t8MpIgDnx9ho+xkxhjJyx4p+ptI+yLftAkC0jHLJ
 M1S8y+SvWnP9akrWbVfj/11nnevU4UPKXP7sNnTYGxrxDNV3dVxKqJBQ2ezCY9g=
X-Google-Smtp-Source: AGHT+IEbfPAcai8rhe0EhdjKKCP3CqJ29Ehv+tbmZ5uIlsoPFhjd4HZ3s9to2kpsRIR/Fz5FhKVl5w==
X-Received: by 2002:aca:918:0:b0:3c5:dbb6:4467 with SMTP id
 24-20020aca0918000000b003c5dbb64467mr10002419oij.7.1712606854807; 
 Mon, 08 Apr 2024 13:07:34 -0700 (PDT)
Received: from bill-the-cat ([187.144.96.143])
 by smtp.gmail.com with ESMTPSA id
 r10-20020ac8794a000000b00434cbc44bebsm267105qtt.86.2024.04.08.13.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 13:07:34 -0700 (PDT)
Date: Mon, 8 Apr 2024 14:07:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Andy Yan <andy.yan@rock-chips.com>,
 Akash Gajjar <gajjar04akash@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 00/14] rockchip: rk3308: Sync DT with linux v6.8 and
 update defconfigs
Message-ID: <20240408200731.GB6531@bill-the-cat>
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408193848.GA6531@bill-the-cat>
 <32b23471-fcec-4b2b-baea-39488b772eb2@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="97HpKDYZSfD+jFw4"
Content-Disposition: inline
In-Reply-To: <32b23471-fcec-4b2b-baea-39488b772eb2@kwiboo.se>
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


--97HpKDYZSfD+jFw4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 09:55:59PM +0200, Jonas Karlman wrote:
> Hi Tom,
>=20
> On 2024-04-08 21:38, Tom Rini wrote:
> > On Mon, Apr 08, 2024 at 06:13:57PM +0000, Jonas Karlman wrote:
> >> This series adds support for new clocks used in linux v6.8 device tree=
s,
> >> enables use of FIT signature check for checksum validation and fixes
> >> loading FIT from SD-card when loading FIT from eMMC fails.
> >>
> >> It should be possible to move RK3308 boards to use OF_UPSTREAM in a
> >> future series after this has been applied.
> >>
> >> I have runtime tested this series on a Radxa ROCK Pi S v1.3 having a
> >> RK3308B SoC. Following was tested and now working after this: SD-card,
> >> eMMC (SD NAND), Ethernet, USB host and USB gadget (RockUSB and UMS).
> >>
> >> Changes in v2:
> >> - Add clocks and resets props to otp node
> >> - Add bootph-some-ram to emmc and sdmmc pinctrl nodes
> >> - Sort bootph-all prop after compatible and reg props
> >> - Fix rk3308-evb debug uart
> >> - New patch to move cru and grf include files to arch-rockchip
> >=20
> > Sorry if I missed the answer in v1, but why aren't we switching to
> > OF_UPSTREAM here, which is also on v6.8 currently? Thanks.
> >=20
>=20
> I would like to keep the switch to OF_UPSTREAM in a separate series
> because of reviewability, some of the device tree files has not been
> updated since v5.5-rc1, also I would like to have the option of
> cherry-picking these patches to e.g. a 2024.04 branch.
>=20
> What is the expected update cadence on OF_UPSTREAM, will there be an
> update to v6.9 before v2024.07 or will U-Boot be one version behind
> linux at release time?

If v6.9 comes out before I open the next branch, yes, it will be in
v2024.07 otherwise no. I have to double check my emails before
repeating if it's rc2 or rc3 I'm trying to regularly do that with, and
then update doc/develop/release_cycle.rst to list it clearly.

--=20
Tom

--97HpKDYZSfD+jFw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYUToAACgkQFHw5/5Y0
tywTSAv7BvVt7DzgFA10sStp71ZjmJC91BX6AjglB6tSbsWXRkgXHZg8B8Z7qi05
RzZkT2gzxJDFZMkyR2tMU1qOecGGDLnnT/rOw3P7er9e/ISqutsLhfqJIDvMGeaJ
eMleTyX0/WDjx+U1kdmi3jLU4TpbxAHwkbK/g/nJB229YDOac0/AXP04CrSHSFLq
3tQdgHe58T7xSdxyjYTm/lPqJ0U1EAwrmbZ3lz9BFYdjGpLLiZ6IJjvbrXc/5eQQ
dyJiNcbx6yLZZchy6cvyS0zAorW/JnhFzlPE5vHjAA287L4sSFI2/IRmHqrJQpiP
njon6/3bD35RcGMiPxlZr+NfxKHQQgmbT03xdfq6DJDo6RmRmC/xl3Zt7rH5dtJJ
VWjrw5yEZKG7Lmo+7Qzdbwt5O7KMhoc+RTnxmCB0e445jd9WurPznoxJSWp0xIrS
qKp6LvLWAwkiaDcebvZ11NLwcLdT0Cbwyp8nZ5Jlp/unW0JoEHB3WA7tjbWAIYAj
umi8TB0t
=/rbp
-----END PGP SIGNATURE-----

--97HpKDYZSfD+jFw4--
