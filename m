Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37E5D10F58
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 15:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6E17841D2;
	Wed, 26 Nov 2025 16:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ih0kpebW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 718898425C; Wed, 26 Nov 2025 16:41:45 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BBC783FD6
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 16:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45090ef26c6so1169339b6e.2
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 07:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764171702; x=1764776502; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3a0spk92dUrRdzO7pDDzJqbsFgUejBhiQbzyM1mblic=;
 b=ih0kpebWOp1CaKkbPCln8bPJLUGox+ZaVxm07xNzR6nsXwasavZGsaG/Be2yIC8BVS
 7tipwuptRkmU6pEgqQ8xBgwao76gKux9jKcQpfbvb6c+1xiYjXFDNlvPyX+dfXGW5hCF
 8VvvoaZfB+fWh2RT5xm8A+BbbU8AX5I24BhCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764171702; x=1764776502;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3a0spk92dUrRdzO7pDDzJqbsFgUejBhiQbzyM1mblic=;
 b=NL4pPw3KkbpaVvH/EgzISnms0ZYpImBSqO0KIOIWSiKW7kjtvydnIbYLZKgLX3NVFV
 0WvRGNhnbIfCBl2Lz/HGdPEXff/TxxWVcidgp5SfQpOzmVbe/c7gfXqoF2FHDDTebq58
 xfQuV2Urk0vXzvBQz0mOPjdSlc7Ls3M1NiXl3xTX97nxlFzD8vSOVYWs8r2FDSUH1WXT
 DoudNKWL8h9yEBQgzJZiVfPI6LgW3ZWG06RsIWWUWaMz11vlWOSkv6bMlXuEvr4btP00
 putkmwQfkr1U+UG05NwLL2BmHDs1W0g/umKd6DIkyesN/slDW3ePnxIxEIYzzHeFcMCp
 WGYg==
X-Gm-Message-State: AOJu0YzuoC/S3LS+y1CzY44HplqWgjRPInfJRBwgUCOBxEiLg70tc+5a
 ZM4uAjzqqO5XCKCpurTB+WQCwYoeKGtGXYXulCLSsjPNsct77meH+vo0nGoZBd5yCVwoS96FO4j
 RscwlRiU=
X-Gm-Gg: ASbGnctzPEI2rGSit+N1MnWS9pPBuwdP1SOLGqpb0VGRLiBx8J9n8Typm0n+xHXVQlF
 lEibWB/lP7UdJAr004Kzx08OtxEJejVlpLJvg5zOFwNZZDc6fJmWm9WVnZWeUEMzDW0HXojGSW6
 lCLFc0RvGQ0plxpV830AMJ4sqYFxuWkJda5BNmZED9p7Hq1D6+DEYkGlo9o5LGeSeV0PSYJI84k
 HW/WiWbxN31H5wihXhg2L4Tcscd08u48LsN6UrcT8liUNhF5LTvLniR3966qBI2vpWz+ms/Nk7K
 i+Ggb3nIkIMPdfR4xUMbx9vYghkdMvg7zjaiJNDX7H7WDJsgMmnHKB2GbUTULjKbgFVUWRw8min
 IKRNCfdivURTL7pvlrwrJ68cFVeVccs5U/KmFZg2M+zY3JsLY98jV3H/h3rWoq7KmHiGoEsiSCk
 eneiN3iB9jpOu9ySLWKLLRacAMdCFheBat5pV0Peu1BNQlt4enSA==
X-Google-Smtp-Source: AGHT+IHYLr6lBw30WAPtw/r0IPeY5Vy/qjlp9s6wo3NN709FtsbRq+bncYhcacjuCgftugc3/8P06w==
X-Received: by 2002:a05:6808:1454:b0:450:b7a0:41ca with SMTP id
 5614622812f47-451159c4925mr8120471b6e.22.1764171701750; 
 Wed, 26 Nov 2025 07:41:41 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450ffe2cf67sm5541289b6e.2.2025.11.26.07.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 07:41:41 -0800 (PST)
Date: Wed, 26 Nov 2025 09:41:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] docker: Use GitHub-mirrored TF-A repository to avoid
 clone failures
Message-ID: <20251126154139.GA3759421@bill-the-cat>
References: <20251110133758.1644822-1-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kTSfBUrtYEHy4e1q"
Content-Disposition: inline
In-Reply-To: <20251110133758.1644822-1-bmeng.cn@gmail.com>
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


--kTSfBUrtYEHy4e1q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 09:37:58PM +0800, Bin Meng wrote:

> GitHub Actions consistently fails to clone the upstream TF-A repo,
> returning the error: "The requested URL returned error: 403".
>=20
> To improve compatibility in building the docker image with GitHub
> Actions, switch to the GitHub-mirrored TF-A repository instead.
>=20
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>=20
>  tools/docker/Dockerfile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index d2384219c06..201a1cdbac1 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -243,7 +243,7 @@ RUN git clone --depth=3D1 https://github.com/OP-TEE/o=
ptee_os.git /tmp/optee_os \
> =20
>  # Build fiptool, bl1 and fip for fvp and qemu_arm64
>  RUN git clone --depth=3D1 -b mbedtls-3.6 https://github.com/ARMmbed/mbed=
tls.git /tmp/mbedtls
> -RUN git clone --depth=3D1 https://git.trustedfirmware.org/TF-A/trusted-f=
irmware-a.git /tmp/tf-a \
> +RUN git clone --depth=3D1 https://github.com/ARM-software/arm-trusted-fi=
rmware.git /tmp/tf-a \
>  	-b v2.13.0 && \
>  	cd /tmp/tf-a/ && \
>  	make CROSS_COMPILE=3D/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64=
-linux- \

How consistent is this failure? I've had problems this past year
building various parts of the container due to AI scraper overloads but
never had a problem with the TF-A repository.

That said, it would also be good to document how to build the containers
with GitHub actions.

--=20
Tom

--kTSfBUrtYEHy4e1q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaScfrAAKCRAr4qD1Cr/k
CknaAP0QpDaNDSYZL3iGA8h9BkECEk8dRyMp8rrlvrp5Jbh4qAEAix0SfnFw7dWc
hnzSoI8qgcjody4XB5Gz7JnCFgBlUQo=
=zO5B
-----END PGP SIGNATURE-----

--kTSfBUrtYEHy4e1q--
