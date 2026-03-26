Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C2810A88C4
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 15:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1810C81E18;
	Thu, 26 Mar 2026 16:18:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fLOFxPz3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9318283F00; Thu, 26 Mar 2026 16:18:22 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2697D80517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 16:18:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-486fd27754bso10506555e9.3
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 08:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774538298; x=1775143098; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xk7pi8UAdBfI6SJWXvHXus3M21ZVmb2wDvRfF4QCmk8=;
 b=fLOFxPz3DTf9PvQs44ay9yLwNaQJGPap/5AICv3NiWSfyKE/bZN0O6KqxQUFkImt6e
 0WUmxAFrwdhArwc6vs3u2Y7v7XulG0jAQvRbsbRSXriIr57Zrf3m3HTXFWeeNNmhPItN
 JtYc2Og/KJOgCIp06qnC8/zzt7w/qkxNx1krpHSvRaxeWrgboUA96qtViFmEeoziHr3v
 zaRiH5s+eQ2DX4/JvLe3s2N4rv6pSpc6aehW6vJgO8EFarBXl8SIeVg/zqWdG969FNNr
 I9fJ6HpLOhHySbVxvmeQs93TWO+FaIjra/mU5lPPJBS7hFDeqn9RZP+VwipQfC3KtYBB
 ArQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774538298; x=1775143098;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xk7pi8UAdBfI6SJWXvHXus3M21ZVmb2wDvRfF4QCmk8=;
 b=k9PCQCkK46uXqU4EorreDSWDhbOArfOOpWeJw1IirQNft6AfsCwxUhjuj8s/Wj1gvq
 y8UI1DVx7Du31JHecPJ2cwuUW224YKngfT03Zu8GGc9y24GKrlEIDuLBQB0NGPiuDQmv
 OncHNnRWygRdjH119UBA/kWXxnVBiwZENf+qzt4ZhdZyTrgDAF2hYcPId8vIgoUaIRfD
 qGO3M+Ji6Yyl6L0bQ0RMB3Sqs8GPRs0LhJj/ugxRaBSFI7PJidDzlv3VTbeRgJBfrH9Q
 ydYf2ys3USXRCc7rXSxfpcCWCPNUHvyVISxN7M/dacwPd829U6ukoxAgQRtNfNd5iYLx
 u41A==
X-Gm-Message-State: AOJu0YxfRzB/IPFTJALOpEQy1TtufhQZIKXMWIcrwy04K9LhTK6wpyZ7
 EyEmho7hH16ktjuH3t15s1IenUGm8PB+eApjHQ4i+TDxX1ettxt1jIqOsxisvpEPeL8=
X-Gm-Gg: ATEYQzyOVzE5wNFSw7CsYtJaVmic7mAbwPmwasg7cj21Y8nuceIuKevCCoUEwYsup5r
 1M5sEzKh+7yWj9LhsrU9/T33lW4s/RyytXzX3G8FHIwF6aLiejLhf0EHX46hANzZgmUVvkrImWX
 FqXejmZk1SBLKg8b+7dG0QUEZp+PTzCdnWObxFnY+q1cJ8bI6FjAnorDhJyBu+F8Z6Xal42RfCc
 5gEQOitSG7U2gyT4qqtE9AsnmnEsj7naSW6IJUrRD4LkYxCUfKko2V3prcLwOTa2dKfgaeV30R6
 Gkr4poj6He8SyIXEoeoRDCo6Fw6czIE6QiyTI3e3ca28tuJwi2blZQ3TOmaK//H7Ch1nGDGlkJs
 eOFEEjDgUAGfNKSy2W+dy5i2lvEaQhacWTs2fOoQOLGs1f3vS/Pcip7MvS7oj3inuzrPgpBvw+Z
 iTuhh6kXeQzA9Q95gEAAYo79COoPLx/Fp7uLLLhvxyOyrEkfI5aR5sxxM/2Gwk27U=
X-Received: by 2002:a05:600c:6487:b0:486:f9d0:aac8 with SMTP id
 5b1f17b1804b1-48716051c95mr127501425e9.18.1774538298428; 
 Thu, 26 Mar 2026 08:18:18 -0700 (PDT)
Received: from [192.168.1.36] (p5b29eb0d.dip0.t-ipconnect.de. [91.41.235.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c957b9sm67020305e9.8.2026.03.26.08.18.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 08:18:17 -0700 (PDT)
Message-ID: <72c0d063-a70d-4957-b679-bb331c3e7f0d@linaro.org>
Date: Thu, 26 Mar 2026 16:18:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: simplefb: Map framebuffer region on probe on ARM64
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260318-simplefb-map-v1-1-edec1ee81df1@fairphone.com>
 <acIpDkBPdC0DGW8y@sumit-xelite>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <acIpDkBPdC0DGW8y@sumit-xelite>
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



On 24/03/2026 07:02, Sumit Garg wrote:
> Hi Luca,
> 
> On Wed, Mar 18, 2026 at 04:07:17PM +0100, Luca Weiss wrote:
>> The framebuffer buffer might not be mapped on some devices.
>>
>> This is #ifdef'ed for ARM64 since mmu_map_region() is not defined for
>> any other architecture.
> 
> This isn't an appropriate fix to the problem.
> 
>>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>> Map 0x1000 extra due to unknown reason, but otherwise it's not enough
>> and we still get a "Synchronous Abort" when drawing at the bottom of the
>> framebuffer.
>>
>> For milos-fairphone-fp6 the framebuffer is reg=0xe3940000
>> size=0xa932c0 (2484*1116*4).
>>
>> When just calling mmu_map_region with plat->size, then it's crashing at
>> 0xe43d3000 even though everything up to 0xe43d32c0 should be mapped.
>> With size+0x800 (or less) it was also still crashing, only size+0x1000
>> then worked.
>>
>> Possible I just don't know enough about memory mapping things, so
>> suggestions welcome! :)
> 
> This sounds more likely the synchronous aborts caused by cache prefetch
> of nearby reserved memory regions. I see there are some reserved mememory
> regions around the address space you have mentioned on Milos.
> 
> On Qcom platforms, the default memory map strategy is to map the overall
> DRAM space without excluding reserved reqions. One can exclude reserved
> regions in a SoC specific manner here [1] but it adds some runtime
> overhead. Give it a try for Milos as well in case it resolves your
> issue.
> 
> I think we still need to revisit that reserved memory strategy where
> default should rather be we unmap the reserved regions.

I think it would be nice to get dcache enabled with a very basic map and
the livetree built pre-relocation, then when we go to build the full
memory map and switch to it we can add this more complex logic without
introducing a big slowdown. U-Boots MMU code will need further
improvements to do all this properly.

> 
> [1] https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-snapdragon/board.c#L743
> 
> -Sumit
> 
>> ---
>>  drivers/video/simplefb.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
>> index 8d0772d4e51..e144fde697b 100644
>> --- a/drivers/video/simplefb.c
>> +++ b/drivers/video/simplefb.c
>> @@ -9,6 +9,7 @@
>>  #include <log.h>
>>  #include <video.h>
>>  #include <asm/global_data.h>
>> +#include <asm/system.h>
>>  
>>  static int simple_video_probe(struct udevice *dev)
>>  {
>> @@ -37,6 +38,11 @@ static int simple_video_probe(struct udevice *dev)
>>  	plat->base = base;
>>  	plat->size = size;
>>  
>> +#ifdef CONFIG_ARM64
>> +	/* The framebuffer buffer might not be mapped on some devices */
>> +	mmu_map_region((phys_addr_t)plat->base, (phys_addr_t)plat->size + 0x1000, false);
>> +#endif
>> +
>>  	video_set_flush_dcache(dev, true);
>>  
>>  	debug("%s: Query resolution...\n", __func__);
>>
>> ---
>> base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
>> change-id: 20260318-simplefb-map-abb9dba0eed1
>>
>> Best regards,
>> -- 
>> Luca Weiss <luca.weiss@fairphone.com>
>>

-- 
// Casey (she/her)

