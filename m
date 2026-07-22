Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942AFC531C7
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 12:15:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D838480EF4;
	Wed, 22 Jul 2026 12:15:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BzAG7xzgVt17; Wed, 22 Jul 2026 12:15:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 13D4980E2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784722546;
	bh=Hm2jeBjoqQsQ7nTf2LaRpE4QxUXn+Uh5WGXVJzOMT0M=;
	h=To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=m9AvNeURnAjXqZgnqBB5E8ikgT5ZkGmTxFugF++Gs99fK/TB8kYeI2TpNrGAyhAJc
	 0DSdN+YmSF3ALywpE6N8twT+XOgecQb3RmERPaTKJETWEYsQXpdbcSl+ekjil6+XMQ
	 ELsGNij0AxUkRQuTCdyTsYe7n9406uD83X1EXfPoAfxoqMK0J8Iii5r7ebWydMMZQY
	 QWLn3UpQrUnhbIytZSWqrOK7AjDQFg4PXTUbZmXv1fDO9YRbi8hQXCyqt7u9M4Homq
	 3tm7OlTK3CikZfgtZOMKcRvtgs3udzuFAzxfJfF+2Nl/0y4yfiM9Lps6xUceGCvTdW
	 C2spAlUf+ORxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13D4980E2C;
	Wed, 22 Jul 2026 12:15:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7426A788
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 71A5B607B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:15:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ddACA0VTV1x for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 12:15:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::5;
 helo=ch5pr02cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5532D607AA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5532D607AA
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5532D607AA
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fudO/c4Gpjy+Sim9C47XBAhziTH/w9y2RVTU9DMLZvDP0/Y00HknZg7zydUOgkgMnfqNhjwNZTsFW4Q99fvNwdkHLS7CHPtOcZl/IEvVeaUw1LsULP5ZjpkrMJ90vhjoQrQsGHc4H9xKYh5orMeim8kslLIgjhiRZc6ROZmJUmgXa1amPk780k+PMnkhjDywHlxZ8w80soZvwvnxakmlG4TmmU65CM7SQ1JiRbHljqfohNJtYRvMQ6L14QQJyUO6EkShjJcKTISfB61SApO3IJFzNRh0VA/d8Fp7lR7y+RTwvSntGx5eLvdXib8y8Ozj/GJk2Tof5hK+77Nl8qPWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hm2jeBjoqQsQ7nTf2LaRpE4QxUXn+Uh5WGXVJzOMT0M=;
 b=IVhrN0/5dxHdLcKaC38w2GkgJU72x01UzArD4oDz7gsGz/FKrcbNKIhUKPVJ4tJHaRXpl71VUvyvM1oTqAWym5IJKvbfCJuM/XQbtOv4z/R723s5Nxm1QHLuacQPFvgcFg6vAp1CCb1jrPFnl3w+q6xCiO3bfKmRY2lUKt+g1H1eP3IuQUTuaj+bUWqjYsRhixzqM6OWdX5kdPmJJ5c/Utl8ZIivhklBDbw4yOzb0l186ice+EYfVV45AHVq3Y972dPTpk4hed2yakhRYhXaaR+RFLqLhZG3pefVIBR/w5ZoviD8IC3Zt7Ng+RardRBrHKdd0yXfm7EKad1Fg8rbEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from BN9PR03CA0270.namprd03.prod.outlook.com (2603:10b6:408:ff::35)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 12:15:38 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:ff:cafe::5f) by BN9PR03CA0270.outlook.office365.com
 (2603:10b6:408:ff::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 12:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 12:15:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 07:15:36 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 05:15:35 -0700
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 22 Jul 2026 07:15:35 -0500
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] xilinx: Enable CMD_NFS for Zynq and Kria platforms
Date: Wed, 22 Jul 2026 14:15:26 +0200
Message-ID: <6c05c5dd87fc1e53a4d4328d3b6ab70f7b49af32.1784722525.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=RXXpXeD5Zg14PaGkOVKGnq58Js0nIdFvO4Io1ELshjY=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQlbElg/fVo+qO+FiEV82vLu3RP/f4lxWQumXyo+fiMm
 ORyw4uHO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiG64z/E9f+Y750M/UOUpV
 uUvn/P5u/FHbl++5iejcby/1ZTpXbspn+B/MExnnr5aipj7Pg3HGlO9JTCf/pR0TFgnZOU3k+tX
 vu7gB
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|DM6PR12MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fcb429d-aee4-4365-a7cc-08dee7eaf017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: A/R6LoK5tMYVVbIAM6s7cR4CzjXWrGK1NMVkyDRNz51y0XXRQH06znsRhLBDlQgbNDSCn/SvTHkYvBvNaqOyJMnj7CDEm7L6YpQZCh1DCcObrYo/VDVKac0ZOavPbQnQU+QxBfBh6FsPI1CIliKnYKZrJH9c2vOD4rFTaliaX0dzvLU9/hqL3HyyLf3O65/MzhyNQinY7E83799alNeC4eoIZC8nA2Dbw+sBUpd+6R3jv3AM8BoC9ZCbvhn6NcyVUuQEMQV43zp1tOFDq04XT+Fn8lKTC2fwPkhlwWPucziSb3AmP0oq0zBP7/Acblnz+e1oX/5ra5GSDyRHEq9UArxeRAqdmB3o0wgvfw9ScbmF8e9NOkZp6GW6Lud0bZcQIbpG0jP9TCanxCT7Jnpiqoqnpx6xYSPJ4fPyyoMDwQ8cMapa2zM/q0Do8LmC8mkY3GilgmhQ1wODdVrsQRYs42zl0bZG/90NsTgo2XQFF+8OEcdsYQZ5krrZgkIuoBwryrvE76r75pB+yQjn8GK0u/9md0YJaoi47p8/QIZC/zFBdwk5X5M577uhl9xVZwxiIxKnUiYYMiOZ3NshYNYmvZlyy2wPppJBNADM7gOc+odIq1KSuEdl5FnSs2bLxlRyOcDROAfbYu51NeSG+LtEPUGmVVIEvopL0wkfIoR/de60qs9JCbDc6Eumxr/KJgmt2r6eeSCxwT6EGkT+V/nWpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rZWIzSHLvguO1WmQbI8E0WzpHwqMaUFvG1suK74h3jWIPyzYaAmaiCPi9r0efPrnR7KL3wpKHRjtMtiQDXO1nvMCIIOaVCe5CI07UATfWSrJMzldf3K/03HA1Ee+gBHmfBpy/Z+ntqqKcOh5b6OFRJOGOKAZFEEICx54dMvo7giYuc1rfKDLNUvtsaAqagHwiJYcTbRimBvt0U9MXXjwDk2OKSd4WX4h4pYRiVlQneWRh+1UPcvtQGMLkEu/QhjJylIiV+re8w/gxHMZLL7vR0LIPLparzgySCpVv1Zs7gfmX+kjNONYbta2iImCqueO3XaoL4FWHmsLXp0ZWDTbQaqwt1TQ5A8h4nJUT76rZgVLqBrR2bAfLe8SVMHFReXLrZfES/1rBG1avaTNkde0O7p9ni81o7x9U+swPKX2FGugXWtfaKa5bHhW+xxlThEH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 12:15:36.9207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcb429d-aee4-4365-a7cc-08dee7eaf017
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hm2jeBjoqQsQ7nTf2LaRpE4QxUXn+Uh5WGXVJzOMT0M=;
 b=rBNlUvbIa7osbDDj7R/yi9TMzjfRuqvjhOAbhq2JUkZgyU09GWGL2sP5OM8f9r+3w37pGdqpZ11W6iib6HVOlIHQR/VAcIlJD/EnTBgtPIfr+bm6KmPfu8F0xLZDgGU9qVwJCu0z6H9s9pjCtbLBQ0eRHGLd7jZP0edh7BUjUpI=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=rBNlUvbI
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Michal Simek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Michal Simek <michal.simek@amd.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable CMD_NFS for Zynq and Kria platforms to have it available by default.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_zynq_virt_defconfig   | 1 +
 configs/xilinx_zynqmp_kria_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index 30ffe28298a0..b7ef9407dcdb 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -69,6 +69,7 @@ CONFIG_CMD_MTD=y
 CONFIG_CMD_NAND_LOCK_UNLOCK=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index ba4fdb9d657a..877e6c7f474e 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -82,6 +82,7 @@ CONFIG_CMD_SDRAM=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_BMP=y
---
base-commit: da4b763f29446ca22856e0f681076e5d27268c05
branch: debian-sent3

-- 
2.43.0

