Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A070C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 19:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C47A9849FB;
	Mon, 29 Jun 2026 21:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="tFg2Ep2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 668D984A5D; Mon, 29 Jun 2026 21:08:09 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E82AE84931
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 21:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d2b5=E2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1782760085;
 bh=vyZMjiuI1sauNpm4W0YuxHIbjTbZ22Qie3hNm9Z6+go=;
 b=tFg2Ep2HidIlZ/9HSzuOSd2h2vJH811BsNdaBQQ4laGUmpkh9z9XPuB/aYenbEklDn5edhILV
 qLM7pvGBNpeun4w0qOEOQocdb4EFRMkUKbKSJZYo734TF54GXprm1gL16rjLaejX6cAl6smUXIS
 /F1S2pMg4XD75nQnwJ4aC5iCr8qQQmCPgu08ut8NYXFBgmxl7QqI69HB7FS9SS7soaotBainLSa
 Nyz/92//niQ6CJyKfsGZUgLcc+/jdey1vnnGuxKMO4nIdIF0HqvByIf98Gpp1fV/oZ+APIidL+3
 n5Q8uQt3/ElYWOJbrx9P+OHQ91xlWg12NvRvXHWoLsAQ==
X-Forward-Email-ID: 6a42c294241fd3e251da4990
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.9.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c8c24197-17ae-486f-82e9-04968a6292b6@kwiboo.se>
Date: Mon, 29 Jun 2026 21:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: image-fdt: Restore suppression of irrelevant ERROR
 message
To: Randolph Sapp <rs@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20260627204851.1151419-1-jonas@kwiboo.se>
 <DJLPP0RNHT5S.2K7TOQJSA7VLV@ti.com>
 <1080aff7-c678-424e-9b33-a56f7b0d7be4@kwiboo.se>
 <DJLR1SYPDTS4.2ZVE5UPMD7COE@ti.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <DJLR1SYPDTS4.2ZVE5UPMD7COE@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Randolph,

On 6/29/2026 8:37 PM, Randolph Sapp wrote:
> On Mon Jun 29, 2026 at 1:14 PM CDT, Jonas Karlman wrote:
>> Hi Randolph,
>>
>> On 6/29/2026 7:33 PM, Randolph Sapp wrote:
>>> Hey, glad people are testing this. 
>>>
>>> On Sat Jun 27, 2026 at 3:48 PM CDT, Jonas Karlman wrote:
>>>> The commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
>>>> removed the suppression of ERROR messages when -EINVAL is returned due
>>>> to the memory region not being part of the LMB memory map.
>>>>
>>>> This causes an irrelevant ERROR message during boot, e.g.:
>>>>
>>>>   Model: Radxa ROCK 3B
>>>>   [...]
>>>>   ERROR: reserving fdt memory region failed (addr=10f000 size=100 flags=2): -22
>>>>
>>>> or
>>>>
>>>>   Model: Rockchip RK3288 Asus Tinker Board S
>>>>   [...]
>>>>   ERROR: reserving fdt memory region failed (addr=fe000000 size=1000000 flags=4): -22
>>>>
>>>> FDT correctly contains reserved-memory for 10f000 or fe000000 and U-Boot
>>>> correctly does not make these regions available in the LMB memory map:
>>>>
>>>>   memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes, flags: none
>>>>   memory[1]      [0x100000000-0x1ffffffff], 0x100000000 bytes, flags: none
>>>>
>>>> or
>>>>
>>>>   memory[0]      [0x0-0x7fffffff], 0x80000000 bytes, flags: none
>>>>
>>>> Ignore -EINVAL errors to restore suppression of this irrelevant ERROR
>>>> message when memory region is not part of the LMB memory map.
>>>>
>>>> Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>>  boot/image-fdt.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>>>> index 9e0e0f93edd3..603294215b89 100644
>>>> --- a/boot/image-fdt.c
>>>> +++ b/boot/image-fdt.c
>>>> @@ -95,7 +95,7 @@ static void boot_fdt_handle_region(u64 addr, u64 size, u32 flags, bool free)
>>>>  		debug("   %s fdt memory region: addr=%llx size=%llx flags=%x\n",
>>>>  		      free ? "freed" : "reserved", (unsigned long long)addr,
>>>>  		      (unsigned long long)size, flags);
>>>> -	} else {
>>>> +	} else if (free || ret != -EINVAL) {
>>>
>>> Seems like you messed up the free error reporting here.
>>
>> Not sure what you mean, it is only lmb_alloc_mem() that documents:
>>
>>   -EINVAL if the requested memory region is not part of the LMB memory map
>>
>> and seems to now help print an verbose ERROR message during normal boot.
>>
>> But maybe we should also ignore free errors?
>>
>>>
>>>>  		printf("ERROR: %s fdt memory region failed (addr=%llx size=%llx flags=%x): %ld\n",
>>>>  		       free ? "freeing" : "reserving", (unsigned long long)addr,
>>>>  		       (unsigned long long)size, flags, ret);
>>>
>>> Got a few questions about this particular case though if you don't mind:
>>>
>>> Why do you have reserved regions defined in areas that don't overlap with DDR?
>>
>> E.g. fe000000-ffffffff or similar region is reserved for hw regs, on
>> boards with e.g. 4 GiB DRAM this area is typically unreachable, on a
>> 2 GiB DRAM board there is no overlap.
>>
>> The 10f000 is shmem used for SCMI, so should be defined in DT.
>>
>>> Shouldn't those areas be unused anyway? Why don't we just explicitly ignore
>>> those reservations instead of forwarding them to an allocator that doesn't care?
>>
>> That is what the net effect was prior to the changes in 623f6c5b6ab7
>> ("boot: image-fdt: free old dtb reservations"). Rockchip platform
>> dynamically declare DRAM banks excluding the unusable ranges, and the
>> LMB allocator ignores ranges outside the declared DRAM banks.
> 
> Not quite. I mean, we should ignore the region explicitly. As in, we should
> never even request to reserve regions outside of LMB.

How would you suggest we do that?

LMB memory map is internal to lmb and boot_fdt_handle_region() is the
actual function that tries to reserve regions from FDT and would be
where we test if a region is part of memory map or not, so why should it
not be able to do such test based on the error code returned from the
function is would end up calling anyway?

With above analysis I am even more convinced that this error message
probably could be downgraded to a debug message ;-)

In what scenarios do you expect this error message to be useful when FDT
contains a reserved region that is not part of LMB memory map?

Regards,
Jonas

> 
>>> Why mask a bunch of potentially valid error cases for this explicit case?
>>
>> That is what the code have been doing up until now, a different option
>> could be to change the error message to a debug message? Here I just
>> tried to do a limited revert to the old behavior.
>>
>> Why should we print verbose ERROR messages for something that is not
>> always considered an error?
> 
> Because under normal circumstances it should always be an error. Occasionally
> asking for a reservation you know is going to fail and assuming all failures of
> that type are OK is a little odd.
> 
>>>
>>> Why do none of the examples listed above have a memory node in dts? I've seen
>>> platforms that expect memory length to be defined by the bootloader, but they
>>> normally still place a dummy node in the tree at the correct starting address.
>>
>> Rockchip platform dynamically check size of DRAM at runtime and declare
>> DRAM banks for the usable areas. Possible a fixup adds a memory node as
>> part of boot into OS.
>>
>> Regards,
>> Jonas
> 
> Ah, thanks for the information.

