Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655E6C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 13:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD9F805C5;
	Tue, 21 Jan 2025 14:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="VYk0io+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C95CE80763; Tue, 21 Jan 2025 14:14:36 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7817580326
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 14:14:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e549dd7201cso9543394276.0
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 05:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1737465273; x=1738070073;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pxs2UTCuWraOZGrtjxP/6RS/vmnHk7FALizmLvNrPc=;
 b=VYk0io+IGBkaTVegq/2F6GCKkbOs+UB1n5T+Z+2DQ7BXf4+dmOxbxABOEK+Za/UHUr
 Ovdvn+7KYVt9VKlT/rA+fePhM4aZ9sZaFcE9/VXQO/ijbYVPxbZecyTeGpDc/XIaW9FF
 b+y2BhVsb5SPCR3LZwrKSnFDXCrtCxV+cI4PkQFlTawrYb8Aaqo2m67n/Rro2mt5zhUX
 /S5Gg5WKq98vOchEpM4KRAKivp3DGxlqhjljR1iTReMtriord8JqMuZWAllgWCAOoZ/r
 1jHnJoSP1jAOjySyOsx2YwUIgVm7vTGyCS2uWfpl49HnPVfjv0DKmD3y2r+qDD37hEYI
 0ZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737465273; x=1738070073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2pxs2UTCuWraOZGrtjxP/6RS/vmnHk7FALizmLvNrPc=;
 b=FeTeloBHk3oeOpgn7+kymIVuLUmDPfJq6DKpOEyDRj/EqLBuJ0t3BkcFj2/INFLLCF
 joynTfDDi1Ydb8PF0A0SS3bwA6ssZnHYaEgZonlU6gLVYtqdB57KIvuLvup6yU1mMXKw
 1FeTeK7tXG2cB2viJkkukkLo7Y/Btru5RBucjtLG07ETfHSzcp33K9renlgYyx2yw1Hk
 LDP/ESg05BRh0l6T/AWosCQ1lPO3kpno9kqLRJqbbo9JW0kVUGVs6x0MsM160ykgp8IA
 RjbUAJRdAXGPpReWfiQaZ5tGUKNko776BPGC9RkWUM4Y4YgmK0v/PhwfEYTyZLxAUvVq
 6V2g==
X-Gm-Message-State: AOJu0Yzw2EiOJ4lW9JAOWCPY8tKNEJ3dk/FWIWMHub5cvH4j2VW19m5V
 3RNZLZUtXifhQgNiWmS5nE4CW+WDBtC6MApDFGIA4zbHuLEfBpgBGgUfGxjHuxu04QmfAon7LHr
 U8d8z3CPadOBxImeD36sQXYACUvyEoll5+se4
X-Gm-Gg: ASbGnctAxMLVz7hHfhCjT9LpBdSFRe4Vc4lQXPf0kes3APrBRV8S0YLWS8hTbQfss79
 XqfGm83mmiYbDFGnXscV6peMlJ7e4+TwCAMkJX/beLKV6+o50Pp0+
X-Google-Smtp-Source: AGHT+IElkzB/Q7MUcpBdSZHLo0QLH5y5t/oPvMGrrgNfRJLDQAB19wiv4goz7DM47OzIb/VOUFoqzZM4YSfu8HM6p0U=
X-Received: by 2002:a05:690c:7084:b0:6ef:7f34:fe1f with SMTP id
 00721157ae682-6f6eb677dbfmr132034757b3.13.1737465273361; Tue, 21 Jan 2025
 05:14:33 -0800 (PST)
MIME-Version: 1.0
References: <20250116054324.836712-1-tapio.reijonen@vaisala.com>
 <20250116054324.836712-2-tapio.reijonen@vaisala.com>
In-Reply-To: <20250116054324.836712-2-tapio.reijonen@vaisala.com>
From: Michal Simek <monstr@monstr.eu>
Date: Tue, 21 Jan 2025 14:14:21 +0100
X-Gm-Features: AbW1kvYpD_tzdNYru3I0cMmEp1FpGbe2ogcmjwgC8bVvp0iSSVAMluL42AOPfa4
Message-ID: <CAHTX3d+Gb+KHHLaDpuHsei+4aQVYk=+urG1u-MaxcaZGdeHmMg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] net: phy: Let gmiitorgmii converter create
 additional PHY
To: Tapio Reijonen <tapio.reijonen@vaisala.com>,
 Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Eugeniu Rosca <erosca@de.adit-jv.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jacky Chou <jacky_chou@aspeedtech.com>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,

=C4=8Dt 16. 1. 2025 v 14:07 odes=C3=ADlatel Tapio Reijonen
<tapio.reijonen@vaisala.com> napsal:
>
> Change the order to connect gmiitorgmii before PHY creation.
> The gmiitorgmii create additional in DTS configured PHY during
> it's configuration. This ensures, that converter sits between the
> MAC and the external phy
> MAC <=3D=3D> GMII2RGMII <=3D=3D> RGMII_PHY.
>
> Fixes: commit a744a284e354 ("net: phy: Add support for ethernet-phy-id wi=
th gpio reset")

From format. Look at link in 2/2.

> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> ---
>
>  drivers/net/phy/phy.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 716a1d46111..740533adeca 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -939,14 +939,14 @@ struct phy_device *phy_connect(struct mii_dev *bus,=
 int addr,
>                 phydev =3D phy_device_create(bus, 0, PHY_NCSI_ID, false);
>  #endif
>
> -#ifdef CONFIG_PHY_ETHERNET_ID
> +#ifdef CONFIG_PHY_XILINX_GMII2RGMII
>         if (!phydev)
> -               phydev =3D phy_connect_phy_id(bus, dev, addr);
> +               phydev =3D phy_connect_gmii2rgmii(bus, dev);
>  #endif
>
> -#ifdef CONFIG_PHY_XILINX_GMII2RGMII
> +#ifdef CONFIG_PHY_ETHERNET_ID
>         if (!phydev)
> -               phydev =3D phy_connect_gmii2rgmii(bus, dev);
> +               phydev =3D phy_connect_phy_id(bus, dev, addr);
>  #endif
>
>         if (!phydev)
> --
> 2.39.5
>

I can't see any issue with this swap but I would like to check your DT
description first.
Can you please share your DT fragment which describes this?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
