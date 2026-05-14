Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112CACD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 11:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68E11845E3;
	Thu, 14 May 2026 13:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="M1V4aWfR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A242C845E3; Thu, 14 May 2026 13:39:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCFE0800AE
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 13:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1778758791; x=1779363591; i=xypron.glpk@gmx.de;
 bh=1PbWNAOYxnbJ/js0A/HLvpsEuYzVT+eAk5A244RiUVo=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=M1V4aWfRW4JX8Xfd569JCIIQm1seqScCFu52asXq75TaIMDTJwG8pauaGRRmauaR
 eIdCMLC8UJptUBvR/6nQPgM/J+3SFt6DhX/gyaoRf7GiA6iQ4pkk53pTx+O/IdiJs
 8kf8dyJpkJjEaCiJp2MAiHnlXLwMlUBEtTkUNv/81rnJkFUL8QSz/SEdzv088KAnQ
 z12uJThQU8hq7ymwjUemHHvP5+oDSq2+MzMNwKKpmaFwV0imfvEKOyP4f6TryEyYU
 wUZVsEB8g2YPjS0px7oz+h/hnDHQNieyg3yWnMhq5B4BLH6X+rjsqz3EZlC2cmzd7
 c8JGJl6jJqV2E00TiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUm7-1wXdZQ1vx9-004qut; Thu, 14
 May 2026 13:39:51 +0200
Date: Thu, 14 May 2026 13:39:48 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: trini@konsulko.com, michal.simek@amd.com, u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_efi=5Floader=3A_Remove_au?=
 =?US-ASCII?Q?thentication_header_in_GetVariable=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <12a09e02-3093-47a6-850b-3be4e63b1ccb@oss.qualcomm.com>
References: <20260512194205.1905069-1-aswin.murugan@oss.qualcomm.com>
 <CAC_iWj+tD8eOKxem3m94BWX42GTLuCD7tqEW0GUdtsPLpLcYqw@mail.gmail.com>
 <12a09e02-3093-47a6-850b-3be4e63b1ccb@oss.qualcomm.com>
Message-ID: <2B0242ED-9FA5-44DA-8324-7D21E692B01A@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0HM3J7ioOQbtXaLA8R6hD2PGk+w26wVKGKqprD2es1smIgiTnkB
 9kbFnAUdKWm6dq+LIvhLFsp9a5uZVsMK58FUD1eU0Je2YXRIXR6WPbB6v8CJInM9q+qsI6+
 iwm8z3lH1WHEHtmysBn4/e2EpkN5bY22VaFAoPI0fZGGnWJHyBkvx2wwgvmOUpR30e3psiP
 POlMIM/1N5Xk61TEQNebg==
UI-OutboundReport: notjunk:1;M01:P0:NT48Jm4Itqg=;ZxvHr6gsW6yFd6bPhg2glZX1Tc/
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

Am 14=2E Mai 2026 13:01:08 MESZ schrieb Aswin Murugan <aswin=2Emurugan@oss=
=2Equalcomm=2Ecom>:
>Hi Ilias,
>
>We are attempting to pre-seed ubootefi=2Evar created using the *efivar=2E=
py* tool for authenticated EFI variables=2E
>Currently, efivar=2Epy writes variables including the full authentication=
 descriptor (timestamp + WIN_CERTIFICATE + payload) into ubootefi=2Evar=2E

For authorization timestamps we have a field in the variable header in the=
 file format=2E

We should verify that SetVariable only sets the header field and strips th=
e authentication header to keep the efivar=2Epy and SetVariable in sync=2E

I think this is done here
https://github=2Ecom/trini/u-boot/blob/36d4c653580824b16574560b21d4401614d=
8b68e/lib/efi_loader/efi_variable=2Ec#L88

Do you intend to provide a patch for efivar=2Epy?

Best regards

Heinrich

>
>As per the CI tests shared, it stores the authenticated EFI variables usi=
ng setenv
>When authenticated variables are set via U=E2=80=91Boot using setenv -e -=
at, the flow goes through SetVariable(), where the firmware:
>
> * parses and validates the authentication descriptor
> * removes the authentication header
> * stores only the variable payload
>
>
>Due to this mismatch, variables created with efivar=2Epy differ from thos=
e created via U=E2=80=91Boot:
>
>GetVariable() returns descriptor + payload instead of payload-only, this =
leads to inconsistent and non=E2=80=91compliant variable behavior
>
>Fix Proposed:
>
>Strip the authentication descriptor within efivar=2Epy during variable wr=
ite, so that only the payload is stored in ubootefi=2Evar, matching U=E2=80=
=91Boot SetVariable() behavior=2E Please confirm if there are any concerns =
with this approach=2E
>
>Regards,
>Aswin
>
>On 5/13/2026 11:54 AM, Ilias Apalodimas wrote:
>> Hi Aswin,
>>=20
>> On Tue, 12 May 2026 at 22:42, Aswin Murugan
>> <aswin=2Emurugan@oss=2Equalcomm=2Ecom> wrote:
>>> Currently, efi_get_variable_mem() returns the raw stored format for
>>> authenticated variables, which includes the EFI_VARIABLE_AUTHENTICATIO=
N_2
>>> descriptor =2E This causes image authentication failures when reading
>>> secure boot variables as callers receive wrong data containing
>>> authentication headers instead of the actual variable payload=2E
>> What are 'the callers'? The EFI security related variables are usually
>> read and consumed by the firmware itself during secure boot=2E I don't
>> remember the code on top of my head, but i think we end up storing the
>> auth info because it also contains timestamps etc=2E
>>=20
>>> The UEFI Specification Section 8=2E2=2E6(EFI_VARIABLE_AUTHENTICATION_2=
 descriptor)
>>> explicitly states:
>>> "The authentication descriptor is not part of the variable data and is
>>> not returned by subsequent calls to GetVariable()=2E"
>> We can strip the headers during GetVariable, but you need more changes
>> apart from the one here=2E The EFI secure boot tests fail with the
>> change above [1]=2E
>>=20
>>> This patch implements spec-compliant behavior by detecting variables w=
ith
>>> the EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS attribute and
>>> stripping the authentication descriptor before returning data to calle=
rs=2E
>> [1] https://source=2Edenx=2Ede/u-boot/custodians/u-boot-tpm/-/pipelines=
/30086
>>=20
>> Regards
>> /Ilias
>>> Signed-off-by: Aswin Murugan <aswin=2Emurugan@oss=2Equalcomm=2Ecom>
>>> ---
>>> Changes in v2:
>>> - Enhanced commit message with explicit UEFI spec reference
>>> Link to v1: https://lore=2Ekernel=2Eorg/u-boot/20250725123653=2E513252=
-1-aswin=2Emurugan@oss=2Equalcomm=2Ecom/
>>> ---
>>>   lib/efi_loader/efi_var_mem=2Ec | 44 +++++++++++++++++++++++++++++---=
----
>>>   1 file changed, 36 insertions(+), 8 deletions(-)
>>>=20
>>> diff --git a/lib/efi_loader/efi_var_mem=2Ec b/lib/efi_loader/efi_var_m=
em=2Ec
>>> index 8d5f99f4870=2E=2Eedf4522e51f 100644
>>> --- a/lib/efi_loader/efi_var_mem=2Ec
>>> +++ b/lib/efi_loader/efi_var_mem=2Ec
>>> @@ -336,9 +336,10 @@ efi_get_variable_mem(const u16 *variable_name, co=
nst efi_guid_t *vendor,
>>>                       u32 *attributes, efi_uintn_t *data_size, void *d=
ata,
>>>                       u64 *timep, u32 mask)
>>>   {
>>> -       efi_uintn_t old_size;
>>> +       efi_uintn_t old_size, var_data_size;
>>>          struct efi_var_entry *var;
>>>          u16 *pdata;
>>> +       void *var_data;
>>>=20
>>>          if (!variable_name || !vendor || !data_size)
>>>                  return EFI_INVALID_PARAMETER;
>>> @@ -362,19 +363,46 @@ efi_get_variable_mem(const u16 *variable_name, c=
onst efi_guid_t *vendor,
>>>          if (!u16_strcmp(variable_name, vtf))
>>>                  return efi_var_collect_mem(data, data_size, EFI_VARIA=
BLE_NON_VOLATILE);
>>>=20
>>> +       for (pdata =3D var->name; *pdata; ++pdata)
>>> +               ;
>>> +       ++pdata;
>>> +
>>> +       var_data =3D (void *)pdata;
>>> +       var_data_size =3D var->length;
>>> +
>>> +       /* Handle EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS *=
/
>>> +       if (var->attr & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_AC=
CESS) {
>>> +               if (var_data_size > sizeof(struct efi_time)) {
>>> +                       struct efi_time *timestamp;
>>> +                       struct win_certificate_uefi_guid *cert;
>>> +                       efi_uintn_t auth_size;
>>> +
>>> +                       timestamp =3D (struct efi_time *)var_data;
>>> +                       cert =3D (struct win_certificate_uefi_guid *)(=
timestamp + 1);
>>> +                       auth_size =3D sizeof(struct efi_time) + cert->=
hdr=2EdwLength;
>>> +                       if (var_data_size > auth_size) {
>>> +                               var_data =3D (u8 *)var_data + auth_siz=
e;
>>> +                               var_data_size -=3D auth_size;
>>> +                       }
>>> +               }
>>> +       }
>>> +       /*
>>> +        * EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS type is old & not
>>> +        * expected for auth variables
>>> +        */
>>> +       else if (var->attr & EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS)
>>> +               return EFI_INVALID_PARAMETER;
>>> +
>>>          old_size =3D *data_size;
>>> -       *data_size =3D var->length;
>>> -       if (old_size < var->length)
>>> +       *data_size =3D var_data_size;
>>> +
>>> +       if (old_size < var_data_size)
>>>                  return EFI_BUFFER_TOO_SMALL;
>>>=20
>>>          if (!data)
>>>                  return EFI_INVALID_PARAMETER;
>>>=20
>>> -       for (pdata =3D var->name; *pdata; ++pdata)
>>> -               ;
>>> -       ++pdata;
>>> -
>>> -       efi_memcpy_runtime(data, pdata, var->length);
>>> +       efi_memcpy_runtime(data, var_data, var_data_size);
>>>=20
>>>          return EFI_SUCCESS;
>>>   }
>>> --
>>> 2=2E34=2E1
>>>=20

