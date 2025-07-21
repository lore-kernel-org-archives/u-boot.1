Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7271CC83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 16:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCACB8324C;
	Mon, 21 Jul 2025 18:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pp2QSLN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 237848327A; Mon, 21 Jul 2025 18:29:02 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD0A83214
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 18:28:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-41eaf97416eso2394783b6e.0
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 09:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753115338; x=1753720138; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5FkzgchyUA3jI9SO7wbfxK5Eq6JMf7GIsJ8vm5RPod4=;
 b=Pp2QSLN+X/H1Hahxm435XocEx/NMksF6Wgv/fKWJMG6ELXbnTpqUcEXRzV6p7VKUS4
 BDPj0CrtcxEXYqbK0BiPZc2wmb20oPCYdNuDBCNCdqCNRrwvRjVk2ePo9o/a5QU8nPBI
 Nk6ofZm3EPw0o0ZWfXcuq3CmJHcSfTxhYS5f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753115338; x=1753720138;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5FkzgchyUA3jI9SO7wbfxK5Eq6JMf7GIsJ8vm5RPod4=;
 b=AOREQ1qXZT7CntfTIq55/RcF8SCkT+0deORVo2aIxHMWNK4NCnpITIspFSpXn+Glth
 A8QOsYH54JdUQI/66ZQu4b8iNBeTeI1YZyXr2HEwbID+/H14Qa5VxmSnKxbo3CpKOr5T
 pI6ay3BOMGD+RKTLg300Nz9C9/8hbndTK6urXueD+a81q5xpUh4udTMjk8BQLT+wl1hM
 YrCVSHxH9+szqvSIhxy39KhciujHVgh2/v7tsy9RpNaLwSYCOKDfWGHbJxU91iF5dByn
 zJuC9P+cj2IgOdrVHptrPgcuRjEKAXYEQSgfOPCmsZ6WE9kjoVnYhE4Fu9jdtiCe5bKO
 Kadw==
X-Gm-Message-State: AOJu0YxT9/ZRhuVs0u74ijVsUNXmCMdpW9BhsLvUPiMjhb6D9jf6P9S9
 AtkLD92xgFGhg28sOKCWTx23FKj6+XgIry9CDP/nwUhPIrQRG4bAVk80Dq4raUBoxR5UZuRm55l
 XRv5Z4Nw=
X-Gm-Gg: ASbGncu1PQMilXHar/H64d4XrgaDgbQdEpfkatZPKivGXyQRSWvkl1nJ6pd0pXm8oDv
 8TzMSZhHSVbbnuFUSw1zEsqV8yHd6XJNyKmlkmc5J1XgGhVNbRI7PP7Pwiz/78Ykp+EPs18kv7P
 b7T36Xi6ONITkfp66MYoUJ/VYV4DyMGDwT42HrRFve67NjwfmfePpTkr5MeNY9i332wRontTCW6
 QCKMJPLQzqcPaQ2MDYl1bVd7IbVC7PcdPC705dcaJ5hahgPZx87GVsyAgwuU5BjRVCOzO8G3qyx
 a9Y+rdTwRHhgnjIAxLAsuliTr+pTOmboORK0V5h8GBum62LpQNnn9Rk9PjYERwXlFdehWpiN7uh
 Pc7nnchGnDpQq6vrGse7g90AaFyFRv1X7Xw465khuN8ybI1e7gRFVSUK1
X-Google-Smtp-Source: AGHT+IHE79hraP5qCTolg8XnJEWP2+Rt4zH5qNXbhZDj11DZXz7tKzmFXJAS5vnsh3GBc2uCvHnOaA==
X-Received: by 2002:a05:6808:250a:b0:41c:9719:479a with SMTP id
 5614622812f47-41d04e8cac4mr15879919b6e.30.1753115338349; 
 Mon, 21 Jul 2025 09:28:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-41fd565d35csm2614782b6e.40.2025.07.21.09.28.57
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 09:28:57 -0700 (PDT)
Date: Mon, 21 Jul 2025 10:28:55 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: PGP key update
Message-ID: <20250721162855.GF193579@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="chAAIPygmBnQ/HPJ"
Content-Disposition: inline
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


--chAAIPygmBnQ/HPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

As my current PGP key is set to expire August 1st, 2025, I've uploaded a
new PGP key to keys.openpgp.org and it can be downloaded at:
https://keys.openpgp.org/vks/v1/by-fingerprint/F3CEA8743D60E0192F9B4C7A2BE2=
A0F50ABFE40A

And it is also directly:
-----BEGIN PGP PUBLIC KEY BLOCK-----

mDMEaH5oTRYJKwYBBAHaRw8BAQdA18301v5FNSVds7WVopJ4ekpR0S+AY61nVav/
VF1hh8+0IFRob21hcyBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+iJkEExYKAEEW
IQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaH5oTQIbAwUJBaOagAULCQgHAgIiAgYV
CgkICwIEFgIDAQIeBwIXgAAKCRAr4qD1Cr/kCkgdAP9c/73P+3pMozxS+EIeLXNe
clCNeJZL4AcqND8DPyZhpgD/esYQqJgmQDsCvYvH3T2QcGPAIYf2Pg4m8qKGMyg0
WgWJAbMEEAEKAB0WIQQaPH9w4I+rFweAm78UfDn/ljS3LAUCaH5pfAAKCRAUfDn/
ljS3LPxgDACg9KLwZG90uc+p2CYdp0rpdcSUoLnx0PTBmUpPoektxo4g7i4FSOcU
SwEe2rZfNYouS01kqvPXyk1F5NZ3h85fnX3tv7h6W7qSlRM/TojAvrIhk+IMcEu+
qf6nVfCwPLGH0xNVilMN8biF49ST0IDgl1CMVRKT3o5y7OFd6gMwYf2jV4wJxLdw
Xoyz7A6TeFVaaXA8KeFF2qB21pNLA9Z1LiOZXvwdwbQFdNt40+TYL7M3MTEADnsV
3OXB9CGYmHrynpOSx4UXbM4DLJgcB5JV3chBoo5+oM6C38NLu5oncM2rKFvwXa52
AKZ4PvN7WgaQeKhJ3eod8OLXmdXWGertGyoNRYYbUCLgIPIg2Hq55hu9LIatSFgB
fdsFxYZMTUkwAB5EQn34afP0KoHMgmifW82Qv3eAJI7nR88pLjqT0VgNsM83kttm
cSj99wO3zyGz16OWCXTgg56PeJRuCivPi6OGThARGUSV2OZMYNPygCX1QsCGZIwO
JqIiqTkG/Mi4OARofmhNEgorBgEEAZdVAQUBAQdAB4oWETud72ovPGZXArCtneYl
KF44NAxR2rtb120fJGwDAQgHiH4EGBYKACYWIQTzzqh0PWDgGS+bTHor4qD1Cr/k
CgUCaH5oTQIbDAUJBaOagAAKCRAr4qD1Cr/kCqmOAQDFP/Gpm3T3Te3pcZyBOqWB
Ozg2gOLy27t3bYDPI58jUAD/a03zFbdIoGQeqe/5IQeVisXoxWxP0/UokNH4wfQx
ywQ=3D
=3D4xwD
-----END PGP PUBLIC KEY BLOCK-----

This key has been signed with my old key and I'll reply to this message
and sign with the new key shortly.

--=20
Tom

--chAAIPygmBnQ/HPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh+ascACgkQFHw5/5Y0
tyyzngwAnxECyTe8CNuED9pqOsg3bM1web1kkMJ039LU0ZUTfASqVatkoELgbLpL
kDTziIgkoC5VdOLBo2ixCHFaV8xCJaL8vrmKGZ0EYOaHKLadedn0t0f3bY4jz2Jq
hKH5suBy9UProO4AFZOcpa3bFFAf7LsnfMXRA1HhytwREBIm0oOdaJ6ZDFf13v6h
APKf6NoelMSOY0B4/qlDzFgHlPI4Fde86YCfYCXx7bdaM20KTlhBHLF/swZmd7qM
kyrL7aO7djmTb4fK+tZiroN6d4CT3ygOUuSVP5Y6IkH/Gj1vNRi/Iv0N7GXssj/l
oinZWH8i/Td5lGP+zj2n/k7PedrZ9NC/X3BwQMJsb0Dfw4Oibw9aPgpAYoB9zf8m
7qm4xZmzh0iUj7C2zsSuzNFUIu6F4FIEdfoOOBx85ko0ew7C7LZiHpdwoM0uGhPU
LwRow8eHd74/1Eq50759Y3YVjwCJvfc1JCi4euaFyfd5ue4Kd5uOp1p+M24y8Qdy
QPIlOFhk
=yHSn
-----END PGP SIGNATURE-----

--chAAIPygmBnQ/HPJ--
