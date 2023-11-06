Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741C4C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C69A2870B8;
	Mon,  6 Nov 2023 17:33:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="thgpaNHS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7720F870BA; Mon,  6 Nov 2023 17:33:00 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 567DC87087
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-41cbf31da84so29900261cf.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288377; x=1699893177; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MIieZ2+gyJGaKPXS8y54j7xLJa+zrL9gyD4XjzYX8Co=;
 b=thgpaNHSs+8q/c6fo+JYuidALs9JF+lGsMQl0giBZ5+sTkJ0gwSnws+H06u7zqA576
 GH94H6oyBmEQu1e8YJqSGD321EmyAoLvWCiUYnTU3bJXcnk88KmDOBfkdv0FCEthnyWe
 w3LcktdCoWdSrA57Esvwf4/QdMtOhqy7rxAxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288377; x=1699893177;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MIieZ2+gyJGaKPXS8y54j7xLJa+zrL9gyD4XjzYX8Co=;
 b=GcNIQb973jswQ9IUxyBS7Wyx/ieXfH/biI5gbj+v2NxjmTvP0XJIesZhJJ+IaqcmG2
 0RKKGpskEroKHARsIyjbyRsuDP5gD8g/TwsfFG9IQbXm6Tr2Qk9S0uox0Hi/3PPlcXez
 XIEicbb0rMz8DJR7MHIntQZEyulxxJ+hytHYLNtmjL601i7i7rTtiL6ktdA1fl2Kd0Iv
 V2sIptV4FP7cFozPnmjw2PEHBHe6/Lv7E7JsdJ2sq4F3c3i6iivBpd020sIaKmVHz0+S
 OWyHtoNmoU76gZe63cm4cmWvLk0NfnRNKa7AXlqI40Av31Eh8pDIescBSfH1vRKaiEwp
 tpjQ==
X-Gm-Message-State: AOJu0Yx9jX1BqlB5lsNgtuGyPYGqfduLsgNB+wjaHtu53iSa7beVTviK
 +YGBplId3YFY3HRB5c5ON0bymzokGu43rZ3CzzcGRg==
X-Google-Smtp-Source: AGHT+IHiNHHfXvrV3F+jmkiDsc9QSSKvwSzaJ/LohuV+ai/wGJpOjHVv3v2QhllFgMte3Ib+9++zbw==
X-Received: by 2002:a05:622a:15ce:b0:41c:b787:7bb with SMTP id
 d14-20020a05622a15ce00b0041cb78707bbmr37889296qty.21.1699288377205; 
 Mon, 06 Nov 2023 08:32:57 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 l5-20020ac87245000000b0041b3a1462fbsm3537189qtp.37.2023.11.06.08.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:32:56 -0800 (PST)
Date: Mon, 6 Nov 2023 11:32:54 -0500
From: Tom Rini <trini@konsulko.com>
To: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de,
 Ley Foon Tan <lftan.linux@gmail.com>
Subject: Re: [PATCH] net: dw_eth_qos: Add 64-bit addressing
Message-ID: <20231106163254.GO496310@bill-the-cat>
References: <20221209063314.597218-1-leyfoon.tan@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cXg37MBRe2rljn6O"
Content-Disposition: inline
In-Reply-To: <20221209063314.597218-1-leyfoon.tan@starfivetech.com>
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


--cXg37MBRe2rljn6O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2022 at 02:33:14PM +0800, Ley Foon Tan wrote:

> Set upper 32bit address for DMA descriptors and buffer address to support
> 64-bit addressing.
>=20
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

Applied to u-boot/master, thanks!

--=20
Tom

--cXg37MBRe2rljn6O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFTYACgkQFHw5/5Y0
tyw9oAwAjbhSySEGj/MRg8glyBLWM2HZKvwe65csA1IlgVoDzsu64Zkc/bB6GsLC
mwK0F+emG4FsKPiIor1sy51gEjysMR3oL1ivfLZJnc/lKa4e+06m6KU4FxGtohZs
WnU+vGtrr15Wh6CudywyNVXLys2oY/1Utc5SqgLrFm+ixJW0KYwwHOlro2cWvGLA
5FzSdU6+jO+g78L6zLCP0xdnjcAb+sbd6DoqbFjnisfjc3PvZ8Fj3OdQN1IR+iM7
7bGqtz7QWFdnQc6O0YX53QXG5/RD+Zvsfcb233LCVphpfPClwxHgeFb5juABla8j
fWS7aubxpsU4FM/WQgU36HazQeXQebRShJCxLHqtgDHMWFIMUHHdSXHRFCbtPE5x
ha6gWkn8ULJcUdy0xdlVA5Mv2ftQt+N6WlHEiMN8y6veBD9dAOc5VHJKUZ+8u/oa
TDa3HBeRTp6WiLtWJfW0bzbZ+ft9NexXWjmpNBVyHSizhO5H8EO0QW9KsYdGyXJg
V2pioRtM
=X6Km
-----END PGP SIGNATURE-----

--cXg37MBRe2rljn6O--
