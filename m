Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C67610A88C3
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 15:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 998FD81E18;
	Thu, 26 Mar 2026 16:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qwUnInac";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E7F83E76; Thu, 26 Mar 2026 16:15:46 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B0D580517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 16:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43a03cb1df9so995155f8f.1
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774538144; x=1775142944; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DzBrqiqa2HFsC3XmMz014TrD7Qub7bTPx295ka9bbX0=;
 b=qwUnInac+XjDhp912Ductc6xyTwZWHO3frAomms1r65uX1/by5lssIJw4+N79oi7ke
 BanI3tV7J0p7yzopVE0SBwZQcHqBbJvsEK2fp79cj/CuvqPL9MsL7dkrzXgHRCzdsm96
 6zPaAofPlOxzTI1MR+P5OLtRhkZzXos1GlzZ9pBtJD/BLXeY8VnNOVVAUr3eDJ4JGqG8
 P8UUdv/rGTsqTrvsAi66e84QANA/OUy7xvo6z4AYY5kLzg4m8mXbuhYoH9ENmQjdICYC
 5i56NeLSapju7qV1ciz4z1cM9xriE8slUaUsNFMp7hj8BsHyCX0zDqdABnlCH/i3j3fE
 90Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774538144; x=1775142944;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DzBrqiqa2HFsC3XmMz014TrD7Qub7bTPx295ka9bbX0=;
 b=RIuiBFALUfkGlZjMOX0DUaoKmBcFIuivWmVq9bRvaSxKFECgkSpeFdBk7Pi2u7DB8K
 oSkpQk7D3OKJPktt+jg5EYhIA1dQXlw/E0m6TlHxwFcDE23UtndNVv7Zkzobz/++Z5Tn
 MltA+zoB+RWrvMbvnOiZu0bbMv+9dNZJfjVbkavmYPLfVZtgY5+dikOwg+KQmEbEEDOK
 ueSUJgRoXZhQajmWNl05F5wd6tBFzOEEZLNq2Ee/5WXgXmzJlz8UTv+zThRHc7MC1FUr
 Wc4Ndmau/sxnRUqZHmOWGQQHr5l7p0B3cbh1DJaswOVwzy1IUdkyKHisZt2pXoyOszLv
 JkIg==
X-Gm-Message-State: AOJu0Yx0o0uYfUPsvm7IPvOC/O02VVdI74wRc1OKnO/r1TZfDc5vwBau
 jdF1wWyELB5i/wS0bXxCyvuKzoU686l8nMTkZoV1s4wAFj2ZioIBH93481MoqlFbuos=
X-Gm-Gg: ATEYQzykp3dV1kmJJpr6grcvNMl7Jg2aQoomi4H3pK6ZA6jWnIx3mSTELet0Dokbvqj
 65lwMhzx82JGMgm7rbo8ZgNk1St0nzfAwIAgWQ1GTuRPUFor5OxAZFVaH0XxbjXvVvvjO0uf0ZL
 Cq3Vv1HlzvXO12Iqk2emzFf83gnr8W3WFfbSJBSjJDphXiZif7dngMMCyhhcDL84jIMwH+jjFhF
 QDrXZW9cmy4bCI28Sf2vS7fTRB5GpkNK0mSC1yr4MLy5eAKe7+FwDhAnDNMl5WUiLlKF67F8+Nm
 R3GnzlFqpevOJeIkUpBh3MMSpaCjlx2TjK4EyYmybzZ2+mUKFs/0U+TfmRD5++4kEaxK4/YUuiO
 EBkkBBxZI5nI+fzhitUGjgMfsvKIhc3FUprdh12dUcHE0n+tVSIsLH/k0a7UloLUu+JS3aT9Qo+
 zkZV0ws/DyU3jnXiVTJrKBwgVl0uOmSBc4D8bxc/AG/yXfmU779nWys7I0pM8B9qk=
X-Received: by 2002:a5d:6708:0:b0:43b:998c:d82b with SMTP id
 ffacd0b85a97d-43b998cd88dmr1461541f8f.19.1774538143466; 
 Thu, 26 Mar 2026 08:15:43 -0700 (PDT)
Received: from [192.168.1.36] (p5b29eb0d.dip0.t-ipconnect.de. [91.41.235.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b9179b212sm8766711f8f.0.2026.03.26.08.15.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 08:15:43 -0700 (PDT)
Message-ID: <297cff44-ab4f-486e-b546-426468f50968@linaro.org>
Date: Thu, 26 Mar 2026 16:15:42 +0100
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

I don't think so, more likely mmu_map_region() is doing an ALIGN_DOWN()
somewhere.

Luca: I think you should do ALIGN(plat->size, SZ_4K) and assert that
plat->stat is 4k aligned as well (or at least WARN if it's not). That
will round up the size 0xa932c0 to 0xa94000.

> 
> On Qcom platforms, the default memory map strategy is to map the overall
> DRAM space without excluding reserved reqions. One can exclude reserved
> regions in a SoC specific manner here [1] but it adds some runtime
> overhead. Give it a try for Milos as well in case it resolves your
> issue.
> 
> I think we still need to revisit that reserved memory strategy where
> default should rather be we unmap the reserved regions.
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

