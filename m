Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18EDCCD1A5
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 08:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7B86836A3;
	Fri, 24 Oct 2025 10:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="o1t0hbIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97FF1836A3; Fri, 24 Oct 2025 10:14:19 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56C3283631
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59O8EF8L718489;
 Fri, 24 Oct 2025 03:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761293655;
 bh=k5hkvDvfqHEzNHbsm/KSEh5wDss+zYi+/hRBnKObb8s=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=o1t0hbIhKoKQQorH5ANkrCMGErnyLgPdMMoE3te7vwRdSfI2ERkqZiC7OraUuc3Go
 gVAv78gUHr0ux0/yM7DDAoD+ZEreaxkm2MWIF9BRtD+YHmrQgd07oIymg6hErLaMBk
 edRsAqElJPjdqh+mYSRqtDvC4RkG5zou+GRKh1Hs=
Received: from DLEE210.ent.ti.com (dlee210.ent.ti.com [157.170.170.112])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59O8EFdv3744053
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 24 Oct 2025 03:14:15 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Oct
 2025 03:14:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Oct 2025 03:14:15 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59O8EDp1041681;
 Fri, 24 Oct 2025 03:14:14 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH v3 2/4] board: ti: common: Kconfig: add CMD_SPL
Date: Fri, 24 Oct 2025 13:44:05 +0530
Message-ID: <20251024081408.1610102-3-anshuld@ti.com>
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

Add CMD_SPL to list of configs implied by TI_COMMON_CMD_OPTIONS. This
allows the use of 'spl export'[1] command for preparing a device-tree
for falcon boot.

[1]:
https://docs.u-boot.org/en/v2025.10/develop/falcon.html#using-spl-command

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 board/ti/common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
index f481812247c..fa8260e3fa4 100644
--- a/board/ti/common/Kconfig
+++ b/board/ti/common/Kconfig
@@ -53,6 +53,7 @@ config TI_COMMON_CMD_OPTIONS
 	imply CMD_REGULATOR if DM_REGULATOR
 	imply CMD_SF if SPI_FLASH
 	imply CMD_SPI
+	imply CMD_SPL
 	imply CMD_TIME
 	imply CMD_USB if USB
 
-- 
2.51.0

