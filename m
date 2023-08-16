Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D46C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 13:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3350A86233;
	Wed, 16 Aug 2023 15:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="BdBc4DS9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BF2A869DA; Wed, 16 Aug 2023 15:28:24 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F26A380740
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 15:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6592a39e51=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37G9C2lw021241; Wed, 16 Aug 2023 15:28:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=ahvggLXkldaOLlXgOau7hw/a8WVMq+fFB6DY4WeF/9w=; b=Bd
 Bc4DS9IJiKumdPmpRfLMANeqeYxaJf6oHF/0A1W+JPggb54EpJ6OD4zaGkmLa0Xz
 IWUzVmSSuEGS1gpccVNZkioIeemYsHOcYnMXffBUQjqJUK437XYNBtKCUQPIzPUS
 fhNzFKExzkg+A1U3Us2RwmmgqD8rCwOhhhGkqFIAMVBBH5hYlXV2utSWZ7zafgQa
 HHbzM7cXwouq4xo/PqQ4ssaMZnz4rObuHkwHRAruj0FeHs0rsdsvo9gkjCdSaSD0
 /eSKkF3sD2/7SrOXXLZIsG4RLKGetY9Q9EiZ1NWZhr+lsi4gncQ4wI2T/EsS80at
 8Z7hicUGX7Uese/x3Cjw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sgum7hena-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Aug 2023 15:28:20 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BFE1310005D;
 Wed, 16 Aug 2023 15:28:19 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B524D242AAE;
 Wed, 16 Aug 2023 15:28:19 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 16 Aug
 2023 15:28:19 +0200
Message-ID: <afe7376c-a859-5305-d86d-0b23f3fc16bf@foss.st.com>
Date: Wed, 16 Aug 2023 15:28:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH] ARM: dts: stm32: fix display pinmux for
 stm32f746-disco
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: Amarula patchwork <linux-amarula@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <michael@amarulasolutions.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230703160233.2303076-1-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230703160233.2303076-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_12,2023-08-15_02,2023-05-22_02
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



On 7/3/23 18:02, Dario Binacchi wrote:
> As reported by the datasheet (DocID027590 Rev 4) for PG12:
> - AF9  -> LCD_B4
> - AF14 -> LCD_B1
> 
> So replace AF14 with AF9 for PG12 in the dts.
> 
> Fixes: fe63d3cfb77ef ("ARM: dts: stm32: Sync DT with v4.20 kernel for stm32f7")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
>  arch/arm/dts/stm32f746-disco-u-boot.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/stm32f746-disco-u-boot.dtsi b/arch/arm/dts/stm32f746-disco-u-boot.dtsi
> index 19b5451db441..522cffb1ac9f 100644
> --- a/arch/arm/dts/stm32f746-disco-u-boot.dtsi
> +++ b/arch/arm/dts/stm32f746-disco-u-boot.dtsi
> @@ -169,7 +169,7 @@
>  	ltdc_pins: ltdc@0 {
>  		pins {
>  			pinmux = <STM32_PINMUX('E', 4, AF14)>, /* B0 */
> -				 <STM32_PINMUX('G',12, AF14)>, /* B4 */
> +				 <STM32_PINMUX('G',12, AF9)>,  /* B4 */
>  				 <STM32_PINMUX('I', 9, AF14)>, /* VSYNC */
>  				 <STM32_PINMUX('I',10, AF14)>, /* HSYNC */
>  				 <STM32_PINMUX('I',14, AF14)>, /* CLK */
Applied on stm32-master

Thanks
Patrice
