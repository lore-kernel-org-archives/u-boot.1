Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10BDC54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9067881FD;
	Fri, 22 Mar 2024 12:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711107819;
	bh=1B7EQYD4zyZltpQ9mmsk0oVM3EPjKWhl4KhScNTBzAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D56om+jOLmwfnxaqv0AxCejFfTHLn7QdrxhLfSsICMtChzNhaaZmBqR2bMDoRSsLS
	 f2SW/AiVJKfpZvRDi7TQr9DnbH+W0uJAJXEv65rylgtX/sSt+rwBuuHgxv/DcBFxOo
	 Z/gBtm0shwR4S/V8zwBuGhgj5V+x1MCz2XEasNnVgPDaFZkqfDRMAJXuyiBx/6QAnS
	 Zk8trG6M2A0yYpw7EedsWQ2scg2eadVLpcN/UtmnjykaGNH1BbD/nKUk4fmjXiFlcF
	 TG80Q6wW74TxMeuZLHGfRlIkq1g0gLOudrwzwsPYZggM0I6TAB2nnXV2o4m53r/f3+
	 xJN/oj7GfeuVQ==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 89820881DF;
 Fri, 22 Mar 2024 12:43:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711107816;
 bh=1B7EQYD4zyZltpQ9mmsk0oVM3EPjKWhl4KhScNTBzAw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q57/nAViGw8AuUCdVN3haRI285WFVeMU6ZWMLmIR0ylbsO5gRVCwjSN4Suv+AcmT4
 NYfmzZ2XBrIHqf9GiGxoySkGDRlkb9J2zqyJ2PGlW/Im1yssSj/o6WzcXy1Tg5++6t
 yvIyfU3yCG8x+fkzgZkN0ThYYz1e1BEdBmv8uo0mQPkV9clt7QPZFhZplREyn5h1Xk
 yJObxAG8mTyfdFqLkt8nxBmP7iijbPQhIqh/q3ZuS9gTlNUrwmnsZhZ4IYvaVgADdm
 peOfOKyP+RWNRu/1HcStTQrC7ar5T4us7qTshgxsGEqy07iXqhbwqAF8Nkak+ALQMm
 czc9h+WrTJtSw==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>,
	u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Christian Hewitt <christianshewitt@gmail.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Fabio Estevam <festevam@gmail.com>,
 Hai Pham <hai.pham.ud@renesas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 Mathieu Othacehe <othacehe@gnu.org>, Michal Simek <michal.simek@amd.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/12] arm: xea: Rename imx28-xea.dts to imx28-xea-1.dts
Date: Fri, 22 Mar 2024 12:43:06 +0100
Message-Id: <20240322114315.2720727-4-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240322114315.2720727-1-lukma@denx.de>
References: <20240322114315.2720727-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The former imx28-xea.dts file has been renamed to imx28-xea.dtsi, which
is included to new imx28-xea-1.dts file.

This is a preparatory work to add support for multiple versions of XEA
boards to u-boot.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

 arch/arm/dts/Makefile                          |  2 +-
 arch/arm/dts/imx28-xea-1-u-boot.dtsi           | 11 +++++++++++
 arch/arm/dts/imx28-xea-1.dts                   |  8 ++++++++
 arch/arm/dts/{imx28-xea.dts => imx28-xea.dtsi} |  0
 board/liebherr/xea/xea.env                     |  2 +-
 configs/imx28_xea_defconfig                    |  2 +-
 configs/imx28_xea_sb_defconfig                 |  2 +-
 7 files changed, 23 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/dts/imx28-xea-1-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx28-xea-1.dts
 rename arch/arm/dts/{imx28-xea.dts => imx28-xea.dtsi} (100%)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index b102ffb5f6..4fc508bcfc 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -879,7 +879,7 @@ dtb-$(CONFIG_TARGET_MX23_OLINUXINO) += \
 
 dtb-$(CONFIG_MX28) += \
 	imx28-evk.dtb \
-	imx28-xea.dtb
+	imx28-xea-1.dtb
 
 dtb-$(CONFIG_MX51) += \
 	imx51-babbage.dtb
diff --git a/arch/arm/dts/imx28-xea-1-u-boot.dtsi b/arch/arm/dts/imx28-xea-1-u-boot.dtsi
new file mode 100644
index 0000000000..4b2b21eeae
--- /dev/null
+++ b/arch/arm/dts/imx28-xea-1-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2024
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+/*
+ * The minimal augmentation DTS U-Boot file to allow eMMC driver
+ * configuration in SPL for falcon boot.
+ */
+#include "imx28-xea-u-boot.dtsi"
diff --git a/arch/arm/dts/imx28-xea-1.dts b/arch/arm/dts/imx28-xea-1.dts
new file mode 100644
index 0000000000..8cb1190ba5
--- /dev/null
+++ b/arch/arm/dts/imx28-xea-1.dts
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2024
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+/dts-v1/;
+#include "imx28-xea.dtsi"
diff --git a/arch/arm/dts/imx28-xea.dts b/arch/arm/dts/imx28-xea.dtsi
similarity index 100%
rename from arch/arm/dts/imx28-xea.dts
rename to arch/arm/dts/imx28-xea.dtsi
diff --git a/board/liebherr/xea/xea.env b/board/liebherr/xea/xea.env
index 043099ae87..ac6ac898ec 100644
--- a/board/liebherr/xea/xea.env
+++ b/board/liebherr/xea/xea.env
@@ -3,7 +3,7 @@ bootpri=mmc_mmc
 bootsec=sf_swu
 consdev=ttyAMA0
 baudrate=115200
-dtbfile=imx28-xea.dtb
+dtbfile=imx28-xea-1.dtb
 rootdev=/dev/mmcblk0p2
 netdev=eth0
 swufile=swupdate-image-xea-upd.itb
diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index 64a0561a34..42cbc3d34c 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -11,7 +11,7 @@ CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_IMX_CONFIG=""
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="imx28-xea"
+CONFIG_DEFAULT_DEVICE_TREE="imx28-xea-1"
 CONFIG_SPL_TEXT_BASE=0x1000
 CONFIG_TARGET_XEA=y
 CONFIG_SPL_MXS_PMU_MINIMAL_VDD5V_CURRENT=y
diff --git a/configs/imx28_xea_sb_defconfig b/configs/imx28_xea_sb_defconfig
index 9872d35c1b..30b3568e7f 100644
--- a/configs/imx28_xea_sb_defconfig
+++ b/configs/imx28_xea_sb_defconfig
@@ -9,7 +9,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="imx28-xea"
+CONFIG_DEFAULT_DEVICE_TREE="imx28-xea-1"
 CONFIG_SPL_TEXT_BASE=0x1000
 CONFIG_TARGET_XEA=y
 CONFIG_SPL=y
-- 
2.39.2

