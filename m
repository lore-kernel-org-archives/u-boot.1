Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F2FEE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 12:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C11FE864C4;
	Tue, 22 Aug 2023 14:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R21yaHbO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54894864C2; Tue, 22 Aug 2023 14:10:43 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ECE7864B4
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 14:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31c615eb6feso493821f8f.3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692706240; x=1693311040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t6THOXraqECCXXwW3uFvPExiob04ry0ZDP8I7uV8zeQ=;
 b=R21yaHbO9jdNW/5f8yoOkIjNiTYHMFVGF5oDPPo8ZyreSuq0+r+kxFsoVURJb1IL0N
 rvGtoeLKMMes7v/f+IJdX9Y87wFcK9HhpSFx953tuKCsuDW7Krkggjkiy8fw6MX7HMkE
 KTPPL1U5bTDeo42PF4Lp9/QLw+7vKLIbvudKgUSj7muSsqOzT/20qOKOcxay6nnOahab
 JAEldJPYa/gAGMZ0UmxGV3ndgF2pP6CB1Gwhp4EQfiE0wv9Q452oTfzE4qkCSTM9MIL3
 qy9nHMtbQBcsr4dnTkIB1xVk73Hxy9J0jkG0C84ZP0OMvFMYA77cKGbZFVTmWVete2Bd
 YrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692706240; x=1693311040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t6THOXraqECCXXwW3uFvPExiob04ry0ZDP8I7uV8zeQ=;
 b=e6UC010Py/dUGatRKJG8V9iQsopYPMzQN6Difca9XC6Mm4N2yc3B8p9uUkNvb7wQa+
 9/XPeBtJp7/7YN2fbDEe/jLwsUd9Vir1/KH4lImItqThcFbQ6TqYgz/vpbmY1VAcxKbb
 FIqhUhlxihjnWhOgrVQHLtR+Yx4TbrzE9b9D0hCdUhXhGQ22lpR9CSxgy70XIVmN9iS+
 tr2c3Nfgy6H9VgtGsia9OEC5RAaxDguyc7DJ3FJoyMKOUpyaIcPqaOYwUvi8tboau1zG
 +FedvsKzZH/Y04s4WXTC+B9e2MEhmFAqaAn3b4AI1EpMrNOh9dX701p4R0LajUey5tdx
 7WzQ==
X-Gm-Message-State: AOJu0YwKeTEMnlHHqVgVW3VeTSPJl52Sx2UmjyaeQ8TLjFq01J68+J/g
 VZOlQ9T4XWJs71jiS2sQgHzxatuz/c8=
X-Google-Smtp-Source: AGHT+IEl+gJ6vNF8g2rO45kATijNUtPn7e+qpirs8ubt07L9+xSJlOevbWnbWXCL45v9gOVeII9EsQ==
X-Received: by 2002:adf:d4cb:0:b0:319:5677:f832 with SMTP id
 w11-20020adfd4cb000000b003195677f832mr7019298wrk.62.1692706239479; 
 Tue, 22 Aug 2023 05:10:39 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 a2-20020adffac2000000b0031753073abcsm15704611wrs.36.2023.08.22.05.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 05:10:39 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v2 0/7] Add support for QEMU's ramfb display
Date: Tue, 22 Aug 2023 15:10:18 +0300
Message-Id: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
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

This is a rebase of Alexander Graf's QEMU ramfb support series with
some changes of mine, in part to address reviews and to accommodate
other changes enabling Bochs video driver. The original cover letter is
as follows:

> QEMU implements multiple ways to expose graphics output to the virt
> machine, but most of them are incompatible with hardware virtualization.
>
> The one that does work reliably is ramfb. It's a very simple mechanism
> in which the guest reserves a memory region for the frame buffer and then
> notifies the host about its location and properties. The host then just
> displays the contents of the frame buffer on screen.
>
> This patch set adds support to drive the ramfb device in our QEMU arm
> targets. Theoretically, it should work as is with any of the other
> architectures as well though.
>
> With this driver, we have a very simple, KVM compatible way to expose
> GOP via UEFI to payloads and thus enable development and testing of
> graphical OS functionality with QEMU's -M virt.

Inspired by the "video: bochs: Remove the x86 limitation" series [1]
that was recently merged, I have also sent a series adding Bochs
video device support for ARM [2], and assuming that would get merged
before this I've rebased this on that to avoid conflicts.

[1] https://lore.kernel.org/u-boot/20230723044041.1089804-1-bmeng@tinylab.org/
[2] https://lore.kernel.org/u-boot/20230814173944.288356-1-alpernebiyasak@gmail.com/

Changes in v2:
- Remove extra "depends on DM_VIDEO" already in "if VIDEO"
- Drop drivers/video/MAINTAINERS file
- Decouple framebuffer allocation from EFI_LOADER
- Add .bind() method for ramfb driver
- Make resolution configurable with kconfig
- Move struct to qfw.h and add comments for members
- Use RAMFB_* definitions instead of DEFAULT_*
- Use if (IS_ENABLED(CONFIG_VIDEO_RAMFB)) instead of #ifdef
- Add patch "qfw: Add flag to allow probing before relocation"
- Rebase on "qemu: arm: Enable Bochs, console buffering, USB keyboard"
- Drop env changes from ARM (necessary but in prerequisite series)
- Drop imply VIDEO, SYS_CONSOLE_IN_ENV changes from ARM (in prereq.)
- Probe QFW in ARM QEMU board_early_init_f to bind ramfb pre-reloc
- Add IS_ENABLED(CONFIG_QFW) check and error handling to ARM QEMU
- Drop imply VIDEO, env changes from RISC-V patch (in u-boot/next)
- Drop imply SYS_CONSOLE_IS_IN_ENV from RISC-V patch (def. y if VIDEO)
- Probe QFW in RISC-V QEMU board_early_init_f to bind ramfb pre-reloc
- Add IS_ENABLED(CONFIG_QFW) check and error handling to RISC-V QEMU
- Add patch "x86: qemu: Enable ramfb by default"

v1: https://lore.kernel.org/u-boot/20220227144043.37359-1-agraf@csgraf.de/

Alexander Graf (5):
  qfw: Add WRITE definition
  ramfb: Add driver for ramfb display
  qfw: Spawn ramfb device if its file is present
  arm: qemu: Enable ramfb by default
  riscv: qemu: Enable ramfb by default

Alper Nebi Yasak (2):
  qfw: Add flag to allow probing before relocation
  x86: qemu: Enable ramfb by default

 arch/arm/Kconfig                        |  3 +
 arch/x86/cpu/qemu/Kconfig               |  4 +
 board/emulation/qemu-arm/qemu-arm.c     | 41 +++++++++++
 board/emulation/qemu-riscv/Kconfig      |  5 ++
 board/emulation/qemu-riscv/qemu-riscv.c | 41 +++++++++++
 board/emulation/qemu-x86/qemu-x86.c     | 47 ++++++++++++
 configs/qemu-x86_64_defconfig           |  4 +-
 configs/qemu-x86_defconfig              |  1 -
 drivers/misc/qfw.c                      | 25 +++++++
 drivers/misc/qfw_mmio.c                 |  1 +
 drivers/misc/qfw_pio.c                  |  1 +
 drivers/misc/qfw_sandbox.c              |  1 +
 drivers/video/Kconfig                   | 30 ++++++++
 drivers/video/Makefile                  |  1 +
 drivers/video/ramfb.c                   | 97 +++++++++++++++++++++++++
 include/qfw.h                           | 11 +++
 16 files changed, 309 insertions(+), 4 deletions(-)
 create mode 100644 drivers/video/ramfb.c


base-commit: 832148f675e427060be074c276956962fa9b5cb6
prerequisite-patch-id: 2c8662d18f6f1e2d4e014bcd5d468e0396064f4f
prerequisite-patch-id: 5f3e5e1d814187841ce299df0da16df16d0121c3
prerequisite-patch-id: adbd0fb953e726ea5ea0b248e00092dfc318fd46
prerequisite-patch-id: 7470d3af5e9ded16eb5a4de7c7264062dcb3ef7f
-- 
2.40.1

