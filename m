Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112EDC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 21:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 796C08081A;
	Thu,  1 May 2025 23:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lmbSv9Nq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34117809A5; Thu,  1 May 2025 23:12:32 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07DE38070C
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 23:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2c6ed7efb1dso971046fac.2
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 14:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746133949; x=1746738749; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aIiCYXGzAgZQI5ngbKqBloS5Medc3XAf8UiHs2DcbEI=;
 b=lmbSv9NqmIP7tV3FJ5soge6gIS35dXasWhiGyiKiZKwnDNbcmwVSeir6nBYmDxryrW
 t2v02SaNoteRHZtoRdEOVDMDcEur43179sU87lw0CYLJRsSJr8vLjRt8g3VjCmpFZvoE
 zUF2obhlRb9CcVfVB5cSTTOR+wai1Mj0qX3eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133949; x=1746738749;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aIiCYXGzAgZQI5ngbKqBloS5Medc3XAf8UiHs2DcbEI=;
 b=hslRUs2XjJWGOF0yr0/eBzC93T9txQXllele4OkvpPZvbOWtcza7vIms7d5KUKw+yf
 cppQUCcybIsDxtZYLlctD4WZyT+lxoD0+nk7GlzvxgSk5fx63xeaK9UlxgDO8EWF07AG
 ou+WVCXL+lE2I+FKJNjclh69U8GpQ6AxwIqPsJR9T7GPlA30XEtqJrJ+n91OMa4bGuXf
 MdK0zznxgsTcvkhTwrzPw6C0D9cWW69YbSKI+Qw4dRols439lYMYJY5W6YGay4Sr4Pjn
 25OADA5KkUgF+2I9TObygHU09A1uCuf7+6i+1jwFGb12iGRpq699vv0ljYa2mRrH2WTC
 ZobQ==
X-Gm-Message-State: AOJu0Yw+7+ToP0mVHLKE8p7n8BqCIAzTi0Tgib/JEcfH5mqk0e7ebsLS
 PH4ynQ5UF6HBCZZ1cnFS9flF+AjP/prCpnE9EDIVOgoc6ULvU7Asx+Bi+k8mFHU=
X-Gm-Gg: ASbGncsj106xIUft4cl4XlHQHrzbhbYZg7SeTOhv/todcGwIEIXqoH3/qKgJTMJrTUO
 iJ4Cd4NPHCiivjgObizM+pP9RE3XnAYSNkItT9gcVt6kYhEBQ4TFVD0c2T407xXvCQbw6z9TopS
 asZoNaAUOokA7hp99ggy5hLzBLLCIhEx/dmQXZI9CBCftAEsu/wMV5dNWPLbJqNf5xVJgQA6ccM
 geMYgmDKEstt+eBBOzruLYxicsJms0+4mQYNJb1c7RDJQpjBqPozxEo6Sa7A0oncZr/hatNJ9WN
 vBYaq7NGpiFfuLsBgxI/zcEKF8Z+9DJDGCNvGKyDWVZBNNbSdF3rsALwvnhV33PWQVbLKT7J9gA
 DoA==
X-Google-Smtp-Source: AGHT+IEFbnkkG2p0EpA0aiDW3qROrQCROGERQY3fZRkEpU4O1Lw4gGhcmV4ByITLluUhstEUIlBTOg==
X-Received: by 2002:a05:6871:ea14:b0:2c8:5db8:f23a with SMTP id
 586e51a60fabf-2dab30bfaf0mr182367fac.20.1746133948609; 
 Thu, 01 May 2025 14:12:28 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa127bdb3sm316919fac.50.2025.05.01.14.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:12:27 -0700 (PDT)
Date: Thu, 1 May 2025 15:12:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Greg Malysa <greg.malysa@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 William Zhang <william.zhang@broadcom.com>
Subject: Re: [PATCH] bloblist: Add maintainer
Message-ID: <20250501211225.GL1261075@bill-the-cat>
References: <20250501210145.2011382-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="im2y9clTg6Vev6Cm"
Content-Disposition: inline
In-Reply-To: <20250501210145.2011382-1-sjg@chromium.org>
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


--im2y9clTg6Vev6Cm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 03:01:42PM -0600, Simon Glass wrote:

> Add myself as maintainer of bloblist
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

With the reminder for clarity that I still have final say over things
(and that's true for everyone):

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--im2y9clTg6Vev6Cm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgT47kACgkQFHw5/5Y0
tyy+8Av/T2ysPMsC0dDwKFFLL+N5YvVGba3OWO8siOdW5rMlcfyf8kjgiq6yDIZf
AOYnjQJNqGJuMaQTtwl0Icu0eG+AAlTyQEKXvgnpz0Uv20pSH0imLuWJOrbxrxbB
IjOUKvDzDtxOl6kYrg0AHS7WaWzGpe+VK3OXq3uY7gZMSzctLQbCDxbrjM78z1cS
ukmqgMA4k0d4C4UchXw3SbqjELp0GcyNd4zu7aDKahLbo5CrQZFN/4budn2KDVt3
4mYygkur236SRxEZd6bnTSm/yTx9wW1MJtjEbf7KMxaEDYsoJ/ylaCyYP/yCXBXa
wcSnSdVkrUaCgc4GRsj0YYE0rgWPnoV2LBWWMx+EFTkkqta2TCMH8WV5Mrt07oqK
XAedAoHN+XbA6E8fZWeFk7vdjXi+cJaDz3v7ln9XGWgJZGqMlEQ4IjE6lGUaC+1z
0x1UOZqGz2GvgFVcn4Q/Gi18qS53GC8pMnUSonBMxyMmIXv1u9RBIgalbLwq0+Vq
Jq49y9OF
=n/g1
-----END PGP SIGNATURE-----

--im2y9clTg6Vev6Cm--
