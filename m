Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDABC71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 14:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07240864ED;
	Tue, 29 Aug 2023 16:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IpfMT+6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A254864F1; Tue, 29 Aug 2023 16:09:10 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 746C8864E8
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 16:09:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-579de633419so50926097b3.3
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 07:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693318146; x=1693922946;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yc91yZ76hR6IY1oFVDAc7iKOgdxJunSaF50fq5YzuXQ=;
 b=IpfMT+6xkUTNLGR5U5x+HU/OOfl7Sp0K4dIIwMrbd+iiA2Lup2WKxlvUJvTKmwVkDS
 Cwc4kox3CsBA2oUBQj97w0zi5gd21vg6X5IMfaskpudmT6FzKUuQxse/d67c3x4xpp+V
 TFeRh/sjkL18DuzmAeBYiQD9v0DF5mJWTjvgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693318146; x=1693922946;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yc91yZ76hR6IY1oFVDAc7iKOgdxJunSaF50fq5YzuXQ=;
 b=b6XzBbDaEqa2YnwJFKhDjW6kfKpnE9NSE/xMoIk3ENif2JyGATwB8YGidScL/U6+Nf
 JxNEnoSKE+A5Htekq8oXTP7q1wV2c1ksei7gdZp7NsPmXz8rsdarPeaMYJRvp2BTDN/U
 4HOZlpCsJjPDaSOKah7Ata6IBkYT5RjWf/uB+8Ep6r3CO9L6CRzlHFslLhG0GQm/RJui
 fsgfUWlzqKSN5UYSDTIdMC/ui3gmgMf0A5BBjCUtrFj/jabTSb3Zy+0HqX5cH/uTsTrf
 hpffmAVwFhC5zlnTOjVOFmDTD/+57bCmYZoL/kJrGU2w95y2WwBynCpy2mfNpcs7m6TN
 0dtg==
X-Gm-Message-State: AOJu0Yxb+QdjYdfCMEQGY3/Z6lsTm5wV2SzvGScJ5uWwZBBglBLav1Eb
 +xl7srT39PWRegrtynFUNDq7mg==
X-Google-Smtp-Source: AGHT+IE1kgB6kQ39UIe1NXdgF3flZ7P/+X/cr0VnSCihGckPe9I6tgQnMyva8WTvKFKQodtmlVvCrQ==
X-Received: by 2002:a81:5245:0:b0:583:d9de:8509 with SMTP id
 g66-20020a815245000000b00583d9de8509mr27449402ywb.27.1693318146086; 
 Tue, 29 Aug 2023 07:09:06 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4165-1a0d-2d73-76fa.res6.spectrum.com.
 [2603:6081:7b00:6400:4165:1a0d:2d73:76fa])
 by smtp.gmail.com with ESMTPSA id
 h84-20020a816c57000000b00583d1fa1fccsm2783743ywc.0.2023.08.29.07.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 07:09:05 -0700 (PDT)
Date: Tue, 29 Aug 2023 10:09:03 -0400
From: Tom Rini <trini@konsulko.com>
To: Frank Wunderlich <linux@fw-web.de>
Cc: u-boot@lists.denx.de, Frank Wunderlich <frank-w@public-files.de>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH] arm: dts: mediatek: convert gmac link mode to 2500base-x
 for r3
Message-ID: <20230829140903.GR3953269@bill-the-cat>
References: <20230803165258.14744-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="maO/dJRHpfKAuwJF"
Content-Disposition: inline
In-Reply-To: <20230803165258.14744-1-linux@fw-web.de>
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


--maO/dJRHpfKAuwJF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 06:52:58PM +0200, Frank Wunderlich wrote:

> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> Ethernet on Bananapi-r3 is broken after
>=20
> commit bd70f3cea353 ("net: mediatek: add support for SGMII 1Gbps auto-neg=
otiation mode")
>=20
> because changes from this commit were not applied to bpi-r3 devicetree to=
o:
>=20
> commit aef54ea16cac ("arm: dts: medaitek: convert gmac link mode to 2500b=
ase-x")
>=20
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Weijie Gao <weijie.gao@mediatek.com>

Applied to u-boot/master, thanks!

--=20
Tom

--maO/dJRHpfKAuwJF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTt+/wACgkQFHw5/5Y0
tyxUXAwAgc25Vj7Zgi0IdfxVvyQe9eVlogcTNyXC9mwo7JsvRigvYOlHQ7vu0A54
JhKZkDLHqGD8YiUtUthzo34r4/aOsExrLCoSAFy5zrOJs1jJQctlfPEaeTGyDVHd
Z1cROZ8a545c5yfhif4kvGawqc6N9mH9Zr8Dexlx4+hxjQQItRDfMCpNn+62zfAS
uVPlybLpERYVJBd3LBia9J/J7eWy6/ESnWcQvHbmSeSzYnFpj53e66nzwESnAbei
3O0XRBgeyoqfXqTtAyXXRRVWht+gYwL7F1rdFZIFNfZYMhA6cynGwHLmuUr45Ip3
zzW/wLxS92ohNe8kSM0LVuwam0ZnDf+mx6f5IpUNyznJ8JOUxzRzDvJTTwxPUr1X
u5Az1yv9MV+2EtsaEulYug53fpkPZ5GHiH51nXAVJKnA3zK/ku6PJMdcKo/AFmbn
cVgIvg2VQK1B4jfdSMLnXKoDqwqOTSq1iN//2VU/skUKlBkAQGUih/bxniazmxtH
uz07FvQM
=AcWq
-----END PGP SIGNATURE-----

--maO/dJRHpfKAuwJF--
