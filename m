Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E97CD54BF
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 19:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 929D186A88;
	Mon, 25 Sep 2023 21:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k7QGu+tp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FB6186BF7; Mon, 25 Sep 2023 21:56:12 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EB2386A88
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 21:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d81b42a3108so8283858276.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 12:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695671769; x=1696276569; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Tub3pxbxRuFAyaygIzqbW7xC8AYWBvBTJgN3Kew3O34=;
 b=k7QGu+tpMRLnqa9vLHNsH+jXhahl/bbxItUMqTKFC7naezTXso4Pk2LbVBnBrE+wJH
 NQkPPULdlscJVNhNo7a+JpMS3z2OrIbJIroqiGBl3IKTYjwgufR4lXU+0or0QEje1x2/
 R1lqYNXeMhcOE7aAyPs2oSY6VW+suUe1/IBho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695671769; x=1696276569;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tub3pxbxRuFAyaygIzqbW7xC8AYWBvBTJgN3Kew3O34=;
 b=dgbM5rHlCFS/OKhJGLRCSmcnr9jWYou/IuroqA/s91n3Ld6SWrw7+AHW6Ilxwy24VN
 vgjFYYKU/pZMMh4987Exq5xWhYCA2aPaOFrZN9FOHSAPOUaqBSzX5pKa2nOMDJGtP0aV
 vHGD6N/YogcWzqAxNbtClkyUYTerHzO2zFHYEn155BHIpOhb+YB7k5qiN6xoZNDhTMQi
 6YM5Q5hqXN3J+QSq+bqEMEd1U8X48vt/z2NneWwfSUxi96rOXoRWbG8RfbFJVaxhoNjN
 NaeGohK2DpPPw2kWbITc7c5ifuJGHHZ6imETuU/rLxurwWJm12MlxY6axfo38bj1uY7f
 ZHJQ==
X-Gm-Message-State: AOJu0Yx0oMe53gw+p1Brdhg1rfYEWISRdeCB99BsSzrcfsx1RcYZG6Qo
 uFPGn1zgpCTG5d7pDDnDwzeW2g==
X-Google-Smtp-Source: AGHT+IH3tdeGVUXJ+V5rPJ1B3lMzXeXSnTKdqdAF1VNDWjCN7gGJoVmAK0I5ITCYdgeIlOfo2WM/RA==
X-Received: by 2002:a25:828f:0:b0:d3f:208:b8ea with SMTP id
 r15-20020a25828f000000b00d3f0208b8eamr6641371ybk.11.1695671769025; 
 Mon, 25 Sep 2023 12:56:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a05690202d100b00d815cb9accbsm2266917ybh.32.2023.09.25.12.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 12:56:08 -0700 (PDT)
Date: Mon, 25 Sep 2023 15:56:06 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Bin Meng <bmeng@tinylab.org>, Nikhil M Jain <n-jain1@ti.com>
Subject: Re: [PATCH v3 16/38] spl: Remove #ifdefs with BOOTSTAGE
Message-ID: <20230925195606.GO305624@bill-the-cat>
References: <20230924192536.1812799-1-sjg@chromium.org>
 <20230924192536.1812799-17-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jl1zdZ2kGdxdJPvY"
Content-Disposition: inline
In-Reply-To: <20230924192536.1812799-17-sjg@chromium.org>
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


--jl1zdZ2kGdxdJPvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 01:25:01PM -0600, Simon Glass wrote:

> This feature has some helpers in its header file so that its functions
> resolve to nothing when the feature is disabled. Add a few more and use
> these to simplify the code.
>=20
> With this there are no more #ifdefs in board_init_r()
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  common/spl/spl.c    | 15 +++------------
>  include/bootstage.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 12 deletions(-)

This isn't equivalent:
   aarch64: (for 1/1 boards) spl/u-boot-spl:all +722.0 spl/u-boot-spl:rodat=
a +14.0 spl/u-boot-spl:text +708.0
            lion-rk3368    : spl/u-boot-spl:all +722 spl/u-boot-spl:rodata =
+14 spl/u-boot-spl:text +708
               spl-u-boot-spl: add: 3/0, grow: 2/0 bytes: 708/0 (708)
                 function                                   old     new   d=
elta
                 bootstage_unstash                            -     308    =
+308
                 bootstage_stash                              -     284    =
+284
                 static.get_record_name                       -      92    =
 +92
                 spl_common_init                            124     136    =
 +12
                 board_init_r                               424     436    =
 +12

Perhaps because this (and another platform) are ones that set:
$ grep BOOTSTAGE .config
CONFIG_BOOTSTAGE_STASH_ADDR=3D0x0
CONFIG_BOOTSTAGE=3Dy
CONFIG_SPL_BOOTSTAGE=3Dy
# CONFIG_TPL_BOOTSTAGE is not set
CONFIG_BOOTSTAGE_REPORT=3Dy
CONFIG_BOOTSTAGE_RECORD_COUNT=3D30
CONFIG_SPL_BOOTSTAGE_RECORD_COUNT=3D5
CONFIG_BOOTSTAGE_FDT=3Dy
# CONFIG_BOOTSTAGE_STASH is not set
CONFIG_BOOTSTAGE_STASH_SIZE=3D0x1000
CONFIG_CMD_BOOTSTAGE=3Dy

--=20
Tom

--jl1zdZ2kGdxdJPvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUR5dYACgkQFHw5/5Y0
tyx00gv/YxAyTSig+EdAraqvVK8a9Nuyj9/XZMr/etupujPZVagLvXu08uuzslgN
JGZNQOAwmO7IJVhMi8Yt/ChGto2YlWRPWgy7RbSkCq+l0BrDUWL2UgLZMtYArsBE
wPKl5BL48ERs/oJnEL4GU6mivBt/g3vGlAeD7hYHl/ultYWqDH/PMLKgjyQrbeyG
9cBdSQRMhvCXUH4Nr5GS54eHgP8jzc73/o2nDL9XL7ZesSuPa1qNvZJ7Bso5e0IM
b33Uxa/J/CuKA32cfXV5FInoAzC1BudBaHgfLKroa2s+38XWilc3BIyCUdUSlLqo
FzXO8e4yKz8jgu+m+Lb/yvg50vAtWtZMFzxbhpl7357/FOE8BspoG3OmXbSKU7Gw
vmDTZx35oU7PpKM8QjKbcXtDzRe7hm3lXD79QaPDzjujtuMtehHJpzYwScgh3ouQ
E77ryc9yWvzahWzb+wv3HvO1QP6NqLvCg1F9k34l8uQpS6yZG7w83WiZyYrwcRid
47AZ4KM8
=0UjP
-----END PGP SIGNATURE-----

--jl1zdZ2kGdxdJPvY--
