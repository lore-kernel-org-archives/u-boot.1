Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEB0C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 16:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB3E7887C7;
	Mon, 29 Apr 2024 18:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VNOPca8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA72D887B0; Mon, 29 Apr 2024 18:49:53 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83E86887D4
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 18:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6ee32bb9c8eso475579a34.1
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714409390; x=1715014190; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z51Jwn5ILjZg3/ieUhxu20B9D8vKktFp/GFG+XFCKU0=;
 b=VNOPca8FvCeP2p5M47lCurhKjTxBlnqhyx7529kcKUCjX1nRC5md8tzfQx8r1fARtA
 H8bkbdfMv1EHLyf+57RbSTg2hyOQs0Iv5gqMVwzcPbZl8T3ilLjKt+R8AM5zjjJZJMQf
 +UmS12X+L9nmO0aliloLUHdGdqK/JN99AO9Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714409390; x=1715014190;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z51Jwn5ILjZg3/ieUhxu20B9D8vKktFp/GFG+XFCKU0=;
 b=RpK4jQEiSGAG2arBXhu9FwLH0nBb48JWCCuMB0dv57GrzqY3Y6sBj1cVzohQKpXZk6
 B2k3pdVeYvM964MjfkxsjTY13GQCabr4pUhEFYeLq1mIx7GCsEOMVl6Cr3iCXoeeIu7q
 ZCJvE31Gd+VHkHGOfoVJHFG6fXwCYc1uqzyBw82uanxtPh9tJcVlk3PhN/vtAa16kiE8
 dBjcd7x6v/uqkhDxDZmx6rWeEHzKe0Rs1u7J+9LvrH/8rX+8z+mRuy06HadjG26dE5xO
 2N50hS2PLfHUspQASgOoN+MGzI/5xMW4O0wldP/E7Dvbqw//XdeJgkUQB3qfO0ZeMEd7
 pvOg==
X-Gm-Message-State: AOJu0Yx2ZRqUYcCHPjW8lOg1Om39sIlmQn0CWt5SaO8rkQyplfc/HK+R
 iFrXaI3y6L/id8px7TQre3F+UYF/qwfGvyHl9SaYAH5ssMqYUPA0EFpgtgmBmRI/Dhr2e5+ImzT
 jJQl+gQ==
X-Google-Smtp-Source: AGHT+IGSybiZgRGnRbZhTbWkr3+8jjLOilrWDJ/4zbdj3yn5QZSnrJSv7jBMbrlSFd57ytfBlOvqJg==
X-Received: by 2002:a05:6830:1101:b0:6ea:1d8e:19fc with SMTP id
 w1-20020a056830110100b006ea1d8e19fcmr12265113otq.34.1714409390252; 
 Mon, 29 Apr 2024 09:49:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 ay18-20020a05620a179200b00790f6b8fa0csm918182qkb.13.2024.04.29.09.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 09:49:49 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:49:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240429
Message-ID: <20240429164947.GO1054907@bill-the-cat>
References: <20240429103524.1146511-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/rEO5d32ER2bYz6h"
Content-Disposition: inline
In-Reply-To: <20240429103524.1146511-1-festevam@gmail.com>
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


--/rEO5d32ER2bYz6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 07:35:24AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit 174ac987655c888017c82df1883c0c2ea0dc24=
95:
>=20
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boo=
t-mmc (2024-04-26 07:39:18 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240429
>=20
> for you to fetch changes up to 37e50627efacd8dae18b564e9d8886a033e181bc:
>=20
>   ARM: dts: imx: Convert i.MX8M flash.bin image generation to binman (202=
4-04-28 12:10:13 -0300)
>=20
> u-boot-imx-master-20240429

Applied to u-boot/master, thanks!

--=20
Tom

--/rEO5d32ER2bYz6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYvz6gACgkQFHw5/5Y0
tyw7CwwAop4aqdrKCHna63FrU1SATT1nQ7i06sse7UbMVVADP5DWg4k7kt57o7CR
IfSrJy59nG7lah8jW2r2vD8nXBo5bVpKGbVvSDXImY+QvgdoMTe6ilaV1BKRHlho
Ro94HxLcnG4fjYCoxn6L13Pu/jeoGa9Bp7qJgwpKhCRTGpCgPzlfhwqi+N8VhO30
3aUrm6e+YLAhth7Jy6CWcT5sXyUZG0jUK9KTsNJgoPL29sPY4rXzwV+7iBbaOINu
P1PRl5m3bZgbowjBYk3TzvN1TnGBs3alZNjrWW0HRzVBOzT/4v4HTMG+qKLoXSPT
uQLG1/DGh+Iv8IYFj/hP0bv9cqpn679lj0E5qUwe10xFCOSkFV28sg6P6FJDgkaS
NrWgJQm/Gy29ktQMWiw9bcsd8xFfgLim1uUKSu7Ym25q2FfZf7vqwlrR60ariNFD
EsM3AEIyzwo/rE4UFGYszJjNHj1RzVNs7QcuG9oLFe0dur3OlQPT9L061Q3nQFSL
kjyasqAK
=MiK/
-----END PGP SIGNATURE-----

--/rEO5d32ER2bYz6h--
