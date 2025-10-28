Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FA3CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:56:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83713838AE;
	Tue, 28 Oct 2025 17:56:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kNsr/wLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C1FF83893; Tue, 28 Oct 2025 17:56:18 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59168838BB
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b6d5b756284so1329167466b.1
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761670574; x=1762275374; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/+EbiVUpEh+Tyd911vxtIjjQUCHl3/qCbQ/+tmKQJ4g=;
 b=kNsr/wLhXnyi7+Hzxxo8h+5edPBIykRFnJkwjo6BIRazpy76zsDKmQ68uV3JfIwNmk
 vfTjy7dDYbUAgB6de4lF5Op8yNeiVgf9CuGkjdUPCwf69wZntunBiCHZm3OAmaiwVIXa
 6jGKeIRw1eQ6dPKcxDr3UZS294VJwjsJl/bpQfNXWxtUDaUmvOp6d7l22sZ7iC5RF4Ec
 bu7YqXhsBNKscPBpoPeDUvhOojDNwabBZJET6FR/ph1i1l5XFuLMWrIiNpXRf6ATFaKK
 dDI7ZWwRglTpwd3yBDa7mEGfgVoo3DfcJgrHX4RnI2/58krcVAoPxfKhnvuFPOdpaBcb
 iIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761670574; x=1762275374;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/+EbiVUpEh+Tyd911vxtIjjQUCHl3/qCbQ/+tmKQJ4g=;
 b=SThtAiWgXPUNjPRrKvMjktckM+tsOqrvLOQsCxfMSsl1ASECrVoKETFKQB6Y/2WbIr
 ZKO24Knjqpv2cXoQeLJ3YftJHGH6WH23v3tXpg3Z+2qUO6bD+ZmE6ltKZURHa0dWbahM
 VCfjT9nbnOVG9KOHIGl4Q8Nio5rbsBRN/3F0yG2MxM5PRs5OtHi5rjgQtpzuj/XPn4lh
 ZDddnBduoQQqTfY1JpBgD9N8F+H8yInvUmTZZ8/InXyDnCh/ngcTO21b98RggZUvsiJf
 tAAqfAoK+6615s+aM6v2+zrqa3y9385x0i4ikwEZfBC8YJ3j4ALkhk8v/jU/dLiKLM5n
 WVaw==
X-Gm-Message-State: AOJu0YxUMngGwKogZv8PUk0p1QrsqU60HaG/Cd88XqFgcchzgIJL0o0N
 s/uWOyotyN7RpwP6hoXIjS2UVJWOUv88iBFe6PMBw0WtojSuNefr60mi
X-Gm-Gg: ASbGnctBlKHKsmPbCFfc3lm4K7YmzWWnQB3b4GfW2wXn6/Sw2lfNKTTjvCqvpp9q+HW
 AFRcDA1jxOGIuVr1xLhOoaqxFmpL7hVo/fmj+HZSpXYegEyZau+qMVJ3jVStKXVzlTXGmUl9HvZ
 Zl5+aO/1JK4Yf+/+Ut73kYBEEeQXlwVp0XnEYkJQlMyJDfkBpNoFqjIPFbqLzrybl19KFYl7Ufb
 oJiI86h6jtgS6REjcj2SRoYC1o2B4fXQ1Y4D6IaOyqQbKbHcYMfMDqtGo8Mkgn44oLR4a5kNXu0
 pe39U6wSpiREC8fQuoXD6/EfKWmVUuydsR17aiaHpRFOvJeFaAKmE9amMaQ4sqvAoBs0TtzzEVp
 JTU34/RXN20V934XMjueCqvuQbkRT9Y2LPH/FiEzEE+pV6X9izySbqrA4WH7CzSMT+oO8XwCO/W
 5lwGS6vrH3NZFm8gpsOWLl/f+h3gXpqE2t5lWTsZvmSupmpElznOiO/GjpMOXVDVh9b9yj
X-Google-Smtp-Source: AGHT+IG+tv4oP6aeAksSiU5LzTIS03UHb8kbRsNUCKmb0mt8anzhAtzLhDkQZbRT93kqrc5kjqA3nQ==
X-Received: by 2002:a17:907:3d55:b0:b38:6689:b9f5 with SMTP id
 a640c23a62f3a-b6dba4471dcmr463075966b.3.1761670573551; 
 Tue, 28 Oct 2025 09:56:13 -0700 (PDT)
Received: from [10.0.1.60]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853f98adsm1122713666b.49.2025.10.28.09.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 09:56:13 -0700 (PDT)
Message-ID: <7401dee0-7ac6-4280-a934-0881dfbb1b6c@gmail.com>
Date: Tue, 28 Oct 2025 17:56:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH v11 00/11] Add support for dynamic MMU
 configuration
To: Anshul Dalal <anshuld@ti.com>, Francesco Dolcini <francesco@dolcini.it>,
 trini@konsulko.com, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Cc: u-boot@lists.denx.de, d-gole@ti.com, b-padhi@ti.com, vigneshr@ti.com,
 nm@ti.com, robertcnelson@gmail.com, w.egorov@phytec.de,
 francesco.dolcini@toradex.com, ggiordano@phytec.com, m-chawdhry@ti.com,
 afd@ti.com, bb@ti.com, u-kumar1@ti.com, devarsht@ti.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
References: <20251017131540.3636067-1-anshuld@ti.com>
 <20251027165225.GA71553@francesco-nb> <DDTOEZHOH4OK.1ZQ850D6UHD0Z@ti.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <DDTOEZHOH4OK.1ZQ850D6UHD0Z@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 28/10/2025 05:38, Anshul Dalal wrote:
> Hi Francesco,
> 
> On Mon Oct 27, 2025 at 10:22 PM IST, Francesco Dolcini wrote:
>> Hello Anshul,
>>
>> On Fri, Oct 17, 2025 at 06:45:22PM +0530, Anshul Dalal wrote:
>>> Hi all,
>>>
>>> In U-Boot, TI only provides a single memory map for all k3 platforms, this
>>> does not scale for devices where atf and optee lie outside the range 0x80000000
>>> - 0x80080000 and 0x9e780000 - 0xa0000000 respectively.
>>>
>>> There are also issues for devices with < 2GiB of memory (eg am62SiP with 512MiB
>>> of RAM) as the maximum size for the first DRAM bank is hardcoded to 2GiB in the
>>> current memory map. Furthermore the second DRAM bank is mapped even for devices
>>> that only have a single bank.
>>>
>>> Therefore this patch set adds the required functionality to create the MMU table
>>> at runtime based on the device-tree.
>>>
>>> The patch set has been build tested on all effected platforms but boot-tested
>>> only on TI's K3 EVMs, the beagleplay and phytec's phycore-am6* platforms.
>>>
>>> The following effected boards have not been boot tested:
>>>  - verdin-am62
>>
>> it seems that this series introduce a regression on verdin-am62, I have
>> not done a bi-sect yet, but we run daily build of U-Boot master and the
>> regressions seems to have started when this patch series was
>> merged.
>>
>> On verdin-am62 we detect the RAM size at run-time, see
>> board/toradex/verdin-am62/verdin-am62.c:dram_init(), and now we always
>> get 2GiB even for modules with only 512MB or 1024MB of memory.
>>
> 
> This patch series modified the behavior of enable_caches to configure the
> memory map of the device as per the device-tree instead of using a
> static map for all of K3.
> 
> The issue with verdin-am62 seems to be that while you do properly
> configure gd->ram_size in your dram_init, the '/memory' node of the
> device-tree remains unchanged with the outdated 2GiB size.
> 
> You could try updating the fdt's memory size to the correct value in
> dram_init and see if that fixes the problem.
> 
> Regards,
> Anshul
Hello Anshul,

I was bisecting the series, and I can confirm that the commit "mach-k3: map
all banks using mem_map_from_dram_banks" introduces the regression.

Given that initcall_run_f() calls dram_init_banksize(), and after relocation
board_init_r() calls enable_caches() (call stack: board_init_r() ->
initcall_run_r() -> initr_caches() -> enable_caches()), I would expect that
enable_caches() should not override the bank sizes previously configured.
Currently, however, enable_caches() introduces this side effect.

Wouldn’t it make more sense to call fdtdec_setup_memory_banksize() in the
default dram_init_banksize() (in arch/arm/mach-k3/k3-ddr.c) and avoid calling
it again in mem_map_from_dram_banks()?

Regards,
Emanuele


