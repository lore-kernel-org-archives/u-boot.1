Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963A9C5475B
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 03:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D205C87F63;
	Mon,  4 Mar 2024 04:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QbQvUxiO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 097FC87F5D; Mon,  4 Mar 2024 04:11:08 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0360F87F58
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 04:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dX0UfsHl/kkPbeWL82XiUxLLEvFNzbzN9moHSmT3mWUjnJJOMHYto+eDnpBpBaWMa3khp1I91S7XUe4y3eexNSw4tCoagBsMwO4LYwAS3wdRwGw1TffLqxqk5/cHdtW5nStH0Hq8JjWFeOktdeIEXjuFW5kiKnO/z8GKYM5BwpH18jlHuINRQKjkGqo/cqHKK3DBX2E8M/3k3GvDfVqGfHM/mPQjzstpyejgKIxB/cLZLPf1CTka5hXSJsGzfIJ96ILaQJ1vCaamo14H9nD+OyA8r0nyxX4JWsZOtCxDiJRG/lSoZK70CcsfZvkAIylcu20Vj9WB/uAepRmH3JRbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01ZQIDAx8U6DvLc7NHbRrUhOjy1ljzOB0BNZ187IREI=;
 b=I0NivnFj9b/ZrVcdkvhzwNclW5tE0ulVwRhOc4Su1vn4BHauPZpB4ovyAa20IL8n5BV/87mZWeY+yiKLeCNhsBxgPeeh+YL9vOII9NXouDcsQtxbfxZABeGPzrgofVwdzVEdj1UBa9Kf1OqPMer5UP57uvG0Ty8ox+70lkQBKHHPjGKMWOMDRCzrh8Q1dKVefxckfb1XZoQnJAyLUfA/hjllOopI4W6whDIB+wmkyTV6kvyu2Xl4Ks2VXa6l0fCCuNP5rYzOWivw83lZpKWOtIPrhU462k7nuXm4WOJ17ZbOO5OSyMr3QL3Zoc+7z5a2kezFrlNGIbJ5HEWxhK6vTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01ZQIDAx8U6DvLc7NHbRrUhOjy1ljzOB0BNZ187IREI=;
 b=QbQvUxiOSe6z0iHzK64QeTKAZryahNS+2JaiOVIKR72N2tQ5eBMVf61JAjHb2m1NvosWWeHhzxkpeizWnlQcixSGPIQfkAVnbn2aYasV8+OyMCBhcdW23uC65DW7zFxZ4d1y2gneFp6c2cyXtS61UtYwOtdwCEHB6KXDqVPNHpQ=
Received: from CY5P221CA0123.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::18)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 03:11:03 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:1f:cafe::db) by CY5P221CA0123.outlook.office365.com
 (2603:10b6:930:1f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Mon, 4 Mar 2024 03:11:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 03:11:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 3 Mar
 2024 21:10:59 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Sun, 3 Mar 2024 21:10:57 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@amd.com>,
 "Ashok Reddy Soma" <ashok.reddy.soma@amd.com>
Subject: [PATCH v11 2/8] mtd: spi-nor: Add parallel memories support for
 read_sr and read_fsr
Date: Mon, 4 Mar 2024 08:40:40 +0530
Message-ID: <20240304031046.25998-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240304031046.25998-1-venkatesh.abbarapu@amd.com>
References: <20240304031046.25998-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9cd835-7e42-476a-9f8b-08dc3bf8b9bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+cnZqohdWphqSJosVvGp2yz6+dDzeYvWep3zaPTO9Al13/BiHZ4qqao6fMJGGqn2mcXm5PO94vAcZU4tzTucbs1VHrRhC1WRWoDe5+TPHjMDoJU1PQp78sRZ3MqrteLJ22xW1IqlXogWD+XsfrzkjBP+rzNYEiUMgBxJomm0lR4Qqn6T1747PMgBtWcgRxGWcfUac4PlWLGY4FsJaC0MB5A4veVUI+uN04OP+eDqNzLkRgSseXoeex1Mis9O0CFFxl7WW1tktCec/AQoXs7S9bb9u3h711iw6v+por/8OA1IOX54FygRcIoofm21FFjcdaScdlJ3s8LqVodVev8BkU7erugvePlGJeJIs1bTmiCna8NW+9VCLVINxsT0LocyIXwXZ8pZ+ZcHz71SMae+UGHaWJT6O0usUWBSzlYbtS68QyrEdDvVp6cAPOqNwuIm0LnCF8pUHBuoqv1fGe5AtEl6MBVnR8fMactG4OdbOSLi167BC/cRzblnbeqUrEUx8DC0cwDJwWizm9d+T86cjyn0a3qf3izJ/wfWVeIoJDLivUrHp8jFeJKM9EJvKSmn10NXOvn59mw3Y9iLgnvFhL7FscgB9A/07gOQp/ySE5yPQA6dHlivZC7+TWgkOKLPjPWsCUGcjDJ5iYmSQrtIN8NadalLI8RkacBnlh1J9AE/HKMsxblZ6bqx3kz9hbdLjSzEbPtXTzMi126atVuBA1Ln+oHsihZKwb7kckgpa+NLmPuQ3CmHHQy7oC5Mu+P
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 03:11:03.3101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9cd835-7e42-476a-9f8b-08dc3bf8b9bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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
index cbcc1d1a31..9c55b424e1 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -462,8 +462,9 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
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
@@ -495,18 +496,29 @@ static int read_sr(struct spi_nor *nor)
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
@@ -538,13 +550,23 @@ static int read_fsr(struct spi_nor *nor)
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

