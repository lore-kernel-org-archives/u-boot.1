Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FA0CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 12:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BF12881A9;
	Wed, 10 Apr 2024 14:27:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F3J4QH/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 140BA877AF; Wed, 10 Apr 2024 14:27:58 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADBAF881A9
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 14:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56e1bbdb362so8166419a12.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 05:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712752075; x=1713356875; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZjnst2iDmL/z5c+hqZlzDyGBt+XEjRfta58JxrjF+o=;
 b=F3J4QH/XOoMp3/CpQN3fTsIM+YIHvajj/2LUKANOGa40D7kaZwEnrUzHZSFX8lDug1
 ehf6KMh4Y8Al+efwpRIDataYza2Kp8bAeRKQz6o0gQHfV0iJEmwOK/ujix6+iQP8MZYs
 8u0N4kChW3lmD4f90GtXPVWUYHYciCinBFbbAkByoD0lAJTOG/TZRSH1ogUyd6TxilTv
 M7jvyNesw9KuTCKxZmFmf/WyN5HjMKEllA+M1NqrvpjsJJbTR40C6LbEp+rbZLBJ0jQk
 NCw1Xefp40TxcQI6N9SXPfvMQiU1bk5/zdug2jsiQ8zEWu74xL4004TvTR5Jnb8Xqy36
 ILOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712752075; x=1713356875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZjnst2iDmL/z5c+hqZlzDyGBt+XEjRfta58JxrjF+o=;
 b=AdrJnuqop3L5YVS4bqY6+TEzsUhhVqMnlDEAK/Omka0x/fOnF718QITVWPmPbOlS2t
 jH+gWJzmTob5Jp/snhZVpIHJvCTOKJ4TprRzWRvYilLsekkRSnBgJpWGhRZ0Yj2Wo0Ij
 996S+d9u3zj8a9DDZhRTZ5t1gGdi27U9GaR9nVuuW1Gt6wNkyZkrjQXG1cP+y1ENV/6f
 KVDi48BpTxCZIfpiTAVvrCrv2POGDng1Rv5aJFC4XIlCUBucn3U4cORgehBXt2RwWVnv
 zM3cEp1R7nOLQxk1+clNUHb08Wml7gfA0Av2cgxJeUNoXxcWUTkhIciJH3EikeNh84EY
 oRdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdY/cHVwT9dgW74BR5TFI66KgRpKVOTZO0Hr7kJzI6QxfOc1NbbJ20j20gCrTpl3JrERv1qWB8u8tGoTACD83miuTIxg==
X-Gm-Message-State: AOJu0Yx8NMeadLg2MYcjRWW1JY8dtwrk8RaFo0Pa1TI9C3iNhUMChag5
 57b8RWXT1mAT27DPlU3E+LsCSDQOdW5GTN0r8s+zNKj5vytFYMWGbBW4knLws9lmrmx2IImRPI6
 32L4W2eH/qIplUoVIc9hr2IWXRRo=
X-Google-Smtp-Source: AGHT+IEWbC2UiXNecn1CbcnYZZAjLAOl3EXrZ7bj1ksx5CCOljJcijjlM5MWWUuBQ9P1VVchhClKoa0pzwGxKRUfPMQ=
X-Received: by 2002:a50:a446:0:b0:568:cdf3:5cb2 with SMTP id
 v6-20020a50a446000000b00568cdf35cb2mr2099543edb.30.1712752074650; Wed, 10 Apr
 2024 05:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240327140628.106143-1-o451686892@gmail.com>
 <e2262678-5a0b-4130-af8d-5e3b93b16aaa@gmx.de>
 <CAHk0HosTU1-gfDGYf+gp+LzDxJY_z=ZO8jYHrAChDtprd-xWcA@mail.gmail.com>
 <CAHk0Hos1NAJoFYrvgvaT2AaU8B+8UTau34x16715k9yNoWd5NA@mail.gmail.com>
 <ace09b2b-f22c-4bcf-af8f-e6a5eb5ac0f6@gmx.de>
In-Reply-To: <ace09b2b-f22c-4bcf-af8f-e6a5eb5ac0f6@gmx.de>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Wed, 10 Apr 2024 20:27:43 +0800
Message-ID: <CAHk0Hot5deZsRGQ1XtdVeWR_Bah2wu30O6R9WzwEuXWJkS759Q@mail.gmail.com>
Subject: Re: [RFC PATCH] efi_loader: Fix EFI_VARIABLE_APPEND_WRITE hash check
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Joao Marcos Costa <jmcosta944@gmail.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 10, 2024 at 8:09=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 10.04.24 13:53, Weizhao Ouyang wrote:
> > On Thu, Apr 4, 2024 at 1:48=E2=80=AFAM Weizhao Ouyang <o451686892@gmail=
.com> wrote:
> >>
> >> Hi Heinrich,
> >>
> >> On Wed, Apr 3, 2024 at 10:54=E2=80=AFPM Heinrich Schuchardt <xypron.gl=
pk@gmx.de> wrote:
> >>>
> >>> On 27.03.24 15:06, Weizhao Ouyang wrote:
> >>>> According to UEFI v2.10 spec section 8.2.6, if a caller invokes the
> >>>> SetVariables() service, it will produce a digest from hash(VariableN=
ame,
> >>>> VendorGuid, Attributes, TimeStamp, DataNew_variable_content), then t=
he
> >>>> firmware that implements the SetVariable() service will compare the
> >>>> digest with the result of applying the signer=E2=80=99s public key t=
o the
> >>>> signature. For EFI variable append write, efitools sign-efi-sig-list=
 has
> >>>> an option "-a" to add EFI_VARIABLE_APPEND_WRITE attr, and u-boot wil=
l
> >>>> drop this attribute in efi_set_variable_int(). So if a caller uses
> >>>> "sign-efi-sig-list -a" to create the authenticated variable, this ap=
pend
> >>>> write will fail in the u-boot due to "hash check failed".
> >>>
> >>> Currently U-Boot does not allow to use EFI_VARIABLE_APPEND_WRITE for =
any
> >>> non-existent variable, signed or not. This does not match the EDK II
> >>> behavior.
> >>
> >> I'm not referring to the non-existent variable situation, it's a norma=
l
> >> existent variable update.
> >>
> >> I mean:
> >> 1. process PK
> >> 2. process KEK
> >> 3. process a new APPEND_WRITE KEK (came from "sign-efi-sig-list -a ...=
",
> >>     so the digest and attrtibute of the KEK auth file will contain
> >>     APPEND_WRITE)
> >> Then the hash check will fail.
> >>
> >>>
> >>> There is a patch queued for this issue:
> >>>
> >>> [PATCH v2] efi_loader: fix append write behavior to non-existent vari=
able
> >>> https://lore.kernel.org/u-boot/20240402090950.3819705-1-kojima.masahi=
sa@socionext.com/
> >>>
> >>> Could you, please, retest with that patch.
> >>>
> >>>>
> >>>> This patch resumes writing the EFI_VARIABLE_APPEND_WRITE attr to ens=
ure
> >>>> that the hash check is correct. And also update the "test_efi_secboo=
t"
> >>>> test case to compliance with the change.
> >>>>
> >>>> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> >>>> ---
> >>>>    lib/efi_loader/efi_variable.c                  |  3 +--
> >>>>    test/py/tests/test_efi_secboot/conftest.py     | 10 ++++++++++
> >>>>    test/py/tests/test_efi_secboot/test_authvar.py |  4 ++--
> >>>>    test/py/tests/test_efi_secboot/test_signed.py  | 10 +++++-----
> >>>>    4 files changed, 18 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_vari=
able.c
> >>>> index 40f7a0fb10..f41aa8f9ad 100644
> >>>> --- a/lib/efi_loader/efi_variable.c
> >>>> +++ b/lib/efi_loader/efi_variable.c
> >>>> @@ -259,7 +259,6 @@ efi_status_t efi_set_variable_int(const u16 *var=
iable_name,
> >>>>        /* check if a variable exists */
> >>>>        var =3D efi_var_mem_find(vendor, variable_name, NULL);
> >>>>        append =3D !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> >>>> -     attributes &=3D ~(u32)EFI_VARIABLE_APPEND_WRITE;
> >>>
> >>> According to the UEFI specification for GetVariable():
> >>>
> >>> "The EFI_VARIABLE_APPEND_WRITE attribute will never be set in the
> >>> returned Attributes bitmask parameter."
> >>
> >> Yes, that's why I called it a RFC patch.
> >>
> >>>
> >>> We don't want to set EFI_VARIABLE_APPEND_WRITE in a variable when
> >>> calling efi_var_mem_ins().
> >>
> >> The APPEND_WRITE attribute is allowed to be set prior to invoking the
> >> service (UEFI section 8.2.6). So anyway we should consider compatibili=
ty
> >> with this case, along with making changes to GetVariable().
> >
> > Part of the process in edk2 is:
> >
> > VerifyTimeBasedPayloadAndUpdate
> > --> VerifyTimeBasedPayload // calculate digest and compare digest
> > --> AuthServiceInternalUpdateVariableWithTimeStamp
> >      --> VariableExLibUpdateVariable
> >          --> UpdateVariable // unset the APPEND_WRITE
> >
> > We can align with this implementation.
>
> I was referring to the attribute value passed to efi_var_mem_ins(), not
> to the value passed to SetVariable().
>
> efi_var_mem_ins() does not remove the EFI_VARIABLE_APPEND_WRITE bit. The
> code calling efi_var_mem_ins() should not pass such a value.

Yeah, efi_var_mem_ins() should escape from this bit.
Could we temporarily unset this attr here?

BR,
Weizhao

>
> Best regards
>
> Heinrich
>
> >
> > BR,
> > Weizhao
> >
> >>
> >> BR,
> >> Weizhao
> >>
> >>>
> >>>>        delete =3D !append && (!data_size || !attributes);
> >>>>
> >>>>        /* check attributes */
> >>>> @@ -275,7 +274,7 @@ efi_status_t efi_set_variable_int(const u16 *var=
iable_name,
> >>>>
> >>>>                /* attributes won't be changed */
> >>>>                if (!delete &&
> >>>> -                 ((ro_check && var->attr !=3D attributes) ||
> >>>> +                 ((ro_check && var->attr !=3D (attributes & ~(u32)E=
FI_VARIABLE_APPEND_WRITE)) ||
> >>>>                     (!ro_check && ((var->attr & ~(u32)EFI_VARIABLE_R=
EAD_ONLY)
> >>>
> >>> The (u32) conversions are superfluous.
> >>>
> >>> Best regards
> >>>
> >>> Heinrich
> >>>
> >>>>                                    !=3D (attributes & ~(u32)EFI_VARI=
ABLE_READ_ONLY))))) {
> >>>>                        return EFI_INVALID_PARAMETER;
> >>>> diff --git a/test/py/tests/test_efi_secboot/conftest.py b/test/py/te=
sts/test_efi_secboot/conftest.py
> >>>> index ff7ac7c810..0fa0747fc7 100644
> >>>> --- a/test/py/tests/test_efi_secboot/conftest.py
> >>>> +++ b/test/py/tests/test_efi_secboot/conftest.py
> >>>> @@ -64,6 +64,12 @@ def efi_boot_env(request, u_boot_config):
> >>>>            check_call('cd %s; %scert-to-efi-sig-list -g %s db1.crt d=
b1.esl; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key db db1.es=
l db1.auth'
> >>>>                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PA=
TH),
> >>>>                       shell=3DTrue)
> >>>> +        # db2 (APPEND_WRITE)
> >>>> +        check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:20=
48 -subj /CN=3DTEST_db2/ -keyout db2.key -out db2.crt -nodes -days 365'
> >>>> +                   % mnt_point, shell=3DTrue)
> >>>> +        check_call('cd %s; %scert-to-efi-sig-list -g %s db2.crt db2=
.esl; %ssign-efi-sig-list -a -c KEK.crt -k KEK.key db db2.esl db2.auth'
> >>>> +                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH=
),
> >>>> +                   shell=3DTrue)
> >>>>            # dbx (TEST_dbx certificate)
> >>>>            check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:=
2048 -subj /CN=3DTEST_dbx/ -keyout dbx.key -out dbx.crt -nodes -days 365'
> >>>>                       % mnt_point, shell=3DTrue)
> >>>> @@ -84,6 +90,10 @@ def efi_boot_env(request, u_boot_config):
> >>>>            check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 d=
b1.crt dbx_hash1.crl; %ssign-efi-sig-list -t "2020-04-06" -c KEK.crt -k KEK=
.key dbx dbx_hash1.crl dbx_hash1.auth'
> >>>>                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PA=
TH),
> >>>>                       shell=3DTrue)
> >>>> +        # dbx_hash2 (digest of TEST_db2 certificate, with APPEND_WR=
ITE)
> >>>> +        check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 db2=
.crt dbx_hash2.crl; %ssign-efi-sig-list -a -c KEK.crt -k KEK.key dbx dbx_ha=
sh2.crl dbx_hash2.auth'
> >>>> +                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH=
),
> >>>> +                   shell=3DTrue)
> >>>>            # dbx_db (with TEST_db certificate)
> >>>>            check_call('cd %s; %ssign-efi-sig-list -t "2020-04-05" -c=
 KEK.crt -k KEK.key dbx db.esl dbx_db.auth'
> >>>>                       % (mnt_point, EFITOOLS_PATH),
> >>>> diff --git a/test/py/tests/test_efi_secboot/test_authvar.py b/test/p=
y/tests/test_efi_secboot/test_authvar.py
> >>>> index f99b8270a6..d5aeb65048 100644
> >>>> --- a/test/py/tests/test_efi_secboot/test_authvar.py
> >>>> +++ b/test/py/tests/test_efi_secboot/test_authvar.py
> >>>> @@ -183,7 +183,7 @@ class TestEfiAuthVar(object):
> >>>>                assert 'db:' in ''.join(output)
> >>>>
> >>>>                output =3D u_boot_console.run_command_list([
> >>>> -                'fatload host 0:1 4000000 db1.auth',
> >>>> +                'fatload host 0:1 4000000 db2.auth',
> >>>>                    'setenv -e -nv -bs -rt -a -i 4000000:$filesize db=
'])
> >>>>                assert 'Failed to set EFI variable' in ''.join(output=
)
> >>>>
> >>>> @@ -197,7 +197,7 @@ class TestEfiAuthVar(object):
> >>>>            with u_boot_console.log.section('Test Case 3c'):
> >>>>                # Test Case 3c, update with correct signature
> >>>>                output =3D u_boot_console.run_command_list([
> >>>> -                'fatload host 0:1 4000000 db1.auth',
> >>>> +                'fatload host 0:1 4000000 db2.auth',
> >>>>                    'setenv -e -nv -bs -rt -at -a -i 4000000:$filesiz=
e db',
> >>>>                    'printenv -e -n -guid d719b2cb-3d3a-4596-a3bc-dad=
00e67656f db'])
> >>>>                assert 'Failed to set EFI variable' not in ''.join(ou=
tput)
> >>>> diff --git a/test/py/tests/test_efi_secboot/test_signed.py b/test/py=
/tests/test_efi_secboot/test_signed.py
> >>>> index 2f862a259a..34719ad1f2 100644
> >>>> --- a/test/py/tests/test_efi_secboot/test_signed.py
> >>>> +++ b/test/py/tests/test_efi_secboot/test_signed.py
> >>>> @@ -177,7 +177,7 @@ class TestEfiSignedImage(object):
> >>>>            with u_boot_console.log.section('Test Case 5b'):
> >>>>                # Test Case 5b, authenticated if both signatures are =
verified
> >>>>                output =3D u_boot_console.run_command_list([
> >>>> -                'fatload host 0:1 4000000 db1.auth',
> >>>> +                'fatload host 0:1 4000000 db2.auth',
> >>>>                    'setenv -e -nv -bs -rt -at -a -i 4000000:$filesiz=
e db'])
> >>>>                assert 'Failed to set EFI variable' not in ''.join(ou=
tput)
> >>>>                output =3D u_boot_console.run_command_list([
> >>>> @@ -201,7 +201,7 @@ class TestEfiSignedImage(object):
> >>>>            with u_boot_console.log.section('Test Case 5d'):
> >>>>                # Test Case 5d, rejected if both of signatures are re=
voked
> >>>>                output =3D u_boot_console.run_command_list([
> >>>> -                'fatload host 0:1 4000000 dbx_hash1.auth',
> >>>> +                'fatload host 0:1 4000000 dbx_hash2.auth',
> >>>>                    'setenv -e -nv -bs -rt -at -a -i 4000000:$filesiz=
e dbx'])
> >>>>                assert 'Failed to set EFI variable' not in ''.join(ou=
tput)
> >>>>                output =3D u_boot_console.run_command_list([
> >>>> @@ -223,7 +223,7 @@ class TestEfiSignedImage(object):
> >>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize K=
EK',
> >>>>                    'fatload host 0:1 4000000 PK.auth',
> >>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize P=
K',
> >>>> -                'fatload host 0:1 4000000 db1.auth',
> >>>> +                'fatload host 0:1 4000000 db2.auth',
> >>>>                    'setenv -e -nv -bs -rt -at -a -i 4000000:$filesiz=
e db',
> >>>>                    'fatload host 0:1 4000000 dbx_hash1.auth',
> >>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize d=
bx'])
> >>>> @@ -300,7 +300,7 @@ class TestEfiSignedImage(object):
> >>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize K=
EK',
> >>>>                    'fatload host 0:1 4000000 PK.auth',
> >>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize P=
K',
> >>>> -                'fatload host 0:1 4000000 db1.auth',
> >>>> +                'fatload host 0:1 4000000 db2.auth',
> >>>>                    'setenv -e -nv -bs -rt -at -a -i 4000000:$filesiz=
e db',
> >>>>                    'fatload host 0:1 4000000 dbx_hash384.auth',
> >>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize d=
bx'])
> >>>> @@ -323,7 +323,7 @@ class TestEfiSignedImage(object):
> >>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize K=
EK',
> >>>>                    'fatload host 0:1 4000000 PK.auth',
> >>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize P=
K',
> >>>> -                'fatload host 0:1 4000000 db1.auth',
> >>>> +                'fatload host 0:1 4000000 db2.auth',
> >>>>                    'setenv -e -nv -bs -rt -at -a -i 4000000:$filesiz=
e db',
> >>>>                    'fatload host 0:1 4000000 dbx_hash512.auth',
> >>>>                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize d=
bx'])
> >>>
>
