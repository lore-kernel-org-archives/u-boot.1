Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F56EED632
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 17:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9524890D8;
	Thu, 12 Sep 2024 19:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HjZOKuPf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 007DD890D9; Thu, 12 Sep 2024 19:45:09 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91BAB890D8
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 19:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6d49cec2a5dso366327b3.3
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 10:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726163105; x=1726767905; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CjNi9IdWNU/ajItHp/2c/v1BKHDncUOkEu2OM37U2mY=;
 b=HjZOKuPfSZODr83JE0WfgN0Kix1W5VskcnmCtk0blbYTH1UyQPBT7crmQlN8XXjXp2
 l3v8+loJvRe4AWWTrP/7vMfjupztBG9vskA8d4kTHN43kdCnPzJzEWpag6uNtnTZKisz
 bxh8BUYLwJY/SuYmrwFBN3Zku704hUTCUkiW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726163105; x=1726767905;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CjNi9IdWNU/ajItHp/2c/v1BKHDncUOkEu2OM37U2mY=;
 b=YUis8fMvncW1rHVWkUqmDcUlswU8kIPl2s5PvpTS72ZiDO0aC655TpxcoxEfWGo00n
 +ZEsNIaP8WZYSW9Ks6gEF2p7YKe3N9bhVK2rsew7UYjyUVW6beSRhdyuM5zVv+3fg2PJ
 3n3fElkhuf5T2hidw1G46db1bMPMPwuzhTG0STbMyjjXKYs2p1I0naL84zbkyqjFtBzY
 vNGesrIplO0KbjRbrO7zb4FUPg1wNv3IjfKA94jZkXDWcfUuKqbOATQrnSVJT0Rs+hmW
 vKZ+McagbHHLtQLazaIUsaU/bxflpDx+aRUlF16I+QKw9RHJNqSjJkErAYMLIEIGowET
 9isg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr98EhPfjBpj24cZEBhHZ/THc2nh7KQPEfhyIbxWXNXUmYsli5XZOe3JslzWlsGdMG6VmL3gc=@lists.denx.de
X-Gm-Message-State: AOJu0YyKuxZNePU9NBn8jk6CtNuEay1+BCqAll/opiIe/jQezRfUuCYr
 29nH0nE7BIZae1sU2rEGAOn2rchWtiae7OGLGhzlxjLKsNgIPnd3/KPMN5soY+w=
X-Google-Smtp-Source: AGHT+IHtVKfIIF6d6Qm3f0FIs4fWtuK+9xWGszl5bOFvZARoC0i7T2DTLNPcxulLrMXQjvyUEUzkow==
X-Received: by 2002:a05:690c:6ac2:b0:64a:d5fd:f19f with SMTP id
 00721157ae682-6dbcc399ab7mr2096987b3.18.1726163105363; 
 Thu, 12 Sep 2024 10:45:05 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7968ed5sm565731585a.42.2024.09.12.10.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 10:45:04 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:45:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: igor.opaniuk@gmail.com, mkorpershoek@baylibre.com, sjg@chromium.org,
 semen.protsenko@linaro.org, colin.mcallister@garmin.com,
 4.shket@gmail.com, avromanov@salutedevices.com,
 u-boot@lists.denx.de, kernel@salutedevices.com, rockosov@gmail.com
Subject: Re: [PATCH v2 0/6] android_ab: introduce bcb ab_dump command and
 provide several bcb fixes
Message-ID: <20240912174501.GU4252@bill-the-cat>
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
 <20240912071053.4cquqz5fcbhg6yzc@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1zj83KOR5UYGI9lH"
Content-Disposition: inline
In-Reply-To: <20240912071053.4cquqz5fcbhg6yzc@CAB-WSD-L081021>
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


--1zj83KOR5UYGI9lH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:10:53AM +0300, Dmitry Rokosov wrote:
> There are Pipeline results. One test was failed. I suppose it's not
> related to my patch series:
>=20
> https://github.com/u-boot/u-boot/pull/625/checks?check_run_id=3D300299250=
59
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> _______________________ test_ut[ut_dm_dm_test_rtc_dual] _________________=
_______
> test/py/tests/test_ut.py:590: in test_ut
>     assert output.endswith('Failures: 0')
> E   AssertionError: assert False
> E    +  where False =3D <built-in method endswith of str object at 0x7fb0=
835c50d0>('Failures: 0')
> E    +    where <built-in method endswith of str object at 0x7fb0835c50d0=
> =3D 'Test: dm_test_rtc_dual: rtc.c\r\r\nTest: dm_test_rtc_dual: rtc.c (fl=
at tree)\r\r\ntest/dm/rtc.c:307, dm_test_rtc_dual...&now1, &cmp, false): Ex=
pected 0xffffffea (-22), got 0x0 (0)\r\r\nTest dm_test_rtc_dual failed 1 ti=
mes\r\r\nFailures: 1'.endswith
> ----------------------------- Captured stdout call ----------------------=
-------
> =3D> ut dm dm_test_rtc_dual
>=20
> Test: dm_test_rtc_dual: rtc.c
>=20
> Test: dm_test_rtc_dual: rtc.c (flat tree)
>=20
> test/dm/rtc.c:307, dm_test_rtc_dual(): -EINVAL =3D=3D cmp_times(&now1, &c=
mp, false): Expected 0xffffffea (-22), got 0x0 (0)
>=20
> Test dm_test_rtc_dual failed 1 times
>=20
> Failures: 1
>=20
> =3D>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Yes, sometimes that just fails due to the underlying hardware (even with
retries). Please tell it to try again so that the world build tests run.
Sorry for the noise here.

--=20
Tom

--1zj83KOR5UYGI9lH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbjKJ0ACgkQFHw5/5Y0
tyyYjQv/Q7nHGM0sasH/Icpnb7HByS0GsLOPhe+MtthMW5KFeiHBsskh6JHPMbjz
hZZsa+UXFUVVzHScPDy5kNBFclYPaTAyCdpYK7mbesMZ9Sx7+F+W9VN81A8Z6zft
xQwJERyGjPVGHtgc8XWa1P2J3n4Qb69++80rZKdKYsGONGo0ZPgA45ZZOBxLBDUe
3dT3xUKo2cFpQVatHmsWg4rZMUZUGHRrvcnMcFJcMpI3yM3iAAglINqT67qTGcqg
csRC7688JEAWMWKMUxnoxo3Vik3RSLiTG5t15kgUSr0wcSjsjLgfx4QwgV5YLLdW
oxgSYzKoWxESkTB1LEzv0yhN6YjTg3M7Y+gCl4UJKWbrs7D4C8qd5JETm1iL9Qe3
oohjgnQy1WRLuWAfyYKblND11lh3mnwnwk8o4P1Q2WKR99jMZ9S8AG+QAAUcQmj3
LlL9q97D/0MjqLh9elIsrOzkLEvbje2ntYES26gUy9F97PkgPfeEX/y4RNsaaHBz
PjyjiINg
=qMui
-----END PGP SIGNATURE-----

--1zj83KOR5UYGI9lH--
