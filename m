Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF6AC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 04:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B3988778B;
	Fri, 10 Nov 2023 05:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D3Y4sXL3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D38387779; Fri, 10 Nov 2023 05:27:11 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7928487779
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 05:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso1383506b3a.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 20:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699590423; x=1700195223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kk/uHJ6hZV6zgI5zBPSBSotS7UN6JRjdXwvuhy7gfpU=;
 b=D3Y4sXL36hUq3TtuYTOK8dczIKVAg25EYJ4O1Cxz/jBpSbBsK+UwncvOXokpKKiq+L
 gwyJAhf36qXJTbzfJm1O/KYFhpg056juZwGwXf5iJBI8lnhlKlQwCYchGqX6zgidR+aN
 1rQGFIZCFKCPiArmeD5cs9nGc4NYXz210XsdOIGt5sUWKdy7AerhX+InjZmu7c+HmHQS
 GT0AKSq0kd/vKZMGB2V6hSMUi8x6582bIDt7aznYvYtVNsTFdyK7OZCfQmuSbB3se2vw
 Ce1XXCLJT7YrWcwqd/hYnkb+di0l3SBKI9iUpCEOgKKMW99oYS6MfKImDD2MxSFYWj+d
 fUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699590423; x=1700195223;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kk/uHJ6hZV6zgI5zBPSBSotS7UN6JRjdXwvuhy7gfpU=;
 b=lUc264LafhHPZ6/E7rIGtq6mbYbRqZ59kEk41ATBZizEBVzxu3KPrNLjf0bv1pDZHE
 x1z5vMmNdU5fGVOdiucOTizAn1hGFYmuarX/9oqACkAqCpJkTW6d5T8hoG+RtK+QWF4t
 bgNVbObkLbS4os8OOuPJg6dZGWeur0t/YLHFPadI1ElSu1/pNgKwrcVRb4LtHMRPHaU/
 oD7AaDpwVFANqCQJ7LQnPHAF0b/8L6QIuLOFT40SpmSeeu05rLOd+TOYuQyHpDJrFpIN
 JGAW2jby0udnd/BTLY8G1XKPpdU+233hy5ohfPu4fRGN4gmScqMV6PvZEqh8HhkobmWR
 14zA==
X-Gm-Message-State: AOJu0YwS55+FTb2D8BUWB6VID20qzqjg85a7Zimho7sIW9uUZ2TCWsVE
 LswgSl3VC8ci6If9w7v6qVI6cPGOdamYBBOdDiw=
X-Google-Smtp-Source: AGHT+IGEkeaHFn+WNSaq6QpoYBhkstN2qVtYj35AsJnjJ4TobqmkmS7VOimdslatbhnGN4+rgTAVew==
X-Received: by 2002:a05:6a00:368c:b0:6c3:468c:6caa with SMTP id
 dw12-20020a056a00368c00b006c3468c6caamr1968305pfb.6.1699590423216; 
 Thu, 09 Nov 2023 20:27:03 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 t17-20020a056a00139100b006933866f49dsm11942448pfg.19.2023.11.09.20.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 20:27:02 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v12 0/9] Add EFI HTTP boot support
Date: Fri, 10 Nov 2023 13:25:33 +0900
Message-Id: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
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
v11 -> v12
- missing root directory close
- 'depends on' DNS, WGET and BLKMAP is changed to 'select' in lib/efi_loader/Kconfig
- creating uri device path is carved out to sub-function

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
 cmd/efidebug.c                                |  78 ++++
 doc/develop/uefi/uefi.rst                     |  30 ++
 drivers/block/Makefile                        |   3 +-
 drivers/block/blkmap.c                        |  15 -
 drivers/block/blkmap_helper.c                 |  53 +++
 include/blkmap.h                              |  29 ++
 include/efi_api.h                             |   5 +-
 include/efi_loader.h                          |   4 +-
 include/net.h                                 |  17 +
 lib/efi_loader/Kconfig                        |   9 +
 lib/efi_loader/efi_bootmgr.c                  | 378 ++++++++++++++++++
 lib/efi_loader/efi_boottime.c                 |   7 +-
 lib/efi_loader/efi_disk.c                     |  18 +
 lib/efi_loader/efi_setup.c                    |   7 +
 net/wget.c                                    | 205 +++++++++-
 test/py/tests/test_efi_secboot/test_signed.py |  42 +-
 .../test_efi_secboot/test_signed_intca.py     |  14 +-
 .../tests/test_efi_secboot/test_unsigned.py   |  14 +-
 test/py/tests/test_fs/test_erofs.py           |   9 +
 .../test_fs/test_squashfs/test_sqfs_ls.py     |   9 +
 21 files changed, 896 insertions(+), 62 deletions(-)
 create mode 100644 drivers/block/blkmap_helper.c

-- 
2.34.1

