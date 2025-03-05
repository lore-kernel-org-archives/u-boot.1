Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01ACFC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 04:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6AF880F9E;
	Wed,  5 Mar 2025 05:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="BBRpk74q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E71281276; Wed,  5 Mar 2025 05:58:56 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::72c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C0F280F56
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 05:58:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YI9+iROBWJSWLjf4TaJEaXV4XhW204mNDQ4Z3pZScxX/lM+H+n07Kl+kHZe3cytBSn2zy3ar+ccxoT1gUKg3SxXTHAk81nAoNRwvHhiXcCM7kikDri/9GSe/j2HGnUQD9R6pI7PRVhUdtLYDTkZNlj00kJuQZJjLRAoFCGjEMkSyfVEGJ7cQjoFQR/dAiIHmHYAQhgAwv0t5lWdz2N6RIyDxjQriLyN2P1N8PgLFXXbGHaskm76f3pW2aUgqLbA3CG5MJ61stiPrFld8hFPkMbtrA3POEDHG45E/s/1KmRzR7U15a58n2ciqT2WI2219kYDg4PNNCn7lZxbh44TEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQrX6LWT4i9R/sk6hHDPGSEfI75w4PKEQefuMl+O/k8=;
 b=A1EDXi21tL5jX7Caxsa7PBgLDCHiByBf3RaxUG6rLjZrYIhla+QZYd2BQvEJbslC1wV4UDKKa9WH0FE1TgjH6JMb2SSmfmGRfwwe2BjCPRJcONwouTnIZzWx+O2yolfCZ820CaFQjLnl/UiIyCA3PqMdt7olBras5Hvxsil+XDFMYCll/hzQyybW5rt0MrY9dNvjdUGLChHOto9ugvqp4oFFZriBkwsuyCVZuMAifZftlS9hc+nk2aedU8BK2zZ2VVuFwi6sK7HeU9INcBjDOr7ra4NM4lyL8XtjD7RA87LC7tJM9LrQ7ba+o/tlinE7auXetGlMuoMaqryWaXfGEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQrX6LWT4i9R/sk6hHDPGSEfI75w4PKEQefuMl+O/k8=;
 b=BBRpk74qQbsL8q59MNwq/u1SVjQy98Jg99TDppLSjdJUN3YTLRYuHIOSQnIT0AyhJhp9KFuFrZG5HRMAU0fMv+tOCnbjb0X6waPklZe6/ZGQUBBs5j8GPXEPoEYRqdnFO1/m9MVwzRxGpAlij+dqPLoGLaVGLI5fMJAMcMfI0eeSj/UMctMqa6t3IgCZ7WpkXb3YaqLjlQuKlmL9bMro7EiLPaZ/S3E+Clx7YUJRhqApbpClU3rnrd4YINV2pzX/tLo9HPMZ79RzU2Ev8QPfOiAp8eXnlZC8jMSuLMaM+XYwDtb99OosfituzZOkZRW+/MInGtZiA0KnTQ9RVNl4+g==
Received: from CWLP265CA0275.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::23)
 by DBAP195MB1097.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Wed, 5 Mar
 2025 04:58:50 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::b2) by CWLP265CA0275.outlook.office365.com
 (2603:10a6:401:5c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 04:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 04:58:50 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:48 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:47 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <joe.hershberger@ni.com>, <n-francis@ti.com>, <afd@ti.com>,
 <nmorrisson@phytec.com>, <d-gole@ti.com>
Subject: [PATCH 05/13] configs: Add phycore_am62ax_r5_usbdfu_defconfig
Date: Wed, 5 Mar 2025 05:58:30 +0100
Message-ID: <20250305045838.3614661-6-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305045838.3614661-1-w.egorov@phytec.de>
References: <20250305045838.3614661-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|DBAP195MB1097:EE_
X-MS-Office365-Filtering-Correlation-Id: 738c0caf-55b4-44b2-1425-08dd5ba26b90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JCZ3V2c8VeN5211YS/jsI+ARdFFexBhj/bw7UuUC11fN3DdTLdp3dOUU7VoW?=
 =?us-ascii?Q?zPPmXu9RmWqggvRQmG+VSTj1UAcyZGS0cvYBsk9BnlIQHaphIVyxHPOuNqrK?=
 =?us-ascii?Q?hiuw/ZOnFsVTtMGTC/dPW4dTngGhPQKawITNmszoI1yL79JUz+ngvbpzzQ3o?=
 =?us-ascii?Q?R8LDaYc7XgI8oTyjJEyMlV/HdurHRJOG3nDnpzdieFO1SC8f4A3k4s8eOTnV?=
 =?us-ascii?Q?rRHbS91lqjnMuAwsmt1BiOZUALbQ+kbM6PeQRH1v1FDX8C+vexMeOK0a36RK?=
 =?us-ascii?Q?fIx0+7MZ68uOrE8hXnoFKntCR1Zhlby8VSuZ6iEpObKFyzKB3IzcMIUMev/i?=
 =?us-ascii?Q?1EQ0Bmfb87xtm4gyLkbDmrhttrGnfQU3x4vfXEN3gxiw8Nyg+ymJ4KdL9RKH?=
 =?us-ascii?Q?9pwHw1Eg/3xyNTW7k+/7a0Z4k5hMZ0Nriw8xADaRiSRR4Kl+kb/GVLAggpsi?=
 =?us-ascii?Q?gaXE9YxGnlR6+K3mf7qwLmKJEdgtCa5TQ61hLFwjliS8jK3IqVGnQ4o9FdZZ?=
 =?us-ascii?Q?/K0Mv7S8FuxgjkAc8M0Q2F/S1yMpsMQ+UHFukqlNXecSc3uw8aFHqpJZAbG+?=
 =?us-ascii?Q?/xsq4r5t4p9S3PszT3Tl08VR9IvwG1d8MsTr7dZ6A7NqiPK/H39diml8C8Ea?=
 =?us-ascii?Q?ZkeMo33tQpH+RU8yu3PnRTnVhW6rWks3c/KkJhM+YuWCPV8u0fzXaBOUYRFL?=
 =?us-ascii?Q?66p095nw0yvzgO/4+IRxmKqbixKLf9lmj6zhFBQmQW0roWF162mLqC8T6zSa?=
 =?us-ascii?Q?eJvosYPFZ3vPPAIy+Sz9Lh729BZUOIwqTvWE2srYyqyc0J9e4uDS2PmIRaa9?=
 =?us-ascii?Q?MgMHPYqO1pjVoA6ECuviRPNoEZkzDWMA6SBcoQh7qAT+WyVNjbTiihDtzjow?=
 =?us-ascii?Q?0OFORtRBNlALBEbAfYVKYn1ZOfpvHUkDZX8j4G+POqvqAFu4qUwXAyKfmGOW?=
 =?us-ascii?Q?R1eu6kpGcZN8UDmykIAnLC4AG0UAutwj0Io6ZnooJkUNNkmM5tIjMEvrx9ud?=
 =?us-ascii?Q?24lzhc6SEp39sFXKH+uvFJftrbVz0EG5jPnNtvoqEYO5R/X9C1nwFr4Xb1ev?=
 =?us-ascii?Q?QOHtXLx6GxRYCvwebm9EUSHDADXOw5j8zmKsme0pfKLlUlInc2hIwbpcouCl?=
 =?us-ascii?Q?wlKzHj4VEwZw140dB4PPgr3HTQE1xM4OVojC0fUVXb5wdmHqrQfbPFmkI7gN?=
 =?us-ascii?Q?WfQRnJe8R2LnRWadhZ6pL+6OEx9d3r47JVua9sOPMTVj6YMCs5wISK1VoknH?=
 =?us-ascii?Q?yU4t2kxOUfOLdT0Zk7kP3lQjMDwBsgixhIzGdpGS8wHz175yzWa8+4+khCL0?=
 =?us-ascii?Q?wUbfql2jFjKP6XYimhMo1pMA3ACNd9+Y48YjddvSjfrPVHqYCpUzsr9/3xMm?=
 =?us-ascii?Q?qT+HHAjTIVae9e6dgfHxbkYg6UoZXoTpypmkkI9v4RaMyBFVfRPWPc+va0fv?=
 =?us-ascii?Q?yMyQu2qYK4GG/ObCTDT9AaR4y70cXpVP1Haf72p2xxjoG8pYVUFfiO6Rh9ID?=
 =?us-ascii?Q?t+yhmzGZEs87Mb8=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 04:58:50.3443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 738c0caf-55b4-44b2-1425-08dd5ba26b90
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB1097
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

This config includes the phycore_am62ax_r5_defconfig file as well as
the am62x_r5_usbdfu.config fragment. We need another defconfig
because the AM62Ax has not enough internal SRAM to support all boot
sources. The normal phycore_am62ax_r5_defconfig should allow to boot
from MMC and OSPI while this new defconfig allows to boot from USB.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62ax/MAINTAINERS    | 1 +
 configs/phycore_am62ax_r5_usbdfu_defconfig | 4 ++++
 2 files changed, 5 insertions(+)
 create mode 100644 configs/phycore_am62ax_r5_usbdfu_defconfig

diff --git a/board/phytec/phycore_am62ax/MAINTAINERS b/board/phytec/phycore_am62ax/MAINTAINERS
index 3e4e2feff4e..7c8a29b20d9 100644
--- a/board/phytec/phycore_am62ax/MAINTAINERS
+++ b/board/phytec/phycore_am62ax/MAINTAINERS
@@ -10,5 +10,6 @@ F:	arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
 F:	board/phytec/phycore_am62ax/
 F:	configs/phycore_am62ax_a53_defconfig
 F:	configs/phycore_am62ax_r5_defconfig
+F:	configs/phycore_am62ax_r5_usbdfu_defconfig
 F:	include/configs/phycore_am62ax.h
 F:	doc/board/phytec/phycore-am62ax.rst
diff --git a/configs/phycore_am62ax_r5_usbdfu_defconfig b/configs/phycore_am62ax_r5_usbdfu_defconfig
new file mode 100644
index 00000000000..34674ce4371
--- /dev/null
+++ b/configs/phycore_am62ax_r5_usbdfu_defconfig
@@ -0,0 +1,4 @@
+#include <configs/phycore_am62ax_r5_defconfig>
+#include <configs/am62x_r5_usbdfu.config>
+
+CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
-- 
2.34.1

