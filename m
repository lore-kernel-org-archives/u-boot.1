Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0333EC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 20:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C42E849C5;
	Mon, 29 Jun 2026 22:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QNll29p5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F2E584A9A; Mon, 29 Jun 2026 22:58:08 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F239184979
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 22:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d2b5=E2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1782766683;
 bh=XLQ6de3sheQpfMKXekW4fwDBYGNLqYqMXY2oIafQfgw=;
 b=QNll29p5B9yfreuc3v4gk2tSOBqcCz5i+i9PGzKr67cf5R4AsX+s6c6SLNi2VpNUzhSCvzn5I
 4nlqD8odfkLjC14VN52/ECtuWqeMTz0mkbB48T3DrqP22oPex182Ts16hZUJ2GS7UqAMBtQXWdu
 ia73CVbCKKbj+TN442HRaPedjNZey3ZPxmQ29JtAEfr6jvS753lHbMUnOdwb0RApxrZUp/LdFyx
 mS7a7P9dQWP3rF6SOobfOyZ41vtT22C1io8vhufy9/Io3vuZdnREJu2m4g3yD2vU+3gtdlfu7OQ
 Waa4SbLE9qhruTO5zn5nxk8vZtduMLduNF0QnPW6lxZw==
X-Forward-Email-ID: 6a42dc54241fd3e251da6f95
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.9.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <eedd8747-ffd6-4c61-a5f3-e748ed1831de@kwiboo.se>
Date: Mon, 29 Jun 2026 22:57:53 +0200
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
 <c8c24197-17ae-486f-82e9-04968a6292b6@kwiboo.se>
 <DJLT7S292PYE.380FF8KPK95CN@ti.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <DJLT7S292PYE.380FF8KPK95CN@ti.com>
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

On 6/29/2026 10:19 PM, Randolph Sapp wrote:
> On Mon Jun 29, 2026 at 2:08 PM CDT, Jonas Karlman wrote:
>> Hi Randolph,
>>
>> On 6/29/2026 8:37 PM, Randolph Sapp wrote:
>>> On Mon Jun 29, 2026 at 1:14 PM CDT, Jonas Karlman wrote:
>>>> Hi Randolph,
>>>>
>>>> On 6/29/2026 7:33 PM, Randolph Sapp wrote:
>>>>> Hey, glad people are testing this. 
>>>>>
>>>>> On Sat Jun 27, 2026 at 3:48 PM CDT, Jonas Karlman wrote:
>>>>>> The commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
>>>>>> removed the suppression of ERROR messages when -EINVAL is returned due
>>>>>> to the memory region not being part of the LMB memory map.
>>>>>>
>>>>>> This causes an irrelevant ERROR message during boot, e.g.:
>>>>>>
>>>>>>   Model: Radxa ROCK 3B
>>>>>>   [...]
>>>>>>   ERROR: reserving fdt memory region failed (addr=10f000 size=100 flags=2): -22
>>>>>>
>>>>>> or
>>>>>>
>>>>>>   Model: Rockchip RK3288 Asus Tinker Board S
>>>>>>   [...]
>>>>>>   ERROR: reserving fdt memory region failed (addr=fe000000 size=1000000 flags=4): -22
>>>>>>
>>>>>> FDT correctly contains reserved-memory for 10f000 or fe000000 and U-Boot
>>>>>> correctly does not make these regions available in the LMB memory map:
>>>>>>
>>>>>>   memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes, flags: none
>>>>>>   memory[1]      [0x100000000-0x1ffffffff], 0x100000000 bytes, flags: none
>>>>>>
>>>>>> or
>>>>>>
>>>>>>   memory[0]      [0x0-0x7fffffff], 0x80000000 bytes, flags: none
>>>>>>
>>>>>> Ignore -EINVAL errors to restore suppression of this irrelevant ERROR
>>>>>> message when memory region is not part of the LMB memory map.
>>>>>>
>>>>>> Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
>>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>>> ---
>>>>>>  boot/image-fdt.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>>>>>> index 9e0e0f93edd3..603294215b89 100644
>>>>>> --- a/boot/image-fdt.c
>>>>>> +++ b/boot/image-fdt.c
>>>>>> @@ -95,7 +95,7 @@ static void boot_fdt_handle_region(u64 addr, u64 size, u32 flags, bool free)
>>>>>>  		debug("   %s fdt memory region: addr=%llx size=%llx flags=%x\n",
>>>>>>  		      free ? "freed" : "reserved", (unsigned long long)addr,
>>>>>>  		      (unsigned long long)size, flags);
>>>>>> -	} else {
>>>>>> +	} else if (free || ret != -EINVAL) {
>>>>>
>>>>> Seems like you messed up the free error reporting here.
>>>>
>>>> Not sure what you mean, it is only lmb_alloc_mem() that documents:
>>>>
>>>>   -EINVAL if the requested memory region is not part of the LMB memory map
>>>>
>>>> and seems to now help print an verbose ERROR message during normal boot.
>>>>
>>>> But maybe we should also ignore free errors?
>>>>
>>>>>
>>>>>>  		printf("ERROR: %s fdt memory region failed (addr=%llx size=%llx flags=%x): %ld\n",
>>>>>>  		       free ? "freeing" : "reserving", (unsigned long long)addr,
>>>>>>  		       (unsigned long long)size, flags, ret);
>>>>>
>>>>> Got a few questions about this particular case though if you don't mind:
>>>>>
>>>>> Why do you have reserved regions defined in areas that don't overlap with DDR?
>>>>
>>>> E.g. fe000000-ffffffff or similar region is reserved for hw regs, on
>>>> boards with e.g. 4 GiB DRAM this area is typically unreachable, on a
>>>> 2 GiB DRAM board there is no overlap.
>>>>
>>>> The 10f000 is shmem used for SCMI, so should be defined in DT.
>>>>
>>>>> Shouldn't those areas be unused anyway? Why don't we just explicitly ignore
>>>>> those reservations instead of forwarding them to an allocator that doesn't care?
>>>>
>>>> That is what the net effect was prior to the changes in 623f6c5b6ab7
>>>> ("boot: image-fdt: free old dtb reservations"). Rockchip platform
>>>> dynamically declare DRAM banks excluding the unusable ranges, and the
>>>> LMB allocator ignores ranges outside the declared DRAM banks.
>>>
>>> Not quite. I mean, we should ignore the region explicitly. As in, we should
>>> never even request to reserve regions outside of LMB.
>>
>> How would you suggest we do that?
>>
>> LMB memory map is internal to lmb and boot_fdt_handle_region() is the
>> actual function that tries to reserve regions from FDT and would be
>> where we test if a region is part of memory map or not, so why should it
>> not be able to do such test based on the error code returned from the
>> function is would end up calling anyway?
>>
>> With above analysis I am even more convinced that this error message
>> probably could be downgraded to a debug message ;-)
>>
>> In what scenarios do you expect this error message to be useful when FDT
>> contains a reserved region that is not part of LMB memory map?
> 
> What about when the FDT contains a reserved region that is part of the LMB
> memory map, but failed to initialize the address pointer correctly?

Please elaborate in what scenario this could happen, any possible
consequence of such error and how this specific error message help
end-users.

> 
> My point is this error code is not specifically reserved for the case you are
> describing and may adopt additional functionality in the future. It already has
> one additional case tied to it *today*.

I do not understand, lmb_alloc_mem() is documented as:

  When the allocation is of type @LMB_MEM_ALLOC_ADDR, the return value can
  be -EINVAL if the requested memory region is not part of the LMB memory
  map, and -EEXIST if the requested region is already allocated.

The old behavior prior to the offending commit correctly ignored this
return value to not produce a verbose ERROR message for regions not part
of the memory map.

The change in this patch restores logging to such expected behavior.
Do you prefer a full revert of the offending commit instead of reverting
logging to old behavior, a downgrade from printf() to debug() or some
other way to remove this erroneous verbose ERROR message?

Regards,
Jonas

> 
>>>
>>>>> Why mask a bunch of potentially valid error cases for this explicit case?
>>>>
>>>> That is what the code have been doing up until now, a different option
>>>> could be to change the error message to a debug message? Here I just
>>>> tried to do a limited revert to the old behavior.
>>>>
>>>> Why should we print verbose ERROR messages for something that is not
>>>> always considered an error?
>>>
>>> Because under normal circumstances it should always be an error. Occasionally
>>> asking for a reservation you know is going to fail and assuming all failures of
>>> that type are OK is a little odd.
>>>
>>>>>
>>>>> Why do none of the examples listed above have a memory node in dts? I've seen
>>>>> platforms that expect memory length to be defined by the bootloader, but they
>>>>> normally still place a dummy node in the tree at the correct starting address.
>>>>
>>>> Rockchip platform dynamically check size of DRAM at runtime and declare
>>>> DRAM banks for the usable areas. Possible a fixup adds a memory node as
>>>> part of boot into OS.
>>>>
>>>> Regards,
>>>> Jonas
>>>
>>> Ah, thanks for the information.
> 

