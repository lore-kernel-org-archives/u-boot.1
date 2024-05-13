Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEEDC25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 05:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C300882AF;
	Mon, 13 May 2024 07:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KZmNH2Sr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A403882AF; Mon, 13 May 2024 07:48:34 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5E3587D4F
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 07:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a59b49162aeso965895666b.3
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 22:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715579310; x=1716184110; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5mKYw33mgqRFS+NKO++O206PTSY2UVcPCP9ZOm6ji8=;
 b=KZmNH2SrnUhJ23LGNNMunqnbEqe1eFo5Y6zLdPD/6yYaCAsHEe9OffdhCiS6jO5P9R
 /hTVMni94Jiop5KRKjN7gCXF2GiDLKJYTtLnmFbUj0PKh8uqziGEsqsoCMbM7eAf7ybN
 dG299Xehg1NmKRRMh6G/kKlZXhZZVJ8B3wptrUbx5UufdgVl062E3Yb1zxPdTLIjKdSH
 17EX0SKt8hSkspH8Y4HzFaPrMxV0zzlJhCwp7yvJXaI+Qh6YD5rxLsD2HQtt0EsfO/eG
 wkImGCJD3g0DwS2QGYoc0+an7/HxaQWVZeQsqg0M2iIp1x/I9Mehm8x9cDDmoEZGHUM7
 vHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715579310; x=1716184110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N5mKYw33mgqRFS+NKO++O206PTSY2UVcPCP9ZOm6ji8=;
 b=kOeO97U3ZBtP+VBD7B6V9CBLCPfmRzVLHZHBdZScFqQIC28a+ApkKhey1rhqWbUtUD
 b6KdrXIKwHBT8hWnLCQfHlfSATmm4LwRCp/FjMHVyOHtsEobwibvjVvHtE/DYtgMV76B
 3AMoaB2YvLl2JJNr46eAVDYKKpAz3+P/ST82KZhZBYYt+RcGDagSrPXFtDZgtOB4f+l7
 E6KKn5jHFZ3UVeIH0pC4YlJWkArQG5Zon46TGB/huWWyRtAutstc7NGONA70cG2jgonX
 REW6IElGV4fpKDn4vayRmitZ4KJj52jZQCjYvJunkeIbksn46n0D5bSxWn38ne5SXDOT
 oiBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlgaNggbIHI25h9O3RcIU9ST1KeyUFkJWmhKAFnTrA0UY2luqIumvek/4aTa7M/k2SjxLxxadp7A9dHJiu1VPtFavalw==
X-Gm-Message-State: AOJu0YyLi1Za2+6EoBrDJ48dc4zLDKi2yPXFmX6/rrcp1GyO802D8fY2
 ZGr8mzu+X/MAlbOMvHh6EtM5fhsq7hN4GSWFsE9BXxaMdfC9SuTMqvWWotr5weWjjUJnrISebE+
 k/fGnU1l/YYlyDhTA82JuINKFNEs=
X-Google-Smtp-Source: AGHT+IHvsmffc7CAiSJxEDnu9SiMBYnJHoh4JHpUu+5XxpE0CtLhvloR7kJ4xuTu4AJ3j/wcK207AQQvGl52VRKsw2Q=
X-Received: by 2002:a50:ab47:0:b0:572:9984:1921 with SMTP id
 4fb4d7f45d1cf-5734d5bec35mr6008837a12.17.1715579309688; Sun, 12 May 2024
 22:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240508111312.154617-1-o451686892@gmail.com>
 <7dfd7a94-b256-437e-97e6-1841c7d53532@gmx.de>
In-Reply-To: <7dfd7a94-b256-437e-97e6-1841c7d53532@gmx.de>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Mon, 13 May 2024 13:48:18 +0800
Message-ID: <CAHk0HouYxX9W+0VK=zwR+aL8U=y50mUZoKctex-f6FN-DpRaEQ@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: Fix EFI_VARIABLE_APPEND_WRITE hash check
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, Simon Glass <sjg@chromium.org>,
 Qu Wenruo <wqu@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Stefan Roese <sr@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Joao Marcos Costa <jmcosta944@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
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

On Fri, May 10, 2024 at 5:23=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 5/8/24 13:13, Weizhao Ouyang wrote:
> > According to UEFI v2.10 spec section 8.2.6, if a caller invokes the
> > SetVariables() service, it will produce a digest from hash(VariableName=
,
> > VendorGuid, Attributes, TimeStamp, DataNew_variable_content), then the
> > firmware that implements the SetVariable() service will compare the
> > digest with the result of applying the signer=E2=80=99s public key to t=
he
> > signature. For EFI variable append write, efitools sign-efi-sig-list ha=
s
> > an option "-a" to add EFI_VARIABLE_APPEND_WRITE attr, and u-boot will
> > drop this attribute in efi_set_variable_int(). So if a caller uses
> > "sign-efi-sig-list -a" to create the authenticated variable, this appen=
d
> > write will fail in the u-boot due to "hash check failed".
> >
> > This patch resumes writing the EFI_VARIABLE_APPEND_WRITE attr to ensure
> > that the hash check is correct. And also update the "test_efi_secboot"
> > test case to compliance with the change.
>
> Looking at EDK II I see that VerifyTimeBasedPayloadAndUpdate() calls
> VerifyTimeBasedPayload() before invoking
> AuthServiceInternalUpdateVariableWithTimeStamp() which handles the
> append flag so this seems to match the intended behavior that you describ=
e.
>
> Should we move the IS_ENABLED(CONFIG_EFI_SECURE_BOOT) check to
> efi_variable_authenticate() and call this function directly after
> setvariable_allowed() if
> EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS is set?
>
> This would make efi_set_variable_int() easier to read and would simplify
> the handling of the attribute flag.

Yeah, I think it's reasonable.

BR,
Weizhao

>
> The UEFI Self-Certification Test (SCT) never highlighted the issue. If a
> test is missing there,it would be a good idea to add an issue in
> https://bugzilla.tianocore.org/.
>
> Best regards
>
> Heinrich
>
> >
> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > ---
> > v2: skip attr for efi_var_mem_ins()
> > ---
> >   lib/efi_loader/efi_variable.c                  |  6 +++---
> >   test/py/tests/test_efi_secboot/conftest.py     | 10 ++++++++++
> >   test/py/tests/test_efi_secboot/test_authvar.py |  4 ++--
> >   test/py/tests/test_efi_secboot/test_signed.py  | 10 +++++-----
> >   4 files changed, 20 insertions(+), 10 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variabl=
e.c
> > index 1cc02acb3b..09651d4675 100644
> > --- a/lib/efi_loader/efi_variable.c
> > +++ b/lib/efi_loader/efi_variable.c
> > @@ -288,7 +288,6 @@ efi_status_t efi_set_variable_int(const u16 *variab=
le_name,
> >       /* check if a variable exists */
> >       var =3D efi_var_mem_find(vendor, variable_name, NULL);
> >       append =3D !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> > -     attributes &=3D ~EFI_VARIABLE_APPEND_WRITE;
> >       delete =3D !append && (!data_size || !attributes);
> >
> >       /* check attributes */
> > @@ -304,7 +303,7 @@ efi_status_t efi_set_variable_int(const u16 *variab=
le_name,
> >
> >               /* attributes won't be changed */
> >               if (!delete &&
> > -                 ((ro_check && var->attr !=3D attributes) ||
> > +                 ((ro_check && var->attr !=3D (attributes & ~EFI_VARIA=
BLE_APPEND_WRITE)) ||
> >                    (!ro_check && ((var->attr & ~EFI_VARIABLE_READ_ONLY)
> >                                   !=3D (attributes & ~EFI_VARIABLE_READ=
_ONLY))))) {
> >                       return EFI_INVALID_PARAMETER;
> > @@ -378,7 +377,8 @@ efi_status_t efi_set_variable_int(const u16 *variab=
le_name,
> >               for (; *old_data; ++old_data)
> >                       ;
> >               ++old_data;
> > -             ret =3D efi_var_mem_ins(variable_name, vendor, attributes=
,
> > +             ret =3D efi_var_mem_ins(variable_name, vendor,
> > +                                   attributes & ~EFI_VARIABLE_APPEND_W=
RITE,
> >                                     var->length, old_data, data_size, d=
ata,
> >                                     time);
> >       } else {
> > diff --git a/test/py/tests/test_efi_secboot/conftest.py b/test/py/tests=
/test_efi_secboot/conftest.py
> > index ff7ac7c810..0fa0747fc7 100644
> > --- a/test/py/tests/test_efi_secboot/conftest.py
> > +++ b/test/py/tests/test_efi_secboot/conftest.py
> > @@ -64,6 +64,12 @@ def efi_boot_env(request, u_boot_config):
> >           check_call('cd %s; %scert-to-efi-sig-list -g %s db1.crt db1.e=
sl; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key db db1.esl db=
1.auth'
> >                      % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
> >                      shell=3DTrue)
> > +        # db2 (APPEND_WRITE)
> > +        check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 =
-subj /CN=3DTEST_db2/ -keyout db2.key -out db2.crt -nodes -days 365'
> > +                   % mnt_point, shell=3DTrue)
> > +        check_call('cd %s; %scert-to-efi-sig-list -g %s db2.crt db2.es=
l; %ssign-efi-sig-list -a -c KEK.crt -k KEK.key db db2.esl db2.auth'
> > +                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
> > +                   shell=3DTrue)
> >           # dbx (TEST_dbx certificate)
> >           check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048=
 -subj /CN=3DTEST_dbx/ -keyout dbx.key -out dbx.crt -nodes -days 365'
> >                      % mnt_point, shell=3DTrue)
> > @@ -84,6 +90,10 @@ def efi_boot_env(request, u_boot_config):
> >           check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 db1.c=
rt dbx_hash1.crl; %ssign-efi-sig-list -t "2020-04-06" -c KEK.crt -k KEK.key=
 dbx dbx_hash1.crl dbx_hash1.auth'
> >                      % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
> >                      shell=3DTrue)
> > +        # dbx_hash2 (digest of TEST_db2 certificate, with APPEND_WRITE=
)
> > +        check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 db2.cr=
t dbx_hash2.crl; %ssign-efi-sig-list -a -c KEK.crt -k KEK.key dbx dbx_hash2=
.crl dbx_hash2.auth'
> > +                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
> > +                   shell=3DTrue)
> >           # dbx_db (with TEST_db certificate)
> >           check_call('cd %s; %ssign-efi-sig-list -t "2020-04-05" -c KEK=
.crt -k KEK.key dbx db.esl dbx_db.auth'
> >                      % (mnt_point, EFITOOLS_PATH),
> > diff --git a/test/py/tests/test_efi_secboot/test_authvar.py b/test/py/t=
ests/test_efi_secboot/test_authvar.py
> > index f99b8270a6..d5aeb65048 100644
> > --- a/test/py/tests/test_efi_secboot/test_authvar.py
> > +++ b/test/py/tests/test_efi_secboot/test_authvar.py
> > @@ -183,7 +183,7 @@ class TestEfiAuthVar(object):
> >               assert 'db:' in ''.join(output)
> >
> >               output =3D u_boot_console.run_command_list([
> > -                'fatload host 0:1 4000000 db1.auth',
> > +                'fatload host 0:1 4000000 db2.auth',
> >                   'setenv -e -nv -bs -rt -a -i 4000000:$filesize db'])
> >               assert 'Failed to set EFI variable' in ''.join(output)
> >
> > @@ -197,7 +197,7 @@ class TestEfiAuthVar(object):
> >           with u_boot_console.log.section('Test Case 3c'):
> >               # Test Case 3c, update with correct signature
> >               output =3D u_boot_console.run_command_list([
> > -                'fatload host 0:1 4000000 db1.auth',
> > +                'fatload host 0:1 4000000 db2.auth',
> >                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db=
',
> >                   'printenv -e -n -guid d719b2cb-3d3a-4596-a3bc-dad00e6=
7656f db'])
> >               assert 'Failed to set EFI variable' not in ''.join(output=
)
> > diff --git a/test/py/tests/test_efi_secboot/test_signed.py b/test/py/te=
sts/test_efi_secboot/test_signed.py
> > index 5000a4ab7b..f604138a35 100644
> > --- a/test/py/tests/test_efi_secboot/test_signed.py
> > +++ b/test/py/tests/test_efi_secboot/test_signed.py
> > @@ -177,7 +177,7 @@ class TestEfiSignedImage(object):
> >           with u_boot_console.log.section('Test Case 5b'):
> >               # Test Case 5b, authenticated if both signatures are veri=
fied
> >               output =3D u_boot_console.run_command_list([
> > -                'fatload host 0:1 4000000 db1.auth',
> > +                'fatload host 0:1 4000000 db2.auth',
> >                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db=
'])
> >               assert 'Failed to set EFI variable' not in ''.join(output=
)
> >               output =3D u_boot_console.run_command_list([
> > @@ -201,7 +201,7 @@ class TestEfiSignedImage(object):
> >           with u_boot_console.log.section('Test Case 5d'):
> >               # Test Case 5d, rejected if both of signatures are revoke=
d
> >               output =3D u_boot_console.run_command_list([
> > -                'fatload host 0:1 4000000 dbx_hash1.auth',
> > +                'fatload host 0:1 4000000 dbx_hash2.auth',
> >                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db=
x'])
> >               assert 'Failed to set EFI variable' not in ''.join(output=
)
> >               output =3D u_boot_console.run_command_list([
> > @@ -223,7 +223,7 @@ class TestEfiSignedImage(object):
> >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
> >                   'fatload host 0:1 4000000 PK.auth',
> >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
> > -                'fatload host 0:1 4000000 db1.auth',
> > +                'fatload host 0:1 4000000 db2.auth',
> >                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db=
',
> >                   'fatload host 0:1 4000000 dbx_hash1.auth',
> >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx']=
)
> > @@ -300,7 +300,7 @@ class TestEfiSignedImage(object):
> >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
> >                   'fatload host 0:1 4000000 PK.auth',
> >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
> > -                'fatload host 0:1 4000000 db1.auth',
> > +                'fatload host 0:1 4000000 db2.auth',
> >                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db=
',
> >                   'fatload host 0:1 4000000 dbx_hash384.auth',
> >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx']=
)
> > @@ -323,7 +323,7 @@ class TestEfiSignedImage(object):
> >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
> >                   'fatload host 0:1 4000000 PK.auth',
> >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
> > -                'fatload host 0:1 4000000 db1.auth',
> > +                'fatload host 0:1 4000000 db2.auth',
> >                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db=
',
> >                   'fatload host 0:1 4000000 dbx_hash512.auth',
> >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx']=
)
>
