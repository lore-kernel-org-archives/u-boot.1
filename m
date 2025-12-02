Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A5BD12668
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 19:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BD8083EAE;
	Tue,  2 Dec 2025 20:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qm/vDwv6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0935983EE4; Tue,  2 Dec 2025 20:30:20 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DD9883C01
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 20:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-656b32a0cc4so1016296eaf.1
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 11:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764703816; x=1765308616; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=72ahj6orCWF2SIIYuCpTDy3TR84cHGzHqO3LyRzuDDw=;
 b=Qm/vDwv6KOFkwGerTgZvklvjKh191penNreFTtqoBWbqUOChpEXjowjiHYxUpPpBCQ
 9mSJHl+eQRuiNgZkmYr2UOF4uuB38/VGCNHVYXZ2C02yoEVfrfWcg1MfTpKdUMhJglq7
 9d3AqDoL4QOf9uFHCPD1AEKWN4By+tfG1K6rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764703816; x=1765308616;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72ahj6orCWF2SIIYuCpTDy3TR84cHGzHqO3LyRzuDDw=;
 b=nZpAidcx7WmGIec21IL2OB/V5+dShuGpz90W2RQSJtIPzDJRGnKMacmhMOhqxLPenw
 mRGqzx6gikMFl0erZdQbXld6PJKiYLdchUKNlRAfiAjEBYeCyJ42Aciis/VrnaP5JLc6
 uedZNkM0ptqKH/IGCkq3HLWWAU1C2sRWOQHSo9rrRH0PFQ5pPFG4dAGRB/JJGT5ZJkOV
 J8pPObrVmFB+EZvTSi0Bp7O9jVMGhqOcwn3M+lzn/SVuyg12uTp8HMNxAqei5Dap9uXP
 mHwBZb/ZsfpmAcGhZ92r4qSJ8PxWBiZtJ5vc0CBKcDwBeCDbvu1ej5p0Sgd3aD0UbKRB
 oZPg==
X-Gm-Message-State: AOJu0YxNDbymUTT6Z5JRu12z3qhO0EDzdxrIXiOd2x5kp/clzaueUpzs
 J55zLRSJtBlQyZkaeyBUf5SDeihgtzYfVsAZ8AMD3dYoS4BvfqzBFHk/Be6mYpqsRX/5oNX6vAx
 Z2SUWrLo=
X-Gm-Gg: ASbGncvrnt+EEeQKDaVp8+ysMQngDaYLEVI8VciJu/z/xNpl+khiqTFjF1gbaZ0E96V
 AfWRc0rMx6jLRS/CLcbo67aPHmGVlOmjgOFkBWKGUJj/kDzfhAMiIEwDuzBXoRs+cG6XYVcgD79
 kMZghmUcrh82aNLYRkBMjQR5P68pTsdhAvC44pckmKqxAjDulv/c7kzKzvBSDOgv8RgIAW3Nck7
 pFxUys7X7ca3hCKXO8k3O0a/0L5p+rAtr5/DNy9kCXhcvtGVNPt89mHfWrkMkoMPVKZ4Z4GMxtM
 wHmwffReJqcg2KYndBhx9iQNCPS51rnJU1pd+L7gFb8Oj6wlbmS52zJ7WkKKX5GM+We0z/pVMz6
 P3Xk7TsBL4y49VL0/xsx7yLlmoGdvxu507F7d6rvZsrsRblgS8Xi7laL/FEJzLG3FxxfuiMGqzk
 Mw+SJCkdXvxeREtR9gdPaSWACnzl/h4TkTsHId13ewhzC3FZCz5g==
X-Google-Smtp-Source: AGHT+IHABqNssyp8a9fGPnTnaVnoqxW1hPCl0zJSozepTyvxQl2FHIaL0N3WxWErnxAO7l2oiExmEA==
X-Received: by 2002:a05:6820:1c91:b0:657:6f7c:e5de with SMTP id
 006d021491bc7-65790bac705mr15559937eaf.5.1764703815782; 
 Tue, 02 Dec 2025 11:30:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65933cc3f57sm4509856eaf.10.2025.12.02.11.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 11:30:15 -0800 (PST)
Date: Tue, 2 Dec 2025 13:30:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
Subject: Re: please pull u-boot-samsung master
Message-ID: <20251202193013.GH303283@bill-the-cat>
References: <CGME20251202065932epcas1p317a2fa75a3b16a4984a0c0bdf0515b5a@epcas1p3.samsung.com>
 <0cdd01dc6359$36177b60$a2467220$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F/rmigGaf8LsInyT"
Content-Disposition: inline
In-Reply-To: <0cdd01dc6359$36177b60$a2467220$@samsung.com>
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


--F/rmigGaf8LsInyT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 03:59:32PM +0900, Minkyu Kang wrote:

> Dear Tom,
>=20
> The following changes since commit caa740df9cae5ddc74b18b88a4fea43e27b2fd=
f6:
>=20
>   Gitlab: Optimize the job dependency list more (2025-11-11 11:55:16 -060=
0)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-samsung.git master
>=20
> for you to fetch changes up to 422b15bb5b693376e345d3f32d7cec4588f3bfba:
>=20
>   doc: samsung: exynos-mobile: add documentation for exynos7870 (2025-12-=
02
> 13:38:28 +0900)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--F/rmigGaf8LsInyT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS8+QQAKCRAr4qD1Cr/k
CufQAP9DrN2mock1Sk+8GjbfkgotilhmJOPwFllAGdpbiuEgZAD+LJubxsNOX/fy
4TXFUUSFHrUvE6MS/UebcM46Clb60wY=
=3j3T
-----END PGP SIGNATURE-----

--F/rmigGaf8LsInyT--
