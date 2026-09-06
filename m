Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63393C79F85
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 13:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 125A96061C;
	Sun,  6 Sep 2026 13:00:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 21w8CIYBU83t; Sun,  6 Sep 2026 13:00:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0BCA760623
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788699603;
	b=grdxd3Y7iz+dFexPJaxscPC7QAU7/4+H0EtAvmBDOswJVmkJPbPL0GCyq7UzNkZFO1ii
	 U3MEd9Slr5K3xiMJxqB4eRsfGBxGBiCb8EOPibGQ0Y+C8mEUWl66h0QTywLnOB0/okxUk
	 jNISiE08O8V/ZHSSY7EtrLQN+fttntMMVvA6GEj/hcTE5gwaAVXVywm9ZvXnNuL0NDDFC
	 jh0OyD+wUZc/3C4bPu1Fg37F1jHhC8NUCsYKokUKztW/O4dmGXqJCYZz/JMdZSNNxEfUE
	 yv+Br02Ry8nd8MvJS7I8MfpyvDG+2A1GatOuWvPDUYz5xLW6gbL0SFvEWeq7rr6kwyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788699603;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3eGmIVunA2R8WRYQlKLXiQFooKnUv7p8viPHvEXFC8Q=;
	b=EClJxZkVM8YFTkvBdistdty47cdsfylDDAUEtLd5Bg3IjbGiHm5Mz9aU7xkmCjTeNORi
	 kWRoH7EbvJ+jFjQFcjSawsPpNUM/k5pEjzyAeYSOiVkGzFFCRVuh9vfUuAMMq5mqQ9JJ9
	 vfc4GaLcvP/Y+Vmnuqkz04ur+LTSjA6bfjscHYkHegPx8DlBHPqyqycPdOft4eGQLAyjj
	 s4EC6LPVfHxL3Yk0Pk5XmBi823XxeNqj1tqAFtY4eQP2O3yY8kz5qqV3t/mnuCv9+FOzp
	 fQDZiR88hUYd52+QoFrVoU9L/kEgeyMT3yn6CCv0EjUO3iWVqehojsq/ofnufd99PrA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788699603;
	bh=3eGmIVunA2R8WRYQlKLXiQFooKnUv7p8viPHvEXFC8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m++/KNs9nV9sRIr2W5gTY22IR59t58RKM9Mz/Do/1Zp+lKk5ewLH2nv7LObt7HGfl
	 zdyWWC8yQvGBoWgYIqxWiI/4fbXRrl/MxDbodiaMTuOK1GiMKxyhszdbFfJ4ys+p4X
	 MgmJJi1h9ztLSbdjnjpMtuPpZ3K5ohFZ9HJezgvda0827P1uZ85a4+6anTtxvitfJr
	 dhk5Mulii2WEqXZgkGfUXSkld6HgwuixuLXa6jfdfml6k3nUAHoSj8fbRsNqe+1b4I
	 I86x4DIHdG5SOXJ9SnAhUE7b50QyriHx85X03M5mEoCdY/FtTDuX1DjAspZz2DlRYm
	 y0Qgmp6LarfpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BCA760623;
	Sun,  6 Sep 2026 13:00:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 537F42C7
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 13:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36A1140068
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 13:00:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b_uaoLZCa4Si for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 12:59:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DFB614000B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788699598;
 b=OojOQwzTaBW5dlxUg1zty1hmQpI36WCeRRG6CrspdCmdm4y2OX79bHK1b+pKHYevv7rh
 iS4rMrLfeyDzbWZ0xeOiJPGG4GlNUQaCOPTuScDNFUyU9yiRWvSspiNoA0uQibPab6uR0
 B/xR/9A/yawMuN4TZDJQQJ6gGmxAV19f80eoOzlFhwsY7P7gBjCC8PuHpdGsjJAbNKXkz
 RF/rwHqtuImwtoYXJx2tvA2iXF5GdveoIQQd7ld5vN4GST8TNKNFonzSYMtTZeYazOfao
 dKDQwC6CFvcSnoDElAKfQ8DBXyEC346intoG8DY5RXs2i1a3WUzfvCTRMzER+67QaZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788699598;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=3eGmIVunA2R8WRYQlKLXiQFooKnUv7p8viPHvEXFC8Q=;
 b=TTTeJnB+wBoKssdvlCzkq5VvawmPR7WgzDLdyTJ3aiL6ToiUKNf5lYYLrmmU4erbxliJ
 vSY3b7qTwdvCniOnV2u0IcDrAuQJWla6KwkMYFKMgq+Xzdsal8Zp+mUKe5b3r0K1H2CD4
 7ddIkolakkI7Rb1pHB7cMl3/DHA/39X8/1BBCli61UR4mOS6tX83FiUSJVSdtSn+rF7hO
 FYGF6SeKx4A831y9SkS+E8a0AttgMEo80tYKPbZpIBNZAcPgSOBde7e/6Y8N+9S4mWw2G
 nUMGQCGSDzPKK/D4QMcc8ibCOPxD+jOipwiN118Uzs77gkHF1MtWwBqqbjz+Y+JyDSA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=public-files.de; 
 dkim=pass header.d=public-files.de header.i=frank-w@public-files.de
 header.a=rsa-sha256 header.s=s31663417 header.b=Th4ilHQh; 
 arc=none smtp.remote-ip=212.227.15.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=frank-w@public-files.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=public-files.de header.i=frank-w@public-files.de
 header.a=rsa-sha256 header.s=s31663417 header.b=Th4ilHQh
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFB614000B
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1788699572; x=1789304372; i=frank-w@public-files.de;
 bh=3eGmIVunA2R8WRYQlKLXiQFooKnUv7p8viPHvEXFC8Q=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Th4ilHQhRaFkbKy4cg1CW08GPcFWtmG8Jf7JVt2ZVSpakDryXAIuOe5q8db8v1LJ
 vKQyyT+kJ1kapxvGLFToaNhDY0gMZUCDVYHsriCVsnisErc6G6xmTCyyEF1caQc4F
 5FZ3Dh0k20ZSOKw7eM2DRa7EiFxhgUHI+1rnrHAAgkCsvdOJnH6M+Xi/sMvsu+QLB
 qkAW0W+zJY5NSPqn3h5zZDxcUtSE6kCJ85u/thfiT9koFUyWzDeWz5b1pxpOYroG1
 ToxVirPr/PEIOJRgX03A1+WUcAX3eqkf2R5KZjyuZ0vk8az6KkW8acDpyzk8znJid
 t5vLYTw2f0PvIH169w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbp3-1xEQcp0I8Z-00PvZ9; Sun, 06
 Sep 2026 14:59:32 +0200
Message-ID: <4c03ad9a-1314-4cae-b2ff-bbf84a6f4b4e@public-files.de>
Date: Sun, 6 Sep 2026 14:59:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: mediatek: add BPi-R3 Mini eMMC board support
To: "Lucien.Jheng" <lucienzx159@gmail.com>, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, igor.belwon@mentallysanemainliners.org,
 dlechner@baylibre.com, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, jbx6244@gmail.com, msp@baylibre.com,
 u-boot@lists.u-boot-project.org
Cc: daniel@makrotopia.org, skylake.huang@mediatek.com
References: <20260906120756.8290-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Frank Wunderlich <frank-w@public-files.de>
In-Reply-To: <20260906120756.8290-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LCn6I9liBD/fIoc8+AESXzahhH/W47G2jHl7Gvo+8aJMuzyPm99
 dhMGVyDLX3kJ0uHKQFSjjz7n0RSuzFGkOJYpUmUNDi6rWLQnrWhrVRhRuXul504RBWzzMzW
 hNSoVM1sQBQJfBTCasqmIiBGqSEpk/UYe4XitEgckuBtFQCGN3I8e4l55SokHAzAphEIzcr
 QXlnSXijAcPx1VioOwh/w==
UI-OutboundReport: notjunk:1;M01:P0:xDBtncj4ZDA=;taqGbqo5dbmezUs03sjr1IWJiHk
 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
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Lucien,

it seems you try to upstream the DTS from my repo [1] (i did not do it=20
because of OF_UPSTREAM discussion/requirement) only with minor cleanup=20
(e.g. dropped my attempt to define regulators as such - was not working=20
in my tests but imho more logical).

But it would be great if you mention me as Co-developed-By or similar.

Not sure if upstream-discussion is still valid (new downstream DTS were=20
rejected there), it needed many other driver patches and some hacks at=20
DT level (my last state [2]).

btw. compatible should be changed to upstream one [3]

regards Frank

[1]=20
https://github.com/frank-w/u-boot/blob/2024-04-bpi-r3mini/arch/arm/dts/mt7=
986a-bpi-r3-mini.dts

latest version:=20
https://github.com/frank-w/u-boot/blob/2026-07-bpi/arch/arm/dts/mt7986a-bp=
i-r3-mini.dts

[2] https://github.com/frank-w/u-boot/commits/2026-01-bpi-ofupstream/

[3]=20
https://github.com/frank-w/BPI-Router-Linux/blob/7.3-rc/arch/arm64/boot/dt=
s/mediatek/mt7986a-bananapi-bpi-r3-mini.dts#L21

Am 06.09.26 um 14:07 schrieb Lucien.Jheng:
> Add device tree and defconfig for the Bananapi BPi-R3 Mini, an
> eMMC-only variant of the BPi-R3 board built around the MT7986A SoC.
>
> The board dtsi enables the MT7986 eMMC controller, SPI-NAND flash,
> PWM, and the on-board Airoha EN8811H 2.5G PHY via mdio.
>
> The mt7986a_bpir3_mini_emmc_defconfig enables the drivers needed for
> this variant: SPI-NAND (MTD/UBI), USB xHCI, PCIe Gen3 with NVMe, the
> Airoha EN8811H PHY driver, and RNG/pstore support.
>
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
> ---
>   arch/arm/dts/Makefile                     |   1 +
>   arch/arm/dts/mt7986a-bpi-r3-mini-emmc.dts | 236 ++++++++++++++++++++++
>   configs/mt7986a_bpir3_mini_emmc_defconfig | 139 +++++++++++++
>   3 files changed, 376 insertions(+)
>   create mode 100644 arch/arm/dts/mt7986a-bpi-r3-mini-emmc.dts
>   create mode 100644 configs/mt7986a_bpir3_mini_emmc_defconfig
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 1b533721bb4..b62a4334750 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1080,6 +1080,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D \
>   	mt7981-sd-rfb.dtb \
>   	mt7986a-bpi-r3-sd.dtb \
>   	mt7986a-bpi-r3-emmc.dtb \
> +	mt7986a-bpi-r3-mini-emmc.dtb \
>   	mt7986a-rfb.dtb \
>   	mt7986b-rfb.dtb \
>   	mt7986a-sd-rfb.dtb \
> diff --git a/arch/arm/dts/mt7986a-bpi-r3-mini-emmc.dts b/arch/arm/dts/mt=
7986a-bpi-r3-mini-emmc.dts
> new file mode 100644
> index 00000000000..18320b20be8
> --- /dev/null
> +++ b/arch/arm/dts/mt7986a-bpi-r3-mini-emmc.dts
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/dts-v1/;
> +#include "mt7986.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +
> +/ {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	model =3D "Bananapi BPi-R3 Mini";
> +	compatible =3D "mediatek,mt7986", "mediatek,mt7986-rfb";
> +
> +	chosen {
> +		stdout-path =3D &uart0;
> +		tick-timer =3D &timer0;
> +	};
> +
> +	memory@40000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x40000000 0x80000000>;
> +	};
> +
> +	gpio-keys {
> +		compatible =3D "gpio-keys";
> +
> +		button-reset {
> +			label =3D "reset";
> +			linux,code =3D <KEY_RESTART>;
> +			gpios =3D <&pio 7 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		status_led: led-0 {
> +			label =3D "green:status";
> +			gpios =3D <&pio 19 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-1 {
> +			label =3D "blue:wlan2g";
> +			gpios =3D <&pio 1 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-2 {
> +			label =3D "blue:wlan5g";
> +			gpios =3D <&pio 2 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	reg_1p8v: regulator-1p8v {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "fixed-1.8V";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "fixed-3.3V";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +};
> +
> +&eth {
> +	status =3D "okay";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mdio_pins>;
> +
> +	mediatek,gmac-id =3D <0>;
> +	phy-mode =3D "2500base-x";
> +	phy-handle =3D <&phy14>;
> +
> +	phy14: eth-phy@14 {
> +		compatible =3D "ethernet-phy-id03a2.a411";
> +		reg =3D <14>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&en8811_pwr_a>;
> +		airoha,pnswap-rx;
> +
> +		reset-gpios =3D <&pio 49 GPIO_ACTIVE_LOW>;
> +		reset-assert-us =3D <10000>;
> +		reset-deassert-us =3D <20000>;
> +	};
> +
> +	/*phy15: eth-phy@15 {
> +		compatible =3D "ethernet-phy-id03a2.a411";
> +		reg =3D <15>;
> +
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&en8811_pwr_b>;
> +		airoha,pnswap-rx;
> +
> +		reset-gpios =3D <&pio 47 GPIO_ACTIVE_LOW>;
> +		reset-assert-us =3D <10000>;
> +		reset-deassert-us =3D <20000>;
> +	};*/
> +};
> +
> +&mmc0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mmc0_pins_default>;
> +	bus-width =3D <8>;
> +	max-frequency =3D <200000000>;
> +	cap-mmc-highspeed;
> +	cap-mmc-hw-reset;
> +	vmmc-supply =3D <&reg_3p3v>;
> +	vqmmc-supply =3D <&reg_1p8v>;
> +	non-removable;
> +	status =3D "okay";
> +};
> +
> +&pio {
> +	en8811_pwr_a: en8811-pwr-a {
> +		pins =3D "GPIO_11";
> +		drive-strength =3D <MTK_DRIVE_8mA>;
> +		bias-pull-down =3D <MTK_PUPD_SET_R1R0_11>;
> +		output-low;
> +	};
> +
> +	en8811_pwr_b: en8811-pwr-b {
> +		pins =3D "GPIO_12";
> +		drive-strength =3D <MTK_DRIVE_8mA>;
> +		bias-pull-down =3D <MTK_PUPD_SET_R1R0_11>;
> +		output-low;
> +	};
> +
> +	mdio_pins: mdio-pins {
> +		mux {
> +			function =3D "eth";
> +			groups =3D "mdc_mdio";
> +		};
> +	};
> +
> +	mmc0_pins_default: mmc0default {
> +		mux {
> +			function =3D "flash";
> +			groups =3D  "emmc_51";
> +		};
> +
> +		conf-cmd-dat {
> +			pins =3D "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
> +			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
> +			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
> +			input-enable;
> +			drive-strength =3D <MTK_DRIVE_4mA>;
> +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		conf-clk {
> +			pins =3D "EMMC_CK";
> +			drive-strength =3D <MTK_DRIVE_6mA>;
> +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		conf-dsl {
> +			pins =3D "EMMC_DSL";
> +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		conf-rst {
> +			pins =3D "EMMC_RSTB";
> +			drive-strength =3D <MTK_DRIVE_4mA>;
> +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +		};
> +	};
> +
> +	spi_flash_pins: spi0-pins-func-1 {
> +		mux {
> +			function =3D "flash";
> +			groups =3D "spi0", "spi0_wp_hold";
> +		};
> +
> +		conf-pu {
> +			pins =3D "SPI2_CS", "SPI2_HOLD", "SPI2_WP";
> +			drive-strength =3D <MTK_DRIVE_8mA>;
> +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_11>;
> +		};
> +
> +		conf-pd {
> +			pins =3D "SPI2_CLK", "SPI2_MOSI", "SPI2_MISO";
> +			drive-strength =3D <MTK_DRIVE_8mA>;
> +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_11>;
> +		};
> +	};
> +
> +	pwm_pins: pwm0-pins-func-1 {
> +		mux {
> +			function =3D "pwm";
> +			groups =3D "pwm0";
> +		};
> +	};
> +};
> +
> +&pwm {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pwm_pins>;
> +	status =3D "okay";
> +};
> +
> +&spi0 {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&spi_flash_pins>;
> +	status =3D "okay";
> +	must_tx;
> +	enhance_timing;
> +	dma_ext;
> +	ipm_design;
> +	support_quad;
> +	tick_dly =3D <1>;
> +	sample_sel =3D <0>;
> +
> +	spi_nand@0 {
> +		compatible =3D "spi-nand";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <52000000>;
> +	};
> +
> +};
> +
> +&uart0 {
> +	status =3D "okay";
> +};
> +
> +&watchdog {
> +	status =3D "disabled";
> +};
> diff --git a/configs/mt7986a_bpir3_mini_emmc_defconfig b/configs/mt7986a=
_bpir3_mini_emmc_defconfig
> new file mode 100644
> index 00000000000..411ad11d6a7
> --- /dev/null
> +++ b/configs/mt7986a_bpir3_mini_emmc_defconfig
> @@ -0,0 +1,139 @@
> +CONFIG_ARM=3Dy
> +CONFIG_ARM_SMCCC=3Dy
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=3Dy
> +CONFIG_POSITION_INDEPENDENT=3Dy
> +CONFIG_ARCH_MEDIATEK=3Dy
> +CONFIG_TEXT_BASE=3D0x41e00000
> +CONFIG_SYS_MALLOC_F_LEN=3D0x4000
> +CONFIG_NR_DRAM_BANKS=3D1
> +CONFIG_ENV_SIZE=3D0x80000
> +CONFIG_ENV_OFFSET=3D0x300000
> +CONFIG_DEFAULT_DEVICE_TREE=3D"mt7986a-bpi-r3-mini-emmc"
> +CONFIG_TARGET_MT7986=3Dy
> +CONFIG_DEBUG_UART_BASE=3D0x11002000
> +CONFIG_DEBUG_UART_CLOCK=3D40000000
> +CONFIG_SYS_LOAD_ADDR=3D0x46000000
> +CONFIG_DEBUG_UART=3Dy
> +CONFIG_DEFAULT_FDT_FILE=3D"mt7986a-bpi-r3-mini-emmc"
> +CONFIG_LOGLEVEL=3D7
> +CONFIG_LOG=3Dy
> +CONFIG_SYS_PROMPT=3D"BPI-R3M> "
> +CONFIG_SYS_CBSIZE=3D512
> +CONFIG_SYS_PBSIZE=3D1049
> +# CONFIG_BOOTM_NETBSD is not set
> +# CONFIG_BOOTM_PLAN9 is not set
> +# CONFIG_BOOTM_RTEMS is not set
> +# CONFIG_BOOTM_VXWORKS is not set
> +# CONFIG_CMD_ELF is not set
> +# CONFIG_CMD_UNLZ4 is not set
> +# CONFIG_CMD_UNZIP is not set
> +CONFIG_CMD_GPIO=3Dy
> +CONFIG_CMD_GPT=3Dy
> +CONFIG_CMD_GPT_RENAME=3Dy
> +CONFIG_CMD_LSBLK=3Dy
> +CONFIG_CMD_MMC=3Dy
> +CONFIG_CMD_PART=3Dy
> +CONFIG_CMD_READ=3Dy
> +CONFIG_CMD_PING=3Dy
> +CONFIG_CMD_SMC=3Dy
> +CONFIG_CMD_FAT=3Dy
> +CONFIG_CMD_EXT4=3Dy
> +CONFIG_CMD_FS_GENERIC=3Dy
> +CONFIG_PARTITION_TYPE_GUID=3Dy
> +CONFIG_ENV_OVERWRITE=3Dy
> +CONFIG_ENV_IS_IN_MMC=3Dy
> +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=3Dy
> +CONFIG_NET_RANDOM_ETHADDR=3Dy
> +CONFIG_REGMAP=3Dy
> +CONFIG_SYSCON=3Dy
> +CONFIG_CLK=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_MMC_MTK=3Dy
> +CONFIG_PHY_FIXED=3Dy
> +CONFIG_DM_MDIO=3Dy
> +CONFIG_MEDIATEK_ETH=3Dy
> +CONFIG_PINCTRL=3Dy
> +CONFIG_PINCONF=3Dy
> +CONFIG_PINCTRL_MT7986=3Dy
> +CONFIG_POWER_DOMAIN=3Dy
> +CONFIG_MTK_POWER_DOMAIN=3Dy
> +CONFIG_DM_REGULATOR=3Dy
> +CONFIG_DM_REGULATOR_FIXED=3Dy
> +CONFIG_DM_SERIAL=3Dy
> +CONFIG_MTK_SERIAL=3Dy
> +CONFIG_FAT_WRITE=3Dy
> +CONFIG_HEXDUMP=3Dy
> +# CONFIG_EFI_LOADER is not set
> +CONFIG_LMB_MAX_REGIONS=3D64
> +
> +CONFIG_AUTOBOOT=3Dy
> +#CONFIG_BOOTDELAY=3D2
> +
> +CONFIG_FIT=3Dy
> +CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=3Dy
> +CONFIG_ENV_DEFAULT_ENV_TEXT_FILE=3D"uEnv_r3.txt"
> +CONFIG_HUSH_PARSER=3Dy
> +
> +CONFIG_MTD=3Dy
> +CONFIG_DM_MTD=3Dy
> +CONFIG_MTD_UBI=3Dy
> +CONFIG_CMD_UBI=3Dy
> +CONFIG_CMD_UBIFS=3Dy
> +CONFIG_SPI=3Dy
> +CONFIG_DM_SPI=3Dy
> +CONFIG_MTD_SPI_NAND=3Dy
> +CONFIG_MTK_SPIM=3Dy
> +#CONFIG_MTK_SPI_NAND=3Dy
> +#CONFIG_MTK_SPI_NAND_MTD=3Dy
> +#CONFIG_MTK_SNOR=3Dy
> +#CONFIG_MTK_SNFI_SPI=3Dy
> +CONFIG_SPI_FLASH=3Dy
> +CONFIG_SPI_FLASH_MTD=3Dy
> +CONFIG_SPI_FLASH_WINBOND=3Dy
> +CONFIG_CMD_MTD=3Dy
> +CONFIG_DM_SPI_FLASH=3Dy
> +CONFIG_CMD_SF=3Dy
> +#CONFIG_MTD_RAW_NAND=3Dy
> +#CONFIG_CMD_NAND=3Dy
> +#CONFIG_CMD_NAND_TRIMFFS=3Dy
> +CONFIG_ENABLE_NAND_NMBM=3Dy
> +CONFIG_MTDIDS_DEFAULT=3D"nmbm0=3Dnmbm0"
> +CONFIG_MTDPARTS_DEFAULT=3D"nmbm0:1024k(bl2),512k(u-boot-env),2048k(fact=
ory),2048k(fip),65536k(ubi)"
> +CONFIG_PHY=3Dy
> +CONFIG_PHY_MTK_TPHY=3Dy
> +CONFIG_DM_USB=3Dy
> +CONFIG_USB=3Dy
> +CONFIG_USB_XHCI_HCD=3Dy
> +CONFIG_USB_XHCI_MTK=3Dy
> +CONFIG_CMD_USB=3Dy
> +CONFIG_USB_STORAGE=3Dy
> +CONFIG_CMD_ASKENV=3Dy
> +CONFIG_CMD_STRINGS=3Dy
> +CONFIG_OF_LIBFDT_OVERLAY=3Dy
> +CONFIG_CMD_BOOTMENU=3Dy
> +CONFIG_SUPPORT_EMMC_BOOT=3Dy
> +
> +CONFIG_FS_LOADER=3Dy
> +CONFIG_PHY_AIROHA=3Dy
> +CONFIG_PHY_AIROHA_EN8811=3Dy
> +CONFIG_DM_ETH_PHY=3Dy
> +CONFIG_PHY_AIROHA_FW_BUILTIN=3Dy
> +CONFIG_PHY_ETHERNET_ID=3Dy
> +
> +CONFIG_PCI=3Dy
> +CONFIG_PCIE_MEDIATEK_GEN3=3Dy
> +CONFIG_CMD_PCI=3Dy
> +CONFIG_NVME_PCI=3Dy
> +CONFIG_NVME=3Dy
> +CONFIG_CMD_CACHE=3Dy
> +
> +CONFIG_CMD_PSTORE=3Dy
> +CONFIG_CMD_PSTORE_MEM_ADDR=3D0x42ff0000
> +CONFIG_CMD_PSTORE_RECORD_SIZE=3D0x1000
> +#CONFIG_CMD_PSTORE_CONSOLE_SIZE=3D0x1000
> +#CONFIG_CMD_PSTORE_FTRACE_SIZE=3D0x0
> +#CONFIG_CMD_PSTORE_PMSG_SIZE=3D0x1000
> +
> +CONFIG_DM_RNG=3Dy
> +CONFIG_RNG_MTK_V2=3Dy
> +CONFIG_CMD_RNG=3Dy
> --
> 2.34.1
