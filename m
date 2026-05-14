Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1AFCD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 18:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 698EC84687;
	Thu, 14 May 2026 20:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="wMBP/uMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8794846A5; Thu, 14 May 2026 20:54:24 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D94028465A
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 20:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWT7HN03LeJHgTialhjRH6hUXjNLgz8friAJMP1pahnmfcAmkyBRLMYiKCjqYKRVIfW2NqEd90dQdGtx4b4obBt+fbVBzHrQm2CpIYry+EQhYOS3mX9f1JXgufgumf9/eFI806t3hsqffTpqfpGXXtNIFgOgpRTVyVmLp3BL8S9iEw0sU5iyP+0GAPznKQMiMeDNXVOr8+qTKYRZ2JTJKyS1n4ggrf6wU0tED1XIg9Mbyqz5KTc1h5Q1ciupH0lcGXy8/qw4L3ba51yUVkXj8z1sdtRkYaDj2YnZq29Bg6B0LMnxi75oPdwQ56N9dk7eYCs7TXUxoQxR5fh4xZNHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLeEsDxA4lG5QuKO0UBXwrYWV5HGrZHkwmLduq9Ifzg=;
 b=a1P48oL8sJNCliRK2aFh7nnFMPWgnch8cwjP0Q51lfKSsgKBuS9RoalRoHYQYDdA95KL+VefrR7sAtFkTce5lFoGXbFuMM8EZ2YvMSTMtzruk6nZOQ5To/rTcTOK5kZD+hMdRlJxuAec+2nV74sfgCSSIDuZOy9Sfg+ayV4kaa1uewGl+++tA1r2vAcgR2TxdtasLBuKwsKkqqN0UrdzoHHnXYvPdOeA+OyCNrFau8oKngAmQcyHSDwyByU1jFK8jgsg5Gd2hDkFiK1EQwTboqvhNULHneDXJCrFI+wwsUek8RmIVNxdilwNbO0JeQDyZrIXoHjWAoMNnqAIJidCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLeEsDxA4lG5QuKO0UBXwrYWV5HGrZHkwmLduq9Ifzg=;
 b=wMBP/uMZ4iBOvIK6shvyLjEjWYpAZiK4iRneFSc6+U7u25fhWOJ3T6UhzM237upHnJTkyApxa2SLvIkzjB/h/bvPY662LNH42UmGmI5m+eowk35vMeZC1n7CLA4AVH9cvAwQ0Qs8bH7/FKkTkZD9rhiTM9T1M5JKQrJV4FMkqOkhXuBMpQ/O+ztvfEX97c+AZZ6695LxgeT2fHqdtND0LeYStx5VejeKwAgGdOUe8KA3flvFrDzAIcRbFHus9mqG+s9KOEMN39a0Ik+EWzT5Zt9XjpxQ6je+dYmXqsVDZQF3n0eHkvk0Nuu+qsfSnvtNQBhE8GXi0kpQNafrlaoo8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by PH0PR03MB5846.namprd03.prod.outlook.com (2603:10b6:510:36::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Thu, 14 May
 2026 18:54:19 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 18:54:19 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 trini@konsulko.com, marex@denx.de, tanmay.kathpalia@altera.com,
 Judith Mendez <jm@ti.com>
Subject: [PATCH v1] mmc: sd: fix redundant 1.8V voltage switch on cold boot
 with UHS card
Date: Thu, 14 May 2026 11:54:11 -0700
Message-Id: <20260514185411.20884-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::6) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|PH0PR03MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a6e0cd-c2fe-4f31-895a-08deb1ea334b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|55112099003|11063799003;
X-Microsoft-Antispam-Message-Info: ZQyWSZOLVHAKpuuj+bGOqvTEynh55YzAUB4+q+q61GpK1P+9Z+aZIhsiDk2k7lZAnj2jlwUduUzJMTZ+81SrX0yXrbyGsb1JwUB9r8xko43Umuj7ksZhgiGl1DsL4Fh91SdvRfhLtZEQd5d2AGTDMJ2CHaUIEnHazuy3g0WO+h0LAE9KUCxYCOMI+idoQ/WpbWm0T3NRuKO0npnsLg8seEcZ8Mflqes3RHdGKSFqa1X8QcxZODFmY1wPpuKfBHmHFslxQ8sujffTojmatnlXo35X83383lHw8n23BIfSiGlKxAKI1JZjXK3pBcpZ6WU8SHCVaTie7Oub7QZdV5J4T9cWnX0+hUVvXJK3CJ1Rsj/dewv9EfpEbuJiDD+7iiN4GNompJrroq3HFTq3YJc282YpbQiLOU146OauBAmfPC9ytxQuig+Of0pVOpofW6ztJJesdfkfixReveI6/5r7F4ZKYJAZKElA4y0iP8n8A2tVkZDCiy4XCuN6ANQKiOVwURy8Kr7SCWmc6b9xMAl8iAss4oWdDMYnjly+4c2g73jgHJ+3DHoJnOjbnQKdmlNsyqy/3g70rvtcXzUpP7aQorMDnsfv09Oz9cT9CvkdEJeras3SXSzmKcKRW9uz+6gDGXyjsQ2Mkj/wwgvF0L1z8UaOIbMJ8+BwSFeic36mCTqSskc1J2HdfmS30nz3wUpL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(55112099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kJILpTgpK0tbKul4Fl5e0QgtP7Jt0PZn12pVo3akoThWp72cdS3owEaEdNXo?=
 =?us-ascii?Q?EUR9chkyeG2jN/GfUe31/TejnNYd96aY4V8Q07Ue1ZqwtH7oxoWKVMz70UiA?=
 =?us-ascii?Q?lETIp992qXzePfZwiJ2B4fOVXxfEn1sW3CJOIATdh9tvVkvAnAEofm+gFM72?=
 =?us-ascii?Q?A2o9ADOxZIsOsZWtjdbXzBxHqe8xw/eG/Oi8OEnMpWEneFh/CmWblcQ5jYKn?=
 =?us-ascii?Q?G4qSOVOFgjR6xgovX52yuM1FnP7vPbnXUw8wGFP0VvL/tGC/L3MwEEvSf4uY?=
 =?us-ascii?Q?++NNeEjqwVsLF7BA0qB0YjbmXVbFiRwK5YjIyZVJ31NRBUt+7r2rNbK4vI8+?=
 =?us-ascii?Q?XwvUP4ymVpSp9CeR2yjmTINIo9w3VHF9rqqZkmJMW5rTL4ATicm6k5P8Bsut?=
 =?us-ascii?Q?REBnZtqmFm8AN3BanmK6/eiyJGVfj9GOdaiRpv29N0MMS+ydOoKdntDc19Nm?=
 =?us-ascii?Q?lLiLi11YEz7h8EHqHUD/P+VQQqIF7JQ9zSx03H4NgTLD8G8p2xqHsh6wp64N?=
 =?us-ascii?Q?kyynQixPKYEvRRYH6gqansrW+0WEAuuxcG9+jn2WZ0mCzGvU952xa1ilTH7a?=
 =?us-ascii?Q?lEjuf0YU6VahOu+jhZzBUKMJrKcBfhpnJtqM4CFwvzQVqaIF4QE2yjhHjIv4?=
 =?us-ascii?Q?R/NspYJs9oFQtDz7V1k3Z1UzvLo/XlaQtMQZriENog4gI3Mkbgej11NzoP2V?=
 =?us-ascii?Q?FD3AvR23IQeq9y8Qe81Gw50VmF6uDGH6yXVS/L7dB6Ulyojoqpw7WPbUDUgQ?=
 =?us-ascii?Q?XBodAE4s8MxMFIBfPHN6T6ZQseD57WAS8Isy/u1w+b9prtQb6To32ESuvZDE?=
 =?us-ascii?Q?ZHbKriWKuI+BHMTM7scpBe2T0nXrGic8zNzkDbdXgymtsH1/01YE0QW8+QmP?=
 =?us-ascii?Q?KjP3KCASTQl5/L4wRwP9VGNWOf5wZQqI81ZbBEQgSYSbDPjPqZJK/weLB1lJ?=
 =?us-ascii?Q?VHDTE4v7BoX5Il7HyYSDFu1mbGvWrda71jc6i7zk/cV0fOBj5ICzCbjnOXsL?=
 =?us-ascii?Q?0mittWsCJGe5/W/hytmvB68IRpErG/nKObXKl5Y9E3rUnskpqTqs3oRTxj9w?=
 =?us-ascii?Q?8COIBFzlOMqQBkd1yUz5yW9yu/IpcX8yQoIftvEg4xA2YNGlYTX7qeKfkLIi?=
 =?us-ascii?Q?qH8OW8JRXhkz1ukHD0woXq9uS7aKShfVj+L58lofy6t2b1fNeCPln7DAQ0li?=
 =?us-ascii?Q?BSW0Vl75QMHIm8vSpTpRds3FTqpoxU1T7f7XDcgSSs9NvkIyZrx57Jhzs9pF?=
 =?us-ascii?Q?cCzw696lqq38IcTjZ+rqyDsLmMzdiVpHT/8oBd5jhOSno0VO/clYmdF/6gEo?=
 =?us-ascii?Q?XpLHDLJPwn3kiDuh4FKG/BkMOxRy/CFifW9D14hzQzHMnh/b/M1mDLglr8N6?=
 =?us-ascii?Q?9IpHAC2X2iZpy9r89xVaNuq10pWv8Bs1okSpW2XlzvXJqzO637DxYAU5qEZ+?=
 =?us-ascii?Q?tFAB2674U4+Gn5ZUAr6aX7PDNR+qamIVzDrvcwmQu5fZ86UP5LuY4TyIvkFW?=
 =?us-ascii?Q?t5OR5zEv/Fd/6ARSLtlQXdpuUc9AvQ6hOd7CzqPk8ibj1G2zutyJWOZXUaNQ?=
 =?us-ascii?Q?AX7db1NFvSqo3Ym0uAcblo+RJ5/QTmXUdGa3FD6q5p3q1fEsev0AGxqlMQaj?=
 =?us-ascii?Q?9eyTsXVFAvWeETKQkQtgG03ysFK5AxqFAYMlvUMb6gsethtPoBNJUR3+TCb8?=
 =?us-ascii?Q?/S5LQX+q5vsh6zrLt2zhdLacGQ/QMl6kXjg1zkpDDbpQolP33zdmXXfcq30C?=
 =?us-ascii?Q?qx3+yxd0xmTPnPTEoLMq2lIp7ZXnEYI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a6e0cd-c2fe-4f31-895a-08deb1ea334b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 18:54:19.2123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wn2pYjPn5ArvqfSOtQBYiEzsVCHBwisNyQ21v8sEkjK1+W5i+dqw6M9zHVKVk+wvSAAjiYtJ5q5293jkO9grAX3Y8WeJPpwsgqgns2XQpCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5846
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

When a UHS card successfully negotiates 1.8V signaling during normal
initialization, the host voltage switch is performed as part of the
ACMD41 handshake. Without this fix, the warm-reboot recovery path
would fire again immediately after, switching the host voltage a
second time unnecessarily.

Add a check so the recovery path is only entered when the voltage
switch was not already performed during the current initialization
session.

Fixes: 906ee6785b1c ("mmc: sd: Handle UHS-I voltage signaling without power cycle")
Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/mmc/mmc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 7dadff27abe..10d8a37d2a8 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -2720,10 +2720,11 @@ static int mmc_startup(struct mmc *mmc)
 
 #if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
 		/*
-		 * If the card has already switched to 1.8V signaling, then
-		 * set the signal voltage to 1.8V.
+		 * If voltage switch was skipped during ACMD41 but the card is
+		 * already at 1.8V (retained from a previous session, e.g. warm
+		 * reboot), re-configure the host to match.
 		 */
-		if (mmc_sd_card_using_v18(mmc)) {
+		if (!(mmc->ocr & OCR_S18R) && mmc_sd_card_using_v18(mmc)) {
 			/*
 			 * During a signal voltage level switch, the clock must be gated
 			 * for 5 ms according to the SD spec.
-- 
2.43.7

