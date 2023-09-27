Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A9FE7F150
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 00:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB23686C23;
	Wed, 27 Sep 2023 02:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HwEGRbHE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74A6D86C23; Wed, 27 Sep 2023 02:43:14 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C75B86BE7
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 02:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59c00b5c8b2so122646777b3.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 17:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695775391; x=1696380191; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WTYiId/av9W8s6vrOVb2uOHTB57e3cWID4cIfYagzM=;
 b=HwEGRbHEy1RGOCtoaax8Tk2UWm0tV74Mu0jiwArElqcMIMqO06/cG0BgJ5cOUJKGEG
 WiV6TCoSV+DepFSN/VWJ/ma+zK+g0aiWD0MuXQTtvcLBOjeKH6Wch1D5ru/Gy2WOArkK
 wpLUIo4wW66R3kyRX8Y1ZQeM3GekKnEDSrLQjMnKEQXkgecao9Bg86UmZe6EnUmzvRr1
 Ovdqeeu8Bjwi2Gfjtz9uwWfTUJv8TemsRfIRAE4TxtS677xuDP1iFxmUDOvj/JIovPOa
 rKqw+tbMy7tvbviuKe8LxOwQvdY5CfgO0RKho+4ZuvqfgCzDlOfEjzcmpkDWz2xBwnAP
 EMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695775391; x=1696380191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9WTYiId/av9W8s6vrOVb2uOHTB57e3cWID4cIfYagzM=;
 b=lLdTPWEZIWdq550BIrlm4YWHtnkTzOLEssyEiVPoeo+8jc6Q6xwUeIMF9XS8jpMxHu
 OWO11r3SoDoh1kTJKDSOyIE+oo9WKwZbNzg5MdZHLXxVli40vSsUD+zhAgAhYkIE6KkM
 Sf5a0Fz84OnTAwgkSIy3fveHiiVVlY/70WtVBMk7hOuNWmbpvie7iOqkJTRtoqLdE1Ck
 2pgFxKzwVbiAARW4lFGgItQKo6E4N6S5dYg67HZg+j0ezUYimv8+FMdO18Mg+saw+PxP
 YzbziIOZycyDybJC3b/LWWT2B5LLF5132nTzHyADmvuP1x/1Kbq6YHVOTWC6QlhbpVdT
 Btxg==
X-Gm-Message-State: AOJu0YyoQugRgXLqkmOjrUWRDHOrc7LHP24pL1kC6n7Z1sY3+Hah7Nb4
 LfXHjotRDjMvBcadrZBtWhFc47+ygZrONV/JxipzgA==
X-Google-Smtp-Source: AGHT+IH2sXlxaRRWI9xEQ2gH+y5+ggLQSl9RLrw7FuAqsl/JlWYKEdAA7zNWXyZXQNdGI4TAMypSOdot6yoj5e5hax8=
X-Received: by 2002:a0d:eacc:0:b0:59b:f152:8998 with SMTP id
 t195-20020a0deacc000000b0059bf1528998mr672923ywe.19.1695775390628; Tue, 26
 Sep 2023 17:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230920084121.1248590-1-masahisa.kojima@linaro.org>
 <CAC_iWjLsF1hK=aroC9+GfY0_3hQVwKScYJzprH6jcNTbsxw4rQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLsF1hK=aroC9+GfY0_3hQVwKScYJzprH6jcNTbsxw4rQ@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Wed, 27 Sep 2023 09:42:59 +0900
Message-ID: <CADQ0-X_=rcFpBdxhCG+qoB6NY0HoFrtOucXMVtXZvNeKEf=OeQ@mail.gmail.com>
Subject: Re: [PATCH v11] Boot var automatic management for removable medias
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>
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

Hi Ilias,

On Wed, 27 Sept 2023 at 03:52, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 20 Sept 2023 at 11:41, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > From: Raymond Mao <raymond.mao@linaro.org>
> >
> > Changes for complying to EFI spec =C2=A73.5.1.1
> > 'Removable Media Boot Behavior'.
> > Boot variables can be automatically generated during a removable
> > media is probed. At the same time, unused boot variables will be
> > detected and removed.
> >
> > Please note that currently the function 'efi_disk_remove' has no
> > ability to distinguish below two scenarios
> > a) Unplugging of a removable media under U-Boot
> > b) U-Boot exiting and booting an OS
> > Thus currently the boot variables management is not added into
> > 'efi_disk_remove' to avoid boot options being added/erased
> > repeatedly under scenario b) during power cycles
> > See TODO comments under function 'efi_disk_remove' for more details
> >
> > The original efi_secboot tests expect that BootOrder EFI variable
> > is not defined. With this commit, the BootOrder EFI variable is
> > automatically added when the disk is detected. The original efi_secboot
> > tests end up with unexpected failure.
> > The efi_secboot tests need to be modified to clear the BootOrder
> > EFI variable at the beginning of each test.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >  lib/efi_loader/efi_disk.c                      | 18 ++++++++++++++++++
> >  lib/efi_loader/efi_setup.c                     |  7 +++++++
> >  test/py/tests/test_efi_secboot/test_signed.py  |  9 +++++++++
> >  .../test_efi_secboot/test_signed_intca.py      |  3 +++
> >  .../py/tests/test_efi_secboot/test_unsigned.py |  3 +++
> >  5 files changed, 40 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > index f0d76113b0..b808a7fe62 100644
> > --- a/lib/efi_loader/efi_disk.c
> > +++ b/lib/efi_loader/efi_disk.c
> > @@ -690,6 +690,13 @@ int efi_disk_probe(void *ctx, struct event *event)
> >                         return -1;
> >         }
> >
> > +       /* only do the boot option management when UEFI sub-system is i=
nitialized */
> > +       if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) && efi_obj_list_init=
ialized =3D=3D EFI_SUCCESS) {
> > +               ret =3D efi_bootmgr_update_media_device_boot_option();
> > +               if (ret !=3D EFI_SUCCESS)
> > +                       return -1;
> > +       }
> > +
> >         return 0;
> >  }
> >
> > @@ -742,6 +749,17 @@ int efi_disk_remove(void *ctx, struct event *event=
)
> >         dev_tag_del(dev, DM_TAG_EFI);
> >
> >         return 0;
> > +
> > +       /*
> > +        * TODO A flag to distinguish below 2 different scenarios of th=
is
> > +        * function call is needed:
> > +        * a) Unplugging of a removable media under U-Boot
> > +        * b) U-Boot exiting and booting an OS
> > +        * In case of scenario a), efi_bootmgr_update_media_device_boot=
_option()
> > +        * needs to be invoked here to update the boot options and remo=
ve the
> > +        * unnecessary ones.
> > +        */
> > +
> >  }
> >
> >  /**
> > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> > index 58d4e13402..69c8b27730 100644
> > --- a/lib/efi_loader/efi_setup.c
> > +++ b/lib/efi_loader/efi_setup.c
> > @@ -245,6 +245,13 @@ efi_status_t efi_init_obj_list(void)
> >         if (ret !=3D EFI_SUCCESS)
> >                 goto out;
> >
> > +       if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR)) {
> > +               /* update boot option after variable service initialize=
d */
> > +               ret =3D efi_bootmgr_update_media_device_boot_option();
> > +               if (ret !=3D EFI_SUCCESS)
> > +                       goto out;
> > +       }
> > +
> >         /* Define supported languages */
> >         ret =3D efi_init_platform_lang();
> >         if (ret !=3D EFI_SUCCESS)
> > diff --git a/test/py/tests/test_efi_secboot/test_signed.py b/test/py/te=
sts/test_efi_secboot/test_signed.py
> > index ca52e853d8..b77b60e223 100644
> > --- a/test/py/tests/test_efi_secboot/test_signed.py
> > +++ b/test/py/tests/test_efi_secboot/test_signed.py
> > @@ -28,6 +28,7 @@ class TestEfiSignedImage(object):
> >              # Test Case 1a, run signed image if no PK
> >              output =3D u_boot_console.run_command_list([
> >                  'host bind 0 %s' % disk_img,
> > +                'setenv -e -nv -bs -rt BootOrder',
> >                  'efidebug boot add -b 1 HELLO1 host 0:1 /helloworld.ef=
i.signed -s ""',
> >                  'efidebug boot next 1',
> >                  'bootefi bootmgr'])
> > @@ -52,6 +53,7 @@ class TestEfiSignedImage(object):
> >              # Test Case 2a, db is not yet installed
> >              output =3D u_boot_console.run_command_list([
> >                  'host bind 0 %s' % disk_img,
> > +                'setenv -e -nv -bs -rt BootOrder',
> >                  'fatload host 0:1 4000000 KEK.auth',
> >                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
> >                  'fatload host 0:1 4000000 PK.auth',
> > @@ -96,6 +98,7 @@ class TestEfiSignedImage(object):
> >              # Test Case 3a, rejected by dbx
> >              output =3D u_boot_console.run_command_list([
> >                  'host bind 0 %s' % disk_img,
> > +                'setenv -e -nv -bs -rt BootOrder',
> >                  'fatload host 0:1 4000000 db.auth',
> >                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
> >                  'fatload host 0:1 4000000 KEK.auth',
> > @@ -132,6 +135,7 @@ class TestEfiSignedImage(object):
> >              # Test Case 4, rejected by dbx
> >              output =3D u_boot_console.run_command_list([
> >                  'host bind 0 %s' % disk_img,
> > +                'setenv -e -nv -bs -rt BootOrder',
> >                  'fatload host 0:1 4000000 dbx_hash.auth',
> >                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
> >                  'fatload host 0:1 4000000 db.auth',
> > @@ -161,6 +165,7 @@ class TestEfiSignedImage(object):
> >              # is verified
> >              output =3D u_boot_console.run_command_list([
> >                  'host bind 0 %s' % disk_img,
> > +                'setenv -e -nv -bs -rt BootOrder',
> >                  'fatload host 0:1 4000000 db.auth',
> >                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
> >                  'fatload host 0:1 4000000 KEK.auth',
> > @@ -217,6 +222,7 @@ class TestEfiSignedImage(object):
> >              # is verified. Same as before but reject dbx_hash1.auth on=
ly
> >              output =3D u_boot_console.run_command_list([
> >                  'host bind 0 %s' % disk_img,
> > +                'setenv -e -nv -bs -rt BootOrder',
> >                  'fatload host 0:1 4000000 db.auth',
> >                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
> >                  'fatload host 0:1 4000000 KEK.auth',
> > @@ -294,6 +300,7 @@ class TestEfiSignedImage(object):
> >          with u_boot_console.log.section('Test Case 7a'):
> >              output =3D u_boot_console.run_command_list([
> >                  'host bind 0 %s' % disk_img,
> > +                'setenv -e -nv -bs -rt BootOrder',
> >                  'fatload host 0:1 4000000 db.auth',
> >                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
> >                  'fatload host 0:1 4000000 KEK.auth',
> > @@ -317,6 +324,7 @@ class TestEfiSignedImage(object):
> >          with u_boot_console.log.section('Test Case 7b'):
> >              output =3D u_boot_console.run_command_list([
> >                  'host bind 0 %s' % disk_img,
> > +                'setenv -e -nv -bs -rt BootOrder',
> >                  'fatload host 0:1 4000000 db.auth',
> >                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
> >                  'fatload host 0:1 4000000 KEK.auth',
> > @@ -348,6 +356,7 @@ class TestEfiSignedImage(object):
> >              # Test Case 8a, Secure boot is not yet forced
> >              output =3D u_boot_console.run_command_list([
> >                  'host bind 0 %s' % disk_img,
> > +                'setenv -e -nv -bs -rt BootOrder',
> >                  'efidebug boot add -b 1 HELLO1 host 0:1 /helloworld_fo=
rged.efi.signed -s ""',
> >                  'efidebug boot next 1',
> >                  'efidebug test bootmgr'])
> > diff --git a/test/py/tests/test_efi_secboot/test_signed_intca.py b/test=
/py/tests/test_efi_secboot/test_signed_intca.py
> > index d8d599d22f..318715fa08 100644
> > --- a/test/py/tests/test_efi_secboot/test_signed_intca.py
> > +++ b/test/py/tests/test_efi_secboot/test_signed_intca.py
> > @@ -30,6 +30,7 @@ class TestEfiSignedImageIntca(object):
> >              # Test Case 1a, with no Int CA and not authenticated by ro=
ot CA
> >              output =3D u_boot_console.run_command_list([
> >                  'host bind 0 %s' % disk_img,
> > +                'setenv -e -nv -bs -rt BootOrder',
> >                  'fatload host 0:1 4000000 db_c.auth',
> >                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
> >                  'fatload host 0:1 4000000 KEK.auth',
> > @@ -63,6 +64,7 @@ class TestEfiSignedImageIntca(object):
> >              # Test Case 2a, unsigned and not authenticated by root CA
> >              output =3D u_boot_console.run_command_list([
> >                  'host bind 0 %s' % disk_img,
> > +                'setenv -e -nv -bs -rt BootOrder',
> >                  'fatload host 0:1 4000000 KEK.auth',
> >                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
> >                  'fatload host 0:1 4000000 PK.auth',
> > @@ -105,6 +107,7 @@ class TestEfiSignedImageIntca(object):
> >              # Test Case 3a, revoked by int CA in dbx
> >              output =3D u_boot_console.run_command_list([
> >                  'host bind 0 %s' % disk_img,
> > +                'setenv -e -nv -bs -rt BootOrder',
> >                  'fatload host 0:1 4000000 dbx_b.auth',
> >                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
> >                  'fatload host 0:1 4000000 db_c.auth',
> > diff --git a/test/py/tests/test_efi_secboot/test_unsigned.py b/test/py/=
tests/test_efi_secboot/test_unsigned.py
> > index df63f0df08..9042a46ccc 100644
> > --- a/test/py/tests/test_efi_secboot/test_unsigned.py
> > +++ b/test/py/tests/test_efi_secboot/test_unsigned.py
> > @@ -28,6 +28,7 @@ class TestEfiUnsignedImage(object):
> >              # Test Case 1
> >              output =3D u_boot_console.run_command_list([
> >                  'host bind 0 %s' % disk_img,
> > +                'setenv -e -nv -bs -rt BootOrder',
> >                  'fatload host 0:1 4000000 KEK.auth',
> >                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
> >                  'fatload host 0:1 4000000 PK.auth',
> > @@ -55,6 +56,7 @@ class TestEfiUnsignedImage(object):
> >              # Test Case 2
> >              output =3D u_boot_console.run_command_list([
> >                  'host bind 0 %s' % disk_img,
> > +                'setenv -e -nv -bs -rt BootOrder',
> >                  'fatload host 0:1 4000000 db_hello.auth',
> >                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
> >                  'fatload host 0:1 4000000 KEK.auth',
> > @@ -79,6 +81,7 @@ class TestEfiUnsignedImage(object):
> >              # Test Case 3a, rejected by dbx
> >              output =3D u_boot_console.run_command_list([
> >                  'host bind 0 %s' % disk_img,
> > +                'setenv -e -nv -bs -rt BootOrder',
> >                  'fatload host 0:1 4000000 db_hello.auth',
> >                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
> >                  'fatload host 0:1 4000000 KEK.auth',
> >
> > base-commit: 8bd7d08407f986fe3c69f3e198f6f7152e12dea8
> > --
> > 2.34.1
> >
>
> I think you should add your co-developped-by tag now since you fixed
> the CI issues,
>
> With that
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

OK, I will resend it.

Thanks,
Masahisa Kojima
