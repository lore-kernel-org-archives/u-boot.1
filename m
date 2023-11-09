Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82C3C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 09:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0C848715C;
	Thu,  9 Nov 2023 10:13:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="fdPiFCUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECF9C87191; Thu,  9 Nov 2023 10:13:48 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1E888713C
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 10:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9677b570d6=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3A95ZWfD023669; Thu, 9 Nov 2023 10:13:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=PAm4xVCZjC9Ld7t+OYsa+Ml7C3v+aWL0JJc7DGK8Nl4=; b=fd
 PiFCUCueGqefmVhecrMJZ1hW6xwsBEaZC8oeRCTuf1G5x5uAubaQbpmOGLbQ26lR
 U7hP0kVkYRKKaHgoQ7Km5VwC61+TrRepEcO3WFYXlNfsq726g4gM0menR2GVgQQe
 u/tIO+bW9mlTAY+0uuvSlhRALEJB0n380FqfRU/ZdyUj0XMiE8uedyqEdO8CPmV1
 /dyWaYrco4TUJbbmot8FWLCPfbjCLVznajvbIJk0gUPN5tRkiyoP55myh6PWGvqz
 YMefoyneUT4eySX3YBUPHAFihQjL6eZgSPwM1S2upX01cCUWdAHnyRj66SQf6qJt
 gdsz8mzpHQdgKdWDEaIg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u8sdns0m9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 10:13:45 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 78A3810005E;
 Thu,  9 Nov 2023 10:13:44 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 72F37207FF0;
 Thu,  9 Nov 2023 10:13:44 +0100 (CET)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 9 Nov
 2023 10:13:43 +0100
Message-ID: <6b6b7f17-039b-4e00-8bef-984d762ad98b@foss.st.com>
Date: Thu, 9 Nov 2023 10:13:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/9] stm32mp: dram_init: Limit DDR usage under 4GB
 boundary for STM32MP
Content-Language: en-US
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231027144304.1002307-1-patrice.chotard@foss.st.com>
 <20231027144304.1002307-5-patrice.chotard@foss.st.com>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20231027144304.1002307-5-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_07,2023-11-08_01,2023-05-22_02
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

On 10/27/23 16:42, Patrice Chotard wrote:
> Limit DDR usage under 4GB boundary on STM32MP regardless of
> memory size declared in device tree.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/mach-stm32mp/dram_init.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
> index cb35ed60ca1..fb1208fc5d5 100644
> --- a/arch/arm/mach-stm32mp/dram_init.c
> +++ b/arch/arm/mach-stm32mp/dram_init.c
> @@ -52,9 +52,15 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   	if (!total_size)
>   		return gd->ram_top;
>   
> +	/*
> +	 * make sure U-Boot uses address space below 4GB boundaries even
> +	 * if the effective available memory is bigger
> +	 */
> +	gd->ram_top = clamp_val(gd->ram_top, 0, SZ_4G - 1);
> +
>   	/* found enough not-reserved memory to relocated U-Boot */
>   	lmb_init(&lmb);
> -	lmb_add(&lmb, gd->ram_base, get_effective_memsize());
> +	lmb_add(&lmb, gd->ram_base, gd->ram_top - gd->ram_base);
>   	boot_fdt_add_mem_rsv_regions(&lmb, (void *)gd->fdt_blob);
>   	/* add 8M for reserved memory for display, fdt, gd,... */
>   	size = ALIGN(SZ_8M + CONFIG_SYS_MALLOC_LEN + total_size, MMU_SECTION_SIZE),


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

