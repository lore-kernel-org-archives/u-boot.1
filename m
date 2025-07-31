Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BC0C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 09:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDB518349B;
	Thu, 31 Jul 2025 11:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="BdoGo0sj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B0958368F; Thu, 31 Jul 2025 11:20:31 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09FD483457
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 11:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0307a9198e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V91mSI011806;
 Thu, 31 Jul 2025 11:20:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 rQIv8MswZLs82CQedP/SphtEA543R93UV1N1DKXVRd0=; b=BdoGo0sjCnTmKghD
 zjL9VvBONYH4o507qAyD4sxcWtP7BYlugfQDENg0uLfSYd6N2Gr2tBGE1MzN9xZA
 0Tpb5xNBBzBSHp+G6YIv/jsUuKXQnHzPlDqarjsYpTr0cRLrmI1e4zFFw8gPvFRf
 PCfL6Jg4UjyYnm5J2vIhWWYSTBr15BAQjKxG5TFyOdsU7V2fFLPcnV56Os1ovye2
 gU0nrhKrjSk4lwMfq0BuRz7OHIFzskomk3Y8rs622vN9ZGv5hBizEP/MWrKB5dBW
 DE1TsTvmbrIv3Odb8TyKOTCvhQb8bNxBGRgxQJDysk0wh+IDA/ENbfHvpfdJD6ik
 o6PlMg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4859ynu62u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Jul 2025 11:20:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1FB7440062;
 Thu, 31 Jul 2025 11:19:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F0C8A7530B7;
 Thu, 31 Jul 2025 11:18:50 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 11:18:50 +0200
Message-ID: <2e3b5375-f235-442d-b75d-310474e7181a@foss.st.com>
Date: Thu, 31 Jul 2025 11:18:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] ARM: dts: stm32: Add STM32MP13x SPL specific DT
 additions
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Cheick Traore <cheick.traore@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250630001053.952342-1-marek.vasut@mailbox.org>
 <20250630001053.952342-8-marek.vasut@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250630001053.952342-8-marek.vasut@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
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



On 6/30/25 02:10, Marek Vasut wrote:
> Add DT additions required by U-Boot SPL to bring up the hardware.
> This includes binman node to generate STM32 Image v2.0 which can be
> booted by the BootROM, clock entries used by the SPL clock driver
> during clock tree initialization, and syscon-reboot node so U-Boot
> can reset the system without having to rely on PSCI call.
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Cheick Traore <cheick.traore@foss.st.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>
> Cc: Lionel Debieve <lionel.debieve@foss.st.com>
> Cc: Pascal Zimmermann <pzimmermann@dh-electronics.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
> V2: Add RB from Patrice
> ---
>  arch/arm/dts/stm32mp13-u-boot.dtsi | 89 ++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32mp13-u-boot.dtsi b/arch/arm/dts/stm32mp13-u-boot.dtsi
> index 1fe6966781c..ad63d5027b2 100644
> --- a/arch/arm/dts/stm32mp13-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp13-u-boot.dtsi
> @@ -17,6 +17,7 @@
>  		pinctrl0 = &pinctrl;
>  	};
>  
> +#if defined(CONFIG_TFABOOT)
>  	firmware {
>  		optee {
>  			bootph-all;
> @@ -27,6 +28,86 @@
>  	psci {
>  		bootph-some-ram;
>  	};
> +#else
> +	binman: binman {
> +		multiple-images;
> +
> +		spl-stm32 {
> +			filename = "u-boot-spl.stm32";
> +			mkimage {
> +				args = "-T stm32imagev2 -a 0x2ffe0000 -e 0x2ffe0000";
> +				u-boot-spl {
> +					no-write-symbols;
> +				};
> +			};
> +		};
> +	};
> +
> +	clocks {
> +		bootph-all;
> +
> +		clk_hse: ck_hse {
> +			bootph-all;
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <24000000>;
> +		};
> +
> +		clk_hsi: ck_hsi {
> +			bootph-all;
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <64000000>;
> +		};
> +
> +		clk_lse: ck_lse {
> +			bootph-all;
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <32768>;
> +		};
> +
> +		clk_lsi: ck_lsi {
> +			bootph-all;
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +		};
> +
> +		clk_csi: ck_csi {
> +			bootph-all;
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <4000000>;
> +		};
> +	};
> +
> +	cpu0_opp_table: cpu0-opp-table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +		bootph-pre-ram;
> +		opp-650000000 {
> +			bootph-pre-ram;
> +			opp-hz = /bits/ 64 <650000000>;
> +			opp-microvolt = <1200000>;
> +			opp-supported-hw = <0x1>;
> +		};
> +		opp-1000000000 {
> +			bootph-pre-ram;
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt = <1350000>;
> +			opp-supported-hw = <0x2>;
> +		};
> +	};
> +
> +	reboot {
> +		bootph-all;
> +		compatible = "syscon-reboot";
> +		regmap = <&rcc>;
> +		offset = <0x114>;
> +		mask = <0x1>;
> +	};
> +#endif
>  
>  	soc {
>  		bootph-all;
> @@ -52,6 +133,14 @@
>  	bootph-all;
>  };
>  
> +#if !defined(CONFIG_TFABOOT)
> +&cpu0 {
> +	nvmem-cells = <&part_number_otp>;
> +	nvmem-cell-names = "part_number";
> +	operating-points-v2 = <&cpu0_opp_table>;
> +};
> +#endif
> +
>  &gpioa {
>  	bootph-all;
>  };
Applied to u-boot-stm32/master

Thanks
Patrice
