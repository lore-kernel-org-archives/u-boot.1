Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF5FC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 07:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA4968721D;
	Wed,  1 Nov 2023 08:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ict42.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ict42.de header.i=@ict42.de header.b="e/fQKLP5";
	dkim=permerror (0-bit key) header.d=ict42.de header.i=@ict42.de header.b="6uEeRObD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3BF287499; Wed,  1 Nov 2023 08:04:18 +0100 (CET)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 409328720C
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 08:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ict42.de
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ludwig.kormann@ict42.de
ARC-Seal: i=1; a=rsa-sha256; t=1698822253; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=PVam/2hFv/O1EpBjeL8CxGmVHucnvP94Olu+8jOQSAP7+RJTroo0YzNcpO9+pmFm0G
 AZs13kp/SGwSSQTfO8v8o9OW3QpZDP1vGus8VbqD2l/NP9ctzrcF21vgdfH7QD7bWSoB
 uyYUNlXLGv/TZcresb3OLPO2dB1a2xoUiBvLATeJd3TWT2WJI8dI/gHluJ+zQQb+Sqwt
 5rXrANyhl9be182ODXyQ+GQwKx378tXiSkOQnvHbLZxguBCDWBYB5xqKwm5JEL4AVz1p
 6o6owA65KznLYwUuLXgatkk4YD43vzcfGRWT57amegGsC+YUOzd9XnT5hQfmsIUmav9O
 auNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698822253;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=1E90L37nkBeD7vA5IS6t6bKKn48yaTUgrMIOr5H/6pM=;
 b=AwEaPfEWrjQRz0Na38NzY5KnIkH47rzUjzgyQFv8vdqUNTygtvAppStD1XwdqNTvms
 nopQW9H/ZkFJjNvNnX9yqf376H8S5Cmd1DRm9hcBtOkHgNKSNFo0OdVy0w1nkHP63EjQ
 GSu83Mi0zAkK4CgSHC6ZByaLG0tcgMrFaNIrST/zMRxVSU1TYIlFKqjxVC5EcYOzwP38
 0Lk+qfGPln9nsP6QK7IT0AWymLmUMDZ5IBrz5fu0bjIhGGF6LGWweRnkoP9UixH35ZpY
 ofSnxZzKdEsdcV2+k4heTcMOqqaBhLmZhqX0F9XjEdEbZLczvDOLLbyMUDH0niJpTWbT
 v0zw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698822253;
 s=strato-dkim-0002; d=ict42.de;
 h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=1E90L37nkBeD7vA5IS6t6bKKn48yaTUgrMIOr5H/6pM=;
 b=e/fQKLP5MUNoFO7o8s3tJjW4xSs85MrBUGASBwgUwjm0ikZtjU7yvufgkSLu6osRpI
 V4VNPABTTEmVkuVawCqpZB6g1j4SqONux4uG1RmmttjTasxfF9yD+JmR5i69lk6ZgdMN
 n+scXX5xPRPBuLr8mfB1GL3kZQ/7W/zNnmF+pIS3/zNQJw/XjIRMz+AuBb1r3Ozwb6Uw
 0tP5wXiMKgbrd4LYsYBTz1DBVUPC1T0SMHp9jvmcs5c73S7+NRtLmzi2m7Qs9BN/i7NX
 DBQR0HTYJiM4mHJYIkc4TJwgA5XR9LEKZfmP3QdkU/BjtgmmRMtmDn+KSqO6nWbaONTU
 Zynw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698822253;
 s=strato-dkim-0003; d=ict42.de;
 h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=1E90L37nkBeD7vA5IS6t6bKKn48yaTUgrMIOr5H/6pM=;
 b=6uEeRObDccVOUZvEjGlmM0wo73IJZiLrqO97g+3ScEf0riCSK9rXUBB5Ro7ngk5iqU
 Rh3CRXniMOch2fQO5UAg==
X-RZG-AUTH: ":IHkAYkmvNfSwjg/qSc4u8zZOVaURsoXe3UH2mQA0Kgl2F4tJkg7tCR14B0tQRciSQkqaueMYDMKD"
Received: from [192.168.4.220] by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
 with ESMTPSA id w61ae2zA174DaGs
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 1 Nov 2023 08:04:13 +0100 (CET)
Message-ID: <8f675d53-5f4e-26ba-bf9e-17210ed7b201@ict42.de>
Date: Wed, 1 Nov 2023 08:04:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RESEND v3 1/1] arm: dts: icnova-a20-adb4006: Add board
 support
Content-Language: de-DE
To: Andre Przywara <andre.przywara@arm.com>,
 linux-sunxi <linux-sunxi@lists.linux.dev>
Cc: hdegoede@redhat.com, jagan@amarulasolutions.com, u-boot@lists.denx.de
References: <20231009113916.2668425-1-ludwig.kormann@ict42.de>
 <20231024232608.6e9b2516@slackpad.lan>
From: Ludwig Kormann <ludwig.kormann@ict42.de>
In-Reply-To: <20231024232608.6e9b2516@slackpad.lan>
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

Hello Andre,

thanks for the update! I will send the updated patch today.

kind regards
Ludwig

Am 25.10.23 um 00:26 schrieb Andre Przywara:
> On Mon,  9 Oct 2023 13:39:16 +0200
> Ludwig Kormann <ludwig.kormann@ict42.de> wrote:
>
> Hi Ludwig,
>
>> Add board support for ICnova A20 SomPi compute module on
>> ICnova ADB4006 development board.
>>
>> Specification:
>> SoM
>> - Processor: Allwinner A20 Cortex-A7 Dual Core at 1GHz
>> - 512MB DDR3 RAM
>> - Fast Ethernet (Phy: Realtek RTL8201CP)
>> ADB4006
>> - I2C
>> - 2x USB 2.0
>> - 1x Fast Ethernet port
>> - 1x SATA
>> - 2x buttons (PWRON, Boot)
>> - 2x LEDS
>> - serial console
>> - HDMI
>> - µSD-Card slot
>> - Audio Line-In / Line-Out
>> - GPIO pinheaders
>>
>> https://wiki.in-circuit.de/index.php5?title=ICnova_ADB4006
>> https://wiki.in-circuit.de/index.php5?title=ICnova_A20_SODIMM
>>
>> devicetree upstreamed with linux 6.5
> As you have probably seen, the DT files have been synced into U-Boot's
> master branch yesterday.
> So if you rebase this on top of master, so just send the defconfig
> (with CONFIG_SYS_64BIT_LBA added) and the Makefile change in a new
> patch, I am happy to take it still this cycle.
>
> Cheers,
> Andre

thanks for the update! I will send the updated patch today.

kind regards
Ludwig


>> Signed-off-by: Ludwig Kormann <ludwig.kormann@ict42.de>
>> ---
>> changes in v3:
>> - rebase on v2023.10
>>
>> changes in v2:
>> - rebase on v2023.07-rc2
>> - remove pin defines from defconfig
>> - get dts reviewed on the linux mailing list and
>>    scheduled for kernel 6.5 [1]
>>
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
>> commit de2bdfb7f79d5c655eb056d459e02be2c7f13c8b
>>
>> ---
>>   arch/arm/dts/Makefile                         |   1 +
>>   arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts | 137 ++++++++++++++++++
>>   arch/arm/dts/sun7i-a20-icnova-a20.dtsi        |  62 ++++++++
>>   board/sunxi/MAINTAINERS                       |   5 +
>>   configs/icnova-a20-adb4006_defconfig          |  20 +++
>>   5 files changed, 225 insertions(+)
>>   create mode 100644 arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts
>>   create mode 100644 arch/arm/dts/sun7i-a20-icnova-a20.dtsi
>>   create mode 100644 configs/icnova-a20-adb4006_defconfig
>>
>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>> index 85fd5b1157..16d5930b78 100644
>> --- a/arch/arm/dts/Makefile
>> +++ b/arch/arm/dts/Makefile
>> @@ -667,6 +667,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>>   	sun7i-a20-haoyu-marsboard.dtb \
>>   	sun7i-a20-hummingbird.dtb \
>>   	sun7i-a20-i12-tvbox.dtb \
>> +	sun7i-a20-icnova-a20-adb4006.dtb \
>>   	sun7i-a20-icnova-swac.dtb \
>>   	sun7i-a20-itead-ibox.dtb \
>>   	sun7i-a20-lamobo-r1.dtb \
>> diff --git a/arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts b/arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts
>> new file mode 100644
>> index 0000000000..577ead1d02
>> --- /dev/null
>> +++ b/arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts
>> @@ -0,0 +1,137 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +// Copyright (C) 2023 In-Circuit GmbH
>> +
>> +/dts-v1/;
>> +
>> +#include "sun7i-a20-icnova-a20.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/leds/common.h>
>> +
>> +/ {
>> +	model = "In-Circuit ICnova A20 ADB4006";
>> +	compatible = "incircuit,icnova-a20-adb4006", "incircuit,icnova-a20",
>> +		     "allwinner,sun7i-a20";
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	hdmi-connector {
>> +		compatible = "hdmi-connector";
>> +		type = "a";
>> +
>> +		port {
>> +			hdmi_con_in: endpoint {
>> +				remote-endpoint = <&hdmi_out_con>;
>> +			};
>> +		};
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		led-0 {
>> +			function = LED_FUNCTION_POWER;
>> +			color = <LED_COLOR_ID_YELLOW>;
>> +			gpios = <&pio 7 21 GPIO_ACTIVE_HIGH>; /* PH21 */
>> +			default-state = "on";
>> +		};
>> +
>> +		led-1 {
>> +			function = LED_FUNCTION_HEARTBEAT;
>> +			color = <LED_COLOR_ID_RED>;
>> +			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>; /* PH20 */
>> +			linux,default-trigger = "heartbeat";
>> +		};
>> +	};
>> +};
>> +
>> +&ahci {
>> +	target-supply = <&reg_ahci_5v>;
>> +	status = "okay";
>> +};
>> +
>> +&codec {
>> +	status = "okay";
>> +};
>> +
>> +&de {
>> +	status = "okay";
>> +};
>> +
>> +&ehci0 {
>> +	status = "okay";
>> +};
>> +
>> +&ehci1 {
>> +	status = "okay";
>> +};
>> +
>> +&hdmi {
>> +	status = "okay";
>> +};
>> +
>> +&hdmi_out {
>> +	hdmi_out_con: endpoint {
>> +		remote-endpoint = <&hdmi_con_in>;
>> +	};
>> +};
>> +
>> +&mmc0 {
>> +	vmmc-supply = <&reg_vcc3v3>;
>> +	bus-width = <4>;
>> +	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
>> +	status = "okay";
>> +};
>> +
>> +&ohci0 {
>> +	status = "okay";
>> +};
>> +
>> +&ohci1 {
>> +	status = "okay";
>> +};
>> +
>> +&otg_sram {
>> +	status = "okay";
>> +};
>> +
>> +&reg_ahci_5v {
>> +	status = "okay";
>> +};
>> +
>> +&ac_power_supply {
>> +	status = "okay";
>> +};
>> +
>> +&reg_usb1_vbus {
>> +	status = "okay";
>> +};
>> +
>> +&reg_usb2_vbus {
>> +	status = "okay";
>> +};
>> +
>> +&uart0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart0_pb_pins>;
>> +	status = "okay";
>> +};
>> +
>> +&usb_otg {
>> +	dr_mode = "otg";
>> +	status = "okay";
>> +};
>> +
>> +&usbphy {
>> +	usb0_id_det-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
>> +	usb0_vbus_det-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
>> +	usb1_vbus-supply = <&reg_usb1_vbus>;
>> +	usb2_vbus-supply = <&reg_usb2_vbus>;
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm/dts/sun7i-a20-icnova-a20.dtsi b/arch/arm/dts/sun7i-a20-icnova-a20.dtsi
>> new file mode 100644
>> index 0000000000..46616c6bc8
>> --- /dev/null
>> +++ b/arch/arm/dts/sun7i-a20-icnova-a20.dtsi
>> @@ -0,0 +1,62 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +// Copyright (C) 2023 In-Circuit GmbH
>> +
>> +#include "sun7i-a20.dtsi"
>> +#include "sunxi-common-regulators.dtsi"
>> +
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +&cpu0 {
>> +	cpu-supply = <&reg_dcdc2>;
>> +};
>> +
>> +&gmac {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&gmac_mii_pins>;
>> +	phy-handle = <&phy1>;
>> +	phy-mode = "mii";
>> +	status = "okay";
>> +};
>> +
>> +&i2c0 {
>> +	status = "okay";
>> +
>> +	axp209: pmic@34 {
>> +		reg = <0x34>;
>> +		interrupt-parent = <&nmi_intc>;
>> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +	};
>> +};
>> +
>> +&gmac_mdio {
>> +	phy1: ethernet-phy@1 {
>> +		reg = <1>;
>> +	};
>> +};
>> +
>> +#include "axp209.dtsi"
>> +
>> +&reg_dcdc2 {
>> +	regulator-always-on;
>> +	regulator-min-microvolt = <1000000>;
>> +	regulator-max-microvolt = <1400000>;
>> +	regulator-name = "vdd-cpu";
>> +};
>> +
>> +&reg_dcdc3 {
>> +	regulator-always-on;
>> +	regulator-min-microvolt = <1000000>;
>> +	regulator-max-microvolt = <1400000>;
>> +	regulator-name = "vdd-int-dll";
>> +};
>> +
>> +&reg_ldo1 {
>> +	regulator-name = "vdd-rtc";
>> +};
>> +
>> +&reg_ldo2 {
>> +	regulator-always-on;
>> +	regulator-min-microvolt = <3000000>;
>> +	regulator-max-microvolt = <3000000>;
>> +	regulator-name = "avcc";
>> +};
>> diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
>> index 98bbd2dd25..67cdd01371 100644
>> --- a/board/sunxi/MAINTAINERS
>> +++ b/board/sunxi/MAINTAINERS
>> @@ -236,6 +236,11 @@ M:	Stefan Roese <sr@denx.de>
>>   S:	Maintained
>>   F:	configs/icnova-a20-swac_defconfig
>>   
>> +ICnova-A20-ADB4006 BOARD
>> +M:	Ludwig Kormann <ludwig.kormann@ict42.de>
>> +S:	Maintained
>> +F:	configs/icnova-a20-adb4006_defconfig
>> +
>>   ITEAD IBOX BOARD
>>   M:	Marcus Cooper <codekipper@gmail.com>
>>   S:	Maintained
>> diff --git a/configs/icnova-a20-adb4006_defconfig b/configs/icnova-a20-adb4006_defconfig
>> new file mode 100644
>> index 0000000000..f70ffe45ab
>> --- /dev/null
>> +++ b/configs/icnova-a20-adb4006_defconfig
>> @@ -0,0 +1,20 @@
>> +CONFIG_ARM=y
>> +CONFIG_ARCH_SUNXI=y
>> +CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-icnova-a20-adb4006"
>> +CONFIG_SPL=y
>> +CONFIG_MACH_SUN7I=y
>> +CONFIG_DRAM_CLK=384
>> +CONFIG_AHCI=y
>> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>> +CONFIG_SPL_I2C=y
>> +CONFIG_SCSI_AHCI=y
>> +CONFIG_SYS_I2C_MVTWSI=y
>> +CONFIG_SYS_I2C_SLAVE=0x7f
>> +CONFIG_SYS_I2C_SPEED=400000
>> +CONFIG_ETH_DESIGNWARE=y
>> +CONFIG_MII=y
>> +CONFIG_SUN7I_GMAC=y
>> +CONFIG_AXP_ALDO4_VOLT=2800
>> +CONFIG_SCSI=y
>> +CONFIG_USB_EHCI_HCD=y
>> +CONFIG_USB_OHCI_HCD=y
>

