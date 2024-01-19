Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F188C47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 13:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D8387927;
	Fri, 19 Jan 2024 14:22:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="6RFrY6QE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE4C78794A; Fri, 19 Jan 2024 14:22:58 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EDD387920
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 14:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=17487c629f=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40JBKVLb009098; Fri, 19 Jan 2024 14:22:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=XyUSgwV/jko3KH7OVlsSFu6ibec2ZrcPGfpSF+7qTEM=; b=6R
 FrY6QEkAKw2GvkkAHGtiKKn9/JsIiBLcSImROV+AnC/GPU5DcEhOmQbzJsjo1kZW
 GcpjPxkLr4oVlZ/bAGhJD4TsmHYnFLuqrrjNFqoIY92UsDcb/IFlp/7245srccRZ
 vEe49k2Q6lFskXAqcdHQrKijxRLCWhalQfE+xqZrRcqJj3M/5aHWinrF0TbrrliD
 xfnJ+G1SUooHvfmoviFsDorGqqRYP3NMGI+U51FdJKr3HuqKOg1mfUHtLuzqVun0
 C3PVM6THM458DjX395XuGOEQsHScXl9cNkUHNYTC4d8r+gmqNL2s3RqNVQ5DWkwH
 OMDg9zVTSYKAMUn1Alyw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmbhntvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 14:22:54 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 10FFA100081;
 Fri, 19 Jan 2024 14:22:54 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0AF05245513;
 Fri, 19 Jan 2024 14:22:54 +0100 (CET)
Received: from [10.252.4.250] (10.252.4.250) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Jan
 2024 14:22:53 +0100
Message-ID: <ff086ee2-0a84-470c-927d-edd217c343ea@foss.st.com>
Date: Fri, 19 Jan 2024 14:22:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] arm64: dts: st: add bsec support to stm32mp25
Content-Language: en-US
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Simon Glass
 <sjg@chromium.org>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
 <20240115150451.v2.1.Iefa175618c8da1cb27702d86b19bdada62a0f01d@changeid>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240115150451.v2.1.Iefa175618c8da1cb27702d86b19bdada62a0f01d@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.4.250]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_08,2024-01-19_02,2023-05-22_02
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



On 1/15/24 15:05, Patrick Delaunay wrote:
> Add BSEC support to STM32MP25 SoC family with SoC information:
> - RPN = Device part number (BSEC_OTP_DATA9)
> - PKG = package data register (Bits 2:0 of BSEC_OTP_DATA122)
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/dts/stm32mp25-u-boot.dtsi |  4 ++++
>  arch/arm/dts/stm32mp251.dtsi       | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32mp25-u-boot.dtsi b/arch/arm/dts/stm32mp25-u-boot.dtsi
> index f4f26add2a41..0c8e95b34163 100644
> --- a/arch/arm/dts/stm32mp25-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp25-u-boot.dtsi
> @@ -37,6 +37,10 @@
>  	};
>  };
>  
> +&bsec {
> +	bootph-all;
> +};
> +
>  &gpioa {
>  	bootph-all;
>  };
> diff --git a/arch/arm/dts/stm32mp251.dtsi b/arch/arm/dts/stm32mp251.dtsi
> index cf2f28dc1582..44eb664fb510 100644
> --- a/arch/arm/dts/stm32mp251.dtsi
> +++ b/arch/arm/dts/stm32mp251.dtsi
> @@ -127,6 +127,22 @@
>  			};
>  		};
>  
> +		bsec: efuse@44000000 {
> +			compatible = "st,stm32mp25-bsec";
> +			reg = <0x44000000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			part_number_otp@24 {
> +				reg = <0x24 0x4>;
> +			};
> +
> +			package_otp@1e8 {
> +				reg = <0x1e8 0x1>;
> +				bits = <0 3>;
> +			};
> +		};
> +
>  		syscfg: syscon@44230000 {
>  			compatible = "st,stm32mp25-syscfg", "syscon";
>  			reg = <0x44230000 0x10000>;

Applied to u-boot-stm32/master

Thanks
Patrice
