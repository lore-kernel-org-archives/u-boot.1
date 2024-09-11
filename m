Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F62EDE997
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 04:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B903D89017;
	Wed, 11 Sep 2024 06:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nqRl38cz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A851A89017; Wed, 11 Sep 2024 06:19:01 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 693BD88FF9
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 06:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48B4IuxJ094728;
 Tue, 10 Sep 2024 23:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1726028336;
 bh=9LnU9MtQG1T33tugKgroRiuVdOhLn2Yd/QewwPyDu28=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=nqRl38czfui/kHVo7apBSiFnihc1muCePfOxAk53p1+/+NBQnygHKjAqq73jcPDVH
 nCpZFZCt8mjdK73srBlM/q00R7EmBqvQG2KH7mMpeWl85grzI7m/M5gnltr0x215eG
 xXC6FcdnTTL7O7I32jmm/rFos2Ng4SGK0Pp/ltGc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48B4IuCd041725
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 10 Sep 2024 23:18:56 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Sep 2024 23:18:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Sep 2024 23:18:56 -0500
Received: from [172.24.19.92] (lt5cd2489kgj.dhcp.ti.com [172.24.19.92])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48B4Iq7m127822;
 Tue, 10 Sep 2024 23:18:53 -0500
Message-ID: <47e1c2ff-c5b9-434f-bbc3-2c3f02dc6d7d@ti.com>
Date: Wed, 11 Sep 2024 09:48:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT 2/3] board: ti: j784s4: Initialize the ESM & PMIC
 ESM
To: Andrew Halaney <ahalaney@redhat.com>
CC: Tom Rini <trini@konsulko.com>, Keerthy <j-keerthy@ti.com>, Neha Malcom
 Francis <n-francis@ti.com>, Eric Chanudet <echanude@redhat.com>, Enric
 Balletbo <eballetb@redhat.com>, <j-humphreys@ti.com>, Nishanth Menon
 <nm@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20240906-j784s4-esm-enable-v1-0-b83b17d5a744@redhat.com>
 <20240906-j784s4-esm-enable-v1-2-b83b17d5a744@redhat.com>
 <2fdfcb29-f6d1-4e30-960d-f1d500fb1cf6@ti.com>
 <5xm64cbmev3egme4xx4n2mgeryn2hhs37ckoiuinveelbx433n@unhnob5wpfnx>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <5xm64cbmev3egme4xx4n2mgeryn2hhs37ckoiuinveelbx433n@unhnob5wpfnx>
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


On 9/10/2024 10:52 PM, Andrew Halaney wrote:
> On Sat, Sep 07, 2024 at 11:12:05AM GMT, Kumar, Udit wrote:
>> Hi Andrew,
>>
>> On 9/7/2024 2:54 AM, Andrew Halaney wrote:
>>> From: Keerthy <j-keerthy@ti.com>
>>>
>>> Initialize the ESM & PMIC ESM. This allows things like
>>> the watchdog to reset the board when tripped.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>> Link: https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/board/ti/j784s4/evm.c?h=ti-u-boot-2024.04&id=9d8b40958ce792808bc571d828197dbc2e7978d6
>>> [halaney: add a line to the commit message, include header]
>>> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
>>> ---
>>>    board/ti/j784s4/evm.c | 28 ++++++++++++++++++++++++++++
>>>    1 file changed, 28 insertions(+)
>>>
>>> diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
>>> index 548dbd5925d..a0ef3a44536 100644
>>> --- a/board/ti/j784s4/evm.c
>>> +++ b/board/ti/j784s4/evm.c
>>> @@ -7,6 +7,7 @@
>>>     *
>>>     */
>>> +#include <dm.h>
>>>    #include <efi_loader.h>
>>>    #include <init.h>
>>>    #include <spl.h>
>>> @@ -72,4 +73,31 @@ int board_late_init(void)
>>>    void spl_board_init(void)
>>>    {
>>> +	struct udevice *dev;
>>> +	int ret;
>>> +
>>> +	if (IS_ENABLED(CONFIG_ESM_K3)) {
>>> +		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@700000",
>>> +						&dev);
>>> +		if (ret)
>>> +			printf("MISC init for esm@700000 failed: %d\n", ret);
>>> +
>>> +		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@40800000",
>>> +						&dev);
>>> +		if (ret)
>>> +			printf("MISC init for esm@40800000 failed: %d\n", ret);
>>> +
>>> +		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@42080000",
>>> +						&dev);
>>> +		if (ret)
>>> +			printf("MISC init for esm@42080000 failed: %d\n", ret);
>>> +	}
>> Thanks for patch ,
>>
>> IMO, if one of esm is failing then we can skip other esm probe,
>>
>>> +
>>> +	if (IS_ENABLED(CONFIG_ESM_PMIC)) {
>>> +		ret = uclass_get_device_by_driver(UCLASS_MISC,
>>> +						  DM_DRIVER_GET(pmic_esm),
>>> +						  &dev);
>> Same here if esm probe is successful then only we should probe pmic_esm.
>>
>> Reason is , if any of probe is failing functionality will not work and
>>
>> there is no point to probe devices, if function is not working.
> Any preference on how this is handled? I was going to do something like:
>
> 	if (IS_ENABLED(CONFIG_ESM_K3)) {
> 		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@700000",
> 						&dev);
> 		if (ret) {
> 			printf("MISC init for esm@700000 failed: %d\n", ret);
> 			return;
> 		}


What I have in mind kind of having string array with name , as 
esm@700000, esm@40800000 and esm@42080000

if (IS_ENABLED(CONFIG_ESM_K3)) {

     for(i = 0 ; i< 2; i++) {
             ret = uclass_get_device_by_name(UCLASS_MISC, STRING[i],
					&dev);
            if(ret) {
                    printf("MISC init for %s failed: %d\n", ret, STRING[i]);
                    break;
             }
     }

}

if (IS_ENABLED(CONFIG_ESM_PMIC) && ret == 0) {
			ret = uclass_get_device_by_driver(UCLASS_MISC,
							  DM_DRIVER_GET(pmic_esm),
							  &dev);
....
}
...
....

> 		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@40800000",
> 						&dev);
> 		...
> 		if (IS_ENABLED(CONFIG_ESM_PMIC)) {
> 			ret = uclass_get_device_by_driver(UCLASS_MISC,
> 							  DM_DRIVER_GET(pmic_esm),
> 							  &dev);
> 			if (ret) {
> 				printf("ESM PMIC init failed: %d\n", ret);
> 				return;
> 			}
> 		}
> 	}
>
> but wasn't sure if a err_esm label and goto would be more in line with
> what you imagined? Let me know otherwise I'll just submit this version
> tomorrow or so.
>
> Thanks,
> Andrew
>
