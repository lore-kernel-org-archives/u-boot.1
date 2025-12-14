Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DFCCFD314
	for <u-boot@archiver.kernel.org>; Sun, 14 Dec 2025 11:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 908F68036B;
	Sun, 14 Dec 2025 12:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cEReQW1Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 395658334F; Sun, 14 Dec 2025 12:22:31 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C441280107
 for <u-boot@lists.denx.de>; Sun, 14 Dec 2025 12:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1765711344; x=1766316144; i=xypron.glpk@gmx.de;
 bh=Qnzs81aDI+gbDY2RAmUcn56p9smfGJ5CRbA5Ppc6dQ8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cEReQW1ZIzlqvegCkLKPTNqbUphOt1chHNOZ+Xo3ynvyGp6LZe2DVnWteWlKo/Aw
 aQc9aDds3lxXU+qlGiY1JbxqSMRLoOwlQsmK59cJKcS0epK90s/kbqYTTRDjqF5ra
 sf/2WMRdjQSQxpaUs/3AlKOZNGuPzVHQzRpuBq/oy1rHwdIL4kwV2PwpA/xkSBNE/
 rvrwdHE0cyVlR8n+/AAR+sjW6GD80/52r/6tKKEC7CkIPNsKdbNowB9DHDDWZfucc
 +NGN1fs6Cf2v1gTW/rIv2iiMhx9H1g+aNUb9BNYblG7SUl7B+55htmb3GBfFSeJxS
 PlTvqbL2/bV41hK+QQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UV8-1vUCDS00CQ-009Yo3; Sun, 14
 Dec 2025 12:22:24 +0100
Message-ID: <257d0dca-ad77-483b-a91a-3c2d1c4f9b24@gmx.de>
Date: Sun, 14 Dec 2025 12:22:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi_loader: Trigger capsule updates with automatically
 generated boot options
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 John Toomey <john.toomey@amd.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Javier Tia <javier.tia@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, Yao Zi <ziyao@disroot.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maks Mishin <maks.mishinfz@gmail.com>, u-boot@lists.denx.de
References: <20251208151503.1681988-1-ilias.apalodimas@linaro.org>
 <1623f49d-708e-4e23-a92e-54636d92d239@gmx.de>
 <CAC_iWjKzi-eM6YkXG2xBTxBVKyrjUtqz=NnBw0ZLcF0y2W3vFA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjKzi-eM6YkXG2xBTxBVKyrjUtqz=NnBw0ZLcF0y2W3vFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5rLJJlF9u+HOwByJ/qieqPWPx/kK9b65a6L580gqxaSJ5AXX3eD
 J6w7HtWO6G0hHD1vsgL7rrlSte7inRTUm4o6rerRfoFwwUionlKxmw2lRGlXMSsQsz00DgM
 zJ0D27gMw9es/FKL3hjkpWZd7wEvINOt5rVWrz9t0DA7Db+a01CjqWpYqAuu9kUhZz8pwB9
 gcoz+zREK/60/Vg9d/PjA==
UI-OutboundReport: notjunk:1;M01:P0:LhWgXGLbHnQ=;/L/zKpYjxYZwYoYGWfyCJYG7RBI
 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
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

On 12/14/25 08:36, Ilias Apalodimas wrote:
> Hi Heinrich
>=20
> [...]
>=20
>>>    /*
>>>     * Determine if an MMC device is an SD card.
>>> @@ -109,10 +122,11 @@ struct efi_device_path *efi_dp_shorten(struct ef=
i_device_path *dp)
>>>     */
>>>    static efi_handle_t find_handle(struct efi_device_path *dp,
>>>                                const efi_guid_t *guid, bool short_path=
,
>>> -                             struct efi_device_path **rem)
>>> +                             struct efi_device_path **rem,
>>> +                             enum match match)
>>>    {
>>>        efi_handle_t handle, best_handle =3D NULL;
>>> -     efi_uintn_t len, best_len =3D 0;
>>> +     efi_uintn_t len, match_len =3D 0, best_len =3D 0;
>>>
>>>        len =3D efi_dp_instance_size(dp);
>>>
>>
>> Where is the documentation update for find_handle()?
>=20
> The description is in efi_dp_find_obj() which is the only place
> find_handle() is called. You want to add something in find_handle() as
> well?

I would like the function find_handle() to be documented in a way that=20
would allow to review its functionality irrespective of where it is used.

>=20
>>
>>> @@ -137,22 +151,35 @@ static efi_handle_t find_handle(struct efi_devic=
e_path *dp,
>>>                        if (!dp_current)
>>>                                continue;
>>>                }
>>> -             len_current =3D efi_dp_instance_size(dp_current);
>>> -             if (rem) {
>>
>> Before this patch calling efi_dp_find_obj(rem =3D=3D NULL) would only r=
eturn
>> exact matches.
>>
>> With the patch efi_dp_find_obj(rem =3D=3D NULL) matches shorter paths.
>>
>> Your commit message does not describe that you want to change the logic
>> of efi_fs_from_path().
>=20
> you mean efi_dp_find_obj()? I do mention the current functionality and
> how it changes. There's a paragraph in the commit message that
> explains that the function currently decides on the exact match based
> on the validity of the 'rem ptr and that an an enum is added. If it's
> unclear i'll reword it.

I have created

[PATCH 1/1] efi_selftest: enhance LoadImage test
https://lore.kernel.org/u-boot/20251214110937.136425-1-heinrich.schuchardt=
@canonical.com/T/#u

which demonstrates the unintended side effect which could not have been=20
derived from the code comments or the commit message.

Best regards

Heinrich

>=20
>>
>>> +
>>> +             match_len =3D len_current =3D efi_dp_instance_size(dp_cu=
rrent);
>>> +             switch (match) {
>>> +             case EXACT:
>>> +                     if (len_current !=3D len)
>>> +                             continue;
>>> +                     break;
>>> +             case SHORTER:
>>>                        if (len_current > len)
>>>                                continue;
>>> -             } else {
>>> -                     if (len_current !=3D len)
>>> +                     break;
>>> +             case LONGER:
>>> +                     if (len_current < len)
>>>                                continue;
>>
>> So here the logic is:
>>
>> When search for \a\b;
>>
>> \a\b\c\d is a better match than \a\b\c
>>
>> Is this intended?
>> I can't find it in the function description of find_handle().
>=20
> Yes it is, the description is in the efi_dp_find_obj(). You want me to
> move it around? Or expand find_handle() as well?
>=20
>>
>>> +                     match_len =3D len;
>>> +                     break;
>>>                }
>>> -             if (memcmp(dp_current, dp, len_current))
>>> +
>>> +             if (memcmp(dp_current, dp, match_len))
>>>                        continue;
>>>                if (!rem)
>>>                        return handle;
>>>                if (len_current > best_len) {
>>>                        best_len =3D len_current;
>>>                        best_handle =3D handle;
>>> -                     *rem =3D (void*)((u8 *)dp + len_current);
>>> +                     if (len_current <=3D len)
>>> +                             *rem =3D (void *)((uintptr_t)dp + len_cu=
rrent);
>>> +                     else
>>> +                             *rem =3D (void *)((uintptr_t)dp_current =
+ match_len);
>>>                }
>>>        }
>>>        return best_handle;
>>> @@ -160,14 +187,25 @@ static efi_handle_t find_handle(struct efi_devic=
e_path *dp,
>>>
>>>    efi_handle_t efi_dp_find_obj(struct efi_device_path *dp,
>>>                             const efi_guid_t *guid,
>>> -                          struct efi_device_path **rem)
>>> +                          struct efi_device_path **rem, bool match_lo=
nger)
>>>    {
>>>        efi_handle_t handle;
>>>
>>> -     handle =3D find_handle(dp, guid, false, rem);
>>> +     handle =3D find_handle(dp, guid, false, rem, EXACT);
>>
>> Here you are tweaking the logic a lot without really describing it:
>>
>> efi_dp_find(rem !=3D NULL) used to match in sequence:
>>
>> 1) exact long path
>> 2) longest long path with dp as start
>> 3) exact short path
>> 4) longest short path with dp as start
>>
>> now you have
>>
>> 1) exact long path
>> 2) exact short path
>> 3) longest long path with dp as start
>> 4) longest short path with dp as start
>>
>> This might be intended. But it is neither described in the commit
>> message nor in the function description.
>=20
> I'll reword the commit message.
>=20
>>
>>>        if (!handle)
>>> -             /* Match short form device path */
>>> -             handle =3D find_handle(dp, guid, true, rem);
>>> +             handle =3D find_handle(dp, guid, true, rem, EXACT);
>>> +     if (handle)
>>> +             return handle;
>>> +
>>
>> Check the value of rem here (see comment above).
>=20
> Sure
>=20
>>
>> Having both rem !=3D NULL and match_longer =3D=3D true wouldn't make mu=
ch sense.
>>
>> Theorectically we could use *rem =3D=3D LONGER for allowing longer DPs =
and
>> *rem =3D=3D SHORTER for other cases to avoid the extra argument.
>>
>> #define LONGER ((void *)(uintptr_t) - 1)
>> #define SHORTER (NULL)
>=20
> Sure, but I think the enum is clearer. Unless you really want this
> I'll keep the enum
>=20
> Thanks
> /Ilias
>=20
>>
>> Best regards
>>
>> Heinrich
>>
>>> +     handle =3D find_handle(dp, guid, false, rem, SHORTER);
>>> +     if (!handle)
>>> +             handle =3D find_handle(dp, guid, true, rem, SHORTER);
>>> +
>>> +     if (match_longer && !handle) {
>>> +             handle =3D find_handle(dp, guid, false, rem, LONGER);
>>> +             if (!handle)
>>> +                     handle =3D find_handle(dp, guid, true, rem, LONG=
ER);
>>> +     }
>>>
>>>        return handle;
>>>    }
>>> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
>>> index 130c4db9606f..0d3d7c187d72 100644
>>> --- a/lib/efi_loader/efi_disk.c
>>> +++ b/lib/efi_loader/efi_disk.c
>>> @@ -339,7 +339,7 @@ efi_fs_from_path(struct efi_device_path *full_path=
)
>>>        efi_free_pool(file_path);
>>>
>>>        /* Get the EFI object for the partition */
>>> -     efiobj =3D efi_dp_find_obj(device_path, NULL, NULL);
>>> +     efiobj =3D efi_dp_find_obj(device_path, NULL, NULL, false);
>>>        efi_free_pool(device_path);
>>>        if (!efiobj)
>>>                return NULL;
>>> --
>>> 2.43.0
>>>
>>

