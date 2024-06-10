Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E959BC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18B7C88657;
	Mon, 10 Jun 2024 18:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OWA1HTlh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42374885E7; Mon, 10 Jun 2024 18:51:17 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD1D888667
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-254a7fe21aeso824809fac.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718038273; x=1718643073; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=80cVWvlrcMtrUol+N7enuecnFl9f7pBO7wub1rvCcJw=;
 b=OWA1HTlhkF2tQquppF+x+NHBUonYXwO3yfM21eeBYv2Cp6oaxdI7LgxOBHW4JZF+Xm
 aUOmQCJ1aGFHfXZF1AqHD0lYwvtDSxpDvg6qchU+onSy+fGxQalQfqa4pa3EiHmxIO58
 OPRNWDuvfnYsmKsieUng5f71wDlclhppdUMfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718038273; x=1718643073;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=80cVWvlrcMtrUol+N7enuecnFl9f7pBO7wub1rvCcJw=;
 b=h8ZuiSuBtcJmSxGBbRjMt5ysecy/GhJYhgXKsxAecvaXJJEfidsGbCT4phD3C13/GQ
 SERaOH2Wi2Goe/DarDd1gM9NUkFIStZx1u3tVxajo1xC255tRryqn06dIpSdVflPGvTk
 zj0fu5xSJlwbIdRqqDWjBIEgyHGrDwH7TBsMn7uo1efM/KQHCZ2JwODA3iMmBL7K4qJd
 NtT+w5HeRVI8UY1uBv2j51GUgjg8LgrdNRuXq1Ov4poGCY5VGPIJ5Ayy27AKi21MZRw1
 dmdUty1GpL2xfG+ktSjYZdVJxcefIW71O85iB+9RGMG2CxWfHuskEgIHk2U+LSqCt9X0
 n/tw==
X-Gm-Message-State: AOJu0YyqnqIWMACROxqKUHP863msm1ImlZ7Bx4fWsJRtqsgZU4bSRJOe
 qqYpFIXs/lNDMm1LnlU6U3CLjbNrwqETGPPl2sLRUx3oKqm7GJz+w7jO0IuvQSqbWsU9SQlQied
 h
X-Google-Smtp-Source: AGHT+IG9gCf2sYbm67J3meyNKpyjWC1jFRmf5ZL105ffC31reczXjda71J5f83ufKUZgrHG4ZIxHqg==
X-Received: by 2002:a05:6870:9a1f:b0:254:b6f2:de86 with SMTP id
 586e51a60fabf-254eccab44amr96875fac.11.1718038273356; 
 Mon, 10 Jun 2024 09:51:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254d96e5e7fsm308769fac.26.2024.06.10.09.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:51:12 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:51:11 -0600
From: Tom Rini <trini@konsulko.com>
To: "Brunham, Kalen" <kalen.brunham@intel.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Message-ID: <20240610165111.GR68077@bill-the-cat>
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RiKvc8bKMxhimlTG"
Content-Disposition: inline
In-Reply-To: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
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


--RiKvc8bKMxhimlTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 07:13:48PM +0000, Brunham, Kalen wrote:

> I've encountered a problem when compiling the 'examples/api' directory fo=
r ARM64 in U-boot. The problem lies in the assembly code in 'examples/api/c=
rt0.S' where the current CONFIG_ARM code is only 32-bit. When targeting ARM=
64, a 64-bit version is necessary.
>=20
> I have proposed a fix by including a 'CONFIG_ARM64' section in the assemb=
ly code as shown below.  These changes have been check via https://github.c=
om/u-boot/u-boot/pull/538.
>=20
> Feedback is welcome.
>=20
> Signed-off-by: Kalen Brunham <kalen.brunham@intel.com>

Applied to u-boot/next, thanks!

--=20
Tom

--RiKvc8bKMxhimlTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZnLv8ACgkQFHw5/5Y0
tyykXAv/aSM7cKEyJrU6VCIHAZA1Shtsd5jb3+JVe++ZJpBwfZpe7Vm18aqTUHGU
ksqKBSk6UjGvGDQQSFtapXdHphhEsbhLVXwXh46hRL+OwxcvY5IpkYEea1MrE1bi
3tXxy8u0V12e8UPq30vh5iG7xHH+Os6dnfuSSzXo35CfXJN60R/Lo62r1y4H5TX4
6nuocR06i756/9hERZP6cTi9uQo/92dOhuSCImgpJy5AegbPppkfP8GEudGXMrRj
/FvYjLi0f32oQJVC3HJDYH7rvOl6BVD9Y6U4Ex/iFI7A4dNShd/Swz6oEWPwLkHQ
ytfG4yQhpl4nxrch0S5j6CByMBGCXKCfwZHpYlVPsZ7Sn2zAYqrDfE5KgVINpOXF
H9tm9JhisfXzFNkJmjl5DMDlS1j4fxBFuf5QglUlya7KVZZpTVuQ7NbHjOaf4aMw
7hiNbSuunU3TKVSEVhvJzZMfBmZQyNw69eyv0r/vHQYPX/JettTTN+2RPFEZV/3W
5h1r3U+p
=SX64
-----END PGP SIGNATURE-----

--RiKvc8bKMxhimlTG--
