Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C57C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF76784AD4;
	Fri,  3 Jul 2026 13:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="p25XhqDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A6BE84A63; Fri,  3 Jul 2026 13:57:20 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D436384A7C
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7SWv75YeDnsVBb9GO6h0e1Oobu/lXO4CvJOUBYzHA4kB86qjkTp1J/ahTqoeYOuHZrsw61RfyF5rJKtfjJWolQAFs1fEjO/PZR5ZeQM1dl8Q3yTtE91ivve21ZFrypM4XIQ2nCtlJKWfA2ckxBu5pnBCiZX0kytGg187T+JR7+fYg0xxb4iEe2WAb5O5iGGS3z5lPTay9cmu7WbCmp0gYJRnEw1qIlZ3XDq3CMxDb6DCGnFKhm4aGLHQcEI0ttGEKgRCiYpAfRdJEriYVQFN4ZAuoqFo2vUg3Fw+mSZCmdGOWQ47Z3XrGaJK1UmDfUHLXtSE8D3ApuqIaRaNSGcEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsL9nm+1mH3XfIUtwcnCsQaowMzdnMkF4QOa9rsitj8=;
 b=UPmE2VoBHU4IttP1u9cXF5ekIXR7JrWpUeowC6FswAIeaHhLUWjcBMRil1ZQseZEJAnBLrAQTnHuaKLtI8GpWsJeNOY8KEgXCOsnBW0ieQ1a9s18FznbuiIlNbz26xLJvnM9NX7Ki+EP0PDZEDIpqYJd5x3XkUcb56X1F9huccex7qKukivcn1XXPnf/i8zjaIXDaGDzmxcxWyMUdGJhsvgpp4S/shPgHyI+7YNKsg1p5H7M/HcIKe1w0Wl9HCUH1G4LUoNdjcbdMpTh2BOhKUn47aL/J3AeYA9U93j6FRtgmzolhZVCihSK9XHhUqEdcnpZB+6FzOTUqJDgft9aIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsL9nm+1mH3XfIUtwcnCsQaowMzdnMkF4QOa9rsitj8=;
 b=p25XhqDXP+xDoGFhIjuB67dHNHTCWhJi8qHc9FpLy3S6EFsfHcNZTucE0TUPzCG9NDjysVraO5bpubZEeLQMduZmKNByLVF2Sbf4CSnSV8TqxMAiaVC1fqT1AG70IA8WmuougVWywnsvI5juVyNSV7WzOpr2i6Gx8IbNz0HEwmODjvCv3q34s/KviYc8hCOM7kd2TMymgyB7KbhjwhkO2b3FSAOAzGVmRdK5cPyOcyM7GNXaAKPzwxVmU4VAlIBnYo8X8fG+ObOrEW+J9/c46r+iY8DzOda4p+klQySaJkwrU22syzxKseZSOK0IXDIKrmtM1S1YJytxewE+196sxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB9448.eurprd08.prod.outlook.com (2603:10a6:102:2f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:57:09 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:57:09 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 11/24] power: domain: renesas-r8a78000: Convert to common
 field_{get, prep}() helpers
Date: Fri,  3 Jul 2026 14:56:14 +0300
Message-ID: <20260703115627.2317120-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAWPR08MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b41b7cb-542f-42d7-a082-08ded8fa364c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|366016|1800799024|921020|38350700014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 8zdDFudHcLC2si+xcXk980HANlDugMVtrP0idxMIUjSUoJ7O8HB3NciNJr5xhTH+oJnksld5ulM4g1JCJchFyld+rZJZ0MN0TWxNp2TB3boB1mwWGocEHzP9cDSVu/HcpaoYYfTpksG6Maogm3xvnULIYkN9r6O7JQfdmPadResl0WZseEDDWKpFtmXRiKfe0QmobDPbK/vzaZfHEcnQ6/RBGTJzCDhxZM67zB2ytUtv2vsg3ETrEFgXjiFmqy5ETx77X6rGJYcn+sR2Yql3UXYi+tREIFQbP91g6FZ0vUFf61DLIeuDY99moIDrFmjbzjq/opr8voT8ASh0QFoSJjNh/8YAoFtv6EsvjyOOy7HmDxEixRB+542E8TKUebxxkFNYnVukEc8K5AMjSOvyujUOnQpXsTIWhCR+DFI0OkBzh5WhM3uFbsgjmk2NS+DP0s+7G8Iq2DbtTLNfkAsXMd7THmt1wC+GxVUG/TZjOK46N+tsmqUNR7kuPCEQQ3dry1/xkGFRf0IMj66LAyODCPIr8IqBAooP4dpqnR7N9ov+XXOOmdkbrxARxaB4pU8OZziO+meSYBfRj81Qu54C3hw3CZT0oiBXQh2u9n8TbCEWJ9SV6U8d/dAJAMKWOrsQGYap9tqWz9npImmeFIesaEaXugUpgeGIyhO/hzCSjtu3scvdP9xOJVojl1xJ4lYNFrRUGHxirS0tx3887NwtztRmHRi6GAoE4VcjUQf9Z5MBUD4Z5RabvVXG52AvWFqM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?owgHFF20BUMrnW3mkyaZKhnPt1waqvYRAO1g+9py3Eb+S0vR1ytoBa7ZThTS?=
 =?us-ascii?Q?Sj+1RUxCpxmBR9lBSCZjJnAapNswQbDZmJaGRfzM2q6fcGTy6zHFS1yKs8yV?=
 =?us-ascii?Q?jGePpWMjn2xW36/Y+JUgSgDN93qmyXUoBAhx0X8d4J4UKDkf4E4fHjJQWJsG?=
 =?us-ascii?Q?zgtEP/7oXBKcyCX53SAQL5cfH+mT5eb1ym762lvLBa/lBohqFD4D+DSoXktY?=
 =?us-ascii?Q?wjw6oY3vEjOMJ+N8Mp/SfbJrpXETD75LRLR89Gy67CrlIY7NCVsBUC5Ufaj1?=
 =?us-ascii?Q?ZGn2+mCKrMw0ISs7SskUqSVu0+JQ1SlXMXloAD/fR9XKf/lYj5ftM96VXZig?=
 =?us-ascii?Q?oJJ+lfwo6h4fMxynaS2knNQQ4AvKx1sOEY7gKTbVfGK13BgGp6A+WkekxTIX?=
 =?us-ascii?Q?1j+VBoYjbK2NG/vwnXXCb9yFc/FT7Htg6HYMLByLPpMUJFbqIPwn//euy+8D?=
 =?us-ascii?Q?mNP/2JSLRwoG8y78UkWbGZZVO/d2CBzkgA7o7NdsSIMprOD+v2fbe3RlH162?=
 =?us-ascii?Q?Gwtzrt+G6FSv4IpLUiS9TUINEUS0Juzzr13wniMPC7Ngzp96cbRzJFgDCeke?=
 =?us-ascii?Q?uyCB0VFK8xLHNvDLWcIU+vVuCFmzKEVMGkKmaxMsA7PYCZZ83t6Q+bWnliOF?=
 =?us-ascii?Q?uSXk8ZXNXosmregnbdb5np/5xvJfOnYrYeRmEQXgECMsPdmZkzfOA7KToHms?=
 =?us-ascii?Q?CcFKU3BSMhtw4YvMlhX9UmgPw8hmlHChkP3N5ag9uRMRVC1tTjo6Li3TG0Ib?=
 =?us-ascii?Q?QLiRG6dGZHD+M0+9357ZKGhIThQmsjHl53wWNio22mngp69uQI5Xf1sBJw8V?=
 =?us-ascii?Q?FJdrrfsg3FOiWRN0Z5HRWLA9npPmGxYVCoR9q73tV6TYva0RGq6t5oU3vf2o?=
 =?us-ascii?Q?3m1I8+coVWwWXHi6RuUgMKhHdErjCCWJhQMklAcsrglMNli5+TFVavbCwdB9?=
 =?us-ascii?Q?hKbJyLe4np53aHlk6GfztTI/2JZfANBxhWakBHmYw45vQw9Bux+YYvT96hAG?=
 =?us-ascii?Q?+BuK0AhQ7PL+KjlpHbkdBvm9Mbps4X50CPaio2Pn79PxRlEm2QDMftmIFn0f?=
 =?us-ascii?Q?y5pjiA/tLtAR98mF7/tqQzzQ3wzivWV+ST2MiQIxGCyTxywKbdhgGzMXi9/R?=
 =?us-ascii?Q?s/7sU6i6U1E2H6TjulDcUALWRTdHfogi9elMEbyE+53C3kW5Jw2eayBMAHBM?=
 =?us-ascii?Q?D5dgX2zQrMMEMs5cd2DkpKabkp2NZ80tEi4HQgWWMw+YWa/F9/IiUS9hO1TP?=
 =?us-ascii?Q?28BN6SSsX8+3xRoPuaOY7MHU/u7YsBph2Pniu1JK9ihtkhAQfpekicVxNBfx?=
 =?us-ascii?Q?gNQG7h/boII0eEdCfee1EaLAGdTkKfdvhtvfe+YI/9vq+LZLedaL1bZ50V4L?=
 =?us-ascii?Q?PluEka5NBZ9VlKT2oE0FB8g21egwt7Wp5U7BX4BFdytU4fG1XiJTZkbUUR58?=
 =?us-ascii?Q?ZFdXsAy9xd/cYVqlYTRNkhTZrHn7X3UtZQNxAadoMbOjR4ay6mENwMESk/iH?=
 =?us-ascii?Q?A1JK2UQTKbNPOsdA0PAwPIQqhZEZl99lYjwbc64Pc5w7+MeEgZrYh49tKgiG?=
 =?us-ascii?Q?ZekDhglXIcyMljPjojXNnRs6RKAvhvIdbTGPRgXcLeJkF58gZjkkMruN2lwC?=
 =?us-ascii?Q?6llk7yQStzF7Q8rCYzG2Abgx8i2ncrNx4w7573D2ZurB6em++b2EFmffm0nm?=
 =?us-ascii?Q?LovNpXdMZOXqG19sqlKipiaGUezSI3RXs+k3di3tnzm8zoqCraDaHkijL4PT?=
 =?us-ascii?Q?t36yW5A7gyPBRN9Ol/7HNKe+8lcy+c4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b41b7cb-542f-42d7-a082-08ded8fa364c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:57:09.9019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PHKgkFs5Vp13Fi74+nkGQSbjb4EyqHQ6fABEQxQ8SWBrBOsRaG4g2GdXkhuJvCqGLI/rDlnybLxT2e8ILEcE7McUx1dzdOaeEkJo64qtKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9448
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

Drop the driver-specific field_get() and field_prep() macros, in favor
of the globally available variants from <linux/bitfield.h>.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/power/domain/renesas-r8a78000-power-domain.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/power/domain/renesas-r8a78000-power-domain.c b/drivers/power/domain/renesas-r8a78000-power-domain.c
index 23fd35cd7f3..57b3b56b2d9 100644
--- a/drivers/power/domain/renesas-r8a78000-power-domain.c
+++ b/drivers/power/domain/renesas-r8a78000-power-domain.c
@@ -11,6 +11,7 @@
 #include <dm/lists.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/bitfield.h>
 #include <power-domain-uclass.h>
 #include <reset-uclass.h>
 
@@ -21,11 +22,6 @@
 #include <dt-bindings/power/r8a78000-power-scmi.h>
 #include <dt-bindings/reset/r8a78000-reset-scmi.h>
 
-#undef field_get
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#undef field_prep
-#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
-
 #define PKC_PROT_LOCK			0xa5a5a500
 #define PKC_PROT_UNLOCK			0xa5a5a501
 
-- 
2.53.0

