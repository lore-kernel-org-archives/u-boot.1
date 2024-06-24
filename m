Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0DCC2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 18:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37C5587572;
	Mon, 24 Jun 2024 20:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I+oFFy0N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBADA882CE; Mon, 24 Jun 2024 20:06:04 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F0048751B
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 20:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6fa11ac8695so2765871a34.3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719252361; x=1719857161; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=paB+sljHV/FIknzwEgu+epZh9FkkrJTL7ef1B6OkOgw=;
 b=I+oFFy0NSqkDfv9b3JZwLKnhNJhPtCdLnN0cq4QQ8TV4kD/nw6SVhEzxwAWb5p9CMD
 GF4Z8GKVv0gZgUrAspiwDWoCHm6YbTg5sm/AcpATSVvmCdVr5LbQAgOT7YA7gmaydgtR
 S0Aowhc/db7D/pilzdVerQae8dXbEM+zygxwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719252361; x=1719857161;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=paB+sljHV/FIknzwEgu+epZh9FkkrJTL7ef1B6OkOgw=;
 b=fr3D7AYCD+aYSn8A//3UPlIIdWwjuZlb1DN+yBRpzHgmzrjJ3JL4mkDn4ejmagn7pJ
 LgBNrZ8rTr6soQ6FXrxFEoYOVWW1cUi5dkHkhLuNDN9GhOfKiDhNb3K9Z+g393e5ojP4
 E3pcEE75ya6KCDs0fO0YiTe6tjnnFUTiWfITUVuaQN3zJZ1nhEVzPUL8PxjyCvyZZ8Dz
 ALHH+UhTER0cVuhy4DDVfgfETAQabdI1VJ8muoil9JkRLiAoxEEndmiwKukUJahIaZB5
 s2hi/u6ZZLmuKJoBD4pK8ENhRsK3om3topbYANeGFmp1RDAginh3x3fGrAWWovWDYalP
 r/yA==
X-Gm-Message-State: AOJu0YxQ39D+q0jK9sypVKT9oz6naaypRrsrsA6q6iGdyrx/BgHm6/uR
 5NuYhUhN7rZ2DOyFZ2eHX1ocTmc/hfKOlH+ck6iY+ER89NwCUjHViD34/JmITyU=
X-Google-Smtp-Source: AGHT+IGRhuNi3JZW2sMRC7DWyO2Ex4beWBQXSEtPcZUQfdZURkW38DFrvF80e+HIPIA778wgNrlsyg==
X-Received: by 2002:a05:6808:120d:b0:3d5:47bc:14db with SMTP id
 5614622812f47-3d547bc1742mr4867909b6e.22.1719252359819; 
 Mon, 24 Jun 2024 11:05:59 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d5344fa318sm1564832b6e.15.2024.06.24.11.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 11:05:59 -0700 (PDT)
Date: Mon, 24 Jun 2024 12:05:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v3 06/19] test: Avoid failing skipped tests
Message-ID: <20240624180556.GG38804@bill-the-cat>
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="naa5xj4m8zYzXe6X"
Content-Disposition: inline
In-Reply-To: <20240623203213.1571666-7-sjg@chromium.org>
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


--naa5xj4m8zYzXe6X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 02:32:00PM -0600, Simon Glass wrote:

> When a test returns -EAGAIN this should not be considered a failure.
> Fix what seems to be a problem case, where the pytests see a failure
> when a test has merely been skipped.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  test/test-main.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/test/test-main.c b/test/test-main.c
> index 3fa6f6e32ec..cda1a186390 100644
> --- a/test/test-main.c
> +++ b/test/test-main.c
> @@ -448,7 +448,7 @@ static int ut_run_test(struct unit_test_state *uts, s=
truct unit_test *test,
>  static int ut_run_test_live_flat(struct unit_test_state *uts,
>  				 struct unit_test *test)
>  {
> -	int runs;
> +	int runs, ret;
> =20
>  	if ((test->flags & UT_TESTF_OTHER_FDT) && !IS_ENABLED(CONFIG_SANDBOX))
>  		return skip_test(uts);
> @@ -458,8 +458,11 @@ static int ut_run_test_live_flat(struct unit_test_st=
ate *uts,
>  	if (CONFIG_IS_ENABLED(OF_LIVE)) {
>  		if (!(test->flags & UT_TESTF_FLAT_TREE)) {
>  			uts->of_live =3D true;
> -			ut_assertok(ut_run_test(uts, test, test->name));
> -			runs++;
> +			ret =3D ut_run_test(uts, test, test->name);
> +			if (ret !=3D -EAGAIN) {
> +				ut_assertok(ret);
> +				runs++;
> +			}
>  		}
>  	}
> =20
> @@ -483,8 +486,11 @@ static int ut_run_test_live_flat(struct unit_test_st=
ate *uts,
>  	    (!runs || ut_test_run_on_flattree(test)) &&
>  	    !(gd->flags & GD_FLG_FDT_CHANGED)) {
>  		uts->of_live =3D false;
> -		ut_assertok(ut_run_test(uts, test, test->name));
> -		runs++;
> +		ret =3D ut_run_test(uts, test, test->name);
> +		if (ret !=3D -EAGAIN) {
> +			ut_assertok(ret);
> +			runs++;
> +		}
>  	}
> =20
>  	return 0;

How did you trigger this case exactly?

--=20
Tom

--naa5xj4m8zYzXe6X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ5tYQACgkQFHw5/5Y0
tyzuJQv/R//5MBBfEv66nVTyu+/kS9w6sDh0Top180Ne8wmdG/tMBfSYl1YuANz/
YF0q6i5fDf7CFLLbGfHmXjLitO72Fyp1A1KYcTGqCrJOjvMWYAsr7HOnNXobjS+t
ZHzgE7B47Jxk1JAIGnwZP9dDQpwRmpOlYQOd6cO/eaFbXNhxiOoRRSBh7mZmk93F
qaacpw7mBbUwIAhAXAeRuWRmTRciSYvJFgResY+SQlKID98j6WYdZZa0tHQSQtcH
O/N5KdJNaCTfgw/3KFPFKVpq/NDUXwN4J7EbNge2U8k0i8HhPSDM1eTbIkx4mnVw
0hMBUrtsrWgqMsSu4Gs3VhWOOny8rKPqKHn6xbvYhXKOnvkBRSLgpmCT6mObbh7u
pi4GV2C7yXpr7vniVNBMajwPU2ORsu3Y4ZDpjXXcGjXOpOKLbQcFSdW3Z3wG43WY
XF0/LY1ysGiJ1RvPIo32abkDKGCk7Qw3FyuGVIu6ArP6xuqj+xe6RheDv9WOIiy+
qnZNR1wo
=VQWi
-----END PGP SIGNATURE-----

--naa5xj4m8zYzXe6X--
