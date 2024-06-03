Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10143C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 13:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A3E88830C;
	Mon,  3 Jun 2024 15:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D83EC881C3; Mon,  3 Jun 2024 15:27:38 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20718.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::718])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9968F882ED
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 15:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpT3VBXO6q7owceUucLZCO1ytyGFMVE42bszwaDWhEMEM4wPBdIhcWWrZzIQHgaTEo7B5l5gVufLeS2N0hDRjv/K1qjCeoNdky+UL98JoFJNtz5CPy2BEKALJCUFzoeQso7ZV00v2feRwik2n79QMrIGxiMxeREeKtFiWu56NxRgRZgvD2hkf0ws3VcBqW3BPS7GEFANyRTAb16WMIICf6PtIojQeLwnImXhjt5CwfPHfKo9pPw+m2wQ82cy7OVHUuKctFruyMbtM3DMvZD8/AC7deJwhl+aw9Fwz8dvBTNHVC0fgk9zyqw4tSzUdczwZcuwnYUlVHoy8I5uKXy/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zprFBAsBy5aaw83OS2VyomFPzLWeoJozemm2G9Ukl2Y=;
 b=kdBQ/4SbNC9KkJLJDaNIZCymFUnh15fNPHS4bWt23IIpRWF2e59Zr/Yob02ymiREyZZ/Q48CiBxZ35WPwXoMJwir4wmm+pJwG8F2xhjQjjttSi5zsT6S1o02o54DEY8hG0O/AgL3G+8dvgV+gD6JmyPuUSzQVv6rJmK4Oj4FtZUPPXKFQ/cV/k2hpS0QsLzvuiFlXRMa9ajv4v/XNs2jYFHWD7Vl9uaH5EPnDJXAymzC0JMu7dOxYfsTFptD6kJZst1a9BfeGLPhnF/TBUvmD6KBrKpO8Z7WSxhv0K0NIW7bv/PWCp5nrs9t7bjxJv4wqi5J2Ui1qJ1SFXx0YcoUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1242.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.43; Mon, 3 Jun
 2024 13:27:30 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::61c0:a8fc:1462:bc54]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::61c0:a8fc:1462:bc54%6])
 with mapi id 15.20.7587.043; Mon, 3 Jun 2024 13:27:30 +0000
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
Subject: [PATCH v1 1/4] dt-bindings: clock: jh7110: Sync with Linux
Date: Mon,  3 Jun 2024 21:27:18 +0800
Message-ID: <20240603132721.6522-2-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3f2805dc-08f6-4e83-8684-08dc83d0eb23
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|41320700004|7416005|52116005|1800799015|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info: VIIyXTRwg9kSNc/Pu6GknuKI1z3P04MKOUxnAeQRI1nhpqr2WB8jrYLto3puz/YMimtDSfPsu0rKZjv8qRt6KLnf3SJIg6QxrSNaRKVudYbrzOF7ES74RleXeSyDt65ZJanj2JTuwnrSs1+gn5O74qFJoSF5Tlc3JWWeQIj0ifEyhbhFaaXo7WqNS7ks7Q51QdOV9OWVyxB2Bz+Gbx2EB/m/QdkEBd+7wNG59usJB8h5nS9ePYzrEkbfqQiZEvPMYxc9JkTcuyIDVwpnJfB+L7oYBpkxmkOfl/LRDsaAXPJr0lCvPrmez6dFdO+2BsavsxiQIHPOY6yBycuXzR/EH04fdIMUYEQpv+MpSmhJiBj4txeJqHyxGsuPwwY22hpvdhHXLgURJ8Te44f/Y5EaBs/xIl24rQeoXpULBxpuXWsFFqjB+uWnQb5VaEimzClDT/2QSo26j1XfmwbvJKFvhHFuAQZv1PA+FfAMaltBJQh4X51Qv8nhnYCUKJFXr6CuDnM9+2z2D77MBTnu3kKJlajUk+rEktksAgyZO7tP7YSEY/vw1EWrmo9qna3OQWAXbFpOjj/oaCdLWKTCGTMQzFJ2rHS0qz+XmQQi06uOJQjs68WIcEgQd3yBUTb3WbL4c83TRBecFpgW2iZoWla9Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(41320700004)(7416005)(52116005)(1800799015)(366007)(38350700005)(921011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vjj7jref2ROJ9j/PIqwRybfv0GjzNgfdw8uiiv9Bmx4Hqx7/fPBm2KuFohMu?=
 =?us-ascii?Q?RvpUrLqtds6OH1FsS0wQ+Bo7FE6pgg9evM1+a7fMzuhgGx/pvuW3+zjFWvrT?=
 =?us-ascii?Q?c1iOTUtIwg4gt3Eg9j65wyUKUzEAOtxRCj4p9brVETXR5UW2x+CqsEyhtiKg?=
 =?us-ascii?Q?ntiRHBGwIQck1mr/knk+vEWFIXG6mz7eCLOPIfmu2eg+Az1ivdbl6xeVxU9x?=
 =?us-ascii?Q?G1oMTCHt8FT+A8NZk/F/RegAJDjTrImKIIiyzEc2VAk+zDE6MkEgnndgvMCn?=
 =?us-ascii?Q?JGh7YWMTjofiClTWNulU0MU8SD7V1UDc1TiH4GuDQSyM93DK1iFkb+NfOqzZ?=
 =?us-ascii?Q?EmWYnTehQxPqwla3/B7RyRXeeW03Abt/WRkhNPcTuH8mFni6H+5A0pEtR24X?=
 =?us-ascii?Q?C8ozT9Oa1rz7BwJsr776MjVFZqlT4KdHj5ujg5jrHXAtJCU7Eifkv/nL4GVK?=
 =?us-ascii?Q?iNJ1fpUYAkkJu25cFyG/f3j139Jn6cngU16RLfy4riX6iWCw72XWFJdf2HBb?=
 =?us-ascii?Q?40GwJI0pT0p4yYXq6cfy2e9chGhgEo7IOqiJWFgnDAvKQrKv2VhSQD046cEU?=
 =?us-ascii?Q?8kYfO7FmI3OOkFORawXCSJfgInGu9TUWa0oNNoHevr4CuOSp224/GSHniXRB?=
 =?us-ascii?Q?pPseQWwR3HxPjUNC9jfWguS0Dve4T0pocfp27K+xsqVey4rqXMzn/FxM4qa7?=
 =?us-ascii?Q?w54GGyeimZqfx/NTJ+/0kENZ8X+JV4THc55zGI+CjmsckgYLIDXXgSAA0Uzq?=
 =?us-ascii?Q?pXk1WZZrznOYqSNI/+PdXFI8HJaExFoQi9112mdu6ubXHj/h3XFrZVKTh5k4?=
 =?us-ascii?Q?sfNf/mge6LAIXeQ9OII/s13zeGxrNv7qomFILLOIOwPljOP0z8qQqrzdxMzu?=
 =?us-ascii?Q?BpGOGwEZy3Oi4ASgON4WPoj4z+nCafqimi7qaF0lRYf2Y10iVXPp+DXQ8Xf0?=
 =?us-ascii?Q?j8LYp08fKUV1gTeZD8zqXcURBbcaIjQ023nUlxEIa8kAVBKKpkEsZ/izzPhA?=
 =?us-ascii?Q?mQYHjsuHuApdXrXoE2np8pIrigsZ/KQWuB690B0SqvUfttTxCpo8Zjreh4Iq?=
 =?us-ascii?Q?hQrL/8RFsbO1NWIdA0jkc5FWbcujjcaW989Qh3xGkvgfsnjTIa1G6PPgssgi?=
 =?us-ascii?Q?T9C3+C3E0WIkR8RzESD1W6SExi/wpWPOtQUAc0tcv/rpKI6kTWZwWsdWkLpO?=
 =?us-ascii?Q?9NxxhUdQ5WYMsxIggTgo6EGzr4D/ptjbkASWo8LajPmP/kVHA1vDMS6d7ioB?=
 =?us-ascii?Q?m1746Pdq3awSHHvRBnHcuFTAiRWTPZQEdOqXlrz8JpGxWn1U9pWAOFO/drjk?=
 =?us-ascii?Q?PDMR9EmE48Q6I204/+Fk0xWCjb8mJcvUjjCoR92KUzw7oHUAjILqtzeQfHfU?=
 =?us-ascii?Q?gGJkNn2msPFm8qFrr4K+4TloKMpwyPHMvCZvu3D5JHPoJtoYlH2xCw/zOiZW?=
 =?us-ascii?Q?U+sxh5RJ/nnB3J18TlZzVzPHaHWjvFuruW0xqR6HBRp5xFGecMtbaVLP2g+/?=
 =?us-ascii?Q?/ozdmDFN3MO6PkfG0K+u7m6QlOtJ/p3TzjLX3p4H2al0ou9kGKiRPNeCTQ9u?=
 =?us-ascii?Q?FB71jg23vyI9d+JwT+kFp7hPJfCCWKW2aOo8gH0ZjUOBBzaFCr1nxq6/bhm4?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2805dc-08f6-4e83-8684-08dc83d0eb23
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 13:27:30.2266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2SxJlSpWrR18lNtBM/DhX/+xX58msjtENLenjp1WNgAu6BXv+OfdGv2AU3MbdE6MirQbd8kQLt+vfyz4yEKDT/ezk/0LpLs6GZypWJ6qp4=
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

Sync JH7110 clock dt-bindings with Linux, which is the same with
dts/upstream/include/dt-bindings/clock/starfive,jh7110-crg.h
except copyright.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 180 +++++++++++-------
 1 file changed, 112 insertions(+), 68 deletions(-)

diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
index b51e3829ff..4eabb05473 100644
--- a/include/dt-bindings/clock/starfive,jh7110-crg.h
+++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
@@ -5,19 +5,21 @@
  * Author: Yanhong Wang <yanhong.wang@starfivetech.com>
  */
 
-#ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__
-#define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__
+#ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
+#define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
 
-#define JH7110_SYSCLK_PLL0_OUT			0
-#define JH7110_SYSCLK_PLL1_OUT			1
-#define JH7110_SYSCLK_PLL2_OUT			2
+/* PLL clocks */
+#define JH7110_PLLCLK_PLL0_OUT			0
+#define JH7110_PLLCLK_PLL1_OUT			1
+#define JH7110_PLLCLK_PLL2_OUT			2
 #define JH7110_PLLCLK_END			3
 
+/* SYSCRG clocks */
 #define JH7110_SYSCLK_CPU_ROOT			0
 #define JH7110_SYSCLK_CPU_CORE			1
 #define JH7110_SYSCLK_CPU_BUS			2
 #define JH7110_SYSCLK_GPU_ROOT			3
-#define JH7110_SYSCLK_PERH_ROOT		4
+#define JH7110_SYSCLK_PERH_ROOT			4
 #define JH7110_SYSCLK_BUS_ROOT			5
 #define JH7110_SYSCLK_NOCSTG_BUS		6
 #define JH7110_SYSCLK_AXI_CFG0			7
@@ -26,9 +28,9 @@
 #define JH7110_SYSCLK_AHB1			10
 #define JH7110_SYSCLK_APB_BUS			11
 #define JH7110_SYSCLK_APB0			12
-#define JH7110_SYSCLK_PLL0_DIV2		13
-#define JH7110_SYSCLK_PLL1_DIV2		14
-#define JH7110_SYSCLK_PLL2_DIV2		15
+#define JH7110_SYSCLK_PLL0_DIV2			13
+#define JH7110_SYSCLK_PLL1_DIV2			14
+#define JH7110_SYSCLK_PLL2_DIV2			15
 #define JH7110_SYSCLK_AUDIO_ROOT		16
 #define JH7110_SYSCLK_MCLK_INNER		17
 #define JH7110_SYSCLK_MCLK			18
@@ -50,12 +52,12 @@
 #define JH7110_SYSCLK_TRACE2			34
 #define JH7110_SYSCLK_TRACE3			35
 #define JH7110_SYSCLK_TRACE4			36
-#define JH7110_SYSCLK_TRACE_COM		37
+#define JH7110_SYSCLK_TRACE_COM			37
 #define JH7110_SYSCLK_NOC_BUS_CPU_AXI		38
 #define JH7110_SYSCLK_NOC_BUS_AXICFG0_AXI	39
 #define JH7110_SYSCLK_OSC_DIV2			40
-#define JH7110_SYSCLK_PLL1_DIV4		41
-#define JH7110_SYSCLK_PLL1_DIV8		42
+#define JH7110_SYSCLK_PLL1_DIV4			41
+#define JH7110_SYSCLK_PLL1_DIV8			42
 #define JH7110_SYSCLK_DDR_BUS			43
 #define JH7110_SYSCLK_DDR_AXI			44
 #define JH7110_SYSCLK_GPU_CORE			45
@@ -64,21 +66,21 @@
 #define JH7110_SYSCLK_GPU_APB			48
 #define JH7110_SYSCLK_GPU_RTC_TOGGLE		49
 #define JH7110_SYSCLK_NOC_BUS_GPU_AXI		50
-#define JH7110_SYSCLK_ISP_TOP_CLK_ISPCORE_2X	51
-#define JH7110_SYSCLK_ISP_TOP_CLK_ISP_AXI	52
+#define JH7110_SYSCLK_ISP_TOP_CORE		51
+#define JH7110_SYSCLK_ISP_TOP_AXI		52
 #define JH7110_SYSCLK_NOC_BUS_ISP_AXI		53
 #define JH7110_SYSCLK_HIFI4_CORE		54
-#define JH7110_SYSCLK_HIFI4_AXI		55
-#define JH7110_SYSCLK_AXI_CFG1_DEC_MAIN	56
-#define JH7110_SYSCLK_AXI_CFG1_DEC_AHB		57
+#define JH7110_SYSCLK_HIFI4_AXI			55
+#define JH7110_SYSCLK_AXI_CFG1_MAIN		56
+#define JH7110_SYSCLK_AXI_CFG1_AHB		57
 #define JH7110_SYSCLK_VOUT_SRC			58
 #define JH7110_SYSCLK_VOUT_AXI			59
 #define JH7110_SYSCLK_NOC_BUS_DISP_AXI		60
-#define JH7110_SYSCLK_VOUT_TOP_CLK_VOUT_AHB		61
-#define JH7110_SYSCLK_VOUT_TOP_CLK_VOUT_AXI		62
-#define JH7110_SYSCLK_VOUT_TOP_CLK_HDMITX0_MCLK	63
-#define JH7110_SYSCLK_VOUT_TOP_CLK_MIPIPHY_REF		64
-#define JH7110_SYSCLK_JPEGC_AXI		65
+#define JH7110_SYSCLK_VOUT_TOP_AHB		61
+#define JH7110_SYSCLK_VOUT_TOP_AXI		62
+#define JH7110_SYSCLK_VOUT_TOP_HDMITX0_MCLK	63
+#define JH7110_SYSCLK_VOUT_TOP_MIPIPHY_REF	64
+#define JH7110_SYSCLK_JPEGC_AXI			65
 #define JH7110_SYSCLK_CODAJ12_AXI		66
 #define JH7110_SYSCLK_CODAJ12_CORE		67
 #define JH7110_SYSCLK_CODAJ12_APB		68
@@ -87,8 +89,8 @@
 #define JH7110_SYSCLK_WAVE511_BPU		71
 #define JH7110_SYSCLK_WAVE511_VCE		72
 #define JH7110_SYSCLK_WAVE511_APB		73
-#define JH7110_SYSCLK_VDEC_JPG_ARB_JPG		74
-#define JH7110_SYSCLK_VDEC_JPG_ARB_MAIN	75
+#define JH7110_SYSCLK_VDEC_JPG			74
+#define JH7110_SYSCLK_VDEC_MAIN			75
 #define JH7110_SYSCLK_NOC_BUS_VDEC_AXI		76
 #define JH7110_SYSCLK_VENC_AXI			77
 #define JH7110_SYSCLK_WAVE420L_AXI		78
@@ -96,37 +98,37 @@
 #define JH7110_SYSCLK_WAVE420L_VCE		80
 #define JH7110_SYSCLK_WAVE420L_APB		81
 #define JH7110_SYSCLK_NOC_BUS_VENC_AXI		82
-#define JH7110_SYSCLK_AXI_CFG0_DEC_MAIN_DIV	83
-#define JH7110_SYSCLK_AXI_CFG0_DEC_MAIN	84
-#define JH7110_SYSCLK_AXI_CFG0_DEC_HIFI4	85
+#define JH7110_SYSCLK_AXI_CFG0_MAIN_DIV		83
+#define JH7110_SYSCLK_AXI_CFG0_MAIN		84
+#define JH7110_SYSCLK_AXI_CFG0_HIFI4		85
 #define JH7110_SYSCLK_AXIMEM2_AXI		86
 #define JH7110_SYSCLK_QSPI_AHB			87
 #define JH7110_SYSCLK_QSPI_APB			88
 #define JH7110_SYSCLK_QSPI_REF_SRC		89
 #define JH7110_SYSCLK_QSPI_REF			90
-#define JH7110_SYSCLK_SDIO0_AHB		91
-#define JH7110_SYSCLK_SDIO1_AHB		92
+#define JH7110_SYSCLK_SDIO0_AHB			91
+#define JH7110_SYSCLK_SDIO1_AHB			92
 #define JH7110_SYSCLK_SDIO0_SDCARD		93
 #define JH7110_SYSCLK_SDIO1_SDCARD		94
 #define JH7110_SYSCLK_USB_125M			95
 #define JH7110_SYSCLK_NOC_BUS_STG_AXI		96
-#define JH7110_SYSCLK_GMAC1_AHB		97
-#define JH7110_SYSCLK_GMAC1_AXI		98
+#define JH7110_SYSCLK_GMAC1_AHB			97
+#define JH7110_SYSCLK_GMAC1_AXI			98
 #define JH7110_SYSCLK_GMAC_SRC			99
 #define JH7110_SYSCLK_GMAC1_GTXCLK		100
 #define JH7110_SYSCLK_GMAC1_RMII_RTX		101
-#define JH7110_SYSCLK_GMAC1_PTP		102
+#define JH7110_SYSCLK_GMAC1_PTP			102
 #define JH7110_SYSCLK_GMAC1_RX			103
 #define JH7110_SYSCLK_GMAC1_RX_INV		104
 #define JH7110_SYSCLK_GMAC1_TX			105
 #define JH7110_SYSCLK_GMAC1_TX_INV		106
 #define JH7110_SYSCLK_GMAC1_GTXC		107
 #define JH7110_SYSCLK_GMAC0_GTXCLK		108
-#define JH7110_SYSCLK_GMAC0_PTP		109
+#define JH7110_SYSCLK_GMAC0_PTP			109
 #define JH7110_SYSCLK_GMAC_PHY			110
 #define JH7110_SYSCLK_GMAC0_GTXC		111
-#define JH7110_SYSCLK_IOMUX_APB		112
-#define JH7110_SYSCLK_MAILBOX			113
+#define JH7110_SYSCLK_IOMUX_APB			112
+#define JH7110_SYSCLK_MAILBOX_APB		113
 #define JH7110_SYSCLK_INT_CTRL_APB		114
 #define JH7110_SYSCLK_CAN0_APB			115
 #define JH7110_SYSCLK_CAN0_TIMER		116
@@ -137,13 +139,13 @@
 #define JH7110_SYSCLK_PWM_APB			121
 #define JH7110_SYSCLK_WDT_APB			122
 #define JH7110_SYSCLK_WDT_CORE			123
-#define JH7110_SYSCLK_TIMER_APB		124
+#define JH7110_SYSCLK_TIMER_APB			124
 #define JH7110_SYSCLK_TIMER0			125
 #define JH7110_SYSCLK_TIMER1			126
 #define JH7110_SYSCLK_TIMER2			127
 #define JH7110_SYSCLK_TIMER3			128
 #define JH7110_SYSCLK_TEMP_APB			129
-#define JH7110_SYSCLK_TEMP_CORE		130
+#define JH7110_SYSCLK_TEMP_CORE			130
 #define JH7110_SYSCLK_SPI0_APB			131
 #define JH7110_SYSCLK_SPI1_APB			132
 #define JH7110_SYSCLK_SPI2_APB			133
@@ -158,21 +160,21 @@
 #define JH7110_SYSCLK_I2C4_APB			142
 #define JH7110_SYSCLK_I2C5_APB			143
 #define JH7110_SYSCLK_I2C6_APB			144
-#define JH7110_SYSCLK_UART0_APB		145
+#define JH7110_SYSCLK_UART0_APB			145
 #define JH7110_SYSCLK_UART0_CORE		146
-#define JH7110_SYSCLK_UART1_APB		147
+#define JH7110_SYSCLK_UART1_APB			147
 #define JH7110_SYSCLK_UART1_CORE		148
-#define JH7110_SYSCLK_UART2_APB		149
+#define JH7110_SYSCLK_UART2_APB			149
 #define JH7110_SYSCLK_UART2_CORE		150
-#define JH7110_SYSCLK_UART3_APB		151
+#define JH7110_SYSCLK_UART3_APB			151
 #define JH7110_SYSCLK_UART3_CORE		152
-#define JH7110_SYSCLK_UART4_APB		153
+#define JH7110_SYSCLK_UART4_APB			153
 #define JH7110_SYSCLK_UART4_CORE		154
-#define JH7110_SYSCLK_UART5_APB		155
+#define JH7110_SYSCLK_UART5_APB			155
 #define JH7110_SYSCLK_UART5_CORE		156
 #define JH7110_SYSCLK_PWMDAC_APB		157
 #define JH7110_SYSCLK_PWMDAC_CORE		158
-#define JH7110_SYSCLK_SPDIF_APB		159
+#define JH7110_SYSCLK_SPDIF_APB			159
 #define JH7110_SYSCLK_SPDIF_CORE		160
 #define JH7110_SYSCLK_I2STX0_APB		161
 #define JH7110_SYSCLK_I2STX0_BCLK_MST		162
@@ -188,7 +190,7 @@
 #define JH7110_SYSCLK_I2STX1_BCLK		172
 #define JH7110_SYSCLK_I2STX1_BCLK_INV		173
 #define JH7110_SYSCLK_I2STX1_LRCK		174
-#define JH7110_SYSCLK_I2SRX_APB		175
+#define JH7110_SYSCLK_I2SRX_APB			175
 #define JH7110_SYSCLK_I2SRX_BCLK_MST		176
 #define JH7110_SYSCLK_I2SRX_BCLK_MST_INV	177
 #define JH7110_SYSCLK_I2SRX_LRCK_MST		178
@@ -200,12 +202,13 @@
 #define JH7110_SYSCLK_TDM_AHB			184
 #define JH7110_SYSCLK_TDM_APB			185
 #define JH7110_SYSCLK_TDM_INTERNAL		186
-#define JH7110_SYSCLK_TDM_CLK_TDM		187
-#define JH7110_SYSCLK_TDM_CLK_TDM_N		188
+#define JH7110_SYSCLK_TDM_TDM			187
+#define JH7110_SYSCLK_TDM_TDM_INV		188
 #define JH7110_SYSCLK_JTAG_CERTIFICATION_TRNG	189
 
 #define JH7110_SYSCLK_END			190
 
+/* AONCRG clocks */
 #define JH7110_AONCLK_OSC_DIV4			0
 #define JH7110_AONCLK_APB_FUNC			1
 #define JH7110_AONCLK_GMAC0_AHB			2
@@ -223,30 +226,31 @@
 
 #define JH7110_AONCLK_END			14
 
-#define JH7110_STGCLK_HIFI4_CORE		0
-#define JH7110_STGCLK_USB_APB			1
-#define JH7110_STGCLK_USB_UTMI_APB		2
-#define JH7110_STGCLK_USB_AXI			3
-#define JH7110_STGCLK_USB_LPM			4
-#define JH7110_STGCLK_USB_STB			5
-#define JH7110_STGCLK_USB_APP_125		6
-#define JH7110_STGCLK_USB_REFCLK		7
-#define JH7110_STGCLK_PCIE0_AXI			8
+/* STGCRG clocks */
+#define JH7110_STGCLK_HIFI4_CLK_CORE		0
+#define JH7110_STGCLK_USB0_APB			1
+#define JH7110_STGCLK_USB0_UTMI_APB		2
+#define JH7110_STGCLK_USB0_AXI			3
+#define JH7110_STGCLK_USB0_LPM			4
+#define JH7110_STGCLK_USB0_STB			5
+#define JH7110_STGCLK_USB0_APP_125		6
+#define JH7110_STGCLK_USB0_REFCLK		7
+#define JH7110_STGCLK_PCIE0_AXI_MST0		8
 #define JH7110_STGCLK_PCIE0_APB			9
 #define JH7110_STGCLK_PCIE0_TL			10
-#define JH7110_STGCLK_PCIE1_AXI			11
+#define JH7110_STGCLK_PCIE1_AXI_MST0		11
 #define JH7110_STGCLK_PCIE1_APB			12
 #define JH7110_STGCLK_PCIE1_TL			13
-#define JH7110_STGCLK_PCIE01_MAIN		14
-#define JH7110_STGCLK_SEC_HCLK			15
-#define JH7110_STGCLK_SEC_MISCAHB		16
-#define JH7110_STGCLK_MTRX_GRP0_MAIN		17
-#define JH7110_STGCLK_MTRX_GRP0_BUS		18
-#define JH7110_STGCLK_MTRX_GRP0_STG		19
-#define JH7110_STGCLK_MTRX_GRP1_MAIN		20
-#define JH7110_STGCLK_MTRX_GRP1_BUS		21
-#define JH7110_STGCLK_MTRX_GRP1_STG		22
-#define JH7110_STGCLK_MTRX_GRP1_HIFI		23
+#define JH7110_STGCLK_PCIE_SLV_MAIN		14
+#define JH7110_STGCLK_SEC_AHB			15
+#define JH7110_STGCLK_SEC_MISC_AHB		16
+#define JH7110_STGCLK_GRP0_MAIN			17
+#define JH7110_STGCLK_GRP0_BUS			18
+#define JH7110_STGCLK_GRP0_STG			19
+#define JH7110_STGCLK_GRP1_MAIN			20
+#define JH7110_STGCLK_GRP1_BUS			21
+#define JH7110_STGCLK_GRP1_STG			22
+#define JH7110_STGCLK_GRP1_HIFI			23
 #define JH7110_STGCLK_E2_RTC			24
 #define JH7110_STGCLK_E2_CORE			25
 #define JH7110_STGCLK_E2_DBG			26
@@ -255,4 +259,44 @@
 
 #define JH7110_STGCLK_END			29
 
-#endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__ */
+/* ISPCRG clocks */
+#define JH7110_ISPCLK_DOM4_APB_FUNC		0
+#define JH7110_ISPCLK_MIPI_RX0_PXL		1
+#define JH7110_ISPCLK_DVP_INV			2
+#define JH7110_ISPCLK_M31DPHY_CFG_IN		3
+#define JH7110_ISPCLK_M31DPHY_REF_IN		4
+#define JH7110_ISPCLK_M31DPHY_TX_ESC_LAN0	5
+#define JH7110_ISPCLK_VIN_APB			6
+#define JH7110_ISPCLK_VIN_SYS			7
+#define JH7110_ISPCLK_VIN_PIXEL_IF0		8
+#define JH7110_ISPCLK_VIN_PIXEL_IF1		9
+#define JH7110_ISPCLK_VIN_PIXEL_IF2		10
+#define JH7110_ISPCLK_VIN_PIXEL_IF3		11
+#define JH7110_ISPCLK_VIN_P_AXI_WR		12
+#define JH7110_ISPCLK_ISPV2_TOP_WRAPPER_C	13
+
+#define JH7110_ISPCLK_END			14
+
+/* VOUTCRG clocks */
+#define JH7110_VOUTCLK_APB			0
+#define JH7110_VOUTCLK_DC8200_PIX		1
+#define JH7110_VOUTCLK_DSI_SYS			2
+#define JH7110_VOUTCLK_TX_ESC			3
+#define JH7110_VOUTCLK_DC8200_AXI		4
+#define JH7110_VOUTCLK_DC8200_CORE		5
+#define JH7110_VOUTCLK_DC8200_AHB		6
+#define JH7110_VOUTCLK_DC8200_PIX0		7
+#define JH7110_VOUTCLK_DC8200_PIX1		8
+#define JH7110_VOUTCLK_DOM_VOUT_TOP_LCD		9
+#define JH7110_VOUTCLK_DSITX_APB		10
+#define JH7110_VOUTCLK_DSITX_SYS		11
+#define JH7110_VOUTCLK_DSITX_DPI		12
+#define JH7110_VOUTCLK_DSITX_TXESC		13
+#define JH7110_VOUTCLK_MIPITX_DPHY_TXESC	14
+#define JH7110_VOUTCLK_HDMI_TX_MCLK		15
+#define JH7110_VOUTCLK_HDMI_TX_BCLK		16
+#define JH7110_VOUTCLK_HDMI_TX_SYS		17
+
+#define JH7110_VOUTCLK_END			18
+
+#endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__ */
-- 
2.43.2

