Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869DFC48286
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 04:02:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E017387C2F;
	Thu,  1 Feb 2024 05:02:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="ItdWgWYd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C561C87C44; Thu,  1 Feb 2024 05:02:54 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACA8887C2F
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 05:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1706760171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0u50TFohILISQ4GZwmOPsVo9WTgv+8iVVpZkAdYpV/Q=;
 b=ItdWgWYdkzNM4ltsUlqf5/TFgkch1dzSjMTNBEKtQPRPxBjNlntBY6WXbu9WXOfBzXES9k
 w3sHsWJjF43X5ZQY6oT8dAhvGXkdk3+DcG+9dp0ZVd0U07sua6wgV1tuynnhfY5tCNs9C8
 cyQBd4lq4Z0Gcm6PdtZvY5GeG9Do4OxmsToLKibg+8PiUB2miii2cwUgCTzyamr+i2WHeg
 AcUH8vFmELjrejWj4nsVMSJdR6Zpf6BjB+GV50P7kVMz82Yz28esjSXuGEy8pmldDWkXoW
 A6J5W2usTxWq6OPIX3anDoXHw8zOcqix2eNPvtouoxgiLd08fKNuRxzd2Qjp8A==
Date: Thu, 01 Feb 2024 05:02:48 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Peter Robinson
 <pbrobinson@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Otavio Salvador <otavio@ossystems.com.br>, Andy
 Yan <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin
 <agust@denx.de>, heiko@sntech.de, u-boot@lists.denx.de, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 06/18] rockchip: pine64: pinebook: migrate to
 rockchip_early_misc_init_r
In-Reply-To: <86f059d7-c2db-4b23-bc50-0317c70efdae@rock-chips.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-6-1eec1c34953c@theobroma-systems.com>
 <86f059d7-c2db-4b23-bc50-0317c70efdae@rock-chips.com>
Message-ID: <ef680bb049878ca5b97a2a257c918db2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Kever and Quentin,

On 2024-02-01 03:48, Kever Yang wrote:
> On 2024/1/23 22:49, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> 
>> Compared to the original misc_init_r from Rockchip mach code,
>> setup_iodomain() is added and rockchip_setup_macaddr() is not called.
>> 
>> It is assumed adding rockchip_setup_macaddr() back is fine.
>> Let's use rockchip_early_misc_init_r instead of reimplementing the 
>> whole
>> misc_init_r from Rockchip (the side effect being that
>> rockchip_setup_macaddr() is back).

We might actually introduce some issues with this change.  I'll get
back later with a more detailed explanation, together with a proposed
fix, after I check it all in detail.

This applies to some other patches in this series as well.

>> Cc: Quentin Schulz <foss+uboot@0leil.net>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> 
> Thanks,
> - Kever
>> ---
>>   board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c | 18 
>> ++----------------
>>   1 file changed, 2 insertions(+), 16 deletions(-)
>> 
>> diff --git a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c 
>> b/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
>> index 4ad780767ea..2408a367305 100644
>> --- a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
>> +++ b/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
>> @@ -11,7 +11,6 @@
>>   #include <asm/arch-rockchip/clock.h>
>>   #include <asm/arch-rockchip/grf_rk3399.h>
>>   #include <asm/arch-rockchip/hardware.h>
>> -#include <asm/arch-rockchip/misc.h>
>>   #include <linux/printk.h>
>>   #include <power/regulator.h>
>>   @@ -54,23 +53,10 @@ static void setup_iodomain(void)
>>   	rk_setreg(&pmugrf->soc_con0, 1 << PMUGRF_CON0_VSEL_SHIFT);
>>   }
>>   -int misc_init_r(void)
>> +int rockchip_early_misc_init_r(void)
>>   {
>> -	const u32 cpuid_offset = 0x7;
>> -	const u32 cpuid_length = 0x10;
>> -	u8 cpuid[cpuid_length];
>> -	int ret;
>> -
>>   	setup_iodomain();
>>   -	ret = rockchip_cpuid_from_efuse(cpuid_offset, cpuid_length, 
>> cpuid);
>> -	if (ret)
>> -		return ret;
>> -
>> -	ret = rockchip_cpuid_set(cpuid, cpuid_length);
>> -	if (ret)
>> -		return ret;
>> -
>> -	return ret;
>> +	return 0;
>>   }
>>   #endif
>> 
