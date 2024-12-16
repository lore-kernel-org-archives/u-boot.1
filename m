Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2259CE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 07:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 414F88005B;
	Mon, 16 Dec 2024 08:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B34AD80104; Mon, 16 Dec 2024 08:31:54 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F1CF8003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 08:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [IPV6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46] (unknown
 [IPv6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 01A6FB4B2B3E;
 Mon, 16 Dec 2024 08:31:48 +0100 (CET)
Message-ID: <759d8791-97df-44bc-91e6-8a8f8daeaacc@freeshell.de>
Date: Sun, 15 Dec 2024 23:31:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] dts: starfive: Add JH7110 Cadence USB dts node
To: Minda Chen <minda.chen@starfivetech.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Roger Quadros <rogerq@kernel.org>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>
References: <20241012031328.4268-1-minda.chen@starfivetech.com>
 <20241012031328.4268-8-minda.chen@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20241012031328.4268-8-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 10/11/24 20:13, Minda Chen wrote:
> Add Jh7110 Cadence USB dts node, Visionfive2 default setting
> is USB 2.0 device.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>   .../dts/jh7110-starfive-visionfive-2.dtsi     |  5 ++
>   arch/riscv/dts/jh7110.dtsi                    | 53 +++++++++++++++++++
>   2 files changed, 58 insertions(+)
> 
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> index e11babc1cde..f62582cf93e 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> @@ -378,3 +378,8 @@
>   		};
>   	};
>   };
> +
> +&usb0 {
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
> index 2cdc683d49b..c770da2fedd 100644
> --- a/arch/riscv/dts/jh7110.dtsi
> +++ b/arch/riscv/dts/jh7110.dtsi
> @@ -371,6 +371,59 @@
>   			status = "disabled";
>   		};
>   
> +		usb0: usb@10100000 {
> +			compatible = "starfive,jh7110-usb";
> +			ranges = <0x0 0x0 0x10100000 0x100000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			starfive,stg-syscon = <&stg_syscon 0x4>;
> +			clocks = <&stgcrg JH7110_STGCLK_USB_LPM>,
> +				 <&stgcrg JH7110_STGCLK_USB_STB>,
> +				 <&stgcrg JH7110_STGCLK_USB_APB>,
> +				 <&stgcrg JH7110_STGCLK_USB_AXI>,
> +				 <&stgcrg JH7110_STGCLK_USB_UTMI_APB>;
> +			clock-names = "lpm", "stb", "apb", "axi", "utmi_apb";
> +			resets = <&stgcrg JH7110_STGRST_USB_PWRUP>,
> +				 <&stgcrg JH7110_STGRST_USB_APB>,
> +				 <&stgcrg JH7110_STGRST_USB_AXI>,
> +				 <&stgcrg JH7110_STGRST_USB_UTMI_APB>;
> +			reset-names = "pwrup", "apb", "axi", "utmi_apb";
> +			status = "disabled";
> +
> +			usb_cdns3: usb@0 {
> +				compatible = "cdns,usb3";
> +				reg = <0x0 0x10000>,
> +				      <0x10000 0x10000>,
> +				      <0x20000 0x10000>;
> +				reg-names = "otg", "xhci", "dev";
> +				interrupts = <100>, <108>, <110>;
> +				interrupt-names = "host", "peripheral", "otg";
> +				phys = <&usbphy0>;
> +				phy-names = "cdns3,usb2-phy";
> +			};
> +		};
> +
> +		usbphy0: phy@10200000 {
> +			compatible = "starfive,jh7110-usb-phy";
> +			reg = <0x0 0x10200000 0x0 0x10000>;
> +			clocks = <&syscrg JH7110_SYSCLK_USB_125M>,
> +				 <&stgcrg JH7110_STGCLK_USB_APP_125>;
> +			clock-names = "125m", "app_125m";
> +			#phy-cells = <0>;
> +		};
> +
> +		pciephy0: phy@10210000 {
> +			compatible = "starfive,jh7110-pcie-phy";
> +			reg = <0x0 0x10210000 0x0 0x10000>;
> +			#phy-cells = <0>;
> +		};
> +
> +		pciephy1: phy@10220000 {
> +			compatible = "starfive,jh7110-pcie-phy";
> +			reg = <0x0 0x10220000 0x0 0x10000>;
> +			#phy-cells = <0>;
> +		};
> +
>   		stgcrg: clock-controller@10230000 {
>   			compatible = "starfive,jh7110-stgcrg";
>   			reg = <0x0 0x10230000 0x0 0x10000>;

Drop this patch. Prefer instead to depend on "Support OF_UPSTREAM for 
StarFive JH7110" series. I have a couple of patches into upstream Linux 
riscv-dt-for-next with the vbus GPIO assignment and setting host mode 
that should land with Linux 6.14, for Mars and for Star64 boards.

-E
