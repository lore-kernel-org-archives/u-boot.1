Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E4AD6EBFF
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 11:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E88F893F5;
	Fri, 29 Nov 2024 12:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="v+0oH1sJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38D05893F4; Fri, 29 Nov 2024 12:03:43 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25267893C7
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 12:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ATB3ddF078701;
 Fri, 29 Nov 2024 05:03:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732878219;
 bh=mkCcK1u3b8rmO5nImT3A2uotZYVG56+C9zKFOyaIg2E=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=v+0oH1sJaRbIu7Mvr7tGFVoSBwCTHD2931S6tNnVBMGwZTrlJIrdDhJgHvHGxH4q4
 7nqJeajmq8cwDpDKujsYlaWucnOEfroo4CH3PJJlTANG+/Tx3bhBDFSH5LW8eNE4Jv
 /qSjOnlGokGxAGgpztxXfHuQZ28aTuw/r8gMWmM8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ATB3drr010025
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Nov 2024 05:03:39 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Nov 2024 05:03:39 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Nov 2024 05:03:39 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ATB3Xdh086529;
 Fri, 29 Nov 2024 05:03:37 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <vaishnav.a@ti.com>,
 <j-choudhary@ti.com>, <b-padhi@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 1/2] board: ti: common: Kconfig: Add CMD_NFS
Date: Fri, 29 Nov 2024 16:33:32 +0530
Message-ID: <20241129110333.444270-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129110333.444270-1-n-francis@ti.com>
References: <20241129110333.444270-1-n-francis@ti.com>
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

Add CMD_NFS to list of configs implied by CONFIG_TI_COMMON_CMD_OPTIONS.
This allows network booting via the NFS protocol from the U-Boot prompt.

Fixes: 10de12570799 ("disable NFS support by default")
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 board/ti/common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
index de44e4de211..821f02b09fc 100644
--- a/board/ti/common/Kconfig
+++ b/board/ti/common/Kconfig
@@ -41,6 +41,7 @@ config TI_COMMON_CMD_OPTIONS
 	imply CMD_I2C
 	imply CMD_MII
 	imply CMD_MMC
+	imply CMD_NFS
 	imply CMD_PART
 	imply CMD_PING
 	imply CMD_PMIC if DM_PMIC
-- 
2.34.1

