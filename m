Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8957E7735A
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 06:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87F7A86963;
	Sat, 30 Sep 2023 08:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="x9+fSEWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5D7A869B6; Sat, 30 Sep 2023 08:41:23 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FA8386568
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 08:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38U6fEZu072329;
 Sat, 30 Sep 2023 01:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696056074;
 bh=IxtLEM2pViBRw6n6fOE+3iCrmPGe4NW45da++lDVJs8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=x9+fSEWyxrmI+MQE8coCUdnnXwYJ+jN5Xi2Lv/4SBTKpT1lnsCn++2OjcoV+xSNRJ
 uyhLkub6REWinawTFn7uCulVzsie9w+SfjTA469kEQnmZA1jIkTFxK43ezc+NeKjbe
 uqeP7JBmUjK4yK3WUe5nggb2uMffIUMEJMSjUa4M=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38U6fEKZ024636
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 30 Sep 2023 01:41:14 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 30
 Sep 2023 01:41:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 30 Sep 2023 01:41:14 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38U6fBRK044124;
 Sat, 30 Sep 2023 01:41:11 -0500
Message-ID: <ab073b0d-5913-9157-e9ef-bf0f0f0f16af@ti.com>
Date: Sat, 30 Sep 2023 12:11:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 0/3] thermal: Integrate VTM and AVS driver
Content-Language: en-US
To: <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <sjg@chromium.org>
CC: <peng.fan@nxp.com>, <ye.li@nxp.com>, <robimarko@gmail.com>,
 <u-boot@lists.denx.de>, <n-francis@ti.com>
References: <20230908172914.436194-1-u-kumar1@ti.com>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230908172914.436194-1-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Dear All,

On 9/8/2023 10:59 PM, Udit Kumar wrote:
> VTM (Voltage and Thermal Manager) IP is used for following purpose
> 1) AVS class 0
> 2) Thermal management (setting thermal shutdown TSHUT) temperature.
> 3) SoC temperature reporting.
>
> In origin boot flow, R5/SPL sets the AVS voltage using
> by AVS driver, residing under UCLASS_MISC.
>
> In this series At top level, following changes are done
> - Moved avs driver to Thermal class
> - Ported kernel driver (drivers/thermal/k3_j72xx_bandgap.c) which
> supports TSHUT and temperature reporting
> - Merged these two driver as one under UCLASS_THERMAL.
>
> This series aims to
> - set avs and thermal shutdown at R5/SPL stage
> - At main u-boot stage, support thermal shutdown and temperature reporting
>
>
> Also, j72xx_bandgap does complex math to get ADC value to temperature
> conversion, This table is pretty static.
> So at R5 SPL stage, instead of calculation, fixed values is used
> for TSHUT values.
> and #ifdef is used skip non needed code for SPL/R5 to reduce code size.

Kindly review and provide feedback, if this approach looks ok.

Thanks

Udit


> Change log
> Changes in v2:
> v1 : https://lore.kernel.org/all/20230901061500.2342452-1-u-kumar1@ti.com/
> - Trying to merge AVS and kernel driver into 1
> - Mark as RFC
>
>
> Udit Kumar (3):
>    thermal: k3: Add support for thermal in vtm
>    arm: mach-k3: update board file to use thermal device
>    arm: dts: k3: update device tree for vtm node
>
>   arch/arm/dts/k3-j7200-mcu-wakeup.dtsi         |   9 +
>   .../arm/dts/k3-j7200-r5-common-proc-board.dts |   6 -
>   arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         |  10 +
>   .../arm/dts/k3-j721e-r5-common-proc-board.dts |   7 -
>   arch/arm/dts/k3-j721e-r5-sk.dts               |   7 -
>   arch/arm/mach-k3/am654_init.c                 |   2 +-
>   arch/arm/mach-k3/j721e_init.c                 |   2 +-
>   configs/am65x_evm_r5_defconfig                |   3 +
>   configs/am65x_evm_r5_usbdfu_defconfig         |   3 +
>   configs/am65x_evm_r5_usbmsc_defconfig         |   3 +
>   configs/am65x_hs_evm_r5_defconfig             |   3 +
>   configs/j7200_evm_a72_defconfig               |   3 +
>   configs/j7200_evm_r5_defconfig                |   3 +
>   configs/j721e_evm_a72_defconfig               |   3 +
>   configs/j721e_evm_r5_defconfig                |   3 +
>   drivers/misc/Makefile                         |   1 -
>   drivers/misc/k3_avs.c                         | 394 --------
>   drivers/thermal/Kconfig                       |   7 +
>   drivers/thermal/Makefile                      |   1 +
>   drivers/thermal/k3_thermal.c                  | 928 ++++++++++++++++++
>   20 files changed, 981 insertions(+), 417 deletions(-)
>   delete mode 100644 drivers/misc/k3_avs.c
>   create mode 100644 drivers/thermal/k3_thermal.c
>
