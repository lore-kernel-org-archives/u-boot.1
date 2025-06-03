Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B60AC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 13:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23AB980F9C;
	Tue,  3 Jun 2025 15:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="2EZIEKCV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32EDA81E25; Tue,  3 Jun 2025 15:28:52 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EBC38091A
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 15:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82493dba10=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553BKtnt024974;
 Tue, 3 Jun 2025 15:28:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 zPJdOmNuuzdc/T68Gn6g9G2vlEeWvIDBlnqavUeP+d0=; b=2EZIEKCVAJtop/iL
 Hlntn3oh7n0u0Fea1YPm0hkB58cjiMSRUvzVBYKq0tkYvD8oq3FBACOnv5f7K7d5
 kZpv8eqLbWfZT4mbz94K3DW6Tve22jxmGQD4AjpF3dVt9JMaLF/xYYJi45HUPpzc
 VQbUefU9QwgiMXhNPcBD0Di3VleHADKO4txrIdYuJOpjVD889OXd6rM3UPMc3q2C
 sniUbyIDa6je63mroSYed5oMQY+sJzvhpCYVbtmHjSbDC51yHNiOkHSn78wWO/UT
 h2nve6fOwuXo4RubJuiNzmkz7zl9VCn2JScX0m9aqy0g1vyHukvQ/0dIx8ASbC2F
 /uL7Rw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 471g8v47ce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 15:28:38 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8B3D64006A;
 Tue,  3 Jun 2025 15:27:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 51D17B13F6F;
 Tue,  3 Jun 2025 15:26:59 +0200 (CEST)
Received: from [10.48.86.182] (10.48.86.182) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 15:26:58 +0200
Message-ID: <ce033305-387b-4732-a711-5a4a9f4237e3@foss.st.com>
Date: Tue, 3 Jun 2025 15:26:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] ARM: stm32: Add STM32MP13xx SPL Kconfig options
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Cheick Traore <cheick.traore@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250512172149.150214-1-marek.vasut@mailbox.org>
 <20250512172149.150214-2-marek.vasut@mailbox.org>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250512172149.150214-2-marek.vasut@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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

On 5/12/25 19:21, Marek Vasut wrote:
> Introduce Kconfig options used by SPL on STM32MP13xx and isolate
> the Kconfig options only used in case TFA BL2 is used as a SPL
> behind CONFIG_TFABOOT dependency.
>
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Cheick Traore <cheick.traore@foss.st.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>
> Cc: Lionel Debieve <lionel.debieve@foss.st.com>
> Cc: Pascal Zimmermann <pzimmermann@dh-electronics.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>   arch/arm/mach-stm32mp/Kconfig     | 7 +++++--
>   arch/arm/mach-stm32mp/Kconfig.13x | 3 ++-
>   2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
> index 58250901101..3a0ca50e9d6 100644
> --- a/arch/arm/mach-stm32mp/Kconfig
> +++ b/arch/arm/mach-stm32mp/Kconfig
> @@ -40,16 +40,19 @@ choice
>   config STM32MP13X
>   	bool "Support STMicroelectronics STM32MP13x Soc"
>   	select ARCH_EARLY_INIT_R
> -	select ARM_SMCCC
> +	select ARM_SMCCC if TFABOOT
> +	select ARCH_SUPPORT_PSCI if !TFABOOT
> +	select BINMAN if !TFABOOT
>   	select CPU_V7A
>   	select CPU_V7_HAS_NONSEC
>   	select CPU_V7_HAS_VIRT
> -	select OF_BOARD
> +	select OF_BOARD if TFABOOT
>   	select OF_BOARD_SETUP
>   	select PINCTRL_STM32
>   	select STM32_RCC
>   	select STM32_RESET
>   	select STM32_SERIAL
> +	select SUPPORT_SPL if !TFABOOT
>   	select SYS_ARCH_TIMER
>   	imply CMD_NVEDIT_INFO
>   	imply OF_UPSTREAM
> diff --git a/arch/arm/mach-stm32mp/Kconfig.13x b/arch/arm/mach-stm32mp/Kconfig.13x
> index bc8b3f8cf77..cecf9e3b8c7 100644
> --- a/arch/arm/mach-stm32mp/Kconfig.13x
> +++ b/arch/arm/mach-stm32mp/Kconfig.13x
> @@ -20,7 +20,8 @@ config TARGET_ST_STM32MP13X
>   endchoice
>   
>   config TEXT_BASE
> -	default 0xC0000000
> +	default 0xC0000000 if TFABOOT
> +	default 0xC0100000 if !TFABOOT
>   
>   config PRE_CON_BUF_ADDR
>   	default 0xC0800000


I don't understood  why you modify TEXT_BASE here.

I expect to have the same base address for SPL or for TF-A boot even if 
we decide to change this address between STM32MP13 and STM32MP15.

the new address avoid potential issue on initial stack size as see on 
STM32MP15 (limited at 0x100000) and because we have no more issue with 
STM32CubeProgrammer (previously the flash-layout file was loaded by TF-A 
at 0xC0000000).

We don't change STM32MP15 just to avoid to break the compatibility...

The default memory is fully described here:

https://wiki.st.com/stm32mpu/wiki/How_to_configure_U-Boot_for_your_board#Before_relocation 


For STM32MP13 the default value are

1/ CONFIG_TEXT_BASE = 0xC0000000 (begin of DDR)

2/ CONFIG_CUSTOM_SYS_INIT_SP_ADDR = C0400000


You change the default STM32MP13 base address to keep the SAME description for you board ?

	CONFIG_SPL_LOAD_FIT=y
	CONFIG_SPL_LOAD_FIT_ADDRESS=0xc1000000

So FIT is loaded at the same address than U-Boot ?

FIT for STM32MP15 was managed with binman config in arch/arm/dts/stm32mp15xx-dhsom-u-boot.dtsi

			images {
				uboot {
					arch = "arm";
					compression = "none";
					description = "U-Boot (32-bit)";
					entry = <CONFIG_TEXT_BASE>;
					load = <CONFIG_TEXT_BASE>;
					type = "standalone";

					uboot-blob {
						filename = "u-boot-nodtb.bin";
						type = "blob-ext";
					};
				};

I don't sure it is the same for STM32MP13 after after your serie.....


Anyway I think the better solution to avoid a extra copy is to load FIT after final U-Boot location in DDR

CONFIG_SPL_LOAD_FIT_ADDRESS=0xc4000000

=> this address can be identical for STM32MP13 and STM32MP15

and to keep the the default value for CONFIG_TEXT_BASE
- 0xC0000000 for STM32MP13
- 0xC0100000 for STM32MP15

Regards

Patrick

