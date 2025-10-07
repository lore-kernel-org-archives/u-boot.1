Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BE6CCA476
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 08:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C5F483869;
	Tue,  7 Oct 2025 10:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="jPOw+zXq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDF5383870; Tue,  7 Oct 2025 10:18:13 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5D0283655
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 10:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 94D9BC99F3; Tue,  7 Oct 2025 10:18:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1759825090; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=PFe3KUIJysAAGAVt0bogZzTLxm+kTcrq+vwo/m5/bVc=;
 b=jPOw+zXqkFsUimQLIp9UXFJdyn+84hPiYfW6vO59k6kLmpDxmwNuFDiX6bNJS1+J7FNVOF
 AB1OjMagU7v6o9O4MfrSFPVXvhw4OVhYbHmJl5xAQBJOFCDWpV3wOTTcfW3Bd7A4VTpiM8
 Kti2KR2FWikdFVKXHtcJ+XFTENBfvCNXJbs7Dfz97kvPgL7gadSrMdsDDk7zrL/f2IJepL
 fKMfWCQIWtTTbgrkJ5ocSTN1fcMSR0XMJyV563BSzSakU5n/cPvtXPQHUP7YAWsHkBWQyv
 Na+6t9emcsjsgtvOQmieEWDr//NDfwmkbVRI8AYJ5X14rY4CvUwFPXoKIsPmkQ==
From: Frieder Schrempf <frieder@fris.de>
To: Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 Eberhard Stoll <eberhard.stoll@kontron.de>,
 Garrett Giordano <ggiordano@phytec.com>, Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 00/13] Misc changes for Kontron i.MX8MM SoMs and Boards
Date: Tue,  7 Oct 2025 10:15:57 +0200
Message-ID: <20251007081640.61772-1-frieder@fris.de>
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

This is a collection of various patches that we have collected
downstream and the conversion to OF_UPSTREAM.

Eberhard Stoll (1):
  imx: kontron-sl-mx8mm: Force default environment for serial loader
    boot

Frieder Schrempf (12):
  imx: kontron-sl-mx8mm: Increase CONFIG_SPL_MAX_SIZE
  imx: kontron-sl-mx8mm: Enable SDP support for loading via USB
  imx: kontron-sl-mx8mm: Remove deprecation warning for old modules
  imx: kontron-sl-mx8mm: Enable fixed regulators
  imx: kontron-sl-mx8mm: Add support for EEPROM on OSM-S module
  imx: kontron-sl-mx8mm: Use eMMC boot part for environment if booting
    from eMMC
  imx: kontron-sl-mx8mm: Export current env config to devicetree
  imx: kontron-sl-mx8mm: Enable multiple useful commands, drivers and
    features
  imx: kontron-sl-mx8mm: Enable standard boot and disable legacy distro
    boot
  imx: kontron-sl-mx8mm: Enable USB hub on BL i.MX8MM OSM-S board
  imx: kontron-sl-mx8mm: Autostart fastboot if booted from USB
  imx: kontron-sl-mx8mm: Convert to OF_UPSTREAM

 arch/arm/dts/Makefile                         |   2 -
 .../dts/imx8mm-kontron-bl-common-u-boot.dtsi  |  16 +
 arch/arm/dts/imx8mm-kontron-bl-osm-s.dts      | 376 ------------------
 arch/arm/dts/imx8mm-kontron-bl.dts            | 355 -----------------
 arch/arm/dts/imx8mm-kontron-osm-s.dtsi        | 335 ----------------
 arch/arm/dts/imx8mm-kontron-sl.dtsi           | 314 ---------------
 board/kontron/sl-mx8mm/sl-mx8mm.c             | 102 ++++-
 board/kontron/sl-mx8mm/spl.c                  |  11 -
 configs/kontron-sl-mx8mm_defconfig            |  75 +++-
 include/configs/kontron-sl-mx8mm.h            |  12 -
 10 files changed, 183 insertions(+), 1415 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mm-kontron-bl-osm-s.dts
 delete mode 100644 arch/arm/dts/imx8mm-kontron-bl.dts
 delete mode 100644 arch/arm/dts/imx8mm-kontron-osm-s.dtsi
 delete mode 100644 arch/arm/dts/imx8mm-kontron-sl.dtsi

-- 
2.51.0

