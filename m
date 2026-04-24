Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB655FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43A7A8445C;
	Sat, 25 Apr 2026 20:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="Ap9IlNFJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65D6284462; Sat, 25 Apr 2026 20:13:55 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC3A7842FC
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-8cb5c9ba82bso1355960585a.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777140831; cv=none;
 d=google.com; s=arc-20240605;
 b=FfsVYi0RyIAnk4RE0MDdn07Rxlzc5nM8td87uQTbL+qigTLXERVMOCM5foPT1kA67S
 v+gr5dgFHVx4NWixqtWt7dKgzGuSo2wdMSrmtceV0tV013wj/xsFtdsQ05xMjj9Ujb16
 qE0c0pHAfhHcWTTYj4krv45OOsuIt4Hzan2rOkH2UQ0VSbXmxKc15+psDvP8gvtzB5r3
 rBMcVkDj78vsDHsH0e/xWU9sopMaaAf27kz1oj1/oNUs1Aj73mMwNJWR50+wMHIgVdb1
 IvO2loy2VN5GD782BgVch/kSijLXzunoJp0dxVlPsz209kQEsh/lINsXruzlXd0mZuCG
 XeXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hdTF+bMnv6bBoOrmpdXCJMTEGvDGsgaCibATBmLHdps=;
 fh=mH/4VRnOPO90qrWF8WAaltchqTpn6XbMSTb6A2AVD/Y=;
 b=dAKmpUj/4Xv/bCgVjofUQdacFY4IASM2ZfjxHY2Fx/nG4yVnCw9mjZl8lyDNlWyCjp
 gBT3lS32A3CowmapE6FwdNh9KDKLjAwzCvC/dP549vOzD7/mtKZz93L1aF7iWCn2vEom
 Sg57WNPyBF4tc/YUq/V3qao4fvE0L3oT+S1Ip+zJwDmDNygHJYEmRJWTv5YjsPjbwsqo
 rMaT5t3Jq1eAOJFVOOvA23YhJcQq7xVrArKSKkq5+TNTDJibfBMmPxVJDLH8QinDovaF
 IwjRdLCD0Slpj6rX+PhFlGF00UrELOoyGaH/GOA6kkAD8geZtteccJc6D8gjcD7Quj2A
 VM3g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1777140831; x=1777745631; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdTF+bMnv6bBoOrmpdXCJMTEGvDGsgaCibATBmLHdps=;
 b=Ap9IlNFJSfILjkv8ZOIqNN4BrTbaIK/Jsx3bSdEGwDih2Vif+8lE3yrVL8pE8+UFLf
 svDnaRPNO7jY8yOknaNSGByxXjTxzDkB37fCCHywwKdE12GSmTuwu1eOZe+g9cTenstf
 9Dyz0XjI9pFYkV1tfbLCKuBrIZHO5I2yKi/Myy1vDLVbw6cf+fSngC3MNpcbjG/0YSVQ
 lqEgwV+kRywIsWQTnUPjVu/pBXf8ymuRMfV8hcR7hOlMv/olFDXbUOBs1kwosl7G2DsK
 J7dZrkKWB5cC8UijnvHGtuba1auj0fu711zYGdO8s0cO4IQfNP6m3vKKRyUQtJZ0VI6R
 sRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777140831; x=1777745631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hdTF+bMnv6bBoOrmpdXCJMTEGvDGsgaCibATBmLHdps=;
 b=nHGoE7/9w/b9X+Zt/Jouy551BvNDm2WktlZpIWv5NM1QBXPg2FdgV1V24DmQAo59YB
 PaVMJuX1g6HcQz4ZhpKDP2tyQXmEnWiA8iPNeGuIGbenhaqIp03yK2ko1UHIz2VlKtqO
 IsQLyhbCtPVBXQleikn4BKgAtFNGaZ0rIiTNnkw/lxTPUDTzddsyuaEHAUvADscQ7E0R
 UjjkD7ewrVzNGcBAeF7Avb8vuiU9YLCX+IRjFOO1ZZ9qlFc4JttVWem4RmmeyC8BPFgk
 +BACM3MAiGylnKKPLnOgm2Ok/MVq83NkueFNr/5p/t9r2J64XjZ+cK0tGTdvJp2W+c2W
 wYdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+r+pJCruJ4hfVZThja5o5Zmc6khe1r0zMCNDkllMVK+c6yZKmVgkH/MW7V5b5+im64pcNbaTE=@lists.denx.de
X-Gm-Message-State: AOJu0Yzi8a4Z0TbhMK37xVAdlcVjQ8/xPu1K9Ss0yWVuulItS2PO2W3N
 XWkEoSmjiGILKfiKFtX5+u2ZhEiZnl3otgwWBGJma1PFPebFsFExy2q9OGs9wxFERy14qgzesMu
 7rSn3tka4gtXhO5SsYGB6NRDkbEL1+J2jgTDGdQmtivQwrz+sEro04Ao=
X-Gm-Gg: AeBDiet/bBFsUy98S05HpU7akOXRdOW8FABDEi+2ut0b4uc6T2TeOrXi4/pYWsuYPI6
 WR9jM/Gup+wzQDC0KdLmbJj8GQ6lj5cxMKCNX+q8kU5iTVgEzlqJkgGAWMd/zHZdYdb1mSWAgjB
 8uxpopEW+ebt03rtseBSHKzusolnz6nn6Embhi8UY/0p/6Cf9IVoBs9L+52mLFQ3f76tNSpbhhb
 fbbfSQkBGx7nv+03dxlR1OcWY9NUsbxPjVYiywHo4LTp1c1YJqmzIITVe/MlNYL2QeF4dBdLHKE
 t0sj1aE/A4YKDwkSrw==
X-Received: by 2002:a05:6808:19a6:b0:466:f57b:2ad2 with SMTP id
 5614622812f47-4799c9a833amr17093303b6e.31.1777045857037; Fri, 24 Apr 2026
 08:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260424-imx952netc-v1-0-87723013827b@nxp.com>
 <20260424-imx952netc-v1-1-87723013827b@nxp.com>
In-Reply-To: <20260424-imx952netc-v1-1-87723013827b@nxp.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 24 Apr 2026 08:50:45 -0700
X-Gm-Features: AQROBzDd8nqryfeo-AFM43w4mX_Dw3bP8gcA2XyB7GXcJq_mHHZY_tp423sizxs
Message-ID: <CAJ+vNU05YTaOPgYnSvUFnciz5smSv6AAK5TEqY5i9312X+5XYA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] net: fsl_enetc: fix the duplex setting on the iMX
 platform
To: alice.guo@oss.nxp.com
Cc: Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>,
 u-boot@lists.denx.de, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Thomas Schaefer <thomas.schaefer@kontron.com>, 
 Michael Walle <mwalle@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Jacky Bai <ping.bai@nxp.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Alice Guo <alice.guo@nxp.com>
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

On Thu, Apr 23, 2026 at 11:54=E2=80=AFPM <alice.guo@oss.nxp.com> wrote:
>
> From: Clark Wang <xiaoning.wang@nxp.com>
>
> The iMX and LS platforms use different bits in the same register to
> set duplex, but their logics are opposite.
> The current settings will result in unexpected configurations in
> RGMII mode.
>
> Fixes: e6df2f5e22c6 ("net: fsl_enetc: Update enetc driver to support i.MX=
95")
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/net/fsl_enetc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
> index 206f1a381bb..b07193e4e83 100644
> --- a/drivers/net/fsl_enetc.c
> +++ b/drivers/net/fsl_enetc.c
> @@ -18,6 +18,7 @@
>  #include <asm/io.h>
>  #include <pci.h>
>  #include <miiphy.h>
> +#include <linux/bitfield.h>
>  #include <linux/bug.h>
>  #include <linux/delay.h>
>  #include <linux/build_bug.h>
> @@ -396,7 +397,7 @@ static int enetc_init_sgmii(struct udevice *dev)
>  /* set up MAC for RGMII */
>  static void enetc_init_rgmii(struct udevice *dev, struct phy_device *phy=
dev)
>  {
> -       u32 old_val, val, dpx =3D 0;
> +       u32 old_val, val =3D 0;
>
>         old_val =3D val =3D enetc_read_mac_port(dev, ENETC_PM_IF_MODE);
>
> @@ -416,15 +417,14 @@ static void enetc_init_rgmii(struct udevice *dev, s=
truct phy_device *phydev)
>                 val |=3D ENETC_PM_IFM_SSP_10;
>         }
>
> -       if (enetc_is_imx95(dev))
> -               dpx =3D ENETC_PM_IFM_FULL_DPX_IMX;
> +       if  (enetc_is_imx95(dev))
> +               val =3D u32_replace_bits(val,
> +                                      phydev->duplex =3D=3D DUPLEX_FULL =
? 0 : 1,
> +                                      ENETC_PM_IFM_FULL_DPX_IMX);
>         else if (enetc_is_ls1028a(dev))
> -               dpx =3D ENETC_PM_IFM_FULL_DPX_LS;
> -
> -       if (phydev->duplex =3D=3D DUPLEX_FULL)
> -               val |=3D dpx;
> -       else
> -               val &=3D ~dpx;
> +               val =3D u32_replace_bits(val,
> +                                      phydev->duplex =3D=3D DUPLEX_FULL =
? 1 : 0,
> +                                      ENETC_PM_IFM_FULL_DPX_LS);
>
>         if (val =3D=3D old_val)
>                 return;
>
> --
> 2.34.1
>

Hi Alice,

It looks like this is required for i.MX94 and i.MX95 as well as
i.MX952 and should be split out if you end up making any other changes
to this series but otherwise:
Reviewed-by: Tim Harvey <tharvey@gateworks.com>

Best regards,

Tim
