Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066FDCD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 15:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B41D8493E;
	Wed,  3 Jun 2026 17:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mHhZ/7/G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FC6483FF5; Wed,  3 Jun 2026 15:30:26 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BA2A839A8
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 15:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Jayaramudu.Desapogu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiFpnP3Lv29DBar+ejumzZt1rHuhTplnNcMqQa9TPhlCaVJjJcgvEWpvGGMxz51YIPcaXLAGVDJ3j3JJyJ9nIqmbW0WCL3Q+t978Q/Ib28e1RETC66FgdoqYGXN/zsTRbdQ2pj0fmvftesAOA5l4OP7VpQ6VCnOjyCdxJLPQfRJnMz27fYu4uXEXHkYqTdebqWg56LKK2TkvWceFcw/ITZtKNn/ZAHvixJg0lkHZaHVypiwI9Ifr29jNk11Y30Frn/9tBD3ii4Mq+zjok2uTMBTzdmVyArAzb0f0SQjrQRJIc4bCcAAkBMujTAvj0c0TqzMA8yDfAbuFF6AildhkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akRD0jbgFkj1b+jZdvNFxTNa3IzLzSM46oWMyfGAhrc=;
 b=Y0pOuOHaoIfoms1toVCG8+xlv6O3kbqczXgf059d7eByiDDBBfpt6UFe63JQLaTaUiG26NF77TeLZw8AjIW7qcGgHYHGw5aOw2YpTyEQxEo8VWbJZTX/YimhKkir431px09Ygozfl5Ao2F+9t+e7vXPOkl5PPvkIKYQ4FLNqlQ8uDYcIjpS4rEYTxvTc9RHhGUWHoDK7VI4QIjn19SxiT3wgnTgwqUWPdxC591rZdQfT1n3FwF09pZIPBmW+7MN+UQoAcnrICxYiNFZhu6tM5yYEBzCPeTLhPSf4Q68/mcSPUZ9OtbTYHSe0huidM5/a+MwUi7Q3gKAJTH97PgrzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akRD0jbgFkj1b+jZdvNFxTNa3IzLzSM46oWMyfGAhrc=;
 b=mHhZ/7/Gly80wipWA7rdeKcYUUiG+JOVCZLPxITzGqGvz/jscYaQSykmb0FN8hUuEarc1NuOawCmrOIS+mNz/OUWzmHxUi0PmIb9IB2mHrqVnYTTWcHZZDpcWNbTN1iOvdqehOZl5l7lR8f9iGnq54f8XotHMTx7RnYM+3pHmMY=
Received: from SJ0PR13CA0179.namprd13.prod.outlook.com (2603:10b6:a03:2c7::34)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 13:30:20 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::55) by SJ0PR13CA0179.outlook.office365.com
 (2603:10b6:a03:2c7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 13:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 13:30:20 +0000
Received: from BLRJDESAPOG1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 08:30:18 -0500
From: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
To: <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
Subject: [PATCH] video: fix no display when serial console is disabled
Date: Wed, 3 Jun 2026 18:59:53 +0530
Message-ID: <20260603132953.36042-1-jayaramudu.desapogu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: ace4ee7d-ef9a-4fbb-9a8e-08dec174423c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|3023799007|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: RfNBzZa5BT/F/R6syMqARzq8x58Oo+giYMOhmbP6vGuiKM1TU++V8k8eYLAO5s4rIz26A549fo/TD3WUFjnv9pE+JDuxDOe5574IVTF0NbE09ufMXBPj5zw6geZfqpTVMVaUyeNXUvHXuFm44wnT7jZoNlw4VfsWG+4Xi+/0sFkR+AEa+mWr19Ny1IaGdOp9dCT+afoBK5oe9E7xDpo2CYLmDn0qXPSz+FVU6mtHXO6y0koZauEiPPo3r+huyF8Hee8CUz1hWRBP92HjhNG4u4jrWkW7pG0MLpMYuz2XVp9M+g8mCxdir7hCd02VbE10g+Y3vBZneJd+cI6JATZWcMuObC9dl2QaLbAyVzdnqHsrCCfnlISZWPYqMvlc0Dl32T49BZIvCJL+F4dYFfpE1ms//2TsSzNE9lyjVt2hLTUZZKbpsDPlOVQUb6G2nyRg5SP6IJ8/uL+atgPIchbG8m+Ru37D72lUwyZHe9EKaFFhuCeZk6FsnMOHT8OOf2lkizxYvIiUAln+rHjbXPnwE0SOJotUhJCoVpxmB+e/4heK/zcyzVATyTcRid3hye2sTaQAjaugjWWAL5ocW9YbajLU+qMaZVpxEe//gyDiHU6b2ImxiCKR0Zr6K+oylkKiX2evMhtrT7J2W38YGiO7Cfyox3xxZnKIHqMoFQp9bf+Tco/+A4Mlqqkhd9t9gLt00mYSkvDnU6Snwfq0PtsVn1MFsn1x5Z2JulMr2OmHPzM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(3023799007)(11063799006)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c6nHNTmbv7xN2e+V752lAzBy72rJT0haMkWpkX7NWJUeyJFpOXJ7DirgrqcbpRjZltKR55Qc9ss/XFcWFlPb6tvhq8Z7PAyr+jyn0l66zmWA6w6yXQB0/Eg/5mA5Iv5AdCSL3/owu3ESj6DG8aqtYePKyEWIjaxdvM8obcaXAfuYftMKF5Ep3/mMFcybdXZPXV544rGenAk3pepUhZ3BZZuOqG/YYl3xZH9hR8QgZpDoIJUVmvGNnaJznivrF8Kc/Whctilw2JaQRCIYgAiZJzAdbpfHtEDvqd/wKWlHZWdy/B7sxa8RL+UckBCogHRpDi2UAOMXSN5cJA3tjMxSbwtZF9BWbjj6a/46FxC/HzeLThcNoSoG9/KsCltQvLrf++yeIWgSajmRjEy5QR9X96EU7WFneMSkxhL+BI7ff43zG6eldey8cfZNUgNglbLt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 13:30:20.3561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ace4ee7d-ef9a-4fbb-9a8e-08dec174423c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052
X-Mailman-Approved-At: Wed, 03 Jun 2026 17:58:19 +0200
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

When the serial console is disabled in coreboot configuration,
no display output is observed during boot.

This happens because DBG2 (Debug Port 2 table) configuration
is required for proper UART initialization and affects the
video initialization path.

Fix this by ensuring DBG2 is correctly configured as a
16550-compatible UART, allowing video initialization to
proceed independently of serial console settings.

Signed-off-by: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
---
 include/acpi/acpi_table.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 4895366a618..3517698ff3e 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -667,7 +667,7 @@ struct __packed acpi_dmar {
 
 /* Subtypes for port_subtype field */
 
-#define ACPI_DBG2_16550_COMPATIBLE	0x0000
+#define ACPI_DBG2_16550_COMPATIBLE	0x0012
 #define ACPI_DBG2_16550_SUBSET		0x0001
 #define ACPI_DBG2_ARM_PL011		0x0003
 #define ACPI_DBG2_ARM_SBSA_32BIT	0x000D
-- 
2.25.1

