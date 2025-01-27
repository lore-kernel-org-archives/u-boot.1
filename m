Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7402AC0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 10:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0CCD81119;
	Mon, 27 Jan 2025 11:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="oo5W506v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D7FA811BA; Mon, 27 Jan 2025 11:10:55 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95898811C5
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 11:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1152fbf31=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1737972652; x=1769508652;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=V+KYJKsy8G2JvOUkDkdKAYB11O2lpnN9xzw5AgOU3fY=;
 b=oo5W506vPDIoiHfdKwGnODXykzPrKx9O1CWYrsBoqSyHQxbpnEsftJ5x
 yjcpaiCAVxR/e8sjFduFX3AG4PJkehH7aUqvRVndqUssBbC0XHl1UATZj
 O63m6KHhjvkaONiAM98e+lZhkGBoQtf4FcdNEvvYj8muoUJxETl49gz+5
 ZJzdQECNhVn5UxuIKEUoToqJRPekZU7l3upcrPQO4rAO0f49X49cbIfJG
 TjtauIEn9xybldr3AzlPVV6N9z6gEaeXXjGNLW2TNL/6IDiGbgDuhs+88
 12UbqOGFsQQpnvMQH0eaHa+m1p9QKjL5eam3ZMuvV5GN6oJrTbNiR0QoV A==;
X-CSE-ConnectionGUID: nUyEV9LgSwaveS2mWdP90Q==
X-CSE-MsgGUID: kArFs5YVR/u2O9TKNeA1pA==
X-IronPort-AV: E=Sophos;i="6.13,238,1732604400"; d="scan'208";a="37387922"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Jan 2025 03:10:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 Jan 2025 03:09:36 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 27 Jan 2025 03:09:33 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 0/7] Align pio3 pinctrl node with Linux
Date: Mon, 27 Jan 2025 15:39:23 +0530
Message-ID: <20250127100930.108377-1-manikandan.m@microchip.com>
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
 arch/arm/dts/at91sam9261.dtsi           |  77 +++++----
 arch/arm/dts/at91sam9263.dtsi           | 117 +++++++------
 arch/arm/dts/at91sam9g45.dtsi           | 106 ++++++------
 arch/arm/dts/at91sam9n12.dtsi           |  93 +++++------
 arch/arm/dts/at91sam9rl.dtsi            |  93 +++++------
 arch/arm/dts/at91sam9x5.dtsi            |  90 +++++-----
 arch/arm/dts/sam9x60.dtsi               | 149 +++++++----------
 arch/arm/dts/sam9x60ek.dts              | 209 ++++++++++++++++--------
 arch/arm/dts/sama5d3.dtsi               | 116 +++++++------
 arch/arm/dts/sama5d4.dtsi               | 118 +++++++------
 drivers/pinctrl/pinctrl-at91.c          |  40 ++++-
 13 files changed, 720 insertions(+), 635 deletions(-)

-- 
2.25.1

