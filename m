Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C63BCCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AD3584308;
	Thu,  9 Oct 2025 16:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="K/hIswks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E06284408; Thu,  9 Oct 2025 16:50:59 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C43D83F0A
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 0A1D21A1243;
 Thu,  9 Oct 2025 14:50:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CDE5D6062C;
 Thu,  9 Oct 2025 14:50:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 19897102F21E6; 
 Thu,  9 Oct 2025 16:50:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760021454; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=dLzD+IETChr8sDYvTwV+xEENH2Ircd24SrFHbhUBJ5g=;
 b=K/hIswksznb8CHZO+gHaGBy/Loc/rK8c9OdBXb3CwY+mJO8p4wiyttenc8/6NfvURl2Ovg
 eRQODPXelwaIrFgh6XTOhM33wKzdnhaF5o44vL+zE3FQ7xBcU5rLOpMukSNjmp5NS9UU1G
 Em1lKSsuGn0sT1F8NZ6YAcUB0PSEE7WfjRdAE7Q1619X25hjxrw9wRkFZkLcllDQLiAS0p
 ZQNQqC3liMWztpe7HMJgUTXYQpvkVETTj5tb+A4omuXeOaHDjgp0NkoqZTVgaDg4/qTbjU
 b4DCRIVtCZmcSMdSJxU4pEtQQl2SJf2xOvHbYTgQLJm5rqF1ohyekLyGukCnYw==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Subject: [PATCH v2 00/18] Convert extension support to UCLASS and adds its
 support to boot flows
Date: Thu, 09 Oct 2025 16:50:36 +0200
Message-Id: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALzL52gC/4WNQQ6CMBREr0L+2prfYrG48h6GEEo/0kRb01YCI
 dzdwgVcvsnMmxUiBUsRbsUKgSYbrXcZxKmAfuzck5g1mUGgkFjzig3UpW+gNi5Re59amhO5fdV
 q3wXDaqmMQbwKWUnIlk+gwc7Hw6PJPNqYfFiOw4nv6eHmiOVf98QZsotUWulByVLI+157WXfu/
 Ruabdt+f3Cnb9AAAAA=
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
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

Changes in v2:
- Fixes few build errors.
- Add patches to move the extension support and board scan out of XPL
  images build.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
Kory Maincent (TI.com) (18):
      MAINTAINERS: Add maintainer for extension board support
      boot: Move extension board support from cmd/ to boot/
      boot: Add UCLASS support for extension boards
      board: ti: Exclude cape detection from XPL builds
      board: ti: Refactor cape detection code for readability
      board: ti: Convert cape detection to use UCLASS framework
      board: sunxi: Exclude DIP detection from XPL builds
      board: sunxi: Refactor CHIP board extension code
      board: sunxi: Convert extension support to UCLASS framework
      board: sandbox: Improve extension board scan implementation
      board: sandbox: Convert extension support to UCLASS framework
      board: compulab: Exclude compulab extension board detection from XPL builds
      board: compulab: Convert imx8mm-cl-iot-gate to UCLASS extension framework
      boot: Remove legacy extension board support
      boot: extension: Move overlay apply custom logic to command level
      boot: pxe_utils: Add extension board devicetree overlay support
      boot: bootmeth_efi: Refactor distro_efi_try_bootflow_files return logic
      boot: bootmeth_efi: Add extension board devicetree overlay support

 MAINTAINERS                                        |   9 +
 .../imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c        |  67 ++++----
 board/sandbox/sandbox.c                            |  22 ++-
 board/sunxi/Makefile                               |   2 +-
 board/sunxi/chip.c                                 |  32 ++--
 board/ti/common/Makefile                           |   2 +-
 board/ti/common/cape_detect.c                      |  52 +++---
 boot/Kconfig                                       |   3 +
 boot/Makefile                                      |   1 +
 boot/bootmeth_efi.c                                |  78 +++++++--
 boot/extension-uclass.c                            | 138 ++++++++++++++++
 boot/pxe_utils.c                                   |  90 ++++++++++
 cmd/Kconfig                                        |   3 -
 cmd/extension_board.c                              | 183 ++++++++++-----------
 doc/usage/cmd/extension.rst                        |  24 +--
 include/dm/uclass-id.h                             |   1 +
 include/extension_board.h                          |  71 ++++++--
 17 files changed, 547 insertions(+), 231 deletions(-)
---
base-commit: 8e7f8c1248e8adfb525a2a4ea56ebf7e54ff5d7a
change-id: 20250916-feature_sysboot_extension_board-958dd0072565

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

