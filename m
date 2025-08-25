Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCA6CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 13:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02FCD8304F;
	Mon, 25 Aug 2025 15:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="i+QTh3Gq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ECAE830A0; Mon, 25 Aug 2025 15:55:40 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C50482DA1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2B73FC9940; Mon, 25 Aug 2025 15:55:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1756130137; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=oH/WPx8npg0tln3VPN6EqKwwtx+phjzQPZfzH4M3ZXY=;
 b=i+QTh3GqEnVqITMO/6+HA3Xwb35ppzqLJt37ZnCtG9YUpoJdT4yqxbKTEXzBIYwJe37WAD
 iBpLJfLcpsoXGXjVovpEHcwm4w/p902wO4j4vPSA6gVufTzHdmvHujRM5X3taQOFgVF4Pj
 ajRQbPVc4VRsWdIX3Vts0AUevxLEIiyRhdNnhpOHRla/2iv0fu7yZaZNtRWP0DZyzmmuaV
 OPGhmxNtjjG72fOeqDHy4uS24c9nznSfuNDCQWvPS4NAPlT+YjpiuhpMSKwLKCMWnZrP8f
 pKxLx2k7NOdf4yhyzzkMUdwIn70NdddE6hRp5vx02H5yBwyPi2RyNBInldtkGA==
From: Frieder Schrempf <frieder@fris.de>
To: Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Annette Kobou <annette.kobou@kontron.de>,
 Eberhard Stoll <eberhard.stoll@kontron.de>, E Shattow <e@freeshell.de>,
 Fabio Estevam <festevam@denx.de>, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Oualid Derouiche <oualid.derouiche@kontron.de>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 00/11] Misc changes for Kontron i.MX6UL SoMs and Boards
Date: Mon, 25 Aug 2025 15:54:24 +0200
Message-ID: <20250825135504.193004-1-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
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

This is a collection of various patches that we have collected
downstream and the conversion to OF_UPSTREAM.

Annette Kobou (2):
  imx: kontron-sl-mx6ul: Enable fastboot support
  imx: kontron-sl-mx6ul: Autostart fastboot if booted from USB

Eberhard Stoll (2):
  imx: kontron-sl-mx6ul: Enable CONFIG_ENV_IS_NOWHERE
  imx: kontron-sl-mx6ul: Force default environment for serial loader
    boot

Frieder Schrempf (6):
  imx: kontron-sl-mx6ul: Fix include statements for local header
  imx: kontron-sl-mx6ul: Enable standard boot and disable legacy distro
    boot
  imx: kontron-sl-mx6ul: Set CONFIG_SDP_LOADADDR to fix SDP boot
  imx: kontron-sl-mx6ul: Enable second ethernet interface
  imx: kontron-sl-mx6ul: Enable watchdog and sysreset
  imx: kontron-sl-mx6ul: Switch to OF_UPSTREAM

Oualid Derouiche (1):
  imx: kontron-sl-mx6ul: Enable redundant environment

 arch/arm/dts/imx6ul-kontron-bl-43.dts         | 103 -----
 .../dts/imx6ul-kontron-bl-common-u-boot.dtsi  |  12 +-
 arch/arm/dts/imx6ul-kontron-bl-common.dtsi    | 406 ------------------
 arch/arm/dts/imx6ul-kontron-bl.dts            |  16 -
 arch/arm/dts/imx6ul-kontron-sl-common.dtsi    | 137 ------
 arch/arm/dts/imx6ul-kontron-sl.dtsi           |  14 -
 arch/arm/dts/imx6ull-kontron-bl.dts           |  15 -
 arch/arm/dts/imx6ull-kontron-sl.dtsi          |  13 -
 board/kontron/sl-mx6ul/sl-mx6ul-common.c      |   2 +-
 board/kontron/sl-mx6ul/sl-mx6ul.c             |  23 +-
 board/kontron/sl-mx6ul/spl.c                  |   3 +-
 configs/kontron-sl-mx6ul_defconfig            |  32 +-
 include/configs/kontron-sl-mx6ul.h            |  12 -
 13 files changed, 56 insertions(+), 732 deletions(-)
 delete mode 100644 arch/arm/dts/imx6ul-kontron-bl-43.dts
 delete mode 100644 arch/arm/dts/imx6ul-kontron-bl-common.dtsi
 delete mode 100644 arch/arm/dts/imx6ul-kontron-bl.dts
 delete mode 100644 arch/arm/dts/imx6ul-kontron-sl-common.dtsi
 delete mode 100644 arch/arm/dts/imx6ul-kontron-sl.dtsi
 delete mode 100644 arch/arm/dts/imx6ull-kontron-bl.dts
 delete mode 100644 arch/arm/dts/imx6ull-kontron-sl.dtsi

-- 
2.50.1

