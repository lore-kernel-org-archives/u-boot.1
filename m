Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2A1D12D60
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 02:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99F798931E;
	Mon, 11 Nov 2024 03:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DF538911A; Mon, 11 Nov 2024 03:09:44 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20730.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::730])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36FDE89198
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 03:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKQ4qN9e97oMvG1UbVErftRelWr4lumBS6fcMIg63BkIlPj13sN/PT5ur3fXxg2PgwXMbtN9VudypKZo02p3rxZ9DXnqG6ifhvLN9GODX81Ks23gfCcUEXRPRmklt30WmVakN/J0gXfR7/+nw83LQObIjun7UBNeXtkyohZK4vmzD0Mkt6/6lBM/cbcnpCZSgl+AOlJeiS7t5cNPALM3v8wSS4O8s1eeUozi/skVMU1XdusuiQyGK5N7pd/1eUEAwUl40bUec9C0DGURVRgCBwuGs5OryQpzhAbfd3Bcp3a2f6IiBqlw1jdvjEuPjxtMdTYL+3Ew5oYrUpPT/x/RtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bunPIF4vKEROSyKMxeNIlGRVq5yIuLnfz3zO8O9/6S0=;
 b=YK0j0FDgK7LF+EI+JuZVp9wZmHKCzq7SzmDP9mikpSD8KuEzi9YDjKveqAwmrIlulQ3btM+eJracmDInAg8KUOQZl1yVvNSJH5SI1x51IQbmqYzU+f7YvYJm/m+u7kVu+q78PIT+qTeAPzsR1LAZ2kd4rO/vaXLj0sXiHak+0A02PGi9ubKnXZtSUkjum7l51EuGfivzd8E9WvllEq5G4goUpBL1nxqdtsF9Y7+vSKmOBe5zznh5flotU7DmSkockkj0/k3Yb6045fod1U1/OuJ8tJC1dLcYZsIZbpSdh61z2Hcge3rTFDnNTNonBGZkNbb24KotqTFivkvNuB7e4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1178.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.36; Mon, 11 Nov
 2024 02:09:44 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.035; Mon, 11 Nov 2024
 02:09:43 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v4 03/13] dt-bindings: Remove StarFive JH7110 clock and reset
 definitions
Date: Mon, 11 Nov 2024 10:07:58 +0800
Message-ID: <20241111020808.38974-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241111020808.38974-1-hal.feng@starfivetech.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1178:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe6cdef-b3c2-44c8-c966-08dd01f5e8a0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: IVirdaYp2oEFJYt/BiTR5RKd6rjmKdAsnp97vpumXnCrapbbgaUMu9LlKpahPszwy4UJaCQlS3d55+48RB+pHvPMPk5oluoQqfOZHBh+B//AqT+DsrVQyfUshlTi6EUhZH9+cmV9Nb42u6s+iCWl44479ULaiTJQk85c2k0byy0SwPqn9fa9Rt4juBm/3NwMpBeMj+wSj7DRI9r49/vh7jKNzNADPlTCYEDbrTkqxT3g7kp0cdUOK7j6rgH2Ulj2FKH0nzCc12hvkXk92R4nzePhBKKnP2kYnqDYZSSMpoK4SNvIK/z/KG/I3osQtHpjay2t6LDaC1bkymCmMsMCZMYtoNU6mM7yhCkKZ+EVLJraEtIJRieAZCeCoS1DX0YzKn4mltVSXU5NPgxayTp5wllukW1AEvAC6WWkYu6CBaQ9t9x8+IT9sqreOimXfIZJVAqAKlatQ7Mc2LMcDGHIF+ztW/sCpL3riuSLqDfwcXcv9UhxIo2VVeoGrep341YrVhGRqcmf5ndozRc3mJAnvuLxd0/SKAjGUAV4cjQDStEdko0b6nc69oPI/a3+sb85PyUCuM/zllNWlZxudIRHRNYRc+3tf2QHu7Y0XzuK7lEexhGxmd1z+anM0ThhtrZlkGfMWkhoTn7U9VrPqSklaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NDB8b+J4B44L2crk485qvBaACHF0Ez4qkGxtSvHQWr9oABnjLOpiRa6/11sO?=
 =?us-ascii?Q?SX500pfmAVIsPblv5xKmWh5c3j7nPbMTF1dOhwgoJROOHSwfFruOlXusXs3r?=
 =?us-ascii?Q?PvRYQhQ1lpH91zTjPYAP8pIrByf42laYs7ptDmmPc5yBZaprIw3xbcEsOZLT?=
 =?us-ascii?Q?AQfCj8qlrWfApZJM8o0nZNyImqtwPu/vc5brNboI6nbEAgt96A/lR0pt7LFi?=
 =?us-ascii?Q?tPd3xx81IcVVUgaqviU7UPqNKpgLqXmf9BairKYd5Tc7S8W4CTYGqjdHgPvc?=
 =?us-ascii?Q?p+MZVGdCicH31Jt722VZh0roL/z1KabQ0gFYyBQBqQxVuDpX2ruUUwj9HlZI?=
 =?us-ascii?Q?5KBDgXw5Te5mBk4xGLMf8kB0X7efv6jYMmZTlfAhObsOXZ3f8leaxJZWxsf5?=
 =?us-ascii?Q?4BGGTdYHt4Mj7Yq0sliMpzJfH+N/8c6WxmxS2bb5+YWaiiKyGJfPqDJFdkXQ?=
 =?us-ascii?Q?dJFCHZyrihtRbIG+QnI2AZ3QGgo/m5JvnzAxlt9md8trqO73QD0nTEuYyYFI?=
 =?us-ascii?Q?G63iqIor73Et+6kMbOFJYtcRilbpi42JsHqyxxnHdMpOKPdpU7SKfEoJRfKW?=
 =?us-ascii?Q?fNvsX+wj/4Y/sPIHuZ7+OJXV8k0MAQWE+O7/bX4wag5pq5HCD1eVGFxrZiAJ?=
 =?us-ascii?Q?bVhw1S1/Penznp+ZNeQE2DS4PZykj1t3e5/YQtE72F1wQXL7nWQZMZYgG3Y/?=
 =?us-ascii?Q?O44PAiLizEu44IdMPjmnWiu+fUnst6GqVgxKNEqA6WR1E+mhn7iLqV4t02ez?=
 =?us-ascii?Q?+MY7ljhH2DSX3plHQZThVBbKkYOyzibgFAQwVUw71vk4xRQIJaTGaB2FYIcX?=
 =?us-ascii?Q?u8IteW1IscDpRaxsK5c8jsD9JFVbo5raqff4NUBsO56OATP/qNIkmZmrNqFG?=
 =?us-ascii?Q?AGehMyfsXNN/z2uH9SEfU78FssNXVdAZ5clgJa3gjkK5K+LRbGQpNOA7dq5Q?=
 =?us-ascii?Q?fLUb3YAcFuIW5UjNu+yePcNOjmbgAH8U7p+JYY+8fwT5nwEy9nSbx2J3OqRa?=
 =?us-ascii?Q?xilQR+wjcRYOQQIj9xqVP47mJiZDBcAr97hqonKTi8I6TC7X02gvbVwstWHL?=
 =?us-ascii?Q?/3Ky9+Dk8A6zS8ZTf5PHxWgTVUiHKXnnr8Wy9RUzvkPGLAskzceY9AdNRxoS?=
 =?us-ascii?Q?igGXuIPakJGAzmliGs0C+2rP2RM34s+b33ZQKyM4v3yQigVU+cJyhBSleo82?=
 =?us-ascii?Q?NTunPW3e7Sv3PvicTZT4MSDIUi+dqYQ2Uspx3vYSRnSL7S3+1ZHm5OaAQtyw?=
 =?us-ascii?Q?QtpTgGF3e1pxI3pDZAaT7LtSS1PFqIJB0WPK63pFxiqE+3qpHpSSxTnLPqqM?=
 =?us-ascii?Q?RcO4GkFo3VGOsZn4iTkrXnZEhZXG2t+3BSKWtUDJJPQgJTI3oENLbqRk5IEI?=
 =?us-ascii?Q?AQ8fVNoPcwSb1JPEx2yiUKLDDhIIzkfGTswS6K04NnM0vdTpVXqcBHpJ7YcR?=
 =?us-ascii?Q?hMCMEjTYTRK2vG7GD6C/ZUi/6F0ikQFTVpIoOpXHJ+QEupVzoxoOpDyr1g/l?=
 =?us-ascii?Q?EpKrF24ZglrauOvt8Lg8pTTEfr8sZ21RELl5KKWLondR3LWKL7Pd5I2AYc9E?=
 =?us-ascii?Q?cZgKidXnA/fdMVxXNnBf7Hh0ST4LNyfy8whSZw7xL8diNtVpAecDPx5zyrLE?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe6cdef-b3c2-44c8-c966-08dd01f5e8a0
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:09:43.9354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3paTTXJp6PeO4dXJQ0d3oCcFG+ZAavPYQTD5Ejr+iAk5WWNGbtQYGQHkvH3DEuYkNHI9fCYLCJY1iUiRzGOL2/xit3lnty4A6F07futIROs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1178
X-Mailman-Approved-At: Mon, 11 Nov 2024 03:23:18 +0100
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

As JH7110 switch to use OF_UPSTREAM dt-bindings,
remove the redundant clock and reset definitions.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 258 ------------------
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 183 -------------
 2 files changed, 441 deletions(-)
 delete mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
 delete mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h

diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
deleted file mode 100644
index b51e3829ff..0000000000
--- a/include/dt-bindings/clock/starfive,jh7110-crg.h
+++ /dev/null
@@ -1,258 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2022 StarFive Technology Co., Ltd.
- *
- * Author: Yanhong Wang <yanhong.wang@starfivetech.com>
- */
-
-#ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__
-#define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__
-
-#define JH7110_SYSCLK_PLL0_OUT			0
-#define JH7110_SYSCLK_PLL1_OUT			1
-#define JH7110_SYSCLK_PLL2_OUT			2
-#define JH7110_PLLCLK_END			3
-
-#define JH7110_SYSCLK_CPU_ROOT			0
-#define JH7110_SYSCLK_CPU_CORE			1
-#define JH7110_SYSCLK_CPU_BUS			2
-#define JH7110_SYSCLK_GPU_ROOT			3
-#define JH7110_SYSCLK_PERH_ROOT		4
-#define JH7110_SYSCLK_BUS_ROOT			5
-#define JH7110_SYSCLK_NOCSTG_BUS		6
-#define JH7110_SYSCLK_AXI_CFG0			7
-#define JH7110_SYSCLK_STG_AXIAHB		8
-#define JH7110_SYSCLK_AHB0			9
-#define JH7110_SYSCLK_AHB1			10
-#define JH7110_SYSCLK_APB_BUS			11
-#define JH7110_SYSCLK_APB0			12
-#define JH7110_SYSCLK_PLL0_DIV2		13
-#define JH7110_SYSCLK_PLL1_DIV2		14
-#define JH7110_SYSCLK_PLL2_DIV2		15
-#define JH7110_SYSCLK_AUDIO_ROOT		16
-#define JH7110_SYSCLK_MCLK_INNER		17
-#define JH7110_SYSCLK_MCLK			18
-#define JH7110_SYSCLK_MCLK_OUT			19
-#define JH7110_SYSCLK_ISP_2X			20
-#define JH7110_SYSCLK_ISP_AXI			21
-#define JH7110_SYSCLK_GCLK0			22
-#define JH7110_SYSCLK_GCLK1			23
-#define JH7110_SYSCLK_GCLK2			24
-#define JH7110_SYSCLK_CORE			25
-#define JH7110_SYSCLK_CORE1			26
-#define JH7110_SYSCLK_CORE2			27
-#define JH7110_SYSCLK_CORE3			28
-#define JH7110_SYSCLK_CORE4			29
-#define JH7110_SYSCLK_DEBUG			30
-#define JH7110_SYSCLK_RTC_TOGGLE		31
-#define JH7110_SYSCLK_TRACE0			32
-#define JH7110_SYSCLK_TRACE1			33
-#define JH7110_SYSCLK_TRACE2			34
-#define JH7110_SYSCLK_TRACE3			35
-#define JH7110_SYSCLK_TRACE4			36
-#define JH7110_SYSCLK_TRACE_COM		37
-#define JH7110_SYSCLK_NOC_BUS_CPU_AXI		38
-#define JH7110_SYSCLK_NOC_BUS_AXICFG0_AXI	39
-#define JH7110_SYSCLK_OSC_DIV2			40
-#define JH7110_SYSCLK_PLL1_DIV4		41
-#define JH7110_SYSCLK_PLL1_DIV8		42
-#define JH7110_SYSCLK_DDR_BUS			43
-#define JH7110_SYSCLK_DDR_AXI			44
-#define JH7110_SYSCLK_GPU_CORE			45
-#define JH7110_SYSCLK_GPU_CORE_CLK		46
-#define JH7110_SYSCLK_GPU_SYS_CLK		47
-#define JH7110_SYSCLK_GPU_APB			48
-#define JH7110_SYSCLK_GPU_RTC_TOGGLE		49
-#define JH7110_SYSCLK_NOC_BUS_GPU_AXI		50
-#define JH7110_SYSCLK_ISP_TOP_CLK_ISPCORE_2X	51
-#define JH7110_SYSCLK_ISP_TOP_CLK_ISP_AXI	52
-#define JH7110_SYSCLK_NOC_BUS_ISP_AXI		53
-#define JH7110_SYSCLK_HIFI4_CORE		54
-#define JH7110_SYSCLK_HIFI4_AXI		55
-#define JH7110_SYSCLK_AXI_CFG1_DEC_MAIN	56
-#define JH7110_SYSCLK_AXI_CFG1_DEC_AHB		57
-#define JH7110_SYSCLK_VOUT_SRC			58
-#define JH7110_SYSCLK_VOUT_AXI			59
-#define JH7110_SYSCLK_NOC_BUS_DISP_AXI		60
-#define JH7110_SYSCLK_VOUT_TOP_CLK_VOUT_AHB		61
-#define JH7110_SYSCLK_VOUT_TOP_CLK_VOUT_AXI		62
-#define JH7110_SYSCLK_VOUT_TOP_CLK_HDMITX0_MCLK	63
-#define JH7110_SYSCLK_VOUT_TOP_CLK_MIPIPHY_REF		64
-#define JH7110_SYSCLK_JPEGC_AXI		65
-#define JH7110_SYSCLK_CODAJ12_AXI		66
-#define JH7110_SYSCLK_CODAJ12_CORE		67
-#define JH7110_SYSCLK_CODAJ12_APB		68
-#define JH7110_SYSCLK_VDEC_AXI			69
-#define JH7110_SYSCLK_WAVE511_AXI		70
-#define JH7110_SYSCLK_WAVE511_BPU		71
-#define JH7110_SYSCLK_WAVE511_VCE		72
-#define JH7110_SYSCLK_WAVE511_APB		73
-#define JH7110_SYSCLK_VDEC_JPG_ARB_JPG		74
-#define JH7110_SYSCLK_VDEC_JPG_ARB_MAIN	75
-#define JH7110_SYSCLK_NOC_BUS_VDEC_AXI		76
-#define JH7110_SYSCLK_VENC_AXI			77
-#define JH7110_SYSCLK_WAVE420L_AXI		78
-#define JH7110_SYSCLK_WAVE420L_BPU		79
-#define JH7110_SYSCLK_WAVE420L_VCE		80
-#define JH7110_SYSCLK_WAVE420L_APB		81
-#define JH7110_SYSCLK_NOC_BUS_VENC_AXI		82
-#define JH7110_SYSCLK_AXI_CFG0_DEC_MAIN_DIV	83
-#define JH7110_SYSCLK_AXI_CFG0_DEC_MAIN	84
-#define JH7110_SYSCLK_AXI_CFG0_DEC_HIFI4	85
-#define JH7110_SYSCLK_AXIMEM2_AXI		86
-#define JH7110_SYSCLK_QSPI_AHB			87
-#define JH7110_SYSCLK_QSPI_APB			88
-#define JH7110_SYSCLK_QSPI_REF_SRC		89
-#define JH7110_SYSCLK_QSPI_REF			90
-#define JH7110_SYSCLK_SDIO0_AHB		91
-#define JH7110_SYSCLK_SDIO1_AHB		92
-#define JH7110_SYSCLK_SDIO0_SDCARD		93
-#define JH7110_SYSCLK_SDIO1_SDCARD		94
-#define JH7110_SYSCLK_USB_125M			95
-#define JH7110_SYSCLK_NOC_BUS_STG_AXI		96
-#define JH7110_SYSCLK_GMAC1_AHB		97
-#define JH7110_SYSCLK_GMAC1_AXI		98
-#define JH7110_SYSCLK_GMAC_SRC			99
-#define JH7110_SYSCLK_GMAC1_GTXCLK		100
-#define JH7110_SYSCLK_GMAC1_RMII_RTX		101
-#define JH7110_SYSCLK_GMAC1_PTP		102
-#define JH7110_SYSCLK_GMAC1_RX			103
-#define JH7110_SYSCLK_GMAC1_RX_INV		104
-#define JH7110_SYSCLK_GMAC1_TX			105
-#define JH7110_SYSCLK_GMAC1_TX_INV		106
-#define JH7110_SYSCLK_GMAC1_GTXC		107
-#define JH7110_SYSCLK_GMAC0_GTXCLK		108
-#define JH7110_SYSCLK_GMAC0_PTP		109
-#define JH7110_SYSCLK_GMAC_PHY			110
-#define JH7110_SYSCLK_GMAC0_GTXC		111
-#define JH7110_SYSCLK_IOMUX_APB		112
-#define JH7110_SYSCLK_MAILBOX			113
-#define JH7110_SYSCLK_INT_CTRL_APB		114
-#define JH7110_SYSCLK_CAN0_APB			115
-#define JH7110_SYSCLK_CAN0_TIMER		116
-#define JH7110_SYSCLK_CAN0_CAN			117
-#define JH7110_SYSCLK_CAN1_APB			118
-#define JH7110_SYSCLK_CAN1_TIMER		119
-#define JH7110_SYSCLK_CAN1_CAN			120
-#define JH7110_SYSCLK_PWM_APB			121
-#define JH7110_SYSCLK_WDT_APB			122
-#define JH7110_SYSCLK_WDT_CORE			123
-#define JH7110_SYSCLK_TIMER_APB		124
-#define JH7110_SYSCLK_TIMER0			125
-#define JH7110_SYSCLK_TIMER1			126
-#define JH7110_SYSCLK_TIMER2			127
-#define JH7110_SYSCLK_TIMER3			128
-#define JH7110_SYSCLK_TEMP_APB			129
-#define JH7110_SYSCLK_TEMP_CORE		130
-#define JH7110_SYSCLK_SPI0_APB			131
-#define JH7110_SYSCLK_SPI1_APB			132
-#define JH7110_SYSCLK_SPI2_APB			133
-#define JH7110_SYSCLK_SPI3_APB			134
-#define JH7110_SYSCLK_SPI4_APB			135
-#define JH7110_SYSCLK_SPI5_APB			136
-#define JH7110_SYSCLK_SPI6_APB			137
-#define JH7110_SYSCLK_I2C0_APB			138
-#define JH7110_SYSCLK_I2C1_APB			139
-#define JH7110_SYSCLK_I2C2_APB			140
-#define JH7110_SYSCLK_I2C3_APB			141
-#define JH7110_SYSCLK_I2C4_APB			142
-#define JH7110_SYSCLK_I2C5_APB			143
-#define JH7110_SYSCLK_I2C6_APB			144
-#define JH7110_SYSCLK_UART0_APB		145
-#define JH7110_SYSCLK_UART0_CORE		146
-#define JH7110_SYSCLK_UART1_APB		147
-#define JH7110_SYSCLK_UART1_CORE		148
-#define JH7110_SYSCLK_UART2_APB		149
-#define JH7110_SYSCLK_UART2_CORE		150
-#define JH7110_SYSCLK_UART3_APB		151
-#define JH7110_SYSCLK_UART3_CORE		152
-#define JH7110_SYSCLK_UART4_APB		153
-#define JH7110_SYSCLK_UART4_CORE		154
-#define JH7110_SYSCLK_UART5_APB		155
-#define JH7110_SYSCLK_UART5_CORE		156
-#define JH7110_SYSCLK_PWMDAC_APB		157
-#define JH7110_SYSCLK_PWMDAC_CORE		158
-#define JH7110_SYSCLK_SPDIF_APB		159
-#define JH7110_SYSCLK_SPDIF_CORE		160
-#define JH7110_SYSCLK_I2STX0_APB		161
-#define JH7110_SYSCLK_I2STX0_BCLK_MST		162
-#define JH7110_SYSCLK_I2STX0_BCLK_MST_INV	163
-#define JH7110_SYSCLK_I2STX0_LRCK_MST		164
-#define JH7110_SYSCLK_I2STX0_BCLK		165
-#define JH7110_SYSCLK_I2STX0_BCLK_INV		166
-#define JH7110_SYSCLK_I2STX0_LRCK		167
-#define JH7110_SYSCLK_I2STX1_APB		168
-#define JH7110_SYSCLK_I2STX1_BCLK_MST		169
-#define JH7110_SYSCLK_I2STX1_BCLK_MST_INV	170
-#define JH7110_SYSCLK_I2STX1_LRCK_MST		171
-#define JH7110_SYSCLK_I2STX1_BCLK		172
-#define JH7110_SYSCLK_I2STX1_BCLK_INV		173
-#define JH7110_SYSCLK_I2STX1_LRCK		174
-#define JH7110_SYSCLK_I2SRX_APB		175
-#define JH7110_SYSCLK_I2SRX_BCLK_MST		176
-#define JH7110_SYSCLK_I2SRX_BCLK_MST_INV	177
-#define JH7110_SYSCLK_I2SRX_LRCK_MST		178
-#define JH7110_SYSCLK_I2SRX_BCLK		179
-#define JH7110_SYSCLK_I2SRX_BCLK_INV		180
-#define JH7110_SYSCLK_I2SRX_LRCK		181
-#define JH7110_SYSCLK_PDM_DMIC			182
-#define JH7110_SYSCLK_PDM_APB			183
-#define JH7110_SYSCLK_TDM_AHB			184
-#define JH7110_SYSCLK_TDM_APB			185
-#define JH7110_SYSCLK_TDM_INTERNAL		186
-#define JH7110_SYSCLK_TDM_CLK_TDM		187
-#define JH7110_SYSCLK_TDM_CLK_TDM_N		188
-#define JH7110_SYSCLK_JTAG_CERTIFICATION_TRNG	189
-
-#define JH7110_SYSCLK_END			190
-
-#define JH7110_AONCLK_OSC_DIV4			0
-#define JH7110_AONCLK_APB_FUNC			1
-#define JH7110_AONCLK_GMAC0_AHB			2
-#define JH7110_AONCLK_GMAC0_AXI			3
-#define JH7110_AONCLK_GMAC0_RMII_RTX		4
-#define JH7110_AONCLK_GMAC0_TX			5
-#define JH7110_AONCLK_GMAC0_TX_INV		6
-#define JH7110_AONCLK_GMAC0_RX			7
-#define JH7110_AONCLK_GMAC0_RX_INV		8
-#define JH7110_AONCLK_OTPC_APB			9
-#define JH7110_AONCLK_RTC_APB			10
-#define JH7110_AONCLK_RTC_INTERNAL		11
-#define JH7110_AONCLK_RTC_32K			12
-#define JH7110_AONCLK_RTC_CAL			13
-
-#define JH7110_AONCLK_END			14
-
-#define JH7110_STGCLK_HIFI4_CORE		0
-#define JH7110_STGCLK_USB_APB			1
-#define JH7110_STGCLK_USB_UTMI_APB		2
-#define JH7110_STGCLK_USB_AXI			3
-#define JH7110_STGCLK_USB_LPM			4
-#define JH7110_STGCLK_USB_STB			5
-#define JH7110_STGCLK_USB_APP_125		6
-#define JH7110_STGCLK_USB_REFCLK		7
-#define JH7110_STGCLK_PCIE0_AXI			8
-#define JH7110_STGCLK_PCIE0_APB			9
-#define JH7110_STGCLK_PCIE0_TL			10
-#define JH7110_STGCLK_PCIE1_AXI			11
-#define JH7110_STGCLK_PCIE1_APB			12
-#define JH7110_STGCLK_PCIE1_TL			13
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
-#define JH7110_STGCLK_E2_RTC			24
-#define JH7110_STGCLK_E2_CORE			25
-#define JH7110_STGCLK_E2_DBG			26
-#define JH7110_STGCLK_DMA1P_AXI			27
-#define JH7110_STGCLK_DMA1P_AHB			28
-
-#define JH7110_STGCLK_END			29
-
-#endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/dt-bindings/reset/starfive,jh7110-crg.h
deleted file mode 100644
index 1d596581da..0000000000
--- a/include/dt-bindings/reset/starfive,jh7110-crg.h
+++ /dev/null
@@ -1,183 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2022 StarFive Technology Co., Ltd.
- *
- * Author: Yanhong Wang <yanhong.wang@starfivetech.com>
- */
-
-#ifndef __DT_BINDINGS_RESET_STARFIVE_JH7110_H__
-#define __DT_BINDINGS_RESET_STARFIVE_JH7110_H__
-
-/* SYSCRG resets */
-#define JH7110_SYSRST_JTAG2APB			0
-#define JH7110_SYSRST_SYSCON			1
-#define JH7110_SYSRST_IOMUX_APB		2
-#define JH7110_SYSRST_BUS			3
-#define JH7110_SYSRST_DEBUG			4
-#define JH7110_SYSRST_CORE0			5
-#define JH7110_SYSRST_CORE1			6
-#define JH7110_SYSRST_CORE2			7
-#define JH7110_SYSRST_CORE3			8
-#define JH7110_SYSRST_CORE4			9
-#define JH7110_SYSRST_CORE0_ST			10
-#define JH7110_SYSRST_CORE1_ST			11
-#define JH7110_SYSRST_CORE2_ST			12
-#define JH7110_SYSRST_CORE3_ST			13
-#define JH7110_SYSRST_CORE4_ST			14
-#define JH7110_SYSRST_TRACE0			15
-#define JH7110_SYSRST_TRACE1			16
-#define JH7110_SYSRST_TRACE2			17
-#define JH7110_SYSRST_TRACE3			18
-#define JH7110_SYSRST_TRACE4			19
-#define JH7110_SYSRST_TRACE_COM		20
-#define JH7110_SYSRST_GPU_APB			21
-#define JH7110_SYSRST_GPU_DOMA			22
-#define JH7110_SYSRST_NOC_BUS_APB_BUS		23
-#define JH7110_SYSRST_NOC_BUS_AXICFG0_AXI	24
-#define JH7110_SYSRST_NOC_BUS_CPU_AXI		25
-#define JH7110_SYSRST_NOC_BUS_DISP_AXI		26
-#define JH7110_SYSRST_NOC_BUS_GPU_AXI		27
-#define JH7110_SYSRST_NOC_BUS_ISP_AXI		28
-#define JH7110_SYSRST_NOC_BUS_DDRC		29
-#define JH7110_SYSRST_NOC_BUS_STG_AXI		30
-#define JH7110_SYSRST_NOC_BUS_VDEC_AXI		31
-
-#define JH7110_SYSRST_NOC_BUS_VENC_AXI		32
-#define JH7110_SYSRST_AXI_CFG1_DEC_AHB		33
-#define JH7110_SYSRST_AXI_CFG1_DEC_MAIN	34
-#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN	35
-#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN_DIV	36
-#define JH7110_SYSRST_AXI_CFG0_DEC_HIFI4	37
-#define JH7110_SYSRST_DDR_AXI			38
-#define JH7110_SYSRST_DDR_OSC			39
-#define JH7110_SYSRST_DDR_APB			40
-#define JH7110_SYSRST_DOM_ISP_TOP_N		41
-#define JH7110_SYSRST_DOM_ISP_TOP_AXI		42
-#define JH7110_SYSRST_DOM_VOUT_TOP_SRC		43
-#define JH7110_SYSRST_CODAJ12_AXI		44
-#define JH7110_SYSRST_CODAJ12_CORE		45
-#define JH7110_SYSRST_CODAJ12_APB		46
-#define JH7110_SYSRST_WAVE511_AXI		47
-#define JH7110_SYSRST_WAVE511_BPU		48
-#define JH7110_SYSRST_WAVE511_VCE		49
-#define JH7110_SYSRST_WAVE511_APB		50
-#define JH7110_SYSRST_VDEC_JPG_ARB_JPG		51
-#define JH7110_SYSRST_VDEC_JPG_ARB_MAIN	52
-#define JH7110_SYSRST_AXIMEM0_AXI		53
-#define JH7110_SYSRST_WAVE420L_AXI		54
-#define JH7110_SYSRST_WAVE420L_BPU		55
-#define JH7110_SYSRST_WAVE420L_VCE		56
-#define JH7110_SYSRST_WAVE420L_APB		57
-#define JH7110_SYSRST_AXIMEM1_AXI		58
-#define JH7110_SYSRST_AXIMEM2_AXI		59
-#define JH7110_SYSRST_INTMEM			60
-#define JH7110_SYSRST_QSPI_AHB			61
-#define JH7110_SYSRST_QSPI_APB			62
-#define JH7110_SYSRST_QSPI_REF			63
-
-#define JH7110_SYSRST_SDIO0_AHB		64
-#define JH7110_SYSRST_SDIO1_AHB		65
-#define JH7110_SYSRST_GMAC1_AXI		66
-#define JH7110_SYSRST_GMAC1_AHB		67
-#define JH7110_SYSRST_MAILBOX			68
-#define JH7110_SYSRST_SPI0_APB			69
-#define JH7110_SYSRST_SPI1_APB			70
-#define JH7110_SYSRST_SPI2_APB			71
-#define JH7110_SYSRST_SPI3_APB			72
-#define JH7110_SYSRST_SPI4_APB			73
-#define JH7110_SYSRST_SPI5_APB			74
-#define JH7110_SYSRST_SPI6_APB			75
-#define JH7110_SYSRST_I2C0_APB			76
-#define JH7110_SYSRST_I2C1_APB			77
-#define JH7110_SYSRST_I2C2_APB			78
-#define JH7110_SYSRST_I2C3_APB			79
-#define JH7110_SYSRST_I2C4_APB			80
-#define JH7110_SYSRST_I2C5_APB			81
-#define JH7110_SYSRST_I2C6_APB			82
-#define JH7110_SYSRST_UART0_APB		83
-#define JH7110_SYSRST_UART0_CORE		84
-#define JH7110_SYSRST_UART1_APB		85
-#define JH7110_SYSRST_UART1_CORE		86
-#define JH7110_SYSRST_UART2_APB		87
-#define JH7110_SYSRST_UART2_CORE		88
-#define JH7110_SYSRST_UART3_APB		89
-#define JH7110_SYSRST_UART3_CORE		90
-#define JH7110_SYSRST_UART4_APB		91
-#define JH7110_SYSRST_UART4_CORE		92
-#define JH7110_SYSRST_UART5_APB		93
-#define JH7110_SYSRST_UART5_CORE		94
-#define JH7110_SYSRST_SPDIF_APB		95
-
-#define JH7110_SYSRST_PWMDAC_APB		96
-#define JH7110_SYSRST_PDM_DMIC			97
-#define JH7110_SYSRST_PDM_APB			98
-#define JH7110_SYSRST_I2SRX_APB		99
-#define JH7110_SYSRST_I2SRX_BCLK		100
-#define JH7110_SYSRST_I2STX0_APB		101
-#define JH7110_SYSRST_I2STX0_BCLK		102
-#define JH7110_SYSRST_I2STX1_APB		103
-#define JH7110_SYSRST_I2STX1_BCLK		104
-#define JH7110_SYSRST_TDM_AHB			105
-#define JH7110_SYSRST_TDM_CORE			106
-#define JH7110_SYSRST_TDM_APB			107
-#define JH7110_SYSRST_PWM_APB			108
-#define JH7110_SYSRST_WDT_APB			109
-#define JH7110_SYSRST_WDT_CORE			110
-#define JH7110_SYSRST_CAN0_APB			111
-#define JH7110_SYSRST_CAN0_CORE		112
-#define JH7110_SYSRST_CAN0_TIMER		113
-#define JH7110_SYSRST_CAN1_APB			114
-#define JH7110_SYSRST_CAN1_CORE		115
-#define JH7110_SYSRST_CAN1_TIMER		116
-#define JH7110_SYSRST_TIMER_APB		117
-#define JH7110_SYSRST_TIMER0			118
-#define JH7110_SYSRST_TIMER1			119
-#define JH7110_SYSRST_TIMER2			120
-#define JH7110_SYSRST_TIMER3			121
-#define JH7110_SYSRST_INT_CTRL_APB		122
-#define JH7110_SYSRST_TEMP_APB			123
-#define JH7110_SYSRST_TEMP_CORE		124
-#define JH7110_SYSRST_JTAG_CERTIFICATION	125
-
-#define JH7110_SYSRST_END			126
-
-/* AONCRG resets */
-#define JH7110_AONRST_GMAC0_AXI		0
-#define JH7110_AONRST_GMAC0_AHB		1
-#define JH7110_AONRST_IOMUX			2
-#define JH7110_AONRST_PMU_APB			3
-#define JH7110_AONRST_PMU_WKUP			4
-#define JH7110_AONRST_RTC_APB			5
-#define JH7110_AONRST_RTC_CAL			6
-#define JH7110_AONRST_RTC_32K			7
-
-#define JH7110_AONRST_END			8
-
-/* STGCRG resets */
-#define JH7110_STGRST_SYSCON_PRESETN		0
-#define JH7110_STGRST_HIFI4_CORE		1
-#define JH7110_STGRST_HIFI4_AXI		2
-#define JH7110_STGRST_SEC_TOP_HRESETN		3
-#define JH7110_STGRST_E24_CORE			4
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
-#define JH7110_STGRST_PCIE0_CORE		15
-#define JH7110_STGRST_PCIE0_APB		16
-#define JH7110_STGRST_PCIE1_MST0		17
-#define JH7110_STGRST_PCIE1_SLV0		18
-#define JH7110_STGRST_PCIE1_SLV		19
-#define JH7110_STGRST_PCIE1_BRG		20
-#define JH7110_STGRST_PCIE1_CORE		21
-#define JH7110_STGRST_PCIE1_APB		22
-
-#define JH7110_STGRST_END			23
-
-#endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_H__ */
-- 
2.43.2

