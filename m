Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26705C001DB
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 13:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D76528669D;
	Sat,  2 Sep 2023 15:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X7b9ZiiE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAA52864CA; Sat,  2 Sep 2023 15:09:42 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABE9A86453
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 15:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5922380064bso30519367b3.2
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693660178; x=1694264978; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ah/G20X5nqno9jkDVwr2pK9QAdH0T3guRlO0ac7nK6I=;
 b=X7b9ZiiEHwn6Vl5GLqp0MMtyBQoiEJcm5yn6BDXnPbEM++pI5+xn/bSC7GbX/7YRvf
 QgIO4oaofnatyurWVlKEGgF+Go6ddexopQzpXbnVwAMnywBPTj2Mo2ufsOVRZcvssgzF
 vU+6E7s0+5nFuZAdkSz7+Rjyh9rFK+Fl/qPgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693660178; x=1694264978;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ah/G20X5nqno9jkDVwr2pK9QAdH0T3guRlO0ac7nK6I=;
 b=DMsHrbqtdKLF3PKHA51ooMd9YDZRwGKIeXTbxiqAjdR13DjosIZV5sNWlrFiJH5pGB
 AhxiJOaIwqlUeIXeYPDXqJYnf33pPkB05IBauS/jsqc8QoftmeDGDH1BlCdOV36HHtTU
 5Gey1pBoFfSl58hzYR06+246Fvd4O72n+pdyyw02k3sn8rHsJG/+eMu2j95QnG266MvW
 QGGhjBpVXyQ5yg5GXJlJiJ+3K6hWj9t1c3ATv33rj6fmnAusCOxQ1ajFkPa9YWzLCtYN
 Fcc3i6KBllc9t+wc4fdvENTvBYJZk1u37uWlCN9gS2IHu4qUOhHLMakSt9LRbVrez+tx
 kBAw==
X-Gm-Message-State: AOJu0YyHbNqESuhI0UnKXNb9lTcPbjiVC3EuhfhVkgHUhVIjVLVLys/B
 TJ96Fr8Ynb6iVOGzsr6cHrGXzg==
X-Google-Smtp-Source: AGHT+IGHp9Z3o5T4+30EPY2CkFOsO+REdis11cB1jSDsJeEKxeCO97YuDbvefswazsmLZfHqOZi08Q==
X-Received: by 2002:a81:5483:0:b0:592:9433:d2f4 with SMTP id
 i125-20020a815483000000b005929433d2f4mr5846557ywb.16.1693660178391; 
 Sat, 02 Sep 2023 06:09:38 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-9522-bc83-aa36-be61.res6.spectrum.com.
 [2603:6081:7b00:6400:9522:bc83:aa36:be61])
 by smtp.gmail.com with ESMTPSA id
 i198-20020a816dcf000000b00583f8f41cb8sm1580118ywc.63.2023.09.02.06.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 06:09:37 -0700 (PDT)
Date: Sat, 2 Sep 2023 09:09:35 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [MASTER] Pull request doc-2023-10-rc4-2
Message-ID: <20230902130935.GV3101304@bill-the-cat>
References: <a4e2444c-f534-4824-a3ef-fa4c819edfed@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sF3HcHTJj80H1YY9"
Content-Disposition: inline
In-Reply-To: <a4e2444c-f534-4824-a3ef-fa4c819edfed@gmx.de>
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


--sF3HcHTJj80H1YY9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 02, 2023 at 09:55:09AM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 0fe0395922d859730eb7ddfcff6ed8d3ac4b29=
37:
>=20
>   Merge branch '2023-08-28-assorted-important-fixes' (2023-08-29
> 10:06:08 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-2023-10-rc4-2
>=20
> for you to fetch changes up to 44c5d7764bf458ef0a8093ddf3422dfebbf7b00c:
>=20
>   doc: Add gpt command documentation (2023-09-02 09:44:04 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--sF3HcHTJj80H1YY9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTzNA8ACgkQFHw5/5Y0
tyy1QAwAnNvmU8KO3mXhGX5GxIlMIkQgL3jwoTDmw13nNDE3d1YMOlySrt9nxVp7
Ruoq38F6AXYDBBEnavBVYUpdD6VdJcqVdxhW5owKeS6QcgZZITWc4PxVS8/E4TbT
Cqpj9V+rDbPq1pVjRI1yuhyM/K2JdNC66FpJI83J5+kEP8ry9It+M0rEREtI0zwG
AjLz7TKW39U7Gfl+hJ1bMI4b3u4Vg+RObbzQ1HI9XLoVMCgi91/BW75X8fxRdCSD
nSY8uJQIKjIUn9JHZMphqcZSH5NLKwVm3uKHs/a6aZTz4+fGX68qb+W35ks875B8
LHzoAZE09RGDghXIt8Ob7fDDTjLHFtcY/txOanL+XD1nGj7a5QXmSMvOP2ufxoq8
hKY11F/laahms/uIpsXV3ELOOKLlZuwJpGq5Ml/65UirO8NKXbCmdDvSAb0qIWlN
Fa+2B5VbLeItyBDFLFcAQJVAXfc8XlFsl8bF+xaI9XV85gykgZiOm2Tyc8Nn+mhx
ZtW9guuR
=3yuL
-----END PGP SIGNATURE-----

--sF3HcHTJj80H1YY9--
