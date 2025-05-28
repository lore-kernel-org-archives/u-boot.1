Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA41C5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 06:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C297838D2;
	Wed, 28 May 2025 08:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="p83rQUgN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7BAA838D7; Wed, 28 May 2025 08:28:00 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A45808318E
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 08:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=8243e56e33=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S113io019785;
 Wed, 28 May 2025 08:27:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 YLI4LDSpvA2S7FT9tGVmNTXpO9El5WzFN+o9n9gnHmI=; b=p83rQUgNLxpUCpBO
 8TWQVhg4o3+Cg2s0VPRJ2P+C7fngs3s9KQ5iS98Xu/G5H3/qcwmYzHRBULfdis34
 hayOZW2L5jHmuY/h768eZpGzMnFQ9IIf/sakXmEQzGbTVKyTVyLS1dLwIJKNCXa2
 ivq880reNaUnOrq6QxtQsoMWVIH0QJJoWFvQyEbNt/xLJlYgtqK1xDP60VKKte8s
 nDblEm9zSymllgf4u4UV8Tpp7D5U19vPOpkpQ0xC2xzcGtsyS2i2pbNL8c5mZqNU
 8FHnhr5+5fPB/j5Hqk2m99AlMEmSAvqCTbbDUMw6QEDDfncOxQTfSg9kDHWEGmBC
 FDvUZg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46uqp4n97r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 May 2025 08:27:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3CE9E40056;
 Wed, 28 May 2025 08:26:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C7EBDB3B2DC;
 Wed, 28 May 2025 08:25:27 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 08:25:27 +0200
Message-ID: <91011616-abe1-41fe-8c8e-309f8710b4ac@foss.st.com>
Date: Wed, 28 May 2025 08:25:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] ARM: stm32: Add STM32MP13xx PMIC initialization for
 DDR3 DRAM type
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Cheick Traore <cheick.traore@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250512172149.150214-1-marek.vasut@mailbox.org>
 <20250512172149.150214-5-marek.vasut@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250512172149.150214-5-marek.vasut@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_03,2025-05-27_01,2025-03-28_01
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



On 5/12/25 19:21, Marek Vasut wrote:
> The STM32MP13xx PMIC initialization for DDR3 DRAM type is similar
> to the STM32MP15xx PMIC initialization, except the VTT rail is not
> enabled. Fill in the STM32MP13xx support.
> 
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
>  board/st/common/stpmic1.c | 51 ++++++++++++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 17 deletions(-)
> 
> diff --git a/board/st/common/stpmic1.c b/board/st/common/stpmic1.c
> index 45c2bb5bcea..b46f89dacb9 100644
> --- a/board/st/common/stpmic1.c
> +++ b/board/st/common/stpmic1.c
> @@ -14,8 +14,19 @@
>  #include <power/pmic.h>
>  #include <power/stpmic1.h>
>  
> +static bool is_stm32mp13xx(void)
> +{
> +	if (!IS_ENABLED(CONFIG_STM32MP13X))
> +		return false;
> +
> +	return of_machine_is_compatible("st,stm32mp131") ||
> +	       of_machine_is_compatible("st,stm32mp133") ||
> +	       of_machine_is_compatible("st,stm32mp135");
> +}
> +
>  int board_ddr_power_init(enum ddr_type ddr_type)
>  {
> +	bool is_mp13 = is_stm32mp13xx();
>  	struct udevice *dev;
>  	bool buck3_at_1800000v = false;
>  	int ret;
> @@ -30,18 +41,21 @@ int board_ddr_power_init(enum ddr_type ddr_type)
>  	switch (ddr_type) {
>  	case STM32MP_DDR3:
>  		/* VTT = Set LDO3 to sync mode */
> -		ret = pmic_reg_read(dev, STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3));
> -		if (ret < 0)
> -			return ret;
> -
> -		ret &= ~STPMIC1_LDO3_MODE;
> -		ret &= ~STPMIC1_LDO12356_VOUT_MASK;
> -		ret |= STPMIC1_LDO_VOUT(STPMIC1_LDO3_DDR_SEL);
> -
> -		ret = pmic_reg_write(dev, STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3),
> -				     ret);
> -		if (ret < 0)
> -			return ret;
> +		if (!is_mp13) {
> +			/* Enable VTT only on STM32MP15xx */
> +			ret = pmic_reg_read(dev, STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3));
> +			if (ret < 0)
> +				return ret;
> +
> +			ret &= ~STPMIC1_LDO3_MODE;
> +			ret &= ~STPMIC1_LDO12356_VOUT_MASK;
> +			ret |= STPMIC1_LDO_VOUT(STPMIC1_LDO3_DDR_SEL);
> +
> +			ret = pmic_reg_write(dev, STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3),
> +					     ret);
> +			if (ret < 0)
> +				return ret;
> +		}
>  
>  		/* VDD_DDR = Set BUCK2 to 1.35V */
>  		ret = pmic_clrsetbits(dev,
> @@ -69,11 +83,14 @@ int board_ddr_power_init(enum ddr_type ddr_type)
>  		mdelay(STPMIC1_DEFAULT_START_UP_DELAY_MS);
>  
>  		/* Enable VTT = LDO3 */
> -		ret = pmic_clrsetbits(dev,
> -				      STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3),
> -				      STPMIC1_LDO_ENA, STPMIC1_LDO_ENA);
> -		if (ret < 0)
> -			return ret;
> +		if (!is_mp13) {
> +			/* Enable VTT only on STM32MP15xx */
> +			ret = pmic_clrsetbits(dev,
> +					      STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3),
> +					      STPMIC1_LDO_ENA, STPMIC1_LDO_ENA);
> +			if (ret < 0)
> +				return ret;
> +		}
>  
>  		mdelay(STPMIC1_DEFAULT_START_UP_DELAY_MS);
>  
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
