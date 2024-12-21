Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAA9E77188
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 02:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4A9A8044A;
	Sat, 21 Dec 2024 03:52:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vzlL86MU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A18C780435; Sat, 21 Dec 2024 03:52:52 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A7C680384
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 03:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BL2qecd083371;
 Fri, 20 Dec 2024 20:52:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734749560;
 bh=PXmnqVnGQR0sZpxR9aw/AmEr0IJx9cE0AOjZGD2oM1c=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=vzlL86MULOYAotMpDz2CYoDGjBSv22YO6m8Poswb57QWB9E2VRLzb8Bgxugw3EdlH
 kPefBP25JWWsIdY+0ZXI/7r07tywWttmE/CWCTzL5E1IQY7K0GtHtsLxIRDMB6ZmaQ
 GkokaRhaPSOcTk0F+D65Z/BAUIvybKSJnf3qirLM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BL2qeii030748
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 20 Dec 2024 20:52:40 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Dec 2024 20:52:40 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Dec 2024 20:52:40 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BL2qTBt084516;
 Fri, 20 Dec 2024 20:52:35 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <lukma@denx.de>,
 <n-francis@ti.com>, <mkorpershoek@baylibre.com>, <afd@ti.com>,
 <glaroque@baylibre.com>, <sjoerd@collabora.com>,
 <martyn.welch@collabora.com>, <rasmus.villemoes@prevas.dk>,
 <caleb.connolly@linaro.org>, <j-humphreys@ti.com>, <rogerq@kernel.org>,
 <nm@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 1/3] board: ti: am62px: env: include environment for DFU
 Boot
Date: Sat, 21 Dec 2024 08:22:21 +0530
Message-ID: <20241221025229.361625-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241221025229.361625-1-s-vadapalli@ti.com>
References: <20241221025229.361625-1-s-vadapalli@ti.com>
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
v2:
https://patchwork.ozlabs.org/project/uboot/patch/20241218124542.3519447-2-s-vadapalli@ti.com/
Changes since v2:
- Collected Reviewed-by tags.

v1:
https://patchwork.ozlabs.org/project/uboot/patch/20241217131658.2920799-3-s-vadapalli@ti.com/
Changes since v1:
- Updated commit message indicating that a newline is also being added
  at the end of this file based on feedback from Mattijs Korpershoek on
  the v1 patch.

 board/ti/am62px/am62px.env | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/board/ti/am62px/am62px.env b/board/ti/am62px/am62px.env
index 7ef54079aa8..e0838196e3a 100644
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

