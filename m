Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0145EE65D32
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 08:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AF06897A4;
	Fri, 22 Nov 2024 09:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CUIrGeSI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 860EA897AB; Fri, 22 Nov 2024 09:16:56 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 127988979D
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 09:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f7657f9f62so19275491fa.3
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 00:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732263413; x=1732868213; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LgU4SLlwf9ZYDHzm6Q4wBGA0RMMCkndTJCW1F4/pipw=;
 b=CUIrGeSIF5K75W3FkmrenV/verQmjXmMcGEYutsE0DLb8QHV3EW/FaT494n6YAnpuu
 mGx3dWYs5bnb/8HcZ2K/YFM36XAg2VISfV1NF1teEhw1G9LH4tK6he52OqOk7qA0OaVJ
 6Z4VjAYShkZe4uHwNl+WN3sBLkaxCp+f/wyiov/ptTdxzL6vrgXITPwLjfvN7PJ68PnY
 HCZDavm8tkM4Ln39syxqEyEuaQU8U0n51249Yak4Sk2rA9wqp3S21pvge9mlyK9htbgd
 8cUBNPH73onFLq79uUBm9dZVdDZ30Pqx1O8/BbNW0WTk3FVG+9enTkccBA4AXLHjxhV9
 JaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732263413; x=1732868213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LgU4SLlwf9ZYDHzm6Q4wBGA0RMMCkndTJCW1F4/pipw=;
 b=J5wSfXRMijQNuKNusfU92qZfolHBeRf0mcOBkA3CT3lgh1oUS5IAKLeakwLRoQrVi+
 6dwU9XK0lETfC/tG549Jn+GLbpqj2F4/+VAqZgdabX/cNC+h4dS5hH49y5p8td1zgLrl
 JDdlwfZe1N+24HJRJr/N1/6espZXD94bRcP+coKJ24M/Vq+gttsdbSMcJOax75o0QB0H
 GfYG2rUuR82SofZ9ZLev0AOh5gML/Uthyb2R8iJ1Efe/sZFu2ru51bSifwdI/v1xf1ND
 zXnNiQNPwJrBgiJ5TFLREJK5VKM0bPwhPO689IJFBL0JgOd9WWwCTxMa8pXjYPGjTY08
 Bxww==
X-Forwarded-Encrypted: i=1;
 AJvYcCU67cDk1GZj1hn+yd8Prp1YDrzaR5tloV3MtnH7vnoN6m/9Y5MV9kPpnEYGzmprXVCLXxXL9KA=@lists.denx.de
X-Gm-Message-State: AOJu0YytGEpds+8ZAZOUlxOAkphm1QC8vEid2pFopYJNhg/q9Q1CBRar
 CLjaOgL+0zeGcp4zgp7Wv4IA70IaeUdT1WoNkp0xf6Z10jvKRgDI150x6so6gEzQbnBPKE5sIpA
 49ZSjhMbQgbTlFndAiWTIagEobvk=
X-Gm-Gg: ASbGncvx3xDF0VNZWZKvB2m8e989kt9x6iu2Gvd6WHRh071uLXvicPQDiJDMd4AHMwe
 7vg/Bi8nPXuEHSJChmCgo1c9qaNfN6Jni/u3AvyiYOC3XvCo/KMQ1I8IA9yssn49Oug==
X-Google-Smtp-Source: AGHT+IFxwEzXqKRsKBrVlEO9CP+yJ6LkbaKh5SoaW/+s/6YR7+RbV5hfbDQCF5V+DcGPSa0Y2jUHBvmzsuqvF3v059A=
X-Received: by 2002:a2e:bd15:0:b0:2ff:8de8:123e with SMTP id
 38308e7fff4ca-2ffa7123f9bmr8241531fa.21.1732263413169; Fri, 22 Nov 2024
 00:16:53 -0800 (PST)
MIME-Version: 1.0
References: <20241012031328.4268-1-minda.chen@starfivetech.com>
In-Reply-To: <20241012031328.4268-1-minda.chen@starfivetech.com>
From: E Shattow <lucent@gmail.com>
Date: Fri, 22 Nov 2024 00:16:42 -0800
Message-ID: <CANV2PTOzwHw6sv06gR39JBOQdAzSuBewEo_0=8OYhv-rU82E5Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Add Starfive JH7110 Cadence USB driver
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

On Fri, Oct 11, 2024 at 8:13=E2=80=AFPM Minda Chen <minda.chen@starfivetech=
.com> wrote:
>
> Add Starfive JH7110 Cadence USB driver and related PHY driver.
> So the codes can be used in visionfive2 and star64 7110 board.
>
> The driver is almost the same with kernel driver.
>
> Test with Star64 JH7110 board USB 3.0 + USB 2.0 host.
> The code can work.
>
> - Star64 using USB 3.0 and USB 2.0 host must add below board dts setting.
> (Vbus bin setting. If usb host in Other JH7110 board vbus pin is not GPIO=
,
> don't require to set this)
>
> 1. usb pin setting
>         usb_pins: usb0-0 {
>                 driver-vbus-pin {
>                         pinmux =3D <GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS,
>                                           GPOEN_ENABLE,
>                                           GPI_NONE)>;
>                         bias-disable;
>                         input-disable;
>                         input-schmitt-disable;
>                         slew-rate =3D <0>;
>                 };
>         };
>
> 2. related dts node setting(USB 3.0 host)
> &pcie0 {
>         status =3D "disabled";
> };
>
> &pciephy0 {
>         starfive,sys-syscon =3D <&sys_syscon>;
>         starfive,stg-syscon =3D <&stg_syscon 0x148 0x1f4>;
>         status =3D "okay";
> };
>
> &usb0 {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&usb_pins>;
>         dr_mode =3D "host";
>         status =3D "okay";
> };
>
> &usb_cdns3 {
>         phys =3D <&usbphy0>, <&pciephy0>;
>         phy-names =3D "cdns3,usb2-phy", "cdns3,usb3-phy";
> };
>
> - If other board is USB 2.0 host, Just set dr mode is OKay.
> &usb0 {
>         dr_mode =3D "host";
>         status =3D "okay";
> };
>
> - previous version
>   v1: https://patchwork.ozlabs.org/project/uboot/cover/20240504150358.196=
00-1-minda.chen@starfivetech.com/
>   v2: https://patchwork.ozlabs.org/project/uboot/cover/20240704055014.551=
17-1-minda.chen@starfivetech.com/
>   v3: https://patchwork.ozlabs.org/project/uboot/cover/20240719013822.101=
374-1-minda.chen@starfivetech.com/
>   v4: https://patchwork.ozlabs.org/project/uboot/cover/20240829013058.617=
8-1-minda.chen@starfivetech.com/
>
> - patch description.
>
> patch1: Add set phy mode function in cdns3 core driver
>         which is used by Starfive JH7110.
> patch2-3: USB and PCIe 2.0 (usb 3.0) PHY drivier
> patch4: Cadence USB wrapper driver.
> patch5: Add JH7110 USB default overcurrent pin.
> patch6-7 dts, config update.
> patch8: MAINTAINERS update
>
> - change:
>         v5:
>         - patch 2-4 format changed.
>         - For pareparing enable OF_UPSTREAM, patch4 get the dr mode
>           from parent device dts node not the cdns core device dts.
>         - patch2 add a common usb syscon setting headfile.
>         - delete v4 patch8 and the star64 dts setting can be setting
>           int star64 board dts configuration if the OF_UPSTREAM is
>           enable.
>         v4:
>         - patch 2 Add usb split setting, default set USB 2.0 only.
>         - patch 5 move to spl stage.
>         - Add a new patch 8 for star64 board usb host, vbus pin setting
>           and usb 3.0
>         v3:
>         - patch 1 Move the added code to cdns3_drd_update_mode().
>         - patch 1-4 correct the code format.(follow Rogers's comments.)
>         - patch 3 using regmap_field.
>
>         v2:
>         - patch 1 Move the added code to cdns3_core_init_role(). Must
>           set PHY mode before calling cdns3 role start function.
>         - patch 1-4 correct the code format.(follow Marek's comments.)
>         - patch 2 Add set 125M clock in PHY init function.
>         - Add new patch5.
>
>
> Minda Chen (8):
>   usb: cdns3: Set USB PHY mode in cdns3_drd_update_mode()
>   phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
>   phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
>   usb: cdns: starfive: Add cdns USB driver
>   spl: starfive: visionfive2: Disable USB overcurrent pin by default.
>   configs: starfive: Add visionfive2 cadence USB configuration
>   dts: starfive: Add JH7110 Cadence USB dts node
>   MAINTAINERS: Update Starfive visionfive2 maintain files.
>
>  .../dts/jh7110-starfive-visionfive-2.dtsi     |   5 +
>  arch/riscv/dts/jh7110.dtsi                    |  53 ++++
>  arch/riscv/include/asm/arch-jh7110/gpio.h     |   5 +
>  board/starfive/visionfive2/MAINTAINERS        |   2 +
>  board/starfive/visionfive2/spl.c              |   3 +
>  configs/starfive_visionfive2_defconfig        |  10 +
>  drivers/phy/Kconfig                           |   1 +
>  drivers/phy/Makefile                          |   1 +
>  drivers/phy/starfive/Kconfig                  |  21 ++
>  drivers/phy/starfive/Makefile                 |   7 +
>  drivers/phy/starfive/phy-jh7110-pcie.c        | 239 ++++++++++++++++++
>  drivers/phy/starfive/phy-jh7110-usb-syscon.h  |   9 +
>  drivers/phy/starfive/phy-jh7110-usb2.c        | 162 ++++++++++++
>  drivers/usb/cdns3/Kconfig                     |   7 +
>  drivers/usb/cdns3/Makefile                    |   2 +
>  drivers/usb/cdns3/cdns3-starfive.c            | 183 ++++++++++++++
>  drivers/usb/cdns3/core.c                      |   3 +
>  drivers/usb/cdns3/drd.c                       |  14 +
>  18 files changed, 727 insertions(+)
>  create mode 100644 drivers/phy/starfive/Kconfig
>  create mode 100644 drivers/phy/starfive/Makefile
>  create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
>  create mode 100644 drivers/phy/starfive/phy-jh7110-usb-syscon.h
>  create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c
>  create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
>
>
> base-commit: c530f6079c70219e01022142b404bf8a6b572366
> --
> 2.17.1
>

Hi Minda,

Can you please depend on series "Support OF_UPSTREAM for StarFive
JH7110", and with changes requested by Marek?

Also I have patches for review on Linux kernel mailing list to provide
some of the dts nodes we will need to allow host USB mode on Star64
and Mars:
 "riscv: dts: starfive: jh7110-pine64-star64: enable usb0 host function"
 "riscv: dts: starfive: jh7110-milkv-mars: enable usb0 host function"

This can allow your series to apply on U-Boot without extra dts?

Thanks,

-E
