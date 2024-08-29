Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456ABC7115B
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 01:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BE8C88B60;
	Thu, 29 Aug 2024 03:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A886088AFB; Thu, 29 Aug 2024 03:31:21 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20716.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::716])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41CEF88AFA
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 03:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBPACj+woaa1X2VKzgDOA+8M2rqhy2iNN3JaoGqauyL24cX8CN18kGPo9Sj0O/0CzCBCmHcf57VqFYjX2jZOEDzkx4fTqLy8FPXuwICVsmKHqtQiV8biB7NNuNEHJSx3h7solEVoOTJE/LRk84vG0RfgH2fU6uzZXywL07b2ODuOtUBmMVQN7EbfhHcCGszloP4il8ZZIy9fXpzOjDkEWWfw0rxyTgIWT7Uw7HoI1AIhW2mkXrEfSFX3bQxQtFpSQGdfzIZ5NudteUe7F1yEF5yFAlsO6VtS9yaLTKLXTVL6YkON4LargCXCJIc4pRJpXaAjSVYj7Y7fcjEoRDZbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOUo+yy46Y9rcFEXfdHlS13Mk1+IbIH6DTlgfTEUIWc=;
 b=oeEBwIXKbsKs+pdZyL2WxZXSYTO+JNc5lpQJJK9eVeSGUYmu2XQlRbDmpZEVsGl5d8Z8JU9cN/Ws/6Dy+426RJ2QNkkwZgLnP8GBHMtwCzA4OtZOI2TDfShhS2PzZaCmeW9eUinwI+oT0VpeN9BP7aCgltpgd2JdVBYQ7ILtRX0AokKoxn6FqZXg6kfas5m7Zoe5mju/vXWc2Vs73jfnlMTXcvGWXb4n4/KT+hg497/GMqS6R0qMHcqEZne0l7b1+ZFxSCmlECq6PGigwYcYKl+MlibN72TkZiPvah5gAISVh5Q7FQk27u11TxLljDsCo/5oYnPrKrHNeMKhydunUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0574.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 01:31:14 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.7897.027; Thu, 29 Aug 2024 01:31:13 +0000
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
Subject: [PATCH v4 5/9] spl: starfive: visionfive2: Disable USB overcurrent
 pin by default.
Date: Thu, 29 Aug 2024 09:30:54 +0800
Message-Id: <20240829013058.6178-6-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240829013058.6178-1-minda.chen@starfivetech.com>
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0047.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::14) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0574:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bfed819-9172-4ed7-7f2b-08dcc7ca453c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|41320700013|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: wcm8LzEaMsuMQ9Bv9L6YNfggOpUIdAr84inpGNinPIn0OE1ovtOQqNFrcY3p09qZwBzbhgGNcn6PfdV6fpWH/3uq4/RIEWfXdrVvvEATNovv/bQN9m2+YQGhNgpgrHAz0zpPAdRDh0q+GSn8i+uRATOPTArqOQHPVqUnpj0B+WEPUhYMNZQZ20d4JD8hCb1F+WoCTekTl/aoRCdCdhUCiSQhGS0QrVW4NYCU7qj1PN7v+kvVtXb1e4BQpYASlEGw3t3/RSpEWX9lvVTDvdlwVk7Ec+R3RltLMJgyNPBDzTEn7bPVf9kX1J1LGqfSoXWamfVtlg/hSAagzV3grBSGGg29Zjs8zzmu/ySuD4x73xwruDr7x1z32xm8S2fGGItP9DRAgXJubZmgSfUnn1ZaFJt0GP/A3kyLQ7LGQRvIPbIeK+RvA7zGOE281QgWKOQOFCaAL5+fIW7d6kMu2ZEAzpphWHKC+SaCckhgkR/U0rd4GRlwCBuByFykQ0oXyGPRnDRzrk4/G2u3UOtQ9fCYZQs7O2eHtejffhBbNZZFbXR9KQKCplbTR0Ulaxr7LFFxRj2smyEOfAxacoAyeSe8EiG9dpahdmk+abPT7DALWLER0lMkXpcm8I3JGzz0QHQwtEvqgw6UQbXdk+sbUWQY7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(41320700013)(366016)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JIcBTTqWxk3u8qh9ntb7la1TXX58iDlor6IJ1bYUeMJF8f+wWnK0uou4hRYr?=
 =?us-ascii?Q?Ldkykax/hVV7rcnDTB/bZPsvi2Qgk0ckj7PABuZNiR6+/Toy/H4TL6nUdMHf?=
 =?us-ascii?Q?vNmzsBjLNeKL75Ok0oYSx0RZYm4ljNTTrJ3D7tjJJ2ttqwizWrspc/XXltPF?=
 =?us-ascii?Q?20X3Uab800oIKuC/NMRPYW88dNv7+YWXGBzFKaUYi8dYWm16BwxgDAEcM7p8?=
 =?us-ascii?Q?uRD/oVgs6c2Hhh96z1wvYgpjUoDsoytBKSFqqjVrYhhQzKJiKRRPMMI8tqqs?=
 =?us-ascii?Q?a5bBh9sWZS92KF7BIqPsNfKa/jnpjzl+meAK4O51Nqqh7aXy0ZS29wkU6p1m?=
 =?us-ascii?Q?h8itMuSGEC8qmIk/s8ap0H1FNmb5XdXp9bPM6DXtuabzxSPz+WincOhoqmMQ?=
 =?us-ascii?Q?ZoBxNUM6x77pscdoLZK5yAByZdt7wkKzpqHP67ThRllV7ombRCpPh2k5mWzC?=
 =?us-ascii?Q?iG/zQWWWQvjaA1LCzS1S3yqKrGb8VsploSSuXWfAc8+qoGjPnXikODXPqHb2?=
 =?us-ascii?Q?vacKihGvrqsS3cNmQBINcs0KDwOeob5ETMwlZkgk4LZWeVSwJsRJ04o5eoDH?=
 =?us-ascii?Q?jGu2Vhwxsswke+MdlKk0GbPKoJLXjZQ/V19WmCG61gQyHsWArcIRXoIEcJFk?=
 =?us-ascii?Q?Az0tICAqQkMHnIx+t+TLxX1PD/1fXI/iS/uOjQmHsiMVQvjtzdt5H2Hubxfm?=
 =?us-ascii?Q?gdveikqZXtnMORGyHx5XB+bvOiW4bYDGuYfklRS59Wd9o9g0ZT62f/qmsL1J?=
 =?us-ascii?Q?W8VuagSv5OOzmFmKEhUyd8jvBy4wFxmRD/XIrTRVtJ+vvxWGd9jMa2aGyomq?=
 =?us-ascii?Q?+XG8bZUQ4otOljXd3pui5yHpPtYWoJcDaFjom4CahKLuHgzU+2NOifFfz0+a?=
 =?us-ascii?Q?GIVkwTdfA6jaFGM5BwGjCSeFyB9TZh8qrsPcHw2MoFf3Y8dtl/KnESq/vBOa?=
 =?us-ascii?Q?rsQnTi+74nZANyZ+JGT2sy2bacOMh0dY4rQl7+wEQjFoRb40B81XlMXujARI?=
 =?us-ascii?Q?37qc6ai9xl+CxkNcBo1jTGChfxFCVpUuiKnSsFzuqM8pnC42cBJ71Pc6nl7b?=
 =?us-ascii?Q?ajA05kYyAfWTLOIecTHtd5rS6hAiGsH1FXsiqXaO5/o+rB6HIO++pc9e5bel?=
 =?us-ascii?Q?iUSwc8l56EGvLwRIt6FTk4kGY6QrZKdUctVuCf9HIk3B9uSZHAXfwbHd/vXY?=
 =?us-ascii?Q?vAho1m/SGyUw7RUQGV/29ktztD0GHkzOPCZLWueJyZlAiA55JMNA++7If80S?=
 =?us-ascii?Q?mBtROtEl9nmLRhCCBz5UxSKpQn8KT1uYNk1e1+vKpgTv0imvkomngLji3PCb?=
 =?us-ascii?Q?L3qrK7Q62E+VgnCDicr2SDBeXfDkPMDH9/NvybwkPuP+DvAReF67Tm/LW+/K?=
 =?us-ascii?Q?+seAfI776fycqHAvCC5TmJU3Wf3/izny5y5UUzo5ctrvO2NJPnQ76Wk94WV5?=
 =?us-ascii?Q?7v9Ds8BvKIW6d2/D3ziT1MH2bk0zEFOXPoKF2XhotXPO9n+iySTlSHEyOOkC?=
 =?us-ascii?Q?cKa1+Eetxp/Wd85JOsLpVUbZsViQm01l01odNVXEKTWFGot7hBKBCKd+N1KN?=
 =?us-ascii?Q?9XAjPom8XEUEBcUSVtpHbxHMg52viDnpvWTumfZYGTci8If4c3VmvAAjdrZQ?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfed819-9172-4ed7-7f2b-08dcc7ca453c
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:31:13.9569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDcSMV4NV3gkvaFb7pKBPGoSSmEeV49OMdHctKw5dhc4FoQDeRTMyY1TuCxzHbD12g08ZkKa+95xpfywSO9Clt82HRV7vFYKUMi5lA0ER2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0574
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
---
 arch/riscv/include/asm/arch-jh7110/gpio.h | 5 +++++
 board/starfive/visionfive2/spl.c          | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/arch-jh7110/gpio.h b/arch/riscv/include/asm/arch-jh7110/gpio.h
index 90aa2f8a9e..be2a1e0d1c 100644
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
index b794b73b6b..388a06e4d9 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -452,6 +452,9 @@ void board_init_f(ulong dummy)
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

