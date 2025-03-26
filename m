Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCF3C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 14:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAFBC8070C;
	Wed, 26 Mar 2025 15:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wGOkyb5n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B74781951; Wed, 26 Mar 2025 15:59:01 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D19FE803CC
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 15:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac6ed4ab410so103654166b.1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 07:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743001138; x=1743605938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pnQNr09dzRQp2cCy9CJ+3Fb9HsrTZd2ceATT5JUGgOk=;
 b=wGOkyb5niVwHEbsFDkV+o1iZMPkYH540PxERWC+2eqepRHBWeJUWb9fwSFZdao3lg7
 vu5/f7DN/82UFRCIMxqTW4DfrFHHfz3umG7ZlRgy1185Y91gBOqmLwYucUUjARU0dEoJ
 GHAFCwScYT1bIXm0yNOd1Wvvn/ul5VXAXWlFoFFbGvawTYlLWtddYhi63S8l4NbUAr+O
 nH5zKbGWEhUF3wRWYpJyA1VAA2FGRouNhJ/6Xjm78eKJLcsJztdqblsNRAMa9l+JDBYF
 gk3NeILTaz2X0u00EtYRzgy4au4u9FWgdCMx+h2mJorpI27rnKW0Z7AMEBVdKuxqLEDr
 DoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743001138; x=1743605938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pnQNr09dzRQp2cCy9CJ+3Fb9HsrTZd2ceATT5JUGgOk=;
 b=CLYJqcL/BbJdp8FsUlYh4SqJHuDZ5KSQBf6ngpXW7DS+8whcZ9zWOnk5/V7+GO99A0
 YXUz3BraRNIXQB57Anqdk51adeE4cOB6Ra28bLbTmZHXdvXx9Z4+/clsMlNfglQuhUA8
 SZVop030zofQXF+ysietLmV8IEp3su6C6KUv/9EV2Bziw8TT5Ad2A0b/2tkmeRCPHZ+B
 Ew3d58r0tNwkvqZ5SNeMgZqst86DywhuylC5WORleomGuSDKqMe7hDanbPib6sM7/NRT
 oyGd3orml7sv/WOUXhSgcnQPwOkt4+TwfQM8VeRAVIakGnPEGKb3azb4ySlLKxpH7bH9
 MNNA==
X-Gm-Message-State: AOJu0YznJwfjUBp1KtFWlCoPx6MirggVsB1lwbjmBh7JhkxkHuGBs0RZ
 SFNIUWM7UPvQ64qU6LSkeXBljfmD+SuqOs4q+Ejjj4SKL3PrZMgSwmxjcv6oKBsyJi4NHvCwXem
 o
X-Gm-Gg: ASbGnctyWRxlymocXIz0xOzdHnhagoU1/Y2SgXZyAnN4FYozyMQseHL79IMS7jnDuek
 X2E33VGTOiCgXwr5QxW1r3ah5+qzxQx3ahrzzkvQoVmJIdeQZ2IWROMBYs9AR9QBucelGizYl4l
 FRo86Iv0xr2u5z5H9k9h97SRtc8dvpaTAA91kVnsC+wz5+ead4UGANTVOifyWdgnvXt0w+b8IG0
 LGLrDeutRTLWpCKL8TMZDIMHBD4BZwZp0Y9aD3wUb4nph2F5JB82FDqDCIIHfQyKNtg8Hf7XOWV
 LAmouo1ZPwRO2+GcUSF6GjpwIP12Aq+F299W8smCIjdgyix2MVLW1rXPlLy0C0CWyuNNEJA0Ucn
 MZU9xNsE72oCILf8oUw4I2X8=
X-Google-Smtp-Source: AGHT+IEmuN1aHXKx3TxIv0SKGpRhkj9wend9vKLWagvAF9LfGDEvSTtmTcYVuvK0HQ7orfRuNIJVrQ==
X-Received: by 2002:a17:907:3da9:b0:ac2:29c7:8622 with SMTP id
 a640c23a62f3a-ac3f252f862mr2099464066b.54.1743001138084; 
 Wed, 26 Mar 2025 07:58:58 -0700 (PDT)
Received: from localhost.localdomain (ppp089210242125.access.hol.gr.
 [89.210.242.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efd3aa21sm1057137366b.158.2025.03.26.07.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 07:58:57 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: xypron.glpk@gmx.de, Anton.Antonov@arm.com, sughosh.ganu@linaro.org,
 tobias@waldekranz.com, pbrobinson@gmail.com
Subject: Pull request for efi-next-26032025
Date: Wed, 26 Mar 2025 16:58:50 +0200
Message-ID: <20250326145850.918186-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
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

Hi Tom,

An interesting series that allows us to boot installers and live images from EFI, without any
distro-specific quirks.

The following changes since commit 042c8f0cb1ea5f6988e8633799f7b550876f0ae6:

  Merge tag 'u-boot-imx-next-20250325' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next (2025-03-25 08:57:38 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/efi-next-26032025

for you to fetch changes up to 61e0a20aecf4af6cdc223bd8cd1bd82fe5e3d9f6:

  blkmap: pass information on ISO image to the OS (2025-03-26 13:28:08 +0200)

The CI https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/25336
suffers from the lmb issue but the same patches on top master work fine
https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/25338

Please pull
/Ilias

----------------------------------------------------------------
When trying to boot an OS installer or a live image via EFI HTTP the
following happens
- U-Boot downloads the image and mounts it in memory
- The EFI subsystem is invoked and the image is started
- The OS calls ExitBootServices and the memory that holds the mounted
  image might get overwritten

This results in installers complaining that they can't find installer
medium or live images complaining they can't find the root filesystem.

ACPI already deals with it by having NFIT and NVDIMM to provide ramdisks
that need to be preserved by the OS. Linux and device trees have support
for persistent memory devices (pmem).

We can use them and inject a pmem node in the DT to preserve memory across the
entire boot sequence. Linux will just create a block device over the reserved
memory and installers/images can re-discover it.

This is what it looks like from the OS perspective:

nd_pmem namespace0.0: unable to guarantee persistence of writes
pmem0: p1 p2 p3
EXT4-fs (pmem0p3): mounted filesystem f40f64a4-5b41-4828-856e-caaae2c1c2a0 r/w with ordered data mode. Quota mode: disabled.
EXT4-fs (pmem0p3): re-mounted f40f64a4-5b41-4828-856e-caaae2c1c2a0 r/w. Quota mode: disabled.
Adding 45052k swap on /dev/pmem0p2.  Priority:-2 extents:1 across:45052k SS
root@genericarm64:~# mount | grep pmem
/dev/pmem0p3 on / type ext4 (rw,relatime)
/dev/pmem0p1 on /boot type vfat (rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)

It's worth noting that Linux behaves differently with reserved memory
(at least on arm64) and that depends on kernel config options.
CONFIG_ZONE_DEVICES and CONFIG_ARM64_PMEM are such options. It boils down to
how the kernel tries to map pages. If devm_memremap_pages() gets called instead
of devm_memremap() mapping the memory fails.

The only safe way is to remove the memory from the EFI memory map,
rather than defining it as /reserved no-map;/ in the DT.

----------------------------------------------------------------
Ilias Apalodimas (2):
      efi_loader: allow for removal of memory from the EFI map
      efi_loader: remove memory occupied by a ramdisk from EFI memory map

Masahisa Kojima (1):
      fdt: add support for adding pmem nodes

Sughosh Ganu (5):
      efi_loader: remove unused code from copy_fdt()
      efi_loader: install device-tree on configuration table on every invocation
      blkmap: store type of blkmap slice in corresponding structure
      blkmap: add an attribute to preserve the mem mapping
      blkmap: pass information on ISO image to the OS

 boot/fdt_support.c            | 39 +++++++++++++++++++-
 boot/image-fdt.c              |  7 ++++
 cmd/blkmap.c                  |  9 ++++-
 drivers/block/blkmap.c        | 82 +++++++++++++++++++++++++++++++++++++++--
 drivers/block/blkmap_helper.c |  2 +-
 include/blkmap.h              | 33 ++++++++++++++++-
 include/efi.h                 | 13 +++++++
 include/efi_loader.h          | 15 ++++++++
 include/fdt_support.h         | 14 +++++++
 lib/efi_loader/efi_bootmgr.c  | 25 ++++++++++---
 lib/efi_loader/efi_helper.c   | 85 ++++++++++++++++++++++++++++++++++---------
 lib/efi_loader/efi_memory.c   | 34 +++++++++--------
 12 files changed, 310 insertions(+), 48 deletions(-)
