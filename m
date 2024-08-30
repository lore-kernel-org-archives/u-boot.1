Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5249FCA0ED4
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 03:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58C7288D1F;
	Fri, 30 Aug 2024 05:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bs6jkPu5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C8C988D52; Fri, 30 Aug 2024 05:31:08 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E6B988B89
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 05:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5334879ba28so1812192e87.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 20:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724988666; x=1725593466; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WP/jDgrRXDbe7s39HkLdIlp/vk30RGBYEKf8HcC0oPo=;
 b=bs6jkPu56VE3sWAQxlBev5peMFV9hPg69k/GNvkc5KWn3GWBUSCiTRckM5DbfnOLrq
 CqR+ZwSgKUchJhW4tAKfETg1kGKE/1GH3uBk+EjdQXWKVWOxT7T9cYR6AORVdv/xO4jb
 tpPXO8brl3/EdEtauQn/MDA0fXUuef1bfAOdGSYhwnYkFQZJpyUZDcF7J7xYYRj/LT73
 Hy/jgnT0mHgn9WyBpvzGy++1v40oJk810TRhDujWtO/lk8bgB8N2yjHGdS7oDI08sFGM
 CKFgON1LldRgJdnPR83QGO1xIcdxj7YiVyaELwwd6RuvABzaY7xwQGyIPQ0KUtbO/+d7
 oqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724988666; x=1725593466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WP/jDgrRXDbe7s39HkLdIlp/vk30RGBYEKf8HcC0oPo=;
 b=Ou3xAiyC5e4R13gX66Dps+jgruKqF/Ax6aNMM4Ds+TtfU2BFopiVSwTrKB9493nGHT
 wEkQtuPsWsxVwLilBScI+OjrSx2gAI8QlXjxA+S1GO9Dx6qUeTZ4g6dyT5X2OorBkGBH
 gcBFYzk2s3hrT4sNrsgGiKD8WdopWScqfMhWp+47JaQQd2DZSeNNGgIac2qStc2qfYZx
 k5O4FaaeYlHzM24HHuj1OAvcdGjazBXsW+z/dC3gHxxcB/HJK1DcMDZuvH+njTjcCIUp
 cIKCT5R7dJ7zpgumrHUoUm7Efx/aF3zU/2pxbtD9DX8Gz6LCm7au19Y05Yxb+lXGc6sl
 /7zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/0qWfCQp1DGRpq0tAX+x1PkbGyXxjpIHfE6ZcwGY10kQDrFwrgazDi+YPzj/HHEDw3Ow7GPQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyTgfyb+LlfOETQLJEIguCsBPRHWcpbzrhQztC8qxW0VHjaYRO2
 4TUh+NIGDxTbaov/XeKdDDRmncD58DHb90ORWRioILMcvmZ/+J+unH1Pp8ASassj1swH+9z6Vky
 iO4QoTBoz6AI9ADefxHV/dHHLfbo=
X-Google-Smtp-Source: AGHT+IENWsfEeSJHDz5RqYMIp3UWLitaw1SLPPz3zUd9OyZcifje6yMVRUKPgCtiUPn3T+/0WbNVjNaoNNw2goCq8g8=
X-Received: by 2002:a05:6512:12cd:b0:52e:9619:e26a with SMTP id
 2adb3069b0e04-53546b2d558mr334102e87.26.1724988665300; Thu, 29 Aug 2024
 20:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
 <20240829013058.6178-9-minda.chen@starfivetech.com>
In-Reply-To: <20240829013058.6178-9-minda.chen@starfivetech.com>
From: E Shattow <lucent@gmail.com>
Date: Thu, 29 Aug 2024 20:30:54 -0700
Message-ID: <CANV2PTODcMvj9RkwBFvBZAf_uTSBiuyb2Hz3iqo4vG+juQaspg@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] spl: starfive: star64: Setup USB fdt fixup function
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
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

Hi Minda,

On Wed, Aug 28, 2024 at 6:31=E2=80=AFPM Minda Chen <minda.chen@starfivetech=
.com> wrote:
>
> Setup star64 USB fdt fixup function. Set dr_mode to host,
> and add vbus pin (GPIO25), and set USB 3.0 mode.
> the functions can be used by other 7110 board like Milk-V
> board.
>
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  board/starfive/visionfive2/spl.c | 66 ++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive=
2/spl.c
> index 388a06e4d9..b3034b19a3 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -123,6 +123,69 @@ static const struct starfive_vf2_pro star64_pine64[]=
 =3D {
>                 "tx-internal-delay-ps", "300"},
>  };
>
> +static void spl_fdt_fixup_usb_vbus_pin(void *fdt, int pin)
> +{
> +       int offset, pin_offset;
> +
> +       offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000"); /* &sys=
gpio */
> +       fdt_add_subnode(fdt, offset, "usb0-0");
> +       fdt_setprop_string(fdt, fdt_path_offset(fdt, "/__symbols__"),
> +                          "usb_pins", "/soc/pinctrl@13040000/usb0-0");
> +       offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0");
> +
> +       /* usb_pins */
> +       fdt_create_phandle(fdt, offset);
> +       fdt_add_subnode(fdt, offset, "driver-vbus-pin");
> +       offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0/dri=
ver-vbus-pin");
> +       /* GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS, GPOEN_ENABLE, GPI_NONE) =
*/

This comment may now be updated:

/* GPIOMUX(pin, GPOUT_SYS_USB_DRIVE_VBUS, GPOEN_ENABLE, GPI_NONE) */

Aside I am confused why we do not use the GPIOMUX macro directly here.
Can anyone say if that would be a problem to just use the macro
GPIOMUX what we are pretending to be here?

I think it will not be a problem here anymore when OF_UPSTREAM is
implemented to jh7110 boards in U-Boot so it is enough now to update
the comment about GPIOMUX.

> +       fdt_setprop_u32(fdt, offset, "pinmux", (0xff07 << 16) | pin);
> +       fdt_setprop_empty(fdt, offset, "bias-disable");
> +       fdt_setprop_empty(fdt, offset, "input-disable");
> +       fdt_setprop_empty(fdt, offset, "input-schmitt-disable");
> +       fdt_setprop_u32(fdt, offset, "slew-rate", 0);
> +
> +       offset =3D fdt_path_offset(fdt, "/soc/usb@10100000"); /* &usb0 */
> +       fdt_setprop_string(fdt, offset, "pinctrl-names", "default");
> +       pin_offset =3D fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0=
");
> +       fdt_setprop_u32(fdt, offset, "pinctrl-0",
> +                       fdt_get_phandle(fdt, pin_offset));
> +}
> +
> +static void spl_fdt_fixup_usb_host(void *fdt)
> +{
> +       int offset;
> +
> +       offset =3D fdt_path_offset(fdt, "/soc/usb@10100000/usb@0"); /*&us=
b_cdns3 */
> +       fdt_setprop_string(fdt, offset, "dr_mode", "host");
> +}
> +
> +static void spl_fdt_fixup_set_usb3(void *fdt)
> +{
> +       int offset, phy_offset;
> +
> +       /* disable pcie0 */
> +       offset =3D fdt_path_offset(fdt, "/soc/pcie@2b000000"); /* &pcie0 =
*/
> +       fdt_setprop_string(fdt, offset, "status", "disabled");
> +
> +       offset =3D fdt_path_offset(fdt, "/soc/phy@10210000"); /* &pciephy=
0 */
> +       fdt_setprop_u32(fdt, offset, "starfive,sys-syscon", /* syscon */
> +                       fdt_get_phandle(fdt,
> +                                       fdt_path_offset(fdt, "/soc/sys_sy=
scon@13030000")));
> +       fdt_appendprop_u32(fdt, offset, "starfive,sys-syscon", 0x18); /* =
append reg offset */
> +       fdt_setprop_u32(fdt, offset, "starfive,stg-syscon",
> +                       fdt_get_phandle(fdt, fdt_path_offset(fdt, "/soc/s=
tg_syscon@10240000")));
> +       /* append reg offset */
> +       fdt_appendprop_u32(fdt, offset, "starfive,stg-syscon", 0x148);
> +       fdt_appendprop_u32(fdt, offset, "starfive,stg-syscon", 0x1f4);
> +
> +       offset =3D fdt_path_offset(fdt, "/soc/usb@10100000/usb@0"); /* us=
b_cdns3 */
> +       phy_offset =3D fdt_path_offset(fdt, "/soc/phy@10210000"); /* <&pc=
iephy0> */
> +       /* append <&pciephy0> */
> +       fdt_appendprop_u32(fdt, offset, "phys", fdt_get_phandle(fdt, phy_=
offset));
> +       fdt_setprop(fdt, offset, "phy-names", "cdns3,usb2-phy\0cdns3,usb3=
-phy",
> +                   sizeof("cdns3,usb2-phy\0cdns3,usb3-phy"));
> +}
> +

Code readability can be better with fdt_appendprop_string helper. As:

fdt_setprop_string(fdt, offset, "phy-names", "cdns3,usb2-phy");
fdt_appendprop_string(fdt, offset, "phy-names", "cdns3,usb3-phy");

Some people prefer it to have "\0" and avoid the fdt_appendprop_string
helper. What you should do is not my choice here to make.

Anyway, and again, I think this will not be our problem after
OF_UPSTREAM is realized for JH7110 boards in U-Boot.

>  void spl_fdt_fixup_mars(void *fdt)
>  {
>         static const char compat[] =3D "milkv,mars\0starfive,jh7110";
> @@ -335,6 +398,9 @@ void spl_fdt_fixup_star64(void *fdt)
>                                 break;
>                 }
>         }
> +       spl_fdt_fixup_usb_host(fdt);
> +       spl_fdt_fixup_usb_vbus_pin(fdt, 25);
> +       spl_fdt_fixup_set_usb3(fdt);
>  }
>
>  void spl_perform_fixups(struct spl_image_info *spl_image)
> --
> 2.17.1
>

I have now tested Mars CM Lite:

+       spl_fdt_fixup_usb_host(fdt);
+       spl_fdt_fixup_usb_vbus_pin(fdt, 25);

added to the Milk-V Mars CM fix-up routine:  in U-Boot there is both
working USB and PCIe. I would note also an error for PCIe in Linux if
continuing from U-Boot with the fdt of U-Boot into Grub2, then Linux:

Loading Linux 6.11-rc4-riscv64 ...
Loading initial ramdisk ...
[   11.718961] pcie-starfive 2b000000.pcie: error -ENODEV: failed to
get valid pcie domain
[   11.727238] cadence-qspi 13010000.spi: couldn't determine
trigger-address
[   11.730479] pcie-starfive 2c000000.pcie: error -ENODEV: failed to
get valid pcie domain
[   11.734112] cadence-qspi 13010000.spi: Cannot get mandatory OF
data.
Gave up waiting for suspend/resume device

This is only a problem when I force `fdtfile` path to be not found,
and U-Boot gives the internal fdt to the next boot software in
sequence (here this is Grub2, and then Debian Linux).

For now, Minda, the error with Mars CM Lite and U-Boot internal fdt
into 6.11-rc4 Linux causing PCIe to fail is something I consider a
regression if we do enable for Mars CM and Mars CM Lite. It is good
enough in this series with only the JH7110 boards that you have
available for testing.

Reviewed-by: E Shattow <lucent@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
