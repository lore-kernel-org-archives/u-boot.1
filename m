Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D61FC83F12
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 15:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8412186508;
	Tue, 29 Aug 2023 17:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UgWNhsDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 808408650A; Tue, 29 Aug 2023 17:04:30 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96CAE86504
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 17:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-58d31f142eeso52117847b3.0
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693321466; x=1693926266;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTnEwEZso/TyISalRGjD+Vbh6ZdhGzYhf+LBjclFzqg=;
 b=UgWNhsDQg2jnA1RBFEe/7zL3NHrvPGBcCHPbwYI9FVKimiH8CC+14QEvh9iNv9GTh/
 7U7CawnIEX0kp4wWF3dqlgxoCsrTEChRcbQy6RkGcRcEIuXdGlXtfss4phafxsOObcN8
 nLKVwIoEx2bki0YOEdNZZq7Tmnc3YA8Vx0xKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693321466; x=1693926266;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTnEwEZso/TyISalRGjD+Vbh6ZdhGzYhf+LBjclFzqg=;
 b=d6XsgkZyrORksTmF2PZpAA09rQQbDNLx+xAyTBIXD/Pp0txA+Kt8Ab68qm7W1+UIwE
 /utsK0dPzQ3Z9GWi4Ye1AMKC5jojLQVR8SPxtPmXpDzUQLTn872ZedYLf/7/1uQlTefa
 /yzokSlQX0ncqNnVwQ2cSj5NPhDdViMbLCvHVVtiEo/u7R5d4XSIhJ/xlFGVAkKuyesE
 ey0PtRORrZ7F3cNF+Kex88tXUIUKp6AWUCo1cAD8Ccpw0sslpY9C/Tom4XKLEVYIDK1n
 JzsmveYnUlN++k95M88uwxEZA9smXbVepTIuZI2jXWs4a74IjXUTGlKYN2i0R9cKBYOs
 o9hA==
X-Gm-Message-State: AOJu0YxrnPHhRMUVa5qq+AgHXwRN3Vw8SqLdJS8tA7Hdq6oIjqF4GjmP
 5/AA4SxNA8cgxF1GexJPriGXEA==
X-Google-Smtp-Source: AGHT+IE03ApYC4MkPyc+kFC+rZlJkJXsmfTV3pTCesk/XpU3vyUuCjL5dbQztJezqjngv15kAk8xSQ==
X-Received: by 2002:a81:528d:0:b0:56d:5060:f91a with SMTP id
 g135-20020a81528d000000b0056d5060f91amr29057240ywb.11.1693321466228; 
 Tue, 29 Aug 2023 08:04:26 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4165-1a0d-2d73-76fa.res6.spectrum.com.
 [2603:6081:7b00:6400:4165:1a0d:2d73:76fa])
 by smtp.gmail.com with ESMTPSA id
 d2-20020a0ddb02000000b0058cd7816bcbsm2794169ywe.17.2023.08.29.08.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 08:04:24 -0700 (PDT)
Date: Tue, 29 Aug 2023 11:04:22 -0400
From: Tom Rini <trini@konsulko.com>
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: u-boot@lists.denx.de, Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH v1] CI: Add jsonschema python module
Message-ID: <20230829150422.GD3953269@bill-the-cat>
References: <20230829143710.204875-1-andrejs.cainikovs@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8zqoezEXP5kMivUz"
Content-Disposition: inline
In-Reply-To: <20230829143710.204875-1-andrejs.cainikovs@toradex.com>
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


--8zqoezEXP5kMivUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 04:37:10PM +0200, Andrejs Cainikovs wrote:

> Some TI boards utilizes `ti-board-config` via binman device
> tree node, which when built via binman, triggers schema validation
> for board specific yaml configuration files.
>=20
> This change adds jsonschema python module to CI Docker image, which
> allows these targets to be built by CI without errors.
>=20
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> ---
>  tools/docker/Dockerfile | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index 3d2b64a355f..2f3121ffcf6 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -98,6 +98,7 @@ RUN apt-get update && apt-get install -y \
>  	python2.7 \
>  	python3 \
>  	python3-dev \
> +	python3-jsonschema \
>  	python3-pip \
>  	python3-pyelftools \
>  	python3-sphinx \

Interesting.  How exactly are you using these CI images? We have
tools/buildman/requirements.txt now to cover the newly-added modules in
CI, as we call pip on that.  But, it's not being used in the prepopulate
the pip cache stage in the Dockerfile.  And, I'm not immune to the idea
that we should instead be installing the distro package here.

--=20
Tom

--8zqoezEXP5kMivUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTuCOUACgkQFHw5/5Y0
tyzVMwv8CCWBgWcW2DN3Q8XWUzXGscDE1qR+SuR3Yv/+pY1s1/+hiNOCRHVNdnAo
0ww3Lf6WbyMokHevbygeFfEceyc73shTHun4DaYfj1UD4G7p9hxNZzIGbcyB0sYR
9oElaDE6p3NIjBLg7ijNElKQk/Drok5xWErBXTe+sCmuD7on8Rr3hJ6TcxL5/age
qkZLk1yOcqGW+lhEjrTnTF1625CggNvAGbwrRuyr534q/EpG72YYX2hPN3qllfI9
Fdj79qMZF4qmi+Pm4Wn7EST6NZcELKhrPUe77dY+L+5MI3vmkaIprro9v6sSlQuW
Flxi951Q8rQt60M2+B2Rh8JTUNy2yl/h47fkNkCEkTrRAcBHHnp6vjMUzbWrv3t/
MNNU2euFPz0nhsUXAyZmbfXfXTwlzuo+B/uSyKkVNnLergZQSsOEgREIzmZCMh2S
g1501ZTNdE7IDoAu7dH8QDmkhn8hH7jEFCfMr80TjUtOWQW8QrYtU27q4AvPOG27
T0uEg8J8
=exvZ
-----END PGP SIGNATURE-----

--8zqoezEXP5kMivUz--
