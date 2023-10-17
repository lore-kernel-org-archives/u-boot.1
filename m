Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC03CDB465
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 03:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1733586BD7;
	Tue, 17 Oct 2023 05:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4L7pfnqX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0EBE86C58; Tue, 17 Oct 2023 05:32:42 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8D5F86BD7
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 05:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcgdWuUlgb8ODCG8M29/9WpnSKsywkAD9/Jg/pv2JT75AwX7hutpqFTjFozqKAubAmeB/Q36udHwEeWKcJCsMkZXuHYTxZg2EkvHb0BpylNhM2pcve/DDxbPt4li0bhpC9d2AZlAsDYQng8fXF6II5K5FC+xURCYnf4GHrJND2v3BSjv67uDHfwsHNuxmu9KOf94QCGZ1NOywV+YADVEsKjMjExtoByl1wqtzkzPwkBLzYi2Q4HvXBQ1XT6sVya8yeb7G26KiHpJSE0L+RcZ6iOmEuW4NBNHjOyIUxVkIohcFwml9OTBD4PEHmzviTab6gUu4smhmB8w3aM2mP+FJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igydsWcJH/1JHaWfqt8Fug3iBe8QuSj5bC0+GgZkCuY=;
 b=EnLZ+W/qvRhambmAcTOnIDSX440WvEeSGzJUyi7dj0r7O04Ik1ccvk+fGUvGXerpnmLVf2WWjlczHC8Y8oJ0N03taa0UbRGNR6lA0cFPmC5aTLcNoE82D3jGcNdYwcxj5P+K0QnALIGIr+vG0Z652xfu8e+PE3Z4js6ifqCp5ivdRm0FBXTWXfi8u7+5aKwvbN0bXb1Q7kJUB7dkBaUlvquaWRhlwGkyW1cH2COLMr8Kf8zAQcGFEoK5ooBevoY1m40p/1Ga1D0R9dDJTbPiBhKb/9Cog0U43Vt+MJ4aaIhgGOZ6e+Ih46Z4ZGC7AuXxTIYwImeBdbkzr3CyYCGxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igydsWcJH/1JHaWfqt8Fug3iBe8QuSj5bC0+GgZkCuY=;
 b=4L7pfnqXuSzmA9edhFvQ7WYHA2jIf8e6qYoUkx3qE0zNmeO34zG8f9jniw6Acaiu4xZeHJzOUteF00p209BhiJ4lAeRqSB8oQsHDsX82d6s7hTtWkWc0EV1JxqiRO/EqSpZNASSkVrwch8HErPkaRMkUA5mZavseYUf1aIqQM5M=
Received: from DS7PR05CA0059.namprd05.prod.outlook.com (2603:10b6:8:2f::32) by
 CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.35; Tue, 17 Oct 2023 03:32:34 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::66) by DS7PR05CA0059.outlook.office365.com
 (2603:10b6:8:2f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Tue, 17 Oct 2023 03:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 03:32:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 22:32:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 22:32:21 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 16 Oct 2023 22:32:19 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v2 2/6] mtd: spi-nor: Add parallel memories support for
 read_sr and read_fsr
Date: Tue, 17 Oct 2023 09:01:54 +0530
Message-ID: <20231017033158.27740-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231017033158.27740-1-venkatesh.abbarapu@amd.com>
References: <20231017033158.27740-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8f7b30-b73e-4f1a-060e-08dbcec1b316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Jwkemkeui1150CMjDFzTOlJT+x198wlnwGJwZ5QmYBRg1kNNfBjKRcsBtDzSh5JSEJEHkENemb9Uf//19QM6k3D8Rs8jsbLdPNruG/oVxGpWh3p4QUGOUl03zW2nd7E6HXcCqL31fNMIMf6inbO7VPCxv5zFprLpU2ZKso1n0Sx53WC3Hdsib+RbH+7AcCfUWJFsRJPn4eBMMnYDp81Udjv8coYdY13e4Vak7dhqzbeTeNfzqbbwWHnEAWvG8cdGh6MocFrdNYjzAfoIJzJ++t3DevDDihomSlawew3yJRwNSEGE90bXIfodRH1gFaxaLuJmbE34EO5/zww1iSlQxkBCOFIlS3e2mPk8YETGZ4lIlerGP/cwwQ3nq5Ogb70X8ktYIFUIV/IMcnuD6orVlYtIaKMZRNBS35LQwvdYBvn3T9qIxfEATnL7SutQvOBIRLt3+KfsRXKyT0P/O+fUAjRcz+gNcjslSxM05NV9pJlscNvf+mWVga9oz94xYuPTmJOQGiFT0Xd3C82PNKcPjHct1S3neRaNE+SdkN0qHU8AXpEbn8tQF6/0uljZol4dx3Gav7mB3mx7Xnt++UYidkmeVmLtFusXw7H7N6H60BtA+cMC1djFm4001LIoXygq4jF3qCtWn7oiEIDdFbh6w3KgE4yY1GWaSEfHaFlOlog3C0o8VWg4nZ6c1lKJNpYx2BSAHHDzwWnRu3y/m8ge3WkeN8th3VcPxrbbCEByje1ueOivMt5l/E/mq/A2nvOFoWT7SlFJpgg/5BI8T+n8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(70206006)(70586007)(6916009)(478600001)(1076003)(336012)(426003)(316002)(2616005)(26005)(54906003)(2906002)(8936002)(5660300002)(8676002)(4326008)(41300700001)(86362001)(81166007)(356005)(36756003)(6666004)(83380400001)(47076005)(82740400003)(36860700001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 03:32:33.0850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8f7b30-b73e-4f1a-060e-08dbcec1b316
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406
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
index b2e5494e78..373979d19b 100644
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

