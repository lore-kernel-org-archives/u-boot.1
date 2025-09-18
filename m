Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA1DCAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 13:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69B8780B9B;
	Thu, 18 Sep 2025 15:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QMSZ2F1v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C60B681E13; Thu, 18 Sep 2025 15:51:05 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19AFF8004F
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 15:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58IDox2i494573;
 Thu, 18 Sep 2025 08:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758203459;
 bh=TaW+ZIIzaiXkGM89whu3jm/56VprJpaJ//PlDtmstkE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=QMSZ2F1vLKhs+m+geAgfSFV8gpjuBGWjBYB24HUerm3kqVaKt9lINW3zctBys6VVl
 Qny+dVTKc5h2OPPzMGhDZQrATyXI35K8wA9+x/qMszDJBJsiGH7X7i0S+30qddjpXG
 1hp33n4jx51PrJUFJ/2lcYrUlbWRVKVphuGGTZ1s=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58IDox8V2151211
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 18 Sep 2025 08:50:59 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 18
 Sep 2025 08:50:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Sep 2025 08:50:59 -0500
Received: from [172.24.233.249] (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58IDotSa965912;
 Thu, 18 Sep 2025 08:50:56 -0500
Message-ID: <50a2750f-39fb-4e3d-85fb-a365792ac2b0@ti.com>
Date: Thu, 18 Sep 2025 19:20:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] Add initial support for AM62D2-EVM
To: Tom Rini <trini@konsulko.com>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>, <u-boot@lists.denx.de>, 
 <bb@ti.com>, <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>,
 <anshuld@ti.com>
References: <20250909053429.444854-1-p-bhagat@ti.com>
 <20250909220312.GD124814@bill-the-cat>
Content-Language: en-US
From: Paresh Bhagat <p-bhagat@ti.com>
In-Reply-To: <20250909220312.GD124814@bill-the-cat>
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

Hi Tom,


On 10/09/25 03:33, Tom Rini wrote:
> On Tue, Sep 09, 2025 at 11:04:24AM +0530, Paresh Bhagat wrote:
>> The AM62D2 SoC, part of the K3 architecture, is built for high-performance
>> DSP tasks in automotive audio, pro audio, radar, sonar, and medical
>> imaging. It features up to four Cortex-A53 cores (1.4GHz), two Cortex-R5F
>> cores, and a C7x DSP with 2 TOPS MMA. Key interfaces include multi-channel
>> McASP audio, TSN-capable Gigabit Ethernet, and a range of peripherals
>> (UART, SPI, I2C, CAN, USB, eMMC/SD, OSPI, CSI). It supports LPDDR4/DDR4,
>> secure boot with hardware security, and low-power modes with
>> CAN/GPIO/UART wakeup.
> [snip]
>>   arch/arm/dts/Makefile                        |    2 +
>>   arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi | 2802 ++++++++++++++++++
>>   arch/arm/dts/k3-am62d-evm-binman.dtsi        |  262 ++
>>   arch/arm/dts/k3-am62d2-evm-u-boot.dtsi       |   14 +
>>   arch/arm/dts/k3-am62d2-r5-evm.dts            |   82 +
>>   arch/arm/mach-k3/am62ax/Kconfig              |   25 +
>>   board/ti/am62dx/Kconfig                      |   26 +
>>   board/ti/am62dx/MAINTAINERS                  |    8 +
>>   board/ti/am62dx/Makefile                     |    7 +
>>   board/ti/am62dx/am62dx.env                   |   21 +
>>   board/ti/am62dx/board-cfg.yaml               |   36 +
>>   board/ti/am62dx/evm.c                        |   37 +
>>   board/ti/am62dx/pm-cfg.yaml                  |   12 +
>>   board/ti/am62dx/rm-cfg.yaml                  | 1047 +++++++
>>   board/ti/am62dx/sec-cfg.yaml                 |  379 +++
>>   board/ti/am62dx/tifs-rm-cfg.yaml             |  903 ++++++
>>   configs/am62dx_evm_a53_defconfig             |   22 +
>>   configs/am62dx_evm_r5_defconfig              |   20 +
>>   18 files changed, 5705 insertions(+)
>>   create mode 100644 arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi
>>   create mode 100644 arch/arm/dts/k3-am62d-evm-binman.dtsi
>>   create mode 100644 arch/arm/dts/k3-am62d2-evm-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/k3-am62d2-r5-evm.dts
>>   create mode 100644 board/ti/am62dx/Kconfig
>>   create mode 100644 board/ti/am62dx/MAINTAINERS
>>   create mode 100644 board/ti/am62dx/Makefile
>>   create mode 100644 board/ti/am62dx/am62dx.env
>>   create mode 100644 board/ti/am62dx/board-cfg.yaml
>>   create mode 100644 board/ti/am62dx/evm.c
>>   create mode 100644 board/ti/am62dx/pm-cfg.yaml
>>   create mode 100644 board/ti/am62dx/rm-cfg.yaml
>>   create mode 100644 board/ti/am62dx/sec-cfg.yaml
>>   create mode 100644 board/ti/am62dx/tifs-rm-cfg.yaml
>>   create mode 100644 configs/am62dx_evm_a53_defconfig
>>   create mode 100644 configs/am62dx_evm_r5_defconfig
> This isn't architecture and board, it's just a board, it should be a
> single patch. In that some of these yaml files are big, it would be good
> to figure out as a generic problem how to reduce that if possible (I
> don't know if it is).


Thanks for the review. Will take into account in the next revision.
In case of am62d, I could reuse the same yaml file as am62a. That should 
reduce the patch size at-least.
For a generic solution across boards, we need to have a right usage 
model something that will need more discussion. Same with the case of 
ddr config here.
>
