Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC90ACD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD6EA83EEF;
	Mon,  8 Jun 2026 10:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QHv+8X4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F31383EEF; Mon,  8 Jun 2026 10:49:57 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 263BF807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E589D6001D;
 Mon,  8 Jun 2026 08:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85F41F00893;
 Mon,  8 Jun 2026 08:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780908593;
 bh=FYOxyc6Tnu5Fm2Um1IZiuEIeE3nuwiFTS/vajs9Pw7w=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=QHv+8X4gs99ejmPr2Rb7SMe0C6fdyF7pia+UuouzE+Ah8S/4fsOfNy7Sm4N+BBe4b
 VJMQKN8VZZDJoJTqxwSLo+DwkrjzcuKPbXdvmm2wHUPXSNZ194eyXpiRlZvFR/KJau
 dNxOyviDlezDopJlQtOgPX13hVAbh0Cpk6U0etqhAEJyO17Xhr7GN8k3FvcKL5NfG1
 3whQRu1EX8aRhVX3r/TBMGq7+w1nBGC5+cPB3Y2N6q7lNe7aIpJ8HKPyM7qZHcCvJs
 eTgA4SAndTxnub/qeMqfzSCCzQRGtuzTzKSXjIBdxkPdqvN2Qlc4nWZ4ulxD4EkTZx
 VItnTESXTk07Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 11/11] test: Move disk images to persistent-data
 directory
In-Reply-To: <20260523085455.750591-12-sjg@chromium.org>
References: <20260523085455.750591-1-sjg@chromium.org>
 <20260523085455.750591-12-sjg@chromium.org>
Date: Mon, 08 Jun 2026 10:49:51 +0200
Message-ID: <87ik7txvps.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Simon,

Thank you for the patch.

On Sat, May 23, 2026 at 02:54, Simon Glass <sjg@chromium.org> wrote:

> It is annoying to have disk images in the source directory since it
> clutters up the working space.
>
> Remove cur_dir=True from DiskHelper calls so disk images are written to
> the persistent-data directory instead.
>
> Move scsi.img too (used by the bootstd tests) and mmc6.img (used by the
> MBR tests).
>
> Add a few comments as to where the images are used.
>
> This keeps the source tree clean and puts disk images in the same place
> as other test data.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

I've re-ran the following using this series:
$ git clean -xdf
$ python3 -m venv venv && . venv/bin/activate && pip install -r test/py/requirements.txt && pip install setuptools && ./test/py/test.py --bd sandbox --build -k ut

Then, if I check the source folder, I still see some disk images:
$ ls *.img
mmc10.img  mmc1.img  mmc5.img  mmc7.img  mmc8.img  mmc9.img

Also see:

$ find -name '*.img'
./build-sandbox/persistent-data/test_efi_capsule.vfat.img
./build-sandbox/persistent-data/scsi.img
./build-sandbox/persistent-data/2MB.ext2.img
./build-sandbox/persistent-data/1MB.fat32.img
./build-sandbox/persistent-data/mmc6.img
./build-sandbox/persistent-data/mmc.vfat.tmp/initramfs-5.3.7-301.fc31.armv7hl.img
./build-sandbox/persistent-data/mmc1.img
./build-sandbox/persistent-data/mmc4.img
./build-sandbox/persistent-data/bootv4.img
./build-sandbox/persistent-data/vendor_boot.img
./build-sandbox/persistent-data/boot.img
./build-sandbox/persistent-data/flash1.img
./build-sandbox/bootv4.img
./build-sandbox/vendor_boot.img
./build-sandbox/boot.img
./mmc1.img
./mmc9.img
./mmc5.img
./mmc7.img
./mmc8.img
./mmc10.img

Is there a reason for not moving all the images?

I think that for this patch, we should at least ensure that all the
mmc*.img are moved.

For example, mmc7.img and mmc8.img are used by Android and I believe
they should be in build-sandbox/persistent-data/ as well.

> ---
>
> (no changes since v1)
>
>  test/py/img/common.py    |  2 +-
>  test/py/img/efi.py       |  2 +-
>  test/py/img/script.py    |  2 +-
>  test/py/tests/test_ut.py | 11 +++++++----
>  4 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/test/py/img/common.py b/test/py/img/common.py
> index 301b6c840d4..a2c86c5c282 100644
> --- a/test/py/img/common.py
> +++ b/test/py/img/common.py
> @@ -74,7 +74,7 @@ def make_extlinux_disk(ubman, devnum, basename, vmlinux, initrd, dtbdir,
>  
>      fsh.mk_fs()
>  
> -    img = DiskHelper(ubman.config, devnum, basename, True)
> +    img = DiskHelper(ubman.config, devnum, basename)
>      img.add_fs(fsh, DiskHelper.VFAT, bootable=True)
>  
>      ext4 = FsHelper(ubman.config, 'ext4', 1, prefix=basename)
> diff --git a/test/py/img/efi.py b/test/py/img/efi.py
> index 4cb0bb95a59..06fda8a90b2 100644
> --- a/test/py/img/efi.py
> +++ b/test/py/img/efi.py
> @@ -31,7 +31,7 @@ def setup_efi_image(ubman):
>  
>      fsh.mk_fs()
>  
> -    img = DiskHelper(ubman.config, devnum, 'flash', True)
> +    img = DiskHelper(ubman.config, devnum, 'flash')
>      img.add_fs(fsh, DiskHelper.VFAT)
>      img.create()
>      fsh.cleanup()
> diff --git a/test/py/img/script.py b/test/py/img/script.py
> index e6072bf5bd9..5c0c9e99183 100644
> --- a/test/py/img/script.py
> +++ b/test/py/img/script.py
> @@ -126,7 +126,7 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
>          ubman, f'echo here {kernel} {symlink}')
>      os.symlink(kernel, symlink)
>      fsh.mk_fs()
> -    img = DiskHelper(ubman.config, mmc_dev, 'mmc', True)
> +    img = DiskHelper(ubman.config, mmc_dev, 'mmc')
>      img.add_fs(fsh, DiskHelper.EXT4)
>      img.create()
>      fsh.cleanup()
> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> index 38fec6cf8a2..9c938943259 100644
> --- a/test/py/tests/test_ut.py
> +++ b/test/py/tests/test_ut.py
> @@ -32,7 +32,8 @@ from img.cedit import setup_cedit_file
>  def test_ut_dm_init(ubman):
>      """Initialize data for ut dm tests."""
>  
> -    fn = ubman.config.source_dir + '/testflash.bin'
> +    # This is used by flash-stick@0 in test.py
> +    fn = ubman.config.persistent_data_dir + '/testflash.bin'
>      if not os.path.exists(fn):
>          data = b'this is a test'
>          data += b'\x00' * ((4 * 1024 * 1024) - len(data))
> @@ -45,8 +46,8 @@ def test_ut_dm_init(ubman):
>          with open(fn, 'wb') as fh:
>              fh.write(data)
>  
> -    # Create a file with a single partition
> -    fn = ubman.config.source_dir + '/scsi.img'
> +    # Create a file with a single partition (used by /scsi in test.dts) */
> +    fn = ubman.config.persistent_data_dir + '/scsi.img'
>      if not os.path.exists(fn):
>          data = b'\x00' * (2 * 1024 * 1024)
>          with open(fn, 'wb') as fh:
> @@ -54,11 +55,13 @@ def test_ut_dm_init(ubman):
>          utils.run_and_log(
>              ubman, f'sfdisk {fn}', stdin=b'type=83')
>  
> +    # These two are used by test/dm/host.c
>      FsHelper(ubman.config, 'ext2', 2, '2MB').mk_fs()
>      FsHelper(ubman.config, 'fat32', 1, '1MB').mk_fs()
>  
> +    # This is used by test/cmd/mbr.c
>      mmc_dev = 6
> -    fn = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
> +    fn = os.path.join(ubman.config.persistent_data_dir, f'mmc{mmc_dev}.img')
>      data = b'\x00' * (12 * 1024 * 1024)
>      with open(fn, 'wb') as fh:
>          fh.write(data)
> -- 
> 2.43.0
