Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8A3C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 15:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A61D88A23;
	Tue,  6 Aug 2024 17:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d3Ka0Pxn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01DAD88A1E; Tue,  6 Aug 2024 17:33:06 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF41088AA9
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 17:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42817f1eb1fso5697095e9.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 08:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722958382; x=1723563182;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u/0i9wm+HH+4u8lWtp+TaFHrvn3t89KvsTssqkwGzjs=;
 b=d3Ka0PxnbcNi4aK5ZxfIpRCQP2PtznvdW/PoOveK+T7eIhXdXVFbGzCDs22f8aowFo
 8Zj/63N9Fb6WPUuIWmcxyPAX6fNf8etHBG4hQODFwwq7Bcgxs73hFxrozLXTcj4KIkLi
 tFcfya9QQ9O6agTnBhBVx5lTknAOt+ZRa93jNaVWEyoUUN/0vtNLvogAdYiLTB7c9uOr
 g8WWZ6KUHpoiNc4bfaFryrj9+2XGV5OLcW1bxEKPRHcKJvG3ufXs8OORsgJXtPBlZA/y
 bqFpwfmMzjKDpxy/WO1YTRL4QdZSURbGBgpYJy1mQ+n0nsHZXjofM6IZLxzW8w8snY7n
 hraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722958382; x=1723563182;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/0i9wm+HH+4u8lWtp+TaFHrvn3t89KvsTssqkwGzjs=;
 b=Yql1Go46VtUcHm4xWjBNquBCbwBuvGSI8BZ793YPwFrxIC+drRe458ay6qsI2fcqjQ
 NTxJcK2jSL9CO+ECKyl0fhg/34mUMOH/uLT/oM4dPHXu1yE65a2XSOVPhJ3Zg30/GzzV
 XP+o+is2YF8mF8ByubLPZod7iqGMrBTmB8hxpDnLWax/ODD6+i5ZC377R4m7DYuT7O0G
 2K0g5ZLMhkgUaCn42hPZEqUXzzV1uiyRKPKugydFdS700RsYr+VL2bzM035ik2aIPIHC
 fJqu5cvsAQ/UZqDLHWgkTqfozlJ8KMJ0bdqfW4eeGB4tfni8+mCFf7L4i9g5H1us+pRI
 BBnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEB2dp+dCXXlrD/35lSI9LEJWuJlnJSXz5HKB3kZEGPmkwdern9luKCExesyRpyPWRXKAUivGR9x/fElVq4Web+G56NA==
X-Gm-Message-State: AOJu0YzQiB/kGpzygDKy9g7zfsOBk7OM3EWE1QlT5PNO4hQAM4Crsvd6
 DGSAw8j4zN4AQCoe0yc3hmd64Itq4DvfoXCGT4mSRZdwQ6bbkUJi8zz9gD+ThD0=
X-Google-Smtp-Source: AGHT+IEsx8kZIKU7vxPvsIGXm4yoXkD70P9A7cYfnffTgatcCNUWmkK1cmCh06FewNkSLEHrbZEanw==
X-Received: by 2002:a05:600c:35c2:b0:428:f79:1836 with SMTP id
 5b1f17b1804b1-428e6b7e74dmr112287575e9.26.1722958381833; 
 Tue, 06 Aug 2024 08:33:01 -0700 (PDT)
Received: from localhost ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e9e924sm182335935e9.48.2024.08.06.08.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 08:33:01 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
Cc: upstream+uboot@sigma-star.at, francis.laniel@amarulasolutions.com,
 glaroque@baylibre.com, sjg@chromium.org,
 christian.taedcke@weidmueller.com, trini@konsulko.com, Richard Weinberger
 <richard@nod.at>
Subject: Re: [PATCH 2/3] test_fs: Rename mount dir to scratch
In-Reply-To: <20240802093322.15240-2-richard@nod.at>
References: <20240802093322.15240-1-richard@nod.at>
 <20240802093322.15240-2-richard@nod.at>
Date: Tue, 06 Aug 2024 17:32:58 +0200
Message-ID: <87plqloedx.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Richard,

Thank you for the patch.

On ven., ao=C3=BBt 02, 2024 at 11:33, Richard Weinberger <richard@nod.at> w=
rote:

> Since no mounting happens anymore, rename the "mnt"
> directory to "scratch" and the related variables.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  test/py/tests/test_fs/conftest.py | 66 +++++++++++++++----------------
>  1 file changed, 33 insertions(+), 33 deletions(-)
>
> diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/co=
nftest.py
> index 59342a6e3d..af2adaf164 100644
> --- a/test/py/tests/test_fs/conftest.py
> +++ b/test/py/tests/test_fs/conftest.py
> @@ -178,13 +178,13 @@ def fs_obj_basic(request, u_boot_config):
>      fs_ubtype =3D fstype_to_ubname(fs_type)
>      check_ubconfig(u_boot_config, fs_ubtype)
>=20=20
> -    mount_dir =3D u_boot_config.persistent_data_dir + '/mnt'
> +    scratch_dir =3D u_boot_config.persistent_data_dir + '/scratch'
>=20=20
> -    small_file =3D mount_dir + '/' + SMALL_FILE
> -    big_file =3D mount_dir + '/' + BIG_FILE
> +    small_file =3D scratch_dir + '/' + SMALL_FILE
> +    big_file =3D scratch_dir + '/' + BIG_FILE
>=20=20
>      try:
> -        check_call('mkdir -p %s' % mount_dir, shell=3DTrue)
> +        check_call('mkdir -p %s' % scratch_dir, shell=3DTrue)
>      except CalledProcessError as err:
>          pytest.skip('Preparing mount folder failed for filesystem: ' + f=
s_type + '. {}'.format(err))

Should we update the error message here as well?
'Preparing scratch folder failed for filestem: '

Same is true for similar messages below.

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>          call('rm -f %s' % fs_img, shell=3DTrue)
> @@ -192,7 +192,7 @@ def fs_obj_basic(request, u_boot_config):
>=20=20
>      try:
>          # Create a subdirectory.
> -        check_call('mkdir %s/SUBDIR' % mount_dir, shell=3DTrue)
> +        check_call('mkdir %s/SUBDIR' % scratch_dir, shell=3DTrue)
>=20=20
>          # Create big file in this image.
>          # Note that we work only on the start 1MB, couple MBs in the 2GB=
 range
> @@ -253,7 +253,7 @@ def fs_obj_basic(request, u_boot_config):
>=20=20
>          try:
>              # 3GiB volume
> -            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0xc000000=
0, '3GB', mount_dir)
> +            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0xc000000=
0, '3GB', scratch_dir)
>          except CalledProcessError as err:
>              pytest.skip('Creating failed for filesystem: ' + fs_type + '=
. {}'.format(err))
>              return
> @@ -264,7 +264,7 @@ def fs_obj_basic(request, u_boot_config):
>      else:
>          yield [fs_ubtype, fs_img, md5val]
>      finally:
> -        call('rm -rf %s' % mount_dir, shell=3DTrue)
> +        call('rm -rf %s' % scratch_dir, shell=3DTrue)
>          call('rm -f %s' % fs_img, shell=3DTrue)
>=20=20
>  #
> @@ -288,13 +288,13 @@ def fs_obj_ext(request, u_boot_config):
>      fs_ubtype =3D fstype_to_ubname(fs_type)
>      check_ubconfig(u_boot_config, fs_ubtype)
>=20=20
> -    mount_dir =3D u_boot_config.persistent_data_dir + '/mnt'
> +    scratch_dir =3D u_boot_config.persistent_data_dir + '/scratch'
>=20=20
> -    min_file =3D mount_dir + '/' + MIN_FILE
> -    tmp_file =3D mount_dir + '/tmpfile'
> +    min_file =3D scratch_dir + '/' + MIN_FILE
> +    tmp_file =3D scratch_dir + '/tmpfile'
>=20=20
>      try:
> -        check_call('mkdir -p %s' % mount_dir, shell=3DTrue)
> +        check_call('mkdir -p %s' % scratch_dir, shell=3DTrue)
>      except CalledProcessError as err:
>          pytest.skip('Preparing mount folder failed for filesystem: ' + f=
s_type + '. {}'.format(err))
>          call('rm -f %s' % fs_img, shell=3DTrue)
> @@ -302,7 +302,7 @@ def fs_obj_ext(request, u_boot_config):
>=20=20
>      try:
>          # Create a test directory
> -        check_call('mkdir %s/dir1' % mount_dir, shell=3DTrue)
> +        check_call('mkdir %s/dir1' % scratch_dir, shell=3DTrue)
>=20=20
>          # Create a small file and calculate md5
>          check_call('dd if=3D/dev/urandom of=3D%s bs=3D1K count=3D20'
> @@ -343,7 +343,7 @@ def fs_obj_ext(request, u_boot_config):
>=20=20
>          try:
>              # 128MiB volume
> -            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000=
, '128MB', mount_dir)
> +            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000=
, '128MB', scratch_dir)
>          except CalledProcessError as err:
>              pytest.skip('Creating failed for filesystem: ' + fs_type + '=
. {}'.format(err))
>              return
> @@ -354,7 +354,7 @@ def fs_obj_ext(request, u_boot_config):
>      else:
>          yield [fs_ubtype, fs_img, md5val]
>      finally:
> -        call('rm -rf %s' % mount_dir, shell=3DTrue)
> +        call('rm -rf %s' % scratch_dir, shell=3DTrue)
>          call('rm -f %s' % fs_img, shell=3DTrue)
>=20=20
>  #
> @@ -409,10 +409,10 @@ def fs_obj_unlink(request, u_boot_config):
>      fs_ubtype =3D fstype_to_ubname(fs_type)
>      check_ubconfig(u_boot_config, fs_ubtype)
>=20=20
> -    mount_dir =3D u_boot_config.persistent_data_dir + '/mnt'
> +    scratch_dir =3D u_boot_config.persistent_data_dir + '/scratch'
>=20=20
>      try:
> -        check_call('mkdir -p %s' % mount_dir, shell=3DTrue)
> +        check_call('mkdir -p %s' % scratch_dir, shell=3DTrue)
>      except CalledProcessError as err:
>          pytest.skip('Preparing mount folder failed for filesystem: ' + f=
s_type + '. {}'.format(err))
>          call('rm -f %s' % fs_img, shell=3DTrue)
> @@ -420,29 +420,29 @@ def fs_obj_unlink(request, u_boot_config):
>=20=20
>      try:
>          # Test Case 1 & 3
> -        check_call('mkdir %s/dir1' % mount_dir, shell=3DTrue)
> +        check_call('mkdir %s/dir1' % scratch_dir, shell=3DTrue)
>          check_call('dd if=3D/dev/urandom of=3D%s/dir1/file1 bs=3D1K coun=
t=3D1'
> -                                    % mount_dir, shell=3DTrue)
> +                                    % scratch_dir, shell=3DTrue)
>          check_call('dd if=3D/dev/urandom of=3D%s/dir1/file2 bs=3D1K coun=
t=3D1'
> -                                    % mount_dir, shell=3DTrue)
> +                                    % scratch_dir, shell=3DTrue)
>=20=20
>          # Test Case 2
> -        check_call('mkdir %s/dir2' % mount_dir, shell=3DTrue)
> +        check_call('mkdir %s/dir2' % scratch_dir, shell=3DTrue)
>          for i in range(0, 20):
>              check_call('mkdir %s/dir2/0123456789abcdef%02x'
> -                                    % (mount_dir, i), shell=3DTrue)
> +                                    % (scratch_dir, i), shell=3DTrue)
>=20=20
>          # Test Case 4
> -        check_call('mkdir %s/dir4' % mount_dir, shell=3DTrue)
> +        check_call('mkdir %s/dir4' % scratch_dir, shell=3DTrue)
>=20=20
>          # Test Case 5, 6 & 7
> -        check_call('mkdir %s/dir5' % mount_dir, shell=3DTrue)
> +        check_call('mkdir %s/dir5' % scratch_dir, shell=3DTrue)
>          check_call('dd if=3D/dev/urandom of=3D%s/dir5/file1 bs=3D1K coun=
t=3D1'
> -                                    % mount_dir, shell=3DTrue)
> +                                    % scratch_dir, shell=3DTrue)
>=20=20
>          try:
>              # 128MiB volume
> -            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000=
, '128MB', mount_dir)
> +            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000=
, '128MB', scratch_dir)
>          except CalledProcessError as err:
>              pytest.skip('Creating failed for filesystem: ' + fs_type + '=
. {}'.format(err))
>              return
> @@ -453,7 +453,7 @@ def fs_obj_unlink(request, u_boot_config):
>      else:
>          yield [fs_ubtype, fs_img]
>      finally:
> -        call('rm -rf %s' % mount_dir, shell=3DTrue)
> +        call('rm -rf %s' % scratch_dir, shell=3DTrue)
>          call('rm -f %s' % fs_img, shell=3DTrue)
>=20=20
>  #
> @@ -477,13 +477,13 @@ def fs_obj_symlink(request, u_boot_config):
>      fs_ubtype =3D fstype_to_ubname(fs_type)
>      check_ubconfig(u_boot_config, fs_ubtype)
>=20=20
> -    mount_dir =3D u_boot_config.persistent_data_dir + '/mnt'
> +    scratch_dir =3D u_boot_config.persistent_data_dir + '/scratch'
>=20=20
> -    small_file =3D mount_dir + '/' + SMALL_FILE
> -    medium_file =3D mount_dir + '/' + MEDIUM_FILE
> +    small_file =3D scratch_dir + '/' + SMALL_FILE
> +    medium_file =3D scratch_dir + '/' + MEDIUM_FILE
>=20=20
>      try:
> -        check_call('mkdir -p %s' % mount_dir, shell=3DTrue)
> +        check_call('mkdir -p %s' % scratch_dir, shell=3DTrue)
>      except CalledProcessError as err:
>          pytest.skip('Preparing mount folder failed for filesystem: ' + f=
s_type + '. {}'.format(err))
>          call('rm -f %s' % fs_img, shell=3DTrue)
> @@ -491,7 +491,7 @@ def fs_obj_symlink(request, u_boot_config):
>=20=20
>      try:
>          # Create a subdirectory.
> -        check_call('mkdir %s/SUBDIR' % mount_dir, shell=3DTrue)
> +        check_call('mkdir %s/SUBDIR' % scratch_dir, shell=3DTrue)
>=20=20
>          # Create a small file in this image.
>          check_call('dd if=3D/dev/urandom of=3D%s bs=3D1M count=3D1'
> @@ -513,7 +513,7 @@ def fs_obj_symlink(request, u_boot_config):
>=20=20
>          try:
>              # 1GiB volume
> -            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x4000000=
0, '1GB', mount_dir)
> +            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x4000000=
0, '1GB', scratch_dir)
>          except CalledProcessError as err:
>              pytest.skip('Creating failed for filesystem: ' + fs_type + '=
. {}'.format(err))
>              return
> @@ -524,7 +524,7 @@ def fs_obj_symlink(request, u_boot_config):
>      else:
>          yield [fs_ubtype, fs_img, md5val]
>      finally:
> -        call('rm -rf %s' % mount_dir, shell=3DTrue)
> +        call('rm -rf %s' % scratch_dir, shell=3DTrue)
>          call('rm -f %s' % fs_img, shell=3DTrue)
>=20=20
>  #
> --=20
> 2.35.3
