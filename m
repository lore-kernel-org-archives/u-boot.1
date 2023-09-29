Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84D6E71D43
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 15:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FD958684C;
	Fri, 29 Sep 2023 17:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tg7S9efl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79BDC86E50; Fri, 29 Sep 2023 17:01:57 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3F7786308
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 17:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-59f7cc71e2eso118013767b3.0
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695999713; x=1696604513; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V0cjtFeBqG41n6lbWTvHrBrFXTISyqkslKAWMSp2sHA=;
 b=Tg7S9efl5G0rTwuUL6J0BJ5Kzcs8utqeA+8IA1+Hl3zHYodguW6/2m1Y6WWHc6b1CD
 ahFeTzSj69f3E5xGLG7C8TwyY2Ybkq9QP/Z1gE7B7p4reApVdIVk9dnFcX7WjXxWpJnV
 ZGaZxvu2mGRQBi4xwjM/BdMK1cy/qpN9xF+jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695999713; x=1696604513;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0cjtFeBqG41n6lbWTvHrBrFXTISyqkslKAWMSp2sHA=;
 b=CUp/B+P38+Xsu/UNpj1Uz7arnb5HSdZSC4hXv54MbO5wnqyemPV/lNh9ENfPDg3GhB
 E9jJTvl08l/Ud9MEhPxQqctj33zLB+HCaaFnnVOXcTkcCq0lUh8b7rUEBDrF1u7/ah/6
 gLLGNk9vnU32GvooCE37qPCyxoL006w09UDQ7dsraYClVdEX9xu8cjsfng1K8M4P/2pQ
 LY35gCdBQ2NxdDoJmxrCo6nhoT32olMiwbzDPIJyVnOQQqNVHyJCZe+Al2MGflvdxkmY
 w5u7yup+ekWK++8vcFgRdGe3WoC5VTARiybNF3PlEEULt0uZUIc2Q66ycSR+8vhLK0sf
 fTxQ==
X-Gm-Message-State: AOJu0YxULef+ADdp6qnxglYN8hFVpxVgAtNVBcZ+X16VEf2kuA5r5O+1
 fMcKbJR69ggKbky5Y2ehCUhidA==
X-Google-Smtp-Source: AGHT+IFtyZPgkpNT9xszkLC6R96zYnM8YscPHiokMdmVSGL43qMxgAIssA1stiT+30+n7iFjETxHtg==
X-Received: by 2002:a0d:eb16:0:b0:59f:67f5:66cf with SMTP id
 u22-20020a0deb16000000b0059f67f566cfmr4740347ywe.11.1695999713452; 
 Fri, 29 Sep 2023 08:01:53 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a39b-08c7-b2a8-b94f.res6.spectrum.com.
 [2603:6081:7b00:6400:a39b:8c7:b2a8:b94f])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a81bb4e000000b00579e5c4982fsm5466075ywl.36.2023.09.29.08.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 08:01:52 -0700 (PDT)
Date: Fri, 29 Sep 2023 11:01:51 -0400
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PULL] u-boot-at91-fixes-2023.10-b
Message-ID: <20230929150151.GO305624@bill-the-cat>
References: <f223ce83-55be-aa17-e003-69627d71e948@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d+Ddwls5VYKDmWGz"
Content-Disposition: inline
In-Reply-To: <f223ce83-55be-aa17-e003-69627d71e948@collabora.com>
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


--d+Ddwls5VYKDmWGz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 05:36:38PM +0300, Eugen Hristev wrote:

>=20
> Hello Tom,
>=20
> Please pull tag u-boot-at91-fixes-2023.10-b , the second set of fixes for
> 2023.10 cycle.
>=20
> This comes late, but I hope you can merge it before the release, it's only
> two small fixes , one for an array not initialized and the second one fix=
es
> an error case when a DT property is missing for the atmel NAND driver.
>=20
> Thanks,
> Eugen
>=20
>=20
> The following changes since commit 15155ab0a3d1f839509bcac620bfb38f950bea=
d6:
>=20
>   Merge tag 'u-boot-imx-20230923' of
> https://source.denx.de/u-boot/custodians/u-boot-imx (2023-09-24 17:15:31
> -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-at91.git
> tags/u-boot-at91-fixes-2023.10-b
>=20
> for you to fetch changes up to 7b4ffe8c32db284e25d3a2636904def8e093da9e:
>=20
>   clk: at91: Fix initializing arrays (2023-09-29 16:45:40 +0300)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--d+Ddwls5VYKDmWGz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUW5tYACgkQFHw5/5Y0
tyxlYAv+O1BmKai4dloa5c+iMY/qw8lU/vjsmbLtWG1NHnPHyaOYCqJkY2d1yehJ
FNqlA19eFCmlzzvgPj26w8YhN9beI6hXA0ur0eups0rrGcI0GTIlqn4nQblsix88
VEYwTX+L3ncFZj4HJIsdX4aPYGLdDfpAlG2a3Cn0xs6FtTdhvE+pI2w6ibfDsL/S
PZxJNbXYY/10PRxSoxBOKAj/N5KmhjrHMW+c8jkS3C8mmDuzVvmd2XJaSK7BBpDw
AvUffR+Cu/X9PTDjvyUaXZHs4WVZA0EyPFj5nOaxOqTW6HkfvRBQvTRts4396Cu4
7Ca3FKkr0RuPQvpNO4aluwqcgnNJr+K63dEwwA6v7BXPKUT7k/aUp7o4SKD+EX2C
nDWHYVch4JUERNTbrwxaK66TiYacRn1IQfePh5/dXhS7Re5/aUp4e8kKj7Fjyz7p
Hoo+q33TG6EkmKI0A/rIarS/R+NjVkBsjYehYuEv00mT/0Js2GuEKxnfFJUcVpFy
+pKoI4Pc
=CBtG
-----END PGP SIGNATURE-----

--d+Ddwls5VYKDmWGz--
