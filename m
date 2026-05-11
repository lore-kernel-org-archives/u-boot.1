Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8B0CD3427
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 08:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D63E84706;
	Mon, 11 May 2026 10:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iBv55+V3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12CBA8482E; Mon, 11 May 2026 10:26:35 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2284C846CB
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 10:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-67f7caa33easo2251373a12.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 01:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778487992; cv=none;
 d=google.com; s=arc-20240605;
 b=f3gEsHics/ytbsPxLOj92howm51v4OEaqBBaSDHEhJGVf7nAGjhMlaJn01BT/SJkt0
 nuQIqe2o4zoD4XCRSpujxp2yTzNnCfV/NGzZh6MKd28DSclLKFzCMDGN780lfwsrPp0f
 Z/wRcn+eIdF8G/wHl5+rQwk24WbjR7q/jGvukEKx0s5UJTloelamsK3WSwOIze9Cjgeb
 S9T9+fpibvKUyS6liT3EC5xrrssyUHePtTZPKCp4+OTxSER+6DZDUEvlCJaBlm+j7OIJ
 ynE4QnGqa23qPQjJrvJ+me2fsukmD3k1d9TUXWgM3aumO0qE/uyVLzp2T7JUXylshKGH
 etoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Olr3MhhpBA1Dmwerer/dtxpKCvXQtnsjGRx2pa6gbuw=;
 fh=2K8JEZe89Cg9mIn12L3R2Gvj32qUAuMJvPugKb6ns28=;
 b=fQzlHR1+GdUXsYCWqgVDdGl5z3U1EUXGpA5dTx3TtYuEE6uaEMtY2nwEs9/HLY2alI
 U32NV7es/d87lmyrrMmaviDD9pyXDqsj8jf2JNsWPEgBYX6DqDGrz+elhdD3IjCFH9TG
 vpZJyeohIpEMcuEzGMOdo8F6tlTHNEgNHyejvJAXVByevXohVWEFwsLZ+OcF6h+vpOOn
 E6RaQ7oUN6AncMOXxtP5Pfl9CqpoDvafFD9kPwnozJqZntJ5T4fSBETIiyMjWKry/Mhc
 0X96ko2QklU7p+tBJLWCN18fLAjw5udnWyfpa0AvlUOJbzu9iOeExhdFPHGy/o8kUQng
 qjLA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778487992; x=1779092792; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Olr3MhhpBA1Dmwerer/dtxpKCvXQtnsjGRx2pa6gbuw=;
 b=iBv55+V3Wcn9qfm5WqWAJ0RX87+Hy3g3rFxUH8l5xovts1PFfDkfRdMXmBg0aWrUBI
 t72bOxnA+hMN3uxadNpX6zvOcOKxG7aOJjGlnrHd1GUZC4fc41xjo6DTwU5wUUBBA0Ht
 mIN6c3UgHaS32wZ+J6vY6Zw2ssPuJTp2FP/hJvi9kz45V+5S8xMgWL45tYc2siEEP7S5
 qxOwUoH788AbQmVc1OfpRK9LdWnA9PjsC//d/eEFKgJpa1OwxW6xtuSqMZ34gD82B0FT
 GVZ96oD3yqVmxSU6OHlO1gO9FjW2kpNOHA+zHq9ACxL8OyWFvs/op5kdrEOsXLAshtJ7
 6Dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778487992; x=1779092792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Olr3MhhpBA1Dmwerer/dtxpKCvXQtnsjGRx2pa6gbuw=;
 b=b8Ah/4eBs9rAi67U0HMDbc7Pjpweka5RL0pxkvv/FGTinAQQKVi2QE1FfMjSPIo20e
 WuKus64nnD+P2Px1WzkV0zvyIRrmcgw7+MZD3EBtKI9k4FCBhNEZ+IF8xSMBUM0V/f8H
 zjTa0KLg+tmxUd6cKxzS1Uls+mJYJQoQKAQZ4ck4YKf/zzYjqHGIeKX6H9upLwJBl/rl
 atE8VTQ1eSPCsOCjQ9I0jrBdr0pZISmFZJxPltpn2Sk3KicyCCz5KnGDsUknI7EQpXRo
 13a5CEgpHXed12ZdFtYi1OTvW7TVmhWtpCmOuZ1pJraV4Mzo/I+dMgQvmRGEjKLR3tyI
 WjQQ==
X-Gm-Message-State: AOJu0YzeidrX07eVzKqrBtjHy7QJyATQeqOAd8NKkk3swv3oVX0fl5mg
 Z7epID7PMlbpLWM/j8ffh9IGgOPcAeedgj9d0IB2zFlSMdUyprr1MkPBQdXsm2SdWoLmapZEshM
 lnTWD5FMtPs2DUv9WdxFixulYStfypp8=
X-Gm-Gg: Acq92OFmXCfnZiVLW3u4a3iU0/qugOEnkvlDTQNjQX69muUCKBDBfLqdYbP5eV0nkec
 bLJDy4juQBkX2olsSFcr32k4Dj6e3A5xc7g68PBUUeddly0r9tmQPD2YYuR6g3J4o5ybS98Mzvo
 8FpBENxbs/faW3mftYDSBLx3hRXKpUXYsFUugl1num1fvlixGJdHnzVjDGQU9E+XDdwkV++/Jt8
 3EsO2CShEjrb862T/xrrMXMGqvgpZSWGNRY/E+A7X3rr7avN3WOd7GGztUsYgTU3CKKNjMD8txR
 yMglOuaLsAi/Q6m8iAYqnwhureez5lqxhRqrBxtSCY4KFrfZWlmTzWevC2VGBBme9rQaXJ7/HjQ
 1/PL8D9MlT7CBX8iOEI56idcGpduylKYcmt+ABNuBPzj6eSIo9yAGF9E8BIpC55SKUGt0/nt9vD
 LdUYCM1LCgcxk=
X-Received: by 2002:a05:6402:913:b0:67c:e014:464c with SMTP id
 4fb4d7f45d1cf-67d638a7675mr10999467a12.5.1778487992314; Mon, 11 May 2026
 01:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778277334.git.aidan@wolfssl.com>
 <9922bb5e8b3fb1d5c6e80ea51a01b685690a2f44.1778277334.git.aidan@wolfssl.com>
In-Reply-To: <9922bb5e8b3fb1d5c6e80ea51a01b685690a2f44.1778277334.git.aidan@wolfssl.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 11 May 2026 09:26:20 +0100
X-Gm-Features: AVHnY4K_-DKp9ONpdGnTLZauYiMRvUqX6U__TgnHGUB4bcRB0w2Qoa16vhVBLzg
Message-ID: <CALeDE9NHCZR6YSL0gjONBM4TRrxL9gPt5b_5rHx3qm9ERDCjrA@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] dts: add TPM device tree nodes for RPi4, QEMU,
 and sandbox
To: Aidan Garske <aidan@wolfssl.com>
Cc: u-boot@lists.denx.de, David Garske <david@wolfssl.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

NAK,

The below should be 4 changes for the 4 different devices.

Also it pollutes the Linux DT if Linux boots with FW DT, such as used
for a SystemReady compliant device, why wouldn't these go upstream?

On the RPi4 side of things you should probably use the prior FW with
the overlay provided by the config.txt to get the real TPM. Not sure
why the DT would need the soft SPI given you disable the driver in the
config?


On Sat, 9 May 2026 at 01:47, Aidan Garske <aidan@wolfssl.com> wrote:
>
> From: Aidan <aidan@wolfssl.com>
>
> Add device tree entries for TPM devices across three platforms:
>
> bcm2711-rpi-4-b.dts:
>   Add SPI0 node with Infineon SLB9670/9672 TPM on CE1 (GPIO7),
>   matching the standard Linux tpm-slb9670 overlay. Add spi0 alias
>   so wolfTPM finds the bus at index 0.
>
> bcm2711-rpi-4-b-u-boot.dtsi (new file):
>   Add soft-SPI (GPIO bit-bang) fallback node for TPM communication.
>   This uses spi-gpio with GPIO11/10/9/7 and provides an alternative
>   to the hardware SPI driver when pinctrl naming differs between
>   U-Boot and Linux device trees.
>
> qemu-arm64.dts:
>   Add MMIO-based TPM TIS node at 0x0c000000 for QEMU virt machine
>   with swtpm. This allows wolfTPM testing via QEMU without hardware.
>
> sandbox.dtsi:
>   Add sandbox TPM SPI device (sandbox,tpm-spi) on SPI bus CS1 with
>   a phandle reference to a sandbox TPM SPI emulator node. This
>   enables wolfTPM SPI HAL testing in the sandbox environment.
>
> Signed-off-by: Aidan Garske <aidan@wolfssl.com>
> ---
>  arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi | 54 ++++++++++++++++++++++++
>  arch/arm/dts/bcm2711-rpi-4-b.dts         | 20 +++++++++
>  arch/arm/dts/qemu-arm64.dts              |  4 ++
>  arch/sandbox/dts/sandbox.dtsi            | 11 +++++
>  4 files changed, 89 insertions(+)
>  create mode 100644 arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi
>
> diff --git a/arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi b/arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi
> new file mode 100644
> index 00000000000..c38276abee9
> --- /dev/null
> +++ b/arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * U-Boot specific additions for Raspberry Pi 4 Model B
> + *
> + * Adds soft SPI support for Infineon SLB9670/9672 TPM HAT
> + * connected to SPI0 CE1 (GPIO 7)
> + *
> + * Uses GPIO bit-banging instead of hardware SPI to avoid
> + * GPIO chip naming issues (pinctrl-bcm2835 vs pinctrl-bcm2711)
> + */
> +
> +#include "bcm283x-u-boot.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +       aliases {
> +               spi0 = &soft_spi;
> +       };
> +
> +       soft_spi: soft-spi {
> +               compatible = "spi-gpio";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               status = "okay";
> +               bootph-all;
> +
> +               /*
> +                * GPIO pins for SPI0 on Raspberry Pi 4:
> +                * GPIO 11 = SCLK
> +                * GPIO 10 = MOSI
> +                * GPIO 9  = MISO
> +                * GPIO 7  = CE1 (chip select for TPM)
> +                */
> +               gpio-sck = <&gpio 11 GPIO_ACTIVE_HIGH>;
> +               gpio-mosi = <&gpio 10 GPIO_ACTIVE_HIGH>;
> +               gpio-miso = <&gpio 9 GPIO_ACTIVE_HIGH>;
> +               cs-gpios = <&gpio 7 GPIO_ACTIVE_LOW>;
> +               num-chipselects = <1>;
> +               spi-delay-us = <1>;
> +
> +               /* Infineon SLB9672 TPM on CS1 */
> +               tpm@0 {
> +                       compatible = "infineon,slb9672", "tcg,tpm-tis-spi";
> +                       reg = <0>;
> +                       spi-max-frequency = <10000000>;
> +                       status = "okay";
> +                       bootph-all;
> +               };
> +       };
> +};
> +
> +&gpio {
> +       bootph-all;
> +};
> diff --git a/arch/arm/dts/bcm2711-rpi-4-b.dts b/arch/arm/dts/bcm2711-rpi-4-b.dts
> index 72ce80fbf26..a09276dc279 100644
> --- a/arch/arm/dts/bcm2711-rpi-4-b.dts
> +++ b/arch/arm/dts/bcm2711-rpi-4-b.dts
> @@ -8,6 +8,11 @@
>         compatible = "raspberrypi,4-model-b", "brcm,bcm2711";
>         model = "Raspberry Pi 4 Model B";
>
> +       /* Alias hardware SPI as spi0 so wolfTPM finds it at bus 0 */
> +       aliases {
> +               spi0 = &spi;
> +       };
> +
>         chosen {
>                 /* 8250 auxiliary UART instead of pl011 */
>                 stdout-path = "serial1:115200n8";
> @@ -54,6 +59,21 @@
>                 enable-active-high;
>                 gpio = <&expgpio 6 GPIO_ACTIVE_HIGH>;
>         };
> +
> +};
> +
> +/* Hardware SPI with TPM - matches Linux tpm-slb9670 overlay */
> +&spi {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&spi0_gpio7>;
> +
> +       /* Infineon SLB9670/9672 TPM 2.0 on CE1 (GPIO7) */
> +       tpm@1 {
> +               compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
> +               reg = <1>;  /* CE1 */
> +               spi-max-frequency = <32000000>;
> +       };
>  };
>
>  &ddc0 {
> diff --git a/arch/arm/dts/qemu-arm64.dts b/arch/arm/dts/qemu-arm64.dts
> index 95fcf53ed74..e74d036a532 100644
> --- a/arch/arm/dts/qemu-arm64.dts
> +++ b/arch/arm/dts/qemu-arm64.dts
> @@ -12,4 +12,8 @@
>  #endif
>
>  / {
> +       tpm@0c000000 {
> +               compatible = "tcg,tpm-tis-mmio";
> +               reg = <0x0 0x0c000000 0x0 0x5000>;
> +       };
>  };
> diff --git a/arch/sandbox/dts/sandbox.dtsi b/arch/sandbox/dts/sandbox.dtsi
> index 02b03894eaf..2fdd7f0e942 100644
> --- a/arch/sandbox/dts/sandbox.dtsi
> +++ b/arch/sandbox/dts/sandbox.dtsi
> @@ -286,6 +286,17 @@
>                         spi-max-frequency = <40000000>;
>                         sandbox,filename = "spi.bin";
>                 };
> +
> +               tpm_spi: tpm@1 {
> +                       reg = <1>;
> +                       compatible = "sandbox,tpm-spi";
> +                       spi-max-frequency = <10000000>;
> +                       sandbox,emul = <&tpm_spi_emul>;
> +               };
> +       };
> +
> +       tpm_spi_emul: tpm-spi-emul {
> +               compatible = "sandbox,tpm-spi-emul";
>         };
>
>         spl-test {
> --
> 2.47.3
>
