Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2057C38150
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 12:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA01C88981;
	Fri,  5 Jul 2024 14:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="s4TOr8Yt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C4488961; Fri,  5 Jul 2024 14:10:44 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82BA788984
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 14:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGevPX10p8SBHhlVnt1cWJbjB7PWPvc9dpaNhJ3o0wOoL+etQz1rIcW5DcbS6+Snn002J2JszvHLJvB1I417dFWLQQCSb1CYsPrxuUQraV798bvS0vownXw1lFEMQ3J+swgkxh7L7foHyn3665nichXd1swNpbjISaRKrb1+PZwN9/P6KiAUWQuu++YnE7WX/ZZRRo2UodSxceaZXnGTKptCLR3HVe/PDI6MR4MCZTehdYGuS2biwwNe85xkIgapgQvTdlab/j8Cd248a0CK8vYUPpeAJm+t1srTxSDqeUZUO1dw1TYRzGk8514BQ5HVrFWg5Ar3+m4odsWuvJ1s2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5q3k0eLQEq4TUrTs1WS36+JKxdgM7GOv3OG27InjsyU=;
 b=LHmQm+AP67ZzlSZyWY1ntJc9I38vdf35YbVKA8R20ysfyhrwKILbUdcXDaNMp/EJsbyHTn10Vg4yZUmk1auII5D+JaxIVLR+WN3W81H1Nzlm5RblLKuLqa01ZXMfLcK+NTJlFNkTqS/xlJyrgNN4gpExU+yqMROUomwMi7K0ttr6vGY8bBkaCBfFujvC+CyYp0E7k+mWA+k6eKkkFEP4xma7ZGXBRZUoFSQboXGOT7naZ1XKoG97d6bIZt+jI1jR7SeWh/8O9Oh8HEYemUj390oYxGyHV8Tvr+wT2Yi2luxJKQsK8ebRtTHYQ+NyvpiVAOgfAMKJt6s6d2T/9Z6CrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5q3k0eLQEq4TUrTs1WS36+JKxdgM7GOv3OG27InjsyU=;
 b=s4TOr8YtfKboFaPmbZkIsRq0R9AaASdzQ/CKva6BRy/C1VAavh01XdhdN9K24k9Styy9oIUz0n+CJ3qPVvhQCGYlkYJyZvwvIrKQCz7L0jS+X/IvSbiiTQQtX0fyI7e5Wt6BT6Sy6dVezJEZYWss6/3DtY6rTp3L0J+gZWfaUCy+7PTbPDUpGO+8PSuAewGcU4YpLJcae9CiCzFfDCOAVCidmTm6/Whva3mCoEwa3NNqunQXy9cMRZepZAmzqzSJI0GgGrRM+ctY4gNC1aTvsSEeKAW20B4Mmg2xHJkgL5GGoORJiFWdTRbSEL+PrAhrIISaQeQCPEpoSbbaBvsIcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9395.eurprd08.prod.outlook.com (2603:10a6:10:422::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 12:10:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 12:10:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 1/2] led: Implement software led blinking
Date: Fri,  5 Jul 2024 16:10:22 +0400
Message-Id: <20240705121023.2266479-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705121023.2266479-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240705121023.2266479-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d81b2d-fd9a-48f7-89d6-08dc9ceb7a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K9EKt3U4bJ3fhXw3ywt83EdDnYxRwQEjHBbo7EBNj1tIZXrBrezhsbiBTF47?=
 =?us-ascii?Q?i3wNtTFL2dMMIGzu9arz3wMVrxj/szMsgZEKbLg8S3U43FwWSMle87LZ4zKd?=
 =?us-ascii?Q?+qvmIwPb8oH6UWVBq3YQr+o8oFyfMQTQEZoXi8dCMbUMswA7PkLp9TaUp9jt?=
 =?us-ascii?Q?10xY3MNUpQYDtRw1uKyTUIdeHrnMG/2HWpYWRAGoRT6KjiVS7zLITL90sjLB?=
 =?us-ascii?Q?fY2ddqGzwLF+CtLrYqcRZKPYOV0CDTS9iCpIAmedE66bjjftU8xToP0L0IJK?=
 =?us-ascii?Q?rXP56y5J71R4AwCX5wFhafkRD1HYUtM4M14sf2b1pFkeFFRratjIRQHGcpyf?=
 =?us-ascii?Q?aDkjOY+3YOLafjPvacBE5O8NsPJlgjWm0rhcVW7OivU/fylBhYpoMkM4rKWF?=
 =?us-ascii?Q?axQPrS4AoB+ntjcnxAXft6dXw6x9KdXKzeWQRaPTsEYZFFTmxydM6c98qu/R?=
 =?us-ascii?Q?1qh5oqA4RcoHn929oCot7Zsdqk5JUbIlgN2PuQaFH4FCNwESG68b/wJSLOzc?=
 =?us-ascii?Q?dv+G5nMG5FiP6Tlb8uqqVWTSZ8NCHdt8QIqFXZHTPXdVqO20V9bOxQvzBHIy?=
 =?us-ascii?Q?FLvYYZKMybcSSgA4YhfXh7U8ggDjhpsDnK5QScFlzkCvBYjFjdOG3j8fRPjw?=
 =?us-ascii?Q?sYQPNoy3KlNossJTr1j3Y+DXH5y6mUfM81Z08qbcP1oGb6iOcsqQXLP7rUGh?=
 =?us-ascii?Q?yNWSbENFkZMbls/GUYvIpTNwDUapt6JY+wIAokVh2ZwuZNaR8euEpjGC+tOc?=
 =?us-ascii?Q?rjgX5UsaZq75f0oEPHlNQKCwBV7X6Hn6f2b3lTMK2dmKJNWScLpDda9l1Uh7?=
 =?us-ascii?Q?6XZYWG3gGJN0k3+k5TKlPhXKe+Hszvr7WvHC0R6yZE4lP9lXF4HNK7qx+5Go?=
 =?us-ascii?Q?nkj+DPMBnPIrwtJXoyjFWI+hu5mJ/+Flg9wl/LvWDo/ApCeAvDd1zKyf/IZr?=
 =?us-ascii?Q?GMYUddb8igZDoSAm4U2cc90GvUOdoJejNvKfZ+DnHooWMI00FgdV2jpZHE/a?=
 =?us-ascii?Q?9E/LjvMLyHr1P7/OU4qR2KVh0jhPWZOXFr/iwVtAQNo6AFtFgb/c6F2Aehik?=
 =?us-ascii?Q?TSS7Ck4p0BNyM23T8VAMfhx7OQKEZT2UwMyLwig/lrwIgT9he66RT6Fc23AZ?=
 =?us-ascii?Q?AGYQbz/XrMSs907s35KKBEqG959I40UTyRahBBY8Zm8810j4JSJugLMvrvTG?=
 =?us-ascii?Q?YqOk3ZjGSlo5k7d+3eYGm7aMCTQ25z4fGcL6kOLgQr8fxu0c+4M53coz7Kxi?=
 =?us-ascii?Q?SJmYeI64MG8VHqkRPukX+hXwzBOSP/pEFTKkyrL1hSC7tQhAtNDCggS8SSvD?=
 =?us-ascii?Q?j0Of2ZGU+QOENg+3oqqCPTk8vHKOfbqZ95pKWUIcoEZvoecs0u4IKyB5VHP/?=
 =?us-ascii?Q?NPcISsJ6B1DLV6B+RSf/QTrhOmXFmjvoRcqaVtx+Zg6rM0VPgA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B4BZEPV7tu3qlnoSZG+bBcXm686lOYqRWTXS3e1djmv0S6oyh/Ln/GZECrut?=
 =?us-ascii?Q?Wtv2bsW2eu5ZS9qpwHAW8PpyyTrBIk0D2+IBsyxaVB7zF1UggosCuSO9ssm2?=
 =?us-ascii?Q?N0hbJcpqq3XRRiZcNZJqtdK/xXP0zPa37lh1hQRP71zPvwQ1gUqZ9rpz0l1X?=
 =?us-ascii?Q?uwGHSk5O/wyEGRkh+/I2bxypKgTMptQXnVKYNWGEICC+uDvqSNOfS2H8CN9r?=
 =?us-ascii?Q?a1EuFSymt2zm5fmzCk7YwCYZ7caDi8EVn8QyUMILZbp7L1dtF/Q1Y3X5BJUS?=
 =?us-ascii?Q?ITMe54wJtLsgWIFf9MY67MbfD7YNGfxQRUj/x3zIX5kfZ4/B20zGH28cnqKU?=
 =?us-ascii?Q?XPgOmtELDnTvwvp3MlIKcMC1t/7FWcBoXLBoTPCMlAwuA5Tt1Jmwm/gyAjd4?=
 =?us-ascii?Q?mycN/YtSJP6oPecsxnb2VLBqCp8bpUfKWpf2GgWPz1TVAWDlUfzl10b/IFxR?=
 =?us-ascii?Q?8x5SfVxAa76gGBq5WMHIjDr9ngwDvI0jaRENnOqux0j8XSx37bnDj3ZmIc4F?=
 =?us-ascii?Q?P1zDXVvcyVKtRHsyrytm0kSrsBs3b7D8XQO5d0suug4jQDLdsCFTXzq0WS4R?=
 =?us-ascii?Q?xZeuLxdf96Ksm1cAO70L5aPnh1n/TaAHtfYbBG7CL5Y2HEAriKRwouRSQI6K?=
 =?us-ascii?Q?X/3JV4xeO7KVMzTBblAy9wNtQjqQG2uqwc+90Uf4aH0FGqf7hTTYnbUnHL2y?=
 =?us-ascii?Q?lAM4FlvXKGef6ir5p47kNCDQLOX0pA8QGYzA50EIsXBXXLadawGL8ADjciea?=
 =?us-ascii?Q?//d5owpo7QjlNCr/xoGdbvmhJ8XQUpE0dKr9JULJ+XYb7YtPVWzOHuygwYkx?=
 =?us-ascii?Q?+cJgyiozafQZ5piwVebSJWlC5Lmv4XQvP0zZpByjdOYzC+0V4+ZIoMqGeSzj?=
 =?us-ascii?Q?oTh1+R/ZZGbpisziVcxJJnQ7JXgZ1gKK7VWet7bZnrCNEJK625X3iQdXns6J?=
 =?us-ascii?Q?g4iETrBAaFgsYsYU31y1L7yvY/Aj3l4GkZWzfXb6q641U6bSigI7IM8xhpBw?=
 =?us-ascii?Q?9gk8bWAU0rJH5oBFb/aRowPbVs6lRa5QePADVXdJN2d/4Bp/kClFaCOyaoft?=
 =?us-ascii?Q?2P/Kpk8PpjF9U/2Y01J3xTfa7ybJCUdQLQgOwjyirQNK1vWaAaZPb8r0dD0H?=
 =?us-ascii?Q?ZU00kax10up/MNsyruvSV0bOJXvGslNwGIzWNxFeWqWIsPWmv336HJYFNrLk?=
 =?us-ascii?Q?+TYO4INq6ygMA4T+TZw952w2sMiN35eN9wif1clBpi26RNoUteCzjIOrrrIZ?=
 =?us-ascii?Q?wTlF76qCBWCecy6RP4SX/xWqj9vo9m7iaBaKb44SfCFZqtmKqIkH5I7YB6vZ?=
 =?us-ascii?Q?ZaN7kqpsgXhF23nLr+rA70fUr0wTuMLrtFw24HByMK9yAfmsntpvkSovGfuR?=
 =?us-ascii?Q?+XmXNZHSmtyWAw4Mc6gA/8RHC34um0uFyugOcvo2A/0ADkNS859FC1U8boyh?=
 =?us-ascii?Q?O9YXrQaIvWqSXzQlhgPPzM1ug5Eof0p/+iWhUL0aXNh+LAL29DlF6VgraajH?=
 =?us-ascii?Q?cv+JsP4tupS96KkVNiLQf8yLOGnnzr8lxTd0AQ7Dre81upo+otXfPFFtzujZ?=
 =?us-ascii?Q?W6chvHl8KDmYPInlaW01oW19dyCvAdg0TOb2NAYTc5OXzeBttvEkYQZ6G3rK?=
 =?us-ascii?Q?zhkDoKc6VFyednpCvrFTUAc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d81b2d-fd9a-48f7-89d6-08dc9ceb7a06
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 12:10:35.9844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uoMFgeGAd7cKcrzXy39MPBfX31sm/FMhMzcPJK6YCuzAjby1t5qlhe0n6Bt/MdTyXGwS7Q7yIe5BkWSsmE6tfcFaYrzA1H2ue/bzB60poUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9395
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
 drivers/led/Kconfig        |  14 +++++
 drivers/led/Makefile       |   1 +
 drivers/led/led-uclass.c   |  17 ++++--
 drivers/led/led_sw_blink.c | 106 +++++++++++++++++++++++++++++++++++++
 include/led.h              |  17 ++++++
 5 files changed, 152 insertions(+), 3 deletions(-)
 create mode 100644 drivers/led/led_sw_blink.c

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 9837960198d..dc9d4c8a757 100644
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
index f37bf6a1550..03907a12407 100644
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
 
@@ -76,10 +84,13 @@ int led_set_period(struct udevice *dev, int period_ms)
 {
 	struct led_ops *ops = led_get_ops(dev);
 
-	if (!ops->set_period)
-		return -ENOSYS;
+	if (ops->set_period)
+		return ops->set_period(dev, period_ms);
+
+	if (IS_ENABLED(CONFIG_LED_SW_BLINK))
+		return led_sw_set_period(dev, period_ms);
 
-	return ops->set_period(dev, period_ms);
+	return -ENOSYS;
 }
 #endif
 
diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
new file mode 100644
index 00000000000..ab56111a60b
--- /dev/null
+++ b/drivers/led/led_sw_blink.c
@@ -0,0 +1,106 @@
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
+static void led_sw_blink(struct cyclic_info *c)
+{
+	struct led_uc_plat *uc_plat;
+	struct udevice *dev;
+	struct led_ops *ops;
+
+	uc_plat = container_of(c, struct led_uc_plat, cyclic);
+	dev = uc_plat->dev;
+	ops = led_get_ops(dev);
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
+	struct cyclic_info *cyclic = &uc_plat->cyclic;
+	struct led_ops *ops = led_get_ops(dev);
+	int half_period_us;
+	char *name;
+	int len;
+
+	half_period_us = period_ms * 1000 / 2;
+
+	name = (char *)cyclic->name;
+	if (name == NULL) {
+		len = snprintf(NULL, 0, "led_sw_blink_%s", uc_plat->label);
+		if (len <= 0)
+			return -ENOMEM;
+
+		name = malloc(len + 1);
+		if (!name)
+			return -ENOMEM;
+
+		snprintf(name, len + 1, "led_sw_blink_%s", uc_plat->label);
+	}
+
+	if (uc_plat->sw_blink_state == LED_SW_BLINK_ST_DISABLED) {
+		uc_plat->dev = dev;
+		cyclic_register(cyclic, led_sw_blink, half_period_us, name);
+	} else {
+		cyclic->delay_us = half_period_us;
+		cyclic->start_time_us = timer_get_us();
+	}
+
+	uc_plat->sw_blink_state = LED_SW_BLINK_ST_NOT_READY;
+	ops->set_state(dev, LEDST_OFF);
+
+	return 0;
+}
+
+bool led_sw_is_blinking(struct udevice *dev)
+{
+	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+
+	return (uc_plat->sw_blink_state > LED_SW_BLINK_ST_NOT_READY);
+}
+
+bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
+{
+	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+
+	if (uc_plat->sw_blink_state != LED_SW_BLINK_ST_DISABLED) {
+		if (state == LEDST_BLINK) {
+			/* start blinking on next led_sw_blink() call */
+			uc_plat->sw_blink_state = LED_SW_BLINK_ST_OFF;
+			return true;
+		}
+
+		/* stop blinking */
+		cyclic_unregister(&uc_plat->cyclic);
+		uc_plat->sw_blink_state = LED_SW_BLINK_ST_DISABLED;
+	}
+
+	return false;
+}
diff --git a/include/led.h b/include/led.h
index a6353166289..26955269d3e 100644
--- a/include/led.h
+++ b/include/led.h
@@ -20,6 +20,13 @@ enum led_state_t {
 	LEDST_COUNT,
 };
 
+enum led_sw_blink_state_t {
+	LED_SW_BLINK_ST_DISABLED,
+	LED_SW_BLINK_ST_NOT_READY,
+	LED_SW_BLINK_ST_OFF,
+	LED_SW_BLINK_ST_ON,
+};
+
 /**
  * struct led_uc_plat - Platform data the uclass stores about each device
  *
@@ -29,6 +36,11 @@ enum led_state_t {
 struct led_uc_plat {
 	const char *label;
 	enum led_state_t default_state;
+#ifdef CONFIG_LED_SW_BLINK
+	struct udevice *dev;
+	struct cyclic_info cyclic;
+	enum led_sw_blink_state_t sw_blink_state;
+#endif
 };
 
 /**
@@ -118,4 +130,9 @@ int led_set_period(struct udevice *dev, int period_ms);
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

