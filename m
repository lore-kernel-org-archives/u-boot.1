Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64F3C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 13:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5ADA88496;
	Tue,  4 Jun 2024 15:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="ZN5l/obX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD1B884BF; Tue,  4 Jun 2024 15:59:28 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::72a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5766488494
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 15:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUN2uKmyJbUyncM0hIEY4PM1txpRSIonpdHYrsh4ASakvqVSNtEV4b1tk9WOEcr1aV+SC+2Z8U2i6K0bIgVjSCqPeL56Upg1mTfLHKm6mxe07vNdvUlTWH8kVdKhPKbW37O10zfjOtE0OemFP/XV3sv7JL0xwO8idOBw8O02SCRPrzexdN8bw/p80J4wPW6Xb5/WUn0z1e/w97H7BRY7ABLbko84ZaDX06u3DYuiVWsEu93LoYPKHs2FbkpD1KY+oNzycTV544T4m239iuTR6CSPR9oYhiFjdGVJpsPKE2pUMJFK3hRKdWeJ1OgAA4xEA5XuaGoJn4M+WIFW8fH6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzSdAmXTBMqLzkbzMRq2lfPXAYw7Bl78In3XLrVkTn8=;
 b=ewSS5PK5ISK4NffeJH/OlKYDZ3Uk6VXwRiHT1wMQgEgbuCDJBVYHtOjkmCeRou41n7+HvAcnJLRo3Z/aAhN6AXDICQt+yulZ6kx1ItSnjaEPwymF0+izRXMD1FWYjo7+uucxUEoYD9VQumZSyhZ+sfP8mJNobHHslYjTTUlIPfvulnU1RVu+dlbEfrGHNpElQKGnXP3GPIExtGWUwxRRNYTrxPqmgc9W4gx1CKDO46a0NZDlcoiDvtFs25Kuwz92NpUWHDweyj3WxIzKffQk9v0jqdAu2LEkbSp10hZfnOVy7qYL9KFOqMKkX5Aq48lop1pOVxyJOt8DS9ZcN+IGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzSdAmXTBMqLzkbzMRq2lfPXAYw7Bl78In3XLrVkTn8=;
 b=ZN5l/obXrOok+gFIFfJBCn1gWJkdaSkFiA8ii9BnzOveVHCH7b4UkqTANoG5MDhTY+Td4QgDPunqm1jhpvMrVb+O3W2FJFeGeggEccYLhR9B8X/BMfD5qeq0DECXCt1W/+2Gjddxa3NyYcgCDTqwYk61Id8xUm/Tp/9wMVikO3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by PAVPR08MB9795.eurprd08.prod.outlook.com (2603:10a6:102:31f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 13:59:24 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 13:59:24 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 1/1] xilinx: zynqmp: Enable reset_cpu() in SPL
Date: Tue,  4 Jun 2024 15:59:15 +0200
Message-Id: <20240604135915.405660-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240604135915.405660-1-lukas.funke-oss@weidmueller.com>
References: <20240604135915.405660-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0273.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::10) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|PAVPR08MB9795:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb6aa40-2772-4637-2947-08dc849e8ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|52116005|1800799015|376005|366007|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lopfDkZf2bkNuYiyWPcnlZSj73X+BmQDSy0tzsAM3g1IZusyur9+XyEah8O9?=
 =?us-ascii?Q?5LeJGo13/2EhsPW2/8mFm6vZr9+NaoSvDBGhULaNkjmGcltDzNmURftQAqvX?=
 =?us-ascii?Q?J7T1fGchui22LxSLWEoj0lmCJrbU/cIx+fm9qLMaBHlX8DdVzGlomktI6LXb?=
 =?us-ascii?Q?Zjk79bUFlvPmIeCI/7SY11MDSE8wDAvgqFh6K5YUnGqjsScYAJBWuw8oh9dg?=
 =?us-ascii?Q?zWLov5kmPgQx+qwcx2WcJjetvlylpkmzW9mm3HwNjptWVVhdx2QTsfSJtHm3?=
 =?us-ascii?Q?Aayr7sQ6TJMz9rwTDhlSASsbUQTPw6ebvUv1xOjPXr4otiySJGQ3IIiAI27z?=
 =?us-ascii?Q?oi4H8dxqGiB2qkW9Fip5RlvgAWxMgLkn9/hVbSWkvUFFaSCx/Yx+Ty7iQOA8?=
 =?us-ascii?Q?G3Vsy6UhsRrow9CJSPj1L9WpWXbzckNhDV1PbEJWZa9RefLbFK2R1z5V83LI?=
 =?us-ascii?Q?HgTi6IfWhwyoO5+R8j8aLkQewpyPjY3QR6I9bnjXxBV6TKviL+GTHgQHsEzc?=
 =?us-ascii?Q?w8VWWcWsj6EZjh7yjywHsRV85DIWF4m6KaTBMTjgOZWLJpWYEDfzomp3IEFh?=
 =?us-ascii?Q?THTQP5mHWwGdnfsk3fnbBtwqxevqFo4TRSiWudwDFa6xxP7WCYfO0gXTe4xf?=
 =?us-ascii?Q?WLdRrOFkwEOrIPrRIguWwgukSJ3PPyLejw4A0xhYSISgV5sG8rwNLsJkT6Yz?=
 =?us-ascii?Q?vg+5X0RvaPdw0zeeCXYXtcPTO1UElD4L1Ws0hb6KVwuP0y/SIE6Y/UaRl87h?=
 =?us-ascii?Q?4Hka3w1mW8+70EOjtKjj2qLUNV91decjPmqKWS/DN+dcYJs7+vxtWgg+g7EH?=
 =?us-ascii?Q?7vh8LPS4hLmkfM6oujXYB3ju0ZdR6DSQHtA6hScn5nWbs2rlqxdMEBPnMQHB?=
 =?us-ascii?Q?hwvEO4XGA0EJFHed3uq7jLFSBwHrGp202gEabehLYfcv6Ghw4qTYCh5rf0rG?=
 =?us-ascii?Q?l1XmzDGM17iyJmgkAIip3XMwlcUXkd/heEv0zAoW3KTs/JUSdJtINXrpnyBn?=
 =?us-ascii?Q?Pg9grPthGPXMJQpCughV0kR+A6oxUGkahYdNS27u1WOzpGQFnQ3URAq0r6Mi?=
 =?us-ascii?Q?8dry3t1tCqJ9H4JepxsKAneglYDrrlgr89WMl2fDHm3U5PTUi8pVm0p49um0?=
 =?us-ascii?Q?I2Nl0EI52y0tEiQ8Zg9ADxOe3lXx5Vbel8n4dSR90NzFYRbYYhgF8ziqCNei?=
 =?us-ascii?Q?SqXoJG4X7LI4s+bXQLfoJuzOm7w8QNhsy/wwK7gLczf58rP6nDFUi3/oWFjf?=
 =?us-ascii?Q?iJaM0+9GtUPU9tcQpcbEC8bO2M5DjmOQZJQkYwuotuD0v7CIN1Ffll3uJpem?=
 =?us-ascii?Q?Sbvw/LHcTllG/X+GjK2SyQX4kH0Vv6132RrSr1+2mEJ8dA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kYoyy9PbbF+olPpylGTgty8gGGj+qVFVeP+yKbSV2bSw2HynmqsUXNCaLUTu?=
 =?us-ascii?Q?YxeD6n7VMdX/kchucu7lwWTiNviPBjmst0XZFl9g3t+K5AVt/2Vdkh4nifRH?=
 =?us-ascii?Q?UGxj4ro5wzzI1A4g/nFbTq4SChbbIKYcjcJps/S376MLV0bcgTNIQTUIDU2n?=
 =?us-ascii?Q?1Ej4RyRgZtacpPgtnBkYeWFAAD1Z3udnTYF5ibFMhagxwiV3pBdxF+fVUdXw?=
 =?us-ascii?Q?XO0DJBJgz2qKCEpEi5LuebouM5xqChVD98nhXussZXdxmQqNiVU6ir/1Pc8P?=
 =?us-ascii?Q?PG2pXuzDBS1gTnBWKKuwLB0Ze/wdQdRqcUi7Ntzhg+98Kdo3YssBltL7UO7A?=
 =?us-ascii?Q?d06OOR8zRTxg3dBv+lrDX6nKYFPXmj9bJpGW1WzwrCTt9c5+3Ymc4y6JNIR4?=
 =?us-ascii?Q?fscwfdDJbj2snCps0P7wUzcpeAlMyx5dm4oJMnNL2v99pMbB3odtQdYbbgUr?=
 =?us-ascii?Q?GCTzGxS2QT5HZU0YVNfNTq7dlnYe86Q+DEYMa0p1emPFh/BdET2JTTyCuhoV?=
 =?us-ascii?Q?qRhUMtRFRJ0rBa3pjBeuEPSZkKFXKm6ah/TiKFpvjbv4SKaJ29dj50GqrB9j?=
 =?us-ascii?Q?RzeUoGSHjpG2IDru86X79a0nmOs4ZJy89ixnuoT3FKCb5UyAeK1kJ/JRAUDK?=
 =?us-ascii?Q?GtOUA15qL5FSDmkl1YiyZw15C9esQ8+rdt4rWZdNLC1Xwlm7LfGb0C4KCRUa?=
 =?us-ascii?Q?N3vRBy+6TM5jR/IbvUgA24wkcMib3TThAfJbs18s5/CkYkY0qQRaCOxJsEWe?=
 =?us-ascii?Q?ERUX2Mu1YgwIVwd+APWZco9+bNKM9X/rL5GZxw3XyNqyUk6TZkqHopRZepG8?=
 =?us-ascii?Q?an5L7IMToedFgmAPllo0HMyUzArKYslqyxKsi9C9nYdHlWANcP8iu9Am7suG?=
 =?us-ascii?Q?Q8CCEaO2hsyzsQQX1HCn+E7yn+FATPZ8VMBl9rl7PYb8Xb85YhmnWYRsKT/y?=
 =?us-ascii?Q?eur3fPKpa6cZA0eZJco2+RT9XiBUfWqjC8xM9pFBc0/7bNhT2qVq0fV2pU0a?=
 =?us-ascii?Q?kv8YW0duuG0jQqRpIu5H65eVElWPgTkSd1lUM2LzfgvQxaTsQZGrJgd3fdVm?=
 =?us-ascii?Q?0mZXgrVhlTYGyUYjuqoZprtNwmNWwVSLV5vqMEYC/5Utc72o/a4dZUxLkqbo?=
 =?us-ascii?Q?lsWFu0zw2hvBlXAEMEzKbjfBsiq94ftmYsxBkooeRlp9YlfKiDY+jUUnoxap?=
 =?us-ascii?Q?NB7YBGmJtobAiJxxvPqcSv4/XgH3vwfPVZGaGBzRTlx0P1pD78T1FBEFx2qr?=
 =?us-ascii?Q?jHDd5g4TtcHkWGMgh2Lu9f+ScWWHw8AFk1nZ5byHFn3SW4uNVlmObsvZTF2v?=
 =?us-ascii?Q?R4oXH/du7F+vXuL5LnadffW/i4ZkWHnL+xDMNl5OpqCfeezdolcgXKtOO9+c?=
 =?us-ascii?Q?FbhKFuOO4FqVVacaI57R//v5GJOzDm6yyAKrvHNDFKcN+dZ1vQczFLgulByq?=
 =?us-ascii?Q?aQ24BvvBn+M4UIHd2lW3YOp+Iun3nUUi6gPrBhcSuC8AD7/GM/SucK+uK2W4?=
 =?us-ascii?Q?k7/OKqgQQAwk+C5m0UX8x8NqrFsdSra8fZBAyfgWhgoyfSJOHtl8aJSKeCPr?=
 =?us-ascii?Q?uEgDKAEIGjAVK8LIiQ1uPORym4tf8x5HBJZKfW2xKldKbpFjHsORgdp+marC?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb6aa40-2772-4637-2947-08dc849e8ab1
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:59:24.7136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1a9AUdMfb5pjcnOu+DJwgsFtO30lkxlBo7+CIgBhFr4DqKoiZDBSy4SblgK8isuWhvqwkBLt5GjRVQCwa0/iwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9795
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

From: Lukas Funke <lukas.funke@weidmueller.com>

This commit enables SPL to reset the CPU via PMU-firmware. The usual
reset mechanism requires bl31 to be loaded which may not be the case in
SPL.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

Changes in v2:
- Drop 2/2 since reworking ZYNQMP_FIRMWARE dependency is out-of-scope

 board/xilinx/zynqmp/zynqmp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index f370fb7347a..a129b1dbbbc 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -40,6 +40,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/sizes.h>
+#include <dt-bindings/reset/xlnx-zynqmp-resets.h>
 #include "../common/board.h"
 
 #include "pm_cfg_obj.h"
@@ -285,6 +286,14 @@ int dram_init(void)
 #if !CONFIG_IS_ENABLED(SYSRESET)
 void reset_cpu(void)
 {
+	if (!IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
+		log_warning("reset failed: ZYNQMP_FIRMWARE disabled");
+		return;
+	}
+
+	xilinx_pm_request(PM_RESET_ASSERT,
+			  ZYNQMP_PM_RESET_START + ZYNQMP_RESET_SOFT,
+			  PM_RESET_ACTION_ASSERT, 0, 0, NULL);
 }
 #endif
 
-- 
2.30.2

