Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84CDC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 04:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 137D182D21;
	Tue, 29 Jul 2025 06:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RuqtZuxM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B708582EB8; Tue, 29 Jul 2025 06:05:40 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6819482CFA
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 06:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4brhb40x0bz9v21;
 Tue, 29 Jul 2025 06:05:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753761936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aj1dOQ4ua2z23v1Y8NcJmxy1NMWZrb1IT3QjrOBQbGA=;
 b=RuqtZuxMoqm/nODPwDu96kj1aX68DaDqjkS+gueWbUo03ig29qP5tn0Fkd9/el3PGnz42T
 Q9UK4iXBfDiKZeCDgSjMijqTmABCpL9R5v6HnOg7a+O0qNxMzJ97gXc8MuQEaK0WddRfzo
 cKRaJby0xAUax0Ki7+qzii761asGXsuMwXKlIUF5KkUKdEeIIC8/GSr2B4ZlbzyZspQ+pN
 zYNeesgXmmFvhWANWyU10tEHj2P1R6JXy0k5GCwep8SsNj9OvyaFCaZJ9ufmsWSXcBntK+
 b//rziDbY4ERqpMet/Zd05DFI+0Xof5JlfSw5yjhKBFpFgYhwjFVp/rqvipcyw==
Message-ID: <7211233b-a1dd-489a-82fb-73e2d5dbb0cf@mailbox.org>
Date: Tue, 29 Jul 2025 06:05:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 01/10] ARM: stm32: Add STM32MP13xx SPL Kconfig options
From: Marek Vasut <marek.vasut@mailbox.org>
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Cc: Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20250512172149.150214-1-marek.vasut@mailbox.org>
 <20250512172149.150214-2-marek.vasut@mailbox.org>
 <ce033305-387b-4732-a711-5a4a9f4237e3@foss.st.com>
 <43ba9ad2-e2df-44e3-9bc0-1b7e343ff1b3@mailbox.org>
Content-Language: en-US
In-Reply-To: <43ba9ad2-e2df-44e3-9bc0-1b7e343ff1b3@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b4c558be054278b064c
X-MBO-RS-META: 5nzdeqsaage6k9xaih847ff4mobbhd3q
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

On 6/29/25 9:08 PM, Marek Vasut wrote:

Hi,

>>> diff --git a/arch/arm/mach-stm32mp/Kconfig.13x b/arch/arm/mach- 
>>> stm32mp/Kconfig.13x
>>> index bc8b3f8cf77..cecf9e3b8c7 100644
>>> --- a/arch/arm/mach-stm32mp/Kconfig.13x
>>> +++ b/arch/arm/mach-stm32mp/Kconfig.13x
>>> @@ -20,7 +20,8 @@ config TARGET_ST_STM32MP13X
>>>   endchoice
>>>   config TEXT_BASE
>>> -    default 0xC0000000
>>> +    default 0xC0000000 if TFABOOT
>>> +    default 0xC0100000 if !TFABOOT
>>>   config PRE_CON_BUF_ADDR
>>>       default 0xC0800000
>>
>>
>> I don't understood  why you modify TEXT_BASE here.
> Loading of data to the very beginning of DRAM may fail in case the data 
> are wrapped in various container image types, because the image loader 
> in SPL may use the area before the data load address to load for example 
> image header(s) in there. This is one example of such header loading, 
> which is triggered on STM32MP13xx in SPL:
> 
> https://source.denx.de/u-boot/u-boot/-/blob/master/include/spl_load.h#L18
> 
> "
>   18         struct legacy_img_hdr *header =
>   19                 spl_get_load_buffer(-sizeof(*header), 
> sizeof(*header));
>   20         ulong base_offset, image_offset, overhead;
>   21         int read, ret;
>   22
>   23         log_debug("\nloading hdr from %lx to %p\n", (ulong)offset, 
> header);
>   24         read = info->read(info, offset, ALIGN(sizeof(*header),
>   25 spl_get_bl_len(info)), header);
> "
> 
> The header is loaded at CONFIG_TEXT_BASE - sizeof(*header). If 
> CONFIG_TEXT_BASE is start of DRAM with no usable memory right below it 
> AND sizeof(*header) is non-zero, then this loading will fail.
> 
> That's why the TEXT_BASE is shifted a bit higher in this patch.

Any news on this series ? It would be good to move this along.

-- 
Best regards,
Marek Vasut

