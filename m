Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D531C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 269A48858B;
	Mon, 10 Jun 2024 15:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="XexkEDZ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87A478853F; Mon, 10 Jun 2024 15:34:13 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06CA38852C
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718026449; x=1720618449;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YKxBhBG6E5CKLHKhX/nMmX2pra/Pjo6aq0WkQ7IYmQg=;
 b=XexkEDZ7uLqEJq7pDvY0u4peu3dWVbHee3MEZYWVfp+ksgSq/AuEc7LI0WqRTzqF
 uTOgQ21hQ5geRn31lyG0Gv6bB+niWwLoAi+JEnZ3anaE59z6RFTuKLJ+VH2ht51v
 3ls9e0xYr8RfRiqbIhpio7TfXznIB2ENZAC8Yymfa4g=;
X-AuditID: ac14000a-03251700000021bc-e6-666700d15150
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C5.7D.08636.1D007666;
 Mon, 10 Jun 2024 15:34:09 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jun
 2024 15:34:09 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <d.schultz@phytec.de>, <nmorrisson@phytec.com>
Subject: [PATCH 03/13] board: phytec: common: k3: Copy fixed partitions to OS
 device tree
Date: Mon, 10 Jun 2024 15:33:42 +0200
Message-ID: <20240610133352.2473414-4-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240610133352.2473414-1-w.egorov@phytec.de>
References: <20240610133352.2473414-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWyRpKBR/ciQ3qawaPrFhYfGjezWUydtJnd
 4u3eTnaLd337mSy636k7sHq8OrCK3ePsnR2MHv3dLawefy6+Yw1gieKySUnNySxLLdK3S+DK
 2N56jLngDlfF3e/dbA2Mczi7GDk5JARMJN6d7GfsYuTiEBJYwiRxY8oPFgjnMaPEhCf97CBV
 bALqEnc2fGMFsUUEgiR6L31iBLGZBTwktv7dABYXFoiU6N66kxnEZhFQlZjQ+Bmsl1fAUmLb
 xW8sENvkJWZe+g4W5xSwkvixZi9YrxBQzaJPa1gg6gUlTs58wgIxX16ieetsZghbQuLgixfM
 EPXyEi8uLYebOe3ca2YIO1Ri65ftTBMYhWYhGTULyahZSEYtYGRexSiUm5mcnVqUma1XkFFZ
 kpqsl5K6iREU8iIMXDsY++Z4HGJk4mA8xCjBwawkwiuUkZwmxJuSWFmVWpQfX1Sak1p8iFGa
 g0VJnHd1R3CqkEB6YklqdmpqQWoRTJaJg1OqgVFP5tXxjWL8UkdFF32w32KzeN6yQ89ivqhw
 Sk24dO7qD2MLge9twU73VabxaioysQb0+WboXX6mxtpvI9ISqig+6Vlxgf1riQ6BtmPt7nOP
 yH3UiK/kfvrJbIJMo/2vU5aBS2XsrTVVjtuGb/mvKxkwSTpdwqsxMDB+Kb/y6mBjqz0nclfu
 UmIpzkg01GIuKk4EAHn/D0RnAgAA
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

Copy fixed-partitions nodes from U-Boot device tree to OS device tree.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/common/k3/board.c      | 10 ++++++++++
 configs/phycore_am62x_a53_defconfig |  1 +
 2 files changed, 11 insertions(+)

diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index f21e154d4fe..3d7e090ccaa 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -5,6 +5,7 @@
  */
 
 #include <env_internal.h>
+#include <fdt_support.h>
 #include <spl.h>
 #include <asm/arch/hardware.h>
 
@@ -94,3 +95,12 @@ int board_late_init(void)
 	return 0;
 }
 #endif
+
+#if IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_OF_BOARD_SETUP)
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	fdt_copy_fixed_partitions(blob);
+
+	return 0;
+}
+#endif
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 7545bf2ea73..44f6e77b626 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -36,6 +36,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_SYS_BOOTM_LEN=0x800000
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run mmcboot; bootflow scan -lb"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_BOARD_LATE_INIT=y
-- 
2.34.1

