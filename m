Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7A9C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 22:37:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 315D360759;
	Mon, 20 Jul 2026 22:37:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RGI6d3L-Idpg; Mon, 20 Jul 2026 22:37:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29BF160747
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784587039;
	bh=FePZl2VYjM6BzoEn/HQBfe8da9neXG8lc1Ht/Lle4xM=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=CCWCpZW+W+p4ucqVwRhBs21iaPIUAI35FaIu/TA2WHeLcCnnluMhV3YqytqQDoPsQ
	 e10A4sqcgLVbcEnAWcAJoKh4flCv3Hj3aAuJOIbxnVLgEfvMMD53II3k8Vkp6WPuOD
	 zDzegKjM5o7Hta66wlo8KaS1RLCNoC7tGrkKL5NA5kBms3JxcxfruOM64JVoM/C3pR
	 bS9l5wCPeEo1kyE9iOE3ELVMF8rtluqZeOsXQky4LtaXpu4djmj6L31T/ajpMvHm4O
	 uSVyNGoJxeTfBXQREl81CedUIRjeOU5LuMBhErGe5gXWp4VgvKqpNGzbHix6feLzUq
	 GxJr51jjI+fLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29BF160747;
	Mon, 20 Jul 2026 22:37:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7720196C
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 22:37:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6924240153
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 22:37:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zEWywNfmzDWC for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 22:37:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8A9C440089
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A9C440089
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8A9C440089
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 22:37:16 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e9f829d75aso4727793a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 15:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784587035; x=1785191835;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FePZl2VYjM6BzoEn/HQBfe8da9neXG8lc1Ht/Lle4xM=;
 b=e4lxP5bAWFPdWP6uHEVplBsThow7aJYYvKNyvToOhbNTMQ4YD+K5pGcUUTNSAHRrE8
 TrNo8qJU3Ap7bjOdXoArePs2kkQwTbNnI4gw8//7PP/8QWNn+udSdz/gC5vV4SMHWQvX
 5MYNW+YKLXaBekYT/+bz/HMje3eTRNjQedSIaXzkVbCutE8/4hdWo3ku5IIzOo5Rhn/J
 T0fBsc2u1Y7VtOieb6qYkrBrSeuQrdqCgngmFErU66weuMJokPspMDPE5T74MkI/p3aB
 QtOxzyxv6g2+IE0oiHrpR5WCpB5upo5ROxjqfZJIVcCfLw62VTtLGRMqpQZO1vvPVJ34
 bUpQ==
X-Gm-Message-State: AOJu0YyYLrbzf2YP0fvK8BcbjQd0kbLIO0ej4VTPo6HX2hg8GaAUkln4
 r69IJpxdZWp3hdBS+zbN+abAA5AQ3lTmATTvbJ7O+CkJA6xB89jByt0ZQY3MPYQuWyP/8QBVv5K
 kwxWoOSE=
X-Gm-Gg: AfdE7cmCave2NBYOhCuo88KzQ2UA+GK7TJegF/9TWbMRIX5TN/UXuEcSXOOx2cdt42R
 wAIBBwLFHky+q3SktzScnj5xkUW4MxylSjv37I2nQdvOTmc5CGmq0YRb9R/s5bbPvCIQ3Lfg34Y
 NQJfcLEHzJqgeZ8Ie8kHN9j27Rk6U8thq3yUg/7H3aHmaQO8RN+bK2nIFQTiPlHLQHluQoEG4YE
 8+cWWx0ehK9e5k/Q57ZZomONMuO3pjHn6/9qAF5Ht9T5+NAqVzgIagRhm6VpQ2qFZfeVVepjctK
 dfYEvC5B8Qqz8LtPpEoxVJF4vDVWSB06ZgSH3M0sC2zhL1bUSU77P/Qvc9sAgjJ/ODP09UgYrZJ
 veIE/TYdlJkLlI5nXCQUS820ohL1hhUrGjHWZ5lAwsNobAdMrnE6qzjgyyfihwUt0omsck4IaWi
 jg7ZUz1Tp2/uDyEqlvZDnM1zqKO4SOfrtQA7NSAUHMSgVi9u/X7C9Wp0aPEy5EfjuSToRK2roYD
 CXXfONf9Q/arq3XKurJpwegVrI=
X-Received: by 2002:a05:6820:1ca2:b0:6a4:cf9:9a74 with SMTP id
 006d021491bc7-6a5366d1d72mr8505353eaf.1.1784587035387; 
 Mon, 20 Jul 2026 15:37:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568e61ced6sm9706433fac.12.2026.07.20.15.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 15:37:14 -0700 (PDT)
Date: Mon, 20 Jul 2026 16:37:12 -0600
To: u-boot@lists.u-boot-project.org
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Yu-Chi Liang <leo.liang@sifive.com>
Subject: Re: [PATCH] Added Device Tree Files for Pine64 PineTab-V
Message-ID: <20260720223712.GM749385@bill-the-cat>
References: <20260720-device-tree-pinetabv-v1-1-8ba97c68020c@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1X7abbVOEETVCYop"
Content-Disposition: inline
In-Reply-To: <20260720-device-tree-pinetabv-v1-1-8ba97c68020c@protonmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784587035; x=1785191835;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FePZl2VYjM6BzoEn/HQBfe8da9neXG8lc1Ht/Lle4xM=;
 b=e5QPENvfgVjBzL6U/666Ic0eNQkrXsgtc4NMWlvpi4lwdMs3qxBOyV4CRKqkMvTZXE
 ZHrLh3MJ0rEOs5I+ULCfuofFc5F+M1dZv8vOjqzpDq302wx61twlD/7dJrsoLqfi7Il7
 NzxRzXJhBLDu8/F/1F/jYDZaPtE+6SaKOZiZc=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=e5QPENvf
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--1X7abbVOEETVCYop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 10:14:12PM +0000, anoduck wrote:

> Support is split between two separate files.
>=20
> 1. `-u-boot.dtsi`: Community Contributions
>   - audio codec
>   - Accelerometer
>=20
> 2. `.dts`: Further Support Provided
>   - SD-Card Support
>   - EMMC Support
>=20
> ---
> ##Added Device Tree files for Pine64 PineTab-V Risc-V 64bit Tablet
>=20
> As requested, division of contribution split among two files, a `dtsi`
> and a `dts` file.
>=20
> 1. Suffixed `-u-boot.dtsi` file:
>   Community contributions derived from precompiled `dtb` file.
>   Contributions include:
>     - Audio codec support
>     - Support for Accelerometer.
>=20
> 2. Standard `.dts` file:
>   Further contributions focused on providing support for the board.
>   Contributions include:
>     - SD-Card support and SD-Card Power Support
>     - EMMC Device Support
>=20
> ## Versions & Revisions:
>=20
> * V0: Incorrectly formatted stub file.
> * V1: Wrong Location in source tree.
> * V2: Misconfigured B4 branch lead to unintended inclusion of revision
>   history.
> * V3: Correctly configured B4 branch, split into two files, and located
>   in the correct place.
>=20
> Thank you, for your patience and kindness.
>=20
> Signed-off-by: anoduck <anoduck@protonmail.com>
> ---
>  arch/riscv/dts/jh7110-pine64-pinetabv-u-boot.dtsi | 1756 +++++++++++++++=
++++++
>  arch/riscv/dts/jh7110-pine64-pinetabv.dts         |  116 ++
>  2 files changed, 1872 insertions(+)

Adjusting the recipients list a little. I think a non-answer to my
question in the last email is an answer itself. This should be ignored
until a human with the hardware and time can pick it up.

--=20
Tom

--1X7abbVOEETVCYop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal6jFAAKCRAr4qD1Cr/k
CruEAP4/X/lZe1teAEjq+Lx7qBXRY1WafMVjU+9M0SI24UZibgD+Le9Gqcnlv+ru
xF4v86vKIB7MFsFsvx5T5hqkW9kNTQg=
=+vcq
-----END PGP SIGNATURE-----

--1X7abbVOEETVCYop--
