Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E16606A880
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EC8DvkLV;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=CitrWJwU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12ED28122F;
	Wed, 11 Nov 2026 16:09:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a_tqaYq3CstR; Wed, 11 Nov 2026 16:09:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D2C2081216
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794413343;
	b=rE3o+++89iwT4wWLUQTWSoVCIaDlaLphL+anXuYh5kPsrl94i9EG2D2uQbX+mVw1dRgb
	 CycCTeji0VI4ESk82PMsyJEXmR0d3Nw6gMPjYaSw3kF09ya0ee2Kcg+EeHUZFfliFhtTB
	 euDXbBPffK19FK7YzhB7urzKVE8v4OZf+LzCiRWa+zby0NNnpXClDu50v0OzebOGlef7u
	 EXaZpTYpe+oWjnjc0ipQougqodz/rmn6/849ZzJptpBMVctWQOkwRJ6APoV/RkTgB7SdE
	 2smm6LLVnJj397FttH7HNQLrqUKyEO4ygMfKL6UKxnpwx1wI/hg/E8JfQs7TWXRmtQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794413343;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IBHrB9IFSX2QotUvUyYy7ggcabp0vcKtXhzJ5p1fjY0=;
	b=daPqHWasVDYq9TsLtL6sZFFK3O1UfAkPEKn/FO7ZTo2vXLtNxWKezy3wmIx1FqfDEzY0
	 hdnZIwfuHc53sE6vF7PZV3I/nix1JUwmiStdx5m9idNOnq4iIwbFHacdINVhg8DfFg228
	 Bs2Kajq4If9K8Yljc1XYa4vVqdwbQeIhydFteYyR8HOXMJNh2/7w8Vb0BhxTGhQ8+aPjM
	 MuWLDeVd6EchGyqy1XJEmxOyyPPlvaUaO94IzRK4TmWO0nJaPkrctcuzSYo6mmg7hC1xa
	 RVo32KpDFC86RA5iPUqMigAZw5auWWtpwc1mXnf4qAElCHbCH70ckavsQw/KJYgSJ2g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794413343;
	bh=IBHrB9IFSX2QotUvUyYy7ggcabp0vcKtXhzJ5p1fjY0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EC8DvkLVSxUG091zA12tl44R6UVqaX8TZgYhFkTor/q5+jotrdZoySLCaSxtYC7dH
	 L0Scvm26kNN32u8nc2VbUlOtqOL0Iaqpjvbvg5iu0njh1nJ9Y4+VswMuWIVuT3A/Zw
	 CbLcU9LCm89PQGQxwsCu88yLW94KXE/yEuj+a9cZErxpHthX8JkZBfnJ0+eIYJpO+W
	 js40zY4EGyyrMlKPV+7R/dkZZec9lid289s+IPQ7klvUXRq2JjFtxd6/DgINyjBJzw
	 CYw6gOJLQ00NtU/7eRl+ov319knP1y9WiQmJh0k3TUz0BetmOsbR3e8+AiEQVSvH1t
	 0VUXL1r9+bvqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2C2081216;
	Wed, 11 Nov 2026 16:09:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A587B2FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:09:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B2984016D
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:09:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6KWyw6TrQfTN for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 16:09:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 349B74006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:8e30::42a9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:8e30::42a9; helo=smtp-42a9.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=CitrWJwU
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::42a9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 349B74006F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:08:59 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPpNn2D7VzcQR;
 Wed, 11 Nov 2026 17:08:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794413337;
 bh=IBHrB9IFSX2QotUvUyYy7ggcabp0vcKtXhzJ5p1fjY0=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=CitrWJwUtf83n+cR8Mf35uDAJ3iMdZmCNTEBB8VSbh2Vi93MCqFgplFxwLc8WVI9+
 v+9G+VCuRHvqiQ7i7qI/xKGaDcvnJ4SMXpO7omcua+UGLkA/eFbNy6JIQ7J4LdpjTa
 quEaIQVVbUEfqPFPyLCvcCN9hglcQtCYFs8tixi6Fdw7WGPOysFVnZn4nz4sJaK8Tv
 uO1E1/sc+sqMA4sPC/sXyAwd+9T8fa/ewc2ZsM7bxRi6H2gtVRbhM2hg+AlT8kuQjl
 6pPHcSOojqgMNM6LWx9LyV4sFr7RpQBrLYTXB6Bm6QwGi1O8b9oS8qPPY8rhgD9Upr
 35p8x2aAYH3dg==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jPpNm2Yg7z2cN; Wed, 11 Nov 2026 17:08:56 +0100 (CET)
Message-ID: <9d263ab1-5880-42d0-afc8-2f2ebdae4a95@0leil.net>
Date: Wed, 11 Nov 2026 17:08:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] ram: rockchip: improve sdram type configs selection
From: Quentin Schulz <u-boot@0leil.net>
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
 <20261025-ddr-multi-v2-1-b82ff9c860ba@gmail.com>
 <1fba6d0c-acac-4495-bdf4-58765efedce0@0leil.net>
Content-Language: en-US
In-Reply-To: <1fba6d0c-acac-4495-bdf4-58765efedce0@0leil.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/26 4:31 PM, Quentin Schulz wrote:
> Hi Massimo,
> 
> On 10/25/26 8:30 PM, Massimo Pegorer wrote:
>> Not all the SDRAM types config options named in the Kconfig are
>> supported by each of the Rockchip SoCs: improve clarity adding SoC
>> dependencies to the options.
>>
>> Add a new RAM_ROCKCHIP_DDR3 option and remove PX30 and RV1126 sdram
>> drivers fallback behaviour when no SDRAM type option is selected,
>> raising a compile time error in this case, instead. The new option
>> has a default true value if no other SDRAM option is true to avoid
>> impacts on defconfigs.
>>
>> Moreover, these drivers support only one SDRAM type at a time: when
>> more options are selected, avoid debatable preemption of one over the
>> others, and raise a compile time error instead.
>>
>> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>> ---
>>   drivers/ram/rockchip/Kconfig        | 24 +++++++++++------
>>   drivers/ram/rockchip/sdram_px30.c   | 17 +++++++++---
>>   drivers/ram/rockchip/sdram_rv1126.c | 54 ++++++++++++++++++++ 
>> +----------------
>>   3 files changed, 60 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
>> index d707d09c1c8..f51ae6a4542 100644
>> --- a/drivers/ram/rockchip/Kconfig
>> +++ b/drivers/ram/rockchip/Kconfig
>> @@ -24,28 +24,36 @@ config RAM_ROCKCHIP_DEBUG
>>         This is an option for developers to understand the ram drivers
>>         initialization, configurations and etc.
>> +config RAM_ROCKCHIP_DDR3
>> +    bool "DDR3 support for Rockchip SoCs"
>> +    depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
>> +    default y if !RAM_ROCKCHIP_DDR4 && !RAM_ROCKCHIP_LPDDR2 && \
>> +        !RAM_ROCKCHIP_LPDDR3 && !RAM_ROCKCHIP_LPDDR4
>> +    help
>> +      Enable DDR3 sdram support on Rockchip SoCs.
>> +
> 
> issue: too much done in one commit
> 
> Please split this into multiple commits. I could identify:
> - add SoC dependency for existing DRAM Kconfig symbols (with the change 
> to the helptext to make it generic)
> - add new DDR3 symbol and gate existing code with it. That is, rv1126 
> and px30 should have their #else for their DDR3 timings gated by this 
> symbol. A new #else can call #error so the build fails in case of 
> incorrect configuration, like you did here,
> - enforce only one selectable DRAM init for PX30 and RV1126,
> 
>>   config RAM_ROCKCHIP_DDR4
>>       bool "DDR4 support for Rockchip SoCs"
>> +    depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
>>       help
>> -      This enables DDR4 sdram support instead of the default DDR3 
>> support
>> -      on Rockchip SoCs.
>> +      Enable DDR4 sdram support on Rockchip SoCs.
>>   config RAM_ROCKCHIP_LPDDR2
>>       bool "LPDDR2 support for Rockchip SoCs"
>> +    depends on ROCKCHIP_PX30
>>       help
>> -      This enables LPDDR2 sdram support instead of the default DDR3 
>> support
>> -      on Rockchip SoCs.
>> +      Enable LPDDR2 sdram support on Rockchip SoCs.
>>   config RAM_ROCKCHIP_LPDDR3
>>       bool "LPDDR3 support for Rockchip SoCs"
>> +    depends on ROCKCHIP_PX30
>>       help
>> -      This enables LPDDR3 sdram support instead of the default DDR3 
>> support
>> -      on Rockchip SoCs.
>> +      Enable LPDDR3 sdram support on Rockchip SoCs.
>>   config RAM_ROCKCHIP_LPDDR4
>> +    depends on ROCKCHIP_RK3399 || ROCKCHIP_RV1126
>>       bool "LPDDR4 support for Rockchip SoCs"
>>       help
>> -      This enables LPDDR4 sdram code support for the platforms based
>> -      on Rockchip SoCs.
>> +      Enable LPDDR4 sdram support on Rockchip SoCs.
> 
> Because I checked, and for future reference:
> 
> PX30 supports LPDDR2/LPDDR3/DDR3/DDR4. Only one selectable at a time 
> currently.
> RK3368 only supports DDR3.
> RK3066 supports DDR3/LPDDR3 but only DDR3 is used (MK808 device, 
> configuration via Device Tree and OF_PLATDATA)
> RK3188 supports DDR3/LPDDR3 but only DDR3 is used (Radxa Rock, 
> configuration via Device Tree and OF_PLATDATA)
> RK322x supports DDR3/LPDDR2/LPDDR3 but only DDR3 is used (RK3229 EVB, 
> configuration via Device Tree and OF_PLATDATA)
> RK3288 supports DDR3/LPDDR3, both used via e.g. Rock Pi N8 (LDDR3) and 
> Rock2 Square (DDR3), configuration via device tree and OF_PLATDATA)
> RK3328 supports DDR3/LPDDR3/DDR4, all used, via e.g. Rock Pi E (DDR3), 
> Rock64 (LPDDR3) and Orange Pi R1S Plus (DDR4).
> RK3399 supports DDR3/LPDDR3/LDDR4, all used, via e.g. Puma (DDR3), Gru 
> Bob (LPDDR3), PinePhone Pro (LPDDR4). Either DDR3/LPDDR3 or LPDDR4, not 
> both. We should check for this in the driver.
> RV1126 supports DDR3/DDR4/LPDDR3/LPDDR4, but no timings for LPDDR3. Only 
> one selectable at a time currently.
> 

And RK3036 only has DDR3 boards supported.

> The common theme though is that they are all configured via Device Tree 
> (via OF_PLATDATA) where the dramtype is hardcoded, and this here would 
> be the first to try to do autodetection of the DRAM and init properly.
> 
>>   endif # RAM_ROCKCHIP
>> diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/ 
>> sdram_px30.c
>> index 37e62120504..c7ff924b2c5 100644
>> --- a/drivers/ram/rockchip/sdram_px30.c
>> +++ b/drivers/ram/rockchip/sdram_px30.c
>> @@ -123,15 +123,24 @@ u32 addrmap[][8] = {
>>   struct dram_info dram_info;
>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3) + \
>> +    IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4) + \
>> +    IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2) + \
>> +    IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3) > 1
>> +#error "This driver only supports one DRAM configuration at a time"
>> +#endif
>> +
>>   struct px30_sdram_params sdram_configs[] = {
>> -#if defined(CONFIG_RAM_ROCKCHIP_DDR4)
>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3)
>> +#include    "sdram-px30-ddr3-detect-333.inc"
>> +#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
>>   #include    "sdram-px30-ddr4-detect-333.inc"
>> -#elif defined(CONFIG_RAM_ROCKCHIP_LPDDR2)
>> +#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
>>   #include    "sdram-px30-lpddr2-detect-333.inc"
>> -#elif defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
>> +#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
> 
> question: what's the benefit to switch defined() to IS_ENABLED?
> 
> It almost made me miss the fact this reorders the DRAM timings array.
> 
> I think the reordering should be made in a separate commit, possibly the 
> one where it's possible to select more than one
> 
> Cheers,
> Quentin

