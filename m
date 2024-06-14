Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D66EC27C79
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0208889FA;
	Fri, 14 Jun 2024 14:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nW6ta3Tn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D22CA889F4; Fri, 14 Jun 2024 14:48:31 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0C338857B
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGc7cbZYBAh2mUjcId3ZGDSQsLp4bZDqjhZg7vSX7Uqij9NqsKS+uow9XAuNBrI5OdtK2jlFpgrEjOUelxSBcznaQaMsYA1aqAkn6hGsFjCBvosikgi/HCp6mQT57btoZJQtLM1gmrFs/z9IXNyzROw4QImxpOlilX9uCcEYw/pxg5ljYvdOadcct8WJpcoi/DWwyk+uLVazu71zb8VMb1og8TSc0giF0LJI0oRnw8oKMcgsu4Xpjcia1cehM2BurHl5f4HN9eaPpdxJdPlmlzxmyExQu/svT7ELnB6y9tDSyehAdPGxDr8dzmYr2oZ06um3AT7oVP1CHnI/6xgyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBWJNhj8HZErIjpRFcGLH6GmLhBmrSY40PrPrcZ2ExU=;
 b=bWGEnXOKS5T6Lx1fjXqQqdCb4904ml0BhF5vL2+moUstOHbrDyxxUUJQ30MT5hmj5Y0DeiJVsd5uw95EVFJHfdna7/SZAHFHbsfJBZZx53vc28SOVlItt/J1ZnQS7bdVbfpzkjVd5ldnYB7I9Q9ERoyMN6kNnUuWmxpIP98Cuq0IaqILB103b8V50bPDcVSqINyL6D5oHbIlaz+MrQQ/EsVYCsMpa+mmjk17U4+I6TP6P4GxK2Vinqb1CTXKydzTqdAhMrZE+0pOLfXre0vG3d2wKHpOMHdA+JKbXo0Xj6HioaTVxSYo3g+YY25MFZyP2o8cK/LKdWBxwv/rQvj/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBWJNhj8HZErIjpRFcGLH6GmLhBmrSY40PrPrcZ2ExU=;
 b=nW6ta3TnVP2Kyd+/V+bRSsf8tYbUphiRK9006xSNnaWQB2iZEy+DB8d+q3sBwhtsSKHxXSZ7P/kINN2Ypv3rRsXVIzM3kFxiuLkI2r2DrcYZABCa2xIXlsVl7vWhrwNX8F0HbRIiZNCoCih4u8NIunqEIoBVaN+QoBo6BBikpn0=
Received: from SJ0PR03CA0146.namprd03.prod.outlook.com (2603:10b6:a03:33c::31)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Fri, 14 Jun
 2024 12:48:25 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::f7) by SJ0PR03CA0146.outlook.office365.com
 (2603:10b6:a03:33c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Fri, 14 Jun 2024 12:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 12:48:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 07:48:22 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Jun 2024 07:48:20 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <vigneshr@ti.com>, <git@amd.com>
Subject: [PATCH 1/2] env_spi: support overriding spi dev from board code
Date: Fri, 14 Jun 2024 18:18:10 +0530
Message-ID: <20240614124811.22945-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614124811.22945-1-venkatesh.abbarapu@amd.com>
References: <20240614124811.22945-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b80b05b-c47f-4b9c-fc96-08dc8c7047f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|376011|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mjhFAl5Qa0+FQ43A7dM/CY5JjfaxoqrbcyA0Hq+PCh148+8ZgZ4AObOE75JC?=
 =?us-ascii?Q?qZZKT2BjxTZ58eax2XNh11eDbjWKXS0Nd+gVRnKaJ5DujOzOIOGMmY9U2Ey7?=
 =?us-ascii?Q?lTA5BdjdZeqdbIzU8TvB9Teb/IApgklNKrrXuj9HJmUKMr84XT4rgOysPDM7?=
 =?us-ascii?Q?DQn0s2yjLum+13QJnZ9b9fwiGW/YbXzXkJLwV4MHyWDQuLiSLkk+N52D5sFO?=
 =?us-ascii?Q?ChExwBiWLc2wxGyN3ZBckfSww63TuVqxFyUFGmLzg07CHzxcYHnzkkGrZT9k?=
 =?us-ascii?Q?wMU9K4MYoUcVo0Vo2WUayDvnJ26HFu0OcmoMFr3pwi49a+AIwgaKXYDehkNO?=
 =?us-ascii?Q?BexvGGBMx5z53uOKF+fkqmHi3HUos8GNDa2t+pt84Xj04LA16+O8WMzW1zTr?=
 =?us-ascii?Q?Qw5V3yospjElnnVQ3xsrff6H+nPf3j98TapNNW2DIlkHCt4pk5vdfJYcEJKl?=
 =?us-ascii?Q?Q3xyPcT3S+8xapYGpJ/Mb/HgW8e/hHUiU/iXnpbg626R7aD7U3kY/S67J6bz?=
 =?us-ascii?Q?DitCjZyZFFcxfs9BU60/Y9jOYg++p0vJywD7tCPgYHz47uIZokyYwnDih8nN?=
 =?us-ascii?Q?PpTcRAD6fouN/S8mTVl9WImu9sHDU4MhLDCjMdVmYE8BZeD/Vwx2RgaHJoNg?=
 =?us-ascii?Q?1b5M8IiH4oMRNpCGfY1+ynKiY5wO8G1TkN7IcHQ1Bxfi2qPVglWdM6fGYkuZ?=
 =?us-ascii?Q?blL7+HAv2WZb1fR2Q/REK5LTcWbhxXJfHyN5BnzBFvqyzwvgq2AbvwYTDlWc?=
 =?us-ascii?Q?lAdgbL2BBoh/5sAFVVfL6tH56xLR2gS7fW36EQYppZjhrrVLQ9mrbuc3TO41?=
 =?us-ascii?Q?Lau7BX5F18QoVlx/8SVr0V3maABXJcw2/KbFHeXmS8IWZJprSDMMatjv1+TR?=
 =?us-ascii?Q?8BySMWtfNRI44j/Lqy9XY0XsaF/rMufOvs+pIaiJab/pFEAvbEeA20RG6DMw?=
 =?us-ascii?Q?sXkheWKooQy5fkFetncT3+38g/TP4w2F7oArvdE8lrHvJQ1lXEHthoytec4M?=
 =?us-ascii?Q?tx8YhcYB9bVAah5O50dfXgkI3LSmGxVR0uucEC/7P7SXitVO8LCQgUCvOVgi?=
 =?us-ascii?Q?QZIsgg9UvwbT2wMamCrkxP+EUsbVHMS5ZgN/d5DnKlBaDx/STvTEQa73rljX?=
 =?us-ascii?Q?vv+IEBpUcTVuas4BTU1+i7xvGMxSCTzCzy+VdhRmMeB0VZXtqD0/zwKljz1L?=
 =?us-ascii?Q?GKrv83ZxYFtnTqndw+Y69ZInku+/efjA36j+cJpsHUivBqKH6fgdINzuJ/7t?=
 =?us-ascii?Q?PF3EiaKIx0YseoTjPf9XlfCrEFw0MiVb0Q+hjIrbeO1ICvU3jo5sYBCFmzjY?=
 =?us-ascii?Q?nNJJhn7rSmHon1jpRrdfILlu+hAUTsa1bCekhPqxnkWr+8Nb9JyxrqhBfar4?=
 =?us-ascii?Q?SwZHS5kxxvd+AU/uQJfLfCxNfL3SDsUABIZdN0lfuhffpUY6YQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 12:48:24.7793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b80b05b-c47f-4b9c-fc96-08dc8c7047f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
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

This enables boards to choose where to/from the environment
should be saved/loaded. They can then for example support using
the same device (dynamically) from which the bootloader was
launched to load and save env data and do not have to
define CONFIG_ENV_SPI_BUS statically.

In my use case, the environment needs to be on the same device I
booted from. It can be the QSPI or OSPI device.
I therefore would override spi_get_env_dev in the board code,
read the bootmode registers to determine where we booted from
and return the corresponding device index.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 9 +++++++++
 env/sf.c                       | 3 ++-
 include/spi.h                  | 2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index f86003ca8c..2fb49a96f3 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4206,3 +4206,12 @@ int spi_flash_cmd_get_sw_write_prot(struct spi_nor *nor)
 
 	return (sr >> 2) & 7;
 }
+
+__weak int spi_get_env_dev(void)
+{
+#ifdef CONFIG_ENV_SPI_BUS
+	return CONFIG_ENV_SPI_BUS;
+#else
+	return 0;
+#endif
+}
diff --git a/env/sf.c b/env/sf.c
index 8f5c03b00d..4d40fd613e 100644
--- a/env/sf.c
+++ b/env/sf.c
@@ -44,9 +44,10 @@ static int setup_flash_device(struct spi_flash **env_flash)
 #if CONFIG_IS_ENABLED(DM_SPI_FLASH)
 	struct udevice *new;
 	int	ret;
+	int dev = spi_get_env_dev();
 
 	/* speed and mode will be read from DT */
-	ret = spi_flash_probe_bus_cs(CONFIG_ENV_SPI_BUS, CONFIG_ENV_SPI_CS,
+	ret = spi_flash_probe_bus_cs(dev, CONFIG_ENV_SPI_CS,
 				     &new);
 	if (ret) {
 		env_set_default("spi_flash_probe_bus_cs() failed", 0);
diff --git a/include/spi.h b/include/spi.h
index 7e38cc2a2a..9e9851284c 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -743,4 +743,6 @@ int dm_spi_get_mmap(struct udevice *dev, ulong *map_basep, uint *map_sizep,
 #define spi_get_ops(dev)	((struct dm_spi_ops *)(dev)->driver->ops)
 #define spi_emul_get_ops(dev)	((struct dm_spi_emul_ops *)(dev)->driver->ops)
 
+int spi_get_env_dev(void);
+
 #endif	/* _SPI_H_ */
-- 
2.17.1

