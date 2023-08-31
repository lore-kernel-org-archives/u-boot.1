Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CC3C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 08:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 346E08652C;
	Thu, 31 Aug 2023 10:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uTEmLbzv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 333B38656A; Thu, 31 Aug 2023 10:26:21 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10BE981FA8
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 10:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37V8QFk3109288;
 Thu, 31 Aug 2023 03:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693470375;
 bh=UeXTfMK4cDpR4uyIApV6xe3ZwuLMnTiZEsTsnjHmQ4Q=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=uTEmLbzvNh+bqKAAmdEaWVaAcIPVfF9Uli9vCpssqxMPIvNlC7RyDVmkTX/tpFTys
 y2L77QfhaC5xFctAd1cboeLfjM3etHUzABn9NcjZPgD8PYjpcFcl+bF6JP6kpHXc8i
 jo9MOmu3J5Nc9ROcYYbc9G4mkZNi33c+hmL9Tux4=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37V8QFiB113742
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 31 Aug 2023 03:26:15 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 31
 Aug 2023 03:26:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 31 Aug 2023 03:26:14 -0500
Received: from [10.24.68.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37V8QAMa078929;
 Thu, 31 Aug 2023 03:26:11 -0500
Message-ID: <36818daf-81f5-a41d-0f20-9f4cb81537d2@ti.com>
Date: Thu, 31 Aug 2023 13:56:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/4] J721E DTS Sync with Kernel v6.5-rc1
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <reidt@ti.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>,
 <gadiyar@ti.com>, <a-nandan@ti.com>, <vaishnav.a@ti.com>
References: <20230828113109.2533045-1-n-francis@ti.com>
 <20230828173316.tpzluxjvcnwmcyjj@circus>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230828173316.tpzluxjvcnwmcyjj@circus>
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

Hi Nishanth

On 28/08/23 23:03, Nishanth Menon wrote:
> On 17:01-20230828, Neha Malcom Francis wrote:
>> This series aims to sync kernel.org v6.5-rc1 DTS with that of U-Boot. It
>> also includes cleanups where necessary along with certain changes to
>> ensure boot is unaffected.
>>
>> While it's mainly synced to the tag v6.5-rc1, one extra commit has been
>> added that cleans up duplicating wkup_i2c0 nodes [1] in Kernel.
>>
>> Same as with other board series that have taken up this effort, cleanup
>> of mcu_ringacc and mcu_udmap are dependent on MCU Ringacc [2] and DMA
>> [3] fixes. This will be taken up after their merge to Linux.
>>
>> [1] https://lore.kernel.org/all/20230721082344.1534094-1-u-kumar1@ti.com/
>> [2] https://lore.kernel.org/all/20230809175932.2553156-1-vigneshr@ti.com/
>> [3] https://lore.kernel.org/all/20230810174356.3322583-1-vigneshr@ti.com/
>>
>> Boot logs:
>> https://gist.github.com/nehamalcom/231426b784e0ba96ef3a0da84346e038
>>
>> Neha Malcom Francis (4):
>>    arm: dts: k3-j721e-r5: Clean up inclusion hierarchy
>>    arm: dts: k3-j721e: Sync with v6.5-rc1
>>    drivers: misc: k3_avs: Add linux compatible to maintain sync
>>    configs: j721e: Remove HBMC_AM654 config
> please change the order of patches:
> a) introduce the driver change for vtm
> b) cleanup config and drop the hbmc node stuff
> c) rest of dts sync
> 
> NOTE:
> * J721e does'nt use SYSFW - it uses TIFS
> * for properties that dont use bootph or u-boot, properties, we
>    should'nt be including property changes in u-boot.dtsi or r5.dts
>    without explanation as to what.
> * There is a bunch of /delete-property/ plugged in for no clear reason.
>    I see that even for timer - but timer data could have been included in
>    arch/arm/mach-k3/j721e/dev-data.c and so could have been others too.
>    This needs clear explanation.
> 

All valid points, will factor these in. However regarding the timer, we have 
already tried to do the same for J721E by adding in the data in dev-data.c 
however this does not work since TIFS is in sysfw.itb which has not been loaded 
yet. Will take action to debug and root cause that further as well as try adding 
data for all the other existing /delete-property/ using nodes.

>>
>>   .../k3-j721e-common-proc-board-u-boot.dtsi    | 139 ++-
>>   arch/arm/dts/k3-j721e-common-proc-board.dts   | 483 ++++++---
>>   arch/arm/dts/k3-j721e-main.dtsi               | 974 ++++++++++++++++--
>>   arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         | 280 ++++-
>>   .../k3-j721e-r5-common-proc-board-u-boot.dtsi |  29 -
>>   .../arm/dts/k3-j721e-r5-common-proc-board.dts | 308 +-----
>>   arch/arm/dts/k3-j721e-r5-sk-u-boot.dtsi       |  31 -
>>   arch/arm/dts/k3-j721e-r5-sk.dts               | 536 +---------
>>   arch/arm/dts/k3-j721e-sk-u-boot.dtsi          | 158 +--
>>   arch/arm/dts/k3-j721e-sk.dts                  | 663 +++++++++---
>>   arch/arm/dts/k3-j721e-som-p0.dtsi             | 213 ++--
>>   arch/arm/dts/k3-j721e-thermal.dtsi            |  75 ++
>>   arch/arm/dts/k3-j721e.dtsi                    |  32 +-
>>   configs/j721e_evm_a72_defconfig               |   1 -
>>   configs/j721e_evm_r5_defconfig                |   1 -
>>   drivers/misc/k3_avs.c                         |   1 +
>>   16 files changed, 2428 insertions(+), 1496 deletions(-)
>>   delete mode 100644 arch/arm/dts/k3-j721e-r5-common-proc-board-u-boot.dtsi
>>   delete mode 100644 arch/arm/dts/k3-j721e-r5-sk-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/k3-j721e-thermal.dtsi
>>
>> -- 
>> 2.34.1
>>
> 

-- 
Thanking You
Neha Malcom Francis
