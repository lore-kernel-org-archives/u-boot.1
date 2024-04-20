Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6AAC4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 15:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31B5A880A5;
	Sat, 20 Apr 2024 17:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sGJUVQET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6601880A8; Sat, 20 Apr 2024 17:29:15 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB1E88074
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 17:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-518b9527c60so3423778e87.0
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 08:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713626952; x=1714231752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DL2uYwKd5SsBCpHgjavcbBJakbgxZXtdbD+4YME16i0=;
 b=sGJUVQETAidK4Z3ehLw2Se6VK+CbhR+9b5mwV/+5r8KxA0df1k55AkWzE1cwW2Oz2N
 NSszDL1FwQxY9ZlQ8DUoDXhJ82dBUGCnmo8+ZkAFWiK72A3tZmrDXIa/pR3apjX0dFY6
 ZTYWOGjPSiqI1irVG3OZirGWQcYXlnVk0CdQBzA9kC544nzsn0pA9Yq+Grp7kquthReN
 83f5w4tJBUadqfdt+lhEaPv9vtXblnkBq8El6+c0gp7TXobp46qHTGv8G3EVhn/lb27V
 1l/BSqAEBDeiQgGt3hTk9Ecg0lRmncSoUKypsRmTp0rx9JCW8t0Q2P8++B1N20ClEduh
 /Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713626952; x=1714231752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DL2uYwKd5SsBCpHgjavcbBJakbgxZXtdbD+4YME16i0=;
 b=UFbKhdbyJaTYcGmyQEtY7ij9ixjw23T6Nk8jZOgsxM9sOGon3gC1hJZcwoIv+S8KdQ
 XLF7URCAUMdiDS6Nuv9U3eZY+UAd8DicpWMelSX89rCLxTg5ZF2utRId2Ajtb6Yo+Kt1
 N/7+AI2S8B8jF6SjdI4h1iAa/19I39WVVPvHuI3TVjuptMUBoPl0czkxOpuktU0BXfhA
 2/aVHXXxsrRkDOtlxHPWNE4u9IIQmGKl1MLg9gByhr94Afgk/LI9iWAZC4pX2mrV30h2
 zEnAfI0DBAq77KTQ0gU4Yi6IFaTv1S5D/i6gdR1ucIcAWbWaKC4ryQVsrxQ+BKGqC4pT
 kUJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYqYn9tmSvcy0WWmjD3pQZ+YX4ACH66ZOx0Jj1+6+cfTVGSFnDUP1tOhKC9VinoDqYQncwCDBwH5/VnHJNwNT0ukrJ3w==
X-Gm-Message-State: AOJu0YwxLeU2GNUWCLE0XRq3vsfc91U4zMrkqs/1ouUju0sXgNB/6ewq
 hmXs86Nf6XEJ9xRgIJ6csQiw8ZlERi3jmBZHJKb1RIwlbi/EHzqp/OjsFszZMXSS9Cf5U8xNNqX
 2i025uAoBY8qWzFXntp9HHSrnfeTExV5M35yZiA==
X-Google-Smtp-Source: AGHT+IEoODjETvR1B7AWRNl5LiMkLy4C6hJzux29Ch/N50EBWuWY0W59srZDkUR0GBclaj6sj27aB/62mu6b6u2wntY=
X-Received: by 2002:a05:6512:159:b0:518:b283:1078 with SMTP id
 m25-20020a056512015900b00518b2831078mr4345890lfo.26.1713626951750; Sat, 20
 Apr 2024 08:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240420140058.120695-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240420140058.120695-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 20 Apr 2024 18:28:34 +0300
Message-ID: <CAC_iWj+AKJ2QX5aGBmRjnBQ5LWpKszXZY5HdPvAbkYbgTPKHYA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: improve error handling in try_load_entry()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, 20 Apr 2024 at 17:01, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The image is not unloaded if a security violation occurs.
>
> If efi_set_load_options() fails, we do not free the memory allocated for
> the optional data. We do not unload the image.
>
> If a load option is not active, we use a random value from the stack to
> allocate memory for the optional data of the load option.
>
> * Unload the image if a security violation occurs.
> * Free load_options if efi_set_load_options() fails.
> * Unload the image if efi_set_load_options() fails.
> * Do not allocate load_options with a random size from the stack
>   if the boot entry is not active.

Where is that happening?
Don't we always init the size in efi_get_var() &
efi_deserialize_load_option()_ which are called early?
efi_get_var() especially sets size = 0 even on failures

>
> Fixes: 53f6a5aa8626 ("efi_loader: Replace config option for initrd loading")

I think we also need a fix tag for 0ad64007feb93 as well?

> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_bootmgr.c                  | 97 +++++++++----------
>  test/py/tests/test_efi_secboot/test_signed.py | 28 +++---
>  .../test_efi_secboot/test_signed_intca.py     | 10 +-
>  .../tests/test_efi_secboot/test_unsigned.py   |  6 +-
>  4 files changed, 70 insertions(+), 71 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 4ac519228a6..ca2ebdaa32f 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -613,9 +613,12 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
>         void *load_option;
>         efi_uintn_t size;
>         efi_status_t ret;
> +       u32 attributes;
>
> -       efi_create_indexed_name(varname, sizeof(varname), "Boot", n);
> +       *handle = NULL;
> +       *load_options = NULL;
>
> +       efi_create_indexed_name(varname, sizeof(varname), "Boot", n);

>         load_option = efi_get_var(varname, &efi_global_variable_guid, &size);
>         if (!load_option)
>                 return EFI_LOAD_ERROR;
> @@ -626,55 +629,54 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
>                 goto error;
>         }
>
> -       if (lo.attributes & LOAD_OPTION_ACTIVE) {
> -               u32 attributes;
> -
> -               log_debug("trying to load \"%ls\" from %pD\n", lo.label,
> -                         lo.file_path);
> -
> -               if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
> -                       /* file_path doesn't contain a device path */
> -                       ret = try_load_from_short_path(lo.file_path, handle);
> -               } else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
> -                       if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
> -                               ret = try_load_from_uri_path(
> -                                       (struct efi_device_path_uri *)lo.file_path,
> -                                       lo.label, handle);
> -                       else
> -                               ret = EFI_LOAD_ERROR;
> -               } else {
> -                       ret = try_load_from_media(lo.file_path, handle);
> -               }
> -               if (ret != EFI_SUCCESS) {
> -                       log_warning("Loading %ls '%ls' failed\n",
> -                                   varname, lo.label);
> -                       goto error;
> -               }
> +       if (!(lo.attributes & LOAD_OPTION_ACTIVE)) {
> +               ret = EFI_LOAD_ERROR;
> +               goto error;
> +       }
>
> -               attributes = EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -                            EFI_VARIABLE_RUNTIME_ACCESS;
> -               ret = efi_set_variable_int(u"BootCurrent",
> -                                          &efi_global_variable_guid,
> -                                          attributes, sizeof(n), &n, false);
> -               if (ret != EFI_SUCCESS)
> -                       goto unload;
> -               /* try to register load file2 for initrd's */
> -               if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
> -                       ret = efi_initrd_register();
> -                       if (ret != EFI_SUCCESS)
> -                               goto unload;
> -               }
> +       log_debug("trying to load \"%ls\" from %pD\n", lo.label, lo.file_path);
>
> -               log_info("Booting: %ls\n", lo.label);
> +       if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
> +               /* file_path doesn't contain a device path */
> +               ret = try_load_from_short_path(lo.file_path, handle);
> +       } else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
> +               if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
> +                       ret = try_load_from_uri_path(
> +                               (struct efi_device_path_uri *)lo.file_path,
> +                               lo.label, handle);
> +               else
> +                       ret = EFI_LOAD_ERROR;
>         } else {
> -               ret = EFI_LOAD_ERROR;
> +               ret = try_load_from_media(lo.file_path, handle);
> +       }
> +       if (ret != EFI_SUCCESS) {
> +               log_warning("Loading %ls '%ls' failed\n",
> +                           varname, lo.label);
> +               goto error;
> +       }
> +
> +       attributes = EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                    EFI_VARIABLE_RUNTIME_ACCESS;
> +       ret = efi_set_variable_int(u"BootCurrent", &efi_global_variable_guid,
> +                                  attributes, sizeof(n), &n, false);
> +       if (ret != EFI_SUCCESS)
> +               goto error;
> +
> +       /* try to register load file2 for initrd's */
> +       if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
> +               ret = efi_initrd_register();
> +               if (ret != EFI_SUCCESS)
> +                       goto error;
>         }
>
> -       /* Set load options */
> +       log_info("Booting: %ls\n", lo.label);
> +
> +       /* Ignore the optional data in auto-generated boot options */
>         if (size >= sizeof(efi_guid_t) &&
>             !guidcmp(lo.optional_data, &efi_guid_bootmenu_auto_generated))
>                 size = 0;
>
> +       /* Set optional data in loaded file protocol */
>         if (size) {
>                 *load_options = malloc(size);
>                 if (!*load_options) {
> @@ -683,18 +685,15 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
>                 }
>                 memcpy(*load_options, lo.optional_data, size);
>                 ret = efi_set_load_options(*handle, size, *load_options);
> -       } else {
> -               *load_options = NULL;
> +               if (ret != EFI_SUCCESS)
> +                       free(load_options);
>         }
>
>  error:
> -       free(load_option);
> -
> -       return ret;
> -
> -unload:
> -       if (EFI_CALL(efi_unload_image(*handle)) != EFI_SUCCESS)
> +       if (ret != EFI_SUCCESS && *handle &&
> +           EFI_CALL(efi_unload_image(*handle)) != EFI_SUCCESS)
>                 log_err("Unloading image failed\n");
> +
>         free(load_option);
>
>         return ret;
> diff --git a/test/py/tests/test_efi_secboot/test_signed.py b/test/py/tests/test_efi_secboot/test_signed.py
> index 2f862a259ad..5000a4ab7b6 100644
> --- a/test/py/tests/test_efi_secboot/test_signed.py
> +++ b/test/py/tests/test_efi_secboot/test_signed.py
> @@ -62,13 +62,13 @@ class TestEfiSignedImage(object):
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert('\'HELLO1\' failed' in ''.join(output))
> -            assert('efi_start_image() returned: 26' in ''.join(output))
> +            assert('efi_bootmgr_load() returned: 26' in ''.join(output))
>              output = u_boot_console.run_command_list([
>                  'efidebug boot add -b 2 HELLO2 host 0:1 /helloworld.efi -s ""',
>                  'efidebug boot order 2',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO2\' failed' in ''.join(output)
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>
>          with u_boot_console.log.section('Test Case 2b'):
>              # Test Case 2b, authenticated by db
> @@ -80,7 +80,7 @@ class TestEfiSignedImage(object):
>                  'efidebug boot order 2',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO2\' failed' in ''.join(output)
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>              output = u_boot_console.run_command_list([
>                  'efidebug boot order 1',
>                  'bootefi bootmgr'])
> @@ -108,7 +108,7 @@ class TestEfiSignedImage(object):
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>
>          with u_boot_console.log.section('Test Case 3b'):
>              # Test Case 3b, rejected by dbx even if db allows
> @@ -120,7 +120,7 @@ class TestEfiSignedImage(object):
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>
>      def test_efi_signed_image_auth4(self, u_boot_console, efi_boot_env):
>          """
> @@ -146,7 +146,7 @@ class TestEfiSignedImage(object):
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>
>      def test_efi_signed_image_auth5(self, u_boot_console, efi_boot_env):
>          """
> @@ -196,7 +196,7 @@ class TestEfiSignedImage(object):
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>
>          with u_boot_console.log.section('Test Case 5d'):
>              # Test Case 5d, rejected if both of signatures are revoked
> @@ -208,7 +208,7 @@ class TestEfiSignedImage(object):
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>
>          # Try rejection in reverse order.
>          u_boot_console.restart_uboot()
> @@ -233,7 +233,7 @@ class TestEfiSignedImage(object):
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>
>      def test_efi_signed_image_auth6(self, u_boot_console, efi_boot_env):
>          """
> @@ -268,7 +268,7 @@ class TestEfiSignedImage(object):
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>
>          with u_boot_console.log.section('Test Case 6c'):
>              # Test Case 6c, rejected by image's digest in dbx
> @@ -282,7 +282,7 @@ class TestEfiSignedImage(object):
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>
>      def test_efi_signed_image_auth7(self, u_boot_console, efi_boot_env):
>          """
> @@ -310,7 +310,7 @@ class TestEfiSignedImage(object):
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>
>          # sha512 of an x509 cert in dbx
>          u_boot_console.restart_uboot()
> @@ -333,7 +333,7 @@ class TestEfiSignedImage(object):
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO\' failed' in ''.join(output)
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>
>      def test_efi_signed_image_auth8(self, u_boot_console, efi_boot_env):
>          """
> @@ -368,4 +368,4 @@ class TestEfiSignedImage(object):
>                  'efidebug test bootmgr'])
>              assert(not 'hELLO, world!' in ''.join(output))
>              assert('\'HELLO1\' failed' in ''.join(output))
> -            assert('efi_start_image() returned: 26' in ''.join(output))
> +            assert('efi_bootmgr_load() returned: 26' in ''.join(output))
> diff --git a/test/py/tests/test_efi_secboot/test_signed_intca.py b/test/py/tests/test_efi_secboot/test_signed_intca.py
> index 8d9a5f3e7fe..cf906205bc2 100644
> --- a/test/py/tests/test_efi_secboot/test_signed_intca.py
> +++ b/test/py/tests/test_efi_secboot/test_signed_intca.py
> @@ -43,7 +43,7 @@ class TestEfiSignedImageIntca(object):
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO_a\' failed' in ''.join(output)
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>
>          with u_boot_console.log.section('Test Case 1b'):
>              # Test Case 1b, signed and authenticated by root CA
> @@ -74,7 +74,7 @@ class TestEfiSignedImageIntca(object):
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO_abc\' failed' in ''.join(output)
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>
>          with u_boot_console.log.section('Test Case 2b'):
>              # Test Case 2b, signed and authenticated by root CA
> @@ -84,7 +84,7 @@ class TestEfiSignedImageIntca(object):
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO_abc\' failed' in ''.join(output)
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>
>          with u_boot_console.log.section('Test Case 2c'):
>              # Test Case 2c, signed and authenticated by root CA
> @@ -122,7 +122,7 @@ class TestEfiSignedImageIntca(object):
>              assert 'Hello, world!' in ''.join(output)
>              # Or,
>              # assert '\'HELLO_abc\' failed' in ''.join(output)
> -            # assert 'efi_start_image() returned: 26' in ''.join(output)
> +            # assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>
>          with u_boot_console.log.section('Test Case 3b'):
>              # Test Case 3b, revoked by root CA in dbx
> @@ -132,4 +132,4 @@ class TestEfiSignedImageIntca(object):
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
>              assert '\'HELLO_abc\' failed' in ''.join(output)
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
> diff --git a/test/py/tests/test_efi_secboot/test_unsigned.py b/test/py/tests/test_efi_secboot/test_unsigned.py
> index 7c078f220d0..b4320ae4054 100644
> --- a/test/py/tests/test_efi_secboot/test_unsigned.py
> +++ b/test/py/tests/test_efi_secboot/test_unsigned.py
> @@ -42,7 +42,7 @@ class TestEfiUnsignedImage(object):
>              output = u_boot_console.run_command_list([
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>              assert 'Hello, world!' not in ''.join(output)
>
>      def test_efi_unsigned_image_auth2(self, u_boot_console, efi_boot_env):
> @@ -95,7 +95,7 @@ class TestEfiUnsignedImage(object):
>              output = u_boot_console.run_command_list([
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>              assert 'Hello, world!' not in ''.join(output)
>
>          with u_boot_console.log.section('Test Case 3b'):
> @@ -113,5 +113,5 @@ class TestEfiUnsignedImage(object):
>              output = u_boot_console.run_command_list([
>                  'efidebug boot order 1',
>                  'efidebug test bootmgr'])
> -            assert 'efi_start_image() returned: 26' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
>              assert 'Hello, world!' not in ''.join(output)
> --
> 2.43.0
>

Please adjust the commit message either in a v2 or while merging.
Other than that

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
