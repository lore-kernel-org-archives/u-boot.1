Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D51FC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 09:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B34C488876;
	Wed, 24 Jul 2024 11:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oj+4QcjJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98A4E888D7; Wed, 24 Jul 2024 11:26:56 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B79D88876
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 11:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7a1be7b7bb5so707034a12.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 02:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721813206; x=1722418006; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1eXvUVqatXkA+zjoiaNY6zUmYQYdQGSAleIJBPmyOA0=;
 b=oj+4QcjJLehotyX7+cgrs9fAGtDx/sgQk41kzzdKg3V05o7QY6JHc8gQrxCBDKINHJ
 1JIYfkHZNrC9NDix/uHjmZrRkykL4BhrDoAaF6pYZ8tQHcRjknk+Fj4c8yv/OV0F3QNE
 vB5peQmlc9v/beoz6wKcZyNDwQEnxs1JADnbl+IhEJeDt9fr9/63YWESR5h/0nXiNkOx
 hmzUXijfUJEApG1WME8C5ilyb1JUC+h2DO1ZL9+uV5JeXHG9CmDbQ20NVd8SGESGAXVK
 jieAlSO8Eef1UTtEX5lXmyKhJeAd1cmvVgwHWI2NOMUa7ES5/GpAzS9cojGehC6gsJGO
 da0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721813206; x=1722418006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1eXvUVqatXkA+zjoiaNY6zUmYQYdQGSAleIJBPmyOA0=;
 b=YTbBLJyiHaGO4OLSjdukkRn9Jumc8rGPfHPR0b3WkbK1LkNAKMnD7XbPa5/mCxkuaB
 eSM1sCpU/xUEEZmCwPGGQb161uVfI7xf4K1FqgxpEJRgksivYMOMT6vC9Md2bkU6kyiV
 fUeSDW/i69mkiM2e4ZojHjqYNn9859F53Uuz52TbdOnS2Doaum/xWC/v2K8H9Gw4TWVt
 TQsqsERqtSw8QmGkcSy2eGvVKUVAgzm6bZgwDW8sJNCXptpDrdin48ukxFPsDrnw9Znz
 O9MD/Dd1hom7LrAALXOnA5fwk1v2kq36s+EuL6UGG2ebSQr6jFrGcs2zS/1V8b1YRDQA
 tsXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9D3HIuOsSZlJZ+wT4zDgN/q7vvwQWIUt40t/Puf6AV0pEiFLGOFLXTYgkdlzL/3B9ca+o5FHQT4tZ6JyihcfL2t2YPQ==
X-Gm-Message-State: AOJu0YyKf7waUXjTYztA9XNaD9LuZiMY8rmkg0b60IKtmWhfU8Jmlun0
 LIiEJ2EKq818HRxpV/TiFS652ucg1dJVpn/KsS7ROE4ZGsjphf12aMlFM6SEk2ccJ41lhmmCYYB
 vO5B/oq3EcMYNeQdvXhqaaW4d5kZOEwgKiC76RQ==
X-Google-Smtp-Source: AGHT+IFYmp1Xmvh8wnlrHyjqHOi+hfGMzqZe72UrxvkOBorK8Nemin6HF/LQ0X+Bj0tNst4XFkAJWuWeALw9xo1vEgA=
X-Received: by 2002:a05:6a21:a24b:b0:1c4:67c1:f6fb with SMTP id
 adf61e73a8af0-1c467c1fbf6mr488157637.41.1721813204647; Wed, 24 Jul 2024
 02:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
 <20240719-b4-dynamic-uuid-v5-5-8a83de3fe3dc@linaro.org>
In-Reply-To: <20240719-b4-dynamic-uuid-v5-5-8a83de3fe3dc@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 24 Jul 2024 12:26:07 +0300
Message-ID: <CAC_iWj+LrXCp4zcLVqESSiJixM6t_7LJ0ekzt7q3DZgYK6vPZg@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] sandbox: switch to dynamic UUIDs
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

On Fri, 19 Jul 2024 at 15:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Migrate sandbox over to generating it's capsule update image GUIDs
> dynamically from the namespace and board/image info. Update the
> reference and tests to use the new GUIDs.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  board/sandbox/sandbox.c                                  | 16 ----------------
>  include/sandbox_efi_capsule.h                            |  6 +++---
>  .../tests/test_efi_capsule/test_capsule_firmware_fit.py  |  2 +-
>  .../tests/test_efi_capsule/test_capsule_firmware_raw.py  |  8 ++++----
>  .../test_efi_capsule/test_capsule_firmware_signed_fit.py |  2 +-
>  .../test_efi_capsule/test_capsule_firmware_signed_raw.py |  4 ++--
>  test/py/tests/test_efi_capsule/version.dts               |  6 +++---
>  tools/binman/etype/efi_capsule.py                        |  2 +-
>  tools/binman/ftest.py                                    |  2 +-
>  9 files changed, 16 insertions(+), 32 deletions(-)
>
> diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
> index 802596569c64..d97945e58fcf 100644
> --- a/board/sandbox/sandbox.c
> +++ b/board/sandbox/sandbox.c
> @@ -31,36 +31,20 @@
>   */
>  gd_t *gd;
>
>  #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
> -/* GUIDs for capsule updatable firmware images */
> -#define SANDBOX_UBOOT_IMAGE_GUID \
> -       EFI_GUID(0x09d7cf52, 0x0720, 0x4710, 0x91, 0xd1, \
> -                0x08, 0x46, 0x9b, 0x7f, 0xe9, 0xc8)
> -
> -#define SANDBOX_UBOOT_ENV_IMAGE_GUID \
> -       EFI_GUID(0x5a7021f5, 0xfef2, 0x48b4, 0xaa, 0xba, \
> -                0x83, 0x2e, 0x77, 0x74, 0x18, 0xc0)
> -
> -#define SANDBOX_FIT_IMAGE_GUID \
> -       EFI_GUID(0x3673b45d, 0x6a7c, 0x46f3, 0x9e, 0x60, \
> -                0xad, 0xab, 0xb0, 0x3f, 0x79, 0x37)
> -
>  struct efi_fw_image fw_images[] = {
>  #if defined(CONFIG_EFI_CAPSULE_FIRMWARE_RAW)
>         {
> -               .image_type_id = SANDBOX_UBOOT_IMAGE_GUID,
>                 .fw_name = u"SANDBOX-UBOOT",
>                 .image_index = 1,
>         },
>         {
> -               .image_type_id = SANDBOX_UBOOT_ENV_IMAGE_GUID,
>                 .fw_name = u"SANDBOX-UBOOT-ENV",
>                 .image_index = 2,
>         },
>  #elif defined(CONFIG_EFI_CAPSULE_FIRMWARE_FIT)
>         {
> -               .image_type_id = SANDBOX_FIT_IMAGE_GUID,
>                 .fw_name = u"SANDBOX-FIT",
>                 .image_index = 1,
>         },
>  #endif
> diff --git a/include/sandbox_efi_capsule.h b/include/sandbox_efi_capsule.h
> index 3e288e8a84a2..84d45ec5cfd5 100644
> --- a/include/sandbox_efi_capsule.h
> +++ b/include/sandbox_efi_capsule.h
> @@ -5,11 +5,11 @@
>
>  #if !defined(_SANDBOX_EFI_CAPSULE_H_)
>  #define _SANDBOX_EFI_CAPSULE_H_
>
> -#define SANDBOX_UBOOT_IMAGE_GUID       "09d7cf52-0720-4710-91d1-08469b7fe9c8"
> -#define SANDBOX_UBOOT_ENV_IMAGE_GUID   "5a7021f5-fef2-48b4-aaba-832e777418c0"
> -#define SANDBOX_FIT_IMAGE_GUID         "3673b45d-6a7c-46f3-9e60-adabb03f7937"
> +#define SANDBOX_UBOOT_IMAGE_GUID       "985f2937-7c2e-5e9a-8a5e-8e063312964b"
> +#define SANDBOX_UBOOT_ENV_IMAGE_GUID   "9e339473-c2eb-530a-a69b-0cd6bbbed40e"
> +#define SANDBOX_FIT_IMAGE_GUID         "46610520-469e-59dc-a8dd-c11832b877ea"
>  #define SANDBOX_INCORRECT_GUID         "058b7d83-50d5-4c47-a195-60d86ad341c4"
>
>  #define UBOOT_FIT_IMAGE                        "u-boot_bin_env.itb"
>
> diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py
> index 11bcdc2bb293..a726c71c1138 100644
> --- a/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py
> +++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py
> @@ -146,9 +146,9 @@ class TestEfiCapsuleFirmwareFit():
>                  verify_content(u_boot_console, '100000', 'u-boot:Old')
>                  verify_content(u_boot_console, '150000', 'u-boot-env:Old')
>              else:
>                  # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
> -                assert '3673B45D-6A7C-46F3-9E60-ADABB03F7937' in ''.join(output)
> +                assert '985F2937-7C2E-5E9A-8A5E-8E063312964B' in ''.join(output)
>                  assert 'ESRT: fw_version=5' in ''.join(output)
>                  assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
>
>                  verify_content(u_boot_console, '100000', 'u-boot:New')
> diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
> index f3a2dff5c2c8..8a790405c7c4 100644
> --- a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
> +++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
> @@ -144,12 +144,12 @@ class TestEfiCapsuleFirmwareRaw:
>                  'env set dfu_alt_info "sf 0:0=u-boot-bin raw 0x100000 0x50000;u-boot-env raw 0x150000 0x200000"',
>                  'efidebug capsule esrt'])
>
>              # ensure that SANDBOX_UBOOT_ENV_IMAGE_GUID is in the ESRT.
> -            assert '5A7021F5-FEF2-48B4-AABA-832E777418C0' in ''.join(output)
> +            assert '9E339473-C2EB-530A-A69B-0CD6BBBED40E' in ''.join(output)
>
>              # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
> -            assert '09D7CF52-0720-4710-91D1-08469B7FE9C8' in ''.join(output)
> +            assert '985F2937-7C2E-5E9A-8A5E-8E063312964B' in ''.join(output)
>
>              check_file_removed(u_boot_console, disk_img, capsule_files)
>
>              expected = 'u-boot:Old' if capsule_auth else 'u-boot:New'
> @@ -198,14 +198,14 @@ class TestEfiCapsuleFirmwareRaw:
>                  verify_content(u_boot_console, '100000', 'u-boot:Old')
>                  verify_content(u_boot_console, '150000', 'u-boot-env:Old')
>              else:
>                  # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
> -                assert '09D7CF52-0720-4710-91D1-08469B7FE9C8' in ''.join(output)
> +                assert '985F2937-7C2E-5E9A-8A5E-8E063312964B' in ''.join(output)
>                  assert 'ESRT: fw_version=5' in ''.join(output)
>                  assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
>
>                  # ensure that SANDBOX_UBOOT_ENV_IMAGE_GUID is in the ESRT.
> -                assert '5A7021F5-FEF2-48B4-AABA-832E777418C0' in ''.join(output)
> +                assert '9E339473-C2EB-530A-A69B-0CD6BBBED40E' in ''.join(output)
>                  assert 'ESRT: fw_version=10' in ''.join(output)
>                  assert 'ESRT: lowest_supported_fw_version=7' in ''.join(output)
>
>                  verify_content(u_boot_console, '100000', 'u-boot:New')
> diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py
> index 44a58baa3106..debbce8bdbdf 100644
> --- a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py
> +++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py
> @@ -156,9 +156,9 @@ class TestEfiCapsuleFirmwareSignedFit():
>                  'u-boot-env raw 0x150000 0x200000"',
>                  'efidebug capsule esrt'])
>
>              # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
> -            assert '3673B45D-6A7C-46F3-9E60-ADABB03F7937' in ''.join(output)
> +            assert '46610520-469E-59DC-A8DD-C11832B877EA' in ''.join(output)
>              assert 'ESRT: fw_version=5' in ''.join(output)
>              assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
>
>              verify_content(u_boot_console, '100000', 'u-boot:New')
> diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
> index 83a10e160b8c..439bd71b3a7d 100644
> --- a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
> +++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
> @@ -150,14 +150,14 @@ class TestEfiCapsuleFirmwareSignedRaw():
>                  'u-boot-env raw 0x150000 0x200000"',
>                  'efidebug capsule esrt'])
>
>              # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
> -            assert '09D7CF52-0720-4710-91D1-08469B7FE9C8' in ''.join(output)
> +            assert '985F2937-7C2E-5E9A-8A5E-8E063312964B' in ''.join(output)
>              assert 'ESRT: fw_version=5' in ''.join(output)
>              assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
>
>              # ensure that SANDBOX_UBOOT_ENV_IMAGE_GUID is in the ESRT.
> -            assert '5A7021F5-FEF2-48B4-AABA-832E777418C0' in ''.join(output)
> +            assert '9E339473-C2EB-530A-A69B-0CD6BBBED40E' in ''.join(output)
>              assert 'ESRT: fw_version=10' in ''.join(output)
>              assert 'ESRT: lowest_supported_fw_version=7' in ''.join(output)
>
>              verify_content(u_boot_console, '100000', 'u-boot:New')
> diff --git a/test/py/tests/test_efi_capsule/version.dts b/test/py/tests/test_efi_capsule/version.dts
> index 07850cc6064c..3aebb5b64fbd 100644
> --- a/test/py/tests/test_efi_capsule/version.dts
> +++ b/test/py/tests/test_efi_capsule/version.dts
> @@ -7,18 +7,18 @@
>         firmware-version {
>                 image1 {
>                         lowest-supported-version = <3>;
>                         image-index = <1>;
> -                       image-type-id = "09D7CF52-0720-4710-91D1-08469B7FE9C8";
> +                       image-type-id = "985F2937-7C2E-5E9A-8A5E-8E063312964B";
>                 };
>                 image2 {
>                         lowest-supported-version = <7>;
>                         image-index = <2>;
> -                       image-type-id = "5A7021F5-FEF2-48B4-AABA-832E777418C0";
> +                       image-type-id = "9E339473-C2EB-530A-A69B-0CD6BBBED40E";
>                 };
>                 image3 {
>                         lowest-supported-version = <3>;
>                         image-index = <1>;
> -                       image-type-id = "3673B45D-6A7C-46F3-9E60-ADABB03F7937";
> +                       image-type-id = "46610520-469E-59DC-A8DD-C11832B877EA";
>                 };
>         };
>  };
> diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
> index 751f654bf310..7ed016432074 100644
> --- a/tools/binman/etype/efi_capsule.py
> +++ b/tools/binman/etype/efi_capsule.py
> @@ -23,9 +23,9 @@ def get_binman_test_guid(type_str):
>      Returns:
>          The actual GUID value (str)
>      """
>      TYPE_TO_GUID = {
> -        'binman-test' : '09d7cf52-0720-4710-91d1-08469b7fe9c8'
> +        'binman-test' : '985f2937-7c2e-5e9a-8a5e-8e063312964b'
>      }
>
>      return TYPE_TO_GUID[type_str]
>
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index e4da04030a51..735413ddb0db 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -123,9 +123,9 @@ TEE_ADDR = 0x5678
>
>  # Firmware Management Protocol(FMP) GUID
>  FW_MGMT_GUID = '6dcbd5ed-e82d-4c44-bda1-7194199ad92a'
>  # Image GUID specified in the DTS
> -CAPSULE_IMAGE_GUID = '09d7cf52-0720-4710-91d1-08469b7fe9c8'
> +CAPSULE_IMAGE_GUID = '985F2937-7C2E-5E9A-8A5E-8E063312964B'
>  # Windows cert GUID
>  WIN_CERT_TYPE_EFI_GUID = '4aafd29d-68df-49ee-8aa9-347d375665a7'
>  # Empty capsule GUIDs
>  EMPTY_CAPSULE_ACCEPT_GUID = '0c996046-bcc0-4d04-85ec-e1fcedf1c6f8'
>
> --
> 2.45.2
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
