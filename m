Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2A7C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 11:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE0686F42;
	Mon,  6 Nov 2023 12:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iLEG0Vwc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC23C86BFA; Mon,  6 Nov 2023 12:40:30 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CA1B8653E
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 12:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1f03db0a410so2761232fac.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 03:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699270822; x=1699875622; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8Bb7KyrdKQOr8af/mV5PMBEzkjqqjtfmyP7AGbj4IzY=;
 b=iLEG0VwcPjdItE4HVVcYlN4JoyNO+9EsNX80YSHirIVgrMWzmQPVO7RtF6hIMHMCB9
 lQ4qBd8YjAar9FaxVk+PuuL21K9AswGuwcQosEhngEV2WriaJqV/EZkE5ISUDO0pchaS
 okCB2Tj4voG8AYGJuSPdzOWnLcqQr6N0cXCKjE+TSaCRpl1VvVXpBprx44b1nRbFpZoN
 7cN3NBwj4TOc/S1IfNOZVIkP++E/QthKw1RicCj09MJOZVAIh+Mc7jpdzO9hd4v01Rbj
 iHOwiTm1isy/6QzDWIDgnjl4un/5GiFpBPNSIdJJL4hdGSw24GrM9HQviMDW7JuwAe5e
 PiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699270822; x=1699875622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Bb7KyrdKQOr8af/mV5PMBEzkjqqjtfmyP7AGbj4IzY=;
 b=JPNaij8ZDsD4dZywk0008DkxVaCCXnSBnHvvRiu+Lx6s79J2vxaLZnOtAoysgGLjgw
 qLSc0TfBqWOEIQyju7w7qi6mkVbuSHOoQxmXQl8l++4Bzl9/ywUqxzz8dmjz4U7b5FqK
 5Im04z9+8+7P8IhNP0wea3ko1vc3mrPaad2Dp/fkIfTl1yu5yO4USNAjKvJdEgVw/R7M
 VVjYcJ+1a78+KkiiVgMDy8BcZSP7wYif5q2DhfGsnTSkWwAKq6/rPT4LNgnZWs23sSrq
 /nNbFzJ1lPyBSys0cpKxJIqk59bEDJWUxsIPetdrTs/4aDNirNJw3h4Fq9A4k5+GZTa/
 QYbA==
X-Gm-Message-State: AOJu0YwlSUiFa8nSWQP/Y8c0csSlcY1vSYc2lB6a4j6bq9mJt6wRfdfu
 i4sOCOjJPs2/WSOMjoxSkRUZNg3ccSD5727E4Iw=
X-Google-Smtp-Source: AGHT+IEMiFz19R71rjQBkD6VoiAzuNk08jCpFXSy0ootp2D0Ksrb+DsqRnZ13P/IZDZeVJ4HtAK0Jg==
X-Received: by 2002:a05:6870:ad06:b0:1e9:9989:33a5 with SMTP id
 nt6-20020a056870ad0600b001e9998933a5mr37874969oab.5.1699270822382; 
 Mon, 06 Nov 2023 03:40:22 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 s1-20020a63d041000000b0050f85ef50d1sm5377694pgi.26.2023.11.06.03.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 03:40:21 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [RESEND PATCH v10 0/9] Add EFI HTTP boot support
Date: Mon,  6 Nov 2023 20:39:11 +0900
Message-Id: <20231106113920.3631591-1-masahisa.kojima@linaro.org>
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
 lib/efi_loader/efi_bootmgr.c                  | 337 ++++++++++++++++++
 lib/efi_loader/efi_boottime.c                 |   7 +-
 lib/efi_loader/efi_disk.c                     |  18 +
 lib/efi_loader/efi_setup.c                    |   7 +
 net/wget.c                                    | 205 ++++++++++-
 test/py/tests/test_efi_secboot/test_signed.py |  42 +--
 .../test_efi_secboot/test_signed_intca.py     |  14 +-
 .../tests/test_efi_secboot/test_unsigned.py   |  14 +-
 test/py/tests/test_fs/test_erofs.py           |   9 +
 .../test_fs/test_squashfs/test_sqfs_ls.py     |   9 +
 21 files changed, 828 insertions(+), 62 deletions(-)
 create mode 100644 drivers/block/blkmap_helper.c

-- 
2.34.1

