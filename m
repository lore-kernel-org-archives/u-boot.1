Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B611BC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29080811C1;
	Tue, 11 Mar 2025 14:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xy/mHC9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02FE48141D; Tue, 11 Mar 2025 14:46:02 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91BEB801BE
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 14:45:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e5dcc411189so5064650276.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741700758; x=1742305558; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rOnkG5MKe1VVL4V5l7yrf5JdcpOV7baJCv39HpwU40o=;
 b=xy/mHC9kJSCEjic9HHPEp5z0NGFfSWAZbKTzALUV023TdpIO7ySAxfY5/+1wgTNVAo
 DUWaufTT7J8VuIvhjEinOGxnzgE+Kkjk2/JOA+qWulp9+x4ATApn7L9PFtxPeBU0k/33
 O1rR+hKEvkOow2BEV7chyTbAkVmRB2gap3wBgwqdyp967wJuDTtOqIwRaFrkjmwMDpC7
 lZF3RRQzdYKIFmxsO4eR1urvPHIEnwnA2X4OEFOeb8kFvoBKWZS+WHp9lyGuKsunbwsR
 OQvME1LybuUXc1GM5QdoEcgXjkE6mBfdzyxfB3pKIBG/jV/CKxgHaPGY/7PMJ8FYqRoy
 WZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741700758; x=1742305558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rOnkG5MKe1VVL4V5l7yrf5JdcpOV7baJCv39HpwU40o=;
 b=qXoJpUzXKEpADtWMEBYgGADNc0IzqLzSF6nJqPvTdsgAs6B1oPNFnPITcqjTsCAq3u
 FmNRJTs3n8EUyrZLgaGtyAk71gcJvVrn2T71JC197deS084ZgHp119mQI+zqRsStwEWK
 CnLUg/ji7a4b91Lahm3+OW7cuUANYgbyLlGKLqG32nt4QjdIrNh1/C4wjPKjLPGFJ8nj
 Z/4FDWfskSKvfv8Fhxn2ZwfYOFHRCG1DQQWEqi/+MF0gSaTA62bSYiI6Il9OrPfSijtZ
 lZ/ZzDOo5xMBJTIzWo9kPajdkSmZMlGjatLb+E45oPcaeZeMnAhN6qHymdZbL6Fm4vWe
 s6ew==
X-Gm-Message-State: AOJu0YwVfu78QYB/snaktIyJx96XaBMiP7WIJqpOhJ3ryqT55+lP4SpA
 5d8Y29f1m7VeoEjHiOglea08U62TQYLufZa+tuvJ0NRMqP/yOZlLhK0qsJHG0+qu72jeH87HEiX
 xHJKpwwbmwmjsvNw/p/VL5nAPUsSl4/h1GeYpUBFN/171eRxJ8Bw=
X-Gm-Gg: ASbGnctNlkLTYrypFbPXEi+SLfxmOSqe6FEAp6F2k9HDtfy+ki3nuAjrqdxPQCLpmQj
 PMjgFe2TkHseeEC66mAmJ1Wk/U4Ws2NzKHmXny+Bbey6oI8Nx4r9nCtabS/WhsBtZwvqvv+GAlF
 WpjzQaeSaQlN/XPXTS3ghC5DZjVZ8=
X-Google-Smtp-Source: AGHT+IEJxPHrCYVJ/Z+c3jvabBxRtc1LT7a7K9u7LbPnOLSTnvhPJhWrUNFalLkYOZt2nDIXq0bZJzkdfUnt0K11a/o=
X-Received: by 2002:a05:6902:340c:b0:e5d:d9f6:d804 with SMTP id
 3f1490d57ef6-e635c1e35d2mr17523572276.38.1741700758277; Tue, 11 Mar 2025
 06:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250306232256.4150882-1-trini@konsulko.com>
 <20250306232256.4150882-7-trini@konsulko.com>
In-Reply-To: <20250306232256.4150882-7-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Mar 2025 15:45:22 +0200
X-Gm-Features: AQ5f1Jrh_rPSWjDkE1_3hv_soDeh-qxRnNlIeLSa5uGHePVMc5agruuoz8wMSxU
Message-ID: <CAC_iWjKTF056xAKbGHLteBGFkc-+M+Jaj+fY0f20da2BdR7Vvw@mail.gmail.com>
Subject: Re: [PATCH 06/10] test/py: Rework test_eficonfig to not use
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

Hi Tom,

I've never really looked at our fs helper functions but this looks reasonable

On Fri, 7 Mar 2025 at 01:23, Tom Rini <trini@konsulko.com> wrote:
>
> The problem with using "virt-make-fs" to make a filesystem image is that
> it is extremely slow. Switch to using the fs_helper functions we have
> instead from the filesystem tests as these can add files to images and
> are significantly faster and still do not require root access.
>
> As this test already had a number of internal functions, add a
> prepare_image function to do this part of the test.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> I noted to Heinrich in private that this test is currently disabled. I
> re-enabled it locally to verify that the disk image is created correctly
> still.
>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  .../{test_eficonfig => }/test_eficonfig.py    | 53 ++++++++++++++++---
>  test/py/tests/test_eficonfig/conftest.py      | 40 --------------
>  2 files changed, 46 insertions(+), 47 deletions(-)
>  rename test/py/tests/{test_eficonfig => }/test_eficonfig.py (89%)
>  delete mode 100644 test/py/tests/test_eficonfig/conftest.py
>
> diff --git a/test/py/tests/test_eficonfig/test_eficonfig.py b/test/py/tests/test_eficonfig.py
> similarity index 89%
> rename from test/py/tests/test_eficonfig/test_eficonfig.py
> rename to test/py/tests/test_eficonfig.py
> index d98de5249dfd..caccd1f42190 100644
> --- a/test/py/tests/test_eficonfig/test_eficonfig.py
> +++ b/test/py/tests/test_eficonfig.py
> @@ -2,13 +2,57 @@
>  """ Unit test for UEFI menu-driven configuration
>  """
>
> +import pytest
> +import shutil
>  import pytest
>  import time
> +from subprocess import call, check_call, CalledProcessError
> +from tests import fs_helper
>
>  @pytest.mark.boardspec('sandbox')
>  @pytest.mark.buildconfigspec('cmd_eficonfig')
>  @pytest.mark.buildconfigspec('cmd_bootefi_bootmgr')
> -def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
> +def test_efi_eficonfig(u_boot_console):
> +
> +    def prepare_image(u_boot_config):
> +        """Set up a file system to be used in UEFI "eficonfig" command
> +           tests. This creates a disk image with the following files:
> +                 initrd-1.img
> +                 initrd-2.img
> +                 initrddump.efi
> +
> +        Args:
> +            u_boot_config -- U-Boot configuration.
> +
> +        Return:
> +            A path to disk image to be used for testing
> +
> +        """
> +        try:
> +            image_path, mnt_point = fs_helper.setup_image(u_boot_config, 0,
> +                                                          0xc,
> +                                                          basename='test_eficonfig')
> +
> +            with open(mnt_point + '/initrd-1.img', 'w', encoding = 'ascii') as file:
> +                file.write("initrd 1")
> +
> +            with open(mnt_point + '/initrd-2.img', 'w', encoding = 'ascii') as file:
> +                file.write("initrd 2")
> +
> +            shutil.copyfile(u_boot_config.build_dir + '/lib/efi_loader/initrddump.efi',
> +                            mnt_point + '/initrddump.efi')
> +
> +            fsfile = fs_helper.mk_fs(u_boot_console.config, 'vfat', 0x100000,
> +                                     'test_eficonfig', mnt_point)
> +            check_call(f'dd if={fsfile} of={image_path} bs=1M seek=1', shell=True)
> +
> +            yield image_path
> +        except CalledProcessError as err:
> +            pytest.skip('Preparing test_eficonfig image failed')
> +            call('rm -f %s' % image_path, shell=True)
> +        finally:
> +            call('rm -rf %s' % mnt_point, shell=True)
> +            call('rm -f %s' % image_path, shell=True)
>
>      def send_user_input_and_wait(user_str, expect_str):
>          time.sleep(0.1) # TODO: does not work correctly without sleep
> @@ -57,12 +101,6 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
>
>      Args:
>          u_boot_console -- U-Boot console
> -        efi__data -- Path to the disk image used for testing.
> -                     Test disk image has following files.
> -                         initrd-1.img
> -                         initrd-2.img
> -                         initrddump.efi
> -
>      """
>      # This test passes for unknown reasons in the bowels of U-Boot. It needs to
>      # be replaced with a unit test.
> @@ -71,6 +109,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
>      # Restart the system to clean the previous state
>      u_boot_console.restart_uboot()
>
> +    efi_eficonfig_data = prepare_image(u_boot_console.config)
>      with u_boot_console.temporary_timeout(500):
>          #
>          # Test Case 1: Check the menu is displayed
> diff --git a/test/py/tests/test_eficonfig/conftest.py b/test/py/tests/test_eficonfig/conftest.py
> deleted file mode 100644
> index 0a82fbefd752..000000000000
> --- a/test/py/tests/test_eficonfig/conftest.py
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -# SPDX-License-Identifier:      GPL-2.0+
> -
> -"""Fixture for UEFI eficonfig test
> -"""
> -
> -import os
> -import shutil
> -from subprocess import check_call
> -import pytest
> -
> -@pytest.fixture(scope='session')
> -def efi_eficonfig_data(u_boot_config):
> -    """Set up a file system to be used in UEFI "eficonfig" command
> -       tests
> -
> -    Args:
> -        u_boot_config -- U-Boot configuration.
> -
> -    Return:
> -        A path to disk image to be used for testing
> -    """
> -    mnt_point = u_boot_config.persistent_data_dir + '/test_efi_eficonfig'
> -    image_path = u_boot_config.persistent_data_dir + '/efi_eficonfig.img'
> -
> -    shutil.rmtree(mnt_point, ignore_errors=True)
> -    os.mkdir(mnt_point, mode = 0o755)
> -
> -    with open(mnt_point + '/initrd-1.img', 'w', encoding = 'ascii') as file:
> -        file.write("initrd 1")
> -
> -    with open(mnt_point + '/initrd-2.img', 'w', encoding = 'ascii') as file:
> -        file.write("initrd 2")
> -
> -    shutil.copyfile(u_boot_config.build_dir + '/lib/efi_loader/initrddump.efi',
> -                    mnt_point + '/initrddump.efi')
> -
> -    check_call(f'virt-make-fs --partition=gpt --size=+1M --type=vfat {mnt_point} {image_path}',
> -               shell=True)
> -
> -    return image_path
> --
> 2.43.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
