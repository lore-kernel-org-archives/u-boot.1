Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C6DC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 16:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E861E80104;
	Wed,  5 Feb 2025 17:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="XeoUTjMa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A7B8033D; Wed,  5 Feb 2025 17:20:38 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BFBD8003E
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 17:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9fbe=U5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738772435;
 bh=3ZP/xGcw8iuJyAV2VgKiQE+j6KKOUUi35sv/31qSVeo=;
 b=XeoUTjMaCwf4GUch0SCbdgF9mXvpzgod9vhlAaJ0NrG1tgeS9gR0YzyQElK47bIJ0ZWYxOdq5
 N2OrWJXuhli3CxUT9ezxSVXRFOyd44WxUAY84mwD+qhWnFK5vE9C5EKzVw5EdII5dc0fF1L2uvB
 YahFdwOP1/MghZNeVCPJ1fYgSQiZPXy/Czb/xQzyVGDm8CViiaW/ajkSU5F7P2tJA8igi/9kFea
 HQgAsr4/oHRXejt8wW2qQ0SiIxiAfrC/bW2FGPlzvLARAZo1QrdjmnsTT8mpQqs7AGKX1nWdH3H
 ifEalNTDDUgNxQeT/oZND5xvMkVFYGdt6z1D1uKe04TQ==
X-Forward-Email-ID: 67a38fcbfb44099d0e594e52
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f119f652-647b-4f62-bcf6-e3672a6ce2b2@kwiboo.se>
Date: Wed, 5 Feb 2025 17:20:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rockchip: Fix SPL link error for Radxa ROCK Pi 4
To: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, trini@konsulko.com, dsimic@manjaro.org,
 pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 ian.roberts@timesys.com, nathan.morrison@timesys.com,
 greg.malysa@timesys.com, bb@ti.com
References: <20250129132529.807031-1-naoki@radxa.com>
 <20250129132529.807031-2-naoki@radxa.com>
 <4e7d8797-8fc7-43cf-ba8c-085476ba9fcf@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <4e7d8797-8fc7-43cf-ba8c-085476ba9fcf@cherry.de>
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

Hi Quentin and Naoki,

On 2025-02-05 12:37, Quentin Schulz wrote:
> Hi Naoki,
> 
> On 1/29/25 2:25 PM, FUKAUMI Naoki wrote:
>> If CONFIG_EFI_CAPSULE_FIRMWARE_RAW, CONFIG_SPL_ENV_SUPPORT, and
>> CONFIG_SPL_DFU are enabled, linking u-boot-spl will fail.
>>
>>    LD      spl/u-boot-spl
>> ld.bfd: drivers/dfu/dfu.o: in function `dfu_init_env_entities':
>> /home/radxa/u-boot/drivers/dfu/dfu.c:173:(.text.dfu_init_env_entities+0x24): undefined reference to `set_dfu_alt_info'
>>
>> Compile mach-rockchip/board.c for SPL.
>>
>> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>> ---
>>   arch/arm/mach-rockchip/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
>> index 5e7edc99cdc..e697df7ebcb 100644
>> --- a/arch/arm/mach-rockchip/Makefile
>> +++ b/arch/arm/mach-rockchip/Makefile
>> @@ -22,10 +22,10 @@ ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
>>   # we can have the preprocessor correctly recognise both 0x0 and 0
>>   # meaning "turn it off".
>>   obj-y += boot_mode.o
>> -obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
>>   endif
>>   
>>   ifeq ($(CONFIG_TPL_BUILD),)
>> +obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
> 
> This is probably a tiny bit too enthusiastic.
> 
> This means the whole content of board.c will be compiled for SPL whereas 
> it currently is compiled only for proper.
> 
> This means we need to be careful about what's in board.c.
> 
> Most IS_ENABLED(CONFIG_<config>) should probably be changed to 
> CONFIG_IS_ENABLED(<config>) so that it handles SPL symbols too and 
> doesn't attempt to build stuff for SPL when only proper symbols are 
> selected (and not their SPL counterpart).
> 
> E.g.
> 
> - EFI_PARTITION
> - SYS_DCACHE_OFF
> - USB_GADGET
> - DM_USB_GADGET
> 
> seems to have SPL symbols too, but
> 
> - EFI_HAVE_CAPSULE_SUPPORT
> - ROCKCHIP_USB2_PHY
> - FASTBOOT
> - MISC_INIT_R
> - ROCKCHIP_EFUSE (though does only build for proper (see the use of 
> $(XPL_) in Makefile))
> - ROCKCHIP_OTP (though does only build for proper (see the use of 
> $(XPL_) in Makefile))
> - BOARD_RNG_SEED
> - RNG_ROCKCHIP
> 
> only have proper symbols.
> 
> Maybe it makes more sense to move the efi-specific part of board.c into 
> efi.c and build that one whenever we actually need it?
> 
> What do you think?

I fully agree, please move the efi-specific parts away from board.c.

In current state it is only the rock-pi-4c-rk3399 target that have use
of set_dfu_alt_info(), rockchip_capsule_update_board_setup() is broken
for rock-pi-4-rk3399, the code check for radxa,rockpi4b, and board
target use radxa,rockpi4a :-)

Regards,
Jonas

> 
> Cheers,
> Quentin

