Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD27E7D0A0
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 17:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E69428645F;
	Thu, 21 Sep 2023 19:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="hlt+0v8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD4D786B29; Thu, 21 Sep 2023 19:06:48 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D4E863CF
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 19:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Durai.ManickamKR@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1695316006; x=1726852006;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6p+tt14UFGRhfkOH+tjMOGxJERwyfenp+zvq7iVXC/4=;
 b=hlt+0v8BnaaHMN8o4Zl3pubsTKSnjuSSJXTaopJw5NfkRrPJEkFZBDFr
 oDtrIwTL5T6uj9zWAGdocr/Cn/FZEASpYOHAyCtDx3JSUk/wCyof9+3Nr
 WmGZjKTVeIDZvcelYSPV7lpVyEqw22xjAyPE7K1uYSIOieGhM6jLgE+zG
 DA2zeO9DdobOnUK4Bv6Heds3R8gPACXcoA0H5eqpy3rjSC5YuwyqrNq70
 fACqY5zTuv8S7yNzRK4wYv+6bZlGVJ8ceGP4kklsjnXXzL2RNQl9DulGX
 cpLVK20dcJCTKKS+tg2ismvAs9g/NA11L7JUDhkOnbwxGuqK+rs7oRYz8 Q==;
X-CSE-ConnectionGUID: +MSlomsGQRGNiRXDNe2IEg==
X-CSE-MsgGUID: tR4wZjYwSaiMHaqB61mqhQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="5770712"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 21 Sep 2023 10:06:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 21 Sep 2023 10:06:43 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 21 Sep 2023 10:06:40 -0700
From: Durai Manickam KR <durai.manickamkr@microchip.com>
To: <u-boot@lists.denx.de>
CC: <durai.manickamkr@microchip.com>, <hari.prasathge@microchip.com>,
 <varshini.rajendran@microchip.com>, <cristian.birsan@microchip.com>,
 <nicolas.ferre@microchip.com>, <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH 0/4] Add support for sam9x60 curiosity
Date: Thu, 21 Sep 2023 22:36:27 +0530
Message-ID: <20230921170631.45752-1-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 21 Sep 2023 19:18:38 +0200
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

This patch series adds boot from NAND support, configs update and 
fixes. The changes has been done on top of u-boot version 2023.07.

Durai Manickam KR (4):
  configs: at91: sam9x60_curiosity: update
    sam9x60_curiosity_mmc_defconfig
  configs: at91: sam9x60_curiosity: Add
    sam9x60_curiosity_nandflash_defconfig
  ARM: dts: at91: sam9x60_curiosity: Enable NAND support
  ARM: dts: at91: sam9x60_curiosity: fix eeprom compatible

 arch/arm/dts/at91-sam9x60_curiosity.dts       | 106 +++++++++++++++++-
 board/atmel/sam9x60_curiosity/MAINTAINERS     |   1 +
 configs/sam9x60_curiosity_mmc_defconfig       |  14 +++
 configs/sam9x60_curiosity_nandflash_defconfig |  92 +++++++++++++++
 4 files changed, 212 insertions(+), 1 deletion(-)
 create mode 100644 configs/sam9x60_curiosity_nandflash_defconfig

-- 
2.25.1

