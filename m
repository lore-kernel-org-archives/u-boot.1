Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C154AC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 00:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC39B8817B;
	Tue, 16 Apr 2024 02:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lppqT7bc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B05A88081; Tue, 16 Apr 2024 02:36:00 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAC0E87FA1
 for <U-Boot@lists.denx.de>; Tue, 16 Apr 2024 02:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78d5e80bc42so332228985a.0
 for <U-Boot@lists.denx.de>; Mon, 15 Apr 2024 17:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713227757; x=1713832557; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WCcfmiDcPK9HU7wx7W95ebrcvxRJupNUD6UpFpYIoUQ=;
 b=lppqT7bclgsapFXC9yk3weQ0VQBSJdhp0lGUulkHM8fktRG5WxbGJQmiUkso3dwCwT
 3WduE/xyO1CIduPwCpTZ2tpS86DtZbjpnLxQNeSYITWTx5nfuyx+mCixvt//0A1RDQIF
 dya63yyQnMqj+4Po/tptcPb/ih5uUajloeTZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713227757; x=1713832557;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WCcfmiDcPK9HU7wx7W95ebrcvxRJupNUD6UpFpYIoUQ=;
 b=wJfnvgluQLOfyScdUJ9VH1/mn9x9h9+wk0/Bs3LnA4jLyvxhdGNN9b+VmEahdmaT4s
 YXa8Bp0NG6xFN+sSVuxZA/hNnvvUod74S0zzSxC+H822C2yKjt15/38pBcMv78hGnfvn
 SLPpKdTvoHI6y2oCNVSOnKMKGEP6SYuAHZGuJzgLiJ8PkR5mW98hp5/SjhOL79ZpCh/m
 O1q7K3YbCL6f7Y/MO7113jkpOsVreNY3kJnDUmwULr0is50eMYOt3YaXUjoNejwQQoX2
 zfx9nWxxo5svrfrQk5LkBgNR6bzzoMwdb5bvZ5VffjrHyNgj2XYxAalOx2HXx5FIA2Ta
 XGgA==
X-Gm-Message-State: AOJu0YwQ8S9QK0Roqu2qgeN9WqHfZ1R+Oa6dhvE1C/qCDURivzclRDyO
 lyovvVkIgjGT6KeqxBIV6dpX/BZOG9hL6hEHyj8AxrI+3fMpRCsFQ38sNSnFiWQ=
X-Google-Smtp-Source: AGHT+IEsyRdIsT+L+/gkffCvSsWpOeiZN8vY1RJ0L2W1Kk40pjK3R0lFNwhF5spr8oLjLic9jDwYmA==
X-Received: by 2002:a05:620a:8106:b0:78e:bd79:f22a with SMTP id
 os6-20020a05620a810600b0078ebd79f22amr11814824qkn.57.1713227756738; 
 Mon, 15 Apr 2024 17:35:56 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 p18-20020a05620a057200b0078ecd227e5csm5389180qkp.74.2024.04.15.17.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 17:35:56 -0700 (PDT)
Date: Tue, 16 Apr 2024 02:35:53 +0200
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: U-Boot Mailing List <U-Boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Linus Walleij <linus.walleij@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: Re: [GIT PULL] Please pull u-boot-mmc master
Message-ID: <20240416003553.GG1054907@bill-the-cat>
References: <CGME20240415095231epcas1p4106945fe2de51e77e1fd60684c3c83bb@epcas1p4.samsung.com>
 <6b1625a6-c5b8-4f18-8e3b-0e268936ae4b@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rDSOr/mUHpJ084lS"
Content-Disposition: inline
In-Reply-To: <6b1625a6-c5b8-4f18-8e3b-0e268936ae4b@samsung.com>
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


--rDSOr/mUHpJ084lS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 06:52:30PM +0900, Jaehoon Chung wrote:

> Dear Tom,
>=20
> Please pull u-boot-mmc master into u-boot master branch.
> If there is any problem, let me know, plz.
>=20
> BTW, I'm checking other pending patches in more detail.
> After checking, I will apply them into u-boot-mmc. Sorry for too late.
>=20
> Best Regards,
> Jaehoon Chung
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/20345
>=20
> The following changes since commit b03b49046af5dfca599d2ce8f0aafed89b97aa=
91:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2024-04-14 1=
5:58:31 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-mmc.git master
>=20
> for you to fetch changes up to 3657ef738ad6aa2c32c569e7ae67a5557343f7d0:
>=20
>   mmc: cv1800b_sdhci: Remove the unused argument (2024-04-15 17:58:59 +09=
00)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--rDSOr/mUHpJ084lS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYdx+kACgkQFHw5/5Y0
tyyaYgwAspGrw6sTgcu9GAyQbitZC1wVfveZIiMHJdJtg4cLo/CSaztzqsfChBmq
MIoRXLnQ3INeajAi2GOlqSPZhWF508KTOw/b8GVZZwnVkZoWeeme4yYS7i1QqCtz
5m+Sz+Ts7nQwj8yMh1LFlxfl9BeX70hDprPewE/7GZ5cdZfRj40QosAZS8vZzdBa
SNOg2biXnrIfX1kv7ifRbk2MOB+XL2yV2tv/l6VMivUkT47AVzzzdhF4jUzMzNkh
zo2WvSIa4zXi6/cyW9VOQW4rjH/b4MO22TWsRM8uVOqj5aT6jEbRt2tcIUpGcFGu
pKUfrt+Gd2Adh8ypKNxIehXmyhkcwFmh+dZHCh78f+F3F9LpxgmLR4qDfvbR//8R
CGWGZ9klXMIS21PdSRaoAe3WHzKW4RmlLXep4dVBOwiA5z3Dt6V71TYCVYo+L75s
DfXgYlnJ2nbZYE8Dqag3wzsrScfjmjrgImemTqfgTTZmP3WDVApQlQGSuU33B3pn
F3HCkTsk
=Q2O9
-----END PGP SIGNATURE-----

--rDSOr/mUHpJ084lS--
