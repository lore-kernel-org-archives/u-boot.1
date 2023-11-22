Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A3CC61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BEAC87691;
	Wed, 22 Nov 2023 21:50:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mj1+M5M5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8498B8765E; Wed, 22 Nov 2023 21:50:11 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F768768E
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5cc60973b4aso1880067b3.3
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686208; x=1701291008; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MI3H9z3tW6GdviEr/2927QwbF3Ojxu/FbK8R84BjaCU=;
 b=mj1+M5M5XImIZZO1gUebiUssPg3RSJYWCBpWZshPL3cSGUJ8+1kcYI27Qvh0IRlmeT
 G2Nsszsi+D79AsA2kg7LWcjLinJLGf7w4iPHN/bFgZ0Z7BwzN4DZQ6Ao7adLK9/J1UGU
 RZBot2s9xZ+mc6rjWBjW5I8cNlTVq+8ONL9cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686208; x=1701291008;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MI3H9z3tW6GdviEr/2927QwbF3Ojxu/FbK8R84BjaCU=;
 b=tCMzUd3d6E+px7WGSIaZiCWSRdS30cx8zVkP875aGhVjj99/1sCvM+HGEMRQphQh5h
 6JIYVhuV9ePOuinCVFpdqhOswNTOclhUMm4wKwUMS4uo+qofzzSTQk6pVWx51cn3LpHx
 Sq7pnIs829leC/YxHef8FeAyqFGuvzzcx6Nk5DHRwhbcUcEhpK6SYemYxPFaP33ETvYe
 fYT7rhNu/zOZcA5gLkLLCY/US+K9QQCil2C4r13PQ8ETyE9l7jCVK4vlMVpKQi/94K8B
 UQ6YxRztjw9zmB6VTl8pp2Sc1B/fIsY5zwxmGeDK+m4V1mY+psup8SanxQpQrsMeTYT4
 bClQ==
X-Gm-Message-State: AOJu0YxfVsPehhx2YupCdhAGBsfRzrjJmHHvme41aPluXRVKGrJZFkjG
 P13yB0h7g+yIgDcwexkDEKSxaQ==
X-Google-Smtp-Source: AGHT+IE+mHtY5zIpBtVVPhRbaeviTSazn+1YxlHLg6qTE0K1WgYaxLbTTFpkL8EQFK+52vue4NykpA==
X-Received: by 2002:a05:6902:34f:b0:da0:4453:8f10 with SMTP id
 e15-20020a056902034f00b00da044538f10mr3282594ybs.43.1700686208150; 
 Wed, 22 Nov 2023 12:50:08 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 k16-20020a056902025000b00d9a36ded1besm1538402ybs.6.2023.11.22.12.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:50:07 -0800 (PST)
Date: Wed, 22 Nov 2023 15:50:05 -0500
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: nm@ti.com, marcel.ziswiler@toradex.com, s-vadapalli@ti.com,
 r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH] arm: dts: k3-am625-verdin-wifi-dev-u-boot.dtsi: Fix DMA
 with BCDMA
Message-ID: <20231122205005.GK2513409@bill-the-cat>
References: <20231114202856.39072-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="55MWaw1rv+hfGk6q"
Content-Disposition: inline
In-Reply-To: <20231114202856.39072-1-rogerq@kernel.org>
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


--55MWaw1rv+hfGk6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 10:28:56PM +0200, Roger Quadros wrote:
> BCDMA can be used at SPL for OSPI boot and mem-to-mem DMA

> so add "bootph-all" to BCDMA node.
>=20
> Suggested-by: Nishanth Menon <nm@ti.com>
> Fixes: 9a3f2b6798b0 ("arm: dts: k3-am625-verdin-wifi-dev-u-boot.dtsi: Fix=
 DMA/Ethernet")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Nishanth Menon <nm@ti.com>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied to u-boot/next, thanks!

--=20
Tom

--55MWaw1rv+hfGk6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaX0ACgkQFHw5/5Y0
tyxilAv/ckI+wujiFw2Yvz1FIem8ud/SO6IIFUi1B6VTxR3lIvN5xMQg2a71Ygfv
sEWixjry7gnhgTD/kBJi51eTB7i+uZ2cC6TMnWichUmobwXbpQPHBTnEk3ZO1hF/
c/FiO/ZCcFuc+s8fFk0mzgj2j9xGgE+3X1LhQkKlQDWiaFBYVFRGgp6dPVeEqUyl
7xhH1Q3GcpW0fT2JGOVPRiGg72CZoPPVKCIZeuHrXlsOFGvPeNleWDBilqGuX7H7
R1AqtHksbFDF9/oh5r6c6R80tIAI9tHOWZeklbQR+uFXpeQVzBFCGmp0OlDQGlnh
RrihnfuRooN6JW/SnkHpP2YQZ4RwdIARzLVnvkNYd9Lwvy7aqOIxVZJMfoYMwKlM
6rO3cujza7+mEoe5xpvsDrRXQXUKu6IYt4uU8F0yh3ks6mOwGzVhTjmX4eGrqAmo
VKSWkBRwTHodPSGxl3Jmlj/4gyjlWIhx7CNoCtfgmaiCrdjHYBsJwC9lY2d1IA//
/D8w9fux
=l3aE
-----END PGP SIGNATURE-----

--55MWaw1rv+hfGk6q--
