Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285E1C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 12:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D9287E37;
	Thu,  8 Feb 2024 13:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MIz5aECX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F010187D26; Thu,  8 Feb 2024 05:51:22 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6115787D15
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 05:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4184pIvc096416;
 Wed, 7 Feb 2024 22:51:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707367878;
 bh=B0ozmv3BCCyBz5VUHNUGKsi30CgaUe/VNoFtJkLO1Uk=;
 h=Date:Subject:From:To:CC:References:In-Reply-To;
 b=MIz5aECXB0kaTr/mkGY6LBCka/c5opH8C2TCcLE7Hku37oU7ZWdx7tGBBTVjC9X8q
 XBJrMv1qgg+GFKDuHnzjFQmDWSNqO5CU/2n7X4Ul0p/2LsJ/3EftEvfnXtfsR4YU9X
 YHRCRBSbl86hIIZlmlGP+RbPUoNhFPTL77lU5PG4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4184pIal044806
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 7 Feb 2024 22:51:18 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 22:51:18 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 22:51:18 -0600
Received: from [172.24.227.241] (santhoshkumark.dhcp.ti.com [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4184pF1S094477; 
 Wed, 7 Feb 2024 22:51:16 -0600
Message-ID: <242b235c-b2bb-4d62-a909-c238caa3b4b3@ti.com>
Date: Thu, 8 Feb 2024 10:21:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] ECC Series
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>
References: <20240131060213.1128024-1-s-k6@ti.com>
In-Reply-To: <20240131060213.1128024-1-s-k6@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 08 Feb 2024 13:10:31 +0100
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



On 31/01/24 11:32, Santhosh Kumar K wrote:
> This series is to:
> 1. Enable ECC priming with BIST engine (Patch 1)
> 2. Add a function to store base address and size of RAM's banks
>     in a 64 bit device private data (Patch 2)
> 3. Setup the ECC region start and range (Patch 3)
> 4. Enable ECC 1 bit error, 2 bit error and multiple bit
>     error interrupts (Patch 4)
> 5. Add CONFIG_K3_INLINE_ECC (Patch 5)
> 6. Pull the redundant DDR functions to a common location (Patch 6)
> 7. Remove redundant DDR functions (Patch 7, 8)
> 8. Fixup DDR size when ECC is enabled (Patch 9)
> 9. Add ss_cfg reg entry (Patch 10)
> 
> Tested on AM62X and AM62A, results:
> AM62X: https://gist.github.com/santhosh21/c5f07cd921bd2b12d12385f22c698ee6
> AM62A: https://gist.github.com/santhosh21/e5fa684d890d65b4034346435213ec8b
> 
> Things to look in the test log:
> 1. Time-taken for priming
> 2. Fixed up DDR size (RAM size =- ECC reserved space).
> 
> Thanks and Regards,
> Santhosh.
> 
> Georgi Vlaev (1):
>    ram: k3-ddrss: Use the DDR controller BIST engine for ECC priming
> 
> Neha Malcom Francis (1):
>    drivers: ram: Kconfig: Add CONFIG_K3_INLINE_ECC
> 
> Santhosh Kumar K (8):
>    ram: k3-ddrss: Add k3_ddrss_ddr_bank_base_size_calc() to solve
>      'calculations restricted to 32 bits' issue
>    ram: k3-ddrss: Setup ECC region start and range
>    ram: k3-ddrss: Enable ECC interrupts
>    board: ti: common: k3-ddr-init: Pull redundant DDR functions to a
>      common location


This patch seems to break compilation on J7* platforms, I'll post a v2.
Please don't merge the series.


>    board: ti: am64x: evm: Remove redundant DDR functions
>    board: ti: am62x: evm: Remove redundant DDR functions
>    board: ti: am62ax: evm: Fixup DDR size when ECC is enabled
>    arm: dts: k3-am62a-ddr: Add ss_cfg reg entry
> 
>   arch/arm/dts/k3-am62a-ddr.dtsi  |   7 +-
>   board/ti/am62ax/evm.c           |  16 +--
>   board/ti/am62x/evm.c            |  61 +---------
>   board/ti/am64x/evm.c            |  71 +----------
>   board/ti/common/k3-ddr-init.c   |  75 ++++++++++++
>   board/ti/common/k3-ddr-init.h   |  15 +++
>   drivers/ram/Kconfig             |  11 ++
>   drivers/ram/k3-ddrss/k3-ddrss.c | 209 +++++++++++++++++++++++++++-----
>   8 files changed, 307 insertions(+), 158 deletions(-)
>   create mode 100644 board/ti/common/k3-ddr-init.c
>   create mode 100644 board/ti/common/k3-ddr-init.h
> 

Thanks and Regards,
Santhosh.
