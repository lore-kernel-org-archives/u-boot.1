Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21352CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 22:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 813A2848BA;
	Wed, 17 Jun 2026 00:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Zl1QE02B";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kQdWuEmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2E3F84910; Wed, 17 Jun 2026 00:15:20 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B63C846B0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 00:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gg1Wp1d01z9tSP;
 Wed, 17 Jun 2026 00:15:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781648118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rFLj0TJucThx4hZSBAfYAjZdMHbQHwS/L6EoLeO9L1M=;
 b=Zl1QE02BOfIzt/vHdEUx3zmnHblChBSRPfBvYEnQf0EbkJ5FI4hvEWZ1QX4x5cJLh/ee53
 7OkpRErvV+pAE5+Wbi/2gKSDTdx99VrRUGSEwczgFlBDUluxzVdJDTtFGBS12F1b8GblXM
 Sp93n1bGoKh+5CgsvM/q/tHa0EhrQ+ztKjSUheifyN3p8LkwxSRiAN3sZ77gbXQWUbF9jU
 cVn/RM3S7BuFdbQ8mLVBx36Hg59tUgua9vHPqsBb98E9LZ/uOkoA77/XuGPdf5hLe1Ud7Y
 zaNZf6YMy2NQj7PpngzN2bAfCTEfuqcOd7xFkjW3sOv0d/mpy9/4I69HAb6mVQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781648116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rFLj0TJucThx4hZSBAfYAjZdMHbQHwS/L6EoLeO9L1M=;
 b=kQdWuEmTh2ctkdMVLy08wNDQbc1NxTHixQwlAcntsU6uwVHZdWWyAaB+jDnmlkpXOGy0hd
 xc5XLXinNsmvqG9ySZgPg5heXKPpfm+Yd3ZMnNooitYocZ0EIGNjGl5H2stJQ2n5il/wCz
 4ulXGFyttzVSsKaUDc7fzFenQgCzNKTw88ndfKPaU8LhKf8PKyQUMVu+zPLVrYRtDZKmyH
 Zjc1aE3ZvegeqVStPpgu9rfRsA1KFhpNVf/779x48pKkb1hNHg6jAozLxn6ExcSX+NXMiA
 Rscoyp2Zihtkug028tVF5Z2Ow605hXkdD+Q6yEaDd/pKArYl2KSSBqsL2BAI1g==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Wed, 17 Jun 2026 00:12:17 +0200
Message-ID: <20260616221459.42663-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xfiigrujuzip7r3g1g6583j1gyid9hxa
X-MBO-RS-ID: d9b16b1164b58cee7f2
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

This is a DRAM controller driver for the R-Car X5H and its enablement.
This makes the U-Boot on RSIP usable beyond U-Boot shell running on
Cortex-M33, as the U-Boot on RSIP can now load not only SCP firmware
into the SCP core STCM, but also TFA BL31, OPTEE-OS and U-Boot into
DRAM and start them on the Cortex-A720AE core. This is self-contained
and affects only the R-Car X5H and a bit of R-Car V4H, besides it went
through rounds of testing until now, therefore it is safe to include
it this late in the release cycle. I know this will make rc5 massive,
sorry about that.

The following changes since commit badd97fe24dfb73b2728c26b433cabe315a27971:

  Merge patch series "Repair boards broken by the 6.1 kbuild bump" (2026-06-15 12:50:04 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 28f675023da174b1b4817266cac7bcf3ffb6d908:

  arm: dts: renesas: Enable DBSC5 on R-Car R8A78000 X5H Cortex-M33 RSIP port (2026-06-16 05:38:25 +0200)

----------------------------------------------------------------
Marek Vasut (3):
      ram: renesas: rtvram: Add support for Renesas R-Car Gen5
      ram: renesas: dbsc5: Add Renesas R-Car Gen5 DBSC5 driver
      arm: dts: renesas: Enable DBSC5 on R-Car R8A78000 X5H Cortex-M33 RSIP port

 arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi    |   10 +
 arch/arm/mach-renesas/Kconfig.rcar5                |    1 +
 board/renesas/common/gen5-cm33.c                   |   49 +
 board/renesas/sparrowhawk/sparrowhawk.c            |    2 +-
 configs/r8a78000_ironhide_cm33_defconfig           |    8 +-
 drivers/ram/renesas/Kconfig                        |    6 +-
 drivers/ram/renesas/Makefile                       |    2 -
 drivers/ram/renesas/dbsc5/Makefile                 |    4 +-
 drivers/ram/renesas/dbsc5/ecc.c                    |  168 +
 drivers/ram/renesas/dbsc5/qos.c                    |    2 +-
 .../renesas/dbsc5/{dbsc5.c => r8a779g0-dbsc5.c}    |    2 +-
 .../renesas/dbsc5/{dbsc5.h => r8a779g0-dbsc5.h}    |    6 +-
 .../ram/renesas/dbsc5/{dram.c => r8a779g0-dram.c}  |    4 +-
 drivers/ram/renesas/dbsc5/r8a78000-dbsc5.c         |   76 +
 drivers/ram/renesas/dbsc5/r8a78000-dbsc5.h         |   17 +
 drivers/ram/renesas/dbsc5/r8a78000-dram.c          | 2795 ++++++++
 drivers/ram/renesas/dbsc5/r8a78000-dram.h          | 7385 ++++++++++++++++++++
 drivers/ram/renesas/dbsc5/rtvram.c                 |   44 +-
 include/configs/rcar-gen5-common.h                 |   42 +-
 include/{dbsc5.h => r8a779g0-dbsc5.h}              |    0
 include/r8a78000-dbsc5.h                           |   63 +
 21 files changed, 10660 insertions(+), 26 deletions(-)
 create mode 100644 drivers/ram/renesas/dbsc5/ecc.c
 rename drivers/ram/renesas/dbsc5/{dbsc5.c => r8a779g0-dbsc5.c} (98%)
 rename drivers/ram/renesas/dbsc5/{dbsc5.h => r8a779g0-dbsc5.h} (80%)
 rename drivers/ram/renesas/dbsc5/{dram.c => r8a779g0-dram.c} (99%)
 create mode 100644 drivers/ram/renesas/dbsc5/r8a78000-dbsc5.c
 create mode 100644 drivers/ram/renesas/dbsc5/r8a78000-dbsc5.h
 create mode 100644 drivers/ram/renesas/dbsc5/r8a78000-dram.c
 create mode 100644 drivers/ram/renesas/dbsc5/r8a78000-dram.h
 rename include/{dbsc5.h => r8a779g0-dbsc5.h} (100%)
 create mode 100644 include/r8a78000-dbsc5.h
