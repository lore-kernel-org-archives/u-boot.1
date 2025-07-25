Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305DEC87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 11:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9468183946;
	Fri, 25 Jul 2025 13:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cI/18vWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75EA6836A3; Fri, 25 Jul 2025 13:26:15 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BF07836A3
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 13:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIOkhXZStjZUX0Icv3TIsybWqEep+odNgWHTQ8WkwDOM4JeE8JSPiFXpuI2IB05gJ4Rhiq+RocOPx43CAxDd7QqpU4hrx3xShWYQhHqSxWHpwNmXuo3Z4LNI3S4nQ2Apv2phpe6UC8tlvBIKu6vI5wRqSbl2hbaG3FyriFLFLmL0PGtv+gyNOhO7B0yfHfUK4Zq2IyHp8Hw+lB78S2mnQHFkjahusfvgWaaU3qXjjy4QJ3uH8cC5EyQRMIjIRwi1qtOjK0lRi6YAwsEAa5PzMNHtsd19h26e8JGySqmjdUR4NQbFMw4lVGCDkMzbAuU/MCQWQ7Xt49kGJNoMSU04aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlZ4Zrtb1FAz0r9sIHwhX2PV2LM1OHMQPzCX1vPvKTc=;
 b=iqxwFlK0FMnDBSrbAkwC+Ghkm7BlLYyE4QVsR61smH0BVn2FiRC0qNb5Bjg1/Q/EV3/SU3+QDb1DHh/mxywtOoJIQkLy1S96K97GJzhJ4vy3W4WfAUAUMZA4x7a3iXBTj1a4d3Aj+8JSHC3h0nxfpBV3tGAttkw5rVRL1STImfsRpKugFHfzoR9N44AzaxSFmrC7yUZGwjbkewHYKUvWMOXLSD60gGaYI4twVUUoV46VtM6yURzNQPHuXpd1L3+MQ315W9Wjtn3nDNexNYvOyhCKnebzE+6lLyxq2r/RUvUtjzfrUdGKYayGLIV3ErJusdd9I5glSWBzH3kti+X0KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlZ4Zrtb1FAz0r9sIHwhX2PV2LM1OHMQPzCX1vPvKTc=;
 b=cI/18vWyoKI5aGwWQudaAYXZSQkQ+ySPHVrvmP4a13j4jJKMKcgHEV1crcyOxuFy4UnMmG2xvNHRctE13NQh1Uvnck4M9UiakBfCnu2LKAUY/85c8ZL2UAjwtRQqRCtUjqPLwVgW386z3d+HBVtXQI/IxaAm85lK/F2h11Uj9X0=
Received: from CH5PR02CA0020.namprd02.prod.outlook.com (2603:10b6:610:1ed::25)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 11:26:08 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::ff) by CH5PR02CA0020.outlook.office365.com
 (2603:10b6:610:1ed::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 11:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 11:26:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 06:26:03 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 25 Jul 2025 06:26:03 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, <p.bruenn@beckhoff.com>
CC: Alexander Dahl <ada@thorsis.com>, Alexander Graf <agraf@csgraf.de>, Dmitry
 Rokosov <ddrokosov@salutedevices.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Muhammad Hazim Izzat Zamri
 <muhammad.hazim.izzat.zamri@altera.com>, Pieter Van Trappen
 <pieter.van.trappen@cern.ch>, Simon Glass <sjg@chromium.org>, Svyatoslav
 Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/3] fpga: Remove lattice and ACEX1 support
Date: Fri, 25 Jul 2025 13:25:51 +0200
Message-ID: <cover.1753442748.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=1FuvteiWFzmV1859HoPTtbOEdOSiHTjesQ09oXf6XZ4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ0Zx5Im3N/0vaHxpz7nwXOmb6bZY0Ld7KZ84bQUw6cp
 h9ZJd5HdZSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBE5CMZ/pcntpbZnLepLFxf
 4Kbu8UW84wHHpNYrl+dv6LqQX3G+7jUjw7suFQPxnywbD5pNb/NrdKnYtiGeyexIvoHurL0Pfbo
 /sAMA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 148a2ce2-da79-4fe1-36e0-08ddcb6e0cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|7416014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ikagF6B7GgRI7jypCPP29gDqFdc2APUDtuozzEAmVhAKoA9eI9ywFbsLRynf?=
 =?us-ascii?Q?WyaWSXuBt3lnSdLv+UIQCGR9LysqjcjGrBNuvDAu0GQcLrT+7HTTtkw2lU86?=
 =?us-ascii?Q?GSDrXTvYVIuYu9RIfFAPMEzYB7ulnpZ8MDyhmn5RB/4YDHyhB6oSHvfDaavF?=
 =?us-ascii?Q?xKyrCLg1a1abS4lk2WEKKhifmxE/OM0/AVvlMK8nEWm638YEQ1KDhwKL3HKT?=
 =?us-ascii?Q?uRIVZPj+8+CkB491YmP458r1BmjDmW7kbWnnz2hqr1+9OCMOzwNnQINcSh8c?=
 =?us-ascii?Q?2rFDTE3YUZjSjYPjR0I91KVW7NCTD8IhIrq7hUtJu6tESRMoM6+Nfo9T2ap6?=
 =?us-ascii?Q?Q+h3DouEukmXTujXwt/cztBj/j9aMnDgU/MdezOBULdMVtp2H1Wx9/eiBOcJ?=
 =?us-ascii?Q?/HXdiGR8JglAISXYS9HCkvwW8gFjVWbRWug/tvRzRG4CsO6sn3dV97Qfm6ML?=
 =?us-ascii?Q?BNSzpdkjqKG1HKY+3B0CwFB0opizRYWCqUmRiXXjWoIAHRHCp1i7DVxL+etZ?=
 =?us-ascii?Q?mmw+66f559U29AmXPOG6h2DUeVLWZifhPdrh7qyyVrWpkZk4CDWvSbylAnXU?=
 =?us-ascii?Q?IT8wn7dENZSVUpXZy6/UjNoablkV609D+GUu40zJ6UqTH77ikfIxyd8xCLNe?=
 =?us-ascii?Q?sgrVkGst94hYgiPwQmcrS7wFec3Za4LUFwxByt+Wou7/eueWjSfNe2IAezCh?=
 =?us-ascii?Q?XZUlQmdZWlYU6BiIaW3s/XggB3HorYW5+4tsP3AnpSvLP+XMFDg7xyZ8J9ew?=
 =?us-ascii?Q?YX2o+7e4jtpnQlZJcrTEWQ6jOhHf729ROnt9uBAwl3oC3GoXp0ij74HXzeW2?=
 =?us-ascii?Q?ZdVHDXfo+tG55giAxOk/+lGrIxUXmjWWd6rdBJzjy6G128BGEyZzMWUQWfn4?=
 =?us-ascii?Q?9JoXs3NZjKj9hD1SxS4KvgsJlShBl+QcheBhGC29S7XdHcEbaKRIy/O9ea3Z?=
 =?us-ascii?Q?9o94zI5g4zJ6DcYC43uNBZDipGflcwPJ+vMl/dc+LSEMKhu67uZfQYJHONPF?=
 =?us-ascii?Q?bbmsJ4Ra/VivFDIGyHj+LNE50xJb6xm5t/woR04EN++gD5TF5shM3XN0Prpz?=
 =?us-ascii?Q?SZQU7iKKRvkWX+FNMpkR9Gpiuii4BphlRz0Dhra/LEsRw7EMclmBJ3W5pouC?=
 =?us-ascii?Q?Q2yozXVCIxjsY6GcbaKNr1/z43uANDpGywvmsTCItSW0lS8MzTsaREqGtCD1?=
 =?us-ascii?Q?TeyV3T6SEvfUoCzmBz0nuGX1RinWqUldVt4s+405smIu3vcPn0V0cE8ZYrxe?=
 =?us-ascii?Q?XL5gljSqTqLcg57zOtNQKgjIJ0pVF6Y9lpDFPk9yY9bOHyktm00rX//1xTid?=
 =?us-ascii?Q?vZijt+CwCY0RJFcBMKFJAuG5nfln2bW89cEwBDRKEiWb/U+ubtN5AejzFyuE?=
 =?us-ascii?Q?iNt5AiK+BQglbM8vk+pXk9guOIWxYk2VdxZtzlZgVDkQG1kJyzEiVTgmRzzx?=
 =?us-ascii?Q?f+fQ3CeukPES6GKGQRo7pKAV7oVIPDlOoKGBxhlx9sF09IDTvfsKDVq0GXWT?=
 =?us-ascii?Q?+xwVEOhpK5jz+ZefPvP/o0wJKAvIwFuoWOMs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 11:26:07.8197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 148a2ce2-da79-4fe1-36e0-08ddcb6e0cdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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

Hi,

when fpga drivers were enabled via sandbox some coverity issues came and
make no sense to fix them when there is no user of these drivers that's why
it is easier just remove them completely.

Another candidate for removal is FPGA_CYCLON2 which is enabled only by
mx53cx9020_defconfig.
Patrick: Is this board still maintained?

Thanks,
Michal


Michal Simek (3):
  fpga: xilinx: Check valid desc structure
  fpga: Remove ancient ACEX1K support
  fpga: lattice: Remove unused support

 configs/sandbox_defconfig |    2 -
 drivers/fpga/ACEX1K.c     |  245 ---
 drivers/fpga/Kconfig      |   12 -
 drivers/fpga/Makefile     |    2 -
 drivers/fpga/altera.c     |    5 +-
 drivers/fpga/fpga.c       |   23 -
 drivers/fpga/ivm_core.c   | 3149 -------------------------------------
 drivers/fpga/lattice.c    |  379 -----
 drivers/fpga/xilinx.c     |    3 +
 include/ACEX1K.h          |   49 -
 include/fpga.h            |    1 -
 include/lattice.h         |  298 ----
 12 files changed, 4 insertions(+), 4164 deletions(-)
 delete mode 100644 drivers/fpga/ACEX1K.c
 delete mode 100644 drivers/fpga/ivm_core.c
 delete mode 100644 drivers/fpga/lattice.c
 delete mode 100644 include/lattice.h

-- 
2.43.0

base-commit: 021783860f7e628f7c4e0c101707cd4250e6d61f
branch: debian-sent3
