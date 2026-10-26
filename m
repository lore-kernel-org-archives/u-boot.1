Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CAF606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NbnzPQaL;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=bmlYQzXl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D106960645;
	Mon, 26 Oct 2026 06:31:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2_MZMrI6UiV1; Mon, 26 Oct 2026 06:31:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C8CC260619
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792996300;
	b=IZea6X5HwbIoghF41qX9W3OoMDdeM0TpznPd3UGjUooqbTRq5h6yqZBPcS4uACvD5bZn
	 XOJuS4S7vBOtE9ygGr7lcVfou9rAn2ZyNf05zT1xMhIyp/KR9W+yjPxyCDfQhBPt+xj81
	 z87In0x6HFUV554ErqjLVimksliwRusjlZh+ldek3BhojQN97J/GPT7V3p5L+GCwsn5BI
	 B3uXL/UQ4aVNaiZLBwNG3LsIO69Itt4DO3QkbPkHc48ilNFfzHRjcDfqRAbeEYuAFSldH
	 X77zCWM2wDP+8CCzC/teX6sBuFfcGv/WCPXbFeHDuLS562HLUPF6Yi6Sja29ZxjQG+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792996300;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:From:To:Cc:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iiWr+Og/VPzJstaRMYfqC4X67KyQexpSdre/QvwCyBI=;
	b=dqfyO32Clnmi6KwRqvnVEHAYL3Im0BtotJpeDFhZfK0Wd76F+CN3Vqhw6BXotkzoGSfo
	 ErlXp+bUeTX5IMV0vaAFIhDMhUl2MJvN+ItO8OK6ZwJHaDoaBpGQ/YXRPSW/Xynl7ydCN
	 c7sRaVKpe+KNM6ENu7lJN3xWAVYYeOcm0P+QoXMiwuj5B2XK3gks2geE6hZDNWg6jPOeN
	 XIi8VlbLtPWyOafiu2C3G5qhcve0ZkO+NVNOlLxKIi7Vvk+OCq6SMRzCs/fjaQOlaog8S
	 7IHkfNqrzFv2eAdviwbO42oKPy3SXMbago0YekSuXN901SSzffJM/bV/qw/eT48+Kvg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792996300;
	bh=iiWr+Og/VPzJstaRMYfqC4X67KyQexpSdre/QvwCyBI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NbnzPQaLkz50V15/MX8ZpZ62paCs3xHm35WvyQaJj7cWxuLkbItRsp3hu0J4uFKVL
	 BB7p0feB7XybUDk9YstYVvw/vcjXEqb0hxqdMBaQFwv51ZjEucFI6GR4eShSbcFslF
	 sMrpPik6Zz29noVpslaO8dUqzCn5ejifliuMEZdIO96pEdlRqSn1ZKFutX2lo8RdY7
	 wSj9beGbVtXYZ4r6hJbJdy3sOFxPxr74zpnZTZudSjnSvg8hZ6lihOZohPaxtF0YWQ
	 YXeRmI7CWYw6GGWmSWSegn41f5Nsny/8dtFXxTvCrZezC/MXTkQO4nuXVNkyis9BBR
	 uEOAfYAV0faEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8CC260619;
	Mon, 26 Oct 2026 06:31:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 95D88380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93A95405D2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:31:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2jIKSwxbQ4Yy for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 06:31:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3B29F405CF
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792996298;
 b=oqNuAEb+lK71k6nwoL0rU1zhIvWIvckgrp+E5a6mbX841lYMuLFwBHcfIXX9XmLgyKXL
 +DrPJJMzjxGkMI/27F5xUIz7k3Rk253SRGqaf5FMPJ/b8P4cnho4Wqbj5NG+LAaZosp/C
 YlHBdybnJXBwcXd1VQjvzXmGCn9KBbHJdJjKS6P8IyTxiaG7FwnwI/lrw4r/T6nphzQwb
 KU/KtxaKJAA61AmFh2K6wB+5+ByWzB5Rb6tK+fHOySGJj0l760m7jSsNUlmeRARIsrXmz
 8ZjvxOD4Ceg5Fi5C6zsl/wA7h7GKLGsh/35Z/E6OOJ557sUdwSSwb/9Ob+QBGhuffgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792996298;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:From:To:Cc:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=iiWr+Og/VPzJstaRMYfqC4X67KyQexpSdre/QvwCyBI=;
 b=AnHIuYaAfS9nJMEDWeJ++QJpTZWEyIm34kcrYAF8j5iGDD3Y7lQlgN4GD6iyUUB3+ZSV
 viJmVP0zHfrJFP1xN7x8nsm+OmXYq4+fPMwaYuafiE+KnrDVTzu/lAWaR77eqedeGUdK+
 dY14gMWccVIXh2h33UxSMesrsMq5LzoU2G8J61crqeeg68Hm9gm30ETqeeef4mOKuryuV
 Q6eNihxhbAqeb3s53b+A9FqrK63YQsiuRhipSiwcK+bHhhHyo7OhtzxFJZOVX06x2lq5J
 2V+ejwy7ZDkTt2HOaWQjCkZnHQjmSXf7ROXMBIY3fOigzej6WlAU8j3V6uBJQUSREpQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=bmlYQzXl; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=bmlYQzXl
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B29F405CF
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:31:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F3BDA1098D6; Mon, 26 Oct 2026 07:31:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792996291;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=iiWr+Og/VPzJstaRMYfqC4X67KyQexpSdre/QvwCyBI=;
 b=bmlYQzXlEGF4b7DpALsjcpwjeS0ZRVgOVhwMnvPlFf9F/dbdI5+fHOdp/ZAP8Fy8kRlEK7
 zbtaOV5+H3XT/c3i6dpiLgsMaRTC2yZsF1LF6hIi1BD627T36Gq4Ch4zxNuTYh5kvpzjNN
 BzllCiQJHC9DgzZj6eQV0cn25RnoruPA0pLGmeNOJgYAnGKnlgkVhcugUMqQiup14shdfr
 V4IWO1/cqVMs1y0fmDHuZ/RHYW3I3kZC2SM5/LAFr2ElZ2H8m6+SA6Rxej8erEct9zf4wl
 8azVKMzCwHQ/xEu1YzIpN4l51IRd7Zlr2MZNpRnTvmwE2WPE67hhk08Z583Q3A==
Message-ID: <034e49fe-4cae-f04e-e1a3-aab1f5b6826a@nabladev.com>
Date: Mon, 26 Oct 2026 07:30:39 +0100
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
 <43fbdd27-1367-02f5-9190-566c626cb256@nabladev.com>
In-Reply-To: <43fbdd27-1367-02f5-9190-566c626cb256@nabladev.com>
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

Hi Simon,

On 26.10.26 06:10, Heiko Schocher wrote:
> Hello Simon,
> 
> On 13.10.26 08:11, Heiko Schocher wrote:
>> Hi Simon,
>>
>> On 13.10.26 03:22, Heiko Schocher wrote:
>>> Hello Simon,
>>>
>>> On 09.10.26 09:08, Simon Glass wrote:
>>>> Hi Heiko,
>>>>
>>>> On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
>>>>> sandbox: spi: let a slave point at the emulation it needs
>>>>>
>>>>> sandbox_sf_bind_emul() binds the SPI NOR flash emulator for every slave
>>>>> on the sandbox SPI bus, whatever that slave is, so a device of another
>>>>> kind cannot be emulated and cannot be tested.
>>>>>
>>>>> As with I2C and PCI, a slave can point to an emulation node via a
>>>>> sandbox,emul phandle. Its compatible selects the driver. Without the
>>>>> property, the flash emulator remains bound to the slave node as before.
>>>>>
>>>>> Rename sandbox_sf_unbind_emul() to sandbox_spi_unbind_emul() while
>>>>> here. It is no longer specific to SPI NOR, and the old name would
>>>>> mislead every new caller.
>>>>>
>>>>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>>>>>
>>>>> drivers/mtd/spi/sandbox.c | 65 ++++++++++++++++++++++++++++++++++++++---------
>>>>>   include/spi_flash.h       |  2 +-
>>>>>   test/dm/sf.c              |  4 +--
>>>>>   test/dm/spi.c             | 10 ++++----
>>>>>   4 files changed, 61 insertions(+), 20 deletions(-)
>>>>
>>>>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>>>>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>>>>>   #ifdef CONFIG_SPI_FLASH
>>>>> -int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
>>>>> -                      struct udevice *bus, ofnode node, const char *spec)
>>>>> +/**
>>>>> + * sandbox_spi_emul_lookup() - bind the emulator standing in for a slave
>>>>
>>>> The generic part (following the sandbox,emul phandle) now lives in the
>>>> SPI NOR emulator, inside #ifdef CONFIG_SPI_FLASH, as does the only
>>>> non-weak sandbox_spi_get_emul(). So emulating an SRAM, or anything
>>>> else that is not flash, needs SPI_FLASH and SPI_FLASH_SANDBOX enabled.
>>>> Please can you move the phandle lookup and sandbox_spi_get_emul() into
>>>> drivers/spi/sandbox_spi.c, replacing the __weak version? The flash
>>>> emulator can then supply just the fallback for nodes with no
>>>> sandbox,emul property.
>>>
>>> I add this in a v3.
>>>
>>>>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>>>>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>>>>> +     if (!ofnode_parse_phandle_with_args(node, "sandbox,emul", NULL, 0, 0,
>>>>> +                                         &args)) {
>>>>> +             ret = lists_bind_fdt(bus, args.node, emulp, NULL, false);
>>>>> +             if (ret)
>>>>> +                     printf("Cannot bind emulator from node '%s' (err=%d)\n",
>>>>> +                            ofnode_get_name(args.node), ret);
>>>>> +
>>>>> +             return ret;
>>>>> +     }
>>>>
>>>> lists_bind_fdt() returns 0 and sets *emulp to NULL when no driver
>>>> matches the compatible, e.g. with CONFIG_SPI_RAM_SANDBOX off. NULL is
>>>> then stored in state->spi[][].emul, sandbox_spi_get_emul() succeeds,
>>>> and sandbox_spi_xfer() gets -EINVAL from device_probe(NULL) with no
>>>> hint about the cause. sandbox_spi_unbind_emul() would also pass NULL
>>>> to device_remove(). Please check for a NULL device and return -ENOENT
>>>> with a message naming the node.
>>>
>>> I add this in v3.
>>>
>>>>
>>>>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>>>>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>>>>> +static int sandbox_spi_emul_lookup(struct udevice *bus, ofnode node,
>>>>> +                                const char *spec, struct udevice **emulp)
>>>>
>>>> This binds a device rather than looking one up, so the name is
>>>> misleading. Also, I2C and PCI do not bind on demand: their emulators
>>>> are bound by the normal DT scan under an emulation parent node, then
>>>> found with uclass_get_device_by_phandle(..., "sandbox,emul", ...). If
>>>> SPI did the same, you could drop the lists_bind_fdt() call, and tests
>>>> would no longer need to unbind the emulator by hand before devices are
>>>> destroyed. Here the emulator node is a child of the slave, so it would
>>>> also be bound twice if the SRAM driver (or the MTD uclass) ever
>>>> scanned its children. What do you think?
>>>
>>> I take a look into it, but sounds correct.
>>
>> I think you are right about the shape.
>>
>> I will implement in v3 your other comments, and I think, that is a series
>> of its own about the sandbox SPI infrastructure, and none of it is about
>> the SRAM.
>>
>> I would send it after this one, with the SRAM as the second user, and drop
>> the manual unbind from the tests there, where the change can be seen for what
>> it is.
>>
>> If this is okay for you?
> 
> Gentle ping?
> 
> I wait with v3 because Stefan was on holiday (added to cc), as Stefan can
> test v3. If all work fine, I can send v3 ... currently state is without your
> above comment...
> 
> Thanks!

Sorry for the email flood... just made a rebase of the patchset to
current HEAD, and I found

commit 3b748d780a37 ("sandbox: spi: Add SPI EEPROM emulator and DM test")

and it seems to me, I do not need this patch anymore, am I correct?

I try to make a rework of the patchset without this patch...

bye,
Heiko
> 
> bye,
> Heiko
>>
>> Thanks!
>>
>> bye,
>> Heiko
>>>
>>>>
>>>>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>>>>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>>>>> +int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
>>>>> +                      struct udevice *bus, ofnode node, const char *spec)
>>>>
>>>> The unbind function is renamed because it is no longer specific to SPI
>>>> NOR, but this one, which now binds any emulator too, keeps the 'sf'
>>>> name. Please rename it to sandbox_spi_bind_emul() so the two stay
>>>> consistent.
>>>
>>> Of course.
>>>
>>>>
>>>>> diff --git a/include/spi_flash.h b/include/spi_flash.h
>>>>> @@ -136,7 +136,7 @@ struct sandbox_state;
>>>>> -void sandbox_sf_unbind_emul(struct sandbox_state *state, int busnum, int cs);
>>>>> +void sandbox_spi_unbind_emul(struct sandbox_state *state, int busnum, int cs);
>>>>
>>>> If this is now a generic SPI helper, it should be declared in
>>>> include/spi.h next to sandbox_spi_get_emul(), not in spi_flash.h under
>>>> DM_SPI_FLASH.
>>>
>>> Indeed, move this in v3
>>>
>>> Thanks!
>>>
>>> bye,
>>> Heiko
>>>>
>>>> Regards,
>>>> Simon
>>>>
>>>
>>
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
