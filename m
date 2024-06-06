Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91ABAC27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 14:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B20BC881D3;
	Thu,  6 Jun 2024 16:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="8C8ZTLUT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D14F988103; Thu,  6 Jun 2024 16:50:26 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53744883AA
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6887058c03=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456DATYT021946;
 Thu, 6 Jun 2024 16:50:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 nVIqt4clDAW5vbK+GlVy7HTbOC5+GJHr7BPY1pF+Wu4=; b=8C8ZTLUTrxI8iTdM
 IIyVsgckZ4/+FoQne142tXHOmYAfHTCSJp3IXj43EM+I8l5DjjO+/w9rlUYwCc8i
 Z8LRsKuo18pfMV7UpigQhSCg9XS+P98J49KesQVREqqIoaq6+ITq7aUTupKR66OS
 CpYZzxpvcdmbkPW3x1SONDIUWqnohpWThYmG7+dCiyMcsXPYJ2tPTyYLasT4idnr
 3ZvK/nGjSCzo1uNyoIrQt+tMPjnNiR0HCOrFSkVsiR/aAWXbW1mcQ51lHt/gH3c4
 jJNtxpjC422kzir/XSU7rmmNhN2Vl4J93OXoEI3iz/wJKqz5DMpWYCx/eXmSesmR
 5lk0Cw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ykbv5108g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 16:50:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6CCCD40044;
 Thu,  6 Jun 2024 16:49:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D9E3D222CA7;
 Thu,  6 Jun 2024 16:49:20 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:49:20 +0200
Message-ID: <1c7f51a0-1114-4c69-9c53-6c49d98f7100@foss.st.com>
Date: Thu, 6 Jun 2024 16:49:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Ping IWDG on exit from PSCI suspend code
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Igor Opaniuk <igor.opaniuk@foundries.io>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240419220331.277574-1-marex@denx.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240419220331.277574-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
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



On 4/20/24 00:03, Marek Vasut wrote:
> Make sure the OS would not get any spurious IWDG pretimeout IRQ
> right after the system wakes up. This may happen in case the SoC
> got woken up by another source than the IWDG pretimeout and the
> pretimeout IRQ arrived immediately afterward, but too late to be
> handled by the suspend main loop. In case either of the IWDG is
> enabled, ping it first and then return to the OS.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Igor Opaniuk <igor.opaniuk@foundries.io>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  arch/arm/mach-stm32mp/stm32mp1/psci.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/mach-stm32mp/stm32mp1/psci.c b/arch/arm/mach-stm32mp/stm32mp1/psci.c
> index 4f2379df45f..e99103910d9 100644
> --- a/arch/arm/mach-stm32mp/stm32mp1/psci.c
> +++ b/arch/arm/mach-stm32mp/stm32mp1/psci.c
> @@ -808,6 +808,27 @@ void __secure psci_system_suspend(u32 __always_unused function_id,
>  	writel(SYSCFG_CMPENR_MPUEN, STM32_SYSCFG_BASE + SYSCFG_CMPENSETR);
>  	clrbits_le32(STM32_SYSCFG_BASE + SYSCFG_CMPCR, SYSCFG_CMPCR_SW_CTRL);
>  
> +	/*
> +	 * Make sure the OS would not get any spurious IWDG pretimeout IRQ
> +	 * right after the system wakes up. This may happen in case the SoC
> +	 * got woken up by another source than the IWDG pretimeout and the
> +	 * pretimeout IRQ arrived immediately afterward, but too late to be
> +	 * handled by the main loop above. In case either of the IWDG is
> +	 * enabled, ping it first and then return to the OS.
> +	 */
> +
> +	/* Ping IWDG1 and ACK pretimer IRQ */
> +	if (gic_enabled[4] & BIT(22)) {
> +		writel(IWDG_KR_RELOAD_KEY, STM32_IWDG1_BASE + IWDG_KR);
> +		writel(IWDG_EWCR_EWIC, STM32_IWDG1_BASE + IWDG_EWCR);
> +	}
> +
> +	/* Ping IWDG2 and ACK pretimer IRQ */
> +	if (gic_enabled[4] & BIT(23)) {
> +		writel(IWDG_KR_RELOAD_KEY, STM32_IWDG2_BASE + IWDG_KR);
> +		writel(IWDG_EWCR_EWIC, STM32_IWDG2_BASE + IWDG_EWCR);
> +	}
> +
>  	/*
>  	 * The system has resumed successfully. Rewrite LR register stored
>  	 * on stack with 'ep' value, so that on return from this PSCI call,

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
