Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B1AECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 10:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1898C88FF6;
	Tue, 10 Sep 2024 12:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="irY91fxe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F0C988FFA; Tue, 10 Sep 2024 12:13:48 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4B4A88F65
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 12:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A56B124000B;
 Tue, 10 Sep 2024 10:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1725963225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qOpM9yo+AbqAbK9h496S16HsQTVEPZ0q05u7zcIHouk=;
 b=irY91fxeMADTxB5jJloieK/JuLQiwT5Ufm1/S4eHjKzu5cFR4g+n6ZPgL640O206sdxoa+
 zE8B7f1/MgYpYtRw9uih9nWJPjUzFs4tUlLdh/aJ3wFqz8luayI06QQr1IcDzxupOmmiS9
 8MCTVwPYCOZJaMySjt/zBc+vuHH/XAESQdhoOIAeoEjMoH1LijWyR8S4aqbztbob58biuj
 F+5318hL16cP5n8wMnGes7pTq84Bo3FqdH34yiQ610BZALXm/BAEdCI4omSQYfMNDdJh5j
 1qZmuPq5P9SmebaSd0d/IbD3DRhG1VEmy2nAW5lZE6uSCDjJzswwSUG76/GeFQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>
Cc: <u-boot@lists.denx.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/8] Add imx8mp video support
Date: Tue, 10 Sep 2024 12:13:36 +0200
Message-ID: <20240910101344.110633-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Thanks,
Miquèl

Miquel Raynal (8):
  dm: core: Add a helper to retrieve devices through graph endpoints
  clk: Ensure the parent clocks are enabled while reparenting
  clk: imx8mp: Add media related clocks
  imx: power-domain: Describe the i.MX8 MEDIAMIX domain
  imx: power-domain: Add support for the MEDIAMIX control block
  video: imx: Fix Makefile in order to be able to add other imx drivers
  video: imx: Add LDB driver
  video: imx: Add LCDIF driver

 drivers/clk/clk-uclass.c                  |   4 +
 drivers/clk/imx/clk-imx8mp.c              |  35 +++
 drivers/core/uclass.c                     |  62 +++++
 drivers/power/domain/Kconfig              |   7 +
 drivers/power/domain/Makefile             |   1 +
 drivers/power/domain/imx8m-power-domain.c |  17 ++
 drivers/power/domain/imx8mp-mediamix.c    | 185 +++++++++++++
 drivers/video/Makefile                    |   2 +-
 drivers/video/imx/Kconfig                 |   7 +
 drivers/video/imx/Makefile                |   4 +-
 drivers/video/imx/lcdif.c                 | 315 ++++++++++++++++++++++
 drivers/video/imx/ldb.c                   | 251 +++++++++++++++++
 include/dm/uclass.h                       |  21 ++
 13 files changed, 909 insertions(+), 2 deletions(-)
 create mode 100644 drivers/power/domain/imx8mp-mediamix.c
 create mode 100644 drivers/video/imx/lcdif.c
 create mode 100644 drivers/video/imx/ldb.c

-- 
2.43.0

