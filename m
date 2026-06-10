Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4430CD98C5
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EF34848DF;
	Wed, 10 Jun 2026 14:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lr3hiNnB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D4684843; Wed, 10 Jun 2026 13:07:29 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D5F807C4
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 13:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Suraj.HanumantKakade@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQwXbNFleJ2WXuT23LhVYEtTqdcMQ5Hvt+0cSBDsc5uHdBs4g2qpjyWQDISPLRK0ZyVd3J+WFkMCyqpuOVvqWnB/qolOaFGBbbVtHpjUA0BZcB9y/mjywd3zfv8nxza1itqd+dVm7SJKdijTlrnGmBc6cpUVj6X5L9oO0iXR0hL0GGyVPVX7h4lDUGTB3QIHgZMed7Cdcvq0qHO13U/OdNIvmC+m6Sqhk9K0Dk5KNx0567vobxOSc9QVtFtPYO3Y8PmGxq8yXdRe3N9myrSYcTENWpavaT/LjNOlsSQrFiPi165syqIyc73ScsX6Ve794iH7giyJm/K5N0REETDVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdZSLmK2JsKOeFglpl+jtZmO/Ps4SPHLHb0d4svUabw=;
 b=fFyegZLpEHfO5nGJV4p0jQRvJOuNa5t4YFe5LPptHEtaq9XjkPRsfez0ZLayWtFq6f2pu5/ZwPJ2wKXjRVvKWK8d3987oZmVWDag/izZREe+mruyzGtVLBokuicm836sKJDa8rOIq5cUBt+fWDLXkRZ05PpnvHAKqgVoQskzaxsfYiDIJ7VjzphNTHZu4eRW/neqc9tHZ/PbZVISEAdyLINkCc/wzomN371i0xUZt2bi0hXtcZcj3dXf5WK8KdWZzKltxMGQgXwY9vzKxoDgpM/o3VE5BqoTlvKhGy6EdE5SWGahULm3oq4+brALCIUFfnHbYO5STjKryZIoDKDeYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdZSLmK2JsKOeFglpl+jtZmO/Ps4SPHLHb0d4svUabw=;
 b=lr3hiNnBZOVzIfjFnguNy6y6prMYpNGGyH7s+GG0/+Aa+vm5PIArcWtYC1lAxtWY9tNux0gJ6/V7xkqzfm3N3PXYDhkgNAhpC4F/RCCtefk9XjgHuPADU3hconssSNdroWJavrXmHAZEZIUK7LE2+IZa2ZgXT0pIQVm4QDx+v3Q=
Received: from SA1PR02CA0014.namprd02.prod.outlook.com (2603:10b6:806:2cf::21)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 11:07:20 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::10) by SA1PR02CA0014.outlook.office365.com
 (2603:10b6:806:2cf::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Wed,
 10 Jun 2026 11:07:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 11:07:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 06:07:13 -0500
Received: from xhdpvinayti50x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Wed, 10 Jun 2026 06:07:11 -0500
From: Suraj Kakade <suraj.hanumantkakade@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Francois Berder <fberder@outlook.fr>, "Pranav
 Sanwal" <pranav.sanwal@amd.com>
Subject: [PATCH] amd: versal2: detect spi env bus from boot mode
Date: Wed, 10 Jun 2026 16:35:31 +0530
Message-ID: <20260610110557.2183203-1-suraj.hanumantkakade@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: d55717c5-d0bc-4e10-9069-08dec6e07103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|32650700020|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: aYdptUMzPWme0K7ghfrjq303LsVtG71Bj6/T6OePcf6fq3pmK1OWMrieal6oD9DIRmlwe78IUs5gHwpaep1OcPFUSZ5N6kmt9rM+XbbSZ+7wSzeS6NPIrXVbkH4sz4h73OHfX7VrBNXp3eQShB78YcYb0gSwydMhR/pvAVZ+v6OWFiJdHT8E5JGEIunx65OfCWwTf16OUnjSNehYs7AauXG4aeZ+pUr2okGeneA64QQM41HIrcjqYBwBUTHP1+r/E7yTDL5ZhefsoYy15yt2ryYt/KPw6TWu5sXO1mrY0I0eMGThD1xhWg2Ma1DfD3yKureUQk/9jGNeeux6fT+qiNolWx9lzP9BeugNM3310vyYDo0LD74O9yCE+jX5LXYBVz9b7ii62W8vk2jBfC3GOShpJ+mJ0rCmyo+1vl1nTbj0sDRLfQ53CY/EUHuaftYz26zOR42GXZH5/ejQk8Iphu1vRwatbaG1fdAstSmOHVVAEohmJOmvgTrThl3fAEizteOvvAORklqPY/kRHqmT3Pd/0qBOpe1FXzBiV9/TUU0W2MlZyUqd9/KKOJoyMjhqDZnQBcKkEVtq7HjyepTtF+lXnk07AFb4LlTWXO+sBjqcsBPq48vxJH4z4TgUp2ODAaIGPlY6kc72M04HNqNI/6wFn7QEkvhoBeqMjlAxNdWxai0we5CoQSerFa85nSiMSFlP+cvvLZSr3kmmR90X+wCExqbT2ryefR/SJFs834Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(32650700020)(6133799003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eL/fumgBcCgRsooApHf25oRestYPjJO8hw1TcXaGEV2nsDvMP15q8Ph/y9Tadk1WVAa+XEMTevfsBNTUWLwBE20rCJgO8ILRsMKPz/p6P3r69/UqopDpg4Md2FmWFoQCy3IRDOm5pjyRefvJ0X3aLhN3n2YFWCicHemOn5TUxnei5UAjAqswtdEWFQYFhVTSHfBibo3H8vrEW0r4iGt+F7qhdR8A10DCXoDX2LrkYUxtsJdWJQVvrRMrvCYq87mveXj8KQmpdo/SfF4Hp/WVE98XDbDKFbqaw4bH2J/oQVueLyJ22eicgzCG++Xleu3kGKoa7yopnvxhgXTq0HhMbvgQdwFwcYy7XZOe8uW9oS+LM9gRjEh33Q2ImWW/NMYaA45aArNdJcAkvqDQAaQ2xjQc5gT2Ou7dAX0dQszOMzFSa/guSM7RWgOdm7n9ETQ0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 11:07:20.3572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d55717c5-d0bc-4e10-9069-08dec6e07103
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
X-Mailman-Approved-At: Wed, 10 Jun 2026 14:53:33 +0200
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

Add spi_get_env_dev() to dynamically detect the correct SPI
bus based on the actual boot mode at runtime. This ensures
environment variables are always loaded from the correct SPI
flash controller regardless of the bus numbering.

For example, on some Versal Gen 2 boards, SPI is disabled in DTS
leaving bus 0 empty in DM. Only QSPI is enabled at bus 1. The
default CONFIG_ENV_SPI_BUS=0 causes U-Boot to search for environment
at bus 0 which does not exist, triggering the warning
"spi_flash_probe_bus_cs() failed, using default environment".

Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
---
 board/amd/versal2/board.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index 81daba1c5ef..46918436364 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -476,3 +476,31 @@ enum env_location env_get_location(enum env_operation op, int prio)
 	}
 }
 #endif
+
+int spi_get_env_dev(void)
+{
+	struct udevice *dev;
+	const char *name;
+	int bootseq;
+
+	switch (versal2_get_bootmode()) {
+	case QSPI_MODE_24BIT:
+	case QSPI_MODE_32BIT:
+		name = "spi@f1030000";
+		break;
+	case OSPI_MODE:
+		name = "spi@f1010000";
+		break;
+	default:
+		return -1;
+	}
+
+	if (uclass_get_device_by_name(UCLASS_SPI, name, &dev)) {
+		debug("SPI driver for %s is not present\n", name);
+		return -1;
+	}
+
+	bootseq = dev_seq(dev);
+	debug("bootseq %d\n", bootseq);
+	return bootseq;
+}
-- 
2.43.0

