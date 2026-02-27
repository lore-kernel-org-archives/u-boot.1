Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722D3FD9E26
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 01:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3567D83E83;
	Fri, 27 Feb 2026 02:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="MkdOJwbA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ACD183642; Fri, 27 Feb 2026 02:42:37 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C26683E61
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 02:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Haller@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2s0I89tw2QRftrcmLOd48+9VCR2BkG+06WAM22ZBU2dPNM7cAy1v699r8Oq42iLQZZmzcNEDG1pIO7jbdMicp83Hta09ldRNMcNc9ag/uvB92AUZO4iaZrCkhCJ8+6zG5UOyCDunDj84L3CTsEw9Ad/WBR7fpkOGbVkHxneHyEf+/tzWFs1SO1o4RyA6JNDgedr933CzC3LjOOgX5q/B2P8HbEkmWEQYLJIwjF8NaEo2ZyvH8L6ZVF2UAtVoma3Vz5Ius3fOf3UVLnD3jS+LV4nQ4LZAkWXRtuus6ZbZMAuqTXweqiJb+C2VhlANZJd8W7P7KDNcx8xLwVUl2d1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWOAQH1hZS9QR+iQpMjddrRwrkncJ0xLtECzhPuYkl0=;
 b=WjnNvRWZ3V7GMbY1P5CR+2FCDLTLPrm0CyzZD5aOCWlqvXzrVcMH3PF0+K+z83Ce7w+8PHUO1Oa/gg64DMzv09Zk2Zd3vxrxymix3s4esZy1+RyN2i9kNbRb52AJ5j51jmQSTApi2rotyEWZIiSI33FEUJFec9GTZk2l+wdSFhiBYSUG+iYA+ly2Z14RtttfLDOTILBF1S7vujMc/DQnbWoRYyr4vWCXsYN5RV1BS0T6HDwkvMRZj9+EpTx3x2EaEpclibems20U0+sKRgurBn4eg/QZXwQ/aAlrIEuG/cSzaUaBnUfZaCgrJTVzWfXzdK56ib8gLhSC3zH9c0jWUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWOAQH1hZS9QR+iQpMjddrRwrkncJ0xLtECzhPuYkl0=;
 b=MkdOJwbANTYvNfp98YqYUpjL/HHXpvVgXmA7MFx/OW//EWDyo4r7VByetpnYGix/hSXLZ388/HqvsIzz/jdILhiMb+heZFHtoktfjq4F25WTJjsgzh8U5m8nMjH/s9Q2fmCxOZ/l/aNAS2EjGumgmRVEuyVLCO5EHm0balz2NXYSvC+Y8seQPQX6rY1vXFyj82sT/fE/A0/upCo1SPxQpR/OI7H6l1miuwfrJQm+4XfkLD3TDAFxfWJw6TkcGpBBYxy6ofOOlXyppjl07qdWhXngt2k3UrCLQIjADm/CRYbj1wtz7i31za/2RRzRTET4qtN7/uDhVe7bGhaKKALEVQ==
Received: from AM0PR02CA0159.eurprd02.prod.outlook.com (2603:10a6:20b:28d::26)
 by DBAP195MB0793.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 01:42:33 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:20b:28d:cafe::6a) by AM0PR02CA0159.outlook.office365.com
 (2603:10a6:20b:28d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 01:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 27 Feb 2026 01:42:32 +0000
Received: from lws-haller-privat.attlocal.net (172.25.39.212) by
 Postix.phytec.de (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 27 Feb
 2026 02:42:31 +0100
From: Dominik Haller <d.haller@phytec.de>
To: Dominik Haller <d.haller@phytec.de>, Tom Rini <trini@konsulko.com>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>
Subject: [PATCH 2/2] configs: phycore_am68x_r5_defconfig: Add ESM and AVS
 configs
Date: Thu, 26 Feb 2026 17:42:00 -0800
Message-ID: <20260227014202.332157-2-d.haller@phytec.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227014202.332157-1-d.haller@phytec.de>
References: <20260227014202.332157-1-d.haller@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.212]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A8:EE_|DBAP195MB0793:EE_
X-MS-Office365-Filtering-Correlation-Id: a963c164-a9cd-4fbd-38ae-08de75a179e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: LR8MIukrdz5ijcYVp5p7QtNcHyfvDbwXQ67TXWeJFMU3hDsghwEj14RLGnULbNadz9+GWRwJ3kTSA1azAvpsLYe774UCw/jFsDo4ESI5mXE6xQyF7f8Vhw1NaAdLwXKBRFlD7tzdpF/IxXW+WqcVzt521HNN6otealANfJfgSPuTZLFOG2kQdcFksf3Fk+2jKsYuIQftfvrBp25PRUgCLWGkdfZ5d8bmVGlxJBny1b7SVcO2U6Sd0qgZIB6g6Zs6JKLxcnUAxgrcMt7MiVaTRbfruAsX9YU0PylkvF/TnryF+8o+b1RyBlHZSfQKQmPX2isKlIZNt0ZitS7J4znC5kaaG8+TRwVA7wEMs2+SqAO78+h4s/5zAgp//4r6DASZOwYYi9rz0a6M9HY1hIi/C/j3pLUEJJnINnmtRChs9jFKhORD4PKD9ouK8HrPkANXDmMFR3kZ3+Q+RrBo+o6blk2D/tVZscVWLxYTrfuEehLc2Wx9iNamYD50UZOtXlgkRlApAq+ITty+ItMz00WgKZGNta56awjNLBL8Gyurj0dNHW7DymrOCPyO/Xw3YWbb4LJk8WYcbQ2sFQsdJi5n+SkotL47UMwKCIVBm1b2hSSfErPnI1FhsMdiEJv11AtayuyeqN3YeLi3v41d6AwmY+20rFvY0Wt9tYXeInkbd0L4/Md8vP4YLQGL7lSLdlffmnEOr5rXSvXOOLUWAFd4tzfIJLwACnV3iGVmLzGOUuBl70KOzF/uPhEUHM9UCnoQ91DCDdco21W29iJOnL0vj2/w8peZHjKmLkEUBF++1UfG8NNl2k3+ReJ7FjNvDgzO4clsGdRZ2og6bwGaNRE49g==
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: osRKjgMXQgRVhU0/Lag7YqI/VUC3vwtCMXIzKPf+2KwACCZRgppG0RsEglMR3i7aZVWVF6OyFrY/5wbA4w3US3rB1wUFVEcue5K8PY10AGjWoIsrt0iTDVTKrS4kmBAqk+gNe9x/kaKvsEtp83hZwaC307tsdf0y/oL0PErGoryEuOWmA9fss28nGHJg4F4vk90uuHIqLlVYk++I56sM/E6uBVwN4ghF+KkCNMODkk+z8GObfRg9Jk/XVJgigSCG1IxsyLMFEClnPV3aznq6OmAGRWfVjAUtC6dgaCeNUuZKh/7a9lyZkq3Rama7uvvBZqW6uM2xlVIpG5d8jNMKr1jun/Fcrw3ge4sjxb1kQzlFHBSvwDhc/Vu5TJEu85VdpTIbNIgx0ei97wu35UnegwY3TFiGCDUmVy5VIGCMxzbpME70BIo+KYu9pLRjWDsQ
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:42:32.8258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a963c164-a9cd-4fbd-38ae-08de75a179e9
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB0793
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

Add TPS6287X which provides VDD_CPU_AVS and ESM_K3+ESM_PMIC for the
watchdogs.

Signed-off-by: Dominik Haller <d.haller@phytec.de>
---
 configs/phycore_am68x_r5_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/phycore_am68x_r5_defconfig b/configs/phycore_am68x_r5_defconfig
index a503bd274411..f0bf98bf44bb 100644
--- a/configs/phycore_am68x_r5_defconfig
+++ b/configs/phycore_am68x_r5_defconfig
@@ -105,7 +105,9 @@ CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_FS_LOADER=y
 CONFIG_SPL_FS_LOADER=y
+CONFIG_ESM_K3=y
 CONFIG_K3_AVS0=y
+CONFIG_ESM_PMIC=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
@@ -139,6 +141,7 @@ CONFIG_DM_PMIC=y
 CONFIG_PMIC_TPS65941=y
 CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR_TPS6287X=y
 CONFIG_DM_REGULATOR_TPS65941=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
-- 
2.43.0

