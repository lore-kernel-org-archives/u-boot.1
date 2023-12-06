Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951F6C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 168C286D85;
	Wed,  6 Dec 2023 06:32:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fEQfkOuV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C0318644E; Wed,  6 Dec 2023 06:32:39 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D008876BA
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVXt8aE2OqCKVGZnyaF11FirLxsIhl4BSk5d5gpyOe8OIsK6VLNC6hBH5r3B5C0RkGSZ/5jmNPRRmOnZRQeHyR/aNJboEtwLlKOw3cjIvXXsK0AST7LPEUvZOzj8mIr3TYqyL049HpNJQl3rfQqj0d5M4QjDUfeqLSbamtEJTvghxCvGe/Rdy6VrzC9hag7cq5GJOxiCDImYI6dP4+Ez+Hnu44R8TthgObCJjU9h/TY/8qF01JSq2j8INMUXFRSpyZMlSGnrghzp6obOaSRPzKUyUcO9eN6WaPrORvuDm5kDJom9pqDbW6kz+1LmPN7K8SRHKvS8vZiZGV66NHUG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANX0Gx4eC3ZQE+igfD++HTnS8mUZkM08G2/TUUwP0wk=;
 b=JQmvfDiNAaOF5w+h7NBXZRHK7XweTh+dopxaDlBgq5hm1aff0axf4oXa0i/NXOka9i8nYUXNm1sXAulxFPu02p7tXp8lbXoNkMoy4lgRSiPR/ca1TrcKmPTMIhD3BUe89QWfc/p5VOrjbi+bpWSnsIGc2xn0CFjXkLV4sxuxZ9klVQMvcdKyi3fVU+RraDA+ra0FvLvH1fb8YOWD9//rO4S1vyhBMnYrZIg9urTN6KCNCYT8XxuRYE1bzYc5Cpnl/6Ghyl2CKO/JWFvxNm+AAKamWNKanMvNjH9uLdHRgw/12YvEMcD0s0zFBz3V7h2xCZVQd18QVjtKuYyuEldumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANX0Gx4eC3ZQE+igfD++HTnS8mUZkM08G2/TUUwP0wk=;
 b=fEQfkOuVMPiGE+/wkESmt+7jwK+72MSad3BaH+KWfI5tOWXetB652fg6F4Hb9sRS6gZurYuKYNcQaOw9FIpjbXtNCP8IoDgjlKO2CpacJfck2OdymgWiR4CtoLELcLIBz/4mZVQAIIlmANYEdaDHbSo7WAeHXwpA8kMmvtXR8i4=
Received: from DM6PR07CA0130.namprd07.prod.outlook.com (2603:10b6:5:330::22)
 by DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.37; Wed, 6 Dec
 2023 05:32:34 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::b6) by DM6PR07CA0130.outlook.office365.com
 (2603:10b6:5:330::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 05:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:32:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:32:33 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:32:31 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@amd.com>
Subject: [PATCH 06/30] mtd: spi-nor: Enable DTR octal flash program
Date: Wed, 6 Dec 2023 11:02:24 +0530
Message-ID: <20231206053224.3745273-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|DM8PR12MB5414:EE_
X-MS-Office365-Filtering-Correlation-Id: 695cc1cc-00dd-4f1e-17ad-08dbf61cc00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xWjzHopwY5Onw28cbARm9RUts65czVS9SJznMg5cpiHI4lE7u+b1UHtqSygOk+HDhdX16SucfcjK+8EKmo6HoH0qoLweq4709MW3IxN0eksD58YYUSoBwFd/7o7i4wrixTRE8/dYdkokzFGGVRf38Tanr41pjfevnSCIxF6ILczTvfGq0LudnhXsFOMxZWOSjhLjkC5hBY5PxAChbDLm0i5NvMzX2CGLypTdN10thEhWXWMChn8LdXdyUAkux7BwIG/tt+l25eBDcxO1iqXe1Iscys/4LcHvlEPWjoYVoYG28Hsz0cgY07a/f37Q1Nb0JojLCXH2UQSG27Fmo5x8fR4OGTAZ27xlYSBEKX4pVJDMPuPB93Dsytni0AUCPhsocXZvkefeJbEXHwQEQV3ACJeXakZtEegGTDS7SpteDXEq/+BNdxv4WuHlJIozf61COgFwDbHDAMaXj07TdZCwP2P75R0LBcnUoqkpcfV+cx5Vqqy/uM+9WsZQg5HF8EIBwRr8s6indbUzYTvvwLMCNgi4c/WrXPH/n9LeleX6fZo5uSEpz5vn9fuwmYXFfgy3gBqQEDxLzQlz2SYWk2AIwFFs2+GpT/3qYNMRJ6EmeTegqyE0ScaX8JMibHkoiME3wJeREqEgXNDwXRdci6641ixW1IgWcmdwJrKPBldzEyV1gI/vFwRanR3i1t/EMjPPE3/j/rsWmRMsZj0gynXiwhEPWaVGOTUKnPv3/6IjE3aYo+u1jPEgD1LUidLAnDeuHdjuPNuqDWOGexSC/oQxtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(83380400001)(40460700003)(26005)(1076003)(2616005)(336012)(426003)(36860700001)(81166007)(356005)(86362001)(36756003)(103116003)(82740400003)(47076005)(316002)(70586007)(70206006)(54906003)(6916009)(8936002)(8676002)(4326008)(41300700001)(5660300002)(2906002)(6666004)(40480700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:32:34.3564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 695cc1cc-00dd-4f1e-17ad-08dbf61cc00d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
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

Define a flag SPI_NOR_OCTAL_DTR_PP and if enabled in spi-nor-ids table,
enable octal DTR page program in the framework.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/sf_internal.h  | 1 +
 drivers/mtd/spi/spi-nor-core.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/sf_internal.h b/drivers/mtd/spi/sf_internal.h
index d3ef69ec74..9c09f97ce2 100644
--- a/drivers/mtd/spi/sf_internal.h
+++ b/drivers/mtd/spi/sf_internal.h
@@ -69,6 +69,7 @@ struct flash_info {
 #define SPI_NOR_HAS_SST26LOCK	BIT(15)	/* Flash supports lock/unlock via BPR */
 #define SPI_NOR_OCTAL_READ	BIT(16)	/* Flash supports Octal Read */
 #define SPI_NOR_OCTAL_DTR_READ	BIT(17)	/* Flash supports Octal DTR Read */
+#define SPI_NOR_OCTAL_DTR_PP	BIT(18) /* Flash supports Octal DTR page program */
 };
 
 extern const struct flash_info spi_nor_ids[];
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index f6e7592458..63f78baaf4 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3026,7 +3026,8 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	 * Since xSPI Page Program opcode is backward compatible with
 	 * Legacy SPI, use Legacy SPI opcode there as well.
 	 */
-	if (CONFIG_IS_ENABLED(SPI_FLASH_DTR_ENABLE)) {
+	if (CONFIG_IS_ENABLED(SPI_FLASH_DTR_ENABLE) && info->flags & SPI_NOR_OCTAL_DTR_PP) {
+		params->hwcaps.mask |= SNOR_HWCAPS_PP_8_8_8_DTR;
 		spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8_8_8_DTR],
 					SPINOR_OP_PP, SNOR_PROTO_8_8_8_DTR);
 	}
-- 
2.27.0

