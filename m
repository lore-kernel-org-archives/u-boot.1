Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03F5C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 14:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F62182EC6;
	Wed, 21 May 2025 16:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="uBjBJL6/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D3A882E66; Wed, 21 May 2025 16:42:21 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A199982F9E
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=723653ac2b=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LDLpqc032550;
 Wed, 21 May 2025 16:42:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 ONkgdQthQ8fpMJotUI5kS4DiFr/qIe/Nef7eyiZr7I8=; b=uBjBJL6/VzvVkpVU
 FCnVU88SJoZ5c8N9ZD64wwIDhak2LNz/T/Mjo4fLYxNKcnyQ8lAiQZcmuNz+P1t5
 JdnODu2TZ5tOB6ON+cZ4CFjukqdVKSO+UsHOt5egbsr8bB0U3LPHznxB0+YMaUKm
 kj++8rBO/cASe4iFcYFROLf+Z3QIIZLFQ924zdJ83MzT/2bjmIez/gaCBByw9kur
 QVLkeXLOsk6mvMOvkWWNrwwehXTTjGCMW6t8kTKvclipOgLNVBxHvNpt+xDHYjRb
 bYixdukOi4FDzeIftBOM8BrfaluLuSGB/5alk77iRN/jz+vraVl+TIfx1/L9ylaj
 G5T49Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46rwff4q4s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 16:42:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5852D40049;
 Wed, 21 May 2025 16:41:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D15BEA187F4;
 Wed, 21 May 2025 16:40:37 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 16:40:37 +0200
Message-ID: <6a97edeb-692b-4959-9624-4fa4d2e6b2c9@foss.st.com>
Date: Wed, 21 May 2025 16:40:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Auto-detect ROM API table on STM32MP15xx
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini
 <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250512164536.147793-1-marek.vasut@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250512164536.147793-1-marek.vasut@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
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



On 5/12/25 18:45, Marek Vasut wrote:
> The ROM API table location is passed to the SPL by BootROM in register r0,
> make use of this, store the content of r0 and later use it to access the
> ROM API table to determine current boot device.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  arch/arm/mach-stm32mp/stm32mp1/cpu.c        | 3 +--
>  arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> index 18175fd12cc..9ab5a3ede52 100644
> --- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> +++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> @@ -330,8 +330,7 @@ static uintptr_t nt_fw_dtb __section(".data");
>  void save_boot_params(unsigned long r0, unsigned long r1, unsigned long r2,
>  		      unsigned long r3)
>  {
> -	if (IS_ENABLED(CONFIG_STM32_ECDSA_VERIFY))
> -		rom_api_table = r0;
> +	rom_api_table = r0;
>  
>  	if (IS_ENABLED(CONFIG_TFABOOT))
>  		nt_fw_dtb = r2;
> diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
> index caeeeca863c..07d99034861 100644
> --- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
> +++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
> @@ -64,7 +64,6 @@
>   * - boot instance = bit 31:16
>   * - boot device = bit 15:0
>   */
> -#define BOOTROM_PARAM_ADDR	0x2FFC0078
>  #define BOOTROM_MODE_MASK	GENMASK(15, 0)
>  #define BOOTROM_MODE_SHIFT	0
>  #define BOOTROM_INSTANCE_MASK	GENMASK(31, 16)
> @@ -189,7 +188,7 @@ void spl_board_init(void)
>  static void update_bootmode(void)
>  {
>  	u32 boot_mode;
> -	u32 bootrom_itf = readl(BOOTROM_PARAM_ADDR);
> +	u32 bootrom_itf = readl(get_stm32mp_rom_api_table());
>  	u32 bootrom_device, bootrom_instance;
>  
>  	/* enable TAMP clock = RTCAPBEN */

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
