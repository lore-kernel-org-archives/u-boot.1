Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123CCC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 21:40:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9615688489;
	Wed, 22 May 2024 23:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nWtbVTU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D215884B6; Wed, 22 May 2024 23:40:33 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 439F788464
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 23:40:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-481398a7381so467731137.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 14:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716414030; x=1717018830; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3VtLA35ytLSteel0Nfbs3l4nvuBUVouE/q5dgpX1ypg=;
 b=nWtbVTU9AmOEp2RbnvKSCMn5g+zoM3tp01rhJPKGv9/SaJW1IR8EyY3ZI+IGPWu8EF
 LzsnqiX+HuoPKpqkS7gzS/pypkrQ+bw01gs9y+y/XYJygjG5S9W5G7Zk9zg9MvULkl3U
 urNIK08o9dgVpX8fe6cV4Hcc3CJQ0w/ddEBVR8Epn26XO+bA3ekOil2sCop3eUv8U106
 iUzOlWujLglDS6ZnLVJUJNFBImVdg1oSxDpQPRVb4oBQLlXCY7PZJv1Mc6XCMTdOMZyd
 uPB0yqXOwjBXL20ZHT35k+PnW6XnNEPBKPv3jJrH+qZZGXMMVTbnd9VQOmj8VbiRmv2e
 XLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716414030; x=1717018830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3VtLA35ytLSteel0Nfbs3l4nvuBUVouE/q5dgpX1ypg=;
 b=IoIyvZoVkFD8fab+U8ALiaexiHZ5HX/2WffKb2SahPDgOMwtp6kTkfdeOw5brm9h2Y
 mOuSLs2knRSxqjxwSJRQOHJPoYF+wC9U89L9Na8HEWbP18M3eooJLN9S78dN2pDqKrWf
 Iz+l3ZWD3s7TerwZqgzUW9S+t62wzOfpgDMCBISWxeyq+rJSd7jK8zINP3GfNY8J1Hb3
 QiWVaEJhF4b+ifc6nijrj6YLz/RJxzlWLV1aJBH1tcQl/iJ2gr5116Bn8ov/0RozkeIC
 p7mMdiJvj+LVFYCk0XGGDjFKHNAP9Bi5JkB/apejXYq6CXZ0M+0rWd1eaSZyqBlJmPf4
 akZA==
X-Gm-Message-State: AOJu0Yzgz5j9QfvDJN1ofFkKejWlgUIH2x3fZpLQVntARkDO8+widrub
 mksHU0SeRHxpBcSqE+nh90HNJmd7b+m4aa/Yd9YynLYpCmfQb9CJ/VumIgPS8iJ0bUghT8hiyFk
 j+EoNbSgsdomkZ3M67iruOxWSwqU=
X-Google-Smtp-Source: AGHT+IF5eWVic9oN6KxTpXggwlZzsEH+pGqkXCgi3RHyJQQsVROZj31QcqCndHAzMRea7F62Bsfm35IpHCO5tiwEXVQ=
X-Received: by 2002:a05:6102:f14:b0:47e:d89:6ae1 with SMTP id
 ada2fe7eead31-48900909ce4mr2917135137.12.1716414030040; Wed, 22 May 2024
 14:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <dcEaD5-kc_SzXGz7v_bxIV4C3Rqg0b0x2bWGjCclG5pS_sL_tWoxtWu7VQqu_2SOx0LN3h9bHcaqsa_l-PiOQAMkZpiJ9G4SQta-kfPDuJw=@protonmail.com>
In-Reply-To: <dcEaD5-kc_SzXGz7v_bxIV4C3Rqg0b0x2bWGjCclG5pS_sL_tWoxtWu7VQqu_2SOx0LN3h9bHcaqsa_l-PiOQAMkZpiJ9G4SQta-kfPDuJw=@protonmail.com>
From: E Shattow <lucent@gmail.com>
Date: Wed, 22 May 2024 14:40:17 -0700
Message-ID: <CANV2PTOBdVQfaecSRVhtXM76daDVdB142SbG03bZ1rrSPKTvpA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v5] board: starfive: support Pine64 Star64 board
To: H Bell <dmoo_dv@protonmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Wed, May 22, 2024 at 12:13=E2=80=AFPM H Bell <dmoo_dv@protonmail.com> wr=
ote:
>
> Similar to the Milk-V Mars, The Star64 board contains few differences to =
the
> VisionFive 2 boards, so can be part of the same U-boot build.
>
> Signed-off-by: Henry Bell <dmoo_dv@protonmail.com>
> Cc: ycliang@andestech.com
> Cc: heinrich.schuchardt@canonical.com
> ---
>
> Changes since v1
>
> - Fix typos on naming
> - Create pine64_star64 struct to be populated with PHY values once confir=
med
>
> Changes since v2
>
> - Set delays to 0
> - Add missing 10/100/1000 clocks across the two devices
> - Set all uA values to 2910
>
> Changes since v3
>
> - Rebase against d678a59d2d
>
> Changes since v4
>
> - Fix up delay values
> ---
>  board/starfive/visionfive2/spl.c              | 89 +++++++++++++++++++
>  .../visionfive2/starfive_visionfive2.c        |  4 +
>  2 files changed, 93 insertions(+)
>
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive=
2/spl.c
> index b555189556..b794b73b6b 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -86,6 +86,43 @@ static const struct starfive_vf2_pro starfive_verb[] =
=3D {
>                 "tx-internal-delay-ps", "0"},
>  };
>
> +static const struct starfive_vf2_pro star64_pine64[] =3D {
> +       {"/soc/ethernet@16030000", "starfive,tx-use-rgmii-clk", NULL},
> +       {"/soc/ethernet@16040000", "starfive,tx-use-rgmii-clk", NULL},
> +
> +       {"/soc/ethernet@16030000/mdio/ethernet-phy@0",
> +               "motorcomm,tx-clk-adj-enabled", NULL},
> +       {"/soc/ethernet@16030000/mdio/ethernet-phy@0",
> +               "motorcomm,tx-clk-10-inverted", NULL},
> +       {"/soc/ethernet@16030000/mdio/ethernet-phy@0",
> +               "motorcomm,tx-clk-100-inverted", NULL},
> +       {"/soc/ethernet@16030000/mdio/ethernet-phy@0",
> +               "motorcomm,tx-clk-1000-inverted", NULL},
> +       {"/soc/ethernet@16030000/mdio/ethernet-phy@0",
> +               "motorcomm,rx-clk-drv-microamp", "2910"},
> +       {"/soc/ethernet@16030000/mdio/ethernet-phy@0",
> +               "motorcomm,rx-data-drv-microamp", "2910"},
> +       {"/soc/ethernet@16030000/mdio/ethernet-phy@0",
> +               "rx-internal-delay-ps", "1900"},
> +       {"/soc/ethernet@16030000/mdio/ethernet-phy@0",
> +               "tx-internal-delay-ps", "1500"},
> +
> +       {"/soc/ethernet@16040000/mdio/ethernet-phy@1",
> +               "motorcomm,tx-clk-adj-enabled", NULL},
> +       {"/soc/ethernet@16040000/mdio/ethernet-phy@1",
> +               "motorcomm,tx-clk-10-inverted", NULL},
> +       {"/soc/ethernet@16040000/mdio/ethernet-phy@1",
> +               "motorcomm,tx-clk-100-inverted", NULL},
> +       {"/soc/ethernet@16040000/mdio/ethernet-phy@1",
> +               "motorcomm,rx-clk-drv-microamp", "2910"},
> +       {"/soc/ethernet@16040000/mdio/ethernet-phy@1",
> +               "motorcomm,rx-data-drv-microamp", "2910"},
> +       {"/soc/ethernet@16040000/mdio/ethernet-phy@1",
> +               "rx-internal-delay-ps", "0"},

> +       {"/soc/ethernet@16040000/mdio/ethernet-phy@1",
> +               "tx-internal-delay-ps", "300"},

Note this 300uS value for tx-internal-delay-ps differs from
pre-loaded firmware on Star64:
 ethernet-phy@1 tx_delay_sel =3D <0x00>;

I would prefer to this (even if it is wrong) same as the pre-loaded
firmware has done. Tuning patches can be applied in some
future series. Is there a noticeable difference in function to change
this value from how the pre-loaded firmware does this?

> +};
> +
>  void spl_fdt_fixup_mars(void *fdt)
>  {
>         static const char compat[] =3D "milkv,mars\0starfive,jh7110";
> @@ -250,6 +287,56 @@ void spl_fdt_fixup_version_b(void *fdt)
>         }
>  }
>
> +void spl_fdt_fixup_star64(void *fdt)
> +{
> +       static const char compat[] =3D "pine64,star64\0starfive,jh7110";
> +       u32 phandle;
> +       u8 i;
> +       int offset;
> +       int ret;
> +
> +       fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat,=
 sizeof(compat));
> +       fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
> +                          "Pine64 Star64");
> +
> +       /* gmac0 */
> +       offset =3D fdt_path_offset(fdt, "/soc/clock-controller@17000000")=
;
> +       phandle =3D fdt_get_phandle(fdt, offset);
> +       offset =3D fdt_path_offset(fdt, "/soc/ethernet@16030000");
> +
> +       fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
> +       fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_AONCLK_=
GMAC0_TX);
> +       fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
> +       fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
> +                          JH7110_AONCLK_GMAC0_RMII_RTX);
> +
> +       /* gmac1 */
> +       offset =3D fdt_path_offset(fdt, "/soc/clock-controller@13020000")=
;
> +       phandle =3D fdt_get_phandle(fdt, offset);
> +       offset =3D fdt_path_offset(fdt, "/soc/ethernet@16040000");
> +
> +       fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
> +       fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_SYSCLK_=
GMAC1_TX);
> +       fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
> +       fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
> +                          JH7110_SYSCLK_GMAC1_RMII_RTX);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(star64_pine64); i++) {
> +               offset =3D fdt_path_offset(fdt, star64_pine64[i].path);
> +
> +               if (star64_pine64[i].value)
> +                       ret =3D fdt_setprop_u32(fdt, offset,  star64_pine=
64[i].name,
> +                                             dectoul(star64_pine64[i].va=
lue, NULL));
> +               else
> +                       ret =3D fdt_setprop_empty(fdt, offset, star64_pin=
e64[i].name);
> +
> +               if (ret) {
> +                       pr_err("%s set prop %s fail.\n", __func__, star64=
_pine64[i].name);
> +                               break;
> +               }
> +       }
> +}
> +
>  void spl_perform_fixups(struct spl_image_info *spl_image)
>  {
>         u8 version;
> @@ -278,6 +365,8 @@ void spl_perform_fixups(struct spl_image_info *spl_im=
age)
>                         spl_fdt_fixup_version_b(spl_image->fdt_addr);
>                 break;
>                 };
> +       } else if (!strncmp(product_id, "STAR64", 6)) {
> +               spl_fdt_fixup_star64(spl_image->fdt_addr);
>         } else {
>                 pr_err("Unknown product %s\n", product_id);
>         };
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/st=
arfive/visionfive2/starfive_visionfive2.c
> index 6be5348962..f6114602f8 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -27,6 +27,8 @@ DECLARE_GLOBAL_DATA_PTR;
>         "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
>  #define FDTFILE_VISIONFIVE2_1_3B \
>         "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
> +#define FDTFILE_PINE64_STAR64 \
> +       "starfive/jh7110-pine64-star64.dtb"
>
>  /* enable U74-mc hart1~hart4 prefetcher */
>  static void enable_prefetcher(void)
> @@ -87,6 +89,8 @@ static void set_fdtfile(void)
>                         fdtfile =3D FDTFILE_VISIONFIVE2_1_3B;
>                         break;
>                 }
> +       } else if (!strncmp(product_id, "STAR64", 6)) {
> +               fdtfile =3D FDTFILE_PINE64_STAR64;
>         } else {
>                 log_err("Unknown product\n");
>                 return;
> --
> 2.44.0
>
>

With that note about phy1 tx-internal-delay-ps (I have no Star64 to test my=
self)

Reviewed-by: E Shattow <lucent@gmail.com>
