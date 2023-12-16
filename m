Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2110FC46CCD
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 16:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EB11876C8;
	Sat, 16 Dec 2023 17:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o9aTD8lf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63129876C9; Sat, 16 Dec 2023 17:03:55 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06CE48761C
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 17:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-59171d44b32so1149255eaf.3
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 08:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702742631; x=1703347431; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iUnojwiGLGrosVFlwu9T1Ik6Qjkjqf3wiX7CQMRu8kk=;
 b=o9aTD8lfgaoUFTpjdnAw8aicFL6ZYLYr/d5oe548sHZnWm/RRja/UV9mcQzP7jtK3m
 kNTmQX5yMA8wQ7MDIrRloqM4vARtCxdLK8pl6phX4H8+p0ceUSV98DZv9NpBo86KSXlc
 jKlEvNOd4zSqrlZ24leeI8spwoWJqsqBqBxZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702742631; x=1703347431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iUnojwiGLGrosVFlwu9T1Ik6Qjkjqf3wiX7CQMRu8kk=;
 b=h7lsEpuxdV5PP7i4bEQiGrPyZyyjyAkTzqhc4vw6rB0y0B05p8yZNpQ9W/jEybNmk5
 z4p1TKup2kYk9LHEVjNeArJ3bwYZzeYnr2cb36NxiQ9kQTdpGEigmCn63wc7Hxx0tu6s
 41a97gjnOXH/P/1fGM0+csx4UWITM6to0YUHSDV5MpOXRVZDBebgiVR2xiuWbN4406d4
 DQ0oH5e11EwZTpwjYdMXUCFddRCRTgvKFTMSujoDrEOH9womwnH9MnhEn1AiLWj+sUGR
 BAgoBD4c9rCqNWE1j14od4nPhRkZQYoNzAX6mLNnuSVx4/kmWCGfSy7t37+wVFxVnEs2
 2eTg==
X-Gm-Message-State: AOJu0YztoaNTQ+VBZL/9BDhi05seN/TihzQ8fJfeh3BJB2zSW76Yrued
 ItfapdShoW+/QksyH9VtjBnn/Q==
X-Google-Smtp-Source: AGHT+IFqwVvIN6tnb778vcvrgOSseeu3Y83Orn4iK1tzC9K6YM7xwXi2Xio0uRUIb3FUi6vnYQi9Aw==
X-Received: by 2002:a4a:98a1:0:b0:591:1d4d:8017 with SMTP id
 a30-20020a4a98a1000000b005911d4d8017mr6105687ooj.1.1702742631614; 
 Sat, 16 Dec 2023 08:03:51 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 hj1-20020a05622a620100b0042601b60861sm2176994qtb.26.2023.12.16.08.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 08:03:50 -0800 (PST)
Date: Sat, 16 Dec 2023 11:03:48 -0500
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Igor Prusov <ivprusov@sberdevices.ru>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: Re: [GIT PULL] clock changes for u-boot/master
Message-ID: <20231216160348.GO2513409@bill-the-cat>
References: <09b2e060-35a4-9509-145f-d1e3080638f7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="itgv337r2W6SGAbd"
Content-Disposition: inline
In-Reply-To: <09b2e060-35a4-9509-145f-d1e3080638f7@gmail.com>
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


--itgv337r2W6SGAbd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 04:06:23PM -0500, Sean Anderson wrote:

> The following changes since commit 3ac22891cfc0dc6d8eec25d2b0fbdd2eb8f3d3=
ed:
>=20
>   Merge tag 'u-boot-imx-20231214' of https://gitlab.denx.de/u-boot/custod=
ians/u-boot-imx (2023-12-15 08:22:31 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-clk.git tags/clk-2024.0=
1-rc5
>=20
> for you to fetch changes up to 97d65b32d76cb3b8297cd8aa2c1f0caab5ab6c57:
>=20
>   test: dm: clk_ccf: fix building error (2023-12-15 15:30:12 -0500)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--itgv337r2W6SGAbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV9yl4ACgkQFHw5/5Y0
tyxHDAv9G65cPdipS2rZqD/nBBzgTz/jYCccXJUdfTXXuYn3tm9foPqoeXhXGrwE
lv6YA48wL6cZakqpTkbtUEJj9sjoinhavR6CY3Trf60lkUDA2KSdhdjBk/6MjxV7
n74WpuTdqTIfUuC892JhUHuwvMH6t/aDWjJK8dCNnAV7dzoSI6wlsFkHRYL/En85
WBJSVpOpZ7lc4JYrShVIZNRTQYQhez8BOcSU+VbWiZLaczgLEBblpHzoECrNwdht
W1F/h+/ReU3RRKY+/qW8C9Cm/XvuaWroSnd1BVgEkt95w6L9JF1eaw/o/5hrg+Gt
3xgiaK2kT3UyLjbKhS/dG4NmX2YYiNmi17SnNtYllHUK/PyGWexgxfoMIXHT0UjT
PmcqhBLNHcOkPXlZk83032GT5XPID6TrrupYmFEuc8ShigEoMSaA0jjDh0cSpkZs
JV+o63lY37QBVtWy8dsC5odJx66GMHhiPo8c5w3F9xgGIkskRNYmirHiir8yBNmG
/DombuFw
=3ycC
-----END PGP SIGNATURE-----

--itgv337r2W6SGAbd--
