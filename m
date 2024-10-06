Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76654CFB43C
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 23:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0E2E88CD9;
	Sun,  6 Oct 2024 01:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vDr05hjm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 726D488D5B; Sun,  6 Oct 2024 01:26:35 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DD8788CC1
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 01:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvHcxpdwFYPzsrYSm/luqdZPhMfiXJq6/2NvJs0kKJOy53ExUaSp5oQQKNAbEUjlvY1zzhlRUXgprIC0dFS+SK2KVH8BOxt4MPCKlmdIl4CmOFLqibuFpZWKA/tBgzDq5s9J8TW52mfqO5Ym/crWqLIyJeY9i6JPF9qqEGfSwk+cyOEXceuefyabYBBd0phOt2uJ+Hq1XMfZ/WaYMznkqYrv7M8i0lAo2wCL5//q6qodxQq0NbmKAnzX/CLWqTaSS4xoV/kVhtleo9mjzFl+UlAFcODyOih7gIBzy5aNGe8X7sjOuR0lWCfbR75Eyo/V72fjFLJrunJQLQ5e2XnWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLZo9B4ArB21pGVH/AbDI8dqBYR58B4dgKDf9IdaC8I=;
 b=U5Z5z4iuP3t1h5nUHZ/M28KUR3SfJnAhlF+R8osINJ2uAAdMkSqBWczIETyzu4tH33O9OaCTAWuq5kRQOeCPnULjgDXzbKqxzPIFPLyWkUH3iUWrxNW5jrPyu4Tn5h562+4Fw6MJ5eAcIn+2AmdBMJ9HaDHG+MWh8VcOkk8TdOVBp4awoBWiiaLrMjvahfh5xp1mZawJvCWnHkXYOnv/mqqRzWni1Sz9R1A4jrtsYjxxADeAj/F81oR7k7J3BJcQnJQyFAkmV7vv/THInadLxu/cd4vpL6F7Tf6YqYrc1gvEFZwlbZF4bMDTJ71uBG536zeoMja/l5U79j/YtzvPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLZo9B4ArB21pGVH/AbDI8dqBYR58B4dgKDf9IdaC8I=;
 b=vDr05hjmOZ3Q/KgM3FYRZsLotttGffVxXYbWGKYnhC/74nmlwTb06V0pXxBpbQJUiM57woN9p8sZ8F/tTSXPeVFZShGJKzDDdiO0yAuPps59/Z2OnCCKdMeT6WSM2w9+QRhaF+g4Eukkc1kLGEyOgTJjbpJSSGeI/ZNhlNWfYN8mcW/IqS71FW4CTFpxFkQow3SCKKlFHRSNYNUtgJbYq4/yhsdakDJFI8EM1ZMD1pF1cF9+Kf4ApXwRWnhnaMLBcaB5mYV5RWRJQfMBJGINyaiVO+hmogojr3+rjea4f9DTMD9VTSqxHs9KQfywd5hLwusGYvGmRfIUHmldQLfb6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9217.eurprd04.prod.outlook.com (2603:10a6:102:232::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Sat, 5 Oct
 2024 23:26:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 23:26:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com,
	Ye Li <ye.li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/4] misc: fuse: Update fuse driver
Date: Sun,  6 Oct 2024 08:30:05 +0800
Message-Id: <20241006003006.20162-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241006003006.20162-1-peng.fan@oss.nxp.com>
References: <20241006003006.20162-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: cf091429-b9a7-4491-05d2-08dce595251c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I9XmHWc6h7QKCuEXIW/h7pUijh5mejcefae1hZaceBhKJ2PjAD6Zv37NKQyJ?=
 =?us-ascii?Q?RXcsgjEomGMOYhZFWNxH6zn1p4UmyUnys5qaUFXLmvECJ+kBkhm5mjlHjXqq?=
 =?us-ascii?Q?/eeYwwWC3/mSEKMRMsYsC7itzDHRQ0nDEZ5W9ouz3v51CfYBA0vJxOAjpAsk?=
 =?us-ascii?Q?AGYOyPV/wgTzq3lXHI28+HCKOw0/Echk150AWQ6hswys9xX0+wCk3zhhnZ6E?=
 =?us-ascii?Q?yECF5AZojd9M5TugVeTAL7oyD/k4N8IsRYRBDADxqBowp84er1EC90MeMht6?=
 =?us-ascii?Q?unOTwYN3K6LskUilc9fkGK2Go9FhW3rIwuCpYIc3TbbDaSEJv09E54gKxsxT?=
 =?us-ascii?Q?Dm33caqA+UU8jrccnnQIfJfj0h1J793vuPe+8Ouu9NCEZw82iatc18EuUwqK?=
 =?us-ascii?Q?/Y+EzqtEEcxsKlKtANo0kxV6T1VH76BHxxYUwg6i1+FwHrBzpSobwS7kUxF/?=
 =?us-ascii?Q?xWqwmO2KFBhn/jb0RCFT0DrcS8XpIRs6mQYXiAZpt/KxiOHMcnaeSa6pWY1D?=
 =?us-ascii?Q?/RNBz+nr/2COm22lr3pkx/rhPKGYpxkuSB8Y5ovXJFinxR1blCgaJGWvexwM?=
 =?us-ascii?Q?G5mowE/6/VKPr1CexOglFBvqhiiEL9TLDAaotben2o8Bzd61+7y1UOqqMXHE?=
 =?us-ascii?Q?7HHrVxYh68PjoosdJcV1ehsIrrm0KneGEvrpq5W/Ifr1cMA8aKubI7/VGbVV?=
 =?us-ascii?Q?yCfOxH37/ruVxGPxMrivLaBJc/03LvaTQKoKMN8Ms67i2Zcg18vdUN0Tz4rF?=
 =?us-ascii?Q?rq1c6/EgoluzmNoGktvXvN5t4bJRIMAjdOI38znnhDvvS+ur9x8fwzJ5USu3?=
 =?us-ascii?Q?5kji+24YrW2XX00DsgmXOTZfcoDdmXFv5xFZU2capUAx6Ebsx69Mv7T7BiCY?=
 =?us-ascii?Q?BIvYbveIJikLNr3Wj3m7Hc5dRMFGf8eVCUQeMHq6v+8sSMz+1OQMwi8iaPhP?=
 =?us-ascii?Q?+97BOpBEE2focy3Jcp6aAMF3PoANLtzYVihmye1+EIwIYrUGqBJiX3Dnz3yL?=
 =?us-ascii?Q?fXj6CaMVf8HYoeztws121cQwJV8CMzitdZIUBPZHDmYTACuqV0JG543+rAzm?=
 =?us-ascii?Q?NX3MU08mNUhMJ/UApNAPaSmuatw2MZU18b6/KwNgsd1DTdHbxT29heiMN6UJ?=
 =?us-ascii?Q?1JTDjN+W6Hqh3nY4fZrDOlFi4epgWONDBbZ4w7rHOUQ2pOHw3qRs6mIlsrki?=
 =?us-ascii?Q?P/vD9xiSwvw1/QgOeBdiNZfkKy+VA0c/0FD6JI7fA/0ca+THVzy14W4Qs0ow?=
 =?us-ascii?Q?/F/MpqBRRrJb5fHN1MOZteeZookLHhY9+5+yG3xqaKTEeSoEpmWFmUOjgIn4?=
 =?us-ascii?Q?cIf6vQx8Ipb6sFkBQgXwNpeoTATD2iQbA+HMNX13zXBnsw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?21RGNkuyGYqI0Pj/duPKGrrlOUicfDIxXSIUTKoH7gkkGxXXLKmqZdc5ZEtq?=
 =?us-ascii?Q?r30sSxZJ50kHW0rxcAMXoE3Pc9X7M/OC9rUFIgbPBKya8zlhR7cC+tbGA29r?=
 =?us-ascii?Q?IyZI2W1FgA0SrUib9ZPL3p4Tr3j4rwq9AkEbaDxhgp10eQWr8SO1VtqJ9ign?=
 =?us-ascii?Q?U0WanvetYHEeOWu/HBQh+SBYIqf5cmV8EzbOMqQhQyNfwtctyJalidvQvjsJ?=
 =?us-ascii?Q?tngV0VaNw8uHvdRwgsKGgAj7HlACWdB4ygAxCEt/tPTmzn/IzAKzFm0iVtQq?=
 =?us-ascii?Q?4wn4CJtU2MacGe1OFz5wqEVk7MNYN44S16wwsDgDEqOCJFzdijhySmJq045R?=
 =?us-ascii?Q?pMAIsNwRucG11mD5tOdJzEpcAk+C2CUEmPXsUQrh/nhvy+ZvYYBSVZs2tBix?=
 =?us-ascii?Q?EVrI/45HLud/7IkoEELyhuEW4x2zSOyFvoR5OgDxF9g+IhDGNbX4g6s6As3u?=
 =?us-ascii?Q?Am7TuET26HXkUgH1DLNNsOz0i0P5O6HjG7hSAMfXjJorPvDymD58uwqS7n2t?=
 =?us-ascii?Q?0Jza7hKKzii2/RJIdtQxelxbSgIRjv9hMcFg2vY1WKq/SUQoV3z9yH7fg59R?=
 =?us-ascii?Q?47d4tjJRyLCbkBYyK2kyUKUolRuP+m0SiymbjvmK2LKfJM8LjlBJ1fyC1QnO?=
 =?us-ascii?Q?B9xpwrUeoFJQosJSwp/8n929GmVtp6r8PixJnutYDh+fIL/MtyvPIv1fLPlQ?=
 =?us-ascii?Q?i+czHat8JzjdTHjp5oEC1qlMpOT9aMLu1xpOjpYV/tE/3B+bDPNMSNIbv8yq?=
 =?us-ascii?Q?IKOZavdruAm4tLqk1z6LkCcSWyA+1pVpP5dxfnFDJ0jelOze6woOHFjUv90e?=
 =?us-ascii?Q?Lijx7JtKWyqTuGJNbP1wobRqtTUfHTWhcsT+4JE0r8bL9cJRKKc5IjSv1LKG?=
 =?us-ascii?Q?hu+Y8tWvGPRfUpceOP6ATjES+nokEhm5RiC8pstal4YCExPiIQnRi1TKByZL?=
 =?us-ascii?Q?pGU0I5eCLmfV77/If/9L5PQaPrflFzXWC3IkFHDjZH30jbKa3ggndXh69UOS?=
 =?us-ascii?Q?TYBeZrCZD489Sf6kTMxN1RWukmMxq2qY5D57PYVxvfmdAujdzr5c3A0V1fGc?=
 =?us-ascii?Q?ro4sSsvVtr6ygUkJXBoWSnFkhZuV5pVANXtSnA/GJrNU21TE1/OQt3CKkqfv?=
 =?us-ascii?Q?/h1DFFK3Ght39pKIZspK74SOIR8e2Oy8JsienOu2z0Fc0y70lVsDguWOs0nd?=
 =?us-ascii?Q?yuhX4amkT3NVsOBzQcEf4Tmi1P+5HmUQ/rIDicmFcu1C/fKADupfm7xa8b3o?=
 =?us-ascii?Q?kCXYOG298Ie+JeOyM7nwrcae0e5UYOF+TO6aPPnZwjgYSlwT6Zq4kWjO6b1T?=
 =?us-ascii?Q?BjcxM/M1ywYcLEzBPz2KCktmJBF5FNTq8zEfYfQakIzuBr3Ukn4SOyUfcAjY?=
 =?us-ascii?Q?iY1X5kVrqjrOpS8gqD18amMTyFBobiU2edNYsGf+tVARsrlgkmAMJ1Zzxb93?=
 =?us-ascii?Q?rbbMFA24khQmsgaQsD7EwFLqbc4BtNq4lt11MeiV8+yvo97G/h+JNTX2Xdnl?=
 =?us-ascii?Q?AKphgL0BfRncxtdu4TzELtmAjb44+KElz4Cu1LNsESWApUvGgtaHoqGYJZxF?=
 =?us-ascii?Q?iVxvRPevmnYQojXBiOc9vuoVeM+GAUajvZTfbCcb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf091429-b9a7-4491-05d2-08dce595251c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 23:26:31.7583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kjp+UpRHFhWHwGbfFaVgpP3tUz3eMGrH7bNsCgrOyyupq+Xp+S3tMgnZC3CqSrZueU7Kohbo/oaaUqhIy/08tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9217
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

From: Ye Li <ye.li@nxp.com>

When OSCCA is enabled, FSB fuse shadow (offset 0x8000)
access is disabled for SOC. So update the driver to read fuse
from ELE API. The ELE has supported to read all shadow fuses like
FSB, reuse the table of FSB for the word index used by ELE API.

Add ELE shadow fuse read and write to current ELE fuse driver.
But when LC is OEM closed, the ELE read/write shadow fuse APIs are
forbidden. Reading from any fuse will return error. This causes
problem to u-boot which must read out some fuse no matter whatever LC.
So we have to change back to read from FSB and ELE common fuse read API.
For using ELE shadow read API for development purpose like checking
the ELE shadow fuse write result, user can set env variable
"enable_ele_shd" to y to switch it.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/misc/imx_ele/fuse.c | 97 ++++++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 24 deletions(-)

diff --git a/drivers/misc/imx_ele/fuse.c b/drivers/misc/imx_ele/fuse.c
index 47880d8aeea..c1e7434dbf3 100644
--- a/drivers/misc/imx_ele/fuse.c
+++ b/drivers/misc/imx_ele/fuse.c
@@ -11,10 +11,10 @@
 #include <env.h>
 #include <asm/mach-imx/ele_api.h>
 #include <asm/global_data.h>
+#include <env.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#define FUSE_BANKS	64
 #define WORDS_PER_BANKS 8
 
 struct fsb_map_entry {
@@ -32,6 +32,7 @@ struct ele_map_entry {
 
 #if defined(CONFIG_IMX8ULP)
 #define FSB_OTP_SHADOW	0x800
+#define IS_FSB_ALLOWED (true)
 
 struct fsb_map_entry fsb_mapping_table[] = {
 	{ 3, 8 },
@@ -84,6 +85,8 @@ struct ele_map_entry ele_api_mapping_table[] = {
 };
 #elif defined(CONFIG_ARCH_IMX9)
 #define FSB_OTP_SHADOW	0x8000
+#define IS_FSB_ALLOWED (!IS_ENABLED(CONFIG_SCMI_FIRMWARE) && \
+	!(readl(BLK_CTRL_NS_ANOMIX_BASE_ADDR + 0x28) & BIT(0)))
 
 struct fsb_map_entry fsb_mapping_table[] = {
 	{ 0, 8 },
@@ -191,20 +194,10 @@ static s32 map_ele_fuse_index(u32 bank, u32 word)
 int fuse_sense(u32 bank, u32 word, u32 *val)
 {
 	s32 word_index;
-	bool redundancy;
 
-	if (bank >= FUSE_BANKS || word >= WORDS_PER_BANKS || !val)
+	if (word >= WORDS_PER_BANKS || !val)
 		return -EINVAL;
 
-	word_index = map_fsb_fuse_index(bank, word, &redundancy);
-	if (word_index >= 0) {
-		*val = readl((ulong)FSB_BASE_ADDR + FSB_OTP_SHADOW + (word_index << 2));
-		if (redundancy)
-			*val = (*val >> ((word % 2) * 16)) & 0xFFFF;
-
-		return 0;
-	}
-
 	word_index = map_ele_fuse_index(bank, word);
 	if (word_index >= 0) {
 		u32 data[4];
@@ -240,25 +233,26 @@ int fuse_sense(u32 bank, u32 word, u32 *val)
 
 	return -ENOENT;
 }
+
 #elif defined(CONFIG_ARCH_IMX9)
 int fuse_sense(u32 bank, u32 word, u32 *val)
 {
 	s32 word_index;
 	bool redundancy;
 
-	if (bank >= FUSE_BANKS || word >= WORDS_PER_BANKS || !val)
+	if (word >= WORDS_PER_BANKS || !val)
 		return -EINVAL;
 
-	word_index = map_fsb_fuse_index(bank, word, &redundancy);
-	if (word_index >= 0) {
-		*val = readl((ulong)FSB_BASE_ADDR + FSB_OTP_SHADOW + (word_index << 2));
-		if (redundancy)
-			*val = (*val >> ((word % 2) * 16)) & 0xFFFF;
+	if (!IS_ENABLED(CONFIG_SCMI_FIRMWARE)) {
+		word_index = map_fsb_fuse_index(bank, word, &redundancy);
 
-		return 0;
+		/* ELE read common fuse API supports all FSB fuse. */
+		if (word_index < 0)
+			word_index = map_ele_fuse_index(bank, word);
+	} else {
+		word_index = bank * 8 + word;
 	}
 
-	word_index = map_ele_fuse_index(bank, word);
 	if (word_index >= 0) {
 		u32 data;
 		u32 res = 0, size = 1;
@@ -279,18 +273,62 @@ int fuse_sense(u32 bank, u32 word, u32 *val)
 }
 #endif
 
-int fuse_read(u32 bank, u32 word, u32 *val)
+static int fuse_read_default(u32 bank, u32 word, u32 *val)
 {
+	s32 word_index;
+	bool redundancy;
+
+	if (IS_FSB_ALLOWED) {
+		word_index = map_fsb_fuse_index(bank, word, &redundancy);
+		if (word_index >= 0) {
+			*val = readl((ulong)FSB_BASE_ADDR + FSB_OTP_SHADOW + (word_index << 2));
+			if (redundancy)
+				*val = (*val >> ((word % 2) * 16)) & 0xFFFF;
+
+			return 0;
+		}
+	}
+
 	return fuse_sense(bank, word, val);
 }
 
+static int fuse_read_ele_shd(u32 bank, u32 word, u32 *val)
+{
+	u32 res = 0;
+	int ret;
+	struct udevice *dev = gd->arch.ele_dev;
+
+	if (!dev)
+		return -ENODEV;
+
+	ret = ele_read_shadow_fuse((bank * 8 + word), val, &res);
+	if (ret) {
+		printf("ele read shadow fuse failed %d, 0x%x\n", ret, res);
+		return ret;
+	}
+
+	return 0;
+}
+
+int fuse_read(u32 bank, u32 word, u32 *val)
+{
+	if (word >= WORDS_PER_BANKS || !val)
+		return -EINVAL;
+
+	if (!IS_ENABLED(CONFIG_SPL_BUILD) &&
+	    env_get_yesno("enable_ele_shd") == 1)
+		return fuse_read_ele_shd(bank, word, val);
+	else
+		return fuse_read_default(bank, word, val);
+}
+
 int fuse_prog(u32 bank, u32 word, u32 val)
 {
 	u32 res = 0;
 	int ret;
 	bool lock = false;
 
-	if (bank >= FUSE_BANKS || word >= WORDS_PER_BANKS || !val)
+	if (word >= WORDS_PER_BANKS || !val)
 		return -EINVAL;
 
 	/* Lock 8ULP ECC fuse word, so second programming will return failure.
@@ -318,6 +356,17 @@ int fuse_prog(u32 bank, u32 word, u32 val)
 
 int fuse_override(u32 bank, u32 word, u32 val)
 {
-	printf("Override fuse to i.MX8ULP in u-boot is forbidden\n");
-	return -EPERM;
+	u32 res = 0;
+	int ret;
+
+	if (word >= WORDS_PER_BANKS || !val)
+		return -EINVAL;
+
+	ret = ele_write_shadow_fuse((bank * 8 + word), val, &res);
+	if (ret) {
+		printf("ahab write shadow fuse failed %d, 0x%x\n", ret, res);
+		return ret;
+	}
+
+	return 0;
 }
-- 
2.35.3

