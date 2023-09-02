Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7EBC001DB
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 13:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3940C86453;
	Sat,  2 Sep 2023 15:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HGBIYrpG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 813DB86467; Sat,  2 Sep 2023 15:11:15 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8EF1847C3
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 15:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5924093a9b2so29545387b3.2
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693660271; x=1694265071; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DTRgFxAlPk4luo8Zy+4HE/n/OEtyPoDj59PmsTuVSvM=;
 b=HGBIYrpG65a84vLeg80NUVTMTa/+/P02I0mZqCZE407KRdQKUtCTiUWvwBz2I8Zq2p
 Vjl8RjjPd8y5jz0N76g9j+EsPdldl6DK5uJhpg8sEHNVMM0FfUvQt7l8lFvn0+H6MuDY
 e30gR7izkDRkr+3my5W/w/M4kpwIS/xLHtxbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693660271; x=1694265071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTRgFxAlPk4luo8Zy+4HE/n/OEtyPoDj59PmsTuVSvM=;
 b=ZVX/oyPbYXR/BJUEV2TpP6/tl5LJ8N/2nloaI09rGbFtVxcuS2rXjF5XZ+GQbcQ7yd
 PpvIkJfFGToc7KC9oDa6ABhpwOhd8zlrXU7tG/3HIc1ShiBDYCV4rd1w/nQyAHxSx0Eb
 GMgs5Ysqq52ESYBmL4YPqCeLYA2aIqctBaOv83R5ZsvHR8GjaF9B/FAn6AzQYEvbnVLk
 xdRwt6gpN/TqWYicPMtjYD4ef+YE11BbAOMrWPliBd43jKq3DYEjmwgAsW6HiPRTxtbp
 BURHo/7gi9p1mOv/fhHOphLdqr1EV0totdC0UJlHdKGtVAZfyoxQaMLnia0xYL3qo+ET
 7P2w==
X-Gm-Message-State: AOJu0YwBNqEeGTEF79XCWCcgmiaqC3cIH7FrlJK5km8bynDVxG0o7ukv
 NimnEDLpCbCWbfbkGBu5AaxFrVk37F9+C8O/yBfGrQ==
X-Google-Smtp-Source: AGHT+IGDY1LQ4LYBaOP/5bSrO7VeSHjbMX4Dq6Fb24TTDzKWA6oXQUb9/nFAAOKUw99U7ECUWQpIEQ==
X-Received: by 2002:a0d:cc10:0:b0:58a:d281:a275 with SMTP id
 o16-20020a0dcc10000000b0058ad281a275mr5588171ywd.21.1693660271578; 
 Sat, 02 Sep 2023 06:11:11 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-9522-bc83-aa36-be61.res6.spectrum.com.
 [2603:6081:7b00:6400:9522:bc83:aa36:be61])
 by smtp.gmail.com with ESMTPSA id
 f123-20020a0ddc81000000b00584554be59dsm1610856ywe.85.2023.09.02.06.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 06:11:10 -0700 (PDT)
Date: Sat, 2 Sep 2023 09:11:09 -0400
From: Tom Rini <trini@konsulko.com>
To: Joao Marcos Costa <jmcosta944@gmail.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de
Subject: Re: [PATCH v2 6/6] doc: add documentation for gen_compile_commands.py
Message-ID: <20230902131109.GW3101304@bill-the-cat>
References: <20230901200353.90290-1-jmcosta944@gmail.com>
 <20230901200353.90290-7-jmcosta944@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dNM/Jm1T/QETHKvz"
Content-Disposition: inline
In-Reply-To: <20230901200353.90290-7-jmcosta944@gmail.com>
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


--dNM/Jm1T/QETHKvz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 10:03:53PM +0200, Joao Marcos Costa wrote:

> This documentation briefly explains what is a compilation database,
> and how to use the script to generate one.
>=20
> This is not a portage, as there was no original documentation in the
> Linux sources.
>=20
> Acknowledge the documentation in the script's header.
>=20
> Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
> ---
>  doc/develop/gen_compile_commands.rst | 46 ++++++++++++++++++++++++++++

This isn't included in one of the index files, which will be the first
error 'make htmldocs' throws, and I think I saw other syntax errors as
well in the file.  The docs themselves look fine, thanks.

--=20
Tom

--dNM/Jm1T/QETHKvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTzNG0ACgkQFHw5/5Y0
tyyLgwv+LPzSaZDijmARyxof0QlHwlqgxtvXR36VRsGK5wJ/5WDBynbHxqAC8n8L
ss4LZTffhqubKDWl+d6tiMBGmgIDaJS1Cgj4jN9Wkdlwos3V9lIWOR+7VIsjMo79
x64+/KkoG0XUY4sAmwwyr5E0S/I/+lhMYCIuHBx8SFbXiO1SmPr5D/Yz9CqNTYUq
hbByocOQaXDh8h0xiJS2/xZbADxXoJocIsYyiO1BXY4HgmHQdLe371RaDTp1TmYi
YEZ1IpnvhuKSxuTTz1f4e/g9lss7257tuzykeEA0qhhnInx/Fqy0mBEmlCAOUZHR
2SXnm3XAqfhnYNzig1SfMxt84jN3Atv6BJIUB+HmUEFmhRKG2KY5jbtdLlRYJu+Z
C/EDLA2Ga0IcKJGYmr0yk9MVVE/gKkyBllQ/E/KCpwY8yp2yy2w5PB1j+R3+J2Q+
64J/v/qVFO2UPxAe2tp5N4+l5auogZVbQZ9RAipI+a8dY5FGDlLidhs5Y+xq5yGX
8StqYFAC
=TNWZ
-----END PGP SIGNATURE-----

--dNM/Jm1T/QETHKvz--
