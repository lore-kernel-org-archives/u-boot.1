Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82A1EDE9AB
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 17:22:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD6CC890C5;
	Tue, 10 Sep 2024 19:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B3B11H2K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C3E890C6; Tue, 10 Sep 2024 19:22:08 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD077890C9
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 19:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-45830ff5b70so16819541cf.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 10:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725988923; x=1726593723; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TC3QsdLJveOnXhkU9AHjMXmc+tNPrQl/RrUzzhVYOM8=;
 b=B3B11H2KofXJeQ6XCEXhSknjmRyRupmg6TvrGfvSU5irvkOmfJWg4cAG/1BzgaHJQI
 rLl56UOXSQPNjNn4OqeqQW6F5iGemhqcJbf4oZL+PYayK9cprS0V0wnb9c81PY3vp+yw
 1GzBYUPwKYRiOzCX6RdDyzB1nhYa1gaUCJIzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725988923; x=1726593723;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TC3QsdLJveOnXhkU9AHjMXmc+tNPrQl/RrUzzhVYOM8=;
 b=wiflP+VLd4vdnGUtmkn0C+PpLkR962wTiJ3J2B/nip627fa8vtn9hRwbc11y5QXkNo
 GIJXVyaYCo4V+48/hsnhzhXWJDnRUXNjSpyhm8TsvtMLSkjTMgSI2lyDOl89sLeeg0Y8
 i2pE0L34ECTqcZxf5lKH8EILxH4BD1+FjyE1emEUrSs022abxvaZ4H0234Id/nssw+BX
 tnbdpgerRyzG9Zuy83GwWN4S5UQtNyMiBH9adJlAfmdDq5e5favFi59WtvIn2juKYBax
 ifpDpeBTggdrc+vXeIV+SDZbmXSEL/lGX/y+C4UmKc4JYyPtOaF7KZsVqKqK7u+pQKXS
 5CXQ==
X-Gm-Message-State: AOJu0Yz7ZYK4WQWtvf3Tib4NcinC+VQOaRTeFtoUrlnFO89aSviPX6mC
 9CNUmacZsJpwBweJXG36xRW1T6BheRNd8CJqeXXb05NyN9tdpl4kAbGrkDGZcis=
X-Google-Smtp-Source: AGHT+IEgin/W1jjTdq3j3xK8+PY0E6A0+oKctiqpek8DRqMoJOMD5HfnHVW6WxaLwbFQuVyxjYqAjQ==
X-Received: by 2002:a05:622a:1190:b0:458:35f7:3950 with SMTP id
 d75a77b69052e-45835f73ce5mr89564421cf.17.1725988923494; 
 Tue, 10 Sep 2024 10:22:03 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4582f9ac84fsm21088501cf.15.2024.09.10.10.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:22:02 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:22:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240909
Message-ID: <20240910172200.GH4252@bill-the-cat>
References: <20240910015648.760641-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i/rD+P7WJdh71eWK"
Content-Disposition: inline
In-Reply-To: <20240910015648.760641-1-festevam@gmail.com>
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


--i/rD+P7WJdh71eWK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2024 at 10:56:48PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master to fix a boot regression
> on i.MX8MQ, thanks.
>=20
> The following changes since commit 7b2d4ecd7f6593771dd3118c8bab525d727a91=
e0:
>=20
>   Merge branch 'master-spi-fixes' of https://source.denx.de/u-boot/custod=
ians/u-boot-sh (2024-09-09 13:54:10 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240909
>=20
> for you to fetch changes up to 9d921355d942091f24269602ca464864cb0719f3:
>=20
>   imx8mq-u-boot: Pass FIT offset to fix boot regression (2024-09-09 21:52=
:15 -0300)
>=20
> u-boot-imx-master-20240909

Applied to u-boot/master, thanks!

--=20
Tom

--i/rD+P7WJdh71eWK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbggDgACgkQFHw5/5Y0
tyyxPgwApztY243bPpW3fZ4fl689C7d9jE5QblvmWI7ySHr1MvJfdS7gIzZDuPlN
28in9Mmv/i9nVcjG8wJ8dmPGZQBfcHdpwqHx/Y8LlJvkD2m4rvbifkHLim3WImCv
yihzvQVoxmG7jF0uRNiQBc+qWlrQA0RVjxllLy3P7Ar0NFEc2anqcAdSqzzDojRS
aPYvhBidHGBNVpnQIWNstuL220t9t36oVt6/mLXkrOxA7BO5PhRkm1VGWAdCzYAZ
PttiPTjahh3kr6hY40Ns8OyuyGQ8A0ofBn7NS366dauuoQ3NtF4keOvf1Lth1Vzt
kpJh3AVuqLZs2q+8dC+vZdZ5ucEkdCv16sWRV22fwKeRxCkoUi7ebPImKMN20OQK
BSNnSIWGQeKNbQmgwJMm7corL5MHlYT/aLCg59UkfQY4fKsvs1SKvwIbJ/PzrcEN
4xS2g7GMMdSCPfbMSRdz8WVIQzuz4UhAhNe1Wkz4/1mTmh0WGKSsJPSVDkEZw7pI
xZVNfA9P
=vBNH
-----END PGP SIGNATURE-----

--i/rD+P7WJdh71eWK--
