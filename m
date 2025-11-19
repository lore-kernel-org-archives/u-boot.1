Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C606BCF3959
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 17:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D11C83FF9;
	Wed, 19 Nov 2025 18:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DXR3Ah6Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D05A83FF9; Wed, 19 Nov 2025 18:05:33 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67F5E84021
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-65363319bacso2863849eaf.2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 09:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763571930; x=1764176730; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NsEv4GKnOMEYHFj8Ek+4IhD/LOkD/LY2F/uKEMTF2ek=;
 b=DXR3Ah6Yz9bhu9JH0OkQHT3YiC3U9g6XFGGu9MBaZOiPLuJKQmzHp3algupkDS0jsL
 fG+VsR982BmPcbxP3gOdj7ME+NFqDtV0q7uwdwwpHVlVR+bh5yfEyzxjN25vnzHtq/e9
 Re35k+0+n3q9O9I2XeI7ITwLuOnjYVUulqp/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763571930; x=1764176730;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NsEv4GKnOMEYHFj8Ek+4IhD/LOkD/LY2F/uKEMTF2ek=;
 b=o/Ku5BmFVweysVc94gqmzQcYXiHjXqIxQV+Tz7I6GloKOCyXIuzRO2favx7UEgoldf
 bryiwVcEKISCVxtYEB+huTWnlDYzcAuZ7p3DFOnS2Mx81IjXa8PAQbIwAPkpYevHOV62
 qREzX8E3G22bSOGzLBv6VPnFxsYw4N1GtsfwfGFQdCqxBdOakIfpksBsa665KR/8znlV
 MIaH2/UXd9P7HKkxQW6BEkESqy7HzBHZCMVWRbT/Ty118s3S+JFKYSlq/gjgjeUEJETa
 CHx8DmSGeQu5IwVF9hDzg+PkNVOM2nYXokEPpAS2wcxQMxOqQq//+Bmra4VaWurGblAS
 4sSQ==
X-Gm-Message-State: AOJu0YyuRfENxDlN9EnUGTFkCy+h2672pt5EQir3jVDDUTVFZo8OIPvu
 +yQKh/qL8u/SjAq0ZMf3YpNLOymHmuulvF6Z32xCJLii2KWvKCfU/aGGWr/23hkq8NM=
X-Gm-Gg: ASbGncuBJp1EW2fIsYGxjlyHi6dZCRptnBg35z/4xOVSra53dIL7bPlLDSKd98kG4Yf
 XLjkEXnGHMGJ5n07Yy8OE/fU0V94PQdbWNdj/y60Jr3tNyAhRgFNirt9W+HY+cDdVZ7VYHC5NhR
 CBixG2DutIdxBQ0enU4Cn4NbkoI6Lue65Q7TSTTDYG3YJKsW+ZYErvwW+6amZJsuJXEXmDubJ4F
 NbqdKzIhNw9rtHKto6uAwX/oo2ypydBZ+YLaVX1WDYl5EodVY6EIW0DKQRHGFsc5ok9enkP0YPr
 xPJywJg8R0QywFum8bco/sWwcQ5hVs8Wwtcztxr0/eEL9WLeRa1Soq/GwRTFgcEg5j2xfZDGaRZ
 EX7DOTKtdg/cTVuPWUQO+rZFNFwhT4Jx8ZsAg+nnrsyfiHwRwGSyYljpVr6OQLYzrzOrpAxvIaU
 2nGMAy9ZWeweO/LsxC0IQ3/fJ/KFfYx2RWu30g/yuAByoFrqbjKQ==
X-Google-Smtp-Source: AGHT+IGNlAxNmv6MwsEeoyvy1k2l7H8A2CyNU2pWCRW6LSOxQrO3yVVhOIQ2nBMIZpbfNEsridp1Yg==
X-Received: by 2002:a05:6808:218a:b0:450:5aa0:3681 with SMTP id
 5614622812f47-4509744f567mr8924086b6e.4.1763571929807; 
 Wed, 19 Nov 2025 09:05:29 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a6d7b24sm6177940b6e.21.2025.11.19.09.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 09:05:29 -0800 (PST)
Date: Wed, 19 Nov 2025 11:05:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Robinson <pbrobinson@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <hackpascal@gmail.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Max Merchel <Max.Merchel@ew.tq-group.com>, Mario Six <mario.six@gdsys.cc>,
 =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>,
 Sinan Akman <sinan@writeme.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 3/5] arm: omap3: remove leftover from CM_T35 support
 removal
Message-ID: <20251119170526.GC2125796@bill-the-cat>
References: <20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de>
 <20251119-legacy-led-unused-code-v1-3-bc0ae1235baa@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FBxXkJ7bQ5nqHUQW"
Content-Disposition: inline
In-Reply-To: <20251119-legacy-led-unused-code-v1-3-bc0ae1235baa@cherry.de>
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


--FBxXkJ7bQ5nqHUQW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 05:43:47PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> Commit 76386d6195a1 ("arm: Remove cm_t35 board") removed support for the
> board that was built when TARGET_CM_T35 is selected, but removal of the
> symbol was forgotten, so let's fix this oversight.
>=20
> While at it, update the README for omap3 to remove the last mention of
> cm_t35.
>=20
> Fixes: 76386d6195a1 ("arm: Remove cm_t35 board")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--FBxXkJ7bQ5nqHUQW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaR341gAKCRAr4qD1Cr/k
Cu7uAP9U0ixEpfTx5tcMDbz20LHFN0zW6LUxMdfbQJkMs71bxwD+PYPXLfEF5aaO
0SVALSkSvDytHVCsfqrb9Gge62qUawQ=
=CtwP
-----END PGP SIGNATURE-----

--FBxXkJ7bQ5nqHUQW--
