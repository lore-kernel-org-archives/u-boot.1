Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D72FA3751
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 15:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B0484228;
	Fri,  2 Jan 2026 16:14:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s9vCigPz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 447528426C; Fri,  2 Jan 2026 16:14:25 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24C468399B
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 16:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-3f0cbfae787so10257065fac.3
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 07:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767366862; x=1767971662; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T5R5v9TtpFZQofxMQjzt9lgXjtJvUz6fP+HJopHwXOo=;
 b=s9vCigPzCaULu0igbxOHir55IEzGggldv+URlOf2d1+vyXyy27x9RwWacWhz4VD1i4
 rBK8z29ojmkY4x/rKJy3mn73OvPkxKRb5SXfY1DXrpRY5MEGfX86jnMg1KfO01FxMN3f
 tg/xOvSspb/emmA1B+MJuptMGTO1ZHFhqH+bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767366862; x=1767971662;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T5R5v9TtpFZQofxMQjzt9lgXjtJvUz6fP+HJopHwXOo=;
 b=wqlx0DqjomGxP+dN6QYRhCd+QKh+3pL9p3EGy97jsC5P+bUsXNok2MLcd4T6L1zLLk
 urPJbWOY7evhLMkwP8Q8QkKjkF6JgPFuOM2l8qyLssKfCBCgs8d0FDEolAOYLL+fyQ5k
 6gDzJt6cxA62T1/ljsvi/sLhDMep2Objd6ovdIoiu/i/4oLXjjV0I4cAc1CtNGvZwus+
 N61SXcFxwiNZHt/5kD9h4ojWMceeuVJCr71iATRujT25BGDzNJ77fjwPvYf5d0U4mle+
 1mTZRfbWSLd6ylaXTJ2cz5SIfaXBt66zCpdd2Z0c/LEWTkqI1ifguYn/VudW4MMNKhMA
 hVpA==
X-Gm-Message-State: AOJu0YwWxu6Zl5ssPStsD/rmeMqiwva951vFqr8GqSWc6MhhwKZHH+P5
 0GT3JKhzZogwWwcCMrW+MJtW82vQV5q9ayAGinuGufRlcGz0AhginlLnUkWspUyf5dDZZaPzQfK
 Qsn5WqGM=
X-Gm-Gg: AY/fxX6TpQDoBNZpE1m5zd4dUA+DObLT6pYTZId9N/wbxCzwalDota5pAYXisvmStZB
 ssy9RvTDvq9dmMLs1OnnZu7I4V6PlnKPgK12FOi0GemLeKtD7FF8mNhSsCo+OpZV9Ml/IjzGkUv
 MpjL8gfGOlrZCeWYqscEEBaBVvSihcvpe+IAM4mImNSZWp8ThxhiWrInqvlj90QgY7hgFxxxnZY
 BxOtYDnzWgOv3Vfzo9H1hcIeOMIGn2vZV4pe+qgNXzO+47OR9RbUIB7rWiOfxXWMe07H2ImWhGN
 CRxy2RmMZWL8w8Z+b2Rz7Hyev0Ip1FUGPd+0mMhVzj+qpKSlyUDyHB1tB0f26wCl/HhrlyPdck8
 7uzF2EvJ0uY4iIoohya7RJ4QCB/bZw+FuR4BiI8cTFsZip5RBoqsjY5sbUrbE/HiDpx9t1KKNDd
 iXboemS5rW0wAQLi0XEwxoP2hBgUtZ0oYlZGQoG9lhbrR3ZsyJsxNP5n3SmpQ3N4EyLMDGSvqnX
 G92WTW996z147/JtH1wKSLbmsCoSKBBp5CZkoY=
X-Google-Smtp-Source: AGHT+IHa9fIPn0qS4685zz3LWoqFTzH6raepI7bXg5FsFWZWDwI6QV3gEfPKFoNmrU/KVWs8Vo03EA==
X-Received: by 2002:a05:6870:b529:b0:3d4:8741:edd3 with SMTP id
 586e51a60fabf-3fda56949cemr23713484fac.20.1767366861762; 
 Fri, 02 Jan 2026 07:14:21 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa931b0esm26270668fac.8.2026.01.02.07.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 07:14:20 -0800 (PST)
Date: Fri, 2 Jan 2026 09:14:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome@forissier.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] net: tftpput: Rework to exclude code from xPL phases
Message-ID: <20260102151419.GE6124@bill-the-cat>
References: <20251225153721.1217202-1-trini@konsulko.com>
 <47b1c881-07c0-4b8a-a344-6ed09ecd926a@forissier.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vxAmpkJcxeJbY5SX"
Content-Disposition: inline
In-Reply-To: <47b1c881-07c0-4b8a-a344-6ed09ecd926a@forissier.org>
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


--vxAmpkJcxeJbY5SX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 02, 2026 at 04:12:41PM +0100, Jerome Forissier wrote:
> Hi Tom,
>=20
> On 12/25/25 16:37, Tom Rini wrote:
> > Given how the support for CONFIG_CMD_TFTPPUT is woven through the
> > support for the tftp protocol we currently end up including "put"
> > support in xPL phases, if enabled. This in turn can lead to size
> > overflow on those platforms as xPL tends to be constrained. To resolve
> > this, use "CMD_TFTPPUT" in the code to check for both CONFIG_CMD_TFTPPUT
> > being true and not being in an xPL build phase.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Jerome Forissier <jerome.forissier@arm.com>
>=20
> From now on, and pending discussions with my new employer, I'd rather use
> my personal email (jerome@forissier.org) for open source contributions.
> I've sent a patch to update MAINTAINERS and .mailmap [1].

Understood, thanks! I wasn't sure what was valid yet and didn't want
this missed.

--=20
Tom

--vxAmpkJcxeJbY5SX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVfgygAKCRAr4qD1Cr/k
Cg7uAPwPJ9AtLc6zki6Cb+8jvkEjJRvEpokF/tffW+SkXeAXMQEA8rcWmdd1+uO0
0ofT/mKpw34sXF3UrBeLV4p/N16jtw8=
=+IiT
-----END PGP SIGNATURE-----

--vxAmpkJcxeJbY5SX--
