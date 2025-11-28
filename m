Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35FECFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C453E84568;
	Fri, 28 Nov 2025 15:06:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bpRf64Uz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A0DA8456B; Fri, 28 Nov 2025 15:06:36 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 280B684565
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 15:06:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c75a5cb752so1038391a34.2
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 06:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764338791; x=1764943591; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=giG/moWrlB0eMXucSkwUbfXXdJf63BbiyuiGV6mrXHU=;
 b=bpRf64UzC2fOefiJkE8C75bkcnpxwGhz/+nmC+eZZdHX4upeUn+LqWPjEY/IHFc+f/
 KxW01aA0KTH7dOFeg/w7bwZQ1uM/i5D2LhN9Nrk7UBgMJxgOt9fpZCJEw+Wuy7WHuzb8
 AAAKlVB0ot4ynSPKJSMQdDVnAsx/weoCn0cHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764338791; x=1764943591;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=giG/moWrlB0eMXucSkwUbfXXdJf63BbiyuiGV6mrXHU=;
 b=WGKEko5fMYzGxo/qQmZEV6NtMQZkwKM4q4hEzsEVdfOpinPdTsbjeJjD1q6VjXEKw6
 qI4GwLhZHBlI2BUdzwrDlUjcno6UngXfxZLDTO4CMLJELEaUvxtxRdU6XW5dfKe6u+EH
 p4QMf/fCa0jozurHXbRVLHb0EZ5JdmN5y55ZFjOZ+9k13IhoBkfUj2cMxKL9q7vwln0H
 rOKnXG2lvSANcMsq3hYPv9OhX2KWQhx74z++sqPj16Mw6Fi52/X7cc0LzRJdZ/fUMIy+
 E93GCxD9VQtEYk8KygnrvXlPAPqf5bmCCTQEjLok0EJ7wZpijGQuy2sOzN0rbFkMMV7+
 zILg==
X-Gm-Message-State: AOJu0Yy1HnwZWNM5oCU1SVuAsGCW+k5E6lRIuEo8h8mGjknCpzeyVu+z
 8lDc6SK91uiJOBBoX/ttHAPmO547LRWxhtsUE6qID8OyQCaa36Mg6Frtu1D9sSdaWSg=
X-Gm-Gg: ASbGncsbqF8dQKKvevMRrXlDGczn+SrdRwdcteb32JveN5fo68WgRLwRrhPtUoIdxvr
 OHND78gYR8tUc1ztz59RSb7W4uAL038MlwnDin/LssP6NnUvT1bWgsscTlL92FF96hb+wnoRa3Y
 EiIKSq0yYNrodU+oQBdmWS6X3je0GL6fwOniCgIKqG4K3e9wvi58QyF5v6ZDUtRlzQl0dir+qxP
 D9scodqwuEvSYDYGyTPv0ji5jDKECVj5v5SabakHDwzsK4GSGipwKsxzbJh89hfv6ndQm/QI8UQ
 DeShrEv+mDFjUMPyhXxak+9aaeM1D3gJNOj7hvXbIkV6Zhzo7fe3T465nUjSL6/UZl2nuvO2AjK
 TvGsqtFhUQwaw9+DbD6QouqOz/PQznp9ZoL/s7dWI4b395Qk2VQWraOSggvY+2rro5ady/Z6y6x
 vP47xxiUt3AJpfj5L0GN2FLpwdAY3KkQFYcxbI7MRhXmlr9my/7w==
X-Google-Smtp-Source: AGHT+IGdfd2mZZpHwJ0zeTm9qAYXhhumxPYjs2FYnDv1o09dQao86xyyHrHlM5plK2KEP5xl4Qg8Rw==
X-Received: by 2002:a05:6830:924:b0:7c7:dff:2ac1 with SMTP id
 46e09a7af769-7c798b8a7dbmr14981675a34.3.1764338790738; 
 Fri, 28 Nov 2025 06:06:30 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5d7d82sm1597177a34.6.2025.11.28.06.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 06:06:29 -0800 (PST)
Date: Fri, 28 Nov 2025 08:06:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: u-boot@lists.denx.de, "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] configs: am335x_hs_evm_spi_defconfig: Remove duplicate
 symbols
Message-ID: <20251128140627.GY2125796@bill-the-cat>
References: <20251126-topic-am33-hs-evm-remove-duplicate-v2026-01-v1-1-5008cdb30536@baylibre.com>
 <20251126202925.GU2125796@bill-the-cat>
 <DEJR900FXLVU.1GCOQ4964FVP4@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n2jdRsru04vfpMAN"
Content-Disposition: inline
In-Reply-To: <DEJR900FXLVU.1GCOQ4964FVP4@baylibre.com>
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


--n2jdRsru04vfpMAN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 09:21:22PM +0100, Markus Schneider-Pargmann wrote:
> Hi Tom,
>=20
> On Wed Nov 26, 2025 at 9:29 PM CET, Tom Rini wrote:
> > On Wed, Nov 26, 2025 at 09:25:56PM +0100, Markus Schneider-Pargmann (TI=
=2Ecom) wrote:
> >> Remove symbols already present in the included file.
> >>=20
> >> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> >> ---
> >>  configs/am335x_hs_evm_spi_defconfig | 3 ---
> >>  1 file changed, 3 deletions(-)
> >>=20
> >> diff --git a/configs/am335x_hs_evm_spi_defconfig b/configs/am335x_hs_e=
vm_spi_defconfig
> >> index df009844defad13109adf2523580181b6ed6b5ca..ad1777f2bcb45bd2c84240=
11adc231f0e7d4ceee 100644
> >> --- a/configs/am335x_hs_evm_spi_defconfig
> >> +++ b/configs/am335x_hs_evm_spi_defconfig
> >> @@ -1,8 +1,5 @@
> >>  #include <configs/am335x_hs_evm_defconfig>
> >> =20
> >> -CONFIG_ARM=3Dy
> >> -CONFIG_ARCH_OMAP2PLUS=3Dy
> >> -
> >>  CONFIG_SPL_SPI_FLASH_SUPPORT=3Dy
> >>  CONFIG_SPL_SPI_SUPPORT=3Dy
> >
> > Did you confirm that buildman still works? That's usually the reason we
> > have this kind of duplication, thanks.
>=20
> Thanks for the hint. I wasn't aware of buildman, but it looks good.
>=20
> I checked if buildman still works for it just now with this command:
>=20
>   tools/buildman/buildman am335x_hs_evm_spi
>=20
> This worked. I am currently not sure if this is everything that can
> break with buildman?

Well hunh. We have, historically, needed some slight amount of
duplication in defconfigs that use #include in order to make sure it was
still parsed right by buildman, but it seems that's no longer true.
Thanks for checking.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--n2jdRsru04vfpMAN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSmsXAAKCRAr4qD1Cr/k
Cph9AQDeAOh46/OGQ4uCi7rgyvKFyh6VW4hiQFum2uy9Wv6gGwD8DpcP1arAk6sX
0D4duYxJsxJjYEej9i6WVwNAJkF4hwk=
=lsel
-----END PGP SIGNATURE-----

--n2jdRsru04vfpMAN--
