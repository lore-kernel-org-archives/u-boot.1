Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92499CDE00B
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 22:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA31084894;
	Fri, 26 Jun 2026 00:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Qtdbs//1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 325A88495B; Fri, 26 Jun 2026 00:16:48 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37835847C3
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 00:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3A8AA1159C3; Fri, 26 Jun 2026 00:16:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782425805;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=RIDgihSZQPOalPp9AT5wGHELq1kb0TtUxgcLI+/XeeQ=;
 b=Qtdbs//1djA85CsUktcL+lsaZPqtbI0lpIko8JFU71ZAzh/7RmpFYxWCF56c2eTcGgD4mM
 EiWlXhR3zEvh7Hfk4HiyMLunOj3L94+ViiHesT/ZsDrsGk3+trcfEEz40chTOTBF3rIsJ/
 uNzN5yMzrIf0LGgFkCrUrfEan4LnTUtBoIkvCHaIJbcS8SjD2YKxkQVEQuFx2twBQJlsvJ
 n00xrvnhfLLUkiwGNTeTx8zzlawGWF/syoKymPVqHGKv0km/im4VS+q9M5ozXJ57HABWsC
 TPoNvEqqjyRNCfxSMs8Kwaj20IfZERq+X5fV8Pt1nJEs1P74A0LltVeMTOC+8w==
Message-ID: <bf804b49-55fd-4bfc-9898-2265dfad95d7@nabladev.com>
Date: Thu, 25 Jun 2026 14:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stm32mp1: use debug() for image entry point message
To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Sean Nyekjaer <sean@geanix.com>, Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de
References: <20260618092921.3702970-1-sean@geanix.com>
 <4e7b14fd-da00-42d5-9221-719313eecfab@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <4e7b14fd-da00-42d5-9221-719313eecfab@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/25/26 8:31 AM, Patrice CHOTARD wrote:
> 
> 
> On 6/18/26 11:29, Sean Nyekjaer wrote:
>> The stm32mp1 specific code prints the image entry point unconditionally
>> before jumping to the next-stage image, unlike the generic SPL
>> implementation in common/spl/spl.c.
>>
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> ---
>>   arch/arm/mach-stm32mp/stm32mp1/cpu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> index 252aef1852e..ea5d8a648df 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> @@ -361,7 +361,7 @@ void __noreturn jump_to_image(struct spl_image_info *spl_image)
>>   	image_entry_stm32_t image_entry =
>>   		(image_entry_stm32_t)spl_image->entry_point;
>>   
>> -	printf("image entry point: 0x%lx\n", spl_image->entry_point);
>> +	debug("image entry point: 0x%lx\n", spl_image->entry_point);
>>   	image_entry(romapi);
>>   }
>>   #endif
> 
> + Marek, as he is the author of the path which brang jump_to_image()
> 
> Personally i don't mind of usage either printk() or debug().
> Marek, what do you prefer ?
debug() is fine, thanks !
