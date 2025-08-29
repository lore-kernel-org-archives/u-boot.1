Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC44CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78558837E4;
	Fri, 29 Aug 2025 16:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA3B83599; Fri, 29 Aug 2025 08:10:20 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20706.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6207F834E5
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 08:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0EQXLerTuqVFVq5S9JkH18a4O5IBxuPa7V8vPTW4w+EPGis6oSM5J8Zbi8HckgvMy1+Iraz78wc0lzRenMozwEqYdfGorLWPTITSfM+LLv5eYB2xuoTQKYy7tJJDqz6n9ds6NCw3aOefHr3NzDmzOxROxmLgS8B/P492UkyqFoR8emLCNJxL92jKKs22wtv0m36BPiz6uXAOrriZM4EqNv9FjY4REb58mujpGpooK7iXkKL2yOaDSag/RcxRYY8+QsvqM65hi429Gvl4AWIy5vnS602dYaXxK+ws093CP43K9kGuEnAS9mUyjSz1WfzOmvYPIEGr4d64J0GjOvqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5YO7VhGtViIU8B54ObKi6h19Dd6/YMemEbATYNx3LA=;
 b=hq/kCrLvTX0qdZUIhMBOKtHKQzmojhRJUQtMVtkVL7UK8pdClgvwaMRSauyK14S+6QSPig0QgnNBazDJsBsYyEdGJsdJgIt+en57/EqCogupEzkHOg0xAI7AiUCtZEOsfIZH8ufAOJXANGcVh89gPloBc9ZieZ0+cl+utTGULXzuZ5UJewB9MuomtDbJ6vZqQOFrIx6DYUozebCpZ3vGKVK9iYwKRyS2FZoyTe67aiKsGZ90DTjT6/y9zc+6JGGX997TqvdIxRiU53/DJgRJoa7zD34I/6ZyUNVXkI4svnx4ghAktyCJdSu60+oPfF0jXOdVqpYQsWplhDpbhArn8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1257.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Fri, 29 Aug
 2025 06:10:12 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9052.024; Fri, 29 Aug 2025
 06:10:12 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [RFC 07/10] riscv: dts: jh7110: Add StarFive VisionFive 2 Lite u-boot
 device tree
Date: Fri, 29 Aug 2025 14:09:28 +0800
Message-ID: <20250829060931.79940-8-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20250829060931.79940-1-hal.feng@starfivetech.com>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::27) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1257:EE_
X-MS-Office365-Filtering-Correlation-Id: 986ad14d-7b58-4ad2-7344-08dde6c2b717
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|41320700013|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: 7E1mcc2vz+i2c49lEf8XtdXTHv12LxwNRig6F01E6V8J4sKA9UIK4ewM1Pj27iNVzI8Amrbc2ax11orsMCB5I45zhdzjwXueg7Opzs/aJh+E/rq543SPm0qScZoz61g3nE7GOFVfOjuLSGOLYtD2FRsFw5Dc9h1cMkCaLfqAmVMb5zFpBugMBeNXbBdkRqAIZidSn2mFchhD/YU6mEiLB7f/nqLPZNrIRWORRIqlLjJ+psO/cSSPyzvufKr0XnLuQcjtLSv7Fgo3X7H8Cy0rCM+zUB4dvUl4quux4oCetfEGTrgK4kc+q04blpFe9+5cmYjy3Ga9YeokSIJl5EJ+qfNkV47PDT0c+zUJMpUXAjW/m0B0cOP57bPrAgxQXk7Ncw5zoePlbpOOS5ua8SLSUq0xdlDy5sEh/AszSUNX0U3cnJQoor0FYkw1+4GKKSrtmaAXSYDPx/jB9DtLRjDq6Zw/mIdy26KWS6wKTK20PaXtMESN0bMaqdIANYOfJ77XBseBxBfeOB6lUHrnAx2oIH46uWPJeMT7PaxHAbgWaGFMcFsxfPhyDYqi/bgPM6qUXNdyG4Rk25I3Gbs1gNF1Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(366016)(41320700013)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oYeIw9bL8UayGJYEzflD/jv/x1uzLpV0OAltbsyH47F3pfftO95OaoTVKIcd?=
 =?us-ascii?Q?fPTzew++caXzjuWObqZjH2TXlf7szdT4JNSPnjiuoClxuORaUFSgcNWi0uM1?=
 =?us-ascii?Q?G7F18iSr4ykOXmNAB6byLEUq9bq3TnaxFQYj+jW2R3xnGa4cTchXpO1fecsq?=
 =?us-ascii?Q?sH6ddSCoN6UYi0Xzwqd/oG+kJZ7Yg616F+jeBL4pJGwa4nZIebyIt7yT/oBS?=
 =?us-ascii?Q?pUSXFpPvRL2ihTViXv2QOZAcs0BXCI11Gy45CdfB3fDUecco6GYYv7EZxDY1?=
 =?us-ascii?Q?4ss9jdPQp4IoGaV3ntDQUrDWk8ymH5tnaLxTzdoKJF7KmFQGK24H2kdGF3T2?=
 =?us-ascii?Q?beO2AAktR1orG0LgH6KxJe/JYgf1NOEomnBq2v3tN2KH59OOBXBtzSBcpjRT?=
 =?us-ascii?Q?yUDFTag6fVkA6lK4W8gQ1GYIcwpfZLe4bmXuFgDRcLVeKasqtF0Az+QMTAWC?=
 =?us-ascii?Q?rQ9KtnGDNSvH6rPEctSYTH/rdq8lz9C4o36BsnyDtBZZvzOgMP0YX7BwDTuK?=
 =?us-ascii?Q?4+IUQJR93T+u8VK5QV34FglDFREIKALlyJqMhSSR4Obz2QzK/vXCz8HJwH/q?=
 =?us-ascii?Q?jRqmJyZEJlQSPgheBffzQaKNwftmVQ+pS+YaYZjgqUicw80OB41CYZBwHFse?=
 =?us-ascii?Q?+qN6y1udZ6ORZcobAgEbl/beKcmAsdZW13a0zOy9VYsMvekPb9IW5oR7jiUP?=
 =?us-ascii?Q?nj9ZGx7oUCn0H/v8otmWt4NxgEjvKAK06AwP0snRxBpD1CvATUsW4nEXRd/F?=
 =?us-ascii?Q?T8ubWoj+bWg57AsUoi3VPba/k91fJNFJpq+5mZrZVDd2gj9odJZ9uDQOpbdO?=
 =?us-ascii?Q?uLYQPodhVV7Pbf882zdRbpWT7tCE8mFETGyGPpVBXbR81qFZ3d7V3fCfpWl2?=
 =?us-ascii?Q?CfCZiU6pX4sBt9riiX3DXf0p7pmp3sgDHdYbx7eNbzhtBN/KuYunIU0e/VjZ?=
 =?us-ascii?Q?e8cZs+Fkh21nirZIlYH+lhSxmiYpeINJGh/wbqnxdN+/cE9s/UD+ZJeSx3Kt?=
 =?us-ascii?Q?lRbwORUj0N1qWwADqa+ufEu4FGimMTLXZcBEILiqFXpuXAusWOoWqF9hQgdv?=
 =?us-ascii?Q?IdeVTmO+PxePRzdpYi7k2hASsu8QS/VssZ7Mk8o7apSMfQrldaMubiIKLmu4?=
 =?us-ascii?Q?mVCzGn6Duu35JjyWawn0w67JGF90DqIu0/oMwTsPZ66l+tt505Cz3PeP9mAe?=
 =?us-ascii?Q?ND7bUBR4yeUw+lP9aAJqEynsPRqyEEo0DuUBtha5yhY+ZLuxXVfdmb2b3ut2?=
 =?us-ascii?Q?cXpePMM6P9lcKDa4vQxCJXJjjwX0CQRf0hCfcBLtboqp8J7rYC0OLd2eTBN3?=
 =?us-ascii?Q?Pr2eHh0R2A9icFZJXj4ltdlN3NYgsFqQKT4jlrvfkQc3g7wB5w2TRua4F062?=
 =?us-ascii?Q?juZSYIQpMMfNTR8tWQduYF6kIzw34oMZFPLn1sudvaPUNAcwlFKfSu22w6cZ?=
 =?us-ascii?Q?SHstoBtj+um8xImFaSmsBtNJa6e7GI5aLTQBaGGhnI5sz/WXq1x7p9XZBT53?=
 =?us-ascii?Q?veVypCXs2wkwG7hPm74JoMRCZYaJvV+HkEZCphIUeNMr7+CRkTE1/63G2Flp?=
 =?us-ascii?Q?gb4KQ8621513B+hf8lwpbwQYhsnm0zdFX0ymh1VFySk6DBM4RmxfeEIgjnDC?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986ad14d-7b58-4ad2-7344-08dde6c2b717
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:10:12.7773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8A6rJKwVNpZ32v2ikjFsG+sazpQziMXu6E6aSC0LgcJzUZA57vAfEEDIVlcoT+hBTfeLnoSlxxZD0Hc/1BgYA6pyPKfYvVE0nzQFFkZV3KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1257
X-Mailman-Approved-At: Fri, 29 Aug 2025 16:29:12 +0200
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

Add the u-boot device tree include needed to support the
StarFive VisionFive 2 Lite board.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi     | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi

diff --git a/arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi b/arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi
new file mode 100644
index 00000000000..46ef07a99eb
--- /dev/null
+++ b/arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 StarFive Technology Co., Ltd.
+ */
+
+#include "jh7110-common-u-boot.dtsi"
+#include "starfive-visionfive2-binman.dtsi"
-- 
2.43.2

