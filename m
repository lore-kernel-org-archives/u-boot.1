Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01A7C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4454980F18;
	Tue, 18 Feb 2025 13:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ak7c7NHf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABC8880F67; Tue, 18 Feb 2025 13:11:18 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C3DB807C0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5mVZUTGoVtPcNL3cnXWroWyasGXS/r24w2Jmb+FlXnY/lQ8cXKyFPCcElKG7uk0tM19IJh20wRYr1bKFzmSShI27hf97GIFx/Op0PD8JMovMMD08Kg4VWVYxB7FNlaDQWZkk50FBRB26pfEPH7kie441illzpfqtNhwFS2Y4m+gLwIxDHpNRh5tCnwmJEmSjhTFKazzjjnwEQOn+Evu9dz9tH8V9edGYN60hWmaYvIaRFJOEuHUpQsuw2kwr11HxzfDdgtmSEjKt2iL5yoLrciGmpSSR37a9OO8oaHnFLEu5ipwtl2eCPx8EdNB3++zouec/FenIPMm/+eLARq9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EvQu6BcbNc9FOAN1k28ucM5faIeteiMnCBPmKurFYc=;
 b=Tv93l9UUJynL6gWU3pBDkmrsbkewR0nYfUW4EEqsL/NhLIDOMe5XlNgDzrhC1JmKpHjuwOUi+FSSDSSWmGx+cKopdJQ41lAVzm4O+Ay2vrClyRF8XZQK4RNPhWTcJVzFJ5LQt1s4fC9a8+odHUFLRCmszgcWOH8f/NKAHKaxlAPhsfxMnTWve9XNlXcxGw9Hm6vpDBVCrs8F1yHWHiQvp5hthLWl+kPvCPErzmRg1Fqarm+xWEtIvNfvx2U0obrvKyijKvoWBf2VPkE9BJ4PzeHyTHjrcbM9xga6g71WhvL5Gzlyln3vy8ifNeBfnOuwK6jYWh7FMylmG0jyRk/hqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EvQu6BcbNc9FOAN1k28ucM5faIeteiMnCBPmKurFYc=;
 b=Ak7c7NHfSQb/v+2pL3Rh7ANurbL/A3CP2t0jxQ4JOCnvXnmofV79T0Nc9QWY/RYAmC3uIkNZCq8uhpQC8U1GpaGbA1NpJTUQqg2WCb2aJNTfKNKItNcmCA0TsCobAv0Wy4CNo9/VepsKwiZdjDve6hT38KNhPGfkkW4Ga3za0G843GdJq+irjT1ifI580mqBkBLjvqMH2tFzWefJKNOjlj4mFLrTJERChielsZsYa4FHhDFICumPogn06qNJcCV3KHc6Vti+kMQ7f92w78oQ+K7xY0dkHc4KrNAnfsE+7OQYGfoasCTHog1oG0H4d0xbNrune5J8KZddmX1CfvM5GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:11:14 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:11:14 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 16/20] tools: imx8image: add i.MX95 support
Date: Tue, 18 Feb 2025 20:05:53 +0800
Message-ID: <20250218120559.451678-17-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218120559.451678-1-alice.guo@oss.nxp.com>
References: <20250218120559.451678-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b1d3ed-804d-4f2b-6977-08dd5015573f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5IszX96bSa3DGVE8B6HjQVzVI4Pij7+shL3SXBvUSFv6wkQrvr5Okf8YNHKd?=
 =?us-ascii?Q?Ez4uBGwsT7Ky8B9APmz5gLs8iOMo/xD5ERSiK8HnD0O66r+QAwHEOWA4i81l?=
 =?us-ascii?Q?CATHUOax1YYiP84P8dhcYW+H1EesebOEnrQ0Zzdt72u0dwDXupr+Xk7NfP/0?=
 =?us-ascii?Q?f1DjWiTB+wEjKsYj236hy2Qlw5mYqbl4x4gCWfhNnIsMHVVcnIgRRxL79Kx4?=
 =?us-ascii?Q?jCRke4hWziF8/FEil7IdBd/du18Y5NLXlZKqziXOnyrdMdze79uGKz6Aa/at?=
 =?us-ascii?Q?tAPk9GedR62HC03vup/LIwKZDZ/SAg7YYIL7u7xcZhmkmA9cUZUpTnHFHPFg?=
 =?us-ascii?Q?RBlaqshL1PEADNL0554ifrEou7ABvJo/5KA1gQKVGIC0GBbUkjXxQKYX8smY?=
 =?us-ascii?Q?PvxgmhZSCbqUmjJi4g9q7HKq3vVxZOtfynGczbZieinFHoVlObYd2Dunxff3?=
 =?us-ascii?Q?FppjqGHpSbjfGh7b9NR7zrR32OhNYhGMyNO9ExClM9IzqABcTNKPdHr3zJxW?=
 =?us-ascii?Q?Tffg41iXznHBCfvEwA6zQB1+k0jkxRhcyp44Muo0mf3RjUFAHcLrjBiy4Vve?=
 =?us-ascii?Q?05E9ccUZ8sAMzI68da9nwLU3B8dQozkU2ztEum74Gf2wmrj184llRs+B97zx?=
 =?us-ascii?Q?9r9uiPnN6vEzZZk398b2Js9S4j0Ko+PjC9wdCwdDFwZmGMPbRYtcvaRciILz?=
 =?us-ascii?Q?3WaGEe/0iPsMXskgmDRKoSXkq4+szbUk8+juSW/Q7ZosJVkrodBJLu1xZJzk?=
 =?us-ascii?Q?LliWO3jtn+BxkLPTVcBEYG+SWQvv4iATcqk914lZLgpfKu6VjsHGibitxbb9?=
 =?us-ascii?Q?gFc9tLHmutUslBZ+tbTsakNDsWYteuEIOOFfsO4lRr70soZ0KlnJi9MYdd0x?=
 =?us-ascii?Q?Z7lok6j2xix/AYCqdbxF+a2E+pbHTSHzMDqEmAtZaRHs2mR+lGGVlTOSuXU/?=
 =?us-ascii?Q?J0hzOd3ay9Wga6t/yfjCWsbFH9p7HsJw7WNLNM8J85gBBKbHBFX/U1C/BnHJ?=
 =?us-ascii?Q?0810nhc/3UugJanIfTobeq82mnt6J1sxoQZbnwNSXks2savbbPePy7Z2IU5u?=
 =?us-ascii?Q?orEcCLrq/F0iaBZe8sXAXwmldt7ijsjMxoVgBzAxdifidaLZlt+8TC4rB9JC?=
 =?us-ascii?Q?N8ugeKIEWAwLQ/6BIVba58r31kzICYEMbXMvaswtXu4RayR4XT331S/iltpg?=
 =?us-ascii?Q?ooy3iTONAOSVsW7RQVH8qpq03cuWXbofMARxY2AADLiqQlLYPExEcPdAnuej?=
 =?us-ascii?Q?iunFDFuhMffoGNWfgzoe1Ld2XTPzluEYcoAybyGL8bffbbTnTfkEGKkyS0Ph?=
 =?us-ascii?Q?UOI3IQxFM63mgw6Iw9TvEb5yadI4GTqolU/ki/cwyzYxetrMihiDLs0w+VHC?=
 =?us-ascii?Q?GqySZ3CnUcCEMYPplBYiz/xKUMzwRc4Fnti1m3ZDOgMTouc+1Od8WOorOGc7?=
 =?us-ascii?Q?p/cvKoJ2UuSsOJ/bGPmxntFx6OfSmVAi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8xEVbVjcfpmmElmfSdWWqy4t4yUh16kZqhcdXQFqlMJK/QWJ98NKBAx6ysdM?=
 =?us-ascii?Q?AKEnxVXT05AeaXOBVNjx26sVaz04CR4vQiO0g9I8cUj3t85JwEiLWBKfL6Bs?=
 =?us-ascii?Q?/p+wbIzlSGGbQfsk1XIVm26+LUKzK+jYTQ2I7nFAt9Q3tK04P8hLR7O9nmrr?=
 =?us-ascii?Q?HajOd3cEBjoAN+qc5cSXfGENX3obnrNAK66WAtevkKheWGJPEtFDMoUx6cdY?=
 =?us-ascii?Q?AEuRGNxqLLTepgPjtU2W52IzPyFGl18XuM+fKigk2iOOZxPk8MCU+6sQPs5F?=
 =?us-ascii?Q?vjN8sUthAguGCeoBR5neNuwE6Wks+/U4nQZZ8c1s2fff5wXO/DuuZNkJeomC?=
 =?us-ascii?Q?e3ynB9aORI2K8c3hFAzW86l2ZaCASqwdtfeV2AkXvBr/TSDXfn5tuB7uN1Xm?=
 =?us-ascii?Q?6rAfd/tlMpsDrgpPhJr0ptM1mwio6iWYtOm8AlNS/9AoU4Z/Dn1rUXkKjLnb?=
 =?us-ascii?Q?l4crjCw/xj0VJIMnZQy9lR3Qhf6/hjnkE8fwSe5wgbNi5PL+DQYtvJTaIJsg?=
 =?us-ascii?Q?4iyJ9EYiRAwh/7CRujn2cR2e3lmjoQorNuycyfy3+t3+5ISvwqHZgAdmK27E?=
 =?us-ascii?Q?UHwC0G6Jlh3J6rL7mi1f2sntvbMEgD8YL6SE06vORE5SMi6WNMD9JLfcnjyN?=
 =?us-ascii?Q?1PNSvn61UHem//6AhGzVBlwCCE84hyWp7fQhDK6gL8idRfvRsTmvsToees8M?=
 =?us-ascii?Q?MjJJvOG2WqSsKqK9aXSZR1goEYDNLKTrgqkDuUsyIXF/JGVVLc4m5qb1jsL0?=
 =?us-ascii?Q?cePvVqMAh4MQDpI9kd10JUyMlK80KGUdN6I9M4BTBVgymsPI4HzR5ElQc+kc?=
 =?us-ascii?Q?Zk6J159wFs7KrXgV8gxSs6mWgxoPhLh4fzQu3oXjukSUlDgjp++TeODtqdv+?=
 =?us-ascii?Q?WV86byssM+qCG8rOj6Hi2mNDngQ6ZCJgaasdO+pzHmTLxZQBePjxm7SYTzLV?=
 =?us-ascii?Q?1O3hs3KSx9M5tquh6AshjvMyoVqqAObvD0Hlo+J+KVPo/47gvlqnWs86LVZK?=
 =?us-ascii?Q?6/TWSiItiBXU2Xz/Z/I6IDZkaFgrWvQW4G2hB3NIlBC35FlSjdpVJUjd9ULQ?=
 =?us-ascii?Q?dWuDs5qVAxUzfBOxhxyvQ11/0bWxehIDVDuv8RQi+c7jWauYhezDXN+traPm?=
 =?us-ascii?Q?UV0uWHhTmcyE+5Xg/EVC4Uoh6Wose8RfR/uyzOPUOSxxUGBl/F5ju9tfRsCV?=
 =?us-ascii?Q?zY6d9YMY5DiVjEcGBiFRmRl7rFXb4vUeHTv+OClWVeiuskN72UeyRmIlXSbr?=
 =?us-ascii?Q?77S+iZy78hOvYjlOoRXIhEKr05Q559e6J53KqgVV4sI5ZjfSalCmXHasjOoE?=
 =?us-ascii?Q?YWKZh8DEF5yLatdtABF6CZHEkar9NuSb+Lpp68LGkHNJqf7RUD0cshGHgmFP?=
 =?us-ascii?Q?bw/xEHoiNX5Q08fzymccQkwpa7XOL/OnLM/YLe3IY+QJ7I3LM8RVJ/h5+WIh?=
 =?us-ascii?Q?PyOEwiRugupatIE2Fy3J4IMz3FSTYbbxhVgMsSKSwzokNQdnv2ydVpAL2eQe?=
 =?us-ascii?Q?PObfCO9fdhCoToA+jTGsYUi85X3SBIg5+p9il6+bo5x8h2Zc4eJ5IZWOngqd?=
 =?us-ascii?Q?G2cTyCIjuEpxWmUh2gkfJC/ctY9+5za1kXCTReY+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b1d3ed-804d-4f2b-6977-08dd5015573f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:11:14.8144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BdhjSCz73eMCFdoYwkZviJ6ftjHQwSKusWr1uTM6VpD7/IrtQ8c7pa8TwnfQEOUGSnrRu6tQ9M7x8IcSf+W4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 uses binman to invoke mkimage to create image container. 2 image
containers are needed currently. The first one is composed of
ahab-container.img, LPDDR firmware images, OEI images, System Manager
image and u-boot-spl.bin. The second one is consisted of ARM Trusted
firmware and u-boot.bin.

Because DDR OEI image and LPDDR firmware images have to be packaged
together and named as m33-oei-ddrfw.bin by binman, so imx9_image.sh does
not check if m33-oei-ddrfw.bin exists.

When using "make imx95_19x19_evk_defconfig; make", imx9_image.sh will
delete the line for u-boot.bin in container.cfg. In fact, binman is
always called after the u-boot.bin is built, so imx9_image.sh does not
check if u-boot.bin exists.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/imx8image.h |  19 +++++-
 tools/imx8image.c   | 143 +++++++++++++++++++++++++++++++++++++++-----
 tools/imx9_image.sh |   8 +++
 3 files changed, 153 insertions(+), 17 deletions(-)

diff --git a/include/imx8image.h b/include/imx8image.h
index 6b95e93fb50..b48e2b03969 100644
--- a/include/imx8image.h
+++ b/include/imx8image.h
@@ -157,7 +157,9 @@ enum imx8image_cmd {
 	CMD_SOC_TYPE,
 	CMD_CONTAINER,
 	CMD_IMAGE,
-	CMD_DATA
+	CMD_DATA,
+	CMD_DUMMY_V2X,
+	CMD_HOLD
 };
 
 enum imx8image_core_type {
@@ -169,7 +171,9 @@ enum imx8image_core_type {
 	CFG_A35,
 	CFG_A55,
 	CFG_A53,
-	CFG_A72
+	CFG_A72,
+	CFG_M33,
+	CFG_OEI
 };
 
 enum imx8image_fld_types {
@@ -208,7 +212,10 @@ typedef enum option_type {
 	FILEOFF,
 	MSG_BLOCK,
 	SENTINEL,
-	UPOWER
+	UPOWER,
+	OEI,
+	DUMMY_V2X,
+	HOLD
 } option_type_t;
 
 typedef struct {
@@ -227,12 +234,16 @@ typedef struct {
 #define CORE_CA35       4
 #define CORE_CA72       5
 #define CORE_SECO       6
+#define CORE_M33        7
 
 #define CORE_ULP_CM33		0x1
 #define CORE_ULP_CA35		0x2
 #define CORE_ULP_UPOWER 	0x4
 #define CORE_ULP_SENTINEL 	0x6
 
+#define CORE_IMX95_M33P		0
+#define CORE_IMX95_A55C0	2
+
 #define SC_R_OTP	357U
 #define SC_R_DEBUG	354U
 #define SC_R_ROM_0	236U
@@ -246,10 +257,12 @@ typedef struct {
 #define IMG_TYPE_EXEC    0x03   /* Executable image type */
 #define IMG_TYPE_DATA    0x04   /* Data image type */
 #define IMG_TYPE_DCD_DDR 0x05   /* DCD/DDR image type */
+#define IMG_TYPE_OEI     0x05   /* Optional Executable image type */
 #define IMG_TYPE_SECO    0x06   /* SECO image type */
 #define IMG_TYPE_SENTINEL 0x06	/* SENTINEL image type */
 #define IMG_TYPE_PROV    0x07   /* Provisioning image type */
 #define IMG_TYPE_DEK     0x08   /* DEK validation type */
+#define IMG_TYPE_V2X_DUMMY 0x0E /* V2X Dummy image */
 
 #define IMG_TYPE_SHIFT   0
 #define IMG_TYPE_MASK    0x1f
diff --git a/tools/imx8image.c b/tools/imx8image.c
index 15510d3e712..9c4b4317455 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -7,6 +7,7 @@
 
 #include "imx8image.h"
 #include <image.h>
+#include <linux/sizes.h>
 
 static int p_idx;
 static int sector_size;
@@ -54,6 +55,8 @@ static table_entry_t imx8image_cmds[] = {
 	{CMD_CONTAINER,         "CONTAINER",            "new container",      },
 	{CMD_IMAGE,             "IMAGE",                "new image",          },
 	{CMD_DATA,              "DATA",                 "new data",           },
+	{CMD_DUMMY_V2X,         "DUMMY_V2X",            "v2x",                },
+	{CMD_HOLD,              "HOLD",                 "hold",               },
 	{-1,                    "",                     "",	              },
 };
 
@@ -66,6 +69,8 @@ static table_entry_t imx8image_core_entries[] = {
 	{CFG_A55,	"A55",			"A55 core",	},
 	{CFG_A53,	"A53",			"A53 core",	},
 	{CFG_A72,	"A72",			"A72 core",	},
+	{CFG_OEI,	"OEI",			"OEI", },
+	{CFG_M33,	"M33",			"M33 core", },
 	{-1,		"",			"",		},
 };
 
@@ -144,6 +149,14 @@ static void parse_cfg_cmd(image_t *param_stack, int32_t cmd, char *token,
 			exit(EXIT_FAILURE);
 		}
 		break;
+	case CMD_DUMMY_V2X:
+		param_stack[p_idx].option = DUMMY_V2X;
+		param_stack[p_idx++].entry = (uint32_t)strtoll(token, NULL, 0);
+		break;
+	case CMD_HOLD:
+		param_stack[p_idx].option = HOLD;
+		param_stack[p_idx].entry = (uint32_t)strtoll(token, NULL, 0);
+		param_stack[p_idx++].filename = NULL;
 	default:
 		break;
 	}
@@ -221,6 +234,16 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 				(*cmd == CMD_DATA) ? DATA : AP;
 			param_stack[p_idx].filename = token;
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].option = OEI;
+			param_stack[p_idx].filename = token;
+			param_stack[p_idx].ext = CORE_CM4_0;
+			break;
+		case CFG_M33:
+			param_stack[p_idx].option = M40;
+			param_stack[p_idx].ext = 0;
+			param_stack[p_idx].filename = token;
+			break;
 		}
 		break;
 	case CFG_LOAD_ADDR:
@@ -238,9 +261,15 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 		case CFG_A53:
 		case CFG_A55:
 		case CFG_A72:
+		case CFG_M33:
 			param_stack[p_idx++].entry =
 				(uint32_t)strtoll(token, NULL, 0);
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].dst = (uint32_t)strtoll(token, NULL, 0);
+			param_stack[p_idx].entry = param_stack[p_idx].dst + 1;
+			p_idx++;
+			break;
 		}
 	default:
 		break;
@@ -548,6 +577,7 @@ static void set_image_array_entry(flash_header_v3_t *container,
 				  char *tmp_filename, bool dcd_skip)
 {
 	uint64_t entry = image_stack->entry;
+	uint64_t dst = image_stack->dst;
 	uint64_t core = image_stack->ext;
 	uint32_t meta;
 	char *tmp_name = "";
@@ -557,7 +587,9 @@ static void set_image_array_entry(flash_header_v3_t *container,
 	img->offset = offset;  /* Is re-adjusted later */
 	img->size = size;
 
-	set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	if (type != DUMMY_V2X) {
+		set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	}
 
 	switch (type) {
 	case SECO:
@@ -579,6 +611,27 @@ static void set_image_array_entry(flash_header_v3_t *container,
 		img->dst = 0xe4000000; /* S400 IRAM base */
 		img->entry = 0xe4000000;
 		break;
+	case OEI:
+		if (soc != IMX9) {
+			fprintf(stderr, "Error: invalid core id: %" PRIi64 "\n", core);
+			exit(EXIT_FAILURE);
+		}
+
+		img->hab_flags |= IMG_TYPE_OEI;
+		if (core == CORE_CM4_0) {
+			img->hab_flags |= CORE_ULP_CM33 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_M33P;
+
+		} else {
+			img->hab_flags |= CORE_ULP_CA35 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_A55C0;
+		}
+		tmp_name = "OEI";
+		img->dst = (dst ? dst : entry);
+		img->entry = entry;
+		img->meta = meta;
+		custom_partition = 0;
+		break;
 	case AP:
 		if (soc == QX && core == CORE_CA35) {
 			meta = IMAGE_A35_DEFAULT_META(custom_partition);
@@ -586,8 +639,10 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			meta = IMAGE_A53_DEFAULT_META(custom_partition);
 		} else if (soc == QM && core == CORE_CA72) {
 			meta = IMAGE_A72_DEFAULT_META(custom_partition);
-		} else if (((soc == ULP) || (soc == IMX9)) && core == CORE_CA35) {
+		} else if ((soc == ULP) && core == CORE_CA35) {
 			meta = 0;
+		} else if ((soc == IMX9) && core == CORE_CA35) {
+			meta = CORE_IMX95_A55C0;
 		} else {
 			fprintf(stderr,
 				"Error: invalid AP core id: %" PRIu64 "\n",
@@ -686,6 +741,15 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			img->entry = 0x28300200;
 		}
 		break;
+	case DUMMY_V2X:
+		img->hab_flags |= IMG_TYPE_V2X_DUMMY;
+		img->hab_flags |= CORE_SC << BOOT_IMG_FLAGS_CORE_SHIFT;
+		tmp_name = "V2X Dummy";
+		set_image_hash(img, "/dev/null", IMAGE_HASH_ALGO_DEFAULT);
+		img->dst = entry;
+		img->entry = entry;
+		img->size = 0; /* dummy image has no size */
+		break;
 	default:
 		fprintf(stderr, "unrecognized image type (%d)\n", type);
 		exit(EXIT_FAILURE);
@@ -708,15 +772,26 @@ void set_container(flash_header_v3_t *container,  uint16_t sw_version,
 	fprintf(stdout, "container flags: 0x%x\n", container->flags);
 }
 
-static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
+static int get_container_image_start_pos(image_t *image_stack, uint32_t align, uint32_t *v2x)
 {
 	image_t *img_sp = image_stack;
 	/*8K total container header*/
 	int file_off = CONTAINER_IMAGE_ARRAY_START_OFFSET;
 	FILE *fd = NULL;
-	flash_header_v3_t header;
+	flash_header_v3_t *header;
+	flash_header_v3_t *header2;
+	void *p;
 	int ret;
 
+	p = calloc(1, SZ_4K);
+	if (!p) {
+		fprintf(stderr, "Fail to alloc 4K memory\n");
+		exit(EXIT_FAILURE);
+	}
+
+	header = p;
+	header2 = p + FIRST_CONTAINER_HEADER_LENGTH;
+
 	while (img_sp->option != NO_IMG) {
 		if (img_sp->option == APPEND) {
 			fd = fopen(img_sp->filename, "r");
@@ -725,7 +800,7 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 				exit(EXIT_FAILURE);
 			}
 
-			ret = fread(&header, sizeof(header), 1, fd);
+			ret = fread(header, SZ_4K, 1, fd);
 			if (ret != 1) {
 				printf("Failure Read header %d\n", ret);
 				exit(EXIT_FAILURE);
@@ -733,19 +808,27 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 
 			fclose(fd);
 
-			if (header.tag != IVT_HEADER_TAG_B0) {
-				fprintf(stderr, "header tag mismatched file %s\n", img_sp->filename);
+			if (header->tag != IVT_HEADER_TAG_B0) {
+				fprintf(stderr, "header tag mismatched \n");
 				exit(EXIT_FAILURE);
 			} else {
-				file_off +=
-					header.img[header.num_images - 1].size;
-				file_off = ALIGN(file_off, align);
+				if (header2->tag != IVT_HEADER_TAG_B0) {
+					file_off += header->img[header->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+				} else {
+					file_off = header2->img[header2->num_images - 1].offset + FIRST_CONTAINER_HEADER_LENGTH;
+					file_off += header2->img[header2->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+					fprintf(stderr, "Has 2nd container %x\n", file_off);
+					*v2x = true;
+				}
 			}
 		}
 
 		img_sp++;
 	}
 
+	free(p);
 	return file_off;
 }
 
@@ -837,6 +920,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	char *tmp_filename = NULL;
 	uint32_t size = 0;
 	uint32_t file_padding = 0;
+	uint32_t v2x = false;
 	int ret;
 
 	int container = -1;
@@ -860,7 +944,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	set_imx_hdr_v3(&imx_header, 0);
 	set_imx_hdr_v3(&imx_header, 1);
 
-	file_off = get_container_image_start_pos(image_stack, sector_size);
+	file_off = get_container_image_start_pos(image_stack, sector_size, &v2x);
 	fprintf(stdout, "container image offset (aligned):%x\n", file_off);
 
 	/* step through image stack and generate the header */
@@ -869,6 +953,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	/* stop once we reach null terminator */
 	while (img_sp->option != NO_IMG) {
 		switch (img_sp->option) {
+		case OEI:
 		case AP:
 		case M40:
 		case M41:
@@ -891,6 +976,30 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 			file_off += ALIGN(sbuf.st_size, sector_size);
 			break;
 
+		case DUMMY_V2X:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			tmp_filename = "dummy";
+			set_image_array_entry(&imx_header.fhdr[container],
+						soc,
+						img_sp,
+						file_off,
+						0,
+						tmp_filename,
+						dcd_skip);
+			img_sp->src = file_off;
+			break;
+
+		case HOLD:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			file_off += ALIGN(img_sp->entry, sector_size);
+			break;
+
 		case SECO:
 		case SENTINEL:
 			if (container < 0) {
@@ -962,11 +1071,15 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	do {
 		if (img_sp->option == APPEND) {
 			copy_file(ofd, img_sp->filename, 0, 0);
-			file_padding += FIRST_CONTAINER_HEADER_LENGTH;
+			if (v2x)
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH * 2;
+			else
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH;
 		}
 		img_sp++;
 	} while (img_sp->option != NO_IMG);
 
+	fprintf(stderr, "%s: %x %d\n", __func__, file_padding, v2x);
 	/* Add padding or skip appended container */
 	ret = lseek(ofd, file_padding, SEEK_SET);
 	if (ret < 0) {
@@ -979,6 +1092,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		/* Note: Image offset are not contained in the image */
 		tmp = flatten_container_header(&imx_header, container + 1,
 					       &size, file_padding);
+		fprintf(stderr, "error writing image hdr %x\n", size);
 		/* Write image header */
 		if (write(ofd, tmp, size) != size) {
 			fprintf(stderr, "error writing image hdr\n");
@@ -999,7 +1113,8 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		    img_sp->option == AP || img_sp->option == DATA ||
 		    img_sp->option == SCD || img_sp->option == SCFW ||
 		    img_sp->option == SECO || img_sp->option == MSG_BLOCK ||
-		    img_sp->option == UPOWER || img_sp->option == SENTINEL) {
+		    img_sp->option == UPOWER || img_sp->option == SENTINEL ||
+		    img_sp->option == OEI) {
 			copy_file_aligned(ofd, img_sp->filename, img_sp->src,
 					  sector_size);
 		}
@@ -1030,7 +1145,7 @@ int imx8image_copy_image(int outfd, struct image_tool_params *mparams)
 	fprintf(stdout, "CONTAINER SW VERSION:\t0x%04x\n", sw_version);
 
 	build_container(soc, sector_size, emmc_fastboot,
-			img_sp, dcd_skip, fuse_version, sw_version, outfd);
+			img_sp, false, fuse_version, sw_version, outfd);
 
 	return 0;
 }
diff --git a/tools/imx9_image.sh b/tools/imx9_image.sh
index ca78a57a19a..6523d1a0ad1 100755
--- a/tools/imx9_image.sh
+++ b/tools/imx9_image.sh
@@ -18,6 +18,14 @@ for f in $blobs; do
 		continue
 	fi
 
+	if [ $f = "m33-oei-ddrfw.bin" ]; then
+		continue
+	fi
+
+	if [ $f = "u-boot.bin" ]; then
+		continue
+	fi
+
 	if [ ! -f $tmp ]; then
 		echo "WARNING '$tmp' not found, resulting binary may be not-functional" >&2
 
-- 
2.43.0

