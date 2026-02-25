Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA282FD45F1
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 21:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1ACE8366F;
	Wed, 25 Feb 2026 22:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="aD+jBAlS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEF6983AA9; Wed, 25 Feb 2026 22:13:54 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE78782A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 22:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=han.xu@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLGCY+At2VDWKalbYIXmhyAQ7KnxAiLXMyd5uYELe2K1iAjMa9O45uPTgCpUiz2sRYchMybOdf+EdqykRru+ejyg/foewTGAyMrNj5U20qbTY4SLzlWtruLF3Ml4P7Ny0dxUezBVEzRXHPf8iY/+6Oy6gstH0A4EMHHQSz6LyjrSBpap/4/hace4OfJm8Wlh6UXEg+nVRizuhPjNPL5IdS06w90ZsP7HW8AMGrljjSHqL99UTbPeSTbuuq4fzWwZSSwEmn9MZCtNjoYzuIbCeoT7u84Vdog9Fz9ADsIDbnu+NfWNqQHcYvt6Q4+/Z4yqYU5Gz6goEqP9jXSbOoO9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yppBI/0rATmKpRrOt5zcYp9gtSyrjE2bB2Hl/kOpAAY=;
 b=EvAWwab8NNKXHWXXbeaPEXJpIarnWK+E8Ge7RS+LK5QK5FrXSMADV9ik1IegFpK/T0MOMLzNbHZD48kWRw/jBBap/sM9mh0vRkfM3ZzVhVz6aTRAZHd9+ar0aZj9AVAsZPLZNbHW4IA/1OQBqKXrYBLMES8RStMVIA9bZ6HxNZig21Vklbzt1RpS94SMEKJdehaMgBXlzthXBSHMNzrRmR6fKnoxC3l2TvrV8r7K68hn+s/rhk/ea2+8o6oefGrqCRhyOa6yZRnyDyfFei4EPIsGtpl068c3/SfiTJ9cY3a+TwIjGQZYVi96YxAdBSRM6uB9SUEQxfWqqg9dN+If5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yppBI/0rATmKpRrOt5zcYp9gtSyrjE2bB2Hl/kOpAAY=;
 b=aD+jBAlS0p5SJCVXW55VEWi3Xp4kHrzN9JIZ3pYiw5TPi3p71wumFnlGuwdAhAdRIHpFU6uP1ZgmieCSN5Z/yujF/1XSbKxVOu90AVXQRdKjrfJ3tXXtlaQSCXeaGQiEscCicq9BGbdW4I9Qv33h5IPf6YM76Cw88gVOEwzdXO4UdqymWBJG9TN4VVfDelo0dNjjR4ftfSNnLozlFRTWRIyFDnfhhy2ulNEzCaH/CnxyowvUE+f1g+1V1HtWfYLwilA5s+YuOR1FBQ79gHiciOddkLoUQG5dKFwBJideSUvIB7AQ4/kCk7svZmxikxAAhBYagN1fo5fO7czh9+uBfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by DB8PR04MB6955.eurprd04.prod.outlook.com (2603:10a6:10:11d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 21:13:51 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::7010:9f6:4361:43bf]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::7010:9f6:4361:43bf%4]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 21:13:50 +0000
From: Han Xu <han.xu@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: Han Xu <han.xu@nxp.com>,
	u-boot@lists.denx.de
Subject: [PATCH] mmc: Add support for eMMC 5.1B specification
Date: Wed, 25 Feb 2026 15:13:32 -0600
Message-Id: <20260225211332.1896252-1-han.xu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:806:121::19) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|DB8PR04MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a73f1b1-e5e1-4666-13ba-08de74b2c5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|19092799006|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: NzSlKT2cJeBCMBf/qRMIYp19uh+3vviBNUp/WETjsxc6ROAISUx2JT2ZAZivitDxwx1ljoOhqE8NyOiPqe3O/KcF+UOJv3AEpPSqk4wy17Hk/dvMtd6qWfehX/T4uJtEg1YbnlqRbJIbP3MvYT5OnatkeTLa06/a11EZQblPCo8ErHB51JmqEBexypbqdLyNTDxRSnCEYzX+J6sOQky8KMgabUmEnXvzFfXNi0kkjBwIRlSR5yVQJ28pTYa7X0zVSaSVvCSm53wPy6Y5qJ2FCZq10WhTCwW9fKV+VSjONpOqsDcUZF2/r3IuuulxKbp0Z/YUlq8VOx6YtpXbX89fkCy+K/OHFLsrxAK9TryMHvGa56jbPLrwo2+2cYhKnHLFZMQNxojDIPG56s1jPcYWwwpcIi3+tA14qnzKs5iLlNjQv3Lzb5nyfnE0Rmdw+MPl5eUq55/JFTqCL///2pr0aY9ugYgIphVF8k6cZQDHCfXgjLk+oSoyqMtM54zB41WyG/MPbslvxXgbSBbD0o5lYMTvlRj+agXSVwMX7jx735TInn2q7bgObQLCqfrSikW0Y8m6CF6pBsgyzTKBYCI6e+icouRqblirE7ys9rg33iDZZKxhHNuDMAJHe++uxG6sxbMKunUIc8NMeIvzU1WoKWyvjuErZMIetGuSMgHqnXAJhs/V2AI0hz2Yve3y+wZFBUXu06u7JMOh5HYTgrQ7bS3MCDzMiOqRIjy9i433J3ZfsuVnxmEr2SNC4yWIZpic2sO+Fs3h/l9RP7BYJPQPCB+zjYeJOtFsepcNB9/M4Oc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9071.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oeecpdHN5ddcZWTf6gdBZT7R+YmvJG+RVO82m4fpKuYCwqbbM6bKGvLTPN6M?=
 =?us-ascii?Q?o24BdY7l7n4Zhj9szCRsgUTjA//3pG8cKG6ItpadH6gDgP1dRCuCVahGiB2w?=
 =?us-ascii?Q?3lkQmq9oA16smpv7OhpXMco4TQiiA6P/9wT4hPsyJJHemypRQ8dSlVsd5UBQ?=
 =?us-ascii?Q?Dyr+5QZzdLCe9YVRXYKd8Qf8J/St54UtMLxyX/76ihj6FB3wp7IRJGPh+NcO?=
 =?us-ascii?Q?Ovv2+T4uMzWkjVPxPcOJnPikufUJIW1sg0rKgzIkhReyWrsowGm4zQGJb3gy?=
 =?us-ascii?Q?gLlQ3KkqguenqZgG8K1iCJa8devnCoki4qEdxJc9h4QuFB26TTKr/2dEjRrL?=
 =?us-ascii?Q?fHC2qIhkFdnG2f2KH6bXkjyjAU2CYTYTiWaGqeIANo/SCPUZGdC5+MeTlU9Z?=
 =?us-ascii?Q?Ji9myNJaCDYhppiFafo5e8eSLv6UNf4wOthGyM5wCPiyhK6nmTNGydDzp3yQ?=
 =?us-ascii?Q?FL+hz5YoQEXz8o014KnDxFaEtj7fjVf4Slfnb2qVcfTLh71CPJCBuR4jR2UR?=
 =?us-ascii?Q?PNX24ofXU92/oHJf2a1RtnNGzT6v29lBqRzuiiS+na8RPbUwi1rtBflcQUz+?=
 =?us-ascii?Q?N1Ujqnn6zU+Si1Mwggvnawa3VMr4PEZIFxyNjphoHOOTKoGBTDZvpYeIwBBT?=
 =?us-ascii?Q?odOdp+9Q+EshTI+p1SYiERjb+S1SXKtxrWXtj4PsoMQ9DtxuUjzA63PYEh6L?=
 =?us-ascii?Q?xuo4Vl9eAoSAKjolLdlvsASRhqjMNGCTN4mXGjRihc2PszrdWTrNgPFuqLJd?=
 =?us-ascii?Q?MW4UMtlQ5/q08CvpPqSDMAgd8Bu1gypwkeRfPC6z43GuApRQ0nzFC/kSn4Wh?=
 =?us-ascii?Q?dwVcmeex3sfLLOy3Shc+eABO4NrLWqe/ZI6iUXWyGDwq4MGFSNJOvU9MQUqX?=
 =?us-ascii?Q?TaSa8BNO3L1wVgN9QDGPEeqV/qLm1/pMFB12q6EspavbA2xsFuOkCmtddo7+?=
 =?us-ascii?Q?gU4lIrEMRKcXWaWTh6IJcH/09Pl8H75zSCHUV7BppSknY2vY9Ben813lZ48q?=
 =?us-ascii?Q?jZIT5HZwxzm7AKhj69SHFarQZujDbWy5jbarFMD+Ia7oDXh1JyEqRH7617dO?=
 =?us-ascii?Q?f9fVAe2wOsLzk+eHj2P5cLSHA+oUTAlJk63Z1i/ze1vzm/58ZMo/nProJqi9?=
 =?us-ascii?Q?EpVsTUF5fOJUQLpBRROVHXc3JV5svPO4gwznSykhNRcbkUwH1cI9JQL50m7x?=
 =?us-ascii?Q?3kpUJ5Pvq1MuhZiVRKLlbT8x9//8nsENgxLhr2UAUZHX1cZd3pMH3sWhhY3c?=
 =?us-ascii?Q?WsZrzEsp+EHn0pNHxpDefYSb90MeunHnAbFicwif3aZrizdLNDoBc2C5zdYd?=
 =?us-ascii?Q?d7p0iGKYDM4vV7Lu4Q5APyp6S67Ee+xTYL54zAGsvJJ/MFygt37V4VlPdnjz?=
 =?us-ascii?Q?9Yw0fNSouzvL8sMgdNAg7YB4J1ZG3oZg24HxZDfAA0WNTW9WFOZqYGwPMZbj?=
 =?us-ascii?Q?H36qaw0Yr29zsg8mgaF7HaG1r2Yc98+IMNTP6wsgogIXiO/j5fJ9rAl3FGBB?=
 =?us-ascii?Q?WVsEBh5B8EG/LEZPGG/XVeJjIEUMmbuq4UeBW7OVxmm09fNDNzQGDmyGaJF/?=
 =?us-ascii?Q?W+3d7ncAPjYwGsbUs1m1AVfrXrlELoEHhPBkJBd9Ve333SnoWrt22Ii9Xx3K?=
 =?us-ascii?Q?V/OoUxjzVzDinX7MRBqv7H+em2W2P4yd3HPMxU/UgQgHk3BfmwV5DNBCsJeH?=
 =?us-ascii?Q?9+/AFFEC0Y3JUeVbPwDgSp1bwOO9tq6/bp6GIQWBSCG8n01B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a73f1b1-e5e1-4666-13ba-08de74b2c5eb
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:13:50.8560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wXI6C187BW4n+HrdeY26mWNZonU06WH0yBCDkyTq2gv8dEOrEH0GigayIGPTnlt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6955
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

Add support for eMMC specification version 5.1B by defining
MMC_VERSION_5_1B and including it in the version array.

eMMC 5.1B (JESD84-B51B) is a minor revision of the 5.1 specification
that primarily addresses MDT (Manufacturing Date) adjustment for dates
beyond 2025. This aligns with the Linux kernel commit 9996707822f82
("mmc: core: Adjust MDT beyond 2025").

Since the manufacturing date field is not currently used in U-Boot,
this change has no functional impact beyond proper device recognition.
It allows the driver to correctly identify and initialize eMMC devices
that report version 5.1B in their Extended CSD register.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/mmc/mmc.c | 3 ++-
 include/mmc.h     | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index c5705f4f215..f0e38efb262 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -2343,7 +2343,8 @@ static int mmc_startup_v4(struct mmc *mmc)
 		MMC_VERSION_4_41,
 		MMC_VERSION_4_5,
 		MMC_VERSION_5_0,
-		MMC_VERSION_5_1
+		MMC_VERSION_5_1,
+		MMC_VERSION_5_1B
 	};
 
 #if CONFIG_IS_ENABLED(MMC_TINY)
diff --git a/include/mmc.h b/include/mmc.h
index 51d3f2f8dd5..9509c9e9543 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -54,6 +54,7 @@ struct bd_info;
 #define MMC_VERSION_4_5		MAKE_MMC_VERSION(4, 5, 0)
 #define MMC_VERSION_5_0		MAKE_MMC_VERSION(5, 0, 0)
 #define MMC_VERSION_5_1		MAKE_MMC_VERSION(5, 1, 0)
+#define MMC_VERSION_5_1B	MAKE_MMC_VERSION(5, 1, 0xB)
 
 #define MMC_CAP(mode)		(1 << mode)
 #define MMC_MODE_HS		(MMC_CAP(MMC_HS) | MMC_CAP(SD_HS))
-- 
2.34.1

