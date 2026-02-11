Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6063FECD6D6
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C3E583E40;
	Wed, 11 Feb 2026 19:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="lDAlPQd7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF07F83E0E; Wed, 11 Feb 2026 19:23:19 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE8C083E21
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:23:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhHEabWtimvlLRj8jIWqP2h9i97lCaeo9bseQwrDJaeYHnZ3rfAzXfdq1dxn9WAMdxNEGJTEb4y9HTUaSdXYkd4Sq27kIRRyYxOIohUzsbhNjKeCTohcbq1rWY3B2nOGBr9pR1VTRDWFgk/1gVQ5FDiDJ+Ke4Dyvgyb+vTFHqXk3hNS1z/Bn79dmLLe8EjVDHPFBF500dLDtHgECqev+tPqM2LeEhrPoKfKaCFF3r0JWrR1BuI7XL7HxQI8fhTselP7NlYR75vroMeNRkOBrg8d7A+ThrBt+vs2zCURecC7ocDz5x+wDKsi5kI6g602AcYIbR2/20yG3qM+G4IijIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqVNwd8khqFDo+kPHAtNbu2fowXYAwaZJ7cge27IiSs=;
 b=pDS9a/U33d3kaifk7MrQ5w9OFm0lvGmpRWvEttRDFih4JZciABmCER8FnouS2cy2H/GOj7xUmdlTHdeHQT6QM74O61d9V0DabhAn3PSLeqLP0YbcWeUJ9bEqaOYLnzfGwgjE/ZiYtdPq0I/s1HMezReX/WQ+rNGzdQ83ZZKT7E/yGvyYJ5+VGRKNWGxRR8m0R4oEQgU8VYgJ+PSwxWuvc3N2UOOT7+TYEJegQ4oxqGi+XZR2ODVng3W43yAxA+4yQe3WSY7Zjpx3uA/p/XQN6WRu92Xz1Gzro+Hu9Y0uYKI0/gkPT9k4tuk+PQWuqFw6vFk+HgixdsdWeG4ze29PJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqVNwd8khqFDo+kPHAtNbu2fowXYAwaZJ7cge27IiSs=;
 b=lDAlPQd70TVWYpGNeGyB0jtfs2KjJhAixjsXTqElGvAHT3DEPAJK8E/YMzVqlhwjZVgYdBb57C64w12I0kJjwNSN3rZceT+ERI63t9Pq+Mka7rjjn7LES5DzvUFQPhaQ8X/HlXpGBsLnbcewCsoh2+sB8R+qPxdTw+DoVrClsKPGlLbDCg/awZgEF5szG+zfbGZ4NjJ6macUUhzRUpXUOuBZVrejATkyXIZeZoofgusNTqQDY/ZubFbS0qfhiXFF5TYK+LP1BJ2oC5ep8TKzVnYuZix/yf65ZRt2UWGWEkMUjz1yscIkRfb6Goj5/ixyMt6+LbaUq9wwHMGMwddTFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8572.eurprd08.prod.outlook.com (2603:10a6:150:84::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:23:14 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 18:23:14 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 08/16] net: airoha: pcs: improve/fix building rules
Date: Wed, 11 Feb 2026 21:22:22 +0300
Message-ID: <20260211182230.968921-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 949620ad-f4ed-4896-e229-08de699a9edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OUMy7XKvC8Pvd7ozd8GCJgpYPUue9LNc9SbQRY5fIOJG0Bh5nqDtjCujFe80?=
 =?us-ascii?Q?wgTnO370qwyyz9ST/TJjIPBrHSlpT4La6wT6IwV5G2KoL7Tc5VV/y0nAue2k?=
 =?us-ascii?Q?llijAynkoI67EqcvhMrv21OESXvryXs4o2MfgrFtKGoQXDkXmkj7k2DYKvI/?=
 =?us-ascii?Q?CNN285/6xuoBIErFERWxmVwSeRqDTI15q/XDUsFu39wpvXfJaXFfio5mSPqD?=
 =?us-ascii?Q?UBdg1A3UFQy6b8TwPdAVy5pBJ48zvV1wmNaezr1Dai/liZC59rEzc09lMb4s?=
 =?us-ascii?Q?6DVizA089pM/31xnQA5ePUgrga0jQ8bIkcNiCY9ooqq7uclv3AiyRZI7jkCz?=
 =?us-ascii?Q?Diqmf8WuNEXHCWqHQ8Bq7K1Loj8k7gxQFP8eq9e5WahLCmnS69maoCPkZTCM?=
 =?us-ascii?Q?JfPlIDtdr0e2MubOjbcejSe7JX53TfG9D8Y3vFEEhURr+PBAga9LAye5JRIZ?=
 =?us-ascii?Q?I65WJkMLsKc9FEQApkgMLKtPNPl5g7tRMEBzlgrrJXbGYRrzEzVHFsY7/4aU?=
 =?us-ascii?Q?muOMkjPKtMfBtbJi9izbWndMQz0AMyv8LsBf8rgK4XOQFex+K/TPERhIs5e4?=
 =?us-ascii?Q?FDrSyJQ/Ce2S4y62+RPa5D28pY/8RSXFHOhVrMjd8bUN2SJnz69QH468Y1JK?=
 =?us-ascii?Q?gcoq6NbNPpKDY6sYDDNtvkhTA1X1v9/FfMdAKfx6bLlKa8IB+TrKEgGT/wHy?=
 =?us-ascii?Q?hDMW5vDrGLY1QIWA7yimEjVGPe0/b4q59nds1xXXiJIC8zWQHbjPT+2E2ipC?=
 =?us-ascii?Q?kp/st/tQOMOnHeF/d4ODjcoNKZ9v3DVdtVLRhSWUHLmLb6F5SE8aOWi3yihG?=
 =?us-ascii?Q?ByJrYx8bRyCYiSC7jWMXQFP9Fbx2sL5B1BeYawew8nEdwdyiCYJGrhAtTu0p?=
 =?us-ascii?Q?oKcY+CzdysyKcDyrKUfDRPyy4diWXDwAMh7kWCJB8BEQHNMWDkVh9doif7m2?=
 =?us-ascii?Q?mE5D34C5EqjOAv2gO651FrZY/sw3P3bFsoh8Wq5U00OO4MPv5ZtIXdOoTLM5?=
 =?us-ascii?Q?MtD9R5BvG3ntACfVWD58qkXnWRoA7bivtFJtU817PRoCvoR/eZafNXz138qQ?=
 =?us-ascii?Q?8ANUQenHDukQegpDnn4nO9INMH6lMTJATmRCCxcnYU3yQ5VtsbYIoyXDi4by?=
 =?us-ascii?Q?5MDOYYHjGzhb6BDLBrXIh2LJeC9KIMpp+YcgM9F70gXv6HZfp5f9fndQscjp?=
 =?us-ascii?Q?ODPp30Zi6jDQGHoUzyO1P19pxDuVUeEyyQAa7VJRS7lp/jQOvLuojmpyTTZI?=
 =?us-ascii?Q?Lz9XM/zH3vf/sNCr82l3E6yx6ZzcPC/A34emDJDQ14/+S3ce/Ldw8HKgZ1R1?=
 =?us-ascii?Q?IHbXHm3qttmRhBN72kQsCnIWhhPgFhAAsW7jKeVOddy1a5jukoKK0MEh4GE6?=
 =?us-ascii?Q?tpxbIDfPP4KnNiyKO7tn6Dy9MhyOvc/JVTgvp7JGllfDhWVVqWaaPz+2HELY?=
 =?us-ascii?Q?M5y4VSskJufAfJauzfvpEKpEgTdATk29tdr4xvp4ZOkV9+yQ5/K4vy9KKFHX?=
 =?us-ascii?Q?DL4GdsndVcEXxJZOEunILOvVQP5fdWswNZRNn/VgHvEbs6uP4788YpjSDDFw?=
 =?us-ascii?Q?JjuC5hJaaoV0Dam+Z5Cx9UNu+gcYEVFv79FxEfHDQCiZOg2t8AeoG1dzFw/p?=
 =?us-ascii?Q?T9hVRIZbV57jN6envwUrFbOFjOLbXZvd4zcXZarP0nzx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?krPdfXYPMNrz0/mvp2JQjBOpix5P6LP+wX1xSIoyKfb+r+ZOIL8Dr82Qylmt?=
 =?us-ascii?Q?r1Rhm3tNl+ek8z9Zze6PsbIt6zkascPCj8TPpxwPSkQxJovRIpwbA5sEcO9y?=
 =?us-ascii?Q?md+zGpai9ga5UiVd/vsi0b0viqcDS/GdM4U3fqEqMae657t65SfcFGvF8O+6?=
 =?us-ascii?Q?r6xgdSTO5iyorG90IFFxQ3qLehrX9U8oOXNzE8SNvOdrTMGsz6e82TwhRkX3?=
 =?us-ascii?Q?yButM9bomF2b7HBpCwAteCePmT/jWD4q32D8iZ85HhQmotgS5lcoew/hZwZr?=
 =?us-ascii?Q?ET+D8DRYrySRHuZ8p94h8fmzX0ocw+95IhKHH2stqRwFAHsVLou2si+YbU5f?=
 =?us-ascii?Q?qGiX8bcEoBfgz1Xp6pLBNKmRE6Y8dpV+hITq1Z50v2dYlGGlXre/dM0j3sEP?=
 =?us-ascii?Q?LgOxkIC+Qi+TzFOl/mmx40x2jDBGwC9Pv5SlhfeqEzjLZO73FEk8041bpJ30?=
 =?us-ascii?Q?v/0w/3cSoAnZWIZI54Y41nG6aAu1w+R2OtR8Z8PGwDrC5i5SEBGVbm7cGdf1?=
 =?us-ascii?Q?/O+e5o7/rO8McMBBg7MbJ+Bd/ggUY+gf2tZS2rEEGJCqSyjlcixsUsDPu7ht?=
 =?us-ascii?Q?iQoa9EJoUGQLrdoaz53U7HRaQii/MiaasJu9AIYUGY1m+V7jtjl4MZuRvVo2?=
 =?us-ascii?Q?/DE54RHNT39QU2T8UIrLqRLA2lC4n/V0T/B/qctT9tCpV/jAqMZIv/d/KFoG?=
 =?us-ascii?Q?TK4IDcKJcy52MDQDBfiDbva4Eo2XAP5Zdl5Xfj93If9Zazdo9QHu2B6WLsie?=
 =?us-ascii?Q?frTY5NuiKQqNkKd2qztUqkRX+xZrJIaAYg+5gtvneF+BwQ2yfeN5xWipAXLC?=
 =?us-ascii?Q?6Z0bp6yEe4xeDfjtxgR+aKxjI5b0wYcWWWYKnU9W6+GeXzEnuzpNZrjTGhx+?=
 =?us-ascii?Q?CcZxFdeAPOQpxGlO2wcFlpv0rMyl2YyhFLMVIZwwPHclHoYWUsf5nCPKydRg?=
 =?us-ascii?Q?8S1xx2TIoPGbm5W0h0kx+P5wEgdc4dob1DF8sTL5hsG/6ySRJ5Nkj7PfZl8r?=
 =?us-ascii?Q?RY4BKCbBjKVxyZr9P1X130wItbXlqhtXtNvUkf0xJJWTGbR+UUZgHgtU4CWY?=
 =?us-ascii?Q?/6fNFHAJmVEjtz3dk7FGnLRKOdCeaKfi+FiDGhjBu9vjDUhOJt0+O8XUqOmb?=
 =?us-ascii?Q?EwG4A/aqgy3gOgrL+krASSt8Ls72gm28U8ooE4jjsw1cw8kS49QMvSQGGEqY?=
 =?us-ascii?Q?XcacXIQYSbAxsdCQjR8xqdtXSn7z0K0vBu1ULxjDwuWTXbKi6/dSMnYyEFoo?=
 =?us-ascii?Q?bVr+e5EOFrRIsUEwSi+J20PS6P3cWJS/vQplJNuSWQXw9PH+Mi9DuG0R9P+7?=
 =?us-ascii?Q?Q0QQdajE2lQ5DwsrpigmLfcXU7oeEVkZIaJ6U2iibQaiFPkvUT6ULZUnHSJG?=
 =?us-ascii?Q?cDHUO4gHvGdQSKLIW8l7SDAx4lvIe5wtklC/SUQGv15AXx+/rKvjByliu7Hp?=
 =?us-ascii?Q?KFR6ALqYuaUHEk2Eb8la76jLXeozAWgXFjs5IKTryPWiCjN/KU/tidXsPKAa?=
 =?us-ascii?Q?86z00Gc02D2QwHPuAVdCPaGu6f+XnNup62HGy0g0R2CZYzNF0s19X2DHXTHa?=
 =?us-ascii?Q?5AAEVtvZlNTcf9Y9BVerPDe/lTFKZSXuyEQC4UAQR0VUB/3VJpXDSAo+Q4zx?=
 =?us-ascii?Q?s3qZdJkVIu+FGiEdtqa9BoXn9QssgWNxL+oG6mOjxJyrD0yEUf5fgEZFigMR?=
 =?us-ascii?Q?7nnRBIqHULVQS1iYBdPasAx0R6vzlnh/vxMONWFlG8+kmGUcakRT6eaAfsD+?=
 =?us-ascii?Q?3lBnuPaawOlXsrakVHi/Lz0io0dD3pE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 949620ad-f4ed-4896-e229-08de699a9edb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:23:14.7250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEE7ERbe+F9m6RKgU5ve7r0TP46bZEefMaKPfdiZMvlPwguIS57ybl+GzOJ6W4TKDVS2ztHVwaf7fpgTVnoEK9nAUGWS8X0Tea2osXFNT4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8572
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

pcs-airoha-common.o should not build unconditionally,
also make building rules looks better.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/airoha/Makefile b/drivers/net/airoha/Makefile
index 27f2969434c..81fd26cf813 100644
--- a/drivers/net/airoha/Makefile
+++ b/drivers/net/airoha/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y				+= pcs-airoha-common.o
-ifdef CONFIG_PCS_AIROHA_AN7581
-obj-y				+= pcs-an7581.o
-endif
+obj-$(CONFIG_PCS_AIROHA)	+= pcs-airoha-common.o
+obj-$(CONFIG_PCS_AIROHA_AN7581)	+= pcs-an7581.o
-- 
2.51.0

