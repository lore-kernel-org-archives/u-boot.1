Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD38CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 12:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2225186F4F;
	Wed, 18 Oct 2023 14:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sm1Dl5+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF81386F80; Wed, 18 Oct 2023 14:30:54 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D74680EEB
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 14:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a86b6391e9so42986147b3.0
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697632250; x=1698237050; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Tlsdb2qkn9Xa9TjnS9jWKlZkuGu3rSxQQQ3YjYKMRnY=;
 b=sm1Dl5+pSzuaiPTM2mQnNL4FzNzpW6qZ/ChVAZMfH/RkvEn4VFeWlllIejjqkCC1fG
 Mo3Qpa5QSNCQPRE/Y3A8s21OxGxK6E8W9uUFpgRQQG99loL7ovbAXjZUr+BSGPRmqq/A
 PyYVDm8mApkh/h58RfemE+sSwB6CF520uJ0rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697632250; x=1698237050;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tlsdb2qkn9Xa9TjnS9jWKlZkuGu3rSxQQQ3YjYKMRnY=;
 b=scpBTDo4LTm2TUfQ56Jbug0p+AsDGdaauusL406x14km04wvpgf4RgX9dThOja0fZJ
 lFU6fdlSRjpo6KQdbyKPbhwhwIH4j0w2n3shS8hStBrN8RyeYXwtBkfjyrDmCdpTUSdD
 3rZC/osMH50M0k/IHZ5zwnZ2U2QKEPDD0fpXlc1ZDsXCsNAZH53DwNQ5DNsvMkgFaULe
 qgEPCk0Qu1ohnq4C7pa+deRVI6YPEvOHMwYqIZTTE7q/t+C3FLmTs184Bwy5mRis2x3N
 EEJmfeMAz16LMJgob24a0TJD4JSTMGaNpA3BmT1/mplan0Osd+ZT7HOb+GrsjxZzOacE
 WWsg==
X-Gm-Message-State: AOJu0Yz9BySJuSGwtceDkhINGgWLSdAqaHbj/8jaR58rED1G36vdKqMk
 Uaycdwmk9hVReUq2FkGKWhZDqA==
X-Google-Smtp-Source: AGHT+IEPQD9qErAqJDvjvl0gFXI4unjwM4yXgT5KvU7xiKasIhTxy06If2t4e8eOs/2ZW9CXf5m/pw==
X-Received: by 2002:a81:4803:0:b0:5a7:c97e:39e3 with SMTP id
 v3-20020a814803000000b005a7c97e39e3mr5170880ywa.15.1697632250000; 
 Wed, 18 Oct 2023 05:30:50 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 s128-20020a817786000000b00585f60e970esm1451444ywc.134.2023.10.18.05.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 05:30:49 -0700 (PDT)
Date: Wed, 18 Oct 2023 08:30:46 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, uboot-imx@nxp.com,
 Anatolij Gustschin <agust@denx.de>, Fabio Estevam <festevam@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Heiko Schocher <hs@denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nitin Garg <nitin.garg@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Roger Quadros <rogerq@kernel.org>, Stefano Babic <sbabic@denx.de>,
 Vignesh R <vigneshr@ti.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v2 00/29] test: spl: Test some load methods
Message-ID: <20231018123046.GA3660774@bill-the-cat>
References: <20231014204805.439009-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PR/DCJmpAlgViKgb"
Content-Disposition: inline
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
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


--PR/DCJmpAlgViKgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 14, 2023 at 04:47:36PM -0400, Sean Anderson wrote:

> This series adds some tests for various SPL load methods, with the intent=
 of
> helping debug v6 of [1]. With that in mind, notable omissions include NAN=
D and
> ROMAPI, which both lack sandbox implementations, and OS_BOOT, which I have
> deferred due to its complexity. Semihosting is also omitted, but I think =
we can
> test that with qemu.
>=20
> In order to test all of these methods, we must first generate suitable im=
ages,
> possibly on filesystems. While other tests have historically generated th=
ese
> images using external tools (e.g. mkimage, mkfs, etc.), I have chosen to
> generate them on the fly. This is for a few reasons:
>=20
> - By removing external dependencies on pytest to create certain files, th=
e tests
>   become self-contained. This makes them easier to iterate on and debug.
> - By generating tests at runtime, we can dynamically vary the content. Th=
is
>   helps detect test failures, as even if tests are loaded to the same loc=
ation,
>   the expected content will be different.
> - We are not testing the image parsers themselves (e.g. spl_load_simple_f=
it or
>   fs_read) but rather the load methods (e.g. spl_mmc_load_image). It is
>   unnecessary to exercise full functionality or generate 100% correct ima=
ges.
> - By reducing functionality to only what is necessary, the complexity of =
various
>   formats can often be greatly reduced.
>=20
> This series depends on [2-3], which are small fixes identified through th=
is
> patch set. The organization of patches in this series is as follows:
>=20
> - General fixes for bugs which are unlikely to be triggered outside of th=
is
>   series
> - Changes to IMX8 container images to facilitate testing
> - General prep. work, particularly regarding linker issues
> - The tests themselves
>=20
> Passing CI at [4].
>=20
> [1] https://lore.kernel.org/all/20230731224304.111081-1-sean.anderson@sec=
o.com/
> [2] https://lore.kernel.org/all/20230930204246.515254-1-seanga2@gmail.com/
> [3] https://lore.kernel.org/all/20231008014748.1987840-1-seanga2@gmail.co=
m/
> [4] https://source.denx.de/u-boot/custodians/u-boot-clk/-/pipelines/18128

For the series, applied to u-boot/master, thanks!

--=20
Tom

--PR/DCJmpAlgViKgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUvz/AACgkQFHw5/5Y0
tyw12Av/d0SXxlgsV1DrrHvAF9peSrXvFycBt2G6YtZraeRY8id+VXDzXDdXGFtT
EN87jNoe3Aqi3NCEG6/sBR2O/K7Z7+4xJlvzPl8kGfitHNzi0qr0LT6A6IcBDSqX
SQ0nsYYhm/aLwg33jSx2kMIS1ciZqsow8yXL8Nzr9FbvOdxqH7RHNT7cxHw6G7uh
hUZ3O9YoA7ltikzXjixL6cls7xUqSX0bwZICkdbACGZXZuy+r2pyr+u6K7JCfgSo
xa8ajLBZWUb+sa9Y7k3/P6n3Iy1uwHQw5K4OiRGlMRONhDp6d3eyk9HbEWJCekyC
a7Pw2JLLppGQ2sqzEoXEBE+o4YYuTJxppexczKHdLCu5qs15yYGsj9wq65Pt7Y2h
3x19GPhfsfl3/a0qaEeHXXf8H+PNmKy/v2QqIcjZHgZWGm7nbPIN+PYZvzk2mJL7
LQ4g8DOZYCFuco6RqCclmGiTCF5GHNFmIIxxHvvB2DjEmqvDZGqrOP3E9O6WfUbL
C/l2QzCg
=x5wz
-----END PGP SIGNATURE-----

--PR/DCJmpAlgViKgb--
