Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987E4C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 15:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D444C80517;
	Mon, 20 Jul 2026 17:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m4ZaoSEd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D35582991; Mon, 20 Jul 2026 17:49:02 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B53C180433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 17:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Jayaramudu.Desapogu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPygjj6V72p6huBG1Y42n5FkA3dYnf93jM18KWCHlphsDE1QOxvlrr4D6d+ch3guEgXQWXF3u/RpLRd9CeirNN3yiWC4rO+mN8mwnIoItp8dXkFMRKNa9YftVjj3sneqd9nqqyoUOu5TV2x6wUC12gC9rJvXp9wfSg8w3Fe/EPdhz1EEE92c2CkTGR72F0K2b562ft1rw7oQW1Ntd0EGiIUo/iM1hF1yxTRfhs9xUUeK/d6azY7IZzGqWvmrmsG4TEA6yS4fDeeBUY9x4KURKv48AueQ//LHOYYJjzmjBJjqK6T5mwDJSXgwDAExgWn/QEogb29yT9vtALvhPMsOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUwSw564M8cuF22i2j6qzp8NZmgd55qoT3VES6C9oVU=;
 b=Fwdd7OWKqhVNtPn23z7CnMlrr8zWMlQHI6XHv03SX97Dfs5MzNqrjEMKRnB2jkm4iq4ldXAS5lmmXjSr59LOP00vKbnaRNbtOWP6Ku8bgYNgG7cfqv3vmUKVM+CZD8L4THQRHiMbseXfha4sYzSANYUg/bQvhMwTzMEW/EXecIaAEJiMtzK6yxHhaqd7mD7ufnzK4bjjVX2Q7fmp0WECsvFEZrP/wm2wUs3QzbBFLz4CgS4eJSlEfdtnIy0LsV/RclPnUd44jfeSgqqrfvUNcL4g5FlIBRXJCaLTCGtYbhBjCrOmeUIFT+w6H9FA+lDwoxNZ0pU1L6QReWgBDZWLmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUwSw564M8cuF22i2j6qzp8NZmgd55qoT3VES6C9oVU=;
 b=m4ZaoSEd3lZFB4C8hHLEOtXfSNC5/l0/nFJ36f2jMQFzFEUFIl4guBR7vTNVlLEAN1Mjs2RqmxeLvyPFkRJkR2cZgkVRwY09sLcFVDOTZzYRnGhXRS4pd+LrqYLXRknj6j33bd+vSNl3EBHWBF/mJZAUR4gEug/yWurqXWYVEIw=
Received: from SN7PR18CA0030.namprd18.prod.outlook.com (2603:10b6:806:f3::7)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:48:55 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::6c) by SN7PR18CA0030.outlook.office365.com
 (2603:10b6:806:f3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Mon,
 20 Jul 2026 15:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 15:48:55 +0000
Received: from BLRJDESAPOG1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 10:48:53 -0500
From: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
To: <sjg@chromium.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
Subject: [PATCH v3] serial: coreboot: Accept DBG2 subtype 0x12
Date: Mon, 20 Jul 2026 21:18:26 +0530
Message-ID: <20260720154826.42527-1-jayaramudu.desapogu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260715134049.85424-1-jayaramudu.desapogu@amd.com>
References: <20260715134049.85424-1-jayaramudu.desapogu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: f31be054-28d9-41bf-d964-08dee67667cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|18002099003|22082099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 587t5kJi1qXSBM9F5MwMGZW8CgTygxMdzdeZ/fGsdSc9S0AbLcrdGTTrT9Cl7kkeOgRozG/53g0r96RA5fO2Oz54rKznGQcVniIsqoz0rA4eaJvyJx2PQXqcAJ7z6hK4Ou90ZJDL9v1ZdpBebM9N5RAnmDDs0lG3rpkmuO+4i3Vk1PbiV92+RrBhqitGvrOZQ2GpAA5bln1sr2uz9skzb9YpVoXqMeBD5PIkenplQQREAW2xmuy1Kq8AV/C1MHxzqMJvz/NStHOobkLHnKC8EvldXzj14CfjnWpNJgBwvqf5be1dTrTC2SsYyrnyP1jcrsV7p43XAZZGIJB3DbIzYskP3DB0ahmzDTedpRnCzmdP+bMejEOCWJRN8R+YEX5P76OYYjMlF1B5lOt4P/j4BiREH/QOxAN4n4VAv9tb3AKj4OtA2mE8jpnsp9rmQs3LlOJaDAu7pVm5ILIcuWS+NSjeK5/Ig+S9EhmAOYMUFIw/sDfQbnQH+b7hZHTIFPQyArvgEJJV3FriQSuAOS9sADb78LcOKw3msoZeEdFF0/gjobFb9kZLLzwgRDYceE0laQDPqJusGgva/QvCjzoynTn+whOmcDIDMdYPMaf1SKcKMJ6PHdWKZE60YKpheTXpq4SHXLbzuqOYRP9kAQdlFsVD5ElDopmbZ4OscCRDUEFz2xphuTQLAMe5fbQWaj9u+ISMnYuC+AbaTUWUEIqDow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H7UqMfipFCMH811PrxjFt/JwSfzbKr5rpj8JJ7HaEqC13MyGzPHEacKyO2x+Wpav9DyVsy2jx26fTafpEvOZ425D4ps3erqh20c74vYUzKdsVa78NRoA3qSduylb7PhrgFFRNNy++eteFLIKZHCbqC79tdnE6g175BiL8OLtMayh1VUrAgXJhOw181htAJk3OcCo7/QOjIqVK6wyRCgC/iZTGMZogWoqy6mhKRhWI9b1tJGfCWPvrAIudVmkPjKwzkNCN3t8fsC1a2w0zlfXtKIXF7xFAEZ+P9w3a0JkopJKboEv1iLR9PsjwEBT9yyfgFBtrZoP73VkSfTkT9c7pjhWA2qPsCYKgzyEZZRWuniR6/li14G2NdKQM3hY40W+xRDJOgb1ATiddjuSRjwABY7KNXErR80r+0MjCzoxaFVFbA5LRuddfnSY/Sq51uqz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 15:48:55.4652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f31be054-28d9-41bf-d964-08dee67667cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255
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

U-Boot running as a coreboot payload obtains serial console
information either from the coreboot table or from the ACPI DBG2
table.

When serial console support is disabled in coreboot, the coreboot
table does not contain serial information. In this case U-Boot falls
back to parsing the DBG2 table.

Some AMD platforms or any other platforms that uses memory-mapped I/O
advertise the debug UART using DBG2 subtype 0x0012 ("16550-compatible
with parameters defined in Generic Address Structure"). U-Boot
currently accepts only subtype 0x0000, causing DBG2 UART detection to
fail and leaving no console output.

Accept subtype 0x0012 as well and keep the existing handling logic.

Signed-off-by: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
---
v3:
- Change subject prefix to "serial: coreboot:"
- Shorten commit subject
- Remove extra From: line by fixing git author identity
- Rework commit message formatting and wrapping
- Rename subtype constant to ACPI_DBG2_16550_WITH_GAS
- Add comment describing DBG2 subtype 0x12
- Keep subtype definitions sorted by value
- Wrap long conditional to stay within 80 columns

 drivers/serial/serial_coreboot.c | 3 ++-
 include/acpi/acpi_table.h        | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial_coreboot.c b/drivers/serial/serial_coreboot.c
index b1f69f6998cfa1..cb07173a80c0cc 100644
--- a/drivers/serial/serial_coreboot.c
+++ b/drivers/serial/serial_coreboot.c
@@ -59,7 +59,8 @@ static int read_dbg2(struct ns16550_plat *plat)
 		log_debug("Not a serial port\n");
 		return -EPROTOTYPE;
 	}
-	if (dbg->port_subtype != ACPI_DBG2_16550_COMPATIBLE) {
+	if (dbg->port_subtype != ACPI_DBG2_16550_COMPATIBLE &&
+            dbg->port_subtype != ACPI_DBG2_16550_WITH_GAS) {
 		log_debug("Incompatible serial port\n");
 		return -EPROTOTYPE;
 	}
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 4895366a6188ec..825652798166a4 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -674,6 +674,7 @@ struct __packed acpi_dmar {
 #define ACPI_DBG2_ARM_SBSA_GENERIC	0x000E
 #define ACPI_DBG2_ARM_DCC		0x000F
 #define ACPI_DBG2_BCM2835		0x0010
+#define ACPI_DBG2_WITH_GAS		0x0012 /* 16550-compatible UART with GAS */
 
 #define ACPI_DBG2_1394_STANDARD		0x0000
 
-- 
2.25.1

