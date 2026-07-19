Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC825C4450A
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 18:36:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F34D484A6F;
	Sun, 19 Jul 2026 20:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="VC6WK/b7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4841184A5D; Sun, 19 Jul 2026 20:04:10 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 385008494B
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 20:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=asrinivasan@tenstorrent.com
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6685483aad2so740125d50.0
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1784484246; x=1785089046; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AVZUiDKHF89LAykh4hruuwA49WfTUxhRzPOs3xUFEnU=;
 b=VC6WK/b7tbSZetpVlg2VZH65iYwf5CpRedBakvMgLwVUHtbPz8B/P/TgSkboVA2nf4
 4N4IWd5x8p09KRdZ5tPUIad2VH0tCij1B0ZezkEC3NMQ3x7yexTy1YuJ4U4BoHznzgLZ
 Pxu0AecTs3jcZi4+SV4KEzUpsCagY8T2sBL/wFPvumiZX3eZNgQOvbdimpyxDhy6E8To
 s+e7I5uyEQWjNc/vTfhMk1LfHwKxIM2G2HHAT/xac38HmVKYiX9Tvlntak+NnOg5E0lN
 mgWX6J8Ck3jqozzTsVBXwfa5Vwc6L89w/YPvR2vcNPDecZucvzj9Zdakn6ZL8CbgmuoU
 hUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784484246; x=1785089046;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AVZUiDKHF89LAykh4hruuwA49WfTUxhRzPOs3xUFEnU=;
 b=oK9wVFTl1OIzw4WeiNN04teAXm69gEnx5wq89zis4OwSxH3QXGrQHRbzWSt6xh/7vG
 Yu8gcdE0ohHEYZvH0d+chQUYzDIj4Ue/XMelTwkOVvfoHj4xvM55OZFSGbEb6C9qZI7G
 rgsEAwZgJfVrc2GcpbVfxRzK5WkulhEjc9mmpzQ7n2op0CAQRY3XOnblJvw6wrjZjPoi
 mQL6Rol1cXWigC/AlyuQQZEZY8hJM/szFf9CQECAN2JjeYhSl88zg+gmBoqgXy2wijQr
 jkvHdiBIBd9xBx7F3mdX6DQ9rOVRy29XXvr452lOupbM3ezBGdXEsOwWMCqs93bk8CBM
 4x3A==
X-Gm-Message-State: AOJu0YxO9qzcIqX69BOQwQU/ArmRz4GmOorsOjZGpH5jO/4P8AstrCUN
 uwdpQTuCX+8j2p1Nb4EkqAkqCYdgW6AmG6Taw4WzDhDgfAx89V4pyKVc/rAtExqEvT8=
X-Gm-Gg: AfdE7ckL8lLSrFKdUQbWZCM/uEaswdEPfXQ1yyvi4DHP+pt5A/sGexqr+h3K4WkgCsl
 atASULcvrJQbUnqicfnbFz8riLo9pYUfTu7U8H8kNGJWhGn1E7H32F3WG5lwH9uSGVYBU4Ig0B6
 wROBpw1FWpIUhvVzQzd+FOYmQh1cAezCm9CKX+NwCiCL6VmZYW6MZNWl4jJpjVdhHAYfI/4fmUC
 wLzK05QDhmlhGGj32HC+X43SmJHax3uhXVNZdJPD8lYnKcD3ciSJvBjwdF8+rriYoQD3594fMly
 b6rWOSGCYUoQ/g66+bidcm8L36LMAoq+IcK/H4seVuk+A0b5TOewB7B9PS70VRwzW9ehtNyLzbc
 0CTf/WlVjwBH78Qq38EIi1o6HKflY6Zqv78xzS3ACFB8orgnZC/wx73v85uw/O+6/01lnl6wkdu
 3iLs+PChI+1fGbE4gTBdsWtcKOzp1/iiVJKxT9srJvCT2FanGki0Ch1A==
X-Received: by 2002:a53:d105:0:b0:668:1c09:aef1 with SMTP id
 956f58d0204a3-6683bb2e9f2mr2352656d50.6.1784484245839; 
 Sun, 19 Jul 2026 11:04:05 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:423:c42:416:fc31])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6683b513a3esm4879882d50.2.2026.07.19.11.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 11:04:05 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Subject: [PATCH 0/8] Misc Fixes for VGA BIOS Emulation
Date: Sun, 19 Jul 2026 13:03:31 -0500
Message-Id: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHMRXWoC/yXMywqDMBSE4VeRs24gBi9pX6UUicloTxcqOVYE8
 d2NuvwY/tlIEBlCr2yjiIWFxyEhf2Tkv27ooTgkk9Gm0nVulZMJCM3S8ihNxytEhcI+tYcpbe0
 phVPENaTu/bkt//YHP59PtO8H/v6fe3YAAAA=
X-Change-ID: 20260718-aspeed_vbios_fixes-d4890ce2587c
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Martin Herren <sputnik@on-the-web.ch>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Sun, 19 Jul 2026 20:36:10 +0200
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

This series contains a bunch of mischallaneous fixes to the BIOSEMU
codebase to get display output working in u-boot using an Aspeed AST2600
PCIE VGA card on a RISC-V system that doesn't support I/O ports. This
was tested by passing the card through to a qemu riscv64 VM, but should
work on any board supporting PCIe in u-boot.

Patches 1-5 contain misc fixes to drivers/bios_emulator that are
suitable for upstream. I would like to get these reviewed and merged in
if possible.

Patches 6, 7, 8 are an implementation of how I got u-boot to actually
talk to to the Aspeed VGA card. The Aspeed has a set of MMIO registers
in PCIe BAR2 that mirror the I/O ports, so all the reads and writes to
the I/O ports are forwarded to this region. It doesn't use any of the
I/O port read/write emulation that is currently in u-boot (which also
means that the read/write functionality I added in Patches 1-5 aren't
exercised in this path, they are just there to expand the range of I/O
ports whose accesses must be forwarded to the MMIO region).

I am not sure if the way in which this is implemented is suitable for
upstream yet, so I was hoping to get some feedback on how to do this
correctly. Maybe this is probably never upstreamable, if that's the
case, please tell me that too.

There some checkpatch warnings, but these are from existing pieces of
code that I've copied/refer to, so I haven't tried fixing/changing them.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
Anirudh Srinivasan (8):
      bios_emulator: select X86EMU_RAW_IO only on x86
      bios_emulator: don't free a caller-supplied BIOS image in biosemu_run
      bios_emulator: use driver-model functions for PCI config acceses
      bios_emulator: support 16-bit reads on VGA port
      bios_emulator: extend VGA I/O ports to include ports 0x3B4-0x3DA
      [NOT-FOR-UPSTREAM] video: Add Aspeed VGA driver
      [NOT-FOR-UPSTREAM] bios_emulator: Support IO port reads for Aspeed VGA cards
      [NOT-FOR-UPSTREAM] Enable biosemu and vesa video output in qemu riscv64 virt machine

 arch/riscv/Kconfig                      |  1 +
 configs/qemu-riscv64_smode_defconfig    |  6 +++
 drivers/bios_emulator/Kconfig           |  4 +-
 drivers/bios_emulator/atibios.c         | 32 ++++++++++++-
 drivers/bios_emulator/besys.c           | 60 ++++++++++++++++++++----
 drivers/bios_emulator/include/biosemu.h |  5 ++
 drivers/video/Kconfig                   | 10 ++++
 drivers/video/Makefile                  |  1 +
 drivers/video/aspeed_vga.c              | 81 +++++++++++++++++++++++++++++++++
 9 files changed, 188 insertions(+), 12 deletions(-)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20260718-aspeed_vbios_fixes-d4890ce2587c

Best regards,
--  
Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

