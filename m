Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8B3C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 16:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F98E877CD;
	Wed, 27 Dec 2023 17:29:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1qX9wk/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DC74877F3; Wed, 27 Dec 2023 17:29:00 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C44CB8764D
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 17:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEsHhkDcmaOUKfu62UZT3myr0qpDXmNVikk/3NYZcH3DxBR05pWiI/7GIiEv6esw5/Qp3ov/Bzm9OQY8R9DvEt8ZEyKbwgLm0MMNanfUXR0oAO321+TezyoszW/M65zufHa2UPz51vgF6weGrvq3ge/radALOon9eJ7wDWqTJu2pHMO10O977mRP9471/CDb9BrLCrB8vojEy3+FQmHoXB5sOoopKM4OTvempjx+H3bAViLlarmmLOl4ovlMBPvILJwakrGbwexTIAj3XWWOt4sM1Yf77TojEDWly4VQEbddQ+6+dzi/o2kRRRyBXVs2UwVxEsPy8I7wt7LFc5LUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYBJkY6rTNYh935Z1v8gGCm9x0R5cAPHLRTGN2GoRHE=;
 b=AU8S2EKCt+8qRFF+QDVNfSgNanXQYxt8FwdCRm+lyb7DweYnHq3cDhY4P6lILnlImMYqHW8atII8UF9meskVzhcnp8JxqCzJ1Tk9IZAcFS1vao6scJS5BrEAC3EugTdtwk23uz0C6CDn+7M/LygXzYqzMNZcncc1NLPtAz9J4W4mc9D4eUOZq532QeC7+t3JgDOTXkaVCSATNZ5gEPUv9ff4A4udsVQSaep97Jh6s1SfGPK2uV6BmpRu+0RYjaX9Z/KS1doWR7jPKfsawiYpM7Gxj5xfk+8ONWkkyXi3xqCJcnOfTrCFYnGhTEnl2u3lmvAPBgvuLvurKgbwbfIOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYBJkY6rTNYh935Z1v8gGCm9x0R5cAPHLRTGN2GoRHE=;
 b=1qX9wk/pmc9sjBAkbyKrssCIZcUppctPbciWapS6c4t1FMNhcfHULF5sTkGmfFOI2G2L8i2k9n5LXVSWSEaUR3SRjQ5t7wp8d+pNQT83wPF5qE2+eq6PFq9yftjLiGqSqgcZ7BsUx+PvZ1Rk146ZJhdyHKICBdxEZk9JX/hytUs=
Received: from BY5PR13CA0004.namprd13.prod.outlook.com (2603:10b6:a03:180::17)
 by CH0PR12MB5092.namprd12.prod.outlook.com (2603:10b6:610:bf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 16:28:54 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::1c) by BY5PR13CA0004.outlook.office365.com
 (2603:10b6:a03:180::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19 via Frontend
 Transport; Wed, 27 Dec 2023 16:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7135.14 via Frontend Transport; Wed, 27 Dec 2023 16:28:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 27 Dec
 2023 10:28:52 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 27 Dec
 2023 10:28:52 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 27 Dec 2023 10:28:50 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <michal.simek@amd.com>,
 <git@xilinx.com>
Subject: [PATCH] mtd: spi-nor: ids: Add is25lx512 chip
Date: Wed, 27 Dec 2023 21:58:39 +0530
Message-ID: <20231227162839.858860-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|CH0PR12MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: b27413a5-a50e-4899-d381-08dc06f8ea91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJv4uJSViWu06qXff7RqJnfxUPxlya0mNhInBXDKKvFtf1dhbUcBIvliIj7FI4C9LbdXSNxMpZm5TvCA72nVHX52jdJQLNCyEIm3+uBNKm2ieziW/S/9xFxEvMtC03yDBbIh7tiVIa4LVlMu+WZ/SoLoGMIF3VuvcOewmDCgbqOLEBYyx1hhyzx4NCy5dc9gBsamm8HWxwRhSnZdUc0oCeAlY6+Kk6T2BTn6i62KKvdh5/A8gmxt1Zz/hZs9h5CajAKiRVhVsLrpusJAdXdGvTakvgDLHpl8JFawjVuDVIv9nOwfnQxm5GLML6i0mQshRhlgY8A2u1RTUMiM+xy9JkIoS8LwGl0W6ihCfKjYzY2q6GzSuP15zD87SvoFI3o/chM/YQgeIuQCdW0nJT7ZCJNc2hh7JMpzDX4qc4ul+iGJOVj/egRpD0FxYS5IcrChfhHgPt4k0eTeC5P0OzOHOG5B1Wlh6OEWkc5VDPfmpfEIv0FYKSx7DTx80HEphL9ddgNMC/FDq3armwHpmpGC8ILAL1+rgzWPvCTZXtlsEfEtCkevalNlokAkD8MZC9/48+B7XVy6cFjFLedIezWhuJC1unh80yMxfCEYfXsaqEh3iyCF41rphJ0TJqunDkpN7nS0pQnNsqLFQxBIdfUbE5wGRjobANK1dCz/kyJyuVT+TuzxMJUKr5gL8FAon6U/UpfTMbnbIve1itRl6Qb9FPEZmyw2l39V2rypWGRlExYX77TvkZ1Fl87sXTH9eKLub5AktFt+zd7QeZkz09N4FA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(2906002)(70206006)(70586007)(5660300002)(40460700003)(6916009)(4744005)(4326008)(8936002)(8676002)(316002)(54906003)(41300700001)(47076005)(103116003)(36756003)(478600001)(26005)(6666004)(86362001)(2616005)(1076003)(107886003)(356005)(336012)(426003)(36860700001)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 16:28:53.5443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b27413a5-a50e-4899-d381-08dc06f8ea91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5092
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

Added support for the ISSI OSPI flash part IS25LX512M.
Initial testing was performed on the Tenzing-se1 board using
SDR mode, covering basic erase, write, and readback operations.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index f86e7ff8e5..5ab1bc9ed3 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -234,6 +234,8 @@ const struct flash_info spi_nor_ids[] = {
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("is25wx256",  0x9d5b19, 0, 128 * 1024, 256,
 			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("is25lx512",  0x9d5a1a, 0, 64 * 1024, 1024,
+			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_TB) },
 #endif
 #ifdef CONFIG_SPI_FLASH_MACRONIX	/* MACRONIX */
 	/* Macronix */
-- 
2.27.0

