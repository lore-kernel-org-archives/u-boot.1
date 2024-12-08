Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CACCE7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 13:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2809189606;
	Sun,  8 Dec 2024 14:25:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3457B894F4; Sun,  8 Dec 2024 10:21:23 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20704.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::704])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7796589515
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 10:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFkLW7t9xyPidvY90d6qlm4++qTu6QMi3mDxcUfGsnG3TyLeQMuejHk+c/chlobSMiWSqXCVWCb2polfPOMlZ4GaBHuYaOvL4yLe+Soy/Vxl7I4C59GJv3VC0yezxfgNSPFyHpzPsiLwiEHOO63vw7kf4B7ETGMsWHL0TRAwDQYiU/sV9FGt8KpK+1TsnVAE2CoZ0bxqPIZHWTKD5utGT660N7lBLBgtEOIBbW0PQU2Wy1AfliTMx1OcwsCDoqlrE2OZPrTn3k5rVrQJnqBPS8AgKsDQaLndLVxks11iHNs5CDGGRDvX+hW0Rtx3XUAuMn51snI/v1Opx2BAtDzBGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJj8xDVhJZMwrvXOFmLNuUFxFv07Dm+AYRTvMJ4dmoc=;
 b=XPv1atVh3SY1rjv5ATXHWB6WQIeHR/sgvZ6wid34NWLoXFJpyLVnDnZi4YhnR2raO69cyPiC8AxxoU4RTnCb7djp3bdgdutVW6/6y2Q8K7FEF6vFLKh4A++DkG0rL3mQDPExUFHvr8Pvwla6+mQYsARSTCwe/NZm7zRMy33dsjXYsmyEjXG6gjzmISoXIULKoyZ5Nfbky6bQK2y+L9dpeWrTplmtw5Tw53pk4ETw3lIE0ibfv/FpJadrTycsIaXlqdNGMC1Ot+dAleENjYmfzfnGqr14EUP2iq8MUk5PeOzMqEvqQuBcWUbC+0OuvAYuWTVJrybc8bwnbz7UKiw4sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1226.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Sun, 8 Dec
 2024 09:21:40 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8230.000; Sun, 8 Dec 2024
 09:21:40 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v8 06/12] riscv: dts: jh7110: Add u-boot device tree for
 JH7110 based boards
Date: Sun,  8 Dec 2024 17:19:36 +0800
Message-ID: <20241208091942.47298-7-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241208091942.47298-1-hal.feng@starfivetech.com>
References: <20241208091942.47298-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::14) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1226:EE_
X-MS-Office365-Filtering-Correlation-Id: 9315057f-d81d-4424-7b29-08dd1769b905
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|41320700013|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: kQOjKgauQVc0OBuuCXxmgG/6piU5yKdwy9jkGZdEimUP9OovDV5v39m3gp+MzN1GrJrZEcaW2vd5wxpPwmF3L35bbSSoHL1gnLrAyEfoJzl88epdyDgrRtbQEkEoO3TviXt1MYz2w2IGBPz62VKffLDK4c2e/iN/vnJze2L32nCR/2YHQ0XGMF7XGFsruQ5ERywHnIZduMy7tchCE1IbqudUnNT2jWrbIgFZxavk7tDPPsyDrCpSqVjJOJqRlfboeRDIwBevDL4dWc1kAGzUgNgkhc7ZMMKLIX8ojpZpeiYDTPFYLSDSSL44P4bUe93b+wL6uw/hzUszduiCSkHgPsgnnES5FaZbn/HIaDN4vxJuAfvNO2drw9Wy8zhW6k2hcb5z9kj9hsNaPORQTVuu3CLsCATdSJXsiqtffjsice1249ah9dUcTxgg0hMYMSlLfK04tQIYXZ7z97XnlWqotqZ+1SqZB0bXPX/UmeS+xqYS2F7Bxnnr3ghH5rdO89v7u46PK9rtcOBABPIamEs9fYVXP9Sj439Pu5zLqhjzPy7cltv4E0/04YSKQg4H0LLrZhcMPfpfRegoDSLqPYOh1OnwNvDlubvhw+esLiMLk5Jy5qzS4ngU4HULMgEwXLtaaRTyvgkmJ6MB0rrWPsls3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(41320700013)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w/itLwLF599l5oiZSDDsBmzgwnWzxr/FX0RAJOdNs2T71Bxf/iOIO6D7HdKh?=
 =?us-ascii?Q?sXdBxZGBtjSXpSVHkvh+U2PGchngXbPJiCgO/2jWqjTR0b5rfYIb8zvWUWgt?=
 =?us-ascii?Q?fzjn/tDEOqgkKkLIObp46KL5L1puAHND3Zijwo1QwOKQBfZXIz0030sDyyJi?=
 =?us-ascii?Q?PS0HfN/PBAFhVYHFJragMbxw/PCXr/lrNrx4ZUkIQvrBhbkVVSpdwugpe/fz?=
 =?us-ascii?Q?2xwHGj+k8cgSV+QMIxfytZZr9bUV/F1KeN+E7EiRak5QEtrjg6S9Xe8kZ6IT?=
 =?us-ascii?Q?0BwKrx2pk560c+VgKN4BmfsYGEW9Nsf8oMjS0WylIhTIuky6DHl9hEsKqL6y?=
 =?us-ascii?Q?vCsdr7dTaET01AEZyU8sBPl6APA3jFRCoz9m2kdcuUNOI/8qKCN/GxeU4McC?=
 =?us-ascii?Q?7BIMzps43CRi1TCSBe7fclizkDWFl+RqHRGvHBrhPay2DBpGy0Lms7LA+h94?=
 =?us-ascii?Q?K2qGyxiohsmfSSldY4rQykbOuoQEVXYi3o3lbCYRKSvO/vVnmPijsWkuhI60?=
 =?us-ascii?Q?bVDOeswU8Q1PBLf1gdBg82loz66LaJO5/suENbQbt9we8aKCTzCeoxobiMOZ?=
 =?us-ascii?Q?czwjvjA/cPYRzXl8Mo3rW3CCrWWMDRlQ46fgX5XPKogiNZXgBuB+QhmB+Xl/?=
 =?us-ascii?Q?VzRdY+1/tEQuGRiKV85FW6Mr2IrgFRbI7PrOWKqOV0CAGxHIQrhxB6efL+x7?=
 =?us-ascii?Q?qwFV5W+5V7948oKdmJiyvmP/3UhfOxSPD+Sd6dclBEy/RGnH0Yzhiphb988J?=
 =?us-ascii?Q?LbQdNfinAZNVliu3DQispfdE3mB/KCuoDdLVPdJA0DmM3QaMpRjSS09rYCPR?=
 =?us-ascii?Q?YpPvpbMKGsB3ijRuISJq6vrkgDE7jPU8IRIEQbCNGszZxdAlFZrC9nhThqvQ?=
 =?us-ascii?Q?2uCwI/xcNE53sf1/kaSMhw2F0cqAkkHGQTClLoFV43GKssRPZlSAITcz9ihx?=
 =?us-ascii?Q?qeeoHv3w2EMhMuK5F6MYP8NxOdfdFr+6WU2QF4I68VlibqYJF+IpEY7UVxll?=
 =?us-ascii?Q?OsDiqZOgcMt1QQRswil/p05Xln/ZpYmFXBcXIlccSanhcc1ON37D4lDXVG6t?=
 =?us-ascii?Q?fVY2BDPfCFobpmBETO6nILqjrgV6qHAjUPbRajUV62ZFQb1IzO6nU99G6v89?=
 =?us-ascii?Q?MBnPzVBXgKY2uzMAMZrNh1JsKtzLTHiguKRJbtTSltAp0KZFEPsg2md+6YqX?=
 =?us-ascii?Q?Lj9AaRtIDl0Pwm3C7EfkHpa8uCIx+JtopVjd47KomgeR2LoFcaXpTJ4CDE2V?=
 =?us-ascii?Q?WakGtm18LBda0JSZ+30sMevH1dHqX6oBp/kf2Hq394LPve1RU9IMcsgHhc92?=
 =?us-ascii?Q?dRMuCDdMNYtTlb8y/jVed3ZwchmJOdAxwzyh28OoNg9B7MmpMn/WSG0AzSq1?=
 =?us-ascii?Q?wpNwPcABC0yePaPvkwFfImTLEvqxXGISw2Ui7KZQ8XJVr0qi0/0RXAekbe4W?=
 =?us-ascii?Q?x3oS/JwrlCOFmqOSgWQ8X7tDJb6SRw4gJ9nL+RLzs+OtjVFimfPgUJg9JLOg?=
 =?us-ascii?Q?D7tithVokqtNYaFpt73WCOLNsoTU8COIP34XqhZczL1aojFOHG1yEDUbQS6C?=
 =?us-ascii?Q?DeyXxTxfiA0LoPLR6wPaFye9OywSRX58pYamYiy8n9L8YJConC2MuRs9Gz7j?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9315057f-d81d-4424-7b29-08dd1769b905
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 09:21:40.0732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7k1VLMQr7QTg5OLDrxgjF7BGawsqrtU0GbjO2JG5EjDjJmZJDdl7QZ0bdMwo91aRPMOscOoNoHfgy+tk2XXK6C7Eq3lrmXnHc0mKThqYnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1226
X-Mailman-Approved-At: Sun, 08 Dec 2024 14:25:45 +0100
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

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
Reviewed-by: E Shattow <lucent@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: H Bell <dmoo_dv@protonmail.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi                | 6 ++++++
 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi             | 6 ++++++
 .../dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi      | 6 ++++++
 3 files changed, 18 insertions(+)
 create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi

diff --git a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
new file mode 100644
index 0000000000..9df1e5db55
--- /dev/null
+++ b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ */
+
+#include "jh7110-common-u-boot.dtsi"
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

