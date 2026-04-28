Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E237FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36D1284314;
	Tue, 28 Apr 2026 05:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="uJwCuefM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6114484119; Tue, 28 Apr 2026 05:48:41 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F750842CE
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXQaCr+RRtgAqkRZ+DMjEY1pAkhV2ZgCYjjnveF91Gd3wz9AGm0poiDcduAT+da6rUbHUAkmqDIV0zEYaB7IG0GhjmnpnwQJrBdVcRih7kd5ZecxcOrhk27cF/jkq2AcfOfXm1Yh12//Hg0vGMY2kCOpMkqDnMEMiNwVMSVY8uKc8lDQ05cBagRcq+Y57PPlOCHR0uWVZ/4b0y7UMeuxfjaBIky4U//vobcZ/GSGIW0is0vfHXlYJrZGuuQOMGKRWWNOG3Er4EYQODyciDhUpszUt9jBLGdfECxbUK3cc0QEeiPvf7fHvbH6KqzRp7KxJEVYVQOqh3ObUfdKB655UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzB6NFh5gXjYN4p6Ty0hfiikW0qooA1FhT23PQ1k3+0=;
 b=JrpGViZK6yoRnqgDg2NQX/YrxMN54YBSuz1yTdwKW6mTg+KGj49KHyp/uJsxVMbm8n/rRP4AKjhTlV400BUXKd0ADkAuwwg/GUwuvaa8TRPxoJ3XFLubFzuOK9ZkKmys9t2FwZM5Ux4ONlWzEm1Qt6yiJU+xcT0aGBv0feOaTXmkXSmLVZ9KoMk6zF8tQY1pWblvX6ruYbrnjf74mo3AOf1KonZzjXpeGVPAM9hNiWqaP7sPFSbkFv0ckxqTysWceoOL7h+lmdObSWMK1ueOq/hj+4UZyhj756lfWgi/VaIEIkBDOQmn2r0GOUCje0A6qoDeisqSP9zoOzXimilwUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzB6NFh5gXjYN4p6Ty0hfiikW0qooA1FhT23PQ1k3+0=;
 b=uJwCuefMXalT7zchnga+5x1rMWBqJ0MRruk4fiQF79Q7qZ/0EO/NnhKRQXDy8G3yXleWTje1BNuXDW8R/vzge3GJ65vH3aZkp6Pfd7/fVc4LrUCqYsKBKiNZ7jBeX6zjuk4pklGSZKWRljxQg/reuNhHGWmZlOCEnb8nmMGi9kjfb6vaijlCwBzjl0cySKaAabF/XS59j9J/uxFe88TZLVqvlJPlxA/ADD8XyLDBcOrNh/9zmsQzK81EMcORZpEI2DzJ9L+Qr2Lkbx3q6GtOid868PCzGizVmMHTcaCx5NHtQfsZTvGHeza8ohtj9LVewpa7QlFMwzmBtoSU85Y7zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ2PR03MB7403.namprd03.prod.outlook.com (2603:10b6:a03:55a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 03:48:34 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.021; Tue, 28 Apr 2026
 03:48:34 +0000
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
Subject: [PATCH v2 5/9] arm: socfpga: s10: Enable system manager driver for
 Stratix10
Date: Mon, 27 Apr 2026 20:48:18 -0700
Message-ID: <20260428034822.23756-6-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
References: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::19) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ2PR03MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: fdec9acc-ffc8-42ce-dc37-08dea4d90531
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|13003099007|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: dxNYTqFRIDKOlpDB4MkubVGVzcxDlPstUo4CcsYwWO1UvZ3jWPucgwNMgUve2Gs8DHz+xNqRtTz+c1Vr1r7lriaamqZbCsknkl9t06ypOBh2aWtn0sSdm3ctRfquUeb8y5/fc4/XkXdTPECKMaYQnSJs20fhSy+4bdafTsISFJTdkFa+f2B8FB27QNriPLtqElYEZSOPY2M+uzetsPtxDI/NZQS10vQ/s2Ywa3IxOVHrOh+RJ39MmHqQDXv5qOhNLXGoYm6lUdnBwS5Lr/FaEWg1/wyBi4X/g9htasoSLg6AyySoJDgbyMDZaS/pvJESZeycZnqomttLwsH50GIXw4XIC1eoPWIZzCG1oINgn+O+rAu0iT6WSrXNZw3uSs2wSL2ig1VAHjwFnPL5ZrCNdjJKBlxnTPfOj6HGQUcWuJbDTgGDBLhpiX1mnqDKEXrjnyPjiUqwU9AD1SdgvUwaLz1BUuUqdWSYXusHgi7tyYg1naSWoghIKMDrn8RDrJ0lHiqFfW+Qqpq/pkM13vzZiuWB1zSrejU2w/dlhzcMXqpj9cwNaVtOXQz+rI1yurs6Wb6PjGcV4FWY4WEUKfiZ6HC48NWyBQL/4kJhHFD8xgQcFmv/eJ+PBEl1UJjtHz7YcdH4veclBFG7M+CHJFyHXpgov3p4wwHk2488r1xo5WyKUWUchPMgWrdoG2jqaruG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(13003099007)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k2gtKtMDvxuGGynqUAukC8EB2MFQJ9xr7GAK/BQfap62KB9RIrnsSm/VwP+P?=
 =?us-ascii?Q?kV1eSEsLGjmpmD2okfvGEewGuPswOjYmODq5gxJ3zL4mxSBt3n6unNnwxSFF?=
 =?us-ascii?Q?X3Xc4/RjG+uL8l7xoCzMqXPXxjSeXOIy473uIH/duFIZKoqWJi6GZ7g1ZfKk?=
 =?us-ascii?Q?7Gt7+vVkbXQrdzGmDKzj7CsiVS7PObW5bxVJfmiNl13anxWUN7ip1AgSL9VD?=
 =?us-ascii?Q?YBcIGqGbolZ9ubdBhiRnSbyE1nTwFE4Glg1dPvmQCZmpZro2FHl9qL1dChLA?=
 =?us-ascii?Q?NXfGQW0q8/MDQAECG91w39jo9ymjkw+r/RWN7QFUQVUjvPHc/IxFlFLJ8foL?=
 =?us-ascii?Q?aToZb+nGZRwpm3ChocsRg2pOhOZsrMKh570G3luxqNn8OZLHNYHKzu7n8D9c?=
 =?us-ascii?Q?wqt2OunsLNZunUtMt2dI56Dzoc5mzitSInGpOOSm5PputPBGYQjASYanhYSb?=
 =?us-ascii?Q?hxZFYgfkcHlQJmf4ktN1I6cUAtrFzL0EB3NU8wOdixJT7oaAqisSsUx4GpAY?=
 =?us-ascii?Q?ABGff04aGIhz+xfkT/M7dIacDlvbWTXJlx2hqmz8avZQfWjjLza4Icwn7KBK?=
 =?us-ascii?Q?X4jf0w8xrAHQb4OnHAa4TnhsL0h/eGEdYbqi/45AyVzYyZI7v8naTsGAPhWR?=
 =?us-ascii?Q?076Nkj9YriNxR4bn8boZsdG2fTi9GQL3RciL5q2CDZKXmNkzSfH3CQk9tV2F?=
 =?us-ascii?Q?CvK7brZz1EE9vdZDOh839HfXFy6JdcRTdPJD94BDiYR6h/OaaF/m3UxknQKJ?=
 =?us-ascii?Q?T3FtKP91r3DX40inYm4sQC0VrqpfTslREhvsRIQScenYaZ24Yaxou4b4f1uI?=
 =?us-ascii?Q?cpvh+21HPoHhB1Xbwbh8MWtzOlmoB3AXTTFVf0RommPKXWoOyN3bDjPdF1Fi?=
 =?us-ascii?Q?G1ZHXH8LraVmRHrbJ/ZwFFF9nYfdmZRfsW826AeRgJK9cw5rJie85KsLjDv4?=
 =?us-ascii?Q?0qYX+fOETNEzkLO8EvmEqZ1kfuzObNqCC5EB3MrlNhKl4ZPJwaGw0TzYnYHF?=
 =?us-ascii?Q?cxuk09J1SQkDd75VGgt+NVxUgW5A3TehjrrLk+30WogdQl7fDfqDcSXIEJdd?=
 =?us-ascii?Q?wYRnma7iZtjBZFOgHkGMrkNugy9ZeLYT+zxj+zt220cxlWCGhMfQhgm+sMbv?=
 =?us-ascii?Q?3Vor+PdgPEgc/BBMMv6+au7s2HBYuff/hzRcp4cUdEwm5Yd9ghl+WFdznPrN?=
 =?us-ascii?Q?e3m7LBwcqRrrVdTBcMdUVtTvbwXCE9Djk58mbVFahG3EmjGKqSfuRFEAaFcf?=
 =?us-ascii?Q?NL9EC8not/8B7FAgf0dFCmQET3wOcvoBnLBbyz3JShvjNNoeSOT2mBqL91mM?=
 =?us-ascii?Q?Ly09H/APkR/62/4SzQsaNsxqzxXRIOyjzC11xA8WvvDOTcc8Zv47ZM9kS1a9?=
 =?us-ascii?Q?M0vEI31H7UBRYOtNMb1F4eOYevt8wL0/Jx2SVfvmpzVkiU9GEJ3n/1b377fz?=
 =?us-ascii?Q?vLBYeCd2ad4hsHSBRYF0jFwGB5epHQmNr4+n+dHwxwUTJVfvCfdQwyzC6Q9k?=
 =?us-ascii?Q?+Ag3kt6PKxKNU57d10S+0DSNwovTzF4/HMadGKFVoo+29pRzo1F/IpJBF/8v?=
 =?us-ascii?Q?Pb/BB2KYVdlMOLtba559cPdMKCyxKmZMVHsfgwSY4gkQzR4aUmMrCs9Svf64?=
 =?us-ascii?Q?54SUvkbKGNGnGG+oSXsyuUB0kz5h8pKpSFkG/C43bTDkDoIjfwNy0N5lDwNR?=
 =?us-ascii?Q?biZNkC+16jJ4vNSTdVB4fpgIHnnqYbO1eSn6wNZgOH/xw8yKOMSHJe+M/eYo?=
 =?us-ascii?Q?I9lBmrQNFjC13rW0YkmMFVgNi7P7Zed/iEvpmqhuskr79F51DTCf?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdec9acc-ffc8-42ce-dc37-08dea4d90531
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 03:48:33.9391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0e3izUSZrL9GDi9Qvt1v/tice61MBX3qHvx4e5MGvL3fZdsmD0DDTCrB2cJiwbCqffTvossiv71u2jbE0dmCLsOftL9XK6SHF9l1eGwVCc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7403
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
index 056902f6ef2..d1173126fc6 100644
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

