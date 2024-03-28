Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC950C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 12:21:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 294B187EAF;
	Thu, 28 Mar 2024 13:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WM+R3zJm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8A9E88148; Thu, 28 Mar 2024 13:21:31 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BE1187E8E
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 13:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ea7b38f773so191099b3a.0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 05:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711628488; x=1712233288; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bkVOahQLydHEod93fC0SSmcRUZmoYjI/cICd23zyl14=;
 b=WM+R3zJmB5lIMtWl2ciiFrzA4Qr440O8YNz9YZHiHrChZ7PFmi4+RvzmbkwabvbUbS
 MCSKBv3wMhrJM/IMAEdm/tIpa1jmh3dNIOrQhrmgKydx8pFMZsA8fIA+LcbERwCm1N1+
 7vbnW/Qh2rSn7Wivp/o/unw9SVuJlmnfdRc/iqkqzy/zpCmnaQF/wYfSfuHPsVIAy6r1
 T4ShKjuTg8dj0sXl1jHicWwN1X9/cQQlkFBE7xwcxIoSH2418vZQ4wYz/uF29OacZPz5
 4jkf9ubPlQdJsjxxk4ZllH5K79u4EdDuukzZsfAnNTt5LPngnIAtbTQQUvCWx00hjjCj
 aPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711628488; x=1712233288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bkVOahQLydHEod93fC0SSmcRUZmoYjI/cICd23zyl14=;
 b=nYWmNxNNQg4RHFBiAYZ4AVztyzxg+Ja5uopZ2g+Q3fb05hUGjAVrkafhEESp/a2Syp
 Uh5V/NgQscgiyZFiseswq6tm8srXEY473alNO6qBPSg9xoja3VbsHDjThAwXzAvva94p
 lmojotaNP2X/kCK5tBJeUXXI7P/s2yvy3ykFezSHumlqDr/aJT3kwY+p/mhErBfd+K+q
 k+TrqsfktwqAjjWplG03ipDSpemvmi+qTB6qyr8THe3zr/948GI1zv25O2zSf+pXm9iP
 v6k4FUgrvcfcg00qS4XwItoGMbzjIAre9wyoDqguXyZB0pCNMO2XS7GS7riCQBx2tAS7
 cvmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6Vv5acZfd9AG0kApgUXcKBsgId0mjw1Nk6qaTDiF7rLSolyK/PzFGiN8IIb1ki2GqW1XXhYnWuL8OWgBl/LXuoOFnFg==
X-Gm-Message-State: AOJu0YwwP7r7EpSwe7017PqNTrnMvyCBTi3qgfGcZ5cKIGzUxeeX7YDy
 cjKqLpK7R9pDUIvVZ1Onpo4dbVyVcCLmzGKmMtf9TQcBvSVnATVq
X-Google-Smtp-Source: AGHT+IE5nD3MRXevESDTb+0Mf5gNdNGsl8NRiWfxnoYb8x+9Ed9Fwz6bc78PPOZSEElhlSqaJq4ADg==
X-Received: by 2002:a05:6a20:da8d:b0:1a3:4721:df94 with SMTP id
 iy13-20020a056a20da8d00b001a34721df94mr3066932pzb.0.1711628487885; 
 Thu, 28 Mar 2024 05:21:27 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:918f:1fce:e47c:7f91])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a170902e74100b001dd2bacf30asm1432184plf.162.2024.03.28.05.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 05:21:27 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: festevam@gmail.com
Cc: baruch@tkos.co.il, trini@konsulko.com, josua@solid-run.com,
 u-boot@lists.denx.de, cgmeiner@igalia.com
Subject: [PATCH] mx6cuboxi: Fix Ethernet after DT sync with Linux
Date: Thu, 28 Mar 2024 09:21:16 -0300
Message-Id: <20240328122116.2460855-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Josua Mayer <josua@solid-run.com>

The i.MX6 Cubox-i and HummingBoards can have different PHYs at varying
addresses. U-Boot needs to auto-detect which phy is actually present,
and at which address it is responding.

Auto-detection from multiple phy nodes specified in device-tree does not
currently work correct. As a work-around merge all three possible phys
into one node with the special address 0xffffffff which indicates to the
generic phy driver to probe all addresses.
Also fixup this fake address before booting Linux, *if* booting with
U-Boot's internal dtb.

Signed-off-by: Josua Mayer <josua@solid-run.com>
[fabio: Added the changes to imx6qdl-sr-som-u-boot.dtsi.]
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Tested-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 ...qdl-hummingboard2-emmc-som-v15-u-boot.dtsi |  1 +
 arch/arm/dts/imx6qdl-sr-som-u-boot.dtsi       | 40 +++++++++++++++++++
 board/solidrun/mx6cuboxi/mx6cuboxi.c          |  8 +++-
 3 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/imx6qdl-sr-som-u-boot.dtsi

diff --git a/arch/arm/dts/imx6qdl-hummingboard2-emmc-som-v15-u-boot.dtsi b/arch/arm/dts/imx6qdl-hummingboard2-emmc-som-v15-u-boot.dtsi
index e9b188ed6587..358cf8abc4ff 100644
--- a/arch/arm/dts/imx6qdl-hummingboard2-emmc-som-v15-u-boot.dtsi
+++ b/arch/arm/dts/imx6qdl-hummingboard2-emmc-som-v15-u-boot.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include "imx6qdl-u-boot.dtsi"
+#include "imx6qdl-sr-som-u-boot.dtsi"
 
 / {
 	board-detect {
diff --git a/arch/arm/dts/imx6qdl-sr-som-u-boot.dtsi b/arch/arm/dts/imx6qdl-sr-som-u-boot.dtsi
new file mode 100644
index 000000000000..4c5f043ea92a
--- /dev/null
+++ b/arch/arm/dts/imx6qdl-sr-som-u-boot.dtsi
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+#include <dt-bindings/gpio/gpio.h>
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_microsom_enet_ar8035>;
+	phy-handle = <&phy>;
+	phy-mode = "rgmii-id";
+
+	/*
+	 * The PHY seems to require a long-enough reset duration to avoid
+	 * some rare issues where the PHY gets stuck in an inconsistent and
+	 * non-functional state at boot-up. 10ms proved to be fine .
+	 */
+	phy-reset-duration = <10>;
+	phy-reset-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/delete-node/ ethernet-phy@1;
+		/delete-node/ ethernet-phy@4;
+
+		phy: ethernet-phy@0 {
+			/*
+			 * The PHY can appear either:
+			 * - AR8035: at address 0 or 4
+			 * - ADIN1300: at address 1
+			 * Actual address being detected at runtime.
+			 */
+			reg = <0xffffffff>;
+			qca,clk-out-frequency = <125000000>;
+			qca,smarteee-tw-us-1g = <24>;
+			adi,phy-output-clock = "125mhz-free-running";
+		};
+	};
+};
diff --git a/board/solidrun/mx6cuboxi/mx6cuboxi.c b/board/solidrun/mx6cuboxi/mx6cuboxi.c
index 8edabf4404c2..fbab39e800a6 100644
--- a/board/solidrun/mx6cuboxi/mx6cuboxi.c
+++ b/board/solidrun/mx6cuboxi/mx6cuboxi.c
@@ -447,7 +447,7 @@ static int find_ethernet_phy(void)
  */
 int ft_board_setup(void *fdt, struct bd_info *bd)
 {
-	int node_phy0, node_phy1, node_phy4;
+	int node_phy, node_phy0, node_phy1, node_phy4;
 	int ret, phy;
 	bool enable_phy0 = false, enable_phy1 = false, enable_phy4 = false;
 	enum board_type board;
@@ -479,6 +479,12 @@ int ft_board_setup(void *fdt, struct bd_info *bd)
 		return 0;
 	}
 
+	// update U-Boot's own unified phy node phy address, if present
+	node_phy = fdt_path_offset(fdt, "/soc/bus@2100000/ethernet@2188000/mdio/phy");
+	ret = fdt_setprop_u32(fdt, node_phy, "reg", phy);
+	if (ret < 0)
+		pr_err("%s: failed to update unified PHY node address\n", __func__);
+
 	// update all phy nodes status
 	node_phy0 = fdt_path_offset(fdt, "/soc/bus@2100000/ethernet@2188000/mdio/ethernet-phy@0");
 	ret = fdt_setprop_string(fdt, node_phy0, "status", enable_phy0 ? "okay" : "disabled");
-- 
2.34.1

