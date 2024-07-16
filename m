Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E70C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 02:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBEAA88755;
	Tue, 16 Jul 2024 04:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F47A8880F; Tue, 16 Jul 2024 04:24:56 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 934B18870C
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 04:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpsz11t1721096675t8fouw
X-QQ-Originating-IP: li1TQBPuv9h3gF3W+NV6AmC3o67FyzEKmsdKnagess8=
Received: from [192.168.159.131] ( [106.150.157.243])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 16 Jul 2024 10:24:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2372899476574021798
Message-ID: <AF48B32FC86879A8+5f4d883b-964e-48ba-a9b6-39d4595eb557@radxa.com>
Date: Tue, 16 Jul 2024 11:24:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: include cru_rk3588.h and define rockchip_cru
 for RK3588
To: Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu
References: <20240618193044.22666-1-naoki@radxa.com>
 <a33b10ea-a0d1-4d33-a0d7-a7a34bcd6ffb@rock-chips.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <a33b10ea-a0d1-4d33-a0d7-a7a34bcd6ffb@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
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

hi

On 6/19/24 05:39, FUKAUMI Naoki wrote:
 > sorry,
 >
 > On 6/19/24 05:29, FUKAUMI Naoki wrote:
 >> Hello,
 >>
 >> this happens only if HOSTCC=clang. I can see several other errors on
 >> several other targets with HOSTCC=clang.
 >
 > ^this happens only if clang is used at make foo-bar_defconfig stage.
 >
 > it seems
 >
 > make foo-bar_defconfig
 > make HOSTCC=clang CC=clang all
 >
 > works.
 >
 >> CC=clang seems to be fine.
 >>
 >> Best regards,
 >>
 >> --
 >> FUKAUMI Naoki
 >> Radxa Computer (Shenzhen) Co., Ltd.

should I check/make patches for other RK3xxx targets?
or should I avoid to use clang for defconfig?

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 7/16/24 11:09, Kever Yang wrote:
> 
> On 2024/6/19 03:30, FUKAUMI Naoki wrote:
>> fix following error found by clang:
>>
>>    CC      arch/arm/mach-rockchip/cpu-info.o
>> arch/arm/mach-rockchip/cpu-info.c:23:13: error: incomplete definition 
>> of type 'struct rockchip_cru'
>>     23 |         switch (cru->glb_rst_st) {
>>        |                 ~~~^
>> ./arch/arm/include/asm/arch-rockchip/clock.h:181:8: note: forward 
>> declaration of 'struct rockchip_cru'
>>    181 | struct rockchip_cru;
>>        |        ^
>> 1 error generated.
>>
>> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> 
> Thanks,
> - Kever
>> ---
>>   arch/arm/include/asm/arch-rockchip/cru.h        | 2 ++
>>   arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/arch-rockchip/cru.h 
>> b/arch/arm/include/asm/arch-rockchip/cru.h
>> index 9778790f34..c3259b8e7c 100644
>> --- a/arch/arm/include/asm/arch-rockchip/cru.h
>> +++ b/arch/arm/include/asm/arch-rockchip/cru.h
>> @@ -17,6 +17,8 @@
>>   # include <asm/arch-rockchip/cru_rk3399.h>
>>   #elif defined(CONFIG_ROCKCHIP_RK3568)
>>   #include <asm/arch-rockchip/cru_rk3568.h>
>> +#elif defined(CONFIG_ROCKCHIP_RK3588)
>> +#include <asm/arch-rockchip/cru_rk3588.h>
>>   #endif
>>   /* CRU_GLB_RST_ST */
>> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h 
>> b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
>> index a0e54d3965..dad484813f 100644
>> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
>> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
>> @@ -92,6 +92,8 @@ struct rk3588_cru {
>>       unsigned int pmuclkgate_con[9]; /* Address Offset: 0x0100 */
>>   };
>> +#define rockchip_cru rk3588_cru
>> +
>>   check_member(rk3588_cru, mode_con00, 0x280);
>>   check_member(rk3588_cru, pmuclksel_con[1], 0x30304);
> 
