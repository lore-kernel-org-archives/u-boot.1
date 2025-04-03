Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9B5C36014
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 22:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80FED82952;
	Thu,  3 Apr 2025 23:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qO+JDYgU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2DBF82932; Thu,  3 Apr 2025 23:59:43 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC48F828B3
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 23:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 533Lxa4P3659618
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Apr 2025 16:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743717576;
 bh=eZLrrTI4m/O/uhzLhYF+7FU23yOxtCaBuFgGQSR22wE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=qO+JDYgUfKgsZwHEIcWBeab6zzlH0cX/2IxZUcTLOmvDsSNeZfrgLyd/+0/OGByac
 7pMgcfEbQVuVoFI3k+a+yPyDREyjU9ZNo73vatVAmB0O0lJqgDwFU5VIKkY8i1I947
 IkJuh4KKdePnfuOrfSJjTRv7RqER4CseWERiiOl8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 533LxaD4057906
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 3 Apr 2025 16:59:36 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Apr 2025 16:59:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Apr 2025 16:59:35 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 533LxYEt115429;
 Thu, 3 Apr 2025 16:59:35 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH v3 08/10] board: ti: add default dtb for am62[axp] in falcon
 mode
Date: Fri, 4 Apr 2025 03:29:05 +0530
Message-ID: <20250403215910.1292922-9-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403215910.1292922-1-anshuld@ti.com>
References: <20250403215910.1292922-1-anshuld@ti.com>
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

