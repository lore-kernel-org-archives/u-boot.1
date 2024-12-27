Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0972EE7718B
	for <u-boot@archiver.kernel.org>; Fri, 27 Dec 2024 18:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C69B80362;
	Fri, 27 Dec 2024 19:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DEPYA0Hc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A14068036D; Fri, 27 Dec 2024 19:24:29 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D8EA8035E
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 19:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b8618be68bso578384885a.3
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 10:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735323866; x=1735928666; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zoX5Ye1SqK/mJxeGUbFfg1QTN6pxVpXqdS2LwEFW6S8=;
 b=DEPYA0HcPSnGGzt1shDqTbDeZomEz4MWik2sDkaq5NhVHKJ2R7gJeo3NL+tVk/rXBn
 P45DS1u8CjiUfaZdmXLd90rL5LpZj7ZkwK37x/QvMopDs3m1BMue3s3W00qJ9cIyJ5ST
 x4D8Ew+w33Pa1NDLW6BXot1h/HO9Z4ZhnugWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735323866; x=1735928666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zoX5Ye1SqK/mJxeGUbFfg1QTN6pxVpXqdS2LwEFW6S8=;
 b=GokP9FMeyPLbZCHSie/lsB0/qWU0rOSottpT8/LCxOANrL9Dox9ug8uPul9YlSATOP
 DoNxTr9nFEhOWKoeQDHcXpQCGUUBQ/mduQxVfcAUY2rCxvOqtIegaZAdD+xXVWiSC6SB
 95wioKQi/oUzzIxb5qwn+XGoSTL1Bg/unLoc4O+BoDd/G/STlAbRBHdeIsyhEWhJsJ15
 sq5S6mF4HB5nzkJE/3stvjRVvDlC9hWwPssEgGEsSeTSxbywnXXvFUqdaHB7ADzz4Cr6
 Gxl/GxzA5HAm67OGsEWviaYeuMeI3pbcc8Zf1xyS+4BBYqVDz7bLudftvmpQX4ZCoay4
 NH2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkdINOOvPrZsUSW9sNc4D69gikAqjATT3ybXFQXBuyst/wh49P8Lone6ldnkXzgefdvxuWAXU=@lists.denx.de
X-Gm-Message-State: AOJu0YznvlgmzQ5jIB3edvtcgVvT85lYQklWSpWlum7Vh0IBS65WrXqU
 ZiBF64lAJAKnA23Su84MGEXvF2GJ0vUlxZ/8vAWQMAjDVeWE0kvC4PbnqNy+LewynMYZPZmqCyY
 m
X-Gm-Gg: ASbGncv0jeAF2kXtsae6kq053SzR4/jJqqychQaNt3m9eQ59Qp6DZlhL/oV+xS8Vqi0
 yOHkoxjMuE1AM2fCCuhilV4p7QgAdXdgBaJdaaqOE8EfuzE5PCgstq98h2BenThGRpVdr//fcgN
 RQ9/7nuObx45aISOGvOG3pDowxZ7CrqwP3Noz9VPzEBv/zxfD/k+Pgem9WhWfdl0IU8O4XqvxgL
 ib/YtOye6C6MbJYyw5CkyHjKYmUyygwAWpvi78Yzo1+WbGgFoebJd1bbQ==
X-Google-Smtp-Source: AGHT+IH1y8YEKhAZRHD5y4rUB8cnivD030KS6glcrF50RZ+9+AT4k+PeLR+iNOlhK0mIngcG1Kf/Iw==
X-Received: by 2002:a05:620a:4042:b0:7b6:ce6e:2294 with SMTP id
 af79cd13be357-7b9ba821a72mr3756808485a.56.1735323866457; 
 Fri, 27 Dec 2024 10:24:26 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac4e2741sm714144885a.119.2024.12.27.10.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Dec 2024 10:24:25 -0800 (PST)
Date: Fri, 27 Dec 2024 12:24:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, j-keerthy@ti.com, jh80.chung@samsung.com, bhargav.r@ltts.com,
 d-gole@ti.com, u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH] power: pmic: tps65941: Fix TI TPS65224 PMIC compatiable
Message-ID: <20241227182422.GF1505244@bill-the-cat>
References: <20241227173024.2346452-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ewqQ8430jOwbXY2Z"
Content-Disposition: inline
In-Reply-To: <20241227173024.2346452-1-u-kumar1@ti.com>
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


--ewqQ8430jOwbXY2Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2024 at 11:00:24PM +0530, Udit Kumar wrote:

> Fix compatiable name for TPS65224 PMIC as defined in
> dts/upstream/Bindings/mfd/ti,tps6594.yaml bindings.
>=20
> Fixes: 1468fbba6d55("power: pmic: tps65941: Add TI TPS65224 PMIC")
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ewqQ8430jOwbXY2Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdu8NYACgkQFHw5/5Y0
tyw/Dwv+NWH6rQmkWEowbw88uckt5s+T7tgK44UeWZM2oKiJdpSe7GHDyOS07MOu
+QKosNqiWBm9AML/KTHG8AwK+hWE/Slh0C7GCf/yZXQQd0Z6fW24qdt0ipqYaRn1
GHIy+9SyPZUNqOpc0fHCSkzU2i/ahH2DaC7sSVnEVCjOYsvG+uITxAeLnZPp1Lz1
MUt8OLjd7cC4PD/3GxP+P9UQKTGzxs8YFjiX+PucwxMh4VE/sVzWNjukUlcy1wjQ
WBsSX/KojsUl9PKRPoAQZduXiV/NAg2369amYTe9EvO0C9ygfLv2fDQlFZNTbYU0
T6b9pxYcjwverSD83HDCooGjIZb+uDZBROvpqc1YwlNe0TvBCShLvRApVXrGShZR
bq3yzv79kvEY25bauEEW3mc3c7p2vJVBYiVOzHBVbEbBScURtO/BzbYufw0z/ObB
89oGlifgrdUYFgPGJ1ok3wSHLbYaUA5Hhsv4ySRrgBtzv+A64Hnv/fA7rD30K1/T
aTB4PreX
=LW7Y
-----END PGP SIGNATURE-----

--ewqQ8430jOwbXY2Z--
