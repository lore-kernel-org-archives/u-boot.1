Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6944FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 15:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 463D484674;
	Tue, 28 Apr 2026 17:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="f5kZ13kK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 654EF8426E; Tue, 28 Apr 2026 17:35:11 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E84EE8460B
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 17:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BspLdQtRFavzWoccCupQetNEHO8ouqYDtovoxG1SHq3c8kbIQV7iaFjSxWDLgqLcGx6yPjrrberHHU8ofDc7AzMsHikbCeoYk/po47wjWYChO5kvkZov2GEFrjtf5UtVv36Gke1QwyOvNa07xViXdc1lZ6HWrmOUZIZSB0wLQYYGAWZBLXtw9HTkVbAi7w9Efd9qso/poE+6lkc8h93nn/xhYOYJEdqjOLg6F1KsMpdZFFxkY2uUeyNgpsyHuGBcv1Xfn2bVnPq/WsO4SwY8yt/gshr9ZAwLzr8v9KwEkIgKBDZOZCsQFiPkClZQ3RYj4oItuWEdUXt9pK/5biydHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6ClsU948XfNbHpli0ON6TXb5irGYLoPfqSKU1ACCvo=;
 b=O6Myyh9ya0NB900gCAF8+3kJWa+YwKrPhvqatcPJHLVRFveTABKq6hZ7DBQp/jHNZD43lksxnnAEUNk4FLZmxQbInxYbuWegWV4Fa1zaRlWllvrVFUOwnu8Ga8AOeRKGm+TYNld6xiicqg+8XOHR5o9zRud7o7AzvKKqUrm3q0+UG4lAl9/VVwir13Pud6LlcyCryULmGj9/IyVbrJtEvSESMquQxE3okLbsmR1aoy2jw/5ZZS1KHUqCUpKjT8/1uNlJqPMXhDevEdv7c21oxTiGcqNLamtpaurx7XCB3rrrlYyvewCB4paf9+EoIswkGK51qgY3PlqPxdzgQBN5gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6ClsU948XfNbHpli0ON6TXb5irGYLoPfqSKU1ACCvo=;
 b=f5kZ13kKGoz0EIiHa/e6c8C4faMuuj0TeYcv4EIRmuhba99579ajoVbMiajnNiLTcRlHC4uJ7fDZcrbLeCCRsdnIL/odtayYHWcMus95GKmDPNn++YUjQs2zjbueoDBBEL1dCMxWe7t8Vvahq2tqut40Qqjl0dVAKeAWZVNqex/zwpoVKoXsdp6GCV4pULnj7gTmdDkmyHyRMttStMK+cK8NqsT6kSBD3DkOfHpPkSEGntr3FYK4T9q7VGSYBh/42VmHql1Ao4Sy3/BmZCGuSo/j3+FHkwxHtsr6kF7nEwc3Bgw2eIlxAqQT3iKbSE+UqVHD92aIAHHV06IY2mo6Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8715.eurprd08.prod.outlook.com (2603:10a6:150:85::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 15:35:02 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 15:35:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Anis Chali <chalianis1@gmail.com>,
 u-boot@lists.denx.de, Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 David Lechner <dlechner@baylibre.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 4/6] pinctrl: airoha: add pin controller and gpio driver
 for EN7523 SoC
Date: Tue, 28 Apr 2026 18:34:46 +0300
Message-ID: <20260428153448.980150-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428153448.980150-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260428153448.980150-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::17) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: e545a3d3-a1ec-4981-6714-08dea53bb69e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: wzzlO8WbbIr12ZwNH6ntxEiccu5H7rfvqEaxWfQxENV2dSfeEzG+j3jL49lpIh5FRlzFyOCnUzoYU7YarHr6W7CP8b7dT0wYoBd7yjGLXLkIobTanOqGITZOtUoh52V3SRfvKtZnr6lx9DhMB2qUkd1XrHuJTwuRDayeLJcg94d3OyfiXixLzi1/530wO5ppffaxl10EsI18PGv4sWNl+tr3veZ3lEpSnVptO2MqCjpN5a5ab2fTU2QJfXM0d/+ygg70bn7+EWyKV9J6DQ8B9/0tBDA3/qX6R+0Qha/jFKuBrk8ZGEHIiHCVuSxGw3XGRbeQrZFCItlszs3qj960igF1xY6VD/gcnye3PeGVBdKxU81EM3fEjwWLB+LBBxYpJ5muz06FsGOnHJKUAmXqu/mu1zf24XW8DIzWVEFcFgNGU7qgWyw8mTuj/I29vBNGDbOdRPtCb1Mhj4eA5Y6MXygEpLsi59xcM08e7HzaRsFC1TDCq30/4hZsKu9WBBfoLekwLPPBcV8GTV48IWWjmDmHAh9kV/s9ol/V7jOF/2Dc1ukQn13iail/kr+dyypYo+gQObuIra87G4RLHIloqlF+71BLOXruN2PvH2neP4ldPJ1t1g42FaJYQMPadR5SMHX6YIbeY1pipw0RGBFBelJLUVzc0qG03iT01a6+q9zIoiNlckXKge1/Wz1RlgMehkxTjkPjF/TjDMcINPwWqX+syn5lC37NFdybXwWgJm7fC77Z5eXTN4/wk+TzD+74
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KbVdvvof31cuKCSuhJ3Ut9kMF3cYg4KoG17Adim3lNoNCMZ6ShCy12tSEXnb?=
 =?us-ascii?Q?5aaFx3fOFy7LYLHt5NqzJvaDvu9fEUrmvJDY5adVGNDf2rqzooUFOtrk8YaQ?=
 =?us-ascii?Q?O7EDvSN9pqYdY98zCPujCwt1vp4KRG/17duQ+fZ1Whyl24h8s9Ab+r19ynTs?=
 =?us-ascii?Q?PKUG5jm3XSMFpjRX/2Nlr1bZoBMKDb63zhhnK5kTPijTNYAdeXt8UzWgc0cR?=
 =?us-ascii?Q?1WMCENPlbJhpmBbcNTxQw2nJGUQoI5YI6HAxafRml+lpEc0LHF8f/oYVBtDH?=
 =?us-ascii?Q?e3Gv3hLQg/XF4ALiyAJvKu5l86OYjN1B+hFStYfe+Wkd2p7g0fUVdjrsnfWe?=
 =?us-ascii?Q?sA/MU/ksmJ6shTmxtMYSkRqTrspKM/e6s1k72/ub7f4TJBcXbgMOCrOfGkSb?=
 =?us-ascii?Q?cWZZndIuwBG62sitrgM87a2Xm2bYnkMtx9D/praBSjmxUUkymiRuWoMqq3hj?=
 =?us-ascii?Q?DvZyqGhc6ewZnbbx3uVCpf8huhUtTWFecY5Pg52BxI+x1d1Uw3ong8yKsmvs?=
 =?us-ascii?Q?KjQcNBZpQMH6vFmE3T33VHOOUCef3tGIsHPOK2dDHKJQVvmphgN3H0UA0B1h?=
 =?us-ascii?Q?qM5V32P55uTsHm0v9n/vMMyvhv+/NHVg2sM3xz29CVOumBtBTS/eAPYJHe9A?=
 =?us-ascii?Q?j/DI3dvwMXDUwRLMXSXjjufECrrLzJOzUbd1izikyBxkJDiacmbh+5oIeUTG?=
 =?us-ascii?Q?kvlSRSOiGCMP+JEEKaShcTbZRlkoJW3TIl5G3hVFGoVmjJ0H8cf7xFv/CP0u?=
 =?us-ascii?Q?YP61IZpZAco7GjShpcc/OrfaJ1CHKKu/GpmqFOzjHwtpZFTdSYQOZKNUsaIv?=
 =?us-ascii?Q?AGQFIu/6FIbJuMMfvq+KVhp4ChUD2XjnHGky/TcMJdtkFC9LtcxVjXqFDtjm?=
 =?us-ascii?Q?iwiaQPSfOAmo78rH0TaW6JtneSuFZRDTKDyPtwbr6Ay+jeSiKC9VmTvh69WL?=
 =?us-ascii?Q?itmJOSIi7O9ieEums2dKxM8EYvRVWGkoBHMqcjG1Rekyoj4AB8/ms6qCN3Hc?=
 =?us-ascii?Q?kcYi8p1qzBf9C6HMQdaFcHdjE7a/+qIXKwBynOO6v+lyJnuOPJbYWgIj4wid?=
 =?us-ascii?Q?zKzIQNOHzASKVCw0b9gnV6kmBvZ4h9HsLDF12KwYeUwSbMBp2YT1PxAITt/2?=
 =?us-ascii?Q?x42wWVoqFH3o7rZ0kt0f7BMtfpVvk/4kDI2cwSMuBBW/TdzkuumQFUErQWqp?=
 =?us-ascii?Q?JXN+8QP6kFYe0cEUxhgBNCL+sIoPAUGIthQr+cu2CkBFDUsuqNCr+cTZSkAF?=
 =?us-ascii?Q?0iNM3QWSW0XJ0wlcayonF2WlKW3Iz/R9H+4kCK2DRXMQJOEzhQM43MluUYHo?=
 =?us-ascii?Q?yJLDQzfn4gBXeIWTriStFXEXQvGAWPdmT/XoMZ3Y93nLI138BbJXBKtLYN4n?=
 =?us-ascii?Q?o3GStWt6li/rzISmbeSkVhc2/aOaIHe2MIDQiusvNdjX0WiCp/tnzpymSr4/?=
 =?us-ascii?Q?xH/DyCu7kriawkpvftESsAH5R9a4JbvudLGmrkd7rre9trriiy9LxHROMiFq?=
 =?us-ascii?Q?2KOQAsKplVNqVh6rRYAfRzuIuWIvJq481HNI2m6LJA61Sdwv8GAxucz15o6x?=
 =?us-ascii?Q?hMdZj+3l7ja1S1y5IoWrk0UHgdNmhzWQaLV/VH+dIiVlilthWJyvTlmBgS52?=
 =?us-ascii?Q?JBuvmjGD39LZibodTo2p8DJGp+LNfIGFxc9X8w2NnSiVQWWSqqHVDVvHdUTd?=
 =?us-ascii?Q?NUJ6N2Y5TxtMHtzdzj23UG0FEw/ZB7Cyo6EkoB5hUVgMg6JpZyDzPC3p0i3u?=
 =?us-ascii?Q?GnXsFYrjIQFOaNo9r+RK5A0hqxMdpU4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e545a3d3-a1ec-4981-6714-08dea53bb69e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 15:35:02.1165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXcdQ4MwFv4kZ7j5PkzO2MVeaVVXNcyf/v8irYBA+Y07p0st337cj8/C9crLaGxIiEbCgslkLlSSNmzZCkexLdKA9sgwN5PTOHDK+ALnjpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8715
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

The driver based on official linux airoha pinctrl and gpio driver with
Matheus Sampaio Queiroga <srherobrine20@gmail.com> changes.
The changes:
 * Separate code for each SoC and keep some of the functions in
   common between them,
 * Add pinctrl driver for EN7523 SoC.

The original Matheus Sampaio Queiroga driver can be taken from the repo:
  https://sirherobrine23.com.br/airoha_an7523/kernel/commits/branch/airoha_an7523_pinctrl

This patch adds U-Boot pin controller and gpio driver for Airoha EN7523 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/pinctrl/airoha/Kconfig          |   5 +
 drivers/pinctrl/airoha/Makefile         |   1 +
 drivers/pinctrl/airoha/pinctrl-en7523.c | 627 ++++++++++++++++++++++++
 3 files changed, 633 insertions(+)
 create mode 100644 drivers/pinctrl/airoha/pinctrl-en7523.c

diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
index d9df89b20b7..cb4a7ab0b0a 100644
--- a/drivers/pinctrl/airoha/Kconfig
+++ b/drivers/pinctrl/airoha/Kconfig
@@ -10,6 +10,11 @@ config PINCTRL_AIROHA
 	select SYSCON
 	bool
 
+config PINCTRL_AIROHA_EN7523
+	bool "Airoha EN7523 pin controller and gpio driver"
+	depends on TARGET_EN7523
+	select PINCTRL_AIROHA
+
 config PINCTRL_AIROHA_AN7581
 	tristate "AN7581 pin controller and gpio driver"
 	depends on TARGET_AN7581
diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha/Makefile
index c8c99dd22f8..b90bd180591 100644
--- a/drivers/pinctrl/airoha/Makefile
+++ b/drivers/pinctrl/airoha/Makefile
@@ -2,5 +2,6 @@
 
 obj-$(CONFIG_PINCTRL_AIROHA)		+= pinctrl-airoha.o
 
+obj-$(CONFIG_PINCTRL_AIROHA_EN7523)	+= pinctrl-en7523.o
 obj-$(CONFIG_PINCTRL_AIROHA_AN7581)	+= pinctrl-an7581.o
 obj-$(CONFIG_PINCTRL_AIROHA_AN7583)	+= pinctrl-an7583.o
diff --git a/drivers/pinctrl/airoha/pinctrl-en7523.c b/drivers/pinctrl/airoha/pinctrl-en7523.c
new file mode 100644
index 00000000000..50075a51be6
--- /dev/null
+++ b/drivers/pinctrl/airoha/pinctrl-en7523.c
@@ -0,0 +1,627 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
+ * Author: Markus Gothe <markus.gothe@genexis.eu>
+ * Author: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
+ */
+#include "airoha-common.h"
+
+static const int en7523_uart2_pins[] = { 8, 9 };
+static const int en7523_smi_mdio_pins[] = { 8, 9 };
+static const int en7523_i2c_slave_pins[] = { 2, 3 };
+static const int en7523_jtag_pins[] = { 22, 23, 24, 25, 26 };
+static const int en7523_sipo_pins[] = { 1, 18, 26 };
+static const int en7523_pcm1_pins[] = { 12, 13, 14, 15 };
+static const int en7523_pcm2_pins[] = { 4, 5, 6, 7 };
+static const int en7523_pcm_rst_pins[] = { 2 };
+static const int en7523_pcm_int_pins[] = { 3 };
+static const int en7523_slic_spi_cs1_pins[] = { 10 };
+static const int en7523_slic_spi_cs2_pins[] = { 27 };
+static const int en7523_slic_spi_cs3_pins[] = { 8 };
+static const int en7523_slic_spi_cs4_pins[] = { 11 };
+static const int en7523_pcie_reset0_pins[] = { 28 };
+static const int en7523_pcie_reset1_pins[] = { 29 };
+static const int en7523_gpio0_pins[] = { 0 };
+static const int en7523_gpio1_pins[] = { 1 };
+static const int en7523_gpio2_pins[] = { 2 };
+static const int en7523_gpio3_pins[] = { 3 };
+static const int en7523_gpio4_pins[] = { 4 };
+static const int en7523_gpio5_pins[] = { 5 };
+static const int en7523_gpio6_pins[] = { 6 };
+static const int en7523_gpio7_pins[] = { 7 };
+static const int en7523_gpio8_pins[] = { 8 };
+static const int en7523_gpio9_pins[] = { 9 };
+static const int en7523_gpio10_pins[] = { 10 };
+static const int en7523_gpio11_pins[] = { 11 };
+static const int en7523_gpio12_pins[] = { 12 };
+static const int en7523_gpio13_pins[] = { 13 };
+static const int en7523_gpio14_pins[] = { 14 };
+static const int en7523_gpio15_pins[] = { 15 };
+static const int en7523_gpio16_pins[] = { 16 };
+static const int en7523_gpio17_pins[] = { 17 };
+static const int en7523_gpio18_pins[] = { 18 };
+static const int en7523_gpio19_pins[] = { 19 };
+static const int en7523_gpio20_pins[] = { 20 };
+static const int en7523_gpio21_pins[] = { 21 };
+static const int en7523_gpio22_pins[] = { 22 };
+static const int en7523_gpio23_pins[] = { 23 };
+static const int en7523_gpio24_pins[] = { 24 };
+static const int en7523_gpio25_pins[] = { 25 };
+static const int en7523_gpio26_pins[] = { 26 };
+static const int en7523_gpio27_pins[] = { 27 };
+static const int en7523_gpio28_pins[] = { 28 };
+static const int en7523_gpio29_pins[] = { 29 };
+
+static struct pinctrl_pin_desc en7523_pinctrl_pins[] = {
+	PINCTRL_PIN(0, "gpio0"),
+	PINCTRL_PIN(1, "gpio1"),
+	PINCTRL_PIN(2, "gpio2"),
+	PINCTRL_PIN(3, "gpio3"),
+	PINCTRL_PIN(4, "gpio4"),
+	PINCTRL_PIN(5, "gpio5"),
+	PINCTRL_PIN(6, "gpio6"),
+	PINCTRL_PIN(7, "gpio7"),
+	PINCTRL_PIN(8, "gpio8"),
+	PINCTRL_PIN(9, "gpio9"),
+	PINCTRL_PIN(10, "gpio10"),
+	PINCTRL_PIN(11, "gpio11"),
+	PINCTRL_PIN(12, "zsync"),
+	PINCTRL_PIN(13, "zclk"),
+	PINCTRL_PIN(14, "zmosi"),
+	PINCTRL_PIN(15, "zmiso"),
+	PINCTRL_PIN(16, "gpio16"),
+	PINCTRL_PIN(17, "gpio17"),
+	PINCTRL_PIN(18, "gpio18"),
+	PINCTRL_PIN(19, "gpio19"),
+	PINCTRL_PIN(20, "gpio20"),
+	PINCTRL_PIN(21, "gpio21"),
+	PINCTRL_PIN(22, "gpio22"),
+	PINCTRL_PIN(23, "gpio23"),
+	PINCTRL_PIN(24, "gpio24"),
+	PINCTRL_PIN(25, "gpio25"),
+	PINCTRL_PIN(26, "gpio26"),
+	PINCTRL_PIN(27, "gpio27"),
+	PINCTRL_PIN(28, "pcie_reset0"),
+	PINCTRL_PIN(29, "pcie_reset1"),
+	PINCTRL_PIN(30, "gpio30"),
+	PINCTRL_PIN(31, "gpio31"),
+	PINCTRL_PIN(32, "gpio32"),
+	PINCTRL_PIN(33, "gpio33"),
+	PINCTRL_PIN(34, "gpio34"),
+	PINCTRL_PIN(35, "gpio35"),
+	PINCTRL_PIN(36, "gpio36"),
+	PINCTRL_PIN(37, "gpio37"),
+	PINCTRL_PIN(38, "gpio38"),
+	PINCTRL_PIN(39, "gpio39"),
+	PINCTRL_PIN(40, "gpio40"),
+	PINCTRL_PIN(41, "gpio41"),
+	PINCTRL_PIN(42, "gpio42"),
+	PINCTRL_PIN(43, "gpio43"),
+	PINCTRL_PIN(44, "gpio44"),
+	PINCTRL_PIN(45, "gpio45"),
+	PINCTRL_PIN(46, "gpio46"),
+	PINCTRL_PIN(47, "gpio47"),
+	PINCTRL_PIN(48, "gpio48"),
+	PINCTRL_PIN(49, "gpio49"),
+	PINCTRL_PIN(50, "gpio50"),
+	PINCTRL_PIN(51, "gpio51"),
+	PINCTRL_PIN(52, "gpio52"),
+	PINCTRL_PIN(53, "gpio53"),
+	PINCTRL_PIN(54, "gpio54"),
+	PINCTRL_PIN(55, "gpio55"),
+	PINCTRL_PIN(56, "gpio56"),
+	PINCTRL_PIN(57, "gpio57"),
+};
+
+static const char *const en7523_uart2_groups[] = { "uart2" };
+static const char *const en7523_smi_mdio_groups[] = { "mdio" };
+static const char *const en7523_i2c_slave_groups[] = { "i2c_slave" };
+static const char *const en7523_jtag_groups[] = { "jtag" };
+static const char *const en7523_pcie_reset_groups[] = { "pcie_reset0", "pcie_reset1" };
+static const char *const en7523_sipo_groups[] = { "sipo" };
+static const char *const en7523_pcm_groups[] = { "pcm1", "pcm2", "pcm_rst", "pcm_int" };
+static const char *const en7523_slic_spi_groups[] = { "slic_spi_cs1", "slic_spi_cs2",
+						      "slic_spi_cs3", "slic_spi_cs4" };
+static const char *const en7523_pwm_groups[] = {
+	"gpio0",  "gpio1",  "gpio2",  "gpio3",	"gpio4",  "gpio5",  "gpio6",
+	"gpio7",  "gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13",
+	"gpio14", "gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20",
+	"gpio21", "gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27",
+	"gpio28", "gpio29",
+};
+static const char *const en7523_phy1_led0_groups[] = { "gpio22", "gpio23", "gpio24", "gpio25" };
+static const char *const en7523_phy2_led0_groups[] = { "gpio22", "gpio23", "gpio24", "gpio25" };
+static const char *const en7523_phy3_led0_groups[] = { "gpio22", "gpio23", "gpio24", "gpio25" };
+static const char *const en7523_phy4_led0_groups[] = { "gpio22", "gpio23", "gpio24", "gpio25" };
+static const char *const en7523_phy1_led1_groups[] = { "gpio7", "gpio6", "gpio5", "gpio4" };
+static const char *const en7523_phy2_led1_groups[] = { "gpio7", "gpio6", "gpio5", "gpio4" };
+static const char *const en7523_phy3_led1_groups[] = { "gpio7", "gpio6", "gpio5", "gpio4" };
+static const char *const en7523_phy4_led1_groups[] = { "gpio7", "gpio6", "gpio5", "gpio4" };
+
+static const struct airoha_pinctrl_func_group en7523_uart2_func_group[] = {
+	{
+		.name = "uart2",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_PON_MODE,
+			       GPIO_UART2_MODE_MASK, GPIO_UART2_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group en7523_smi_mdio_func_group[] = {
+	{
+		.name = "mdio",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_2ND_I2C_MODE,
+			       GPIO_MDC_IO_MASTER_MODE_MODE,
+			       GPIO_MDC_IO_MASTER_MODE_MODE },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group en7523_i2c_slave_func_group[] = {
+	{
+		.name = "i2c_slave",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_2ND_I2C_MODE,
+			       GPIO_I2C_SLAVE_MODE_MODE,
+			       GPIO_I2C_SLAVE_MODE_MODE },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group en7523_jtag_func_group[] = {
+	{
+		.name = "jtag",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_NPU_UART_EN,
+			       JTAG_UDI_EN_MASK, JTAG_UDI_EN_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group en7523_pcie_reset_func_group[] = {
+	{
+		.name = "pcie_reset0",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_PON_MODE,
+			       GPIO_PCIE_RESET0_MASK, GPIO_PCIE_RESET0_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcie_reset1",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_PON_MODE,
+			       GPIO_PCIE_RESET1_MASK, GPIO_PCIE_RESET1_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group en7523_sipo_func_group[] = {
+	{
+		.name = "sipo",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_PON_MODE,
+			       GPIO_SIPO_MODE_MASK, GPIO_SIPO_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group en7523_pcm_func_group[] = {
+	{
+		.name = "pcm1",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM1_MODE_MASK, GPIO_PCM1_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm2",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM2_MODE_MASK, GPIO_PCM2_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_rst",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_RESET_MODE_MASK, GPIO_PCM_RESET_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_int",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_INT_MODE_MASK, GPIO_PCM_INT_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group en7523_slic_spi_func_group[] = {
+	{
+		.name = "slic_spi_cs1",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS1_MODE_MASK, GPIO_PCM_SPI_CS1_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "slic_spi_cs2",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS2_MODE_P128_MASK,
+			       GPIO_PCM_SPI_CS2_MODE_P128_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "slic_spi_cs3",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS3_MODE_MASK, GPIO_PCM_SPI_CS3_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "slic_spi_cs4",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS4_MODE_MASK, GPIO_PCM_SPI_CS4_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group en7523_pwm_func_group[] = {
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
+};
+
+static const struct airoha_pinctrl_func_group en7523_phy1_led0_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio22", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio23", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio24", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio25", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(0)),
+};
+
+static const struct airoha_pinctrl_func_group en7523_phy2_led0_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio22", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio23", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio24", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio25", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(1)),
+};
+
+static const struct airoha_pinctrl_func_group en7523_phy3_led0_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio22", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio23", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio24", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio25", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(2)),
+};
+
+static const struct airoha_pinctrl_func_group en7523_phy4_led0_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio22", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio23", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio24", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio25", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(3)),
+};
+
+static const struct airoha_pinctrl_func_group en7523_phy1_led1_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio7", GPIO_LAN0_LED1_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio6", GPIO_LAN1_LED1_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio5", GPIO_LAN2_LED1_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio4", GPIO_LAN3_LED1_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(0)),
+};
+
+static const struct airoha_pinctrl_func_group en7523_phy2_led1_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio7", GPIO_LAN0_LED1_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio6", GPIO_LAN1_LED1_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio5", GPIO_LAN2_LED1_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio4", GPIO_LAN3_LED1_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(1)),
+};
+
+static const struct airoha_pinctrl_func_group en7523_phy3_led1_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio7", GPIO_LAN0_LED1_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio6", GPIO_LAN1_LED1_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio5", GPIO_LAN2_LED1_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio4", GPIO_LAN3_LED1_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(2)),
+};
+
+static const struct airoha_pinctrl_func_group en7523_phy4_led1_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio7", GPIO_LAN0_LED1_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio6", GPIO_LAN1_LED1_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio5", GPIO_LAN2_LED1_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio4", GPIO_LAN3_LED1_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(2)),
+};
+
+static const struct pingroup en7523_pinctrl_groups[] = {
+	PINCTRL_PIN_GROUP("uart2", en7523_uart2),
+	PINCTRL_PIN_GROUP("mdio", en7523_smi_mdio),
+	PINCTRL_PIN_GROUP("i2c_slave", en7523_i2c_slave),
+	PINCTRL_PIN_GROUP("jtag", en7523_jtag),
+	PINCTRL_PIN_GROUP("sipo", en7523_sipo),
+	PINCTRL_PIN_GROUP("pcm1", en7523_pcm1),
+	PINCTRL_PIN_GROUP("pcm2", en7523_pcm2),
+	PINCTRL_PIN_GROUP("pcm_rst", en7523_pcm_rst),
+	PINCTRL_PIN_GROUP("pcm_int", en7523_pcm_int),
+	PINCTRL_PIN_GROUP("slic_spi_cs1", en7523_slic_spi_cs1),
+	PINCTRL_PIN_GROUP("slic_spi_cs2", en7523_slic_spi_cs2),
+	PINCTRL_PIN_GROUP("slic_spi_cs3", en7523_slic_spi_cs3),
+	PINCTRL_PIN_GROUP("slic_spi_cs4", en7523_slic_spi_cs4),
+	PINCTRL_PIN_GROUP("pcie_reset0", en7523_pcie_reset0),
+	PINCTRL_PIN_GROUP("pcie_reset1", en7523_pcie_reset1),
+	PINCTRL_PIN_GROUP("gpio0", en7523_gpio0),
+	PINCTRL_PIN_GROUP("gpio1", en7523_gpio1),
+	PINCTRL_PIN_GROUP("gpio2", en7523_gpio2),
+	PINCTRL_PIN_GROUP("gpio3", en7523_gpio3),
+	PINCTRL_PIN_GROUP("gpio4", en7523_gpio4),
+	PINCTRL_PIN_GROUP("gpio5", en7523_gpio5),
+	PINCTRL_PIN_GROUP("gpio6", en7523_gpio6),
+	PINCTRL_PIN_GROUP("gpio7", en7523_gpio7),
+	PINCTRL_PIN_GROUP("gpio8", en7523_gpio8),
+	PINCTRL_PIN_GROUP("gpio9", en7523_gpio9),
+	PINCTRL_PIN_GROUP("gpio10", en7523_gpio10),
+	PINCTRL_PIN_GROUP("gpio11", en7523_gpio11),
+	PINCTRL_PIN_GROUP("gpio12", en7523_gpio12),
+	PINCTRL_PIN_GROUP("gpio13", en7523_gpio13),
+	PINCTRL_PIN_GROUP("gpio14", en7523_gpio14),
+	PINCTRL_PIN_GROUP("gpio15", en7523_gpio15),
+	PINCTRL_PIN_GROUP("gpio16", en7523_gpio16),
+	PINCTRL_PIN_GROUP("gpio17", en7523_gpio17),
+	PINCTRL_PIN_GROUP("gpio18", en7523_gpio18),
+	PINCTRL_PIN_GROUP("gpio19", en7523_gpio19),
+	PINCTRL_PIN_GROUP("gpio20", en7523_gpio20),
+	PINCTRL_PIN_GROUP("gpio21", en7523_gpio21),
+	PINCTRL_PIN_GROUP("gpio22", en7523_gpio22),
+	PINCTRL_PIN_GROUP("gpio23", en7523_gpio23),
+	PINCTRL_PIN_GROUP("gpio24", en7523_gpio24),
+	PINCTRL_PIN_GROUP("gpio25", en7523_gpio25),
+	PINCTRL_PIN_GROUP("gpio26", en7523_gpio26),
+	PINCTRL_PIN_GROUP("gpio27", en7523_gpio27),
+	PINCTRL_PIN_GROUP("gpio28", en7523_gpio28),
+	PINCTRL_PIN_GROUP("gpio29", en7523_gpio29),
+};
+
+static const struct airoha_pinctrl_func en7523_pinctrl_funcs[] = {
+	PINCTRL_FUNC_DESC("uart", en7523_uart2),
+	PINCTRL_FUNC_DESC("mdio", en7523_smi_mdio),
+	PINCTRL_FUNC_DESC("i2c", en7523_i2c_slave),
+	PINCTRL_FUNC_DESC("jtag", en7523_jtag),
+	PINCTRL_FUNC_DESC("pcie_reset", en7523_pcie_reset),
+	PINCTRL_FUNC_DESC("sipo", en7523_sipo),
+	PINCTRL_FUNC_DESC("pcm", en7523_pcm),
+	PINCTRL_FUNC_DESC("slic_spi", en7523_slic_spi),
+	PINCTRL_FUNC_DESC("pwm", en7523_pwm),
+	PINCTRL_FUNC_DESC("phy1_led0", en7523_phy1_led0),
+	PINCTRL_FUNC_DESC("phy1_led1", en7523_phy1_led1),
+	PINCTRL_FUNC_DESC("phy2_led0", en7523_phy2_led0),
+	PINCTRL_FUNC_DESC("phy2_led1", en7523_phy2_led1),
+	PINCTRL_FUNC_DESC("phy3_led0", en7523_phy3_led0),
+	PINCTRL_FUNC_DESC("phy3_led1", en7523_phy3_led1),
+	PINCTRL_FUNC_DESC("phy4_led0", en7523_phy4_led0),
+	PINCTRL_FUNC_DESC("phy4_led1", en7523_phy4_led1),
+};
+
+static const struct airoha_pinctrl_conf en7523_pinctrl_pullup_conf[] = {
+	PINCTRL_CONF_DESC(0, REG_GPIO_L_PU, BIT(0)),
+	PINCTRL_CONF_DESC(1, REG_GPIO_L_PU, BIT(1)),
+	PINCTRL_CONF_DESC(2, REG_GPIO_L_PU, BIT(2)),
+	PINCTRL_CONF_DESC(3, REG_GPIO_L_PU, BIT(3)),
+	PINCTRL_CONF_DESC(4, REG_GPIO_L_PU, BIT(4)),
+	PINCTRL_CONF_DESC(5, REG_GPIO_L_PU, BIT(5)),
+	PINCTRL_CONF_DESC(6, REG_GPIO_L_PU, BIT(6)),
+	PINCTRL_CONF_DESC(7, REG_GPIO_L_PU, BIT(7)),
+	PINCTRL_CONF_DESC(8, REG_GPIO_L_PU, BIT(8)),
+	PINCTRL_CONF_DESC(9, REG_GPIO_L_PU, BIT(9)),
+	PINCTRL_CONF_DESC(10, REG_GPIO_L_PU, BIT(10)),
+	PINCTRL_CONF_DESC(11, REG_GPIO_L_PU, BIT(11)),
+	PINCTRL_CONF_DESC(12, REG_GPIO_L_PU, BIT(12)),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_PU, BIT(13)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_PU, BIT(14)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_PU, BIT(15)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_PU, BIT(16)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_PU, BIT(17)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_PU, BIT(18)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_PU, BIT(19)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_PU, BIT(20)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_PU, BIT(21)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_PU, BIT(22)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_PU, BIT(23)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_PU, BIT(24)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_PU, BIT(25)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_PU, BIT(26)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_PU, BIT(27)),
+	PINCTRL_CONF_DESC(28, REG_I2C_SDA_PU, PCIE0_RESET_PU_MASK),
+	PINCTRL_CONF_DESC(29, REG_I2C_SDA_PU, PCIE1_RESET_PU_MASK),
+};
+
+static const struct airoha_pinctrl_conf en7523_pinctrl_pulldown_conf[] = {
+	PINCTRL_CONF_DESC(0, REG_GPIO_L_PD, BIT(0)),
+	PINCTRL_CONF_DESC(1, REG_GPIO_L_PD, BIT(1)),
+	PINCTRL_CONF_DESC(2, REG_GPIO_L_PD, BIT(2)),
+	PINCTRL_CONF_DESC(3, REG_GPIO_L_PD, BIT(3)),
+	PINCTRL_CONF_DESC(4, REG_GPIO_L_PD, BIT(4)),
+	PINCTRL_CONF_DESC(5, REG_GPIO_L_PD, BIT(5)),
+	PINCTRL_CONF_DESC(6, REG_GPIO_L_PD, BIT(6)),
+	PINCTRL_CONF_DESC(7, REG_GPIO_L_PD, BIT(7)),
+	PINCTRL_CONF_DESC(8, REG_GPIO_L_PD, BIT(8)),
+	PINCTRL_CONF_DESC(9, REG_GPIO_L_PD, BIT(9)),
+	PINCTRL_CONF_DESC(10, REG_GPIO_L_PD, BIT(10)),
+	PINCTRL_CONF_DESC(11, REG_GPIO_L_PD, BIT(11)),
+	PINCTRL_CONF_DESC(12, REG_GPIO_L_PD, BIT(12)),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_PD, BIT(13)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_PD, BIT(14)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_PD, BIT(15)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_PD, BIT(16)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_PD, BIT(17)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_PD, BIT(18)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_PD, BIT(19)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_PD, BIT(20)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_PD, BIT(21)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_PD, BIT(22)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_PD, BIT(23)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_PD, BIT(24)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_PD, BIT(25)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_PD, BIT(26)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_PD, BIT(27)),
+	PINCTRL_CONF_DESC(28, REG_I2C_SDA_PD, PCIE0_RESET_PD_MASK),
+	PINCTRL_CONF_DESC(29, REG_I2C_SDA_PD, PCIE1_RESET_PD_MASK),
+};
+
+static const struct airoha_pinctrl_conf en7523_pinctrl_drive_e2_conf[] = {
+	PINCTRL_CONF_DESC(0, REG_GPIO_L_E2, BIT(0)),
+	PINCTRL_CONF_DESC(1, REG_GPIO_L_E2, BIT(1)),
+	PINCTRL_CONF_DESC(2, REG_GPIO_L_E2, BIT(2)),
+	PINCTRL_CONF_DESC(3, REG_GPIO_L_E2, BIT(3)),
+	PINCTRL_CONF_DESC(4, REG_GPIO_L_E2, BIT(4)),
+	PINCTRL_CONF_DESC(5, REG_GPIO_L_E2, BIT(5)),
+	PINCTRL_CONF_DESC(6, REG_GPIO_L_E2, BIT(6)),
+	PINCTRL_CONF_DESC(7, REG_GPIO_L_E2, BIT(7)),
+	PINCTRL_CONF_DESC(8, REG_GPIO_L_E2, BIT(8)),
+	PINCTRL_CONF_DESC(9, REG_GPIO_L_E2, BIT(9)),
+	PINCTRL_CONF_DESC(10, REG_GPIO_L_E2, BIT(10)),
+	PINCTRL_CONF_DESC(11, REG_GPIO_L_E2, BIT(11)),
+	PINCTRL_CONF_DESC(12, REG_GPIO_L_E2, BIT(12)),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_E2, BIT(13)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_E2, BIT(14)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_E2, BIT(15)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_E2, BIT(16)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_E2, BIT(17)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_E2, BIT(18)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_E2, BIT(19)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_E2, BIT(20)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_E2, BIT(21)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_E2, BIT(22)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_E2, BIT(23)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_E2, BIT(24)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_E2, BIT(25)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_E2, BIT(26)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_E2, BIT(27)),
+	PINCTRL_CONF_DESC(28, REG_I2C_SDA_E2, PCIE0_RESET_E2_MASK),
+	PINCTRL_CONF_DESC(29, REG_I2C_SDA_E2, PCIE1_RESET_E2_MASK),
+};
+
+static const struct airoha_pinctrl_conf en7523_pinctrl_drive_e4_conf[] = {
+	PINCTRL_CONF_DESC(0, REG_GPIO_L_E4, BIT(0)),
+	PINCTRL_CONF_DESC(1, REG_GPIO_L_E4, BIT(1)),
+	PINCTRL_CONF_DESC(2, REG_GPIO_L_E4, BIT(2)),
+	PINCTRL_CONF_DESC(3, REG_GPIO_L_E4, BIT(3)),
+	PINCTRL_CONF_DESC(4, REG_GPIO_L_E4, BIT(4)),
+	PINCTRL_CONF_DESC(5, REG_GPIO_L_E4, BIT(5)),
+	PINCTRL_CONF_DESC(6, REG_GPIO_L_E4, BIT(6)),
+	PINCTRL_CONF_DESC(7, REG_GPIO_L_E4, BIT(7)),
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
+	PINCTRL_CONF_DESC(28, REG_I2C_SDA_E4, PCIE0_RESET_E4_MASK),
+	PINCTRL_CONF_DESC(29, REG_I2C_SDA_E4, PCIE1_RESET_E4_MASK),
+};
+
+static const struct airoha_pinctrl_conf en7523_pinctrl_pcie_rst_od_conf[] = {
+	PINCTRL_CONF_DESC(28, REG_PCIE_RESET_OD, PCIE0_RESET_OD_MASK),
+	PINCTRL_CONF_DESC(29, REG_PCIE_RESET_OD, PCIE1_RESET_OD_MASK),
+};
+
+static const struct airoha_pinctrl_match_data en7523_pinctrl_match_data = {
+	.gpio_offs = 0,
+	.gpio_pin_cnt = 58,
+	.pins = en7523_pinctrl_pins,
+	.num_pins = ARRAY_SIZE(en7523_pinctrl_pins),
+	.grps = en7523_pinctrl_groups,
+	.num_grps = ARRAY_SIZE(en7523_pinctrl_groups),
+	.funcs = en7523_pinctrl_funcs,
+	.num_funcs = ARRAY_SIZE(en7523_pinctrl_funcs),
+	.confs_info = {
+		[AIROHA_PINCTRL_CONFS_PULLUP] = {
+			.confs = en7523_pinctrl_pullup_conf,
+			.num_confs = ARRAY_SIZE(en7523_pinctrl_pullup_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_PULLDOWN] = {
+			.confs = en7523_pinctrl_pulldown_conf,
+			.num_confs = ARRAY_SIZE(en7523_pinctrl_pulldown_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_DRIVE_E2] = {
+			.confs = en7523_pinctrl_drive_e2_conf,
+			.num_confs = ARRAY_SIZE(en7523_pinctrl_drive_e2_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_DRIVE_E4] = {
+			.confs = en7523_pinctrl_drive_e4_conf,
+			.num_confs = ARRAY_SIZE(en7523_pinctrl_drive_e4_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_PCIE_RST_OD] = {
+			.confs = en7523_pinctrl_pcie_rst_od_conf,
+			.num_confs = ARRAY_SIZE(en7523_pinctrl_pcie_rst_od_conf),
+		},
+	},
+};
+
+static const struct udevice_id airoha_pinctrl_of_match[] = {
+	{ .compatible = "airoha,en7523-pinctrl",
+	  .data = (uintptr_t)&en7523_pinctrl_match_data },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(airoha_pinctrl) = {
+	.name = "airoha-en7523-pinctrl",
+	.id = UCLASS_PINCTRL,
+	.of_match = of_match_ptr(airoha_pinctrl_of_match),
+	.probe = airoha_pinctrl_probe,
+	.bind = airoha_pinctrl_bind,
+	.priv_auto = sizeof(struct airoha_pinctrl),
+	.ops = &airoha_pinctrl_ops,
+};
-- 
2.53.0

