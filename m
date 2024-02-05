Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0A6C48297
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 13:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 898238798F;
	Mon,  5 Feb 2024 14:51:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="JzqsgCef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F5F9877CB; Mon,  5 Feb 2024 14:51:31 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 989D78798F
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 14:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4887=JP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1707141082;
 bh=ZGIcx7V+7s4HOfTFOQZ7I3p9/zDpBbZcm7yJzhMD2Lc=;
 b=JzqsgCefH1u7NFY8f0nE6iQpAztMBibPilUTZAW9coJfzS7dC/UqnqqJALWUTAGYkkOnOobxK
 lUjzZhUZa2tFbe+3glJmM3otUsVjc6Oqa9R0hlDWofMK68QgPDqk7RaSijDalE1WFAGTkuE915/
 rA16pEsc3mxUXD0LIN3W/8r6S0WBPe55++xnR1Yicu+hZOFp2N/cxdhPaNsOyJzLfGr8iRk6l6V
 cQ4ddSVMeCCcm6wzBYjL++Jo6A5eqiKaJ70RitYxQfrYxhSSVMCgDZGWUcBHPH0pE/DKm0tVq9G
 4Ihl7hznd66wIXebjeLpso7dYkRy2MjBemIBFRzEmHeA==
Message-ID: <13bb928f-0d86-41e3-a01e-0f5b9c74d761@kwiboo.se>
Date: Mon, 5 Feb 2024 14:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: spl: Enable caches to speed up checksum
 validation
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
References: <20240125211905.3649948-1-jonas@kwiboo.se>
 <44c406a7-48d3-4b2b-a8c6-076423b636aa@rock-chips.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <44c406a7-48d3-4b2b-a8c6-076423b636aa@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c0e7d9a7f28028f81d0538
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

On 2024-02-05 01:51, Kever Yang wrote:
> Hi Jonas,
> 
>      This patch fail to build with armv7 platform:
> 
> +arch/arm/mach-rockchip/spl.c: In function 'board_init_f':
> +arch/arm/mach-rockchip/spl.c:143:17: error: implicit declaration of 
> function 'enable_caches' [-Werror=implicit-function-declaration]
> +  143 |                 enable_caches();
> +      |                 ^~~~~~~~~~~~~
> 

Oh, I will probably have to protect the added code using #if instead.

Will send a v4 later.

Regards,
Jonas

> 
> Thanks,
> 
> - Kever
> 
> On 2024/1/26 05:19, Jonas Karlman wrote:
>> FIT checksum validation is very slow in SPL due to D-cache not being
>> enabled.
>>
>> Enable caches in SPL on ARM64 SoCs to speed up FIT checksum validation,
>> from seconds to milliseconds.
>>
>> This change enables caches in SPL on all Rockchip ARM64 boards, the
>> Kconfig options SPL_SYS_ICACHE_OFF and SPL_SYS_DCACHE_OFF can be used to
>> disable caches for a specific board or SoC if needed.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
>> Changes in v3:
>> - Limit to ARM64 SoCs
>> - Fix build with SPL_SYS_ICACHE_OFF or SPL_SYS_DCACHE_OFF enabled
>> - Use cleanup_before_linux() in spl_board_prepare_for_boot() to disable
>>    caches before jumping from SPL to next stage
>> - Collect r-b tag
>>
>> Changes in v2:
>> - None
>>
>> This has been tested on multiple RK3328, RK3399, RK356x and RK3588
>> boards without any issues, vendor U-Boot also enables caches in SPL for
>> all SoCs.
>>
>> This only worked on RK3288 because the default enable_caches() that does
>> not enable caches was being used. Trying to enable caches on my RK3288
>> froze my boards in mmu_setup(). So v3 limits the enable_caches() call to
>> only include ARM64 SoCs.
>>
>> Link to RFC: https://patchwork.ozlabs.org/patch/1802303/
>> Link to v2: https://patchwork.ozlabs.org/patch/1889319/
>> ---
>>   arch/arm/mach-rockchip/spl.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
>> index 87280e2ba7cc..c4d3983a6735 100644
>> --- a/arch/arm/mach-rockchip/spl.c
>> +++ b/arch/arm/mach-rockchip/spl.c
>> @@ -136,6 +136,20 @@ void board_init_f(ulong dummy)
>>   	}
>>   	gd->ram_top = gd->ram_base + get_effective_memsize();
>>   	gd->ram_top = board_get_usable_ram_top(gd->ram_size);
>> +
>> +	if (IS_ENABLED(CONFIG_ARM64) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
>> +		gd->relocaddr = gd->ram_top;
>> +		arch_reserve_mmu();
>> +		enable_caches();
>> +	}
>>   #endif
>>   	preloader_console_init();
>>   }
>> +
>> +void spl_board_prepare_for_boot(void)
>> +{
>> +	if (!IS_ENABLED(CONFIG_ARM64) || CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
>> +		return;
>> +
>> +	cleanup_before_linux();
>> +}

