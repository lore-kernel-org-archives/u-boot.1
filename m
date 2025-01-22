Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B45DC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 14:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80ED68083F;
	Wed, 22 Jan 2025 15:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737556363;
	bh=xbFn8DttEcbPGsEva0TKqXoMTx10/J0P1axmI0el3O8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XtFws107jJA1i5umoKey7wbx1Hvs1E/WJWmL8Uez5FwYx79MBPqo2uBdCt2QZedcz
	 ZgoUYdcEgLLCZzqZz2x/Vej7chYr5UJBctswUIHWRu3zBYokR8pTmKPq5pV0I1h+Zi
	 J30KloibOPNueiAoiIBGquQFVKa8XN27eXPQxvDJ3+SeBixsrzPI8o1jrkDyk64h0C
	 ZOPTEpGe/L84L9Uygf53ii8/4kQkGtTDvXsXBksjWoi4NPe1v2+RT/O2AxIKVavTLY
	 blQSS8y5IEfyXpObGJSzvqwTgcvKruirRXO/6o9Lpr522wIDdoQWyLVSeAB1ulneyO
	 Ai5A9rgLKlRRg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6732880843; Wed, 22 Jan 2025 15:32:42 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE198083E
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 15:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="SCpQpqoV"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 716D91048B8EB; Wed, 22 Jan 2025 15:32:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737556359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xbFn8DttEcbPGsEva0TKqXoMTx10/J0P1axmI0el3O8=;
 b=SCpQpqoVJ28+wHBeeBweP4wLnhDvlta+hcYOF+4fr4nfPVJYNuwSePDHvX5NRRkG2o8G6H
 A7laMi7j4YKH0NcQp4leL8f2tvhgb935jq2DAJL+xh21t9vTAezSX/aqRw3GzXWhcZc1Wk
 oyetSDtA+sOnW/xtUdc/GAoU0RDPqZ0D0touecNUlpSWr/FuxVpB1PPJ+1wU3CGwY7KJiV
 oOJFpJxbLFRzdGQpO//l123rZDbi7kMR1/dkBpTQUV2BSqrqTblzJ8qnlrt4mMleNDGXw/
 Y8GFOxjsA3gHM6+oe4fvCjn41HCCOjbM5msWVTvceekjWAAa+6w/NqjjACXVEg==
Message-ID: <d973c75a-5b54-42aa-b68f-dcf45f8b3144@denx.de>
Date: Wed, 22 Jan 2025 15:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] image: apply FDTOs on FDT image node without a load
 property
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20250122-extlinux-relocate-dtb-when-dtbo-v3-1-46bef4eac720@cherry.de>
 <ee42f531-0084-467e-86e5-3c16a8c90cb4@cherry.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ee42f531-0084-467e-86e5-3c16a8c90cb4@cherry.de>
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

On 1/22/25 3:21 PM, Quentin Schulz wrote:

[...]

>> @@ -2395,17 +2395,18 @@ int boot_get_fdt_fit(struct bootm_headers 
>> *images, ulong addr,
>>       /* we need to apply overlays */
>>   #ifdef CONFIG_OF_LIBFDT_OVERLAY
>> -    image_start = addr;
>> -    image_end = addr + fit_get_size(fit);
>> -    /* verify that relocation took place by load address not being in 
>> fit */
>> -    if (load >= image_start && load < image_end) {
>> -        /* check is simplified; fit load checks for overlaps */
>> -        printf("Overlayed FDT requires relocation\n");
>> +    /* Relocate FDT so resizing does not overwrite other data in FIT. */
>> +    of_flat_tree = map_sysmem(load, len);
>> +    len = ALIGN(fdt_totalsize(load), SZ_4K);
>> +    err = boot_relocate_fdt(&of_flat_tree, &len);
> 
> My bad, I mistakenly "compile-tested" this with a defconfig that doesn't 
> enable CONFIG_OF_LIBFDT_OVERLAY so this was never built.
> 
> The compiler is actually not happy about that, it wants it cast to (char 
> **).
> 
> @Marek, what do you prefer? We go back to having of_flat_tree a char* or 
> do the cast in boot_relocate_fdt?
What about -- go back and add a code comment ?

btw. please try and clip the response using [...] so you won't be 
quoting a wall of useless text each time. The actual response is then 
hard to find in it.
