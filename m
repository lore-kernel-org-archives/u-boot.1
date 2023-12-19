Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C08C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 04:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E985B86FD5;
	Tue, 19 Dec 2023 05:16:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VMre3sga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4D498715C; Tue, 19 Dec 2023 05:16:18 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7D9D8700D
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 05:16:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPxwY4yaliFOTXiqFjriA1sm2EjOYhNINtnsJf0mvNVuJNQNLVQtXt/asfQBrOJ1GAZk7EuA+YYhtTWD/Cy/cF9xDmaGUgTS0wHc60FwfDPuyoN8947F2pyuImQ/61n6DjfuuO931H7rUkB1CsFqfqqk67TBpM/wTFcFnPEozcselwFS/L2iYsRkzRrrdFMN2Gc25rTurGXu3gAOUCblz71BonqrlcCJe/+HCkZbiPrRpc3M8bhNVesBs5tUyknPl9ARbyWpC9DLPVQ3Jq98WWO8IX/eG+CJfanU03SD1ERS1RtNlVMHlMfV8VKAG/rc5YC3Fo6kESB5riwF5R8lzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UA3Vc5eYlJ/8QrYP6EcF9tM5UmR+9gpJ0T60mhADKoM=;
 b=fGR76K1v3JMm8i4aXOJrqNlixIeMdwdXTB0/Yk1Vw4/bKK/lMFxspJ+2qoGtHM0X20zVMxjEC8cP7FqXwdguUHcs6wmDYMgOfJOPu/EMPCSCWmwotxb+QQZpMB6KP5lwJXdBE31HF3qye2wSuljkoqjmZU6GlZP2FdNT/QhdVu2bwvjYBvMTz8z03AJgUOPLaDXTNUgC01rzKk10Oyore91wMNc9LeEITRUEX0LjD/1aXA8CaPe9DM2AwQ77OirPxTgtj1SuesX311Qco9ox33kcR++ouF3A64whXNvL8NITn1xaFro3b/Ix/Xx9CCdINLpUEKegppLNdkMQhX7QCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA3Vc5eYlJ/8QrYP6EcF9tM5UmR+9gpJ0T60mhADKoM=;
 b=VMre3sgaKGyo09DEuHiwKdGEfZXTFI7Cgd7CF6jlHHfZ5a3zVqRElioizsw/UoVqj49HPK8ZoGRTYj58pnJM2VaN8/tnKUMEXH8qUEGL6fmoWlic7+2N6M25NhchrGZYO6oHCyK7rYYotFqv+SBEcUj/81L1mX8UK1cG5hOC51k=
Received: from BL0PR1501CA0015.namprd15.prod.outlook.com
 (2603:10b6:207:17::28) by BL1PR12MB5755.namprd12.prod.outlook.com
 (2603:10b6:208:392::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 04:16:09 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:207:17:cafe::ce) by BL0PR1501CA0015.outlook.office365.com
 (2603:10b6:207:17::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Tue, 19 Dec 2023 04:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 04:16:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 22:16:04 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 18 Dec 2023 22:16:03 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v7 2/6] mtd: spi-nor: Add parallel memories support for
 read_sr and read_fsr
Date: Tue, 19 Dec 2023 09:45:33 +0530
Message-ID: <20231219041537.1240070-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219041537.1240070-1-venkatesh.abbarapu@amd.com>
References: <20231219041537.1240070-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: fe399d4f-f2ec-47d5-d9a7-08dc00493a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aE4vOw89kRZ9jdfg6MxllVngzAtoys+yMEcIzppAiFFxQ5oLAmjue4UUJkPcfEdBlWD3rfTLMOnXmqoQSn1fObd1EqzV1V18mGWEa83rkBaroSfX0Ceh59x7BJcnBUsbrawwCF/Cd09nZpIZ5f5qIKSgAYGwGKT3fMWw95ts9ZK4wQanuqnJ8V3CHHBhVFroaiink2wx3tqxdF9AhteOQDcGZ2iaRkwZxC+bDpXWaeLGj+C1TWufBE3mXJYZiytWFO5caO1IBUfDxAj1Iqwz1XtXiQOBofaRjnY2jYN5qXGbWLcV+XTgoY61hBLx6oe9UN42uJ6EWb7tkLuFCUPS19DxHLoDEcu914oyR7CawSCeF+xCebWGpPpEtVR6AWCIqtBQyb5uBwGZn4jdM2ohMnTa1CvXxXo/oDFKPPgvxK1VKqKvVEF2Fz5Srtp2TqDhwPf3e/v3JSHVoWA0QOz6NCiNE5W4LuZcEsVHw5KEEKo5uF9upqC6S07FGjotuCUiSOpYUNZ3NjILbmiO8kfoVt7QdcNGWwCmF+dDgZ4qrbX04ajJX4b61M2NGk6T2M+ghKwiW3ZUXdmRMvFevG8gWioNpp91nxxf9/2dQIHkjZJSfPdpDSGe2AnubZwq6MkGLzEM+HJprDs5dMKbzIjsC6kiZDZ2ICSsrpykbOmZh8AL5uLoLXYuDli1R0zA0hjt4QU2WtDv92qmJsePyjiuXa1ogDrD5jPSea5z9F1TxwX6hftmCX9sEoQYXd7hbHkodaLNTdr8vy3Is9QCXA9ITA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(36756003)(41300700001)(81166007)(86362001)(356005)(82740400003)(478600001)(336012)(26005)(426003)(1076003)(40480700001)(83380400001)(2616005)(36860700001)(70586007)(6916009)(54906003)(70206006)(316002)(6666004)(40460700003)(47076005)(4326008)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 04:16:09.0288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe399d4f-f2ec-47d5-d9a7-08dc00493a50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
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
index 08319a881d..3112f93af0 100644
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

