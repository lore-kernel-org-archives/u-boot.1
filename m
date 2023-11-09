Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7A0C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 13:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0707A870F8;
	Thu,  9 Nov 2023 14:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lc/ItKeW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97309870F8; Thu,  9 Nov 2023 14:38:04 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF9C1871A2
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 14:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5ac376d311aso10170617b3.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 05:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699537080; x=1700141880; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+HMMuK8PlbeCO7XQlnzG0RcSmQv+XRJSwM7Xj0yU624=;
 b=Lc/ItKeWdqs1rhYiBuO8guCh2H8yKuLCdBAE6NauIBNA55r/4v2jOHNjZ1yFv3v8sd
 0uyvMkO8KrE7HKSHYnQr6caR57IYmhxfffeBngYbOXIctaHWmu9qr7EGK246VBRCvOKR
 UJF1X8W0EeZ5nIabbI1x7AkeyiUyHMJGy3bjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699537080; x=1700141880;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+HMMuK8PlbeCO7XQlnzG0RcSmQv+XRJSwM7Xj0yU624=;
 b=NoaXg28SvKU/tSUoeyz86qbaR8ebbL+nMrJEyjQ5ZSWB1IoRCgx91F3GudY9JL7pPk
 6sGEoqZPhaVWjatOdYWtIVEt++xMwApGW9W93U1jSuMKsUbDWuCBr7nRYOsoUHwE708u
 HYUub/ZfmHBjD51Masbshmtzn/QBaqCa/ZSzEjauuK/cpvD8Thvk3x/cy6bhjz0joN+4
 wCdzEiDxxhFwMxbx2H+/rfeZn/+HGi8Eqs6dKrgUhd1pV6VOivTMK6r8X6ThazDMEIiY
 ZhRdXuiMgnRAMGo3zLnyPsVDQ7VKQqbtcF35qJ9aQOwozKt7PdYP4AAJ+nHqNvw4Cm5X
 HX4Q==
X-Gm-Message-State: AOJu0YwItx7nReDyJRUAyf3O35D1tLwiSoW6h4ZK4o0RuPsAz/5zK2wJ
 XYazr5JhuF2PyoVZsRqAN2LAJA==
X-Google-Smtp-Source: AGHT+IG3rDVBCNr+rkcGH5E2V9LmF9I8h732vdqimjDFA+o4dabcQDHNgyUOE/gB3t6zuibPg34GHA==
X-Received: by 2002:a0d:f502:0:b0:5a7:ba54:af02 with SMTP id
 e2-20020a0df502000000b005a7ba54af02mr4492009ywf.38.1699537080512; 
 Thu, 09 Nov 2023 05:38:00 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 qh6-20020a0562144c0600b0066db331b4cdsm2069553qvb.86.2023.11.09.05.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 05:38:00 -0800 (PST)
Date: Thu, 9 Nov 2023 08:37:57 -0500
From: Tom Rini <trini@konsulko.com>
To: Francis Laniel <francis.laniel@amarulasolutions.com>
Cc: u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Tony Dinh <mibodhi@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ramon Fried <rfried.dev@gmail.com>,
 Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Michael Walle <michael@walle.cc>, John Keeping <john@metanate.com>
Subject: Re: [PATCH v11 23/24] DO NOT MERGE: only to make CI happy
Message-ID: <20231109133757.GD6601@bill-the-cat>
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
 <20231107214121.132079-24-francis.laniel@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rxb4r8zBxDKZr/YW"
Content-Disposition: inline
In-Reply-To: <20231107214121.132079-24-francis.laniel@amarulasolutions.com>
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


--Rxb4r8zBxDKZr/YW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 11:41:20PM +0200, Francis Laniel wrote:

> This commit set CONFIG_HUSH_PARSER_2021 as the default to trigger the CI =
with
> this parser.
>=20
> Nonetheless, the keymile (i.e. VENDOR_KM) board family is not compatible =
with
> new 2021 hush parser.
> Indeed, This boards used set_local_var() to store some variables as local=
 shell.
> They then used get_local_var() to retrieve the variables values.
> Sadly, this two functions do not exist with CONFIG_HUSH_PARSER_2021.
> A patch was proposed to use environment variables rather than local varia=
bles
> but it does not tackle the problem, so complementary work is needed to ma=
ke
> this boards use CONFIG_HUSH_PARSER_2021 [1].
>=20
> We also remove a #undef of CONFIG_FEATURE_SH_STANDALONE as it does not ex=
ist in
> U-Boot and causes troubles in the CI.
>=20
> We also set CONFIG_LTO for kirkwoord sheevaplug and phytec bk4r1, otherwi=
se it
> hits its board size limit.
>=20
> We also disable some check for pylint as it was not able to find future f=
or
> commit object.
>=20
> Acked-by: Tony Dinh <mibodhi@gmail.com>
> Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
> [1] https://marc.info/?l=3Du-boot&m=3D165541917618725&w=3D2
> ---
>  cmd/Kconfig                  | 3 ++-
>  common/cli_hush_upstream.c   | 1 -
>  configs/sheevaplug_defconfig | 1 +
>  tools/patman/series.py       | 4 ++++
>  4 files changed, 7 insertions(+), 2 deletions(-)

Of these, it seems like only the keymile portion is needed.  Please
split this patch in to two, which can then be merged, where the first
patch sets the default to the new hush and the second changes the defconfig=
s for:
pg_wcom_expu1 pg_wcom_expu1_update pg_wcom_seli8 pg_wcom_seli8_update socfp=
ga_secu1 kmcoge5ne kmeter1 kmopti2 kmsupx5 kmtepr2 tuge1 tuxx1 kmcent2
to use the old hush still, and cc's Holger as well as the marc.info link
(as a Link: tag please).

--=20
Tom

--Rxb4r8zBxDKZr/YW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVM4LUACgkQFHw5/5Y0
tyxfPwwAtxTZFuZ9lpZQ5fvTcURzpn3Iu8mB9jJFCDEYWZ6lIGKUzD9SJMwCDPFw
9mgKBQcCykGrS6EuBGDIFnB9Vm4efrmRCwqDj5o37sCsGuq2xyNwaRGiyQegqnnF
PJWUZ2V3yT4l+B91/0b/pUfJCN530QRRcaDNCX7wPMqtK3iqCflT2a/C4dsYW8EC
hGb7weM1SLBAgaRygvqYWq3aIxG7qA9Y6Rx1kEr3FvGNlgAyPDpP7YztSW8cRRpJ
K5mFfW+PEB8lT6iAGjSIMeOC6xST78Fs2Iv/X9bM1eALYl0O9CqUlmEu/fFc2Rhe
pTnICE0VQ16EMltqwhhVQ8pCHzxoXPYnV+RJZ3da0gHt5VI5lkcaCgrNi2/wClx6
OSQ7hZqDotmdAhUd/earBVRR4y6jNFZwQKBXv2Z/LbhiePAWfG+jaZhZoBRN3HxX
lSdcn1APs6tjiVvVD/VVJQh+iDuKldCQNvNf56ml6ndD+qSYdmuWES0JqGbq5wid
PpaXNiPn
=/fNy
-----END PGP SIGNATURE-----

--Rxb4r8zBxDKZr/YW--
