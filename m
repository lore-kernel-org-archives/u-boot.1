Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD227C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 04:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80DFA871A4;
	Tue, 14 Nov 2023 05:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JsJJ7//w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C028D8715B; Tue, 14 Nov 2023 05:57:06 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC8BF8715B
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 05:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yie/ajUk3Ex0PhHEC0jsPxXeZmyOVbcNWmmoRweZYoXq8WUmaWJeSB8EIgcRNJaY0WxdkM/nXGrfUtP9sKZOhbBTXHRiHm+D1iR1DP0KuNI14H0+9+/hN/NIrEUk38XEP46Cta6RRGwbPCC8xkV9EryASMk9RdB0w3Tmr8U5A1qrfBnqbuRsQhM1W7WXDLioZgVeR2mt34Tns0lwU3kp8UuDPiQU/0cGoFXzzAqOD56KKiuAyUPZP+lQIvrV5SaGoHyn8QnYCx46glFYac5vxX1G8DnyKd8r6zWYuaDUSDuIKHhov3QBpM+eoAaMrQTgcgSYB0M73l5/YMncG/Gmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEd8eF0M7FFps7PZXWTUcLICXAGhW6mR4HsB7Zcn5Ig=;
 b=FbTFdxDs3XsIAHup+1/WBpmyBzs2KcpStma/k6HmfzLFQVoYLhbHxlDrs6bBTUqHUBRu9YLtH1J+sbKYNenFbBZhDQ6XSoiS+VGdlULPGlv+3zleaKWpULfy+iRW9Ihm6U/j2+AIeJaUwT18vlXbnG3Q7vJTmn3Od3opzm1Hur2L6xPOoFxAJUW5juS2XhBoQ6Uz56xf3+aj6MGuv78QCgay2XsP+Ou8A79kfCWtpkLxVmrSSyFYbeEaugZz/CF2hMdCXtOUP13LMmcrp18SmqoCCl8OhlFf+iUJm6hxO4kpVk6qHYORjg2aPj2eaKPUzEaJSF291cXBEjD8e0EO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEd8eF0M7FFps7PZXWTUcLICXAGhW6mR4HsB7Zcn5Ig=;
 b=JsJJ7//wGpDfFqPPWRGZ6v4DnHNE5EldyiwEL4pJsuknUkht0DqTzIvYkJTXaTdoUqiHbUoRGnLSB2WFyc0oHGPuvJHItg5CqSzE7Cyk62pfIwDOOQdfwX69IDkl18KHiJOIfpQcuM1Of9cdIXJIyHd0aGwyobYoJ4Dm/Nv+Koc=
Received: from MN2PR13CA0008.namprd13.prod.outlook.com (2603:10b6:208:160::21)
 by MN2PR12MB4565.namprd12.prod.outlook.com (2603:10b6:208:26b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 04:56:59 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::14) by MN2PR13CA0008.outlook.office365.com
 (2603:10b6:208:160::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Tue, 14 Nov 2023 04:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Tue, 14 Nov 2023 04:56:58 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 22:56:58 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 20:56:57 -0800
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Mon, 13 Nov 2023 22:56:55 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v4 2/6] mtd: spi-nor: Add parallel memories support for
 read_sr and read_fsr
Date: Tue, 14 Nov 2023 10:26:34 +0530
Message-ID: <20231114045638.6463-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231114045638.6463-1-venkatesh.abbarapu@amd.com>
References: <20231114045638.6463-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|MN2PR12MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2f566c-c14d-465b-987c-08dbe4ce21d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7j0iC9ZPvp03RxRZw+EOAyGTK2PX/CFIfXXFADGN6409FbOvKzUeVesldU/aMJ+0L6d6uaPMhZ0fJqlN70w/qnWhZ2CxGQzSrqPDZ+DUUVkNrdgReIB4RD83jgYdvlzrAUaKq7X14GxyYGPLvha7snuF3Set1lDQKeMufSp8xZtZIeRGsirrdr/McYqvs+qPsvLe77RIyiDIHm6TEGn96ezuLi48nzjjPs0DXzG+UkQcjS2pvx1HIVd7SJhWGa3bvIllFEtI2NVdJABs2QZO5MslWIM3xCGPxjtg/W5rCnZPnmyZg6RWz6wzh0RveRRcLsFM2Umt2Cjn2DedDIjAZOi6lFdy1qoFCJb/sc1dD6XS2+ChwObjNMytRSkIpeUP7XErK3faED5Wv0AEBfFHO7tBxa4FqQ+alD037l8CW5/9LxRnDEscEQ+jjAamKCwayxOacjUo673VNql5fWuISTeKHdPxlLNsVQhVHcOH+IgjhUPElJiGl3IK/9rF+Z3ZfB4QXCD4cgYB+bRmlEDXqEnV963m7VljeHSVQbsijd/4WzccFr9/43ljH1MApc9bh/RmZvMwcIkKEykpzqTnt0TP8RyBvSv2cId5oRNnpL/ZBSOQOZxxDkPNqWpKZE78UOc0uX2jIgC5nFBSEgxO9KVownphvZTVq/VTMGpBT/lfX9G8P6iRR5wjOzuzaaaplev9Sr2dGtfAwlZinLU8Qz4Ph3lRQIHjdSgWOvCHdRTQ6+DDMYk95CFct0iwkcGBbvVMY2akUQjkm26+Gm2cQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(36756003)(86362001)(47076005)(70586007)(54906003)(70206006)(6916009)(316002)(426003)(36860700001)(82740400003)(8676002)(4326008)(336012)(2616005)(1076003)(8936002)(81166007)(6666004)(356005)(478600001)(5660300002)(26005)(41300700001)(83380400001)(2906002)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 04:56:58.4459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2f566c-c14d-465b-987c-08dbe4ce21d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4565
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
index 2f49ca3365..c1c9d007f9 100644
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
2.17.1

