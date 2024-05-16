Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA63C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 07:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C2E6880F1;
	Thu, 16 May 2024 09:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Kc4FwhKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A315387FC7; Thu, 16 May 2024 09:53:32 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1745F880A3
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 09:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5aYEF2G13YF3upobaw1tf5P7gsQemtX+GjAjxHKeGGWk08okV7UuMXsfUR5g6AK4lD+d9VQE4lHSDoU0T+R8W9lOCLMMChhgWJQ8jMxVl3bfFTv6v0vfxMbv4eMyy+rHly1FoCaOTbltQdzGrF+cXRAW5lSo1OEqM4SKr5WHcqsdwCQJCWqynhqGZfi1lSMo66Rnl9/IuRgnvPUTweMrpu5IU/RFy0A83Py1MeKjItVtbOSGS17dvBfMmdyfAwPBvsFr5YBk1CNbKqPUG9qQZSr9JB6KGtko/bKDU9IlRMFy2bO5IDh6vHEFU8VsXPGYr/mTXd/Yo270hUBlxOBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2nB+T4/zRGVvOJMKu042tyDRoQkadALfppjUa9tUfA=;
 b=OFyWyAHeRxDcfbkqCWPO+HEqu04wW2fkKZP+b0LdTGx0K1Z+ABnX4bBqhUC6ShID2y5XTYODstR52xuaSlz4SOTlCV4jS+eC6BY0DkV94ac3Y5t3KzU+pliE8LLmzf8SYSzCZP5SP9yPEWhXDjnPZ1JTFjJ3KPkgdauJTjzjBvQr6Fsb/McuDGtMqy9ge44RPideQv7VPWb5VWWak+pHYYx8ocdZQo7iNuDgSqTNNyBnBK47x6y6UDyDJxr/BtVDBEpcMTUbjHcBcCHqg1/SOrOmBMQ/Rl12PSHZr6X3o5mAqnf3bVR8vphQMYPpnQnKob79xH6ZkiWrwbqFvR40UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2nB+T4/zRGVvOJMKu042tyDRoQkadALfppjUa9tUfA=;
 b=Kc4FwhKXSHHwghqQyYKz6s66UJpwdGoPr79z+cZVqVswpP6b+dvLUlEWtJHCrSYIpuL065Q07WcnGhwwcBwMvhM3d+fSa9SriRFePrg0JeLpZv68okyT/zxEvvHF1p04qgv8x9c/v7sr+So6CazYythUbtBQt0+h7cwPOGlbevQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB6752.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5e7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 07:53:27 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 07:53:27 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 2/3] wdt-uclass: prevent multiple cyclic_register calls
Date: Thu, 16 May 2024 09:53:13 +0200
Message-Id: <20240516075314.1548051-3-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240516075314.1548051-1-rasmus.villemoes@prevas.dk>
References: <20240516075314.1548051-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0008.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::30) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 86715b51-9f25-48f3-ab5c-08dc757d4565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|1800799015|376005|52116005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fpMYbMPtZLGmPZK2Xc3YJmEin7QxSHa95h+1WzxLF+098f7nPNzUuzscgl1c?=
 =?us-ascii?Q?87ozT+HVDa9HE3vxEO9G5i62Xpv8jXUog41CPWU+74IxTevEoV6v8swlSS9X?=
 =?us-ascii?Q?PYtP5qKppMwBAdmQzZWyNMzF7nSD/p3pxYIm+2mn+DJYS25hf87JIGpe1QD2?=
 =?us-ascii?Q?d85jw+uzu49yHXza1/1NM0u8DH5OMjovj4brQVdn8fkFLXL0wE9oCEC2EyWt?=
 =?us-ascii?Q?3d1eCs4FQTTNilL16wW2kp2sdQfq7ruXwLsSSsBUiK7iA/Mx+eSuv8vWgvYL?=
 =?us-ascii?Q?Z0cphnBFUBy/Y7tBPzT5VPwI5KKVNEawHLGQj/uNZFLDDaO4DNb6xfAQOrDN?=
 =?us-ascii?Q?UPfDXphIYhuzWPmn0ghR3JhL7h5EPcokrxCDguIeSihA2KxBP+RIvjHYOXF1?=
 =?us-ascii?Q?Bh3/m82UjF5urzxjZ0u3cAZ/Rn27VP/OKTHumMIIZ4LXXppl3w/gua38Der+?=
 =?us-ascii?Q?WSxfSA9fg4NuPnwNmdvDi3rs/GBdF5OyxYyygrWRVhfuigCsX40MAnazCd2Q?=
 =?us-ascii?Q?9TBrlNKGLPadB2PsbSg3vohGrU4Kwyt7ljFwAg1LPxOIQPG/L9uxzVxsfz7w?=
 =?us-ascii?Q?cL7LCRVnShTXEJ6sDfl031f0DYXwsMfD4vQuxJK5pMzWXyFLGmLg2N+Yb2v9?=
 =?us-ascii?Q?GYpEN4wQm1Eht2W6IDYzWyO0NwebvUftSKr84u4LuPY4yoQjfy3pDikyI74J?=
 =?us-ascii?Q?v+xiIfpf81PPwufy0yP5yKVhc9/GCqeURiTnHzMx2RBrJj3zaJdmQmoDwLv7?=
 =?us-ascii?Q?RGwNVR3qkfnm8IOWYSJHwzBhC2HizYZxJGD2Tg0oq9jg/AM1oahPfeJ51eGG?=
 =?us-ascii?Q?GC0CWgnEba8bps/IO3tVupt3oONztqPcovL3NjHeqjGW5ykAPkfkCRTgmEB3?=
 =?us-ascii?Q?S58gyN31FBjLaQ19I3ZDFKS1OH1PyDkzukdv9TgJx8ItqzcLQNmvyeHC+RmE?=
 =?us-ascii?Q?K0ObIWDhcAmubNLqV4ZN38rEHZtztumVjyx30XhGIAI+jcj3mGu1GwgwnMrt?=
 =?us-ascii?Q?97uOnSkS9hHDEW9AW9iT0VgGsC+N/PavW5RIPHoqExICX1oBeyImjjq1Ym37?=
 =?us-ascii?Q?WDrwOvb8/Wsd8yzHWWoWa64KTBD4g7a1pcmY03Hr/w7c1oEs3kEgAL2TvxV9?=
 =?us-ascii?Q?mYoBV+6StBWuGqmJ4Gwd+qPSRmv2TZFwJk956O9e1HD7P4R9CMxZ1fjggWYr?=
 =?us-ascii?Q?oSuwtcwtSAYhAzyRqT5QEONZq+HK7xjTW18N86tTR8c/Wx3JemaPNTeIDx2Q?=
 =?us-ascii?Q?puzZjffpDVEdRJtnUetH9kysYDoPmbNlmFhiKCT/KLpowwOBJQrSGAwv5P7U?=
 =?us-ascii?Q?ojStd8UdoomJWY1ZDbfVJB6jCXkY/+Yo2SZmB2ZO+ZTeoQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gz5PLMlLszClSKdPv+Gz4MefYv4ILaUZa0ZHpGhcl8Lmu5MMLOgD76UFvYWF?=
 =?us-ascii?Q?QFekkdlVVU9WRaRlOVzkhB52c3AIgl6qhhBF8wRij7EeIArppJKewB28JkSU?=
 =?us-ascii?Q?rCTBKI2AzZ4w+qkBECtOe+wJIsWjSlyb8xi/H3yWofUG+QhTNXYOYxebUqih?=
 =?us-ascii?Q?oXdXbbxAszAkwX3SI68D5EXPqN2Tu3rObKJMivig+KmVbM3evuEk2mgT6soY?=
 =?us-ascii?Q?J6lSFqCx8mWE+1K/6/ICbzWrU+TKorNr289tdGbrKaW46v4hQrvseELOCd3I?=
 =?us-ascii?Q?O1m/L7crpVaC7MJMRI0EcoPYcOR0Wb7pH+gM9XwSNzvxnTb/b4A9MWTwbHYq?=
 =?us-ascii?Q?l8rfgX55ZSWWG6IZhR11fk1PoRXYhOGXSItsA5Wnb3gntOaWn16/an3/v8RY?=
 =?us-ascii?Q?jmhAjwvE6PYwm5ebJLJXha7J6p8z2oLiopiDCSaa07ZcCZdLuQ43Kk8Tw91W?=
 =?us-ascii?Q?ckZTO6fG3COHT2vIBMhDvfTnu42eJ4cXu/KHOAVVbf3oD3hU0DnruKABPumj?=
 =?us-ascii?Q?QalQRAJ7SR7fdRQshGgiQcii4I3UFAAqOcPyubVaX/AUFV5ATgFNKS1fZQPd?=
 =?us-ascii?Q?Loz0rsYfpLEecjWFhvoDcvma5/rIfCfCOr8V2VdFpxqKbric5mAMLFpR1OzI?=
 =?us-ascii?Q?ukz8uRNa91bcfgQ99zN8/bx0ySCnKsMMkAXa9lG+Tsr7/Eu2WXrWcptsTNFN?=
 =?us-ascii?Q?JRl2N9urSXtzltvyqXH4lxU96seq7Nh+yl34XNL+grJc5th931nkreqbm+4F?=
 =?us-ascii?Q?iIsqfewERSHvvk4I5J2qUnvgkBZQaHvg4kpRcLoDYh2/6WRgXE30APNKnOND?=
 =?us-ascii?Q?9+1zNcR644Ij64xtPq2Zn6utqG/JcGxU3YoiVtP/asAD0XSjfFbphyksYtzY?=
 =?us-ascii?Q?cke+WSy/k5CH41Yc8Y9CsFOboml+xgUzcH+5c/J0R0mRETr3HfXPybfV7XIb?=
 =?us-ascii?Q?CScBtWjkl35YSUBuqpOakZ4bR0JcqvH9f7KX/I2ss4m4fLSNxfiTKiZfc6mw?=
 =?us-ascii?Q?6gIAeZqHDNw61zh0/9AfpvwBGi9KkGZCnpH1P2X1Jn2i9emTdLREgLlmy4Ea?=
 =?us-ascii?Q?pn6hNiNqs+D9HAu7EKIDUi+ShsPXe5Ah/nxY++V9HChd9BAI7zxFDtvpOEEy?=
 =?us-ascii?Q?9jhR1MniqO5Nx0MCkiL1J1himaBB0JMyWZYfPRTOooyqfChULIsAPEilO2zj?=
 =?us-ascii?Q?IAXa6hwslOCkKSnbEfHKiUlxhUFXVFkTZSRz8xmBS+6bvtR+g169W+fCuRav?=
 =?us-ascii?Q?BCs0oFmrd2lTala6hOCxQYGjtcYYI2W+1JjBqEZL6iGqnE/cKEymzhZh3WK6?=
 =?us-ascii?Q?5kX/l6RiqIKBJp35hiE7+pAL5yEiRSv7Yad0tQrbK56diyr/7JT2JORW6GCG?=
 =?us-ascii?Q?gYt3VSBWV5rp/uy7qJc+JHUCJL1T5kFO1qsARS9AZV6YVDTVCqrtG6xkQ+Kw?=
 =?us-ascii?Q?1Qq4A/gr3vFyyEQaRldrNT4ANTOfxEmY39eyxHWfbbXMDJlVfiVuvKxGq/Z4?=
 =?us-ascii?Q?wabfVOgMSu1PcMXhFKvyvrTuhMbljH86YtkOCqcGtNfT3h/2AQLxJMX9eLw4?=
 =?us-ascii?Q?zAG9DJiNoJBD07COykqQ4CPW8jOLdoSa9I8Y2nqG/chu6+ZRWKTTSgE9imaa?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 86715b51-9f25-48f3-ab5c-08dc757d4565
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 07:53:27.6725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHjhjCJ1LSiUTYoej0dtHWZSUV6VwB11+a7yHGiLErv5UJMnQkMgtgmMGJzVtftwrF6XNU/u7ZpeCQjvuqTFjOFQj6E3ZzY6S5jKvidkYys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6752
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

Currently, the cyclic_register() done in wdt_start() is not undone in
wdt_stop(). Moreover, calling wdt_start multiple times (which is
perfectly allowed on an already started device, e.g. to change the
timeout value) will result in another struct cyclic_info being
registered, referring to the same watchdog device.

This can easily be seen on e.g. a wandboard:

=> cyclic list
function: watchdog@20bc000, cpu-time: 22 us, frequency: 1.01 times/s
=> wdt list
watchdog@20bc000 (imx_wdt)
=> wdt dev watchdog@20bc000
=> wdt start 50000
WDT:   Started watchdog@20bc000 with servicing every 1000ms (50s timeout)
=> cyclic list
function: watchdog@20bc000, cpu-time: 37 us, frequency: 1.03 times/s
function: watchdog@20bc000, cpu-time: 241 us, frequency: 1.01 times/s
=> wdt start 12345
WDT:   Started watchdog@20bc000 with servicing every 1000ms (12s timeout)
=> cyclic list
function: watchdog@20bc000, cpu-time: 36 us, frequency: 1.03 times/s
function: watchdog@20bc000, cpu-time: 100 us, frequency: 1.04 times/s
function: watchdog@20bc000, cpu-time: 299 us, frequency: 1.00 times/s

So properly unregister the watchdog device from the cyclic framework
in wdt_stop(). In wdt_start(), we cannot just skip the registration,
as the (new) timeout value may mean that we have to ask the cyclic
framework to call us more often. So if we're already running,
first unregister the old cyclic instance.

Reviewed-by: Stefan Roese <sr@denx.de>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/watchdog/wdt-uclass.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index c88312ec721..12850016c93 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -121,10 +121,11 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 		struct wdt_priv *priv = dev_get_uclass_priv(dev);
 		char str[16];
 
-		priv->running = true;
-
 		memset(str, 0, 16);
 		if (IS_ENABLED(CONFIG_WATCHDOG)) {
+			if (priv->running)
+				cyclic_unregister(priv->cyclic);
+
 			/* Register the watchdog driver as a cyclic function */
 			priv->cyclic = cyclic_register(wdt_cyclic,
 						       priv->reset_period * 1000,
@@ -139,6 +140,7 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 			}
 		}
 
+		priv->running = true;
 		printf("WDT:   Started %s with%s servicing %s (%ds timeout)\n",
 		       dev->name, IS_ENABLED(CONFIG_WATCHDOG) ? "" : "out",
 		       str, (u32)lldiv(timeout_ms, 1000));
@@ -159,6 +161,9 @@ int wdt_stop(struct udevice *dev)
 	if (ret == 0) {
 		struct wdt_priv *priv = dev_get_uclass_priv(dev);
 
+		if (IS_ENABLED(CONFIG_WATCHDOG) && priv->running)
+			cyclic_unregister(priv->cyclic);
+
 		priv->running = false;
 	}
 
-- 
2.40.1.1.g1c60b9335d

