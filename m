Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9987FC4828F
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 15:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8DB787D23;
	Thu,  1 Feb 2024 16:40:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IZqt/o7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5986387D26; Thu,  1 Feb 2024 16:40:29 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56B1B87D1D
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 16:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dc6cbe1ac75so797754276.1
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 07:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706802026; x=1707406826; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+6nqufq1yejM8kixWLfbWEFBMwMk1hyiIC1WiuTUJMU=;
 b=IZqt/o7nQ9aeQiYHCS3f6AaSAdOGk8HxUGQGTQoJggZbEA3Dip+fIradz6mrVKwkNT
 suyUVuBhK6il9j9mBRFUosY4MGsW0Yf0s9U2fy0LfhaB8a1zMma62jOg9VJonLdH5R46
 L74CKqXxEP37NQA8r280xjeJQgPAn38qM5r+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706802026; x=1707406826;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6nqufq1yejM8kixWLfbWEFBMwMk1hyiIC1WiuTUJMU=;
 b=b6CPimgDq6wRXVzin8OKy+V0nAlaYajeAXi8GbYUNFd5zQjO/KPuzI3LSQ2NPW1avt
 wTiB9RC+izCXYroAXDKXx5rzYOSH0ywQ9VmTJ2rVIE/gvA8xOzR2WSQdaQRzU/M9yEUI
 CMsIJTEI37DJv/1tfTSnqIf0360WeaHDPoQYb9q82QEDehYmhqczyu2fcy11Igu76E8b
 nCnU/fm2c9VwCbpCmOf6/bh9Urw7oVizQuSOshGlwrpHOTxl5gp7mpxw+W4Yzc9/eT4J
 rfFfiNkhAhbTQKdV0D7q6E5pXqzamLk7aOKbbXMg0NOnYWsE+XOLrhJRrGUYF6sVgxdw
 7xKg==
X-Gm-Message-State: AOJu0YyMtVtoHQIDkm5t1Heb44ybjs51jk8SQZlgCSAZvokkfC4uZK4p
 mSzjNGby2xj5Epn11+p0ubGZba7m4cGyZi9H1eAZ7xxADF30NzGkESG5c9Kc/LVAn0kH6Gw1s/S
 +
X-Google-Smtp-Source: AGHT+IEm3e4eiq8cjMJ+x7fbkEifuimKhOk5KHHiQz1488VuaoVZ76mOM3M4OzeaAv8EEkuMOPJrPw==
X-Received: by 2002:a25:df03:0:b0:dbd:998:5fbd with SMTP id
 w3-20020a25df03000000b00dbd09985fbdmr3304268ybg.32.1706802026054; 
 Thu, 01 Feb 2024 07:40:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 h1-20020a25e201000000b00dc63e73aaa0sm4101314ybe.56.2024.02.01.07.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 07:40:25 -0800 (PST)
Date: Thu, 1 Feb 2024 10:40:23 -0500
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-watchdog/master
Message-ID: <20240201154023.GY1152441@bill-the-cat>
References: <d46b4ac3-8834-42e1-8371-dbbc596af962@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hfsRZfcdk1DarZaw"
Content-Disposition: inline
In-Reply-To: <d46b4ac3-8834-42e1-8371-dbbc596af962@denx.de>
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


--hfsRZfcdk1DarZaw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 11:50:43AM +0100, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull the following watchdog related last minute fixes:
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--hfsRZfcdk1DarZaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW7u2cACgkQFHw5/5Y0
tyxK0QwAjKOSB4gkhzpLsBe3cS59MpS4QZiy+seac0NZOfqBxtyrSyc3ScTM7hCc
1AfaK9esloz9WADQ5bVAxciklz9cWlY5MG94OohPFBf/TW3opBgdpC0MiR0fwAk1
roawZ8f5cQeUplQw/oPRivTUizCsHdKrWckTcgBhzqM7AAiVyD7OKTDV+Ariq55V
QIDqU6+Qo93F8uIGuIPG4Sw/pueWE2TQvfs8dWc7EFqYOpRpTSgPJ8DIHM2QYhwz
4hXMoiCody1ZYSCQ2spJ6yNYujn9uCNOvUrrS10p8Cajf6OHMMKk4dj6DsqRD2N+
jWXmimyXO3dViX9d8R7sY+q7X37FO7eg4MNM1GOcPYBxNjjpA3IEVu1DYt185X3W
y6G4/gm+5ufyTSxywybbB1/3rUHLvgZ+4B+CS2NaizomPFGNO/00U/fF6mQFYYfW
wbDyIxcVpBNwzcUmRbowCmUPvVFkEUPeldpShFRHyaq6X8sXqRNHFh1ZKvUgM2+c
g8/0o6tZ
=4TtQ
-----END PGP SIGNATURE-----

--hfsRZfcdk1DarZaw--
