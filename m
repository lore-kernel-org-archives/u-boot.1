Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCAE105F7A8
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 13:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76E5D84309;
	Fri, 13 Mar 2026 14:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ft81hIUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 870E684307; Fri, 13 Mar 2026 14:59:27 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8150F84307
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvaxSSPKghIN1ik8DWFQoviKHde3NBR9BS0XYfNqtUIqK8TkhLkwLP67ySxMVidHEVl4SV8d+A/xDShMkP4YN8n/6re8HTccFTMEyAUk2B10BEoj76ZvuXIePAJXXLbEVwC3nrPXlSg7oxD37Egu9/JUnUaR1vz5HmZYgz/bVHZX+CZcrW9fZ+KOjT4a/BItaUtVZz7RbCVuJH8PqP+UJs6hCtL7OTyIWpP9O6ddiUX6MsrE5Gpxhw8K1Rxfa8hlcfadBsLEjNJbCC1LtLRUELVncgqPg3DZ40w029HgEX1dZ9lpX3qBBEiLkndC4H/maogXxtrZS8eAiTCwafNpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ij4qZWN2IsStGeVexq0b1krK8iVjGJfzbxDLPODny+c=;
 b=bLdF38ZYm848wpnqbZDoe5XtZ4OuVwanFbHsWNT1k6q0F58IimNC3AxMlwb37SMnhTYDNlbngOUB85dufb7lGHgxu6ITUuvgrG8pP64yW+UQrkb0uDKNOIhG1DYJ2Tr2W24l0ayTxJe8qgci6vzKj8VNHyG21gmgxDec2NAekpqV3jvXkImgGqFWwY2B6I8el6LccTq8+WpVx3vvzaepB+0/iqD6SLaUK86BXgqx2iNeAjpKxumgd5/tesCK3mEZFWqYAbITkYWWz0DQCh7k9Qsh3RbkLsjxiHkvWGyssP/m+zNtsJkTG4xnk53e0GdV5exTtiVAra3aefrXgVsIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ij4qZWN2IsStGeVexq0b1krK8iVjGJfzbxDLPODny+c=;
 b=ft81hIUCtZ/KPhXmNCyACC/cJTBHJER/0fDHgzy2Mg/cRBXwEfqd7cuY/SK7zjC7TiWv0nmIJr2zr5J+U//RhzQHCQ73cTwoeSI4ZXd2ZZJWfKcbJtxtp7dTvhSiLHuL6/2TsJUpEG8OukJ44NZ/ultRyaKfqNAhKUJjITFaPII=
Received: from CH2PR14CA0032.namprd14.prod.outlook.com (2603:10b6:610:56::12)
 by PH7PR10MB6529.namprd10.prod.outlook.com (2603:10b6:510:200::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.13; Fri, 13 Mar
 2026 13:59:22 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:610:56:cafe::29) by CH2PR14CA0032.outlook.office365.com
 (2603:10b6:610:56::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 13:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:19 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:16 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:16 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6JZ638000;
 Fri, 13 Mar 2026 08:59:14 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 03/19] global: k3: use gd to store the resume state
Date: Fri, 13 Mar 2026 19:28:44 +0530
Message-ID: <20260313135900.3430264-4-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|PH7PR10MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: a05ffbfc-dc38-4ae1-5336-08de8108b934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: eCd4UJjrD9UpjcojgwskoLNv2nRPCBnxqleNnF3vZo1u3BgqGxI0d1JVpjN6qcIhhlbjWQJw9MlwDwoodt9zgkUJdsGAYGEcCYjQnEpTVTsl3SQCfpjj9L1CyBN59m4I56zwYGoIfMalcbprkEc+HIuLM/X3++VGoFDCIk8J3RDlYSXb+Wka9DeGcrcrcZC/RvvxOkFsxGj5MX8JYoghvh68oPxkqOxRVtAsEsHf2I/YBGmOYpzMI414ZduLkUZlwbc91abMC3kq+0nI3K9iMSlvJmvpi6d+YQMwy6dTrDW2NvexIZTAqF5VUhjrq0oqGljPQnvD9tFZeBL00D+Uxje4P69vBxGdHOse8uwQnNoRY1P9gmyF93inqF7TrcZifrGhgfnKXdamx+FVpQoIBBd9E5hYIa9Y2YvOkYBJWRqK4tPOFqJDxi5LNy0Id8Y90yu8Ho0eySRvvCq4KISK/K2Qbg6QGZ/MZEub19p/2ts9TDx6F/yhSj+CNFHIjbDUZ7Sm4KYpMbZjNrrCXMMWV8hL+bu9+8bG/YnDvzWg9/F/tTfDoGnw5vm2VpqcXiryDjCg4+uVouIeOc5y8X/nOk/oReDnmEO9ghOSg6WjBLbMczxc72N8e5ZUzHPRCaetI2tfNrqWDDXfhumbASPY0/e6y3rRWvXvIoFkCJokxKoO9aG389iV5+Q1utbWqJW8dgA72fw0Mc86c8DqIc9H2/mL1LxO+OCXjeIYQsJgKjps9ZdnM+nMbulkHJRnKg1SSwqM8vSYwAleeAFxiLKweg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: blsLYGx5u6OYTtNHG0idUba449GL1f7+pGFDAaDUIzpSyRGK3uZjzJiy0EdpZNtjDWPlNk5ZtuCtCo9EPufiA3i3a6J7PaBII9pwls2k5zC6AAhdv1iY/YjsRHVn7lhaaKJmR69fEtYGX0mdukwENwbWO2SXONMYQ481AGzvqmPswaDlBfi1FO5QOKSUQUWY3+VQm/ZR/7jH8kBLStDPoU5hum/JdIzFraAnFfHNgB4YdIht8UxLxbdDEUQ1S0qMUMYjjXkGqmQjxJhx9UTBqWXJ7BHxAEp/v75dEEBbJhp0EHrI00H4cfSiRWuWyRZFmn18SJYJ38mXkhG1pP2ST0341Hb/0oQvHzIfy2ae9rQz7laLDXhqUio3qLGDRQf8uFMRv6p7aqe8PUubS3Vfc811Qilrn1W0QWGHuYbAh5+axtW1bHq2iskEnj09xWc/
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:19.9138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a05ffbfc-dc38-4ae1-5336-08de8108b934
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6529
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

From: Richard Genoud <richard.genoud@bootlin.com>

As stated by the README, in board_init_f(), the BSS is not available, so
we cannot use global/static variables, only stack variables and
global_data.

Thus, we use gd to store the resume state of the board.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/include/asm/global_data.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index b2ec450f900..3a4210fbfc6 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -108,8 +108,19 @@ struct arch_global_data {
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_ARCH_K3))
+	int k3_resuming;
+#endif
 };
 
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_ARCH_K3))
+#define gd_k3_resuming() gd->arch.k3_resuming
+#define gd_set_k3_resuming(state) gd->arch.k3_resuming = (state)
+#else
+#define gd_k3_resuming() 0
+#define gd_set_k3_resuming(state)
+#endif
+
 #include <asm-generic/global_data.h>
 
 #if defined(__clang__) || defined(LTO_ENABLE)
-- 
2.34.1

