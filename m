Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8117BC021AA
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 10:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED9A28056B;
	Fri, 21 Feb 2025 11:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QeRUOopw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CA18807C4; Fri, 21 Feb 2025 11:13:06 +0100 (CET)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F1C98007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 11:13:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-4ba00b6821aso656841137.2
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 02:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740132781; x=1740737581; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TyK6QRINye08z7VrCxTI3lz0BjDsFLw9krHHIi6NwXo=;
 b=QeRUOopw/p3PWQokV3wg8GEW6w3CajtY5WofFwpCbP7HxGT0WzreTtdZ2Rw2/EzgVn
 srFCfITxpLoAVm025qECnpy1Jjuw2OLq+zWqi/iDL78VQhESJ3fVtJo393zBAumXsZ5u
 X3K5jLePJbjMy7P96u6g6KY/wicjksB1ZkVnNmhLNaZMIJT6WyoDulYUk8Px1BEOY5GA
 n867u4CU5qZIcRUy2jzQr+o4KkaLwfvTZ3nLF7E573QB78Tz2pKWdZS7oX/JPL0tU14a
 EpVPhRbhYIIIx3BFfhWmW2ygAishmZ3U3XD54ySLnEq4qf0EbsXHTjAYn0xwrZGc0+Cg
 02qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740132781; x=1740737581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TyK6QRINye08z7VrCxTI3lz0BjDsFLw9krHHIi6NwXo=;
 b=JANhs7H609aIG/2m/gEgnKSG2DP2nqD6PBBf3s0ge2L+YaBPtAnn/+70e5RjXzusKl
 zRNMFrAL6x0Ih6zMyYq6hM3cFHZNBL7jHi4XxEKBgmzsV/31ScI2LurFUdfjBikVTAlc
 oQFBRGMMFxqxP6hQmTQcwBtg2IGcQh3idtsx+KHOzw4Hv3wNZ9hrg1sGb1CRKQlgt2XG
 lq8R2ia7ZbVGNRDI8KIQ7KPg5kNaFHQH5pNR53/lbCoXb7IiCZxfI4LNy153nimjVRYE
 +lGnMQBRkyUDugSdVpgO3gw2MjedcBuvL3g77qboUwYjyJdHFbkzjGN0I2P1V4bbJzB+
 xFSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeHrkgCgWklSdC/MDjswyqfdV2TOaDxSHLDVYqHi61i9Oj+yuB2w+57kqMUuxbypgvl7vKggY=@lists.denx.de
X-Gm-Message-State: AOJu0YzANRKzwNsiJfjGmUeGLpWZYhG3ADA/b7f5RwcZHxBmkNRUXw2f
 EN6qPxJ+SsDSwm+qcpHozDcyWRikOaF2c7MEwpc6ZOvzH3kwnl0NZpIp8qTozLXrVgSHYfc05d/
 vGFMjWEzpAn22SH7mQc+PPdoU/eKIp642IUgwBQ==
X-Gm-Gg: ASbGnctDx6FyELieITdXDn7kQFCPxtA2esj9ILmpv/kDH6/QRJVE+t92Qfb1BM31wzL
 AK1FrLXtFjeJZk+XoFMzYStwe8c6LlCqNfifm0UYB6wQOvW/Z6rprYNHcO0M5l19XewqJ1uyxD/
 OyzN1ZxbvY3g==
X-Google-Smtp-Source: AGHT+IHX+QPC3ktM+JPqbMKAs1aVFSxuezecfzkfK1NfvBwbL/CV0ze/inC/5HfH4SdR/KcVMmy8h9fhj8R1drDN+2w=
X-Received: by 2002:a05:6102:41a7:b0:4bb:c9bd:8dc5 with SMTP id
 ada2fe7eead31-4bfc279eea6mr929245137.3.1740132780826; Fri, 21 Feb 2025
 02:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20250221100314.464818-1-manikandan.m@microchip.com>
 <20250221100314.464818-6-manikandan.m@microchip.com>
In-Reply-To: <20250221100314.464818-6-manikandan.m@microchip.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 21 Feb 2025 15:42:48 +0530
X-Gm-Features: AWEUYZlMeb2vVU3yZnLQnQ7XD_7uyqXkzG9HNzfJyB6rtcRLHI6q-nwMqJVNrzM
Message-ID: <CAFA6WYMK4+jNkYazYsY2Nh5Fwswx-orLwwGp481DeCJeQskA0g@mail.gmail.com>
Subject: Re: [PATCH 5/8] ARM: dts: at91: sam9x7: Add initial DT for sam9x7 SoC
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 seanga2@gmail.com, 
 kever.yang@rock-chips.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 festevam@denx.de, Oliver.Gaskell@analog.com, aford173@gmail.com, 
 prasad.kummari@amd.com, caleb.connolly@linaro.org, andre.przywara@arm.com, 
 neil.armstrong@linaro.org, mibodhi@gmail.com, nicolas.ferre@microchip.com, 
 mihai.sain@microchip.com, sjg@chromium.org, u-boot@lists.denx.de, 
 Varshini Rajendran <varshini.rajendran@microchip.com>
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

Hi Manikandan,

On Fri, 21 Feb 2025 at 15:34, Manikandan Muralidharan
<manikandan.m@microchip.com> wrote:
>
> From: Varshini Rajendran <varshini.rajendran@microchip.com>
>
> Add initial device tree for sam9x7 SoC family.
>
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> [manikandan.m@microchip.com: Align with Linux DT]
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  arch/arm/dts/sam9x7.dtsi | 1273 ++++++++++++++++++++++++++++++++++++++

This SoC DT is already present here [1], so try to enable OF_UPSTREAM
as described here [2].

[1] ./dts/upstream/src/arm/microchip/sam9x7.dtsi
[2] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#where-do-i-get-a-devicetree-file-for-my-board

-Sumit

>  1 file changed, 1273 insertions(+)
>  create mode 100644 arch/arm/dts/sam9x7.dtsi
>
> diff --git a/arch/arm/dts/sam9x7.dtsi b/arch/arm/dts/sam9x7.dtsi
> new file mode 100644
> index 00000000000..35c81fa4a4a
> --- /dev/null
> +++ b/arch/arm/dts/sam9x7.dtsi
> @@ -0,0 +1,1273 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * sam9x7.dtsi - Device Tree Include file for Microchip SAM9X7 SoC family
> + *
> + * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
> + *        Varshini Rajendran <varshini.rajendran@microchip.com>
> + */
> +
> +#include <dt-bindings/clk/at91.h>
> +#include <dt-bindings/dma/at91.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/mfd/at91-usart.h>
> +#include <dt-bindings/mfd/atmel-flexcom.h>
> +#include <dt-bindings/pinctrl/at91.h>
> +#include "skeleton.dtsi"
> +
> +/ {
> +       model = "Microchip SAM9X7 SoC";
> +       compatible = "microchip,sam9x7";
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       interrupt-parent = <&aic>;
> +
> +       aliases {
> +               serial0 = &dbgu;
> +               gpio0 = &pioA;
> +               gpio1 = &pioB;
> +               gpio2 = &pioC;
> +               gpio3 = &pioD;
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu@0 {
> +                       compatible = "arm,arm926ej-s";
> +                       reg = <0>;
> +                       device_type = "cpu";
> +                       clocks = <&pmc PMC_TYPE_CORE 25>, <&pmc PMC_TYPE_CORE 17>, <&main_xtal>; /* ID_MCK_PRES, ID_MCK_DIV */
> +                       clock-names = "cpu", "master", "xtal";
> +               };
> +       };
> +
> +       clocks {
> +               slow_rc_osc: slow_rc_osc {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <18500>;
> +               };
> +
> +               main_rc: main_rc {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <12000000>;
> +               };
> +
> +               slow_xtal: clock-slowxtal {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +               };
> +
> +               main_xtal: clock-mainxtal {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +               };
> +       };
> +
> +       sram: sram@300000 {
> +               compatible = "mmio-sram";
> +               reg = <0x300000 0x10000>;
> +               ranges = <0 0x300000 0x10000>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +       };
> +
> +       ahb {
> +               compatible = "simple-bus";
> +               ranges;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +
> +               sdmmc0: mmc@80000000 {
> +                       compatible = "microchip,sam9x7-sdhci", "microchip,sam9x60-sdhci";
> +                       reg = <0x80000000 0x300>;
> +                       interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 12>, <&pmc PMC_TYPE_GCK 12>;
> +                       clock-names = "hclock", "multclk";
> +                       assigned-clocks = <&pmc PMC_TYPE_GCK 12>;
> +                       assigned-clock-rates = <100000000>;
> +                       status = "disabled";
> +               };
> +
> +               sdmmc1: mmc@90000000 {
> +                       compatible = "microchip,sam9x7-sdhci", "microchip,sam9x60-sdhci";
> +                       reg = <0x90000000 0x300>;
> +                       interrupts = <26 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 26>, <&pmc PMC_TYPE_GCK 26>;
> +                       clock-names = "hclock", "multclk";
> +                       assigned-clocks = <&pmc PMC_TYPE_GCK 26>;
> +                       assigned-clock-rates = <100000000>;
> +                       status = "disabled";
> +               };
> +       };
> +
> +       apb {
> +               compatible = "simple-bus";
> +               ranges;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +
> +               flx4: flexcom@f0000000 {
> +                       compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
> +                       reg = <0xf0000000 0x200>;
> +                       ranges = <0x0 0xf0000000 0x800>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
> +                       status = "disabled";
> +
> +                       uart4: serial@200 {
> +                               compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
> +                               reg = <0x200 0x200>;
> +                               interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
> +                               clock-names = "usart";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(8))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(9))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,use-dma-rx;
> +                               atmel,use-dma-tx;
> +                               atmel,fifo-size = <16>;
> +                               atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> +                               status = "disabled";
> +                       };
> +
> +                       spi4: spi@400 {
> +                               compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
> +                               reg = <0x400 0x200>;
> +                               interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
> +                               clock-names = "spi_clk";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(8))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(9))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +
> +                       i2c4: i2c@600 {
> +                               compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
> +                               reg = <0x600 0x200>;
> +                               interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(8))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(9))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               flx5: flexcom@f0004000 {
> +                       compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
> +                       reg = <0xf0004000 0x200>;
> +                       ranges = <0x0 0xf0004000 0x800>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
> +                       status = "disabled";
> +
> +                       uart5: serial@200 {
> +                               compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
> +                               reg = <0x200 0x200>;
> +                               interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
> +                               clock-names = "usart";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(10))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(11))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,use-dma-rx;
> +                               atmel,use-dma-tx;
> +                               atmel,fifo-size = <16>;
> +                               atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> +                               status = "disabled";
> +                       };
> +
> +                       spi5: spi@400 {
> +                               compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
> +                               reg = <0x400 0x200>;
> +                               interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
> +                               clock-names = "spi_clk";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(10))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(11))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +
> +                       i2c5: i2c@600 {
> +                               compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
> +                               reg = <0x600 0x200>;
> +                               interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(10))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(11))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               dma0: dma-controller@f0008000 {
> +                       compatible = "microchip,sam9x7-dma", "atmel,sama5d4-dma";
> +                       reg = <0xf0008000 0x1000>;
> +                       interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       #dma-cells = <1>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 20>;
> +                       clock-names = "dma_clk";
> +                       status = "disabled";
> +               };
> +
> +               ssc: ssc@f0010000 {
> +                       compatible = "microchip,sam9x7-ssc", "atmel,at91sam9g45-ssc";
> +                       reg = <0xf0010000 0x4000>;
> +                       interrupts = <28 IRQ_TYPE_LEVEL_HIGH 5>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 28>;
> +                       clock-names = "pclk";
> +                       dmas = <&dma0
> +                               (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +                                AT91_XDMAC_DT_PERID(38))>,
> +                              <&dma0
> +                               (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +                                AT91_XDMAC_DT_PERID(39))>;
> +                       dma-names = "tx", "rx";
> +                       status = "disabled";
> +               };
> +
> +               i2s: i2s@f001c000 {
> +                       compatible = "microchip,sam9x7-i2smcc", "microchip,sam9x60-i2smcc";
> +                       reg = <0xf001c000 0x100>;
> +                       interrupts = <34 IRQ_TYPE_LEVEL_HIGH 7>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 34>, <&pmc PMC_TYPE_GCK 34>;
> +                       clock-names = "pclk", "gclk";
> +                       dmas = <&dma0
> +                               (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +                                AT91_XDMAC_DT_PERID(36))>,
> +                              <&dma0
> +                               (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +                                AT91_XDMAC_DT_PERID(37))>;
> +                       dma-names = "tx", "rx";
> +                       status = "disabled";
> +               };
> +
> +               flx11: flexcom@f0020000 {
> +                       compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
> +                       reg = <0xf0020000 0x200>;
> +                       ranges = <0x0 0xf0020000 0x800>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
> +                       status = "disabled";
> +
> +                       uart11: serial@200 {
> +                               compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
> +                               reg = <0x200 0x200>;
> +                               interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
> +                               clock-names = "usart";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(22))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(23))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,use-dma-rx;
> +                               atmel,use-dma-tx;
> +                               atmel,fifo-size = <16>;
> +                               atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> +                               status = "disabled";
> +                       };
> +
> +                       i2c11: i2c@600 {
> +                               compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
> +                               reg = <0x600 0x200>;
> +                               interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(22))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(23))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               flx12: flexcom@f0024000 {
> +                       compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
> +                       reg = <0xf0024000 0x200>;
> +                       ranges = <0x0 0xf0024000 0x800>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
> +                       status = "disabled";
> +
> +                       uart12: serial@200 {
> +                               compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
> +                               reg = <0x200 0x200>;
> +                               interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
> +                               clock-names = "usart";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(24))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(25))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,use-dma-rx;
> +                               atmel,use-dma-tx;
> +                               atmel,fifo-size = <16>;
> +                               atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> +                               status = "disabled";
> +                       };
> +
> +                       i2c12: i2c@600 {
> +                               compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
> +                               reg = <0x600 0x200>;
> +                               interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(24))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(25))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               pit64b0: timer@f0028000 {
> +                       compatible = "microchip,sam9x7-pit64b", "microchip,sam9x60-pit64b";
> +                       reg = <0xf0028000 0x100>;
> +                       interrupts = <37 IRQ_TYPE_LEVEL_HIGH 7>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 37>, <&pmc PMC_TYPE_GCK 37>;
> +                       clock-names = "pclk", "gclk";
> +               };
> +
> +               sha: crypto@f002c000 {
> +                       compatible = "microchip,sam9x7-sha", "atmel,at91sam9g46-sha";
> +                       reg = <0xf002c000 0x100>;
> +                       interrupts = <41 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 41>;
> +                       clock-names = "sha_clk";
> +                       dmas = <&dma0
> +                               (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +                                AT91_XDMAC_DT_PERID(34))>;
> +                       dma-names = "tx";
> +               };
> +
> +               trng: rng@f0030000 {
> +                       compatible = "microchip,sam9x7-trng", "microchip,sam9x60-trng";
> +                       reg = <0xf0030000 0x100>;
> +                       interrupts = <38 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 38>;
> +                       status = "disabled";
> +               };
> +
> +               aes: crypto@f0034000 {
> +                       compatible = "microchip,sam9x7-aes", "atmel,at91sam9g46-aes";
> +                       reg = <0xf0034000 0x100>;
> +                       interrupts = <39 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 39>;
> +                       clock-names = "aes_clk";
> +                       dmas = <&dma0
> +                               (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +                                AT91_XDMAC_DT_PERID(32))>,
> +                              <&dma0
> +                               (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +                                AT91_XDMAC_DT_PERID(33))>;
> +                       dma-names = "tx", "rx";
> +               };
> +
> +               tdes: crypto@f0038000 {
> +                       compatible = "microchip,sam9x7-tdes", "atmel,at91sam9g46-tdes";
> +                       reg = <0xf0038000 0x100>;
> +                       interrupts = <40 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 40>;
> +                       clock-names = "tdes_clk";
> +                       dmas = <&dma0
> +                               (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +                                AT91_XDMAC_DT_PERID(31))>,
> +                              <&dma0
> +                               (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +                                AT91_XDMAC_DT_PERID(30))>;
> +                       dma-names = "tx", "rx";
> +               };
> +
> +               classd: sound@f003c000 {
> +                       compatible = "microchip,sam9x7-classd", "atmel,sama5d2-classd";
> +                       reg = <0xf003c000 0x100>;
> +                       interrupts = <42 IRQ_TYPE_LEVEL_HIGH 7>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 42>, <&pmc PMC_TYPE_GCK 42>;
> +                       clock-names = "pclk", "gclk";
> +                       dmas = <&dma0
> +                               (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +                                AT91_XDMAC_DT_PERID(35))>;
> +                       dma-names = "tx";
> +                       status = "disabled";
> +               };
> +
> +               pit64b1: timer@f0040000 {
> +                       compatible = "microchip,sam9x7-pit64b", "microchip,sam9x60-pit64b";
> +                       reg = <0xf0040000 0x100>;
> +                       interrupts = <58 IRQ_TYPE_LEVEL_HIGH 7>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 58>, <&pmc PMC_TYPE_GCK 58>;
> +                       clock-names = "pclk", "gclk";
> +               };
> +
> +               can0: can@f8000000 {
> +                       compatible = "bosch,m_can";
> +                       reg = <0xf8000000 0x100>, <0x300000 0x7800>;
> +                       reg-names = "m_can", "message_ram";
> +                       interrupts = <29 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <68 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       interrupt-names = "int0", "int1";
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 29>, <&pmc PMC_TYPE_GCK 29>;
> +                       clock-names = "hclk", "cclk";
> +                       assigned-clocks = <&pmc PMC_TYPE_CORE 2>, <&pmc PMC_TYPE_GCK 29>;
> +                       assigned-clock-rates = <480000000>, <40000000>;
> +                       assigned-clock-parents = <&pmc PMC_TYPE_CORE 2>, <&pmc PMC_TYPE_CORE 2>;
> +                       bosch,mram-cfg = <0x3400 0 0 64 0 0 32 32>;
> +                       status = "disabled";
> +               };
> +
> +               can1: can@f8004000 {
> +                       compatible = "bosch,m_can";
> +                       reg = <0xf8004000 0x100>, <0x300000 0xbc00>;
> +                       reg-names = "m_can", "message_ram";
> +                       interrupts = <30 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <69 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       interrupt-names = "int0", "int1";
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 30>, <&pmc PMC_TYPE_GCK 30>;
> +                       clock-names = "hclk", "cclk";
> +                       assigned-clocks = <&pmc PMC_TYPE_CORE 2>, <&pmc PMC_TYPE_GCK 30>;
> +                       assigned-clock-rates = <480000000>, <40000000>;
> +                       assigned-clock-parents = <&pmc PMC_TYPE_CORE 2>, <&pmc PMC_TYPE_CORE 2>;
> +                       bosch,mram-cfg = <0x7800 0 0 64 0 0 32 32>;
> +                       status = "disabled";
> +               };
> +
> +               tcb: timer@f8008000 {
> +                       compatible = "microchip,sam9x7-tcb","atmel,sama5d2-tcb", "simple-mfd", "syscon";
> +                       reg = <0xf8008000 0x100>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&pmc PMC_TYPE_GCK 17>, <&clk32k 0>;
> +                       clock-names = "t0_clk", "gclk", "slow_clk";
> +               };
> +
> +               flx6: flexcom@f8010000 {
> +                       compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
> +                       reg = <0xf8010000 0x200>;
> +                       ranges = <0x0 0xf8010000 0x800>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
> +                       status = "disabled";
> +
> +                       uart6: serial@200 {
> +                               compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
> +                               reg = <0x200 0x200>;
> +                               interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
> +                               clock-names = "usart";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(12))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(13))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,use-dma-rx;
> +                               atmel,use-dma-tx;
> +                               atmel,fifo-size = <16>;
> +                               atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> +                               status = "disabled";
> +                       };
> +
> +                       i2c6: i2c@600 {
> +                               compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
> +                               reg = <0x600 0x200>;
> +                               interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(12))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(13))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               flx7: flexcom@f8014000 {
> +                       compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
> +                       reg = <0xf8014000 0x200>;
> +                       ranges = <0x0 0xf8014000 0x800>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
> +                       status = "disabled";
> +
> +                       uart7: serial@200 {
> +                               compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
> +                               reg = <0x200 0x200>;
> +                               interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
> +                               clock-names = "usart";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(14))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(15))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,use-dma-rx;
> +                               atmel,use-dma-tx;
> +                               atmel,fifo-size = <16>;
> +                               atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> +                               status = "disabled";
> +                       };
> +
> +                       i2c7: i2c@600 {
> +                               compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
> +                               reg = <0x600 0x200>;
> +                               interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(14))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(15))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               flx8: flexcom@f8018000 {
> +                       compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
> +                       reg = <0xf8018000 0x200>;
> +                       ranges = <0x0 0xf8018000 0x800>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
> +                       status = "disabled";
> +
> +                       uart8: serial@200 {
> +                               compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
> +                               reg = <0x200 0x200>;
> +                               interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
> +                               clock-names = "usart";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(16))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(17))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,use-dma-rx;
> +                               atmel,use-dma-tx;
> +                               atmel,fifo-size = <16>;
> +                               atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> +                               status = "disabled";
> +                       };
> +
> +                       i2c8: i2c@600 {
> +                               compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
> +                               reg = <0x600 0x200>;
> +                               interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(16))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(17))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               flx0: flexcom@f801c000 {
> +                       compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
> +                       reg = <0xf801c000 0x200>;
> +                       ranges = <0x0 0xf801c000 0x800>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
> +                       status = "disabled";
> +
> +                       uart0: serial@200 {
> +                               compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
> +                               reg = <0x200 0x200>;
> +                               interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
> +                               clock-names = "usart";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(0))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(1))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,use-dma-rx;
> +                               atmel,use-dma-tx;
> +                               atmel,fifo-size = <16>;
> +                               atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> +                               status = "disabled";
> +                       };
> +
> +                       spi0: spi@400 {
> +                               compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
> +                               reg = <0x400 0x200>;
> +                               interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
> +                               clock-names = "spi_clk";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(0))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(1))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +
> +                       i2c0: i2c@600 {
> +                               compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
> +                               reg = <0x600 0x200>;
> +                               interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(0))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(1))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               flx1: flexcom@f8020000 {
> +                       compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
> +                       reg = <0xf8020000 0x200>;
> +                       ranges = <0x0 0xf8020000 0x800>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
> +                       status = "disabled";
> +
> +                       uart1: serial@200 {
> +                               compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
> +                               reg = <0x200 0x200>;
> +                               interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
> +                               clock-names = "usart";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(2))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(3))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,use-dma-rx;
> +                               atmel,use-dma-tx;
> +                               atmel,fifo-size = <16>;
> +                               atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> +                               status = "disabled";
> +                       };
> +
> +                       spi1: spi@400 {
> +                               compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
> +                               reg = <0x400 0x200>;
> +                               interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
> +                               clock-names = "spi_clk";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(2))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(3))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +
> +                       i2c1: i2c@600 {
> +                               compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
> +                               reg = <0x600 0x200>;
> +                               interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(2))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(3))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               flx2: flexcom@f8024000 {
> +                       compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
> +                       reg = <0xf8024000 0x200>;
> +                       ranges = <0x0 0xf8024000 0x800>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
> +                       status = "disabled";
> +
> +                       uart2: serial@200 {
> +                               compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
> +                               reg = <0x200 0x200>;
> +                               interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
> +                               clock-names = "usart";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(4))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(5))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,use-dma-rx;
> +                               atmel,use-dma-tx;
> +                               atmel,fifo-size = <16>;
> +                               atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> +                               status = "disabled";
> +                       };
> +
> +                       spi2: spi@400 {
> +                               compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
> +                               reg = <0x400 0x200>;
> +                               interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
> +                               clock-names = "spi_clk";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(4))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(5))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +
> +                       i2c2: i2c@600 {
> +                               compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
> +                               reg = <0x600 0x200>;
> +                               interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(4))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(5))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               flx3: flexcom@f8028000 {
> +                       compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
> +                       reg = <0xf8028000 0x200>;
> +                       ranges = <0x0 0xf8028000 0x800>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
> +                       status = "disabled";
> +
> +                       uart3: serial@200 {
> +                               compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
> +                               reg = <0x200 0x200>;
> +                               interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
> +                               clock-names = "usart";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(6))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(7))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,use-dma-rx;
> +                               atmel,use-dma-tx;
> +                               atmel,fifo-size = <16>;
> +                               atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> +                               status = "disabled";
> +                       };
> +
> +                       spi3: spi@400 {
> +                               compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
> +                               reg = <0x400 0x200>;
> +                               interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
> +                               clock-names = "spi_clk";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(6))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(7))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +
> +                       i2c3: i2c@600 {
> +                               compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
> +                               reg = <0x600 0x200>;
> +                               interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(6))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(7))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               gmac: ethernet@f802c000 {
> +                       compatible = "microchip,sam9x7-gem", "cdns,sama7g5-gem";
> +                       reg = <0xf802c000 0x1000>;
> +                       interrupts = <24 IRQ_TYPE_LEVEL_HIGH 3>,        /* Queue 0 */
> +                                    <60 IRQ_TYPE_LEVEL_HIGH 3>,        /* Queue 1 */
> +                                    <61 IRQ_TYPE_LEVEL_HIGH 3>,        /* Queue 2 */
> +                                    <62 IRQ_TYPE_LEVEL_HIGH 3>,        /* Queue 3 */
> +                                    <63 IRQ_TYPE_LEVEL_HIGH 3>,        /* Queue 4 */
> +                                    <64 IRQ_TYPE_LEVEL_HIGH 3>;        /* Queue 5 */
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 24>, <&pmc PMC_TYPE_PERIPHERAL 24>, <&pmc PMC_TYPE_GCK 24>, <&pmc PMC_TYPE_GCK 67>;
> +                       clock-names = "hclk", "pclk", "tx_clk", "tsu_clk";
> +                       assigned-clocks = <&pmc PMC_TYPE_GCK 67>;
> +                       assigned-clock-rates = <266666666>;
> +                       status = "disabled";
> +               };
> +
> +               pwm0: pwm@f8034000 {
> +                       compatible = "microchip,sam9x7-pwm", "microchip,sam9x60-pwm";
> +                       reg = <0xf8034000 0x300>;
> +                       interrupts = <18 IRQ_TYPE_LEVEL_HIGH 4>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 18>;
> +                       #pwm-cells = <3>;
> +                       status = "disabled";
> +               };
> +
> +               flx9: flexcom@f8040000 {
> +                       compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
> +                       reg = <0xf8040000 0x200>;
> +                       ranges = <0x0 0xf8040000 0x800>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
> +                       status = "disabled";
> +
> +                       uart9: serial@200 {
> +                               compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
> +                               reg = <0x200 0x200>;
> +                               interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
> +                               clock-names = "usart";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(18))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(19))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,use-dma-rx;
> +                               atmel,use-dma-tx;
> +                               atmel,fifo-size = <16>;
> +                               atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> +                               status = "disabled";
> +                       };
> +
> +                       i2c9: i2c@600 {
> +                               compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
> +                               reg = <0x600 0x200>;
> +                               interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(18))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(19))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               flx10: flexcom@f8044000 {
> +                       compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
> +                       reg = <0xf8044000 0x200>;
> +                       ranges = <0x0 0xf8044000 0x800>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
> +                       status = "disabled";
> +
> +                       uart10: serial@200 {
> +                               compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
> +                               reg = <0x200 0x200>;
> +                               interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
> +                               clock-names = "usart";
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(20))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(21))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,use-dma-rx;
> +                               atmel,use-dma-tx;
> +                               atmel,fifo-size = <16>;
> +                               atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> +                               status = "disabled";
> +                       };
> +
> +                       i2c10: i2c@600 {
> +                               compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
> +                               reg = <0x600 0x200>;
> +                               interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
> +                               dmas = <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(20))>,
> +                                      <&dma0
> +                                       (AT91_XDMAC_DT_MEM_IF(0) |
> +                                        AT91_XDMAC_DT_PER_IF(1) |
> +                                        AT91_XDMAC_DT_PERID(21))>;
> +                               dma-names = "tx", "rx";
> +                               atmel,fifo-size = <16>;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               matrix: matrix@ffffde00 {
> +                       compatible = "microchip,sam9x7-matrix", "atmel,at91sam9x5-matrix", "syscon";
> +                       reg = <0xffffde00 0x200>;
> +               };
> +
> +               pmecc: ecc-engine@ffffe000 {
> +                       compatible = "microchip,sam9x7-pmecc", "atmel,at91sam9g45-pmecc";
> +                       reg = <0xffffe000 0x300>, <0xffffe600 0x100>;
> +               };
> +
> +               mpddrc: mpddrc@ffffe800 {
> +                       compatible = "microchip,sam9x7-ddramc", "atmel,sama5d3-ddramc";
> +                       reg = <0xffffe800 0x200>;
> +                       clocks = <&pmc PMC_TYPE_SYSTEM 2>, <&pmc PMC_TYPE_CORE 1>;
> +                       clock-names = "ddrck", "mpddr";
> +               };
> +
> +               smc: smc@ffffea00 {
> +                       compatible = "microchip,sam9x7-smc", "atmel,at91sam9260-smc", "syscon";
> +                       reg = <0xffffea00 0x100>;
> +               };
> +
> +               aic: interrupt-controller@fffff100 {
> +                       compatible = "microchip,sam9x7-aic";
> +                       reg = <0xfffff100 0x100>;
> +                       #interrupt-cells = <3>;
> +                       interrupt-controller;
> +                       atmel,external-irqs = <31>;
> +               };
> +
> +               dbgu: serial@fffff200 {
> +                       compatible = "microchip,sam9x7-dbgu", "atmel,at91sam9260-dbgu", "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
> +                       reg = <0xfffff200 0x200>;
> +                       interrupts = <47 IRQ_TYPE_LEVEL_HIGH 7>;
> +                       clocks = <&pmc PMC_TYPE_PERIPHERAL 47>;
> +                       clock-names = "usart";
> +                       dmas = <&dma0
> +                               (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +                                AT91_XDMAC_DT_PERID(28))>,
> +                              <&dma0
> +                               (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +                                AT91_XDMAC_DT_PERID(29))>;
> +                       dma-names = "tx", "rx";
> +                       atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> +                       status = "disabled";
> +               };
> +
> +               pinctrl: pinctrl@fffff400 {
> +                       compatible = "microchip,sam9x7-pinctrl", "microchip,sam9x60-pinctrl", "simple-mfd";
> +                       ranges = <0xfffff400 0xfffff400 0x800>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +
> +                       /* mux-mask corresponding to sam9x7 SoC in TFBGA228L package */
> +                       atmel,mux-mask = <
> +                                        /*  A          B          C          D   */
> +                                        0xffffffff 0xffffefc0 0xc0ffd000 0x00000000    /* pioA */
> +                                        0x07ffffff 0x0805fe7f 0x01ff9f81 0x06078000    /* pioB */
> +                                        0xffffffff 0x07dfffff 0xfa3fffff 0x00000000    /* pioC */
> +                                        0x00003fff 0x00003fe0 0x0000003f 0x00000000    /* pioD */
> +                                        >;
> +
> +                       pioA: gpio@fffff400 {
> +                               compatible = "microchip,sam9x7-gpio", "microchip,sam9x60-gpio", "atmel,at91rm9200-gpio";
> +                               reg = <0xfffff400 0x200>;
> +                               interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
> +                               #interrupt-cells = <2>;
> +                               interrupt-controller;
> +                               #gpio-cells = <2>;
> +                               gpio-controller;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 2>;
> +                       };
> +
> +                       pioB: gpio@fffff600 {
> +                               compatible = "microchip,sam9x7-gpio", "microchip,sam9x60-gpio", "atmel,at91rm9200-gpio";
> +                               reg = <0xfffff600 0x200>;
> +                               interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
> +                               #interrupt-cells = <2>;
> +                               interrupt-controller;
> +                               #gpio-cells = <2>;
> +                               gpio-controller;
> +                               #gpio-lines = <26>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 3>;
> +                       };
> +
> +                       pioC: gpio@fffff800 {
> +                               compatible = "microchip,sam9x7-gpio", "microchip,sam9x60-gpio", "atmel,at91rm9200-gpio";
> +                               reg = <0xfffff800 0x200>;
> +                               interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
> +                               #interrupt-cells = <2>;
> +                               interrupt-controller;
> +                               #gpio-cells = <2>;
> +                               gpio-controller;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 4>;
> +                       };
> +
> +                       pioD: gpio@fffffa00 {
> +                               compatible = "microchip,sam9x7-gpio", "microchip,sam9x60-gpio", "atmel,at91rm9200-gpio";
> +                               reg = <0xfffffa00 0x200>;
> +                               interrupts = <44 IRQ_TYPE_LEVEL_HIGH 1>;
> +                               #interrupt-cells = <2>;
> +                               interrupt-controller;
> +                               #gpio-cells = <2>;
> +                               gpio-controller;
> +                               #gpio-lines = <22>;
> +                               clocks = <&pmc PMC_TYPE_PERIPHERAL 44>;
> +                       };
> +               };
> +
> +               pmc: clock-controller@fffffc00 {
> +                       compatible = "microchip,sam9x7-pmc", "syscon";
> +                       reg = <0xfffffc00 0x200>;
> +                       interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> +                       #clock-cells = <2>;
> +                       clocks = <&clk32k 1>, <&clk32k 0>, <&main_xtal>, <&main_rc>;
> +                       clock-names = "td_slck", "md_slck", "main_xtal", "main_rc";
> +               };
> +
> +               reset_controller: reset-controller@fffffe00 {
> +                       compatible = "microchip,sam9x7-rstc", "microchip,sam9x60-rstc";
> +                       reg = <0xfffffe00 0x10>;
> +                       clocks = <&clk32k 0>;
> +               };
> +
> +               poweroff: poweroff@fffffe10 {
> +                       compatible = "microchip,sam9x7-shdwc", "microchip,sam9x60-shdwc";
> +                       reg = <0xfffffe10 0x10>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       clocks = <&clk32k 0>;
> +                       atmel,wakeup-rtc-timer;
> +                       atmel,wakeup-rtt-timer;
> +                       status = "disabled";
> +               };
> +
> +               rtt: rtc@fffffe20 {
> +                       compatible = "microchip,sam9x7-rtt", "atmel,at91sam9260-rtt";
> +                       reg = <0xfffffe20 0x20>;
> +                       interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> +                       clocks = <&clk32k 0>;
> +               };
> +
> +               clk32k: clock-controller@fffffe50 {
> +                       compatible = "microchip,sam9x7-sckc", "microchip,sam9x60-sckc";
> +                       reg = <0xfffffe50 0x4>;
> +                       clocks = <&slow_rc_osc>, <&slow_xtal>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               gpbr: syscon@fffffe60 {
> +                       compatible = "microchip,sam9x7-gpbr", "atmel,at91sam9260-gpbr", "syscon";
> +                       reg = <0xfffffe60 0x10>;
> +               };
> +
> +               rtc: rtc@fffffea8 {
> +                       compatible = "microchip,sam9x7-rtc", "microchip,sam9x60-rtc";
> +                       reg = <0xfffffea8 0x100>;
> +                       interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> +                       clocks = <&clk32k 0>;
> +               };
> +
> +               watchdog: watchdog@ffffff80 {
> +                       compatible = "microchip,sam9x7-wdt", "microchip,sam9x60-wdt";
> +                       reg = <0xffffff80 0x24>;
> +                       interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> +                       status = "disabled";
> +               };
> +       };
> +};
> --
> 2.25.1
>
