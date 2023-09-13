Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF26EEE020F
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 22:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2FE086D43;
	Thu, 14 Sep 2023 00:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bmjq7d6q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3414986E1A; Thu, 14 Sep 2023 00:04:15 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 136CA86A27
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 00:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58fae4a5285so3618427b3.0
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 15:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694642651; x=1695247451; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A0xAY2DEteM1673yFH3PwsHj6ojl4YMddbrhbU08CeQ=;
 b=Bmjq7d6qWnC3lxHkc/F//K+oVV7/bCVbMzbe5C+smazRHdXb+4Ra/xt1emSbKZ7sYR
 XptInsTopI09x1NyQxvA2ouMc9JT4W95oBdemN7MI9Oa7KxT8ry9AJIEPhwkpBJ6JQe9
 bR/8j5VgoWoKEuBLk6ifER8YCtNWIJf1ewHOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694642651; x=1695247451;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A0xAY2DEteM1673yFH3PwsHj6ojl4YMddbrhbU08CeQ=;
 b=ma5etkBk4oJ3WBAm2bsXRM/JXkp7vhXknSq+VxlRKzSdOxvMPCydxyYskCSmjqYhWg
 OQlFRxe+NLsakzf39czy1kf6vGcDh1LtOoGoX6WXkml0BQIL2MAtXJOO8nS9WDXNj1Hb
 YQrto4XUdIg3QpSZI/FGX3GJzAhjJF5ZzVTiIkCfaKwTd36IuAvWZvgzi0JR1NaxrZv6
 GuUsg4sY2ldwTrB3q5ac5m1hbSWjXSW7KO3jhw+NTUU5bP3j1bKQvYzkdX/XIlj3V4rf
 iNv2ZileI30X84sl5xDDhviSLmCFA9KzR9w7AreYGSbmnGuGSyNY2VLxnoibL93SclVX
 5/Bg==
X-Gm-Message-State: AOJu0Yw/DyamEyu77pALG8Oy8DfhTaDx7jzlRSO3CCY1HasQsQSaHd2Q
 TUW6UOyLHQFURHOgmGBhixfeMQ==
X-Google-Smtp-Source: AGHT+IHXv9uY3QG6kzcyAe46InRPAkLNlUsX+9KOpSKCJZ+vVS3VSneLrqQL+F6yXA5uXHwTyZeP7w==
X-Received: by 2002:a0d:d247:0:b0:59b:2be2:3560 with SMTP id
 u68-20020a0dd247000000b0059b2be23560mr3511981ywd.48.1694642651632; 
 Wed, 13 Sep 2023 15:04:11 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d1a3-6cda-a8be-914f.res6.spectrum.com.
 [2603:6081:7b00:6400:d1a3:6cda:a8be:914f])
 by smtp.gmail.com with ESMTPSA id
 d194-20020a814fcb000000b0058fb9863fe7sm3392ywb.103.2023.09.13.15.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 15:04:11 -0700 (PDT)
Date: Wed, 13 Sep 2023 18:04:09 -0400
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/6] phy: Set phy->dev to NULL when
 generic_phy_get_by_name() fails
Message-ID: <20230913220409.GU305624@bill-the-cat>
References: <20230831221629.1027552-1-jonas@kwiboo.se>
 <20230831221629.1027552-2-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lLlcXw/BItkkDuFC"
Content-Disposition: inline
In-Reply-To: <20230831221629.1027552-2-jonas@kwiboo.se>
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


--lLlcXw/BItkkDuFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 10:16:33PM +0000, Jonas Karlman wrote:

> generic_phy_get_by_name() does not initialize phy->dev to NULL before
> returning when dev_read_stringlist_search() fails. This can lead to an
> uninitialized or reused struct phy erroneously be report as valid by
> generic_phy_valid().
>=20
> Fix this issue by initializing phy->dev to NULL, also extend the
> dm_test_phy_base test with calls to generic_phy_valid().
>=20
> Fixes: b9688df3cbf4 ("drivers: phy: Set phy->dev to NULL when generic_phy=
_get_by_index() fails")
> Fixes: 868d58f69c7c ("usb: dwc3: Fix non-usb3 configurations")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--lLlcXw/BItkkDuFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUCMdkACgkQFHw5/5Y0
tyzlzwv+L2S4bhneoZBOVUAul0OH8juEyBugYwZ5CGMpzCV3kxPWDpqY99LXWLD2
hn7frjxwJbXT9N8tFF2oUy8lgBAf6v8m3mn3aXd+sowBHR3Y1TTC9jPgJf5UzYS6
uFr4ul7deDEEA70/6mBzCLQMRc9raxLURu476aaLXQaobznm//YBuJ3W4CcE80FC
s0L+HhDxPVI9pr3ivMMYz7eNNE2RcwwY8bFbUi8amsD+VGhLFIdJQ1a6x8Si3TUD
hsmUpIeJwO9cfFpUUAtJKBQHrMhuZiLb5T4l/bMPzjGmn3e5yHWbkVAfNvKtQniK
76wTeRdDQhewnuHeSOlPoLUEzehvj3KWsNsXthuLahAk0iLh84RZdIN9DxdQDNTA
d+Ct6pIJ3HwPS528F6ST+akc+R1HbAkOfaI4We7CJVZ3mNu1tl6vZlOcyRkd+mEE
rsutFBYjh8FwMUOp10Bb/6Uf4WVtxT3r+sfpIqGZtd0DGa90iv7cViFJOMfjROp7
pV5oBuzP
=w0Da
-----END PGP SIGNATURE-----

--lLlcXw/BItkkDuFC--
