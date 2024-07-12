Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FB4C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 05:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D21E18870D;
	Fri, 12 Jul 2024 07:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="PdPTteLl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BC8F88415; Fri, 12 Jul 2024 07:25:27 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF18888703
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 07:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wvsb+sJguDposg/FkXJSNddp9a8RXGsdp+kGQlIzBOWxLIoIi2aZud/fNMxzVVvsgm6lea9meALoD3OQqtHPZi0rfRwDlIocEzHBwc3nD26wH3DRxBbgDZyvSG+chenbX9hNES9cTtEAswbfGz+AVhKcYPJ32LQ3SxYeS6FjelugvVi2pcXdzPrmQnRALD/27tvX8Adw4N11uM3F8WUsqCnc0YTrvrvEqvPgTTcRbRiZUmm3nyq0zYuayKpK5321ZnmllP25R01svc+1jCLbCtu6W8Bma3czAGd6cC//0GOyRTsX7p1N1x7ujorCOLd9QAzWBfkd8eijgbGxZM0hRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vm9qWD+29JDrSxIkbVj9UquBLRVpRkJF5XCqFqY6RBU=;
 b=CTtVDtWeEZqs8GHNynQ6o7RZ6VXTmeFG+3+yGhLzGWsF3OpT3ZTkwLM7gEKrjIyfA90MYYBWlWfXosYxGGuWdH+jjI7dibay1p2/mlq/QtBYKlQXT/KoHTwxIw/o8QssalX3Sr2P6M1VXX1JEtSQcP6Qd2NQvcjIR+KKJVf23XVykJtBknsZdYBe6mV1JhxUZSAEeLOkhAZn3BC3/DhGZ9Vd7dPxS+afzBO2wpKFPGIVZu4dp9f8tBnpoJzXef6jSkQ0KgvRL2qawv4HnuS+x5e4SivpCHN0RBS/M+G66FMs1MVrZMAFcobwDDrwRkAxz94e6q6hoZee5gNmK3zZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vm9qWD+29JDrSxIkbVj9UquBLRVpRkJF5XCqFqY6RBU=;
 b=PdPTteLlFxzPHl93yBDmwEK7d+GcA9jk5XRQ20HuuyR9fMpN9RjLSNjeiNZyrPZ5l/1d9oJ3m9ncx8P6vrGSdu7RGqGcwS7mLhKq3F8I0wV6ZIaCPY/zQcLDMMHhugs5U3QnqzbKq97ej+seud+MFOjQFOkqSgmU/Ws+4ZOGWQ2LqdT3It4oFKzySLrv7rHLvulH3wu0aVlLwfGZoWQG+byJEpG8JhvaCVqiSJN8JjSAdEQA5Ykb15iqxMVcZbzYbF+uWBSmyL1nl80FGFEvcjW1lW0e/LjRPHvofW9ygydNpSDW9iZifR4lgwuRoA6Dg6mNNW7dmhVKUhGmDzX0uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5796.eurprd08.prod.outlook.com (2603:10a6:20b:1d1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 05:25:22 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 05:25:22 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 1/2] led: Implement software led blinking
Date: Fri, 12 Jul 2024 09:25:06 +0400
Message-Id: <20240712052507.2496669-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712052507.2496669-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240712052507.2496669-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0178.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::21) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 9804786c-edc4-4aeb-48ee-08dca23306f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CQKT6hDmXuwflChpvBPKE9OzRIaRKAWQipj+K56mGbewNAqY5AiUuQ1DRp96?=
 =?us-ascii?Q?YdlNGPFgcwz6Y1VF3pQzE0mRdxTMU083YmBA6lvcutu/+kHpUHAA51E9d13r?=
 =?us-ascii?Q?1EubJNtWKa/tzYPYYRLmX3//2Ufo8BtrflwGqdh28Ccbidg60I33zQv9lZNh?=
 =?us-ascii?Q?sKR9yrbg+4/86Yqq7zafkUcpdddw2kChmXjukXvghzoddrKorO4NPM4aB0h5?=
 =?us-ascii?Q?+psHOO11TPii31kzf+IWfpLKTkTMV8cLoDnWSjEUSQNnaMa10NvrUeXe/0BL?=
 =?us-ascii?Q?8LvekU31OSyaqgWFzl978wNm7Z32D5DTAv05oZyreO6V2GJrLgeqp3xMWPnL?=
 =?us-ascii?Q?zhfXWq0HfHcNGqYJMfJVNFLhMliLzx0uqTZ1rEdg1e4cH2I+6RJLqvuQ13ri?=
 =?us-ascii?Q?sr/s68W54BfteEemHuYFL0i9PhBrimw/R4zwUuIvh+pFkIKTeBHBfB8eI6Qk?=
 =?us-ascii?Q?hInmWb9HWYm6J2UMvqG3TGxfDJmD42I8S9abOFu6S2EP8ffA2QiW74fVVhz3?=
 =?us-ascii?Q?n+gkbQL+DLbxhJ57c9uCXcS+KzkvCWaBLGEf6W/b/R3bDVLUZfecqUejKNhm?=
 =?us-ascii?Q?Evx8IocFqgCtjYDSHmRc0PhRevEVZ1Oul2/P8dhGNGldlFnCjmxpkPPTiGaQ?=
 =?us-ascii?Q?YEI3PoRvOGIrZwtod3q3JHSe2pF5BdH8+RAw6G10JiQnmD93WiWWSWTEfkKK?=
 =?us-ascii?Q?WO1eRdGrswDsuoRHYIGBd91zxACBqbj00hgYI0RDMFn45x7hYpnE9iwm/4Y3?=
 =?us-ascii?Q?4FYrk/GIjfowcGl6hugPdrHc40I2oKgpwn9YM/cGkz0xmA9nG7FTHTb+AHAD?=
 =?us-ascii?Q?XrRm3X494SgEIp7xeLm2XyfDQD7Tiz3pLyBdnTQQrTdFJxukHS5IhdrIog0/?=
 =?us-ascii?Q?Bfy/6Z9uDX8xERRaFTlilBac7NcKXs7Bi/a8q9vaSX2/07UsXwD6EOlbkuKS?=
 =?us-ascii?Q?IUIPOd7QBKKYTZgCg2YNVoaFBT6YQYmzFaXIP3JOW5NowAJIYl0ZlIvXG6nl?=
 =?us-ascii?Q?3SlrBlYrgLZiwP4nMJMZZRoA9dQbswRSJEconXWjUUK5zfqCmca6/DmTjtVj?=
 =?us-ascii?Q?JAFEpWaojaa8KQviRbL5WDMHYxwV3wCrS6M4sLfffMa/lU/XlftE8jTDsbgu?=
 =?us-ascii?Q?GiLBF/btzSG7rNpLdLWFEUYaKEOtt95w0EYp6G6E0PE37pCw51R0XYYvjjp1?=
 =?us-ascii?Q?Ocq7Iwq4v4dG15DS1SvZlatwhp8RM3/0+1RvNZZHLxE4C7EV0KqPBHXKsqoh?=
 =?us-ascii?Q?kEy+0QGS+2QV3YPvI+8CrUjEPXy8CzBWovgwPcD1sdj7au3NjVuS/uxlvcsM?=
 =?us-ascii?Q?e9j83nVaarsGzoqPdL7hdNLsd342zrV1TRWd7gYCQ/ITLg3FxauodPbl0FhG?=
 =?us-ascii?Q?PJEj31xiQRts4kMYCiDjt0NBkrhQKfaCrlHiJQ3a/HD0wjz7yg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EBprfnoJVvRaR0/hlFlotkmU0ZS/qM7T2h75roZ8Ovhic+PAbcezZs35lxpG?=
 =?us-ascii?Q?BiNcrye9DUqzk59ehBYs5aG32AT4xEGvsYULW3u09dHouTZJ3h98w+g1yFnT?=
 =?us-ascii?Q?zwQgghWJVZLTtJz4RvX4m5kcGlXS/KRlBbUNpdvDeIaqhkOhzdGhHqm/mSQj?=
 =?us-ascii?Q?mv+J3sjZTDqv05EJcI6+S9I4azeqnRO520DA9dbSaR0jvXT+JbIyuZPQbOkj?=
 =?us-ascii?Q?nXXcNHrhPuc8Em6AC0n+rhCQWKkmmaJp6IL3igYRJyhnElfhDs4eJkkS5qrf?=
 =?us-ascii?Q?TKBCuSU36aqdkc/ci+CK7+CtRXQBeQ0a/svTOT9aCLA49X5cgWygiiLwd5Q8?=
 =?us-ascii?Q?vWmQTjJ06awH4r4ie+9sxKInZvA7g2lZg/JqG3sa2Jv7eRNmNSpRdMeNyhJu?=
 =?us-ascii?Q?0SxP6wKENTJi82of21LZSM2AEnMuAjnQlrzqXVLUZknJpDkQcgRmyUyytCIt?=
 =?us-ascii?Q?H5ok2G02qIrOR1h66LuwkLNA7fqLICq2SqjaE2dbSVa9ZOJPHBVv7izXGzWL?=
 =?us-ascii?Q?6CSK2S5SPQDOHed1cYuA5HQEi5y4NgfvBsu+vDNyLttsKJfZR4QA20egF4BX?=
 =?us-ascii?Q?eZ0CDer/bOBwtr7nJ/TxSd4hevfymNAjZpTScK889wT5KuStsxhA8I9OlWva?=
 =?us-ascii?Q?PmFsZ3Ti++fk9G97D5MNmclHuXcS+WaEvfmv7elvPQHPJVrRpnT69XgDfzW+?=
 =?us-ascii?Q?VIh+Gd9zbKwWhrf84zPnlFEYHKFBRSzwCYFY+KYrshdx+LSTSgM82sTX5T0q?=
 =?us-ascii?Q?TtQD6+JEoCeMd/aikw2nI57VjeKpPrO9Q0TdMIeJz9EKgyf4kcMCbArF2To4?=
 =?us-ascii?Q?YudpGWVpdIXhJh3OvCqxn0O7tcvSvtJ0fDFfjNX+kGFVyEMbC88LqFEpu2XV?=
 =?us-ascii?Q?Vzuj4VtsTnF/t2aUNvuF2Zir8Gy9S/+RwOjxiA7Lh/p3PX3zqKaxzfKvYTvl?=
 =?us-ascii?Q?ySLiy39p5NxHpYttlKZiMwRn0BcYmfuk8T6dznWvDkhAkRP6yiPhsmjO9qwv?=
 =?us-ascii?Q?fgFA6IocIZaGEnhX69tgNoWsGGoGaZWFwwvxb2RUU2ARCFXoHD3EwFHCaT49?=
 =?us-ascii?Q?4OQ1ofuMFWL1Aeh5Jh9o+sXlya2F8432PHc/QbDFl5DfJys21O2WEhwANJzi?=
 =?us-ascii?Q?0jEKpTP2NkI/umAbJ7oZAN3mqXidfNtA+edhAP0S3WEewn9Ket+G1afsLAGU?=
 =?us-ascii?Q?rTCCzFBK673Lclz8Eqiqq/CVuDpTuK5oO5FTcibgKhH4LG/MJlYT4snKWxZG?=
 =?us-ascii?Q?3+M7MgX+OOZu0NWnzU4gJVKJBPU9b1ZPvtCevLcG1x2qnleYOGVV03HDS0m0?=
 =?us-ascii?Q?096k3dlY5eJmmJSf8MtB/C8n1gSK70BX1LSey5J04UqOgUEAvNZjWKts1SGy?=
 =?us-ascii?Q?Xviz2I7JZ/wjJ0dFXxekatneOO8H40U7YnGSxSQItZZ8/LTxRQdZI90qfw18?=
 =?us-ascii?Q?EOoosjJZAjx92MKvc03WIgdOempVfm7JVG5SfscdW9kEgZ/lBqmKOAQ09EMr?=
 =?us-ascii?Q?hCOdqK4ZSzXQimBjg7e1phZLbu7veViPh8dQ8uIvNqZGfBgoeigXb+NFTauq?=
 =?us-ascii?Q?vxnkrSBnnfKPZGa0pnHf1+wz1Nmlge1dx7UEEqRs00zHmfUXEbHg/pgspGRo?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9804786c-edc4-4aeb-48ee-08dca23306f1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 05:25:22.4967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NV/1hmFWA6zb5Uzwp3zqpgtJ8zPnqN+9dIUURK78DWpAlvFBQXCs3WB+Im7VStng6vuoQjhzYT6+o2tcgp8Cmw022tcGeGC3utVsNp3Oz9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5796
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
 drivers/led/led-uclass.c   |  19 +++++--
 drivers/led/led_sw_blink.c | 106 +++++++++++++++++++++++++++++++++++++
 include/led.h              |  17 ++++++
 5 files changed, 154 insertions(+), 3 deletions(-)
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
index f37bf6a1550..4f5dd66765e 100644
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
 
@@ -68,6 +72,12 @@ enum led_state_t led_get_state(struct udevice *dev)
 	if (!ops->get_state)
 		return -ENOSYS;
 
+#ifdef CONFIG_LED_BLINK
+	if (IS_ENABLED(CONFIG_LED_SW_BLINK) &&
+	    led_sw_is_blinking(dev))
+		return LEDST_BLINK;
+#endif
+
 	return ops->get_state(dev);
 }
 
@@ -76,10 +86,13 @@ int led_set_period(struct udevice *dev, int period_ms)
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

