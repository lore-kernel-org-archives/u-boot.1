Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5854ECF6495
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 13:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFE448888F;
	Sun, 29 Sep 2024 15:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZIg2sROe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C6688873C; Sun, 29 Sep 2024 15:14:43 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 345A188D36
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 15:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5nEAKJGmVP12mge/ZtnOU+uo0OqS9YUI9v7y4qR1Binhu7YBAzWK6T80mTh4oYIjp1ccGWrVhnUyMC47JfuBhyTdlZI4ZKbw45CtOhI0eUPGbm+YD29sbgeyIKvDhx+yn5ZiTryFGq9G+lhudx94twJpTAgEik9AKqwX3Os6SIffodlEUAx7Cz1eIvNbe7RzUeZ8D9sfr6zmvLm+/0cuSl2y+nB9goaN5lVwPLE5RFBKf77GtKTAqIMtRuob0289VcPTB2jL5i510YZGYQ+ymYt31n9BlH8BvTJCXlIWTlE7cAz1uzoUvZkCKB2gyQPxY9KWfg8ER8gshftbb6vyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AV9zp3ufNeWIltdd+CB4plYUbJh+pSvUwdW3P3mJJI0=;
 b=Ad+LJeDcmSX7L2wwDmsFf1HojstCpTEZhOydOliFS+kXjunBwjJ4zP8i4sFslAuzRQrPUs7JFX6heY2w5/2tRnogxkFCYheCJjB5TwEp2m7Xz9s1Fc6L8oYXiG3XJvsuK+d9OGuuPD6HJ8mn0f5HsebTt/fgT5Ga9lswGVyXe6ixi3nZSGgN1l+BFfavcMdxHQ3Lcld2oCus6NLobZH1ZMva5uC8tAMIgICC8CqFqdov6q3SfB5dHICLUzOV7xFFV17gSHxpPPQbThgg1JGEL4UbpyXMc523ubew9XNYvourzGaCPH8Fno7ODEKY5B0kQvqxWzRM/3CHPnTBkxlZhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV9zp3ufNeWIltdd+CB4plYUbJh+pSvUwdW3P3mJJI0=;
 b=ZIg2sROewIBfYBFo3/u0kiw43ySTJ/cblGj7nHzQzBYjaf3lcGNdSiBddirmYuq/sMLQgwe5Hr3vimw0N4+fDBiq7WyDfl0Nav9++uxEA2MSqb+qHY9WvTubYkQG0sr33RQstWJ8+eqff8U/Vufhu39irsAzx9rsIWMce1T+MJBoHAbfdo5FO1WSQjx56zOycWqnmh+CA6UiHsaIv3MB+KElPkLeD6j0YR62+5k7LnYsm6kmR290S6tPrp67V/ompfklpTKMYFgKqcPi/tcltZrCn3IoNhFT/Usg8pv02ZfBuvEojNEfTnF9DlxJUGSAP+fEit6Q1K6hrY+Spa36QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7261.eurprd04.prod.outlook.com (2603:10a6:800:1a3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Sun, 29 Sep
 2024 13:14:39 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 13:14:39 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ye.li@nxp.com, peng.fan@nxp.com, alice.guo@nxp.com,
 viorel.suman@nxp.com, michal.simek@amd.com
Subject: [PATCH v1] mailbox: add i.MX MU driver
Date: Sun, 29 Sep 2024 21:13:41 +0800
Message-Id: <20240929131341.2761444-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b20ce2-9985-476c-5672-08dce088ac19
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ezOUvsLk7jSDJLgbew5UUF5/4XKxyXHJUv7cqYFBen/0PTOEcMmD9tu68lP5?=
 =?us-ascii?Q?CByE4h7HuFxeX+aw3eYFwKgkeCWs+zl+O7BesFUdOyILycTatFg5tgIKkehB?=
 =?us-ascii?Q?6t1yr+5yRrHw18y/+2SYBZ+bsZR557h4xY40+F8bclOMYqqbRtYO34gffHSk?=
 =?us-ascii?Q?2jmRINmbr7U94N0it6l4agM9LfW/XD/j5GNgPW2u2+smhEnd8Mi2P+9rXv+A?=
 =?us-ascii?Q?iTHzbgCry0m4diJ4n0tMwQ+hCnJgargeoq1fmqlKz7ICVlSwvAh7kvh5/zzY?=
 =?us-ascii?Q?zCD+1nQeRtPxE4XPUlDnEQfkCLjHdYk7t4gG10Txn2tWkbqgRlQHvzm37nfy?=
 =?us-ascii?Q?t6pKWJnd8YxytoVjI3ul/XR82/dSLGzrXge3h3fU03KH6FhjwoLn0V4O4VkX?=
 =?us-ascii?Q?4EuFBv4cHPobaZhMhpcNtQpLHceUB4aJwIirdSwUVINs3VszpZmbnF8n32aL?=
 =?us-ascii?Q?q3UtAklCSKhZoli5AdF3qU6kS6nD1UfxcL2Sc+8eUH/L3ird0/8/itdonf6o?=
 =?us-ascii?Q?qtosCKnH4/ujNJ0Gb0dPWn7aq5b7RY7tqWWTIpR64JNyFWwmGU+NOkk6HWzO?=
 =?us-ascii?Q?QLEk3fa9smvLXK7AC0INfRwgfYWiGYrsti5/fs13Y00idTeYwQ76du5HOWY8?=
 =?us-ascii?Q?9MgTAiOpUPt6rDy4rjiDosJUehe6PCJ1rPqU8VraDZB4u8ve5k3YbAHY7HYD?=
 =?us-ascii?Q?1Hi9Zt0a2CVXeRkGvVZhDt6Mza/xLm4MfxCXysZbIPDs7EM0MD84CNwEx9Do?=
 =?us-ascii?Q?mD1Rcqfs6ROHrTrX26OztLPGCILJ6IxlVFgHNLOpzerYsPlCqfw7R+rADzB0?=
 =?us-ascii?Q?mUU3nDbd3vPE504SK2kgvu2MgvOmwyRsphboWSRnZusw17fVPf8Ki4lo18Ct?=
 =?us-ascii?Q?bWkW3IbekoH2lW7XoyQVuy3/oC6Yf7Pv5VsJmhD14PG7PTZbADnTOAiZktjd?=
 =?us-ascii?Q?3DPof50yy3Ws+cp5UXot577pE86zUw8JgvNwNVpGsfRUsrQWj3yNDTuQ6ioc?=
 =?us-ascii?Q?4MXWB3imzuQrDI4VUKLmoXbx7gynlQcAc+eqCIJsRuzHklfgnzjikrNwbaFB?=
 =?us-ascii?Q?AIz7l5y9+f4eTJj1X+Ec9Yb9OIGh+zs57yr/eLj/4ymecBuKlTZ7ka0vXv6R?=
 =?us-ascii?Q?ChYx6Cyw8rTtMcNju3OZpQiFoayft4OJqBniM1WsapW02LZuUaht2NFf610G?=
 =?us-ascii?Q?v6n+/qSFrwA9s1bR/1uS3UrxMtshWQKRm6+2uuQBKvdKEVsXCV4ymkxO/TC9?=
 =?us-ascii?Q?Dab21wxGQhCIuFIIdUFtq4XaoYqLD4Xu9aoJf9lCl4pUK1XR3Uf+3DmqzZcu?=
 =?us-ascii?Q?ayxbEHmMGCHDRwsX7OM3OkLDvdYA3p1S6N8w83foHVHG2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?07nvHwNTS9tkHlVbU9ASjfMXRjC6nUe3Ej0AKIJBL5WBmv/ktxmEzbtX38Zu?=
 =?us-ascii?Q?Mp93zPb5+uv+Nio5ZQiJgyrUCYLwV8Yo1frmbhG/3evYFwUOKdvWEyhfpwPQ?=
 =?us-ascii?Q?B7/iPGuKcfj+5+WQxMMSHoQEgEpjEeJFCROZJj9J/rAQTj++vK+8sGGoJXM8?=
 =?us-ascii?Q?VqOmsOmspt9ZEbB1oDOIJRSdcsthHS3KlMGb/6fEfUM7xVyOhPaZL86gydme?=
 =?us-ascii?Q?lFDQ2JrwDTth6VpzQ0QzDjrqvVFfxcjXztfANo/ieD1TdUTA6t6fr/tQ//oS?=
 =?us-ascii?Q?hh3UIZXGae0UGH7DvaS10Fchu+/IS52Tln13JptypRaaeY8oSH81VQ49qA0B?=
 =?us-ascii?Q?mydk7AOPfu4htmhMrtCys+yawG6RBDG4N4aiDpeD0KhjroA4+YCUi7k1cnuH?=
 =?us-ascii?Q?D+SbXAirFqzmdce5xTA7ieqncv9tpng/2yNnZj+SxeL5wLsE/zfu27mfAwz/?=
 =?us-ascii?Q?0ZbFLNoafnCRVzldJyBWnHC9Fth80SLVcJ8cLUaEAaPPEvVbiSlbBQ+nOStc?=
 =?us-ascii?Q?pjbmO+cyvFYDEYmWitytE5b3pOWNvWXTk0qQTPWgGNKU6Eg1alkz4JMzgSsF?=
 =?us-ascii?Q?PYNpFDgFeY4DtHN8vPKdhLZf8kWF0hemF5ShHvU0gq/+ujF85z4uJ/AMg0Tn?=
 =?us-ascii?Q?ZPXSp3EtTpmA1TPoz6YMlgxMsvz+NgKm2b819yZ3nhIaGfKFHMUDCAhk/D6/?=
 =?us-ascii?Q?cc5UEkD0XfAJWiqQS55E7gU/SRsW0HFycPINIGPE7h7hQkG1yX19qvqAhVSZ?=
 =?us-ascii?Q?7gbG7vdX4ukfvHRGkaqE444Z8q11PzN2Qk0oBUc5+QvinfvywHomqsZeh+ax?=
 =?us-ascii?Q?Xq90JRG5k0ttVbWXHiszvJsGAeyQsZMCjJY1TENXHYYnGW3inR4SJzLeT81z?=
 =?us-ascii?Q?xXrQxhU8MT7DzAK+4zEu6r0NlEPeTMQFMYJ0GotFx5k8a6Nm99fQEczHqdmT?=
 =?us-ascii?Q?5GlPbwqpO8OFOhuUPNbhGHm3JcVggzuPPIVoHcHzNKb83NNAqin5zDUElyLp?=
 =?us-ascii?Q?c2ipIlq9GBByLCyMYY/Hvz1tmkH1vjc/HGzxxNEHxbSD3r0ek9AyXqzuyrl4?=
 =?us-ascii?Q?1PEd3VmiPPvU/RPFrYU2oHCg6+pzeFckaXk7KK+bIUTe5WR9/isieYIuJigJ?=
 =?us-ascii?Q?VaLPwkgH9/VGS6sHWcH3nK730KWemS36w73NnogmmYCsTR3gTIE94GPxFiZW?=
 =?us-ascii?Q?Wf94NK7pnEM3pMfu9CKFqJUYLJkCa16ZP5nDNBVa5V39bwt22rFTUlAT8y6X?=
 =?us-ascii?Q?PIJplUB76Wq5tYZc1/MrFEQLFyX40B7yUC4ISxblZ5hPku5fJE6iipRVAPO7?=
 =?us-ascii?Q?f7YBMkqjjSqz88ySZJ72K9+0/od6xC+Slvw0SKPTT3NbkXOQgTS3ZWnrJIeo?=
 =?us-ascii?Q?SqxDGsUvxcZfzTkGcIYBKcgHNPB7HTi2WBoS0rq4QF0tThHulMDuNbQ2OkOX?=
 =?us-ascii?Q?U02s3SqB4PPUc+EC0V+Z+mAQ255fbc+h5KMZ79LLykEh0PHANe1mmZjTmXJr?=
 =?us-ascii?Q?YBCkpQaucIpxFLEAlE6kFEOn7iXTvLyjCBjJfGZZigU7lQNVpFmLZVXSM54N?=
 =?us-ascii?Q?8JeCPvTHGGroZwk79IqORyPm+Y8eOW0v679MiOqG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b20ce2-9985-476c-5672-08dce088ac19
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 13:14:38.9999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QK059xhSW/z9SmrYF7uMniXkdnE7Jvz1k6HHiC02p17Bjdlja+wual0K7faYUWof76GeOouSwpg2/fNIYjU7MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7261
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

From: Peng Fan <peng.fan@nxp.com>

Add i.MX MU based mailbox driver.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/mailbox/Kconfig       |   7 +
 drivers/mailbox/Makefile      |   1 +
 drivers/mailbox/imx-mailbox.c | 417 ++++++++++++++++++++++++++++++++++
 3 files changed, 425 insertions(+)
 create mode 100644 drivers/mailbox/imx-mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 67d5ac1a74..4d9f004eba 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -21,6 +21,13 @@ config APPLE_MBOX
 	  such as the System Management Controller (SMC) and NVMe and this
 	  driver is required to get that functionality up and running.
 
+config IMX_MU_MBOX
+	bool "Enable i.MX MU MBOX support"
+	depends on DM_MAILBOX
+	help
+	  Enable support for i.MX Messaging Unit for communication with other
+	  processors on the SoC using mailbox interface
+
 config SANDBOX_MBOX
 	bool "Enable the sandbox mailbox test driver"
 	depends on DM_MAILBOX && SANDBOX
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 59e8d0de93..96a6adb709 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_$(SPL_)DM_MAILBOX) += mailbox-uclass.o
 obj-$(CONFIG_APPLE_MBOX) += apple-mbox.o
+obj-$(CONFIG_IMX_MU_MBOX) += imx-mailbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox-test.o
 obj-$(CONFIG_STM32_IPCC) += stm32-ipcc.o
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
new file mode 100644
index 0000000000..584950b20d
--- /dev/null
+++ b/drivers/mailbox/imx-mailbox.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2017-2023 NXP
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <mailbox-uclass.h>
+#include <linux/bitfield.h>
+#include <linux/bug.h>
+#include <linux/iopoll.h>
+#include <linux/compat.h>
+
+/* This driver only exposes the status bits to keep with the
+ * polling methodology of u-boot.
+ */
+DECLARE_GLOBAL_DATA_PTR;
+
+#define IMX_MU_CHANS		24
+
+#define IMX_MU_V2_PAR_OFF	0x4
+#define IMX_MU_V2_TR_MASK	GENMASK(7, 0)
+#define IMX_MU_V2_RR_MASK	GENMASK(15, 8)
+
+enum imx_mu_chan_type {
+	IMX_MU_TYPE_TX          = 0, /* Tx */
+	IMX_MU_TYPE_RX          = 1, /* Rx */
+	IMX_MU_TYPE_TXDB        = 2, /* Tx doorbell */
+	IMX_MU_TYPE_RXDB        = 3, /* Rx doorbell */
+	IMX_MU_TYPE_RST         = 4, /* Reset */
+	IMX_MU_TYPE_TXDB_V2     = 5, /* Tx doorbell with S/W ACK */
+};
+
+enum imx_mu_xcr {
+	IMX_MU_CR,
+	IMX_MU_GIER,
+	IMX_MU_GCR,
+	IMX_MU_TCR,
+	IMX_MU_RCR,
+	IMX_MU_xCR_MAX,
+};
+
+enum imx_mu_xsr {
+	IMX_MU_SR,
+	IMX_MU_GSR,
+	IMX_MU_TSR,
+	IMX_MU_RSR,
+	IMX_MU_xSR_MAX,
+};
+
+struct imx_mu_con_priv {
+	unsigned int		idx;
+	enum imx_mu_chan_type	type;
+	struct mbox_chan	*chan;
+};
+
+enum imx_mu_type {
+	IMX_MU_V1,
+	IMX_MU_V2 = BIT(1),
+	IMX_MU_V2_S4 = BIT(15),
+	IMX_MU_V2_IRQ = BIT(16),
+};
+
+struct imx_mu {
+	void __iomem *base;
+	const struct imx_mu_dcfg *dcfg;
+	u32 num_tr;
+	u32 num_rr;
+	/* use pointers to channel as a way to reserve channels */
+	struct mbox_chan *channels[IMX_MU_CHANS];
+	struct imx_mu_con_priv  con_priv[IMX_MU_CHANS];
+};
+
+struct imx_mu_dcfg {
+	int (*tx)(struct imx_mu *plat, struct imx_mu_con_priv *cp, const void *data);
+	int (*rx)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*rxdb)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*init)(struct imx_mu *plat);
+	int (*of_xlate)(struct mbox_chan *chan, struct ofnode_phandle_args *args);
+	enum imx_mu_type type;
+	u32	xTR;			/* Transmit Register0 */
+	u32	xRR;			/* Receive Register0 */
+	u32	xSR[IMX_MU_xSR_MAX];	/* Status Registers */
+	u32	xCR[IMX_MU_xCR_MAX];	/* Control Registers */
+};
+
+#define IMX_MU_xSR_GIPn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+#define IMX_MU_xSR_RFn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+#define IMX_MU_xSR_TEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+
+/* General Purpose Interrupt Enable */
+#define IMX_MU_xCR_GIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+/* Receive Interrupt Enable */
+#define IMX_MU_xCR_RIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+/* Transmit Interrupt Enable */
+#define IMX_MU_xCR_TIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+/* General Purpose Interrupt Request */
+#define IMX_MU_xCR_GIRn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(16 + (3 - (x))))
+/* MU reset */
+#define IMX_MU_xCR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(5))
+#define IMX_MU_xSR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(7))
+
+static void imx_mu_write(struct imx_mu *plat, u32 val, u32 offs)
+{
+	iowrite32(val, plat->base + offs);
+}
+
+static u32 imx_mu_read(struct imx_mu *plat, u32 offs)
+{
+	return ioread32(plat->base + offs);
+}
+
+static u32 imx_mu_xcr_rmw(struct imx_mu *plat, enum imx_mu_xcr type, u32 set, u32 clr)
+{
+	u32 val;
+
+	val = imx_mu_read(plat, plat->dcfg->xCR[type]);
+	val &= ~clr;
+	val |= set;
+	imx_mu_write(plat, val, plat->dcfg->xCR[type]);
+
+	return val;
+}
+
+/* check that the channel is open or owned by caller */
+static int imx_mu_check_channel(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	if (plat->channels[chan->id] != NULL) {
+		/* if reserved check that caller owns */
+		if (plat->channels[chan->id] == chan)
+			return 1; /* caller owns the channel */
+
+		return -EACCES;
+	}
+
+	return 0; /* channel empty */
+}
+
+static int imx_mu_chan_request(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp;
+	enum imx_mu_chan_type type;
+	int idx;
+
+	type = chan->id / 4;
+	idx = chan->id % 4;
+
+	if (imx_mu_check_channel(chan) < 0) /* check if channel already in use */
+		return -EPERM;
+
+	plat->channels[chan->id] = chan;
+	chan->con_priv = kcalloc(1, sizeof(struct imx_mu_con_priv), 0);
+	if (!chan->con_priv)
+		return -ENOMEM;
+	cp = chan->con_priv;
+	cp->idx = idx;
+	cp->type = type;
+	cp->chan = chan;
+
+	switch (type) {
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, IMX_MU_xCR_RIEn(plat->dcfg->type, idx), 0);
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, IMX_MU_xCR_GIEn(plat->dcfg->type, idx), 0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int imx_mu_chan_free(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) <= 0) /* check that the channel is also not empty */
+		return -EINVAL;
+
+	/* if you own channel and  channel is NOT empty */
+	plat->channels[chan->id] = NULL;
+	switch (cp->type) {
+	case IMX_MU_TYPE_TX:
+		imx_mu_xcr_rmw(plat, IMX_MU_TCR, 0, IMX_MU_xCR_TIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, 0, IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		break;
+	}
+
+	kfree(cp);
+
+	return 0;
+}
+
+static int imx_mu_send(struct mbox_chan *chan, const void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	return plat->dcfg->tx(plat, cp, data);
+}
+
+static int imx_mu_recv(struct mbox_chan *chan, void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+	u32 ctrl, val;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_RXDB:
+		/* check if GSR[GIRn] bit is set */
+		if (readx_poll_timeout(ioread32, plat->base + plat->dcfg->xSR[IMX_MU_GSR],
+		    val, val & BIT(cp->idx), 1000000) < 0)
+			return -EBUSY;
+
+		ctrl = imx_mu_read(plat, plat->dcfg->xCR[IMX_MU_GIER]);
+		val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+		val &= IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx) &
+			(ctrl & IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		dev_warn(chan->dev, "Unhandled channel type %d\n", cp->type);
+		return -EOPNOTSUPP;
+	};
+
+	if (val == IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx))
+		plat->dcfg->rxdb(plat, cp);
+
+	return 0;
+}
+
+static int imx_mu_of_to_plat(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE)
+		return -ENODEV;
+
+	plat->base = (struct mu_type *)addr;
+
+	return 0;
+}
+
+static int imx_mu_init_generic(struct imx_mu *plat)
+{
+	unsigned int i;
+	unsigned int val;
+
+	if (plat->num_rr > 4 || plat->num_tr > 4) {
+		WARN_ONCE(true, "%s not support TR/RR larger than 4\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	/* Set default MU configuration */
+	for (i = 0; i < IMX_MU_xCR_MAX; i++)
+		imx_mu_write(plat, 0, plat->dcfg->xCR[i]);
+
+	/* Clear any pending GIP */
+	val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+	imx_mu_write(plat, val, plat->dcfg->xSR[IMX_MU_GSR]);
+
+	/* Clear any pending RSR */
+	for (i = 0; i < plat->num_rr; i++)
+		imx_mu_read(plat, plat->dcfg->xRR + i * 4);
+
+	return 0;
+}
+
+static int imx_mu_generic_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	enum imx_mu_chan_type type;
+	int idx, cid;
+
+	if (args->args_count != 2) {
+		dev_err(chan->dev, "Invalid argument count %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	type = args->args[0]; /* channel type */
+	idx = args->args[1]; /* index */
+
+	cid = type * 4 + idx;
+	if (cid >= IMX_MU_CHANS) {
+		dev_err(chan->dev, "Not supported channel number: %d. (type: %d, idx: %d)\n",
+			cid, type, idx);
+		return -EINVAL;
+	}
+
+	chan->id = cid;
+
+	return 0;
+}
+
+static int imx_mu_generic_tx(struct imx_mu *plat, struct imx_mu_con_priv *cp,
+			     const void *data)
+{
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+		imx_mu_xcr_rmw(plat, IMX_MU_GCR, IMX_MU_xCR_GIRn(plat->dcfg->type, cp->idx), 0);
+		break;
+	default:
+		dev_warn(cp->chan->dev, "Send data on wrong channel type: %d\n", cp->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int imx_mu_generic_rxdb(struct imx_mu *plat, struct imx_mu_con_priv *cp)
+{
+	imx_mu_write(plat, IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx),
+		     plat->dcfg->xSR[IMX_MU_GSR]);
+
+	return 0;
+}
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx95 = {
+	.tx	= imx_mu_generic_tx,
+	.rxdb	= imx_mu_generic_rxdb,
+	.init	= imx_mu_init_generic,
+	.of_xlate = imx_mu_generic_of_xlate,
+	.type	= IMX_MU_V2,
+	.xTR	= 0x200,
+	.xRR	= 0x280,
+	.xSR	= {0xC, 0x118, 0x124, 0x12C},
+	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
+};
+
+static const struct udevice_id ids[] = {
+	{ .compatible = "fsl,imx95-mu", .data = (ulong)&imx_mu_cfg_imx95 },
+	{ }
+};
+
+int imx_mu_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	return plat->dcfg->of_xlate(chan, args);
+}
+
+struct mbox_ops imx_mu_ops = {
+	.of_xlate = imx_mu_of_xlate,
+	.request  = imx_mu_chan_request,
+	.rfree    = imx_mu_chan_free,
+	.send     = imx_mu_send,
+	.recv     = imx_mu_recv,
+};
+
+static void imx_mu_get_tr_rr(struct imx_mu *plat)
+{
+	u32 val;
+
+	if (plat->dcfg->type & IMX_MU_V2) {
+		val = imx_mu_read(plat, IMX_MU_V2_PAR_OFF);
+		plat->num_tr = FIELD_GET(IMX_MU_V2_TR_MASK, val);
+		plat->num_rr = FIELD_GET(IMX_MU_V2_RR_MASK, val);
+	} else {
+		plat->num_tr = 4;
+		plat->num_rr = 4;
+	}
+}
+
+static int imx_mu_probe(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	int ret;
+
+	debug("%s(dev=%p)\n", __func__, dev);
+
+	plat->dcfg = (void *)dev_get_driver_data(dev);
+
+	imx_mu_get_tr_rr(plat);
+
+	ret = plat->dcfg->init(plat);
+	if (ret) {
+		dev_err(dev, "Failed to init MU\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(imx_mu) = {
+	.name = "imx-mu",
+	.id = UCLASS_MAILBOX,
+	.of_match = ids,
+	.of_to_plat = imx_mu_of_to_plat,
+	.plat_auto = sizeof(struct imx_mu),
+	.probe = imx_mu_probe,
+	.ops = &imx_mu_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.34.1

