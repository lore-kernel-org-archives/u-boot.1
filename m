Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3420FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7219D84099;
	Tue, 28 Apr 2026 05:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AKVP+gml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45A5C84258; Tue, 28 Apr 2026 05:48:37 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 333B98429E
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1ipCTUqAWC07VBgtvawz99XG6SsD31WzQWBWbL0doptv36vTqOK8EPEe+gmcXP3zlyBwaNezL17hsFn1H/SrNb1XmGqtIsshMZEaq5iN+fZAoW22jO5p/2yK3OLmpraqpgyUk6iV0lGbAHBtVIzCAVNlIxxhY0TGj93ZrcQ7REx7yltnS19cHnjm0H797uclt8yQu30cDifu40lr64YcTqFhj3JEm7Qja4xzO9kEtujIkxQfxy4KJz1/pZ/zQSS8J+feTTiJpuuZTdUPon/Ms69+SCsNlunctCUtyaY0yBRc9lJJUtur0pksguWyEeY2EkT7qdyL4EKyhMK2sy0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0A0rj6e/TfgLER1MnxlUAdEddJb7avQ02Q1xgC5rVaQ=;
 b=MqRHzIheeKuGK+CYh5o70RMzrdRUJjh0v6q2m/ORWpkMOTkkqLvCINugV7KU7uniEMv9t+lQ0cu8v8n6agLOkjIv5aqjMDtZpWQ17wh7ZgfuKghiw5+sMo5jeimxkygS/gaZ/6sO5kmViWBgF1u0xMOxidq0hDs8Nico/mQsEqpDGlnlcQzfIOtBv9c/2HRRy+QKseKP88CAiRDkloIvV32Et6DaRIKc2QABIj52dJjmqTP8cmS7Qt+HoVIZZcfcNIaee8wDZCUpXUPyue7leP+hR9oO4bD4T0kGWtRYOHcdDKQwKf7WUnzIANZn5yDz5/O2cO5q5bFnWo8mReCA1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0A0rj6e/TfgLER1MnxlUAdEddJb7avQ02Q1xgC5rVaQ=;
 b=AKVP+gmlP57AsC3J6MuQazFRwJK98zrEub+ANxLaK32Mi2jVZ2jYp7/4UmqnDkcczj5NScuiIiTb7l2xPTD8wk9/0xUJn3FbxQPdr7SxKBxP5VEtumBkvi/EJMBWdFBJmWhLXEixTP/SSCRG8b604l7fjgw5mP1cKrytJ7yh8MotntTF3hwyvzwSG0IIKLoBkGlXgT2atClhPP7PPWTK/gRX4urFtTCBfYznmOgXnxOA2zqt0xfpq8Bv+kcp/C7kr/r0ASlP6EbbSn8o1O/BEMCyKzRE6Ltgddbq0aX+bBSP8LWBTrcI3qJhzjncDFc7NIpgdkBeSS8Lf78DIbEmCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ2PR03MB7403.namprd03.prod.outlook.com (2603:10b6:a03:55a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 03:48:31 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.021; Tue, 28 Apr 2026
 03:48:31 +0000
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
Subject: [PATCH v2 3/9] arm: socfpga: Move firmware register settings from
 source code to device tree
Date: Mon, 27 Apr 2026 20:48:16 -0700
Message-ID: <20260428034822.23756-4-alif.zakuan.yuslaimi@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4ff641f6-2ada-4993-1aff-08dea4d90380
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: pEQjQs77QoHTUNi40Zqm3p01n9Yk5Gy5FtxRFJg2NOTtWBrKKs9TtraEmRbFNOyp4/yXk3pfCYvCgMTX2q8sp1R0HGYR8zuhB/A31+2Xbf+DujGSEE1+NFjrzCUBPYGLnbHapKDfoy7c/Sz5FcGIbWdxfnXFdqhuk/yDu/2lcM9gAEL+PORrWn50wGsvaYeAeEHMBPe4rpxqii37vXpXTevVFQvWc1VxdPrjo6/fI7blh9lSvstqUu5ndsMrUmxNhIyQXSzHArPnRX7ZD1LPLFVvd2R08coEfNb9NAh+xLFatwdmuJ6Tc2uRJ73feMMxbwPMwo7eTDEbWSkt5c4P29eTGskGtbO+j6OVsEn/sdaVbXZBwriL/i2IzAlVALgFtX71Aps/GWtCUooAyAZVe7+JD1gg2NIECHVH2IWeGaAp8db93xPE453PX+BlvMQlJ04ice9v+5B8qX+h0yeXA0nVzcETImBtEYfcKHKYcz1p6hQU8aOhN46RkZe8+WNP9CwceM+eXcWneP2a18pcnOVytSEzsRlgw4ELT30d8z7CsBrya8VJBUyi7PH/CvN+eLhnMAt+jnzuIy4a9s6APi6hOKIQPt6ceb7FhEHv/Vpfg81iOS4z23fz/DblbrH6GiN05PXa+N3YqfxSEGBRckwD/f2yVx5OvdTLDYjAnzb+Pr60dWhXNqpsbYkJlPBt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DlMvNvDCKtVSMGg73KFs5HNs1KolgM0RQkBcibKzK+RnZV+Chy5lWbb9snEU?=
 =?us-ascii?Q?d8bj/VFqZWDtdUlqyS3eJAm+1g/pxIk1d8JXQ0L5++oCz9MU84iQPEn7GBHn?=
 =?us-ascii?Q?oLNz5gj4+C0IzKyl0rxIxWsx2OmaVtki7kCWEthWsRAznD97f+KiTLoP1B0u?=
 =?us-ascii?Q?0z/pivCBcwq032penQgopCrJrsdHcS7EFFUU59b/l2eNlL5+U04/Gst8ws2W?=
 =?us-ascii?Q?RCME7W1KIzMERvDDBv0aBR0Sp+kKruIekHlsmVWDkmzqsB7Td6lzyG2wjDIi?=
 =?us-ascii?Q?x9c3WNUe68Kb8nSEIraUGOtakQ+vjehGTEXQPF5G8nGpUwJ4lq4vClXSZNek?=
 =?us-ascii?Q?DfQ6SNqMyyekzvunTTrixQhMqU7AAPQhKGd8Af4bidRHNoQAGCsmvGoX/hvz?=
 =?us-ascii?Q?D5VqYoKRQHGMMS6NZpfBGfg7Vqqh+T93r5RZkLUw3t3n63Wb3BDfvG8sULyF?=
 =?us-ascii?Q?fJmGpWC2u47mCZr2lxmaoOJIDspqb31S9rxqWhJtsxCZzC7wef/pF5UIAXR3?=
 =?us-ascii?Q?Leb92DRnRAKZZxsG2L0sv2lqNg7kxv+FNHqjbA+2fMOIGpgKf/WZmaSqZ5Bc?=
 =?us-ascii?Q?oK/yrnNf+n9mICmH0xwZUvdA27/RDTOLg4B7MzNAyVMr5wy+pQwvFbS4YEcC?=
 =?us-ascii?Q?+CkExfG+gf9PvfLtbhBCquuIv0sBPi07d+9t7y49PAfNUhShy3WmIzmzahhm?=
 =?us-ascii?Q?vGPup9DClu4T8U++8OiGC9HlSzK9OnteAilZav3rTygXX+k5yKxFZY2yJQKA?=
 =?us-ascii?Q?O6LtXI3uvwU12j1Q1uvyzKSFEzop/697UDd5EW0dSfIosY8R7jlqryPfKUWT?=
 =?us-ascii?Q?MQyQWWO37snKiZBN33oBXSdk1+kRLHOFeR+3YEJo6Ghy9mNxfvyo6a88QQz7?=
 =?us-ascii?Q?mVKAowp9PBjV6fjU94tuAkYgj7P2h6vF0/CKqwR7tlTQqEvAhLwllVmNc9Ce?=
 =?us-ascii?Q?ZQOwa+lKDVqjfhYqShdUfns6UC7Z4RudNMTEKsbkYl8uB00ZAGw5ztnmphVx?=
 =?us-ascii?Q?CPxKT7pZTK3IZ93ctTdB8jBd8z+OU04uxQplXcqON6B5j06z/magpOf6uLTO?=
 =?us-ascii?Q?obGpfPvU7fmTps2Zj8s+cTCwvtUpWYVwEaB1tbHbY032yj+1V9vsng4RMfV2?=
 =?us-ascii?Q?W//8oB5dxJ0pFKRsdP3xhUxsXvBIMC/u6DETMXVOUGQd4CYscgu4Ga9nKCOz?=
 =?us-ascii?Q?mEoaL9GQ3ARht6E3mQql4xPFtVs/peQdq/z6XvyMjGaERMV99ZpcCr6rYlM3?=
 =?us-ascii?Q?e4fvZ0Ta5rPzmvbp9pDWMCsjhlRm8vvZp36N7OWEwMg/RQq/f8rTKWwxjY+0?=
 =?us-ascii?Q?Rkjuoevkg9KoU59Jx6ZJ2W/1JVN3ZVEp6wHduOGB7jED22FcRE7+EDE+u/nb?=
 =?us-ascii?Q?nroY6V0yiIJe8Z1iQt9Lpdgh5M5RKQbJIrH8F8N1aRvq/gVXUk0Go391DCWi?=
 =?us-ascii?Q?FZBjtPDPQ2QRXmLFE5b/Z6lkFigy7kCOcxeDZ9dj+dzVUkILamK8dH8MP3ur?=
 =?us-ascii?Q?/nEY87sp4tXUDcAYzBkiSzerwocyDf/JA3nTE1ISEDzHI4t+NGJgUQhI1yYc?=
 =?us-ascii?Q?7lEwUCIoEJhJgSZm+0EYlJYm9dkKhSzpwfK1cmb5+qHIpfZcBSBr0b9/EmZ1?=
 =?us-ascii?Q?rcT5G0rNvQ3E0k1uIo3xaqTyv7C4pcE0PZV4mp6nQdFyPJBaBbzTzmXOtMEg?=
 =?us-ascii?Q?7zRbmOk93zptWXANucFwzbbjIBnDb6oCLZdi5uGZqeuswiNAwialG0ojMzLn?=
 =?us-ascii?Q?w3uJx9crXoyncd53bBM6JpuWM9Je/kFr+S8858lqxojoE7cPod9u?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff641f6-2ada-4993-1aff-08dea4d90380
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 03:48:31.0818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5J0Szdl6bUhFvf4zBo5nrL4WpbVBaKdH/rZUjkDwaqxN25RDzrdfGUzsowPCloLY9KYAdqOSBl1fpBgjBEBlqmKxxJLNkKmnKfrLSPSO2uc=
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

