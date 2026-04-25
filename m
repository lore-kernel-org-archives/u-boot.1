Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BCEFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3146B84137;
	Sat, 25 Apr 2026 18:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X+z+5Hy8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51DED84109; Sat, 25 Apr 2026 18:06:05 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9823984120
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:06:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from CYXPR10MB7951.namprd10.prod.outlook.com (2603:10b6:930:dc::9)
 by CH2PR10MB4343.namprd10.prod.outlook.com (2603:10b6:610:a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 12:57:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdREsT2e5nOWjM3BKXXtbkdMdZEsdNDLFhxnn9rJDdWcsz4+EdRcnlbp0OdIuunmY2h6E8sOIXG3Juy0MRCzqAOnX8pR2STfAmRh4BuUZmjUlFP5oLveuNO1n/N28xJezjNadug5T4LHDKdRDk/gx9A04/d2XvJW4uM6GN5nsuwHVXbP3eoi0rMql+IWX3hgRLUbw95gXSJuaOaTt+BhdWyCtmeOuykYxS3kGMZuHMMqlInypoa++kMcio8AaFfEnDNfzoh33zf9E0JPEFaG1apfvUNO78TeW0i1G3WPkBkO3vEVflMyeOOjQko5e32zaLbgLiesa2O4O0Iqpzf5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywCzqBzg6fKPu0QKPGLzNUrzP6H95ANbjICTqPHRWrI=;
 b=Y+wglyuAI0PnrxgkPF265cyv3xOv6prZ6wbvYRBmXDX87SEyyPsKXYNlBoxAwiOVS+cs/n3UJ1sNDwlkaTiVo7LyCKstAkrEx/+IOXPM+oTapm859Wl0C7xLtF7zYo7wyO8R4CWm/4+TANkajvPYO67TFOvVjCfnQeVxjgeHBctyE2UHwA8iEpVyCwyF5JN0O6mihea5b94zxlOLI138TWLF9OFNgLCLBQGRqBgAyAwqqM1Qx1HRcN4HeNjiBctsuPYR4QAvGfmRpfDglVQep4yFKqqOf6LQxxNwJXKUZoX1iBwsZZBm+7JhxlPWfNjbGGXI9WFk0BPC938M++Xjtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywCzqBzg6fKPu0QKPGLzNUrzP6H95ANbjICTqPHRWrI=;
 b=X+z+5Hy86qsC9upLRoLbZzvnXA3aXJR3YcAw/a2k8yv84Ls79HV+Sg8+UNUZT6wnpfmMwkwzTC7I/l52GYvRRsSx3e9BZMJEvHKR5tIYnM5dXLlL7MU5SXzrQOjvDWWrNhnyNbHtB2bzcUrkRHZm1DvuS4Hy9F2ZBpX2zbYNO+g=
Received: from BL0PR0102CA0048.prod.exchangelabs.com (2603:10b6:208:25::25) by
 CYXPR10MB7951.namprd10.prod.outlook.com (2603:10b6:930:dc::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.22; Sat, 25 Apr 2026 03:38:32 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::49) by BL0PR0102CA0048.outlook.office365.com
 (2603:10b6:208:25::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Sat,
 25 Apr 2026 03:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 03:38:32 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:31 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:31 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 22:38:31 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 63P3bk8A2903263; Fri, 24 Apr 2026 22:38:28 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v4 11/11] arm: mach-k3: r5: common: Invoke boot of HSM M4 core
Date: Sat, 25 Apr 2026 09:07:42 +0530
Message-ID: <20260425033742.1519298-12-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425033742.1519298-1-b-padhi@ti.com>
References: <20260425033742.1519298-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CYXPR10MB7951:EE_|CH2PR10MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e6678d-ef70-47fd-9b36-08dea27c1f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7VAspks8aetXBjChaCpm+gyBm4qXk/2e8tpCClAbCdFIBSdoHo3cUgFcUyxkJifgo2bpaN3sRe3TzrTI+/wBifrpEX7MeWdpJ8WhV3QORzEkQQGc175z6OO0RQ6fAewkjejA9JM8RIIZ9v2GwInBJdjuJGUQNROOUIc0FNPd+eI9Yb65FDLgPzXTtWBzzfIz4cxn781DUSFP+DFhbZpidey9TXuJQlxL1bWxS4PUxh2ht/WcI1Rqi8X2cjVkEGSiG5i/9FoTnJcSVOuT6k5p8I+eYne7u6b0lcuBNgok67N9z9tuwYc0ffs08z+7fofTgK2bgUae5LnWN1De08hBubzVuPVAR/ahGCN3ibSNjSz6lDqbVSwLMsVW5JtBX2J6brTl2egRt3RGORzm/FymP9fWdMQLBuCU0TQ5CADZsA8DvrVvyiMccYoBBx6eXzmnz2sxyGLzBXWHWAm9Ejr7TaGaMAyQsqZOlflbeBdjrmnXTx5YwKdI/mVloc9dszNFn+ZI5/yXdLKwRr6I3VkWhcaGGf7gDErszxfvstWRmo+n3AH9sDYFKFCUGCoc8K+qHR1u3aDoNeNXIUy68Z3YYg+3J7UWZ5GA/oukVrSL2hhjWCpU49/tTzfGjDR9bIMjVzfj3Nc9u99hA2JFT/DFs5HVKaW2BxNcpwv4rQCJ6gBepLER5eSWgNlSCSVYXyOkdazSO2EUI4Rk1VvYgeVOjmBweb64BCYZ1n6sr7JSyp0=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z8leqazGR8yqyNRuIVP1zx1iNntqQyZS0WNP/Yr5MjuSx3jkaRJ8gecD7/PX3HX3Gcbql8ZvKO7gQ5FcMacsPfbUBS+9bMGaHhYcJS/+MqpnL/6+GEsTaXJoEGaIRZYbflJLsaQj5TF2erWx5PFap0SAr0qtQNMw8LYFfHl019QtzptW0Uf10EtYK510SBi0H/S+nG1GjYsoGmBcYGyAm5NVXTm3UJYFtpwHhGG5g5iOoa3iebzSpDdDtrCxkkKFkMt8eSqA7wLEX/Um1R0xKeIcxpNYru1j96Xq/mu6KPDVOwi3M9VkD5xtJd5hNGLrI6WiuFGhqN0CfnNCcVX6oTzGrALNUD6agWJVv2S9Kmw6/NZWXP9xjTIIR+7K9nW+b73OdoMdvi8bH6DvSYl/hamh7xvn5q7nO9tzGcZVXrGmP/8pC/LoU/0pQpazBYmV
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 03:38:32.1045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e6678d-ef70-47fd-9b36-08dea27c1f8e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7951
X-OriginatorOrg: ti.com
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

The tispl.bin fit image is packed with the HSM firmware image. Populate
the "os" info of the image so that it can be detected and used to load
the HSM core. Further, invoke the load and boot of HSM core at R5 SPL
stage using the remoteprocessor framework.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-11-b-padhi@ti.com/

v3: Changelog:
1. Use remoteproc framework to boot HSM core.

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-8-b-padhi@ti.com/

v2: Changelog:
1. Hang system boot if HSM firmware failed to boot.
2. __maybe_unused to decrease preprocessor usage.
3. Better error messages with return code.
4. Added Error case in if-elseif-else ladder.

Note:
#define PROC_ID_HSM_M4F seems to have extra tab in the diff/patch.
But when patch gets applied in file, all of them have consistent
tabs.

Link to v1:
https://lore.kernel.org/all/18e01808-499d-4690-995a-45ac5fd727d9@ti.com

 arch/arm/mach-k3/r5/common.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index f075b881901..df93b2bba5f 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -28,6 +28,7 @@ enum {
 	IMAGE_ID_TIFSSTUB_HS,
 	IMAGE_ID_TIFSSTUB_FS,
 	IMAGE_ID_TIFSSTUB_GP,
+	IMAGE_ID_HSM,
 	IMAGE_AMT,
 };
 
@@ -40,6 +41,7 @@ static const char *image_os_match[IMAGE_AMT] = {
 	"tifsstub-hs",
 	"tifsstub-fs",
 	"tifsstub-gp",
+	"hsm",
 };
 #endif
 
@@ -158,6 +160,20 @@ void __noreturn jump_to_image(struct spl_image_info *spl_image)
 				     &loadaddr);
 	}
 
+	if (IS_ENABLED(CONFIG_REMOTEPROC_TI_K3_HSM_M4F)) {
+		ret = rproc_load(2, fit_image_info[IMAGE_ID_HSM].load,
+				 fit_image_info[IMAGE_ID_HSM].image_len);
+		if (ret) {
+			panic("Error while loading HSM firmware, ret = %d\n", ret);
+		} else {
+			ret = rproc_start(2);
+			if (ret)
+				panic("Error while starting HSM core\n");
+			else
+				printf("Successfully loaded and started HSM core\n");
+		}
+	}
+
 	/*
 	 * It is assumed that remoteproc device 1 is the corresponding
 	 * Cortex-A core which runs ATF. Make sure DT reflects the same.
-- 
2.34.1

