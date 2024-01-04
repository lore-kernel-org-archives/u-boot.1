Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0921DC47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 13:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60CEF87952;
	Thu,  4 Jan 2024 14:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eB7Tvdi6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF2887716; Thu,  4 Jan 2024 14:51:47 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 305F18788D
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 14:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3bb53e20a43so378529b6e.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 05:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704376300; x=1704981100; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jFbb3iyghDod4O+g8hgb6jFTq+b3HmKsZ0bKuXGbtqg=;
 b=eB7Tvdi6TPO4m+AQIF9CcZRxIX2p6aiFtx1It2ukp7xXOA9biZ6I0cEbJfq0SQV6QJ
 qNkZB6EG03bcSMMpDDTNDjv9vU0KXGbnHZSzh0eXKbaDlr/UqNGS1RU++xmpWx88kywV
 tFuaWP5MmNNfaTsNeNOQsCTNEGn2g/0JNB4g4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704376300; x=1704981100;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFbb3iyghDod4O+g8hgb6jFTq+b3HmKsZ0bKuXGbtqg=;
 b=ECoQmi0rCGQq/zs21hdbr/bJQPD3GReSA5uy5gIXBYY0upUaWqzdG8D0i03xmSmxJc
 Mnt7uo/Y75xbarltPGeh9wD8ysbA5LAPc3S15Ec2htI8OTmqo/Gnnbhr9U1+/X0KF1vF
 bOebbnTNWHVqnUuVcDUtD2tvp7pHDqy8w7aEeF6WYDyEkl9zp3SVm6UYf1tbaRns+ni2
 IrW4yS3AjzRshOED2vP0k95DTaOy2Ke7V17OT7nQTng5V8+W+ufgIeRtCGb/y8mSPDyn
 4hIeSY0Yjx+lzaeEbHDjNFYwWtsZ3wzmRp3zHIl0Qfjog9elO424wt/3FDA5cJZi6TpM
 +C1g==
X-Gm-Message-State: AOJu0YyxEm2h38jP32X6poHc0LHrXh7B2DYqSX4Sx6C/LATgCqLTmx56
 92S3K+VI2TXdyoMpr5NdNroF5DiEHbtDqA==
X-Google-Smtp-Source: AGHT+IFZvMYFZBHatM8QBqWa0Yi0hzqQ+qEwJ5xHqONBr8Yqm6fohAagMcKuudFb1SDjGjp1y+gL6w==
X-Received: by 2002:a54:4e8c:0:b0:3bb:c55b:4bf4 with SMTP id
 c12-20020a544e8c000000b003bbc55b4bf4mr596624oiy.108.1704376300438; 
 Thu, 04 Jan 2024 05:51:40 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 mg14-20020a056214560e00b0067f70cc986asm11761916qvb.92.2024.01.04.05.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 05:51:40 -0800 (PST)
Date: Thu, 4 Jan 2024 08:51:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Raymond Mao <raymond.mao@linaro.org>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Baruch Siach <baruch@tkos.co.il>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>, Johan Jonker <jbx6244@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Samuel Holland <samuel@sholland.org>, Shiji Yang <yangshiji66@outlook.com>
Subject: Re: [PATCH v7] fdt: Allow the devicetree to come from a bloblist
Message-ID: <20240104135137.GR1610741@bill-the-cat>
References: <20240104014919.413568-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+GdxkpsmxnbX3mI9"
Content-Disposition: inline
In-Reply-To: <20240104014919.413568-1-sjg@chromium.org>
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


--+GdxkpsmxnbX3mI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 06:49:19PM -0700, Simon Glass wrote:

> Standard passage provides for a bloblist to be passed from one firmware
> phase to the next. That can be used to pass the devicetree along as well.
> Add an option to support this.
>=20
> Tests for this will be added as part of the Universal Payload work.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Thanks for reworking this.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--+GdxkpsmxnbX3mI9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWWt+kACgkQFHw5/5Y0
tyxnDAv/c82+nfBbkaAIhflG5ESDrTvyNJYxm9RazVAd3O2jih4h3OA8b3Kvbkqf
MyBNqARvnQMujtCjYc60pfoWF5WyUDGX5e0EfSPOfuDJFIQXzE8m2nYw3UPXKScp
iJ/xpwNM6UCtBaW0EtoPV6qqf5rmsms5Q8xid/ZaO51OQwmbqT/uD+EpHr4lYOGA
9+h4+LX0p9L2sjKhI9JrNasf7P1DD2u4+jm+zIZq40N56vIM2TLywLPEM2cHvZpy
ZLSFMMuhSczFXO3ByCL36qC1/tI8Q/ck43+bt5IVMOs6+E9esx/TVTBDOX3abUvJ
bgysc2A32fnRZTdKlnNnY9Q9PsrdyL7NwskEc98SmTUNocmt40kCqZIGYkH3TtY+
SAaSq3VnryKVwB6iUdCYGB1Uya+EqJtzQWxv+Wqd5XZWrIvPM9RrHgsrUQEqXqN9
bxXlvmflZb0BI0ZaDXQZHkrK3rr/MO0MKnttPTYBTkG/Hq8st0Ek+HxOjDutlZ4M
uAb4mT22
=oTDU
-----END PGP SIGNATURE-----

--+GdxkpsmxnbX3mI9--
