Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D857CFA77A
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 13:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F42988A4C;
	Fri,  4 Oct 2024 15:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S8vX3FWh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE46E88B2D; Fri,  4 Oct 2024 15:21:13 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D0188966
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 15:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 494DL6B2050751;
 Fri, 4 Oct 2024 08:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728048066;
 bh=j/66IydhbJx+1ev6CtNgLrJAQeznnLPCZ4ukNesX0u0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=S8vX3FWh4hefVrg9l17tAcJCx80pKidyFg+gv7kd9jB6ucskC9D6zmVzqz/2N6nNc
 U6pk34wfBIKnjb2s2qaTzskV9HN1NBV8r0E+HwCule2kTyfeCqeABF9JRTXWtkfXoT
 Avl/gD7POeNOSS/3RxuX4R2GfAJMF67KzvnFO8jE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 494DL6YC107524
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 4 Oct 2024 08:21:06 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Oct 2024 08:21:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Oct 2024 08:21:05 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.197])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 494DKx3d061378;
 Fri, 4 Oct 2024 08:21:03 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: [PATCH 1/4] mach-k3: common.c: Add dma device remove in spl exit
Date: Fri, 4 Oct 2024 18:50:54 +0530
Message-ID: <20241004132057.1449909-2-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004132057.1449909-1-p-mantena@ti.com>
References: <20241004132057.1449909-1-p-mantena@ti.com>
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

While exiting from spl, remove any dma device active through
spl_board_prepare_for_boot(). This is required for cleaning up
any dma channels being used in spl and avoid issues with overlapping
channel allocation in the next stage bootloaders.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/mach-k3/common.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index df48ec8d47..982dc76b00 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -28,6 +28,8 @@
 #include <env.h>
 #include <elf.h>
 #include <soc.h>
+#include <dm/uclass-internal.h>
+#include <dm/device-internal.h>
 
 #include <asm/arch/k3-qos.h>
 
@@ -246,12 +248,31 @@ void spl_enable_cache(void)
 #endif
 }
 
-#if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
+static __maybe_unused void k3_dma_remove(void)
+{
+	struct udevice *dev;
+	int rc;
+
+	rc = uclass_find_device(UCLASS_DMA, 0, &dev);
+	if (!rc && dev) {
+		rc = device_remove(dev, DM_REMOVE_NORMAL);
+		if (rc)
+			pr_warn("Cannot remove dma device '%s' (err=%d)\n",
+				dev->name, rc);
+	}
+}
+
 void spl_board_prepare_for_boot(void)
 {
+#if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
 	dcache_disable();
+#endif
+#if IS_ENABLED(CONFIG_SPL_DMA) && IS_ENABLED(CONFIG_SPL_DM_DEVICE_REMOVE)
+	k3_dma_remove();
+#endif
 }
 
+#if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
 void spl_board_prepare_for_linux(void)
 {
 	dcache_disable();
-- 
2.34.1

