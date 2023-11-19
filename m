Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2736DC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 19:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B5E87496;
	Sun, 19 Nov 2023 20:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A1mBd9Ru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83ADB87252; Sun, 19 Nov 2023 20:12:25 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB99F871B2
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 20:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-35b03e9c08eso979525ab.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 11:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700421127; x=1701025927; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q93hTl0ciRtzumqQmb4BhFqt0Z+UxxUpDgncnYMvA4w=;
 b=A1mBd9RulIjMvcJ8/xq2ri+LQjYh5c/NIMhEpXGtIPWWkUvR/x39n4Szp1I0wrIzmV
 Qh/kons6p1CQr2ID//o6PSs1PHwo4sR0SH+hQqXdd83rrToifBxU9CZv++8i4x4vHB19
 z3GC5UHd5y0EekZJNm1AZ6jAa8IHNrUzy1rVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700421127; x=1701025927;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q93hTl0ciRtzumqQmb4BhFqt0Z+UxxUpDgncnYMvA4w=;
 b=srhw9ihYbdYfnsceobJBH8jPyamP5P9uQVNowL9tNgUXLjYfTmLTLa32AM7GgzsqyC
 VHjkYh1p3vTV2pUKGi7rZV1Ar+vAQ2nz7aEma2dE+vDUZAZCbMdjAYIJnRAiw/RME4/H
 FqkhDwclPC1dT7SnDs+FIG0d72zsSpGUHMZGgokiLiDmJ2II7MIUwWKKPE/ahytVW8R2
 lo6WOsLNzacZ5VgY8wbWs42+c7sjLvuoJba5Ug7HKMFK676/mg8wxIlLIEJtfmZtgIwy
 9KfKKC8W4MaGcw7Ok8ASnPHpITYRtP5hUKvQ0a8mfB/FuOqwcreBGHklcXgnSv3lPJl9
 4vCA==
X-Gm-Message-State: AOJu0YwsXhXbo9oPM9bkT2tReg5Y+SK1gjs26lt945Vp362Tgwsz8Tof
 UGu3YzjBsWq8QKX4dN/co8NIwgTSWfUXCd5+MC/2nw==
X-Google-Smtp-Source: AGHT+IEcS+3vAhind5x4XEJ4bkX2pAPQPGFWeh90ki1MTfYGWCZRkXh0VnXHKBItKXfCJ1OMkprTzQ==
X-Received: by 2002:a05:6e02:3489:b0:34f:70ec:d4cf with SMTP id
 bp9-20020a056e02348900b0034f70ecd4cfmr9718691ilb.8.1700421127224; 
 Sun, 19 Nov 2023 11:12:07 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a920511000000b0035ab2c7016bsm1951032ile.50.2023.11.19.11.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 11:12:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaewon Jung <jaewon8868@gmail.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v5 00/12] Resolve issues with booting distros on x86
Date: Sun, 19 Nov 2023 12:11:35 -0700
Message-ID: <20231119191202.667180-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
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

This little series reprises the EFI-video fix, fixes a USB problem and
enables a boot script for coreboot.

It also moves to truetype fonts for coreboot and qemu-x86, since the
menus look much better and there are no strong size constraints.

With these changes it is possible to boot a Linux distro automatically
with U-Boot on x86, including when U-Boot is the second-stage
bootloader.

Changes in v5:
- Adjust motivation for patch, since the EFI hang is fixed

Changes in v4:
- Don't rename the legacy-USB functions
- Add a bit more detail to the comment
- Use a Kconfig option

Changes in v3:
- Add new patch to refactor mmc prep to allow a different scan
- Add missing word 'function' in the commit message
- Clear the screen before booting
- Add new patch to drop unnecessary truetype operations from SPL
- Add new patch to enable truetype fonts in coreboot
- Add new patch to enable truetype fonts in qemu-x86 and qemu-x86_64

Changes in v2:
- Rebase to -next
- Add some more comments to the header file
- Add fixes tag
- Add new patch to add a return code to bootflow menu
- Add new patch to add a coreboot boot script
- Add new patch to avoid unbinding devices in use by bootflows

Simon Glass (12):
  efi: Correct handling of frame buffer
  bootstd: Refactor mmc prep to allow a different scan
  bootstd: Add a return code to bootflow menu
  x86: coreboot: Add a boot script
  usb: Avoid unbinding devices in use by bootflows
  expo: Correct background colour
  video: Correct setting of cursor position
  video: Drop unnecessary truetype operations from SPL
  x86: Enable SSE in 64-bit mode
  x86: coreboot: Enable truetype fonts
  x86: qemu: Expand ROM size
  x86: qemu: Enable truetype fonts

 arch/x86/Kconfig                  |  8 ++++
 arch/x86/config.mk                |  4 ++
 arch/x86/cpu/x86_64/cpu.c         | 12 ++++++
 arch/x86/dts/coreboot.dts         | 10 +++++
 board/emulation/qemu-x86/Kconfig  |  3 +-
 boot/bootm.c                      |  2 +-
 boot/expo.c                       |  4 +-
 cmd/bootflow.c                    | 53 ++++++++++++++++++------
 common/usb.c                      |  5 +++
 configs/coreboot64_defconfig      |  2 +
 configs/coreboot_defconfig        |  2 +
 configs/qemu-x86_64_defconfig     |  5 ++-
 configs/qemu-x86_defconfig        |  1 +
 doc/usage/cmd/bootflow.rst        | 67 +++++++++++++++++++++++++++++++
 drivers/usb/host/usb-uclass.c     | 14 ++++++-
 drivers/video/Kconfig             |  1 +
 drivers/video/console_truetype.c  | 10 +++++
 drivers/video/vidconsole-uclass.c | 15 +++----
 include/usb.h                     | 21 +++++++++-
 include/video.h                   |  9 +++--
 lib/efi_loader/efi_gop.c          | 12 +++---
 test/boot/bootflow.c              | 64 ++++++++++++++++++++++++-----
 22 files changed, 280 insertions(+), 44 deletions(-)

-- 
2.43.0.rc0.421.g78406f8d94-goog

