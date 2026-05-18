Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE11CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 01:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42995846B0;
	Mon, 18 May 2026 03:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="IZJ67lrK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 026C383AA9; Mon, 18 May 2026 03:13:23 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65B13846AC
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 03:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXlZ7e9bJ2PxBiWt5o3l8WYXlWramhBwtqYlqsErxhYyvwiym+t3gngx/SmaD8zAhbRILc/QAsmR1kJHwmkJnMqRXZwiW2kns9i5NWNZhp29qVYS0loTCmNK67ggJFcYs32L36IARjhudoNnXJHl/U9+oafQt/KpumUuTHpZ2N9YqyPZq9ZLm5j7v9c813ekoTFYxn8o4lwytMM6gNP/MBWulBl58MzYIb+dZo6eFOcQyOORcvPWbtNInz3Ohkt69eyt8R0WyLMT5ouJBm28wFcJxXSaSJBtnNar1XEo+i+fG2rDEQlzN4G5zaFlop7bY4NAgTBUV6zKIV4aNnFX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k68WOAulZYdtVP2lKzguqIFd4hx67xc1nA3zyKoZhC8=;
 b=MHIBH9u6Z5UxLrVJV2Ixis5CzkzGVGzrEoRsXRkY3ke1Gl0EeLCCTxeR+ncr6Rb0gyGoT0QuY7CSgogT468N3LeACNCZyaptPIkwNeE9tceUOS36uaTdjavpDdgxc0mW0OJ6ud7QTPz3fFqHjEjn5W9ETFSkBUvXAmISGsUWVUOw8dx4jbjtvFujicST+KhxL/F+wrSDelKg3qH7VjJRhZGmBNPsNG33kucBVSskGoaDAP7iVfk6GwW+p/oSeRSyzO/TQvdJ3zMsWtoCIf8AsTse1EiGcnLK1HK18A6er7CnIyh9PI29I/2v95YC5fc9l99/by9mPhBT9Ks2CNTJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k68WOAulZYdtVP2lKzguqIFd4hx67xc1nA3zyKoZhC8=;
 b=IZJ67lrKMsh+bHCpf5G6yKC/t1rWs8FPsvwjZ9M0k0TXeGRQr+gfA4IKXyOHoX3shX5J4EvwBrhzaIfbCfqS/gr7CjGNlwgo0EgR82jYYLH7Pcoh/mWjsfpdqtoxSWb6/c3VvzTU88xH3Fg8cPGk4Pz0W0YS/4iqYjvryK16ZxCFPVtZqbNkD3sWlG5ApQCtVVqtAYOuGKWB/Bs9DOYAt2e9s/yHGjOWb9lUISgSMzSkin2sjolNiJGdRNgC/XEkCW5gv4xVlK8buAPhIiFZEdIeu+tSd6R8+MXzFXWXLs78ZqHpyARt0DNBswCS++uUKu4gY6bzvtz5tbJCot2bHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB6928.namprd03.prod.outlook.com (2603:10b6:a03:43e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 01:13:16 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 01:13:16 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v3 5/9] arm: socfpga: s10: Enable system manager driver for
 Stratix10
Date: Mon, 18 May 2026 09:12:41 +0800
Message-ID: <20260518011245.19083-6-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
References: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ0PR03MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d9f51d9-ad16-42ad-f4e7-08deb47aa3fe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|55112099003|13003099007|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: bVqVvY08qy6tNZhTj3A1LGmtyC7xa2q7c4L911eoeRElJQtoni6rBHMr0J3i9CYevKUY2la6PVj10HWzFStkc45WET5d5qqgQ1aOSenN9XfQjDKx8PWxci1/MAdMfuSt22WfktjlYId7iPx2c2TSKk4nv2R4bs3JE2U97p1NMdhHuDC1qdfL4a9Tc4nC7uppFKj7AAXBUrqqdCgGhRhurg8h23eABjrVVz9SC+0p88EZn9KhlSrE6o9l0r7USGvDvIhHhNnhzCaHEvkgM6tbdDvsRkzUMEBEZeDxzGQMJTETuHp10PlrSHJ5ry0pwTfFVVAgANHDgOnKteWdib4XeQUTs/JxFAynXwQ/rhF33/s7Hi799WUBaqTb9qETrxXevT5ulLDuqPkjSwpwpSrHeZZ8BStkn7egjq/Z5GRtY07ax52t8Tep3rr9T+/ESC/6lMKJIIleDRpK8YCADJQ5ZY71P9lSRCpSiwmea3XDT8yRmLnsKC0G/HyNhOV/Bjy5b3hl53IObgrFnBZmWULObvVS7AjnstaYsydSthqWmQu1KRQUj/AxoHAxZMl7vQ6nozRgotvnWZz+xLpdRdGHZYOOLpqrOOaSLgeTPw7FKCuCr7Iq4Gfe94KVOH220W//Hs28g7L1FvQyEqHILsldhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(55112099003)(13003099007)(11063799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jNUHrGPmna6an6RABK0DGr0HhCITKFvCJLhN5NZQffm/XpxD3yI4XW4C6lnP?=
 =?us-ascii?Q?ncmui9ZdhgHAn6Dn6GV1XJEm01dCfr+CKVPhXBs5SV2SkqrrBrui3zb0I/OG?=
 =?us-ascii?Q?Urnz4hOQ79ujRTczqsTEqkkzVAzZQS3WrVqq1pL8yT8Pr6WWKCmhPTq/UkbD?=
 =?us-ascii?Q?Ft7R7Bp4oJHCtcaAo8PrryFcPHJiRVvRU3FLvhh3kzEDtQOsbfe3oGZurD1g?=
 =?us-ascii?Q?0bq6FL2qsmwQZvgwBd2QKrNUsb75o+rFK2zUfwmP70KVIUKlvtAGEzMStTBz?=
 =?us-ascii?Q?LSIInJglvbPqOvADxHyfPWdSW14HbdMCXHZSVOwJmVxq98Bcg+wF9kYT6ZV+?=
 =?us-ascii?Q?2116BNDBG/WBXAyOaIww7/1li3FoamXh+Y8SVJK38l6t6yHhjoHlUc+WYIZV?=
 =?us-ascii?Q?SCZT+4bTlW53t/t5ysPBvgHGXFK0RftRzB0eU7ll3Od950RQzxj1vKrJ5wt/?=
 =?us-ascii?Q?QjPMvMkK+5UyoOhu+XKXsT4noCZQnivEr6o74Rl6pe2gFmdh8qdV7oJIM+C7?=
 =?us-ascii?Q?SIy3pMSenUkYNcdbymHAYtb5MPEi4+xAbEPvWG/btbsl9OU6LMv05V7cJCrT?=
 =?us-ascii?Q?J84ZZcg36nG1W3QalIg/cmz279AqD0dzqkETet5DS2aJdAagF1pI3qLwOUyz?=
 =?us-ascii?Q?9KzUB4X/3ehOyiktxsFzsmJFMT97xxDkH+pU46rBG9uQZcDhPw30z3ToBID7?=
 =?us-ascii?Q?dDhaDEwnlpJx/rNflZ0Xq80WuD1xLkHTAnDwjRCEFqiy0FhMn3cp+MZeeiim?=
 =?us-ascii?Q?4p4xen56O7SXAjiCP5YF9QUdKyVrLqL8I2WM2UNhrZnnU+tnMZL5BZIiUju0?=
 =?us-ascii?Q?O+6mAoOmVHCVODNBd5rntSQbA+Qh1n/uL2MFR/7ZFItEiyk8l5ljMMog60Rw?=
 =?us-ascii?Q?uHlZAt8PYm1e8bCu5LFdnvQbNQwhbe1+ukfSDCLTNtwlbelOfsDNeFdSQlH8?=
 =?us-ascii?Q?S26R8y7lpKrnmNCWToqVztRuXeYNziKVVxBPTrdaV35m4qHT+9Br6bINYPuY?=
 =?us-ascii?Q?6X7QyAfZMLyFUV6i8KVPJGZQCpYeo79vLeB6wUdq3YG7nLbHXPseKvSJK0Xe?=
 =?us-ascii?Q?tUCwRd4uf6x2nNUN5iZuwQHw/T47b5HIx4dEtWNvc73mnMo410yL5mFFCDbc?=
 =?us-ascii?Q?84cnwTSZDQjsD1qinYSuxuDpTlkxZLZOHPPvJTYImEBTIXuLndGzk5/BfJiI?=
 =?us-ascii?Q?jp4SnJEgwfB41ymuSREjD51U2MqoWQozzxWDf3fDh7fyz0YiSvjx84M8r0xU?=
 =?us-ascii?Q?nzlOtKSC0+MeWXstN4z99YteMd5wNdkpo2ONSamHk77v93c7UaCacrkFxmeh?=
 =?us-ascii?Q?ms2r61spW9yO7C3icRXCzFGwolm6SeGc9uRGRVZr2mXHTqEUAYd7yq9r/5bG?=
 =?us-ascii?Q?lYKA8KKoxDWWXA6hKE/v+yv4sQR1mqlvNtju5SAeMB1hoyHpDsWMmhE6gu5B?=
 =?us-ascii?Q?X1YV1KB+P2ubZfMfZL8bxIRag+vUalrShgmcQYwJajS9/lO2Za9cgqSctbP6?=
 =?us-ascii?Q?0qTzAOu/mYnznTPudGbyXmqDVCSbHoBFXALQK8UiC+kS0VwK0C7//CMH4hFj?=
 =?us-ascii?Q?7ApW8IXEWc5VnNS24UpGAsTrv1kou2qipwybTz8O3WvYNM/NuvE8MpfnaH2T?=
 =?us-ascii?Q?DFHJHTrYUkdzFkhGkpkMXrt+DbygwQyWkQ1cs4sPayKzlu+nCv1EcnUAqpKE?=
 =?us-ascii?Q?1dTAmvuj0MQaBwTqtDpm+VR8MVzsKRKgRms+XVyFXAA2NgyUPw70C/4aiQqr?=
 =?us-ascii?Q?9Qw/QkpYvzjwpdmvN2Pv5Qd2ObnWfL0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9f51d9-ad16-42ad-f4e7-08deb47aa3fe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 01:13:16.6156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zEJZ/4Od03HBnompPDtr8HlJijI+H+FfaOLUcHmg+zW5re+tqUp2K3tyEYabgDu2SeDN1OvruNRCfzVi7x7ePaJF1SxK84CXZNVnYNOQe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6928
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

The base address of system manager can be retrieved
using DT framework through the system manager driver.

Enable system manager support for Stratix10 by probing the
system manager driver to initialize during SPL boot up.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

Changes in v3:
- SPDX-License-Identifier format correction in
  board/altera/stratix10-socdk/Makefile

 MAINTAINERS                                |  1 +
 arch/arm/dts/socfpga_stratix10-u-boot.dtsi |  6 ++++++
 arch/arm/mach-socfpga/Makefile             |  1 +
 arch/arm/mach-socfpga/misc.c               |  3 ++-
 arch/arm/mach-socfpga/spl_s10.c            |  1 +
 board/altera/stratix10-socdk/Makefile      |  6 ++++++
 board/altera/stratix10-socdk/socfpga.c     | 12 ++++++++++++
 configs/socfpga_stratix10_defconfig        |  1 +
 8 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 board/altera/stratix10-socdk/Makefile
 create mode 100644 board/altera/stratix10-socdk/socfpga.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ea646f618a5..dede01e0d09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -168,6 +168,7 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
 F:	arch/arm/dts/socfpga_*
 F:	arch/arm/mach-socfpga/
+F:	board/altera/stratix10-socdk/
 F:	board/intel/agilex-socdk/
 F:	configs/socfpga_*
 F:	drivers/ddr/altera/
diff --git a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
index ad4b383f704..89fa0e829f6 100644
--- a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
@@ -13,6 +13,7 @@
 	aliases {
 		spi0 = &qspi;
 		i2c0 = &i2c1;
+		sysmgr = &sysmgr;
 		freeze_br0 = &freeze_controller;
 	};
 
@@ -283,6 +284,11 @@
 	};
 };
 
+&sysmgr {
+	compatible = "altr,sys-mgr", "syscon";
+	bootph-all;
+};
+
 &uart0 {
 	bootph-all;
 	clock-frequency = <100000000>;
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index b6f35ddacc4..962dce67c64 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -39,6 +39,7 @@ obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
 obj-y	+= wrap_handoff_soc64.o
 obj-y	+= wrap_pll_config_soc64.o
+obj-y	+= altera-sysmgr.o
 endif
 
 ifdef CONFIG_ARCH_SOCFPGA_AGILEX
diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 1eef7893e54..418d7dfb572 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -263,7 +263,8 @@ void socfpga_get_managers_addr(void)
 
 	if (!IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) &&
 	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M) &&
-	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)) {
+	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5) &&
+	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)) {
 		ret = socfpga_get_base_addr("altr,sys-mgr",
 					    &socfpga_sysmgr_base);
 		if (ret)
diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
index ce1d5d4c8ff..b05bec2cbc1 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -48,6 +48,7 @@ void board_init_f(ulong dummy)
 	if (ret)
 		hang();
 
+	socfpga_get_sys_mgr_addr();
 	socfpga_get_managers_addr();
 
 	/* Ensure watchdog is paused when debugging is happening */
diff --git a/board/altera/stratix10-socdk/Makefile b/board/altera/stratix10-socdk/Makefile
new file mode 100644
index 00000000000..2e105adf942
--- /dev/null
+++ b/board/altera/stratix10-socdk/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2026 Altera Corporation <www.altera.com>
+#
+
+obj-y	:= socfpga.o
diff --git a/board/altera/stratix10-socdk/socfpga.c b/board/altera/stratix10-socdk/socfpga.c
new file mode 100644
index 00000000000..f8facf79204
--- /dev/null
+++ b/board/altera/stratix10-socdk/socfpga.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include <asm/arch/misc.h>
+
+int board_early_init_f(void)
+{
+	socfpga_get_sys_mgr_addr();
+	return 0;
+}
diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
index be0c452ead0..53864251f29 100644
--- a/configs/socfpga_stratix10_defconfig
+++ b/configs/socfpga_stratix10_defconfig
@@ -28,6 +28,7 @@ CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=5
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="earlycon panic=-1"
+CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-- 
2.43.7

