Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA62CA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 13:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EC1B86564;
	Fri,  1 Sep 2023 15:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TEVUDEAg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A602686759; Fri,  1 Sep 2023 15:24:11 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB7F98144A
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 15:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-d71dd633f33so1575768276.2
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693574647; x=1694179447; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e8lhFAZKKF0xYup/AgYAwoGTW4iSQgOC3qtL1O1K/DQ=;
 b=TEVUDEAgxniaPHJ95L4GFrVpr58e/cAasexr7T5PXNkmSNvYWruP/wp9DXR1y64aC8
 5VQwwv6xake37gZnGzLQOyuiqAhupbSOakK6+4pl8gIMI3Ki2nmjE2EgHNiYbEX+Nwl+
 9JIz4JXcISTmxAIjUHB5Et1gtWTQ1CCXXcUGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693574647; x=1694179447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e8lhFAZKKF0xYup/AgYAwoGTW4iSQgOC3qtL1O1K/DQ=;
 b=H/XWoUzG3ZNnLm9FAt6k8Ku+f4cU74c+axm86LDqc82c/yKUQ1i1QGeW8PRK7YmiXg
 RiNgyB3LQZhJJ/8NVTMpXB5DiXWxvJcuu/f15hKhUXl0OFBgEXUhiXZNgNeW5FvXk/++
 S2enRefUrgrGTmkikqWQ9TUZDQmId+GbV7M+IgAzJPtvJnV7h5CB+SydmPxR5mZCoSPV
 eoZLtqdGBc/ilvSr17R2xwt2eRQa0KdYxUO8GahVm58BObOJcE8dUm6ol4vtXwEBfzpk
 0Y+v9GJEJK8vc/EVLWZ7LV/ymOGENUhBq7/JXx0TvlTdLIp6y8NVd1/XV7USg9UI3ZxH
 nHNA==
X-Gm-Message-State: AOJu0YyadwOwSwgmAuPStILSVmLIEvIfsVBxA0gFrpRXAJdamd30ys5q
 chrFPhL/Ct1QDZjECpAS2eQG1g==
X-Google-Smtp-Source: AGHT+IFcGggAb11LT8uNaXXi2OeLu7gLmOQi+hfZ1HbT2P25DzsOiBtp319NsxH7vgi0jd1rmKqrPA==
X-Received: by 2002:a25:42d1:0:b0:d22:c8b9:8c9b with SMTP id
 p200-20020a2542d1000000b00d22c8b98c9bmr2811632yba.13.1693574647617; 
 Fri, 01 Sep 2023 06:24:07 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4587-e14d-65a2-5068.res6.spectrum.com.
 [2603:6081:7b00:6400:4587:e14d:65a2:5068])
 by smtp.gmail.com with ESMTPSA id
 135-20020a25048d000000b00d677aec54ffsm884316ybe.60.2023.09.01.06.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 06:24:07 -0700 (PDT)
Date: Fri, 1 Sep 2023 09:24:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] .gitlab-ci: Test sandbox64 board in addition to sandbox
Message-ID: <20230901132405.GR3101304@bill-the-cat>
References: <20230901084810.238594-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ReXHJkW31KaxnhkQ"
Content-Disposition: inline
In-Reply-To: <20230901084810.238594-1-marek.vasut+renesas@mailbox.org>
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


--ReXHJkW31KaxnhkQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 10:48:10AM +0200, Marek Vasut wrote:

> Test both 32bit and 64bit sandbox boards in CI.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> DEPENDS:
> - [v2] test: print: Fix hexdump test on 64bit systems
> - test: dm: test-fdt: Use fdtdec_get_int() in dm_check_devices()
> - configs: sandbox64: Enable legacy image format support

Nice work.

Reviewed-by: Tom Rini <trini@konsulko.com>

> ---
>  .gitlab-ci.yml | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 6d7ffdd1bbc..a7282be3181 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -291,6 +291,23 @@ sandbox without LTO test.py:
>      BUILD_ENV: "NO_LTO=3D1"
>    <<: *buildman_and_testpy_dfn
> =20
> +sandbox64 test.py:
> +  variables:
> +    TEST_PY_BD: "sandbox64"
> +  <<: *buildman_and_testpy_dfn
> +
> +sandbox64 with clang test.py:
> +  variables:
> +    TEST_PY_BD: "sandbox64"
> +    OVERRIDE: "-O clang-16"
> +  <<: *buildman_and_testpy_dfn
> +
> +sandbox64 without LTO test.py:
> +  variables:
> +    TEST_PY_BD: "sandbox64"
> +    BUILD_ENV: "NO_LTO=3D1"
> +  <<: *buildman_and_testpy_dfn

I think this means it'll be time to split sandbox out in to its own
stage on Azure as we can get 10 meaningful-but-long runs there and so
it's best for overall job time to make that a stage. I'll go give that a
spin shortly unless you want to.

--=20
Tom

--ReXHJkW31KaxnhkQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTx5e4ACgkQFHw5/5Y0
tyxJTwv/THsUwC7/gdyUzWdMkORAvwewc4FLcpSja5HxalLZW20SqfSLAK5u6WeV
Rs/Fz4ROqZDl0oQCOIvnHYP6k3rPoY9nZ4nGz7ku8ZBYXcJKgp+hJShTrZ85wOHl
dU7d4FgegUN7QSczDuoJ+JU0+Vr+LDTTUEO2a2reNJ9l/8DgE/mb9TRA4cAt+RKq
7uqWLQzsfxnnm8qrh4AFCirWf/flXspqn7dlACy2mOywuMJbCTPv7BYrUopWcrFu
CZERB+KGg3GyCwcKKGfmLNJtP3qvCrXEO8gnmlRcVmYIp8zbgsefpvRpb0kPlO0i
91vziz9/o60yqBw0r9rIc+5jI1pd9PeKtYYy5bPoXMarjL3TyVBoJb8bbvZK7vOK
wLqLM17N0oz14aNtfwRjg9CWPLdZDlvLRpkHALkWN+uGdqdnCmGuUH0eigFWN7OA
WNImXXVrh9cFjXCEPsmKVPpOiof2yMGLfzGP2yHa+xTjljYI9pxbsTA2m5xcpvqt
zaK8EqqV
=Gqz0
-----END PGP SIGNATURE-----

--ReXHJkW31KaxnhkQ--
