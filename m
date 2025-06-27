Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6488C7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 18:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18360806D8;
	Fri, 27 Jun 2025 20:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RgzO4IoL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E90BA80C83; Fri, 27 Jun 2025 20:43:26 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 078158006D
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 20:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55RIgGEd2820962;
 Fri, 27 Jun 2025 13:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751049736;
 bh=775HIIos7bD7QvzuFU3oERNyXwopUOy3osnwQZXtgv4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=RgzO4IoLimlnhAhru+xnbXJCoXVQHL/2cqEoUZoTCoYaGgnk3oO07mNZ4E897AtX+
 TYEs8Bt1vXAdBv563ttnams+tsUkTMgLLFw/QpxvnoxkTIU+1zLQWxqoIXnfbNJw8/
 kGmGT1tBnRD5qmX0flVsH6ezOIP2xrza6kIH0wfM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55RIgFlo633648
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 27 Jun 2025 13:42:16 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 27
 Jun 2025 13:42:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 27 Jun 2025 13:42:15 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55RIgFIA3272624;
 Fri, 27 Jun 2025 13:42:15 -0500
Message-ID: <623b8617-09c1-4006-9a76-907182ff4387@ti.com>
Date: Fri, 27 Jun 2025 13:42:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] mach-k3: add runtime memory carveouts for MMU table
To: Tom Rini <trini@konsulko.com>
CC: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>, 
 <nm@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>, <devarsht@ti.com>,
 <robertcnelson@gmail.com>
References: <20250618124210.1936140-1-anshuld@ti.com>
 <85f6fdb7-73ea-4617-b82a-fb14369315d1@ti.com>
 <20250627180912.GG4003484@bill-the-cat>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250627180912.GG4003484@bill-the-cat>
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

On 6/27/25 1:09 PM, Tom Rini wrote:
> On Fri, Jun 27, 2025 at 01:06:50PM -0500, Andrew Davis wrote:
>> On 6/18/25 7:42 AM, Anshul Dalal wrote:
>>> In u-boot we only provide a single MMU table for all k3 platforms,
>>> this does not scale for devices with reserved memory outside the range
>>> 0x9e780000 - 0xa0000000 or for devices with < 2GiB of memory (eg
>>> am62-SIP with 512MiB of RAM).
>>>
>>> To properly configure the MMU on various k3 platforms, the
>>> reserved-memory regions need to be queried at runtime from the
>>> device-tree and the MMU table should be updated accordingly.
>>>
>>> This patch adds the required fixups to the MMU table (during proper
>>> U-boot stage) by marking the reserved regions as non cacheable and
>>> keeping the remaining area as cacheable.
>>>
>>> For the A-core SPL, the 128MiB region starting from SPL_TEXT_BASE
>>> is marked as cacheable i.e 0x80080000 to 0x88080000.
>>>
>>> The 128MiB size is chosen to allow for future use cases such as falcon
>>> boot from the A-Core SPL which would require loading kernel image from
>>> the SPL stage. This change also ensures the reserved memory regions that
>>> all exist past 0x88080000 are non cacheable preventing speculative
>>> accesses to those addresses.
>>>
>>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>>> ---
>>> Changes for v4:
>>>    - Add call to k3_mem_map_init for beagleplay
>>>    - Mark reserved regions as non-cacheable
>>
>> In v2 I said you cannot mark any regions as non-caching. How did this
>> sneak back in? If the reserved memory region is marked in DT as "no-map"
>> it must not be mapped at all. So NAK.
> 
> Presumably at the top of your mailbox now that I just pushed it to
> -next. 

Yes, this bubbled up to my attention thanks to your applied to -next message.

> Should I revert, or expect a prompt follow-up to clean things up?

If we get a quick cleanup patch that maps the reserved regions as caching to
match previous behavior that would remove much of the reason for this patch
in the first place. Removing mapping the reserved memory then we will break
remoteproc loading. Both have issues so reverting will probably be needed

Andrew
