Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A01FC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 05:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87D2287A01;
	Thu, 14 Dec 2023 06:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uCzMW0pH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C0BB879E2; Thu, 14 Dec 2023 06:24:09 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E9F2879A1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 06:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akIIHO7sJ0QOHb7y8gh1evM+XZOiFw5CN+rmBJd0jWuDTWhEN0U2rvQbDRAlURpY0E0aoMn/4EILAabgnXhndLywCXDtoVtoqfC6gveVKKlpRq4TWV0f7L8UHlGG1hUffykcV69braWBOcmdJqCFgrRE+Qs7T9GUtU614mLuqV/wQOWPHzCMJJ8RvQZZ5aIU70vBRWZ6Nze1Yl/D4kY6M9ofKmNDUGrVdioxXWEZpQzAz8XBxsaV8T7M9F6xJFMQOg8HZ+ihAiGu4wAjgANkoRkohcq7TLUMtaSAtTQZgsEIHUnHUxFj1nAQ0k1IQdx97EDd8hVT1kEo+z8jInhnSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFUMhewX+wwjfc26OO3b6HGNXnbQPSPE8DbhyNRUz78=;
 b=BgHhNF1vK0Rb4iOZzyfwBFGEnsmUxa7ZYkFpAISC8LVRDoDQHv9GeeQAaBcnU6RgHmvyzXav+HHWBBW5o4PkfkvHaIGGlT89pFYAQrqJByGY4UV85RAdylOKGVOg1fu2Dd9NFcVAFlR4PLpn7556FZcZ55u09RFQka3mvk7yaeD9e3AxGggagyE4HoawKIy6voRhc/Wc3YbTaoSQwWxDfAmg5Se3kG6y1rvOra5hp04BnnJ5TEGOUPMEOxEM9/bPlmmLy6G1AuhvbHBF9LqoFPfB13XYZ5N3L8QzBdRMe6LS5jrNGD0IcInM8LjQMiIKMqwz0Cs9ysdifwF4crqppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFUMhewX+wwjfc26OO3b6HGNXnbQPSPE8DbhyNRUz78=;
 b=uCzMW0pHN3rx1BOBzb6QihlPzelL+LvGZAupikvJRfvTgwaZkK5nk5WtoadiEQzM2FLRmEl3lpLQfB2zbNIUviWs4xizJmxOikhIw37DA52XuyzoJ7MTVlEUKEUWgyl9fKFOyTMI8RIjjdWXU6rvnQRKCOsEvcyMMlIV8InLMGY=
Received: from MW4P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::24)
 by SJ0PR12MB5486.namprd12.prod.outlook.com (2603:10b6:a03:3bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 05:24:03 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::16) by MW4P223CA0019.outlook.office365.com
 (2603:10b6:303:80::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Thu, 14 Dec 2023 05:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 05:24:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 23:24:01 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 23:23:59 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v6 3/6] mtd: spi-nor: Add parallel and stacked memories
 support in read_bar and write_bar
Date: Thu, 14 Dec 2023 10:53:36 +0530
Message-ID: <20231214052339.82382-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214052339.82382-1-venkatesh.abbarapu@amd.com>
References: <20231214052339.82382-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SJ0PR12MB5486:EE_
X-MS-Office365-Filtering-Correlation-Id: 2261d005-5d37-48ef-1af8-08dbfc64e25a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 299unel+v4bCJFXK23SgSqPqbALm9CnMZN+O46yA00WCsUcy+v5gSMkUzBc+Kk1ZlLwF38wGbZmhQ4uGm4iSR6YTadAAzlL/9SfRVVkXPlpYoeV+dIOIhNtuFfdRHdVfAscg6jmkbxgKsanFsAe4oKGqWm6UF1er6KzAvZF1SUJtEja08rtxZVWREX3zgGtHj7w11HVHl/mRdbywfhO6GGcA1jsTZMlddPDtMQT02MZ9/94uhD28BNQ3xyS7NSs5J5YU+9P9pbGf5DmLaDip2eO7zFXuKrX2puOmFaXqvd6olREO1c4SmCiBg9i5feaA0X0fFVGOjbnrxk+kGJZTh9fLa4GQwykGReIQvfi+ve4Ikl7DeLKIpYVWh7Bg+F6/w1D8WKstgRBHEdCV4Ssnwi0hapyXvmcT6UP6heFlI7mzHJ4ulQqXfjOAwIolDKxpA1s7e795nP5x/SiGOe+7o1U3hNxbVkg6oouYJ/QmWntmEp6Sy9KgLSMv1YjOe7KVpKfSbSq501IjD/hYFmXfMiJHgFzQsJfaVKtvsZ+tuHkZBjXU7kjNKjGiKllVAbZZ2+q6pYNVFmSpCje3aGtSgzTUjLtE1jf3w1YLTFzwevvsvABKuCxn2RYNE1dZGSafx44gmrPUK1StsgT2OrHBVopIlcC7IdchyOcWb3DFUr/3rgnTa3GqQZtzzUyPSDfmCB2QQlCgcehNEcZgc1dCr4YQQACf6M4wE2Qm8QrLZ6f13sbzAKEvom+Y5dogoaL4WUAq6ewkwbiDus3ZxAjiSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(1076003)(2616005)(336012)(426003)(83380400001)(26005)(86362001)(41300700001)(4326008)(8676002)(8936002)(36756003)(2906002)(5660300002)(70206006)(316002)(6916009)(54906003)(70586007)(6666004)(478600001)(36860700001)(82740400003)(47076005)(356005)(81166007)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 05:24:02.5979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2261d005-5d37-48ef-1af8-08dbfc64e25a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5486
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
index 30dd2764c9..2c6a203f82 100644
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

