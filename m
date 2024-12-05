Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8364EE7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:54:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0D8289507;
	Thu,  5 Dec 2024 14:54:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="VjKyzcIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5874E894FD; Thu,  5 Dec 2024 14:54:47 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A5E689495
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 14:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 030704000A;
 Thu,  5 Dec 2024 13:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1733406883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Vyp/bmCs264ounos1IbPAtdGK29NFcfYpxi+66RezWQ=;
 b=VjKyzcIKTYyxYr6xcqeDEYwKWU6U7Im5VjgFr1b8nGf3Oz5sZoO1W8f9ZRxhys+s0ZQG32
 Clg9o5Iu7PIbinJT02SPHJunGMPk4whuMOZKavPFjL51oO4b+dcDZz0eI4D0ZvK/+8v6rD
 tkthPLgJA6+XQjEyh9SGqWQkEaE/E1qvZ8PHYrEtQsbGGsNdUI5hc46Xgxrc4T9SJSaIVE
 44ySktjrS7ge55wGto51NFqlMxT+Fl3YgcJ45IQp4fDDq4+orWR6n3KX6vndL//nbPi5Ce
 XmOT6tPgE1+IIQSPJ6VkCRKXrdfcsa7ZKFeRBuNCj9e2+9zsOuHPyTJTAiKrSg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 00/13] Add imx8mp video support
Date: Thu, 05 Dec 2024 14:54:06 +0100
Message-Id: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH6wUWcC/x3MwQqDMAyA4VeRnBfIgu6wV5EdujbVgNbSbKKI7
 27x+P2H/wCTomLwbg4osqrpkir40YAfXRoENVQDE7dPpg5rmZ2mSZNgUMuT29H+OS/lh0Q+vih
 +A3sP9ZCLRN3ue/85zwuPU/TIbQAAAA==
X-Change-ID: 20241205-ge-mainline-display-support-00cf60fbd2cc
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>, 
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com
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

In order to display a boot picture or an error message, the i.MX8MP
display pipeline must be enabled. The SoC has support for various
interfaces (LVDS, HDMI, DSI). The one supported in this series is the
standard 4-lane LVDS output. The minimal setup is thus composed of:
* An LCD InterFace (LCDIF) with an AXI/APB interface, generating a pixel
  stream
* One LVDS Display Bridge (LDB), also named pixel mapper, which receives
  the pixel stream and route it to one or two (possibly combined) LVDS
  displays.
* All necessary clocks and power controls coming from the MEDIAMIX
  control block.

Patch 1 adds a very useful helper to the core in order to grab devices
through endpoints instead of being limited to phandles. Video pipelines
being often described using graphs endpoints, the introduced helper is
used several times in the serires (there are 3 LCDIF, one of them being
connected to the LDB, itself having 2 ports).

Patch 2 is a fix which is necessary for this series to work properly,
but is way broader than just this use case. In practice, when assigned
clocks are defined in the device tree, the clock uclass tries to assign
the parents first and then sets them to the correct frequency. This only
works if the parents have been enabled themselves. Otherwise we end-up
with a non-clocked parent. I believe this is not the intended behavior
in general, but more importantly on the i.MX8MP, there are "clock
slices" which have pre-requisites in order to be modified and selecting
an ungated parent is one of them.

All the other patches progressively build support for the whole video
pipeline. Regarding the LCDIF driver, there is already a similar driver
for older i.MX SoCs but I didn't manage to get it to work. It was
written more than a decade ago while device-model, clocks and others
were not yet generically supported. Thus, numerous ad-hoc solutions
were implemented, which no longer fit today's requirements. I preferred
to add a new "clean" driver instead of modifying the existing one
because of the too high risk of breaking these platforms. Once proper
clocks/power-domain descriptions will be added to them they might be
converted (and tested) to work with the "new" implementation, but going
the opposite way felt drawback.

---
Changes in v2:
- Add ISP clocks to avoid harmless errors when shutting down the
  pipeline.
- Add power domain refcounting to avoid shutting down a power domain
  already disabled. This is useful when a device points several times to
  the same power domain in the DT.
- Ensure the mediamix driver frees all the power domains it got a
  reference on.
- Add an in-tree user as requested by Fabio: the EVK.
- Use the same Kconfig prompts as in Linux.
- Add sandbox tests for uclass_get_device_by_endpoint().
- Enclosed media clocks definitions within #if CONFIG_IS_ENABLED()
  guards to avoid bloating the SPL and configurations without video
  support, as Adam and Fabio advised.
- Disable the enabled clocks in the remove path of the mediamix block
  driver.
- Fix many typos.
- Fix checkpatch warnings.
- Rebase on next.
- Collect tags
- Link to v1: https://lore.kernel.org/r/20240910101344.110633-1-miquel.raynal@bootlin.com

To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de
Cc: Ian Ray <ian.ray@gehealthcare.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Adam Ford <aford173@gmail.com>

---
Miquel Raynal (13):
      dm: doc: Fix example
      dm: core: Add a helper to retrieve devices through graph endpoints
      sandbox: Add a fake display controller and link it to the panel
      test: dm: test-fdt: Add checks for uclass_get_device_by_endpoint()
      power-domain: Add refcounting
      clk: Ensure the parent clocks are enabled while reparenting
      clk: imx8mp: Add media related clocks
      imx: power-domain: Describe the i.MX8 MEDIAMIX domain
      imx: power-domain: Add support for the MEDIAMIX control block
      video: imx: Fix Makefile in order to be able to add other imx drivers
      video: imx: Add LDB driver
      video: imx: Add LCDIF driver
      imx8mp_evk: Enable display support

 arch/sandbox/dts/test.dts                  |  26 +++
 configs/imx8mp_evk_defconfig               |   7 +
 doc/develop/driver-model/design.rst        |   2 +-
 drivers/clk/clk-uclass.c                   |  21 +-
 drivers/clk/imx/clk-imx8mp.c               |  69 +++++++
 drivers/core/uclass.c                      |  62 ++++++
 drivers/power/domain/Kconfig               |   7 +
 drivers/power/domain/Makefile              |   1 +
 drivers/power/domain/imx8m-power-domain.c  |  17 ++
 drivers/power/domain/imx8mp-mediamix.c     | 208 +++++++++++++++++++
 drivers/power/domain/power-domain-uclass.c |  37 +++-
 drivers/video/Makefile                     |   2 +-
 drivers/video/imx/Kconfig                  |   9 +
 drivers/video/imx/Makefile                 |   4 +-
 drivers/video/imx/lcdif.c                  | 314 +++++++++++++++++++++++++++++
 drivers/video/imx/ldb.c                    | 251 +++++++++++++++++++++++
 include/dm/uclass.h                        |  21 ++
 include/power-domain.h                     |   4 +-
 test/dm/test-fdt.c                         |  20 +-
 19 files changed, 1070 insertions(+), 12 deletions(-)
---
base-commit: c498b6cace9e0de45ea12146312f5a6f43a03a9b
change-id: 20241205-ge-mainline-display-support-00cf60fbd2cc

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

