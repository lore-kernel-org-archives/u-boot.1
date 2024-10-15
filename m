Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A84D20682
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 22:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E64D889EF;
	Wed, 16 Oct 2024 00:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f48QqR+n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ACA0889EF; Wed, 16 Oct 2024 00:54:07 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92FBE87F19
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 00:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6c5ab2de184so37443456d6.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729032844; x=1729637644; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TTxJljfO2kE5j9MxkVv934x4Is1w6OCqMpXb5HSLgWU=;
 b=f48QqR+nv8p6+2Cpq38ZlB9pIcJoAm6n7DX/WtciMbeCOjhr36zlP/bHLUdr9TTnkk
 yrnaE6EhzIl7jXkQADwlgEe1PrLELUuuc3FVxwljdZ3JXombWrQpMWsyHTGuhEVoSo29
 Ozm1FSE0JQ/h6oBQd4WBusfzORR5LmO0LG9zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729032844; x=1729637644;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTxJljfO2kE5j9MxkVv934x4Is1w6OCqMpXb5HSLgWU=;
 b=OBBBREc/WX0bonLyUMRjE7BTiTyVRkgmOsROXFnJcDEi6knkGtQxKQTIeQbxiCRaoe
 ojZYALKVHfMkk0aIjOiA46sRiCHssvDUGQC0YFOOJNVGuytKi08xW4yHxYE67xYFQJcv
 r4Phee9UhKg/PnpmcIE9hBKesoRIo8GhphD/3lSpnn4s9T1X2Fl/Dk6D3GSHX6X01bu7
 ACLaclMGgAcTI/hP68VmIyfbbQKs4eIBT7ERxgIOXNA2V8ajOoPShk8ZR7yrX7Nlt5as
 y4eSFSqmMlfJaDEMswVCKeCDfOSX47OVO7UZOUOJ4tgI0Zs/F7ynbcb++SkCZ+APMKVD
 H3aQ==
X-Gm-Message-State: AOJu0Yz/2UkAUKhdTv6jsGT0T7OXWhfSU0WHEAAgQgUFNn4IyqyD/zRk
 Mak7K4y+JPNLNnXJYWwKrsB4rrtm1Ed/kWed6nYF7KCJMKfWli+ZEuxLbSWi67dqY72xIA4pj2n
 auQI=
X-Google-Smtp-Source: AGHT+IEkcBe5B2O+6kc6i/XxsXaeVKlqIoaoUvmRqS2ylAZW7/dSWckufZmiUzaGr56lCAeDFv1Jeg==
X-Received: by 2002:ad4:42c5:0:b0:6cb:f7dd:b6a8 with SMTP id
 6a1803df08f44-6cbf7ddb70amr197856676d6.26.1729032844437; 
 Tue, 15 Oct 2024 15:54:04 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc22990968sm11408356d6.139.2024.10.15.15.54.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 15:54:03 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:54:00 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] CI: Do not test "sleep" in QEMU
Message-ID: <20241015225400.GB6412@bill-the-cat>
References: <20241015182934.353099-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="giutu/qmvNegw7TG"
Content-Disposition: inline
In-Reply-To: <20241015182934.353099-1-trini@konsulko.com>
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


--giutu/qmvNegw7TG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 12:29:34PM -0600, Tom Rini wrote:

> When we have platforms being emulated by QEMU we cannot rely on the
> "sleep" command running for the expected wall-clock amount of time. Even
> with our current allowance for deviation from expected time, it will
> still fail from time to time. Exclude the sleep test here.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--giutu/qmvNegw7TG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcO8ogACgkQFHw5/5Y0
tyx0dAwAmojHzYHTO5Mdg6rvZWJiGMotrMxKnwZuqofQVdqZqDfIGBSZyksjOrAr
Yl0xg6jVWsQ4sGFHOslWwgoVVpl5O35oMUVtfqDFMkhIhL7Fz+5KJCQzujR8UYmt
bbpBOiZAS1zlhIFQ2nveTdENGKKHKuMrf0kTpT/vJEYU92Q8ZJAjvWW2T9Q2p9vC
eHq9pcLu96lFdXvLJGfWK9tWHb3u95+K+rXlyUbr9UMGLWel1gljvWKUj53rR5Ln
ME+4aWzBI14RTXAXAzb9stqslUD8/5EuFW/AJ1+FVoKsaLKvqd4TX7VXH877w7N2
HCQPtQshO6LodCZWPW4+ROOjsg+qNO1FuN4Vy0LfyWvdk85BTc5Xeho1p5FeCpEj
sA2qwmzlEqUl9EeS3x8wuHDOjuM2juN8O9h4/jK7uiPHpKNKvfW+hctzeB4MGjYF
G2AyrUhQHlaNHu/6Brp4dALgNga5+p5e7182o+szx0mTQ4zJX1Nftcf1UlH79Gk3
H9prPA5X
=3sqz
-----END PGP SIGNATURE-----

--giutu/qmvNegw7TG--
