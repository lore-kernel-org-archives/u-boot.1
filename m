Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F9ACA0FF0
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 18:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E5EF8522C;
	Fri,  1 Sep 2023 20:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UEgQKz0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF27D85894; Fri,  1 Sep 2023 20:11:29 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 276A381FA8
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 20:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59288c68eb8so24548457b3.0
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 11:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693591885; x=1694196685; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GhrxWyoEUedyxlLfe9ORD7FDmSs0nquOC6R7c6zI+gU=;
 b=UEgQKz0u1ISUxx/LP1JSirdJWMK55UC0+Z7mZTydLedZyChxfbTpUkIwGC2dWY4d01
 gEFzgx2ak7r+FrUeKzlOoR84ts9j41y5naCnIoGHZvVhoQTWbBytA/1EwtwBta5nyuWp
 /55PeacH1ITAhdKbjBg3p4u5jIWEB7riwUmkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693591885; x=1694196685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhrxWyoEUedyxlLfe9ORD7FDmSs0nquOC6R7c6zI+gU=;
 b=kPNnGiItN9HwScaIY/U+415QrSImnC7OztP3dCmIteQ7EWJ4Z7K16+ye9XbpQ2SMHl
 5qyFfzpgCKb5v98Mvi1fPuvZySKQBKwhKF0ThnAbRw322dlbFXPXLKmxklRIpaDDdq+t
 Jr3et+K0FpxqkSwmnzaqaRa/N9JwwnNvE8HiSpkO+/ZNfYGqIENpSwTnwOBq3cFPjrih
 f14/UWRuZhRra/BPzqCZirofsXWlF5vRk85uJPlwgxArRfw++jFeZiDfsIrUyeRQwUVq
 z62Xq+ML8t6dYRvzQV1LpW89PtHnqjVWp3W5qvZN9VZ5YgpWji/kBsA+8S9OP4POub1H
 KyVg==
X-Gm-Message-State: AOJu0YxQXMRUsBimf6YlYFzh2TI2r+EMRZYbZTYlu2hcpfsYRmgyIHa2
 KbM4yVBTWjyd3pCwGSz1y+byQA==
X-Google-Smtp-Source: AGHT+IHD9FAZZ0VYmu6BLx7RlGTEBDoqsQ5lF3fK3795VQS49sg+qM/cxsCzH8dzDfEt+rqbmUhmzw==
X-Received: by 2002:a0d:e045:0:b0:595:77f:e368 with SMTP id
 j66-20020a0de045000000b00595077fe368mr2872777ywe.52.1693591885676; 
 Fri, 01 Sep 2023 11:11:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4587-e14d-65a2-5068.res6.spectrum.com.
 [2603:6081:7b00:6400:4587:e14d:65a2:5068])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a0dd801000000b0059511008958sm1196017ywe.76.2023.09.01.11.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 11:11:25 -0700 (PDT)
Date: Fri, 1 Sep 2023 14:11:23 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] .gitlab-ci: Test sandbox64 board in addition to sandbox
Message-ID: <20230901181123.GT3101304@bill-the-cat>
References: <20230901084810.238594-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dJznbpdi+pJ/+QbM"
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


--dJznbpdi+pJ/+QbM
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

I'm not sure it's worth building and testing sandbox64 without LTO as
well. The primary reason we do this here is to ensure that the NO_LTO
flag keeps working, rather than specific outputs from the tests, and we
should _probably_ change the current one to be a case where we just test
that the version test runs and passes.

--=20
Tom

--dJznbpdi+pJ/+QbM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTyKUQACgkQFHw5/5Y0
tyxyTAwAniGZbVcEDNVHVTFK3qQaYJYHYd7X9KICh93fI77Gbkv5sJZUEUjqoUG6
TTbsh+Klg7iicMN67Tq5Y1Q/pPhyRxALVuMhvYBVsz+oOkGZ+WsOKn9+G9PkP8ws
HODBxH3WMaHN5bZOI4wCxepFc2WNDHCwDZeBcVaDy4iLptw9PhTthtgyWfZW9hd2
k3OCi/HWJv7s5jjeVSjtjlT2vrbWZvOJNayoOKmXbGbQF4D2rSTZp6hfIM45mt9T
Zlcloi4QNMaLpKxhS+d6wfq2RhwlAlnyq86jfwHkWm8kdQnLaJB0h1HCZqCiXghw
sDKDMLEp4YVp5vUKKq2YDFykZQ18ppvwVX58rOG5SInTBt8/z4T2aKLzvKMEqIP5
F/woLlA4RYUb3I1Y7GVp5hakhAn9RbepEzJlPz8cZxzISisWbY/cdYSDLXJrrqeT
pTB/KD0JWBBVhNCmKNPUe6/JLRCuPeYPqdUfAHh9/GNfdwnx6UBe/cAjKfNHUVm9
zi6wPf0v
=cuiv
-----END PGP SIGNATURE-----

--dJznbpdi+pJ/+QbM--
