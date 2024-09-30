Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527ADCEB2C0
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 20:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4F1988CF1;
	Mon, 30 Sep 2024 22:40:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 613DD8903A; Mon, 30 Sep 2024 19:04:04 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20705.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::705])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A67688FCE
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 19:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJPl689eh0CWFkRJ53yLXKkXGHC3raepi01yWbsEQqOWIdjSq6pzj5xbDOrvI1UWXW5WRWbWYK1QIEpf8RXqJmnOI4PUbUdk9yA2APMOGFHK/dASYK5kUWmk3Qo8HddFX6NPj7VET93VCVC7jbzxt92sMu0nat+1gk0Og3N4q1LkuI+9oEH6yAVv5+pJd9xjyDNvj9Zi6Dxe8+2eMtrJLyVrhDxh/vWIoeVt89HT6ZBQGBZoWN/8fuXoN7jWbMMW7Kn8yi2gtAoFG2xXcVx6nP3UxLBTKQEWhhAmkx3BvraehTAGKRrrO6Vfr/ocDvjHS2YFc547KzJQJVa7a8p6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS/chOSHBlh+gHirKSS/6As0uplRSofJf8ZSdAeI8WQ=;
 b=gy68BCqE09v/JY1bxgZ28aImDOXrjmR/79a6FzTeZEtv3cVU+WPgpU//x2Kn/1MRheqzuTwhoX9l+4Gy6PNHMiaLAi6xETWgCJltzPYnXzDtfbGLWpvB5oKYCmVuGRZOkSuUTkQtGh7hGZEbMqqkb0c11u50P3+ZHHh1+EycnfM+Lskzm9T083Rk1yxfaQEpGB9MeEwxQLDzeiARN3GoN8w6YRPaegyXNgPwJ4JwOQv1Yu3UrKWludtzzR2blTpQ6yd7OSvDpS/pEKO8nExoRT6XQRhM78GRgR8oEKEqSA2cjo+HQv7ghJU5NPh1dNlnk1ahk7RHTYvwSntC4bZbkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1243.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 15:59:37 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:59:37 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v1 09/12] riscv: dts: jh7110: Add u-boot device tree for
 JH7110 based boards
Date: Mon, 30 Sep 2024 23:59:16 +0800
Message-ID: <20240930155919.111738-10-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240930155919.111738-1-hal.feng@starfivetech.com>
References: <20240930155919.111738-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1243:EE_
X-MS-Office365-Filtering-Correlation-Id: 94849454-31e5-47a5-7c22-08dce168e277
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: wj48svZI5rmtuJ0bRGt1Xe4JBokDjrAuX6mP6hLeNipySL4F3kEQdNA8V56vmskyqx/tYMhxbfXXIJtly1a8LyO82+H+E+0Eg+IIBvcy/4hqQ7pQBbIP3fcD4OyKFiK2VO7N/hCngEjne1kSz98hCV0iWBE0WWa/RyjRCxT0B9RwjMeU7TFkPnxyal/bnGgNG4Fx3Tx4M8T/9crLnogPTwCGYJncmDDGxEZoual7MWYHCfI1ApsA2j6Phnjh54N0uta5SfhOqH/m/TrZGHkhZHVBOU9vlNvD3un7J1U7RT4KJTEZUeuDFwZh3XPkaoygGKTUDsTckxl9DUXVmLuTvKwCacKlM3f7ArO4TBr++shKDe/C/K1Ny2cn+5q1DrLzct/EYGxk/JtN0LI60EQPWCTv5YDhlpgHkAlNBIGAKUvvzjPaNg3zNvG4SrgqameXbBl3hXq1HuwZaY1wmly04E75lxfBw58blo8cWJx2Hz8V8VhQ7S2hcj0sjueKRvcg0yUskR915OB5Uzr1kOvx3q61S7R4vUAG2laTzazcvlYgUAJuQVAGkzmosL88f1CwBQ6VI1G7grf9C8DS+BvU7AD36z4U9nC3h95CPIQY9dqmcUejaEmFRoX+BNTnyd2L
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mJIbK/NJNg0sHRcHP2koANwD8ZOlMLQrF6aEbcU4bsTjGmeR/vnFv0KE3ZOE?=
 =?us-ascii?Q?Ooqy8DpmFpXn/jmLgfmfjrM5C/mTQFRS+EByhJ8mRAFmodiU8VhWsuh5fEFs?=
 =?us-ascii?Q?xpZFI7QG6GcIRKJvmg9ETtdLZsvnBhxuKkDpr1T30aGBVfjbmeJixsFWV1AI?=
 =?us-ascii?Q?72cVtbT0NKNQEdk3nC6d8P0TicsmSeJp00MC+eXlyKRCixsZOGSCM6POndje?=
 =?us-ascii?Q?fD2Ut9C3ik5DbbnM1wT/szlj8moocrgpmdeTqNQdq/o+jWwCdf1qOeRCKrnc?=
 =?us-ascii?Q?wpFOa1tDLucD3H0YhJe+EutCdjlbmRzzoqPrxEejXDcoNnHo+zl93NPscOXr?=
 =?us-ascii?Q?dwaZbsTQegtBffXq5I1PAQ8qqhL/owBOTzpyDfUJsItN9UMLvXpbVKGGCAbT?=
 =?us-ascii?Q?FstfLSfN6ANcCrxuhNR9Yp0cOz28FOQHkU4jAhLCMUntX5O6WYAC7u+BQjTV?=
 =?us-ascii?Q?3LI3VA0w6CXUCRExLmLF5T+aDkP+kAWOYC+V9vNtGNaCfjJvc4kvby8Y71gS?=
 =?us-ascii?Q?V30yPlFOlzBtaAECJG1GIPWHWzz2bxy4vdp3BmXNlqDuCGx3o5t3J00cG2jg?=
 =?us-ascii?Q?xCg+aieGG4Cw9gyLiaKGYmPFBhfqwD6JNh7sRPY6AkXXj22Kz0cxXqtP7/Ps?=
 =?us-ascii?Q?9Jne2FrInp5hf4waOVmVUdcwR2lVYlZ7RysKhL/A5WxzZsqLYQTxlFWd6pJB?=
 =?us-ascii?Q?yuk9CWTfmqlv0vJYy5JH36NkvmjZUtMX91rEU3Z5+IjG8taKErNISu63Ktki?=
 =?us-ascii?Q?8Cri+lf4sB0yEmtR5wHOgS95AWHJmjhjsU2mhK6ry+O1LhSeKjSXKB81D9d5?=
 =?us-ascii?Q?9e4F8L1EBtmGLI7x+KHxtYFDdbDaWhlu1u7yg8HE4I1WpJPRBslgDOE8MTn2?=
 =?us-ascii?Q?7yPZdtvj4YuWc3rilydo6a+I7hcNbNpeH5BrzlUUODGa2YZgjzn5WCf1DOUZ?=
 =?us-ascii?Q?piQJ7PmIZb7+0xECkEEGPw2/Tedz4wPKsY18kTFYdK+urbwIlvf87UXSVAOp?=
 =?us-ascii?Q?rpqxgiK3d+YzWok2+D8qRyP/32hJYsY72RyhdMyvCQU/lb1LSuSQ13gsg7/h?=
 =?us-ascii?Q?lQlm27UwPppHccvAjlmCzT+x2mBi6J2X7n6cJCuHH6G8ag55FmUqzfZZp/ae?=
 =?us-ascii?Q?yHFKDfFivXbqX8bya7XHRiUUteYHmda/dvmwhYG3LUrCoHzWYe9fQCSzts9F?=
 =?us-ascii?Q?7IIyLN6DWJQQ3N0sDZcz91XlE1fMa+s6e6SMsfn+g5ihZBtgNybVUJ5PPsTW?=
 =?us-ascii?Q?oPFKw10iwgEldbYLuzQEr0Id+NKOu3MizlukoDN2DbVWl8OZULqpnxq8EZ7Z?=
 =?us-ascii?Q?caSOamxJZ6ewCzKJpolky9HER2sekSJJiYpXJo+SRK3YelQ1QswqTauJrseC?=
 =?us-ascii?Q?aVJJm6yhop4enyLOPjnveQxFZF+JIvlwjQZg9v4zk0+F23x5oKP0Stc8oI5J?=
 =?us-ascii?Q?FdlhsweT8BOr3firtTCjqpEMKvhcKzkjpwYue09qX04BnhmzxZibIQABNa3F?=
 =?us-ascii?Q?70oL/zDfnXLgpXbk8jns47tdcwGO6O9tdru57gm8oozULimk1K9xA817ip1r?=
 =?us-ascii?Q?gX0csVsHQrCMPLBZqrbArCjxtjtDczeQKDwpBzrl2LQ0H28TCs1LQaOCQ4ll?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94849454-31e5-47a5-7c22-08dce168e277
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:59:37.3255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGlNebus2fjEnRAiuvN7q4FeVbYxJWBitwkGzvS6tLK+Et4W16aSQyDFHQGWDJaFkmthFfDPFP7jshIISocK+HIqQR5XL9FsGNGDSFmdddw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1243
X-Mailman-Approved-At: Mon, 30 Sep 2024 22:40:01 +0200
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

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi          | 11 +++++++++++
 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi       |  6 ++++++
 .../jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi    |  6 ++++++
 3 files changed, 23 insertions(+)
 create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi

diff --git a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
new file mode 100644
index 0000000000..2ad4068549
--- /dev/null
+++ b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ */
+
+#include "jh7110-common-u-boot.dtsi"
+
+&phy0 {
+	/delete-property/ motorcomm,tx-clk-10-inverted;
+	rx-internal-delay-ps = <1900>;
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

