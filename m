Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CAAD26D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 17:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC8ED8436C;
	Fri,  9 Jan 2026 18:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="grDp6jBz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C41E84374; Fri,  9 Jan 2026 18:33:57 +0100 (CET)
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com
 [IPv6:2001:4860:4864:20::44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57B4B84206
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 18:33:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-3fe3cc80bc3so2370577fac.0
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 09:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767980034; x=1768584834; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AW7pKTa11HH9f4BPF+9uB7vJtgdJiTLDvTVzh/n1j3I=;
 b=grDp6jBzG/LsoEEFHHXMYenNXb2piUQE+coD8ccPqnyBMULHbXpuST7JWIpesFm+SL
 9HpbjV4ewYWTU1H6wf4vrebm0OsnbXeY50OcP+RAhyRsV7mEiuFZEg/I+JT6a5E7BEcv
 rHyb74qVYbwLJ6n8uVJjFBfhYhyw2Wa1labiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767980034; x=1768584834;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AW7pKTa11HH9f4BPF+9uB7vJtgdJiTLDvTVzh/n1j3I=;
 b=pX1DOpA+TOPCqR0mTFIbU+fiAs65LL3zkm2E/VdZ2UVxtCnJsvh/z96PuXUKd28u/W
 h50pZPaCGCLDDifwabOZm0OFN8MkoDEoxkjjog9+/PytRGkKKzMTBh5z/U/pz3aW0ab3
 MuMQG5Ttof5rhBdjXwgtX42Q90mTJz98b3wdvLPPSIUOOiVBK7cvQIruyRakwDgMJx5e
 uAPelnyi8reP3lFjuNpKQWDZha5grPrI6wMoW3HHeM6oozUlsqzuu6eutgUkTXxvIXTK
 Srre7GJYCNYH6OuWOswtJzpgRpd7jKrP3T2T7yoMYxVRs+LdcP8rPW0NHe6AKKL+hJdt
 Hgig==
X-Gm-Message-State: AOJu0YzJO9TD5FOQNAoqGnx0hLy3ro/qXP/1mSX7Qtojviy8Qj8/9rkA
 uGo2imRLmxwdrJEzFplQ554exZps/s5Nr97P4BgPWaXYvV5EvKi61Tz1/4lbCeTv8bH1SpxbJ+G
 qRpgHse0=
X-Gm-Gg: AY/fxX71IF/MtQYH1T1BpmvKBphQRod8oz6J1xWlHyr69FPIXZSca/W1kgyXibh/c5Z
 gaX/MZkII/S43moOUka5cz10uM80Ard13jqNo5Wc5dG1TskG3BYsZW1nxrWaPoe8qpregz1ItGW
 mWJU677dIPiCDcL16x5nuSjx/CUiG3SJbi2Stvh37RpBHwxXdUdgnmgpqfEfkLbmNWfGyP0wL26
 rUavHXVT8YThTS9/lTRvKxRMkQww7LyHli5b6kNMFcrltk5dqxs8a4Yb+YFCCkG/FjH8i9WbWyR
 C7uwF/W+YD5Z69Du4mqvxkp4Bw4TGjlPdAPJUhoUkK/KRT2CIC8NLz/F97pnoZRL8c1t71m8dRY
 BDv+KcQwNo08m5xe68wa7jvMcwSYz0qSSZv4CTchNMtbRjpQ+AiboUZSW4m+LPs9oO7n0Zd/wjI
 zgd8NTpnM4T04vFKlMPrDbDWG7tGS+yWw1au12ddgCnFTxIefBBDX6FhYIbZClBYyZuQwE+k4w2
 retCOGJZQXSGvUr7MnUnSWxhZHYSZEymm98zNI=
X-Google-Smtp-Source: AGHT+IGdioQnGyGloMMrVJGcvDVSbbxvDH0jSrzX/Pa5/V2yFn6XLbcCf9dcP888MP0Ihp4ifrTv/Q==
X-Received: by 2002:a4a:db8e:0:b0:65d:1636:5432 with SMTP id
 006d021491bc7-65f54f7ea02mr4443104eaf.65.1767980033916; 
 Fri, 09 Jan 2026 09:33:53 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48be5a7esm4358048eaf.6.2026.01.09.09.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 09:33:53 -0800 (PST)
Date: Fri, 9 Jan 2026 11:33:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>,
 asahi@lists.linux.dev
Subject: Re: [PATCH] configs: apple: Enable SMBIOS / sysinfo
Message-ID: <20260109173351.GF3416603@bill-the-cat>
References: <20260109-apple-defconfig-smbios-v1-1-16477009c034@jannau.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+BwhojA++If/QNso"
Content-Disposition: inline
In-Reply-To: <20260109-apple-defconfig-smbios-v1-1-16477009c034@jannau.net>
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


--+BwhojA++If/QNso
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2026 at 06:20:30PM +0100, Janne Grunau wrote:

> Enable verbose SMBIOS table generation so that user space applications
> can use the SMBIOS table to provide details about the system. The
> desired information is chassis-type to determine whether the system is
> laptop.
> Adding the chassis-type property is proposed for the upstream device
> trees in the Linux kernel in [1].
>=20
> Link: https://lore.kernel.org/asahi/20260109-apple-dt-usb-c-atc-dwc3-v1-0=
-ce0e92c1a016@jannau.net/ [1]
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Tom Rini <trini@konsulko.com>

> ---
> I do not plan to update u-boot's in-tree device trees. The Linux device
> trees have almost reached feature parity. The main missing features are
> the USB Type-C ports (on track for next merge window) and the laptop
> keyboards. I think it makes more sense to close the feature gap and
> switch to upstream device trees instead of adding to the in-tree device
> trees.

This sounds like a good plan to me, thanks!

--=20
Tom

--+BwhojA++If/QNso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWE7+wAKCRAr4qD1Cr/k
CqRRAP9JYpq6J6Z7vbK/MERTsjfauX30Gwf+flQwimJ6Dp9XKAD+Mb9WAt75w218
vJde3JpzMz7FFgjkarbHJXoT7MZ2dwI=
=bAb4
-----END PGP SIGNATURE-----

--+BwhojA++If/QNso--
