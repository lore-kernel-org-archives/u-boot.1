Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B6BCCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 15:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D478483303;
	Wed, 22 Oct 2025 17:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pqaimxgl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9258680422; Wed, 22 Oct 2025 17:20:28 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39AFE80422
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 17:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id DC2ABC0AFF6;
 Wed, 22 Oct 2025 15:20:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A3D5E606DC;
 Wed, 22 Oct 2025 15:20:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2E3AC102F23AD; 
 Wed, 22 Oct 2025 17:20:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761146424; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=rATZARFtagHvVm34B3vMBdZ3DcVAu0fAg2tRepFIovM=;
 b=pqaimxglxXfvwAoBmv2KKAXBME8QBBFDIJ8uWZWQW7roMQQH7pP3Wokwn+MBkGROmBfblF
 S0ygGEqC3gZRhK/BL0JOqiXr7vURuIL2SBCASyPi/RNi823qb7mhsRJAt+jMYiEToE4yHY
 8XvHFIMKxyu7Bxgn3uPsN9XKh5gmKE9UizVlAhaRab9MZ6vVdL8PA8KdcLTGmRq8aclOqo
 FRHdW4MkBG8+r5Bn8MBivXkuUkRXBL6TeIXTpUga8OtZRlPsdUHFSI+S0ikr3t8nFZLbS/
 +mhcSpJ95DqlUZOmHtE/mQUFuBnvvdAiMcgRY6KfYxQOP+lCp6VSjrBxMnHbNQ==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Subject: [PATCH v4 00/20] Convert extension support to UCLASS and adds its
 support to boot flows
Date: Wed, 22 Oct 2025 17:20:11 +0200
Message-Id: <20251022-feature_sysboot_extension_board-v4-0-d24b5ef7b468@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACv2+GgC/43OTQrCMBAF4KtI1kYmf23jynuIlMZMbUATSWqpS
 O9u2pWIUJdvmPnevEjC6DCR/eZFIg4uueBzkNsNOXeNvyB1NmfCgSvQrKAtNv0jYp2eyYTQ1zj
 26Oer2oQmWqpVZS1AyVWhSFbuEVs3Lg3HU86dS32Iz6VwYPN0sRmAWLUHRoFKVZnKtJUSXB3mt
 avzu3O4kVkf+Keo10WeRQRthEYlLf4QxYfI/vhRZBEkFKUpJefNlzhN0xvF3XP0dAEAAA==
X-Change-ID: 20250916-feature_sysboot_extension_board-958dd0072565
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.15-dev-52d38
X-Last-TLS-Session-Version: TLSv1.3
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

This series converts the extension board framework to use UCLASS as
requested by Simon Glass, then adds extension support to pxe_utils
and bootmeth_efi (not tested) to enable extension boards devicetree load
in the standard boot process.

I can't test the imx8 extension scan enabled by the
imx8mm-cl-iot-gate_defconfig as I don't have this board.
I also can't test the efi bootmeth change as I don't have such board.

Changes in v4:
- Update the bootstd tests, due to the removal of extension hunter.

Changes in v3:
- Reorder the patches inside the series as several config were broken
  in the middle of the series.
- Use U_BOOT_DRVINFO macro instead of manually bind the drivers.
- Use uclass_first_device_err instead of extension_get_dev function.
- Made few fixes in documentation and Kconfig dependency.
- Made few changes of error value returned.
- Add a patch to document the extension structure.
- Add a patch to fix CAPE_EEPROM_BUS_NUM Kconfig dependency

Changes in v2:
- Fixes few build errors.
- Add patches to move the extension support and board scan out of XPL
  images build.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
Kory Maincent (TI.com) (20):
      MAINTAINERS: Add maintainer for extension board support
      board: ti: Exclude cape detection from XPL builds
      board: ti: Fix CAPE_EEPROM_BUS_NUM Kconfig dependency
      board: sunxi: Exclude DIP detection from XPL builds
      board: compulab: Exclude compulab extension board detection from XPL builds
      include: extension_board: Document the extension structure
      boot: Move extension board support from cmd/ to boot/
      boot: Add UCLASS support for extension boards
      board: ti: Refactor cape detection code for readability
      board: ti: Convert cape detection to use UCLASS framework
      board: sunxi: Refactor CHIP board extension code
      board: sunxi: Convert extension support to UCLASS framework
      board: sandbox: Improve extension board scan implementation
      board: sandbox: Convert extension support to UCLASS framework
      board: compulab: Convert imx8mm-cl-iot-gate to UCLASS extension framework
      boot: Remove legacy extension board support
      boot: extension: Move overlay apply custom logic to command level
      boot: pxe_utils: Add extension board devicetree overlay support
      boot: bootmeth_efi: Refactor distro_efi_try_bootflow_files return logic
      boot: bootmeth_efi: Add extension board devicetree overlay support

 MAINTAINERS                                        |   9 +
 .../imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c        |  70 ++++----
 board/sandbox/sandbox.c                            |  26 ++-
 board/sunxi/Makefile                               |   2 +-
 board/sunxi/chip.c                                 |  36 ++--
 board/ti/common/Kconfig                            |   2 +-
 board/ti/common/Makefile                           |   2 +-
 board/ti/common/cape_detect.c                      |  56 ++++---
 boot/Kconfig                                       |   4 +
 boot/Makefile                                      |   1 +
 boot/bootmeth_efi.c                                |  79 +++++++--
 boot/extension-uclass.c                            |  93 +++++++++++
 boot/pxe_utils.c                                   |  92 +++++++++++
 cmd/Kconfig                                        |   3 -
 cmd/extension_board.c                              | 183 ++++++++++-----------
 doc/usage/cmd/extension.rst                        |  29 ++--
 doc/usage/pxe.rst                                  |   4 +
 include/dm/uclass-id.h                             |   1 +
 include/extension_board.h                          |  86 ++++++++--
 test/boot/bootdev.c                                |  32 ++--
 test/boot/bootflow.c                               |   6 +-
 test/boot/bootstd_common.h                         |   4 +-
 22 files changed, 563 insertions(+), 257 deletions(-)
---
base-commit: 8e7f8c1248e8adfb525a2a4ea56ebf7e54ff5d7a
change-id: 20250916-feature_sysboot_extension_board-958dd0072565

Best regards,
--  
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

