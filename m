Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51475E7E65D
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 18:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CA1386B93;
	Tue, 26 Sep 2023 20:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RGunJ6Kq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00F4C86B95; Tue, 26 Sep 2023 20:52:03 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C81BB86B76
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 20:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50437f39c9dso12975209e87.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695754320; x=1696359120; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7UPGhsYQ3veNfZHRAE2/j34To6qr7qb7SuSOTdAOnO4=;
 b=RGunJ6Kqo/scwdiCk+86R8wd6gKHAJSC2cNsrXb39vnnXNjtCYBLTt8e/NzIFYrIz3
 Ekk95PVSzEUkBhX1YTerwVF0yljB54JlcpXugbYd9tzmC7rguA6bMMqpcQDVcdvLZTtH
 hw0qUSvcKwu2QB/TrhoI8s/YUgPG4LkJw4nAVmpGJw7e7sQI8AKtyp01DbkOhyjnJffM
 B61+MnrBgIQukLjtVqAVoxhwTa5A1Ti9nj7+QrgDUASAPfnRLExKsu/yzeey53On8H84
 v9WZCYk07TO5ZTqhElRKe4wMq6faRBu7V64Fp6ORK8PzfxvYVu5r9sTiOvQpaFwC3g8R
 I6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695754320; x=1696359120;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7UPGhsYQ3veNfZHRAE2/j34To6qr7qb7SuSOTdAOnO4=;
 b=okdk8acplCpNp3G93rVXsVolqZ8zsCsdoVOD9ClXnLI7zGV2NFMcpURp4vuXDJ2C8N
 peneJNLTHRCf69fEf0SdEpuLKwWqeY0hJNLIpeD4tyBzeaotDoKfBHe0Z4Lb1Qh16DnY
 /QGV9lQzy8Oug4oxwNIxeF4aFGOUtXtu/WtUYebjIHSqJ93GfJAZdb2YWmW6TlAtEHJG
 xQDPZTKKj+O4NxguYLAooAMW6adRTHZa4KkbX8ARI3fnYYD6zQOI1Ulf5gP9eOgBqIXm
 IurY7jM/eaXTA5K+sf5kZnOcFH+TMgOFAs58vL8ow3z5XiDtU7qGCnLPz6c1hf7ZueQ0
 Hvbg==
X-Gm-Message-State: AOJu0YzOfd61VmIg5ji1bM3tUZ/YRTUFJIPbDjwXE85hUJV61w9YcjNV
 +xwDqZgEeBIzSQAKoR/WYm2gxq6MPkM1e+aAa1iVQg==
X-Google-Smtp-Source: AGHT+IHaEe1FirhbrCLL3JOF5RR8EvyltcCwc55EoxmDVEIhEFFZiUvBye5In7kcoamTwZF9be/HPB268wQ14beyjjw=
X-Received: by 2002:a05:6512:2103:b0:503:26bc:b08f with SMTP id
 q3-20020a056512210300b0050326bcb08fmr8043814lfr.24.1695754319951; Tue, 26 Sep
 2023 11:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230920084121.1248590-1-masahisa.kojima@linaro.org>
In-Reply-To: <20230920084121.1248590-1-masahisa.kojima@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 26 Sep 2023 21:51:23 +0300
Message-ID: <CAC_iWjLsF1hK=aroC9+GfY0_3hQVwKScYJzprH6jcNTbsxw4rQ@mail.gmail.com>
Subject: Re: [PATCH v11] Boot var automatic management for removable medias
To: Masahisa Kojima <masahisa.kojima@linaro.org>
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

On Wed, 20 Sept 2023 at 11:41, Masahisa Kojima
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
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
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
>
> base-commit: 8bd7d08407f986fe3c69f3e198f6f7152e12dea8
> --
> 2.34.1
>

I think you should add your co-developped-by tag now since you fixed
the CI issues,

With that
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
