Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C60C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 14:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C38887EDC;
	Thu, 25 Jul 2024 16:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jCmh892t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B739387E23; Thu, 25 Jul 2024 16:49:55 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 946FF879AF
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-70936061d0dso257594a34.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721918992; x=1722523792; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w6jCxtVuBtR3fv+2ZszYT7f9j/hY4uHjQ5qqzSnNpjc=;
 b=jCmh892tdY1W5BRmjNbeNUxAXxQNToTEcTn2RWMC/bFGof4zav/8GwTRcxqGZ0RSX+
 xO6P3hek1YmfFLKxXrnB3IbC0NRWzt9Ac4t7KpH5HFqT6KdaaG+qxfKKpF4IWjZDeVWE
 LmTxnQhvIqtM58ZTgtoJB1q/UYMj0gm2nSAKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721918992; x=1722523792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w6jCxtVuBtR3fv+2ZszYT7f9j/hY4uHjQ5qqzSnNpjc=;
 b=QqL8JKj7H5sByrmZHsoFFlmv6fx49qGZPUvUVX9UkOnd/nwVQpAngSNQ0rjKvxyNnE
 XLK3opLDHVXCl/0PY+DOSqERHA0hGzDdKl92ttDfsEF+iUat9/LCcnUAGSvpX1U6MIjL
 IB3U3dESWnDCkiAT/E4052Q7VKifCnz+lO7Xkq70PopBMoIwOA/BJQbjJ6eJCGWJgZW3
 9RC2vSQEiTDRvQ9roug6YUJpL7iFYI8eiEDuowEgSBBUsOtTreGh8tXeJtbUKJnzKHTr
 gvfgzglA14KCa1WPC40ZodYn0qdaDCUKeLZ9JfdsfgFnjq7/bHkE3pdcHFMQ3t2yOnBj
 OhLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4PztBg8pbeROI7fjorp+dKsIIZ9u44Gqjr97IvPwWXFL2Kqml86gYFzD8JcQPuLKD5NSqTQJcbgqf1uh/Yjn8Zk9N5A==
X-Gm-Message-State: AOJu0Ywj9tzTBiwYRiWdv1++bPW759+zxNGchncn5TrFh75iU2zjhh03
 vnCBM4GX0rtZwkBgUXUWNEzjvsFFMroFul58REzbqEynBJ936yVLGhsVMN5zPXM=
X-Google-Smtp-Source: AGHT+IH3bNqunuSb84wbrmRG5c4uBLcUm9mYFbLLVZYbUK29o7dITrUeOxtDQ6AVk7fFig5zvi4wCg==
X-Received: by 2002:a05:6830:b96:b0:703:68d0:a267 with SMTP id
 46e09a7af769-709321146c5mr2751626a34.3.1721918992295; 
 Thu, 25 Jul 2024 07:49:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-709307088c2sm325062a34.24.2024.07.25.07.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 07:49:51 -0700 (PDT)
Date: Thu, 25 Jul 2024 08:49:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 04/40] lib: Convert str_to_list() to use alist
Message-ID: <20240725144948.GU989285@bill-the-cat>
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-5-sughosh.ganu@linaro.org>
 <20240724205418.GM989285@bill-the-cat>
 <b81b9431-4681-432b-ba24-3e24e7e1cb85@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g+s10Gp1ozEKMXcs"
Content-Disposition: inline
In-Reply-To: <b81b9431-4681-432b-ba24-3e24e7e1cb85@amd.com>
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


--g+s10Gp1ozEKMXcs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 08:13:38AM +0200, Michal Simek wrote:
>=20
>=20
> On 7/24/24 22:54, Tom Rini wrote:
> > On Wed, Jul 24, 2024 at 11:31:48AM +0530, Sughosh Ganu wrote:
> >=20
> > > From: Simon Glass <sjg@chromium.org>
> > >=20
> > > Use this new data structure in the utility function.
> > >=20
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >   lib/strto.c | 35 +++++++++++++++++++----------------
> > >   1 file changed, 19 insertions(+), 16 deletions(-)
> >=20
> > This is rather big growth when we didn't already have realloc:
> > 05: lib: Convert str_to_list() to use alist
> >     aarch64: (for 1/1 boards) all +1765.0 rodata +37.0 text +1728.0
> >              xilinx_versal_mini_emmc0: all +1765 rodata +37 text +1728
> >                 u-boot: add: 7/0, grow: 1/0 bytes: 1728/0 (1728)
> >                   function                                   old     ne=
w   delta
> >                   realloc                                      -    112=
0   +1120
> >                   alist_ensure_ptr                             -     14=
0    +140
> >                   alist_expand_to                              -     13=
6    +136
> >                   alist_init                                   -     10=
8    +108
> >                   alist_uninit_move_ptr                        -      7=
6     +76
> >                   alist_add_ptr                                -      7=
2     +72
> >                   alist_uninit                                 -      4=
8     +48
> >                   str_to_list                                204     23=
2     +28
> >=20
>=20
> this is definitely not acceptable. This mini configuration is running out=
 of
> OCM and we are already pretty close to limit.
>=20
> What's the reason for this change? I can't see any explanation in commit =
message.

It was more clearly explained in the cover thread for when Simon posted
alist. This conversion was an example, so dropping it from the lmb
rework series is fine.

--=20
Tom

--g+s10Gp1ozEKMXcs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaiZgwACgkQFHw5/5Y0
tyw8EAv/bmJiJ+J75XJ1fQrUQymL0kAMKCJAsCxQiIe5Nyy1DKOttxrBzcQSe1l2
uRVSkf5gClP9StfyNqstqVw2pGo4+dOxg42esUFw5G3563aAcPmV+Ix5LvN8N9ov
lLuT9gfSC7PH7V0uJhTNJN+smYNZ1cVoL1AmKh0ERHrFx8gln2tQn79wYEVLl5nx
emxB3Q6fuwjjDt2CDr0SfpLvgnVnbDAG3/WGXLku0YpfI7H2pafjK/2sjYsL9tFX
qrTfG9JG9ZKqpuOeeyCGUkqIfIfMktRvxpJI0emBcoCo43c84fOJ2iWIArYDq9rf
wG5EzNguarickwztx1TeOqehGxYii+ge9Rtz4xNVo/N2POSNlXW6Cntgr5JUO3HQ
v6m5RS7g4hsnAMfHYaADHvZXH1kxDoQ3rnk7Lk3VDga2+tKx66Oa6gS8HPw6hIeR
yrHznGW2U+8bo/njJM9J3CmEPr4Iu2557eulUzw4aJPKc0uCJDK+HoKGrsdHWLE4
/ZmPctET
=qXWu
-----END PGP SIGNATURE-----

--g+s10Gp1ozEKMXcs--
