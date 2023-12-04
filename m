Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B5BC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 21:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 615C587712;
	Mon,  4 Dec 2023 22:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kb5Uioth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 021BA87812; Mon,  4 Dec 2023 22:56:57 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EACC3876A4
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 22:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tanmay.shah@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhCflfemcyjyjS2U9NyFuUjp1Du6OetttkewdI5Ec34kGi35tXLi7JWbb+fFLjya3YvhoxagvTG68yW8OwWkY5f8XH/dNLlCdv9OYuLLuLT1d1MHn+MsnRouvbal212SVnFeH+qeHPouG4Hpj7ohe9xl8bgUkTVQ+JFKTEqFsApasiZckvWoLJMgLtlTvjergI7oeOk3YntJrSY2OZ1TclW9iKvXb28r4DLOq7P6ZHE/77fwX5NixO1rVoGbWCikuofkYaY1BbXIa9e0xBe2IBnA4QRekBseX66fBQwNFpTmu+aE4a7YaT7rJ8PStiMUV/XScHzQR8lT1X9XGxKx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TfF4QnOdQmWYFzBDOYpCIJDq32vCDi8vv9IXlxFNIs=;
 b=nNM2i1Bk0EBuD0ha6up8wZKnbhnVXibH60pxLvsU9yRK/4QG4zVSJ7p0fRQ0CrHUMwGoMOkcPyeMBexqRgZ+TsFMWSZEO1w8mQyEhKP+NacL15xNy3wG6nOtYS2662H3iemvkN6Fk4PBlph+0t8NTn5s3OhvnZJt+a2C4KuAHO0pQxTDSNpMbhP2gbBu4VbyoGYYPc3liiIjt/QbuwXKS3GZTZSnFQ8oxSiZ40BpvZGxTyiswglAmnb33fS7fk5hZug2owO9csQb73qPkS2UxZhjyewRetObfT8SkmmZys5PeKyDd4UGnorWk5EQ+nXtvNKVPTtc5p7s20S/uSV1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TfF4QnOdQmWYFzBDOYpCIJDq32vCDi8vv9IXlxFNIs=;
 b=kb5UiothkoDLwH91iW558mY81h+n72FaMkdG2VlDyXnCwN4ffmKtpaSqtY1dxlP1IAOE9o/uZkCdgxWhV9ZdJFiGOQbQtQ5dX1e4XhUco9rLq42vIznfEukMGHkiTBNq0STNXM+MAT1XjUFRh7k2ZOOtdqlEtosog44Qooqi+Gs=
Received: from SN7PR04CA0106.namprd04.prod.outlook.com (2603:10b6:806:122::21)
 by SA0PR12MB4544.namprd12.prod.outlook.com (2603:10b6:806:70::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 21:56:50 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::fc) by SN7PR04CA0106.outlook.office365.com
 (2603:10b6:806:122::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Mon, 4 Dec 2023 21:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 21:56:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 15:56:49 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via
 Frontend Transport; Mon, 4 Dec 2023 15:56:49 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH 2/4] mailbox: add el3 support only for zynqmp platform
Date: Mon, 4 Dec 2023 13:56:18 -0800
Message-ID: <20231204215620.63334-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204215620.63334-1-tanmay.shah@amd.com>
References: <20231204215620.63334-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SA0PR12MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dac8b13-ed79-484b-a095-08dbf513eb4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZsIEl28vg32kx8AuXQ50sm344NiNq3cUZMnKCnMbYQayeO5/Fme1aUVJYbqSbAX68pj+Kogh1RReXRcmuSvvIMlyVlJ+e+FUoJWwmKAneRSADWtGiDTXempC630OI41VWbFh6S4+PvBseheZfno1JNshS0oWw8t9f6dwz6uOJCOiX554hIG7oNjCxnYMOi3sW+gZI6PY/WmAOUBUjOAdzWCuJFxyK4q4sTlr283cj5Pq/WQ6DTYo0hczs8ngxwaqlUlvhe91mSgkf5Mj7FwnTFOJUyiI5oBbqfinNZT67VXl4p16S4a3y0FnGFhJ64SmkXfGKQ1mlSd/nMlxHCU2QB/gSvK5XdfilFkaIt7iX9ZKXb9cNvlF7ebKaDDZD0AaGip90v2rzLL6SHpBzPcSYtpyDnonLRT7fgd6GZ2uziba7IwHNWeBqjOdGBYonhiwNx1xEUb4rVw/+4ikjzD+c3ofyNJ1rRnTaOzIetbZ0lA24dfAL3H6Yxjgu+YI0gKd0xZ6taef2H7BiIlK8Ss7RV88JpwLDcp8ooYR0XNmSwS58jnPdi0pISEty+V2EG5ygUpHzdi8kMCEtJ27m2vOVNLze3M6AbmihIRBNLQ/svzM+HlWBW0dujYRe054zcsa7zDoQIjD5aQ9suF+gnDkiI7uL/lAGHSqkjsVwPQHmJ1lAspM3JGbRuvmtkqlNrhS89xm0OWqw5PoCVzjy1BViAywswfRCvJ2s/OUsowqkXlnhlECHetF1c0GIGLj3CPDIuqKgfz0y5F2BUXZtOZQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(54906003)(70206006)(316002)(6916009)(70586007)(6666004)(40460700003)(478600001)(15650500001)(5660300002)(41300700001)(36756003)(2906002)(4326008)(8936002)(8676002)(44832011)(86362001)(83380400001)(2616005)(47076005)(81166007)(36860700001)(356005)(82740400003)(26005)(426003)(336012)(1076003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 21:56:50.3349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dac8b13-ed79-484b-a095-08dbf513eb4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4544
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

If U-Boot is running in Exception Level 3 then use hardcode
register values for mailbox message passing with PMU.
This is only supported for zynqmp platform.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/mailbox/zynqmp-ipi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mailbox/zynqmp-ipi.c b/drivers/mailbox/zynqmp-ipi.c
index acd0b287db..e76561f310 100644
--- a/drivers/mailbox/zynqmp-ipi.c
+++ b/drivers/mailbox/zynqmp-ipi.c
@@ -81,6 +81,7 @@ struct zynqmp_ipi {
 	void __iomem *remote_res_regs;
 	u32 remote_id;
 	u32 local_id;
+	bool el3_supported;
 };
 
 static int zynqmp_ipi_fw_call(struct zynqmp_ipi *ipi_mbox,
@@ -115,6 +116,12 @@ static int zynqmp_ipi_send(struct mbox_chan *chan, const void *data)
 		return ret;
 	}
 
+	/* Return if EL3 is not supported */
+	if (!zynqmp->el3_supported) {
+		dev_err(chan->dev, "mailbox in EL3 only supported for zynqmp");
+		return -EOPNOTSUPP;
+	}
+
 	/* Write trigger interrupt */
 	writel(IPI_BIT_MASK_PMU0, &ipi_int_apu->trig);
 
@@ -159,6 +166,9 @@ static int zynqmp_ipi_probe(struct udevice *dev)
 
 	debug("%s(dev=%p)\n", __func__, dev);
 
+	if (IS_ENABLED(CONFIG_SPL_BUILD) || of_machine_is_compatible("xlnx,zynqmp"))
+		zynqmp->el3_supported = true;
+
 	/* Get subnode where the regs are defined */
 	/* Note IPI mailbox node needs to be the first one in DT */
 	node = ofnode_first_subnode(dev_ofnode(dev));
-- 
2.25.1

