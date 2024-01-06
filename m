Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EB2C46CD2
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 17:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E719087A10;
	Sat,  6 Jan 2024 18:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hquAeM/c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07C9E879E5; Sat,  6 Jan 2024 18:41:25 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86E4B87A05
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 18:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-427f5cc49afso5960331cf.2
 for <u-boot@lists.denx.de>; Sat, 06 Jan 2024 09:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704562877; x=1705167677; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/N4xt2nOOd7OCLGEQHAU3vGgR5AwKa7JCpY3jDsCefU=;
 b=hquAeM/cO9xXlm2Mszy2Q2gDyQw9WrZHDWIsEn1a+R0i/CmMAx7SJUecHHFmnPNRWD
 w3zmAiIXXbWKdselp0aiDLKJPQXxxxRZRBUQeWw/bdYlACJSXKK3C5anX5WdRyNtT1JY
 kq/1aaU/sbk4VPK3gIFmBn2iSNaA6yQW60/Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704562877; x=1705167677;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/N4xt2nOOd7OCLGEQHAU3vGgR5AwKa7JCpY3jDsCefU=;
 b=jTud/vnZtL6jg6UzDK/Z7U5lnqPKAMBUJwbR9/6QQ4g2c+VRX8v7rYbPDPTJVDldQ1
 Al0T68bywbbhCzt2zbx0QgPMkJPZjl2Gdz31s2EuGPxlkWNJIsbcBb0l9/y8i8m/+UXV
 ScVvxxvFoUEjkU1nET9m4yFHVYiRZvx5B9WChMPxxuLtaw8a0qq7aJjtHLXIwtpaRb1j
 lUpys7gywS0kgTian/fcnMF/tzhc/YhpRf8UqIE9mZF5QbpitthAjGiwfTmDX07VUh3G
 ikFZ02sUkdaNcL3Av/ckDJ6cHMO3tKaWpVXwU+qIAkZiwZL1VQOJ/6yUpDSm/f2E/OJV
 Fw/w==
X-Gm-Message-State: AOJu0YzhQ4cxC5qS87u2Nd8DnKM+sH08kn/qyO5qtk1dT73k1rJo1ELw
 simJig58DuUgM42fXicHG4zAcV8U7V7c0g==
X-Google-Smtp-Source: AGHT+IH+9twwBZEW8enyYloYft9tD3Q94zXSrC8mIhu9Q9rp5NDL62yyIDR3hpmKGbu/XGDBXHN+HA==
X-Received: by 2002:a05:622a:14d4:b0:429:74f2:24cd with SMTP id
 u20-20020a05622a14d400b0042974f224cdmr1919292qtx.71.1704562877576; 
 Sat, 06 Jan 2024 09:41:17 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 fw10-20020a05622a4a8a00b0042832c42d1esm1815702qtb.17.2024.01.06.09.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 09:41:16 -0800 (PST)
Date: Sat, 6 Jan 2024 12:41:14 -0500
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: u-boot@lists.denx.de, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] fw_env: fix reading NVMEM device's "compatible" value
Message-ID: <20240106174114.GZ1610741@bill-the-cat>
References: <20231212173327.22819-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lCBB+zq/NFSLByqq"
Content-Disposition: inline
In-Reply-To: <20231212173327.22819-1-zajec5@gmail.com>
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


--lCBB+zq/NFSLByqq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 06:33:27PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> Call to fread() was changed to check for return value. The problem is it
> can't be checked for returning 1 (as it is) to determine success.
>=20
> We call fread() with buffer size as "size" argument. Reading any
> "compatible" value shorter than buffer size will result in returning 0
> even on success.
>=20
> Modify code to use fstat() to determine expected read length.
>=20
> This fixes regression that broke using fw_env with NVMEM devices.
>=20
> Fixes: c059a22b7776 ("tools: env: fw_env: Fix unused-result warning")
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Applied to u-boot/next, thanks!

--=20
Tom

--lCBB+zq/NFSLByqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWZkLoACgkQFHw5/5Y0
tyxQ1gwAsrmUs/ZngGqdvOAPF/nfcWvv16YYgoog64PnMiZDboswNMP9mETGNfgK
uqhidhp1pZM/j0yfHK14F6ceF34K5k02rGu+gJs3CMSwodFJqhBGnDYPc83indgv
DKM1MsM4IGFCHIEEHZh4G2mYhP6VL80jDgBG0L6F3EdgQ13AsfD2uIFxe3Z4ZqPO
he+u47kt0/n6PPPHXZU70kmhmKHUBvhDhdMQ+mMhH8+5MiAfeOWldVz2WAYQkTj/
Up6NOmsJoBEATIKYXxkGN2e6m21txm++ACMphqP0IwqcABQEnUNs+fDxZb2OrQFf
N8TpbTwtDDBrVLpJinMXISRcnzh5ABk9lzNLzYVlQTYZ3bmifJbfS350uW2504A7
d6bXU30GdpGGrwrVwnNIZb1GsZJc9+I0FxBaKL+t5oO6hthnWjR8xahBZbco0y4i
6NgU11phVxcmaaaIGfifJqf4gRDiUH1kgagHo3rO0VBxl8SeeJ3YztibnYmy6xxC
gGoz5dkb
=DoLz
-----END PGP SIGNATURE-----

--lCBB+zq/NFSLByqq--
