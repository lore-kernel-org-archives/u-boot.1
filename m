Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A505BC30653
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 02:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA2AF88917;
	Fri,  5 Jul 2024 04:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="OCE0n/rq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F13288669; Fri,  5 Jul 2024 04:26:45 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 421E6882B6
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 04:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L75oysbhz76dy8viHlYYye+6BJ/cJr/6t5mMk6k9qsiGBCzYICJx8x5XzXiwAeDDaTWfct4UCVCJu3nHFR7VpbRTN5vzCUYFyfWo5z7AlXDAvcZv/zOlzJ+J0E9gC8dGouA2xxrlXUixiYhr2Zwr517mnWGpTgmnHsofaa5/KSAhtPVfTNCyunlbH8VkFYU46sy6kxrD9mc8Z/jcsaYgTgOZq4MsHz1kOgFUiqrTZgfX+ZrcoQEEyGuf1zkwy32bsU9aP7h63oQw2XegzHqL/BEiCr4PEAXa+t1kjnVDpb/FbEF29POSco4Cs0j7l4W7px7hD4k7h/LTTTFAOmUUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKx1zz71v+l74w2KZyPkDRr8yHikexLF37uPNburVPU=;
 b=He/PY5dGqsoYu/fV/+aXDAb8xwwRPn+t2sWXyLrd4g6hjlJUxWrNYT6jbkzonw6b/WPRvpsXDjP7rR/cC1w031Z6zz1mkq0Lqu6OPco3jvcCBGQLASgggWH1U/jIASXooJa1gC9x3d5EEMBGO04ON08JFix4x35IAJQX2t/pQXu+hCZfjHpzu3FhwffcPBkCgVbONwi2PAyF1sA4420jhkUxKap9OOCc+vbJmWzJIv2UabibJfFxJGxgBdHa9YEN6EGb/aiE80rV+8GEwuzOU+6puyVqQIM1ZNMDD+vO7+BV3/72bzQefpzjWXT9YmIfiHk1oxfYrHweKHmLHUxTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKx1zz71v+l74w2KZyPkDRr8yHikexLF37uPNburVPU=;
 b=OCE0n/rq6gIDCYpwZRk5DGIA29mMBu5QYIl/qN9tJZ3I1QbSrBoJRwI505svpLhiaHRNyqGuqtOdDQSuLz6qyBMbI8/QWHNWtky1UZV5+rQ18vjh0eDyFTlsGrH+dTZ11AC2VK8+SF0UV/STmZRpn680D2/jddVxIzd1KPr2aU/uhoskd0QHVKuhA4lMV0XI/71xkld3GyOl4hmndjjUhA2rw6JbiYG4ut/DMOVfxPb0C/cttrXWtDUt6DAfNcIwrYA9Cjd5w8w32jP7gw6obA8KN4/OJNuadMJFuW2svAVt1tCOQ2w0C3sqNcsuTgwv2ua4584vs+O0xfnYScvlOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8488.eurprd08.prod.outlook.com (2603:10a6:150:b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 02:26:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 02:26:41 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de,
 Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 1/2] led: Implement software led blinking
Date: Fri,  5 Jul 2024 06:26:24 +0400
Message-Id: <20240705022625.2249734-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0627.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f07f31-4b09-46e0-c994-08dc9c99e805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+5dkoVUXKm7ZePWZkV3pwS2pDadGcfA73XBK1sNU0vp0IbmCF85djavb8kdU?=
 =?us-ascii?Q?Zp6sGASjNjNAqsSST7GBWQPmWNZDuU3zyFPJ5Ylgz7C4Wk4k39HLt9PRfGul?=
 =?us-ascii?Q?NwxKIUSK27LTJ9zoEfrDGwT2h/UcRPIQ83p1RuuJ5D7uSdBdmE15JZkiTpIX?=
 =?us-ascii?Q?FBXmF1gmErnY9ZuqPCl+5LvfBMPidZR7XCE8Fdrm1ZKtIljlrTYsSeGbQaHq?=
 =?us-ascii?Q?a20pR77Hc9A0yo/7nBMgq9Ucc3G1SjTplG8cs0T4zt92v8SBlVjjbEaGyMzF?=
 =?us-ascii?Q?zya5k2jV4yPsnwRZunGP7Qs1rvp+k1PRiSW/ZJfKhzS/gAa9KYwKYpiqNYSw?=
 =?us-ascii?Q?Cd1X1lSe51FJ9F5MH3INjC5mAHSS3fLocS+fg39cEYJcjWDr0P6t3V0qrdyd?=
 =?us-ascii?Q?itp81036WQTNounyp8cKvttPsyUlgomUwZAul/H5dBAc5HwruT3phXEMM5Cv?=
 =?us-ascii?Q?WFZS9OOX5qV64GGgxxwYMQ+AmKfZQYNknzZPXitV5sjuUE7AyL4V0lPTyH7Q?=
 =?us-ascii?Q?Irnrq15IVXZbfxLUzEZfKBe0nzGICRMEpmKPcyubI+cVExgFIURQBsaWwsIC?=
 =?us-ascii?Q?pECBg2Y505vE+5AoZAUVWaj2JNW80f8OT/P88otb6YQBcg9pAIUXvVq/SUmS?=
 =?us-ascii?Q?ueNfhbBj4Cd6tfTtEJt2zcGz+m9tF6KEhiIOt67Rrp2tXdry0gpdjij/BVYr?=
 =?us-ascii?Q?md3ljh3phOgfFsLEe6baRb8qvjcX2PAKn16J6iif6AVHe9xhFpkwKmLj1le5?=
 =?us-ascii?Q?wCCvyCt4MiRkQDSaDKx/imXqPpPtlU16enPkMsv+ncaXQENQqIYPiiHxaQ+U?=
 =?us-ascii?Q?ii0ZT0f7R0yNaZM8atjsBNmBktEqikMfzkQifKyv/yXDH2l8IAUStLU4Cwe8?=
 =?us-ascii?Q?LoHcIvkTL2hcjgJ8bvw+2BOc2qwAiQi77bVI5S720/LhWbYcHKaQjbE/xr6h?=
 =?us-ascii?Q?o6nCtplqkMxNXR0BfXOw92LDmuunnRx5o8AGIjJa5mAZjPJ/IaVTwDbnFOWb?=
 =?us-ascii?Q?i99IUpUa69bF5gBs5cJK8ZFUdZrNWRtrCoAO1zSAtAjGA2N5L3RpdCLpYkvI?=
 =?us-ascii?Q?W1tHt8sankjIRVKms7ghgKmul6RFgu1jlk7YjTA9jic9a4HZiWagdHdkd+Zz?=
 =?us-ascii?Q?Qgm3fjvsv3G2HjnADIZsQ4srXgP4hqt+UChEhvEBzVgULWyqMdZZAU5zrqmo?=
 =?us-ascii?Q?AeaZm5Q1hx0Kwjx74zB9kqErRrBqhPs6+9WsbWqgpVTmr7D4BG7dKR2LhFdM?=
 =?us-ascii?Q?bJEw0XJCjkrxW8k7fVeFBUR3KfuKhk2woUAzVxDsUdvGdszYHMGrVhUlifEM?=
 =?us-ascii?Q?OXmtMOzlU8VClNXsdqhvQCACLH6Zwm4VB2j41sZFadzlZZCKvLu+s1LIxnWn?=
 =?us-ascii?Q?myeg2coQEL2VgMl7Po6JCDEw53U+OVDOh+XQnrWVByyaiNSdXg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fHJSxnNEQPq+E5068+xvpwQ+ILG2FxvRpcs+H5fBzGEdxOhqTYDfWfvKDxgU?=
 =?us-ascii?Q?u5j8DKlXW6bdrnwKuW9OMUvU/wJ7GyljEqZz/hy1jsiZOfcUuyyDkH9Z4QFE?=
 =?us-ascii?Q?3jWkcM0YNUmA7UU6d9pkeSoQ/IldncXXpOQPfttCbVruFlF/DtdZJcCjVePV?=
 =?us-ascii?Q?KmIZ9g8sBMTXccaf53L6CyvGHlNTNsZFy/9+wXqKoG3EPwgmnL/xQFlVne/W?=
 =?us-ascii?Q?oD3Dzijaj2gfOTNc9fE6Ny9ELLcMYnSSdcDFa07uLc+j2yUKFHRN5t/6Jb8D?=
 =?us-ascii?Q?NMn/SnDdV7IULVR0S+92p6bGRnia2NTZOl/b7V1cz5Nq2YQI0wN+gQSr042q?=
 =?us-ascii?Q?rh6spZjvRXlhQWiCyTYiT3yJBtuVmgQfKayonHq8uE/qsgcgVNiYmuwK5p9b?=
 =?us-ascii?Q?eGrcs0TCcdVD8jqdhayP2+09d1Pi+PUTPKYUTmIMfvuzgzWA5OJK+807Mi3J?=
 =?us-ascii?Q?EtHrKgGsjqlTbDrU+n2vg3Gqf02BzQCx/FODCZ3Gyi8vVzxdAj4+f0cC59xe?=
 =?us-ascii?Q?qWdLAV2ncGZ6X/Q6FDyk84mRpnbz5GW550NonlTvd0bh546/1WBw4aM7wFzc?=
 =?us-ascii?Q?t2DNiQZQhVW1/INQGgLG5iU0lbjstJfiAuSkvNk6E44Z/ioVhajao8g+KzWo?=
 =?us-ascii?Q?NxfIwQrvUmcmMNUk98jK94QOZwcqwSPw0LtFHCCEWppYthI1Mo09pw9CGWph?=
 =?us-ascii?Q?25P4Et7pvM/XsL02I0hJmduOnpR5nLezFQg4/Cfikciya8WxBhphg9q7aWlv?=
 =?us-ascii?Q?marglPrjBYxr/5Vpb6IPyn6+51jZjYZVDCkZj1kez1v6dgiPzCJ480C1oad8?=
 =?us-ascii?Q?D4YEaVd8BGXH7T01FMO8cLj8LzgkNZdTrqFNJiICLjfEPaWACRaCPBLcIByn?=
 =?us-ascii?Q?qqD3GrT8SLcAOj/BfEGGdwIHwUhzzC7PhDjaffll4tCXtinII0p13z/phbhE?=
 =?us-ascii?Q?8GhC6Sbmnztj+rtIHppS2mzrYewjFfzTdlopLc2HISx9x8f5C5Ap7zFND+Rf?=
 =?us-ascii?Q?AU6CNE/43qFSTv14XMEOgyWhLbGcuUBaq/05JTM6x6Djv1u252mJWvpvD4oC?=
 =?us-ascii?Q?tqr1RvKpClsJK+tEvQ/jKEBXB4psmNA5z1hR5ZWi21lcom73ZUFwZ/phPM2g?=
 =?us-ascii?Q?jVPd/+UWVVyfgiwaxcrkoQZvwccMjAQfZUIzHN3DCJPVh4nj3vwr56SkiEPu?=
 =?us-ascii?Q?25V6IcsM3domUmhiCsvwcqbM7JWWrRgXMIiNuhcId4njOYmHOoP5GjVd6zAq?=
 =?us-ascii?Q?2iaIxt/Qq7Y01gueLZxegpIAVjnkL17THnimCpiJDXuGcX5tozjw+kvv9uBs?=
 =?us-ascii?Q?7Tv46Ri5Fr8i7QYD3Soc8zJTq5LgTUzhgsfIh+bWemuuk53yrmmXXG7W12+R?=
 =?us-ascii?Q?QkSwroj4dHEL6raDbgDc+x5ipsb2ZHK3a4Pv4FQb2kxs9QWGFjJBqHyxkOcW?=
 =?us-ascii?Q?Vdi6ouscmSPobiV1dMy6VdB39LD1Wbws9ZCLWrs4vnyeJ+nzue7NebrAmJjr?=
 =?us-ascii?Q?+f7Zr7Vekun3isAjNfnnSdFjhNLWBEHDRIfemsIqCUU0ati2lBlaq2095P8N?=
 =?us-ascii?Q?ZxCiOArEfugwq1coQDEnziwLffpHmU3Y8mihTlFhpBjD/x+OBF3B9SOotZRs?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f07f31-4b09-46e0-c994-08dc9c99e805
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 02:26:41.7837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SyW7dcsFewFEH+vRJalUV2Vum9EoSjQNcGKks+ayRsla5P3yx8Sf3RYh2/s7VvUFvmb28gmzvG8bS8+Ct4N/yAvzkTkXk5qH3GH0xC5vKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8488
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

v3 changes:
 * Adapt code to recent cyclic function changes
 * Move software blinking functions to separate file
 * Other small changes

Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/led/Kconfig        |  14 +++++
 drivers/led/Makefile       |   1 +
 drivers/led/led-uclass.c   |  16 +++++-
 drivers/led/led_sw_blink.c | 106 +++++++++++++++++++++++++++++++++++++
 include/led.h              |  17 ++++++
 5 files changed, 152 insertions(+), 2 deletions(-)
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
index f37bf6a1550..37dc99cecdc 100644
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
 
@@ -76,8 +84,12 @@ int led_set_period(struct udevice *dev, int period_ms)
 {
 	struct led_ops *ops = led_get_ops(dev);
 
-	if (!ops->set_period)
-		return -ENOSYS;
+	if (!ops->set_period) {
+		if (IS_ENABLED(CONFIG_LED_SW_BLINK))
+			return led_sw_set_period(dev, period_ms);
+		else
+			return -ENOSYS;
+	}
 
 	return ops->set_period(dev, period_ms);
 }
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

