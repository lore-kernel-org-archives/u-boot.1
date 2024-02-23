Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FFCC48BC4
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 09:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C4CD8786A;
	Fri, 23 Feb 2024 10:14:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="A44CxXwx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9887587BF1; Fri, 23 Feb 2024 10:13:23 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 580A88792D
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 10:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 8F802212B4;
 Fri, 23 Feb 2024 10:11:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708679518;
 bh=hg/BqxnAJ2bS0Fr6UQ2tTLWwyJM421rtTX2XsHE34mM=; h=From:To:Subject;
 b=A44CxXwxGGa7VnAKwq58h6RxU043TT9eqUi/fk1o8bBfawRqI83HsLt8QEnnb/lIc
 1gU5VNVLcmxL17HPlF6mlud/7I+ArP3NLmxGUoF/jAe64Tx0quPE9fHeQOz5w5st+k
 oeANVlKyBJGzzI0FxDSBhMKgZexF0x4c1yciTRVJzigEkKiULN7st6BngfuXVNnsTt
 TuLc2XKlvXAp3rZUUlH3+NUWGia6xUaHtumS9sevA/V50ZEXaNMOszZpo0n41HTksH
 Z9EsZY2bIojtBix+opxkbP49OZNfMFoc62eIym0LwlCSJRqjeuoikuVvy28ZXu3YJ9
 tiqPqiV9DjUbA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 3/7] toradex: common: Use SETTINGS_R event to read toradex
 config block
Date: Fri, 23 Feb 2024 10:11:39 +0100
Message-Id: <20240223091143.9561-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223091143.9561-1-francesco@dolcini.it>
References: <20240223091143.9561-1-francesco@dolcini.it>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Use SETTINGS_R event to read toradex config block and checkboard()
to print board info.

Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com> # Verdin iMX8M Plus
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/common/tdx-common.c | 92 ++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 38 deletions(-)

diff --git a/board/toradex/common/tdx-common.c b/board/toradex/common/tdx-common.c
index cdf645b14177..6084436b48b4 100644
--- a/board/toradex/common/tdx-common.c
+++ b/board/toradex/common/tdx-common.c
@@ -103,54 +103,69 @@ __weak int print_bootinfo(void)
 
 int checkboard(void)
 {
-	unsigned char ethaddr[6];
-
-	if (read_tdx_cfg_block()) {
-		printf("MISSING TORADEX CONFIG BLOCK\n");
-		get_mac_from_serial(tdx_serial, &tdx_eth_addr);
-	} else {
-		snprintf(tdx_serial_str, sizeof(tdx_serial_str),
-			 "%08u", tdx_serial);
-		snprintf(tdx_board_rev_str, sizeof(tdx_board_rev_str),
-			 "V%1d.%1d%s",
-			 tdx_hw_tag.ver_major,
-			 tdx_hw_tag.ver_minor,
-			 get_board_assembly(tdx_hw_tag.ver_assembly));
-
-		env_set("serial#", tdx_serial_str);
-
+	if (valid_cfgblock) {
 		printf("Model: Toradex %04d %s %s\n",
 		       tdx_hw_tag.prodid,
 		       toradex_modules[tdx_hw_tag.prodid].name,
 		       tdx_board_rev_str);
 		printf("Serial#: %s\n", tdx_serial_str);
+	}
+
 #ifdef CONFIG_TDX_CFG_BLOCK_EXTRA
-		if (read_tdx_cfg_block_carrier()) {
-			printf("MISSING TORADEX CARRIER CONFIG BLOCKS\n");
-			try_migrate_tdx_cfg_block_carrier();
-		} else {
-			tdx_carrier_board_name =
-				get_toradex_carrier_boards(tdx_car_hw_tag.prodid);
-
-			snprintf(tdx_car_serial_str, sizeof(tdx_car_serial_str),
-				 "%08u", tdx_car_serial);
-			snprintf(tdx_car_rev_str, sizeof(tdx_car_rev_str),
-				 "V%1d.%1d%s",
-				 tdx_car_hw_tag.ver_major,
-				 tdx_car_hw_tag.ver_minor,
-				 get_board_assembly(tdx_car_hw_tag.ver_assembly));
-
-			env_set("carrier_serial#", tdx_car_serial_str);
-			printf("Carrier: Toradex %s %s, Serial# %s\n",
-			       tdx_carrier_board_name,
-			       tdx_car_rev_str,
-			       tdx_car_serial_str);
-		}
+	if (tdx_carrier_board_name)
+		printf("Carrier: Toradex %s %s, Serial# %s\n",
+		       tdx_carrier_board_name,
+		       tdx_car_rev_str,
+		       tdx_car_serial_str);
 #endif
-	}
 
 	print_bootinfo();
 
+	return 0;
+}
+
+static int settings_r(void)
+{
+	unsigned char ethaddr[6];
+
+	if (read_tdx_cfg_block()) {
+		printf("MISSING TORADEX CONFIG BLOCK\n");
+		get_mac_from_serial(tdx_serial, &tdx_eth_addr);
+
+		/* Board can run even if config block is not present */
+		return 0;
+	}
+
+	snprintf(tdx_serial_str, sizeof(tdx_serial_str),
+		 "%08u", tdx_serial);
+	snprintf(tdx_board_rev_str, sizeof(tdx_board_rev_str),
+		 "V%1d.%1d%s",
+		 tdx_hw_tag.ver_major,
+		 tdx_hw_tag.ver_minor,
+		 get_board_assembly(tdx_hw_tag.ver_assembly));
+
+	env_set("serial#", tdx_serial_str);
+
+#ifdef CONFIG_TDX_CFG_BLOCK_EXTRA
+	if (read_tdx_cfg_block_carrier()) {
+		printf("MISSING TORADEX CARRIER CONFIG BLOCKS\n");
+		try_migrate_tdx_cfg_block_carrier();
+	} else {
+		tdx_carrier_board_name =
+			get_toradex_carrier_boards(tdx_car_hw_tag.prodid);
+
+		snprintf(tdx_car_serial_str, sizeof(tdx_car_serial_str),
+			 "%08u", tdx_car_serial);
+		snprintf(tdx_car_rev_str, sizeof(tdx_car_rev_str),
+			 "V%1d.%1d%s",
+			 tdx_car_hw_tag.ver_major,
+			 tdx_car_hw_tag.ver_minor,
+			 get_board_assembly(tdx_car_hw_tag.ver_assembly));
+
+		env_set("carrier_serial#", tdx_car_serial_str);
+	}
+#endif
+
 	/*
 	 * Check if environment contains a valid MAC address,
 	 * set the one from config block if not
@@ -171,6 +186,7 @@ int checkboard(void)
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_SETTINGS_R, settings_r);
 
 #ifdef CONFIG_TDX_CFG_BLOCK_USB_GADGET_PID
 int g_dnl_bind_fixup(struct usb_device_descriptor *dev, const char *name)
-- 
2.39.2

