Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4014CDE006
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 13:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6365288D90;
	Thu, 26 Sep 2024 15:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QMFbeH6W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7DD188D56; Thu, 26 Sep 2024 15:58:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA7D388D8D
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1727359134; x=1727963934; i=xypron.glpk@gmx.de;
 bh=JR4qYl0tTPctCepC3JNrXh1lrrxYuYk3BxlQ+MkWuhg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QMFbeH6WOulrZ1wuaUPvhPKSNDb6WhCoPEx7E2X96zzkawWwtQX1vNqwB9Cql03E
 oJnSjVsSLq54xuXWNFAK8QucSjMAJhy3qpZCJMslLrtntHSqJAKv2NdcRW5E9F1rA
 zv11hYymRH258fXcdibuCPj7uOwye1S16lnQTgpa0mKeoOnbG6LBm3nNZPreJKpVM
 yZpJQY0vHNIuCZWBJI8T/g5OLx0MPWoFwgGs7KKxLC5K2m95q78dIUtgnS/ukCqdG
 GSDzOy+Ei5weODNM3wdSpOZ0833UExhNl/T9dVThsMmUnmozPeny7amxkfDrJRxrS
 0MCV+3OLLCCkZCc7CA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7QxL-1rqhPP13Of-013nT2; Thu, 26
 Sep 2024 15:58:54 +0200
Message-ID: <30c6bdb6-f150-4c77-92cd-fc76f8c22157@gmx.de>
Date: Thu, 26 Sep 2024 15:58:53 +0200
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
 <66f42c2b-000e-4109-9899-9bf7568791ea@gmx.de>
 <CAC_iWjLvwxnBhFwV3wKup4-FJCYRXBNy3W5fe_LbUb7waYzwTA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjLvwxnBhFwV3wKup4-FJCYRXBNy3W5fe_LbUb7waYzwTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WreBbnt10nV/vK3gVEc4n3YP6Vz22gfj+jQy4EXsEpjCZIVBx8x
 1lWz3R3OZSXZah7fDVxlQNVzSfaX5xNpeLuobo5Xs2yjLHnRtDWbDuOiv40BMbwlBS0QHHw
 MT/yyh4gVv/KMBGkP3KHVss98MIbRp9sTD/7cZQYSr9vmedyf5I1R8lor726K+8DFoQMb25
 TDbYALYG3+MAIbbVJCLIQ==
UI-OutboundReport: notjunk:1;M01:P0:uTZyLnmga6Y=;TmJr583y7dzbKmtVpBzs0pKPcNc
 6XMvpQ4DgmCBxr79ELPYEiCN1OJs+6FlwpiaZboxpMn/R6F3yzLgd/ed/K4XrNTHRwbWigBO+
 xF7GSSd0VriDDwhL3FUB43XNUIv6+tsHtyhrI730rnWTU1T/kqhzsR4H9fnqsf/fWW568cA7c
 kHlxk0qTEKwN+vcMO4Dpg4g4pxbqvAp+67ErJGWmUkGiH4v/g2+P6IHGef8NdMKH8OhWcjrYe
 2N80rPy4+IAfS4T1gH045g+e/d1Ur6nZvpDfgHX8ICtJxa7OFbrTCMTn4kd/Biz2jT4mSkLgm
 tQcCoj0BZavhNuqcxff1oa8VFyBJ6x0DvuRK+KgU/gpUVU5KeRJ+f4cqlLmVy4cJPddm0kz8g
 if3PN8tXasLR5BPSBxY30ouK9vfoTaHEwQBqSI9mh32pAP0YXvnDSW9+l03AYRIP5jmUt3Am9
 IbggT0PcTNwayZsL8aD592Tfci4pv0f89b6IIy8/H/flc5roBRvIi1Vl+LY4pwJGtJoDDX7PA
 lLwIwG6TDehUOawME5FrFIW25g/pzPaozPGn53WYqWr0A3WX1RHo+8F+4LGR4z51YOzd4LPu/
 v3kT6tNVIpFjV+zhvlkZJbdqv79D65FaaXSUweCh7erqSyz7V6TIEnaOI+IpzAj+NBjzdNPYZ
 3/U45iNpDpap0EJEu/xufsq9KJQel+ncatq1K0vfx2crw7V8U88lff3SZhwMKFTF626TP3IOw
 Ga2jhGj+a0xba7fJGUUIvwaaST8so3oZTmiIBtiO+JJHlO5ey0x146ogJWNG0X1UIHc8FPiPo
 2JLSlQUAFGNpU1H+WpBfxjnw==
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

On 26.09.24 15:54, Ilias Apalodimas wrote:
> Hi Heinrich,
>
> On Thu, 26 Sept 2024 at 16:19, Heinrich Schuchardt <xypron.glpk@gmx.de> =
wrote:
>>
>> On 26.09.24 14:58, Ilias Apalodimas wrote:
>>> Hi Heinrich,
>>>
>>> On Sat, 14 Sept 2024 at 18:08, Heinrich Schuchardt <xypron.glpk@gmx.de=
> wrote:
>>>>
>>>> On 9/5/24 10:27, Sughosh Ganu wrote:
>>>>> Add an event which would be used for notifying changes in the
>>>>> LMB modules' memory map. This is to be used for having a
>>>>> synchronous view of the memory that is currently in use, and that is
>>>>> available for allocations.
>>>>
>>>> The synchronous view problem only exists because we are duplicating
>>>> data. Store the EFI memory type in LMB and the problem vanishes.
>>>
>>> We could, but I wonder if that would be enough.
>>> Apart from the EFI memory types, we plan on fixing the EFI memory
>>> attributes. I'll go read the spec again and take look at EDK2 but
>>> IIRC, you can't correlate memory types to memory attributes (at least
>>> not for all of them).
>>>
>>> If that's true we'll also need the attributes in LMB + perhaps logic
>>> for 64kb page size OSes and 4KB page firmware, which might be a bit
>>> too much. In that case, I think the sync is fine, but I really don't
>>> see the point of making an event out of it. Perhaps we could just
>>> update the efi memory map directly from LMB.
>>
>> Yes, memory attributes should be stored in LMB too if UEFI is enabled.
>>
>> I would suggest:
>>
>> * GetMemoryMap() calls into LMB to generate the map on the fly.
>> * The EFI_MEMORY_ATTRIBUTES_TABLE is generated from LMB information.
>> * The EFI_MEMORY_ATTRIBUTE_PROTOCOL calls into LMB.
>>
>> Best regards
>>
>> Heinrich
>
> That would work. TBH I do have a few doubts on how clean this is going
> to be. It seems a bit cleaner to me atm to keep the efi memory map as
> is. Especially if we get rid of the event.
> Would it make sense to clean this up from the event and merge it close
> to its current form? Then we could prototype what you suggest and send
> an RFC to decide it it looks cleaner or not.
>

Sure, we can split the work into two series.

Best regards

Heinrich


>>>>
>>>> The event is only needed to notify EFI_EVENT_GROUP_MEMORY_MAP_CHANGE.
>>>>
>>>> Best regards
>>>>
>>>> Heinrich
>>>>
>>>>>
>>>>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>>>>> ---
>>>>>     common/event.c  |  2 ++
>>>>>     include/event.h | 14 ++++++++++++++
>>>>>     2 files changed, 16 insertions(+)
>>>>>
>>>>> diff --git a/common/event.c b/common/event.c
>>>>> index dda569d447..fc8002603c 100644
>>>>> --- a/common/event.c
>>>>> +++ b/common/event.c
>>>>> @@ -48,6 +48,8 @@ const char *const type_name[] =3D {
>>>>>
>>>>>         /* main loop events */
>>>>>         "main_loop",
>>>>> +
>>>>> +     "lmb_map_update",
>>>>>     };
>>>>>
>>>>>     _Static_assert(ARRAY_SIZE(type_name) =3D=3D EVT_COUNT, "event ty=
pe_name size");
>>>>> diff --git a/include/event.h b/include/event.h
>>>>> index fb353ad623..fce7e96170 100644
>>>>> --- a/include/event.h
>>>>> +++ b/include/event.h
>>>>> @@ -153,6 +153,14 @@ enum event_t {
>>>>>          */
>>>>>         EVT_MAIN_LOOP,
>>>>>
>>>>> +     /**
>>>>> +      * @EVT_LMB_MAP_UPDATE:
>>>>> +      * This event is triggered on an update to the LMB reserved me=
mory
>>>>> +      * region. This can be used to notify about any LMB memory all=
ocation
>>>>> +      * or freeing of memory having occurred.
>>>>> +      */
>>>>> +     EVT_LMB_MAP_UPDATE,
>>>>> +
>>>>>         /**
>>>>>          * @EVT_COUNT:
>>>>>          * This constants holds the maximum event number + 1 and is =
used when
>>>>> @@ -203,6 +211,12 @@ union event_data {
>>>>>                 oftree tree;
>>>>>                 struct bootm_headers *images;
>>>>>         } ft_fixup;
>>>>> +
>>>>> +     struct event_lmb_map_update {
>>>>> +             u64 base;
>>>>> +             u64 size;
>>>>> +             u8 op;
>>>>> +     } lmb_map;
>>>>>     };
>>>>>
>>>>>     /**
>>>>
>>

