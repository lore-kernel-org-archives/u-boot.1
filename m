Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BC4E7D0D6
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 07:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26477863DE;
	Fri, 22 Sep 2023 09:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qQGzdfc6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 089DD864DD; Fri, 22 Sep 2023 09:11:55 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FF338634D
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 09:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68c576d35feso1655285b3a.2
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 00:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695366710; x=1695971510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KEVY7zumXmIbns82dkk+NFbgvnnddL5MmiwKJM4jOqw=;
 b=qQGzdfc6pyuNj4u5CvlkYgysOJpe1B6BD83PbwbklbRe3Kw3u/BxCNo7iaT+ZHlszC
 ONJsv/aRnr+SrIpHF2PuP/pbEl6qU1GAneBGnbtDPbzfp2/ukyuF9h6pLvHwRj+BsJ15
 j6aAuNH1QX4oUJiyTJUt+mLr6KuzwNRcoJ+aF4c5u58vqdDrREZXZTHHNd48Lfm2yavA
 4VJvJuKNwUSvQ3D/cWwtm9K/q51J2t1R8m9LSVVSn8AQA6RWlOrbYdi1+QhoWMHDO2ct
 wcQQpwNc1Xa2Y+CPFzHPUDuY/XirknDr7v4TFhGoTt53tu33mSOUtSY5qz9pm4W8/HTC
 AUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695366710; x=1695971510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KEVY7zumXmIbns82dkk+NFbgvnnddL5MmiwKJM4jOqw=;
 b=XUkeszQ+ISNx8hQu68+tI5p2JiRM0ibUOma2UZuDZxha44NZLa+/PKbHXrC166j+F5
 C0uEnSaldyG5VlvyuHpzQESE28ZnhLRJ+gzIUx4bXRR1evBU8EJo+9q6NQArZv7arKPA
 YLEW3spu9sbEF8ssksI22F4pAAxDmwYD6WfzMO0rZFZIyArLih7hcI5ZyniH6blXowC4
 lkH5Xo6fhQr9VxA2TuYrLQmKh19EsT0jC8lkQtKYVNcIm20y6gXF/xw/S+VrXyvVeIkL
 4WtzlWZ6B767JW1Y4OR6wTkRHpLqXRsgbLBRjLwtaVXv8LjbFPXLaicbajYhIBlgiiWy
 RcPA==
X-Gm-Message-State: AOJu0YyErAtuHZgy4ALVghi26axMqwgr0ywaeU9n7XOZnJDwe44GPk2A
 JrJzwUXZqiee1vAFJUELgzV8hoqR6IYEMAeWHe0=
X-Google-Smtp-Source: AGHT+IGT343oGXGhHCC+JXR8Qw3bn+bXHbQqOXHxZ23At5j9m+Cfk7b0epNNC0+uVbk2fRwXT2vQXQ==
X-Received: by 2002:a05:6a20:96d7:b0:15d:c1a8:c329 with SMTP id
 hq23-20020a056a2096d700b0015dc1a8c329mr761937pzc.48.1695366710412; 
 Fri, 22 Sep 2023 00:11:50 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 y10-20020a056a001c8a00b006926e3dc2besm1833323pfw.108.2023.09.22.00.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 00:11:49 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v4 0/8] Add EFI HTTP boot support
Date: Fri, 22 Sep 2023 16:11:11 +0900
Message-Id: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
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
  efi_loader: support boot from URI device path
  efi_loader: set EFI HTTP Boot download buffer as reserved
  cmd: efidebug: add uri device path
  doc: uefi: add HTTP Boot support
  efi_loader: create BlockIo device boot option

 cmd/efidebug.c                   |  50 +++++++
 doc/develop/uefi/uefi.rst        |  30 ++++
 drivers/block/Makefile           |   1 +
 drivers/block/blkmap.c           |  15 --
 drivers/block/blkmap_helper.c    |  53 +++++++
 include/blkmap.h                 |  29 ++++
 include/efi_loader.h             |   3 +
 include/net.h                    |  17 +++
 lib/efi_loader/efi_bootmgr.c     | 241 +++++++++++++++++++++++++++++--
 lib/efi_loader/efi_device_path.c |  20 +++
 lib/efi_loader/efi_dt_fixup.c    |   2 +-
 net/wget.c                       | 206 +++++++++++++++++++++++++-
 12 files changed, 628 insertions(+), 39 deletions(-)
 create mode 100644 drivers/block/blkmap_helper.c

-- 
2.34.1

