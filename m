Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDF3C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 11:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF323884E7;
	Tue, 28 May 2024 13:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ItKQZlhf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D6AA884B0; Tue, 28 May 2024 13:13:48 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3587C884BA
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 13:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx+K6/vykJbEs4y63AJoQKPIRqaXI+3KTHV98Vlq7mxExb8BYGsDnXdBwvrRixTYvJN1wAAWAY5DWuCwtxK/H9QWrVE0z9JA9+8qN2pU3pB00w7UrwnXwkmBknCchdTv0USPNTEGIZgp/HxhZbx5r/jcGo7FEI9b5dvO/uXzWueKHFtOmRKqf5MVWu7x5FBSWiYqpJNwTiYlLdOyD/8Ust0x8AdnN9fTABBagkvqAPxpeYEdwT7mvMyE+XzZSwU/N8DSgrE/1QbOe/+Fix9lDA4gDnbSXjt+mXmJD5yUR9g1SxuTh3OSKsyfO6fwOrie67yif2vZ+hEv22fWRf/GvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e19by//5T7PnJfOKqVhlnzgfNoM2hkXkhcbvYUe6XpU=;
 b=ksPPcmFIw2mzPfV9MBfEsjvj+buFuRzpjBS0DTQvVsK0DAxgoVG8Gacp65Gn7Q27Q9j+7wBv7fI803GX7Nucroz0WvbqqS1A3wYoPxD+fO/wRu62D0SP1ylCNFpIVg12R28CUqQs8eMi0aNfO0qiqG++21AHklpOFpRIRUqE/Hheba9yjUAg+aJjyigsgOIm9cddaQIKT1MSmFiT0Fr1RWthFkSnGTLzh9X7K4SOyWv0X6Z4e4VtTVKcXlW5t4ss3nlscedZD+QypcXA9anMZsssRFPbtBZ/axRy+VUhpc+sXi+5iW3SvI5L2QbUaKkUBZqyYSS8Y3OVBwyKv7JN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e19by//5T7PnJfOKqVhlnzgfNoM2hkXkhcbvYUe6XpU=;
 b=ItKQZlhf4Dgqn6TPhiolLPLERI3tTo1YegIZaBC4le0Zsfr3RZdq8jHy4slEn3vwecGw7MtraJDk/jS7sfbFSRQHwILXD+kbbNexNtQw337Amp4rSr23LBnOKUfExdFqfqaBDH77vgpfTAB/gtRveGgFACxW6xp+8ZUW1G4DZXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB7079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:df::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 28 May
 2024 11:13:36 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 11:13:36 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH 1/7] m68k: remove dead code
Date: Tue, 28 May 2024 13:13:19 +0200
Message-Id: <20240528111325.2163560-2-rasmus.villemoes@prevas.dk>
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
X-MS-Office365-Filtering-Correlation-Id: c100b29b-e32a-4842-c455-08dc7f07380a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|366007|52116005|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tHpczReldnF2g7efwbVcGGS9czLCh2EhPRdPN3yu+zf0asbog8giWv8v88Ke?=
 =?us-ascii?Q?FncvmqvJV0a/iTa1cBAEk34LcDZIAtK3iM/Wc7unBPPz1X3Pg0ycF69OvZal?=
 =?us-ascii?Q?AhrJfF4XZ9PHYBILYha0Fw8hC+pIMJPmoEaIZ1F4bTU5hmg4CLiNEkiW4mLD?=
 =?us-ascii?Q?XJM+Oe+Z8CEtb2i9wTcuQJzYB6OQWAPRUbmqboUnuIzd1XaIgQrAVZ3jjeFy?=
 =?us-ascii?Q?DvUa2EEALVmXaOchA80J99SKyYqLAd9dC3Mpjl2jeBWlTIEZPk30x7ymIj8r?=
 =?us-ascii?Q?1lPPkNW+dpOSRBdLvvof3VtEhIQBq3KMMqyWsnbzsrTiKuAr12bhuDFRquyr?=
 =?us-ascii?Q?kAOwQoXF8OslvfrX4lrAp4+44GJ6BJSU1jd8lVFQqa24jt4lQKYzSsRGTJxF?=
 =?us-ascii?Q?SSAopaunY0BBYScCCWX82WEj4K7s4kFtRr/RPzusJeC+mlPQcLyV4Ztbn2Kx?=
 =?us-ascii?Q?UvyJSO1gYWU/Xe/O4yFXGSIetTZLo40AtDJLVWwK2L1y9hcxxEwjT12zccoc?=
 =?us-ascii?Q?XgfJAGcRaVVKNEezozDNplFLRxdyL5cLer/69Tdv2i9zljUD0UvUg4rv9bZL?=
 =?us-ascii?Q?4QknaViJSz/hUdlyQ5fMXSkhpPE0HhemK0n0YxxdoNdAyllLEEhYp+XFSwlI?=
 =?us-ascii?Q?whZRLfvy6gjyzcbCX2lrs1vX91VC9C4gfvysedxLPwXVY+GZ/ET9aLp35pV3?=
 =?us-ascii?Q?10KDWeeBJh6U4NT6pTfhnm2V+BAZdg6E5WmAB5zfpRAO03988ZolM1ztGXM5?=
 =?us-ascii?Q?2VMdFdsuZpx72icCU3N33QS3Tag6idRbLQ7R4AGMyKtxljk9ZqXRTo2EkEJo?=
 =?us-ascii?Q?XQkmy4h5jyx/UTsumETGSvtIUJGxNDnu4u+px8k/Ejka/vH2418CQ51lGivp?=
 =?us-ascii?Q?dUhjMcvQ9wx8EE61thytl67qxGctqCtOz5/OlsNEzpOz3KfEk9tpSX7BGs/f?=
 =?us-ascii?Q?GPfv3XFpED6LMIvlHmXIVe5cVXdHRhQWs9QdJ3a7qiH4Sl5528lXTIiwS3uG?=
 =?us-ascii?Q?N1Zd12dvOgcfHjpaXCs1wW+PcJDvnL2ouMkx7gxCzMiL9EmA97d4Tdl1o0kq?=
 =?us-ascii?Q?dHJHsg56r1UjZigdWppDnDH9usf5z9/WOyF0KWW5db8prYQ3KNC2C+66mH6P?=
 =?us-ascii?Q?Iql9xhmgnVQVh3ZTiHMP7tX5oWHX23gtM7BHILYXoAYMj9PI3Im0DGJYhOSc?=
 =?us-ascii?Q?do2okvl2Woi27C2FOmrk1N9GZ2yd0KUQcOMWlBu40tpiXR3LyuHfftKwnm+a?=
 =?us-ascii?Q?L17xJGjgVC7MWJVNtPBJoeFfQBNW/IAzJoyclU8hakKLlDYlbQTZaD4H5/8Z?=
 =?us-ascii?Q?jOTHgfaHuwGEsqai7uQBDXZw6zQDCcLKOJBOEwscR6VaLQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?691H3WjY0QYd622MDO+/N/cRgcVtX5uXzMTsD1UcPJaE9xxrfptBWx3GX4S/?=
 =?us-ascii?Q?9toYsmyAQQFW5dRylLmb3Z1/VQLqWmuRxKNKMhBt3FvQTKeKbDGx/TOF92R/?=
 =?us-ascii?Q?/HNOjYLkqIRqmqJcGUweoX+cHlSETxJPB2F3+lOjCxacDb2BGQbEnVyqNYQJ?=
 =?us-ascii?Q?YJG+Gr5xqRdcqGFzybWMr2ZFBKKY52Xdn81g6U0rHu8RzRJn4/N5BhP97rpv?=
 =?us-ascii?Q?Ldt1F4LCEweB3r2XZo04cRKZG3eWb7pqgQqpsW2Bm+KaJssjQqQNdWMBBxIb?=
 =?us-ascii?Q?xc0D2UtWsye1RPtaUaSthOXgbKs3zH8QWZstFDPhT3wmxEIpaR9/UrrcEjAs?=
 =?us-ascii?Q?xA//t4HYS1B4ix5SKQHGdG25UIH11pYCLe1OmDbIOAIP8ODxWYkegOiXNnJx?=
 =?us-ascii?Q?KRS2Pfh2AmhaRUWXq2e9/5J99CEGUYeqQ7MH8kDNd0LEnYE+XUcc1dj+ol/A?=
 =?us-ascii?Q?Uf8yQ7ExfpZw94cnlkAoEFwauGAmJqhBkmZXWofaF2DtJBEW98Rw20+74UT8?=
 =?us-ascii?Q?F3Gl/AjoRps6ImJrC2mWoHPDkc/3yHGvZWs+hyPD099N5RQM2cf6rYoN9Nug?=
 =?us-ascii?Q?FwnONrXU8QAYsWbYy23qyzobX9v6IKirR2KymQrD2nT2/d2yUrYHgX4h/Sn6?=
 =?us-ascii?Q?YrtQqtsTBsUy4YNAfAwwvc0OHQ+zO2DeUU3zNT8lGwgBr5W7cMFeK/qO8Toe?=
 =?us-ascii?Q?c3vlvtBYA6PSTKRNEwRjugzZYB5XyZ6jRdd9v+Kn11d9t5b3mPlvXzJWv/QD?=
 =?us-ascii?Q?wmeHZl7hwIuiwKkN5UyT5TnMOmG1cSVcrgN7xvBc02oo5OUrCOKiEQYu9PSK?=
 =?us-ascii?Q?f1U01myGdXUWvIZNY9S4vM+18rY4hZgT3C5xtK7lHTXIBXtv6SBUcByVDqnK?=
 =?us-ascii?Q?QNdecJcOa5nW0SFWqYTSimc3+lgbEMbAXRoQwVHsj200mlFay/04mKmHmZCw?=
 =?us-ascii?Q?sA24scHXJ3G2OFUK2Zk69q+WuHMphHyOKo3RPBRU9BBieab6AA0/b017T2Qm?=
 =?us-ascii?Q?25QiyoyUwyiQUG9z2uDjjsccMMeqnMtinm2Z7b0sP2dDcgRN3AVCTgy7q9q8?=
 =?us-ascii?Q?S3kHim9gzGAgxpKWKmGQm4iWoAc3IOxGaxlf73pyb5TyIv36w0ax4QTwj4se?=
 =?us-ascii?Q?zJkxGuIOELL2mqUH3mZgVEaIW8R3TssxS6HMynyEWb/vs6bsQj21oKr/iOz5?=
 =?us-ascii?Q?9FBTI1pUqOzqsu2ZHpCn4z/3sGJ3gUETJqKG26qL9QXbQQpkeVNJ7XCmX+4C?=
 =?us-ascii?Q?4EF2VeldMN/1ZxnTFC1jvgA3G2yycgfB5RqWHihLKI4QSwYcFyEot6NyfOg+?=
 =?us-ascii?Q?CP16Ffxw7Zi6mkKfAC7EzibR2FSWig4wE95fkA5YCaATAfIA2XUwWUl/YNVY?=
 =?us-ascii?Q?N2WJYfWQ1pEWFwyieor27k/QsKZjBa4e6a5MjB9ox5GWCUYVMECU1vDwVft8?=
 =?us-ascii?Q?yhztrStIb8usSLh/OHHX5XmhVmKqHUUFrto/6vAM04QScFnWG2ZcHa99ep7t?=
 =?us-ascii?Q?6h1WDj7oxvsblCBf+wvKy5OHKLmcJi4VE1iFyhsG94eFO/KJZ3johk74pVga?=
 =?us-ascii?Q?OMla99vWWIAQz64CnSiK4sC+vfMDJXVLmgb1mtwiZJcqGHSLgWpn2LZSlCO/?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c100b29b-e32a-4842-c455-08dc7f07380a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 11:13:36.2610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvb0LWd0Yn3PUxrA/GDk5NEADE52Hf+q2iS4S2/Qw/9P+IZb3LpLCyNZD8rhWEoHlZbmzCZUjNhN3eFFm7onUwGqdR8qYuc9r9U0CA4x/hw=
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

There are no calls of "watchdog_reset()" anymore anywhere in the tree
since the WATCHDOG_RESET macro got removed in 942d07df0e79 ("watchdog:
Remove WATCHDOG_RESET macro").

The only places the identifiers watchdog_disable and watchdog_init are
called are in arch/arm/mach-omap2/, so those can obviously not refer
to these instances.

Hence these functions are not actually used at all and can be
removed. As a bonus, this also removes two leftover references to
WATCHDOG_RESET.

Cc: Huan Wang <alison.wang@nxp.com>
Cc: Angelo Dureghello <angelo@kernel-space.org>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 arch/m68k/cpu/mcf52x2/cpu.c | 108 ------------------------------------
 1 file changed, 108 deletions(-)

diff --git a/arch/m68k/cpu/mcf52x2/cpu.c b/arch/m68k/cpu/mcf52x2/cpu.c
index 6bfde5e9bd7..d0a0a4500a9 100644
--- a/arch/m68k/cpu/mcf52x2/cpu.c
+++ b/arch/m68k/cpu/mcf52x2/cpu.c
@@ -108,26 +108,6 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return 0;
 };
 
-#if defined(CONFIG_WATCHDOG)
-void watchdog_reset(void)
-{
-	mbar_writeShort(MCF_WTM_WSR, 0x5555);
-	mbar_writeShort(MCF_WTM_WSR, 0xAAAA);
-}
-
-int watchdog_disable(void)
-{
-	mbar_writeShort(MCF_WTM_WCR, 0);
-	return (0);
-}
-
-int watchdog_init(void)
-{
-	mbar_writeShort(MCF_WTM_WCR, MCF_WTM_WCR_EN);
-	return (0);
-}
-#endif				/* #ifdef CONFIG_WATCHDOG */
-
 #endif
 
 #ifdef	CONFIG_M5272
@@ -174,49 +154,6 @@ int print_cpuinfo(void)
 };
 #endif /* CONFIG_DISPLAY_CPUINFO */
 
-#if defined(CONFIG_WATCHDOG)
-/* Called by macro WATCHDOG_RESET */
-void watchdog_reset(void)
-{
-	wdog_t *wdt = (wdog_t *)(MMAP_WDOG);
-
-	out_be16(&wdt->wdog_wcr, 0);
-}
-
-int watchdog_disable(void)
-{
-	wdog_t *wdt = (wdog_t *)(MMAP_WDOG);
-
-	/* reset watchdog counter */
-	out_be16(&wdt->wdog_wcr, 0);
-	/* disable watchdog interrupt */
-	out_be16(&wdt->wdog_wirr, 0);
-	/* disable watchdog timer */
-	out_be16(&wdt->wdog_wrrr, 0);
-
-	puts("WATCHDOG:disabled\n");
-	return (0);
-}
-
-int watchdog_init(void)
-{
-	wdog_t *wdt = (wdog_t *)(MMAP_WDOG);
-
-	/* disable watchdog interrupt */
-	out_be16(&wdt->wdog_wirr, 0);
-
-	/* set timeout and enable watchdog */
-	out_be16(&wdt->wdog_wrrr,
-		(CONFIG_WATCHDOG_TIMEOUT_MSECS * CONFIG_SYS_HZ) / (32768 * 1000) - 1);
-
-	/* reset watchdog counter */
-	out_be16(&wdt->wdog_wcr, 0);
-
-	puts("WATCHDOG:enabled\n");
-	return (0);
-}
-#endif				/* #ifdef CONFIG_WATCHDOG */
-
 #endif				/* #ifdef CONFIG_M5272 */
 
 #ifdef	CONFIG_M5275
@@ -243,51 +180,6 @@ int print_cpuinfo(void)
 };
 #endif /* CONFIG_DISPLAY_CPUINFO */
 
-#if defined(CONFIG_WATCHDOG)
-/* Called by macro WATCHDOG_RESET */
-void watchdog_reset(void)
-{
-	wdog_t *wdt = (wdog_t *)(MMAP_WDOG);
-
-	out_be16(&wdt->wsr, 0x5555);
-	out_be16(&wdt->wsr, 0xaaaa);
-}
-
-int watchdog_disable(void)
-{
-	wdog_t *wdt = (wdog_t *)(MMAP_WDOG);
-
-	/* reset watchdog counter */
-	out_be16(&wdt->wsr, 0x5555);
-	out_be16(&wdt->wsr, 0xaaaa);
-
-	/* disable watchdog timer */
-	out_be16(&wdt->wcr, 0);
-
-	puts("WATCHDOG:disabled\n");
-	return (0);
-}
-
-int watchdog_init(void)
-{
-	wdog_t *wdt = (wdog_t *)(MMAP_WDOG);
-
-	/* disable watchdog */
-	out_be16(&wdt->wcr, 0);
-
-	/* set timeout and enable watchdog */
-	out_be16(&wdt->wmr,
-		(CONFIG_WATCHDOG_TIMEOUT_MSECS * CONFIG_SYS_HZ) / (32768 * 1000) - 1);
-
-	/* reset watchdog counter */
-	out_be16(&wdt->wsr, 0x5555);
-	out_be16(&wdt->wsr, 0xaaaa);
-
-	puts("WATCHDOG:enabled\n");
-	return (0);
-}
-#endif				/* #ifdef CONFIG_WATCHDOG */
-
 #endif				/* #ifdef CONFIG_M5275 */
 
 #ifdef	CONFIG_M5282
-- 
2.40.1.1.g1c60b9335d

