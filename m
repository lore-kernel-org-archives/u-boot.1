Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80686C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01DCB80214;
	Thu, 23 Jan 2025 15:32:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hLGr+pgL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF67680243; Thu, 23 Jan 2025 15:32:47 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B44E880137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:32:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6dd01781b56so12378416d6.0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737642764; x=1738247564; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4sMxdoUairB4fiTddfZ8U2Y+XBugnkE+hux3BDTGExo=;
 b=hLGr+pgLbq+mTyCyBBHnhxCYMtCQ55nX9mScwJKYaarLfST9f/qlZEi85S/fWr3Eb4
 hBYdfnKvliwmkVqBlGmHjIWbHAuLVT/znWzV97iNx6Iw1WfMjbWDK+XAiKVclKpBDsoy
 wcAffePzp7b6A8ldIIElkIp6EbB7vv9gsP1Nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737642764; x=1738247564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4sMxdoUairB4fiTddfZ8U2Y+XBugnkE+hux3BDTGExo=;
 b=pmq5mg6hUXbDlGlKXVzzSuz+qp8cY/mdhJ2SgLvTn2Y4j+uDzic4hnaBFBMYN3HC5S
 ioMqHTEaxiFnAtE2EF+w2RCc10j0NVSxl/feg6MsjM7s3qKO2Zhf0W70cfIwHcD/Dq+B
 E4r7hQLTJV0dpRT0x3N/M0iMbaK7X2AkaZpThcjVJLvf8fPHuj4m4cI3my6BXRD+sj8E
 0DbZkbsdyfGNxVkys0JFDo1Bd20jaTQkfdqcnru7sDkpfAuKapCxTiQZp6df51/mWkzR
 GAkRdG9TEakyrlWsgHa1DDFY5yL8OW+bIRqis4ToFyftWCtCzN2C9VICFwnhlXr2Si0A
 c4Mg==
X-Gm-Message-State: AOJu0Ywwrd2YkwvAxIHAD+3JrG5Bk2whziXIw9WGnpaoczWj2DLVsLWQ
 0zM7pM6zjweXPtsbYrRlGj7mr3ysyroUNMx7cAx7w8U3od7ECmmw+eyAD6ZW+vM71pZ6JMjGBmd
 P
X-Gm-Gg: ASbGncvgZFpf5I32lE/cOQyzM4kmMS2eqxA+rLeYQfRmm9N2kBJQEMkvbZXEo9wbDQY
 9iKVt0XXS971xuz1qvpqe0V4mbZrScInJ+bfHv1N/+soGmD0PjKcxvTAfju2Yx0+Mu47P9MqvJo
 bX/xqLT9ZSglPwO3BK6fuRuAx2Z5DWIAHk9BCwdTD57pWcu52QW+ilcqwUOc3zPAdT1hruZ4UTA
 LVABZ4YBlrUGL2U7aI1ZtRj2RmFZtkeGLeQ+awXI7emGrPKwHUqPNbq27dlBjjP0ZU9AnOU9v1V
 No0Q
X-Google-Smtp-Source: AGHT+IHt20QIHyhMEt+exyPhpDZ6yW8aN4OINXW/fJBbsmcXbVOJ/OJRV540W9a39SVkN8rUR9I3NQ==
X-Received: by 2002:a05:6214:2b09:b0:6e1:a45a:f8d4 with SMTP id
 6a1803df08f44-6e1b21693c0mr365162266d6.7.1737642764544; 
 Thu, 23 Jan 2025 06:32:44 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afcf6cc9sm71427796d6.120.2025.01.23.06.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 06:32:43 -0800 (PST)
Date: Thu, 23 Jan 2025 08:32:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] tools: check result of lseek
Message-ID: <20250123143241.GF60249@bill-the-cat>
References: <20250122161505.74348-1-maks.mishinFZ@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9O2pr7nqdj/uadru"
Content-Disposition: inline
In-Reply-To: <20250122161505.74348-1-maks.mishinFZ@gmail.com>
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


--9O2pr7nqdj/uadru
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 07:15:04PM +0300, Maks Mishin wrote:

> Return value of function 'lseek', called at pblimage.c:211,
> is not checked, but it is usually checked for this function.
>=20
> This trigger was found using the Svace static analyzer.
>=20
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--9O2pr7nqdj/uadru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeSUwUACgkQFHw5/5Y0
tyz/fQv9HDeeNz8Y04ZzaavSEb4Z4cOsWQyT/FCeEiCId6N1NTiI6+qP27Qc32Pf
X0z45iw5x8AR6G1van+UGVOkUGROMTlwfZnRKICKhO4gfdE77m1Yno++ECsPdxI9
1rnCfsGki+lyAJSBFrjQHIDDcWZjidQEKLojhy5LhIBOwpt8V5jm0jETmUyUsKgD
HupagBMo8nv2eDDCo0CT+uwtF/I7hXZa4X88i795W8aMQUEPVcDxOg7fDTzNMuP3
mPhUZhwu6Dgrpx0fOgfM8TGUs3ZLA92P7djjtSvKPJNPOpzeX7jr5wqAu4Dj2NAw
M+uK+jILJZKAa6O7wlzxLZ4++ErLHIqj5714PjPk4/Ghn053F6bxzVDwm6SgqFNX
qVPG+f4tsM3WOtJPrvwIXLc/fbc6mI4nRS9GOh9zTGj2/PqxljW/ECL3J+JbpnNb
szGM/AzAiL1qeE5XL9k0qA/HCZeyRpqWKivXmA7PaS0MXOIa/tT/SCG14/b4FAAR
2xBCjF+q
=91Wy
-----END PGP SIGNATURE-----

--9O2pr7nqdj/uadru--
