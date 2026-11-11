Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F05B606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HahMvTxg;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=K21VkQWm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08083607D0;
	Wed, 11 Nov 2026 18:08:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8cci37YzauRU; Wed, 11 Nov 2026 18:08:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 11BE660774
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794420531;
	b=BmfIUWE+tfNyTdft3m/dVeUXXJWAaZQofcCNNhmSG2LwWeaRC9v8ddmlcGLhT+pzGOfz
	 a6I92PAuO/J1Y985PkISJk/6/P12rl/Yzmd/09f1skNYkDOty7V47EAeP4HkEZSEO+AVp
	 /N588l6H4bLHPkF6HA3KBbQU/u6Tva7pk1lDGUFb2P7P8nfBTHxGcZ+XydMa+ogt75Beh
	 PUOpt5Cabw2XNuiLnFOsCrwIj7NqnMlbMf/E3A0KWvqi0NTKq7Od6WENb7O2FoNHe2XiI
	 3DFhZweZaunbD8ohHHUQlcOhu6gqyawT2MO/Sd/mRi2zejlLYw/BKELGNHRbQXnLEUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794420531;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=o5IcHoQtofodd0wPACPIzFRRdsyKRfPYrPNYcesA7Ak=;
	b=J7iAAhg+sm0KFvQuDj+ooHjyiR7uCTrLHeS4i7y80JG1RiX1OlvdyWthS/OQYnK+qRX2
	 yJ4RfYNKYIp3ldUGKCKbmNnmBu1qeIJpZmRk+tkcxmxxY5qV/iomBFpC6F06dVnUaBUH4
	 6ACNnyQlkQyMzs7w88tszMrycM90l7koGIAy0JC7yn/jPE04P+9L0pGrsz99IX6W8rc/A
	 B8uE3wo2E/tAUa2dsTMvjPuNqfWIXaxsN/78GJeJP8JR135lGjDU5PeKONWJN8/+TofmK
	 +GCRP8ZKihMhg2QnLG7I+BNj43mrC+SSTNXx0ahqY+hRtOb1VVEyHxD5AcNBsR4FEXA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794420531;
	bh=o5IcHoQtofodd0wPACPIzFRRdsyKRfPYrPNYcesA7Ak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HahMvTxgM8q3CZcLDUJ08hIhp9Amti3CNYJEDbeTK5MNMMPFbefZWyFt9u0tDmvtb
	 Hpfa4jtzuR2A8+RBdGpBRViw42QSc+MaLYiqoTZaDZhiq2SLXWQrEx5QNHur2vml9C
	 jY5JarS0gcf7N+nCHken/IdrABLlbTpnHgZXnS7UhShxB60D6AFYdih3sSSELlDP6b
	 t9/KQSCZrNwg7HLyzrzfZGuJr+p2gE9fY6eLIpiT+qNux06Eq++UdxLkJf4wj2czIj
	 ul1eu8xW9KQwMzEOR1Sy2zr5952DJFTVuyhqDxmrRJy+IuRTGmBjGS+RczZLwXj5Cj
	 Z5sNS5oCemdvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11BE660774;
	Wed, 11 Nov 2026 18:08:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 025C5F22
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 18:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC6D84007E
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 18:08:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UVXMtKLF7tvI for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 18:08:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 65CE440060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:d548::42ad"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:d548::42ad; helo=smtp-42ad.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=K21VkQWm
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::42ad])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 65CE440060
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 18:08:47 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPs3015T3zNk7;
 Wed, 11 Nov 2026 19:08:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794420524;
 bh=o5IcHoQtofodd0wPACPIzFRRdsyKRfPYrPNYcesA7Ak=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=K21VkQWmMa6NdJfiyYe9HFAEpgCH26y1BZneZoln4TmPHFnWL4BgY2W68ogTdSro8
 GConMnnM8hlspuglKJqZKakkTpoiIoG7+S3haG1UWXJh1FeqzU8HmJ9yqiW7oiL+ok
 rJjS54nHeuMZq71rG3R1Kwa0m9Dgr2BeT7nZJYFnjmo3Mb9UoOt5Pg/VTaqWsAhIlV
 gyaq5KuUmOGS9HY0ZoWoXjLBvfesmeMgcNJQksbhIR/PEaeA++P/5n77XWLvXCFogS
 FAYQEeZ2ecf+AErkKxzlwgYjeQt/w0t5QGPWZDkYoBCNwELrGINPn3uugmmfg473kf
 L1tH+o4iVPyAw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jPs2y603tzlWd; Wed, 11 Nov 2026 19:08:42 +0100 (CET)
Message-ID: <cfb5d923-8148-4087-a090-a20077a4a627@0leil.net>
Date: Wed, 11 Nov 2026 19:08:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] ram: rockchip: px30: allow multiple SDRAM types
 selection
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Joseph Chen <chenjh@rock-chips.com>,
 Tom Rini <trini@konsulko.com>
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
 <20261025-ddr-multi-v2-2-b82ff9c860ba@gmail.com>
 <a10d5dd9-ecdd-44e2-acce-8cb33501adec@0leil.net>
 <CAC928Hanm2_mSEo3vuLnDQnHZ9uXTbV9pMmHfhXne7H3ONor=A@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <CAC928Hanm2_mSEo3vuLnDQnHZ9uXTbV9pMmHfhXne7H3ONor=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/26 6:55 PM, Massimo Pegorer wrote:
> Hi Quentin,
> 
> Il giorno mer 11 nov 2026 alle ore 16:41 Quentin Schulz ha scritto:
>>
>> Hi Massimo, Joseph,
>>
>> On 10/25/26 8:30 PM, Massimo Pegorer wrote:
>>> Allow the inclusion of more than one SDRAM parameters set in the PX30
>>> sdram driver. The driver applies included sets in alphabetical order
>>> (DDR3, DDR4, LPDDR2, LPDDR3), stopping at the first one that makes
>>> SDRAM initialization function to complete with success. This order is
>>> debatable and not based on any specific reason.
>>>
>>> Due to limited PX30 TPL maximum size, including support for more than
>>> one SDRAM type can require disabling some configuration options such
>>> as CONFIG_RAM_ROCKCHIP_DEBUG.
>>>
>>
>> @Joseph, can you help us out here?
>>
>> We are trying to do the same thing that px30_ddr_333MHz_v*.bin from
>> Rockchip's rkbin is doing: do DDR initialization without knowing which
>> kind of DDR is soldered on the PX30-based device. Is there something
>> special we need to do or know? For now, we are trying to initialize with
>> DDR3 first, then DDR4 if it fails, then LPDDR2 if that fails too, then
>> LPDDR3 if all fails. The first DDR init that doesn't fail is deemed
>> successful. I do not know if this is correct, can you please provide
>> some guidance?
>>
>>> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>>> ---
>>>    drivers/ram/rockchip/sdram_px30.c | 40 +++++++++++++++++----------------------
>>>    1 file changed, 17 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
>>> index c7ff924b2c5..7f51b9c4f8f 100644
>>> --- a/drivers/ram/rockchip/sdram_px30.c
>>> +++ b/drivers/ram/rockchip/sdram_px30.c
>>> @@ -123,27 +123,24 @@ u32 addrmap[][8] = {
>>>
>>>    struct dram_info dram_info;
>>>
>>> -#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3) + \
>>> -     IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4) + \
>>> -     IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2) + \
>>> -     IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3) > 1
>>> -#error "This driver only supports one DRAM configuration at a time"
>>> -#endif
>>> -
>>>    struct px30_sdram_params sdram_configs[] = {
>>>    #if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3)
>>>    #include    "sdram-px30-ddr3-detect-333.inc"
>>> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
>>> +#endif
>>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
>>>    #include    "sdram-px30-ddr4-detect-333.inc"
>>> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
>>> +#endif
>>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
>>>    #include    "sdram-px30-lpddr2-detect-333.inc"
>>> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
>>> +#endif
>>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
>>>    #include    "sdram-px30-lpddr3-detect-333.inc"
>>> -#else
>>> -#error "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP option"
>>>    #endif
>>>    };
>>>
>>> +static_assert(ARRAY_SIZE(sdram_configs) > 0,
>>> +           "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP options");
>>> +
>>>    struct ddr_phy_skew skew = {
>>>    #include    "sdram-px30-ddr_skew.inc"
>>>    };
>>> @@ -691,19 +688,11 @@ out:
>>>        return ret;
>>>    }
>>>
>>> -struct px30_sdram_params
>>> -             *get_default_sdram_config(void)
>>> -{
>>> -     sdram_configs[0].skew = &skew;
>>> -
>>> -     return &sdram_configs[0];
>>> -}
>>> -
>>>    /* return: 0 = success, other = fail */
>>>    int sdram_init(void)
>>>    {
>>>        struct px30_sdram_params *sdram_params;
>>> -     int ret = 0;
>>> +     int ret = 1;
>>
>> @Massimo: question: why the need to change ret to 1?
>>
>> Because the driver enforces sdram_configs array to be non-empty, we're
>> guaranteed to do at least one loop and thus ret is guaranteed to be set
>> properly.
> 
> You are right, the static assert guarantees ret to be set at least once.
> 
> For variables - and logic in general - which are in the local scope, I'm used
> to rely as little as possible on conditions and assumptions out of that local
> scope. But I respect different opinions and approaches, so if you prefer I can
> drop the initialization at all, or restore the zero init.
> 

Up to you, but if you keep a change to ret, have it at least -1 so it 
obviously shows when reading that an error is expected to be returned by 
default.

You can also check if not setting ret doesn't actually save you some 
bytes in the final binary.

suggestion: Maybe:

	for (int i = 0; i < ARRAY_SIZE(sdram_configs); i++) {
		sdram_configs[i].skew = &skew;
		sdram_params = &sdram_configs[i];
		if(sdram_init_detect(&dram_info, sdram_params))
			continue;

		sdram_print_ddr_info(&sdram_params->ch.cap_info, &sdram_params->base, 0);
		return 0;
	}

	return -1;
}

can make the binary even smaller without the need for the ret variable 
at all and removes a bunch of if conditions/jumps and is also valid 
without the static_assert on the sdram_configs array.

thought: I'm also not sure why we have a global dram_info? If it's not 
needed, then we can have it as a function-local variable in sdram_init 
and initialized in one go:

struct dram_info dram_info = {
	.phy = (void *)DDR_PHY_BASE_ADDR,
	.pctl = [...]
};

if it needs to be global, we can still initialize it in one go and avoid 
the multiple assignments in sdram_init.

> By the way, in the original code, which is the need to init ret to zero? In that
> case, there is a local scope evidence and guarantee that it will be set before
> using.
> 

Yeah, let's agree we've got a lot of unused and non-optimal code in 
U-Boot for Rockchip boards :) We can always improve :)

Cheers,
Quentin
