Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2D6EC8747
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 02:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03729869D7;
	Fri,  8 Sep 2023 04:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UE3WOif5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3950E86A76; Fri,  8 Sep 2023 04:57:42 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9488869D6
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 04:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3882vY3j093471;
 Thu, 7 Sep 2023 21:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694141854;
 bh=CAU1oGlHytN94SsOAXGWIshx+OzeLBq2A1G7K62yP1E=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=UE3WOif5QnOm8DGenPkEmYwAYvnkVfgyL0FeNkykpzduSNlUJgaoNX8LulbBE/xP4
 hna7/NYkoJCT/fDbW3LrF0EgBsdBXbl5sosI0iL5xMYm1Z4IjblS+lAsR+Y7fmmnLI
 2TdPAHAKF/M5O8ZmoR0k0BSQRA/+dy5Ws1uE3wyA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3882vYiA024558
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Sep 2023 21:57:34 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 21:57:33 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 21:57:33 -0500
Received: from [10.24.68.114] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3882vT1e030773;
 Thu, 7 Sep 2023 21:57:29 -0500
Message-ID: <46603619-dbf5-cc07-6834-6e6bed561602@ti.com>
Date: Fri, 8 Sep 2023 08:27:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/7] drivers: misc: k3_avs: Add linux compatible to
 maintain sync
To: reidt <reidt@ti.com>, Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <m-chawdhry@ti.com>,
 <afd@ti.com>, <sinthu.raja@ti.com>, <gadiyar@ti.com>,
 <a-nandan@ti.com>, <vaishnav.a@ti.com>
References: <20230907141407.382215-1-n-francis@ti.com>
 <20230907141407.382215-2-n-francis@ti.com>
 <20230907150858.3l6q2yxyfgdx3jvn@mulled>
 <20230907180954.h6zxgoiif6z73nq6@reidt-HP-Z2>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230907180954.h6zxgoiif6z73nq6@reidt-HP-Z2>
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

Hi Reid

On 07/09/23 23:39, reidt wrote:
> On 10:08-20230907, Nishanth Menon wrote:
>> On 19:44-20230907, Neha Malcom Francis wrote:
>>> The U-Boot AVS driver works on the VTM (Voltage and Thermal Management)
>>> module, also used by the Linux TI Bandgap temperature sensor driver
>>> (drivers/thermal/k3_j72xx_bandgap.c). Although the purpose and
>>> functionalities that these two implement are different, the hardware is
>>> the same, so ensure that their compatibles are in sync. Thus, add
>>> ti,j721e-vtm compatible to the AVS driver.
>>>
>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>> ---
>>>   drivers/misc/k3_avs.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
>>> index 840148d090..3008cf9810 100644
>>> --- a/drivers/misc/k3_avs.c
>>> +++ b/drivers/misc/k3_avs.c
>>> @@ -382,6 +382,7 @@ static struct vd_config am654_vd_config = {
>>>   static const struct udevice_id k3_avs_ids[] = {
>>>   	{ .compatible = "ti,am654-avs", .data = (ulong)&am654_vd_config },
>>>   	{ .compatible = "ti,j721e-avs", .data = (ulong)&j721e_vd_config },
>>> +	{ .compatible = "ti,j721e-vtm", .data = (ulong)&j721e_vd_config },
>>>   	{}
>>>   };
>>>   
>>> -- 
>>> 2.34.1
>>>
>> https://lore.kernel.org/all/52a7c0b2-7a87-c74e-e63f-d07821ffc1f8@ti.com/
>>
>> we are going to end up creating a dependency nightmare.
>>
>> Can we just do a single series(might be just a single patch) for
>> compatible additions for k3_avs.c and make the dts syncs dependent on this?
>>
> 
> I submitted one here if this works:
> https://lore.kernel.org/u-boot/20230907180635.89011-1-reidt@ti.com/T/#u
> 
> -Reid
> 

Thanks for sending the patch! I'll omit this patch from the next version.

>> -- 
>> Regards,
>> Nishanth Menon
>> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

-- 
Thanking You
Neha Malcom Francis
