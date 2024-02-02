Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2095EC4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 20:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C09787E19;
	Fri,  2 Feb 2024 21:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="Mi67L4hd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB0F187E1D; Fri,  2 Feb 2024 21:14:51 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A189F87E19
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 21:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d0512f6e32so30221311fa.1
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 12:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1706904889; x=1707509689; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/miyXERwqxqfqL4/PQJMmiJUolp8gBqbJ+H1L5VQAI=;
 b=Mi67L4hdsczLB8X1eQXBpWUblSWC7j286BNpCGM6t1aXwX8gwOFIXTlzciXhFVkosI
 qcakCM6EETt3llWybXJhwPZQigS0ddpMmzZL2UXNYYrWZ1y6bJhYau5bsGp5aHrYx9NC
 Qbgz1nK4hozPWBBUBDMS79ho00PH2yPMo1QqKZh14q0wGWUsxj5ZlIaWjVTleK4Nt36n
 0Tlu8NWI/HNI3xxWSkOM0ZdAZdqDNYcLSGl0l5hNIyqkB6vxMXx5TAcP2jspWPlaOXVE
 mkLwmjBRWIXTchRyFxvxzeo+5FaFoz37+nf6924ft626C8eNByxxPhdAbH6gD7idQ+It
 8jjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706904889; x=1707509689;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/miyXERwqxqfqL4/PQJMmiJUolp8gBqbJ+H1L5VQAI=;
 b=u0l8QeotRQeSgy+hC2dwQ8kyEtFJS9aAuH9ioPXTYy8p7Co890luDpA7vLhjmzjkMC
 NYKZTgt9s/8CeGfZS6tWl/5qstnPr6L6186I6o0vOeKs+LSrTcy6NbH+x7KRLs6yN2UN
 Nbc6E1MfILFDZExnGxqzaMgsIycY/WSbJvQhkVL0cJ4eKbM9sO1S3BSSz/fAmFJ5Pz7j
 BtMIlaV/zOSfem18BS1h0xo+ZX83PjSID/RxTJfL9/unGG0rMnihPlpTx1X4sZSCYxdC
 +QO0FXvUbAonrs9xLnL44lfdzsSE5xLoS+Qo/OdYho3kk3Rbn44R7rr1UN6jCHEueL92
 FW1g==
X-Gm-Message-State: AOJu0Yw8Ec/Y63ZpdmAvTqhwkE/CdOIa8EI4umFM1r5DFU4vPZszfND8
 /WSVAHXkcj5o7zsmX7zT7JuJAxXNWkL9c93kSurL9gsIMAa630qFski9P51FQC5Orwpvd6qHDDF
 /EZfGMnx9tVImE8P6Nx0BpTpPTOIU97ZHCs5awA==
X-Google-Smtp-Source: AGHT+IFjf65tyMoriEmj8f30pNjDTDrvRdcXgUUJuDay/UBjYdxyGHq5OLfdkC02nWsJA0TzH4foqtBAIsGxo6DziWc=
X-Received: by 2002:a2e:a589:0:b0:2d0:5f90:2b29 with SMTP id
 m9-20020a2ea589000000b002d05f902b29mr5019662ljp.12.1706904888494; Fri, 02 Feb
 2024 12:14:48 -0800 (PST)
MIME-Version: 1.0
References: <20240202160405.4126192-1-festevam@gmail.com>
 <20240202160405.4126192-3-festevam@gmail.com>
In-Reply-To: <20240202160405.4126192-3-festevam@gmail.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Fri, 2 Feb 2024 21:14:36 +0100
Message-ID: <CAL6CDMGa=7R1MNX0xz42_Vy=Bs4GQRr_gZoY=mEWcZsuOUXLFQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mx6sabresd: Remove board_phy_config()
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, trini@konsulko.com, uboot-imx@nxp.com, 
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

Hello Fabio,

On Fri, Feb 2, 2024 at 5:04=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> With Ethernet DM in place, there is no longer the need for having
> the board_phy_config() anymore.
>
> Remove it.
>
> Confirmed that TFTP transfer still works fine without board_phy_config().
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v1:
> - Newly introduced.
>
>  board/freescale/mx6sabresd/mx6sabresd.c | 34 -------------------------
>  1 file changed, 34 deletions(-)
>
> diff --git a/board/freescale/mx6sabresd/mx6sabresd.c b/board/freescale/mx=
6sabresd/mx6sabresd.c
> index b558a596dff8..bb066a5d36c3 100644
> --- a/board/freescale/mx6sabresd/mx6sabresd.c
> +++ b/board/freescale/mx6sabresd/mx6sabresd.c
> @@ -7,7 +7,6 @@
>
>  #include <image.h>
>  #include <init.h>
> -#include <net.h>
>  #include <asm/arch/clock.h>
>  #include <asm/arch/imx-regs.h>
>  #include <asm/arch/iomux.h>
> @@ -254,39 +253,6 @@ int board_mmc_init(struct bd_info *bis)
>  }
>  #endif
>
> -static int ar8031_phy_fixup(struct phy_device *phydev)
> -{
> -       unsigned short val;
> -
> -       /* To enable AR8031 ouput a 125MHz clk from CLK_25M */
> -       phy_write(phydev, MDIO_DEVAD_NONE, 0xd, 0x7);
> -       phy_write(phydev, MDIO_DEVAD_NONE, 0xe, 0x8016);
> -       phy_write(phydev, MDIO_DEVAD_NONE, 0xd, 0x4007);
> -
> -       val =3D phy_read(phydev, MDIO_DEVAD_NONE, 0xe);
> -       val &=3D 0xffe3;
> -       val |=3D 0x18;
> -       phy_write(phydev, MDIO_DEVAD_NONE, 0xe, val);
> -
> -       /* introduce tx clock delay */
> -       phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x5);
> -       val =3D phy_read(phydev, MDIO_DEVAD_NONE, 0x1e);
> -       val |=3D 0x0100;
> -       phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, val);
> -
> -       return 0;
> -}
> -
> -int board_phy_config(struct phy_device *phydev)
> -{
> -       ar8031_phy_fixup(phydev);
> -
> -       if (phydev->drv->config)
> -               phydev->drv->config(phydev);
> -
> -       return 0;
> -}
> -
>  #if defined(CONFIG_VIDEO_IPUV3)
>  static void disable_lvds(struct display_info_t const *dev)
>  {
> --
> 2.34.1
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
