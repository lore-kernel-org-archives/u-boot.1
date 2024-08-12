Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC28C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 18:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA1A888C1;
	Mon, 12 Aug 2024 20:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fYfYPrxy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 969D48887E; Mon, 12 Aug 2024 20:42:10 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259368887E
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 20:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-709340bd54dso2038760a34.1
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 11:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723488127; x=1724092927; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vaIAtPzr57Wob44hvI+fK8XqKZNVyChvr4je00C7mEY=;
 b=fYfYPrxyE2j4yi2eVi2VrlGCufUZxce2u8VsYdlFZzzH3bFcu4MBdvzfg3VF1Kt7Ac
 6Hp1hskRzfvVuv0YchQKDCpUoQrF3kqjpln+yVWbqMN3cNK2LBhklcfy4PDyQWsEtCNr
 i8sbIq+hqFUA+6JRtTWsQKcx2cTCmLyvENjyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723488127; x=1724092927;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vaIAtPzr57Wob44hvI+fK8XqKZNVyChvr4je00C7mEY=;
 b=TI0aEYjZ8dWHpjTFivQjahUhfqCBlbJq926Y7SS8QAUJZ0qFufXxhLt5XmUBBvHZQj
 dsHTXuXhdtyHMA5ttz5sJXC3Uu1EuNoct2gibRpd10TNTdDSWuwYDLXkmGL3byB/OODB
 MZD/Qale29T73AjnQjsRc6CP7N0a4nKewHaFS1jezdZ7MBEZ8dA5AMCrye+eUk1QuHfK
 O5Si+eExoPtdOUJ9F+v8/oynLstnXEnqkpzcdvOZk8T+iYzDdjluFob12lo58EAJaU9v
 y2e1fNXH94OHMuPG44NFimtnXxagwRKBb65BkxyGOst/FmSbWRfqGmT21mN4nAkEe//M
 SkGA==
X-Gm-Message-State: AOJu0Yyxpq48neRP0skYN4OdHsf2OKfa9oJw5n2tmBkPa7TyVM/v6Zdk
 azUyxR7Ijbbvuvwjl8bqF9lCzCVKsshMzOgGI+/vI6UgBzeRJS7GVdpj1rA9jEyZjhp/ALQNYno
 u
X-Google-Smtp-Source: AGHT+IGY1QlDhKr1xvOBw84rOKuSnb6d0KOd1jMCwFWvufcNw08/QzCRuFPY2veBn8PkvLCdBE3W5A==
X-Received: by 2002:a05:6830:4101:b0:709:373f:fc92 with SMTP id
 46e09a7af769-70c95665018mr274245a34.1.1723488126931; 
 Mon, 12 Aug 2024 11:42:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-26c721030b9sm1934046fac.24.2024.08.12.11.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 11:42:06 -0700 (PDT)
Date: Mon, 12 Aug 2024 12:42:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20240812
Message-ID: <20240812184203.GG1626301@bill-the-cat>
References: <20240812094530.39676-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rxbzc0aNkRC+Q/Je"
Content-Disposition: inline
In-Reply-To: <20240812094530.39676-1-kever.yang@rock-chips.com>
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


--Rxbzc0aNkRC+Q/Je
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 05:45:30PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the updates for rockchip platform:
> - Add board support:
> 	RK3566: Radxa ROCK 3 Model C
> 		Radxa ZERO 3W/3E
> 		Xunlong Orange Pi 3B
> 	RK3568J: Radxa ROCK 3B
> 	RK3308B: Radxa ROCK S0
> 	RK3588: Radxa ROCK 5 ITX
> 		FriendlyElec CM3588 NAS board
> - dw-mmc: allow 4-bit mode;
> - dts and config updates;
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/21997
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit 1c5445f190cabfd0e453f583aca44da10156c0=
d6:
>=20
>   Merge patch series "Low Power Mode: Package TIFS Stub in BeaglePlay" (2=
024-08-08 18:37:11 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20240812
>=20
> for you to fetch changes up to 192318d3dcd42da47b9df532a9bda125ed120e4f:
>=20
>   configs: rockchip: enable "ums" command for Radxa ROCK 5B (2024-08-12 1=
5:44:04 +0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Rxbzc0aNkRC+Q/Je
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma6V3sACgkQFHw5/5Y0
tyw93gwAqIrt5jqrO9nJuKY86Wzna6ASvFpjjQ7wdMQqfecPzID7mgJ7ugZyCMTo
RoPWqs5hI3DQXSmPt6/1MMCuVWSbLL/5U+BlAlnwf0XfddwyjsHspQoV7wUkHJlk
hwJX87Ot61ucwN+UKJRARj+D8pTwwMqk7+SmqBxOendz0WEkHzEIbvsV+HK4I+/m
OJfqaolCI1CoCRNLrfRLKLkrYqZYsTxtznLa5mdMfVae2+/SNDOGxt66msEVTxKG
4BBYPR6SsK+KQ/CGyL9ihNC400alnBdJzOjfymDFc99VOPqKGjp8xndIl2Hia/Zp
eOcfUg+ygUu3Ozj51tarIfTa3IxMXd22I0RVEmzykxApnn8M1hdNWOlWgeSEMRN4
WzLN2hfxpMR0Twr0z4zOwceix2dGHjxSXV3cvFMAdt1H6CvzG+6xUtczsX9jEbvp
RrkcIzkAYjKVaQiAMrCKoXQLa59CsJ0K6Mw20xpWnBfkvVwQh5CZxd+v6tJFCLnB
A2IibgvP
=FEEd
-----END PGP SIGNATURE-----

--Rxbzc0aNkRC+Q/Je--
