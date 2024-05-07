Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7355AC25B10
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 00:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AF3487D43;
	Tue,  7 May 2024 02:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bWNlcFRo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A792387EDC; Tue,  7 May 2024 02:31:48 +0200 (CEST)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CACA487D40
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 02:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7ebe09eb289so910413241.2
 for <u-boot@lists.denx.de>; Mon, 06 May 2024 17:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715041904; x=1715646704; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81/rm/uB2sIQFT5ay/MCUl95B7wiy16MHxgf/f6jVXM=;
 b=bWNlcFRouolC7qsNXAbTrdXiP3FCDcAjX81sSbKEpH168vspN6wZcgUsWYoqvR+/07
 DeoAJJI3AoS5WUofKp0KH2v77tbSlbh8VU2NzZcLmzh4zJWZkvz9fX2dgHQczdvM/m/t
 9aKuBnGkaQRbyyCcUXN/L61Cdfb4kLAXygWsgCDfoXgbUf7TVVsNsodxldpWyuK5yEo4
 EKNNPoZgqUFVX80JTKV3MoNewk8dvKcVDQWWpqj/H4xABIiFyOQQ3t3waHI77Z4yDbfX
 l05iO+gnePd5mxdhYFdk5HUb52nDkcu6k06/fUrjsLywDhJ6XO2HavQmgLdYkkeG2Cvl
 ORGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715041904; x=1715646704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81/rm/uB2sIQFT5ay/MCUl95B7wiy16MHxgf/f6jVXM=;
 b=GGeemaZg6Ydjh0TrSwSSGXVmiUuymrLIL/79VS+mC7yQuQe2J9zqUVV6qlCkLtT6JD
 BcAzbhJp2MFXt+w/mzzfx0g03/QyExT9shSnZOp0wPa/SGNyN65MIpiTQausOgwb7lCP
 FMZ08jN+s0dXFt+L8wUAdKNYLGv9ryHked6ycBDRcpDHkBBcTxWvfIrdqyeomnEpaCdS
 hANhiyA//mNkoh5l0WMnLzzBII9C02LXyMyJCGLBx9hlt+HwiIIkRENiBua7dbxTs91X
 VuhYhQiwHgOMKIsIuy6C9qBwIBH8bAtZ5muGa5nHwQiU72nS7P/veSlYrSYRYjVxEvUE
 IZJw==
X-Gm-Message-State: AOJu0YxraTcTCCma9gnYSeEKHuykoixfYyQ1+1YmXisjFDaLhnKepySy
 jVYrWkLWSoMA4HLcdZBIYZUHq8oTBsuPWrvQmla/BnpP6+viBrxt8BFOWq65ImUQLQMCxYgbF/m
 xWcE4W0S7/NnUpS9Q9crOCRFflg0=
X-Google-Smtp-Source: AGHT+IEvKyZFfdaSujh50zBss4OdTCR8r0x56lLDMeecUArviG85KxtZP+nZmsCq61b08WinIWZTp1bzHx9YYMpwgmo=
X-Received: by 2002:a67:ead1:0:b0:47e:f1f1:d052 with SMTP id
 s17-20020a67ead1000000b0047ef1f1d052mr13558124vso.33.1715041904480; Mon, 06
 May 2024 17:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <9UKxZxvyW2p7WWu5KwPIVoiFveSPOTEAzCVemUccLIb70r8QO7ch2PAiwVf428TC-7K9HDSO26ShohI0gnI4C671Plwa0M1CuwclJt3xJEc=@protonmail.com>
In-Reply-To: <9UKxZxvyW2p7WWu5KwPIVoiFveSPOTEAzCVemUccLIb70r8QO7ch2PAiwVf428TC-7K9HDSO26ShohI0gnI4C671Plwa0M1CuwclJt3xJEc=@protonmail.com>
From: E Shattow <lucent@gmail.com>
Date: Mon, 6 May 2024 17:31:32 -0700
Message-ID: <CANV2PTPkebMS76obVPZ2e9vw+pgXhWbNAC5SGb1yLkiyByBU4A@mail.gmail.com>
Subject: Re: [PATCH] board: starfive: support Pine64 Star64 board
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

Hi,

On Mon, May 6, 2024 at 8:30=E2=80=AFAM H Bell <dmoo_dv@protonmail.com> wrot=
e:
>
> Similar to the Milk-V Mars, The Star64 board contains few differences to =
the
> VisionFive 2 boards, so can be part of the same U-boot build.
>
> Signed-off-by: Henry Bell <dmoo_dv@protonmail.com>
> Cc: ycliang@andestech.com
> Cc: heinrich.schuchardt@canonical.com
> ---
>  board/starfive/visionfive2/spl.c              | 52 +++++++++++++++++++
>  .../visionfive2/starfive_visionfive2.c        |  4 ++
>  2 files changed, 56 insertions(+)
>
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive=
2/spl.c
> index ca61b5be22..b8d29a02af 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -226,6 +226,56 @@ void spl_fdt_fixup_version_b(void *fdt)
>         }
>  }
>
> +void spl_fdt_fixup_star64(void *fdt)
> +{
> +       static const char compat[] =3D "starfive,star64\0starfive,jh7110"=
;

Should be "pine64,star64\nstarfive,jh7110" ?

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
> +       for (i =3D 0; i < ARRAY_SIZE(starfive_verb); i++) {
> +               offset =3D fdt_path_offset(fdt, starfive_verb[i].path);
> +
> +               if (starfive_verb[i].value)
> +                       ret =3D fdt_setprop_u32(fdt, offset,  starfive_ve=
rb[i].name,
> +                                             dectoul(starfive_verb[i].va=
lue, NULL));

Using the fishwaldo repo Star64_devel branch Linux sources as my reference
https://github.com/Fishwaldo/Star64_linux
the drive strength is 3600 and looking at StarFive repo:
https://github.com/starfive-tech/u-boot/blob/223ac8b1e907924d3891b3be1b2f66=
20b56bff31/arch/riscv/dts/starfive_visionfive2.dts#L323
from "rgmii_sw_dr_rxc =3D <0x6>;" (7th enum is 3600).  However the dev
dts still refers to 0x7 ( i.e. " motorcomm,rx-clk-drv-microamp =3D
<3970>;")
https://github.com/starfive-tech/u-boot/blob/223ac8b1e907924d3891b3be1b2f66=
20b56bff31/arch/riscv/dts/starfive_devkits.dts#L289

Also the delay inverts differ somewhat. Marked-up
arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dtsi from the above
repo:

&gmac0 {
        status =3D "okay";
        #address-cells =3D <1>;
        #size-cells =3D <0>;
        phy0: ethernet-phy@0 {
                rgmii_sw_dr_2 =3D <0x0>;   switch drive 1.8V operation
                rgmii_sw_dr =3D <0x3>;     switch drive 4th enum is 2910
                rgmii_sw_dr_rxc =3D <0x6>; switch clock drive rx current
7th enum is 3600
                rxc_dly_en =3D <0>;           0 (disabled) 1900ps rxc
clock additional delay added to configured rx delay (default is
disabled).  Default tx/rx delay value is 1950ps.
                rx_delay_sel =3D <0xa>;    1500 at 1000Mbps
                tx_delay_sel_fe =3D <5>;    750 at 10/100Mbps
                tx_delay_sel =3D <0xa>;    1500 at 1000Mbps
                tx_inverted_10 =3D <0x1>;   true motorcomm,tx-clk-10-invert=
ed
                tx_inverted_100 =3D <0x1>;  true motorcomm,tx-clk-100-inver=
ted
                tx_inverted_1000 =3D <0x1>; true motorcomm,tx-clk-1000-inve=
rted
        };
};

&gmac1 {
        #address-cells =3D <1>;
        #size-cells =3D <0>;
        status =3D "okay";
        phy1: ethernet-phy@1 {
                rgmii_sw_dr_2 =3D <0x0>;    switch drive 2 1.8V operation
                rgmii_sw_dr =3D <0x3>;      switch drive 4th enum is 2910
                rgmii_sw_dr_rxc =3D <0x6>;  switch clock drive rx
current 7th enum is 3600
                rxc_dly_en =3D <0>;          0 (disabled) 1900ps rxc
clock additional delay added to configured rx delay (default is
disabled).  Default tx/rx delay value is 1950ps.
                rx_delay_sel =3D <0x2>;    300 at 1000Mbps
                tx_delay_sel_fe =3D <5>;   750 at 10/100Mbps
                tx_delay_sel =3D <0>;        0 at 1000Mbps
                tx_inverted_10 =3D <0x1>;  motorcomm,tx-clk-10-inverted
                tx_inverted_100 =3D <0x1>; motorcomm,tx-clk-100-inverted
                tx_inverted_1000 =3D <0x0>;  false (omit
motorcomm,tx-clk-1000-inverted)
        };
};

New property names are not made clear to me how to choose these
different delays for 10/100 Mbps vs 1000 Mbps operation. If the
fishwaldo repo is a valid reference then it seems different than the
content in starfive_vf2_pro starfive_verb[]. No Star64 here to test
with, does this work as-is for both network interfaces?

> +               else
> +                       ret =3D fdt_setprop_empty(fdt, offset, starfive_v=
erb[i].name);
> +
> +               if (ret) {
> +                       pr_err("%s set prop %s fail.\n", __func__, starfi=
ve_verb[i].name);
> +                               break;
> +               }
> +       }
> +}
> +
>  void spl_perform_fixups(struct spl_image_info *spl_image)
>  {
>         u8 version;
> @@ -252,6 +302,8 @@ void spl_perform_fixups(struct spl_image_info *spl_im=
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
> index a86bca533b..93bc8b5c55 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -23,6 +23,8 @@ DECLARE_GLOBAL_DATA_PTR;
>         "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
>  #define FDTFILE_VISIONFIVE2_1_3B \
>         "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
> +#define FDTFILE_PINE64_STAR64 \
> +       "starfive/pine64-star64.dtb"

Should be "starfive/jh7110-pine64-star64.dtb" ?

>
>  /* enable U74-mc hart1~hart4 prefetcher */
>  static void enable_prefetcher(void)
> @@ -78,6 +80,8 @@ static void set_fdtfile(void)
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

Best regards, -E
