Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C65C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61DB18784B;
	Tue, 26 Dec 2023 10:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="py/0twIn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A4168784B; Tue, 26 Dec 2023 10:36:38 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C33787527
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUrmoQp4u9hE+xFjHy8oIUVECiy2GtzasIw2bwu47sT2Z5KBkn58vLxLDzJzriDqR4XMzIlyx6tPI0dPB7KOKhuxATt5ajYBKKnk7pp5nCH9WMnxe7Uh9U9Mfygdvl/KMmq9fUs/NyEDzSodYblbnFYHL0U4ql4a15C6FtO3NWWPxnBTGbrBnvDqOhlFIoWMuJWFBSnYyuHTxeIfKPtYDSf9VeJ3wPjH4Ri5pKlgQIzi4Rn05szq+UWnRTTDNX7YfejZdb4ucDC/XW6h7fU9m0JgkV4cUyr7MdOAiMndt24F3BeVNxI6B3GWBWCREfkzo+jAooeCddrYL7TEwEF9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFLLCnYtXjP7ElUcOZbc3PjaIlKWvS6oivkiqxXXD/A=;
 b=D4WKCVJm/e9+GX9/rPbm2pwddcZMGhUOls3yxtyGpOMtz9HjFkE20BFpe8TQREl8w111M1zHlSioDr18EcFyGRYxHDB/pL2zOz63Sq32FpslE8O6VhBaWCYal5DUbje0M7kFP1cIHmla9EMk81hZzOEEiW2t04VyjJf/1bU7FadGJeza7mTXqFUXQaSf2bxwHkqmFtkB0aiZ7LMQ6qQZ9mE5hoCroHz+7SsXNfAtEly1uDBpIQ0d3fW+6Oby/reZezU6YnccgnXZEc0Txtszo/ndH+GyOb/OsXyuK4BHTTzSyaW2I/Zue9ax3s7jiwkS46A0tlTyQVMNr0Vt6GO37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFLLCnYtXjP7ElUcOZbc3PjaIlKWvS6oivkiqxXXD/A=;
 b=py/0twIn2ItDPmbRfCxSDiUEcU7pl3qGOVO/rles8M87I8YnWTdGgp4cRzWsQbWJBAuHV+FPVDT3CLmEsg7lwyW/ogV9UZIRe9Xc6cEbQdn/3Sb05bHwstLa4AwTke3D/8s3vP0L1b+ZUuG4ghnyqVwjpeHVQVs20ZIqVLCBZU8=
Received: from BL1PR13CA0362.namprd13.prod.outlook.com (2603:10b6:208:2c0::7)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18; Tue, 26 Dec
 2023 09:36:30 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::50) by BL1PR13CA0362.outlook.office365.com
 (2603:10b6:208:2c0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.16 via Frontend
 Transport; Tue, 26 Dec 2023 09:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7135.14 via Frontend Transport; Tue, 26 Dec 2023 09:36:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 26 Dec
 2023 03:36:29 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 26 Dec
 2023 03:36:28 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 26 Dec 2023 03:36:26 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v8 2/8] mtd: spi-nor: Add parallel memories support for
 read_sr and read_fsr
Date: Tue, 26 Dec 2023 15:06:09 +0530
Message-ID: <20231226093615.530089-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231226093615.530089-1-venkatesh.abbarapu@amd.com>
References: <20231226093615.530089-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: 674680e6-aa3d-4444-7d91-08dc05f6239f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNCNe722/Wt6Rc7OoajRgtMhF3TnxUa4eayyE6Zv5S2Z3slOVSBegvXsdypBwwgrHo3e+l0jF/vXPJYoTilb7XLywyQImDkIHya/NY4DuS8IpxgD5+JR9JOx4ofEZNZsqiJ6FL4NF6dYatwBCyJZXaF4OKCv50QnHSYTYnK0yXe3yvKm8KOuFPTILcMc6Xh4+q87Fl2bZjUgzBnD6Yx7dLww85ixUGR9SOSCIc48nuI3VEIysni1HQa5+kYEAUeU1s1d6mhU4nOmlvNCaY1TRnwvFlBx7RsO7voLo89nTDW/DUP1jDI6RvdBPELEldzQtPu/6vKXFFjrcM3K+2eI6XdmDe+PRf2PM8Ykw/9GbVlgP2d/J6pZ7rWDb7Qy/q4uk4VQQBGvy4be6LHqluSGMCS0M792lWhNJX42R7ryDUzgLvnYUQbZgNauRN0P30aBFrlrthh6TuD2plclffanyNUJ39P4GccTIZ9iJ8iH+3pUD5QfNY8f1yKBxU0/ImGSWiy29Y4hcHCWZCN7LTEDOH4mwFoBOJj4MbabJHIirwM6C81R14HExkRlt+KZsmwYl3GpDdhrkBAWwZPkphiyWbDeYjk+vH66c3e637cJENFs6lDNuqP9w77xApYaAQCoegVcDBlPMP1jWakLmwsMi5FScC+aonavaCFOpAiyB4B6a5gw4wkz4irjwdwQtXKe5/UBnBOsv2elub0xTsuqdWZU33KtEDOLfg4qOhvhh3To66+WoKtpVhsGOcJoXqqdckHNnpwOMnQNjdFMB6bxlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39850400004)(376002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40480700001)(36756003)(40460700003)(6666004)(6916009)(70586007)(70206006)(86362001)(336012)(426003)(1076003)(81166007)(356005)(82740400003)(26005)(83380400001)(2616005)(47076005)(41300700001)(2906002)(5660300002)(8936002)(8676002)(478600001)(54906003)(36860700001)(316002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 09:36:29.7047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 674680e6-aa3d-4444-7d91-08dc05f6239f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
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

Add support for parallel memories flash configuration in read status
register and read flag status register functions.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 50 ++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 9d72dff85e..6d1bd4d54a 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -438,8 +438,9 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 }
 
 /*
- * Read the status register, returning its value in the location
- * Return the status register value.
+ * Return the status register value. If the chip is parallel, then the
+ * read will be striped, so we should read 2 bytes to get the sr
+ * register value from both of the parallel chips.
  * Returns negative if error occurred.
  */
 static int read_sr(struct spi_nor *nor)
@@ -471,18 +472,29 @@ static int read_sr(struct spi_nor *nor)
 	if (spi_nor_protocol_is_dtr(nor->reg_proto))
 		op.data.nbytes = 2;
 
-	ret = spi_nor_read_write_reg(nor, &op, val);
-	if (ret < 0) {
-		pr_debug("error %d reading SR\n", (int)ret);
-		return ret;
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		op.data.nbytes = 2;
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading SR\n", (int)ret);
+			return ret;
+		}
+		val[0] |= val[1];
+	} else {
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading SR\n", (int)ret);
+			return ret;
+		}
 	}
 
-	return *val;
+	return val[0];
 }
 
 /*
- * Read the flag status register, returning its value in the location
- * Return the status register value.
+ * Return the flag status register value. If the chip is parallel, then
+ * the read will be striped, so we should read 2 bytes to get the fsr
+ * register value from both of the parallel chips.
  * Returns negative if error occurred.
  */
 static int read_fsr(struct spi_nor *nor)
@@ -514,13 +526,23 @@ static int read_fsr(struct spi_nor *nor)
 	if (spi_nor_protocol_is_dtr(nor->reg_proto))
 		op.data.nbytes = 2;
 
-	ret = spi_nor_read_write_reg(nor, &op, val);
-	if (ret < 0) {
-		pr_debug("error %d reading FSR\n", ret);
-		return ret;
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		op.data.nbytes = 2;
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading SR\n", (int)ret);
+			return ret;
+		}
+		val[0] &= val[1];
+	} else {
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading FSR\n", ret);
+			return ret;
+		}
 	}
 
-	return *val;
+	return val[0];
 }
 
 /*
-- 
2.25.1

