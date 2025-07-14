Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0ACBC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 19:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0813782BA7;
	Mon, 14 Jul 2025 21:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TvMNfa6+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 292C382E52; Mon, 14 Jul 2025 21:47:22 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D31CC805D7
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 21:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2eff5d1c7efso2984001fac.2
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 12:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752522438; x=1753127238; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JQrSf8OOkPjhPhJzFt8Ms7MsL+piCYO5KqR1/U7dRJI=;
 b=TvMNfa6+wiwExOUyMK54dHEekARsH6fVFbB28bF0MTFwNIjY6EfgbYe13cq6sN8/c+
 puNbA1Swbqre8jMSj1UHZJbXSDe60q5kaJoCOUIC/rj4CxshRMe+Lq4uH2ZVFfnNQIjh
 rNGagW1aoKwtbDrfteQRwn/Y7nZYxwnrEZuGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752522438; x=1753127238;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQrSf8OOkPjhPhJzFt8Ms7MsL+piCYO5KqR1/U7dRJI=;
 b=IRwON8an9g1Ot4WpMJj2XyXJ0uu/56Dfqlo854XP+t4bUlGz7HdljV8AkFizr4iaNG
 d/5lglrDRcLv3U4I/jnjUakU564n3sWEFj9TZnVV9ebPwQbRQ/VD5X4rmob5Obkmw9+8
 JACUJz9zXCQ098EsLNh/4PDxvtVoQnFJDcCxB9MyhNxEI+Xh3IRJVVHyQhIpS5NYRfpt
 KatGmhM7LJlNL5zypnYFAB1X3QIPtFI7v8tjCCAjKZ9+AizC2FK1ih6G9flx2WdWD2xa
 kRkWqXcehnDFzsYobidy6fKnp1eaOk4aX9fXTHyyvcVtY2KpOM/k+LlR02mdMrbCa2xU
 1CDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCNIQfA0XKbZudu7RHBpgvH6uH8pmLLnttvRO/8Ch38frY8pSjfeGASmwzy8xvmqb9fPfIbXw=@lists.denx.de
X-Gm-Message-State: AOJu0YyaFk5qD3SisHLLw/m/mtb9EzRXDKuvvXJkAjlJJjCuO4Ztfnmo
 vR0PUwSuRUfonKzd+M+JA2BIQmrofQdD5Y7qiBiD/KtemSl9DO/KajzTxcvhAZvz+DU=
X-Gm-Gg: ASbGncsXrpqrX6OdMtsOoKziAo1ELlpoEf7C8zInaEcvQ7EX1Ag2KMxmC/n9NidmkZK
 feqEbCyBT6oSGql4U92UXM5ywgc9m+EXc/xn3yTdZ+LWpRpLWKuajCbTCcEDbNpTyWsoufXXoNe
 AJZdwXMnFsbYzvQ8x6dkwvy/1ZrwxyzHNszShjOsvPdDZsnD/fafFs4POf70tD7oBrs8aXLaYLQ
 mXtcoL5XqJaQGIA8s/vl9vr2G3yyq8wX12W8wrCond1UEaRy6UwVmDs2cdYG22GEMkqe1XYC72A
 s6sp64raOsDpmoZbeMQdjkYNaXfv0Z1rFAhJLa0tdvXmQF0MO0jtrmNk0sTdR8QWPBie6mUqhKY
 6cBehoBNFtMojkFuPOF3tELJ9J7mjUmR7lC8+bS/FlbFfl98/CENFxqZS
X-Google-Smtp-Source: AGHT+IGYD9/RtbD6wrWcSlfKCIKUyC+snyhZWjDrZY5lMBpQ5NGMUJX5tzOJMed9QCZLCwMIjxf27g==
X-Received: by 2002:a05:6870:8927:b0:2bc:918c:ee04 with SMTP id
 586e51a60fabf-2ff26eece88mr10364291fac.14.1752522438341; 
 Mon, 14 Jul 2025 12:47:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff11686f20sm2014339fac.24.2025.07.14.12.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 12:47:17 -0700 (PDT)
Date: Mon, 14 Jul 2025 13:47:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Greg Malysa <malysagreg@gmail.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] block: Remove unreachable code
Message-ID: <20250714194715.GA193579@bill-the-cat>
References: <20250714-blk-uclass-v1-1-d21428c5f762@linaro.org>
 <20250714162951.GI13084@bill-the-cat>
 <04953cfc-0475-4560-bd7c-fee27739e351@linaro.org>
 <CABdDSeVtccemn8PTgs-f+QzZqJDZ_R=GRmrK2wquasCYDwWYPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jpL7oee5nbjrLc0N"
Content-Disposition: inline
In-Reply-To: <CABdDSeVtccemn8PTgs-f+QzZqJDZ_R=GRmrK2wquasCYDwWYPQ@mail.gmail.com>
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


--jpL7oee5nbjrLc0N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 03:13:26PM -0400, Greg Malysa wrote:
> Hi Tom, Andrew,
>=20
> On Mon, Jul 14, 2025 at 1:12=E2=80=AFPM Andrew Goodbody
> <andrew.goodbody@linaro.org> wrote:
> >
> > On 14/07/2025 17:29, Tom Rini wrote:
> > > On Mon, Jul 14, 2025 at 04:38:53PM +0100, Andrew Goodbody wrote:
> > >> The two functions blk_find_first and blk_find_next use a for loop wi=
th
> > >> the content being a 'return 0' which means that the 'increment' code=
 is
> > >> unreachable so remove it and also remove the variable ret which is
> > >> assigned to but its value is never used.
> > >>
> > >> This issue found by Smatch.
> > >>
> > >> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > >> ---
> > >>   drivers/block/blk-uclass.c | 14 ++++----------
> > >>   1 file changed, 4 insertions(+), 10 deletions(-)
> > >>
> > >> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> > >> index f3ac8db9464..b38c21ffbe2 100644
> > >> --- a/drivers/block/blk-uclass.c
> > >> +++ b/drivers/block/blk-uclass.c
> > >> @@ -613,11 +613,8 @@ static int blk_flags_check(struct udevice *dev,=
 enum blk_flag_t req_flags)
> > >>
> > >>   int blk_find_first(enum blk_flag_t flags, struct udevice **devp)
> > >>   {
> > >> -    int ret;
> > >> -
> > >> -    for (ret =3D uclass_find_first_device(UCLASS_BLK, devp);
> > >> -         *devp && !blk_flags_check(*devp, flags);
> > >> -         ret =3D uclass_find_next_device(devp))
> > >> +    for (uclass_find_first_device(UCLASS_BLK, devp);
> > >> +         *devp && !blk_flags_check(*devp, flags);)
> > >>              return 0;
> > >>
> > >>      return -ENODEV;
> > >> @@ -625,11 +622,8 @@ int blk_find_first(enum blk_flag_t flags, struc=
t udevice **devp)
> > >>
> > >>   int blk_find_next(enum blk_flag_t flags, struct udevice **devp)
> > >>   {
> > >> -    int ret;
> > >> -
> > >> -    for (ret =3D uclass_find_next_device(devp);
> > >> -         *devp && !blk_flags_check(*devp, flags);
> > >> -         ret =3D uclass_find_next_device(devp))
> > >> +    for (uclass_find_next_device(devp);
> > >> +         *devp && !blk_flags_check(*devp, flags);)
> > >>              return 0;
> > >>
> > >>      return -ENODEV;
> > >
> > > Should we clean up uclass_find_next_device(...) to not return int? The
> > > function comments don't quite make sense (include/dm/uclass-internal.=
h)
> > > and it always returns 0.
> >
> > OK, that should not be too bad.
> >
> > Andrew
>=20
> To me it looks like this function doesn't do what is advertised in
> include/blk.h in either case (find the first block device with
> matching flags by checking each one until one matches or we run out),
> instead it seems to test the first block device for the flags
> requested and either returns -ENODEV or 0. Out of curiosity, i looked
> for uses of blk_find_first and blk_find_next, and (except for
> test/dm/blk.c where all the functions are used) they're only used by
> the blk_foreach macro (include/blk.h again), which is only used in
> blk_foreach_probe, which is only used in blk_count_devices, which is
> used nowhere. Instead users use blk_first_device_err which is a
> completely separate path (drivers/block/blk-uclass.c:638).
>=20
> I was hoping the test code could clarify a bit and it might. In test/dm/b=
lk.c:
>=20
> dm_test_blk_flags first looks for devices with either flag (BLKF_BOTH)
> so the flag check never fails, then it looks for BLKF_FIXED ,which it
> indicates must fail because before probing all devices are removable,
> then it looks for BLKF_REMOVABLE, which is set for the first device
> before probing (even though it will become BLKF_FIXED later). So none
> of these are (I think) testing for the situation where the first
> device is missing a flag, but the second device has it and
> blk_find_first should return the second device. Then in
> dm_test_blk_iter, blk_count_devices is used with varying flag
> combinations and is expected to give the correct answer, which
> suggests that the code does actually work, assuming the test case runs
> and succeeds.
>=20
> I've been looking for something to poke around in and if you're ok
> with it I'd be interested in exploring this further to figure out
> whether the function does what it is intended to or if there's an
> opportunity to improve the test coverage.

If you would like to dig in here further that would be much appreciated,
thanks!

--=20
Tom

--jpL7oee5nbjrLc0N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh1Xr8ACgkQFHw5/5Y0
tyxLGgwArF8gxQfMygIgsVv9iSN0GuyEXaickQGIE3pebkwvogmaNWkQH9KhDcWF
SgECKbQyDYQLSVX/NO1uTBXI0J4pdDBX4i4rN0Ebu8NcWcpnIhRcfj/p67LWKjLg
LQxNuk2Aeamyjg1h4mC5KIqBew3nO6KYQJi3wBfAVotAFT2Ro03k7EKlIsl3/GNZ
lrOTcHxIxO0OdX7Y9tqUX7oZUILseRRZ5obs6bOBFuJo3ZPoRVjLjZtkrwIIxCQR
QxiIgceVS8YZd6TYdBxeA+R54x/o/v0pYjZPcfemIaXUiTFBTVlngUxiMF71TQcL
58NgvqZYd4ThK9iYilIcpiYQGGOjO6ioPt0oB7qTfDm0ZHqrdhCWbe8beKigWsB6
q9/HnnN9IjUZOGth9S9PrVH92UA+i40dXrK6LdtQNq9+BVk4tAj0y4gG1gJivtVj
PTYWAhOt1rlbnqkmShXIsOPYxawDiu3TQOJ+Uv5txBIbX+kJdLZxA5j/VdhnnnCc
WodAd5CK
=5x1v
-----END PGP SIGNATURE-----

--jpL7oee5nbjrLc0N--
