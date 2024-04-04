Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67461CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDA35883AD;
	Thu,  4 Apr 2024 09:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y17Jf4kV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D85883B6; Thu,  4 Apr 2024 09:51:16 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5EC588393
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 45D00612EC;
 Thu,  4 Apr 2024 07:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24571C433F1;
 Thu,  4 Apr 2024 07:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712217072;
 bh=EdDiwgkX2/qG4nKv8+HB/1ktRRJAUYQx57VrpVVJ0uo=;
 h=From:To:Cc:Subject:Date:From;
 b=Y17Jf4kV2hQhhzmsmhcbyi/izrXa+eKdrGvb6qWhBHrbsFiTe/T4Y896VbqSNIIdy
 c+zuXZTVCGOksVrHMBakSV+WVEA+d2JXPqb9Fa0M6huC53UF4E2qe7nRPGHchgdmPn
 w8/8MfjJL3qRSbh8YVAhUpOTjOo3D9I9T60gTsHulh7TUqxQIAVeAkiKu/LALSYbKX
 F4z6LWRlB81LVnpAMBf29zub7sJxuTkO4BI+IB09nTrIhiQssNhhX+nbFsPbcWcOHO
 89JcfwALnZFsdZgGcqpWBubZw4SVFjNfUJ9gWwI+1CAtECghGVk95/K5z7V+ViVlNe
 UgoWo2YbW3U9A==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v4 00/18] Turris Omnia - New board revision
 support
Date: Thu,  4 Apr 2024 09:50:49 +0200
Message-ID: <20240404075107.19636-1-kabel@kernel.org>
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

changes since v3:
- added missing files turris_common.c and turris_common.h to patch 05/18
- added comment to patch 11/18 before while (1); as discussed in v3

v1, v2 and v3 at:
  https://patchwork.ozlabs.org/project/uboot/cover/20240304152148.3847-1-kabel@kernel.org/
  https://patchwork.ozlabs.org/project/uboot/cover/20240323180711.5498-1-kabel@kernel.org/
  https://patchwork.ozlabs.org/project/uboot/cover/20240327162355.24584-1-kabel@kernel.org/

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
 arch/arm/mach-mvebu/system-controller.c  | 145 ++++++--
 board/CZ.NIC/turris_atsha_otp.c          |  27 +-
 board/CZ.NIC/turris_common.c             |  42 +++
 board/CZ.NIC/turris_common.h             |  10 +
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
 19 files changed, 1097 insertions(+), 482 deletions(-)
 create mode 100644 board/CZ.NIC/turris_common.c
 create mode 100644 board/CZ.NIC/turris_common.h
 delete mode 100644 drivers/gpio/turris_omnia_mcu.c
 create mode 100644 drivers/misc/turris_omnia_mcu.c
 create mode 100644 include/turris-omnia-mcu-interface.h

-- 
2.43.2

