Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC7CC001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 15:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1231A8696D;
	Mon, 14 Aug 2023 17:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NNnMJ381";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E04538696C; Mon, 14 Aug 2023 17:04:27 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE2C386967
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 17:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-58c4f61ca12so4081907b3.3
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692025462; x=1692630262;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JGFyLvFOku9fg37eu+ZRo0TzlLvSfLtW5bPBOG+U8WU=;
 b=NNnMJ381eo/yTBR6vlHVxY1DPNRy+qQS/BHMjzEeiNmwtddMOPoVwFdu5K0cV+2UWY
 UF3rkyjHViHD4uE+9T+7QU3Uxnn15Je4GKhAx3RbWZEKsQ+GisygKlZIzs/6DqP8Qm2c
 53yfeykY8yRo/TIp24O8DTaenL40aqu0jfVi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692025462; x=1692630262;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGFyLvFOku9fg37eu+ZRo0TzlLvSfLtW5bPBOG+U8WU=;
 b=Rzoz/xwYCoMIIGPLa5JYRQr9ipOfEuWy84jN95l9zH+4bdlNgD+hKbwBTydUvUxQQl
 aqcbgnbzxnWmOLcYtAXW2trG2WdFyuN7JVpYfyNtjDiu82ZrGDbU7zTX/lWlDE9wDaSh
 S1nmZhFPyHGcIcvZU3iyeipgiR6Q84R9hf0aPEPWJGejJ/f5uosDSFC8Hy4/X8hF/5lb
 9BMN30em/n+i0DhxPhzdhlBHL1zYLf3rAf85vg6mUepnwmNAdhMHe7Of0Kj+G0E+8O+H
 gGZQ/aXT9vPPVSjQp95L2u/gUrjVoOLvbgkwwY6eUNKGOC7QEpWBqTTmbyaaRa7zJBCI
 sLoQ==
X-Gm-Message-State: AOJu0YxL9WzF0kQa+99nBX4vnXAajDqKjSPXR19xnMhBJSBTiw3LgEnF
 MX2s+61d8bFgXNFiNP3dSVfre7sRLNVT7eOVkOEOoQ==
X-Google-Smtp-Source: AGHT+IEUsNO2EOL6ECVSam//SaDDdFT3bAdemLdPhRT9pEMn9DnmDupYN4+r67pDPGR90ugCn1JdjQ==
X-Received: by 2002:a25:ec0d:0:b0:d11:2999:532e with SMTP id
 j13-20020a25ec0d000000b00d112999532emr12006171ybh.20.1692025462677; 
 Mon, 14 Aug 2023 08:04:22 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1d1b-2873-dbaa-7ea0.res6.spectrum.com.
 [2603:6081:7b00:6400:1d1b:2873:dbaa:7ea0])
 by smtp.gmail.com with ESMTPSA id
 s3-20020a25b943000000b00cad44e2417esm2345244ybm.64.2023.08.14.08.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 08:04:22 -0700 (PDT)
Date: Mon, 14 Aug 2023 11:04:20 -0400
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20230814
Message-ID: <20230814150420.GV3630934@bill-the-cat>
References: <20230814121413.798805-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v1G0nSo15JeYHMH9"
Content-Disposition: inline
In-Reply-To: <20230814121413.798805-1-kever.yang@rock-chips.com>
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


--v1G0nSo15JeYHMH9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 08:14:13PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the updates for rockchip platform:
> - Add board: rk3568 EmbedFire Lubancat 2
> - Fixes for rk3568 clock and pinctrl;
> - Fixes for rk3308 clock and uart;
> - rk3328 rock64 updates;
> - Video fix on veyron board;
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/17348
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit a5899cc69a99379f01e8e2f9f98e0e09b24f16=
56:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-watchdog (2023-08=
-10 11:40:09 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20230814
>=20
> for you to fetch changes up to d7009faa098169abd7ff0e4b41af89b17896a7da:
>=20
>   pinctrl: rockchip: Fix drive and input schmitt on RK3568 (2023-08-14 11=
:07:27 +0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--v1G0nSo15JeYHMH9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTaQnQACgkQFHw5/5Y0
tywUgQv/Z26DTgpqeVCr523v4FsIMnjYBn8DRleMYqFnwrrDaBmy+PwgEO6P0CDN
6Pypk6FFvDqqwXJKz7iircgSFddys8zPQyj3iU/aAvWOaRvN//mkZCoU2EBkQBGZ
Mi85RhQEZ1SLTVwWMMQTAX00TS4yFplRNBa5WL785gMfcb715W2suNdnaWtMN48v
9zE6shQbhhjvJNBuVE40XUNwtWNZUfLMeQZtsbwPENGmA/DKHnsXUUjsHgQar9QJ
35f8siStgMQxGjA1ZCECPbNz7wAEOqxDocY/JK9Ot4YAHQYZHwg/g+83LwBMaEOo
WrxQqpvWqJyoNVATHHP4+PwbXAYHUdMN4N/ZbJ7qgtFhjy8lB29+XRdErexoOAbM
HUJYOictq+mERq3voMPzS+yKom9vYNAJkAAVj3WJi8fuGYdGaglHz4pgxaJIGMjC
hpN0JSA+6shauUPGXzdAS5XgE5ng5xnv8N07BlZkPoQ5ls9ydQBJJ6ybn6c5PbA6
BPcuVwwo
=bffQ
-----END PGP SIGNATURE-----

--v1G0nSo15JeYHMH9--
