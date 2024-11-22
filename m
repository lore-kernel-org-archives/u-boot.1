Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4F8E65D3A
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 09:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B643897D0;
	Fri, 22 Nov 2024 10:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TGsiPEIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC57E897D6; Fri, 22 Nov 2024 10:26:38 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83E7589384
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 10:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSurRVUjhn10RVbdvqxPFxzWx2JloGrW4c6cK/e8lF0+ZeEFXCH7o8LINzZCRfq5QWfDap1PNbFCxGRXu1FXpeZnie/t/PGwP/YmhR2TKGvmQitFooipgdB0iWO6vpf74e3re7x0QkbroYdxI1y4Qys1dg01a4l3HkO+tfyX+fRPZGDuUCJDk4S1KNOHTiyMcDZfZac+q/1s6qTyJNJ7w17GPlazi6Kqpd96hfQec1zv+fneugEo6JYU4WQrng506xn3CXL93GbrJbsvbf4IPsgictk2Adctxj7KnfMkHkbKi7ssZDbJfTrjiL92fzTK3AkdqUix15Yn14KA5fOX6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cnMTM3/AZCNx8w3mD6oLLu1iOVoMDimG/J3PhtE8Fk=;
 b=Ih1yV2vgGqFtV4BDY0VNa5/fAbm6cNzV4Bm2po9kknVsGj39OKLqDKpW8dcHQ5g4Yor5WgnRYd7thhpDAj4AxDmLWKlzY5hHz2n3RxqnANjk2DCQrvMTFLX41Apo9zkCERSMbhlH8anKLZxoN7UW7PaUt+3yZjD186lX/5qQLxIxv11t2N6mdk8TVhPmyb+qGInyss8wAeXCDDoSZxMQ+vvaObyfeNjrsfhD0u7tHW/SOIuNI9CAFv4TEVrw1oGaMGHJADUCz3kgeSaSoRDJIzmwuxu8O9vTk9MfRksONUZDIsjllG2GkCwkQ9AszRGZTKEyNVCtPsgx/ELd315c4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cnMTM3/AZCNx8w3mD6oLLu1iOVoMDimG/J3PhtE8Fk=;
 b=TGsiPEIaZ8CQuKY+13+iMRF5BSJ+2nchErULcSRazGlK4aitCo29TdQaZLwAQwYfDX7Mc+eowsN/YMt17Gw4u2vDs8Zb+ZlGMSfBbM8fjEyLaTg8a5xUmBw1rSqwk81AnTaPM7pnwloEA3eZjyeUMJJEG4OYos2LCM6RJspexQI=
Received: from BN0PR10CA0022.namprd10.prod.outlook.com (2603:10b6:408:143::30)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.26; Fri, 22 Nov
 2024 09:26:32 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::ef) by BN0PR10CA0022.outlook.office365.com
 (2603:10b6:408:143::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Fri, 22 Nov 2024 09:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 09:26:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 03:26:31 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 03:26:29 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 22 Nov 2024 03:26:25 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <j-humphreys@ti.com>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <tudor.ambarus@linaro.org>,
 <Takahiro.Kuwano@infineon.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH] mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx
 flashes
Date: Fri, 22 Nov 2024 14:56:19 +0530
Message-ID: <20241122092619.1376234-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: b9779e17-fb27-486e-ec58-08dd0ad7c068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RCM7XzMVX2ZochEfknLxgWrU7q7mPijQvnnYmFZyUroVYlFhAkGxX8QIqPoH?=
 =?us-ascii?Q?JL0GH88f0FbYb3bfbMvSkVYEmvPzh7ZEjxIuV4FUOc3gb87nYAbFM21pF7Ny?=
 =?us-ascii?Q?2/5MqqVPIRbsYNzhQPp9YErYcFqSo+Y9ObUh2SE7CMnMQrhW735Xml4nRf5j?=
 =?us-ascii?Q?NWtdLl0ueEXPN5Td9OJcILwp2LxvBkUf8NJHXBY40c4uXN9yXzi9dVZ7AFFI?=
 =?us-ascii?Q?ZeplnOST7s8N1OPNwlrl2km4EepL3AGWCaPkRF7x3tqzAJJJ1tC5kGhONXG4?=
 =?us-ascii?Q?mg/qAThYf0ZOY+U9OhqorndI1oItZAS9ItDv8YwQUpV/S1xlkGdHFPKwoc6q?=
 =?us-ascii?Q?KpMt1V9CsrxaES12np47SoGTqhO2e2Gcr3o2f5wt5mCHu171teI4ZvPeX8BY?=
 =?us-ascii?Q?qvmbDNIn5juEJxfP6eu7Rsa5Nlf2f97ihChNNiJmAHDpGaX6AElVrgeGUJjN?=
 =?us-ascii?Q?4YuK8e060XxYcWi3QalG4PmKEpBgKlDiucAnPWQ9ZLzLHVIxHd2t96XdhO1S?=
 =?us-ascii?Q?1i3p1EKBGFoIbIdLteZy9VXeD0YQV/2BbnsbNjEuOsIdK297FkDdgro7TijU?=
 =?us-ascii?Q?l158yGJqgdBBvAufmP3NuOl7Gp5pIvK5qinjdkjH41X3j2TvcfXdrhcg4rLD?=
 =?us-ascii?Q?L+h7ZoSYX0DFgIl1Qo91b3pvHYDz+szsp7k90jeMylAcZ2Yt3X8EJxRJwti5?=
 =?us-ascii?Q?keax62L6NBek/TtwwRbOHo43ulraDRLTOQBaDb1ZpZqxZV6xQjw/7oUYtLIS?=
 =?us-ascii?Q?YMCKaOhjaPeUmPbv0RSox+caDPVle3S4Vqp/4bDCb/HH2lzeXs3jRWNKOqtR?=
 =?us-ascii?Q?J7lsIu3Pg2sMgDCi6PccjO8TgP0LmMlEji+K6+Mz2pI6Jp+LBalallYyF+AJ?=
 =?us-ascii?Q?ZfMoXL/u1iQHcQ7xCCwMlSI/GUBUvbrVZEHZfuKFI/0KtkFaKRFL8ZUEzg3d?=
 =?us-ascii?Q?UsonTCAIzJVwcON2tNTehIuYL8li3FOUQuqGHeO+JBuqJ97eXSleDhBZmXet?=
 =?us-ascii?Q?mELUWzJlGorbJXawdT4+g4G2T5pM6zBRBlyvd2aqRxLx5S5VPOauQ3cWLPQb?=
 =?us-ascii?Q?3Y3zapfkHe4FdkgZ4SEZzLkxNsKhwczFOPrHzIG1Zgg4HdUEeaNMDl9UuOjv?=
 =?us-ascii?Q?B5llMQj5+zEuk5Wt2Pp0gxhD4ZbHlRBg1ZVxPD2Fe0/XJlsZFCjmE7dYrDGi?=
 =?us-ascii?Q?KDy181bfFHlQuxzuDXyRy8Zs0zA82XaF/WdJqwa/ZX+RwXpEJ4PaofoNMCB8?=
 =?us-ascii?Q?oCRjI58ABxlkaaauRVr1b1t73y8RVfAVWIsQZETiXnzkCccfw/Iq1U7XP0sn?=
 =?us-ascii?Q?XqwgL9nAVSiZ80JOlKpAKaWck1AQzMTL6h8Pl3sbCfu2r7Vj7OLF0kZRAl0U?=
 =?us-ascii?Q?xuIcaoDPMKDcJ0R17CWFmyvR1AYAGAWHdUYvaoQraPwtPAnVqg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 09:26:31.7889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9779e17-fb27-486e-ec58-08dd0ad7c068
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217
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

Enable mt35xu512aba_fixups for all mt35 series flashes to work
in DTR mode, and return after nor->fixups is updated, otherwise
it will get overwritten with macronix_octal_fixups.
This flash works in DTR mode only if CONFIG_SPI_FLASH_MT35XU
is enabled and SPI_NOR_OCTAL_DTR_READ flag is set in id table.

Additionally, a new flag, "SPI_XFER_SET_DDR", has been introduced
to instruct the OSPI controller driver to switch to DDR mode.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 8 +++++++-
 include/spi.h                  | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ec841fb13b..8d201433d5 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4073,6 +4073,7 @@ static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor)
 	if (ret)
 		return ret;
 
+	nor->spi->flags |= SPI_XFER_SET_DDR;
 	buf = SPINOR_MT_OCT_DTR;
 	op = (struct spi_mem_op)
 		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
@@ -4404,8 +4405,13 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 #endif
 
 #ifdef CONFIG_SPI_FLASH_MT35XU
-	if (!strcmp(nor->info->name, "mt35xu512aba"))
+	if (!strcmp(nor->info->name, "mt35xu512aba") ||
+	    !strcmp(nor->info->name, "mt35xl512aba") ||
+	    !strcmp(nor->info->name, "mt35xu01g") ||
+	    !strcmp(nor->info->name, "mt35xu02g")) {
 		nor->fixups = &mt35xu512aba_fixups;
+		return;
+	}
 #endif
 
 #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
diff --git a/include/spi.h b/include/spi.h
index 6944773b59..d7fef36662 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -164,6 +164,7 @@ struct spi_slave {
 #define SPI_XFER_U_PAGE		BIT(4)
 #define SPI_XFER_STACKED	BIT(5)
 #define SPI_XFER_LOWER		BIT(6)
+#define SPI_XFER_SET_DDR	BIT(7)
 
 	/*
 	 * Flag indicating that the spi-controller has multi chip select
-- 
2.25.1

