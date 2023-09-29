Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1427BE728CF
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 18:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0D9986B95;
	Fri, 29 Sep 2023 20:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81606864CD; Fri, 29 Sep 2023 16:11:13 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04olkn0812.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::812])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B139686EEF
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 16:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFbDgk2MPVRX/6j1bUtkYAUYnMu2B/lotuNOiP+k/QXxpjcwL/Mwx+HmAkLqeGoGvmhJduubW0F5/GwWND2VlC1AhKmZykvQ2lBzqDywk4/RMwsF1ddwhj7M/6U3kBEkdLK29USrQGlZNeisXCDf2eK4UbZou0tP0wJTaxJErew3IzL1RI8kA1EYiaGTvjgi+2/eDeOdZ2Y3hudwzZLYugR2owttD+R3OvYnT3LTqeOgyBpYEdQSrSBSkPvIjPT6rtnQG2kjJEVKivSDJ2sCfud1H8YzMHGOq9Dvs98kV0IR7rH/veDm+RIRmUuK+tz1cRe1pvqFuu1dw4a+my5wmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQT5ZYhFZTZvbEnlnWho2IseH56ZhTyVrV6+T2gLm2U=;
 b=FmUgwm98+x7hxT87PWeEKAcZvgdkLK2xkoav/+vNVDN66k8j0JCHQjsOQaHGpcU8Vj9RZUc2QiPxyi+MthUOqbgA5v8IaVoRw+XuLsdCAundSx5voGrsaUrCuG2RZyjAc2RB5tf/Oj6WGSqibtyOjf9dXTiyMQ1ctnt/C+OALetjDNAUCv9mlVFihJpvEaEaSshWvT0RMljmtsoj2x8RfOf7jIH7umhpk0V95OoauZ4pktWta4W4QPjJXixyGmn2UqGngX3MRsE0KuiOx/mc6HxcZ4ygcJVmi7f6++uTwG9GdUTClpBiZJYHTZZlPmgFIJFZCrTFeFvCOpS3x8CV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM0P191MB0689.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:159::13)
 by AM9P191MB1240.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 14:11:10 +0000
Received: from AM0P191MB0689.EURP191.PROD.OUTLOOK.COM
 ([fe80::2014:b5d4:9539:9e21]) by AM0P191MB0689.EURP191.PROD.OUTLOOK.COM
 ([fe80::2014:b5d4:9539:9e21%3]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 14:11:10 +0000
From: Francois Berder <fberder@outlook.fr>
To: u-boot@lists.denx.de
Cc: lusus@denx.de,
	Francois Berder <fberder@outlook.fr>
Subject: [PATCH] board/km/cent2: Fix buffer overflow when fixing MAC address
Date: Fri, 29 Sep 2023 16:11:00 +0200
Message-ID: <AM0P191MB06891CA6155F4B995969E9E7DAC0A@AM0P191MB0689.EURP191.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [YITNX4QK/gSFtRgr3g7P0Pymcpu9NqOQBKLLOJ/t8qs=]
X-ClientProxiedBy: DU2PR04CA0286.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::21) To AM0P191MB0689.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:159::13)
X-Microsoft-Original-Message-ID: <20230929141100.19057-1-fberder@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0P191MB0689:EE_|AM9P191MB1240:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c956af-0a6c-484f-1321-08dbc0f5ee18
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CfEMkj5F7aU3369QCqPXCE6jXCf4w6jqhHiwcN2D8y9GWJjkBY+MpsMmApNKxNYybzdcgt+itQ+O4IwKCqLWNHvgjgggAu/rEneTD9z/PUOa+JzG6QTshrInfXU4P+KDydDPsicjy88l7/OJjQwjZ7TLF8x8VzU82clrLkzcdzXSMnI699eyFMOR8z0UotbvFXWT26vo4Mm894XhLvovmxJozIeRatROAZ3GVC04ZuChe747N9et1G0nUGGCZSV/TqfB+cAjZMYS82jl1C91Pls+4A6qaS9qUmVgULz9l5AAiAynD15zMPHBKsfmIhGWVF8g6kIFdzqWVPnqGR8g4VUv272bM8+2KWBg6pDDbjGoah++u9o+8FhAzslcTuMyTBhMMRLU3UfuTkaUnPXYQEzN6fdCl054oQsgFNhKxYddc+F60smqa81DA9idGR8U9tRoqd/FZYmSShwFzIwO7/l538O+DitTswtl/h8T3HkhV9cy2wzuLYkcZcpEZeW+/IO3A6o/ymsQNlmpbT6rcTF7qaagOdjHOpmt5i/kdHVvhayzYyVwUy0m69boV+/HBL6KXbHeCJRrwKCtBPQd5iyEalXxqIrXqAi/Sfp+N1SQX1ix14c/Ak8mD89dNCPS
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6909sv+AcXlpB5DTDHpwl6/KVawMhG52Hl9XdkGg8EthnaCSr+6PzPu8YO9A?=
 =?us-ascii?Q?fdecYsSdoaehAL4LYUhOX36UMd/ZZ0myMgIQGX+gB75Vzg3pr/yPueCdQdhT?=
 =?us-ascii?Q?TNj5GLlVi0hy5/Jsie/5IChyknl3YQ8QPQgM2lZSN0vsYY6ctKOiOeli0fdW?=
 =?us-ascii?Q?I38gqm9Z5DB3bUT7ZdjcpzO3y0/Cuz1JXd2A35pnmdnCgN1UMkRf9snXMYbu?=
 =?us-ascii?Q?fI0akZGUewaaqfzl6DtnPzLbNqlXBZn++IeZI+CYQOv5SoMni1ULzI6y97qU?=
 =?us-ascii?Q?5eZEKzzDn4zm4YY4+h/b9A/ftkiXf6kA3Ji9MHE2Tcku9evBBqESMow64prH?=
 =?us-ascii?Q?tmt5yG54U7hS8O5N3U8pUTQfWfRIFZI1w/P0DFNxqzLP1YzJnd0ToALhZ3vF?=
 =?us-ascii?Q?GNKtCgT8ssnGb450K5lut8ZEsEybwOfUnu0ggZ9ZGF7SKebjRPDojMtj1aRH?=
 =?us-ascii?Q?EOmJ5Mf4qpIOBfLpE75XmHSq6yqsVqu6sN9VvKobxClEEoJI4Y+RqVOPpthU?=
 =?us-ascii?Q?gjWsLN9CwTMh3SBkSXHDT3NSpdqOEHiYT3K392sGndHbl7mW7vcaoG2U5Z4d?=
 =?us-ascii?Q?5nAUqLbH1y5KLA+NsxfXSVmkS+JFoTI1yFURZ2X1suiqTzWjL4r+WGDph0Es?=
 =?us-ascii?Q?JHFb+bJNxDKBYKJwoUz6GE5JqN7hJ+VBrCgAhQ6kM8OsLJIOdVQLohMGPa+K?=
 =?us-ascii?Q?clIKJnjRddtj5Fifd9HnaXp/E1YEf2RRtqvk4T37aXH7Xgnt7jzmTi9gZav/?=
 =?us-ascii?Q?1BUrta6uiwS7mDZ8WO/hx7BiKDa85T3YmCyfhNScHJax6ijz9EWqHdHzjBrg?=
 =?us-ascii?Q?WqFUa6zCXvgFCjW+7kqepqomi+RupFosdlCSE2kxaZ17lsq0YOp4dDe5o/CO?=
 =?us-ascii?Q?4WF20uFxL7M0nyUQiZwk3u/O6VDrXzkwHSir7lXwR+dvkeNuoMOD0E1rV1Ms?=
 =?us-ascii?Q?3nzDVO0iJvbrqbDP9QGa/8yo5yr79nI+qVN2c8o3oVteDXIHb3vLnBLpHX+V?=
 =?us-ascii?Q?xpsI1PI/Ye0IfKjxocygovhYIbAdy14ekMl+sjzvICNOeuVmCwwEInOclQJF?=
 =?us-ascii?Q?XkadiLtrIMoKSixfd7XZpxEOw2IzdT0lcd0CIV7REC299ySIQNSf8hJL94j/?=
 =?us-ascii?Q?gHHME61ziuQdPUgoZSV0liDk+I0f6zWHuNHIaxtje789pQBBVUA72514Q0jb?=
 =?us-ascii?Q?0nuFS6bK4FKAs48ffA6RSqMdSTXFKPtvOJ/4eQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-50200.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c956af-0a6c-484f-1321-08dbc0f5ee18
X-MS-Exchange-CrossTenant-AuthSource: AM0P191MB0689.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 14:11:10.3859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P191MB1240
X-Mailman-Approved-At: Fri, 29 Sep 2023 20:35:40 +0200
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

String "/soc/fman/ethernet@e8000" is 25 bytes long
and not 24 due to extra byte for null character at
the end.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 board/keymile/kmcent2/kmcent2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/keymile/kmcent2/kmcent2.c b/board/keymile/kmcent2/kmcent2.c
index ed552c57b5..cd3a649c16 100644
--- a/board/keymile/kmcent2/kmcent2.c
+++ b/board/keymile/kmcent2/kmcent2.c
@@ -291,7 +291,7 @@ int last_stage_init(void)
 void fdt_fixup_fman_mac_addresses(void *blob)
 {
 	int node, ret;
-	char path[24];
+	char path[25];
 	unsigned char mac_addr[6];
 
 	/*
-- 
2.34.1

