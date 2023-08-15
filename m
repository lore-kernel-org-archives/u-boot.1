Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F4BC001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAEAF869B3;
	Tue, 15 Aug 2023 16:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DvBsJmFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37507869B3; Tue, 15 Aug 2023 16:43:29 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73F68867F0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-58c4f61ca12so15518177b3.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692110605; x=1692715405;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=42dIPYs6QipHDW3LI9Ifu3Pzj63JFOpat/5D+BFuUKc=;
 b=DvBsJmFIQkX1XS35pM2amZJb/LPm/JAUQaEWTrxSZ8/oRp+qGnp/lIhRZu+4jRA4Vy
 Ps1S6ufxqsBy2uNVXhyAw/kXbzfMWZepUDjwjV4MG6nWAgO6nvvPjQS2H3ycCbM4F4c/
 GxE8QlctELRduQHcexsbers5gbotk3vvSf878=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110605; x=1692715405;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42dIPYs6QipHDW3LI9Ifu3Pzj63JFOpat/5D+BFuUKc=;
 b=daaBBVnd26Z0s2XkhRfBH9kr/BNXwezUv+rnISwYoZQPWL/+5aBPwb/+cXes6RU78T
 GH/zk6IjbxlgX3dT5NX1vXcvEqr2Jke9O19FFa0eRUfkt6KF5K49YrR5J/bo+iYHq2si
 pmLDWHL6EJR03GBIbDay2yAU/bIhk5LgLs/8q9cdCgsz7k40v/JXqQpnG/jSsA1DPDhl
 BFPDHrUUguh/TcfP/iTcOIzrxhWikUGBrdE3tbFUpzZzUWTwtetUDH6tkTJsUbVAs5jp
 t3C2/pYWQC6ZtuGVaTmsWHPWvf6FxLFnPJ9hEAHrg70n1f0p9sevpQarqyNarkpDT+rw
 Aqzg==
X-Gm-Message-State: AOJu0YzgqSCfiZUd5C6EG1JvfOQkxm0zZfZx3mNJDCN4EA4/oa2n47qx
 DChiiOWfJLL1ll96fjNUgePkww==
X-Google-Smtp-Source: AGHT+IHRxqh6xDTDVddrNpTZwPz0ECJlBG7g94O8uTN8Eyy9uxFyxECGFmPThJwDQeKjAVJgueJjMw==
X-Received: by 2002:a0d:ccc8:0:b0:57a:f72:ebf8 with SMTP id
 o191-20020a0dccc8000000b0057a0f72ebf8mr15591168ywd.28.1692110605289; 
 Tue, 15 Aug 2023 07:43:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 ey15-20020a05690c300f00b005837b48d16csm3401360ywb.84.2023.08.15.07.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:43:24 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:43:22 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] configs: enable SEMIHOSTING on qemu_arm64_defconfig
Message-ID: <20230815144322.GS3630934@bill-the-cat>
References: <20230731200121.38095-1-heinrich.schuchardt@canonical.com>
 <20230731200121.38095-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I5HEASj4zqE2kMxl"
Content-Disposition: inline
In-Reply-To: <20230731200121.38095-2-heinrich.schuchardt@canonical.com>
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


--I5HEASj4zqE2kMxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 10:01:20PM +0200, Heinrich Schuchardt wrote:

> We need a platform on which we can test our semihosting code.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Sean Anderson <sean.anderson@seco.com>

Applied to u-boot/next, thanks!

--=20
Tom

--I5HEASj4zqE2kMxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbjwoACgkQFHw5/5Y0
tyxn3gv/Rs1yiIbA1Z5fnqjwRyYB50r8Mmbkn9CY3oqX/3Ztx1zKU+3li/T054vi
oR6wXZpOkp3MLMzrEbwYEDeYPZ3y/CGAOIaZthlwF3ZHz/TAFZesyRpoPnsLX/jz
IL153LeQp+j+GBG7xqcub869gOfZolYHufTZ9lF6blrcgvNOBI/s2+z80WoTcQMs
jvvK8Uwt1KC/LYOogDkFmqjfsgHowe+fi1t6Ls6puQP4ND3upshjMnCiSHax0SI2
Hp3ECMOaobFdONIDva4YOr6aZI5lp+HFuAXbErKyZAEBpqV3ur+P3qVlnHsGNU6d
6pAbLlt+NVKRdRamHGbJxaAtwc6t87CjlGbZoyTrsnxk2nna38qHjJIUTKHqTDLM
6VA8ySOHYgJ4BluGSzv9vJTTRoowihiBk9aunOPh/ZIDbIJs24oE1hGWrZeuT7/Y
zx9O0i/49kJTY+89U9+Tn98x2iJeK9kct4ld9PQlLNCzPqLg+r1V8UHNbyNJ0cfV
0dnZ38tF
=w8bV
-----END PGP SIGNATURE-----

--I5HEASj4zqE2kMxl--
