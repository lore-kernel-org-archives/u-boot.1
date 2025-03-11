Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4363AC28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CACE0811C1;
	Tue, 11 Mar 2025 14:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PDUJkI6l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E34F281671; Tue, 11 Mar 2025 14:46:42 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0F80801BE
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 14:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e5dc299deb4so4805609276.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741700799; x=1742305599; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w37r5xnubh9EXZqr32mAHKXJPCFF5D2XPeYIF/R3hpI=;
 b=PDUJkI6l6/EY8B5uIdU3htY8fMkHfJgtin5d8sfMxdPF2z92/QxNpIww8iDyo1fKi9
 B7vPhxMET8FhADdYjo0KfndaQJmMk7pIRuyYq3/YUWSKxjRxYbVbkSNZSQ6EEC8N8g12
 mobg7vO6MDJyGrA4ER41zeoOOwhyNpwdyXM7kHMEp3qsklbnW3FRvn5G/elHxVqP0nRY
 Q3Y6jn+h7Hu89a9YObZQvwyBHHdXv16cPAqNRIfnlek/4Gh9Qk8qQ4JV9V7loI2QPA2H
 GrlUb3tgHqKX9mP+EISLFQ9TLOOejjfWQt5B7MniKo/uVI6y4+EbkY3IkAsxReewUD9I
 lHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741700799; x=1742305599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w37r5xnubh9EXZqr32mAHKXJPCFF5D2XPeYIF/R3hpI=;
 b=LUqx3K/q5oUzVVBaXUZ594v5IcdyahdOzQ9gd8EdsGextIYOvjNSsED8XQPvj2Pbl4
 4t86vDDibbX4jCx7kurt5mOEi5eFVh9JZbqbU2mvzLLjJ3hI/z+9GK3QpvqiDAN3XOr9
 bomGVpgc2BGjXIS4u+blY0NZ94rDxRiVx5bfuorkKSTPwv8ynnFqXwFQw2kUbniwrFfO
 +WZm1zLp0Fsu3EW/XvNZXF/qHoVlIkk3qnZaXq5KgFIZV+MqUf+DE+GjggCJAzIzdadG
 ZrM2Pb+9g5nJZlhDUGwGznBkRZywrIAg3NC9ef23Jh0HuwM6EAkFCC920nPe5yt4f0me
 NguQ==
X-Gm-Message-State: AOJu0YyMPvRMdS7vDlPEZ5HtGdUHVf8zcVsw0yatE7K5sJfR4Vh94+NP
 V1NS5orpfVD2ENGqXFXvaMuu461UhM2XtAkMmjgMb5m1ECpJAEPMV8L21WCAWQLn9f39+GpcrGz
 s/17GyduwyKU8h5WQUiw67I+9cz4IDyLkepvkFg==
X-Gm-Gg: ASbGncvx5K9ewpDKby0WPJMF6/mi3cipOPSl72uJdl5S/vAldUfzmIrojoFyXdDq76l
 5DKNAf+ePQv5kcckA6fEFDlsynUZ7N6J0Z5g+1sXApHItCntzL6Aj+R8cL+1eJA0I2qd85GCj8z
 jbTYCMJyMTsl2fi3CgXU07lRVB7aI=
X-Google-Smtp-Source: AGHT+IGM+CZPLm9vnjIoDxr2EjGtVu1cv1HNEjbid8fm4AElSgfIBimw8geaDKqjYvAF1zsLdo2iLAwMESvrRjqMWos=
X-Received: by 2002:a05:6902:310b:b0:e5b:4482:a4f7 with SMTP id
 3f1490d57ef6-e635c1382fdmr21959516276.12.1741700799492; Tue, 11 Mar 2025
 06:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250306232256.4150882-1-trini@konsulko.com>
 <20250306232256.4150882-8-trini@konsulko.com>
In-Reply-To: <20250306232256.4150882-8-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Mar 2025 15:46:03 +0200
X-Gm-Features: AQ5f1JqxSJZkIr-lK912gURi5I3LnkygDcNf79kzli-wXKCZrs6RGxNwx2Pt2hk
Message-ID: <CAC_iWjJd5582MP2K9keQ0wXsG1TBF5B7ZgunXhQ+8cPWWC9Byg@mail.gmail.com>
Subject: Re: [PATCH 07/10] test/py: Rework test_efi_capsule to not use
 virt-make-fs
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 7 Mar 2025 at 01:23, Tom Rini <trini@konsulko.com> wrote:
>
> The problem with using "virt-make-fs" to make a filesystem image is that
> it is extremely slow. Switch to using the fs_helper functions we have
> instead from the filesystem tests as these can add files to images and
> are significantly faster and still do not require root access.
>
> The main change here is that our mount point directory has changed from
> "test_efi_capsule" to "scratch" and so we need to update other functions
> too. As the disk image that we get created doesn't have a GPT, invoke
> sgdisk to do a conversion first.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> I tested this as much as I could with an empty
> board/sandbox/capsule_pub_esl_good.esl which did show me a few issues
> along the way so I am reasonably confident, but this really does need to
> be tested on a platform where all tests are run for real.
>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  .../tests/test_efi_capsule/capsule_common.py  |  2 +-
>  test/py/tests/test_efi_capsule/conftest.py    | 21 ++++++++++++-------
>  2 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/test/py/tests/test_efi_capsule/capsule_common.py b/test/py/tests/test_efi_capsule/capsule_common.py
> index fc0d851c619a..68b2e48bf5a5 100644
> --- a/test/py/tests/test_efi_capsule/capsule_common.py
> +++ b/test/py/tests/test_efi_capsule/capsule_common.py
> @@ -136,7 +136,7 @@ def do_reboot_dtb_specified(u_boot_config, u_boot_console, dtb_filename):
>          u_boot_console -- A console connection to U-Boot.
>          dtb_filename -- DTB file name.
>      """
> -    mnt_point = u_boot_config.persistent_data_dir + '/test_efi_capsule'
> +    mnt_point = u_boot_config.persistent_data_dir + '/scratch'
>      u_boot_console.config.dtb = mnt_point + CAPSULE_DATA_DIR \
>                                  + f'/{dtb_filename}'
>      u_boot_console.restart_uboot()
> diff --git a/test/py/tests/test_efi_capsule/conftest.py b/test/py/tests/test_efi_capsule/conftest.py
> index 61eab5112a17..7f8a3de46171 100644
> --- a/test/py/tests/test_efi_capsule/conftest.py
> +++ b/test/py/tests/test_efi_capsule/conftest.py
> @@ -7,6 +7,7 @@
>  import os
>
>  from subprocess import call, check_call, CalledProcessError
> +from tests import fs_helper
>  import pytest
>  from capsule_defs import CAPSULE_DATA_DIR, CAPSULE_INSTALL_DIR, EFITOOLS_PATH
>
> @@ -21,12 +22,12 @@ def efi_capsule_data(request, u_boot_config):
>      request -- Pytest request object.
>      u_boot_config -- U-Boot configuration.
>      """
> -    mnt_point = u_boot_config.persistent_data_dir + '/test_efi_capsule'
> -    data_dir = mnt_point + CAPSULE_DATA_DIR
> -    install_dir = mnt_point + CAPSULE_INSTALL_DIR
> -    image_path = u_boot_config.persistent_data_dir + '/test_efi_capsule.img'
> -
>      try:
> +        image_path, mnt_point = fs_helper.setup_image(u_boot_config, 0, 0xc,
> +                                                      basename='test_efi_capsule')
> +        data_dir = mnt_point + CAPSULE_DATA_DIR
> +        install_dir = mnt_point + CAPSULE_INSTALL_DIR
> +
>          # Create a target device
>          check_call('dd if=/dev/zero of=./spi.bin bs=1MiB count=16', shell=True)
>
> @@ -88,11 +89,15 @@ def efi_capsule_data(request, u_boot_config):
>          check_call('cp %s/Test* %s' % (u_boot_config.build_dir, data_dir), shell=True)
>          os.environ['PYTHONPATH'] = pythonpath
>
> -        # Create a disk image with EFI system partition
> -        check_call('virt-make-fs --partition=gpt --size=+1M --type=vfat %s %s' %
> -                   (mnt_point, image_path), shell=True)
> +        # Create a 16MiB partition as the EFI system partition in the disk
> +        # image
> +        fsfile = fs_helper.mk_fs(u_boot_config, 'vfat', 0x1000000,
> +                                 'test_efi_capsule', mnt_point)
> +        check_call(f'dd if={fsfile} of={image_path} bs=1M seek=1', shell=True)
> +        check_call('sgdisk --mbrtogpt %s' % image_path, shell=True)
>          check_call('sgdisk %s -A 1:set:0 -t 1:C12A7328-F81F-11D2-BA4B-00A0C93EC93B' %
>                     image_path, shell=True)
> +        call('rm -f %s' % fsfile, shell=True)
>
>      except CalledProcessError as exception:
>          pytest.skip('Setup failed: %s' % exception.cmd)
> --
> 2.43.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
