Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FAACEDDA3
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D907C88DB6;
	Wed,  9 Oct 2024 16:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UBaVGKYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0059988DFF; Wed,  9 Oct 2024 16:57:17 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB5C488DB6
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 499EvCRs057093;
 Wed, 9 Oct 2024 09:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728485832;
 bh=AYSDMC5ydGdzXpPzt58r0D2ntkV15yLPIDh3EbEqvEo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=UBaVGKYn3uodAnL0r4X7/33h0ttxpUlN8gZhXIaGf2NxkKFVEWi/S2/a4LImltEUu
 Ke5WH1pxgut1nK6h3RiuudrAQEkELfORPXWcnlTJuqQt9tBNM6LSfOx1xid7uG///E
 qHXS3ufLpJU3c3rfKfgdwUrYxhsYyei0+2JC4BGE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 499EvCZn010394
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 9 Oct 2024 09:57:12 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Oct 2024 09:57:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Oct 2024 09:57:12 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.197])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 499Ev5cd008396;
 Wed, 9 Oct 2024 09:57:09 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: [PATCH v2 1/4] mach-k3: common.c: Remove dma device in spl exit
Date: Wed, 9 Oct 2024 20:27:00 +0530
Message-ID: <20241009145703.1970034-2-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009145703.1970034-1-p-mantena@ti.com>
References: <20241009145703.1970034-1-p-mantena@ti.com>
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
 arch/arm/mach-k3/common.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index df48ec8d47..ff47739e9b 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -28,6 +28,8 @@
 #include <env.h>
 #include <elf.h>
 #include <soc.h>
+#include <dm/uclass-internal.h>
+#include <dm/device-internal.h>
 
 #include <asm/arch/k3-qos.h>
 
@@ -246,12 +248,33 @@ void spl_enable_cache(void)
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
+	else
+	    pr_warn("DMA Device not found (err=%d)\n", rc);
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

