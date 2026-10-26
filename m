Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A66606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 05:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O4Xe8LMb;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=bqhwLyeU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7B9B80D43;
	Mon, 26 Oct 2026 05:11:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yf36W_ZlK43O; Mon, 26 Oct 2026 05:11:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 16E8B80D45
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792991507;
	b=G/WRjwTQbBEPydP39SzfxfMSCupUMEuqK/GtqmRPhED7PFNBxxJ7vSebkiYZmEkypx4o
	 /zYdkZ8FezfAvJSttS72txXx84EcEIxch2Diqjesfot2GIL+agUjPGLkmUBwcnO1QlZs/
	 65P2eVUqsY47IVzTiM3Ixdjq+Yfw6Dxno3xVwPrlaGsaLwCG/btzecwbaG0TvzEP4Y8cv
	 916QRJoKGaebwwmu85nsftOsn3WabI2QJqDJBvMkJd1lcCR+yWczFlCXMT17ZRmhT0he6
	 7hHVkBd0kZXhqdpem7WQKk9iWeML359HSF3/elG6g5z7juWfVBg+eIKgMyL6L0TwCyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792991507;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:From:To:Cc:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FQX8cwGCULiKf/WCJcmrm5qxGAOdriQ6n892nnQ/cYM=;
	b=Y9y6fy3vo593dVKxI/XJym0Le506hLP2dcXn/ZelTTdqyj5H2uQlibsFnAB+0cjvc24N
	 3sWdpULRdfDpSFqNvd7m9JBaq1mOuknWCoKdLHHjN25s5OKCK6bKK4oFnu4Z3tg8HdR7y
	 TTfM7eQ7GajokGPYf/pXeA/52UKxkiNnzM9shs06zUTlguE/q78vEiBF4CusayHjAOsle
	 HL70feIpGU7lgGO0ht2lzo8PzvMPlKR/+xrn58nfL8tcKFoCi8OrN4vpVJJCQvXAlsuYX
	 IZc/Y9uCngCUGv3MD07OQ1BxsxiCEC/QDGcqqsw1htQLk2ffxYXgvShCPN5Xt5/38EQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792991507;
	bh=FQX8cwGCULiKf/WCJcmrm5qxGAOdriQ6n892nnQ/cYM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O4Xe8LMbaK6NYp1SGIJbLEilC1r4tI1kRXEkJTFlWtUXtB+iUSA6329bpr0/08GXp
	 Q2tDS6mFI8xwPffWE2Xc+9pb03OX8ICr34Gy7pfn9xE/3z6S4+iIml9edyQbgu2jVK
	 dTz50UmelVE+EJYl+qQ8BKZNV4rnE4j3BVyaEuTVO87W2z4WaOIkCZ0jK5iG1OJFB6
	 L+kjLBlrF56G7p2Kdx2TMH37V103wpRCq1V4IvWfdXzn7Y/1GxGVqHUgTNp5WDJ5TA
	 VpOq0UsYVRorXvxt/ZjmDqQ4HbGTQA+T36+KrzOgvLH5A9UKpB7R2xd0X1x4FA4e90
	 GUaUGbEm1LJqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16E8B80D45;
	Mon, 26 Oct 2026 05:11:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4928E2C7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B4C7405D2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:11:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B3CJkuVmgGYe for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 05:11:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ABA32405CB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792991504;
 b=I45BRfl7t+admw4maFYYGVYAhJQdkovagwM4TB3liAzw9KUPtC5eCMW/jBu6ZtE60/19
 xyU9Tora9t63aVkuAK3ZsO9N+kp1GCjz/FxTYm2lqobgVJ/8/bEfm5qqfWU/Jgczfj3XN
 5cijPRVMfQHCcEBipZRL4Y7W7XBgGc99LVtdf6YltBZvsslcC8VvvuM9Mn+cj7RKwZHUJ
 4ZSJTdse/b/oPDJzymvvyTeuZzF7sdIGtLkV8L1boshlzvs57PvLzEIQ/u5R/5/+zhZoY
 ZDEthUW2EJJw35C9Ot9bsZA8vRc5H5Z3YR68v7nawQI8kA9j3H1Cfh2dGy3i4AkHFgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792991504;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:From:To:Cc:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=FQX8cwGCULiKf/WCJcmrm5qxGAOdriQ6n892nnQ/cYM=;
 b=SWpTfCD5/To7qs3PemjkLKLElarIdy+T/uvwNCwB+yXw16T6B5NtQENo2gR9eIKKGfpR
 S+tDCC1aSKBfKQehPBlSbR2vPhyR88mp/swhPQhl0Tzs919+MzrrLxlY+9E3XDpa9LS9V
 vs9Vg2DUwyLM+RubOrto0/8aqDZFBS+EBiEZauXXmPzAKg4iGNfknmv/WpBc1pRfXeONz
 1WOj2LfQA+9//w7ex5LzPWFqK4pWooyQbngjiI6GQiz10YMBx8NL2lFUV8cagomJuFhws
 Ng6jVVTSpBWZWfxJCkS1eqgbLPXzG2aeJE+Kav/oPfJ5wylRgT2kSGWHlgv6+nFF6Nw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=bqhwLyeU; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=bqhwLyeU
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ABA32405CB
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:11:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E8A47106F43; Mon, 26 Oct 2026 06:11:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792991496;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=FQX8cwGCULiKf/WCJcmrm5qxGAOdriQ6n892nnQ/cYM=;
 b=bqhwLyeUcafLvvgk0OgGryBL/diBqrumN+MO/i66WO/v9MBwx8qO5dVSqeFb3+EHrfsctU
 8MNXHV2HF54SlBrzpfRJSL/f+uxxEOT7mtl7FI0slKpF/G8nEx1pWfCptlJjNrCPGzFhtq
 0uJBi3Xh9Kp0sj2JeQtEknc0nicbUsjRY9HoCPTzaLC1OvFttHZTKTDkitI4y+YtaFfIYk
 +fDQ5UtpoPplUyedhpnjgLQP72UXUg4B5TcCMLepp+GnlO4kt3rg96xfBnAKN/O5q5rAzM
 edh75f2IgO/mCFtdVr6Uf+4mOl7vRL8NKt9WIo9SZ7TdHy4ynJMturLGmrK60Q==
Message-ID: <43fbdd27-1367-02f5-9190-566c626cb256@nabladev.com>
Date: Mon, 26 Oct 2026 06:10:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 4/5] sandbox: spi: let a slave point at the emulation
 it needs
Content-Language: en-US
From: Heiko Schocher <hs@nabladev.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Cole Munz <Munzzyy1@proton.me>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 "Bigler Stefan, Securiton, EES" <stefan.bigler@securiton.ch>
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-5-hs@nabladev.com>
 <CAFLszThWnBLQVZvpDAdD_zD_xDPe0x8ed4peMXpfFF6a13=rrQ@mail.gmail.com>
 <2a7285ce-bc12-043e-8fe6-674d41d1f275@nabladev.com>
 <56382e4e-d25b-66bf-1463-5438588392a6@nabladev.com>
In-Reply-To: <56382e4e-d25b-66bf-1463-5438588392a6@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Simon,

On 13.10.26 08:11, Heiko Schocher wrote:
> Hi Simon,
> 
> On 13.10.26 03:22, Heiko Schocher wrote:
>> Hello Simon,
>>
>> On 09.10.26 09:08, Simon Glass wrote:
>>> Hi Heiko,
>>>
>>> On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
>>>> sandbox: spi: let a slave point at the emulation it needs
>>>>
>>>> sandbox_sf_bind_emul() binds the SPI NOR flash emulator for every slave
>>>> on the sandbox SPI bus, whatever that slave is, so a device of another
>>>> kind cannot be emulated and cannot be tested.
>>>>
>>>> As with I2C and PCI, a slave can point to an emulation node via a
>>>> sandbox,emul phandle. Its compatible selects the driver. Without the
>>>> property, the flash emulator remains bound to the slave node as before.
>>>>
>>>> Rename sandbox_sf_unbind_emul() to sandbox_spi_unbind_emul() while
>>>> here. It is no longer specific to SPI NOR, and the old name would
>>>> mislead every new caller.
>>>>
>>>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>>>>
>>>> drivers/mtd/spi/sandbox.c | 65 ++++++++++++++++++++++++++++++++++++++---------
>>>>   include/spi_flash.h       |  2 +-
>>>>   test/dm/sf.c              |  4 +--
>>>>   test/dm/spi.c             | 10 ++++----
>>>>   4 files changed, 61 insertions(+), 20 deletions(-)
>>>
>>>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>>>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>>>>   #ifdef CONFIG_SPI_FLASH
>>>> -int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
>>>> -                      struct udevice *bus, ofnode node, const char *spec)
>>>> +/**
>>>> + * sandbox_spi_emul_lookup() - bind the emulator standing in for a slave
>>>
>>> The generic part (following the sandbox,emul phandle) now lives in the
>>> SPI NOR emulator, inside #ifdef CONFIG_SPI_FLASH, as does the only
>>> non-weak sandbox_spi_get_emul(). So emulating an SRAM, or anything
>>> else that is not flash, needs SPI_FLASH and SPI_FLASH_SANDBOX enabled.
>>> Please can you move the phandle lookup and sandbox_spi_get_emul() into
>>> drivers/spi/sandbox_spi.c, replacing the __weak version? The flash
>>> emulator can then supply just the fallback for nodes with no
>>> sandbox,emul property.
>>
>> I add this in a v3.
>>
>>>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>>>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>>>> +     if (!ofnode_parse_phandle_with_args(node, "sandbox,emul", NULL, 0, 0,
>>>> +                                         &args)) {
>>>> +             ret = lists_bind_fdt(bus, args.node, emulp, NULL, false);
>>>> +             if (ret)
>>>> +                     printf("Cannot bind emulator from node '%s' (err=%d)\n",
>>>> +                            ofnode_get_name(args.node), ret);
>>>> +
>>>> +             return ret;
>>>> +     }
>>>
>>> lists_bind_fdt() returns 0 and sets *emulp to NULL when no driver
>>> matches the compatible, e.g. with CONFIG_SPI_RAM_SANDBOX off. NULL is
>>> then stored in state->spi[][].emul, sandbox_spi_get_emul() succeeds,
>>> and sandbox_spi_xfer() gets -EINVAL from device_probe(NULL) with no
>>> hint about the cause. sandbox_spi_unbind_emul() would also pass NULL
>>> to device_remove(). Please check for a NULL device and return -ENOENT
>>> with a message naming the node.
>>
>> I add this in v3.
>>
>>>
>>>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>>>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>>>> +static int sandbox_spi_emul_lookup(struct udevice *bus, ofnode node,
>>>> +                                const char *spec, struct udevice **emulp)
>>>
>>> This binds a device rather than looking one up, so the name is
>>> misleading. Also, I2C and PCI do not bind on demand: their emulators
>>> are bound by the normal DT scan under an emulation parent node, then
>>> found with uclass_get_device_by_phandle(..., "sandbox,emul", ...). If
>>> SPI did the same, you could drop the lists_bind_fdt() call, and tests
>>> would no longer need to unbind the emulator by hand before devices are
>>> destroyed. Here the emulator node is a child of the slave, so it would
>>> also be bound twice if the SRAM driver (or the MTD uclass) ever
>>> scanned its children. What do you think?
>>
>> I take a look into it, but sounds correct.
> 
> I think you are right about the shape.
> 
> I will implement in v3 your other comments, and I think, that is a series
> of its own about the sandbox SPI infrastructure, and none of it is about
> the SRAM.
> 
> I would send it after this one, with the SRAM as the second user, and drop
> the manual unbind from the tests there, where the change can be seen for what
> it is.
> 
> If this is okay for you?

Gentle ping?

I wait with v3 because Stefan was on holiday (added to cc), as Stefan can
test v3. If all work fine, I can send v3 ... currently state is without your
above comment...

Thanks!

bye,
Heiko
> 
> Thanks!
> 
> bye,
> Heiko
>>
>>>
>>>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>>>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>>>> +int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
>>>> +                      struct udevice *bus, ofnode node, const char *spec)
>>>
>>> The unbind function is renamed because it is no longer specific to SPI
>>> NOR, but this one, which now binds any emulator too, keeps the 'sf'
>>> name. Please rename it to sandbox_spi_bind_emul() so the two stay
>>> consistent.
>>
>> Of course.
>>
>>>
>>>> diff --git a/include/spi_flash.h b/include/spi_flash.h
>>>> @@ -136,7 +136,7 @@ struct sandbox_state;
>>>> -void sandbox_sf_unbind_emul(struct sandbox_state *state, int busnum, int cs);
>>>> +void sandbox_spi_unbind_emul(struct sandbox_state *state, int busnum, int cs);
>>>
>>> If this is now a generic SPI helper, it should be declared in
>>> include/spi.h next to sandbox_spi_get_emul(), not in spi_flash.h under
>>> DM_SPI_FLASH.
>>
>> Indeed, move this in v3
>>
>> Thanks!
>>
>> bye,
>> Heiko
>>>
>>> Regards,
>>> Simon
>>>
>>
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
