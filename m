Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7C5C4707C
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 14:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17EAD87A18;
	Mon,  8 Jan 2024 15:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="klvkaBcL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C28387A75; Mon,  8 Jan 2024 15:27:24 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1102D86C72
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 15:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704724040; x=1705328840; i=xypron.glpk@gmx.de;
 bh=xT+2SLcZDIkxmV25X2HA0EllCykFX8ui/JFRtLf/X5E=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=klvkaBcLgrUUDw5F/gAncKcqNyml/6GTmGTpS19j4iI3CyQW1TwXcrKTerls5lPv
 0BMFbm6p/XHaKYdaFLkxyRRtnFFhiCrFqBZwYf5eBgCvDJdVhPV8qzi9PFIQdTlz6
 y9hrgjUyTymKFCDespKcKs9L7H5RbE8L/ioKcqNuWlhmW2OTEr5N9wmspGORNUCzs
 j6tCEVbocuL0FvNdxH6D0NPzbSAKYHMNNOuqtQzXaNV4hWMKY8ro8PehEsWe0HyrF
 hH78hwjOug3kBv8piPkNIsg9fSVtiJxmNH0WXOpSeRSJcAwwUlBXSpOpESubxMVg+
 GLVh8eVFOCzi6Yi9XA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJqD-1qt3xz276p-00nUeD; Mon, 08
 Jan 2024 15:27:20 +0100
Message-ID: <4244abf5-49b4-43ac-a52e-5ebc8c1aa658@gmx.de>
Date: Mon, 8 Jan 2024 15:27:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
Content-Language: en-US
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: sjg@chromium.org, mark.kettenis@xs4all.nl, Drew.Reed@arm.com,
 u-boot@lists.denx.de, nd@arm.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20231214155346.GB295924@e130802.arm.com>
 <87ttok689d.fsf@bloch.sibelius.xs4all.nl>
 <CAC_iWjKYa1_GrU3XPKqbnOf6VJxx426qTfD1WcSMkmj982ECSw@mail.gmail.com>
 <20231218165909.GA313366@e130802.arm.com>
 <20240108141256.GA236096@e130802.arm.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240108141256.GA236096@e130802.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zZQJcKNQLA4Nf8WyvVymPpa2gtZ5Ra5ch5J72XUhbo8WF2bru7c
 4lF3AOSuUmWrvT8pNhRGTjgJx9vtWefqMpFRRMmOtQF/Z+76dM/ZaVgRfo3pMdkguSUo0kj
 /Z02X2+VqdxYk5Rdgk/ZQVFQiylD7UFolA0lMV+kgS0QPRKEPprAm3G6M2tDSG+TjS84HFd
 Gb955efjCBAcl19MHIDfw==
UI-OutboundReport: notjunk:1;M01:P0:I5VGbbi6GBw=;77tFK3/918Tr/XdAKsEdMjHSUDE
 l0G+611kXUccNlY2lLmcx01foIUIM4t3OVa2Vj2p+jHmJhf8vlaH4MoL9I0y6aARQ5WJlLfR3
 JKYYnN668Gz98abRd3lLVmOAls0OKOLjLrqtoV9TNsFy77dMvtQY9bYQ7/brrep08LydUcP6+
 J8J4oo551b3OHI/a5K38TnbgRWXFnZIVFJMLJ84dsYen6I+imDIVeXsysy5ZtTQyFQ+nSKoqD
 2kuLPYQVBouAhacaFkM3HMjn6TGpckX5J58QtNc7e6kHCPkJH93wc6ghWsOBit5n/sAddb2Kc
 XfjUPgbltUjPbOSIIXqDHwhcSkUmgjhWM+HqXSMvIMeSfb7KtivNDEAYfVuHQs9k8wqhAm4dK
 nPJFtMDr8uChwsTD9E4WMwnXgX5CjlxQL9BUc+MJyGF7w36THfxm/KbzAjNSgw/Q0XxfG4N8J
 ZV7+WbLEic1FYwM1XLNLAxvE92gFcdVdu/CzORDDBkzU+4LnnynrBL+w+Ju6/Wo949C145FTf
 eUYQMTU8TL3vri0lNMlcSC0OeGDDpnN61dCDVWQz8k6FB55xZkT7fsOCLFSpHoOwu5JYZcCER
 JslGaeh0vWOMC0z867yVNL8zpOX7RIS+B15GAs8vYfFncGMvX3N7bCw2SUI7ca60TLLZ6fNvG
 4Di1QoFbj/bZq3fEc8EJA6XRM00c9UZJaoav4JRqwU8gE7wwTTKGTBsFO5rxUD3KI8YXpfM4O
 +Es170//LBChiY0RFVPzCzYcRO51G9CJ+RrUO2/6E8YvpHx+KsLzfojLINP+Nzj5gHNltATry
 76RwDIDJ5569YuBBNYOUQzgMfc0JAVD+zNn0tfoTwwbizFKvjcAubUEZNzIliwbfOW71NB1sG
 VjAt7kRSnIPQuF+BooBnrWUD2KP8IIWcR8nX/5nBN5Ysev19RKjCBGKczleB9xpqMEsMNj7NP
 3GVtMQ==
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

On 08.01.24 15:12, Abdellatif El Khlifi wrote:
> Happy new year Ilias,
>
> On Mon, Dec 18, 2023 at 04:59:09PM +0000, Abdellatif El Khlifi wrote:
>> Hi Ilias
>>
>> On Thu, Dec 14, 2023 at 09:47:13PM +0200, Ilias Apalodimas wrote:
>>> Hi Mark, Abdellatif
>>>
>>> On Thu, 14 Dec 2023 at 18:47, Mark Kettenis <mark.kettenis@xs4all.nl> =
wrote:
>>>>
>>>>> Date: Thu, 14 Dec 2023 15:53:46 +0000
>>>>> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>>>>
>>>> Hi Abdellatif,
>>>>
>>>>> Hi guys,
>>>>>
>>>>> I'd like to ask for advice regarding adding EFI RT support to the Ar=
m's FF-A bus
>>>>> in U-Boot.
>>>>>
>>>>> The objective is to enable the FF-A messaging APIs in EFI RT to be
>>>>> used for comms with the secure world. This will help getting/setting
>>>>> EFI variables through FF-A.
>>>>>
>>>>> The existing FF-A APIs in U-Boot call the DM APIs (which are not ava=
ilable at RT).
>>>>>
>>>>> Two possible solutions:
>>>>>
>>>>> 1/ having the entire U-Boot in RT space (as Simon stated in this dis=
cussion[1])
>>>>
>>>> I don't think this is a terribly good idea.  With this approach order=
s
>>>> of magnitude more code will be present in kernel address space one th=
e
>>>> OS kernel is running and calling into the EFI runtime.  Including cod=
e
>>>> that may access hardware devices that are now under OS control.  It
>>>> will be nigh impossible to audit all that code and make sure that onl=
y
>>>> a safe subset of it gets called.  So...
>>>
>>> +100
>>> I think we should draw a line here. I mentioned it on another thread,
>>> but I did a shot BoF in Plumbers discussing issues like this,
>>> problems, and potential solutions [0] [1]. Since that talk patches for
>>> the kernel that 'solve' the problem for RPMBs got pulled into
>>> linux-next [2].
>>
>> I watched your talk. Great work, thanks :)
>>
>>> The TL;DR of that talk is that if the kernel ends up being in control
>>> of the hardware that stores the EFI variables, we need to find elegant
>>> ways to teach the kernel how to store those directly. The EFI
>>> requirement of an isolated flash is something that mostly came from
>>> the x86 world and is not a reality on the majority of embedded boards.
>>> I also think we should give up on Authenticated EFI variables in that
>>> case. We get zero guarantees unless the medium has similar properties
>>> to an RPMB.
>>> If a vendor cares about proper UEFI secure boot he can implement
>>> proper hardware.
>>>
>>>>
>>>>>
>>>>> 2/ Create an RT variant for the FF-A APIs needed.
>>>>>        These RT variant don't call the DM APIs
>>>>>        (e.g: ffa_mm_communicate_runtime, ffa_sync_send_receive_runti=
me, ...)
>>>>>
>>>>> What do you recommend please ?
>>>>
>>>> ...this is what I would recommend.  Preferably in a way that refactor=
s
>>>> the code such that the low-level functionality is shared between the
>>>> DM and non-DM APIs.
>>>
>>> Yes. The only thing you need to keep alive is the machinery to talk to
>>> the secure world. The bus, flash driver etc should all be running
>>> isolated in there. In that case you can implement SetVariableRT as
>>> described the the EFI spec.
>>
>> Cool, thanks. That's my preferred solution too.
>>
>> mm_communicate() should be able to detect runtime mode so it calls ffa_=
mm_communicate_runtime().
>>
>> Is there a way to check whether we are in EFI runtime or not ?

Relevant UEFI event groups for the transition to the OS are:

EFI_EVENT_GROUP_BEFORE_EXIT_BOOT_SERVICES
EFI_EVENT_GROUP_EXIT_BOOT_SERVICES
EFI_EVENT_GROUP_VIRTUAL_ADDRESS_CHANGE

Once EFI_EVENT_GROUP_EXIT_BOOT_SERVICES is signaled you are at runtime.

Use CreateEventEx() to create an event for the group.

Best regards

Heinrich

>>
>> Suggested changes (pseudo-code):
>>
>> __efi_runtime mm_communicate () {
>> #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
>> if (RT) { /* NEW */
>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ffa_mm_communicate_runtime(comm_bu=
f, dsize); /* NEW */
>> } else {
>>  =C2=A0 =C2=A0 mm_comms =3D get_mm_comms();
>>  =C2=A0 =C2=A0 if (mm_comms =3D=3D MM_COMMS_FFA)
>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ffa_mm_communicate(comm_buf, dsize=
);
>>  =C2=A0 =C2=A0 else
>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D optee_mm_communicate(comm_buf, dsi=
ze);
>> }
>> #else
>> ...
>> #endif
>>
>> Existing code:  https://github.com/u-boot/u-boot/blob/master/lib/efi_lo=
ader/efi_variable_tee.c#L417
>
> A gentle reminder about the question above please (Is there a way to che=
ck whether we are in EFI runtime or not).
>
> Cheers,
> Abdellatif

