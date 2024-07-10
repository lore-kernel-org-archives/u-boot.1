Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4339C3DA49
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 06:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 284E9886EB;
	Wed, 10 Jul 2024 08:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720592650;
	bh=uUUSakAqzE6MyjJ1XpjbUFK7krEuTF2okI7j4wXUrhs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lhFAhQzdqAA8SK/Ep5IMxZ3abw55kKnE2BzGKMNkK3PQlm+txQx6eRvkrC3tdIqpE
	 /ITX9KJFTEzY11l1vjG81/R/QIseGqzeFN/phsu0ZlZZMefw9mf32ahL7Wb9T1JiuX
	 p5d1FEdWszwXXEToZ2UtmWssuB5groHghCWB/reF8iqwdYVIwMk5i197O1MvkKw7Qs
	 29Z6rceaaXEXbp2Vv71+725/x58t4obO1/032J3Zuqaj9V69++AxQ+ydPOErinn6ln
	 cXUsi7d1WtNhAjpX2lb2CBQW8ba3Joi8pJDAkTUkHxTFGs3LFJehm0oTnMKdqbw1FM
	 KTf/hqdNzFsQg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFA5C886F5; Wed, 10 Jul 2024 08:24:09 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 763F38860C
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 08:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4WJnr6707jz9sWN;
 Wed, 10 Jul 2024 08:24:06 +0200 (CEST)
Message-ID: <b02e9a8c-445b-4f51-9178-3b5582ad0373@denx.de>
Date: Wed, 10 Jul 2024 08:24:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: dts: mvebu: Migrate to upstream DT for Synology
 DS116 (Armada 385) board
To: Tony Dinh <mibodhi@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>
References: <20240522215200.16199-1-mibodhi@gmail.com>
 <CAFA6WYMb1vK_ZtECYmWesVBrd8ssOs123owarF1pEcqNE2R9vA@mail.gmail.com>
 <CAJaLiFx5VdVYy2yquOAdD1mvuyGnR83schmPWZBSBYdUpxc81g@mail.gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <CAJaLiFx5VdVYy2yquOAdD1mvuyGnR83schmPWZBSBYdUpxc81g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Tony,

On 7/9/24 22:27, Tony Dinh wrote:
> Hi Stefan,
> 
> On Thu, May 23, 2024 at 12:27 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> On Thu, 23 May 2024 at 03:22, Tony Dinh <mibodhi@gmail.com> wrote:
>>>
>>> Enable OF_UPSTREAM to use upstream DT and add marvell/ prefix to the
>>> DEFAULT_DEVICE_TREE in DS116 defconfig. Remove current DTS in
>>> arch/arm/dts/ directory.
>>>
>>> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
>>> ---
>>>
>>>   arch/arm/dts/Makefile                      |   1 -
>>>   arch/arm/dts/armada-385-synology-ds116.dts | 291 ---------------------
>>>   configs/ds116_defconfig                    |   3 +-
>>>   3 files changed, 2 insertions(+), 293 deletions(-)
>>>   delete mode 100644 arch/arm/dts/armada-385-synology-ds116.dts
>>>
>>
>> Acked-by: Sumit Garg <sumit.garg@linaro.org>
>>
>> -Sumit
> 
> Is this OK to be merged to next?

I think so:

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> All the best,
> Tony
> 
>>
>>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>>> index a5c82ebf7a..75f7e616b4 100644
>>> --- a/arch/arm/dts/Makefile
>>> +++ b/arch/arm/dts/Makefile
>>> @@ -155,7 +155,6 @@ dtb-$(CONFIG_ARCH_MVEBU) +=                 \
>>>          armada-385-atl-x530.dtb                 \
>>>          armada-385-atl-x530DP.dtb               \
>>>          armada-385-db-88f6820-amc.dtb           \
>>> -       armada-385-synology-ds116.dtb           \
>>>          armada-385-thecus-n2350.dtb             \
>>>          armada-385-turris-omnia.dtb             \
>>>          armada-388-clearfog.dtb                 \
>>> diff --git a/arch/arm/dts/armada-385-synology-ds116.dts b/arch/arm/dts/armada-385-synology-ds116.dts
>>> deleted file mode 100644
>>> index 82a0373f7f..0000000000
>>> --- a/arch/arm/dts/armada-385-synology-ds116.dts
>>> +++ /dev/null
>>> @@ -1,291 +0,0 @@
>>> -// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> -/*
>>> - * Device Tree file for Synology DS116 NAS
>>> - *
>>> - * Copyright (C) 2017 Willy Tarreau <w@1wt.eu>
>>> - */
>>> -
>>> -/dts-v1/;
>>> -#include "armada-385.dtsi"
>>> -#include <dt-bindings/gpio/gpio.h>
>>> -
>>> -/ {
>>> -       model = "Synology DS116";
>>> -       compatible = "marvell,a385-gp", "marvell,armada385", "marvell,armada380";
>>> -
>>> -       chosen {
>>> -               stdout-path = "serial0:115200n8";
>>> -       };
>>> -
>>> -       memory {
>>> -               device_type = "memory";
>>> -               reg = <0x00000000 0x40000000>; /* 1 GB */
>>> -       };
>>> -
>>> -       soc {
>>> -               ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
>>> -                         MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
>>> -                         MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
>>> -                         MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000
>>> -                         MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
>>> -
>>> -               internal-regs {
>>> -                       i2c@11000 {
>>> -                               pinctrl-names = "default";
>>> -                               pinctrl-0 = <&i2c0_pins>;
>>> -                               status = "okay";
>>> -                               clock-frequency = <100000>;
>>> -
>>> -                               eeprom@57 {
>>> -                                       compatible = "atmel,24c64";
>>> -                                       reg = <0x57>;
>>> -                               };
>>> -                       };
>>> -
>>> -                       serial@12000 {
>>> -                               pinctrl-names = "default";
>>> -                               pinctrl-0 = <&uart0_pins>;
>>> -                               status = "okay";
>>> -                       };
>>> -
>>> -                       serial@12100 {
>>> -                               /* A PIC16F1829 is connected to uart1 at 9600 bps,
>>> -                                * and takes single-character orders :
>>> -                                *   "1" : power off // already handled by the poweroff node
>>> -                                *   "2" : short beep
>>> -                                *   "3" : long beep
>>> -                                *   "4" : turn the power LED ON
>>> -                                *   "5" : flash the power LED
>>> -                                *   "6" : turn the power LED OFF
>>> -                                *   "7" : turn the status LED OFF
>>> -                                *   "8" : turn the status LED ON
>>> -                                *   "9" : flash the status LED
>>> -                                *   "A" : flash the motherboard LED (D8)
>>> -                                *   "B" : turn the motherboard LED OFF
>>> -                                *   "C" : hard reset
>>> -                                */
>>> -                               pinctrl-names = "default";
>>> -                               pinctrl-0 = <&uart1_pins>;
>>> -                               status = "okay";
>>> -                       };
>>> -
>>> -                       poweroff@12100 {
>>> -                               compatible = "synology,power-off";
>>> -                               reg = <0x12100 0x100>;
>>> -                               clocks = <&coreclk 0>;
>>> -                       };
>>> -
>>> -                       ethernet@70000 {
>>> -                               pinctrl-names = "default";
>>> -                               phy = <&phy0>;
>>> -                               phy-mode = "sgmii";
>>> -                               buffer-manager = <&bm>;
>>> -                               bm,pool-long = <0>;
>>> -                               status = "okay";
>>> -                       };
>>> -
>>> -                       mdio@72004 {
>>> -                               pinctrl-names = "default";
>>> -                               pinctrl-0 = <&mdio_pins>;
>>> -
>>> -                               phy0: ethernet-phy@1 {
>>> -                                       reg = <1>;
>>> -                               };
>>> -                       };
>>> -
>>> -                       sata@a8000 {
>>> -                               pinctrl-names = "default";
>>> -                               pinctrl-0 = <&sata0_pins>;
>>> -                               status = "okay";
>>> -                               #address-cells = <1>;
>>> -                               #size-cells = <0>;
>>> -
>>> -                               sata0: sata-port@0 {
>>> -                                       reg = <0>;
>>> -                                       target-supply = <&reg_5v_sata0>;
>>> -                               };
>>> -                       };
>>> -
>>> -                       bm@c8000 {
>>> -                               status = "okay";
>>> -                       };
>>> -
>>> -                       usb3@f0000 {
>>> -                               usb-phy = <&usb3_0_phy>;
>>> -                               status = "okay";
>>> -                       };
>>> -
>>> -                       usb3@f8000 {
>>> -                               usb-phy = <&usb3_1_phy>;
>>> -                               status = "okay";
>>> -                       };
>>> -               };
>>> -
>>> -               bm-bppi {
>>> -                       status = "okay";
>>> -               };
>>> -
>>> -               gpio-fan {
>>> -                       compatible = "gpio-fan";
>>> -                       gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>,
>>> -                               <&gpio1 17 GPIO_ACTIVE_HIGH>,
>>> -                               <&gpio1 16 GPIO_ACTIVE_HIGH>;
>>> -                       gpio-fan,speed-map = <   0 0
>>> -                                             1500 1
>>> -                                             2500 2
>>> -                                             3000 3
>>> -                                             3400 4
>>> -                                             3700 5
>>> -                                             3900 6
>>> -                                             4000 7>;
>>> -                       #cooling-cells = <2>;
>>> -               };
>>> -
>>> -               gpio-leds {
>>> -                       compatible = "gpio-leds";
>>> -
>>> -                       /* The green part is on gpio0.20 which is also used by
>>> -                        * sata0, and accesses to SATA disk 0 make it blink so it
>>> -                        * doesn't need to be declared here.
>>> -                        */
>>> -                       orange {
>>> -                               gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
>>> -                               label = "ds116:orange:disk";
>>> -                               default-state = "off";
>>> -                       };
>>> -               };
>>> -       };
>>> -
>>> -       usb3_0_phy: usb3_0_phy {
>>> -               compatible = "usb-nop-xceiv";
>>> -               vcc-supply = <&reg_usb3_0_vbus>;
>>> -               #phy-cells = <0>;
>>> -       };
>>> -
>>> -       usb3_1_phy: usb3_1_phy {
>>> -               compatible = "usb-nop-xceiv";
>>> -               vcc-supply = <&reg_usb3_1_vbus>;
>>> -               #phy-cells = <0>;
>>> -       };
>>> -
>>> -       reg_usb3_0_vbus: usb3-vbus0 {
>>> -               compatible = "regulator-fixed";
>>> -               regulator-name = "usb3-vbus0";
>>> -               pinctrl-names = "default";
>>> -               pinctrl-0 = <&xhci0_vbus_pins>;
>>> -               regulator-min-microvolt = <5000000>;
>>> -               regulator-max-microvolt = <5000000>;
>>> -               enable-active-high;
>>> -               gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;
>>> -       };
>>> -
>>> -       reg_usb3_1_vbus: usb3-vbus1 {
>>> -               compatible = "regulator-fixed";
>>> -               regulator-name = "usb3-vbus1";
>>> -               pinctrl-names = "default";
>>> -               pinctrl-0 = <&xhci1_vbus_pins>;
>>> -               regulator-min-microvolt = <5000000>;
>>> -               regulator-max-microvolt = <5000000>;
>>> -               enable-active-high;
>>> -               gpio = <&gpio1 27 GPIO_ACTIVE_HIGH>;
>>> -       };
>>> -
>>> -       reg_sata0: pwr-sata0 {
>>> -               compatible = "regulator-fixed";
>>> -               regulator-name = "pwr_en_sata0";
>>> -               regulator-min-microvolt = <12000000>;
>>> -               regulator-max-microvolt = <12000000>;
>>> -               enable-active-high;
>>> -               regulator-boot-on;
>>> -               gpio = <&gpio0 15 GPIO_ACTIVE_HIGH>;
>>> -       };
>>> -
>>> -       reg_5v_sata0: v5-sata0 {
>>> -               compatible = "regulator-fixed";
>>> -               regulator-name = "v5.0-sata0";
>>> -               regulator-min-microvolt = <5000000>;
>>> -               regulator-max-microvolt = <5000000>;
>>> -               vin-supply = <&reg_sata0>;
>>> -       };
>>> -
>>> -       reg_12v_sata0: v12-sata0 {
>>> -               compatible = "regulator-fixed";
>>> -               regulator-name = "v12.0-sata0";
>>> -               regulator-min-microvolt = <12000000>;
>>> -               regulator-max-microvolt = <12000000>;
>>> -               vin-supply = <&reg_sata0>;
>>> -       };
>>> -};
>>> -
>>> -&spi0 {
>>> -       pinctrl-names = "default";
>>> -       pinctrl-0 = <&spi0_pins>;
>>> -       status = "okay";
>>> -
>>> -       spi-flash@0 {
>>> -               #address-cells = <1>;
>>> -               #size-cells = <1>;
>>> -               compatible = "macronix,mx25l6405d", "jedec,spi-nor";
>>> -               reg = <0>; /* Chip select 0 */
>>> -               spi-max-frequency = <50000000>;
>>> -               m25p,fast-read;
>>> -
>>> -               /* Note: there is a redboot partition table despite u-boot
>>> -                * being used. The names presented here are the same as those
>>> -                * found in the FIS directory. There is also a small device
>>> -                * tree in the last 64kB of the RedBoot partition which is not
>>> -                * enumerated. The MAC address and the serial number are listed
>>> -                * in the "vendor" partition.
>>> -                */
>>> -               partition@0 {
>>> -                       label = "RedBoot";
>>> -                       reg = <0x00000000 0x000f0000>;
>>> -                       read-only;
>>> -               };
>>> -
>>> -               partition@c0000 {
>>> -                       label = "zImage";
>>> -                       reg = <0x000f0000 0x002d0000>;
>>> -               };
>>> -
>>> -               partition@390000 {
>>> -                       label = "rd.gz";
>>> -                       reg = <0x003c0000 0x00410000>;
>>> -               };
>>> -
>>> -               partition@7d0000 {
>>> -                       label = "vendor";
>>> -                       reg = <0x007d0000 0x00010000>;
>>> -                       read-only;
>>> -               };
>>> -
>>> -               partition@7e0000 {
>>> -                       label = "RedBoot config";
>>> -                       reg = <0x007e0000 0x00010000>;
>>> -                       read-only;
>>> -               };
>>> -
>>> -               partition@7f0000 {
>>> -                       label = "FIS directory";
>>> -                       reg = <0x007f0000 0x00010000>;
>>> -                       read-only;
>>> -               };
>>> -       };
>>> -};
>>> -
>>> -&pinctrl {
>>> -       /* use only one pin for UART1, as mpp20 is used by sata0 */
>>> -       uart1_pins: uart-pins-1 {
>>> -               marvell,pins = "mpp19";
>>> -               marvell,function = "ua1";
>>> -       };
>>> -
>>> -       xhci0_vbus_pins: xhci0_vbus_pins {
>>> -               marvell,pins = "mpp58";
>>> -               marvell,function = "gpio";
>>> -       };
>>> -       xhci1_vbus_pins: xhci1_vbus_pins {
>>> -               marvell,pins = "mpp59";
>>> -               marvell,function = "gpio";
>>> -       };
>>> -};
>>> diff --git a/configs/ds116_defconfig b/configs/ds116_defconfig
>>> index 1fc7380216..bcc5f00fe5 100644
>>> --- a/configs/ds116_defconfig
>>> +++ b/configs/ds116_defconfig
>>> @@ -16,7 +16,7 @@ CONFIG_SF_DEFAULT_SPEED=50000000
>>>   CONFIG_ENV_SIZE=0x10000
>>>   CONFIG_ENV_OFFSET=0x7E0000
>>>   CONFIG_ENV_SECT_SIZE=0x10000
>>> -CONFIG_DEFAULT_DEVICE_TREE="armada-385-synology-ds116"
>>> +CONFIG_DEFAULT_DEVICE_TREE="marvell/armada-385-synology-ds116"
>>>   CONFIG_SPL_TEXT_BASE=0x40000030
>>>   CONFIG_SPL_SERIAL=y
>>>   CONFIG_SPL_STACK=0x4002c000
>>> @@ -56,6 +56,7 @@ CONFIG_CMD_CACHE=y
>>>   CONFIG_CMD_TIME=y
>>>   CONFIG_CMD_MTDPARTS=y
>>>   CONFIG_MTDPARTS_DEFAULT="mtdparts=spi0.0:1m(u-boot),7040k(kernel),64k(u-boot-env),-(data)"
>>> +CONFIG_OF_UPSTREAM=y
>>>   CONFIG_ENV_OVERWRITE=y
>>>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>>   CONFIG_VERSION_VARIABLE=y
>>> --
>>> 2.39.2
>>>

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
