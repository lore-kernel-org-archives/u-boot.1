Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50674C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 18:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8240E88966;
	Wed, 24 Jul 2024 20:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ObnZ1xBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE3A188959; Wed, 24 Jul 2024 20:06:16 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F03B88966
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 20:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52efd8807aaso5906168e87.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 11:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721844372; x=1722449172; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ON7ouuRykYhwhEZbAvomTMmy/a9XlLFcd3FTMiixf4=;
 b=ObnZ1xBk0W3ycMIwhVpyS49WJAkBSkXDPf25/pLQ+tIHcYL7kigG4HJ4wMaMYL4NOu
 QrZyNOWO1S0NkGFfwXBZ3Vl/9V/QvuN/ljDvDqAYDZb2SdgaUJS+cz8GZI00XN1Fa6o8
 ieYLaipTI8knBmZXwpJgg7b19n6GOjhF4UESGKK5tnWNOcMIZeJoYxytsAXWOl2NecUo
 ZsG0QX7Zqv/Q/NQ7jDuJBJ8YN2BT7acew4J/zF1GkgHhHt2Dni+iq7MFtaJtWiUdSorf
 af2HtAZ1fu/zHoIVc6fo+teZ2tiKDFvx6T8dWe3AHmGHS4Psz5gWkycuj4ejWhzdbQRL
 QPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721844372; x=1722449172;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ON7ouuRykYhwhEZbAvomTMmy/a9XlLFcd3FTMiixf4=;
 b=tsuZ+YPJ9lnEWdjakbyww+cbKWyjnArwcCs4NBOYKTImJ+gB4wL+5M7v8WKPAF3zFs
 bQ9eJ2ptbyPpXmuq2b3FseVErUuOX/lkV255csm1YsH/70CMwPLfYoNe6f6zJvFNintp
 xvQs5NNdAka31i5m+Pzd2xNZZXc3iQzzBQZZg74Dw4lwx7Q+W0WqVv9VSlMC2CJrqe6E
 Uc1Bv25Xth6TVPf5ViSy8a4JXwrJ8O8rkrNg+gXL0rwZrqvzPTxwut3gG9ehUSPTG1T/
 cTqc1YJ5/VnS2zmbZHTpsKwTBOJXoTkaKx15Zpcpg78ItLLpN5+5H7sBV0/KMCF4o1kD
 QjsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPjc6hHNfx8pPc1+YfdcLkGXIzfVPAXwe+kZxsano4swMw0MQieegQCRoY+TGOn6P7Zfu4Isu+HiWOSOPYATmMR6QqPw==
X-Gm-Message-State: AOJu0YzOrDcX5vW4ztD5ONfnjbvD7HLMQY/JNb+9U/vB+NS0aqCQJw7Y
 kTWsQ8uMlRV/TVAleVecdmQyWn0mSLbNYdiaENT8AYKqOUdZGeXpVXS3GGc4PX08rWAdATRjumR
 LAtcUU+OEnRTkN9Au8z0p44B1+40=
X-Google-Smtp-Source: AGHT+IH3s2laG6QCeBFcASLZXesz2/iR2Izlf8zK3cqbZnyVEUu2VRbSisOnirAp4XVGeC2K60x8rDzYMcpkMbDrMqA=
X-Received: by 2002:a05:6512:3f03:b0:52f:368:5018 with SMTP id
 2adb3069b0e04-52fd3f6c226mr324453e87.43.1721844371379; Wed, 24 Jul 2024
 11:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240719013822.101374-1-minda.chen@starfivetech.com>
 <20240719013822.101374-8-minda.chen@starfivetech.com>
 <CANV2PTOXmm4a4+_94iKoGTAY5-kiym3xwYF77upXdu8KmLKv+Q@mail.gmail.com>
 <CANV2PTPv9v9h0LW08qQq-cU3XJQBhs3Lz-w691CV3=5u7gh=_A@mail.gmail.com>
 <SHXPR01MB08630B214A12FD7BD186B116E6A92@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
 <CANV2PTN4nusHvTmKXsMV3zm6KtwZA1Jkx3CKO9pP=1f5PQhPcg@mail.gmail.com>
 <SHXPR01MB0863DAC3A0BBF387191D8A76E6A92@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
 <CANV2PTPGCgOJ=XrcUimRqx0N6ukwe55pg-pgvV=zVcQPaPgHRg@mail.gmail.com>
 <SHXPR01MB0863B451D94A3DFDB4E3633AE6AA2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <SHXPR01MB0863B451D94A3DFDB4E3633AE6AA2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
From: E Shattow <lucent@gmail.com>
Date: Wed, 24 Jul 2024 11:05:59 -0700
Message-ID: <CANV2PTPnu5L9aJ-ViaMpEvkT+dF4tsCVOOy5vC9G=Nv88W=2cA@mail.gmail.com>
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

On Tue, Jul 23, 2024 at 8:24=E2=80=AFPM Minda Chen <minda.chen@starfivetech=
.com> wrote:
>
>
>
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: E Shattow <lucent@gmail.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B47=E6=9C=8823=E6=97=
=A5 21:06
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Minda Chen <minda.chen@starfivetech.com>
> > =E6=8A=84=E9=80=81: Marek Vasut <marex@denx.de>; Tom Rini <trini@konsul=
ko.com>; Roger
> > Quadros <rogerq@kernel.org>; Neil Armstrong <neil.armstrong@linaro.org>=
;
> > Alexey Romanov <avromanov@salutedevices.com>; Sumit Garg
> > <sumit.garg@linaro.org>; Mark Kettenis <kettenis@openbsd.org>; Nishanth
> > Menon <nm@ti.com>; Rick Chen <rick@andestech.com>; Leo Yu-Chi Liang
> > <ycliang@andestech.com>; u-boot@lists.denx.de; Heinrich Schuchardt
> > <xypron.glpk@gmx.de>; Simon Glass <sjg@chromium.org>
> > =E4=B8=BB=E9=A2=98: Re: [PATCH v3 7/8] dts: starfive: Add JH7110 Cadenc=
e USB dts node
> >
> > On Tue, Jul 23, 2024 at 3:16=E2=80=AFAM Minda Chen <minda.chen@starfive=
tech.com>
> > wrote:
> > >
> > >
> > >
> > > >
> > > > On Mon, Jul 22, 2024 at 6:29=E2=80=AFPM Minda Chen
> > > > <minda.chen@starfivetech.com>
> > > > wrote:
> > > > >
> > > > >
> > > > >
> > > > > >
> > > > > > On Sat, Jul 20, 2024 at 6:47=E2=80=AFPM E Shattow <lucent@gmail=
.com> wrote:
> > > > > > >
> > > > > > > Hi, I am testing on Milk-V Mars CM Lite, and I add to these
> > > > > > > devicetree changes at runtime from
> > > > > > > board/starfive/visionfive2/spl.c
> > > > > > >
> > > > > > > On Thu, Jul 18, 2024 at 6:38=E2=80=AFPM Minda Chen
> > > > > > > <minda.chen@starfivetech.com>
> > > > > > wrote:
> > > > > > > >
> > > > > > > > Add Jh7110 Cadence USB dts node, Visionfive2 default settin=
g
> > > > > > > > is USB
> > > > > > > > 2.0 device.
> > > > > > > >
> > > > > > > > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > > > > > > > ---
> > > > > > > >  .../dts/jh7110-starfive-visionfive-2.dtsi     |  5 ++
> > > > > > > >  arch/riscv/dts/jh7110.dtsi                    | 52
> > > > > > +++++++++++++++++++
> > > > > > > >  2 files changed, 57 insertions(+)
> > > > > > > >
> > > > > > > > diff --git
> > > > > > > > a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > > > > > > > b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > > > > > > > index e11babc1cd..44785bbee3 100644
> > > > > > > > --- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > > > > > > > +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > > > > > > > @@ -378,3 +378,8 @@
> > > > > > > >                 };
> > > > > > > >         };
> > > > > > > >  };
> > > > > > > > +
> > > > > > > > +&usb_cdns3 {
> > > > > > > > +       dr_mode =3D "peripheral";
> > > > > > > > +       status =3D "okay";
> > > > > > > > +};
> > > > > > > > diff --git a/arch/riscv/dts/jh7110.dtsi
> > > > > > > > b/arch/riscv/dts/jh7110.dtsi index 2cdc683d49..1eee924e1d
> > > > > > > > 100644
> > > > > > > > --- a/arch/riscv/dts/jh7110.dtsi
> > > > > > > > +++ b/arch/riscv/dts/jh7110.dtsi
> > > > > > > > @@ -371,6 +371,58 @@
> > > > > > > >                         status =3D "disabled";
> > > > > > > >                 };
> > > > > > > >
> > > > > > > > +               usb0: usb@10100000 {
> > > > > > > > +                       compatible =3D "starfive,jh7110-usb=
";
> > > > > > > > +                       ranges =3D <0x0 0x0 0x10100000
> > 0x100000>;
> > > > > > > > +                       #address-cells =3D <1>;
> > > > > > > > +                       #size-cells =3D <1>;
> > > > > > > > +                       starfive,stg-syscon =3D <&stg_sysco=
n
> > 0x4>;
> > > > > > > > +                       clocks =3D <&stgcrg
> > > > > > JH7110_STGCLK_USB_LPM>,
> > > > > > > > +                                <&stgcrg
> > > > > > JH7110_STGCLK_USB_STB>,
> > > > > > > > +                                <&stgcrg
> > > > > > JH7110_STGCLK_USB_APB>,
> > > > > > > > +                                <&stgcrg
> > > > > > JH7110_STGCLK_USB_AXI>,
> > > > > > > > +                                <&stgcrg
> > > > > > JH7110_STGCLK_USB_UTMI_APB>;
> > > > > > > > +                       clock-names =3D "lpm", "stb", "apb"=
,
> > > > > > > > + "axi",
> > > > > > "utmi_apb";
> > > > > > > > +                       resets =3D <&stgcrg
> > > > > > JH7110_STGRST_USB_PWRUP>,
> > > > > > > > +                                <&stgcrg
> > > > > > JH7110_STGRST_USB_APB>,
> > > > > > > > +                                <&stgcrg
> > > > > > JH7110_STGRST_USB_AXI>,
> > > > > > > > +                                <&stgcrg
> > > > > > JH7110_STGRST_USB_UTMI_APB>;
> > > > > > > > +                       reset-names =3D "pwrup", "apb", "ax=
i",
> > > > > > > > + "utmi_apb";
> > > > > > > > +
> > > > > > > > +                       usb_cdns3: usb@0 {
> > > > > > > > +                               compatible =3D "cdns,usb3";
> > > > > > > > +                               reg =3D <0x0 0x10000>,
> > > > > > > > +                                     <0x10000 0x10000>,
> > > > > > > > +                                     <0x20000 0x10000>;
> > > > > > > > +                               reg-names =3D "otg", "xhci"=
,
> > > > "dev";
> > > > > > > > +                               interrupts =3D <100>, <108>=
,
> > > > <110>;
> > > > > > > > +                               interrupt-names =3D "host",
> > > > > > "peripheral", "otg";
> > > > > > > > +                               phys =3D <&usbphy0>;
> > > > > > > > +                               phy-names =3D
> > "cdns3,usb2-phy";
> > > > > > > > +                       };
> > > > > > > > +               };
> > > > > > > > +
> > > > > > > > +               usbphy0: phy@10200000 {
> > > > > > > > +                       compatible =3D
> > "starfive,jh7110-usb-phy";
> > > > > > > > +                       reg =3D <0x0 0x10200000 0x0 0x10000=
>;
> > > > > > > > +                       clocks =3D <&syscrg
> > > > > > JH7110_SYSCLK_USB_125M>,
> > > > > > > > +                                <&stgcrg
> > > > > > JH7110_STGCLK_USB_APP_125>;
> > > > > > > > +                       clock-names =3D "125m", "app_125m";
> > > > > > > > +                       #phy-cells =3D <0>;
> > > > > > > > +               };
> > > > > > > > +
> > > > > > > > +               pciephy0: phy@10210000 {
> > > > > > > > +                       compatible =3D
> > "starfive,jh7110-pcie-phy";
> > > > > > > > +                       reg =3D <0x0 0x10210000 0x0 0x10000=
>;
> > > > > > > > +                       #phy-cells =3D <0>;
> > > > > > > > +               };
> > > > > > > > +
> > > > > > > > +               pciephy1: phy@10220000 {
> > > > > > > > +                       compatible =3D
> > "starfive,jh7110-pcie-phy";
> > > > > > > > +                       reg =3D <0x0 0x10220000 0x0 0x10000=
>;
> > > > > > > > +                       #phy-cells =3D <0>;
> > > > > > > > +               };
> > > > > > > > +
> > > > > > > >                 stgcrg: clock-controller@10230000 {
> > > > > > > >                         compatible =3D "starfive,jh7110-stg=
crg";
> > > > > > > >                         reg =3D <0x0 0x10230000 0x0 0x10000=
>;
> > > > > > > > --
> > > > > > > > 2.17.1
> > > > > > > >
> > > > > > >
> > > > > > > Access fault
> > > > > > >
> > > > > > >         starting USB...
> > > > > > >         Bus usb@0: cdns-usb3-host usb@0: set 1 has failed, ba=
ck to
> > 0
> > > > > > >         scanning bus usb@0 for devices... Unhandled exception=
:
> > > > > > > Load
> > > > > > access fault
> > > > > > >         EPC: 00000000fff85ce2 RA: 00000000fff85cdc TVAL:
> > > > > > 0000000000000004
> > > > > > >         EPC: 0000000040246ce2 RA: 0000000040246cdc reloc
> > > > > > > adjusted
> > > > > > >
> > > > > > >         Code: 9863 3ee7 8526 f0ef c37f 651c 3a03 0105 (43dc)
> > > > > > >
> > > > > > >
> > > > > > >         resetting ...
> > > > > > >
> > > > > > > when I add only these:
> > > > > > >
> > > > > > >         int offset;
> > > > > > >
> > > > > > >         offset =3D fdt_path_offset(fdt,
> > > > > > > "/soc/pinctrl@13040000"); /*
> > > > > > &sysgpio */
> > > > > > >         fdt_add_subnode(fdt, offset, "usb0-0");
> > > > > > >         fdt_setprop_string(fdt, fdt_path_offset(fdt,
> > > > > > > "/__symbols__"), "usb_pins", "/soc/pinctrl@13040000/usb0-0");
> > > > > > >         offset =3D fdt_path_offset(fdt,
> > > > > > > "/soc/pinctrl@13040000/usb0-0");
> > > > > > > /* usb_pins */
> > > > > > >         fdt_create_phandle(fdt, offset);
> > > > > > >         fdt_add_subnode(fdt, offset, "driver-vbus-pin");
> > > > > > >         offset =3D fdt_path_offset(fdt,
> > > > > > > "/soc/pinctrl@13040000/usb0-0/driver-vbus-pin");
> > > > > > >         fdt_setprop_u32(fdt, offset, "pinmux", 0xff070019); /=
*
> > > > > > > GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS, GPOEN_ENABLE,
> > > > GPI_NONE)
> > > > > > */
> > > > > > >         fdt_setprop_empty(fdt, offset, "bias-disable");
> > > > > > >         fdt_setprop_empty(fdt, offset, "input-disable");
> > > > > > >         fdt_setprop_empty(fdt, offset, "input-schmitt-disable=
");
> > > > > > >         fdt_setprop_u32(fdt, offset, "slew-rate", 0);
> > > > > > >
> > > > > > >         offset =3D fdt_path_offset(fdt, "/soc/usb@10100000");=
 /*
> > > > > > > &usb0
> > > > */
> > > > > > >         fdt_setprop_string(fdt, offset, "pinctrl-names", "def=
ault");
> > > > > > >         fdt_setprop_u32(fdt, offset, "pinctrl-0",
> > > > > > > fdt_get_phandle(fdt, fdt_path_offset(fdt,
> > > > "/soc/pinctrl@13040000/usb0-0")));
> > > > > > >         fdt_setprop_string(fdt, offset, "status", "okay");
> > > > > > >
> > > > > > >         offset =3D fdt_path_offset(fdt,
> > > > > > > "/soc/usb@10100000/usb@0");
> > > > > > > /*
> > > > > > > &usb_cdns3 */
> > > > > > >         fdt_setprop_string(fdt, offset, "dr_mode",   "host");
> > > > > > >
> > > > > > > Success USB is working but PCI disabled if instead I add all =
of this:
> > > > > > >
> > > >
> > > > > I checked t Milk-V CM board do not contain USB3.0 host So I think
> > > > > the USB 3.0 configuration is not required.
> > > >
> > > > I agree it should be USB 2.0, but with your patch this is the only
> > > > configuration that does anything successful with USB2.0 or 3.0
> > > >
> > > >
> > > > >
> > > > > > >         int offset;
> > > > > > >
> > > > > > >         offset =3D fdt_path_offset(fdt,
> > > > > > > "/soc/pinctrl@13040000"); /*
> > > > > > &sysgpio */
> > > > > > >         fdt_add_subnode(fdt, offset, "usb0-0");
> > > > > > >         fdt_setprop_string(fdt, fdt_path_offset(fdt,
> > > > > > > "/__symbols__"), "usb_pins", "/soc/pinctrl@13040000/usb0-0");
> > > > > > >         offset =3D fdt_path_offset(fdt,
> > > > > > > "/soc/pinctrl@13040000/usb0-0");
> > > > > > > /* usb_pins */
> > > > > > >         fdt_create_phandle(fdt, offset);
> > > > > > >         fdt_add_subnode(fdt, offset, "driver-vbus-pin");
> > > > > > >         offset =3D fdt_path_offset(fdt,
> > > > > > > "/soc/pinctrl@13040000/usb0-0/driver-vbus-pin");
> > > > > > >         fdt_setprop_u32(fdt, offset, "pinmux", 0xff070019); /=
*
> > > > > > > GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS, GPOEN_ENABLE,
> > > > GPI_NONE)
> > > > > > */
> > > > > > >         fdt_setprop_empty(fdt, offset, "bias-disable");
> > > > > > >         fdt_setprop_empty(fdt, offset, "input-disable");
> > > > > > >         fdt_setprop_empty(fdt, offset, "input-schmitt-disable=
");
> > > > > > >         fdt_setprop_u32(fdt, offset, "slew-rate", 0);
> > > > > > >
> > > > > > >         offset =3D fdt_path_offset(fdt, "/soc/pcie@2b000000")=
;
> > > > > > > /* &pcie0
> > > > */
> > > > > > >         fdt_setprop_string(fdt, offset, "status", "disabled")=
;
> > > > > > >
> > > > > > >         offset =3D fdt_path_offset(fdt, "/soc/phy@10210000");=
 /*
> > > > > > > &pciephy0
> > > > > > */
> > > > > > >         fdt_setprop_u32(fdt, offset, "starfive,sys-syscon",
> > > > > > > fdt_get_phandle(fdt, fdt_path_offset(fdt,
> > > > > > > "/soc/sys_syscon@13030000"))); /* =3D <&sys_syscon> */
> > > > > > >         fdt_appendprop_u32(fdt, offset, "starfive,sys-syscon"=
,
> > > > > > > 0x18);
> > > > > > > /* append <magic number> */
> > > > > > >         fdt_setprop_u32(fdt, offset, "starfive,stg-syscon",
> > > > > > > fdt_get_phandle(fdt, fdt_path_offset(fdt,
> > > > > > > "/soc/stg_syscon@10240000"))); /* =3D <&stg_syscon> */
> > > > > > >         fdt_appendprop_u32(fdt, offset, "starfive,stg-syscon"=
,
> > > > > > > 0x148);
> > > > > > > /* append <magic number> */
> > > > > > >         fdt_appendprop_u32(fdt, offset, "starfive,stg-syscon"=
,
> > > > > > > 0x1f4);
> > > > > > > /* append <magic number> */
> > > > > > >         fdt_setprop_string(fdt, offset, "status", "okay");
> > > > > > >
> > > > > > >         offset =3D fdt_path_offset(fdt, "/soc/usb@10100000");=
 /*
> > > > > > > &usb0
> > > > */
> > > > > > >         fdt_setprop_string(fdt, offset, "pinctrl-names", "def=
ault");
> > > > > > >         fdt_setprop_u32(fdt, offset, "pinctrl-0",
> > > > > > > fdt_get_phandle(fdt, fdt_path_offset(fdt,
> > > > "/soc/pinctrl@13040000/usb0-0")));
> > > > > > >         fdt_setprop_string(fdt, offset, "status", "okay");
> > > > > > >
> > > > > > >         offset =3D fdt_path_offset(fdt,
> > > > > > > "/soc/usb@10100000/usb@0");
> > > > > > > /*
> > > > > > > &usb_cdns3 */
> > > > > > >         fdt_setprop_u32(fdt,    offset, "phys",
> > > > > > > fdt_get_phandle(fdt, fdt_path_offset(fdt,
> > > > > > > "/soc/phy@10200000")));
> > > > > > > /* =3D <&usbphy0> */
> > > > > > >         fdt_appendprop_u32(fdt, offset, "phys",
> > > > > > > fdt_get_phandle(fdt, fdt_path_offset(fdt,
> > > > > > > "/soc/phy@10210000"))); /*
> > > > append <&pciephy0> */
> > > > > > >         fdt_setprop(fdt,        offset, "phy-names",
> > > > > > > "cdns3,usb2-phy\0cdns3,usb3-phy",
> > > > > > > sizeof("cdns3,usb2-phy\0cdns3,usb3-phy"));
> > > > > > >         fdt_setprop_string(fdt, offset, "dr_mode",   "host");
> > > > > > >
> > > > > > > I have made some mistake for devicetree and USB2.0 with
> > > > > > > keeping
> > > > > > > pcie0 (not disable)? or is there a problem with the implement=
ation?
> > > > > > >
> > > > > > > Best regards, -E Shattow
> > > > > >
> > > >
> > > > > I don=E2=80=99t have a Milk-V CM board. So I just can test this c=
ode to Star64.
> > > > > Thanks. I will test this and add the code to board_fixup_star64()=
.
> > > >
> > > > Can you try to configure in USB2.0-only mode on Star64?  Do you see
> > > > the same problem with "load access fault"?
> > > >
> > > Yes =EF=BC=8CUSB 2.0 only can work.
> > > > ...snip...
> > > >
> > > > Same devicetree fixup code but separated some of the statements to
> > > > multiple
> > > > lines:
> > > >
> > > > https://paste.debian.net/1324036/
> > > >
> > > > ```
> > > Now I can see the issue,Usb 2.0 host can work in Milk-V CM, but PCIe =
can not
> > work.
> > > Is that correct?
> > > The PCIe in CM board is PCIe0=EF=BC=8C The PCIe1 is not used. So I th=
ink
> > > disable PCIe1 node and just set USB 2.0 to host is OK.
> > > milkV CM PCIe0 setting is the same with VisionFive v2.
> > > The USB 3.0 setting should not be added.
> > >
> > > This USB 3.0 setting. Should NOT be added to Milk-V CM board.
> > > &pciephy0 {
> > >         starfive,sys-syscon =3D <&sys_syscon 0x18>;
> > >         starfive,stg-syscon =3D <&stg_syscon 0x148 0x1f4>;
> > >         status =3D "okay";
> > > };
> > >
> > > &usb_cdns3 {
> > >         phys =3D <&usbphy0>, <&pciephy0>;
> > >         phy-names =3D "cdns3,usb2-phy", "cdns3,usb3-phy";
> > >         dr_mode =3D "host";
> > >         status =3D "okay";
> > > };
> > >
> >
> > Here is Mars CM Lite:
> >
> > StarFive # pci
> > BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
> > _____________________________________________________________
> > 00.00.00   0x1556     0x1111     Bridge device           0x04
> > 01.00.00   0x10ec     0x8168     Network controller      0x00
> > 02.00.00   0x1556     0x1111     Bridge device           0x04
> >
> > This is the DFRobot Mini Router carrier and the Mars CM Lite.  There is=
 a
> > network interface connected to PCIe.
> >
> > When I apply this fixup:
> >
> > void spl_fdt_fixup_jh7110_cadence_usb2_host(void *fdt) {
> >         int offset;
> >         u32 phandle;
> >
> >         offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000"); /* &s=
ysgpio
> > */
> >         fdt_add_subnode(fdt, offset, "usb0-0");
> >         fdt_setprop_string(fdt, fdt_path_offset(fdt, "/__symbols__"),
> > "usb_pins", "/soc/pinctrl@13040000/usb0-0");
> >         offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0")=
;
> > /* usb_pins */
> >         fdt_create_phandle(fdt, offset);
> >         fdt_add_subnode(fdt, offset, "driver-vbus-pin");
> >         offset =3D fdt_path_offset(fdt,
> > "/soc/pinctrl@13040000/usb0-0/driver-vbus-pin");
> >         fdt_setprop_u32(fdt, offset, "pinmux", 0xff070019); /* GPIOMUX(=
25,
> > GPOUT_SYS_USB_DRIVE_VBUS, GPOEN_ENABLE, GPI_NONE) */
> >         fdt_setprop_empty(fdt, offset, "bias-disable");
> >         fdt_setprop_empty(fdt, offset, "input-disable");
> >         fdt_setprop_empty(fdt, offset, "input-schmitt-disable");
> >         fdt_setprop_u32(fdt, offset, "slew-rate", 0);
> >
> >         offset =3D fdt_path_offset(fdt, "/soc/pcie@2c000000"); /* &pcie=
1 */
> >         fdt_setprop_string(fdt, offset, "status", "disabled");
> >
> >         offset =3D fdt_path_offset(fdt, "/soc/usb@10100000"); /* &usb0 =
*/
> >         fdt_setprop_string(fdt, offset, "pinctrl-names", "default");
> >         phandle =3D fdt_get_phandle(fdt, fdt_path_offset(fdt,
> > "/soc/pinctrl@13040000/usb0-0")); /* <&usb_pins> */
> >         fdt_setprop_u32(fdt, offset, "pinctrl-0", phandle);
> >         fdt_setprop_string(fdt, offset, "status", "okay");
> >
> >         offset =3D fdt_path_offset(fdt, "/soc/usb@10100000/usb@0"); /*
> > &usb_cdns3 */
> >         fdt_setprop_string(fdt, offset, "dr_mode", "host"); }
> >
> > at the last instruction of spl_fdt_fixup_mars_cm() then there is this e=
rror I am
> > telling you about:
> >
> > U-Boot 2024.07-00971-g8eed381de5ef-dirty (Jul 23 2024 - 05:49:09 -0700)
> >
> > CPU:   sifive,u74-mc
> > Model: Milk-V Mars CM Lite
> > DRAM:  4 GiB
> > Core:  139 devices, 29 uclasses, devicetree: board
> > WDT:   Not starting watchdog@13070000
> > MMC:   mmc@16010000: 0, mmc@16020000: 1
> > Loading Environment from SPIFlash... SF: Detected gd25lq128 with page s=
ize
> > 256 Bytes, erase size 4 KiB, total 16 MiB OK StarFive EEPROM format v2
> >
> > --------EEPROM INFO--------
> > Vendor : MILK-V
> > Product full SN: MARC-V10-2340-D004E000-000006DF data version: 0x2 PCB
> > revision: 0xc1 BOM revision: A Ethernet MAC0 address: 6c:cf:39:00:83:11
> > Ethernet MAC1 address: 6c:cf:39:00:83:12 --------EEPROM INFO--------
> >
> > starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
> > PCI: Failed autoconfig bar 10
> > In:    serial@10000000
> > Out:   serial@10000000
> > Err:   serial@10000000
> > Net:   eth0: ethernet@16030000
> > Error: eth_rtl8169 No valid MAC address found.
> >
> > starting USB...
> > Bus usb@0: cdns-usb3-host usb@0: set 1 has failed, back to 0 scanning b=
us
> > usb@0 for devices... Unhandled exception: Load access fault
> > EPC: 00000000fff85b2e RA: 00000000fff85b28 TVAL: 0000000000000004
> > EPC: 0000000040246b2e RA: 0000000040246b28 reloc adjusted
> >
> > Code: 9863 3ee7 8526 f0ef c37f 651c 3a03 0105 (43dc)
> >
> >
> > resetting ...
> >
> > (C)StarFive
> > CCC
> I can reproduce USB 2.0 only on Star64 now. I know this.
> Next version I will fix this.

I follow the "load access fault" problem to
drivers/usb/host/usb-uclass.c: err =3D ops->control(bus, udev, pipe,
buffer, length, setup);

ops->control has the value set from drivers/usb/host/xhci.c:

struct dm_usb_ops xhci_usb_ops =3D {
      .control =3D xhci_submit_control_msg,
...

I verify this by assigning a unique value to xhci_usb_ops.control and
printf from submit_control_msg() in drivers/usb/host/usb-uclass.c and
the value is the same.

So why does this cause a load access fault when calling this function
pointer of &xhci_submit_control_msg, but just when we are having a
problem in the Cadence USB wrapper with USB2.0-only, and not USB3.0?

The load access fault is a problem because it is a crash / halt and
nothing else can be done, and so after then a different U-Boot must be
flashed with a recovery method.

I think the USB2.0-only problem is different, but anyway it should not
be possible to crash U-Boot this way. How is this possible?

>
> You can test with this patch to check whether can fix this.
>
> diff --git a/drivers/phy/starfive/phy-jh7110-usb2.c b/drivers/phy/starfiv=
e/phy-jh7110-usb2.c
> index d48c9f8a74..a09fb2efea 100644
> --- a/drivers/phy/starfive/phy-jh7110-usb2.c
> +++ b/drivers/phy/starfive/phy-jh7110-usb2.c
> @@ -116,7 +116,7 @@ int jh7110_usb2_phy_probe(struct udevice *dev)
>                 dev_err(dev, "Failed to get app 125m clock\n");
>                 return PTR_ERR(phy->app_125m);
>         }
> -
> +       writel(BIT(17), 0x13030018);
>         return 0;
>  }
>

Yes, adding the writel() this avoids the load access fault for Mars CM
Lite, and USB with also PCIe are active:

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

StarFive # pci;usb tree
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
00.00.00   0x1556     0x1111     Bridge device           0x04
01.00.00   0x10ec     0x8168     Network controller      0x00
02.00.00   0x1556     0x1111     Bridge device           0x04
USB device tree:
  1  Hub (5 Gb/s, 0mA)
     U-Boot XHCI Host Controller

The output text says USB 3.0, and 5Gb/s speeds, which is probably
wrong for USB 2.0 but anyway I was able to usb stop;usb start for a
storage device and it reports 480Mb/s:

StarFive # usb tree
USB device tree:
  1  Hub (5 Gb/s, 0mA)
  |  U-Boot XHCI Host Controller
  |
  +-2  Mass Storage (480 Mb/s, 500mA)
       Kingston UHS-II SD Reader 202006003857

StarFive # usb info
1: Hub,  USB Revision 3.0
 - U-Boot XHCI Host Controller
 - Class: Hub
 - PacketSize: 512  Configurations: 1
 - Vendor: 0x0000  Product 0x0000 Version 1.0
   Configuration: 1
   - Interfaces: 1 Self Powered 0mA
     Interface: 0
     - Alternate Setting 0, Endpoints: 1
     - Class Hub
     - Endpoint 1 In Interrupt MaxPacket 8 Interval 255ms

2: Mass Storage,  USB Revision 2.10
 - Kingston UHS-II SD Reader 202006003857
 - Class: (from Interface) Mass Storage
 - PacketSize: 64  Configurations: 1
 - Vendor: 0x11b0  Product 0x3306 Version 0.3
   Configuration: 1
   - Interfaces: 1 Bus Powered 500mA
     Interface: 0
     - Alternate Setting 0, Endpoints: 2
     - Class Mass Storage, Transp. SCSI, Bulk only
     - Endpoint 1 In Bulk MaxPacket 512
     - Endpoint 2 Out Bulk MaxPacket 512

StarFive # load usb 0:2 $loadaddr /boot/initrd.img-6.9.8-riscv64
46072333 bytes read in 2760 ms (15.9 MiB/s)

However, when Linux kernel is loaded using U-Boot internal fdt there
is USB but not any PCIe active:

# lspci -v; lsusb -v

Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 [unknown]
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0002 2.0 root hub
  bcdDevice            6.10
  iManufacturer           3 Linux 6.10.0-jh7110 xhci-hcd
  iProduct                2 xHCI Host Controller
  iSerial                 1 xhci-hcd.0.auto
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0019
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 [unknown]
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             1
  wHubCharacteristic 0x0009
    Per-port power switching
    Per-port overcurrent protection
    TT think time 8 FS bits
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0100 power
Device Status:     0x0001
  Self Powered

Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 [unknown]
  bDeviceProtocol         3
  bMaxPacketSize0         9
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0003 3.0 root hub
  bcdDevice            6.10
  iManufacturer           3 Linux 6.10.0-jh7110 xhci-hcd
  iProduct                2 xHCI Host Controller
  iSerial                 1 xhci-hcd.0.auto
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x001f
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 [unknown]
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12
        bMaxBurst               0
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength       0x000f
  bNumDeviceCaps          1
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x02
      Latency Tolerance Messages (LTM) Supported
    wSpeedsSupported   0x0008
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   1
      Lowest fully-functional device speed is Full Speed (12Mbps)
    bU1DevExitLat           0 micro seconds
    bU2DevExitLat           0 micro seconds
Hub Descriptor:
  bLength              12
  bDescriptorType      42
  nNbrPorts             1
  wHubCharacteristic 0x0009
    Per-port power switching
    Per-port overcurrent protection
  bPwrOn2PwrGood       50 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  bHubDecLat          0.0 micro seconds
  wHubDelay             0 nano seconds
  DeviceRemovable    0x00
 Hub Port Status:
   Port 1: 0000.02a0 5Gbps power Rx.Detect
Device Status:     0x0001
  Self Powered

The USB storage device is not listed, this is because U-Boot was
trying to boot from the storage :-)  so I remove it.

If I do not have USB devicetree nodes in fixup then it is like this
with PCIe active:

# lspci -v; lsusb -v
0000:00:00.0 PCI bridge: PLDA XpressRich-AXI Ref Design (rev 02)
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 40
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
0
        Memory behind bridge: 30000000-300fffff [size=3D1M] [32-bit]
        Capabilities: [80] Express Root Port (Slot+), IntMsgNum 0
        Capabilities: [e0] MSI: Enable+ Count=3D1/32 Maskable+ 64bit+
        Capabilities: [f8] Power Management version 3
        Capabilities: [100] Vendor Specific Information: ID=3D1556 Rev=3D1
Len=3D008 <?>
        Capabilities: [200] Advanced Error Reporting
        Kernel driver in use: pcieport

0000:01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev
15)
        Subsystem: Realtek Semiconductor Co., Ltd. RTL8111/8168 PCI
Express Gigabit Ethernet controller
        Flags: fast devsel, IRQ 39
        Memory at 30004000 (64-bit, non-prefetchable) [size=3D4K]
        Memory at 30000000 (64-bit, non-prefetchable) [size=3D16K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
        Capabilities: [70] Express Endpoint, IntMsgNum 1
        Capabilities: [b0] MSI-X: Enable+ Count=3D4 Masked-
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel
        Capabilities: [160] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [170] Latency Tolerance Reporting
        Capabilities: [178] L1 PM Substates
        Kernel driver in use: r8169
        Kernel modules: r8169

0001:00:00.0 PCI bridge: PLDA XpressRich-AXI Ref Design (rev 02)
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 59
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
0
        Memory behind bridge: [disabled] [32-bit]
        Capabilities: [80] Express Root Port (Slot+), IntMsgNum 0
        Capabilities: [e0] MSI: Enable+ Count=3D1/32 Maskable+ 64bit+
        Capabilities: [f8] Power Management version 3
        Capabilities: [100] Vendor Specific Information: ID=3D1556 Rev=3D1
Len=3D008 <?>
        Capabilities: [200] Advanced Error Reporting
        Kernel driver in use: pcieport

There is more to do for changing to USB2.0-only and also keep PCIe ?

Thank you Minda.   -E
