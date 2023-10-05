Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AFEE936ED
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 01:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 844A887522;
	Thu,  5 Oct 2023 03:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rhq7QWjh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59B0687522; Thu,  5 Oct 2023 03:01:06 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E953E8757D
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 03:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-27740ce6c76so281424a91.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 18:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696467656; x=1697072456; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lOMCYkerI+rKoLjXWf732/AbPf/YBZAcLZzjGXRAiuo=;
 b=rhq7QWjhaS9etXtLscUGbNIIirFBdMYGGkJqJe2ZWKb6OnxSmhSJ/AlpwN8djZJAuj
 WOFlBXVmItFXoxIDfiRd4LcKmVcETrw5LNXhjzFf/EAHfX/luOAKIlDZySpC1Q7my05l
 kkJZ11aSvoYwhscHgCt1klDweMFmdxetLdGTVqYUhHmOqFbaXRhElmpeJrh04qw9xIaR
 1iOzez+TvmIkyUDnS4lViYhYvAXhZt79q2uPI95NBi4X42N7N6MQSdxEYGqcRafLagwv
 vvn8MqcgVN3b1E7uZs7LRo3iraiQ/UcZ3zRMBVyf4VL/3vbC/zUi/ll/TcSkUsFapbqV
 7m7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696467656; x=1697072456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lOMCYkerI+rKoLjXWf732/AbPf/YBZAcLZzjGXRAiuo=;
 b=kPnnU1eI9jDAHW48njBj0/U+mR2AHnQzvmSUIWJrvfJr6YaWEZD0Lo1P1sQ0oKW1R7
 oYN/9vYRXnH9bWvRIXx+J0qfy+Ue0IuDB7XHln3LTZnrvMvO0TbKXnDY+gfi3tDHBo7s
 D5N7HF3gOYO9bM27CBkNep8bMqbDPoMgc74rJD0oCBJCIcZhcaOsgMCxZMqEMMX+3HrQ
 wYK3wSHKvp82Hz1TmQ/j6dfenmJjpE/z72L5QHnUYJBFrXZKdeQVgQbz64D+etFgKr2l
 j3TyI2DnDEATSU1jNbraWnzZCrnRijMzBZ6sdf0vER9ZC3Ci7JX3ZLhd29uFf+6ikzbz
 3OJg==
X-Gm-Message-State: AOJu0Yyx6+IEQzASZ2YuNlTZECDmp87FWuN8j8ea2YpA7lTQecSQzKGZ
 BtWwPVGrLG5z0dOdHEVOMWRzhx/SAyWujzRoFdjKr33cA1GN4NIE
X-Google-Smtp-Source: AGHT+IFMeLafzKXIN2O7MHejMJhIpOyNNELw26X5SA8ogiN2JjBW6c1VXGnKn2f2Yd/Ij3bpCSOqj3bi7RR4bxzf2BQ=
X-Received: by 2002:a17:90a:e651:b0:268:1be1:745a with SMTP id
 ep17-20020a17090ae65100b002681be1745amr3513418pjb.29.1696467656479; Wed, 04
 Oct 2023 18:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230927010436.1503621-1-masahisa.kojima@linaro.org>
In-Reply-To: <20230927010436.1503621-1-masahisa.kojima@linaro.org>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Thu, 5 Oct 2023 10:00:45 +0900
Message-ID: <CADQ0-X9qG+qyZe9eeS6tOH=ySMQqWcxyJRYLBRmanEceC6PECg@mail.gmail.com>
Subject: Re: [PATCH v12] Boot var automatic management for removable medias
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>
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

Hi Tom, Heinrich, Ilias,
 # Added Tom since this patch is delegated to him

On Wed, 27 Sept 2023 at 10:06, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> From: Raymond Mao <raymond.mao@linaro.org>
>
> Changes for complying to EFI spec =C2=A73.5.1.1
> 'Removable Media Boot Behavior'.
> Boot variables can be automatically generated during a removable
> media is probed. At the same time, unused boot variables will be
> detected and removed.
>
> Please note that currently the function 'efi_disk_remove' has no
> ability to distinguish below two scenarios
> a) Unplugging of a removable media under U-Boot
> b) U-Boot exiting and booting an OS
> Thus currently the boot variables management is not added into
> 'efi_disk_remove' to avoid boot options being added/erased
> repeatedly under scenario b) during power cycles
> See TODO comments under function 'efi_disk_remove' for more details
>
> The original efi_secboot tests expect that BootOrder EFI variable
> is not defined. With this commit, the BootOrder EFI variable is
> automatically added when the disk is detected. The original efi_secboot
> tests end up with unexpected failure.
> The efi_secboot tests need to be modified to clear the BootOrder
> EFI variable at the beginning of each test.
>
> Co-developed-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/efi_loader/efi_disk.c                      | 18 ++++++++++++++++++
>  lib/efi_loader/efi_setup.c                     |  7 +++++++
>  test/py/tests/test_efi_secboot/test_signed.py  |  9 +++++++++
>  .../test_efi_secboot/test_signed_intca.py      |  3 +++
>  .../py/tests/test_efi_secboot/test_unsigned.py |  3 +++
>  5 files changed, 40 insertions(+)
>
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index f0d76113b0..b808a7fe62 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -690,6 +690,13 @@ int efi_disk_probe(void *ctx, struct event *event)
>                         return -1;
>         }
>
> +       /* only do the boot option management when UEFI sub-system is ini=
tialized */
> +       if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) && efi_obj_list_initia=
lized =3D=3D EFI_SUCCESS) {
> +               ret =3D efi_bootmgr_update_media_device_boot_option();
> +               if (ret !=3D EFI_SUCCESS)
> +                       return -1;
> +       }
> +
>         return 0;
>  }
>
> @@ -742,6 +749,17 @@ int efi_disk_remove(void *ctx, struct event *event)
>         dev_tag_del(dev, DM_TAG_EFI);
>
>         return 0;
> +
> +       /*
> +        * TODO A flag to distinguish below 2 different scenarios of this
> +        * function call is needed:
> +        * a) Unplugging of a removable media under U-Boot
> +        * b) U-Boot exiting and booting an OS
> +        * In case of scenario a), efi_bootmgr_update_media_device_boot_o=
ption()
> +        * needs to be invoked here to update the boot options and remove=
 the
> +        * unnecessary ones.
> +        */
> +
>  }
>
>  /**
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index 58d4e13402..69c8b27730 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -245,6 +245,13 @@ efi_status_t efi_init_obj_list(void)
>         if (ret !=3D EFI_SUCCESS)
>                 goto out;
>
> +       if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR)) {
> +               /* update boot option after variable service initialized =
*/
> +               ret =3D efi_bootmgr_update_media_device_boot_option();
> +               if (ret !=3D EFI_SUCCESS)
> +                       goto out;
> +       }
> +
>         /* Define supported languages */
>         ret =3D efi_init_platform_lang();
>         if (ret !=3D EFI_SUCCESS)
> diff --git a/test/py/tests/test_efi_secboot/test_signed.py b/test/py/test=
s/test_efi_secboot/test_signed.py
> index ca52e853d8..b77b60e223 100644
> --- a/test/py/tests/test_efi_secboot/test_signed.py
> +++ b/test/py/tests/test_efi_secboot/test_signed.py
> @@ -28,6 +28,7 @@ class TestEfiSignedImage(object):
>              # Test Case 1a, run signed image if no PK
>              output =3D u_boot_console.run_command_list([
>                  'host bind 0 %s' % disk_img,
> +                'setenv -e -nv -bs -rt BootOrder',

This patch itself is trying to automatically add the EFI boot
option(BOOT####) and
update the BootOrder variable.
I now understand that clearing the BootOrder variable is not an appropriate=
 fix
in this efi_secboot test, 'setenv -e -nv -bs -rt BootOrder' fails
when the BootOrder variable is not found.
When booting the system with BootNext fails, efibootmgr falls back to BootO=
rder.
Instead of loading an image with BootNext, efi_secboot tests need to
explicitly set
the BootOrder variable.

I will revise this patch, and let me include this patch in EFI HTTP
Boot series[1].
As discussed with Ilias, EFI HTTP Boot series[1] will rely heavily on
this patch.

[1] https://lore.kernel.org/u-boot/20230927093631.1595494-1-masahisa.kojima=
@linaro.org/

Thanks,
Masahisa Kojima



>                  'efidebug boot add -b 1 HELLO1 host 0:1 /helloworld.efi.=
signed -s ""',
>                  'efidebug boot next 1',
>                  'bootefi bootmgr'])
> @@ -52,6 +53,7 @@ class TestEfiSignedImage(object):
>              # Test Case 2a, db is not yet installed
>              output =3D u_boot_console.run_command_list([
>                  'host bind 0 %s' % disk_img,
> +                'setenv -e -nv -bs -rt BootOrder',
>                  'fatload host 0:1 4000000 KEK.auth',
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
>                  'fatload host 0:1 4000000 PK.auth',
> @@ -96,6 +98,7 @@ class TestEfiSignedImage(object):
>              # Test Case 3a, rejected by dbx
>              output =3D u_boot_console.run_command_list([
>                  'host bind 0 %s' % disk_img,
> +                'setenv -e -nv -bs -rt BootOrder',
>                  'fatload host 0:1 4000000 db.auth',
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
>                  'fatload host 0:1 4000000 KEK.auth',
> @@ -132,6 +135,7 @@ class TestEfiSignedImage(object):
>              # Test Case 4, rejected by dbx
>              output =3D u_boot_console.run_command_list([
>                  'host bind 0 %s' % disk_img,
> +                'setenv -e -nv -bs -rt BootOrder',
>                  'fatload host 0:1 4000000 dbx_hash.auth',
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
>                  'fatload host 0:1 4000000 db.auth',
> @@ -161,6 +165,7 @@ class TestEfiSignedImage(object):
>              # is verified
>              output =3D u_boot_console.run_command_list([
>                  'host bind 0 %s' % disk_img,
> +                'setenv -e -nv -bs -rt BootOrder',
>                  'fatload host 0:1 4000000 db.auth',
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
>                  'fatload host 0:1 4000000 KEK.auth',
> @@ -217,6 +222,7 @@ class TestEfiSignedImage(object):
>              # is verified. Same as before but reject dbx_hash1.auth only
>              output =3D u_boot_console.run_command_list([
>                  'host bind 0 %s' % disk_img,
> +                'setenv -e -nv -bs -rt BootOrder',
>                  'fatload host 0:1 4000000 db.auth',
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
>                  'fatload host 0:1 4000000 KEK.auth',
> @@ -294,6 +300,7 @@ class TestEfiSignedImage(object):
>          with u_boot_console.log.section('Test Case 7a'):
>              output =3D u_boot_console.run_command_list([
>                  'host bind 0 %s' % disk_img,
> +                'setenv -e -nv -bs -rt BootOrder',
>                  'fatload host 0:1 4000000 db.auth',
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
>                  'fatload host 0:1 4000000 KEK.auth',
> @@ -317,6 +324,7 @@ class TestEfiSignedImage(object):
>          with u_boot_console.log.section('Test Case 7b'):
>              output =3D u_boot_console.run_command_list([
>                  'host bind 0 %s' % disk_img,
> +                'setenv -e -nv -bs -rt BootOrder',
>                  'fatload host 0:1 4000000 db.auth',
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
>                  'fatload host 0:1 4000000 KEK.auth',
> @@ -348,6 +356,7 @@ class TestEfiSignedImage(object):
>              # Test Case 8a, Secure boot is not yet forced
>              output =3D u_boot_console.run_command_list([
>                  'host bind 0 %s' % disk_img,
> +                'setenv -e -nv -bs -rt BootOrder',
>                  'efidebug boot add -b 1 HELLO1 host 0:1 /helloworld_forg=
ed.efi.signed -s ""',
>                  'efidebug boot next 1',
>                  'efidebug test bootmgr'])
> diff --git a/test/py/tests/test_efi_secboot/test_signed_intca.py b/test/p=
y/tests/test_efi_secboot/test_signed_intca.py
> index d8d599d22f..318715fa08 100644
> --- a/test/py/tests/test_efi_secboot/test_signed_intca.py
> +++ b/test/py/tests/test_efi_secboot/test_signed_intca.py
> @@ -30,6 +30,7 @@ class TestEfiSignedImageIntca(object):
>              # Test Case 1a, with no Int CA and not authenticated by root=
 CA
>              output =3D u_boot_console.run_command_list([
>                  'host bind 0 %s' % disk_img,
> +                'setenv -e -nv -bs -rt BootOrder',
>                  'fatload host 0:1 4000000 db_c.auth',
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
>                  'fatload host 0:1 4000000 KEK.auth',
> @@ -63,6 +64,7 @@ class TestEfiSignedImageIntca(object):
>              # Test Case 2a, unsigned and not authenticated by root CA
>              output =3D u_boot_console.run_command_list([
>                  'host bind 0 %s' % disk_img,
> +                'setenv -e -nv -bs -rt BootOrder',
>                  'fatload host 0:1 4000000 KEK.auth',
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
>                  'fatload host 0:1 4000000 PK.auth',
> @@ -105,6 +107,7 @@ class TestEfiSignedImageIntca(object):
>              # Test Case 3a, revoked by int CA in dbx
>              output =3D u_boot_console.run_command_list([
>                  'host bind 0 %s' % disk_img,
> +                'setenv -e -nv -bs -rt BootOrder',
>                  'fatload host 0:1 4000000 dbx_b.auth',
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
>                  'fatload host 0:1 4000000 db_c.auth',
> diff --git a/test/py/tests/test_efi_secboot/test_unsigned.py b/test/py/te=
sts/test_efi_secboot/test_unsigned.py
> index df63f0df08..9042a46ccc 100644
> --- a/test/py/tests/test_efi_secboot/test_unsigned.py
> +++ b/test/py/tests/test_efi_secboot/test_unsigned.py
> @@ -28,6 +28,7 @@ class TestEfiUnsignedImage(object):
>              # Test Case 1
>              output =3D u_boot_console.run_command_list([
>                  'host bind 0 %s' % disk_img,
> +                'setenv -e -nv -bs -rt BootOrder',
>                  'fatload host 0:1 4000000 KEK.auth',
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
>                  'fatload host 0:1 4000000 PK.auth',
> @@ -55,6 +56,7 @@ class TestEfiUnsignedImage(object):
>              # Test Case 2
>              output =3D u_boot_console.run_command_list([
>                  'host bind 0 %s' % disk_img,
> +                'setenv -e -nv -bs -rt BootOrder',
>                  'fatload host 0:1 4000000 db_hello.auth',
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
>                  'fatload host 0:1 4000000 KEK.auth',
> @@ -79,6 +81,7 @@ class TestEfiUnsignedImage(object):
>              # Test Case 3a, rejected by dbx
>              output =3D u_boot_console.run_command_list([
>                  'host bind 0 %s' % disk_img,
> +                'setenv -e -nv -bs -rt BootOrder',
>                  'fatload host 0:1 4000000 db_hello.auth',
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
>                  'fatload host 0:1 4000000 KEK.auth',
> --
> 2.34.1
>
