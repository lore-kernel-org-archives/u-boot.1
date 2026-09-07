Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC36C79FA3
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 15:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AA20606A3;
	Mon,  7 Sep 2026 15:34:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oSjZICPGwylL; Mon,  7 Sep 2026 15:34:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 64CCE606A6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788795294;
	b=VoUubJClG61asXx0jX8sccbxeodSB5FstfMTxgMgWPj04S4jwdl6wAXAZtZg4weqgHfz
	 JplValGKZClusqNMOqYvLGZWOBNZeCJRWbpPPXdX46H2LXmGcXRJHpnROM54RUOrLgIxy
	 VDauoyQ+AxFSmLBNrPkf4J4J2HYqT6RWrjhVCY0m3oFPp0B+cMRWQmRgN3GZ4kEO60qPl
	 AWaUWEVYCIVP/fcNywAT/Cne50w3Cq16NkISiwPo0qyVkIas1CAbSxY9vFtweFIU4Eh1i
	 aq0xSUNmGVT/TY1v16M5ttuAMrDDuyeNiq+RHB3Qu5Ra0PIWYZgoTwPFZXnLpuVXjOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788795294;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hM2MY1CQNvwuFCQKGtZvDmkNF0KY1iMkLCAmQj2sh9U=;
	b=NLjVeTrBbaS9iFBuBRRpq5LFjlT1nGnCKGk1b5qN0J6nuXYHjd+AGDC3eJDH0JTpDQH8
	 69Ylj9tzXrbNq4UM1/G/g79itM5dT8n4VpHnd6TLK6+fZb7/7aJMRG11pElJskbK4lAUD
	 Z/GTb5kzqUNZl9IK9D1N0vM9Yg8ljHYElPmX2Y16a7xMroA1sgh0Ra4pNGkPOxv0K7AxD
	 ETGU6eabpPvOiLPtygrqv5z5hRWWI5FvQ15Vbrs+YkO40qFMutTdFPlDIDgNPNaNIXfbA
	 YMRpPA18Mt3m0lU+AeFzbQioaysxsaZbP6wkF2jZgVUkuKDmOb/IpsOvwO2cnKOBd1Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788795294;
	bh=hM2MY1CQNvwuFCQKGtZvDmkNF0KY1iMkLCAmQj2sh9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w7YVFlgkq9l8wB2rpXb/ekjsfehzgGyrGuJBd2MiF4Q4XnuaeVrhCFgJ7nBzkddV6
	 du0pG37yqFQR3lSxicWWS1YofWxyI78mt4w3ghKCdVaqBPpE2QEW4jNTUDFs0QpQ0g
	 4wvPlMj7K6yYkHZ+W5qXCrabbOHE1LKNU0WCvPPx3yLbR1DgiFP88TO0T97mjI6sVX
	 3yOUjikd2+BsKCbD98CiOoAvuucyjOTWhDR+ICQofai4IJSBDkbmwtOCqE+i/eeuNO
	 Jsi2nq4cxV3dDg9F0jvfs52VJYZHH7BBeZtgja7CrpcYEH9J4lUMkKhcrwgGvsQ6o+
	 00K0bw64a7gvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64CCE606A6;
	Mon,  7 Sep 2026 15:34:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D1C49CF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8EBC840106
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:34:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DVHzRkVOp-LY for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 15:34:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A3AA040103
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788795291;
 b=ZZa/13NJHks74RJWEmcoI2issLMEOFEj653JOw/VRVGDHTtft6hh64CvdgfJz8QuUACD
 qVMmgRLGOPprbSVabYkZ36H/LE5CLV3jiXtyY30/+Bn7lyinvAGnC+rYWQPGA3iF7X6Li
 UwF1ZBLOipff3YM6QmRt2RA3SzJDnEnqgDC1+LZ0hzobjSwTfsmunn9t/qwNxiWtI7XoC
 Mvgm4XCFn2M5GxAV0k84RKfszlxGtihDr3LL5zTvN2KwIIsyXY9RtzcNQ/7QaekcmnXQ8
 BKEV2y55dv++h+CYm/fCLfqFyaTPaBdzt5xqZOnSpn1jmTUhweW5LnA3ia5KL3ei7AQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788795291;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=hM2MY1CQNvwuFCQKGtZvDmkNF0KY1iMkLCAmQj2sh9U=;
 b=rNQVBYe55bq0V08l46kakxMT5wA56BIyyak8ZfqYp47VkSjBL7PKc0Jrh7ebXiiTK/92
 /Go+jaG4R1VM7mkwy77jVMmXsJzGZCAYQwwcp/+K7F2VsSE44PpaWSEccHDmYb3d5khDs
 uYiVvbEAPneKc9jwZdrNjUe8j87Zi4oWTT9vmBdLH9RIzt0BlF8y41EPxAkwMNE3mZAlk
 W3/u91rImLcEWlL/2CnzJ5HSJhmO+F1ySkw6IizSGbPF5qxqulcWwI04ZrN1dnZZ9QsWJ
 U6JCAJG3XUwCt6SCOhVaqirjOZ0NLVaDEi9PwOilZF8b4ckDx4tmPUtDpvW9lCsgckA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=hj0TYRb5; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=hj0TYRb5
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A3AA040103
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:34:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id F00CBB00583;
 Mon,  7 Sep 2026 17:34:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1788795288;
 bh=9ymWRPjr6VInhAE//2gmjOOJoXnMHo8rVkNfk4bCoOU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hj0TYRb5PBuik3dR89LS7v5CYtc9BsaYBKye9nM+4E7lczTV9wt99z30ds1sLrfmb
 0lKKtmZUuRz/6/y39xj1lZOXnk7jYvkR1qYvpC0Mx1P5/OJ4Plc8FPPuLC/0i80alT
 wi7WhaXDwkBdBOOAp0PlqBYZMPee2qC27Eb//Vqv4lwsI9oGwKFmuvlBzPFeLIP10e
 2aG/+05YmFVvEm4sZJA+f/6HRu9C12d0UsNhkJsvuYcygkjsXHdV9jw2ji5N+Aw95K
 c9JTAcb+zArkS8VxAwbvNs7uOU7wHbJR5VreWUEU4fnAZu9wabxbUFvKG+0++GSx0u
 tgTq4W7jiLc9Q==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Simon Glass <sjg@chromium.org>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 1/8] board: nxp: add Nodebox v3 CPU Module (LX2160A)
Date: Mon,  7 Sep 2026 17:34:03 +0200
Message-ID: <20260907153411.2207773-2-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907153411.2207773-1-vjardin@free.fr>
References: <20260907153411.2207773-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Introduce TARGET_NBXV3 for the Free Mobile Nodebox v3 CPU Module, an
LX2160A based platform.

eth_nbxv3 renames the DPAA2 Ethernet devices from a "u-boot,nickname"
DT property (EVT_DM_PRE_PROBE spy) to something more user friendly.

Currently CONFIG_ID_EEPROM is not set since the NXP format is not used
on this board.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

Changes in v2:
- Device tree: the board DT fsl-lx2160a-nbxv3.dtsi is now shared
  with Linux too, sent in parallel to the kernel list for review
  https://lore.kernel.org/all/20260907-for-upstream-nbxv3-dts-v1-3-f43fd0028b78@free.fr/
- Squashed the former per-peripheral patches 10-23 into this base
  port to align with the new DT approach.
- FIT stays the default boot path; CONFIG_EFI_LOADER is left off for
  footprint
- checkpatch: IS_ENABLED() for the MC boot call in eth_nbxv3.c
- VID handoff: fix voltage table per the doc and avoid manual correction
  since the MPQ devices does it on its own.

 arch/arm/Kconfig                           |  12 +
 arch/arm/dts/Makefile                      |   1 +
 arch/arm/dts/fsl-lx2160a-nbxv3-u-boot.dtsi |  67 ++++
 arch/arm/dts/fsl-lx2160a-nbxv3.dts         |  16 +
 arch/arm/dts/fsl-lx2160a-nbxv3.dtsi        | 342 +++++++++++++++++++++
 board/nxp/lx2160a/Kconfig                  |  45 +++
 board/nxp/lx2160a/MAINTAINERS              |  11 +
 board/nxp/lx2160a/Makefile                 |   1 +
 board/nxp/lx2160a/nbxv3/Makefile           |   5 +
 board/nxp/lx2160a/nbxv3/eth_nbxv3.c        |  53 ++++
 configs/nbxv3_tfa_defconfig                | 106 +++++++
 include/configs/nbxv3.h                    |  57 ++++
 12 files changed, 716 insertions(+)
 create mode 100644 arch/arm/dts/fsl-lx2160a-nbxv3-u-boot.dtsi
 create mode 100644 arch/arm/dts/fsl-lx2160a-nbxv3.dts
 create mode 100644 arch/arm/dts/fsl-lx2160a-nbxv3.dtsi
 create mode 100644 board/nxp/lx2160a/nbxv3/Makefile
 create mode 100644 board/nxp/lx2160a/nbxv3/eth_nbxv3.c
 create mode 100644 configs/nbxv3_tfa_defconfig
 create mode 100644 include/configs/nbxv3.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1b474a346bf..fe4045548b1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1572,6 +1572,18 @@ config TARGET_LX2162AQDS
 	  Support for NXP LX2162AQDS platform.
 	  The lx2162aqds support is based on LX2160A Layerscape Architecture processor.
 
+config TARGET_NBXV3
+	bool "Support Nodebox v3 CPU Module (LX2160A)"
+	select ARCH_LX2160A
+	select ARM64
+	select ARMV8_MULTIENTRY
+	select ARCH_SUPPORT_TFABOOT
+	select BOARD_LATE_INIT
+	select GPIO_EXTRA_HEADER
+	help
+	  Support for the Free Mobile Nodebox v3 CPU Module, an LX2160A
+	  based platform.
+
 config TARGET_HIKEY
 	bool "Support HiKey 96boards Consumer Edition Platform"
 	select ARM64
diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index a02dad22f27..a1b4e283584 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -470,6 +470,7 @@ dtb-$(CONFIG_FSL_LSCH3) += fsl-ls2080a-qds.dtb \
 	fsl-ls1028a-qds-duart.dtb \
 	fsl-ls1028a-qds-lpuart.dtb \
 	fsl-lx2160a-rdb.dtb \
+	fsl-lx2160a-nbxv3.dtb \
 	fsl-lx2160a-qds.dtb \
 	fsl-lx2160a-qds-3-x-x.dtb \
 	fsl-lx2160a-qds-3-11-x.dtb \
diff --git a/arch/arm/dts/fsl-lx2160a-nbxv3-u-boot.dtsi b/arch/arm/dts/fsl-lx2160a-nbxv3-u-boot.dtsi
new file mode 100644
index 00000000000..63c08569446
--- /dev/null
+++ b/arch/arm/dts/fsl-lx2160a-nbxv3-u-boot.dtsi
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Free Mobile Nodebox v3 CPU Module (LX2160A), U-Boot specific
+ *
+ * Copyright 2026 Free Mobile, Vincent Jardin
+ */
+
+/ {
+	aliases {
+		spi0 = &dspi0;
+		spi2 = &dspi2;
+		spi3 = &fspi;
+	};
+};
+
+&dpmac13 {
+	u-boot,nickname = "ptp0";
+};
+
+&dpmac14 {
+	u-boot,nickname = "ptp1";
+};
+
+&dpmac17 {
+	u-boot,nickname = "lanconsole0";
+};
+
+&fsl_mc {
+	compatible = "fsl,qoriq-mc", "simple-mfd";
+
+	dpmacs {
+		compatible = "simple-mfd";
+	};
+};
+
+&i2c0 {
+	bootph-all;
+};
+
+/* The VID hand-off */
+&vdd08 {
+	regulator-name = "+0V8_VDD";
+	regulator-min-microvolt = <600000>;
+	regulator-max-microvolt = <1100000>;
+	regulator-boot-on;
+	regulator-always-on;
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+/*
+ * DDR training, MC boot, DPL apply and a big NOR kernel load do
+ * not fit in the 30s default.
+ */
+&wdt0 {
+	timeout-sec = <120>;
+};
diff --git a/arch/arm/dts/fsl-lx2160a-nbxv3.dts b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
new file mode 100644
index 00000000000..258d3a1a83e
--- /dev/null
+++ b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Free Mobile Nodebox v3 CPU Module (LX2160A)
+ *
+ * Copyright 2026 Free Mobile, Vincent Jardin
+ */
+
+/dts-v1/;
+
+#include "fsl-lx2160a.dtsi"
+#include "fsl-lx2160a-nbxv3.dtsi"
+
+/ {
+	model = "Free Mobile Nodebox v3 CPU Module (LX2160A)";
+	compatible = "freemobile,nbxv3", "fsl,lx2160a";
+};
diff --git a/arch/arm/dts/fsl-lx2160a-nbxv3.dtsi b/arch/arm/dts/fsl-lx2160a-nbxv3.dtsi
new file mode 100644
index 00000000000..bd10eccac4f
--- /dev/null
+++ b/arch/arm/dts/fsl-lx2160a-nbxv3.dtsi
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Free Mobile Nodebox v3 CPU Module (LX2160A)
+ *
+ * Copyright 2026 Free Mobile, Vincent Jardin
+ *
+ * This file is shared by the Linux kernel and U-Boot.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-restart {
+		compatible = "gpio-restart";
+		gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+		priority = <128>;
+	};
+};
+
+&crypto {
+	status = "okay";
+};
+
+&dspi0 {
+	status = "okay";
+
+	dpll@0 {
+		compatible = "microchip,zl30733";
+		reg = <0>;
+		spi-max-frequency = <12500000>;
+	};
+};
+
+&dspi2 {
+	status = "okay";
+};
+
+&dpmac13 {
+	status = "okay";
+	phy-handle = <&lan8023_phy_s0>;
+	phy-connection-type = "10gbase-r";
+};
+
+&dpmac14 {
+	status = "okay";
+	phy-handle = <&lan8023_phy_s1>;
+	phy-connection-type = "10gbase-r";
+};
+
+&dpmac17 {
+	status = "okay";
+	phy-handle = <&rtl8211fd>;
+	phy-connection-type = "rgmii-id";
+};
+
+&emdio1 {
+	status = "okay";
+
+	/* Microchip LAN8023 dual 10G PCS/retimer, Clause 45 only, one address per slice */
+	lan8023_phy_s0: ethernet-phy@2 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <2>;
+	};
+
+	lan8023_phy_s1: ethernet-phy@3 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <3>;
+	};
+
+	rtl8211fd: ethernet-phy@6 {
+		compatible = "ethernet-phy-id001c.c916";
+		reg = <6>;
+	};
+};
+
+&emdio2 {
+	status = "okay";
+};
+
+&esdhc1 {
+	status = "okay";
+	bus-width = <8>;
+	non-removable;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+};
+
+&fspi {
+	status = "okay";
+
+	/* GigaDevice GD55LB02GF, 256 MiB boot NOR */
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <150000000>;
+		spi-rx-bus-width = <1>;
+		spi-tx-bus-width = <1>;
+	};
+};
+
+&fsl_mc {
+	status = "okay";
+};
+
+&gpio0 {
+	status = "okay";
+	gpio-line-names =
+		"", "",
+		"altfn:iic1-sda", "altfn:iic1-scl",
+		"altfn:uart4-sin", "altfn:uart4-sout",
+		"altfn:uart2-sin", "altfn:uart2-sout",
+		"altfn:uart3-sin", "altfn:uart3-sout",
+		"altfn:uart1-sin", "altfn:uart1-sout",
+		"altfn:spi3-pcs3", "altfn:spi3-pcs2",
+		"altfn:spi3-pcs1", "altfn:spi3-pcs0",
+		"altfn:spi1-sck", "altfn:spi1-sin",
+		"altfn:spi1-pcs2", "altfn:spi1-pcs1",
+		"altfn:spi1-pcs0", "altfn:spi1-sout",
+		"altfn:iic6-sda", "altfn:iic6-scl",
+		"altfn:spi3-sin", "altfn:spi3-sout",
+		"altfn:iic4-sda", "altfn:iic4-scl",
+		"altfn:iic3-sda", "altfn:iic3-scl",
+		"altfn:iic2-sda", "altfn:iic2-scl";
+};
+
+&gpio1 {
+	status = "okay";
+	gpio-line-names =
+		"", "", "", "", "", "",
+		"cfg-rcw-src2", "cfg-rcw-src3",
+		"reset-req-b",
+		"altfn:sdhc2-clk", "altfn:sdhc2-ds",
+		"altfn:sdhc2-dat0", "altfn:sdhc2-dat1",
+		"altfn:sdhc2-dat2", "altfn:sdhc2-dat3",
+		"altfn:sdhc2-dat4", "altfn:sdhc2-dat5",
+		"altfn:sdhc2-dat6", "altfn:sdhc2-dat7",
+		"altfn:sdhc2-cmd",
+		"cfg-svr1",
+		"altfn:xspi1-cs0", "altfn:xspi1-sck",
+		"thermtrip",
+		"altfn:xspi1-data0", "altfn:xspi1-data1",
+		"", "",
+		"flash-reset#", "pltrst#", "", "ethsw-reset#";
+
+	pltrst-hog {
+		gpio-hog;
+		gpios = <29 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "pltrst#";
+	};
+
+	thermtrip-hog {
+		gpio-hog;
+		gpios = <23 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "thermtrip";
+	};
+
+	/* Boot NOR reset, released: electrical high */
+	flash-reset-hog {
+		gpio-hog;
+		gpios = <28 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "flash-reset#";
+	};
+
+	/* Ethernet switch reset, released: electrical high */
+	ethsw-reset-hog {
+		gpio-hog;
+		gpios = <31 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "ethsw-reset#";
+	};
+};
+
+&gpio2 {
+	status = "okay";
+	gpio-line-names =
+		"lan8023-mdint",
+		"i2c2-alert#", "i2c4-alert#", "i2c6-alert#",
+		"u800-tca9539-int#",
+		"spi3-alert#",
+		"wake0", "wake1",
+		"carrier-hot#",
+		"u1300-rtl8211fd-int#",
+		"ethsw-int#",
+		"", "",
+		"u1700-zl30733-clk-gpio0", "u1700-zl30733-clk-gpio1",
+		"u1700-zl30733-clk-gpio2", "u1700-zl30733-clk-gpio3",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "";
+};
+
+&gpio3 {
+	status = "okay";
+	gpio-line-names =
+		"altfn:ec1-txd3", "altfn:ec1-txd2",
+		"altfn:ec1-txd1", "altfn:ec1-txd0",
+		"altfn:ec1-tx-en", "altfn:ec1-gtx-clk",
+		"altfn:ec1-rxd3", "altfn:ec1-rxd2",
+		"altfn:ec1-rxd1", "altfn:ec1-rxd0",
+		"altfn:ec1-rx-clk", "altfn:ec1-rx-dv",
+		"", "",
+		"ptp-refclk-in",
+		"", "", "", "", "", "", "", "",
+		"u1700-zl30733-pps-out",
+		"",
+		"ethsw-mdio-en",
+		"usb01-oc#",	/* USB1_PWRFAULT and USB2_PWRFAULT share one net */
+		"",
+		"usb01-oc#",
+		"altfn:spi3-sck",
+		"", "";
+
+	/* Low enables the carrier-side EMDIO2 level translator */
+	ethsw-mdio-en-hog {
+		gpio-hog;
+		gpios = <25 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "ethsw-mdio-en";
+	};
+};
+
+/* On-module management bus */
+&i2c0 {
+	status = "okay";
+
+	eeprom@52 {
+		compatible = "atmel,24c32";
+		reg = <0x52>;
+		pagesize = <32>;
+	};
+
+	/* Board ID straps */
+	gpio@74 {
+		compatible = "ti,tca9539";
+		reg = <0x74>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"boardid-0x0001", "boardid-0x0002",
+			"boardid-0x0004", "boardid-0x0008",
+			"boardid-0x0010", "boardid-0x0020",
+			"boardid-0x0040", "boardid-0x0080",
+			"boardid-0x0100", "boardid-0x0200",
+			"boardid-0x0400", "boardid-0x0800",
+			"boardid-0x1000", "boardid-0x2000",
+			"boardid-0x4000", "boardid-0x8000";
+	};
+
+	u800: gpio@75 {
+		compatible = "ti,tca9539";
+		reg = <0x75>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"carrier-gpio0", "carrier-gpio1",
+			"carrier-gpio2", "carrier-gpio3",
+			"carrier-gpio4", "carrier-gpio5",
+			"carrier-gpio6", "carrier-gpio7",
+			"carrier-gpio8", "carrier-gpio9",
+			"carrier-gpio10", "carrier-gpio11",
+			"", "", "",
+			"lan8023-rst";
+	};
+
+	/* +0V8_VDD core rail, MPS MPQ8646 (MPQ8785 core) over PMBus */
+	vdd08: regulator@10 {
+		compatible = "mps,mpq8646";
+		reg = <0x10>;
+	};
+
+	/* SO-DIMM SPD temperature sensors */
+	temperature-sensor@18 {
+		compatible = "jedec,jc-42.4-temp";
+		reg = <0x18>;
+	};
+
+	temperature-sensor@19 {
+		compatible = "jedec,jc-42.4-temp";
+		reg = <0x19>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&pcie3 {
+	status = "okay";
+};
+
+&pcie4 {
+	status = "okay";
+};
+
+&pcie5 {
+	status = "okay";
+};
+
+&pcie6 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
diff --git a/board/nxp/lx2160a/Kconfig b/board/nxp/lx2160a/Kconfig
index 5764c83ab08..efd245bb68a 100644
--- a/board/nxp/lx2160a/Kconfig
+++ b/board/nxp/lx2160a/Kconfig
@@ -45,3 +45,48 @@ config SYS_CONFIG_NAME
 	default "lx2162aqds"
 
 endif
+
+if TARGET_NBXV3
+
+config SYS_BOARD
+	default "lx2160a"
+
+config SYS_VENDOR
+	default "nxp"
+
+config SYS_SOC
+	default "fsl-layerscape"
+
+config SYS_CONFIG_NAME
+	default "nbxv3"
+
+config NBXV3_DM_EVENT
+	bool
+	default y
+	select DM_EVENT
+
+config NBXV3_PMBUS
+	bool
+	default y
+	select PMBUS
+	select CMD_PMBUS
+	select DM_REGULATOR
+	select DM_REGULATOR_PMBUS_HELPER
+	select DM_REGULATOR_MPQ8785
+	select DM_REGULATOR_PMBUS_GENERIC
+	select CMD_REGULATOR
+
+config NBXV3_DPLL
+	bool
+	default y
+	select SPI
+	select DM_SPI
+	select FSL_DSPI
+
+config NBXV3_FAN
+	bool
+	default y
+	select DM_REGULATOR
+	select DM_REGULATOR_FIXED
+
+endif
diff --git a/board/nxp/lx2160a/MAINTAINERS b/board/nxp/lx2160a/MAINTAINERS
index abdac1372d2..eebda365d00 100644
--- a/board/nxp/lx2160a/MAINTAINERS
+++ b/board/nxp/lx2160a/MAINTAINERS
@@ -53,3 +53,14 @@ LX2162AQDS_VERIFIED_BOOT BOARD
 M:	Manish Tomar <Manish.Tomar@nxp.com>
 S:	Maintained
 F:	configs/lx2162aqds_tfa_verified_boot_defconfig
+
+NBXV3 BOARD
+M:	Vincent Jardin <vjardin@free.fr>
+S:	Maintained
+F:	board/nxp/lx2160a/nbxv3/
+F:	include/configs/nbxv3.h
+F:	configs/nbxv3_tfa_defconfig
+F:	arch/arm/dts/fsl-lx2160a-nbxv3.dts
+F:	arch/arm/dts/fsl-lx2160a-nbxv3.dtsi
+F:	arch/arm/dts/fsl-lx2160a-nbxv3-u-boot.dtsi
+F:	doc/board/nxp/nbxv3.rst
diff --git a/board/nxp/lx2160a/Makefile b/board/nxp/lx2160a/Makefile
index c9561bfadea..9a617a1f094 100644
--- a/board/nxp/lx2160a/Makefile
+++ b/board/nxp/lx2160a/Makefile
@@ -9,3 +9,4 @@ obj-y += ddr.o
 obj-$(CONFIG_TARGET_LX2160ARDB) += eth_lx2160ardb.o
 obj-$(CONFIG_TARGET_LX2160AQDS) += eth_lx2160aqds.o
 obj-$(CONFIG_TARGET_LX2162AQDS) += eth_lx2162aqds.o
+obj-$(CONFIG_TARGET_NBXV3) += nbxv3/
diff --git a/board/nxp/lx2160a/nbxv3/Makefile b/board/nxp/lx2160a/nbxv3/Makefile
new file mode 100644
index 00000000000..90ef2734eec
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2026 Free Mobile - Vincent Jardin
+#
+
+obj-y += eth_nbxv3.o
diff --git a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
new file mode 100644
index 00000000000..8aec68c571f
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * Nodebox v3 CPU Module Ethernet wiring.
+ */
+
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/ofnode.h>
+#include <dm/uclass.h>
+#include <event.h>
+#include <netdev.h>
+#include <exports.h>
+#include <fsl-mc/fsl_mc.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_eth_init(struct bd_info *bis)
+{
+	return 0;
+}
+
+#if defined(CONFIG_RESET_PHY_R)
+void reset_phy(void)
+{
+	if (IS_ENABLED(CONFIG_FSL_MC_ENET))
+		mc_env_boot();
+}
+#endif /* CONFIG_RESET_PHY_R */
+
+/*
+ * Enforce the per DPMAC u-boot,nickname DT property as the U-Boot device
+ * name, so `dm tree` and `setenv ethact ...` show role based names
+ * (lanconsole0, ptp0, ptp1) instead of the auto generated
+ * DPMAC<n>@<phy-mode> string
+ */
+static int nbxv3_eth_apply_nickname(void *ctx, struct event *event)
+{
+	struct udevice *dev = event->data.dm.dev;
+	const char *nick;
+
+	if (device_get_uclass_id(dev) != UCLASS_ETH)
+		return 0;
+
+	nick = ofnode_read_string(dev_ofnode(dev), "u-boot,nickname");
+	if (!nick)
+		return 0;
+
+	return device_set_name(dev, nick);
+}
+
+EVENT_SPY_FULL(EVT_DM_PRE_PROBE, nbxv3_eth_apply_nickname);
diff --git a/configs/nbxv3_tfa_defconfig b/configs/nbxv3_tfa_defconfig
new file mode 100644
index 00000000000..bc90bb0594c
--- /dev/null
+++ b/configs/nbxv3_tfa_defconfig
@@ -0,0 +1,106 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_GIC_V3_ITS=y
+CONFIG_TARGET_NBXV3=y
+CONFIG_TFABOOT=y
+CONFIG_TEXT_BASE=0x82000000
+CONFIG_SYS_MALLOC_LEN=0x202000
+CONFIG_SYS_MALLOC_F_LEN=0x6000
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x500000
+CONFIG_ENV_SECT_SIZE=0x20000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="fsl-lx2160a-nbxv3"
+CONFIG_FSPI_AHB_EN_4BYTE=y
+CONFIG_SYS_MONITOR_LEN=958464
+CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=y
+CONFIG_SEC_FIRMWARE_ARMV8_PSCI=y
+CONFIG_ENV_ADDR=0x20500000
+CONFIG_PCI=y
+CONFIG_OF_BOARD_FIXUP=y
+CONFIG_SYS_FSL_NUM_CC_PLLS=4
+CONFIG_REMAKE_ELF=y
+CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyAMA0,115200 earlycon=pl011,mmio32,0x21c0000 nokaslr"
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_PBSIZE=532
+CONFIG_LAST_STAGE_INIT=y
+# CONFIG_ID_EEPROM is not set
+CONFIG_PCI_INIT_R=y
+CONFIG_RESET_PHY_R=y
+CONFIG_CMDLINE_PS_SUPPORT=y
+CONFIG_CMD_HISTORY=y
+CONFIG_CMD_GREPENV=y
+CONFIG_CMD_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
+CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
+CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_TEMPERATURE=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_WDT=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_RNG=y
+CONFIG_CMD_LOG=y
+CONFIG_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_SPI_BUS=3
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="lanconsole0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_FSL_CAAM=y
+CONFIG_DYNAMIC_DDR_CLK_FREQ=y
+CONFIG_DDR_ECC=y
+CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
+CONFIG_SYS_FSL_DDR_INTLV_256B=y
+CONFIG_GPIO_HOG=y
+CONFIG_DM_PCA953X=y
+CONFIG_MPC8XXX_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x52
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_ESDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_REALTEK=y
+CONFIG_SYS_MEMAC_LITTLE_ENDIAN=y
+CONFIG_PCIE_LAYERSCAPE_RC=y
+CONFIG_PCI_IOMMU_EXTRA_MAPPINGS=y
+CONFIG_PCIE_LAYERSCAPE_GEN4=y
+CONFIG_DM_RNG=y
+CONFIG_DM_SERIAL=y
+CONFIG_PL01X_SERIAL=y
+CONFIG_NXP_FSPI=y
+CONFIG_DM_THERMAL=y
+CONFIG_IMX_TMU=y
+CONFIG_DM_THERMAL_JC42=y
+CONFIG_PMBUS_THERMAL=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_MAX_CONTROLLER_COUNT=2
+CONFIG_WDT=y
+CONFIG_WDT_SBSA=y
+CONFIG_SEMIHOSTING=y
+CONFIG_ZSTD=y
diff --git a/include/configs/nbxv3.h b/include/configs/nbxv3.h
new file mode 100644
index 00000000000..c266e0f9fe2
--- /dev/null
+++ b/include/configs/nbxv3.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * Nodebox v3 CPU Module config header.
+ */
+
+#ifndef __NBXV3_H
+#define __NBXV3_H
+
+#include "lx2160a_common.h"
+
+#define CFG_EXTRA_ENV_SETTINGS						\
+	"pci_iommu_extra=pci@0x3600000,1.0.0,hp,"			\
+		"pci@0x3700000,1.0.0,hp,"				\
+		"pci@0x3800000,1.0.0,hp,"				\
+		"pci@0x3900000,1.0.0,hp\0"				\
+	"kernel_addr_r=0xc0000000\0"					\
+	"fit_nor_offset=0x1000000\0"					\
+	"fit_nor_size=0x1000000\0"					\
+	"mcmemsize=0x70000000\0"					\
+	"mcinitcmd="							\
+		"sf probe 3:0 && "					\
+		"sf read ${kernel_addr_r} ${fit_nor_offset} ${fit_nor_size} && "\
+		"imxtract ${kernel_addr_r} mc 0xa8000000 && "		\
+		"imxtract ${kernel_addr_r} dpc-${carrier} 0xa9000000 && "\
+		"imxtract ${kernel_addr_r} dpl-${carrier} 0xaa000000 && "\
+		"fsl_mc start mc 0xa8000000 0xa9000000 && "		\
+		"fsl_mc lazyapply dpl 0xaa000000\0"			\
+	"mc_init=bootm ${kernel_addr_r}#conf-${carrier}\0"		\
+	"linux_boot_fit="						\
+		"sf probe 3:0 && "					\
+		"sf read ${kernel_addr_r} ${fit_nor_offset} ${fit_nor_size} && "\
+		"bootm ${kernel_addr_r}#conf-${carrier}\0"		\
+	"host_boot="							\
+		"load semihosting - ${kernel_addr_r} fit.itb && "	\
+		"bootm ${kernel_addr_r}#conf-${carrier}\0"		\
+	"provision_openocd_fit="					\
+		"load semihosting - ${kernel_addr_r} fit.itb && "	\
+		"sf probe 3:0 && "					\
+		"sf erase ${fit_nor_offset} ${fit_nor_size} && "	\
+		"sf write ${kernel_addr_r} ${fit_nor_offset} ${filesize} && "\
+		"reset\0"						\
+	"xspi_bootcmd="							\
+		"cp.b 0x21000000 ${kernel_addr_r} ${fit_nor_size} && "	\
+		"bootm ${kernel_addr_r}#conf-${carrier}\0"		\
+	"fsl_bootcmd_mcinitcmd_set=y\0"					\
+	"bootcmd=run mc_init || run provision_openocd_fit\0"		\
+	"mdio_list="							\
+		"echo === Nbxv3 probed PHYs === && "			\
+		"mdio list\0"						\
+	"PS1=nbxv3> \0"							\
+	"ps_refresh="							\
+		"setenv PS1 \"nbxv3 ${ethact} ${ipaddr}> \"\0"		\
+	"preboot=run mdio_list ; run ps_refresh\0"
+
+#endif /* __NBXV3_H */
-- 
2.43.0

