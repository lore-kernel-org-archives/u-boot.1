Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEDFCAC598
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 09:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B278A835B0;
	Wed, 17 Sep 2025 11:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ajeMPYsf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75234834E1; Wed, 17 Sep 2025 11:47:09 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D3F983510
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 11:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58H9l56i222078;
 Wed, 17 Sep 2025 04:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758102425;
 bh=5qOs3XDDAPPI+zmms3tK+jASaBhSLZrpFQDfkzkTdcc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ajeMPYsfb/8GSrYcsucMrK7pIM4xevxFSFdmHSj0M6Wu509Xi/eeVnXYAv7y4sD/y
 xQ+/jdQzoAEAYGKsMoC24WwAT1nWwc9G/rooud7FNIVNY8iyP9240UeSOKun/PjvMe
 eYOQyNu9XI1bdPr94LR9hbhap6BhbnBq1pwg0y5E=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58H9l5lG2250355
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 17 Sep 2025 04:47:05 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 17
 Sep 2025 04:47:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Sep 2025 04:47:04 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.237])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58H9l0Bv3103753;
 Wed, 17 Sep 2025 04:47:03 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>
CC: <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>,
 <a-dutta@ti.com>
Subject: [PATCH v4 1/4] mtd: Kconfig: Add SPL_MUX_MMIO dependency to HBMC
 driver
Date: Wed, 17 Sep 2025 15:16:56 +0530
Message-ID: <20250917094659.3922343-2-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917094659.3922343-1-a-dutta@ti.com>
References: <20250917094659.3922343-1-a-dutta@ti.com>
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

MUX_MMIO is needed by HBMC in SPL stage. Enable it at SPL as well
as u-boot proper stage.

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 drivers/mtd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 2b7f5e5ed7b..e76601a5545 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -202,7 +202,7 @@ config RENESAS_RPC_HF
 
 config HBMC_AM654
 	bool "HyperBus controller driver for AM65x SoC"
-	depends on MULTIPLEXER && MUX_MMIO
+	depends on MULTIPLEXER && (MUX_MMIO || SPL_MUX_MMIO)
 	help
 	 This is the driver for HyperBus controller on TI's AM65x and
 	 other SoCs
-- 
2.34.1

