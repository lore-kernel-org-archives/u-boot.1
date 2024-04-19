Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D653C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9BDF884C4;
	Fri, 19 Apr 2024 18:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LerpGSFt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B6D08875D; Fri, 19 Apr 2024 18:33:32 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8495988305
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a55911bff66so32594566b.0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713544409; x=1714149209; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=59aGDHzJzaQ7G6YYrBlR+aaChx8yEOOVDlPI+sjtxg0=;
 b=LerpGSFt1l8NXnsu7ipJ/xBQrwrIOmbOjoOfK/nbg/5DIbvOH9UOg1xv9Vi2imYYxA
 XmtfQHjcMfjDZF9ovaFbdi7a78FMeSLmGjGLBsKfcSm6+5w5Hik4ArbvTX83Xm2AVHZw
 v/Y/TGW6R9zdZG2XripX8+w58bXZ09/3pnvCUGw5Q/d/MXR+SOy7FQdWiGoJosGZTX3D
 5AksrzAuO+1HrzJtKul/5Y+vsqV1ap0VRmmx1aGtwHvTlREAuJPmvERYPCBcwA1UUxcG
 WYClehNhvSQke4ugYCdC3wcPONMtR7ms7bw7wQPKCerPI3EtwgMzktvrV/B1cNUZE5Ap
 ws1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713544409; x=1714149209;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=59aGDHzJzaQ7G6YYrBlR+aaChx8yEOOVDlPI+sjtxg0=;
 b=Qcg7qXAAAMZ9py8pW+NJuWoZ+oNO751ew3FByKfhbZibB1Yv6U/6bzejqxsKF+O6Hg
 qQXMIJ0BHIWqXD7yItc9YdzSGwKfOGHVgU55rBaD4k7nSRh4r/3alApbWDSgOCxrKGmJ
 qaFB1YN5irmT+HmDMKPTQ/tS/PvNncIvn5rCikqbiihKLm2os3HZSa1e+fc3MNq4Zz+Z
 fJNlK4nDGi/LSF35c+o8dzBu4yq7dKVg/bIHx7CjG5fmzWYaTmWDtaiw95nkOu4PJVYP
 qB+/aXs8Wt1AeiF2y1mouXK1a6Al+MCqVEgtrRRJEt/g6eiD02ZWf2qGroFNcndCwFUE
 TXNg==
X-Gm-Message-State: AOJu0YzC9uuDh5LoVjPPV1m472rUO73XOyus3phBRgJkw+NQuiy6dT3w
 02uidY+nShWSXzr2ZKXeNYWbStKtntXzGIJIWMDOhPrOBYNr91CR
X-Google-Smtp-Source: AGHT+IGgdNU3evayJo7TvuwyAExYLOs7B3MkZiWHMaAr/rhZX5UsLOy1DLfCiA8b6eZJTUIHCNJwig==
X-Received: by 2002:a17:907:7b86:b0:a52:5b71:d91f with SMTP id
 ne6-20020a1709077b8600b00a525b71d91fmr2590581ejc.19.1713544408856; 
 Fri, 19 Apr 2024 09:33:28 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 qs29-20020a170906459d00b00a5197fa2970sm2375989ejc.25.2024.04.19.09.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:33:28 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=f96d869ddce27e0bdf873f5fe9a909ed87d1472f1ce8809ee95618c8e0f6;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:33:27 +0200
Message-Id: <D0O8SPNX2ESE.2AL0KBG7N5R8H@gmail.com>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 02/18] video: tegra20: dc: fix image shift on rotated
 panels
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-3-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-3-clamor95@gmail.com>
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

--f96d869ddce27e0bdf873f5fe9a909ed87d1472f1ce8809ee95618c8e0f6
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> Subtracting 1 from x and y fixes image shifting on rotated
> panels.
>
> Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS Grouper E1565
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/tegra20/tegra-dc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Yeah, looks like we have that same fixup in Linux:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--f96d869ddce27e0bdf873f5fe9a909ed87d1472f1ce8809ee95618c8e0f6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYinNgACgkQ3SOs138+
s6E6eBAAkoWmCgvjyzn2/Of/HuPnN9IpAeH+31oeF0Wc/YGhD9wT53p6zST5SH3s
V3fmBf4NRK2lfwKWHtlQQhvFG4brVBa1SrmiyVddXV9A9OgIbi9Ph9xjfuLeFSEI
Zh9sxTD0+t4eIG086hoz5C20Itud43oeaZdY8a8OTle2/nLolxAgyU3DNvK8EdH7
mbXJsL7ojnEf8aZv6y8SXQcTdXo3fZl2ngL4QixwzjHJRIb07mWqwV24d/2LtE1p
Hr7FdB3iePuNavcYVqwJ14exppfEHd9zy/i23aLZ8ioWvOobpF0pU747lkvaa06o
xeF23P1S09XeH0EN3s0KbFtHNIRwnKfUXpTDMBKuxTUP1/WIW2zL1LUpYNXMTCfl
SfMmxC4ZLp5CfC+E3hbwCaQ30HnVFa2v1Gmb3RA6E7Qocr4vEtdmjTjgPT9cJqFY
Zwg0Fe/hc/xfuQTY212NV/M7uORMa1fvhp7L/U1GxAhU13Q38C2DF3AIRGUwFc/T
8UkuJNaTEHaWzdeaJv2WfI7lf6ozVQpxZ2Y7sHxcL2MQ67qd60fqOTxNhtMbSRR0
yJcWJ5enSyU+4oU0gCpU/m64jRps4fyNq5x5HZa8E2aiodAXeJo10Cyu9XS/IyDF
URi3l2E7dmU5H7ERyGrsoRLiswOJHeDRnwglCfsPjbn7t0hsx5U=
=LNa0
-----END PGP SIGNATURE-----

--f96d869ddce27e0bdf873f5fe9a909ed87d1472f1ce8809ee95618c8e0f6--
