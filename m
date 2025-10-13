Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ED9CCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 13:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D315E838BB;
	Mon, 13 Oct 2025 15:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="gAxSlcUE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FC33838C1; Mon, 13 Oct 2025 15:32:44 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99119837E4
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 15:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 00B74C093AE;
 Mon, 13 Oct 2025 13:32:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DBA43606C6;
 Mon, 13 Oct 2025 13:32:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4C1A9102F2263; 
 Mon, 13 Oct 2025 15:32:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760362359; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=XU98oKRTr/RXCr/nwwLMWJjaxJrTh81eHG4HfM88OFY=;
 b=gAxSlcUEEbyeQ7FxpjDRXFL+WRLtvp9hC0PW6Vx0UJimhHUb+aSfkwBkkwrVDFjndva6e7
 ion5/WMVwQykAXb7IRaQ9DMyHCeNphQc5g/1Qhgxeun/TiU1Vk/8LDTJx2xE7reewWz8PU
 xtu0A3NlJp498H0iCm08XKj2wocc8zhJWYS7HkFM3qOZRDNSl1jfUkrlXwMWSmhFPCl8Ei
 kMC+O5eQZ8REluAa9Cc9n8/o89KBk7f26XAL7y9WpUyqRaPDQ79qL6n8//siygH9A3C7Ra
 o7bWksHP/aQvEFyD6I+jakdK73yiL0KyqOz8Oy1n77bixIivKnihZFVcDRswzQ==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Subject: [PATCH v3 00/20] Convert extension support to UCLASS and adds its
 support to boot flows
Date: Mon, 13 Oct 2025 15:32:25 +0200
Message-Id: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGn/7GgC/4XNQQ7CIBAF0KsY1mIolAquvIcxTSlTS6JgAEmbp
 ncXujJuuvyT+e8vKIA3ENDlsCAPyQTjbA7seED92NkHYKNzRpRQTmTV4AG6+PHQhjko52ILUwR
 bWq1ynddYcqE1IWfKG46y8vYwmGlbuN1zHk2Izs/bYKrKdbMrQtiunSpMcM2FEmoQnFF+LW9PY
 0+9e6GiJ/oryn2RZhGIVEwCrzX8ieu6fgGGXRg3IgEAAA==
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
X-Mailer: b4 0.15-dev-8cb71
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
 include/dm/uclass-id.h                             |   1 +
 include/extension_board.h                          |  85 ++++++++--
 18 files changed, 541 insertions(+), 232 deletions(-)
---
base-commit: 8e7f8c1248e8adfb525a2a4ea56ebf7e54ff5d7a
change-id: 20250916-feature_sysboot_extension_board-958dd0072565

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

