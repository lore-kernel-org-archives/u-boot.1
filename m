Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C09CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 16:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 425118380F;
	Fri,  3 Oct 2025 18:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vdNqmhJH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A1E883826; Fri,  3 Oct 2025 18:34:18 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5841883759
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 18:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A25994E40E9D;
 Fri,  3 Oct 2025 16:34:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 58A7660683;
 Fri,  3 Oct 2025 16:34:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4DD3C102F17C4; 
 Fri,  3 Oct 2025 18:33:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759509253; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=mQ12388BwQ5q7M2IBvlXpkRXI3371lKtYqdUXBhAGh0=;
 b=vdNqmhJHEvpbZT+lBC04FO3xkdJfy9aLX1h5Ru5y19tALC7yyz2rpMUIN8/gnv81yvHrVc
 0XkD0Ca757HwI1AaNFJ9xRyO4t89MGJXQowpqHYOgDqvrqMxvziFxnjsAm9YL/v4XJ1zhU
 sRmVxXZZq9ySEbiXH76l+U064yJc0v+WntimMkm/1HTx0sucECpu9IhMZe2zkGLYo4zpgJ
 N5q7aO6sDsJPKn4GiAP2u/Wu2ZHkU/C5h5D6hSj9hIx36Vqu3GkJYsxuRLtv9l/c4hAlYg
 Zs7fa1fayZeVtyCANMfFmhJY7Fa6RoEF2/Z2I1xzs1jILjuDNCt0ynFi2fZQ2A==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH 00/16] Convert extension support to UCLASS and adds its
 support to boot flows
Date: Fri, 03 Oct 2025 18:33:40 +0200
Message-Id: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOT632gC/x2NwQrCMBAFf6Xs2UAaSLX+ikhIzavuJZHdKC2l/
 97ocQ4zs5FCGErXbiPBl5VLbtCfOnq8Yn7CcGpMzjpvx34wM2L9CIKuOpVSA5aK/LPCVKIkM/p
 LStaenR88tcpbMPPyP9zu+34AhZ257nEAAAA=
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Kory Maincent <kory.maincent@bootlin.com>
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

The UCLASS implementation provides one driver that manages all
extension boards (alternative would be one U-Boot device per
extension board). Simon is that what you would expect?

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (16):
      MAINTAINERS: Add maintainer for extension board support
      boot: Move extension board support from cmd/ to boot/
      boot: Add UCLASS support for extension boards
      board: ti: Exclude cape detection from XPL builds
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
 .../imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c        |  60 ++++---
 board/sandbox/sandbox.c                            |  22 ++-
 board/sunxi/chip.c                                 |  33 ++--
 board/ti/common/Makefile                           |   2 +
 board/ti/common/cape_detect.c                      |  52 +++---
 boot/Kconfig                                       |   3 +
 boot/Makefile                                      |   1 +
 boot/bootmeth_efi.c                                |  78 +++++++--
 boot/extension-uclass.c                            | 138 ++++++++++++++++
 boot/pxe_utils.c                                   |  90 ++++++++++
 cmd/Kconfig                                        |   5 +-
 cmd/extension_board.c                              | 183 ++++++++++-----------
 doc/usage/cmd/extension.rst                        |  24 +--
 include/dm/uclass-id.h                             |   1 +
 include/extension_board.h                          |  71 ++++++--
 16 files changed, 544 insertions(+), 228 deletions(-)
---
base-commit: 9710d98e8942151fc0c62d54100d9d27e8263d04
change-id: 20250916-feature_sysboot_extension_board-958dd0072565

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

