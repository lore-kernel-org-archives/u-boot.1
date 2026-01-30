Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F405BE6BF35
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 19:09:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E60884535;
	Fri, 30 Jan 2026 20:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qaF3cO/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDEAB84543; Fri, 30 Jan 2026 20:09:48 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD29E844F4
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 20:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=03eb=AE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1769800183;
 bh=UyMQbb44tG4WMeN4fsYReMI3AdN5jpyMW0PhmcUnEaU=;
 b=qaF3cO/8HQACGOT6RwGY1KdKHDe7o2NiVI0vAHlitFGil0Hs16onUrIhe0XvywAH28i6YgNxm
 SAuzoTY8Z+IFe63j78oDEVAE5nYrWfTxJYqDBMXnYez0mim1i83jv/mxmPGVIt2sUWBtnXIgoDJ
 eRvALRocybGxU1EFXhRdLG8acadC92r9TOyZQNmA/8k8ClbLVenx3D+VJ9pXQdEnRU4hMvleOW1
 b+27pks8ilq4Wm1hvV7gtLSCBhQYOYUGMIvl/xM02H2vVhEt4cc07zM64fxV+O7s7t2C/9AIlbL
 JUES9TKtr5g5zK6JXM53/mC5Ndyd9GbxLxBkYbx5SUEA==
X-Forward-Email-ID: 697d01eed2f8868516a55735
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <544c09eb-7eec-40f1-b480-d5a60a88b9cb@kwiboo.se>
Date: Fri, 30 Jan 2026 20:09:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3568: Include all addressable DRAM in memory
 map
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20260129193153.2232395-1-jonas@kwiboo.se>
 <8bd0b00f-9631-4c36-bb73-280e4943dccc@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <8bd0b00f-9631-4c36-bb73-280e4943dccc@cherry.de>
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

Hi Quentin,

On 1/30/2026 7:19 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/29/26 8:31 PM, Jonas Karlman wrote:
>> Rockchip RK356x supports up to 8 GiB DRAM, however U-Boot only includes
>> the initial 4 GiB in its memory map, something that matches gd->ram_top
> 
> Does it? The first range is 0-0xf0000000 which is 3.75GiB and not 4GiB.

The 4 GiB here was more meant as the 32-bit 0-4 GiB addressable range.

To be more exact the initial 3840 MiB out of 4 GiB DRAM can be reached
at [0x0, 0xf0000000) and remaining 256 MiB at [0x1f0000000, 0x200000000).

>> and current expected memory available for use in U-Boot.
>>
>> Add the remaining 4-8 GiB range to the memory map to more correctly
>> describe available and addressable DRAM of RK356x. While at it also add
>> the missing UL suffix to the PCIe address range for consistency.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/mach-rockchip/rk3568/rk3568.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
>> index c2b96902d2dd..2b1eafee37c9 100644
>> --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
>> +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
>> @@ -72,9 +72,15 @@ static struct mm_region rk3568_mem_map[] = {
>>   			 PTE_BLOCK_NON_SHARE |
>>   			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>>   	}, {
>> -		.virt = 0x300000000,
>> -		.phys = 0x300000000,
>> -		.size = 0x0c0c00000,
>> +		.virt = 0x100000000UL,
>> +		.phys = 0x100000000UL,
> 
> How do you know it starts there? I'm assuming from the ATAGS? If so, 
> please state that in the commit log.

This range matches the DRAM banks we add in U-Boot proper, it also
matches some old dumps of rk356x ddr_mem tags I have at [1] and also
seem to match the mem map used in latest vendor U-Boot.

To me the commit message it quite clear, we only include 0-4 GiB (and
pcie range) in current memory map and this adds the missing 4-8 GiB
range, not sure how to phrase the commit message any clearer.

> The previous mem region ends there but if you read the TRM, it should 
> likely end at 0xFE8C0000 + 128KiB which is 0xfe8e0000. This only gives 
> us an additional 23.125MiB which wouldn't be enough to explain the 
> missing 0.25GiB we need to round this all to a nice 4/8GiB.

The rk356x only seem to be able to address up to 8 GiB so the the MIMO
address space is most likely lost DRAM. That extra 23.125 MiB is
probably not worth pursuing ;-)

Below is a copy of the rk356x ddr_mem tags for 4 GiB and 8 GiB, please
also see [2] for a dump of different rk3588 ddr_mem tags.

    count = 0x2
  bank[0] = 0x0
  bank[1] = 0x1f0000000
  bank[2] = 0xf0000000
  bank[3] = 0x10000000

    count = 0x1
  bank[0] = 0x0
  bank[1] = 0x200000000

[1] https://gist.github.com/Kwiboo/6d983693c79365b43c330eb3191cbace
[2] https://gist.github.com/Kwiboo/1c020d37e3adbc9d0d79dc003d921977

Regards,
Jonas

> 
> Cheers,
> Quentin

