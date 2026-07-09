Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55FFC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4054984B01;
	Thu,  9 Jul 2026 03:53:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pd2gsVHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A0F84994; Thu,  9 Jul 2026 03:53:08 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9554584B01
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 03:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6a31b9a492aso214203eaf.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 18:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783561983; x=1784166783; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=knV+srueQKe0xHl1mTWRl+QRKekkEwnkAhVCHBOrwjI=;
 b=pd2gsVHelEzW+Z+yx07sznATWZEmZ5yQ8iRW4SxN1JQw2OFBeE4cuVUaoyfz42U5I0
 gPiwI2BlWY8c2pJUCEUGrvy18ZFfDaRMFBTAWjxw0AmrSgVhQG7IXI4g7Q1q1HmGFjxo
 h+ExAT9fIZwoLDi61sqa3y/rzUHcMFrPFGxKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783561983; x=1784166783;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=knV+srueQKe0xHl1mTWRl+QRKekkEwnkAhVCHBOrwjI=;
 b=FJVLjg8/hKGc4zTRkWJy/pklGg7IpgVtI1L5wa5ka39XxXlmrvZsrYhvWt9tyQ9gry
 WU6Gg5DFV6Dk/eTsfQEPHPsq/WITpd97w71hjbLIdk140BnCW5rP/IDdoYN8q76KZvHe
 L17vTp+FI2vomDHLfBA9wlFVNwlCSG5r32glATnmWJ7NZEyLjgFnHWazAOCaCT/LYCNT
 tDONzpDTvZnDlr2FysRnwWpde1KQ7F7S/e47PiO6NXU5gCx25HIkJUJCJqQgQnVt6nEl
 nWWESEFha+iY964vx1xlJ9YiTjnDCmlvfdBsUmhZjeq1/yES2QSXOYWCsly2F9YBEfmd
 J5qQ==
X-Gm-Message-State: AOJu0Yxoyt1DA5348tgzbWWWhtaTkNr+Y2hFulkr5nTRmaYPxQu/6zzy
 iqg3ZkX+9fAVihagiFuEicJXpiiS5fln6/HVCMIteTySo2xv+5hmKzRU8v9mShghobM=
X-Gm-Gg: AfdE7ckrL0w1ljjg3CLZCgZJF2/FBp5GVOPJ+Q9SQ2eBSH06l2MAEUfo0H0UZq9bQvl
 8dOVCwz1es6jOuC5yrCe7xCUfg42y2+8OhC8b5qS/6oS8B+P0cFteeFTc0+mPuYctGKimHbHbVp
 DTK72em+bLiinyctQqsaWAIcRxJIMYh6VKVsg0tUmMa6RHoq9IcJ8E3n5fw49sMzBOm7Tk+BUw7
 Edwn6HCHpIiA9ko7Pi1t0lokEnDcFhG/R++pAHHCaVzf/DsizfxIwJLseGjLv7+mGOsZHyDmyec
 V/ODwPVCRWdTJAwF7BHW+he2tWqGM9fg7dQcjV/3LKBwicRvQjH1R4E+6/o3t+rJVSlH6cMhyuO
 WIdmdg0AmXuEUX/8kPc7o9QIGVidOfQ6Z+ry4I4bY+Y7sfh7eT2GdBLPQL+oLGVgSEEgePu6N/v
 uFM55zjqgKJwGJ5pz5JHGGjKWBPAKne6EEcU6QOw7snPUMCU+fqdafW9SY84yhMObeHIJyIElGF
 Zb4fdcmwbVUMC2LcecI0DD9LoDETBnVKRlhtQ==
X-Received: by 2002:a05:6820:992:b0:6a1:fd87:5325 with SMTP id
 006d021491bc7-6a36d9803c0mr3691956eaf.19.1783561983340; 
 Wed, 08 Jul 2026 18:53:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a36a632ff6sm3039931eaf.7.2026.07.08.18.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 18:53:02 -0700 (PDT)
Date: Wed, 8 Jul 2026 19:53:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 09/11] Kconfig: serial: Depend on correct xPL symbol
Message-ID: <20260709015300.GT749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-10-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kAYPiWYtqpip4BTg"
Content-Disposition: inline
In-Reply-To: <20260708220540.3368825-10-jonas@kwiboo.se>
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


--kAYPiWYtqpip4BTg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 10:05:35PM +0000, Jonas Karlman wrote:

> Change xPL_SERIAL_PRESENT symbols to depend on the xPL_DM_SERIAL symbol
> intended for the related xPL phase instead of the DM_SERIAL symbol
> used for U-Boot proper to make CONFIG_IS_ENABLED(SERIAL_PRESENT) guards
> work as intended.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/serial/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index e221800d5d06..f125061fe184 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -71,7 +71,7 @@ config SERIAL_PRESENT
> =20
>  config SPL_SERIAL_PRESENT
>  	bool "Provide a serial driver in SPL"
> -	depends on DM_SERIAL && SPL
> +	depends on SPL_DM_SERIAL
>  	default y
>  	help
>  	  In very space-constrained devices even the full UART driver is too

Using the database option to qconfig.py, this is not equivalent. There's
901 platforms today that enable SPL_SERIAL_PRESENT, and 344 that enable
SPL_SERIAL_PRESENT but not SPL_DM_SERIAL. Now it's possible that there's
no functional change here. Something like "pinetab" would be a single
platform to check the size changes on as it's SPL_SERIAL_PRESENT=3Dy and
SPL_DM_SERIAL=3Dn.

--=20
Tom

--kAYPiWYtqpip4BTg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak7+/AAKCRAr4qD1Cr/k
CsnoAP411N1ej2Zni6vEX1ZB39odmHaLX4Lv1mGviIlthNslTgEAxbidZ3kv3D5E
axHD8GTM1dANMe+/ItPwegcnjY80nw4=
=brjZ
-----END PGP SIGNATURE-----

--kAYPiWYtqpip4BTg--
