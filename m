Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F27C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 18:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A11F81F0D;
	Fri, 14 Mar 2025 19:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ajS8BaxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42B9581F0D; Fri, 14 Mar 2025 19:32:11 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D7A281E92
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 19:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-46fa764aac2so23174951cf.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 11:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741977128; x=1742581928; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p0RWGqkdhNFvyU+Q4vxSeXHq1AIfUrxX1hozsy7BSz8=;
 b=ajS8BaxKvjDbipgTzuAHq4IZ45ZAIwYpA4Zp5Nvg5gg8WdXn6W1KqjORx6Y8kLNTvU
 0OzL5GDkq89yU4lEXj1GVo5eYdjYCrawY/gqolE0JXIGQLELUbRpGO0OqyBAhU2vqDQa
 c1UwhMqqL7f8kTeGZCNfZK1DV8OrL2d8krsO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741977128; x=1742581928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0RWGqkdhNFvyU+Q4vxSeXHq1AIfUrxX1hozsy7BSz8=;
 b=rW7CxoGH0SFOkIFqfGJm7E7KwfchTlmMyNton5zTEYeq9RDvwWCro9lfaicQ4FZDd/
 vE6xTbFLzlp0tSgWZYivLx706cZKXxNb/gLsbp9r2nao7b7633+10jWxJry9M8J9Md5T
 Y6sjNqzc6IHsOEgw3h6UFM5fm43JFS3zHiHrMppmBOb1PBjgYh+ExGWrjnRuhNrC7a6N
 BNZtTw1Mt8gmvfy16R+T8oEFp6JbPeGjHO7xLMUyRaakl4aumxQsiJN3ZF191iMjg2Fw
 uVaQBjRKsH273zylEaDplcPpwOu9t91n1LkY27yxUqxj0FwpbWa9CG5eL8Q3ss7hPjO9
 nyjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4BZqHylHzTSguTdwPvAaBDQ69dBT054FTfoPfvWO2HzQpAmCIvm+j+P1Z7KPH6MUa+Rmn9A0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9gyLyG3Cf7FUfUcLaiWUH209bQoGSB5n8bizNSa2rOnmwwqCc
 IfbkTg2vv4Hw/KR8PuyYJQoFKe7JyS0El027n1PXWS1ssqQSieEN8bDhvRV8+hA=
X-Gm-Gg: ASbGncvXrn3jZ2wZAW8BRwVjK0QjD0FvV4e0uZPPE02DLjlkp10lwxgMD9utAoc6JIE
 7YkLapw6Xw6zCkRETrh3aUjZuE78vsXeaDsDmpR5j2cRN0rRLpve2OQnLUmPjmFHWnzLoEyvetk
 gArg3Os6qqJdZLSdPhajf59F2krDo6Ch0OkC9Uab8lZQS8MY5tKLlWTbRkqVzSOaRdv6+/zUn2K
 /iRpyxHqII6GxGJy6y60eW6j2HrERR5yqLGU0FqCo+5CTpqHHdnQQvT6zlt1i+FJKRsefFNNidI
 UMsQwSJFl5RmuWsD1ICnOQaDnpZGwFgmU0D4iMt5Ae0gwg==
X-Google-Smtp-Source: AGHT+IH+qG/zoocjmjCVGamNmFePKnZeZkkfHjl9T3RuGHwwbkdVo4zeiNCQyaD0MADnmwv2ShxMQw==
X-Received: by 2002:a05:622a:206:b0:476:955f:91e2 with SMTP id
 d75a77b69052e-476c815f058mr50965611cf.29.1741977127333; 
 Fri, 14 Mar 2025 11:32:07 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb611c83sm26028951cf.2.2025.03.14.11.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 11:32:06 -0700 (PDT)
Date: Fri, 14 Mar 2025 12:32:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Stephen Warren <swarren@wwwdotorg.org>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: twarren@nvidia.com, sjg@chromium.org, u-boot@lists.denx.de,
 Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] disable mail for swarren
Message-ID: <20250314183203.GE2640854@bill-the-cat>
References: <20250314181031.7978-1-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6mgRTm/hOUuycrOp"
Content-Disposition: inline
In-Reply-To: <20250314181031.7978-1-swarren@wwwdotorg.org>
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


--6mgRTm/hOUuycrOp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 12:10:31PM -0600, Stephen Warren wrote:

> From: Stephen Warren <swarren@nvidia.com>
>=20
> I haven't been involved in U-Boot development for quite a while, so
> CCing me on patches isn't currently useful. Add a .mailmap entry that I
> believe will turn off patch CCs. This can always be removed if I become
> active again! Remove myself from a few MAINTAINERS failed and the git
> mailrc file too.

Thanks for your time and contributions over the years Stephen.

> ---
>  .mailmap                             | 2 ++
>  board/compal/paz00/MAINTAINERS       | 1 -
>  board/compulab/trimslice/MAINTAINERS | 1 -
>  board/nvidia/beaver/MAINTAINERS      | 1 -
>  board/nvidia/jetson-tk1/MAINTAINERS  | 2 +-
>  board/nvidia/p2771-0000/MAINTAINERS  | 2 +-
>  board/nvidia/ventana/MAINTAINERS     | 1 -
>  doc/git-mailrc                       | 2 +-
>  8 files changed, 5 insertions(+), 7 deletions(-)

I'm adding in Thierry Reding and Svyatoslav Ryhel because Tom Warren has
also stepped away from U-Boot a while ago now and those boards should
likely be taken over by someone else, and the doc/git-mailrc alias
updated further.

--=20
Tom

--6mgRTm/hOUuycrOp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUdhsACgkQFHw5/5Y0
tyxb/wv8DfhplB2FhJnQ/Z6XdcHXfSdhsA1mGpFiqQYBH6JodpMBTI19YPlnOqE8
Lpgy3WNk1ta+zFrTP9MEmvmERJQZ4NfBnBWg75vag4NSXVM23hBtHV1VnPWTqo7y
/7ql/0O/ACV3bRWhOLI+pzW5KYYKHW1yL30k0cGriakPxpQxxvrNB0qoAHHcfo41
jZYOQHElKDkYrH+w4nVvzvDBeWTouWtEYaoUYggSiNouYAK0vL3TP5hn5sVNa1rF
kayXH+B9feieGlK289coEHSH9p/+l5PeDh/zcYvdMkcYuvGq/8LDcD6NOg81I4JU
q8VH1Zn5L1ya499xEB2q5PUDJt6SXyOEtRLx5mwMWeKWy9dkdiYA6/FtT7ouZEpE
hdwq8URrWfjVVaXX7+fxDBBjHERHTW5d6rA+SYvifztGcKuteLhIhDpkf6jyju9b
x5QPeOVVR8vf9oawhZpwTNc+9kaxzF6hfVZSUFCxq3KDsKeRgY3BOlIAPkl7iuhK
Fmx+ieRk
=BJN0
-----END PGP SIGNATURE-----

--6mgRTm/hOUuycrOp--
