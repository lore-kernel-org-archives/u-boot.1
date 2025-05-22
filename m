Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A20C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 14:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7027583123;
	Thu, 22 May 2025 16:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="B0DPx5RC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60C7283095; Thu, 22 May 2025 16:11:10 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C59A830E5
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 16:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=230144c57=Eoin.Dickson@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1747923068; x=1779459068;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SQ0BB9U5ZkHEEyDz2ZfEEaj03KK/y2GH7KW+/OiJUF4=;
 b=B0DPx5RCKi8lIcOgoJ+vL6Z8NNRuGW8E9OfcrMESMHujuLLrYbB/PLav
 LONUJTpZ1vo4cyO/a7K6HPmK46DzqhGXSb/SbJUdXvHlsCs6Cri4BXKF5
 xl22wSnfNdlazR6yuPuvm68KPvdSA9U1qv67bI7mKQH6BxBzaYh6ZLM/V
 tZY5cds0eQfB8w5h5NDVdWjPXTAdeItSs5NsGEReJ1bT4M1X7vzFrs5ce
 ZxrR7QcmDCP9gt//kaBOs6Yyxb8TcHbM6MaKwddtX/h7YLZl1mqk5VFCe
 zvVJzjXOderKPL90BJ+hQ8hJaj/ZTx8aFNf5MjsMpgKWJYeAwobHTAkdF Q==;
X-CSE-ConnectionGUID: iM74ktmPTiCh7fCylug4HA==
X-CSE-MsgGUID: fRDfQRnfQA2j6nYaOtQNwA==
X-IronPort-AV: E=Sophos;i="6.15,306,1739862000"; d="scan'208";a="273322453"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 May 2025 07:11:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 22 May 2025 07:10:35 -0700
Received: from ird-lt-m75649b.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 22 May 2025 07:10:33 -0700
From: Eoin Dickson <Eoin.Dickson@microchip.com>
To: <u-boot@lists.denx.de>
CC: <rick@andestech.com>, <ycliang@andestech.com>,
 <conor.dooley@microchip.com>, <jamie.gibbons@microchip.com>,
 <praveen.kumar@microchip.com>, <eoin.dickson@microchip.com>,
 <cyril.jean@microchip.com>, <jagan@amarulasolutions.com>
Subject: [PATCH v1 0/4] Add SD card support to the Beagle-V-Fire
Date: Thu, 22 May 2025 19:39:58 +0530
Message-ID: <20250522141002.1212408-1-Eoin.Dickson@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 22 May 2025 16:50:59 +0200
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

Eoin Dickson (4):
  gpio: add PolarFire SoC GPIO and Core GPIO driver
  spi: coreqspi: add xfer function for PolarFire SoC
  configs: beaglev_fire: Enable GPIO and MMC_SPI
  riscv: dts: microchip: enable gpio banks in Beagle-V Fire

 arch/riscv/dts/mpfs-beaglev-fire.dts |  44 +++++-
 configs/beaglev_fire_defconfig       |   4 +
 drivers/gpio/Kconfig                 |   6 +
 drivers/gpio/Makefile                |   1 +
 drivers/gpio/mpfs_gpio.c             | 199 +++++++++++++++++++++++++++
 drivers/spi/microchip_coreqspi.c     | 113 ++++++++++++++-
 6 files changed, 364 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpio/mpfs_gpio.c

-- 
2.34.1

