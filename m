Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FF2CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 01:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9AEA846A5;
	Mon, 18 May 2026 03:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ZiEJqFr9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A821F846A4; Mon, 18 May 2026 03:13:14 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 962978467A
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 03:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izPvwJfLd6FTzAyUmY5oeWcn1fD/d4g9/MNrHURotbNcFB+tBIBePbL7etNwfLG4j+NMbRAYteOpbQxUBeqlDjW8IQkKrfof3JKBYraVe/cgSB7A9NURmGCPBvT3Li5uAtypj2IaP3gtjvfWBbnqzOo71YlYxUQRrD3aCkoDXJKwbx7j73RSEwyCWFNyHmCPN/DzdwQWFzWWbot97yTrATjW6zhWsBACgetJfA9fxd2eMSDFDBg8EMUnI/mOsnryqpZ0g8Y7VD0KBRmCDKf2KlMrzCZv9qWOar22iDWG0zXqe/XnpPzSxhKnEo3aTlanKue05a9RktaAWpIMmMhtxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Klf3B8c6v644ajthHgMXVBJW3rSyAXFFNIPElanpug=;
 b=INfOJi7IMvTrNsWWVkAxlTrIIMfF0+CsMW2I6KxYccjaZ2sxsnzcjayEZmA4jscG2cOFNTAzrfI1Sg1odQY3QT2UNYmHc1JMH8C2unTx8jsMixqAiY6V5g6WkHPD1Og5GzUzL9WadKw4qu0t7+RzkxYuI6/ewGuwikO/wJijw8M7MaPkGCOcuiTEy/0e+VeCKg1d6eMfkTWk39aVV+P+XZWbeBSN4NmAqy92+bqGCZ7Oh1W1OruE121qYNS3D66zS47DBMe19kepY9hdpXDQ1qN1BgH838+VvgV4LhWY7yMvfprUoBGUIwLMJaNjjJEAZwdNp3tNBRq0674HyL8y1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Klf3B8c6v644ajthHgMXVBJW3rSyAXFFNIPElanpug=;
 b=ZiEJqFr9uriMqCQEF9QdGoQAvwYQ7fv4oCbXxluoqmIPbMVpLxaWIv7vOcgC9WFA7TH1GFovlq1adCkEXC20+e4RauiKLvscl5kXoJwQV9GNIPZLPXw2YQ/bheCwWg8Agfu0TpD6426KbU8cGW2VykFDtnej0G8czWM5DAWilj9w0wVn33Y90EdiLuVpgN22IwuKr3mHlc19HDXPWP3wmFm7/4QhT3lU5ZgQeoBZhRtMCEeA79Cst4f3o8TgsV6q5yKYsycD+uWHSJ4bnbQca2Qv4DG2d7LuSPIxhng7qUzOJvDWTXwIeyDHNG4qXZeRJ0ExCt2BZPeRhUDbqk5PEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BLAPR03MB5556.namprd03.prod.outlook.com (2603:10b6:208:297::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 01:13:09 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 01:13:09 +0000
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
Subject: [PATCH v3 3/9] arm: socfpga: Move firmware register settings from
 source code to device tree
Date: Mon, 18 May 2026 09:12:39 +0800
Message-ID: <20260518011245.19083-4-alif.zakuan.yuslaimi@altera.com>
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
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|BLAPR03MB5556:EE_
X-MS-Office365-Filtering-Correlation-Id: c754f5a7-62c9-49ca-8ff6-08deb47a9f99
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003|11063799003|55112099003;
X-Microsoft-Antispam-Message-Info: Yw51HjxiX+8iwAcIZ836J1VKuy1bdaNmkKXbz3pVkJvayL89KKUJUnVJTWOtQ2MokCO7g6nSgqc8vOQ18Ui0FcKJhTXyubcLIDqvs0EZ5FJ9qTZx1+E3MAm/SsCuTUq0yopNtPpSnab8R1eL6dFfO+r6n3v30At4BzTeqtIaaLhbGe5+KhpjDSFGP+xx+JL5sj6YRd/NS4zTEasYeDp0Cir8F20iEOLUI+RMxJtkaSN4pfDe5J4YjScWI4fG1zqAcBuo3h0jVRozlMJDcE98wz1G/F5ZbMmzpoCG+LbLHYFgXmr55uBc9Zl8ys6eula1oq7AR/6w97sJuAV4hWaai6tiu57gugK8kBhDgSpn+yPP0M0LcRmm+BkLz6te16pxj/1+bAK0fCsL/0PhsrznoGKEkgD7PWqXj38TyTctC9COmM2m5dHOxuC0Gl6/SLNYXjNsBpbx6Pdz4mupBP/umLYIXb8hnjRhcM4gdLFG8VHxpRJyS2AHjbHeUrtrUpQF67t2QmArK5I52xRTRY0UW/6CskXPMpY8qaIQuQF4I8mZR3DlPNPych17RyhXdjJ0/rm2L43ofUU1WDzC6Si2jm2PjDwfygm3qOpHEFly3ua4FM1VwVao7RGlYnmqqwDvjLITd9VN0oMJ03eXOFDUQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003)(11063799003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PgaknPdS3yrcALRWXLYJ1ngSFeDQ+c2E8TX9Tzp7+tw3nrHL9ApUuf47Tgxa?=
 =?us-ascii?Q?oX0X+2ujmr1S3t0Ld+eRDIcxLbbslRrEh7ESiwlndQMQE5kRMGmIb8xKC1P5?=
 =?us-ascii?Q?y8clBPW1paVmKrQzYpegkn/9sy3/pNcnZTezlYRwsHxiAPYv3HDiJP/tEUes?=
 =?us-ascii?Q?nBKo/3QHdeAdUtUY3nUjjj3pHL2KzDKyt+uCQGpHUk1+WTQhzBXm3oSok+YP?=
 =?us-ascii?Q?NUpTugeAuEZboRnqDWYSonL+w/acXv2NzXOrtLaefGkU53j12+QMz5UkQ24n?=
 =?us-ascii?Q?Vb0S9GFeXShM3yyP8w4DrLZOlvmUKT6H+udv6CHspA+awv5eOI9jUp3wCLzD?=
 =?us-ascii?Q?GCWl1BY2n1Il8nGIWjSA1ZOwwYI30/CffmyUxviueRLunOlb7qHix2iEQFnd?=
 =?us-ascii?Q?1rdNeoDaeg4pk09tjac2zWOHbrwofPvfwwGfcyM02B3T/xI0gmxepkT6yADt?=
 =?us-ascii?Q?y2rbODX/ZKdNh0EW+YWrd0hi/fjNUZH820h1r0p45JZtszM3KdCvaFMlPyWL?=
 =?us-ascii?Q?ChbtW+J1wHjL2x5VEdR2oFEYSNe7T3nhaFV1wwKxQmzXBm6HMu+Xz+9DwwAJ?=
 =?us-ascii?Q?6KkC3f648Rx3CA8297FXEK0Q4aczDZ12x2B9WeA6WVhOd+e5AdMKIURCjlXw?=
 =?us-ascii?Q?HRomexhUz+94n7JIXNckV/Q9pmbBjlLAWKLTIKH9hNG8cTE0f7d9CibjZxvr?=
 =?us-ascii?Q?JRlZ5Ga6k90rLr8ErMTxFrUT38aKHGM1Z+e55Xy2RKSzoipj0YKRfRgSKVwL?=
 =?us-ascii?Q?z9NyXzyyN+fdZiXqiDkcwCEeM1w5fMy/3fzE9vKJYqi8N+oI5udUY+grQmda?=
 =?us-ascii?Q?WJZhMGvNyH4CbBNolcYGBXuKfBk0Ry/9nFiIzhJ6t00Ju0M0SFiczCM5Y+fx?=
 =?us-ascii?Q?xObi6cIxSpgyiw+mvIUenup6qz0tipuT6drKv5HuAwlUFwwV1XEm80Njz5hs?=
 =?us-ascii?Q?06vXCvsCO9zxcO/grhLKw/ZiP0GWQPIkyL27fiRC7/mjGK6H10gru7DRhf0e?=
 =?us-ascii?Q?pRv49M+ELMqKIBs52lYhyYiX5KQwZN9lFm2qRlNAy6VHK/4wqGWDDzWpngWa?=
 =?us-ascii?Q?QSCfwUCNE+O81rltySaTYBWfNrzRjHED6lL2DtR9j3JMBNBP3wzWLzSjqYz2?=
 =?us-ascii?Q?Oq6Eta+m3ylLOmcSUk1k9qeKaecODJbQoC6lV1Vzx5QWed4yn2PJ2tREZ3by?=
 =?us-ascii?Q?rXF9VAeGMSasejLHPkYA+/QHOAHFxxuxO0WC1+ruaZhmQQ40JcqUl+tcCMBy?=
 =?us-ascii?Q?3K0I8m2EGqiSjaHpPvVlEevDvNg1DoXF30nW8mHv5uKB1olnHC1NMkO2e+aq?=
 =?us-ascii?Q?HN8OLgYmUQYpeAEF6nAkyGSJVMcIJuAoJ4/isEXlJmq/CSJBePBZuP1sveGQ?=
 =?us-ascii?Q?2BqCCmjckcK6X3FSx2s/CR9oSUL0lMHqABwea8A+z5ZOXqgrgxvIFvcmJLe5?=
 =?us-ascii?Q?tegRZ2TaYoJPBFk4sgbdiFZQHBoqILwoFH9PFa+MGFPVn8ojRBhN6u8Ouyb+?=
 =?us-ascii?Q?rl85g1cVHtrtdR8p/cqajWgJR1lc0HzGW2gKHow94Ru45R6pG9nE8+3gPTbE?=
 =?us-ascii?Q?3sOqoOlSRhgc2TII9SlPwcdFox6nKzob+q1hoLfzkJrrSXsjQhq/CrNBOccF?=
 =?us-ascii?Q?OJWCWM6PBICcd7VMdpuJpFajyo/jgFP32dcvrnmWj1CBYD6B8k+07jpVduCi?=
 =?us-ascii?Q?CDrXXwjORRC6nNZgMaKVqxJqtuV6ODTScNa4drH81UK5w6yJW3jnVgz9CI0s?=
 =?us-ascii?Q?dmrrLzFRc7E3FJhDZIDMRLMtS5SgCBs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c754f5a7-62c9-49ca-8ff6-08deb47a9f99
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 01:13:09.2594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyUljlTzFnRD0l0Up//KY8pXCAoaS4TwJQNwjh+H8bmG+1Kyoz0SteszCiiQPuLfhIgBgOhlMB1dnvLVoSvAZeajLpP65HzwQ7HdHhXQaTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5556
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

(no changes since v1)

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

