Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED208E77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 03:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 998E789641;
	Fri,  6 Dec 2024 04:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fMqeCBd1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15AA089620; Fri,  6 Dec 2024 03:36:37 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A511A8918C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a7dcbdf1cdso11852535ab.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452593; x=1734057393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vUHt/CU+ORsyM5n8LWrBqGOJ3uj3Mdl4aZd/U73RpnQ=;
 b=fMqeCBd1++GtvptzCQDIZmGjEqGj2c++JlnhgIxkC2Qo8TNJeMMghfFm8ubpRozFTN
 6/CfGqymhUvOxy3tispAWYTb6rkBKRcHdiy0LJ4XzaN5RLSra3DBbatvNMpjevUeQYC/
 gkcngwq5DwupkkX1mKB/3AS50qTsTX13zhUNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452593; x=1734057393;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vUHt/CU+ORsyM5n8LWrBqGOJ3uj3Mdl4aZd/U73RpnQ=;
 b=ddUSbXRVwB96rg7dMTgX78vmd6g9HNeriKtMyzvZjFp/LPB0tk8PVPrMZUx4AuOLeG
 lZ7HsHhRNQ5b9szgBxG9z3E83b9MpIjFHW311hRxBBCzqcEAd5BWOf1pMGe1dCuXp2V8
 EguDgwuJZ+oq0X8ZbZcZrqQbK9nPiBrLw1m15/U67mBoFO1xtkayRs8copRajiuh/2Wf
 rmpE0SLYQmMYELCfVRcx1+YE4JgSLlUZhlPRUTLE/Tac3HjJ/WskBoljrrv5YANyXMOp
 vcnNAbniWZNoN/x+4kozGw1h3Ajo011sTwMMY3tYr2ON4LjBfcNABHEX6mkM1sSyQls3
 dNHA==
X-Gm-Message-State: AOJu0YzpgQ1kvK+0u/wfS8tFYW/X53DxGYwfboEg9x3qQJ2dWOrAA/Rg
 C84Z8cFAxDMzTGCzxa17XkrABkiEU/lU51XPIDQDvSa6MI917Q9fwoL4v4hNNYq2YhUw70/Yg04
 =
X-Gm-Gg: ASbGncujidbsx5qFYgV6l34+RPGYp5+jgNOUBmdWDeZBKv6No7WWv+9eZ9bgDNFYm6M
 zOlzd05P4qu/0FmS28ZT4ljtqEcPmFQoCYjvW5HjfO5DnrzJCpC4Spp9OhslkLL8Kn65REcPqLF
 csa7gSv7eswEReAMevLYILDOomBnFFJQD0/XZrvi7HHBYqWF81pxPuWrC5tLkTBWpwKGn1kjnaJ
 86SGt5QxZvBxkTs9TUTOPukJ1C6n8AEyv8euz9kXG8VP7pynozdXUSRceucQ7an3cMDUkhdW0Tk
 fgY+eHb+91U=
X-Google-Smtp-Source: AGHT+IHUkmseNEI69IC2bJFfMF4LJVzYy+MItpaaZ1BGAhLSKGDnRI3JnSjFlOALsFL9NUdayPAsrA==
X-Received: by 2002:a05:6e02:1c26:b0:3a7:d7dd:e70f with SMTP id
 e9e14a558f8ab-3a811db94f6mr20631165ab.12.1733452592791; 
 Thu, 05 Dec 2024 18:36:32 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:36:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 00/46] pxe: Support read_all() for extlinux and PXE
Date: Thu,  5 Dec 2024 19:35:39 -0700
Message-Id: <20241206023626.2456858-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Dec 2024 04:03:43 +0100
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

This series implements read_all() so that it is possible to read all the
files relating to a bootflow, make adjustments and then boot.

Unfortunately quite a few things stand in the way, so this series
finishes off several pending items: zboot without CONFIG_CMDLINE,
required support in pxe_utils and the differing code in the extlinux and
PXE bootmeths. There is very little new code, but quite a lot of
refactoring.

The bootm, booti and bootz commands have all been refactored previously,
so that they can operate without needing CONFIG_CMDLINE to be enabled.
At the, time, zboot was left alone, since it is x86-specific and a bit
more trouble.

However it turns out that the booti support doesn't work with compressed
booti images, so this series resolved that problem too.

This series adds a programatic API for zboot and uses the forthcoming
bootstd 'image list' to collect information from an extlinux file. It is
therefore possible to parse the file, load the resulting images and then
examine/adjust the resulting bootflow, before booting.

The addition of options to extlinux resulted in the PXE and extlinux
bootmeth having slightly different features. This is tidied up in this
series, with common functions for both. This allows the same features
(loading images as a separate step) to be provided for PXE.

Changes in v3:
- Add new patch to convert IMAGE_FORMAT into an enum
- Add new patch to add a format for the booti file
- Add new patch to support booti format in bootm
- Add new patch to support compressed booti images in bootm
- Pass through the bootfile since extlinux and PXE are different
- Pass through the bootfile since extlinux and PXE are different
- Add new patch to detect booti format properly in pxe_utils
- Pass through the bootfile since extlinux and PXE are different

Changes in v2:
- Split out strlcpy() change into new patch
- Move strlcpy() change into an earlier patch
- Fix 'initaddr' typo'
- Rebase on earlier change
- Add new patch to simplify the code reading fdtcontroladdr and fdt_addr

Simon Glass (46):
  x86: Make do_zboot_states() static
  x86: Rename zboot_run() to zboot_run_args()
  x86: Drop duplicate definition of zimage_dump()
  x86: Move x86 zboot state into struct bootm_info
  x86: Rename state to bmi
  x86: Move the bootm state for zimage into cmd/
  bootstd: Correct display of kernel version
  x86: Drop the unnecessary base_ptr argument to zboot_dump()
  boot: Use strlcpy() in label_boot()
  boot: Split pxe label_boot() into two parts
  boot: Split pxe label_run_boot() into two parts
  boot: Pass just the FDT argument to label_process_fdt()
  bootm: Allow building bootm.c without CONFIG_SYS_BOOTM_LEN
  boot: Convert IMAGE_FORMAT into an enum
  boot: arm: riscv: sandbox: Add a format for the booti file
  boot: Support booti format in bootm
  boot: Support compressed booti images in bootm
  boot: pxe: Use bootm_...() functions where possible
  pxe_utils: Simplify default fdt in label_run_boot()
  boot: pxe: Refactor label_run_boot() to avoid cmdline
  net: Keep the bootstage functions together
  net: Tidy up the comments to parse_args()
  net: Simplify parse_args()
  net: Return the load address from parse_args()
  net: Return the address and size from parse_addr_size()
  net: Return the size from parse_args()
  net: Refactor part of netboot_common() into a function
  net: Drop #ifdef in parse_args()
  net: Provide a function to run network operations
  boot: Avoid using the cmdline in bootmeth_pxe and pxe cmd
  pxe: Drop the cmdline parameter
  pxe: Record the bootflow in the PXE context
  pxe: Allow skipping the boot
  test: Update bootm test to restore silent_console
  bootmeth_extlinux: Move extlinux_info into plat
  bootmeth_extlinux: Move pxe_context into plat
  bootmeth: Refactor to put options in a common file
  bootmeth_pxe: Implement the fallback option
  bootmeth_pxe: Drop the driver-private data
  bootmeth_extlinux: Move boot code into common file
  bootstd: Update extlinux and pxe to allow boot interruption
  pxe: Collect the FDT in the bootflow
  pxe: Deal with a missing FDT in the bootflow
  boot: Detect booti format properly in pxe_utils
  pxe_utils: Refactor to separate reading from booting
  bootmeth_extlinux: Refactor extlinux to split boot

 arch/arm/lib/image.c          |   9 +-
 arch/riscv/lib/image.c        |   9 +-
 arch/sandbox/lib/bootm.c      |   5 +
 arch/x86/include/asm/zimage.h |  57 +---
 arch/x86/lib/zimage.c         | 102 ++++---
 boot/Makefile                 |   6 +-
 boot/bootm.c                  |  76 ++++-
 boot/bootmeth_cros.c          |   6 +-
 boot/bootmeth_extlinux.c      |  98 +------
 boot/bootmeth_pxe.c           |  50 ++--
 boot/ext_pxe_common.c         | 139 +++++++++
 boot/image-board.c            |  36 +--
 boot/pxe_utils.c              | 513 +++++++++++++++++++++-------------
 cmd/bootflow.c                |   8 +-
 cmd/net.c                     |  92 +++---
 cmd/pxe.c                     |  30 +-
 cmd/sysboot.c                 |   4 +-
 cmd/x86/zboot.c               |  33 ++-
 include/bootm.h               |  63 ++++-
 include/bootmeth.h            |   8 +-
 include/extlinux.h            |  60 +++-
 include/image.h               |  48 +++-
 include/net-common.h          |  30 ++
 include/pxe_utils.h           |  56 +++-
 net/net.c                     |  44 +++
 test/boot/bootflow.c          |  71 +++++
 test/boot/bootm.c             |   7 +
 27 files changed, 1127 insertions(+), 533 deletions(-)
 create mode 100644 boot/ext_pxe_common.c

-- 
2.34.1

