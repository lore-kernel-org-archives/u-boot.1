Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229C8C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 07:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E1087C9A;
	Fri, 15 Mar 2024 08:58:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cvc43M/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9395C87CDB; Fri, 15 Mar 2024 08:58:26 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D982287B82
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1710489497; x=1711094297; i=xypron.glpk@gmx.de;
 bh=vk5iRCSgG1hs0aCA2xHNKVVxmQZ1Ja/3gFBwf0qaUSM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=cvc43M/w96tOL5Z3a/2jf9tiE7OMGqlrBHiQ1RjGe0+cfn4fKLurnuYAHdqcuI71
 8hFHq/1VbCeoBbhwTCAb64I73x82ztxxAMa711yjwBKz1l6Qyrqm7/EGTz9XOezOX
 3UIb8vsVFC3eF1AhE0qPG97cOK4fP/VfJ2VgS+h+d5KC0p2OQPiwnWxvKgqqUphif
 ZwSZbkxD/JGzxH1JvCvuk+ICG/aVCgvASSHraWR9x+bFiX41V+HIypnvK+h2XOCAd
 B35e06Y0LQm9tvbakoZWlGuGfL9BERI/e+bK8+mBH9B2UQTA44/RP0a41M+kLCtLv
 sGARDh66N4qyJXUz5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1qoDFE1igP-013O2C; Fri, 15
 Mar 2024 08:58:17 +0100
Message-ID: <4adb368c-87ad-423e-8782-7cf35a3f9550@gmx.de>
Date: Fri, 15 Mar 2024 08:58:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: accept append write with valid size and data
To: kojima.masahisa@socionext.com
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240304061100.2386856-1-kojima.masahisa@socionext.com>
 <CAC_iWjL1P0HLv+PJ6aH+=n-PBtaq=dqYujzVA+J+_yp1x20Nkg@mail.gmail.com>
 <TYCPR01MB83750A2962738D3D4C8BFC5EE3282@TYCPR01MB8375.jpnprd01.prod.outlook.com>
 <CAC_iWj+jpjn17yAvBDi3Q+j-YrZyeo4sXzSYJay63HY4iZSeqg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWj+jpjn17yAvBDi3Q+j-YrZyeo4sXzSYJay63HY4iZSeqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LJNAbCwJn0M3ZVqgVver6WlSQwbYAOXx88sGvjzxk022RbNC1vU
 iA6thpFyn+NZn7CVDkdt3pXILBy5SqCCHyFzbM7/muLHl4M6MdG2/C6PkUtdkabGUIiZwH5
 LRG8Ogp9Q8T5BQ0KZdp3oyfSx6dbnrVx+RDh1VZSWrIv0cqtPZukv1lfoGCENcxT6B/iqq+
 nYi/n9oFpKHIbM3+GQ+xw==
UI-OutboundReport: notjunk:1;M01:P0:7HNqumxjZTo=;x41J+bre1wi10VZemB6o0Kka2yh
 NerJaF2BnYTfsuEXjLuWOHlrDgYQVal/dawj/nd+HrtfDNzIa8TEudwgps07qFaimsK/XhQwv
 slzJWEP006nfZPQcvyzU9H/PSdKx2Miq0w98h7IWYZhIPIGiFQ/dSRKryXxBt9GJthQmGPUGn
 bTJ8PvsxXxPRkQgkLNnK8nLTTsbK3eY8ykN9rgCp4/A333bdKgWLoRlG2KZlEkG5LZdLYGMVQ
 +uPAwLBrkuCR+TlMpKDZkvKb22LdaCe/urlGBHA9HQCfaf3Mj6Q5p1jS+I4mCpfdSgU8rSYK3
 YGHP2jIu9Y0H3S+DN667xi0VbqN5kMSD2iiWA5FXeFixU4fi+XtngvgfKh9XsU6tfZ1zinIFY
 iAeqTvrxSb0mm/ChFiQzFTtUBnC6bl7RR49DuNy3NP8wZaTVAzi60tRsCYunYFr1ppZt64VUa
 omUPsLpSqCcMnugNIGDpJyyuHom8sIUMu48TAWg+GuMmJjPZ0OllXZJ9V0TaQJfCzWXaHaeCk
 6G2zibVNNnL9anBx5J7L0JYMsiUSy4AZ70X9NWTYDyGCQkJ1aR968vZP6qjklkWcrN1H6nFUy
 2iVCmFmkBDVngKmQa5ct2Uf9DP9fnL4Ykca0B31W+hr+okicAYCUchYs0BmHjxrdS4vsOaFGl
 rGKMUb5XsifH3soaVOzhSPOG6XAOtMXLO22hvMIxodOViNns/eRDzt8EFIlBYpAYzIrbLNaDi
 x+VF76tzZLibSw19G7qDElngUta+D6NrLkqiRdSLXlVEEwGV19OPUIDs2GmAtdbuSkF7RKg5P
 lfpfytc2HUB5TVkYzn8apRkIlcKJAcauIs/nUngUvWa/E=
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

On 3/15/24 08:03, Ilias Apalodimas wrote:
> Hi Kojima-san
>
> On Fri, 15 Mar 2024 at 02:10, <kojima.masahisa@socionext.com> wrote:
>>
>> Hi Ilias,
>>
>>> -----Original Message-----
>>> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> Sent: Thursday, March 14, 2024 10:54 PM
>>> To: Kojima, Masahisa/=E5=B0=8F=E5=B3=B6 =E9=9B=85=E4=B9=85 <kojima.mas=
ahisa@socionext.com>
>>> Cc: u-boot@lists.denx.de; Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> Subject: Re: [PATCH] efi_loader: accept append write with valid size a=
nd data
>>>
>>> Hi Kojima-san
>>>
>>> Apologies for the late reply
>>>
>>> On Mon, 4 Mar 2024 at 08:10, Masahisa Kojima
>>> <kojima.masahisa@socionext.com> wrote:
>>>>
>>>> Current "variables" efi_selftest result is inconsistent
>>>> between the U-Boot file storage and the tee-based StandaloneMM
>>>> RPMB secure storage.
>>>> U-Boot file storage implementation does not accept SetVariale
>>>> call to non-existent variable with EFI_VARIABLE_APPEND_WRITE
>>>> attribute and valid size and data, however it is accepted
>>>> in EDK II StandaloneMM implementation.
>>>
>>> Yes,
>>>
>>>>
>>>> Since UEFI specification does not clearly describe the behavior
>>>> of the append write to non-existent variable, let's update
>>>> the U-Boot file storage implementation to get aligned with
>>>> the EDK II reference implementation.
>>>>
>>>> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
>>>> ---
>>>>   lib/efi_loader/efi_variable.c             | 13 +++++-----
>>>>   lib/efi_selftest/efi_selftest_variables.c | 30
>>> +++++++++++++++++++++--
>>>>   2 files changed, 35 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_varia=
ble.c
>>>> index 40f7a0fb10..1693c3387b 100644
>>>> --- a/lib/efi_loader/efi_variable.c
>>>> +++ b/lib/efi_loader/efi_variable.c
>>>> @@ -282,11 +282,8 @@ efi_status_t efi_set_variable_int(const u16
>>> *variable_name,
>>>>                  }
>>>>                  time =3D var->time;
>>>>          } else {
>>>> -               if (delete || append)
>>>> -                       /*
>>>> -                        * Trying to delete or to update a non-existe=
nt
>>>> -                        * variable.
>>>> -                        */
>>>> +               if (delete)
>>>> +                       /* Trying to delete a non-existent variable. =
*/
>>>>                          return EFI_NOT_FOUND;
>>>
>>> I am not sure about this tbh. The UEFI spec says
>>> "When the EFI_VARIABLE_APPEND_WRITE attribute is set, then a
>>> SetVariable() call with a DataSize of zero will not cause any change
>>> to the variable value (the timestamp
>>> associated with the variable may be updated however, even if no new
>>> data value is provided;see the description
>>> of the EFI_VARIABLE_AUTHENTICATION_2 descriptor below). In this case
>>> the DataSize will not be zero
>>> since the EFI_VARIABLE_AUTHENTICATION_2 descriptor will be populated)"
>>>
>>> I think this assumes the variable exists. Is there a different chapter
>>> in the spec that describes the behavior?
>>
>> No, I could not find it.
>> I'm also not sure what the UEFI spec expects.
>
> I don't have any objections to aligning this with EDK2. But can we add
> a comment about it as well?
> Heinrich any preference here?
>
> [...]
>
>>> non-existent variable returns wrong code\n");
>>>> +               efi_st_error("Variable was not deleted\n");
>>>>                  return EFI_ST_FAILURE;
>>>
>>> This used to fail as well [0]. Does it work now?
>>
>> Yes. With this patch applied, both U-Boot file storage and StMM
>> pass the efi selftest.
>
> Yes, that's obviously a hack. The reason we didn't bother fixing it
> back then is because stmm is not running in our CI, but I should have
> added a comment on that instead of having it on email history...

Hello Kojima,

Thank you for pointing out the inconsistencies.

I have created https://mantis.uefi.org/mantis/view.php?id=3D2447 to
discuss the expected behavior.

The logic in MdeModulePkg/Universal/Variable/RuntimeDxe/Variable.c is:

If the variable does not exist and EFI_VARIABLE_APPEND_WRITE is set and
the size is non-zero, the variable is created.
If the variable does not exist and EFI_VARIABLE_APPEND_WRITE is set and
the size is zero, the variable is not created and EFI_SUCCESS is returned.

I am not able to derive this from the specification.

In our selftest we should test the following four cases of
EFI_VARIABLE_APPEND_WRITE:

variable existing, size non-zero
variable existing, size zero
variable non-existent, size non-zero
variable non-existent, size zero

Could you, please, check if the StMM logic matches
MdeModulePkg/Universal/Variable/RuntimeDxe/Variable.c for all four cases.

If yes, we should change the our file based implementation to match these.

Best regards

Heinrich

>>>
>>>>          }
>>>>          /* Enumerate variables */
>>>> --
>>>> 2.34.1
>>>>
>>>
>>> [0]
>>> https://lore.kernel.org/u-boot/CAC_iWjL2G2mvQb6WNGLTxr+xj64xrYuOKr8G
>>> 3-3z8Lv7yX5XSg@mail.gmail.com/
>>>
>>> Regards
>>> /Ilias

