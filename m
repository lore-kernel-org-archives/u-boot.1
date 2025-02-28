Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2C7C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 05:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51C918083E;
	Fri, 28 Feb 2025 06:00:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CbwyaIJR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C35D9808B6; Fri, 28 Feb 2025 06:00:47 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7AEF807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 06:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPAR6HBDJoim8uAcUEnUeWMRdKv3zdKL1ofrEInjlDgYv3KWdEKg6TUcbFXzMONVaZCVady8aDlNaEVAZky4BKdNcXf1MJ8nii1UMsTNPYcGFEi9lsi/p4tXgzQFef9vjnbBvAd2r4CwvOnc8fu/I0v+V5fgSqaUYVpvIKE9aZCH+OLb8iJulewI8wIp/Qn7XvXxROazYigFghEd2WdHiRSI3SyI4i+wg89Pif9muNVxyGcmcklOPGrwB+1QS7wFvQcaS01Gn32BuSJho5ynow4uGdWgEUz7f2m/LJxRREgVM5RNZA5+2wwZNK1tLIGeigJWYIhrMOaWF6I/z4LTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhdVovKF6Wf3Yovw6IonzBH3I2CsB9pVSFQWFDEPymA=;
 b=YsrR105p5yxYbl5rG1uCVwrHCgMpFmI3jdQyQqoghkQAMQjUn46SLXj1cg/tnNEl5Q1ytJ4aqdmiDV5VLINktaQ7VNlANMRT9Zf61zdEJmpAU1qOAaKE3iTJ9WHW5ursEuJViNzYAXhMDeLxSUFxsZ2ULDmWzRMgVV0/XONZjnWEXm3D1Sjw24iB6oE9ozCiuBOvRxEbog4YrPggQfwSItx/03CnrKxm9KodXqMyvg8gmpm3uPrZkt2BIE/GNdqZ8w4QrBePhUeEx0kdt1DEBePFUdKbmD9k8uweZn8eJgJZiNrFIrTIc702obiUgENMAKP5ZionxN+8+8sT3f1IJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhdVovKF6Wf3Yovw6IonzBH3I2CsB9pVSFQWFDEPymA=;
 b=CbwyaIJRwoZzWA8d9zuDAGOWHeI2seV6q5uhw9wnRdQU6GBeDYm5LQ/FrunpJ+N306sfQBExVaAAZYKqOILZnRP0jSSRdHXtFdy1q4ia2T1/UPKpZYlvx7ZzNWAbUrovfgULXVSDhYy0GRF4gkQXhVCGbasg80ZI2M+8GnqqTkJlzU60E0omp0sVJV+4CjI0dJHS9ZvxNodyNvsNysu4b34OsXKIpanMc/1JJCpRQ/2S13JHzI9r11qaXpSkUtVWdiu2ozjISWS0h1LDBgosSdX7FeNbRBLRVCG3EkFjsaASo/dpL01hDFCOvhKwsQOqfnT+ZiQ64bCjpzLtNQpeoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB11044.eurprd04.prod.outlook.com (2603:10a6:150:215::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 05:00:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Fri, 28 Feb 2025
 05:00:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: olteanv@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de,
 Benjamin Lemouzy <blemouzy@centralp.fr>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] board: freescale: fix LS1021a build
Date: Fri, 28 Feb 2025 14:07:59 +0800
Message-Id: <20250228060759.20759-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB11044:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f796001-6c1d-4020-3fb6-08dd57b4da55
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FiGHNBdsykE4DzW7+Z5zHaT5fC2HiK1ODUTbWPc5fyu4U2U8A+VqTULZ5IOr?=
 =?us-ascii?Q?574UB9J/LIO8NAK/VdGWWs2dpusnh2oOUfGJKxTlX2L2MMqEkIlTCaKKZCq6?=
 =?us-ascii?Q?5YUTafjwc/XDWgfM3gRg/sNqj0igzwOQZNl2tuaBj34NY6pwSVV9d56FqTnP?=
 =?us-ascii?Q?YoM7OwUMPfZZbUXxyqqa6VSsY7cZiFOHm3e0m7eo425409CcASiyEXjUVyMz?=
 =?us-ascii?Q?pJpkdXuJcwBfkZyq3Vss00dQd9XTXEshtdsFOEEUKa/YSDPUVeN2aXmfMmFf?=
 =?us-ascii?Q?+M738qYuRrmTFDWTapGbgeetEYWs3qGVGizaiIhk4wcBcavJSxwctbnjm3Ro?=
 =?us-ascii?Q?yMKQzQVRecIoyv/f0iDdlXIfXrfz/ZbRRIdDEZmQPPedhG2sV3TrCBLA3fH4?=
 =?us-ascii?Q?323CjLr2IcIEFjNskHo8nER2w1ddc96go7naY7E/p4QpDSFriJacCWQ3nE8n?=
 =?us-ascii?Q?roXProWdbcXqtOWJfdtpT08V+tcoOWAtMlJA4JBYiEvp6YKK4jbYNy+o6yyv?=
 =?us-ascii?Q?pNhsLlmplJVcxoCe7UmF3wZDTm1oC6REu2VDKu6gRYmnNbwb/Kl6GHr5OXnS?=
 =?us-ascii?Q?X4UR8oeIkyBFOYOzxD1fIlTLc5AYMJsx3xCVgM4l0IEdcie/ytbalftQvkJ0?=
 =?us-ascii?Q?bIH6sJRlqMhtCz13NLjmCYGemsps9+Ziz+SfcgD2KSLRXxSx3+1iWvOUXtiD?=
 =?us-ascii?Q?JToOQQsa14A4UG4HyucXaQtNBby5T47zMJfMKT/sf912C/7KxAkx7cnp1Zf+?=
 =?us-ascii?Q?1rET4tbPEuevSdHzKUvPGamWDv9453gbKBuhaz5y/5p0F9nCbc5JXNpKf+dz?=
 =?us-ascii?Q?YZqY39A7ygX3PnHjlFApbWKB7cNIdmheqUOK9aEGyxeG3D4YeGHtjVuSXHxF?=
 =?us-ascii?Q?7GhNJXqbhghHBGuzeSP7EkkSE3LFcLJe++2g7bSt9AzRPFBqmDLiI5v1Iuv8?=
 =?us-ascii?Q?k7Y/EpmTdosx48UmeNVvV+nIo5kE3UC7ARzD4YjO/EMpB5ymyh3923y9DfbO?=
 =?us-ascii?Q?+VLGUuNYUhD2BZiiXbd8NThyyKgVPopkNFCsfoo8VC094K7f6juKuBUNHcEi?=
 =?us-ascii?Q?ohPKpz3cKhpguQxVFYU1hjAdIXy4TQynfA6Jxq61iK/XDYt1+FjMpDleZEyY?=
 =?us-ascii?Q?kNtDKEAMZEmeTCnxjHnSvtZcRQ8oIYTD/8qwwFeayBV0+SYlEoowNqV/RYas?=
 =?us-ascii?Q?Q7FtgTwFr+PN1h5BAqZ5Ji0+Jr+Lpi2BOYqEX429/Tze8Ljz3atqX3T8fKdS?=
 =?us-ascii?Q?XLtsF4fZTrWqHdB9m6IwiGYy0xxtgFT/CSQfYKVg8+1tTWsEUmbTaYInfxut?=
 =?us-ascii?Q?huyC0wbxTWJB8Hyy5gAqA8TjW+Kpm14nT+zH3YXlnd9+PyueLfs6rPCCW/WX?=
 =?us-ascii?Q?cLgwLbbsh///M4nrtx2zlfguY2IlE/0f5eL4bOMRcOCshOswKohPATzOE2ZW?=
 =?us-ascii?Q?/Y96XHxfNtzxelAmAbKnEn+5GdBVvHXE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eyCjF89oJbp0yH5mMO+OQTXvSTkDOpt35J8vCKKefZ6ZtZhGwozhiGaBA1yb?=
 =?us-ascii?Q?WjUJe5pGoOXXzHQ6RB7qG0PzDX+PpTQxHuaqTActrBD1AEWng98QY7vMM0Ej?=
 =?us-ascii?Q?BumbSDluva14YyP6jbqbGrwIhg0QmBQxUsodmUNUbIK1iICACGxFNls7w+Sy?=
 =?us-ascii?Q?O8gi5v6RURS02T4bpMdPWeMd80l0UAQR0KxwNwO3GtcfyNAkgQVoxFwpvM+r?=
 =?us-ascii?Q?C7HQdfzqj+zmWMDUeFjMblw/vH+r4IxxIHlApOPX7O9nr7dSzVKTn7mHDqD+?=
 =?us-ascii?Q?bqZXURQ6hPjpPegmUxwQcQLvunQWaBu+m3cadeUPss7b2ISr8iAStFh7kdBu?=
 =?us-ascii?Q?WxxtHPTrhDkcqzDli48WfbsHZQz/JB2HzWZerV+FrK1qtno5o2ugd05Sf2EJ?=
 =?us-ascii?Q?YTFHiOzRam0zzrLZRhZGdVcs++HGSDaFPEc2YnRkHOnuXfI++nVhD/KCBp3b?=
 =?us-ascii?Q?lIGrIyaw/vWfutDis6zXGseJR6gRIIQV8JZgLE2b1ewvBH3dGKAA04zjYMYE?=
 =?us-ascii?Q?lL3Q4NlqgeLywI0zJdQ9o80vIwXADxsQy7bZlzLB58dIZ4XKjtLdROPJAGWL?=
 =?us-ascii?Q?tkVHvt17DdHaMu7VCpObr4ISaditJ3JaNeD9LkIHl5TISA1PDHqf4Qw7/HnR?=
 =?us-ascii?Q?csYx9uVPz2sw2w/CpHTIirayH3cXTgM8ZSbAoNNZKZzoAxAoYuGGjXbt+eek?=
 =?us-ascii?Q?QPqNs5zxLdobZX9Tff1SNBQwa2ODCVgb2Q8Zva/xiGT2mFhdXwZSgqO21byY?=
 =?us-ascii?Q?6mJN7Gamieaeo1ARwORZPh/ZsNMb3N+RTvyCQ9LL73zIRKvtVmivUCNAAz5x?=
 =?us-ascii?Q?Qm7xsSm86PCwdvqvx4TAwB0PCaPopNU7YNLk7oogcBrok55v/ESHmR00fDRE?=
 =?us-ascii?Q?VTY+6KJ1NRxjxDFuq5XixzyGewt2ntS0XuML+xon6JXLlXehRqgByb1WBdMk?=
 =?us-ascii?Q?4b3avXlvzCD9E5WWA6zW71IAvHDAPo1lt1x4RNx9TnY25JjApVvmz6HfOaX7?=
 =?us-ascii?Q?h/iYF3Sx3lR55KJ92mqgWI8EirbxhhgQzSrtRtEx2E9HBMWZxfsFYGdKgvy9?=
 =?us-ascii?Q?lCj4GR2jUr3uADK/F707y6UXGoNe7VPpbUCM92HiqZ20ll2fuY3u4KgTMFus?=
 =?us-ascii?Q?XjBVUe0o+WjYFBCoLrUU5ajkGqsKJbFxSJdQylCcpFlo/GDzMEYwBlFYt+Mm?=
 =?us-ascii?Q?Gmcywl2E/E18ugEr/JS5kc3jZgzNBH4CShSJY7cQtxQ3pdXhO21Ye0y0A7v4?=
 =?us-ascii?Q?zaMDh7O0Q/ahBhWlcw1mwq/cSfeNMNbclbWbCODMIs4CNs6t6yglGX7YZf4E?=
 =?us-ascii?Q?RmqRcZJsmXesL8olIHEyjemL9bgiZF4EH0H5eJE9AD5W52MsDCc4Q5MJeN0G?=
 =?us-ascii?Q?kBUUxXDEOEOgITl4G1uu6Qb4ruwiMcG2qoqZka5zn6IAloBbRLhNDi3JT9BE?=
 =?us-ascii?Q?6NU03bGoBh/1NmYNh1d04qiO9aMHcBikOhMdPoqnNyWqn8IzxsMdRjOF5D5f?=
 =?us-ascii?Q?m7UuGLYOahdHEZRFk/4Lj+QGg9zdPcv0GsiZTY7MxiUA2yUMwFoGrrgQtUZg?=
 =?us-ascii?Q?z39HJCeoU8loIAlttAmLq2q1yosASl2s9XSqWqzT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f796001-6c1d-4020-3fb6-08dd57b4da55
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:00:42.8833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyGUdj5DJvakTGKJiyaDhub2K1fLnxbLWyTVmuYCjWDYmN48fF4at5091Grn6Xhb0gkggtpWe1Nau7HzAkBkuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11044
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

From: Benjamin Lemouzy <blemouzy@centralp.fr>

Fix build error "undefined reference to `is_warm_boot'" when
ls1021atsn and ls1021atwr boards are built with CONFIG_SPL=y and
CONFIG_DEEP_SLEEP=n.

Signed-off-by: Benjamin Lemouzy <blemouzy@centralp.fr>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Use CONFIG_IS_ENABLED

 board/freescale/ls1021atsn/ls1021atsn.c | 15 ++++++++-------
 board/freescale/ls1021atwr/ls1021atwr.c | 15 ++++++++-------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/board/freescale/ls1021atsn/ls1021atsn.c b/board/freescale/ls1021atsn/ls1021atsn.c
index d1acccec110..c92430c0896 100644
--- a/board/freescale/ls1021atsn/ls1021atsn.c
+++ b/board/freescale/ls1021atsn/ls1021atsn.c
@@ -166,10 +166,9 @@ void board_init_f(ulong dummy)
 
 	get_clocks();
 
-#if defined(CONFIG_DEEP_SLEEP)
-	if (is_warm_boot())
-		fsl_dp_disable_console();
-#endif
+	if (CONFIG_IS_ENABLED(DEEP_SLEEP))
+		if (is_warm_boot())
+			fsl_dp_disable_console();
 
 	preloader_console_init();
 
@@ -187,9 +186,11 @@ void board_init_f(ulong dummy)
 	 * it from SD since it has already been reserved in memory
 	 * in last boot.
 	 */
-	if (is_warm_boot()) {
-		second_uboot = (void (*)(void))CONFIG_TEXT_BASE;
-		second_uboot();
+	if (CONFIG_IS_ENABLED(DEEP_SLEEP)) {
+		if (is_warm_boot()) {
+			second_uboot = (void (*)(void))CONFIG_TEXT_BASE;
+			second_uboot();
+		}
 	}
 
 	board_init_r(NULL, 0);
diff --git a/board/freescale/ls1021atwr/ls1021atwr.c b/board/freescale/ls1021atwr/ls1021atwr.c
index cc9665c0410..0758e5eae25 100644
--- a/board/freescale/ls1021atwr/ls1021atwr.c
+++ b/board/freescale/ls1021atwr/ls1021atwr.c
@@ -417,10 +417,9 @@ void board_init_f(ulong dummy)
 
 	get_clocks();
 
-#if defined(CONFIG_DEEP_SLEEP)
-	if (is_warm_boot())
-		fsl_dp_disable_console();
-#endif
+	if (CONFIG_IS_ENABLED(DEEP_SLEEP))
+		if (is_warm_boot())
+			fsl_dp_disable_console();
 
 	preloader_console_init();
 
@@ -438,9 +437,11 @@ void board_init_f(ulong dummy)
 	 * it from SD since it has already been reserved in memeory
 	 * in last boot.
 	 */
-	if (is_warm_boot()) {
-		second_uboot = (void (*)(void))CONFIG_TEXT_BASE;
-		second_uboot();
+	if (CONFIG_IS_ENABLED(DEEP_SLEEP)) {
+		if (is_warm_boot()) {
+			second_uboot = (void (*)(void))CONFIG_TEXT_BASE;
+			second_uboot();
+		}
 	}
 
 	board_init_r(NULL, 0);
-- 
2.35.3

