Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F992CDE001
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 13:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95DA688CB9;
	Thu, 26 Sep 2024 15:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="sBnomNRS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86F7188CFC; Thu, 26 Sep 2024 15:14:05 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8192E8898B
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1727356436; x=1727961236; i=xypron.glpk@gmx.de;
 bh=4sLrlw4fP8geWQ93BYP3t2Z++zWHhbesiroGBwCFJ1g=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=sBnomNRS5wykOzDOXTr52zvbXiOjHnrodFSabdvbTExt0mfnGaGB0xkuJvKZnh4g
 hL8qL8RhM0MEFcLQX8q/EiXtJFTxSzfbi0orM+jN/smmjJ9p7uTnT7ExHyPnkz8uB
 PSL2AKbeh/B5IAk6eVAeAZNuZjFZhdW9aFt7J1vFy9uSJWFksIvFK2QsOca35X62K
 sOT1g2wFlu/FMGpU+2ntWg7CWw6NTbFMgq953LaJwvBb0N7bP6yDvWtSQr9QeY0bM
 6YuX8+1rDXVJxazRzBRpPqfnLyi/eWsCI4rt0KwwLu/IA4LXXUsUzv7D0vFPMlNwv
 Xv0DtwmKYgxD7nYCiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsIv-1s2Fl63RMV-00tBIy; Thu, 26
 Sep 2024 15:13:55 +0200
Message-ID: <66f42c2b-000e-4109-9899-9bf7568791ea@gmx.de>
Date: Thu, 26 Sep 2024 15:13:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] event: add event to notify lmb memory map changes
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-5-sughosh.ganu@linaro.org>
 <0291efc6-86a2-437c-938a-707c46c34f91@gmx.de>
 <CAC_iWjL4jHHfPA63x6hE4cxR9FLDvqkR+TYJh6-qwh3KTzmmcQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjL4jHHfPA63x6hE4cxR9FLDvqkR+TYJh6-qwh3KTzmmcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8xeGe1LdK5zBmxmWSs/U4y/AA9BrqyaRARgoatKKdgMLCMLEUVV
 MWY7JiJFY7V9SmIMM9RIPD+ayzVkzTsOPHB7nR6i+s60DIKPvxmbYdwnEMSSoD1PRj1Pzbk
 F6TLmC8tAijNWeY7uqBvz88PmTwkzEnKPL1k61p8/M1R5YWeLWKEsUFS5yQnMYeXemAaYgy
 nPPRjUCUs8cxpGwtCT+GA==
UI-OutboundReport: notjunk:1;M01:P0:+21vdKZTBtY=;ycePh3izsUm5ZbUuv2/q30TYfgu
 RTVX0Ai7UewrA1oQsdR6hwKGp3YXK4w019oJVsvQj9tQ3ivk6KIV+uS8hj4I6OloKI35S/rtc
 drVVtiLZ4zIlUUDRA5tbEJbm5asMNZuhI/g+TMMjH/k9Pp7FvkgJlTnyDMIQQtpGy9CZUlTyL
 p3ZAJcTdKxee3LRpw/XubGFomOCJK93u0BhTNRtRpTiWIjpLo/Mdujq/udfr8iG/ab4K8P+5f
 RDaYPegH47K0LUExw8IvGcPF2944S0IgPCJnx7+lwgXsbs6s44xZhGzdF1l3k5Cs0tjvtAZLc
 gF3zb8l9MRYhxWEpdYIJFf7pOAw2Jqt4RpMJUp7EsQMnncyNbetORVrPoiSSuMKaiQDhrIORK
 Jpvd9QpS3CyiMOyicpNqW0KLK+ByEj9pLF+j7V3kA65Ior2mlZRapcSjMctVaEiQR1liSjDtE
 kjHXjDG+WYKTuBrKO1Nn/0wgvmHA6HBjRyRJVJdu635BNMXlIQZw2+wr6qg2OKvVNy2iTEdp7
 XPTPIEduISswDj0RkUAXXB2ci0M2+ooZfffdLW3bRM5mrPb4LaiggnkGXf3DPHSMICo3nnehH
 6UebwbOy0bcbty9cT9VuB2lHlRZtJS3XjLcvjK/IQPvxF+yECppGm3oQbyAYdv8TfyZtfqYTg
 sYdh4+yj+iCyNXiE5Lhp5hS0xbAqrU+Leymf8B6QzUP5dq3mHC/TkQK7yBAIaywmmYrvQ1d4O
 ykX74Py8F5Etl8zaMB+sYe3UbE2BuRcavGDjQctC5IX++y9m1I8mshH3xalsSfqGS5eQzALvJ
 9hPXWRbHtYDBohLifU0MA9Rw==
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

On 26.09.24 14:58, Ilias Apalodimas wrote:
> Hi Heinrich,
>
> On Sat, 14 Sept 2024 at 18:08, Heinrich Schuchardt <xypron.glpk@gmx.de> =
wrote:
>>
>> On 9/5/24 10:27, Sughosh Ganu wrote:
>>> Add an event which would be used for notifying changes in the
>>> LMB modules' memory map. This is to be used for having a
>>> synchronous view of the memory that is currently in use, and that is
>>> available for allocations.
>>
>> The synchronous view problem only exists because we are duplicating
>> data. Store the EFI memory type in LMB and the problem vanishes.
>
> We could, but I wonder if that would be enough.
> Apart from the EFI memory types, we plan on fixing the EFI memory
> attributes. I'll go read the spec again and take look at EDK2 but
> IIRC, you can't correlate memory types to memory attributes (at least
> not for all of them).
>
> If that's true we'll also need the attributes in LMB + perhaps logic
> for 64kb page size OSes and 4KB page firmware, which might be a bit
> too much. In that case, I think the sync is fine, but I really don't
> see the point of making an event out of it. Perhaps we could just
> update the efi memory map directly from LMB.

Yes, memory attributes should be stored in LMB too if UEFI is enabled.

I would suggest:

* GetMemoryMap() calls into LMB to generate the map on the fly.
* The EFI_MEMORY_ATTRIBUTES_TABLE is generated from LMB information.
* The EFI_MEMORY_ATTRIBUTE_PROTOCOL calls into LMB.

Best regards

Heinrich

>
> Thanks
> /Ilias
>>
>> The event is only needed to notify EFI_EVENT_GROUP_MEMORY_MAP_CHANGE.
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>>> ---
>>>    common/event.c  |  2 ++
>>>    include/event.h | 14 ++++++++++++++
>>>    2 files changed, 16 insertions(+)
>>>
>>> diff --git a/common/event.c b/common/event.c
>>> index dda569d447..fc8002603c 100644
>>> --- a/common/event.c
>>> +++ b/common/event.c
>>> @@ -48,6 +48,8 @@ const char *const type_name[] =3D {
>>>
>>>        /* main loop events */
>>>        "main_loop",
>>> +
>>> +     "lmb_map_update",
>>>    };
>>>
>>>    _Static_assert(ARRAY_SIZE(type_name) =3D=3D EVT_COUNT, "event type_=
name size");
>>> diff --git a/include/event.h b/include/event.h
>>> index fb353ad623..fce7e96170 100644
>>> --- a/include/event.h
>>> +++ b/include/event.h
>>> @@ -153,6 +153,14 @@ enum event_t {
>>>         */
>>>        EVT_MAIN_LOOP,
>>>
>>> +     /**
>>> +      * @EVT_LMB_MAP_UPDATE:
>>> +      * This event is triggered on an update to the LMB reserved memo=
ry
>>> +      * region. This can be used to notify about any LMB memory alloc=
ation
>>> +      * or freeing of memory having occurred.
>>> +      */
>>> +     EVT_LMB_MAP_UPDATE,
>>> +
>>>        /**
>>>         * @EVT_COUNT:
>>>         * This constants holds the maximum event number + 1 and is use=
d when
>>> @@ -203,6 +211,12 @@ union event_data {
>>>                oftree tree;
>>>                struct bootm_headers *images;
>>>        } ft_fixup;
>>> +
>>> +     struct event_lmb_map_update {
>>> +             u64 base;
>>> +             u64 size;
>>> +             u8 op;
>>> +     } lmb_map;
>>>    };
>>>
>>>    /**
>>

