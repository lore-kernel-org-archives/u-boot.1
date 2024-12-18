Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C651BE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 14:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51A5180241;
	Wed, 18 Dec 2024 15:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KEzSJr6R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02DC480269; Wed, 18 Dec 2024 15:34:48 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5CC68022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 15:34:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-467a37a2a53so59650301cf.2
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 06:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734532485; x=1735137285; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JRHA2Buu/o0ZOZPnNaAXyspE1BseehRM6CmdlUasXys=;
 b=KEzSJr6RykZRqlutkf9K7Gh5AbNuxwP/fmSmfgkSknKjrA81N3zseVtaMotgbjQvtw
 klCzS6T4Sm6+mtcnf+CzwAlziVsAeFqNM00xocC97cAjcHNvlGEjMf6fw41UfEybpbQL
 7ma8PNnjticMhmNzedCoM8rDynrycUSopOFXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734532485; x=1735137285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRHA2Buu/o0ZOZPnNaAXyspE1BseehRM6CmdlUasXys=;
 b=StPw5FM+bAi5gjvQyjk4KyOsol6w86Mr54xpqXFN2PcFA5CQbzKkrwWP1V1ueJG1TC
 mqFZnh7XFTYKXVV2T940YGQU6nrQ1f+n2F3Xj5LEAfLrczfJXMy+jnL1vqV6d/NTObt9
 95qS6y0iDp0lxf/gEmLtuXWhu39XrVNW9fHreag5x9EwBtKi0ISuXC6yKfVXsbtV+zvc
 L/jMGr616IZCtsMLIYxurClZuHDYiSybo7/lHz1IK7m315ygHMfifgguH0q7JWzKVX/O
 QSYXNxWEdoBpDvXWmpHCYQvT5uv0hIooCX466Q+09u23XlupkmVU6DuxPKFCX1QJRZ+4
 MsYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHMbLl7PPdESmkBidYIGfJ43JG0OYbFHh9EmZ5DTF469HWZCOoEQO4qJOHJfVYXhoWchGo83Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6JVO4T8lZXzNGYBKcFjatKF825cHzc2JSv8/2ZdeJr+1O8/9y
 YRifsvCsfpx1eHjgbXLLN6rFkcS8aWH2zxDWOjejpLBOH+0bKsGOA6a9xuoXQ8k=
X-Gm-Gg: ASbGncvN95erfAdhkUFg2SKv3lro4lg7yeLxK9i3wVZh7kB1jiWYfmF+3O2qTNOxka8
 CUKtKeg7SbOogLfS+9LR0rTw9yYXnW3xsl1gxH7WrkaGDb6RFZiUBeuOCf7aC43dzpICGvoQqYz
 tApHvDSqm3b4tRtpG4A0oNgDEQSu2GEcRCX14ZlsAW99FtG5WrAF5nNrSFlDGfn1qLukq3u7w7t
 eaugBXEKIgIpWAY8RaZKKisHB0TEcQ73ZNTJFyhaQP0UODuG7TLT/xx
X-Google-Smtp-Source: AGHT+IHVggjweKbya32p4m9q4cURDR1Ra5Oab4jZxjhSNAMZBoO56f6qPF2TRRYHJKhm49QMqyFI6w==
X-Received: by 2002:ac8:7f41:0:b0:467:6b59:423 with SMTP id
 d75a77b69052e-46908ed2625mr53988721cf.55.1734532484765; 
 Wed, 18 Dec 2024 06:34:44 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2cbb473sm51255761cf.36.2024.12.18.06.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 06:34:44 -0800 (PST)
Date: Wed, 18 Dec 2024 08:34:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Vitor Soares <vitor.soares@toradex.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] imx: Fix usable memory ranges for imx8m SOCs
Message-ID: <20241218143440.GA1505244@bill-the-cat>
References: <20241218090007.692815-1-ilias.apalodimas@linaro.org>
 <93a5b107-63c7-4d44-a0f4-f4079935f8e8@kontron.de>
 <CAC_iWjJxi9mkaAbR6DFHCZ13FNSnkWKSkFLZa_PLpvDOuZq9bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="16bJE93upKUNLezD"
Content-Disposition: inline
In-Reply-To: <CAC_iWjJxi9mkaAbR6DFHCZ13FNSnkWKSkFLZa_PLpvDOuZq9bw@mail.gmail.com>
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


--16bJE93upKUNLezD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 11:24:45AM +0200, Ilias Apalodimas wrote:
> Thanks Frieder
>=20
> On Wed, 18 Dec 2024 at 11:17, Frieder Schrempf
> <frieder.schrempf@kontron.de> wrote:
> >
> > On 18.12.24 10:00 AM, Ilias Apalodimas wrote:
> > > commit e27bddff4b97 ("imx8m: Restrict usable memory to space below 4G=
 boundary")
> > > tried to adjust the usable memory limits on a 4GB boundary.
> >
> > I would be nice to also mention 74f88b72219e ("ARM: imx: imx8m: Fix
> > board_get_usable_ram_top()") which actually introduces the value of
> > 0xFFFF_FFFF. I guess it would even qualify for another Fixes tag.
>=20
> Ah thanks, Tom can you amend it or want me to send a v2?

patchwork / b4 will pickup a Fixes tag, but if you want to
further-reword things instead do a v2 please.

--=20
Tom

--16bJE93upKUNLezD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdi3YAACgkQFHw5/5Y0
tyxg8Qv+L1WpKD6MJ2HTvSQlKF8PWbox5NkXPSmZOktrdkSkD+RGgDTmBobLioeK
vtKZs6zIWh3f7e456Cruo0tlwd0Xx0Z2dWu6XqPcSjEI8fMBWXHXn5uDj/ss3nNq
hu9EvZfmPbvEvw82StkSDDgU8w+w9VUi8ls/8Ldruln1HZO1BfJI/B4sn1WrbJwb
XBnVh41ucSuJWRVPMAunCFCUUkJsZybr5N+vyJqGhWHP4ai8CAZxJkgSKXPSDlP8
hi/fRu1CtspjztLYX692z6wT59bL5PiyXV1Mgkega9CBG6dTegeQt27v4d7LFjrv
z6Q1kyIg0MmymHlwtNpm32T5ow9CZanN2MVK132RthM4kBMjZEtuI/9ngW7lPUoK
1z8CSemKZ+zyV9hjYeEhziBofLF5NZCEUkObCa0xneiCoKpJqTMUSm9Z9ubA5j1d
EJmGNNwkRb4Yt4AvXWHg8w0evkzlxQJZ3RwmR5dukUX48/MLwMnYPSJzlq6/ZH2Q
el+PJuhG
=FFci
-----END PGP SIGNATURE-----

--16bJE93upKUNLezD--
