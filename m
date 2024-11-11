Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFDAD2E9D4
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 10:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 129268902D;
	Mon, 11 Nov 2024 11:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UyUBcqUd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8712F8932A; Mon, 11 Nov 2024 11:27:22 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA17D88B9E
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 11:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731320822; x=1731925622; i=xypron.glpk@gmx.de;
 bh=XBGgzsaxH3Dpt2U2lvVUT6+tbIfbeq0F+gwkWJrKHnA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UyUBcqUdjLseThI8USMQFIMMpXuhLjyrbwYK/rRW966CMAsJs8PR1cfvCprNf61o
 T2Xm6hbvgSZJ4FBeA6h90dUDsDCIlSB77XrBCMJdKUWePo7XgD65L8QRDI8yYi7O2
 IJSCuFaX3kxqorhZugJzZp9ncUdxA28MBSqtC1jQviD8hUie6J7OSpJ4YxstWg0GF
 /RjTe1/DgB60x++YLhB9T0hECoqNUd78RbyAmRGrBDj9Ih1PUn2okilCeVtAcD7df
 h4YscEQSpLo8SMLCEJlVVWJMiYBSWgDcRN1ap71AwRNp/c45hqq175r5zzgrgEBXs
 72bJbyInhnnaa8/iZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHEJ-1thYC517V5-00eIpa; Mon, 11
 Nov 2024 11:27:02 +0100
Message-ID: <e152cc16-7501-4c60-92e7-d967a03bcfc9@gmx.de>
Date: Mon, 11 Nov 2024 11:26:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/13] riscv: dts: jh7110: Drop redundant devicetree
 files
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 H Bell <dmoo_dv@protonmail.com>, E Shattow <lucent@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
 <20241111020808.38974-3-hal.feng@starfivetech.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241111020808.38974-3-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M5adnJwlzBQMSukMsNRM8qOKOYFPNLr5miqjb9CEbjONG9qI8JI
 PCi8vS56NlySp1HWsE4jrJ6pC3YD0fx91eZr9KYDud6m8553WU1jxQV6f5wnQ+5qNE4MV1s
 NMtKrSv1gTOsXEbedacQ1jcgZrJLc+YLtNFpRX3VOtm2vWtIoeBWcQn2QGvAtJTYAxX/a2y
 EUMIUcP5a85ko/3SP1Xbg==
UI-OutboundReport: notjunk:1;M01:P0:97EcR5V8etE=;StUHsNI7Icdk6ohCBUm/MZvgy15
 sRPgLhhPwu/qb7CCS6brm2PLlAcV+4eZq3b37wRYnRqSqpLu0U3N1q4M+MYYeg+zsGq4taqhA
 LsVxuMjn3tBHU/WgUJ58p8v4YNZbnjFkXuUmvtH390JGZ9eTWzHVmJTgoxfJ+XR1q/SKDJrRB
 uDRb6t9McXKN42eRoRhySW81XkCfyIoU3E3ua4TUkKd67kzW5OxPeo4IY0PmIiOVye1V5vBZ/
 33HJ0VxsPVJxlOjlth6h4GRhrGPvOHfdm62+xUcjAI+B6n2UJyruz1FAlvLr4BqOs4NDFeNUb
 gLNdniP2dq6TsYnEQ4CO5bAL5C1lcQxheL9ZFkN8BIX7XIcBV7J4f0N2ddup5XECfQ2iTzsiM
 H21DnqC5ACZqrokWVAFW5MaTZCEe0sz12DQWo573pCI5CGKAQziCfCcNP8hnbw4KL//Yv19ye
 af4tnL5lXW5o5lBIc/OOaEuN8wPJJ33hDPSaUtkK/iXG2C0PDmduftiNFq06Cq8nnvJCFdWLo
 YM0hpg71tXTLxKDU5Vms/z+XbXEAPFLfPVAAOBzH+h9GBi4YF6/Lb48tC6+mV2uK0FT4UcrB3
 VhAgRhksFRHcCvTNoWeeD8PIBSWp5qqj90IL8TNR8K9CnJ12z9h3piOzwboLQ3XX/uhGKz66t
 FvnKb7v06ksGr1HpQ0Q15oaVN4e0oV0Arw48FqNBRVbY6oqLXMgCZoCvMUBwGKb4FFf8d6W27
 qXWfYYBQWe8E4Q/REac2nPJc1zWUziVH99rkZr46WmzLocKQrJRuhnWxD0D1F/HH2T6bPfnQe
 lQBQB+cuUp2QdNeiIGwAemX3cQq4sjKyV+JkISblf3sjGRE7mMpzIbkik7XdHoLohGI3hUwT6
 PwTNr4n4G9MrKyD82oWPmiD24MqOYua6vlerGbYww8g+bxxCRfGof/fu/
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

On 11/11/24 03:07, Hal Feng wrote:
> JH7110 boards switch to using upstream DT, so drop
> redundant DT files from arch/riscv/dts/.
>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

I added paches 1/13 and 2/13 to origin/master.

make starfive_visionfive2_defconfig
make

yielded the following error:

   DTC
dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb
Error: dts/upstream/src/riscv/starfive/jh7110.dtsi:518.15-16 syntax error
FATAL ERROR: Unable to parse input tree
Check
/home/zfsdt/workspace/u-boot-build/denx/dts/upstream/src/riscv/starfive/.j=
h7110-starfive-visionfive-2-v1.3b.dtb.pre.tmp
for errors
make[2]: *** [scripts/Makefile.lib:423:
dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb]
Error 1
make[1]: *** [dts/Makefile:60: arch-dtbs] Error 2
make: *** [Makefile:1175: dts/dt.dtb] Error 2
make: *** Waiting for unfinished jobs....

include/dt-bindings/clock/starfive,jh7110-crg.h
which does *not* include the symbol JH7110_SYSCLK_TDM_TDM is evaluated
instead of
dts/upstream/include/dt-bindings/clock/starfive,jh7110-crg.h
which contains the symbol JH7110_SYSCLK_TDM_TDM.

We want git bisect to work. Hence we must ensure that after each
individual patch building works.

Before merging the series we need a patch ensuring that upstream
includes are used.

Best regards

Heinrich

> ---
>   arch/riscv/dts/Makefile                       |   1 -
>   .../dts/jh7110-starfive-visionfive-2.dts      |  11 -
>   .../dts/jh7110-starfive-visionfive-2.dtsi     | 380 ---------
>   arch/riscv/dts/jh7110.dtsi                    | 761 ------------------
>   4 files changed, 1153 deletions(-)
>   delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dts
>   delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
>   delete mode 100644 arch/riscv/dts/jh7110.dtsi
>
> diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
> index de356584bf..07ebe530bd 100644
> --- a/arch/riscv/dts/Makefile
> +++ b/arch/riscv/dts/Makefile
> @@ -7,7 +7,6 @@ dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) +=3D openpiton-ri=
scv64.dtb
>   dtb-$(CONFIG_TARGET_SIFIVE_UNLEASHED) +=3D hifive-unleashed-a00.dtb
>   dtb-$(CONFIG_TARGET_SIFIVE_UNMATCHED) +=3D hifive-unmatched-a00.dtb
>   dtb-$(CONFIG_TARGET_SIPEED_MAIX) +=3D k210-maix-bit.dtb
> -dtb-$(CONFIG_TARGET_STARFIVE_VISIONFIVE2) +=3D jh7110-starfive-visionfi=
ve-2.dtb
>   dtb-$(CONFIG_TARGET_TH1520_LPI4A) +=3D th1520-lichee-pi-4a.dtb
>   dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv32.dtb
>   dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv64.dtb
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dts b/arch/risc=
v/dts/jh7110-starfive-visionfive-2.dts
> deleted file mode 100644
> index 288ea39493..0000000000
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dts
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0 OR MIT
> -/*
> - * Copyright (C) 2023 StarFive Technology Co., Ltd.
> - */
> -
> -/dts-v1/;
> -#include "jh7110-starfive-visionfive-2.dtsi"
> -
> -/ {
> -	compatible =3D "starfive,visionfive-2-v1.3b", "starfive,jh7110";
> -};
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/ris=
cv/dts/jh7110-starfive-visionfive-2.dtsi
> deleted file mode 100644
> index e11babc1cd..0000000000
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> +++ /dev/null
> @@ -1,380 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0 OR MIT
> -/*
> - * Copyright (C) 2022 StarFive Technology Co., Ltd.
> - */
> -
> -/dts-v1/;
> -
> -#include "jh7110.dtsi"
> -#include <dt-bindings/pinctrl/pinctrl-starfive-jh7110.h>
> -#include <dt-bindings/gpio/gpio.h>
> -/ {
> -	aliases {
> -		serial0 =3D &uart0;
> -		spi0 =3D &qspi;
> -		mmc0 =3D &mmc0;
> -		mmc1 =3D &mmc1;
> -		i2c0 =3D &i2c0;
> -		i2c2 =3D &i2c2;
> -		i2c5 =3D &i2c5;
> -		i2c6 =3D &i2c6;
> -		ethernet0 =3D &gmac0;
> -		ethernet1 =3D &gmac1;
> -	};
> -
> -	chosen {
> -		stdout-path =3D "serial0:115200n8";
> -	};
> -
> -	cpus {
> -		timebase-frequency =3D <4000000>;
> -	};
> -
> -	memory@40000000 {
> -		device_type =3D "memory";
> -		reg =3D <0x0 0x40000000 0x2 0x0>;
> -	};
> -
> -	gpio-restart {
> -		compatible =3D "gpio-restart";
> -		gpios =3D <&sysgpio 35 GPIO_ACTIVE_HIGH>;
> -	};
> -};
> -
> -&osc {
> -	clock-frequency =3D <24000000>;
> -};
> -
> -&rtc_osc {
> -	clock-frequency =3D <32768>;
> -};
> -
> -&gmac0_rmii_refin {
> -	clock-frequency =3D <50000000>;
> -};
> -
> -&gmac0_rgmii_rxin {
> -	clock-frequency =3D <125000000>;
> -};
> -
> -&gmac1_rmii_refin {
> -	clock-frequency =3D <50000000>;
> -};
> -
> -&gmac1_rgmii_rxin {
> -	clock-frequency =3D <125000000>;
> -};
> -
> -&i2stx_bclk_ext {
> -	clock-frequency =3D <12288000>;
> -};
> -
> -&i2stx_lrck_ext {
> -	clock-frequency =3D <192000>;
> -};
> -
> -&i2srx_bclk_ext {
> -	clock-frequency =3D <12288000>;
> -};
> -
> -&i2srx_lrck_ext {
> -	clock-frequency =3D <192000>;
> -};
> -
> -&tdm_ext {
> -	clock-frequency =3D <49152000>;
> -};
> -
> -&mclk_ext {
> -	clock-frequency =3D <12288000>;
> -};
> -
> -&uart0 {
> -	reg-offset =3D <0>;
> -	current-speed =3D <115200>;
> -	clock-frequency =3D <24000000>;
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&uart0_pins>;
> -	status =3D "okay";
> -};
> -
> -&i2c0 {
> -	clock-frequency =3D <100000>;
> -	i2c-sda-hold-time-ns =3D <300>;
> -	i2c-sda-falling-time-ns =3D <510>;
> -	i2c-scl-falling-time-ns =3D <510>;
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&i2c0_pins>;
> -	status =3D "okay";
> -};
> -
> -&i2c2 {
> -	clock-frequency =3D <100000>;
> -	i2c-sda-hold-time-ns =3D <300>;
> -	i2c-sda-falling-time-ns =3D <510>;
> -	i2c-scl-falling-time-ns =3D <510>;
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&i2c2_pins>;
> -	status =3D "okay";
> -};
> -
> -&i2c5 {
> -	clock-frequency =3D <100000>;
> -	i2c-sda-hold-time-ns =3D <300>;
> -	i2c-sda-falling-time-ns =3D <510>;
> -	i2c-scl-falling-time-ns =3D <510>;
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&i2c5_pins>;
> -	status =3D "okay";
> -
> -	pmic@36 {
> -		compatible =3D "x-powers,axp15060";
> -		reg =3D <0x36>;
> -	};
> -
> -	eeprom@50 {
> -		compatible =3D "atmel,24c04";
> -		reg =3D <0x50>;
> -		pagesize =3D <16>;
> -	};
> -};
> -
> -&i2c6 {
> -	clock-frequency =3D <100000>;
> -	i2c-sda-hold-time-ns =3D <300>;
> -	i2c-sda-falling-time-ns =3D <510>;
> -	i2c-scl-falling-time-ns =3D <510>;
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&i2c6_pins>;
> -	status =3D "okay";
> -};
> -
> -&sysgpio {
> -	status =3D "okay";
> -	uart0_pins: uart0-0 {
> -		tx-pins {
> -			pinmux =3D <GPIOMUX(5, GPOUT_SYS_UART0_TX,
> -					     GPOEN_ENABLE,
> -					     GPI_NONE)>;
> -			bias-disable;
> -			drive-strength =3D <12>;
> -			input-disable;
> -			input-schmitt-disable;
> -			slew-rate =3D <0>;
> -		};
> -
> -		rx-pins {
> -			pinmux =3D <GPIOMUX(6, GPOUT_LOW,
> -					     GPOEN_DISABLE,
> -					     GPI_SYS_UART0_RX)>;
> -			bias-disable; /* external pull-up */
> -			drive-strength =3D <2>;
> -			input-enable;
> -			input-schmitt-enable;
> -			slew-rate =3D <0>;
> -		};
> -	};
> -
> -	i2c0_pins: i2c0-0 {
> -		i2c-pins {
> -			pinmux =3D <GPIOMUX(57, GPOUT_LOW,
> -					      GPOEN_SYS_I2C0_CLK,
> -					      GPI_SYS_I2C0_CLK)>,
> -				 <GPIOMUX(58, GPOUT_LOW,
> -					      GPOEN_SYS_I2C0_DATA,
> -					      GPI_SYS_I2C0_DATA)>;
> -			bias-disable; /* external pull-up */
> -			input-enable;
> -			input-schmitt-enable;
> -		};
> -	};
> -
> -	i2c2_pins: i2c2-0 {
> -		i2c-pins {
> -			pinmux =3D <GPIOMUX(3, GPOUT_LOW,
> -					     GPOEN_SYS_I2C2_CLK,
> -					     GPI_SYS_I2C2_CLK)>,
> -				 <GPIOMUX(2, GPOUT_LOW,
> -					     GPOEN_SYS_I2C2_DATA,
> -					     GPI_SYS_I2C2_DATA)>;
> -			bias-disable; /* external pull-up */
> -			input-enable;
> -			input-schmitt-enable;
> -		};
> -	};
> -
> -	i2c5_pins: i2c5-0 {
> -		i2c-pins {
> -			pinmux =3D <GPIOMUX(19, GPOUT_LOW,
> -					      GPOEN_SYS_I2C5_CLK,
> -					      GPI_SYS_I2C5_CLK)>,
> -				 <GPIOMUX(20, GPOUT_LOW,
> -					      GPOEN_SYS_I2C5_DATA,
> -					      GPI_SYS_I2C5_DATA)>;
> -			bias-disable; /* external pull-up */
> -			input-enable;
> -			input-schmitt-enable;
> -		};
> -	};
> -
> -	i2c6_pins: i2c6-0 {
> -		i2c-pins {
> -			pinmux =3D <GPIOMUX(16, GPOUT_LOW,
> -					      GPOEN_SYS_I2C6_CLK,
> -					      GPI_SYS_I2C6_CLK)>,
> -				 <GPIOMUX(17, GPOUT_LOW,
> -					      GPOEN_SYS_I2C6_DATA,
> -					      GPI_SYS_I2C6_DATA)>;
> -			bias-disable; /* external pull-up */
> -			input-enable;
> -			input-schmitt-enable;
> -		};
> -	};
> -
> -	mmc0_pins: mmc0-pins {
> -		 mmc0-pins-rest {
> -			pinmux =3D <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> -					      GPOEN_ENABLE, GPI_NONE)>;
> -			bias-pull-up;
> -			drive-strength =3D <12>;
> -			input-disable;
> -			input-schmitt-disable;
> -			slew-rate =3D <0>;
> -		};
> -	};
> -
> -	mmc1_pins: mmc1-pins {
> -		mmc1-pins0 {
> -			pinmux =3D <GPIOMUX(10, GPOUT_SYS_SDIO1_CLK,
> -					      GPOEN_ENABLE, GPI_NONE)>;
> -			bias-pull-up;
> -			drive-strength =3D <12>;
> -			input-disable;
> -			input-schmitt-disable;
> -			slew-rate =3D <0>;
> -		};
> -
> -		mmc1-pins1 {
> -			pinmux =3D <GPIOMUX(9, GPOUT_SYS_SDIO1_CMD,
> -					     GPOEN_SYS_SDIO1_CMD, GPI_SYS_SDIO1_CMD)>,
> -				<GPIOMUX(11, GPOUT_SYS_SDIO1_DATA0,
> -					     GPOEN_SYS_SDIO1_DATA0, GPI_SYS_SDIO1_DATA0)>,
> -				<GPIOMUX(12, GPOUT_SYS_SDIO1_DATA1,
> -					     GPOEN_SYS_SDIO1_DATA1, GPI_SYS_SDIO1_DATA1)>,
> -				<GPIOMUX(7, GPOUT_SYS_SDIO1_DATA2,
> -					     GPOEN_SYS_SDIO1_DATA2, GPI_SYS_SDIO1_DATA2)>,
> -				<GPIOMUX(8, GPOUT_SYS_SDIO1_DATA3,
> -					     GPOEN_SYS_SDIO1_DATA3, GPI_SYS_SDIO1_DATA3)>;
> -			bias-pull-up;
> -			drive-strength =3D <12>;
> -			input-enable;
> -			input-schmitt-enable;
> -			slew-rate =3D <0>;
> -		};
> -	};
> -};
> -
> -&mmc0 {
> -	compatible =3D "snps,dw-mshc";
> -	max-frequency =3D <100000000>;
> -	bus-width =3D <8>;
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&mmc0_pins>;
> -	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
> -	mmc-hs200-1_8v;
> -	non-removable;
> -	cap-mmc-hw-reset;
> -	post-power-on-delay-ms =3D <200>;
> -	status =3D "okay";
> -
> -};
> -
> -&mmc1 {
> -	compatible =3D "snps,dw-mshc";
> -	max-frequency =3D <100000000>;
> -	bus-width =3D <4>;
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&mmc1_pins>;
> -	no-sdio;
> -	no-mmc;
> -	cd-gpios =3D <&sysgpio 41 GPIO_ACTIVE_LOW>;
> -	cap-sd-highspeed;
> -	post-power-on-delay-ms =3D <200>;
> -	status =3D "okay";
> -};
> -
> -&qspi {
> -	spi-max-frequency =3D <250000000>;
> -	status =3D "okay";
> -
> -	nor-flash@0 {
> -		compatible =3D "jedec,spi-nor";
> -		reg=3D<0>;
> -		spi-max-frequency =3D <100000000>;
> -		cdns,tshsl-ns =3D <1>;
> -		cdns,tsd2d-ns =3D <1>;
> -		cdns,tchsh-ns =3D <1>;
> -		cdns,tslch-ns =3D <1>;
> -	};
> -};
> -
> -&pcie0 {
> -	reset-gpios =3D <&sysgpio 26 GPIO_ACTIVE_LOW>;
> -	status =3D "okay";
> -};
> -
> -&pcie1 {
> -	reset-gpios =3D <&sysgpio 28 GPIO_ACTIVE_LOW>;
> -	status =3D "okay";
> -};
> -
> -&syscrg {
> -	assigned-clocks =3D <&syscrg JH7110_SYSCLK_CPU_ROOT>,
> -			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
> -			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
> -			  <&syscrg JH7110_SYSCLK_QSPI_REF>;
> -	assigned-clock-parents =3D <&pllclk JH7110_SYSCLK_PLL0_OUT>,
> -				 <&pllclk JH7110_SYSCLK_PLL2_OUT>,
> -				 <&pllclk JH7110_SYSCLK_PLL2_OUT>,
> -				 <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
> -	assigned-clock-rates =3D <0>, <0>, <0>, <0>;
> -};
> -
> -&aoncrg {
> -	assigned-clocks =3D <&aoncrg JH7110_AONCLK_APB_FUNC>;
> -	assigned-clock-parents =3D <&osc>;
> -	assigned-clock-rates =3D <0>;
> -};
> -
> -&gmac0 {
> -	phy-handle =3D <&phy0>;
> -	phy-mode =3D "rgmii-id";
> -	status =3D "okay";
> -
> -	mdio {
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		compatible =3D "snps,dwmac-mdio";
> -
> -		phy0: ethernet-phy@0 {
> -			reg =3D <0>;
> -		};
> -	};
> -};
> -
> -&gmac1 {
> -	phy-handle =3D <&phy1>;
> -	phy-mode =3D "rgmii-id";
> -	status =3D "okay";
> -
> -	mdio {
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		compatible =3D "snps,dwmac-mdio";
> -
> -		phy1: ethernet-phy@1 {
> -			reg =3D <0>;
> -		};
> -	};
> -};
> diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
> deleted file mode 100644
> index 2cdc683d49..0000000000
> --- a/arch/riscv/dts/jh7110.dtsi
> +++ /dev/null
> @@ -1,761 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0 OR MIT
> -/*
> - * Copyright (C) 2022 StarFive Technology Co., Ltd.
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/clock/starfive,jh7110-crg.h>
> -#include <dt-bindings/reset/starfive,jh7110-crg.h>
> -
> -/ {
> -	compatible =3D "starfive,jh7110";
> -	#address-cells =3D <2>;
> -	#size-cells =3D <2>;
> -
> -	cpus {
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -
> -		S7_0: cpu@0 {
> -			compatible =3D "sifive,s7", "riscv";
> -			reg =3D <0>;
> -			device_type =3D "cpu";
> -			i-cache-block-size =3D <64>;
> -			i-cache-sets =3D <64>;
> -			i-cache-size =3D <16384>;
> -			next-level-cache =3D <&ccache>;
> -			riscv,isa =3D "rv64imac_zba_zbb";
> -			status =3D "disabled";
> -
> -			cpu0_intc: interrupt-controller {
> -				compatible =3D "riscv,cpu-intc";
> -				interrupt-controller;
> -				#interrupt-cells =3D <1>;
> -			};
> -		};
> -
> -		U74_1: cpu@1 {
> -			compatible =3D "sifive,u74-mc", "riscv";
> -			reg =3D <1>;
> -			d-cache-block-size =3D <64>;
> -			d-cache-sets =3D <64>;
> -			d-cache-size =3D <32768>;
> -			d-tlb-sets =3D <1>;
> -			d-tlb-size =3D <40>;
> -			device_type =3D "cpu";
> -			i-cache-block-size =3D <64>;
> -			i-cache-sets =3D <64>;
> -			i-cache-size =3D <32768>;
> -			i-tlb-sets =3D <1>;
> -			i-tlb-size =3D <40>;
> -			mmu-type =3D "riscv,sv39";
> -			next-level-cache =3D <&ccache>;
> -			riscv,isa =3D "rv64imafdc_zba_zbb";
> -			tlb-split;
> -
> -			cpu1_intc: interrupt-controller {
> -				compatible =3D "riscv,cpu-intc";
> -				interrupt-controller;
> -				#interrupt-cells =3D <1>;
> -			};
> -		};
> -
> -		U74_2: cpu@2 {
> -			compatible =3D "sifive,u74-mc", "riscv";
> -			reg =3D <2>;
> -			d-cache-block-size =3D <64>;
> -			d-cache-sets =3D <64>;
> -			d-cache-size =3D <32768>;
> -			d-tlb-sets =3D <1>;
> -			d-tlb-size =3D <40>;
> -			device_type =3D "cpu";
> -			i-cache-block-size =3D <64>;
> -			i-cache-sets =3D <64>;
> -			i-cache-size =3D <32768>;
> -			i-tlb-sets =3D <1>;
> -			i-tlb-size =3D <40>;
> -			mmu-type =3D "riscv,sv39";
> -			next-level-cache =3D <&ccache>;
> -			riscv,isa =3D "rv64imafdc_zba_zbb";
> -			tlb-split;
> -
> -			cpu2_intc: interrupt-controller {
> -				compatible =3D "riscv,cpu-intc";
> -				interrupt-controller;
> -				#interrupt-cells =3D <1>;
> -			};
> -		};
> -
> -		U74_3: cpu@3 {
> -			compatible =3D "sifive,u74-mc", "riscv";
> -			reg =3D <3>;
> -			d-cache-block-size =3D <64>;
> -			d-cache-sets =3D <64>;
> -			d-cache-size =3D <32768>;
> -			d-tlb-sets =3D <1>;
> -			d-tlb-size =3D <40>;
> -			device_type =3D "cpu";
> -			i-cache-block-size =3D <64>;
> -			i-cache-sets =3D <64>;
> -			i-cache-size =3D <32768>;
> -			i-tlb-sets =3D <1>;
> -			i-tlb-size =3D <40>;
> -			mmu-type =3D "riscv,sv39";
> -			next-level-cache =3D <&ccache>;
> -			riscv,isa =3D "rv64imafdc_zba_zbb";
> -			tlb-split;
> -
> -			cpu3_intc: interrupt-controller {
> -				compatible =3D "riscv,cpu-intc";
> -				interrupt-controller;
> -				#interrupt-cells =3D <1>;
> -			};
> -		};
> -
> -		U74_4: cpu@4 {
> -			compatible =3D "sifive,u74-mc", "riscv";
> -			reg =3D <4>;
> -			d-cache-block-size =3D <64>;
> -			d-cache-sets =3D <64>;
> -			d-cache-size =3D <32768>;
> -			d-tlb-sets =3D <1>;
> -			d-tlb-size =3D <40>;
> -			device_type =3D "cpu";
> -			i-cache-block-size =3D <64>;
> -			i-cache-sets =3D <64>;
> -			i-cache-size =3D <32768>;
> -			i-tlb-sets =3D <1>;
> -			i-tlb-size =3D <40>;
> -			mmu-type =3D "riscv,sv39";
> -			next-level-cache =3D <&ccache>;
> -			riscv,isa =3D "rv64imafdc_zba_zbb";
> -			tlb-split;
> -
> -			cpu4_intc: interrupt-controller {
> -				compatible =3D "riscv,cpu-intc";
> -				interrupt-controller;
> -				#interrupt-cells =3D <1>;
> -			};
> -		};
> -
> -		cpu-map {
> -			cluster0 {
> -				core0 {
> -					cpu =3D <&S7_0>;
> -				};
> -
> -				core1 {
> -					cpu =3D <&U74_1>;
> -				};
> -
> -				core2 {
> -					cpu =3D <&U74_2>;
> -				};
> -
> -				core3 {
> -					cpu =3D <&U74_3>;
> -				};
> -
> -				core4 {
> -					cpu =3D <&U74_4>;
> -				};
> -			};
> -		};
> -	};
> -
> -	timer {
> -		compatible =3D "riscv,timer";
> -		interrupts-extended =3D <&cpu0_intc 5>,
> -				      <&cpu1_intc 5>,
> -				      <&cpu2_intc 5>,
> -				      <&cpu3_intc 5>,
> -				      <&cpu4_intc 5>;
> -	};
> -
> -	osc: oscillator {
> -		compatible =3D "fixed-clock";
> -		clock-output-names =3D "osc";
> -		#clock-cells =3D <0>;
> -	};
> -
> -	rtc_osc: rtc-oscillator {
> -		compatible =3D "fixed-clock";
> -		clock-output-names =3D "rtc_osc";
> -		#clock-cells =3D <0>;
> -	};
> -
> -	gmac0_rmii_refin: gmac0-rmii-refin-clock {
> -		compatible =3D "fixed-clock";
> -		clock-output-names =3D "gmac0_rmii_refin";
> -		#clock-cells =3D <0>;
> -	};
> -
> -	gmac0_rgmii_rxin: gmac0-rgmii-rxin-clock {
> -		compatible =3D "fixed-clock";
> -		clock-output-names =3D "gmac0_rgmii_rxin";
> -		#clock-cells =3D <0>;
> -	};
> -
> -	gmac1_rmii_refin: gmac1-rmii-refin-clock {
> -		compatible =3D "fixed-clock";
> -		clock-output-names =3D "gmac1_rmii_refin";
> -		#clock-cells =3D <0>;
> -	};
> -
> -	gmac1_rgmii_rxin: gmac1-rgmii-rxin-clock {
> -		compatible =3D "fixed-clock";
> -		clock-output-names =3D "gmac1_rgmii_rxin";
> -		#clock-cells =3D <0>;
> -	};
> -
> -	i2stx_bclk_ext: i2stx-bclk-ext-clock {
> -		compatible =3D "fixed-clock";
> -		clock-output-names =3D "i2stx_bclk_ext";
> -		#clock-cells =3D <0>;
> -	};
> -
> -	i2stx_lrck_ext: i2stx-lrck-ext-clock {
> -		compatible =3D "fixed-clock";
> -		clock-output-names =3D "i2stx_lrck_ext";
> -		#clock-cells =3D <0>;
> -	};
> -
> -	i2srx_bclk_ext: i2srx-bclk-ext-clock {
> -		compatible =3D "fixed-clock";
> -		clock-output-names =3D "i2srx_bclk_ext";
> -		#clock-cells =3D <0>;
> -	};
> -
> -	i2srx_lrck_ext: i2srx-lrck-ext-clock {
> -		compatible =3D "fixed-clock";
> -		clock-output-names =3D "i2srx_lrck_ext";
> -		#clock-cells =3D <0>;
> -	};
> -
> -	tdm_ext: tdm-ext-clock {
> -		compatible =3D "fixed-clock";
> -		clock-output-names =3D "tdm_ext";
> -		#clock-cells =3D <0>;
> -	};
> -
> -	mclk_ext: mclk-ext-clock {
> -		compatible =3D "fixed-clock";
> -		clock-output-names =3D "mclk_ext";
> -		#clock-cells =3D <0>;
> -	};
> -
> -	stmmac_axi_setup: stmmac-axi-config {
> -		snps,lpi_en;
> -		snps,wr_osr_lmt =3D <4>;
> -		snps,rd_osr_lmt =3D <4>;
> -		snps,blen =3D <256 128 64 32 0 0 0>;
> -	};
> -
> -	soc {
> -		compatible =3D "simple-bus";
> -		interrupt-parent =3D <&plic>;
> -		#address-cells =3D <2>;
> -		#size-cells =3D <2>;
> -		ranges;
> -
> -		clint: timer@2000000 {
> -			compatible =3D "starfive,jh7110-clint", "sifive,clint0";
> -			reg =3D <0x0 0x2000000 0x0 0x10000>;
> -			interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_intc 7>,
> -					      <&cpu1_intc 3>, <&cpu1_intc 7>,
> -					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> -					      <&cpu3_intc 3>, <&cpu3_intc 7>,
> -					      <&cpu4_intc 3>, <&cpu4_intc 7>;
> -		};
> -
> -		plic: interrupt-controller@c000000 {
> -			compatible =3D "starfive,jh7110-plic", "sifive,plic-1.0.0";
> -			reg =3D <0x0 0xc000000 0x0 0x4000000>;
> -			interrupts-extended =3D <&cpu0_intc 11>,
> -					      <&cpu1_intc 11>, <&cpu1_intc 9>,
> -					      <&cpu2_intc 11>, <&cpu2_intc 9>,
> -					      <&cpu3_intc 11>, <&cpu3_intc 9>,
> -					      <&cpu4_intc 11>, <&cpu4_intc 9>;
> -			interrupt-controller;
> -			#interrupt-cells =3D <1>;
> -			#address-cells =3D <0>;
> -			riscv,ndev =3D <136>;
> -		};
> -
> -		ccache: cache-controller@2010000 {
> -			compatible =3D "starfive,jh7110-ccache", "sifive,ccache0", "cache";
> -			reg =3D <0x0 0x2010000 0x0 0x4000>;
> -			interrupts =3D <1>, <3>, <4>, <2>;
> -			cache-block-size =3D <64>;
> -			cache-level =3D <2>;
> -			cache-sets =3D <2048>;
> -			cache-size =3D <2097152>;
> -			cache-unified;
> -		};
> -
> -		uart0: serial@10000000 {
> -			compatible =3D "snps,dw-apb-uart";
> -			reg =3D <0x0 0x10000000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_UART0_CORE>,
> -				 <&syscrg JH7110_SYSCLK_UART0_APB>;
> -			clock-names =3D "baudclk", "apb_pclk";
> -			resets =3D <&syscrg JH7110_SYSRST_UART0_APB>,
> -				 <&syscrg JH7110_SYSRST_UART0_CORE>;
> -			interrupts =3D <32>;
> -			reg-io-width =3D <4>;
> -			reg-shift =3D <2>;
> -			status =3D "disabled";
> -		};
> -
> -		uart1: serial@10010000 {
> -			compatible =3D "snps,dw-apb-uart";
> -			reg =3D <0x0 0x10010000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_UART1_CORE>,
> -				 <&syscrg JH7110_SYSCLK_UART1_APB>;
> -			clock-names =3D "baudclk", "apb_pclk";
> -			resets =3D <&syscrg JH7110_SYSRST_UART1_APB>,
> -				 <&syscrg JH7110_SYSRST_UART1_CORE>;
> -			interrupts =3D <33>;
> -			reg-io-width =3D <4>;
> -			reg-shift =3D <2>;
> -			status =3D "disabled";
> -		};
> -
> -		uart2: serial@10020000 {
> -			compatible =3D "snps,dw-apb-uart";
> -			reg =3D <0x0 0x10020000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_UART2_CORE>,
> -				 <&syscrg JH7110_SYSCLK_UART2_APB>;
> -			clock-names =3D "baudclk", "apb_pclk";
> -			resets =3D <&syscrg JH7110_SYSRST_UART2_APB>,
> -				 <&syscrg JH7110_SYSRST_UART2_CORE>;
> -			interrupts =3D <34>;
> -			reg-io-width =3D <4>;
> -			reg-shift =3D <2>;
> -			status =3D "disabled";
> -		};
> -
> -		i2c0: i2c@10030000 {
> -			compatible =3D "snps,designware-i2c";
> -			reg =3D <0x0 0x10030000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_I2C0_APB>;
> -			clock-names =3D "ref";
> -			resets =3D <&syscrg JH7110_SYSRST_I2C0_APB>;
> -			interrupts =3D <35>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -			status =3D "disabled";
> -		};
> -
> -		i2c1: i2c@10040000 {
> -			compatible =3D "snps,designware-i2c";
> -			reg =3D <0x0 0x10040000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_I2C1_APB>;
> -			clock-names =3D "ref";
> -			resets =3D <&syscrg JH7110_SYSRST_I2C1_APB>;
> -			interrupts =3D <36>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -			status =3D "disabled";
> -		};
> -
> -		i2c2: i2c@10050000 {
> -			compatible =3D "snps,designware-i2c";
> -			reg =3D <0x0 0x10050000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_I2C2_APB>;
> -			clock-names =3D "ref";
> -			resets =3D <&syscrg JH7110_SYSRST_I2C2_APB>;
> -			interrupts =3D <37>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -			status =3D "disabled";
> -		};
> -
> -		stgcrg: clock-controller@10230000 {
> -			compatible =3D "starfive,jh7110-stgcrg";
> -			reg =3D <0x0 0x10230000 0x0 0x10000>;
> -			#clock-cells =3D <1>;
> -			#reset-cells =3D <1>;
> -		};
> -
> -		stg_syscon: stg_syscon@10240000 {
> -			compatible =3D "starfive,jh7110-stg-syscon","syscon";
> -			reg =3D <0x0 0x10240000 0x0 0x1000>;
> -		};
> -
> -		uart3: serial@12000000 {
> -			compatible =3D "snps,dw-apb-uart";
> -			reg =3D <0x0 0x12000000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_UART3_CORE>,
> -				 <&syscrg JH7110_SYSCLK_UART3_APB>;
> -			clock-names =3D "baudclk", "apb_pclk";
> -			resets =3D <&syscrg JH7110_SYSRST_UART3_APB>,
> -				 <&syscrg JH7110_SYSRST_UART3_CORE>;
> -			interrupts =3D <45>;
> -			reg-io-width =3D <4>;
> -			reg-shift =3D <2>;
> -			status =3D "disabled";
> -		};
> -
> -		uart4: serial@12010000 {
> -			compatible =3D "snps,dw-apb-uart";
> -			reg =3D <0x0 0x12010000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_UART4_CORE>,
> -				 <&syscrg JH7110_SYSCLK_UART4_APB>;
> -			clock-names =3D "baudclk", "apb_pclk";
> -			resets =3D <&syscrg JH7110_SYSRST_UART4_APB>,
> -				 <&syscrg JH7110_SYSRST_UART4_CORE>;
> -			interrupts =3D <46>;
> -			reg-io-width =3D <4>;
> -			reg-shift =3D <2>;
> -			status =3D "disabled";
> -		};
> -
> -		uart5: serial@12020000 {
> -			compatible =3D "snps,dw-apb-uart";
> -			reg =3D <0x0 0x12020000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_UART5_CORE>,
> -				 <&syscrg JH7110_SYSCLK_UART5_APB>;
> -			clock-names =3D "baudclk", "apb_pclk";
> -			resets =3D <&syscrg JH7110_SYSRST_UART5_APB>,
> -				 <&syscrg JH7110_SYSRST_UART5_CORE>;
> -			interrupts =3D <47>;
> -			reg-io-width =3D <4>;
> -			reg-shift =3D <2>;
> -			status =3D "disabled";
> -		};
> -
> -		i2c3: i2c@12030000 {
> -			compatible =3D "snps,designware-i2c";
> -			reg =3D <0x0 0x12030000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_I2C3_APB>;
> -			clock-names =3D "ref";
> -			resets =3D <&syscrg JH7110_SYSRST_I2C3_APB>;
> -			interrupts =3D <48>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -			status =3D "disabled";
> -		};
> -
> -		i2c4: i2c@12040000 {
> -			compatible =3D "snps,designware-i2c";
> -			reg =3D <0x0 0x12040000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_I2C4_APB>;
> -			clock-names =3D "ref";
> -			resets =3D <&syscrg JH7110_SYSRST_I2C4_APB>;
> -			interrupts =3D <49>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -			status =3D "disabled";
> -		};
> -
> -		i2c5: i2c@12050000 {
> -			compatible =3D "snps,designware-i2c";
> -			reg =3D <0x0 0x12050000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_I2C5_APB>;
> -			clock-names =3D "ref";
> -			resets =3D <&syscrg JH7110_SYSRST_I2C5_APB>;
> -			interrupts =3D <50>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -			status =3D "disabled";
> -		};
> -
> -		i2c6: i2c@12060000 {
> -			compatible =3D "snps,designware-i2c";
> -			reg =3D <0x0 0x12060000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_I2C6_APB>;
> -			clock-names =3D "ref";
> -			resets =3D <&syscrg JH7110_SYSRST_I2C6_APB>;
> -			interrupts =3D <51>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -			status =3D "disabled";
> -		};
> -
> -		power-controller@17030000 {
> -			compatible =3D "starfive,jh7110-pmu";
> -			reg =3D <0x0 0x17030000 0x0 0x10000>;
> -			interrupts =3D <111>;
> -		};
> -
> -		qspi: spi@13010000 {
> -			compatible =3D "cdns,qspi-nor";
> -			reg =3D <0x0 0x13010000 0x0 0x10000
> -				0x0 0x21000000 0x0 0x400000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_QSPI_REF>;
> -			clock-names =3D "clk_ref";
> -			resets =3D <&syscrg JH7110_SYSRST_QSPI_APB>,
> -				 <&syscrg JH7110_SYSRST_QSPI_AHB>,
> -				 <&syscrg JH7110_SYSRST_QSPI_REF>;
> -			reset-names =3D "rst_apb", "rst_ahb", "rst_ref";
> -			cdns,fifo-depth =3D <256>;
> -			cdns,fifo-width =3D <4>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -		};
> -
> -		syscrg: clock-controller@13020000 {
> -			compatible =3D "starfive,jh7110-syscrg";
> -			reg =3D <0x0 0x13020000 0x0 0x10000>;
> -			clocks =3D <&osc>, <&gmac1_rmii_refin>,
> -				 <&gmac1_rgmii_rxin>,
> -				 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
> -				 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
> -				 <&tdm_ext>, <&mclk_ext>,
> -				 <&pllclk JH7110_SYSCLK_PLL0_OUT>,
> -				 <&pllclk JH7110_SYSCLK_PLL1_OUT>,
> -				 <&pllclk JH7110_SYSCLK_PLL2_OUT>;
> -			clock-names =3D "osc", "gmac1_rmii_refin",
> -				      "gmac1_rgmii_rxin",
> -				      "i2stx_bclk_ext", "i2stx_lrck_ext",
> -				      "i2srx_bclk_ext", "i2srx_lrck_ext",
> -				      "tdm_ext", "mclk_ext",
> -				      "pll0_out", "pll1_out", "pll2_out";
> -			#clock-cells =3D <1>;
> -			#reset-cells =3D <1>;
> -		};
> -
> -		sys_syscon: sys_syscon@13030000 {
> -			compatible =3D "starfive,jh7110-sys-syscon","syscon", "simple-mfd";
> -			reg =3D <0x0 0x13030000 0x0 0x1000>;
> -
> -			pllclk: clock-controller {
> -				compatible =3D "starfive,jh7110-pll";
> -				clocks =3D <&osc>;
> -				#clock-cells =3D <1>;
> -			};
> -		};
> -
> -		sysgpio: pinctrl@13040000 {
> -			compatible =3D "starfive,jh7110-sys-pinctrl";
> -			reg =3D <0x0 0x13040000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_IOMUX_APB>;
> -			resets =3D <&syscrg JH7110_SYSRST_IOMUX_APB>;
> -			interrupts =3D <86>;
> -			interrupt-controller;
> -			#interrupt-cells =3D <2>;
> -			gpio-controller;
> -			#gpio-cells =3D <2>;
> -		};
> -
> -		watchdog@13070000 {
> -			compatible =3D "starfive,jh7110-wdt";
> -			reg =3D <0x0 0x13070000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_WDT_APB>,
> -				 <&syscrg JH7110_SYSCLK_WDT_CORE>;
> -			clock-names =3D "apb", "core";
> -			resets =3D <&syscrg JH7110_SYSRST_WDT_APB>,
> -				 <&syscrg JH7110_SYSRST_WDT_CORE>;
> -		};
> -
> -		mmc0: mmc@16010000 {
> -			compatible =3D "starfive,jh7110-mmc";
> -			reg =3D <0x0 0x16010000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_SDIO0_AHB>,
> -				 <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
> -			clock-names =3D "biu", "ciu";
> -			resets =3D <&syscrg JH7110_SYSRST_SDIO0_AHB>;
> -			reset-names =3D "reset";
> -			interrupts =3D <74>;
> -			fifo-depth =3D <32>;
> -			fifo-watermark-aligned;
> -			data-addr =3D <0>;
> -			starfive,sysreg =3D <&sys_syscon 0x14 0x1a 0x7c000000>;
> -			status =3D "disabled";
> -		};
> -
> -		mmc1: mmc@16020000 {
> -			compatible =3D "starfive,jh7110-mmc";
> -			reg =3D <0x0 0x16020000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_SDIO1_AHB>,
> -				 <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
> -			clock-names =3D "biu", "ciu";
> -			resets =3D <&syscrg JH7110_SYSRST_SDIO1_AHB>;
> -			reset-names =3D "reset";
> -			interrupts =3D <75>;
> -			fifo-depth =3D <32>;
> -			fifo-watermark-aligned;
> -			data-addr =3D <0>;
> -			starfive,sysreg =3D <&sys_syscon 0x9c 0x1 0x3e>;
> -			status =3D "disabled";
> -		};
> -
> -		gmac0: ethernet@16030000 {
> -			compatible =3D "starfive,jh7110-dwmac", "snps,dwmac-5.20";
> -			reg =3D <0x0 0x16030000 0x0 0x10000>;
> -			clocks =3D <&aoncrg JH7110_AONCLK_GMAC0_AXI>,
> -				 <&aoncrg JH7110_AONCLK_GMAC0_AHB>,
> -				 <&syscrg JH7110_SYSCLK_GMAC0_PTP>,
> -				 <&aoncrg JH7110_AONCLK_GMAC0_TX_INV>,
> -				 <&syscrg JH7110_SYSCLK_GMAC0_GTXC>;
> -			clock-names =3D "stmmaceth", "pclk", "ptp_ref",
> -				      "tx", "gtx";
> -			resets =3D <&aoncrg JH7110_AONRST_GMAC0_AXI>,
> -				 <&aoncrg JH7110_AONRST_GMAC0_AHB>;
> -			reset-names =3D "stmmaceth", "ahb";
> -			interrupts =3D <7>, <6>, <5>;
> -			interrupt-names =3D "macirq", "eth_wake_irq", "eth_lpi";
> -			snps,multicast-filter-bins =3D <64>;
> -			snps,perfect-filter-entries =3D <8>;
> -			rx-fifo-depth =3D <2048>;
> -			tx-fifo-depth =3D <2048>;
> -			snps,fixed-burst;
> -			snps,no-pbl-x8;
> -			snps,force_thresh_dma_mode;
> -			snps,axi-config =3D <&stmmac_axi_setup>;
> -			snps,tso;
> -			snps,en-tx-lpi-clockgating;
> -			snps,txpbl =3D <16>;
> -			snps,rxpbl =3D <16>;
> -			starfive,syscon =3D <&aon_syscon 0xc 0x12>;
> -			status =3D "disabled";
> -		};
> -
> -		gmac1: ethernet@16040000 {
> -			compatible =3D "starfive,jh7110-dwmac", "snps,dwmac-5.20";
> -			reg =3D <0x0 0x16040000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_GMAC1_AXI>,
> -				 <&syscrg JH7110_SYSCLK_GMAC1_AHB>,
> -				 <&syscrg JH7110_SYSCLK_GMAC1_PTP>,
> -				 <&syscrg JH7110_SYSCLK_GMAC1_TX_INV>,
> -				 <&syscrg JH7110_SYSCLK_GMAC1_GTXC>;
> -			clock-names =3D "stmmaceth", "pclk", "ptp_ref",
> -				      "tx", "gtx";
> -			resets =3D <&syscrg JH7110_SYSRST_GMAC1_AXI>,
> -				 <&syscrg JH7110_SYSRST_GMAC1_AHB>;
> -			reset-names =3D "stmmaceth", "ahb";
> -			interrupts =3D <78>, <77>, <76>;
> -			interrupt-names =3D "macirq", "eth_wake_irq", "eth_lpi";
> -			snps,multicast-filter-bins =3D <64>;
> -			snps,perfect-filter-entries =3D <8>;
> -			rx-fifo-depth =3D <2048>;
> -			tx-fifo-depth =3D <2048>;
> -			snps,fixed-burst;
> -			snps,no-pbl-x8;
> -			snps,force_thresh_dma_mode;
> -			snps,axi-config =3D <&stmmac_axi_setup>;
> -			snps,tso;
> -			snps,en-tx-lpi-clockgating;
> -			snps,txpbl =3D <16>;
> -			snps,rxpbl =3D <16>;
> -			starfive,syscon =3D <&sys_syscon 0x90 0x2>;
> -			status =3D "disabled";
> -		};
> -
> -		rng: rng@1600c000 {
> -			compatible =3D "starfive,jh7110-trng";
> -			reg =3D <0x0 0x1600C000 0x0 0x4000>;
> -			clocks =3D <&stgcrg JH7110_STGCLK_SEC_HCLK>,
> -				 <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;
> -			clock-names =3D "hclk", "ahb";
> -			resets =3D <&stgcrg JH7110_STGRST_SEC_TOP_HRESETN>;
> -			interrupts =3D <30>;
> -		};
> -
> -		aoncrg: clock-controller@17000000 {
> -			compatible =3D "starfive,jh7110-aoncrg";
> -			reg =3D <0x0 0x17000000 0x0 0x10000>;
> -			clocks =3D <&osc>, <&rtc_osc>,
> -				 <&gmac0_rmii_refin>, <&gmac0_rgmii_rxin>,
> -				 <&syscrg JH7110_SYSCLK_STG_AXIAHB>,
> -				 <&syscrg JH7110_SYSCLK_APB_BUS>,
> -				 <&syscrg JH7110_SYSCLK_GMAC0_GTXCLK>;
> -			clock-names =3D "osc", "rtc_osc", "gmac0_rmii_refin",
> -				      "gmac0_rgmii_rxin", "stg_axiahb",
> -				      "apb_bus", "gmac0_gtxclk";
> -			#clock-cells =3D <1>;
> -			#reset-cells =3D <1>;
> -		};
> -
> -		aon_syscon: aon_syscon@17010000 {
> -			compatible =3D "starfive,jh7110-aon-syscon","syscon";
> -			reg =3D <0x0 0x17010000 0x0 0x1000>;
> -		};
> -
> -		aongpio: pinctrl@17020000 {
> -			compatible =3D "starfive,jh7110-aon-pinctrl";
> -			reg =3D <0x0 0x17020000 0x0 0x10000>;
> -			resets =3D <&aoncrg JH7110_AONRST_IOMUX>;
> -			interrupts =3D <85>;
> -			interrupt-controller;
> -			#interrupt-cells =3D <2>;
> -			gpio-controller;
> -			#gpio-cells =3D <2>;
> -		};
> -
> -		pcie0: pcie@2b000000 {
> -			compatible =3D "starfive,jh7110-pcie";
> -			reg =3D <0x0 0x2b000000 0x0 0x1000000
> -			       0x9 0x40000000 0x0 0x10000000>;
> -			reg-names =3D "reg", "config";
> -			#address-cells =3D <3>;
> -			#size-cells =3D <2>;
> -			#interrupt-cells =3D <1>;
> -			ranges =3D <0x82000000  0x0 0x30000000  0x0 0x30000000 0x0 0x0800000=
0>,
> -				 <0xc3000000  0x9 0x00000000  0x9 0x00000000 0x0 0x40000000>;
> -			interrupts =3D <56>;
> -			interrupt-parent =3D <&plic>;
> -			interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
> -			interrupt-map =3D <0x0 0x0 0x0 0x1 &plic 0x1>,
> -					<0x0 0x0 0x0 0x2 &plic 0x2>,
> -					<0x0 0x0 0x0 0x3 &plic 0x3>,
> -					<0x0 0x0 0x0 0x4 &plic 0x4>;
> -			msi-parent =3D <&plic>;
> -			device_type =3D "pci";
> -			starfive,stg-syscon =3D <&stg_syscon 0xc0 0xc4 0x130 0x1b8>;
> -			bus-range =3D <0x0 0xff>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
> -				 <&stgcrg JH7110_STGCLK_PCIE0_TL>,
> -				 <&stgcrg JH7110_STGCLK_PCIE0_AXI>,
> -				 <&stgcrg JH7110_STGCLK_PCIE0_APB>;
> -			clock-names =3D "noc", "tl", "axi", "apb";
> -			resets =3D <&stgcrg JH7110_STGRST_PCIE0_MST0>,
> -				 <&stgcrg JH7110_STGRST_PCIE0_SLV0>,
> -				 <&stgcrg JH7110_STGRST_PCIE0_SLV>,
> -				 <&stgcrg JH7110_STGRST_PCIE0_BRG>,
> -				 <&stgcrg JH7110_STGRST_PCIE0_CORE>,
> -				 <&stgcrg JH7110_STGRST_PCIE0_APB>;
> -			reset-names =3D "mst0", "slv0", "slv", "brg",
> -				      "core", "apb";
> -			status =3D "disabled";
> -		};
> -
> -		pcie1: pcie@2c000000 {
> -			compatible =3D "starfive,jh7110-pcie";
> -			reg =3D <0x0 0x2c000000 0x0 0x1000000
> -			       0x9 0xc0000000 0x0 0x10000000>;
> -			reg-names =3D "reg", "config";
> -			#address-cells =3D <3>;
> -			#size-cells =3D <2>;
> -			#interrupt-cells =3D <1>;
> -			ranges =3D <0x82000000  0x0 0x38000000  0x0 0x38000000 0x0 0x0800000=
0>,
> -				 <0xc3000000  0x9 0x80000000  0x9 0x80000000 0x0 0x40000000>;
> -			interrupts =3D <57>;
> -			interrupt-parent =3D <&plic>;
> -			interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
> -			interrupt-map =3D <0x0 0x0 0x0 0x1 &plic 0x1>,
> -					<0x0 0x0 0x0 0x2 &plic 0x2>,
> -					<0x0 0x0 0x0 0x3 &plic 0x3>,
> -					<0x0 0x0 0x0 0x4 &plic 0x4>;
> -			msi-parent =3D <&plic>;
> -			device_type =3D "pci";
> -			starfive,stg-syscon =3D <&stg_syscon 0x270 0x274 0x2e0 0x368>;
> -			bus-range =3D <0x0 0xff>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
> -				 <&stgcrg JH7110_STGCLK_PCIE1_TL>,
> -				 <&stgcrg JH7110_STGCLK_PCIE1_AXI>,
> -				 <&stgcrg JH7110_STGCLK_PCIE1_APB>;
> -			clock-names =3D "noc", "tl", "axi", "apb";
> -			resets =3D <&stgcrg JH7110_STGRST_PCIE1_MST0>,
> -				 <&stgcrg JH7110_STGRST_PCIE1_SLV0>,
> -				 <&stgcrg JH7110_STGRST_PCIE1_SLV>,
> -				 <&stgcrg JH7110_STGRST_PCIE1_BRG>,
> -				 <&stgcrg JH7110_STGRST_PCIE1_CORE>,
> -				 <&stgcrg JH7110_STGRST_PCIE1_APB>;
> -			reset-names =3D "mst0", "slv0", "slv", "brg",
> -				      "core", "apb";
> -			status =3D "disabled";
> -		};
> -	};
> -};

