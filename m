Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A40FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 15:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 505D38467E;
	Tue, 28 Apr 2026 17:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="q+KrElQN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 999128426E; Tue, 28 Apr 2026 17:35:11 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9115C8432A
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 17:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPoBLSENpkuuPDcIKLvYtk2BAmrxjfvRk7ktjcmOKJo4w62HhqaTjHSfQtEdt/shpjKzW86jCJWK4OW+7UWXk0ZzU8Astoaa/fzOla9oxxA0D5TqBVZmitwvqrAlZPlmGnt+z4Q3RZExV3T6rErWj0/kyEVmimIw9r4CCWn63HjJa4XwytvovgJRGTzJ876ooJg0YlDBzJSDw/BKvgFPDaZfRSQvvW9eehS5ChkDqopFNxYQlXD+FxYHhiSAFMQ+xxLtvUhDBwalrLiC9v+8rUG3CgyQR4soPlHusUJV04bGUShcW8GRjJr3cgu45VPpeIDANMdNCDmKlPyazhglRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjKwLWOd2QRbE+EBOtigPwEby+9XQJx8lztDVaT7+CQ=;
 b=s8S4cu5BV+j1+54sOHeiz7/SqoP/62KSBIjmXXJsAVqxI9d/bD7LDel4OjIuCN1cq7NohPfy3ZrJENbuHyLMEZHmIKv4FPm+6G3uXCJ0DjDBe7Ug5frHm1Qx2ubgIUK/0WsKYPJ5MfDLlx78rfJwr/9JPqNhXueY/SJ9hqxZYZ/LUnnJLlWdztEi7KPRMZMbPxZEYsSOaNJyOAjCvifDAXHHwLmMUVLN/znMV/CO5pXNmrrOLEajipzh6g7krM/Kq+OzxgJIvlfHJwDDvSc6QQ28Ij76mDwvc5DKmWscbFG5xLAm23O61ChIDQFGre7WP2DjiN/z1mZ3wxApq0wuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjKwLWOd2QRbE+EBOtigPwEby+9XQJx8lztDVaT7+CQ=;
 b=q+KrElQN9PG4tapBnxCejHlyVMxxkmqVou282I2tnWLaaG/q7E9X9FA5KvYQIuKm0EiNBxgcMdh4oKGnkFK4GInZTX719icsg1wQ32nZ8nS26LDluFDiaoHHcl+iOGgJwiB6BI+yB+C+LChYptmfpOENrboPGpyLUD6HZoIYOEkMBFVcTUU/071g4u+5hyVEI/hD9PXym3L9YglbucF8WfwNccAWtsAS7ak2VhFExz6CBjYb7XM7kBbo6XS64LAJ1qeEb8eVqyjDXUCT9RRw12+6W9JCmYScNgaIexOTt0BnnqRsEXh80IAew9WkGuxaU2J2eBrnrpOvL7MLFKey3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAXPR08MB6720.eurprd08.prod.outlook.com (2603:10a6:102:130::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 15:34:59 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 15:34:59 +0000
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
Subject: [PATCH v2 2/6] pinctrl: airoha: add pin controller and gpio driver
 for AN7581 SoC
Date: Tue, 28 Apr 2026 18:34:44 +0300
Message-ID: <20260428153448.980150-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAXPR08MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dce1b42-c490-4bbd-6245-08dea53bb504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|52116014|56012099003|18002099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: Ff9bpxHZLVyOuAZFNnUJNW+sxpvt4QTPVefh30KMQnLH7lf3XJkKFKE/3K88zY9jAdBtf0ySXoFPW3aYNhy6eSSvHxHtRUVgYdjh0nEOL5v9c2lJS/hNTDK+Wu6orTAX5OUNyf50zIbwDdTpk3ELrjZe1FjLKo1g5nxztsHEQ5v78g5nMogcM0icY2O9HVuBs91zseACPQmkmwamnnRebN9JGrTJJc3qkkYIKtAbKPcgqatiAoxiXojsv7BsGFPA8oCraeA+AP44gAZl9+jwCfJwfwDhxDyvPgN8n8pRYHTLa8X2e0UCNW46FltNsopbzth/qYN7VQEqigjX8VcAhSTnKcFY6zVIH3MCDM0MArulwJMv5FuIFhQGG8VDqhHj9N8hIDEKP8byQNbhK6GgVVnzvRWBlBMk0DBfQtkvdGhnDEyeNmv9oCTxml8dhKeRVOONO4pD+H6c07fEUJ71tD8c4Ipcy2n6V4McmWTjEiKqjlDRzRYhTP3TBvPHLYAqTIRK1MUTSiimGke7X/fNjTE9DmMjqSXFYTtYIdu4tRyD0oqxvrjMv9txZFwtrvRyLx2IPmgPw/3+6aombU8g22d+2EkkLPQ2KGdxwivzxBizw5UUEpEw3IYZxyvnHFS0/d90cYgA4DJc/A9u6IplnKQ5XwRJs2Vrwd4mSY5ba/++EgBn1aXiNOLRJ/p3FMQOifSFn7KK1jFwiluG0F7ObOG715qTExtpPJIqQHovIGAMq0xn4nXNLPfcphBOnTdN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(56012099003)(18002099003)(22082099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ALzeQvmryUvKyNMYHkOs4G8iA4RjCC+zwSRGXUi6K2Ulornm852n+UG8jAzF?=
 =?us-ascii?Q?5Dw0sxmwilM3mSWBE2b6FZtpn6obGauZ4xJKvq1O4gJXso6YW3Bbk+SHoWik?=
 =?us-ascii?Q?ONOI1W/T2oJSMv+DHLWV3wo3oFUa7D6OdGwt+6nFs/LiQxC7l5+KwnkfkRgZ?=
 =?us-ascii?Q?gWfrNV3TZGuqPZ9SMto5KzkqtY4rwEKw4QIDfVOMl+EUTpGO60sajLLEX60T?=
 =?us-ascii?Q?2E5yxSKYCR6JVHV6Brrfq24Oiz0fFh8mqr2TBBx5lggMs8FRqwXlCeNZp8f8?=
 =?us-ascii?Q?dt93OsgLVvJ4DFaPCYUwdg6Pxaom3OzfTX+GZz3o5OcjQC/qisT5kcKjHT3N?=
 =?us-ascii?Q?WCLz/b8dcEP0h+e3LR65tukYBl6gt/+SFrWnCe3yavRbkPhiGYEg18f8DxGq?=
 =?us-ascii?Q?CI/q/vVwcT3WW58NkKnzLr1kCkRykug6iWS8Bf13iXteOzhBuRhTO2upnnT2?=
 =?us-ascii?Q?CltnvNQ8OQHJbYM3xtg7I4ZxAVYg7ZZqngLx3Z95M7060NzU18la+49yGz1l?=
 =?us-ascii?Q?crCQ43vXfcLLkq1wnIHj3yiPBWrafhzrYbBDIyxWtPKVfhOtKncC5mE1XsIg?=
 =?us-ascii?Q?3+3priZo14qDUtyV8TgpEXl1im5gsBqPd+bIRV7X1AUozqtVic0TUtdjdoqP?=
 =?us-ascii?Q?9wB8jX4AW3uoC0Q5uZ1NCk+HgFREX+PEeWB14he26qb5xjDPSJFZan3F5yCL?=
 =?us-ascii?Q?QznRFVelNvDz1bXPlrBaj0Zr4ndRPOPsvDhT2pYEOQm1mlipkPEVLXKY28cA?=
 =?us-ascii?Q?WXY45m3Xvm/9euEIVl5yeSi2y2GyON3AwU0IsQuntS1v8mXd2Zuw7kqZxnMu?=
 =?us-ascii?Q?nOK2fGOeKh1us1c68hq3fbhBU7MkmmhHgdkDD62ClldKiuFvIugUpSHXHyvC?=
 =?us-ascii?Q?1gs58DPKyVSoQlvKfsdCj3D6v/VnHNk+4y2XFN4wS2gABTycEEJNS7xcOylq?=
 =?us-ascii?Q?atxtyr8ey9eAy1FbCRtM+rv3c2e78iwHjGYUrpb4RqTnu63ll+eaUrQXU2A+?=
 =?us-ascii?Q?BcxXzB9XMXMbkv8UZjMVhciFBxU1K1YTLi75h3sPL2Ve0R229meVC4WlaaV/?=
 =?us-ascii?Q?bWTcOHHuQaByXjUHKADcC7S3BEv7GsViRTw0UJ/XyYsEpd0zRmy2kEr5b9HS?=
 =?us-ascii?Q?Y3qyisj7gHOtKOJN8xZ5ocQgv373whzcioDzFIh9Fme2QkJMFI/M1V5nBq6r?=
 =?us-ascii?Q?M9esJqrJgmETcVhUFvuS+JD8THm51D+SLuBu4kSid7Bp6upGJ02/nmUfV3MP?=
 =?us-ascii?Q?SGkUyPy+/r3Q2IR1EWuVO1V1MSXUlocTZxLEhev21cAhjdOai4WRAJ1OZdZf?=
 =?us-ascii?Q?sVhnsT8HUkUtqhr0XSfWn31mAuwei3EZQmRkL2CYh835AR+ulz1qSvTYgoST?=
 =?us-ascii?Q?SGm+nEw5FYaC7zJQxjtbF4JYdm981/NaN9GsoZHRySJv+OYpzgPE/aFtKiwT?=
 =?us-ascii?Q?6EvPG2yX06NGPOCnLKcLIyzWLxRt5dfFi2ip+dmvJrLakOM8VvxNAnflIsOs?=
 =?us-ascii?Q?BN/jDiCj1Bkmfb+LCHY5z0HamiQF/dMGrb4eGHtLokqjSjQuYDYrU7YZk6LV?=
 =?us-ascii?Q?iRanNi3/5oP4DFzBA6PbmS8Oex/7QJWch4hgemRxugR41HsvCVatzvWFc4PU?=
 =?us-ascii?Q?2PGrHeFkrjFEKUFblL8RwKPzu1P+uUpSKGOf1I5tB3zS0XhhadHwBhu3uITY?=
 =?us-ascii?Q?T5jfXvqqb6bwPLTukay5Du5Z2DcC5TBgmLx2yox9wiFZeC0y7l6npRdd1fl5?=
 =?us-ascii?Q?r2SNbeuqXL2EHqWtwaa4vaknU0lsszw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dce1b42-c490-4bbd-6245-08dea53bb504
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 15:34:59.3933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/QrB8lESiH+KCcn48hT95HzlV994aF006yHjySjIy1+iIiUNG5LqKAnRNeUh/FysbDnJVjzaBN5iwpQfiMIkUh2QRs8wjOncZAoarlJKxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6720
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

This patch adds U-Boot pin controller and gpio driver for Airoha AN7581 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/pinctrl/Kconfig                 |    1 +
 drivers/pinctrl/Makefile                |    1 +
 drivers/pinctrl/airoha/Kconfig          |   16 +
 drivers/pinctrl/airoha/Makefile         |    5 +
 drivers/pinctrl/airoha/airoha-common.h  |  513 +++++++++++
 drivers/pinctrl/airoha/pinctrl-airoha.c |  691 +++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7581.c | 1060 +++++++++++++++++++++++
 7 files changed, 2287 insertions(+)
 create mode 100644 drivers/pinctrl/airoha/Kconfig
 create mode 100644 drivers/pinctrl/airoha/Makefile
 create mode 100644 drivers/pinctrl/airoha/airoha-common.h
 create mode 100644 drivers/pinctrl/airoha/pinctrl-airoha.c
 create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 578edbf8168..46a95a1ab6b 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -405,6 +405,7 @@ config SPL_PINCTRL_ZYNQMP
 
 endif
 
+source "drivers/pinctrl/airoha/Kconfig"
 source "drivers/pinctrl/broadcom/Kconfig"
 source "drivers/pinctrl/exynos/Kconfig"
 source "drivers/pinctrl/intel/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 29fb9b484d0..b03e838ab39 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl_pic32.o
 obj-$(CONFIG_PINCTRL_EXYNOS)	+= exynos/
 obj-$(CONFIG_PINCTRL_K210)	+= pinctrl-k210.o
 obj-$(CONFIG_PINCTRL_MESON)	+= meson/
+obj-$(CONFIG_PINCTRL_AIROHA)	+= airoha/
 obj-$(CONFIG_PINCTRL_MTK)	+= mediatek/
 obj-$(CONFIG_PINCTRL_MSCC)	+= mscc/
 obj-$(CONFIG_ARCH_MVEBU)	+= mvebu/
diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
new file mode 100644
index 00000000000..986d23c2e3d
--- /dev/null
+++ b/drivers/pinctrl/airoha/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config PINCTRL_AIROHA
+	depends on ARCH_AIROHA
+	select PINCTRL_FULL
+	select PINCTRL_GENERIC
+	select PINMUX
+	select PINCONF
+	select REGMAP
+	select SYSCON
+	bool
+
+config PINCTRL_AIROHA_AN7581
+	tristate "AN7581 pin controller and gpio driver"
+	depends on TARGET_AN7581
+	select PINCTRL_AIROHA
diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha/Makefile
new file mode 100644
index 00000000000..909bd9a04d9
--- /dev/null
+++ b/drivers/pinctrl/airoha/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_PINCTRL_AIROHA)		+= pinctrl-airoha.o
+
+obj-$(CONFIG_PINCTRL_AIROHA_AN7581)	+= pinctrl-an7581.o
diff --git a/drivers/pinctrl/airoha/airoha-common.h b/drivers/pinctrl/airoha/airoha-common.h
new file mode 100644
index 00000000000..21bc9f50083
--- /dev/null
+++ b/drivers/pinctrl/airoha/airoha-common.h
@@ -0,0 +1,513 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef __AIROHA_COMMON_HEADER__
+#define __AIROHA_COMMON_HEADER__
+
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include <dm/device.h>
+#include <dm/pinctrl.h>
+
+#define PINCTRL_PIN_GROUP(id, table)					\
+	PINCTRL_PINGROUP(id, table##_pins, ARRAY_SIZE(table##_pins))
+
+#define PINCTRL_FUNC_DESC(id, table)					\
+	{								\
+		.desc = PINCTRL_PINFUNCTION(id, table##_groups,	\
+					    ARRAY_SIZE(table##_groups)),\
+		.groups = table##_func_group,				\
+		.group_size = ARRAY_SIZE(table##_func_group),		\
+	}
+
+#define PINCTRL_CONF_DESC(p, offset, mask)				\
+	{								\
+		.pin = p,						\
+		.reg = { offset, mask },				\
+	}
+
+/* MUX */
+#define AN7581_REG_GPIO_2ND_I2C_MODE	0x0214
+#define EN7523_REG_GPIO_2ND_I2C_MODE	0x0210
+#define GPIO_MDC_IO_MASTER_MODE_MODE	BIT(14)
+#define GPIO_I2C_MASTER_MODE_MODE	BIT(13)
+#define GPIO_I2S_MODE_MASK		BIT(12)
+#define GPIO_I2C_SLAVE_MODE_MODE	BIT(11)
+#define GPIO_LAN3_LED1_MODE_MASK	BIT(10)
+#define GPIO_LAN3_LED0_MODE_MASK	BIT(9)
+#define GPIO_LAN2_LED1_MODE_MASK	BIT(8)
+#define GPIO_LAN2_LED0_MODE_MASK	BIT(7)
+#define GPIO_LAN1_LED1_MODE_MASK	BIT(6)
+#define GPIO_LAN1_LED0_MODE_MASK	BIT(5)
+#define GPIO_LAN0_LED1_MODE_MASK	BIT(4)
+#define GPIO_LAN0_LED0_MODE_MASK	BIT(3)
+#define PON_TOD_1PPS_MODE_MASK		BIT(2)
+#define GSW_TOD_1PPS_MODE_MASK		BIT(1)
+#define GPIO_2ND_I2C_MODE_MASK		BIT(0)
+#define NPU_UART_MODE_MASK		BIT(2)
+
+#define REG_GPIO_SPI_CS1_MODE		0x0218
+#define EN7523_REG_GPIO_SPI_CS1_MODE	0x0214
+
+#define GPIO_PCM_SPI_CS4_MODE_MASK		BIT(21)
+#define GPIO_PCM_SPI_CS3_MODE_MASK		BIT(20)
+#define GPIO_PCM_SPI_CS2_MODE_P156_MASK		BIT(19)
+#define GPIO_PCM_SPI_CS2_MODE_P128_MASK		BIT(18)
+#define AN7583_GPIO_PCM_SPI_CS2_MODE_MASK	BIT(18)
+#define GPIO_PCM_SPI_CS1_MODE_MASK		BIT(17)
+#define GPIO_PCM_SPI_MODE_MASK			BIT(16)
+#define GPIO_PCM2_MODE_MASK			BIT(13)
+#define GPIO_PCM1_MODE_MASK			BIT(12)
+#define GPIO_PCM_INT_MODE_MASK			BIT(9)
+#define GPIO_PCM_RESET_MODE_MASK		BIT(8)
+#define GPIO_SPI_QUAD_MODE_MASK			BIT(4)
+#define GPIO_SPI_CS4_MODE_MASK			BIT(3)
+#define GPIO_SPI_CS3_MODE_MASK			BIT(2)
+#define GPIO_SPI_CS2_MODE_MASK			BIT(1)
+#define GPIO_SPI_CS1_MODE_MASK			BIT(0)
+
+#define REG_GPIO_PON_MODE			0x021c
+#define EN7523_REG_GPIO_PON_MODE		0x0218
+#define GPIO_PARALLEL_NAND_MODE_MASK		BIT(14)
+#define GPIO_SGMII_MDIO_MODE_MASK		BIT(13)
+#define GPIO_PCIE_RESET2_MASK			BIT(12)
+#define SIPO_RCLK_MODE_MASK			BIT(11)
+#define GPIO_PCIE_RESET1_MASK			BIT(10)
+#define GPIO_PCIE_RESET0_MASK			BIT(9)
+#define GPIO_UART5_MODE_MASK			BIT(8)
+#define GPIO_UART4_MODE_MASK			BIT(7)
+#define GPIO_HSUART_CTS_RTS_MODE_MASK		BIT(6)
+#define GPIO_HSUART_MODE_MASK			BIT(5)
+#define GPIO_UART2_CTS_RTS_MODE_MASK		BIT(4)
+#define GPIO_UART2_MODE_MASK			BIT(3)
+#define GPIO_SIPO_MODE_MASK			BIT(2)
+#define GPIO_EMMC_MODE_MASK			BIT(1)
+#define GPIO_PON_MODE_MASK			BIT(0)
+
+#define REG_NPU_UART_EN			0x0224
+#define EN7523_REG_NPU_UART_EN		0x0220
+#define JTAG_UDI_EN_MASK		BIT(4)
+#define JTAG_DFD_EN_MASK		BIT(3)
+
+#define REG_FORCE_GPIO_EN		0x0228
+#define FORCE_GPIO_EN(n)		BIT(n)
+
+/* LED MAP */
+#define REG_LAN_LED0_MAPPING		0x027c
+#define REG_LAN_LED1_MAPPING		0x0280
+
+#define LAN4_LED_MAPPING_MASK		GENMASK(18, 16)
+#define LAN4_PHY_LED_MAP(_n)		FIELD_PREP_CONST(LAN4_LED_MAPPING_MASK, (_n))
+
+#define LAN3_LED_MAPPING_MASK		GENMASK(14, 12)
+#define LAN3_PHY_LED_MAP(_n)		FIELD_PREP_CONST(LAN3_LED_MAPPING_MASK, (_n))
+
+#define LAN2_LED_MAPPING_MASK		GENMASK(10, 8)
+#define LAN2_PHY_LED_MAP(_n)		FIELD_PREP_CONST(LAN2_LED_MAPPING_MASK, (_n))
+
+#define LAN1_LED_MAPPING_MASK		GENMASK(6, 4)
+#define LAN1_PHY_LED_MAP(_n)		FIELD_PREP_CONST(LAN1_LED_MAPPING_MASK, (_n))
+
+#define LAN0_LED_MAPPING_MASK		GENMASK(2, 0)
+#define LAN0_PHY_LED_MAP(_n)		FIELD_PREP_CONST(LAN0_LED_MAPPING_MASK, (_n))
+
+/* CONF */
+#define REG_I2C_SDA_E2			0x001c
+#define AN7583_I2C1_SCL_E2_MASK		BIT(16)
+#define AN7583_I2C1_SDA_E2_MASK		BIT(15)
+#define SPI_MISO_E2_MASK		BIT(14)
+#define SPI_MOSI_E2_MASK		BIT(13)
+#define SPI_CLK_E2_MASK			BIT(12)
+#define SPI_CS0_E2_MASK			BIT(11)
+#define EN7523_SPI_MISO_E2_MASK		BIT(13)
+#define EN7523_SPI_MOSI_E2_MASK		BIT(12)
+#define EN7523_SPI_CLK_E2_MASK		BIT(11)
+#define EN7523_SPI_CS0_E2_MASK		BIT(10)
+#define PCIE2_RESET_E2_MASK		BIT(10)
+#define PCIE1_RESET_E2_MASK		BIT(9)
+#define PCIE0_RESET_E2_MASK		BIT(8)
+#define AN7583_MDIO_0_E2_MASK		BIT(5)
+#define AN7583_MDC_0_E2_MASK		BIT(4)
+#define UART1_RXD_E2_MASK		BIT(3)
+#define UART1_TXD_E2_MASK		BIT(2)
+#define I2C_SCL_E2_MASK			BIT(1)
+#define I2C_SDA_E2_MASK			BIT(0)
+
+#define REG_I2C_SDA_E4			0x0020
+#define AN7583_I2C1_SCL_E4_MASK		BIT(16)
+#define AN7583_I2C1_SDA_E4_MASK		BIT(15)
+#define SPI_MISO_E4_MASK		BIT(14)
+#define SPI_MOSI_E4_MASK		BIT(13)
+#define SPI_CLK_E4_MASK			BIT(12)
+#define SPI_CS0_E4_MASK			BIT(11)
+#define EN7523_SPI_MISO_E4_MASK		BIT(13)
+#define EN7523_SPI_MOSI_E4_MASK		BIT(12)
+#define EN7523_SPI_CLK_E4_MASK		BIT(11)
+#define EN7523_SPI_CS0_E4_MASK		BIT(10)
+#define PCIE2_RESET_E4_MASK		BIT(10)
+#define PCIE1_RESET_E4_MASK		BIT(9)
+#define PCIE0_RESET_E4_MASK		BIT(8)
+#define AN7583_MDIO_0_E4_MASK		BIT(5)
+#define AN7583_MDC_0_E4_MASK		BIT(4)
+#define UART1_RXD_E4_MASK		BIT(3)
+#define UART1_TXD_E4_MASK		BIT(2)
+#define I2C_SCL_E4_MASK			BIT(1)
+#define I2C_SDA_E4_MASK			BIT(0)
+
+#define REG_GPIO_L_E2			0x0024
+#define REG_GPIO_L_E4			0x0028
+#define REG_GPIO_H_E2			0x002c
+#define REG_GPIO_H_E4			0x0030
+
+#define REG_I2C_SDA_PU			0x0044
+#define AN7583_I2C1_SCL_PU_MASK		BIT(16)
+#define AN7583_I2C1_SDA_PU_MASK		BIT(15)
+#define SPI_MISO_PU_MASK		BIT(14)
+#define SPI_MOSI_PU_MASK		BIT(13)
+#define SPI_CLK_PU_MASK			BIT(12)
+#define SPI_CS0_PU_MASK			BIT(11)
+#define EN7523_SPI_MISO_PU_MASK		BIT(13)
+#define EN7523_SPI_MOSI_PU_MASK		BIT(12)
+#define EN7523_SPI_CLK_PU_MASK		BIT(11)
+#define EN7523_SPI_CS0_PU_MASK		BIT(10)
+#define PCIE2_RESET_PU_MASK		BIT(10)
+#define PCIE1_RESET_PU_MASK		BIT(9)
+#define PCIE0_RESET_PU_MASK		BIT(8)
+#define AN7583_MDIO_0_PU_MASK		BIT(5)
+#define AN7583_MDC_0_PU_MASK		BIT(4)
+#define UART1_RXD_PU_MASK		BIT(3)
+#define UART1_TXD_PU_MASK		BIT(2)
+#define I2C_SCL_PU_MASK			BIT(1)
+#define I2C_SDA_PU_MASK			BIT(0)
+
+#define REG_I2C_SDA_PD			0x0048
+#define AN7583_I2C1_SDA_PD_MASK		BIT(16)
+#define AN7583_I2C1_SCL_PD_MASK		BIT(15)
+#define SPI_MISO_PD_MASK		BIT(14)
+#define SPI_MOSI_PD_MASK		BIT(13)
+#define SPI_CLK_PD_MASK			BIT(12)
+#define SPI_CS0_PD_MASK			BIT(11)
+#define EN7523_SPI_MISO_PD_MASK		BIT(13)
+#define EN7523_SPI_MOSI_PD_MASK		BIT(12)
+#define EN7523_SPI_CLK_PD_MASK		BIT(11)
+#define EN7523_SPI_CS0_PD_MASK		BIT(10)
+#define PCIE2_RESET_PD_MASK		BIT(10)
+#define PCIE1_RESET_PD_MASK		BIT(9)
+#define PCIE0_RESET_PD_MASK		BIT(8)
+#define AN7583_MDIO_0_PD_MASK		BIT(5)
+#define AN7583_MDC_0_PD_MASK		BIT(4)
+#define UART1_RXD_PD_MASK		BIT(3)
+#define UART1_TXD_PD_MASK		BIT(2)
+#define I2C_SCL_PD_MASK			BIT(1)
+#define I2C_SDA_PD_MASK			BIT(0)
+
+#define REG_GPIO_L_PU			0x004c
+#define REG_GPIO_L_PD			0x0050
+#define REG_GPIO_H_PU			0x0054
+#define REG_GPIO_H_PD			0x0058
+
+#define REG_PCIE_RESET_OD		0x018c
+#define PCIE2_RESET_OD_MASK		BIT(2)
+#define PCIE1_RESET_OD_MASK		BIT(1)
+#define PCIE0_RESET_OD_MASK		BIT(0)
+
+/* GPIOs */
+#define REG_GPIO_CTRL		0x0000
+#define REG_GPIO_DATA		0x0004
+#define REG_GPIO_INT		0x0008
+#define REG_GPIO_INT_EDGE	0x000c
+#define REG_GPIO_INT_LEVEL	0x0010
+#define REG_GPIO_OE		0x0014
+#define REG_GPIO_CTRL1		0x0020
+
+/* PWM MODE CONF */
+#define REG_GPIO_FLASH_MODE_CFG		0x0034
+#define GPIO15_FLASH_MODE_CFG		BIT(15)
+#define GPIO14_FLASH_MODE_CFG		BIT(14)
+#define GPIO13_FLASH_MODE_CFG		BIT(13)
+#define GPIO12_FLASH_MODE_CFG		BIT(12)
+#define GPIO11_FLASH_MODE_CFG		BIT(11)
+#define GPIO10_FLASH_MODE_CFG		BIT(10)
+#define GPIO9_FLASH_MODE_CFG		BIT(9)
+#define GPIO8_FLASH_MODE_CFG		BIT(8)
+#define GPIO7_FLASH_MODE_CFG		BIT(7)
+#define GPIO6_FLASH_MODE_CFG		BIT(6)
+#define GPIO5_FLASH_MODE_CFG		BIT(5)
+#define GPIO4_FLASH_MODE_CFG		BIT(4)
+#define GPIO3_FLASH_MODE_CFG		BIT(3)
+#define GPIO2_FLASH_MODE_CFG		BIT(2)
+#define GPIO1_FLASH_MODE_CFG		BIT(1)
+#define GPIO0_FLASH_MODE_CFG		BIT(0)
+
+#define REG_GPIO_CTRL2	0x0060
+#define REG_GPIO_CTRL3	0x0064
+
+/* PWM MODE CONF EXT */
+#define REG_GPIO_FLASH_MODE_CFG_EXT	0x0068
+#define GPIO51_FLASH_MODE_CFG		BIT(31)
+#define GPIO50_FLASH_MODE_CFG		BIT(30)
+#define GPIO49_FLASH_MODE_CFG		BIT(29)
+#define GPIO48_FLASH_MODE_CFG		BIT(28)
+#define GPIO47_FLASH_MODE_CFG		BIT(27)
+#define GPIO46_FLASH_MODE_CFG		BIT(26)
+#define GPIO45_FLASH_MODE_CFG		BIT(25)
+#define GPIO44_FLASH_MODE_CFG		BIT(24)
+#define GPIO43_FLASH_MODE_CFG		BIT(23)
+#define GPIO42_FLASH_MODE_CFG		BIT(22)
+#define GPIO41_FLASH_MODE_CFG		BIT(21)
+#define GPIO40_FLASH_MODE_CFG		BIT(20)
+#define GPIO39_FLASH_MODE_CFG		BIT(19)
+#define GPIO38_FLASH_MODE_CFG		BIT(18)
+#define GPIO37_FLASH_MODE_CFG		BIT(17)
+#define GPIO36_FLASH_MODE_CFG		BIT(16)
+#define GPIO31_FLASH_MODE_CFG		BIT(15)
+#define GPIO30_FLASH_MODE_CFG		BIT(14)
+#define GPIO29_FLASH_MODE_CFG		BIT(13)
+#define GPIO28_FLASH_MODE_CFG		BIT(12)
+#define GPIO27_FLASH_MODE_CFG		BIT(11)
+#define GPIO26_FLASH_MODE_CFG		BIT(10)
+#define GPIO25_FLASH_MODE_CFG		BIT(9)
+#define GPIO24_FLASH_MODE_CFG		BIT(8)
+#define GPIO23_FLASH_MODE_CFG		BIT(7)
+#define GPIO22_FLASH_MODE_CFG		BIT(6)
+#define GPIO21_FLASH_MODE_CFG		BIT(5)
+#define GPIO20_FLASH_MODE_CFG		BIT(4)
+#define GPIO19_FLASH_MODE_CFG		BIT(3)
+#define GPIO18_FLASH_MODE_CFG		BIT(2)
+#define GPIO17_FLASH_MODE_CFG		BIT(1)
+#define GPIO16_FLASH_MODE_CFG		BIT(0)
+
+#define REG_GPIO_DATA1			0x0070
+#define REG_GPIO_OE1			0x0078
+#define REG_GPIO_INT1			0x007c
+#define REG_GPIO_INT_EDGE1		0x0080
+#define REG_GPIO_INT_EDGE2		0x0084
+#define REG_GPIO_INT_EDGE3		0x0088
+#define REG_GPIO_INT_LEVEL1		0x008c
+#define REG_GPIO_INT_LEVEL2		0x0090
+#define REG_GPIO_INT_LEVEL3		0x0094
+
+#define AIROHA_NUM_PINS			64
+#define AIROHA_PIN_BANK_SIZE		(AIROHA_NUM_PINS / 2)
+#define AIROHA_REG_GPIOCTRL_NUM_PIN	(AIROHA_NUM_PINS / 4)
+
+/* PWM */
+#define AIROHA_PINCTRL_PWM(gpio, mux_val)		\
+	{						\
+		.name = (gpio),				\
+		.regmap[0] = {				\
+			AIROHA_FUNC_PWM_MUX,		\
+			REG_GPIO_FLASH_MODE_CFG,	\
+			(mux_val),			\
+			(mux_val)			\
+		},					\
+		.regmap_size = 1,			\
+	}						\
+
+#define AIROHA_PINCTRL_PWM_EXT(gpio, mux_val)		\
+	{						\
+		.name = (gpio),				\
+		.regmap[0] = {				\
+			AIROHA_FUNC_PWM_EXT_MUX,	\
+			REG_GPIO_FLASH_MODE_CFG_EXT,	\
+			(mux_val),			\
+			(mux_val)			\
+		},					\
+		.regmap_size = 1,			\
+	}						\
+
+#define AIROHA_PINCTRL_PHY_LED0(variant, gpio, mux_val, map_mask, map_val)	\
+	{								\
+		.name = (gpio),						\
+		.regmap[0] = {						\
+			AIROHA_FUNC_MUX,				\
+			variant##_REG_GPIO_2ND_I2C_MODE,				\
+			(mux_val),					\
+			(mux_val),					\
+		},							\
+		.regmap[1] = {						\
+			AIROHA_FUNC_MUX,				\
+			REG_LAN_LED0_MAPPING,				\
+			(map_mask),					\
+			(map_val),					\
+		},							\
+		.regmap_size = 2,					\
+	}
+
+#define AIROHA_PINCTRL_PHY_LED1(variant, gpio, mux_val, map_mask, map_val)	\
+	{								\
+		.name = (gpio),						\
+		.regmap[0] = {						\
+			AIROHA_FUNC_MUX,				\
+			variant##_REG_GPIO_2ND_I2C_MODE,				\
+			(mux_val),					\
+			(mux_val),					\
+		},							\
+		.regmap[1] = {						\
+			AIROHA_FUNC_MUX,				\
+			REG_LAN_LED1_MAPPING,				\
+			(map_mask),					\
+			(map_val),					\
+		},							\
+		.regmap_size = 2,					\
+	}
+
+#define airoha_pinctrl_get_pullup_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_get_conf((pinctrl), AIROHA_PINCTRL_CONFS_PULLUP,		\
+				(pin), (val))
+#define airoha_pinctrl_get_pulldown_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_get_conf((pinctrl), AIROHA_PINCTRL_CONFS_PULLDOWN,	\
+				(pin), (val))
+#define airoha_pinctrl_get_drive_e2_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_get_conf((pinctrl), AIROHA_PINCTRL_CONFS_DRIVE_E2,	\
+				(pin), (val))
+#define airoha_pinctrl_get_drive_e4_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_get_conf((pinctrl), AIROHA_PINCTRL_CONFS_DRIVE_E4,	\
+				(pin), (val))
+#define airoha_pinctrl_get_pcie_rst_od_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_get_conf((pinctrl), AIROHA_PINCTRL_CONFS_PCIE_RST_OD,	\
+				(pin), (val))
+#define airoha_pinctrl_set_pullup_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_set_conf((pinctrl), AIROHA_PINCTRL_CONFS_PULLUP,		\
+				(pin), (val))
+#define airoha_pinctrl_set_pulldown_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_set_conf((pinctrl), AIROHA_PINCTRL_CONFS_PULLDOWN,	\
+				(pin), (val))
+#define airoha_pinctrl_set_drive_e2_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_set_conf((pinctrl), AIROHA_PINCTRL_CONFS_DRIVE_E2,	\
+				(pin), (val))
+#define airoha_pinctrl_set_drive_e4_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_set_conf((pinctrl), AIROHA_PINCTRL_CONFS_DRIVE_E4,	\
+				(pin), (val))
+#define airoha_pinctrl_set_pcie_rst_od_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_set_conf((pinctrl), AIROHA_PINCTRL_CONFS_PCIE_RST_OD,	\
+				(pin), (val))
+
+static const u32 gpio_data_regs[] = {
+	REG_GPIO_DATA,
+	REG_GPIO_DATA1
+};
+
+static const u32 gpio_out_regs[] = {
+	REG_GPIO_OE,
+	REG_GPIO_OE1
+};
+
+static const u32 gpio_dir_regs[] = {
+	REG_GPIO_CTRL,
+	REG_GPIO_CTRL1,
+	REG_GPIO_CTRL2,
+	REG_GPIO_CTRL3
+};
+
+static const u32 irq_status_regs[] = {
+	REG_GPIO_INT,
+	REG_GPIO_INT1
+};
+
+static const u32 irq_level_regs[] = {
+	REG_GPIO_INT_LEVEL,
+	REG_GPIO_INT_LEVEL1,
+	REG_GPIO_INT_LEVEL2,
+	REG_GPIO_INT_LEVEL3
+};
+
+static const u32 irq_edge_regs[] = {
+	REG_GPIO_INT_EDGE,
+	REG_GPIO_INT_EDGE1,
+	REG_GPIO_INT_EDGE2,
+	REG_GPIO_INT_EDGE3
+};
+
+struct airoha_pinctrl_reg {
+	u32 offset;
+	u32 mask;
+};
+
+enum airoha_pinctrl_mux_func {
+	AIROHA_FUNC_MUX,
+	AIROHA_FUNC_PWM_MUX,
+	AIROHA_FUNC_PWM_EXT_MUX,
+};
+
+struct airoha_pinctrl_func_group {
+	const char *name;
+	struct {
+		enum airoha_pinctrl_mux_func mux;
+		u32 offset;
+		u32 mask;
+		u32 val;
+	} regmap[2];
+	int regmap_size;
+};
+
+struct airoha_pinctrl_func {
+	const struct pinfunction desc;
+	const struct airoha_pinctrl_func_group *groups;
+	u8 group_size;
+};
+
+struct airoha_pinctrl_conf {
+	u32 pin;
+	struct airoha_pinctrl_reg reg;
+};
+
+struct airoha_pinctrl_gpiochip {
+	struct udevice *dev;
+
+	/* gpio */
+	const u32 *data;
+	const u32 *dir;
+	const u32 *out;
+	/* irq */
+	const u32 *status;
+	const u32 *level;
+	const u32 *edge;
+
+	u32 irq_type[AIROHA_NUM_PINS];
+};
+
+struct airoha_pinctrl_confs_info {
+	const struct airoha_pinctrl_conf *confs;
+	unsigned int num_confs;
+};
+
+enum airoha_pinctrl_confs_type {
+	AIROHA_PINCTRL_CONFS_PULLUP,
+	AIROHA_PINCTRL_CONFS_PULLDOWN,
+	AIROHA_PINCTRL_CONFS_DRIVE_E2,
+	AIROHA_PINCTRL_CONFS_DRIVE_E4,
+	AIROHA_PINCTRL_CONFS_PCIE_RST_OD,
+
+	AIROHA_PINCTRL_CONFS_MAX,
+};
+
+struct airoha_pinctrl {
+	struct udevice *dev;
+	struct airoha_pinctrl_match_data *data;
+
+	struct regmap *chip_scu;
+	struct regmap *regmap;
+
+	struct airoha_pinctrl_gpiochip gpiochip;
+};
+
+struct airoha_pinctrl_match_data {
+	const int gpio_offs;
+	const int gpio_pin_cnt;
+	const struct pinctrl_pin_desc *pins;
+	const unsigned int num_pins;
+	const struct pingroup *grps;
+	const unsigned int num_grps;
+	const struct airoha_pinctrl_func *funcs;
+	const unsigned int num_funcs;
+	const struct airoha_pinctrl_confs_info confs_info[AIROHA_PINCTRL_CONFS_MAX];
+};
+
+extern const struct pinctrl_ops airoha_pinctrl_ops;
+
+int airoha_pinctrl_probe(struct udevice *dev);
+int airoha_pinctrl_bind(struct udevice *dev);
+
+#endif
diff --git a/drivers/pinctrl/airoha/pinctrl-airoha.c b/drivers/pinctrl/airoha/pinctrl-airoha.c
new file mode 100644
index 00000000000..c8a22792d51
--- /dev/null
+++ b/drivers/pinctrl/airoha/pinctrl-airoha.c
@@ -0,0 +1,691 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
+ * Author: Markus Gothe <markus.gothe@genexis.eu>
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <dm/ofnode.h>
+#include <asm-generic/gpio.h>
+#include <dt-bindings/pinctrl/mt65xx.h>
+#include <regmap.h>
+
+#include <syscon.h>
+#include <asm/arch/scu-regmap.h>
+
+#include "airoha-common.h"
+
+//#define PINCTRL_GET_STATE
+
+static int pin_to_gpio(struct airoha_pinctrl *pinctrl, unsigned int pin)
+{
+	struct airoha_pinctrl_match_data *data = pinctrl->data;
+
+	if ((pin < data->gpio_offs) ||
+	    (pin >= data->gpio_offs + data->gpio_pin_cnt))
+		return -EINVAL;
+
+	return pin - data->gpio_offs;
+}
+
+/* gpio callbacks */
+static int airoha_gpio_set(struct udevice *dev, unsigned int gpio,
+			   int value)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev->parent);
+	u32 offset = gpio % AIROHA_PIN_BANK_SIZE;
+	u8 index = gpio / AIROHA_PIN_BANK_SIZE;
+
+	return regmap_update_bits(pinctrl->regmap,
+				  pinctrl->gpiochip.data[index],
+				  BIT(offset), value ? BIT(offset) : 0);
+}
+
+static int airoha_gpio_get(struct udevice *dev, unsigned int gpio)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev->parent);
+	u32 val, pin = gpio % AIROHA_PIN_BANK_SIZE;
+	u8 index = gpio / AIROHA_PIN_BANK_SIZE;
+	int err;
+
+	err = regmap_read(pinctrl->regmap,
+			  pinctrl->gpiochip.data[index], &val);
+
+	return err ? err : !!(val & BIT(pin));
+}
+
+static int airoha_gpio_get_direction(struct udevice *dev, unsigned int gpio)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev->parent);
+	u32 mask, index, val;
+	int err, field_shift;
+
+	field_shift = 2 * (gpio % AIROHA_REG_GPIOCTRL_NUM_PIN);
+	mask = GENMASK(field_shift + 1, field_shift);
+	index = gpio / AIROHA_REG_GPIOCTRL_NUM_PIN;
+
+	err = regmap_read(pinctrl->regmap,
+			  pinctrl->gpiochip.dir[index], &val);
+	if (err)
+		return err;
+
+	if ((val & mask) > BIT(field_shift))
+		return -EINVAL;
+
+	return (val & mask) ? GPIOF_OUTPUT : GPIOF_INPUT;
+}
+
+static int airoha_gpio_set_direction(struct udevice *dev,
+				     unsigned int gpio, bool input)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev->parent);
+	u32 mask, index;
+	int err, field_shift;
+
+	/* set output enable */
+	mask = BIT(gpio % AIROHA_PIN_BANK_SIZE);
+	index = gpio / AIROHA_PIN_BANK_SIZE;
+	err = regmap_update_bits(pinctrl->regmap, pinctrl->gpiochip.out[index],
+				 mask, !input ? mask : 0);
+	if (err)
+		return err;
+
+	/* set direction */
+	field_shift = 2 * (gpio % AIROHA_REG_GPIOCTRL_NUM_PIN);
+	mask = GENMASK(field_shift + 1, field_shift);
+	index = gpio / AIROHA_REG_GPIOCTRL_NUM_PIN;
+
+	return regmap_update_bits(pinctrl->regmap,
+				  pinctrl->gpiochip.dir[index],
+				  mask, !input ? BIT(field_shift) : 0);
+}
+
+static int airoha_gpio_direction_input(struct udevice *dev, unsigned int gpio)
+{
+	return airoha_gpio_set_direction(dev, gpio, true);
+}
+
+static int airoha_gpio_direction_output(struct udevice *dev, unsigned int gpio,
+					int val)
+{
+	int err;
+
+	err = airoha_gpio_set_direction(dev, gpio, false);
+	if (err)
+		return err;
+
+	return airoha_gpio_set(dev, gpio, val);
+}
+
+static int airoha_pinctrl_gpio_probe(struct udevice *dev)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev->parent);
+	struct gpio_dev_priv *uc_priv;
+
+	uc_priv = dev_get_uclass_priv(dev);
+	uc_priv->bank_name = "airoha";
+	uc_priv->gpio_count = pinctrl->data->gpio_pin_cnt;
+
+	return 0;
+}
+
+static int airoha_pinctrl_gpio_bind(struct udevice *dev)
+{
+	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
+	return 0;
+}
+
+static const struct dm_gpio_ops airoha_pinctrl_gpio_ops = {
+	.set_value = airoha_gpio_set,
+	.get_value = airoha_gpio_get,
+	.get_function = airoha_gpio_get_direction,
+	.direction_input = airoha_gpio_direction_input,
+	.direction_output = airoha_gpio_direction_output,
+};
+
+static struct driver airoha_pinctrl_gpio_driver = {
+	.name = "airoha_pinctrl_gpio",
+	.id = UCLASS_GPIO,
+	.probe = airoha_pinctrl_gpio_probe,
+	.bind = airoha_pinctrl_gpio_bind,
+	.ops = &airoha_pinctrl_gpio_ops,
+};
+
+static int airoha_gpiochip_register(struct udevice *parent)
+{
+	struct airoha_pinctrl *pinctrl;
+	struct uclass_driver *drv;
+	struct udevice *dev;
+	int ret;
+	ofnode node;
+
+	drv = lists_uclass_lookup(UCLASS_GPIO);
+	if (!drv)
+		return -ENOENT;
+
+	/*
+	 * Support upstream linux DTSI that define gpio-controller
+	 * in the root node (instead of a dedicated subnode)
+	 */
+	if (dev_read_bool(parent, "gpio-controller")) {
+		node = dev_ofnode(parent);
+		goto bind;
+	}
+
+	ret = -ENOENT;
+	dev_for_each_subnode(node, parent)
+		if (ofnode_read_bool(node, "gpio-controller")) {
+			ret = 0;
+			break;
+		}
+
+	if (ret)
+		return ret;
+
+bind:
+	ret = device_bind_with_driver_data(parent, &airoha_pinctrl_gpio_driver,
+					   "airoha_pinctrl_gpio", 0, node,
+					   &dev);
+	if (ret)
+		return ret;
+
+	pinctrl = dev_get_priv(parent);
+	pinctrl->gpiochip.dev = dev;
+
+	return 0;
+}
+
+/* pinmux callbacks */
+static int airoha_pinmux_set_mux(struct airoha_pinctrl *pinctrl,
+				 unsigned int selector,
+				 unsigned int group)
+{
+	const struct airoha_pinctrl_func *func;
+	const struct pingroup *grp;
+	int i;
+
+	func = &pinctrl->data->funcs[selector];
+	grp = &pinctrl->data->grps[group];
+
+	dev_dbg(pinctrl->dev, "enable function %s group %s\n",
+		func->desc.name, grp->name);
+
+	for (i = 0; i < func->group_size; i++) {
+		const struct airoha_pinctrl_func_group *group;
+		int j;
+
+		group = &func->groups[i];
+		if (strcmp(group->name, grp->name))
+			continue;
+
+		for (j = 0; j < group->regmap_size; j++) {
+			switch (group->regmap[j].mux) {
+			case AIROHA_FUNC_PWM_EXT_MUX:
+			case AIROHA_FUNC_PWM_MUX:
+				regmap_update_bits(pinctrl->regmap,
+						   group->regmap[j].offset,
+						   group->regmap[j].mask,
+						   group->regmap[j].val);
+				break;
+			default:
+				regmap_update_bits(pinctrl->chip_scu,
+						   group->regmap[j].offset,
+						   group->regmap[j].mask,
+						   group->regmap[j].val);
+				break;
+			}
+		}
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int airoha_pinmux_set_direction(struct airoha_pinctrl *pinctrl,
+				       unsigned int p, bool input)
+{
+	int gpio;
+
+	gpio = pin_to_gpio(pinctrl, p);
+	if (gpio < 0)
+		return gpio;
+
+	return airoha_gpio_set_direction(pinctrl->gpiochip.dev, gpio, input);
+}
+
+/* pinconf callbacks */
+static const struct airoha_pinctrl_reg *
+airoha_pinctrl_get_conf_reg(const struct airoha_pinctrl_conf *conf,
+			    int conf_size, int pin)
+{
+	int i;
+
+	for (i = 0; i < conf_size; i++) {
+		if (conf[i].pin == pin)
+			return &conf[i].reg;
+	}
+
+	return NULL;
+}
+
+#if defined(PINCTRL_GET_STATE)
+static int airoha_pinctrl_get_conf(struct airoha_pinctrl *pinctrl,
+				   enum airoha_pinctrl_confs_type conf_type,
+				   int pin, u32 *val)
+{
+	const struct airoha_pinctrl_confs_info *confs_info;
+	const struct airoha_pinctrl_reg *reg;
+
+	confs_info = &pinctrl->data->confs_info[conf_type];
+
+	reg = airoha_pinctrl_get_conf_reg(confs_info->confs,
+					  confs_info->num_confs,
+					  pin);
+	if (!reg)
+		return -EINVAL;
+
+	if (regmap_read(pinctrl->chip_scu, reg->offset, val))
+		return -EINVAL;
+
+	*val = (*val & reg->mask) >> __ffs(reg->mask);
+
+	return 0;
+}
+#endif
+
+static int airoha_pinctrl_set_conf(struct airoha_pinctrl *pinctrl,
+				   enum airoha_pinctrl_confs_type conf_type,
+				   int pin, u32 val)
+{
+	const struct airoha_pinctrl_confs_info *confs_info;
+	const struct airoha_pinctrl_reg *reg = NULL;
+
+	confs_info = &pinctrl->data->confs_info[conf_type];
+
+	reg = airoha_pinctrl_get_conf_reg(confs_info->confs,
+					  confs_info->num_confs,
+					  pin);
+	if (!reg)
+		return -EINVAL;
+
+	if (regmap_update_bits(pinctrl->chip_scu, reg->offset, reg->mask,
+			       val << __ffs(reg->mask)))
+		return -EINVAL;
+
+	return 0;
+}
+
+#if defined(PINCTRL_GET_STATE)
+static int airoha_pinconf_get_direction(struct airoha_pinctrl *pinctrl, u32 p)
+{
+	int gpio;
+
+	gpio = pin_to_gpio(pinctrl, p);
+	if (gpio < 0)
+		return gpio;
+
+	return airoha_gpio_get_direction(pinctrl->gpiochip.dev, gpio);
+}
+
+static int airoha_pinconf_get(struct airoha_pinctrl *pinctrl,
+			      unsigned int pin, unsigned long *config)
+{
+	enum pin_config_param param = pinconf_to_config_param(*config);
+	u32 arg;
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+	case PIN_CONFIG_BIAS_DISABLE:
+	case PIN_CONFIG_BIAS_PULL_UP: {
+		u32 pull_up, pull_down;
+
+		if (airoha_pinctrl_get_pullup_conf(pinctrl, pin, &pull_up) ||
+		    airoha_pinctrl_get_pulldown_conf(pinctrl, pin, &pull_down))
+			return -EINVAL;
+
+		if (param == PIN_CONFIG_BIAS_PULL_UP &&
+		    !(pull_up && !pull_down))
+			return -EINVAL;
+		else if (param == PIN_CONFIG_BIAS_PULL_DOWN &&
+			 !(pull_down && !pull_up))
+			return -EINVAL;
+		else if (pull_up || pull_down)
+			return -EINVAL;
+
+		arg = 1;
+		break;
+	}
+	case PIN_CONFIG_DRIVE_STRENGTH: {
+		u32 e2, e4;
+
+		if (airoha_pinctrl_get_drive_e2_conf(pinctrl, pin, &e2) ||
+		    airoha_pinctrl_get_drive_e4_conf(pinctrl, pin, &e4))
+			return -EINVAL;
+
+		arg = e4 << 1 | e2;
+		break;
+	}
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		if (airoha_pinctrl_get_pcie_rst_od_conf(pinctrl, pin, &arg))
+			return -EINVAL;
+		break;
+	case PIN_CONFIG_OUTPUT_ENABLE:
+	case PIN_CONFIG_INPUT_ENABLE:
+		arg = airoha_pinconf_get_direction(pinctrl, pin);
+		if (arg != param)
+			return -EINVAL;
+
+		arg = 1;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+
+	return 0;
+}
+#endif
+
+static int airoha_pinconf_set_pin_value(struct airoha_pinctrl *pinctrl,
+					unsigned int p, bool value)
+{
+	int gpio;
+
+	gpio = pin_to_gpio(pinctrl, p);
+	if (gpio < 0)
+		return gpio;
+
+	return airoha_gpio_set(pinctrl->gpiochip.dev, gpio, value);
+}
+
+static int airoha_pinconf_set(struct airoha_pinctrl *pinctrl,
+			      unsigned int pin, unsigned long *configs,
+			      unsigned int num_configs)
+{
+	int i;
+
+	for (i = 0; i < num_configs; i++) {
+		u32 param = pinconf_to_config_param(configs[i]);
+		u32 arg = pinconf_to_config_argument(configs[i]);
+
+		switch (param) {
+		case PIN_CONFIG_BIAS_DISABLE:
+			airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 0);
+			airoha_pinctrl_set_pullup_conf(pinctrl, pin, 0);
+			break;
+		case PIN_CONFIG_BIAS_PULL_UP:
+			airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 0);
+			airoha_pinctrl_set_pullup_conf(pinctrl, pin, 1);
+			break;
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 1);
+			airoha_pinctrl_set_pullup_conf(pinctrl, pin, 0);
+			break;
+		case PIN_CONFIG_DRIVE_STRENGTH: {
+			u32 e2 = 0, e4 = 0;
+
+			switch (arg) {
+			case MTK_DRIVE_2mA:
+				break;
+			case MTK_DRIVE_4mA:
+				e2 = 1;
+				break;
+			case MTK_DRIVE_6mA:
+				e4 = 1;
+				break;
+			case MTK_DRIVE_8mA:
+				e2 = 1;
+				e4 = 1;
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			airoha_pinctrl_set_drive_e2_conf(pinctrl, pin, e2);
+			airoha_pinctrl_set_drive_e4_conf(pinctrl, pin, e4);
+			break;
+		}
+		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+			airoha_pinctrl_set_pcie_rst_od_conf(pinctrl, pin, !!arg);
+			break;
+		case PIN_CONFIG_OUTPUT_ENABLE:
+		case PIN_CONFIG_INPUT_ENABLE:
+		case PIN_CONFIG_OUTPUT: {
+			bool input = param == PIN_CONFIG_INPUT_ENABLE;
+			int err;
+
+			err = airoha_pinmux_set_direction(pinctrl, pin, input);
+			if (err)
+				return err;
+
+			if (param == PIN_CONFIG_OUTPUT) {
+				err = airoha_pinconf_set_pin_value(pinctrl,
+								   pin, !!arg);
+				if (err)
+					return err;
+			}
+
+			break;
+		}
+		default:
+			return -ENOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
+#if defined(PINCTRL_GET_STATE)
+static int airoha_pinconf_group_get(struct airoha_pinctrl *pinctrl,
+				    unsigned int group, unsigned long *config)
+{
+	u32 cur_config = 0;
+	int i;
+
+	for (i = 0; i < pinctrl->data->grps[group].npins; i++) {
+		if (airoha_pinconf_get(pinctrl,
+				       pinctrl->data->grps[group].pins[i],
+				       config))
+			return -ENOTSUPP;
+
+		if (i && cur_config != *config)
+			return -ENOTSUPP;
+
+		cur_config = *config;
+	}
+
+	return 0;
+}
+#endif
+
+static int airoha_pinconf_group_set(struct airoha_pinctrl *pinctrl,
+				    unsigned int group, unsigned long *configs,
+				    unsigned int num_configs)
+{
+	int i;
+
+	for (i = 0; i < pinctrl->data->grps[group].npins; i++) {
+		int err;
+
+		err = airoha_pinconf_set(pinctrl,
+					 pinctrl->data->grps[group].pins[i],
+					 configs, num_configs);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int airoha_get_pins_count(struct udevice *dev)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->num_pins;
+}
+
+static const char *airoha_get_pin_name(struct udevice *dev, unsigned selector)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->pins[selector].name;
+}
+
+static int airoha_get_groups_count(struct udevice *dev)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->num_grps;
+}
+
+static const char *airoha_get_group_name(struct udevice *dev, unsigned selector)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->grps[selector].name;
+}
+
+static int airoha_get_funcs_count(struct udevice *dev)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->num_funcs;
+}
+
+static const char *airoha_get_func_name(struct udevice *dev, unsigned selector)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->funcs[selector].desc.name;
+}
+
+static int airoha_pinmux_group_set(struct udevice *dev, unsigned group_selector,
+				   unsigned func_selector)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	dev_info(dev, "enabling %s function for pin group %s\n",
+		airoha_get_func_name(dev, func_selector),
+		airoha_get_group_name(dev, group_selector));
+
+	return airoha_pinmux_set_mux(pinctrl, func_selector, group_selector);
+}
+
+static int airoha_pinmux_set(struct udevice *dev, unsigned pin_selector,
+			     unsigned func_selector)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+	const struct airoha_pinctrl_match_data *data = pinctrl->data;
+	const char *pin_name;
+	unsigned selector;
+
+	pin_name = data->pins[pin_selector].name;
+
+	/* find group matching the pin_name */
+	for (selector = 0; selector < data->num_grps; selector++) {
+		if (!strcmp(pin_name, data->grps[selector].name))
+			return airoha_pinmux_group_set(dev, selector,
+						       func_selector);
+	}
+
+	return -ENOENT;
+}
+
+static const struct pinconf_param airoha_pinconf_params[] = {
+	{ "bias-disable",     PIN_CONFIG_BIAS_DISABLE,     0 },
+	{ "bias-pull-up",     PIN_CONFIG_BIAS_PULL_UP,     1 },
+	{ "bias-pull-down",   PIN_CONFIG_BIAS_PULL_DOWN,   1 },
+	{ "drive-strength",   PIN_CONFIG_DRIVE_STRENGTH,   0 },
+	{ "drive-open-drain", PIN_CONFIG_DRIVE_OPEN_DRAIN, 0 },
+	{ "output-enable",    PIN_CONFIG_OUTPUT_ENABLE,    1 },
+	{ "input-enable",     PIN_CONFIG_INPUT_ENABLE,     1 },
+};
+
+static int airoha_pinconf_set_handler(struct udevice *dev, unsigned pin_selector,
+				      unsigned param, unsigned argument)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+	unsigned long configs[1] = { param };
+	unsigned int pin = pinctrl->data->pins[pin_selector].number;
+
+	dev_info(dev, "enabling %s=%d property for pin %s\n",
+		airoha_pinconf_params[param].property, argument,
+		airoha_get_pin_name(dev, pin_selector));
+
+	return airoha_pinconf_set(pinctrl, pin, configs, 1);
+}
+
+static int airoha_pinconf_group_set_handler(struct udevice *dev, unsigned group_selector,
+					    unsigned param, unsigned argument)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+	unsigned long configs[1] = { param };
+
+	dev_info(dev, "enabling %s=%d property for pin group %s\n",
+		airoha_pinconf_params[param].property, argument,
+		airoha_get_group_name(dev, group_selector));
+
+	return airoha_pinconf_group_set(pinctrl, group_selector, configs, 1);
+}
+
+const struct pinctrl_ops airoha_pinctrl_ops = {
+	.get_pins_count		= airoha_get_pins_count,
+	.get_pin_name		= airoha_get_pin_name,
+	.get_groups_count	= airoha_get_groups_count,
+	.get_group_name		= airoha_get_group_name,
+	.get_functions_count	= airoha_get_funcs_count,
+	.get_function_name	= airoha_get_func_name,
+	.pinmux_set		= airoha_pinmux_set,
+	.pinmux_group_set	= airoha_pinmux_group_set,
+
+	.pinconf_num_params	= ARRAY_SIZE(airoha_pinconf_params),
+	.pinconf_params		= airoha_pinconf_params,
+	.pinconf_set		= airoha_pinconf_set_handler,
+	.pinconf_group_set	= airoha_pinconf_group_set_handler,
+
+	.set_state		= pinctrl_generic_set_state,
+};
+
+int airoha_pinctrl_probe(struct udevice *dev)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	pinctrl->dev = dev;
+	pinctrl->data = (struct airoha_pinctrl_match_data *)dev_get_driver_data(dev);
+
+	pinctrl->regmap = syscon_node_to_regmap(dev_ofnode(dev->parent));
+	if (IS_ERR(pinctrl->regmap))
+		return PTR_ERR(pinctrl->regmap);
+
+	pinctrl->chip_scu = airoha_get_chip_scu_regmap();
+	if (IS_ERR(pinctrl->chip_scu))
+		return PTR_ERR(pinctrl->chip_scu);
+
+	pinctrl->gpiochip.data   = gpio_data_regs;
+	pinctrl->gpiochip.dir    = gpio_dir_regs;
+	pinctrl->gpiochip.out    = gpio_out_regs;
+	pinctrl->gpiochip.status = irq_status_regs;
+	pinctrl->gpiochip.level  = irq_level_regs;
+	pinctrl->gpiochip.edge   = irq_edge_regs;
+
+	return 0;
+}
+
+int airoha_pinctrl_bind(struct udevice *dev)
+{
+	/*
+	 * Make sure that the pinctrl driver gets probed after binding
+	 * as on EN7523/AN7581/AN7583 the pinctrl driver is the one that
+	 * is also registering the GPIO one during probe, so if its not
+	 * probed GPIO-s are not registered as well.
+	 */
+	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
+	return airoha_gpiochip_register(dev);
+}
diff --git a/drivers/pinctrl/airoha/pinctrl-an7581.c b/drivers/pinctrl/airoha/pinctrl-an7581.c
new file mode 100644
index 00000000000..c70952e9ba8
--- /dev/null
+++ b/drivers/pinctrl/airoha/pinctrl-an7581.c
@@ -0,0 +1,1060 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
+ * Author: Markus Gothe <markus.gothe@genexis.eu>
+ */
+#include "airoha-common.h"
+
+static const int en7581_pon_pins[] = { 49, 50, 51, 52, 53, 54 };
+static const int en7581_pon_tod_1pps_pins[] = { 46 };
+static const int en7581_gsw_tod_1pps_pins[] = { 46 };
+static const int en7581_sipo_pins[] = { 16, 17 };
+static const int en7581_sipo_rclk_pins[] = { 16, 17, 43 };
+static const int en7581_mdio_pins[] = { 14, 15 };
+static const int en7581_uart2_pins[] = { 48, 55 };
+static const int en7581_uart2_cts_rts_pins[] = { 46, 47 };
+static const int en7581_hsuart_pins[] = { 28, 29 };
+static const int en7581_hsuart_cts_rts_pins[] = { 26, 27 };
+static const int en7581_uart4_pins[] = { 38, 39 };
+static const int en7581_uart5_pins[] = { 18, 19 };
+static const int en7581_i2c0_pins[] = { 2, 3 };
+static const int en7581_i2c1_pins[] = { 14, 15 };
+static const int en7581_jtag_udi_pins[] = { 16, 17, 18, 19, 20 };
+static const int en7581_jtag_dfd_pins[] = { 16, 17, 18, 19, 20 };
+static const int en7581_i2s_pins[] = { 26, 27, 28, 29 };
+static const int en7581_pcm1_pins[] = { 22, 23, 24, 25 };
+static const int en7581_pcm2_pins[] = { 18, 19, 20, 21 };
+static const int en7581_spi_quad_pins[] = { 32, 33 };
+static const int en7581_spi_pins[] = { 4, 5, 6, 7 };
+static const int en7581_spi_cs1_pins[] = { 34 };
+static const int en7581_pcm_spi_pins[] = { 18, 19, 20, 21, 22, 23, 24, 25 };
+static const int en7581_pcm_spi_int_pins[] = { 14 };
+static const int en7581_pcm_spi_rst_pins[] = { 15 };
+static const int en7581_pcm_spi_cs1_pins[] = { 43 };
+static const int en7581_pcm_spi_cs2_pins[] = { 40 };
+static const int en7581_pcm_spi_cs2_p128_pins[] = { 40 };
+static const int en7581_pcm_spi_cs2_p156_pins[] = { 40 };
+static const int en7581_pcm_spi_cs3_pins[] = { 41 };
+static const int en7581_pcm_spi_cs4_pins[] = { 42 };
+static const int en7581_emmc_pins[] = {
+	4, 5, 6, 30, 31, 32, 33, 34, 35, 36, 37
+};
+static const int en7581_pnand_pins[] = { 4,  5,	 6,  7,	 30, 31, 32, 33, 34,
+					 35, 36, 37, 38, 39, 40, 41, 42 };
+static const int en7581_gpio0_pins[] = { 13 };
+static const int en7581_gpio1_pins[] = { 14 };
+static const int en7581_gpio2_pins[] = { 15 };
+static const int en7581_gpio3_pins[] = { 16 };
+static const int en7581_gpio4_pins[] = { 17 };
+static const int en7581_gpio5_pins[] = { 18 };
+static const int en7581_gpio6_pins[] = { 19 };
+static const int en7581_gpio7_pins[] = { 20 };
+static const int en7581_gpio8_pins[] = { 21 };
+static const int en7581_gpio9_pins[] = { 22 };
+static const int en7581_gpio10_pins[] = { 23 };
+static const int en7581_gpio11_pins[] = { 24 };
+static const int en7581_gpio12_pins[] = { 25 };
+static const int en7581_gpio13_pins[] = { 26 };
+static const int en7581_gpio14_pins[] = { 27 };
+static const int en7581_gpio15_pins[] = { 28 };
+static const int en7581_gpio16_pins[] = { 29 };
+static const int en7581_gpio17_pins[] = { 30 };
+static const int en7581_gpio18_pins[] = { 31 };
+static const int en7581_gpio19_pins[] = { 32 };
+static const int en7581_gpio20_pins[] = { 33 };
+static const int en7581_gpio21_pins[] = { 34 };
+static const int en7581_gpio22_pins[] = { 35 };
+static const int en7581_gpio23_pins[] = { 36 };
+static const int en7581_gpio24_pins[] = { 37 };
+static const int en7581_gpio25_pins[] = { 38 };
+static const int en7581_gpio26_pins[] = { 39 };
+static const int en7581_gpio27_pins[] = { 40 };
+static const int en7581_gpio28_pins[] = { 41 };
+static const int en7581_gpio29_pins[] = { 42 };
+static const int en7581_gpio30_pins[] = { 43 };
+static const int en7581_gpio31_pins[] = { 44 };
+static const int en7581_gpio33_pins[] = { 46 };
+static const int en7581_gpio34_pins[] = { 47 };
+static const int en7581_gpio35_pins[] = { 48 };
+static const int en7581_gpio36_pins[] = { 49 };
+static const int en7581_gpio37_pins[] = { 50 };
+static const int en7581_gpio38_pins[] = { 51 };
+static const int en7581_gpio39_pins[] = { 52 };
+static const int en7581_gpio40_pins[] = { 53 };
+static const int en7581_gpio41_pins[] = { 54 };
+static const int en7581_gpio42_pins[] = { 55 };
+static const int en7581_gpio43_pins[] = { 56 };
+static const int en7581_gpio44_pins[] = { 57 };
+static const int en7581_gpio45_pins[] = { 58 };
+static const int en7581_gpio46_pins[] = { 59 };
+static const int en7581_pcie_reset0_pins[] = { 61 };
+static const int en7581_pcie_reset1_pins[] = { 62 };
+static const int en7581_pcie_reset2_pins[] = { 63 };
+
+static struct pinctrl_pin_desc en7581_pinctrl_pins[] = {
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
+static const char *const uart_groups[] = { "uart2",  "uart2_cts_rts",
+					   "hsuart", "hsuart_cts_rts",
+					   "uart4",  "uart5" };
+static const char *const i2c_groups[] = { "i2c1" };
+static const char *const jtag_groups[] = { "jtag_udi", "jtag_dfd" };
+static const char *const pcm_groups[] = { "pcm1", "pcm2" };
+static const char *const spi_groups[] = { "spi_quad", "spi_cs1" };
+static const char *const pcm_spi_groups[] = {
+	"pcm_spi",	    "pcm_spi_int",	"pcm_spi_rst", "pcm_spi_cs1",
+	"pcm_spi_cs2_p156", "pcm_spi_cs2_p128", "pcm_spi_cs3", "pcm_spi_cs4"
+};
+
+static const char *const i2s_groups[] = { "i2s" };
+static const char *const emmc_groups[] = { "emmc" };
+static const char *const pnand_groups[] = { "pnand" };
+static const char *const pcie_reset_groups[] = { "pcie_reset0", "pcie_reset1",
+						 "pcie_reset2" };
+
+static const char *const pwm_groups[] = {
+	"gpio0",  "gpio1",  "gpio2",  "gpio3",	"gpio4",  "gpio5",  "gpio6",
+	"gpio7",  "gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13",
+	"gpio14", "gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20",
+	"gpio21", "gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27",
+	"gpio28", "gpio29", "gpio30", "gpio31", "gpio36", "gpio37", "gpio38",
+	"gpio39", "gpio40", "gpio41", "gpio42", "gpio43", "gpio44", "gpio45",
+	"gpio46", "gpio47"
+};
+static const char *const phy1_led0_groups[] = { "gpio33", "gpio34", "gpio35",
+						"gpio42", "gpio43", "gpio44", "gpio45", "gpio46" };
+static const char *const phy2_led0_groups[] = { "gpio33", "gpio34", "gpio35",
+						"gpio42", "gpio43", "gpio44", "gpio45", "gpio46" };
+static const char *const phy3_led0_groups[] = { "gpio33", "gpio34", "gpio35",
+						"gpio42", "gpio43", "gpio44", "gpio45", "gpio46" };
+static const char *const phy4_led0_groups[] = { "gpio33", "gpio34", "gpio35",
+						"gpio42", "gpio43", "gpio44", "gpio45", "gpio46" };
+static const char *const phy1_led1_groups[] = { "gpio43", "gpio44", "gpio45",
+						"gpio46" };
+static const char *const phy2_led1_groups[] = { "gpio43", "gpio44", "gpio45",
+						"gpio46" };
+static const char *const phy3_led1_groups[] = { "gpio43", "gpio44", "gpio45",
+						"gpio46" };
+static const char *const phy4_led1_groups[] = { "gpio43", "gpio44", "gpio45",
+						"gpio46" };
+
+static const struct airoha_pinctrl_conf en7581_pinctrl_drive_e2_conf[] = {
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
+	PINCTRL_CONF_DESC(32, REG_GPIO_L_E2, BIT(18)),
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
+static const struct airoha_pinctrl_conf en7581_pinctrl_drive_e4_conf[] = {
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
+	PINCTRL_CONF_DESC(32, REG_GPIO_L_E4, BIT(18)),
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
+static const struct airoha_pinctrl_conf en7581_pinctrl_pcie_rst_od_conf[] = {
+	PINCTRL_CONF_DESC(61, REG_PCIE_RESET_OD, PCIE0_RESET_OD_MASK),
+	PINCTRL_CONF_DESC(62, REG_PCIE_RESET_OD, PCIE1_RESET_OD_MASK),
+	PINCTRL_CONF_DESC(63, REG_PCIE_RESET_OD, PCIE2_RESET_OD_MASK),
+};
+
+static const struct airoha_pinctrl_func_group pon_func_group[] = {
+	{
+		.name = "pon",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
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
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_SIPO_MODE_MASK | SIPO_RCLK_MODE_MASK,
+			       GPIO_SIPO_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "sipo_rclk",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
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
+		.regmap[1] = { AIROHA_FUNC_MUX, REG_FORCE_GPIO_EN,
+			       FORCE_GPIO_EN(1) | FORCE_GPIO_EN(2),
+			       FORCE_GPIO_EN(1) | FORCE_GPIO_EN(2) },
+		.regmap_size = 2,
+	},
+};
+
+static const struct airoha_pinctrl_func_group uart_func_group[] = {
+	{
+		.name = "uart2",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_UART2_MODE_MASK, GPIO_UART2_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "uart2_cts_rts",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_UART2_MODE_MASK |
+				       GPIO_UART2_CTS_RTS_MODE_MASK,
+			       GPIO_UART2_MODE_MASK |
+				       GPIO_UART2_CTS_RTS_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "hsuart",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_HSUART_MODE_MASK |
+				       GPIO_HSUART_CTS_RTS_MODE_MASK,
+			       GPIO_HSUART_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "hsuart_cts_rts",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_HSUART_MODE_MASK |
+				       GPIO_HSUART_CTS_RTS_MODE_MASK,
+			       GPIO_HSUART_MODE_MASK |
+				       GPIO_HSUART_CTS_RTS_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "uart4",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_UART4_MODE_MASK, GPIO_UART4_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "uart5",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
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
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_NPU_UART_EN,
+			       JTAG_UDI_EN_MASK, JTAG_UDI_EN_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "jtag_dfd",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_NPU_UART_EN,
+			       JTAG_DFD_EN_MASK, JTAG_DFD_EN_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group pcm_func_group[] = {
+	{
+		.name = "pcm1",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM1_MODE_MASK, GPIO_PCM1_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm2",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM2_MODE_MASK, GPIO_PCM2_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group spi_func_group[] = {
+	{
+		.name = "spi_quad",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_QUAD_MODE_MASK,
+			       GPIO_SPI_QUAD_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "spi_cs1",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_CS1_MODE_MASK, GPIO_SPI_CS1_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "spi_cs2",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_CS2_MODE_MASK, GPIO_SPI_CS2_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "spi_cs3",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_CS3_MODE_MASK, GPIO_SPI_CS3_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "spi_cs4",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_CS4_MODE_MASK, GPIO_SPI_CS4_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group pcm_spi_func_group[] = {
+	{
+		.name = "pcm_spi",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_MODE_MASK, GPIO_PCM_SPI_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_int",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_INT_MODE_MASK, GPIO_PCM_INT_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_rst",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_RESET_MODE_MASK,
+			       GPIO_PCM_RESET_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs1",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS1_MODE_MASK,
+			       GPIO_PCM_SPI_CS1_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs2_p128",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS2_MODE_P128_MASK,
+			       GPIO_PCM_SPI_CS2_MODE_P128_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs2_p156",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS2_MODE_P156_MASK,
+			       GPIO_PCM_SPI_CS2_MODE_P156_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs3",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS3_MODE_MASK,
+			       GPIO_PCM_SPI_CS3_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs4",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
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
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_EMMC_MODE_MASK, GPIO_EMMC_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group pnand_func_group[] = {
+	{
+		.name = "pnand",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_PARALLEL_NAND_MODE_MASK,
+			       GPIO_PARALLEL_NAND_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group pcie_reset_func_group[] = {
+	{
+		.name = "pcie_reset0",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_PCIE_RESET0_MASK, GPIO_PCIE_RESET0_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcie_reset1",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_PCIE_RESET1_MASK, GPIO_PCIE_RESET1_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcie_reset2",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
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
+	AIROHA_PINCTRL_PWM_EXT("gpio47", GPIO47_FLASH_MODE_CFG),
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
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio44", GPIO_LAN1_LED1_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio45", GPIO_LAN2_LED1_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio46", GPIO_LAN3_LED1_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(2)),
+};
+
+static const struct pingroup en7581_pinctrl_groups[] = {
+	PINCTRL_PIN_GROUP("pon", en7581_pon),
+	PINCTRL_PIN_GROUP("pon_tod_1pps", en7581_pon_tod_1pps),
+	PINCTRL_PIN_GROUP("gsw_tod_1pps", en7581_gsw_tod_1pps),
+	PINCTRL_PIN_GROUP("sipo", en7581_sipo),
+	PINCTRL_PIN_GROUP("sipo_rclk", en7581_sipo_rclk),
+	PINCTRL_PIN_GROUP("mdio", en7581_mdio),
+	PINCTRL_PIN_GROUP("uart2", en7581_uart2),
+	PINCTRL_PIN_GROUP("uart2_cts_rts", en7581_uart2_cts_rts),
+	PINCTRL_PIN_GROUP("hsuart", en7581_hsuart),
+	PINCTRL_PIN_GROUP("hsuart_cts_rts", en7581_hsuart_cts_rts),
+	PINCTRL_PIN_GROUP("uart4", en7581_uart4),
+	PINCTRL_PIN_GROUP("uart5", en7581_uart5),
+	PINCTRL_PIN_GROUP("i2c0", en7581_i2c0),
+	PINCTRL_PIN_GROUP("i2c1", en7581_i2c1),
+	PINCTRL_PIN_GROUP("jtag_udi", en7581_jtag_udi),
+	PINCTRL_PIN_GROUP("jtag_dfd", en7581_jtag_dfd),
+	PINCTRL_PIN_GROUP("i2s", en7581_i2s),
+	PINCTRL_PIN_GROUP("pcm1", en7581_pcm1),
+	PINCTRL_PIN_GROUP("pcm2", en7581_pcm2),
+	PINCTRL_PIN_GROUP("spi", en7581_spi),
+	PINCTRL_PIN_GROUP("spi_quad", en7581_spi_quad),
+	PINCTRL_PIN_GROUP("spi_cs1", en7581_spi_cs1),
+	PINCTRL_PIN_GROUP("pcm_spi", en7581_pcm_spi),
+	PINCTRL_PIN_GROUP("pcm_spi_int", en7581_pcm_spi_int),
+	PINCTRL_PIN_GROUP("pcm_spi_rst", en7581_pcm_spi_rst),
+	PINCTRL_PIN_GROUP("pcm_spi_cs1", en7581_pcm_spi_cs1),
+	PINCTRL_PIN_GROUP("pcm_spi_cs2_p128", en7581_pcm_spi_cs2_p128),
+	PINCTRL_PIN_GROUP("pcm_spi_cs2_p156", en7581_pcm_spi_cs2_p156),
+	PINCTRL_PIN_GROUP("pcm_spi_cs2", en7581_pcm_spi_cs2),
+	PINCTRL_PIN_GROUP("pcm_spi_cs3", en7581_pcm_spi_cs3),
+	PINCTRL_PIN_GROUP("pcm_spi_cs4", en7581_pcm_spi_cs4),
+	PINCTRL_PIN_GROUP("emmc", en7581_emmc),
+	PINCTRL_PIN_GROUP("pnand", en7581_pnand),
+	PINCTRL_PIN_GROUP("gpio0", en7581_gpio0),
+	PINCTRL_PIN_GROUP("gpio1", en7581_gpio1),
+	PINCTRL_PIN_GROUP("gpio2", en7581_gpio2),
+	PINCTRL_PIN_GROUP("gpio3", en7581_gpio3),
+	PINCTRL_PIN_GROUP("gpio4", en7581_gpio4),
+	PINCTRL_PIN_GROUP("gpio5", en7581_gpio5),
+	PINCTRL_PIN_GROUP("gpio6", en7581_gpio6),
+	PINCTRL_PIN_GROUP("gpio7", en7581_gpio7),
+	PINCTRL_PIN_GROUP("gpio8", en7581_gpio8),
+	PINCTRL_PIN_GROUP("gpio9", en7581_gpio9),
+	PINCTRL_PIN_GROUP("gpio10", en7581_gpio10),
+	PINCTRL_PIN_GROUP("gpio11", en7581_gpio11),
+	PINCTRL_PIN_GROUP("gpio12", en7581_gpio12),
+	PINCTRL_PIN_GROUP("gpio13", en7581_gpio13),
+	PINCTRL_PIN_GROUP("gpio14", en7581_gpio14),
+	PINCTRL_PIN_GROUP("gpio15", en7581_gpio15),
+	PINCTRL_PIN_GROUP("gpio16", en7581_gpio16),
+	PINCTRL_PIN_GROUP("gpio17", en7581_gpio17),
+	PINCTRL_PIN_GROUP("gpio18", en7581_gpio18),
+	PINCTRL_PIN_GROUP("gpio19", en7581_gpio19),
+	PINCTRL_PIN_GROUP("gpio20", en7581_gpio20),
+	PINCTRL_PIN_GROUP("gpio21", en7581_gpio21),
+	PINCTRL_PIN_GROUP("gpio22", en7581_gpio22),
+	PINCTRL_PIN_GROUP("gpio23", en7581_gpio23),
+	PINCTRL_PIN_GROUP("gpio24", en7581_gpio24),
+	PINCTRL_PIN_GROUP("gpio25", en7581_gpio25),
+	PINCTRL_PIN_GROUP("gpio26", en7581_gpio26),
+	PINCTRL_PIN_GROUP("gpio27", en7581_gpio27),
+	PINCTRL_PIN_GROUP("gpio28", en7581_gpio28),
+	PINCTRL_PIN_GROUP("gpio29", en7581_gpio29),
+	PINCTRL_PIN_GROUP("gpio30", en7581_gpio30),
+	PINCTRL_PIN_GROUP("gpio31", en7581_gpio31),
+	PINCTRL_PIN_GROUP("gpio33", en7581_gpio33),
+	PINCTRL_PIN_GROUP("gpio34", en7581_gpio34),
+	PINCTRL_PIN_GROUP("gpio35", en7581_gpio35),
+	PINCTRL_PIN_GROUP("gpio36", en7581_gpio36),
+	PINCTRL_PIN_GROUP("gpio37", en7581_gpio37),
+	PINCTRL_PIN_GROUP("gpio38", en7581_gpio38),
+	PINCTRL_PIN_GROUP("gpio39", en7581_gpio39),
+	PINCTRL_PIN_GROUP("gpio40", en7581_gpio40),
+	PINCTRL_PIN_GROUP("gpio41", en7581_gpio41),
+	PINCTRL_PIN_GROUP("gpio42", en7581_gpio42),
+	PINCTRL_PIN_GROUP("gpio43", en7581_gpio43),
+	PINCTRL_PIN_GROUP("gpio44", en7581_gpio44),
+	PINCTRL_PIN_GROUP("gpio45", en7581_gpio45),
+	PINCTRL_PIN_GROUP("gpio46", en7581_gpio46),
+	PINCTRL_PIN_GROUP("pcie_reset0", en7581_pcie_reset0),
+	PINCTRL_PIN_GROUP("pcie_reset1", en7581_pcie_reset1),
+	PINCTRL_PIN_GROUP("pcie_reset2", en7581_pcie_reset2),
+};
+
+static const struct airoha_pinctrl_func en7581_pinctrl_funcs[] = {
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
+static const struct airoha_pinctrl_conf en7581_pinctrl_pullup_conf[] = {
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
+	PINCTRL_CONF_DESC(32, REG_GPIO_L_PU, BIT(18)),
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
+static const struct airoha_pinctrl_conf en7581_pinctrl_pulldown_conf[] = {
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
+	PINCTRL_CONF_DESC(32, REG_GPIO_L_PD, BIT(18)),
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
+static const struct airoha_pinctrl_match_data en7581_pinctrl_match_data = {
+	.gpio_offs = 13,
+	.gpio_pin_cnt = 47,
+	.pins = en7581_pinctrl_pins,
+	.num_pins = ARRAY_SIZE(en7581_pinctrl_pins),
+	.grps = en7581_pinctrl_groups,
+	.num_grps = ARRAY_SIZE(en7581_pinctrl_groups),
+	.funcs = en7581_pinctrl_funcs,
+	.num_funcs = ARRAY_SIZE(en7581_pinctrl_funcs),
+	.confs_info = {
+		[AIROHA_PINCTRL_CONFS_PULLUP] = {
+			.confs = en7581_pinctrl_pullup_conf,
+			.num_confs = ARRAY_SIZE(en7581_pinctrl_pullup_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_PULLDOWN] = {
+			.confs = en7581_pinctrl_pulldown_conf,
+			.num_confs = ARRAY_SIZE(en7581_pinctrl_pulldown_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_DRIVE_E2] = {
+			.confs = en7581_pinctrl_drive_e2_conf,
+			.num_confs = ARRAY_SIZE(en7581_pinctrl_drive_e2_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_DRIVE_E4] = {
+			.confs = en7581_pinctrl_drive_e4_conf,
+			.num_confs = ARRAY_SIZE(en7581_pinctrl_drive_e4_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_PCIE_RST_OD] = {
+			.confs = en7581_pinctrl_pcie_rst_od_conf,
+			.num_confs = ARRAY_SIZE(en7581_pinctrl_pcie_rst_od_conf),
+		},
+	},
+};
+
+static const struct udevice_id airoha_pinctrl_of_match[] = {
+	{ .compatible = "airoha,en7581-pinctrl",
+	  .data = (uintptr_t)&en7581_pinctrl_match_data },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(airoha_pinctrl) = {
+	.name = "airoha-an7581-pinctrl",
+	.id = UCLASS_PINCTRL,
+	.of_match = of_match_ptr(airoha_pinctrl_of_match),
+	.probe = airoha_pinctrl_probe,
+	.bind = airoha_pinctrl_bind,
+	.priv_auto = sizeof(struct airoha_pinctrl),
+	.ops = &airoha_pinctrl_ops,
+};
-- 
2.53.0

