Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD004FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C53C8412A;
	Sat, 25 Apr 2026 18:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Tw6q1mP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D8178407E; Sat, 25 Apr 2026 18:36:32 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E02FA84109
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from CO1PR10MB4435.namprd10.prod.outlook.com (2603:10b6:303:6c::17)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 07:49:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFGYBrh43cOKFyvAH4roWsYi3mSL3XNznBPC4TqLyMK8K79Ls+BmH3H/WAwWBMAmYYMr0Ffg8rGHFVH8WZ/1Lyq+QYPqu8aTTfpR2myRM2eNPNlF7SNSF6ov9WC2Hicl8mPuuETJbjji4fR8tT/2FzEm/pG6aALj6TbX29MhBj66wGdRMTqCBBbHgZdUiBzWZFHqDzEWm9w0InewEK4rhPjGI0lyoIwJSuyhfiM6OgQwpZmO2oqgLdrTRsJagwoCiWTmUZUCce3i15oscmVGBKVlSSPWox9Yo2eNlwd3b4od7XiTkz3PboVYx6EhnjZrWTIJJ4lbet4NwMYO5rMbwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+u4ubUIRwW/l0byA9OLrX8nXDHwY8oaHKB0cQgsEjhI=;
 b=g/DM1QgmOem/omxKf1/T3Pw6IvUVCDr5AW8z+DEJcurwL1+aL3jdNmU6n4yn5Y8owQ1bHn6Wy87iYE+0FPjS+qbtQgKeWOIT+2hVuh6TM3Ari5Jiph5XJmaD50IleapQHfmes8Rufys+BCIl5n3c90xUrB8JAMzg09p0IFVbCD45dgP6mkE0CQjH8KTZkKel5jDl/2R2puryIT+MLBh/rZczrgaDITrPzZxF2iNVGfpWHKksPixsKEhjj7vmZpoCqDwKjdqGIqONS2aD9cPW1HYxTYDa62w498W7Q8RwNfkrMbQjd6DrEH+Z8LckqlOSRoyJ70gwVD9wqR0/AM/hMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+u4ubUIRwW/l0byA9OLrX8nXDHwY8oaHKB0cQgsEjhI=;
 b=Tw6q1mP/s4A0gGsGqfhiBRx5ZOlG1rf2K1bym3vZNYokq2fJJyoMTCS2lauXsDIX2jRz3s0SZsY0vzL2tGf/NawyrvWD0LaL+tWUX/XbJPdSqmL6kag5yIwGCYVCCf4ZhnVsqtCVtLgVtfOUZLFSbt7cMIEJncMORuRrx5Z1QzU=
Received: from BL1P221CA0034.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::18)
 by CO1PR10MB4435.namprd10.prod.outlook.com (2603:10b6:303:6c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 03:38:03 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:5b5:cafe::ed) by BL1P221CA0034.outlook.office365.com
 (2603:10b6:208:5b5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Sat,
 25 Apr 2026 03:38:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 03:38:03 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:00 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 22:38:00 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 63P3bk812903263; Fri, 24 Apr 2026 22:37:57 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v4 02/11] arm: mach-k3: Use FIT image data addr as fallback if
 'load' prop is missing
Date: Sat, 25 Apr 2026 09:07:33 +0530
Message-ID: <20260425033742.1519298-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425033742.1519298-1-b-padhi@ti.com>
References: <20260425033742.1519298-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CO1PR10MB4435:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b19ed8-9f6c-4e09-c0d1-08dea27c0e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9n28rXG9HwhpboFpv8LwNH1MiePZBX6PNJMitU8GpKV4Q5b6ZWgHV0eroWr2VfQ/YBYi9lt1MzXV6K0ry6RMkIjX0lzQb9Ym16mu8bv2E8/pSqj/kOZK67G9QKlW+6vdXIBr0p1zDozgPMwyat90lwKoN5KVJ6SniZMMBIC4rgfSn/DPq6TLO+fHYGAAI3+z29QpSe0IVGpOO8wZ3c3ILGtWkaT85mYUJqDJHE07swO3S9+5PxwL1Q9fB5Fl1QcPiEIO8/ZnMsFGf2f/y2YIQKaelyY6PfnGz/JoGv+5AvjX/5A3DBWwR/KfGZc2TxA7vRGkVX0wnlU+GR9uFp/OlLyMtzhkM67mn/42BrkqG8hpyBAcQpjPDmDfpubZxMKG1hIqi74zrRQQD6dVo1U1Am7ZQBbrr8zo2w9c4cfphWtGUL2cIHkzQscYx8Y6I0ihTsV/vYNC8sfMsgakZu4vaAC2b7iEoRhWeNE+29LCSqVH1lywUm1zKnf7NzPBamma/ODeiacLuuRJmELqbdf4YY7WowAUZPdzTIeNDqywMc++fXpeFN3Jkyz3lwBInAesLW+1cUCQslhOa8Teu0aEm06EsN5im41PmbvJ0XRg77uuAFp3gsj/ajmr9ScchmEVbwZoo27ExI06OBGdTaAUdVihZ87dzh0H/+5tiNnYeprLRoCTCg79+DNndvil7AMI3LOg3kcS+7KPjTRJBjeTALAa9YAa4mSs4yl/a+xGGNi0BlaFfXl6Qx0PNow/xUVcgUQlt+0HWlyDpI1AajRLmIO+PV2hrkTcbxSkP1rNfNc=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YvNR5sD8FGyjj3ONSQvG9WKPAdwJvIT0S1k+Wxn7RnXJ9oJK/JguTeCMZILl5D/xZR+XDXHilhBPb52kdeuPrYsASEqb1Et2xLOxChUJZSqWcdigACm7uGaDyX/PEdAbJblMK7EZV01fBy7BlUEdWx10rwXiVHTMPncmFfWUqHZRO2MRtdKrAt7IZ+2EfigidZXwT9hc7ZJEeTM0MO0nzXxXnUxCo5xpPEcFG+EA/dLsb2KQiyDXCKoYj9sa6vWXNx5wmfvLxjbyKH3DSsiN+kXp0ftZMn1+kyBNVkzojc+D7DZmBiszpHy9tPzZfUbThnoIsyGu+wtPcylfiRf4ewax8J9UsCkqaI9Svt1hUsqv3otp1WXpsYlb++H39FM3UQvOmHS95lQI6wg3rR2QNhILoLqg5AyQKGmIm1sZlJXHvPbJLD4hChgq7939tzD6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 03:38:03.1677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b19ed8-9f6c-4e09-c0d1-08dea27c0e4e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4435
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

It is possible for FIT Images to skip mentioning the pre-defined 'load'
address property. In those cases, SPL uses the actual address of the FIT
Image data as the fallback load address. Use this FIT data address for
referencing the image when the 'load' property is missing.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-3-b-padhi@ti.com/

v3: Changelog:
1. None

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-6-b-padhi@ti.com/

v2: Changelog:
1. New patch. Fetch FDT Data addr for accessing image if 'load' prop is
not present in node.

 arch/arm/mach-k3/r5/common.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 484d96f9536..50c4231655e 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -328,12 +328,15 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 				  size_t *p_size)
 {
 	int len;
-	int i;
+	int i, ret;
 	const char *os;
-	u32 addr;
+	u32 addr, load_addr;
+	const void *fit_image_loadaddr;
+	size_t fit_image_size;
 
 	os = fdt_getprop(fit, node, "os", &len);
 	addr = fdt_getprop_u32_default_node(fit, node, 0, "entry", -1);
+	load_addr = fdt_getprop_u32_default_node(fit, node, 0, "load", -1);
 
 	debug("%s: processing image: addr=%x, size=%d, os=%s\n", __func__,
 	      addr, *p_size, os);
@@ -342,6 +345,22 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 		if (!strcmp(os, image_os_match[i])) {
 			fit_image_info[i].image_start = addr;
 			fit_image_info[i].image_len = *p_size;
+			/*
+			 * If the 'load' property is missing in the FIT image,
+			 * fall back to using the actual in-memory address of
+			 * the FIT image data.
+			 */
+			if (load_addr == -1) {
+				ret = fit_image_get_data(fit, node,
+							 &fit_image_loadaddr,
+							 &fit_image_size);
+				if (ret < 0)
+					panic("Error accessing node os = %s in FIT (%d)\n",
+					      os, ret);
+				fit_image_info[i].load = (ulong)fit_image_loadaddr;
+			} else {
+				fit_image_info[i].load = load_addr;
+			}
 			debug("%s: matched image for ID %d\n", __func__, i);
 			break;
 		}
-- 
2.34.1

