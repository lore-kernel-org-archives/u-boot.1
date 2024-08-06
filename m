Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4A1C52D70
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 15:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F332488A1E;
	Tue,  6 Aug 2024 17:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="20X96g8z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34B4B88A38; Tue,  6 Aug 2024 17:29:57 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D43A288A10
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 17:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-428101fa30aso5157985e9.3
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722958185; x=1723562985;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mJPN4zy7gBD3To3BMnDAa3/CgXyC09bcPJVAG7vYgXA=;
 b=20X96g8zKtGuw+FWGpl8Y5UDogCQDJyBHRwUwZEHcCW1rFWX9wGncmB81EKdddqngq
 uFJPbQGMedNcUi06Y2Ga97w52Cxz7ejpa+aD7KmqwLdqx5fY39HpGzVhWQJqp+YY/aq3
 gYOstcJ3OxNUVhO+Jn8eZG8/y6Y5n7cvpa7EqCNATmBQrdzooHuhrzXaLFmiodS3FbE/
 W1oP+MJPSldIlUkQyydTZikqUcc5WUxnVYmxobIY725mrEc1Kc35H3auAsQcVV/rHDS3
 ozzOFudJkWI3GJXH7t471OOnupjsO4PQE9GVbCh6tXv3BVIcv8tYmgBUHSFRtTQiE9uK
 hvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722958185; x=1723562985;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mJPN4zy7gBD3To3BMnDAa3/CgXyC09bcPJVAG7vYgXA=;
 b=r4V2MboCMZ2xZgPnWvmEGOs4h9za13zTmv+tMS5HJlNc5ToLfPVaqnSi2vXlJexnXw
 B82esgr87Ae7BTTj5+fNwfvUGw05POUIZ4djBnZ7O/A/C+RDWPuDzVrCkuWNcH0unvJh
 lVI04dtJBKnTLDqbZcgPLbxHJjfNYeJ93EHGBCMrMPhHwihbQ0MCOrObHRXP7lWAGtYd
 7V5F5D+eVu0e/aCIb8GatvpkGL01SJ15sdGC86t68Ev9UpRGOz7XcrNepR4g+5iLY1tj
 iFlzhVzRJwfiOymNfNKYBW8kzub7CUt2gNcGPIpzK62f/DUBjOPTVXAmxjnG68zPLLRp
 /6RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSyQtsuoQ1Kaw4SxuDvCZTA81HINxBdq1C9wN6GZ4xJ4J4YpjgQWVa75sXird2f7EQWEIXzPxsHJExcTgPoA0mb4aOpA==
X-Gm-Message-State: AOJu0YwVO0pMCz70DUx/miuA8sOHQQVbk2lKuo9BpuzTkVq1Qt3CWaDe
 pWXTV9wEbrQX7N19e6oVRu3rjk+7bLG6OvUDpWkdMgD0Dj7jMe3TsohiWELeHMo=
X-Google-Smtp-Source: AGHT+IELDi1vXvUwM1M8Nrpb64+rZjRYKqUagB9wACfo1KzN77TFoWtxxI1UxdXvNK1G2T5WsjE5TQ==
X-Received: by 2002:a05:600c:3506:b0:426:5e91:3920 with SMTP id
 5b1f17b1804b1-428e6b7d042mr114039505e9.29.1722958184548; 
 Tue, 06 Aug 2024 08:29:44 -0700 (PDT)
Received: from localhost ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b89a86dsm246874775e9.1.2024.08.06.08.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 08:29:44 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
Cc: upstream+uboot@sigma-star.at, francis.laniel@amarulasolutions.com,
 glaroque@baylibre.com, sjg@chromium.org,
 christian.taedcke@weidmueller.com, trini@konsulko.com, Richard Weinberger
 <richard@nod.at>
Subject: Re: [PATCH 1/3] test_fs: Allow running unprivileged
In-Reply-To: <20240802093322.15240-1-richard@nod.at>
References: <20240802093322.15240-1-richard@nod.at>
Date: Tue, 06 Aug 2024 17:29:41 +0200
Message-ID: <87sevhoeje.fsf@baylibre.com>
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

> There is no need to mount the filesystem on the host side.
> All filesystem tools offer some way to fill the fs without mounting.
>
> So, create the content on the host side, create and fill the fs
> without mounting.
> No more sudo or guestmount needed.
>
> This new approach works because the tests don't care about user IDs
> and no device files are needed.
> If user IDs start to matter it's still possible to use wrapper
> tools like fakeroot in future while filling the fs.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Running:
$ ./test/py/test.py --bd sandbox --build -k test_fs

On master: 100 skipped
With the series applied: no more tests are skipped

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  test/py/tests/fs_helper.py        |  11 +-
>  test/py/tests/test_fs/conftest.py | 175 ++++++------------------------
>  test/py/tests/test_ut.py          |   4 +-
>  3 files changed, 47 insertions(+), 143 deletions(-)
>
> diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
> index 380f4c4dca..154e01264c 100644
> --- a/test/py/tests/fs_helper.py
> +++ b/test/py/tests/fs_helper.py
> @@ -9,7 +9,7 @@ import re
>  import os
>  from subprocess import call, check_call, check_output, CalledProcessError
>=20=20
> -def mk_fs(config, fs_type, size, prefix, size_gran =3D 0x100000):
> +def mk_fs(config, fs_type, size, prefix, src_dir, size_gran =3D 0x100000=
):
>      """Create a file system volume
>=20=20
>      Args:
> @@ -39,6 +39,13 @@ def mk_fs(config, fs_type, size, prefix, size_gran =3D=
 0x100000):
>      else:
>          fs_lnxtype =3D fs_type
>=20=20
> +    if src_dir:
> +        if fs_lnxtype =3D=3D 'ext4':
> +            mkfs_opt =3D mkfs_opt + ' -d ' + src_dir
> +        elif fs_lnxtype !=3D 'vfat':
> +            # Implement src_dir for this fs!
> +            raise
> +
>      count =3D (size + size_gran - 1) // size_gran
>=20=20
>      # Some distributions do not add /sbin to the default PATH, where mkf=
s lives
> @@ -55,6 +62,8 @@ def mk_fs(config, fs_type, size, prefix, size_gran =3D =
0x100000):
>                                        shell=3DTrue).decode()
>              if 'metadata_csum' in sb_content:
>                  check_call(f'tune2fs -O ^metadata_csum {fs_img}', shell=
=3DTrue)
> +        elif fs_lnxtype =3D=3D 'vfat' and src_dir:
> +            check_call(f'mcopy -i {fs_img} -vsmpQ {src_dir}/* ::/', shel=
l=3DTrue)
>          return fs_img
>      except CalledProcessError:
>          call(f'rm -f {fs_img}', shell=3DTrue)
> diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/co=
nftest.py
> index fca5448837..59342a6e3d 100644
> --- a/test/py/tests/test_fs/conftest.py
> +++ b/test/py/tests/test_fs/conftest.py
> @@ -156,64 +156,6 @@ def tool_is_in_path(tool):
>              return True
>      return False
>=20=20
> -fuse_mounted =3D False
> -
> -def mount_fs(fs_type, device, mount_point):
> -    """Mount a volume.
> -
> -    Args:
> -        fs_type: File system type.
> -        device: Volume's file name.
> -        mount_point: Mount point.
> -
> -    Return:
> -        Nothing.
> -    """
> -    global fuse_mounted
> -
> -    try:
> -        check_call('guestmount --pid-file guestmount.pid -a %s -m /dev/s=
da %s'
> -            % (device, mount_point), shell=3DTrue)
> -        fuse_mounted =3D True
> -        return
> -    except CalledProcessError:
> -        fuse_mounted =3D False
> -
> -    mount_opt =3D 'loop,rw'
> -    if re.match('fat', fs_type):
> -        mount_opt +=3D ',umask=3D0000'
> -
> -    check_call('sudo mount -o %s %s %s'
> -        % (mount_opt, device, mount_point), shell=3DTrue)
> -
> -    # may not be effective for some file systems
> -    check_call('sudo chmod a+rw %s' % mount_point, shell=3DTrue)
> -
> -def umount_fs(mount_point):
> -    """Unmount a volume.
> -
> -    Args:
> -        mount_point: Mount point.
> -
> -    Return:
> -        Nothing.
> -    """
> -    if fuse_mounted:
> -        call('sync')
> -        call('guestunmount %s' % mount_point, shell=3DTrue)
> -
> -        try:
> -            with open("guestmount.pid", "r") as pidfile:
> -                pid =3D int(pidfile.read())
> -            util.waitpid(pid, kill=3DTrue)
> -            os.remove("guestmount.pid")
> -
> -        except FileNotFoundError:
> -            pass
> -
> -    else:
> -        call('sudo umount %s' % mount_point, shell=3DTrue)
> -
>  #
>  # Fixture for basic fs test
>  #     derived from test/fs/fs-test.sh
> @@ -241,14 +183,6 @@ def fs_obj_basic(request, u_boot_config):
>      small_file =3D mount_dir + '/' + SMALL_FILE
>      big_file =3D mount_dir + '/' + BIG_FILE
>=20=20
> -    try:
> -
> -        # 3GiB volume
> -        fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0xc0000000, '=
3GB')
> -    except CalledProcessError as err:
> -        pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}=
'.format(err))
> -        return
> -
>      try:
>          check_call('mkdir -p %s' % mount_dir, shell=3DTrue)
>      except CalledProcessError as err:
> @@ -256,15 +190,6 @@ def fs_obj_basic(request, u_boot_config):
>          call('rm -f %s' % fs_img, shell=3DTrue)
>          return
>=20=20
> -    try:
> -        # Mount the image so we can populate it.
> -        mount_fs(fs_type, fs_img, mount_dir)
> -    except CalledProcessError as err:
> -        pytest.skip('Mounting to folder failed for filesystem: ' + fs_ty=
pe + '. {}'.format(err))
> -        call('rmdir %s' % mount_dir, shell=3DTrue)
> -        call('rm -f %s' % fs_img, shell=3DTrue)
> -        return
> -
>      try:
>          # Create a subdirectory.
>          check_call('mkdir %s/SUBDIR' % mount_dir, shell=3DTrue)
> @@ -326,15 +251,20 @@ def fs_obj_basic(request, u_boot_config):
>  	    % big_file, shell=3DTrue).decode()
>          md5val.append(out.split()[0])
>=20=20
> +        try:
> +            # 3GiB volume
> +            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0xc000000=
0, '3GB', mount_dir)
> +        except CalledProcessError as err:
> +            pytest.skip('Creating failed for filesystem: ' + fs_type + '=
. {}'.format(err))
> +            return
> +
>      except CalledProcessError as err:
>          pytest.skip('Setup failed for filesystem: ' + fs_type + '. {}'.f=
ormat(err))
> -        umount_fs(mount_dir)
>          return
>      else:
> -        umount_fs(mount_dir)
>          yield [fs_ubtype, fs_img, md5val]
>      finally:
> -        call('rmdir %s' % mount_dir, shell=3DTrue)
> +        call('rm -rf %s' % mount_dir, shell=3DTrue)
>          call('rm -f %s' % fs_img, shell=3DTrue)
>=20=20
>  #
> @@ -363,14 +293,6 @@ def fs_obj_ext(request, u_boot_config):
>      min_file =3D mount_dir + '/' + MIN_FILE
>      tmp_file =3D mount_dir + '/tmpfile'
>=20=20
> -    try:
> -
> -        # 128MiB volume
> -        fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '1=
28MB')
> -    except CalledProcessError as err:
> -        pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}=
'.format(err))
> -        return
> -
>      try:
>          check_call('mkdir -p %s' % mount_dir, shell=3DTrue)
>      except CalledProcessError as err:
> @@ -378,15 +300,6 @@ def fs_obj_ext(request, u_boot_config):
>          call('rm -f %s' % fs_img, shell=3DTrue)
>          return
>=20=20
> -    try:
> -        # Mount the image so we can populate it.
> -        mount_fs(fs_type, fs_img, mount_dir)
> -    except CalledProcessError as err:
> -        pytest.skip('Mounting to folder failed for filesystem: ' + fs_ty=
pe + '. {}'.format(err))
> -        call('rmdir %s' % mount_dir, shell=3DTrue)
> -        call('rm -f %s' % fs_img, shell=3DTrue)
> -        return
> -
>      try:
>          # Create a test directory
>          check_call('mkdir %s/dir1' % mount_dir, shell=3DTrue)
> @@ -427,15 +340,21 @@ def fs_obj_ext(request, u_boot_config):
>          md5val.append(out.split()[0])
>=20=20
>          check_call('rm %s' % tmp_file, shell=3DTrue)
> +
> +        try:
> +            # 128MiB volume
> +            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000=
, '128MB', mount_dir)
> +        except CalledProcessError as err:
> +            pytest.skip('Creating failed for filesystem: ' + fs_type + '=
. {}'.format(err))
> +            return
> +
>      except CalledProcessError:
>          pytest.skip('Setup failed for filesystem: ' + fs_type)
> -        umount_fs(mount_dir)
>          return
>      else:
> -        umount_fs(mount_dir)
>          yield [fs_ubtype, fs_img, md5val]
>      finally:
> -        call('rmdir %s' % mount_dir, shell=3DTrue)
> +        call('rm -rf %s' % mount_dir, shell=3DTrue)
>          call('rm -f %s' % fs_img, shell=3DTrue)
>=20=20
>  #
> @@ -461,7 +380,7 @@ def fs_obj_mkdir(request, u_boot_config):
>=20=20
>      try:
>          # 128MiB volume
> -        fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '1=
28MB')
> +        fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '1=
28MB', None)
>      except:
>          pytest.skip('Setup failed for filesystem: ' + fs_type)
>          return
> @@ -492,14 +411,6 @@ def fs_obj_unlink(request, u_boot_config):
>=20=20
>      mount_dir =3D u_boot_config.persistent_data_dir + '/mnt'
>=20=20
> -    try:
> -
> -        # 128MiB volume
> -        fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '1=
28MB')
> -    except CalledProcessError as err:
> -        pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}=
'.format(err))
> -        return
> -
>      try:
>          check_call('mkdir -p %s' % mount_dir, shell=3DTrue)
>      except CalledProcessError as err:
> @@ -507,15 +418,6 @@ def fs_obj_unlink(request, u_boot_config):
>          call('rm -f %s' % fs_img, shell=3DTrue)
>          return
>=20=20
> -    try:
> -        # Mount the image so we can populate it.
> -        mount_fs(fs_type, fs_img, mount_dir)
> -    except CalledProcessError as err:
> -        pytest.skip('Mounting to folder failed for filesystem: ' + fs_ty=
pe + '. {}'.format(err))
> -        call('rmdir %s' % mount_dir, shell=3DTrue)
> -        call('rm -f %s' % fs_img, shell=3DTrue)
> -        return
> -
>      try:
>          # Test Case 1 & 3
>          check_call('mkdir %s/dir1' % mount_dir, shell=3DTrue)
> @@ -538,15 +440,20 @@ def fs_obj_unlink(request, u_boot_config):
>          check_call('dd if=3D/dev/urandom of=3D%s/dir5/file1 bs=3D1K coun=
t=3D1'
>                                      % mount_dir, shell=3DTrue)
>=20=20
> +        try:
> +            # 128MiB volume
> +            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000=
, '128MB', mount_dir)
> +        except CalledProcessError as err:
> +            pytest.skip('Creating failed for filesystem: ' + fs_type + '=
. {}'.format(err))
> +            return
> +
>      except CalledProcessError:
>          pytest.skip('Setup failed for filesystem: ' + fs_type)
> -        umount_fs(mount_dir)
>          return
>      else:
> -        umount_fs(mount_dir)
>          yield [fs_ubtype, fs_img]
>      finally:
> -        call('rmdir %s' % mount_dir, shell=3DTrue)
> +        call('rm -rf %s' % mount_dir, shell=3DTrue)
>          call('rm -f %s' % fs_img, shell=3DTrue)
>=20=20
>  #
> @@ -575,14 +482,6 @@ def fs_obj_symlink(request, u_boot_config):
>      small_file =3D mount_dir + '/' + SMALL_FILE
>      medium_file =3D mount_dir + '/' + MEDIUM_FILE
>=20=20
> -    try:
> -
> -        # 1GiB volume
> -        fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x40000000, '=
1GB')
> -    except CalledProcessError as err:
> -        pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}=
'.format(err))
> -        return
> -
>      try:
>          check_call('mkdir -p %s' % mount_dir, shell=3DTrue)
>      except CalledProcessError as err:
> @@ -590,15 +489,6 @@ def fs_obj_symlink(request, u_boot_config):
>          call('rm -f %s' % fs_img, shell=3DTrue)
>          return
>=20=20
> -    try:
> -        # Mount the image so we can populate it.
> -        mount_fs(fs_type, fs_img, mount_dir)
> -    except CalledProcessError as err:
> -        pytest.skip('Mounting to folder failed for filesystem: ' + fs_ty=
pe + '. {}'.format(err))
> -        call('rmdir %s' % mount_dir, shell=3DTrue)
> -        call('rm -f %s' % fs_img, shell=3DTrue)
> -        return
> -
>      try:
>          # Create a subdirectory.
>          check_call('mkdir %s/SUBDIR' % mount_dir, shell=3DTrue)
> @@ -621,15 +511,20 @@ def fs_obj_symlink(request, u_boot_config):
>              % medium_file, shell=3DTrue).decode()
>          md5val.extend([out.split()[0]])
>=20=20
> +        try:
> +            # 1GiB volume
> +            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x4000000=
0, '1GB', mount_dir)
> +        except CalledProcessError as err:
> +            pytest.skip('Creating failed for filesystem: ' + fs_type + '=
. {}'.format(err))
> +            return
> +
>      except CalledProcessError:
>          pytest.skip('Setup failed for filesystem: ' + fs_type)
> -        umount_fs(mount_dir)
>          return
>      else:
> -        umount_fs(mount_dir)
>          yield [fs_ubtype, fs_img, md5val]
>      finally:
> -        call('rmdir %s' % mount_dir, shell=3DTrue)
> +        call('rm -rf %s' % mount_dir, shell=3DTrue)
>          call('rm -f %s' % fs_img, shell=3DTrue)
>=20=20
>  #
> @@ -665,7 +560,7 @@ def fs_obj_fat(request, u_boot_config):
>=20=20
>      try:
>          # the volume size depends on the filesystem
> -        fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, fs_size, f'{f=
s_size}', 1024)
> +        fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, fs_size, f'{f=
s_size}', None, 1024)
>      except:
>          pytest.skip('Setup failed for filesystem: ' + fs_type)
>          return
> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> index 05e1583059..3cef6c29fa 100644
> --- a/test/py/tests/test_ut.py
> +++ b/test/py/tests/test_ut.py
> @@ -538,8 +538,8 @@ def test_ut_dm_init(u_boot_console):
>          u_boot_utils.run_and_log(
>              u_boot_console, f'sfdisk {fn}', stdin=3Db'type=3D83')
>=20=20
> -    fs_helper.mk_fs(u_boot_console.config, 'ext2', 0x200000, '2MB')
> -    fs_helper.mk_fs(u_boot_console.config, 'fat32', 0x100000, '1MB')
> +    fs_helper.mk_fs(u_boot_console.config, 'ext2', 0x200000, '2MB', None)
> +    fs_helper.mk_fs(u_boot_console.config, 'fat32', 0x100000, '1MB', Non=
e)
>=20=20
>      mmc_dev =3D 6
>      fn =3D os.path.join(u_boot_console.config.source_dir, f'mmc{mmc_dev}=
.img')
> --=20
> 2.35.3
