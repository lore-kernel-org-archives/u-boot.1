Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BF3D3B7CA
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A844899C6;
	Mon, 25 Nov 2024 01:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13590895E4; Mon, 25 Nov 2024 01:33:41 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20705.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::705])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B59CD895F7
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:33:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNgOQWpARoFGPbt6u+PZxsDnRsvl6QSZ8OZ1dW8QPrkatMbVPXNKBfcEtw3Xm7APE/naHCejYepP5/WRwLLzyRnryVPb/A1OA4LjrYHiedh0kxGHQwCWdIGLPjoRFd/ywNC4sJG9ksRd6BipuC+wl+OMegIi5PtHiR3iAlqzzAtvUA1Mw8GIIzQw3CCX9zt44Mty655iDrEmb+0xal5rbl6x5Eq4cb4C3T95nH/1+8w24RIK+pblHyI97/YdsauzQGndowYzSBznyU//JxCuybWmGG7uyOmqCFILQZGYOOUTURGx5PZgzfaX4ZZTc2mDqJJcmdNHaeVu0XqDRVb4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMTCYyAu1/DVD0ocK7gcMxFyj9iLAIgv6FwX2ySrEl0=;
 b=jTaBCw/9tNqAHvZUMJqa2qlohGYnlVsFonzyRqDoxLobIcG9+7XattevNl+jydE49M/h9Qz6HU6NRrvajLDODCOCQ1akMUkiOt9pIZ4VAGWO5Q59DEv8aAApaeBT3F97NJaTJ3ydqjVa5/n3FEHkOqKB7uAMx3jZuih5adiM2G0Ct0BH5PyJCrKQVYxCbSr76cCWPgAfQdHOmr2NJo+JMykEZleN94heQICg9wXygW5OODYZYPKrdTruW2nmL9UvSiNn1VpJOZSpfgW3CxGy1XEM3Cczi2FDzoS/Rsh1m1OUbnxfe6KskJYVFTv6F161iAWGTKfTVfktyCRRag/mvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1244.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 00:33:56 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 00:33:56 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v6 05/11] riscv: dts: jh7110: Add u-boot device tree for
 JH7110 based boards
Date: Mon, 25 Nov 2024 08:31:59 +0800
Message-ID: <20241125003205.75327-6-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241125003205.75327-1-hal.feng@starfivetech.com>
References: <20241125003205.75327-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0033.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::10) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1244:EE_
X-MS-Office365-Filtering-Correlation-Id: 831dc5a1-dd3b-4f8e-4eef-08dd0ce8d8a4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: Yigdb1AMN5jaQR5/c3YC1/XYgCrgBueGgMFe/i1EBHla1sB+GEDSfGxhx0ToNVnwfjWXiWoO6vU4i47Xcfufvz8P/IZJnkvmVO2EkgauRV7Kw1a91kdKrm87451mgkPO6QaPidaW8IISVHR6ZIZJs3Zn3aoMO24FHN08ppWR9+iUtGPPRu6DTKAYNsjynhnBdPRokCWyhNtNDz+qNKu3vJsj9DsrKFTeKawO1I1biNzl/myBcuB+YGXiAFbTfprE3MzIyzB2LjG+1FPSTAXE7O3j/a15Z4kVvk7opodZOcBkHpoNzMv5skViYIzVZ/NIcl6P227n2iGc8gl3dXWoNFD5fE1SEVY5kGDkKCTUZmeGNjSgFUzNxj0vmOj69dfuYaFiIBfX90yFeO8cCUWmRu4E55huRzMjfd96JR7LAx7GyQzrZL1MB2bFB5T/7Tao07ymbWu/R/GDcUkWLhDmKfr93CI9zYAmGvRX5+N7y64xeXuviWYDlu0TT5NS+KiMB7dbsWvF2JCXIj9yBAfM8R9JKeV9xutAOs/Nubtoe3RJu6zvYcZgilh77dnyRunbiXyO++Tru7Y7HAdiFkG563z+FbhnqA9QREgL5ssMYn+7Qtyt/imwBId2lpVFVuE3c20h+7sqZ9m2YkWFV2dtUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LVMw4gW4R3fy4yLvlh0MN2OFyiR7fTG1TkU5+P1uiVnFlFO51RJfEGs57h8l?=
 =?us-ascii?Q?WxvFiLn9GGa/6+QkzXdRmHttJqldvOfELbWpEhIJt//uOMP1OPowuk5iYahr?=
 =?us-ascii?Q?a9/ysqrYfJ/UNRMhIKni2NQ2E+wW6SYVyudYWGRFlSD26AibNFHbi5s1xyye?=
 =?us-ascii?Q?h3ZQGe3lGfha05tIPYLD4E1UDCigcAbMHANIUjNmWdIzVRTSEdHSItq9nPQI?=
 =?us-ascii?Q?Tkg+pSDoiqcltGwF9rbcp3Ke+Wu0IpypRmkdAnM5EVgsxJfV5H3M5/PsZccE?=
 =?us-ascii?Q?/HjHBrwLE9Ie3rWA/hLadmPB206xIiGal+sKLfYbGJE2hP0lpdVVBnUxQFHh?=
 =?us-ascii?Q?TAqfshLj24bMHeFQQSaAbPYdDY17Q1ugEI1IR8RDCaNW5GHyxnEsisymy3Ep?=
 =?us-ascii?Q?8byPWWG62aZQ1lVigRcJVbLyKZUvfA6j1i0jWIjk8g3DezQ0cwQORlOCEOGQ?=
 =?us-ascii?Q?hndiOx0LEbpvHZs6/5896W6shLnCSqOwhJDBnlBGPH7GsnWJO2zUPvwpjhMK?=
 =?us-ascii?Q?BnoFCMnXJeQpZ3cNGWMDmT1GMSh0h2sZf6lCuHrQXj9odn35nKyQFRqLLt6g?=
 =?us-ascii?Q?v0nGQWrDJnruq/mVPhywQGLV7+rImphQni0UzIOR7GRQOePz++9LhX1KY/dO?=
 =?us-ascii?Q?3JkQEpJO0Hs9m2+KsvZeRdEzC9+C6IBINnc2RLpuWWx5pRG0VPRhrvV9RkZn?=
 =?us-ascii?Q?9BJ21CYTf0+HH5Wg+ocLDtkwiWMiispy5SoDRy63U5RbiBG+7it1JSV8UyKh?=
 =?us-ascii?Q?EuY5rw+4yH7/eQg6v9Ck890qqf46pX+DDBMWJvDibXelumFrROgUtasJaXHr?=
 =?us-ascii?Q?NewQzC0KfpuY+pM4oCC8UTgNdcSqfF9OButlfHqfjJDpGohC2O4XYoMIYQP5?=
 =?us-ascii?Q?GkfbC5Mw4xLb7u1FrbjG4pi3OxZcaJDGaFmzPZs6n1VrMlhl5BoP4Mo20wLx?=
 =?us-ascii?Q?FfH7S1mg2CBGMVMBh01TVrSHr63TQWGyDGl4T7tVq1IPHgjFq5bWsvXwIZd0?=
 =?us-ascii?Q?BA3lpDsHG2G2tPbG6fEvQej5BeJBxRQ+eBMfbpzM3NotFNlWBxLFpzQC1rw3?=
 =?us-ascii?Q?CJlix/So0tmiOYr1bQslO+cvwHsx7YodzXppykpMC603e2nFaEMiEfhU2TVA?=
 =?us-ascii?Q?r8wGZyKkeH6xTNmkmRqeIEKtQ3VhX9Wue7TTiISJfO+km18iY7lsR9qHYU8v?=
 =?us-ascii?Q?fxNm7d/DF/dhc7xDecz8QS4Xhn30dIVMuxvkzM7/Y3D6/SuRUAreMrbbxl2F?=
 =?us-ascii?Q?AqC6ZiFfFXRz2goT2zrnlfunFRPmUrZ2wRGxwjrRAqEcK5Pwh99f+QiGBwlH?=
 =?us-ascii?Q?pydRYhcZJK+GYCfJ11wC4G6eW1IWaHvUr20b66S1n3w4fac0q6eLHrD9MoYZ?=
 =?us-ascii?Q?tpK+0epsCbbcM1y8cHliJe9UZbCLHQTDLPqhLlccvzDAH5uQMZjeuXY1Ncon?=
 =?us-ascii?Q?gG1ryGO5YyWLZoRdhyiLowoNM1xBEkCb/VAu1Ti3UXJjULk99ErFtcfuvFPn?=
 =?us-ascii?Q?LZgVZzZqXIg4g6UXC+P7EjxxoQ250BRyaPGoFgTRactnLvsVaADLwaE1Seyu?=
 =?us-ascii?Q?lkoO0xOFfuwE8NXdHXydj46wqIGuLn5pyFvDHkkoQhQvtjacTzxyiwpKMApQ?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831dc5a1-dd3b-4f8e-4eef-08dd0ce8d8a4
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 00:33:56.4038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6dJG3wgAT56Hjn004IgpsF6kjhZ8JS2DVVYBhA8tUMKnckXMkcRWCse98cqIm2W5nhHpunmMyjeosgeljTw6oSHtTuAeC2HYzt7ntxkifg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1244
X-Mailman-Approved-At: Mon, 25 Nov 2024 01:40:37 +0100
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

Tested-by: E Shattow <lucent@gmail.com>
Reviewed-by: E Shattow <lucent@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: H Bell <dmoo_dv@protonmail.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi               | 7 +++++++
 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi            | 6 ++++++
 .../dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi     | 6 ++++++
 3 files changed, 19 insertions(+)
 create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi

diff --git a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
new file mode 100644
index 0000000000..f56528c988
--- /dev/null
+++ b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ */
+
+#include "jh7110-common-u-boot.dtsi"
+
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

