Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73ABD1CA19
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 03:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C3458904A;
	Tue,  5 Nov 2024 04:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8983088F73; Tue,  5 Nov 2024 04:45:05 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4136B88FA0
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 04:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a56uEqdShOLYJI1Kw7T3VGeDW4NkkGCo/Z4bqGcRv2zvTnu1OQSVL3xP98Ik2EourDYJtILi172+F6NsXCpA71900/B0S0Tt0G7cSz8Rx3yekGTQPPSfLtck9lkp8+o9OawHYaWrDQ1+4qwk1U0yzfWzumeWCGvoaTnTxiDAsHx77H1eLfTOYYXPALzrT7EkKZR8pGWCuYFPOXDxKX9iSBZzgcR8xapNNXW+tDv5Cr+w/iBpP/+MUK0DOeiCvaXo/SwCpuEKKcDLageHfNelYwt7VnvHdS7D8mjFOSQvQAZJPyS763vdIBQTlumIDCVaQgmx8dXZjqv9+LAwirujpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Teslqh+/7jTeja25hbVAVO5Lzf8DZypBF5iTfAG71IA=;
 b=f7Sls9po3avFBAAJBgJ+rdZd6gfjVCQCaAo9Bv4GoP/iPyhByCvU08JzVPoaOOWPnhXmakw4lw9ZTnq6oBFiRWsWlVDzcEdgdc+pozaimzvoGCE3YdzmobRVlJh5gFMQIkmVgiVv4W7grjn9lD65fKLFFyhP2/gnRQwoJ73Ow0CScnWtHDtkwic4UwQqyKEbUyuoJXb5dhESndLDmdb2ZiMQrnGdT45Hzjw/1H3Kku3D33GgRfQ07XpJrVMCoiuthTtCJDKq3BQeGsMGouVJFX4lK18pDkqD+wDFztqqKSo+aZknZrk3OCdh9rsXSa7Tu0qAQidjmMsEcAzV7jmyig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1145.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 03:45:11 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 03:45:11 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v3 08/13] riscv: dts: jh7110: Add u-boot device tree for
 JH7110 based boards
Date: Tue,  5 Nov 2024 11:43:23 +0800
Message-ID: <20241105034328.56439-9-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241105034328.56439-1-hal.feng@starfivetech.com>
References: <20241105034328.56439-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1145:EE_
X-MS-Office365-Filtering-Correlation-Id: 194ac7de-f16d-406c-a1ae-08dcfd4c4031
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|41320700013|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: ok+q32QdYSNW+df7ivBnApjuPAlO4jQ8ZOUVH0VUZB63NKqqbdumGxdf9zQ6gY6Tg3fYDDI2bS+KNgj5m+KfOuUTFtiv6UAkeP5CHzoCy0X0Zkde06HfoLED4ZIYSYO630djpvWm6Q6vw6MrylKwoaunY0RkgNmu8Y7De9rOsurh2wmjwmWdCcheUh1dYKDCKMX/54n1XiH4ZRZDqAyiC+pLCRKlvqPJpL7yePqCPhPDWE1dIqg+5SZF3qo1CIo0B7OGDka09FSzX8DPBSgFyj2MhqEBjZ8Bxe/rPd7ZNxYp2SZ964/IuW7159o9JJOzTk9rVy+oz3RZuxWELinxA6LIMVNSP8Ru9htOGyqOt0Rc1axcvOviNqV29OgdcdrfVbtIP6ZpLM8IxKiDotxFDgkMfxvzhByMcgMH+AogngHGc02Z46PLJw5w4VVMiPTJOPG2nH7aIt/baCGhEeS+0uan/ed+dvuIw9+Ty5n7sZs0sbZMkKPDSOB1D+8bugnSyDIu8RMgOAodrnlxazuErI8gtpZZZmHkN2SvSMmZZD3f278guy8QxKZ1VaMMccm6eS6VfUBUJKcQVAkAcL23haCNslXO985EVBt8wTcLogBYwYfJg/PkWvTrUiThDDsh3rzE4jIY7pcoD60si6BhQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(41320700013)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9D4MenBJEUMj2U10YXcFhIH63Lf3zIffgGoG/e8dk4CArPTkVTJ7HgEh6UEI?=
 =?us-ascii?Q?g0u0j2pkvkgsYYlRcxOoCwv6JTQ1JGK+A0KFvir3ffD+XTEHPjycQmm4zId+?=
 =?us-ascii?Q?S1caUI5q9PxPVqd8F3djmLoGRuugKLcUjChqbcR1/5LmSMJTq1xb844TTWHn?=
 =?us-ascii?Q?oLzXD5H4IKybe9Kzi4k8cH1yRl7cYQQC+DqWWHpMKQFygimOs95m7VBq8QfN?=
 =?us-ascii?Q?S6WjcwHvsypF8MpW/UsJzCFiSX55EWoRUjL1hLSmklidwJAxNOjjO4B9U5K3?=
 =?us-ascii?Q?hyMdip4arQkK2Pf8mZEA605plQ5R2X3a4X5o+psLvioPMUySAp+pW7e23yTM?=
 =?us-ascii?Q?pO3b7mZWUPgSsk8UfOYW7nTQ5KcMuoz8dTJr+/VGI8q5X7Ex6nkbAhwjpFyD?=
 =?us-ascii?Q?HmZs5UpQdXuxLBf6uoPZJyjAEOnWtqqhWqwAW4eM+qxWRPSaa4QvijXSXejR?=
 =?us-ascii?Q?jcyMQIHgmfG08jtkyBS5lRezljsHyiUsHTOgFlHJ4fvdtpvDVWVIoMeI/Upv?=
 =?us-ascii?Q?YET+ttEJdyeFvMYITYotkczfEaHBFnaQ0L+FTddFy3m2bbvbMnXogme8YgiE?=
 =?us-ascii?Q?CC5MgWoNhrmrlX/GgjZpf+TKbT7Q+GcKT/G9xvFH+/XkpGukaFRwRs6GyBfp?=
 =?us-ascii?Q?LHr/WFZ6RSEMELmhxJGyJxy7de/iFf3jOodsileoYMscuxpS9jPGz1iEprm/?=
 =?us-ascii?Q?eE6e7WLz93gBiJQXMNSiNRQkcD3zvIGAn6SzBwU49harcCkxb9+FjGA8nUga?=
 =?us-ascii?Q?J3B4CVn+wvMerPSahzhNj23krDmdByAD+/shqglUS91+3VGvKxC2lFgAvYJ7?=
 =?us-ascii?Q?MRZN3k0s0iHyAawm8XzWMelyP+SUqCX3GXehOP79OpM2HclOssQpb36C+fFm?=
 =?us-ascii?Q?manniGLAssQUe/JPPsNrL8UhvFfl9XtYfTdDr/jQon/rs0U+vZrPDMY38rEb?=
 =?us-ascii?Q?4MDGaTXAMTVoaZNZOFwH1ewDPN9PoOPSepZiHRtDGuZDaarzU2+OzbvZikMu?=
 =?us-ascii?Q?vgZAC/9eIeVfOoJPiVvxJTQJCjfr45j7RKNrIxfBABMG+Dkuiv9QuieQP7RA?=
 =?us-ascii?Q?FNPwFVAOuJdAY58iRPaQLCSBOm4hPW2Qn/y+vfVFk4AfktRElxlOJnXsqn5t?=
 =?us-ascii?Q?ijKCb4s2yP3+5oSniBRUvt5ws5JcCnhLB4s7kxVXEzh0/pYGMeaBgF+6cuYR?=
 =?us-ascii?Q?cYhjQ4bxmmZhhMiy47bor7u6AOwoxDRfH9xuztzwIdBkcN4PdJJ+pCYUezLk?=
 =?us-ascii?Q?6HA+ZLA0pg1hrJ0OsDdUyVgTr0f21zqG8U0akSfMWi4x2hWx/UGb3hqABYLm?=
 =?us-ascii?Q?5uc4Q6PuE6zUZ14xiaPx2jUYH8N2rA5Dx7CqXNSZLiBGc9178u+bCybPjiIH?=
 =?us-ascii?Q?LW3rrsZ/p5tzKtJpL0EPBaknZsVLQzjbIYymvBzx1GHQYjoFx1B2LTOIyK+V?=
 =?us-ascii?Q?+GzuwYvcWsHDzcnBugL73bAAJORAlvnnDDAyiUg9vmAAOTyUbR4noVu1Ncz0?=
 =?us-ascii?Q?xgQQV0gww/hsH3GqSHn/g2X5lxmttffUC++1fZV++BklnUYK68e43rh3Abea?=
 =?us-ascii?Q?Bl4gtiuBx2MOF4sXw4Y19sh7DL3KW/LDyjOmarqnOa3vPyZ4nU4V9P/MwZ4M?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194ac7de-f16d-406c-a1ae-08dcfd4c4031
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 03:45:11.6926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kvy4p66HxwJDUdnfQdVEGQaP8bZGG0aW+4QOlMyhf4Hcbj4fclklbFdb0+xj7VKgVosVPlNRTw+UX3TTdg26pPCwgWj/XzDD7Ll4sqefTIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1145
X-Mailman-Approved-At: Tue, 05 Nov 2024 04:45:33 +0100
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

