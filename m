Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51940D60D09
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 02:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21278894F7;
	Tue, 19 Nov 2024 03:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4455892EF; Tue, 19 Nov 2024 03:06:11 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20725.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::725])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2F0889484
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 03:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3NoWnWheNXnn1G+qId+oFoHYUO1D3X/Jp69IOHzo0esKPNl2AkajfmG2XuyNsS70Ohm/nv3AkVqhAPMIAA6QhrgzDrww32NaQtPAKOSkYW9w2kYlhipYAVT/8xDSmL9LJqJIpJRgpKL/Jo1BpBow5Ct7ccYge0Ow3tPYNTbSAq8ZpTkHOHlcDyXfCnmLIPMJeL5IDoUGSw8KrktlOL4bjI9WvcD0l+TUV3/mkaV5ztBbKZbyk6F5JLOkC4LcTevf0SdOpdoH920uetBzlbH7gGGhcSiNVdnhjap4g51ibrR06nWIuEAR6OJYt6FT40JYXUqzNa6tPV20L4MNtM+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Teslqh+/7jTeja25hbVAVO5Lzf8DZypBF5iTfAG71IA=;
 b=TvGBGKX9Nss9pK9FSeboHTlGmKosDA6kbZaNv3yvtz/4/+59BRm1KAqnA6i3TvZadgrOve+0eRL/9znzqHZPul20NLf9I0rOtbDJJyA4n7D7auZArYLhT8F31PqCSKj1LVZIh46FZ+MYIfwcJmRO+ojB1/CwffQfJSgsA49zPY5xKF/vYunbHIQarbmd0RCa3oFvNnUCOLX84cmfNt7f6OHWduREUaQJNcEdHcwR0VzcN7syQ+I9234WBomOM6yXj4ReSqBEHokMlJn+ll4cxlSJn3ojXs+xNTGC3V7OX1N1jFr5LaiIlXKRAKOdIM0jiJb8K8IzcD+IxZpmwphb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1164.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 02:06:11 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 02:06:06 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v5 05/11] riscv: dts: jh7110: Add u-boot device tree for
 JH7110 based boards
Date: Tue, 19 Nov 2024 10:04:19 +0800
Message-ID: <20241119020425.51989-6-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241119020425.51989-1-hal.feng@starfivetech.com>
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::21) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1164:EE_
X-MS-Office365-Filtering-Correlation-Id: 95135f66-fd2e-4130-a677-08dd083eba1e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: oV/QOjzfNHKawyqZXfJsSWu24GUbFMGCHRdpuP0KLJCv1xWXiMIK3e8IP+Mf0XVbLZq1W8IjSi8KNrsRBXg5g9ZAzoXmInWBWHf5iy1VenO5nNmUEJz9iuuS+dIWT/E9GeHvDiVzsS0oRdSIUTlfNa4o/u2iCwOJvBLsuz7t3lKrdIElOSY508BtpB2fXU3AlEyzP3GVM5wfMHpnZqgN1E6n1w5hWRBF2oegfmMoUOngPrjmjPbbMZcqxnYshM4ZHebcEEOsSKMhENo3WlKfBXyOiMVXEvVZrxis2gFp+40IQq6zh+XfMsWSXWsuTGAYp0erthhCL8qM074+dl+9JA94JaWwIDgBZv+Xw+6zwszTPL0/lY25eHHZ/wr+8bFfV3VhY64jhRbrCei/fxeO3QA41EROlE4qUeSsAZjbxf1HHYQTj6KA091tyB+y6/GZvMQaPtt1bw2List/l8eC8f4UBedcFFBCiuBfZHqlASyO7hLQl/yxoJEXWCZeLfgn1VzDhTLqrrzUwpaTCcLBWXjAaabkXTnQzdCkJ+GAv0X0U/PKYjgGYOY29AZ9JCtKmMriN7NUyjI85eB6JfZYX2JujHovQxdPLiblSJeE0uTuRSbsy4W5Sz3GutpIGCtbt0ba6hexgczKcA3GFqRlHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6QsbCpDCixcD5KpOeeB5NoFDG8JeFLI5Efi5mGLC9/hLGupQjBEQrRdf2g52?=
 =?us-ascii?Q?7xC2xw+AdUprcO8wXGxDDH3D+C9hIuLOP9rDYyW0NN90/E0EHpfWBzSlTlrT?=
 =?us-ascii?Q?bf3dM7QH3JYLN3hRlLXBE+m0t/Q5/elv4+1WHdQNoJafgOHGcpUcxvMP7PCh?=
 =?us-ascii?Q?XbnBntTCRwsqqwSltARICgOC5/Dc6fbPmIyzn4qRAkN8vJ/Ae2SalcmHPQsQ?=
 =?us-ascii?Q?3TUxe/kiajpSNJ7/Pg+c2Tckcrf4A0Tf9mS8oBqFjLLXLK6DPHcFABCqUJhe?=
 =?us-ascii?Q?KrIR5flNmsWyEDBXQXYGZH+uRsVPDo+OwJb6O2alKx7TWvJ6K+bo0dyte3RK?=
 =?us-ascii?Q?k0AA1MU6R8u6GqWZ5KK22TJM3jR10HlC/zXjqHEdgjixYeoJBXF5pmZE2ryB?=
 =?us-ascii?Q?+eB6xIFHxcM7/SpwfwZSuEwBCfFSz6HyNQdvbkXCMpHYs+fYurimvgnfbYvg?=
 =?us-ascii?Q?AlIlYlJXZot2zPA3l2avcEAvsxurDb+HEkBwYNHrDot1s666nZ0ShUhFb55v?=
 =?us-ascii?Q?myc7UYfk+VQbMH6OltMgk78W9SYlOIrpDzWmtULvy6BHBb7xUFpYNHH//mhO?=
 =?us-ascii?Q?yEO7LGiPgh8wa5ryomtZCgGsZ5MnseSEkc6oXvxbx53z+X3qwwlH/f9T3pTO?=
 =?us-ascii?Q?CLERmoOzSiLO4MFOWk3vCXj9NuV3elAE5+GTpPIA2gvVm+7oZKcEmjfz/8ye?=
 =?us-ascii?Q?0ToSWa59c3fc4lyH0hS5EiwlH8qO+o/NsC6sH7u+rxMT18VFbGzoeaC5wxYB?=
 =?us-ascii?Q?hhwA0TfGUP03iHPTYHAg9EAPAxNQgH7fHUwXToQEcgfVCGDyxeJ/E7j3lPF5?=
 =?us-ascii?Q?tKAj2ZYHSiIk5vBZs1q6iaHrsM+0Dwan1QhXVS7/sznP+vMWE+eVdXh1Gkyo?=
 =?us-ascii?Q?5MGtPeq0t9xusogROLH+NCZ19zcndGz1sr1GDT6/vMOlTEVPRSjKY2D78UQ0?=
 =?us-ascii?Q?YCsg3Cl24AIXMxyy+KGu/VPSQjW5kxH7biS/ce+fC80f07/xMkpq8ZgQ9DFf?=
 =?us-ascii?Q?Sr7srjO1ibCFDd80+oYfhZR+rCosGEmOjHZgw7mqh2uZ3o6k65XrSYir+1rP?=
 =?us-ascii?Q?9G7L3y1xqarae1OuCefsSsb9S9xiiGcbdWDgcDyhFE98Em9T5IjuIErO2I32?=
 =?us-ascii?Q?NqctkOLXTLcbdmhqRDzRBsoBXrr4PCPBN8j49sJvgcTwjMaG+HBR0K7GAyLr?=
 =?us-ascii?Q?MDm04GAEI8twNteEKtkaWFHSWWySMXK4EL+cXIHTlZb30StvV+Yxe1umx716?=
 =?us-ascii?Q?L3LN2nm1MzaQDWYctX8P21fYqmYtfArvqmwZYCp61lpdXEQLfSX9glT1viPz?=
 =?us-ascii?Q?mrSIpE5UPT+JgimHz8k+lL0NZaTeXXs/mtPPC5pntfxpnPRO4b4pGH+W0r3l?=
 =?us-ascii?Q?6OaaFfFKD6H/CPMC0e4/6dJusBpV4qrjOZZ7qvyk5XRdXsRKAT+XsbNA+SsB?=
 =?us-ascii?Q?4CrTaLDro/FU2RbK09StgrQNBiV+0CzG1DmldSiOscDLCO+ShlLB2/I8ncka?=
 =?us-ascii?Q?xnYU9umZu3JVGL1IYzw/WHYTDWWJumZysl+2xrohyFALz4aVkLXGA3umGkCc?=
 =?us-ascii?Q?YraZ2cX2AI+xTFv6tRmUXxZNBJk9ecZ5KfLOfGZySdTlAzN148pFyhYi7EFb?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95135f66-fd2e-4130-a677-08dd083eba1e
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 02:06:06.1379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+O+oZL7EaNKRf1aw77PaT7TiLqaSU4ReUKFxuPxFjq6uYhHzyHe9kIHuJtIcaEn7VceXbkEpgUlhm3bKgHjjcULU0J8vdNFp94QVzqoKLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1164
X-Mailman-Approved-At: Tue, 19 Nov 2024 03:08:50 +0100
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

To support the other JH7110 based boards, add u-boot
device tree for them.

Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: H Bell <dmoo_dv@protonmail.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi           | 10 ++++++++++
 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi        |  6 ++++++
 .../dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi |  6 ++++++
 3 files changed, 22 insertions(+)
 create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi

diff --git a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
new file mode 100644
index 0000000000..cf4f0d4c06
--- /dev/null
+++ b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ */
+
+#include "jh7110-common-u-boot.dtsi"
+
+&phy0 {
+	/delete-property/ motorcomm,tx-clk-10-inverted;
+};
diff --git a/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
new file mode 100644
index 0000000000..9df1e5db55
--- /dev/null
+++ b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ */
+
+#include "jh7110-common-u-boot.dtsi"
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
new file mode 100644
index 0000000000..9df1e5db55
--- /dev/null
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ */
+
+#include "jh7110-common-u-boot.dtsi"
-- 
2.43.2

