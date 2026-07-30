Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F264FC531D0
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 03:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C11680EFB;
	Thu, 30 Jul 2026 03:43:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8jo9OcnuoYAQ; Thu, 30 Jul 2026 03:43:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B9D680ED2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785383028;
	bh=S739bDWYnr8EGYlECvCgvvrmpXLmLLIYF8UgkLgrnKM=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TltiHhMqEYXAYBpQNMJPcy4OLuMgyrUthXWZGTZqN0gt1fDV35eCmjPJtjXLNrNO1
	 amqfvjBVl0euO5sHe87tdk2AgYqwS9PeehM7ZLGCzVeX+Xvxa/UBxmrur/cC26HZIl
	 bf9PwA+XlJYq8mzz2qapaHAholkYZWiYYWF9CK3krP/WtQxIs/eQHnC6qqr7ClLnI4
	 0GeSl4svwAmdGN4McfIct63kPoRmQjdlTIpdsZZSx9SEB9Rx7K7EcM3O1N0LlfiV5r
	 LCyJxWCh6QJcrLFrDJ2e+8+RH7zyXZuBHWQoDNiDleQjJDl8MM44DAJOpdax4tsUHB
	 wgYkRN4ZocQqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B9D680ED2;
	Thu, 30 Jul 2026 03:43:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DF7C350
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 03:43:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6426660785
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 03:43:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9MBkI__-zovC for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 03:43:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c111::9;
 helo=dm5pr21cu001.outbound.protection.outlook.com;
 envelope-from=jayaramudu.desapogu@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8E86260618
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E86260618
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E86260618
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 03:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjTgF6B8gkqASE/7n06ZIwIZR1yP2g8iF4Vb5lWkVMEA2PXYczzP5mywTkCdNXjBQnxiB5OGx+1/sbXfpHx+90QoBikTnvoaka0vMXLcNiiewGR3EdEXNvKPyQImW1i06qOjvWfpkrkNbXakd7VWSUum4uH3g29vacSDpz9kcv0wSkUW7nBj6oD1nNSeNNVW/QmlwOPJInQrAw1gjvfIC8M5Pd85avoaYrHl9F0mNScf2f72AHvpWNitgDd3TwMGdi+gnV/ya/CsPQQ/3ZGRRJFUQFCadfRy0d/PvAbdJ8usSiv5vy1+tCIj9K0NQdMGXRp2P2MLS7OkH2SEJDbI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S739bDWYnr8EGYlECvCgvvrmpXLmLLIYF8UgkLgrnKM=;
 b=osM0eNEOQJRUYI50bV5d9bfm3eYEi2iETYxYqrFu3gTTV0UKtEU0pxC7ClhqnI71a2/sEM1TR5Pah/bkEJwPaWkXqoJnF7HESTTV4KPBrKAi34zRiiPnUDdqpeITMty9jBoshA2HhPBSHgHjW4WCmqu4EW1+REXrVFXoj2LG9v6iwLTnAa6ltjZxGMIX401zIzSp27ABMawAh/FvwTExVKyEPc0K4JZyGHNDiZpCmX15u+rHMul3UWxWjzGj/h6GlN3NR9udNs2MJbsd5j8JN0RRBobpTd3TgwSiEj+ZgI6PpiVYaMKwZVdyG/Tss5mgTQNZLq+tabkh8cQ3bmtGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from BN9PR03CA0568.namprd03.prod.outlook.com (2603:10b6:408:138::33)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 03:43:42 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:138:cafe::a4) by BN9PR03CA0568.outlook.office365.com
 (2603:10b6:408:138::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Thu,
 30 Jul 2026 03:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Thu, 30 Jul 2026 03:43:42 +0000
Received: from BLRJDESAPOG1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 22:43:40 -0500
From: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
To: <sjg@chromium.org>, <trini@konsulko.com>
CC: <u-boot@lists.u-boot-project.org>, Desapogu Jayaramudu
 <jayaramudu.desapogu@amd.com>
Subject: [PATCH v5] serial: coreboot: Accept DBG2 subtype 0x12
Date: Thu, 30 Jul 2026 09:13:16 +0530
Message-ID: <20260730034316.26353-1-jayaramudu.desapogu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: dd91558e-4c1e-4f94-c5f0-08deedecc03b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Y5FWGhNCXU8lp8sCRihc3hhPvkeohRo3rOknntKGMyH0omjucHzrJW4c1NaWtDM2nToNLXz36rgrVHX2//3q0PrvmzelPZQRl6dMKdLE5qmL8MXqpOpwfg9Za2lRmsTcsatsm45va/ziXM7s+kOhac5updy+4vvkUfL4Bg3Zw/x/4MVMGhTt8TZMy95g/ouWInJagegqMyEVXnnElDGUB5b+4QueNUiNukMULm4PeE+3NC715OM79teblL5DIRBGL4b2svfeXMQpRzKyAN/d8USGaQT3iu8iv1CMPW0AkBfCXlx1gNEbpLm3yqErjDRzbS8TT8ybH90kC+axA9fRIBiHCqcJsqulvD/Aig/wlYQlDgjsw99l4+Tc7HVi/iJ2lP90MLAGDT5LJhTvrymhHa4yINrNkdmrBswYRRD6TQQQewyD5z5BTVv9xfjjhQYq/4RwNbVIM1HWU9+MDFsR49eJveXOialJwQ7wjVUTPS+0ZEUETA6D8s2clHkyY+igWFNWa7BFQ9C3MI1Sc9lburdSFbLHLaptqksjgjjjICO9NRFDMxned2UXiEKN674IBUh9unqLV6R+7IW2vIkNPjwVjUBWvmI9oqRjOEjbftHOir7exzr0TuaRy/WIh34BnGPuAxg57idkzgCF1ZjxlhC5nNImvCR8B2iV6aSLnjKVI+9E1CtKJQlJviakf2wMYX+8M1KFWgZwzhy7bFnkNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qYAZ8rCzj074+WAfHILwzoIpt10oliRzVN45YnZ5CuF2nT5uTs2gGgrJMnFK0pRPwoWVTtt0AyDUndHEveE4xX12utiZP8SovF/a2t8+L15/OpxUfLHIftcE/8AVoTNjkrr8ScifkYkNuUEmwZRg4wboY7Ak4k4nSrhJGVT+cq8tXFNcV7xlKt4mzR3wZrsBKfHb2RY+7W/lDWLoO2jhW+njqwzHAnr/RC2T2BGsNTROj0aP6RAaMXoNYyihr16FVX+YkAKavgcGJObqzD6QMGxdUDj61VL/vRqjtrrkzcXAqb81k9WZk2kgFh7Jtg/af/BmgdCicqq/ozTJMPYK3VtQeIhnRQ/6ptnOqi7j5SaUXvTClg/yqKxYMb/IK3Agls5DLqlmaLxwGJFzOgG2MaWfYbacZc78Zcqvkf5BCdXWIAvqZXj3iazXpE84IATA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 03:43:42.5984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd91558e-4c1e-4f94-c5f0-08deedecc03b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S739bDWYnr8EGYlECvCgvvrmpXLmLLIYF8UgkLgrnKM=;
 b=lv583DsnvHue+RhCvYy/5E3aIoyHUNH1I035UsTAbndoD1fdV5QJy9L/hBQP6UKUZA6t1WV5g6fXLTwO1P1BPhBfYuUqyD8/tQkYDO6hdgOg6DX9PdYat49u1/UaXbaAr5tCsfsJXS4ze+lkBdborBpFeLzELnYvMxMfp6fg1vU=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=lv583Dsn
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
v5:
- removed whitespce

 drivers/serial/serial_coreboot.c | 3 ++-
 include/acpi/acpi_table.h        | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial_coreboot.c b/drivers/serial/serial_coreboot.c
index b1f69f6998cfa1..89da11ffa5241e 100644
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

