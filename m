Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87235CD4857
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 06:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 928CF83C51;
	Tue, 12 May 2026 08:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gYKs3739";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 509E8801A9; Tue, 12 May 2026 08:50:26 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BB2183C51
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 08:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCbwc+SF+njm6qkHw+e1Z5GrUjXhqkdrxiRiUVleUdoVgu/heZknTvm3BJ1khUhwG6bQhgVOb9JE9U79TeKb8bnHNLNnOD47yl232iXdzenK7SsBei/c6xNB2X2EJx74iYzbhLDbtj/AnG2rL/HzazCc2Wizygo/QONDLeRvqn6+1Gd84o3DQzfjwyeR91JRnVRJ1zqC2T0bRBiYTH+VzmsDIk6TGzIbKeLQhPNXZJhrBEpopi93dKuw0JN321jRL/VPTLZquxR6LEy5zWvaWWaXrtQoZ5HlcIEbfNKMBemk+dsZW+p6o0sjYQPZ7mYV7C/+wcjJaP+kmVnvAcz0DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nt2RbyYdUO64n9uLzE2TM7bgxrqrAfA3xVZ+T/RczZs=;
 b=ejRdISzVpnzlV90u9be3vBsbpBTBAz7P13znUOA3wAaewxU4omeqtXmE//Cn8bzAf+4ph14SUqAJQcQ6zT2rAF5tKXLYR+Ds4TOlvhqx70fzZzG9OmzyipYIKxuuELz8ZtYAd+QzOKR5vJMsDRSK/4mtUGHe2wiM1mb/VMbqYumKBCJJlfwKLS82RgD2lSHh1Xgu92pFSNIKlYyZViJNEmMlDLK99CHu897Bk6Sd1x6lyYag+0F1R36JxPpNSsiExhT80SPK8qbjOsACwEGCr96SxLJ8y8P7yJijXcz9ebR58pGuJ511v4Dw23zCpD03qgBtoEGKwyzJIBjQGPCGDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt2RbyYdUO64n9uLzE2TM7bgxrqrAfA3xVZ+T/RczZs=;
 b=gYKs3739DtQPTh+H6OCLPYLJUAyihU11BlgYwpz+IY/7R/zDUpbEM5lzdml5C3177gCoKaR3VHHaA/1Vni7vQpTb5VRBnuLz9UWlVRNyLRCupzoh0PXXmHQMyw8A2uDeT8MZrey/3zxJ4Bfe6aRuuonhUL1P0GypTA/qhZkrzQ6oHps9LJ+8uYHCoEGbv+k109JyxMU/tGTBcuIpl1g8tL76cSnjzDwqLTPAu6X07kegrVzaxLaZdr0RUd3li4E8eUcQoNaonsA8CMOo/V1UHe0OesEGXJswjcTf9xPLWX3Y64qPk0ct9eKXARu0G4sIfGjaXrDiMmJEuHRugNAzSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by CH4PR03MB7697.namprd03.prod.outlook.com (2603:10b6:610:237::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 06:50:21 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 06:50:21 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v3 2/3] ddr: altera: gen5: Add DRAM size checking
Date: Tue, 12 May 2026 14:49:56 +0800
Message-ID: <20260512064957.32497-3-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260512064957.32497-1-alif.zakuan.yuslaimi@altera.com>
References: <20260512064957.32497-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|CH4PR03MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b20f5a1-7551-4064-1cd7-08deaff2bc24
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|55112099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: jnGZU4swnJzrtHTVPTD0IliWkcXI1N27WfgbGhhPldYiLDQCIMCFVtfAI4T+xauDRcmR/JUpgMvgU1jrz/XYwuHYD0msTMdVAZp8zxm7tmWjqNySp8VtaNJkWoiOG02D2HK1/e3nRe5FmI1n6hLBA8sPvHSr7/H8KvYV88WTy3Yfxo1qPX9RDSqMXU1W6VjRD3pX9uyCM5tEGkiE2G5dzhf7qhGtTC7RG/5cEO3DII69DSFh3XcSbU7H6iNNqIJYhpnhmcP14w8eCUD8Hr570EJtF8OQvw1kpiGaCfYLXNYaNAJivgX9p8sWJ9j5X/Dquqr/QYhKvzmCDGgMd1oTXjwNYTE5m1FwBaGFzQbIicyU539OfVVDdN29Ch4/PO3gQF7s85DGC8g4NrTyxqNzv8gtDY8Hf73XCZaxaWn2l3AKbcJz0ULZhdnQpKtQbO677QMA016aR+TXC080xFHFyuw5cui3dMzCYfO+6BvTLO7w/sbdDgdMls7Lut9i+M3MC+IdWgPIMeVvW9P7OcdnD9O/gQ38f6iL1HKYRNu9nbAoz53kfMCuvCT4Os3nXe40vFNUidFd2jGCBM8VfR6A5tLCCm0ZtS/dkxtMT44My7HsMkQtpnSGrTeZq67qe8zzVsda1ZScKoCEqKHuu3AFEK/+DO44vrK6OfNXG/hbbQo1yxzkmbKyREcOrrjdZsMT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(55112099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1wnjVF148mhKFWEqTIAp8jpBI7wSziRco5tkAWWKlnRNHpJ9QwUlWXEFqUKs?=
 =?us-ascii?Q?9zPJwUW1CWxXAG5PiU774uT0lVktljx1Szl/ryz86EZ1cbQrtoxFT7YG/L38?=
 =?us-ascii?Q?6klmrMNZH6+YQiWeT9G1k6a9g4cWEkzsjSeSKn4OeJ0yiH7DZ/NOmavf9CQC?=
 =?us-ascii?Q?meTgZsJB88OXxeuxZtIGCV/MBonytdiBh1CnkYFhm1IZh9Ud6yIDjkbvI4i4?=
 =?us-ascii?Q?qcYXaUoqxTGrfDOI+B2ijj+3eO5PWOCHG8eBLEKksQHRuuT6+OebvUAu4oYI?=
 =?us-ascii?Q?PNoTQeiDIL/uw27aS0i34XdgIZHDdod/CDuXrLwmQwoFQtJvZbQC8tgcOXs1?=
 =?us-ascii?Q?/jUlWleMqNZN2wBvWzQWnarWEDrtKBLZaQymtCNFWuQw56EfKLV6cXLvznNQ?=
 =?us-ascii?Q?lYA0sxv6v9biQBa8RAW2RpIZk1LQg5OkVOX/YZJzOAUcFRkqxEM7JERpv66c?=
 =?us-ascii?Q?v4yzNCk5ap9A/RQwrSLWoyiUL0GyZeSf0Zbalq/vmZlzVb8KIhQf1AtpsW87?=
 =?us-ascii?Q?awaB5GrWWuXLWNlW1xhMpZqo3Zs9tpK046PEFFqp7XoFlPqSEVlU/YA0usO9?=
 =?us-ascii?Q?U+E1Rqig5AoIZps+xg6q4Ba1S7nWXwBp9u4teDd0HOUZvpx/jLtfZ2laup8Y?=
 =?us-ascii?Q?KDMNkdtTc2xPhuICX41I1QAlHHk3vCwgjWVWcO/KjYp3CavXKMenxJPZ6ixL?=
 =?us-ascii?Q?MZAf/VJwItaC2FtaBuWT1roOH5hDdUBm7aPlVnYPPTLFbLhBTPDsfCZ6uoGi?=
 =?us-ascii?Q?IaQMu5TcouW27fUow9Ry4wKzNDLDcbD9s9mkHgg1xjjjxv1GvueVQq0NMcOK?=
 =?us-ascii?Q?V2i2hz2X7x+egc8mY6x57IeszPjfiaKlbwZ//YkcTeqRFGLJ9+p3niQ/z9PU?=
 =?us-ascii?Q?TEbQcorc5bu/nPR9MJnzNglxzyCQVMreP9r1rNS7Sj6iLa8FyR2pZsYXFcBx?=
 =?us-ascii?Q?NAVipb75jRHRzrKrPlcbkr+wDhe15yvZbrTTSKPOWtMa3Jg3otGSi/xNjrEK?=
 =?us-ascii?Q?gKZKoL8lb86I+GU76fIgHYoQv4aBSDxyxzBH2bxF4eZiI1+Ym62Jr23/bnaC?=
 =?us-ascii?Q?G7x2xxT7gm3pdB7nIWDOyeFs5OBdwfTHJCuPdawp+g6O7HWLYCMgne6s6tR8?=
 =?us-ascii?Q?5C/z0aTI8ETWQAgzq0SwBD+SklFIsmsxP5A0LQmh0G4ZktLHPJxm6M7LYsIB?=
 =?us-ascii?Q?DovNdjjsGgKtCWafKMzM4OtVa2CqVaa6msMmbFUyQP3KzuMhqeI1kxc6huCI?=
 =?us-ascii?Q?im3WppxqWUtG6wiVCXwuymhA7fwPnZ3n9OrF4SPA0D/SMZt6wLkxZQCgWwZh?=
 =?us-ascii?Q?gTvtKRIdUWsN/4thy9IMX5Zu2f3UrPvNfO6hEKpTiOOADygKfSQlWlObiRo6?=
 =?us-ascii?Q?+kFKmgF3zAb7qSgCG1XrRYBBVz13Z5q3cYeXb4OCnrKpUzjyFPmjSd3oEalW?=
 =?us-ascii?Q?nqbPjwveNioJ7vFqbHk+bBOC7dx+wInZqt+XuRa3BPUeJnpUw6ie2bsHHp0e?=
 =?us-ascii?Q?li1JRwIxvB0ucZFKxe+ljq3be5xvZEnJpUMqonKxCLy16t2uQXwXwOd4okTi?=
 =?us-ascii?Q?NTa/RExj84kgLik5PUGthjLcYyzVy3rt9jE2gQssRuzPYDiaSqqZov1/b+o9?=
 =?us-ascii?Q?fR46CbAX3WFWZHM84KkezCQtUeQDn84ya1T58dggi4HjpkbX+bGhC6IelXS8?=
 =?us-ascii?Q?MS4naYSofedauCEwvGbl1IkzQ6tpok4SHnlDBdL+DOOc8zhJPod7TxvAeQud?=
 =?us-ascii?Q?kb4OfwTKOFT/+0sIvs33aTmPyNAjz+I=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b20f5a1-7551-4064-1cd7-08deaff2bc24
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 06:50:21.0276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejGjBhZa8DXQtB87ngOOteWtkeyBOswpT/G4Z4szZDZmCDVkTYkZHgykNkwRZAbex5eVJTnk4hNAYSqvxeRArJgaflvYFzIYBINxNO1CCEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7697
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Add DRAM size checking compare between size from device tree and actual
hardware.

Trigger hang if DRAM size from device tree is greater than actual hardware.
Display warning message if DRAM size mismatch between device tree and
actual hardware.

get_ram_size() uses size from device tree. So, it has consistency with
other device families.

New Kconfig is introduced to enable this implementation only on the default
CycloneV board as this will increase the SPL size which will exceed some
Gen5 devices' SPL size limit.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

Changes in v3:
- Move the bdata declaration and gd->bd = &bdata assignment from spl_gen5.c
  in patch 3 into this patch, making this patch self-contained

Changes in v2:
- DRAM size checking is set as optional via Kconfig and defaulted on only
  for the reference Arria10/CycloneV boards to avoid SPL overflows on
  size-limited Gen5 defconfigs.

 arch/arm/mach-socfpga/Kconfig    |  9 +++++++++
 arch/arm/mach-socfpga/spl_gen5.c | 11 +++++++++++
 drivers/ddr/altera/sdram_gen5.c  | 27 +++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index fb98b647442..b814e034ecd 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -6,6 +6,12 @@ config ERR_PTR_OFFSET
 config NR_DRAM_BANKS
 	default 1
 
+config SOCFPGA_DRAM_SIZE_CHECK
+	bool "Enable DRAM size checking for safety"
+	help
+	 Compares device tree DRAM size with actual hardware. Hangs on
+	 oversized claim.
+
 config SOCFPGA_SECURE_VAB_AUTH
 	bool "Enable boot image authentication with Secure Device Manager"
 	depends on ARCH_SOCFPGA_AGILEX || ARCH_SOCFPGA_N5X || \
@@ -111,6 +117,9 @@ config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
 config ARCH_SOCFPGA_CYCLONE5
 	bool
 	select ARCH_SOCFPGA_GEN5
+	select SOCFPGA_DRAM_SIZE_CHECK if !TARGET_SOCFPGA_TERASIC_SOCKIT \
+	  && !TARGET_SOCFPGA_EBV_SOCRATES && \
+	  !TARGET_SOCFPGA_SOFTING_VINING_FPGA
 
 config ARCH_SOCFPGA_GEN5
 	bool
diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
index 08b756db2ca..a9825173189 100644
--- a/arch/arm/mach-socfpga/spl_gen5.c
+++ b/arch/arm/mach-socfpga/spl_gen5.c
@@ -6,6 +6,7 @@
 #include <hang.h>
 #include <init.h>
 #include <log.h>
+#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/utils.h>
 #include <image.h>
@@ -24,6 +25,12 @@
 #include <dm/uclass.h>
 #include <linux/bitops.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
+#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+static struct bd_info bdata __attribute__ ((section(".data")));
+#endif
+
 u32 spl_boot_device(void)
 {
 	const u32 bsel = readl(socfpga_get_sysmgr_addr() +
@@ -143,6 +150,10 @@ void board_init_f(ulong dummy)
 	/* enable console uart printing */
 	preloader_console_init();
 
+#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+	gd->bd = &bdata;
+#endif
+
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 	if (ret) {
 		debug("DRAM init failed: %d\n", ret);
diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
index 3c79bb11802..1c3c70ea8ae 100644
--- a/drivers/ddr/altera/sdram_gen5.c
+++ b/drivers/ddr/altera/sdram_gen5.c
@@ -5,6 +5,7 @@
 #include <dm.h>
 #include <errno.h>
 #include <div64.h>
+#include <hang.h>
 #include <init.h>
 #include <log.h>
 #include <ram.h>
@@ -15,6 +16,7 @@
 #include <asm/arch/sdram.h>
 #include <asm/arch/system_manager.h>
 #include <asm/bitops.h>
+#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 
@@ -22,6 +24,8 @@
 
 #ifdef CONFIG_XPL_BUILD
 
+DECLARE_GLOBAL_DATA_PTR;
+
 struct altera_gen5_sdram_priv {
 	struct ram_info info;
 };
@@ -604,8 +608,31 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
 	sdram_size = sdram_calculate_size(sdr_ctrl);
 	debug("SDRAM: %ld MiB\n", sdram_size >> 20);
 
+#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+	/* setup the dram info within bd */
+	dram_init_banksize();
+
+	if (sdram_size != gd->bd->bi_dram[0].size) {
+		printf("DDR: Warning: DRAM size from device tree (%lu MiB)\n",
+		       (ulong)(gd->bd->bi_dram[0].size >> 20));
+		printf(" mismatch with hardware (%lu MiB).\n",
+		       (ulong)(sdram_size >> 20));
+	}
+
+	if (gd->bd->bi_dram[0].size > sdram_size) {
+		printf("DDR: Error: DRAM size from device tree is greater\n");
+		printf(" than hardware size.\n");
+		hang();
+	}
+#endif
+
 	/* Sanity check ensure correct SDRAM size specified */
+#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+	if (get_ram_size(0, gd->bd->bi_dram[0].size) !=
+	    gd->bd->bi_dram[0].size) {
+#else
 	if (get_ram_size(0, sdram_size) != sdram_size) {
+#endif
 		puts("SDRAM size check failed!\n");
 		goto failed;
 	}
-- 
2.43.7

