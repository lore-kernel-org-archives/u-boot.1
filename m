Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E51C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 22:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 286A587727;
	Wed,  3 Jan 2024 23:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T/0M2RLa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8029C875FC; Wed,  3 Jan 2024 23:59:43 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A2ED875FC
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 23:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bbc648bed4so5344162b6e.3
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 14:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704322780; x=1704927580; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=glUQOJ/bS/zm/zxREkRJms2OIkxue28x53Platz7bVQ=;
 b=T/0M2RLacdWi6tPksCl1oz1tISyKg38tl86SqHZfFFKGewpvfBg/7m7EzH84fLuCDX
 dHy3mUQcbgWYabUkjNvMSPgOWCWI+UfOiJzoYYlcwfksIUvqbDd9/QobNqRG3cH/S4re
 F0Slwwm/xiWxI1+KWACeGZgaqlon44ORpslmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704322780; x=1704927580;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=glUQOJ/bS/zm/zxREkRJms2OIkxue28x53Platz7bVQ=;
 b=ZNBJA6WOrDlPXMtgKdh28qgxCsZPWu9o27ypychIxfXX8pkOgH2Kp/OWeC4N++983o
 igtT80kVuhY6sXSG1P0z6Wmr3WrU1kE7Tjq5FoMTmD/82VD1zjBqkYH4eICH0LkC9qmz
 c4OH/rRuqyYbvrAK/g3wUTi08nS0NHh2IyNmm6cwziNIb/Z3WZSpa1eZk3XoBjazxSLj
 kyq5FSZqiOg8kdTnGLdqLrdi+llmkanCkNZfT3l5i11pa1v8Q2xCTj+64CYejp69U0qt
 tdCvRB/Z9XSbw6zV8IW+mQhWbeqB/vobdiiWw1lzB9+vUnwQvCvRWkMmyme6V0LC6uAl
 UkTA==
X-Gm-Message-State: AOJu0Yxzcr+Y4N3Gq8eiVoxHDp6GKApF8V5Ah3aoDrS9dpKbRmeJ0ba5
 KZZP/FPQ/Doxg59bqqdibsMxd1XCmH5Z9g==
X-Google-Smtp-Source: AGHT+IGL+9FMqJItnEQOvWqnvQE5PpynK/ml63NVkrbrWtUub8W5acTeVmYahlJGp7l3CY9tOKCXUQ==
X-Received: by 2002:a05:6808:4494:b0:3bb:c73e:7ca with SMTP id
 eq20-20020a056808449400b003bbc73e07camr21025252oib.2.1704322780008; 
 Wed, 03 Jan 2024 14:59:40 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 da7-20020a05621408c700b0067f2c03d4adsm11161682qvb.100.2024.01.03.14.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 14:59:39 -0800 (PST)
Date: Wed, 3 Jan 2024 17:59:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Sinan Akman <sinan@writeme.com>, u-boot@lists.denx.de
Subject: MPC837XERDB DM_I2C (and related) migrations
Message-ID: <20240103225937.GP1610741@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WVhIbfVq3vY1LtkK"
Content-Disposition: inline
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


--WVhIbfVq3vY1LtkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

Can you please migrate MPC837XERDB to using DM_I2C for U-Boot itself?
This will likely also require either updating drivers/rtc/ds1374.c to
support DM and switching to DM_RTC as well. Thanks!

--=20
Tom

--WVhIbfVq3vY1LtkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWV5tUACgkQFHw5/5Y0
tyz5HgwAnsacVDaLJg3phTyY657AAthO7wKG6oG4+ILo4t2qjogp/S6zepQPBkE8
GhaXQeoisdPURkejcOsxI3LD9YPw7JmzlRU5IZQrX2qo5IvGOGHHOAW71KJRzVlI
gwdcUKra1Ll7IPkccrByJfuUzwC509UjqESi5R2uFMpOtoCCS4Abmzt79EwDFvDM
ruxtIVV3uzP56wBXAa7oKIOSYS2HNwQkfTKf+He55E/O9/vUdzIeRwc2OmTivNyQ
eBM7Fcg4h2pU0RQNDqAetmWDMFEtmRDkce6xZyOnwIrb2JfBum2m7GLCfrcvivEq
A5xKKPykhv4iWlEZbovq8kkJWq+T6WcjV7rhH6QnpkGqg9r8BOVTW1Jrj+oW9tNH
8TXFXt1H/VbjqvN+upB5ol0n2dv1XbP5cELDFtS23eZTRYWzlnztcqHTzYnPxgvE
u6TAV4rsTVbQbp0b8PKS/6/BJi3zyNXlQvX7T7z/7pdIrjmkkWO/MPF0tOaw0aL4
FY2kO7EY
=tjWj
-----END PGP SIGNATURE-----

--WVhIbfVq3vY1LtkK--
