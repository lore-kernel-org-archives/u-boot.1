Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C79C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 11:23:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B14D807D6;
	Mon, 10 Feb 2025 12:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U+GKbuf6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 448C780B98; Mon, 10 Feb 2025 12:23:11 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85ED2805C2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51ABMxWm115989
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Feb 2025 05:22:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739186579;
 bh=lmR7c+TZ0itlopBlytPWg4buKAr11h9iaCc8wbEwNQM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=U+GKbuf62lqG3e5CW8TmVM4qGeWWwq4Ee0bzpU4z+1yV6VRmTzeFAAbOs6ckfP0HP
 j3j7sqbRq8zzQFBdshMvQh4YLzyhsyOBTi7OOYvY4qEs8S5vAtmKHA+NkaDjalogF5
 rrmj39O9lCu3nMXonVSIisX5q9K8MVcV/sT6N3Jo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51ABMxYK025368
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Feb 2025 05:22:59 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Feb 2025 05:22:59 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Feb 2025 05:22:58 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51ABMdb4047041; 
 Mon, 10 Feb 2025 05:22:52 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>, <vaishnav.a@ti.com>, 
 <j-choudhary@ti.com>, <mkorpershoek@baylibre.com>, <rogerq@kernel.org>,
 <hnagalla@ti.com>, <glaroque@baylibre.com>, <nm@ti.com>,
 <n-francis@ti.com>, <m-chawdhry@ti.com>, <jm@ti.com>,
 <devarsht@ti.com>, <sjg@chromium.org>, <afd@ti.com>,
 <j-humphreys@ti.com>, <quentin.schulz@cherry.de>,
 <sjoerd@collabora.com>, <martyn.welch@collabora.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 2/7] board: ti: am62px: env: include environment for DFU
 Boot
Date: Mon, 10 Feb 2025 16:52:25 +0530
Message-ID: <20250210112239.2639009-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250210112239.2639009-1-s-vadapalli@ti.com>
References: <20250210112239.2639009-1-s-vadapalli@ti.com>
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

Include the TI K3 DFU environment to support DFU Boot and DFU Flash.
Also add "usb" to the list of "boot_targets". While at it, add a newline
at the end of the file.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---

v3:
https://patchwork.ozlabs.org/project/uboot/cover/20241221025229.361625-1-s-vadapalli@ti.com/

Changes since v3:
- Collected Reviewed-by tags.

Regards,
Siddharth.

 board/ti/am62px/am62px.env | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/board/ti/am62px/am62px.env b/board/ti/am62px/am62px.env
index 7ef54079aa..e0838196e3 100644
--- a/board/ti/am62px/am62px.env
+++ b/board/ti/am62px/am62px.env
@@ -1,5 +1,6 @@
 #include <env/ti/ti_common.env>
 #include <env/ti/mmc.env>
+#include <env/ti/k3_dfu.env>
 
 name_kern=Image
 console=ttyS2,115200n8
@@ -7,7 +8,7 @@ args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
 	${mtdparts}
 run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
 
-boot_targets=mmc1 mmc0 pxe dhcp
+boot_targets=mmc1 mmc0 usb pxe dhcp
 boot=mmc
 mmcdev=1
 bootpart=1:2
@@ -17,4 +18,4 @@ rd_spec=-
 #if CONFIG_BOOTMETH_ANDROID
 #include <env/ti/android.env>
 adtb_idx=3
-#endif
\ No newline at end of file
+#endif
-- 
2.43.0

