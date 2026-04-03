Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1D2D73086
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 02:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E77EB84142;
	Fri,  3 Apr 2026 04:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="VqF1iWQP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 708E783D8A; Fri,  3 Apr 2026 04:25:58 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2FA4840BE
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 04:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8wAdNHPFJj+3/XaoTs8Os0bk1hLlIWicPhFp6MxBZ8aHY6hMRIhMW+5kdKdx8fWfG44Kdecc91ywuJqZUFzJ9nxHtcIV5TqPW9+7a6d3z5YMqGm9TqTf0mPCzOClqBkvWcE3p+Ry8Wsw9Lt3RbE6eMxN2GtfhMp6B2qkMYG7OJuBw/d+CDcErzD1LsN/vLYOhKizGuZPpKpkLScF5MvBuXzp+nuCOwM1ziLeTki46TqlQCeA61KOQSjedsVgNyIjeG8CjeCLvk00/MIVhLG+FMQCrJPxzTKTUyz0ODM9XZ+SM8/f7PjrePPOjf4eOX9gkDThP6mSm7UoSMfopei8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpcNrYga8FWpIk1fn7kWlT2pfR6yflbtyxzuoJvFecY=;
 b=eCkSXMgAZpxRvQrr+zdlL40EAAx+ri9XbZdFFgHDV/xsO+6IjjAQoLZib76DJqXMqyCHNNyVH7+U7IB4b1a00PG7cF1ueDhfN+NeH+2pqitorB6Jyu5z4Lrq2daBR9hw6LmSC6jDx2Fq3eqSeZqpHKdKnL6H4tesKFoqJHfPmtsBjyQUYKWCUQpWvVoDkDpoPZDZdIODJ60EwTlu6lVVDsR0CksPSe7GDvDIO6nl64oSPxZk1vH9usMq/VNbfRKYARdWGNB4ExlnShG2WcLJm2dLBIB83TmMNdKGE5i5EXCY91C06rFZWPzYGv/OaQ/adtvFKqx1kA32fV6PFTJ/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpcNrYga8FWpIk1fn7kWlT2pfR6yflbtyxzuoJvFecY=;
 b=VqF1iWQPfiUMGByNWSBNHFSSdI+gNTcGTECtLFR0APDTt2pJzPVVQV/frUNuCXnAJCmsT56bqt198a3ohwe36H1WjmEjizv4EBf6kbOm0rMbSlBm4EiOa71PKj18ksKlWgYOtrgOxf2eXITBBoEsFIiCaOb7DBtx+2FqwdAu+DZXHHW6FDxvWhmKQIl56br3cajdMF5aK2jf9oHgSrW+XISugb+rmu4D2jpSuVUi5V0+D/nrjefqceg1ZQJwqX4e8tHs7VvP7lgp9bR5SCSeKdD90q7kxmiuQc11yAStxBY5JHhTwK8JF4BD7WsSAlsc9j7OK3+L1Xir8uq97wNGiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSWPR03MB989164.namprd03.prod.outlook.com (2603:10b6:8:362::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 3 Apr
 2026 02:25:49 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9745.025; Fri, 3 Apr 2026
 02:25:49 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 5/9] arm: socfpga: s10: Enable system manager driver for
 Stratix10
Date: Thu,  2 Apr 2026 19:25:09 -0700
Message-ID: <20260403022513.9446-6-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
References: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSWPR03MB989164:EE_
X-MS-Office365-Filtering-Correlation-Id: 5809ffb1-56d8-4b7a-184a-08de912851ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|13003099007|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KSPHbGKSBykkFMFlMCzdRj7uL/+bVAJnD/E7mKvgyM4Sl9DkkWyyhS8UmoojM5CvWGUak3x2aUXI2/YNm3+ziJJ9sUPx2xrJAIgnqRkuwyWP+ibV6fuonMU4Z+q0PnfVhGQAmqCGiffmy0icuPCwD7Qv2T20p4OpD+QkpDH6GJ/b8aMrmGXL+bkIdpuoaQCNKgnMudzRKdcfQBO6piVebvCLOVseVYjJbe3tZcTYIpN1ycSyYyEGAM8m3YfTBeNdUZ6eo0l9mhtHJidpMHWhyjxLLdAD+cgZ0QXOFhPLseJhtRBPn16OibpoCQYIOxb0s6Ur5wQvoaqx+di8PX4BCUlo2O/6w5Tz/iuFuesJlDZK47tk080asCzuERNiKBx7teFyzcF+uQV0dB1PkD1QLNDRCbOn82luX6xAKTNrn8KTPS9yo9bmvxHk7Uc3YoAENAyQJlEmXQQ465eqkMaj+m8NHNFVs01o/P7Vc31RVRYc5aMFyrGMypvPNbrRouaFdP3/woJDCVcVslIN0xJUkCblpwm5W+nAis2BJ4HmUOzVIfy/lw0nGOIFFVO9JaQLIEzfie/N2REo3krpgDRUFS8I9c9EtJ4LRtke0N56Hfk+9Nb02eAkQShHPqSwCBFvKkZbUnrVTY9TphTpg4RwTwMDcyRU8UsEb072vI5+EF78XvFabp2eld4NR/W7i1FY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(55112099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ImLbNTqIuuC3aXBYyl7dbPL229kErkbC0dYInz2Zav32JA0Ziu8Www30h9FS?=
 =?us-ascii?Q?95R5Wzs+sZnxAUEXc8KH6YWBpc11LcvYEY+Jc2GZksAdNNPYQa2JhU29ZPxZ?=
 =?us-ascii?Q?Tyd619/gDGmYaKMRS3fEByGr18SsJarWDXUwBMYTRAU0u1Uqz/etLDxKw2pE?=
 =?us-ascii?Q?0bgW5p9ymoSiw3m0rzm0G02fAC/Jpy6rPqaW1CQD1/jxMLXVeGdUSB8IC/f+?=
 =?us-ascii?Q?3C4M5rx0sbdAaBkut1BcGf6EN0p+NJoB/ZVcLW4WQa4981oLfN4ptQimwDNy?=
 =?us-ascii?Q?0iFx2CO4nmEm3fAdIqGPlwwV1Tu6Un4ge+lpQgqYfiwGM9F1jIpD9UECZjMk?=
 =?us-ascii?Q?w1aVX98JkFj1oIyVNH8KlC7V3Y427HJqktWJIcftJU2jV+v9xc8aQzumjIyl?=
 =?us-ascii?Q?2BYhallz7sxaHnVN/RQHn8FgF3laxc8sixrfbBkCnNa5/Y9OLmZ0MleIW+50?=
 =?us-ascii?Q?e37wWvDMCPEAMiWAWd13OjP0AXugeUdQDrICnwCACvpq6lmaIlP9yyY1vCAH?=
 =?us-ascii?Q?OLE3ZN994VWdzY4UySLhh9T6W424Gcuo0ZaibQ/C9Hj1Aa6yUeITBtJOCJ+r?=
 =?us-ascii?Q?cB8OXYhGFpKjjMlG6nsjU5p9zkg9uB9Pq3epvhoGUV59eoO1MNtnU27U4/U+?=
 =?us-ascii?Q?11QhkIF4jmoUZdFz8RfxWRN1MKhWRooeKXcNMOju6j8ayA5w0QOee4NUkQpz?=
 =?us-ascii?Q?PNRLLVvO6FJTBBML+1ELmSuozElHhkwj6XBsOFXeMp/ndMTEmCF1HAgBzW/2?=
 =?us-ascii?Q?5sZ7w8Q/trHEJKen9EJpmX9JyNGM5oDkMPWRhA/El70kHurT9FKljeCwfFkH?=
 =?us-ascii?Q?BiXc5bKIu0J7qxk1+OPYT/a1HoJwT+5FtVSGclJEU6UeWinr0OacGvGso/oS?=
 =?us-ascii?Q?S7tvmw+agre4zrvxY//DFCcUv5KlzJ96s+hxfl17vbwJ9gth3u3Mjd6xB+fh?=
 =?us-ascii?Q?fExw0151uHm+npcvQCm76m7SKHJ6vBNYWENksFu+929dwC8AOhJGElFE0Mkn?=
 =?us-ascii?Q?pOtO8DAEAEa4j83vqYIyOijUtaXdCcFILWeTT9etMW4D/LbJlRXmGjrvDrEg?=
 =?us-ascii?Q?dDwvzwQz/U5YcEneey1/Z82DH7XXJVNISYP1EP/uTMwXP2a8z2+equ54IwAy?=
 =?us-ascii?Q?D4f3fWgSEEpVIqQgzZynDfOL+m6hZmSsMknmSVpBWNGumyqC7uB/fpVN5GhW?=
 =?us-ascii?Q?+Qd3edzQhzBof93Qj4IPgrE4JP6SFrvfPVLpoZzrGVtE3YBj5zuWexKGkl4z?=
 =?us-ascii?Q?bHgbyJe8HGSIdL107GmaObcirwWeJtnLgwgTG5uYEDLOeNp0FafsECeq52zL?=
 =?us-ascii?Q?KuDqOZPf52ECa8Bw1MZHO1i3XpuCdhWlm9jupxddPCSXoQE9wCdroiJWRLZO?=
 =?us-ascii?Q?vXc8WpxKKcJCL31pcqRPZXkyV+clzxMwNAVx1QOADArEEjzK/uhX3ckJCf+J?=
 =?us-ascii?Q?zH25oxy1+bgaL/NbiLpd+0yZFHRcoWUiBBhfeVJEvS6aD7fx0NSmAhiYXtlX?=
 =?us-ascii?Q?LA+T8rCGf6rQXkAMTJfkwXxiXBJD1eLArDQXg/V8yMSik7zwxvnyusJYqotg?=
 =?us-ascii?Q?pvSoe4eBWTYA4oNM7ejhBP71XakyM3rlEZ4Go3gD8RWuGOEVqSPV984c3M9p?=
 =?us-ascii?Q?7YA6FXmkfXUfFa8YrIe64s2DK8upzxXFi0O5ca+UX+MPnvNnvJP74gfVMefA?=
 =?us-ascii?Q?J224GKYKJrIKU+JC0PCW7GUIM1L+20T0e7UpC+qMjwWnLdoZHq1CrrRpIMWw?=
 =?us-ascii?Q?K5nIc123AZaisYwSOogZvl+ZH/55wtc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5809ffb1-56d8-4b7a-184a-08de912851ca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 02:25:49.3198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOIvOdXwSZ2aASh2Aej7WCOLTRBz4rs/aAFIFygtnfUZ8M5wVxqIiNbjiE9sZVXkMiSbNm43DRoG1706uYK2JPZ9KmBzo/hMPU+br0ixahI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR03MB989164
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
 MAINTAINERS                                |  1 +
 arch/arm/dts/socfpga_stratix10-u-boot.dtsi |  6 ++++++
 arch/arm/mach-socfpga/Makefile             |  1 +
 arch/arm/mach-socfpga/misc.c               |  3 ++-
 arch/arm/mach-socfpga/spl_s10.c            |  1 +
 board/altera/stratix10-socdk/Makefile      |  7 +++++++
 board/altera/stratix10-socdk/socfpga.c     | 12 ++++++++++++
 configs/socfpga_stratix10_defconfig        |  1 +
 8 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 board/altera/stratix10-socdk/Makefile
 create mode 100644 board/altera/stratix10-socdk/socfpga.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d2508d90c33..c58d8f85e33 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -156,6 +156,7 @@ S:	Maintained
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
index 00000000000..416c121406a
--- /dev/null
+++ b/board/altera/stratix10-socdk/Makefile
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2026 Altera Corporation <www.altera.com>
+#
+# SPDX-License-Identifier:	GPL-2.0
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
index 6a6f1d98c16..726dd7d7c9f 100644
--- a/configs/socfpga_stratix10_defconfig
+++ b/configs/socfpga_stratix10_defconfig
@@ -28,6 +28,7 @@ CONFIG_USE_BOOTARGS=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x3ff00000
-- 
2.43.7

