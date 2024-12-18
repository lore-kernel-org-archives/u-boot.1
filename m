Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF047E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 17:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 610128036E;
	Wed, 18 Dec 2024 18:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ptPngnfo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E2E80312; Wed, 18 Dec 2024 18:40:23 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF30680274
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b85d5cc39eso197969485a.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 09:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734543620; x=1735148420; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lJxotYAkGxB9d5Wpv3i7EZn8YsNkVGhF2KpCGhv3xTs=;
 b=ptPngnfoaQ5y4iJ2oYp5g8YbVO6y3OJtX2ZlUqI/oMcrzwQy7+hJUWRwS449ZvFv9M
 NAtqaRCCF+4oyHCMKUgpbNPPvMNSgwUiJEfrf45jlzEF3hPFHMZSFsbNBeGywwkpkE48
 EffJ+hXRZl7gtBDXoJL+UbpvbZnpq3rkSX1fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734543620; x=1735148420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJxotYAkGxB9d5Wpv3i7EZn8YsNkVGhF2KpCGhv3xTs=;
 b=oCMzMqEYW9OJTRYK9vitmSy+9ocGEMMZSsD2RXwV6lqdF2dpqRoy0fkfCRK1sMXZBV
 70ZaEVgGOvsmjyAF4D7Una62/yn94CW1t5l0usgbkJ1cCuJ7/ifYiirp2QsdGbktPNyz
 jhvB4/6+TGwsFsvztjBy758GlvEAIRNprQCrm3gSXHzpJDhdAYl6MKnnSEPOQT27NC9i
 CkcrSaZ4q6+47hM6wWBH4YC4E7+yeg4Yth8KeiCrVvSLUzg6xTE+VQgcMbmD1KU4mueC
 ZKECZVLhUNT7z7laZcd28ApZrn4ri9W/Ssq2g45V8ATE/I5ErI/6pECQfUuwWk2vDS8O
 kA9w==
X-Gm-Message-State: AOJu0Yyl4bqJjCeEe8tHvLBwReWsn0a7T8VpgvysNNiUJ/UtbhvO7CH5
 XIweNG0AsYTvn/35WBJCr/UcXb4g/MBeSpDWPSVd/4dL5+JRmxkZa1Nv/DUo4GpWPbndnA9r8US
 6
X-Gm-Gg: ASbGncsrX9Rm//D8yqAnArpscimBy7K+JVE9kc0RVM5nl9LE+Ynu/PXUGIjgg5oOXVy
 ikAAkqGCt2XGTwq0gT9GKOghlLSaJPHgM7AmAi8M0XRNjapTR+L1uVMtmiMH7M3UpIhOdY6Y1K4
 7lUFAgLai4zmpvAMeN6yyIIAQPoFJFrfRIFanN95uaVtuxOVUQBrLPTa3/k51b7kJSpn3tiHKhk
 4UjcMrfr7FbGGSOXKc3f42+WnHlHL4GiHfoHyIpzcuMSNFBNqdKfHf4
X-Google-Smtp-Source: AGHT+IFMr423vrXxaBMX0Jn9FdwRLPxfDWqXZDsMj4OolEYzlk7XXYCjv6OEnzR+f4ObxoMm0iPxvw==
X-Received: by 2002:a05:620a:2a02:b0:7b6:f1be:4f7e with SMTP id
 af79cd13be357-7b9aa8f41b9mr25039785a.26.1734543619794; 
 Wed, 18 Dec 2024 09:40:19 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048caa1esm447689885a.119.2024.12.18.09.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 09:40:19 -0800 (PST)
Date: Wed, 18 Dec 2024 11:40:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/next
Message-ID: <20241218174016.GN1505244@bill-the-cat>
References: <Z2J-mMspCN0ZWjx3@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dCjsCJC8fpb7VNiw"
Content-Disposition: inline
In-Reply-To: <Z2J-mMspCN0ZWjx3@swlinux02>
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


--dCjsCJC8fpb7VNiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 03:49:44PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 3b3c7280b82b1f08807a070ac066cd02919dfd=
e1:
>=20
>   smbios: address build warning (2024-12-15 11:41:32 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
>=20
> for you to fetch changes up to e59241f8b1315168b7a8a2645c3d3fe73ea5d6d9:
>=20
>   riscv: spl: add FIT name for RISC-V Falcon mode (2024-12-18 13:19:16 +0=
800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/23926

Applied to u-boot/next, thanks!

--=20
Tom

--dCjsCJC8fpb7VNiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdjCQAACgkQFHw5/5Y0
tyzXZgv9EhN1wDMzm0K/ickMXdUS0OLz+hQRQbBEpBO2cMjGBO8wlrTdx22n5NOp
454c5umrazuMMJYGF9kDTdJa1FfdmsVTHGhypSUTwbNVkA1Y5uVaKXbltMMWBn/8
y1pfSqyR3HGIOiqzPKDSdTqRMfGzbLDSGGX1ZBFkeUMtG0M6Njsml6w21/MKhCEP
+2kkMPUuuF7J6V32SOI+22rOakVOpjl+srBUxTgFMpRX1mpE5/8RJ5mgZJH14ruh
vANeernIjyb2p1jJFzfvsYaO+9P/FPfIRCWUqMkJGCaXeSuXmrb0R4/U6q1JizyM
IBzvEPLs7dst+qtUuW3qY0l+YAoo0VJ2ZJ/GL/F3m7gX6m/bMNnBS3ULEJckvt7O
DRGHFP2uBt901CVTGLMuU7GSgIqAB6ctaywJ7EQDcyjEOnJd19syLsq+TilCVgRP
sh11QNlUqrG5ZE/fck/nXoed8lpYGCme1VOKLHjgxiK4aAmRJ5FWETalJz5drVBM
YmSAOUiD
=KxcV
-----END PGP SIGNATURE-----

--dCjsCJC8fpb7VNiw--
