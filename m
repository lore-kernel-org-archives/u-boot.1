Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156C5C47DD9
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 15:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5036C87930;
	Mon, 22 Jan 2024 16:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tMzmpB/7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 116CA86F1A; Mon, 22 Jan 2024 16:10:27 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F882879D7
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 16:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dc22ade26d8so2334523276.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 07:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705936222; x=1706541022; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6VQHeylH+cJkr+Qbpg/IK+T+bcXkLgbB6pS1DMPCTTA=;
 b=tMzmpB/7LNKVeSGVqRDkOoNBF949szvOdlt6s0YkFsJ2DQHLO0ZQfJjqsRSZWLfKEj
 E5qGZsnzegiCjRrFopU2uwDN/5kICn/46Y1YugeD/+bmh/1wc8aBWLOxetSbhjlHtpAB
 xuMG4EAoI2tnkwBnnXiSzoz33jOuTP/PnMs+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705936222; x=1706541022;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6VQHeylH+cJkr+Qbpg/IK+T+bcXkLgbB6pS1DMPCTTA=;
 b=v6sjqpr/zqTsYP7BjI4nPaPuWj2R8WYBVIYVJA2qDFvj0B+7AASfEIMglw5JFc+GkK
 HWK+cbnMO3gHLeLd0w3YvXgWrssjs8E8yIlD8VZKShAuH+y7yy5nHD1bhJpDih15nbhf
 yVeiPHa74blNCKeknPCfGfMhSxkUtD/5BPkchi27vH5qLvlatCdR/bgMbLXP1sGvUMn+
 EedBpagxWk1j7YRr4bVOBE7R+bbYTQ4/yr+o1uJgXgEj2dN8T3brkQuxMBCTKRCMgdzc
 nItpL4Rxt7aLxJih9wrJ8FL0bD0/iwyyL7PNcJE31CvipE6X4RIug/IOzNCxMxrP3fl/
 0w4Q==
X-Gm-Message-State: AOJu0Yx3DAWlr0FN2K2+TA2wjM8Q6dIg/dOOBRN1AA5qMeLksgzW2BSn
 Ar0ItqnfWqKFmLi6RZOfWawgqfBVDJoFo3P+31p40Gb7WEc/hPUPUvAfb345TSaNFeJsyTIOKvS
 i
X-Google-Smtp-Source: AGHT+IH4vmabkAqMWdzKT3RzssTY3Kd0VE8Sgkge8EUJtM1f36AwkYdfBN6ueZCDBuwEXsAGb9tNkg==
X-Received: by 2002:a81:4893:0:b0:5ff:52d5:d86b with SMTP id
 v141-20020a814893000000b005ff52d5d86bmr3144226ywa.18.1705936221939; 
 Mon, 22 Jan 2024 07:10:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 w13-20020a81490d000000b00600052be128sm498931ywa.73.2024.01.22.07.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 07:10:21 -0800 (PST)
Date: Mon, 22 Jan 2024 10:10:19 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de
Subject: Re: Pull request: Please pull u-boot-imx-20240115
Message-ID: <20240122151019.GJ3652023@bill-the-cat>
References: <20240122130258.1161602-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SKALK4TbNxaaSOsC"
Content-Disposition: inline
In-Reply-To: <20240122130258.1161602-1-festevam@gmail.com>
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


--SKALK4TbNxaaSOsC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 10:02:58AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx, thanks.
>=20
> The following changes since commit 3c04fcf3137d5f694d52b8f355373e4baabe5f=
78:
>=20
>   Merge patch series "k3-j721e: beagleboneai: Fix USB" (2024-01-20 11:39:=
13 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240122
>=20
> for you to fetch changes up to a80e0e7711a2b2890a583d88dcd9af978ddada32:
>=20
>   ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM (2024-01-22 =
08:40:02 -0300)
>=20
> u-boot-imx-master-20240122

Applied to u-boot/master, thanks!

--=20
Tom

--SKALK4TbNxaaSOsC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWuhVsACgkQFHw5/5Y0
tywBGAv+PFqVl+WtAbncipDQDZPSgWD5su5gyJsaMP3tba9WTtrav7Ydi3bTVbWI
Z/iMMuIQGoc9emA3ieWxFZhWl1I855eNKIgHIDI6+m0Dm3gJWS2nhAX+Be0NZLj5
HdItOoTi8gfVtyyM/nOhlPhTXNwYh1YEvOF2Bgtk+1EWSUCUMUNmRUQ1CwlSj6w7
FG1l41vvaMaDXMb0vEkYgkKE02WChG4sgxOJPZ5TGlTAUQri+zUyIB72/glAHmgj
pOefKC3G1K2hD7yIKh+RHxaADfAfpQ2rVXT1qhKM0+lnspa6KWWYaVVNQVRHhHkx
Chfi3W71VEBu8aCHzniH6hzDvB5SPYD4M3oBWwFRTChmBCjnKTJj040U0/lprBFo
3p9HmVrvD1zetqdXgS1XLT9Qp7jZT3eucP6aajbPiyPBOVzKQTTYiObDeQH0PUyq
MYPSr5FYAO649fSc97dgobzeW5/yWxea9b0DCQfFKVPw+XwAnY94bkRofyAqVsPq
tEhrh1zu
=XxUA
-----END PGP SIGNATURE-----

--SKALK4TbNxaaSOsC--
