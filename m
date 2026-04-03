Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A977D73087
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 02:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 434AA840AB;
	Fri,  3 Apr 2026 04:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Bojz9BtI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C9D8408D; Fri,  3 Apr 2026 04:25:53 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE0A48408D
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 04:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ku8Yz5JEU/UdoYfYjeyewBfV1XbdIoBGk4WObeAv2z+nM8jPRxAqLLAqw6Nd8/1p2JdAN/4w37AGdWiGRZplABTjQ0gbrg/XFchauN8xZ2cSdO5wjfOzQ6GjMigaPV1rI4wrvgcX9v0hxRm3XHTMNx1RekWZL71PioVvMnMMO02HqRiF9eiqZVNuuzn7YSkMqRobAmtCcpun9q9qf/u8YjDyG9oKBHDlH0tnpOTqxdyCf/xoQ3vw//2Q8/HKatqDVgsv+ZJ9tZpvudKcG+UYZUEfIqMBg5ML6dA8C/1mBorTKavbxz6/WCtOoLOQ/sz16yIGrCI7MNG0CHn/ke5hjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0A0rj6e/TfgLER1MnxlUAdEddJb7avQ02Q1xgC5rVaQ=;
 b=x1rZ34II18MrYDlaWwrqpnKFISxUF41rh/mnDbwdNDRSmtOq8IviHQ+W/+3GdYOYxVZY6pvseGq85oFQzita58x1AVOksHT2TiB9gdNCcmBAIvP0H0BW2kvsGffYWXLmTPLm6+yUlwRYpeVe+hYPwmz0jmSdSU8CBi/2aqJykExs69gf1ivK4kCm3hF3fvtlyBQk+BP+aTENy1eRXAqgFK1r/i9RkJp+46hkXczEb8n3Xj6WM00Xgalg0FkTC0LtPvzhBJiRK1IrHe9TGjJbT1xtSkV9bt8Pxxoy2VcsHGHb2aEir38tHz0+g+BolVakvTZhH5gJNcAoDVTHPIpBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0A0rj6e/TfgLER1MnxlUAdEddJb7avQ02Q1xgC5rVaQ=;
 b=Bojz9BtIGIEoXrjJ3HFWKsIUaG2cyHw4F6EgiXJwJI4a4cJhUslwsvuQv8gWV1pW0dzHQwXnqp83nmIOghPkwmGyT7sC1MclliQtde1sfbXCulDQtiwQ+07R2nfDZbug/GZv0MwPFOK2Jlz4CTXRV2mi5c8IhG+8v+pvXerYbKa6VFcz/VuqohQqd8jqDLT2xHodG8YCN5xwWk7Vo3CQ80IhHO3uDmuHaULTtRcLZF5pzHfL5jPA92DTcjvumh9T/OalDOn2fJM2F8ad0tBu5cVk7SkrAt2+hkdbw0ABlLWt8i5rsyGrZG9ceaxzKoj/p9Ox5565aLXcObUhuTYFfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BN8PR03MB5044.namprd03.prod.outlook.com (2603:10b6:408:7e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 02:25:47 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9745.025; Fri, 3 Apr 2026
 02:25:47 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 3/9] arm: socfpga: Move firmware register settings from
 source code to device tree
Date: Thu,  2 Apr 2026 19:25:07 -0700
Message-ID: <20260403022513.9446-4-alif.zakuan.yuslaimi@altera.com>
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
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|BN8PR03MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: be4abe62-efa1-4ad0-1711-08de91285079
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: +oQza/BjVOdYm2STPCLoMdfemo6Nid8M/hyahi82zGBIdY20N+dwRt57F7NG2RI3a05FuoO9n3Ze/jk9OnQTWSfKe4SlPYWIAmmO0rsDy4k4t2TvAU1pOYTjM3xvah21BsBXFkX0BwPvtM0JEOUPOxv/MMS4XZWPp33A9PsirIm/eHS3GjK41PBfAjnW77v0uaP6wgomcC5hMddvX1P5T/uw12LNkK99VeLio01DcWfQww22zVwVA4HRtupy+TTs+uHiOSeTyDR3FYSoNyLjaUw4gMqJHPmR8IRUubuKAZi5aS9sh41LVoayq+Qmu0tczO68Eab9XFEtV0jyBn1P5o3JctzRt7VSmuW/Kz+TNXLvbJCGXIHgRatSeIxOkD0LDNzuTGqrdtcawJ0y/Hz0fHWkRHz6goNmqB217IZZMi9nRHucVgMu9zhJY98t5qJMIENcUou4iAIqFKg/TjJtkRBPzsyxgmuXFKDhSUdpEQ25yJEwbHS+jNMW7GVIA4QkNe5LExojJ5qVx0apGX6G/UHmE5vpFvKyoq5oTLCicX6KeCu+EpxwoBicyHNL41KwsXBjbVb5JjUs7waF4BI+Md4Wovs5ep8+ZgMO7qhggBO4etFw8WY/IXJyb9HHyJXKwl1YTz1FkVCfNCP/fvVPgUogISB8MVtW79IGL5zzHdIdJpPAuj8zXHuz4GguShu7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?83Djbyp5ep63sJh23zKYs/ieeMFAVxCfqbrVHhk3P9JXeMNh86anTesFesF5?=
 =?us-ascii?Q?fXw+ngB2ZVMCDMUVbI/Y1REVW3TfXxBUqh2X1lXs9DShkw7tOBkM0BXFk53G?=
 =?us-ascii?Q?6xPgyDskFR4LcECKelKbPw+jM+vR91zV4QJF6dYkEjV7M/lSC4D2XbhgiLzU?=
 =?us-ascii?Q?wNEwVm2lkmaOqhTSTPq6mc8xJP8HGgqQ6126QpZBIDayc/nz0TZeSnOm4aYs?=
 =?us-ascii?Q?hRGLjeXwN6X/bMOcY0Hwm0ycBSwnEKzGgG+W5BkBGlEPqtEr6oiSeX5PqczZ?=
 =?us-ascii?Q?DEjcQbb9/+kTORNUkFu0+B6gZHUVcl/4c99PtWGpC666SZnYguJOzIHFCODr?=
 =?us-ascii?Q?1L2pkG9S1ZXN+9ynMDM9o+fhdpk97tnslZv2+/7nbVihMWybxp00FMfebtnW?=
 =?us-ascii?Q?Lkpq+0ElP3a4k1UX1JWr8gSqVrmUIcPhVhH0TzpXLZZGrgKMaIQgNUCPzGga?=
 =?us-ascii?Q?jRqsCdHCMhh/taS9pNCRnRsLRAJcozlYtt3+gTdL4VZQX5z1rFiJZfndCMQT?=
 =?us-ascii?Q?DCG656/Tf7uJ5HKodxQw4NYGKZ1EwZH6nEPy2m27xXrxp1Nw/MisM/xMdC+1?=
 =?us-ascii?Q?RiSuMgz0C9hPoEFB71+BkA0R/8vgaY+nXV0CjpOkE+UJzppNut64deSRtykb?=
 =?us-ascii?Q?jE/bFSIqjL3QDw6gD9GjKXZWAwxLMY8y+3XOfIAGrn2ElQwxIOkgkx54GoKp?=
 =?us-ascii?Q?bnhaIv/eOVBJYPAin85wQPxJJbhT5dLRwk4kS+wSf3AT4n4pSzN9q+nLAJXu?=
 =?us-ascii?Q?OufZ4CDjkqrwVwP1PuYi8jXOJJsuUlPGDSFXss9FvolfSRHV2yY6dRpS/zkC?=
 =?us-ascii?Q?5YBPXiwgfb4Sn7Llc5PcA27aSGrOgm6Z+fNji6B2oT41TTZE34Zj8vN1VKlu?=
 =?us-ascii?Q?sjXNv4kMNZEW86W/WJOU/nibXoF9I3ti3J/l3bax3OZueB7qOcf4eO3XgGrR?=
 =?us-ascii?Q?S/MvK0kkq0HuscejOw/O661zDfu35zjbO+uGyJ3TBb/7P7fenjFAyO8o95AA?=
 =?us-ascii?Q?mRtqW2Iak8qVndA/JRUSu/h7IJ/lv/n7otsBvgNY8Z5WO2FF/OKTbl0+uRTk?=
 =?us-ascii?Q?7ATzfSIlTg4dIAG67Mf2u2P9tRIGq3ck2/BNPopgwE4BPkR4KwdzTV1Nhq3p?=
 =?us-ascii?Q?/ib8sd3InOhxqz6oMjXMrjF77MTkxaSGmX9Uj0fSKUuwy+O/U43IfgLnXuo+?=
 =?us-ascii?Q?rB7s4ECV6CF+PvHRA37l3pKiGc/5/E9jopn43A32+nzfM4cMcR52oNLVIBb3?=
 =?us-ascii?Q?GXDX3j5nqtXwm19EXg4ZGLriJ8I3oqrtuxhPLBF32K6aa+WbkCM2GNDKB27v?=
 =?us-ascii?Q?6gl5sXEXIOEQ6E+aLWlMtS/nMhS1m4uEIEimNI8gmyU1ECaOSHW1zotuf8ZC?=
 =?us-ascii?Q?6oLAEvGrsQntENJC5m4yKIhE7JK7CA0yqhU4HJJ0XHKOn4u8LQfaj5m+XzKv?=
 =?us-ascii?Q?W4QnVCsRrLv4j+iYLfGwANtHR+MWukSRBZpaSYvYbXgrD/ZWkg4va+jROoYK?=
 =?us-ascii?Q?QLf5ghMOCQBj5f5Qr4MlM4egzyYen6Q13BNpSQnCFyFR25iB3OhFC2LQ3xtZ?=
 =?us-ascii?Q?5UEOakRqX/CpvqOl/GgVR2woImf+O9ztc4voHePeNPQrtET/BPad2MrvkHTG?=
 =?us-ascii?Q?xTyAFLWxO+c3t6xDbd2peUYWrvmpi+FwrOJwhBm3YTSvr7o8apxpttH7o/R0?=
 =?us-ascii?Q?unWKtjp0HPoT3gbLuI0At6GNeXKItg7Z6ikXMwNaVd2vduoHCjMsDaW3CHYj?=
 =?us-ascii?Q?cOnRZ2SAw1H1snQ1DB1S9Yr/IWi0Kyc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4abe62-efa1-4ad0-1711-08de91285079
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 02:25:46.9894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upz9YrQTBvmXGwhZ/EkORMUV2TyC2t3auppwHRFabOBfy1GqOmAQHIlWhkxJ+PMmd9ofccPtS632fY7/VJT6fKr0XNfEqa5+lJfDJa/p9eU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5044
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

Migrate the CCU, firewall, and high privilege register configurations from
hardcoded values in the source code to the device tree.

This helps to centralize hardware configuration, improves maintainability,
and allows easier customization for different platforms.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/dts/socfpga_stratix10-u-boot.dtsi | 149 +++++++++++++++++++++
 arch/arm/mach-socfpga/spl_s10.c            |  29 ++--
 drivers/ddr/altera/sdram_s10.c             |  44 ------
 3 files changed, 165 insertions(+), 57 deletions(-)

diff --git a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
index a3b4c0564f9..ad4b383f704 100644
--- a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
@@ -6,6 +6,7 @@
  * Copyright (C) 2026 Altera Corporation <www.altera.com>
  */
 
+#include "socfpga_soc64_u-boot.dtsi"
 #include "socfpga_soc64_fit-u-boot.dtsi"
 
 /{
@@ -134,6 +135,154 @@
 	bootph-all;
 };
 
+&socfpga_l3interconnect_firewall {
+	i_ccu_noc_registers@f7000000 {
+		reg = <0xf7000000 0x00049e60>;
+		intel,offset-settings =
+			/* Enable access to DDR reg from CPU */
+			<0x0004400 0xF8000000 0xffffffff>,
+
+			/* Enable access to DDR region from CPU */
+			<0x00045c0 0x00000000 0xffffffdf>,
+			<0x00045e0 0x00000000 0xffffffdf>,
+			<0x0004600 0x00000000 0xffffffdf>,
+			<0x0004620 0x00000000 0xffffffdf>,
+			<0x0004640 0x00000000 0xffffffdf>,
+			<0x0004660 0x00000000 0xffffffdf>,
+
+			/* Disable ocram security at CCU for non secure access */
+			<0x0004688 0xfffc0000 0xffffffcf>,
+			<0x0018628 0xfffc0000 0xffffffcf>,
+
+			/* Enable access to DDR region from IO master */
+			<0x00018560 0x00000000 0xffffffdf>,
+			<0x00018580 0x00000000 0xffffffdf>,
+			<0x000185a0 0x00000000 0xffffffdf>,
+			<0x000185c0 0x00000000 0xffffffdf>,
+			<0x000185e0 0x00000000 0xffffffdf>,
+			<0x00018600 0x00000000 0xffffffdf>,
+
+			/* Enable access to DDR region from TCU */
+			<0x0002c520 0x00000000 0xffffffdf>,
+			<0x0002c540 0x00000000 0xffffffdf>,
+			<0x0002c560 0x00000000 0xffffffdf>,
+			<0x0002c580 0x00000000 0xffffffdf>,
+			<0x0002c5a0 0x00000000 0xffffffdf>,
+			<0x0002c5c0 0x00000000 0xffffffdf>,
+
+			/* Enable access to DDR region from FPGA */
+			<0x000105a0 0x00000000 0xffffffdf>,
+			<0x000105c0 0x00000000 0xffffffdf>,
+			<0x000105e0 0x00000000 0xffffffdf>,
+			<0x00010600 0x00000000 0xffffffdf>,
+			<0x00010620 0x00000000 0xffffffdf>,
+			<0x00010640 0x00000000 0xffffffdf>;
+		bootph-all;
+	};
+
+	/*
+	 * Both firewall and QOS regs accessed by CPU in MPFE has
+	 * dependency on CCU configuration above.
+	 *
+	 * Below are all fpga2sdram firewall settings with default
+	 * reset value for the sake of easy reference by users.
+	 * Users may choose to remove any of these register configurations
+	 * that they do not require in their specific implementation.
+	 */
+	soc_noc_fw_ddr_fpga2sdram_inst_0_ddr_scr@f8020200 {
+		reg = <0xf8020200 0x00000050>;
+		intel,offset-settings =
+			<0x0000000 0x00000000 0x0000000f>,
+			<0x0000004 0x00000000 0x0000000f>,
+			<0x0000008 0x00000000 0x0000000f>,
+			<0x0000010 0x00000000 0xffff0000>,
+			<0x0000014 0x00000000 0x0000001f>,
+			<0x0000018 0x00000000 0xffff0000>,
+			<0x000001c 0x00000000 0x0000001f>,
+			<0x0000020 0x00000000 0xffff0000>,
+			<0x0000024 0x00000000 0x0000001f>,
+			<0x0000028 0x00000000 0xffff0000>,
+			<0x000002c 0x00000000 0x0000001f>,
+			<0x0000030 0x00000000 0xffff0000>,
+			<0x0000034 0x00000000 0x0000001f>,
+			<0x0000038 0x00000000 0xffff0000>,
+			<0x000003c 0x00000000 0x0000001f>,
+			<0x0000040 0x00000000 0xffff0000>,
+			<0x0000044 0x00000000 0x0000001f>,
+			<0x0000048 0x00000000 0xffff0000>,
+			<0x000004c 0x00000000 0x0000001f>;
+		bootph-all;
+	};
+
+	soc_noc_fw_ddr_fpga2sdram_inst_1_ddr_scr@f8020300 {
+		reg = <0xf8020300 0x00000050>;
+		intel,offset-settings =
+			<0x0000000 0x00000000 0x0000000f>,
+			<0x0000004 0x00000000 0x0000000f>,
+			<0x0000008 0x00000000 0x0000000f>,
+			<0x0000010 0x00000000 0xffff0000>,
+			<0x0000014 0x00000000 0x0000001f>,
+			<0x0000018 0x00000000 0xffff0000>,
+			<0x000001c 0x00000000 0x0000001f>,
+			<0x0000020 0x00000000 0xffff0000>,
+			<0x0000024 0x00000000 0x0000001f>,
+			<0x0000028 0x00000000 0xffff0000>,
+			<0x000002c 0x00000000 0x0000001f>,
+			<0x0000030 0x00000000 0xffff0000>,
+			<0x0000034 0x00000000 0x0000001f>,
+			<0x0000038 0x00000000 0xffff0000>,
+			<0x000003c 0x00000000 0x0000001f>,
+			<0x0000040 0x00000000 0xffff0000>,
+			<0x0000044 0x00000000 0x0000001f>,
+			<0x0000048 0x00000000 0xffff0000>,
+			<0x000004c 0x00000000 0x0000001f>;
+		bootph-all;
+	};
+
+	soc_noc_fw_ddr_fpga2sdram_inst_2_ddr_scr@f8020400 {
+		reg = <0xf8020400 0x00000050>;
+		intel,offset-settings =
+			<0x0000000 0x00000000 0x0000000f>,
+			<0x0000004 0x00000000 0x0000000f>,
+			<0x0000008 0x00000000 0x0000000f>,
+			<0x0000010 0x00000000 0xffff0000>,
+			<0x0000014 0x00000000 0x0000001f>,
+			<0x0000018 0x00000000 0xffff0000>,
+			<0x000001c 0x00000000 0x0000001f>,
+			<0x0000020 0x00000000 0xffff0000>,
+			<0x0000024 0x00000000 0x0000001f>,
+			<0x0000028 0x00000000 0xffff0000>,
+			<0x000002c 0x00000000 0x0000001f>,
+			<0x0000030 0x00000000 0xffff0000>,
+			<0x0000034 0x00000000 0x0000001f>,
+			<0x0000038 0x00000000 0xffff0000>,
+			<0x000003c 0x00000000 0x0000001f>,
+			<0x0000040 0x00000000 0xffff0000>,
+			<0x0000044 0x00000000 0x0000001f>,
+			<0x0000048 0x00000000 0xffff0000>,
+			<0x000004c 0x00000000 0x0000001f>;
+		bootph-all;
+	};
+
+	/*
+	 * Example of ccu_mem0_I_main QOS settings with
+	 * default reset value for the sake of easy reference
+	 * by users. Users may choose to remove any of these register
+	 * configurations that they do not require in their specific
+	 * implementation.
+	 */
+	soc_ddr_scheduler_inst_0_ccu_mem0_I_main_QosGenerator@f8022080 {
+		reg = <0xf8022080 0x0000001c>;
+		intel,offset-settings =
+			<0x0000008 0x00000000 0x00000303>,
+			<0x000000c 0x00000001 0x00000003>,
+			<0x0000010 0x00000BFE 0x00001fff>,
+			<0x0000014 0x00000008 0x000003ff>,
+			<0x0000018 0x00000000 0x00000007>;
+		bootph-all;
+	};
+};
+
 &uart0 {
 	bootph-all;
 	clock-frequency = <100000000>;
diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
index a0d3c96d456..8ab80740c6e 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -25,6 +25,7 @@ void board_init_f(ulong dummy)
 {
 	const struct cm_config *cm_default_cfg = cm_get_default_config();
 	int ret;
+	struct udevice *dev;
 
 	ret = spl_early_init();
 	if (ret)
@@ -67,22 +68,24 @@ void board_init_f(ulong dummy)
 	print_reset_info();
 	cm_print_clock_quick_summary();
 
-	firewall_setup();
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-system-mgr-firewall", &dev);
+	if (ret) {
+		printf("System manager firewall configuration failed: %d\n", ret);
+		hang();
+	}
 
-	/* disable ocram security at CCU for non secure access */
-	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADMASK_MEM_RAM0),
-		     CCU_ADMASK_P_MASK | CCU_ADMASK_NS_MASK);
-	clrbits_le32(CCU_REG_ADDR(CCU_IOM_MPRT_ADMASK_MEM_RAM0),
-		     CCU_ADMASK_P_MASK | CCU_ADMASK_NS_MASK);
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-l3interconnect-firewall", &dev);
+	if (ret) {
+		printf("L3 interconnect firewall configuration failed: %d\n", ret);
+		hang();
+	}
 
 #if CONFIG_IS_ENABLED(ALTERA_SDRAM)
-		struct udevice *dev;
-
-		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
-		if (ret) {
-			debug("DRAM init failed: %d\n", ret);
-			hang();
-		}
+	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+	if (ret) {
+		debug("DRAM init failed: %d\n", ret);
+		hang();
+	}
 #endif
 
 #ifdef CONFIG_CADENCE_QSPI
diff --git a/drivers/ddr/altera/sdram_s10.c b/drivers/ddr/altera/sdram_s10.c
index 4ac4c79e0ac..1497a8e4aab 100644
--- a/drivers/ddr/altera/sdram_s10.c
+++ b/drivers/ddr/altera/sdram_s10.c
@@ -78,50 +78,6 @@ int sdram_mmr_init_full(struct udevice *dev)
 	phys_size_t hw_size;
 	struct bd_info bd = {0};
 
-	/* Enable access to DDR from CPU master */
-	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADBASE_DDRREG),
-		     CCU_ADBASE_DI_MASK);
-	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADBASE_MEMSPACE0),
-		     CCU_ADBASE_DI_MASK);
-	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADBASE_MEMSPACE1A),
-		     CCU_ADBASE_DI_MASK);
-	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADBASE_MEMSPACE1B),
-		     CCU_ADBASE_DI_MASK);
-	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADBASE_MEMSPACE1C),
-		     CCU_ADBASE_DI_MASK);
-	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADBASE_MEMSPACE1D),
-		     CCU_ADBASE_DI_MASK);
-	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADBASE_MEMSPACE1E),
-		     CCU_ADBASE_DI_MASK);
-
-	/* Enable access to DDR from IO master */
-	clrbits_le32(CCU_REG_ADDR(CCU_IOM_MPRT_ADBASE_MEMSPACE0),
-		     CCU_ADBASE_DI_MASK);
-	clrbits_le32(CCU_REG_ADDR(CCU_IOM_MPRT_ADBASE_MEMSPACE1A),
-		     CCU_ADBASE_DI_MASK);
-	clrbits_le32(CCU_REG_ADDR(CCU_IOM_MPRT_ADBASE_MEMSPACE1B),
-		     CCU_ADBASE_DI_MASK);
-	clrbits_le32(CCU_REG_ADDR(CCU_IOM_MPRT_ADBASE_MEMSPACE1C),
-		     CCU_ADBASE_DI_MASK);
-	clrbits_le32(CCU_REG_ADDR(CCU_IOM_MPRT_ADBASE_MEMSPACE1D),
-		     CCU_ADBASE_DI_MASK);
-	clrbits_le32(CCU_REG_ADDR(CCU_IOM_MPRT_ADBASE_MEMSPACE1E),
-		     CCU_ADBASE_DI_MASK);
-
-	/* Enable access to DDR from TCU */
-	clrbits_le32(CCU_REG_ADDR(CCU_TCU_MPRT_ADBASE_MEMSPACE0),
-		     CCU_ADBASE_DI_MASK);
-	clrbits_le32(CCU_REG_ADDR(CCU_TCU_MPRT_ADBASE_MEMSPACE1A),
-		     CCU_ADBASE_DI_MASK);
-	clrbits_le32(CCU_REG_ADDR(CCU_TCU_MPRT_ADBASE_MEMSPACE1B),
-		     CCU_ADBASE_DI_MASK);
-	clrbits_le32(CCU_REG_ADDR(CCU_TCU_MPRT_ADBASE_MEMSPACE1C),
-		     CCU_ADBASE_DI_MASK);
-	clrbits_le32(CCU_REG_ADDR(CCU_TCU_MPRT_ADBASE_MEMSPACE1D),
-		     CCU_ADBASE_DI_MASK);
-	clrbits_le32(CCU_REG_ADDR(CCU_TCU_MPRT_ADBASE_MEMSPACE1E),
-		     CCU_ADBASE_DI_MASK);
-
 	/* this enables nonsecure access to DDR */
 	/* mpuregion0addr_limit */
 	FW_MPU_DDR_SCR_WRITEL(0xFFFF0000, FW_MPU_DDR_SCR_MPUREGION0ADDR_LIMIT);
-- 
2.43.7

