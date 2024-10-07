Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27DACFB44F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 17:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD4C886B1;
	Mon,  7 Oct 2024 19:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Q24qUrCm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F4AD884D2; Mon,  7 Oct 2024 19:47:19 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF88884D2
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 19:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ML9xtiOPeLRfyCZBgHyQ4iUTyXkAzBO0lTRsIrjy55+qQzoKTNPwXYv7EZTdLTNWK+7J6jwEF6kKFsrKXIT/DiSTCnISyt0awBobNq7xYmJYa5vpO0DXq8Tv95ac/bdCIJga9Kt2bwXV0ZNx5L0ZKMHxmMrtch1PxQ28SyCuUME5t2kB6bJVvuN7pRPE0Zfqp8RBv/yXv2Zg6vvJNDzkKgLSSzbCu40RTfJYeWzafnYNqIgSp2N+kxhL1++GMab6E8PGBm8QjDxMovU+9NKzgT1nfL51sfJLz85blcg99wht0D44w/nwNO+Td+Vv+rVHcdw+VLiMrtjtVqLlVcMCUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R5zKjho8Kjgy2keLqTXCC5Y6WQ5y7rArvL/8e8KpYc=;
 b=tvp4J3oppncv/MhStlhQSXPHn8mWEYANqvOxff+QklMJEGVPvKf5GskdOzVARVs0IQ9ceNU+HEYl6VQ2EuD8GfE1ep0+h8RyOspsRywVDqiuxP7VdMx2pxVd/OK9xWdvKXQKTHvd+ixxm2u65jOAXbvC3kYgmLoMl9dJptry57xVv6jb1dM/K1PAnepgBcIodu2qejrSkXmoVWr3T9VXJh5/QAnUlq3h32q5z4VSw5WqE463A0KXoRFQYl6RO2oFCBnarloXB2dUsI7V+6BBGtsUOeESmWeTia4JhEc+FGsBAsKP74HtqPa7KEB61SH1otSt9HTvYULw81WqWHvbWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R5zKjho8Kjgy2keLqTXCC5Y6WQ5y7rArvL/8e8KpYc=;
 b=Q24qUrCmY8kjOJJZzwPohOLDqcpNhTYFX4v7DkUDv8v1cn1HSfkNu7RymKCUy+Mmt4RtJNCiv8Nz8vU6ROR8RffhcxSnJDfkKbw3/4tNOOQvsQQLCchVJpdSngD+dRERBgLYnUHRozoXP0VVC4p0hLzYKop+BDFKbx4nYcgsEqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB7797.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Mon, 7 Oct
 2024 17:47:15 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.013; Mon, 7 Oct 2024
 17:47:14 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] watchdog: introduce separate SPL symbol for WDT_GPIO
Date: Mon,  7 Oct 2024 19:47:16 +0200
Message-ID: <20241007174716.1068936-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0075.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 81878548-e8ea-4461-9f39-08dce6f8145e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kPXT3RhL4jqKO76w5eD+G/B9AHpEh1ELlg3B3mAKbj27a+yJLjjuj0sWJtrr?=
 =?us-ascii?Q?Uy7F6z4Ezh5decD+KiCtrQF1fXojnE1Hnu6ehRHI0IiM/dkIvI+e5vLGpJr9?=
 =?us-ascii?Q?/EbP7ISB3NvPWatetszzCdtO7zwxRGloFh4b+YTqJ6UxgrKCuzvZ8vIlzet3?=
 =?us-ascii?Q?945qjAvgYJRvizBs5r3DMxK6evhqTLUODoN9vsVAXLg80dOGQSJhjzHiaiiP?=
 =?us-ascii?Q?RSkhCv3d/iDqVE0bXxOZ5KO1StcVoAY3o84WU5MNRzYoYbX3D2wb8LOtPLSR?=
 =?us-ascii?Q?cbGZWYP6s7U1fcT0VXGClmYlOmWnI48KonIyx/WA1iQLDmx0fTcPFVdrUjfm?=
 =?us-ascii?Q?Xqaj3wi4Fkgk7dZYAdG7C1ubIEqdbogdLFJBz/shzf2GYc+ePyZPzbWD00ab?=
 =?us-ascii?Q?zcOD1UuBQA1d2nJeyDkK2u+0OJ+jE75VM3k9J1Y0rLnTyCCSzYoRHJAevCSV?=
 =?us-ascii?Q?EFO5lcyDbINDRoAQMrlWU7bK4mwBsehLKRa4kSn+97DdswEKwHgx+pD+Yg1P?=
 =?us-ascii?Q?B14zQcGCxR7CRlxHGnCGnZYgR1DWkdG79/9VHkxCQm2iJAfzhxpuGFX4nxu3?=
 =?us-ascii?Q?UbiKuoMMVKoI0yIilKIX9b1BhY87JThSPHH8ctLzZlBcy+it6gjjKu2RU/VD?=
 =?us-ascii?Q?a36P6ELxriYIdAlqN13z6K0xCrQ6KJkojTuvsTlH0vTm/5oQefoGlAAA3loS?=
 =?us-ascii?Q?6a0ZrtdEhTAeB1aRCpOt5FLBqVVxDOFydVJFSC3lRxT7fx9JFa0sYWERarso?=
 =?us-ascii?Q?3cce1uu/MKc8FXvqV1t4DuuFEGZNOCQ3F67Zl3cHeeq35J5axQxQbSwPcNrM?=
 =?us-ascii?Q?KE3lPwWtYp3NoQvNSlAF+OM4m8eIFMI1mVKjypptgmtZ12RBGQt7kxfpdTc5?=
 =?us-ascii?Q?wTEQuC7TQTU34/7FD+uvPMRCF5hyrkBoq8W19uRN7lgb4v7qyWAUm1XBmZyi?=
 =?us-ascii?Q?C16zYYiqFS7ZmybVio+eQCZHZWhebISEOFFuK12bjVPkA3TkoAWLS7VCVqYB?=
 =?us-ascii?Q?CouipsTf3aOU61LYdVqRFeZ3PFaEsu4cChTN8j6NfS+GZFtbWxiQ/fifN9k1?=
 =?us-ascii?Q?8siFqiKxhTOeLKsWGh/qKFkFPSAshNKRgkBB6l8CzjRC31GXkHyd88q3SD6S?=
 =?us-ascii?Q?3SCBULjlUXYPv6KPufpPTba5QOA5me1TLdvy+KXH4elYSOTz+V42cZVG0HBv?=
 =?us-ascii?Q?rQaHzOcvTidwVpUbwWrBK87Pabez14t1T/Gd/C7ZA0JTWHqOjvpQzHCwPVjk?=
 =?us-ascii?Q?8oZ6c5qo6OmOs74y6EgVX1xphANxuEBN9ViPguzr5ChOgS1qOJYbc74DCxZT?=
 =?us-ascii?Q?l1U4qq++dpW+1SF9kzWTvcALkMguKCCL1yGsrQavoq+PYg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lc7vm/oKcMmg8KH0ZUa840HLN0jTXGiSTT/aR5QZq8rZEGzPD/1EQ2SDj0wZ?=
 =?us-ascii?Q?RJEwZ3mrwBvwTYjwIcGRo4nNfJfTV9kcSM+GlbCpv3T4rCRo2TJt+gTFcO/s?=
 =?us-ascii?Q?niVo5cuKkmivOvnlghpA2x20jpuY6lfWsvVDNYT9aHLFwcVADChU+pD0V4u/?=
 =?us-ascii?Q?J23ERNHP2xSSn1oa1DuiNEePIUsV+dJEwAfyGoxzjA7R6JxREpTZXQC9Z9e9?=
 =?us-ascii?Q?0bIfqTkZZX+1QyKFv7yUgcgq6uPnUhqZYM9qqflzTCF1aSGnnEE23xkALruf?=
 =?us-ascii?Q?PCQDZymwUl0p5rYk13EQCic+W37w7AkFZc1kfapPA9ENEVX+OzrZKC7Vlojj?=
 =?us-ascii?Q?r66lNwKoEnqODC4Oo+j+RQzbs3K7475qrzFRLrMTB2W3UocnoqLFXuWXRJ/a?=
 =?us-ascii?Q?+E1i4ythnA2wv57NryEwCz2mIVgfX/53Opkexi6iiVB8INqhtIBk7VwMSZWa?=
 =?us-ascii?Q?d5PjUO19w0wip9GsPWovj1gf0RVNT59rKQIsO0R7BVWbkAXv7jSUWifhx+Fw?=
 =?us-ascii?Q?/gZskdYCy91JLqh4zAcACDiCQYa8+LKwFMQptaQSIsYlZVMxgw3JwmIzz3+h?=
 =?us-ascii?Q?ZkA/475OkabG5LWWujkUh93k///gRx5+/LSPYSC2vI5ArwP9mAuSbcUFVL9y?=
 =?us-ascii?Q?W/QF0lY6p6s2RnV16rD0Kylk1WKTGVMfRlON6wsk0Vqil6Su+m9vzv8o04Ne?=
 =?us-ascii?Q?MFrGOfwsMPXMn4x7ldOEJvxQXHFbEqIUnZ5A7sjgVguJfRMOHnACyBp7X1os?=
 =?us-ascii?Q?BXx44bHnRfY9CVCnz4oeXUA2CV0x8D91ewR1oagORAISMYadFq2tAxbrRCMa?=
 =?us-ascii?Q?EUXhUQReEEof5lWNG2Bd/hdwC1Q+73bQ6hjjrjnhsachSpZl5lbW98nQtgUI?=
 =?us-ascii?Q?6lNy0KqL2hbCTAAb4NLcNGgHsnmKtey6kfAmGHewiiJ2Bh9XbxszKb99qJoq?=
 =?us-ascii?Q?PMt2tR/St2f6aoBTxKeVfX9oNNoLlUDoAMiYfww+W1mr7YPBEbyWhC+smTB7?=
 =?us-ascii?Q?QE5lZHFoZQRAy2PYLjxo+nlajjNaVH1Au0njtOuujCyitK3TrNUabEPTGT/N?=
 =?us-ascii?Q?zjRKqqL2cnG/iCGWqXRy7mVegDqWhi8ZPnOS72IZlwW9myBT4dc2EcGPj1Jv?=
 =?us-ascii?Q?ouy856xKsLIAqdSZadlAXEOnDGGQhriOj0nQ/uDUqfC6WlLPfSfSp81MBLyS?=
 =?us-ascii?Q?u47brWGKSvd6YhkwKtT3RHtq5654fMi5p/VIsyA5BN2WuhOcLWCLDM3/BGj6?=
 =?us-ascii?Q?Kp38VascZ9rDjPhkMIiw+A0SOCJruhCa5hFkCdPprSaSEXXXdmApU5afAxHW?=
 =?us-ascii?Q?EhrNcmuYLV5AW6zHi+QhoF3p6HY/b2vdwIumoLhRAISlJGgu2WuS2a0WYAZ5?=
 =?us-ascii?Q?vvblalnyZMWrPbkLSWqV2Tq0XCcPoMqEW/+sHmcQzZesGicMAor+LNs7spVA?=
 =?us-ascii?Q?pSADOg5xEjlJ6nFg77WpCHiOWfGZuMlTvaSMTNHHHbSSqJE76L6n2UkZPinm?=
 =?us-ascii?Q?cg9nCTvWMs6lsr9QmVkXxhCPg/nFHsFZRt6eaM4hJb5TrsZihCDQ4Bvzrxtc?=
 =?us-ascii?Q?5YJtm59Z9r4fl7PLFf+7E0TSk1sdLQOqQG/4iXXamLSdg9dPDoEaoLiNBbec?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 81878548-e8ea-4461-9f39-08dce6f8145e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 17:47:14.8741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thT//vlU4yxUJQRX5IGGlCR6qgKYAfzWN9Tuf6Xanrpm6n6ebnOdmHyAN3b39H2dlGi0AgYzgC84Y0ktZPoUFOWbq2i0Y3tn4uieBmnu938=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7797
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

Currently, enabling WDT_GPIO on a board which uses SPL, but does not
have SPL_WDT, SPL_DM_GPIO or SPL_OF_CONTROL enabled, breaks the build.

Make it possible to use the WDT_GPIO driver on such boards by
introducing a separate symbol controlling whether the driver is built
for SPL. Make it default to WDT_GPIO such that boards that already
have it enabled and all the SPL prerequisites satisfied will continue
to have it in SPL.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/watchdog/Kconfig  | 9 +++++++++
 drivers/watchdog/Makefile | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 0c3e9913318..18028269b9e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -178,6 +178,15 @@ config WDT_GPIO
 	  doc/device-tree-bindings/watchdog/gpio-wdt.txt for
 	  information on how to describe the watchdog in device tree.
 
+config SPL_WDT_GPIO
+	bool "External gpio watchdog support in SPL"
+	depends on SPL_WDT
+	depends on SPL_DM_GPIO
+	depends on SPL_OF_REAL
+	default WDT_GPIO
+	help
+	  Support for external watchdog fed by toggling a gpio in SPL.
+
 config WDT_MAX6370
 	bool "MAX6370 watchdog timer support"
 	depends on WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 7b39adcf0ff..a450c33b3ad 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -30,7 +30,7 @@ obj-$(CONFIG_WDT_CORTINA) += cortina_wdt.o
 obj-$(CONFIG_WDT_ORION) += orion_wdt.o
 obj-$(CONFIG_WDT_CDNS) += cdns_wdt.o
 obj-$(CONFIG_WDT_FTWDT010) += ftwdt010_wdt.o
-obj-$(CONFIG_WDT_GPIO) += gpio_wdt.o
+obj-$(CONFIG_$(SPL_TPL_)WDT_GPIO) += gpio_wdt.o
 obj-$(CONFIG_WDT_MAX6370) += max6370_wdt.o
 obj-$(CONFIG_WDT_MCF) += mcf_wdt.o
 obj-$(CONFIG_WDT_MESON_GXBB) += meson_gxbb_wdt.o
-- 
2.46.2

