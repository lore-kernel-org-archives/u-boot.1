Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D275CFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 08:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 815F1888B2;
	Mon,  7 Oct 2024 10:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="p5rJaKJZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49B7388D7F; Mon,  7 Oct 2024 10:18:04 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FBE3884DB
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 10:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4978HtFB025467;
 Mon, 7 Oct 2024 03:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728289075;
 bh=03W+xwmwBu9f/QyyIxV0Ecc8GX82d5+8OGfYXnbPClo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=p5rJaKJZgL0z6hHj9hkxkHOlSLwXb2JhfjfnvwTVQhk8poBN6zcRvuMVPnfu4Tdpv
 3Ra5hmBqX5Nl4UF49ntmZxme9/GbpzZFU/oZSAcjvDvNhl7ISOdUrFgXRg9zvJqdHx
 NT8F2gYjqNoqDWNgeqmKT5VMUupBTxamkczqsi9E=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4978HtGW057487
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Oct 2024 03:17:55 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Oct 2024 03:17:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Oct 2024 03:17:54 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4978HptT002240;
 Mon, 7 Oct 2024 03:17:52 -0500
Message-ID: <41d7be2a-1411-4cea-949f-8e447bc83687@ti.com>
Date: Mon, 7 Oct 2024 13:47:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] ufs: enhancements to support Qualcomm UFS
 controllers
To: <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, Bhupesh Sharma
 <bhupesh.linux@gmail.com>
CC: Michal Simek <michal.simek@amd.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, <bmeng.cn@gmail.com>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
References: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
 <9a25aaeb-98c1-4f21-8789-03582b8a4431@linaro.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <9a25aaeb-98c1-4f21-8789-03582b8a4431@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Neil

On 07/10/24 13:43, Neil Armstrong wrote:
> Hi Bhupesh, Neha Malcom Francis,
> 
> On 30/09/2024 14:44, Neil Armstrong wrote:
>> This serie regroups all the fixes and base enhancements required to
>> support the Qualcomm UFS controllers in U-Boot.
>>
>> This syncs headers & defines from Linux, and includes 2 set of
>> fixes that were sent separately:
>> - ufs: core: remove link_startup_again logic
>> - ufs: properly fix cache operations
>>
>> Without those 2 sets, UFS cannot initialize on Qualcomm controlers
>> since v5, and a numerous of Cache issues makes any UFS controller
>> fail to initialize.
>>
>> Since UFS core hasn't changed for a while, and since UFS is core
>> technology for the Qualcomm SoCs, I volunteer maintaininig the
>> UFS subsystem if Bhupesh & Neha Malcom Francis are ok with that.
>>
>> It has been reported to show regressions on:

Both of the links are saying that there are "no regressions" seen.

>> - TI K3 platforms (j721s2, j721e, j7200, j784s4) [1]
>> - AMD platform (amd_versal2_virt_defconfig) [2]
>>
>> [1] https://lore.kernel.org/all/38f599a8-7094-4a04-8ff6-96fc8b9d168a@ti.com/
>> [2] 
>> https://lore.kernel.org/all/SA1PR12MB869713CA620F99077B75EF0E98632@SA1PR12MB8697.namprd12.prod.outlook.com/
> 
> Is it ok for me to apply the patches ?
> 
> Thanks,
> Neil
> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Changes in v3:
>> - Fixup patch 9
>> - Link to v2: 
>> https://lore.kernel.org/r/20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org
>>
>> Changes in v2:
>> - Added review and tested-by tags
>> - Updated patch 12 message with more explanations
>> - Synced patch 9 again with Linux 6.11
>> - Updated patches 7, 8, 9 and 10 with informations about the origins of the 
>> changes
>> - Link to v1: 
>> https://lore.kernel.org/r/20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org
>>
>> ---
>> Bhupesh Sharma (5):
>>        ufs/ufs.h: Add definition of 'ufshcd_rmwl()'
>>        ufs: Clear UECPA once due to LINERESET has happened during LINK_STARTUP
>>        ufs: Sync possible UFS Quirks with Linux UFS driver
>>        ufs: Add missing memory barriers
>>        ufs: Fix debug message in 'ufs_start'
>>
>> Marek Vasut (2):
>>        ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
>>        ufs: Add UFSHCD_QUIRK_HIBERN_FASTAUTO
>>
>> Neil Armstrong (6):
>>        ufs: allocate descriptors with size aligned with DMA_MINALIGN
>>        ufs: fix dcache flush and invalidate range calculation
>>        ufs: split flush and invalidate to only invalidate when required
>>        ufs: use dcache helpers for scsi_cmd data and only invalidate if necessary
>>        ufs: core: remove link_startup_again logic
>>        MAINTAINERS: Add myself to the list of UFS maintainers
>>
>>   MAINTAINERS       |   1 +
>>   drivers/ufs/ufs.c |  98 +++++++++++++++-----------
>>   drivers/ufs/ufs.h | 203 ++++++++++++++++++++++++++++++++++++++++++++++++------
>>   3 files changed, 241 insertions(+), 61 deletions(-)
>> ---
>> base-commit: ddbcafeb53e7093c58488596bfce6d8823777c3a
>> change-id: 20240910-topic-ufs-enhancements-fe8ef9ce39d8
>>
>> Best regards,
> 

-- 
Thanking You
Neha Malcom Francis
