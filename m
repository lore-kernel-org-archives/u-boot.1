Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FEBE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 14:39:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23DF3801BD;
	Thu, 12 Dec 2024 15:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YNXg6j4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7DA6801EB; Thu, 12 Dec 2024 15:39:51 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78384801A0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 15:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BCEdkdU2944787
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2024 08:39:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734014386;
 bh=5oqmTnxxl7saiBIX+mjIoM6GqCLPS6GBPRtuQ4sU19Q=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=YNXg6j4OWlQoFWvEMdOhKU1wH5pqCChsJG2JPC2SZvBQ7xuOHilVpQIosE3aAQCpV
 GuCTtg0Ovorf7zGKfxcvZ0HGs3e9G3GvPhIWDGOMiJbRLPcymoO3aZVIocMsFvlR4/
 d56nKG4MzyaZyNnkj/E85urK7f4wh7Lku0OucyN4=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BCEdkPO109936
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Dec 2024 08:39:46 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Dec 2024 08:39:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Dec 2024 08:39:45 -0600
Received: from [172.24.227.241] (santhoshkumark.dhcp.ti.com [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BCEdgr0101560; 
 Thu, 12 Dec 2024 08:39:43 -0600
Message-ID: <29426710-db50-4c69-b7ab-37c1e80eff15@ti.com>
Date: Thu, 12 Dec 2024 20:09:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] drivers: ram: Kconfig: Add CONFIG_K3_INLINE_ECC
To: Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>
CC: <trini@konsulko.com>, <m-chawdhry@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>, 
 <vigneshr@ti.com>, <u-boot@lists.denx.de>, <w.egorov@phytec.de>,
 <s-k6@ti.com>
References: <20241021044024.835846-1-s-k6@ti.com>
 <20241021044024.835846-6-s-k6@ti.com>
 <20241023144559.dtwggwlxwljpky6p@bryanbrattlof.com>
 <689bda91-9d6a-4ae4-9ccf-b2e5af6c53cd@ti.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <689bda91-9d6a-4ae4-9ccf-b2e5af6c53cd@ti.com>
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

Hi, Bryan and Neha,

On 24/10/24 09:33, Neha Malcom Francis wrote:
> Hi Bryan
> 
> On 23/10/24 20:15, Bryan Brattlof wrote:
>> On October 21, 2024 thus sayeth Santhosh Kumar K:
>>> From: Neha Malcom Francis <n-francis@ti.com>
>>>
>>> Add CONFIG_K3_INLINE_ECC so that ECC functions can be compiled into 
>>> R5 SPL
>>> only when the config has been enabled.
>>>
>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>> ---
>>>   drivers/ram/Kconfig | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
>>> index f7e357f24da7..533d0c629a64 100644
>>> --- a/drivers/ram/Kconfig
>>> +++ b/drivers/ram/Kconfig
>>> @@ -116,6 +116,16 @@ config IMXRT_SDRAM
>>>         to support external memories like sdram, psram & nand.
>>>         This driver is for the sdram memory interface with the SEMC.
>>> +config K3_INLINE_ECC
>>> +    bool "Enable TI Inline ECC support"
>>> +    depends on K3_DDRSS
>>> +    help
>>> +      Enable Inline ECC support on K3 platforms. 1/9th of the SDRAM 
>>> space
>>> +      is used for ECC storage and the rest 8/9th is available for 
>>> system
>>> +      use. Enabling ECC increases boot time as the ECC protected 
>>> regions
>>> +      need to be primed with a predefined value prior to enabling ECC
>>> +      check.
>>> +
>>
>> I agree size will always be a complaint at such an early stage of boot
>> but we're already adding the ECC configuration in the memory{} node.
>>
>> We should do one or the other but not both. It would be hard to debug
>> problems if someone added the protected{} node but not enable this
>> config
> 
> Actually I do agree with this, maybe we can get rid of the flag 
> ti,ecc-enable which is redundant. In multi-DDR systems, it was still a 
> possibility that we could use it to select the DDR we want ECC enabled 
> on, but that hasn't been tested nor does it make any sense since they'll 
> be interleaved anyways.

Yes, we can get rid of 'ti,ecc-enable' flag and use only K3_INLINE_ECC 
config for enabling ECC.

Regards,
Santhosh.

> 
