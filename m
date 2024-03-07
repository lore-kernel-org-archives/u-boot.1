Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2AEC54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 17:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73F5287C83;
	Thu,  7 Mar 2024 18:12:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s6LYQaaz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA6187B77; Thu,  7 Mar 2024 18:12:46 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 941B787C83
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 18:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-68ffddd89d1so6196456d6.0
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 09:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709831557; x=1710436357; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vuQArpVCDULy2IKQlNZaX//dGdnSZuXajtSb87vk9h8=;
 b=s6LYQaazWhQ3tHihSW41hbhBVPoZEE8Pq+FRfxIqUbkVt/6RDcs60oYw64TNwAl6yM
 NtyFHDoL1w6jBCsl1pQnW6pj9aaaM1fzjKe0UoBoi+of5MGopc+rx3+KgrV061SLSOgN
 KSRx79TLtCXXfuqZ51xbV2x5pdkYdD1zcwEeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709831557; x=1710436357;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vuQArpVCDULy2IKQlNZaX//dGdnSZuXajtSb87vk9h8=;
 b=fDpJWwaWHsYXHHNhX/CiK3eYdgHPjHEvhjIhVPvhyCOrPCyWKjzrvAW3C6hnYTOJHi
 7uN9utFNcDKUiDkE59mskqqb2VJJ/KobAClMfkPMwEGMGbhZqXbO9gHyRmCjQJbWfltP
 NCJrTKchNAgbw7CDXBsdN9Qxpd4mxlI5nSGklSIN79uTEU1bqGf/LhkSCKBOcp/xaCsa
 N6NC/ucZtAjRoMDvEiUu1Qv9idcXLGAwjPBhB+Ubj69OdH9oIE80PckbDK5bP/c/5lqt
 tp2IinJebfRmKJmY4SUJyrFxLeqWTMCegledShzbmNHpLQJrVK5bXdYAEnVqhmNBKQ76
 FcBg==
X-Gm-Message-State: AOJu0YzioRsLPwJSPlLFQ3aR5I90aPf3255DueGcm0Ss+8eJLkkgOrct
 uLB0WAZDNbVmI00ZNvRoQsmJ825uprO+iRQWGIKQ+dqXKBfF+mN1SXW2TR+IYm0=
X-Google-Smtp-Source: AGHT+IEieeVP4UwajsH8OHbGV1ldnMpj5qtvqrZ0aOZpp+tnOVCTOnZOwzs0rBGBSN7Z+06xw/bd1Q==
X-Received: by 2002:a0c:ab4f:0:b0:690:4e5e:c01e with SMTP id
 i15-20020a0cab4f000000b006904e5ec01emr9136353qvb.0.1709831557429; 
 Thu, 07 Mar 2024 09:12:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:7f::1001]) by smtp.gmail.com with ESMTPSA id
 lr9-20020a0562145bc900b006904ca1971esm8541547qvb.42.2024.03.07.09.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 09:12:36 -0800 (PST)
Date: Thu, 7 Mar 2024 12:12:34 -0500
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, nm@ti.com, upstream@lists.phytec.de,
	d-gole@ti.com
Subject: Re: [PATCH v3 1/2] board: phytec: am64x: Add PHYTEC phyCORE-AM64x SoM
Message-ID: <20240307171234.GO1523872@bill-the-cat>
References: <20240228084217.935848-1-w.egorov@phytec.de>
 <20240228084217.935848-2-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H58upOzXQjLnT0lP"
Content-Disposition: inline
In-Reply-To: <20240228084217.935848-2-w.egorov@phytec.de>
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


--H58upOzXQjLnT0lP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 09:42:16AM +0100, Wadim Egorov wrote:

> Add support for PHYTEC phyCORE-AM64x SoM.
>=20
> Supported features:
>   - 2GB DDR4 RAM
>   - eMMC Flash
>   - external uSD
>   - OSPI NOR Flash
>   - debug UART
>=20
> Product page SoM: https://www.phytec.com/product/phycore-am64x
>=20
> Device trees were taken from Linux v6.8-rc2.
>=20
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Please note that the MAINTAINERS file here wasn't updated from the am62x
platform and I corrected that. With that, applied to u-boot/next, thanks!

--=20
Tom

--H58upOzXQjLnT0lP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXp9YIACgkQFHw5/5Y0
tyz6xAv+M0aSh52mH5YX0vauNNFBLPbEIgJ0xwAk3fu+0tnxm6jCoqQXbaMq96Jq
+qaKnA7ERIDgQM43iUprOz949EzC9KTj14S7CLLPxVmPdHiMOufmCw4J7w6GsvhJ
XInJs5KtQkNfsDezO4lMQ3C0+iYnlhrC3tHSfpjAFc/EQkZ2I4jHw4q1wO7Qczea
6Tp2FamFC6ypg3rgyFV7CjpuY1TboAeHRsUds2KSaqj0FYwnJmcEAObCicETAxPd
ox7hZsCUZyK4jMOqmr47YNAIJCRAdvPASBQT8TeqT+A4+Y59x60AdMz49ihikZRT
i3TKQbGbgE8KsK6M71LQPbkCwaIih9Boya5MM0sLv30+C4gfq4gxsFZNV4GIXF0x
VuXRBT6/ypj5UC/3Q3dHctVLurOLJVhlnVQ6CphjKUluWHnAht6hukGWBiLeOii1
03+ABpYTtAguyzvJ5QpXgDky30OIFv57idsUEwEzYz7Z2qC5F7D6aQFG/P5tfdnh
eFX6UsQc
=t8ME
-----END PGP SIGNATURE-----

--H58upOzXQjLnT0lP--
