Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD48C27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C5988245;
	Fri, 14 Jun 2024 14:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="pN+L9EXR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDE7388254; Fri, 14 Jun 2024 14:01:00 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E16BA87F8C
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6895721e93=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EBssiH009949;
 Fri, 14 Jun 2024 14:00:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 6aKROm70pNwPOCd+PDu4m+88MV2E9M3d/CXLLDYz64A=; b=pN+L9EXRUsRn0Mwk
 JX+v63haFCNS+In/c+Goav0MnZcW9C9M0RMi2AqYZ//P4dgBd23LTo2ghVeO6eqU
 bmzHpzwzOvLVqfpqYNyIKbKI5evcG1MFjNmScs30LTIKkSXA//SyhsHNlhXWrsVb
 7966GVGsssjPvbpNamYcblV8FioYgiWF9OR9lo3Y4hXQR/x0E/jyPauDdwaAibY+
 PNSIXMtIuokrfA5OuohRwFMqXCZjNIOCdKzbMmomtDhjzJi6i1QhrGVr8j4AFbnT
 cvLt1R4Oyxbgl6559iKIo4Mf2BKpmTgBxNZfxDHn7hwYagLZ1bnYYXDZ507D1kzD
 A7bXAA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypbp4gdm8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 14:00:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 786EC4002D;
 Fri, 14 Jun 2024 14:00:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AC4712132ED;
 Fri, 14 Jun 2024 14:00:12 +0200 (CEST)
Received: from [10.252.18.60] (10.252.18.60) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 14 Jun
 2024 14:00:12 +0200
Message-ID: <433560cb-8d8a-4db4-bc9b-d49a05da127b@foss.st.com>
Date: Fri, 14 Jun 2024 14:00:11 +0200
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
Applied to u-boot-stm32/next

Thanks
Patrice
