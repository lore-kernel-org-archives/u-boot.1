Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE897C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 05:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0F7D81207;
	Tue, 28 Jul 2026 05:02:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7GP8hdGG5Sa9; Tue, 28 Jul 2026 05:02:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92841811F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785214968;
	bh=YLD6BamMdGZEWcbmIT3CjlthQFnYF/inyPRqiYQ4HZs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tlqIc6V+lzkSBSAUI1ZVfpHhd0gglJqJALiReDOzVr2VQY4QFnnfvA4+KYXTGJTPL
	 chqALrSsN8LwraYJ51znm0ASCCFplW4kuks/EoRKDO52iuPFywcLzPvlt1rpa24q19
	 1FwhVbInRJKPIbWboQe10OjBGdTB8rOadW0e7QkuPFWdyDEh0zeFFsEQp/aZQYArV8
	 W1pfUpqXW4cXmtNuxu3mNSWjI2bxV7baAYuL8nrBgQDNUcJ6tVMdFtPu+420Vy5h3P
	 9aR/tueo4hNn6rZZJRZB22bGEpPhNgzqCEbiWVMqjWiMoFXmOo+Tn/DbHwDXg27btf
	 59QY6rTS5Xm7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92841811F2;
	Tue, 28 Jul 2026 05:02:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 303E326C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:02:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2163340084
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:02:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6dsJq55dCVIc for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 05:02:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=jayaramudu.desapogu@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 751AC40024
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 751AC40024
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 751AC40024
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvIv6zxlCSNbkz5zdC+5rtD1FvWzNZ2uTrlTx8mxtRD5HLsl5A3njjaVBWSdnD+H/NexXxp79yOG9CwTp7CyCqW+F3Rgo8q4zkHUGJapJiyln/xEcq+dL7P+hwXwGAd7Aa2SQ08/xyaES3DMgJlBpKFU7kw2pgTaVl2nT3Eyo5xKfHUh8w1kgw2TZZpUwTYJkKdgoDh3dnixipOR3JMgC6mTxqYGpgsnyt/0prmaK7BVJugKIaX+5+Q0vROOwr6+tMBNtOB/CfU+h0T9xsow6uLkETkrXXbqMVhapIMD97RvM8xUj0dBL2lrIE7FWc/Yqr/v0mPLRNYonf5BI9qiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLD6BamMdGZEWcbmIT3CjlthQFnYF/inyPRqiYQ4HZs=;
 b=lunIAI5RhAIbMU8OjdCS+eWxwFHSZwPzMtzzeLgxL52NlFt1mqztICL1K2LUFl8Dz47oqlyJyk6c56X2aT2HUMoJVLzTxNYavfMoWgLoj6NaTTg07a2RyobnDfQsNMtbJi1pKJKwk4cQAWKjTOZoBGCOxx5yrsxaPoFyxpvoPB5zPmtKyzUvBxRmJr0uLdS8bIpjjxSkTEj8YxV4CYEJYQP/P3xnT9xdYqEtxt6o0UPVpxUfuue8YfsjgChjUaIuMxNMdtZUu+MewiLMoQFRYXqwWdk0GS1Pr8LLwn6R+jRNCSWcgj797WcmQ/YYNA2rLzzyRDEn3iyDO7Aaw3J1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from SN7PR04CA0215.namprd04.prod.outlook.com (2603:10b6:806:127::10)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 05:02:39 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::51) by SN7PR04CA0215.outlook.office365.com
 (2603:10b6:806:127::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 05:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 05:02:38 +0000
Received: from BLRJDESAPOG1.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 00:02:36 -0500
From: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
To: <sjg@chromium.com>, <trini@konsulko.com>
CC: <u-boot@lists.u-boot-project.org>, Desapogu Jayaramudu
 <jayaramudu.desapogu@amd.com>
Subject: [PATCH v4] serial: coreboot: Accept DBG2 subtype 0x12
Date: Tue, 28 Jul 2026 10:32:11 +0530
Message-ID: <20260728050211.35542-1-jayaramudu.desapogu@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 83affac0-d34f-467f-43b9-08deec657240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|11063799006|10067099003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wHDic8kTNFyJKj8xK9LqHsAgscFLuaOyDtEXPTFwWcFgJaE+H+oWnY4V+JWP2D51xlYlBjze7tgUI1JnLoU9b97U8aG66Yx9iG9OBO3dFt5Xw1awkvj0rGqKbf4V6A2BQmhzW5krcfP+ILdXHeG7S4sO9s5sNffustGTaxBwNI28jJ2jVLE1+WW7OUokX/gS4sGSy8M6rj3GxWetYFPt6Pp+2CvzGq1HL9RrnmZSR733fSh2DqC96PuOz1DO6S3uguTyk3EzjFAdVxAvd3l9yARSzj46dH9MLgbjlcRMKRyEIZqzZzXyxe1ZyOxFGg9BD+AGhEv+hhOr9pbPRhKIxIfkvbPJKqTUYt8p7/Dc+TmLkaJeDpAqeQlh3fLTSJrnafnG3/NvdteLVFRj6Pd36qbbQJWcxd1xkz1XshqR+3qnEqTcNvgCxcZw4NrnpqfXFhOw8lnyUnfCzlDamCuOzZdIxXc7V7I1sLz265hu4tsBuacboZfxPpvCPTe/EJmImOq1f6xur3p5Mp4fZagDiyTsgkPAe0/6QVOFhxgZIfKv3GAUfrOotS17mbYpjsmAJtz8rJAhwUVzVxYFPaQ1N+Z5h7+3cFtWD/L2yxH3ilkTfdEqZmPrJRLK8Smait4vOsYGxikZzQ0/LoGQtNbw640Loz/bskGCzvPHtY24ENJEriX3zCA+kbVSZBf2R2s3ee0thuOhTt3RSYHgFQ+n7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(11063799006)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e1qWQdVwOShNuMMecOCearTyoDEOXgjXAdx7Qnv8g9YMIDbMQlMnyi1EPEgq43qV1YQUNz+LK6N00M+t1S05XVVXNQXu7Lv//sybP7FpQFsMQN65oSHE6h7/oe2AtbYoPWCnsPyWaCxabpunpo0yh71gwlvyJSgTo+ymsRSrzb20j+MfU5R2ixmbQwtey5PUqB/K/0yjs3Ni7lWSdXdyX2ro8vk9t4hHnnUywdJ/rwxAmyKmqW/GK2gtECVst8FvWvR1TbNrPuAC1uNmhqbg1DEQ5lThng/xo1yTdbjRef7TOxOHc08N7lREzOL/VACVXadTDi87IuwWxO4vUjQBJk0W4TAUb+TnIEetIEgsCu/1+QHLctVFip/oRTgYX3WrA/fcqE5/SDdcl6wYw9k+7wCYXOrkezNK3/yxHc4V6Y22eV1w9BTfzkboVu1HNVtr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 05:02:38.5204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83affac0-d34f-467f-43b9-08deec657240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLD6BamMdGZEWcbmIT3CjlthQFnYF/inyPRqiYQ4HZs=;
 b=tPKqQcnbAPmRFmiN8/uaexDpHdASl9PsUYQx8E83NVuG6kRNq0a2IXMaotuoqGQZYVUWSfhPMKXopDlmiHAMqiSsPnu9UxOCG7cLMaxP2MUrqsLqu+USTpVknrUmUMwEuIoP4RuiQfdxm/EtsWNB24FxpWuyvLq1UeiXYIyqlmI=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=tPKqQcnb
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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
v4:
- changed macro ACPI_DBG2_WITH_GAS to ACPI_DBG2_16550_WITH_GAS

 drivers/serial/serial_coreboot.c | 3 ++-
 include/acpi/acpi_table.h        | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial_coreboot.c b/drivers/serial/serial_coreboot.c
index b1f69f6998cfa1..2976853f397745 100644
--- a/drivers/serial/serial_coreboot.c
+++ b/drivers/serial/serial_coreboot.c
@@ -59,7 +59,8 @@ static int read_dbg2(struct ns16550_plat *plat)
 		log_debug("Not a serial port\n");
 		return -EPROTOTYPE;
 	}
-	if (dbg->port_subtype != ACPI_DBG2_16550_COMPATIBLE) {
+	if (dbg->port_subtype != ACPI_DBG2_16550_COMPATIBLE &&
+	    dbg->port_subtype != ACPI_DBG2_16550_WITH_GAS) { 
 		log_debug("Incompatible serial port\n");
 		return -EPROTOTYPE;
 	}
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 4895366a6188ec..ac50ea10312e28 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -674,6 +674,7 @@ struct __packed acpi_dmar {
 #define ACPI_DBG2_ARM_SBSA_GENERIC	0x000E
 #define ACPI_DBG2_ARM_DCC		0x000F
 #define ACPI_DBG2_BCM2835		0x0010
+#define ACPI_DBG2_16550_WITH_GAS	0x0012 /* 16550-compatible UART with GAS */
 
 #define ACPI_DBG2_1394_STANDARD		0x0000
 
-- 
2.43.0

