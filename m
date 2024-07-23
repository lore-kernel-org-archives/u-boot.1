Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170FFC3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CE9C88496;
	Tue, 23 Jul 2024 15:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UMZ3GGpE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A86D88204; Tue, 23 Jul 2024 15:06:03 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E615288496
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 15:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52f025bc147so3356550e87.3
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721739958; x=1722344758; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwQ+mEljC8zdAY/zuem7jvWfr2KU/azmqAyyW4nJrCo=;
 b=UMZ3GGpESqnQZe/dmyBYDOHLauYbYhQBg13v6jwooJdT/wuP2zkVtr5V/7wMwh4M2E
 mI6eoEVIgud+0kQ806ghzaPXEIOscop1laBX8bu1F8KhLbNdaoNPNCwDIapQhkUyztdB
 Y+je4GxXoxIFMCv3nQvOxfI6c0Zk5zmdcUUkqO1AUkC6mB2juH6Z/V22oYkDHHFxSGAx
 4WEAcDbXhcxVQy6Mf9u7DSTuCAym+L6gGY4GFzFQOtrCVLe/sACuei6RpBMQgy8LjmKm
 eIPFI1URT1EHR41LD5dlq/azQ8qR5JsCsY05n4mXwXqhbvb+rFXmEF+WNb3KWJvS0rrV
 37jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721739958; x=1722344758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UwQ+mEljC8zdAY/zuem7jvWfr2KU/azmqAyyW4nJrCo=;
 b=vS06Ap96EF/fPAkSx4OJrCBhczarMU40SfPLowTdm2ozb3VxR1wl8ZpkY99rwU5vrU
 T+AoHY33p+g57aFIXqRXbaGBtgwpHEecw06qDoYikVAKANauEb9A516J6o0b4iXoENyO
 xRyRVO4ta39noZHBDSv4T9UZdLxiGLKfG9yg0jXlJj5OzJZy8AjhOy/Nj2oysFpKbvQT
 CepwJsupzQJWPT1cGAadFaO0MboUwflx0ZkgplomaFx9WX591kvd+7qC6ENPUfEnb5gc
 ZEkmFvn3PFpy+rtf69VEQ6XNwb/8pKcdz1a740sSTGNZswVLt2GRweT2MqcJY0Fu88J+
 qi3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVggqcPZWWF904rkL60pMJPQf0Vc24xteN3po/IW9EdHBa6pT3NXO4cC7OfrZTbT5Fg5ggn2kmJUddqyGxIRlKfTF8XJg==
X-Gm-Message-State: AOJu0YwJE+WD5LRAEqYF0O4saZQu0FsfaMhXCe/gy79np4eMYkk6qCdi
 DvkFtpoTyJq9/+nMqdPNoS2rdaGijvz7IZ77XrVIhJ7l0KE2vf7L7Py1ATH8B/0aNOIDf4e/bD1
 +MD0ZcqFS9cx5QLDbXhjIuiCmaZw=
X-Google-Smtp-Source: AGHT+IHJGMKjjhGcIYiYIH2/IDRe7yqKWEG6bWg5Ry1FksU3jevleU4bUeAlcA+vf1+eKfDeb5yPUWX7ZKbJUzCzdVM=
X-Received: by 2002:a05:6512:a86:b0:52c:f521:9423 with SMTP id
 2adb3069b0e04-52efb64782dmr6822735e87.26.1721739957600; Tue, 23 Jul 2024
 06:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240719013822.101374-1-minda.chen@starfivetech.com>
 <20240719013822.101374-8-minda.chen@starfivetech.com>
 <CANV2PTOXmm4a4+_94iKoGTAY5-kiym3xwYF77upXdu8KmLKv+Q@mail.gmail.com>
 <CANV2PTPv9v9h0LW08qQq-cU3XJQBhs3Lz-w691CV3=5u7gh=_A@mail.gmail.com>
 <SHXPR01MB08630B214A12FD7BD186B116E6A92@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
 <CANV2PTN4nusHvTmKXsMV3zm6KtwZA1Jkx3CKO9pP=1f5PQhPcg@mail.gmail.com>
 <SHXPR01MB0863DAC3A0BBF387191D8A76E6A92@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <SHXPR01MB0863DAC3A0BBF387191D8A76E6A92@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
From: E Shattow <lucent@gmail.com>
Date: Tue, 23 Jul 2024 06:05:45 -0700
Message-ID: <CANV2PTPGCgOJ=XrcUimRqx0N6ukwe55pg-pgvV=zVcQPaPgHRg@mail.gmail.com>
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

On Tue, Jul 23, 2024 at 3:16=E2=80=AFAM Minda Chen <minda.chen@starfivetech=
.com> wrote:
>
>
>
> >
> > On Mon, Jul 22, 2024 at 6:29=E2=80=AFPM Minda Chen <minda.chen@starfive=
tech.com>
> > wrote:
> > >
> > >
> > >
> > > >
> > > > On Sat, Jul 20, 2024 at 6:47=E2=80=AFPM E Shattow <lucent@gmail.com=
> wrote:
> > > > >
> > > > > Hi, I am testing on Milk-V Mars CM Lite, and I add to these
> > > > > devicetree changes at runtime from
> > > > > board/starfive/visionfive2/spl.c
> > > > >
> > > > > On Thu, Jul 18, 2024 at 6:38=E2=80=AFPM Minda Chen
> > > > > <minda.chen@starfivetech.com>
> > > > wrote:
> > > > > >
> > > > > > Add Jh7110 Cadence USB dts node, Visionfive2 default setting is
> > > > > > USB
> > > > > > 2.0 device.
> > > > > >
> > > > > > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > > > > > ---
> > > > > >  .../dts/jh7110-starfive-visionfive-2.dtsi     |  5 ++
> > > > > >  arch/riscv/dts/jh7110.dtsi                    | 52
> > > > +++++++++++++++++++
> > > > > >  2 files changed, 57 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > > > > > b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > > > > > index e11babc1cd..44785bbee3 100644
> > > > > > --- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > > > > > +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > > > > > @@ -378,3 +378,8 @@
> > > > > >                 };
> > > > > >         };
> > > > > >  };
> > > > > > +
> > > > > > +&usb_cdns3 {
> > > > > > +       dr_mode =3D "peripheral";
> > > > > > +       status =3D "okay";
> > > > > > +};
> > > > > > diff --git a/arch/riscv/dts/jh7110.dtsi
> > > > > > b/arch/riscv/dts/jh7110.dtsi index 2cdc683d49..1eee924e1d 10064=
4
> > > > > > --- a/arch/riscv/dts/jh7110.dtsi
> > > > > > +++ b/arch/riscv/dts/jh7110.dtsi
> > > > > > @@ -371,6 +371,58 @@
> > > > > >                         status =3D "disabled";
> > > > > >                 };
> > > > > >
> > > > > > +               usb0: usb@10100000 {
> > > > > > +                       compatible =3D "starfive,jh7110-usb";
> > > > > > +                       ranges =3D <0x0 0x0 0x10100000 0x100000=
>;
> > > > > > +                       #address-cells =3D <1>;
> > > > > > +                       #size-cells =3D <1>;
> > > > > > +                       starfive,stg-syscon =3D <&stg_syscon 0x=
4>;
> > > > > > +                       clocks =3D <&stgcrg
> > > > JH7110_STGCLK_USB_LPM>,
> > > > > > +                                <&stgcrg
> > > > JH7110_STGCLK_USB_STB>,
> > > > > > +                                <&stgcrg
> > > > JH7110_STGCLK_USB_APB>,
> > > > > > +                                <&stgcrg
> > > > JH7110_STGCLK_USB_AXI>,
> > > > > > +                                <&stgcrg
> > > > JH7110_STGCLK_USB_UTMI_APB>;
> > > > > > +                       clock-names =3D "lpm", "stb", "apb",
> > > > > > + "axi",
> > > > "utmi_apb";
> > > > > > +                       resets =3D <&stgcrg
> > > > JH7110_STGRST_USB_PWRUP>,
> > > > > > +                                <&stgcrg
> > > > JH7110_STGRST_USB_APB>,
> > > > > > +                                <&stgcrg
> > > > JH7110_STGRST_USB_AXI>,
> > > > > > +                                <&stgcrg
> > > > JH7110_STGRST_USB_UTMI_APB>;
> > > > > > +                       reset-names =3D "pwrup", "apb", "axi",
> > > > > > + "utmi_apb";
> > > > > > +
> > > > > > +                       usb_cdns3: usb@0 {
> > > > > > +                               compatible =3D "cdns,usb3";
> > > > > > +                               reg =3D <0x0 0x10000>,
> > > > > > +                                     <0x10000 0x10000>,
> > > > > > +                                     <0x20000 0x10000>;
> > > > > > +                               reg-names =3D "otg", "xhci",
> > "dev";
> > > > > > +                               interrupts =3D <100>, <108>,
> > <110>;
> > > > > > +                               interrupt-names =3D "host",
> > > > "peripheral", "otg";
> > > > > > +                               phys =3D <&usbphy0>;
> > > > > > +                               phy-names =3D "cdns3,usb2-phy";
> > > > > > +                       };
> > > > > > +               };
> > > > > > +
> > > > > > +               usbphy0: phy@10200000 {
> > > > > > +                       compatible =3D "starfive,jh7110-usb-phy=
";
> > > > > > +                       reg =3D <0x0 0x10200000 0x0 0x10000>;
> > > > > > +                       clocks =3D <&syscrg
> > > > JH7110_SYSCLK_USB_125M>,
> > > > > > +                                <&stgcrg
> > > > JH7110_STGCLK_USB_APP_125>;
> > > > > > +                       clock-names =3D "125m", "app_125m";
> > > > > > +                       #phy-cells =3D <0>;
> > > > > > +               };
> > > > > > +
> > > > > > +               pciephy0: phy@10210000 {
> > > > > > +                       compatible =3D "starfive,jh7110-pcie-ph=
y";
> > > > > > +                       reg =3D <0x0 0x10210000 0x0 0x10000>;
> > > > > > +                       #phy-cells =3D <0>;
> > > > > > +               };
> > > > > > +
> > > > > > +               pciephy1: phy@10220000 {
> > > > > > +                       compatible =3D "starfive,jh7110-pcie-ph=
y";
> > > > > > +                       reg =3D <0x0 0x10220000 0x0 0x10000>;
> > > > > > +                       #phy-cells =3D <0>;
> > > > > > +               };
> > > > > > +
> > > > > >                 stgcrg: clock-controller@10230000 {
> > > > > >                         compatible =3D "starfive,jh7110-stgcrg"=
;
> > > > > >                         reg =3D <0x0 0x10230000 0x0 0x10000>;
> > > > > > --
> > > > > > 2.17.1
> > > > > >
> > > > >
> > > > > Access fault
> > > > >
> > > > >         starting USB...
> > > > >         Bus usb@0: cdns-usb3-host usb@0: set 1 has failed, back t=
o 0
> > > > >         scanning bus usb@0 for devices... Unhandled exception:
> > > > > Load
> > > > access fault
> > > > >         EPC: 00000000fff85ce2 RA: 00000000fff85cdc TVAL:
> > > > 0000000000000004
> > > > >         EPC: 0000000040246ce2 RA: 0000000040246cdc reloc adjusted
> > > > >
> > > > >         Code: 9863 3ee7 8526 f0ef c37f 651c 3a03 0105 (43dc)
> > > > >
> > > > >
> > > > >         resetting ...
> > > > >
> > > > > when I add only these:
> > > > >
> > > > >         int offset;
> > > > >
> > > > >         offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000");=
 /*
> > > > &sysgpio */
> > > > >         fdt_add_subnode(fdt, offset, "usb0-0");
> > > > >         fdt_setprop_string(fdt, fdt_path_offset(fdt,
> > > > > "/__symbols__"), "usb_pins", "/soc/pinctrl@13040000/usb0-0");
> > > > >         offset =3D fdt_path_offset(fdt,
> > > > > "/soc/pinctrl@13040000/usb0-0");
> > > > > /* usb_pins */
> > > > >         fdt_create_phandle(fdt, offset);
> > > > >         fdt_add_subnode(fdt, offset, "driver-vbus-pin");
> > > > >         offset =3D fdt_path_offset(fdt,
> > > > > "/soc/pinctrl@13040000/usb0-0/driver-vbus-pin");
> > > > >         fdt_setprop_u32(fdt, offset, "pinmux", 0xff070019); /*
> > > > > GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS, GPOEN_ENABLE,
> > GPI_NONE)
> > > > */
> > > > >         fdt_setprop_empty(fdt, offset, "bias-disable");
> > > > >         fdt_setprop_empty(fdt, offset, "input-disable");
> > > > >         fdt_setprop_empty(fdt, offset, "input-schmitt-disable");
> > > > >         fdt_setprop_u32(fdt, offset, "slew-rate", 0);
> > > > >
> > > > >         offset =3D fdt_path_offset(fdt, "/soc/usb@10100000"); /* =
&usb0
> > */
> > > > >         fdt_setprop_string(fdt, offset, "pinctrl-names", "default=
");
> > > > >         fdt_setprop_u32(fdt, offset, "pinctrl-0",
> > > > > fdt_get_phandle(fdt, fdt_path_offset(fdt,
> > "/soc/pinctrl@13040000/usb0-0")));
> > > > >         fdt_setprop_string(fdt, offset, "status", "okay");
> > > > >
> > > > >         offset =3D fdt_path_offset(fdt, "/soc/usb@10100000/usb@0"=
);
> > > > > /*
> > > > > &usb_cdns3 */
> > > > >         fdt_setprop_string(fdt, offset, "dr_mode",   "host");
> > > > >
> > > > > Success USB is working but PCI disabled if instead I add all of t=
his:
> > > > >
> >
> > > I checked t Milk-V CM board do not contain USB3.0 host So I think the
> > > USB 3.0 configuration is not required.
> >
> > I agree it should be USB 2.0, but with your patch this is the only conf=
iguration
> > that does anything successful with USB2.0 or 3.0
> >
> >
> > >
> > > > >         int offset;
> > > > >
> > > > >         offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000");=
 /*
> > > > &sysgpio */
> > > > >         fdt_add_subnode(fdt, offset, "usb0-0");
> > > > >         fdt_setprop_string(fdt, fdt_path_offset(fdt,
> > > > > "/__symbols__"), "usb_pins", "/soc/pinctrl@13040000/usb0-0");
> > > > >         offset =3D fdt_path_offset(fdt,
> > > > > "/soc/pinctrl@13040000/usb0-0");
> > > > > /* usb_pins */
> > > > >         fdt_create_phandle(fdt, offset);
> > > > >         fdt_add_subnode(fdt, offset, "driver-vbus-pin");
> > > > >         offset =3D fdt_path_offset(fdt,
> > > > > "/soc/pinctrl@13040000/usb0-0/driver-vbus-pin");
> > > > >         fdt_setprop_u32(fdt, offset, "pinmux", 0xff070019); /*
> > > > > GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS, GPOEN_ENABLE,
> > GPI_NONE)
> > > > */
> > > > >         fdt_setprop_empty(fdt, offset, "bias-disable");
> > > > >         fdt_setprop_empty(fdt, offset, "input-disable");
> > > > >         fdt_setprop_empty(fdt, offset, "input-schmitt-disable");
> > > > >         fdt_setprop_u32(fdt, offset, "slew-rate", 0);
> > > > >
> > > > >         offset =3D fdt_path_offset(fdt, "/soc/pcie@2b000000"); /*=
 &pcie0
> > */
> > > > >         fdt_setprop_string(fdt, offset, "status", "disabled");
> > > > >
> > > > >         offset =3D fdt_path_offset(fdt, "/soc/phy@10210000"); /*
> > > > > &pciephy0
> > > > */
> > > > >         fdt_setprop_u32(fdt, offset, "starfive,sys-syscon",
> > > > > fdt_get_phandle(fdt, fdt_path_offset(fdt,
> > > > > "/soc/sys_syscon@13030000"))); /* =3D <&sys_syscon> */
> > > > >         fdt_appendprop_u32(fdt, offset, "starfive,sys-syscon",
> > > > > 0x18);
> > > > > /* append <magic number> */
> > > > >         fdt_setprop_u32(fdt, offset, "starfive,stg-syscon",
> > > > > fdt_get_phandle(fdt, fdt_path_offset(fdt,
> > > > > "/soc/stg_syscon@10240000"))); /* =3D <&stg_syscon> */
> > > > >         fdt_appendprop_u32(fdt, offset, "starfive,stg-syscon",
> > > > > 0x148);
> > > > > /* append <magic number> */
> > > > >         fdt_appendprop_u32(fdt, offset, "starfive,stg-syscon",
> > > > > 0x1f4);
> > > > > /* append <magic number> */
> > > > >         fdt_setprop_string(fdt, offset, "status", "okay");
> > > > >
> > > > >         offset =3D fdt_path_offset(fdt, "/soc/usb@10100000"); /* =
&usb0
> > */
> > > > >         fdt_setprop_string(fdt, offset, "pinctrl-names", "default=
");
> > > > >         fdt_setprop_u32(fdt, offset, "pinctrl-0",
> > > > > fdt_get_phandle(fdt, fdt_path_offset(fdt,
> > "/soc/pinctrl@13040000/usb0-0")));
> > > > >         fdt_setprop_string(fdt, offset, "status", "okay");
> > > > >
> > > > >         offset =3D fdt_path_offset(fdt, "/soc/usb@10100000/usb@0"=
);
> > > > > /*
> > > > > &usb_cdns3 */
> > > > >         fdt_setprop_u32(fdt,    offset, "phys",
> > > > > fdt_get_phandle(fdt, fdt_path_offset(fdt, "/soc/phy@10200000")));
> > > > > /* =3D <&usbphy0> */
> > > > >         fdt_appendprop_u32(fdt, offset, "phys",
> > > > > fdt_get_phandle(fdt, fdt_path_offset(fdt, "/soc/phy@10210000")));=
 /*
> > append <&pciephy0> */
> > > > >         fdt_setprop(fdt,        offset, "phy-names",
> > > > > "cdns3,usb2-phy\0cdns3,usb3-phy",
> > > > > sizeof("cdns3,usb2-phy\0cdns3,usb3-phy"));
> > > > >         fdt_setprop_string(fdt, offset, "dr_mode",   "host");
> > > > >
> > > > > I have made some mistake for devicetree and USB2.0 with keeping
> > > > > pcie0 (not disable)? or is there a problem with the implementatio=
n?
> > > > >
> > > > > Best regards, -E Shattow
> > > >
> >
> > > I don=E2=80=99t have a Milk-V CM board. So I just can test this code =
to Star64.
> > > Thanks. I will test this and add the code to board_fixup_star64().
> >
> > Can you try to configure in USB2.0-only mode on Star64?  Do you see the=
 same
> > problem with "load access fault"?
> >
> Yes =EF=BC=8CUSB 2.0 only can work.
> > ...snip...
> >
> > Same devicetree fixup code but separated some of the statements to mult=
iple
> > lines:
> >
> > https://paste.debian.net/1324036/
> >
> > ```
> Now I can see the issue,Usb 2.0 host can work in Milk-V CM, but PCIe can =
not work.
> Is that correct?
> The PCIe in CM board is PCIe0=EF=BC=8C The PCIe1 is not used. So I think
> disable PCIe1 node and just set USB 2.0 to host is OK.
> milkV CM PCIe0 setting is the same with VisionFive v2.
> The USB 3.0 setting should not be added.
>
> This USB 3.0 setting. Should NOT be added to Milk-V CM board.
> &pciephy0 {
>         starfive,sys-syscon =3D <&sys_syscon 0x18>;
>         starfive,stg-syscon =3D <&stg_syscon 0x148 0x1f4>;
>         status =3D "okay";
> };
>
> &usb_cdns3 {
>         phys =3D <&usbphy0>, <&pciephy0>;
>         phy-names =3D "cdns3,usb2-phy", "cdns3,usb3-phy";
>         dr_mode =3D "host";
>         status =3D "okay";
> };
>

Here is Mars CM Lite:

StarFive # pci
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
00.00.00   0x1556     0x1111     Bridge device           0x04
01.00.00   0x10ec     0x8168     Network controller      0x00
02.00.00   0x1556     0x1111     Bridge device           0x04

This is the DFRobot Mini Router carrier and the Mars CM Lite.  There
is a network interface connected to PCIe.

When I apply this fixup:

void spl_fdt_fixup_jh7110_cadence_usb2_host(void *fdt)
{
        int offset;
        u32 phandle;

        offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000"); /* &sysgp=
io */
        fdt_add_subnode(fdt, offset, "usb0-0");
        fdt_setprop_string(fdt, fdt_path_offset(fdt, "/__symbols__"),
"usb_pins", "/soc/pinctrl@13040000/usb0-0");
        offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0");
/* usb_pins */
        fdt_create_phandle(fdt, offset);
        fdt_add_subnode(fdt, offset, "driver-vbus-pin");
        offset =3D fdt_path_offset(fdt,
"/soc/pinctrl@13040000/usb0-0/driver-vbus-pin");
        fdt_setprop_u32(fdt, offset, "pinmux", 0xff070019); /*
GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS, GPOEN_ENABLE, GPI_NONE) */
        fdt_setprop_empty(fdt, offset, "bias-disable");
        fdt_setprop_empty(fdt, offset, "input-disable");
        fdt_setprop_empty(fdt, offset, "input-schmitt-disable");
        fdt_setprop_u32(fdt, offset, "slew-rate", 0);

        offset =3D fdt_path_offset(fdt, "/soc/pcie@2c000000"); /* &pcie1 */
        fdt_setprop_string(fdt, offset, "status", "disabled");

        offset =3D fdt_path_offset(fdt, "/soc/usb@10100000"); /* &usb0 */
        fdt_setprop_string(fdt, offset, "pinctrl-names", "default");
        phandle =3D fdt_get_phandle(fdt, fdt_path_offset(fdt,
"/soc/pinctrl@13040000/usb0-0")); /* <&usb_pins> */
        fdt_setprop_u32(fdt, offset, "pinctrl-0", phandle);
        fdt_setprop_string(fdt, offset, "status", "okay");

        offset =3D fdt_path_offset(fdt, "/soc/usb@10100000/usb@0"); /*
&usb_cdns3 */
        fdt_setprop_string(fdt, offset, "dr_mode", "host");
}

at the last instruction of spl_fdt_fixup_mars_cm() then there is this
error I am telling you about:

U-Boot 2024.07-00971-g8eed381de5ef-dirty (Jul 23 2024 - 05:49:09 -0700)

CPU:   sifive,u74-mc
Model: Milk-V Mars CM Lite
DRAM:  4 GiB
Core:  139 devices, 29 uclasses, devicetree: board
WDT:   Not starting watchdog@13070000
MMC:   mmc@16010000: 0, mmc@16020000: 1
Loading Environment from SPIFlash... SF: Detected gd25lq128 with page
size 256 Bytes, erase size 4 KiB, total 16 MiB
OK
StarFive EEPROM format v2

--------EEPROM INFO--------
Vendor : MILK-V
Product full SN: MARC-V10-2340-D004E000-000006DF
data version: 0x2
PCB revision: 0xc1
BOM revision: A
Ethernet MAC0 address: 6c:cf:39:00:83:11
Ethernet MAC1 address: 6c:cf:39:00:83:12
--------EEPROM INFO--------

starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
PCI: Failed autoconfig bar 10
In:    serial@10000000
Out:   serial@10000000
Err:   serial@10000000
Net:   eth0: ethernet@16030000
Error: eth_rtl8169 No valid MAC address found.

starting USB...
Bus usb@0: cdns-usb3-host usb@0: set 1 has failed, back to 0
scanning bus usb@0 for devices... Unhandled exception: Load access fault
EPC: 00000000fff85b2e RA: 00000000fff85b28 TVAL: 0000000000000004
EPC: 0000000040246b2e RA: 0000000040246b28 reloc adjusted

Code: 9863 3ee7 8526 f0ef c37f 651c 3a03 0105 (43dc)


resetting ...

(C)StarFive
CCC
