Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB375C6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30BE088077;
	Wed, 20 Mar 2024 15:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zc0/mUVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34B3C88076; Wed, 20 Mar 2024 15:30:56 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 074CA88076
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:30:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-dcc73148611so7281268276.3
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710945052; x=1711549852; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EoUTEcNEmknxEvZ5onK/mvSypwIZzbPNzNpuIQtRJHc=;
 b=Zc0/mUVDM71DHcXRN5sh5TGnAq2atVwo6Zus56Q+7IqVWBlXdrLt8EqIh6MPNLdTlU
 1D9kkM+dr2GvbqngIaGzI/Atb9VsiGmMHiwTy7m4xy0KdVzclahAA/kzBXw8PWa8heCF
 7aHsziUJ+IFa0dtTkBkAo3eQAK9s7nKK+3deA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710945052; x=1711549852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EoUTEcNEmknxEvZ5onK/mvSypwIZzbPNzNpuIQtRJHc=;
 b=HSzIKFzgpnAth/qNGV6yOCK6PNGi1iB+qr0pDevRXIL24L5AVtwaQNMJHpmtoBHiSj
 RZxvhjStgyIpY47MTHOKFqRo6RP+6CLuodsVaILHSksGXARhTWCaJZyOR558lj0FHEeY
 riI0A2Txk/ZVeLypVOdqRMcJcrM0gYRk5z3DAggkB2bLVy4WUwXHZIAdjXRGxK2FU6IC
 6PMo67s9K6aNE/bj8u/7RPzSpyXu8KvEPdapuS1IAf3hvTGn8VUuq1BGOPAow7pFBjXs
 5UYxc2/0Mb2BdBOQD9UN4C1ec6FkXkKkogZIWCAbmJxWXtx/j5cwql2tNqgVET4o8hEh
 zMOg==
X-Gm-Message-State: AOJu0YyqKFDGpx1GeBwKf+AbtDyIZzdDH9leXT48gTYOtox0uan6H8R8
 TquJnJGGPiBImujOIeTgTckTRzHDWh5KfC3MmCaumtLaNAJ5FzQJ6b3RS0VnFfs=
X-Google-Smtp-Source: AGHT+IFj2Y6Wwp0Qb/8Yps6euju/JIBdd0hXn6r/8Rjh9dcmEULbgCfdCD6nMTldv5uIB+kQwzPHzw==
X-Received: by 2002:a25:bc82:0:b0:dcd:5bdb:4aa4 with SMTP id
 e2-20020a25bc82000000b00dcd5bdb4aa4mr15396331ybk.51.1710945052177; 
 Wed, 20 Mar 2024 07:30:52 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 v89-20020a25abe2000000b00dc701e0bdbcsm2680395ybi.44.2024.03.20.07.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:30:51 -0700 (PDT)
Date: Wed, 20 Mar 2024 10:30:48 -0400
From: Tom Rini <trini@konsulko.com>
To: lukas.funke-oss@weidmueller.com
Cc: u-boot@lists.denx.de, Lukas Funke <lukas.funke@weidmueller.com>,
 Andre Przywara <andre.przywara@arm.com>, Bin Meng <bmeng@tinylab.org>,
 Chanho Park <chanho61.park@samsung.com>, Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] spl: Introduce architecture specific init function
Message-ID: <20240320143048.GU3442575@bill-the-cat>
References: <20240320131928.1836386-1-lukas.funke-oss@weidmueller.com>
 <20240320131928.1836386-2-lukas.funke-oss@weidmueller.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8hUoe5HsmipEH0ca"
Content-Disposition: inline
In-Reply-To: <20240320131928.1836386-2-lukas.funke-oss@weidmueller.com>
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


--8hUoe5HsmipEH0ca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 02:19:26PM +0100, lukas.funke-oss@weidmueller.com w=
rote:

> From: Lukas Funke <lukas.funke@weidmueller.com>
>=20
> Some architectures use spl_board_init() in their architecture specific
> implementation. Board developers should be able to add board specific
> implementation via spl_board_init(). Hence, introduce a spl_arch_init()
> method which is called right before spl_board_init() for architecture
> specific implementation.
>=20
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>

I think this could allow for other SoCs to clean up their existing
ad-hoc mechanisms for SoC/architecture init and then board init, so this
looks like a good idea to me.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--8hUoe5HsmipEH0ca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX68xIACgkQFHw5/5Y0
tyxMSQv+O1FW7d/Ky8fsx468H6N5flg17N6j2KuVpvBAgFj1AlQp9xI55TOx8rVr
nfpgKZlT/ujOAQPsSYQ0PdurZSs01xsOlUUQLrqULg8ivqSyA2FDqeY5IuqZBU60
NMOVpMqf3hnbWvqsSN0FjPZZoGfMS/KvBQ1C/DL1y4A4mTxZwseCs22DWWwgpdFC
lMAf5Igqnj72x+xKHtJ2sSALhVJPPbc3z9rkKtj4/CPMH0MngFnkrWtg5Qv3jC1Q
ahI3iyjRNgY+RfWNdreUAxwZQLH9F+aN5O28oOvs9NMIHPDf6kacewptmw2HVnD9
wN8xVWrnjhYI1/0z78v+2DazeMVBnxCjhEMHqSX+g1DJ+56NpnlDlbl9wOXCdVpb
YOsOAk8gEJFOF9ytmjF55zO0+0haOfIaASXGFTMXuF7yD2QEImBaOaW6cIiXIYK4
uOfUjg970suKbTATL7Z8htISWhuAZnq2s8nVs1I84bYJMAh92kU3MgNq9BkniTp4
chyItKKu
=CdG7
-----END PGP SIGNATURE-----

--8hUoe5HsmipEH0ca--
