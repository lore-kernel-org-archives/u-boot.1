Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5EAC3ABD8
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 15:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE2FB8129F;
	Wed, 14 May 2025 17:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pUCUDnMU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4BC381DD6; Wed, 14 May 2025 17:05:01 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C4B8059D
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 17:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-72ecb4d9a10so7522995a34.3
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747235098; x=1747839898; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EOP2AT7r+O7UOf3CMGRDKfsRJwswzs+A3Wfttdt8GI8=;
 b=pUCUDnMUchM3cZ+JfOSkaYNPk3mI6LSW2OYPk1A4SR++CO7e+YmsWeYwuwBUVlAqzC
 SpV9AFFgbwVjQvmVdQCxhO55Z7KBfqjDnHrR4SeooIhwmIwzydxPdFKoFvRLgI7QX5hy
 jrH0n9kdB0WVTB9tzSHdgwEgTMlbOuyHVfs8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747235098; x=1747839898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOP2AT7r+O7UOf3CMGRDKfsRJwswzs+A3Wfttdt8GI8=;
 b=FD8+9lmEjh6nI1ec1P22hJFDRsfVQGACC8qbr8iQ4yDvTWzUZ7Xp5VMBGb/1dWkiKw
 x0z0ODLO3cYq5rPPOrQ5+ksL65BaJa3LhcuFmHqi+Qx1HWuM7VoAJ9pDhkU1o3kikbDw
 6FmXgrqhIRMJxDgoNFDnT7FJlNbsijbIZDRhCQqkXUd9LV/CcFciV6R359TrPhReXjPe
 nX2zMiK7fEtUmdXXJFfObtYlJiVcVgoI3l1OoGMPTod6H9KnmqqHE3+hsDR9sFsxAUrS
 i2+0XXIcuPSt7+/Qvc8v/eavk6V5XxRe9WtFbrJa/3rtFCwS7eiOw5vuNCXyiqUWwzLv
 /zIQ==
X-Gm-Message-State: AOJu0YykO8ClqgzQNOHODg/06Gzs7lKEV/EfrHeWi8k/if58dMQpyFmV
 QnpllR5/8u8Ba6AqJ5rZ+6fxWx/Y+WEfGj3xIvSVaV/HqT6eoaHuFHYi7NucmmE=
X-Gm-Gg: ASbGnctq+TH01XHH3ig73+zpd04m6T85O08lzjZMTpr88OS47wTPtrPcYHLUZZPSD9a
 7l5ZRCeGEB2maoONdR3yWiFXIatCrF56aO02q+GwhwGBaSCAmq7L1neLPIV5SPBtQuCUAKOCppW
 7BJy6LRnmUWdbvaIBfNQ1EaoNO7jE29E1TPwvoR1msNJmU2RynAs6SkZ91tDl9ydwDagja0xJzX
 Bv7CeBC8PQQWlzcY3ROQV7dFN1rZddhiFOiBn/xykIEIwOp9GBW6JcLykAtHSs+3u51CUsG/NGF
 nzbMq54K5tH3iuC5rTO5gXI9GZ17+2xv7+AGZugm0p3YIkrK7pue+vICKV1NiuIMGiH677OqW0w
 a4dxvsuBfyl/G
X-Google-Smtp-Source: AGHT+IEiRGCJGmQUZ4uQhHXJn6Np/ZIMYOVRW6caA0O8nqMjScpR2X1wzf1LJ878gGCltNHfPQKhQA==
X-Received: by 2002:a05:6870:89a4:b0:2df:a9d0:1dc9 with SMTP id
 586e51a60fabf-2e3488718bbmr2022902fac.37.1747235097681; 
 Wed, 14 May 2025 08:04:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba0619e78sm2659175fac.3.2025.05.14.08.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 08:04:56 -0700 (PDT)
Date: Wed, 14 May 2025 09:04:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, jerome.forissier@linaro.org,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH v2 3/3] py/tests/test_efi_loader.py: execute HTTP testing
Message-ID: <20250514150454.GW603748@bill-the-cat>
References: <20250514074513.3562063-1-adriano.cordova@canonical.com>
 <20250514074513.3562063-4-adriano.cordova@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LY4K+97l++oKXAXE"
Content-Disposition: inline
In-Reply-To: <20250514074513.3562063-4-adriano.cordova@canonical.com>
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


--LY4K+97l++oKXAXE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 03:45:13AM -0400, Adriano Cordova wrote:

> Execute test_efi_helloworld_net_http
>=20
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>=20
> v2:
>  - remove --httpserver option
>=20
>  test/py/tests/test_efi_loader.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_lo=
ader.py
> index 91f151d09cd..e19920b4fce 100644
> --- a/test/py/tests/test_efi_loader.py
> +++ b/test/py/tests/test_efi_loader.py
> @@ -195,7 +195,7 @@ def test_efi_helloworld_net_http(ubman):
> =20
>      Call the do_test_efi_helloworld_net function to execute the test via=
 HTTP.
>      """
> -    if ubman.config.env.get('env__efi_helloworld_net_http_test_skip', Tr=
ue):
> +    if ubman.config.env.get('env__efi_helloworld_net_http_test_skip', Fa=
lse):
>          pytest.skip('helloworld.efi HTTP test is not enabled!')
> =20
>      do_test_efi_helloworld_net(ubman, PROTO_HTTP);

Is this test inverted, or were you unaware of the u-boot-test-hooks side
at for example:
https://source.denx.de/u-boot/u-boot-test-hooks/-/blob/master/py/travis-ci/=
u_boot_boardenv_qemu_arm64_na.py?ref_type=3Dheads

--=20
Tom

--LY4K+97l++oKXAXE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgksRAACgkQFHw5/5Y0
tyyT5wv/YEu0D8BjegjGsF95yyRONkX+XOZrcrvj2w40TJPsVPJryCYht5On9Qih
plctt8m9afk5sqYvEvC7RPKy2luM2DJA9bhFnEwXRKgbgpMIuO9VnNHyerBFbwTy
G+GGEdvTiHu1GrwgYtcYsrcC843tMncbaWv9/w3hG9rvT6CtxSwwBVAzRls3YKwo
T4hoRHtskAwsyxgtChXUI4QgDK83TQhuROExMQv83TMeOEG2ebGZ01I+2WUVVwO/
cFMj5asZ2kg4gEbnfm6SWtpc52LZfJbmF8S40csKRM2mtiO/3nfWoOwoC6phHTRr
Ewl+Vh6VX8qzshL1/YhNlTgxp83d0TwFILHopNEP9XBH5tmjA6d95lzDERjzD2nR
2OBDJRSrcINhyaP2YU6ATOt/jhq1SbKQKN7Dc3K9NFP4Dvx2RFCM4Vi+1MtF9I0p
/pZLjYFIC7I84+UeESa6OBFDwG1i3TWn1uhZhbrMVdC+32ZxJHhmeY92RBTRoI2q
tTmqwyRr
=RyVS
-----END PGP SIGNATURE-----

--LY4K+97l++oKXAXE--
