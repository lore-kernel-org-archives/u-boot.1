Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A925CE8D60
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 08:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BCE788B16;
	Thu, 19 Sep 2024 10:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OH2VTIK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD9F288B16; Thu, 19 Sep 2024 10:57:07 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEE8988F62
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 10:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48J8uxUh024860;
 Thu, 19 Sep 2024 03:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1726736219;
 bh=G4MqpOk2Vm8Sppyo4A+sl3aBBbKzG5SKmQHKC3ud3k4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=OH2VTIK7uMkpNXxVJoPdtL/wdC3gB/MfNvgu05n44VCF2Gzm1b+fAs0O0K+yWEemx
 VtsU7IRgZN9i2/roqKgonvLfgWs2vjy72xucvpPSsVIhPmYnPZuyyRnlf5ssyHtI1F
 TuV5MFoVQIVxX8vwKH2kKMz5erryeAAx+g6WuRWw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48J8uxZ0013275
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 19 Sep 2024 03:56:59 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Sep 2024 03:56:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Sep 2024 03:56:58 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48J8ut94039006;
 Thu, 19 Sep 2024 03:56:56 -0500
Message-ID: <38f599a8-7094-4a04-8ff6-96fc8b9d168a@ti.com>
Date: Thu, 19 Sep 2024 14:26:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] ufs: enhancements to support Qualcomm UFS
 controllers
To: <neil.armstrong@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, <bmeng.cn@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>, Bhupesh Sharma
 <bhupesh.linux@gmail.com>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
 <bff9ce50-b5a6-45d8-9969-f116d91f75dd@linaro.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <bff9ce50-b5a6-45d8-9969-f116d91f75dd@linaro.org>
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

On 18/09/24 13:36, Neil Armstrong wrote:
> Hi Marek, Manorit, Tom, Michal,
> 
> On 10/09/2024 11:20, Neil Armstrong wrote:
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
> 
> Could you run this serie on the r8a779f0_spider, j721s2_evm_a72, j721e_evm_a72,
> j7200_evm_a72, amd_versal2_virt and qemu-riscv and check for possible regressions ?
> 

For the K3 platforms (j721s2, j721e, j7200, j784s4) I have already done a sanity 
test with this series on j784s4 with no regressions seen, so should be fine.

> It seems the only user of UFS_PCI is qemu-riscv, is there other users ?
> 
> Thanks,
> Neil
> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
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
>>   drivers/ufs/ufs.c |  98 ++++++++++++++++++++--------------
>>   drivers/ufs/ufs.h | 157 +++++++++++++++++++++++++++++++++++++++++++++++-------
>>   3 files changed, 197 insertions(+), 59 deletions(-)
>> ---
>> base-commit: ca55cf8104c0dd78aae45fa66dd8400ef1b3d0ac
>> change-id: 20240910-topic-ufs-enhancements-fe8ef9ce39d8
>>
>> Best regards,
> 

-- 
Thanking You
Neha Malcom Francis
