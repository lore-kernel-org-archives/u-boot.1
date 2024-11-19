Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C4AD4417A
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 15:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5462D8957A;
	Tue, 19 Nov 2024 16:59:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KcLAqrzK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E9A895A2; Tue, 19 Nov 2024 16:59:46 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0E6C89578
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 16:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b35b1ca0c2so527057585a.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 07:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732031983; x=1732636783; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=op1/g0qVALDl/M8FzHKpsNAq5miq1D9HRPDsqXohmFY=;
 b=KcLAqrzKC77sLjej/SnAfVSjSTdZQ+xbrWF46dcSGyExDp3TlwaM27rZcKnahkUDY/
 BJCBow1mvvEfwJsmJRVWRQJHxpSAcIOk0xigbgtKH9yslPC/LEeQdygsp5xFXf98pn+H
 wL92FBPuyWOV7UdHlOiQuTy3WQj1caohGs4E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732031983; x=1732636783;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=op1/g0qVALDl/M8FzHKpsNAq5miq1D9HRPDsqXohmFY=;
 b=RuWTBUmSvkK/uIUGN0pnPreVI7Yei8nyAF0UxF4HqvqfV30hnzpJ+mWX+/9qGzDGvd
 L1Tc77wbBE9mliS2M4K+MJaJ3a9zoq63KeSgW5HhDKpFegW3UzOTzmVB35WBDldtug/H
 TGfDgPBPzfh0jLxaS8C9xHbXCcWZR4b47Rs0x9RWrZ0zh2vy0K7AYZb+ftC6o0e/Okvw
 0hwJlGXSmGxRzDAz9tP5M1/wub1+19W+ktvVBa2hTm0dlKi6kNhFT1zQ7v3pG4gQ/I8t
 YIpRqH5t09HGkEUVRAlgLi5zylGVZNw1PMJPLwppamgQqoEXHVnee2w54rqNtUeNmoet
 V2Bw==
X-Gm-Message-State: AOJu0Yxf7no84S+2AURAEl2hb7TOyQbwTI6zBBKy5URsfbBDmWeno8Xb
 kCxhnr6lw4XpagpJv+7AdyzHuOLCAx1DznmjMGGnOXX4oRczo5FjVf1UBa2rkik=
X-Google-Smtp-Source: AGHT+IGyYFGT+vn1xP8VDiTbjp0hwPVuHeKXFdKU6Gu9PmMICe0B3MB/BCM7QWgkUFnREfU1yRH+sA==
X-Received: by 2002:a05:620a:44d5:b0:7a9:c129:504f with SMTP id
 af79cd13be357-7b37aa80df8mr634146785a.23.1732031982756; 
 Tue, 19 Nov 2024 07:59:42 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b37a89637esm104703485a.82.2024.11.19.07.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 07:59:42 -0800 (PST)
Date: Tue, 19 Nov 2024 09:59:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>
Subject: Re: [PATCH v2] test/cmd/wget.c: move net_test_wget() to the cmd test
 suite
Message-ID: <20241119155939.GA3493897@bill-the-cat>
References: <20241115164514.2186763-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2AySSUhvDcvzvTXm"
Content-Disposition: inline
In-Reply-To: <20241115164514.2186763-1-jerome.forissier@linaro.org>
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


--2AySSUhvDcvzvTXm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 05:45:14PM +0100, Jerome Forissier wrote:

> Since net_test_wget() is testing a command and is in test/cmd it should
> be in the 'cmd' test suite, not 'lib'.
>=20
> Saving and restoring the values of the environment variables that the
> test manipulates is necessary to avoid a regression when running the
> whole ut test suite. A minimal reproducer is:
>=20
>  $ ./u-boot -T -c "ut cmd net_test_wget; ut dm dm_test_eth_act" | \
>      grep -E "(Test:|Failures:)"
>=20
> Reported-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  test/cmd/wget.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/test/cmd/wget.c b/test/cmd/wget.c
> index fe26fee54c9..7570c065a10 100644
> --- a/test/cmd/wget.c
> +++ b/test/cmd/wget.c
> @@ -19,7 +19,7 @@
>  #include <dm/test.h>
>  #include <dm/device-internal.h>
>  #include <dm/uclass-internal.h>
> -#include <test/lib.h>
> +#include <test/cmd.h>
>  #include <test/test.h>
>  #include <test/ut.h>
> =20
> @@ -206,6 +206,10 @@ static int sb_http_handler(struct udevice *dev, void=
 *packet,
> =20
>  static int net_test_wget(struct unit_test_state *uts)
>  {
> +	char *prev_ethact =3D env_get("ethact");
> +	char *prev_ethrotate =3D env_get("ethrotate");
> +	char *prev_loadaddr =3D env_get("loadaddr");
> +
>  	sandbox_eth_set_tx_handler(0, sb_http_handler);
>  	sandbox_eth_set_priv(0, uts);
> =20
> @@ -223,6 +227,10 @@ static int net_test_wget(struct unit_test_state *uts)
>  	ut_assert_nextline("md5 for 00020000 ... 0002001f =3D=3D> 234af48e94b00=
85060249ecb5942ab57");
>  	ut_assert_console_end();
> =20
> +	env_set("ethact", prev_ethact);
> +	env_set("ethrotate", prev_ethrotate);
> +	env_set("loadaddr", prev_loadaddr);
> +
>  	return 0;
>  }
> -LIB_TEST(net_test_wget, UTF_CONSOLE);
> +CMD_TEST(net_test_wget, UTF_CONSOLE);

I don't know why / how, but now this causes the "hash" unit test to
fail, in both Azure and GitLab.

--=20
Tom

--2AySSUhvDcvzvTXm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc8teMACgkQFHw5/5Y0
tyztSgv8C/Ip3zaoIJzUlQ1aFp6OzoOB/JpV1EJpf7EWIny43vnoz6c+sIEmT3Pc
Vk/E78JmUw/EYz74q712/jxpbr06VNN6zI6SEEun/aY/PtCjZIr7z34kDOJ+vBa7
QHBFMdCMAfTCoadUsKRURU5VEeMjfiCXNzyl/BGO5lXP2UBY6erzXTnRhGgGfC9t
2RxKmlB8cXzw7UVJpQWV4IitOaG4KqdP5nJqxczvu886pTnY6wDggF6WcSTnfnP/
xQAk9pGzG1jPA4xRGE3mzmbmnVVPPkjbw0v2axD93UCF9vA9rYNDxRXZz+n+9G6U
q7TLbAfM/DT2DHtCGMH59KEHnAU558qyR4frKrUJ3AqVQfrUO//SK3ZcNZp5t7xz
pZwUK14ae7DT+XMZlDxCseqViOF5J1xM6bt8+BX2/3g+UN+Se0zIDn8ADskoXzfs
3nrJKC/MW4mzXl0jSyfZg6rvcy9tZUNXj2lwzXAy05/e7auP8npoqk8gBmuBhn3E
j5YIcICQ
=6fIR
-----END PGP SIGNATURE-----

--2AySSUhvDcvzvTXm--
