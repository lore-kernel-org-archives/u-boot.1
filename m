Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460DFECE57E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 21:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 250B888792;
	Mon,  9 Sep 2024 23:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EToBGt9M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66EF788A1C; Mon,  9 Sep 2024 23:54:46 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1876C886B1
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 23:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6c54a5fbceeso7895636d6.2
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725918883; x=1726523683; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d/pPIomTnsF8ZDQwPFErvB1wZUlugSzL5+hNXBw36g0=;
 b=EToBGt9MLS9u6TinuZ64WT9mEv2nw8BdIfbyJemtfRM8EPxQXMbZCthMAx0ZHq9wtF
 KAhR5s/o0Kysc3H9AqoHX6+hc3qg6oXEypjIAiapvlPxONDX06AhSI+FeElmIXDbLIxs
 s8BDcZ4e0mqnJxrwXhUWou+sTO5FyRZVGNq0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725918883; x=1726523683;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/pPIomTnsF8ZDQwPFErvB1wZUlugSzL5+hNXBw36g0=;
 b=uYnQILvt34E34J2fcxnXuzl8mxIwMKdXppjFje45ZXxqGw4uWYyoH+KSSPz5ITolCG
 gkCcKGmEE8AOF9ySi7nA+fXo9a6v13lWuCcO37mDqp0dJ+mDzvop+1Rx0Zc5LAFE158D
 NOfQyzH9LIGqvnqyGuCsHQILELSRhxdZkS2UQTfKCGOxHxPBRrgF3wo8FzJwptW6R0KK
 zCYwSKP3JElpKE624W95110hQrxUODFOvums3/4CWaZo0AQL7wwEWFN7SxzUHqWxFBj2
 sz0aAcb7mGvS5EMCr3sVFSmweO3e3B9g7CpUueD2kWBzXr9yqd34evZi4UIDowGi5QzQ
 ukiQ==
X-Gm-Message-State: AOJu0Yw6Il7t7mPm34deghWNK42lpaiQHKH15nhI+FyTmsdxVwR3SGPM
 JlBX5mzH32MLvqq74132Rl9paMh03UH1dNhXVRUkGa5/2Ok6DMguHR4dC/FIhbg=
X-Google-Smtp-Source: AGHT+IG4mowheAR2edTIl60wzKRIR0eIS1wSH5HgL8tfcT8YfH7hV//wHX5A1k6ATl7jM0fduusDZw==
X-Received: by 2002:a0c:f80d:0:b0:6c5:3177:eaed with SMTP id
 6a1803df08f44-6c53177eb9emr96283826d6.36.1725918882813; 
 Mon, 09 Sep 2024 14:54:42 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822e8ba52sm23949781cf.38.2024.09.09.14.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 14:54:41 -0700 (PDT)
Date: Mon, 9 Sep 2024 15:54:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/master-spi-fixes
Message-ID: <20240909215439.GE4252@bill-the-cat>
References: <20240909140419.7713-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X6PVCgc5mdLL1rnU"
Content-Disposition: inline
In-Reply-To: <20240909140419.7713-1-marek.vasut+renesas@mailbox.org>
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


--X6PVCgc5mdLL1rnU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2024 at 04:02:55PM +0200, Marek Vasut wrote:

> Last minute SPI fixes for R-Car to make the SPI NOR work on Gen4.
> Also one RPC HF fix for Gen4.
>=20
> The following changes since commit 1630ff26cc960439b5949b80cfc604a2c8aa47=
dd:
>=20
>   Merge https://gitlab.denx.de/u-boot/custodians/u-boot-marvell (2024-09-=
04 10:34:54 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master-spi-fixes
>=20
> for you to fetch changes up to 3faeb78378ea32922fbd00e9ddf675ce0aa526a3:
>=20
>   ARM: dts: renesas: Minimize R8A779G0 V4H RPC SPI DT node (2024-09-09 01=
:10:44 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--X6PVCgc5mdLL1rnU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbfbpsACgkQFHw5/5Y0
tyzvpgwAr5n9A399s9tH+xMjCmku4eU/6RBoMbJzHuPs3Tp5i+ugQSAK+KeeVCUI
saOT2Y7EMCtkBvlEWyoCNdI/Kt8bae2YC13k5A4rvl0Uqdy6AUbsS8r3miKkCs8M
2AlXEUxGFY4/qHUp5xEwR+B0oglxEe95vBNG0BkNfhjpt0woY21JP91zIQuyGj6Q
/ORqcuPSE8OeWYQKYPmwFZU3qO7eVf4CI6BtFiaGL1tBzr9Lz/Xd80UXi/Sn05GD
eFpMhGGkp76yOBaPbVSS0wJQ/QCTAv2MsFFYazVmxTz707gpgadL2wxVoyeyc6cr
Y2Y1lanr8ZIW3plHjcaJXR5VnPmOuG80TWGpJI0kRZbl1mw/sshsII1mLla8xFZ/
dAY4lXPn9F/cN+ixyn2Lg0N52kePuNZRYHVqheOsB/3fcArg+M6+rcW2fN920qXu
Tg201JX37DClA6LmAl0mwQt5c/hu1qZcHaz31XVFFciWB4jaA2aMRo/jFUY2GW47
NPE0PAq1
=9T6w
-----END PGP SIGNATURE-----

--X6PVCgc5mdLL1rnU--
