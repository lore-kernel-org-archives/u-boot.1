Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EEEC47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 14:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71BDB87B90;
	Wed, 17 Jan 2024 15:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aUkd8Gqt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D707987B99; Wed, 17 Jan 2024 15:26:43 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7811487B92
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5ebca94cf74so106823837b3.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 06:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705501600; x=1706106400; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WALVb3NmTXYg9cEq+pGwGlgzN2Sa/5+/1ma5PnrUe/g=;
 b=aUkd8Gqt2k3xrTyPZXu9+cIfLSMnTv2kZxIHe6hJ0K+5w+kkCdpWlXx+GHBuyzkMnp
 JB5PisEBrRO3CDjaIOc1ngml8057nLEin4gzFe4qk+wmnDN4BlW1xQemXKTq413hgbD1
 RNj1O66tGQh/wv0cQn731eUZuNOI5/ST+UKbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705501600; x=1706106400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WALVb3NmTXYg9cEq+pGwGlgzN2Sa/5+/1ma5PnrUe/g=;
 b=c7CRAIrJ+h01QTOD61gDQfszlFT1lHISftTt9Zvxr/yUdl5vHmtu2yleL3udnemiKl
 ry6XPDY1L4GXnXxYy6scpahTr7vEOkAXNQTlkTWyjDApHFg53xZygk1MkULHIWQKfHjO
 vKqIXtR3Qiu0BNWdyssg6kRCxlrTaFM+RdsOS7+LPj3rys18LJ+NIXuNqn5O1PrdPJZD
 npk7WBpxb3x2Lp7YCWkmJ4NY36qiD78nnK58vR/m4UqqB8zc+aO1gXb0QM4aCdd90Umg
 lVo26x5pY68LCWqwIIL4gvTbnY5wKTxvoH6DkbWY/NEHslh+iy2BQRzoRcqFM3NxgPmf
 NDmQ==
X-Gm-Message-State: AOJu0YxyI0LYctJPM3vwC56grfjKwZCV9ERJ6Aw5iy+jLxY1qBQrt4Lr
 t0Q2ihCNKetAhblRnv8CHrk1MQ0gxL3IjBNJ5I+rEFk25BY=
X-Google-Smtp-Source: AGHT+IHR9r/vnADkcOf5Ap1cNbD1wilwj6hNjFcWZdQPlm18WdCRz5IQk+O4PekOaj8HPze3K3McRw==
X-Received: by 2002:a05:690c:10:b0:5ed:4be6:fea1 with SMTP id
 bc16-20020a05690c001000b005ed4be6fea1mr6953314ywb.13.1705501600226; 
 Wed, 17 Jan 2024 06:26:40 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 i17-20020a819111000000b005ff55dc76e9sm1440493ywg.14.2024.01.17.06.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:26:39 -0800 (PST)
Date: Wed, 17 Jan 2024 09:26:38 -0500
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de, nm@ti.com
Subject: Re: [PATCH v4 1/2] board: phytec: am62x: Add PHYTEC phyCORE-AM62x SoM
Message-ID: <20240117142638.GO12635@bill-the-cat>
References: <20231220091811.80373-1-w.egorov@phytec.de>
 <20231220091811.80373-2-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lR/ioQZtAcF1+sQs"
Content-Disposition: inline
In-Reply-To: <20231220091811.80373-2-w.egorov@phytec.de>
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


--lR/ioQZtAcF1+sQs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 10:18:10AM +0100, Wadim Egorov wrote:

> Add basic support for PHYTEC phyCORE-AM62x SoM.
>=20
> Supported features:
>   - 2GB DDR4 RAM
>   - eMMC Flash
>   - OSPI NOR Flash
>   - external uSD
>   - Ethernet
>   - debug UART
>=20
> Product page SoM: https://www.phytec.com/product/phycore-am62x
>=20
> Device trees were taken from Linux v6.7-rc3.
>=20
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--lR/ioQZtAcF1+sQs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWn454ACgkQFHw5/5Y0
tyzmowwAgLqMsWvIIYGufGQMjHdTArdUWL6KdabiPprrvYOwg1RfAtNZ44Jp4Zzq
KV3xrn9l23kPlAB9LzD/6/mE7NbaiZhY0emMb4QysyGPyx/MaV8x9yOGQ00QiqVl
poOgFwt4Z1xqdEcXYI0FOYyswrH0JgiZO2r3y6RPrVFXJfbN1JphSp/xuRk4lHlE
yS0R7y0uODg9fh0WkoruT2sc3eGGkTw2ii4wDxXPx1KwP70EBpJ78ETIIBR0i/P1
JQ1pOqxfoMtyJEutjEni8A6twT8q23cTRJuW1aORcUd49XJUvKGCxsKjoVLp0ohD
1lSlLJ3BH2RX/gqFIyoC7Ixr88mqlZKCrYgMEIMUGJthQXAwNgQY79WloUmqdoWx
n/o6XKHdBd561xqtiEgEeKPkeYslk8eCe+cDCe0cLaAKjFLV936p/9/C1vE8KFXG
pXee/EkTZL2Gw6SJS/0kulZ8Xl+1XGfG7OVVVh7c/RupPE+WW9PlKKl2O5tUKAcJ
smnv2KE8
=0ac+
-----END PGP SIGNATURE-----

--lR/ioQZtAcF1+sQs--
