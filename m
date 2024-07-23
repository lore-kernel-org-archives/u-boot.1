Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692A1C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 03:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58BAA8867C;
	Tue, 23 Jul 2024 05:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dEK5YFJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27D75886CC; Tue, 23 Jul 2024 05:54:06 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A83B88681
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 05:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52f04c1e58eso2128114e87.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 20:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721706841; x=1722311641; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0YxLIBEqcHBiCqlPQ2TjKlvDUvcgBOIYiXq2+jasdag=;
 b=dEK5YFJTcaa56AQWY/SrlG6M+b5GmSPw0LgEfqaENj+3CEZVU6cVyNwqLn/nOWWW8g
 vmuZfc5keMnxombVPlPEFRJQzHEpjCJAM79a+4gtY6Epw3YUvz5Hx1wI5fY1Pa8Kfrq8
 JTqW63ABipO7fElnda+T+iU2mU9N51SWrc36l7KMA4KFlHY5pfVU1eHPtcG2dYmOB3QB
 vZLJH9Z4kGzeJKEYspPfsbD+PnYxo2kTklHxT3hzqDVq0kVQu0Fpvp+T8BPD/wUpZ+kz
 dPaE7Lg+MAxVSOiKw9GArSL5Q6wnWqq1KuGLcG+nScynZvf8oi72uP4v8OPBopf17oqB
 jhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721706841; x=1722311641;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0YxLIBEqcHBiCqlPQ2TjKlvDUvcgBOIYiXq2+jasdag=;
 b=VjAqCIDCQ59ZO5lTRTjvun9Rw28AuHQnCT5kinmVSaxCbVpqW8AhF2HAtrgkiKKeK8
 jwz3/f6Y9UGRLlC+n0/fTr6R4g/bFWKY40rrZP1QldAGXIo/q8T9fLRhbDTAckd9p+4g
 Gak+jXVfhx2casbYOvsouQzztDBPyrRyCfbxLmZIAgWFbeqO8POEhMSjlfJk0jy62rzy
 T0yV/kyOggtSqiDeZOeFwSFWUZlZ2l5d1PB6VfjCDqVW2wwhfZ41O7LoBjvVFXLROFcM
 PQKrvOfTey+50Ae9IV/G78zWvJWQubpVpCNNN7XOL5IZxUn9lKwUq9yhJ8AChNw5T/kd
 urxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeD7emD4K3QfayML+iFsq9Kr4WAQ4NeaPb7LSAdQWLRP3EhGR9gArvDTI0eR2y8+IoRwWiwmN1cPLQOnA4vWf8s9vlVg==
X-Gm-Message-State: AOJu0YyOWUm4c39UQEguI4rLXUBAf/n2O8FM+flaPWxBlQs7yAmHDy8k
 MjNi6vJG1S23I93pgDHdpkkqzDqJp0FJtZyLNzE3Gi+j4+BtI+LZMoodG1xo8WLlY0W3re6q/tU
 9LrUb6m6W8ia8Hgt62ICowbjxwvg=
X-Google-Smtp-Source: AGHT+IFHBfqMy0PlqR5jurWb2GZFDKNXSPFSmyPYl8NNDoXMlb5eO5VL8w+UZoh9wuPuN+ZmEv5/aRTwp1e+LooH2eY=
X-Received: by 2002:a05:6512:12d5:b0:52c:9877:71b7 with SMTP id
 2adb3069b0e04-52efb81264emr6535206e87.59.1721706840953; Mon, 22 Jul 2024
 20:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240719013822.101374-1-minda.chen@starfivetech.com>
 <20240719013822.101374-8-minda.chen@starfivetech.com>
 <CANV2PTOXmm4a4+_94iKoGTAY5-kiym3xwYF77upXdu8KmLKv+Q@mail.gmail.com>
 <CANV2PTPv9v9h0LW08qQq-cU3XJQBhs3Lz-w691CV3=5u7gh=_A@mail.gmail.com>
 <SHXPR01MB08630B214A12FD7BD186B116E6A92@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <SHXPR01MB08630B214A12FD7BD186B116E6A92@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
From: E Shattow <lucent@gmail.com>
Date: Mon, 22 Jul 2024 20:53:49 -0700
Message-ID: <CANV2PTN4nusHvTmKXsMV3zm6KtwZA1Jkx3CKO9pP=1f5PQhPcg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] dts: starfive: Add JH7110 Cadence USB dts node
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, 
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
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

On Mon, Jul 22, 2024 at 6:29=E2=80=AFPM Minda Chen <minda.chen@starfivetech=
.com> wrote:
>
>
>
> >
> > On Sat, Jul 20, 2024 at 6:47=E2=80=AFPM E Shattow <lucent@gmail.com> wr=
ote:
> > >
> > > Hi, I am testing on Milk-V Mars CM Lite, and I add to these devicetre=
e
> > > changes at runtime from board/starfive/visionfive2/spl.c
> > >
> > > On Thu, Jul 18, 2024 at 6:38=E2=80=AFPM Minda Chen <minda.chen@starfi=
vetech.com>
> > wrote:
> > > >
> > > > Add Jh7110 Cadence USB dts node, Visionfive2 default setting is USB
> > > > 2.0 device.
> > > >
> > > > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > > > ---
> > > >  .../dts/jh7110-starfive-visionfive-2.dtsi     |  5 ++
> > > >  arch/riscv/dts/jh7110.dtsi                    | 52
> > +++++++++++++++++++
> > > >  2 files changed, 57 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > > > b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > > > index e11babc1cd..44785bbee3 100644
> > > > --- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > > > +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > > > @@ -378,3 +378,8 @@
> > > >                 };
> > > >         };
> > > >  };
> > > > +
> > > > +&usb_cdns3 {
> > > > +       dr_mode =3D "peripheral";
> > > > +       status =3D "okay";
> > > > +};
> > > > diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dts=
i
> > > > index 2cdc683d49..1eee924e1d 100644
> > > > --- a/arch/riscv/dts/jh7110.dtsi
> > > > +++ b/arch/riscv/dts/jh7110.dtsi
> > > > @@ -371,6 +371,58 @@
> > > >                         status =3D "disabled";
> > > >                 };
> > > >
> > > > +               usb0: usb@10100000 {
> > > > +                       compatible =3D "starfive,jh7110-usb";
> > > > +                       ranges =3D <0x0 0x0 0x10100000 0x100000>;
> > > > +                       #address-cells =3D <1>;
> > > > +                       #size-cells =3D <1>;
> > > > +                       starfive,stg-syscon =3D <&stg_syscon 0x4>;
> > > > +                       clocks =3D <&stgcrg
> > JH7110_STGCLK_USB_LPM>,
> > > > +                                <&stgcrg
> > JH7110_STGCLK_USB_STB>,
> > > > +                                <&stgcrg
> > JH7110_STGCLK_USB_APB>,
> > > > +                                <&stgcrg
> > JH7110_STGCLK_USB_AXI>,
> > > > +                                <&stgcrg
> > JH7110_STGCLK_USB_UTMI_APB>;
> > > > +                       clock-names =3D "lpm", "stb", "apb", "axi",
> > "utmi_apb";
> > > > +                       resets =3D <&stgcrg
> > JH7110_STGRST_USB_PWRUP>,
> > > > +                                <&stgcrg
> > JH7110_STGRST_USB_APB>,
> > > > +                                <&stgcrg
> > JH7110_STGRST_USB_AXI>,
> > > > +                                <&stgcrg
> > JH7110_STGRST_USB_UTMI_APB>;
> > > > +                       reset-names =3D "pwrup", "apb", "axi",
> > > > + "utmi_apb";
> > > > +
> > > > +                       usb_cdns3: usb@0 {
> > > > +                               compatible =3D "cdns,usb3";
> > > > +                               reg =3D <0x0 0x10000>,
> > > > +                                     <0x10000 0x10000>,
> > > > +                                     <0x20000 0x10000>;
> > > > +                               reg-names =3D "otg", "xhci", "dev";
> > > > +                               interrupts =3D <100>, <108>, <110>;
> > > > +                               interrupt-names =3D "host",
> > "peripheral", "otg";
> > > > +                               phys =3D <&usbphy0>;
> > > > +                               phy-names =3D "cdns3,usb2-phy";
> > > > +                       };
> > > > +               };
> > > > +
> > > > +               usbphy0: phy@10200000 {
> > > > +                       compatible =3D "starfive,jh7110-usb-phy";
> > > > +                       reg =3D <0x0 0x10200000 0x0 0x10000>;
> > > > +                       clocks =3D <&syscrg
> > JH7110_SYSCLK_USB_125M>,
> > > > +                                <&stgcrg
> > JH7110_STGCLK_USB_APP_125>;
> > > > +                       clock-names =3D "125m", "app_125m";
> > > > +                       #phy-cells =3D <0>;
> > > > +               };
> > > > +
> > > > +               pciephy0: phy@10210000 {
> > > > +                       compatible =3D "starfive,jh7110-pcie-phy";
> > > > +                       reg =3D <0x0 0x10210000 0x0 0x10000>;
> > > > +                       #phy-cells =3D <0>;
> > > > +               };
> > > > +
> > > > +               pciephy1: phy@10220000 {
> > > > +                       compatible =3D "starfive,jh7110-pcie-phy";
> > > > +                       reg =3D <0x0 0x10220000 0x0 0x10000>;
> > > > +                       #phy-cells =3D <0>;
> > > > +               };
> > > > +
> > > >                 stgcrg: clock-controller@10230000 {
> > > >                         compatible =3D "starfive,jh7110-stgcrg";
> > > >                         reg =3D <0x0 0x10230000 0x0 0x10000>;
> > > > --
> > > > 2.17.1
> > > >
> > >
> > > Access fault
> > >
> > >         starting USB...
> > >         Bus usb@0: cdns-usb3-host usb@0: set 1 has failed, back to 0
> > >         scanning bus usb@0 for devices... Unhandled exception: Load
> > access fault
> > >         EPC: 00000000fff85ce2 RA: 00000000fff85cdc TVAL:
> > 0000000000000004
> > >         EPC: 0000000040246ce2 RA: 0000000040246cdc reloc adjusted
> > >
> > >         Code: 9863 3ee7 8526 f0ef c37f 651c 3a03 0105 (43dc)
> > >
> > >
> > >         resetting ...
> > >
> > > when I add only these:
> > >
> > >         int offset;
> > >
> > >         offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000"); /*
> > &sysgpio */
> > >         fdt_add_subnode(fdt, offset, "usb0-0");
> > >         fdt_setprop_string(fdt, fdt_path_offset(fdt, "/__symbols__"),
> > > "usb_pins", "/soc/pinctrl@13040000/usb0-0");
> > >         offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0=
");
> > > /* usb_pins */
> > >         fdt_create_phandle(fdt, offset);
> > >         fdt_add_subnode(fdt, offset, "driver-vbus-pin");
> > >         offset =3D fdt_path_offset(fdt,
> > > "/soc/pinctrl@13040000/usb0-0/driver-vbus-pin");
> > >         fdt_setprop_u32(fdt, offset, "pinmux", 0xff070019); /*
> > > GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS, GPOEN_ENABLE, GPI_NONE)
> > */
> > >         fdt_setprop_empty(fdt, offset, "bias-disable");
> > >         fdt_setprop_empty(fdt, offset, "input-disable");
> > >         fdt_setprop_empty(fdt, offset, "input-schmitt-disable");
> > >         fdt_setprop_u32(fdt, offset, "slew-rate", 0);
> > >
> > >         offset =3D fdt_path_offset(fdt, "/soc/usb@10100000"); /* &usb=
0 */
> > >         fdt_setprop_string(fdt, offset, "pinctrl-names", "default");
> > >         fdt_setprop_u32(fdt, offset, "pinctrl-0", fdt_get_phandle(fdt=
,
> > > fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0")));
> > >         fdt_setprop_string(fdt, offset, "status", "okay");
> > >
> > >         offset =3D fdt_path_offset(fdt, "/soc/usb@10100000/usb@0"); /=
*
> > > &usb_cdns3 */
> > >         fdt_setprop_string(fdt, offset, "dr_mode",   "host");
> > >
> > > Success USB is working but PCI disabled if instead I add all of this:
> > >

> I checked t Milk-V CM board do not contain USB3.0 host
> So I think the USB 3.0 configuration is not required.

I agree it should be USB 2.0, but with your patch this is the only
configuration that does anything successful with USB2.0 or 3.0


>
> > >         int offset;
> > >
> > >         offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000"); /*
> > &sysgpio */
> > >         fdt_add_subnode(fdt, offset, "usb0-0");
> > >         fdt_setprop_string(fdt, fdt_path_offset(fdt, "/__symbols__"),
> > > "usb_pins", "/soc/pinctrl@13040000/usb0-0");
> > >         offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0=
");
> > > /* usb_pins */
> > >         fdt_create_phandle(fdt, offset);
> > >         fdt_add_subnode(fdt, offset, "driver-vbus-pin");
> > >         offset =3D fdt_path_offset(fdt,
> > > "/soc/pinctrl@13040000/usb0-0/driver-vbus-pin");
> > >         fdt_setprop_u32(fdt, offset, "pinmux", 0xff070019); /*
> > > GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS, GPOEN_ENABLE, GPI_NONE)
> > */
> > >         fdt_setprop_empty(fdt, offset, "bias-disable");
> > >         fdt_setprop_empty(fdt, offset, "input-disable");
> > >         fdt_setprop_empty(fdt, offset, "input-schmitt-disable");
> > >         fdt_setprop_u32(fdt, offset, "slew-rate", 0);
> > >
> > >         offset =3D fdt_path_offset(fdt, "/soc/pcie@2b000000"); /* &pc=
ie0 */
> > >         fdt_setprop_string(fdt, offset, "status", "disabled");
> > >
> > >         offset =3D fdt_path_offset(fdt, "/soc/phy@10210000"); /* &pci=
ephy0
> > */
> > >         fdt_setprop_u32(fdt, offset, "starfive,sys-syscon",
> > > fdt_get_phandle(fdt, fdt_path_offset(fdt,
> > > "/soc/sys_syscon@13030000"))); /* =3D <&sys_syscon> */
> > >         fdt_appendprop_u32(fdt, offset, "starfive,sys-syscon", 0x18);
> > > /* append <magic number> */
> > >         fdt_setprop_u32(fdt, offset, "starfive,stg-syscon",
> > > fdt_get_phandle(fdt, fdt_path_offset(fdt,
> > > "/soc/stg_syscon@10240000"))); /* =3D <&stg_syscon> */
> > >         fdt_appendprop_u32(fdt, offset, "starfive,stg-syscon", 0x148)=
;
> > > /* append <magic number> */
> > >         fdt_appendprop_u32(fdt, offset, "starfive,stg-syscon", 0x1f4)=
;
> > > /* append <magic number> */
> > >         fdt_setprop_string(fdt, offset, "status", "okay");
> > >
> > >         offset =3D fdt_path_offset(fdt, "/soc/usb@10100000"); /* &usb=
0 */
> > >         fdt_setprop_string(fdt, offset, "pinctrl-names", "default");
> > >         fdt_setprop_u32(fdt, offset, "pinctrl-0", fdt_get_phandle(fdt=
,
> > > fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0")));
> > >         fdt_setprop_string(fdt, offset, "status", "okay");
> > >
> > >         offset =3D fdt_path_offset(fdt, "/soc/usb@10100000/usb@0"); /=
*
> > > &usb_cdns3 */
> > >         fdt_setprop_u32(fdt,    offset, "phys",
> > > fdt_get_phandle(fdt, fdt_path_offset(fdt, "/soc/phy@10200000"))); /* =
=3D
> > > <&usbphy0> */
> > >         fdt_appendprop_u32(fdt, offset, "phys", fdt_get_phandle(fdt,
> > > fdt_path_offset(fdt, "/soc/phy@10210000"))); /* append <&pciephy0> */
> > >         fdt_setprop(fdt,        offset, "phy-names",
> > > "cdns3,usb2-phy\0cdns3,usb3-phy",
> > > sizeof("cdns3,usb2-phy\0cdns3,usb3-phy"));
> > >         fdt_setprop_string(fdt, offset, "dr_mode",   "host");
> > >
> > > I have made some mistake for devicetree and USB2.0 with keeping pcie0
> > > (not disable)? or is there a problem with the implementation?
> > >
> > > Best regards, -E Shattow
> >

> I don=E2=80=99t have a Milk-V CM board. So I just can test this code to S=
tar64.
> Thanks. I will test this and add the code to board_fixup_star64().

Can you try to configure in USB2.0-only mode on Star64?  Do you see
the same problem with "load access fault"?

...snip...

Same devicetree fixup code but separated some of the statements to
multiple lines:

https://paste.debian.net/1324036/

```
diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/=
spl.c
index b794b73b6b..b4b0930e75 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -123,6 +123,53 @@ static const struct starfive_vf2_pro star64_pine64[] =
=3D {
  "tx-internal-delay-ps", "300"},
 };

+void spl_fdt_fixup_jh7110_cadence_usb3_host(void *fdt)
+{
+ int offset;
+ u32 phandle;
+
+ offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000"); /* &sysgpio */
+ fdt_add_subnode(fdt, offset, "usb0-0");
+ fdt_setprop_string(fdt, fdt_path_offset(fdt, "/__symbols__"),
"usb_pins", "/soc/pinctrl@13040000/usb0-0");
+ offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0"); /* usb_p=
ins */
+ fdt_create_phandle(fdt, offset);
+ fdt_add_subnode(fdt, offset, "driver-vbus-pin");
+ offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0/driver-vbus=
-pin");
+ fdt_setprop_u32(fdt, offset, "pinmux", 0xff070019); /* GPIOMUX(25,
GPOUT_SYS_USB_DRIVE_VBUS, GPOEN_ENABLE, GPI_NONE) */
+ fdt_setprop_empty(fdt, offset, "bias-disable");
+ fdt_setprop_empty(fdt, offset, "input-disable");
+ fdt_setprop_empty(fdt, offset, "input-schmitt-disable");
+ fdt_setprop_u32(fdt, offset, "slew-rate", 0);
+
+ offset =3D fdt_path_offset(fdt, "/soc/pcie@2b000000"); /* &pcie0 */
+ fdt_setprop_string(fdt, offset, "status", "disabled");
+
+ offset =3D fdt_path_offset(fdt, "/soc/phy@10210000"); /* &pciephy0 */
+ phandle =3D fdt_get_phandle(fdt, fdt_path_offset(fdt,
"/soc/sys_syscon@13030000")); /* =3D <&sys_syscon> */
+ fdt_setprop_u32(fdt, offset, "starfive,sys-syscon", phandle);
+ fdt_appendprop_u32(fdt, offset, "starfive,sys-syscon", 0x18); /*
append <magic number> */
+ phandle =3D fdt_get_phandle(fdt, fdt_path_offset(fdt,
"/soc/stg_syscon@10240000")); /* =3D <&stg_syscon> */
+ fdt_setprop_u32(fdt, offset, "starfive,stg-syscon", phandle);
+ fdt_appendprop_u32(fdt, offset, "starfive,stg-syscon", 0x148); /*
append <magic number> */
+ fdt_appendprop_u32(fdt, offset, "starfive,stg-syscon", 0x1f4); /*
append <magic number> */
+ fdt_setprop_string(fdt, offset, "status", "okay");
+
+ offset =3D fdt_path_offset(fdt, "/soc/usb@10100000"); /* &usb0 */
+ fdt_setprop_string(fdt, offset, "pinctrl-names", "default");
+ phandle =3D fdt_get_phandle(fdt, fdt_path_offset(fdt,
"/soc/pinctrl@13040000/usb0-0")); /* <&usb_pins> */
+ fdt_setprop_u32(fdt, offset, "pinctrl-0", phandle);
+ fdt_setprop_string(fdt, offset, "status", "okay");
+
+ offset =3D fdt_path_offset(fdt, "/soc/usb@10100000/usb@0"); /* &usb_cdns3=
 */
+ phandle =3D fdt_get_phandle(fdt, fdt_path_offset(fdt,
"/soc/phy@10200000")); /* =3D <&usbphy0> */
+ fdt_setprop_u32(fdt, offset, "phys", phandle);
+ phandle =3D fdt_get_phandle(fdt, fdt_path_offset(fdt,
"/soc/phy@10210000")); /* append <&pciephy0> */
+ fdt_appendprop_u32(fdt, offset, "phys", phandle);
+ fdt_setprop_string(fdt, offset, "phy-names", "cdns3,usb2-phy");
+ fdt_appendprop_string(fdt, offset, "phy-names", "cdns3,usb3-phy");
+ fdt_setprop_string(fdt, offset, "dr_mode", "host");
+}
+
 void spl_fdt_fixup_mars(void *fdt)
 {
  static const char compat[] =3D "milkv,mars\0starfive,jh7110";
@@ -335,6 +382,8 @@ void spl_fdt_fixup_star64(void *fdt)
  break;
  }
  }
+
+ spl_fdt_fixup_jh7110_cadence_usb3_host(fdt);
 }

 void spl_perform_fixups(struct spl_image_info *spl_image)
```

I think there is missing some of the USB2.0-only logic in your patch.
Can you try some more testing to understand why this fault happens
here?

Thanks,

-E
