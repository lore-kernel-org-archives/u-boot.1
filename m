Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327ACC7EE39
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 19:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EB8E82EA5;
	Sun, 29 Jun 2025 21:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mSeU9+IO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE7A282F08; Sun, 29 Jun 2025 21:11:07 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D198382E35
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 21:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bVf5V5z2rz9sb9;
 Sun, 29 Jun 2025 21:10:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751224254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLNQ8fxnonJpK20WMywOsA1Fps/EuDuuF5nqBkoLB+w=;
 b=mSeU9+IOxpvFAKB9TFk16idov8BfaHvzn40YyGlh1XT5Ge8BZhI1ZjH93rxNMRrWFQZlip
 W1C07CQBSNzZzvwT6WbJ+SHvUsT02JKRSDpQ6dP9ELTW5BagGyXYhg4ohD3b+IYgkNiY33
 SdiWeTqr3QQRpJINcQalQ/8UQqo0nCltQppzkUIC96I2mab/LzGfITuy/3Q4deOp3PuWWG
 b6eWerLHrSGSKCiRkV6ULmnMB8SDMnrd18BUbM357ScfP2+72RWHvM/4q+6NRrVNZ8Um1j
 23miKIOevHdFNBkql7NpUHxghX6zBYny4UxPs4Dl+JKg/iu/ATudyKRjm4UQ5Q==
Message-ID: <0c1ec8bd-7492-4315-bf14-7184a04bd96e@mailbox.org>
Date: Sun, 29 Jun 2025 21:10:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 03/10] ARM: stm32: Limit early cache enablement in SPL to
 STM32MP15xx
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Cc: Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20250512172149.150214-1-marek.vasut@mailbox.org>
 <20250512172149.150214-4-marek.vasut@mailbox.org>
 <2e65615b-6b87-4bc8-b349-d7ce585bc23c@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <2e65615b-6b87-4bc8-b349-d7ce585bc23c@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 64aa87aeca50d686f51
X-MBO-RS-META: nae66prbi64nhxp9f5swcbb5rpieix9o
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

On 6/3/25 3:37 PM, Patrick DELAUNAY wrote:

Hi,

>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach- 
>> stm32mp/stm32mp1/cpu.c
>> index 9ab5a3ede52..1ae82489a4b 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> @@ -28,7 +28,9 @@
>>    * early TLB into the .data section so that it not get cleared
>>    * with 16kB allignment (see TTBR0_BASE_ADDR_MASK)
>>    */
>> +#if (!IS_ENABLED(CONFIG_XPL_BUILD) || !IS_ENABLED(CONFIG_STM32MP13X))
>>   u8 early_tlb[PGTABLE_SIZE] __section(".data") __aligned(0x4000);
>> +#endif
>>   u32 get_bootmode(void)
>>   {
>> @@ -95,18 +97,19 @@ void dram_bank_mmu_setup(int bank)
>>    */
>>   static void early_enable_caches(void)
>>   {
>> +#if (!IS_ENABLED(CONFIG_XPL_BUILD) || !IS_ENABLED(CONFIG_STM32MP13X))
> 
> 
> can you replace #if, if it possible?
> 
> 
> if (!IS_ENABLED(CONFIG_XPL_BUILD) || !IS_ENABLED(CONFIG_STM32MP13X))
> 
>      return;
No, because of the "u8 early_tlb[PGTABLE_SIZE] __section(".data") 
__aligned(0x4000);" dependency which really must be compiled out using 
#if ... #endif. If the early_tlb is unreachable due to preprocessor 
macros, then early_enable_caches() cannot reference it, hence the #if 
... in it.
