Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA9DCD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 17:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FEA6881F6;
	Wed,  3 Apr 2024 19:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lQfRG+Es";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 964088817B; Wed,  3 Apr 2024 19:48:27 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49C85881F6
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 19:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56e0e1d162bso85645a12.1
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 10:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712166505; x=1712771305; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fbccUT58qBqnkpwQxtx+vjr5GTJzr+t+foXmMgforc=;
 b=lQfRG+EsnrNUEpckYQ3MNQWikBzjEk8UXE9WtVP9vIK5QFw4m/v64zEqek1PZ2Q0vM
 zn8AOXPhYXZZmuYSugTFvP7LrKvhjs7Ibunzu5KHse28Y68zslzm7h1QKkzrBKaY+tPa
 w/2xZZPwSC6WG3Xxv7jezAIX02oT88mODYyJn3rw7lzvEO2KpbSGRkhUJDgedl1EArNl
 b8zZ6ltH7i0lczwgEUs5dBZoWf6wJdluLAg1Iu8TiXWLG56DRtmkYVdihHhRnubcn4iu
 foGcQ8DDRE6OCh0D/Okh/IJOVSPToG3Lva3/56q6szIsnF5zO1YHtBG5NaPzG9ps6q45
 IRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712166505; x=1712771305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4fbccUT58qBqnkpwQxtx+vjr5GTJzr+t+foXmMgforc=;
 b=cecp7R2YVnZ6kqU10V4U+8HKt5vf20f8wQj8iy/L1sdezLFrJljl+DrtM+gsPa2mB5
 EicC7txBYORVY5HJKOKwCP5QBRZC8i7MedKK9au/2+hwLWkgoFjfZgBHp2YdA3cCZo0V
 6g94c6qls/zMleT6mivZpianZCJm0hd4Lb8HtgsoxLy5SosMq3nu3ylBYsTTiEjVTwCx
 ztQRPgGtCphVqu8yB/tQXfDBi70AsPkYpr96gtGidBCj6FxTP2ryM04mAMLxjibNcge3
 UpLJsDFm18pcrbDmElubWOw9yx4qMA5AUWDfrnhwY4jPTNaZyHk5xtmm03zDRaWLPa1A
 HMTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/eO8p9/uj05oMLUfXPYN8fZYpGaytXCN/H9G5LTMF3vf+RN+9UDc6vMyi8GlJIfRil6BaCiWXffsTeL4FX7ITgjwGSQ==
X-Gm-Message-State: AOJu0Yz3N8l3acBsc8IamtILGzQR11lIt727R+6RRVKdJpp8MrxTl1e2
 HotyL75jQNVyUji/GmRDGgWTjUMInqxOZvNEQ/uEntLWmhlK6zSGkotw/AZpx3CFwYgaAsd89Vl
 piB7wZxNSRspC/eHVyt+75Jx3H/U=
X-Google-Smtp-Source: AGHT+IFQepOGdUxkuDdiCnmgaafvInmPABJU5SIYmvCZGPwSCI/BeQGD7pcPnpOlNWQlzGu/TOfxWzOC2EM/zh1Dkic=
X-Received: by 2002:a50:9e24:0:b0:565:dfac:a686 with SMTP id
 z33-20020a509e24000000b00565dfaca686mr89430ede.38.1712166504272; Wed, 03 Apr
 2024 10:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240327140628.106143-1-o451686892@gmail.com>
 <e2262678-5a0b-4130-af8d-5e3b93b16aaa@gmx.de>
In-Reply-To: <e2262678-5a0b-4130-af8d-5e3b93b16aaa@gmx.de>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Thu, 4 Apr 2024 01:48:12 +0800
Message-ID: <CAHk0HosTU1-gfDGYf+gp+LzDxJY_z=ZO8jYHrAChDtprd-xWcA@mail.gmail.com>
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

Hi Heinrich,

On Wed, Apr 3, 2024 at 10:54=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 27.03.24 15:06, Weizhao Ouyang wrote:
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
>
> Currently U-Boot does not allow to use EFI_VARIABLE_APPEND_WRITE for any
> non-existent variable, signed or not. This does not match the EDK II
> behavior.

I'm not referring to the non-existent variable situation, it's a normal
existent variable update.

I mean:
1. process PK
2. process KEK
3. process a new APPEND_WRITE KEK (came from "sign-efi-sig-list -a ...",
   so the digest and attrtibute of the KEK auth file will contain
   APPEND_WRITE)
Then the hash check will fail.

>
> There is a patch queued for this issue:
>
> [PATCH v2] efi_loader: fix append write behavior to non-existent variable
> https://lore.kernel.org/u-boot/20240402090950.3819705-1-kojima.masahisa@s=
ocionext.com/
>
> Could you, please, retest with that patch.
>
> >
> > This patch resumes writing the EFI_VARIABLE_APPEND_WRITE attr to ensure
> > that the hash check is correct. And also update the "test_efi_secboot"
> > test case to compliance with the change.
> >
> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > ---
> >   lib/efi_loader/efi_variable.c                  |  3 +--
> >   test/py/tests/test_efi_secboot/conftest.py     | 10 ++++++++++
> >   test/py/tests/test_efi_secboot/test_authvar.py |  4 ++--
> >   test/py/tests/test_efi_secboot/test_signed.py  | 10 +++++-----
> >   4 files changed, 18 insertions(+), 9 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variabl=
e.c
> > index 40f7a0fb10..f41aa8f9ad 100644
> > --- a/lib/efi_loader/efi_variable.c
> > +++ b/lib/efi_loader/efi_variable.c
> > @@ -259,7 +259,6 @@ efi_status_t efi_set_variable_int(const u16 *variab=
le_name,
> >       /* check if a variable exists */
> >       var =3D efi_var_mem_find(vendor, variable_name, NULL);
> >       append =3D !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> > -     attributes &=3D ~(u32)EFI_VARIABLE_APPEND_WRITE;
>
> According to the UEFI specification for GetVariable():
>
> "The EFI_VARIABLE_APPEND_WRITE attribute will never be set in the
> returned Attributes bitmask parameter."

Yes, that's why I called it a RFC patch.

>
> We don't want to set EFI_VARIABLE_APPEND_WRITE in a variable when
> calling efi_var_mem_ins().

The APPEND_WRITE attribute is allowed to be set prior to invoking the
service (UEFI section 8.2.6). So anyway we should consider compatibility
with this case, along with making changes to GetVariable().

BR,
Weizhao

>
> >       delete =3D !append && (!data_size || !attributes);
> >
> >       /* check attributes */
> > @@ -275,7 +274,7 @@ efi_status_t efi_set_variable_int(const u16 *variab=
le_name,
> >
> >               /* attributes won't be changed */
> >               if (!delete &&
> > -                 ((ro_check && var->attr !=3D attributes) ||
> > +                 ((ro_check && var->attr !=3D (attributes & ~(u32)EFI_=
VARIABLE_APPEND_WRITE)) ||
> >                    (!ro_check && ((var->attr & ~(u32)EFI_VARIABLE_READ_=
ONLY)
>
> The (u32) conversions are superfluous.
>
> Best regards
>
> Heinrich
>
> >                                   !=3D (attributes & ~(u32)EFI_VARIABLE=
_READ_ONLY))))) {
> >                       return EFI_INVALID_PARAMETER;
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
> > index 2f862a259a..34719ad1f2 100644
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
