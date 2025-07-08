Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36783C83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 13:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DCB48338D;
	Tue,  8 Jul 2025 15:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="JaNyTgtM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3950C8332E; Tue,  8 Jul 2025 15:02:14 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5DFB830B4
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 15:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=277d701d6=Eoin.Dickson@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1751979731; x=1783515731;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sCWGoAqYnjycsaGzwTG9970WWFBL0OHBR2f1R3S6eLU=;
 b=JaNyTgtMBASzp7EwiR2G7bMOKMO/X8rBdN5oTsaA8621+rdeUTfgYtb4
 wCRsM8zZIp6godmzh/RxjOZ1dMa2quUlLlTDIivbQlnvV8RQnafROegAf
 WL8JbAbWV5x+g1RUK3XokHXCJXSGkS+kAxDe8TYZIwQaT6ERy/yzqPM6O
 D+M6Wnjzq1z/cDV96A+50wfByHRQGno98NTfcZcyooo+xOPZIqX/VrZXK
 k/FLwpappbhfWzkCBlfgoTsy4+9aLgdadjfym65Lx8RLNN6JzOy5YyL9d
 fj2UXvCgwkWFNwWThJMs3XcpL6V3jmFT5Rw5DPN3YKeO5G0QfklJsjlhH g==;
X-CSE-ConnectionGUID: EcxI15FNSVmwNDPeRbYfAA==
X-CSE-MsgGUID: FmTCdw3CQDeNPlmw2rgqYA==
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="211173065"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 08 Jul 2025 06:02:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Jul 2025 06:02:09 -0700
Received: from ird-lt-m75649b.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 8 Jul 2025 06:02:07 -0700
From: Eoin Dickson <Eoin.Dickson@microchip.com>
To: <u-boot@lists.denx.de>
CC: <rick@andestech.com>, <ycliang@andestech.com>,
 <Conor.Dooley@microchip.com>, <Jamie.Gibbons@microchip.com>,
 <Praveen.Kumar@microchip.com>, <Eoin.Dickson@microchip.com>,
 <Cyril.Jean@microchip.com>, <jagan@amarulasolutions.com>
Subject: [PATCH v3 0/2] Add SD card support to the Beagle-V-Fire
Date: Tue, 8 Jul 2025 18:31:19 +0530
Message-ID: <20250708130121.1769247-1-Eoin.Dickson@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 08 Jul 2025 15:23:43 +0200
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

From: Eoin Dickson <eoin.dickson@microchip.com>

This series add SD card support for the Beagle-V-Fire. The Beagle-V-Fire uses the
Microchip coreqspi xfer function and a gpio chip select, so this series adds gpio
support for PolarFire SoC and the xfer function into the Microchip coreqspi driver.


Eoin Dickson (2):
  gpio: add PolarFire SoC GPIO and Core GPIO driver
  spi: coreqspi: add xfer function for PolarFire SoC

 drivers/gpio/Kconfig             |   5 +
 drivers/gpio/Makefile            |   1 +
 drivers/gpio/mpfs_gpio.c         | 198 +++++++++++++++++++++++++++++++
 drivers/spi/microchip_coreqspi.c | 113 +++++++++++++++++-
 4 files changed, 315 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpio/mpfs_gpio.c

-- 
2.34.1

