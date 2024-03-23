Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EEFC54E58
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 18:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9425687947;
	Sat, 23 Mar 2024 19:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N0wPjbwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C71188785E; Sat, 23 Mar 2024 19:07:21 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35C4D87D0A
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 19:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0016C6091A;
 Sat, 23 Mar 2024 18:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B68C433F1;
 Sat, 23 Mar 2024 18:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711217236;
 bh=ZWrUgsfbd7kJrDzkp5nIlBY9SbiV10R1KZRUwTZizfA=;
 h=From:To:Cc:Subject:Date:From;
 b=N0wPjbwgU2jMlAYN72ZrzMlO9b1ydTDsdmQ0xEuA+mXkZCLQiAjLVMGD70EZJnC9P
 KPoY8Ck6BSQuNRN5qXwRI2S+EFdcCEeMAbL3kJotLtvnZjWYkUe+qz0qeoqyiOE1JN
 CY8aY2oREhiyx7hwMiqrvUBSXrYi/qzPO0QonTUKUhpAVmpvlo8rtpNbE6FlQyP209
 KHdcAd3mgErnR+Ha8TFvcaFc+7B3T2vJ119CGQxyorFX9bbgwMaETkD+XTjXL2FmQM
 SrIH5GtZfXk1aDVUcBP/XrfIYIBoZzqaD/iFQN+BjyrMP9gr3b2zzQEvsx236G+pdT
 0Jpk96lKAdnOw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH u-boot-mvebu v2 00/18] Turris Omnia - New board revision
 support
Date: Sat, 23 Mar 2024 19:06:53 +0100
Message-ID: <20240323180711.5498-1-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Stefan,

this is v2 of series adding support for new board revision of Turris
Omnia.

See v1 at
  https://patchwork.ozlabs.org/project/uboot/cover/20240304152148.3847-1-kabel@kernel.org/

Changes since v1:
- MCU firmware features can be 32-bit wide, updated the code to support
  reading 32 bits of features (both in board driver and in gpio driver)
- gpio driver now moved to misc, since it handles more functionality
  (rng, sysreset)
- mvebu system-controller driver expanded to also support UCLASS_SYSRESET,
  configurable by config option
- LTO enabled by default for Turris Omnia, otherwise it won't fit into
  the space reserved for U-Boot with these changes
- enabled the poweroff command (via sysreset) in defconfig (new MCU
  firmware can power off the board voltage regulators)
- enabled the rng command in defconfig

Marek Behún (18):
  arm: mvebu: turris_omnia: Enable LTO by default on Turris Omnia
  arm: mvebu: turris_omnia: Add header containing MCU command interface
    and use it
  arm: mvebu: turris_{omnia, mox}: Don't print model two times
  arm: mvebu: turris_omnia: Update MCU status and features reading
  arm: mvebu: turris_omnia: Implement getting board information from MCU
  arm: mvebu: turris_omnia: Print board ECDSA public key if available
  arm: mvebu: turris_omnia: Disable Atmel SHA node if not present
  arm: mvebu: spl: Do not build mvebu-reset in SPL
  arm: mvebu: system-controller: Rework to use UCLASS_SYSCON
  arm: mvebu: system-controller: Select mvebu-reset if DM_RESET &&
    PCI_MVEBU
  arm: mvebu: system-controller: Add support for SYSRESET
  gpio: turris_omnia_mcu: Use byteorder conversion functions
  gpio: turris_omnia_mcu: Update firmware features reading
  gpio: turris_omnia_mcu: Add support for system power off via sysreset
  arm: mvebu: turris_omnia: Enable poweroff command via sysreset in
    defconfig
  cmd: rng: Print "Abort" on -EINTR
  misc: turris_omnia_mcu: Add support for rng provided by MCU
  arm: mvebu: turris_omnia: Enable rng command in defconfig

 arch/arm/mach-mvebu/Kconfig              |  25 ++
 arch/arm/mach-mvebu/Makefile             |   3 +-
 arch/arm/mach-mvebu/cpu.c                |   2 +
 arch/arm/mach-mvebu/system-controller.c  | 144 ++++++--
 board/CZ.NIC/turris_atsha_otp.c          |  27 +-
 board/CZ.NIC/turris_mox/turris_mox.c     |   5 +-
 board/CZ.NIC/turris_omnia/Makefile       |   2 +-
 board/CZ.NIC/turris_omnia/turris_omnia.c | 310 ++++++++++++-----
 cmd/rng.c                                |   7 +-
 configs/turris_omnia_defconfig           |   6 +
 drivers/gpio/Kconfig                     |   7 -
 drivers/gpio/Makefile                    |   1 -
 drivers/gpio/turris_omnia_mcu.c          | 316 -----------------
 drivers/misc/Kconfig                     |  11 +
 drivers/misc/Makefile                    |   1 +
 drivers/misc/turris_omnia_mcu.c          | 411 +++++++++++++++++++++++
 include/turris-omnia-mcu-interface.h     | 238 +++++++++++++
 17 files changed, 1034 insertions(+), 482 deletions(-)
 delete mode 100644 drivers/gpio/turris_omnia_mcu.c
 create mode 100644 drivers/misc/turris_omnia_mcu.c
 create mode 100644 include/turris-omnia-mcu-interface.h

-- 
2.43.2

