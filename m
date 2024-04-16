Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7A0C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 00:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E712880D6;
	Tue, 16 Apr 2024 02:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b/elmgvR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6802787FA1; Tue, 16 Apr 2024 02:36:13 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD08188158
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 02:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-69b2f6d31c1so9190616d6.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 17:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713227769; x=1713832569; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=viIAZl7Bc80JFxwQw33FCmByjtQQFEgGjj/mVfTpZEA=;
 b=b/elmgvRWjQmJqdHfQ66eezHx/Lg9MWcCnyWHkRW32x3qwwzfUJwhgB3dqfPYk1L79
 BVe7RoQ1Lc7zFfoN/l198rVcwR/Pv8H7o+aH8sDjpvgcm4XQsJesVFZvw1aa+6dCFnSc
 efR6/4m59LZvP/1xjV83KFScE8RgWow2JODSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713227769; x=1713832569;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=viIAZl7Bc80JFxwQw33FCmByjtQQFEgGjj/mVfTpZEA=;
 b=o2mxKufKf5uQdMXwcOEkabzUyo7p53kXoDdZCPM36P8Q1RG0acwjbgXJi/3XnghTIK
 3+EZkB3BpaRNG8TG/syK/eiK2rzAQkmKfqYjcS4Fgg6byIc9gJOR4g4iBnWCQXubdBVr
 5hgv5yrSyFxahBy8xouTzwP859lQ7qEM5GN4Xmb5Z3HRnSTWvYELpx8uov8ryGN7xXka
 v8hZasX+pwyXidzQcsP/HTkkK7VBAJ4l0PGWvRy9+Ibcx3tv7/ojNY4Fjq9EThjyFEn9
 XuAfdf0SDEJ2HRMhuJrryFKeUh9uYu1eKocHqu6hFhY1QJ6hdnuT2vLo8UcQQ+LGqxJV
 FK8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9CU7ZIcp3CGxydxc89MD34GzRBLXVRCbwn3JVakDg+BGvgA8b7BG1mRgbRRj5grtmovG88sYgqAM9aI+br5TiMMiOZA==
X-Gm-Message-State: AOJu0YyiRhTnjesfMPfp8ZoyM/cOFfRbypwoKqiu3OUEEfmATAN87fRH
 2jCcMhuuAmPKUAxC6uV2X0jV6PugItZ114PIsjk7dioLQbCBElnDWg9SEzen2ZDmcrxRHJsAjej
 dpOA=
X-Google-Smtp-Source: AGHT+IECYhDfbQAIT0942XGur7DME5xv8Afp5AUVfWtbblGjLsOlssMnrnhoAOVAtnxmltrcjHD/2A==
X-Received: by 2002:a0c:f94d:0:b0:698:f66f:bdf3 with SMTP id
 i13-20020a0cf94d000000b00698f66fbdf3mr13062289qvo.28.1713227769547; 
 Mon, 15 Apr 2024 17:36:09 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 h19-20020a0cab13000000b006913aa64629sm6907119qvb.22.2024.04.15.17.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 17:36:09 -0700 (PDT)
Date: Tue, 16 Apr 2024 02:36:06 +0200
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH] env: mmc: print MMC device being read
Message-ID: <20240416003606.GI1054907@bill-the-cat>
References: <20240415-mmc-loadenv-dev-v1-1-4dd649e0c298@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4895x11jWCtIxUYb"
Content-Disposition: inline
In-Reply-To: <20240415-mmc-loadenv-dev-v1-1-4dd649e0c298@theobroma-systems.com>
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


--4895x11jWCtIxUYb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 02:43:57PM +0200, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>=20
> This prints the MMC device being read similar to how we print the MMC
> device we write to when e.g. calling saveenv.
>=20
> One of the side effects is that the boot log now shows from which MMC
> device the env was loaded:
>=20
> Loading Environment from MMC... Reading from MMC(1)... OK
>=20
> This is useful to identify which MMC device the environment was loaded
> from for boards where there are more than one (e.g. eMMC and SD card)
> without adding some debug messages manually.
>=20
> Sadly, there's no way to know which of the default or redundant
> environment is being read from env_mmc_load before env_import_redund is
> called so it is printing a bit later (and possibly after error/warning
> messages).
>=20
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--4895x11jWCtIxUYb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYdx/YACgkQFHw5/5Y0
tyxBlAv/RJdFeqKB7k8NdO7XFyzio+QsQJ31Q0gqQ7wTymF0Z0WPeWTG9zd0u4XG
NSaBpPF7jokC3pY/ETSb07KNcLh5zwYUtQTQfWpdSdE8HzCd15nfNqiJBlhtsqVM
Y1fCZrjkOHBdtQI/DLTPvjy0RUjw5AaDcN9nhw868nl/qzlpYA1TrS7KK4u8MXUJ
KUswsB41/IIS8NRCcYujzaPiP9zeaLbXgy7+WUbyobpJoOd5dMQcDsrtjk6r5tK7
OjNrKMqcl6M3ljaFoDWZqDfK7s7fwM29ofrKhQrh88IDwF7eF10xjg/EPm/OgT/2
W9FYN86N7Z09ODg7fGtXv+PAOp5R58ONXgqXhy/3ISfBa7DuCD4ch8sCCgwYoQ6A
kMwr0YyKH24cVf0BPsth/kAwFG7Est0yOtRxi+/BIFJjH9PJ52gluxKFKlzgmWHx
pWx0xxG0whAv+ewdFUzT7nZGrrc2dXayaRvq/XkROP2JlJIcgpRkvUHTQMIS/rNW
VKf7si2C
=kVJ+
-----END PGP SIGNATURE-----

--4895x11jWCtIxUYb--
