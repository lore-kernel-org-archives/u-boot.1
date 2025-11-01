Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50947CCF9FE
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9B2983C11;
	Sat,  1 Nov 2025 01:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="SgO346Z3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E42BD83B87; Sat,  1 Nov 2025 01:45:28 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F26783B5E
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgnVEqTWXVTQ0bha+B5RaZ6YZ4it3yr1FPyBoBKAf3J+DZARDra4CDhET1WLR1hQ9BWFkYyBkF2sYLkKs93EZ/3T/DGXjgvTwnna7u+Qe6+dFIAMy5w6rgZUTU395RYlVmbjEASepHEJLU+HQsh6ZwfsuYpgZLNnJvZqDCjOS9TcXDxWzXlin54rqHklw4iy52rkcIOO69KlgcsgQdFeECawFmPSCL6kn6W53IttUL2IF5gNLMZxozFPLXIFHjEvKPK4jwGAwj8OfcI/YvU9TZoXXfHVWd+AqsoEA6r1XIu8wO8K5v0v+kR4PE2fQzI5rXnUksEO6UlTChI2iqOU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1P8j2Pb7Yk4UqAknfuM/YbBmZ3Qi8BjCNOFC+Af9POk=;
 b=M+NNjSDk0R29aUjHqFN6ykmAwiMwO3Rm5F6Dphp9OsOYU6cqLdKKRvdt+Ovx1nz+GqnIuq7/2F/oZdBR357GXQbkwgXGJycWhc7d489QN3MDzOciNYDWmRfdg/pT6pSiB4H37GMd/AIi2MonleQRcq1iXJdGW8x1aMYVp+OddnrIyrHS5bTkgEvw16x/bSXhdYzPeOmnwfFuBh6f7r2DCOrMPOd98GAAx8pCvQUfutoww0LMQMriaAz5+kmb6SlClXLbw2QIrl7YLQctIGgMtVOUcknKG/nuz7Bnxn8noV5qm2K+FQOsADeEaudh+Kt1kvMs9KeM6/Um26uOC/yieQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1P8j2Pb7Yk4UqAknfuM/YbBmZ3Qi8BjCNOFC+Af9POk=;
 b=SgO346Z3K3FtbWscoLlAH/uEDcDggLNHS707B2am5t8fYYaLBIRwFuYF7ly3SDfjp3tvlbjdQN8LGAuIhkP5bLEpiAZ1rbC5T7THnZwTR2PrMDnjvmsFmo7bJjLpKnIG6WQaYHtxon1mBkXfWQMfUc/13c2vkYqj/mEqy7Idlb084SVwtradW7+KfYMXqqOz4An81JMit214y/e2lDTQH9Tc445fi8zKTuc47oP82fzEHj/crjn1MZyfdYIEgN5ncCWQoNr6yYLsQEisLJAhAcj1hrAvxYyLt5j5Y3LeliEbjhjYAvdJPruJjEeTvRirxkWoF5lyVQZ6Apv6Ll159g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9258.eurprd08.prod.outlook.com (2603:10a6:102:308::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:23 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:23 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 10/19] dt-bindings: reset: Add reset support for Airoha EN7523
Date: Sat,  1 Nov 2025 03:44:54 +0300
Message-ID: <20251101004503.2379529-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 9552d6ac-fddd-4d9b-9769-08de18dff0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z8NOe3lWnd83sqfezBh6Ioodf3dKefi+YLOZVRlJVI1EJJQyBPLyt0HvvsJ5?=
 =?us-ascii?Q?auvPkdros1HT51rrtNzTSbZL36bdKpm8ohz8cQgQAipqEopH6frhPgml0l18?=
 =?us-ascii?Q?S5Sz1q3tk3fSt34eVn7xrGzdyprLtYL6hpwBk/qLmmCvx1Dw13v7moIBAaH9?=
 =?us-ascii?Q?gDwWOduJEvZMRNxkLHavv0j1czojvoK2EvFMvj6YCDIe3Lht+06l1a8j+Xve?=
 =?us-ascii?Q?4ST42GtH5+LbVkRkDwl7bHsXah9QThHEmTwyNZ1J4EaQp6fwrIFaj70Dh8aK?=
 =?us-ascii?Q?Bj2bt+JIoKDrGIl48NtvB6WsJBBWvupMdn90XWEnLb7yKjpXd/cTY+HrsT4h?=
 =?us-ascii?Q?QGT3aPm83YRdmlJqRoNNm3DhyCJ4L4vabSLnd+dR32AgaWg9wG/UTNi+54nk?=
 =?us-ascii?Q?oAc/TnA51foDNncFyrhFN+Mk5/RDAlIrGLJBk79trfAoUbqibxAYy+sbkCu9?=
 =?us-ascii?Q?Ydi8jv06J6Ue1i2wy03B4ghzHzkQR1pUvu8BzcM1Jb8OHHdn5SrWl50lSu9W?=
 =?us-ascii?Q?j6EW5oCB+oBxn0IRS2bsP9pTR1TmE2DlbKJt5U8UrZoEWWJM7+5YE3nV3F9Q?=
 =?us-ascii?Q?CGAC5vknp8s7yQ73/ASzulBkQz8dlYc17lk2WS9YSgQzFjmRaYsG+q+HbGA7?=
 =?us-ascii?Q?cBcq5MyUczB0yjKxMFa43D7h5DeAZir1aNwUTFEdMP94SZbcXKzPAJyi02df?=
 =?us-ascii?Q?PX0qaOTjF9464KZp+K2vmrOFrlllvLHMWWwPzszdjAIwZO3ZO7Jx730jwGgw?=
 =?us-ascii?Q?fyGo/y+Ni4oMF4CE8+8u3grgsVe4FW/yzl0Xir7LDdOpCUE0R24JbLeWoh68?=
 =?us-ascii?Q?+DcZE9vtAvaniOHVWMz20E+BSprZ1s0C+XX7m7tarWCWJbUN7LXkTgglXKKK?=
 =?us-ascii?Q?pgdi58KS2rQH3PX5ZZ2Ec1dqmNKFywPajgowkTcDDcZSaNUk55E6/665inqA?=
 =?us-ascii?Q?BhI8wkKgQbFl+dPK6heIIyqYnnVNj9Hhc6KgF302dVMNhLrbQR2FHUcn4Ois?=
 =?us-ascii?Q?2ahYjMP3qkpedp+CvvzOXWXbERhzzr37mXBvGX1nCq1WHKo6m1mqpdhTx6EL?=
 =?us-ascii?Q?sV1+CzgYMlcccUOEgyy5s5/TKo7xiJ3n+JaCHKXVmpX0Hh9acW+Vt/4abOCH?=
 =?us-ascii?Q?Lfwj0v2DEH8bmVZRP1RV7oJN1d73DI2lj77dWv13y2WG0DavdCkBpA8I6GNA?=
 =?us-ascii?Q?6VS35WupFkrSUdCVz1D68+fNJkBL3Jl8kq5v7DeAiicF5b8d/cqbuPS4Nh/9?=
 =?us-ascii?Q?079p1uAyDljFzXdhwVSIlO+98gkFHm4ghJSqf6zuuR1QgK6aylzw1mIx6vgn?=
 =?us-ascii?Q?2NICMpG7cpwzMLEFmWTICNbksv1SpQZIMq78ImXKbL8Sdludqk/XGHPweIi1?=
 =?us-ascii?Q?hEaDDQmsnw2rJ2TOrxtiN3hARFUYO1vtQtuAtS2udyCRF4wx4z4rihxSYvfy?=
 =?us-ascii?Q?JmscFG9roTxWNWYUD1XkNlOc8PgndoIJvdAIs0p/3XAsjE78gNJkVXHWQUIf?=
 =?us-ascii?Q?pqEnmB552HHu8mSpBxakyJiYjrQaHGQfx+Be?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mdTMPMx3foyHGThmpSxciaFhBqVBiLPAS4gFcsSHRRdtut4evr6YtUCc5ZJo?=
 =?us-ascii?Q?PhEMDrWHLYwQu4vCL4c6J0nK5OaIChurkyQxKUyZ04o85Hf27A3PmSFRmk3J?=
 =?us-ascii?Q?kmDWoAjCwMDYpjmoCZLJKVfWZTFfhWATfTkKFXyflaqpuc7bhOq4tOd3w9+Q?=
 =?us-ascii?Q?s2LOWuF4oqtCNLfBeaGk6p+6B7Iq4hLxt4ODPANEA838RQv77FmxqYsFYV4o?=
 =?us-ascii?Q?lDMYQ4T8tnFDqSzcPQpuI1Z2oroMAD1HRFya2vfmye8BXBrJ0jw7uDz4fhlW?=
 =?us-ascii?Q?TGkIaSdHkg4Jp0BS5acSPsqJpGndWDEy+o+iWcKQuf8WgVzr+WIXHcyAgFkj?=
 =?us-ascii?Q?OqOCJC2dC+UkBd0JbkUMrUvwMIX8KIo44vJ7wVk/MEfRlSyNm6kLUwi6WlSd?=
 =?us-ascii?Q?UdWmH9tdNE4q1ktxVpUmNrazXvBop/+xMqCcZETpyPsWt5kp7phGTpwnY6qr?=
 =?us-ascii?Q?KfAVnFw8N7WPPdydIc9GtOus7zK8RpYmQFBGpn1sO36d+g7O3IUyHUG8r4eU?=
 =?us-ascii?Q?74rvf2LaeTMmtxwiyB7U3zOUSXZ6xkSxx0/IAesaKAEl7gjF3lcdXgK30vJN?=
 =?us-ascii?Q?JER2UY3Kaq2T8d9YHlktkWvpbb/6ZCAjSZ/869sJkS3IL1WPdvKjWvQuO4Ak?=
 =?us-ascii?Q?l6FU9HOFVjldlUYPKy7VIAQ/p0vkAamuwpyvFtOUUryptfmsyJDiSGY/Dzja?=
 =?us-ascii?Q?WhcWkheGxbltgXWl2PLGWE1lMlvTwKAdIr2qGLaemw+ByodoWV7NjGoWwV85?=
 =?us-ascii?Q?eANyD6LArsxLo4EcJSSUUR9rJBC2E5FDSXGT0R2WF4bWX7zJVEfjaI0+3zuy?=
 =?us-ascii?Q?m0j5dCEbdjR9hHZhoLk+PD6DnG7RdwTnJx50V8/EWWPHRBVI4LFxIlCPxgLe?=
 =?us-ascii?Q?jAvQAt7DPy2PSQCEnXRuEUA8FvkmLB3JcWQJhHmIrf5UAyCsq5kzEjxgXTAh?=
 =?us-ascii?Q?2z4QvmX9LGUH7JM3gJf7Ea+7ux0AxaIVWeAxI4OoO8tMsMCUUUd2GoqJ8Mu5?=
 =?us-ascii?Q?C3aWbjklDkoXxjfxDBSeMqN9/vviRm8Pz6Op35t7u+CouqDOoWdLoIc2KUbm?=
 =?us-ascii?Q?UzhsDfacnn47lokZYq3/+1GKfUvKjiEHMb1dA/SZDAEe8m+otHN3IelmWr6u?=
 =?us-ascii?Q?or1TjiyDoGxZoFlDOO+xKf50zI+X3o9fnSDLPWhEQbjEMCUyFBO8dAszCvlf?=
 =?us-ascii?Q?cV8pldAAe/zmGtveUyX5MNw9wCBpf1Z6W1ukT4z269YQOk1/S64joZXMRqws?=
 =?us-ascii?Q?h0j0wY/Nyz5RvLe6LgpPcoyISpzQY11IrEMSMmUzn022QeJ+n1XFaLO2dw0k?=
 =?us-ascii?Q?X3/6aiiwWUn/eOlAIYnGtGitiYZ8XzdR+VoSt+qmPFS2C/5+ydIeLplGFCei?=
 =?us-ascii?Q?SCQP27x1w3jqlQcxfLHG8N+RQmpMCP+rFcjkrIviIz1WF2PKIFBlUL3tcb7r?=
 =?us-ascii?Q?oBoRcWDtKCv3WSUXhRMSqIbIhRB504FjVNmEsu4RuK6cBqh22QriA4uxZIAI?=
 =?us-ascii?Q?bI6crZuRwvp6HJ2Fd2YuV633XF3FsMaTci6pB42/RdZAqNvqTCJskZDPtsm2?=
 =?us-ascii?Q?ChHJanFTeTHOEhrlEMZnCeAkgcdZSSMfEuuC5hn9/IZjehmhRmeDRzMHStls?=
 =?us-ascii?Q?tztrAR17NgxADRQ07TrvPjM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9552d6ac-fddd-4d9b-9769-08de18dff0cf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:23.1408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1ATjZo7564kehE++dAwrGyPArT2oXf0vNRvpYKQqI+UjM4iHKOeVYGJzxd340EcSokQttgCpY5MH9vKVffsjtX4qUinV8lyFfRv3EHYsWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9258
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

Introduce reset capability for EN7523 device-tree binding

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 .../dt-bindings/reset/airoha,en7523-reset.h   | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 include/dt-bindings/reset/airoha,en7523-reset.h

diff --git a/include/dt-bindings/reset/airoha,en7523-reset.h b/include/dt-bindings/reset/airoha,en7523-reset.h
new file mode 100644
index 00000000000..bb0a28673d6
--- /dev/null
+++ b/include/dt-bindings/reset/airoha,en7523-reset.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (C) 2024 iopsys Software Solutions AB.
+ * Copyright (C) 2025 Genexis AB.
+ *
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ *
+ * based on
+ *   dts/upstream/include/dt-bindings/reset/airoha,en7581-reset.h
+ * by Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#ifndef __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7523_H_
+#define __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7523_H_
+
+/* RST_CTRL2 */
+#define EN7523_XPON_PHY_RST		 0
+#define EN7523_XSI_MAC_RST		 1
+#define EN7523_XSI_PHY_RST		 2
+#define EN7523_NPU_RST			 3
+#define EN7523_I2S_RST			 4
+#define EN7523_TRNG_RST			 5
+#define EN7523_TRNG_MSTART_RST		 6
+#define EN7523_DUAL_HSI0_RST		 7
+#define EN7523_DUAL_HSI1_RST		 8
+#define EN7523_HSI_RST			 9
+#define EN7523_DUAL_HSI0_MAC_RST	10
+#define EN7523_DUAL_HSI1_MAC_RST	11
+#define EN7523_HSI_MAC_RST		12
+#define EN7523_WDMA_RST			13
+#define EN7523_WOE0_RST			14
+#define EN7523_WOE1_RST			15
+#define EN7523_HSDMA_RST		16
+#define EN7523_I2C2RBUS_RST		17
+#define EN7523_TDMA_RST			18
+/* RST_CTRL1 */
+#define EN7523_PCM1_ZSI_ISI_RST		19
+#define EN7523_FE_PDMA_RST		20
+#define EN7523_FE_QDMA_RST		21
+#define EN7523_PCM_SPIWP_RST		22
+#define EN7523_CRYPTO_RST		23
+#define EN7523_TIMER_RST		24
+#define EN7523_PCM1_RST			25
+#define EN7523_UART_RST			26
+#define EN7523_GPIO_RST			27
+#define EN7523_GDMA_RST			28
+#define EN7523_I2C_MASTER_RST		29
+#define EN7523_PCM2_ZSI_ISI_RST		30
+#define EN7523_SFC_RST			31
+#define EN7523_UART2_RST		32
+#define EN7523_GDMP_RST			33
+#define EN7523_FE_RST			34
+#define EN7523_USB_HOST_P0_RST		35
+#define EN7523_GSW_RST			36
+#define EN7523_SFC2_PCM_RST		37
+#define EN7523_PCIE0_RST		38
+#define EN7523_PCIE1_RST		39
+#define EN7523_PCIE_HB_RST		40
+#define EN7523_XPON_MAC_RST		41
+
+#endif /* __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7523_H_ */
-- 
2.51.0

