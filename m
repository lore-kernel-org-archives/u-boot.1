Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4085BCD4F57
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 08:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7274183DBD;
	Thu, 13 Nov 2025 09:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EXiSTn6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED0E683D77; Thu, 13 Nov 2025 09:22:46 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF71383DC9
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 09:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIPP7zWLalodDvQzMtYIY+xoLtEy4H/5nrXo6xetqIgC2nT8kYCZLa38CSt2hKLkESzWsUGJuMy9n1seOsMxxN8GHccAZZlrpHUFf7GFQXM6zUlCGK6aWfixkc73mMT++Qu1IFy2qYdP8PI+kbrPY33MS58Dhj9mNF3JBs2OiGOvPi5hQd5BbDVrCJKfgYq0UfUMfqkzvXuNAAzjmVobPdVvW8JZkvvFQ92Y01uhhVfS1HdLP4poG0S8H05WKZ5autHV3zIQGzjpNLVJHKYJlk7FnHZcPb9lPwX06sluG5w+kIJhms+UwtdjeWBItr3Sz7LNLRsYnOCwfYusKL3Vkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xz7rfz1Im3svKoZ6FAUnQGjSp/66CN/b/46BnT+/cFE=;
 b=QSeUqr51guGdIsWpSPNZdFrtkz3VSscheNjiMOwAJRAhr7mZMGjiVQzo6L9EHqkCXyRb+RVecnBcudEEEyrc2DfMhR0n35KRNXBRm9Fj/3448w5cGgHz3rt4h0FPEVgR0o0YNFcAfq18u3Cjz6qmfOK34DdQxo5R/w/pMJSfyx2GqDfNYg9GDrl/1JLu4lcMyOwI3VWG+wW+N1pTOc9hEaNohcNpioWQKz1Iv9HYqU9k8Vk7RiaR3z7/55C4fsbFYqROcegq/Zct12Z/2AjI6cysZH0P43tCBpATKUE4PrpvWv0i5WMmZA3oyoAnLOa6+n8K5Oc3dev5YdazBdXCVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xz7rfz1Im3svKoZ6FAUnQGjSp/66CN/b/46BnT+/cFE=;
 b=EXiSTn6O2TkUJ7LHo9diZdOWZFmNxOsAcmYZ3TAhmZ2M+FS2QFxn74fcoKsjX6SwzsQ2Zv8asKC17EdZXAA7rkHpDy1kcxMk2bEKtkU/e4ZOzb8BU9KvfzOo+uEC4OCkZBWcKGnLx95+XBGNaMt5AK8yNe4ryCQbPBfVah2/zSvpvQ408UYETW2vuROtIDAzAKTnVWsMaOe8IfzkSziSUib8DiHEMaj3lkVgrZ9nNq1uhybZFyWg++iB+T/XcunV9RO9sJZmW1L5u/He7O9QbKypNNRp3k4j/OkkjTDLSZTAO/5Pj747ZLwzOKRfM6Nsm4F+b6N+B2b7Tw65jdcDcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS1PR04MB9453.eurprd04.prod.outlook.com (2603:10a6:20b:4da::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 08:22:41 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 08:22:41 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de, uboot-imx@nxp.com, sbabic@nabladev.com,
 festevam@gmail.com, trini@konsulko.com
Cc: ye.li@nxp.com,
	peng.fan@nxp.com,
	ji.luo@nxp.com,
	alice.guo@nxp.com
Subject: [PATCH v1] imx95_evk: Initialize the ELE RNG context
Date: Thu, 13 Nov 2025 16:21:45 +0800
Message-ID: <20251113082145.898431-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS1PR04MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7f5c54-7798-4ba4-4a7e-08de228dd003
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|1800799024|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t1Ozu1xnolR4yjxosJgGlPljykNBe0HTuCQAGCwnDXKrMUdzquuDGgiMqG0k?=
 =?us-ascii?Q?upKshdMnMdONcobYN5jlsboI6L2ajPzv/XONt8MmV9fmc/0BjuEWhhTmU8WF?=
 =?us-ascii?Q?7OszZQuRD16Z9dh/guO2RMENVCrdKVyi6oroVyjLfAgx91QXPDelXsM9oh+I?=
 =?us-ascii?Q?6E3CNHKiU9w9amN3DLkZuO8J3/trOit90Gs3qSl/fcoTDNQ0KKG0eCuR7mep?=
 =?us-ascii?Q?gxVbPzNlYUBydz7cT26UqVSN3EGNnvHp/K3Pxv7IKQItxkkwin/6wqKMV8vt?=
 =?us-ascii?Q?vbCkNnS0tBC2NtdrSowYfZWycGYtAxkKtFS5+7lg1BYz8dhE19xCH/UzEAsK?=
 =?us-ascii?Q?EiPJTmSN79cGxZtke5KCmSCGIQ4BM8OGtzmir9Hf3bAmwQZzuaHPrsD70obn?=
 =?us-ascii?Q?OdCs1n02ctcjis42wg2uCllqPid26uXZGGPMKqth2EgTWZnnI8Pu/ZzBlasV?=
 =?us-ascii?Q?CoZ3Z7wWui2Efjkc1r9p2LcHqEehhv7K4QA3XMuxI4l/BuapFDdbnOINvmII?=
 =?us-ascii?Q?Lal5qX3d3Joe+nRF18sqfdhc7VmWJUzrYUmfXAv3Y6hA0uRCZXKZMWh+dn81?=
 =?us-ascii?Q?nzE+QDnIXSP7EEWW2jcLOjlmA/zucg3ro4DZOE6Z2OYIW1K6SaT6uQUbHjMb?=
 =?us-ascii?Q?z1hzl1VrytJZHYqLVrp+/XrHY+VCme3JtjwKSuAgMYUC+oyU5KgMlx3c+6hH?=
 =?us-ascii?Q?XWhWT5KuL4eCJiNymfO7Iw+tZDUgRpIiWWp5HJqkP8gSE6MGzonbeoZowQ2U?=
 =?us-ascii?Q?ZWpRaTDB9nOAHLA/YLaalc5JDfDEU1SxyksjDGgU22cNdyTq92ibIcEGD8R/?=
 =?us-ascii?Q?xu12b4bHmj6PJF1P56TdO8xcdbkJ2JQCpHtX1FyiYL5PKa9D9vWW30X4OyiB?=
 =?us-ascii?Q?OgfzZot2ogJpi9SRJALPwj4E3kyj+yvYL+/4b76Xc/gJjZHq4tN7uicrVcbS?=
 =?us-ascii?Q?aVpWpg31u7h88KMy3AZrY65tMSEAWf/uY6xM/BvmxBhm50Up1MRkbeLCRBV7?=
 =?us-ascii?Q?B5irnVPE9CdsvI2AOu40/72PFRXmWJZkiB+ak3WpSBIT06kXBVVBX6prezJn?=
 =?us-ascii?Q?VOuikiWO3yI5ghS4EptNmF14qbKOBEiFmy2X7zSNeJ06IBZYYhPP5DQiVYon?=
 =?us-ascii?Q?srlTLnZCMa2qi07FRTa7NIfSBcz45Qb7rIJmQmPXCocKw2f5bXqx/WxwiwYY?=
 =?us-ascii?Q?4dcD+bNLjc/VoN1SUWe5geqWkQfAZLzCXTuln0kbNl8rGUn/QHaPfF1nIKKn?=
 =?us-ascii?Q?0nxi0JngtmN1LoIw6PAJ2wzLWZSbMuko1qErmogJEjVugQhJLV1TzlRVEPy2?=
 =?us-ascii?Q?2CxfrOUv5ciMrskTufGfd/ulXmrch60vi3LKFQS5jz/jEfq30WyzSojsl4lt?=
 =?us-ascii?Q?+tnpddzhNCiVL11OkiYsTy9mk66DURGsnRtVdu9W1HlctN4xaZw8BW7g96UM?=
 =?us-ascii?Q?g+/mAqwZ0mF3qyOKPu9uJ/LVX2s4IyJb3Hu4JEE2JN8pxfRSFE10C5AbP4sV?=
 =?us-ascii?Q?QuvMM+/0BV/mZhQuLJiCvCZMzt0PCFEeHq3w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(1800799024)(366016)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?07sOkgo9GdVH+8R23GcND46AnbT9qB1OpkV3fL7ctLE8IzvacMNde86Q6d68?=
 =?us-ascii?Q?4Mba7PD06S6Ld3eInO69zkhUWiHkdZLA4HA5Up9CbS3FZnH7akN8yLrrEBBh?=
 =?us-ascii?Q?2wC4wOQ08o60amJBW/DxkMAgS7tpIgnS6PutzOA7lEzqoe/uZzy6stwfgaWr?=
 =?us-ascii?Q?GhVVLsvDzkUWg0P7QpnjR2R1PZkwXPOv5RN69Eyc+JfcFaF6EDG5sfXOd2pn?=
 =?us-ascii?Q?f8rBLiLCQpDTdo1GKiLQkMSIE/ZWsdpqjGz6kx3T+GxU+/PVV+QGcj0JEBjD?=
 =?us-ascii?Q?7qJfj7Q4n1lto3m6xjwyiapXLZRSxn1v1QFNcYNzFccNTKyFg5yeD2SnchbP?=
 =?us-ascii?Q?DConTA6mTQQ+pfiAnZwGIexeemejgtfYL5oydUGlKMZAgax9eERHlSxX8oyR?=
 =?us-ascii?Q?UUZFgVZIycNVwmv9RKrrn7wdC/VaEqVkDj/qsPTB7FrG6cKCn+YJfAHP+Or/?=
 =?us-ascii?Q?AgC6N9mb4iM7b1m/ESgnNdGnVfyyy4tevNieU7DEQhgLRLB+wKFWW4OoUB3e?=
 =?us-ascii?Q?yZ4hYRI9JOkyDtjY0my4ULIxP46+3TtFz4sSjXYqjoMlVSeaRdI7kW1WuNR6?=
 =?us-ascii?Q?e6dSh57jN9dh/3tlgybjfVQiSm+uPmz1jEZf9zH2/5PpGkMcikhf8AgMKkYJ?=
 =?us-ascii?Q?5nUp2lDUjWlbDjkG5KFvT2EBarKe27h6L96vOhWHdW1QXETpotDg847Z7vx6?=
 =?us-ascii?Q?BoloAlRIUgxuofi3EpDxIRstSmPDjL8N6FUnZBxTcDw17XAULhwrre/BK8If?=
 =?us-ascii?Q?ITXYeHxGtOcHpZAMr0Wcqb+9RSSGvg2d/WbzBSdQ2kbOh9cTdO0Vai6v0phi?=
 =?us-ascii?Q?c0hudXKPGUeaDum8OajxAFvMVEvUEq5hfHUCUzQZGNt6r3bmW+KtZZ+1pQJ1?=
 =?us-ascii?Q?AxYw/CZFJ66tskw3HkHdcpNYq0APYO4pOWAqQ/iLmrBkd2BABk21xn8GppsT?=
 =?us-ascii?Q?8RGoys94CIcG+W5cWysuToMLEAg9IzvCHduglYd4WQhL/dN6fplxUoLXNPBd?=
 =?us-ascii?Q?h7LHzO5xM2RmSVKpqA78v3t1nnb1tnrYRv2jXHQRCKC7oAhpKUaLsYBg+Jzx?=
 =?us-ascii?Q?QS9iySHu73xTnyVfMFBhkFKjaq+bm0C3goDbLTLhfUnyRxRclckkq03qfQPj?=
 =?us-ascii?Q?4fys039OKfaHaHilx4t/4WaeLhOpKdJaAe9CLU8sjjhDSrzOGwvAOOvuaBZE?=
 =?us-ascii?Q?Zo7WCt6LBKT/uq7ujjXVOutwG/a4sDlLSVibwsc7qF8sa3DtIGCjTNnKmZF7?=
 =?us-ascii?Q?RsWYKGh9ZinTL3bJKD0EUo0s0gHnGYArIskJR/W7LEKZyOGVqY2XXojx7hqy?=
 =?us-ascii?Q?glGYpZ3rjNCihP6TQrxx+LBcej4snHkA77qqjGg+yxEDaL15j6B4qe+O8VZ+?=
 =?us-ascii?Q?uPyd7FB2kFQ24VCINNfpO65FqV1ztf283i1KAlAKGEt/Yd3XDne0Kum5Kgui?=
 =?us-ascii?Q?P6lNHPu+W+tyVXA8tL88SIY5Z5tPIs7Ttp4iEJpUKgCjwKux4sbkO4NLhNDg?=
 =?us-ascii?Q?LsJ+AE4J9GQ3Qf2z1S8JAQ88Sj5HdFi/TlkqjM8Vw+Xv2f+idbSD0+vE1KwQ?=
 =?us-ascii?Q?VMMVQmgYmYDI9wi6/o3sX7dL/2fPROXOE4EVNr8d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7f5c54-7798-4ba4-4a7e-08de228dd003
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 08:22:41.4260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8B87Aq2hCMzmIsUZ2eW0MxKR1PBdwYvHWLjr4hrqqwGWAUjWo5EbTxmia3rSofz8kEc4Omo1ppH/hYq9nEFeWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9453
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

From: Ji Luo <ji.luo@nxp.com>

OP-TEE requires a trusted RNG. This is provided by ELE on i.MX95. Start
the initialization of the ELE RNG context before OP-TEE startup to allow
OP-TEE to derive RNG later.

Signed-off-by: Ji Luo <ji.luo@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 board/freescale/imx95_evk/spl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/board/freescale/imx95_evk/spl.c b/board/freescale/imx95_evk/spl.c
index 3d64097b4c7..48b47d2aed9 100644
--- a/board/freescale/imx95_evk/spl.c
+++ b/board/freescale/imx95_evk/spl.c
@@ -7,6 +7,7 @@
 #include <asm/arch/mu.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
 #include <asm/sections.h>
 #include <hang.h>
 #include <init.h>
@@ -32,7 +33,13 @@ int spl_board_boot_device(enum boot_device boot_dev_spl)
 
 void spl_board_init(void)
 {
+	int ret;
+
 	puts("Normal Boot\n");
+
+	ret = ele_start_rng();
+	if (ret)
+		printf("Fail to start RNG: %d\n", ret);
 }
 
 void board_init_f(ulong dummy)
-- 
2.43.0

