Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E111CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D95A86BA4;
	Mon, 16 Oct 2023 16:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fn5rrBVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B429586823; Mon, 16 Oct 2023 16:14:15 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC3EF86C26
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B53220007;
 Mon, 16 Oct 2023 14:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1697465651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ajd+LGh9aWWXu9Q4FuoK1tmp+xhBFYVskTFDBwohTlg=;
 b=fn5rrBVAPKgsWJOTuuMmO21yD2bueP1isik6OkvrcHJ4PqBMXhZClgRp3strlQb89iakr8
 RUjNSHb4E1s/c3lU+QkQ4qAEiNLbk5qlgj6LQ9OE324IrxMMg9IACg82cesKHCZsgqFe5a
 7bGmDJ7Mbf4zk+tgTCRvj/X9+ZwVVFiY7xWLdcSPxQVb0xhY+mskgLcQyX0wMEaSaf4ihK
 HDjpnx18rZkz2KV487ihRXpSimKyRl0IxDGbjMVy4fnVH6GKP5hOsE9T1qe8Ua4nIQvpRq
 yThx2yXLkXFK0vXqnjtzFtrIsTXP/s9S7UCmEduUp/7AOpB3V6X/SHPFv8inpg==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: nm@ti.com, thomas.petazzoni@bootlin.com, thomas.richard@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bryan Brattlof <bb@ti.com>, Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Gowtham Tammana <g-tammana@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Tobias Waldekranz <tobias@waldekranz.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/9] Suspend to RAM support for K3 J7200
Date: Mon, 16 Oct 2023 16:11:26 +0200
Message-Id: <20231016141135.325698-1-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
X-Mailman-Approved-At: Mon, 16 Oct 2023 16:15:24 +0200
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

A test_enter_sleep command was implemented to be able to test the
suspend sequence from U-Boot. It is only for test, the resume will not
work.


Gowtham Tammana (1):
  DO NOT MERGE: arm: dts: k3-j7200-r5-common: Add pmic node for esm

Gregory CLEMENT (3):
  configs: j7200_evm_r5: Used reserved memory in DDR for stack
  configs: j7200_evm_r5: Move address used for allocation in the
    reserved space
  cmd: test_enter_suspend: Add test_enter_suspend command

Thomas Richard (5):
  board: ti: j721e: Add resume detection for J7200
  ram: k3-ddrss: Add exit retention support
  board: ti: j721e: Add the missing part of exit retention for k3-ddrss
    (J7200)
  board: ti: j721e: During resume spl restores TF-A and DM-Firmware
  arm: mach-k3: j7200: Skip fit processing when resuming

 .../arm/dts/k3-j7200-r5-common-proc-board.dts |  17 +-
 arch/arm/mach-k3/common.c                     |  37 ++-
 arch/arm/mach-k3/include/mach/j721e_spl.h     |  29 ++
 arch/arm/mach-k3/sysfw-loader.c               |  16 +-
 board/ti/j721e/evm.c                          |  79 +++++
 cmd/Kconfig                                   |   7 +
 cmd/boot.c                                    |   8 +
 configs/j7200_evm_r5_defconfig                |   4 +-
 drivers/firmware/psci.c                       |  23 ++
 drivers/ram/k3-ddrss/k3-ddrss.c               | 302 ++++++++++++++++++
 include/command.h                             |   2 +
 11 files changed, 514 insertions(+), 10 deletions(-)

-- 
2.39.2

