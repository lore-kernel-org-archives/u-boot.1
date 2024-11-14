Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778E2D6A221
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 17:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0DFB89607;
	Thu, 14 Nov 2024 18:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iBls+O51";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F8498963D; Thu, 14 Nov 2024 18:27:12 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDF3B88E41
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 18:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-296085d59caso555715fac.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 09:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731605229; x=1732210029; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9vonQd0zqYfIAu5/GgSjc6blD+ZULZRsyt/Pwmf+lMg=;
 b=iBls+O51oKEPd58oOZGzlAQJk1LV4XraGGsapkDLLzuluT0OMfb4eLaTFMBOLYxNvF
 95215g0cDv8QFdSb94kQ6xgXVcIpou7PzLTk2LxdYicSKyTeZEBX1PtBHTar2DyTvauy
 3a5GkVdEFdc433NK4KNUZDAPJE7ZbrwKVlIrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731605229; x=1732210029;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vonQd0zqYfIAu5/GgSjc6blD+ZULZRsyt/Pwmf+lMg=;
 b=HZUMYvqgL3mstgYlQUT1CXx4lvuC3wyTrpWbCR/KWnVOlO43wnr8+Krl6NXrw+H3C5
 eVVlvJ8Y9P12Ski6tKXwTrgZ3Xnl6I1vgfHfhAt+vi0GYN6KcCyWmkyyRKQH0SYC01+C
 7s/TN4xxX7IV+5HpLVoWD0kDc6o5nSPCe3/HCklwu8tZWJV8NjSHcXaFhqqDdDOjrYF0
 RNyeRVAmOOs8st1mnNuFMw/9eC/38xEweJy/vZaRrplwpxCEeK72/IkE6SGx+fBdHL7p
 IwE+izeagMn02EDZ/DXMWShuk+kaHwv+74Mygl+gRgTLO8Ds0PG8VMHTei8R7+qN/kOa
 +mwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLuyAxA+TEZaPQrRlXTI/Co2viFncOoKex7bZ4v4TmU0umr7k0xjxDOvT22Cql6olP8dPwqUw=@lists.denx.de
X-Gm-Message-State: AOJu0YyBaunZ4j5sbktxssHIlJ37plA4TjmZ1KpANwjZpEb+kd82/8Ra
 UQfmdhhcXTiQpsjQNQfSdRO8MYMOcUXDavd5C907qpzfMKhN0PRpBeu+a8zEJcQ=
X-Google-Smtp-Source: AGHT+IGHH7UP6naBblnIaF2ChBL48r8ASYzJH25+zM9rSR+7YdDjiS1DSeYqX80amcqShl4ASQzPGA==
X-Received: by 2002:a05:6870:3910:b0:295:51e0:9241 with SMTP id
 586e51a60fabf-295602f3923mr24072760fac.37.1731605228607; 
 Thu, 14 Nov 2024 09:27:08 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2961089fa73sm629979fac.16.2024.11.14.09.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 09:27:07 -0800 (PST)
Date: Thu, 14 Nov 2024 11:26:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Hugo Cornelis <hugo.cornelis@essensium.com>,
 Simon Glass <sjg@chromium.org>, Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Dahl <ada@thorsis.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] tools: use cryptographically safe RNG
Message-ID: <20241114172654.GA4059396@bill-the-cat>
References: <20241102163259.305802-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AIdnFqzmEcblPwEy"
Content-Disposition: inline
In-Reply-To: <20241102163259.305802-1-heinrich.schuchardt@canonical.com>
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


--AIdnFqzmEcblPwEy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 02, 2024 at 05:32:59PM +0100, Heinrich Schuchardt wrote:

> The PRNG implementing the random() function only has 2^31 states and
> therefore is unsafe to use for cryptography. Use arc4random() instead.
>=20
> Fixes: cc34f04efd63 ("tools: image-host.c: use random instead of rand")
> Addresses-Coverity-ID: 312953 Calling risky function
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  tools/image-host.c | 35 +++--------------------------------
>  1 file changed, 3 insertions(+), 32 deletions(-)

Now I get:
/home/uboot/u-boot/u-boot/tools/image-host.c: In function 'fit_image_setup_=
cipher':
/home/uboot/u-boot/u-boot/tools/image-host.c:439:17: warning: implicit decl=
aration of function 'arc4random_buf' [-Wimplicit-function-declaration]
  439 |                 arc4random_buf((void *)info->iv, info->cipher->iv_l=
en);
      |                 ^~~~~~~~~~~~~~
/usr/bin/ld: tools/image-host.o: in function `fit_image_cipher_data':
image-host.c:(.text+0xb41): undefined reference to `arc4random_buf'
collect2: error: ld returned 1 exit status
make[3]: *** [scripts/Makefile.host:104: tools/dumpimage] Error 1

in the docker container. I gather this means arc4random_buf is not as
widely available as assumed.

--=20
Tom

--AIdnFqzmEcblPwEy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc2MtMACgkQFHw5/5Y0
tyzwJwv9FMzixlmmriGMW4vSe9Yne0mWlVDc+fEPEQyclLCEdJJyYaVtALpI+dRh
q7RFEFT/6yb8nfI5GUv+W/SqaZFvniduka/4i8yd3rXQxylRsri5C+y5Q3ut/EM0
mYh2TRek3m15Jrv/rPAB2nPAE6ePKZcv5hTsrU2Yt7KwYwoBJQYGxmF6ZW4TDb51
NXmzBH1DRu0w4tT74Cem+L2WUDbJwPOfi7LutEXVwql2r/Adg3e8cgBqJd/5FS37
16Lyiq6t/T5sAB4tS6IGS8jgYoy4p/W58MGYS/JLnTGpSEDvxwI6OHBWJCxPQMCe
weKxR8UVZNb1rTU8llYLAMwxEuLRjbtuEvMQhtrv955zSPcQuaAopktDwGEg85Rl
2yLPTkahTzCMiuUozPxvP8kEm7FuAjMbnT57NpldfhPSroGlDFruldbIImsUNBjZ
H2l3CoYOFxTCPe1E55yJMVMSBC60hT3cVCdeS+x7rrIVyZSkjzg88kn8BNL5GMFl
Xk+Jnsoa
=zkG3
-----END PGP SIGNATURE-----

--AIdnFqzmEcblPwEy--
