Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DBDFC6160
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 08:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B386D83B6C;
	Sat,  3 Jan 2026 09:43:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="fNCs/3p3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55EDD83B8F; Sat,  3 Jan 2026 09:43:15 +0100 (CET)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E075B83B4E
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 09:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBLKtQ9+U46p8bB1ju0VPl5sDIgwtqzjxz+Si+cZtpCABhFbcbE5CGJtQmtrK7oUb42dwL4BuOq1JNJef3Dq05Y9u/INyGm/yWYQkZJ+8tW/rCJmXVQci2j6lzvdatTbHo/CRnMXvBIi5bq0DZtIs7ZKGYR1ApwkSzY8+Vz0S2vGdMfuQ8TdWDeX4q9aegzjCmSWaMJkdEuVogGnCXpJcuxPmQO44sxmuFo8w4uLOZ6/F4/UnPWnRlbPCYAj19A3JeOT7TSDuE1soSnL3GO6N50dN9iRP4yEPFM2LUEzNxPXSJV9WI9waZohss63kTKy+m/2/tx/lF9abK8Ivi6G1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTLC4/9/IS1SuS/N/f4yOaFGiGzZiafxlhqMxtojqEo=;
 b=b/fGg+u/Hv2enorLHB3YcbLtK8TMtGe/SZUTRlcfVFS5ZKJpdiu2XLk4kmci4v2fgj4a8eI4kHYN+RKyTeL40FqduiETehWlkDoeu8sUP9dx3GW6mmxTa4elmFc+IBSWNK0VQWvgFUF7SYARm5/n7Jt0oaqsa7dkCcNWe/dnmIsh2DCG9xQTygumkMYFnxBhzPukq1outYU4OqoxUgPGF/MvzKfpZt50BthNMQFwBwmwYpdNNOyH9pOrggH9PPWpLm7bpwF6mzwA5SVWfIrWcIejh2YovCS7jYg39R5rABvIx2FeY4aQBH3v2npKv5AiAfTkN3jQeX00bLMRIEEITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTLC4/9/IS1SuS/N/f4yOaFGiGzZiafxlhqMxtojqEo=;
 b=fNCs/3p3/cERLJv17yZdeZfiRmWiy90zSUof/RVsSXSpIADgM61YUKMXc9zsvBrnlAKMoJW7sA49zNev14bf6vI4v11OuhQjJEVbO+PPGLuj7RcNK6VTd4LLeptm7FFUUx5aU5t9iqXRnk6P5GrxX3w33y0+AkD8NbusgOVvdus/VK7XQzdUEsXLv448c7biB2RSPMK4Or7Mj0+aM8nHBARdPNnljuGMnPssg/oNqLynh2rj4x2zDK9Y5HuwaAOEOpuBPQzbAMOnW6lokv7c8XG/OIxvdiH4XguLDXf0EhwLzI/4nzBjiJ/vJvoeYtbhL/kUC1Xjk5z5g+xTJH9TNw==
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::14) by TY3PR01MB11642.jpnprd01.prod.outlook.com
 (2603:1096:400:370::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Sat, 3 Jan
 2026 08:43:08 +0000
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6]) by OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6%4]) with mapi id 15.20.9499.001; Sat, 3 Jan 2026
 08:43:08 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] pinctrl: mediatek: MT7981: fix GPIO9 register map
Date: Sat,  3 Jan 2026 16:42:39 +0800
Message-ID: <OS7PR01MB1383436D15128C22D7F9203D6BCB8A@OS7PR01MB13834.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To OS7PR01MB13834.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::14)
X-Microsoft-Original-Message-ID: <20260103084240.3142599-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13834:EE_|TY3PR01MB11642:EE_
X-MS-Office365-Filtering-Correlation-Id: bb20e377-3900-40a8-2fb8-08de4aa41e54
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|5072599009|23021999003|5062599005|8060799015|15080799012|461199028|3412199025|440099028|40105399003|52005399003|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B6Cm0VAMCM4C1BFJAvFYuFsbzYE3w7e8fGab4ivhZovXGw8DuGl3ErwaOxHn?=
 =?us-ascii?Q?W1G5fvfeYGOwt010uXDsifPE0kPTndyhFQgX5Exx5sH/1nxq6pOG3pvyOsVu?=
 =?us-ascii?Q?HDqt+Xa2nz9Xlo0jOrcAXdviYpZfXZzsOJGlBi6qv7W5qfXvGePXg9Aq9ZuE?=
 =?us-ascii?Q?pX/3nDH2kWET0sH3BsjAowZ0BHPXVHYrHFFRVzijHMomSMAvImer9FHL5Wlx?=
 =?us-ascii?Q?2kZ4KeaTntLENq1lNTTZccnNY58ksxoBEyrAozpKmwCgLdiQ9BXrv+2Pz33h?=
 =?us-ascii?Q?+EP9T5V9rZp3yo1q/CyHm7C6A9Ey9+3a+/LA14E5+1jBFtYxv2GI4/L/ZOCb?=
 =?us-ascii?Q?dE42V9/9YKFyUrImC0JWUTxfdt39zAatT6oRBuUh6oOhw9LNSwkRZSkrZ/bU?=
 =?us-ascii?Q?Jaycf9aTz9dTUbCQt/KLW+MPao7oeq3ZEqSZmzv5dvjGTpoRNSj13ZZGKbKG?=
 =?us-ascii?Q?T2zzhRJHCCtrcT8CSjKRHbNXUzC6wMsVUijTraFAs1Aiu8G4pskMcvGJ6/Hk?=
 =?us-ascii?Q?igyXMim2Pnv4WLAt/jmFsZ20nHT0qJrCVc8Kjpk4yN4iy5jzj7Y/MU3+k6Bw?=
 =?us-ascii?Q?cCHZk14Swc4pyg9CQecIMn4vtJY3/wNgfGsgfnJzjEaWlrTFNQba5H1yAh/1?=
 =?us-ascii?Q?cOdq/4XrLX32Pik9lHk9E2990t3NlEogWj5OtVxbKqO78zHa4T8yG+99QEPp?=
 =?us-ascii?Q?UpBIPMaCDPNlBlEpU2zi862n1lHKeyJ5Dw1NoY6VKOSJYzvlOBKYLTzn+uvh?=
 =?us-ascii?Q?cmzn/sSllJLTpghWeYO2Al9odyrVU8sBIlCEkVYL+BIyLvwJUhQjSFD4n8tQ?=
 =?us-ascii?Q?upZ4VaNASAW/bsvJg3jZN3++yZ2uAfeVnij8c4k8HLNzFsZcWs93bA3Y5GsT?=
 =?us-ascii?Q?2QglfEAY7HMDZrD535mfssO8zMdOlrnEV2v2JJTuw/k25C9Svs0G/DbQcQG9?=
 =?us-ascii?Q?7+KATMT4DbkzUu0qoluJ79s2PZ/maiRYbFFJ5l1/yQmwNtTLi6wcTA8k0m5B?=
 =?us-ascii?Q?Jlex3L4dx2+0jFRYcELKuSew4fDJRuZBu/WFbc9j17EHj6LFO9udBrhcD4/2?=
 =?us-ascii?Q?SBR84S1QUprnZJFYoDWbIytXvOGSFSlNudAtC/MG8/qqVqzjM2K/rCdQhdRu?=
 =?us-ascii?Q?+dXwQH7eULN2OWIRPK3cytcmlAYuQQp52KV1/opRNb5AeMpkfzVziggCYvk/?=
 =?us-ascii?Q?JBDx4qmP5PpFMMTb/s4KbHn0RmplCuHfOvCT3N2M21xfrGZgw5Qset3lgHk?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4MhM4jhSJwCKQ3CT32ssftaodtoPG9kkdaCN723cScuje6rl7C5pTQVSQQ2/?=
 =?us-ascii?Q?T60r62z/MvvMy3q0yeGqTaFhbo7rZNeJtBgcJgCp9reXKyusQjnavBEgejvW?=
 =?us-ascii?Q?aDpBuSw9eECVXQuP/7VLg19ea21XNildVa9XwyBvs+8ID64eKdE3q5PWE+GB?=
 =?us-ascii?Q?gd0cR4dMiJOwW8nyr40fNv9uw/SQlE6fBGtEmqqMPIKKVh48H63F7doEBNII?=
 =?us-ascii?Q?lPwAbZ02SyNX7wfV7wHyZDO48MGLCprxtd5xCDFXGx0BmrImJoTK33J3oEQW?=
 =?us-ascii?Q?Wl+0LNV7bcbSbXabQVU8efRpnuyUMRezQn3GTPZeBVa1/qiElI1MsIX2KnbO?=
 =?us-ascii?Q?1CCrvM5fvFm5bZS3AEmkC+JCLv3N21YYi5M9kR94p7PQnsN5Q7i7ikaBxofZ?=
 =?us-ascii?Q?dsPKVgq5DSscsy35vsKLzVgv1hxpd0eLJtuT6ogw2L0hoAP7ynp63vrZITiR?=
 =?us-ascii?Q?seUWsqATphSdkZaoTwoeGdYWIIf8i6vNVEPRNvO8Ha1Bi+5YboARWLFLUjuL?=
 =?us-ascii?Q?P6oAVY/YRS7wFxt1qtHn1AeU0KkGzV0TNgME/Nsscwj8yI0JCmjPJbpgDRwr?=
 =?us-ascii?Q?jGHH/47o5EMayvXLxl8e2QMF7nLiNoZDRaxmxKHQy3v/rQLBY2zM5WA/yMbs?=
 =?us-ascii?Q?SvjYb8CNIEbrPcJTk59srHriw4P88BpKk8QxseKGECCD6kRiXfFl+ltd6OM7?=
 =?us-ascii?Q?7fSyTrfw0AOGtF64SqV3Z8N22jMVPp/s4327QDXWMt5F9/qorJa9eRUfCHc9?=
 =?us-ascii?Q?hD4u3gRi/g8fW9LfpAeZqNVPA0rYe2VApBsxN6e1Gw+8RK3T8sQH+3txI9Xl?=
 =?us-ascii?Q?anx+YC0FK/p5PiQ8db/HTHg17SRx72XVMijZI8+M4RHLffqUYYJ4rIw23SwP?=
 =?us-ascii?Q?lUGjuDpdT8D3GT5LoT6kqyDdt3+lB8e94ZVJyF4iu/ZrHyOl9ETaAebLpOEo?=
 =?us-ascii?Q?jAd+QTVPo+uSXaquAHZIO3jDmtXXGK8tqPSPn2HoQ6Dg66Y9o1hlis69bJEc?=
 =?us-ascii?Q?wkgFmHhV9LFVTT86xzgG+MbTH1lmeB/VRQ4BVddCFAqrPTn9g/SL2SSnNC+v?=
 =?us-ascii?Q?1m/GMFlwHfRTVgW7KIWsw5p4smRjL4zFULH1t+grb8Fr5KbiXdX0dW0Yu2Zk?=
 =?us-ascii?Q?E9sOkzUBtM+rGGc2ArlCtCMHd/QIMWAQMrFBLGBrFTw8sNH2zkKnyPWj/XeA?=
 =?us-ascii?Q?q0goTqOyQZ4C84rdvB5BmKaUplXeTmpaAqar6+LWqddeZPh5/Qtny+kfQxYX?=
 =?us-ascii?Q?YqLlhInpdynibO9vYm+bLc9hwO1eTZXhwHFgzLX6iXEnhzKk3hqm3GfzVale?=
 =?us-ascii?Q?xocc1zarG6rPUQadj9RuhMvX2bh2KS4T3d//At6x1Ow8qg3hBi2lH5zzF2a4?=
 =?us-ascii?Q?CGI2SQQB13y72tzrHQO3vCEUlbbunOlvHFp1E4HY9bzqovYnMA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb20e377-3900-40a8-2fb8-08de4aa41e54
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13834.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 08:43:08.1663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11642
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

Ported from the Mediatek SDK. The upstream Linux kernel also has the
same register map as the SDK.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7981.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7981.c b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
index 6b9769067b0..13c3dc143cb 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7981.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
@@ -103,8 +103,8 @@ static const struct mtk_pin_field_calc mt7981_pin_ies_range[] = {
 	PIN_FIELD_BASE(6, 6, 4, 0x20, 0x10, 3, 1),
 	PIN_FIELD_BASE(7, 7, 4, 0x20, 0x10, 0, 1),
 	PIN_FIELD_BASE(8, 8, 4, 0x20, 0x10, 4, 1),
-	PIN_FIELD_BASE(9, 9, 4, 0x20, 0x10, 9, 1),
 
+	PIN_FIELD_BASE(9, 9, 5, 0x20, 0x10, 9, 1),
 	PIN_FIELD_BASE(10, 10, 5, 0x20, 0x10, 8, 1),
 	PIN_FIELD_BASE(11, 11, 5, 0x40, 0x10, 10, 1),
 	PIN_FIELD_BASE(12, 12, 5, 0x20, 0x10, 7, 1),
@@ -172,8 +172,8 @@ static const struct mtk_pin_field_calc mt7981_pin_smt_range[] = {
 	PIN_FIELD_BASE(6, 6, 4, 0x80, 0x10, 3, 1),
 	PIN_FIELD_BASE(7, 7, 4, 0x80, 0x10, 0, 1),
 	PIN_FIELD_BASE(8, 8, 4, 0x80, 0x10, 4, 1),
-	PIN_FIELD_BASE(9, 9, 4, 0x80, 0x10, 9, 1),
 
+	PIN_FIELD_BASE(9, 9, 5, 0x90, 0x10, 9, 1),
 	PIN_FIELD_BASE(10, 10, 5, 0x90, 0x10, 8, 1),
 	PIN_FIELD_BASE(11, 11, 5, 0x90, 0x10, 10, 1),
 	PIN_FIELD_BASE(12, 12, 5, 0x90, 0x10, 7, 1),
@@ -285,8 +285,8 @@ static const struct mtk_pin_field_calc mt7981_pin_drv_range[] = {
 	PIN_FIELD_BASE(6, 6, 4, 0x00, 0x10, 9, 3),
 	PIN_FIELD_BASE(7, 7, 4, 0x00, 0x10, 0, 3),
 	PIN_FIELD_BASE(8, 8, 4, 0x00, 0x10, 12, 3),
-	PIN_FIELD_BASE(9, 9, 4, 0x00, 0x10, 27, 3),
 
+	PIN_FIELD_BASE(9, 9, 5, 0x00, 0x10, 27, 3),
 	PIN_FIELD_BASE(10, 10, 5, 0x00, 0x10, 24, 3),
 	PIN_FIELD_BASE(11, 11, 5, 0x00, 0x10, 0, 3),
 	PIN_FIELD_BASE(12, 12, 5, 0x00, 0x10, 21, 3),
@@ -354,8 +354,8 @@ static const struct mtk_pin_field_calc mt7981_pin_pupd_range[] = {
 	PIN_FIELD_BASE(6, 6, 4, 0x30, 0x10, 3, 1),
 	PIN_FIELD_BASE(7, 7, 4, 0x30, 0x10, 0, 1),
 	PIN_FIELD_BASE(8, 8, 4, 0x30, 0x10, 4, 1),
-	PIN_FIELD_BASE(9, 9, 4, 0x30, 0x10, 9, 1),
 
+	PIN_FIELD_BASE(9, 9, 5, 0x30, 0x10, 9, 1),
 	PIN_FIELD_BASE(10, 10, 5, 0x30, 0x10, 8, 1),
 	PIN_FIELD_BASE(11, 11, 5, 0x30, 0x10, 10, 1),
 	PIN_FIELD_BASE(12, 12, 5, 0x30, 0x10, 7, 1),
@@ -404,8 +404,8 @@ static const struct mtk_pin_field_calc mt7981_pin_r0_range[] = {
 	PIN_FIELD_BASE(6, 6, 4, 0x40, 0x10, 3, 1),
 	PIN_FIELD_BASE(7, 7, 4, 0x40, 0x10, 0, 1),
 	PIN_FIELD_BASE(8, 8, 4, 0x40, 0x10, 4, 1),
-	PIN_FIELD_BASE(9, 9, 4, 0x40, 0x10, 9, 1),
 
+	PIN_FIELD_BASE(9, 9, 5, 0x40, 0x10, 9, 1),
 	PIN_FIELD_BASE(10, 10, 5, 0x40, 0x10, 8, 1),
 	PIN_FIELD_BASE(11, 11, 5, 0x40, 0x10, 10, 1),
 	PIN_FIELD_BASE(12, 12, 5, 0x40, 0x10, 7, 1),
@@ -454,8 +454,8 @@ static const struct mtk_pin_field_calc mt7981_pin_r1_range[] = {
 	PIN_FIELD_BASE(6, 6, 4, 0x50, 0x10, 3, 1),
 	PIN_FIELD_BASE(7, 7, 4, 0x50, 0x10, 0, 1),
 	PIN_FIELD_BASE(8, 8, 4, 0x50, 0x10, 4, 1),
-	PIN_FIELD_BASE(9, 9, 4, 0x50, 0x10, 9, 1),
 
+	PIN_FIELD_BASE(9, 9, 5, 0x50, 0x10, 9, 1),
 	PIN_FIELD_BASE(10, 10, 5, 0x50, 0x10, 8, 1),
 	PIN_FIELD_BASE(11, 11, 5, 0x50, 0x10, 10, 1),
 	PIN_FIELD_BASE(12, 12, 5, 0x50, 0x10, 7, 1),
-- 
2.51.0

