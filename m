Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8004CC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 11:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6548884A0;
	Tue, 28 May 2024 13:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="AEVboP8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17E8D884D5; Tue, 28 May 2024 13:13:48 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6E1B884A6
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 13:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpAqkWkb64WMvbYlGPAfJdF8etcNd56wI4X2Uyw9RJUt7D0v8YSlABIO5O+ZnOguTQneKGrRQbN6X/JaBIA33H/yOmF7CqyjOda1wBUNhMWp+U+6m1BxetPqSRz8zKe14pdzJctBNBaL7I6uUBVIbD4V6V7qxEKUThicObYMPULWqNK7jK0sxH1c+c86+6INk91COaMLdiMYTULaPWCuie/tuCmCQN29W4Bjf3ErYW9j/nesD6cYUEf2q1+oeK+mMhJCXwFwf0ZJQAtHTymrfUjtsC9RhErs6YIAQXUNgGL/uFxU4JgWfMajOMp1Mgl8qgF+ulODvXC5lBu0+hw70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Foi/+8AuJPWs3rLCd5h1Qz+m2AnePfQfzOFC0z6h1v4=;
 b=OJywI2I1ZJT8pCydAu6DUOT2cZtOd39PE1ZKdzmoUWa0sqKOKQ9TurVcLvlMuAuvre3JJd6UQQ4HX6V5alEZ0C0ERcGxDwSqiNXfc4MeVkDXpXKyqmd82hmrFKRtB1CQLj4Fay+VKVhh1WaUIBTePmcZsZK2x4K7qjHaRoEG4oil09zFZI4D/zFFnMT8f9hFGonOk7ZKc7UKT40fEPaY90OnFBTdza4t4WiOB8ZL5vt1X+Bi+c+PUjW3mgJ/K18h5AeYCchiX9+WQFu+TvuaGUHIZ5YzMGPDuUIbwPnj/YiPGtSx/9ef2SZYj1FiMMSRQ/htAGc+xoEW8gjfFtqoUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Foi/+8AuJPWs3rLCd5h1Qz+m2AnePfQfzOFC0z6h1v4=;
 b=AEVboP8WuXiSmzqpAJca9ZG57mxFD8mCTqa1lyzUElMJ/LBOfNnVISpdEMbWwQ9mqeaHAy+NdvL3PrEbPy9wJCynOUs6Rehwlnl7u+9Qd9BsG3HjUCllFFt9Fxb0mIidkLwBPo0yhVkXChy0gnP6tt9sETk1tlbQbDlMJDlWIM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB7079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:df::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 28 May
 2024 11:13:37 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 11:13:37 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 2/7] wdt-uclass: watchdog_reset cleanup
Date: Tue, 28 May 2024 13:13:20 +0200
Message-Id: <20240528111325.2163560-3-rasmus.villemoes@prevas.dk>
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
X-MS-Office365-Filtering-Correlation-Id: 694e6549-ae46-48fb-1e9c-08dc7f073866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|366007|52116005|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eHaVohIY5WTrG4Xqd3ExCugIvR75ueqf/T7/ntrbCFQMoKTIb+4bN1jDjH/F?=
 =?us-ascii?Q?JYBMyTxRu7OvD/36upaCqKcDC8tu5ImGNA5yUwdTjR4Cu19Bed6+E3Ram+cv?=
 =?us-ascii?Q?TpOj61SXuq2I4Vs186uLE76z5P7hOvPk6NzRZt/uw4eKb8jcLIHLc+TXJZTl?=
 =?us-ascii?Q?ar2zCbAAxJiPp9T08jvRFtiN/hNDQ2vqyG4hU7JeZG3Sr/CVW/VOnUSH6ibp?=
 =?us-ascii?Q?zmj5MLJnftjcYjPnGEqLEFtERXN12lRv45wiN9MpMjKJhMLXaY5my7YLzgka?=
 =?us-ascii?Q?sDN5U1YE+pXcPtfp6X81CuBi462t1VAINYJY1eQen7Of8vPNc+ttBwKcUWzi?=
 =?us-ascii?Q?zFj5xPBHMBhWWEoBrIrmSwEWw+9vPe+dOEy9fZM+tw2QMqV3rPyP6UK1nu4Z?=
 =?us-ascii?Q?Gyfy3SSyad/GO0d0lWbRzUVqy68DnTabbQ/EqUG4NckvXcQaZdfhkP66pqxj?=
 =?us-ascii?Q?l2ZzapWwWOhOE5T8kwv2v78IEP4NIBdyzrhpXs9Xzq/4jH9C0yCIjY4/ReEI?=
 =?us-ascii?Q?MfZIkD9eBAlbCjGqGjGRSyIFUGaSWfgd1jsMmcjOqfX8tfROF5Z2czk13O2G?=
 =?us-ascii?Q?5DmRI6nQ+IOt2MVMqYlw6SKW/DHmEAE6IvF4epvf9P1f1w98q5OpJPvwp/p2?=
 =?us-ascii?Q?HurYc/hAaQENrqSMcrnztIX8Lt+ya1RN8E0pHjbLmbBv4A701o3ma5kwpoWo?=
 =?us-ascii?Q?XzHOzdou9CWEp5oYUxIQVv/qdQ3kwiNIY6uKUgYitNLnwmPHkZq06VBfP/NG?=
 =?us-ascii?Q?gcAL6p74sQxBIXHdmfgnBy32JaPVlIYM3eBrCTKbeE16iyA4BdimMp9sd4+M?=
 =?us-ascii?Q?g6xqHf3eZHiWuMs1Q5edf7SmbOCz0Ugla1urj/6E+mOOFx0Cxqk6YQwGt8yC?=
 =?us-ascii?Q?B+cu+U7Fsba0CNBaueR6L/gmUTWTwmRADCHHntMSDtLq0RDZu4Azcq9zUymw?=
 =?us-ascii?Q?or/YaaZ+BsQpJzkBNI0kCvM4hFEVmVXAss7Jl/p/SuQkuKZgnQvD4K06n2mG?=
 =?us-ascii?Q?woRxipKskfCMzJg+pSpSFwqQ2B6xEigZZwvCy9EdVNbbxi/R+JMoVwvdEKji?=
 =?us-ascii?Q?jfexAEuoLIFgVvI1DSIiMnlJNIBAJGOSGYHspnGlh+7LkM20mzpgaCRohv3p?=
 =?us-ascii?Q?dgS5eZOK1xs59mzX167MFrCC91GKgrfC/81WXNg2JOVUikNrtrLF5gfIjrmB?=
 =?us-ascii?Q?g5dd+27xeGiw+6H/YIlzhgqqHGeQYojrwKVW5srC23BRhoaKB1ThhS0BvCXa?=
 =?us-ascii?Q?wtxt4jjVPS+z/oyeXStM2ea4AoVqUJkzCjEtspHO99spJqO8ONigwPT2EDk8?=
 =?us-ascii?Q?v9NiBYTSldVcLbcK+TAY167KDAY3scPsHZHIsvczeb9vHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nqn4OMfnllTVYLIl7uHakFJRyLQkkp+1BvhmiNvO6XsPHSreR2xS2tNaiuI9?=
 =?us-ascii?Q?bhoBHXsBwP+sAdHh1U5A1EeSocPd+/37zx8gOlnnO9Mo6LNqPe0tEAYICruL?=
 =?us-ascii?Q?dAkimx10NDt1c8UmqIoPtzfbrKaex8R2RIFwww8Powa1X9ZzcE4wI2CyFzU9?=
 =?us-ascii?Q?N/+BqFxt4r9/MAI7g8QjDdN7kqbLw9mRYuzvUIihmZ1NEiTe5zXBJCA1F8f2?=
 =?us-ascii?Q?1G6LLxbCptw+m+dcf/0DzGxxxDLgEQN6RGzlaYpDZFFobagjEj+TowFXb7zl?=
 =?us-ascii?Q?VOxueO53lctiSz+5SPf3fVD2KSIDbG3ktWbNXYlGB8+PnfOSwx+hIXLLtLXL?=
 =?us-ascii?Q?Z7JhXltd2IBOuuhv0AfAwiUlBN+whWdUr6D181ol8rRbDVr9IEhdcwa52Wb4?=
 =?us-ascii?Q?pBylonvg2/NrZxNIPLV4pd4cmdaNx8igM1+v3cvL3RCwfXXabuzWLNGqUylW?=
 =?us-ascii?Q?AClcOgULyb6tHHBl2CpyW8c4txChmv7Gokn50Z3JMA2d/wCnxVv3grCUsCvq?=
 =?us-ascii?Q?25OYCtcWIucOnjI1mJ3a9RQE+x+f6Ewq4GzXEX9LLcYdjx5Mws6dbA11yM6S?=
 =?us-ascii?Q?a/ugg5bbUbXC8gGLCI7N/fmbOFgYWCgOJ3l/Tm8+skZgKpTDSpKH1TCHKjza?=
 =?us-ascii?Q?LTGlKdpN1VLbkEfLZf2EE5jItwHdFgCd0MY9Ls3WZkVJDLTf9f+mKIeCotlf?=
 =?us-ascii?Q?O73cIZFyAASgnWx6cf5X/UXSCuelndcHBiEk+xcGF4q4xy1l99rFED4/F7/Z?=
 =?us-ascii?Q?gBnw18HOavW5pvw0TL5teDYXZhUtFTMPczjzhnLXOkaPxP370I901HR3ae/q?=
 =?us-ascii?Q?cj+vz57c9cS1TDoWJvuV3qXOk1cpULAdwjbd4Zq4HXD5wF2QxSnl2dn9abyH?=
 =?us-ascii?Q?KP+PnuP9/x3SvGbry0IzX6jZPf/4IPFO5en8QfP4cq26DxaXkUZ8fFZzRD3q?=
 =?us-ascii?Q?1hIVjKr+l1eSnLuuuUlI/gLgPpuY++tuNnrrvZOXJx1VMPf/St2APWY8UfsV?=
 =?us-ascii?Q?zNk5Ijaag/FzPDRl8uPP6dfeJk00v2YQWqwig4+cfoX57CpvMVhg1vLFZexA?=
 =?us-ascii?Q?2iuiTggltH+NFTPQvwdsEpjDaJnBF12Pe12kVS04cezn/0V2qBP1S/TRii3a?=
 =?us-ascii?Q?p4UhITuxHs86qUQHc2AWksx2Hvy3538epnxcsdBCrsLS/gL+vEnf3Zy0dNn9?=
 =?us-ascii?Q?9SxbJcUiIRd2IvZzjOYQEmoO1JkAqbie8GtAMzUKFxjscOLE7ezO1rkyQISg?=
 =?us-ascii?Q?jlDQqzmHkzsH7JOrWER5pGwkRcRaC+mG5VLudB2hPuXwACpk/igsWnvgQZe7?=
 =?us-ascii?Q?i2HBo7H4sSsJX+ndB3qpYcMEbFUEd72uayAnqz8w+NpJ4uRebEkJ7RD7MMdN?=
 =?us-ascii?Q?zSo79jVjcCMFwhf3W3eyrwGiAFZT5fgB6cZtUKf5yx/AfW22qgfnrKO/0Fha?=
 =?us-ascii?Q?Oi+B+c4H+2eZcJcd3hKYx/4lGAu/rnlHcPy/e3FZ3u0eAPb9CnQ3KDVm7teH?=
 =?us-ascii?Q?iV+xT0kh3kH+/AGdnLLF2XVpvJFD+E4CYFgAjHhheHiI/qngz3fWk3jMiIWm?=
 =?us-ascii?Q?90xdtntdLhLtlV1AHTtCfz6MlG9toSjeEdFeduWuZH3WL+GBHFbw/umlgkbd?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 694e6549-ae46-48fb-1e9c-08dc7f073866
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 11:13:36.8856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUi20FxJB3AXe2Rjb3MG5R6BpxwfigGZFcYug+f9xTJYB4XrXWQhro9Qdf40d17hXI4gCgLheSgvcJzOYeMgoaJuufgYRozIHwF67QWAHXc=
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

watchdog_reset() is no longer called from anywhere, so we do not need
to define a dummy no-op function. Remove that definition, and update
references to say schedule() instead.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/watchdog/wdt-uclass.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index 417e8d7eef9..918f31d6b43 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -28,7 +28,7 @@ struct wdt_priv {
 	u32 timeout;
 	/*
 	 * Time, in milliseconds, between calling the device's ->reset()
-	 * method from watchdog_reset().
+	 * method from schedule().
 	 */
 	ulong reset_period;
 	/*
@@ -222,21 +222,6 @@ int wdt_expire_now(struct udevice *dev, ulong flags)
 	return ret;
 }
 
-#if defined(CONFIG_WATCHDOG)
-/*
- * Called by macro WATCHDOG_RESET. This function be called *very* early,
- * so we need to make sure, that the watchdog driver is ready before using
- * it in this function.
- */
-void watchdog_reset(void)
-{
-	/*
-	 * Empty function for now. The actual WDT handling is now done in
-	 * the cyclic function instead.
-	 */
-}
-#endif
-
 static int wdt_pre_probe(struct udevice *dev)
 {
 	u32 timeout = WATCHDOG_TIMEOUT_SECS;
@@ -263,7 +248,7 @@ static int wdt_pre_probe(struct udevice *dev)
 	priv->autostart = autostart;
 	/*
 	 * Pretend this device was last reset "long" ago so the first
-	 * watchdog_reset will actually call its ->reset method.
+	 * schedule() will actually call its ->reset method.
 	 */
 	priv->next_reset = get_timer(0);
 
-- 
2.40.1.1.g1c60b9335d

