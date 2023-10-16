Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA40CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 07:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9915868C0;
	Mon, 16 Oct 2023 09:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dTL7/48y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBE22868C0; Mon, 16 Oct 2023 09:58:34 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51DFA863FD
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 09:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9ae2cc4d17eso677402666b.1
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 00:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697443110; x=1698047910; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X44TAZoVh1F5v8xGPlLO6IS59BL7Hcrx62soj36CGxk=;
 b=dTL7/48yXCVUWsc+4DuGRgxYVQawzm0S6W/Ms+6j5IdRDtl1ZT0/cnp9AzRG0xqobt
 mqx/sz0E4wY8Fada4pPmpO4foOlgBPJaDHON3q7L8I0pFPSs0wESWh+AwvR/Fc5Hkh8/
 D1OdX/mND39JuDH3QddZoF8dCKFvfHnyNM8t1UBQu7HLG80x12mdA9AVAwkGjZNmM4GL
 zYiW5TUL1gbZX0m/yFq1hC+LHJ0FJkAvQ6a5QJjSOOqfLLbIrjVzuriW0cXR0f6TII2K
 0D8FihXE2//fDViDj1Nz2qDvVkau6VOln4hPeGFHr55APGumpyj4T8uvsqQml0gugaam
 PCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697443110; x=1698047910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X44TAZoVh1F5v8xGPlLO6IS59BL7Hcrx62soj36CGxk=;
 b=spDxFlb4N+TrU8aTudbtAwfKSBFiTVoYp9y259/MQMXWNLQSTAsGgHd9WGOjAi5hKT
 E9k6OW+biRxcBsUfF3xQ4Wmvi+rapRe37UtLUpextPLAXiFfG0xm/B9yMZViZf+3MMcx
 KoS2VsABi+YGPsBSzzDbX0bo3PSiuhUzC1mNONoI46cPiOenHQol9IHj58V2y1Qu/WjS
 wGqBCzX5g8Yb69fTwNlHN98UQvv6ITvBUTCbxeTzDlcdzhfcg357t8JyWU35TWJH6yzz
 B7NYqS8V/BZ5pWMWz8sbiGycSb3PXUXF/99Rt10COdQf2fbCoPfi+0LtF724ZeQj2TlQ
 BoQQ==
X-Gm-Message-State: AOJu0YyRExs0pKVL7Vuvwtl+eVqY+SrXsRK8HmOdD4MXpZQV8yg7CnPu
 rqhsIb6+6PRxkyQV2iTYuoO40rfpSNZnRRCYpVM=
X-Google-Smtp-Source: AGHT+IGtsGF/v6Z3iW/06WmgLAAFLxyaUuVd5ffib85RMwGOYYDELZhtKQZxQyehCDk+vTkvRcNIrqUE6j/rvFa+hC0=
X-Received: by 2002:a17:906:308c:b0:9ae:829e:d930 with SMTP id
 12-20020a170906308c00b009ae829ed930mr30274695ejv.9.1697443109226; Mon, 16 Oct
 2023 00:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
 <20231016064526.2410856-8-masahisa.kojima@linaro.org>
In-Reply-To: <20231016064526.2410856-8-masahisa.kojima@linaro.org>
From: =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <jmcosta944@gmail.com>
Date: Mon, 16 Oct 2023 09:58:17 +0200
Message-ID: <CABfBAmBOSLp4VAfTepU8n63MjXcVMWzzNtPv4309UhZgfVN4zA@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] Boot var automatic management for removable medias
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello,

Em seg., 16 de out. de 2023 =C3=A0s 08:47, Masahisa Kojima <
masahisa.kojima@linaro.org> escreveu:

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
> automatically added when the disk is detected. The original
> efi_secboot tests end up with unexpected failure.
> The efi_secboot tests need to be modified to explicitly set
> the BootOrder EFI variable.
>
> squashfs ls test is also affected by this modification, need to
> clear the previous state before squashfs ls test starts.
>
> Co-developed-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/efi_loader/efi_disk.c                     | 18 ++++++++
>  lib/efi_loader/efi_setup.c                    |  7 ++++
>  test/py/tests/test_efi_secboot/test_signed.py | 42 +++++++++----------
>  .../test_efi_secboot/test_signed_intca.py     | 14 +++----
>  .../tests/test_efi_secboot/test_unsigned.py   | 14 +++----
>  .../test_fs/test_squashfs/test_sqfs_ls.py     |  6 +++
>  6 files changed, 66 insertions(+), 35 deletions(-)
>
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index f0d76113b0..b808a7fe62 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -690,6 +690,13 @@ int efi_disk_probe(void *ctx, struct event *event)
>                         return -1;
>         }
>
> +       /* only do the boot option management when UEFI sub-system is
> initialized */
> +       if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) &&
> efi_obj_list_initialized =3D=3D EFI_SUCCESS) {
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
> +        * In case of scenario a),
> efi_bootmgr_update_media_device_boot_option()
> +        * needs to be invoked here to update the boot options and remove
> the
> +        * unnecessary ones.
> +        */
> +
>  }
>
>  /**
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index e6de685e87..37359a77bb 100644
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
> diff --git a/test/py/tests/test_efi_secboot/test_signed.py
> b/test/py/tests/test_efi_secboot/test_signed.py
> index ca52e853d8..2f862a259a 100644
> --- a/test/py/tests/test_efi_secboot/test_signed.py
> +++ b/test/py/tests/test_efi_secboot/test_signed.py
> @@ -29,7 +29,7 @@ class TestEfiSignedImage(object):
>              output =3D u_boot_console.run_command_list([
>                  'host bind 0 %s' % disk_img,
>                  'efidebug boot add -b 1 HELLO1 host 0:1
> /helloworld.efi.signed -s ""',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'bootefi bootmgr'])
>              assert 'Hello, world!' in ''.join(output)
>
> @@ -37,7 +37,7 @@ class TestEfiSignedImage(object):
>              # Test Case 1b, run unsigned image if no PK
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 2 HELLO2 host 0:1 /helloworld.efi
> -s ""',
> -                'efidebug boot next 2',
> +                'efidebug boot order 2',
>                  'bootefi bootmgr'])
>              assert 'Hello, world!' in ''.join(output)
>
> @@ -59,13 +59,13 @@ class TestEfiSignedImage(object):
>              assert 'Failed to set EFI variable' not in ''.join(output)
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 1 HELLO1 host 0:1
> /helloworld.efi.signed -s ""',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert('\'HELLO1\' failed' in ''.join(output))
>              assert('efi_start_image() returned: 26' in ''.join(output))
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 2 HELLO2 host 0:1 /helloworld.efi
> -s ""',
> -                'efidebug boot next 2',
> +                'efidebug boot order 2',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO2\' failed' in ''.join(output)
>              assert 'efi_start_image() returned: 26' in ''.join(output)
> @@ -77,12 +77,12 @@ class TestEfiSignedImage(object):
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize db'])
>              assert 'Failed to set EFI variable' not in ''.join(output)
>              output =3D u_boot_console.run_command_list([
> -                'efidebug boot next 2',
> +                'efidebug boot order 2',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO2\' failed' in ''.join(output)
>              assert 'efi_start_image() returned: 26' in ''.join(output)
>              output =3D u_boot_console.run_command_list([
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'bootefi bootmgr'])
>              assert 'Hello, world!' in ''.join(output)
>
> @@ -105,7 +105,7 @@ class TestEfiSignedImage(object):
>              assert 'Failed to set EFI variable' not in ''.join(output)
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 1 HELLO host 0:1
> /helloworld.efi.signed -s ""',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
>              assert 'efi_start_image() returned: 26' in ''.join(output)
> @@ -117,7 +117,7 @@ class TestEfiSignedImage(object):
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize db'])
>              assert 'Failed to set EFI variable' not in ''.join(output)
>              output =3D u_boot_console.run_command_list([
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
>              assert 'efi_start_image() returned: 26' in ''.join(output)
> @@ -143,7 +143,7 @@ class TestEfiSignedImage(object):
>              assert 'Failed to set EFI variable' not in ''.join(output)
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 1 HELLO host 0:1
> /helloworld.efi.signed -s ""',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
>              assert 'efi_start_image() returned: 26' in ''.join(output)
> @@ -170,7 +170,7 @@ class TestEfiSignedImage(object):
>              assert 'Failed to set EFI variable' not in ''.join(output)
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 1 HELLO host 0:1
> /helloworld.efi.signed_2sigs -s ""',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert 'Hello, world!' in ''.join(output)
>
> @@ -181,7 +181,7 @@ class TestEfiSignedImage(object):
>                  'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db'])
>              assert 'Failed to set EFI variable' not in ''.join(output)
>              output =3D u_boot_console.run_command_list([
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert 'Hello, world!' in ''.join(output)
>
> @@ -193,7 +193,7 @@ class TestEfiSignedImage(object):
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
>              assert 'Failed to set EFI variable' not in ''.join(output)
>              output =3D u_boot_console.run_command_list([
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
>              assert 'efi_start_image() returned: 26' in ''.join(output)
> @@ -205,7 +205,7 @@ class TestEfiSignedImage(object):
>                  'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize dbx']=
)
>              assert 'Failed to set EFI variable' not in ''.join(output)
>              output =3D u_boot_console.run_command_list([
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
>              assert 'efi_start_image() returned: 26' in ''.join(output)
> @@ -230,7 +230,7 @@ class TestEfiSignedImage(object):
>              assert 'Failed to set EFI variable' not in ''.join(output)
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 1 HELLO host 0:1
> /helloworld.efi.signed_2sigs -s ""',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
>              assert 'efi_start_image() returned: 26' in ''.join(output)
> @@ -254,7 +254,7 @@ class TestEfiSignedImage(object):
>              assert 'Failed to set EFI variable' not in ''.join(output)
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 1 HELLO host 0:1
> /helloworld.efi.signed -s ""',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'bootefi bootmgr'])
>              assert 'Hello, world!' in ''.join(output)
>
> @@ -265,7 +265,7 @@ class TestEfiSignedImage(object):
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
>              assert 'Failed to set EFI variable' not in ''.join(output)
>              output =3D u_boot_console.run_command_list([
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
>              assert 'efi_start_image() returned: 26' in ''.join(output)
> @@ -279,7 +279,7 @@ class TestEfiSignedImage(object):
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
>              assert 'Failed to set EFI variable' not in ''.join(output)
>              output =3D u_boot_console.run_command_list([
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
>              assert 'efi_start_image() returned: 26' in ''.join(output)
> @@ -307,7 +307,7 @@ class TestEfiSignedImage(object):
>              assert 'Failed to set EFI variable' not in ''.join(output)
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 1 HELLO host 0:1
> /helloworld.efi.signed_2sigs -s ""',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
>              assert 'efi_start_image() returned: 26' in ''.join(output)
> @@ -330,7 +330,7 @@ class TestEfiSignedImage(object):
>              assert 'Failed to set EFI variable' not in ''.join(output)
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 1 HELLO host 0:1
> /helloworld.efi.signed_2sigs -s ""',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
>              assert 'efi_start_image() returned: 26' in ''.join(output)
> @@ -349,7 +349,7 @@ class TestEfiSignedImage(object):
>              output =3D u_boot_console.run_command_list([
>                  'host bind 0 %s' % disk_img,
>                  'efidebug boot add -b 1 HELLO1 host 0:1
> /helloworld_forged.efi.signed -s ""',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert('hELLO, world!' in ''.join(output))
>
> @@ -364,7 +364,7 @@ class TestEfiSignedImage(object):
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
>              assert 'Failed to set EFI variable' not in ''.join(output)
>              output =3D u_boot_console.run_command_list([
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert(not 'hELLO, world!' in ''.join(output))
>              assert('\'HELLO1\' failed' in ''.join(output))
> diff --git a/test/py/tests/test_efi_secboot/test_signed_intca.py
> b/test/py/tests/test_efi_secboot/test_signed_intca.py
> index d8d599d22f..8d9a5f3e7f 100644
> --- a/test/py/tests/test_efi_secboot/test_signed_intca.py
> +++ b/test/py/tests/test_efi_secboot/test_signed_intca.py
> @@ -40,7 +40,7 @@ class TestEfiSignedImageIntca(object):
>
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 1 HELLO_a host 0:1
> /helloworld.efi.signed_a -s ""',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO_a\' failed' in ''.join(output)
>              assert 'efi_start_image() returned: 26' in ''.join(output)
> @@ -49,7 +49,7 @@ class TestEfiSignedImageIntca(object):
>              # Test Case 1b, signed and authenticated by root CA
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 2 HELLO_ab host 0:1
> /helloworld.efi.signed_ab -s ""',
> -                'efidebug boot next 2',
> +                'efidebug boot order 2',
>                  'bootefi bootmgr'])
>              assert 'Hello, world!' in ''.join(output)
>
> @@ -71,7 +71,7 @@ class TestEfiSignedImageIntca(object):
>
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 1 HELLO_abc host 0:1
> /helloworld.efi.signed_abc -s ""',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO_abc\' failed' in ''.join(output)
>              assert 'efi_start_image() returned: 26' in ''.join(output)
> @@ -81,7 +81,7 @@ class TestEfiSignedImageIntca(object):
>              output =3D u_boot_console.run_command_list([
>                  'fatload host 0:1 4000000 db_b.auth',
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO_abc\' failed' in ''.join(output)
>              assert 'efi_start_image() returned: 26' in ''.join(output)
> @@ -91,7 +91,7 @@ class TestEfiSignedImageIntca(object):
>              output =3D u_boot_console.run_command_list([
>                  'fatload host 0:1 4000000 db_c.auth',
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert 'Hello, world!' in ''.join(output)
>
> @@ -117,7 +117,7 @@ class TestEfiSignedImageIntca(object):
>
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 1 HELLO_abc host 0:1
> /helloworld.efi.signed_abc -s ""',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert 'Hello, world!' in ''.join(output)
>              # Or,
> @@ -129,7 +129,7 @@ class TestEfiSignedImageIntca(object):
>              output =3D u_boot_console.run_command_list([
>                  'fatload host 0:1 4000000 dbx_c.auth',
>                  'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO_abc\' failed' in ''.join(output)
>              assert 'efi_start_image() returned: 26' in ''.join(output)
> diff --git a/test/py/tests/test_efi_secboot/test_unsigned.py
> b/test/py/tests/test_efi_secboot/test_unsigned.py
> index df63f0df08..7c078f220d 100644
> --- a/test/py/tests/test_efi_secboot/test_unsigned.py
> +++ b/test/py/tests/test_efi_secboot/test_unsigned.py
> @@ -36,11 +36,11 @@ class TestEfiUnsignedImage(object):
>
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi -=
s
> ""',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'bootefi bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
>              output =3D u_boot_console.run_command_list([
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert 'efi_start_image() returned: 26' in ''.join(output)
>              assert 'Hello, world!' not in ''.join(output)
> @@ -65,7 +65,7 @@ class TestEfiUnsignedImage(object):
>
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi -=
s
> ""',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'bootefi bootmgr'])
>              assert 'Hello, world!' in ''.join(output)
>
> @@ -89,11 +89,11 @@ class TestEfiUnsignedImage(object):
>
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi -=
s
> ""',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'bootefi bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
>              output =3D u_boot_console.run_command_list([
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert 'efi_start_image() returned: 26' in ''.join(output)
>              assert 'Hello, world!' not in ''.join(output)
> @@ -107,11 +107,11 @@ class TestEfiUnsignedImage(object):
>
>              output =3D u_boot_console.run_command_list([
>                  'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi -=
s
> ""',
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'bootefi bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
>              output =3D u_boot_console.run_command_list([
> -                'efidebug boot next 1',
> +                'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert 'efi_start_image() returned: 26' in ''.join(output)
>              assert 'Hello, world!' not in ''.join(output)
> diff --git a/test/py/tests/test_fs/test_squashfs/test_sqfs_ls.py
> b/test/py/tests/test_fs/test_squashfs/test_sqfs_ls.py
> index 527a556ed8..3b8118104f 100644
> --- a/test/py/tests/test_fs/test_squashfs/test_sqfs_ls.py
> +++ b/test/py/tests/test_fs/test_squashfs/test_sqfs_ls.py
> @@ -118,6 +118,12 @@ def test_sqfs_ls(u_boot_console):
>      """
>      build_dir =3D u_boot_console.config.build_dir
>
> +    # If the EFI subsystem is enabled, default file(e.g.
> EFI/BOOT/BOOTAA64.EFI)
> +    # is scanned when the new disk is detected. This ends up with the
> unexpected
> +    # output at the first 'sqfsls' command.
> +    # Clear the previous state.
> +    u_boot_console.restart_uboot()
> +
>      # setup test environment
>      check_mksquashfs_version()
>      generate_sqfs_src_dir(build_dir)
> --
> 2.34.1
>
>
Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>

--=20
Best regards,
Jo=C3=A3o Marcos Costa

www.linkedin.com/in/jmarcoscosta/
https://github.com/jmarcoscosta
