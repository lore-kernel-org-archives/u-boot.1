Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D453ECF34C3
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AAB588F95;
	Thu,  3 Oct 2024 23:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="HVZNd+kx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9D1988E65; Thu,  3 Oct 2024 23:28:21 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BCCF88F55
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9wLXWuNL4KYh8jJ3ChozbGxIBdrZLhgacwFKX9ruy7jk6YbRqW6BQv4z3XJp8C0QkkO0zh7bQhfaZMVlWrzbWjeNj+akeshOvojCZ7YlJXsJ1V/to+D8UmGBfAkh1pe/ga/InKiiJ3Mis93J+Uu+oHyTmFhwAu7dWES6pKVos+alDXdUkdDwDpbpgbDGgLhpv+aNuaqBFOxYZYDraMQNzCEeSXRpiSS8Vf5a4iKCLPCfY9QlzkaLtVjo+edJB+f6H9PU+03538uABeWLeTsaa6kw2W+gJY9mbSb/eb2G+e04Lviwa+U3qKJch1utaMKn1vYntLJOUwEVew81Bc3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpOJhGjYHnI4/rVZRKkAuOkAiqaWH0oS9bemV6hmtJM=;
 b=XGo3ZwmVjkwl3fWUEd4pEpCxYPeIjwxObdSvDyIDXAdS+COug9zjnpuVTpB7RSRknLFZwnvNzzNEhyclBCCDBstDiP25gQyyJ1I1ld+cy4HkP19dPbVnDw82TVhYQ4p5N+dNt0f01W0LpneL4Cnc4NJE6PNo/c1GdCEXO0XjHIeMdap3v97zXMBcR234TJ/kCYGrvY4QAco5340lq2aJZfQBWUTnj10G2MwcF80GWPSt4gHehGdLsKiTRHNYj60GGx/BLLRtA++vb0I4WrV7k0hRLQRZ07OJJnEta12udNFPC0sd3LR4ZEvlvcqlF4OdTr4ra9ZtIRzxThMmQtfrFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpOJhGjYHnI4/rVZRKkAuOkAiqaWH0oS9bemV6hmtJM=;
 b=HVZNd+kx7X3u6sAsxuVTf00OrXCJFbVb0pFrnWIfgWpkXhdYSbC7RpJRHgnwTA9cXcgs9Hab8Q1RU4M/rMsRLPH/Rsp6FoMfHsAd55VZTH/HoHuFw/FL8201deiZC6GlaNmirEpo0zMGrVbLkZwaxk/sJ5oW1AUkpyYMxVtU/Mw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB9PR10MB8118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 21:28:17 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 21:28:17 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 05/13] fs/cramfs: use schedule instead of cyclic_run as
 callback
Date: Thu,  3 Oct 2024 23:27:54 +0200
Message-ID: <20241003212802.3810-6-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003212802.3810-1-ravi@prevas.dk>
References: <20241003212802.3810-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0120.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::34) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB9PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: ba35a742-3c3a-440c-52b4-08dce3f24bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z2gtE8WUNV872fD1dqDTeTnop0GkCRPPl0wqbbGZmorqRDWgMCqMuDzNjJnK?=
 =?us-ascii?Q?wx9XoIyyvHxvLCeDtKAThopi3fGSGV0MkDk0ZEBZv4Z1tIelljPbEWyVXdIs?=
 =?us-ascii?Q?QUTyt07oebYnEculTtgG+Sgzo8sVEJpGKeKxI741zIKJj+cp14U+dYKyujd8?=
 =?us-ascii?Q?j3ExJjoImGlfaaJCSLn5pZ9sLGCWgszqc0WrOHcCH5dUik13/pHu0RjqKefw?=
 =?us-ascii?Q?bEOalFQ/sboiyMDbEvDTJ7YQXTrQ842RWgkGS3rEnWBE8TLeom1tV/YuPQTA?=
 =?us-ascii?Q?2cmUwxz8Um71UYQ24ilr1EG6MOhtbeYarzc9/LeooxqdNAve/agZxF6dtiX5?=
 =?us-ascii?Q?x8FisZ3HLqofpckrg4RGE610RlFlexlFJw0ZHzmzQ4VdjnMNjv0YgdHKviNS?=
 =?us-ascii?Q?3+6wMlcBre5UEiQ36hVR8TiOSHS0kbMFAeQMIXgEaA7y226b0BRx9N/S7shO?=
 =?us-ascii?Q?SQbVp+x62hzbcBWVTt11U7+5yKUgH1V11l5ogmgK0aa8cnR3JfS2f56HaYr1?=
 =?us-ascii?Q?veucQ7Aw8DOt0K0cVIpMzDjpLTuFapfQa4xOP9unk29sNwOaciSgp7wB7auO?=
 =?us-ascii?Q?TV2BhH2CXz/YNQX6B6F/a8TGh/BzEY1aIEdCdrORRkRyKsmUAgEMFPBv1YpG?=
 =?us-ascii?Q?+Ulg1xv+nnKy1q6D7XOGfZJszBifiWikCJcC8GI79Ty7B+5QWu3CFQM6fA3n?=
 =?us-ascii?Q?q5TcvArexJJXaZq9TrIASFLaD19Qb/WmFH0zCZ/hl+j0vwG230ltt4DAha7w?=
 =?us-ascii?Q?mgyESo2LWt5Fa1XqfM1Wf4RocRmy8nrYcGdLvahuH5Y/IGGoQcRi00yn76tY?=
 =?us-ascii?Q?DI2YTrpthbZwb1NC7Itmdd5XPzgQaPvLaL0/c32hVwYDSf6Tm6qWvTKnoWJl?=
 =?us-ascii?Q?u/37pt1lAqed0qSUw6IqjsKCS+oLmV/uYDHA/dhcfErmLB8fLwrNmtAodu+I?=
 =?us-ascii?Q?9qOoY0KfPzlRdFmuPn82hCym3/aO+/75uNrE3MkFLVoUMtcI0K64rYLRq5GE?=
 =?us-ascii?Q?UPI1CsRkBteA9Yz6wCVX7feR2WD5LeQ17EKNiwJlQ89SxMK84CM4k8nbD2AM?=
 =?us-ascii?Q?xX+hlN8cUJOahxwQCrdCoY1AGnVzyUTwJ9POUfQGLkhCwz4cJI6wYlqyvfbN?=
 =?us-ascii?Q?x4X7TITOSajScgHgu8ygP5fqO606f46fpYj+VupVGdsN1yakNDR2jbnoDorN?=
 =?us-ascii?Q?NAvLFwYS4DY892mz6vMYxzH8TZWNECexBCM0A8WMj/T325dGGKSr1vPymjCZ?=
 =?us-ascii?Q?V523fuP4LiWk95Lhce4hjeZ/eptwj5cbNqD4uf04CIFXnkvwoM3hhlByUfHP?=
 =?us-ascii?Q?efeKVgZCzJakA8Ak1CDD70oxcR2a/kbjDEfrxUrDigcLCA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lCgd8taTs/MvyPF2DQo0VMdbhjTZo+n6nU/lssO2VoNelniczwekRtEt6KNr?=
 =?us-ascii?Q?HKNt7O+LOHxV71tecBvzBT9Z7hu+bzq0mLI7VQLhYD3ZJaKuheshhtYnydmN?=
 =?us-ascii?Q?YLffKCAwaBOfmm2nCrzKuEe+0RJM7iwK/nZl9XF4HKnQ02pb5JsKnbsmQNBK?=
 =?us-ascii?Q?yu08B8f5C6pgu99rH12nz9sf1fnzwBrMK7fQtiCMpdZjHHxqASusSoBwEFAU?=
 =?us-ascii?Q?yhVCXcBNrHEQrtbfmJZjaAp1cqdrpGzcCrctM7btPe9VD9Nmui37oMnPhQTW?=
 =?us-ascii?Q?jOkNX+y3n6OunFIlz2aLxG7yh01lpkkvOM1/uIBMB3F51512F540d5xlZ2EG?=
 =?us-ascii?Q?o7VF5FNAqvYEVDwfzPTgdYL6RbFqDjH4U0EXtbPljhoAEzWWbTh/Pxu4cPcq?=
 =?us-ascii?Q?BVHlzKirIT8HYHUvec/7aKRoNdS/SP8k4seAmQhReNaqI7TAPZ9t/fQdatH7?=
 =?us-ascii?Q?bexFBwyy2x20Lf8p92MGnu5F9nGD+NK+6XwXMHy3QzTlSB2lRV2enOoETGPY?=
 =?us-ascii?Q?AHih1fGUPxUMdD/cNa/JhCnwxG80fxCGkHnijH/cdXGJL645i3mhk1QvPZMR?=
 =?us-ascii?Q?K36nvhFJRdfOHzyM8Y06l6I4QZaMCWhbzO5zdZQer0GEdejf8ir6VOCisvbp?=
 =?us-ascii?Q?UDQkQLI4fCoz95vx/RdEuVJMgCoAiAZhC2Y6C8/c7+P3KIBh3J+W56u0QBxf?=
 =?us-ascii?Q?Xr6PdszG6vg8d9CoyJcJownspfneOWZuG/PHKAFfcEiEcD1uptvBS4SncYqy?=
 =?us-ascii?Q?FrVtpExhzqbtgDXx4H1yAZRYei0eAu2x/cJz4z0mV2AKeRugHp/fjnKE0v7R?=
 =?us-ascii?Q?WBBnvCsBfPZYmWtwT/IE4RATkodcgQuN8QMVxGEawGkMDabPGtAG1lrb2Wre?=
 =?us-ascii?Q?DRjtNKA2Pr32JKnVKfrZQG5FcXG/+huD5b/usSlTnBiSXvNeN1wbmVzYAJ8j?=
 =?us-ascii?Q?r0yIPbu8ECna6Jrnz2rmWBzwh7ZREhRA2lPZuUUMmHKPoq69s8MvXohNGOBV?=
 =?us-ascii?Q?ByhXe7NBYlsGFSYqAyDxbvco4zSgbzGMfS/Bp3vtwHgebaTqbFvU9zIDPz/I?=
 =?us-ascii?Q?RrmaTV0jjcnwKW7h0ydg30f3JNb0ZArS7tfibNsaG08+K8JJbNDV7xWKCzcY?=
 =?us-ascii?Q?is+BZFPu1q5UQAQ2hTUOF5cB0UqgKVl6ee3OMavYs7JfSaVo0Kdz6vokGKJs?=
 =?us-ascii?Q?Wz7SpTbcUR35BsaHI2f16VOsZ4pouvr354n2DX0ose9i0DuNPhw1OynDwYKu?=
 =?us-ascii?Q?bVJtlezq8SH+IWAl/XMHBBSclio/MfRlPEO4Mm4z++Y8r6hJnpXh9OMQmPDJ?=
 =?us-ascii?Q?BcEJtPzy+Ie8sfuQf2GXZZvaVw4K18VYaSZVy8mTc592FOSc5mCCfZjbZdUl?=
 =?us-ascii?Q?qSFwWpgwSXlrLM8NnB+kVSWl5j9+PdDwwwDasTeiTcIykEO2Qsc8bEBY0lXn?=
 =?us-ascii?Q?uMoQwS1+B37oR2tlLtHvnrs5ZvuZem5aRa8duTUCwW389ZVigSf7Knr1TYZq?=
 =?us-ascii?Q?V/A2QGxqF1WarS7XC+26y7q1idUxwhJECyeCdEOzfKS4UH4G2c8U2ROelg45?=
 =?us-ascii?Q?TA8chy3pcuxbcs+fkeQdd/yYHyKDKMmC/Wi2xQhgMFuI1rdyKug/D/rbARb7?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ba35a742-3c3a-440c-52b4-08dce3f24bab
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:28:17.1766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0U9uL9zQ/IRJRtWW2PzhkNS3omNHv9RxSafXUf/ysJ4e+IKgzHVG6S9r2e27gH0tcCJEQUfNk/d02SWBpzix8gPNjlqSuE+0d9xUrAYDDoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8118
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

Prior to commit 29caf9305b6f ("cyclic: Use schedule() instead of
WATCHDOG_RESET()") we had

/* Currently only needed for fs/cramfs/uncompress.c */
static inline void watchdog_reset_func(void)
{
       WATCHDOG_RESET();
}

and .outcb was set to that watchdog_reset_func().  Said commit changed
that .outcb to cyclic_run instead of schedule, which would otherwise
match all the other WATCHDOG_RESET replacements done. As the
HW_WATCHDOG case is not handled by cyclic_run, this seems to be an
oversight.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 fs/cramfs/uncompress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cramfs/uncompress.c b/fs/cramfs/uncompress.c
index 2141edf22e4..97af8cb2b4f 100644
--- a/fs/cramfs/uncompress.c
+++ b/fs/cramfs/uncompress.c
@@ -21,9 +21,9 @@
  */
 
 #include <stdio.h>
-#include <cyclic.h>
 #include <malloc.h>
 #include <watchdog.h>
+#include <u-boot/schedule.h>
 #include <u-boot/zlib.h>
 
 static z_stream stream;
@@ -63,7 +63,7 @@ int cramfs_uncompress_init (void)
 	stream.avail_in = 0;
 
 #if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
-	stream.outcb = (cb_func)cyclic_run;
+	stream.outcb = (cb_func)schedule;
 #else
 	stream.outcb = Z_NULL;
 #endif /* CONFIG_HW_WATCHDOG */
-- 
2.46.2

