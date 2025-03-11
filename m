Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC50CC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7731381671;
	Tue, 11 Mar 2025 14:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I+gB/9TO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4CE5801BE; Tue, 11 Mar 2025 14:46:12 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0CD581898
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 14:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e5dc299dee9so4925512276.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 06:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741700768; x=1742305568; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MAcpZdqyWfie6AKsQ4nfrnFwFYCn6/3yd5d/Yfz3QY4=;
 b=I+gB/9TOMRNisGiEa4ZJQb2La7eV3DMKPzwlBCWT1E8oQR0xp7Gn2prdnvUoYFxY1F
 X3aCb051cxBJr7C+sJCCR1K3yA8NHgx5CgvHyS2RCReGEGXv9voUMaQWobxBaSn2HZGS
 WxLZpsva1jgHIAZQX6/WtJsIl4eKn38Tuw+OcdWlnL1ejEDenVarDNmwoIUUbIQNO4pl
 oxR+xmRbjyBnvrer2IBteo3vzhDuyGu14kgDENQxl1oaBpFKGHWl4iVjsTq0PYwJ6jVJ
 q08sYfOBN4SVvKAbZd0G6Owd3e4a2T3sm1sgB6gsQbknTULS/YONIqR8+DSFJQOnK4/t
 cc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741700768; x=1742305568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MAcpZdqyWfie6AKsQ4nfrnFwFYCn6/3yd5d/Yfz3QY4=;
 b=uW+nwXSfMP0J1oJLGupDDWHdy+e697qa/1fl2A366zkDiJg1M/ZbLae7dMnRMshfPS
 TYoL+6O1CwABbRyhdhvPb9Ea6B1aQSB0OcfazzCeuq+bji3gFwA+tNdhgxTgyVWQyKJc
 iRwOnDGkMbx8pZ5NLKFbCSA5AJOW1V7XDd+9vAO6Ud4NqEjZz3JwbsC4ZCvkEI5tVlzJ
 QcIRtwoFyPZ56u7WFfGCBPgBtIfMq6gV6t9/aRklGVWSDtmU2gtJjFiZ4HAQ/OZc+K7n
 b7X1D4torsu0sY8ErxRGl71nDbAupXXTA7T75ryKk6ARCWmp5AADIg8lNTG2UN89S2oQ
 wRxQ==
X-Gm-Message-State: AOJu0YzAsoNt9NtnDu+QEUZS/1mkw877fAzMM8JWk7AZOO6KTPogzhJj
 JjQXfntc2fVH8/oWOLdAfwT8npXNc469fyZuEH98PEJuxiA9vQzSfrHxOCvS5Qo2QsFaZMNg376
 uRWPy9874Cu2S5RQ+iDzN3pqlYWt5wY4PRhWm3w==
X-Gm-Gg: ASbGnctlVQAl9dX7UXR1c1Zt8QX7HnLJSnuFuNinueA0khgbxqERb85tg7DNbn1B+kH
 44cIrsu+BWZHdzvhWSMLSR41yxJf7BMU/+ZJz5mUEivBeaXz3lWEHAXVbO2YUXJ/xovcaTApYxM
 qR0nTEMPbJ7i9U24EfO8uW6JUWm5A=
X-Google-Smtp-Source: AGHT+IFHA3iCzo2hy2wykKweRnImvKaUR5OgCU6tKwecHNgyhcR+KYTY4MT7D9I6pCvx01zYFFGuGzYpSzsccVUKntk=
X-Received: by 2002:a05:6902:310d:b0:e58:dbf:ed05 with SMTP id
 3f1490d57ef6-e635c1003edmr19487280276.10.1741700768521; Tue, 11 Mar 2025
 06:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250306232256.4150882-1-trini@konsulko.com>
 <20250306232256.4150882-9-trini@konsulko.com>
In-Reply-To: <20250306232256.4150882-9-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Mar 2025 15:45:32 +0200
X-Gm-Features: AQ5f1JrAZ51obE_bGog_2LGd5AbZAlVhDfxyu-1eEYV-qC8RZ37zn1cScvz2LC4
Message-ID: <CAC_iWjKnMRjC1fxzWjAEhy0QcGTdnTYQ+9aMvhRB10LaNj3NSQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] test/py: Rework test_efi_secboot to not use
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
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  test/py/tests/test_efi_secboot/conftest.py | 32 ++++++++++------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/test/py/tests/test_efi_secboot/conftest.py b/test/py/tests/test_efi_secboot/conftest.py
> index 0fa0747fc764..bd05bfc55c7d 100644
> --- a/test/py/tests/test_efi_secboot/conftest.py
> +++ b/test/py/tests/test_efi_secboot/conftest.py
> @@ -5,6 +5,7 @@
>  """Fixture for UEFI secure boot test."""
>
>  from subprocess import call, check_call, CalledProcessError
> +from tests import fs_helper
>  import pytest
>  from defs import *
>
> @@ -19,13 +20,10 @@ def efi_boot_env(request, u_boot_config):
>      Return:
>          A path to disk image to be used for testing
>      """
> -    image_path = u_boot_config.persistent_data_dir
> -    image_path = image_path + '/test_efi_secboot.img'
>
>      try:
> -        mnt_point = u_boot_config.build_dir + '/mnt_efisecure'
> -        check_call('rm -rf {}'.format(mnt_point), shell=True)
> -        check_call('mkdir -p {}'.format(mnt_point), shell=True)
> +        image_path, mnt_point = fs_helper.setup_image(u_boot_config, 0, 0xc,
> +                                                      basename='test_efi_secboot')
>
>          # suffix
>          # *.key: RSA private key in PEM
> @@ -123,9 +121,9 @@ def efi_boot_env(request, u_boot_config):
>                     % (mnt_point, EFITOOLS_PATH),
>                     shell=True)
>
> -        check_call('virt-make-fs --partition=gpt --size=+1M --type=vfat {} {}'.format(
> -            mnt_point, image_path), shell=True)
> -        check_call('rm -rf {}'.format(mnt_point), shell=True)
> +        fsfile = fs_helper.mk_fs(u_boot_config, 'vfat', 0x1000000,
> +                                 'test_efi_secboot', mnt_point)
> +        check_call(f'dd if={fsfile} of={image_path} bs=1M seek=1', shell=True)
>
>      except CalledProcessError as exception:
>          pytest.skip('Setup failed: %s' % exception.cmd)
> @@ -133,7 +131,8 @@ def efi_boot_env(request, u_boot_config):
>      else:
>          yield image_path
>      finally:
> -        call('rm -f %s' % image_path, shell=True)
> +        call('rm -rf %s' % mnt_point, shell=True)
> +        call('rm -f %s %s' % (image_path, fsfile), shell=True)
>
>  #
>  # Fixture for UEFI secure boot test of intermediate certificates
> @@ -154,13 +153,10 @@ def efi_boot_env_intca(request, u_boot_config):
>      Return:
>          A path to disk image to be used for testing
>      """
> -    image_path = u_boot_config.persistent_data_dir
> -    image_path = image_path + '/test_efi_secboot_intca.img'
>
>      try:
> -        mnt_point = u_boot_config.persistent_data_dir + '/mnt_efi_secboot_intca'
> -        check_call('rm -rf {}'.format(mnt_point), shell=True)
> -        check_call('mkdir -p {}'.format(mnt_point), shell=True)
> +        image_path, mnt_point = fs_helper.setup_image(u_boot_config, 0, 0xc,
> +                                                      basename='test_efi_secboot_intca')
>
>          # Create signature database
>          # PK
> @@ -242,8 +238,9 @@ def efi_boot_env_intca(request, u_boot_config):
>          check_call('cd %s; cat TestSub.crt TestRoot.crt > TestSubRoot.crt; %ssbsign --key TestCert.key --cert TestCert.crt --addcert TestSubRoot.crt --out helloworld.efi.signed_abc helloworld.efi'
>                     % (mnt_point, SBSIGN_PATH), shell=True)
>
> -        check_call('virt-make-fs --partition=gpt --size=+1M --type=vfat {} {}'.format(mnt_point, image_path), shell=True)
> -        check_call('rm -rf {}'.format(mnt_point), shell=True)
> +        fsfile = fs_helper.mk_fs(u_boot_config, 'vfat', 0x1000000,
> +                                 'test_efi_secboot_intca', mnt_point)
> +        check_call(f'dd if={fsfile} of={image_path} bs=1M seek=1', shell=True)
>
>      except CalledProcessError as e:
>          pytest.skip('Setup failed: %s' % e.cmd)
> @@ -251,4 +248,5 @@ def efi_boot_env_intca(request, u_boot_config):
>      else:
>          yield image_path
>      finally:
> -        call('rm -f %s' % image_path, shell=True)
> +        call('rm -rf %s' % mnt_point, shell=True)
> +        call('rm -f %s %s' % (image_path, fsfile), shell=True)
> --
> 2.43.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
