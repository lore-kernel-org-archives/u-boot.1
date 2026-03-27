Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075F910ED66E
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 12:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79C608394E;
	Fri, 27 Mar 2026 13:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mehz7/eM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AAF883DA7; Fri, 27 Mar 2026 13:53:39 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28CBB81E18
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 13:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTMyLXo1Xd42yH1WUGH0tS1WzrAIrPrUPcqrGGTwGo3s6E0RDCGk6habim2zLf+2Bist/AqXVMm3345EcS1jrAVr/E16LJVILRIqGoFOAZv5v2H+0tfxFx+oiny7VVPy8swLSskKizYMHCoNlFKzEDBhWAZa2vmzpcjV2dZDzdswf/V8hP0aRbdmPEz/fGpCr8Z2DA67MCfs49GvQuOI0O9DVGwAMys5o1YDYZcbSBourCkFKumn5vVFDu1yaEQp/2aJbakBCZG4iy3GA8wcizw+ZpSyvFoNRplEdRkXmHiCt2evQyZRgNm+xC4ypbz3GmL73UQS4LzE0G+jRbFLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kytsmhfKZPfi+FrX4JcCYoLltlHyiqvarVSTHGFx0yU=;
 b=YdJWfp+wY5cLwefSOTqjiOhhmgjM+lYzaEOHpveTAxTqGES5+CLqE+S8ZGKEqiBeDoC/31pSrMCBIIMvKo/NErSSNCILnGu8q17HKxe770g8tJJ2PFkVeQDXjkXvDlxfWL8UrtyrDwcBiZ43ymuLG2O5B4bBZM5UTX8t18HhyFpNGiNHvvZG30aGg8qRfimo9iQO+CPO2HoVtDeu0RvNPcxVjkcBpK7uheH+HZTCUYAvOz0QJiVDAnViCZdCGCFpBFpntMNoXqEt/G0J6Fz7OSI8UC+HyDWkK69eZUx3FAbbP4LtEAY1ydB6F4mKYNlHk/TT0Tnj84SGFc0tkFE1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kytsmhfKZPfi+FrX4JcCYoLltlHyiqvarVSTHGFx0yU=;
 b=mehz7/eMroOPB1r9ztDqSpxPGH0mmYHg25RHKuOqy9irfGoCq5qyTNpggyqCdGAiEOsTFLov/FzEOx+cdQmJKr6FtoR89dzUCmIoayhr9VhYrt6GpmAErLulCFiDSaBDuLw7Cfj2dUif7G1/rc7Kf6+szuv2epZ8bVlQ12AghFM=
Received: from BL1P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::29)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.11; Fri, 27 Mar
 2026 12:53:32 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::8d) by BL1P223CA0024.outlook.office365.com
 (2603:10b6:208:2c4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Fri,
 27 Mar 2026 12:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 12:53:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 07:53:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 05:53:31 -0700
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 07:53:30 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>
Subject: [PATCH 0/4] Add TPM2 support for AMD Versal Gen 2
Date: Fri, 27 Mar 2026 18:22:54 +0530
Message-ID: <20260327125318.1037146-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d3b704-7d50-4194-6614-08de8bffda26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: J0143ukWwDpR1k1oLV0US+4FTwAnqGXJciBN5NZcbkUOBNaYG/WWcPhWnwCITA2kr3WzAqbmiL9R5eLCGgZnpj/KwOfjVEjB3Kxv8Df0rHcwAe4qPP7VdmdEwiDhVm5DtIQHw7D0cbu3oJzg1am7/ibcCeIU1UYvYVM0yF1CkI0vRJ8NqtQQiTy6aOL4eyIIG68A6JhnjPyaxbJyVDCHksPUhGM4oRnET+Djxa70geUXqxpn1+RxW+vN/rH7+poT+5k5xeqETOry4aXK+2b9dHAixCz4Jxu8uX8xpUqimtdNfY86abgstQB9uPNd5hfUCkM/ghB2vG3SAzlDYpX1FnbP/IWE8ILPTqbiqa7ezAZITbWe8b8nN02YIf9/1Pri4yBd6clag4vZBDrT9DdsANxiTViKJAOSfWn5XaElBsZNo5lQeMNo8BRjq+DoQsdWd3g4TLywDsqPFYP3KND/TnjM979omwsM6dlmF3ERKJJdSwfN6cCv9D8J/Iuem9oaXept9II+xlh46zHtigWGlQPSRF8ZA6P4OaEoQUlZassm1gITGvQF5gFhcX8NA/xU8GGq8TYjARSO/5u0Tt98vDzwKs+dww1WcIndE8dkV9vVk+ysRadIvzsebWCXTAFKPYsNdxYpCAygj/JGCmXEiS8eYFce16C92KwhG3hbeo+nyDBJPCtqYK09INubJPYqDxaPsKWjX0eqO/7hQIa+GAueXLiX8sKL8ZFT6RC0ymwThEZAkftiifJ2nzqd1jcPORWfookd5TeprjVpJ8vD+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MtGQdTlMf9/cY8FE4jOMISyZI9fTObBrvpXA69dCj6vxPi+c+SAFQ7SuFoPgDeCA+X4rJwRdmA4SvaIZw/espFtmIuddCKX5RpzdQw2nmeD7fgB7xY+hhC//CzMYvIcYGb+iAEcov9U6z7R1A8zrCjNtIyW4hKODtnPjxoaMmXFv4DAJCA6JWmQ1EUipqJYyekV+qFFsjP68AWBzi2V4nOVxgsaGMNjQPPVrhyQJ6qUAgQGRzO7dgC0/Lb97B9eYKYGAvuS4fRDi6XwKHyMDqEapK3iZotDRpI4+ooicblnaece7THWIw2mIdbxWSbGFQBOqw+IlPKltChps0vidPfb1FzE2py9AYT4fuviytvjSc24tCz8xtGmuaCsxJbLVD+dEDQKFW9O06317QMC8roPHBKienbApGOBvLZvS2Iu/GH3XyqttQfz01nb+yHvD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:53:32.5635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d3b704-7d50-4194-6614-08de8bffda26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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

This series adds a TPM2 driver for AMD Versal Gen 2 that exposes the
PLM XilOCP Hardware PCR service as a standard TPM2 interface.

On Versal Gen 2 there is no discrete TPM chip; instead the Platform
Management controller (PLM) provides a set of Hardware PCRs through its
XilOCP module (module ID 13). U-Boot reaches PLM via the TF-A SMC
PASS_THROUGH path using the existing xilinx_pm_request() infrastructure:

 U-Boot -> xilinx_pm_request() -> SMC (PASS_THROUGH) -> TF-A -> IPI -> PLM

Padmarao Begari (4):
  firmware: zynqmp: Add HW PCR API for Versal Gen 2
  tpm: Add AMD Versal Gen 2 TPM2 driver
  firmware: zynqmp: Bind TPM2 driver for Versal Gen 2
  configs: amd: Enable Versal Gen 2 TPM2 driver

 MAINTAINERS                        |   5 +
 configs/amd_versal2_virt_defconfig |   1 +
 drivers/firmware/firmware-zynqmp.c |  85 +++-
 drivers/tpm/Kconfig                |  21 +
 drivers/tpm/Makefile               |   1 +
 drivers/tpm/tpm2_versal2_smc.c     | 666 +++++++++++++++++++++++++++++
 include/zynqmp_firmware.h          |  24 ++
 7 files changed, 802 insertions(+), 1 deletion(-)
 create mode 100644 drivers/tpm/tpm2_versal2_smc.c

-- 
2.34.1

