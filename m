Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98522C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 07:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B5FB88FDA;
	Fri, 26 Apr 2024 09:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="yIa2CGs5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAE19890FE; Fri, 26 Apr 2024 09:48:25 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0676588FD8
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 09:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4846c7b602=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q0wEJg012185;
 Fri, 26 Apr 2024 09:48:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=Tlw7JCSp98V0AlCpVn/7r6fomVkhFAB7XG5LwbZeFA8=; b=yI
 a2CGs5VAl3dbfY7WK/2B565IxN+OfEa0UNNpzKUogKigDRWTmN4ES4Fturf9pCk9
 gXv8VhyLwDA0fHi1c91/HO17sHV3yjna0020AIn7QeERntaHGrfIWmX5P/2LW/OO
 mb1o8zHsbfc0376v48N1cno7+MnHxu9qCgmRjI9WAGk/X54yjp60loWn9JRwSrUP
 xKQ/uStuAAg0qbCnXGOzkAqjG59z6Kni+ZHkDwwhHxZxkhhqEvAcNeC6oCqPsbZs
 fBgz3vhojldg9cHJVop4DagpubbSb55+pO1n5HYqnHQZwI9WC/hkckkBkyrRlW46
 CBdX2O5D/YJJR4OPaD1Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xmq90y2ge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 09:48:13 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A303840049;
 Fri, 26 Apr 2024 09:48:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 31B21212FB6;
 Fri, 26 Apr 2024 09:47:43 +0200 (CEST)
Received: from [10.48.86.98] (10.48.86.98) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 09:47:42 +0200
Message-ID: <b030f729-c0d9-4249-8a5b-38124ada5379@foss.st.com>
Date: Fri, 26 Apr 2024 09:47:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: add eth1 and eth2 support on stm32mp13
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Christophe Roullier <christophe.roullier@st.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240421230954.193773-1-marex@denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240421230954.193773-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.98]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_07,2024-04-26_01,2023-05-22_02
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



On 4/22/24 01:09, Marek Vasut wrote:
> From: Christophe Roullier <christophe.roullier@st.com>
> 
> Add both ethernet MACs based on GMAC SNPS IP on stm32mp13.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
> ---
> Cc: Christophe Roullier <christophe.roullier@st.com>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: u-boot@dh-electronics.com
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  arch/arm/dts/stm32mp131.dtsi | 37 ++++++++++++++++++++++++++++++++++++
>  arch/arm/dts/stm32mp133.dtsi | 30 +++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32mp131.dtsi b/arch/arm/dts/stm32mp131.dtsi
> index 159ba8f8c9c..ad331b73d18 100644
> --- a/arch/arm/dts/stm32mp131.dtsi
> +++ b/arch/arm/dts/stm32mp131.dtsi
> @@ -1328,6 +1328,37 @@
>  			status = "disabled";
>  		};
>  
> +		eth1: eth1@5800a000 {
> +			compatible = "snps,dwmac-4.20a", "st,stm32mp13-dwmac";
> +			reg = <0x5800a000 0x2000>;
> +			reg-names = "stmmaceth";
> +			interrupts-extended = <&intc GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&exti 68 1>;
> +			interrupt-names = "macirq", "eth_wake_irq";
> +			clock-names = "stmmaceth",
> +				      "mac-clk-tx",
> +				      "mac-clk-rx",
> +				      "ethstp",
> +				      "eth-ck";
> +			clocks = <&rcc ETH1MAC>,
> +				 <&rcc ETH1TX>,
> +				 <&rcc ETH1RX>,
> +				 <&rcc ETH1STP>,
> +				 <&rcc ETH1CK_K>;
> +			st,syscon = <&syscfg 0x4 0xff0000>;
> +			snps,mixed-burst;
> +			snps,pbl = <2>;
> +			snps,axi-config = <&stmmac_axi_config_1>;
> +			snps,tso;
> +			status = "disabled";
> +
> +			stmmac_axi_config_1: stmmac-axi-config {
> +				snps,wr_osr_lmt = <0x7>;
> +				snps,rd_osr_lmt = <0x7>;
> +				snps,blen = <0 0 0 0 16 8 4>;
> +			};
> +		};
> +
>  		usbh_ohci: usb@5800c000 {
>  			compatible = "generic-ohci";
>  			reg = <0x5800c000 0x1000>;
> @@ -1404,6 +1435,12 @@
>  			ts_cal2: calib@5e {
>  				reg = <0x5e 0x2>;
>  			};
> +			ethernet_mac1_address: mac1@e4 {
> +				reg = <0xe4 0x6>;
> +			};
> +			ethernet_mac2_address: mac2@ea {
> +				reg = <0xea 0x6>;
> +			};
>  		};
>  
>  		/*
> diff --git a/arch/arm/dts/stm32mp133.dtsi b/arch/arm/dts/stm32mp133.dtsi
> index df451c3c2a2..5cd5bde9535 100644
> --- a/arch/arm/dts/stm32mp133.dtsi
> +++ b/arch/arm/dts/stm32mp133.dtsi
> @@ -64,5 +64,35 @@
>  				};
>  			};
>  		};
> +
> +		eth2: eth2@5800e000 {
> +			compatible = "snps,dwmac-4.20a", "st,stm32mp13-dwmac";
> +			reg = <0x5800e000 0x2000>;
> +			reg-names = "stmmaceth";
> +			interrupts-extended = <&intc GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			clock-names = "stmmaceth",
> +				      "mac-clk-tx",
> +				      "mac-clk-rx",
> +				      "ethstp",
> +				      "eth-ck";
> +			clocks = <&rcc ETH2MAC>,
> +				 <&rcc ETH2TX>,
> +				 <&rcc ETH2RX>,
> +				 <&rcc ETH2STP>,
> +				 <&rcc ETH2CK_K>;
> +			st,syscon = <&syscfg 0x4 0xff000000>;
> +			snps,mixed-burst;
> +			snps,pbl = <2>;
> +			snps,axi-config = <&stmmac_axi_config_2>;
> +			snps,tso;
> +			status = "disabled";
> +
> +			stmmac_axi_config_2: stmmac-axi-config {
> +				snps,wr_osr_lmt = <0x7>;
> +				snps,rd_osr_lmt = <0x7>;
> +				snps,blen = <0 0 0 0 16 8 4>;
> +			};
> +		};
>  	};
>  };
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
