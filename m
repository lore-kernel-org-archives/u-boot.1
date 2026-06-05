Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A5ACD6E6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 01:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C2BC849F7;
	Fri,  5 Jun 2026 03:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NGhq9PQ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5069284931; Fri,  5 Jun 2026 03:57:00 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27718849CE
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 03:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ak2PXeTznangMd86HnaZyF98DDYAm+/li13Ody+oxllSKpNQJFuMc6fyQzYFQ336vBqt35dRdQ2Uj8YZh0Q0GV7+sB1xYg53HnRZUaoBC7Pm5AXy+NVFQXyxLtetsDeihZ5PxMt5SmTxMBsAzF/nsvdJqh6PZEKQH8yySSUI4gMZjmeLJ4N5n/0b4NBpv4ftL9JyIYDQa+nvxtkwrW499WRVR3mQNMvH1JSwlqKcNCqQ8Fp8xa90iMYrqMVH0sgAP2nt1jX2tsWrRqDKT2QZMROiBt3LjxoDbQuW5n8FC7nPMLJhk2mwmWgNaqMxZ5MZFY4q+USTAyuJVB9F3eX65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhzI3Rq6mdunSlbjmDty2BVXEgViof/2Xccz2A0ksUE=;
 b=XidWru0OOggGrJaxy/vaUmeqaTyOWhf7WTqYkcNrbBkOqjz1hkRxWUPpHsV+z0dJw9UHFv16uFP9jUL7RTy7IqV96aS/RRyxii9RneHd9N9UELKhZRP47tz+9JYXIP7w+cyvjAEqKajt4oKXaar58ShcOlLBrmVU8T5hqU0uiRsZkEUzGFNQNa55C730yHaHVtWH+rFoM3wAO12hiuC4uQgc3S32HAwJswWnQb/PevUVs21A0wrK5NDH2yAIElQ/AJvcvdVmUv4+67qyCMWuofenEpkbIzQtHYjtaT4S2MQV0L7Avw4ORZWXgHDQu3GG1XcBgXdsNdW+7z/onPLGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhzI3Rq6mdunSlbjmDty2BVXEgViof/2Xccz2A0ksUE=;
 b=NGhq9PQ3qa5NbrR+rQ6ywzdB0zUCV93mUf0CDaQ6DdfVe1QWo3Owutg/fe1RTky2P5Eb40FsSt9cOlknock/14Rmk7zul7c7FglJSikC1Rc07/DmegZDio9m5l528wwJmum+CcDFsVT/QF4YJW/QYrAtlQKLCQY44HE+zpU5BdWFqZFaVADidlM5VqbeXlOFwWWKjEdWVj51tsqk7YRzcGj3LO4Vt7byZzMRGlDFWV7WjD8zRezAQji1fS5HOSfd+ZfBUSQdP5TrLNwyI/b+lCAFBtUGbtqDBiv460/36o2Xc9xXC8pvcx3eJMC9WE1PV+yWdcjxfxZZTS7AmTlRbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSVPR03MB989315.namprd03.prod.outlook.com (2603:10b6:8:3ae::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:56:51 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:56:51 +0000
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
Subject: [PATCH v4 5/9] arm: socfpga: s10: Enable system manager driver for
 Stratix10
Date: Fri,  5 Jun 2026 09:54:59 +0800
Message-ID: <20260605015503.11709-6-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
References: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSVPR03MB989315:EE_
X-MS-Office365-Filtering-Correlation-Id: 874955cf-f103-4a14-566e-08dec2a5b5ad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|11063799006|56012099006|22082099003|13003099007|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: iVcYFG4w+fyBekMmdIRXnMWPjWtgSwiWtMNK5pnxNfv4KaxDQ5iVm9mufahY+o5RECcedXiwpg+aBfdn1AKET4ilSYgViGjz8gikXLkTAQeoqz8ohYYiuEHNeFeaySYXIKKSHIeOGa5NlS/NA2OCiKeIhb2EUIOTJRnv68nfOa2cFuL1F7JGnmTp7A04OXRShdnLx7wBet+f8cJ7YUY4IiqemIQinUNAQfBFtdaFKNfPthRWYr3X+Wx8Igvqxx+Y6vrhFBbGpMKgt6BBvo4/EsQELGmYwqbNgkBecqfk/mLn4uqWKRz7SbRbzl8GrEQJdjJT1AwRSDBWFA01vJpszkY3lSwvm97BSvdBxa1XpFEn0FjaYwHHNl05/3nUXRRe+GxWPH/hfZtXE4fXa13LUYW4ZuJ3gE0oFje+9X6T5EqbByQmjv/8bp9BF+rikYoRvKbgM/W1AkLKKSniV8lu3Q6VWIEotZRX1jTppUxFbrkU90Z+ejygv148guq1Qm1FgB4XdkHee2kWcFKb36RHj4uzEEPvFBdbvYlBcLkGrCkcaI4ffc3A20UK1Wm8DbUYWp6eRUX3KT6Bp+zBzPR/Fi1SbwtNW8M0FFf55Dw7qy1FvXjuuqcr0KN/wH33VXnDlbhlXlNh+cQ1tgTm6J7WNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(11063799006)(56012099006)(22082099003)(13003099007)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ssdHyEYq2gDugXDQR2gpHbxUsXxB/WYsd2zECNV6KgP4R3cRFgrgOAL4eyW?=
 =?us-ascii?Q?FHflJQyXs+yZaMaPWvPfsQQVnPC29aU7eRQ9DsUZOGi18H76bfep7IlCrLEn?=
 =?us-ascii?Q?g8JxdqO8ygdtapRZa8aCDJuJyxIjO61Cyfmjn9DP9Pe2TqDwuY+DPs6c5tOP?=
 =?us-ascii?Q?sSU9JHOGOH1bqKVK60D3+KYhI5j/8+u4Qk4+h2+gpdMrGv8vfetvnO4/dO1s?=
 =?us-ascii?Q?Zm2kDrzQ6nzNe4ZU+Sm7EhVxiPBnnROENdPatfcfl6HiTj54kpauc3sCnvGl?=
 =?us-ascii?Q?5UPXFtl7Hc212Fj7Dez9Wuu8hfDY11GP9CxzVJ8FScgXXovjscN9InNpMwYZ?=
 =?us-ascii?Q?SoXYSbpRWWGhcPAaoDuce9qOV7h6fodvafi3KineXKhLivLzKTxn/O7331cF?=
 =?us-ascii?Q?VPRyYd9pZpbdMbf9ZSwwTnrDMC7f5a06vDWjClGR9MUksjpoa5C0tQRH8dzF?=
 =?us-ascii?Q?WOqgJYQCyjiFo08TaszbOJ2VoDGuVk1K0XViUnIKbZ9JWuDwCJoQjZiK2Tce?=
 =?us-ascii?Q?dPwK5S5CnN3rd2hkkCpd52TkAJwViCDDgXscxreN9RTV2SR00z4288DJuhpp?=
 =?us-ascii?Q?bgRfdjIcMPDcqCSVSxCHc0UidIhEFlw4EEOQ4viwVCHfxpSuNk1s8gJs6jF7?=
 =?us-ascii?Q?YXc5ZRth/aM5AxoGpgMbFcOYiA+Wx1wj0L9xhVF8tRJ2aNfT5MwqxRW4B1+5?=
 =?us-ascii?Q?jRBHf/T1Euy+F13p6GfQVxyhAA9GYDtizLcWHSjzQR1YZGFDECBGCJYJMmx2?=
 =?us-ascii?Q?HzCyLHCrVILYZdQTy1pWNoIJE8da+4Xk2nG9NS+2mCUYs93bHdlyau79CyYG?=
 =?us-ascii?Q?Yp1guX1i6RmGFQsrAZyctkn5dBgmOAOx6tZQnVP0A/4TJ0btqVsQLDU51h0I?=
 =?us-ascii?Q?uz43I+8hFg4xkPM6SC114zKk0+r2kuRigz639bpzvr4JAyNva4Ii8fl8EwQ0?=
 =?us-ascii?Q?KY3geDcvfAiMIY18prNYoHXdpLF4CtCaS6u9VNcHX1u7DUoF/AgR7Yow3R67?=
 =?us-ascii?Q?TupIz3q6R3iePkQHx3e2e93NcZMZWjMRsiE82X1pVnceuunc752oS4Yu+Vcz?=
 =?us-ascii?Q?3wHzbmFy1aDE+kpuCtCJulyCV3bFMrfFAGkwVmvw9WrU99j277Fipu/uRVE3?=
 =?us-ascii?Q?3XswiawErYqJh0d8NWAy81ndveB9d53eMf93QWS2cDEd+EjJWc7rcVA3aFoJ?=
 =?us-ascii?Q?evuhx6g60W4l2+c8Q9c322uiZPpgUbGbpu1cWbwEdAtsHd9X04OSes/gC73M?=
 =?us-ascii?Q?bbfFj2njCwvm97wDZs3VVLrMLXrentYc3cQeuhTz+H8CL0MlXXgWN2MpvwnV?=
 =?us-ascii?Q?sg4mT1vK91jmtTQl/xtK+l9n32Iqb1v/LiYBt+2tcP4p4tePLRl4zQ3iYyNc?=
 =?us-ascii?Q?2quvm4igo+0SomHQy7E1nEnz0nokaIENn+C1bc8TVYZGMqvhOXYR2BglV9Mm?=
 =?us-ascii?Q?S/2n2FdMbZe/h2W1g86nMGmpHlqg//5W62j20Ri/nHpkynQqEl5SKxL7Cboz?=
 =?us-ascii?Q?uLFkPxmlZ68n8rwfFyaWkpZlFchAfyMTiHpMZe5EIy1IK3OMGuEU9Sc4geMa?=
 =?us-ascii?Q?jsTYlB/+BQQIECvarJfMITBY/Gs9rRnn7dSZz1yFu3qfuOMaqdWOFWGhiLyj?=
 =?us-ascii?Q?Aox7QyYu/+9K/+4mKDDtn0yKTE5mqLGC3IMAIHgexTHistczP50k9s7nozRU?=
 =?us-ascii?Q?+uaG2fN4i3Y43YKfGXM/1ftGPhRN1HbEhWeTcHP/dNTlKwwS76gl4wpoUC7d?=
 =?us-ascii?Q?7Yr59dzw1vh2DAWOPZonU5JPT+HCx1o=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874955cf-f103-4a14-566e-08dec2a5b5ad
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:56:51.0120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJV6qHsB/4gy9xRLSEy5MqI5gUODZ64TWS8+i0ah7pscCWVsMrPtQwZXHa1jtKjP7/WLydVO1/CVQ7AKeasofDyhgE+Jkh9q4NAywi+vrgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB989315
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

(no changes since v3)

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
index 571af196465..bc4abd21dbc 100644
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
index 00d43460fce..893579f17c1 100644
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

