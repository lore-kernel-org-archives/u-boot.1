Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D4DCCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 13:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3456683826;
	Fri, 17 Oct 2025 15:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E3ABFQYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 562C783829; Fri, 17 Oct 2025 15:58:08 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE2D83734
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 15:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-43f67a9ba58so510908b6e.3
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760709484; x=1761314284; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fNwPVUi4OBrqKqY8408KeP116BWszbhHor1d5/G6Xkk=;
 b=E3ABFQYZNx9B5MW71scarcIQfUubLfHHOY5uFmKCzos+oaW2pDyaTgfgC/1k7XRNuA
 R6nRHvgkksS9ukkVC2oCKLTHKRKj8sailpcr8p6p9By9tMUq9ZLX/AzCWekHgB159mQf
 0+fTVJ9eCTbBjFgDKT+aoUyWgIcAEw2qVzGv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760709484; x=1761314284;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNwPVUi4OBrqKqY8408KeP116BWszbhHor1d5/G6Xkk=;
 b=FtZWGCvTxR6MPuEW2/nrFEulTjs9lNOQEHj40UE5lF1gNXjgvBwiMarX3eP1q2N0yu
 f/J+9O/5bu+T5fcKAkwQjodXlLd12xjnqVNtmjPXzGMrtIPabO/VRX9UpmyjA8x4cdD/
 SaoBaZ1Hb9H3IznVGoQXIgjJHCfMQhjYwCiRZShHeR8/gYwErXwqBtI8RBZt8I0NpJMK
 6PVbCmu/cUqGnNRqIbwq5cHNWoVxvw0dwDGNybswKkep99oDMxz99IpS03jWNpi4N40E
 llb1GksRsywuUSb+XBtLQpiZHdDOGxo9d0D+i2BxX8bvv5GK3VevCkMmRyiAf97VaDkM
 mb/Q==
X-Gm-Message-State: AOJu0Yxr1BsUDlxN+8VTQBYm2A3wStf8Rt9e/Cmen1VnCRnl3E3Y4+WF
 upMl3+7B5uVmxTMSgsVxz+PuvMuoxGMoW0weQR3tGXjd1SxCCaFzpU36w0z4MJpTGhQ=
X-Gm-Gg: ASbGncsZaXLEc8NhBZQKBMqRdc0xh7iaVTu+BLQiqe4CtWqqAdj3IEg6TCXmJG4YptJ
 c+9RJEUU885wk9ILRG6Q8X5AhyROYEbjojpiZfQfQqnSCbv89RSb684Jzw0FTk5o2wccY6iw466
 4KD2PolmlXPc9CFIHgppk7Txr7TR6kAi2jUQxu1YIVugqtR281nNTdDmdG+IX6Pw/U9SD0lWRYE
 RwStZ1RrMjjVM/OCyZfP+0IfRqFBP3qJIhbX/bxIEcgJk6ETp3/49jSyTP0F5dEQZ/hLEG6xjqs
 IcdI+EOdU63urzkEEJ0ztjzxGQejIhd5SDZb7lxKwlOuHLRxXRhY0OVeIPyQdEFfzu6LndJwZ5V
 M94228Jh68A1uJajl1RQBzROkyjBzbjyrkjakC17Zx7Fon99H6G3zDaCPTNghbrEjFrAExZwG1/
 ZWLhAR/8L7u2jpQC5sNhjZmPzkSruaXgoa8SXW9rkWXINy6HTgzQ==
X-Google-Smtp-Source: AGHT+IHSXW9a3yk7D5vkEe7RgXrBwnxtkyFulqq5URYBVN9dmMN+dz4cjeiRPAMWGPQ8agm+FStuvQ==
X-Received: by 2002:a05:6808:1a17:b0:441:8f74:f47 with SMTP id
 5614622812f47-443a31ba620mr1741503b6e.65.1760709484194; 
 Fri, 17 Oct 2025 06:58:04 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-650181577absm5295726eaf.9.2025.10.17.06.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 06:58:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 07:58:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH v1] env: Kconfig: disable external env in secure os boot
Message-ID: <20251017135800.GD6688@bill-the-cat>
References: <20251009123435.960225-1-anshuld@ti.com>
 <176065245424.262817.8921064566527287297.b4-ty@konsulko.com>
 <DDKAOHK5MOPF.26P0O31MCY1DV@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nxtTNK0eL2krlQxD"
Content-Disposition: inline
In-Reply-To: <DDKAOHK5MOPF.26P0O31MCY1DV@ti.com>
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


--nxtTNK0eL2krlQxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 09:28:58AM +0530, Anshul Dalal wrote:
> On Fri Oct 17, 2025 at 3:37 AM IST, Tom Rini wrote:
> > On Thu, 09 Oct 2025 18:04:34 +0530, Anshul Dalal wrote:
> >
> >> Falcon mode uses falcon_image_file from the env during mmc fs boot, but
> >> external env can be compromised. Therefore disable access to external
> >> env by setting SPL_ENV_IS_NOWHERE when SPL_OS_BOOT_SECURE is set.
> >>=20
> >>=20
> >
> > Applied to u-boot/master, thanks!
> >
> > [1/1] env: Kconfig: disable external env in secure os boot
> >       commit: 1e470ddd0743bbd1f229421e11e9ad2093f7fd20
>=20
> Hi Tom,
>=20
> Unfortunately the patch this depends on[1] has not been merged yet.
> Essentially as master stands now, we are disabling env based on
> SPL_OS_BOOT_SECURE even though that config isn't defined anywhere.
>=20
> I'm working on addressing your comments[2] on my last series disabling
> fallback in falcon mode and will duly post a revision, in the meantime
> could we just merge the [1/7] of that series and I'll remove it form the
> rest of the series in the revision?

So, whoops. However, in Kconfig evaluation of "depends on
!DOES_NOT_EXIST" is true, so there's no functional breakage here.

--=20
Tom

--nxtTNK0eL2krlQxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPJLYgAKCRAr4qD1Cr/k
CqJaAQDOJHiL04/Md8QxwbKYMk7tpL25yss4Z7vAbdMhGilmzQEAnv9FimDGMvFf
goR7kxxbZhuHM0qnctDxEdzLxo5FGQw=
=OnmW
-----END PGP SIGNATURE-----

--nxtTNK0eL2krlQxD--
