Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC3FC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68A46884CA;
	Fri, 14 Jun 2024 14:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="p1ZvcqRc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDCCD884CA; Fri, 14 Jun 2024 14:13:31 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C738F881BF
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6895721e93=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EBDejH009961;
 Fri, 14 Jun 2024 14:13:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 oietBq9FSff6jiabmtZlMW6SqFMEY+QP+56A0SaIGYg=; b=p1ZvcqRcO0JekOtL
 udTZ8O6gkfj8tXlz++zuIcDHpbXaY0ctV/LdGKR9PIjWjqvgDCq7KQVLMOPjk/w4
 baegcyGrBNvwywuUvhakt4Ep5gP/4E4dS4qptaPO7hB8C1hUkYJ9j36yo4rZldOf
 q4R5U67uXPQj+4qJz7wl1F5t6Cxzmccf4CwzSCzGhssWPkoQpqcc3Wl8OldOb8gQ
 ykAyZehobG95zLhPm4ziBeJ4csA9RIBniAbUXOv4FV3n5vQpT/yhgCIzVB6Asec5
 sRLZ8oaZMqRq7jXTIUYVxX7i3fxVqa/OpgAzBfteQF4rTrOsBSqPe85L/dSaYChS
 +eyQAA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypbp4gfcx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 14:13:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AE86F4002D;
 Fri, 14 Jun 2024 14:13:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ED6E02138E2;
 Fri, 14 Jun 2024 14:12:47 +0200 (CEST)
Received: from [10.252.18.60] (10.252.18.60) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 14 Jun
 2024 14:12:47 +0200
Message-ID: <047b06a5-5eb7-4928-80ba-4579168e5145@foss.st.com>
Date: Fri, 14 Jun 2024 14:12:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: Auto-detect second MAC on STM32MP15xx DH
 electronics DHCOM
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240606130222.24530-1-marex@denx.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240606130222.24530-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.18.60]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_09,2024-06-14_03,2024-05-17_01
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



On 6/6/24 15:01, Marek Vasut wrote:
> Test whether this system is compatible with STM32MP15xx DHCOM SoM,
> if so, test whether R292 pull up is populated on pin PC3, which is
> an indication that the second MAC chip, KS8851-16MLL, is populated.
> Use this information to patch 'status' DT property into the second
> ethernet MAC DT node and enable/disable the MAC on systems where
> the chip is/isn't populated respectively.
> 
> Use spl_perform_fixups() to patch the U-Boot proper DT from SPL and
> ft_board_setup() to patch Linux DT from U-Boot proper. This way both
> software components are configured the same way.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi |  1 +
>  board/dhelectronics/dh_stm32mp1/board.c    | 65 ++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi b/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
> index 1b445619325..d7b78cdcfa9 100644
> --- a/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
> @@ -26,6 +26,7 @@
>  		u-boot,error-led = "error";
>  		dh,som-coding-gpios = <&gpiof 12 0>, <&gpiof 13 0>, <&gpiof 15 0>;
>  		dh,ddr3-coding-gpios = <&gpioz 6 0>, <&gpioz 7 0>;
> +		dh,mac-coding-gpios = <&gpioc 3 0>;
>  	};
>  };
>  
> diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
> index 20c9d70737e..ebd45f9053f 100644
> --- a/board/dhelectronics/dh_stm32mp1/board.c
> +++ b/board/dhelectronics/dh_stm32mp1/board.c
> @@ -37,6 +37,7 @@
>  #include <power/regulator.h>
>  #include <remoteproc.h>
>  #include <reset.h>
> +#include <spl.h>
>  #include <syscon.h>
>  #include <usb.h>
>  #include <usb/dwc2_udc.h>
> @@ -672,12 +673,69 @@ void board_quiesce_devices(void)
>  #endif
>  }
>  
> +static void dh_stm32_ks8851_fixup(void *blob)
> +{
> +	struct gpio_desc ks8851intrn;
> +	bool compatible = false;
> +	int ks8851intrn_value;
> +	const char *prop;
> +	ofnode node;
> +	int idx = 0;
> +	int offset;
> +	int ret;
> +
> +	/* Do nothing if not STM32MP15xx DHCOM SoM */
> +	while ((prop = fdt_stringlist_get(blob, 0, "compatible", idx++, NULL))) {
> +		if (!strstr(prop, "dhcom-som"))
> +			continue;
> +		compatible = true;
> +		break;
> +	}
> +
> +	if (!compatible)
> +		return;
> +
> +	/*
> +	 * Read state of INTRN pull up resistor, if this pull up is populated,
> +	 * KS8851-16MLL is populated as well and should be enabled, otherwise
> +	 * it should be disabled.
> +	 */
> +	node = ofnode_path("/config");
> +	if (!ofnode_valid(node))
> +		return;
> +
> +	ret = gpio_request_by_name_nodev(node, "dh,mac-coding-gpios", 0,
> +					 &ks8851intrn, GPIOD_IS_IN);
> +	if (ret)
> +		return;
> +
> +	ks8851intrn_value = dm_gpio_get_value(&ks8851intrn);
> +
> +	dm_gpio_free(NULL, &ks8851intrn);
> +
> +	/* Set the 'status' property into KS8851-16MLL DT node. */
> +	offset = fdt_path_offset(blob, "ethernet1");
> +	ret = fdt_node_check_compatible(blob, offset, "micrel,ks8851-mll");
> +	if (ret)	/* Not compatible */
> +		return;
> +
> +	/* Add a bit of extra space for new 'status' property */
> +	ret = fdt_shrink_to_minimum(blob, 4096);
> +	if (!ret)
> +		return;
> +
> +	fdt_setprop_string(blob, offset, "status",
> +			   ks8851intrn_value ? "okay" : "disabled");
> +}
> +
>  #if defined(CONFIG_OF_BOARD_SETUP)
>  int ft_board_setup(void *blob, struct bd_info *bd)
>  {
>  	const char *buck3path = "/soc/i2c@5c002000/stpmic@33/regulators/buck3";
>  	int buck3off, ret, uv;
>  
> +	dh_stm32_ks8851_fixup(blob);
> +
>  	ret = board_get_regulator_buck3_nvm_uv_av96(&uv);
>  	if (ret)	/* Not Avenger96 board, do not patch Buck3 in DT. */
>  		return 0;
> @@ -698,6 +756,13 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>  }
>  #endif
>  
> +#if defined(CONFIG_SPL_BUILD)
> +void spl_perform_fixups(struct spl_image_info *spl_image)
> +{
> +	dh_stm32_ks8851_fixup(spl_image_fdt_addr(spl_image));
> +}
> +#endif
> +
>  static void board_copro_image_process(ulong fw_image, size_t fw_size)
>  {
>  	int ret, id = 0; /* Copro id fixed to 0 as only one coproc on mp1 */
Applied to u-boot-stm32/next

Thanks
Patrice
