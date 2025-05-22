Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50579C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 09:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B0782FC8;
	Thu, 22 May 2025 11:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="oED0rE6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 892A183043; Thu, 22 May 2025 11:54:48 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30CAD82F67
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 11:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7237539014=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M8iWtO005516;
 Thu, 22 May 2025 11:54:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 eJFHq+BJdrJnp0xd0+zsTL/z+X5oREcHDumtX1as9nU=; b=oED0rE6yxidsw1Cx
 bS5kofv5VqVgIxNJVO8ZCxwJawY4gppOYGdG6i0kIT/YjDmt58PuUmson7ljIy1D
 GeS4MbWIY5afBT/tvVx4H2WxUj5eQzXXcDkhGbAkVLsgMY5tFvc25/J8RHS3cktH
 W126kFO2gZ03zTThe9tn3hn2ayGPgKELG/+EcglUMJp4jsOlu4n8I1kOtin87Kj1
 OOEeLd/NJSUJZnOVIpzv0H79L+MM+Fq/C3gCPNflKnCmt4gM+rK031Bs+f6KtQGU
 9/F0MlO72BVgxwBHfn+G0Uxq9zudVOH4NCJ6IBO3Lfpizy3Ky36mLjw7IIH+dOTZ
 g7d1Xg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46rwfc85ug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 11:54:42 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 28D5E4004D;
 Thu, 22 May 2025 11:53:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4AF67B132B9;
 Thu, 22 May 2025 11:53:40 +0200 (CEST)
Received: from [10.48.86.182] (10.48.86.182) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 11:53:39 +0200
Message-ID: <a22cb1c0-bcee-4b12-bed8-2eb7e19e0939@foss.st.com>
Date: Thu, 22 May 2025 11:53:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] watchdog: don't autostart watchdog on STM32MP boards
To: Antonio Borneo <antonio.borneo@foss.st.com>, <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marex@denx.de>
CC: <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?=
 <clement.legoffic@foss.st.com>
References: <20250521122755.265760-1-antonio.borneo@foss.st.com>
 <20250521122755.265760-5-antonio.borneo@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250521122755.265760-5-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_05,2025-05-22_01,2025-03-28_01
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

Hi,

On 5/21/25 14:27, Antonio Borneo wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
>
> The STM32MP2 boards have watchdog started by a previous boot

why only for STM32MP2...

I think it is case for STM32MP1 also.


and in the patch it is the case => default n for ARCH_STM32MP

= all STM32 MPU: STM32MP1(ARMv7) & STM32MP2(ARMv8)


> stage (e.g. bootrom or secure OS), WATCHDOG_AUTOSTART is useless.
> Prefer to rely on DT properties "u-boot,autostart" or "u-boot,noautostart"
> if needed.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> ---
>   drivers/watchdog/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 1bb67f50352..510330be8a5 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -15,6 +15,7 @@ config WATCHDOG_AUTOSTART
>   	bool "Automatically start watchdog timer"
>   	depends on WDT
>   	default n if ARCH_SUNXI
> +	default n if ARCH_STM32MP
>   	default y
>   	help
>   	  Automatically start watchdog timer and start servicing it during


With this patch you are change the behavior for ALL users of STM32MP arch...

It is OK for any boot with TF-A/OP-TEE....

so for stm32mp15_defconfig/stm32mp15_trusted_defconfig


but what append for boot with SPL on ST boards ?

stm32mp15_basic_defconfig

and what appends for  customer defconfig  with SPL ?

stm32mp15-microgea-stm32mp1-microdev2_defconfig
stm32mp15-icore-stm32mp1-ctouch2_defconfig
stm32mp15_dhcor_basic_defconfig
stm32mp15_dhcom_basic_defconfig
stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
stm32mp15-icore-stm32mp1-edimm2.2_defconfig

if you want have no impact on other boards, I think a defconfig 
modification is missing for all these defconfig without TF-A/OP-TEE support

CONFIG_WATCHDOG_AUTOSTART=y

or you are expecting STM32MP15 board device tree modification 
("u-boot,autostart") ?


Regards

Patrick


