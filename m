Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0F1C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 13:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED0A87954;
	Tue, 26 Dec 2023 14:58:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zgAiRtme";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E1FD87951; Tue, 26 Dec 2023 14:58:02 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C8B87942
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 14:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0HfxZq4NG5gICCgCd0p6VNwOFPGYnUI/P6qu6InVj7FCxIvbM9aGrKq8oO/zENL2ZSb3v3LePoog9pBWHyp4j9f0e2sXgpmFDYgYW7LY84KPlx5Ggo15obk1AyDWlwf2VRg9Qqb4Igknr8D3hMuvshqREK0fW80P2LZIHZ+xY+a2Yujiig2vlOb17pXdnPbUSooz2QyXkTQNsdG8T3jRXUllP8v0eeXz/JWqgaYOR85xSRRB4mOVynOxAsuenbUN7oG9X+Xf0hHscHdTzJ3IBv9b97cCZhqw6qA6Vyu0PheZnUdj14dUF6vvBaNIiMszq0RcvzrXVAFoTGxnFpmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0Ksms9E/sdySLxuKPuH7x5grgHhS9Bck4OxfaCA26Y=;
 b=Ls9M096qrrWOMx0zXdPoGy4nOYRPrxtpFjF1x2eyKXuJE9P593ml+nZKL5bH4D+nqGmjlMuOvNZRHQO3lSrpcYYVfJMMrSd09vu2hVDg2I98SnLps+sGfdg0lE5+jVjPOFczrNQZ7/o63rownFAUGuR2zAkP7Rm4lh8FxrghZEgB6jYEAfH5vJt6ZuAQBMviDfOHicDQG247cBcDWEkYjNxZLCx7kXB2sov9RB6qWfyCDi0K7gx6uK6bbTaNqLBrgLiGWWCCiabLWrd78foaqJuqCnLA2vjktpv+kuAsMZQiSAr5ZGSai0eqXd4PJmdGQ/Mi0vLp5xuPH7RWMb5k8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0Ksms9E/sdySLxuKPuH7x5grgHhS9Bck4OxfaCA26Y=;
 b=zgAiRtmeQuRUCi2GMsgaTdZ22HNvY9pLqgSbOxBcf+YA8V5+izwSSrAQfjlFhz6vDQiuRwSdlNQfaeUpdKnYzmrfwrgcxYTG3uAYVAedSzTZgjq97HwFkcII6IA0IHh9qjlNn75jUnFpFyWVPoLnPFUATOUUn0KSNJ196pwV4Ds=
Received: from SA9PR13CA0106.namprd13.prod.outlook.com (2603:10b6:806:24::21)
 by PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 11:45:14 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:24:cafe::f0) by SA9PR13CA0106.outlook.office365.com
 (2603:10b6:806:24::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18 via Frontend
 Transport; Tue, 26 Dec 2023 11:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7135.14 via Frontend Transport; Tue, 26 Dec 2023 11:45:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 26 Dec
 2023 05:45:09 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 26 Dec 2023 05:45:07 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <lukma@denx.de>, <git@xilinx.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v9 3/8] mtd: spi-nor: Add parallel and stacked memories
 support in read_bar and write_bar
Date: Tue, 26 Dec 2023 17:14:48 +0530
Message-ID: <20231226114453.577589-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231226114453.577589-1-venkatesh.abbarapu@amd.com>
References: <20231226114453.577589-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: d5212c6a-2e22-448d-67d6-08dc06081f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hhWmsMWsOmmG/Q+dgwOGuaxz2jikuNc9FuiuJUJhlPX+xmDul/O757vXVcrenY/72/p5Dx5iiKSlZ1sDfzMjZAg5jJhKU8fD0SyrzSSU3OsMYL9pi4xSkiCl9yYrogxREASAPmbVaiYMJf20Xc2/iSJ1kWwvkYdT+D6Qt/4o8Ron0yOiKBKD+5O8QzY44rRslRPFLkqhuxhRQgM04XuXQAZgtrpNhmAIIBSUT/nkzOosbMdGSolTHfhxxPYDmcox9DXQWhtwoWKUisZBicG2M0f57jh6ZXOWh9up3GEwLLpGUyvThWUolDCpc5XtfoWIx6PoFMIruxQ4FpxemQMGlSUzfraa8rN1Wbslm8ThLG7urhzo8J8JNkK2FXSPLdihWypOT5B0zfDVwn6jWVOm2SJvyJGGedxX+hChlT7wmgFQtNFUY6m9UK82q6HnRpaVn1AC8bKy+cbnWme96xIjuqKNwa+7SDokChSpvuDZ70cK9ba+PSI1jUq9w5SeGXDoBqIgRKINv+uRzY0LXx6uTva2ffUA7lHZEmkL0aHYC436m8dWT9K9AImHtv/YcCH3Kd63FRshLjxtnR3k5NIsVuIXo0q1IRmTlC15QNydAEQL6ZfmgFdvgy3VhszrX3/eKk0Jfe5h5FyGeglr5ac1Eeu4Rrax/T98o4GDTlJiKVnrI0t+Ay7/r4nQL3PDQ9oHdt3aYmqJgcYZ/+DrhUAkF92r8X2K9TCL9B+D/3CdMkmwUZ8X3Wo10gIITy1/42SxHaCAljCFFXZ/ZIUvcLkbSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(36840700001)(46966006)(83380400001)(47076005)(41300700001)(2616005)(26005)(356005)(81166007)(1076003)(82740400003)(316002)(36860700001)(4326008)(54906003)(8676002)(426003)(336012)(2906002)(5660300002)(478600001)(8936002)(6666004)(70206006)(70586007)(6916009)(86362001)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 11:45:13.7328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5212c6a-2e22-448d-67d6-08dc06081f85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
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

From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>

Add support for parallel memories and stacked memories configuration
in read_bar and write_bar functions.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 55 +++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 6d1bd4d54a..6ca43aa6e8 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -885,12 +885,32 @@ static int clean_bar(struct spi_nor *nor)
 
 static int write_bar(struct spi_nor *nor, u32 offset)
 {
-	u8 cmd, bank_sel;
+	u8 cmd, bank_sel, upage_curr;
 	int ret;
+	struct mtd_info *mtd = &nor->mtd;
+
+	/* Wait until previous write command is finished */
+	if (spi_nor_wait_till_ready(nor))
+		return 1;
+
+	if (nor->flags & (SNOR_F_HAS_PARALLEL | SNOR_F_HAS_STACKED) &&
+	    mtd->size <= SZ_32M)
+		return 0;
+
+	if (mtd->size <= SZ_16M)
+		return 0;
+
+	offset = offset % (u32)mtd->size;
+	bank_sel = offset >> 24;
 
-	bank_sel = offset / SZ_16M;
-	if (bank_sel == nor->bank_curr)
-		goto bar_end;
+	upage_curr = nor->spi->flags & SPI_XFER_U_PAGE;
+
+	if (!(nor->flags & SNOR_F_HAS_STACKED) && bank_sel == nor->bank_curr)
+		return 0;
+	else if (upage_curr == nor->upage_prev && bank_sel == nor->bank_curr)
+		return 0;
+
+	nor->upage_prev = upage_curr;
 
 	cmd = nor->bank_write_cmd;
 	write_enable(nor);
@@ -900,15 +920,19 @@ static int write_bar(struct spi_nor *nor, u32 offset)
 		return ret;
 	}
 
-bar_end:
 	nor->bank_curr = bank_sel;
-	return nor->bank_curr;
+
+	return write_disable(nor);
 }
 
 static int read_bar(struct spi_nor *nor, const struct flash_info *info)
 {
 	u8 curr_bank = 0;
 	int ret;
+	struct mtd_info *mtd = &nor->mtd;
+
+	if (mtd->size <= SZ_16M)
+		return 0;
 
 	switch (JEDEC_MFR(info)) {
 	case SNOR_MFR_SPANSION:
@@ -920,15 +944,30 @@ static int read_bar(struct spi_nor *nor, const struct flash_info *info)
 		nor->bank_write_cmd = SPINOR_OP_WREAR;
 	}
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		nor->spi->flags |= SPI_XFER_LOWER;
+
 	ret = nor->read_reg(nor, nor->bank_read_cmd,
-				    &curr_bank, 1);
+			    &curr_bank, 1);
 	if (ret) {
 		debug("SF: fail to read bank addr register\n");
 		return ret;
 	}
 	nor->bank_curr = curr_bank;
 
-	return 0;
+	// Make sure both chips use the same BAR
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		write_enable(nor);
+		ret = nor->write_reg(nor, nor->bank_write_cmd, &curr_bank, 1);
+		if (ret)
+			return ret;
+
+		ret = write_disable(nor);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
 }
 #endif
 
-- 
2.25.1

