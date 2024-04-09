Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B8DCD128A
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 16:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D03987E06;
	Tue,  9 Apr 2024 18:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="MeU3MSjg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD18A87EA9; Tue,  9 Apr 2024 18:30:58 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70E5C87DCA
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 18:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=445b=LP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1712680248;
 bh=8oJNJ93vCfGqERkdYpUMIINwLc9gwxTgSgHDcHAVhgY=;
 b=MeU3MSjgY5XKHb+MNHm7xHuOWT/MvH5j/fTcIp2CvUv3TicrV1MeRH/DYALWtvEPOThGpdX79
 4TalYtH8siG0okmbZbT87rmPR7sTSTsVFBYL9yrYIChb/g/3XGbhAD6IoUXsldTYhpj4ksVGtL+
 Kte4ojlvjlF9bM0wL/oEAMJrXiR9xfOMPDzGpFEZbpBJfsaa0wgj+07DXml82np2Knoob1P3GIB
 ck1WS3omR6eyj9p1cSevfyKRHOOqKUQf7IpCtGC4zG6JZOj0tiGic+26E6E0A5sGtUl2JmE3xZ3
 Y4qn4ZHc05QrZb5ny8+l2WC20D7e7s9TM7X1Vo6ZrP3g==
Message-ID: <e73b2576-4a0c-4965-a1f8-debe6b364af3@kwiboo.se>
Date: Tue, 9 Apr 2024 18:30:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: Imply HS200 cap with mmc-hs400 prop to match
 linux
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini
 <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240408210619.3749231-1-jonas@kwiboo.se>
 <496013c1-7a57-4d12-bf31-c5257f35ee8c@theobroma-systems.com>
 <3b2643b4-dea7-43cd-9f9c-da63e6588281@kwiboo.se>
 <ac394528-ca53-41d5-8c4c-7c10943a7c92@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <ac394528-ca53-41d5-8c4c-7c10943a7c92@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66156d37e7a102f19b2aa09f
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

Hi Quentin,

On 2024-04-09 18:02, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 4/9/24 17:58, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 2024-04-09 17:27, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 4/8/24 23:06, Jonas Karlman wrote:
>>>> eMMC nodes in linux device tree files typically only contain a mmc-hs400
>>>> prop to signal support for both HS400 and HS200. However, U-Boot require
>>>> an explicit mmc-hs200 prop to signal support for the HS200 mode.
>>>>   > Fix this by follow linux and imply HS200 cap when HS400 cap is signaled
>>>> using a mmc-hs400 prop.
>>>>
>>>
>>> Technically speaking, the DT binding should be the one and only source
>>> of truth and should be implementation-agnostic.
>>>
>>> There it says:
>>> """
>>>     mmc-hs400-1_2v:
>>>       $ref: /schemas/types.yaml#/definitions/flag
>>>       description:
>>>         eMMC HS400 mode (1.2V I/O) is supported.
>>>
>>>     mmc-hs400-1_8v:
>>>       $ref: /schemas/types.yaml#/definitions/flag
>>>       description:
>>>         eMMC HS400 mode (1.8V I/O) is supported.
>>> """
>>>
>>> So I'd say, the DTs should be fixed to add mmc-hs200 as well wherever it
>>> makes sense.
>>>
>>> The point of the DT/DT binding is to be system-agnostic and
>>> representative of the **HW** implementation. At least that's what the DT
>>> people want it to be.
>>>
>>> If the eMMC standard doesn't allow to have HS400 without HS200, then I
>>> think this change is acceptable as is, because it is the reality of the
>>> HW standard. Couldn't find this implied in the standard though (but I
>>> just skimmed through).
>>>
>>> It's also quite surprising, as it's not because the eMMC works with
>>> HS400 that it necessarily does with HS200 or that it's desired (EMI,
>>> signal integrity/stability, etc...)?
>>>
>>> Now, it wouldn't be the first time U-Boot follows whatever is done in
>>> Linux, so... up to you/the maintainers :)
>>
>> Agree that implying HS200 does not fully make sense, however it was part
>> of the original Linux binding when HS400 was added in v3.16-rc1 [1] so I
>> think that this is the expected behavior and changing it may be an ABI
>> breakage.
>>
> 
> I'm not advocating undoing the kernel "hack", but rather make it so that 
> we add hs200 to DTs where it's actually supported instead of doing the 
> same hack the kernel does. In that case, we wouldn't need the hack anymore.

I will add a patch that adds the missing mmc-hs200 props to affected
rk3588 boards, nanopc-t4 and quartzpro64 in v2 of the "rockchip: rk35xx:
Miscellaneous fixes and updates" series.

Also turns out the issue with those boards was because of my other "mmc:
rockchip_sdhci: Revert 4 blocks PIO mode read limit for RK35xx" patch,
so will need to rework that revert some more before posting a v2 of that
patch.

For this patch it is fully up to the maintainers if U-Boot wants to
mimic Linux kernel or not.

Regards,
Jonas

> 
> (well maybe it isn't a hack per-se, but for lack of more info on that, I 
> call the kernel implementation this :) )
> 
> Cheers,
> Quentin

