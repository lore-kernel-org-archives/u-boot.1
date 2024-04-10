Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CFBCD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 11:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2C4588166;
	Wed, 10 Apr 2024 13:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q1jmcYb3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D89298818E; Wed, 10 Apr 2024 13:53:48 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B6D588122
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 13:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-516d0c004b1so7877828e87.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 04:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712750026; x=1713354826; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d6j3xCW4JPyqOVYWdF2WVJR1il81BY4RSrHV94YRmq0=;
 b=Q1jmcYb3+EAXsE/JzZF6yczNVQj/F0SdUIY+8vm0jB/CO3jPuEaHDaQEeU8t7Fy2EA
 s3wsrspj4ZNQQJRYLUut42lV29y00CLHyXBPwGEAJJxAKBfNlaogQcju/S5bAua5+Dpa
 u6YD4WF4nUqUbTE+PgR1U5jztdpvqMU6N5HSAaX981nS5na1lpaHi1smRRBomw++u4T9
 VaOoWae8/eA6r8c5nwkmpahYgOoiW89T7NKqtWSQiIoMqvXp4PWyLwbEoXvZQ6ykcMWx
 xJ91JkABM1a4w7YIcMM6rkj1lVeDUWkAvOYUlGSO5RT0Ky1j4Ow/LBB8kmqFRIenoBat
 OT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712750026; x=1713354826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d6j3xCW4JPyqOVYWdF2WVJR1il81BY4RSrHV94YRmq0=;
 b=pA0CdHunJ2rJtEWGwkwfXknVfezyrseRdUQvbW+k+2wNOUIGLXPB94ktZCz78KwVtM
 5NhZ5DmPVs5v3ZTDJbuTdyhhb3CakuWuFAnPVGAv0wei1QupzgaAgl9uNpFNYla5AjJ6
 YNKzXwrZXc1tQT6P5gCs41xt4ZDJMIdOhLsxdequQEDIl5NmD3ka80ClGzEMWFznX0+l
 XnIae7yVc+WmLrNvkFckSF3DaSTcdJfNVbKLgbc1PxH2fcm8VzjS381rxLk3LMoVVNH1
 OC4dIk9ZCVZaQemxeR5Xix9DnXEXOM70kknMefwbbcExahlbwIfFfAc3nj3phTtAYz/Y
 amYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTGo5N2AZvnQwkZCwly/e0XhGE8/ZFTTic37rvhyX4NEWEmpWTNxAisjVxVE/XkVshFy8POPhVaAgQG70ddXpepINqKA==
X-Gm-Message-State: AOJu0Yx/7eyZsOjYLhtPGl2Oa9JJeDB1EfPqHYUObz8bnhwceo4PON96
 1byvIl4y7DffYYs43Bw48dQ64EDvZlVj/LVJ7Nl4IITSWjngDybFhoCtuRC04WtKu0TYilrhykq
 5vHhi7lYSzFL2SZ4CcWkBYMB7O/M=
X-Google-Smtp-Source: AGHT+IGL8iOkGGjoTKEI1fFajmFz7LMzjqbUhWP/seVqTMNko6XijTpLYOcI4swBxgGUXeCNbjWN1y9An8qmGpwgQr0=
X-Received: by 2002:a05:6512:159:b0:515:8c97:ff47 with SMTP id
 m25-20020a056512015900b005158c97ff47mr1769881lfo.23.1712750025189; Wed, 10
 Apr 2024 04:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240327140628.106143-1-o451686892@gmail.com>
 <e2262678-5a0b-4130-af8d-5e3b93b16aaa@gmx.de>
 <CAHk0HosTU1-gfDGYf+gp+LzDxJY_z=ZO8jYHrAChDtprd-xWcA@mail.gmail.com>
In-Reply-To: <CAHk0HosTU1-gfDGYf+gp+LzDxJY_z=ZO8jYHrAChDtprd-xWcA@mail.gmail.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Wed, 10 Apr 2024 19:53:33 +0800
Message-ID: <CAHk0Hos1NAJoFYrvgvaT2AaU8B+8UTau34x16715k9yNoWd5NA@mail.gmail.com>
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

On Thu, Apr 4, 2024 at 1:48=E2=80=AFAM Weizhao Ouyang <o451686892@gmail.com=
> wrote:
>
> Hi Heinrich,
>
> On Wed, Apr 3, 2024 at 10:54=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@=
gmx.de> wrote:
> >
> > On 27.03.24 15:06, Weizhao Ouyang wrote:
> > > According to UEFI v2.10 spec section 8.2.6, if a caller invokes the
> > > SetVariables() service, it will produce a digest from hash(VariableNa=
me,
> > > VendorGuid, Attributes, TimeStamp, DataNew_variable_content), then th=
e
> > > firmware that implements the SetVariable() service will compare the
> > > digest with the result of applying the signer=E2=80=99s public key to=
 the
> > > signature. For EFI variable append write, efitools sign-efi-sig-list =
has
> > > an option "-a" to add EFI_VARIABLE_APPEND_WRITE attr, and u-boot will
> > > drop this attribute in efi_set_variable_int(). So if a caller uses
> > > "sign-efi-sig-list -a" to create the authenticated variable, this app=
end
> > > write will fail in the u-boot due to "hash check failed".
> >
> > Currently U-Boot does not allow to use EFI_VARIABLE_APPEND_WRITE for an=
y
> > non-existent variable, signed or not. This does not match the EDK II
> > behavior.
>
> I'm not referring to the non-existent variable situation, it's a normal
> existent variable update.
>
> I mean:
> 1. process PK
> 2. process KEK
> 3. process a new APPEND_WRITE KEK (came from "sign-efi-sig-list -a ...",
>    so the digest and attrtibute of the KEK auth file will contain
>    APPEND_WRITE)
> Then the hash check will fail.
>
> >
> > There is a patch queued for this issue:
> >
> > [PATCH v2] efi_loader: fix append write behavior to non-existent variab=
le
> > https://lore.kernel.org/u-boot/20240402090950.3819705-1-kojima.masahisa=
@socionext.com/
> >
> > Could you, please, retest with that patch.
> >
> > >
> > > This patch resumes writing the EFI_VARIABLE_APPEND_WRITE attr to ensu=
re
> > > that the hash check is correct. And also update the "test_efi_secboot=
"
> > > test case to compliance with the change.
> > >
> > > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > > ---
> > >   lib/efi_loader/efi_variable.c                  |  3 +--
> > >   test/py/tests/test_efi_secboot/conftest.py     | 10 ++++++++++
> > >   test/py/tests/test_efi_secboot/test_authvar.py |  4 ++--
> > >   test/py/tests/test_efi_secboot/test_signed.py  | 10 +++++-----
> > >   4 files changed, 18 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_varia=
ble.c
> > > index 40f7a0fb10..f41aa8f9ad 100644
> > > --- a/lib/efi_loader/efi_variable.c
> > > +++ b/lib/efi_loader/efi_variable.c
> > > @@ -259,7 +259,6 @@ efi_status_t efi_set_variable_int(const u16 *vari=
able_name,
> > >       /* check if a variable exists */
> > >       var =3D efi_var_mem_find(vendor, variable_name, NULL);
> > >       append =3D !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> > > -     attributes &=3D ~(u32)EFI_VARIABLE_APPEND_WRITE;
> >
> > According to the UEFI specification for GetVariable():
> >
> > "The EFI_VARIABLE_APPEND_WRITE attribute will never be set in the
> > returned Attributes bitmask parameter."
>
> Yes, that's why I called it a RFC patch.
>
> >
> > We don't want to set EFI_VARIABLE_APPEND_WRITE in a variable when
> > calling efi_var_mem_ins().
>
> The APPEND_WRITE attribute is allowed to be set prior to invoking the
> service (UEFI section 8.2.6). So anyway we should consider compatibility
> with this case, along with making changes to GetVariable().

Part of the process in edk2 is:

VerifyTimeBasedPayloadAndUpdate
--> VerifyTimeBasedPayload // calculate digest and compare digest
--> AuthServiceInternalUpdateVariableWithTimeStamp
    --> VariableExLibUpdateVariable
        --> UpdateVariable // unset the APPEND_WRITE

We can align with this implementation.

BR,
Weizhao

>
> BR,
> Weizhao
>
> >
> > >       delete =3D !append && (!data_size || !attributes);
> > >
> > >       /* check attributes */
> > > @@ -275,7 +274,7 @@ efi_status_t efi_set_variable_int(const u16 *vari=
able_name,
> > >
> > >               /* attributes won't be changed */
> > >               if (!delete &&
> > > -                 ((ro_check && var->attr !=3D attributes) ||
> > > +                 ((ro_check && var->attr !=3D (attributes & ~(u32)EF=
I_VARIABLE_APPEND_WRITE)) ||
> > >                    (!ro_check && ((var->attr & ~(u32)EFI_VARIABLE_REA=
D_ONLY)
> >
> > The (u32) conversions are superfluous.
> >
> > Best regards
> >
> > Heinrich
> >
> > >                                   !=3D (attributes & ~(u32)EFI_VARIAB=
LE_READ_ONLY))))) {
> > >                       return EFI_INVALID_PARAMETER;
> > > diff --git a/test/py/tests/test_efi_secboot/conftest.py b/test/py/tes=
ts/test_efi_secboot/conftest.py
> > > index ff7ac7c810..0fa0747fc7 100644
> > > --- a/test/py/tests/test_efi_secboot/conftest.py
> > > +++ b/test/py/tests/test_efi_secboot/conftest.py
> > > @@ -64,6 +64,12 @@ def efi_boot_env(request, u_boot_config):
> > >           check_call('cd %s; %scert-to-efi-sig-list -g %s db1.crt db1=
.esl; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key db db1.esl =
db1.auth'
> > >                      % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH=
),
> > >                      shell=3DTrue)
> > > +        # db2 (APPEND_WRITE)
> > > +        check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:204=
8 -subj /CN=3DTEST_db2/ -keyout db2.key -out db2.crt -nodes -days 365'
> > > +                   % mnt_point, shell=3DTrue)
> > > +        check_call('cd %s; %scert-to-efi-sig-list -g %s db2.crt db2.=
esl; %ssign-efi-sig-list -a -c KEK.crt -k KEK.key db db2.esl db2.auth'
> > > +                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH)=
,
> > > +                   shell=3DTrue)
> > >           # dbx (TEST_dbx certificate)
> > >           check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:20=
48 -subj /CN=3DTEST_dbx/ -keyout dbx.key -out dbx.crt -nodes -days 365'
> > >                      % mnt_point, shell=3DTrue)
> > > @@ -84,6 +90,10 @@ def efi_boot_env(request, u_boot_config):
> > >           check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 db1=
.crt dbx_hash1.crl; %ssign-efi-sig-list -t "2020-04-06" -c KEK.crt -k KEK.k=
ey dbx dbx_hash1.crl dbx_hash1.auth'
> > >                      % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH=
),
> > >                      shell=3DTrue)
> > > +        # dbx_hash2 (digest of TEST_db2 certificate, with APPEND_WRI=
TE)
> > > +        check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 db2.=
crt dbx_hash2.crl; %ssign-efi-sig-list -a -c KEK.crt -k KEK.key dbx dbx_has=
h2.crl dbx_hash2.auth'
> > > +                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH)=
,
> > > +                   shell=3DTrue)
> > >           # dbx_db (with TEST_db certificate)
> > >           check_call('cd %s; %ssign-efi-sig-list -t "2020-04-05" -c K=
EK.crt -k KEK.key dbx db.esl dbx_db.auth'
> > >                      % (mnt_point, EFITOOLS_PATH),
> > > diff --git a/test/py/tests/test_efi_secboot/test_authvar.py b/test/py=
/tests/test_efi_secboot/test_authvar.py
> > > index f99b8270a6..d5aeb65048 100644
> > > --- a/test/py/tests/test_efi_secboot/test_authvar.py
> > > +++ b/test/py/tests/test_efi_secboot/test_authvar.py
> > > @@ -183,7 +183,7 @@ class TestEfiAuthVar(object):
> > >               assert 'db:' in ''.join(output)
> > >
> > >               output =3D u_boot_console.run_command_list([
> > > -                'fatload host 0:1 4000000 db1.auth',
> > > +                'fatload host 0:1 4000000 db2.auth',
> > >                   'setenv -e -nv -bs -rt -a -i 4000000:$filesize db']=
)
> > >               assert 'Failed to set EFI variable' in ''.join(output)
> > >
> > > @@ -197,7 +197,7 @@ class TestEfiAuthVar(object):
> > >           with u_boot_console.log.section('Test Case 3c'):
> > >               # Test Case 3c, update with correct signature
> > >               output =3D u_boot_console.run_command_list([
> > > -                'fatload host 0:1 4000000 db1.auth',
> > > +                'fatload host 0:1 4000000 db2.auth',
> > >                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize =
db',
> > >                   'printenv -e -n -guid d719b2cb-3d3a-4596-a3bc-dad00=
e67656f db'])
> > >               assert 'Failed to set EFI variable' not in ''.join(outp=
ut)
> > > diff --git a/test/py/tests/test_efi_secboot/test_signed.py b/test/py/=
tests/test_efi_secboot/test_signed.py
> > > index 2f862a259a..34719ad1f2 100644
> > > --- a/test/py/tests/test_efi_secboot/test_signed.py
> > > +++ b/test/py/tests/test_efi_secboot/test_signed.py
> > > @@ -177,7 +177,7 @@ class TestEfiSignedImage(object):
> > >           with u_boot_console.log.section('Test Case 5b'):
> > >               # Test Case 5b, authenticated if both signatures are ve=
rified
> > >               output =3D u_boot_console.run_command_list([
> > > -                'fatload host 0:1 4000000 db1.auth',
> > > +                'fatload host 0:1 4000000 db2.auth',
> > >                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize =
db'])
> > >               assert 'Failed to set EFI variable' not in ''.join(outp=
ut)
> > >               output =3D u_boot_console.run_command_list([
> > > @@ -201,7 +201,7 @@ class TestEfiSignedImage(object):
> > >           with u_boot_console.log.section('Test Case 5d'):
> > >               # Test Case 5d, rejected if both of signatures are revo=
ked
> > >               output =3D u_boot_console.run_command_list([
> > > -                'fatload host 0:1 4000000 dbx_hash1.auth',
> > > +                'fatload host 0:1 4000000 dbx_hash2.auth',
> > >                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize =
dbx'])
> > >               assert 'Failed to set EFI variable' not in ''.join(outp=
ut)
> > >               output =3D u_boot_console.run_command_list([
> > > @@ -223,7 +223,7 @@ class TestEfiSignedImage(object):
> > >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK=
',
> > >                   'fatload host 0:1 4000000 PK.auth',
> > >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'=
,
> > > -                'fatload host 0:1 4000000 db1.auth',
> > > +                'fatload host 0:1 4000000 db2.auth',
> > >                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize =
db',
> > >                   'fatload host 0:1 4000000 dbx_hash1.auth',
> > >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx=
'])
> > > @@ -300,7 +300,7 @@ class TestEfiSignedImage(object):
> > >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK=
',
> > >                   'fatload host 0:1 4000000 PK.auth',
> > >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'=
,
> > > -                'fatload host 0:1 4000000 db1.auth',
> > > +                'fatload host 0:1 4000000 db2.auth',
> > >                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize =
db',
> > >                   'fatload host 0:1 4000000 dbx_hash384.auth',
> > >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx=
'])
> > > @@ -323,7 +323,7 @@ class TestEfiSignedImage(object):
> > >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK=
',
> > >                   'fatload host 0:1 4000000 PK.auth',
> > >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'=
,
> > > -                'fatload host 0:1 4000000 db1.auth',
> > > +                'fatload host 0:1 4000000 db2.auth',
> > >                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize =
db',
> > >                   'fatload host 0:1 4000000 dbx_hash512.auth',
> > >                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx=
'])
> >
