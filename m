Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23227C4167D
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 11:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00BCD86BEC;
	Mon,  6 Nov 2023 12:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nbaMX5e5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0065B86BEC; Mon,  6 Nov 2023 12:16:42 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A995486BA4
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 12:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ba54c3ed97so4484640b3a.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 03:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699269395; x=1699874195; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8Bb7KyrdKQOr8af/mV5PMBEzkjqqjtfmyP7AGbj4IzY=;
 b=nbaMX5e5jzDe9eWuavRqxViWFIb04GOu3c6Oo87Wea51XgTLUmAfE7EMxYURTN822e
 U05dlzjYuZe8NamqQJpPKGvoBEEn3KI8m1sfZ+dts2yvCRQsy5OWI6eF6wQCEiQ/TtcI
 soq2JWrLbR4/w0RbjCx96Q/pTlL+8h74FHAqEcgXvQUvlJMsRQEsKLVloVGQB9LXdfX7
 rPtiJEF8WzRAMiAA/zp/ZmVkU9mS4ocGtmYQe9NMq2mtZF05ubR+uyXw86sJTuA9zYtx
 LOQ8J73JVSu8GxIPoNKa6bz1Gp0+v1YfB/YnBIAQqrUzmYmVevC0+d2EvSba8Qlij8kJ
 Iglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699269395; x=1699874195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Bb7KyrdKQOr8af/mV5PMBEzkjqqjtfmyP7AGbj4IzY=;
 b=cl8fKr/p4nZzE9usB9VD4riTqv/9kxZNpRYDI9kRoBzqE1CwEwnCo1c5zbspKAKvJg
 v9hFcogFGPr3UKWngM4iddAc6tcRjnRzz3Csdd3Nd+n3tSH8YfwYgx2ykeVtqi4nb14h
 zwFhCiV/z5b1DX7YRV2lv/PEWgVXHgunvtoLJFRQnc8Ee/xhEUW5wRQfT3nytGEJoFAV
 QX08CfUSrzXFnN2qS4VMxvKpwtKmNYmgxWuz8BRMgcdCfisGa/o/ObZCzaGKE6ITmGXN
 cFIb0z6KTpC/orBQBIYREzrj1A5NVFrY79YN0I5xmsOvluUpc1rl0R16SlcPSwRDijsF
 AFSw==
X-Gm-Message-State: AOJu0YzgKWwIqFN1pruyDMoY3Me6Vkm8n4Nf34OVrRGIhXDhHDa3e28w
 xap+zpR3xDc67Q5Dw5/CSijZBHl5SJniJNKvL/Y=
X-Google-Smtp-Source: AGHT+IEKVuRW7nuu/J8MapW0i7Mh7Urel4pZLTRAEivubDmbziI/uU9FQQmYdUtNbfRGKICXPBaP+w==
X-Received: by 2002:a05:6a20:7d84:b0:158:17e6:7a6 with SMTP id
 v4-20020a056a207d8400b0015817e607a6mr41021718pzj.42.1699269394814; 
 Mon, 06 Nov 2023 03:16:34 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 pt11-20020a17090b3d0b00b0027d0adf653bsm5325886pjb.7.2023.11.06.03.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 03:16:34 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v10 0/9] Add EFI HTTP boot support
Date: Mon,  6 Nov 2023 20:14:55 +0900
Message-Id: <20231106111504.3631058-1-masahisa.kojima@linaro.org>
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

