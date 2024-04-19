Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B644CC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C4CD88258;
	Fri, 19 Apr 2024 18:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ivpsz0AS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E4AC88244; Fri, 19 Apr 2024 18:41:14 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B247488258
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2da08b07157so28736631fa.1
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713544871; x=1714149671; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5qDD1Pmxpp98RwDGP5mwr7uVMCYlD9zn/TURBUf8leQ=;
 b=ivpsz0ASaWr2QlQ+9z98cRIq6GEadMZ46Zn46q7gJFbZUBpBmaewyj4Mu0CrQJ66WE
 VuQoiyPRa1uQNksnIA/60BDO/fidW13GEkN07u1L605aWuLVCw8UZKwvKPrnb8eVIMKI
 KPDiwDa73Tg/JMCNe4pkevhFuxvtozV2NWr5duXm7iFfSuqulju0HDbhruQUXqaHaeDo
 DGO6nwXGI6mMe5tF9MfhCa+/EGuW95x8FqMv3XL+rn+4gFwiKBRDKmhyiPv5Qh4+d9CE
 ULjcB3VKNkNchkT5uxPPbIK/Iu8/wDKSMhmsNY7ei4u+PrE45NvCZNm0UoA85MrcsVYl
 IVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713544871; x=1714149671;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5qDD1Pmxpp98RwDGP5mwr7uVMCYlD9zn/TURBUf8leQ=;
 b=vgMVWwws8Mn33cRqlqJfpBD9GmX7t3vEmyo5JdF+7gWWR5+JaOd+vN+FYKdAjQI2yv
 WtIKjNbmksTaiy56bUWykOcuYAMOoPWB5j9uThu0HdrFOK8WSTKfDxHsAudeYcCiCifT
 eBzolv7hrJ9/0JDJ36KOeKv68wldZw4avfdLvUGym81R1hgZESPQyZWDWP6IuF0IguDV
 tgk6uBBEU3vWOmMFg5eh0zATh71He0DdG2I5EJaVjeklgG1nozq8PUoneCtNipQW/PTC
 Oa0odYWOm2/TXbbFUoqcD3Xkm2+J/QCUuqZwWJqvkdM4A9TJGlJ1WIhFoQEuIdoLfG2X
 alLg==
X-Gm-Message-State: AOJu0YwlLoRnFVb1N1nEogs6q6vzrSkYdDJAHdN2nB9kshbztktOnhKQ
 F/U4WRMNEBxyb4awt/XopUb7kfZS6jArPB5Qvd1S2fNVFpfwkpORPcIxNA==
X-Google-Smtp-Source: AGHT+IExmHlHBg+88NgYNqUu2tdWkAPirvMCHmsqZeHsXFbVUvdp+M6LmGCqNFSTox62n8gLLkOJtQ==
X-Received: by 2002:a05:651c:1414:b0:2da:16fd:5c9b with SMTP id
 u20-20020a05651c141400b002da16fd5c9bmr2117342lje.9.1713544870619; 
 Fri, 19 Apr 2024 09:41:10 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 f24-20020a170906c09800b00a522f867697sm2375600ejz.132.2024.04.19.09.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:41:10 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=540ad970af5b979a5cbf6a6ce14ac341270ed320ef96cb851a2d76f8d49d;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:41:09 +0200
Message-Id: <D0O8YLUHKZAZ.1DFGQ30RHORAD@gmail.com>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 16/18] video: tegra20: dsi: remove pre-configuration
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-17-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-17-clamor95@gmail.com>
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

--540ad970af5b979a5cbf6a6ce14ac341270ed320ef96cb851a2d76f8d49d
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> From: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
>
> Configuration for DC driver command mode is not required for
> every panel. Removed.
>
> Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
> Signed-off-by: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/tegra20/tegra-dsi.c | 2 --
>  1 file changed, 2 deletions(-)

Yeah, this seems completely unnecessary.

Reviewed-by: Thierry Reding <treding@nvidia.com>

--540ad970af5b979a5cbf6a6ce14ac341270ed320ef96cb851a2d76f8d49d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYinqYACgkQ3SOs138+
s6FV8w//dUupj+9eN84tJQo4tpiG+/Ofo2QTtZ34Jjnjly+imdN06PcgIXqr54N6
CJ2Yo6qvdHsmCnEV045x+r1/v1vw4YtLMQKgVDDKk475oiTuQ2gWlwVzVRetaLVx
mAl7y+NK4IrP6GyOicyZDVwqF1BszUUJvttvCEvbx0l1uG7+iQJ6A/LVl/iTSUWX
azJK29WQA25tyf3NtEh38I8uVDRx8jw10GCIBuB6+FdHsM2yYU9JT2YnDBPAHQ8O
WOJ5UmBIqC6p4+QwfHbgNtrLtw/RL804f+d1u6kMg0goLW3TdDtC8MDyjScUhY5U
0aUmDORo/aqR6H8AGbK/kpMBDqgjE06SqliKODLjMpFg0UjbemVnM/AKpD4WVbeL
1IMr1i9h6ta6gkUAr4J4PySEHbFCtDSk6sB/tJTFpOUYZstYhd6zdXSwfRws6WCN
+JKVg0hYLxMf8vByyX8tdqs/vxg4bkQQhxy64A6mo56MN6LEGr7/1PWeFcoEFC2i
ANrX4NKDEp2xpYPD7LsV/nu0Z9gUhJHB0NypwkY3rFuqWzueTI7UtwwNOpULOkLA
HEWtrRLR1ZIqU63rXaDhWdS4azQVxtUb4t4eeeFR3zPfdBHODD2ogwa0fPddHwlc
zjVBnWWsir09nmBZNU3RsQA+MRIVrZjVBHTzLgeqAxmOeAE/H1o=
=cBiq
-----END PGP SIGNATURE-----

--540ad970af5b979a5cbf6a6ce14ac341270ed320ef96cb851a2d76f8d49d--
