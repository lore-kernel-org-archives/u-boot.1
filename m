Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFEBC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF076876F0;
	Wed,  6 Dec 2023 10:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J9CDxrwl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B5208761C; Wed,  6 Dec 2023 10:32:22 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA472875EB
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAlQNaSkdmNkd2R+Iws7mbVUmDQOhTIdUi9/1YCCedA6JwLJM84hWeAWNOSf7bH3RgEIhE8PLt0pA8f4t2m5CjnqIkepwdC+SVU7niDpqHHoz9Miy26YIgqrB7nzU/VnGyemBysuduFv8MqNgx1nWKiX7VElstUaDDaMB+QWSejSYybKTcXBC10RPvtMrgQClhGCPIXNVvJZKBNUduxmitg0Lj+UJuO18ZsCTuicUYHSDpbjwdIgCLtx5XA5XycJyZ+FZwnmZXi1D1IoM3La5fhJAHrKOY+73GLnwRcZF6En1CYo7WoWiFn/hOOzwJnJf+2iQHJVOdFDrXAf7/gC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANX0Gx4eC3ZQE+igfD++HTnS8mUZkM08G2/TUUwP0wk=;
 b=GYU0JByt6RaDiGN1qhFA2FAZfbWqVEEF9d6HSFzEnH1SM8k5GekYS4GiHjmptxaam/4nGOGASPlDX388OEyQ2z811MszOWDSVOgnc7/ZOmJ5QbqwWLWXUolfn/3Pq3wYrH1ZPZTy9tNwDkoPDz6NwqaIBFumftzq98Dc3thP52X1qeMWH7xXnPSwpXFs4bbb3ogi4dtxypStkcwxhlkwFCDVECx9ihL7DMXIpjuQ/ORv2quH53Tu/jjGX1bxYJfzlbnzcNbaDIkwyuGohRic/MUpWiXQde+pL8UJUh+sNeLnXmTcxqTWvol74fEyerewcu818fDNGDCQL6dpKBse5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANX0Gx4eC3ZQE+igfD++HTnS8mUZkM08G2/TUUwP0wk=;
 b=J9CDxrwl2rhlG+w6VokPKJG57pQqvWL9nEhf2F6enjT73MPQ8GX8GPL5ZV2Ne28HoA0Ou9sxF9IzMjtZ0zy+a2FwkSAQcAalXFJfRB1SZrm7rW+9erQEGDVJapXDf9aEcCXRa/ScweuFV8Gnb8r0JbSJKPjitjLRShLxa/wfp1A=
Received: from CY5PR19CA0129.namprd19.prod.outlook.com (2603:10b6:930:64::27)
 by PH7PR12MB6719.namprd12.prod.outlook.com (2603:10b6:510:1b2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 09:32:15 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:64:cafe::8b) by CY5PR19CA0129.outlook.office365.com
 (2603:10b6:930:64::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 09:32:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:32:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:12 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:11 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:32:09 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@amd.com>
Subject: [PATCH v2 06/30] mtd: spi-nor: Enable DTR octal flash program
Date: Wed, 6 Dec 2023 15:01:17 +0530
Message-ID: <2155cd92f92b60ae7cb53b2323dca01c9bd9ba45.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|PH7PR12MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 20022f6b-2043-4cf8-da76-08dbf63e3bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4v1OD7DzXgDaDcNpCi4et3utsti8Ddh5dV9sWTYEc8cljJ28VIE02hrOyski587tXTBO4RSUlKOEjl2Ctwd3wPodZZMOuTxY9k5r3hvTo3eOMAzeYAHa5CzawnBR6x5lo947UyviEygXH7misjoOuH8NsgJN1+SS30yn8Cv9sDOSa/gZ2BVZtTyNCk/xb/+l6BIA7sAQZ+ljgaT1X1PPtcTSKdNIc/7twsftNQCKBrYZyfFs4Wzf30Xze3zuZblUhDYaTP/v91wFU6qjvcBIvS0yB69NOOToe+igAePKB8BFpfRQWjnIIZsbAw0q42pvpFqb/UfED/ugtfVjWZouVhdEQ7UdN56ElGpsfy9AS4HwI5F/LSQrNEOosnS+BugXRu/mMcMwNEqkcK7hakVY6/GHt386yNn3ECJj90hTlQIU9sfu0yuWQE7VfAyKZz9uucpD4WmA2dKbbtnEOAjqY5wKntF/8w2G6sdakIURbh83hLH29XXSCeWw23ZrnQw/6MpkV23z4ZAsgmdh6UflV7bS2t7LJpCQGRsQdg0MgpXc6WShwpHfRkD1hQGwZKAnsaYyYSx3B+qjugxedN8wrl298Yx/SFeg24eLMgvAGbRKS6jJybBew2h1ZK1ynciloVD1iVuSlC+ekOHyTKezQk7xB+VsYwcwW1QszIHiIziV7qhgm3hFX/4I1fMbcUzs0XPHdfSR4nNeRkevx9SDmmKVdAr/SQGjoYn5yaxHoo22gzyG/6qKsCDnjjx0+kuR+UwHNLvPqmYdrVyPMAlVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(82740400003)(5660300002)(2906002)(36860700001)(41300700001)(86362001)(356005)(36756003)(478600001)(81166007)(2616005)(6666004)(26005)(47076005)(8936002)(8676002)(70586007)(426003)(70206006)(336012)(6916009)(54906003)(83380400001)(316002)(4326008)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:32:15.4476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20022f6b-2043-4cf8-da76-08dbf63e3bdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6719
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

