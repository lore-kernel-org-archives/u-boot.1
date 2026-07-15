Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833F3C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 13:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F6184ABB;
	Wed, 15 Jul 2026 15:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lyJPXwvR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BE8B84ACE; Wed, 15 Jul 2026 15:41:24 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4A5184A3A
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 15:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Jayaramudu.Desapogu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B29ZFVIikWXgkmKQLETp1nslPdqY+/7pzxW6lKP/vAqoc71NOf1pIqUaQ/HE/Z2i0k1nUm5KIftIGiaezjQ194DnFLNG6QHn98x1MS5N10f+ir0Tty2Js4keEd5ND5S93CPPGpigZKdxCiEuZrLUKA51AzqLU5eho2FSrO/3OUdO84bSTG7wvTrgDplhlZ3Tq7dbFVWnDlBvlroXRtE0iie54MlPFhj4q39MfiaR6yTShRv38DDKid1CoRcC8Q/TmCjyfwJwdjOSiy4Veothn1E3Ht7TNLvTc9l57z4xacdkeMMz/A6jbcMitOuVlpVewcClZd3O6Bd5kKVn0WyIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gR3wRoCem3pwCkn0jcNx2I+glk/3SJP5c+HOcLyA13M=;
 b=l6LEdopXSBrYlOJfhibaMu8WTSCFRTYKZVzj/FMPW0J1VCyvWE1r72ONQep0kgKOlMnXG+9beTnoxOqCGeF5rIMGQJxjNby1g0IPgf+83m9ftT4HcnbZis4Mv7CPcJufUf5E0c+8xWS1MBQJ8df/ck3XttqJGkiL+TkqKk0aH+loTA5t3dARCCsNVQv8DuVWiWxiGFwnRgAyOQUR2v7tqJcaCoSoDx2FfruM0wi9qRr1PqtfT13EzMHcryvlQn57SKs7pEpA/AWfAASHfU5lzio4unJMeUDQXRBBgccqcb2h6QwUUuNCsZiZuSoe1IMg4CSvJp8JOYeYbGToZFI3Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gR3wRoCem3pwCkn0jcNx2I+glk/3SJP5c+HOcLyA13M=;
 b=lyJPXwvRpT6hpe8kB7QbEDoy7IxnTXXvORmDYBBNBrZEp4L2vPefbDyUlJVGJ56TLdm0H8Uk4058wTmKBfGlcToVaMo12TLKOOt5HUcXzxA0KHFrInVUY8e7Tgp290Bji2Va3NuUwnoGYbD8Q7YBI1C6o/guKAk9tpq1txk/N/A=
Received: from CH5PR02CA0009.namprd02.prod.outlook.com (2603:10b6:610:1ed::10)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 13:41:14 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::8) by CH5PR02CA0009.outlook.office365.com
 (2603:10b6:610:1ed::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:41:13 +0000
Received: from BLRJDESAPOG1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:41:11 -0500
From: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
To: <sjg@chromium.org>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, jayaram <jayaram@BLRJDESAPOG1.amd.com>, "Desapogu
 Jayaramudu" <jayaramudu.desapogu@amd.com>
Subject: [PATCH v2] acpi: fix no display when serial console is disabled in
 coreboot config
Date: Wed, 15 Jul 2026 19:10:49 +0530
Message-ID: <20260715134049.85424-1-jayaramudu.desapogu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 2747fb96-924b-49f7-8e17-08dee276bd1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|3023799007|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: OwClm4ZbaTtgj69A/93z9uzniekADu6yRgGZO3A7npUsGa4gzolUmPiSM80s3biqoJgjIJddL98l/IfdVH0ihVW+3Q9gkKKOjCqZS9I/3vxGbb+ZuEhDtRa7N6Hm6j2waDYVQDQpCwrpU7zLIEzNOpCO2QKn/Z3ToUUNjDf/Og+JkXwl3IVR6N/zbxbjPP1yfQYZFC0b9ug3XRG2Tr+26MeAqsRSuQF/qyZ66db8nwJnBv56vbaFTjgahR7Y+spPAveqYz6HCZ30PMKIHHDwJQdqrQHqRnBrfsUuRv6ZQdQpRzkBQ0PNzp6CWoHzDZXx//bBPUn2C0HZupvMFGgIgNaBqZ71+TqUia8dPhCuDLqk9w4xMux2iPnU9D9ziB7g/Biu5TZH4dYBoel0djGdpHJQmKsT4Z/YsLziXr9KCwdOYc2C/h0H69ScxDUzi94TYqgOIGRRIUYDZlRxwQPAlSWrUoMMZt9QATYaA4GutRE5DWbQzOjzGE9qPYWe1s8tWfzxDfiQNxdjLdY49hdxrxDFqDkxF1MoTJWJVGeJafv+59kWXMCEdWekFkPX0nqvE7knduOBF9gfxiJzx6YBwehOpgs4Z5P7FP5DHriw66aM5hLoT7N4HpnutEgAunkFQNQjYtQTzCA/ngpr8uHAeXCv0qSTJCWBZXqApEiYJszRw2aI9CCbz/8twrWJnrGtfAhlqqaic7ZzaKKWh/DpJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ck+kMxDepYUuBKjV7kRA/iAvP/QbbbkfL0lsRmvCxS0xPzG0C6Egc9sEP8rWdQ5EX21nBrNKWIlJ1FMBVmw5rkuEmcnfKUGHFcOc7fo5WeRR4VB+3TyRCXqWJn+omYi55GWcTA9VtSBjCNUILMCkIcLeFQHuAZ5I5ta8/frZaOGgxxHIl1EkBsfCc9EJvj39TqqjnamCUhW0m4YOwrS8MVpxBDIp2CQzwLLfuvZHBkMXuRfx6speMylb41QTL55Sj1l3mSEaVt0Hjpkqizuoi+I2N++ZnMSzyyN2qhaQ4qAzCy6Vl0dEZmN8+1CdH/hHebJOYKk71mM2uFvp4YTgNDSP9lIjJWcj2b0oGuCROpU9tozVOq9l9n7O1kjpVe32VdqIAm5mMXL5PldjbQjE1rj8CSyo5uZRuB4RKEB0J8MgiuhQlmNwE4vUJKTruqIk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:41:13.9498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2747fb96-924b-49f7-8e17-08dee276bd1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205
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

From: jayaram <jayaram@BLRJDESAPOG1.amd.com>

From: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>

When the serial console is disabled in coreboot configuration,
no display output is observed during boot.

coreboot can expose serial console/debug-port information either through
coreboot tables(lb_serial) in src/lib/coreboot_table.c or through
ACPI DBG2 tables(RSDT/XSDT) during write_acpi_tables().When coreboot generates
a DBG2 table,it is publishing UART/debug-port information (IO or MMIO) through
ACPI for the operating system.By default coreboot assigned subtype
(ACPI_DBG2_PORT_SERIAL_16550 = 0x12)for both IO/MEM in src/acpi/acpi.c.

U-Boot as a coreboot payload consumes serial data either from coreboot table or
ACPI DBG2.When serial console is disabled in coreboot config , the coreboot table
contains no serial data.So U-boot fallback and check the ACPI DBG2 table for UART
serial console using 'read_dbg2()' to find port type and subtype.Currently u-boot
reads subtype as 0x12.But u-boot in include/acpi/acpi_table.h subtype defined as
0x0000 this value suppots only port I/O as per microsoft DBG2. For AMD platforms
or any other platforms that use memory-mapped I/O,we see display issues when serial
console is disabled in coreboot config.

Fix this issue by ensuring DBG2 is correctly configured as a
16550-compatible UART, to support memory-mapped I/O in include/acpi/acpi_table.h and
checking the correct subtype in drivers/serial/serial_coreboot.c.

Signed-off-by: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
---
 drivers/serial/serial_coreboot.c | 2 +-
 include/acpi/acpi_table.h        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial_coreboot.c b/drivers/serial/serial_coreboot.c
index b1f69f6998cfa1..f6fc0fd8ae0f67 100644
--- a/drivers/serial/serial_coreboot.c
+++ b/drivers/serial/serial_coreboot.c
@@ -59,7 +59,7 @@ static int read_dbg2(struct ns16550_plat *plat)
 		log_debug("Not a serial port\n");
 		return -EPROTOTYPE;
 	}
-	if (dbg->port_subtype != ACPI_DBG2_16550_COMPATIBLE) {
+	if (dbg->port_subtype != ACPI_DBG2_16550_COMPATIBLE && dbg->port_subtype != ACPI_DBG2_16550_GAS) {
 		log_debug("Incompatible serial port\n");
 		return -EPROTOTYPE;
 	}
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 4895366a6188ec..aea608f0ffa7a0 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -668,6 +668,7 @@ struct __packed acpi_dmar {
 /* Subtypes for port_subtype field */
 
 #define ACPI_DBG2_16550_COMPATIBLE	0x0000
+#define ACPI_DBG2_16550_GAS             0x0012
 #define ACPI_DBG2_16550_SUBSET		0x0001
 #define ACPI_DBG2_ARM_PL011		0x0003
 #define ACPI_DBG2_ARM_SBSA_32BIT	0x000D
-- 
2.25.1

