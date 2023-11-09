Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E34C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 09:41:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 348FA871C6;
	Thu,  9 Nov 2023 10:41:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="F+yIKOSu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C55A87101; Thu,  9 Nov 2023 10:41:37 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36061871CC
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 10:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9677b570d6=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3A96lDCw015586; Thu, 9 Nov 2023 10:41:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=TorKX/HPagtPp6LJJ8PFg9xPs96o+qyjyWoh1TwJcK0=; b=F+
 yIKOSuimZKiT9XjRrUN7FOcewpkIta/EklEu5igMVUcjRc/VG3kECVyvAKA6vqkg
 7PT2bp6OoA5oHz7V2PXrX4RcqIWPEXSngkwjYNTNCCdbxWt4hmGGdmA6Qv+AArST
 Kyejfxi+CnknQ/bpq7wllfquXqENyTyKYhQ/Q+4z9qX/skT2PXoV/cDOt30weWhC
 qPhxllru7WiLfyD73Y7/IkCJhnzVf6Y9zRzVeYDC9j3ATWf/nlBUTseTHIY8/0mg
 sSe7Cg/7KIvGdApqdC0zZUtW0WtjihhDFzaBNieexpO2X5seIT1S2xGkxShl6VbK
 qFrev8Fy76q2/OMkMjog==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u7w22fru1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 10:41:31 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0CCCC10005E;
 Thu,  9 Nov 2023 10:41:28 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F1EC2208D75;
 Thu,  9 Nov 2023 10:41:27 +0100 (CET)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 9 Nov
 2023 10:41:27 +0100
Message-ID: <410e8a06-22e5-4105-b56b-079ffbe92c9e@foss.st.com>
Date: Thu, 9 Nov 2023 10:41:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] stm32mp2: initial support
Content-Language: en-US
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Bharat Gooty
 <bharat.gooty@broadcom.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Marek Vasut <marex@denx.de>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, Simon Glass <sjg@chromium.org>, Sughosh
 Ganu <sughosh.ganu@linaro.org>
References: <20231027144304.1002307-1-patrice.chotard@foss.st.com>
 <20231027144304.1002307-10-patrice.chotard@foss.st.com>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20231027144304.1002307-10-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_08,2023-11-08_01,2023-05-22_02
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

On 10/27/23 16:43, Patrice Chotard wrote:
> Add initial support for STM32MP2 SoCs family.
>
> SoCs information are available here :
> https://www.st.com/content/st_com/en/campaigns/microprocessor-stm32mp2.html
>
> Migrate all MP1 related code into stm32mp1/ directory

Minor:

MP1 => STM32MP1 series

> Create stm32mp2 directory dedicated for STM32MP2 SoCs.
>
> Common code to MP1, MP13 and MP25 is kept into


Minor

MP1 => STM32MP15

MP13 => STM32MP13

MP25 => STM32MP25


> arch/arm/mach-stm32/mach-stm32mp directory :
>    - boot_params.c
>    - bsec
>    - cmd_stm32key
>    - cmd_stm32prog
>    - dram_init.c
>    - syscon.c
>    - ecdsa_romapi.c
>
> For STM32MP2, it also :
>    - adds memory region description needed for ARMv8 MMU.
>    - enables early data cache before relocation.
>      During the transition before/after relocation, the MMU, initially setup
>      at the beginning of DDR, must be setup again at a correct address after
>      relocation. This is done in enables_caches() by disabling cache, force
>      arch.tlb_fillptr to NULL which will force the MMU to be setup again but
>      with a new value for gd->arch.tlb_addr. gd->arch.tlb_addr has been
>      updated after relocation in arm_reserve_mmu().
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/Kconfig                              |   2 +-
>   arch/arm/mach-stm32mp/Kconfig                 |  26 ++-
>   arch/arm/mach-stm32mp/Kconfig.25x             |  43 ++++
>   arch/arm/mach-stm32mp/Makefile                |  15 +-
>   arch/arm/mach-stm32mp/include/mach/stm32.h    | 141 ++++++++-----
>   .../arm/mach-stm32mp/include/mach/sys_proto.h |  26 +++
>   arch/arm/mach-stm32mp/stm32mp1/Makefile       |  20 ++
>   arch/arm/mach-stm32mp/{ => stm32mp1}/cpu.c    |   0
>   arch/arm/mach-stm32mp/{ => stm32mp1}/fdt.c    |   0
>   arch/arm/mach-stm32mp/{ => stm32mp1}/psci.c   |   0
>   .../{ => stm32mp1}/pwr_regulator.c            |   0
>   arch/arm/mach-stm32mp/{ => stm32mp1}/spl.c    |   0
>   .../mach-stm32mp/{ => stm32mp1}/stm32mp13x.c  |   0
>   .../mach-stm32mp/{ => stm32mp1}/stm32mp15x.c  |   0
>   arch/arm/mach-stm32mp/{ => stm32mp1}/tzc400.c |   0
>   arch/arm/mach-stm32mp/stm32mp2/Makefile       |   9 +
>   arch/arm/mach-stm32mp/stm32mp2/arm64-mmu.c    |  68 ++++++
>   arch/arm/mach-stm32mp/stm32mp2/cpu.c          | 108 ++++++++++
>   arch/arm/mach-stm32mp/stm32mp2/fdt.c          |  16 ++
>   arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c   | 194 ++++++++++++++++++
>   arch/arm/mach-stm32mp/syscon.c                |   4 +-
>   board/st/stm32mp2/Kconfig                     |  13 ++
>   board/st/stm32mp2/MAINTAINERS                 |   9 +
>   board/st/stm32mp2/Makefile                    |   6 +
>   board/st/stm32mp2/stm32mp2.c                  |  52 +++++
>   configs/stm32mp25_defconfig                   |  52 +++++
>   include/configs/stm32mp25_common.h            |  24 +++
>   27 files changed, 757 insertions(+), 71 deletions(-)
>   create mode 100644 arch/arm/mach-stm32mp/Kconfig.25x
>   create mode 100644 arch/arm/mach-stm32mp/stm32mp1/Makefile
>   rename arch/arm/mach-stm32mp/{ => stm32mp1}/cpu.c (100%)
>   rename arch/arm/mach-stm32mp/{ => stm32mp1}/fdt.c (100%)
>   rename arch/arm/mach-stm32mp/{ => stm32mp1}/psci.c (100%)
>   rename arch/arm/mach-stm32mp/{ => stm32mp1}/pwr_regulator.c (100%)
>   rename arch/arm/mach-stm32mp/{ => stm32mp1}/spl.c (100%)
>   rename arch/arm/mach-stm32mp/{ => stm32mp1}/stm32mp13x.c (100%)
>   rename arch/arm/mach-stm32mp/{ => stm32mp1}/stm32mp15x.c (100%)
>   rename arch/arm/mach-stm32mp/{ => stm32mp1}/tzc400.c (100%)
>   create mode 100644 arch/arm/mach-stm32mp/stm32mp2/Makefile
>   create mode 100644 arch/arm/mach-stm32mp/stm32mp2/arm64-mmu.c
>   create mode 100644 arch/arm/mach-stm32mp/stm32mp2/cpu.c
>   create mode 100644 arch/arm/mach-stm32mp/stm32mp2/fdt.c
>   create mode 100644 arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
>   create mode 100644 board/st/stm32mp2/Kconfig
>   create mode 100644 board/st/stm32mp2/MAINTAINERS
>   create mode 100644 board/st/stm32mp2/Makefile
>   create mode 100644 board/st/stm32mp2/stm32mp2.c
>   create mode 100644 configs/stm32mp25_defconfig
>   create mode 100644 include/configs/stm32mp25_common.h
>

with the minor remark on commit message


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


