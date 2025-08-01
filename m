Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCBDC87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 12:42:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B05483A8E;
	Fri,  1 Aug 2025 14:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="jKvBi5t9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB1B8839F1; Fri,  1 Aug 2025 14:32:52 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5B1183A8A
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 14:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=301ae58c2=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1754051567; x=1785587567;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kx8kNwx50mzZuVmNUwp+TF0uCfY5EsOC+RoWKAAY3Ac=;
 b=jKvBi5t9wABir9ub3rHkmcLDyEZqK6wU8YzZA8oNry249K2IMAklfHWJ
 cgyLkU2I1uuOfQkW8pOFqeL+NvHgZFY3aYYVooLU7krHKGhxPXl/h3jEA
 hSeTA8XJYolBuYnzhfvmiTDRxMF3+sSG1MQydYkG1jfbpExpQ1qcamKqr
 NrybOSvbID0ww2qpxN4l35zL9VRqraB9jaTFMb1wGGZjjO5GlNHbGzjMg
 6PqeRMr7m2xihiN9BpZhbmI5hLD5NRljbL9gVUJxDdAdZotqsO1bf8lpL
 5TObDVllwrIGSrIgPsQsld9QsD9zQ8+POzgjbZjhkyNI0W4LNcKfHQSq1 w==;
X-CSE-ConnectionGUID: MeqoYqJ8TL+1crWCDCcF1g==
X-CSE-MsgGUID: 7GEdOq/rRayYs6qEs2wqqQ==
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; d="scan'208";a="44692470"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Aug 2025 05:32:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 1 Aug 2025 05:32:34 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 1 Aug 2025 05:32:32 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Cyril Jean
 <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 2/6] board: microchip: mpfs_icicle: make use of
 ft_board_setup()
Date: Fri, 1 Aug 2025 13:36:22 +0100
Message-ID: <20250801123626.1972658-3-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801123626.1972658-1-jamie.gibbons@microchip.com>
References: <20250801123626.1972658-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 01 Aug 2025 14:41:57 +0200
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

Move ethernet mac address setting to ft_board_setup() to remove the need
for fdt set in custom boot script.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 board/microchip/mpfs_icicle/mpfs_icicle.c | 51 ++++++++++++-----------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/microchip/mpfs_icicle/mpfs_icicle.c
index ba622e38ee5..19acbbba42b 100644
--- a/board/microchip/mpfs_icicle/mpfs_icicle.c
+++ b/board/microchip/mpfs_icicle/mpfs_icicle.c
@@ -22,6 +22,8 @@ DECLARE_GLOBAL_DATA_PTR;
 #define SERVICE_CR_REQ			0x1u
 #define SERVICE_SR_BUSY			0x2u
 
+static unsigned char mac_addr[6];
+
 static void read_device_serial_number(u8 *response, u8 response_size)
 {
 	u8 idx;
@@ -145,10 +147,7 @@ int board_late_init(void)
 {
 	u32 ret;
 	int node;
-	u8 idx;
-	u8 device_serial_number[16] = { 0 };
-	unsigned char mac_addr[6];
-	char icicle_mac_addr[20];
+	u8 device_serial_number[16] = {0};
 	void *blob = (void *)gd->fdt_blob;
 
 	read_device_serial_number(device_serial_number, 16);
@@ -170,19 +169,6 @@ int board_late_init(void)
 		}
 	}
 
-	icicle_mac_addr[0] = '[';
-
-	sprintf(&icicle_mac_addr[1], "%pM", mac_addr);
-
-	icicle_mac_addr[18] = ']';
-	icicle_mac_addr[19] = '\0';
-
-	for (idx = 0; idx < 20; idx++) {
-		if (icicle_mac_addr[idx] == ':')
-			icicle_mac_addr[idx] = ' ';
-	}
-	env_set("icicle_mac_addr0", icicle_mac_addr);
-
 	mac_addr[5] = device_serial_number[0] + 1;
 
 	node = fdt_path_offset(blob, "/soc/ethernet@20110000");
@@ -194,18 +180,33 @@ int board_late_init(void)
 		}
 	}
 
-	icicle_mac_addr[0] = '[';
+	return 0;
+}
 
-	sprintf(&icicle_mac_addr[1], "%pM", mac_addr);
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	u32 ret;
+	int node;
+
+	node = fdt_path_offset(blob, "/soc/ethernet@20110000");
+	if (node >= 0) {
+		ret = fdt_setprop(blob, node, "local-mac-address", mac_addr, 6);
+		if (ret) {
+			printf("Error setting local-mac-address property for ethernet@20110000\n");
+			return -ENODEV;
+		}
+	}
 
-	icicle_mac_addr[18] = ']';
-	icicle_mac_addr[19] = '\0';
+	mac_addr[5] -= 1;
 
-	for (idx = 0; idx < 20; idx++) {
-		if (icicle_mac_addr[idx] == ':')
-			icicle_mac_addr[idx] = ' ';
+	node = fdt_path_offset(blob, "/soc/ethernet@20112000");
+	if (node >= 0) {
+		ret = fdt_setprop(blob, node, "local-mac-address", mac_addr, 6);
+		if (ret) {
+			printf("Error setting local-mac-address property for ethernet@20112000\n");
+			return -ENODEV;
+		}
 	}
-	env_set("icicle_mac_addr1", icicle_mac_addr);
 
 	return 0;
 }
-- 
2.43.0

