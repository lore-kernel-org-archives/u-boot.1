Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAD1E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 14:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54AEA801B6;
	Thu, 12 Dec 2024 15:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="o3BhFNbl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DEBA801BD; Thu, 12 Dec 2024 15:38:42 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F837801A0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 15:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BCEcbOW2998938
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2024 08:38:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734014317;
 bh=zOcPppgZ4Go7rrr1gMDkcsH6uvv/uAvKWjyxtGgwuzE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=o3BhFNblX7LciC0jP6HhXR0TvL9Szw7IzyeNd+fGVzIcXyOHaXIy0YnA99ujqDNjY
 fCFEljbavcvsW+rGQwwJOVqF5esGqx6nFVqxG/yjQX+nxYpdMvlzAhp1+6yRbYo/Se
 JVfDMYASnPZKyLBTxyaz422lC+mIW0E6FPbG8NFY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BCEcbaw130413
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Dec 2024 08:38:37 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Dec 2024 08:38:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Dec 2024 08:38:36 -0600
Received: from [172.24.227.241] (santhoshkumark.dhcp.ti.com [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BCEcX6E100479; 
 Thu, 12 Dec 2024 08:38:34 -0600
Message-ID: <8e1b6379-4c82-4c08-9461-43e547e01a01@ti.com>
Date: Thu, 12 Dec 2024 20:08:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Inline ECC Series
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>, 
 <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <n-francis@ti.com>,
 <s-k6@ti.com>
References: <20241021044024.835846-1-s-k6@ti.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20241021044024.835846-1-s-k6@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi, everyone,

On 21/10/24 10:10, Santhosh Kumar K wrote:
> Hello,
> 
> This series is to:
> 
> Add support for Inline ECC in DDR for AM64X, AM62X, AM62AX, AM62PX,
> J721S2 and J784S4 devices.
> 
> (1/8) Enable ECC priming with BIST engine
> (2/8) Add a function to store base address and size of RAM's banks
>        in a 64-bit device private data
> (3/8) Setup the ECC region start and range
> (4/8) Enable ECC 1-bit error, 2-bit error and multiple-bit
>        error interrupts
> (5/8) Add CONFIG_K3_INLINE_ECC
> (6/8) Set NR_DRAM_BANKS to 2
> (7/8) Pull Redundant DDR functions to a common location and Fixup
>        DDR size when ECC is enabled
> (8/8) Add ss_cfg reg entry
> 
> Changes since v3:
> Pull redundant DDR functions to arch/arm/mach-k3/*
> 
> v3: https://lore.kernel.org/all/20240523050430.455201-1-s-k6@ti.com/
> 
> Changes since v2:
> Removed 'default n' in Kconfig as that is default setting
> 
> v2: https://lore.kernel.org/u-boot/20240510084707.1903133-1-s-k6@ti.com/
> 
> Changes since v1:
> Add support for J7* devices.
> 
> v1: https://lore.kernel.org/u-boot/20240131060213.1128024-1-s-k6@ti.com/
> 
> Test Results: https://gist.github.com/santhosh21/25937355aa2c134a64fa76480ac6a4a2

I apologize for the delayed response!

Regards,
Santhosh.

> 
> Thanks and Regards,
> Santhosh.
> 
> Georgi Vlaev (1):
>    ram: k3-ddrss: Use the DDR controller BIST engine for ECC priming
> 
> Neha Malcom Francis (2):
>    drivers: ram: Kconfig: Add CONFIG_K3_INLINE_ECC
>    configs: j7*_evm_r5_defconfig: Set NR_DRAM_BANKS to 2
> 
> Santhosh Kumar K (5):
>    ram: k3-ddrss: Add k3_ddrss_ddr_bank_base_size_calc() to solve
>      'calculations restricted to 32 bits' issue
>    ram: k3-ddrss: Setup ECC region start and range
>    ram: k3-ddrss: Enable ECC interrupts
>    board: ti: Pull redundant DDR functions to a common location and Fixup
>      DDR size when ECC is enabled
>    arm: dts: k3-*-ddr: Add ss_cfg reg entry
> 
>   arch/arm/dts/k3-am62a-ddr.dtsi         |   7 +-
>   arch/arm/dts/k3-j721s2-ddr.dtsi        |  12 +-
>   arch/arm/dts/k3-j784s4-ddr.dtsi        |  24 ++-
>   arch/arm/mach-k3/Makefile              |   2 +-
>   arch/arm/mach-k3/include/mach/k3-ddr.h |  15 ++
>   arch/arm/mach-k3/k3-ddr.c              |  88 ++++++++++
>   board/ti/am62ax/evm.c                  |  17 +-
>   board/ti/am62px/evm.c                  |  17 +-
>   board/ti/am62x/evm.c                   |  62 +------
>   board/ti/am64x/evm.c                   |  73 +--------
>   board/ti/am65x/evm.c                   |  29 +---
>   board/ti/j721e/evm.c                   |  29 +---
>   board/ti/j721s2/evm.c                  |  35 ++--
>   board/ti/j784s4/evm.c                  |  17 +-
>   configs/j7200_evm_r5_defconfig         |   1 +
>   configs/j721e_evm_r5_defconfig         |   1 +
>   configs/j721s2_evm_r5_defconfig        |   1 +
>   configs/j784s4_evm_r5_defconfig        |   1 +
>   drivers/ram/Kconfig                    |  10 ++
>   drivers/ram/k3-ddrss/k3-ddrss.c        | 214 +++++++++++++++++++++----
>   20 files changed, 387 insertions(+), 268 deletions(-)
>   create mode 100644 arch/arm/mach-k3/include/mach/k3-ddr.h
>   create mode 100644 arch/arm/mach-k3/k3-ddr.c
> 
