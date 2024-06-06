Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CE0C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 13:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B8D788266;
	Thu,  6 Jun 2024 15:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717678962;
	bh=23z1ORnaf1u25zvpf1Q3SGg8/rIdTwrB9Zrzf75ZDF0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mYo/h3PHyhQaeRXPIyenzuHECOQs6DDoS7Nkk7TsSBpCV+6iMZxJSsCAsxyitmSzG
	 lP7k1BrZtKJelW8SqPd4GRJwdZLmrk75d4NLH77570KKGdne4ycaOQCsBJByW1nJaN
	 2ZvqnIuMHB2WP/np8k8dFHX6waftcAxM0WFLvv6vDU+aj1aDYTh2qYwcrKHauWhITn
	 D+SijyCEYV7Orm+sCkmtjuBlAtTbqiHPiRWbbSbjnY1GXrsQ/zOyBWmLtYKlYyShi6
	 CYFWJOZ3Y/bLpt9H5DDv6H/a4YWNfcmG052PSzV9cgOnYxh49jXEht3w+q7nssOEXS
	 75W+8btyS9prw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0CE8387666;
 Thu,  6 Jun 2024 15:02:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1717678960;
 bh=23z1ORnaf1u25zvpf1Q3SGg8/rIdTwrB9Zrzf75ZDF0=;
 h=From:To:Cc:Subject:Date:From;
 b=gas3ImJsdLjNvTAxHFrhObIcVuPG+haz0mET8W4WupAp3gx6M1nBfvElp+99p5l40
 146+4kGg1n9HMqXB4bEzgJP/oyZHdKGxg5gYaGqOO1WfEXjU0eH6LndCWGNNprGUHJ
 Ap6Rw6mxQgIKhe3gsg5EUq6/2GUEOIcMkri0CKf4JPmz2xCMK5M/kW/LERSuGSuThH
 +J9gYj/5Yzi1PJ04ivZUbSPUYBjYsejTmsAs/W29A1aPNOY1II0TypGtfZGlXOC/ld
 WkzhYvDagC1Vt1hj4/H4dlu5j1v/tjOfcSc+xCOqrxc5GUhwhZ9RK7n6e0JMqoqcqJ
 sKE2asxKamqQw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: Auto-detect second MAC on STM32MP15xx DH
 electronics DHCOM
Date: Thu,  6 Jun 2024 15:01:48 +0200
Message-ID: <20240606130222.24530-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Test whether this system is compatible with STM32MP15xx DHCOM SoM,
if so, test whether R292 pull up is populated on pin PC3, which is
an indication that the second MAC chip, KS8851-16MLL, is populated.
Use this information to patch 'status' DT property into the second
ethernet MAC DT node and enable/disable the MAC on systems where
the chip is/isn't populated respectively.

Use spl_perform_fixups() to patch the U-Boot proper DT from SPL and
ft_board_setup() to patch Linux DT from U-Boot proper. This way both
software components are configured the same way.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi |  1 +
 board/dhelectronics/dh_stm32mp1/board.c    | 65 ++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi b/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
index 1b445619325..d7b78cdcfa9 100644
--- a/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
@@ -26,6 +26,7 @@
 		u-boot,error-led = "error";
 		dh,som-coding-gpios = <&gpiof 12 0>, <&gpiof 13 0>, <&gpiof 15 0>;
 		dh,ddr3-coding-gpios = <&gpioz 6 0>, <&gpioz 7 0>;
+		dh,mac-coding-gpios = <&gpioc 3 0>;
 	};
 };
 
diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
index 20c9d70737e..ebd45f9053f 100644
--- a/board/dhelectronics/dh_stm32mp1/board.c
+++ b/board/dhelectronics/dh_stm32mp1/board.c
@@ -37,6 +37,7 @@
 #include <power/regulator.h>
 #include <remoteproc.h>
 #include <reset.h>
+#include <spl.h>
 #include <syscon.h>
 #include <usb.h>
 #include <usb/dwc2_udc.h>
@@ -672,12 +673,69 @@ void board_quiesce_devices(void)
 #endif
 }
 
+static void dh_stm32_ks8851_fixup(void *blob)
+{
+	struct gpio_desc ks8851intrn;
+	bool compatible = false;
+	int ks8851intrn_value;
+	const char *prop;
+	ofnode node;
+	int idx = 0;
+	int offset;
+	int ret;
+
+	/* Do nothing if not STM32MP15xx DHCOM SoM */
+	while ((prop = fdt_stringlist_get(blob, 0, "compatible", idx++, NULL))) {
+		if (!strstr(prop, "dhcom-som"))
+			continue;
+		compatible = true;
+		break;
+	}
+
+	if (!compatible)
+		return;
+
+	/*
+	 * Read state of INTRN pull up resistor, if this pull up is populated,
+	 * KS8851-16MLL is populated as well and should be enabled, otherwise
+	 * it should be disabled.
+	 */
+	node = ofnode_path("/config");
+	if (!ofnode_valid(node))
+		return;
+
+	ret = gpio_request_by_name_nodev(node, "dh,mac-coding-gpios", 0,
+					 &ks8851intrn, GPIOD_IS_IN);
+	if (ret)
+		return;
+
+	ks8851intrn_value = dm_gpio_get_value(&ks8851intrn);
+
+	dm_gpio_free(NULL, &ks8851intrn);
+
+	/* Set the 'status' property into KS8851-16MLL DT node. */
+	offset = fdt_path_offset(blob, "ethernet1");
+	ret = fdt_node_check_compatible(blob, offset, "micrel,ks8851-mll");
+	if (ret)	/* Not compatible */
+		return;
+
+	/* Add a bit of extra space for new 'status' property */
+	ret = fdt_shrink_to_minimum(blob, 4096);
+	if (!ret)
+		return;
+
+	fdt_setprop_string(blob, offset, "status",
+			   ks8851intrn_value ? "okay" : "disabled");
+}
+
 #if defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	const char *buck3path = "/soc/i2c@5c002000/stpmic@33/regulators/buck3";
 	int buck3off, ret, uv;
 
+	dh_stm32_ks8851_fixup(blob);
+
 	ret = board_get_regulator_buck3_nvm_uv_av96(&uv);
 	if (ret)	/* Not Avenger96 board, do not patch Buck3 in DT. */
 		return 0;
@@ -698,6 +756,13 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 }
 #endif
 
+#if defined(CONFIG_SPL_BUILD)
+void spl_perform_fixups(struct spl_image_info *spl_image)
+{
+	dh_stm32_ks8851_fixup(spl_image_fdt_addr(spl_image));
+}
+#endif
+
 static void board_copro_image_process(ulong fw_image, size_t fw_size)
 {
 	int ret, id = 0; /* Copro id fixed to 0 as only one coproc on mp1 */
-- 
2.43.0

