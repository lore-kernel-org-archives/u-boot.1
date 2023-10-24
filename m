Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEE6C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8876186FE3;
	Wed, 25 Oct 2023 01:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AweMt1u1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DACB86FE7; Wed, 25 Oct 2023 01:15:49 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AC9A86FB9
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d84c24a810dso4498542276.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189346; x=1698794146; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iROtPZVduVRdQZbcGbKqg+LDSVm/M+MBEdb7xFYHkCM=;
 b=AweMt1u1oqSgFdflUN2lwf7YFDHWE0ZG2yEP3+7SACl9NOAgk6WmaMblN2tH1SVXz3
 HCnRL4RdlWgUm6UD6zHIOPk9o9rQ9aaBUn8H5Y8UpQwM7E3wFboRt5XkGycSeibgeGDS
 73Yfv/RPRPzEb3GdZiZajP7sKVIW738PnlAJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189346; x=1698794146;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iROtPZVduVRdQZbcGbKqg+LDSVm/M+MBEdb7xFYHkCM=;
 b=bn11efW8oEPoPUzuLKyNVWoC7VzKauJ2knsHCUWoUNCHfVl3vKiW/UAFFTNTn3in2T
 tYZMzkZVlehEXa6f3HT3ChckJqmWpZlmGqudCluuFhsflz97jotMl1Onj2+P9JtdC0rm
 ALeWraPMozrK+rfqyKTfXxnMR1riliIeq3MmJ7pK/fsqHa5taha2zF1eqJqfaX0l6Drg
 Gm1cnnNDRZNnSU4I0dyAgfSBUz0sJ3errj/RkIo9j/YSqCjFebsHmT8PNzQO7KoRnhxg
 rCldsZP8z71xQ/da0RHgK2VlTuynePkhsZfTGyc1iljb69liJWXfuLUGVYiQdgXuNkoY
 BcIQ==
X-Gm-Message-State: AOJu0Yxt+N88dwi/in23y6/7XDi+q3zbQoFeXsawkYdyqB6d6NuPXqrv
 Y5g8HLvKDj+1Q3UC7GybOvCP/ax6O4iqBNnOYZkQmg==
X-Google-Smtp-Source: AGHT+IHXH0vOLxmElrr7JMNcuJDjxDK9yGGhml3ryuxQcB64aYa+/VNtvxkd0Fr5CCG6tLkkrnsQWQ==
X-Received: by 2002:a25:2fd3:0:b0:d91:6d2e:6f17 with SMTP id
 v202-20020a252fd3000000b00d916d2e6f17mr13445715ybv.54.1698189346040; 
 Tue, 24 Oct 2023 16:15:46 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 p63-20020a252942000000b00d9abff76f5csm3966716ybp.9.2023.10.24.16.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:15:45 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:15:43 -0400
From: Tom Rini <trini@konsulko.com>
To: Michel Alex <Alex.Michel@wiedemann-group.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] misc: i2c_eeprom: consider pagesize when writing to eeprom
Message-ID: <20231024231543.GN496310@bill-the-cat>
References: <AS1P250MB0608EFCD6443148D5D9837C6A9F8A@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3k5qlMB3spuc8Slw"
Content-Disposition: inline
In-Reply-To: <AS1P250MB0608EFCD6443148D5D9837C6A9F8A@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
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


--3k5qlMB3spuc8Slw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 12:29:45PM +0000, Michel Alex wrote:

> Calculate the maximum length of the buffer when writing
> accross the page boundary. If the buffer length exceeds
> the page boundary, split it. Use this length instead of
> comparing the length with the pagesize, because the write
> start address can be somewhere in the middle of a page.
>=20
> Signed-off-by: Alex Michel <alex.michel@wiedemann-group.com>
> ---
>  drivers/misc/i2c_eeprom.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Please fix the checkpatch.pl errors with this patch, thanks.

--=20
Tom

--3k5qlMB3spuc8Slw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UBwACgkQFHw5/5Y0
tyzYewv/Wo3QbYe74CTqSPD25QZ3RpEoZAPq0OEA3H/db8zFplsAKi/UPJMXLRUZ
lpDHIEyaGbyvVp8Tw1vDlvp2u4EwktRgFKbO1zl2trMZtNwTsd1QKCAVFJ89gMXF
P5xUoqdGP2GdmGXHr2aD36Pa84Ar2Z7d3Vj+Yafvy3nWcwEKKtW8f6hr5iCAAOdL
Cfs6FFqZPNStlJ4NqpGWi1hGL3qmPE+XWWviwCBlTqw4DFrcMTE1jLYN8ItzkiBM
/MvX1q+3QV0pcgMYpdA3DHttekEnBdEGzc7kuyWAyrRqcZ+hYiPmO7EUzsC0NgP5
221jfCOpFX2nAu9h0oA2ukxzUk10CFLhyc3FAR8WoATy6p2pmJwhkU8248XZD9lC
BML9NiSo5VsZYVCvmCFHmsI+/PD4ynQvmXED3dhPEuvajfPt/a4ugdRT42SBnnfF
xmzr7b7/KVnmuE4a6lfCxQknyEEfDnLEzEaOPgYlnxm+MsiA8RRT7qqAEr1ZnvoC
uHub44BS
=aLOb
-----END PGP SIGNATURE-----

--3k5qlMB3spuc8Slw--
