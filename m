Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FA5CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 10:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 803DC83EC9;
	Tue, 11 Nov 2025 11:31:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="j7ehxbIu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F9E983F5B; Tue, 11 Nov 2025 11:31:44 +0100 (CET)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6656E83968
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 11:31:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 52205C9EEB; Tue, 11 Nov 2025 11:31:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1762857100; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=nMsupRzruwFyO5WWR3Vq5w6stYjl55OAndQMOEYmYRc=;
 b=j7ehxbIuHeQnZthGHAetIXThCSGuBHc8EPPlPOcvEIaaZGW+n+F4Nhtnsq/AVAPaTFNLnH
 dZd4EI6Ff00UDEg7d5bMZkj5S9X4V7oCQf3+uuOeM/XQti8J+7sGe7YfdWbM2yc4/MYhsF
 96+4u1QMwGPsbWlE4hq4a1GRlxx7CFS23PudBGUvtpY1YfXHPC5pBQW7BYxjeALAK6Wg7M
 LpsXrd+BfmODbkb8y0MTA8E2lPyEwcMnYMVnfM9NFTOTHsqfFoVUZA+/rfd/h0pbEemDlz
 7RZkIVrfqePCKWIGuUU9Aup3EuPWu6IqmdjAGFi7xHmmlYS+57JT5BjByfFZrQ==
From: Frieder Schrempf <frieder@fris.de>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Benjamin Hahn <B.Hahn@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Eberhard Stoll <eberhard.stoll@kontron.de>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>, Simon Glass <sjg@chromium.org>,
 Vitor Soares <vitor.soares@toradex.com>, Wadim Egorov <w.egorov@phytec.de>,
 Yannic Moog <y.moog@phytec.de>, Ye Li <ye.li@nxp.com>
Subject: [PATCH 0/4] Add support for Kontron i.MX8MP and i.MX93 OSM hardware
Date: Tue, 11 Nov 2025 11:28:09 +0100
Message-ID: <20251111102904.157931-1-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This adds support for Kontron hardware based on i.MX8MP and i.MX93
OSM (Open Standard Module) SoMs.

Frieder Schrempf (4):
  imx: Add support for Kontron i.MX8MP OSM-S SoM and BL carrier board
  arm64: dts: imx8mp-kontron: Fix USB OTG role switching
  arm: imx: imx9: Use arch override for env_get_location()
  imx: Add support for Kontron i.MX93 OSM-S SoM and BL carrier board

 .../dts/imx8mp-kontron-bl-osm-s-u-boot.dtsi   |  115 +
 .../dts/imx93-kontron-bl-osm-s-u-boot.dtsi    |  153 +
 arch/arm/mach-imx/imx8m/Kconfig               |   14 +
 arch/arm/mach-imx/imx9/Kconfig                |   11 +-
 arch/arm/mach-imx/imx9/soc.c                  |    2 +-
 board/kontron/osm-s-mx8mp/Kconfig             |   17 +
 board/kontron/osm-s-mx8mp/MAINTAINERS         |    7 +
 board/kontron/osm-s-mx8mp/Makefile            |    9 +
 board/kontron/osm-s-mx8mp/imximage.cfg        |    8 +
 board/kontron/osm-s-mx8mp/lpddr4_timing.c     | 2474 +++++++++++++++++
 board/kontron/osm-s-mx8mp/osm-s-mx8mp.c       |  175 ++
 board/kontron/osm-s-mx8mp/osm-s-mx8mp.env     |    6 +
 board/kontron/osm-s-mx8mp/spl.c               |  358 +++
 board/kontron/osm-s-mx93/Kconfig              |   17 +
 board/kontron/osm-s-mx93/MAINTAINERS          |    7 +
 board/kontron/osm-s-mx93/Makefile             |    9 +
 board/kontron/osm-s-mx93/lpddr4x_timing.c     | 1992 +++++++++++++
 board/kontron/osm-s-mx93/osm-s-mx93.c         |  168 ++
 board/kontron/osm-s-mx93/osm-s-mx93.env       |    6 +
 board/kontron/osm-s-mx93/spl.c                |  169 ++
 configs/kontron-osm-s-mx8mp.config            |  203 ++
 configs/kontron-osm-s-mx8mp_defconfig         |    3 +
 configs/kontron-osm-s-mx93.config             |  197 ++
 configs/kontron-osm-s-mx93_defconfig          |    3 +
 doc/board/kontron/index.rst                   |    2 +
 doc/board/kontron/osm-s-mx8mp.rst             |  104 +
 doc/board/kontron/osm-s-mx93.rst              |   95 +
 .../freescale/imx8mp-kontron-bl-osm-s.dts     |   24 +-
 include/configs/kontron-osm-s-mx8mp.h         |   30 +
 include/configs/kontron-osm-s-mx93.h          |   30 +
 30 files changed, 6401 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/dts/imx8mp-kontron-bl-osm-s-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx93-kontron-bl-osm-s-u-boot.dtsi
 create mode 100644 board/kontron/osm-s-mx8mp/Kconfig
 create mode 100644 board/kontron/osm-s-mx8mp/MAINTAINERS
 create mode 100644 board/kontron/osm-s-mx8mp/Makefile
 create mode 100644 board/kontron/osm-s-mx8mp/imximage.cfg
 create mode 100644 board/kontron/osm-s-mx8mp/lpddr4_timing.c
 create mode 100644 board/kontron/osm-s-mx8mp/osm-s-mx8mp.c
 create mode 100644 board/kontron/osm-s-mx8mp/osm-s-mx8mp.env
 create mode 100644 board/kontron/osm-s-mx8mp/spl.c
 create mode 100644 board/kontron/osm-s-mx93/Kconfig
 create mode 100644 board/kontron/osm-s-mx93/MAINTAINERS
 create mode 100644 board/kontron/osm-s-mx93/Makefile
 create mode 100644 board/kontron/osm-s-mx93/lpddr4x_timing.c
 create mode 100644 board/kontron/osm-s-mx93/osm-s-mx93.c
 create mode 100644 board/kontron/osm-s-mx93/osm-s-mx93.env
 create mode 100644 board/kontron/osm-s-mx93/spl.c
 create mode 100644 configs/kontron-osm-s-mx8mp.config
 create mode 100644 configs/kontron-osm-s-mx8mp_defconfig
 create mode 100644 configs/kontron-osm-s-mx93.config
 create mode 100644 configs/kontron-osm-s-mx93_defconfig
 create mode 100644 doc/board/kontron/osm-s-mx8mp.rst
 create mode 100644 doc/board/kontron/osm-s-mx93.rst
 create mode 100644 include/configs/kontron-osm-s-mx8mp.h
 create mode 100644 include/configs/kontron-osm-s-mx93.h

-- 
2.51.0

