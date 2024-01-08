Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27B9C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 16:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F177E87A34;
	Mon,  8 Jan 2024 17:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="kiGy8uvV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5090387A99; Mon,  8 Jan 2024 17:58:05 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C693A87463
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 17:58:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 175EFFF806;
 Mon,  8 Jan 2024 16:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1704733081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kGePgtduf9UP9cEx9EiiqHqUiDeI5c2SxlkKIWXKsgo=;
 b=kiGy8uvVS9JajGN/WfHLPpo6zYogsfsXncLq1YyRDf3D6VVkATCMIvzsLc5VLsMoaq+TVD
 YuUCvEAZJE48vsMiP8zLc7fiwPnB0sHCKQQNTgZB9fK2LvqpY0zlOvoW6xnky2UNmsPTfa
 Xv0fpRgfEh4VzOEUp1mRdzmB59FvkNhDcGv7dbLK7bxvFYezAlL/ti6B2r0BRsO0YGjcjo
 ZAPDE/ywMg3iHQz+EZ9t2mO3LD7806QdDe4SKki+dR5aTGAvmcV9sktnVIKE94IxItFeEK
 RsKnQz6ifH3dMai519UGNr9ZqyouV1LQKzNF4SjLLs+jnWSvl9MPclADm8nboQ==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: thomas.petazzoni@bootlin.com, thomas.richard@bootlin.com, nm@ti.com,
 u-kumar1@ti.com, gregory.clement@bootlin.com, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Gowtham Tammana <g-tammana@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/8] Suspend to RAM support for K3 J7200
Date: Mon,  8 Jan 2024 17:56:20 +0100
Message-Id: <20240108165628.3935756-1-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
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

This series is the U-Boot part of the work to add the suspend to RAM
support for the K3 J7200 EVM board.

During the boot R5 SPL makes a copy of DM-Firmware and TF-A in memory.
Resume detection is done by reading a magic value in a pmic register
(set by DM-Firmware).

If a resume is detected, R5 SPL run the exit retention sequence of the
DDR. Then it load TF-A and DM-Firmware using the copies done during the boot
(fit image processing is skipped).
Before to start TF-A, R5 SPL writes a magic value in scratchpad ram. This
will be used by TF-A to detect that the board is resuming.

The copy of TF-A/DM-Firmware, the SPL stack and malloc are located in a
reserved memory region (for the kernel point of view) to avoid any
memory corruption.

This version is mostly to test the firewall protection with the suspend
to ram.
Some comments (for the v2) were not fixed in this version.
This series has been tested with the series [1] to enable the firewall.
At the end of the resume sequence, TF-A is well protected by the
firewall, but OP-TEE remains unprotected.

[1] https://lore.kernel.org/all/20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com/


Changes in v3:
- At resume, R5 SPL doesn't restore TF-A anymore.
  TF-A is started like during a cold boot. R5 SPL will notify that the board is
  resuming using a magic value written in the scratchpad ram.
  TF-A will restore itself.
- Link to v2:
  https://lore.kernel.org/u-boot/20231107161802.855154-1-thomas.richard@bootlin.com/

Changes in v2:
- Set exit retention code for DDR behind CONFIG_K3_J721E_DDRSS
- Check if TF-A is running in DRAM, if yes no need to restore it
- Remove BL31_START macro, and get TF-A start address from the fit image
- Remove the test_enter_suspend command
- Link to v1:
  https://lore.kernel.org/u-boot/20231016141135.325698-1-thomas.richard@bootlin.com/

Gowtham Tammana (1):
  DO NOT MERGE: arm: dts: k3-j7200-r5-common: Add pmic node for esm

Gregory CLEMENT (2):
  configs: j7200_evm_r5: Used reserved memory in DDR for stack
  configs: j7200_evm_r5: Move address used for allocation in the
    reserved space

Thomas Richard (5):
  board: ti: j721e: Add resume detection for J7200
  ram: k3-ddrss: Add exit retention support
  board: ti: j721e: Add the missing part of exit retention for k3-ddrss
    (J7200)
  board: ti: j721e: During resume spl notify tf-a that the board is
    resuming
  arm: mach-k3: j7200: Skip fit processing when resuming

 .../arm/dts/k3-j7200-r5-common-proc-board.dts |  17 +-
 arch/arm/mach-k3/common.c                     |  65 +++-
 .../arm/mach-k3/include/mach/j721e_hardware.h |   1 +
 arch/arm/mach-k3/include/mach/j721e_spl.h     |  30 ++
 arch/arm/mach-k3/sysfw-loader.c               |  16 +-
 board/ti/j721e/evm.c                          |  77 +++++
 configs/j7200_evm_r5_defconfig                |   4 +-
 drivers/ram/k3-ddrss/k3-ddrss.c               | 307 ++++++++++++++++++
 8 files changed, 507 insertions(+), 10 deletions(-)

-- 
2.39.2

