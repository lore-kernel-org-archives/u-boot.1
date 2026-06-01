Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B725CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 19:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7648C84956;
	Mon,  1 Jun 2026 21:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Tdsu8aQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8860C848EB; Mon,  1 Jun 2026 21:53:43 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF0DE848EB
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 21:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewyUMYW/7HPp7WqTt9d6IX8323F1/h/UrmGhiPV4OcrdNLWnm6ADHebvlA0gXPRSxICpUwA8HomGs/C15e9yC3YqK0daV1ea+NldSaa857/Mc4mLmGZXcMTz7HXSo+6qdWLJP0Hs14k8RxuGGYFHR87/5p90NPAOwANWOCyi1rFwHHGQCByLmsQ0jHenxjb6oszr5iy63c8MM4DZ614TmOZ+JT+3WQ61Gr7dkNurRXJunp3NByMVmnm+lRlcU9iuYFyrKIJ9qMYOUwrpHFRFUwF+OgMVLFtanjY6xbqi3dnVXDkggYNhlro1Am66t1EkKESgao57CZ5uGZWK5F9Iqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kitDQMp6PTXkZOGVDovmrOloWGtGHajF3mPsg5exgA0=;
 b=wxLm/47P8dM4puoQCtv/Z1ezhDrkf3jYrN5DFYRQHeuadtTfJzv5m9aGaPtyUOSgTgkqA4iP1YDv+ol6nnI3PHmf3uRcIZ4Rt+YkEHbGl3M99ZEafRDn4OG1IbVqfwB7CRNpXYWQGFCbjWNJbDfAQ8gZyrYmjk3wcRBP6/uvlpNwpsyapse3n++WeiOA9enAskohL6DUyoLZCqmqNpmgXUbzVkjL+8qADhjisTcBO+ciBHsdtXHkdhzwBJfaGrKulCNfZ96Kgkm1jgidKKbW/rkUU2GphseWRxIKGVZymn6y7fG3B744kidt6md0DobD0Ff0w7YAum/xbg9MSHKPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kitDQMp6PTXkZOGVDovmrOloWGtGHajF3mPsg5exgA0=;
 b=Tdsu8aQo+xFtx9SGhc2tRK39gpvEAZwJ8e/JVDp02JWec+ZO5gBNOSa1qddxBDG+XgJnoTWajOdDFU2Mbt7Gk5wLfhmf261oG1SlNh3Tb1dIPg8Ey+C/Q02SykZmI7I1i3A+jlNHwcodLKCw+68ue9N1lr2YNJXi1GzBn6OwUjtTFKYw9wdvo3bLbPkX0ImipViGvzMTb+36Q2NOWh529MyIb0PlwhLgwuSSv4YVKKtg9CejkdiD8kKHoATV8myxg3TBSldkLkXlw9ieVzDMkney+jzf+St6pPFxaiDcS6mq/87nisKDnkEB8/3taBbK0e8fuB19o//j11yVyXLdyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 19:53:34 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 19:53:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Anis Chali <chalianis1@gmail.com>,
 Yao Zi <me@ziyao.cc>, Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v11 07/12] pinctrl: airoha: add pin controller and gpio driver
 for AN7581 SoC
Date: Mon,  1 Jun 2026 22:53:06 +0300
Message-ID: <20260601195311.2390473-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::35) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBAPR08MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4b8a8f-0df4-4de2-4dd0-08dec0177649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: m2h0d8kspcTXfZj19zf3wuzOLNsbNcdflTulQPaNznzEkCevsivF/A158A36TJCC/VXSeLLnnSnlZEdkUqIDda9EXCIgXL8klKFI97Ms0Gx/vJczESyIQheg8dhS/2SOiRE3KlP5WXBGYRtqGs9VT0SoGa1t6ZaSRcchjIgzolSEHWiVDaRI7hWA0XSJ5fByLKAqaoeQwuwDScALQKRt6DwTR5+KBqj9df8cjuT5zFhgSUfCnC9Oxc2B8qXWQN6atvCkrzrdo2ZHVC25OxocdKyzL2eHyHZzY8QnpwnOUfP59bSgeH6W1TXXv7XH8pPqS5lB/l8TxOsiEyMWFOlaBVtjj6hFBeLSGzAH6NgT3H6B7jUpTxS6TmC2o0avLjiN2CCg6Dxm6Rb0CN/mPrfUxG1Vh94E4FMq7g/exwo1+YylWOUbI8kZzO2m4N6gRBIdeLPhbWkRi+PfgGd9fBM143xX7hC0dZgvyMkFWtOD9LS528eCcYPIVwnN1OB12YJZj/5jEfPr9dmcp2+646OpbEAWkcAzDCGKnzVOEu1W55aiyUt+UAdHbN1JUT8yqeF141Xn7UAIasmqClk5+MZm/p6poUDBbduhVM6pe9mABv56H/UTBRL8Kqqj0sBvsNOUh34QgcZ/XMSaw4Y0eMyusWeo14pCCmIvx07BOQIm8/DVB7+cl++RJgy0RSmRGVXJ/9ERqqHrXWM3C/YBRr5x5ejK4vsSZiOhCwzk4JB/pdfKSXxPTUcvbBCNi2Pcwoe7H5xZkWmc/3Ad1H2dPevF6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?14VMoJrC0whhTV1E2/1MOfORRf+WGHgMlHM1acBHi6Gmc3EhIR+0eEdggfVI?=
 =?us-ascii?Q?G78jeE6Fd8lVYjp6UhYPE55AiXcXxxZriRgFlpEZp1mJjLewIeMf7P7AcV/J?=
 =?us-ascii?Q?w4toA6I893lYnejjU27Mps76IKz1OcxW1MHftLJ2WZU+4YTEwv5fRg5ibt99?=
 =?us-ascii?Q?0+A9O/x1QpgRsheKEVxyOowQs4sZSYfLZawiziVNxlAu9ixbsHLgPIWSb6li?=
 =?us-ascii?Q?EFt+ZnAQ5CqWwCwgTYz7g+76DLmddcmRwaRNKeJTKe9IgUoF9w8GtkJR41jX?=
 =?us-ascii?Q?NhPTT/J7NmTalqqr0Pk6jj7ir2jcbQ7EDJIn+8MCKvHJmmH/HKRjvDUvTgU8?=
 =?us-ascii?Q?yck1nZ0fRp4p8IBh3bl05BJ5xsL4nY2QfzMX9yeNHcFdq2RTtUnqpxWi7oMQ?=
 =?us-ascii?Q?KjgY2DaGAe7BGsENiCN3ekV1nxDZVMyDARaHlSKJluro3JMNAP6L1KmqPzA7?=
 =?us-ascii?Q?d27YaaTss9Ld5OAkrIsoWlClHwL6V7hdG8MQQLmhUNEVHvejK1ZCAJynBiC+?=
 =?us-ascii?Q?sOgs+AVTggoSxp2BI8b2c6EqoGLuPPPSpCGA4vGscYHJHqQDMITkKRvUUefx?=
 =?us-ascii?Q?dy/nWYnXnuChbun3C21s1wjFBh+cE8++MsWp71vwDDJ9XroJbPwjhCTFBcBL?=
 =?us-ascii?Q?hK0uUWrJAZTmCvO6Cdnn0zDOvhsnNtfcwSV91KX0ECA0VNN5ygiGdB8QxRqm?=
 =?us-ascii?Q?FKEMD0/D0IzUWQIs7/77uZOJJf5VKLYBmGVFcuwkPF4yhwq0ZY1WivilWpEa?=
 =?us-ascii?Q?lu1p6MAiRrUYOeA8HWhrXl8RjLuU5DDHUmVBkou7PmW23c2m0DHfOmUaCsn/?=
 =?us-ascii?Q?Rza8a69q+iUKCVv1aFH0Sll0KP/PXoZReH1UdfA2xYsbsHdHEdJV/n3SBq4A?=
 =?us-ascii?Q?bueeNSknT/xcVLrcmN418dgC7OKcz1NcOJGwgyb+CwGJ51bfYn14PMlZhzFC?=
 =?us-ascii?Q?Jgx6ewnzjEy17PpwOdNkObFVMmVkC3dIxLCapTmcugiTLoxqIVNl2IoDvYqW?=
 =?us-ascii?Q?yzlaj3k6/aTzUXucmxer/9g/3dofHyvrEWsMxgIOLr+VlxI8ewwprRgq+9o+?=
 =?us-ascii?Q?KFIXaP7LYZxppzt/anA1uhitaPjU3UnnoxMKvbiThCfW8w++Kmd/049irdyu?=
 =?us-ascii?Q?kIAD5rRwBiz+lMDKikZyYVTBI5mGnC5BqWzp6xCc3AacXDiXtH3qtM5EPvxN?=
 =?us-ascii?Q?MLGBQ0+UOte11wdessByDmOrBHq6pwmyZiJ9gkJZqJ2ZdUJjK8XyqOzoTi9P?=
 =?us-ascii?Q?bnL0G/eSC7mKUWkokm13+e1v9Eu8ceNBPMFzCUV2zZub0URkChR8HmE1NBzP?=
 =?us-ascii?Q?363+AEg4qL61sVa3qweOAMZ4JObrQrvvY4JK7CZcmcetJCFeL35dp8ndsV+x?=
 =?us-ascii?Q?pP61/cMuM8dn3HtJQahRBqiYPJHbBJTwmqhu9Wn0gH7UeCheiLwOvY9oS/lA?=
 =?us-ascii?Q?yECsAY87xoImPE6IYN5//PvX2iFNPgrtZ+X805GMO6X8MXzZIvkHciQysbMF?=
 =?us-ascii?Q?ctT1JqysrfNrdpcxxSqVWsTu20nMFKbHQrhxjFGQeRRDw54TmHAI44LUMOAQ?=
 =?us-ascii?Q?lzmwikRzhJWknBM104r+ywxdkf0hjYaOf2waocuCOD/AzhNajxkvn06LUM/l?=
 =?us-ascii?Q?er93ZI97K8EZQLjfmuzGxTakQEC4NjmLNffm5fRet34jQvV/IlyL0Ns1OExU?=
 =?us-ascii?Q?cpIP2f2spMQFFeK87hdx3cl5f5shAZAqUq3PiRFuPgg7Q9LLjPBsRh757PVl?=
 =?us-ascii?Q?e/8dO/eNNBa8rdwVFWg6OvxvLhQ5NPg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4b8a8f-0df4-4de2-4dd0-08dec0177649
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 19:53:33.6577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwZQpH4aXZ/pOplyq8oRPF8I22OD1Z2u5r2jnZW9/d64+aMXFXhlk1EnL2E0oqihHQNTgqyDWdEkh7ak8icSlBYYGqP2y5wXx57tjE6qoik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5653
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

This patch adds U-Boot pin controller and gpio driver for Airoha AN7581 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/airoha/Kconfig          |    5 +
 drivers/pinctrl/airoha/Makefile         |    2 +
 drivers/pinctrl/airoha/pinctrl-an7581.c | 1077 +++++++++++++++++++++++
 3 files changed, 1084 insertions(+)
 create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c

diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
index eb87afbb374..ae387f70b22 100644
--- a/drivers/pinctrl/airoha/Kconfig
+++ b/drivers/pinctrl/airoha/Kconfig
@@ -9,3 +9,8 @@ config PINCTRL_AIROHA
 	select REGMAP
 	select SYSCON
 	bool
+
+config PINCTRL_AIROHA_AN7581
+	bool "Airoha AN7581 pin controller and gpio driver"
+	depends on TARGET_AN7581
+	select PINCTRL_AIROHA
diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha/Makefile
index a25b744dd7a..909bd9a04d9 100644
--- a/drivers/pinctrl/airoha/Makefile
+++ b/drivers/pinctrl/airoha/Makefile
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_PINCTRL_AIROHA)		+= pinctrl-airoha.o
+
+obj-$(CONFIG_PINCTRL_AIROHA_AN7581)	+= pinctrl-an7581.o
diff --git a/drivers/pinctrl/airoha/pinctrl-an7581.c b/drivers/pinctrl/airoha/pinctrl-an7581.c
new file mode 100644
index 00000000000..a3d3fcc11b6
--- /dev/null
+++ b/drivers/pinctrl/airoha/pinctrl-an7581.c
@@ -0,0 +1,1077 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
+ * Author: Markus Gothe <markus.gothe@genexis.eu>
+ */
+#include "airoha-common.h"
+
+static const int pon_pins[] = { 49, 50, 51, 52, 53, 54 };
+static const int pon_tod_1pps_pins[] = { 46 };
+static const int gsw_tod_1pps_pins[] = { 46 };
+static const int sipo_pins[] = { 16, 17 };
+static const int sipo_rclk_pins[] = { 16, 17, 43 };
+static const int mdio_pins[] = { 14, 15 };
+static const int uart2_pins[] = { 48, 55 };
+static const int uart2_cts_rts_pins[] = { 46, 47 };
+static const int hsuart_pins[] = { 28, 29 };
+static const int hsuart_cts_rts_pins[] = { 26, 27 };
+static const int uart4_pins[] = { 38, 39 };
+static const int uart5_pins[] = { 18, 19 };
+static const int i2c0_pins[] = { 2, 3 };
+static const int i2c1_pins[] = { 14, 15 };
+static const int jtag_udi_pins[] = { 16, 17, 18, 19, 20 };
+static const int jtag_dfd_pins[] = { 16, 17, 18, 19, 20 };
+static const int i2s_pins[] = { 26, 27, 28, 29 };
+static const int pcm1_pins[] = { 22, 23, 24, 25 };
+static const int pcm2_pins[] = { 18, 19, 20, 21 };
+static const int spi_quad_pins[] = { 32, 33 };
+static const int spi_pins[] = { 4, 5, 6, 7 };
+static const int spi_cs1_pins[] = { 34 };
+static const int pcm_spi_pins[] = { 18, 19, 20, 21, 22, 23, 24, 25 };
+static const int pcm_spi_int_pins[] = { 14 };
+static const int pcm_spi_rst_pins[] = { 15 };
+static const int pcm_spi_cs1_pins[] = { 43 };
+static const int pcm_spi_cs2_pins[] = { 40 };
+static const int pcm_spi_cs2_p128_pins[] = { 40 };
+static const int pcm_spi_cs2_p156_pins[] = { 40 };
+static const int pcm_spi_cs3_pins[] = { 41 };
+static const int pcm_spi_cs4_pins[] = { 42 };
+static const int emmc_pins[] = {
+	4, 5, 6, 30, 31, 32, 33, 34, 35, 36, 37
+};
+static const int pnand_pins[] = {
+	4, 5, 6, 7, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42
+};
+static const int gpio0_pins[] = { 13 };
+static const int gpio1_pins[] = { 14 };
+static const int gpio2_pins[] = { 15 };
+static const int gpio3_pins[] = { 16 };
+static const int gpio4_pins[] = { 17 };
+static const int gpio5_pins[] = { 18 };
+static const int gpio6_pins[] = { 19 };
+static const int gpio7_pins[] = { 20 };
+static const int gpio8_pins[] = { 21 };
+static const int gpio9_pins[] = { 22 };
+static const int gpio10_pins[] = { 23 };
+static const int gpio11_pins[] = { 24 };
+static const int gpio12_pins[] = { 25 };
+static const int gpio13_pins[] = { 26 };
+static const int gpio14_pins[] = { 27 };
+static const int gpio15_pins[] = { 28 };
+static const int gpio16_pins[] = { 29 };
+static const int gpio17_pins[] = { 30 };
+static const int gpio18_pins[] = { 31 };
+static const int gpio19_pins[] = { 32 };
+static const int gpio20_pins[] = { 33 };
+static const int gpio21_pins[] = { 34 };
+static const int gpio22_pins[] = { 35 };
+static const int gpio23_pins[] = { 36 };
+static const int gpio24_pins[] = { 37 };
+static const int gpio25_pins[] = { 38 };
+static const int gpio26_pins[] = { 39 };
+static const int gpio27_pins[] = { 40 };
+static const int gpio28_pins[] = { 41 };
+static const int gpio29_pins[] = { 42 };
+static const int gpio30_pins[] = { 43 };
+static const int gpio31_pins[] = { 44 };
+static const int gpio32_pins[] = { 45 };
+static const int gpio33_pins[] = { 46 };
+static const int gpio34_pins[] = { 47 };
+static const int gpio35_pins[] = { 48 };
+static const int gpio36_pins[] = { 49 };
+static const int gpio37_pins[] = { 50 };
+static const int gpio38_pins[] = { 51 };
+static const int gpio39_pins[] = { 52 };
+static const int gpio40_pins[] = { 53 };
+static const int gpio41_pins[] = { 54 };
+static const int gpio42_pins[] = { 55 };
+static const int gpio43_pins[] = { 56 };
+static const int gpio44_pins[] = { 57 };
+static const int gpio45_pins[] = { 58 };
+static const int gpio46_pins[] = { 59 };
+static const int pcie_reset0_pins[] = { 61 };
+static const int pcie_reset1_pins[] = { 62 };
+static const int pcie_reset2_pins[] = { 63 };
+
+static struct pinctrl_pin_desc pinctrl_pins[] = {
+	PINCTRL_PIN(0, "uart1_txd"),
+	PINCTRL_PIN(1, "uart1_rxd"),
+	PINCTRL_PIN(2, "i2c_scl"),
+	PINCTRL_PIN(3, "i2c_sda"),
+	PINCTRL_PIN(4, "spi_cs0"),
+	PINCTRL_PIN(5, "spi_clk"),
+	PINCTRL_PIN(6, "spi_mosi"),
+	PINCTRL_PIN(7, "spi_miso"),
+	PINCTRL_PIN(13, "gpio0"),
+	PINCTRL_PIN(14, "gpio1"),
+	PINCTRL_PIN(15, "gpio2"),
+	PINCTRL_PIN(16, "gpio3"),
+	PINCTRL_PIN(17, "gpio4"),
+	PINCTRL_PIN(18, "gpio5"),
+	PINCTRL_PIN(19, "gpio6"),
+	PINCTRL_PIN(20, "gpio7"),
+	PINCTRL_PIN(21, "gpio8"),
+	PINCTRL_PIN(22, "gpio9"),
+	PINCTRL_PIN(23, "gpio10"),
+	PINCTRL_PIN(24, "gpio11"),
+	PINCTRL_PIN(25, "gpio12"),
+	PINCTRL_PIN(26, "gpio13"),
+	PINCTRL_PIN(27, "gpio14"),
+	PINCTRL_PIN(28, "gpio15"),
+	PINCTRL_PIN(29, "gpio16"),
+	PINCTRL_PIN(30, "gpio17"),
+	PINCTRL_PIN(31, "gpio18"),
+	PINCTRL_PIN(32, "gpio19"),
+	PINCTRL_PIN(33, "gpio20"),
+	PINCTRL_PIN(34, "gpio21"),
+	PINCTRL_PIN(35, "gpio22"),
+	PINCTRL_PIN(36, "gpio23"),
+	PINCTRL_PIN(37, "gpio24"),
+	PINCTRL_PIN(38, "gpio25"),
+	PINCTRL_PIN(39, "gpio26"),
+	PINCTRL_PIN(40, "gpio27"),
+	PINCTRL_PIN(41, "gpio28"),
+	PINCTRL_PIN(42, "gpio29"),
+	PINCTRL_PIN(43, "gpio30"),
+	PINCTRL_PIN(44, "gpio31"),
+	PINCTRL_PIN(45, "gpio32"),
+	PINCTRL_PIN(46, "gpio33"),
+	PINCTRL_PIN(47, "gpio34"),
+	PINCTRL_PIN(48, "gpio35"),
+	PINCTRL_PIN(49, "gpio36"),
+	PINCTRL_PIN(50, "gpio37"),
+	PINCTRL_PIN(51, "gpio38"),
+	PINCTRL_PIN(52, "gpio39"),
+	PINCTRL_PIN(53, "gpio40"),
+	PINCTRL_PIN(54, "gpio41"),
+	PINCTRL_PIN(55, "gpio42"),
+	PINCTRL_PIN(56, "gpio43"),
+	PINCTRL_PIN(57, "gpio44"),
+	PINCTRL_PIN(58, "gpio45"),
+	PINCTRL_PIN(59, "gpio46"),
+	PINCTRL_PIN(61, "pcie_reset0"),
+	PINCTRL_PIN(62, "pcie_reset1"),
+	PINCTRL_PIN(63, "pcie_reset2"),
+};
+
+static const char *const pon_groups[] = { "pon" };
+static const char *const tod_1pps_groups[] = { "pon_tod_1pps", "gsw_tod_1pps" };
+static const char *const sipo_groups[] = { "sipo", "sipo_rclk" };
+static const char *const mdio_groups[] = { "mdio" };
+
+static const char *const uart_groups[] = {
+	"uart2", "uart2_cts_rts", "hsuart", "hsuart_cts_rts", "uart4", "uart5"
+};
+static const char *const i2c_groups[] = { "i2c1" };
+static const char *const jtag_groups[] = { "jtag_udi", "jtag_dfd" };
+static const char *const pcm_groups[] = { "pcm1", "pcm2" };
+static const char *const spi_groups[] = { "spi_quad", "spi_cs1" };
+static const char *const pcm_spi_groups[] = {
+	"pcm_spi",          "pcm_spi_int",      "pcm_spi_rst", "pcm_spi_cs1",
+	"pcm_spi_cs2_p156", "pcm_spi_cs2_p128", "pcm_spi_cs3", "pcm_spi_cs4"
+};
+
+static const char *const i2s_groups[] = { "i2s" };
+static const char *const emmc_groups[] = { "emmc" };
+static const char *const pnand_groups[] = { "pnand" };
+static const char *const pcie_reset_groups[] = {
+	"pcie_reset0", "pcie_reset1", "pcie_reset2"
+};
+
+static const char *const pwm_groups[] = {
+	"gpio0",  "gpio1",  "gpio2",  "gpio3",  "gpio4",  "gpio5",  "gpio6",
+	"gpio7",  "gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13",
+	"gpio14", "gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20",
+	"gpio21", "gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27",
+	"gpio28", "gpio29", "gpio30", "gpio31", "gpio36", "gpio37", "gpio38",
+	"gpio39", "gpio40", "gpio41", "gpio42", "gpio43", "gpio44", "gpio45",
+	"gpio46"
+};
+static const char *const phy1_led0_groups[] = {
+	"gpio33", "gpio34", "gpio35", "gpio42",
+	"gpio43", "gpio44", "gpio45", "gpio46"
+};
+static const char *const phy2_led0_groups[] = {
+	"gpio33", "gpio34", "gpio35", "gpio42",
+	"gpio43", "gpio44", "gpio45", "gpio46"
+};
+static const char *const phy3_led0_groups[] = {
+	"gpio33", "gpio34", "gpio35", "gpio42",
+	"gpio43", "gpio44", "gpio45", "gpio46"
+};
+static const char *const phy4_led0_groups[] = {
+	"gpio33", "gpio34", "gpio35", "gpio42",
+	"gpio43", "gpio44", "gpio45", "gpio46"
+};
+static const char *const phy1_led1_groups[] = {
+	"gpio43", "gpio44", "gpio45", "gpio46"
+};
+static const char *const phy2_led1_groups[] = {
+	"gpio43", "gpio44", "gpio45", "gpio46"
+};
+static const char *const phy3_led1_groups[] = {
+	"gpio43", "gpio44", "gpio45", "gpio46"
+};
+static const char *const phy4_led1_groups[] = {
+	"gpio43", "gpio44", "gpio45", "gpio46"
+};
+
+static const struct airoha_pinctrl_conf pinctrl_drive_e2_conf[] = {
+	PINCTRL_CONF_DESC(0, REG_I2C_SDA_E2, UART1_TXD_E2_MASK),
+	PINCTRL_CONF_DESC(1, REG_I2C_SDA_E2, UART1_RXD_E2_MASK),
+	PINCTRL_CONF_DESC(2, REG_I2C_SDA_E2, I2C_SDA_E2_MASK),
+	PINCTRL_CONF_DESC(3, REG_I2C_SDA_E2, I2C_SCL_E2_MASK),
+	PINCTRL_CONF_DESC(4, REG_I2C_SDA_E2, SPI_CS0_E2_MASK),
+	PINCTRL_CONF_DESC(5, REG_I2C_SDA_E2, SPI_CLK_E2_MASK),
+	PINCTRL_CONF_DESC(6, REG_I2C_SDA_E2, SPI_MOSI_E2_MASK),
+	PINCTRL_CONF_DESC(7, REG_I2C_SDA_E2, SPI_MISO_E2_MASK),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_E2, BIT(0)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_E2, BIT(1)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_E2, BIT(2)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_E2, BIT(3)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_E2, BIT(4)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_E2, BIT(5)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_E2, BIT(6)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_E2, BIT(7)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_E2, BIT(8)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_E2, BIT(9)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_E2, BIT(10)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_E2, BIT(11)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_E2, BIT(12)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_E2, BIT(13)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_E2, BIT(14)),
+	PINCTRL_CONF_DESC(28, REG_GPIO_L_E2, BIT(15)),
+	PINCTRL_CONF_DESC(29, REG_GPIO_L_E2, BIT(16)),
+	PINCTRL_CONF_DESC(30, REG_GPIO_L_E2, BIT(17)),
+	PINCTRL_CONF_DESC(31, REG_GPIO_L_E2, BIT(18)),
+	PINCTRL_CONF_DESC(32, REG_GPIO_L_E2, BIT(19)),
+	PINCTRL_CONF_DESC(33, REG_GPIO_L_E2, BIT(20)),
+	PINCTRL_CONF_DESC(34, REG_GPIO_L_E2, BIT(21)),
+	PINCTRL_CONF_DESC(35, REG_GPIO_L_E2, BIT(22)),
+	PINCTRL_CONF_DESC(36, REG_GPIO_L_E2, BIT(23)),
+	PINCTRL_CONF_DESC(37, REG_GPIO_L_E2, BIT(24)),
+	PINCTRL_CONF_DESC(38, REG_GPIO_L_E2, BIT(25)),
+	PINCTRL_CONF_DESC(39, REG_GPIO_L_E2, BIT(26)),
+	PINCTRL_CONF_DESC(40, REG_GPIO_L_E2, BIT(27)),
+	PINCTRL_CONF_DESC(41, REG_GPIO_L_E2, BIT(28)),
+	PINCTRL_CONF_DESC(42, REG_GPIO_L_E2, BIT(29)),
+	PINCTRL_CONF_DESC(43, REG_GPIO_L_E2, BIT(30)),
+	PINCTRL_CONF_DESC(44, REG_GPIO_L_E2, BIT(31)),
+	PINCTRL_CONF_DESC(45, REG_GPIO_H_E2, BIT(0)),
+	PINCTRL_CONF_DESC(46, REG_GPIO_H_E2, BIT(1)),
+	PINCTRL_CONF_DESC(47, REG_GPIO_H_E2, BIT(2)),
+	PINCTRL_CONF_DESC(48, REG_GPIO_H_E2, BIT(3)),
+	PINCTRL_CONF_DESC(49, REG_GPIO_H_E2, BIT(4)),
+	PINCTRL_CONF_DESC(50, REG_GPIO_H_E2, BIT(5)),
+	PINCTRL_CONF_DESC(51, REG_GPIO_H_E2, BIT(6)),
+	PINCTRL_CONF_DESC(52, REG_GPIO_H_E2, BIT(7)),
+	PINCTRL_CONF_DESC(53, REG_GPIO_H_E2, BIT(8)),
+	PINCTRL_CONF_DESC(54, REG_GPIO_H_E2, BIT(9)),
+	PINCTRL_CONF_DESC(55, REG_GPIO_H_E2, BIT(10)),
+	PINCTRL_CONF_DESC(56, REG_GPIO_H_E2, BIT(11)),
+	PINCTRL_CONF_DESC(57, REG_GPIO_H_E2, BIT(12)),
+	PINCTRL_CONF_DESC(58, REG_GPIO_H_E2, BIT(13)),
+	PINCTRL_CONF_DESC(59, REG_GPIO_H_E2, BIT(14)),
+	PINCTRL_CONF_DESC(61, REG_I2C_SDA_E2, PCIE0_RESET_E2_MASK),
+	PINCTRL_CONF_DESC(62, REG_I2C_SDA_E2, PCIE1_RESET_E2_MASK),
+	PINCTRL_CONF_DESC(63, REG_I2C_SDA_E2, PCIE2_RESET_E2_MASK),
+};
+
+static const struct airoha_pinctrl_conf pinctrl_drive_e4_conf[] = {
+	PINCTRL_CONF_DESC(0, REG_I2C_SDA_E4, UART1_TXD_E4_MASK),
+	PINCTRL_CONF_DESC(1, REG_I2C_SDA_E4, UART1_RXD_E4_MASK),
+	PINCTRL_CONF_DESC(2, REG_I2C_SDA_E4, I2C_SDA_E4_MASK),
+	PINCTRL_CONF_DESC(3, REG_I2C_SDA_E4, I2C_SCL_E4_MASK),
+	PINCTRL_CONF_DESC(4, REG_I2C_SDA_E4, SPI_CS0_E4_MASK),
+	PINCTRL_CONF_DESC(5, REG_I2C_SDA_E4, SPI_CLK_E4_MASK),
+	PINCTRL_CONF_DESC(6, REG_I2C_SDA_E4, SPI_MOSI_E4_MASK),
+	PINCTRL_CONF_DESC(7, REG_I2C_SDA_E4, SPI_MISO_E4_MASK),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_E4, BIT(0)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_E4, BIT(1)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_E4, BIT(2)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_E4, BIT(3)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_E4, BIT(4)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_E4, BIT(5)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_E4, BIT(6)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_E4, BIT(7)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_E4, BIT(8)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_E4, BIT(9)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_E4, BIT(10)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_E4, BIT(11)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_E4, BIT(12)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_E4, BIT(13)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_E4, BIT(14)),
+	PINCTRL_CONF_DESC(28, REG_GPIO_L_E4, BIT(15)),
+	PINCTRL_CONF_DESC(29, REG_GPIO_L_E4, BIT(16)),
+	PINCTRL_CONF_DESC(30, REG_GPIO_L_E4, BIT(17)),
+	PINCTRL_CONF_DESC(31, REG_GPIO_L_E4, BIT(18)),
+	PINCTRL_CONF_DESC(32, REG_GPIO_L_E4, BIT(19)),
+	PINCTRL_CONF_DESC(33, REG_GPIO_L_E4, BIT(20)),
+	PINCTRL_CONF_DESC(34, REG_GPIO_L_E4, BIT(21)),
+	PINCTRL_CONF_DESC(35, REG_GPIO_L_E4, BIT(22)),
+	PINCTRL_CONF_DESC(36, REG_GPIO_L_E4, BIT(23)),
+	PINCTRL_CONF_DESC(37, REG_GPIO_L_E4, BIT(24)),
+	PINCTRL_CONF_DESC(38, REG_GPIO_L_E4, BIT(25)),
+	PINCTRL_CONF_DESC(39, REG_GPIO_L_E4, BIT(26)),
+	PINCTRL_CONF_DESC(40, REG_GPIO_L_E4, BIT(27)),
+	PINCTRL_CONF_DESC(41, REG_GPIO_L_E4, BIT(28)),
+	PINCTRL_CONF_DESC(42, REG_GPIO_L_E4, BIT(29)),
+	PINCTRL_CONF_DESC(43, REG_GPIO_L_E4, BIT(30)),
+	PINCTRL_CONF_DESC(44, REG_GPIO_L_E4, BIT(31)),
+	PINCTRL_CONF_DESC(45, REG_GPIO_H_E4, BIT(0)),
+	PINCTRL_CONF_DESC(46, REG_GPIO_H_E4, BIT(1)),
+	PINCTRL_CONF_DESC(47, REG_GPIO_H_E4, BIT(2)),
+	PINCTRL_CONF_DESC(48, REG_GPIO_H_E4, BIT(3)),
+	PINCTRL_CONF_DESC(49, REG_GPIO_H_E4, BIT(4)),
+	PINCTRL_CONF_DESC(50, REG_GPIO_H_E4, BIT(5)),
+	PINCTRL_CONF_DESC(51, REG_GPIO_H_E4, BIT(6)),
+	PINCTRL_CONF_DESC(52, REG_GPIO_H_E4, BIT(7)),
+	PINCTRL_CONF_DESC(53, REG_GPIO_H_E4, BIT(8)),
+	PINCTRL_CONF_DESC(54, REG_GPIO_H_E4, BIT(9)),
+	PINCTRL_CONF_DESC(55, REG_GPIO_H_E4, BIT(10)),
+	PINCTRL_CONF_DESC(56, REG_GPIO_H_E4, BIT(11)),
+	PINCTRL_CONF_DESC(57, REG_GPIO_H_E4, BIT(12)),
+	PINCTRL_CONF_DESC(58, REG_GPIO_H_E4, BIT(13)),
+	PINCTRL_CONF_DESC(59, REG_GPIO_H_E4, BIT(14)),
+	PINCTRL_CONF_DESC(61, REG_I2C_SDA_E4, PCIE0_RESET_E4_MASK),
+	PINCTRL_CONF_DESC(62, REG_I2C_SDA_E4, PCIE1_RESET_E4_MASK),
+	PINCTRL_CONF_DESC(63, REG_I2C_SDA_E4, PCIE2_RESET_E4_MASK),
+};
+
+static const struct airoha_pinctrl_conf pinctrl_pcie_rst_od_conf[] = {
+	PINCTRL_CONF_DESC(61, REG_PCIE_RESET_OD, PCIE0_RESET_OD_MASK),
+	PINCTRL_CONF_DESC(62, REG_PCIE_RESET_OD, PCIE1_RESET_OD_MASK),
+	PINCTRL_CONF_DESC(63, REG_PCIE_RESET_OD, PCIE2_RESET_OD_MASK),
+};
+
+static const struct airoha_pinctrl_func_group pon_func_group[] = {
+	{
+		.name = "pon",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_PON_MODE,
+			       GPIO_PON_MODE_MASK, GPIO_PON_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group tod_1pps_func_group[] = {
+	{
+		.name = "pon_tod_1pps",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_2ND_I2C_MODE,
+			       PON_TOD_1PPS_MODE_MASK, PON_TOD_1PPS_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "gsw_tod_1pps",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_2ND_I2C_MODE,
+			       GSW_TOD_1PPS_MODE_MASK, GSW_TOD_1PPS_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group sipo_func_group[] = {
+	{
+		.name = "sipo",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_PON_MODE,
+			       GPIO_SIPO_MODE_MASK | SIPO_RCLK_MODE_MASK,
+			       GPIO_SIPO_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "sipo_rclk",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_PON_MODE,
+			       GPIO_SIPO_MODE_MASK | SIPO_RCLK_MODE_MASK,
+			       GPIO_SIPO_MODE_MASK | SIPO_RCLK_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group mdio_func_group[] = {
+	{
+		.name = "mdio",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_2ND_I2C_MODE,
+			       GPIO_MDC_IO_MASTER_MODE_MODE,
+			       GPIO_MDC_IO_MASTER_MODE_MODE },
+		.regmap[1] = { AIROHA_FUNC_MUX, AN7581_REG_FORCE_GPIO_EN,
+			       FORCE_GPIO_EN(1) | FORCE_GPIO_EN(2),
+			       FORCE_GPIO_EN(1) | FORCE_GPIO_EN(2) },
+		.regmap_size = 2,
+	},
+};
+
+static const struct airoha_pinctrl_func_group uart_func_group[] = {
+	{
+		.name = "uart2",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_PON_MODE,
+			       GPIO_UART2_MODE_MASK, GPIO_UART2_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "uart2_cts_rts",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_PON_MODE,
+			       GPIO_UART2_MODE_MASK |
+				       GPIO_UART2_CTS_RTS_MODE_MASK,
+			       GPIO_UART2_MODE_MASK |
+				       GPIO_UART2_CTS_RTS_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "hsuart",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_PON_MODE,
+			       GPIO_HSUART_MODE_MASK |
+				       GPIO_HSUART_CTS_RTS_MODE_MASK,
+			       GPIO_HSUART_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "hsuart_cts_rts",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_PON_MODE,
+			       GPIO_HSUART_MODE_MASK |
+				       GPIO_HSUART_CTS_RTS_MODE_MASK,
+			       GPIO_HSUART_MODE_MASK |
+				       GPIO_HSUART_CTS_RTS_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "uart4",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_PON_MODE,
+			       GPIO_UART4_MODE_MASK, GPIO_UART4_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "uart5",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_PON_MODE,
+			       GPIO_UART5_MODE_MASK, GPIO_UART5_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group i2c_func_group[] = {
+	{
+		.name = "i2c1",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_2ND_I2C_MODE,
+			       GPIO_2ND_I2C_MODE_MASK, GPIO_2ND_I2C_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group jtag_func_group[] = {
+	{
+		.name = "jtag_udi",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_NPU_UART_EN,
+			       JTAG_UDI_EN_MASK, JTAG_UDI_EN_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "jtag_dfd",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_NPU_UART_EN,
+			       JTAG_DFD_EN_MASK, JTAG_DFD_EN_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group pcm_func_group[] = {
+	{
+		.name = "pcm1",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM1_MODE_MASK, GPIO_PCM1_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm2",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM2_MODE_MASK, GPIO_PCM2_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group spi_func_group[] = {
+	{
+		.name = "spi_quad",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_QUAD_MODE_MASK,
+			       GPIO_SPI_QUAD_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "spi_cs1",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_CS1_MODE_MASK, GPIO_SPI_CS1_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "spi_cs2",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_CS2_MODE_MASK, GPIO_SPI_CS2_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "spi_cs3",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_CS3_MODE_MASK, GPIO_SPI_CS3_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "spi_cs4",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_CS4_MODE_MASK, GPIO_SPI_CS4_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group pcm_spi_func_group[] = {
+	{
+		.name = "pcm_spi",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_MODE_MASK, GPIO_PCM_SPI_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_int",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_INT_MODE_MASK, GPIO_PCM_INT_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_rst",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_RESET_MODE_MASK,
+			       GPIO_PCM_RESET_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs1",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS1_MODE_MASK,
+			       GPIO_PCM_SPI_CS1_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs2_p128",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS2_MODE_P128_MASK,
+			       GPIO_PCM_SPI_CS2_MODE_P128_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs2_p156",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS2_MODE_P156_MASK,
+			       GPIO_PCM_SPI_CS2_MODE_P156_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs3",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS3_MODE_MASK,
+			       GPIO_PCM_SPI_CS3_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs4",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS4_MODE_MASK,
+			       GPIO_PCM_SPI_CS4_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group i2s_func_group[] = {
+	{
+		.name = "i2s",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_2ND_I2C_MODE,
+			       GPIO_I2S_MODE_MASK, GPIO_I2S_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group emmc_func_group[] = {
+	{
+		.name = "emmc",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_PON_MODE,
+			       GPIO_EMMC_MODE_MASK, GPIO_EMMC_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group pnand_func_group[] = {
+	{
+		.name = "pnand",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_PON_MODE,
+			       GPIO_PARALLEL_NAND_MODE_MASK,
+			       GPIO_PARALLEL_NAND_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group pcie_reset_func_group[] = {
+	{
+		.name = "pcie_reset0",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_PON_MODE,
+			       GPIO_PCIE_RESET0_MASK, GPIO_PCIE_RESET0_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcie_reset1",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_PON_MODE,
+			       GPIO_PCIE_RESET1_MASK, GPIO_PCIE_RESET1_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcie_reset2",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_PON_MODE,
+			       GPIO_PCIE_RESET2_MASK, GPIO_PCIE_RESET2_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group pwm_func_group[] = {
+	AIROHA_PINCTRL_PWM("gpio0", GPIO0_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio1", GPIO1_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio2", GPIO2_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio3", GPIO3_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio4", GPIO4_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio5", GPIO5_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio6", GPIO6_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio7", GPIO7_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio8", GPIO8_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio9", GPIO9_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio10", GPIO10_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio11", GPIO11_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio12", GPIO12_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio13", GPIO13_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio14", GPIO14_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio15", GPIO15_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio16", GPIO16_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio17", GPIO17_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio18", GPIO18_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio19", GPIO19_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio20", GPIO20_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio21", GPIO21_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio22", GPIO22_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio23", GPIO23_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio24", GPIO24_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio25", GPIO25_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio26", GPIO26_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio27", GPIO27_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio28", GPIO28_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio29", GPIO29_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio30", GPIO30_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio31", GPIO31_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio36", GPIO36_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio37", GPIO37_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio38", GPIO38_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio39", GPIO39_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio40", GPIO40_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio41", GPIO41_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio42", GPIO42_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio43", GPIO43_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio44", GPIO44_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio45", GPIO45_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio46", GPIO46_FLASH_MODE_CFG),
+};
+
+static const struct airoha_pinctrl_func_group phy1_led0_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio33", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio34", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio35", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio42", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio43", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio44", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio45", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio46", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(0)),
+};
+
+static const struct airoha_pinctrl_func_group phy2_led0_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio33", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio34", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio35", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio42", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio43", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio44", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio45", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio46", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(1)),
+};
+
+static const struct airoha_pinctrl_func_group phy3_led0_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio33", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio34", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio35", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio42", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio43", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio44", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio45", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio46", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(2)),
+};
+
+static const struct airoha_pinctrl_func_group phy4_led0_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio33", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio34", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio35", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio42", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio43", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio44", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio45", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio46", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(3)),
+};
+
+static const struct airoha_pinctrl_func_group phy1_led1_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio43", GPIO_LAN0_LED1_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio44", GPIO_LAN1_LED1_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio45", GPIO_LAN2_LED1_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio46", GPIO_LAN3_LED1_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(0)),
+};
+
+static const struct airoha_pinctrl_func_group phy2_led1_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio43", GPIO_LAN0_LED1_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio44", GPIO_LAN1_LED1_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio45", GPIO_LAN2_LED1_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio46", GPIO_LAN3_LED1_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(1)),
+};
+
+static const struct airoha_pinctrl_func_group phy3_led1_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio43", GPIO_LAN0_LED1_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio44", GPIO_LAN1_LED1_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio45", GPIO_LAN2_LED1_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio46", GPIO_LAN3_LED1_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(2)),
+};
+
+static const struct airoha_pinctrl_func_group phy4_led1_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio43", GPIO_LAN0_LED1_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio44", GPIO_LAN1_LED1_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio45", GPIO_LAN2_LED1_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio46", GPIO_LAN3_LED1_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(3)),
+};
+
+static const struct pingroup pinctrl_groups[] = {
+	PINCTRL_PIN_GROUP("pon", pon),
+	PINCTRL_PIN_GROUP("pon_tod_1pps", pon_tod_1pps),
+	PINCTRL_PIN_GROUP("gsw_tod_1pps", gsw_tod_1pps),
+	PINCTRL_PIN_GROUP("sipo", sipo),
+	PINCTRL_PIN_GROUP("sipo_rclk", sipo_rclk),
+	PINCTRL_PIN_GROUP("mdio", mdio),
+	PINCTRL_PIN_GROUP("uart2", uart2),
+	PINCTRL_PIN_GROUP("uart2_cts_rts", uart2_cts_rts),
+	PINCTRL_PIN_GROUP("hsuart", hsuart),
+	PINCTRL_PIN_GROUP("hsuart_cts_rts", hsuart_cts_rts),
+	PINCTRL_PIN_GROUP("uart4", uart4),
+	PINCTRL_PIN_GROUP("uart5", uart5),
+	PINCTRL_PIN_GROUP("i2c0", i2c0),
+	PINCTRL_PIN_GROUP("i2c1", i2c1),
+	PINCTRL_PIN_GROUP("jtag_udi", jtag_udi),
+	PINCTRL_PIN_GROUP("jtag_dfd", jtag_dfd),
+	PINCTRL_PIN_GROUP("i2s", i2s),
+	PINCTRL_PIN_GROUP("pcm1", pcm1),
+	PINCTRL_PIN_GROUP("pcm2", pcm2),
+	PINCTRL_PIN_GROUP("spi", spi),
+	PINCTRL_PIN_GROUP("spi_quad", spi_quad),
+	PINCTRL_PIN_GROUP("spi_cs1", spi_cs1),
+	PINCTRL_PIN_GROUP("pcm_spi", pcm_spi),
+	PINCTRL_PIN_GROUP("pcm_spi_int", pcm_spi_int),
+	PINCTRL_PIN_GROUP("pcm_spi_rst", pcm_spi_rst),
+	PINCTRL_PIN_GROUP("pcm_spi_cs1", pcm_spi_cs1),
+	PINCTRL_PIN_GROUP("pcm_spi_cs2_p128", pcm_spi_cs2_p128),
+	PINCTRL_PIN_GROUP("pcm_spi_cs2_p156", pcm_spi_cs2_p156),
+	PINCTRL_PIN_GROUP("pcm_spi_cs2", pcm_spi_cs2),
+	PINCTRL_PIN_GROUP("pcm_spi_cs3", pcm_spi_cs3),
+	PINCTRL_PIN_GROUP("pcm_spi_cs4", pcm_spi_cs4),
+	PINCTRL_PIN_GROUP("emmc", emmc),
+	PINCTRL_PIN_GROUP("pnand", pnand),
+	PINCTRL_PIN_GROUP("gpio0", gpio0),
+	PINCTRL_PIN_GROUP("gpio1", gpio1),
+	PINCTRL_PIN_GROUP("gpio2", gpio2),
+	PINCTRL_PIN_GROUP("gpio3", gpio3),
+	PINCTRL_PIN_GROUP("gpio4", gpio4),
+	PINCTRL_PIN_GROUP("gpio5", gpio5),
+	PINCTRL_PIN_GROUP("gpio6", gpio6),
+	PINCTRL_PIN_GROUP("gpio7", gpio7),
+	PINCTRL_PIN_GROUP("gpio8", gpio8),
+	PINCTRL_PIN_GROUP("gpio9", gpio9),
+	PINCTRL_PIN_GROUP("gpio10", gpio10),
+	PINCTRL_PIN_GROUP("gpio11", gpio11),
+	PINCTRL_PIN_GROUP("gpio12", gpio12),
+	PINCTRL_PIN_GROUP("gpio13", gpio13),
+	PINCTRL_PIN_GROUP("gpio14", gpio14),
+	PINCTRL_PIN_GROUP("gpio15", gpio15),
+	PINCTRL_PIN_GROUP("gpio16", gpio16),
+	PINCTRL_PIN_GROUP("gpio17", gpio17),
+	PINCTRL_PIN_GROUP("gpio18", gpio18),
+	PINCTRL_PIN_GROUP("gpio19", gpio19),
+	PINCTRL_PIN_GROUP("gpio20", gpio20),
+	PINCTRL_PIN_GROUP("gpio21", gpio21),
+	PINCTRL_PIN_GROUP("gpio22", gpio22),
+	PINCTRL_PIN_GROUP("gpio23", gpio23),
+	PINCTRL_PIN_GROUP("gpio24", gpio24),
+	PINCTRL_PIN_GROUP("gpio25", gpio25),
+	PINCTRL_PIN_GROUP("gpio26", gpio26),
+	PINCTRL_PIN_GROUP("gpio27", gpio27),
+	PINCTRL_PIN_GROUP("gpio28", gpio28),
+	PINCTRL_PIN_GROUP("gpio29", gpio29),
+	PINCTRL_PIN_GROUP("gpio30", gpio30),
+	PINCTRL_PIN_GROUP("gpio31", gpio31),
+	PINCTRL_PIN_GROUP("gpio32", gpio32),
+	PINCTRL_PIN_GROUP("gpio33", gpio33),
+	PINCTRL_PIN_GROUP("gpio34", gpio34),
+	PINCTRL_PIN_GROUP("gpio35", gpio35),
+	PINCTRL_PIN_GROUP("gpio36", gpio36),
+	PINCTRL_PIN_GROUP("gpio37", gpio37),
+	PINCTRL_PIN_GROUP("gpio38", gpio38),
+	PINCTRL_PIN_GROUP("gpio39", gpio39),
+	PINCTRL_PIN_GROUP("gpio40", gpio40),
+	PINCTRL_PIN_GROUP("gpio41", gpio41),
+	PINCTRL_PIN_GROUP("gpio42", gpio42),
+	PINCTRL_PIN_GROUP("gpio43", gpio43),
+	PINCTRL_PIN_GROUP("gpio44", gpio44),
+	PINCTRL_PIN_GROUP("gpio45", gpio45),
+	PINCTRL_PIN_GROUP("gpio46", gpio46),
+	PINCTRL_PIN_GROUP("pcie_reset0", pcie_reset0),
+	PINCTRL_PIN_GROUP("pcie_reset1", pcie_reset1),
+	PINCTRL_PIN_GROUP("pcie_reset2", pcie_reset2),
+};
+
+static const struct airoha_pinctrl_func pinctrl_funcs[] = {
+	PINCTRL_FUNC_DESC("pon", pon),
+	PINCTRL_FUNC_DESC("tod_1pps", tod_1pps),
+	PINCTRL_FUNC_DESC("sipo", sipo),
+	PINCTRL_FUNC_DESC("mdio", mdio),
+	PINCTRL_FUNC_DESC("uart", uart),
+	PINCTRL_FUNC_DESC("i2c", i2c),
+	PINCTRL_FUNC_DESC("jtag", jtag),
+	PINCTRL_FUNC_DESC("pcm", pcm),
+	PINCTRL_FUNC_DESC("spi", spi),
+	PINCTRL_FUNC_DESC("pcm_spi", pcm_spi),
+	PINCTRL_FUNC_DESC("i2s", i2s),
+	PINCTRL_FUNC_DESC("emmc", emmc),
+	PINCTRL_FUNC_DESC("pnand", pnand),
+	PINCTRL_FUNC_DESC("pcie_reset", pcie_reset),
+	PINCTRL_FUNC_DESC("pwm", pwm),
+	PINCTRL_FUNC_DESC("phy1_led0", phy1_led0),
+	PINCTRL_FUNC_DESC("phy2_led0", phy2_led0),
+	PINCTRL_FUNC_DESC("phy3_led0", phy3_led0),
+	PINCTRL_FUNC_DESC("phy4_led0", phy4_led0),
+	PINCTRL_FUNC_DESC("phy1_led1", phy1_led1),
+	PINCTRL_FUNC_DESC("phy2_led1", phy2_led1),
+	PINCTRL_FUNC_DESC("phy3_led1", phy3_led1),
+	PINCTRL_FUNC_DESC("phy4_led1", phy4_led1),
+};
+
+static const struct airoha_pinctrl_conf pinctrl_pullup_conf[] = {
+	PINCTRL_CONF_DESC(0, REG_I2C_SDA_PU, UART1_TXD_PU_MASK),
+	PINCTRL_CONF_DESC(1, REG_I2C_SDA_PU, UART1_RXD_PU_MASK),
+	PINCTRL_CONF_DESC(2, REG_I2C_SDA_PU, I2C_SDA_PU_MASK),
+	PINCTRL_CONF_DESC(3, REG_I2C_SDA_PU, I2C_SCL_PU_MASK),
+	PINCTRL_CONF_DESC(4, REG_I2C_SDA_PU, SPI_CS0_PU_MASK),
+	PINCTRL_CONF_DESC(5, REG_I2C_SDA_PU, SPI_CLK_PU_MASK),
+	PINCTRL_CONF_DESC(6, REG_I2C_SDA_PU, SPI_MOSI_PU_MASK),
+	PINCTRL_CONF_DESC(7, REG_I2C_SDA_PU, SPI_MISO_PU_MASK),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_PU, BIT(0)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_PU, BIT(1)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_PU, BIT(2)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_PU, BIT(3)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_PU, BIT(4)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_PU, BIT(5)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_PU, BIT(6)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_PU, BIT(7)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_PU, BIT(8)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_PU, BIT(9)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_PU, BIT(10)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_PU, BIT(11)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_PU, BIT(12)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_PU, BIT(13)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_PU, BIT(14)),
+	PINCTRL_CONF_DESC(28, REG_GPIO_L_PU, BIT(15)),
+	PINCTRL_CONF_DESC(29, REG_GPIO_L_PU, BIT(16)),
+	PINCTRL_CONF_DESC(30, REG_GPIO_L_PU, BIT(17)),
+	PINCTRL_CONF_DESC(31, REG_GPIO_L_PU, BIT(18)),
+	PINCTRL_CONF_DESC(32, REG_GPIO_L_PU, BIT(19)),
+	PINCTRL_CONF_DESC(33, REG_GPIO_L_PU, BIT(20)),
+	PINCTRL_CONF_DESC(34, REG_GPIO_L_PU, BIT(21)),
+	PINCTRL_CONF_DESC(35, REG_GPIO_L_PU, BIT(22)),
+	PINCTRL_CONF_DESC(36, REG_GPIO_L_PU, BIT(23)),
+	PINCTRL_CONF_DESC(37, REG_GPIO_L_PU, BIT(24)),
+	PINCTRL_CONF_DESC(38, REG_GPIO_L_PU, BIT(25)),
+	PINCTRL_CONF_DESC(39, REG_GPIO_L_PU, BIT(26)),
+	PINCTRL_CONF_DESC(40, REG_GPIO_L_PU, BIT(27)),
+	PINCTRL_CONF_DESC(41, REG_GPIO_L_PU, BIT(28)),
+	PINCTRL_CONF_DESC(42, REG_GPIO_L_PU, BIT(29)),
+	PINCTRL_CONF_DESC(43, REG_GPIO_L_PU, BIT(30)),
+	PINCTRL_CONF_DESC(44, REG_GPIO_L_PU, BIT(31)),
+	PINCTRL_CONF_DESC(45, REG_GPIO_H_PU, BIT(0)),
+	PINCTRL_CONF_DESC(46, REG_GPIO_H_PU, BIT(1)),
+	PINCTRL_CONF_DESC(47, REG_GPIO_H_PU, BIT(2)),
+	PINCTRL_CONF_DESC(48, REG_GPIO_H_PU, BIT(3)),
+	PINCTRL_CONF_DESC(49, REG_GPIO_H_PU, BIT(4)),
+	PINCTRL_CONF_DESC(50, REG_GPIO_H_PU, BIT(5)),
+	PINCTRL_CONF_DESC(51, REG_GPIO_H_PU, BIT(6)),
+	PINCTRL_CONF_DESC(52, REG_GPIO_H_PU, BIT(7)),
+	PINCTRL_CONF_DESC(53, REG_GPIO_H_PU, BIT(8)),
+	PINCTRL_CONF_DESC(54, REG_GPIO_H_PU, BIT(9)),
+	PINCTRL_CONF_DESC(55, REG_GPIO_H_PU, BIT(10)),
+	PINCTRL_CONF_DESC(56, REG_GPIO_H_PU, BIT(11)),
+	PINCTRL_CONF_DESC(57, REG_GPIO_H_PU, BIT(12)),
+	PINCTRL_CONF_DESC(58, REG_GPIO_H_PU, BIT(13)),
+	PINCTRL_CONF_DESC(59, REG_GPIO_H_PU, BIT(14)),
+	PINCTRL_CONF_DESC(61, REG_I2C_SDA_PU, PCIE0_RESET_PU_MASK),
+	PINCTRL_CONF_DESC(62, REG_I2C_SDA_PU, PCIE1_RESET_PU_MASK),
+	PINCTRL_CONF_DESC(63, REG_I2C_SDA_PU, PCIE2_RESET_PU_MASK),
+};
+
+static const struct airoha_pinctrl_conf pinctrl_pulldown_conf[] = {
+	PINCTRL_CONF_DESC(0, REG_I2C_SDA_PD, UART1_TXD_PD_MASK),
+	PINCTRL_CONF_DESC(1, REG_I2C_SDA_PD, UART1_RXD_PD_MASK),
+	PINCTRL_CONF_DESC(2, REG_I2C_SDA_PD, I2C_SDA_PD_MASK),
+	PINCTRL_CONF_DESC(3, REG_I2C_SDA_PD, I2C_SCL_PD_MASK),
+	PINCTRL_CONF_DESC(4, REG_I2C_SDA_PD, SPI_CS0_PD_MASK),
+	PINCTRL_CONF_DESC(5, REG_I2C_SDA_PD, SPI_CLK_PD_MASK),
+	PINCTRL_CONF_DESC(6, REG_I2C_SDA_PD, SPI_MOSI_PD_MASK),
+	PINCTRL_CONF_DESC(7, REG_I2C_SDA_PD, SPI_MISO_PD_MASK),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_PD, BIT(0)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_PD, BIT(1)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_PD, BIT(2)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_PD, BIT(3)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_PD, BIT(4)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_PD, BIT(5)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_PD, BIT(6)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_PD, BIT(7)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_PD, BIT(8)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_PD, BIT(9)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_PD, BIT(10)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_PD, BIT(11)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_PD, BIT(12)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_PD, BIT(13)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_PD, BIT(14)),
+	PINCTRL_CONF_DESC(28, REG_GPIO_L_PD, BIT(15)),
+	PINCTRL_CONF_DESC(29, REG_GPIO_L_PD, BIT(16)),
+	PINCTRL_CONF_DESC(30, REG_GPIO_L_PD, BIT(17)),
+	PINCTRL_CONF_DESC(31, REG_GPIO_L_PD, BIT(18)),
+	PINCTRL_CONF_DESC(32, REG_GPIO_L_PD, BIT(19)),
+	PINCTRL_CONF_DESC(33, REG_GPIO_L_PD, BIT(20)),
+	PINCTRL_CONF_DESC(34, REG_GPIO_L_PD, BIT(21)),
+	PINCTRL_CONF_DESC(35, REG_GPIO_L_PD, BIT(22)),
+	PINCTRL_CONF_DESC(36, REG_GPIO_L_PD, BIT(23)),
+	PINCTRL_CONF_DESC(37, REG_GPIO_L_PD, BIT(24)),
+	PINCTRL_CONF_DESC(38, REG_GPIO_L_PD, BIT(25)),
+	PINCTRL_CONF_DESC(39, REG_GPIO_L_PD, BIT(26)),
+	PINCTRL_CONF_DESC(40, REG_GPIO_L_PD, BIT(27)),
+	PINCTRL_CONF_DESC(41, REG_GPIO_L_PD, BIT(28)),
+	PINCTRL_CONF_DESC(42, REG_GPIO_L_PD, BIT(29)),
+	PINCTRL_CONF_DESC(43, REG_GPIO_L_PD, BIT(30)),
+	PINCTRL_CONF_DESC(44, REG_GPIO_L_PD, BIT(31)),
+	PINCTRL_CONF_DESC(45, REG_GPIO_H_PD, BIT(0)),
+	PINCTRL_CONF_DESC(46, REG_GPIO_H_PD, BIT(1)),
+	PINCTRL_CONF_DESC(47, REG_GPIO_H_PD, BIT(2)),
+	PINCTRL_CONF_DESC(48, REG_GPIO_H_PD, BIT(3)),
+	PINCTRL_CONF_DESC(49, REG_GPIO_H_PD, BIT(4)),
+	PINCTRL_CONF_DESC(50, REG_GPIO_H_PD, BIT(5)),
+	PINCTRL_CONF_DESC(51, REG_GPIO_H_PD, BIT(6)),
+	PINCTRL_CONF_DESC(52, REG_GPIO_H_PD, BIT(7)),
+	PINCTRL_CONF_DESC(53, REG_GPIO_H_PD, BIT(8)),
+	PINCTRL_CONF_DESC(54, REG_GPIO_H_PD, BIT(9)),
+	PINCTRL_CONF_DESC(55, REG_GPIO_H_PD, BIT(10)),
+	PINCTRL_CONF_DESC(56, REG_GPIO_H_PD, BIT(11)),
+	PINCTRL_CONF_DESC(57, REG_GPIO_H_PD, BIT(12)),
+	PINCTRL_CONF_DESC(58, REG_GPIO_H_PD, BIT(13)),
+	PINCTRL_CONF_DESC(59, REG_GPIO_H_PD, BIT(14)),
+	PINCTRL_CONF_DESC(61, REG_I2C_SDA_PD, PCIE0_RESET_PD_MASK),
+	PINCTRL_CONF_DESC(62, REG_I2C_SDA_PD, PCIE1_RESET_PD_MASK),
+	PINCTRL_CONF_DESC(63, REG_I2C_SDA_PD, PCIE2_RESET_PD_MASK),
+};
+
+static const struct airoha_pinctrl_match_data pinctrl_match_data = {
+	.gpio_offs = 13,
+	.gpio_pin_cnt = 47,
+	.pins = pinctrl_pins,
+	.num_pins = ARRAY_SIZE(pinctrl_pins),
+	.grps = pinctrl_groups,
+	.num_grps = ARRAY_SIZE(pinctrl_groups),
+	.funcs = pinctrl_funcs,
+	.num_funcs = ARRAY_SIZE(pinctrl_funcs),
+	.confs_info = {
+		[AIROHA_PINCTRL_CONFS_PULLUP] = {
+			.confs = pinctrl_pullup_conf,
+			.num_confs = ARRAY_SIZE(pinctrl_pullup_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_PULLDOWN] = {
+			.confs = pinctrl_pulldown_conf,
+			.num_confs = ARRAY_SIZE(pinctrl_pulldown_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_DRIVE_E2] = {
+			.confs = pinctrl_drive_e2_conf,
+			.num_confs = ARRAY_SIZE(pinctrl_drive_e2_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_DRIVE_E4] = {
+			.confs = pinctrl_drive_e4_conf,
+			.num_confs = ARRAY_SIZE(pinctrl_drive_e4_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_PCIE_RST_OD] = {
+			.confs = pinctrl_pcie_rst_od_conf,
+			.num_confs = ARRAY_SIZE(pinctrl_pcie_rst_od_conf),
+		},
+	},
+};
+
+static const struct udevice_id pinctrl_of_match[] = {
+	{ .compatible = "airoha,en7581-pinctrl", 
+	  .data = (uintptr_t)&pinctrl_match_data },
+	{ .compatible = "airoha,an7581-pinctrl",
+	  .data = (uintptr_t)&pinctrl_match_data },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(airoha_an7581_pinctrl) = {
+	.name = "airoha-an7581-pinctrl",
+	.id = UCLASS_PINCTRL,
+	.of_match = of_match_ptr(pinctrl_of_match),
+	.probe = airoha_pinctrl_probe,
+	.bind = airoha_pinctrl_bind,
+	.priv_auto = sizeof(struct airoha_pinctrl),
+	.ops = &airoha_pinctrl_ops,
+};
-- 
2.53.0

