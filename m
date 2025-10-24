Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBA9CCD1AB
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 08:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 252EB83678;
	Fri, 24 Oct 2025 10:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CKjibojT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E704E836B4; Fri, 24 Oct 2025 10:14:20 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0083D83678
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59O8EH5B1850491;
 Fri, 24 Oct 2025 03:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761293657;
 bh=er7F7bkzcGFtcMsDmNGJ5GN3zIT3EE26aWpNpz/lA5Q=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=CKjibojTB/cZ7DG+TfJ00ssD+SC0I7mEXbGxfMw1ikLhJc263HILhbzeVpJPoRMv/
 xa7MuAn6lofd34UYcDS6ECAEAs6pBwVFSZM9o/WVTRCkxingp/S1uObMB7ZfwnzGTj
 zgmQ+eXvAC5bfmXv81zsLLPM4OnEy3XfVVJV7LKo=
Received: from DLEE201.ent.ti.com (dlee201.ent.ti.com [157.170.170.76])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59O8EHaI3437699
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 24 Oct 2025 03:14:17 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Oct
 2025 03:14:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Oct 2025 03:14:16 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59O8EF9Z035146;
 Fri, 24 Oct 2025 03:14:16 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH v3 3/4] arm: mach-k3: enable support for falcon mode
Date: Fri, 24 Oct 2025 13:44:06 +0530
Message-ID: <20251024081408.1610102-4-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024081408.1610102-1-anshuld@ti.com>
References: <20251024081408.1610102-1-anshuld@ti.com>
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

With CONFIG_SPL_OS_BOOT enabled, U-Boot checks for the return value of
spl_start_uboot to select between falcon or the regular boot flow. Where
a return value of 0 means 'boot to linux'.

This patch overrides the weak definition form common/spl/spl.c to allow
K3 devices to use falcon mode with SPL_OS_BOOT_SECURE enabled for the
A-Core SPL.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 7c06764af82..04a0f232d84 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -480,3 +480,11 @@ release_proc_ctrl:
 	proc_ops->proc_release(ti_sci, PROC_ID_MCU_R5FSS0_CORE1);
 	return ret;
 }
+
+#if IS_ENABLED(CONFIG_ARM64) && IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE)
+int spl_start_uboot(void)
+{
+	/* Always boot to linux on Cortex-A SPL with CONFIG_SPL_OS_BOOT set */
+	return 0;
+}
+#endif
-- 
2.51.0

