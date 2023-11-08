Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66ABC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 11:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4583874BD;
	Wed,  8 Nov 2023 12:07:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZVyb8Wb7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D29E874DC; Wed,  8 Nov 2023 12:07:44 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A3C68746A
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 12:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3b2ec5ee2e4so3879792b6e.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 03:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699441659; x=1700046459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qny8G975tb38Qcf6cYx0LoCdUxB1soNN93mo80t34CI=;
 b=ZVyb8Wb7Pd+g8kWCmhsucmsuz7Htx3KWSLDvWU0uSdHc/vhEqlD1+nFqqbSvpRqcG7
 aYO44zxA4YphNf8IG8DhS/W0OedvxTd5S/ma7hHLjBco0EvsSlrXpEgUAusA9lFsIJRg
 QnnBMiEiY+0ZFrRzQnGJ+DsVnoXZn1JTyCfxAcEonRXmCW3vHhWZje3lnOwhW2EKYzHK
 yuOn3YGwjNyS0gibrMJSq8AZdSRXQ/qiF62S61eNLPbZrViIzch8fqqx/KbYbC51Ru3b
 aRVMgCpi8uv88ipTuP6hOPGvRHTrfAAuncsyNlINa+20KwsQxlcz64fEU5Lm9izhdzNE
 NZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699441659; x=1700046459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qny8G975tb38Qcf6cYx0LoCdUxB1soNN93mo80t34CI=;
 b=q0c5KEdSBRofAbpH8hlqSKoK8QfcHTXG/7gZoRzeSK90vH06Hj79+JZg0ihnL0j1GN
 eHkejWWJ19FYN/PaLEaXM4nUuRRiSjT0/IavwbRrZX0z2VNv6NyDU9T8JZaxPTRFgY2D
 N5Xeqp7NXtRXTuECN5qM+SNAQCwkbBriTfd8/RKZn+pmtQa1mMHaORj8b4itzhngb3tb
 gRAYcWQGW08qtucvumO1aQHZz0Vj/COWRCDxIBi7Nk/cf7dV5Fv6saLI7svOYXKHT40G
 hBRZb8sBV76XH8JZWy/5zP/q5AZPcStzcvSQorYxij+CrDed/va9PYVKyUmJBkRGMMAp
 7vAg==
X-Gm-Message-State: AOJu0YyVN6g0eyL1+v2gKTe1rUwSZAvkwka3ZhuOGlDk5dG2bfTvlHYR
 ih00g0eY0d9THRne5NmonayvUIAkqH1WURDb/2c=
X-Google-Smtp-Source: AGHT+IFvDrhb8QNTQH6vtn3Ja0ftQezRTfDDFGd5lRFN7PkqtzCJ7OHAWFhCSD0LCa6RsBbzjfH7hA==
X-Received: by 2002:aca:2816:0:b0:3a7:1e3e:7f97 with SMTP id
 22-20020aca2816000000b003a71e3e7f97mr1672562oix.4.1699441659457; 
 Wed, 08 Nov 2023 03:07:39 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 u17-20020a056a00125100b0069102aa1918sm8680455pfi.48.2023.11.08.03.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 03:07:38 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v11 0/9]  Add EFI HTTP boot support
Date: Wed,  8 Nov 2023 20:06:27 +0900
Message-Id: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

This series adds the EFI HTTP boot support.
User can add the URI device path with "efidebug boot add" command.
efibootmgr handles the URI device path, download the
specified file using wget, mount the downloaded image with
blkmap, then boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI)
by selecting automatically created boot option when the new disk is
detected.

This version still does not include the test.

To enable EFI HTTP boot, we need to enable the following Kconfig options.
 CONFIG_CMD_DNS
 CONFIG_CMD_WGET
 CONFIG_BLKMAP
 CONFIG_EFI_HTTP_BOOT

On the Socionext Developerbox, enter the following commands then
debian installer is downloaded into "loadaddr" and installer
automatically starts.
 => dhcp
 => setenv serverip 192.168.1.1
 => efidebug boot add -u 3 debian-netinst http://ftp.riken.jp/Linux/debian/debian-cd/12.1.0/arm64/iso-cd/debian-12.1.0-arm64-netinst.iso
 => efidebug boot order 3
 => bootefi bootmgr

Note that this debian installer can not proceed the installation
bacause RAM disk of installer image is not recogniged by the kernel.
I'm still investigating this issue, but drivers/nvdimm/of_pmem.c in linux
will be one of the solution to recognize RAM disk from kernel.
(In EDK2, the equivalent solution is called ACPI NFIT.)

On QEMU, I can not make DNS work from the QEMU guest.
The following commands work on qemu_arm64(manually set the http server ip in URI).
  => dhcp
  => setenv gatewayip 10.0.2.2
  => setenv httpserverip 134.160.38.1
  => efidebug boot add -u 3 debian-netinst http://134.160.38.1/Linux/debian/debian-cd/12.1.0/arm64/iso-cd/debian-12.1.0-arm64-netinst.iso
  => efidebug boot order 3
  => bootefi bootmgr

[TODO]
- add test
- stricter wget uri check
- omit the dns process if the given uri has ip address
   -> this will be supported when the lwip migration completes
- uri device path support in eficonfig
- expose ramdisk to OS

[change log]
v10 -> v11
only #7 "efi_loader: support boot from URI device path" is updated
- remove duplicate code by calling expand_media_path()
- remove global variables, use uridp context structure
- uninstall device_path protocol when the efi application returns

v9 -> v10
- fix failure in erofs python test
- refactor try_load_from_uri_path(), call efi_load_image() in single location
- missing free of file_path for EFI application
- fix blkmap_create_ramdisk() size type from int to ulong

v8 -> v9
- implement new EFI event to notify that loaded image returns
  and back to the efibootmgr
- ramdisk cleanup is done in event callback
- refactor error handling

v7 -> v8
- search the default file on the fly, instead of creating
  the boot option with default file
- delete blkmap and reserved memory in case of error or
  when the EFI application returns
- update the subject "Boot var automatic management for removable medias"
  since this automatic boot option management is also applied
  for non-removable medias
- update error handling in efidebug command
- call efi_add_memory_map() instead of exposing efi_reserve_memory()

v6 -> v7
- rename the funtion name from load_default_file_boot_option()
  to load_mounted_image()
- move some fix from patch #5 "efi_loader: support boot from URI device path" to
  patch #4 "efi_loader: create default file boot option".
- fix missing free() of default_file_path

v5 -> v6
- add patch #4 "Boot var automatic management for removable medias"
- boot from automatically created boot option
  rather than searching default file on the fly
- introduce new CONFIG_EFI_HTTP_BOOT Kconfig option
- comment in one place
- use log_err() rather than printf()
- use env_get_hex("filesize", 0) instead of return value of net_loop()
- use more suitable error code
- blkmap can be build for SPL/TPL
- add CDROM short-form device path support

v4 -> v5
- add missing else statement
- add NULL check of efi_dp_find_obj() call
- update document to remove "limitation"

v3 -> v4
- patch#8 is added to simplify the bootmgr default boot process
- add function comments

v2 -> v3
- Patch#6 is added, reserve the whole ramdisk memory region
- remove .efi file extension check for PE-COFF image
- use "if IS_ENABLED(..)" as much as possible
- 1024 should be sizeof(net_boot_file_name)
- call net_set_state(NETLOOP_FAIL) when wget encounters error
- describe DNS ip address host name limitation in document

v1 -> v2
- carve out the network handling(wget and dns code) under net/wget.c
- carve out ramdisk creation code under drivers/block/blkmap_helper.c
- wget supports the valid range check to store the received blocks using lmb
- support when the downloaded image have no partiton table but a file system
- not start the .efi file in try_load_entry()
- call efi_check_pe() for .efi file to check the file is PE-COFF image
- add documentation for EFI HTTP Boot

Masahisa Kojima (8):
  net: wget: prevent overwriting reserved memory
  net: wget: add wget with dns utility function
  blk: blkmap: add ramdisk creation utility function
  efi_loader: add missing const classifier for event service
  efi_loader: add return to efibootmgr event group
  efi_loader: support boot from URI device path
  cmd: efidebug: add uri device path
  doc: uefi: add HTTP Boot support

Raymond Mao (1):
  efi_loader: Boot var automatic management

 cmd/bootefi.c                                 |  12 +
 cmd/efidebug.c                                |  51 +++
 doc/develop/uefi/uefi.rst                     |  30 ++
 drivers/block/Makefile                        |   3 +-
 drivers/block/blkmap.c                        |  15 -
 drivers/block/blkmap_helper.c                 |  53 +++
 include/blkmap.h                              |  29 ++
 include/efi_api.h                             |   5 +-
 include/efi_loader.h                          |   4 +-
 include/net.h                                 |  17 +
 lib/efi_loader/Kconfig                        |   9 +
 lib/efi_loader/efi_bootmgr.c                  | 376 ++++++++++++++++++
 lib/efi_loader/efi_boottime.c                 |   7 +-
 lib/efi_loader/efi_disk.c                     |  18 +
 lib/efi_loader/efi_setup.c                    |   7 +
 net/wget.c                                    | 205 +++++++++-
 test/py/tests/test_efi_secboot/test_signed.py |  42 +-
 .../test_efi_secboot/test_signed_intca.py     |  14 +-
 .../tests/test_efi_secboot/test_unsigned.py   |  14 +-
 test/py/tests/test_fs/test_erofs.py           |   9 +
 .../test_fs/test_squashfs/test_sqfs_ls.py     |   9 +
 21 files changed, 867 insertions(+), 62 deletions(-)
 create mode 100644 drivers/block/blkmap_helper.c

-- 
2.34.1

