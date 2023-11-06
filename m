Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF202C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 11:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF13586FE5;
	Mon,  6 Nov 2023 12:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="As00ozIk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E397A86FF2; Mon,  6 Nov 2023 12:23:03 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A35886BA8
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 12:23:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ba54c3ed97so4489677b3a.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 03:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699269778; x=1699874578; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZLuklwxAS4bFbK0LxxWkqOLNFhUazwAfnD/9SVIF5nc=;
 b=As00ozIkM2DKHF2er8DbDds25Og6GnZ2mCxzxKs+7eTiDspuyn/ADLEr6UaE5AMb/z
 lPs4OEVaEd2n0IWuBW5MPuhDj2yHE+0s0yvGVuBHfy80eHKTnh9wBzkWV+OwJCicHzzj
 WRh47FcHCCiLgItdwEE5XTDjkxJf8ho0sUlrVyzxwF5Nez0Db9rp1L61aj+62i12L69P
 2+SiOKvs2cT1ezOAx5qQn3a4N1cWB1t3asHmm7gMD3yG0uELEqzP1f9f5K+yIJ+I+w/x
 3adFAt+8JQMAh5jOcDiIC2td0iSMjpoy3IIgHkAdiheQiS+PPDonE3KB9u7xuVDFM1+7
 jENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699269778; x=1699874578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZLuklwxAS4bFbK0LxxWkqOLNFhUazwAfnD/9SVIF5nc=;
 b=upgZtOJq1R9OtaYIMZB3NBTX28udVnmgxJfmOvVQr/Asbk5ssnAOLjUlwaTf51HbI1
 xqjQScmKD9QB82mYsAuqaTVH1Upe1hLrWHocTwrRqJqolb2tl6PnjLWihmzNlKOFeXfv
 JaBuJKVrVJGwjK1Vldd6gnwrl3v0kE9RH8q6+UQdY0DdvFSBhhKzou5xCoJbXWnq3Ikb
 mRw3neeM3Q4KNBVgOmRW4jd90CKbwUgUQn9GpSfRyjoY1+SJluQf0HpfG0W9qm7PU2Do
 ePzZho+U36v0XHqgTE5keI/aH4oFQ3LrK1oOclWFw7mDG2bMVT+Re+AafvuS7k915OiB
 7raA==
X-Gm-Message-State: AOJu0YzppHKqyaFuD5f51CTCEqG6qTy3CJnxuiRomlDBE6oCQ1YMA4tf
 TiVVE4FYEzYwT/jOed+6EfxNH8VJNWYbEXkLOsr3wXJEE9SdtAEV
X-Google-Smtp-Source: AGHT+IEeoTxniMfNzNb+hA34n0+vj3qa5p8SgQcham/6xJU9cCMsoRFk9pjpMp+0ijt9O5z0NCK7bCXB3GWOJ8XCOeA=
X-Received: by 2002:a05:6a21:7189:b0:183:c7ea:bb52 with SMTP id
 wq9-20020a056a21718900b00183c7eabb52mr6842772pzb.30.1699269778191; Mon, 06
 Nov 2023 03:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20231106111504.3631058-1-masahisa.kojima@linaro.org>
In-Reply-To: <20231106111504.3631058-1-masahisa.kojima@linaro.org>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Mon, 6 Nov 2023 20:22:47 +0900
Message-ID: <CADQ0-X-+U_hyn_0TQcZTgG2By-roUfdXJ=gQa_kACNUwrDYWVQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] Add EFI HTTP boot support
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Michal Simek <michal.simek@amd.com>
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

Sorry but I had trouble in send-email, let me re-send this series.

Regards,
Masahisa Kojima

On Mon, 6 Nov 2023 at 20:16, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
>
> This series adds the EFI HTTP boot support.
> User can add the URI device path with "efidebug boot add" command.
> efibootmgr handles the URI device path, download the
> specified file using wget, mount the downloaded image with
> blkmap, then boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI)
> by selecting automatically created boot option when the new disk is
> detected.
>
> This version still does not include the test.
>
> To enable EFI HTTP boot, we need to enable the following Kconfig options.
>  CONFIG_CMD_DNS
>  CONFIG_CMD_WGET
>  CONFIG_BLKMAP
>  CONFIG_EFI_HTTP_BOOT
>
> On the Socionext Developerbox, enter the following commands then
> debian installer is downloaded into "loadaddr" and installer
> automatically starts.
>  => dhcp
>  => setenv serverip 192.168.1.1
>  => efidebug boot add -u 3 debian-netinst http://ftp.riken.jp/Linux/debian/debian-cd/12.1.0/arm64/iso-cd/debian-12.1.0-arm64-netinst.iso
>  => efidebug boot order 3
>  => bootefi bootmgr
>
> Note that this debian installer can not proceed the installation
> bacause RAM disk of installer image is not recogniged by the kernel.
> I'm still investigating this issue, but drivers/nvdimm/of_pmem.c in linux
> will be one of the solution to recognize RAM disk from kernel.
> (In EDK2, the equivalent solution is called ACPI NFIT.)
>
> On QEMU, I can not make DNS work from the QEMU guest.
> The following commands work on qemu_arm64(manually set the http server ip in URI).
>   => dhcp
>   => setenv gatewayip 10.0.2.2
>   => setenv httpserverip 134.160.38.1
>   => efidebug boot add -u 3 debian-netinst http://134.160.38.1/Linux/debian/debian-cd/12.1.0/arm64/iso-cd/debian-12.1.0-arm64-netinst.iso
>   => efidebug boot order 3
>   => bootefi bootmgr
>
> [TODO]
> - add test
> - stricter wget uri check
> - omit the dns process if the given uri has ip address
>    -> this will be supported when the lwip migration completes
> - uri device path support in eficonfig
> - expose ramdisk to OS
>
> [change log]
> v9 -> v10
> - fix failure in erofs python test
> - refactor try_load_from_uri_path(), call efi_load_image() in single location
> - missing free of file_path for EFI application
> - fix blkmap_create_ramdisk() size type from int to ulong
>
> v8 -> v9
> - implement new EFI event to notify that loaded image returns
>   and back to the efibootmgr
> - ramdisk cleanup is done in event callback
> - refactor error handling
>
> v7 -> v8
> - search the default file on the fly, instead of creating
>   the boot option with default file
> - delete blkmap and reserved memory in case of error or
>   when the EFI application returns
> - update the subject "Boot var automatic management for removable medias"
>   since this automatic boot option management is also applied
>   for non-removable medias
> - update error handling in efidebug command
> - call efi_add_memory_map() instead of exposing efi_reserve_memory()
>
> v6 -> v7
> - rename the funtion name from load_default_file_boot_option()
>   to load_mounted_image()
> - move some fix from patch #5 "efi_loader: support boot from URI device path" to
>   patch #4 "efi_loader: create default file boot option".
> - fix missing free() of default_file_path
>
> v5 -> v6
> - add patch #4 "Boot var automatic management for removable medias"
> - boot from automatically created boot option
>   rather than searching default file on the fly
> - introduce new CONFIG_EFI_HTTP_BOOT Kconfig option
> - comment in one place
> - use log_err() rather than printf()
> - use env_get_hex("filesize", 0) instead of return value of net_loop()
> - use more suitable error code
> - blkmap can be build for SPL/TPL
> - add CDROM short-form device path support
>
> v4 -> v5
> - add missing else statement
> - add NULL check of efi_dp_find_obj() call
> - update document to remove "limitation"
>
> v3 -> v4
> - patch#8 is added to simplify the bootmgr default boot process
> - add function comments
>
> v2 -> v3
> - Patch#6 is added, reserve the whole ramdisk memory region
> - remove .efi file extension check for PE-COFF image
> - use "if IS_ENABLED(..)" as much as possible
> - 1024 should be sizeof(net_boot_file_name)
> - call net_set_state(NETLOOP_FAIL) when wget encounters error
> - describe DNS ip address host name limitation in document
>
> v1 -> v2
> - carve out the network handling(wget and dns code) under net/wget.c
> - carve out ramdisk creation code under drivers/block/blkmap_helper.c
> - wget supports the valid range check to store the received blocks using lmb
> - support when the downloaded image have no partiton table but a file system
> - not start the .efi file in try_load_entry()
> - call efi_check_pe() for .efi file to check the file is PE-COFF image
> - add documentation for EFI HTTP Boot
>
> Masahisa Kojima (8):
>   net: wget: prevent overwriting reserved memory
>   net: wget: add wget with dns utility function
>   blk: blkmap: add ramdisk creation utility function
>   efi_loader: add missing const classifier for event service
>   efi_loader: add return to efibootmgr event group
>   efi_loader: support boot from URI device path
>   cmd: efidebug: add uri device path
>   doc: uefi: add HTTP Boot support
>
> Raymond Mao (1):
>   efi_loader: Boot var automatic management
>
>  cmd/bootefi.c                                 |  12 +
>  cmd/efidebug.c                                |  51 +++
>  doc/develop/uefi/uefi.rst                     |  30 ++
>  drivers/block/Makefile                        |   3 +-
>  drivers/block/blkmap.c                        |  15 -
>  drivers/block/blkmap_helper.c                 |  53 +++
>  include/blkmap.h                              |  29 ++
>  include/efi_api.h                             |   5 +-
>  include/efi_loader.h                          |   4 +-
>  include/net.h                                 |  17 +
>  lib/efi_loader/Kconfig                        |   9 +
>  lib/efi_loader/efi_bootmgr.c                  | 337 ++++++++++++++++++
>  lib/efi_loader/efi_boottime.c                 |   7 +-
>  lib/efi_loader/efi_disk.c                     |  18 +
>  lib/efi_loader/efi_setup.c                    |   7 +
>  net/wget.c                                    | 205 ++++++++++-
>  test/py/tests/test_efi_secboot/test_signed.py |  42 +--
>  .../test_efi_secboot/test_signed_intca.py     |  14 +-
>  .../tests/test_efi_secboot/test_unsigned.py   |  14 +-
>  test/py/tests/test_fs/test_erofs.py           |   9 +
>  .../test_fs/test_squashfs/test_sqfs_ls.py     |   9 +
>  21 files changed, 828 insertions(+), 62 deletions(-)
>  create mode 100644 drivers/block/blkmap_helper.c
>
> --
> 2.34.1
>
