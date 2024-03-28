Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F266EC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 254F5881A9;
	Thu, 28 Mar 2024 16:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="en4p+E5s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FC7C88150; Thu, 28 Mar 2024 16:09:25 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35489881A8
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 16:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-430c32c04c7so5155031cf.0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711638562; x=1712243362; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y8OAcKSH7XVaS9F4atPsR7h/hrtT+B1CMjNtCyPO4RU=;
 b=en4p+E5sdAJ2OsulIBnnO+X1nVkybCv2AkmlM5dTCPYug5mgeL8hE4p2+7Ky97cYrA
 0o1w8037nLmL2XGFQDkomQG2KXUOnwZR+Ah4BcPWshO2WhyJdajakdQyAuN/AwapSpBv
 BSWMtOTY/E469KFMX55QsK7bUn9Q47GaSNDmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638562; x=1712243362;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8OAcKSH7XVaS9F4atPsR7h/hrtT+B1CMjNtCyPO4RU=;
 b=xN7Br1jRl/qkPGhhOCijEIkq225+d+XyXKL83uQtpwLk52S4hfKKQYCmdgl1cfskFM
 U6L3O1iihVz9fAleDkPXcTQmmPle7Soh6aZeBFooRZaoy28SNCIyzJ8TZFSNLzYaPTbX
 SsM6XRNC1wWf8glGpsDxFAEwBTD3ozl+aP76PLz6Je364f7CZwuSuWagIABobPQwpRA/
 op+VkLo7t+P+WzLrqy/o8OlpUPAKxUbwzcGoD1GEp/PJWx1gV0hPIwHvzvLkI9Os2e/h
 JXM8BgFD5SYVp2dgUAYnfcpAbMYyeRBAuGMKFUEGTBxEyphRgtmxAz3ImkYFnDa6jxfe
 s5Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQl2ge8VEOMAcDdx8NpQG9dzbYGbt09bbmrb7Ce/DdhszokxxD+Ao+BolimP6VeyLbNQXC7BXIHPO5+yOqVir6BGnB0Q==
X-Gm-Message-State: AOJu0Yz/N8V4a89Bj724jSi0sYtszqZyo2jjSOs9b/Sid+XsmoQrZgh1
 0Un0tb/0QLJ7e2TYtG9rpefo6wfKbV2rTD2EKgTbG/GHM5Qxmtw7saDC/3/f6W4=
X-Google-Smtp-Source: AGHT+IFZ6eybir8tv0ZVLXI998Th+k4P61DDxsKEIVbPzmeoAC5GXy4QIVLivZFb8aMe8ECfTjMGQQ==
X-Received: by 2002:ac8:5c45:0:b0:432:b42b:8f3e with SMTP id
 j5-20020ac85c45000000b00432b42b8f3emr2081323qtj.64.1711638562107; 
 Thu, 28 Mar 2024 08:09:22 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 f2-20020ac84702000000b0042f14f31cd9sm678716qtp.92.2024.03.28.08.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:09:21 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:09:19 -0400
From: Tom Rini <trini@konsulko.com>
To: forbidden405@outlook.com
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/5] net: hifemac_mdio: use log_msg_ret() correctly,
 report error by dev_err()
Message-ID: <20240328150919.GZ3442575@bill-the-cat>
References: <20240122-net-v3-0-f1e80564725b@outlook.com>
 <20240122-net-v3-1-f1e80564725b@outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kLqnZVXULFqdYlTj"
Content-Disposition: inline
In-Reply-To: <20240122-net-v3-1-f1e80564725b@outlook.com>
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


--kLqnZVXULFqdYlTj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 10:33:20PM +0800, Yang Xiwen via B4 Relay wrote:

> From: Yang Xiwen <forbidden405@outlook.com>
>=20
> The initial commit used log_msg_ret() wrongly. Fix that by moving error
> report to a separate dev_err() call and shrink the first argument of
> log_msg_ret() to no more than 4 chars.
>=20
> Fixes: 6b5c8d98e204 ("net: add hifemac_mdio MDIO bus driver for HiSilicon=
 platform")
>=20
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--kLqnZVXULFqdYlTj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYFiB8ACgkQFHw5/5Y0
tyxo/gwAqpIFB6l/ltQz02eBDMfgBX3b2MV7AyZl/Cx/RyeiZiTXd+0wzCx0w4v9
wyR99gUOj3oxZvt71/MiBheFixtyAgvewEj0GjAoxbexRJn3V8O9l5gSq6ye408t
yuFgKKXuKM3awFygjyqdPbNqIXL7/FE2oFw1iCFTE6R2U+LFydMPslLP0Uzotq7b
oDDqvB00RNf9oQBTAHRbX4Y4CeIzQUtbXM+nr0v0Jh29UQh9bblKxutGszdpDCXE
lGG8wXWZioTHKJEQXbH/8++g/3PXBUc8HgtS62irvS5oBsJSw7BABpzxWfCUNBWg
lU72Rj8yMmF1ucgnc6iD/f87HFBraLuc0AdjEK/fFirIzBEuhrc110ad2RCemWDc
ZWKNFTboZXNIj5mjFrPHhNd3ycpJs2anf/45lar0UzFLgrCiBYVT9lonCudzpbZZ
VsaB6hSxECUng8UqUNNuGabt55Tqw3euJtUMzrpsbnqxIda0zE75Zii1h5RqjLqi
VAf6M+OC
=L8A8
-----END PGP SIGNATURE-----

--kLqnZVXULFqdYlTj--
