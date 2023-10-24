Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EF6C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 19:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F38B87987;
	Tue, 24 Oct 2023 21:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kcko4qHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F314487990; Tue, 24 Oct 2023 21:25:35 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB885874BA
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 21:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a84204e7aeso47261017b3.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 12:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698175532; x=1698780332; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xeV1P/JBaF/T3NhGbifJwcjggzcP2zrVzpM4AGoXTlU=;
 b=kcko4qHhInTVwC9QFwPUacqsZ0epzvFyEThRv5h2pC5pxkiKZxLCVkU2IgUkSLQghW
 rj4Hw15jJ8nPTslVVueVCfIfKMZFA6kB/L1mrxEn6RDJ9p6gy9WY6TgsvySz+aMouUIp
 3XuxwV270s53TsMukFvBK8wqJdas5G5VRsDHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698175532; x=1698780332;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xeV1P/JBaF/T3NhGbifJwcjggzcP2zrVzpM4AGoXTlU=;
 b=SVmDMDJ8FuUFssXMEH5VIaNPpmb9DyiddPypSmtZfcdlfud1wZlWyO1Ty6GZYoWQsR
 nyP6pNmpf/nEGYK8aSVkCuT+Eq7cOn9qMH2BB+D+M2LYtXaYYP/6u/UbIorWfRxi+bEp
 oBwSEhy/U6CGyfumdwrImj2aSFvZuulMtso5RoIVVFJiHwMiW3uFwh4uVCJic2PnrOZv
 Lw/6KZwmwgT9bfVUtRca8Z5/iV1cNXhcBp05vf1fj4v7MEOuWhvI9pfp6B4PqvD/qXaw
 AaT8f/nJoCms+WtuM8Mv/vzYQyCEKi6cz52srs4IWQ/ed/MVVDBT1H7rBEZuLClAhnqV
 kvSw==
X-Gm-Message-State: AOJu0YzBL7Ir5SBtdT7b7NaUUe7w6nz6HcTkL/ywUf2iNlNS67TpeVNc
 aSpnHhSfc8YPwCooL6zl4mq8isvCnPvrWH/pUt99Vg==
X-Google-Smtp-Source: AGHT+IHnk19pLsy6DkUCc5fVGAxtCRJw0wnL6gAl/ut00b1Co7hUxR1aJWn7VhlnY4T9QHWPkgC9lA==
X-Received: by 2002:a05:690c:ed6:b0:5a7:b10c:4772 with SMTP id
 cs22-20020a05690c0ed600b005a7b10c4772mr18162053ywb.19.1698175532542; 
 Tue, 24 Oct 2023 12:25:32 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a0deb04000000b0059f5d686479sm4342025ywe.16.2023.10.24.12.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 12:25:31 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:25:30 -0400
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] arm: init: add an option to use FDT from previous
 bootloader
Message-ID: <20231024192530.GH496310@bill-the-cat>
References: <20231024-b4-prevbl-fdt-v1-1-541f71dba802@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uDQfj4vEt6qKFW24"
Content-Disposition: inline
In-Reply-To: <20231024-b4-prevbl-fdt-v1-1-541f71dba802@linaro.org>
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


--uDQfj4vEt6qKFW24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 12:32:35PM +0100, Caleb Connolly wrote:

> Add a new config option to allow u-boot to reuse the FDT provided by the
> previous stage bootloader when available.
>=20
> On some boards the previous stage bootloader can populate
> platform-specific parts of the devicetree such as the memory node, this
> allows us to avoid hardcoding it in u-boot and instead determine it
> dynamically at runtime.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> This patch will improve generic support for Qualcomm boards by enabling
> us to configure the memory map at runtime rather than having hardcoded
> maps on a per-device basis. I've gone for this approach initially to try
> and avoid introducing board specific code where possible, but I'm happy
> to rework this into mach-snapdragon if that's preferred.
> ---
> base-commit: e65b5d35c9116485366bb08138043d51220551da
>=20
> // Caleb (they/them)
> ---
>  arch/arm/lib/save_prev_bl_data.c |  7 +++++++
>  boot/Kconfig                     | 10 ++++++++++
>  include/init.h                   |  9 +++++++++
>  lib/fdtdec.c                     |  7 ++++++-

So what is different with this instead of using save_boot_params ? I'm
not saying this isn't needed, but I don't immediately see why
save_boot_params + (OF_HAS_PRIOR_STAGE=3Dy&&OF_BOARD=3Dy) isn't the solution
to the problem.

--=20
Tom

--uDQfj4vEt6qKFW24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4GioACgkQFHw5/5Y0
tyxa3wv+OPSU9AY3sA2EPdfgPM/K95MdMSkBBLlmGGmBxKd6CvX2r/5BfWk1jeeh
YP1voVPw9GBUecioZBx4Rmo0J7gFLiArfIxyOt4xKVITeBdI8Nj8We5SQvecDmW/
q1JH/ohJ2J0CL+0wMqZro098PhjYJOhg5ewCJ/ydQbKmeK+36VCNe9nyKA9F/HoM
h0LFQjjP5IYe1uSBRrZwOv1GHtHJwIAJm2o4yAPQ6fiWv8KOHPI/6wRX/PiC0rGs
V2IfcFK2e8NB3zdt1IVKApkiKqAuThYzVcOaDOcyNrCiQ8GwAkgc92qylmGmhbIu
K5ZrSvf/EA+GL+rJLo98LJzBZr1KG9BlwrYUZ7bfKhvrBEOGvs8YkbuNQdCXi+vN
Gv/wvJzhHyO1d8/D4wWNY7swAvjz43VN0dtQ+t8xGMJddFV+zpa/sD6g0VMHQk0I
675jbycUh2mVpmvigpow/pBwx+pU4gdM06dPrpq7gcErir1paH9sfOeMtOZJ+QAa
0XX5iswW
=HiWx
-----END PGP SIGNATURE-----

--uDQfj4vEt6qKFW24--
