Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009F9C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5DDF87203;
	Wed, 15 Nov 2023 23:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ah/U7+X4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21303869F7; Wed, 15 Nov 2023 23:37:34 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0AFD87483
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-778a47bc09aso6297785a.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087850; x=1700692650; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AMi2mAGf1fsp/BHWHJEyB/nvgMEQ73yY0wAQYAO4+5k=;
 b=Ah/U7+X47qYPQJC3LWYQIkAcJ9g4u18DTMV33hh4nZlh7j+FJ2XY9aqMI/evWsDWo1
 zKby1tdBieJHKRDYlptaaSVZqtfsZL6EuMY6WSi4ZC3TioI0U68uxH1ywfo1cWNdYRZS
 VsL4fbGOwL1/mbw/Jb9+ogUvsZgYNfCB68Wrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087850; x=1700692650;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMi2mAGf1fsp/BHWHJEyB/nvgMEQ73yY0wAQYAO4+5k=;
 b=ImJRuXzJAkcBgspkuYyQ403/P+LrUqQ0WUkJ2BRxyhw6nQfI55319+RU1PijHLfP5f
 PWe1OsB+sVVINdjVjuzX8mFhJf5dom67G0y6Z/AD5bFtuVMnRlM+3lAdLOHMct4NzPXJ
 ppBx5n/EgpB/OM+hQklsOG13U8FMHN72+6kUiVchZarP9BrixERsmJ3JodPYICJwAyDu
 kxABQya1uF2d3wkwtJ2wKX/rmy5YBu4MP5kIH7TGZzd81D+HrAgiHFAx6YYQNYkf5Tyi
 an4oJ2M4faw4Sp6JCs12apxgUmNSQOmAvV0bCcWauZDUGN8TwxPknX2Cm/v4J2qwzm6/
 zKgA==
X-Gm-Message-State: AOJu0YzOMPbn3frlAtowQxah1soNREhM6WUH8755KWB9ae7GlJpuyLzP
 kjGD8ZPGOTSJQGaBAeJadA3jIw==
X-Google-Smtp-Source: AGHT+IHgyPKnAVaUfLAPtcd1EA8sKNWVkYyBxQdVHg9oI6KzzJpqiUgkXdlXtXaIHyxmxkU7F0C1eQ==
X-Received: by 2002:a05:620a:4090:b0:77a:413:2d73 with SMTP id
 f16-20020a05620a409000b0077a04132d73mr8295863qko.2.1700087850514; 
 Wed, 15 Nov 2023 14:37:30 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 de39-20020a05620a372700b00774350813ccsm3800793qkb.118.2023.11.15.14.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:37:30 -0800 (PST)
Date: Wed, 15 Nov 2023 17:37:28 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>
Subject: Re: [PATCH 18/29] fdt: Allow use of fdt_support inside if() statements
Message-ID: <20231115223728.GZ6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-19-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tsI83aUTdsZWfl2A"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-19-sjg@chromium.org>
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


--tsI83aUTdsZWfl2A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:09:03PM -0700, Simon Glass wrote:

> Most of the fdt_support.h header file is included only if OF_LIBFDT or
> OF_CONTROL are enabled. This means that calling functions defined in
> that file must happen inside an #ifdef
>=20
> This is unnecessary, so reduce the condition to just !USE_HOSTCC
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--tsI83aUTdsZWfl2A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVSCgACgkQFHw5/5Y0
tyxahwwAnk/u6/kfGsM+gwB5fO+FqmBnrlLBD583LKEs043AIqqQsRuvJzD5xVzO
c6ti2ViXa5GRgyVueehKymAhvyKwAU/AI+d2qDsDAvVYVjzXyg4Nl3btwnyudQJs
0INZ6JXRb9SJHYGf90aTlFlSb+1meGo/IZvjat71r6at/4cBxwUZQCaPRZui9/zj
RoAgpD6H4rEPI4yTN7coPcN7SoqjdJQJ53Vwb7j9oQ31YSOv3Jph1imIUOPHcXD2
YlG2zrOldSxSyFEIvK5IUc4l/S/vEPzM1L5xjEAQjEMgpD5KXOEZLkHJRXLFlNco
gt9TUsvZO178x5mOI9y8JCBh6LlZnvlSP4JHjcCXLhJU2pfeHW5vZsFimI9lN+vy
c4tW6HEiN9TbIZ+Gi8QbI8NWCdReb2kUtkvn21ddNlmqVo7GqfzKtu8rG/vbF0y4
LV1VbjY/CwbsCdDiaL0POz9Mhio8tZa/YHPy+2BlE7jFxGt4i87uLy35Q4aIgayT
dg7mB5ea
=ll83
-----END PGP SIGNATURE-----

--tsI83aUTdsZWfl2A--
