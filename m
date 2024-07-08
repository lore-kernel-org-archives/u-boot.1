Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9426C3DA42
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 06:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87A2988570;
	Mon,  8 Jul 2024 08:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="bilUQ/+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0304388570; Mon,  8 Jul 2024 08:08:03 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C37F8884C6
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 08:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720418880; x=1723010880;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bZgInon94T0BRYt52ODwYnH36bnCShGDMjJgK6Dsh+4=;
 b=bilUQ/+2017vmjTpbbr3hvpm1bD0eUHG/2GEkb9BVrQqAwl+MTt+nwxbDFt57lSS
 77Nd3zmVMYcnTzS/+pfV48u0W8QLJ2Jfct386+2vROisy/+IPsc5k8SiOadpHZAh
 ophc2SLIk8fvc4U5VnApFzgNbzq4YZH/nQUqP6n4K5Q=;
X-AuditID: ac14000a-03251700000021bc-54-668b8240f60f
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 90.21.08636.0428B866;
 Mon,  8 Jul 2024 08:08:00 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 8 Jul 2024
 08:07:56 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <w.egorov@phytec.de>
CC: <d-gole@ti.com>, <nm@ti.com>, <mkorpershoek@baylibre.com>,
 <upstream@lists.phytec.de>, <t.remmet@phytec.de>, <y.moog@phytec.de>,
 <m-chawdhry@ti.com>, <kamlesh@ti.com>, <jm@ti.com>, <B.Hahn@phytec.de>,
 Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 3/6] board: phytec: common: k3: Add SOM detection overlays
Date: Sun, 7 Jul 2024 23:07:31 -0700
Message-ID: <20240708060734.4029040-4-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240708060734.4029040-1-d.schultz@phytec.de>
References: <20240708060734.4029040-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWyRpKBR9ehqTvNYPNEZYuWtR4Wnz5kWnza
 +ZjV4mj/GmaLSw9SLV4cm8tu8ebHWSaLqZM2s1u83dvJbtH9Tt2By+P9jVZ2j1cHVrF7nL2z
 g9Gjv7uF1eP6me1MHsdvbGcKYIvisklJzcksSy3St0vgymjb3cJYcJS/YvnzRsYGxl88XYyc
 HBICJhL9Z78wdzFycQgJLGGS6Jv5iQnCuccoMbPpMzNIFZuAlsSdLXPBbBGBJIllFztZQYqY
 Bb4zSrz4+IsVJCEs4CVxc+JfJhCbRUBFYuKvbjCbV8BKoq13IhPEOnmJmZe+s4PYnALWEo+m
 dbKA2EJANXMnb2CDqBeUODnzCVicGai+eetsZghbQuLgixfMEPUKErO3TWaEmTnt3GtmCDtU
 4sim1UwTGIVmIRk1C8moWUhGLWBkXsUolJuZnJ1alJmtV5BRWZKarJeSuokRFDUiDFw7GPvm
 eBxiZOJgPMQowcGsJMJ7+nF7mhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe1R3BqUIC6Yklqdmp
 qQWpRTBZJg5OqQbG0KXRv3uV/92bmGF1RlyhxOf1lC0tbu8O/GxkTTGuynbnfSVs265daPJS
 V6claOXHzykyx8++1YldeuqFWvFfodeb3Gebz6xr+iXy6HjH0TmfCjsWvn939fK/JgV/5Rjb
 r7c+n7LSLjjXEO2o8UU35pzPCwG/Q484/qeHBmm9l9+966HGl40/lViKMxINtZiLihMB1Alu
 64gCAAA=
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

Add overlays to disable or alter SOM features according
to the EEPROM image content.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/k3/board.c | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index 3d7e090ccaa..867dd880675 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -8,6 +8,7 @@
 #include <fdt_support.h>
 #include <spl.h>
 #include <asm/arch/hardware.h>
+#include <extension_board.h>
 
 #include "../am6_som_detection.h"
 
@@ -104,3 +105,47 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	return 0;
 }
 #endif
+
+#if IS_ENABLED(CONFIG_CMD_EXTENSION)
+int extension_board_scan(struct list_head *extension_list)
+{
+	struct extension *extension = NULL;
+	struct phytec_eeprom_data data;
+	int count = 0;
+	int ret;
+
+	ret = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
+	if (ret)
+		return count;
+
+	if (phytec_get_am6_eth(&data) == 0) {
+		extension = phytec_add_extension("Disable Ethernet phy",
+						 "k3-am6xx-phycore-disable-eth-phy.dtbo", "");
+		list_add_tail(&extension->list, extension_list);
+		count++;
+	}
+
+	if (phytec_get_am6_spi(&data) == PHYTEC_EEPROM_VALUE_X) {
+		extension = phytec_add_extension("Disable SPI NOR Flash",
+						 "k3-am6xx-phycore-disable-spi-nor.dtbo", "");
+		list_add_tail(&extension->list, extension_list);
+		count++;
+	}
+
+	if (phytec_am6_is_qspi(&data)) {
+		extension = phytec_add_extension("Select QSPI NOR Flash",
+						 "k3-am6xx-phycore-qspi-nor.dtbo", "");
+		list_add_tail(&extension->list, extension_list);
+		count++;
+	}
+
+	if (phytec_get_am6_rtc(&data) == 0) {
+		extension = phytec_add_extension("Disable RTC",
+						 "k3-am6xx-phycore-disable-rtc.dtbo", "");
+		list_add_tail(&extension->list, extension_list);
+		count++;
+	}
+
+	return count;
+}
+#endif
-- 
2.25.1

