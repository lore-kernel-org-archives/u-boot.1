Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14DFE77180
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 05:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F0E4801BF;
	Fri, 13 Dec 2024 06:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MCaeTIbG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56582801BF; Fri, 13 Dec 2024 04:09:51 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1173080085
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-46772a0f8fbso11406251cf.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 19:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734059387; x=1734664187; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uSViAJKAn14LgYLl3yTG7R4OfK8BZpmfv9IQAOyFlSI=;
 b=MCaeTIbGVmHOsYQ4/emlIlSuTnXuldPAy/SlfNx0Is/5LKyBUNrkmZAPlpx17zyg5H
 FHItCQXirUGHq8T4JO1xEAKiVBH6pD1mkYqymq7zTxQeL1P6MSFOrcu9NfMSq0ljSiJn
 /vv31RSoPc+6MVJwl5ZirBNLvKylOqD4vF5fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734059387; x=1734664187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSViAJKAn14LgYLl3yTG7R4OfK8BZpmfv9IQAOyFlSI=;
 b=MvP5ZjsBjHrwckLRVTROUM9b1eGEGuAcpNEMoqOQrB+m7VgrtD/r40tUxxvJQqraVd
 JlMQsja6cGObLELsjUsQy85moiLppZn1UQUjcECzUMUMxmhIqtoS24S60+VH5rqNjFIP
 zPiqsGucGbk9N0+2qUN42SdpOOX+0UEIPxemHYgHn6m8m1KZ3skTPNqf9gnwLN/8BV7q
 CgE8R2Cj4eEeLTd/vjjvNPekZtnXi7zJCdnIsrHnzJAy1ILum1141EB7wa+X72qRlO3d
 0/W2rPUtmST4FmqMIpNkRtFCfiXuviXpdFulOSnxg4wdpJYEJBILnXbiZPKCd/9f0OLG
 JrXQ==
X-Gm-Message-State: AOJu0Ywass32VxesHE5N307jwO6c9JASxB+FoLoBsv1wZbNk9OtUhLYI
 tf6uxkr4zgn9axYcHAjD+Ru5gxmCuLWjRENLfxpAEAoNp/I2fxgbOEub85fmXD1t62UHIdnho30
 86yU=
X-Gm-Gg: ASbGnctKLuIjicteAM1BLTMseY5AfdKA5ywQE9y7PBmBHQTdOgvVhoVrEQV5XZOfR4P
 Fd01ieE6SKJMjeyuqDOhfMBNhkxILPvfhWueDY5Qkqgz2zxseH4kdSNykFpiIdoPzM/B+5WzmWK
 6+A2o00PJy2sT4/URfLxKtRwGCIQ6BSfo9zawc3LpII5hSFnpmwCEcVXXzCcJ/OadbVHbOtdF/P
 Ljub1wSvCoyBhU+AhWSqm3BLJFlyWYlRYoaiaK/5A2GMzVCNyFRq87/
X-Google-Smtp-Source: AGHT+IHLGmbzz0mtn2C5BKo2txSmb5YBzhclTwfN54Eta80H5WLKsTh/Shu7IV5kmcfynSGqpFzvpA==
X-Received: by 2002:a05:622a:11d5:b0:467:6508:2385 with SMTP id
 d75a77b69052e-467a5829f17mr16184271cf.34.1734059387599; 
 Thu, 12 Dec 2024 19:09:47 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4678f7a75f9sm22222431cf.19.2024.12.12.19.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 19:09:46 -0800 (PST)
Date: Thu, 12 Dec 2024 21:09:40 -0600
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Dragan Simic <dsimic@manjaro.org>,
 Gary Bisson <bisson.gary@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michael Walle <mwalle@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v3 00/19] vbe: Series part E
Message-ID: <20241213030940.GO1505244@bill-the-cat>
References: <20241207172412.1124558-1-sjg@chromium.org>
 <173405231528.1635625.10928592597091154587.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1CXWzMU8U8uWI+aH"
Content-Disposition: inline
In-Reply-To: <173405231528.1635625.10928592597091154587.b4-ty@konsulko.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 13 Dec 2024 06:46:56 +0100
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


--1CXWzMU8U8uWI+aH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 07:11:55PM -0600, Tom Rini wrote:
> On Sat, 07 Dec 2024 10:23:53 -0700, Simon Glass wrote:
>=20
> > This includes various patches towards implementing the VBE abrec
> > bootmeth in U-Boot. It mostly focuses on SPL tweaks and adjusting what
> > fatures are available in VPL.
> >=20
> > Changes in v3:
> > - Add new patch to avoid size growth in spl_mmc_find_device() debug
> > - Use strlcpy() instead of strncpy()
> > - Rebase to master
> >=20
> > [...]
>=20
> Applied to u-boot/next, thanks!

And, ugh, I missed that CI was failing for real. This causes
rcar3_salvator-x to fail to link due to size growth, so I'm reverting
this for now, sorry. I thought the CI failure I saw was due to something
else at the time.

--=20
Tom

--1CXWzMU8U8uWI+aH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdbpUIACgkQFHw5/5Y0
tyyYowwAn/J/WH8uKCuJIthRwIjgWBndDsQief7wUb3wvb0A5jmD7Al6XbjNWTzO
lJIyDmBsRpVxy3icXZAxtibKJC2fRpe0dC9YUl7dWQoCGzcwGpU0wGiOy+1eVMot
Yyh5joJ0cAGcV7n5zsEBMppkn44zNcxiTDeZFY1IpUzX6L5iayzLtdXyuJzuUnJK
6++cqIYCK0X25ygriHqlNL8bZv6HLpAvGCkK5w54oIPEtyozYYtjuqLXcA4DQlZm
/tgn3fHny+NvPbaTaNhIqVGpymZ5rqg3NuR0DstSGbkFHaAsfNglRbbTtz2V8dX1
3f3N0x7yPoZMjwP2ougTpoYB7UAHV3YNuokB28NdG1I0DWoRCqdH6G3bHblBYVCC
45UPqAjs5vG+BKO5csgIDdFICZJ9P6rqlMNzwDokAnmTSaA37leJHONa0eZkeEHN
0J99glP4HAtd7MawoFomWyA0xiBKv7F/5xCvLH1Bm2h0pIF8IWDW3bmSbGGa1AkB
X+/Wpw7U
=XZBx
-----END PGP SIGNATURE-----

--1CXWzMU8U8uWI+aH--
