Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA85BC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6E43800B3;
	Mon,  3 Feb 2025 18:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l2mclgJQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03DBD800CF; Mon,  3 Feb 2025 18:14:04 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1FE880079
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:14:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-46783d44db0so43763141cf.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738602840; x=1739207640; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aDrcX+2YpfgocCqVRpcqGMK74ZUZ24C7LxZLkT6ID6A=;
 b=l2mclgJQuJswXYc0W/H7Zhf2rCKxWv8bro56cWrx1LQ5m26sj7olvEokOrgop/OZjI
 xBFcP7aE15DZYwTUerxAJaEf2w/NTsI4RacdVxRi7B0w97FUVoCRydiSN8yeBvtuXYIg
 CbzYxikouoePit7rkob9mOF9v06PdxgSNLQVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738602840; x=1739207640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aDrcX+2YpfgocCqVRpcqGMK74ZUZ24C7LxZLkT6ID6A=;
 b=EkBxlcHnGUb6tTVzC8Jc9AUBZT6Yx6rUqu/roMSvQchKEwXgvUXz84LaYz31V/VEgf
 CP1HzAMdnU0KDTqINI1m3drV5lxcPOHtwjWJehA5drsufK7qFzaiig/X3CwJR7q9bHgX
 TcpLb+FUhfcL+mtRNuCpptp18I5Fjr1Y+SACXNVWKONV5dzgIQQyi4Nvv+J3adoH1jIU
 8CX6WHSIjZr25wlZxOUZE2cgQgO078T4WWsP74n6brhwwOrSpEhAgku6gB1mFauac5P6
 fUIvAtnxw31j7LslYFVGl+gK5LfpkFPqRLrSMGqLUjv1p2G7ix0sA5eMVSkfTVca0DDs
 lpNQ==
X-Gm-Message-State: AOJu0Yx4wONqsCL3XIFpuLszWpubV56NXtELQ9n+9hlQr+ghKhzjKjR2
 rw1QGs2iMewh0h2pvNEO6YXCfVHF8Hd8cruv0J6RDgKC9LPQjulvP5SO64Qgems=
X-Gm-Gg: ASbGncsu+Vk4x8RbHAC3I+JrQhhbizq72onnMhIwR3pVGfjwVa1rBIl6/XmsekASJVa
 ZSRuGV/KqA+kQHV2TA0O/yyPT682tVyJF+TcQSmOXueMXTxuS02TxU8mjqn3wADx0Dx+lQHKhL3
 vrS+KVySYieZGpE5Dr9q88Au7JnxcDg0MrrM2pABnwVKCj+fJBSno5SuE1SRZq7biiJfeAb2hNJ
 n6glXfFkQpVfS9X8V42n9nNdCOQjqo4DFRiJjwD8GKZYO4h0JYTaSHmUaMwKGotWEFA+VR2RGCe
 +7RGoJarEXK3PEQ=
X-Google-Smtp-Source: AGHT+IHoCJjImA/d8Tmkx2MdwcLfx7/vQFqYiA9803ilncJ44jedS7rApeVekujJeL16i0S0iQ8KoA==
X-Received: by 2002:a05:622a:52:b0:467:61da:1ce2 with SMTP id
 d75a77b69052e-46fd0a9bfcamr342100361cf.16.1738602840227; 
 Mon, 03 Feb 2025 09:14:00 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0e4e80sm51819381cf.47.2025.02.03.09.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:13:58 -0800 (PST)
Date: Mon, 3 Feb 2025 11:13:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] CI: Use different containers for concurrent runner
Message-ID: <20250203171356.GW1233568@bill-the-cat>
References: <20250203162608.626479-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="itisj8beSDw0nrn2"
Content-Disposition: inline
In-Reply-To: <20250203162608.626479-1-sjg@chromium.org>
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


--itisj8beSDw0nrn2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 09:25:54AM -0700, Simon Glass wrote:

> When running multiple runners on the same machine, each should be in its
> own container to avoid them interfering with either other.
>=20
> Add a container name for this. Ensure it is removed after use.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  .gitlab-ci.yml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 1d4d3a85741..3487ad7e579 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -14,6 +14,10 @@ default:
>  # in the u-boot tree at tools/docker/Dockerfile
>  image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240911.1-0=
8Dec2024
> =20
> +services:
> +  - name: container:${CI_JOB_ID}`
> +    command: ["--rm"]
> +
>  # We run some tests in different order, to catch some failures quicker.
>  stages:
>    - testsuites

This seems fine, but we should start by moving the image: line to be
under the default: stanza, and then add this in default as well.

--=20
Tom

--itisj8beSDw0nrn2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeg+VAACgkQFHw5/5Y0
tyyv+wv+Nk587VZjjXcg5Btu9texB/58mdiLaigCfA2CLObkcFAbiNiYY7eUE8Vs
TIZWU6ArHOzLGDcwi/y8eDOx2bdx/rnjg7rHahvPSXkrGT8RPM2kI2RDWAyOc0sM
tK1c225JrKKafxJ5ImoEh2lRB1CgVUKuRr+yAE7079vgaeIEnZimNUFVSka+4IO5
1gJbZfrRumR/T01FfMXwiEEUp8sTTflhrXzu/MKlobCtqUGrXL7ztr6vws2kjDw1
9FsBI7rQvztm4kcDWM1JVulVazOm68IKpvO+Q3yLhD1VOv0Vzb0bwrlUkzOinReq
YxUq/lIWnH/fxZa85rLXDveZrK2PdTZz9NpmbCN+34wkzdzmm4khOiVX9Jkg69y0
jjpWrMOo8qv0fN+DtBbtQQqg1ujKKyFAV3hWvo7Dvhn7+ZGwtQH44A4i53DGAvSJ
jw8Fl3jAPzDUaSGdOb+pxPkYr3d/6KjkExMOXsFgou5bupHWuexBAdW58pXctXWj
Q9M+KOPH
=YshT
-----END PGP SIGNATURE-----

--itisj8beSDw0nrn2--
