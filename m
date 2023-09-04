Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965F1C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 19:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE81386824;
	Mon,  4 Sep 2023 21:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xiicfyry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 837748609B; Mon,  4 Sep 2023 21:14:27 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF048846D2
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 21:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5925e580f12so17163847b3.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693854863; x=1694459663; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6quPEnEdNSsiPY8wwLIGSC9vG/O2HHVEjUXIEpNcDIA=;
 b=XiicfyryptZWXc4x5YO2QeziafjOTsNz1E1r7A1aeMfYZZISsJwplivg2VPe3IP7i7
 tD766DvQbdoC3NfUJS28s09sVIbm4BrXfkKjupZxU2BEmLD1stVWjnug+Oeis5CAsYuf
 TsSSddnHPprwzgGys1zJ/tTi3IaCr60g6dj0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693854863; x=1694459663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6quPEnEdNSsiPY8wwLIGSC9vG/O2HHVEjUXIEpNcDIA=;
 b=S9xkeRTJZH2IhYRWbOWOFmCRbV3DmIiqS5gcgC8UqY7HhEzl2nrjvHg+mEVL0R9MqK
 4W0J/WnhLuX2Gu2LVJD2HPC7LDaKQTfmUSOBsoQspmWZ4fkd35blgXUnCZd9lRHskicQ
 wK5KoC+CSfbC13pld6L9eHJZz7Dc4Hs7hCLms6XKW5NiIZNspryXl4H23Vb8rIiKZkYE
 6lcPhUa2sUV64bpA1cF7t3BxAEReTI/pVvoMFM6M/I9WaWsqH176/wlUMzWniA+yZPEn
 vDUEVdmf5igslIRkfGkLvKk3p/71Bh1WM1DCCcF1Wao1YJgcZXyZU98xxRG/tSpUC/+y
 oZow==
X-Gm-Message-State: AOJu0Yz+qaTb/N5zxsr53hqm0B98qKjBrl35PdR5ibx+p04IVNUsnpqU
 C8clgj40B5X7fW8UGldgp1GNJA==
X-Google-Smtp-Source: AGHT+IGGG0uuBAtdhoEEDDkfmtqJMlhvKH3gYfN8SYgJwB6AooJ+pjMX0EyfKNZCmnNLk3B+mecvSA==
X-Received: by 2002:a81:910f:0:b0:583:e1ac:ecc8 with SMTP id
 i15-20020a81910f000000b00583e1acecc8mr12677913ywg.43.1693854863375; 
 Mon, 04 Sep 2023 12:14:23 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-977e-7fa5-b64a-ed15.res6.spectrum.com.
 [2603:6081:7b00:6400:977e:7fa5:b64a:ed15])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a81710a000000b005845e6f9b50sm2781090ywc.113.2023.09.04.12.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 12:14:22 -0700 (PDT)
Date: Mon, 4 Sep 2023 15:14:20 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v3 04/20] video: Move the BMP options
Message-ID: <20230904191420.GF3101304@bill-the-cat>
References: <20230904144131.2699824-1-sjg@chromium.org>
 <20230904144131.2699824-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5YgmTFK0aAIhgLQm"
Content-Disposition: inline
In-Reply-To: <20230904144131.2699824-5-sjg@chromium.org>
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


--5YgmTFK0aAIhgLQm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2023 at 08:41:07AM -0600, Simon Glass wrote:

> These appear prominently in the main menu at present. Move them to the
> video Kconfig where they belong.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v2)
>=20
> Changes in v2:
> - Just move these options to driver/video for later consideration
>=20
>  common/Kconfig        | 11 -----------
>  drivers/video/Kconfig | 16 ++++++++++++++++
>  2 files changed, 16 insertions(+), 11 deletions(-)
>=20
You're still changing these from prompt's to selected only and that's
not how they're used today.

--=20
Tom

--5YgmTFK0aAIhgLQm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT2LIYACgkQFHw5/5Y0
tywtDAwAh6aKhnuupCjDhqJk7Fmsj8DW6eMMGw6lcWe78UC+ODXmPptg33gpnR3x
yWOsbIzC6YOkjPyxRrEb9Am3CvZDRJopWBMbALFww0oEUyWnoIgtfj8MWuxMjC+2
NjC1nrtPhtuixTLEhotiicragr3ztBTNUGoadxR4At9BNj2LwgOHTU1QSRmqAUfz
Oh55pw+2kW7DQL3lMiaZRSbkcCmcNDbCwofQbdEZjnkH/jUfUNNU/OnPCAy8e2x5
xiA5bAThjlEAmuw0TKee7YuGZ3aTm6rF0nQmXevRFAqDmnOgANV0EPsPdB6FqUMk
dmI876zI6P/eb96QnC3goACKq8ado/agZyh2LKfFkM74VidLUKBt4ss/1BiiUkHy
ZrmnC6M3am6HRYz0M6QzOyn4lCp8SuXcZP3cwZq84VIjGxvw+GLuXwUKYZpnwCbK
ZkRGbOjEtQTC27vJev2QOu8JdobbFLsL50+/tSOhhV8gVYbVbLXEnP0jhOrSHkHF
9Cs1nfc4
=EZwP
-----END PGP SIGNATURE-----

--5YgmTFK0aAIhgLQm--
