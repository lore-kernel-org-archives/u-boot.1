Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEA6C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 21:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1504D88717;
	Wed, 10 Jul 2024 23:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="OOVs0oYm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCF658862D; Wed, 10 Jul 2024 23:17:37 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1042C88722
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 23:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KabeKF2XLF/0xF89GaKadz/7ZoZY/pWBuu3WARLdfoaluEHA9zvR+MOJCHbWV/snumr3i3is8tSkHHHMoEIlj4E+bSanslsooz+SUFD7xrgL68MB9WoF0koRAO0OSUr2jieFuBC4g4t41VKlKvMApoQW8cG0ZO/zCSAoFz7rT5FQ+/+UgbYBH6cxWurVMqtB39j/+qPuZR5v3O0YmEFqyrGvzJa3aTEnC03TMjxbLWxFlBvhHrGqjDmJRzH2wABGzMGiG8WkP4P41ljFYuACwwpaxr1ySc5sjjDHxtUcviXw0QHshzN6V1VBkVSIQbBlvhnNJzPwnX7v/31jG0/O8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzjr1l+tuHbCZwNTmy27aB8lgB+0P4PFh6QqLwMYxFg=;
 b=SgoPTjLMRk1cxMeBgSak90Rq6HFLU4EifXfH1VuZibi1WceiKrTM4Lw88QSeUQByllvi7nE2DE2ey8QEEfRJ5qGrfK2VGmuavqpFAyHmmvXtKT7i2PJLqnkR6xrAg9PQWNnvPmn+aFRqeVEtqexE8AAOZLzeD/1UTZxC1V6YGzFJqsc5MUE2BTXGkGbX3CkNjb0vYZ7mvNhy9kC8tlc9oR0Jy297aiv+BaFM28iLdQPma36uvXUpmhnB6xDDDTJMWp8zpdA6VFT9oxfx4krEYxug1gM66z53z17Z2XfggksIvfU5R6FQx56X+NIbyedy7Dz95nxbzw19a3WJKab3zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzjr1l+tuHbCZwNTmy27aB8lgB+0P4PFh6QqLwMYxFg=;
 b=OOVs0oYmkugquCNUa7rgKEeGh45HGbNc3oWYHgdfL2GTsuls1w8mwZXOSuJi4Wy7Q9lAa/7r8OmAjacwlbWv37zg9L0FNlgLV757LzMxDbW0D2tByXqPPDfyc/S5nOe1hkSRaUWqTb1gKfB7NGjS3Lkwl07q7WizO6gYJOs27Is=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB6711.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 21:17:31 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 21:17:31 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 1/2] arm: bcm283x: remove pointless empty hw_watchdog_disable
Date: Wed, 10 Jul 2024 23:17:29 +0200
Message-ID: <20240710211730.2635847-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0103.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::17) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a774fcf-3d63-4619-67f3-08dca125b5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0SKUvITC3jEFOGaBrDygiMl5e+viMEPzAAeTp1gTiIqRgBe3g7UQ0KupGH74?=
 =?us-ascii?Q?O4eAWUXiR3QXccea4vEHU6o4azs5DkIZ+eQUsMAwCPbCEjRdXieEQuUOd4Tk?=
 =?us-ascii?Q?eO5Wx50vwKbw5eM5UHKvJS6TLWwXvYG7c9Crw97LC02o6Bnzs74PoUfQtOnJ?=
 =?us-ascii?Q?kdRRkfFAExPlFLSyrhBRekHG2td0rdxKomMcxeCyJBPpPRDwV081/iUJ9eFU?=
 =?us-ascii?Q?SQmMxi0A18x0PeZvMTVmR1f2gzoYSBE3X0kXEK0rg2hn7aMyQXBCYSpfbB2/?=
 =?us-ascii?Q?uWd3z/dRTehku3ptUZ+XrlFWv1NeYee0C44vhsZGwjUIV823ceUzP2Y6x1mr?=
 =?us-ascii?Q?URc7G+iDpz2+Xz7dMc15kEMf7Pba09vUogxj2sXMbSWBLvY+s2Dw8jJEdzAc?=
 =?us-ascii?Q?RadhyWyQd8buwMXY0Dp7QIZAMl2eNTVULn3BLatkUCh3w/mGBDCcx3WKMIEF?=
 =?us-ascii?Q?WbKz0MVb7AFXrIEELZGZQkpPNrldzWOpz75ai7MAwRn2LC6BJpS5XfLSuAkV?=
 =?us-ascii?Q?Ci/XYNdjW9fYK3DxFE1bDtpfYz05mqxzqs2k0EmVZrAR7ztEVlZfJTxX0JFy?=
 =?us-ascii?Q?ZTDdyP74TDB1bHouJxC8RRR0jckZVOmmjQs4d+GH0rX2z0VO/UVTqIjk5yOt?=
 =?us-ascii?Q?+/I8g3lPN2/OPIEFMG7VtXPqAnAhzeEwCJ0skg0pdwku1Oc8eNCTWJKAX0aX?=
 =?us-ascii?Q?u6ALgDhevHEzOm9SIzLqi1APCeGl2VSMBSseXcIYZ+tBiFXV01suJ1bMOVea?=
 =?us-ascii?Q?2szzCHYuzfrpYzoJDs4OsJjWjtBe7Qpu3QUzkjN88XTSnW5QWPyQuPlIm8yW?=
 =?us-ascii?Q?K9dNiwmGK+AhY6+qPVE2Hx+/bjekxkuxkKCDi5lZyUzo32mYboGAncWAOLFB?=
 =?us-ascii?Q?IO3/dWAIZRR2NvInTbaLDYue/GOmFdeEYnMQGX1ZegJBt5X9g/Bm/dm3RvVL?=
 =?us-ascii?Q?UHisJXpgZ7xka840Zzq3dIv+G3YNA1TGWOULm5r0wqrD2CyLKZMvC5teZMe+?=
 =?us-ascii?Q?Yww4YtQ0MGxEYW6tQVtiasICYuo9BOy8apKmHQNDuEzmjthSh8HeTrP1E3EA?=
 =?us-ascii?Q?6+4t0w9dRCJoJ6f7OyR3cnCUCT9aWubsP+doNlnLlN+n1ftbN5UE23x8D88b?=
 =?us-ascii?Q?IRsvFaxuv49FMqkF8GdciJ+TDOWxcbiOa0hn5I/CJW84yvA/lx5izn8JvBa/?=
 =?us-ascii?Q?sTtg8Az3iwvysHNoM015OOvJDRQsKz+9UuG+BivK0++arsGqNBASsPQD1dcg?=
 =?us-ascii?Q?Daemb1IMqKbTVnTWlV6NwZ3C02UCmsGr1eteR+7u6ZpGPJz7hvbfKj2H7GZn?=
 =?us-ascii?Q?RS9C6NISrUfOr0OkF2/A+CpriZMmQ3fbpc4Ku/D4o+WclrfX7Qd7QEiX5Pcq?=
 =?us-ascii?Q?jAuCodLhh0zkj04PPemlxcqVCOrl9A1xYalVj9svCwhAyPTaoA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QLuWD3mEWoJ8NGY7WF+bS/M3L5tXDgZj13aQ+5GaIUY+ftFtdd3CrRKzwdpU?=
 =?us-ascii?Q?esE29bCEMP2rllZLOe26NHqhTvJQw/cFvot6zN3/4P4L9IqmjitT2ic998/Z?=
 =?us-ascii?Q?sSvPnNr0QsGGZqEJhPdH+F7FyFSfJYYPVEl/YjTdmdGvUNP9HusGpRX+tP/o?=
 =?us-ascii?Q?iU3Hl8tPx6Jmsi3ocTv3mlDgXw7UezMAWWRAetv8ss0UthWa1Qa82FBiODxr?=
 =?us-ascii?Q?Cdy+nXxiT/qheK0UIj/bkNPzV4nVqdtTPweq8kp/a7Z2U6OL1/sbJffsj4EA?=
 =?us-ascii?Q?J4/yESa+/yXyWD/rgz9lZnItVXLt3+bkDhyMIuvTD2vTMDqnO0p28djJdYme?=
 =?us-ascii?Q?bf4yxoG+0+BhEo3235foLUFHtQF9hJLXIAdHd1eXHcToX9vsonQVFunpQjB0?=
 =?us-ascii?Q?2U4Wp5aH7uYkym9CY2yFypOFRnS4p/vH8IePV8y86aU5ONqGiwtmLK39X9KG?=
 =?us-ascii?Q?2hS+ICX+qFMY+K/0lM5/P9z/IlfQoAXnMyQgYJSiSp5PnpS0iqGpKNKzuff+?=
 =?us-ascii?Q?EVF8/1Tnz/7KA5n51xOAAji3NScOd8cBuyj4M0aj5yOTLUQ6xXg8caN/pDNo?=
 =?us-ascii?Q?zoncHdJ2jydyIX6s8Tl7lkWad4n6BbCcShm0B1xP153CF9jpfc5rKBEmrX91?=
 =?us-ascii?Q?QXSFlrnfIIrgFjLNQR+rv2oqMZPakObdqMV3LBg3/W9gpTh8JklkqXHYgqgG?=
 =?us-ascii?Q?PWrwAGcbb1NqVIb+Nb0mNjYOYvz5mPLh6gBDTkR5iUV9Rjd5EwedRwHnM3dh?=
 =?us-ascii?Q?N5/BbgDjIzJ6zAcU7F9hhkeCqWC9zHY/lc4RsC8DDYljxEYUmMXYV/6Natwb?=
 =?us-ascii?Q?/kezGUCChNwW5pXTYq9L3wie/+qq1uS9Og78MlmNoNR0YAGN2SDnR9WSW3PQ?=
 =?us-ascii?Q?SNc8lXftuljdsDWsxpxn1DjRTjkioUEh8RGrLHGexgIzUQXTxM+INtsHWDy6?=
 =?us-ascii?Q?Jca7tPy6ElrnhKG4cOCEnfG24G6TF1XIbpIPgRYNoQnl4P8nqKMmjvqHbeCU?=
 =?us-ascii?Q?q8izRRPA/O1OHTnu60rs7iyIfD2nJFO3iFv36eWJNEkbcXEEubR27EcqrFGx?=
 =?us-ascii?Q?nWgmQXZnfYmXkd5EPoOsjbuoqt5P/4Bkc9kNB+pA4ZYBAVy1caWqBNtlb8em?=
 =?us-ascii?Q?B4LO7F+nGGzke4aOQRTx2uVAqxJJ4ImdnJpgpDdQlUCNRJ81H8WQb+dabyW8?=
 =?us-ascii?Q?jWlLGvpVrLWCEhyWuWrx6sgErRN/LRZIEanTI7nOp4hFDV2KGj4p9nOJnXPz?=
 =?us-ascii?Q?DODUuOlqyzmuL7TbdG1rxLuPqV3QNM/hiBzFuYvRyc+j+NXMAV3MwGhzUrJ1?=
 =?us-ascii?Q?T1oa1LnQ6+xytPWpqOj7yNhNmbAU6up2aqpXtZgTcMLOV5ej091pJTxDjuSI?=
 =?us-ascii?Q?ZvWxd7PvSb6EuQv2dzDI8QyT09MgBWMTVfyAsQuGf2xrkdKsufnd38K3n8CD?=
 =?us-ascii?Q?A93gqM50nrqUhzN7vVyR2pucWyuhzt42rDG6AsRns9xlxRIURJUoKQaKEq6H?=
 =?us-ascii?Q?msxG59yyqdskkf4/Qjz9bCEgKBrSh/86epO8plX1ET45Zaml8oHn8CoriySW?=
 =?us-ascii?Q?cdW8Iv+pv9rbOifZm32zrJmJI5gjgm+q9d6cK2wq3owu7zrkC+08Vq/7zHJM?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a774fcf-3d63-4619-67f3-08dca125b5b6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 21:17:31.4943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qu7aw3yKqXP2hmCZPkxYhrS+MqvKNYCXVGCrkoaazLArKdy0Hcws//Vt+4g2CbSEqsRk+oS7Svh0Ew7BPY2mvYi+q/tlgihKvHbNImRvtAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6711
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

This empty stub was originally added as one branch of an #ifdef in
commit 45a6d231b2f (bcm2835_wdt: support for the BCM2835/2836
watchdog). That incarnation of the rpi watchdog driver was later
removed in c7adc0b5f98 (watchdog: bcm2835_wdt: Remove unused BCM283x
watchdog driver and its references), but this now-pointless stub was
left behind. The later (re-)added rpi watchdog driver does not define
a hw_watchdog_disable() function, as that is properly integrated in
the watchdog framework (i.e. not of the hw_* kind).

Since it wasn't declared static, the compiler cannot even elide
it (though it does get inlined into the caller here, and the
out-of-line definition does get gc'ed by the linker).

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 arch/arm/mach-bcm283x/reset.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-bcm283x/reset.c b/arch/arm/mach-bcm283x/reset.c
index 9199234917f..1dc7ce50d1d 100644
--- a/arch/arm/mach-bcm283x/reset.c
+++ b/arch/arm/mach-bcm283x/reset.c
@@ -25,8 +25,6 @@
 /* max ticks timeout */
 #define BCM2835_WDOG_MAX_TIMEOUT	0x000fffff
 
-void hw_watchdog_disable(void) {}
-
 __efi_runtime_data struct bcm2835_wdog_regs *wdog_regs;
 
 static void __efi_runtime
@@ -34,10 +32,9 @@ __reset_cpu(struct bcm2835_wdog_regs *wdog_regs, ulong ticks)
 {
 	uint32_t rstc, timeout;
 
-	if (ticks == 0) {
-		hw_watchdog_disable();
+	if (ticks == 0)
 		timeout = RESET_TIMEOUT;
-	} else
+	else
 		timeout = ticks & BCM2835_WDOG_MAX_TIMEOUT;
 
 	rstc = readl(&wdog_regs->rstc);
-- 
2.45.2

