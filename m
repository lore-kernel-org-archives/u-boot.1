Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0B9CD6E6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 01:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DC5D849EF;
	Fri,  5 Jun 2026 03:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="slf33AoL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2553B84931; Fri,  5 Jun 2026 03:57:00 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A2108495E
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 03:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beTVJsM9olV+F6Bkafe/fAAQWVaBO1wjmoFDRI4zhD2Eo8DRlNyrqyJALAe7bMnh2Eq48vY28CzbOvgv/rCTLm9/lmNKKOlOoKSElcKfLhgBZzho5D/Zltb8Ng3kW51391KwIsisu4q562aUs333xMqarIHkHn32GiUJ6tN1+F9EPF+0FO6ErgyMgLueMefCjgrgeRY+vRhd+Rm8dx/DKll8+Gtospip/l4/xRjIs5AAL61bN0GoCDpFmdqmqahmC1gmdCsFUvRC/HIlTJbfnrE/FqNfznWaeeCY3r5z6jscDSdWNwOk+9/cpLuXXEUaCDj/GSATnPoTdPaOAvHRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNwl/eGQkBYKPcsdH8D0hUcmC4ESgcTpbU98KP+97zY=;
 b=Z4NCz7QsBp5kQJFVEfZUKNBlZS7q4rxhGM1I1ByKnvNLVp8BoI9UT7RtkfcfW8K7CMHz34Y2KZekVKjhTo41H7IQFAmb6bzqIVeIbtIZUpf2qOj9BTvnoa5zMZ5vmv8OKdHcadAnCXtrdUpStanzpqWKI1W9nDrOkJofcJULSuygzjJX8LiOaVxEPSsaa63jyuWX7HL2AtIS2sgJcIFLWlkCFCKJE6C9BOExhoo3NXnsmoJEe77oYTyS4OjRlJi2HSD38wfby7EhMRKD3vXtsd58Npd2Ey3SK+0n4yZxwMH+clmCwdoOiPzlweUQ6wt/3ZdIbSyRqQR1N1+hWn0/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNwl/eGQkBYKPcsdH8D0hUcmC4ESgcTpbU98KP+97zY=;
 b=slf33AoLfVRcWxUtHnLX5Z6NT4Lb3kyZb/2cYsfj5+OSEBGbCf0gG633dpHLOrscnWiROUh52mLLIkQF2tD/LQKWVby7rVrb1vA0X4Yn3BVWKOwdNZeRGvPAw6WTZwROkyx7H67UUSY6tlDqhndaTVvrT/y9a7Dc9bVi7OtdprQ0JK5JduVQZriAy0uiKQHN3Q4OaG0r+gQnwk/jHeYYAeunU5rrfJ/8jfN9MLfU5K79b8F6/lxZE9ZJG5qY+i0T0Ks/lo+OFQ1V66YCjj/yYgTEoGGC7aP3eGz6cYbVV6YJS0mpyNeGkQZnS2USZmaWeqjnVgkG6Vqo0UzgIE4MwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSVPR03MB989315.namprd03.prod.outlook.com (2603:10b6:8:3ae::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:56:43 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:56:43 +0000
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
Subject: [PATCH v4 3/9] arm: socfpga: Move firmware register settings from
 source code to device tree
Date: Fri,  5 Jun 2026 09:54:57 +0800
Message-ID: <20260605015503.11709-4-alif.zakuan.yuslaimi@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 301a6abf-b25b-47ca-6b26-08dec2a5b136
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: DZqsNLQ8LVbSpQkL/CEHS9EgvluMMfeVFQJnXa3EusKtfhpDq52KFGoUg6ZzfCdLlwMCAG/pR1uRFXpn34Bkp2sronxdSsMaHq33XfCTh06DemjbHIXXZkMIOL91ptZPizkSAO9CMljiXwufW2hJ5JPo2if4ASKxb0MSDAfB/rMPLjcsklds/ZWcfeYnEkSUERFwItgaTsxAduuzj6/OV/1W/BRrKjR0nKJfUk4gU/XiOzJCejR4VsGosIFKihUicdeRQg+Oi/otPQbEYqEAszEP3c+Y27TZugtAbvCOn6jO73QxHSRU6nL0NrzJ53cehGtvlrjXMtkH4s0/yplbmQmI2aoDwMg6mFjkHrGduhXnWRDdcIKnxe8cX4wpt8BXKGKHmLn51/u2Ueyn+ABYaom3/fL//jAGuDqV4LNAlUDvcT21MIhXlbgKfrahUwDFLiBMFoFsejOeWvERSWstuzMwmHHOx0pxZzyVHfiDNlWrS8fJUvHKTLZdHU4nbew5Kog6SstWAvzwSfe7y61R2t2vYuYUSm/YSdX1PfJ8IwNDoh5k3WamCW07Af6k8vWWG8ehHSxpJ6eBeE+A2EL6s4FrZ+HNomoezIJqJhPPjS0PVHT7PE5+0TGMrJaY4X3jdg4eyfXmVkPHoE+VWEf52g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ITOvsZ/BD5lEtxvqs3kinaM5gYsxtRZf2/Itu6qXNKZoVQbUNjcn4+Ud01Df?=
 =?us-ascii?Q?yB30l579EiEo61aXwxh9r0hpAEoBxUUCUmXtILYkDJ6f3Bl0hSN8yyhpL6iB?=
 =?us-ascii?Q?qTy4wxre3ed14/vu7PlZVCma/346pDrL5bdJzpo8PTpqmBg3O7sslw66/QBU?=
 =?us-ascii?Q?+b1uyHc9PvN5FQIjtRnIk693LDkdoU4fbo1ziwHfX1p+HU+8KLsvWuvO0Qhc?=
 =?us-ascii?Q?GLdc5n3doB5YEA3wXT99Og4zQGaLs7Oujyhr8g3RBs0Bpk4FYXZXTJrQWRQp?=
 =?us-ascii?Q?Jwn9RKIHTanmTG/7ZsX3NmFY3ipVHHrNbXlOex+f+6HUwsUIKd7WIkVHJGHp?=
 =?us-ascii?Q?xxLSFAlqylTgUz6pNp+bbOHWwtIn+mpO3HgA+R4HQdkMU/XOLVMaq2MSvWUG?=
 =?us-ascii?Q?oNjPsr29b6Xt1hRRN24mDgFBk9XXwMOdhAFnrwWnFW2h8OiF6l8gJtNmrQSo?=
 =?us-ascii?Q?rtqIA8qIqxE8zq890jgaTHM70Mnv5XWp9idgYfypfyxdu4tv/hslgxcy7KMg?=
 =?us-ascii?Q?yb+LR1MPDPhSvE2caPiVq9bS2IQ0ziAW0yCt7DIopnvSRgo4E8x2dbeDqD3T?=
 =?us-ascii?Q?ExXy6D1+hzwaH4lCH+183MCnyZZjU7jUjrpseYoSo3zpd3QXtuS523vIdTEq?=
 =?us-ascii?Q?HcWL6tZHRrazWMWb4crNJKXEfSFvSrgpmRc+ILzabn51V5qgMFDrKw4o5yxe?=
 =?us-ascii?Q?5/j400jgNeZDqFWnaC8ExuoK4VSc+uN1zZp6MGw3+gtYYVtWeXKeRrDByaNq?=
 =?us-ascii?Q?m5WCtP3OIRrANMKjYdh2ekb/NWeooaC3ZPTK2LO61V2S4N7qzxIDhssFOKmk?=
 =?us-ascii?Q?My+2Mwj9pwhYn2bzlELzSewOFBxOquE6CvlnLiPFGAjXBRjcgcvdcX1VJSp+?=
 =?us-ascii?Q?V0XE4bi5xkPbT0/7QWLBJ4fjapVHu5Z0K3KTgKuVzcPbKrWrbz7pM3TLSsJ1?=
 =?us-ascii?Q?bfWI79yUTOjkcNkCA3RiLiPGZMTbeDLjuRXq5CRY66ubwtlaXdBzFgFi1qtP?=
 =?us-ascii?Q?cUq9KtP0dS8CJB9lo0nHZxN1JncmI5yMSX2xEuhysNepvQ0kylEOIvCzO/8t?=
 =?us-ascii?Q?LoqOlFfGYInEFVgn1JFID1MyPimAyQIWit60wjEKUYqVa4W52I2+pfgJfEd7?=
 =?us-ascii?Q?9+A6fNwKJBjycHYH3nSjQ3cu3Gz34YA3vSsINlll1gWbt+sBFGv3wvFkEAKN?=
 =?us-ascii?Q?21kzYzslff+EfsIzTWh5/zOG4ulPEQoFQlsq61h3Ak5Q4s6hpW8L8T2uN7ML?=
 =?us-ascii?Q?1m7DToVGmrU8vZafbocdrqV+LanNT/or55+V5R742KikV1ycwyUlq7GK0eNB?=
 =?us-ascii?Q?4qqnTrCyQoeLTD6nXTFnyOgaAbw/A1kvDUeAsQpWtWu+jzYE6b8h9wHMWhRJ?=
 =?us-ascii?Q?jzqhLLB9pNpzKq0jID4Z3EWAb4DEf0pfZFO8PLRdl5HrczNHnYtGufKvz4jJ?=
 =?us-ascii?Q?5Teolwnvfe7o6sQT5Eu2oS7rET4cMoprxPAJvq4EBsuPnX7Wb6JIV+GtqExo?=
 =?us-ascii?Q?FLNsyRwQ6CGRglzP2P4D86akwCT4DiXrblEHpjNApXRZlup9ZWrcQ0Nmua9i?=
 =?us-ascii?Q?PT1pahbALiHK7ut5sScuLjwjVVdRplqxpB+DDP45MSIaqfSN79hpkyn8sRXF?=
 =?us-ascii?Q?gNqy0uTOAVKtjfCO2bECNGEolO+0W4h7MDi0t2ZtclXA2bSVHgIvWposreU2?=
 =?us-ascii?Q?bp4RYpmMurMHB9WMVj9/Mtl0AgGTnSFQceF4FYmRHqI4f6zzIP9s8GX2z8t6?=
 =?us-ascii?Q?MWhCsH3vRk5zIAYtn3i2Glf3kpMIVHo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301a6abf-b25b-47ca-6b26-08dec2a5b136
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:56:43.4816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzZ41r/vWxLVqxr2Phc1hm3UoVB3ZnmrcVxMqWMHhJ+rxMeQWkoqn2VyAqb7PA0vE4DNNd7v9lb9+RIuYXyP9a7j4ZNg5mLVUPM/SXQHhS0=
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

Migrate the CCU, firewall, and high privilege register configurations from
hardcoded values in the source code to the device tree.

L4 per/sys firewall setup which was previously done by firewall_setup() in
spl_s10.c is now replaced by DTreg node in socfpga_soc64_u-boot.dtsi as
Stratix10 is sharing the same tables that Agilex uses.

This helps to centralize hardware configuration, improves maintainability,
and allows easier customization for different platforms.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

Changes in v4:
- Commit message improvement

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

