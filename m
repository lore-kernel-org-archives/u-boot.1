Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23DFCCF9FE
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE2A683B83;
	Sat,  1 Nov 2025 01:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="lnbsvmGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D6D083B5D; Sat,  1 Nov 2025 01:45:20 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C372483B64
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqed+xLZx3fS4cbOlXkN9/lbz0HJsLuOxvCHq6c7hgCtpNarahy8+R2m6WezYRmkrASig6rUhzZqqgdQxZRXtS4mMUZv2XIBqIOVdBo92o7wuJVDTT6nBu+BBp5cl/ui6mEkBgy1KAKVL9osoO7079chLGv3rL+jGDsie9WCEucH9iBsTdYXBp8a5/NN/nOEkB+Fqs480J3QhP2IT/XTdJq/kP8HfpYjsFRoAxgRheiYHQP33/ghEmLqYwUqc13YIXEVMZmI4PDUanUvw5DsJ4E4H9dt90MjhVzkGmeKlQtDGoOy6rQTtGw++Uu0y0akrILpuGRpqKfuDPWnJuz64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4zbIslAwkZB6kC+bRqcAXJqJJgvepgGLBwQWklWe2o=;
 b=sOuqYe3VIOkM8OPXfGHGUI+bYfjq0PQZ0BoBGa5Kn4KawnbuN8haT7d8JyBW+wYS1fJWaQOgs3+GRxyPsCsYuWLPY8z44sT1TPtzmyc7gtT1mbrhSIoP/QHFoAq65/PIu1rqhM2tTm4RaheecARHLNOXHySRBCLev0QajaaYufuyEONjGR72B2fnGzE2skE9XjdUcEsYsI36hFhZqJ60XH9NDceIdNoQyGcE4x110ZKJv+3CNouYHdzwNwpgc/fEEOv7zIQLJcsF+3KzELXRUaCrOWw1UDCWL5VP3LWEHAeEPAboYqNkIU3emBKl2GlsINNL/ke8UhnK20Y81z6BgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4zbIslAwkZB6kC+bRqcAXJqJJgvepgGLBwQWklWe2o=;
 b=lnbsvmGdwOednEgATCaI/wxj4YUzGhIfhLFlnyk5NbkL5VpOnHjNT8t0yTdtGhGRiw5s8xqpcQmWq5KR36CpB49nopJoAiLkHnT+QwIRnnUTiqkDkvBx5+W5cfrsb1p/nGI0IIAFeDQXqAkSRYm7Bm21gXTfBmQjUh03dpSwWovOrBtOf04vYWFIEnDsFfoir6JUjKomK9SQ7rjgsaM26bDNt5uzQzBKT2XY3Kh7UOS7500HvVuditVFYwIhRFLscRpD4Ve2fqD7MBgWNZXxb4+U38hzxcOByFTgGQGw6EohDbFS4mZ1Hso35dW8BiYrA2PPESz29+HdrzG8EqNtqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9258.eurprd08.prod.outlook.com (2603:10a6:102:308::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:16 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:16 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 04/19] arm: airoha: introduce EN7523 helpers to get SCU and
 CHIP_SCU regmaps
Date: Sat,  1 Nov 2025 03:44:48 +0300
Message-ID: <20251101004503.2379529-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: c03d20ff-8fc3-49f0-d535-08de18dfecde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LQBft+RwTV5bUI95J7Fms4/hHVU6pGKP5pBIYFLGW7ww84IBfIpyVcZW9Bx2?=
 =?us-ascii?Q?uPQn6q3gXZ+7dqX1jw584/9/Jrm0V6rTmtRE1o+vU4spK6fkh/xCGwv6OL4N?=
 =?us-ascii?Q?h8DvdY3YpUkuW1Vp85H8x9LQHA7D77rwegMGsLvRpDFWaKzwPJU1xjLr7TPR?=
 =?us-ascii?Q?cPPo7IBbKuDl9EtpFNDFZQzv17sfQhcUsjq1zlbL7yvq2EV/lerEHpQwoMDk?=
 =?us-ascii?Q?IQHySJ7RG+KOXD3CqjUtaNurN+nWcHkFlJWcXVgJHBtdgF95+ZFBRoi4mx6U?=
 =?us-ascii?Q?viSFyLeGn2k9t4j9pBnBX0KoPrK880xP3wjDFKUcomDbVFCDfzLyto9ZdwIT?=
 =?us-ascii?Q?dgvNyyz9NZdhgfWX+gM+vt20IF0VTtLY0FAGMCDVEA5UAScpf9UHUzz8RuJp?=
 =?us-ascii?Q?NDNm8yEL1w1Fe/KO5NcNmjzLBlczHI5dr8k3L48N4FtnhYlou4KvS3h0ZxAk?=
 =?us-ascii?Q?pdX6/V9agzrEmeVMZ9UMoBLuhIU7sF0aBUeCAWSCf1B5RQsuFphlicvPXOkH?=
 =?us-ascii?Q?7rgcbZcyO3bEeemaAaAp1y5kM+GCOLpo+GB3hDYkm3uRrfSfMgK4ExVNU/se?=
 =?us-ascii?Q?oSLd7g+63gwzk1cuNv1m35JAxQnX+NY+SYzUM9amV9m1MV2RG22odtthmH4g?=
 =?us-ascii?Q?lZxCSzdx7En8tzCcrIoh5e1miXasnY+hlH0AvGznzuE8WnfHFMTzbxycmuAT?=
 =?us-ascii?Q?LWjuQHO0odAqZKgyWXLeuiN+BPI7R6RHykbRcdP8GZ1P8hLXPK3KSdT/d1T5?=
 =?us-ascii?Q?q9Jkvi+eZP8khhgF9M5HDy0gDIOakjfzECSCtKuI3xJQKo76YLs06AbP7VgN?=
 =?us-ascii?Q?NTFyH1r4+dJLQCIeABnNw/LDbqUXucqS22hfusuX/zlXLNsbSyZg+0OqMwwd?=
 =?us-ascii?Q?LakoYx+HaBDsrzjmhhlOlSoPjNEweL9FEy/rPATppO6f20Tm5JkWBu47RPBK?=
 =?us-ascii?Q?yU06gndYEX1GmB6EpylaP5/n6qf6fQ+EJ414+6p0VdEKvBtncKZWGVCnyAYV?=
 =?us-ascii?Q?+OD0adfLCEWtMm9/wovekotljDFInYASOkl4HdOKM1027dWRozVQcWFw6tgU?=
 =?us-ascii?Q?Q1INZb1D8qbT1Zovxprlp6uZv2MYrJpnHomnKJWPznX7+iGpSv8trPAo2jqw?=
 =?us-ascii?Q?8opBgIZw7rs6k1AAJLqpmN/boDvf6ujq6CxxHj2e2RlagzfRvFGI/GwneHVr?=
 =?us-ascii?Q?13PfVrypjbN1CF5gvwb7Sv1yIc3u37dwWRqXQW7KS1OOroLsWJS0qYmleg6b?=
 =?us-ascii?Q?rRSa+QEZ3V49DXePCpYLbZ8O7/oPKhg9cjYRXsLNIgIpzgNhc55hXJijxS1g?=
 =?us-ascii?Q?7YC+4OlTqLMzAQ1sMSPTLYs6JTEZNMwsOURAQ4tcv3Y86DwS1xvtlMIHFyzf?=
 =?us-ascii?Q?ZwASJVMw3JLCMSw9AZTzS5ROJvanAGom3024bqfqIjXr0PNxVXOnj3h+7gaB?=
 =?us-ascii?Q?w2tSid4M3Vx9624ZKezZuX1+WcRVCXO5mjOSlxVoMRrSa9KwSfFWPp915NhC?=
 =?us-ascii?Q?V0RGP9XSM4p/waz+RnUTCoTv1sINjy7KjzZE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yHi8QeEqn4BrRJosc99OFshCdnmVty8wvMIYHvJsn0FNGS02yjzH4NuJqeST?=
 =?us-ascii?Q?DhOTPz0nVz/5j12AiI1s/etcCifQZlCt/z/FGpydp9QHXxwv4lOny/MNQHNz?=
 =?us-ascii?Q?vmA7IXMj6x35bRdKonPXO4DV7NN4H4aO3ZBEb88bqXJCld9hX1u2q6F/Lprv?=
 =?us-ascii?Q?RXfryswuSyVQ8EMbYOHfnVbQfDhfCO6VmBgpwQLCkLepkv2woplrn2DH8MPd?=
 =?us-ascii?Q?IsgLBuJkZChE7fqesPiPwJzEdb14guoVmsRK9JMeuTqp8/rJRVQ0bhdnJQez?=
 =?us-ascii?Q?bHay3PAM/v8TD8NOnNs+jNQCHt0wBuqY7uy/kJyEIQuR6JVLJq5ELK1czgBN?=
 =?us-ascii?Q?+3rbjx21Ve2Kgmsgj40sjD681Ljg4vQY14cM38oqjBrm6MvtxnJsHxht56ZA?=
 =?us-ascii?Q?OtMXZDTNzZOd+x2Rrpt0LyRuOzeqKW9J1EUBt1DdOBKqrOWS/JuLgBgz3vk9?=
 =?us-ascii?Q?Fucq3Nk85M1XXrgb7+39nESzwJeO3jEwq9v0OanSO6No69rBl+yw3Dze23Vn?=
 =?us-ascii?Q?2dl20wOFpgRiC0Zcw3czGteSU8+Fqvce/tOUIIz6IggzINJ9SpAGaG9R7tdb?=
 =?us-ascii?Q?IWrqWH5K7UOMEg7urRPCJ2+pButLVCwaniE2izkNt9YcWfb9iQGjhCyI4/8e?=
 =?us-ascii?Q?+Kd1dEo1iF81tdETez40qEBVULhrmKFZnoplFVa72Y6a/gVLpsS+/Qhb91mT?=
 =?us-ascii?Q?8nmlZBI4C7wqoRMywcPep59Q6rcGOPrz8za6vNDoCeMVb4lMt1R1oBhbmGL/?=
 =?us-ascii?Q?rFQduaPiRjZBuncbG0riDQrqD7Y/WF9z+TiT9jwjdqhwxv6TvCaVHp3sXtvT?=
 =?us-ascii?Q?x6BgH27KMxhbr7N3tTC4ux5LTRDDjfKFlHd68AK0Qbprd/Vv6o9JzIbYfIYo?=
 =?us-ascii?Q?cdlL7UKowlrGg+/xJ5tRabwEkALAGIbueSTkOnNZh06CyhWkeqOJ57rtQuqg?=
 =?us-ascii?Q?7KX0RcQjvRZE2TqakhT05aPOxR8PYfJtn+ybf9RSO4x5+ewi978fC1yfsPKv?=
 =?us-ascii?Q?dh6KvDWm+K0thIgGtqBCngNWOPsKpyXEBn0Ucz+IRitwJKd0M42GaZmvG9dh?=
 =?us-ascii?Q?KWHgCRsknmPGPSw6MfdwBdcmLgG0dCiX2RiAL3v6d2exXge89N/DDQKN57Za?=
 =?us-ascii?Q?PCl52Nrlvbkk9PUd2NbvPOEqFqt+C8IZTf5ltd2tlkIWQHJcw2w4cwxZC30U?=
 =?us-ascii?Q?f2nRDhc2XE480schefkV9EwqF4mCnTovhpOLJK0qa/7N7UGaxw9HZyZT9RwZ?=
 =?us-ascii?Q?Sz9S1tBuprModaaCyxCJ6xPL+AOt0UN+cgfNDah2ZXPfjBIhZ+iRQlK2b53C?=
 =?us-ascii?Q?/Coth+s24AD01LJQ/yyVvp4YuOa7WwmJwuHDIIgQ/KlXsnDDa8u7lgZPyWJo?=
 =?us-ascii?Q?WqadkmM/cJ5QiM5rMvWJU7MkOIUYejXWESSmZCy1PJujI0MUmrgGIibyG5av?=
 =?us-ascii?Q?amCFX9AMKWqt6TTeJtK6bTW6Tdu/VduSSCjZUsdjV6+rVOy0DmscWq7SLHqc?=
 =?us-ascii?Q?yMZ3tUImKV9XTZODCffORLs7lIF12p6/Y9Uji9Io2dzoeZfCN2RWAaukxdzK?=
 =?us-ascii?Q?XJ4qXxnq0/8+Zj9UxXxzIwwLNELwu2AinaTVOQPl8e7LRMCABmbqL41qlnNH?=
 =?us-ascii?Q?t1Kcrz9+1BPFT24Xqi9i1ek=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c03d20ff-8fc3-49f0-d535-08de18dfecde
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:16.5485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdJrVZzLRzuNu29dipozqRBhPch5zETftPttDoSVRNWKoiWiUOcn8OpgmKeIOXZKkZOrYkhZ4BHemokANxlhkaAaoiBf7/BzJdwePwRI7xM=
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

We need access SCU and CHIP_SCU regmaps in several places (clk-airoha,
reset-airoha, airoha_eth). Unfortunately these regmaps can't be easily
retrieved with a common code, because of different Airoha SoCs uses
a different dts structure.

To make life easy we can write a commonly named SoC specific helpers
for these tasks. This patch implements helpers for Airoha EN7523 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/include/asm/arch-en7523         |  1 +
 arch/arm/mach-airoha/en7523/Makefile     |  1 +
 arch/arm/mach-airoha/en7523/scu-regmap.c | 38 ++++++++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 120000 arch/arm/include/asm/arch-en7523
 create mode 100644 arch/arm/mach-airoha/en7523/scu-regmap.c

diff --git a/arch/arm/include/asm/arch-en7523 b/arch/arm/include/asm/arch-en7523
new file mode 120000
index 00000000000..d2317ed3bc3
--- /dev/null
+++ b/arch/arm/include/asm/arch-en7523
@@ -0,0 +1 @@
+arch-airoha
\ No newline at end of file
diff --git a/arch/arm/mach-airoha/en7523/Makefile b/arch/arm/mach-airoha/en7523/Makefile
index 886ab7e4eb9..51f978aa101 100644
--- a/arch/arm/mach-airoha/en7523/Makefile
+++ b/arch/arm/mach-airoha/en7523/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier:	GPL-2.0
 
 obj-y += init.o
+obj-y += scu-regmap.o
diff --git a/arch/arm/mach-airoha/en7523/scu-regmap.c b/arch/arm/mach-airoha/en7523/scu-regmap.c
new file mode 100644
index 00000000000..1e201cb060c
--- /dev/null
+++ b/arch/arm/mach-airoha/en7523/scu-regmap.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <dm/ofnode.h>
+#include <linux/err.h>
+#include <asm/arch/scu-regmap.h>
+
+static struct regmap *airoha_scu_node_regmap_by_index(unsigned int index)
+{
+	struct regmap *map;
+	ofnode node;
+	int err;
+
+	node = ofnode_by_compatible(ofnode_null(), "airoha,en7523-scu");
+	if (!ofnode_valid(node))
+		return ERR_PTR(-EINVAL);
+
+	/* CHIP_SCU (index=0), SCU (index=1) */
+	err = regmap_init_mem_index(node, &map, index);
+	if (err)
+		return ERR_PTR(err);
+
+	return map;
+}
+
+struct regmap *airoha_get_scu_regmap(void)
+{
+	/* CHIP_SCU (index=0), SCU (index=1) */
+	return airoha_scu_node_regmap_by_index(1);
+}
+
+struct regmap *airoha_get_chip_scu_regmap(void)
+{
+	/* CHIP_SCU (index=0), SCU (index=1) */
+	return airoha_scu_node_regmap_by_index(0);
+}
-- 
2.51.0

