Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637ABC0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 06:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D95280BA9;
	Mon, 10 Feb 2025 07:52:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="V/dMh2Ex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0586280A55; Mon, 10 Feb 2025 07:52:24 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E72F809D4
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 07:52:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1293da399=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1739170341; x=1770706341;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+NlTfA0EvAAdQPbL7E6Lw3IcHkU91RFeP4J3qoeCyDk=;
 b=V/dMh2Ex6LCDmbY0/C9XE3SV+m6xj62TZ2UF9NRslE2BxA85VRadi38F
 exA7FWvpJgVYy18Bt7LpLhdVBA7VH3VTCXEGiwlOSC7Xs6tmHKlbxEOSD
 GDytjwbk2kPEMRWQ1tOBWaalFhfcTE1rFDJag8Hab21CLLuRY/eH53kXg
 c9soLQhhzxKTpN6brTqsne+jtAtLpHuseEJ137HBmgpx+bBawD8sTnToh
 b+ekzJ9kOT1Ai1uirEBnDU3cq8sxve51EG6U0DnmvEFDKedJ3aSoZtSUt
 O1MQmsXhOMu1Y8iV6seynaV4orhPVXjmihPKBpe84ZqEg5BydtqBvnhV9 g==;
X-CSE-ConnectionGUID: l7eC6ISbRG2IhJavUmxzKw==
X-CSE-MsgGUID: kR/AReGWT5mHqRMWhVWOOw==
X-IronPort-AV: E=Sophos;i="6.13,273,1732604400"; d="scan'208";a="37072169"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 09 Feb 2025 23:52:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 9 Feb 2025 23:51:49 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 9 Feb 2025 23:51:47 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v3 0/7] Align pio3 pinctrl node with Linux
Date: Mon, 10 Feb 2025 12:21:36 +0530
Message-ID: <20250210065143.313553-1-manikandan.m@microchip.com>
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

Changes in v3:
- 5/7 - Add comment block to describe at91_pinctrl_bind()


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
 drivers/pinctrl/pinctrl-at91.c          |  52 +++++-
 13 files changed, 738 insertions(+), 635 deletions(-)

-- 
2.25.1

