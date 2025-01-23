Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0952C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 01:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD3EA807E0;
	Thu, 23 Jan 2025 02:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C34E080137; Thu, 23 Jan 2025 02:01:34 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20715.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92FDA8001F
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 02:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUjlJdPlm7c37zfWwexZB/hpjIn1tZruTvCXIYcpmtd7fHm0ESIMcWxmhI0x/NMc668qw8z6aw9ZQydjmfpY5UlrDAmGK09MkyVdYeW2tksL/F1pGBOtKdNQ3wHKuQToFJm1pfx/rbvZ2rSqDUvyH+pFXHX7tMD8hghT86uMnVqGeilqTnzw+FYpgb9lakfrze/JSXuQzJuteEwvX4+zkAu6lCOQ7tLdVeLKf0psT/H0HoIsZPU9szUUJ8W/irzPD/CuteDn7JPJlnt+Zj2XqdWAi23eY6Cbnf8uxmsU9oDSizUsgeKNh73QRpiFAg9CcfCyBF2AU4bbIHrq71zxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DGmX8r7lZapjCpkzo8ev3Mc1NDhiOS+FKo0o91wADQ=;
 b=ge2IKuNBPlWy6pFUTF/l5R2o9kU500BtfoRRwX81b6Z0RRw8nYudUooZH17TfSsLkushytYCrmEe9Vch9Zefxi4pHnVntgs3GQJAJcQ21/09PT7m8Up4vg2mQlBuILj1UDRNdt3eJ2ypb9fbRJ/PJ9oLbwxm3vhot/k5y0M0UAJKykuiLdFR7g2KfcCp+wQ2FOHYUHps1zcctF9LcMX2kJATiem7ZRDm/yCq+gwHap4PmUq5XCTEIVv4jgsyqR9RI/UXPXVJy7QYSA8lnPZ9wqCpYxM80aE1WnVtwxCoZX8kZO3Er/VWmzJsNQeU9fYRdtB0FzJE6HeejSc1888dxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0813.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.8; Thu, 23 Jan
 2025 01:01:29 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Thu, 23 Jan 2025 01:01:29 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v6 6/8] spl: starfive: visionfive2: Disable USB overcurrent
 pin by default.
Date: Thu, 23 Jan 2025 09:01:10 +0800
Message-Id: <20250123010112.78924-7-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250123010112.78924-1-minda.chen@starfivetech.com>
References: <20250123010112.78924-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0029.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::10) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0813:EE_
X-MS-Office365-Filtering-Correlation-Id: 55bdf9f4-0cf1-4b73-40a1-08dd3b49786b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: nH8eQYHtRebjXvGsI+TI9cyEY1X4fWhSBYYLugz62KMR6hIkZwGwg4anihCcs15TiUDEhOUYjQTsdOfE8iQrMqQveQ0/F0VS1JfQ6x+/cfPHNcCTHKtfQ40OFMknc3Bwt0cffHjzjFTZ5Q3WvbwPDH+p+ltRZIvdpDBW27LgiWmz85fPyqeL5svwzemYXzTg2Xtg8VDP/r2HueMYrjaSl7xUkrVsJseEBwEHEt+76G7Gf0CFahv0gW9QpYLnFtelgWzQTJZAy9qXvhZrK7czFmqgcFLTmyXp+AdxLt2bbvBFY0Wo88iCCh7jGMDlWoMpR8Pupd8F/ufdM/oU4KZ4x8BBY3iE/tUkiN0M855TPimQqgXb+X1GnEGL0UejWMs0oL/IVSwAY6KWFIPnct/eQtNMMy55pftQtkihigxdxD99bHi77xeJIOq24x96cJmLZ1oCAQoUW9CtLXD0zwU58z+QEJgHa6dM8VghIeM3V6+tkPP5dX1IsOcDzCxe5/3kfnRiST9T7zsHn6yDBmP4nHtBvMr83NbJ1q3R45AZ49/q61rYQkPhPWANxOCCalYKXF1S022lM3ca6JT1HgPBlfKUZMe/v+okaOgd6tZmz8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?keG4w9HmlGbJNyaiLTN6ESQipJZeHFv7hVFLdWCskrb5f24EYG0CTl/oKc5h?=
 =?us-ascii?Q?OuDPXjZRC4cADhpSRgdQIoA4sH0x4XjMJdhFDcZAOQiBwNRRCRPTzzhJWP2r?=
 =?us-ascii?Q?ZcCNI4PZcfAjylffRYI1xh47AlOsQtZbSk6cGOHPWPndX9k4+Bj0LcaafFRV?=
 =?us-ascii?Q?ByaNK+OjKWKkSIuBp/Zdz8UhuV8S7OvU8VlgMsjtoUtAWbHJ5IDn4hA3M192?=
 =?us-ascii?Q?/gfcm9mKnW6YRtOfw/WLTRLZU7JhCd3JHNpjY3MGQsUAURQxywxs1xUUXIil?=
 =?us-ascii?Q?eV8gk3hOQ9EZwi4Zu1sV+klWmwlth1ojmZn67dVcjxylWAjsjp0zJIcl3/Nx?=
 =?us-ascii?Q?HnJitJPdV7k6bTIYckobIFTEfB6WBs8nkd6R/m7Z8kOmQcd6xR/nZuYN/qsg?=
 =?us-ascii?Q?4vVInXl1nBIm9F8EI36O4J/oVGFbkyLwECmaYt2Lpb7bbhVI+3cE+tWBvTGN?=
 =?us-ascii?Q?QGDPk6BFlcu+PH8agxsc+qEFJJVUdmaL0gScR2HQ/1R3MvxvQqHQSgKg18ix?=
 =?us-ascii?Q?AparloJgmIXcM56s7jY/uyLxZ+i903UCxmf709vjuNN0Wl4cum6oPyOgymMV?=
 =?us-ascii?Q?THARH+ms7GmHT02yYoeMw/7dq+fKjiv5+VEulJeN1RJlJOm2JlSYKsUGPfKV?=
 =?us-ascii?Q?tTxcgCStE320wsLWcwVxdcSbmRMNft+tqG/kz9FmgMNPl4b6s3X4QqA1phqH?=
 =?us-ascii?Q?yC45GP7qd3XwkW+tCfVN9ksw9lyP411fjAADv7b8l/WicqkCGd5wgV4Oh460?=
 =?us-ascii?Q?LaAfkoEVG742mWBLhxj8zbWWJw9e3b5kKJcB4lRZ+a++0+ppAn3kK7bcq6Zp?=
 =?us-ascii?Q?nI3j69vow7Cz7DO4khOTrbhAOPJPKU7Cf/bBQZvAvUvR2J/0ZX+HY1SzXxwH?=
 =?us-ascii?Q?NnvidJs8zmP3lS5CvHg8vJfDcMbEVgFbi3m9ZFHSRP/wSTgEc61C7NyS4D+X?=
 =?us-ascii?Q?2C7YP6wquTwn+HP7yVChSHrl7mvUJtPbGYWNp6n+uXJ4/scO2twFP+9pW7eG?=
 =?us-ascii?Q?kjLFFcG7/N/aZFTPNhH344hknLTmPBi5Mg9QZKkrwa3Rwq2JdNTmgtDhl848?=
 =?us-ascii?Q?ZPbcZAkwi0dRtaXFqzh35EPnRtPrncw0zqt+EFq79YoZgDa5rpKbY42aBhMd?=
 =?us-ascii?Q?K5EnA8CtUFsdF2ic0WBbsYcrPlPK03uNpORXjuIWfwQpRM0sPX8iNW2mK986?=
 =?us-ascii?Q?fvv0FSLeqi8+ur0QBlUmv3xaCjyVV3clED+eybOurPJAE8/B/u52rm33exhd?=
 =?us-ascii?Q?zSEDQPpXkDZLZdL31EtWQ72GqDnHZNX1snLsWyazSnc74PHR1kWF0ThGRR7M?=
 =?us-ascii?Q?MNCReHK2lQqjP4Edc6t/FuhW5DwbKTSssYSUtlgzJK2ivmL8sQYkwa6/oD/f?=
 =?us-ascii?Q?kkGWWxDJRO13gtUyzETmeUptAUATOsnC0czTfsXDJD76AquK42bxCISKoj+P?=
 =?us-ascii?Q?QTZQ/FhL2Nans7UUT0/pqUaN8pd0B3dqpGumRUkRRxuWXH8PCp/0GGMs7XBV?=
 =?us-ascii?Q?QIg5AKHCn1O5yDOOIcqAlstoQioWmn79iQ5fw3mxI4tV7X1qfQ1tZpU4KN7l?=
 =?us-ascii?Q?kzGi6ZDEXYuocB+OWcVxObvTuz5YVrAeNRteJNJ28BAD/RkvcDZEDOUwi+YT?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bdf9f4-0cf1-4b73-40a1-08dd3b49786b
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 01:01:29.6719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ufN3JiufKTeC0m3auTeTMCPb5kgAbDuCqg1KZ09JaIv6YhYsIZa1Z22vmDLgBBT3QJ8VOOgde4HJXRda9UuDbQmI1ex7aSHnHtShtomwBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0813
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

For some JH7110 boards, USB host overcurent pin is not reserved,
To make USB host work, overcurrent pin must be disabled. So set the
pin default disabled in spl stage.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Tested-by: E Shattow <lucent@gmail.com>
---
 arch/riscv/include/asm/arch-jh7110/gpio.h | 5 +++++
 board/starfive/visionfive2/spl.c          | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/arch-jh7110/gpio.h b/arch/riscv/include/asm/arch-jh7110/gpio.h
index 90aa2f8a9ed..be2a1e0d1c8 100644
--- a/arch/riscv/include/asm/arch-jh7110/gpio.h
+++ b/arch/riscv/include/asm/arch-jh7110/gpio.h
@@ -63,6 +63,11 @@ enum gpio_state {
 			GPIO_DIN_MASK << GPIO_SHIFT(gpi), \
 			((gpio + 2) & GPIO_DIN_MASK) << GPIO_SHIFT(gpi))
 
+#define SYS_IOMUX_DIN_DISABLED(gpi)\
+	clrsetbits_le32(JH7110_SYS_IOMUX + GPIO_DIN + GPIO_OFFSET(gpi), \
+			GPIO_DIN_MASK << GPIO_SHIFT(gpi), \
+			((0x1) & GPIO_DIN_MASK) << GPIO_SHIFT(gpi))
+
 #define SYS_IOMUX_SET_DS(gpio, ds) \
 	clrsetbits_le32(JH7110_SYS_IOMUX + GPIO_CONFIG + gpio * 4, \
 			GPIO_DS_MASK, (ds) << GPIO_DS_SHIFT)
diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 22afd76c6b9..1538d6aec73 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -103,6 +103,9 @@ void board_init_f(ulong dummy)
 			JH7110_CLK_CPU_ROOT_MASK,
 			BIT(JH7110_CLK_CPU_ROOT_SHIFT));
 
+	/* Set USB overcurrent overflow pin disable */
+	SYS_IOMUX_DIN_DISABLED(2);
+
 	ret = spl_board_init_f();
 	if (ret) {
 		debug("spl_board_init_f init failed: %d\n", ret);
-- 
2.17.1

