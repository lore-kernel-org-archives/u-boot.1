Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BD4D6101C
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 14:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A8B83BF4;
	Thu, 29 Jan 2026 15:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h3XPmIxP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC19883FC8; Thu, 29 Jan 2026 15:59:31 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99CFA83EF9
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 15:59:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d18a9d2b1aso1059811a34.2
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 06:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769698768; x=1770303568; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R6pK0bSklrYj0IDJC5CJT7eOA8H4ENqe8G1yMrz6x14=;
 b=h3XPmIxPI9m41RerzcdnWPBUddGbh5EoRbbTfjpPv1VvSSX8MWz2qKZpxUutqzzfQH
 jOJIhrE8w/8WxUZtWRH7b8AcG0p3slI0bj+djLQavuC7M2/6Du3lzWUfMfSCNoxMfdgY
 yyTnSTr5RfIMCN/CI5xEnBRdD0tIdW5C6WICc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769698768; x=1770303568;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6pK0bSklrYj0IDJC5CJT7eOA8H4ENqe8G1yMrz6x14=;
 b=EZXl9/fD9Sp7v/fVTrGRvW/vxP4bjvLFObDuJlulxE4K5veX67JkD1dUfduokFXQYl
 z9YqtRI4VNP1mnXOXGpjxYQiRecA094YoxzHrlkt8XEIoIICl5tK80M2xCv3dpwprTJh
 +7BSSUcyxmpDF5olwAQ5reG8KS7nxpuQ07+DyjWdphzKK3URZuu9+2vNBEzmJf8dJLeI
 XZ8vhXm1gTk0SNBpbA8WpTR0PMPTJ/iUYbKSI9zOmjLpuc4v6kdlo99h/W+iKOBGYn51
 /bZUkadw8DgT+8WcT7pEUjlq7DHr2+NiL39NA4tKBHmtwl2Nw4/Fv6p9bk1PWqIW1DBw
 T5EQ==
X-Gm-Message-State: AOJu0YzrNDpEa33i/SLcm+87T5gPgmwEpyu1N9Tzu8QcqJAg+58KQVJy
 aQ3Bm7mjMPZJZnhMCdlgEq/h6Ccs77Ycgr9aiyOrwvZGaQputnKN8Z6wCDmh2gICUqI=
X-Gm-Gg: AZuq6aLV3rMNljAFb11T3o8SwkULtIvpyAwsLrDhIEIRa5pjM4JYb8zBLYXNu8jP/U3
 jEc/SFJPXq1u5PupbSK8b8Z4YGm14fHwJtvLAf6GJY9xQ9w2BORZZAR6U/hE9qBMpUIFbz+cqPJ
 pLG1vTHaweJdERU3B9T/xFgzg4HD853irlsK0jlFq1ddNhdR9uWGvkCAa3cPyitCwr0OyIfQ5Rc
 PT4xe7B+qMqOfHSeNH34j1lTMSYoIg7XLsoK91eBX0Nmx0nC2C/8ooXJfyMYI2qZZrAJvoy2o3i
 H6dWrJhI23d4Xp6zo/xwR26tTou51vmZZxef3dcWoIDF+Q/RSFgNnAIIlkZj2p8TRjOS1OT1hJu
 Xld52Qt68+OnJgGxxRTtFTmrf19OKcSPATNOilVcIpvFUfWQmlCeL5SX4bjzrj9IPaOUdNI94x1
 AFriDpZ4+j+6FEDgjV2pLdfozXN+sPEP4WD4aamv6C/QYsNRIjO2HfbroDlhvXFGu41638WK481
 fRkWyT7VPh3oDSsMGqA5IniPrf9lStOuNH7kE/ETpnCv35qNg==
X-Received: by 2002:a05:6830:25c2:b0:7cf:dd0c:2ba6 with SMTP id
 46e09a7af769-7d1850e620dmr5440533a34.22.1769698768349; 
 Thu, 29 Jan 2026 06:59:28 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d18c69e632sm3792873a34.10.2026.01.29.06.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 06:59:27 -0800 (PST)
Date: Thu, 29 Jan 2026 08:59:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>
Subject: Re: [PATCH] misc: Keep FSL_IFC available on PowerPC as well
Message-ID: <20260129145924.GT3416603@bill-the-cat>
References: <20260128192617.1724570-1-trini@konsulko.com>
 <PAXPR04MB8459F4847B32CECD8E039101889EA@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XlM+gZp0Csm++xoP"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459F4847B32CECD8E039101889EA@PAXPR04MB8459.eurprd04.prod.outlook.com>
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


--XlM+gZp0Csm++xoP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 03:25:41AM +0000, Peng Fan wrote:
> > Subject: [PATCH] misc: Keep FSL_IFC available on PowerPC as well
> >=20
> > This symbol is used on a number of PowerPC platforms as well, so
> > make it available there again.
> >=20
> > Fixes: 424b324165ea ("armv7: Add CPLD support via IFC to the
> > ls1021a-iot board.")
> > Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> Acked-by: Peng Fan <peng.fan@nxp.com>
>=20
> Tom, I not have patches for fsl-qoirq queue. Would you
> please directly pick up?

Will do.

--=20
Tom

--XlM+gZp0Csm++xoP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXt1zAAKCRAr4qD1Cr/k
Ch36AP9sQma4YQZ0iO9BiHEjkysUsqr78Wbl+U0b27eHyBmFhwD/W5BYxm+bQsaT
XRwWQ+lyRsgNFFeaApbSZIHhoiDUvQY=
=Ht/9
-----END PGP SIGNATURE-----

--XlM+gZp0Csm++xoP--
