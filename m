Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918C9CCD193
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 10:47:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60799835B0;
	Wed, 15 Oct 2025 12:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jgmvK9kP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E01B28357F; Wed, 15 Oct 2025 12:47:13 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97CA580107
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 12:47:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59FAl9rX1299395;
 Wed, 15 Oct 2025 05:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760525229;
 bh=k5hkvDvfqHEzNHbsm/KSEh5wDss+zYi+/hRBnKObb8s=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=jgmvK9kPYL9qfTN6s9XCG+zBjJART9br1zSeUUVAvsDFoQZi9JXVrV7iGmP+6KkfZ
 TlXcdBr3696mhqLRa/+fBhB8Ul5QO/7vwX9vv9VmRVe806JPiQ9wfl6YiWkVrpGxz8
 K0SFvBMLj/pUdH+Gc/4MiPg6gASG/Jn24BjmWC8k=
Received: from DLEE212.ent.ti.com (dlee212.ent.ti.com [157.170.170.114])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59FAl9iL1166508
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 15 Oct 2025 05:47:09 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 05:47:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 05:47:09 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59FAl8Db1778457;
 Wed, 15 Oct 2025 05:47:08 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH v2 2/5] board: ti: common: Kconfig: add CMD_SPL
Date: Wed, 15 Oct 2025 16:16:44 +0530
Message-ID: <20251015104702.3726411-3-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015104702.3726411-1-anshuld@ti.com>
References: <20251015104702.3726411-1-anshuld@ti.com>
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

