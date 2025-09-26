Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C658ECAC5B9
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 14:08:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0DEA8323A;
	Fri, 26 Sep 2025 16:08:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fou6duvL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BFDC8329F; Fri, 26 Sep 2025 16:08:34 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 428A283192
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-90a0b3ddebeso61353739f.0
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 07:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758895711; x=1759500511; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hy1VUl0aUlKNQ19oeEB0JT6vnzebDfPeTQL9vizku2o=;
 b=Fou6duvL+b0zmAzTiBY1oNA4w1IkhLnX838qwvls0AvXoFs34Upc7ih0YWbPdO/XLE
 hrc2T/igs3OM/zMbCsc8ezytZiKUASBTdFqv+YU3MArwE2NdiSdWXbiOQxzy/pOZ8nzm
 xabtKGfy69ngivUZyg9UNIFmfiePN1Zsb3J24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895711; x=1759500511;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hy1VUl0aUlKNQ19oeEB0JT6vnzebDfPeTQL9vizku2o=;
 b=niqbW7TVmHeXEwr/69nzBxTuzG6R5S22rjEq7zIzXUEimEPDpb+nJkCWhZ1g1A2lQn
 ddbKHCXLEshs73t0DtZ/q0U1Z+00Tha0aJqMlA1+00m9I/yh0StMOf7i1+WK2y0rSxVd
 qluoLl5+oNZMP6mN3jEJOuHAnFgkUZZ5dN4HGrbUiL+yNTF13SOuMrDA187pgTXbWNXy
 l2ulAvGBNts+sCwaB3w8JrFnDzqYh8ANW1fNNF58b2ZBzI+AkBRX7n7gEeFu4Rv6QKsW
 Osc14Iw1DY5KgPM0P0iaLH0zcqg1XnA5ZkuvXriGG+o2jn5Evuek9BfPmg0oD0VJY/H/
 dsQw==
X-Gm-Message-State: AOJu0YyVj5AadQ+/1WmF6QstYTrUe6MpJ2DlOwnD2nUB31ZlJttuT+SJ
 9eQzkWhUsuEkEa/dg6ZldkUqvlzeCcTl6tqK1piMjhoepEca4brGtaGw60uPQAkcIhxjhNZ8uRa
 GQkqnIVM=
X-Gm-Gg: ASbGncuUkGUC2YyqCa8gf7ku1Z2Hwgmbp8IHoOOsGgKOLj5dMBF7joAk29seoUZP32Q
 uXv5GeikFsGj1jSWBggSAQ/9Gv4HZ9ZumxcUMqC6RwMeuGlmOsobWr7juos5d79q9LPqxvpEzK/
 qK3dEeVsi2eEpw3tyRd1ZkViAr+/ydja2OaSkSMdLtqjsgOjTsJ4pWRhuLBbVDxk7QUB1clNRbA
 pMI6dTIxYYx2PJbGRMNYvpPxBr21HduHnyiBgbjvSlJGlcJqQGwYKQ9psMYCM6MaoZfzi9T1meC
 kO93f2mLB5MvDS5TwqWAZDloRpzh1T9qJd4w/ZJcIAoOMxCwSau+3/+2dY3Q0OusoX0ijLi2bPD
 YrZPi2G1mFMVBsirkSzcYGyFHb7kYw6fZQVvU/0y77nKegHy9f4gxYKSa0HakNjwLHWk=
X-Google-Smtp-Source: AGHT+IFsc66E2Djx6Za99soGaODMMaxLuwv0TgTj1cQRvQdfzo1Ku2iu2SUKmLWIxVq03W5+0qAROA==
X-Received: by 2002:a05:6e02:b22:b0:425:7974:fe32 with SMTP id
 e9e14a558f8ab-425956541ddmr104887665ab.23.1758895710629; 
 Fri, 26 Sep 2025 07:08:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-56a65654b00sm1886308173.29.2025.09.26.07.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:08:29 -0700 (PDT)
Date: Fri, 26 Sep 2025 08:08:27 -0600
From: Tom Rini <trini@konsulko.com>
To: "Ng, Boon Khai" <boon.khai.ng@altera.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>
Subject: Re: [PATCH 4/4] net: Tighten more driver dependencies
Message-ID: <20250926140827.GT197373@bill-the-cat>
References: <20250925204414.3561033-1-trini@konsulko.com>
 <20250925204414.3561033-4-trini@konsulko.com>
 <SA3PR03MB71879F064700EEC64233B7CBB41EA@SA3PR03MB7187.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="86qnltLkfVFYSLv5"
Content-Disposition: inline
In-Reply-To: <SA3PR03MB71879F064700EEC64233B7CBB41EA@SA3PR03MB7187.namprd03.prod.outlook.com>
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


--86qnltLkfVFYSLv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 05:53:14AM +0000, Ng, Boon Khai wrote:
> Hi Tom,
>=20
> >  config DWC_ETH_XGMAC
> > -        bool "Synopsys DWC Ethernet XGMAC device support"
> > +        bool
> >  	select PHYLIB
> >          help
> >            This driver supports the Synopsys Designware Ethernet XGMAC =
(10G @@
>=20
> That case we shall remove the DWC_ETH_XGMAC config from our
> socfpga defconfig?
>=20
> > -190,7 +190,8 @@ config DWC_ETH_XGMAC_SOCFPGA
> >  	bool "Synopsys DWC Ethernet XGMAC device support for SOCFPGA"
> >  	select REGMAP
> >  	select SYSCON
> > -	depends on ARCH_SOCFPGA && DWC_ETH_XGMAC
> > +	select DWC_ETH_XGMAC
> > +	depends on ARCH_SOCFPGA
> >  	default y if TARGET_SOCFPGA_AGILEX5
> >  	help
> >  	  The Synopsys Designware Ethernet XGMAC IP block with specific diff =
--
>=20
> And preserve this config DWC_ETH_XGMAC_SOCFPGA?

Both of the changes have that effect. There's no need to update the
defconfig file, it'll get changed on the next resync.

--=20
Tom

--86qnltLkfVFYSLv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNaeWAAKCRAr4qD1Cr/k
CmekAQCTqfZHbRt9nMIe9hR9QE6uIY5iVcpomK+/k/S0LCB/VQD+JpycobpnFDKP
SzWbaUQf/0wDwU6sXMTmf3WsAY+Llww=
=Me50
-----END PGP SIGNATURE-----

--86qnltLkfVFYSLv5--
