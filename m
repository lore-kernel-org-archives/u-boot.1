Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD91C71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 19:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6646B81E18;
	Mon, 16 Jun 2025 21:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FrIWBHDS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65EF882B18; Mon, 16 Jun 2025 21:16:39 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4679F81760
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 21:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c27166ab3so3597307a34.1
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 12:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750101396; x=1750706196; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8X7LKNYaFTeIGdV1lEeBCD2daEllvzjjfNWOrwb9JI4=;
 b=FrIWBHDSvmBe2yTYG7luuxQ+mqLT3lntSiEFpfEoCYHVKv755H8ncgxpZHjcaI30lk
 bgkR1TTC/Too56hi/VKz5IknZKiICci0J/k/PMaXn1PoZNG9itsBlrAL3Kzg2L5OODg1
 eZw53ChINwiq1qs0GmTBe1tQ94wSpzSrXKb5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750101396; x=1750706196;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8X7LKNYaFTeIGdV1lEeBCD2daEllvzjjfNWOrwb9JI4=;
 b=NCttB7VMXj7V1lNSmHxHUeQO42UTl3xFfiovse8ubfzCMMBSmlJzHlWhBGocYdisCN
 TFs9b2XV7nG77B/NmmLIt5PefdF3cnaYY8q0zhJG6MV2AxM/mV4/iTsROiBUsoqlpJTs
 8A7YXZJGx16LnhdJieCLhd8nMykEK5eO+hVVAlEXAIPn+bpKCZLZPP3kV4/k1HbQ9Qw+
 X37KX6N43BDt7fVQqXuEXAnh0sNbeZbIxun6vOHRd6HYKqOfMpGdcRoGLuhP915t2o5i
 UDg68uTNMiLRtFsBAXPZpyJkb9mF0LMiUFbji3YcKq2QXqH3gxRmiHLAmzRh5YE1+4+G
 oVVQ==
X-Gm-Message-State: AOJu0YzOOmuJrySMxyNKHKuHlOP7A0qMHt2kqCFGR1yYhmAuG/PNtk6b
 oQ3iNCoRDm9dyznRMIhKeKw691cqB8fed7SSHe1rLeLyApCi6dx3wqAlzufNI0U+5ls=
X-Gm-Gg: ASbGncvmjbzy01FJvd1+0bLp0wTVj7AJhUIanttAa5HzWwg+n67l0aGcExEn6aA9H0I
 Q+I5xAwnsS0CDhJWUxleQXBkuPdByQfNMgkwP4ZiXvvCA/UWYo35Jpk60eQSNyITsckYtm6Iyto
 tFhwIvJnhofD2msiZprTKN2r9O/UZp62OLIpfsLQ5WWrqy9m5jlOg08pr+o3gOvIAducIQcM3yf
 1BE26RluGm0htaBcnz8LhLELL4z2iroTSXc05+LOzZXuuMajYPgMFf+kuR6ua3e4EQCOyG9TCam
 DWXx4Q5tdLUO904LhFyAeH4+5jrrBga1ej/ImaJnrpR4kv0PF0kzmCyJuXaYH6lJyFc1Cm6QKxo
 E+tswWNF3JieVAgK1vY/FbXo=
X-Google-Smtp-Source: AGHT+IG5ZAuDRdOp0TTvBwx2LylTBIm1UvkcuR6gFB3GYTCtAgIC7sFl06odI/jPTAFcV0rolXix8g==
X-Received: by 2002:a05:6830:6683:b0:727:439c:d18b with SMTP id
 46e09a7af769-73a36382361mr7903683a34.15.1750101395982; 
 Mon, 16 Jun 2025 12:16:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eab88ae983sm1972670fac.2.2025.06.16.12.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 12:16:34 -0700 (PDT)
Date: Mon, 16 Jun 2025 13:16:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] test/py: Re-add setuptools to requirements.txt
Message-ID: <20250616191632.GJ1382132@bill-the-cat>
References: <20250616185353.1733300-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RShUkIgpzE5xAW7U"
Content-Disposition: inline
In-Reply-To: <20250616185353.1733300-1-javierm@redhat.com>
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


--RShUkIgpzE5xAW7U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 08:53:32PM +0200, Javier Martinez Canillas wrote:

> The commit 859621b47f9e ("python: Recreate test/py and tools/buildman
> requirements.txt files") recreated the python requirements but dropped
> the setuptools module that is used by the test harness.
>=20
> This leads to the following error when trying to run a test:
>=20
>     pytest --build --bd sandbox test/py/tests/test_net.py
>     +make O=3D/home/javier/devel/u-boot/build-sandbox -s sandbox_defconfig
>     +make O=3D/home/javier/devel/u-boot/build-sandbox -s -j8
>     Traceback (most recent call last):
>       File "/home/javier/devel/u-boot/build-sandbox/../scripts/dtc/pylibf=
dt/setup.py", line 23, in <module>
>         from setuptools import setup, Extension
>     ModuleNotFoundError: No module named 'setuptools'
>     make[3]: *** [../scripts/dtc/pylibfdt/Makefile:33: rebuild] Error 1
>     make[2]: *** [../scripts/Makefile.build:398: scripts/dtc/pylibfdt] Er=
ror 2
>     make[1]: *** [/home/javier/devel/u-boot/Makefile:2079: scripts_dtc] E=
rror 2
>     make: *** [Makefile:177: sub-make] Error 2
>     Exit code: 2
>=20
> Fixes: 859621b47f9e ("python: Recreate test/py and tools/buildman require=
ments.txt files")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

It's not pytest that requires setup tools, it's pylibfdt. You're not
able to build sandbox, is the problem. And that's a documented
requirement for building U-Boot in general for a number of platforms.
This doesn't belong in test/py/requirements.txt which is why the "make a
requirements.txt" tooling drops it.

--=20
Tom

--RShUkIgpzE5xAW7U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhQbY0ACgkQFHw5/5Y0
tyyjJAv/Wo7L7Z80S0LUDDbxNqeF3Kkz2FmIU5HMQ5V0N2qw19XRSN1sBRN/sJL4
DTVbayzPr7jt4c/okf6s8WQgqgt8rD7bWD9Jt/TgCMo4aV2giTFGqZ65c4STXjKU
QatMA2ko1r3U24gvDPeeU4xyBoKwokouQeZaifWcQySRABlFXq9M6D2LzkkpTCUS
NgnOA0IHd6ZLeA5Qzeeo0HYKk4a3sIdC0BxneiE5o/k1bdw8bAAJBlm0C503eeXn
WqBXoT66bKbSIgsSw5mGW3TFr+CDj9jwHVrZcsEquwaVqdzvRvxTXD7xHkD9nvsr
AsRzhykf8G1bZlf5iRAhhpiUzYzOEfgtj+JhtznKClAUWaJZa1AnxeFUDySMZC/d
xeVBMJ7w5bLr9mCUDJ+Fm6ZzdOj3oDrrifTVP4MLW88ukeDbEvwnr8UtXwsrkpTq
TqqVhS9W/3Xy48ctQKNfF9bqxKKBxMUcOwwg02CnaMkPtewyUxCfpb/XUAOSevma
IyHXHpxW
=hSq5
-----END PGP SIGNATURE-----

--RShUkIgpzE5xAW7U--
