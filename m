Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E95CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E8668489E;
	Mon,  8 Jun 2026 09:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="YyQ0fwQR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E495D83314; Mon,  8 Jun 2026 03:28:34 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95517838BB
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 03:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDNJbUboZCn29iQfBZq41knc9u+LH03X1Gp5sRjKewPEbULyRbU8sNagPj15Vgozg/vnRPnOonAxnUmK8fhVaLkDRkqHlyjNwctuBQ6tbiCVEOg6FbXJFjfNH9qzXUVP7qh84dGS/fhSkWSa0f7C9v/p4JojE8Oo5X9FSFoKa3jrhGooC8t+UEc2DYjCCc7/QlXA80WxNjnDDQ+RpcY+c2SHi3BFm5/N8JY/7JEfa3G1RUqCbUbOeILtKvdK6D4Z5rgFlSz+OqeOrn2r8T0pEhx543Ero3bBCRsavuzq9jBBvb5IJoZp+nu5t5kw7zPwPiyJBMUSNFGrIciX4Zj44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51rltmWSoB6k0po/7VpHlUehTGKroMNm1jGlTpctvAQ=;
 b=ghdZ69dymqlMLBC20z2/cS/LYND+dgSYTXIm0HRQFRKJnkycgw4xtcItudKg1n8mjkYJ2b+aRyCn/r/OCv5lWPKn0bE9DJeYiBCDYAZV5SvBMo5ha65sNSXd5Q1QH4IP5vMlvwR8t0A9HVURgAy5GPmoX4Jnr2meJt1r8CTmyY4OlY/YZqR3mZdmwf/ndX1drzkU/wMki6ipj9onsfARUpKPxnqzE6f2YxrQpGdZpjq/6ve822fnsvwjFVRid9zmItyO+Qtt2fM4Jks/aQlVFdy9fgaeO6in28AR8iU1A6aReUo5o5IOKeUPPKPxKlINQ6PXAyQpiTpadbgWsCRLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51rltmWSoB6k0po/7VpHlUehTGKroMNm1jGlTpctvAQ=;
 b=YyQ0fwQRbzE4zJoaGLSGHOg5vWwDoLNItVk5e11WmN063MwHS7QsL+gQfEpbrDP66zIGDYmybhqvLaK0Wyi84dEuoT0/9uZ/vqmomv1ZPaGpxzlco88LiTijVCdgrwtBwWTMoiJ1RPCRt8IAIJRw2Mwoz66ZnwSUH7L2Y5AmnhkKPFXzVOb+/oc1x+olVkNBXW9haWeb89p4qTS/NaNxtOpYKnvbW4UDG7RoIND7y6igTJWKZN1/1oVUutdsmp9MQVnk7SBdw0WBnxP0Z/LBuWUXHLT++Ccce1jnv+naNsa66dM1hiIJ7wrKiyKKhZj0PoeMDhtddRwINzn/QxgO0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SJ0PR03MB5807.namprd03.prod.outlook.com (2603:10b6:a03:2ad::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 01:28:30 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 01:28:30 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v3 5/7] arm: socfpga: n5x: switch firewall setup to driver
 model
Date: Mon,  8 Jun 2026 09:27:39 +0800
Message-ID: <20260608012741.23760-6-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260608012741.23760-1-chen.huei.lok@altera.com>
References: <20260608012741.23760-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SJ0PR03MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d50bb8a-66b4-46ca-319c-08dec4fd3f14
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /zeHBIkfogzK1HWITUNXP/Ipxz5LbpXLkBh1pIbynYvRJNec/9ntH6TKcjtoWzZ6pwNBM48KQp/g5QtE9xlr1Krqxe12l2QGjJJWSVbFFYALbHjg0ejPqCyj3xJeotb8YFbDpzf1V7AOU06+a+yFmHkMw2seVMoQ5BLoeHmlvYUTA31Yj6GJVeOV4UEyZb1q+A8XWdQ1JfuhgkoXe1mrxufsNLl2lBIRHhKYlYgRplLwJzGvtpqE8czY+/es/9W9GycRyFscZVEAqX92Heb6GYgdPxXGB7Nu+nebIn+yqRdZl1htK/P6MGFvBEphlSvBm5wyPN3DdCZo921ShLDGH/iLDKSMUxYBshQedL4l09n4LRO6mtoxvjylgitYYzO+LlU1R4PdRou8M0pBR0ybN1hJFa/FY0m7rIzCk+E9zWbyUHNGJK7GgDdj3RNM4u3yHMRXjS9oYhofcVbax6C6yh2sRmKBN+pk0+sRHqcIdWfxadYTUcXV6/r0GqQGpDchBDlLe2E59zf667ubF+RSKWEUkg/A6SgKRrWloIlj2K4tPxC2+W/s3g4NGDQVOdGazJ1h8VYWyRhHLGbaSJCsOKQ/H5VWCtkB9040A+UXpAZCXBeFzHcXXh3RR2cEjLlvVdOwCAj/MYZ5eMe2RTkXCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W+tToeDescAOY65FtnxU+vFks0rFnBj9ovesG1JgPkyRk602bpjIwLMCydfa?=
 =?us-ascii?Q?uqsxJArayb9ZNF7DvyXAsZ3Da194H2nanXyGH8s0cwc0XUZEOWpqPtr1nlUk?=
 =?us-ascii?Q?qJSVdZmuo+2P+6ZcyvXnDPGU/CtaCx7SVYPiOJtdgOnPnbZE5KHQqDqhEh8P?=
 =?us-ascii?Q?L9EiT5go5eudlknNt6CTrKtl3FhXwKByOCSx9d7JCR6Rtf2QIIACC4pcDjFx?=
 =?us-ascii?Q?T7QZQgkHQl5yE4ausbA5mL8AAjdqbc4W25hLz5Ad9p3I4H6tnHQ9Q7lo2m9l?=
 =?us-ascii?Q?s8KeCLfOScRmZavEbNBRRXQDifpt+XoXdBcXD+XyJgub+LMGrwr6oy2A2Ewm?=
 =?us-ascii?Q?z7OiLWsRadijuh4aUZi0bdxI2FWrWT1MUWwdsBQDRH5oKSDFRzZr0l8pbK7+?=
 =?us-ascii?Q?wilWREBCpbTUR8ylWGIvEuz3kj4LzsuvW/yy67VBGl4t+/qIjRAfWE2ZgwhZ?=
 =?us-ascii?Q?92GDeXy2S5UyCzM1yxRuJ00Chmd5nbxANS2yCX2QCfzlpzsz8jY2aYjNU5QK?=
 =?us-ascii?Q?u/leIsjcvhAWb7TFGSSjfSrXGP9uG/bwefP3ExMs8z9Vju/Al+HsJq8aOXAZ?=
 =?us-ascii?Q?TDruuGC+c8+znZbUiGt2yAOtictRpiZqWCpoh0yuf1wESZPoXxe4KgjzFI7n?=
 =?us-ascii?Q?B9cpMNojGMXsnDdbBZGS28xFnbyInatZMpUusOrdpWe6WXXgNd9IozaNpSNH?=
 =?us-ascii?Q?KyTHbSavENour9BFYGN1cX//ZuiNRf3mG3Gmjp8BOzHJbvCUOulwVq5fGkZB?=
 =?us-ascii?Q?gjibhZYDVpYtyHhCNy9ur84DKbFKy7mEwF72er1MAbXdhYq0pjZWXa+dj4p4?=
 =?us-ascii?Q?B/L2/7lawozC59R1ilgCtg9gTJIwI/O0X/yryku/soYNuiqfgek/ZEWkhYxY?=
 =?us-ascii?Q?FmywFuFNs1nciQlt25Y5xXXpn6Cwj9UA6tH1n420JfldMX+dwC/h2DvlDd+O?=
 =?us-ascii?Q?xlXt7lVFWTiv1K5mCXxih38HLNN4DECvH45yH/NNW+1XThgUtOw8LwbVsalO?=
 =?us-ascii?Q?vDUJe2G2h+e4kE0LjtpODm3HzFGO8/FaUBMjoeieUrfOimbk3iMWL77dpTcN?=
 =?us-ascii?Q?nSEn5++m7ZGNJjMjnzvSbulAMt6Xk5R60QkHU0X8AhE8r7nT4X0JLBo7I2dN?=
 =?us-ascii?Q?2+lXInud0X+j4VUTpqC7BLDmByS82DILz0MH+ZHozChi9jpX7UlvzIX4LG9s?=
 =?us-ascii?Q?PMHCz5v7x+AwOm6Hg6mFjERhq0erpHMzXnEyLJPDspcuVwln6ezB4Y7EHRKg?=
 =?us-ascii?Q?mbqLxmU0WzWP7Ij0vyMMdZNSsO8Z8ZJFkWtkQ9dtRyOAsHQh7HuZYLCMsRQR?=
 =?us-ascii?Q?RxZstToMNCtuDOUPJH68LIh5C6X1WvhJLe8pYNPa+FeUgcfCdQhwVB9m10H3?=
 =?us-ascii?Q?Af8wM2OQClC1dNtz9D3YQsgFUtfmHFtg5IuzJX0h40VbRbo7OR/Pax/GqNVF?=
 =?us-ascii?Q?YZofDMKWvC58LKN18rzbId/0XmzwKJvopQz2/81eZ2pj3emXPEqWEGJ+amwV?=
 =?us-ascii?Q?bq3HDd7Br2TdWdXTUACf7VtjCp/RPIHzXDapqYMRttesKQk9D0IFS8FDtUbh?=
 =?us-ascii?Q?Hs9X2JyCioUlOC808gamBvaWAe6gU1wVybEp/BJD3CPixFZ+j9XKNMcpDXaT?=
 =?us-ascii?Q?WR8vMVxkZU4SM32Ay0BwLRg/21nsniHSKOesdR1UDzbz+6UWpgJjULe+yypO?=
 =?us-ascii?Q?LMegTJxNdM3jJAcGIUDYWlwWU+Vvv3rmEaJMPmTfS4C8l+wXejVSoDEEAjgY?=
 =?us-ascii?Q?aXFsglXARw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d50bb8a-66b4-46ca-319c-08dec4fd3f14
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 01:28:30.1659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qK72kDUeNw8dx7oPVHXJ0HoVMIoODwOWq7LeocvDndKSIHxuvHz5BU+7ksuuQiW5ZMUZyTyjFAoE0rIAzi4FhRH2n79tmCcJlqiGbeXoU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5807
X-Mailman-Approved-At: Mon, 08 Jun 2026 09:45:15 +0200
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

Move the system manager and L3 interconnect firewall configuration from
a dedicated firewall_setup() function to the driver model, using
uclass_get_device_by_name(). This removes hardcoded firewall setup in
SPL and relies on the driver model, making the code more maintainable
and aligned with upstream practices.

With spl_n5x.c migrated, no in-tree SoC64 SPL file calls
firewall_setup() directly any longer. Remove the function and its
private helpers from firewall.c, drop firewall.c from the Makefile,
remove the now-unused declaration from firewall.h, and drop the stale
firewall.h include from spl_n5x.c.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---

Changes in v3:
- Extend to fully remove the now-dead firewall_setup() implementation:
  delete arch/arm/mach-socfpga/firewall.c, remove firewall.o from
  Makefile, remove the void firewall_setup(void) declaration from
  firewall.h, drop the now-unused struct socfpga_firwall_l4_per,
  socfpga_firwall_l4_sys, FIREWALL_L4_DISABLE_ALL, and
  FIREWALL_BRIDGE_DISABLE_ALL from firewall.h, remove stale
  #include <asm/arch/firewall.h> from spl_n5x.c

 arch/arm/mach-socfpga/Makefile                |   1 -
 arch/arm/mach-socfpga/firewall.c              | 107 ------------------
 arch/arm/mach-socfpga/include/mach/firewall.h |  69 -----------
 arch/arm/mach-socfpga/spl_n5x.c               |  13 ++-
 4 files changed, 11 insertions(+), 179 deletions(-)
 delete mode 100644 arch/arm/mach-socfpga/firewall.c

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 962dce67c64..5e57d23657c 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -114,7 +114,6 @@ obj-y	+= wrap_pinmux_config.o
 obj-y	+= wrap_sdram_config.o
 endif
 ifdef CONFIG_ARCH_SOCFPGA_SOC64
-obj-y	+= firewall.o
 obj-y	+= spl_soc64.o
 endif
 ifdef CONFIG_ARCH_SOCFPGA_ARRIA10
diff --git a/arch/arm/mach-socfpga/firewall.c b/arch/arm/mach-socfpga/firewall.c
deleted file mode 100644
index 4dec47b8e96..00000000000
--- a/arch/arm/mach-socfpga/firewall.c
+++ /dev/null
@@ -1,107 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2016-2019 Intel Corporation <www.intel.com>
- *
- */
-
-#include <mach/base_addr_soc64.h>
-#include <asm/io.h>
-#include <asm/arch/firewall.h>
-#include <asm/arch/system_manager.h>
-
-static void firewall_l4_per_disable(void)
-{
-	const struct socfpga_firwall_l4_per *firwall_l4_per_base =
-		(struct socfpga_firwall_l4_per *)SOCFPGA_FIREWALL_L4_PER;
-	u32 i;
-	const u32 *addr[] = {
-			&firwall_l4_per_base->nand,
-			&firwall_l4_per_base->nand_data,
-			&firwall_l4_per_base->usb0,
-			&firwall_l4_per_base->usb1,
-			&firwall_l4_per_base->spim0,
-			&firwall_l4_per_base->spim1,
-			&firwall_l4_per_base->emac0,
-			&firwall_l4_per_base->emac1,
-			&firwall_l4_per_base->emac2,
-			&firwall_l4_per_base->sdmmc,
-			&firwall_l4_per_base->gpio0,
-			&firwall_l4_per_base->gpio1,
-			&firwall_l4_per_base->i2c0,
-			&firwall_l4_per_base->i2c1,
-			&firwall_l4_per_base->i2c2,
-			&firwall_l4_per_base->i2c3,
-			&firwall_l4_per_base->i2c4,
-			&firwall_l4_per_base->timer0,
-			&firwall_l4_per_base->timer1,
-			&firwall_l4_per_base->uart0,
-			&firwall_l4_per_base->uart1
-			};
-
-	/*
-	 * The following lines of code will enable non-secure access
-	 * to nand, usb, spi, emac, sdmmc, gpio, i2c, timers and uart. This
-	 * is needed as most OS run in non-secure mode. Thus we need to
-	 * enable non-secure access to these peripherals in order for the
-	 * OS to use these peripherals.
-	 */
-	for (i = 0; i < ARRAY_SIZE(addr); i++)
-		writel(FIREWALL_L4_DISABLE_ALL, addr[i]);
-}
-
-static void firewall_l4_sys_disable(void)
-{
-	const struct socfpga_firwall_l4_sys *firwall_l4_sys_base =
-		(struct socfpga_firwall_l4_sys *)SOCFPGA_FIREWALL_L4_SYS;
-	u32 i;
-	const u32 *addr[] = {
-			&firwall_l4_sys_base->dma_ecc,
-			&firwall_l4_sys_base->emac0rx_ecc,
-			&firwall_l4_sys_base->emac0tx_ecc,
-			&firwall_l4_sys_base->emac1rx_ecc,
-			&firwall_l4_sys_base->emac1tx_ecc,
-			&firwall_l4_sys_base->emac2rx_ecc,
-			&firwall_l4_sys_base->emac2tx_ecc,
-			&firwall_l4_sys_base->nand_ecc,
-			&firwall_l4_sys_base->nand_read_ecc,
-			&firwall_l4_sys_base->nand_write_ecc,
-			&firwall_l4_sys_base->ocram_ecc,
-			&firwall_l4_sys_base->sdmmc_ecc,
-			&firwall_l4_sys_base->usb0_ecc,
-			&firwall_l4_sys_base->usb1_ecc,
-			&firwall_l4_sys_base->clock_manager,
-			&firwall_l4_sys_base->io_manager,
-			&firwall_l4_sys_base->reset_manager,
-			&firwall_l4_sys_base->system_manager,
-			&firwall_l4_sys_base->watchdog0,
-			&firwall_l4_sys_base->watchdog1,
-			&firwall_l4_sys_base->watchdog2,
-			&firwall_l4_sys_base->watchdog3
-		};
-
-	for (i = 0; i < ARRAY_SIZE(addr); i++)
-		writel(FIREWALL_L4_DISABLE_ALL, addr[i]);
-}
-
-static void firewall_bridge_disable(void)
-{
-	/* disable lwsocf2fpga and soc2fpga bridge security */
-	writel(FIREWALL_BRIDGE_DISABLE_ALL, SOCFPGA_FIREWALL_SOC2FPGA);
-	writel(FIREWALL_BRIDGE_DISABLE_ALL, SOCFPGA_FIREWALL_LWSOC2FPGA);
-}
-
-void firewall_setup(void)
-{
-	firewall_l4_per_disable();
-	firewall_l4_sys_disable();
-	firewall_bridge_disable();
-
-	/* disable SMMU security */
-	writel(FIREWALL_L4_DISABLE_ALL, SOCFPGA_FIREWALL_TCU);
-
-	/* enable non-secure interface to DMA330 DMA and peripherals */
-	writel(SYSMGR_DMA_IRQ_NS | SYSMGR_DMA_MGR_NS,
-	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_DMA);
-	writel(SYSMGR_DMAPERIPH_ALL_NS,
-	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_DMA_PERIPH);
-}
diff --git a/arch/arm/mach-socfpga/include/mach/firewall.h b/arch/arm/mach-socfpga/include/mach/firewall.h
index b47b577ae75..8f3b7d90ad1 100644
--- a/arch/arm/mach-socfpga/include/mach/firewall.h
+++ b/arch/arm/mach-socfpga/include/mach/firewall.h
@@ -10,73 +10,6 @@
 
 #include <linux/bitops.h>
 
-struct socfpga_firwall_l4_per {
-	u32	nand;		/* 0x00 */
-	u32	nand_data;
-	u32	_pad_0x8;
-	u32	usb0;
-	u32	usb1;		/* 0x10 */
-	u32	_pad_0x14;
-	u32	_pad_0x18;
-	u32	spim0;
-	u32	spim1;		/* 0x20 */
-	u32	spis0;
-	u32	spis1;
-	u32	emac0;
-	u32	emac1;		/* 0x30 */
-	u32	emac2;
-	u32	_pad_0x38;
-	u32	_pad_0x3c;
-	u32	sdmmc;		/* 0x40 */
-	u32	gpio0;
-	u32	gpio1;
-	u32	_pad_0x4c;
-	u32	i2c0;		/* 0x50 */
-	u32	i2c1;
-	u32	i2c2;
-	u32	i2c3;
-	u32	i2c4;		/* 0x60 */
-	u32	timer0;
-	u32	timer1;
-	u32	uart0;
-	u32	uart1;		/* 0x70 */
-};
-
-struct socfpga_firwall_l4_sys {
-	u32	_pad_0x00;		/* 0x00 */
-	u32	_pad_0x04;
-	u32	dma_ecc;
-	u32	emac0rx_ecc;
-	u32	emac0tx_ecc;		/* 0x10 */
-	u32	emac1rx_ecc;
-	u32	emac1tx_ecc;
-	u32	emac2rx_ecc;
-	u32	emac2tx_ecc;		/* 0x20 */
-	u32	_pad_0x24;
-	u32	_pad_0x28;
-	u32	nand_ecc;
-	u32	nand_read_ecc;		/* 0x30 */
-	u32	nand_write_ecc;
-	u32	ocram_ecc;
-	u32	_pad_0x3c;
-	u32	sdmmc_ecc;		/* 0x40 */
-	u32	usb0_ecc;
-	u32	usb1_ecc;
-	u32	clock_manager;
-	u32	_pad_0x50;		/* 0x50 */
-	u32	io_manager;
-	u32	reset_manager;
-	u32	system_manager;
-	u32	osc0_timer;		/* 0x60 */
-	u32	osc1_timer;
-	u32	watchdog0;
-	u32	watchdog1;
-	u32	watchdog2;		/* 0x70 */
-	u32	watchdog3;
-};
-
-#define FIREWALL_L4_DISABLE_ALL		(BIT(0) | BIT(24) | BIT(16))
-#define FIREWALL_BRIDGE_DISABLE_ALL	(~0)
 
 /* Cache coherency unit (CCU) registers */
 #define CCU_CPU0_MPRT_ADBASE_DDRREG		0x4400
@@ -149,6 +82,4 @@ struct socfpga_firwall_l4_sys {
 	writel(data, SOCFPGA_FW_MPU_DDR_SCR_ADDRESS + (reg))
 #endif
 
-void firewall_setup(void);
-
 #endif /* _FIREWALL_H_ */
diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index a49be837921..0a8dd6d0fee 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -5,7 +5,6 @@
  */
 
 #include <asm/arch/clock_manager.h>
-#include <asm/arch/firewall.h>
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
@@ -69,7 +68,17 @@ void board_init_f(ulong dummy)
 	print_reset_info();
 	cm_print_clock_quick_summary();
 
-	firewall_setup();
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-system-mgr-firewall", &dev);
+	if (ret) {
+		printf("System manager firewall configuration failed: %d\n", ret);
+		hang();
+	}
+
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-l3interconnect-firewall", &dev);
+	if (ret) {
+		printf("L3 interconnect firewall configuration failed: %d\n", ret);
+		hang();
+	}
 
 	ret = uclass_get_device(UCLASS_CACHE, 0, &dev);
 	if (ret) {
-- 
2.43.7

