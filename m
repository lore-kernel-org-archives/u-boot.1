Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBDEE82CA1
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 15:31:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B76D286DF9;
	Wed, 27 Sep 2023 17:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="okmsEQrF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1E1586E20; Wed, 27 Sep 2023 17:31:11 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77BDA86DD6
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 17:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=laurentiu.tudor@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEWn6QKBcrniHRMfWViy6EQeQNISrIysWEeo5PMXubgoD9b5Eb57DQPnPjW36PVtbqtBOI05AHLmUKKP+z0H1yyoMGns4R+w3YxD+0IiHfbpki3CJWlrB9Fo0zrA91Dau/UT2xmqJjTZglr148ZU1lYFoAgfflHfDfXQUdWxlcIrwAj/oCr/Dd1rOts/6sQzcygn5RHHkbE+wcW0POl8uFodsl9RR6T0hMwNJTE+EHOIIc4srZbZdXs3JdNhW8fLdcGB7b/aF65bt5v+tUHvRzskZONhUdYbHqd2iZ1hHyMb4qa8TnccrRZ5ZGU1lRb1uW328MCqdigtxkq5Zbjcxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/K33TvjnX5QQRBONenuD3dr+x9nkeWHVRLdJZKXag8=;
 b=AzP6TT1IrTs/INe0GvrS24LT91w8Qb+Osx3gouWE75BZlw1d9kEl1d+AYoXvMbVHl+bHYKMdGMVIfX2+Yln6yCcpuOfBQ1vz39aEgEHqUmcChlWZuvK8xFc7w7yKxTjvwuEYaqxQTiMaqimTqA9Q4kEZrv8wqf3EwQRv4qO9Bmub8jnfLllZJJ5KzM+1uNAUYY+oIfVuXGMniXUdtuL+da6ZZiogo9Jp/RZ5PrsmkLu++9JyWe39suHN4sWQAYJCicWoeiTK7A+ZdcyLpso6/Sn3TehvlJ0IkyKaA6IXfsOB2y/DyBUbsEwsBYUfeU7e2Lpi2dRxf+Liy3YcczHPXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/K33TvjnX5QQRBONenuD3dr+x9nkeWHVRLdJZKXag8=;
 b=okmsEQrFuwP+rlUnmSHbDiuHfcqRVDIf1t93orhJ4elFN6lOtMP5ZyaEHNdd3YM7sIv1OwnBfsxxHsdVouZ1yQOkwCsnzED/SgXNktWuvy0XQv5LNCe1/wqLVNM44vpqDFckPv7gqiPdWWrSX+VyS2LBAeo3TobxKDJ8QFLSPbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 15:31:07 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::425a:a4a9:17b3:cfe4]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::425a:a4a9:17b3:cfe4%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 15:31:07 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: priyanka.jain@nxp.com, wasim.khan@nxp.com, meenakshi.aggarwal@nxp.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, peng.fan@nxp.com,
 sjg@chromium.org, sean.anderson@seco.com, ioana.ciornei@nxp.com,
 u-boot@lists.denx.de
Cc: robin.murphy@arm.com, thierry.reding@gmail.com, jon@solid-run.com,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 3/4] board: freescale: ls2080a: declare MC reserved regions
Date: Wed, 27 Sep 2023 18:30:48 +0300
Message-Id: <20230927153049.12786-4-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230927153049.12786-1-laurentiu.tudor@nxp.com>
References: <20230927153049.12786-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0175.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::12) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|PAXPR04MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 160c8314-8ef8-4498-6973-08dbbf6ec4e6
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8IIKe8Jie1KeaghsW6KSVlqDX55m7gauxPCcN9otc3797KeqJwcxHjaNAWi/VUpmnY9xANw005Ht6QznGmnTnH7MYk+1LkSB+i8Kk4YcNJFXtfsyboUnn+ljX4dR1+UN2CILDK4gepDoJx0CaSfLDjpnMXMCApJTSq3fZAYvowhNLYgC5oS/qR4zdaaW457G8J68vP9I+gho+yGfYEC5XUjTM19OchpqcbzV+a0CLtTqlJ+pGzTOe2DvJyRIFb4u4DyB37iWLmGazBNYZbE025krfrIvygh2ZdFmJ1fpASYRf+gzQVB1/HZjYHL19FqUczYvflm9QL6JsaLdL75j1pYijuPMhj4IQHbJpBxRYJ4ReQVvcZGEvv1uyNlimeGKv9iDM3RcD5WFiygkK0LZle6sG/TiZSZbAFgqcNGnEmfUkMrfedURjPXv1ERlthAzFUIC7iAO8NySK0HmuMlrCprwgJbITGTbyCToDeWkac/efoODqRPLs94JAKS+WyS2X8DkmGnqKZY6a2jo0kM3OmanWc6k5XdpsConmNpY7bIr9XQeFTEnzhV4pQHkbsRtoJ52/gHzK7tHMNjp7+/xhjsmQTsVOkldhHlAhdY7CK0+bap2+xFIf1i80Deo5q8VZ+Ni5We4jNWFQec4hBqvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9380.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(186009)(1800799009)(451199024)(26005)(6506007)(66556008)(6486002)(2616005)(66476007)(52116002)(1076003)(86362001)(6512007)(66946007)(6666004)(478600001)(38350700002)(38100700002)(2906002)(5660300002)(921005)(44832011)(8936002)(8676002)(36756003)(4326008)(316002)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X60+XG7OCxbBWoMwmWUIRaF7tcg3IOdD+mvEKM4UijFTd4pyZIf5kkYsTuHD?=
 =?us-ascii?Q?bFYRTM8ecudFil0PZDaLvFm6btS/twlbmp9CQIQ2JzGFI4J5OLdooIzs3R0p?=
 =?us-ascii?Q?iI8C1YGH/m1pa3J90ssV1zqKP7QAKt7a1t3i3rQyF+/podAsFBBahU5rDteL?=
 =?us-ascii?Q?ZWYT/oXQ6XYTz+r3uC95qd+TxsVCw92zGv+J+O02tBJ+TeN1t5McwIi8n12/?=
 =?us-ascii?Q?MXM3rjzUPjcjUqX+3PiDsjPeFL0I8xErDUDHv42S7GW9cab4IAO20k0IjgSL?=
 =?us-ascii?Q?FwagJ4lkiIYpo0JSk5C4ynMuuDuAdz+doc9zkLtIJujNdo3GeDJ31IxI4Ftv?=
 =?us-ascii?Q?4jnk8VcEVh4Yp9GXLAqCNNiBojmZAcadzpaPSq4gFm3TtvAZFSvi/zAxJeBo?=
 =?us-ascii?Q?AGuZ3UhHnHSHTTRhk9VjnlzzKX23/v01ei9b5jDCOnPCtMQRzQ9kjR+NfDsM?=
 =?us-ascii?Q?je2FGrb7ZsV/ojX2g77C3fRP21yMO2Q+LTQRgjCvJ6BM7uw1Jk22dV+PSQRD?=
 =?us-ascii?Q?MOWRtwOLaACTAvNwx8vU6kHLlJYbdLM+dEcH7BohK/U1aIhS/3zkjnYbbslS?=
 =?us-ascii?Q?gWbN9BBZtXJMkV1b15y+caV89J4EnW1fs0Rl4KxsB3TO49bran2oKw7JqsWm?=
 =?us-ascii?Q?Vf1Nni6//COyVjVR+YDuKNt4ZgIBk7MK2eo6oMnGja2g80UYXhGgwaVxzNhm?=
 =?us-ascii?Q?svkne6nE9Yt327Rar5ttZygwuwppHXWI+dknsfhgt5rfoqZNnbsWMekG2VtI?=
 =?us-ascii?Q?QlhEHQRrXYbz4kY1C8gvm3BCJZv5dr26VwO7wtexNWXKs2Gx56LVpDGJz2N0?=
 =?us-ascii?Q?sSaF4njgt8gBuRyo8R+5kZYpDStZbzNuEFSiWRwXT5iCnDM7GXu5bSwodHiv?=
 =?us-ascii?Q?scbMTGf6JRyMPGQDaiSHQzDPA23YgYsoOV4JWvZW//hWPRY2w/ZDyi/8ocOT?=
 =?us-ascii?Q?iums/nqKedZbRAz/L9t1+oEcfXLiWWeWzSnYJTfA3WywXLMEgodTKfu0EfM3?=
 =?us-ascii?Q?GSVAH6Sqz4mXG0/G8PEWnDBrngOj4fs2iHMkCzePrXMhsO29DzfQCSdXAXg1?=
 =?us-ascii?Q?I2oaoOxTU5UwidP6J+I5DrEvMWfk0AaWVT8fBKVFHenMdgXvWqfC5u8FTIb7?=
 =?us-ascii?Q?gO1WqDkFpD6k6Wq6iJSqLRrosRlKcVf7WHXLx96+27sZPyTkdjJevC2mZj4k?=
 =?us-ascii?Q?inGDQmk3SdVHiZb8HJ+ozfUd1wLo0kTwmDvot8d+7qVW+laSdQ+cpj0bgXxf?=
 =?us-ascii?Q?iwlzj7X+X9I9d1A9xsFa2frDoHKBmmsXLoGp4YIDS9v+GL+6FmjP9J8Mbua2?=
 =?us-ascii?Q?BVrzVLTYl2y3He/pGRZz/gbwSE4nZjKodb8Onate3vzSaczVaVjfNwNxVpd/?=
 =?us-ascii?Q?nsuOh/tJ615ltLE3Mvvks3d+zCzYMzLupS52EgtxL4E7KHZ8UjWFVMl7pzYl?=
 =?us-ascii?Q?bWQB6plRALXid12AelUJbIuJotrdzOap1DkDvRc5M3/dKk9adhuaPBHMZxk8?=
 =?us-ascii?Q?xpKuIH0Cp4PydpUQKsbxp2RBYusqq0puj+xpOLKMgjbyFzqJmTIPGhHgEnyk?=
 =?us-ascii?Q?Q/eIF3KRxJ2vyW1atAPLYNe/vXLxRAXAIvbXIn9X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160c8314-8ef8-4498-6973-08dbbf6ec4e6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:31:07.5391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1OlK/cCOjtwLRUBOmiL/DcYAemQ0oBjOfLBoyB6qCUNP7WFXeUa9Gw4/YIswQiJ3/IXGR27lF9U7gMJlX+L1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720
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

Populate the device tree with the MC reserved memory regions.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 board/freescale/ls2080aqds/ls2080aqds.c | 1 +
 board/freescale/ls2080ardb/ls2080ardb.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/board/freescale/ls2080aqds/ls2080aqds.c b/board/freescale/ls2080aqds/ls2080aqds.c
index ba25e9b0b8fc..5c94c83121b5 100644
--- a/board/freescale/ls2080aqds/ls2080aqds.c
+++ b/board/freescale/ls2080aqds/ls2080aqds.c
@@ -325,6 +325,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 #if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_SPL_BUILD)
 	fdt_fixup_board_enet(blob);
+	fdt_reserve_mc_mem(blob, 0x300);
 #endif
 
 	fdt_fixup_icid(blob);
diff --git a/board/freescale/ls2080ardb/ls2080ardb.c b/board/freescale/ls2080ardb/ls2080ardb.c
index 8d340f17a256..5c30de83d841 100644
--- a/board/freescale/ls2080ardb/ls2080ardb.c
+++ b/board/freescale/ls2080ardb/ls2080ardb.c
@@ -522,6 +522,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 #ifdef CONFIG_FSL_MC_ENET
 	fdt_fixup_board_enet(blob);
+	fdt_reserve_mc_mem(blob, 0x300);
 #endif
 
 	fdt_fixup_icid(blob);
-- 
2.17.1

