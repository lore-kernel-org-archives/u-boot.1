Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AF4C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 16:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC66B87512;
	Tue,  7 Nov 2023 17:18:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="a9OUhkGS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C04AD87514; Tue,  7 Nov 2023 17:18:45 +0100 (CET)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1569F87508
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 17:18:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 311E01C000C;
 Tue,  7 Nov 2023 16:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1699373922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rsFnNznu/T7hSJaRcxCO3Axx+wsXUJim6mmjBEkzksg=;
 b=a9OUhkGS7r/vb8mHQZL54J9nwKYPKnVZ86vwnXi2ixf/TEGADl74yO167DdZ3kgek6q5TX
 mXU3uYQ3eAZq7Py46njzrMb9C3wwb3pMkMGw8/M7JWvZiMXI4MI6HVIQFQ6PvOjdvewL3r
 9ZaOzm3IPuWzrQ5bWzRn4C1HL7YkmI51EIhQEVdsP3UXV9AIAe1efyH6FO2MIVBEgR/3Hk
 pHpXWPOR7GP68zgGiR7aOrzbBojK8ZO+Z+7y4eYWixHhdbF829H/8crz/eaeyXNzCfNBE6
 Frhn4wj4+HpKRvO2SavHaCxaFIuXhpnbZrNhI8v0LkTggtum8nyqns0ZnunJdA==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: nm@ti.com, thomas.richard@bootlin.com, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com, Bryan Brattlof <bb@ti.com>,
 Gowtham Tammana <g-tammana@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/8] Suspend to RAM support for K3 J7200
Date: Tue,  7 Nov 2023 17:17:54 +0100
Message-Id: <20231107161802.855154-1-thomas.richard@bootlin.com>
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

During the boot R5 SPL makes a copy of DM-Firmware in memory.
Resume detection is done by reading a magic value in a pmic register
(set by DM-Firmware).

If a resume is detected, R5 SPL run the exit retention sequence of the
DDR. Then it restores TF-A in SRAM (it saved itself to DDR), and load
DM-Firmware using the copy done during the boot (fit image processing
is skipped).

The copy of TF-A/DM-Firmware, the SPL stack and malloc are located in a
reserved memory region (for the kernel point of view) to avoid any
memory corruption.

Changes in v2:
- Set exit retention code for DDR behind CONFIG_K3_J721E_DDRSS
- Check if TF-A is running in DRAM, if yes no need to restore it
- Remove BL31_START macro, and get TF-A start address from the fit image
- Remove the test_enter_suspend command
- Link to v1: https://lore.kernel.org/u-boot/20231016141135.325698-1-thomas.richard@bootlin.com/

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
  board: ti: j721e: During resume spl restores TF-A and DM-Firmware
  arm: mach-k3: j7200: Skip fit processing when resuming

 .../arm/dts/k3-j7200-r5-common-proc-board.dts |  17 +-
 arch/arm/mach-k3/common.c                     |  48 ++-
 arch/arm/mach-k3/include/mach/j721e_spl.h     |  28 ++
 arch/arm/mach-k3/sysfw-loader.c               |  16 +-
 board/ti/j721e/evm.c                          |  79 +++++
 configs/j7200_evm_r5_defconfig                |   4 +-
 drivers/ram/k3-ddrss/k3-ddrss.c               | 307 ++++++++++++++++++
 7 files changed, 489 insertions(+), 10 deletions(-)

-- 
2.39.2

