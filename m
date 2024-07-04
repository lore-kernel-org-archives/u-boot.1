Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF70C3271E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 14:42:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F08AC88669;
	Thu,  4 Jul 2024 16:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TLxdI6Xo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F23A885D7; Thu,  4 Jul 2024 16:42:08 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4068D888DE
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 16:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2c96187b3d1so489945a91.3
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 07:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720104125; x=1720708925; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vh6VsLEl1EOOMmoXJhepYuajuCQx/Ua77DZA3Vlv1Fw=;
 b=TLxdI6XodlYd9qDZBFzg2DRs/FKo608Gd3KWUoAHkUWrD66PQuIe0DjO955ky4qv/a
 QcUeqhaafHE4Arakl1lC7HAy9e4OP4PbggTDm721EOB6toP1/NfDqmvl2mGTuicK4dD9
 TGwBH+lHPmE3kstQXBcImWfhFZb9Lx580XgUhHV/PvRXfXvjdjvYThee6EI8hUV8MisS
 69GtG8q/Z/Sk1UH/sLLsECERj4N/vP/f0cJZiDRqsN6TsYFS/Q2RV/u7zeB19mmvOa5R
 a6rDwEPQA6IUJUmp9X9XQ21VbSDmSwB/679iFYxzRuZvxqjppZKEfkeKpeZD/wvk3vQb
 /LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720104125; x=1720708925;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vh6VsLEl1EOOMmoXJhepYuajuCQx/Ua77DZA3Vlv1Fw=;
 b=iaK+7axO/0+OCATdzIPluLk6a3zQ4hepjZ1OQJRn44OXbtJj/dtu4SxM4+bu1mljNS
 CNjfuGWGSDww7VBrjruN/C3ZbxfMViScNBo4j4UZmptqLUK1l1NH1jGlLbhz6nm755UK
 tEI09z3ilfsT7uWO2l/xoB1DCrbeKDX0B0SrYwikPYAJwPa7V0olccJvm5fF8VavELIW
 UXx+VBMlk26V5qa962sPveu6Iag5qhSDIQ5MmpjIEKGvE03LJvkq0Z/lrFGG/Rc3kgHw
 X99GRSu+OUoZ6IDSnLlJxwjVCqFpfxv5ZhLbmq1qA7HQb1lV/MIGJmb92W4izBF9iInY
 FlIQ==
X-Gm-Message-State: AOJu0Yxz34z2selO1vrQgwEV7TdZLRerA9pRHadNx0PyDLdpPgfaQqqs
 lX3/45+21dCKlUHmzniSxO2sWYQiWsgZN+8pknlo/ONqyQVDLL4yeJRhyrLcf9hGrZfl5HpAO/8
 MYxFORKYdPDXKOJZBuKaS4Enz5x1JceKJTaYJ+pTYa6/oAKsFqjs=
X-Google-Smtp-Source: AGHT+IF6E8IFRPMmdOKl5HR2u2kPYoglehdO0vkY0TZFP/Iyqan1CFi9R1BLmUrfAm/en//m8owp7pnPkJ0nlP7VP5Q=
X-Received: by 2002:a17:90a:f28f:b0:2c2:faf7:67a0 with SMTP id
 98e67ed59e1d1-2c99c694365mr1451118a91.16.1720104124572; Thu, 04 Jul 2024
 07:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240704143752.250847-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20240704143752.250847-1-ilias.apalodimas@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Jul 2024 17:41:28 +0300
Message-ID: <CAC_iWjKXht3-7cdAo4iA1P=Q9ONPXLCRbjcD9GJVrnRVbxu=8g@mail.gmail.com>
Subject: Re: [PATCH] test: test for ignore OsIndications
To: xypron.glpk@gmx.de
Cc: u-boot@lists.denx.de
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

Hi Heinrich

Please ignore this patch I messed up my rebasing.

I'll send the proper one shortly

On Thu, 4 Jul 2024 at 17:37, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> The tests we currently have expect the firmware update to fail
> when OsIndications is not set properly. However, we have a Kconfig flag
> that explicitly ignores that variable and trigers the capsule update
> regardless. Adjust the tests accordingly
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  .../py/tests/test_efi_capsule/test_capsule_firmware_raw.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
> index 05853578c293..f3a2dff5c2c8 100644
> --- a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
> +++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
> @@ -95,6 +95,9 @@ class TestEfiCapsuleFirmwareRaw:
>              'config_efi_ignore_osindications')
>          need_reboot = True if ignore_os_indications else False
>
> +        capsule_auth = u_boot_config.buildconfig.get(
> +            'config_efi_capsule_authenticate')
> +
>          capsule_early = u_boot_config.buildconfig.get(
>              'config_efi_capsule_on_disk_early')
>          with u_boot_console.log.section('Test Case 2-b, after reboot'):
> @@ -104,10 +107,10 @@ class TestEfiCapsuleFirmwareRaw:
>              if not ignore_os_indications:
>                  check_file_exist(u_boot_console, disk_img, capsule_files)
>
> -            expected = 'u-boot:New' if ignore_os_indications else 'u-boot:Old'
> +            expected = 'u-boot:New' if (ignore_os_indications and not capsule_auth) else 'u-boot:Old'
>              verify_content(u_boot_console, '100000', expected)
>
> -            expected = 'u-boot-env:New' if ignore_os_indications else 'u-boot-env:Old'
> +            expected = 'u-boot-env:New' if (ignore_os_indications and not capsule_auth) else 'u-boot-env:Old'
>              verify_content(u_boot_console, '150000', expected)
>
>      def test_efi_capsule_fw3(
> --
> 2.43.0
>
