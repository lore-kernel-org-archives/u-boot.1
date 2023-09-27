Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A2CE80A9A
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 07:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C0886D4D;
	Wed, 27 Sep 2023 09:11:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="RU2dzaf4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF9886D52; Wed, 27 Sep 2023 09:11:35 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F3286D4D
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 09:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=76345cf035=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38R6NEh8015600; Wed, 27 Sep 2023 09:11:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=JPgRfFEl7h2BnM4HfYGsujskYnEcgm8nL5UOjJXwtPE=; b=RU
 2dzaf4OuUVn1Rva0p/uDBkogX+WtupfgQpvzqDFDxZs3KUMQLsia64Pag2+/Hs8y
 oFh128h0SbH1rdXoxMUH973srWoTC2cCkUG+OLaRZwkUrS7+UYvIys8mVjJttPHA
 tRPyxJFDmmP2UgkVYPMt6ll3fjXipTixTjVH1sO+rsC6QFj+pa0nKfjuHE92wriq
 A+vttU47yevXo3LRNHy1SW8bEVjjRKKfJjbA44Juml4gBFLouRQqcvxMaGX2ekWp
 pofJjxhGUGQBCjeInS0MqyTNHQxrG2ZjIsRrUKETW3076pYlNIYrfxFga8Ud/PSX
 k6veObgBV5aUjNkLtBBg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ta9k0dnpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 09:11:32 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EC4E9100057;
 Wed, 27 Sep 2023 09:11:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E601C2132D7;
 Wed, 27 Sep 2023 09:11:31 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 09:11:31 +0200
Message-ID: <2ce2245d-6fee-f91c-86e3-1698a6c9c306@foss.st.com>
Date: Wed, 27 Sep 2023 09:11:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 7/7] ARM: dts: stm32: add RNG node for STM32MP13x
 platforms
Content-Language: en-US
To: Gatien Chevallier <gatien.chevallier@foss.st.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230919152759.327420-1-gatien.chevallier@foss.st.com>
 <20230919152759.327420-8-gatien.chevallier@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230919152759.327420-8-gatien.chevallier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
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



On 9/19/23 17:27, Gatien Chevallier wrote:
> Add RNG node for STM32MP13x platforms.
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> Changes in V2:
> 	- Added Patrick's tag
> 
>  arch/arm/dts/stm32mp131.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32mp131.dtsi b/arch/arm/dts/stm32mp131.dtsi
> index d23bbc3639..bd7285053d 100644
> --- a/arch/arm/dts/stm32mp131.dtsi
> +++ b/arch/arm/dts/stm32mp131.dtsi
> @@ -1208,6 +1208,14 @@
>  			};
>  		};
>  
> +		rng: rng@54004000 {
> +			compatible = "st,stm32mp13-rng";
> +			reg = <0x54004000 0x400>;
> +			clocks = <&rcc RNG1_K>;
> +			resets = <&rcc RNG1_R>;
> +			status = "disabled";
> +		};
> +
>  		mdma: dma-controller@58000000 {
>  			compatible = "st,stm32h7-mdma";
>  			reg = <0x58000000 0x1000>;
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
