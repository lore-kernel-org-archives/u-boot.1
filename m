Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B05C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 06:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DCE487D83;
	Thu, 21 Mar 2024 07:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WHbGyeh0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A3C88063; Thu, 21 Mar 2024 07:21:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F30F87D6B
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 07:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711002086; x=1711606886; i=xypron.glpk@gmx.de;
 bh=Sa1cI2FumaTfiKQ93/XPs42N61yS4/eomAI98zQQi1Y=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=WHbGyeh0U9UCX3VKo7J72fel+dq2XYTtHEa1L+4+lSi6a99wTXfAxEYuyMID4N7x
 zFaPyUYEqi8MRLiPZEyXXpYnumcWR9vtZjFX1/k7IIOYnXhEWYqFZDjLGzQugerGh
 Bnpc7oFbTMwTc/mh7ZZh4JtNL807GOT0/SJdnqFWSdCcrZZHJunKs5u4vkUWpolqn
 gGFi1jsU3Iqp9Se0t4Ysm+4vZJjlkqKC5xJ4eHE+dwKeFqNss1m90tShCDjeLdfi6
 wYk2Q8rykNrKKq43pGAE1aVgtlT7j6phG4n/d+0y1KDZRBdSi+Di68Zaci7j0aK+x
 EtWozYv5Jja2J/hkEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1qv6BG05iG-00uFK8; Thu, 21
 Mar 2024 07:21:26 +0100
Message-ID: <4c240b32-4eaf-46a1-a4d1-49eda1cc9af0@gmx.de>
Date: Thu, 21 Mar 2024 07:21:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: accept append write with valid size and data
To: kojima.masahisa@socionext.com
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org
References: <20240304061100.2386856-1-kojima.masahisa@socionext.com>
 <CAC_iWjL1P0HLv+PJ6aH+=n-PBtaq=dqYujzVA+J+_yp1x20Nkg@mail.gmail.com>
 <TYCPR01MB83750A2962738D3D4C8BFC5EE3282@TYCPR01MB8375.jpnprd01.prod.outlook.com>
 <CAC_iWj+jpjn17yAvBDi3Q+j-YrZyeo4sXzSYJay63HY4iZSeqg@mail.gmail.com>
 <4adb368c-87ad-423e-8782-7cf35a3f9550@gmx.de>
 <TYCPR01MB837592496ABA6AB9262B1085E32D2@TYCPR01MB8375.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <TYCPR01MB837592496ABA6AB9262B1085E32D2@TYCPR01MB8375.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:34STE4FkMNqoqpyaH9o1WLOkP/xWXh6TYyx4ZgFbzNcdhvzQhCR
 qybMfKzgiPXJb1U18+tFvNWg8BoCrvyMz/nhvcisECPVucUvOuQQjqVAVfq08oy3V6c8q82
 X1mYSZSXrimYIVRRYhLpNOdpj6aRqj53uPd8m/r/Eecu7PDF2lIqSPJ3o3BaTBRAJy/bdg9
 49/wE1h0tY0EJzDK2CkEg==
UI-OutboundReport: notjunk:1;M01:P0:yBEIkKzXpkk=;QgGoiCiYdjWgYt4rBYVjCbgDxw8
 sp7ZnE1kIxu7fBcUkeScwe5mqRnscJrQsSB4vEjATDkUm12a6llUp85k3ppqYDuPyq05bLGh0
 C7in4ziRA3l9mffeskKF9NvLa5Cxq/9z/6Xv8TH2PYLthkADb6aFALHzYgdWl+/QaZ8Jjags0
 0bvFATdVSYiHNabVU0SjhJtVwd24qlflSnClkbP1xibzWm2w3xI0m3DmWDsWYGpNNQWICI+kf
 mBA8h+C8NMZN8VEqCVq0k8wMyYBk261mSk5zMKwDb40Kbt8d7Lfg1L1CNqlv4BJpGpE1P1xKn
 b9H97J3N+26KDbrLtgBp3giL8IohwJ7WDbtZsKlRrzbqh9G2pBzeS3nzV5gWFTrXg8SBdp/tz
 KlS2aVo3+ofjTlJSmSyMQvs2l/zuxgSGc/pG4uHfuOItAJTulOll0A0Qo6W0L8vN+35MLSMtr
 mVIqXyp/IHPSczIPuThlmCMgO0twQPSYjI4mtXAcP8+b0qRKtQJzZmRQeIZYmta0MCJV7AtRF
 6Ic/DMUgMS/c5wea9VcKugjMDBVatvaV+Yu+NazZKtTxPep+rEioJqYqZLN4Ll7WfWembq1tV
 wad5eYz79ONWyfYqloaA/BbfsqWGf2LV2DuMTFzu4Ls1hpOuyxZSqTwejcESroRKZEBC3+fuo
 NICGLuS01NLaSEX8oveixYSUI5JjZOqVq4mkPyLEC4Gg9Z6IIc+IHn6hblSt2FtuHJ83oBkFF
 YH6W+Tg7jd4daAxzAcT/OOnixRPN2YcvTPFw9JjuBbKHeLwQhhdA3FZ9fPBHjtlUK9wYICc/7
 VLSC9gkaXPwGb06TtYqCeX6fP97KH6FWMZlJOP6ZWrLzk=
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

On 3/18/24 03:46, kojima.masahisa@socionext.com wrote:
> Hi Heinrich,
>
>> -----Original Message-----
>> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Sent: Friday, March 15, 2024 4:58 PM
>> To: Kojima, Masahisa/=E5=B0=8F=E5=B3=B6 =E9=9B=85=E4=B9=85 <kojima.masa=
hisa@socionext.com>
>> Cc: u-boot@lists.denx.de; Ilias Apalodimas <ilias.apalodimas@linaro.org=
>
>> Subject: Re: [PATCH] efi_loader: accept append write with valid size an=
d data
>>
>> On 3/15/24 08:03, Ilias Apalodimas wrote:
>>> Hi Kojima-san
>>>
>>> On Fri, 15 Mar 2024 at 02:10, <kojima.masahisa@socionext.com> wrote:
>>>>
>>>> Hi Ilias,
>>>>
>>>>> -----Original Message-----
>>>>> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>>> Sent: Thursday, March 14, 2024 10:54 PM
>>>>> To: Kojima, Masahisa/=E5=B0=8F=E5=B3=B6 =E9=9B=85=E4=B9=85 <kojima.m=
asahisa@socionext.com>
>>>>> Cc: u-boot@lists.denx.de; Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>>> Subject: Re: [PATCH] efi_loader: accept append write with valid size=
 and
>> data
>>>>>
>>>>> Hi Kojima-san
>>>>>
>>>>> Apologies for the late reply
>>>>>
>>>>> On Mon, 4 Mar 2024 at 08:10, Masahisa Kojima
>>>>> <kojima.masahisa@socionext.com> wrote:
>>>>>>
>>>>>> Current "variables" efi_selftest result is inconsistent
>>>>>> between the U-Boot file storage and the tee-based StandaloneMM
>>>>>> RPMB secure storage.
>>>>>> U-Boot file storage implementation does not accept SetVariale
>>>>>> call to non-existent variable with EFI_VARIABLE_APPEND_WRITE
>>>>>> attribute and valid size and data, however it is accepted
>>>>>> in EDK II StandaloneMM implementation.
>>>>>
>>>>> Yes,
>>>>>
>>>>>>
>>>>>> Since UEFI specification does not clearly describe the behavior
>>>>>> of the append write to non-existent variable, let's update
>>>>>> the U-Boot file storage implementation to get aligned with
>>>>>> the EDK II reference implementation.
>>>>>>
>>>>>> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
>>>>>> ---
>>>>>>    lib/efi_loader/efi_variable.c             | 13 +++++-----
>>>>>>    lib/efi_selftest/efi_selftest_variables.c | 30
>>>>> +++++++++++++++++++++--
>>>>>>    2 files changed, 35 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_var=
iable.c
>>>>>> index 40f7a0fb10..1693c3387b 100644
>>>>>> --- a/lib/efi_loader/efi_variable.c
>>>>>> +++ b/lib/efi_loader/efi_variable.c
>>>>>> @@ -282,11 +282,8 @@ efi_status_t efi_set_variable_int(const u16
>>>>> *variable_name,
>>>>>>                   }
>>>>>>                   time =3D var->time;
>>>>>>           } else {
>>>>>> -               if (delete || append)
>>>>>> -                       /*
>>>>>> -                        * Trying to delete or to update a non-exis=
tent
>>>>>> -                        * variable.
>>>>>> -                        */
>>>>>> +               if (delete)
>>>>>> +                       /* Trying to delete a non-existent variable=
. */
>>>>>>                           return EFI_NOT_FOUND;
>>>>>
>>>>> I am not sure about this tbh. The UEFI spec says
>>>>> "When the EFI_VARIABLE_APPEND_WRITE attribute is set, then a
>>>>> SetVariable() call with a DataSize of zero will not cause any change
>>>>> to the variable value (the timestamp
>>>>> associated with the variable may be updated however, even if no new
>>>>> data value is provided;see the description
>>>>> of the EFI_VARIABLE_AUTHENTICATION_2 descriptor below). In this
>> case
>>>>> the DataSize will not be zero
>>>>> since the EFI_VARIABLE_AUTHENTICATION_2 descriptor will be
>> populated)"
>>>>>
>>>>> I think this assumes the variable exists. Is there a different chapt=
er
>>>>> in the spec that describes the behavior?
>>>>
>>>> No, I could not find it.
>>>> I'm also not sure what the UEFI spec expects.
>>>
>>> I don't have any objections to aligning this with EDK2. But can we add
>>> a comment about it as well?
>>> Heinrich any preference here?
>>>
>>> [...]
>>>
>>>>> non-existent variable returns wrong code\n");
>>>>>> +               efi_st_error("Variable was not deleted\n");
>>>>>>                   return EFI_ST_FAILURE;
>>>>>
>>>>> This used to fail as well [0]. Does it work now?
>>>>
>>>> Yes. With this patch applied, both U-Boot file storage and StMM
>>>> pass the efi selftest.
>>>
>>> Yes, that's obviously a hack. The reason we didn't bother fixing it
>>> back then is because stmm is not running in our CI, but I should have
>>> added a comment on that instead of having it on email history...
>>
>> Hello Kojima,
>>
>> Thank you for pointing out the inconsistencies.
>>
>> I have created https://mantis.uefi.org/mantis/view.php?id=3D2447 to
>> discuss the expected behavior.
>
> Thank you.
> My company is not the member of uefi and probably I could not create the=
 account.
>
>>
>> The logic in MdeModulePkg/Universal/Variable/RuntimeDxe/Variable.c is:
>>
>> If the variable does not exist and EFI_VARIABLE_APPEND_WRITE is set and
>> the size is non-zero, the variable is created.
>> If the variable does not exist and EFI_VARIABLE_APPEND_WRITE is set and
>> the size is zero, the variable is not created and EFI_SUCCESS is return=
ed.
>>
>> I am not able to derive this from the specification.
>>
>> In our selftest we should test the following four cases of
>> EFI_VARIABLE_APPEND_WRITE:
>>
>> variable existing, size non-zero
>> variable existing, size zero
>> variable non-existent, size non-zero
>> variable non-existent, size zero
>>
>> Could you, please, check if the StMM logic matches
>> MdeModulePkg/Universal/Variable/RuntimeDxe/Variable.c for all four case=
s.
>
> The variable service logic is common, StMM also uses
> MdeModulePkg/Universal/Variable/RuntimeDxe/Variable.c for Variable Servi=
ce[1].
>
>>
>> If yes, we should change the our file based implementation to match the=
se.
>
> Current situation of append write is as follows.
>
> #1 variable existing, size non-zero =3D> OK
>   StMM: append write
>   U-Boot: append write
>
> #2 variable existing, size zero =3D> OK
>   StMM: will not delete, return EFI_SUCCESS
>   U-Boot: will not delete, return EFI_SUCCESS
>
> #3 variable non-existent, size non-zero =3D> inconsistent
>   StMM: create new variable
>   U-Boot: return EFI_NOT_FOUND
>
> #4 variable non-existent, size zero  =3D> inconsistent
>   StMM: will not create variable, return EFI_SUCCESS
>   U-Boot: return EFI_NOT_FOUND
>
> My original patch tried to fix above case #3.
> Currently U-Boot does not have selftest for case #4, we need to add a te=
st
> and also modify the behavior if needed.
>   # I'm not sure that the edk2 implementation of #4 is correct and expec=
ted anyway.

Hello Kojima,

I don't believe EDK II will change. So let us return EFI_SUCCESS in case
#4, too.

Could you, please, re-submit the patch with that change.

I hope
[PATCH 1/1] .mailmap entry for Masahisa Kojima
https://lore.kernel.org/u-boot/20240318104718.18365-1-heinrich.schuchardt@=
canonical.com/
is fine for you. Could you, please, add your review.

Best regards

Heinrich

>
> [1] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Universal=
/Variable/RuntimeDxe/VariableSmm.c#L94
>
> Thanks,
> Masahisa Kojima
>
>>
>> Best regards
>>
>> Heinrich
>>
>>>>>
>>>>>>           }
>>>>>>           /* Enumerate variables */
>>>>>> --
>>>>>> 2.34.1
>>>>>>
>>>>>
>>>>> [0]
>>>>>
>> https://lore.kernel.org/u-boot/CAC_iWjL2G2mvQb6WNGLTxr+xj64xrYuOKr8G
>>>>> 3-3z8Lv7yX5XSg@mail.gmail.com/
>>>>>
>>>>> Regards
>>>>> /Ilias
>

