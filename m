Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72533CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 06:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFC3D83EC9;
	Tue, 11 Nov 2025 07:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="u5pFXp7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91ACA83EC0; Tue, 11 Nov 2025 07:17:22 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F74183A98
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 07:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uK1kbqAdxLIfJSfyK6UEo06jAGDO6uSxuQGQ8UKtcL/BcQ9lb2IznjbjkB4C9kBBzNMMppojYtiKc5Mr5DOsD1zoFgb45cQKSrH1md0nnjczt7swChTL9TfO1xo6P3mFtgbXi7T/LhKNiJmGnlxu/qXO1xLg3gceOK0kf3FuXumFk6o79qiWeSSjG8BQwUCyXPyGPWSdk8euLaKxEl+1PErI2WsXHdPQPG5mqeehPht8fcoubCuM8raedrRLDgso/vnKAN46+b/crauHZP+KYCpPUkMCzJ4IGZkk5l+hoQTR2lvWwwh/rk41rRbq8080dt7L0IUgbVGT01k3ShRhig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNz67oxvMBHnq5F88vmTGqF2JTothu8BydOB7SR2sIU=;
 b=RISiHc/V7mKkgSD+tyZiaY4KV0FiYthfTn0SjpRFGn8ofeYZx/vqKy755sGeUnRyuK6Km6I8OLdm4MmvHfdQXs6vMqsGsIQE1lEJJnuAgTfi3gPxdL3Y7rbi1p3PJz7vULY9qV1cKf2DU28MDpWO96ZnM8maCmV/Ud4kmGKap2U7OFFP3+hRiwJxXs4zqxpSqR4WPJ3EIOLMt1ouOH+IWsczJTLHuu04nmYybv8dvVPRdHL2+IxwHkESvQ/N0JUPSNI/3M246S+aciFUbeSklBranrlaOXgVUa2SBvrjSFE3cZCG/f0mrKEtWaU8f9zILbc5zsQ13yqJEDP85ddl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNz67oxvMBHnq5F88vmTGqF2JTothu8BydOB7SR2sIU=;
 b=u5pFXp7nDUjTi27DwPrGsHmZ6UMgF+iKhI+vzyj2fBbH53vrULTEJ81cDxEyoi9wpMAX0/QHKyobjT6sWjmUNMevFBqArgPY5Aq602w6U/5fplN+KzHlTY2IC7KeGI/iTclvTAREA1UqEYsIwFA0IYcLg0eWmuUCdw/Db+JGn60=
Received: from BL1PR13CA0259.namprd13.prod.outlook.com (2603:10b6:208:2ba::24)
 by SA2PR10MB4458.namprd10.prod.outlook.com (2603:10b6:806:f8::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 06:17:17 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::41) by BL1PR13CA0259.outlook.office365.com
 (2603:10b6:208:2ba::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 06:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 06:17:16 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 00:17:15 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 00:17:14 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 00:17:14 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AB6GkPS448280;
 Tue, 11 Nov 2025 00:17:09 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <c-vankar@ti.com>,
 <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <peng.fan@nxp.com>, <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>,
 <jm@ti.com>, <m-chawdhry@ti.com>, <ahalaney@redhat.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v2 5/5] configs: j784s4_evm_a72_defconfig: Enable configs for
 PCIe boot
Date: Tue, 11 Nov 2025 11:46:45 +0530
Message-ID: <20251111061645.1004382-6-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111061645.1004382-1-h-salunke@ti.com>
References: <20251111061645.1004382-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|SA2PR10MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 49894168-d104-4f2a-3dc7-08de20e9f69a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XEWEUymnIQyZ5FHHdVyitInGHcmC7JMUK9Dc7L61piMR+ZwbyyUVXiqJ7VfG?=
 =?us-ascii?Q?CLM58zR97TkPW8wQJBopEOGHQHE+4uUPf6rft1lO6vDzfT31xlx63CIvd/1Y?=
 =?us-ascii?Q?jn2vMMwBnCA8l0NzCFLKWwiz2CHNqTHJWbI+W4RXRbFfZCxD+DRGJtxBULh/?=
 =?us-ascii?Q?7PUASDQkjlRZ3Dsym6ZBEna+8tkHPIEEqa07y7E4Ov73iAT6zs5k8dOohSTN?=
 =?us-ascii?Q?yvtIULlT4qaxAOhAOepZAR5yzdy2kNl3wpooEjfyoofJHps2mqhUGoRQi9bc?=
 =?us-ascii?Q?Ennts+hV27vAvNt+usrof49oqrvM3LWIL/UKERXmlLSgQJSsKEoqVw9MMzyD?=
 =?us-ascii?Q?C5V7L6dJCstdNs4uUPlYwdMENRKFmD1m7h+5Gc0zAVYoZKAv9OB3EIVK60zr?=
 =?us-ascii?Q?hsEbZ03YxVukGjczSqGurlBpKzLVrRXQ2FrbbaVmWKLi5/PwqHb/qkT2wXEw?=
 =?us-ascii?Q?TvtxC8Qt156JEkk5SsHMebFQH0PPSixelu2IuwXMXHEMdE/xrClCJ/s2lVKQ?=
 =?us-ascii?Q?McAI00cuia2fjV7Htfy98Kc/Y1ctcQROLTS/KO4upwtMs0OuZU3It8y3K0Xe?=
 =?us-ascii?Q?iDMwePlPs7Ut6EL05NWrV3rggnBWxxWsnQ5Ymp8wvp3OeUQ2WDIPh8q6vDHm?=
 =?us-ascii?Q?oD4dTbiWRMXSa3QlVEUgTp4Espx0tsRhQvEHSCNLiBfBdcikx8Fn3SYLE8Yw?=
 =?us-ascii?Q?JF/YCiSOnEdg97h7qu5sBtOqq+NfbRPi0bNrcFOLfPFJNe+2VvBW1FyZLYbj?=
 =?us-ascii?Q?Ci1UCQIA0poLA0rW5GvU71m5FoewB3oWh26qdImCJtK46CQzQ6oroCWTyk6x?=
 =?us-ascii?Q?+90RkEsRYL8aGd5q1XJ7uP6TaVnAgkG1okCgD4/IWe4G+kgixJZoSGzegczv?=
 =?us-ascii?Q?3efWX3klS262KvBua4O7GmC+/WVg9g0vigqW5oHkGB0UjgK8isGtmKAkIezk?=
 =?us-ascii?Q?AEYBf58EYh5Xek19Ct4I1YhVpyVAvDtDKf8aW4ghdx41b8tY2lSdKy3P7yi9?=
 =?us-ascii?Q?wBaGyn4n7eeoqNY4ds+Zpv5kkjOwZ+5XFQzmEeLkO+GPPaPRsqpeUKZNsFBx?=
 =?us-ascii?Q?5i6NOcklfzotNrUDfs8IclKUwHbeMFeEBinzlw1GZQbg8clf5eQ4pM0kH27J?=
 =?us-ascii?Q?7Yo3L1i8tDVnGZYut9+PZ4xBWoEq5yakiql29KyZu3gp6NsbixacyzW9qCUQ?=
 =?us-ascii?Q?CKAdGADk66CflCDnm8vMM/H8G/2IuC22ccJS3DF7ZBDHM5xqHztpkWx+MALd?=
 =?us-ascii?Q?JZOFqpLXHITq8W4UC96HUhQkJK7e/cZm6layKewThWrGo72Rgbv8IkHoKMeq?=
 =?us-ascii?Q?BCTz8G7VO91cl/yacRCJ4YvHDoAJPW3PgBPExZfiAVjn6FMSxa5D+a23JiSc?=
 =?us-ascii?Q?HvA99sfxPflVfFDsuBQMAM/SsS54h0TnvFfNSoapp7rAzQEOBVd9HJzDigvK?=
 =?us-ascii?Q?dmePRq+phtjL60WLjhQmFccyyJwCSW//VpSyaEsV1m2IsNTj1C8bbZ4lEd0u?=
 =?us-ascii?Q?b0PWMTy2+5kEOrT4JvN+WpRkR3TRQyVPTG1ANtoUCb/v3itqrd3zbY8eWzUR?=
 =?us-ascii?Q?g/vL0lI04UfkTOxkqodTCcyqfMbIUGiufHomkDPF?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:17:16.9232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49894168-d104-4f2a-3dc7-08de20e9f69a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4458
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

J784S4 SoC has two instances of PCIe, namely PCIe0 and PCIe1. The
PCIe1 instance is used for PCIe endpoint boot. Enable the configs
required for PCIe boot on the J784S4 platform.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 configs/j784s4_evm_a72_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index fc7acbae694..f3c23470295 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -46,9 +46,16 @@ CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_PCI_ENDPOINT=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_PCI_DFU=y
+CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS=0x81000000
+CONFIG_SPL_PCI_DFU_BAR_SIZE=0x400000
+CONFIG_SPL_PCI_DFU_VENDOR_ID=0x104c
+CONFIG_SPL_PCI_DFU_DEVICE_ID=0xb010
+CONFIG_SPL_PCI_DFU_BOOT_PHASE="tispl.bin"
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
-- 
2.34.1

