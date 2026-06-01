Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A9FCD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 08:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FBDD8466E;
	Mon,  1 Jun 2026 10:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vUZwLgY5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7271C846A7; Mon,  1 Jun 2026 10:09:31 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE371840ED
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 79F90C6247E;
 Mon,  1 Jun 2026 08:09:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8F146602AB;
 Mon,  1 Jun 2026 08:09:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 270C51088805A; 
 Mon,  1 Jun 2026 10:09:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780301367; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=BCb6UcuKh5+VDcAkxY0NI/PIoDb4JubtsJC57QmTGM4=;
 b=vUZwLgY5ct7NyaoOFB5wWUJNo5+PF6FsaehiAojRqAYO8yeCXsLZuBrMxP8meVEevP+NU8
 hG917PlGMSFsd8LfCmmD8J3Gd3OZPusZAFN3HFh3e8B569eRHOXVl7DqF6BRxG5ddvXwXu
 +Yq+xegsU4JiNsccAj2RXKvltznFJzGS78q2a7dDmzpI0i4tRhE+AXepjMhR7dze1KaxN9
 cleeHbmz3Cr0+4id04/uMfNHRJlE/Le5Xp1TXNn3/aBQ4gnRbGU2mKc+vdzSwHeO7RMO6e
 A3Ckz3tT/cGKiYfTEtO4Yt6tsGjmoppsuB10oLwCm9B+HWB2uBnQD8FtbkGZag==
Message-ID: <eeb2f9a7-356d-4be9-997e-39337c28ffd1@bootlin.com>
Date: Mon, 1 Jun 2026 10:09:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH 11/20] mach-k3: r5: common: add helper
 functions needed in LPM resume sequence
To: "Kumar, Abhash" <a-kumar2@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar
 <u-kumar1@ti.com>, Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-12-richard.genoud@bootlin.com>
 <1cab46ae-e03d-4a6b-bce1-7a5c3767c000@ti.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <1cab46ae-e03d-4a6b-bce1-7a5c3767c000@ti.com>
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

Hi Abhash,
Le 01/06/2026 à 10:05, Kumar, Abhash a écrit :
> 
> On 4/30/2026 2:14 PM, Richard Genoud (TI) wrote:
>> From: Prasanth Babu Mantena <p-mantena@ ti. com> Add helper functions 
>> that are used by respective SoCs in LPM resume flow. - lpm_process() 
>> is called at boot time to: - retrieve the LPM memory region from DTS - 
>> save ATF/OPTEE certificates
>> ZjQcmQRYFpfptBannerStart
>> This message was sent from outside of Texas Instruments.
>> Do not click links or open attachments unless you recognize the source 
>> of this email and know the content is safe.
>> Report Suspicious
>> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
>> undqXRfPtm2bSgZlPFMD_PaDMAG16nyrFWtHumWcmHVJHF2x9T6ju4MVod9Xz5kkhLg8jvqD8Vb2RXV8TKm6Nx3q-RI8sEAX0Ue59g$>
>> ZjQcmQRYFpfptBannerEnd
>> From: Prasanth Babu Mantena <p-mantena@ti.com>
>>
>> Add helper functions that are used by respective SoCs in LPM resume flow.
>>
>> - lpm_process() is called at boot time to:
>>    - retrieve the LPM memory region from DTS
>>    - save ATF/OPTEE certificates information and DM code in this memory
>>      region
>>    - Forward the LPM address to TIFS via TISCI_MSG_LPM_SAVE_ADDR
>> TIFS will use this address to save TFA context and its own minimal
>> context just before suspend.
>>
>> - do_resume() is called at resume, just after bringing the DDR out of
>>    retention to:
>>    - retrieve the LPM memory region from DTS
>>    - authenticate certificates from LPM memory region and apply firewalls
>>    - ask TIFS to restore TFA and its own minimal context
>>    - start TFA on remote proc
>>    - load and jump to DM
>>
>> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/ 
>> lpm.html#lpm-msg-lpm-save-addr
>>
>> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
>> Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
>> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
>> ---
>>   arch/arm/mach-k3/common.h        |  16 +++
>>   arch/arm/mach-k3/lpm-common.h    |  15 ++
>>   arch/arm/mach-k3/r5/Kconfig      |   4 +
>>   arch/arm/mach-k3/r5/Makefile     |   1 +
>>   arch/arm/mach-k3/r5/common.c     |  17 +--
>>   arch/arm/mach-k3/r5/lpm-common.c | 228 +++++++++++++++++++++++++++++++
>>   6 files changed, 269 insertions(+), 12 deletions(-)
>>   create mode 100644 arch/arm/mach-k3/lpm-common.h
>>   create mode 100644 arch/arm/mach-k3/r5/lpm-common.c
>>
>> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
>> index e970076d08ec..50e670f845e3 100644
>> --- a/arch/arm/mach-k3/common.h
>> +++ b/arch/arm/mach-k3/common.h
>> @@ -8,6 +8,7 @@
>>   #include <asm/armv7_mpu.h>
>>   #include <asm/hardware.h>
>> +#include <image.h>
>>   #include <mach/security.h>
>> +static int extract_lpm_region(void)
>> +{
>> +    ofnode node;
>> +    fdt_addr_t lpm_reg_addr;
>> +    fdt_size_t lpm_reg_size;
>> +
>> +    node = ofnode_path("/reserved-memory/lpm-memory");
>> +    if (!ofnode_valid(node)) {
>> +        printf("lpm will not be functional\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    lpm_reg_addr = ofnode_get_addr(node);
>> +    if (lpm_reg_addr == FDT_ADDR_T_NONE) {
>> +        printf("Can't find a valid reserved node!\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    lpm_reg_size = ofnode_get_size(node);
>> +    if (lpm_reg_size == FDT_ADDR_T_NONE) {
>> +        printf("Can't find a valid reserved node!\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    mem_addr_lpm.context_save_addr = (u32 *)lpm_reg_addr;
>> +    mem_addr_lpm.atf_cert_addr = mem_addr_lpm.context_save_addr + 
>> FW_IMAGE_SIZE;
>> +    mem_addr_lpm.optee_cert_addr = mem_addr_lpm.atf_cert_addr + 
>> FW_IMAGE_SIZE;
> 
> Hi Richard,
> 
> Adding a u32 pointer to an integer "FW_IMAGE_SIZE" would scale 
> FW_IMAGE_SIZE by sizeof(u32).
> 
> This would cause the address values to come out different than intended.
Good catch, I'll fix that.

Thanks!

> 
>> +    mem_addr_lpm.dm_save_addr = mem_addr_lpm.optee_cert_addr + (2 * 
>> FW_IMAGE_SIZE);
>> +    mem_addr_lpm.size = lpm_reg_size;
>> +
>> +    return 0;
>> +}
>> +
> 
> Thanks,
> 
> Abhash
> 

