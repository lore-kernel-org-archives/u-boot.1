Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C27DC54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 13:28:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF3C28804C;
	Tue,  5 Mar 2024 14:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lv8P87DT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F188804C; Tue,  5 Mar 2024 14:27:54 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D91987FA5
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 14:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-68ffddd89d1so21490826d6.0
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 05:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709645270; x=1710250070; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q+V0jcFnFtNOIn4Dn1kQKn6vQFqKMLY+AhksrYOBhdo=;
 b=lv8P87DTCvydNA8KHUUXX8lpTusOuygTFeCnnou1gZaYUWAfOaDwSNdy7y6xPCuwSO
 7jEjEcYJIUYktz4aKDvTftVC4EXXOL8YCTv2LYQftBQ4dzmyyYC6sq173ajkGWho0MlR
 qBejA/JE9nekjnHX/SgNESyeoOl3TBCqyEAcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709645270; x=1710250070;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+V0jcFnFtNOIn4Dn1kQKn6vQFqKMLY+AhksrYOBhdo=;
 b=Uw9/Q9AKH/hHurHcScKXA1G3RNHkGj7KGvu+N5OPZmwUwg5NZF8fSEcSrTC9G+UBse
 PgeBUcVCG3yJZoo01BGhagmYi7VDP+MUYYxYQbT9wsLXlP2Ysx4e53zP3zJpOPFoEPII
 3CwZJjitVqhk1V4ZbKarpgnzYrHumFup07icVLc3Hgncv96ZGjBgSxttLgSwcg/5ftyY
 glg27116y35Q7XpwmDMclrBNvBSFd7dICr7Xz+gFiYl17VCXqlolQrZMetiOqanTwUos
 qyJsbeC4pIkE17h1/iwVe7hbgFUKbpJdE9CK9v3G69FUH8pvFxV5bVULDHffcFmYzTL3
 NL5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD21y8oJqgwTzTdOOZW2uD8Azy04cg0Gczrynj9K7RLnNqetbvP7jdeNZJu4JA97FqgoZahSV8TgnUL7lsf1+kx+1ipw==
X-Gm-Message-State: AOJu0Yyc8NikX4Cu3c1GkOv1Wa03VyoJVsyXDabavVn/wgQyzgnND1ty
 ZvEA42L+EKUlwc/r+SBw6T2RaKKyl1r6/QjTCEJtktWAFvOKr0e9HCM856GVAEw=
X-Google-Smtp-Source: AGHT+IHKpzlTNtWQ4KCwz1996nYIQyoNH3E8dNtK9KZ2wwqhJ+LMI5gZ6+u7B10o8XNNMaxlouSpQw==
X-Received: by 2002:a0c:cd88:0:b0:690:871e:ff7d with SMTP id
 v8-20020a0ccd88000000b00690871eff7dmr1786538qvm.36.1709645270058; 
 Tue, 05 Mar 2024 05:27:50 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1000.res6.spectrum.com.
 [2603:6081:7b00:7f::1000]) by smtp.gmail.com with ESMTPSA id
 nz10-20020a0562143a8a00b006903af52cbfsm6266401qvb.40.2024.03.05.05.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:27:49 -0800 (PST)
Date: Tue, 5 Mar 2024 08:27:47 -0500
From: Tom Rini <trini@konsulko.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v6] remoteproc: uclass: Add methods to load firmware to
 rproc and boot rproc
Message-ID: <20240305132747.GC1523872@bill-the-cat>
References: <20240228120645.958316-1-danishanwar@ti.com>
 <34e1f240-1a5a-4982-aca5-43a508c469f5@kernel.org>
 <1a5bf390-f3e5-4ed3-9cc9-10180bf0737e@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4oxCFYueTeQN2BAF"
Content-Disposition: inline
In-Reply-To: <1a5bf390-f3e5-4ed3-9cc9-10180bf0737e@ti.com>
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


--4oxCFYueTeQN2BAF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 02:39:14PM +0530, MD Danish Anwar wrote:
> On 29/02/24 3:43 pm, Roger Quadros wrote:
> >=20
> >=20
> > On 28/02/2024 14:06, MD Danish Anwar wrote:
> >> Add APIs to set a firmware_name to a rproc and boot the rproc with the
> >> same firmware.
> >>
> >> Clients can call rproc_set_firmware() API to set firmware_name for a r=
proc
> >> whereas rproc_boot() will load the firmware set by rproc_set_firmware(=
) to
> >> a buffer by calling request_firmware_into_buf(). rproc_boot() will then
> >> load the firmware file to the remote processor and start the remote
> >> processor.
> >>
> >> Also include "fs-loader.h" and make remoteproc driver select FS_LOADER=
 in
> >> Kconfig so that we can call request_firmware_into_buf() from remoteproc
> >> driver.
> >>
> >> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >> Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> >=20
> > Reviewed-by: Roger Quadros <rogerq@kernel.org>
>=20
> Hi Tom,
>=20
> Can you please pick this patch. There are no active comments on this
> patch and Roger and Ravi has reviewed / acked the patch.

Yes, I'm going to give people a little longer to comment / review and
will pull this to -next soon.

--=20
Tom

--4oxCFYueTeQN2BAF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXnHdMACgkQFHw5/5Y0
tyyUbAv/YIeAgFfHul0e3GHTHeZ3SYTOF6THrW/5WQ183403+lJa3I0n/eRJvzu9
YmT9vHLfDraox1mlYdW4q4mgnUxJlLfZPXi4JsZhyLjUnbsDxltHm5I+VHeCEprb
TZZjV350Y2VjWYvdyiDp9Mu7BsQjk2kRz2Wbo3tXUu2za8Fv8789gejomF6gDEkO
NvQNsj3T6v1XBnugbb6uz1l6fcFFpHUzV8QqJkDSnywJoO4WvIbO3kgZVbssbDGq
JH/XVDmIk6wt5f1ucwuppOy6TvZBhN7ocfSWSwrmuheXnxNu3KBnnLyn+D6DcmIl
5nEFCt8gT/1b6Wi04b80bs3Z0DT0qVLfcwnBpKsNnGyfxGqM/zYnFO2EMiCJten/
UgcilW8s/oigrrzDQ7eoSPil3mNZgwU1/WD1Ycm7NzcZjhyrAgNGXw+gAli0nFoB
RYivkph2fjnQY5AUg8Nga6CHPTwvksq+a3qSylz5k3o3Qt5q3mbaL49gotgtTWdb
ATzTjvfW
=zMLt
-----END PGP SIGNATURE-----

--4oxCFYueTeQN2BAF--
