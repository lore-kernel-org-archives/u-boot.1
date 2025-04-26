Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75F6C369C2
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 02:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B09A82A96;
	Sat, 26 Apr 2025 04:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZQShasTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 349A482A81; Sat, 26 Apr 2025 04:30:53 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF274828BC
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 04:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53Q2UnAI3066432
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 21:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745634649;
 bh=iMigbJ3PSVXv+AAy35nOBxMwH96Z8R0DXbKe06cNDws=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZQShasTX/BxOEZPFOFgdFp6cekxgb7maCunnaV5VW85y94autN2pFl4USp0hFzikj
 81+WxjRzmRcIdSCiy0z4YLM0+yI+ej8cfVReEv0mySnOM+jq+X+l3SwD+BNBol3w4i
 RVZPe3lAJbBFBXRmDq3gQO70N8cSzawo4ykTz8SM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53Q2UnjQ044838
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 21:30:49 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 21:30:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 21:30:48 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53Q2Ujcf034133;
 Fri, 25 Apr 2025 21:30:46 -0500
Message-ID: <334d7a69-6b84-4a0e-aeb0-f581008d3e79@ti.com>
Date: Sat, 26 Apr 2025 08:00:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] include: env: ti: mmc.h: Find DTB files in dtb
 directory for AM57xx
To: Neha Malcom Francis <n-francis@ti.com>, Anurag Dutta <a-dutta@ti.com>,
 <trini@konsulko.com>
CC: <nm@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20250425053431.1622267-1-a-dutta@ti.com>
 <20250425053431.1622267-2-a-dutta@ti.com>
 <01ad9412-f1de-4628-aa1d-9fe391872fa5@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <01ad9412-f1de-4628-aa1d-9fe391872fa5@ti.com>
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


On 4/25/2025 12:19 PM, Neha Malcom Francis wrote:
> Hi Anurag
>
> On 25/04/25 11:04, Anurag Dutta wrote:
>> Add dtb/ to the DTB search path.
>>
>> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
>> ---
>>   include/env/ti/mmc.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/env/ti/mmc.h b/include/env/ti/mmc.h
>> index dbb0e3559ea..968d6ec03dc 100644
>> --- a/include/env/ti/mmc.h
>> +++ b/include/env/ti/mmc.h
>> @@ -24,7 +24,7 @@
>>   		"env import -t ${loadaddr} ${filesize}\0" \
>>   	"loadbootenv=fatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}\0" \
>>   	"loadimage=load ${devtype} ${bootpart} ${loadaddr} ${bootdir}/${bootfile}\0" \
>> -	"loadfdt=load ${devtype} ${bootpart} ${fdtaddr} ${bootdir}/${fdtfile}\0" \
>> +	"loadfdt=load ${devtype} ${bootpart} ${fdtaddr} ${bootdir}/dtb/${fdtfile}\0" \
>>   	"envboot=mmc dev ${mmcdev}; " \
>>   		"if mmc rescan; then " \
>>   			"echo SD/MMC found on device ${mmcdev};" \
> Are there any other boards that use .h instead of .env other than AM57x?
> Would they break with this change?

Yes there are few

include/configs/am62ax_evm.h:#include <env/ti/mmc.h>
include/configs/am65x_evm.h:#include <env/ti/mmc.h>
include/configs/da850evm.h:#include <env/ti/mmc.h>
include/configs/omap3_evm.h:#include <env/ti/mmc.h>
include/configs/omapl138_lcdk.h:#include <env/ti/mmc.h>
include/configs/phycore_am335x_r2.h:#include <env/ti/mmc.h>
include/configs/ti_omap4_common.h:#include <env/ti/mmc.h>
include/configs/ti_omap5_common.h:#include <env/ti/mmc.h>

One way, I see append dtb in search path in patch 2/2 
ti_omap_am57_evm_fdt_map

>
