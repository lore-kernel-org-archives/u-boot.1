Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73E8C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 18:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C5DD84942;
	Mon, 29 Jun 2026 20:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lqRrk/ks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EAA284A0F; Mon, 29 Jun 2026 20:15:08 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 635048490A
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 20:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d2b5=E2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1782756903;
 bh=az4qJOHFb9x4QwQHM1/1NqDa+LEPizd6oh57GwL1HmA=;
 b=lqRrk/ks7v+LAkuwq9cNWuoObDY24dYiLK1Ddjf7Yqp0nTvjXkteOMRYK785JRzZNeiNxxXIi
 vcCgJdH71jZAGD7V1tClpKGohdQt8XtfUmRzZlx9YNNmkQbQjUf6Pcmrwnm5w35OMZFkxEwnodG
 MEYbtoZSu4Y7EaUnIj18AML9UitIMhW4dApi4wtjvywH3z2xZChcMQNBCY3w3Zyrl78vXoGXSHH
 5EYF6+RV+5IJyMsmFCVgN85Q3kuroRweL3fAKow1ya32S88AP5u3bFiGzABTrG4Eq4aItZAeeEd
 QoeZ+IC4P2t91nrHnXBuu0p6S3t5OAy6+pVPaJ2hE7OQ==
X-Forward-Email-ID: 6a42b61f2f41acfca71c77e9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.9.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1080aff7-c678-424e-9b33-a56f7b0d7be4@kwiboo.se>
Date: Mon, 29 Jun 2026 20:14:30 +0200
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
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <DJLPP0RNHT5S.2K7TOQJSA7VLV@ti.com>
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

On 6/29/2026 7:33 PM, Randolph Sapp wrote:
> Hey, glad people are testing this. 
> 
> On Sat Jun 27, 2026 at 3:48 PM CDT, Jonas Karlman wrote:
>> The commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
>> removed the suppression of ERROR messages when -EINVAL is returned due
>> to the memory region not being part of the LMB memory map.
>>
>> This causes an irrelevant ERROR message during boot, e.g.:
>>
>>   Model: Radxa ROCK 3B
>>   [...]
>>   ERROR: reserving fdt memory region failed (addr=10f000 size=100 flags=2): -22
>>
>> or
>>
>>   Model: Rockchip RK3288 Asus Tinker Board S
>>   [...]
>>   ERROR: reserving fdt memory region failed (addr=fe000000 size=1000000 flags=4): -22
>>
>> FDT correctly contains reserved-memory for 10f000 or fe000000 and U-Boot
>> correctly does not make these regions available in the LMB memory map:
>>
>>   memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes, flags: none
>>   memory[1]      [0x100000000-0x1ffffffff], 0x100000000 bytes, flags: none
>>
>> or
>>
>>   memory[0]      [0x0-0x7fffffff], 0x80000000 bytes, flags: none
>>
>> Ignore -EINVAL errors to restore suppression of this irrelevant ERROR
>> message when memory region is not part of the LMB memory map.
>>
>> Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  boot/image-fdt.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>> index 9e0e0f93edd3..603294215b89 100644
>> --- a/boot/image-fdt.c
>> +++ b/boot/image-fdt.c
>> @@ -95,7 +95,7 @@ static void boot_fdt_handle_region(u64 addr, u64 size, u32 flags, bool free)
>>  		debug("   %s fdt memory region: addr=%llx size=%llx flags=%x\n",
>>  		      free ? "freed" : "reserved", (unsigned long long)addr,
>>  		      (unsigned long long)size, flags);
>> -	} else {
>> +	} else if (free || ret != -EINVAL) {
> 
> Seems like you messed up the free error reporting here.

Not sure what you mean, it is only lmb_alloc_mem() that documents:

  -EINVAL if the requested memory region is not part of the LMB memory map

and seems to now help print an verbose ERROR message during normal boot.

But maybe we should also ignore free errors?

> 
>>  		printf("ERROR: %s fdt memory region failed (addr=%llx size=%llx flags=%x): %ld\n",
>>  		       free ? "freeing" : "reserving", (unsigned long long)addr,
>>  		       (unsigned long long)size, flags, ret);
> 
> Got a few questions about this particular case though if you don't mind:
> 
> Why do you have reserved regions defined in areas that don't overlap with DDR?

E.g. fe000000-ffffffff or similar region is reserved for hw regs, on
boards with e.g. 4 GiB DRAM this area is typically unreachable, on a
2 GiB DRAM board there is no overlap.

The 10f000 is shmem used for SCMI, so should be defined in DT.

> Shouldn't those areas be unused anyway? Why don't we just explicitly ignore
> those reservations instead of forwarding them to an allocator that doesn't care?

That is what the net effect was prior to the changes in 623f6c5b6ab7
("boot: image-fdt: free old dtb reservations"). Rockchip platform
dynamically declare DRAM banks excluding the unusable ranges, and the
LMB allocator ignores ranges outside the declared DRAM banks.

> Why mask a bunch of potentially valid error cases for this explicit case?

That is what the code have been doing up until now, a different option
could be to change the error message to a debug message? Here I just
tried to do a limited revert to the old behavior.

Why should we print verbose ERROR messages for something that is not
always considered an error?

> 
> Why do none of the examples listed above have a memory node in dts? I've seen
> platforms that expect memory length to be defined by the bootloader, but they
> normally still place a dummy node in the tree at the correct starting address.

Rockchip platform dynamically check size of DRAM at runtime and declare
DRAM banks for the usable areas. Possible a fixup adds a memory node as
part of boot into OS.

Regards,
Jonas
