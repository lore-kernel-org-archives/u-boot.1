Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1ECAFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 11:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F28218410D;
	Mon, 27 Apr 2026 13:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="N0/GoeaE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UiaN/Uq0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CD2A8407D; Mon, 27 Apr 2026 13:27:04 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E5D980433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 13:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4g41Vs0861z9v5F;
 Mon, 27 Apr 2026 13:27:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777289221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tdTrt01VNvLhTFLa6E57vwAfOKCO/s/20tdnCjmt6CE=;
 b=N0/GoeaE6Xs13EE9pJyYxxsD1OF3Mq6gOIvgJJsYY9BtoQoNM5ynZJzroJ9XWYv+U8DAB6
 Y9cAg+vcNa/iwR8jN0yLCRzAjlKfzGTW4eUXyasMSZnRqu2ERG4afcjetrbJ7uGFlagV95
 pzv2nYK0s3CgaDVev/mK7YDdIJHJt7SJgMiJRZBQM80Ez8xAlpudzrbkeY8McmRFWK/uBG
 MkmXe3t4CotpzB8QS08podoxdlXgbMmlvPQ2pKnszu7PRH1d+ysKMMFXkCHa7rYexvT5Hn
 QhPLA/fkhZivgDdGm/k0LdRk4tFCzX9gbmDdq/zQMjkR1BvlC3KIMA5VG4DMTg==
Message-ID: <8b87df2b-1904-4f2c-862d-924daff649e6@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777289219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tdTrt01VNvLhTFLa6E57vwAfOKCO/s/20tdnCjmt6CE=;
 b=UiaN/Uq0LZQewd+FpdimZHXejrFIYWRXoV6mSu97OllauWKkRpPywsn8M+Cy3uNazRbORj
 KDdDXRVm1tGeY6hFQsr0zPvBZi6WORAD928mbzP5ch4gfQ6o7cYIanSPGARoPKt2SnuJwC
 bdzExPYvYGl+GvZZE66nr/Ox19o3UyHsxC6Pcdq3QvtYMcRHn1VpwN6iVhHX8hctQspeqf
 DgCLvB6MAY6MNh3lgW8+IxPodOu/5UUdl2xwkeAnamAJLOwhqDiICUI28nkUIVFwTsfafx
 K4rRC+xtN+lLoguqhU87/W/7FQUTY7oJw1/NE5IEBX/BvfDN0B7xNWupJwDy9w==
Date: Mon, 27 Apr 2026 12:43:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 6/6] common: Add an option to relocate on ram top
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se,
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
 <20260416055948.130041-7-ilias.apalodimas@linaro.org>
 <6944f28f-131f-4a08-9ef9-aae812926f4b@mailbox.org>
 <CAC_iWj+ufWdroVDCh9qNAYfsjON5r_pdfOUgyB=h=b2b_rMVKg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWj+ufWdroVDCh9qNAYfsjON5r_pdfOUgyB=h=b2b_rMVKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: anam6pa5u4q1x11zry1ztditf74it797
X-MBO-RS-ID: 97387f2f143c9031e25
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

On 4/27/26 8:20 AM, Ilias Apalodimas wrote:
> Hi Marek,
> 
> On Sun, 26 Apr 2026 at 19:35, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 4/16/26 7:59 AM, Ilias Apalodimas wrote:
>>> Right now we only relocate u-boot to the top of the first
>>> memory bank unless the board specific code overwrites it.
>>> This is problematic when loading big binaries as it
>>> fragments the contiguous memory space for no apparent reason.
>>>
>>> It's worth noting that there are cases where we must not relocate
>>> above the 4GiB boundary (64bit hardware with 32bit only capable
>>> DMA). E.g This will break platforms, if the ethernet
>>> controller cannot DMA above 4 GiB, and once U-Boot does
>>> get relocated above 4 GiB, the packet buffer which is built
>>> into the U-Boot binary is also relocated above 4 GiB.
>>
>> On certain platforms, it is currently not possible to relocate U-Boot
>> above the 32bit boundary, due to various dependencies on content located
>> below the 32bit boundary. One such example is ethernet, where the packet
>> buffer built into U-Boot binary is placed below the 32bit boundary and
>> allows loading of data via ethernet even above 32bit boundary due to
>> memory copy from the packet buffer to the destination location.
>>
>>> A previous patch moves the bi_dram[] info from bd to gd and make
>>> the memory bank information available early. So move the
>>> dram_init_banksize() INITCALL before the relocation address calculation
>>> and use it to derive the address.
>>>
>>> Also add a Kconfig option and allow the common code to relocate U-Boot
>>> to the top of the last discovered bank.
>>>
> 
> [...]
> 
>>
>>> +
>>>    endif # EXPERT
>>>
>>>    config PHYS_64BIT
>>> diff --git a/common/board_f.c b/common/board_f.c
>>> index 4ac22dca9e7c..f95e789257ad 100644
>>> --- a/common/board_f.c
>>> +++ b/common/board_f.c
>>> @@ -339,7 +339,22 @@ static int setup_ram_base(void)
>>>    static int setup_ram_config(void)
>>>    {
>>>        debug("Monitor len: %08x\n", gd->mon_len);
>>> -#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
>>> +
>>> +     if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
>>> +             int bank;
>>> +             phys_size_t total_size = 0;
>>> +
>>> +             for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
>>> +                     if (gd->ram_top <= gd->bi_dram[bank].start)
>>> +                             gd->ram_top = gd->bi_dram[bank].start +
>>> +                                             gd->bi_dram[bank].size;
>>> +                     total_size += gd->bi_dram[bank].size;
>>> +             }
>>> +             gd->ram_size = total_size;
>>
>> Shouldn't this also apply board_get_usable_ram_top() to be consistent ?
> 
> Simon asked the same thing. I'd rather keep this option strict for now
> and always relocate to the upper memory boundary fnor now. Once I do
> further cleanups, I can either add it or remove the function entirely
> since dram_init_banksize() (which hs also board specific) runs really
> early now.

Maybe the default board_get_usable_ram_top() can return the ram top if 
CONFIG_IS_ENABLED(RELOC_ADDR_TOP) ? That would still allow users to use 
board_get_usable_ram_top() consistently to reduce the ram top.

>>> +     } else {
>>> +             gd->ram_top = gd->ram_base + get_effective_memsize();
>>> +             gd->ram_top = board_get_usable_ram_top(gd->mon_len);
>>
>> Should this really use gd->mon_len as a parameter, or gd->ram_top?
> 
> I haven't really thought about thism since it's what we currently do.
> In any case that's a change that needs to go on another patch.
Indeed.
