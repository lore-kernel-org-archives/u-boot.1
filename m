Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7380EC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 18:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F093B8868F;
	Thu, 18 Apr 2024 20:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="uuX1wKOk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DCE88868F; Thu, 18 Apr 2024 20:25:25 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD00884E8
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 20:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=48388125ca=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43IEJ9Hw009597; Thu, 18 Apr 2024 20:25:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=Y6X4pmEDPc7AN1EHTrZPAekapSYOQ7j1ZzEVRKAV8HY=; b=uu
 X1wKOkc+SBRvVN2xLsQCXww0MMZY/RrUqh5WM4CbZ2hOWZDk9ZNweHa+nWOzJRq0
 MqkpsYJeG54z5CVgcX2A96mxQzd33cKuIiW1pZ4iZH487tXg1c/X23ZeSqaqFFrr
 lFp3cwKLCd2Y0uG879YhLXW5KuZybrHQalFcRintKQCRqHhePjf+cQqR7gffV1D5
 XA7vFhHXI9VtsZaPrEJMLmjQayUjT79dHBCMVpxq82D6+lAKzoBNfTgSQ+gl4A8N
 psrfWISmk9m6eDgj72In2uC4Gwdl8wYPw3KnYosAYPKpyOupyIfkJlBPqf+2raVl
 GhtBnPWQsnuAD+yG1QnQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xff64rckg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Apr 2024 20:25:08 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 58F3640044;
 Thu, 18 Apr 2024 20:25:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4FCF2229A81;
 Thu, 18 Apr 2024 20:24:34 +0200 (CEST)
Received: from [10.48.86.112] (10.48.86.112) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 20:24:33 +0200
Message-ID: <f4d25293-e9c6-45de-a0d9-643252e2a0b6@foss.st.com>
Date: Thu, 18 Apr 2024 20:24:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: stm32: Initialize TAMP_SMCR BKP..PROT fields on
 STM32MP15xx
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Igor Opaniuk <igor.opaniuk@foundries.io>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240415125541.6547-1-marex@denx.de>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20240415125541.6547-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.112]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_16,2024-04-17_01,2023-05-22_02
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

On 4/15/24 14:55, Marek Vasut wrote:
> In case of an OTP-CLOSED STM32MP15xx system, the CPU core 1 cannot be
> released from endless loop in BootROM only by populating TAMP BKPxR 4
> and 5 with magic and branch address and sending SGI0 interrupt from
> core 0 to core 1 twice. TAMP_SMCR BKP..PROT fields must be initialized
> as well to release the core 1 from endless loop during the second SGI0
> handling on core 1. Initialize TAMP_SMCR to protect the first 16 backup
> registers, the ones which contain the core 1 magic, branch address and
> boot information.
>
> This requirement seems to be undocumented, therefore it was necessary
> to trace and analyze the STM32MP15xx BootROM using OpenOCD and objdump.
> Ultimately, it turns out that a certain BootROM function reads out the
> TAMP_SMCR register and tests whether the BKP..PROT fields are non-zero.
> If they are zero, the BootROM code again waits for SGI0 using WFI, else
> the execution moves forward until it reaches handoff to the TAMP BKPxR 5
> branch address.


These backup registers are documented in

https://wiki.st.com/stm32mpu/wiki/STM32MP15_backup_registers


This "security" configuration is done in STMicoelectronics delivery

(OpenSTLinux) in OP-TEE.


>
> This fixes CPU core 1 release using U-Boot PSCI implementation on an
> OTP-CLOSED system, i.e. system with fuse 0 bit 6 set.


A ROM code  security check is done only for closed device to avoid malicious

code execution: "unsecure" code on CPU2 during wake-up by changing

BRANCH_ADDRESS

=> the STM32MP15 ROM check that only the secure world can update

       the TAMP_BKP5R = BRANCH_ADDRESS

       before to start the CPU2 and jump to this address.


Sorry to inconvenient, we will improve this part on next release

= OpenSTLinux V5.1


> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>
> Thanks
> Patrick
>
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Igor Opaniuk <igor.opaniuk@foundries.io>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
> V2: Fix up the BKPRWD/BKPWD mask typo
> ---
>   arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
> index dd99150fbc2..a2496361e01 100644
> --- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
> +++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
> @@ -14,6 +14,7 @@
>   #include <asm/arch/sys_proto.h>
>   #include <dm/device.h>
>   #include <dm/uclass.h>
> +#include <linux/bitfield.h>
>   
>   /* RCC register */
>   #define RCC_TZCR		(STM32_RCC_BASE + 0x00)
> @@ -41,6 +42,9 @@
>   #define TZC_REGION_ID_ACCESS0	(STM32_TZC_BASE + 0x114)
>   
>   #define TAMP_CR1		(STM32_TAMP_BASE + 0x00)
> +#define TAMP_SMCR		(STM32_TAMP_BASE + 0x20)
> +#define TAMP_SMCR_BKPRWDPROT	GENMASK(7, 0)
> +#define TAMP_SMCR_BKPWDPROT	GENMASK(23, 16)
>   
>   #define PWR_CR1			(STM32_PWR_BASE + 0x00)
>   #define PWR_MCUCR		(STM32_PWR_BASE + 0x14)
> @@ -136,6 +140,18 @@ static void security_init(void)
>   	 */
>   	writel(0x0, TAMP_CR1);
>   
> +	/*
> +	 * TAMP: Configure non-zero secure protection settings. This is
> +	 * checked by BootROM function 35ac on OTP-CLOSED device during
> +	 * CPU core 1 release from endless loop. If secure protection
> +	 * fields are zero, the core 1 is not released from endless
> +	 * loop on second SGI0.
> +	 */
> +	clrsetbits_le32(TAMP_SMCR,
> +			TAMP_SMCR_BKPRWDPROT | TAMP_SMCR_BKPWDPROT,
> +			FIELD_PREP(TAMP_SMCR_BKPRWDPROT, 0x10) |
> +			FIELD_PREP(TAMP_SMCR_BKPWDPROT, 0x10));
> +
>   	/* GPIOZ: deactivate the security */
>   	writel(BIT(0), RCC_MP_AHB5ENSETR);
>   	writel(0x0, GPIOZ_SECCFGR);


The recommended mapping (the mapping done in OP-TEE for OpenSTLinux) is 
described in Wiki page

- 10 backup register secure

- 4  backup register secure write / non secure read

- 17 backup register Non-secure

It is done in

https://github.com/STMicroelectronics/optee_os/blob/3.19.0-stm32mp/core/arch/arm/plat-stm32mp1/main.c

with


static TEE_Result stm32_configure_tamp(void)
{
     TEE_Result res __maybe_unused = TEE_SUCCESS;
     struct stm32_bkpregs_conf bkpregs_conf = {
         .nb_zone1_regs = 10, /* 10 registers in zone 1 */
         .nb_zone2_regs = 5   /* 5 registers in zone 2 */
                      /* Zone3 all remaining */
     };

     /* Enable BKP Register protection */
     if (stm32_tamp_set_secure_bkpregs(&bkpregs_conf))
         panic();


But when you are booting with SPL U-boot, all the boot chain and the 
Linux kernel

is running in secure world


So you have no reason to manage any limit for the access to backup 
register,

you can allocate all the backup registers (the 32 one) to secure world

See "Figure 552. Backup registers secure protections" in reference mnauel

Protection zone 1 => x = 31 with  BKPRWDPROT = 31

Protection zone 2 & 3 => empty

+	clrsetbits_le32(TAMP_SMCR,
+			TAMP_SMCR_BKPRWDPROT | TAMP_SMCR_BKPWDPROT,
+			FIELD_PREP(TAMP_SMCR_BKPRWDPROT, 0x20) |
+			FIELD_PREP(TAMP_SMCR_BKPWDPROT, 0x20));


Sorry for the delay, I need also to check on my side


But anyway your proposal is functional,

So with or without the previous remark


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


