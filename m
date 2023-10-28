Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAC2C0032E
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 13:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92DCC87C0E;
	Sat, 28 Oct 2023 15:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ix2XYQ+4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BCF287BEB; Sat, 28 Oct 2023 15:27:40 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DAD087BEA
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 15:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7789cb322deso222910685a.3
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698499657; x=1699104457; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DmyjfXdhDkKRwKH7O5nKPaZO9fLNP7wLraUpGYP6URk=;
 b=Ix2XYQ+4t1FD0oNOEmMMTAHfcyaejfR6mDFTNEOeSYpmBXq1X8zhgPNDZVuUDGwz0L
 k4anfkw7NAbzz0PqOq+3buViNbiOgVMizX2GoM8lzKx0t4e2ek9t8K4mVYBp58JGr+O4
 8vMS3Yb1+OrR3rvOWyr2QHX9jBoso8QjfzAM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698499657; x=1699104457;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmyjfXdhDkKRwKH7O5nKPaZO9fLNP7wLraUpGYP6URk=;
 b=sbEXggx4gw66Dbc4zNRZ4Jw6oWixNuOAmtUBtNGulvWvlBO0r/RTah/5UzCPXzbgHd
 tyoRFJMmT1bgOfbZqDaME/ORYcD2+XG4umnEp+9YmZyl93+vcCHfovlY426Ev+rpQJx/
 osHjdZKKkKvmwvtIspQaDTfEStZcpODkEgYJizCQnlcna4FWyhVm6W28SM8yKgsyeUNl
 DtgE8S1U/QhaCCe31ikCK6O5WouiAlp3q6SdAl6R1e8OEkLmwmYS0meMzm9xrSTvAWAQ
 PREy/MVcMdOYRal+/pYuKFD6aX3nRSho33ZrpqJ80JoCMscV2c8fY0FO1gJhnoUX8uT9
 9Sog==
X-Gm-Message-State: AOJu0YwvWZxNN23fLLfnZSnHUTTsOytMiLknmkoz6NZthTtk2cAir7sL
 b0fNVIJCXALPL5C5NvskpQhKyg==
X-Google-Smtp-Source: AGHT+IEoZ0a5BLsdBYkPRT8qOYhv/7+bAReUCf/IASt0SrXs1Vy5VsIocjhMQYA/BJPHsZlnSvV69g==
X-Received: by 2002:a05:622a:89:b0:41c:bfeb:3672 with SMTP id
 o9-20020a05622a008900b0041cbfeb3672mr5792901qtw.47.1698499657033; 
 Sat, 28 Oct 2023 06:27:37 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com.
 [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
 by smtp.gmail.com with ESMTPSA id
 x21-20020ac86b55000000b004166ab2e509sm1584910qts.92.2023.10.28.06.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 06:27:36 -0700 (PDT)
Date: Sat, 28 Oct 2023 09:27:34 -0400
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, masahisa.kojima@linaro.org,
 ryosuke.saito@linaro.org, Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] board: synquacer: Update the flash image layout
Message-ID: <20231028132734.GP496310@bill-the-cat>
References: <20231019135419.162726-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UOi2vPHIqXFFPqxC"
Content-Disposition: inline
In-Reply-To: <20231019135419.162726-1-ilias.apalodimas@linaro.org>
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


--UOi2vPHIqXFFPqxC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 04:54:19PM +0300, Ilias Apalodimas wrote:

> The SynQuacer Developerbox, in EFI mode, supports A/B capsule
> updates and single image ones. The flash layout in the latter case is
> outdated, update it with the new offsets and images
>=20
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Tested-By: Masahisa Kojima <masahisa.kojima@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--UOi2vPHIqXFFPqxC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU9DEYACgkQFHw5/5Y0
tyzlmgv/XbM9keVvKpI++IPI1A8xwc3bByjL8ewmNsiWzJ3Z5smxn0CQPKE7FJ5e
9TerSdQBKOELunlUIlRVgW469ZanQzcltBM6AoU2XOoHG1gNc0Bs0AayeMHvlnA9
Gi++JdEgkwHtRNq5VNmcotumhUO9K5EZIROYowh5BPFoZ2Kgej0F+dzmAzW59GFJ
axyM7zPKytSr/9ulwRgx/e8iHRb4LdVsQVSDgvgqlwgBkjAL/rnzSpVuIKCPAQVZ
oHFSIpDvPf2YunaUUCkm8aPtby980sjERct0iArgCg4qxni+TzKzfy7dczSFIIBP
CSrCQ9NG/2IKe6SBoavcaswyrUx1FAWV25QTWnmeqxOhuq+Dg8reOlU4gEkcKnok
BP6goJsF7QMDs9UBgsgFadLZEOFXD81cLNaySOlOafsneASrQUo3ShyBsr8z3w6u
EPq8WxCGxxZAHd8ZbzT2JHTSWYSwhGV6rBuEFTcf8OglvoncA3dVtNqpttn5Ij9f
Au1CIDwc
=5Bnp
-----END PGP SIGNATURE-----

--UOi2vPHIqXFFPqxC--
