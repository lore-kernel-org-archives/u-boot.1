Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B3BC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 13:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 664048710B;
	Sat,  4 Nov 2023 14:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XKMSXWj4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 745D2869C4; Sat,  4 Nov 2023 14:57:48 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87F4A87068
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 14:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-779f2718accso201896685a.1
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 06:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699106251; x=1699711051; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0d/szmC+isPyrVt0DkrLP5UtNsTeVp/vIp2+V8C/9SU=;
 b=XKMSXWj4w3aKb77dqi11FzPUtDHt1CeIQNnMh0XB8bMTD+2S14nPehLK8Wt1GxyPnu
 op0TSbMk9oG9tkutC86f5G9tCktUdw5WOGcxoPncQEQP6o1+497OWG7cT8Uw94tYdtIK
 FMfypTX3p8+0v3gNAJNt4H7r18R583227y0js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699106251; x=1699711051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0d/szmC+isPyrVt0DkrLP5UtNsTeVp/vIp2+V8C/9SU=;
 b=SPPwZRldkb7xCGUdzTqM5UCTT7svvoDY2IkgR85mVgowoxofbXj8Wra9Qr5AyIHd7h
 EBO/mEfpNQ9WIERFxBMkpRlR52nZtozF9QlKJiSporHZ4rHb+GsO+/qE985zpQnoaM6U
 eC191wfj5KYQDc06Qy+97PXIK8FYqukbP0cZ51hbWBTV5lLysbIq+jvwgacUX1AgrMC/
 00UIzYn+zz7emQMEl07DC0Xp6nsM+yqpLq9CSBP+bSdnhRJpfgedFYOEt716kEttAccl
 caM8XHFnqVsq1CR5PhH4kFJOuAbi//5wK+9sF603E1rm2EEhcZhWBg6620QyQUzqQFu8
 gfbA==
X-Gm-Message-State: AOJu0YyI78Rf/RQmfjjFGMxkDiLLXqwIdPLT+6NbxMb1Nmd718lcKhVL
 bf92EUBZkT5/lJ6okr1SFkM++A==
X-Google-Smtp-Source: AGHT+IHYlyRK5Mw+aLhwAqip3LCBv64wsiaqxNE/k1jXVOwumi0O62YuZOvN7+1MIuCId93ZPL4Cxg==
X-Received: by 2002:a05:6214:624:b0:675:66e8:243b with SMTP id
 a4-20020a056214062400b0067566e8243bmr6152703qvx.44.1699106251077; 
 Sat, 04 Nov 2023 06:57:31 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 m8-20020ad44488000000b0065d05c8bb5dsm1654530qvt.64.2023.11.04.06.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 06:57:30 -0700 (PDT)
Date: Sat, 4 Nov 2023 09:57:28 -0400
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v9 1/8] power: pmic: palmas: support TI TPS65913 PMIC
Message-ID: <20231104135728.GC496310@bill-the-cat>
References: <20231027082615.306943-1-clamor95@gmail.com>
 <20231027082615.306943-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nNUkA3ynCpwV95DK"
Content-Disposition: inline
In-Reply-To: <20231027082615.306943-2-clamor95@gmail.com>
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


--nNUkA3ynCpwV95DK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 11:26:08AM +0300, Svyatoslav Ryhel wrote:

> Existing PALMAS PMIC driver is fully compatible with TI TPS65913
> PMIC found in many Tegra 4 devices, like Tegra Note 7 and ASUS
> TF701T. TPS65913 shares same structure of regulators like TPS659038
> so data can be reused.
>=20
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # NVIDIA Tegratab
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

For the series, applied to u-boot/master, thanks!

--=20
Tom

--nNUkA3ynCpwV95DK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVGTcgACgkQFHw5/5Y0
tywDigwAn4PKNKIxayHIyrEerNzq1nM8B3H5SCl+37c4BprWaoNNRuyp4VJlogFA
4WrNb7pXq2qjfJnzIZ7HejHrshsb4uKikCBk3rs6nAHSe9auVyPTkO6bfKMChZDR
ex20m5yJY8l936R0DuPEHUnwn2MsMXA1zhmJJrBaUoS+nhxFnZeIC/zSt8S+KVML
jM/dtMY43xI2/VgqkhuWVBvtFTuxBlCWClXT73i9EZnkqRkyYR6FPoQuLcHPxZe7
6VI66EldqILWkAHHTtY3j0hqhkpbh1nqfHieiGzWTAc5VKWwmStHAQV9NO7zAPrj
KD6AvoUWt+ukSw2DrHYuN0qHpD83NqP4odtNzO0URnB60IOvXxD1tQWBO7xVJeZz
8GzZBlKxCSYlKNLAgKdw2w3PsjmROQ61MUrK0g+4ddIUpljSiAe7QLIldm0K0PXc
7cyj70C/m889kO8OMHeeh3MHWgFg5DH7RJ6FkZ5G7VDKcl2rsROQa4ELZAwZOmA/
Xw8ZLLBv
=7Onh
-----END PGP SIGNATURE-----

--nNUkA3ynCpwV95DK--
