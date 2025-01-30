Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB457C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 03:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D97F380EEF;
	Thu, 30 Jan 2025 04:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="Wh1Fyi49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFD0680C99; Thu, 30 Jan 2025 04:52:32 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A65F80AE2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 04:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=118a1aa8f=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1738209150; x=1769745150;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nZ53Ki+OSdHGfwNGNxiD5oVtf+t2QvCOO0/Tzy5Y/VA=;
 b=Wh1Fyi49cGtZ67Gm1KQl7H6Hq10PpJc1/H+rcXI1h9K8zd3ZVfk1V/Lv
 +R/hNxVEbiqszVPBxbxg20OFujDJnao0r4cCwV3RbhcL2jTt5nKnujPev
 imuCLF8YKPVFEXFhWCB+sjFfSe/z971MwA1es/9Qb6lxhz8D97tQa6ApW
 RlSNrr82nIH/3iWw7T6tobE/MfaAOCUYcaqNpUjED5q5Y+N02Bs6s4Vlg
 YXhT+D/qg/8//qsm77UHnqN38P73ZS2w6ZpjOrzW6UNaukSHuJ2EPCukv
 Ivr87Z2qc2B0Gfh13aCRD3vWACKTeXA8lI/6hVtTfMmGMXAJWE0J8/btQ w==;
X-CSE-ConnectionGUID: 6UfhbO/CQrK5c8RpTJRJjg==
X-CSE-MsgGUID: BxqaLHByReS9b6dHFN77GQ==
X-IronPort-AV: E=Sophos;i="6.13,244,1732604400"; d="scan'208";a="204597331"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 29 Jan 2025 20:52:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 29 Jan 2025 20:52:07 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 29 Jan 2025 20:52:05 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v2 0/7] Align pio3 pinctrl node with Linux
Date: Thu, 30 Jan 2025 09:21:50 +0530
Message-ID: <20250130035157.226995-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The series adds support in the pinctrl driver and additional
changes in the at91 DT to align the pio3 based pinctrl nodes
in the u-boot DT with that of Linux

Changes in v2:
- 1/7 - Align the properties of AIC node with that of Linux
- 2/7 - cosmetic fix
      - Align and arrange the pinmux child node as per Mainline Linux
- 4/7 - Modify the pinctrl node compatible property

Balamanikandan Gunasundar (1):
  ARM: dts: at91: sam9x60: Define pinctrl node with its label

Manikandan Muralidharan (6):
  ARM: dts: at91: sam9x60: Add AIC node
  ARM: dts: at91: sam9x60: Move pinmux node to board DTS
  ARM: dts: at91: sam9x60: Add missing pinctrl node properties
  pinctrl: at91: Bind GPIO driver to the pinctrl DT node
  pinctrl: at91: Add support to align with Linux Devicetree
  ARM: dts: at91: Align pinctrl node with Linux Devicetree

 arch/arm/dts/at91-sam9x60_curiosity.dts |  71 ++++++++
 arch/arm/dts/at91sam9260.dtsi           |  76 ++++-----
 arch/arm/dts/at91sam9261.dtsi           |  77 ++++-----
 arch/arm/dts/at91sam9263.dtsi           | 117 ++++++-------
 arch/arm/dts/at91sam9g45.dtsi           | 106 ++++++------
 arch/arm/dts/at91sam9n12.dtsi           |  93 +++++------
 arch/arm/dts/at91sam9rl.dtsi            |  93 +++++------
 arch/arm/dts/at91sam9x5.dtsi            |  90 +++++-----
 arch/arm/dts/sam9x60.dtsi               | 151 +++++++----------
 arch/arm/dts/sam9x60ek.dts              | 213 ++++++++++++++++--------
 arch/arm/dts/sama5d3.dtsi               | 116 ++++++-------
 arch/arm/dts/sama5d4.dtsi               | 118 +++++++------
 drivers/pinctrl/pinctrl-at91.c          |  40 ++++-
 13 files changed, 726 insertions(+), 635 deletions(-)

-- 
2.25.1

