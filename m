Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD41CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 08:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B572863F3;
	Wed, 18 Oct 2023 10:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697616149;
	bh=COeXQzItZwgYlmXJqazYcr6NKjgvZPG9brhX1o55GNY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BZV4yHFaXHUND6/7Bvjobu+3Fk4O7UBv+2XTtWWBc2M0ScZY9a1SeKdt5KZA0vqs9
	 41zaxPhNyqfw+GD9KfXx/yvzRenwK/w/sveME+5Udqr+uTS0gdWqKhPZqZNZNBRZ4D
	 qghThy4Pz5MHOquSZ7yupmilPWWUt+hAd8uWzuQrKq2y8Hlz921PdP7Hv4YklVfUH6
	 fb3SDYBt/Cx1nt5qy3JdqrhAKUbFeorAuiySjq369v2c3z+7OjL/BAiXLGNso5FMpE
	 QWYuH5Kqb0kb7m/mFm7dxd7h5RN097htkLio37nZqX+wqIpchlev7yXTJ8ayurwAMJ
	 qORiDXm+/E9cA==
Received: from [IPV6:2001:a61:6040:2801:a606:8537:48c7:bbf0] (unknown
 [IPv6:2001:a61:6040:2801:a606:8537:48c7:bbf0])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: sbabic@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2FC5C85DE0;
 Wed, 18 Oct 2023 10:02:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697616148;
 bh=COeXQzItZwgYlmXJqazYcr6NKjgvZPG9brhX1o55GNY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Y+nahNdzyRhZkoyZ3ErQTvOCcLEFMIzoS4TtNimuHp+KnJpIBgXHHfB1E9FyUl1KV
 Uh2LZItCuIy/jQ811r45bYEGH/b0rQ7I9se7XO0SXiiky+nCgIcG8bLqedD9TG64gh
 P+7pYPJPR35wiQMDa88HoOrv1yiGuZdbcOogDP7qXt3wCxha8/rWdcg5+o5i2zahVY
 KThbkqGQoo3klPUxWqd+rw64x4PxCm3CerKQ5NlDXd3ZhQCxUwRfRUAVpM5lOhwBal
 VhdGDUAGBMdyRt0kX91w0BNDoG/GUTKWYxEdZONHBrq9OGIjkkGaroMBeQn43Pgbxp
 ScKhKFCSz9jIw==
Message-ID: <480a02b7-6a76-4727-8b27-0da9d12e6478@denx.de>
Date: Wed, 18 Oct 2023 10:02:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mxs: Clear CPSR V bit to activate low vectors
Content-Language: de-DE
To: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>
References: <20230729133010.8660-1-marex@denx.de> <20230731100615.22850307@wsk>
From: Stefano Babic <sbabic@denx.de>
In-Reply-To: <20230731100615.22850307@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Marek, Lukasz,

On 31.07.23 10:06, Lukasz Majewski wrote:
> On Sat, 29 Jul 2023 15:30:10 +0200
> Marek Vasut <marex@denx.de> wrote:
> 
>> The MXS starts with CPSR V bit set, which makes the CPU jump to high
>> vectors in case of an exception. Those high vectors are located at
>> 0xffff0000, which is where the BootROM exception table is located as
>> well. U-Boot should handle exceptions on its own using its own
>> exception handling code, which is located at 0x0, i.e. at low
>> vectors. Clear the CPSR V bit, so that the CPU would jump to low
>> vectors on exception instead, and therefore run the U-Boot exception
>> handling code.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
>> Cc: Fabio Estevam <festevam@gmail.com>
>> Cc: Lukasz Majewski <lukma@denx.de>
>> Cc: Stefano Babic <sbabic@denx.de>
>> ---
>>   arch/arm/cpu/arm926ejs/mxs/mxs.c      | 3 +++
>>   arch/arm/cpu/arm926ejs/mxs/spl_boot.c | 4 ++++
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/cpu/arm926ejs/mxs/mxs.c
>> b/arch/arm/cpu/arm926ejs/mxs/mxs.c index 4d21e3df76e..d64a8328b04
>> 100644 --- a/arch/arm/cpu/arm926ejs/mxs/mxs.c
>> +++ b/arch/arm/cpu/arm926ejs/mxs/mxs.c
>> @@ -85,6 +85,9 @@ void mx28_fixup_vt(uint32_t start_addr)
>>   		/* cppcheck-suppress nullPointer */
>>   		vt[i + 8] = start_addr + (4 * i);
>>   	}
>> +
>> +	/* Make sure ARM core points to low vectors */
>> +	set_cr(get_cr() & ~CR_V);
>>   }
>>   
>>   #ifdef	CONFIG_ARCH_MISC_INIT
>> diff --git a/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
>> b/arch/arm/cpu/arm926ejs/mxs/spl_boot.c index
>> 5598c552ab9..4a7dfc6a2ae 100644 ---
>> a/arch/arm/cpu/arm926ejs/mxs/spl_boot.c +++
>> b/arch/arm/cpu/arm926ejs/mxs/spl_boot.c @@ -17,6 +17,7 @@
>>   #include <asm/arch/sys_proto.h>
>>   #include <asm/gpio.h>
>>   #include <asm/sections.h>
>> +#include <asm/system.h>
>>   #include <linux/compiler.h>
>>   
>>   #include "mxs_init.h"
>> @@ -104,6 +105,9 @@ static void mxs_spl_fixup_vectors(void)
>>   
>>   	/* cppcheck-suppress nullPointer */
>>   	memcpy(0x0, &_start, 0x60);
>> +
>> +	/* Make sure ARM core points to low vectors */
>> +	set_cr(get_cr() & ~CR_V);
>>   }
>>   
>>   static void mxs_spl_console_init(void)
> 
> Reviewed-by: Lukasz Majewski <lukma@denx.de>
> 

Thanks for raising my attention to this older patch, but it breaks 
exaclty the xea board:

+{standard input}: Assembler messages:
+{standard input}:214: Error: selected processor does not support `mrc 
p15,0,r3,c1,c0,0' in Thumb mode
+{standard input}:249: Error: selected processor does not support `mcr 
p15,0,r3,c1,c0,0' in Thumb mode
+{standard input}:157: Error: selected processor does not support `mrc 
p15,0,r3,c1,c0,0' in Thumb mode
+{standard input}:188: Error: selected processor does not support `mcr 
p15,0,r3,c1,c0,0' in Thumb mode

Can you check it ?

Regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================

