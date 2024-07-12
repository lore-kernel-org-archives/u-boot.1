Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AE5C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 09:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 614BD88777;
	Fri, 12 Jul 2024 11:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="VdeA2l4C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A3F88756; Fri, 12 Jul 2024 11:07:26 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE6708871F
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 11:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6i6zTwmcnTuu21x/TsytDwUATCtfvvdjEP4kYbKrBIrZkpHFwxfsbcNbAPpecxM6otYC+jclGnUJEuaxOkNH4ppTJY2oZNpVIfZsBj7IFlF+RrdDGePcNdzuvngXYzQQQ+I3IQnTPhrH3BVk1Gy7E43SsjqbBMC8VsHw9oIv9PFnl/Z71Ihw6/Jsf+elNf6jlusCyqBVQyCTjadJJvwMR7HlkJu0Yw1wh5FuniA5xqb+kObBouWJeEaUGoinztat3gHHdDolFFqUzju4PTnNQXDbcqiGJNScRQTN1UhlOBhzfyYT/DOVS/uJ3OM3OOT0lpcsmCI/ilp55n4whAFUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUUUjB1xnkdWxYbJc3PL+LpVnpH90akucp+Sbfu78aE=;
 b=iabAPBaZmRaUA+W5LEcoU6wsrVq8kec9Jg8PBUNLYp2pgyEffg07pd4kUluYqK5ZPklVegImIwt//cxdVQ8kn71YTr9zr/tTYhTA93xMK2WctTedM/pqcUVTwS2uAo6ZwvGYxJdHTK2wIRjCGpubs3tAYhNecMr02dq+2jWVoj+jMqCaCR3xXltOi9bveQsFn1OR08JKzez0ti0tlfdVlmHhYjvIEJ6JKV1yotsVd7Go13aRgmTimCFAjMmWIuLgQhAxmu7RsaYbbDLVhOBt/U9PbnfJJrW5MiRArzl+xTQ+ho3hTgt86VokH6o6tOHq0Ya8r8NTn+6+hBaIuslJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUUUjB1xnkdWxYbJc3PL+LpVnpH90akucp+Sbfu78aE=;
 b=VdeA2l4CCj/kw1cUW+BYU/+BERUod1aalqtuN3jrTocDdYdrx7z8lUr2X8jz5nJmuLKie0EbaHsWfcU/voQFYEb745a0h0Zw5U9gslkB/uDRefMtPC2pPajF3pgRxginXqVYMfFK3MppvYAnNU7upwqbFp7tCKsNKH+zj2kpJLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU4PR10MB8780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 09:07:20 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.7762.016; Fri, 12 Jul 2024
 09:07:20 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 1/2] arm: bcm283x: remove unused empty hw_watchdog_disable
Date: Fri, 12 Jul 2024 11:07:24 +0200
Message-ID: <20240712090725.2093317-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240712090725.2093317-1-rasmus.villemoes@prevas.dk>
References: <20240712090725.2093317-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0010.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::21) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU4PR10MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d74b8e-adc0-4f67-3a64-08dca252095f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sigq5ORE8xJoJcnhL485BqB25uoy+Cx+7t5vUlSk3JLiVoVloDoFv3RCFNV7?=
 =?us-ascii?Q?WpACN/BvBY1nZDr8mjCOUdzBEn1nUtTANJd8fw6h8rKLhic4gc0DEwbi1E9t?=
 =?us-ascii?Q?+qlBMI4/Lsltshqo9V8kybQKVydXir83A93B76BV1QOHXa7lb9K+ZT5pPNLI?=
 =?us-ascii?Q?SBxT0v3jvAVpyftEda14iapOe60f3XPpoSDJrI1w7UA1bglDLUxLhdNsTIC7?=
 =?us-ascii?Q?NwczkLpsGP88dEwTEOsfP8xbNMan7/ZSRhjnECDSlZwUFwxdnpLig+yqjNuk?=
 =?us-ascii?Q?Q7KEDWq8O9zv/vuSBm3zhPFfJo3APCOaKdzhgUBUFKTslk5aOaApt1kRRU+C?=
 =?us-ascii?Q?g5YrTExxCdu2JUcJpnkWUWqC602zfI1M6SKnKzgqNjtmDrdN0KpEcJ9GKwFT?=
 =?us-ascii?Q?iY61DXAsBGH2nc/My0Mx9Nm+ieDeB1foyjJDhFfbfI/JN17rnB0CUjX1u5TD?=
 =?us-ascii?Q?mv4tmdJ9S7PmXAzDdw508W6SaKetXkFsyWCtvKOzIQupHik3NajsAtjEXXa+?=
 =?us-ascii?Q?tfMoK8Cd4uAdUEfHzg0UGJ7TsbXozDAXfG/AmakSx0sdciUn8eoFgHqfCPzL?=
 =?us-ascii?Q?Hfh/gIW8NntCxwBq2T3bbHApIGBEb+dWhjpBNEk7lkMVA9XAp4LObOv+9Y2P?=
 =?us-ascii?Q?w7E5UKSReiOzNbWO5zF5jkiXJEd1MOGIInd6ydOnwiCjgJ81g6nPIJY5txWB?=
 =?us-ascii?Q?tY3abM/wavcd/k5UJ1D0CINiNAMOeMe5QYJ4KRpFO91N7U32glVUMxye4jxs?=
 =?us-ascii?Q?JAGKs6nFKp7SNT0fe87pZQc1kPhGU8oYODKkKXY8klg6XBTBfBWUcP1UQsyh?=
 =?us-ascii?Q?BW6MBWzQUHRU8DU3wWonxJhsSMv6bgWi9wdEwONbP3JlVhlu+FFzOr3JO9HV?=
 =?us-ascii?Q?PbTbZrik14IeP9dl/y7DDs6uzhH5S6QXVPxTVSCYO+lsD8JJ+mnK+70pktSH?=
 =?us-ascii?Q?ZvltIR7wTYFs49EcV8XH4m7Lp3tw9L1F7E75U+wqBMYgxJp4hFRy3hITRJK/?=
 =?us-ascii?Q?MHCH99dLtdSlU82D9EyyLkCW/DX57ad/dVX9YBU3HTCpPMIoHKgyODSQ3uEO?=
 =?us-ascii?Q?N0O6iBDfDjBDc63fKDWdQnoi9Vor8us0ifiu4L4wZ26wyy+l4rUcNMx6Ucp2?=
 =?us-ascii?Q?AiGJSQf40JqavBAU7UrSKWgwclJEOvtIaWAWheDXAu5cTc4XYB/kJlFWHvLD?=
 =?us-ascii?Q?jv+oP7HSNOpY5XJE4jzNX9JFXJz9z7HGn2abMYnER4CYtiREE7OcY+UGN4xd?=
 =?us-ascii?Q?JYGRn0kjLPdPlUxJJSWoQM0ZoVfc1LRw1EN7l9mrXgRgV2sBrqjr/IE/bMvl?=
 =?us-ascii?Q?2N1NsADX3mQ1i7+jH0qFzrgvb2KX/EAWmheApuxbGy50IMLlj7NFiaQSqS9u?=
 =?us-ascii?Q?aT6+K5E6TtWH/9/G6uhonjpHlMggyK73wm/p1lyix6LWEecaOg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FsNfYhqeh0uyLljDNelYilfhhHpMWoox4ia13+UY+RHmZWD43RlNsJXLMuX2?=
 =?us-ascii?Q?pJX2/wk8BnTLtjmAGaWP1MPzYiONdi+jZegYBytrvXx3Qut90sxBoOorjU54?=
 =?us-ascii?Q?rqakssP1f6knNMCv0FG313sYTG5Zp+sSHy8mryLDFCHRrM0NhfXRC8DxS0Lq?=
 =?us-ascii?Q?BpAlZ18Na8m9WUH23t6W6eVXhJihr3q8S1Ye+fMTOIJ5knmideMQTyhoJTKY?=
 =?us-ascii?Q?/c1ZayvEDZeNZzeoYtkRuWpb+67LLxihf1/2rh4zb009DONb7EZM73wbuQ+W?=
 =?us-ascii?Q?9zo634stUmHXoGCyXzzD4ipQW/kQ00W4PZkXrXvK9CrxdGQK1VyzdYXcxsrI?=
 =?us-ascii?Q?1nnf+fbXJsBJOSNp+vdicahHBY0qmejY8PNln3C5OkqL9N5qoqDhMWaHAQiN?=
 =?us-ascii?Q?BijKdReFVruuLLb7uMhjx13pIiE/nRslJsY+pS0R9bBYY7hxemoZsFYlM0dy?=
 =?us-ascii?Q?iFi6RqFmZzaaAC6KXjKjM1xstiHDdxTdOKveeIjzAKbJJN9i5EKHlN+IXHpz?=
 =?us-ascii?Q?ChobChqmMAVWEWT9edvEb+CWHuHHQRJBlvd7QgEDhBtDbenUOd4CPvIasTFu?=
 =?us-ascii?Q?4hXTIqNutrVpBiuplZ3R03lbCiS4tF3rAWDXMAjU6qO0FmtBWxi4jIAlM/6P?=
 =?us-ascii?Q?VvIKzk75ey1KbgfTa0PY2DshhEnFIJDCxfxGuqkEAou8iKWYgsMPF27Xiijz?=
 =?us-ascii?Q?jdrJBbrGORJVODaSwU4kqLe0IThHunglTN7ax95gd+58lIq1QaI0OsPRwhZI?=
 =?us-ascii?Q?rgWTe6ObS6ue/Qkb2iuoInbdb1nGObNz4/UfbI1GIGI9ruZ+Sc67HXxgaMzk?=
 =?us-ascii?Q?UDQwshHhXK9TXthiZ7926SczF8hTRgJ3RfrwIEUkN6to2YMmudMVk8h2NWSw?=
 =?us-ascii?Q?pwS9YOrLUVi5Hptmp4XV0BjW97ViObR7nQHDfKlEohGJIV2fBQgbQLnEt5Y6?=
 =?us-ascii?Q?ETrhyytpmg6V7OmHS1w5CZplSiX7Be7k786OeQLJqz0HruIJVvtajEFME9Xa?=
 =?us-ascii?Q?3J2VIivnziocv00o1zGAuj3PMUmoqeSK5CH+F0UKa3Fe4ei4WxzxF9OS3b8Z?=
 =?us-ascii?Q?19dgzLgQvjvWjDfLTqHLrB8fmJgxuNA4oAIKlzFPQ3FEDNEN4rBw7NJdbjpT?=
 =?us-ascii?Q?aCJXtYQXeR/4ym7Z1Xjbc1x6E3iYn7gViGiHvn+ENbhxaYslLqgvuMsWynRP?=
 =?us-ascii?Q?MdasfYJVfVtl4e75aQJ9RmUE+Tv/ppQkGtSil2Lf6iM/Shj7p1Xdq62bgfEC?=
 =?us-ascii?Q?HMb7HlKCnMMILoCbTDaEykLMiAdDacqSazHN1WZxtgSK2Po9DVAF4kiXLVO5?=
 =?us-ascii?Q?Zoloor/VExq2c5KIUPrQZT4AAYiJsHhwsjrs3ZMs531WBmOCdvOGHn539HTp?=
 =?us-ascii?Q?rmXa+cvl/cdfsvuPBpzHSTD/eb++5l9C01YEKut/xiaO7WRll7twJBVNrd8w?=
 =?us-ascii?Q?3Ng2KdtXZXmLiiSMh/MZfQICp68XqJPVgTZquJ+m16StMgyCNPLGOFS9+k7n?=
 =?us-ascii?Q?nyHfqzX+z8ptPv5lZd+iFNVQm5JbtcpTLVEz1oB2KCniCEkY8jIB3hJaWyk4?=
 =?us-ascii?Q?MB5Yzj+ttc+Cbhx+jYvNI9PM+O9OBcl25Yqmd7laqIMNf2kivtZIQh74bk6f?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d74b8e-adc0-4f67-3a64-08dca252095f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 09:07:20.8853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hRfVyckfbaiSK9hAKsedUW/kX6xd5qhV4BTM97okwmCwI3wsNKhtapS3mGQ0eJBL0deH8NSx++rv1NPFXT78OkSDa7z3RpOqRDqS98iacg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8780
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
watchdog driver and its references), but this now unused stub was left
behind. The later (re-)added rpi watchdog driver does not define a
hw_watchdog_disable() function, as that is properly integrated in the
watchdog framework.

Reviewed-by: Stefan Roese <sr@denx.de>
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

