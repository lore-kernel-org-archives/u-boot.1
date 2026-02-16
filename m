Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C69AE63F3F
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 17:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFF5183C72;
	Mon, 16 Feb 2026 18:50:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gIt71hcv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9A0383CB9; Mon, 16 Feb 2026 18:50:36 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B56380325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 18:50:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d195166b2cso2262038a34.3
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 09:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771264223; x=1771869023; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d9VaIRBAsiI6iVdAb2tgI4x/lWupG0vW+ZSUAe7QCLU=;
 b=gIt71hcvoWX8oUP09f9+dXXAbH6//A4M+TZ+fEQ0Y6c+dKxTJl/R5IOW0+pvgQlBRC
 3BkQw+M6J/XIOGGchgMVzwttH72eEoFoewUHuPJ1lMY5XIg6Uw+JPJ9PckZRuBz5kF4k
 JjhCIZNtQlbh2OylzjCM7hmIy81B3tI8mFKFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771264223; x=1771869023;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d9VaIRBAsiI6iVdAb2tgI4x/lWupG0vW+ZSUAe7QCLU=;
 b=EcgeJEJmMQFEJ7D6Qy4ijJbdYAOSbWHnu+Bh5U3c0o0ptne/UmcWIdsT91TfNDecyp
 84EnmPNH8fhAjlxqCWsksUlf+s7V9wPe1zQfKG6fkVGbJWXxMtmbM6ua0F6HKwzcn1pb
 QbsDzW2p+3FIcHD6TVPnLEv3p1F5XPs5aHEeCGGRtxpC0MMU84QT3cJuV4gB14eo8f1M
 7DHpcaPUNyr4MYnTWKOkm1JrNck90HSi4ILAgSHf1uRUz1WPv8mYpxOlJvbwrAJdecK0
 tEYIxIwFN/9rU9+PhPHMJHi4AsuLquKkNDBwzhCKCCMCq8zpT8KHwgzNLmb0WCwtwhrE
 OnLQ==
X-Gm-Message-State: AOJu0YwhfpEF2F5dmPn7Xqo0lzdmbLvc5OS+64Pw0ad1zznSYsyDwicf
 v6WTxtAQLnEVWJa0A1PUiwrmsXY71WymRrv5294CYQzMIO+0LUA3FAGJvZQcSMPO1Ac=
X-Gm-Gg: AZuq6aK2he9niw3zvItx4z9fe+MXMVJKWUIas8wbaxPl0n3MiLKyTRuQ95VzOhHdPwq
 9ywYGjSdeRsrcGeWij8qZLuG1UFLz/QRzGG5MorCK+FZahKhI+ZSMx78vnfyAKXxIXEWZzetkcP
 Tp4rORE2c1toGoVK2u9U+fYaCD1rSmKYrKLC8uq3YCXfimHPkNIxf8LNS7tZCVXZys5xtrLhRC9
 1OzJ3e0X63LP4mIU3v2V3ROmq255u5cHkdne/q+sibQQioyu3eSsKlEVo5mPccLYP+HX6jvCP6K
 cdn+LtYVGic7PqAcQ+zoRs/tdbJXaM0xLI5xWpaWNhmUpSMbM7RBioUWqM9AWBoU0TsYIY4vZJd
 s3wSRVffO2IwRmhLy5iygf9M0NOpdYxDXDYgmRTv9FzYUuooMhsRBJGN+Eldq+IvCpBJG42um9k
 CfCcf/rCdN2FJX24hW2g+wW7iaVMEvwVyVufsog9/wSwAXnk8UyDhspazvZIiSOKh+ToT9ZBGJW
 5XIvpBNhxTCL2OzPnhtIrLVA/iEQXd/nLqy/GHqpjjEUuSvfrE=
X-Received: by 2002:a05:6830:3c10:b0:7d4:9679:5797 with SMTP id
 46e09a7af769-7d4c31c929bmr6610659a34.28.1771264223085; 
 Mon, 16 Feb 2026 09:50:23 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a7547ac1sm12745738a34.7.2026.02.16.09.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 09:50:22 -0800 (PST)
Date: Mon, 16 Feb 2026 11:50:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Simon Glass <sjg@chromium.org>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH] dm: core: Don't allow ofnode_to_fdt() to return NULL
Message-ID: <20260216175020.GX2747538@bill-the-cat>
References: <20260210-ofnode-to-fdt-null-v1-1-4bed28680f35@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mr1SVJJVwdmtFEp4"
Content-Disposition: inline
In-Reply-To: <20260210-ofnode-to-fdt-null-v1-1-4bed28680f35@bootlin.com>
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


--Mr1SVJJVwdmtFEp4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 05:29:01PM +0100, Romain Gantois wrote:

> The ofnode_to_fdt() function may return a NULL pointer in multiple cases.
> Or, this function's return value is often passed directly to functions su=
ch
> as fdt_getprop() which end up dereferencing it, thus causing a NULL point=
er
> exception.
>=20
> Don't allow ofnode_to_fdt() to return NULL, to avoid a NULL pointer
> dereference.
>=20
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

This leads to failures to build such as:
+(neu6a-io-rk3588) drivers/core/ofnode.c: In function 'ofnode_to_fdt':
+(neu6a-io-rk3588) drivers/core/ofnode.c:176:21: error: assignment discards=
 'const' qualifie  from pointer target type [-Werror=3Ddiscarded-qualifiers]
+(neu6a-io-rk3588)   176 |                 fdt =3D gd->fdt_blob;
+(neu6a-io-rk3588)       |                     ^
+(neu6a-io-rk3588) cc1: all warnings being treated as errors

--=20
Tom

--Mr1SVJJVwdmtFEp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZNY0AAKCRAr4qD1Cr/k
Cq3zAP9SnaK+kws9Yls7+7hm5GRQQfSIhYfjTtHrH9M1r24/sQD+I+cGeFKIYkg3
bQLKkpiEZpiI7NTC8NRdV7wvZBaH/gQ=
=GtiV
-----END PGP SIGNATURE-----

--Mr1SVJJVwdmtFEp4--
