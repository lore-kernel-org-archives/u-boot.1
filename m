Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A285C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 20:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25412889A1;
	Wed, 24 Jul 2024 22:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P71o+UVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C6038899B; Wed, 24 Jul 2024 22:54:26 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E71ED8899A
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 22:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5d4071e9b93so181716eaf.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 13:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721854462; x=1722459262; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3HhrqOpO3b6atPooBv4OizUMVPdFSvrmtc3At4rxTSE=;
 b=P71o+UVuB/Ksz6EsLlbqNJkJiJh4iL9kjhT9pIIh4v3e6ieigaZHEqpIMkeAgOPBKe
 T4Z154XUrjHfOlb+xRvl6h9T79EEz+c5HcA4tVw4Ce6U48r409mcoZJOaJnjOaA1q+pF
 PMdTOypoHXc3Cqbgh65gwDMDDPaGLpk1t2jZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721854462; x=1722459262;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HhrqOpO3b6atPooBv4OizUMVPdFSvrmtc3At4rxTSE=;
 b=Pyc/ZzPu/wFZkEcEVTtXv8SnmCOrtfFsz/Jkes2XklAuc+U7U2yXHEyfHViqMIGO2B
 xdr3nNRsP8x7XG51ymJ8sJz2AVuYRY5I5AqBt7my2NdYpFu8SvLsQwNQLLiHAD69zkJw
 bKbwcSCZH7gkqQTdkWrBZ4lpafSV8yWdci/S/dVh4uwi86Cz+PFM7Flg+EN4qHf1eNp1
 jjQXfwM74EDHJb7DqqSvGv3vMjy/0uyKbgsN1b4W9YJU8Tf6J7Lx0mA43Qg9WUbw0JO3
 JVo9ttf0Zq+5j8297CqEj6zMLrSsY59rOAp0Slr4NEj54s81RX4q266k1GLZXICYLTbf
 D+Ng==
X-Gm-Message-State: AOJu0YznRcfRi5pgfAAvm0/xgyi5yQKuS3+xWQ0ocW9Mo7pRP7wcWCU6
 HGy+XWhdLeuiBm7M0P/meXFoFBwdYIxha1aurPLz1jUCGS/5L6gUqQucfzXZnFM=
X-Google-Smtp-Source: AGHT+IGFhO8JEUHpFSo66WrSPAze9sWlcXxQA+JPvl8shLOw/kT/Um7tFeuJ8Z3aw9JNyQTWfrnIgw==
X-Received: by 2002:a05:6820:1b09:b0:5c4:7b18:b8eb with SMTP id
 006d021491bc7-5d5ad9c892dmr1487235eaf.2.1721854462631; 
 Wed, 24 Jul 2024 13:54:22 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d5b3591726sm2734eaf.15.2024.07.24.13.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 13:54:22 -0700 (PDT)
Date: Wed, 24 Jul 2024 14:54:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 04/40] lib: Convert str_to_list() to use alist
Message-ID: <20240724205418.GM989285@bill-the-cat>
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-5-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9bJIRkQVPdiIVjnz"
Content-Disposition: inline
In-Reply-To: <20240724060224.3071065-5-sughosh.ganu@linaro.org>
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


--9bJIRkQVPdiIVjnz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 11:31:48AM +0530, Sughosh Ganu wrote:

> From: Simon Glass <sjg@chromium.org>
>=20
> Use this new data structure in the utility function.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  lib/strto.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)

This is rather big growth when we didn't already have realloc:
05: lib: Convert str_to_list() to use alist
   aarch64: (for 1/1 boards) all +1765.0 rodata +37.0 text +1728.0
            xilinx_versal_mini_emmc0: all +1765 rodata +37 text +1728
               u-boot: add: 7/0, grow: 1/0 bytes: 1728/0 (1728)
                 function                                   old     new   d=
elta
                 realloc                                      -    1120   +=
1120
                 alist_ensure_ptr                             -     140    =
+140
                 alist_expand_to                              -     136    =
+136
                 alist_init                                   -     108    =
+108
                 alist_uninit_move_ptr                        -      76    =
 +76
                 alist_add_ptr                                -      72    =
 +72
                 alist_uninit                                 -      48    =
 +48
                 str_to_list                                204     232    =
 +28

--=20
Tom

--9bJIRkQVPdiIVjnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmahafcACgkQFHw5/5Y0
tyyDLAv9Hy3h8lZKhPkYzAhXhXhy8MzvCHyP5nJTLr5gFj4mNhKNkmn2L7oRPesY
2HpBz1q47M3RrC3lDhMqxcrLIbP2cH0nPH6J+kzL/J2e2IdXq19sur7x6p+D1IhG
Gvm71hvg6rjSgIhxOFgKrQjnzijAM2nKPKu5gAXy7Njn36W/myjAeoH7ZbAsgjqo
urflFIZpyLncodACKxXPgYZNlX4EfI1p0icKm48pnYczuHeaWVsVHmwLLe2FoWSf
kBfrsR0ZMdmXhj7YBqIJMxr5H0Og3GQayIxmITVK+OIX/JMqIKvAnpqSbivOkLYx
yyNcpbDufAiWjZmWQSBLlZanLfNZq+w1gz6mkpT0rLQEckPSY1KqEqGumi3WV4bk
4mSwlL2MYRCmRDlRTZhrAIveWFrnD0aufIiORUcgvKnIDbQCaH94P4XbGuIUGiTS
bKibPDvntOeKiYxyLdI6fUlc9IKE8tW95VLPSrGywJM3nXOD3mLbZZwNxGabq61P
u6W3VyKe
=Na2Q
-----END PGP SIGNATURE-----

--9bJIRkQVPdiIVjnz--
