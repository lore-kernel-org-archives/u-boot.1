Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B45C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 17:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FCDE888D1;
	Sat, 20 Jul 2024 19:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uZVZ1NKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D38D08887E; Sat, 20 Jul 2024 19:11:41 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFCDB88837
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 19:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-260fff38792so1334186fac.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 10:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721495498; x=1722100298; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u3iHWaZhSu2RYHqErPDhTyzZxHNKyWnBVOWoPpKmyFU=;
 b=uZVZ1NKQdv+qr2IbdT3QA3DiQS6M9F8BCJUf+e/HevKl+5IbAOWjGhgxrZhFYn9drE
 gK0vq/IDt3BI9bpu7flFF69cE5pmLuF9LYb4SXgtsEaxioK4Dx2fGMlYuRjGmZA+Ow/x
 y9KKtYjNSFNLnr4H496r2Bkd0DW+UwvTlb4oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721495498; x=1722100298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3iHWaZhSu2RYHqErPDhTyzZxHNKyWnBVOWoPpKmyFU=;
 b=IODuEsYzEy1NovwLJdraUxum2PUnBaxvNEFbRXBlk5I1wQG0khlu+DSlVVdd5YTqhi
 W9E5B4IsCY5DOEBRFWC5vm91Cm64wI+sneZqdOm+QEYsNcV1UQ7JYdgrhGKG77QmwfWb
 oIB7x0hP/kk+MXKX2Rjys9FqkSmM2GUOy0PE4vv+jhj6q0OCUBS0AmO79dLShXW1S1CA
 82GSPq38u1OXjDOQXcuYfw7NAR/QXZe4xem+kiI7qA64e8EbeU3+69Y3p4n8XYNj7erA
 qXexwxWVQtSquaQL2VCRx8pWBqgxRSnKAiC78pSSYYJ+534vTzlZXmxi7ctDD6G9PChV
 lQ/g==
X-Gm-Message-State: AOJu0YwuMk3PTVrWR2+j2Zculbba/SLkRXQ0EZ4LSZe5J3/2Hgydjbpd
 76ymKOsLJW4U4SqvPbP0VZjbsF4Iu3bLmFQ7i52oY/BkHChkLfjZef5cSKq8LAA=
X-Google-Smtp-Source: AGHT+IFXpBNgCYYhEelzKp7EudWxKwsw+/IwufJ03yMp2hqJGhiUvk/4jYIeAL7XMIQ+z9ILoKG7fQ==
X-Received: by 2002:a05:6870:8327:b0:24f:e5f2:1cf0 with SMTP id
 586e51a60fabf-263ab42d58cmr1663732fac.14.1721495497880; 
 Sat, 20 Jul 2024 10:11:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2610ca47ff0sm837850fac.38.2024.07.20.10.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 10:11:37 -0700 (PDT)
Date: Sat, 20 Jul 2024 11:11:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] board: beagle: convert to CONFIG_DM_I2C
Message-ID: <20240720171133.GE561963@bill-the-cat>
References: <20240719215123.3358410-1-agust@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gdBkILOQhWmDMNF9"
Content-Disposition: inline
In-Reply-To: <20240719215123.3358410-1-agust@denx.de>
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


--gdBkILOQhWmDMNF9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 11:51:23PM +0200, Anatolij Gustschin wrote:

> Rework to remove use of legacy I2C API.
>=20
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  board/beagle/beagle/beagle.c   | 41 +++++++++++++++++++++-------------
>  configs/omap3_beagle_defconfig |  2 +-
>  include/configs/omap3_beagle.h |  3 ---
>  3 files changed, 26 insertions(+), 20 deletions(-)

Thanks for doing the conversion. That said, as the nominal maintainer of
the platform and also given that Robert of beagleboard.org would like to
drop this initial platform support, I'll merge this update, in case
someone in the future wishes to revive it, then continue to delete.

--=20
Tom

--gdBkILOQhWmDMNF9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmab77sACgkQFHw5/5Y0
tyw4iQv/cHndHaJ6kDBcKFUWAWlrp+KAKEgHitlFS+uvgtJSqRfMmk+qo4VekZSm
dR9Bd4mMxSaVj7wULGu5KrtvgiE1yxMJNvM6oE5vXz1btqJOnW2GfCjZ4F7mzU6g
M6zhpHvAWqYuvS0YFS/Ty+weGT/HeHfufl8rLb2ISKJY/0KCkwNW7sGsjqjBmXvh
1LrlTZqSvfUTV7ZijedmbFI7d+szgyEE8/WH3U0FpdsOZTquWhYjMOmjBwb3VTBR
Jh29PqkFQFWc6xuKJnVJjbKc83Sn06oWGMfcUoBjwpZa7a+4LZK/GUZ0DQcC2Gsy
uDX9WlfafWVzblU8MVe7b7PEuPoS2W6MturR/NV0FDp27QaBGvNs8xSL2BH44kyS
lfhC5zzbvQoc3kWQI5x/st1FPTCNsVV+Hea/hGI8dXVLmERAfh4M3Fk1nHTJmyy5
aR7Wk9RcsqtqzhYnbPOCHWid8fP2uPcupv+Ixc0z/gPT3r6Y3sKwXbeutkGu5avX
NVXxECc3
=aETg
-----END PGP SIGNATURE-----

--gdBkILOQhWmDMNF9--
