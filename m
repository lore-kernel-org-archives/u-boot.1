Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFCAC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 09:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFF9688B6B;
	Fri, 19 Jul 2024 11:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ph3pVG64";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1465E88B3A; Fri, 19 Jul 2024 11:12:32 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F12EB88B19
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 11:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFGKL4teTpzPkCaij2fX+Y+xWDP7Iw3TjLgLhVgaBi3/U1S5Xe3VK37iXCBIRm/ypLWhZg65g9JRPT7h3Z1nnDdj08cYw93XQSa3KYMX0/KCnomvQ2PTPAmKklXwbxqnvnEiC5guglk6OpU0YgIXw+dDbpkY1SfIskPcPhOYDhfJrWz/XN4PRBCcv8jsLncaMQgmAvIv2YCKgkoTA7icfFnzomEdUH5gF74/drOu53aroNGwklg6XMkbFcOU0qbJIO7m7tISHRLMVTb/ep2cni1IlEUlk6CcPqMilQZDG/wgIvO7SyiW8keMhWJCbEgO5q4ZJtoMbprOSW54Xzkj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70/a21EVbigo3D+t5+J0b7e9I6JhgTfYgP0eEU050OA=;
 b=gF+ZpkeI1z+xVvlrU7MiGJA/1VuZbfm7FCMFqtDpSZ4+Icn3pzDuTQLywUgCmwd57pU584HksGShHApVM9fdJrIgHf6cjgwf/JKiveBtoXCQZGFsjzvz1PDc4sQpKcV6fNt9oWPHn8LE9jOZCI033eH5x0xcXjsdb3CDxeCNXKz+wSVR+3yKx4DHB+NdB5q/opprKkTnypCnUYfMMuQ2RER0n8ABiJs5ibxW5EgPf22u2+dQS0Iz+lhhbx2YVK9sQE5Tn4WjYuKXApQbR7HbRLR5VKTpEnrHplhy/KDgSh5xgpPoyslp6MFtYA1XG+kGKhE5TfCSU2LqxDqbfgnxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70/a21EVbigo3D+t5+J0b7e9I6JhgTfYgP0eEU050OA=;
 b=ph3pVG64W7xRa1LZHSWwhprYdn44QsSmxUEhKGXGSb4swTc6Iy0PC1S7w6VJKrsD6uiep28C1X9gvD7nrVw28wzzjAtFkM/chzLkrgz+Wj/dlsbbJ2kdOKP9ojoVGO/59O0YnYrbedH6fEGJ0bIu/faqk+/vVCGg8lwZTgTLVDH+7ApODc0T4IAL8WgGvYGcUIuDtQNG1KSOpHzpQtZ0It4txv8zOKERR3C7zgPkeBiAxZtQJsumlvksPYRxD3PgzAlzd0rTRVrMkKVRbxLYNYPbxPZhiKwGMt+qDSW+b2h7mkOTFWc4U0bwPFQkGGMkFQfkF4yxvPEE9QEgA1KYzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7402.eurprd08.prod.outlook.com (2603:10a6:20b:4c6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 09:12:28 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 09:12:28 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 2/3] led: Implement software led blinking
Date: Fri, 19 Jul 2024 13:12:12 +0400
Message-Id: <20240719091213.3757300-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240719091213.3757300-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240719091213.3757300-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0029.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::20) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2e0967-44aa-434e-56af-08dca7d2e967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OqoMZhiOas46n7TrUdsWGzZ7SJi+inIeTVSjHN8tRvFhnmvSrvn6m6zlDUoT?=
 =?us-ascii?Q?EV+V/m42TGI60ZqJKVcLAJ3H/fe7joC3/YZcPTtG1ZxZPPQwuWwMj4gME6LH?=
 =?us-ascii?Q?TMZVqwZ5l+a9amTgneRD4w4DKfxxNsvTm2jzx6oCY/HIvKd1hDyoZu6BpJEI?=
 =?us-ascii?Q?lIZiJ02m6/Hgc2gm9k4tX0O92FqIjjsOh9mvfnsao8Ol1Wn5qq98+IBj4eoy?=
 =?us-ascii?Q?Fg8iLVwDw5+09lfAxuMHaQFiaQ7IQ55hle6mOl4o0FY2c1Yh0byczc8x8abk?=
 =?us-ascii?Q?mvlXd5G1rL3RIQClEMMKlnQVfZhjfkqBgxLzIi1LgbflHmZpWRXBc9mbIykg?=
 =?us-ascii?Q?S3SnV05Hb9wj887nc3c6I4fBN2EHMUZFFJx3aKPVg2+Jg+5c5OywYj0z6BGQ?=
 =?us-ascii?Q?ioHexvtT6SPIbnwY6nEQ70Q+cgp1sjEqISGwv1vrMJ0S8cAEcy89IYatnBEC?=
 =?us-ascii?Q?vcNHs7XVKjmiZyPZmvCUi+j13HXI5Qpo+QlzAkHaKzhBscog9gAmeWPfMVxi?=
 =?us-ascii?Q?Yp15XA1A2iN1w35hnGjsefD5xl4w8xoIuKAje+fhf0E2KadMIZJZz7rH3aTF?=
 =?us-ascii?Q?wt9QF59BSnINLHP3/lKDCdK5RFafc0+JjFPAiTtHganFYQQLXzqE9p/ww6m6?=
 =?us-ascii?Q?rj5iJO8Ph0a+ACFYUZuk/Yav+5VorlTDAtSDVlsajD64mfVxUCMM8b/gDeHV?=
 =?us-ascii?Q?hQdAv7k0bZJ73i37ynRLIdZORP5CObF3NZE/97g9tOo/gt31QMdYtWzhoBhA?=
 =?us-ascii?Q?ewSjrDD2+DQSBOHbA8rB6e0ianaR32RrgE7+42f8HdkoN/DQS4qe/mgCeXUF?=
 =?us-ascii?Q?L5MEcpvbzxiDf87jFB/vCzRRau44K32e2gRN4sDbye1BNppcsF+ochh9khFN?=
 =?us-ascii?Q?IHkvWwAb6b934TMNfOJzNbuyUn5AT8twRgdVIKMY1P0wgHuCfbYrMZS2LzEl?=
 =?us-ascii?Q?pT4sWqxmEhWWb9EGLByq2r7nvjJAh9/DymPCs7nJflItJSeJIYiEvz10jGe8?=
 =?us-ascii?Q?/vID1WxX9Z66zDyDcN288tjQKH1G2cJckLaqZ5SRwu+m7ELZyhMX5FDGrQ+X?=
 =?us-ascii?Q?cwW4zKs2+ld8zTzegg/OUdINYdhLddR6Ya68Qt4MfGZXMDv+W9yAukI3ZZlw?=
 =?us-ascii?Q?DG+g6hb8+3VN5zQGMzgPQEsL+ExN8P+2KUPKF9rivzhwT6vf3FGmXm3GnaQ1?=
 =?us-ascii?Q?ViLwimpV4JDDbBoFIr2VuEUPKhDVsN+vq6Su4haWfdzBsAQZjfVG2y8HBAhl?=
 =?us-ascii?Q?Q/xTvQvoPAknsQClZRoqV4wQwKbLv/KwwKInX3g+Sb71lnrXLF1wR+olwrp8?=
 =?us-ascii?Q?yhK0LxEao5JxqWvBOqriJQUlpwZSAOnhjaOquaSV8jto2i57Sw9fQi3btjds?=
 =?us-ascii?Q?tePknqZ/sKN5UqeriVrdyTC4cRZKEFwZ6cT9f6bz7PpTbMmX/Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sdUnWfNVXAHDr1QQ73nPzFFKQFrIfbgTZDBqxCqxJboRgO4DvfhITylAjUuZ?=
 =?us-ascii?Q?nLlWEynK3wkbhyccAU4H2tBIn6rDW/C2gS8qBlQDb9QW3MtjDlXTngR5cUC0?=
 =?us-ascii?Q?vcf6isqhZMupbRKHGtFBbNMKpHn9+o3rK8M4BbqD2rCfy40A5W0Hbm2Jie2W?=
 =?us-ascii?Q?r+p8WOqLB6D7ySD6hTMylwMGJ32/83PVXwBY61i/1DN+Gwyz/kdf9Rm4BWrf?=
 =?us-ascii?Q?mUHxFVDVgXQtb+Gw0hq7EU2AxFMmg18UDaZGCNekhsvc749uEbvE7PQ65yat?=
 =?us-ascii?Q?pIvaoz4jFp/+9vLjJMotiHXLqAXfVsMYrHcI+sbLMHo4JSpiAFxn24EFvw1R?=
 =?us-ascii?Q?3VtOU38+L9YPhV4ZyGWe78i+Nyomw8jr51aQTLve1G+3/VU5VMhlyeKEkxTG?=
 =?us-ascii?Q?HSiTfxc6RRF/L1SQ50m11nBC6kQl2wg2c8/rXts0XvtOlGLUvd9nVrVIHxB2?=
 =?us-ascii?Q?6e9L6O1K0YELAmndvTVzbI4arsxRSeCcX1iG3KqwX9wM4+lv3vgCFED4U0Uc?=
 =?us-ascii?Q?svCOqe3YaxBM5pOXTWSzTCAJ2gG/0nWYP9lhphzfvTfrZZ/MN0vodrd4NYIh?=
 =?us-ascii?Q?ifxtli9KWNHTOQzeJDlTCy973W1Bugy0Gtwg9wy/TIfexEWDuXEyDDKSAXxK?=
 =?us-ascii?Q?6g7ZiU0u9h0pSJC4kxM/LyOY3Ylb+MPfcgaOYMeJFIS6Pfh/Oa5y060iPi4K?=
 =?us-ascii?Q?rO2qnVcZGL2BlDW/K9IV/ZfqlK3A7xEnDtfaGnuwoipWpvhY+kZHWSU07NtJ?=
 =?us-ascii?Q?+sHAKu8qCupmkPL+5irt20FtulKfqKp3QJY8tQlOlArycEB/3Zvu8jdYvaV+?=
 =?us-ascii?Q?uaa+3S2Jy0u2blE0CVhQILWJEFVek6CMSQt6nGIJkX5s0om9S2LDT6Yfai58?=
 =?us-ascii?Q?D9lG6/8NGvzPzWXzrzz52EVNl0OiMVYQTG6aFXkvL4FAJ9TeHiaIMGOXCO6a?=
 =?us-ascii?Q?DVQv5ha4Rxk9QGgEneJyHcLrqfxjkfDXyUVYGy2KL7PBW7XIyAHnFscAjr/t?=
 =?us-ascii?Q?yBP3QLq8nNSeDAgaKjCqnquqnDPUoNTmlw+9SRah0IKObwaOC+k1/aOZmY3a?=
 =?us-ascii?Q?t0TmpKEMV5jSNKzG0fkVVbOfmvKn3rrKWL87VRVtqpAGj5uBBB7spleK2kvg?=
 =?us-ascii?Q?AUHfY9FKx7fM7Fiis/SafeIeiJ5n6MGO4gf8FhwJIxugsnutK5rxQ8MfbKEH?=
 =?us-ascii?Q?T/uEJ66qYjxcQ/SKy0BWvQU7kmTdjvz7sIeQ3uGpLE4cpFTS1mHQtmT9HiYe?=
 =?us-ascii?Q?IjFdfNkmiASmzYHfMN42kw1jHmgPmwAD7eO9vvS2RbqKUsqbHv4jMyFmn3s8?=
 =?us-ascii?Q?PV2ySsw94ZnDx3samvJY1Kn1Q0/jtR/mmsITeVZaOQaz5KWXjv4a7bBBH/vO?=
 =?us-ascii?Q?DO0OiO7kHMF+xygZADwspvSm396/gx1i3SLzPqrHBR30g2bUHKOvakuNs6qO?=
 =?us-ascii?Q?ONwJkAARFRhh2i79Zb9TGHXWb6tiAfDKyOhCCajrPKXNj2lVEBggDhcfUmDq?=
 =?us-ascii?Q?nK8EyINnyIlo9RGqyDRcd0oc5g1soYdY2dt4wpYkM1hjEi9riuMR3wmQHBlD?=
 =?us-ascii?Q?TOoB07TixQUJYpn0snBNkqlO/G38aNjQLEWbR+0LT6zdZIUlCp2acceTd9FY?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2e0967-44aa-434e-56af-08dca7d2e967
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 09:12:28.2216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9gpwkt+Q+3WzusF1w8HQYdSo9aJZXJKcJ8mZUpPJ1aJ5BsIUuJQsykL2zCQwN71zATAAcjR3u9lpA15SVpXqShqKeB61/Al1mSiMOSr0kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7402
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

From: Michael Polyntsov <michael.polyntsov@iopsys.eu>

If hardware (or driver) doesn't support leds blinking, it's
now possible to use software implementation of blinking instead.
This relies on cyclic functions.

Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/led/Kconfig        |  16 ++++-
 drivers/led/Makefile       |   1 +
 drivers/led/led-uclass.c   |  11 ++++
 drivers/led/led_sw_blink.c | 117 +++++++++++++++++++++++++++++++++++++
 include/led.h              |  22 +++++++
 5 files changed, 166 insertions(+), 1 deletion(-)
 create mode 100644 drivers/led/led_sw_blink.c

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 9837960198d..bee74b25751 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -65,7 +65,7 @@ config LED_PWM
 	  Linux compatible ofdata.
 
 config LED_BLINK
-	bool "Support LED blinking"
+	bool "Support hardware LED blinking"
 	depends on LED
 	help
 	  Some drivers can support automatic blinking of LEDs with a given
@@ -73,6 +73,20 @@ config LED_BLINK
 	  This option enables support for this which adds slightly to the
 	  code size.
 
+config LED_SW_BLINK
+	bool "Support software LED blinking"
+	depends on LED
+	select CYCLIC
+	help
+	  Turns on led blinking implemented in the software, useful when
+	  the hardware doesn't support led blinking. Half of the period
+	  led will be ON and the rest time it will be OFF. Standard
+	  led commands can be used to configure blinking. Does nothing
+	  if driver supports hardware blinking.
+	  WARNING: Blinking may be inaccurate during execution of time
+	  consuming commands (ex. flash reading). Also it completely
+	  stops during OS booting.
+
 config SPL_LED
 	bool "Enable LED support in SPL"
 	depends on SPL_DM
diff --git a/drivers/led/Makefile b/drivers/led/Makefile
index 2bcb8589087..e27aa488482 100644
--- a/drivers/led/Makefile
+++ b/drivers/led/Makefile
@@ -4,6 +4,7 @@
 # Written by Simon Glass <sjg@chromium.org>
 
 obj-y += led-uclass.o
+obj-$(CONFIG_LED_SW_BLINK) += led_sw_blink.o
 obj-$(CONFIG_LED_BCM6328) += led_bcm6328.o
 obj-$(CONFIG_LED_BCM6358) += led_bcm6358.o
 obj-$(CONFIG_LED_BCM6753) += led_bcm6753.o
diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 4932b901142..e6312d1dc41 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -58,6 +58,10 @@ int led_set_state(struct udevice *dev, enum led_state_t state)
 	if (!ops->set_state)
 		return -ENOSYS;
 
+	if (IS_ENABLED(CONFIG_LED_SW_BLINK) &&
+	    led_sw_on_state_change(dev, state))
+		return 0;
+
 	return ops->set_state(dev, state);
 }
 
@@ -68,6 +72,10 @@ enum led_state_t led_get_state(struct udevice *dev)
 	if (!ops->get_state)
 		return -ENOSYS;
 
+	if (IS_ENABLED(CONFIG_LED_SW_BLINK) &&
+	    led_sw_is_blinking(dev))
+		return LEDST_BLINK;
+
 	return ops->get_state(dev);
 }
 
@@ -80,6 +88,9 @@ int led_set_period(struct udevice *dev, int period_ms)
 		return ops->set_period(dev, period_ms);
 #endif
 
+	if (IS_ENABLED(CONFIG_LED_SW_BLINK))
+		return led_sw_set_period(dev, period_ms);
+
 	return -ENOSYS;
 }
 
diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
new file mode 100644
index 00000000000..9e36edbee47
--- /dev/null
+++ b/drivers/led/led_sw_blink.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Software blinking helpers
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <dm.h>
+#include <led.h>
+#include <time.h>
+#include <stdlib.h>
+
+#define CYCLIC_NAME_PREFIX	"led_sw_blink_"
+
+static void led_sw_blink(struct cyclic_info *c)
+{
+	struct led_sw_blink *sw_blink;
+	struct udevice *dev;
+	struct led_ops *ops;
+
+	sw_blink = container_of(c, struct led_sw_blink, cyclic);
+	dev = sw_blink->dev;
+	ops = led_get_ops(dev);
+
+	switch (sw_blink->state) {
+	case LED_SW_BLINK_ST_OFF:
+		sw_blink->state = LED_SW_BLINK_ST_ON;
+		ops->set_state(dev, LEDST_ON);
+		break;
+	case LED_SW_BLINK_ST_ON:
+		sw_blink->state = LED_SW_BLINK_ST_OFF;
+		ops->set_state(dev, LEDST_OFF);
+		break;
+	case LED_SW_BLINK_ST_NOT_READY:
+		/*
+		 * led_set_period has been called, but
+		 * led_set_state(LDST_BLINK) has not yet,
+		 * so doing nothing
+		 */
+		break;
+	default:
+		break;
+	}
+}
+
+int led_sw_set_period(struct udevice *dev, int period_ms)
+{
+	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+	struct led_sw_blink *sw_blink = uc_plat->sw_blink;
+	struct led_ops *ops = led_get_ops(dev);
+	int half_period_us;
+
+	half_period_us = period_ms * 1000 / 2;
+
+	if (!sw_blink) {
+		int len = sizeof(struct led_sw_blink) +
+			  strlen(CYCLIC_NAME_PREFIX) +
+			  strlen(uc_plat->label) + 1;
+
+		sw_blink = calloc(1, len);
+		if (!sw_blink)
+			return -ENOMEM;
+
+		sw_blink->dev = dev;
+		sw_blink->state = LED_SW_BLINK_ST_DISABLED;
+		strcpy((char *)sw_blink->cyclic_name, CYCLIC_NAME_PREFIX);
+		strcat((char *)sw_blink->cyclic_name, uc_plat->label);
+
+		uc_plat->sw_blink = sw_blink;
+	}
+
+	if (sw_blink->state == LED_SW_BLINK_ST_DISABLED) {
+		cyclic_register(&sw_blink->cyclic, led_sw_blink,
+				half_period_us, sw_blink->cyclic_name);
+	} else {
+		sw_blink->cyclic.delay_us = half_period_us;
+		sw_blink->cyclic.start_time_us = timer_get_us();
+	}
+
+	sw_blink->state = LED_SW_BLINK_ST_NOT_READY;
+	ops->set_state(dev, LEDST_OFF);
+
+	return 0;
+}
+
+bool led_sw_is_blinking(struct udevice *dev)
+{
+	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+	struct led_sw_blink *sw_blink = uc_plat->sw_blink;
+
+	if (!sw_blink)
+		return false;
+
+	return sw_blink->state > LED_SW_BLINK_ST_NOT_READY;
+}
+
+bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
+{
+	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+	struct led_sw_blink *sw_blink = uc_plat->sw_blink;
+
+	if (!sw_blink || sw_blink->state == LED_SW_BLINK_ST_DISABLED)
+		return false;
+
+	if (state == LEDST_BLINK) {
+		/* start blinking on next led_sw_blink() call */
+		sw_blink->state = LED_SW_BLINK_ST_OFF;
+		return true;
+	}
+
+	/* stop blinking */
+	uc_plat->sw_blink = NULL;
+	cyclic_unregister(&sw_blink->cyclic);
+	free(sw_blink);
+
+	return false;
+}
diff --git a/include/led.h b/include/led.h
index 9b24a4ce188..8270d6cef93 100644
--- a/include/led.h
+++ b/include/led.h
@@ -18,6 +18,20 @@ enum led_state_t {
 	LEDST_COUNT,
 };
 
+enum led_sw_blink_state_t {
+	LED_SW_BLINK_ST_DISABLED,
+	LED_SW_BLINK_ST_NOT_READY,
+	LED_SW_BLINK_ST_OFF,
+	LED_SW_BLINK_ST_ON,
+};
+
+struct led_sw_blink {
+	enum led_sw_blink_state_t state;
+	struct udevice *dev;
+	struct cyclic_info cyclic;
+	const char cyclic_name[0];
+};
+
 /**
  * struct led_uc_plat - Platform data the uclass stores about each device
  *
@@ -27,6 +41,9 @@ enum led_state_t {
 struct led_uc_plat {
 	const char *label;
 	enum led_state_t default_state;
+#ifdef CONFIG_LED_SW_BLINK
+	struct led_sw_blink *sw_blink;
+#endif
 };
 
 /**
@@ -116,4 +133,9 @@ int led_set_period(struct udevice *dev, int period_ms);
  */
 int led_bind_generic(struct udevice *parent, const char *driver_name);
 
+/* Internal functions for software blinking. Do not use them in your code */
+int led_sw_set_period(struct udevice *dev, int period_ms);
+bool led_sw_is_blinking(struct udevice *dev);
+bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state);
+
 #endif
-- 
2.39.2

