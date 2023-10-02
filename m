Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F45FE748FC
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 17:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35242871B9;
	Mon,  2 Oct 2023 19:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="G6XnvTIG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ADDD86940; Mon,  2 Oct 2023 18:59:17 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 531F58712A
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 18:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 525D8120007;
 Mon,  2 Oct 2023 19:59:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 525D8120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1696265951;
 bh=f/z1DcuYBfjZ2kNEpnuYXXkIZllyCQtrwgIaVz+WtuY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=G6XnvTIGHoInjd66MKPsQw5iNG1fyjCwfyf2vHwaRsUQSnLqOIe22pdtsOmIk37C+
 oYXuhsuVJVKxn2BthtFL7DvxWPMmYm5XaiHncZOPkxUDV6+VHTGuXtN5luBJxkL9eA
 um8IknlzS6bPqTp/dZh9Z/WdnlERY87l+dZQBy2Bc9Zricsxycppp+gEpc5DZA9uO4
 VjRf/KIrkN9yne42d7HGJvta1iJEyWzCb3pCd2HXzkctAgnG5so2vOVBgVP84fkTu9
 9jFrDzN8pjcp386Jn8Rg8PpBa3LQzybz8ak306VG3QpcwYiaFi8W3WcGeeWTjfH/m0
 htZ0GFO9KpMow==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon,  2 Oct 2023 19:59:11 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 2 Oct 2023 19:59:10 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>, <sjg@google.com>, 
 <lukma@denx.de>, <seanga2@gmail.com>, <marex@denx.de>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 8/8] arch: a1: introduce USB initialization functionality
Date: Mon, 2 Oct 2023 19:58:52 +0300
Message-ID: <20231002165857.19512-9-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002165857.19512-1-avromanov@salutedevices.com>
References: <20231002165857.19512-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180290 [Oct 02 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535
 da804c0ea8918f802fc60e7a20ba49783d957ba2,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1; 100.64.160.123:7.1.2;
 127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/10/02 12:04:00 #22024008
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Mon, 02 Oct 2023 19:34:08 +0200
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

This is entrypoint for USB stack initialization. Function
board_usb_init will be called from cmd/fastboot.c code.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 arch/arm/mach-meson/board-a1.c | 89 ++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm/mach-meson/board-a1.c b/arch/arm/mach-meson/board-a1.c
index 967bb67182..781d5cfb33 100644
--- a/arch/arm/mach-meson/board-a1.c
+++ b/arch/arm/mach-meson/board-a1.c
@@ -4,12 +4,17 @@
  */
 
 #include <common.h>
+#include <dm.h>
+#include <usb.h>
 #include <asm/arch/a1.h>
 #include <asm/arch/boot.h>
 #include <asm/armv8/mmu.h>
 #include <asm/io.h>
 #include <linux/compiler.h>
 #include <linux/sizes.h>
+#include <linux/usb/otg.h>
+#include <asm/arch/usb.h>
+#include <usb/dwc2_udc.h>
 
 phys_size_t get_effective_memsize(void)
 {
@@ -57,3 +62,87 @@ static struct mm_region a1_mem_map[] = {
 };
 
 struct mm_region *mem_map = a1_mem_map;
+
+#if CONFIG_IS_ENABLED(USB_DWC3_MESON_G12A) && \
+	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
+
+static struct dwc2_plat_otg_data meson_a1_dwc2_data;
+
+int board_usb_init(int index, enum usb_init_type init)
+{
+	int node, dwc2_node;
+	const void *blob = gd->fdt_blob;
+	struct udevice *dev;
+	int ret;
+
+	node = fdt_node_offset_by_compatible(blob, -1,
+					     "amlogic,meson-a1-usb-ctrl");
+	if (node < 0) {
+		pr_err("not found usb-control node\n");
+		return -ENODEV;
+	}
+
+	if (!fdtdec_get_is_enabled(blob, node)) {
+		pr_err("usb is disabled in the device tree\n");
+		return -ENODEV;
+	}
+
+	ret = uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS, node, &dev);
+	if (ret) {
+		pr_err("not found usb-control device\n");
+		return ret;
+	}
+
+	dwc2_node = fdt_node_offset_by_compatible(blob, node,
+						  "amlogic,meson-a1-usb");
+	if (dwc2_node < 0) {
+		pr_err("not found dwc2 node\n");
+		return -ENODEV;
+	}
+
+	if (!fdtdec_get_is_enabled(blob, dwc2_node)) {
+		pr_err("dwc2 is disabled in the device tree\n");
+		return -ENODEV;
+	}
+
+	meson_a1_dwc2_data.regs_otg = fdtdec_get_addr(blob, dwc2_node, "reg");
+	if (meson_a1_dwc2_data.regs_otg == FDT_ADDR_T_NONE) {
+		pr_err("can't get base address\n");
+		return -ENODATA;
+	}
+
+	meson_a1_dwc2_data.rx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
+						"g-rx-fifo-size", 0);
+	if (meson_a1_dwc2_data.rx_fifo_sz < 0) {
+		pr_err("failed to get g-rx-fifo-size value\n");
+		return -ENODATA;
+	}
+
+	meson_a1_dwc2_data.np_tx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
+						"g-np-tx-fifo-size", 0);
+	if (meson_a1_dwc2_data.np_tx_fifo_sz < 0) {
+		pr_err("failed to get g-np-tx-fifo-size value\n");
+		return -ENODATA;
+	}
+
+	meson_a1_dwc2_data.tx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
+						"g-tx-fifo-size", 0);
+	if (meson_a1_dwc2_data.tx_fifo_sz < 0) {
+		pr_err("failed to get g-tx-fifo-size value\n");
+		return -ENODATA;
+	}
+
+	ret = dwc3_meson_g12a_force_mode(dev, USB_DR_MODE_PERIPHERAL);
+	if (ret) {
+		pr_err("failed to force usb mode to peripheral\n");
+		return ret;
+	}
+
+	return dwc2_udc_probe(&meson_a1_dwc2_data);
+}
+
+int board_usb_cleanup(int index, enum usb_init_type init)
+{
+	return 0;
+}
+#endif
-- 
2.25.1

