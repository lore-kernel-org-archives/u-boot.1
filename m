Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5275F01822
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 10:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D231B838BB;
	Fri,  6 Mar 2026 11:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RjAEsATk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD308839A8; Fri,  6 Mar 2026 03:36:58 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64123836D3
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-899fc9853b7so68968766d6.2
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764615; x=1773369415; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gxMmuum0xpweUY2d6NUGW0yXnNLFgO3MTyFl661n3Hc=;
 b=RjAEsATkuemvgTWeTOoyHEQcZikIrRrLKsyMamdKSScCuA6AYGSD9pVfM1HLvfocjZ
 Nq0nyGi9DZBT0uBY3J3RB/UDx5VOBVB/YeVIGR5g/K4jagpYu7ASmC/UOv0DdG4DQyFL
 sYUE2+mOTfVAG/NEeR+E0E+lkvtD+e1gCJ3gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764615; x=1773369415;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gxMmuum0xpweUY2d6NUGW0yXnNLFgO3MTyFl661n3Hc=;
 b=KZAolXREL41EQGvzOpRfXfpuLcmqHnTIVRzS41ERoYDL2hiK7NnR6QIIT1oVRjLbpW
 LYyShqpeP4Rl8Fi509vvyYWzzsCHpl4xepu4jAPzriq+WnX5MM24xx7Dpb98akFeI0LS
 lanH+xsB5pgamtXQ7koOVue8e/v783J7nsFQO0z+0AP53vWoaBtX3GhxeyKzNV07hQJO
 joYPLaSia94uTVBLqU9WJG3DB7Sjv69o6/5rJMLiV8OoCoOx6Mt1q5NwcObt7hpRCQJv
 JtaQT105BEV7y73y8JxyuVwA7v3p3Cqw/X1HM1fgO0HAtBscFtJhVtIIdjk3BTknknky
 wjiA==
X-Gm-Message-State: AOJu0YxtqRWTkIcMTqvV6br65IWwkCR2V65LjB8zmzMjFJEA63X6akwD
 m51OWVPNISCSNJhV75OLyJCdail5J9QRGkx1LQuuK6buYtagd4BTO2D3ndgPN3zZwsj7NdWUbjd
 Pp/U=
X-Gm-Gg: ATEYQzyw2KWwPTtgHG2FdrIt8CHEil7ZlNitCDmG9a4YgpBpvbbRSQPZSOXre6lTAc8
 s8B19PCq58BQVlrchZ/4MIDR58klaDKNa70qMC+p0rQMm7qgp3S7wRLqoMj/NoWubfwnddaLZNq
 +2cpjBEJEI0QSUnDO5+de/7KRxzZ/fXLr3BYpRgf5AhoCyfdyak4iQXEHxUuN7vw2GzuzuVvqTj
 sgNkyJGIvYIzP0DABGAd/buWkMcKQs/azfYm8RzhVEbBbPiLmCPRvKyqc/x8SRWnkFMQa8d2YDr
 vtwXerRjAefZ2yZnV5z9qadHdWQ28DRLPHpwF99V6HHDDHB1nbmzhQCAPzVfyOa7H5zkNxG91Ju
 G/8sGFYdi2Jv1ig1RemrGabLvTQZdj5lSFsVaLIe7KyYncHRt8F7lTEF7gjZGRbi+HtidX/XZ7x
 XmGiPvb39abw5URtC/Hw==
X-Received: by 2002:a05:6214:529b:b0:89a:16f:423b with SMTP id
 6a1803df08f44-89a30a5ac5emr5878506d6.18.1772764614621; 
 Thu, 05 Mar 2026 18:36:54 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:36:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>, Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>,
 Aristo Chen <jj251510319013@gmail.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Bin Meng <bmeng.cn@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Guillaume Ranquet <ranquet.guillaume@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rick Chen <rick@andestech.com>,
 Scott McNutt <smcnutt@psyent.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Thomas Chou <thomas@wytron.com.tw>,
 Vishnu Singh <v-singh1@ti.com>, Wolfgang Denk <wd@denx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 00/17] bootm: Clean up arch-specific, pre-OS clean-up
Date: Thu,  5 Mar 2026 19:36:09 -0700
Message-ID: <20260306023638.2678886-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Mar 2026 11:20:36 +0100
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

Each arch does something slightly different before booting the OS. Some
archs even do different things depending on the CPU type.

It is quite hard to know what actually happens in the final milliseconds
before the OS boot.

This series attempts to start cleaning up U-Boot in this area.

The basic intent is to create a new bootm_final() function which can be
called by all archs. It provides some flags for a couple of necessary
variations but otherwise it is generic.

All architectures are converted over to use this new function.

board_quiesce_devices() is moved into bootm_final() so that all archs
benefit from it.

This series fixes a bug in device_remove() is fixed where removing a
parent with specialised flags (e.g. DM_REMOVE_ACTIVE_ALL) could leave
children activated, since they do not match the flags. This fixes is
needed to avoid bootm_final() causing test failures on sandbox.

Future work could take this a little further:
- Convert EFI loader to use the same function
- Improve comments for cleanup_before_linux() across architectures
- Support fake-run tracing on all archs

Changes in v4:
- Drop announce_and_cleanup() in arm and riscv
- Drop announce_and_cleanup(), inline the two calls
- Pass flag directly instead of using BOOTM_FINAL_FAKE
- Print '(fake run for tracing)' when flag is set
- Use BOOTM_STATE_OS_FAKE_GO instead of new enum bootm_final_t

Changes in v3:
- Add dm: device_remove() fix for child removal with specialised flags
- Add new patch for ARC conversion
- Add new patch for ARM conversion (requested by Tom)
- Add new patch for MIPS conversion
- Add new patch for MicroBlaze conversion
- Add new patch for Nios2 conversion
- Add new patch for PowerPC conversion
- Add new patch for SH conversion
- Add new patch for Xtensa conversion
- Add new patch for bootstage stashing, needed for ARM conversion
- Add new patch for m68k conversion
- Add new patch for sandbox conversion
- Convert all remaining architectures
- Drop cleanup_before_linux() patch
- Drop the DMA comment move (now in the introductory patch)
- Drop udc_disconnect()
- Fix "the a" typo
- Introduce with all common functionality (not empty)
- Move board_quiesce_devices() into bootm_final() instead of dropping it
- Move bootstage dummies earlier in the series
- Move earlier in the series so bootm_final() can use bootstage from the start
- Put bootm_final() in bootm.c instead of a separate file
- Put in bootm.c instead of a separate file
- Squash in patches 2, 3 and 5 from v2
- Squash introductory patches so bootm_final() is introduced non-empty
- Squash with the previous riscv patches
- Update cover letter to match current series

Changes in v2:
- Drop patch 'efi: Drop EFI_GRUB_ARM32_WORKAROUND'
- Update cover message to reflect dropping the EFI patches, etc.

Simon Glass (17):
  dm: Move flags_remove() check before child removal
  dm: Remove children when parent is removed by flags
  bootstage: Add some missing dummy functions
  bootm: Create bootm_final() for pre-boot cleanup
  x86: Call bootm_final()
  riscv: Call bootm_final()
  bootm: Stash bootstage data in bootm_final()
  arm: Call bootm_final()
  arc: Call bootm_final()
  microblaze: Call bootm_final()
  mips: Call bootm_final()
  powerpc: Call bootm_final()
  m68k: Call bootm_final()
  nios2: Call bootm_final()
  sh: Call bootm_final()
  xtensa: Call bootm_final()
  sandbox: Call bootm_final()

 arch/arc/lib/bootm.c                  |  8 ++---
 arch/arm/lib/bootm.c                  | 50 ++++-----------------------
 arch/m68k/lib/bootm.c                 |  2 ++
 arch/microblaze/lib/bootm.c           |  8 ++---
 arch/mips/lib/bootm.c                 |  7 +---
 arch/nios2/lib/bootm.c                |  2 ++
 arch/powerpc/lib/bootm.c              |  7 +---
 arch/riscv/include/asm/u-boot-riscv.h |  1 -
 arch/riscv/lib/bootm.c                | 39 ++-------------------
 arch/sandbox/lib/bootm.c              |  1 +
 arch/sh/lib/bootm.c                   |  2 ++
 arch/x86/lib/bootm.c                  | 14 +-------
 arch/xtensa/lib/bootm.c               |  2 ++
 boot/bootm.c                          | 25 ++++++++++++++
 drivers/core/device-remove.c          | 34 +++++++++++-------
 include/bootm.h                       | 10 ++++++
 include/bootstage.h                   |  8 +++++
 17 files changed, 90 insertions(+), 130 deletions(-)

-- 
2.43.0

base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67
branch: bootma-us4
