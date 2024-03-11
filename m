Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2578C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 18:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16B8387F12;
	Mon, 11 Mar 2024 19:24:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hrjnTb9d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B042C87F0A; Mon, 11 Mar 2024 19:24:28 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C17987572
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 19:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-68f571be9ddso40065906d6.0
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 11:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710181465; x=1710786265; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HGLalmjnJb32QmlbPJoWG92vxARIcemUFEekRrwdTsY=;
 b=hrjnTb9dT3KN80j45QxE7asRlN6kdPpEEWyAtav29Z2dZzUSMAOr4E/8ZbgbqeTgex
 +Td9Sad5Lmb5XPVD2KXeTucPNVbjUIx+e1J33MbNJNLZvY6dBou6zsyafAmoItBNPH87
 05wyYHS2GdCc7sPe70GNn06wauSCD9lfs4QuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710181465; x=1710786265;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGLalmjnJb32QmlbPJoWG92vxARIcemUFEekRrwdTsY=;
 b=GMFYFNFAdHMlIEZud8zgZFAG45jQXHgda2+B3I+AEcTB7N7lOPXku80fDEyiXHxLue
 RPZOBqGSVA10ewT+ZLSka/S1hoiolD+zRQTj1U4gA2SJ9v91rS52LsMKPmcP1FegX67p
 iECGvg8hNS/VESvxcu+WqjLc0OKnsJb7jEz/J6ajKoswR+9F8yOoDePUPgzg5U67BUn+
 8/EZM9GDx3UunQUdqFw99tkiiEhCUb29mIejjJjzhXrLatydpc9fnAkcBCE9p9T0jPAQ
 pZlIHh/FetB3sQJ99WLfc2jVA1tIqhNVXYPv7JDzJvpwD2lriQRJcaP2OGW0NZcS1ebd
 XMaQ==
X-Gm-Message-State: AOJu0YzM82TCWgahfIADE0raEfzOEEFp9pm4D+VJ03uxTJxzXWkeubDh
 nhJ6c9z5s8zPA9ZQcnI7tXOrFKFb9ULgDl0dkTWZGTXZ5JCxkJFL29BtBeaMMbg=
X-Google-Smtp-Source: AGHT+IGCRnZ7px11Zcv/AJx9tnakKlEdBkNEOLkeJugnnhMt7J6ZBB8rthQme6bNTFKaGMZMU+X6ig==
X-Received: by 2002:a05:6214:1854:b0:690:c3ea:ed0a with SMTP id
 d20-20020a056214185400b00690c3eaed0amr5759411qvy.11.1710181465296; 
 Mon, 11 Mar 2024 11:24:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 f29-20020a0caa9d000000b00690aa73c1a8sm2944742qvb.45.2024.03.11.11.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 11:24:24 -0700 (PDT)
Date: Mon, 11 Mar 2024 14:24:23 -0400
From: Tom Rini <trini@konsulko.com>
To: Kang Lion <hkang70@hotmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 HOON KANG <lionkang70@naver.com>,
 "lionkang@wavetc.com" <lionkang@wavetc.com>
Subject: Re: About U-Boot License
Message-ID: <20240311182423.GB1523872@bill-the-cat>
References: <SEYPR01MB5364E20BEC422DCA667399F5A3242@SEYPR01MB5364.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zS8NOc1JoMob0mr+"
Content-Disposition: inline
In-Reply-To: <SEYPR01MB5364E20BEC422DCA667399F5A3242@SEYPR01MB5364.apcprd01.prod.exchangelabs.com>
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


--zS8NOc1JoMob0mr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 05:40:19AM +0000, Kang Lion wrote:

> Dear DAS
>=20
>=20
> This is lion. Nice to meet you.
>=20
>=20
> I'm sending you an e-mail because I have a question about the U-Boot lice=
nse.
> I would like to know about the obligation to disclose the U-Boot code cur=
rently provided by Xilinx(zynqMP).
>=20
>=20
> 1. When we use a commercial OS code called RTEMS, we use U-Boot as the bo=
otloader.
> At this time, even if RTEMS OS is commercial, if we merge an image such a=
s an open source called U-Boot to make a final image and use it, should I r=
elease all the codes? I want to know the scope of disclosure.
>=20
> Do we even have to disclose commercial RTEMS OS + Application?
>=20
>=20
> 2. Or do you see only U-Boot as a separate image, and since the OS is com=
mercial, there is no need to interpret it separately and disclose it?
>=20
> At this time, should the U-Boot be disclosed according to the license or =
not? I wonder.
>=20
>=20
> cf) We will just change small part for only definition, but I'm afraid th=
at we have to disclosure our every code of RTEMS and Application.
>=20
> That's why I'm questing it now.
>=20
> I know you're busy, but please answer me.

This is a question for your company's lawyers. U-Boot can of course be
used to launch a proprietary OS. Changes you make to U-Boot need to
comply with the license.

--=20
Tom

--zS8NOc1JoMob0mr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXvTFMACgkQFHw5/5Y0
tyw+CwwAlPR1ju3FoFWP/pjMy8TcYv6ZJS/lTD3sUJqgo2NH/8Bx7sNNKJjmDseh
sxw9jPN6gLxbAviwaXJxwYvoPqfaGBag/rX3SRtblbUoXm1SYKusZOUM3TVY25Fs
GhMY7T8WZ3TGGu2J6Dilupmr/QQT910RZDBrFZOWaPhYC/T40ZolVoEgUInRCuhH
b0gc3kz2pQgeWsoPIJGe9by+03N8941euw+ho3zmhgazqF+v8LLocNWGHXBaz+GQ
yhp6h2NEkoNvFnouW3uTkfANTJZZQJGf8lKK04yMSLuMArX2cYCVDA8hMMwesjCV
c9hlAUA4OtS/0YTUrSZPrM509N9qEyOexbqb6BOfDQa7YKv99gQr4WAgkoCwsi3z
peaPjueCXPk77DIYYJoAdEd63jmkh/HJDrO8UkaMuC027vne+uMkUzYuv/SRmrt+
iz7aANhckUFn15u9KjKtXyUMaqVarZ/XPwtGBkvou9CXBVOY7KrXnOIy/ZXWWfb/
fphtaziF
=ejIG
-----END PGP SIGNATURE-----

--zS8NOc1JoMob0mr+--
