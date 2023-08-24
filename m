Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35009C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3797E86504;
	Thu, 24 Aug 2023 16:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KoCYa38f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3641386433; Thu, 24 Aug 2023 16:02:56 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B93C8650F
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692885772; x=1693490572; i=xypron.glpk@gmx.de;
 bh=YRChIWlXyYqfbAOC8hgVZY2vbIcg/HpL9ecpI5LwjWY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=KoCYa38fXPuAKSRqh6jwdab/LcIbe2oe5OJf2Um0BzIsPm6bLRDenGgrGD28PlKRsWayUpc
 M1rfsYeuhMMo/VOXvuKR7JEZtbKHap+0kZ1E08Tfc4m7iK8N0zsmFi++eQWiirEdPKJGgOePT
 xpMs12b7I1hf+cyZUd0gNKaGJeId9uLg/1IAlOVTOu2hqn6VlyuA/B/oBzeYCUPvksHKZqkmZ
 Ya4vKYzJZ8wiD3eFh7PbCDstj7QD/SKXuz9R2mCwkbMBaFLK/gyMWoWPGjY7lC4etbgRqTAj1
 bebnhsCnI/EfPBSwc06ay2L2yTFTq11ifsxMcWOTweiPtw+QRWIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([62.143.244.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmfi-1qAKYA1dFq-00TCxs; Thu, 24
 Aug 2023 16:02:52 +0200
Message-ID: <4b0ee7eb-0d8f-3a83-791a-e4bef539fd8a@gmx.de>
Date: Thu, 24 Aug 2023 16:02:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] efi_loader: delete handle from events when a protocol is
 uninstalled
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
References: <20230824115500.2388636-1-ilias.apalodimas@linaro.org>
 <b84b35df-c146-5255-f9b6-427688cd7eeb@gmx.de>
 <CAC_iWjLUFe=tBAZTndrzusDLpuFExSFRjjRxgzeZ1iL=_y57Kg@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjLUFe=tBAZTndrzusDLpuFExSFRjjRxgzeZ1iL=_y57Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8LgjJxjjQMsbj7rqcb2C1Nj3q+MjIq4LJzyvkcThQQScOkAdbpG
 tS3PlgNND3OrMrKki2G9h7MlBh6yaJ35+OBHJ5K9bQYb+foHZ9CtiKVA981bsNjwSfWf2+P
 oKazyu/zAnjXZzgY9HB1ezrhA11bD3WvEeQsRZBWuWbFYEXB13+WBU4Q9kYrOifDR8SznSO
 pRghji1gY6Q1dL5Rgr63A==
UI-OutboundReport: notjunk:1;M01:P0:BceyV4p6Uyo=;GAWhZf0UkRBtwLEOHz37LHt21i+
 eJyTUszvpmRuMFg6estjFlZF8GXQ2/3oCID+HAMunIsRGXxXUqZSAH1lShlbTMjPOgOUpjWOt
 jFtqfSKk4VIy4VFOLqM+Xd82GnPVn8Vyp/2Lq4e838Ucl/YFKMR1zlv3stT6keRPy8WhdXz+z
 PkG3w/AG5ZTOZtjR+y8pThAJhhEMYItMA9EyU9/aIFlUZ3tAw24uTSjIK9CNSVX8MfsvWhYSZ
 zsMwP8Vrx1EXozMOXMP+xcGHJNZSGAtlAnXUipUcpmfD8SMqPptZyNGehmauYh1nfm+VHwiN/
 6WI2hK9pW0x3gRj5OWOpumr7tkUtEuzaGvK52jYbq3pWPRBxAkUVajvS7c0wZoXtX+Pi1UkFC
 rd4zHGhjo09fh8sV3L23/ApUfc0yzcB4BJUUa2WsB54YZ+9WrQcdiJuWqRXD2KFz8FZP0Yx3F
 edaByxrmJi39kF15vBfKWc8F55BimLDUKKacHMdSLAoCB9NV+ykbyCGzqQXBDTX4tjHOB28sU
 +ydsrm/Jm1oWrYz0GAQh67ZkT3QAir+UY5AKaXVM6gG8tZYLt9EvdKdtR4bLKBPhUIoWkOGrl
 Txa6Gt+cPyjsWRYF1185SjXqyKHxgkymh5+WqDiG2If6ddrcyJxEZCH1ulEHV1PeXAACXYMQO
 3yln1J7HDlCxc5mLHlfIQnKIxX+EfSmDu0Wh4I5da8HLwJmT3vEdCm7u6baALg+4iGOwLlp/p
 q8+LFye5S109yOR2IqW4tqMm5YxYZq5tSJh5FVFp7EROV3YfpT6UQQ9HbIJTmgnNY17wa5XSd
 92cC5uJz2/pFbO7dWyNMKJMOpQS3UzgOU1NQ4ztfFa/6GQ7ppUwt6T2QSMJA7hjbxTTLQBMoZ
 YnUaycYam8p+TPjNGmrSE5e+ge8SFr7JbOuXlrS5lz9EaDrMTtddWSDnGtE7Dks5Q0Q+x4YC0
 V876VSaXXbpKDjCzl2S83plr3g8=
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

On 24.08.23 15:06, Ilias Apalodimas wrote:
> Hi Henrich
>
>
>>>
>>> +/**
>>> + * efi_purge_handle() - Clean the deleted handle from the various lis=
ts
>>> + * @handle: handle to remove
>>> + *
>>> + * Return: status code
>>> + */
>>> +static efi_status_t efi_purge_handle(efi_handle_t handle)
>>> +{
>>> +     struct efi_register_notify_event *item, *next;
>>> +
>>> +     if (!list_empty(&handle->protocols))
>>> +             return EFI_ACCESS_DENIED;
>>> +     /* The handle is about to be freed. Remove it from events */
>>> +     list_for_each_entry_safe(item, next, &efi_register_notify_events=
, link) {
>>
>> You are not deleting from efi_register_notify_events.
>
> I am not sure I understand this.  I am not trying to delete the event
> here, but the handle on which the notified protocol was installed.
>
>>   Why do you use the safe version of the iterator?
>
> No particular reason, I just tend to prefer it over the unsafe one.
> The latter is perfectly fine here.

The save version is only needed if you delete the current item or insert
in the current position.

>
> [...]
>
>>>
>>> -     /* If the last protocol has been removed, delete the handle. */
>>> -     if (list_empty(&handle->protocols)) {
>>
>>>        size_t i =3D 0;
>>> @@ -2795,25 +2827,25 @@ efi_uninstall_multiple_protocol_interfaces_int=
(efi_handle_t handle,
>>>                return EFI_INVALID_PARAMETER;
>>>
>>>        efi_va_copy(argptr_copy, argptr);
>>> +     protocol =3D efi_va_arg(argptr, efi_guid_t*);
>>>        for (;;) {
>>> -             protocol =3D efi_va_arg(argptr, efi_guid_t*);
>>> +             bool preserve =3D true;
>>> +
>>>                if (!protocol)
>>>                        break;
>>>                protocol_interface =3D efi_va_arg(argptr, void*);
>>> +             next_protocol =3D efi_va_arg(argptr, efi_guid_t*);
>>> +             if (!next_protocol)
>>> +                     preserve =3D false;
>>
>> Is your idea that if 5 protocols are to be removed but only the first 3
>> are installed your want to reinstall the first 3?
>
> Not only that. Image you install 2 protocols and then someone tries to
> uninstall 3. If the invalid guid/protocol is at the beginning or the
> middle of the list you'll be fine.  The current code will reinstall
> the previously removed protocols.
> However, if the invalid protocol is last, you will have removed 2
> valid protocols and the handle will be empty.  In that case, we will
> delete the handle before trying to reinstall the uninstalled
> protocols.

This is just what I meant.

Best regards

Heirnich

>
>>
>> Can we have some code comment describing what the function should do? I=
n
>> 5 years nobody will remember why the code was implemented this way.
>>
>
> Of course
>
> [...]
>
> Cheers
> /Ilias

