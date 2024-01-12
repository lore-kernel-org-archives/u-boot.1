Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234F3C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 12:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93DF78796E;
	Fri, 12 Jan 2024 13:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZoOXHaqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5656E8797B; Fri, 12 Jan 2024 13:31:36 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBA058785F
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CCVVFJ018397;
 Fri, 12 Jan 2024 06:31:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705062691;
 bh=HCCEKFP8Jph1+bVhUCMhaLZHxgAhjXizsdameSiP+yE=;
 h=Date:CC:Subject:To:References:From:In-Reply-To;
 b=ZoOXHaqvnanTKx4uJ5gEh1nWo4sv4OdQZbd1gimGna7Mq46zDsFoCExX9g3w5pD71
 Yq9e5XU3IR7KY+QQOqAZiicy5Q2MCjfPnZr3nz7uZnMUGjPk55SWvjyjQyAgO3WyJq
 xyNsRulnQgIcLnI/J3LVayoIZwmr5NNcMs8PXcDA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CCVVxe024741
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 06:31:31 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 06:31:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 06:31:31 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CCVSBi028252;
 Fri, 12 Jan 2024 06:31:28 -0600
Message-ID: <4fdc86fb-69e6-4b79-acd8-e1b0bd8c9f4b@ti.com>
Date: Fri, 12 Jan 2024 18:01:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <trini@konsulko.com>, <sjg@chromium.org>, <afd@ti.com>, <vigneshr@ti.com>, 
 <u-boot@lists.denx.de>, <dannenberg@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: Re: [PATCH 01/10] board: ti: am62x: Init DRAM size in R5/A53 SPL
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
 <20240112064759.1801600-2-s-vadapalli@ti.com>
 <20240112122623.gkrpcvcqbmrmwkho@margin>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20240112122623.gkrpcvcqbmrmwkho@margin>
Content-Type: text/plain; charset="UTF-8"
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

Hello Nishanth,

On 12/01/24 17:56, Nishanth Menon wrote:
> On 12:17-20240112, Siddharth Vadapalli wrote:
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Call dram_init_banksize() from spl_board_init() otherwise TFTP download
>> fails with error "TFTP error: trying to overwrite reserved memory..."
>> due to lmb_get_free_size() not able to find unreserved region due
>> to lack of DRAM size info. Required to support Ethernet boot on AM62x.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>  board/ti/am62x/evm.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
>> index ad93908840..35f291d83a 100644
>> --- a/board/ti/am62x/evm.c
>> +++ b/board/ti/am62x/evm.c
>> @@ -85,6 +85,9 @@ void spl_board_init(void)
>>  	if (IS_ENABLED(CONFIG_SPL_SPLASH_SCREEN) && IS_ENABLED(CONFIG_SPL_BMP))
>>  		splash_display();
>>  
>> +	if (IS_ENABLED(CONFIG_SPL_ETH))
>> +		/* Init DRAM size for R5/A53 SPL */
>> +		dram_init_banksize();
>>  }
>>  
>>  #if defined(CONFIG_K3_AM64_DDRSS)
>> -- 
>> 2.34.1
>>
> 
> Are you sure? tftp seems to work without this patch.
> 
> https://gist.github.com/nmenon/91e3282e00e38ae42e8cf640be2ab888

I noticed the error pointed out in the commit message at the A53 SPL stage when
the U-Boot Image is being fetched over TFTP without this patch, so I have
verified that this patch is necessary. The logs you have shared verify TFTP at
U-Boot, but this patch is for enabling TFTP at A53 SPL for fetching U-Boot image
via TFTP.


-- 
Regards,
Siddharth.
