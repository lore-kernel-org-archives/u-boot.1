Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534DAC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 18:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0C81888B2;
	Mon, 29 Jul 2024 20:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UwedYzQe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6796888B4; Mon, 29 Jul 2024 20:17:32 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2099888A3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 20:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3db22c02a42so1937138b6e.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722277049; x=1722881849; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6lGgHgNsIx1+vYKw1bzFgr477hb29Y79+BTlhVdb6TU=;
 b=UwedYzQevShCuYBed6Jb0JTIKKi+tvi6jq/W9w1u0QD2jiEsB+KOt3IYYSwAx64vbW
 zSi/g+ysO13JM32U7Dy3yOnL4vZ9akpwsT5cWnsKu7wofHA7XpDT5jUITVf5SXmIlKkU
 02jcRf5n5Xvdl5yv8kM20l/8YPez7yBUJUfpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722277049; x=1722881849;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6lGgHgNsIx1+vYKw1bzFgr477hb29Y79+BTlhVdb6TU=;
 b=kKXOy8PvjgZe5/fAXExENzRc9EL9dJ/MzLdt6cdLvSKQkB8D87Rm2pqwQG7vSMiHGK
 Hg8RLVFWaCq/bRZV2PbKEHiYgK0L1J1W2u1ZQiXCUb0aIwWUamjziXxmG3ucGtybpSx/
 sM2lT4dCrq6+PlT7H/oW1zVLUQwXPVvdwBaDKClIXJokw1W90CIcOZEVRYzV0J6hqgy4
 XGwFNSLtPBODOBuO95LHOjeyiLnGKPI3bcNNMVdMazPWCyBWcN3zY3Evqb6OEXk4Xkx9
 NBonCw2/OX+7i4sfZql38dFkz3pMF1N65rcji2tJXlf4RRPAORuXR7siXxfrMei1Kzbi
 qnXg==
X-Gm-Message-State: AOJu0YyvT59UcXpNABqRkrmNT+ACHIpkCK+849t/wGbX3Hsdhg9SU6x5
 YQ5rnDnubUIMNcAYn0FUGml4JH6Ej9Bf1Ft3SXWgGE8MPgW9nDwWrMmOTvAFKuA=
X-Google-Smtp-Source: AGHT+IHRVU07h+Wz7CMu/XH9B4neoX8wMjYCds/t79WlYSEM4gLCjRaDEi0ETHTGyY6LPYb/igO/XQ==
X-Received: by 2002:a05:6808:2010:b0:3d9:2bab:de1f with SMTP id
 5614622812f47-3db239d3588mr11860512b6e.25.1722277049515; 
 Mon, 29 Jul 2024 11:17:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db135608ccsm2192059b6e.52.2024.07.29.11.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 11:17:29 -0700 (PDT)
Date: Mon, 29 Jul 2024 12:17:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: u-boot@lists.denx.de, Yegor Yefremov <yegorslists@googlemail.com>,
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>,
 "Andrew F . Davis" <afd@ti.com>,
 Javier =?iso-8859-1?Q?Mart=EDnez?= Canillas <javier@dowhile0.org>,
 Felix Brack <fb@ltec.ch>, Heiko Schocher <hs@denx.de>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Adam Ford <aford173@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 Thomas Weber <weber@corscience.de>, Enrico Leto <enrico.leto@siemens.com>,
 "Derald D . Woods" <woods.technical@gmail.com>,
 "Matwey V . Kornilov" <matwey.kornilov@gmail.com>,
 Niel Fourie <lusus@denx.de>, Parthiban Nallathambi <parthiban@linumiz.com>
Subject: Re: [PATCH 00/12] omap configuration cleanups
Message-ID: <20240729181724.GQ989285@bill-the-cat>
References: <20240728202501.3204905-1-paulk@sys-base.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DfAVYoRtgpz8H3vN"
Content-Disposition: inline
In-Reply-To: <20240728202501.3204905-1-paulk@sys-base.io>
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


--DfAVYoRtgpz8H3vN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 10:24:49PM +0200, Paul Kocialkowski wrote:

> Here is a bunch of configuration cleanups for OMAP boards, mostly
> unifying and moving common configuration from board-specific defconfigs
> to Kconfig definitions.
>=20
> There's also a cleanup of the sniper (LG Optimus Black) defconfig,
> prior to migrating it to DM/DT in a future follow-up series.

Thanks! For the series:

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--DfAVYoRtgpz8H3vN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAman3LQACgkQFHw5/5Y0
tywmTAwAjPyLefC23wTF/j2tSwSQCMdCLCSC433D6iLunmjnYXvfcXQpzd+WemJd
Yb3Jrl68UCH83+k23xFwMSPkQY+YVlcdRqr5RVYnW3/RkGTsMcymTsAlFLhM6Ti8
RSGIa8s592eVQvwh9a3RfAh7EbTYy6x8zNQKpOVz/f/IaGaIkaUTFlOwVzIZzRn8
CYDGRBmJmx2+6yWQTZI6HbelFvYDhgHSxMsv8CtiNAvOghn2PeIp1sjzIhKeJbXl
kBlEyjSqhijVg4x0p5P1hNLUgiosK+npmdQeaFajesmxLuqirL8Ce6L8+TyPEZAn
3PL7Ci7AKnS3G5eSNJjoYPzjaR1Yxbdx/bnhDhEF3ooYibI9kTmk0fGQaxfLwl+9
wl+WDxZxEza2l62x5U3aRd8lG1hQLqdF4FIOKr7Zaasn46ngGQ8KRQt7UeRXUWBA
457oui/9Fo+aD9jIyBrqOLUKHl1zojGqK3X70srYCLzZTDU+ExKiBoj1Dgz8t68E
UzrbzFm1
=47Gv
-----END PGP SIGNATURE-----

--DfAVYoRtgpz8H3vN--
