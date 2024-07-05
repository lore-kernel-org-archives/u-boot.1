Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E763C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 15:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 270848899C;
	Fri,  5 Jul 2024 17:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="WUE4V7VN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22FDB88864; Fri,  5 Jul 2024 17:04:50 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2071e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::71e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CE748897D
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 17:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faBfUibPtx7d3XamJgmoHAHHOyvdDcwtO9j1liuzA1DNT/D2RXmsGgI5kgxuLKGHKjwv8Z833kZyDh8qsM3BjmolCLPK9fxVWx4GtA2keeWxfVxLiB0zksWj2CVLpvzRJkf2d++SKkaJyYHHQQzx6qKg97ER3xP0AVzPaQAaNb/r6JJ//nLnLUMmfLBCM6+PLEz7vRxn0SGSRLcJ1NlMd67TPqbpGmAsZObK2bctqEuyrL5aAECxx7kU02NuxOmiiXNMRDy4eCZerWcUnWgyVyJPmEWpjIFJJ0nfzMVIpmmC9+2ou1pN0EdC3//IeNV/pm78qaPhXFmJLRpsURn2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqekxxPvqhNagB8v0Iorv1ikkuJ2PtkSmV/vrO6/tGQ=;
 b=jf6bpBovZMW5hSAzhaqpSCRX35hIVxgxvloyB0Fb/E/o1+Me7ra6Tx6Tj7rnCvvfnJkN4yJ5A+VtM2tCgvRIvgFKOxtPlmMrfzQOEOwioQS1VoSArsnLDQL1KU3FFdjDvFM1Ac63+gJHGCs5SeHIQ/4jZGCXl3FksFAL+2l+z9ByGOJvUg3uCj6VyhHpMVU0kp4fnXCB/f5cPpwbNcxvSn2AL24PsVzOl0Ck3sevhXwa0jDOvEIG6soVNgsN9kd+JNDjztVd/VRkb/+7oopxL6904BbsPRMKinJPIkF+1KMUo6vZG5pmEy/mZwAl+HikI7Fg80TirTGJlR3ilXBOOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqekxxPvqhNagB8v0Iorv1ikkuJ2PtkSmV/vrO6/tGQ=;
 b=WUE4V7VN9K+J9xKBjAaCBJbBjgOIZTA+7AefG8hRtaqRxrOaYLsYqs3tWmBchnmq1mFT/NOhwekYdqd0opW3MH8saKxA1o/HpcUk4Wt/TdAbWptL6bGXTMLEKwbeHCi+65NiiGqeD/2sIBuChXp4KAR5IZjmg9RrDbRBbtYYZwzhFUIm4yE0PAXj+lsQk/VUJ6gs+BHPNUtHwVr0x6HZLfA6f01pggzBkcwudct+IzDRRasJWOIUCzRNccR4jYbgCLJXi4HESY0Vs1nL8YNkONVtyjVIwh0tE2iKcEB3q3daTMYiJ1MXtQcQV/a8hZSX9WTBxvSyIGkKa2GBWdjXfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB9808.eurprd08.prod.outlook.com (2603:10a6:102:2ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Fri, 5 Jul
 2024 15:04:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 15:04:45 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 1/9] net/tcp: fix TCP options processing
Date: Fri,  5 Jul 2024 19:04:23 +0400
Message-Id: <20240705150431.2274662-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705150431.2274662-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240705150431.2274662-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: 732100d1-5583-45f1-f453-08dc9d03ce7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hbj4EsHVO88WaIJpvqcfXN1pjtpxpd4AlJrYVOIEs2wR2KkBq53y4DamfoyY?=
 =?us-ascii?Q?k4qfSxnkuFgpq5q41oT+Z3tItXcO3KkReoxspzc+Qk8X9NhfXVepdXHWJFZo?=
 =?us-ascii?Q?Hdtty+3+So2tZDi3diWxTLSkYiwu15HQgTM2CKWcwFVwsO5/5ZC66x5kR0dP?=
 =?us-ascii?Q?9qJebfrmfZhDm93rnEEnli18HdNHBN/PgpQZ2kAFGW7FZso7lPp3gDIe3h6O?=
 =?us-ascii?Q?T8vRpdjjlMErJ1QUWph05cN2bbjtCe80kmy1WWKYDMsRWfZOeXchGo5XjG8r?=
 =?us-ascii?Q?UXkXu6pceO9uXceI7avUT2qqKxzcvNxFOwgESxdQLp9PMxbc80+8P29l9Mun?=
 =?us-ascii?Q?UFeMZEPQX+jPrAh4YAIPjujaNDRuiZqQXzOsr5kFgNiM3uX2+WfENuHEreD1?=
 =?us-ascii?Q?ObfpaVJyFCgAhhdqXLNQ3pgS+LY1iZ/Qu0DiJ/m317NDTnIA6NbKNGAWT+V7?=
 =?us-ascii?Q?/HUDDV5ORf7iYmVX88mR1MbKcbIYl0eGUpoO7uLgIoJHxNFnp59C3Ki9vIPL?=
 =?us-ascii?Q?pijgvOnF03Isw3S3lyMdR4ShobUS5bAvBNnViFMpTMKd/OekZusxWYwPKcpM?=
 =?us-ascii?Q?+/paObNS0fs4eehVklHy8PaSZIrY3ul5v5h20VKC9LXS4Vd0t9prF3flvZrN?=
 =?us-ascii?Q?957DzZF3iBllk1ZCbpbookAiupSbBPup45glgEoFOkYViFWRU+tnmSwlP1Fi?=
 =?us-ascii?Q?HcxrhvPLYABuj+ypJpxs1qogeCHucjvzRBJpGiCnpFPe+ab842RcBzQB1Fx2?=
 =?us-ascii?Q?TLLtRnRtOv6yhjAf0wnh0h5NgwOXWClZSvXlIcJ0bAIEhbKJb67pnpgbSUnE?=
 =?us-ascii?Q?9ForTi2EoymWnW+qHcS4om1HSKzTjEvND6xe9+mEwz47OvEkPyvPpEFfRG+q?=
 =?us-ascii?Q?uXFzHJYi6AI4/Sf4VdMz8hcqPkqOUGskfwPINkvPcYZr1tMKrChqPW2evOxK?=
 =?us-ascii?Q?Q2/FGoy3DhsiietLr7n60tTsJNS4LAaJNGb/T0WDGOBul7o2HZhpghZWXpxi?=
 =?us-ascii?Q?3XwEEPctbZFWzipqVRaNC9zJTLuMfbs1MUkIqbA8fLYMwLFXFxqsKOkzwEno?=
 =?us-ascii?Q?orgwNSuGSMleyQ+hCRBeBF3rgjHu+xw/VzlK5cPdeq8Ao3qQKSM7TnXr4mB8?=
 =?us-ascii?Q?krM5+AuHj25xBhKYbEeCZ4rKOIqeZEMhDqRJG07V85tyHTJSG0jzJ0GxSm7x?=
 =?us-ascii?Q?m1Ef/DBdW2OV9hN4LFUNiug7r0v5/LtKvxkrKYuUOBRk4jtC1MKtGsdeV7Ul?=
 =?us-ascii?Q?lfhiNcqmusIQMQfhfiiDO2KWekH09BhPifl6wtYu+qqgVhIeSkAqQ3k8Gshf?=
 =?us-ascii?Q?OXe9Np2UbhEz8yjNSksR1PAvjs1v9ASt0GHDiYYrraKuWvWz6uxY/q8lHFLT?=
 =?us-ascii?Q?4f4R8qxhrF8gu6Kycb4Jt2ouxSj3DvluL7JlqE1sRUZM/PpFxHGYtdx0gKji?=
 =?us-ascii?Q?gjvIOkMQvCA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zeABju08Q9AjFRbb7o6X6OcEZ8HG2iaEIy1ETlyKVoe1+yLFqVI0eN43J/EB?=
 =?us-ascii?Q?KQcQ7qwW0zR/mhP/gaGFb/CTbJE3dJtHIPaVX/gUkGK5YrLwzE8c5yeU+oN6?=
 =?us-ascii?Q?/Uc14JfFlqpMGlHPqoxKwkHY3sYlJc7maSmbMoloTuQ62T6cON8aOD16Zpvi?=
 =?us-ascii?Q?Gl39ogCh4/WovSIHoNZGsiLIGGqdQFiV3pO83mrsuIrgJIbF2lEzBhgRy6fU?=
 =?us-ascii?Q?DxIFJ6/LKHSm6JeCGm8y+na9jUfLuViOSK7+gf0AX2ddRAJW7zwBWE6fzMBw?=
 =?us-ascii?Q?Mo2+OVLkz+Jb+LpRdWbMWknz7DixOU9DnU+YDE1sCjZuIVHEPIgAPKoF8FjA?=
 =?us-ascii?Q?BXKkdtHLiOfY9Ig32Q3W/hU83t4Gh7+4xWr4FyV7Q76m3oBQYjuZeUXS2Z+d?=
 =?us-ascii?Q?fnq5ea0Z+9SImN2dZXn1VWnMt2nM/fARIqYLNJpCJyAaZvlcGmZqnx4N9Q2x?=
 =?us-ascii?Q?9Fh2yMhEA38nBy3WMs/Ia932yf0zP1y+Wts7AOSf2tCfbHR/tB9G3uKBTrz+?=
 =?us-ascii?Q?F3FZH5NZEhIHLoejlfTG7FehTqKwsKr+ndyOoapAyh9qAcAFwYKZlS6IJ7t6?=
 =?us-ascii?Q?eggZQeh6/8uImfuoDLWYHMnUuVPCItScYV7ytWSdJv5wiufM34Os7I3obvtK?=
 =?us-ascii?Q?aNwxiutOnbvRRJ19rKTN2PamMTW7dHU40fY/wyzB4M48mO1BjSGzz8gAUpsc?=
 =?us-ascii?Q?r3uzfSWh3LECXspWNMkhE4OT47aMVxm8HweXIFthCtG2Sh3mVLDJA7UV8+pl?=
 =?us-ascii?Q?iwpJPa5pa+VMkS2qK3LSSaesqJ0kxP6Yn4rF8UIBKPfOiVFAtcfoXGMP8NG4?=
 =?us-ascii?Q?TIRu+8zqdoPekQnHecsDwE+m2tIUHQn8HP9J7yx8IH+I/g/5e4Tmz9VULDKn?=
 =?us-ascii?Q?1b8MsP0dQ0uRCyDRQhe0C1kO44Qnm+TXwGVktdXC86kMDBDV1ACyDRxUP9L6?=
 =?us-ascii?Q?xqvCpmR7rJRHkz9ZM7q6DoqfxScPAJIQSKl7iQYda6/VScpAy4gwi/JlwJqq?=
 =?us-ascii?Q?kOfHyiGAoepHiUcjPw7WeRvI48HHZ2Kg5CWYgBOJET0ZVnjsmJZvxLzo/1U1?=
 =?us-ascii?Q?OjVINcanQTKsVzZowHM7ya7R0Wsggd74+ze/pspwkdowAByEB6YEXEca6YgV?=
 =?us-ascii?Q?NgbhycqGV0qheKvdTLu717NUy98e1k8C+WEBu4a6RReOHBpiZ4ITy6Ek2QcC?=
 =?us-ascii?Q?YYg7g1Jq2YuodnbEIICB5+XEWUQzJykM6lnHp3+fU2EvTuSEuOoXRo609fYO?=
 =?us-ascii?Q?c/iyh2O8NDOeD809B8lHyZUmtASTBjQLz8NSBrB3AYCf+b/krPKghuzg86rX?=
 =?us-ascii?Q?cKYJ7mxH1aQT/JKwe5j/6N3WyGZdN4+tKGN8XBmiWGvnsoiY30ZSHce1PuVV?=
 =?us-ascii?Q?xWs6sLhJceUEpepceyaWrae6Mae55xnWuIDHW67OYHFQISeejOdfi6zOvh2k?=
 =?us-ascii?Q?QDjQfnP1tcI3iOm3kphGjBTxP2ppNiPP28XsQECHtX2Oo66QOxBiAzLL1Uht?=
 =?us-ascii?Q?37nr9lz+w55PadMH93HR2csdFjzyY95dtNvgPGEviA5qOLVLL5sEdT52flZG?=
 =?us-ascii?Q?O26MmhouJa/8Wt9Q/WDI9s/fMue8Vy0EEHr4iPURYVNxyod1SJjA6pGJT1vG?=
 =?us-ascii?Q?71SgcL1Pv7H7Sxyxl8/16OI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 732100d1-5583-45f1-f453-08dc9d03ce7d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 15:04:45.6283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyTuQcigN5SbtunFe3HvUpwKLLJmvA/WPgKBTjFyYjPS6Fh8JDCaDU8iiMDE2kr/deCYfWgJ0nSpVa+1acPFZBzYNbp19OetmBjdPzWant4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9808
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

Current TCP code may miss an option if TCP_O_NOP option was used before
it for proper aligning.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 net/tcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index a713e1dd609..c9bcd364ee3 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -476,7 +476,7 @@ void tcp_parse_options(uchar *o, int o_len)
 	 * NOPs are options with a zero length, and thus are special.
 	 * All other options have length fields.
 	 */
-	for (p = o; p < (o + o_len); p = p + p[1]) {
+	for (p = o; p < (o + o_len); ) {
 		if (!p[1])
 			return; /* Finished processing options */
 
@@ -491,12 +491,14 @@ void tcp_parse_options(uchar *o, int o_len)
 		case TCP_O_TS:
 			tsopt = (struct tcp_t_opt *)p;
 			rmt_timestamp = tsopt->t_snd;
-			return;
+			break;
 		}
 
 		/* Process optional NOPs */
 		if (p[0] == TCP_O_NOP)
 			p++;
+		else
+			p += p[1];
 	}
 }
 
-- 
2.39.2

