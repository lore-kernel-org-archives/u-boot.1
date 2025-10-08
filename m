Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E87CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 20:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 139D483914;
	Wed,  8 Oct 2025 22:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pYXkF2/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B19C839B7; Wed,  8 Oct 2025 22:24:19 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D65C83906
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 22:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7bdfbc6ba5cso113886a34.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 13:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759955056; x=1760559856; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NvQ0qpFwthYUXEwkHkEl5RQXqpqcAvOU/N8CJcfhHD0=;
 b=pYXkF2/u4SsGTOUqTVD6pPqOt7SJdZWvQ4Wz5nC+9TheRIDXrJkd9baZNcM0eNsMEe
 cQhqZfNn7yaZwcbGws++Ber1YMXIzVVCJORlKzsHUhyjtCE4yrD+drV7yIHGnAu0C5hw
 SEUrDAJnJy/iAyrXsBZf4YUDRpukq1c6RBrhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759955056; x=1760559856;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NvQ0qpFwthYUXEwkHkEl5RQXqpqcAvOU/N8CJcfhHD0=;
 b=O42QyWO8b4qjfOlkgm5jo6GTqeEqK9VttgY1HZeq1szLJSODuPNNJs8XhKQhv5nr1k
 eJqpfWmyNjFcISuUv5ZEm84Z0YA+Netj9NCJIcshpe1eQd7zuQegF/Lz9ur4gKdGjsgm
 AfgnmAyRaFymaxE+uG7+Q3xXr/ltr7YJSHW+/Ff/idcD5ce8HF6+Zoc19eYLWdYhCI0W
 yZ4gcJeNTsAcYgumC3zHWjorWL1bG1UcRu0V6LGXu8y06hrMQjGIIhkRkHCPZqmHtBjc
 xM1S19DP+SJWX1w7fwWXRndC/Leg4INw6/dac5H8GmnKsnxccF6jXu6U6xzheRr6655c
 amMQ==
X-Gm-Message-State: AOJu0Yz53PEYKx1nkX+gma5Grlm14bCy4tW1jF1YOiD1DHXZHIfu2tBz
 0hTM1A08uTqxwD2fR0yciNq0QTwPH2EvMwqxMsvh5yKq0D/r/iiisqD9jtjVkTqlgUg=
X-Gm-Gg: ASbGnctuByliqgsyiQwtnljUW0Btu6CIYBPWSOhPtLH8GSPKhJZx1qWrSBOQv4Yo+uq
 vKoQldobxlerlhwD7UqV5OuYezDpEGU9MUkXiE72uWKZR2wbeyJT6om1bw4Kzvrb3xe4sH6OjSZ
 wGMZrQ+KMGXgLidQIIckmWJc61IaTfRp50kaXlI6HYvi2vn0h1vdXRWpL/Jgc0bPFnMF0O7DaED
 /uO0gvPX87hlvJ4cUXZLIpqLtKzyGHxUtBK6oCTaUBNOHXoaRKPSL0hDO3lN4stmRM6pB5LaUbH
 JwObYNh6DxMFSnK7TPtWNOHx2jBrIuCQCsLhuxCax8eTiHDx+CLw/luQzvv30AhzyATKzLzJzrL
 cl/xMjyHcuS1YjrXlt/iN26k9VnaIyYVeyTtwfYoich8BHw/ecf/N4zz4pwLQWal/xMztJk0f5X
 If8ZsidVgYPA==
X-Google-Smtp-Source: AGHT+IFGIYFqgFIH3eWVmYxsjb39BywpwqWemnmnzzCPhIU5+6QuspuPmYNdJATl9J9gLeRTrce6vw==
X-Received: by 2002:a05:6808:188d:b0:43f:2ab7:345a with SMTP id
 5614622812f47-4417b3ba929mr2525079b6e.37.1759955055568; 
 Wed, 08 Oct 2025 13:24:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf3f6102f2sm6130808a34.6.2025.10.08.13.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 13:24:14 -0700 (PDT)
Date: Wed, 8 Oct 2025 14:24:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] cmd/dma: documentation
Message-ID: <20251008202412.GK298503@bill-the-cat>
References: <20251008174408.381-1-briansune@gmail.com>
 <20251008190713.GH298503@bill-the-cat>
 <CAN7C2SAaia8qV4sx-uMF2Y1GE4GW=WmmgSMHMApW0YoTzTqQOQ@mail.gmail.com>
 <20251008193306.GI298503@bill-the-cat>
 <CAN7C2SDaP65Eu914rAzNdhKG9oAUEeM9EhE-EEh2odONnBjWVw@mail.gmail.com>
 <20251008194613.GJ298503@bill-the-cat>
 <CAN7C2SDR9NLpmF3Pcd9QRVRk5gBrR2fciiPwccCsev7tpRYHJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s8mth+jLR1QIJf0X"
Content-Disposition: inline
In-Reply-To: <CAN7C2SDR9NLpmF3Pcd9QRVRk5gBrR2fciiPwccCsev7tpRYHJQ@mail.gmail.com>
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


--s8mth+jLR1QIJf0X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 04:16:51AM +0800, Sune Brian wrote:
> Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B410=E6=9C=889=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=883:46=E5=AF=AB=E9=81=93=EF=BC=9A
>=20
> > > > > > still) in the shell commands section. Also please do "make html=
docs
> > > > > > KDOC_WERROR=3D1" and make sure there's no complains for v2, I s=
ee some
>=20
> without adding any rst
>=20
> make htmldocs KDOC_WERROR=3D1
>   HOSTCC  scripts/basic/fixdep
>   SPHINX  htmldocs --> file:///media/sf_shared/u-boot/doc/output
>   PARSE   include/linker_lists.h
> Running Sphinx v8.1.3
> enabling CJK for LaTeX builder
> loading translations [en]... done
> Converting `source_suffix =3D '.rst'` to `source_suffix =3D {'.rst':
> 'restructuredtext'}`.
> building [mo]: targets for 0 po files that are out of date
> writing output...
> building [html]: targets for 694 source files that are out of date
> updating environment: [new config] 694 added, 0 changed, 0 removed
> reading sources... [100%] usage/fit/kernel_fdt .. usage/upl
> looking for now-outdated files... none found
> pickling environment... done
> checking consistency...
> /media/sf_shared/u-boot/doc/develop/package/bintools.rst: WARNING:
> document isn't included in any toctree

I'm not sure what's going on with your environment, sorry, you might
have to just push things to CI. All of those errors don't make any
sense. Docs are build that way as part of every CI run, so they aren't
generally speaking broken.

--=20
Tom

--s8mth+jLR1QIJf0X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaObIaAAKCRAr4qD1Cr/k
CmsfAP9ukPDfXtm3HmPuX890hSAD3L/wegkqwnl15yYWk262QQD+KJtTGu+1A4Ev
i0yTvncarTmybz1EPBbwerq0Y62Q0Q0=
=/VzW
-----END PGP SIGNATURE-----

--s8mth+jLR1QIJf0X--
