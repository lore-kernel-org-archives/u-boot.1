Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86A3D3C52B
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 17:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1183D89072;
	Thu, 17 Oct 2024 19:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mp7xqlQU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 275E98906D; Thu, 17 Oct 2024 19:54:49 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7BD78907D
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 19:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4603f47b2c8so12143831cf.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729187684; x=1729792484; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TNBCrBWdzYCJ+V3/qpiUKQPX7KkiKYJF8Pdu3CwUQcg=;
 b=Mp7xqlQU6JMve6h7meIaLVqYklhf1jCCPubPuB85LaFAS+yxjem+S5ucZe+kYiqB2p
 15yXVXzAwzkGYXNqnOIA4aeqVVrRauyvptmzpyumXecGwL+M/Gn38hFwJZTcg4Lv3sw4
 dIwgi41CiVijrKfSN3txh3vLmY/BCbkew2kVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729187684; x=1729792484;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNBCrBWdzYCJ+V3/qpiUKQPX7KkiKYJF8Pdu3CwUQcg=;
 b=lTsnk20cfGtEYYZS2j3Vbmh52iRoRLzLKHy68URoeseOl/4Zg7NKNPRT3xFXMnP/US
 Csk/Ycc7ye8fLeviWBSZfGP6ZwfiG6ta9h3cjJv2H26W2M5eafYk+peL3GZAnizyugS9
 xX8fcw8XyDZYimbz/jVkF596Yb8G/bNLTLJYUBDShIiH0jhqNSGmFPQOlLTasYMeLBZ7
 1KmSzzM1nk3XD1489hTgF9rtAsLjzTxhqZti3L0wuptkSe8kZ/qUWdZdfUtAAp5+9ecf
 SNs7JZ/FdFUw75643VSNuJy21Ir7+g1ObwvKcAQpQA4+crjM+ghUNkCJBlQB2OndZV0X
 iJzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAMbvkVSMBtue4R6AIxCa8+h1uOfmyL5TK8xncqqxrkiLakbcslnN3kjqQPkNchMeQdtsFzOw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6ge9Uq6DnaZU/WG7enZZ+GTi8dHYNOFTXUWEB/iR8rnuApjo6
 dLKAgiM8l4D5llHvO19g4K0CycWZalu6KOdwSqUm/ndJJzb3mGRJcc0s8/40NkI=
X-Google-Smtp-Source: AGHT+IF/GCIB5wg+X1QtcOrbrBtFRFRHXfrk0IiBSt8Rh9QBsLdKXHSHEPJpHybnAbqrlE6RvxIkHg==
X-Received: by 2002:ac8:5756:0:b0:460:7c45:2218 with SMTP id
 d75a77b69052e-4608a4c8bc4mr133132571cf.15.1729187683698; 
 Thu, 17 Oct 2024 10:54:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4607b38ba0bsm29454301cf.79.2024.10.17.10.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 10:54:42 -0700 (PDT)
Date: Thu, 17 Oct 2024 11:54:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Cc: Marek Vasut <marex@denx.de>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PULL] Pull request for u-boot master / v2025.01 =
 u-boot-stm32-20241017
Message-ID: <20241017175439.GN4959@bill-the-cat>
References: <730607a8-1f4d-47b3-8296-52e21be4070e@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qCp9NMAZb1lCE5PB"
Content-Disposition: inline
In-Reply-To: <730607a8-1f4d-47b3-8296-52e21be4070e@foss.st.com>
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


--qCp9NMAZb1lCE5PB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:29:29AM +0200, Patrick DELAUNAY wrote:

> Hi Tom,
>=20
> Please pull the STM32 related patches for u-boot/master,=A0 v2025.01 =3D
> u-boot-stm32-20241017
>=20
> With the following changes:
> - stm32mp: fix boot issue with OP-TEE
> - stm32mp: Add script to install U-Boot from SD/eMMC to SPI NOR on DH STM=
32MP15xx
> - stm32mp: Switch to using upstream DT on DH STM32 DHSOM
> - stm32mp: Generate u-boot.itb using binman on DH STM32 DHSOM
>=20
>=20
> CI status:
> https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/22732
>=20
>=20
> Regards
>=20
> Patrick
>=20
>=20
> The following changes since commit d5cab0d6adc26ec1bbd45c2fed101184d04454=
ae:
>=20
> =A0 Revert "Makefile: Drop SPL_FIT_GENERATOR / SPL_FIT_SOURCE support" ch=
anges
> (2024-10-15 20:35:07 -0600)
>=20
> are available in the Git repository at:
>=20
> =A0 https://source.denx.de/u-boot/custodians/u-boot-stm.git
> tags/u-boot-stm32-20241017
>=20
> for you to fetch changes up to 4aa8b9ede9b9010de367af15eabbf4d5c06a754c:
>=20
> =A0 stm32mp: cosmetic: remove empty comment block in configs file (2024-1=
0-16
> 20:35:33 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--qCp9NMAZb1lCE5PB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcRT18ACgkQFHw5/5Y0
tywl3AwAsqNBhz+IaWxUQv5yKec8jLvpseYCaMbDMNTZkYDJEQvEJ+oTY/VOddys
QtIIQQXRGdbDm32nTjNsvS0ydabn5k7u+ziy9PcLH5X374WbNd213i/q8fV5nT3W
hW4TdvlVfEUmtSixtNQ52stT2PkcVIM4vqRRVDdgcJR92mngLSaPqdH+uRRX5IHL
T0+sFQ4NFmCwCf9Ek0ks1FzyanDLOc0AAvzkqYcns9EedIjSSDGBna209xGD6EPd
gGle7heozWu4XEfu3mRwg6g2Y1bX9vfRHPoDbRfrRmOJHyZZ7bWAJDmyzEC0D304
ZPlBIVRaAWJLAmYAPqUhuK9zovEWiSfH75EtJbXvEuRsU32Xr/MPo8zSJAKeAbMc
iEVSy2c66Wl/PDiIBdZcnjWugNHhyDrgIAF0oo4LYUFFnrCe6BmFt3CRhRj9o/Nh
3GpU3DLEIBTP6yRGHJUh8DXrD9Z+a9Hh2pxq0YgSSdV90m3HEaLprlVfodZQjk1x
ni0RZBL7
=1COJ
-----END PGP SIGNATURE-----

--qCp9NMAZb1lCE5PB--
