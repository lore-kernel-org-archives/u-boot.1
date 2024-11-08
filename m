Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E3CD64064
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 16:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C5F891FE;
	Fri,  8 Nov 2024 17:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zqh6VdWv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B8888900E; Fri,  8 Nov 2024 17:51:13 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 531B588B0B
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 17:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cacb76e924so3413549a12.0
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 08:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731084671; x=1731689471; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BBX55xOZPJEkcYK0yt8NiNbN3qUfo6/zcgDWyx9Yipk=;
 b=Zqh6VdWvZh4yIV/TETgWSEjWNBR7eNgT3hz73+bfcO2aedf2JKitYEBgDcjYj61MdX
 5hC/feQo7ubS+O8emKhI9SBHzxyXlxmhj9azENSYV+LDHZi2/axN+UNseioP8+hxiN/g
 R5+HLxDsuzCUah9rYEptJbabrbtqEweGy919g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731084671; x=1731689471;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBX55xOZPJEkcYK0yt8NiNbN3qUfo6/zcgDWyx9Yipk=;
 b=KgSr6IcMcAmOoOaKOQkh+lS6SJWsuzIlv0L6MYimzy7kQ9TaoeE7ZZfNJD+t87L9SN
 SdeEkuQrSt0J+obCjW68FR9FKizVWNWcC8XGTJ5BObrqldbC2j+eMAoF37WJcKBai6oj
 Se2syogF60JDu4foIO/pQ8O45s2Ua4jPadBgr/wEHYGug+jUK+dMgGjSJkhMqALZPeEW
 fRVI4BQkNvmLmn6RFM8rpzysHmFvHpMJZflaWF0IzKJi8XkqT7BbGhhRJcGxK/cpT9fr
 8EBQuhOLZxj98ZfgxHQIrx1LlD9v1D0wTQ9PeHTbXJ5fvoFCHGGVjOiUwQkpIS6dkVFP
 VOeA==
X-Gm-Message-State: AOJu0Yy8VyR8Em8x9iWIN6LdvD1u+QdQ8sFm6Auk+L2BdcVhMG8N1llq
 lkvvIG1NC6h1Zrg42gVl7tpvVPIZRfBT+PzUsnBuHSwjotej/si7AYNOdcrumWDUXmI8VYgT+1o
 xSB8=
X-Google-Smtp-Source: AGHT+IE1IZFtE76i8k6FXKNTaSZ7sMDoUm6kG2UD7TNOHSZW0IS3FTCODWWKfx9sVW7YydYXbFmq2Q==
X-Received: by 2002:a17:907:6d24:b0:a9a:9df:5581 with SMTP id
 a640c23a62f3a-a9eeffeee58mr332479166b.38.1731084670804; 
 Fri, 08 Nov 2024 08:51:10 -0800 (PST)
Received: from oliver.lan ([23.155.80.164]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0def026sm254154666b.163.2024.11.08.08.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 08:51:09 -0800 (PST)
Date: Fri, 8 Nov 2024 10:51:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20241108165105.GA38525@oliver.lan>
References: <ZytdFmEgu6DgeRRf@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1RObwvc1TWiUxMWI"
Content-Disposition: inline
In-Reply-To: <ZytdFmEgu6DgeRRf@swlinux02>
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


--1RObwvc1TWiUxMWI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024 at 08:12:06PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 56accc56b9aab87ef4809ccc588e1257969cd2=
71:
>=20
>   bios_emulator: fix first argument of pci_{read,write}_config_* function=
 calls (2024-11-04 18:01:58 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to d5f5e778183d5908caa2954b9438614252b806dd:
>=20
>   riscv: Introduce configuration for 64bit version Microblaze V (2024-11-=
06 19:42:54 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/23239

Applied to u-boot/master, thanks!

--=20
Tom

--1RObwvc1TWiUxMWI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcuQXIACgkQFHw5/5Y0
tyzlMAwArI3C1ha4f9UlQ+MsnqNAvLhhtqBhvb5zsjmqlktRN3waBuI82PqJyFkg
6XyB08cy6ch8Fh+LIN084Jpq8kVQMbSjhWYjSozdFWvvCTjuvUC6YGXqBwMQ7Rrs
GokgPyeGV8IoAK2mcDd5DqDd1pRcyZssL0P/9Z1l7h90MulSgy1ZNryKhYPjJZJC
oLb8xLo/kmzi40/dEv31UyD5f8N5RZLIpogRu0UItcLVN8HFteo81zy/mc6AmDDj
5XKRXtJ16fudFIwpdxGXNlc8C1QASiu9qeY4fUOB2C/bqZqGrGshUyQv1nmKTKdA
7eeUmc8Frzy+ZWvUBRMkxynD82lLDka6J3rKxDujemqn+uWwZtszhBCm1kXl+BJy
6Ea02BomOJqaNEx/Y3+AyKYzq0F9s3/xlmJWvXTgHX78ORTEdMMnFmsYonRkSc6I
RnHhfcFefN1o+vJ8MvLOwKwN2q8rhSWpoanKSK/WHuI/1Ke4F8eRu8ADqkGu4fWZ
GQ06ockY
=pMzV
-----END PGP SIGNATURE-----

--1RObwvc1TWiUxMWI--
