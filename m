Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F9BC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 272A687604;
	Thu, 26 Oct 2023 16:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="toEZp3Lb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FC3887B6B; Thu, 26 Oct 2023 16:12:32 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B3AE87B23
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Op67gfoW1OcaPap+B3l/16b2zMH7VFi+ABJS5P+fNlDw+14cYZkUVzYa+Jyxf1Zn+Mos89yXwslEJVJgaFng9BJea4OeSI2ynX7ha70QqnXU0DtJpZ2AJKPFMCw15nHX4gkGC4hyS8vw4a9u2XITl4yNFo9Ctie9dwGTlphNRrqiK1966agu0PRi0lo05kOs7mdIulLpaHrptaHxKEA7Dyq5/0Luloq1FTJ+6/OvitsdzHPxl3N89fHp3spdi2QSNBWFGYJBZs1O7d2br7/Rittbcuxo+EvauSqtZdppm5tHM7EgW4gu34bvNp4SvkMh9kU44Cenagl0/b5+o7w16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEyF6lay1o34Zpv9Vm5sg9PZyC7URdXbcPHMDdmvvuI=;
 b=LXui8T5zBkItA+vxKFdnD4TxJmggF70zE0aJNYI5VI+ry3on/ail6+Q2ULJ+kyRWUO6NgsRozU0+MXqUNMbPZwJLrmKEeDsj7WKM8QMKrv+T9wR74Po7N7dDu5TVWYLgRfL7lbfLj7/Zyh6bIT/rGc9SGXbJIEfgRxOzuQfqaVTpb1XPEeuZofzZGAnmiLnHI7HkJrw9nSs3fvWfjmaegTYsfWXwpgF4de3Y8j99izdL7k/MIEtsHMMPiI6NK9LpDCslS9TBTes+ZDHTpM6GNm7cMqSu9Q/la71YlldLkbLCicNnwQzb/mWI2Os48p7Ar0yRKwfywYi2pChjixx+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEyF6lay1o34Zpv9Vm5sg9PZyC7URdXbcPHMDdmvvuI=;
 b=toEZp3LbU5P17j+/gUUd6ZU4Fl3dVavtLO+L9Uu+pIGkUoKq9NVYCptX6BVNjd6KFy/hMxPPwY2BgdW8Seev1inFSPPdmdDrq7K3uQ2YLBgAJN3X2dvjykf678GAP1mUDXbW3/Y6Oe5OAfIKlH+HKLbhI1sXvKZJPeYQxwI0boQ=
Received: from DM6PR10CA0011.namprd10.prod.outlook.com (2603:10b6:5:60::24) by
 DS0PR12MB7801.namprd12.prod.outlook.com (2603:10b6:8:140::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.23; Thu, 26 Oct 2023 14:12:24 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::a3) by DM6PR10CA0011.outlook.office365.com
 (2603:10b6:5:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Thu, 26 Oct 2023 14:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:12:24 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:12:23 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] xilinx: versal: Setup 30MHz as default spi frequency
Date: Thu, 26 Oct 2023 16:12:21 +0200
Message-ID: <f7989540e0837091ac798014077783db57c78fe9.1698329539.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=761; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=SESmmWTjE0USYP52hGkD2MqHMjPJS9nAq/8IiZdIVFE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlSr4sOGAkxXb1lL+dbe8HsQeWUH87XJlRVTPgteFFshf
 irf9u2UjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRd/EM8wyEflRun9cuMzN2
 4SlvEUXGdfoBcxnm532Wtneae7aAWeHimuQNP0s3Hg5eDQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|DS0PR12MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: be908520-fbbd-4871-8ca1-08dbd62d93ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eTny8AbRoHPZKmlMOUfjZFZ3LzwiOdliexC+SgeG09w1l8uUqWKNNrYptxi1mxRK2UhiT+QWWM8EeIbNmigp+p3oxOhIXP/g0Gwi0VXugf4PeuZq6jlBgNynqBAEFlNnIKXeNGsriqdo665/j60FuXqFcqheIXtVXgsbZN2p2RtV6wSYfIUcAti1qEC6bEV0LRrg0U4DJ8SDRC2LVe6RJX3TLtMSYAviT9bFeR37WHDivVoY7tAqA1znB+oyrqMYulcHR/THi7APrKynro5Rv1tLXLSsFAjt7/ojk6ERJYiC1Tx+skv/3hW6nw9jO6MSYhUkD6VPXfm0ZVYSF0CaRzIn3nojvZ+HK4mCTSqXfCI6QzSAKiUmhugeGpvQrqhtlVDe5vpauEwu93cP5gENzOYHIsGnZpr0wMQ5ZopWeChdCj/h30NQYAgdrzUfScKXKHM7eFNTZQeSmPD1ORkezsX22RsbNxvEhjxeSjtVk1C+OHaCN0XUIcHTnaFHSz2pFCuca6p3jIYnPSZU4WMeSTKLReI1YWI0Gt2PR63j2UMec9NAn7DwNfTO0hujex14NwEaPdJVqeyT67K7qCEvk5Nj0XbXVKVeawPDL4dZQtYFt5DkW44zbVlsVHRott12oBgcYNZQbcHcoiS2sMKDX0/OHtX998/qXI7K5As9AVpYobDPkupFq32vOIxvXj1HAyTU3XpsJeKyor4MOuHPKfw3Br8rIafnygjBLQ13mmONJQWoUwvk5hHC3BfBM4l0rZMhwSnU8qMvKibPDxunfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(1800799009)(82310400011)(186009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(2616005)(44832011)(41300700001)(36756003)(26005)(16526019)(8676002)(8936002)(5660300002)(356005)(36860700001)(82740400003)(110136005)(4744005)(47076005)(70206006)(81166007)(70586007)(2906002)(316002)(86362001)(478600001)(336012)(426003)(40480700001)(40460700003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:12:24.5745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be908520-fbbd-4871-8ca1-08dbd62d93ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7801
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

Align default SPI configuration with ZynqMP/Versal NET.
There is no reason to run on lower frequencies.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_versal_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index be86d446cf46..90911b374e75 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
 CONFIG_ARCH_VERSAL=y
 CONFIG_TEXT_BASE=0x8000000
 CONFIG_SYS_MALLOC_F_LEN=0x100000
+CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_NR_DRAM_BANKS=36
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-versal-virt"
 CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.36.1

