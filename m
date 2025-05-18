Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0F8C3ABC9
	for <u-boot@archiver.kernel.org>; Sun, 18 May 2025 15:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E04C780584;
	Sun, 18 May 2025 17:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OsnMvq5J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21E068059D; Sun, 18 May 2025 17:58:41 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2360A8004F
 for <u-boot@lists.denx.de>; Sun, 18 May 2025 17:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4b0lq11Cj0z9ss0;
 Sun, 18 May 2025 17:58:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747583917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oC5jYV8Ql+EFOG8ZwRyrvRtj8QCrA+kYCtt1GRKhNso=;
 b=OsnMvq5JyYKTOrNsQ4H/EkkecgkCM5p9ORsNNPoiN2BJDnCrt34WP2/+1FmY5jzRVyDYKS
 0hBAd1disH1PyfXOzToi2kJSVmFvUbwDDbTPvvpuJbXJH6ItAmybpueSa9qijPZ0+zMRtD
 AmRhoqSLmtqDBGMXn6sXCMOXUXakn16Wp9We74inGSQidx8XVKqWiWQGaQpGyMdUDOP7TP
 n2ISlyUB6GuoOeORPsmihMvfso6ygK3sPUlHgfoqV9fSMspxWhFuQTLdmwK51CWcX3f11Q
 x/JEZef6VHSfACHcN6iENbf86ixnMNXvDY85sz0AGtV6iAGzNFTLUMd0HYnNNg==
Message-ID: <fec4425c-efc3-4297-9d3f-281220ab6faf@mailbox.org>
Date: Sun, 18 May 2025 17:58:35 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] ARM: Align image end to 8 bytes to fit DT alignment
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Edwards <cfsworks@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250512161033.146396-1-marek.vasut@mailbox.org>
 <291de23e-2f9f-4683-90ab-d52cf2dc9d49@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <291de23e-2f9f-4683-90ab-d52cf2dc9d49@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d10dc77f15b6a7ae19b
X-MBO-RS-META: dnn7r7qcsf87ns5dud7p651k4jx9s5wr
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

On 5/12/25 6:50 PM, Quentin Schulz wrote:
> Hi Marek,
> 
> On 5/12/25 6:10 PM, Marek Vasut wrote:
>> Align U-Boot image end to 8 bytes to make sure DT alignment requirement
>> is fulfilled. This fixes a possible failure in fdt_find_separate() in
>> case the U-Boot image is aligned to 4 Bytes and DT is appended at the
>> end at already 8 Byte aligned offset.
>>
>> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
>> ---
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Sam Edwards <cfsworks@gmail.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   arch/arm/cpu/u-boot.lds | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
>> index 817e7a983ae..b2109e03ce3 100644
>> --- a/arch/arm/cpu/u-boot.lds
>> +++ b/arch/arm/cpu/u-boot.lds
>> @@ -153,14 +153,14 @@ SECTIONS
>>           __efi_runtime_rel_stop = .;
>>       }
>> -    . = ALIGN(4);
>> +    . = ALIGN(8);
>>       __image_copy_end = .;
>>       /*
>>        * if CONFIG_USE_ARCH_MEMSET is not selected __bss_end - 
>> __bss_start
>>        * needs to be a multiple of 4 and we overlay .bss with .rel.dyn
>>        */
> 
> While 8 is a multiple of 4, it's now a bit confusing to have this 
> comment just above the following line. Maybe you can update it?
Fixed in V2, thanks for spotting this.
