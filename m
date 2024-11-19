Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917F3D44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A07A89555;
	Tue, 19 Nov 2024 14:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OTBFziWE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C93A289557; Tue, 19 Nov 2024 14:18:54 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 838FE8954F
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:18:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a7222089aaso13989425ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022331; x=1732627131; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LJMGAQxf1L4k5+EJXTUOVA7QBfoJ2wImRW8D69UYW08=;
 b=OTBFziWEhSZ4vnNcoSpwAhFzPgNRlCPojk/kFTR3t28L1J10xeOXYrR8er7BEWuyLl
 DE7zGDWG67tu78+Gai+8Jqz+h3PltYaKId6DO6kAFscLGjbUYqE531oFzfY2RFaCZk4A
 QgSNxY83+YCtiz12CIXhk8rRbzUshCDRgQaNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022331; x=1732627131;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LJMGAQxf1L4k5+EJXTUOVA7QBfoJ2wImRW8D69UYW08=;
 b=rsgNCPBk/SAzk2cMetitqi4Vg7MmsV8PfA3eiq0Uu2+RqqgL0GnTG+RBClg8iWPQ/k
 0i4bto8HnmGp56ld7Y7dYoJmFK4VrMqqlfinR6PEglpsDCMPVLxP4Son6OXOHjUVQ2T/
 UYbfWJGM0s/EHnS/nf9bh/bfm2QoN7It8mG5NsO9wWPqXSI24iMB5mlH1xjYgO/gAR+B
 mVCB9BVzVOOvSbYrl8smLOF/BcPRWzaFSI7gCuMNkVARWyx0SRaSv8BdIi+k1AbhfiSg
 K7aZBdsJ8JKZxb7Xd3hc9i4Y0yTh2Q9ymqc/QlG9Iukfn6QHXv51BiiPkt58EZKUOG4k
 J2+A==
X-Gm-Message-State: AOJu0YypbuQIxwQXYs13vrccQojc9dekx9NR8j+CQ2GaGW58CMVRK9ZS
 8BqRgDQ+qHt+XxdkwsYGYzfF/FHSiFJiS4/shItoGuSYBnGR8CiIqTooHf6ZKySsy4x2aJjyDJ0
 =
X-Google-Smtp-Source: AGHT+IHEAjvfVXMRKHc69efKZ+QKgsBwX87H67HlfqNkjW1luNlFvYUBdmhjHsTnVCLb1Pa706KxIA==
X-Received: by 2002:a92:c107:0:b0:3a7:6639:b1db with SMTP id
 e9e14a558f8ab-3a7773c92a7mr23372445ab.4.1732022330672; 
 Tue, 19 Nov 2024 05:18:50 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:18:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 00/39] pxe: Support read_all() for extlinux and PXE
Date: Tue, 19 Nov 2024 06:18:05 -0700
Message-Id: <20241119131844.4078144-1-sjg@chromium.org>
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

This series adds a programatic API for zboot and uses the forthcoming
bootstd 'image list' to collect information from an extlinux file. It is
therefore possible to parse the file, load the resulting images and then
examine/adjust the resulting bootflow, before booting.

The addition of options to extlinux resulted in the PXE and extlinux
bootmeth having slightly different features. This is tidied up in this
series, with common functions for both. This allows the same features
(loading images as a separate step) to be provided for PXE.


Simon Glass (39):
  x86: Make do_zboot_states() static
  x86: Rename zboot_run() to zboot_run_args()
  x86: Drop duplicate definition of zimage_dump()
  x86: Move x86 zboot state into struct bootm_info
  x86: Rename state to bmi
  x86: Move the bootm state for zimage into cmd/
  bootstd: Correct display of kernel version
  x86: Drop the unnecessary base_ptr argument to zboot_dump()
  boot: Split pxe label_boot() into two parts
  boot: Split pxe label_run_boot() into two parts
  boot: Pass just the FDT argument to label_process_fdt()
  bootm: Allow building bootm.c without CONFIG_SYS_BOOTM_LEN
  boot: pxe: Use bootm_...() functions where possible
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
  pxe_utils: Refactor to separate reading from booting
  bootmeth_extlinux: Refactor extlinux to split boot

 arch/x86/include/asm/zimage.h |  57 +---
 arch/x86/lib/zimage.c         | 102 ++++---
 boot/Makefile                 |   6 +-
 boot/bootm.c                  |   8 +-
 boot/bootmeth_cros.c          |   6 +-
 boot/bootmeth_extlinux.c      |  97 +------
 boot/bootmeth_pxe.c           |  48 ++--
 boot/ext_pxe_common.c         | 134 +++++++++
 boot/pxe_utils.c              | 507 +++++++++++++++++++++-------------
 cmd/bootflow.c                |   8 +-
 cmd/net.c                     |  92 +++---
 cmd/pxe.c                     |  30 +-
 cmd/sysboot.c                 |   4 +-
 cmd/x86/zboot.c               |  33 ++-
 include/bootm.h               |  63 ++++-
 include/bootmeth.h            |   8 +-
 include/extlinux.h            |  52 +++-
 include/net-common.h          |  30 ++
 include/pxe_utils.h           |  56 +++-
 net/net.c                     |  44 +++
 test/boot/bootflow.c          |  71 +++++
 test/boot/bootm.c             |   7 +
 22 files changed, 960 insertions(+), 503 deletions(-)
 create mode 100644 boot/ext_pxe_common.c

-- 
2.34.1

