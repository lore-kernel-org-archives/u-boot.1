Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BA5C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 18:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1EA87FE3;
	Tue, 20 Feb 2024 19:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nxOaVmKx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 897AC87ED8; Tue, 20 Feb 2024 19:15:44 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27BB387F76
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 19:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-607f94d0b7cso47208557b3.3
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 10:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708452937; x=1709057737; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F6Cww+HXm9Fo3gsL1YZDp8K1N1737oykTgSJr51FBBA=;
 b=nxOaVmKxImjx/vxtjY8w1wjOtuZGYo8OtUNh5H9EXXM2RcCpXL700N48x3SKpC4vvf
 d/KVcan61MppOW7lpTOqOQEZyyr+38MATM/1YhSiLbLL3MSu1FmBIhO7JKgl8cX5QIFM
 k90FCPRqsWkSsyxTOO2ic/i6kroJOgQRDkYBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708452937; x=1709057737;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F6Cww+HXm9Fo3gsL1YZDp8K1N1737oykTgSJr51FBBA=;
 b=TQhPgwF+jWIB6VU6c5KVpe/ioSMsJizYEgnNlYf0Pf6b5v5UrCh4g/vnwk0dwTwGXH
 rZ0wOrMdLBrQnXWpLrUKL8Sr/iKRcAyRHZqXxXxONVEBNopj45a99SPdgGIUdXLL1ltX
 sMovG4PnQEIw4Myi2cJg/Ul4rPObQnAgss7IbRNR1bTSoppuCTsc4Aq62GpYV7HV+6xm
 +zu1x4XLh/nbPhv1Us7rQJGVAp00Eg7ovSZ7nsx0h2tGh2fkzDqljKFg5IgzLM90ZRlc
 jkf9k1vG/wPAa6L6CrQZEHLHZGKMHdGo3p9F3911US+r5CVM3IY2aqrU7scdzVvynkyO
 PnZw==
X-Gm-Message-State: AOJu0Yx+BWX2OdBEQZEoom62HWXMvgDfy6LdqX7VY4axWsu/vwgeSObE
 ddUpiNBCxY2oWbtk+Y+CsXIaNxoDuERvj248MlWSt2O9txRNJQGUFRmy1/HC2pfQDPbNSThVZWD
 e
X-Google-Smtp-Source: AGHT+IEIx1SvspXyrfX14KGahek4xYYCRuq91HFlt0Px6JWdsg/+73v/BBrVQo1qptZyTqGx6wW6Dg==
X-Received: by 2002:a81:a193:0:b0:608:3797:5ac8 with SMTP id
 y141-20020a81a193000000b0060837975ac8mr6631719ywg.32.1708452937682; 
 Tue, 20 Feb 2024 10:15:37 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 t75-20020a81834e000000b00607a75ae26csm2224467ywf.17.2024.02.20.10.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 10:15:37 -0800 (PST)
Date: Tue, 20 Feb 2024 13:15:35 -0500
From: Tom Rini <trini@konsulko.com>
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
Subject: Re: Please pull u-boot-samsung master
Message-ID: <20240220181535.GP3040305@bill-the-cat>
References: <CGME20240220042544epcas1p1814450956381663117a9e274d775a952@epcas1p1.samsung.com>
 <1ec901da63b4$dee1e420$9ca5ac60$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W8bGXvCurYEXbM3f"
Content-Disposition: inline
In-Reply-To: <1ec901da63b4$dee1e420$9ca5ac60$@samsung.com>
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


--W8bGXvCurYEXbM3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 01:25:44PM +0900, Minkyu Kang wrote:

> Dear Tom,
>=20
> The following changes since commit 15e7927b5a2d33666af19879577bf0c30ab088=
fe:
>=20
>   Merge patch series "omap3: Make SPL_OMAP3_ID_NAND depend on
> NAND_OMAP_GPMC" (2024-01-22 14:18:55 -0500)
>=20
> are available in the git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-samsung.git master
>=20
> for you to fetch changes up to 1e81d12e34e874319e041652198a4ba561d751ab:
>=20
>   MAINTAINERS: Add new Samsung subsystems (2024-01-24 11:23:20 +0900)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--W8bGXvCurYEXbM3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXU7EQACgkQFHw5/5Y0
tyykHQv9ERKOittB2uYSKZlc/5H3XXSbA8sh4W1Wg5f4aGcoCsIuGBV0HRS7KM8k
hdPNOI+NTrD+E3A3ZWPspDRTMQbeQwW7X187ozE1CKywx+XJTZ26WpdkI8WT0SkY
0fYKwwm/izZQ14KFUT9cuTju5BzP55g5HBe6UJpbPOA/FIgv4plOcN9NeB7l6+dO
Ol11WUpXWuxcgOXbc6898De6x5fiOmSZmqfQb5j7xNurDJYPVNgc2lXgLVd3fHAP
s0ThtB1L4QqK9wdshNVq2jq1icgb0K//cMmeedRr6jk0xs52A0c4VRS7CK9VIXU1
2uMwVoXoZC8+Wi557DBYxnVBeAAk7+/flILEtYG1F7kaMc96b2SRQLLXJ3w/PTDl
j7gn4nGRcbyHRrhf0XJkrjItVo074eh0sD+8ifa+KnAORkeSsY1kwWLSoBoT9iv2
HIq3EHqyD2W4LIK23PGf5VQDZB1BbYyLo8OfXZaHMOOK2I6/MCBZmhFUiSkccWnd
AFKGFKPe
=E6U9
-----END PGP SIGNATURE-----

--W8bGXvCurYEXbM3f--
