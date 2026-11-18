Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4D606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HOKZ5xCX;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=GNeNNQ33
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3A9340807;
	Wed, 18 Nov 2026 07:11:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cYqtsCMzXGtA; Wed, 18 Nov 2026 07:11:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7ECD4407FF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794985918;
	b=FGyJydSCjEeP1y9mjMhX98Ne/BYekHBBcHS4tkdN0HvHkuH0uPAkn1C6/8mLLiK8fffl
	 UYikHpcXI335aC6zb91bc5qM9F4zWHXH/9mNU7KtY1ngCA3QQeAZhUJNQ+ma0Zns6f03L
	 l82JOuWTsb2GLn4aCsZzzUgUyXjGshkGN89T+jqWGPh/sT/1n0u+wzsc7brERQ5qrr7dw
	 8G33MSil4vqYxizi+nIOjoxN2pIIDOGdZkKLu56hKF096jJHujUzNp8Hv5j0d7Wqwuqvr
	 odJMU3VLeJrxm6eGF3qwoJj8cZ2QA8I4MJEIDFdLVJAQ2xRazWL2nuROpUxdeIRffIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794985918;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=35BEuwuptUuqJhm97acAizspGK2hwGXZXJ+ULUzcVl8=;
	b=f6J5HweYQ2MGhKdcSRieYIQTY1ffnCXTeh0dZhSGo2+TEt65zLLkqsdOfdllkLimLFYo
	 Wpx9hQrMbmbwa0pWrp6MIx9GQ7HWpDW8MX+CWVuadL0Qb9mObStkt/1kN8DKU3pcCtqQU
	 HLl3FfT7dgNmKiETYKpFFebM6pvotXItST8n+K711zM6z07/25188k6W8fSlOfwGr55q7
	 sA4/0o1My0AYLBUAwmhmWrhroEkBsWzLx3aISjpyauRhMzu4Yek0kxRJgeBf0QIRYlD3d
	 sSPxhLLoVDJoYQyKLJ/GQ618gjNEwRaU/XnxRdF+jkflMf3z1V9UBucfaz9dwwGMszg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794985918;
	bh=35BEuwuptUuqJhm97acAizspGK2hwGXZXJ+ULUzcVl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HOKZ5xCXBy98QM1MyBzCQ2t04Hp1F2A+abiEP2R19bpriGFML/kEXaloht3du0kiE
	 S2/K6d22O1SQnSgkNcSTIpaFZ+6tOkKh4ARRxVWYTdlg25KUbcut8UvSTaU79QzKUl
	 B+3Qrq1NuSRwF6wMfwbI892DpOMsZofz3ukduIhd0mWf0DRuvGxwuYo7NGZZmoYz7y
	 iLRSgCAFk3l1ohYMB8Zb4vT4nFVbHKxcA4PXvENXMe98yqSwnQfYU8cs/Heml+2Sqi
	 8PiWQRNTcamwiKT168tYT+1+wvVyHjOQf9MOd5ex3Rsg2pV1VjrN+t4MWHZWoYd7ad
	 mcIxLzS/IyYvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7ECD4407FF;
	Wed, 18 Nov 2026 07:11:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D9CA91E7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:11:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9B04400A7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:11:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5S1AHkSsRNLD for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 07:11:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 047C94005D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=210.79.60.68
X-Greylist: delayed 307 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 18 Nov 2026 07:11:54 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=rock-chips.com header.i=@rock-chips.com
 header.a=rsa-sha256 header.s=default header.b=GNeNNQ33
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=210.79.60.68;
 helo=mail-m6068.netease.com; envelope-from=chenjh@rock-chips.com;
 receiver=<UNKNOWN> 
Received: from mail-m6068.netease.com (mail-m6068.netease.com [210.79.60.68])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 047C94005D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:11:52 +0000 (UTC)
Received: from [172.16.12.163] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 551a0303f;
 Wed, 18 Nov 2026 15:06:39 +0800 (GMT+08:00)
Message-ID: <bcfaf696-2aad-4528-9fff-e909c0254b0c@rock-chips.com>
Date: Wed, 18 Nov 2026 15:06:37 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] ram: rockchip: px30: allow multiple SDRAM types
 selection
Content-Language: en-US
To: Quentin Schulz <u-boot@0leil.net>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
 <20261025-ddr-multi-v2-2-b82ff9c860ba@gmail.com>
 <a10d5dd9-ecdd-44e2-acce-8cb33501adec@0leil.net>
From: Joseph Chen <chenjh@rock-chips.com>
In-Reply-To: <a10d5dd9-ecdd-44e2-acce-8cb33501adec@0leil.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1ed7aa1d503aakunmd0dd24f92e464a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHkgeVhhCGUkZTkhNTk1OT1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=GNeNNQ33JjnR8pU/Z4IQJYQhLo7q4aVDAtrRa5rLhJ97xohJ0Qb1g8HfeSup+xBHIJP70XmhewVu422wO4OXZzgxEbh3vfR7qa2agzDd4dwJvmu/HP5fECA4YCAtaxrXPI4S80C76Wxx5a7E7+PEo6TUQHAFJifz8KxxWzBBArE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=35BEuwuptUuqJhm97acAizspGK2hwGXZXJ+ULUzcVl8=;
 h=date:mime-version:subject:message-id:from;
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

Hi Quentin,

在 2026-11-11 23:41, Quentin Schulz 写道:
> Hi Massimo, Joseph,
>
> On 10/25/26 8:30 PM, Massimo Pegorer wrote:
>> Allow the inclusion of more than one SDRAM parameters set in the PX30
>> sdram driver. The driver applies included sets in alphabetical order
>> (DDR3, DDR4, LPDDR2, LPDDR3), stopping at the first one that makes
>> SDRAM initialization function to complete with success. This order is
>> debatable and not based on any specific reason.
>>
>> Due to limited PX30 TPL maximum size, including support for more than
>> one SDRAM type can require disabling some configuration options such
>> as CONFIG_RAM_ROCKCHIP_DEBUG.
>>
>
> @Joseph, can you help us out here?
>
> We are trying to do the same thing that px30_ddr_333MHz_v*.bin from 
> Rockchip's rkbin is doing: do DDR initialization without knowing which 
> kind of DDR is soldered on the PX30-based device. Is there something 
> special we need to do or know? For now, we are trying to initialize 
> with DDR3 first, then DDR4 if it fails, then LPDDR2 if that fails too, 
> then LPDDR3 if all fails. The first DDR init that doesn't fail is 
> deemed successful. I do not know if this is correct, can you please 
> provide some guidance?

Sorry, I can't offer much guidance on this topic.

>
>> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>> ---
>>   drivers/ram/rockchip/sdram_px30.c | 40 
>> +++++++++++++++++----------------------
>>   1 file changed, 17 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/ram/rockchip/sdram_px30.c 
>> b/drivers/ram/rockchip/sdram_px30.c
>> index c7ff924b2c5..7f51b9c4f8f 100644
>> --- a/drivers/ram/rockchip/sdram_px30.c
>> +++ b/drivers/ram/rockchip/sdram_px30.c
>> @@ -123,27 +123,24 @@ u32 addrmap[][8] = {
>>     struct dram_info dram_info;
>>   -#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3) + \
>> -    IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4) + \
>> -    IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2) + \
>> -    IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3) > 1
>> -#error "This driver only supports one DRAM configuration at a time"
>> -#endif
>> -
>>   struct px30_sdram_params sdram_configs[] = {
>>   #if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3)
>>   #include    "sdram-px30-ddr3-detect-333.inc"
>> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
>> +#endif
>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
>>   #include    "sdram-px30-ddr4-detect-333.inc"
>> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
>> +#endif
>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
>>   #include    "sdram-px30-lpddr2-detect-333.inc"
>> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
>> +#endif
>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
>>   #include    "sdram-px30-lpddr3-detect-333.inc"
>> -#else
>> -#error "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP option"
>>   #endif
>>   };
>>   +static_assert(ARRAY_SIZE(sdram_configs) > 0,
>> +          "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP 
>> options");
>> +
>>   struct ddr_phy_skew skew = {
>>   #include    "sdram-px30-ddr_skew.inc"
>>   };
>> @@ -691,19 +688,11 @@ out:
>>       return ret;
>>   }
>>   -struct px30_sdram_params
>> -        *get_default_sdram_config(void)
>> -{
>> -    sdram_configs[0].skew = &skew;
>> -
>> -    return &sdram_configs[0];
>> -}
>> -
>>   /* return: 0 = success, other = fail */
>>   int sdram_init(void)
>>   {
>>       struct px30_sdram_params *sdram_params;
>> -    int ret = 0;
>> +    int ret = 1;
>
> @Massimo: question: why the need to change ret to 1?
>
> Because the driver enforces sdram_configs array to be non-empty, we're 
> guaranteed to do at least one loop and thus ret is guaranteed to be 
> set properly.
>
> Cheers,
> Quentin

-- 
Best regards,

陈健洪 (Joseph Chen)
chenjh@rock-chips.com
福州瑞芯微电子股份有限公司
Fuzhou Rockchip Electronics Co.Ltd
福建省福州市铜盘路软件大道89号软件园A区17号楼 (350003)
No. 17 Building, A District, No.89,software Boulevard Fuzhou,Fujian,PRC
TEL：0591-83991906/07-8573


