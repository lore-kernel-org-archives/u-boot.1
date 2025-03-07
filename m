Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EA8C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 14:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C85B808A2;
	Fri,  7 Mar 2025 15:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OibrHRf2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F20B680E94; Fri,  7 Mar 2025 15:15:49 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50BC7803CC
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 15:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6fece18b3c8so346487b3.3
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 06:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741356944; x=1741961744; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ePx33zBWy2YB6hNkElD57TecPyKyGzaVj38EzewzvoY=;
 b=OibrHRf2+jUw4JVYi/yiF1nCtnfxKyRKD0XTIdK0enzAS46F4Rz9A5AXe9VeLJ34w0
 FSGYCTNRs/8+ptgWNFWJpuTRSX3evMse3cLWLdLTIxI5NL0DjiY0yNEh7Yi7yqnuFbau
 nYH5gUQtFFJSGPkBaRaVTDGE7zX/oodgziorM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741356944; x=1741961744;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePx33zBWy2YB6hNkElD57TecPyKyGzaVj38EzewzvoY=;
 b=mJgF3VnIcXmr2bR7jK0Uoa396Xkt+W5Inqvm4es3ns7dDfVlRWHX+4rW4xJ9+BLRA3
 jWCKjx5MsusHfopyIDAka5kEoAYBwxDtn7EY6O+8trtwzbSPiJ+bVDxuJ44QSe3I0yIh
 Xdji9J1FUAEBFH3gL6AibIra8jN68adecL3qsM2G808TASy4S+Zn9lG1iGuX4Qt7E/gf
 hTBbZjfSefcAfwDKB9D41pqNqkHPRhQdaFTPJJT4nUWCkhQOdmHuBxOF/jR6p5ZaMu16
 aPMXFNQTcBDwM/wx4tvSIeH8Ai+1vaWG0S795Kq62mqUVmibzFXfCYAr4o2x0Hwdw/yM
 iAiQ==
X-Gm-Message-State: AOJu0YwDtV3iD99t6HLt9wsmov+ybORPzBy2VYk6caYQv0O9LAqSA9K/
 OrWvkO7iuVSUwKRgBhxMA8+4mAUAWf6MTksZmKps6vOJahJg4Yy3RUXS4mm0yqU=
X-Gm-Gg: ASbGncuVlDYSWhCzF+/gUGrkrO0TLyWxDGIhJxtD7CWQTcT1Nq1rNvt6G4B2CHjHD+l
 yfk2jDPet4Xs29dGpRGruKQkCalTpkDs1jpgev+PqaKx6pVV94iIA76sZBZsgSpjCxgcoup43Ba
 2G5fslprtnvAhu9C5drRmIQx8dTauE+7D1ejiElFkqktg1HrkaoWOBw7R8n5ruO398QlLPF9k6L
 3VDHElvdI9ydvWDP37k5WjqjkqHmF3HQakp0/vlbBCsSMgtMqnwqjEXqlgtMGwejBiNkV2SmVSc
 Kkc9ky3K9bnrg0DLqJY7YNCqRKeH5j9zYKH4bJxy5qvn8g==
X-Google-Smtp-Source: AGHT+IG56MkOgByxMpbB40IKrESMz8bqrUJrrIXuD2LQgJNhJwE6n5L0U2q1oTQQxlfUtLLYcDu6JQ==
X-Received: by 2002:a05:690c:46c9:b0:6fd:41d5:de11 with SMTP id
 00721157ae682-6febf3836e2mr47386987b3.23.1741356944089; 
 Fri, 07 Mar 2025 06:15:44 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e634b73607dsm839613276.5.2025.03.07.06.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 06:15:43 -0800 (PST)
Date: Fri, 7 Mar 2025 08:15:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v4 29/47] test/py: Correct sizing of created disks
Message-ID: <20250307141540.GI2640854@bill-the-cat>
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250306160428.3041057-30-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/tj6M0OW+x9EqrPm"
Content-Disposition: inline
In-Reply-To: <20250306160428.3041057-30-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--/tj6M0OW+x9EqrPm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 09:03:56AM -0700, Simon Glass wrote:

> At present the disks end up being 1MB shorter than they should be,
> since dd truncates by default.
>=20
> Move the code into a function and update it to avoid truncation.
>=20
> This resolves various warnings when running sandbox tests, of the form:
>=20
>    mmc_bread() MMC: block number 0x9801 exceeds max(0x9800)
>=20
> caused by the FAT partition being scanning.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v3)
>=20
> Changes in v3:
> - Add new patch to correct sizing of created disks
>=20
>  test/py/tests/test_ut.py | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> index ea0c43cd4fc..b8adb597e11 100644
> --- a/test/py/tests/test_ut.py
> +++ b/test/py/tests/test_ut.py
> @@ -57,6 +57,17 @@ def setup_image(ubman, devnum, part_type, img_size=3D2=
0, second_part=3DFalse,
>                               stdin=3Dspec.encode('utf-8'))
>      return fname, mnt
> =20
> +def copy_partition(ubman, fsfile, outname):
> +    """Copy a partition into a disk iamge
> +
> +    Args:
> +        ubman (ConsoleBase): U-Boot fixture
> +        fsfile (str): Name of partition file
> +        outname (str): Name of full-disk file to update
> +    """
> +    utils.run_and_log(ubman,
> +                      f'dd if=3D{fsfile} of=3D{outname} bs=3D1M seek=3D1=
 conv=3Dnotrunc')

Ah, interesting.

> +
>  def setup_bootmenu_image(ubman):
>      """Create a 20MB disk image with a single ext4 partition
> =20
> @@ -172,7 +183,7 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
>      fsfile =3D 'ext18M.img'
>      utils.run_and_log(ubman, f'fallocate -l 18M {fsfile}')
>      utils.run_and_log(ubman, f'mkfs.ext4 {fsfile} -d {mnt}')
> -    utils.run_and_log(ubman, f'dd if=3D{fsfile} of=3D{fname} bs=3D1M see=
k=3D1')
> +    copy_partition(ubman, fsfile, fname)
>      utils.run_and_log(ubman, f'rm -rf {mnt}')
>      utils.run_and_log(ubman, f'rm -f {fsfile}')
> =20
> @@ -224,7 +235,7 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc3=
1.armv7hl)
>      utils.run_and_log(ubman, f'fallocate -l 18M {fsfile}')
>      utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
>      utils.run_and_log(ubman, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::=
/'])
> -    utils.run_and_log(ubman, f'dd if=3D{fsfile} of=3D{fname} bs=3D1M see=
k=3D1')
> +    copy_partition(ubman, fsfile, fname)
>      utils.run_and_log(ubman, f'rm -rf {mnt}')
>      utils.run_and_log(ubman, f'rm -f {fsfile}')
> =20
> @@ -562,7 +573,7 @@ def setup_efi_image(ubman):
>      utils.run_and_log(ubman, f'fallocate -l 18M {fsfile}')
>      utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
>      utils.run_and_log(ubman, ['sh', '-c', f'mcopy -vs -i {fsfile} {mnt}/=
* ::/'])
> -    utils.run_and_log(ubman, f'dd if=3D{fsfile} of=3D{fname} bs=3D1M see=
k=3D1')
> +    copy_partition(ubman, fsfile, fname)
>      utils.run_and_log(ubman, f'rm -rf {mnt}')
>      utils.run_and_log(ubman, f'rm -f {fsfile}')

It's on my TODO list to make all of these use the mk_fs helper instead,
I noticed this yesterday or the day before.

--=20
Tom

--/tj6M0OW+x9EqrPm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfK/4gACgkQFHw5/5Y0
tyyrewv/SiOiUiJYgLoWZwroAZ7LitGdrboVCstAz38AS3tPEXLxoVYcP8IN+db5
DgJGZR/8H+ahdn7OB2QD+B0SQ3PxkMS7xibUbf2z5sKwVIMwGOV4Bm3ud2/B5sO7
4iUwkRy4nmNmIHdgUK505QM8VXfaFuMWpOBlB1UmRS+cw9dYGOi1kyuJlw3SFTp6
jgbqn/FYIIIA3UWVfA4OwLX99Mt8iwdMVlOAzAc+tj7ZGBdnRUo1kvg+pKNZwTQL
59nkVaGPVoVd7czH7FZRoCavhHzfvbGdJ62R1C/71WY3QZNeBNq5tsNWsqexw/+B
1t3Sf6MmY/EMkRtOzK5SZ4AuyjN9b0v54EHjn7eQrLNwsV66M6/tnjFJAJGH+sXu
ITchDBrk/PGOzipnaESqo3ek7EtYFzoMr5/OfCvBeRSlYm5jP3tbjHg0Oi7Bipb+
PYNk3oD/8SljFJXUdtD36qgkBTdbnya1gP9YlZ6QG9KkzIFw0jN9HGUu7lZgJlA+
z5gUyH7r
=Ehgl
-----END PGP SIGNATURE-----

--/tj6M0OW+x9EqrPm--
