Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B50AFF8870
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 06:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1AA083BC4;
	Tue, 28 Apr 2026 08:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="T3V6EV5n";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BLdo5oug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CFCC84106; Tue, 28 Apr 2026 08:43:29 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D560583A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 08:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g4W9B4R8Vz9t5q;
 Tue, 28 Apr 2026 08:43:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777358606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibhsGCeU5eGB28izotD6Ztecdmf3SFtLQQGeswBvRKU=;
 b=T3V6EV5n818GiZpiNssKvZzFRTn6k8IL1woJKRH4mb6IA5pTgWhlkeGQWzVaHTc0+6L7lu
 njQew1khYq7JSeZ/L0661NdZzq5S+U5TItX6EZFqGWfy7d87vNdsuE9gNJzYbRPIwDoQKw
 qP0/zC5YUjfuvSUI9E+JFG8b1ByUlKV9bQAsZRH2QrCl33zK4EjiOYdZx/mrKDD6DSwRXQ
 g1sGf2KUpALHCwtDc5ni1z21x6uGwQF6kv+/X9jgiqAyHPTsw2mIW4fK5nLfp8BdmU2Uy1
 XC3FYeL2lLL6M+auea0Cp9FVSVXplUu5nWBTg+M011Lpazcjke/zsEYIUJtYIA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=BLdo5oug;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <73312691-c9a1-45a6-be3d-232949432b60@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777358605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibhsGCeU5eGB28izotD6Ztecdmf3SFtLQQGeswBvRKU=;
 b=BLdo5ougqUjK4iz5brEj/+COyD3kw63Ab8x7FSIE55AtLq6/er6M5sG1WBdG8cK3TqarhP
 oo6uLTfv1Eacwj/posNM4z5TnAyTuE7C0R7gMRTEfS65xfji7uw8OiGqqR9ajc/mercCc2
 M2Gaz+AkXMx90Gh76A2TDeGAUl7+J6oxJTWDgJn7vuAKgOMHsyEGgDjh0EEWJh4Q5Si6oi
 3E/VlBTKhw4VvJ0BuDBTshmWw8+ofiGo0sy6S49WeEclsCbPZx4Q7Khipl0GmK319FLEcs
 gNXTWoJsmpskePRKe0krdpeLCy/sMUR4fpTrlw4tMGgXh80II204jYFP/Cmi8g==
Date: Mon, 27 Apr 2026 19:32:47 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 6/6] common: Add an option to relocate on ram top
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se,
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
 <20260416055948.130041-7-ilias.apalodimas@linaro.org>
 <6944f28f-131f-4a08-9ef9-aae812926f4b@mailbox.org>
 <CAC_iWj+ufWdroVDCh9qNAYfsjON5r_pdfOUgyB=h=b2b_rMVKg@mail.gmail.com>
 <8b87df2b-1904-4f2c-862d-924daff649e6@mailbox.org>
 <CAC_iWj+1PNaGjX5DH3hA4iednKruydKjy-0YoXuWTCJHmPVCDA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWj+1PNaGjX5DH3hA4iednKruydKjy-0YoXuWTCJHmPVCDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ra8xi4hgir4j4w8y938ai7jqs5hohr6o
X-MBO-RS-ID: 54042bce9bcb0cf60e8
X-Rspamd-Queue-Id: 4g4W9B4R8Vz9t5q
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

On 4/27/26 4:33 PM, Ilias Apalodimas wrote:

[...]

>>>>> +++ b/common/board_f.c
>>>>> @@ -339,7 +339,22 @@ static int setup_ram_base(void)
>>>>>     static int setup_ram_config(void)
>>>>>     {
>>>>>         debug("Monitor len: %08x\n", gd->mon_len);
>>>>> -#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
>>>>> +
>>>>> +     if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
>>>>> +             int bank;
>>>>> +             phys_size_t total_size = 0;
>>>>> +
>>>>> +             for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
>>>>> +                     if (gd->ram_top <= gd->bi_dram[bank].start)
>>>>> +                             gd->ram_top = gd->bi_dram[bank].start +
>>>>> +                                             gd->bi_dram[bank].size;
>>>>> +                     total_size += gd->bi_dram[bank].size;
>>>>> +             }
>>>>> +             gd->ram_size = total_size;
>>>>
>>>> Shouldn't this also apply board_get_usable_ram_top() to be consistent ?
>>>
>>> Simon asked the same thing. I'd rather keep this option strict for now
>>> and always relocate to the upper memory boundary fnor now. Once I do
>>> further cleanups, I can either add it or remove the function entirely
>>> since dram_init_banksize() (which hs also board specific) runs really
>>> early now.
>>
>> Maybe the default board_get_usable_ram_top() can return the ram top if
>> CONFIG_IS_ENABLED(RELOC_ADDR_TOP) ? That would still allow users to use
>> board_get_usable_ram_top() consistently to reduce the ram top.
> 
> dram_init_banksize() can be used instead now to reduce that and we can
> remove this option eventually. Is there anything that we can't achieve
> with only that ?
I think I might be confused, but it seems board_get_usable_ram_top() is 
used to set gd->ram_top , which is U-Boot's top of RAM and may not be 
the same as physical top of RAM . So no, dram_init_banksize() has to 
configure the correct physical RAM topology, board_get_usable_ram_top() 
can be used to make space at ram_top unavailable to U-Boot .
