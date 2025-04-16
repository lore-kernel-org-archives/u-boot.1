Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3C0C369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 07:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F37A182D59;
	Wed, 16 Apr 2025 09:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d3OGNgyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80FA182D17; Wed, 16 Apr 2025 09:46:44 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3578582D88
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 09:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7kdGt247386
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 02:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744789600;
 bh=eZLrrTI4m/O/uhzLhYF+7FU23yOxtCaBuFgGQSR22wE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=d3OGNgyBc41w2SBizCHHfA+AnbKh1LGVcaGc4npHtSbYyelAlqUlQZjRHqvrz60oO
 JSaKXdkTkCP2AA7CwdAWBd1d/0NqfqvULgYOK1yxrd9+oxlhvQBbo7NC9hVtASibgv
 6O9wc5Ci9H9BRbPvGKMqMJOqCghEbLj4ElCYVtA8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7kdIY130370
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 02:46:39 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 02:46:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 02:46:39 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53G7kcKf069931;
 Wed, 16 Apr 2025 02:46:39 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH v4 6/8] board: ti: add default dtb for am62[axp] in falcon mode
Date: Wed, 16 Apr 2025 13:15:12 +0530
Message-ID: <20250416074515.1452854-7-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416074515.1452854-1-anshuld@ti.com>
References: <20250416074515.1452854-1-anshuld@ti.com>
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

The SPL_FS_LOAD_ARGS_NAME config is used for the arguments to the kernel
(dtb in our case) in falcon boot.

Setting it in board specific Kconfig allows us to reuse the same config
fragment 'am62x_r5_falcon.config' for all 3 platforms to enable falcon
boot.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 board/ti/am62ax/Kconfig | 3 +++
 board/ti/am62px/Kconfig | 3 +++
 board/ti/am62x/Kconfig  | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/board/ti/am62ax/Kconfig b/board/ti/am62ax/Kconfig
index 51e7b3e0eab..187e9e5c9cd 100644
--- a/board/ti/am62ax/Kconfig
+++ b/board/ti/am62ax/Kconfig
@@ -23,4 +23,7 @@ if TARGET_AM62A7_R5_EVM
 config SPL_LDSCRIPT
 	default "arch/arm/mach-omap2/u-boot-spl.lds"
 
+config SPL_FS_LOAD_ARGS_NAME
+	default "boot/dtb/ti/k3-am62a7-sk.dtb"
+
 endif
diff --git a/board/ti/am62px/Kconfig b/board/ti/am62px/Kconfig
index 9d95ffd9b29..5f7252d7b19 100644
--- a/board/ti/am62px/Kconfig
+++ b/board/ti/am62px/Kconfig
@@ -23,4 +23,7 @@ if TARGET_AM62P5_R5_EVM
 config SPL_LDSCRIPT
 	default "arch/arm/mach-omap2/u-boot-spl.lds"
 
+config SPL_FS_LOAD_ARGS_NAME
+	default "boot/dtb/ti/k3-am62p5-sk.dtb"
+
 endif
diff --git a/board/ti/am62x/Kconfig b/board/ti/am62x/Kconfig
index 610dacfdc08..1564913096c 100644
--- a/board/ti/am62x/Kconfig
+++ b/board/ti/am62x/Kconfig
@@ -32,6 +32,9 @@ config SYS_CONFIG_NAME
 config SPL_LDSCRIPT
 	default "arch/arm/mach-omap2/u-boot-spl.lds"
 
+config SPL_FS_LOAD_ARGS_NAME
+	default "boot/dtb/ti/k3-am625-sk.dtb"
+
 source "board/ti/common/Kconfig"
 
 endif
-- 
2.49.0

