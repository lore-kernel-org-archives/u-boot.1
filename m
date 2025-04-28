Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BEAC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 13:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A42F582A53;
	Mon, 28 Apr 2025 15:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ZMWwjfaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4B5782948; Mon, 28 Apr 2025 15:24:26 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC6F582757
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7213f5eaf8=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S9MJkZ009718;
 Mon, 28 Apr 2025 15:24:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 M/BQa/7t8PrNmv7y/iQ2RiUeBsfqf7hjj//UCl22VAg=; b=ZMWwjfaV7aZNVwuV
 eOzP0LGCJitn1Lwzrt35vKq0h1rinkyHl/BB0x6MqF2M9hJ7NSF4fHY0Ezii+mHF
 EV1TAYkg/t+De9mP+Wh5+t+kTSUOjEtYCMAK4Wl0rRLxi8lPKj+2d/yG4m0a9Tvu
 6YuSBYcjwl8oKTL6x2E3pa6v9pVcWWfeoFmG73rwEQ5ZTML4U6AemtqnCUcRz5qa
 rG78RBvLVKO+3eL2tW1sBaLOlKA1EItzofoEhr4Gd+MhFU3TUHGPpULfgQlzecO0
 5UR9/8DwyjuYkY/lr/y3FjnSyHtTZh5k1aBqHbB2pDzmuHHTbdRzaDJn2xCZ0R3b
 Z7EH9w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 468pcg6qm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 15:24:23 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7EFDD40071;
 Mon, 28 Apr 2025 15:23:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 45C2EA60158;
 Mon, 28 Apr 2025 15:23:40 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 15:23:39 +0200
Message-ID: <64e7db74-c355-4110-aab9-456a470346b7@foss.st.com>
Date: Mon, 28 Apr 2025 15:23:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/22] arm: stm32mp: increase EARLY_TLB_SIZE to 0x10000
To: <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
References: <20250425131533.392747-1-patrice.chotard@foss.st.com>
 <20250425131533.392747-15-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250425131533.392747-15-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
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



On 4/25/25 15:15, Patrice Chotard wrote:
> Depending on Soc (STM32MP25 vs STM32MP21), the memory map can be
> different and it generates a different TLB page table configuration/size.
> 
> Increase EARLY_TLB_SIZE to 0x10000 to fix following error message
> and panic:
> 
> "Insufficient RAM for page table: 0xb000 > 0xa000. Please increase the
> size in get_page_table_size()"
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/mach-stm32mp/stm32mp2/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-stm32mp/stm32mp2/cpu.c b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
> index 7cb71c518bd..9548b27cfa7 100644
> --- a/arch/arm/mach-stm32mp/stm32mp2/cpu.c
> +++ b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
> @@ -24,7 +24,7 @@
>   * early TLB into the .data section so that it not get cleared
>   * with 16kB alignment
>   */
> -#define EARLY_TLB_SIZE 0xA000
> +#define EARLY_TLB_SIZE 0x10000
>  u8 early_tlb[EARLY_TLB_SIZE] __section(".data") __aligned(0x4000);
>  
>  /*
Applied to u-boot-stm32/master

Thanks
Patrice
