Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E97BC6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DF2C8814A;
	Tue,  2 Apr 2024 15:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="EZWdzBRG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85B6B8815B; Tue,  2 Apr 2024 15:47:41 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E204D88126
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d8ab=LI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1712065647;
 bh=zOwNOAjwK67wBhQfLdJaBFu5uLbsJ7Dvm/v9XwACeYA=;
 b=EZWdzBRGy/FM6RyXD4JqRAOwcojyprgEOwe2qGioXNDiY5uHJvUsanCKz52mNYG3pYR+Nu1i6
 rJuQUGWbqaEwaTjHBdViGJgl4GWsBHh2z1VsEgNx6rI5Z9n/k3FqLydK7vqRO6qFLgjgXzqGjMO
 aTTQoClC+zmrpSnZiS6fdWKk/diBrhlG/SMPfnJybMQDamsCsxoGC94ar3Ucxj0lONKl0nOqZC8
 tAK0mFpCj9hvQLeGGJQCLkBONxVtuSHuRAV2hiW0uKAtflMcIBbqA7IVfpjmvNfjgWxwmqb6FSM
 AjJIe41PWjf/lFcz40iwPDnwlirWei1M021kGvTVMxOg==
Message-ID: <7fdacbef-cad3-4e87-a3b0-9abd7ef13293@kwiboo.se>
Date: Tue, 2 Apr 2024 15:47:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/31] rockchip: rk3399-ficus: Enable TPL and use common
 bss and stack addr
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-3-jonas@kwiboo.se>
 <2d1ee75c-898e-433a-ba60-37aa532736d6@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <2d1ee75c-898e-433a-ba60-37aa532736d6@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 660c0c6f8f30aa7daaf4d890
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

On 2024-04-02 15:10, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 3/31/24 22:28, Jonas Karlman wrote:
>> The rk3399-ficus board is only using SPL and not TPL+SPL like all other
>> RK3399 boards, chromebook bob/kevin excluded. It does not seem to be any
>> technical reason why this board was left using only SPL.
>>
>> Switch to use TPL+SPL and use common bss and stack addresses to allow
>> for more options to be enabled in a future patch. Also add the missing
>> DEFAULT_FDT_FILE option.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   configs/ficus-rk3399_defconfig | 14 ++------------
>>   1 file changed, 2 insertions(+), 12 deletions(-)
>>
>> diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
>> index 4859042d6b56..3bcd0fd66b91 100644
>> --- a/configs/ficus-rk3399_defconfig
>> +++ b/configs/ficus-rk3399_defconfig
>> @@ -2,32 +2,22 @@ CONFIG_ARM=y
>>   CONFIG_SKIP_LOWLEVEL_INIT=y
>>   CONFIG_COUNTER_FREQUENCY=24000000
>>   CONFIG_ARCH_ROCKCHIP=y
>> -CONFIG_TEXT_BASE=0x00200000
>> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>>   CONFIG_SF_DEFAULT_SPEED=20000000
>>   CONFIG_ENV_OFFSET=0x3F8000
>>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-ficus"
>> -CONFIG_SPL_TEXT_BASE=0xff8c2000
>>   CONFIG_ROCKCHIP_RK3399=y
>> -CONFIG_ROCKCHIP_SPL_RESERVE_IRAM=0x4000
>>   CONFIG_TARGET_ROCK960_RK3399=y
>> -CONFIG_SPL_STACK=0xff8effff
>>   CONFIG_DEBUG_UART_BASE=0xFF1A0000
>>   CONFIG_DEBUG_UART_CLOCK=24000000
>>   CONFIG_SYS_LOAD_ADDR=0x800800
>>   CONFIG_DEBUG_UART=y
>> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-ficus.dtb"
>>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>>   CONFIG_SPL_MAX_SIZE=0x2e000
>>   CONFIG_SPL_PAD_TO=0x7f8000
>> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> -CONFIG_SPL_BSS_START_ADDR=0xff8e0000
>> -CONFIG_SPL_BSS_MAX_SIZE=0x10000
>>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>> -CONFIG_SPL_STACK_R=y
>> -CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x4000
>>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>> +CONFIG_TPL=y
>>   CONFIG_CMD_BOOTZ=y
>>   CONFIG_CMD_GPT=y
>>   CONFIG_CMD_MMC=y
> 
> I think we want to move CONFIG_SPL_STACK to match other RK3399 devices 
> as well?

This patch also drops SPL_SHARES_INIT_SP_ADDR and other bss + stack
related options, so new safe default bss and stack addresses from [1]
is used after this patch.

[1] https://source.denx.de/u-boot/u-boot/-/commit/008ba0d56d002f550570faa76c475290ac72721a

Regards,
Jonas

> 
> Indeed, it is currently set to 0xff8effff which matches the default 
> value for when TPL was NOT enabled. 0x400000 is used for devices with 
> TPL support. c.f. 
> https://source.denx.de/u-boot/u-boot/-/commit/f113d7d3034672de7d074506a05a7055f1f0dcae
> 
> Cheers,
> Quentin

