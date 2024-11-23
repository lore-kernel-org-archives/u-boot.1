Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD905E6ADE0
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 02:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE09C898A5;
	Sat, 23 Nov 2024 03:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FtDkaDqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FF6D8981B; Sat, 23 Nov 2024 03:42:20 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 310E6891E8
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 03:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-460c1ba306bso18829431cf.2
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 18:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732329737; x=1732934537; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qS6LZnuqWmu3cr8m8YoR332hZE2nmQf+M0c9UE4Na4Q=;
 b=FtDkaDqPx9NujkVgAgAl/qlyf7sBDPIhfBzniBOeUiqEEwlsEu2pkQhfoQqB+8vdX3
 wSLMIT7oRMyCU6oDqAdVWQYGbx+d8cuwIAB8bPzy8cIrh/iRv9+uTOVJHy/a1a6qr9J8
 8ULMyUnBga66FH3bc9cYxG9lHnn3VFie34X0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732329737; x=1732934537;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qS6LZnuqWmu3cr8m8YoR332hZE2nmQf+M0c9UE4Na4Q=;
 b=TyQSSEpZtdMjYsvFcjA1UOVVtXx4mYq/HAHjPwh0eTMk4yoscwIOHCvyflOH0APxUV
 782LORPDIDy6A+d5zu3Bu9wCoq8HKv3CYixkcAEUlPPQjDML7ZCsPBCEnLd4F11EWEtU
 lh+O7ZTtNbEznr+3ijBJaxiTgfR60aUWoas3H4I4qPLrWXHVrZqRZ5OWki1QoEyAi0av
 9HKi7dMJ3nuSFzqlnxuI9Fj+2QQqd3y5sLUA3cdVw78D9TnE3Td2o9tQ/JeUubOFhEA7
 Hww4hC7mN5rOyN45phxfKcrW/6dvZy1u0og4yywlrcqAw9xVQbZgGhFAsqTpi4FH9xCx
 KUsA==
X-Gm-Message-State: AOJu0YwpLoqUUuy01OAPaDZ1EBfZip1iNOKHHuf+RwUcHTC2cra7Gjti
 HG39QZTiOljTyIiyvgUPlbPa6t/4BBYgUzxIfEVl1PnrnlDB/N06hfqPmEjR5Lk=
X-Gm-Gg: ASbGncsqMeRQNryGoBLbDuL88GkAnoDejbZ318SIPAJErjQjRqmU6HPJJM5UlJEMu1q
 bbJSDe0MKXtEeCp3zoUdEB3X6RkV5uk8IHk0NIs1cX4BzW6ieBCp7d/EzECzhGdp/uOwqHGjJYh
 UDQNiz5cLDRdt5tMAybjhZIEq0lrvIt8TQnQ0Q4BirEB+QkwqZNfH4YOqDNaO/N2nwqzj2ao2MD
 6QcQtdu3rtyW2ylWg8A33YMbZkuFMOs+Fi2nQ0E4Hc8az4S6w==
X-Google-Smtp-Source: AGHT+IGyY51Fgf1a2GuWPfvSO5+Vss0sdAhfCcpae1l6cyXGnBMNF4f5DUEoVT6Swti3+NqyYVU++A==
X-Received: by 2002:ac8:5acb:0:b0:464:888f:adf3 with SMTP id
 d75a77b69052e-4653d5a4b28mr68509051cf.27.1732329737108; 
 Fri, 22 Nov 2024 18:42:17 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4653c47f48asm19222191cf.65.2024.11.22.18.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 18:42:16 -0800 (PST)
Date: Fri, 22 Nov 2024 20:42:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH] net: lwip: fix get_udev_ipv4_info()
Message-ID: <20241123024213.GT3600562@bill-the-cat>
References: <20241118143125.2258888-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1q3/iWZXgPxO20d6"
Content-Disposition: inline
In-Reply-To: <20241118143125.2258888-1-jerome.forissier@linaro.org>
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


--1q3/iWZXgPxO20d6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 03:31:25PM +0100, Jerome Forissier wrote:

> The local variables ipstr, maskstr and gwstr in static function
> get_udev_ipv4_info() cannot be pointers to read-only data, since
> they may be written to in case the device index is > 0. Therefore
> make them char arrays allocated on the stack.
>=20
> Reported-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reported-by: Adriano Cordova <adrianox@gmail.com>
> Link: https://lists.denx.de/pipermail/u-boot/2024-November/572066.html
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--1q3/iWZXgPxO20d6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdBQQUACgkQFHw5/5Y0
tyzXIAv+PgstPaWFyi2CndiZObn0ANXJ1WPkwzCoCkI8ndtZg5jTdGmgYFQv+RgD
EfdCLrinoQ1BOIIpbk2QSulBv2sEvzwWS2gz/zWwygFv7Pf3gyjTcr0fXJashEUj
o69bKLPtCCjHrhsZbjQCL5wMnWb2DE4unAlZsV6pJsCCTdMJslPl2C7822XlEc67
EqPuNKOcTC11FTUjtnysQ3jCgUW2SkfkvMvoEZndNcTnubdHu5XpsdORT2gbfP4M
+zNFKjIyOV0LKawDeU/+YflGeR+jfemIWC7sd8iyHU170nEAugxlZdu6k11hRGkH
+b5EW3OjsgClayIiDmpQLa6NoOO4uBchLl2E+HDUOdmYhdNcS8NvUFMEWrmR0e7j
NSGuMuu+f1kRHnNEe4M6EOhd55UORWewSb+ot4e55UZvbFAPSRHxlsvxZAAoYMtE
i73pOGK+3kDfK/yV1axSqTCSfcbk84zVpiRsZJDLRyo+jx+MqpMItifXwlgn3ie1
1yJ9SBoe
=tIAJ
-----END PGP SIGNATURE-----

--1q3/iWZXgPxO20d6--
