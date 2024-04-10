Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80807CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 12:09:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 976DD8272A;
	Wed, 10 Apr 2024 14:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fLioGwEr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC6B88176; Wed, 10 Apr 2024 14:09:47 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84A4F81F9A
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 14:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712750976; x=1713355776; i=xypron.glpk@gmx.de;
 bh=NAdsaLulD5EkFWWTi/Pf3iqNkB8RXProTSBHzChAaes=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=fLioGwErbNJx+qyYxcxmzuXUPl3ns+Ptq1coTW89RIq/YrrwPKoi8rhyO6ZOkz9o
 QzlEWx9jKUGlNsxgcizxOhsoJ6pDTRXtvqsM5+2SOLfII7hWgoGpyndE/pllsi0Fy
 MWCLXvtOsJWTPklXW7Bwt+h0v7IRqwj00Zp9cKkfNo0DCTiMeAvhG5oklAP0FH3O7
 ZoMK0w7EFAeJtyaLAN4stxMS5382Ie0y6faUJ74S0OhRH/d8iRuEAQPs0DN3HQVih
 D7ZyKozY278+3npLU4CFXRGRfZGviEl2MFPauhgyPi9+sPfbQxeOYX5sKAFM/yZ45
 8Q5bnQCPCa0fBau43A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lY1-1ruFmt0vTP-000rfZ; Wed, 10
 Apr 2024 14:09:36 +0200
Message-ID: <ace09b2b-f22c-4bcf-af8f-e6a5eb5ac0f6@gmx.de>
Date: Wed, 10 Apr 2024 14:09:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] efi_loader: Fix EFI_VARIABLE_APPEND_WRITE hash check
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
References: <20240327140628.106143-1-o451686892@gmail.com>
 <e2262678-5a0b-4130-af8d-5e3b93b16aaa@gmx.de>
 <CAHk0HosTU1-gfDGYf+gp+LzDxJY_z=ZO8jYHrAChDtprd-xWcA@mail.gmail.com>
 <CAHk0Hos1NAJoFYrvgvaT2AaU8B+8UTau34x16715k9yNoWd5NA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAHk0Hos1NAJoFYrvgvaT2AaU8B+8UTau34x16715k9yNoWd5NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gi1QpZY3qNAt/aGAKTnvaXGOB9eQeNah9AOYEICvaW2DWR+rE2x
 +ZDNtHx0wnQt2W/b97Al77cnHUcN8no1ThU6pX3dgUBL+6K/LTTr9NqKW4cM2Fs/+rIH3dd
 sbJm9t0xPPFnm3TqZsKjDQKxFIFeJP+uBN4yY4Hkxjf24m+lviFcnlCiArn6vbUWGiI3/LU
 bQWsvojcwJJW9wpkbl0zA==
UI-OutboundReport: notjunk:1;M01:P0:vvs/wwcwZdk=;IA5YYdUpsyrMdZBgnjrz9OTbwU7
 X8Frej5VlwQZ+UXVFA3vcVIvr54xAjg0nCCVQasMCXTZdii6brQECBg0nHtgwSuUwIxAL0Zpk
 CEPgo7xuuAqjvqhDZoMd3VGjZhobmaqcTwWdsytBirve/D/P9ZG3wb2kMx47CdJXaJ1GlI7s+
 rflad8/P304AmG+Pm/gylsjIQdcUCHRs2KIHRpWBvTKOeb5o8YknPVzdN4ezW00plLn4pDg78
 6TqNTbSGW4EDsiam2NRXJRIt77dA+KyKew184UpP3zaWjCHlqqgBuyeZgAs0SIQgiiK7XuRuT
 2hBH4uR2e5ARF4nkKt0qtoL0Ttty1BTZXl7A6eXuDX7XgBt6PLbMyY5MI0G4WJAwgLXWt4UGJ
 BpK0BvTNW6EWdmaX2fhYQdN4pp/Hi+9swH8fb/dY8VVF0IdZUCK7Hgx3f+SKeild5+96XQcZY
 SRqhuvb2F6gBPgSz95/f94GgMiEeHJMwEYNX7kHKhBGx6lWpeXoA1VRpPBFrjETYI+mOw3uo9
 XtOLxCptKk8ZiVyvuXDJorSEyHGdz5TH9qG8gCCU8L78IHtXNvGgn2HN7fXw5Jk4F4VdeUP1t
 nE0sFwpr67iqqczFmlBw3IXVHmscJmjHbFQlQC6+NIzHx0n6u4YT3wJt0gBnj0GmIZRVd5lAO
 c27dmP4wIV81W3O++i2Ze3ichuFPRkRCOq7Iy0xXuyFAjKmhzOelL30p9wytSZD+snXYSqtlN
 E6GfQ/Q14Vwaj83zHv75jScCRUS94yBt4AGM14CCdkZCJcXVjCSOWTIgMhxQud0JmzRtKjvb7
 QDiAcdl8j/+xds3rsZQSamG9ngzHj/PE3nyBLkQqFIYPQ=
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

On 10.04.24 13:53, Weizhao Ouyang wrote:
> On Thu, Apr 4, 2024 at 1:48=E2=80=AFAM Weizhao Ouyang <o451686892@gmail.=
com> wrote:
>>
>> Hi Heinrich,
>>
>> On Wed, Apr 3, 2024 at 10:54=E2=80=AFPM Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
>>>
>>> On 27.03.24 15:06, Weizhao Ouyang wrote:
>>>> According to UEFI v2.10 spec section 8.2.6, if a caller invokes the
>>>> SetVariables() service, it will produce a digest from hash(VariableNa=
me,
>>>> VendorGuid, Attributes, TimeStamp, DataNew_variable_content), then th=
e
>>>> firmware that implements the SetVariable() service will compare the
>>>> digest with the result of applying the signer=E2=80=99s public key to=
 the
>>>> signature. For EFI variable append write, efitools sign-efi-sig-list =
has
>>>> an option "-a" to add EFI_VARIABLE_APPEND_WRITE attr, and u-boot will
>>>> drop this attribute in efi_set_variable_int(). So if a caller uses
>>>> "sign-efi-sig-list -a" to create the authenticated variable, this app=
end
>>>> write will fail in the u-boot due to "hash check failed".
>>>
>>> Currently U-Boot does not allow to use EFI_VARIABLE_APPEND_WRITE for a=
ny
>>> non-existent variable, signed or not. This does not match the EDK II
>>> behavior.
>>
>> I'm not referring to the non-existent variable situation, it's a normal
>> existent variable update.
>>
>> I mean:
>> 1. process PK
>> 2. process KEK
>> 3. process a new APPEND_WRITE KEK (came from "sign-efi-sig-list -a ..."=
,
>>     so the digest and attrtibute of the KEK auth file will contain
>>     APPEND_WRITE)
>> Then the hash check will fail.
>>
>>>
>>> There is a patch queued for this issue:
>>>
>>> [PATCH v2] efi_loader: fix append write behavior to non-existent varia=
ble
>>> https://lore.kernel.org/u-boot/20240402090950.3819705-1-kojima.masahis=
a@socionext.com/
>>>
>>> Could you, please, retest with that patch.
>>>
>>>>
>>>> This patch resumes writing the EFI_VARIABLE_APPEND_WRITE attr to ensu=
re
>>>> that the hash check is correct. And also update the "test_efi_secboot=
"
>>>> test case to compliance with the change.
>>>>
>>>> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
>>>> ---
>>>>    lib/efi_loader/efi_variable.c                  |  3 +--
>>>>    test/py/tests/test_efi_secboot/conftest.py     | 10 ++++++++++
>>>>    test/py/tests/test_efi_secboot/test_authvar.py |  4 ++--
>>>>    test/py/tests/test_efi_secboot/test_signed.py  | 10 +++++-----
>>>>    4 files changed, 18 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_varia=
ble.c
>>>> index 40f7a0fb10..f41aa8f9ad 100644
>>>> --- a/lib/efi_loader/efi_variable.c
>>>> +++ b/lib/efi_loader/efi_variable.c
>>>> @@ -259,7 +259,6 @@ efi_status_t efi_set_variable_int(const u16 *vari=
able_name,
>>>>        /* check if a variable exists */
>>>>        var =3D efi_var_mem_find(vendor, variable_name, NULL);
>>>>        append =3D !!(attributes & EFI_VARIABLE_APPEND_WRITE);
>>>> -     attributes &=3D ~(u32)EFI_VARIABLE_APPEND_WRITE;
>>>
>>> According to the UEFI specification for GetVariable():
>>>
>>> "The EFI_VARIABLE_APPEND_WRITE attribute will never be set in the
>>> returned Attributes bitmask parameter."
>>
>> Yes, that's why I called it a RFC patch.
>>
>>>
>>> We don't want to set EFI_VARIABLE_APPEND_WRITE in a variable when
>>> calling efi_var_mem_ins().
>>
>> The APPEND_WRITE attribute is allowed to be set prior to invoking the
>> service (UEFI section 8.2.6). So anyway we should consider compatibilit=
y
>> with this case, along with making changes to GetVariable().
>
> Part of the process in edk2 is:
>
> VerifyTimeBasedPayloadAndUpdate
> --> VerifyTimeBasedPayload // calculate digest and compare digest
> --> AuthServiceInternalUpdateVariableWithTimeStamp
>      --> VariableExLibUpdateVariable
>          --> UpdateVariable // unset the APPEND_WRITE
>
> We can align with this implementation.

I was referring to the attribute value passed to efi_var_mem_ins(), not
to the value passed to SetVariable().

efi_var_mem_ins() does not remove the EFI_VARIABLE_APPEND_WRITE bit. The
code calling efi_var_mem_ins() should not pass such a value.

Best regards

Heinrich

>
> BR,
> Weizhao
>
>>
>> BR,
>> Weizhao
>>
>>>
>>>>        delete =3D !append && (!data_size || !attributes);
>>>>
>>>>        /* check attributes */
>>>> @@ -275,7 +274,7 @@ efi_status_t efi_set_variable_int(const u16 *vari=
able_name,
>>>>
>>>>                /* attributes won't be changed */
>>>>                if (!delete &&
>>>> -                 ((ro_check && var->attr !=3D attributes) ||
>>>> +                 ((ro_check && var->attr !=3D (attributes & ~(u32)EF=
I_VARIABLE_APPEND_WRITE)) ||
>>>>                     (!ro_check && ((var->attr & ~(u32)EFI_VARIABLE_RE=
AD_ONLY)
>>>
>>> The (u32) conversions are superfluous.
>>>
>>> Best regards
>>>
>>> Heinrich
>>>
>>>>                                    !=3D (attributes & ~(u32)EFI_VARIA=
BLE_READ_ONLY))))) {
>>>>                        return EFI_INVALID_PARAMETER;
>>>> diff --git a/test/py/tests/test_efi_secboot/conftest.py b/test/py/tes=
ts/test_efi_secboot/conftest.py
>>>> index ff7ac7c810..0fa0747fc7 100644
>>>> --- a/test/py/tests/test_efi_secboot/conftest.py
>>>> +++ b/test/py/tests/test_efi_secboot/conftest.py
>>>> @@ -64,6 +64,12 @@ def efi_boot_env(request, u_boot_config):
>>>>            check_call('cd %s; %scert-to-efi-sig-list -g %s db1.crt db=
1.esl; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key db db1.es=
l db1.auth'
>>>>                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PAT=
H),
>>>>                       shell=3DTrue)
>>>> +        # db2 (APPEND_WRITE)
>>>> +        check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:204=
8 -subj /CN=3DTEST_db2/ -keyout db2.key -out db2.crt -nodes -days 365'
>>>> +                   % mnt_point, shell=3DTrue)
>>>> +        check_call('cd %s; %scert-to-efi-sig-list -g %s db2.crt db2.=
esl; %ssign-efi-sig-list -a -c KEK.crt -k KEK.key db db2.esl db2.auth'
>>>> +                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH)=
,
>>>> +                   shell=3DTrue)
>>>>            # dbx (TEST_dbx certificate)
>>>>            check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2=
048 -subj /CN=3DTEST_dbx/ -keyout dbx.key -out dbx.crt -nodes -days 365'
>>>>                       % mnt_point, shell=3DTrue)
>>>> @@ -84,6 +90,10 @@ def efi_boot_env(request, u_boot_config):
>>>>            check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 db=
1.crt dbx_hash1.crl; %ssign-efi-sig-list -t "2020-04-06" -c KEK.crt -k KEK=
.key dbx dbx_hash1.crl dbx_hash1.auth'
>>>>                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PAT=
H),
>>>>                       shell=3DTrue)
>>>> +        # dbx_hash2 (digest of TEST_db2 certificate, with APPEND_WRI=
TE)
>>>> +        check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 db2.=
crt dbx_hash2.crl; %ssign-efi-sig-list -a -c KEK.crt -k KEK.key dbx dbx_ha=
sh2.crl dbx_hash2.auth'
>>>> +                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH)=
,
>>>> +                   shell=3DTrue)
>>>>            # dbx_db (with TEST_db certificate)
>>>>            check_call('cd %s; %ssign-efi-sig-list -t "2020-04-05" -c =
KEK.crt -k KEK.key dbx db.esl dbx_db.auth'
>>>>                       % (mnt_point, EFITOOLS_PATH),
>>>> diff --git a/test/py/tests/test_efi_secboot/test_authvar.py b/test/py=
/tests/test_efi_secboot/test_authvar.py
>>>> index f99b8270a6..d5aeb65048 100644
>>>> --- a/test/py/tests/test_efi_secboot/test_authvar.py
>>>> +++ b/test/py/tests/test_efi_secboot/test_authvar.py
>>>> @@ -183,7 +183,7 @@ class TestEfiAuthVar(object):
>>>>                assert 'db:' in ''.join(output)
>>>>
>>>>                output =3D u_boot_console.run_command_list([
>>>> -                'fatload host 0:1 4000000 db1.auth',
>>>> +                'fatload host 0:1 4000000 db2.auth',
>>>>                    'setenv -e -nv -bs -rt -a -i 4000000:$filesize db'=
])
>>>>                assert 'Failed to set EFI variable' in ''.join(output)
>>>>
>>>> @@ -197,7 +197,7 @@ class TestEfiAuthVar(object):
>>>>            with u_boot_console.log.section('Test Case 3c'):
>>>>                # Test Case 3c, update with correct signature
>>>>                output =3D u_boot_console.run_command_list([
>>>> -                'fatload host 0:1 4000000 db1.auth',
>>>> +                'fatload host 0:1 4000000 db2.auth',
>>>>                    'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize=
 db',
>>>>                    'printenv -e -n -guid d719b2cb-3d3a-4596-a3bc-dad0=
0e67656f db'])
>>>>                assert 'Failed to set EFI variable' not in ''.join(out=
put)
>>>> diff --git a/test/py/tests/test_efi_secboot/test_signed.py b/test/py/=
tests/test_efi_secboot/test_signed.py
>>>> index 2f862a259a..34719ad1f2 100644
>>>> --- a/test/py/tests/test_efi_secboot/test_signed.py
>>>> +++ b/test/py/tests/test_efi_secboot/test_signed.py
>>>> @@ -177,7 +177,7 @@ class TestEfiSignedImage(object):
>>>>            with u_boot_console.log.section('Test Case 5b'):
>>>>                # Test Case 5b, authenticated if both signatures are v=
erified
>>>>                output =3D u_boot_console.run_command_list([
>>>> -                'fatload host 0:1 4000000 db1.auth',
>>>> +                'fatload host 0:1 4000000 db2.auth',
>>>>                    'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize=
 db'])
>>>>                assert 'Failed to set EFI variable' not in ''.join(out=
put)
>>>>                output =3D u_boot_console.run_command_list([
>>>> @@ -201,7 +201,7 @@ class TestEfiSignedImage(object):
>>>>            with u_boot_console.log.section('Test Case 5d'):
>>>>                # Test Case 5d, rejected if both of signatures are rev=
oked
>>>>                output =3D u_boot_console.run_command_list([
>>>> -                'fatload host 0:1 4000000 dbx_hash1.auth',
>>>> +                'fatload host 0:1 4000000 dbx_hash2.auth',
>>>>                    'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize=
 dbx'])
>>>>                assert 'Failed to set EFI variable' not in ''.join(out=
put)
>>>>                output =3D u_boot_console.run_command_list([
>>>> @@ -223,7 +223,7 @@ class TestEfiSignedImage(object):
>>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize KE=
K',
>>>>                    'fatload host 0:1 4000000 PK.auth',
>>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK=
',
>>>> -                'fatload host 0:1 4000000 db1.auth',
>>>> +                'fatload host 0:1 4000000 db2.auth',
>>>>                    'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize=
 db',
>>>>                    'fatload host 0:1 4000000 dbx_hash1.auth',
>>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize db=
x'])
>>>> @@ -300,7 +300,7 @@ class TestEfiSignedImage(object):
>>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize KE=
K',
>>>>                    'fatload host 0:1 4000000 PK.auth',
>>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK=
',
>>>> -                'fatload host 0:1 4000000 db1.auth',
>>>> +                'fatload host 0:1 4000000 db2.auth',
>>>>                    'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize=
 db',
>>>>                    'fatload host 0:1 4000000 dbx_hash384.auth',
>>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize db=
x'])
>>>> @@ -323,7 +323,7 @@ class TestEfiSignedImage(object):
>>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize KE=
K',
>>>>                    'fatload host 0:1 4000000 PK.auth',
>>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK=
',
>>>> -                'fatload host 0:1 4000000 db1.auth',
>>>> +                'fatload host 0:1 4000000 db2.auth',
>>>>                    'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize=
 db',
>>>>                    'fatload host 0:1 4000000 dbx_hash512.auth',
>>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize db=
x'])
>>>

