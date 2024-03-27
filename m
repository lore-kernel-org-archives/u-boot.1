Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6494BC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 16:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1BD1880AC;
	Wed, 27 Mar 2024 17:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z+Zk9Z97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C361687F95; Wed, 27 Mar 2024 17:24:03 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F90888035
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 17:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EBECB615F2;
 Wed, 27 Mar 2024 16:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D7CC433C7;
 Wed, 27 Mar 2024 16:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711556639;
 bh=ePTVhfDAthlnPSErceMvBPpwP0nuucm6UUOO9vgVQ6k=;
 h=From:To:Cc:Subject:Date:From;
 b=Z+Zk9Z97LA3zp0dyq5AqLt7QRVlBNNDD8jnPxWJXdmBGckTUc5Md2YSgmL8PNbC6P
 Fz46whBtiO8Z02Lp5/Dt0oqbGVMTkEhfDuIc3RAFwqvIew31nwevk2SZwL44ky8ibO
 ztBwNTV2yTCvl43c3b/pr68iM94IdcvP6KfX7coB8ITraQFPG8PDeTtsMhygoupYJR
 MxcVNr66ZGxKX8xcanIfIMcR602bMghhQ5EIBveCtOTJt/+tCTPa8Y2CIs0xIaXdu+
 XpN0ubDKpgYXZuleVi2L3hZfh7K9ZUmFt4nXNDhvD2U+CwyDoesLu2l1ndbKsVbwXj
 OrnHdIMRroE0g==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH u-boot-mvebu v3 00/18] Turris Omnia - New board revision
 support
Date: Wed, 27 Mar 2024 17:23:37 +0100
Message-ID: <20240327162355.24584-1-kabel@kernel.org>
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

this is v3 of series adding support for new board revision of Turris
Omnia.

Changes since v2:
- patch 2: updated MCU command interface header
- patch 6: fixed bug setting \0 as end of string in src array instead
           of dst array after bin2hex() call
- patch 16: updated commit message (added the bit about ctrl+c)

v1 and v2 at:
  https://patchwork.ozlabs.org/project/uboot/cover/20240304152148.3847-1-kabel@kernel.org/
  https://patchwork.ozlabs.org/project/uboot/cover/20240323180711.5498-1-kabel@kernel.org/

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
 include/turris-omnia-mcu-interface.h     | 248 ++++++++++++++
 17 files changed, 1044 insertions(+), 482 deletions(-)
 delete mode 100644 drivers/gpio/turris_omnia_mcu.c
 create mode 100644 drivers/misc/turris_omnia_mcu.c
 create mode 100644 include/turris-omnia-mcu-interface.h

-- 
2.43.2

