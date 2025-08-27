Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81CDCA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 18:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D678831D3;
	Wed, 27 Aug 2025 20:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QpHOaTVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FEB0831B4; Wed, 27 Aug 2025 20:32:16 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7F20831D3
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 20:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-437d3cb58acso7464b6e.1
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 11:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756319532; x=1756924332; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D0mx9sZfbD2IB7TQovGData2lYozvgUa7jdSwzYCQjo=;
 b=QpHOaTVr6GSMwiHaNWkx5/Y6QAP9993+mHruif+rvRdbJ3t3QAps+shP6kU/4o1WfE
 YZ37pgPdS8hF7I+rmqhbIokJloYiUycYPhsFMwdHTjrHysChi5VWqfpN2JhJ9mX1e1Op
 +E1aOiKcmIqotGpy0nqRoF1BgxcbQNSymujlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319532; x=1756924332;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D0mx9sZfbD2IB7TQovGData2lYozvgUa7jdSwzYCQjo=;
 b=lwsYRbx3Y3tfR/6dpQa94Y/5kz+cbpBwa5Kwv7MxVgXGMQyGsidJHyqFnkFblUJSx0
 rw6UeVS4WE/sLwzTcXLo7iYZPXXt/jxOoyqEQ5zzmqikXMTKtl+p57DvYjRN1GEDJ/8X
 8AH0CbR/EhlMP7kVS8CNsG/RjDLlDezi2T5R11bxkFTB6KlQOuyPhMvJd8nOmU0SII68
 KRCznok8SeKd20OM0wvL23DUSuX1kdvsG5JF70fjcOlJJir91wYoFsnER06VGZ5Xuu+C
 uUgpBwE6F9wCt1Td2VBVkaUkwxePJynfaaqAVa1y6rrYLTUL0nYIm+e4oHbThjg5yBbG
 4BOQ==
X-Gm-Message-State: AOJu0Yz0UQtTFIiAXwtiSoE212PADcs8xN66IXpiCcJk9WCONSOceB+x
 9CEc3moTNrdD5mD5IuBriypTOITnZJU7jMNesSBoUiHMFp39w6NcaufIyEpwvy59bfs=
X-Gm-Gg: ASbGnctF5hQIvs9yZoRVKapQMJFG5pKGZwdKQLgPQGW7mj3cM4bmqADTf4OqVrwdEC1
 lPX04wWmBjqKZzQyAmEUnApbbN3fvEXVkvsPVtGjMw/5cHLbDn+bDR/hAm/Ot0AvWMn+0tp28Vd
 nzHCUx4Bmvo1+5nqVaF6jfwOxWuc7AzXeEE5V4iSZg9+Pn65d+ASetVkb210RPXARMVKEfiZhy4
 rjqsW+pI6ZfSKXWpUuwablNce4CbHD9rRyWRvs0c/Qu2Cz4FLWAIuuxGEheU7r5a7WrgnHUYho1
 PWq/PUGPufaXfQrrW++V5U1rF19Pd0g6XwGQYmBS1/cy8HZAA0q1DFFUYZTWnNaqtwFwejubdnz
 9wjJVOvmPlBM2w907q761DlEkbk22d/aMy5OXMP2I/loEt0URYds3beNZ
X-Google-Smtp-Source: AGHT+IEsKiXztvxNNWr21kN/yYLGLWvRNtjQtjpNO+0T+Go1D4HoPnUF74clRwIpC5A8smCS5cWJUA==
X-Received: by 2002:a05:6808:191f:b0:41d:7d24:e328 with SMTP id
 5614622812f47-437851906cdmr8799802b6e.9.1756319532128; 
 Wed, 27 Aug 2025 11:32:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-437968c7898sm2062163b6e.21.2025.08.27.11.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:32:11 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:32:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH] i2c: davinci: drop =?utf-8?Q?u?=
 =?utf-8?Q?nnecessary_parentheses_in_REG=28&=E2=80=A6=29?=
Message-ID: <20250827183209.GM124814@bill-the-cat>
References: <20250827110905.39725-1-bhimeswararao.matsa@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M0ha6nN5qhVm2Dyn"
Content-Disposition: inline
In-Reply-To: <20250827110905.39725-1-bhimeswararao.matsa@gmail.com>
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


--M0ha6nN5qhVm2Dyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 04:39:04PM +0530, Bhimeswararao Matsa wrote:

> Signed-off-by: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
> ---
>  drivers/i2c/davinci_i2c.c | 118 +++++++++++++++++++-------------------
>  1 file changed, 59 insertions(+), 59 deletions(-)

You should at least have a commit message that mentions that
checkpatch.pl complains about not needing these parenthesis and so
remove them, thanks.

--=20
Tom

--M0ha6nN5qhVm2Dyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaK9PKQAKCRAr4qD1Cr/k
CoU2AQCgcZIieL7hr6uYqE0z7ppkhB6zRAqTVO2TOShRtrdSiwEAtXq7kDxwV0nK
niFTSwVNao1VBjc2pR+2XYZIFke2kQI=
=DfRu
-----END PGP SIGNATURE-----

--M0ha6nN5qhVm2Dyn--
