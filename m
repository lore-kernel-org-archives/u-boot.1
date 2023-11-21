Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846BAC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 23:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD74B87250;
	Wed, 22 Nov 2023 00:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RDsx9jg5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F1FD8749C; Wed, 22 Nov 2023 00:07:52 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AC0A86BFA
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 00:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1f060e059a3so3660506fac.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700608069; x=1701212869; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oMIAcYSrq4X+6P6OJVMd7Xy7sYeJIwz1qI8ujKGj0pk=;
 b=RDsx9jg55OsVDchsCkU2kKELN3+NofhUMqLvAGOUZ47P37B9TXWOAEMiyWZrcvNOee
 8ATFLWYwWvNGVDzrPAHb6ccFlVY60+wP3xH5yDhTipyKaTDZGGaUP4OIGtrQhP73ls7E
 Awj3PtQ+pH42B2qCra1WmEmmi1Ag6nuG+gRT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700608069; x=1701212869;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oMIAcYSrq4X+6P6OJVMd7Xy7sYeJIwz1qI8ujKGj0pk=;
 b=qZXC2IxKbP9MLB+PBaHG2YYxfY0/hKP/p7Ao1TK7x6SM7+k+14hIhiInWKGoxz3t5Y
 qCu+xETxZ3PLMkKi8DAIqp0WdlNo7xtWUcMIHnFBoAZ+JJksJ8+9ni3HtSZnRcPjF11V
 KN2FlWmqXYyP1EO5P2k9CSW/N3DwzA7lzxLnrNiB3mkxiiuF3qQr6OIezw5ayZ5KUzj7
 +E4ZuQ7+Dikv+1nHpt6IinMxG2ofG0j+v2/DVk3pEJ/6asq7Zg5OqJECrZz0P4/xgAVE
 lJPN7TqwuV4I/cF81szAqbLFyCiDsi2yeFmR2NEFntlcStnYswd0aTA07P8e/0l/hXP8
 /osw==
X-Gm-Message-State: AOJu0YwIEjo3+3dpZH0QdTvVCdKLJtZU7u2ALVbDmu2AosMRYVU3M8Ya
 kiHMXIpf7WZ0xfPmFhpVyDu/4Q==
X-Google-Smtp-Source: AGHT+IHCseouYMO5cGJ3V/z24x4xduJSCXxdX+1vtymIB/YEbvue+X7awRVNSkyo5Nu4Um1+RutKcQ==
X-Received: by 2002:a05:6871:5c4d:b0:1e9:8780:a0e with SMTP id
 os13-20020a0568715c4d00b001e987800a0emr852238oac.28.1700608069028; 
 Tue, 21 Nov 2023 15:07:49 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 i3-20020ac860c3000000b004198f67acbesm3924779qtm.63.2023.11.21.15.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 15:07:48 -0800 (PST)
Date: Tue, 21 Nov 2023 18:07:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v2] test/py: i2c: Add tests for i2c command
Message-ID: <20231121230746.GP2513409@bill-the-cat>
References: <0d8e994ea619d3942ee215a8f5635627e89c3512.1700567875.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MqFvB2V1Lx+qMrUx"
Content-Disposition: inline
In-Reply-To: <0d8e994ea619d3942ee215a8f5635627e89c3512.1700567875.git.love.kumar@amd.com>
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


--MqFvB2V1Lx+qMrUx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 05:28:43PM +0530, Love Kumar wrote:

> Add below test cases for i2c commands:
> i2c_bus - To show i2c bus info,
> i2c_dev - To set or show the current bus,
> i2c_probe - To probe the i2c device,
> i2c_eeprom - To test i2c eeprom device,
> i2c_probe_all_buses - To list down all the buses and probes it
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--MqFvB2V1Lx+qMrUx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVdODwACgkQFHw5/5Y0
tyySkAv/YAHe+no4tZlCxaYg/Xhy+TuY3LxgdeHCsUdFk9xv9n3cG61q2N0PdF1L
kqhU9S1EuvgsNRFU/7/DtEE6j+DRf0kVYCCEAG1Ok/ExYNshFuInHWC+pXzSSNPH
mcUxN3RPUwZu6TlBZCWlTyDacHQX7bIpJJ8UC1zEqIlGTtp+wG8y2PE6GtbzLP/f
daEIdTOuyYIWLvlcrTTs9mEcn5BwjH4eb7eY+Do74MFjTxkKZ3WGUT/hdPuCKo7h
GbEyBQgvSgz/W4RByScwRfcPNzdIiOF/zv2uTYQaWABf9/plrpypkSn7v+vD/Rqh
jEJOjXYvYoF7Eovfz6i4916v1kb1yZ/h8aaCPo6Es92sT/3emGJaroja8wpxhc5g
b2/kAI58R2jwek8fBLURcOkBSDfN+A/mEPpGkU2gxA6T0f39xnyDcW//qBDCL1RG
olFYsPSKDEBHzOB6twz7isW0+fGNAaPBcd5m6ZYYplEwdvN2cMXTcvnUxRqcJ+4y
KdaznHW+
=J/lC
-----END PGP SIGNATURE-----

--MqFvB2V1Lx+qMrUx--
