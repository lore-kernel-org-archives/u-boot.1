Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C758E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 18:52:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C94A1800D0;
	Wed,  8 Jan 2025 19:52:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="XNUGBawf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1A69800DF; Wed,  8 Jan 2025 19:52:52 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C108180017
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 19:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3103f025b2=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508DL6IQ031319;
 Wed, 8 Jan 2025 19:52:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 W1uCHFIUspjrfkf2xgKCWcDKzf0p04aAODniQJkvD+0=; b=XNUGBawfUIdSUMj7
 9QMp7xVFHnfTfoxHNfAn14uB+oHBlAJ8hE1Z8LswXDqvvwGnCJnmpWsFffdR6W9L
 J4otS3O7LyyljxZBbV3ZglmgTqTV4ivI76cSM/M7c52eu6c6fwp+hcvjYtwAXm7d
 qdkKlPP99ZVyfLlI/TSkWptgvlJF3YETauzUOqRSeFH7qV88KZ/sHVxW3wLDuwLe
 72IgMlz3+ao/M40xpEbJA/YHCXKLy7EmgB3X2tDBjtfL6AxRGMxwvssWxmpq3AJY
 c+DGvxRaO7Wc8oO9XKybHSMjkPLby6HntT2KfvriXsZDurRKNyv7SU8xG2WlTZPC
 sfBFXQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 441pu4t7rd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 19:52:49 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CB21F40053;
 Wed,  8 Jan 2025 19:52:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2434A2A1054;
 Wed,  8 Jan 2025 19:51:53 +0100 (CET)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 8 Jan
 2025 19:51:52 +0100
Message-ID: <773255e7-0df2-463d-b388-6dbb6bf5f61f@foss.st.com>
Date: Wed, 8 Jan 2025 19:51:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32mp13: Add support of ck_usbo_48m in
 pre-reloc stage
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20241129123325.426138-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241129123325.426138-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.126]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

On 11/29/24 13:33, Patrice Chotard wrote:
> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>
> The clock ck_usbo_48m is a clock source for RCC, so the ck_usbo_48m
> clock provided by usbphyc need to be probed when RCC clock driver is
> required, in pre-reloc stage.
>
> This patch allow to remove the following warning:
>
> clk_register: failed to get ck_usbo_48m device (parent of usbo_k)
>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/dts/stm32mp13-u-boot.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/dts/stm32mp13-u-boot.dtsi b/arch/arm/dts/stm32mp13-u-boot.dtsi
> index aa5cfc6e41d..af7edc7e2b2 100644
> --- a/arch/arm/dts/stm32mp13-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp13-u-boot.dtsi
> @@ -111,3 +111,8 @@
>   &syscfg {
>   	bootph-all;
>   };
> +
> +&usbphyc {
> +	/* stm32-usbphyc-clk = ck_usbo_48m is a source clock of RCC CCF */
> +	bootph-all;
> +};



Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

