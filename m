Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EA4C3065C
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 01:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7982688528;
	Wed,  3 Jul 2024 03:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NI6ooFK+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 376998877C; Wed,  3 Jul 2024 03:02:30 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 817B38852A
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 03:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3mtZ73czCk8SpWRlkr+x+uyI96WQap4mm7NPzaXW8ct8gFIOzlsW43tUQwp8IB15gkcO3kS83EYRl9phethaSKei5Ekjm8o3nr9603Bshct2eLjHFZe2fIGrnTOVCL+UZWQ9WNXOnpj2O0G0kovYdunT2BDikrnFr/cRPF8NbfotiCg/72ukP1Og7F9OU31LJaauBOmeL6PJfDokRBlbXR55/lKImZsTZ0dTcsicgpnKDzrPCxgmVOleBr0d9yxAhWihOo+WDhyc4pqlgGcYSEmbBKrbh1UzS+/GWUCUk/caof3kkwVhVOjD3WIuyTq8XbEX0gVqNt895I4uGokOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9my4k93dtWMgpDnvYGC8sbR9VZU6AgRt6X7ZxlwQzzg=;
 b=ltF43mKq2l+7UIfQEysirvId/dcPYtXcQTWmFcZV5OIoKZY6gIBDY691qTppTN/mR6pyvSxboE1CXysqNdFku4oEYGr4rsj6QwCI48RtuzQ4KRJ10YZngJVUjYaV+36SLW5SJ0hvQQzTjiqsUMLiSTTfV/lWb0cP8Bkl6VkRID7nNzzg5HC1r5XI4zBBJGjASQhnlaNQx9TZmxCRYunA5k/ciH1StMFzB4Hsb4cgaKQNNJtXmej8GSLKldxVC0VpKAWlyfnu5hLXf5xSlBo61fpJBToAgaxQWUlaIyHjeDLvUICZqG3I5LGcXyC4PAKgwRph8Zgz62my1evIaI8ADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9my4k93dtWMgpDnvYGC8sbR9VZU6AgRt6X7ZxlwQzzg=;
 b=NI6ooFK+s5sGeVPLLluoSVGlybejE/7MSwy3TLAzhVBwX1pnpudcv+7P9spVYYWrtRlS4ASiJDsMpvmFsUpK4zOITplyH1l5j+gkXR79s91qMex9cK5QK1/L6KdjDIkvi+o+7Ji+tzBmf0VF6EMA1uQU1yNrg5KK3M+p9RtCpNg2ndK56sS2me3c2Tzv8gKVqloej4tdm+BnVouuhbsLB6iKH+cPrSNUHV6GgYrGwH17DateLoMb7yoZ6/iqdut7xbVGMY4jqwzrMTLB0bETHHEBV/IgbbdhKKJTXxDYUoI37ZfH/Xx9Sm4uKJg+gWk5krxIpq03qEO16YpEv6VahQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6013.eurprd08.prod.outlook.com (2603:10a6:102:eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 01:02:26 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 01:02:26 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 1/2] led: Implement software led blinking
Date: Wed,  3 Jul 2024 05:01:30 +0400
Message-Id: <20240703010131.1735100-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240703010131.1735100-1-mikhail.kshevetskiy@iopsys.eu>
References: <CAFLszTihEQVMW==2V2Vq9GY_JffKWFgmarshmXSJFkCFyg4pXg@mail.gmail.com>
 <20240703010131.1735100-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0130.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: b52f017e-cf11-4590-e697-08dc9afbcdce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q0EhSyYA2w4JWcCOG8b232dL7mJ9ru/aZ53CMmQfcF8xl/PxfzGd9hMucaiW?=
 =?us-ascii?Q?nWW5kOUVp7Hdr7/V0lSMQPJifO4M7Whn6oeD6mitpPNT+pXtYyU4SM8E3uNH?=
 =?us-ascii?Q?VJW1DGULYgwef0SU5IJsAWhvhWnP0Ber6iP75/SY8B8vCUndLwKWTjTBo2hO?=
 =?us-ascii?Q?VV1FAzlLdzIwfEMI9nU9qriW44MFiUBZSbO8w6QA3AB3YMYCxPLaP5VdYtDF?=
 =?us-ascii?Q?waapMuPS6wLDY9H6EtzI8JzQdrBSATlWWHJLAJId7b2ZeTB0jcgPFbc604fQ?=
 =?us-ascii?Q?yArjeAUujkFj68U+M0Tig3YehUge9ER0rwGvMsBmzSgRrbQnz7Qya2swJ8nR?=
 =?us-ascii?Q?OKB3R2W0v7WosGoXZ6zNmoX1b/w5+lkB1UwcEtuY2QYpCGhxyqY/uZbekjD9?=
 =?us-ascii?Q?VaMcwacvqFcHao1/czqDLrBGZneZ12OfQTp0s6Z/YYLPDR/4xclGkArh5ZfE?=
 =?us-ascii?Q?H5B915HVO9oIZ/naFgqeoB/DSuqkwacpOno0oJOEXwmM5lDD7/gzh7ZdvsTL?=
 =?us-ascii?Q?qE6nSeTZJ8A05JHUkOVoJQv5Fi0WJsbATuqO7cvbiwFKGL6yjZ0tCCQucpWh?=
 =?us-ascii?Q?J818D/dDdVTtDkJyriRuKLHO1kQnOKSzEra7Vs+88wFQhpREOgr6Gqm2f0Dz?=
 =?us-ascii?Q?t51AibeeIo0RyxPw9DIhhG7UiFm3A52mqAMWqjZ6CnUvJ/QutGotLG7TSjne?=
 =?us-ascii?Q?Q9X3aMi1YLpgX9YVSUjrxX7sluX5+rLae9lwv1cul8xW27aiyJZVGwa0FDoS?=
 =?us-ascii?Q?kM3eMb86/jmcpVHtsxXlWb13JSPNnc0dFIzoEOEI8zNCZM4u6jRBnoEfgOaG?=
 =?us-ascii?Q?PAtcmD+Mth+hRa9DeOimFNYspimGJ76LAFdnCWD0KNTzql8d7Q8a1B+7idLV?=
 =?us-ascii?Q?vpPjbH2H6CxWZsBJMjTRrRSce/Hn7xGGpXcidG46UsUKW28aY2dPxwsVJQTy?=
 =?us-ascii?Q?Lhf8izH5jv+fBhaobROo67XJ2K/sbq/XYswiWkXQVbGvwmt4rfy4SGKOoyNM?=
 =?us-ascii?Q?5ficx8g8CtZxPG9rfsjFSU+8G1dlW9d3tjkqQMOljVHym8taX6e/AaGi2lpo?=
 =?us-ascii?Q?IcHtDlpCiNC6sWYlfQrhbgYVy6Y8mvWgZhPugj84yVkwHEo/d5VfKhUJAoPL?=
 =?us-ascii?Q?n/3rIHN6BKui8xS24TrJNqkl/CVmgMGg9FJiQqmj3ZwEbxe5NMI6lGAxAODW?=
 =?us-ascii?Q?CLGgxpLRc+OuCxwS1E/12yPPcl6iQHChA5CtmlSibglmldk3tnpX3XSvY/4x?=
 =?us-ascii?Q?ow1rIqo2F9+T/QosZdvz6zwjlHUBk6HNR0xPC6BvpmlDbXkwO4VyVtP7adDb?=
 =?us-ascii?Q?07DbmZTlMlMcQrxuh2QXiup0d+26l3MwBtA6f6BhNJT6zK6LukfZsMt1PDWC?=
 =?us-ascii?Q?EHy2i8JspECtKVbwR5ZYplYsF5RLgfZtEzgcvXeXKVgdwOwpUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?37TPGNZDWg9AJz0n4enMeFuqqzco7lJnBd2NR+UEl+tReY/VQBuch4xRS3ZH?=
 =?us-ascii?Q?bLYwFjd7NhVLw9yUUSY0znUMTO7ghsxRfACfCrLV/8p6ZYfeYeaH8pwuoh3S?=
 =?us-ascii?Q?GNlQKCAq+b5F3pr9CeB6sV6TfmeVWyA0PbUFs89zXR9zXbGCqle/G5uVdXPM?=
 =?us-ascii?Q?yrygZv5Vek5eBVk3Y0j31xrxybmSsBL556mw6ftstTeO6jHxEEb6vvy5/2eF?=
 =?us-ascii?Q?IXNrif/6HipMcapZe0ag40bOsthGLBDQ+eU8f9D7Dy1Kn9QXTt8cnEH7ES6T?=
 =?us-ascii?Q?lyl1ev3uQwTohYryA9ZiS/84vLi2V0CqSzCe8S+fSNx0ROKNvHbXVW0td89n?=
 =?us-ascii?Q?b/y1nbY2PSlal57Y9AkH09IHEvXuvYMoXF9l3IVcMvGZP46+IMFwX35BQy1y?=
 =?us-ascii?Q?wIMJSfsrAII+hVAxAGMITG+kUR8xp+KuMW1+RhGHe4iairPSP+iSh728SaHQ?=
 =?us-ascii?Q?EQZPO6l6hSvVQ8IE+kwwYc7hbetGr0Yw+yb8/hB/45yW2WlYfZ/hbdFTL/Pn?=
 =?us-ascii?Q?LoM2mkMH6rj5C/TCTYMDuT7jMZdS+fTmSHqZWe6w/cpeqT9+gq6R0BTD7yQ0?=
 =?us-ascii?Q?vIDKYCvzyW5SqZpqpKwZRTrZYiEmDeb4mX0B0WLreu8PAnUfulpKUKuSu+Mc?=
 =?us-ascii?Q?in/Jfqy6O2J4lIEcmHbJoYxmN2mdkNBN+wHnn5TwAfKPWKnJ5McMxWwQZJku?=
 =?us-ascii?Q?sAT+M/47hFXWfHLdRnWm5Oies/qb+HlF7w6VFKpYcunwwPUijfo4L6npyvnG?=
 =?us-ascii?Q?eRlNZusZMdQm7MQ1sleyxlkAEgSugwr6RcmsWG6tMRDHHtCAtnt4LwEkmykg?=
 =?us-ascii?Q?sK6V5HCPX92+Z25gs40vGUA+hljTrJuj0DOOyuH3JLYBefRxBwNgkxpzaTAa?=
 =?us-ascii?Q?hmWdw1QZKDJny2QLLf5GYdIn6VwAr/ufwbIpSkRU8iEMLZubeEhI3lIQRdH/?=
 =?us-ascii?Q?5mv+WAZ4e28PrdJ38nywIuOL7Bupm0KqL8ITj7vrqBTuiuYznKfsh4Y1UwcA?=
 =?us-ascii?Q?agSQFg8aviq1U6SEH6ZhpOcwAnc4048nwO/KuW0j13VS62EMPIfI6NDNDfsD?=
 =?us-ascii?Q?kVd+WQQqcLHqjRe6UtKkNbeTrGOQzT32FA7+Mrm+F4A4eWHaRX78qHDuXxWe?=
 =?us-ascii?Q?0VILtZUETnrZyaEtqdc34xGwqAM4E4pUZ7yNeWawVadIMroA9ljVIH8mLjbP?=
 =?us-ascii?Q?xe9/fGVASyRqKLNkktQ1a6eaCmhaDteyxZvjGGmImJHgET8B23HNPyIslgDN?=
 =?us-ascii?Q?cB1FAHNxAj76Fm6PyKl+nRR9oOCGaq2UvdfxEcxpNN7ackRxcHXSAwJq/AuF?=
 =?us-ascii?Q?MgmtO8fQ5kIm5AT2LNlXUY/4mA0uSWFIWdm4O4JGvjKXFs6NPlvaVD65uRfC?=
 =?us-ascii?Q?8EGjfXHujGorJizh0eaZpO6yorPLDYN1Q/op2hDw0mK5q0pgPXWiMyEg/t+4?=
 =?us-ascii?Q?UQNecEltH/Rin097D4/cZ++r40/oXPLzz150fpKBve3jZPk2UjVcvWaa7POa?=
 =?us-ascii?Q?6rYqPQZJI8f0R/7pTMi76QahAIV/9gwUbN4T/p+/j6Drt4eIroMQKeHahM5w?=
 =?us-ascii?Q?IhCw7cyvPygaSBzqJ2X4rRosTG2nQMC7dFeAFTmWFuqyo+RT9vHTfW1vW2eW?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b52f017e-cf11-4590-e697-08dc9afbcdce
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 01:02:26.1788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6RVjk8uXI5efSvvQOU5y+hCMq0+3niR+hvJgZhng3bmO8K2/y26IZ1+u7uypImwYE/6PtO4KkJcRDgr/NzLW/CQgAk66zORlEbMobfk5XI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6013
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

v2 changes:
 * Drop sw_blink_state structure, move its necessary fields to
   led_uc_plat structure.
 * Add cyclic_info pointer to led_uc_plat structure. This
   simplify code a lot.
 * Remove cyclic function search logic. Not needed anymore.
 * Fix blinking period. It was twice large.
 * Other cleanups.

Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/led/Kconfig      |  14 ++++++
 drivers/led/led-uclass.c | 102 +++++++++++++++++++++++++++++++++++++++
 include/led.h            |  12 +++++
 3 files changed, 128 insertions(+)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 9837960198d..1afb081df11 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -73,6 +73,20 @@ config LED_BLINK
 	  This option enables support for this which adds slightly to the
 	  code size.
 
+config LED_SW_BLINK
+	bool "Support software LED blinking"
+	depends on LED_BLINK
+	select CYCLIC
+	help
+	  Turns on led blinking implemented in the software, useful when
+	  the hardware doesn't support led blinking. Half of the period
+	  led will be ON and the rest time it will be OFF. Standard
+	  led commands can be used to configure blinking. Does nothing
+	  if driver supports blinking.
+	  WARNING: Blinking may be inaccurate during execution of time
+	  consuming commands (ex. flash reading). Also it will completely
+	  stops during OS booting.
+
 config SPL_LED
 	bool "Enable LED support in SPL"
 	depends on SPL_DM
diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index a4be56fc258..d021c3bbf20 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -52,6 +52,94 @@ int led_get_by_label(const char *label, struct udevice **devp)
 	return -ENODEV;
 }
 
+#ifdef CONFIG_LED_SW_BLINK
+static void led_sw_blink(void *data)
+{
+	struct udevice *dev = data;
+	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+	struct led_ops *ops = led_get_ops(dev);
+
+	switch (uc_plat->sw_blink_state) {
+	case LED_SW_BLINK_ST_OFF:
+		uc_plat->sw_blink_state = LED_SW_BLINK_ST_ON;
+		ops->set_state(dev, LEDST_ON);
+		break;
+	case LED_SW_BLINK_ST_ON:
+		uc_plat->sw_blink_state = LED_SW_BLINK_ST_OFF;
+		ops->set_state(dev, LEDST_OFF);
+		break;
+	case LED_SW_BLINK_ST_NONE:
+		/*
+		 * led_set_period has been called, but
+		 * led_set_state(LDST_BLINK) has not yet,
+		 * so doing nothing
+		 */
+		break;
+	}
+}
+
+static int led_sw_set_period(struct udevice *dev, int period_ms)
+{
+	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+	struct cyclic_info *cyclic = uc_plat->cyclic;
+	struct led_ops *ops = led_get_ops(dev);
+	char cyclic_name[64];
+	int half_period_us;
+
+	uc_plat->sw_blink_state = LED_SW_BLINK_ST_NONE;
+	ops->set_state(dev, LEDST_OFF);
+
+	half_period_us = period_ms * 1000 / 2;
+
+	if (cyclic) {
+		cyclic->delay_us = half_period_us;
+		cyclic->start_time_us = timer_get_us();
+	} else {
+		snprintf(cyclic_name, sizeof(cyclic_name),
+			 "led_sw_blink_%s", uc_plat->label);
+
+		cyclic = cyclic_register(led_sw_blink, half_period_us,
+					 cyclic_name, dev);
+		if (!cyclic) {
+			log_err("Registering of blinking function for %s failed\n",
+				uc_plat->label);
+			return -ENOMEM;
+		}
+
+		uc_plat->cyclic = cyclic;
+	}
+
+	return 0;
+}
+
+static bool led_sw_is_blinking(struct udevice *dev)
+{
+	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+
+	return (uc_plat->sw_blink_state != LED_SW_BLINK_ST_NONE);
+}
+
+static bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
+{
+	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+
+	if (uc_plat->cyclic) {
+		if (state == LEDST_BLINK) {
+			/* start blinking on next led_sw_blink() call */
+			uc_plat->sw_blink_state = LED_SW_BLINK_ST_OFF;
+			return true;
+		}
+
+		/* stop blinking */
+		cyclic_unregister(uc_plat->cyclic);
+		uc_plat->cyclic = NULL;
+		uc_plat->sw_blink_state = LED_SW_BLINK_ST_NONE;
+	}
+
+	return false;
+}
+#endif /* CONFIG_LED_SW_BLINK */
+
 int led_set_state(struct udevice *dev, enum led_state_t state)
 {
 	struct led_ops *ops = led_get_ops(dev);
@@ -59,6 +147,11 @@ int led_set_state(struct udevice *dev, enum led_state_t state)
 	if (!ops->set_state)
 		return -ENOSYS;
 
+#ifdef CONFIG_LED_SW_BLINK
+	if (led_sw_on_state_change(dev, state))
+		return 0;
+#endif
+
 	return ops->set_state(dev, state);
 }
 
@@ -69,6 +162,11 @@ enum led_state_t led_get_state(struct udevice *dev)
 	if (!ops->get_state)
 		return -ENOSYS;
 
+#ifdef CONFIG_LED_SW_BLINK
+	if (led_sw_is_blinking(dev))
+		return LEDST_BLINK;
+#endif
+
 	return ops->get_state(dev);
 }
 
@@ -78,7 +176,11 @@ int led_set_period(struct udevice *dev, int period_ms)
 	struct led_ops *ops = led_get_ops(dev);
 
 	if (!ops->set_period)
+#ifdef CONFIG_LED_SW_BLINK
+		return led_sw_set_period(dev, period_ms);
+#else
 		return -ENOSYS;
+#endif
 
 	return ops->set_period(dev, period_ms);
 }
diff --git a/include/led.h b/include/led.h
index a6353166289..bd50fdf33ef 100644
--- a/include/led.h
+++ b/include/led.h
@@ -20,6 +20,14 @@ enum led_state_t {
 	LEDST_COUNT,
 };
 
+#ifdef CONFIG_LED_SW_BLINK
+enum led_sw_blink_state_t {
+	LED_SW_BLINK_ST_NONE = 0,
+	LED_SW_BLINK_ST_OFF = 1,
+	LED_SW_BLINK_ST_ON = 2,
+};
+#endif
+
 /**
  * struct led_uc_plat - Platform data the uclass stores about each device
  *
@@ -29,6 +37,10 @@ enum led_state_t {
 struct led_uc_plat {
 	const char *label;
 	enum led_state_t default_state;
+#ifdef CONFIG_LED_SW_BLINK
+	enum led_sw_blink_state_t sw_blink_state;
+	struct cyclic_info *cyclic;
+#endif
 };
 
 /**
-- 
2.39.2

