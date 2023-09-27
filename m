Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43324E810B3
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36A91864C3;
	Wed, 27 Sep 2023 11:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lIHRwm+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43B7C86BFA; Wed, 27 Sep 2023 11:37:24 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EC9585C98
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7ae0da3a692so1111326241.2
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 02:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695807439; x=1696412239; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AeWkQFhq6KpJu5GxycgQlX22xr7zK0BT9fuQ3gseGWY=;
 b=lIHRwm+El7h5vu+W4B0XnBnGFue4HLuZycbvA/lk9IGUGoJamnhTDhv1jrl0YRYUGb
 58etbZEZ/wzdd2HMhJr+8R/4OVlX95nm0NlJMn0TyDBA/TYLdkwvTpDjESdBP90lrOhV
 0qpcLLvu0cjfJs4VMlK3HARo5xavLB4hp+eivV2mWwDiaqwAGMg9aRhLadTB3khbQT6c
 E1O4VeX9snWlFaeRQbGg6sD3GeeppxVctsM7O6nhDFNK0jywH6Fkivy3u6bX8S7xq9eL
 RvY80vpRmP+JtAiWa0zj82Rs+JoUruNgIhDgBXK9bXhWPcF6JqbN/Pnn+5ufWHRomYSQ
 Jb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695807439; x=1696412239;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AeWkQFhq6KpJu5GxycgQlX22xr7zK0BT9fuQ3gseGWY=;
 b=Ko6ZbPV5l0mCT6/hG1Gr8t7ZHEizDEeAMjBjm6kIRH0TYtp9w8c8TCv6k6Al0BLe+s
 mCmpX0ckA/rhQtQXxr4fbkg3hdBi/axW0B5Y0Z0hx4gcIzW/atHh+/G9P7w6/XPLoq2D
 uPQbBVZsPNSeq3+ualnA1tlwEGxn6hEnJCpgVJ970XuJGPIpI6MaMQEtiHmNbzd9ffUL
 vc10hoxGDG1CQ0acuvaRXFzCV3xC1MAiGLFnXF5+xI8webwJOm1q+uspoqxjrk0wRiwQ
 H+3KBnkijx3E385E6xrVwwvCTktTS7kmd8uUGyLNiTkgGY2JyRak04HTtYlU9Scw9TSe
 KZWQ==
X-Gm-Message-State: AOJu0YwOoopeqOSRMbUNP6lwcz7+IQgNNCeoUqWy2a6di08RGqHR1Pe1
 ajdKHipZK/l8AyeKPfBtKV81Fc6sQRBVG7c9osY=
X-Google-Smtp-Source: AGHT+IGiRdZldT7HAgsH0OvnRWNcbqNka4+5MMkH51rfaAwpfrKyZt5u4tQMsmxk0PqTNlCKqvT9RQ==
X-Received: by 2002:a05:6102:44c:b0:452:4eb4:8314 with SMTP id
 e12-20020a056102044c00b004524eb48314mr1172427vsq.2.1695807439604; 
 Wed, 27 Sep 2023 02:37:19 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 d190-20020a6336c7000000b005657495b03bsm9459535pga.38.2023.09.27.02.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 02:37:18 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v5 0/7] Add EFI HTTP boot support
Date: Wed, 27 Sep 2023 18:36:24 +0900
Message-Id: <20230927093631.1595494-1-masahisa.kojima@linaro.org>
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

Masahisa Kojima (7):
  net: wget: prevent overwriting reserved memory
  net: wget: add wget with dns utility function
  blk: blkmap: add ramdisk creation utility function
  efi_loader: support boot from URI device path
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
 lib/efi_loader/efi_bootmgr.c     | 248 ++++++++++++++++++++++++++++---
 lib/efi_loader/efi_device_path.c |  20 +++
 lib/efi_loader/efi_dt_fixup.c    |   2 +-
 net/wget.c                       | 206 ++++++++++++++++++++++++-
 12 files changed, 634 insertions(+), 40 deletions(-)
 create mode 100644 drivers/block/blkmap_helper.c

-- 
2.34.1

