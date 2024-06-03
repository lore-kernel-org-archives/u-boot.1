Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA36AC25B76
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 13:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6ECC88350;
	Mon,  3 Jun 2024 15:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F359882AC; Mon,  3 Jun 2024 15:27:39 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20718.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::718])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B1EA8830C
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 15:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPgdCRdXxToi0FUeVqtMl+6Jss8nbyy92ADp2MkTVIPuY2NFJbOsBxxvP6mkmeQdf4x5kUGGlOCLIyf1xE0eL8qBVfYSUIn1wpLEPylP4t1JdSP6nJf47u9deAnO7dr9c6dcvTBwJk4gfhss6dmSuYeiIiNGK+HN1PBmyYlj2whrHVNgPgnLNAB64BG35anlP0X+ERmrxBpn0kCJx1qVYtPwXRlgG3y6sK80Iqd+6rPRLeUS7vRk7/8HvcW8D7NfkTDe6bBOt03WXQnhhItQCTZFqXnR5FYwKmmeN5ZDNq7oZs3iw0EhoZGD1GTB7IQ3fwqhIBKKuL/K7tB86D9k6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3b/xIXcmZPF98f/rnmudhC18M9xvexhonbF9B2UDBw=;
 b=MFhtDDnbg4hRintOcGnlpivasOy9YXjP7pllx0t6yukfJABoT2aSqQsTJO0OKH03SXRZ8Cd7FWAbB6sDpwYOMxnnZOV2xUJw2aafbfjNNKirQXXGCDBpGz5EBZtSCrFTDswrB9tZimLJ3gSTxdrEYLWZx8RdAntgcX6PoDde20uxPGwTQEZ5HuCnUfad/r+QKMY+E++fcDW6RpySyP7e7m4Ar3iqUJ7KcdxlLzJlcXGQMSgrP004J1ZYm6nkDbcylhfCtYEBe0bv/C7zG05zmSf9YXKZaQdRCo3MS/d6D4z/QIb0Y9lK3M3suRt1HWhbtmA8L3cig3xU5VA8DW1nEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1242.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.43; Mon, 3 Jun
 2024 13:27:31 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::61c0:a8fc:1462:bc54]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::61c0:a8fc:1462:bc54%6])
 with mapi id 15.20.7587.043; Mon, 3 Jun 2024 13:27:31 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/4] dt-bindings: reset: jh7110: Sync with Linux
Date: Mon,  3 Jun 2024 21:27:19 +0800
Message-ID: <20240603132721.6522-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240603132721.6522-1-hal.feng@starfivetech.com>
References: <20240603132721.6522-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0029.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::10) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1242:EE_
X-MS-Office365-Filtering-Correlation-Id: a40b3a1a-cb4e-409c-479a-08dc83d0ebbd
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|41320700004|7416005|52116005|1800799015|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info: vYhii1KHqTrzVedJQQQAQMF4sup2iAWcr5YOj9g8qXxQVvDheYNx+k3CGGqoonuPoaP8+ijmp3qf5kF3eTq9E848kpXA+5i5Pr8MFXYFEurcJOW1R0C+N5cad/Y+HOf5Sz6ghbBvunrjNaNiNRmHDBiDnL6Ag3B/VQvOqThVYigujX64TlhpjHGE/3+/JEcSYbiAbScgPJzb/bVywNV7UVvx22PDP8eSgkhgYBDle/B3IAHlUVJ/OmwD1J5/xoAzX1G3C9Q/8uqprXnzAJLR7pZFwfkApVOLwDPFiP59+udeTkeRjLrdu9tGrULsSTyAR3kM9rlKr8DxExqAGRu1EJAhGQ+V5jOD72kws+G+j26mJHLWBQqlOnFNJtfHNttxL7N2AVv3Dqd5LGlEWl/9SIbyy7avk6lbg22HU8xpsutLlJ/lGCvjuO/1Dl+W3Slk575gCYoWqoBPvL8e7vRnH29Ri2TYa5qjdAEBFoz6m8eTJ+ado7dU2ru57KjGXOjLlUbOedCfi8zS838TUm0xPXKxEnSGY0/2Zu4YaQgpe+NaRuq6K4Ed8BrE7nPqinLeS6B+u+NsbJbOlx6aY/5eftNmHK3SCBP9kusBClW0qZJH9KXFS6mf0n7sFaQR2U9RjP1Z9rs4mVx3hbLHMVOpjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(41320700004)(7416005)(52116005)(1800799015)(366007)(38350700005)(921011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3dPbNblLP3O6jswPzZDhciBMpjfymD5+9d3S35W0lk9pExtAc9utmsI2Huyi?=
 =?us-ascii?Q?s5ja/SHcoa7BMhhFtKPoDuTYAsrnsSxZtrUA2qqiTMUtkTZ6vuZhDV+/V+LO?=
 =?us-ascii?Q?X5bkHuY+9iaPORosFiwvFZLVaqUSGa24pjZwbmO82LQOCeLU2YylWoWWgw10?=
 =?us-ascii?Q?UWhTRQvWsILtTHkWnx3yAA4GwwB1ALLcZJmWQIxQ52WM4z+Ac57QVLXFE0s3?=
 =?us-ascii?Q?MTFx611LNBGeA/Wylf6Fj0uv0d9c9QaLipOIjCoRV+4apqMn/aBh0vTD5D5H?=
 =?us-ascii?Q?Ep2zJfWwU1vOGxiV2cjdRqj71BxDTybZv6aykaYdeX4Bf1Uziu77vEmxInYR?=
 =?us-ascii?Q?vMkUoxkimx9YEvBL69sHYedA54wDhMi6ZojQbyFuK2+PUvVXsBMa2g5aEUgy?=
 =?us-ascii?Q?VE9Kx2bS77ui8txi1c2MGsq2b/imbZA4m48Cbl1uV7Lrq38kMBfDDgXDJI+7?=
 =?us-ascii?Q?YnXoUKS5EptZ1C2iXNtO2JnwkstVlJ55XtvvMizGFnjSZ3CD7e9GIEwZKuJI?=
 =?us-ascii?Q?gk894xNzTvnU23oxget6NQ0QYT7Igg3EFwcjNIn/JTZk2ScOt4jp+dmLMOGt?=
 =?us-ascii?Q?eBtTmVLjSlEULIxOpaH5EYwE6Gds39Q0sRwel4NY5mqboBxusWBcH7Zz+cns?=
 =?us-ascii?Q?yAAr/7WvT8otWyG0R7vgYqSzFeRR20Txk/63aWXaiQu2pwEKp5Xlkmn6Ze9Y?=
 =?us-ascii?Q?H71rH4MA73sCAvibHsJh/EGmxek+Mx6k92622tOl47ArfqOmgiIMR8VflHEC?=
 =?us-ascii?Q?KGpUDX//ls2jmTRYcd9Y1HVOQNlOvtqmMz4NZcIeiXC4HBdtsHzQb4loGSlm?=
 =?us-ascii?Q?y7XJjxeTTPN8JOaaE+RgTN44G5vMQqhaxfMbDEVuRXjJ3uqDWoykq7MzrJEZ?=
 =?us-ascii?Q?1bS0XLu2v227Fj0uJfh7xsyf/7vxWoQruYHN8uy3YPaitU+CSNKHwvVis//b?=
 =?us-ascii?Q?Yvy0nP0QlnSkC4BQ4FYJzRXu5qjyGlPxH3B5Yy2HdNVWqK/XMnnI/MfGcysj?=
 =?us-ascii?Q?wUv8oLl82A7O7T3y1y3A3Clcyx/bTz+uCdC5GVsy82LO+JFCoyyf3y4UNXNL?=
 =?us-ascii?Q?qCz4iMQZmMd4rINQsZuMATeIso9JIKvQQ/q8xhCMhY9vwBBF51F13o8GWQ6R?=
 =?us-ascii?Q?6bo9SfazLn5tFvJsBXV31wKw8Rb7GfhVs8KI1YOgiVGsjUglcpYgZ5053rqK?=
 =?us-ascii?Q?HYEvXnJUe/LKoaAe9dq+7W+NKy56rpn/GE2YDXfRu3Hz+OMiLL7PeaimKz6z?=
 =?us-ascii?Q?3byqGRSOj4Kc6YyYUqQJcol1KpUNLKJOyORQ48t6FtHr9p8vJtdG1b7aG3Eb?=
 =?us-ascii?Q?a8HjqzbbE2V/MuaQHjTT1zVbypl8KaB42YJ8uODM0YvKo2gVrJz9CtAYbiYD?=
 =?us-ascii?Q?bcBfmkSSQpMY82Vtlf0Do+wcGFRoJwG43Kf5hOQt4Mky+E08jk01pERAUl5m?=
 =?us-ascii?Q?yXQCZqb9hrEarYzdWGkp8xVNJeQOfNaqNbNU2Kd5FvjOnpDXeDmyPx7qLnJC?=
 =?us-ascii?Q?2rbdAKJCAytwlvSZwM+AbPLZ6LVOCyxlnRFxQ/nJWRl6PMPCr+AH7RPufvlF?=
 =?us-ascii?Q?My2ZHRYisg18AKjSb48GzKz3pxnzA3QTUtMYe026PbKbXzJ5p2FnQaUKKzOE?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40b3a1a-cb4e-409c-479a-08dc83d0ebbd
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 13:27:31.2145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqGP6oEl41sIIQBUmKcpcRNf8XrOyFcDYLGGcAMdngMTWs84TJlj0J399fIgaXG7wy9erS/bQE0kOuVK2RbfZ8cwjBDUDnEsVzrk1RGJq3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1242
X-Mailman-Approved-At: Mon, 03 Jun 2024 15:57:36 +0200
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

Sync JH7110 reset dt-bindings with Linux, which is the same with
dts/upstream/include/dt-bindings/reset/starfive,jh7110-crg.h
except copyright.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 144 +++++++++++-------
 1 file changed, 88 insertions(+), 56 deletions(-)

diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/dt-bindings/reset/starfive,jh7110-crg.h
index 1d596581da..771b1aecd0 100644
--- a/include/dt-bindings/reset/starfive,jh7110-crg.h
+++ b/include/dt-bindings/reset/starfive,jh7110-crg.h
@@ -5,13 +5,13 @@
  * Author: Yanhong Wang <yanhong.wang@starfivetech.com>
  */
 
-#ifndef __DT_BINDINGS_RESET_STARFIVE_JH7110_H__
-#define __DT_BINDINGS_RESET_STARFIVE_JH7110_H__
+#ifndef __DT_BINDINGS_RESET_STARFIVE_JH7110_CRG_H__
+#define __DT_BINDINGS_RESET_STARFIVE_JH7110_CRG_H__
 
 /* SYSCRG resets */
-#define JH7110_SYSRST_JTAG2APB			0
-#define JH7110_SYSRST_SYSCON			1
-#define JH7110_SYSRST_IOMUX_APB		2
+#define JH7110_SYSRST_JTAG_APB			0
+#define JH7110_SYSRST_SYSCON_APB		1
+#define JH7110_SYSRST_IOMUX_APB			2
 #define JH7110_SYSRST_BUS			3
 #define JH7110_SYSRST_DEBUG			4
 #define JH7110_SYSRST_CORE0			5
@@ -29,10 +29,10 @@
 #define JH7110_SYSRST_TRACE2			17
 #define JH7110_SYSRST_TRACE3			18
 #define JH7110_SYSRST_TRACE4			19
-#define JH7110_SYSRST_TRACE_COM		20
+#define JH7110_SYSRST_TRACE_COM			20
 #define JH7110_SYSRST_GPU_APB			21
 #define JH7110_SYSRST_GPU_DOMA			22
-#define JH7110_SYSRST_NOC_BUS_APB_BUS		23
+#define JH7110_SYSRST_NOC_BUS_APB		23
 #define JH7110_SYSRST_NOC_BUS_AXICFG0_AXI	24
 #define JH7110_SYSRST_NOC_BUS_CPU_AXI		25
 #define JH7110_SYSRST_NOC_BUS_DISP_AXI		26
@@ -43,17 +43,17 @@
 #define JH7110_SYSRST_NOC_BUS_VDEC_AXI		31
 
 #define JH7110_SYSRST_NOC_BUS_VENC_AXI		32
-#define JH7110_SYSRST_AXI_CFG1_DEC_AHB		33
-#define JH7110_SYSRST_AXI_CFG1_DEC_MAIN	34
-#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN	35
-#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN_DIV	36
-#define JH7110_SYSRST_AXI_CFG0_DEC_HIFI4	37
+#define JH7110_SYSRST_AXI_CFG1_AHB		33
+#define JH7110_SYSRST_AXI_CFG1_MAIN		34
+#define JH7110_SYSRST_AXI_CFG0_MAIN		35
+#define JH7110_SYSRST_AXI_CFG0_MAIN_DIV		36
+#define JH7110_SYSRST_AXI_CFG0_HIFI4		37
 #define JH7110_SYSRST_DDR_AXI			38
 #define JH7110_SYSRST_DDR_OSC			39
 #define JH7110_SYSRST_DDR_APB			40
-#define JH7110_SYSRST_DOM_ISP_TOP_N		41
-#define JH7110_SYSRST_DOM_ISP_TOP_AXI		42
-#define JH7110_SYSRST_DOM_VOUT_TOP_SRC		43
+#define JH7110_SYSRST_ISP_TOP			41
+#define JH7110_SYSRST_ISP_TOP_AXI		42
+#define JH7110_SYSRST_VOUT_TOP_SRC		43
 #define JH7110_SYSRST_CODAJ12_AXI		44
 #define JH7110_SYSRST_CODAJ12_CORE		45
 #define JH7110_SYSRST_CODAJ12_APB		46
@@ -61,8 +61,8 @@
 #define JH7110_SYSRST_WAVE511_BPU		48
 #define JH7110_SYSRST_WAVE511_VCE		49
 #define JH7110_SYSRST_WAVE511_APB		50
-#define JH7110_SYSRST_VDEC_JPG_ARB_JPG		51
-#define JH7110_SYSRST_VDEC_JPG_ARB_MAIN	52
+#define JH7110_SYSRST_VDEC_JPG			51
+#define JH7110_SYSRST_VDEC_MAIN			52
 #define JH7110_SYSRST_AXIMEM0_AXI		53
 #define JH7110_SYSRST_WAVE420L_AXI		54
 #define JH7110_SYSRST_WAVE420L_BPU		55
@@ -75,11 +75,11 @@
 #define JH7110_SYSRST_QSPI_APB			62
 #define JH7110_SYSRST_QSPI_REF			63
 
-#define JH7110_SYSRST_SDIO0_AHB		64
-#define JH7110_SYSRST_SDIO1_AHB		65
-#define JH7110_SYSRST_GMAC1_AXI		66
-#define JH7110_SYSRST_GMAC1_AHB		67
-#define JH7110_SYSRST_MAILBOX			68
+#define JH7110_SYSRST_SDIO0_AHB			64
+#define JH7110_SYSRST_SDIO1_AHB			65
+#define JH7110_SYSRST_GMAC1_AXI			66
+#define JH7110_SYSRST_GMAC1_AHB			67
+#define JH7110_SYSRST_MAILBOX_APB		68
 #define JH7110_SYSRST_SPI0_APB			69
 #define JH7110_SYSRST_SPI1_APB			70
 #define JH7110_SYSRST_SPI2_APB			71
@@ -94,24 +94,24 @@
 #define JH7110_SYSRST_I2C4_APB			80
 #define JH7110_SYSRST_I2C5_APB			81
 #define JH7110_SYSRST_I2C6_APB			82
-#define JH7110_SYSRST_UART0_APB		83
+#define JH7110_SYSRST_UART0_APB			83
 #define JH7110_SYSRST_UART0_CORE		84
-#define JH7110_SYSRST_UART1_APB		85
+#define JH7110_SYSRST_UART1_APB			85
 #define JH7110_SYSRST_UART1_CORE		86
-#define JH7110_SYSRST_UART2_APB		87
+#define JH7110_SYSRST_UART2_APB			87
 #define JH7110_SYSRST_UART2_CORE		88
-#define JH7110_SYSRST_UART3_APB		89
+#define JH7110_SYSRST_UART3_APB			89
 #define JH7110_SYSRST_UART3_CORE		90
-#define JH7110_SYSRST_UART4_APB		91
+#define JH7110_SYSRST_UART4_APB			91
 #define JH7110_SYSRST_UART4_CORE		92
-#define JH7110_SYSRST_UART5_APB		93
+#define JH7110_SYSRST_UART5_APB			93
 #define JH7110_SYSRST_UART5_CORE		94
-#define JH7110_SYSRST_SPDIF_APB		95
+#define JH7110_SYSRST_SPDIF_APB			95
 
 #define JH7110_SYSRST_PWMDAC_APB		96
 #define JH7110_SYSRST_PDM_DMIC			97
 #define JH7110_SYSRST_PDM_APB			98
-#define JH7110_SYSRST_I2SRX_APB		99
+#define JH7110_SYSRST_I2SRX_APB			99
 #define JH7110_SYSRST_I2SRX_BCLK		100
 #define JH7110_SYSRST_I2STX0_APB		101
 #define JH7110_SYSRST_I2STX0_BCLK		102
@@ -124,26 +124,26 @@
 #define JH7110_SYSRST_WDT_APB			109
 #define JH7110_SYSRST_WDT_CORE			110
 #define JH7110_SYSRST_CAN0_APB			111
-#define JH7110_SYSRST_CAN0_CORE		112
+#define JH7110_SYSRST_CAN0_CORE			112
 #define JH7110_SYSRST_CAN0_TIMER		113
 #define JH7110_SYSRST_CAN1_APB			114
-#define JH7110_SYSRST_CAN1_CORE		115
+#define JH7110_SYSRST_CAN1_CORE			115
 #define JH7110_SYSRST_CAN1_TIMER		116
-#define JH7110_SYSRST_TIMER_APB		117
+#define JH7110_SYSRST_TIMER_APB			117
 #define JH7110_SYSRST_TIMER0			118
 #define JH7110_SYSRST_TIMER1			119
 #define JH7110_SYSRST_TIMER2			120
 #define JH7110_SYSRST_TIMER3			121
 #define JH7110_SYSRST_INT_CTRL_APB		122
 #define JH7110_SYSRST_TEMP_APB			123
-#define JH7110_SYSRST_TEMP_CORE		124
+#define JH7110_SYSRST_TEMP_CORE			124
 #define JH7110_SYSRST_JTAG_CERTIFICATION	125
 
 #define JH7110_SYSRST_END			126
 
 /* AONCRG resets */
-#define JH7110_AONRST_GMAC0_AXI		0
-#define JH7110_AONRST_GMAC0_AHB		1
+#define JH7110_AONRST_GMAC0_AXI			0
+#define JH7110_AONRST_GMAC0_AHB			1
 #define JH7110_AONRST_IOMUX			2
 #define JH7110_AONRST_PMU_APB			3
 #define JH7110_AONRST_PMU_WKUP			4
@@ -154,30 +154,62 @@
 #define JH7110_AONRST_END			8
 
 /* STGCRG resets */
-#define JH7110_STGRST_SYSCON_PRESETN		0
+#define JH7110_STGRST_SYSCON			0
 #define JH7110_STGRST_HIFI4_CORE		1
-#define JH7110_STGRST_HIFI4_AXI		2
-#define JH7110_STGRST_SEC_TOP_HRESETN		3
+#define JH7110_STGRST_HIFI4_AXI			2
+#define JH7110_STGRST_SEC_AHB			3
 #define JH7110_STGRST_E24_CORE			4
-#define JH7110_STGRST_DMA1P_AXI		5
-#define JH7110_STGRST_DMA1P_AHB		6
-#define JH7110_STGRST_USB_AXI			7
-#define JH7110_STGRST_USB_APB			8
-#define JH7110_STGRST_USB_UTMI_APB		9
-#define JH7110_STGRST_USB_PWRUP		10
-#define JH7110_STGRST_PCIE0_MST0		11
-#define JH7110_STGRST_PCIE0_SLV0		12
-#define JH7110_STGRST_PCIE0_SLV		13
-#define JH7110_STGRST_PCIE0_BRG		14
+#define JH7110_STGRST_DMA1P_AXI			5
+#define JH7110_STGRST_DMA1P_AHB			6
+#define JH7110_STGRST_USB0_AXI			7
+#define JH7110_STGRST_USB0_APB			8
+#define JH7110_STGRST_USB0_UTMI_APB		9
+#define JH7110_STGRST_USB0_PWRUP		10
+#define JH7110_STGRST_PCIE0_AXI_MST0		11
+#define JH7110_STGRST_PCIE0_AXI_SLV0		12
+#define JH7110_STGRST_PCIE0_AXI_SLV		13
+#define JH7110_STGRST_PCIE0_BRG			14
 #define JH7110_STGRST_PCIE0_CORE		15
-#define JH7110_STGRST_PCIE0_APB		16
-#define JH7110_STGRST_PCIE1_MST0		17
-#define JH7110_STGRST_PCIE1_SLV0		18
-#define JH7110_STGRST_PCIE1_SLV		19
-#define JH7110_STGRST_PCIE1_BRG		20
+#define JH7110_STGRST_PCIE0_APB			16
+#define JH7110_STGRST_PCIE1_AXI_MST0		17
+#define JH7110_STGRST_PCIE1_AXI_SLV0		18
+#define JH7110_STGRST_PCIE1_AXI_SLV		19
+#define JH7110_STGRST_PCIE1_BRG			20
 #define JH7110_STGRST_PCIE1_CORE		21
-#define JH7110_STGRST_PCIE1_APB		22
+#define JH7110_STGRST_PCIE1_APB			22
 
 #define JH7110_STGRST_END			23
 
-#endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_H__ */
+/* ISPCRG resets */
+#define JH7110_ISPRST_ISPV2_TOP_WRAPPER_P	0
+#define JH7110_ISPRST_ISPV2_TOP_WRAPPER_C	1
+#define JH7110_ISPRST_M31DPHY_HW		2
+#define JH7110_ISPRST_M31DPHY_B09_AON		3
+#define JH7110_ISPRST_VIN_APB			4
+#define JH7110_ISPRST_VIN_PIXEL_IF0		5
+#define JH7110_ISPRST_VIN_PIXEL_IF1		6
+#define JH7110_ISPRST_VIN_PIXEL_IF2		7
+#define JH7110_ISPRST_VIN_PIXEL_IF3		8
+#define JH7110_ISPRST_VIN_SYS			9
+#define JH7110_ISPRST_VIN_P_AXI_RD		10
+#define JH7110_ISPRST_VIN_P_AXI_WR		11
+
+#define JH7110_ISPRST_END			12
+
+/* VOUTCRG resets */
+#define JH7110_VOUTRST_DC8200_AXI		0
+#define JH7110_VOUTRST_DC8200_AHB		1
+#define JH7110_VOUTRST_DC8200_CORE		2
+#define JH7110_VOUTRST_DSITX_DPI		3
+#define JH7110_VOUTRST_DSITX_APB		4
+#define JH7110_VOUTRST_DSITX_RXESC		5
+#define JH7110_VOUTRST_DSITX_SYS		6
+#define JH7110_VOUTRST_DSITX_TXBYTEHS		7
+#define JH7110_VOUTRST_DSITX_TXESC		8
+#define JH7110_VOUTRST_HDMI_TX_HDMI		9
+#define JH7110_VOUTRST_MIPITX_DPHY_SYS		10
+#define JH7110_VOUTRST_MIPITX_DPHY_TXBYTEHS	11
+
+#define JH7110_VOUTRST_END			12
+
+#endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_CRG_H__ */
-- 
2.43.2

