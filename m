Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74035CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B045A83678;
	Fri, 29 Aug 2025 16:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="efN1D6DR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2F5083689; Fri, 29 Aug 2025 16:56:59 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7714A835FE
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 16:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-61e266ab733so357883eaf.1
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756479416; x=1757084216; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8QuLzCuG7KL5B1xjNJWrHINR4SY1bDIavmLXAuh5n30=;
 b=efN1D6DRGQ8yYGL2Zlyf6Ol07aiiqL6jvvp2Udg+FRgwq9Tz6kxMqKWx5DJNnY3P8a
 7IlfUCzXVoSg0wR5CdDDIAhcj6ATilkEv98tWOVBcR71l/d+aUQYjPgsJ3pN0+XORa/z
 97nbl+5gjz4EbuGRvgaRwSqOiePaMry1Alw2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756479416; x=1757084216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QuLzCuG7KL5B1xjNJWrHINR4SY1bDIavmLXAuh5n30=;
 b=vReiUWS8sXHiGy+WQzEDKyR6xbg/c0oP7dfrfXVALk12BhjTCsjhN2vXdXiN43X8Nu
 89yFeDc9aUzNX+RP+Gv0MbrMp9U1p5S9rcy+58O9uQADozbrZgOys/IRRpfpwn3+RcdB
 08qu6O8TRTawmEC5+GEOyRepCnzUI0lX6mBoiJF34/omkj1mex3wKVg6o8ZCWAsw00gW
 R1VP1rucneqfdKq4tGKw016Xmgd3XmF7soTT4f/Z9nT/mCzqo6aWv64iVhu8LGRwG+u7
 4SCUSFraLt4sngWb2RDWUBec2FFTJKeVhFEsBgyEmlmDoFSo1o9CyN4r+8nyn47rVixN
 gorA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkqODu4znmp0QcAgR8Y85ZQ0cf968+Jygb380OteDe8qWg94mxEiZs/32iXA6MQwaFWcIKYrY=@lists.denx.de
X-Gm-Message-State: AOJu0YwyGWDLPC4JBR58vnqdCy5HWhz8z3zFrqY2ey7mOzapTV2RJl0P
 6GXv8PAgFqj8rB9ED1+Ze/sSNtap0HDfY5Ho9lWY/+DVC3Hic0BsLBlQdkvNP0GZoTQ=
X-Gm-Gg: ASbGnctAS64KhboATtWa1Puf7qn5GJuTgBnJn+Zi7FGt/Q9zRCGxih03nOhAUcFyagm
 zp4BU7hC4VIY+4N5pLHgY+SQ6dvpnvIYRFgKj6plmIOWyEGf/QIPVejOOzTgh5kRuPKh7j+Xejh
 am1jZaj9jCWO9ocAAoPO2MFgEe6ghXYwg+XZ4iDT1LXqRD5J9gTPTve7hXVWVOmybZmU5N7ad49
 0hBRGR0gOCQ6q5WMulCr2gsiitnqb8cpTTDhGDS8VZas9uP5DGdfL6SPd38bBuGEJEaP2qvrGaU
 T74zzvHZ1JBYPh9lEv4q4GG7ZE6INF9gpIF5sNcNDwMTZvANBOYNFSXyFccEI3TvkVM/wVSctG2
 GesGA5/+waOEkvH3OBfjase2N8AFyftqtRpskKT1M0yemjZiwAf9rHUGm
X-Google-Smtp-Source: AGHT+IEQRvqhFsywQmHvaruYEgHO0gMh+5ZVW+NDa1cwFj9fDietX4xVvw1aGsLAbNShxT6fj0e2XQ==
X-Received: by 2002:a05:6808:1483:b0:431:5a87:9c69 with SMTP id
 5614622812f47-437c5441bb5mr6159675b6e.1.1756479416030; 
 Fri, 29 Aug 2025 07:56:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-437f41a1532sm1878b6e.14.2025.08.29.07.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 07:56:54 -0700 (PDT)
Date: Fri, 29 Aug 2025 08:56:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Beleswar Padhi <b-padhi@ti.com>, nm@ti.com, vigneshr@ti.com,
 hnagalla@ti.com, n-francis@ti.com, jm@ti.com, u-kumar1@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] Revert "remoteproc: Tighten some remoteproc driver
 dependencies"
Message-ID: <20250829145652.GV124814@bill-the-cat>
References: <20250829053451.3615976-1-b-padhi@ti.com>
 <20250829053451.3615976-2-b-padhi@ti.com>
 <2937fb1b-1f40-4edc-af4a-e02946b5bf8f@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jDD3/B70zvUp+YVu"
Content-Disposition: inline
In-Reply-To: <2937fb1b-1f40-4edc-af4a-e02946b5bf8f@ti.com>
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


--jDD3/B70zvUp+YVu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 09:32:00AM -0500, Andrew Davis wrote:
> On 8/29/25 12:34 AM, Beleswar Padhi wrote:
> > This reverts commit 548ae9d1a537464254afac63f802179a24c645d6.
> >=20
> > The IPU remote processor is only present in TI OMAP SoCs. Remove the
> > ARCH_K3 dependency from Kconfig. This driver builds just fine without
> > ARCH_K3 config.
> >=20
> > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > ---
> >   drivers/remoteproc/Kconfig | 1 -
> >   1 file changed, 1 deletion(-)
> >=20
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index e9f19a69433..a3ecea05e20 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -125,7 +125,6 @@ config REMOTEPROC_TI_PRU
> >   config REMOTEPROC_TI_IPU
> >   	bool "Support for TI's K3 based IPU remoteproc driver"
> >   	select REMOTEPROC
> > -	depends on ARCH_K3
>=20
> The original commit seems to indicate there are some platforms
> were this does not build, maybe depend on ARCH_OMAP2PLUS

Yes, it fails to build on sandbox. If REMOTEPROC_TI_IPU only supports
OMAP SoCs and not K3 SoCs then the prompt text, and perhaps help text
(not in this patch context so I can't see) need to be fixed. The driver
isn't enabled anywhere today, so I don't know that it even compiles,
actually. So it should probably get enabled somewhere, too.

--=20
Tom

--jDD3/B70zvUp+YVu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLG/sAAKCRAr4qD1Cr/k
CteiAP9eWLdzPcOgEGem49mTzn01jSnJpaKgnJU52UMFKv7NpwEAgaA0jh0SsXZV
IYuJbCVVJW3DN+VQ9aW/gBzRQxKTOAI=
=DA0T
-----END PGP SIGNATURE-----

--jDD3/B70zvUp+YVu--
