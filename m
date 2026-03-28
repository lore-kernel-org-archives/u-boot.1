Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E11910BA434
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 00:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C48AD83C5E;
	Sat, 28 Mar 2026 01:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KR4SUFCu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W+9EbB2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D5F83CD3; Sat, 28 Mar 2026 01:08:15 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67DA083C14
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 01:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fjHsS5YjYz9tfn;
 Sat, 28 Mar 2026 01:08:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774656492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRcSqU0dgMNcdEOqQiMmhnmoKggIh9KqGAuhk0/UIYA=;
 b=KR4SUFCuKniNFH2L06WvIxMf5QsURKXun+KyYz6a+/YICA7SRk6EzzEhQv+SSzed+N3U9t
 gk3tKpvJ3awg0n/KkXyTHL+EGeTbkNPPFZQ69ruS5y3160i2dab5+hvyA3vkzu6xDZCYv/
 MG+ZcYU51vKMOFF/Q+5T0ygiu4KawWStjY/l1iROgF3AOk1Maj73hg2hxNAf6w+1OTn2H8
 eUXZuAqNbTKoBh6J68+Rgg5kxqku90lXT7raruG7/2BtXDDxaVnbub10Fmn8GrFn2vhFWl
 ts4tn6nkervqRTym2EPjFqP8tzh7YV0Lv+wdo1XNTu+1w1/W1oUQgcbmrvtxVg==
Message-ID: <2dc80d82-3c57-49b8-816b-8c57553fd750@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774656491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRcSqU0dgMNcdEOqQiMmhnmoKggIh9KqGAuhk0/UIYA=;
 b=W+9EbB2VEjIchmLuF9r0yCOTHuZmZeJeh7ttJ3X0JZhm0wH+ym5pRwh6JO8AOIYSaBgpKD
 AoA93RIotPoPcGMYevegbKeofEoEmQ+GcukJpWhN8R/A+x6OReeLWfpFnXfs5fFaiZfImf
 GuOIaICI0L5IU8ZdZBqsnN3Nns6qmFHB0uMclmps4ORLb3oIMWoWn1e/Xce3LNTBGg6xde
 4gpDOwYepu8DSrX1bfRGtkRyQ3mu6O15YN4bc6PwkbRDVIPindWsqpPvJJ8mn1yZRIHoja
 hRuLA/bl5QVNDe866KWkeJqk83HFQ/sziHFbGmYgpDnHlNN4egGDHahkAtHEKQ==
Date: Sat, 28 Mar 2026 01:08:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/3] fdtdec: Introduce fdtdec_setup_mem_ram_top() to
 determine end of topmost DRAM bank
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
References: <20260326115111.1631261-1-ilias.apalodimas@linaro.org>
 <20260326115111.1631261-3-ilias.apalodimas@linaro.org>
 <ce171493-712b-4551-a895-a45f386180f0@mailbox.org>
 <CAC_iWjJEOntvBAL8fPhJpsabGBcVVq=OXkbOkyh6OgWottkD5g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWjJEOntvBAL8fPhJpsabGBcVVq=OXkbOkyh6OgWottkD5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ueixmnedx9iig9snx56e3ojkwwmsjkwr
X-MBO-RS-ID: a3ba0422add24965cda
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

On 3/27/26 1:19 PM, Ilias Apalodimas wrote:

Hello Ilias,

> On Thu, 26 Mar 2026 at 22:40, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 3/26/26 12:51 PM, Ilias Apalodimas wrote:
>>
>> [...]
>>
>>> +/**
>>> + * fdtdec_setup_mem_ram_top() - decode and setup gd->ram_top to highest address
>>> + * available in any memory bank
>>> + *
>>> + * Decode the /memory 'reg' property to determine the highest end of the memory
>>> + * bank and populate the global data ram_top with it.
>>> + *
>>> + * This function should be called from a boards board_get_usable_ram_top().
>>> + * This helper function allows for boards to query the device tree for topmost
>>> + * DRAM address.
>>> + *
>>> + * Return: 0 if OK, -EINVAL if the /memory node or reg property is missing or
>>> + * invalid
>>> + */
>>> +int fdtdec_setup_mem_ram_top(void);
>>> +
>>>    /**
>>>     * fdtdec_setup_memory_banksize() - decode and populate gd->bd->bi_dram
>>>     *
>>> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
>>> index d820f75b031d..c5ee2ecb3a49 100644
>>> --- a/lib/fdtdec.c
>>> +++ b/lib/fdtdec.c
>>> @@ -1162,6 +1162,26 @@ int fdtdec_setup_mem_size_base_lowest(void)
>>>        return fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_size_base_lowest_bankfn);
>>>    }
>>>
>>> +static void fdtdec_setup_mem_ram_top_bankfn(struct resource *res, int bank)
>>> +{
>>> +     if ((res->end + 1) > gd->ram_top) {
>>> +             gd->ram_top = res->end + 1;
>>> +             gd->ram_size += res->end - res->start;
>> Since this is called fdtdec_setup_mem_ram_top(), it likely shouldn't be
>> manipulating with gd->ram_size ?
> 
> Sure. I don;t mind either way. We either rename the function to
> something more readable or just add a new callback that updates the
> sizes.
> I'll just move this to a new callback.
Thank you
