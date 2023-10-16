Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B808CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 04:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A13F8657B;
	Mon, 16 Oct 2023 06:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UJiMHp0E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 819B986940; Mon, 16 Oct 2023 06:24:18 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC64486524
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 06:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-57b5f0d658dso2487007eaf.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 21:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697430251; x=1698035051; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kEHNBpE8zPZsX9O4NASd1h64DP8zYsg2xxwHSxdXBm0=;
 b=UJiMHp0EQRj/ZV0fYYn0lzuKeUyLze9szru8R6VxShGKWSLDr0JsVOFN+TJsNRbLuh
 2zY7IJA1Bln3ap//9BqZPSfdkWoAst3aQjZpxYFIvkdthqRLYSMpax9rQcf1CdRHdHe+
 sJiz7X/cWv32fKbWroOXiezRU0qOPX26O1++hhok1OAB0rYkFUEgN9xb8DWf0GVh9RDO
 zCY+wEfqb1+Wc8sWtnii1auamx15MvoRhxCMzlqBAneNRc29317rx8IEf1vZc/uXz1LE
 oCC+FnhJ8wfr2/DfL4dZJ913qgic84imltN3AV490bPNykmbs5JPPY5yLiQtqojrqlv7
 A6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697430251; x=1698035051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kEHNBpE8zPZsX9O4NASd1h64DP8zYsg2xxwHSxdXBm0=;
 b=pnXhWhnioSCEYaCpxj/6iMbi4vCCDlAIK4naqmueLAs2zFPmEsizrsG/XEHKzuZsus
 cdLV4jQ/ktOBaZG5rDEwiAwXvjEzJQZ85PeykM8uscpgxvKvfXC7WCQWkhhZROcq5xF0
 ewcFApLhWowS7WX5IbN3tmLGfiQ1/h2qnPoV6R9Mp0/+2BfBdKkDb2L60ecSHLmG9y5h
 0U6MXKrHj+qQHMYZ3dV9xDaR8LbFvopbaxqVEhJOYwIzef5x0IMlBz89sUXYnq1e2Jxk
 445ArQTd6mIlNm6ILakzcrx5xNk7ZRTSKRyPDN4u/Yhhqao9wZV5xdOX7Y3rSsbEhYFU
 JVpQ==
X-Gm-Message-State: AOJu0Yxgbr6XAXfLMphQFTGlK83ugUQ+/nUBxgdkZBlDz1AFHw5gF0Kr
 xD1q14+rCNf0RXEjE4QY77ZCdBcp1Bop3XwIUFY=
X-Google-Smtp-Source: AGHT+IGEW2jpgZVNRyDkrK9uH1TLAedhDZfB8qEs++eYFs0e2rVjwooZkY5VHZs/5Uz/3JZhb/9gBg==
X-Received: by 2002:a05:6358:5289:b0:13a:4f34:8063 with SMTP id
 g9-20020a056358528900b0013a4f348063mr36289433rwa.32.1697430251634; 
 Sun, 15 Oct 2023 21:24:11 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 b14-20020aa78ece000000b0069337938be8sm624194pfr.110.2023.10.15.21.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 21:24:10 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [RESEND PATCH v6 0/9] Add EFI HTTP boot support
Date: Mon, 16 Oct 2023 13:22:59 +0900
Message-Id: <20231016042309.2386387-1-masahisa.kojima@linaro.org>
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

[change log]
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
  efi_loader: create default file boot option
  efi_loader: support boot from URI device path
  efi_loader: add CDROM short-form device path
  cmd: efidebug: add uri device path
  doc: uefi: add HTTP Boot support

Raymond Mao (1):
  Boot var automatic management for removable medias

 cmd/efidebug.c                                |  50 +++
 doc/develop/uefi/uefi.rst                     |  30 ++
 drivers/block/Makefile                        |   3 +-
 drivers/block/blkmap.c                        |  15 -
 drivers/block/blkmap_helper.c                 |  53 ++++
 include/blkmap.h                              |  29 ++
 include/efi_loader.h                          |   2 +
 include/net.h                                 |  17 ++
 lib/efi_loader/Kconfig                        |   9 +
 lib/efi_loader/efi_bootmgr.c                  | 284 ++++++++++++++++--
 lib/efi_loader/efi_device_path.c              |   3 +-
 lib/efi_loader/efi_disk.c                     |  18 ++
 lib/efi_loader/efi_dt_fixup.c                 |   2 +-
 lib/efi_loader/efi_setup.c                    |   7 +
 net/wget.c                                    | 205 ++++++++++++-
 test/py/tests/test_efi_secboot/test_signed.py |  42 +--
 .../test_efi_secboot/test_signed_intca.py     |  14 +-
 .../tests/test_efi_secboot/test_unsigned.py   |  14 +-
 .../test_fs/test_squashfs/test_sqfs_ls.py     |   6 +
 19 files changed, 720 insertions(+), 83 deletions(-)
 create mode 100644 drivers/block/blkmap_helper.c


base-commit: c1ab04626d6b05c6e82dfe4d97d3f62f7310d612
-- 
2.34.1

