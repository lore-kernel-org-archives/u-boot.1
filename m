Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14FBC48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F330D87EF3;
	Mon, 12 Feb 2024 14:55:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="wlFLETmH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E88687F00; Mon, 12 Feb 2024 14:55:08 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6911E87EEC
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:54:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707746098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HoWKIiO6JGvCdoMyLc79AbJ788Cgq/zHj5LJEknuzoY=;
 b=wlFLETmHzLY7K8qIcRZHsAojUNFrEl0OOZ2PlHSDKvNf6DFzuHskq3vk2P0oWPsd0xJDfC
 1qFbzlnEex/57VP9lCD+KpO21RtgqK+N6tp4rMY/m09GOY/bVLm7S2x2YK8TT1CgvH80je
 JXLeUbBTZc9c/4VrtFnQxDU+/YilxMHf1GaaeMNu1RBAwHE+7t86i4F0bp9GLyeks+55n5
 b9H4kYDGW2rSojTC0FjeZtLPGJp+UT+RAO3d23EkpXrUO/5hCIW+nFCxqvYK3sp9HEsJ10
 MvR6rk8THQi2u3YP0q42D07PUBQof97TH/lTEGF5jGPQhnh43OzLBOv2oqxyqA==
Date: Mon, 12 Feb 2024 14:54:57 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, Klaus
 Goger <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Otavio Salvador <otavio@ossystems.com.br>, Andy
 Yan <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin
 <agust@denx.de>, u-boot@lists.denx.de, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH v2 04/20] rockchip: pine64: pinebook-pro: migrate to
 rockchip_early_misc_init_r
In-Reply-To: <CALeDE9NSsp7j2nmFJvPrK9CxhGM1wKcR0ZnRfSy02kFSYwVW6Q@mail.gmail.com>
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
 <20240209-jaguar-v2-4-6c9ffe09b924@theobroma-systems.com>
 <CALeDE9NSsp7j2nmFJvPrK9CxhGM1wKcR0ZnRfSy02kFSYwVW6Q@mail.gmail.com>
Message-ID: <92c918f160c275b712a50e5ebd3ebdf4@manjaro.org>
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

Hello Peter,

On 2024-02-12 14:41, Peter Robinson wrote:
> On Fri, 9 Feb 2024 at 09:50, Quentin Schulz <foss+uboot@0leil.net> 
> wrote:
>> 
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
> 
> The Pinebook Pro doesn't have onboard ethernet, nor an alias defined,
> I wonder if rockchip_setup_macaddr should be gated on GMAC_ROCKCHIP or
> something similar. Otherwise:

It's the same with the Pinephone Pro, plus we've got the Pinephone,
the PineTab, and the "OG" Pinebook with no Ethernet interfaces.  I've
already prepares patches that gate out the redundant code, and I'll
send them over after a bit more testing.

> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> 
>> Cc: Quentin Schulz <foss+uboot@0leil.net>
>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> ---
>>  board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c | 18 
>> ++----------------
>>  1 file changed, 2 insertions(+), 16 deletions(-)
>> 
>> diff --git a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c 
>> b/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
>> index 4ad780767ea..2408a367305 100644
>> --- a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
>> +++ b/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
>> @@ -11,7 +11,6 @@
>>  #include <asm/arch-rockchip/clock.h>
>>  #include <asm/arch-rockchip/grf_rk3399.h>
>>  #include <asm/arch-rockchip/hardware.h>
>> -#include <asm/arch-rockchip/misc.h>
>>  #include <linux/printk.h>
>>  #include <power/regulator.h>
>> 
>> @@ -54,23 +53,10 @@ static void setup_iodomain(void)
>>         rk_setreg(&pmugrf->soc_con0, 1 << PMUGRF_CON0_VSEL_SHIFT);
>>  }
>> 
>> -int misc_init_r(void)
>> +int rockchip_early_misc_init_r(void)
>>  {
>> -       const u32 cpuid_offset = 0x7;
>> -       const u32 cpuid_length = 0x10;
>> -       u8 cpuid[cpuid_length];
>> -       int ret;
>> -
>>         setup_iodomain();
>> 
>> -       ret = rockchip_cpuid_from_efuse(cpuid_offset, cpuid_length, 
>> cpuid);
>> -       if (ret)
>> -               return ret;
>> -
>> -       ret = rockchip_cpuid_set(cpuid, cpuid_length);
>> -       if (ret)
>> -               return ret;
>> -
>> -       return ret;
>> +       return 0;
>>  }
>>  #endif
>> 
>> --
>> 2.43.0
>> 
