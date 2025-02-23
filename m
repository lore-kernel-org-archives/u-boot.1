Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72E8C021B2
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 12:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45A3D80F67;
	Sun, 23 Feb 2025 13:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bintprel";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4E080F67; Sun, 23 Feb 2025 13:56:12 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AD27807A8
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 13:56:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4399ca9d338so20899315e9.3
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 04:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740315370; x=1740920170; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6MncH6Gqf8O4m0AgaQGfafepOO+H69xvwL93wAgKAE=;
 b=Bintprelr6stKgjF+ofwGdNz92xZlzxud8XFvWJw9WLRCBOCeTv1eelafJAN5l7qXD
 7qSmcm6vU5C7EJkRKCPvst2+ujvRqGomnbrWmOtLZ4h7whEDmbJXwfAOwNm25ZDyv+uA
 iKJQelJ9WIrC2eFf3QL6UaRMYwVHKJgZq3jC8/IqmhMW9wwpkNFyT/Lto2ARaFVyT+wo
 IFK8IT8Vu/tZXziT3jOWqIYhuC6UbSTHsNOSzDrieMBI/zeGYRMHXr++g8awss79hbXJ
 BEne5crCEIUvXlj3NFniPM1Y4Tp43MRKWooi44NLWKk7XB1OVTVmgu5tOg8ROhOkPcd9
 SdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740315370; x=1740920170;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H6MncH6Gqf8O4m0AgaQGfafepOO+H69xvwL93wAgKAE=;
 b=VrJfrGxjjzUAYMPVWDPH6q30Ycsx9y2QALCxtH4pDynK9/A93LmdDzztgXZ8OfG5Xi
 hAJ2HDWvnqgw8jWx/iypHl1rZdCo5hPz5PuS78FS+8BHAOd8UY0EGqYM2BRoYtiYQB/y
 Hcu6ARm6GI+7tuQC9yLjAfLk6pGC3+n3izbl6FdZT7waQ4UX3Wx1xE9DZVv4MemgedBs
 zs/NPIJDF7/Kv8Kkl08ZWAZfHAN6gh1YBAcWtmKnyfainMUoqchKlDgEjmvfQ0uQSSx6
 wV5OyvgKTkO4YSMv0tp9WGKPSQo2Gu2X+7ZNz8t+3l7m7w9WpuvcYoZQeklwIfZTLs6P
 cn2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdMPUXwrEnHoqjJ1SfkUVeIcx1I9RJqs1cbCtg+Qg9LbfJT8Yt22SEqB5oDASIXeSCIXyfrMw=@lists.denx.de
X-Gm-Message-State: AOJu0YxYard0KJ82N/ecYHSu+wZ40SjFj/XXwM4QDFys81XTQe/v520a
 VfC9m+NdQrwHZ1lQuVDv4BjbByazg7ie9X1FitigoTtf2tMSkxzu2cPfzREYm8f7M9jUPROB/2A
 JgJnrioX2M/8Wbep1AJ2kiLlwuk4=
X-Gm-Gg: ASbGncuGkPdg0oYXe150sTWW34xQ4AOOdykr9SsxUtdiSPAQZ22Bc7viB8ryaq7zrwR
 sxH1W6ZnOpUbp8kZ8t0sy8gOlcwCy+56hWab1cY/lbLSTX58Nt6D1dcJPnJuSyiKXYOJMdsk0r6
 1MLKC6rGTE
X-Google-Smtp-Source: AGHT+IGZnz3/62867ovPqO3tBtTlvEFnOG3A/gXyayjaMhcmxIVrMAe4Bq2lbKYtenAAHWhhCABATfEeWWrAau7hbf0=
X-Received: by 2002:a5d:5f87:0:b0:38f:3b9b:6f91 with SMTP id
 ffacd0b85a97d-38f6e958e35mr6682062f8f.12.1740315369510; Sun, 23 Feb 2025
 04:56:09 -0800 (PST)
MIME-Version: 1.0
References: <20250223-vop2-pt2-v2-0-71350e482970@riseup.net>
 <20250223-vop2-pt2-v2-7-71350e482970@riseup.net>
In-Reply-To: <20250223-vop2-pt2-v2-7-71350e482970@riseup.net>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 23 Feb 2025 14:55:58 +0200
X-Gm-Features: AWEUYZlbWANKX-uNVvZv_775Ejd6OT97sO_Rmcyg37ExFh3dq-0dlPjY1qVJ_Pk
Message-ID: <CAPVz0n2W7kPAenXcZy17Sm0W4=-mkjzANN2FyZGc+ZyYhEgWHg@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] video: rockchip: vop2: Add video bridge support
To: Dang Huynh <danct12@riseup.net>
Cc: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
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

=D0=BD=D0=B4, 23 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:14 Dang=
 Huynh <danct12@riseup.net> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Add support for video bridge to VOP2 so we can use the MIPI DSI
> bridge driver that we have.
>
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>  drivers/video/rockchip/rk_vop2.c | 81 +++++++++++++++++++++++++++++-----=
------
>  1 file changed, 59 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/video/rockchip/rk_vop2.c b/drivers/video/rockchip/rk=
_vop2.c
> index 14abe316f5b4aa814bbd46e410d319d1571debd2..ffb6144be54068033a92e2c3b=
39e9e4eb2f789c3 100644
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
> @@ -254,6 +256,7 @@ static int rk_display_init(struct udevice *dev, ulong=
 fbbase, ofnode vp_node)
>         int vop_id, port_id;
>         struct display_timing timing;
>         struct udevice *disp;
> +       struct udevice *bridge;
>         int ret;
>         u32 remote_phandle;
>         struct display_plat *disp_uc_plat;
> @@ -320,8 +323,11 @@ static int rk_display_init(struct udevice *dev, ulon=
g fbbase, ofnode vp_node)
>                         return -EINVAL;
>                 }
>
> +               if (IS_ENABLED(CONFIG_VIDEO_BRIDGE))
> +                       uclass_find_device_by_ofnode(UCLASS_VIDEO_BRIDGE,=
 remote, &bridge);
> +
>                 uclass_find_device_by_ofnode(UCLASS_DISPLAY, remote, &dis=
p);
> -               if (disp)
> +               if (disp || bridge)
>                         break;
>         };
>         compat =3D ofnode_get_property(remote, "compatible", NULL);
> @@ -360,27 +366,49 @@ static int rk_display_init(struct udevice *dev, ulo=
ng fbbase, ofnode vp_node)
>                 return ret;
>         }
>
> -       disp_uc_plat =3D dev_get_uclass_plat(disp);
> -       debug("Found device '%s', disp_uc_priv=3D%p\n", disp->name, disp_=
uc_plat);
> -       if (display_in_use(disp)) {
> -               debug("   - device in use\n");
> -               return -EBUSY;
> -       }
> +       if (bridge) {
> +               /* video bridge detected, probe it */
> +               ret =3D device_probe(bridge);
> +               if (ret) {
> +                       dev_err(dev, "Failed to probe video bridge: %d\n"=
, ret);
> +                       return ret;
> +               }
>
> -       disp_uc_plat->source_id =3D vop_id;
> -       disp_uc_plat->src_dev =3D dev;
> +               /* Attach the DSI controller and the display to the bridg=
e. */
> +               ret =3D video_bridge_attach(bridge);
> +               if (ret) {
> +                       dev_err(dev, "Failed to attach video bridge: %d\n=
", ret);
> +                       return ret;
> +               }
>
> -       ret =3D device_probe(disp);
> -       if (ret) {
> -               debug("%s: device '%s' display won't probe (ret=3D%d)\n",
> -                     __func__, dev->name, ret);
> -               return ret;
> -       }
> +               ret =3D video_bridge_get_display_timing(bridge, &timing);
> +               if (ret) {
> +                       dev_err(dev, "Failed to read timings: %d\n", ret)=
;
> +                       return ret;
> +               }
> +       } else {
> +               disp_uc_plat =3D dev_get_uclass_plat(disp);
> +               debug("Found device '%s', disp_uc_priv=3D%p\n", disp->nam=
e, disp_uc_plat);
> +               if (display_in_use(disp)) {
> +                       debug("   - device in use\n");
> +                       return -EBUSY;
> +               }
>
> -       ret =3D display_read_timing(disp, &timing);
> -       if (ret) {
> -               debug("%s: Failed to read timings\n", __func__);
> -               return ret;
> +               disp_uc_plat->source_id =3D vop_id;
> +               disp_uc_plat->src_dev =3D dev;
> +
> +               ret =3D device_probe(disp);
> +               if (ret) {
> +                       debug("%s: device '%s' display won't probe (ret=
=3D%d)\n",
> +                             __func__, dev->name, ret);
> +                       return ret;
> +               }
> +
> +               ret =3D display_read_timing(disp, &timing);
> +               if (ret) {
> +                       debug("%s: Failed to read timings\n", __func__);
> +                       return ret;
> +               }
>         }
>
>         /* Set clock rate on video port to display timings */
> @@ -410,9 +438,18 @@ static int rk_display_init(struct udevice *dev, ulon=
g fbbase, ofnode vp_node)
>
>         rkvop_mode_set(dev, &timing, vop_id, port_id, platdata);
>
> -       ret =3D display_enable(disp, 1 << l2bpp, &timing);
> -       if (ret)
> -               return ret;
> +       if (bridge) {
> +               /* Attach the DSI controller and the display to the bridg=
e. */
> +               ret =3D video_bridge_set_backlight(bridge, 60);
> +               if (ret) {
> +                       dev_err(dev, "Failed to start the video bridge: %=
d\n", ret);
> +                       return ret;
> +               }
> +       } else {
> +               ret =3D display_enable(disp, 1 << l2bpp, &timing);
> +               if (ret)
> +                       return ret;
> +       }
>
>         uc_priv->xsize =3D timing.hactive.typ;
>         uc_priv->ysize =3D timing.vactive.typ;
>
> --
> 2.48.1
>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
