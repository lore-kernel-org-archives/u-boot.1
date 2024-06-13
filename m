Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7EFC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 15:33:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FA778892C;
	Thu, 13 Jun 2024 17:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IV/6ZWBr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D4B38891D; Thu, 13 Jun 2024 17:33:05 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D091D88912
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 17:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-25837a78858so289250fac.2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 08:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718292781; x=1718897581; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7/8XuFfjOcq7mTtuurIBJ5//sjpf4PuUGzLtGwhf0us=;
 b=IV/6ZWBri3WvucGH3uMiHTSaSQSNXysVb0sbJIvNMSKQs0R10DrChUT8InKaSYq81r
 iBHgAYMmC9OV8cxOp2zWeHbTHp9yPTGEHyt8uPWzoW3onao8FiTeZcmY/JP+2bw92ZoG
 SI7Dk1K/337YEXetWAO3H4gaN7L4rqsYi0Efw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718292781; x=1718897581;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/8XuFfjOcq7mTtuurIBJ5//sjpf4PuUGzLtGwhf0us=;
 b=IyrSn5Kjz/LC7+KpJrCxyOmZdEAtdgL58f1VdFrHPC5Hszyqyc/Ym5Rtu3lXLDxTcS
 B+ZxZQVtojfUmK/R+gHLPl7NtP2JbLt5YZjg3HKEJfCrHucBRyKb8IJROyGkjPgM2N4r
 gMK+Cah63IpwiLoSwtqtvxIYIgSWUHRixHmnCN4b9TLRBlYYSLj6h1+EQYb49wxD+CxG
 HiceC2LV1fSzBhbhXsJOjCvNBjncZnqnpz93QJuIY0IFo8X+0mi31XPoPc4nAqmKGlns
 K86GRHEW7M3JxWzcoG4rbx0NZY+emN2pX5w5NS4Q5OANkst4t8jh0jEY30WRyyesPx1n
 tEpw==
X-Gm-Message-State: AOJu0YxWMMnerxLwaZjE86MvVvpGPGDY4MCjxPZ4Ymz2qJywqdzpD/u+
 tEp9Ui0hluNWl0JPY2fd5Ez7afERME0JaLBVRQDEmD5IZlJDjCyzIKFvXz1G4qo=
X-Google-Smtp-Source: AGHT+IGchv2If21mas2ppHN8pf/TEp3cQm+Or2czANoLYEVH47YLKjs4FbRjksUTYJ53WFSb+Z5JFg==
X-Received: by 2002:a05:6870:d20a:b0:24f:c32f:802d with SMTP id
 586e51a60fabf-25514b4dfaemr6068272fac.6.1718292781388; 
 Thu, 13 Jun 2024 08:33:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5b1b91ffsm253852a34.31.2024.06.13.08.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 08:33:01 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:32:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Weizhao Ouyang <o451686892@gmail.com>
Subject: Re: Pull request efi-2024-07-rc5 for branch master
Message-ID: <20240613153259.GK68077@bill-the-cat>
References: <7e881715-31d5-4407-bd51-fc527cb82c33@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nAKJpR1xO3v/om2R"
Content-Disposition: inline
In-Reply-To: <7e881715-31d5-4407-bd51-fc527cb82c33@gmx.de>
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


--nAKJpR1xO3v/om2R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 01:37:31PM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 1ebd659cf020843fd8e8ef90d85a66941cbab6=
ec:
>=20
>   Merge tag 'u-boot-dfu-20240606' of
> https://source.denx.de/u-boot/custodians/u-boot-dfu (2024-06-06 08:24:15
> -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-07-rc5
>=20
> for you to fetch changes up to f3b6228ef4ee6918a9e1ec1db399ede057308a13:
>=20
>   doc/sphinx, test/py: Update requests module to 2.32.2 (2024-06-10
> 15:05:30 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21060
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--nAKJpR1xO3v/om2R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZrESoACgkQFHw5/5Y0
tyxjOgv3VgEOvQnudZdmVxtL9YhEZJeUr5GEfzlpiKkFeb6wO64ywrFeU8XlKXp+
+rIBAK/O/DqXcr6wxqLM1tGnEyduaGmFSlhs0Uv9lye6vPSaMl63L74inYj/HS1p
ttnp2Wf0cUgvVD3I/QRbAQXYzr6POTwbFpjqCup8eSjf/o8pLbz6i8gYVvMifIF1
4dTvVlUCbmDbC1p+uWoeKxwLDCsRR+5fIJQTIoUsndvtkBs8rW915AKobkczFVEn
uat9fmmgj4irVudOw0Ed/EWKb9f60iA06tXAtnIJfUXMibLD8Vc2OcSE1bKUUzIy
438eLvf8HdN+JV27GmPz+KNGySTRssjPF0MDRFNwQ+93EpCurIKfO7TIMxJjWfP3
oS953K+nAWd8XHlnmvdyckdMGriorAIyiGH993U8eCFl5LWIghBFAILyK83x2qpC
EeIDiU+CTysUTyMROtGPUG3/JxxMYIjuPn5TOokogW6t+hir0wL9EV86f0eUrthq
1hY3CjY=
=D0Ed
-----END PGP SIGNATURE-----

--nAKJpR1xO3v/om2R--
