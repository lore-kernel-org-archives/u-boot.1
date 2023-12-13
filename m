Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16BBC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 21:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AD41878D0;
	Wed, 13 Dec 2023 22:00:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UFMV6DLn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eq4c8RJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0144878BF; Wed, 13 Dec 2023 22:00:31 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 455BA87880
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 22:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Sr7DB66Zwz9svb;
 Wed, 13 Dec 2023 22:00:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702501226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2RoGCA6G2sQTSpyP6IJ7K92Sy88ZxJuWH0lsQYAi4dY=;
 b=UFMV6DLnxHZyeUBnhAiPVkYylP/gtnQnF2UBc29RJncoKnjbnstxLap5yHjVc1FZrFtW9Y
 cHdLEs6mxlKU7zlAH7QNJFst/ODnSlMcfGaMDhQam3/xWsRxMdPoSPkSmohhs8uYpNC+v2
 ITTD8e7n+8Jh8Vm0gy+b1WaQ9wf2yYmseqG6narObF1KwvNuvpfy6SBI2A6OU1u2APvmwN
 pGkixSUfaZLzc0LUPReh9aCkgJbeF1RSDRuqbYM1memm05knG2E3F+OzJys2a7dw9yKaK3
 X4bmNVThD24Tb+LUA61WAFHsGUaFa47SyX+Pa3B/R+B3vIPKs8EqqsptrTXWJA==
Message-ID: <1eeea86e-f696-4452-a160-6c5e8131f6ad@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702501225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2RoGCA6G2sQTSpyP6IJ7K92Sy88ZxJuWH0lsQYAi4dY=;
 b=eq4c8RJegDaTwtAXMg1KYnn0syuRZE5B7SBOLO0ofyk+zHrrAPMvsxuL9pXWSm2vfkkDxY
 +Z5OO9LrsEm173O+ARU9IoUWTHzZ5+POED/X7ElewOsJeSC4/MavTmvL1/AEAetZ482i4u
 lXUBMG5tsJMtd+OuLKQ9mxsb3AwG8oLicKz2x9db5T7zqsQLTf/RmNn/5eE+7nEYyo+dUJ
 py3EYGhrQhe1qHhh3XB3GBINPg0wQ6/yTS8l7H5xgyJLEoVclDholxDuF8OZ6gQ9sdCDyJ
 7wtUo04P4MRPJw+neBQer852HcH4h707SicJWmfGGaHiiz9mrp6s8HnUeV2WyQ==
Date: Wed, 13 Dec 2023 22:00:23 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] mmc: Poll CD in case cyclic framework is enabled
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
References: <20231210150304.124458-1-marek.vasut+renesas@mailbox.org>
 <CAPnjgZ10dpyK3qyoogTaabyH0sNsXRZReCGdvVhdO=0LG2DJWw@mail.gmail.com>
 <6b56dc6f-f753-4da3-b371-4a8146d3f4e9@mailbox.org>
 <CAPnjgZ1bwt8-n=saKfdcoKOx42SdE1-t36eGazaiatzn626_ww@mail.gmail.com>
 <b09c6600-b05b-4fec-beb0-c0a9a226a507@mailbox.org>
 <CAPnjgZ0vjRjX3nQ+GU-vL6cgZN++szsS_ZEYXN1KXJD=Yxgyvw@mail.gmail.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAPnjgZ0vjRjX3nQ+GU-vL6cgZN++szsS_ZEYXN1KXJD=Yxgyvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: cfa9f9cfe0e4a8f659b
X-MBO-RS-META: ascg6pwhimj8jyjer57byxg1iji8qfom
X-Rspamd-Queue-Id: 4Sr7DB66Zwz9svb
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

On 12/13/23 20:49, Simon Glass wrote:
> Hi Marek,
> 
> On Wed, 13 Dec 2023 at 07:08, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 12/12/23 15:05, Simon Glass wrote:
>>> Hi Marek,
>>>
>>> On Mon, 11 Dec 2023 at 12:24, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>>>
>>>> On 12/11/23 18:52, Simon Glass wrote:
>>>>> Hi Marek,
>>>>>
>>>>> On Sun, 10 Dec 2023 at 08:03, Marek Vasut
>>>>> <marek.vasut+renesas@mailbox.org> wrote:
>>>>>>
>>>>>> In case the cyclic framework is enabled, poll the card detect of already
>>>>>> initialized cards and deinitialize them in case they are removed. Since
>>>>>> the card initialization is a longer process and card initialization is
>>>>>> done on first access to an uninitialized card anyway, avoid initializing
>>>>>> newly detected uninitialized cards in the cyclic callback.
>>>>>>
>>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>>> ---
>>>>>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>>>>>> Cc: Peng Fan <peng.fan@nxp.com>
>>>>>> Cc: Simon Glass <sjg@chromium.org>
>>>>>> ---
>>>>>> V2: Move the cyclic registration/unregistration into mmc init/deinit
>>>>>> V3: Replace if (CONFIG_IS_ENABLED(CYCLIC)...) with #if as the former
>>>>>>        does not work with structure members
>>>>>> ---
>>>>>>     drivers/mmc/mmc.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>>>     include/mmc.h     |  5 +++++
>>>>>>     2 files changed, 41 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>>>>>> index eb5010c1465..a5686dbc12e 100644
>>>>>> --- a/drivers/mmc/mmc.c
>>>>>> +++ b/drivers/mmc/mmc.c
>>>>>> @@ -2985,6 +2985,22 @@ static int mmc_complete_init(struct mmc *mmc)
>>>>>>            return err;
>>>>>>     }
>>>>>>
>>>>>> +#if CONFIG_IS_ENABLED(CYCLIC)
>>>>>> +static void mmc_cyclic_cd_poll(void *ctx)
>>>>>> +{
>>>>>> +       struct mmc *m = ctx;
>>>>>> +
>>>>>> +       if (!m->has_init)
>>>>>> +               return;
>>>>>> +
>>>>>> +       if (mmc_getcd(m))
>>>>>> +               return;
>>>>>> +
>>>>>> +       mmc_deinit(m);
>>>>>> +       m->has_init = 0;
>>>>>> +}
>>>>>> +#endif
>>>>>> +
>>>>>>     int mmc_init(struct mmc *mmc)
>>>>>>     {
>>>>>>            int err = 0;
>>>>>> @@ -3007,6 +3023,19 @@ int mmc_init(struct mmc *mmc)
>>>>>>            if (err)
>>>>>>                    pr_info("%s: %d, time %lu\n", __func__, err, get_timer(start));
>>>>>>
>>>>>> +#if CONFIG_IS_ENABLED(CYCLIC)
>>>>>
>>>>> We really shouldn't be adding new #ifdefs to the code.
>>>>>
>>>>> If you really want to make put ->cyclic behind an #ifdef then how
>>>>> about creating an accessor as is done in global_data.h ?
>>>>
>>>> That's really just working around the underlying issue, which is that
>>>> this does not compile:
>>>>
>>>> struct foo {
>>>> #if CONFIG_IS_ENABLED(STUFF)
>>>>      type member;
>>>> #endif
>>>> ...
>>>> };
>>>>
>>>> type fn() {
>>>> ...
>>>> if (CONFIG_IS_ENABLED(STUFF))
>>>>      access struct->member;
>>>> ...
>>>> }
>>>>
>>>> Accessor won't make it any better, would it ? It would only attempt to
>>>> hide the error and make the code more fragile, i.e. this:
>>>>
>>>> accessor(struct)
>>>> {
>>>> type fn() {
>>>> if (CONFIG_IS_ENABLED(STUFF))
>>>>      return access struct->member;
>>>> else
>>>>      return 0;
>>>> }
>>>>
>>>> }
>>>>
>>>> type fn() {
>>>> ...
>>>>      accessor(struct);
>>>> ...
>>>> }
>>>>
>>>> I suspect it also won't compile for one thing, and for the other, it
>>>> really just hides the issue.
>>>
>>> No, I mean like this:
>>>
>>> #ifdef CONFIG_ACPI
>>> #define gd_acpi_ctx() gd->acpi_ctx
>>> #define gd_acpi_start() gd->acpi_start
>>> #define gd_set_acpi_start(addr) gd->acpi_start = addr
>>> #else
>>> #define gd_acpi_ctx() NULL
>>> #define gd_acpi_start() 0UL
>>> #define gd_set_acpi_start(addr)
>>> #endif
>>>
>>> The header file has #ifdefs but not the C files.
>>
>> Hmmm, I can't say I like that either, that just adds more indirection
>> into the code and makes it harder to read in my opinion .
> 
> Sure, it isn't for everyone. But adding new #ifdefs is really grim
> IMO. Maybe you will get used to it?

I don't really want to get used to such workarounds which only obfuscate 
the code and decrease readability.

> Maybe there is a better approach?

I am open to suggestions . If there are none, I would say go with the 
ifdefs .
