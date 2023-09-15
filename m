Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5CDEE6452
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 10:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D165864E8;
	Fri, 15 Sep 2023 12:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QdJrmgn6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 475D6864EC; Fri, 15 Sep 2023 12:17:30 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89469864D9
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 12:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3a9f88b657eso1168711b6e.3
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 03:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694773046; x=1695377846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JAB6JjYkPuMxNT0bjJchKvFCwKttRydrs0ueaQQwZas=;
 b=QdJrmgn6+dRNX+G3ci6y3V/0ZN7OPetY7g5vuazwaOmyFBmJMdLuiu2RZlq3raxCr1
 3Ua+tkJajzXBu7Tz+MuVRrQx8Hr5o2hjlg3fJkFs0gZ8XeJhnJpOd4fNh7rmF/fq81Rl
 QgacxOI2qWht7wkPZCfvDZoRF5ZavoILXOAa88mpP8J8pW63ouhBgO0++4XBanH2H+6l
 HHNapixNfW8OjtUJgxNgKfUC0oYsPKqG4WvfJZwdwCwoQfuexbMtSTObuaKO4cHcb180
 XqBKv2at9GItgxSzngMTSefFn7/OgeMZ1n/bANWMIskYmMQNaMCc+gnHx3j8KiuP2tQU
 0nGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694773046; x=1695377846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JAB6JjYkPuMxNT0bjJchKvFCwKttRydrs0ueaQQwZas=;
 b=Yy+YFSJ616BBQmZw7wWOd4kj0ibGL9fvHNbBdmosCRqBJP7v2tDoNrVQKHE2L0MxEj
 AKULC0kd8mMRmlncvjKgzd5ksnQHHTinDcBFdbJR1sA7P6dryDxpclMu3r6EpQNgdKEo
 4Vmzmkak7YVcLtJOA7BN5hYRu6eWZzm9I+2x7pRzrae3HXlJvbZvxP1hGgLH4FOzocpW
 KGdn3tiFc8s3ZwjgPGGJCtOoOxGswejVSKsuFmaOpsbg6tq963+FfuL5b4/Ep8d7wbun
 UVBwfTVN0gQjz1b/MM4yinYJvXw+C13nNySvwghvNK6D8PN1TzbFd/YbUJOlkwZU6PgX
 ey6A==
X-Gm-Message-State: AOJu0YwTJqIExlOmWAsKTMcEJgvlp3yPlqU97IW4qgnJyeCp2fPJQzo3
 ravPYNWDUMnBEs6ubGdpZzZK+lT7a1WM3S3GZAU=
X-Google-Smtp-Source: AGHT+IFQsWgq9kCFdky5ZSc8XYmnpxBaCHhXY+0r2rlGmWaBy0ir7eXSWuR/2D+lIaBwCBZ0lndjpg==
X-Received: by 2002:a05:6808:ab0:b0:3a8:83df:d5a4 with SMTP id
 r16-20020a0568080ab000b003a883dfd5a4mr1156077oij.59.1694773045671; 
 Fri, 15 Sep 2023 03:17:25 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 15-20020aa7910f000000b00682a61fa525sm2772584pfh.91.2023.09.15.03.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 03:17:24 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v3 0/7] Add EFI HTTP boot support
Date: Fri, 15 Sep 2023 19:16:33 +0900
Message-Id: <20230915101640.1166332-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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
blkmap, then boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).

This version still does not include the test.

To enable EFI HTTP boot, we need to enable the following Kconfig options.
 CONFIG_CMD_DNS
 CONFIG_CMD_WGET
 CONFIG_BLKMAP

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

Masahisa Kojima (7):
  net: wget: prevent overwriting reserved memory
  net: wget: add wget with dns utility function
  blk: blkmap: add ramdisk creation utility function
  efi_loader: support boot from URI device path
  efi_loader: set EFI HTTP Boot download buffer as reserved
  cmd: efidebug: add uri device path
  doc: uefi: add HTTP Boot support

 cmd/efidebug.c                |  50 +++++++++
 doc/develop/uefi/uefi.rst     |  30 +++++
 drivers/block/Makefile        |   1 +
 drivers/block/blkmap.c        |  15 ---
 drivers/block/blkmap_helper.c |  53 +++++++++
 include/blkmap.h              |  29 +++++
 include/efi_loader.h          |   2 +
 include/net.h                 |   3 +
 lib/efi_loader/efi_bootmgr.c  | 194 ++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_dt_fixup.c |   2 +-
 net/wget.c                    | 206 ++++++++++++++++++++++++++++++++--
 11 files changed, 562 insertions(+), 23 deletions(-)
 create mode 100644 drivers/block/blkmap_helper.c


base-commit: 9f201d9bf3dd895d1d5e3a57b562e4f107ed5118
prerequisite-patch-id: 386e2563ffafe7f80fda169076d2835ea071b3f9
-- 
2.34.1

