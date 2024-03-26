Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149E4CD11DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 10:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3944888059;
	Tue, 26 Mar 2024 11:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="E0xdXuLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B719087F5C; Tue, 26 Mar 2024 04:30:38 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3EAC870D2
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 04:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=joy.zou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRUHDq+RRgTB5k5/fukpVpwcvyMJUYjSO3DGpTSusFJI6BPC5cDne1oKwWK5QGXZsBiBkcC5NUJgMxDuEIMn53VRO/iWvPTv6zeCGCbhGNBUmNHq83HcawxngoMvQpYqaeOUBTlxFsH7zgoqX6YiUzDF050fPkNlCzYz0a9C35Dw7jtwiToxYCPx2IvYt3gCRTxLGuLRvDillF+wNKT61ZjjQnweR38vYQPGQmRPXOrDkKrOJSklrfuoYA3R5rQP3URQmiy2Hzq9Ua3YlxFRMDnhkMh6n3wv4O1yG9Byh5zxFDkxEzvl/tQhVJEWUsiVYkT1rwmmMG9ZSOvQbIfJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNos00hQFGcFKXYbptqBXFCAoxBJCXQIopPrngM8zns=;
 b=HysFuljKzWGp2+1iDXFPwo4U5tmF4S0LLM6abpEtPd4DRRRGGCDEAPA4a+aiqbwOuWWjA7S5VR5wT3H/MrCm2MOio3b1ogp+2JSvkG9iaEw79EJ9Wr4oC5JME9VvBnLHCweB3Mh8Wal7hgoen2kxNECin+oVN/uz+HVfm23Dbi01aXH7z2mz/iYCTlMBW0RcaxBaSfd9pcaFq3CR+t3IQ2EY2tdO4KY9JZEUmifBOxxRI6KeBpzsM6TkgMG8uqWi38AuHI0VO7HyeMkHXuXuqXWHl+iRcFMY8BaJHmGCMMmAbyXWb7RxAcFqAY2mieABM/lWco8ESZ4cgDyLPeOvIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNos00hQFGcFKXYbptqBXFCAoxBJCXQIopPrngM8zns=;
 b=E0xdXuLts3/XAe8mDZp+BM3IosN/nJbrnXJR39uNHddup89uwOGMtO4V99faAD/ElNQF7OI3z+ug8HdpoFJDN1D4wMsBzzgP/wzWXfVodo5HGmk4SF5JnptRgPxRF8+MCcvU6kmr6kHWFJOKTuU9MAczD5yk/Kj51LZ/Db5tBiM=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB7863.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 03:30:36 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 03:30:36 +0000
From: Joy Zou <joy.zou@nxp.com>
To: peng.fan@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, sbabic@denx.de,
 festevam@gmail.com, sjg@chromium.org, saproj@gmail.com,
 judge.packham@gmail.com
Cc: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Subject: [PATCH v3 3/3] configs: Enable RTC pcf2131 support
Date: Tue, 26 Mar 2024 11:38:01 +0800
Message-Id: <20240326033801.228419-4-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240326033801.228419-1-joy.zou@nxp.com>
References: <20240326033801.228419-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0192.apcprd04.prod.outlook.com
 (2603:1096:4:14::30) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS8PR04MB7863:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8UH7dLSJtfkQlNh/ISFJS/uLIW5uNDc6I4bUSMGBSeumqXUO3zJ4cyyqBMBM9iBkipeErbuGV4wmVFvgZ89u0g+ssQ57QRWxcmWwQIqTmF8W6W+eajKS8nDWk9z9XJ+8U2zaFH+KiB2tZ53ukTYaZfPvZUlbd35obwOEk5F+FmD04uoEBYK/kwfBg6SgPA4AvJ8QzmvJ61o+5MuHyIbtGHLCpnZglGVuDJJI4lbX1LJ5HDDKxWVI6MP/ejG+hVqPBqQQUz8yq54cziA3UsvAs/8NFknqdtSEc4gZmvDXBphtbOyZbG/yQwMYc6spJRJdZ2/+ndoDdI1coxHThplFGgPLLRDSpFocDo24PoKoCIOZegY6yXEiaqWCoTV9qZollXLgw1HeuV/CiWxwq/t4IKLugG+JOCVqfJHNOhLUXFsn5MfPmMbzQQaMlop0UzSYK2OIM0xo63TE7uNHmjqjKAs+KA9NSssbW7yALmwUq3XTcIB6QyiOVjk5D5BS5bO5GE4APGHtI2xpI0lt/Hf4BBB9auNLzetI9pjQIj1/lVH9xxb85wwtU+8kXiWh/XDSWUyxA4a/DYeClPhPPPRt16uJliBLH2A9K1NHH2EVbcRxys9nQuHIX2PXA7Ox5jIFbNYEmvJ4Gzbs+/qfQVC2jBxOQVGOrhim9nQSlQhJFTma+bI/T0r+93DR3FwFT5kipjNTmsUu+scBRIX5hDqagJzLr5KITjhKQPhyioz6Cw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9386.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iR6EFQipoJ1793imlgaVTK3SxNuVo26HB8KT2zHIeEPWBHvLnE/8ExxKpNlV?=
 =?us-ascii?Q?f8LvvGDs7IJlhRA+uCiMm1gEjNS+vn3PQg/xQMekNUpKyAHVSMCpuA1o3Cn/?=
 =?us-ascii?Q?bN8jH/es9zUYbTriCT3dsYDbqgmOeLyN9w33w7PM6PofStzLvwiWZvNdfPld?=
 =?us-ascii?Q?y1rVLmktc2de7s9wvavxPkvmgvn+hnEq4YSiPeQkDOREuI+5yRJ9vrsdwDdY?=
 =?us-ascii?Q?mWQCfvkVPbZ2VT5wItA6SGRLa1DQtsD2g8ikdvSN5VK0qZt8eP1YUXLyE5O3?=
 =?us-ascii?Q?5l0pDG8Tf3XHv3lp3OBNPD+NDFJsgHPJpIn5nG3LdmXL+JfhJ5lyzNUGO1zf?=
 =?us-ascii?Q?+FoKDSbWhmvzrKj41p0cYw8K6I3fYQtWXOFLvvMEV70zoKRK988aFfbZeof/?=
 =?us-ascii?Q?UpWOJWnMsgAR3EIHWgszTvzqkKuzuks3dtJPLZH5q/lW3O+WCdCN07Kzg3cQ?=
 =?us-ascii?Q?uQ813R2fWRDJ/pWSKN/8dRaQ/G/F1boVLJiAuTJIcHGSEnu8Q2CKJA8DXKLX?=
 =?us-ascii?Q?rZG7rAZRk5qMZzm3Ou1ATS9qcGVUCIgu/sglPTORpfb6ltCmSHWLk2mjmvoW?=
 =?us-ascii?Q?NdjASILH6rWbxLLJglt96Zpdf2iL40hq6l+QUvGpDJDtkMKXvsUzfWgLHELH?=
 =?us-ascii?Q?VcjkAtY9lJLHnG1lHBkEiiFC/RBDjUIjqdHk+Q7vliIPfowhGWjmdAO9294m?=
 =?us-ascii?Q?az3Cc7mbMSfKpJ623ys6t+j9DkijkI3clxIhZnBH+oFpJ6EMz2METj7jUBbg?=
 =?us-ascii?Q?ZKB3jqtXd5FQaUy1hZZAkBDwCu+7Vj/ojJYtbm/l7t73H+zyJsMQrE7CPwur?=
 =?us-ascii?Q?7AujtpG4YxXXUlkMRinL4T78jszxgxkQnv1iuzIdNTovpBGdF+VyzNLwjYOJ?=
 =?us-ascii?Q?VVK6Vb3JQiX6tOSBPiisiODQjn9JxJo295AuTMIuplcdE8Nxq5kOMGl6c2DU?=
 =?us-ascii?Q?sNJOjM7DVCUDF+bmEFsAangtXjrvSUwRbdJYre7dErPCn36O3UDL3kvvgbj/?=
 =?us-ascii?Q?U9BuQu6fww9VIEYgCdIXXUg5DyMDrITb/e+u7Hezjwz37kRNMcs29PwgByfR?=
 =?us-ascii?Q?sabyFyagxZ7HqocSQ4JPxTjt58/DyMQCfocyM1d1op4es0Z0cu/ZkkhqwMpI?=
 =?us-ascii?Q?FiJQ4bDZALpZIBkfjyFZqZ1hN8I9dmXObNs5UYLNEjnFX5rPMjuGXF52y83Z?=
 =?us-ascii?Q?WfMrL6TLkggBBBZfGgzi04K9oMXIj03TfoXtLaowSqgwdSiiNDp9DG9cJ/ar?=
 =?us-ascii?Q?qRB0RPPS0k5XjivjGi4Z1to1/iAqyM1regMlPO9LzA5Atu41KnUkKEXvNDbm?=
 =?us-ascii?Q?hFv3wWnwe/FqQiWyOeTursptmaVikD5TNWIk6RA2posPwJT23+OzmPNPtS6v?=
 =?us-ascii?Q?Yndyfgs8J+8n1h9cky99HiRHJYZgjmcQetNKZe1MAXMd3+DWdTP9+nAVCsZ0?=
 =?us-ascii?Q?0sS4aTlChkuVz6Jp9bUsCDJxEci+qqcRVpvXdzUaFRUyV4UeM5Qb+OD/IEYV?=
 =?us-ascii?Q?LnO3cIHyaDB8W2sdPsX/v10flIpnwRi0GjSgTrB6pA5yOsIUU5+xJAGwx7/k?=
 =?us-ascii?Q?B/2ZAHeBMG1TeNyy+wyF9s3dpWA8UjHhZ1wCWRmP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5af785-20c5-40bd-b6f2-08dc4d4519a7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 03:30:36.0975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9fq9FoNuhNTdCz2jXLC3PXfkYo6N5N2o0iqxUxIdfU1pqDeYG55j6lRBDqqMAf5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7863
X-Mailman-Approved-At: Tue, 26 Mar 2024 11:21:12 +0100
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

Enable CONFIG_RTC_PCF2127 configs to support pcf2131.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v3:
1. Change CONFIG_RTC_PCF2131 into CONFIG_RTC_PCF2127 because the pcf2131
driver have been merged into the pcf2127.
---
 configs/imx93_11x11_evk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index 63613477c7..55e2673291 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -14,6 +14,7 @@ CONFIG_DEFAULT_DEVICE_TREE="imx93-11x11-evk"
 CONFIG_SPL_TEXT_BASE=0x2049A000
 CONFIG_TARGET_IMX93_11X11_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_RTC_PCF2127=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK=0x20519dd0
-- 
2.37.1

