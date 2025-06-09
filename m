Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D42C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 08:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9D3F82B18;
	Mon,  9 Jun 2025 10:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Fae71Pkl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA5582B18; Mon,  9 Jun 2025 10:57:43 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 969F382B18
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 10:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82553fdf62=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5597m2Hl007780;
 Mon, 9 Jun 2025 10:57:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 MkXMBsyLDDx9G3YZSbRn9bFGg5mtPxG6m6h4FJPYI8c=; b=Fae71PklXRHnGpFQ
 kDdI+htnUNC+mDuEejyxlc8cIl1E9/JR/ilmpdDuzhER2tIjteMCiR0Wy95/w1jF
 EWFm1VdP6RUvb+ruJ1B79LtCIDNTl780qEudKZdtXqkc3OC4ZiAHv7C4oOFh6wUP
 QmPAk+HWlVfEOArEh8m+GodYu75oUiCQr720Oqxn3ZhcnvSKY45EsipV6FsDDt0I
 V7IjKO/mWtfPJmzEjAl3kFmbo4JaQM0X8Jk/j2dlbm6EvHo8AOalCOaVFX+1lAwz
 uJYH3yh3chohe7O1ISvmZsrwJAVvc5aaG83i2Ou2/sev3j0MTI7XDvIEIyaJT0BR
 KrnNHQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474y04v5t6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 10:57:36 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8838240085;
 Mon,  9 Jun 2025 10:56:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E1890B7D314;
 Mon,  9 Jun 2025 10:55:09 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 10:55:09 +0200
Message-ID: <0963f46e-a26d-4727-a956-059ae2a8cd74@foss.st.com>
Date: Mon, 9 Jun 2025 10:55:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Auto-detect ROM API table on STM32MP15xx
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini
 <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250512164536.147793-1-marek.vasut@mailbox.org>
 <6a97edeb-692b-4959-9624-4fa4d2e6b2c9@foss.st.com>
Content-Language: en-US
In-Reply-To: <6a97edeb-692b-4959-9624-4fa4d2e6b2c9@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_03,2025-06-05_01,2025-03-28_01
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



On 5/21/25 16:40, Patrice CHOTARD wrote:
> 
> 
> On 5/12/25 18:45, Marek Vasut wrote:
>> The ROM API table location is passed to the SPL by BootROM in register r0,
>> make use of this, store the content of r0 and later use it to access the
>> ROM API table to determine current boot device.
>>
>> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
>> ---
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>  arch/arm/mach-stm32mp/stm32mp1/cpu.c        | 3 +--
>>  arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c | 3 +--
>>  2 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> index 18175fd12cc..9ab5a3ede52 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> @@ -330,8 +330,7 @@ static uintptr_t nt_fw_dtb __section(".data");
>>  void save_boot_params(unsigned long r0, unsigned long r1, unsigned long r2,
>>  		      unsigned long r3)
>>  {
>> -	if (IS_ENABLED(CONFIG_STM32_ECDSA_VERIFY))
>> -		rom_api_table = r0;
>> +	rom_api_table = r0;
>>  
>>  	if (IS_ENABLED(CONFIG_TFABOOT))
>>  		nt_fw_dtb = r2;
>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
>> index caeeeca863c..07d99034861 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
>> @@ -64,7 +64,6 @@
>>   * - boot instance = bit 31:16
>>   * - boot device = bit 15:0
>>   */
>> -#define BOOTROM_PARAM_ADDR	0x2FFC0078
>>  #define BOOTROM_MODE_MASK	GENMASK(15, 0)
>>  #define BOOTROM_MODE_SHIFT	0
>>  #define BOOTROM_INSTANCE_MASK	GENMASK(31, 16)
>> @@ -189,7 +188,7 @@ void spl_board_init(void)
>>  static void update_bootmode(void)
>>  {
>>  	u32 boot_mode;
>> -	u32 bootrom_itf = readl(BOOTROM_PARAM_ADDR);
>> +	u32 bootrom_itf = readl(get_stm32mp_rom_api_table());
>>  	u32 bootrom_device, bootrom_instance;
>>  
>>  	/* enable TAMP clock = RTCAPBEN */
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice
Applied to u-boot-stm32/next

Thanks
Patrice
