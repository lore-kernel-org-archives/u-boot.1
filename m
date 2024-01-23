Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD48CC47DDC
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 10:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF2C587CC0;
	Tue, 23 Jan 2024 11:16:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="RUBSpA90";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9763487CA1; Tue, 23 Jan 2024 11:16:40 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37C9687D06
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 11:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=33c1=JB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1706004981;
 bh=cCSVYjcwFv/QKrKrZQQw+T+ni4qe0GD2zv63emHCzcs=;
 b=RUBSpA90W04XrXxQCH+k/xFJ4YWMsgr6tqpSTdNlJAjGyhnnOYfcPL3uPLd1zthi+L0XW7HXb
 8emBEu/EXx/CCS69N+yn82k2THc/lZQqgThNNuL0wzIDbFkl7pJxMCFbzY4yOJFKOjehBuyA+vI
 Ns3uO+5n8liEyi4AWF8i7QFBwc7Vc6E3W8DK+Cg3AWE4w56OBLgsyGSj61m7z/piP3boKdaumWp
 437im/d1U/DizyE9cvTnPEfysV/xR6VlMmcbFaugKQeipryKpZJc1n/NatTGVQN8Dzb4naWdMfx
 PNPram93H9dVXzG9cGEBjLljwcIg1NbXpTpXWs/ReWxg==
Message-ID: <358939ff-0379-40ec-875e-80f608a21c40@kwiboo.se>
Date: Tue, 23 Jan 2024 11:16:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: spl: Enable caches to speed up checksum
 validation
To: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
References: <20240122181631.2383743-1-jonas@kwiboo.se>
 <3c5babfa-6ce3-4629-8694-692bda20b3e5@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <3c5babfa-6ce3-4629-8694-692bda20b3e5@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65af91f547ae9d353e475bd8
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

Hi Kever,

On 2024-01-23 03:36, Kever Yang wrote:
> Hi Jonas,
> 
> On 2024/1/23 02:16, Jonas Karlman wrote:
>> FIT checksum validation is very slow in SPL due to D-cache not being
>> enabled.
>>
>> Enable caches in SPL to speed up FIT checksum validation, from seconds
>> to milliseconds.
>>
>> This change enables caches in SPL on all Rockchip boards, the Kconfig
>> options SPL_SYS_ICACHE_OFF and SPL_SYS_DCACHE_OFF can be enabled to
>> disable caches for a specific board or SoC if needed.
> It should invalidate cache before go to next stage, but the U-Boot 
> proper and SPL
> are using different memory area and U-Boot calls cleanup_before_linux() 
> at last,
> this patch should be safe in current code structure.

Thanks for input, since the commit 6826c432e351 ("spl: Jump to image at
end of board_init_r") the spl_board_prepare_for_boot() will be called
before next stage after SPL regardless of TF-A, OPTEE, linux or U-Boot
proper.

Sounds like I should add something like the following in v3, after some
re-testing to ensure all caches are disabled before next stage.

void spl_board_prepare_for_boot(void)
{
	cleanup_before_linux();
}

Regards,
Jonas

> 
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> 
> Thanks,
> - Kever
> 
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Changes in v2:
>> - None
>>
>> This has been tested on multiple RK3288, RK3328, RK3399, RK356x and
>> RK3588 boards without any issues, vendor U-Boot also enables caches in
>> SPL for all SoCs.
>>
>> Link to RFC: https://patchwork.ozlabs.org/patch/1802303/
>> ---
>>   arch/arm/mach-rockchip/spl.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
>> index 87280e2ba7cc..e29c841100c8 100644
>> --- a/arch/arm/mach-rockchip/spl.c
>> +++ b/arch/arm/mach-rockchip/spl.c
>> @@ -136,6 +136,10 @@ void board_init_f(ulong dummy)
>>   	}
>>   	gd->ram_top = gd->ram_base + get_effective_memsize();
>>   	gd->ram_top = board_get_usable_ram_top(gd->ram_size);
>> +	gd->relocaddr = gd->ram_top;
>> +
>> +	arch_reserve_mmu();
>> +	enable_caches();
>>   #endif
>>   	preloader_console_init();
>>   }

