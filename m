Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD2FCCF9E3
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 15:15:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2922C88BD2;
	Wed, 25 Sep 2024 17:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Mn1so5M7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BE9788B5F; Wed, 25 Sep 2024 17:14:24 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0290588BD2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 17:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48PFE14F102765;
 Wed, 25 Sep 2024 10:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1727277241;
 bh=I75++hoxomkw9nvhi5KogYtWG4b2mbBUdzn9J7HHuks=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Mn1so5M7SgXD2znIvNNZ8YFqr4OTKRAGvab+L2t+X5s2fjyNAwMPVVKYyaDmd+9PY
 yXHPeWj3hiEn/IweuWK4LJKHs5HWAQcg2Ae1FNbSfmplHu/w7I/0YnTnlvGzvHcfrx
 11iY7JRVgNSWsremOSkt2qLON5dB0XLUQektXTTw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48PFE05g103161
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 25 Sep 2024 10:14:00 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 25
 Sep 2024 10:14:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 25 Sep 2024 10:14:00 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48PFDxJS017947;
 Wed, 25 Sep 2024 10:13:59 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <bb@ti.com>
CC: <sjg@chromium.org>, <agust@denx.de>, <praneeth@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <s-jain1@ti.com>, <r-donadkar@ti.com>,
 <j-humphreys@ti.com>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <akashi.tkhro@gmail.com>,
 <mkorpershoek@baylibre.com>, <eajames@linux.ibm.com>,
 <caleb.connolly@linaro.org>, <quentin.schulz@cherry.de>,
 <martinstolpe@gmail.com>, <iivanov@suse.de>, <n-jain1@ti.com>,
 <devarsht@ti.com>
Subject: [PATCH 3/3] board: ti: am62x: evm: Update simple-framebuffer node in
 device-tree
Date: Wed, 25 Sep 2024 20:43:54 +0530
Message-ID: <20240925151354.480704-4-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240925151354.480704-1-devarsht@ti.com>
References: <20240925151354.480704-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Update simple-framebuffer device-tree node by enumerating framebuffer
related information in existing simple-framebuffer node in Linux
device-tree file and enabling it.

In case there is no simple-framebuffer stub detected in Linux kernel
device-tree and video is still active, then update the device-tree to
reserve the framebuffer region for the active splash screen.

This helps preserve the splash screen till the display server takes over
after OS is booted.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 board/ti/am62x/evm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index 9bdd0223cdb6..be0447f6e9ea 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -16,6 +16,7 @@
 #include <cpu_func.h>
 #include <k3-ddrss.h>
 #include <fdt_support.h>
+#include <fdt_simplefb.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <dm/uclass.h>
@@ -162,3 +163,23 @@ void spl_perform_fixups(struct spl_image_info *spl_image)
 #endif
 }
 #endif
+
+#if defined(CONFIG_OF_BOARD_SETUP)
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	int ret = -1;
+
+	if (IS_ENABLED(CONFIG_FDT_SIMPLEFB))
+		ret = fdt_simplefb_enable_and_mem_rsv(blob);
+
+	/* If simplefb is not enabled and video is active, then at least reserve
+	 * the framebuffer region to preserve the splash screen while OS is booting
+	 */
+	if (IS_ENABLED(CONFIG_VIDEO) && IS_ENABLED(CONFIG_OF_LIBFDT)) {
+		if (ret && video_is_active())
+			return fdt_add_fb_mem_rsv(blob);
+	}
+
+	return 0;
+}
+#endif
-- 
2.39.1

