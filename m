Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E846FC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 06:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F79787859;
	Tue,  9 Jan 2024 07:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pNbUBA5H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4209B876FF; Tue,  9 Jan 2024 07:08:14 +0100 (CET)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB6B287859
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 07:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4670af5bd56so623965137.2
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 22:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704780486; x=1705385286; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wCD3PuPHPBT7O29lcJvmoiBSvp9khfkqVRyGAHb9fhQ=;
 b=pNbUBA5HJS196VEuixOhKNhz6aj+2b0oQ+CZp/WElQtnzQyj/GBFRT3GPV70ZqVJG7
 vxCdxqF2rW/zfSbMWY4MSVN6MRd8xRNESHcDmtCHDF4ls0Fz+r2mhyAxxNyY6Ybufi3x
 Chhr9zelI4bQDBRIdDGolOSfAOC095YljnZvHY+JlnuQx2QWZfLWEnAKXmc6ouI5vLJv
 3n3LPN89WpviqG36qsO7w4VYD1sU2NKuEAlPpxSyUml9+dGclV9vmtuoKUN+8Fy8ZSmi
 8tcZ6T0Mm57Nih8+h7Z2QcyestgQKxUG4AC1yKB6C5lPwW5ZHBMzQJ8lBpvhlFVH4VDW
 Kf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704780486; x=1705385286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wCD3PuPHPBT7O29lcJvmoiBSvp9khfkqVRyGAHb9fhQ=;
 b=LxyFi9F6njzOej+/Uxme/ZREQ1H4KEUx+qVktIF0LpCBLQEQfx5wbe2b4Xg+GUpxuh
 dlowm2XkAsKG8XxiK2h6A9OHW9ZSvG2R4+rujlcnw4jn7VSH21yHl3JNThXwc9AvWDF4
 P4Lduvg+9zfoHQB1sa1sqJbZ/c8TBZRux3huVws2CQDhDojYvAsPjurzo1GrVArGtW74
 MmbU6Khjx0WzlLvq1NtZOSQt+AkRe4SlvFFYT433zLzju3YtmXkTMfOeOM+vA+48Gc+v
 lIyTjFnWd+goA/Vl0Vaf06E4BZu3YDKzn/kpA4j3qI6FrEfz3VZ028+MIiu5Hjb2vpEV
 hjFw==
X-Gm-Message-State: AOJu0Yxn2SSdal9vCO0EiXjFh7dyIZJzM5tvtgyNU3+BlsOEQx8O5EEv
 Hrf1qfTobFwPykadxb58BvWAIsi3T55XGS5QzkoRgFzr0gqPNw==
X-Google-Smtp-Source: AGHT+IEjvmXqHFOnLL6Zgzq+j5iuBF3H7AyWUYCTzEQtbXVkwhDjnduz3LgI7oCybJ4FDiXO2CGdtxcWXDMp02R/NqI=
X-Received: by 2002:a05:6102:d89:b0:467:dda2:825c with SMTP id
 d9-20020a0561020d8900b00467dda2825cmr1571645vst.26.1704780486565; Mon, 08 Jan
 2024 22:08:06 -0800 (PST)
MIME-Version: 1.0
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <CAFA6WYPo6kET7DA12iZQ=RJRtxs295hWTAr9YVcuB1so56JJTQ@mail.gmail.com>
 <3e669c63-7357-4e86-8724-470f783a893e@linaro.org>
In-Reply-To: <3e669c63-7357-4e86-8724-470f783a893e@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 9 Jan 2024 11:37:55 +0530
Message-ID: <CAFA6WYPwZxFu-tbtqaU5Mp_yiUyTA8J9-=FY+qmsZ4ZD_JGM+Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/32] Qualcomm generic board support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

On Fri, 5 Jan 2024 at 19:15, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 05/01/2024 13:14, Sumit Garg wrote:
> > Hi Caleb,
>
> Hi Sumit,
>
> [snip]
>
> >> ---
> >> I have tested this series on the Dragonboard410c, Dragonboard820c, and
> >
> > This series fails to boot (without any U-Boot console print) on
> > db410c. I even added below pinctrl change but without any success:
>
> Are you chainloading from aboot? Or flashing over it?
>

I am using the default mode where U-Boot acts as the first stage
bootloader. I suppose it worked for you since LK enabled drivers which
were just reused by U-Boot.

> I have only been able to validate the chainloading method, following the
> steps in doc/board/qualcomm/board.rst and generating the config with
>
> make dragonboard410c_defconfig chainloaded.config
>
> do you get any output at all?

No output from U-Boot. Last prints from SBL1:

<snip>
D -    299022 - SBL1, Delta
S - Flash Throughput, 81000 KB/s  (1537656 Bytes,  18940 us)
S - DDR Frequency, 400 MHz

> Can you try enabling debug UART output as
> documented in doc/board/qualcomm/debugging.rst?

I did but it didn't help.

>
> The pinctrl fix shouldn't be needed to boot to a shell.

While at it, I noticed another pinctrl issue which should be fixed by
following diff:

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index 0148ddb54df..6fe7bdd1dca 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -204,7 +204,7 @@ static int msm_serial_probe(struct udevice *dev)
        if (ret)
                return ret;

-       pinctrl_select_state(dev, "uart");
+       pinctrl_select_state(dev, "default");
        uart_dm_init(priv);

        return 0;

But this still didn't fix the boot problem. As you have the board in
your hand, I would suggest you to debug to avoid this back and forth.

-Sumit

>
> Thanks,
> >
> > diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c
> > b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> > index 8e698085d78..88518845952 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> > @@ -42,7 +42,7 @@ static const char *apq8016_get_pin_name(struct udevice *dev,
> >                                         unsigned int selector)
> >  {
> >         if (selector < 122) {
> > -               snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
> > +               snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> >                 return pin_name;
> >         } else {
> >                 return msm_pinctrl_pins[selector - 122];
> >
> >
> >> Dragonboard845c. I unfortunately don't have access to a QCS404 EVB board
> >> to test.
> >
> > db820c and qcs404 require a similar pinctrl change though.
> >
> > -Sumit
> >
> >>
> >> This series is based on the qcom-next branch [1] and depends on my PMIC
> >> fixes series [2], an integration branch for testing can be found at [3].
> >> The non-qualcomm-specific changes (patches 1 and 2) don't have any
> >> dependencies.
> >>
> >> [1]: https://source.denx.de/u-boot/custodians/u-boot-snapdragon
> >> [2]: https://lore.kernel.org/u-boot/20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org/
> >> [3]: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/tree/b4/qcom-common-target
> >>
> >> ---
> >> Changes in v2:
> >> - Split DTS changes to reduce patch size.
> >> - Import full board DTS files from Linux too, and introduce -u-boot.dtsi
> >>   files where necessary to make any U-Boot specific changes.
> >> - Add a pinctrl driver for qcom PMIC GPIOs
> >> - Always enable LINUX_KERNEL_IMAGE_HEADER
> >> - Link to v1: https://lore.kernel.org/r/20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org
> >>
> >> To: Neil Armstrong <neil.armstrong@linaro.org>
> >> To: Sumit Garg <sumit.garg@linaro.org>
> >> To: Ramon Fried <rfried.dev@gmail.com>
> >> Cc: Marek Vasut <marex@denx.de>
> >> To: Dzmitry Sankouski <dsankouski@gmail.com>
> >> To: Caleb Connolly <caleb.connolly@linaro.org>
> >> To: Peng Fan <peng.fan@nxp.com>
> >> To: Jaehoon Chung <jh80.chung@samsung.com>
> >> To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> >> To: Lukasz Majewski <lukma@denx.de>
> >> To: Sean Anderson <seanga2@gmail.com>
> >> To: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> >> To: Stephan Gerhold <stephan@gerhold.net>
> >> Cc:  <u-boot@lists.denx.de>
> >>
> >> ---
> >> Caleb Connolly (32):
> >>       arm: init: export prev_bl_fdt_addr
> >>       usb: dwc3-generic: support external vbus regulator
> >>       mmc: msm_sdhci: use modern clock handling
> >>       dt-bindings: drop msm_sdhci binding
> >>       clk/qcom: use upstream compatible properties
> >>       serial: msm: add debug UART
> >>       serial: msm: fix clock handling
> >>       gpio: qcom_pmic: 1-based GPIOs
> >>       gpio: qcom_pmic: add a quirk to skip GPIO configuration
> >>       gpio: qcom_pmic: add pinctrl driver
> >>       board: dragonboard410c: add chainloaded config fragment
> >>       board: dragonboard410c: upstream DT compat
> >>       board: dragonboard410c: import board code from mach-snapdragon
> >>       board: dragonboard820c: use LINUX_KERNEL_IMAGE_HEADER
> >>       mach-snapdragon: generalise board support
> >>       mach-snapdragon: dynamic load addresses
> >>       mach-snapdragon: generate fdtfile automatically
> >>       doc: board/qualcomm: document generic targets
> >>       dt-bindings: import headers for SDM845
> >>       dts: sdm845: import supporting dtsi files
> >>       dts: sdm845: replace with upstream DTS
> >>       dt-bindings: import headers for MSM8916
> >>       dts: msm8916: import PMIC dtsi files
> >>       dts: msm8916: replace with upstream DTS
> >>       dt-bindings: import headers for MSM8996
> >>       dts: msm8996: import PMIC dtsi files
> >>       dts: dragonboard820c: use correct bindings for clocks
> >>       dts: msm8996: replace with upstream DTS
> >>       dt-bindings: import headers for qcs404
> >>       dts: qcs404-evb: replace with upstream DT
> >>       board: qcs404-evb: drop board code
> >>       MAINTAINERS: Qualcomm: add some missing paths
> >>
> >>  MAINTAINERS                                        |   12 +-
> >>  arch/arm/Kconfig                                   |    4 +
> >>  arch/arm/dts/Makefile                              |    9 +-
> >>  arch/arm/dts/apq8016-sbc.dts                       |  729 +++
> >>  arch/arm/dts/apq8096-db820c-u-boot.dtsi            |   10 +
> >>  arch/arm/dts/apq8096-db820c.dts                    | 1137 ++++
> >>  arch/arm/dts/dragonboard410c-uboot.dtsi            |   44 -
> >>  arch/arm/dts/dragonboard410c.dts                   |  199 +-
> >>  arch/arm/dts/dragonboard820c-uboot.dtsi            |   32 -
> >>  arch/arm/dts/dragonboard820c.dts                   |  151 -
> >>  arch/arm/dts/dragonboard845c-uboot.dtsi            |   26 -
> >>  arch/arm/dts/dragonboard845c.dts                   |   48 -
> >>  arch/arm/dts/msm8916-pm8916.dtsi                   |  157 +
> >>  arch/arm/dts/msm8916.dtsi                          | 2702 +++++++++
> >>  arch/arm/dts/msm8996.dtsi                          | 3884 +++++++++++++
> >>  arch/arm/dts/pm8916.dtsi                           |  178 +
> >>  arch/arm/dts/pm8994.dtsi                           |  152 +
> >>  arch/arm/dts/pm8998.dtsi                           |  130 +
> >>  arch/arm/dts/pmi8994.dtsi                          |   65 +
> >>  arch/arm/dts/pmi8998.dtsi                          |   98 +
> >>  arch/arm/dts/pms405.dtsi                           |  149 +
> >>  arch/arm/dts/qcs404-evb-4000-u-boot.dtsi           |   26 +
> >>  arch/arm/dts/qcs404-evb-4000.dts                   |   96 +
> >>  arch/arm/dts/qcs404-evb-uboot.dtsi                 |   30 -
> >>  arch/arm/dts/qcs404-evb.dts                        |  390 --
> >>  arch/arm/dts/qcs404-evb.dtsi                       |  389 ++
> >>  arch/arm/dts/qcs404.dtsi                           | 1829 ++++++
> >>  arch/arm/dts/sdm845-db845c.dts                     | 1190 ++++
> >>  .../arm/dts/sdm845-samsung-starqltechn-u-boot.dtsi |   16 +
> >>  arch/arm/dts/sdm845-samsung-starqltechn.dts        |  624 +++
> >>  arch/arm/dts/sdm845-wcd9340.dtsi                   |   86 +
> >>  arch/arm/dts/sdm845.dtsi                           | 5801 +++++++++++++++++++-
> >>  arch/arm/dts/starqltechn-uboot.dtsi                |   27 -
> >>  arch/arm/dts/starqltechn.dts                       |   68 -
> >>  arch/arm/lib/save_prev_bl_data.c                   |    5 +
> >>  arch/arm/mach-snapdragon/Kconfig                   |   95 +-
> >>  arch/arm/mach-snapdragon/Makefile                  |    8 +-
> >>  arch/arm/mach-snapdragon/board.c                   |  304 +
> >>  arch/arm/mach-snapdragon/include/mach/dram.h       |   12 -
> >>  arch/arm/mach-snapdragon/init_sdm845.c             |   73 -
> >>  arch/arm/mach-snapdragon/misc.c                    |   55 -
> >>  arch/arm/mach-snapdragon/sysmap-apq8016.c          |   31 -
> >>  arch/arm/mach-snapdragon/sysmap-apq8096.c          |   31 -
> >>  arch/arm/mach-snapdragon/sysmap-qcs404.c           |   43 -
> >>  arch/arm/mach-snapdragon/sysmap-sdm845.c           |   31 -
> >>  board/qualcomm/dragonboard410c/Kconfig             |   15 -
> >>  board/qualcomm/dragonboard410c/Makefile            |    3 +-
> >>  .../dragonboard410c/configs/chainloaded.config     |    7 +
> >>  board/qualcomm/dragonboard410c/dragonboard410c.c   |  109 +-
> >>  .../qualcomm/dragonboard410c/misc.c                |   51 +-
> >>  .../mach => board/qualcomm/dragonboard410c}/misc.h |    1 +
> >>  board/qualcomm/dragonboard820c/Kconfig             |   15 -
> >>  board/qualcomm/dragonboard820c/Makefile            |    1 -
> >>  board/qualcomm/dragonboard820c/dragonboard820c.c   |   39 +-
> >>  board/qualcomm/dragonboard820c/head.S              |   33 -
> >>  board/qualcomm/dragonboard820c/u-boot.lds          |  111 -
> >>  board/qualcomm/dragonboard845c/Kconfig             |   12 -
> >>  board/qualcomm/qcs404-evb/Kconfig                  |   15 -
> >>  board/qualcomm/qcs404-evb/Makefile                 |    6 -
> >>  board/qualcomm/qcs404-evb/qcs404-evb.c             |   62 -
> >>  configs/dragonboard410c_defconfig                  |    8 +-
> >>  configs/dragonboard820c_defconfig                  |    8 +-
> >>  configs/dragonboard845c_defconfig                  |   29 -
> >>  configs/qcom_defconfig                             |   73 +
> >>  configs/qcs404evb_defconfig                        |   55 -
> >>  configs/starqltechn_defconfig                      |   41 -
> >>  doc/board/qualcomm/board.rst                       |  119 +
> >>  doc/board/qualcomm/debugging.rst                   |   61 +
> >>  doc/board/qualcomm/index.rst                       |    4 +-
> >>  doc/board/qualcomm/qcs404.rst                      |   79 -
> >>  doc/board/qualcomm/sdm845.rst                      |  162 -
> >>  doc/device-tree-bindings/mmc/msm_sdhci.txt         |   25 -
> >>  doc/device-tree-bindings/usb/ehci-msm.txt          |   10 -
> >>  drivers/clk/qcom/clock-apq8016.c                   |    9 +-
> >>  drivers/clk/qcom/clock-apq8096.c                   |    7 +-
> >>  drivers/gpio/qcom_pmic_gpio.c                      |  232 +-
> >>  drivers/mmc/msm_sdhci.c                            |   69 +-
> >>  drivers/phy/qcom/msm8916-usbh-phy.c                |    4 +-
> >>  drivers/pinctrl/qcom/pinctrl-apq8016.c             |    2 +-
> >>  drivers/serial/Kconfig                             |    8 +
> >>  drivers/serial/serial_msm.c                        |   56 +-
> >>  drivers/usb/dwc3/dwc3-generic.c                    |   12 +
> >>  drivers/usb/host/ehci-msm.c                        |   24 +-
> >>  include/configs/dragonboard845c.h                  |   20 -
> >>  include/configs/qcom.h                             |   21 +
> >>  include/configs/qcs404-evb.h                       |   20 -
> >>  include/configs/sdm845.h                           |   26 -
> >>  include/dt-bindings/arm/coresight-cti-dt.h         |   37 +
> >>  include/dt-bindings/clock/qcom,camcc-sdm845.h      |  116 +
> >>  include/dt-bindings/clock/qcom,dispcc-sdm845.h     |   56 +
> >>  include/dt-bindings/clock/qcom,gcc-msm8916.h       |  179 +
> >>  include/dt-bindings/clock/qcom,gcc-msm8996.h       |  360 ++
> >>  include/dt-bindings/clock/qcom,gpucc-sdm845.h      |   24 +
> >>  include/dt-bindings/clock/qcom,lpass-sdm845.h      |   15 +
> >>  include/dt-bindings/clock/qcom,mmcc-msm8996.h      |  295 +
> >>  include/dt-bindings/clock/qcom,rpmcc.h             |  174 +
> >>  include/dt-bindings/clock/qcom,rpmh.h              |   37 +
> >>  include/dt-bindings/clock/qcom,turingcc-qcs404.h   |   15 +
> >>  include/dt-bindings/clock/qcom,videocc-sdm845.h    |   35 +
> >>  include/dt-bindings/dma/qcom-gpi.h                 |   11 +
> >>  include/dt-bindings/firmware/qcom,scm.h            |   18 +
> >>  include/dt-bindings/iio/qcom,spmi-vadc.h           |  300 +
> >>  include/dt-bindings/interconnect/qcom,msm8916.h    |  100 +
> >>  .../dt-bindings/interconnect/qcom,msm8996-cbf.h    |   12 +
> >>  include/dt-bindings/interconnect/qcom,msm8996.h    |  163 +
> >>  include/dt-bindings/interconnect/qcom,osm-l3.h     |   15 +
> >>  include/dt-bindings/interconnect/qcom,sdm845.h     |  150 +
> >>  include/dt-bindings/phy/phy-qcom-qmp.h             |   20 +
> >>  include/dt-bindings/phy/phy-qcom-qusb2.h           |   37 +
> >>  include/dt-bindings/pinctrl/qcom,pmic-gpio.h       |  164 +
> >>  include/dt-bindings/pinctrl/qcom,pmic-mpp.h        |  106 +
> >>  include/dt-bindings/power/qcom-rpmpd.h             |  412 ++
> >>  include/dt-bindings/qcom,q6asm.h                   |   26 +
> >>  .../dt-bindings/regulator/qcom,rpmh-regulator.h    |   36 +
> >>  include/dt-bindings/reset/qcom,gcc-msm8916.h       |  100 +
> >>  include/dt-bindings/reset/qcom,sdm845-aoss.h       |   17 +
> >>  include/dt-bindings/reset/qcom,sdm845-pdc.h        |   22 +
> >>  include/dt-bindings/soc/qcom,apr.h                 |   28 +
> >>  include/dt-bindings/soc/qcom,rpmh-rsc.h            |   14 +
> >>  include/dt-bindings/sound/apq8016-lpass.h          |    9 +
> >>  include/dt-bindings/sound/qcom,lpass.h             |   46 +
> >>  include/dt-bindings/sound/qcom,q6afe.h             |    9 +
> >>  include/dt-bindings/sound/qcom,q6asm.h             |   26 +
> >>  include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h |  234 +
> >>  include/dt-bindings/sound/qcom,wcd9335.h           |   15 +
> >>  include/init.h                                     |   11 +
> >>  126 files changed, 23909 insertions(+), 2375 deletions(-)
> >> ---
> >> base-commit: bcb4a9ddbd21a61b5b421ba374a785757bd28c80
> >>
> >> // Caleb (they/them)
> >>
>
> --
> // Caleb (they/them)
