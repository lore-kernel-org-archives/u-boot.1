Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC8BCA0FE7
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 16:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A100D8312A;
	Tue, 26 Aug 2025 18:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X3x6ULX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CAD7830E4; Tue, 26 Aug 2025 18:32:09 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D0578313B
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 18:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-30ccea8a199so4669847fac.2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756225925; x=1756830725; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b6aRAyj4Fivox5Cg5qZHon0sx0mLrqiJaGzALNjqKck=;
 b=X3x6ULX02OtGziEuObUVFpVcCC0x1sfHrvDxERkck/g+fhTXQJWSMKackWX72R+GbP
 /WEHPBP2wwpgmyh+EztV+HHsjkybYGXoIeMe9ZVIb64n6lkEOw+8RxoN36bFjbvpBG7H
 fuQVA9O6xh6ryDwH097+8UfJTcLhu/ht7DTi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756225925; x=1756830725;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6aRAyj4Fivox5Cg5qZHon0sx0mLrqiJaGzALNjqKck=;
 b=ceHQt5WGEsamG8qws5daP/4+nF7okhUUtMnzUWEUs6kLUD0ganhxk9mM2NlPSP/To1
 msCtfsISrx+d4hqT3KarF0zy5/eZVhqf2j3IKDBEDXh95tvJV/dUpuQB2Fn6DYmFLAOr
 oYOtKTzRUiKEF5F5snCKSerc2ZwVZYDledHIDOLBu2CFsPDnIgqs1Q12vHz1xuE51qUE
 iVMjXHeO3zFrTfFo1IIfijY0/yfT7wJuNteVFtIEOQPymMcFkZCS9GSkT06MkQXBqmaI
 mdCXkRj7H7AkXQ2RGrx8mpSxlEgpMrDZ9+31W93grY3k1NNu15uLCX6H0DRAUhFivdrf
 P6Kg==
X-Gm-Message-State: AOJu0YyZW39jhpg+nzgFbl3Yrg78eLkdV60tNLZXOZ8527lfb4Yj/f/h
 m3pwPAM7+LZaPlEn4KRzDr5Fc4EBOCDm5lWo2Hky1Smu4If2f0fL5mp+J/VHlon22YU=
X-Gm-Gg: ASbGncvfBl2fkkqvqKjx2Ifq4NuPfYshNKnpt8G2Dn/VOg1vexJJyQLvPlcS1wAbV5C
 WHSynZIUkF28HcgVd+OKRy8EYrpBYhAfKKUSHRvnpS+axOrhOd08I88+gG9ZT1DlLyoiddyLlWd
 1mowuoyfcPwfmD36v0OWmMRHSdq76UMdevYxoDgY3b2DZbBhpIJYNZC2IftezrXazUoIaMrpgnW
 P/06DjwFo/PhqiJkKcyIY7lMV0haVQsk1PVZxKcXsqnRRf/OGbZVKYiD/ic2ycKLGMMKoI10p+r
 vF5LgHDJcXnnsNHWH8wF/BgJua89nH14rAMb1LoD3M4/tNDzcuU0CrOcS+6BYIHNTS993X6CsJo
 njZKcIp2upCfHCsXS+R/+4Fge1YictHcsDP+jF2D0txk8w+KB+Nnl/5dm
X-Google-Smtp-Source: AGHT+IHRuaqwam3dT4V70lUByGl4ZYMeUqrRm+K6bVEyYD1cAVSnv/a176vtLVYnNv3rB0/rNx1dlw==
X-Received: by 2002:a05:6870:8e0d:b0:2ff:8822:29b8 with SMTP id
 586e51a60fabf-314dcde0b18mr8732770fac.36.1756225925679; 
 Tue, 26 Aug 2025 09:32:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7450e268ba8sm2399700a34.5.2025.08.26.09.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:32:04 -0700 (PDT)
Date: Tue, 26 Aug 2025 10:32:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: U-boot Openlist <u-boot@lists.denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH v1] MAINTAINERS: Add entry for DesignWare XGMAC driver
Message-ID: <20250826163202.GE124814@bill-the-cat>
References: <20250826030505.24964-1-boon.khai.ng@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vQssQX0yv2kTM/ep"
Content-Disposition: inline
In-Reply-To: <20250826030505.24964-1-boon.khai.ng@altera.com>
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


--vQssQX0yv2kTM/ep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 11:05:05AM +0800, Boon Khai Ng wrote:

> Add a MAINTAINERS entry for the DesignWare XGMAC network driver to
> ensure future patches are properly routed for review and support.
>=20
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--vQssQX0yv2kTM/ep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaK3hgQAKCRAr4qD1Cr/k
CoygAQDDKHOMwzh8Gup0Y+Sbn5YPmNqNY+SooLdULkoo6dXNqwEA1kAy57O13tBK
PRHckAx5ZLpLM2AU5lNzcVbJp76digs=
=mNZh
-----END PGP SIGNATURE-----

--vQssQX0yv2kTM/ep--
