Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8B5EB7ED7
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 12:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 778D2838BB;
	Wed,  4 Mar 2026 13:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dizC6sgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D99839A8; Wed,  4 Mar 2026 13:29:42 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A54F83642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 13:29:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-660d2e48383so1923647a12.1
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 04:29:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772627380; cv=none;
 d=google.com; s=arc-20240605;
 b=RyR/6gqSH/YkjgvW0vPDsKhsFMVjfKlmi1mJ6zL4pvHr8Y2dJVMU1PfovBfCp2s43O
 vqEXsAox0ZnuztiU/Nc6sdt2CnyhyaF9ND6C3TUqth92vzEbu+eKQIOtm3ZhokAjAit6
 pJRgLdpJJwTKSeoNfINvsXIbEnRrz62z0+/gSPQIGebr7Sd+OhmTboYM6/ptLlaAmdJF
 EO5lOAwAX+ofMb+Xh4Qt0iIH7EKUNZuQ52FFzmlaU9k+g5DMRYHkWsSdBNYRzxSrT/0n
 Ozrb2gf6+jldNfNyAH9T7cZLJvneP9u6hqyCOSmZF2HsT+txHBN5qZ6BTmr3YDKmyOmN
 SVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=G4MQESiPC/PXsnj0l6xHngILWkCiFJP4K0GxK4yfV9w=;
 fh=SRwQtMjPzvIYQNZe9O0twcj57Zv+WcIStWaW8fLsCfs=;
 b=bBxASKy8BZKux+En16UL8BX2BRF2F4k138lbkjVPzDOedgs52Jp+AdMKKCwWgaVmfu
 V5qiHaS3viLlFJjuXre6F/pzy40+1s0LRgxcTictdn2jzqKIh9e6xOsoUjWkJ8zBV7Ac
 6Z3Jzo7Nh828xKE+MW8G1A8NTwF3vCM4+1vPsx2mMjOPxyNT8VANp0HpGCPf3QpjY2bz
 FiDSkZsLM85rUzuGe6NoOGm8U77wTTL6sN7anIE6qJGTPRuTDhcXd24kWNGVvHN/X35T
 CgeuNovGr7TPBLmkwBtsq1+HuloKZWXmofY+jWTDF2ns1SDl1tG76otdEOATEcExfFe2
 7hwQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772627380; x=1773232180; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G4MQESiPC/PXsnj0l6xHngILWkCiFJP4K0GxK4yfV9w=;
 b=dizC6sgPtd8kN/4WW3Y7BebMocnKaFRmPYTjOtN+TWGN0R5qvmFi52XFDZdqhGZIkG
 Y+eBxitjOtWYCCAoWOCbC5IuxlLXSXSUu4i4ifCfUhKvcjrrcxX1PN5FxSmZ60KiSVXo
 0Gug+/SRzLhqrzQdTr7/t3Iroihvit6gu9ioDsfwlbt6cTRuSRO6g3LA44r6hlDlfLFt
 ZvlGOVQdnO4EKjs0RP/xwJ/fLvem/aV3QmOOkUwZ5Tgf0Lp0ErcKMMF+V9VhL0bVXpeq
 ncH8+rU8cAEjlwixGoHgDy0NeGDZ8DVRrmjPi484FuLJaOWgNJNfae5PYvtrwFvWcJsa
 71Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772627380; x=1773232180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4MQESiPC/PXsnj0l6xHngILWkCiFJP4K0GxK4yfV9w=;
 b=Hn/fuFWOdmqcB58oNRZFBFutGUoWgHAgkiJhbaXLn9yTPKJkqaMKcs/wTwq9rOBQnZ
 nedpzcwBs5+Ui2Q9yhOp2eBDl/yQGYHszUfeJu/6FbCZQJzxLxtUK14EH75NMt3Vv+kz
 G48aH1KvrfvxSiXV1ZyyEuH0szG6ROHnUB/Vx2YJI7aapqdpc+mgi3iZASAGTAAzR6ai
 Xs45Eye37F4X2eSI3Yspa/22fwf9aiSp28DTohlnCRYQPVmRcsQSB36cOR7kX4V9YS2g
 k0vto/cK4wWfju/l1rHp7OJ1YG0SE57oCP153dtgmmOuJUz5p3NA3+Q5kBeO+FMhvZu1
 2p9g==
X-Gm-Message-State: AOJu0YxrY8No+5qrmWAjVULbi7g5nzMCEdsMxAJdoBVFnzAPC0g0+lz1
 gGv75IoYSU5i7MaoWj5h0zLQbasaenvlzNm5i6+j38VdKDHGdQFrvaVM5V3nqRB/QNAzzHJTz4U
 fdXSV+c1vtFBFqU1PUUdYN0zgTUyCfx0=
X-Gm-Gg: ATEYQzy38gpyTj6D75Lr/vscxfn1mzu11yFjgVq3BGGpap15AcdsgZD3raF2Q0orgwU
 Y1XiLTbCuM7Fbooz0m3W7GMyxTwFaylN5jsp3BIa5A17S1pFt3HhWQSL5Bxm/Zulpnlz1P5ED+x
 tPs9KoQ9qVxLAOT+RtnrQucjTnP16upIgR7Vd+5nwygelwhH1TeT6alli6xKBtR2jELak0vJvDN
 rozhfvT9EcVJbf79z/NhyM/+GUHETnt087mPhp+WGxvAKawMst3vH5dctV2OMpqGDuoOrbF1ZGw
 BuTHGz+dtnGYeQKEs2VtEOb8uimmfabuLlAkgW9Sy0STAOUe3fq5otqUhKoK/BbRTre/3LXS4qf
 uTsHctHSoOqr6Y8dTdeB84yDC1prHaGmUvkkR6TB/haDAxl/EWTxRnfjeJEU=
X-Received: by 2002:a05:6402:2809:b0:65c:5a7b:bd99 with SMTP id
 4fb4d7f45d1cf-660f00d67fdmr1051166a12.31.1772627379262; Wed, 04 Mar 2026
 04:29:39 -0800 (PST)
MIME-Version: 1.0
References: <20251108-vop2-pt2-v6-0-d04c699262fb@mainlining.org>
 <20251108-vop2-pt2-v6-7-d04c699262fb@mainlining.org>
In-Reply-To: <20251108-vop2-pt2-v6-7-d04c699262fb@mainlining.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 4 Mar 2026 12:29:27 +0000
X-Gm-Features: AaiRm51LfXVlgph0yoYZ_9tBhd5jursp2zcZZEwfnX6WT671YRIugbq62D27roc
Message-ID: <CALeDE9OTnFa4gs1XnGsdN2X0Db2aYAsSLafr8pYf+MQuRSpuXQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/12] video: rockchip: vop2: Add video bridge support
To: dang.huynh@mainlining.org
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Ondrej Jirman <megi@xff.cz>,
 Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dragan Simic <dsimic@manjaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonas Karlman <jonas@kwiboo.se>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Piotr Zalewski <pZ010001011111@proton.me>
Content-Type: text/plain; charset="UTF-8"
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

Hey Dang,

Finally started to play with this patch set.

> From: Dang Huynh <dang.huynh@mainlining.org>
>
> Add support for video bridge to VOP2 so we can use the MIPI DSI
> bridge driver that we have.

I see a link failure when using this patch set with the
anbernic-rgxx3-rk3566_defconfig using 2026.04-rc3.

/usr/bin/ld.bfd: drivers/video/rockchip/rk_vop2.o: in function
`rk_display_init':
/builddir/build/BUILD/uboot-tools-2026.04-build/u-boot-2026.04-rc3/drivers/video/rockchip/rk_vop2.c:422:(.text.rk_vop2_probe+0x360):
undefined reference to `display_in_use'
/usr/bin/ld.bfd:
/builddir/build/BUILD/uboot-tools-2026.04-build/u-boot-2026.04-rc3/drivers/video/rockchip/rk_vop2.c:437:(.text.rk_vop2_probe+0x388):
undefined reference to `display_read_timing'
/usr/bin/ld.bfd:
/builddir/build/BUILD/uboot-tools-2026.04-build/u-boot-2026.04-rc3/drivers/video/rockchip/rk_vop2.c:492:(.text.rk_vop2_probe+0x794):
undefined reference to `display_enable'

Cheers,
Peter


> Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> ---
>  drivers/video/rockchip/rk_vop2.c | 81 +++++++++++++++++++++++++++++-----------
>  1 file changed, 59 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/video/rockchip/rk_vop2.c b/drivers/video/rockchip/rk_vop2.c
> index 992f215d416..156daafa0c3 100644
> --- a/drivers/video/rockchip/rk_vop2.c
> +++ b/drivers/video/rockchip/rk_vop2.c
> @@ -13,10 +13,12 @@
>  #include <dm/device_compat.h>
>  #include <edid.h>
>  #include <log.h>
> +#include <panel.h>
>  #include <regmap.h>
>  #include <reset.h>
>  #include <syscon.h>
>  #include <video.h>
> +#include <video_bridge.h>
>  #include <asm/global_data.h>
>  #include <asm/gpio.h>
>  #include <asm/io.h>
> @@ -291,6 +293,7 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode vp_node)
>         int vop_id, port_id, win_id;
>         struct display_timing timing;
>         struct udevice *disp;
> +       struct udevice *bridge;
>         int ret;
>         u32 remote_phandle;
>         struct display_plat *disp_uc_plat;
> @@ -357,8 +360,11 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode vp_node)
>                         return -EINVAL;
>                 }
>
> +               if (IS_ENABLED(CONFIG_VIDEO_BRIDGE))
> +                       uclass_find_device_by_ofnode(UCLASS_VIDEO_BRIDGE, remote, &bridge);
> +
>                 uclass_find_device_by_ofnode(UCLASS_DISPLAY, remote, &disp);
> -               if (disp)
> +               if (disp || bridge)
>                         break;
>         };
>         compat = ofnode_get_property(remote, "compatible", NULL);
> @@ -390,27 +396,49 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode vp_node)
>         if (ret < 0)
>                 return ret;
>
> -       disp_uc_plat = dev_get_uclass_plat(disp);
> -       debug("Found device '%s', disp_uc_priv=%p\n", disp->name, disp_uc_plat);
> -       if (display_in_use(disp)) {
> -               debug("   - device in use\n");
> -               return -EBUSY;
> -       }
> +       if (bridge) {
> +               /* video bridge detected, probe it */
> +               ret = device_probe(bridge);
> +               if (ret) {
> +                       dev_err(dev, "Failed to probe video bridge: %d\n", ret);
> +                       return ret;
> +               }
>
> -       disp_uc_plat->source_id = vop_id;
> -       disp_uc_plat->src_dev = dev;
> +               /* Attach the DSI controller and the display to the bridge. */
> +               ret = video_bridge_attach(bridge);
> +               if (ret) {
> +                       dev_err(dev, "Failed to attach video bridge: %d\n", ret);
> +                       return ret;
> +               }
>
> -       ret = device_probe(disp);
> -       if (ret) {
> -               debug("%s: device '%s' display won't probe (ret=%d)\n",
> -                     __func__, dev->name, ret);
> -               return ret;
> -       }
> +               ret = video_bridge_get_display_timing(bridge, &timing);
> +               if (ret) {
> +                       dev_err(dev, "Failed to read timings: %d\n", ret);
> +                       return ret;
> +               }
> +       } else {
> +               disp_uc_plat = dev_get_uclass_plat(disp);
> +               debug("Found device '%s', disp_uc_priv=%p\n", disp->name, disp_uc_plat);
> +               if (display_in_use(disp)) {
> +                       debug("   - device in use\n");
> +                       return -EBUSY;
> +               }
>
> -       ret = display_read_timing(disp, &timing);
> -       if (ret) {
> -               debug("%s: Failed to read timings\n", __func__);
> -               return ret;
> +               disp_uc_plat->source_id = vop_id;
> +               disp_uc_plat->src_dev = dev;
> +
> +               ret = device_probe(disp);
> +               if (ret) {
> +                       debug("%s: device '%s' display won't probe (ret=%d)\n",
> +                             __func__, dev->name, ret);
> +                       return ret;
> +               }
> +
> +               ret = display_read_timing(disp, &timing);
> +               if (ret) {
> +                       debug("%s: Failed to read timings\n", __func__);
> +                       return ret;
> +               }
>         }
>
>         /* Set clock rate on video port to display timings */
> @@ -453,9 +481,18 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode vp_node)
>
>         rkvop2_mode_set(dev, &timing, vop_id, port_id, platdata);
>
> -       ret = display_enable(disp, 1 << l2bpp, &timing);
> -       if (ret)
> -               return ret;
> +       if (bridge) {
> +               /* Attach the DSI controller and the display to the bridge. */
> +               ret = video_bridge_set_backlight(bridge, 60);
> +               if (ret) {
> +                       dev_err(dev, "Failed to start the video bridge: %d\n", ret);
> +                       return ret;
> +               }
> +       } else {
> +               ret = display_enable(disp, 1 << l2bpp, &timing);
> +               if (ret)
> +                       return ret;
> +       }
>
>         uc_priv->xsize = timing.hactive.typ;
>         uc_priv->ysize = timing.vactive.typ;
>
> --
> 2.51.2
>
>
