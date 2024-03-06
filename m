Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF141C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 12:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4F6187C61;
	Wed,  6 Mar 2024 13:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="S6g3syyM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C4A887BD6; Wed,  6 Mar 2024 13:55:44 +0100 (CET)
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C4787D9B
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 13:55:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [213.135.10.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 22E69388;
 Wed,  6 Mar 2024 13:55:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1709729740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=UP/4+AXPcHAM5/gNlpqoxc85tyPx6tucnSD5r/YpHwY=;
 b=S6g3syyM/MiL9iwvka5/XUdY0Tnw87AJlzm94DPamk6N3FDMgvn9mg6CJiki6dXcKAUVOO
 2UQv/wMaY9W+Xg7NbvQ/hO5/uvOiPqqA4tzMzsAlDlykvLPzZ7dBi413jCQOrAHcH2542k
 9NlXk3Ra1JoY2GjtbwbQ9+YSuP6ZESWBcui156oIbXXKcoFUPwY5Od1OJlUXFlswBx42DH
 UOHbuDjGX1zevvDiNn6p4iPCXpdfoshphAvRem80widurHYpou3sXOHF+PiWDxDCyxgD2L
 xVclATsKzge3BESyegOnhty0cxFw3tSrnq2BeYj0VjN5lKAAZS/a6ULZd6vmHw==
Content-Type: multipart/signed;
 boundary=628dd0f2262d98db81a5a3b4102f9eb2bd50b702375f351cd3de550bd1f2;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 06 Mar 2024 13:55:34 +0100
Message-Id: <CZMOLX07WDHJ.36M7NNZK94F99@walle.cc>
To: "Marek Vasut" <marex@denx.de>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] mtd: spi-nor: Clear Winbond SR3 WPS bit on boot
Cc: "Hai Pham" <hai.pham.ud@renesas.com>, "Heinrich Schuchardt"
 <xypron.glpk@gmx.de>, "Jagan Teki" <jagan@amarulasolutions.com>, "Johann
 Neuhauser" <jneuhauser@dh-electronics.com>, "Simon Glass"
 <sjg@chromium.org>, "Takahiro Kuwano" <Takahiro.Kuwano@infineon.com>,
 "Venkatesh Yadav Abbarapu" <venkatesh.abbarapu@amd.com>, "Vignesh R"
 <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>
From: "Michael Walle" <michael@walle.cc>
X-Mailer: aerc 0.16.0
References: <20240304161607.82759-1-marex@denx.de>
 <CZLOVK212G8L.2ISEL1IIWU1YE@walle.cc>
 <7c0e2496-4338-497d-96cf-41d75e2fc52b@denx.de>
 <CZLTVKVR3AG1.BZIQQU2PYSU6@walle.cc>
 <a28b0543-67ee-4e33-91c1-86ae36eb44d5@denx.de>
 <CZLXRLFU5YKU.1S5D9EZ3GUTH4@walle.cc>
 <faa78709-6b7c-4394-8048-3c1f09b65a04@denx.de>
 <CZLZ391C9O5F.38A18T9S51BNT@walle.cc>
 <d522ac8e-8664-4798-9069-947691c6cd43@denx.de>
 <CZM55T7YDKCR.3AIA4OQT2VG0S@walle.cc>
 <ba2831d1-9ba1-4cd3-89c5-f4b9e8a4b94f@denx.de>
In-Reply-To: <ba2831d1-9ba1-4cd3-89c5-f4b9e8a4b94f@denx.de>
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

--628dd0f2262d98db81a5a3b4102f9eb2bd50b702375f351cd3de550bd1f2
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Mar 6, 2024 at 3:56 AM CET, Marek Vasut wrote:
> > I'd argue if one wants to use the locking at all, you have to set
> > UNLOCK_ALL=3Dn. Otherwise, the bootloader might come alone and just
> > clear your locking bits again. Clearing the WPS bit there is just
> > one more thing which IMHO doesn't make much sense.
>
> On the other hand, if UNLOCK_ALL=3Dy is supposed to work and reset=20
> locking, then the SR3 WPS bit has to be configured to select the=20
> standard SPI NOR locking scheme, so the locking can actually be reset=20
> using that scheme.

Yes, that's what I've meant with "the unlock all works as
advertised" and your patch is fine.

-michael

--628dd0f2262d98db81a5a3b4102f9eb2bd50b702375f351cd3de550bd1f2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIcEABYIAC8WIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZehnxhEcbWljaGFlbEB3
YWxsZS5jYwAKCRDNyh2jtWxG+9OYAP48lD5V4W6ZtS2VXwQW7z7loSQYE0VyFTr8
OIQOJjuvMwD/fHszb9szqtF5DUI02DVnWMoBIsZNbjvzWwMAwucgoAc=
=Qsij
-----END PGP SIGNATURE-----

--628dd0f2262d98db81a5a3b4102f9eb2bd50b702375f351cd3de550bd1f2--
