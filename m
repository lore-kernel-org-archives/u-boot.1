Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D20F8FA94
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17598842B7;
	Tue, 21 Apr 2026 17:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IMANqzCC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06379842A4; Tue, 21 Apr 2026 16:10:31 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A95A4839D5
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g0PQB51YCz9t5H;
 Tue, 21 Apr 2026 16:10:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776780626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HlETeEzxHSXui/3ZB/22mDE4IPp+8viT3xUveQavu8=;
 b=IMANqzCCtFV3a7qfwbLm7pHN+qhF4umX1kRQQSTAm5u4cUm9k96YJbFdsSkx4vSAhaJD+6
 GJgDPHKlxGLcpCK14pG7e7p0D8ickUAYZdMJHFlmC3SwN+Z/87AMWcQEUy9RcvmDuIoYJb
 SHOL1xG5bjkZYUfa1tQQyD/9aEr7AIziftDm0hCDXFFgaWyDyWD5AP+iKYLw/qx+FSmE9j
 THZvGgdjD1uaFEhiEup8eGulVdRbrXL4U1Z7UnbECexcNLGNEvY6raIK3LszA84oqMPRRJ
 ZkURZZ9uZJCX0SY4AnUnXIc1NQjY0M2cpoSEtVxebBp8XUr9n0mq3WeYGWEYvA==
Message-ID: <aa7822a0-a114-4989-b23d-9e242bd2dcde@mailbox.org>
Date: Tue, 21 Apr 2026 16:10:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/5] arm: dts: imx: Update watchdog nodes for dynamic
 base address lookup
To: alice.guo@oss.nxp.com, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Christoph Stoidner <c.stoidner@phytec.de>,
 upstream@lists.phytec.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Simon Glass <sjg@chromium.org>,
 Fedor Ross <fedor.ross@ifm.com>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 =?UTF-8?Q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, Jacky Bai <ping.bai@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Tim Harvey <tharvey@gateworks.com>, Anshul Dalal <anshuld@ti.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Joseph Guo <qijian.guo@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>,
 Alice Guo <alice.guo@nxp.com>
References: <20260421-wdt-v1-0-0bd01ec6a7c4@nxp.com>
 <20260421-wdt-v1-2-0bd01ec6a7c4@nxp.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260421-wdt-v1-2-0bd01ec6a7c4@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 85fzpi1sqxzbgu41ddwpedy487cbjrep
X-MBO-RS-ID: 4124b0baed44d599a93
X-Mailman-Approved-At: Tue, 21 Apr 2026 17:12:16 +0200
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

On 4/21/26 16:01, alice.guo@oss.nxp.com wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Update watchdog device tree nodes to enable dynamic base address
> retrieval for i.MX7ULP, i.MX8ULP, i.MX91, i.MX93, i.MX943, i.MX95 and
> i.MX952. This allows the bootloader to obtain watchdog base addresses
> from the device tree instead of using hardcoded values.
> 
> - imx7ulp: Add wdog2 node
> - imx8ulp: Mark wdog3 available
> - imx91/imx93: Add wdog4 and wdog5 nodes
> 	       Mark wdog3/wdog4/wdog5 available
> - imx943: Add wdog4 node and mark wdog3/wdog4 available
> - imx95/imx952: Add wdog4 node and mark wdog3/wdog4 available
> 
> Watchdog nodes are marked with "bootph-all" to ensure availability
> during early boot stages when init_wdog() occurs.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>   arch/arm/dts/imx7ulp.dtsi        |  6 ++++++
>   arch/arm/dts/imx8ulp-u-boot.dtsi |  4 ++++
>   arch/arm/dts/imx91-u-boot.dtsi   | 12 ++++++++++++
>   arch/arm/dts/imx93-u-boot.dtsi   | 12 ++++++++++++
>   arch/arm/dts/imx93.dtsi          | 18 ++++++++++++++++++
>   arch/arm/dts/imx943-u-boot.dtsi  | 16 ++++++++++++++++
>   arch/arm/dts/imx95-u-boot.dtsi   | 14 ++++++++++++++
>   arch/arm/dts/imx952-u-boot.dtsi  | 14 ++++++++++++++
>   8 files changed, 96 insertions(+)
> 
> diff --git a/arch/arm/dts/imx7ulp.dtsi b/arch/arm/dts/imx7ulp.dtsi
> index bcec98b9641..45a69f06e20 100644
> --- a/arch/arm/dts/imx7ulp.dtsi
> +++ b/arch/arm/dts/imx7ulp.dtsi
> @@ -295,6 +295,12 @@
>   			clock-names = "divcore", "hsrun_divcore";
>   		};
>   
> +		wdog2: watchdog@40430000 {
> +			compatible = "fsl,imx7ulp-wdt";
> +			reg = <0x40430000 0x10000>;
> +			timeout-sec = <40>;
> +		};
> +
>   		pcc3: clock-controller@40b30000 {
>   			compatible = "fsl,imx7ulp-pcc3";
>   			reg = <0x40b30000 0x10000>;
> diff --git a/arch/arm/dts/imx8ulp-u-boot.dtsi b/arch/arm/dts/imx8ulp-u-boot.dtsi
> index 30baaeff8ef..54ecbcf1795 100644
> --- a/arch/arm/dts/imx8ulp-u-boot.dtsi
> +++ b/arch/arm/dts/imx8ulp-u-boot.dtsi
> @@ -61,3 +61,7 @@
>   	};
>   };
>   #endif
> +
> +&wdog3 {
> +	bootph-all;
> +};
> diff --git a/arch/arm/dts/imx91-u-boot.dtsi b/arch/arm/dts/imx91-u-boot.dtsi
> index 5b639c965d6..149f7bc685a 100644
> --- a/arch/arm/dts/imx91-u-boot.dtsi
> +++ b/arch/arm/dts/imx91-u-boot.dtsi
> @@ -90,3 +90,15 @@
>   		};
>   	};
>   };
> +
> +&wdog3 {
> +	bootph-all;
> +};
> +
> +&wdog4 {
> +	bootph-all;
> +};
> +
> +&wdog5 {
> +	bootph-all;
> +};
> diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
> index dc86746ac90..a84cdf2bc45 100644
> --- a/arch/arm/dts/imx93-u-boot.dtsi
> +++ b/arch/arm/dts/imx93-u-boot.dtsi
> @@ -96,3 +96,15 @@
>   			       0x000001b2 0x800001b6>;
>   	#thermal-sensor-cells = <1>;
>   };
> +
> +&wdog3 {
> +	bootph-all;
> +};
> +
> +&wdog4 {
> +	bootph-all;
> +};
> +
> +&wdog5 {
> +	bootph-all;
> +};
> diff --git a/arch/arm/dts/imx93.dtsi b/arch/arm/dts/imx93.dtsi
> index d6964714ea0..511e9594e37 100644
> --- a/arch/arm/dts/imx93.dtsi
> +++ b/arch/arm/dts/imx93.dtsi
> @@ -414,6 +414,24 @@
>   				timeout-sec = <40>;
>   			};
>   
> +			wdog4: watchdog@424a0000 {
> +				compatible = "fsl,imx93-wdt";
> +				reg = <0x424a0000 0x10000>;
> +				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX93_CLK_WDOG4_GATE>;
> +				timeout-sec = <40>;
> +				status = "disabled";
> +			};
> +
> +			wdog5: watchdog@424b0000 {
> +				compatible = "fsl,imx93-wdt";
> +				reg = <0x424b0000 0x10000>;
> +				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX93_CLK_WDOG5_GATE>;
> +				timeout-sec = <40>;
> +				status = "disabled";
> +			};
> +
>   			tpm3: pwm@424e0000 {
>   				compatible = "fsl,imx7ulp-pwm";
>   				reg = <0x424e0000 0x1000>;
> diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
> index 3457442a3b0..fca0f10c865 100644
> --- a/arch/arm/dts/imx943-u-boot.dtsi
> +++ b/arch/arm/dts/imx943-u-boot.dtsi
> @@ -159,6 +159,18 @@
>   	};
>   };
>   
> +&aips4 {
> +	bootph-all;
> +
> +	wdog4: watchdog@49230000 {
> +		bootph-all;
> +
> +		compatible = "fsl,imx94-wdt", "fsl,imx93-wdt";
> +		reg = <0x49230000 0x10000>;
> +		status = "disabled";
> +	};
> +};
> +
>   &clk_ext1 {
>   	bootph-all;
>   };
> @@ -460,3 +472,7 @@
>   &sram0 {
>   	bootph-all;
>   };
> +
> +&wdog3 {
> +	bootph-all;
> +};
> diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
> index 6dec159752b..2fdb7e331b6 100644
> --- a/arch/arm/dts/imx95-u-boot.dtsi
> +++ b/arch/arm/dts/imx95-u-boot.dtsi
> @@ -138,6 +138,16 @@
>   
>   &aips2 {
>   	bootph-all;
> +
> +	wdog4: watchdog@424a0000 {
> +		bootph-all;
> +
> +		compatible = "fsl,imx93-wdt";
> +		reg = <0x424a0000 0x10000>;
> +		clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +		timeout-sec = <40>;
> +		status = "disabled";

I understand why "bootph-all" is in the u-boot special file. But the
other main properties defining the watchdog device should be in the
common dts(i) file, no?

Checking mainline kernel I see, that "bootph-all" is used there as well.
It seems to be accepted. So why not move everything into the common
dts/dtsi files instead?

Thanks,
Stefan

> +	};
>   };
>   
>   &aips3 {
> @@ -238,3 +248,7 @@
>   &scmi_buf1 {
>   	bootph-all;
>   };
> +
> +&wdog3 {
> +	bootph-all;
> +};
> diff --git a/arch/arm/dts/imx952-u-boot.dtsi b/arch/arm/dts/imx952-u-boot.dtsi
> index e977014992e..082dab75a18 100644
> --- a/arch/arm/dts/imx952-u-boot.dtsi
> +++ b/arch/arm/dts/imx952-u-boot.dtsi
> @@ -115,6 +115,16 @@
>   
>   &aips2 {
>   	bootph-all;
> +
> +	wdog4: watchdog@420c0000 {
> +		bootph-all;
> +
> +		compatible = "fsl,imx93-wdt";
> +		reg = <0x420c0000 0x10000>;
> +		clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>;
> +		timeout-sec = <40>;
> +		status = "disabled";
> +	};
>   };
>   
>   &aips3 {
> @@ -237,6 +247,10 @@
>   	bootph-pre-ram;
>   };
>   
> +&wdog3 {
> +	bootph-all;
> +};
> +
>   &scmi_iomuxc {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_hog>;
> 

