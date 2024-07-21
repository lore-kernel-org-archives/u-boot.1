Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9501DC3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 18:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96D6087D6B;
	Sun, 21 Jul 2024 20:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UhIoU+D+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51EAC86DBD; Sun, 21 Jul 2024 20:27:36 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B48E387F51
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 20:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52f042c15e3so105156e87.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 11:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721586453; x=1722191253; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j9ocxDhHjpzhe+GksOU/1BU79CxMR5pPjqc9VX+0YYM=;
 b=UhIoU+D+5LDyjxeGIGa+uQZcpz2ZKa9F5m6clcUagRLQaZNiDPgvIgtG9NY1oXZzpe
 NOGNaHETa08nZGu10NInsQKfesw/IAYVCssl+CXif4PUuuHjoXds3cjfk2uPbddw/Gz6
 qhOirH274LgMTy5ixxK48qjrPetTH2x9SgBwvaI6y9lgrNvwFEQeyNFH1VKsYa8e95E6
 4X6FmROUT9Z4cvmXqAYnrWm5PgTylKlWuu+ugN/yYWu7eyMDoobl52bcJ7lrFFv8Jwiv
 QMFDoXUoS3ibSQ2fZQaTX+/BVXStFyw8M8XTV6xz1E+k4FuwX8oH76MYgbjmyCzOhMHb
 BLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721586453; x=1722191253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j9ocxDhHjpzhe+GksOU/1BU79CxMR5pPjqc9VX+0YYM=;
 b=wfT8CUnm/Q4KWE/dUUpItX14CgnsqPxKnf01sZgaBZafH9coRZ9JNrYKMY26c2vi+Z
 /h/M0ogtgmk4GA4fwxybHf4fkDqVKx1CYVkjhWREAgGN6Edh3VWhuWpQApLZoBjW5ihq
 BeqSXzAyWetEHO9RHfIXFjDrCb99yJv3rIVr/uixIruUF0eQjtq883rEudSzW2NKLP32
 XXIh3HumkA9WGdWdgjp1hQ9DbdVouu+5ADtkzoqe9dGHXvigiJxdpLmB8EHryt+v4AOm
 YTmMDrnuTgnZS3PQMir9ZbFP7mRxuRL1kgmZpyxvyUUe/kfYf66wGqmGjYno1i9JYS/K
 zhRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUalNuo62RLdlZ6NC+nFxSNlj0VtQYyXbFdS65lsskzT7DzMyU6fUU4/0YG9VGpbJK45AllVDhQRIlLVcjakp3bEm3kWQ==
X-Gm-Message-State: AOJu0YzgNlu8GHtqivTYZo5DyO0ZoSGUAFgwc//4XlVeInU8XbLz3Diz
 jYqkuSRCjIObndhclJh6YQU24cdA+XiiAkzbnQ0gVNOJTfzTbylO7Jx/SOiLUCERLaJmg1OgBQ4
 xuExiIVEZ0lCy2vfGNIEQ7TXO7Uc=
X-Google-Smtp-Source: AGHT+IENpa2BmgnaelUtWONZSwxnZ1AebokLYuhBHbywxy6rKfpAjNYOQDjK1XAwuRnxtI7xVgtzQHBVhk4DSF/UoUE=
X-Received: by 2002:a05:6512:3342:b0:52e:fa78:63c0 with SMTP id
 2adb3069b0e04-52efa7866d0mr1050005e87.13.1721586452500; Sun, 21 Jul 2024
 11:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240719013822.101374-1-minda.chen@starfivetech.com>
 <20240719013822.101374-8-minda.chen@starfivetech.com>
 <CANV2PTOXmm4a4+_94iKoGTAY5-kiym3xwYF77upXdu8KmLKv+Q@mail.gmail.com>
In-Reply-To: <CANV2PTOXmm4a4+_94iKoGTAY5-kiym3xwYF77upXdu8KmLKv+Q@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Sun, 21 Jul 2024 11:27:21 -0700
Message-ID: <CANV2PTPv9v9h0LW08qQq-cU3XJQBhs3Lz-w691CV3=5u7gh=_A@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] dts: starfive: Add JH7110 Cadence USB dts node
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, 
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 u-boot@lists.denx.de, 
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

On Sat, Jul 20, 2024 at 6:47=E2=80=AFPM E Shattow <lucent@gmail.com> wrote:
>
> Hi, I am testing on Milk-V Mars CM Lite, and I add to these devicetree
> changes at runtime from board/starfive/visionfive2/spl.c
>
> On Thu, Jul 18, 2024 at 6:38=E2=80=AFPM Minda Chen <minda.chen@starfivete=
ch.com> wrote:
> >
> > Add Jh7110 Cadence USB dts node, Visionfive2 default setting
> > is USB 2.0 device.
> >
> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > ---
> >  .../dts/jh7110-starfive-visionfive-2.dtsi     |  5 ++
> >  arch/riscv/dts/jh7110.dtsi                    | 52 +++++++++++++++++++
> >  2 files changed, 57 insertions(+)
> >
> > diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/ri=
scv/dts/jh7110-starfive-visionfive-2.dtsi
> > index e11babc1cd..44785bbee3 100644
> > --- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > @@ -378,3 +378,8 @@
> >                 };
> >         };
> >  };
> > +
> > +&usb_cdns3 {
> > +       dr_mode =3D "peripheral";
> > +       status =3D "okay";
> > +};
> > diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
> > index 2cdc683d49..1eee924e1d 100644
> > --- a/arch/riscv/dts/jh7110.dtsi
> > +++ b/arch/riscv/dts/jh7110.dtsi
> > @@ -371,6 +371,58 @@
> >                         status =3D "disabled";
> >                 };
> >
> > +               usb0: usb@10100000 {
> > +                       compatible =3D "starfive,jh7110-usb";
> > +                       ranges =3D <0x0 0x0 0x10100000 0x100000>;
> > +                       #address-cells =3D <1>;
> > +                       #size-cells =3D <1>;
> > +                       starfive,stg-syscon =3D <&stg_syscon 0x4>;
> > +                       clocks =3D <&stgcrg JH7110_STGCLK_USB_LPM>,
> > +                                <&stgcrg JH7110_STGCLK_USB_STB>,
> > +                                <&stgcrg JH7110_STGCLK_USB_APB>,
> > +                                <&stgcrg JH7110_STGCLK_USB_AXI>,
> > +                                <&stgcrg JH7110_STGCLK_USB_UTMI_APB>;
> > +                       clock-names =3D "lpm", "stb", "apb", "axi", "ut=
mi_apb";
> > +                       resets =3D <&stgcrg JH7110_STGRST_USB_PWRUP>,
> > +                                <&stgcrg JH7110_STGRST_USB_APB>,
> > +                                <&stgcrg JH7110_STGRST_USB_AXI>,
> > +                                <&stgcrg JH7110_STGRST_USB_UTMI_APB>;
> > +                       reset-names =3D "pwrup", "apb", "axi", "utmi_ap=
b";
> > +
> > +                       usb_cdns3: usb@0 {
> > +                               compatible =3D "cdns,usb3";
> > +                               reg =3D <0x0 0x10000>,
> > +                                     <0x10000 0x10000>,
> > +                                     <0x20000 0x10000>;
> > +                               reg-names =3D "otg", "xhci", "dev";
> > +                               interrupts =3D <100>, <108>, <110>;
> > +                               interrupt-names =3D "host", "peripheral=
", "otg";
> > +                               phys =3D <&usbphy0>;
> > +                               phy-names =3D "cdns3,usb2-phy";
> > +                       };
> > +               };
> > +
> > +               usbphy0: phy@10200000 {
> > +                       compatible =3D "starfive,jh7110-usb-phy";
> > +                       reg =3D <0x0 0x10200000 0x0 0x10000>;
> > +                       clocks =3D <&syscrg JH7110_SYSCLK_USB_125M>,
> > +                                <&stgcrg JH7110_STGCLK_USB_APP_125>;
> > +                       clock-names =3D "125m", "app_125m";
> > +                       #phy-cells =3D <0>;
> > +               };
> > +
> > +               pciephy0: phy@10210000 {
> > +                       compatible =3D "starfive,jh7110-pcie-phy";
> > +                       reg =3D <0x0 0x10210000 0x0 0x10000>;
> > +                       #phy-cells =3D <0>;
> > +               };
> > +
> > +               pciephy1: phy@10220000 {
> > +                       compatible =3D "starfive,jh7110-pcie-phy";
> > +                       reg =3D <0x0 0x10220000 0x0 0x10000>;
> > +                       #phy-cells =3D <0>;
> > +               };
> > +
> >                 stgcrg: clock-controller@10230000 {
> >                         compatible =3D "starfive,jh7110-stgcrg";
> >                         reg =3D <0x0 0x10230000 0x0 0x10000>;
> > --
> > 2.17.1
> >
>
> Access fault
>
>         starting USB...
>         Bus usb@0: cdns-usb3-host usb@0: set 1 has failed, back to 0
>         scanning bus usb@0 for devices... Unhandled exception: Load acces=
s fault
>         EPC: 00000000fff85ce2 RA: 00000000fff85cdc TVAL: 0000000000000004
>         EPC: 0000000040246ce2 RA: 0000000040246cdc reloc adjusted
>
>         Code: 9863 3ee7 8526 f0ef c37f 651c 3a03 0105 (43dc)
>
>
>         resetting ...
>
> when I add only these:
>
>         int offset;
>
>         offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000"); /* &sys=
gpio */
>         fdt_add_subnode(fdt, offset, "usb0-0");
>         fdt_setprop_string(fdt, fdt_path_offset(fdt, "/__symbols__"),
> "usb_pins", "/soc/pinctrl@13040000/usb0-0");
>         offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0");
> /* usb_pins */
>         fdt_create_phandle(fdt, offset);
>         fdt_add_subnode(fdt, offset, "driver-vbus-pin");
>         offset =3D fdt_path_offset(fdt,
> "/soc/pinctrl@13040000/usb0-0/driver-vbus-pin");
>         fdt_setprop_u32(fdt, offset, "pinmux", 0xff070019); /*
> GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS, GPOEN_ENABLE, GPI_NONE) */
>         fdt_setprop_empty(fdt, offset, "bias-disable");
>         fdt_setprop_empty(fdt, offset, "input-disable");
>         fdt_setprop_empty(fdt, offset, "input-schmitt-disable");
>         fdt_setprop_u32(fdt, offset, "slew-rate", 0);
>
>         offset =3D fdt_path_offset(fdt, "/soc/usb@10100000"); /* &usb0 */
>         fdt_setprop_string(fdt, offset, "pinctrl-names", "default");
>         fdt_setprop_u32(fdt, offset, "pinctrl-0", fdt_get_phandle(fdt,
> fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0")));
>         fdt_setprop_string(fdt, offset, "status", "okay");
>
>         offset =3D fdt_path_offset(fdt, "/soc/usb@10100000/usb@0"); /*
> &usb_cdns3 */
>         fdt_setprop_string(fdt, offset, "dr_mode",   "host");
>
> Success USB is working but PCI disabled if instead I add all of this:
>
>         int offset;
>
>         offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000"); /* &sys=
gpio */
>         fdt_add_subnode(fdt, offset, "usb0-0");
>         fdt_setprop_string(fdt, fdt_path_offset(fdt, "/__symbols__"),
> "usb_pins", "/soc/pinctrl@13040000/usb0-0");
>         offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0");
> /* usb_pins */
>         fdt_create_phandle(fdt, offset);
>         fdt_add_subnode(fdt, offset, "driver-vbus-pin");
>         offset =3D fdt_path_offset(fdt,
> "/soc/pinctrl@13040000/usb0-0/driver-vbus-pin");
>         fdt_setprop_u32(fdt, offset, "pinmux", 0xff070019); /*
> GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS, GPOEN_ENABLE, GPI_NONE) */
>         fdt_setprop_empty(fdt, offset, "bias-disable");
>         fdt_setprop_empty(fdt, offset, "input-disable");
>         fdt_setprop_empty(fdt, offset, "input-schmitt-disable");
>         fdt_setprop_u32(fdt, offset, "slew-rate", 0);
>
>         offset =3D fdt_path_offset(fdt, "/soc/pcie@2b000000"); /* &pcie0 =
*/
>         fdt_setprop_string(fdt, offset, "status", "disabled");
>
>         offset =3D fdt_path_offset(fdt, "/soc/phy@10210000"); /* &pciephy=
0 */
>         fdt_setprop_u32(fdt, offset, "starfive,sys-syscon",
> fdt_get_phandle(fdt, fdt_path_offset(fdt,
> "/soc/sys_syscon@13030000"))); /* =3D <&sys_syscon> */
>         fdt_appendprop_u32(fdt, offset, "starfive,sys-syscon", 0x18);
> /* append <magic number> */
>         fdt_setprop_u32(fdt, offset, "starfive,stg-syscon",
> fdt_get_phandle(fdt, fdt_path_offset(fdt,
> "/soc/stg_syscon@10240000"))); /* =3D <&stg_syscon> */
>         fdt_appendprop_u32(fdt, offset, "starfive,stg-syscon", 0x148);
> /* append <magic number> */
>         fdt_appendprop_u32(fdt, offset, "starfive,stg-syscon", 0x1f4);
> /* append <magic number> */
>         fdt_setprop_string(fdt, offset, "status", "okay");
>
>         offset =3D fdt_path_offset(fdt, "/soc/usb@10100000"); /* &usb0 */
>         fdt_setprop_string(fdt, offset, "pinctrl-names", "default");
>         fdt_setprop_u32(fdt, offset, "pinctrl-0", fdt_get_phandle(fdt,
> fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0")));
>         fdt_setprop_string(fdt, offset, "status", "okay");
>
>         offset =3D fdt_path_offset(fdt, "/soc/usb@10100000/usb@0"); /*
> &usb_cdns3 */
>         fdt_setprop_u32(fdt,    offset, "phys",
> fdt_get_phandle(fdt, fdt_path_offset(fdt, "/soc/phy@10200000"))); /* =3D
> <&usbphy0> */
>         fdt_appendprop_u32(fdt, offset, "phys",
> fdt_get_phandle(fdt, fdt_path_offset(fdt, "/soc/phy@10210000"))); /*
> append <&pciephy0> */
>         fdt_setprop(fdt,        offset, "phy-names",
> "cdns3,usb2-phy\0cdns3,usb3-phy",
> sizeof("cdns3,usb2-phy\0cdns3,usb3-phy"));
>         fdt_setprop_string(fdt, offset, "dr_mode",   "host");
>
> I have made some mistake for devicetree and USB2.0 with keeping pcie0
> (not disable)? or is there a problem with the implementation?
>
> Best regards, -E Shattow

P.S. here is with debug logging:

drivers/core/ofnode.c:517-    ofnode_read_prop() ofnode_read_prop:
assigned-clock-rates: <not found>
drivers/core/uclass.c:537-uclass_get_device_by_ofnode() Looking for phy@102=
00000
drivers/core/uclass.c:388-uclass_find_device_by_ofnode() Looking for
phy@10200000
drivers/core/uclass.c:407-uclass_find_device_by_ofnode()    - result
for phy@10200000: phy@10200000 (ret=3D0)
drivers/core/uclass.c:540-uclass_get_device_by_ofnode()    - result
for phy@10200000: phy@10200000 (ret=3D0)
drivers/core/ofnode.c:517-    ofnode_read_prop() ofnode_read_prop:
assigned-clock-rates: <not found>
drivers/core/uclass.c:537-uclass_get_device_by_ofnode() Looking for
clock-controller@13020000
drivers/core/uclass.c:388-uclass_find_device_by_ofnode() Looking for
clock-controller@13020000
drivers/core/uclass.c:407-uclass_find_device_by_ofnode()    - result
for clock-controller@13020000: clock-controller@13020000 (ret=3D0)
drivers/core/uclass.c:540-uclass_get_device_by_ofnode()    - result
for clock-controller@13020000: clock-controller@13020000 (ret=3D0)
drivers/core/uclass.c:537-uclass_get_device_by_ofnode() Looking for
clock-controller@10230000
drivers/core/uclass.c:388-uclass_find_device_by_ofnode() Looking for
clock-controller@10230000
drivers/core/uclass.c:407-uclass_find_device_by_ofnode()    - result
for clock-controller@10230000: clock-controller@10230000 (ret=3D0)
drivers/core/uclass.c:540-uclass_get_device_by_ofnode()    - result
for clock-controller@10230000: clock-controller@10230000 (ret=3D0)
common/event.c:113-      notify_dynamic() Sending event 5/(unknown) to
spy 'efi_disk add'
drivers/usb/cdns3/drd.c:287-      cdns3_drd_init() cdns-usb3-host
usb@0: DRD version v1 (ID: 0004024e, rev: 00000200)
drivers/usb/cdns3/drd.c:297-      cdns3_drd_init() cdns-usb3-host
usb@0: Controller strapped to HOST
drivers/core/ofnode.c:517-    ofnode_read_prop() ofnode_read_prop: dr_mode:=
 host
drivers/phy/starfive/phy-jh7110-usb2.c:58-   usb2_phy_set_mode()
jh7110_usb2_phy phy@10200000: Changing phy to 1
drivers/usb/cdns3/core.c:304-cdns3_hw_role_switch() cdns-usb3-host
usb@0: Switching role 0 -> 1cdns-usb3-host usb@0: Waiting till Host
mode is turned on
drivers/usb/cdns3/core.c:309-cdns3_hw_role_switch() cdns-usb3-host
usb@0: set 1 has failed, back to 0
drivers/usb/cdns3/core.c:375-         cdns3_probe() cdns-usb3-host
usb@0: Cadence USB3 core: probe succeed
common/event.c:113-      notify_dynamic() Sending event 5/(unknown) to
spy 'efi_disk add'
drivers/core/ofnode.c:394-ofnode_read_u32_index()
ofnode_read_u32_index: companion: (not found)
scanning bus usb@0 for devices... Unhandled exception: Load access fault
EPC: 00000000fff7f50e RA: 00000000fff7f508 TVAL: 0000000000000004
EPC: 000000004024d50e RA: 000000004024d508 reloc adjusted

Code: 9863 3ee7 8526 f0ef c37f 651c 3a03 0105 (43dc)


resetting ...

-E
