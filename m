Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BD5C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 19:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C75DE8007D;
	Wed, 30 Apr 2025 21:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="moRK2Nuq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F41800C1; Wed, 30 Apr 2025 21:14:39 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CCED8004F
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 21:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72c173211feso50489a34.1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 12:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746040476; x=1746645276; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UyVrMqf5JDF2XZBishjnBfTkWZJQGH+FA1wll+Wgo2E=;
 b=moRK2NuqsqyOoFiO5ucQnf9/+X7zAcwFXS5hIBnD0QTJU7bgAhYxiC9c/9pEz7zSlw
 79sxMuqo5Okab9T0qTK4EpDyIT4NUCMsb3kxJd1XNDzg3yqBb5r+rATzwD8S33AqtYkH
 m7JM1a617TzQdjdSyYn//FDFezcZI7U2BeIsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746040476; x=1746645276;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UyVrMqf5JDF2XZBishjnBfTkWZJQGH+FA1wll+Wgo2E=;
 b=cFYGgTyoeqNBvNVVQ0XxCCGBtgZbFLirbU8rNyCmaAqr1dBPaOWA1A0i4LS7nTWsBQ
 TOIc5Ovv7ogRvpl+tLZYv+GqiUBux76M6DyrqxSe2k9i7griOqVUWoPEBVzPoOINkOpi
 9P84gj0ESFd+NcuvMGE8OVxH5zK29BvhmVNL2ZbvqD07i7wEiuyKbrBe+MxPl1xRrWFM
 pkaE/+gG4fZUQy8pRPGNTYPDDLwe6R7YpWVBm7lgsBSU9+iK45aJ9b6H/VLNiz9Tbz7C
 XKrxvyjnUYLPthhWL96cNR1QhPHW1qhRnIUSuJmRPnXtA1VBT0omWKr7EBeLd1LSgNb4
 2NFw==
X-Gm-Message-State: AOJu0Yy+GoEag3xMf2ulvJvL/0cvF5b2y/rZL742Anw8IQKnjajsgggx
 yj5dmSMSm2YkQFBGeO8/BgCTDeRl/9jl4Iu/67ygMm0R1mo2mCEqHnhAT94aA+U=
X-Gm-Gg: ASbGncslLvU1wkOfkHD4Q0Qr104KdxfLY5xVmouFM4eA1YaI87HeetqKgzZcLvE0YZV
 CE/wfKdAbwMLwW25LPr5PfZbcuxcThS6+G0Wp6D/B7SDxIAgBH8+laEX65Gv30RIuFDZB9Jlu3X
 RHlh7k1qlXtzojApKKMQORCLRmEG1n/2eGDCp6n76iekUss/K+ODUhv1cTguywKbkGypxaanCnC
 Hj4QDDpTLP7xGGmRtru/lae2ME7N1BDTX9hZbE39kcPTQ+p2/4y3T5p6Z/ro6rDeRhdrduFxriR
 /ZOpDkmkvGKe1lJO3I96+4MgeUjvjzqB4fRa06EGdOVLVtnaqSadAeGVdANWagYvNI3gKXc7AyX
 MYA==
X-Google-Smtp-Source: AGHT+IEp7bRfFmJMx84Cx4j3fXlxCXYlfA5aSu7IUMCsktqz/e0BxJIJyaVfnSb37bLm2Qltcd0p0w==
X-Received: by 2002:a05:6808:3308:b0:402:18a1:843f with SMTP id
 5614622812f47-402d24f2d2bmr2468537b6e.32.1746040475889; 
 Wed, 30 Apr 2025 12:14:35 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-402129255a2sm911351b6e.13.2025.04.30.12.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 12:14:35 -0700 (PDT)
Date: Wed, 30 Apr 2025 13:14:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20250430191432.GY1261075@bill-the-cat>
References: <20250428215930.GI5495@bill-the-cat>
 <0ffea631-2d8a-4f24-abfd-ef4aaeca01c8@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0FuBhzo+AAcSU0JU"
Content-Disposition: inline
In-Reply-To: <0ffea631-2d8a-4f24-abfd-ef4aaeca01c8@gmx.de>
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


--0FuBhzo+AAcSU0JU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 08:23:29PM +0200, Heinrich Schuchardt wrote:
> On 28.04.25 23:59, Tom Rini wrote:
> > Hey all,
> >=20
> > Here's the latest set of Coverity defects. Please let me know if some of
> > these are false positives for example, thanks.
>=20
> Hello Tom,
>=20
> I have marked the acpi_update_header() items as "intentional" in Coverity:
>=20
> 550301
> 550291
> 550288
> 550287
>=20
> We could change the parameter of acpi_update_checksum() to const void * to
> make Coverity happy but we would loose the type checking.

Sounds good, thanks!

--=20
Tom

--0FuBhzo+AAcSU0JU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgSdpAACgkQFHw5/5Y0
tyz1vgv+LMl+gDYuAXMPPLWPZfkBtoXFkBf61z1z/v3exf74SYMikVZOOVaSm8BX
0DkaduXIYAedvBIeSwLsPTLiH0EUEsvrOvpUB3YRjo0tcn3wuohxEFv/D6uKQ6er
+SoKerfjUZUkOp7d+mZ8K/fxvJOHzXfVinjrVZUUvH8bow3q/NF21Zq8wJpw9rjS
mrz941zdtzaN71vs308qPhzS415YEYwoBpjwOe3wOP9B4F0GrpAaI0fUKrOHovnp
2ARFMDtp4HjkwlBCanb89ylrjp7gJbOwbzh8M7Rhq/qx6LuVEd148gm52RdqWHBW
Yntb0dIGwlaul9ALkqL/XAmOS8Bhircs2/6nUhNXozgZNfoqRtN5vnJugZHzHOZR
js9Hw7M+xh3c4YRc9tl8bz8GxFWFWrNDs9uGQ4NwvJeaLNgMP6dW7QlxI+tT12n7
1SDjMQcBB/pvAzjULsYbsSAc1ZuUWypwD0lDPCU56b2YeZhArOT2yp2y9jEje/et
U6dVAjee
=ZAeu
-----END PGP SIGNATURE-----

--0FuBhzo+AAcSU0JU--
