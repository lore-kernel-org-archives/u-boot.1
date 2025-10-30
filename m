Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FB3CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42AC4836D1;
	Thu, 30 Oct 2025 17:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FmiAiImR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 281A2838CC; Thu, 30 Oct 2025 17:57:02 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70558334F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cy9J96bcvz9v97;
 Thu, 30 Oct 2025 17:56:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761843418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NrEeHulrPqqcygc69UxcDlUkjkSlFgR5xqKvzcLTtKc=;
 b=FmiAiImRaTMq7N2kNffHveEbbasDL4CqXdJEEkww/0b00bkB8u+yyulNac8GdUg3zzXTqL
 Du7r2Td3xFT8CE12iRd/jw6hTavoNFQhnUsco3rmtxjk3Su7Q/oTSs5YVCxHLgsVk8A/Yh
 g/2MZfJma8lqpqvnm7LUuMwgdH8hUuvXxxz7P/0ubPwe+Q3FUtH6YAnOR/JzULU7goPU2b
 UCEScv+EEElDfTqcXQ76GCWW5cq7vbWBnw8Tr9T3eABowc7jmZ2fMwri6IVRv5YrUJvMmw
 TLkuIdWke9tr7nQ4t2rpeLu4Ovw7LcAc/YSxmlL/m+WZgLU/5ECl0zV3EV9qrg==
Message-ID: <421f3c7a-9313-4a3d-bf62-ec675cc4057b@mailbox.org>
Date: Thu, 30 Oct 2025 14:56:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] firmware: scmi: Drop mmu_set_region_dcache_behaviour()
 misuse
To: Bryan Brattlof <bb@ti.com>, Anshul Dalal <anshuld@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Alice Guo <alice.guo@nxp.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>, kamlesh@ti.com,
 d-gole@ti.com
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB84593511CF2B43470CDD8ABD88FDA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <68e5af37-1511-4720-9172-751d5b788c39@mailbox.org>
 <2a3421c8-b7af-4c6e-91c5-cbd08c9f3dd5@mailbox.org>
 <DDUP3J37VKJU.3G90BDVOTBJSI@ti.com>
 <20251030123654.zp2abxrfdgex3rq2@bryanbrattlof.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251030123654.zp2abxrfdgex3rq2@bryanbrattlof.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 97kskwaeuiagyrxuiht9fudqufib65tk
X-MBO-RS-ID: e10f6f25a614bbf3edf
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

On 10/30/25 1:36 PM, Bryan Brattlof wrote:
> On October 29, 2025 thus sayeth Anshul Dalal:
>> On Tue Oct 28, 2025 at 8:46 PM IST, Marek Vasut wrote:
>>> On 10/28/25 3:37 PM, Marek Vasut wrote:
>>>> On 10/28/25 9:25 AM, Peng Fan wrote:
>>>>
>>>> Hello Peng,
>>>>
>>>>>> Subject: [PATCH] firmware: scmi: Drop
>>>>>> mmu_set_region_dcache_behaviour() misuse
>>>>>>
>>>>>> MMU region cache behavior configuration for SCMI/SMT mailboxes is
>>>>>> platform specific. Even on ARM systems, the mailbox memory may not
>>>>>> even be located in any cacheable MMU region and may instead reside
>>>>>> in some SRAM. Remove this non-generic cache behavior configuration
>>>>>> code from generic code path.
>>>>>>
>>>>>> It is unlikely that any platform is affected by this change if it did
>>>>>> configure its MMU regions correctly on start up. Platforms which might
>>>>>> be affected are i.MX94/95 and STM32MP.
>>>>>>
>>>>>
>>>>> If the memory is mapped before running SCMI stuff, it is ok.
>>>>> But if memory is dynamic mapped at run time, there might be issue.
>>>>
>>>> I wonder ... should ARM/ARM64 define CONFIG_HAVE_ARCH_IOREMAP and
>>>> implement actual ioremap() function which changes these cacheable
>>>> properties accordingly ?
>>>>
>>>>> I saw TI platforms has some changes to use dynamic mappings,
>>>>> I have not read the details, TBH.
>>>>
>>>> Can we put the TI people on CC here ?
>>>
>>> +CC Anshul
>>
>> This change shouldn't affect any current TI platforms since we don't
>> make use of SCMI on K3 devices.
>>
>> I'll CC folks working on upcoming devices in case they have any
>> thoughts.
>>
>> +CC Dhruva, Bryan, Kamlesh
> 
> It's my expectation is the shared buffer would always be in some
> internal SRAM which shouldn't need to be mapped.

I think the buffer can be in DRAM, if the DRAM controller supports some 
protected regions/filtering, but it would be susceptible to rowhammer or 
similar attacks.

> Not only does it keep
> the buffer secure on platforms that care about that but it also speeds
> up the access latencies between the different binaries.
> 
> IMHO it makes sense to rip this out and let the few architectures that
> need to do some MMU maintenance do it themselves.
It seems Alice from NXP found some breakage on MX8ULP , I have yet to 
reply to that, but maybe this is fixable on architecture/mmu table 
level, I'll reply to that email shortly.

If we have breakage here, I think we either need to consider:
- some weak function to fix up dynamically allocated areas (?)
- make ioremap() configure the cacheable properties of mapped memory

The second option is more generic obviously, but I am unsure whether 
this is the right way to go about it.
