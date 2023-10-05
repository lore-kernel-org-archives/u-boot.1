Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131D6E8FDC8
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 10:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 011F386546;
	Thu,  5 Oct 2023 12:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UO/Hh/bN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A47B186546; Thu,  5 Oct 2023 12:41:49 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9851386541
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 12:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S1Sm961CPz9syc;
 Thu,  5 Oct 2023 12:41:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696502505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YDXh5kAZK3lBi5wKk1ZQpMNm9SlW1LFN/eQnUIydhs=;
 b=UO/Hh/bNkoeUEkN8HPKYL7gJRvsGYoWkuOrxg/wSKsegGAqSnPvyPG08iirEXL21wIxn+u
 AWEf/P+PmhVnxtJd7nCERdfz61KTmhfSPwc78XA2xKlFoEfxNe5eZFM6RJQQGhrfkmty/w
 eYbEG6bFq2mNlJEsd9g+gmgUsRe6zl1Y+n5oZ0V/5c7aA6bJMrGKB9fwEgvhuKhd/4uuo2
 M2XvRFpeNxx15dUUQGZeN58K4qwy//mK35B4QxMHuDl9X9sIN/6iCqPwuLXke5QIiNmKui
 zRT+rwew+XcvEgoUAn0PjhrJrM2wYt+t68N40TEKU49W7izvnPxa71uSAvzcQw==
Message-ID: <79f43342-d4fa-4405-9ac5-878d5407ad0c@mailbox.org>
Date: Thu, 5 Oct 2023 12:41:43 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 09/16] pinctrl: renesas: Add RZ/G2L PFC driver
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-10-paul.barker.ct@bp.renesas.com>
 <b0df977c-75ef-1579-506e-42e48ef2a06b@mailbox.org>
 <8d2eb729-977f-9fd8-669c-25520218880d@bp.renesas.com>
 <ebcddc10-e450-45e0-8f93-585ff440da4a@mailbox.org>
 <20231004194357.frlx2ojavgj6xye3@GBR-5CG2373LKG.adwin.renesas.com>
 <0d7fb0cd-6e90-4d88-b3b9-2a9bd91f8d0a@mailbox.org>
 <25731584-b21c-c114-7fb4-f90204521a85@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <25731584-b21c-c114-7fb4-f90204521a85@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6a882e4a8696e311fa7
X-MBO-RS-META: pafnc7t4w65d9g1oiz1du61fssk7uxjr
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

On 10/5/23 11:39, Paul Barker wrote:
> On 05/10/2023 03:24, Marek Vasut wrote:
>> On 10/4/23 21:43, Paul Barker wrote:
>>
>> [...]
>>
>>>>>>> +/*
>>>>>>> + * We need to ensure that the module clock is enabled and all resets are
>>>>>>> + * de-asserted before using either the gpio or pinctrl functionality. Error
>>>>>>> + * handling can be quite simple here as if the PFC cannot be enabled then we
>>>>>>> + * will not be able to progress with the boot anyway.
>>>>>>> + */
>>>>>>> +static int rzg2l_pfc_enable(struct udevice *dev)
>>>>>>> +{
>>>>>>> +	struct rzg2l_pfc_data *data =
>>>>>>> +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
>>>>>>> +	struct reset_ctl_bulk rsts;
>>>>>>> +	struct clk clk;
>>>>>>> +	int ret;
>>>>>>> +
>>>>>>> +	if (data->pfc_enabled)
>>>>>>
>>>>>> When does this get triggered ?
>>>>>
>>>>> This is initialised to false in rzg2l_pfc_bind(), then this function
>>>>> rzg2l_pfc_enable() sets it to true before a successful return. The
>>>>> effect is that the PFC is enabled just once, regardless of whether the
>>>>> pinctrl or gpio driver is probed first.
>>>>
>>>> Why would be call to rzg2l_pfc_enable() a problem in the first place ?
>>>> It just grabs and enables clock and ungates reset, the second time this is
>>>> called the impact on harware should be no-op , right ?
>>>
>>> The hw impact is a no-op, but it wastes time unnecessarily re-reading
>>> data from the fdt and repeating the setup, e.g. in rzg2l_cpg_clk_set()
>>> we have to search the array of clocks each time to find the requested
>>> entry.
>>
>> Does getting clock and enabling them have noticable overhead on this
>> platform ? Look at CONFIG_OF_LIVE, that should mitigate the DT access
>> overhead at least.
> 
> I've not measured this. I was just assuming that it is sensible to only do the setup once.
> 
>>
>>> I think it's worth keeping the conditional here but can drop it if
>>> you're really against it.
>>
>> It feels like fixing a problem at the wrong place really.
> 
> I'll drop the pfc_enabled flag and re-test.

You can stick get_timer() before and after the code to get a rough idea 
of how long it took, likely it will be 0 .

Thanks
