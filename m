Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42387CCF9EA
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 05:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95CB783957;
	Thu, 30 Oct 2025 06:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZoCSimgO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3957A83936; Thu, 30 Oct 2025 06:20:10 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DA33838D5
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 06:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDlxTiz2l/c+Q5WIyyjHRn14jCwvJZ1AsuOTsg6+edTzuYSqCs9yoc6zvUdXu6K9PwhjivgufMwTlhYCgAmGdJufRuhV7W9ZiQP03N8hp0tCbueZgEg/IwZwlWnWKsqp0bFU2vocibDEEZ4wp8RTQ+EU71pIc30Q9g6Rns/8RWGy07Gp2sOesDve9LeCeFparcrZDlflenZNknc5j2DF9Ej2kWtST5xx5rmkf7jjFF5FE0z5fOChgzYQOE67Pc/eWVgx/5mO/tK2aXQpCqNWE2XsLz4k/g3fV/AS4A+CWJAFgF6unKXUd6eish8E/SlefsCphW1LFk6XXgTR0De1uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCSJoRKdFCzIyOXu2CzA5mGaTiaFlp0mhz7nGJuGarM=;
 b=ROiU6+cDxDeSXhl07DeMElrugSh4haJwfFDCoXTzYRI79iBWVBE39B29mY+pXGktGHuRFvypGzthXKfZ4lPw5WrQ0cYUl82HJyfErXbZPmkPushMD0fHtiJtLHEyfc2pXAAeU1+xbl+U7KQdd0dvNrv2X79Nk8dlmzOHZ5PeW1PCAzjeSyL8BUjE4ovRVZ1RVaT2hpX8CG6T/KA8shL1uP+eypKQ1bl4eDliLFtW7uH7NSoRhmy8HKCIBoQl+aWjY4EPvw1IrSVv1Qcuq6DIMkggeoUUcTp23aJiEwMfcoRI/eOuHHaJO8Ix+temLVFdQpGWlcMfqCGl0w1iJPWDKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCSJoRKdFCzIyOXu2CzA5mGaTiaFlp0mhz7nGJuGarM=;
 b=ZoCSimgORK+oJsGBdHuMQGwD/P6l9N+Yeo/60O/E8KMO6nNd4ak4qC1vLTmzwRF6xAuuB6CKXdRco+gzBeqhcz1oQccsIFDh+M2/vsvGX6efc6WvxLIxXe9OkRsCshDXYRS2gNVEoyJvSgVLilJDzBdgF+ZPh9uRa4Mdu8iS3oA=
Received: from SA0PR11CA0039.namprd11.prod.outlook.com (2603:10b6:806:d0::14)
 by SA1PR10MB5757.namprd10.prod.outlook.com (2603:10b6:806:23e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 05:20:02 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::bd) by SA0PR11CA0039.outlook.office365.com
 (2603:10b6:806:d0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 05:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 05:20:01 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:19:49 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:19:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 00:19:49 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59U5JmPw1446289;
 Thu, 30 Oct 2025 00:19:49 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v9 5/8] mach-k3: r5: common: add fdt fixups for falcon mode
Date: Thu, 30 Oct 2025 10:49:29 +0530
Message-ID: <20251030051937.3659010-6-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030051937.3659010-1-anshuld@ti.com>
References: <20251030051937.3659010-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SA1PR10MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b227a1-cb37-4174-357b-08de1773f9c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|34020700016|376014|82310400026|3122999009;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rkP64DUj7oK3tUi2ch5qmhZ5ltg+eP0Tb83WiqNIu0HVCQKLt15rkTiaskUk?=
 =?us-ascii?Q?oQp+Xj9mEeAovBCvRUTDidq7K6rwCTQrtbB69YUi/FbxTdOKALPld17C/afN?=
 =?us-ascii?Q?tg9mmgjnQ8XktbycvWN6gCOx04xwU/nKXL1p/WHpS4ypi4pt5mNZ4OB2/lbI?=
 =?us-ascii?Q?TUnA6T50WDoTuFNk9FbKk4oBTAFm+M2QHAAHZcBWIIc70EqV7VUjMdAAunOz?=
 =?us-ascii?Q?2YFMMrek4wEBpBLn+h3UTRfMLrxCZ7gfjmtFkmZufIx7EuVQTopmvTKx4Fl4?=
 =?us-ascii?Q?AAW2uZJ7qBnB7ef2xiAsQrLgPCOk7RVx3LnAENU58FsTRLr3NM360iUs/+5F?=
 =?us-ascii?Q?TY7tDtn8ilO/zJXYEmEuFT5/lOZcOhGoILL6gt2eLSCESphi6g2v7WsPUcLd?=
 =?us-ascii?Q?VoM3lmnAybSlmMn3Y40QyJ7FutOOQhqjawpBd52W4MeF55mhGda65Cqcglub?=
 =?us-ascii?Q?Cf2xChL1m0WGOtopJVExF6deAOTxWeXS8+HNdBrd02xS1eYf5wDkY/px7Evz?=
 =?us-ascii?Q?RP5+P3zHJwAxfxdsiwP+BCLm/Jz7/DfaCmg3V16R3hDw7CpQAMYxBZ7qoCwb?=
 =?us-ascii?Q?/a6U2gOWvZW/g75JLobEyE0YMCrelU9MGswHh6YEjcC8Ky951NeZVUh7khcz?=
 =?us-ascii?Q?P4K9mNDEho81lXoMHr0fG8VWmYXFHFpK7UwpUoW+BKnflWijTV46+76w6c3J?=
 =?us-ascii?Q?aA1kni4Qjqe9hZ45oa5416sUYLaLwxhE/MwNuYTWWYh2uzKcFzJSk+95Uc+2?=
 =?us-ascii?Q?NSFcZcZfwCINdOfzg/OvayNz4w5QZkTMv/QMGpsmgeOBnY90+I8VgnvwF2f+?=
 =?us-ascii?Q?K1UcyMw2k3rD9y/XgHVgSQIGPGJovhG/mb4eMl8R0hm+aM3TEgh6MfY0mH0+?=
 =?us-ascii?Q?s8uUI38GHMN4s3/H1lfzxtrbRQBar61R00QRtp60PVD7a5NNNTQBfmpylKI4?=
 =?us-ascii?Q?LYaAsV0Rv+tUMRn104cuTk1ALh/oXhw2ehSS/UAcBLdE1T1UkoJmxY0Y8jvN?=
 =?us-ascii?Q?Pb6maDYeqIkoc/3JBAXCp+/hKafwVPcS4JGBFMiVqjeXXF8f4e6bNbXzSkjU?=
 =?us-ascii?Q?JNjk3PtoL3WTd7ej8DHgZDuxygw8KIrxt55buMmmBOwgAo7N2ld6mfkW1Ify?=
 =?us-ascii?Q?OLmVq6XfqToPhZgGV0XQ+wS1Kvn3DT1T+D8DdHOZt+f/ijlI4D6YUsNqoV03?=
 =?us-ascii?Q?rhRQe+3itYWZxT8rl10yH6yEiIf9XBZG8tf4ilcILeliNmjWDNDhZkiG7XwU?=
 =?us-ascii?Q?e1D8grk6G8KBJnpC0OwF55NP6HxyPxBPcVYMDYszLtEjVbfqQP6zSlkTFBhy?=
 =?us-ascii?Q?Rj8NwUiBYieNwWIfbA7Ac5rQpdt3OUPLGBSt81V+81dbH6AwsCRKwlGDkbf0?=
 =?us-ascii?Q?ao7o5byyDOuEi7NXGgo2IVCm68plF4m5y0RK+5eQxyXRHLSvWXsPc+iv80St?=
 =?us-ascii?Q?40riz+cAqhA7ah1kCC7GuAQL/GOEsxcBI5DYBFoBx7v7phjvXmXTXAznA3F3?=
 =?us-ascii?Q?8k9eDD03IxISCxAC7Vgi4aFqtSxGr+fA/emwqsMNuPpGw7Eq9aOC6li81a6p?=
 =?us-ascii?Q?w9lcTmUii8Km7kGJ+pg=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(34020700016)(376014)(82310400026)(3122999009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 05:20:01.1686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b227a1-cb37-4174-357b-08de1773f9c6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5757
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

This patch adds fdt fixups to the kernel device-tree in R5 falcon mode,
these fixups include fixing up the core-count, reserved-memory etc.

The users can opt out by disabling the respective CONFIG_OF_*_SETUP
config options.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/r5/common.c | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index aa94c0c1956..4788aaff3ea 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -406,12 +406,43 @@ int k3_r5_falcon_bootmode(void)
 		return BOOT_DEVICE_NOBOOT;
 }
 
+static int k3_falcon_fdt_fixup(void *fdt)
+{
+	int ret;
+
+	if (!fdt)
+		return -EINVAL;
+
+	fdt_set_totalsize(fdt, fdt_totalsize(fdt) + CONFIG_SYS_FDT_PAD);
+
+	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP)) {
+		ret = ft_board_setup(fdt, gd->bd);
+		if (ret) {
+			printf("%s: Failed in board fdt fixups: %s\n", __func__,
+			       fdt_strerror(ret));
+			return ret;
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_OF_SYSTEM_SETUP)) {
+		ret = ft_system_setup(fdt, gd->bd);
+		if (ret) {
+			printf("%s: Failed in system fdt fixups: %s\n",
+			       __func__, fdt_strerror(ret));
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 int k3_r5_falcon_prep(void)
 {
 	struct spl_image_loader *loader, *drv;
 	struct spl_image_info kernel_image;
 	struct spl_boot_device bootdev;
 	int ret = -ENXIO, n_ents;
+	void *fdt;
 
 	tifalcon_loaded = true;
 	memset(&kernel_image, '\0', sizeof(kernel_image));
@@ -429,6 +460,13 @@ int k3_r5_falcon_prep(void)
 			if (ret)
 				continue;
 
+			fdt = spl_image_fdt_addr(&kernel_image);
+			ret = k3_falcon_fdt_fixup(fdt);
+			if (ret) {
+				printf("%s: Failed performing fdt fixups in falcon flow: [%d]\n",
+				       __func__, ret);
+				return ret;
+			}
 			return 0;
 		}
 	}
-- 
2.51.0

