Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5621DC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 13:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D584886DC;
	Wed,  1 May 2024 15:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N2GdbLvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A39588AAF; Wed,  1 May 2024 15:49:42 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18102886BB
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 15:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-22ed075a629so2655931fac.3
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 06:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714571379; x=1715176179; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sCHZngvK1cWjOFX+H8eBXV/Ls+lPMaE0Vg0fxp84Lbs=;
 b=N2GdbLvJwV2NWFuyroVcy4V8URS7B85Jl1cXN4aJ0eY1P6Hmag1FDiyUyM8Xpxe9o/
 cyQqC8TAcZPEX83Z+QgX34wQRINVfZTVzblyl+X28/5NuC1RZtOSmP4Sn4s/9NgevhTS
 vvsdRmnJwtuQDW6UrHqnvM2hUy5K8tRqUQ+nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714571379; x=1715176179;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sCHZngvK1cWjOFX+H8eBXV/Ls+lPMaE0Vg0fxp84Lbs=;
 b=wRSFlv+C9EO8sTg4eEyoXxY+9uk6xXpz/QmwtAt0NGO9DHfVOihyPajxKUDlqJdO20
 pe48q+ziQ4otm4Onke0MUtYF2BNcdOaQsLdXPhIllmscefnH/AwKsZOnRYWkPvjsiFtX
 w3ejnYjR+UHHwnSdXh6JWDX1BUm9fgmIF7dSSUe1A+xcZgvhvtEH/NSddhO11WDFfz9l
 AnJ6suHJlyeFXHJQSwJ9aOO2RcmkEirbkGYLvX9/EfST4yopo8/NKLSDvK8BLU1G255i
 cTWxgYXF5u5vq9zalt09okWqPBVrSelZjqlmIEOS5+pPR/e8g1UpyNfUritSKhg0W5Oh
 d/DQ==
X-Gm-Message-State: AOJu0YzcYQqPIawyOYL8KvWmOrwkqhc4XY2awUHk03/2cut4rNM6lq6N
 hW2Fdb1ub/ZKqQZ/iKlIgW8QHod7BOZF+UVb+FDpRWNHp4gzWDElNSzEltxGIhlnPkgb0j6fGyz
 N3BpgzYFC
X-Google-Smtp-Source: AGHT+IEfjmoREY2bmlY/uoyy3xsgMTJmwWO8H4+avZyDDmiWUu9RCxPWUn4GYmPc7PY10FPzr7aUVg==
X-Received: by 2002:a05:6870:95a5:b0:239:700d:61b9 with SMTP id
 k37-20020a05687095a500b00239700d61b9mr2691635oao.26.1714571378747; 
 Wed, 01 May 2024 06:49:38 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a05620a0f8700b00790fbf629b5sm2346842qkn.115.2024.05.01.06.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 06:49:37 -0700 (PDT)
Date: Wed, 1 May 2024 07:49:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 001/149] global: Make <asm/global_data.h> include
 <asm/u-boot.h>
Message-ID: <20240501134934.GR1054907@bill-the-cat>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <CAJaLiFzo=XeEto0EN_SE+G2iwxyWZ1Lb9AE8LG2sMfdTVhBF6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Cfd+ArJ7f4Y+GR2k"
Content-Disposition: inline
In-Reply-To: <CAJaLiFzo=XeEto0EN_SE+G2iwxyWZ1Lb9AE8LG2sMfdTVhBF6A@mail.gmail.com>
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


--Cfd+ArJ7f4Y+GR2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 11:33:01PM -0700, Tony Dinh wrote:

> Hi Tom,
>=20
> This patch does not apply cleanly on the master branch. Perhaps this
> patch series has a dependency on another previous patch? Please see
> below at arch/arm/lib/bdinfo.c.

Yeah, sorry, this depends on the two previous series I've posted.
https://patchwork.ozlabs.org/project/uboot/list/?series=3D404691
https://patchwork.ozlabs.org/project/uboot/list/?series=3D404991

--=20
Tom

--Cfd+ArJ7f4Y+GR2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYySGcACgkQFHw5/5Y0
tyxlIQv9Fm0OqJv/R9KJe9nvrxuQ7AfNXHGtte7nBFvZuJ/AFGaiDdi8O+W64zGy
9sTsZ5qmkWOfQvic2Aw/x2j/0cDkKlLHMMSxtxK2BJtHUfgtcfSExn42f2dQEmod
ShOzmXKHrWUS60qtQBu/DQUPNIDNx+siGcgAP/aO+68lkspen3OW29nymJIOy+Zh
1eLva7sXyqkJerXbmYMZDzm1bC/Euvc6ieS5n7/jn6dYs8ol0PceP3lEdCFGB0Rg
Bz41Kw/BtVAVLCT+Bf3qH3wnb2MyKmouUC6wQ1eJGpOQzBnipgOYyAZ5b9QUqG6x
0n6Wby4nOf2N6S25iFi+WZmGewRf4FM6kG8h2xNlGMi3Z49JS+24PbEoAhJ3wwwY
0NCaVP+DoMBIM0HICTXxbShjTWCvfsWi1jvag8oumNbKcrue19C8U7k0kuoY/DEM
qUc+jGZBNC6bqLKQCFXyzt+rphupGbvL88kE05L+WQh386WHUckyV1ZQIyhb5Wdh
GDtjsqLW
=Oxhf
-----END PGP SIGNATURE-----

--Cfd+ArJ7f4Y+GR2k--
