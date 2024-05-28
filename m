Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1664C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 11:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57C2C884A4;
	Tue, 28 May 2024 13:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="bQOt84Mw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 477E888489; Tue, 28 May 2024 13:13:46 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B10C588494
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 13:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqZ+SsBd115tXLde5Du08BkmQHh+a3dl7cbfVUwegfN89+9JvzZLLWeBz1TgCf9D/vIsrfmICSDZdWAa22EiQGITBrdntix+uLi5MOD4dcJwv9aa0wzsR8Z2Mm064nO0IDoa9YdxKVAgaXzY7sOgX3zshk9oNRxpperNJ+aTCMvPvDhxE5LPN9fK5+SdMDC6/Z7hREO883hMmelCJjaW1cgsRv7oRdZK/RFMYI9zy+ORu3lmPJrCwAdgWZZ9Ps2LHKkkBCPNid+fNG0R1kET728t9ocvB2rg1Ek5DhQ7cOFQay0aH7meAOIpNJ5VMeuusrFbkW5BWk1pvX6gv6vgew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHQYM2am0ZyyFlNmoF0H4MN1ppsWtGYovEGojZR19Ko=;
 b=diJLxc18C2sIr+AN+RnyDU8jv3OBBXFrjHymPM7pUkdiInMdMDSPvFTkBTokNKVdVMKL1b+i53pL4mA0Q7VdMcqsNcQC0FpdZikWDqQTnBfOweJ0fFv0SwvyqV6B+2cgvE0sHVxTsKAjYpAXc52vmptenIHQODoPAcrV7iQe02hFOpZzvkFXD+/iDNXOj85xpH2tECh31gXE8UA/LpG4JvM74L+PLAOlnMvQVpev7fZD1XQwo5hGuijrL9DY6l7fCCv9nGMVAaCizRDyWuZKyfatGAVNm+9kCLCWy3sv5ni4loC3h6vqM9hsv9WIQ0FDkJMHeaEvV1zMvxQwv7ROgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHQYM2am0ZyyFlNmoF0H4MN1ppsWtGYovEGojZR19Ko=;
 b=bQOt84MwZUTQ0HnSuvBOTkubygR40Mds0oD5GrZRjP2wyNLg2pLNxn/KxxHiMfX+wZW0lCgT3wnu9+DC1s9A0h8RXNOSa3o9qYCrAyLM0yi2QAQXqOnOA3JgCHI9ZNJ4ufGc7pNTKb9Xbu2XnX7DXumIRjlRZMPLzEonD8WgVFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB7079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:df::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 28 May
 2024 11:13:40 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 11:13:40 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 7/7] powerpc: mpc85xx: remove dead watchdog-related code
Date: Tue, 28 May 2024 13:13:25 +0200
Message-Id: <20240528111325.2163560-8-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240528111325.2163560-1-rasmus.villemoes@prevas.dk>
References: <20240528111325.2163560-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0066.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::9)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV2PR10MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c32dfd-def0-453b-6472-08dc7f073a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|366007|52116005|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dcb2QVjtEYrGL/REpGyBy6HVzPh0OTE1DhQOywsrOs0n94VxL7U3g6StiDUv?=
 =?us-ascii?Q?Ah6VnTkrz93txjFPVUDP1IExFv2yjDZFj2Y+iNIZSqLcHXCXeeWpJQlph1kQ?=
 =?us-ascii?Q?cPZUjAijtHUwVR9xq+2cgX6ZvIMQv+hssFE38gPCQraR7u9Foc4avkc8HYrR?=
 =?us-ascii?Q?O5fOWXXY/o3Lx+6c9MtdugAtq40rYJEisEcZDnA77hQ3UOAbhjKdtxqknEE9?=
 =?us-ascii?Q?genz2fJW7FA4v+S6EGebmdID0Az1R3xE9GQbxjdtpdFU5Ge8u2RR/sgDLcgw?=
 =?us-ascii?Q?GNRfUJ+r85aNRmoeJ5oHU7obNBJfD8rY4yXRw2U8AuzCiGBK7iUDlMA42ysB?=
 =?us-ascii?Q?4Y4iNLOq+3UPhFmUngn0DhIRZjspDxYtzsHPNcNMKGdKMNxc9W+88f+kFN9G?=
 =?us-ascii?Q?2kCFm5E7qG08EruwrkpSlBza99mlj8H2a09tM9b5NZvT7fLSmtzyh9qR8Uq6?=
 =?us-ascii?Q?7Y8/AkQ38snSW40gXlpL97LLqvAQUYERHXbX+rbGcA2jJBB3CfS/sbE97CZ3?=
 =?us-ascii?Q?4RWiBIbF0ape5Nhkjs7iJbYwM0KAouykBh+PpnpLhkmFRO3EQ1mdmm6YAZBZ?=
 =?us-ascii?Q?kcOYX/K9GdTwyoNIqm1AbJ/AJ6lYjGc9UuTWRzWYLIb8uPGE40ZgZ2RtmdFR?=
 =?us-ascii?Q?B7XE+YDUzTV4NURbmzeSijTcaqLytJaR/h1aSryIDHK4q5FeOg0qyFoOIBhF?=
 =?us-ascii?Q?k8Blk+N90TRr0Brv1al7BjWypXG78Ehtlvtdo60dYHC+si1Oo6SIgDrTdZ/+?=
 =?us-ascii?Q?f6z+vZq8QyMyauMf7zYkiZKP2mud33LsTIDk9pd8X76ohE38kM0m1z5XzzOW?=
 =?us-ascii?Q?fwaD+747JiyG6moeuxSh0XiTckLOjksZzT9cBncBZSuCi3HcgRddm7dUUrS9?=
 =?us-ascii?Q?qSsFPogEeFd7AVQozfV7Ass+GTenzVLIl/ZiRYrPcmyGHTC7asbF9phSYbZC?=
 =?us-ascii?Q?7fV6EmiMpD0MU+cv8BgrCIqEKfrSR0n2XI/FtFffC9ef2XknadMfQVR4DJdm?=
 =?us-ascii?Q?w3qFWqfmoe4BN+d4hJ17+5Ii1T/8LFwb+L4rSNygsZe+HKz1xkt5pftaSbFi?=
 =?us-ascii?Q?aPvyK/ycvyw+v4zn+Ug/PVSIn3ixfYWKh+zb9IJ7p5nSyMCBdmPwwBYlrx9Z?=
 =?us-ascii?Q?C+Iq5jCCFvkKrmIrKAoA3Jh3W68rRkKdg/voHZSdI+hdLMNzlrTsT3HHWGIH?=
 =?us-ascii?Q?OT9BbhJAfGEKuoDP/fJcmai1Q8HjpucXTbtpTdmefYrsKk8OpKLo8g+PQQ9o?=
 =?us-ascii?Q?46jFyS7z1/X+BV8U8s7w7+VvbKe2TsDPEmkddjduNwYCiMfTAJ1vflHngWu4?=
 =?us-ascii?Q?NyacY/xGhY3v9G73anYNUyV9tDzMM88j/AFIeZHYEq5O4Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4qmlSpY/LeV9GIY6QnHLowDXrWw931EOzvFPOu9loH57VMr0jE0Xq4+G8dnX?=
 =?us-ascii?Q?mp0MRhVyEMiC2CtuySf/JQTizoRG9/kQPhazOeWlR+1rCQyGJ/cPDMUPMu6Y?=
 =?us-ascii?Q?rCLO8YuIEsawOpV4ON2cCoM5Ba6qnlFhAYeo1z/j5jrJTW3P1JK8HV0G09Xi?=
 =?us-ascii?Q?kNlgotZzUNBZphQ6v9CtTCriVs1YrcNRj9wrad+is3KawL+lLyApd7wOK+m7?=
 =?us-ascii?Q?OAs9iXXYD57gA3B5VOezHd9icls2fAbFTpY5X3Ped1imQikt1aSdgyVejA9P?=
 =?us-ascii?Q?pW6X7ya+wHiNJhEIO353P5ETNzb8BblcgOpcaomBTQ49Qdm9oLb1Kk5q9x27?=
 =?us-ascii?Q?4epVW8lW5bTmFtua6Lze8Tk1/6PdfZAQueNQN2HkmXG50+cj5UnoD1tbcyT0?=
 =?us-ascii?Q?LTeoPT5r4Gll4SxpEIjMtSl82UWbCd4bJSkRpoUUyOgXxBCR0WigbKC/sIZr?=
 =?us-ascii?Q?one7CsdZxBfMUaRD9A/eZjJhc+csY6JDgfmzQJYuU5ubB3ADV4VEkH3dWzuX?=
 =?us-ascii?Q?4SYTwQvZWrrBtJJ2YNVb5C0cK/cmErlsjd81IBDoKM/BbJ6laMhV140YNlRE?=
 =?us-ascii?Q?F2fudyci2F2zNg1MIOfdUrjLBotNMUxayGcJn5evA0eo4rmovy66Pxec/SGn?=
 =?us-ascii?Q?cLOgKWWWKU4ESdX8KRMzNucV4TDC0up5hbLReBpHDV/y0nhfz6NXOjqd6uyY?=
 =?us-ascii?Q?Hm1WQfkBVZ4Sppzp3/f4MatrUFNnT/lqaUbTsTY2juYTUO3NTCVLSHqHn75/?=
 =?us-ascii?Q?LO8qPbBAFWRT3iPUHgwolzb/+SnvUjIcFCmObus0/unzaQ5dXFbCJEcf2P5f?=
 =?us-ascii?Q?o5fbHW/ouOegIGcXAinu/b3n9vJPzbJERYMp+qqbVQ0N6eLhVV2nbB9ElCTn?=
 =?us-ascii?Q?Ql4D4/v4hRdPB9wcFu8kEpvI+6l3VM7q7GZDWB8vIRmRmjQ0MRRgc4bF/Hby?=
 =?us-ascii?Q?WqHUKh/rOO1jWHHEPEsm1jnw15GHov1eU20K1fTE2xM+JUdiGyfp+pFP3+4u?=
 =?us-ascii?Q?261NdMn+kQMpQaR2DG4e0gY9chBbFeue1hLkaUYRF+050V7zhAyti+CanW+J?=
 =?us-ascii?Q?hu2ovbYkU+pp4Bixtw+mqdpZhIeCWeiMXbMZAd1tZwme2Jmwf0Lzrba3mXlo?=
 =?us-ascii?Q?u+ArQj/b636QwW5tiWqx8ue5mpg9oflbnq+ywBdPZkOoDtnVNy/S0Z8XrhBa?=
 =?us-ascii?Q?dD28GUC5UnXtXgBLzf55rsBsowZL0ieCFUiBt8j+RR3GgHrec/Ry2lEmq5Ig?=
 =?us-ascii?Q?tHchS0+lhkHD4ncTlH9SFxyDm5jruFSJfjqQ+Ik+l+iZb/xpOPNd0Yy1eA6i?=
 =?us-ascii?Q?Z6z+XQgNiWE/UkvlzttJ3+r2au/dI1tt3CG5Qw3Nn/NztC2wHMKjK3pHIgTE?=
 =?us-ascii?Q?qc8QjqfHvvpO6rIf7kQd2Bnqpv/0t+3NFRGg9e1yDVDXxsAfF/xbvHLxhcZS?=
 =?us-ascii?Q?hHNPHZV+KaKiYLlG0TznYhugA7tJ3WmU++ColGBphTUkLfoQn7oNzGPdQkUb?=
 =?us-ascii?Q?UA3o36/NNFu9+tJIWrrsstGWyfKL+dJgaUMgEuEwTB0voBEEb+JGfybYpxzb?=
 =?us-ascii?Q?USYXvpBpNhskCYr44IfhHVS5W0rD9uFeVA6G1vqsOwZKrcmxu7BVLjSOM6cD?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c32dfd-def0-453b-6472-08dc7f073a7e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 11:13:40.3737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BFCnp0Li+fDGruEQiLK9iHo52qfe4EmUZ9uGH4jDwR/3pzY3SBZ/Z4oCm4WTuednlgluelJsnnVB9/VKHkZfFAQADwR9ewSd8pOIP66awg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7079
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

Nothing in-tree calls watchdog_reset() anymore (that stopped two years
ago with the removal of the WATCHDOG_RESET macro). So that function is
dead code.

That was the only caller of reset_85xx_watchdog(), so that
can obviously also be removed.

Finally, init_85xx_watchdog() is/was also not called from anywhere, so
that can go away as well, which nicely also removes a bit of
arch-specific code from the generic watchdog.h header.

Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 arch/powerpc/cpu/mpc85xx/cpu.c | 31 -------------------------------
 include/watchdog.h             |  3 ---
 2 files changed, 34 deletions(-)

diff --git a/arch/powerpc/cpu/mpc85xx/cpu.c b/arch/powerpc/cpu/mpc85xx/cpu.c
index e8a3e82765f..f3ac0ab0da4 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu.c
@@ -350,37 +350,6 @@ __weak unsigned long get_tbclk(void)
 }
 
 
-#ifndef CONFIG_WDT
-#if defined(CONFIG_WATCHDOG)
-#define WATCHDOG_MASK (TCR_WP(63) | TCR_WRC(3) | TCR_WIE)
-void
-init_85xx_watchdog(void)
-{
-	mtspr(SPRN_TCR, (mfspr(SPRN_TCR) & ~WATCHDOG_MASK) |
-	      TCR_WP(CFG_WATCHDOG_PRESC) | TCR_WRC(CFG_WATCHDOG_RC));
-}
-
-void
-reset_85xx_watchdog(void)
-{
-	/*
-	 * Clear TSR(WIS) bit by writing 1
-	 */
-	mtspr(SPRN_TSR, TSR_WIS);
-}
-
-void
-watchdog_reset(void)
-{
-	int re_enable = disable_interrupts();
-
-	reset_85xx_watchdog();
-	if (re_enable)
-		enable_interrupts();
-}
-#endif	/* CONFIG_WATCHDOG */
-#endif
-
 /*
  * Initializes on-chip MMC controllers.
  * to override, implement board_mmc_init()
diff --git a/include/watchdog.h b/include/watchdog.h
index ac5f11e376f..d1956fafca1 100644
--- a/include/watchdog.h
+++ b/include/watchdog.h
@@ -40,7 +40,4 @@ int init_func_watchdog_reset(void);
 	void hw_watchdog_init(void);
 #endif
 
-#if defined(CONFIG_MPC85xx)
-	void init_85xx_watchdog(void);
-#endif
 #endif /* _WATCHDOG_H_ */
-- 
2.40.1.1.g1c60b9335d

