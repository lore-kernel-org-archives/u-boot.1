Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32FACCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 04:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E221183FDE;
	Fri, 10 Oct 2025 06:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y0O2jptp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1235F83F69; Fri, 10 Oct 2025 06:38:39 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D760583F2B
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 06:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7WXsqw/nIl9hoS07BSIx5xF1ISi+tcNEe4Ck/qBKO4dryBPNBJdKx3IfJhaAKNiR//bn9ayOSgMwwxCXd7AIDUfQUcdfnVtZkp2r0d63PRMb6ZkPfjQx9U4fOiWK5TYk393mZQf1RP96W4R9xSpP40H+CFMy6egNC+BHLPpGOiQGa9yln5Ch927/hDKPsBea8cvm7PuaRhEScHU+4l1eeqyKKYAzF5x1PKiGMA6sEelJ+XFajpR5ZzOF1e9eigfGxBINsE+5zNmLHCtZE/5NKdhoWlzZ9Vh2R5PEiK8cugR/Ns3Zvg35Vww9hE/TX4CDh+RkLxdWi1FAUn2kKn9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSnWJ9uLp9lh3IMoAA6uA3TAFWHzC4e/i+19LjvITgs=;
 b=OpM5NGV7e3ytqxlUlB0KZHitjYZhQJKDMpe3SIHkqyxCDtBf77rpbdqN4gGKKRQNIWoykyZEW2uJZB+kYXm7vP+HcKA8Kf+W99QTd0QCtbRDOKgrfWz9Jck7m4c+mx2afO+maKDIKKMjTp0bEV0bByasn3r3HDzApQ34EHXPmDm0LVK14eTzlHN2vZ497luLs18UUsJFXF1BUl0fYVFY50SpVaRwcLXJnmXtkH/tHc99ceBHv4RBY60/UpMH9TvSN9NDC9wlXEVEYEoj8lGopNpPhOTqWFShb3bOb9s51pAKFAYh3Qsnb6YQHPEBoTBP5OjMAAhtnzdcGN+6y2bQZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSnWJ9uLp9lh3IMoAA6uA3TAFWHzC4e/i+19LjvITgs=;
 b=Y0O2jptpHJlV7o7A31hzeRG0prBSDHz9tJ1TvdPetPc0PeQZ3sK2y/3IuKSiGAEuzHzKS0lsqDzliIXKZunwJrBPvaARRK3sJnK3xbtaeLpNU6rXm71M4La0xx9couSB7vMoYKZPwSyz/4fTmn2/U3hFxjNzqm/wryJwfA8SiAy/Q1yCacuS3quU+VLm5/2Ug+skMKiuArLt0FJtgoen4Yo2DrwV0UJdaIgJk1WkFdN7rM6kvuZK/814ukVQGCOKVn+VI70iU8DwOySWds4FSkbw+oH2p/CUVD7xdJejXFuWilB7KHRZFhefN/UWk6A8K5snjhlMnI+KZP9STiwNyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9087.eurprd04.prod.outlook.com (2603:10a6:150:22::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 04:38:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 04:38:34 +0000
Date: Fri, 10 Oct 2025 13:50:47 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] please pull fsl-qoriq-master-2025-10-10
Message-ID: <20251010055047.GB17199@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096::25) To
 PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 1025d4fb-d4f7-455f-718d-08de07b6df40
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uOkbwFw5E+ot6UNl3wJPQnj7Ct+4FSrBc0LLhbtFz1bwLiql41yc8so7DLm9?=
 =?us-ascii?Q?vPW4j9wCEFEUWiJDYIBl24UmP8X8C7zm7vU6+w6qN1Q1PlNkgGGbhqAoaLL6?=
 =?us-ascii?Q?PgmNuG5OBNZHPeeMc0ejjGOLFawbS2iJdwkzaUSU/1h1dkPUReTkaGRwt7Go?=
 =?us-ascii?Q?l7ss3yonwqmoinxXsJAkSHHmq3gOrsjhtMKEu2GLPFU6CvOiBoOk9eKxUU95?=
 =?us-ascii?Q?ctO+ANJEghykwBCEnFP3n0TlMcYW/XuqfFMnkOCWoHcv1yhGOnQ53fnTPjpW?=
 =?us-ascii?Q?H4XQEtTrfCoxPeVajBgNH1x3Nro7IcrRISmKm4HjlvJdqJgTAqPH2VRRSOkt?=
 =?us-ascii?Q?kNfFGGlEF9y7nl3ULCemXP5i2KSKrILTS0C5hQZd4WDzUJhb5iMaAFxlYHQV?=
 =?us-ascii?Q?4RYp6zTBPeLxD8LH00jvnCT/O0iQ3tIm96+TKk4CCwH/w7m3zefAChfqVJvq?=
 =?us-ascii?Q?dYS2/7hSv3tayUxDjN/KZHFAEjWVtNDt5KDQRQnMQqEHWNPIHDokO6o3zLdZ?=
 =?us-ascii?Q?VynGzvVn9CTpsLdBSd7Nl0D9H8L7vUrMCX6x9lQKkzHeAY+3ZcGIUD1z5uJI?=
 =?us-ascii?Q?Z+w17PefQAsGz4KsbAQxtnqMmR3dnoZjK6DAwdWkOnMjnznca2HxLn0eV5u9?=
 =?us-ascii?Q?MNmc5qDXLAO5UFRboxunVMgwlJV9R2+4OwtkNZLsWjmZvyCukAYYmSiGn/H6?=
 =?us-ascii?Q?7L3SmPYP8lrdu9ivwmODemgLlTdqAYRkJBgkrCmD/IrVQ4EMM2XEINda+QvE?=
 =?us-ascii?Q?rH5fEOHsD2giHPTwyv0T4TNbdbt7zy2AxEOT4bD4kQKGrRzxeVyJavKwljod?=
 =?us-ascii?Q?7HYPKj6hm6LtNYzxJwJwWV344M33OAZKSHAnC+dvGRxMVRieek83lb4hJPoL?=
 =?us-ascii?Q?trLVcETzoh1CLP+nL6raFKg+GC6SVyRUEY3/qdZDVTxjOpGBZyVrPYd+OKk6?=
 =?us-ascii?Q?9jUIKrhyZ9bmy8z0mHtuBtxxw7CYogQbwq2MKtzaw9XOVwierPcbOc1slaRv?=
 =?us-ascii?Q?fzO/QntRDC6se1Lwcq5OMJ98U9wnQ21JWwuCu62nKMP+oCstx4vzLyPeY+F1?=
 =?us-ascii?Q?7KWFqzxwfK4q3vHrcpkSsH9/XaDgK7WePBDCpePK5S91LDWIUoJTe+4HOnoS?=
 =?us-ascii?Q?JUuu8eOUFlhilKd7oYhMZlJ0c2c5JKeU+ldPZGjWgxRYy8DRirV3heJb1Lmq?=
 =?us-ascii?Q?ebsjK3nDyfBb5hwb/z8JFbn2wzRJJJr3xDnXeTQTOXFZNclZhvDiqUO1661/?=
 =?us-ascii?Q?mpMZyCr1uqcq25LhfWqLZ0W/hSlYEGQ3SR6ILYZXb6OvMJD6wvKNBBl+x4gs?=
 =?us-ascii?Q?AcTACJVZEJIHBpbni3mVPzhyoIMCr4w/p6iCRq5uHqlYx9nr6h7pEgczAfgF?=
 =?us-ascii?Q?OcnC19Zu2bY1sNc/cjDeKGRortQuMBi/2bu6UH1qKb8K046F3+INYdz5BIUC?=
 =?us-ascii?Q?TGrAYZKMIY4oXhPUDxiH0Ew8+E9/guVPu4c8RmO6YB6uVUQJLGRwCQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P5rZUkwntEeY99X+MC6vxUwRg1sho6d6L/XacXb6zoaqZSQh36fJHSngrkfu?=
 =?us-ascii?Q?C58jRHXX5sOACIVhynxrKDP9JrtSC0M2lw765WDSZmP0wOt/89tjGiAcvvqj?=
 =?us-ascii?Q?BrGPbm7KDR0nKLNMiFLr06mhlA6Cha3vYN7SFQBB1BJGczQIqXKKevANwI9D?=
 =?us-ascii?Q?kCzb98c53IonOWEVD+o8seu612l8XgbLgLfm1YryeGKsml/RP3Jq0gg1HRSV?=
 =?us-ascii?Q?nY6BWKGp88EfWSRXncccPS+WEVg+VjlOrYXNlkKL+9AZO5eY0oZzd9vk8Ukv?=
 =?us-ascii?Q?RFrfkWFn6yWsIj92PLZY2yReDsleHZ1FkOyQqJY+/0JnYDlCs4n8IGHVBjWk?=
 =?us-ascii?Q?mEPrxkwnMeL3fXZmv+hgzSkfsPAgobG826Q7BZc7FaHAvWtTA/JsghMn38Bx?=
 =?us-ascii?Q?aUNLzGWYsD54k9tAgokiPZjB95BIpj0ey034Wg64iCTDwBH4iUXh+keHXUW5?=
 =?us-ascii?Q?GnwoeFKsFYxG/tYLplcMQLjfJ4ch/OBIr2iF68kJYJBzylIvJY8SEVDJojV7?=
 =?us-ascii?Q?QCkQjZz2xEJvWaHZFNtr9Xz3y/6G5D63rRRUYPGtJmtPqgFHxNXw97xEqJtX?=
 =?us-ascii?Q?UtVPWGrYFc10xVJOwqO4x2MLphbPwIl1bcwi/0hT1mFvZG5NSaS2H/yP0Xh5?=
 =?us-ascii?Q?qz/N3/zb8plK9/8xLmUTHYfBsEnb4TKIeWEMWjJdQTxEIxlwHQky6Ko0Xyyu?=
 =?us-ascii?Q?kk4gAjsKXBu9iUZhwX/o4WBS5L+gB6LbTNTK0BGYb8DFjWqIGuQUkas02rmj?=
 =?us-ascii?Q?XgMOLhNvoXEFu6T513kmU8FPoajuJ9Ryk/y+qvtoIeI8zEeYOiZFBtOY4ILv?=
 =?us-ascii?Q?NcFbCEeGCcuiBegPJfs+dKgl+Sojaf+T5avb7YZBs2GLloY9vueHax6/aCq6?=
 =?us-ascii?Q?ZuIcNvSrW6aP0HdIb6NumgHQxZ0CelrhRam+LQHQfR+EOr5/zonhsl0fR4Cb?=
 =?us-ascii?Q?pGLjeGY1uuVG/H3hpyAGYhTQ6FIvmMwrS253dzxDuzH+YdvyyfoUz/fpyqKq?=
 =?us-ascii?Q?kHBNN3ZDADVPwQx68F3yUxTC+AJc/uiNlM5tVgLJaODT+1noBRwPAzZiGcaP?=
 =?us-ascii?Q?c9XZJALQi20zY9Ngndup0HPSgftwAExaAOXf41pscl7SQFfXpOUDdfELtSlH?=
 =?us-ascii?Q?KYrOI0ANJWSed2bEups8/9tB1dbwg1/8U+0JL6QDWCs/xR7dIlzUBbBzjY0G?=
 =?us-ascii?Q?9KBzvYMrqj5yG0xmaKAInLLYQ3PDPGLCyvklKoOmrTaqMMnj3xWO2HlKFxD7?=
 =?us-ascii?Q?CC0IgyDSdsKOMI4qCI9C2/2/pFAVW534kGrSE5vsF3JUeffxbNdy3bK+PI7q?=
 =?us-ascii?Q?mcCBqNWhAKDRgAvsBxLv/o02Yh4gKuP7LXdDT90Qxcnt+RiS63hmkOAS3uwC?=
 =?us-ascii?Q?Oo7w+n0PBAa+ywIuwc64rp/ZmjJdGBIV7h6xxMLclf/uenWma1RVIjWQ3qT0?=
 =?us-ascii?Q?MgFFQQ5drV17BqNE+YegIgGcBntixbNpNf5/Vmnd4V+NgchUQZDPb0owrtm3?=
 =?us-ascii?Q?A79eU3UCELYawYzqB3FMgcDSF69C3UBBrxjctyhpu37PH9UZqm1fG9RKN5/V?=
 =?us-ascii?Q?Y/dk59+KCoAc9BHs3uaBsLhPTzz1P9RikmiqZ1wJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1025d4fb-d4f7-455f-718d-08de07b6df40
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 04:38:34.7949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLTkIPKCUU+2iCJlPNbqx7tLQm5JSiRFZXkgTOwD2WIypJEAMQ+4McKnSUmv6QLr4ghjW2k+h1PWSEA9cI5Z/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9087
X-Mailman-Approved-At: Fri, 10 Oct 2025 06:50:32 +0200
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

Hi Tom,

please pull fsl-qoriq-master-2025-10-10
-------------------------------------------------------
crypto/rng: double the entropy delay interval for retry
Make RAMBOOT_PBL only be valid for PowerPC or ls1021A
-------------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/27882

Thanks,
Peng

The following changes since commit ecdc3872a767fb045be3296d4317ae978a14b022:

  Merge patch series "firmware: scmi: various update" (2025-10-09 14:30:02 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-master-2025-10-10

for you to fetch changes up to b1ca952b488fce2ffd71d93040b1f1f2d95d4674:

  NXP: Make RAMBOOT_PBL only be valid for PowerPC or ls1021A (2025-10-10 11:45:07 +0800)

----------------------------------------------------------------
Gaurav Jain (1):
      crypto/rng: double the entropy delay interval for retry

Tom Rini (1):
      NXP: Make RAMBOOT_PBL only be valid for PowerPC or ls1021A

 boot/Kconfig            | 1 +
 drivers/crypto/fsl/jr.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
