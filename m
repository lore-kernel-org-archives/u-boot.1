Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94051C48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 13:10:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2646F880CC;
	Thu, 22 Feb 2024 14:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hGxxCYPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BAAC88087; Thu, 22 Feb 2024 14:08:36 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FEED880AE
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 14:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MD8KZA047005;
 Thu, 22 Feb 2024 07:08:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708607300;
 bh=TnHBW84XqgAfyZEpL+X0QNVYQSxvMKldLy2mVDGyUps=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=hGxxCYPAhHALoumhuZrAr1TKh43r9EHdr0UY0z9JhMW5/3jKoTccdGesDHpwFrALF
 YmQZNUyAuuhimIMZakPiltT/+L3UyOiPdXm/KuPmZ6AVqLVoQxUwbRIKeyF27EsfD4
 Fks1MvbisYipqJu7dXHoJKtJD0SAdUHTFQu0Jg3o=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MD8KEb007129
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Feb 2024 07:08:20 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 07:08:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 07:08:20 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MD8JJe081917;
 Thu, 22 Feb 2024 07:08:19 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>
CC: <bmeng@tinylab.org>, <xypron.glpk@gmx.de>, <patrick.delaunay@foss.st.com>, 
 <patrice.chotard@foss.st.com>, <hvilleneuve@dimonoff.com>,
 <michal.simek@amd.com>, <troykiskyboundary@gmail.com>,
 <j-humphreys@ti.com>, <afd@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
 <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH 4/4] board: ti: am62x: evm: Update simple-framebuffer node in
 device-tree
Date: Thu, 22 Feb 2024 18:38:11 +0530
Message-ID: <20240222130811.3878567-5-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222130811.3878567-1-devarsht@ti.com>
References: <20240222130811.3878567-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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
 board/ti/am62x/evm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index 88e02155ee..c825af3368 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -15,6 +15,7 @@
 #include <cpu_func.h>
 #include <k3-ddrss.h>
 #include <fdt_support.h>
+#include <fdt_simplefb.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <dm/uclass.h>
@@ -118,3 +119,21 @@ void spl_perform_fixups(struct spl_image_info *spl_image)
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
+	if (ret && video_is_active())
+		return fdt_add_fb_mem_rsv(blob);
+
+	return 0;
+}
+#endif
-- 
2.34.1

