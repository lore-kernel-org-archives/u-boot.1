Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77342C54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D871D82F67;
	Sat, 24 May 2025 16:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ItHbXZC2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C42078310F; Sat, 24 May 2025 16:43:09 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC866828BC
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2d0d25cebfeso557717fac.2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748097786; x=1748702586; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QYazZm34LLKNznYzIR4CyjRSPJVhoQyNXzjTdfxkxCI=;
 b=ItHbXZC2i3U41C7wupvMrlWV9vMbC9R/jpIolCC5QMMV9ZAd6vl/ndIke6Tt1+Y6UP
 cdoqWE7PJlVPuEWpDf9juPASAl7kVzfmAedT6PtrqD6RSKnQmkvGXzpBr9hnTS8/j8Oi
 0NP0jfBE/rdDZnIxDGDEo2h/ZVSAuu/98gaH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748097786; x=1748702586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYazZm34LLKNznYzIR4CyjRSPJVhoQyNXzjTdfxkxCI=;
 b=OTOPjPE5GqlMTndPJMdwkAofSDBuxniF69/+vMCT+eZ+r2W7x6muEIJ3NXIpvwVhex
 uL4QvE65TtNhAwwQPKv/KhwvlGD3frDZq1HV2qBUPhct2nPyyyOlvGKBmsBGDIxkfqAa
 hLJsdLsEWuHfSAkzDtpb+8qMXwbA/AKGSxVXwJQptaK2BgMF70FQBSqLR1b6nqHMRQT2
 Vm69gV/TJWGii0MwXjHrEJRePnq3ACxaHPAb8BPXvwWzJsXpjceTWleGiq0itWx9j5Sx
 j2uhrLjZzyV/MOlQuWdOzeLjejtOcwuIq6U4M1MdTTu8BaGjkxreL5Fu3xeE+6GtqyqH
 WjKQ==
X-Gm-Message-State: AOJu0YzyaS45SRo262vssDdxQJ5KXANDLsm2CvhEDxUAPT/5aJUk0QUz
 uJ/GJVnoRtpatBTpd6KuXicRiSxU1pVNfmEn5F7krui4nhYI/0xCN0NQ5+ntIsI5spbfa79m0UL
 7NFfp6Sk=
X-Gm-Gg: ASbGncumQXhhIRf2+3wfp+NjUqh9mxdTTSOCO59FA3bUwEYV7419sFIjWfepAIbTpKj
 iOK32m9q8CyfTI+hNWxdS9HyTYr87D6O9f0jzSReFA7nNnx36tuhCrX5dhDryLNF1aDR2e4YRQs
 w26JRjcxEdlkTCVeZJ7+c1zWLxj1VJul2PWDLU2t2BEFjcK6K8owXHdxvGPkr3X4EKoIAUR9UC2
 H+LSPLGT599HZx1RilaAUt/Dkybf3e+8KCe6nD+UwpqyOqrRKskSqRZAoXNBcgip1+MNkw07YLG
 2wTceOP/c4Q6pZTGWBA2EjZ9mZuzgHGJL/LbTm/gD7NAP6onUm1uNS6NuqyD2KfE0cfsj8SzS+Z
 WucoYj3agXxWA
X-Google-Smtp-Source: AGHT+IFRLwT9Su0kHCf6i4YUc6Jov6vQgmqDXReTUNEO9PlcqGnZbBc6nGK8fd5dArah3svyYZNshw==
X-Received: by 2002:a05:6871:e418:b0:2c2:3e24:9b54 with SMTP id
 586e51a60fabf-2e861e02c19mr1692872fac.11.1748097786428; 
 Sat, 24 May 2025 07:43:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c06084ccsm4140620fac.7.2025.05.24.07.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:43:05 -0700 (PDT)
Date: Sat, 24 May 2025 08:43:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH] sandbox: Move FDT to a different address
Message-ID: <20250524144303.GM100073@bill-the-cat>
References: <20250524143837.1205231-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rIWs7PFyBxok1I5D"
Content-Disposition: inline
In-Reply-To: <20250524143837.1205231-1-sjg@chromium.org>
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


--rIWs7PFyBxok1I5D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 08:38:27AM -0600, Simon Glass wrote:

> The FDT is near its limit and may overlap with the early-malloc region
> if more things are added. Move it to a better location.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  arch/sandbox/Kconfig         | 2 +-
>  doc/arch/sandbox/sandbox.rst | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
[snip]
> --=20
> 2.43.0
>=20
> base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
> branch: sand

This is once again, not against mainline.

--=20
Tom

--rIWs7PFyBxok1I5D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgx2vcACgkQFHw5/5Y0
tyw7igwAgtkwz5gDURh6Cbkozlau2YYeQO3p8pYzphZNWz2jGiAzBAoNnJc0Y7Fr
Phk72g8niQCrp8VWxwKQqDmCYBAF0TMVX4ktGgsgkmQkFbBrEstGcDRk37O5jnul
rwK4A4tEjYEOD1XVn2tpeIsc2ssWS7+pTGC91cOJ1xDu0p0Igf/J62sTfTnKY8Vy
WZpOOATuvzAnhSsQysDY8BysxICVKB6cIsV1cm9KduWyCPCkhWJuSggliBV3d/Gl
jzkZbNSdgw/UEHAd169zpzYOSeeryY7Q94ppr6OOHyq4rpRCCrn6MELWPmTuzeAj
LaKQVSIP5RYrFI76z0e4hyQQak8svjvmbvkuI/46a1XVnTC/QsczDoOK5fJBTF2M
NegEYRW5ULQxbHn7LoJenMvhUMGC1qRuR6QBCJ1VwwSI9EsL/oaMlLY0Mw7EXyCZ
IblIs983S1TrSOBLFzj6ACRlOw+OlzeM4MVw8HJsaSBISH+p86MqYSO7roy4ukXH
IzZ2h5az
=EZaX
-----END PGP SIGNATURE-----

--rIWs7PFyBxok1I5D--
