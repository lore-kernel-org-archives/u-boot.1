Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A33CF3185
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 20:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47BE589256;
	Tue,  1 Oct 2024 22:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="t+aItcUD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DC8689221; Tue,  1 Oct 2024 22:45:09 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07FB1892E6
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 22:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oehruwbicebLDOgHuDpWuXKLFj3uB+ClXvhTyVdaCP4dAAs0hzyrnG1c7Xz+DHace6xINKZBcsHvhnBXuil8v5E7TFfRQsvaQ+FepbH05O7YiI5b+JWslHbUq3L13mkuQUDU07cZPz4xUYJ3ICWDVscdCM+LAQVI97AkEa0QPHHoX2zVkUweVk2ms2x+O2wE3DyjNpqFpD4x58i9Hwy/2ssE49oZJ88k7UMK8Xerug0q9/O/bWr/yrLQiwxa6mzDkft/h3BZ17eeEilw4aZaI0/+JOHAJNnLlFOOase0mNhc0SqMcczd0SVZiPGd/drlXs1QvxlRRTdsCW45KIlQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FVKMCs7g8msQQCy2l/Ny47c+XR4Rl1ZvMK36YZTPu8=;
 b=pYjfgZ8tsq3+3Rm5kU7Zw1DCkXfHn2zuKCdeggndB2GwAZQX5V8yy3paQIeemf2Kp4+nuCfl5QQIWDeRinxbDeV04lEe2R1Cd8p5KiHeEPK3kysU6528KE0OG8eN9z5XJ8qoJaHmnkU9MVcbQS8aUzUE6fZ7SV0SZt4AQ7aTNqJ2aaxd3Xnhu2D9EaDAZE4C85zXYM9nmIatF5MlTIJVST58riHHRhKCDvlwqcQjHWNseyWSOqaxc1EyNha5N0gVth2OsbFMvvX9XamqDLqS/XnzdKYTBq3LW9UaS/mbh5/gllLWDRi0Tiw9w8QXeI//H1/mS92JSTo88Sb2Rcre3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FVKMCs7g8msQQCy2l/Ny47c+XR4Rl1ZvMK36YZTPu8=;
 b=t+aItcUDoiGPIG4fkd79CQ3mgOzCyYM/9kyJSreCNfjBUu931XpzgXgFbXkDFc89PG+Lits11YzgpQK5qgDYH3+FKeslVRDwLn3tccsfT9gRFis9cphU5P+fUQa1VxZWNVyN16jrz5W3b9t/XogCpwyxxqYaQEe30dQSoTF2hCVWJX6nm153vApqi7aAtRdIusE75eoHclVue17mgnNuUnXAypJZhoVrvBOjonuQ7rlqHsIAHAKLnyDeH1lzHic8mxW2sA2+tyibt2/gQ12tV6SjxMvE7GM8FgfVHp/gKb8MKGLXf27aAkEJfNVr3mgQgTd8qaeNg/oPDYzLK4OnFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7812.eurprd08.prod.outlook.com (2603:10a6:10:3b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 20:45:04 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 20:45:04 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 William Zhang <william.zhang@broadcom.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 09/10] mtd: spinand: sync supported flashes with
 linux-6.10
Date: Tue,  1 Oct 2024 23:44:41 +0300
Message-ID: <20241001204444.917238-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B5E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:16) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: d1916560-6c9f-4cbe-e53b-08dce259ed49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8G/7R88yOP88Jle3bNhHVxOJIBtULf5EmxtzYnTaMa6KJXyfEIARBy8TjDHT?=
 =?us-ascii?Q?z6oUVg1NpRb0N9HNFbCmvAR8cWYx9QwzG6JeSr96LMoXZQxKBBCsN/KBKLUE?=
 =?us-ascii?Q?pzb0kNJozZNZtpF/hU+iffMeJC+F/SWdrSNI98E7VLDKAtkuYtTBoI07xNEv?=
 =?us-ascii?Q?Vxe23+nd83zSd9WqeYgHPNyCIOBp3fLCV1hy1rT/p1oXeCHrTA3lJUPMt0B2?=
 =?us-ascii?Q?TPNIx5l97TFyq2mT0bpPJuUR2EPgIbrYW2+b8HZFsabYUQnUS5mYjezAQOoo?=
 =?us-ascii?Q?MuwsoDtsuBeCNyJ0vjMx1Sh9f+/ayC1BLE1lIzPhV+j4zMREOJncUiN3F5/g?=
 =?us-ascii?Q?1r/dv7ICxrdpaWuhTXRjbvVPmEIjUzzESFZsuLiwPzr9fr2gk7rOiv5rRieu?=
 =?us-ascii?Q?CIEu+R56rygnD4ZYhVjeloccD/gnK1yPPhONt6gcP6R2d8RheGtILtryqNvJ?=
 =?us-ascii?Q?yK1d3x53vPoe8QmNapO5ZCaM2JKoFhYS7hXLuWV1nEVoE9n0Z8DS2CwDec8n?=
 =?us-ascii?Q?va67R5WsIFyw7k0e57Ud48bCSxrgqnblHYv4+Xrb7Ja6BT9YOKK8jMIjAZ51?=
 =?us-ascii?Q?C3abRFX3AFqgzJT8WvXq5M+rQTViK6LiTbRt0Nl4QxhXS2kfpZIKbPP9CsUL?=
 =?us-ascii?Q?FXG3MMC0pjfp/rtiUgH2NHLonhArTpohuxvc1r8Dn10jSHnySrJeQrLtARMg?=
 =?us-ascii?Q?FRibxz/jK5N2rcT6Ihn+ylKbwv28PPTNyl2RY8VB+duNeAKmAV60UsmMxLhr?=
 =?us-ascii?Q?qS6UH5i2FvZodORMNkNwysZiVBmKLDKt7I3EFjYidIfpTZr8SK0awjeQK1ii?=
 =?us-ascii?Q?HddkFjfmsnwsjSwU3EoeCQ0wMMyeymYo+v1ujRasriwwCnic307hUaOWYlMV?=
 =?us-ascii?Q?Ub0evwqJr03bBRTvk1pGnG+p+u7X0Ybb2ikwHR6ih7hhYHwp1CFHdURSD6h7?=
 =?us-ascii?Q?1/XnoxMjLojCaqJW76TR8o5r4FiWKTYTBDYiN6YveuGSEkRvPqK7ckdjsx1x?=
 =?us-ascii?Q?QNZGLv0PFMlF2tCeHsOqTgTrjJA4UpkzwQ1jz4MqkI1li3SQbqgu2m3GEcdr?=
 =?us-ascii?Q?AUysG0jwzn1PsYOpeJrxreyDYvSjt6drg3NPa1rvfZ9HVLk/1aNCKgDaNgBq?=
 =?us-ascii?Q?vkjiXfVpVx5bC/101PeNd11odxk2cOU0YcvN49zpoNqFKwvf8p5b4ilIcA2k?=
 =?us-ascii?Q?NQBw75OEZnJA6I9ZMQ6V5Zi9ZapQmhbB+KSVVRLxE1BGrvKyng6tIwwnoJPg?=
 =?us-ascii?Q?ubxMVuBcJsVaa09iNLhqh0QjToqn4PKwemvBaedKM1XX4L6ituRCvTkZu8kS?=
 =?us-ascii?Q?Byr+qizwWSNGEt1u8BO3zEscJ8BxrKZALo+ujmkprD7voKKIueSh2FwhiY7u?=
 =?us-ascii?Q?G7Pnlyc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oXkJcXqoSIBqaS7TSZio4M6AaGZHyFj1ymyugfcTwiyGWPRRwq6yjKHJNonL?=
 =?us-ascii?Q?mdVXJfkELgYy+Z2D+4ADDnohtIHXMLlsPhF7afa5lj2ukZRVV24D0t9D0Jn7?=
 =?us-ascii?Q?iL/mdLVANAOc1kqwSNt1QYfpdFOym2MtaHuIf/8gbtWTCX2Faz7/K7sPWng/?=
 =?us-ascii?Q?cS3EKfwmPboMhumX/LuWxGqCDu43x+dtu43E7cufQks4OE/8fBpj9HxUfBAC?=
 =?us-ascii?Q?+7f/WJYx3JsPKJwewbIAfBL4kiBqLRJeojzqgNt1W+lI4eD55zcqwF3QHhSo?=
 =?us-ascii?Q?zmEMvZZEbwUVpt2tXHHzgyv/FpoIt0tkiy8BhVD8OXhEKDwwb/oPCdxQIYZd?=
 =?us-ascii?Q?fmQngqPW6vY2z8Wnc2i9frgsce8jbuJ0XsmATD8+Vsm8x7A9UiIC9dFnCBUq?=
 =?us-ascii?Q?hgNhrkM/cxGu2b/9yTCRnKJemWQ+waazx+8poJp56vmOM26xid7xp4gLzOJ/?=
 =?us-ascii?Q?4OpaHRde4r9Jf4RpXOzbwUJPwzcyGOm/leY8xyE4s0MfDGT3wi9zZpRyrNDR?=
 =?us-ascii?Q?AsRGUwxLsp6TgOOpmsmlPSf5Oa6LN5jZPdqUqqlHhAf+ZjEues7tQpP8uQE/?=
 =?us-ascii?Q?4utWl15pPq64v8K5GiTBsKOCqp+tWq6i3mPRE38Xa2rB7MpnGkU2i4pD6kZc?=
 =?us-ascii?Q?efzeqhJzmiwOW52bhi6KtKv/ftVo0f/mLl6sPA/rOhWbLJlOVGjhQ0KrvvKo?=
 =?us-ascii?Q?d3bIhRSSMew1BCysjJHQoBgchzCIRZ1uUAOPy9x+Z8KDNndoZiUPZ3KcN7m3?=
 =?us-ascii?Q?+JjoJaxXv/MAN6ArwXBrFca+OqgdSKDoBxMmLom6l2VSz2uTlcOcuOlGJ1Rb?=
 =?us-ascii?Q?lzx/0FypCST3y67Z0MF2ckuHK64iimZBFSD3XJS4rZ7Z0nWGMrjpzTWZNVCQ?=
 =?us-ascii?Q?CCh8HZ91V1Wm6+Ry9dGiA0raPoGio1IbuPFRuDwb4QNLyBygTxmnngAFnaCx?=
 =?us-ascii?Q?Jcgecqx9qpaxpnDT+IEtwI6os/r+tlQ4qB6ivQfRdCO66jPo2appmuHUY1RI?=
 =?us-ascii?Q?BcPGnWJgf5EKFb9hLhtM6LpZz14qRJspmQ9s0HDmjBgGMQDyDiesajTCH3pT?=
 =?us-ascii?Q?MHco1Bq91UWZ+U0fPURsnrMYVdabd/wc97a+QiMCW8iPv0/Ag4AxX1L08edV?=
 =?us-ascii?Q?+e2EZS4wYqEkOsN5iS8zlHirQ38hDq48GogSC0VY+Jd8Hep/dnukGMjmdxWd?=
 =?us-ascii?Q?NdsNi5A5yJ6r5eHWrg09bv9B6jSY8bLzMe3HO2mTCl0QZMO50g8cmODP/beE?=
 =?us-ascii?Q?3fr29lZui3HhrmcGfWB7n+M+ATWQhvRvZ5MVuAiSesMGiJFUqihJ69qAk5N2?=
 =?us-ascii?Q?iBscZ2yZraC1zJF/kAP+tYyHx/rBpGGEdzY9NK9zKr5/pWlRgCniHVYDlML/?=
 =?us-ascii?Q?oQgFaoNtcQkake5zzVeq20NKxLw7rKuIvCMCAPXl3ZVW4iE7jjwRoPmJoP8j?=
 =?us-ascii?Q?7B2etHa87+2wae8zWHi2MzIBFyvUCEvmaDp18tu9ZoIh9RqYbIB1v1doejK8?=
 =?us-ascii?Q?mDe2Xv7GZdMiwwl7Crc+c/xMCEVFHBpWMiH9OmrR4kJrTFG8jdjZPIa4FkTY?=
 =?us-ascii?Q?ynZCdP3lw4QeILMaI4bM0CJ3+Atwef6cW7Xn52Sz3+QEDPq+6Np4D4748Jup?=
 =?us-ascii?Q?sBDZI1xUv3V0ZToGViF+qiY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d1916560-6c9f-4cbe-e53b-08dce259ed49
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:45:04.2808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNzyO60T+TjmSWwE5jXup8VoiB1/bvDFlgdZKKqil40Gch7vWaOb53cAMBh2OAIrsTILcO2gpMVFyPr1Qsq++KtAyYntWzCZmFmarT6nQOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7812
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/Makefile         |   4 +-
 drivers/mtd/nand/spi/alliancememory.c | 155 ++++++++++++++++++++
 drivers/mtd/nand/spi/ato.c            |  84 +++++++++++
 drivers/mtd/nand/spi/core.c           |   5 +-
 drivers/mtd/nand/spi/esmt.c           |  16 ++-
 drivers/mtd/nand/spi/foresee.c        |  97 +++++++++++++
 drivers/mtd/nand/spi/gigadevice.c     | 194 +++++++++++++++++++++++++-
 drivers/mtd/nand/spi/macronix.c       |  25 +++-
 drivers/mtd/nand/spi/toshiba.c        |  33 +++++
 drivers/mtd/nand/spi/winbond.c        |  57 ++++++++
 include/linux/mtd/spinand.h           |   5 +-
 11 files changed, 664 insertions(+), 11 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/alliancememory.c
 create mode 100644 drivers/mtd/nand/spi/ato.c
 create mode 100644 drivers/mtd/nand/spi/foresee.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 65b836b34ca..d438747cf37 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-spinand-objs := core.o esmt.o gigadevice.o macronix.o micron.o paragon.o
-spinand-objs += toshiba.o winbond.o xtx.o
+spinand-objs := core.o alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
+spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/alliancememory.c b/drivers/mtd/nand/spi/alliancememory.c
new file mode 100644
index 00000000000..e29e4cc77ec
--- /dev/null
+++ b/drivers/mtd/nand/spi/alliancememory.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Mario Kicherer <dev@kicherer.org>
+ */
+
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_ALLIANCEMEMORY	0x52
+
+#define AM_STATUS_ECC_BITMASK		(3 << 4)
+
+#define AM_STATUS_ECC_NONE_DETECTED	(0 << 4)
+#define AM_STATUS_ECC_CORRECTED		(1 << 4)
+#define AM_STATUS_ECC_ERRORED		(2 << 4)
+#define AM_STATUS_ECC_MAX_CORRECTED	(3 << 4)
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+			   SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int am_get_eccsize(struct mtd_info *mtd)
+{
+	if (mtd->oobsize == 64)
+		return 0x20;
+	else if (mtd->oobsize == 128)
+		return 0x38;
+	else if (mtd->oobsize == 256)
+		return 0x70;
+	else
+		return -EINVAL;
+}
+
+static int am_ooblayout_ecc(struct mtd_info *mtd, int section,
+			    struct mtd_oob_region *region)
+{
+	int ecc_bytes;
+
+	ecc_bytes = am_get_eccsize(mtd);
+	if (ecc_bytes < 0)
+		return ecc_bytes;
+
+	region->offset = mtd->oobsize - ecc_bytes;
+	region->length = ecc_bytes;
+
+	return 0;
+}
+
+static int am_ooblayout_free(struct mtd_info *mtd, int section,
+			     struct mtd_oob_region *region)
+{
+	int ecc_bytes;
+
+	if (section)
+		return -ERANGE;
+
+	ecc_bytes = am_get_eccsize(mtd);
+	if (ecc_bytes < 0)
+		return ecc_bytes;
+
+	/*
+	 * It is unclear how many bytes are used for the bad block marker. We
+	 * reserve the common two bytes here.
+	 *
+	 * The free area in this kind of flash is divided into chunks where the
+	 * first 4 bytes of each chunk are unprotected. The number of chunks
+	 * depends on the specific model. The models with 4096+256 bytes pages
+	 * have 8 chunks, the others 4 chunks.
+	 */
+
+	region->offset = 2;
+	region->length = mtd->oobsize - 2 - ecc_bytes;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops am_ooblayout = {
+	.ecc = am_ooblayout_ecc,
+	.rfree = am_ooblayout_free,
+};
+
+static int am_ecc_get_status(struct spinand_device *spinand, u8 status)
+{
+	switch (status & AM_STATUS_ECC_BITMASK) {
+	case AM_STATUS_ECC_NONE_DETECTED:
+		return 0;
+
+	case AM_STATUS_ECC_CORRECTED:
+		/*
+		 * use oobsize to determine the flash model and the maximum of
+		 * correctable errors and return maximum - 1 by convention
+		 */
+		if (spinand->base.mtd->oobsize == 64)
+			return 3;
+		else
+			return 7;
+
+	case AM_STATUS_ECC_ERRORED:
+		return -EBADMSG;
+
+	case AM_STATUS_ECC_MAX_CORRECTED:
+		/*
+		 * use oobsize to determine the flash model and the maximum of
+		 * correctable errors
+		 */
+		if (spinand->base.mtd->oobsize == 64)
+			return 4;
+		else
+			return 8;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct spinand_info alliancememory_spinand_table[] = {
+	SPINAND_INFO("AS5F34G04SND",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x2f),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&am_ooblayout,
+				     am_ecc_get_status)),
+};
+
+static const struct spinand_manufacturer_ops alliancememory_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer alliancememory_spinand_manufacturer = {
+	.id = SPINAND_MFR_ALLIANCEMEMORY,
+	.name = "AllianceMemory",
+	.chips = alliancememory_spinand_table,
+	.nchips = ARRAY_SIZE(alliancememory_spinand_table),
+	.ops = &alliancememory_spinand_manuf_ops,
+};
diff --git a/drivers/mtd/nand/spi/ato.c b/drivers/mtd/nand/spi/ato.c
new file mode 100644
index 00000000000..f0d4436cf45
--- /dev/null
+++ b/drivers/mtd/nand/spi/ato.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Aidan MacDonald
+ *
+ * Author: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
+ */
+
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_ATO		0x9b
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int ato25d1ga_ooblayout_ecc(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 8;
+	region->length = 8;
+	return 0;
+}
+
+static int ato25d1ga_ooblayout_free(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	if (section) {
+		region->offset = (16 * section);
+		region->length = 8;
+	} else {
+		/* first byte of section 0 is reserved for the BBM */
+		region->offset = 1;
+		region->length = 7;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops ato25d1ga_ooblayout = {
+	.ecc = ato25d1ga_ooblayout_ecc,
+	.rfree = ato25d1ga_ooblayout_free,
+};
+
+static const struct spinand_info ato_spinand_table[] = {
+	SPINAND_INFO("ATO25D1GA",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x12),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&ato25d1ga_ooblayout, NULL)),
+};
+
+static const struct spinand_manufacturer_ops ato_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer ato_spinand_manufacturer = {
+	.id = SPINAND_MFR_ATO,
+	.name = "ATO",
+	.chips = ato_spinand_table,
+	.nchips = ARRAY_SIZE(ato_spinand_table),
+	.ops = &ato_spinand_manuf_ops,
+};
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 548a7144ee3..d5cb9026246 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -866,13 +866,16 @@ static const struct nand_ops spinand_ops = {
 };
 
 static const struct spinand_manufacturer *spinand_manufacturers[] = {
+	&alliancememory_spinand_manufacturer,
+	&ato_spinand_manufacturer,
+	&esmt_c8_spinand_manufacturer,
+	&foresee_spinand_manufacturer,
 	&gigadevice_spinand_manufacturer,
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
 	&paragon_spinand_manufacturer,
 	&toshiba_spinand_manufacturer,
 	&winbond_spinand_manufacturer,
-	&esmt_c8_spinand_manufacturer,
 	&xtx_spinand_manufacturer,
 };
 
diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
index 7e07b26827a..23be098b885 100644
--- a/drivers/mtd/nand/spi/esmt.c
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -106,7 +106,8 @@ static const struct mtd_ooblayout_ops f50l1g41lb_ooblayout = {
 
 static const struct spinand_info esmt_c8_spinand_table[] = {
 	SPINAND_INFO("F50L1G41LB",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01, 0x7f,
+				0x7f, 0x7f),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -115,7 +116,8 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
 	SPINAND_INFO("F50D1G41LB",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11, 0x7f,
+				0x7f, 0x7f),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -123,6 +125,16 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
+	SPINAND_INFO("F50D2G41KA",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51, 0x7f,
+				0x7f, 0x7f),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
 };
 
 static const struct spinand_manufacturer_ops esmt_spinand_manuf_ops = {
diff --git a/drivers/mtd/nand/spi/foresee.c b/drivers/mtd/nand/spi/foresee.c
new file mode 100644
index 00000000000..7d141cdd658
--- /dev/null
+++ b/drivers/mtd/nand/spi/foresee.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023, SberDevices. All Rights Reserved.
+ *
+ * Author: Martin Kurbanov <mmkurbanov@salutedevices.com>
+ */
+
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_FORESEE		0xCD
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int f35sqa002g_ooblayout_ecc(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *region)
+{
+	return -ERANGE;
+}
+
+static int f35sqa002g_ooblayout_free(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	/* Reserve 2 bytes for the BBM. */
+	region->offset = 2;
+	region->length = 62;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops f35sqa002g_ooblayout = {
+	.ecc = f35sqa002g_ooblayout_ecc,
+	.rfree = f35sqa002g_ooblayout_free,
+};
+
+static int f35sqa002g_ecc_get_status(struct spinand_device *spinand, u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		return nand->eccreq.strength;
+
+	default:
+		break;
+	}
+
+	/* More than 1-bit error was detected in one or more sectors and
+	 * cannot be corrected.
+	 */
+	return -EBADMSG;
+}
+
+static const struct spinand_info foresee_spinand_table[] = {
+	SPINAND_INFO("F35SQA002G",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x72, 0x72),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&f35sqa002g_ooblayout,
+				     f35sqa002g_ecc_get_status)),
+};
+
+static const struct spinand_manufacturer_ops foresee_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer foresee_spinand_manufacturer = {
+	.id = SPINAND_MFR_FORESEE,
+	.name = "FORESEE",
+	.chips = foresee_spinand_table,
+	.nchips = ARRAY_SIZE(foresee_spinand_table),
+	.ops = &foresee_spinand_manuf_ops,
+};
diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index f2ecf47f8d4..f3608a13d8e 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -43,6 +43,22 @@ static SPINAND_OP_VARIANTS(read_cache_variants_f,
 		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(true, 0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(false, 0, 0, NULL, 0));
 
+static SPINAND_OP_VARIANTS(read_cache_variants_1gq5,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(read_cache_variants_2gq5,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 4, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD(true, 0, NULL, 0));
@@ -174,7 +190,7 @@ static int gd5fxgq4uexxg_ecc_get_status(struct spinand_device *spinand,
 {
 	u8 status2;
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
-						      &status2);
+						      spinand->scratchbuf);
 	int ret;
 
 	switch (status & STATUS_ECC_MASK) {
@@ -195,6 +211,7 @@ static int gd5fxgq4uexxg_ecc_get_status(struct spinand_device *spinand,
 		 * report the maximum of 4 in this case
 		 */
 		/* bits sorted this way (3...0): ECCS1,ECCS0,ECCSE1,ECCSE0 */
+		status2 = *(spinand->scratchbuf);
 		return ((status & STATUS_ECC_MASK) >> 2) |
 			((status2 & STATUS_ECC_MASK) >> 4);
 
@@ -216,7 +233,7 @@ static int gd5fxgq5xexxg_ecc_get_status(struct spinand_device *spinand,
 {
 	u8 status2;
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
-						      &status2);
+						      spinand->scratchbuf);
 	int ret;
 
 	switch (status & STATUS_ECC_MASK) {
@@ -236,6 +253,7 @@ static int gd5fxgq5xexxg_ecc_get_status(struct spinand_device *spinand,
 		 * 1 ... 4 bits are flipped (and corrected)
 		 */
 		/* bits sorted this way (1...0): ECCSE1, ECCSE0 */
+		status2 = *(spinand->scratchbuf);
 		return ((status2 & STATUS_ECC_MASK) >> 4) + 1;
 
 	case STATUS_ECC_UNCOR_ERROR:
@@ -329,6 +347,36 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
 				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GQ4RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xc1),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ4UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xd2),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ4RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xc2),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
 	SPINAND_INFO("GD5F1GQ4UFxxG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE, 0xb1, 0x48),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
@@ -343,12 +391,152 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x51),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(4, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GQ5RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x41),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ5UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x52),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ5RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x42),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F4GQ6UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x55),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 2, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F4GQ6RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x45),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 2, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
 				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GM7UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x91),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GM7RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x81),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GM7UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GM7RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x82),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F4GM8UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x95),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F4GM8RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x85),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ5xExxH",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x22),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GQ5RExxH",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x21),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GQ4RExxH",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xc9),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops gigadevice_spinand_manuf_ops = {
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 86bffc2800b..3d4a7f0c3cb 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -23,7 +23,7 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
-		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
@@ -86,9 +86,10 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
 		 * in order to avoid forcing the wear-leveling layer to move
 		 * data around if it's not necessary.
 		 */
-		if (mx35lf1ge4ab_get_eccsr(spinand, &eccsr))
+		if (mx35lf1ge4ab_get_eccsr(spinand, spinand->scratchbuf))
 			return nand->eccreq.strength;
 
+		eccsr = *spinand->scratchbuf;
 		if (WARN_ON(eccsr > nand->eccreq.strength || !eccsr))
 			return nand->eccreq.strength;
 
@@ -300,6 +301,26 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
 
+	SPINAND_INFO("MX31LF2GE4BC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x2e),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX3UF2GE4BC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xae),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops macronix_spinand_manuf_ops = {
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index b9908e79271..ad48b1c7c8a 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -269,6 +269,39 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 1Gb (1st generation) */
+	SPINAND_INFO("TC58NYG0S3HBAI4",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xA1),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 4Gb (1st generation) */
+	SPINAND_INFO("TH58NYG2S3HBAI4",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xAC),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 2, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 8Gb (1st generation) */
+	SPINAND_INFO("TH58NYG3S0HBAI6",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xA3),
+		     NAND_MEMORG(1, 4096, 256, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops toshiba_spinand_manuf_ops = {
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index dd4ed257a83..c62096dc2e6 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -18,6 +18,8 @@
 
 #define WINBOND_CFG_BUF_READ		BIT(3)
 
+#define W25N04KV_STATUS_ECC_5_8_BITFLIPS	(3 << 4)
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
@@ -121,6 +123,7 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 		return -EBADMSG;
 
 	case STATUS_ECC_HAS_BITFLIPS:
+	case W25N04KV_STATUS_ECC_5_8_BITFLIPS:
 		/*
 		 * Let's try to retrieve the real maximum number of bitflips
 		 * in order to avoid forcing the wear-leveling layer to move
@@ -172,6 +175,60 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N01JW",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbc, 0x21),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N02JWZEIF",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbf, 0x22),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 2, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N512GW",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x20),
+		     NAND_MEMORG(1, 2048, 64, 64, 512, 10, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N02KWZEIR",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x22),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N01GWZEIG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x21),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N04KV",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x23),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
 };
 
 static int winbond_spinand_init(struct spinand_device *spinand)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index b701d25f73d..81a7b0dbbb2 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -266,13 +266,16 @@ struct spinand_manufacturer {
 };
 
 /* SPI NAND manufacturers */
+extern const struct spinand_manufacturer alliancememory_spinand_manufacturer;
+extern const struct spinand_manufacturer ato_spinand_manufacturer;
+extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
+extern const struct spinand_manufacturer foresee_spinand_manufacturer;
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
 extern const struct spinand_manufacturer paragon_spinand_manufacturer;
 extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
 extern const struct spinand_manufacturer winbond_spinand_manufacturer;
-extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
 extern const struct spinand_manufacturer xtx_spinand_manufacturer;
 
 /**
-- 
2.45.2

