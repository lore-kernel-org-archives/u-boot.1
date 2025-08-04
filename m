Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77633C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C878883DDF;
	Mon,  4 Aug 2025 03:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ciN0TAea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EC4B83DBD; Mon,  4 Aug 2025 03:25:21 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5D2383BB5
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tI2KwMdtn8ffsMqD0WOShdYNzOoYudic6JsHr/szH+oghSJ27REl4dyka+6s4yUvGAa8vuN41o4pd6j7B6CTW10ldi9g4jCI1PMPxSsXDn2i9P+jzIUEEIfUP5OAeS4eh+IRgjI3EUXUoxVG+l8KW4+ulUs6gfbgWYfqeVP/2Ga3WzfWFf+O1ez0c3p4vmP8exsa+4EbZwV6P+sYvljX1u07iutAlGCq3z6IvlWnptJ3pUdTC68zAzCqIqqfMyfzhf1Q95hC7dUnyywlQkRa8M73PA79ABarSY+12yNWebdPDoneg/BEwt6/wm+NTruuRqLkhredcCCN+E6trVMwkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XX5rYuSQqhUu6XPeLDIySPgFHl7W3BuSKnkrzbXrH8=;
 b=jVOLaG/G+Z+kbD+BHxDYLnoKaxIhSlBm1/tdH044PE81ywF0YkKOZtmKy3gKBjT5j/dBqx7Db9lkVfbN/j9CaBsy/wRyFHR9ZI+DL5iUpOJkP3A49AsHe1jJ8ksepNL3u+sjoPGPqDTw7YeBFZjhqtNiBEJGUi00bk/upJQtTQ8ePrp2VpnEh7I6JjMf071l/ywuU4iwBYRpkPoB7srtSDE9jRIrxkzK5mU8aS+/QWI0jwpsxymFPUhkzNOARlWobHMfVwlnkCUevM6hHDB8TISbj4WchUGQv2uPLaJ1FgATOu/lZNyE3IcpRFuBjR1nuJP+40PJ2sD586dGtg2jrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XX5rYuSQqhUu6XPeLDIySPgFHl7W3BuSKnkrzbXrH8=;
 b=ciN0TAeaW/1pMltNEpP8zGhm33qKfpY/QOWnqtNsy6r7pBp1Jmv/IjKzLmeaJT5CK6Ia+bVrU9GmMEZPVUloR+wzYYARhESmPfAPbA6aPjtg0qBYpDQ1AwZCWkXt0aeL4GYgVFHGYfkUsph/B8qpA0XLtjwdGZYeLPekr6BuploA8Ree8oFlI3Kvyy8TQ4hM+EqXF9qVBFDaqUtNuAIP0yoJ36zTu3a2S11KuVoAiAsnuxt/+gtkAX9PY0vbSMzlKPWMRpTbnJyqaAMqHNNG7+qO8DIwqApY17uPGw1RwfeLM8bvVuwbkLu8NO/qvU6bQxKzvmdcw9Eg+lWznjlKzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MW4PR03MB6346.namprd03.prod.outlook.com (2603:10b6:303:11d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 01:25:15 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:14 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 02/34] configs: agilex: Combine defconfig for all boot
 flashes
Date: Sun,  3 Aug 2025 18:24:29 -0700
Message-Id: <20250804012501.21811-3-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MW4PR03MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1337d5-3cbf-4cd5-1ba3-08ddd2f5c2e0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mwSlAeNnkYbyOohC/OZRoGPajwOhMXgsNifLZ16wJNJfIhvFR34xemZn+seP?=
 =?us-ascii?Q?Hoik7DB6zxHCGopCIbS7gxipLrCRskJGYd0XBnxnO5lmOx6OaaLQzfv4fMbB?=
 =?us-ascii?Q?rZxfYLNacmMOAp/IrkJkQGjFRsgmnDgj0JSltU6CBxazFYXoF9IqxdMXwxpd?=
 =?us-ascii?Q?KJQ4IcQLmzYNreyYkTmPDktfEUQ/CYLybaRlIduBa9vyFfk06gIZKQ9+HOHq?=
 =?us-ascii?Q?GrSQagAoi8MV7qHPPcRTHRGHXSDv6s1x2M7TxPgZy+evJOaoT0VSe4rFLIhl?=
 =?us-ascii?Q?hh3qgxVp6ROVYVkhHGDBXJSTZpVmSGmDwt9Wg+zRq7OfF7i6yhbpJAQhLlMN?=
 =?us-ascii?Q?ysy2HIdaoj3b+z7dnPtuoCYvJqrWzjJmcGLZg6Opg/lK/bxzX0We4+w50k1E?=
 =?us-ascii?Q?nr8IWNcpRsXDwvz/xwHD7EXcSlky84ugWQ4R8aMSz5t5OeZexZvE4QSm7L9Z?=
 =?us-ascii?Q?IyayOgS8NQNBnxEzbESFJ3j16qCtYTm5yY7uZ4m3xF9fErcGOZz+Hw5kEK7N?=
 =?us-ascii?Q?kJxTiEDdU1xq3xz6thCcNVmbt4UkcorypXeuVf/RhQk+yPSyfIzBHDMZJQCg?=
 =?us-ascii?Q?XTy1W/nsWm6KPzJ8ggivfzm50e0VNsCaIX3ZampOYaO9f3WJjk7sQ5Hus7dk?=
 =?us-ascii?Q?mJas8BLt3EIX22nv5tUGpdVynWV9tshmRzURiJdm4tDfiqPLItHEBLlfeAkf?=
 =?us-ascii?Q?l/ZcQp9oK+Bv/BXb6Jwk9a+yTlFPHgYXbkMgcxMQ7tZf7fYjaCHaPUb8N86z?=
 =?us-ascii?Q?fqh3H0DTjUhlHrvM00lQ1INigQEAY/vNI4aEib8u6RQiOXIcZoLb1Wfa16J3?=
 =?us-ascii?Q?oqcKj9qegb29kKyhbXG+9VN+lVN34IuZyUTOZEu9pt7YajO/UsOcqHZeph+q?=
 =?us-ascii?Q?e2Sdm6VIckmVBVxT15kES+CSvxl9TJqkBVprVXdUzLmOeGRbOCT4X90U96z6?=
 =?us-ascii?Q?6BqZAh/7uq4QfoTYT6P5d3ja1itwu7WlfxI6uOWv7Z/hSxvTm2EZXLDw58IQ?=
 =?us-ascii?Q?BE5Zzdz5E3iVFe0GhjDKcr9bEcFOzkyLrn/A3MKFfX/p7vWpwdTzbRwUwKLB?=
 =?us-ascii?Q?RtA6f+ky5PhZ7/2XPhHYUy5dMnnesUuW89wdcUFgr5quP0Xi6KYmdam0ul/H?=
 =?us-ascii?Q?IY/V3jRrwvvIbhDIZNq2AsOgOFC0Y7kbLfoETlhzEFUn91a2btbxw64bMwtP?=
 =?us-ascii?Q?LM8in2Zmud7L0N5ACdHSi2lvi26e1679tF52iDw+tn2xMsHE3W3bQTbWEVKL?=
 =?us-ascii?Q?Vdx/IUY7QcsQOCtePD3LWwNevOjdTUaXANWBSaExxwnkzmiIm6wGklSx/zIn?=
 =?us-ascii?Q?Uu+osL/ANPj+5Cxr3rfqF7HrAuLLh7Zzk5SamJm2zZsuTS9+/MEn4GUrRnGU?=
 =?us-ascii?Q?ZhDp6I8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SW6fVha4YZxGQLdQv/c+q7Dj4y+0skMYcq951CeCvlxN1BQIPKThrWgU9nO6?=
 =?us-ascii?Q?q+eKRRQjMQhCyLDcDu7qL6ccpV4vgRBICk4hBHvOSxm5t/VNbnkGuKnRNRZ9?=
 =?us-ascii?Q?YkLiaromSNVpGrLk+C4N4thCXQ0RcOx9QSLcjEYlZ5dz6+n+XD729zUulIw1?=
 =?us-ascii?Q?jzmJ20QkUNk9cEvb/aYqHb5OVG+F9gua5s2aCYa5QAxAgCR/zzvLC+hcF1Gp?=
 =?us-ascii?Q?gHB/Devdd6Yjl3jkc5w0jareavi9dTPxNeMuPI/TLiKMJQzbcyXGbxeBqiiO?=
 =?us-ascii?Q?GLC6EfewdTQH12owPIxMkwzTiuLgeO4FDcVBDeQfHkndN9edlyt/SO8/AoEv?=
 =?us-ascii?Q?0IePFLy9mvh3SwH/hjIrUTtOqIdvvODYwsve6zZoaXe+6ds0AYEcoxsuCFKA?=
 =?us-ascii?Q?Mkgi4/FaQeMZLC3nPuAnkMJUQ28eSQ9szQ8LYblNGP7hr/czM4jCs1NE5Ypb?=
 =?us-ascii?Q?XaGpv/ueYT4rDfsNgTj0Bg3oxQxqAWPZNC9wcKo0MyRsWgAYzRrJ2DeG8nBX?=
 =?us-ascii?Q?FTk4dpegQvhPbRr945lxIITIyR2QiyFHqgSINFEkC2tfNZiE8qq7jrfgNXxI?=
 =?us-ascii?Q?C4gG7kQ7S4rQ2TxLjyPRwEfJv2JuQUoskQirMr4AusFfg9x6YeFoMxhyIvPB?=
 =?us-ascii?Q?jl0ugs88gOeXAcCQrtHi8fS/j1coZno0KHUARS0E0wYCa9U7macMnLrX4yhc?=
 =?us-ascii?Q?7q0ydLrDAaAP5mxm8JcWjZHt+Qy1/OpSUmgyHhDJD7rmg+0nWxTfAAsnSfeX?=
 =?us-ascii?Q?uU/m0rRNjgYweAtbNUL6HYMOYTB9oaOlukFnL4+qMnnTqYX2HpmEPRv+bwZV?=
 =?us-ascii?Q?nGb4pw7aCMDJUPByjptXr8jGcIZKZ4gCl/u4q+b5WAWfgMI2eiAGt74eg6iK?=
 =?us-ascii?Q?ek250CD//8xnjlKs9s8HaEEnG+nzuPwN3oGMzWFkN8I6ZVMjDiVQ+OBjBwHd?=
 =?us-ascii?Q?D8mUh4Q2dLMA0OswWHf78PQw53ed6nglt1X8cPYPTSW8g5N1J273GUPI1MKZ?=
 =?us-ascii?Q?ikIFDbJGSKPxXIEXW1OeRWu1/5a2uBmUmuBK40YMvhLPwFAmwBENOP5qG8DL?=
 =?us-ascii?Q?U31yJZFLHJvbiuaXp9fnKO/0gqwoH/Xb+7EhMWz7CBesG0608XrNK2lT/FdA?=
 =?us-ascii?Q?r/CM4sKaacs5tCHi5l0N9c/8GW5OanTsk+sXkyDcF3OLZqM5jtpu9yWdBO+Y?=
 =?us-ascii?Q?eOqgWjK6yzABuCC7aLgc5kPs1xzECxwfA8kUp13hzR3ZFry8dCaHF2uznZmn?=
 =?us-ascii?Q?EyQh1heodG4l3X0IwB6OXNaX+06DDqqCIelFVzwZXfnOcCnWWqF7kQN7ENZc?=
 =?us-ascii?Q?t+jPWbIGXvElOURf0KSfOaTIDC4rkwQp4zBLgvUX/MytE1JTGqodpcnXZTiq?=
 =?us-ascii?Q?7UyN0m9qaBglb5eBV/HDakl++QfQK+2VizMSEvaa0imPLAkxqHHG3qfE0zz0?=
 =?us-ascii?Q?lVDuDWBn+GE3w2a8P9TpHzurEwgRYbTjfDQHyHGxm+FoLrjhIzK96tRfwlbl?=
 =?us-ascii?Q?jJs3TtKdHjJdFrzlmOSgHTBS+xTis9CClN9ueQ+nMm0RMAvgZ4vvdqj1kK5k?=
 =?us-ascii?Q?sGy/jDZiifwv5lO7Xc831A+9QsivD5b2iTweYbUJ6MMqtDnwKKRgsJvegb6y?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1337d5-3cbf-4cd5-1ba3-08ddd2f5c2e0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:14.4753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfTi+mKgV+lg7QLkA6Rib8ChLDKA75ZQCzL+M/dm2UIWGCrZ9rGaeg3i/1LqTg5XuONFiBYyVRjpisolmYcak7EWixr4otnfiFn3OvjGJEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6346
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

Combine all MMC, NAND and QSPI configs into single defconfig which is named
as "socfpga_agilex_defconfig". This will be the default defconfig to use.
It supports booting from all three flashes using ARM Trusted Firmware (ATF)
as the secure runtime monitor.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 MAINTAINERS                          |  2 +-
 configs/socfpga_agilex_atf_defconfig | 93 ----------------------------
 configs/socfpga_agilex_defconfig     | 65 +++++++++++--------
 3 files changed, 39 insertions(+), 121 deletions(-)
 delete mode 100644 configs/socfpga_agilex_atf_defconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index f914fc54f54..2e730f94481 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -155,9 +155,9 @@ M:	Tien Fong Chee <tien.fong.chee@altera.com>
 M:	Tingting Meng <tingting.meng@altera.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
+F:	configs/socfpga_*
 F:	drivers/ddr/altera/
 F:	arch/arm/mach-socfpga/
-F:	configs/socfpga_agilex5_vab_defconfig
 F:	drivers/sysreset/sysreset_socfpga*
 
 ARM AMLOGIC SOC SUPPORT
diff --git a/configs/socfpga_agilex_atf_defconfig b/configs/socfpga_agilex_atf_defconfig
deleted file mode 100644
index a2bd40d5dbd..00000000000
--- a/configs/socfpga_agilex_atf_defconfig
+++ /dev/null
@@ -1,93 +0,0 @@
-CONFIG_ARM=y
-CONFIG_COUNTER_FREQUENCY=400000000
-CONFIG_ARCH_SOCFPGA=y
-CONFIG_TEXT_BASE=0x200000
-CONFIG_SYS_MALLOC_LEN=0x500000
-CONFIG_NR_DRAM_BANKS=2
-CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
-CONFIG_SF_DEFAULT_MODE=0x2003
-CONFIG_ENV_SIZE=0x1000
-CONFIG_ENV_OFFSET=0x200
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex_socdk"
-CONFIG_DM_RESET=y
-CONFIG_SPL_STACK=0xffe3f000
-CONFIG_SPL_TEXT_BASE=0xFFE00000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x3ff00000
-CONFIG_SPL_BSS_MAX_SIZE=0x100000
-CONFIG_SYS_BOOTM_LEN=0x2000000
-CONFIG_SYS_LOAD_ADDR=0x02000000
-CONFIG_TARGET_SOCFPGA_AGILEX_SOCDK=y
-CONFIG_IDENT_STRING="socfpga_agilex"
-CONFIG_SPL_FS_FAT=y
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_SPL_FIT_SIGNATURE=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
-CONFIG_BOOTDELAY=5
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="earlycon"
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run fatscript; run mmcfitload; run mmcfitboot"
-CONFIG_SYS_PBSIZE=2082
-CONFIG_SPL_MAX_SIZE=0x40000
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_HAVE_INIT_STACK=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
-CONFIG_SPL_CACHE=y
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
-CONFIG_SPL_ATF=y
-CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
-CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_PROMPT="SOCFPGA_AGILEX # "
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="kernel.itb"
-CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SPL_DM_SEQ_ALIAS=y
-CONFIG_SPL_ALTERA_SDRAM=y
-CONFIG_DWAPB_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_DW=y
-CONFIG_SYS_MMC_MAX_BLK_COUNT=256
-CONFIG_MMC_DW=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_PHY_MICREL=y
-CONFIG_PHY_MICREL_KSZ90X1=y
-CONFIG_ETH_DESIGNWARE=y
-CONFIG_MII=y
-CONFIG_SYS_NS16550_MEM32=y
-CONFIG_SPI=y
-CONFIG_CADENCE_QSPI=y
-CONFIG_DESIGNWARE_SPI=y
-CONFIG_USB=y
-CONFIG_USB_DWC2=y
-CONFIG_USB_STORAGE=y
-CONFIG_DESIGNWARE_WATCHDOG=y
-CONFIG_WDT=y
-# CONFIG_SPL_USE_TINY_PRINTF is not set
-CONFIG_PANIC_HANG=y
-CONFIG_SPL_CRC32=y
diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
index 0b6194c1f27..f5e73000561 100644
--- a/configs/socfpga_agilex_defconfig
+++ b/configs/socfpga_agilex_defconfig
@@ -1,14 +1,12 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=400000000
 CONFIG_ARCH_SOCFPGA=y
-CONFIG_TEXT_BASE=0x1000
-CONFIG_SYS_MALLOC_LEN=0x500000
+CONFIG_TEXT_BASE=0x200000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x101000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_MODE=0x2003
-CONFIG_ENV_SIZE=0x1000
-CONFIG_ENV_OFFSET=0x200
+CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex_socdk"
 CONFIG_DM_RESET=y
@@ -17,22 +15,23 @@ CONFIG_SPL_TEXT_BASE=0xFFE00000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x3ff00000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
-CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x02000000
 CONFIG_TARGET_SOCFPGA_AGILEX_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_agilex"
 CONFIG_SPL_FS_FAT=y
-# CONFIG_PSCI_RESET is not set
-CONFIG_SYS_MEMTEST_START=0x00000000
-CONFIG_SYS_MEMTEST_END=0x3fe00000
-CONFIG_REMAKE_ELF=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_FIT=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=5
 CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="earlycon"
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run fatscript; run mmcload; run linux_qspi_enable; run mmcboot"
-CONFIG_SYS_PBSIZE=2082
+CONFIG_BOOTARGS="earlycon panic=-1"
+CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
@@ -40,38 +39,49 @@ CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_CACHE=y
+CONFIG_SPL_MTD=y
+CONFIG_SPL_SPI_FLASH_MTD=y
 CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x3c00000
-CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
-CONFIG_HUSH_PARSER=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x04000000
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_SYS_PROMPT="SOCFPGA_AGILEX # "
+CONFIG_CMD_NVEDIT_SELECT=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-# CONFIG_CMD_MTDPARTS is not set
-CONFIG_ENV_IS_IN_MMC=y
+CONFIG_CMD_SMC=y
+CONFIG_CMD_UBI=y
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+CONFIG_OF_LIST=""
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_IS_IN_UBI=y
+CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
+CONFIG_ENV_UBI_PART="root"
+CONFIG_ENV_UBI_VOLUME="env"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="Image"
+CONFIG_BOOTFILE="kernel.itb"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_ALTERA_SDRAM=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
+CONFIG_MISC=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
+CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_ETH_DESIGNWARE=y
@@ -82,8 +92,9 @@ CONFIG_CADENCE_QSPI=y
 CONFIG_DESIGNWARE_SPI=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_USB_STORAGE=y
 CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
+CONFIG_SPL_CRC32=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.35.3

