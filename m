Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C62C47DA9
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 04:45:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4DBA87D82;
	Tue, 30 Jan 2024 05:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Blbe2Sgj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 731BE87D88; Tue, 30 Jan 2024 05:45:08 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 462B687D7A
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 05:45:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vcodn3WalQIHFOdF7sWZB4L+aAAU8Lz+obK5Y88Xm9amPcdQ+wuq1BvVVUlo1ZY5YrLTjm0E34sLBOGwhSM2eNyL31qxYGhsv6DMyKnbNuySGdVOaaGGfwRnu500lVe2e5pzzPOAsk4myPUxEl7KxgZ0D2wTR/dCWkUjna+uNmnKYxHc4ug6IqdYaUWtdPMGbCSATHDV/crG0ewslefK2WFU+IS8fjZy0Xskd1a7NIh8osnxzWXaqMjxubJSLdvVNNl1e6oTeEl8pApfP1yBLSXs+R1Cn9o+3KzUaJPT+B/rfGUQt2iJ9jzP8gGIRAH5k4BcODLHHHqVDfkAFm7UHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+fYo7/0IPvYhBRSbaash5g7XSB8xBYASXQgdfLkcn0=;
 b=TA+jMcuKEOZsRmz1x7UJe0kE99zRd5mPA88aqYu5ggo0fWgeuXvwYzUaO862uYvQ8Pudrbrfh6cI535jP5gjQoNrGabhbISyS9yAv2axVMoA1mNWJC3k/B6YAeXxETr82ksuWF75d93zx4lv3C4gccDFCKco+O4bPD0+lo4f/R4o+uJiO1eleOwUACJQJxDJlMJwCFNs0PM+0M+aCHCKtA2+u+kWILM0JENr53r6qisMXoAUorm++8QcFDSg6Hb76ZhTYFJgVBNNxGPF9kFWvHw46xfwr9hrvRjI4AuowOo1LJ82i1EQlvPbvXnNfk8AQOcV6FbhI5FhSK0FDx+HNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+fYo7/0IPvYhBRSbaash5g7XSB8xBYASXQgdfLkcn0=;
 b=Blbe2SgjH2JHq23vGl8Peiu2ZV1ogFcAPn4/2JeOXbWMPdK2OcWM0XfW+2iYIjZymUzWqcroIo+Fali6coXMAgDWZvIDjnARAjZdpP/508BN+c4y9qT1//9yERdKQWai2JCd2nJCxkRwp6FVmYlCUDsxWPrA3p8eBzM5xOCZRTI=
Received: from BY5PR20CA0026.namprd20.prod.outlook.com (2603:10b6:a03:1f4::39)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 04:45:02 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::57) by BY5PR20CA0026.outlook.office365.com
 (2603:10b6:a03:1f4::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 04:45:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 04:45:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 22:45:00 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 29 Jan 2024 22:44:58 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v10 3/8] mtd: spi-nor: Add parallel and stacked memories
 support in read_bar and write_bar
Date: Tue, 30 Jan 2024 10:14:18 +0530
Message-ID: <20240130044423.1391251-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130044423.1391251-1-venkatesh.abbarapu@amd.com>
References: <20240130044423.1391251-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 523d1281-3510-4afe-4fdc-08dc214e3880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NrvYSQuyMGn/bhA5JSi1RKOkNJQ71TrVhZ/Cr6ycUZ80XvmHQnm0L9D9mJ/yAAHJInBhKQ7aCFyVK8iaatS3jTHStIqTLqHauNMaKElHoVlFeQ8vPsWIh4YtBIAAF+mtEr5L072hs9rdKHYP53gRPWe1BK0Eyt9Y54Tq7iuYdMkMgmmf8HpinVxJXe1Vabm0efOCFSvPMT8TTqN7PoelHONjsCKmDCXkLeKofD5U8dCFREBZmMtdzHMCTgmVW8dRmZaSypoojxO5G/tufqWoA6SrZ0n6Ot6Q1XlSnPa+LjwuOyWt2iDlJYXsW5rj9StRLcnqV4FKAzAX/sYp7G62sYCDM2lw/auiBU5MmEciqztFFT92ng7nTpkNcQaualzNNu4gKxcHHnV4cT/TwqRM4IoopMuCOY8PUvRv6Bn7C/YbaYlcY/LuHU7hIvtFYv0ocIDST9EWlGPfz/4+5Kid9r/6AjU3z3uYqzjccgp20eMxdJgs8pqpY/YoCi6GMzVnPV/tJqjb9kSt0GrZhSXTG1FLQxer83KwWBYCn1ic16LYF5LzKboDdXShtffaVT6C6SZbSWRrLGUvGJrOQCv1Ej3pTHBMnRT8DFAZnNeGaFGIvoot73gYbEYHUg3LB0aX1yRY2qz+f8TUUQ1vuJJ4kIVJ74OL95EQcgR5Pat98wuoEqE7lzCgeWvgTQWgFktxONw0ok4BLc6ANgiF4mBhSZd5a3GiPK3qwXxGFvdsqIWNV+69wf+Aw7MA19WB7Yv1UD1TYvEItVNmkiYis1TYrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(2616005)(1076003)(6666004)(2906002)(5660300002)(4326008)(54906003)(8676002)(70586007)(336012)(316002)(70206006)(26005)(426003)(8936002)(6916009)(36860700001)(47076005)(356005)(81166007)(478600001)(86362001)(82740400003)(83380400001)(41300700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 04:45:01.7460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 523d1281-3510-4afe-4fdc-08dc214e3880
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
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
index b7e5f253a3..21fc9b52c6 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -909,12 +909,32 @@ static int clean_bar(struct spi_nor *nor)
 
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
@@ -924,15 +944,19 @@ static int write_bar(struct spi_nor *nor, u32 offset)
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
@@ -944,15 +968,30 @@ static int read_bar(struct spi_nor *nor, const struct flash_info *info)
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

