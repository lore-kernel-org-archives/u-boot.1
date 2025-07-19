Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32A2C83F17
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 00:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80E7A836A6;
	Sat, 19 Jul 2025 02:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="F6AG8+uF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A49908365C; Sat, 19 Jul 2025 02:57:42 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF9B383693
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 02:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcmT7CUOfqY1IF5laGtXfmG1+5puE4mAZ9Ak/PcXoAe/DCmVEpM5MSCvmjRhpRmmOAYY6wph3+CHCE4/BvwDyJwPPucKY+ibpvoh7DjfFZgLqWtsHGuP5y8j/3XWYOP5j+5n99inyHBCwGXlxDd/6cVNQdLuXmkzxyZpb1JMIrWW0fwWNnwUbcnu3jTXuC8wYgRyN+yo3E/xDRHKEO4hjYgIMYDZR5PiZLMOsHoVXq7c0jVMFxEIrhItoTz+kSMN5Aj3B7Spj+S8oiqeb+sxdz07J1fjI/XGpDBiMf2KRhcMz2gAvjXTvI/rkWj6+L9OtDRQlRMuH/NrFcjeliQYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tr4r84l+b9y2s28d72lF0vts+TQgZiMoyCnJQ82Ay3U=;
 b=iUQstQFNfiGKZG1xoaP13Q/K1R32yALN6V+rhWHPQvChmay6xLdpIBP/yeidr5dZ4mclY1sJqKJ8oD17X/nqOrMepaGQw27C8gFMhtLvzpxCHutIFjCrBgpDrHUCuS55VRUJDIJesv6zqiow+gziBBR9oW/vEL84cdNCc6IYIGZD+VGWvroee4J1qfbe6ALj5lHyFMwb1rN8NdNLxHlsTAQt1Ef2T/wOO5HBry0Hp7dGNUxx5n9sO7LYbzmwSQHfwUujtPHAOp8LgbP2/7HlOwfzkx+dX5FFPlcwUa/6nf/QxsMEKTEHRp7zfSm+eG6i2Mm+MejDn2EB8dgYpF8aoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr4r84l+b9y2s28d72lF0vts+TQgZiMoyCnJQ82Ay3U=;
 b=F6AG8+uFMuMHy/gXQHwA8vu00jvlvihbq7GjFcymSDVIbihCie09ZVZaE9U9ac0gpjfERplIXaM1hSO/jYJ/rP0iOSQkCFQYg6nKLbnvq80z1jjoei8FQo31L3btCExGJWz+Jjn6cDkfNppzYE1qv/V1U47ovbt9vb77C1T500mqnvstFbWRxhDjWmsUznEMjUo1GDgOPEsTVl0HWUlZWZdqyHOzRZv2P2aLQXw3xTAwIrFe7L3gdMSiFt9O6h3rZl9NXoZYRlZtNWWOzFJzEGll+MlfYp07bNw/7IAZ6exgqx7VahhrPS4El9b1nqJxjWYVZ5djjRB5S/ZFiVDjXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB10218.eurprd08.prod.outlook.com (2603:10a6:800:1be::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.39; Sat, 19 Jul
 2025 00:57:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8922.037; Sat, 19 Jul 2025
 00:57:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 1/7] airoha/an7581: increase the number of rx network buffers
Date: Sat, 19 Jul 2025 03:57:11 +0300
Message-ID: <20250719005717.113842-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB10218:EE_
X-MS-Office365-Filtering-Correlation-Id: e656172a-1f6b-48ea-d9be-08ddc65f40bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uc0VNg4bpy2gZ4JZEjGLIA9DkBm/JLUoftjU9qwKmZQui32sBPuZ8z31q7/1?=
 =?us-ascii?Q?Fm3HxKLQqiGNCrcuK9g/KDxx3PFlnBvhMy8WEeW0iiUypqWHPG3QU7mQ7W0Y?=
 =?us-ascii?Q?teszuEeKGU2nnsXEWy2PNp/cYT/b32lzW6pEdLdxXeNwH0oA7OPXLhmGdotw?=
 =?us-ascii?Q?+Vt0uRNsTDvIpEK1MQcmswl4dxsInWmDglSAYg4xbzQOy5M4h4F3X3syXYNd?=
 =?us-ascii?Q?XT5AoHulKFgzRVM4jjOgElLGYkbMEnZE1t66opZe9oDwr49URQpXgGtn9IA4?=
 =?us-ascii?Q?cWTD8NbEqPy/V4dxL/FCmGVf75PPDhFrkVOkml+SqzYopoxvz8yLrXz3jE0j?=
 =?us-ascii?Q?Z88FDZLRbNvPDv5e6zJhkovOy9DCgB7vCFVE/9I8q+5gGq+pwPAyVky+Cgpj?=
 =?us-ascii?Q?vgil6PTRJbb1M50+Au3HkOO51U372/jZ7GUEm5R7FCi0Kw3yh1vyhTMW17n5?=
 =?us-ascii?Q?LGu7dl3f6YFi87I6twfTPYSNhEOiMWmgMNwve2j1/SAgOj8aU3UmjS5Ze/2h?=
 =?us-ascii?Q?juhfoqnGJ3KVN1GOCx7I/LIJy1LFzNE7R0HYPOw/n1td1iZnegRStas3ylJE?=
 =?us-ascii?Q?Omwt9ykCH2z49ZuyI+lGk94Df3bGc8ejUSLwR284syTt0E5UeCsBB9sRGg45?=
 =?us-ascii?Q?7vkDnR7dMwh/wVxbL25234ldkysHN5UkllVc+i14gVwb7yvasI7rsNVSWRZ8?=
 =?us-ascii?Q?s//hzXWWxUAp7VdhOn64ekS5GgevUdObqFLDmmLuwZ4pPGJ0MIyCY76UfViU?=
 =?us-ascii?Q?dUxMGS4vC45D1WWPhVaOf/l/T9f61mW1dLgHpxGqJ/HKsG0SO+FzhD3sObKG?=
 =?us-ascii?Q?9bKwWTJTROt+6tvn/iwqQsInD+FI20sul1106c+hHrZ+Iy7aKucryXL7Im7t?=
 =?us-ascii?Q?WoUdYH5+99sd4Q0leTld2WM4MFP6LTVCyrmA8sNF4L1hMpa6EC2vBThr54i1?=
 =?us-ascii?Q?5PQOINllzDAEvQ4qvpJT8ngQwx/zBhrw1Bg7dAp2J5aRH1kfMWPtco9irE2w?=
 =?us-ascii?Q?jkdFZAA5yaDl8UaKYlo3Md4OUkmpYzd/Ir2soZZz6LGzwtcCBnGnELyQtG09?=
 =?us-ascii?Q?cSaEWa7YZayYXDoiIs+jF1NuvprWuN5lBUbY+bpHndar5HNFhl/lrCGEQh5q?=
 =?us-ascii?Q?lknx6/1IG7+z3J+GkjDDtUMx86pKQYjt8fdQZVS2fgnVt/a7ijkeOfEdyfj6?=
 =?us-ascii?Q?fXFhbq52u6TQtT+lJoHlX6WFZAKdyua5FZVmIFnb0A8TG7+VtCwh7Dq/5kuf?=
 =?us-ascii?Q?HHq0P2SptG/P9LTSPGhQ2GvVy5QM0wzu48+/uuMv1rq+lcqWyuGmJX8WDp+2?=
 =?us-ascii?Q?vDrvckZpB3J8Pt9Tvv0vtzRmKon/EwKYbnnaRbdHVNxTk0xwPfG6uJJEBi76?=
 =?us-ascii?Q?CEFhW8/2nTwwjdBSE1yCntERg6/YmX+NEpVtH8AfXvgodxqR2Kk5oEA8xGh6?=
 =?us-ascii?Q?oGFSu45Vtd7yZOIf2bgbBdxCO7lMnRg0jAjCbQTQM4Lw/40Somx8jZidqYP6?=
 =?us-ascii?Q?CNE5Da2bAy1pc6c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nmiyq7aP5qeZAG070Y+c4alMTfmIomWDo4RNnlMAUbwYSzXlkmKKua4wnP2I?=
 =?us-ascii?Q?OnQCAbrVI129q0hrlcuqrmjAVYO6sku7R3uMRAtaOnVH9NCCrSeqgoZkhBVf?=
 =?us-ascii?Q?jcht1veHCnnBEnDG6ca6iIO1EsX0l1C0dG9z+B3zOSAbVS8nnNERKoX2OCDl?=
 =?us-ascii?Q?pF2We/DZYV77jbsDPmpQAeg1fNqsaVisd7WeS1kSQEKOtQopaAIaKsy4MJD1?=
 =?us-ascii?Q?yiqHUWSeo4WoODxk0jbXdWS/X4LOIvBTsXM3GZjcmOpEwojzT/431RRz6ASe?=
 =?us-ascii?Q?5Wbj82bKfsCxn0BvjgS0nNbFiTo4AOUqVdUqxK+MYoAUSNIxiOXbuVzXUzSP?=
 =?us-ascii?Q?X2jvQjjAT2164YEaJ94cqMf9ndDVwjVhGOMdNhDBfuSr917iE5jQwy2Ph40f?=
 =?us-ascii?Q?zpbfvGB4miczuCOUfeZEaoch2hvgmxyI7/yNaBMlfXbPTMYk1YBA9TCCXfZG?=
 =?us-ascii?Q?sEcVcjTs7+J3V7gVlBJYeIhqUWfUVPXDuhvaeM5WMGLxADLvWVZ3IIY9jGKs?=
 =?us-ascii?Q?Y+7JPwvPwQnY3r+ji+RDj/pJGQRlCopZGgE7F9rYPtI/9fzbG4vV7AkK03+r?=
 =?us-ascii?Q?8VdkmLRKE5PDqWcyFbQ/lc6OwkCtfmA2d8SHIaJyAw7F0NXRwyq2AUJJN95L?=
 =?us-ascii?Q?oNhKuXfNVp7umiG86H/0ESH7SSdtQn9Sv2KIfURcTsAT4QyPxICpzIEcDyDo?=
 =?us-ascii?Q?HIraMRIXeVYn/syeRTRdlEsp0PCjtq8gpC12UlVK+ZnJxnn/FWpP4JG7IufU?=
 =?us-ascii?Q?WHO7xjq0pseoCkhLj0/am2meV4z40DHvkqYQesL5i62/oHbuo3VWSE3ODmZo?=
 =?us-ascii?Q?ov0z7BKFd4qbsqfls5DQPfgZbBv2g6w4gOMYHSwX2Tb+QTPDoyhD/UM3gQ6a?=
 =?us-ascii?Q?t4im6fHw+vpm0oB4frO4HolzggVcYIKskAMyWe/Heqdhw5S6zdB4Z4qbKcP+?=
 =?us-ascii?Q?IaUKTJa3uatI4tZ3Y1yoj4qy53ZY0bxEin3uKRon+IhABJgT+Ag8AouJV+sa?=
 =?us-ascii?Q?9XywRmkxLKGMxChUxlSBlvz95eG9P7NywsslpQK/PKBtEl0CAah6ZnxAGtW1?=
 =?us-ascii?Q?9ZdHnPj5MoNxKyzFMNNrlhe9mN6RApoH3Ijo0LnEmh0jj+98FKRObpH9k1qr?=
 =?us-ascii?Q?ppTmyIpeq/9uIBkI13nA+0PSrJN87xdV4MauCnv58EwePkTdAWFUJLqHuJ71?=
 =?us-ascii?Q?XffpXTKxE34pXiIS9Klxixx753+yXQlfrfy1qzCMzJWpIbyZFbqp0M4kEzIB?=
 =?us-ascii?Q?cbuQl9zYbVQKkSQa4aNlrfU9MUT5T7kXRRUQ251HH3RHg/yBsMptPG89w69e?=
 =?us-ascii?Q?2vUGFzFyCyidrPX2PCR3cpSodCz3IfP824HFC9tvVEQhRLuoS4vhvC/M+7jB?=
 =?us-ascii?Q?ti7sBTc98WFbA0oM04oMnPhxH8kaTGofVt5L8cXj9/jQ1Nr3DWeg2Z1vBzsn?=
 =?us-ascii?Q?mKhzDvj6jff2JoZqkbga5jaeWq4jZY36GiEzfk5xSgJzWLxRiSmyYZCHjPew?=
 =?us-ascii?Q?qNmrhkICmMAjbZKjvagPBl7LGZIYJwnEItUKxQbmKA7UnEXBTv7IV68uV9k8?=
 =?us-ascii?Q?1keiedhW6o6iXbKel4tm5JjeOUM2Mh/n0h33rjqebMk7UsX/DTgZxJAnG72D?=
 =?us-ascii?Q?5COOhtf38epey0A9mPqK+8M=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e656172a-1f6b-48ea-d9be-08ddc65f40bf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 00:57:36.9954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/+JcSV0oS5vxHNbA+bxfl3XCpaqqaCqFYBcImNobSZzyeSdM0sHliAAYIZWLvh8s4+Tn3padFd7Dh0AT73hPj2ajOjpr78kA2G4ZTW7HXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10218
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

According to commit 997786bbf473 ("drivers/net/airoha_eth: fix stalling
in package receiving") the minimal possible value of SYS_RX_ETH_BUFFER
is 4. Unfortunately it's too small for reliable ping.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/an7581_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index 0ccab4f066f..baa3fc3f5de 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -43,6 +43,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
-- 
2.47.2

