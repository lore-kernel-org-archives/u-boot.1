Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC28D65C45
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 06:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B9DF895C2;
	Thu, 14 Nov 2024 07:21:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K9rd2BuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADC54895C3; Thu, 14 Nov 2024 07:21:04 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D87895C1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 07:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaHmPMRGoYILrRlFdWopikP8kJW6YNQTfzd/l5i0z8cp/MkKG0WjgerzSsqCecbaEQhOHQgKIzsTmdPJLK8g/f40GMcIIb/bbTos0SOMQfO3viEkRzfZJMS6rm2y9Mnky6aMnRtyGZ7a6dFXpIolEDwsUbMN9VnshUlNQUBN3yLvv0EhHWR79oth8JXZ/qtBs+u8iXgbFtyhu6xyqhdlvU956vUsbGom5Xs/ulmh2zm+GITVGnGpeimLHp0zqa8Tzp3OYqJe40J7QP7756Uwn9e+tbU+lsBq2/nSR9v/O9rZB7iHlfticozU+yM0Q2PC+01+iuw08LDcP1AM2/L+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMr16rlkYuhen1Bqrf1d4Zv6qcBwYc5lughsDb2h95M=;
 b=uYWb9SjPoQiGxHcfU1CXxjxSKW0oeTxzxqvHffkO7/ipXLUjqE9s/8M1jlQNRZ7EJgLOTtVVYm9JLdc8V4WmCg9/WoVS0uV82hkYKh9UvvDk8UDFjSBhcJQLZ5fdHrYjyOQ5Ohp4zE2wGR5dgwxBBUW3PWcPHLTOzt2jn3ZReIpnHSAyBWH+qTYsmHxOK06xmmvWs4w6Qge0x66Fh9v878Kd69zekuTgmUaEL7IQOGGs0tOB9jYwFNXUEr5PgsZwfnxMmAoyFBgfgkVMvMp0WKRXZfAQriGvoboMS5XzaeVi2a51AwovCzhDytOnYil/yhsIQsclsfsUJJr1jkhDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMr16rlkYuhen1Bqrf1d4Zv6qcBwYc5lughsDb2h95M=;
 b=K9rd2BuDH73oVfF+p2aevGPH8FEzGKoWKauEq8LKdf14fd+QfgI3PUiJKjtP00/X6bKVdiMpPRtS/hko0H9RFVRLbVKEEUlHqZsx2uN0RfK642+s2Hi98ytmnuUuY2IwS1NRKDsZ7AIT4ifHTw032bd0cbLJRT/mPszpH6uGAd8=
Received: from SJ0PR05CA0170.namprd05.prod.outlook.com (2603:10b6:a03:339::25)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 06:20:58 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::1a) by SJ0PR05CA0170.outlook.office365.com
 (2603:10b6:a03:339::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Thu, 14 Nov 2024 06:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 06:20:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 00:20:57 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 00:20:55 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 14 Nov 2024 00:20:52 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <git@amd.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>
Subject: [PATCH] spi: cadence_qspi: Fix OSPI boot issue
Date: Thu, 14 Nov 2024 11:50:45 +0530
Message-ID: <20241114062045.17581-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c37d081-10bc-4690-90e7-08dd047480dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U5UYRV3bMt7Yzw26rcERmMPEUAG+NC0SseTzb1ugFS4pat7PlkxVU7erCsPA?=
 =?us-ascii?Q?W5GphcDc8u/JAuy4GsMNk4NR226vCKul7mvfI/iV7OBlTaTUDq1beoM+1Scj?=
 =?us-ascii?Q?ATCIuv5v2WPa9pp+2DNUVhHzy+csdB53IpbfzOBRhLNl3H52YuSbYNOvq+KJ?=
 =?us-ascii?Q?YrgqdzFs5SrJYg89XVJJF5Kevz+AXkDRuTQep91sQmAZofghWQh4WbA+h1lO?=
 =?us-ascii?Q?sWoz/SPIaJ13OFhdyT49/EFzlJeX8PbMsYRSBDpza9xUypg75hI4J9iIprkE?=
 =?us-ascii?Q?t41hoW7Cl4+WHxxn4D98X3VChs6cV5gSD7khpme1ssd9l4hamq1lSmLt8pYU?=
 =?us-ascii?Q?QD/SUvBFEdajhQ7zhmljoVGqaicRYGfClkk4G7Fngi86aHGWK7rmbbvZ6nj0?=
 =?us-ascii?Q?gskyNec2ey1fQV3hSSEB89/9404tesP3ZUUKXQz5GZCf9+7sYn/m4z2g+0ez?=
 =?us-ascii?Q?ZfwciicKccAzNGh6in3vUL77nWE3ERTdBR+T2Axj5YbfzoVytjFgwUogg8Jl?=
 =?us-ascii?Q?rxXqbgBK7QifsnAEukFlsFFpnJGl279ivyaG5IDPDOx/hdi+8T9d6OFBfiwc?=
 =?us-ascii?Q?sCW/MQXBy28c04HKGSyQQhjFIDXFfadMU6i06nl+kWDc0JdyZ8HreU3xSBAe?=
 =?us-ascii?Q?067rRIvMZqXQHY/KKuLP3qTXNT939r8wS5nKttWFA2hZCKV/oZCH4WNvUB2N?=
 =?us-ascii?Q?VLZmHywh0DLxl30UR86aGuMlrBNvlbWFjWZESKdcZvYL+ByWtBzgDBYaAKwF?=
 =?us-ascii?Q?wU+N5Na9iGKedPzE9djQkNhR16fWj+t+EFEYKnzidlQGxX5gmXR/6NCvBgHr?=
 =?us-ascii?Q?DEzZUKg60zDdxT9Bnis1zLUxUyRDcp1uECwuPbuuVMHZGtZYtS09RKOb5P+I?=
 =?us-ascii?Q?FQnrQYuTjkiR86An4rSD9ibPaA56dNUN1S1Zb3W+Fta8Rg+A7slZR8xknskF?=
 =?us-ascii?Q?gtLggG8R3GUTh8eF0H7vaUQetb4RgE5UiIdeoQLVBadBmFTQPiT7wm5OnoKe?=
 =?us-ascii?Q?Ea3Udk/ZWBxx2toyJqF/Bn7WvOktKpiCcEaYSHzKlUsxdiz9BPpe2WktJNdj?=
 =?us-ascii?Q?8TM3BDfuege/vPDajASh0yviKugQeTI/06e4nbWkd6Yq/w38dC0jrO9No5lg?=
 =?us-ascii?Q?MJMJE4vA6n0pmv7QXarj19PWlStWlfrDdUhoL+/JxE/VU8Nhn1PttqCbzkAE?=
 =?us-ascii?Q?DyID8l3xsbKw3JgjtYrOGRgT0Do+aJ6cltY+XHfe46Xnk/QM247FcnqtgOqm?=
 =?us-ascii?Q?XttiTodjJ5k97T3L51FL31dHBzWB2YeoNO94Qm5ELjtsohN/PvYRKK/iB3pz?=
 =?us-ascii?Q?yNbwOXexLvWf7Qv/k8y4FGkdV6L7I/accwM/riqGTlTCmmknCFU8EOYyLJiF?=
 =?us-ascii?Q?bRu2jeeS4OjFJ9JBtn5HhdPxBIhp4WNP9qyD0LgdjaFmE6Pw5Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 06:20:57.9259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c37d081-10bc-4690-90e7-08dd047480dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943
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

Moving the hw_reset function from the controller driver to
the NOR framework has caused the OSPI reset not to be triggered
in the Cadence driver's probe function. As a result, reading the
flash ID during SPI calibration is incorrect, and the
CQSPI_REG_RD_DATA_CAPTURE is set with an invalid value.This makes
it unable to read the flash ID properly.
To solve this problem, it's suggested to skip SPI calibration and
instead retrieve the read_delay directly from the device tree.

Skipping SPI calibration doesn't bring harm since there's no need
for the flash golden values stored during SPI calibration.
Instead, they are now read during the spi_nor_read_id call in the
NOR framework.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/cadence_qspi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 9c466f8695..331a46d88f 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -251,13 +251,6 @@ static int cadence_spi_probe(struct udevice *bus)
 
 	priv->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC, priv->ref_clk_hz);
 
-	/* Versal and Versal-NET use spi calibration to set read delay */
-	if (CONFIG_IS_ENABLED(ARCH_VERSAL) ||
-	    CONFIG_IS_ENABLED(ARCH_VERSAL_NET) ||
-	    CONFIG_IS_ENABLED(ARCH_VERSAL2))
-		if (priv->read_delay >= 0)
-			priv->read_delay = -1;
-
 	/* Reset ospi flash device */
 	return cadence_qspi_versal_flash_reset(bus);
 }
-- 
2.17.1

