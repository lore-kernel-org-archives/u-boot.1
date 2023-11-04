Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1F6C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 14:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3537B86F32;
	Sat,  4 Nov 2023 15:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Qfx5xu0m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7166486F4A; Sat,  4 Nov 2023 15:13:42 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5583B86F02
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 15:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A4EDXxh099273;
 Sat, 4 Nov 2023 09:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699107213;
 bh=VvIaL8Ozg+MUumJYBgNItEXjluNnu3613K7W1BKABew=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Qfx5xu0m4iTM7SaICusVwAgzraTGJ25GTvmPn/IQu60N0kWBaZpKK1aPFzcDJNiAF
 z8Lm7jNcCUIEOQXoEZa3LsGA8eFQd9smJBNBYAxcsPIkMCElcQW2q83IT2RDtVu2j9
 eDE5HimVn0sOVsUfQ5GrtTFjQmehPidKDIvdVOJs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A4EDXqg117902
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 09:13:33 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 09:13:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 09:13:33 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A4EDSKb003485;
 Sat, 4 Nov 2023 09:13:28 -0500
Message-ID: <24da82c0-005d-4da2-9f74-ede3f9c13f9e@ti.com>
Date: Sat, 4 Nov 2023 19:43:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] board: ti: j721e: evm: Drop board based serdes
 initialization
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, <u-boot@lists.denx.de>,
 <u-kumar1@ti.com>
References: <20231103003805.2420005-1-nm@ti.com>
 <20231103003805.2420005-7-nm@ti.com>
 <a2fb1bc8-9bef-4e0f-9188-19dc7e7dff7e@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <a2fb1bc8-9bef-4e0f-9188-19dc7e7dff7e@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/4/2023 4:05 PM, Kumar, Udit wrote:
>
> On 11/3/2023 6:07 AM, Nishanth Menon wrote:
>> Serdes initialization should be compile flag based instead of being
>> eeprom based.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>   board/ti/j721e/evm.c | 10 ++--------
>>   1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
>> index 17640ae79665..d49993fffe39 100644
>> --- a/board/ti/j721e/evm.c
>> +++ b/board/ti/j721e/evm.c
>> @@ -359,9 +359,6 @@ void configure_serdes_torrent(void)
>>       struct phy serdes;
>>       int ret;
>>   -    if (!IS_ENABLED(CONFIG_PHY_CADENCE_TORRENT))
>> -        return;
>> -
>>       ret = uclass_get_device_by_driver(UCLASS_PHY,
>>                         DM_DRIVER_GET(torrent_phy_provider),
>>                         &dev);
>> @@ -393,9 +390,6 @@ void configure_serdes_sierra(void)
>>       int ret, count, i;
>>       int link_count = 0;
>>   -    if (!IS_ENABLED(CONFIG_PHY_CADENCE_SIERRA))
>> -        return;
>> -
>>       ret = uclass_get_device_by_driver(UCLASS_MISC,
>>                         DM_DRIVER_GET(sierra_phy_provider),
>>                         &dev);
>> @@ -477,10 +471,10 @@ int board_late_init(void)
>>               probe_daughtercards();
>>       }
>>   -    if (board_is_j7200_som())
>> +    if (IS_ENABLED(CONFIG_PHY_CADENCE_TORRENT))
>>           configure_serdes_torrent();
>>   -    if (board_is_j721e_som())
>> +    if (IS_ENABLED(CONFIG_PHY_CADENCE_SIERRA))
>>           configure_serdes_sierra();
>
> Could be merged into one if condition
>

Please ignore above comments

with that

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

>
>>       return 0;
