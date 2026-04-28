Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5183FF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 01:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84C59846C1;
	Wed, 29 Apr 2026 03:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FvR6PY6t";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dL6w6WJR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01A3C846BE; Wed, 29 Apr 2026 03:08:04 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5BC5846AF
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 03:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4g4zgg2ZQ2z9tss;
 Wed, 29 Apr 2026 03:07:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777424879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MK6jSsSSiDrAmIYRxv1zu11sUOzC98C+5NynPTM8JBg=;
 b=FvR6PY6tiO0k+F3K/LLGbmn1So2Gv7YUhi1N2UAfkQATgtJd/mvgi+CE5OHGcgrOys/71m
 p+2RZ+b5Y11zHok1kL6N5PPcIeBvAulE0pmh4pZiIaU8hn8gf++nkzkEKl5kXkL5dBhAIL
 /Bbp0WD21N5L08QQ6rb9qQrPkPOlCwkCVuYorgy+NlgjoBDoJrTm+Tli0zE4SXYzaZqAml
 eMtXmq91lbRCUVkW2JSFU5YC1FNSY4WJ4/2MfV+GMDQkM8+1kVanGnGahVkJNueZIr8ahw
 iiqLD0xqp+87tTonaZWHUAuUPsxINMvh4GnFJcIJhGRWvMUgCw4N9twq8cZF3Q==
Message-ID: <3d37e4a7-2beb-49df-bc0d-aff41d403f74@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777424877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MK6jSsSSiDrAmIYRxv1zu11sUOzC98C+5NynPTM8JBg=;
 b=dL6w6WJRgzDWwCAZdWjNjspnl6ZdKjoNqGAsTQfXTCOyHu/7dbYSQFq6vL8uBR7PNuTwIq
 6ILr5eG1l2U73riViTrcyv1/Sl1Jm/OpqHF69ugfy7aBNbjckn40bjZiXOHp9tA3d87BrW
 yh+aMwmV948MU5wyLIGE4dRPOwU5t/BMRGaL2FOFhq30irWx6wBq7i15Q71+hnc1W9pwAx
 FqcxeLta1Unav1Hdd4zHeHeWO0jS/6/50H1309SiiYXZoI1ydoRNqA5giHL2q3ihXQUCaW
 tZYBwBoVE5K2W91QT8vTw4PLW95ctgFeo+DwDV8TpjulvINgCAcJJLhztQED+A==
Date: Tue, 28 Apr 2026 21:59:53 +0200
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
 <73312691-c9a1-45a6-be3d-232949432b60@mailbox.org>
 <CAC_iWj+bT0Ab_MuGWa5seQBQ4WaAGSqWnPvZ=D9G2SgBH0X0Dg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWj+bT0Ab_MuGWa5seQBQ4WaAGSqWnPvZ=D9G2SgBH0X0Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: hakbm9xd5zbaqjnd5e11r3ber4fcgynr
X-MBO-RS-ID: b4760b83cdc95b29607
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

On 4/28/26 9:31 AM, Ilias Apalodimas wrote:
> On Tue, 28 Apr 2026 at 09:43, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 4/27/26 4:33 PM, Ilias Apalodimas wrote:
>>
>> [...]
>>
>>>>>>> +++ b/common/board_f.c
>>>>>>> @@ -339,7 +339,22 @@ static int setup_ram_base(void)
>>>>>>>      static int setup_ram_config(void)
>>>>>>>      {
>>>>>>>          debug("Monitor len: %08x\n", gd->mon_len);
>>>>>>> -#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
>>>>>>> +
>>>>>>> +     if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
>>>>>>> +             int bank;
>>>>>>> +             phys_size_t total_size = 0;
>>>>>>> +
>>>>>>> +             for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
>>>>>>> +                     if (gd->ram_top <= gd->bi_dram[bank].start)
>>>>>>> +                             gd->ram_top = gd->bi_dram[bank].start +
>>>>>>> +                                             gd->bi_dram[bank].size;
>>>>>>> +                     total_size += gd->bi_dram[bank].size;
>>>>>>> +             }
>>>>>>> +             gd->ram_size = total_size;
>>>>>>
>>>>>> Shouldn't this also apply board_get_usable_ram_top() to be consistent ?
>>>>>
>>>>> Simon asked the same thing. I'd rather keep this option strict for now
>>>>> and always relocate to the upper memory boundary fnor now. Once I do
>>>>> further cleanups, I can either add it or remove the function entirely
>>>>> since dram_init_banksize() (which hs also board specific) runs really
>>>>> early now.
>>>>
>>>> Maybe the default board_get_usable_ram_top() can return the ram top if
>>>> CONFIG_IS_ENABLED(RELOC_ADDR_TOP) ? That would still allow users to use
>>>> board_get_usable_ram_top() consistently to reduce the ram top.
>>>
>>> dram_init_banksize() can be used instead now to reduce that and we can
>>> remove this option eventually. Is there anything that we can't achieve
>>> with only that ?
>> I think I might be confused, but it seems board_get_usable_ram_top() is
>> used to set gd->ram_top , which is U-Boot's top of RAM and may not be
>> the same as physical top of RAM . So no, dram_init_banksize() has to
>> configure the correct physical RAM topology, board_get_usable_ram_top()
>> can be used to make space at ram_top unavailable to U-Boot .
> 
> I don't think you are confused but what I am trying to do with this
> option here is make the process of relocating to the last bank
> standard. So people that want U-Boot to calculate the reloc address
> based on the information they initalized on dram_init_banksize() _ the
> reserved DT regions should enable this option. if they have their own
> per board calculation logic, they can leave it as is, in which case
> we'll still call board_get_usable_ram_top().
That I do understand, I think board_get_usable_ram_top(top) should by 
default return its input parameter "top" . If user does need to adjust 
their ram_top, they can override board_get_usable_ram_top() and possibly 
consume the "top" parameter too. That way, the user has the actual ram 
top at their disposal, and they can use it if they need it, instead of 
reimplementing the logic to get their ram top. Most users should ideally 
not override board_get_usable_ram_top() of course.
