Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64690D13592
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 02:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 208E2890A9;
	Mon, 28 Oct 2024 03:00:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BBE388FE4; Mon, 28 Oct 2024 02:59:22 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2072c.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::72c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2263288FFB
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 02:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZD4SC8JMfGF1V233oKYsjAk9szdAzpIrCdQUNTNtBmfCxi3iu7xBa+ZvMxVq0TPCo7AuimpECO5s75W7vH1DCsV39Aqgt7wcswqQLBDVTd33EU3/0cuSwNhPCUBjORH0Nm+ubD3uERcT+oUz3DkX6oZRCxyvrlePPBeDHYvMPsKamealAysoLwRtpAUifhUTHMYx87md2PrQm3bPGG37ivyCMpWnAoCTGQMAizHYQ/oXWTCS/uF29cb7aVHhUTi7U8XnK+ndEbyJaWkGLWzZUgga//4y6Am/8sXldDuRfIUkWE2ar6D6VhPi8xoHaH1WekaN6zjvJzumqj1/1DCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNY2HRiVHhri0zcxwGpaOtkLqpxlDaMt3EIwz50HTew=;
 b=RVGudcH62WjJ0vq2+od/R/l7MuNg2mn1Bfq0MNl0+hEmB4/8H601NEAkMRzZn9Vy0jDK3y9xkXgkoZwc1GSOyHQn+GYsTMjWmIMgWTLsyZPfDDuiwTq0xWXxPwFxExWwAwEUjO+oMnwmdOvjG/aTA1+QGpZmkVXxBYhiOx7t/FKjgaO41lhtQzK6t5LIHXNjmF1ucB4bUq3r3IJRM9iaFfhAA/17go+HfqVjuwXZ/rMNePnhyieTaV2bI6SJW6cuH7S4QDDohmxaJph6ouZryQPg3Ut4ZlQE5B8pt5cxqY8POT1/O15uQJwLUEc7o7LOefoRug8uQl8NPEstO2ILGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1211.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.34; Mon, 28 Oct
 2024 01:59:14 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8069.031; Mon, 28 Oct 2024
 01:59:14 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v2 09/14] riscv: dts: jh7110: Add u-boot device tree for
 JH7110 based boards
Date: Mon, 28 Oct 2024 09:58:42 +0800
Message-ID: <20241028015847.42344-10-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241028015847.42344-1-hal.feng@starfivetech.com>
References: <20241028015847.42344-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1211:EE_
X-MS-Office365-Filtering-Correlation-Id: 6abd8327-78fe-4ace-1f98-08dcf6f41fbd
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|366016|41320700013|38350700014; 
X-Microsoft-Antispam-Message-Info: /9SdV7M24aJefRbu3JYPNRZpB6Syg5Y44vF9fxUhsH1HDDEayhS1dPjjxRzbqca8sp/rta9/DOCK6ZoqlbpBeIz9JjP7sXM0eaLwnqZ+LFd0Y3SOUKOXevBHqas6jV7VJDrRv5U8p7ScDtr8POdDQEPnRtJAGO3yAJr4NirRUiiqZ4z9cfhvufiBIWvYR4geaMSGufg6s0nGtm+LPG6eh92INGjhq2h0Uh1RifgIDcwWGyFmmt/+4VueCZ1jSrgmuOaJUU9iQpCpK69DrFuqQmfXbTcopLWPBWlfHZtjnfAHc4xdvWcfvGOe16vHWtDm1TGQOJEfZoYYUsMe/x6g445KgT5SeN+t9JYDJZGx3V3PvxnNGcJvBOI/gEq4XGnlyqpQVsUp1qo9nDaLpgqyuLeTpdT7ZEQ5pqGCkR6Ts57wZ0g9otT4vL1IaR6Qou21SK3oTu6FU3hatjPMoPpT9WpwdY8mLbu08slOnjPAIXaA9A2DVIZQGoPpnXFyVHxjzObog7XiyAUHBwQDNjoac3hQnvtHUennFIKg4nO2cx7ADdoAxUrFNfk/dhCk9MrtXiv8EoS1x2hOhEDg7jhESz6zCH1TSGLM66W2d1kOyYdwORmfuANSdET50yhNEZkw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(41320700013)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?enRLAGOGFldtyoTmN19b1Izpny6d3+asRVOTHfRswgtKF6nhbjnbpsAuk7uF?=
 =?us-ascii?Q?Gbo8YrCIDLwA9zoc5rryl5Lf0ub7GQ6FeeKKsitRQKjlOpRbZ+WrUS8n6dTU?=
 =?us-ascii?Q?lpIlHJh3CrLpBN1/Ho6uErtsqDRUiE07XG+DgwMTBbpPCzzHOn9FhI1S9rTR?=
 =?us-ascii?Q?OalW2efd22RT5hHEC1N2Viq2OJq2iQSyMGlVYM/wLLHJoSKts4Bt1/lZIszz?=
 =?us-ascii?Q?x/UM4ccmBuyOo3Ighfj423EEDowIE0GDrJTveaU6Zwgmkq+nAZxLOwk/Wmvg?=
 =?us-ascii?Q?6KqFNqRl7vUQ8CDmSK0l6mLXkeQyxkiRl/TnAEuebffbWC28BGBSZSFGmp1b?=
 =?us-ascii?Q?cRu3rdbjSe4SgCBqs+q1YzJJ0fp/AYw0gS62dadkxqc2CIIF34fjj9Ue70fb?=
 =?us-ascii?Q?aAMpAdYG5t87NruAPzjeOolihikZH8p5wQfGSSRxMzit6Bm3gsq2mVZvM6se?=
 =?us-ascii?Q?i08b7Xx0ZQrgcLz20N6pk7WCJDZT09Yk9JjnOG6oNAgmtPOcUrG/pZRLlrhJ?=
 =?us-ascii?Q?IszLK3NXbx1dfQ6aPs/alVygsDvfMHJU9aJChvKmsUT+fye8/yGL6H8DQDHy?=
 =?us-ascii?Q?+DpL447nYQDcS5DM+iIDdDe5lLplCkKHibXqc9Bcp33qtS//4QFclbGe3ph/?=
 =?us-ascii?Q?O0n5Tjqmr2zCMxR1uT7OlILTtDTMUTJgzFd9vhdLRN4qPOZwZLAtamo3Fp2u?=
 =?us-ascii?Q?xCH1tjRsLhjdGxLDI1yBrgOPN9uDWelqKBEe3m/3hkVdYLdUp0xQubC36ncW?=
 =?us-ascii?Q?mGHFLmjkAPf38n90LYZvLHIb6sZDnYUoIB1gj9+uWs4cT5jmVDLsHb8TFVad?=
 =?us-ascii?Q?+kZVoJb5gmjKL4J4hii1vxJCFO8oXoXmeDantEby7hBoL/jNshqaq+SWPDeo?=
 =?us-ascii?Q?SjoPj4eO5hwGQlWJhQ9Y2E5eI2GiYX2Bp3QronN1MX0EhMLeH11NDuNI60zr?=
 =?us-ascii?Q?27/JLOLx2nuaDJ7gKXHymcO+2oAlwkZ1GHOq4jglDpwPYxdu/PvJ+rjAF5K2?=
 =?us-ascii?Q?eOW/brgGE6thyJOM+4PM/LCACe7LicTPfw+hpSeujlSs5qprdVTCotIgfF5y?=
 =?us-ascii?Q?zFehlNrLwurUqTnBtcevoxmpOvt+cs7FaytKUBFuPyiNdn/u/mRF7DvpTXc+?=
 =?us-ascii?Q?4grtzXwaK3NgUFYULp41U8KUoGOLI4J0ckLOBh7FVSpwya+6TZKKfYpn514H?=
 =?us-ascii?Q?P6wEnbgfBaj2TyaqvPkrfMiObrYNm9HSputzAhFOIwyPLEWzvEPcbCwOjVe9?=
 =?us-ascii?Q?e67Z6bmVgo5xpnIViP69KdFCPAsHC4kn6q4FHc61LPN2EKA+AbjdKdNUkCC1?=
 =?us-ascii?Q?MzuXpIHkxJF0YaOOx3J4/eiRMm5MGHgsqSVyujd66aCUgkL2KmqN4TDhf+4r?=
 =?us-ascii?Q?039mQd+CBQw6VDDQmuYP6VIV6S2/HCYFCl69y+a0Oa+P9cj+xhhlfXRlh33E?=
 =?us-ascii?Q?C9un0XhzflceWtUpe91/HNeqLA4S1m+OlQBiW8hmsC/GNU7A1q89Auq/AeOu?=
 =?us-ascii?Q?judm71Vow6nOb7hGk6YVSM8jlo+OjP5XQl2WYXJS3/WsAGg2OOiZtAPKGgiC?=
 =?us-ascii?Q?AZAz7eiXuu/8swzmgNbMP0elsU6d3zb53i+NOcUqZoCL0R/YJRZacqX0xHCj?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abd8327-78fe-4ace-1f98-08dcf6f41fbd
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 01:59:14.6041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJabH8n9ZobHwIDbLYQMNAYOgJUOFHpH7Z9O56hoKru0Ti3uzsbKj+dpQuhas4lYaO4pkXUmKhileuIIAWbTiGVpH1UXy2XfShi9tm+tzlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1211
X-Mailman-Approved-At: Mon, 28 Oct 2024 03:00:01 +0100
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

