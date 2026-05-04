Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E30CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 224648467F;
	Mon,  4 May 2026 20:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dXHXtwBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0158E84683; Mon,  4 May 2026 20:05:42 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C0D18467A
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 20:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-40974bf7781so3834507fac.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 11:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777917938; x=1778522738; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ED+rR1r3FC3v2iolNo8dyaCHa0/+Sf7C/WsisLiJnAQ=;
 b=dXHXtwBTowYxL3GtDbaegu8LAsXy8i96FcieYc4cRpgqpJXKRSPaOCHzq7QtOcip9I
 tjxkFuo/ZWBkbiJ6wQtiSTKJs8O9ED76Gg5ZA6GXGnY6G/Yp6Y7Iwz/d7s50siqU3WfW
 4KM3Fk2cc+ReAX7sCrg7E14r7OUrqy9aNDlwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777917938; x=1778522738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ED+rR1r3FC3v2iolNo8dyaCHa0/+Sf7C/WsisLiJnAQ=;
 b=Xow5yv/73DnVv8hfFsA7dVNDyhprFMVzdLQRNAJdavCubAgu77mQjGlC9UoT7V7Ho/
 U/1UOg1bbJ8OSS4SwYe6/nbdLiWZhDbmjmwS5gcWfqJbdE5zrXSxgsLji8+2HW7IbTs0
 YP/Xnw5uIGh2o3JgDx0CWovzBB42yV5zI4DZ8BVXF6thKiVo2Bep5yl3Vm14u0dwq/XF
 r/5BksRmksGDl7Jqr4z+Ox9qYhbkA12Vc48vv+5gzZCGGto7RAWVYjm0zFc4Or24I7UI
 UxM/CmtZ5TfoKslyV5HN96vYamgR8itb4+FEgDDFodZQj7IyyNmmyujfTyYv/zbl30DD
 Opuw==
X-Gm-Message-State: AOJu0Yw8EuxvK7wncdRzY9WObomOcNMSqN6m8u0wmZ7ZHAVxin6wLBL1
 7dPnsJL+Sl4TV68GZuN7WTxTKOxuW9U+5+ykWWNcMvwr5jmzO8Sp1HbBHCfteldTB34=
X-Gm-Gg: AeBDieuJN+8vk6DZ8A7N8hTkKNbYLrhtKYBdpwiwq7xwMn9b1XTf8oyGgJeAPj0zdvx
 oIUz9Z0Dv8+Ld+RTEn9QNdUI+O0QTQ+m/2YMXI5GQbgpVFlFdkUzVTJ+XrNMn48887dsRuMsHRi
 cLkgLSRbcY4D//i3zhiYFKIzIkO/H4NEIUM1sMLP5V5oSKEfzUjJEY25rIr5BhpAlFuIOwaB7eX
 2U7CYBfjstMHXm3/SWSuCYs3FcWGrjHjHb9gB9YW+KecCbULqo0XctCtwuzAZ5tM+kzGf7++LHL
 aMep0gr1VGmOg7uZZOQxOR9ZWcy/8tlvKjihCFGTUTDjbhZiBB3mZ1OfoayyK7y/J6/KIy8wxCS
 NbQwBQQlSIeAyWBcNGlmd9GPBPdCK5GZDciXO60UfAFmL680mQOAtksMp4p5qi4hJGRGU2xA9B6
 PRI1wNJ8HBe/+fdloOb0ie1nCJFwqoN4YLvx2a4/7f22qPsaeme0lUaYkb8jCRTfOocmpNLZC5q
 AA0sNTeraFlHRKcKqYiRzPQd4vY09oTmBgxuFcTPLIrRkMvbgRx1yINRwy1WUaKs2L7DiKM
X-Received: by 2002:a4a:df17:0:b0:694:91f7:3fe0 with SMTP id
 006d021491bc7-69887829ad2mr270619eaf.15.1777917937877; 
 Mon, 04 May 2026 11:05:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-434549540b2sm11519996fac.6.2026.05.04.11.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 11:05:37 -0700 (PDT)
Date: Mon, 4 May 2026 12:05:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <simon.glass@canonical.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH RFC next 02/18] CI: pass clang HOSTCC and CC to pytest
Message-ID: <20260504180534.GK1614990@bill-the-cat>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-2-b19301d1948a@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fT9pFh7jijp0J4e9"
Content-Disposition: inline
In-Reply-To: <20260504-extrawarn-sync-v1-2-b19301d1948a@cherry.de>
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


--fT9pFh7jijp0J4e9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2026 at 03:20:29PM +0200, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> test_env_initial_env_file test calls make on the build directory passed
> with --build-dir parameter which points at UBOOT_TRAVIS_BUILD_DIR which
> is populated with buildman before pytest is run. For "sandbox with clang
> test.py" and "sandbox64 with clang test.py" jobs, buildman uses clang-20
> toolchain, but pytest isn't configured to use that as well, resulting in
> gcc being used with a configuration made with clang-20 toolchain.
>=20
> Specify the HOSTCC and CC clang make arguments so pytest uses the proper
> toolchain, this will be required in a few commits when we'll upgrade to
> a newer version of scripts/Makefile.extrawarn which gets rid of checking
> whether a clang flag exists (because it's supported by the min clang
> version the kernel advertises as being supported) which will be an issue
> since GCC for sure doesn't support all clang flags.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  .gitlab-ci.yml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 245e422d72f..d0ebd9f123b 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -288,6 +288,7 @@ sandbox with clang test.py:
>      - ${HOST}
>    variables:
>      TEST_PY_BD: "sandbox"
> +    TEST_PY_EXTRA: "--make-args HOSTCC=3Dclang-20 --make-args CC=3Dclang=
-20"

Is ""--make-args 'HOSTCC=3Dclang-20 CC=3Dclang-20'" not parsed correctly ?

--=20
Tom

--fT9pFh7jijp0J4e9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafjf7gAKCRAr4qD1Cr/k
Cl4qAP4kRC5pXOHdubzw7zhc1d6nX9c1woLXbIIBl8rWs992WAD6Al5kVSxtswjG
IkAi+HBeBrxNKajehNV32mMlHndpYww=
=pwLe
-----END PGP SIGNATURE-----

--fT9pFh7jijp0J4e9--
