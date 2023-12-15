Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3037C41535
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 14:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39B8D87B9C;
	Fri, 15 Dec 2023 15:41:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uSKKoMXc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5DBC87B9E; Fri, 15 Dec 2023 15:41:28 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C63787B77
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4260b657ed5so5899681cf.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 06:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702651284; x=1703256084; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vbV/bAnKYbcGWGSBqMbf4BZblAWp+U5jpwn3Nc95SxE=;
 b=uSKKoMXcUmCUUe2QEqxEFLcGwuW+R0jt1TlqTijPVrS0ok2espdf/lSsuMDgsC+LAu
 ASSxwW1mBNbANVR5WSDxByZqUErkgvPKI4SKQGZ5xa2GqTffyrLjKDfJkwE3ltsGMny3
 78FgXtlTXSvXs/T22zCojj86fs3FOJnGSVSpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702651284; x=1703256084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbV/bAnKYbcGWGSBqMbf4BZblAWp+U5jpwn3Nc95SxE=;
 b=NlkMbYsxn7hg/Ism15NsgY1Wx5iLfI9xIlf+6y+YHnUvvdBra+YVNGLLLkeRmGD0Jt
 OEXzPd99pWuk5hlWq3Lnh71v3iBHPUEZS9Ohd1budoubUsmuXsJZC/6RDCNFA4E3QRqW
 I820TS9GYYK+dosWElQp+uUhFJMKU96CSFtaaxLc3N5oDBx2Qmrj1KABw0HeT+6XvE69
 BgIFT4TyF7LkcKd5jy9au1vPMGW8rE1sJUHvsY692hWTgRowB1FSKj7DTthOnNGSWf4y
 QgdNY32hXdFMl8G9lVxXIIo9lk1ypfj5OTW4CmohZAUPlOEgBsnNDyQYRB9dWiOhYszp
 m6Lw==
X-Gm-Message-State: AOJu0YzT2OCsCy+Yz+QXHzvTS3Lmrufb6arNXG3bhfrufaZKQXGfM7nm
 l0t283HR5HVgD/VXd2BYmOERqYnLUYrE6xlbUCY=
X-Google-Smtp-Source: AGHT+IEoUmIJabjWVH/j/dIx1Txwznidk0La4faCCoTBkthzIkEer8cmypJUteobMo05qPLDQ/MH/g==
X-Received: by 2002:a05:622a:10c:b0:425:87e0:fe84 with SMTP id
 u12-20020a05622a010c00b0042587e0fe84mr14746872qtw.107.1702651284146; 
 Fri, 15 Dec 2023 06:41:24 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-faf3-908c-f76f-32dd.res6.spectrum.com.
 [2603:6081:7b00:6400:faf3:908c:f76f:32dd])
 by smtp.gmail.com with ESMTPSA id
 f23-20020ac84717000000b00421c272bcbasm6686546qtp.11.2023.12.15.06.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 06:41:23 -0800 (PST)
Date: Fri, 15 Dec 2023 09:41:21 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, marex@denx.de, tharvey@gateworks.com, u-boot@lists.denx.de
Subject: Re: Pull request: Please pull u-boot-imx-20231214
Message-ID: <20231215144121.GY2513409@bill-the-cat>
References: <20231215130707.184861-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7yEkAuNnplanN3dq"
Content-Disposition: inline
In-Reply-To: <20231215130707.184861-1-festevam@gmail.com>
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


--7yEkAuNnplanN3dq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 10:07:07AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull these fixes from u-boot-imx, thanks.
>=20
> The following changes since commit 27089f1e4d11fd7e0619097b59258d0428cde2=
ac:
>=20
>   Merge branch '2023-12-13-assorted-minor-fixes' (2023-12-13 09:57:28 -05=
00)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-20231214
>=20
> for you to fetch changes up to 4f7122ca1580602399afc30f94f4b37f79e4d662:
>=20
>   imx8mp-venice: update DRAM config for 2000MHz (2023-12-14 15:34:12 -030=
0)
>=20
> u-boot-imx-20231214

Applied to u-boot/master, thanks!

--=20
Tom

--7yEkAuNnplanN3dq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV8ZY4ACgkQFHw5/5Y0
tywW+Av4jBQ83oCRaOFzqg/Crt8uRtjDIi+9kKdapSh0M2PrfQENSfBDSu2X1nFU
Df9BrWlSmLzsK7fRHYZE2XC/OsRvF3yObXwC2uAmvN6aqYzA+ZSmNmBHADLbMf5e
W1+tnU7boUKj1D2JX8t86hnuh+kO35ZErw3Tm3+qdykeYhKQVTR8jbUAaXAXrb+h
G7dOK6md56fqP71HD0eXIOyXX91n1LskbBCjHb5UgwrjCWsYgeOINZb5qDLh0iAh
kYt9PZChT+qwXO+e/01jGjINcXqOMOU02K4fUIiQ6hiHm6xtIcM+WE2twz8ABb/X
p8+GnEunVGXAkPhTIx1+GpfK6S0zPfze+srmgu9diYbCOz8qWFUrNveEZ3N5zubf
MhY/be6NrX3ViEiGBspgT0x+32C/7LCXYXs/8bdbarW+/KLCZRuiqLB8BvhDf63C
e8CkKO+oCRv8eLjXruzNMdPfMMnSpptd66Z/ag2XsCG0kpo/NPya6sMI0CXWLO3b
wmdLG/A=
=8kk5
-----END PGP SIGNATURE-----

--7yEkAuNnplanN3dq--
