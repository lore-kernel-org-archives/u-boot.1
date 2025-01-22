Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1901EC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 15:45:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B43680805;
	Wed, 22 Jan 2025 16:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737560738;
	bh=vxsFZbohy0NlPghsbBsP9MO8xLnmRZh6phElueDP2SE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bviZ3HyoioGmS8vnhn7RmsHJHlw+ZOZuIr7Bpe7WS8YbENSGzbY262VCe50ooaITO
	 yqmWAIKZK0hGXEyaNG7XIKODDElPkyozlCyvna3sPuPRbxcq1R1WlgQFDhobdq/TU8
	 nh++yy4FUBjZCN1QZnbnpLIs18xCQnfVuud+R6rCGy/Azeq2tdw/0h5+Kg9+Y0Wal1
	 L+8LLaxO4xoV2dsJtV3fczWG6fJkvO9tNIt1YTQYl84l3xC3HcnHLm+9I5bKEV2KQZ
	 hZLtMCShTWHCsxadMPsPkq49chlRNGVE/ASjCj9ZU7jv68T8PzLLDuqYqn24ftgE2D
	 LuWwuP4mCArNw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7436C80805; Wed, 22 Jan 2025 16:45:37 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52BA4807EC
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 16:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="KW6y6gSf"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 481E71048AF56; Wed, 22 Jan 2025 16:45:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737560734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vxsFZbohy0NlPghsbBsP9MO8xLnmRZh6phElueDP2SE=;
 b=KW6y6gSfne9Oqx/zHUnrk8LmoO34dEKL1xuq12vtz6d+a4SQpCCli9dbXDVQ/RFNrlCZ1g
 KLn9lftgDxJTlfxdwUrheMV1XscOD50J9VtSe/kDJwUn2syCyJdc+W9+RLGpXJiWyhj3tf
 1QyeYQPCn56QXwXoTnu+QQqZJxlCiumZwkZiyQvmHfZ5eOk0coAdLsOLp4JOe6fuy8Ubg1
 f+LOYGV4m2DCxw0sREsLTHAniFFEr4oAq24nCIYyw/ukwR8m2MPQVDG40rluAOG8lSDvft
 lu8UP6/LscSPavqtC4gTUZ6E1w4BpC7rD3qLIyCzGeBm2ig1M/KdzkGE6EKjpg==
Message-ID: <3531f8a6-0ce2-415d-acb7-bf76ef812741@denx.de>
Date: Wed, 22 Jan 2025 16:45:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] image: apply FDTOs on FDT image node without a load
 property
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20250122-extlinux-relocate-dtb-when-dtbo-v3-1-46bef4eac720@cherry.de>
 <ee42f531-0084-467e-86e5-3c16a8c90cb4@cherry.de>
 <d973c75a-5b54-42aa-b68f-dcf45f8b3144@denx.de>
 <ec967669-a715-4f16-854a-958607df13b8@cherry.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ec967669-a715-4f16-854a-958607df13b8@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/22/25 4:43 PM, Quentin Schulz wrote:
> Hi Marek,
> 
> On 1/22/25 3:32 PM, Marek Vasut wrote:
>> On 1/22/25 3:21 PM, Quentin Schulz wrote:
>>
>> [...]
>>
>>>> @@ -2395,17 +2395,18 @@ int boot_get_fdt_fit(struct bootm_headers 
>>>> *images, ulong addr,
>>>>       /* we need to apply overlays */
>>>>   #ifdef CONFIG_OF_LIBFDT_OVERLAY
>>>> -    image_start = addr;
>>>> -    image_end = addr + fit_get_size(fit);
>>>> -    /* verify that relocation took place by load address not being 
>>>> in fit */
>>>> -    if (load >= image_start && load < image_end) {
>>>> -        /* check is simplified; fit load checks for overlaps */
>>>> -        printf("Overlayed FDT requires relocation\n");
>>>> +    /* Relocate FDT so resizing does not overwrite other data in 
>>>> FIT. */
>>>> +    of_flat_tree = map_sysmem(load, len);
>>>> +    len = ALIGN(fdt_totalsize(load), SZ_4K);
>>>> +    err = boot_relocate_fdt(&of_flat_tree, &len);
>>>
>>> My bad, I mistakenly "compile-tested" this with a defconfig that 
>>> doesn't enable CONFIG_OF_LIBFDT_OVERLAY so this was never built.
>>>
>>> The compiler is actually not happy about that, it wants it cast to 
>>> (char **).
>>>
>>> @Marek, what do you prefer? We go back to having of_flat_tree a char* 
>>> or do the cast in boot_relocate_fdt?
>> What about -- go back and add a code comment ?
>>
> 
> Not entirely sure to understand the kind of comment you'd like to see 
> there?
> 
> Would something like:
> 
> // of_flat_tree is storing the void * returned by map_sysmem, then
> // its address is passed to boot_relocate_fdt which expects a char **
> // and it is then cast into a ulong. Setting its type to void * would
> // require to cast its address to char ** when passing it to
> // boot_relocate_fdt. Instead, let's be lazy and use void *.
> 
> work for you?
Something like that , yes .
