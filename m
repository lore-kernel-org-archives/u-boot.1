Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66D8CD4F3E
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 12:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3677783AA0;
	Sun, 16 Nov 2025 13:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="HP35fwXN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 511E583AA7; Sun, 16 Nov 2025 13:33:41 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E505D83959
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 13:33:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ebe4=5Z=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1763296417;
 bh=sDz8jDPf363bH05KLDfDg7w/nt9e0tFIQA+flzPGv3U=;
 b=HP35fwXNKywVEYd44D5JwAFl33yrJj4XjjdE7H0EasKaePlh4AvFg2ArkwaYsOnWlny9fu6JR
 VkNGrbfbsDkR/MIg441luYIyvLPmHZY1/wPEr0ausNEWQ+nnIQ6k+w+c2Z06t6moDTFiQNY9p9q
 w02W7GksziKXtowZBy0VVIHyaAmwH/D5omuZ94utrrA8RaZ4ZDCa7af1A4ccZLc7lAx/J9oAJqr
 lDFiqaxtsj9QFolUNfk3XhotplxFMpggQtnD97BzGUBiKtZZ3dPKrmvcNOyT+P2mx5SbBxZF+qV
 4Dw0b+GkPN9xwZ3EGILgrDJzUnQSjIhKXSyK0SP2opyQ==
X-Forward-Email-ID: 6919c49ae64fa24da9bd4dd7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.4.5
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <083f7cc0-7e45-47c6-855c-a2a8bc1c435b@kwiboo.se>
Date: Sun, 16 Nov 2025 13:33:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3588: Map SCMI shared memory area as
 non-cacheable
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20251116014531.2133243-1-jonas@kwiboo.se>
 <CALeDE9OzWUNOmsgQ+S5PRCSQmXne=YBXwSZmXP-AtgmY=RQe+A@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CALeDE9OzWUNOmsgQ+S5PRCSQmXne=YBXwSZmXP-AtgmY=RQe+A@mail.gmail.com>
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

Hi Peter,

On 11/16/2025 10:55 AM, Peter Robinson wrote:
> Hey Jonas,
> 
>> The SCMI shared memory area is no longer automatically marked as
>> non-cacheable after the commit a5a0134570c8 ("firmware: scmi: Drop
>> mmu_set_region_dcache_behaviour() misuse").
>>
>> This change in behavior cause Rockchip RK3588 boards to fail boot with:
>>
>>   SoC:   RK3588
>>   DRAM:  8 GiB
>>   scmi-over-smccc scmi: Channel unexpectedly busy
>>   scmi_base_drv scmi-base.0: getting protocol version failed
>>   scmi-over-smccc scmi: failed to probe base protocol
>>   initcall_run_r(): initcall initr_dm() failed
>>   ### ERROR ### Please RESET the board ###
>>
>> Update the memory mapping on RK3588 to mark the SCMI shared memory area
>> as non-cacheable to fix the SCMI shared memory based transport issue
>> that prevented RK3588 boards from booting.
> 
> Will the other newer rockchips rk356x devices which use SCMI need this fix too?

Most RK35xx SoCs only use SCMI clks for CPU, GPU and NPU, however RK3588
also use SCMI clks for sdmmc and because of this is the only RK SoC in
U-Boot that auto imply SCMI_FIRMWARE and CLK_SCMI Kconfig options.

Other boards with RK35xx SoCs could be affected in case the SCMI Kconfig
options are enabled by a user when building U-Boot.

Ideally we could look for /reserved-memory/shmem nodes, however they
seem to use wrong size, 0x100 instead of the actual used 0x1000 size:

  #define SCMI_SHARE_MEM_SIZE	SIZE_K(4)

For now I just fixed RK3588 to get boards booting using latest master.

Regards,
Jonas

> 
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  arch/arm/mach-rockchip/rk3588/rk3588.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
>> index c01a40020896..55d2caab4fec 100644
>> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
>> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
>> @@ -63,7 +63,20 @@ static struct mm_region rk3588_mem_map[] = {
>>         {
>>                 .virt = 0x0UL,
>>                 .phys = 0x0UL,
>> -               .size = 0xf0000000UL,
>> +               .size = 0x10f000UL,
>> +               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>> +                        PTE_BLOCK_INNER_SHARE
>> +       }, {
>> +               /* SCMI shared memory area must be mapped as non-cacheable. */
>> +               .virt = 0x10f000UL,
>> +               .phys = 0x10f000UL,
>> +               .size = 0x1000UL,
>> +               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
>> +                        PTE_BLOCK_INNER_SHARE
>> +       }, {
>> +               .virt = 0x110000UL,
>> +               .phys = 0x110000UL,
>> +               .size = 0xefef0000UL,
>>                 .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>                          PTE_BLOCK_INNER_SHARE
>>         }, {
>> --
>> 2.51.2
>>

