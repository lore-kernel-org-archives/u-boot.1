Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFF6CD5BB3
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 15:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32AB184859;
	Fri, 22 May 2026 17:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WP0EgXLg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 455568486D; Fri, 22 May 2026 17:57:48 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B4E5847EF
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 17:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 851584E42D1D;
 Fri, 22 May 2026 15:57:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 442CD6003C;
 Fri, 22 May 2026 15:57:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E7654108113CD; 
 Fri, 22 May 2026 17:57:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779465464; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=JLRDm14zb3UxACnSLI84fPJWYdnXKucDCJmmJBOZbOc=;
 b=WP0EgXLgM++JRpuAaL9F9+6reNd8QwuV9UxbHffL3UXfeUD6gY49PNsbdjXpcIILi4WSxn
 v8FbMNSm8rQfV0UBiAz7Jk91bKaRdgFYt+IQbTXK3+eb6DngsIkX1Z0jk0iynJN0Vh6beF
 YK1waLrtNB7190nD8IOjURKDyjEuvIHCF5yyQSUUWT9i801bFTMMFv4VQZuUfTdN8JCmXJ
 hDvll5sEfF4zs5kIhtFma3dQQNWQdKxt2qefu+vSxjpOmTln34uTmzhVwIfvVcdyWddM4/
 DCPjQRw64ztaDmk4IUo4Gm2x/tepO9lgXxeZfda7Pw6XdXDG9gZ0hHrCM2OGeQ==
Message-ID: <f2f4b451-ea28-4546-bc32-bdef0ed3353f@bootlin.com>
Date: Fri, 22 May 2026 17:57:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/20] board: ti: evm: Store wakeup reason on scratchpad
 memory
To: Andrew Davis <afd@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar
 <u-kumar1@ti.com>, Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-19-richard.genoud@bootlin.com>
 <51551426-22af-4b6d-9357-8732cf5470ad@ti.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <51551426-22af-4b6d-9357-8732cf5470ad@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Le 30/04/2026 à 19:32, Andrew Davis a écrit :
> On 4/30/26 3:44 AM, Richard Genoud (TI) wrote:
>> From: Abhash Kumar Jha <a-kumar2@ti.com>
>>
>> While resuming from suspend, the wakeup reason need to be stored
>> and this will be used by the Linux kernel once its up.
>>
>> Use the 32 bytes of MCU_PSRAM0_RAM area (addr = 0x40280000) to
>> store the wakeup reason.
>>
>> Read the value as soon as it starts and store it internally.
>>
>> Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
>> ---
>>   arch/arm/mach-k3/include/mach/j721e_hardware.h  | 1 +
>>   arch/arm/mach-k3/include/mach/j784s4_hardware.h | 1 +
>>   board/ti/common/k3-lpm.h                        | 5 +++++
>>   board/ti/j721e/evm.c                            | 9 +++++++++
>>   board/ti/j784s4/evm.c                           | 9 +++++++++
>>   5 files changed, 25 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/include/mach/j721e_hardware.h b/arch/ 
>> arm/mach-k3/include/mach/j721e_hardware.h
>> index 587dd10eb1ea..d58e2b3e1bb2 100644
>> --- a/arch/arm/mach-k3/include/mach/j721e_hardware.h
>> +++ b/arch/arm/mach-k3/include/mach/j721e_hardware.h
>> @@ -47,6 +47,7 @@
>>   /* MCU SCRATCHPAD usage */
>>   #define TI_SRAM_SCRATCH_BOARD_EEPROM_START    
>> CONFIG_SYS_K3_MCU_SCRATCHPAD_BASE
>> +#define TI_SRAM_SCRATCH_LPM_START        0x40280000
> 
> Should this be a Kconfig option?
> 
> Andrew
> 
Yes, definitely.

Thanks!


>>   #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
>> diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/ 
>> arm/mach-k3/include/mach/j784s4_hardware.h
>> index dd51473419dd..2fc81902f879 100644
>> --- a/arch/arm/mach-k3/include/mach/j784s4_hardware.h
>> +++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
>> @@ -46,6 +46,7 @@
>>   /* MCU SCRATCHPAD usage */
>>   #define TI_SRAM_SCRATCH_BOARD_EEPROM_START    
>> CONFIG_SYS_K3_MCU_SCRATCHPAD_BASE
>> +#define TI_SRAM_SCRATCH_LPM_START        0x40280000
>>   #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
>> diff --git a/board/ti/common/k3-lpm.h b/board/ti/common/k3-lpm.h
>> index a2141a0c25a8..dfd8f8486f08 100644
>> --- a/board/ti/common/k3-lpm.h
>> +++ b/board/ti/common/k3-lpm.h
>> @@ -13,5 +13,10 @@
>>   /* PMIC register where the magic value resides */
>>   #define K3_LPM_SCRATCH_PAD_REG 0xcb
>> +struct lpm_scratch_space {
>> +    u16 wake_src;
>> +    u16 reserved;
>> +} __packed;
>> +
>>   #endif /* __K3_LPM_H */
>> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
>> index 41eea1bdea95..a9f469fea1f7 100644
>> --- a/board/ti/j721e/evm.c
>> +++ b/board/ti/j721e/evm.c
>> @@ -474,6 +474,9 @@ err_free_gpio:
>>   #if (IS_ENABLED(CONFIG_SPL_BUILD) && 
>> IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM))
>> +#define LPM_WAKE_SOURCE_PMIC_GPIO 0x91
>> +#define LPM_WAKE_SOURCE_MAIN_IO   0x80
>> +
>>   static void clear_isolation(void)
>>   {
>>       int ret;
>> @@ -498,12 +501,15 @@ bool j7xx_board_is_resuming(void)
>>   {
>>       struct udevice *pmica;
>>       u32 pmctrl_val = readl(PMCTRL_IO_1);
>> +    struct lpm_scratch_space *lpm_scratch;
>>       int ret;
>>       if (gd_k3_resuming() != K3_RESUME_STATE_UNKNOWN)
>>           goto end;
>> +    lpm_scratch = (struct lpm_scratch_space *)TI_SRAM_SCRATCH_LPM_START;
>>       if ((pmctrl_val & IO_ISO_STATUS) == IO_ISO_STATUS) {
>> +        lpm_scratch->wake_src = LPM_WAKE_SOURCE_MAIN_IO;
>>           clear_isolation();
>>           gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
>>           debug("Resuming from IO_DDR mode\n");
>> @@ -520,6 +526,7 @@ bool j7xx_board_is_resuming(void)
>>       if (pmic_reg_read(pmica, K3_LPM_SCRATCH_PAD_REG) == 
>> K3_LPM_MAGIC_SUSPEND) {
>>           debug("%s: board is resuming\n", __func__);
>> +        lpm_scratch->wake_src = LPM_WAKE_SOURCE_PMIC_GPIO;
>>           gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
>>           /* clean magic suspend */
>> @@ -527,6 +534,8 @@ bool j7xx_board_is_resuming(void)
>>               printf("Failed to clean magic value for suspend 
>> detection in PMICA\n");
>>       } else {
>>           debug("%s: board is booting (no resume detected)\n", __func__);
>> +        lpm_scratch->wake_src = 0;
>> +        lpm_scratch->reserved = 0;
>>           gd_set_k3_resuming(K3_RESUME_STATE_BOOTING);
>>       }
>>   end:
>> diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
>> index eef56556a33c..b94ec7f3653b 100644
>> --- a/board/ti/j784s4/evm.c
>> +++ b/board/ti/j784s4/evm.c
>> @@ -68,6 +68,9 @@ int board_late_init(void)
>>   #if (IS_ENABLED(CONFIG_SPL_BUILD) && 
>> (IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM) || \
>>                         IS_ENABLED(CONFIG_TARGET_J742S2_R5_EVM)))
>> +#define LPM_WAKE_SOURCE_PMIC_GPIO 0x91
>> +#define LPM_WAKE_SOURCE_MCU_IO    0x81
>> +
>>   static void clear_isolation(void)
>>   {
>>       int ret;
>> @@ -93,12 +96,15 @@ bool j7xx_board_is_resuming(void)
>>   {
>>       struct udevice *pmic;
>>       u32 pmctrl_val = readl(WKUP_CTRL_MMR0_BASE + PMCTRL_IO_0);
>> +    struct lpm_scratch_space *lpm_scratch;
>>       int err;
>>       if (gd_k3_resuming() != K3_RESUME_STATE_UNKNOWN)
>>           goto end;
>> +    lpm_scratch = (struct lpm_scratch_space *)TI_SRAM_SCRATCH_LPM_START;
>>       if ((pmctrl_val & IO_ISO_STATUS) == IO_ISO_STATUS) {
>> +        lpm_scratch->wake_src = LPM_WAKE_SOURCE_MCU_IO;
>>           clear_isolation();
>>           gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
>>           debug("board is resuming from IO_DDR mode\n");
>> @@ -115,6 +121,7 @@ bool j7xx_board_is_resuming(void)
>>       if (pmic_reg_read(pmic, K3_LPM_SCRATCH_PAD_REG) == 
>> K3_LPM_MAGIC_SUSPEND) {
>>           debug("%s: board is resuming\n", __func__);
>> +        lpm_scratch->wake_src = LPM_WAKE_SOURCE_PMIC_GPIO;
>>           gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
>>           /* clean magic suspend */
>> @@ -122,6 +129,8 @@ bool j7xx_board_is_resuming(void)
>>               printf("Failed to clean magic value for suspend 
>> detection in PMIC\n");
>>       } else {
>>           debug("%s: board is booting (no resume detected)\n", __func__);
>> +        lpm_scratch->wake_src = 0;
>> +        lpm_scratch->reserved = 0;
>>           gd_set_k3_resuming(K3_RESUME_STATE_BOOTING);
>>       }
>>   end:
> 
