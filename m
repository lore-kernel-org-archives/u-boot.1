Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AECC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4286B83EAC;
	Mon,  4 Aug 2025 03:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gcn+kePS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD49283E76; Mon,  4 Aug 2025 03:25:33 +0200 (CEST)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC96383E21
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1Q6nSVFTdwx1TXiWaW9x3G5n1htLPN3mIj0aZlHQOnZa583w52WRUEBOAhvyNg7cmIlbY9RBqB26cLYhjqTFYzS5pP0CAJFsVA4hrA4ijgQReuNwlTpJ8IyYDPufFWEI+fTiDfMWVPVLVsvZ45vBk9dfDRAeb/v5dOCNKCZow9Dtg6pia8TbEZe55MXwLovvxoFxMJOCxg+UBdSPaasuxNWWcnxelOgDTFvY3e0oFBrG8B6WU6aCs9TdSKZ3Qf2TEnMziDe+mLzYwPrQAQFFH2s/DFDaAH4UZpqgHFR85L722Lbu6AM//k0KJJLau6l5+FxAm+/VvfIc9LGMRW8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gk4zlXQtnPt2gWww2B9ovf7volHsquiGEDXDL+XNveM=;
 b=vVAoWUofhq7rwqXhbebIeUzF1j860paK5+JB+HMWGXDwflYZjKLR96j22vmmOLD3WAanOJOvsMBoDvpZx3hj1uQTtNPLzGvON+OrRxxZHKdj9E0MOHJJDQMbvSc8SNfu7yD1RJGUdi36KGGT56evwI1p0EvLREbmgENtg+mW1fx5Cr2Fj1r+zrERtMcPFkuftyg8/ZjTKJWdm6lypaARX2IeJ9DjnXRYAovnUjgAJavy4bzopfrX9fug6hT9ZFH9cb2/Q7FsmCLqNWFgV6Vw8S4czGq1EuBsEFeKqHNmjyzV6kRz9cXGwH8oqpNs9QVq3xkmFVhilRys7tRR0x09Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gk4zlXQtnPt2gWww2B9ovf7volHsquiGEDXDL+XNveM=;
 b=gcn+kePSL6jNCbM9mKOSSMoUzA3ZJ1pIa1UsH5ky55KvNcYBUrSAgNeNjmDweeYZs4UXyYWpsDNqVM7i7tA2aQsNbBV4aqLaMj/58SUYGna9zmHaO0hdXxuZ56t5Mxfvd93RqcTsgLBd5Q5k6KhNa7w/ypPZT8kwGvpAZT3wxefAbhuheX6mEg7lvk7/AZtEhaVWwAjd/nttvP7ndl7oa3rDH/POsvLsTl4y/w/m1nDxJLWoa7CKMZ+9oMg62wJ4KA74xnHQdoWj846YlVh9Xc+dEB5bPWspwAnKISaS8g206LZcjbQ4hv0k379Q/61N1a1zbmBk38YC2rjeDerQEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:30 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:30 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 23/34] arch: arm: mach-socfpga: Improve help info.
Date: Sun,  3 Aug 2025 18:24:50 -0700
Message-Id: <20250804012501.21811-24-alif.zakuan.yuslaimi@altera.com>
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
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9c76fe-df23-43a1-3260-08ddd2f5ccdf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rM1XLwrUMFmDO8tmgN/B9nmvbVmiidJoXdg07EH1LeV94AgwuX7Sey6FGq4X?=
 =?us-ascii?Q?EIQeDyJHRyfv+Tyk/99CnI6d3pP2qgD0UTj3PuMVToVu9cyg/evKxpZ7v3n6?=
 =?us-ascii?Q?McHQVWmAVOJapOPGy4KvD8kRrmNiafVj4NCh5119HoghQHyMEgEGqWoh3FQg?=
 =?us-ascii?Q?Uv68pl0BMq8GGU7sfkpuHzI7GESn9Kcp3ND0ta6eyexlB7+rsanKGttDbtBC?=
 =?us-ascii?Q?rCNbR/cqE9I+1cH11x9AZlMLr4GX+w6guEaMsxEuOBnEmTeMDubtV8J2TQJv?=
 =?us-ascii?Q?ZcfJjTLO2bGwKxvgoz3oKIZEA4hCbxmLs89erAIUxXxIBP5nGUUHZPkSQqOS?=
 =?us-ascii?Q?YRuY0UwejeIHKAUGYgLHO6UIBgGvdAo+lFBn3PXAw35tV4R3cBSBIdFisPPw?=
 =?us-ascii?Q?byhegvhHwYY31C1asV4Z7RPYscqXyYkYKCXCq4hhC9/tlYd0opaYtcvk1yKh?=
 =?us-ascii?Q?7MXe3zpi3HeumC62DiQR7a0U9Xc2wulpxrabSG1n/w49VEVxV1fWjEktbiRM?=
 =?us-ascii?Q?U6jMiqx6k5abciurpxmtQ9UNBEuVbyozC5iFHjqujlz+8PSwdorvP2i/tU+R?=
 =?us-ascii?Q?g5lj2E2gxc4gTzyy1MvVocfqQU6g7xUnQPiM8SPtNC420v6RHseFHYd0Pe6L?=
 =?us-ascii?Q?XfVTAC30WVjS1rk7WuzoMSoSFEGfbygmWU3W2IqpTP3Z4D0CwMAnxuUjHEfH?=
 =?us-ascii?Q?QzbzOmgFYXyajnTlM47Snx+h/9a7p2ao1iSblXRE+zKb4RowO+qxHXBKzjlX?=
 =?us-ascii?Q?cs2X2QvrsKbcGKOad2SQU4WzKJdLJ+Zm+dEHVbYlZ8mJwuw9LpNUsSBm+VCq?=
 =?us-ascii?Q?XQu9zzs1iMyPIEfw2/yU5LT8Mrne218R0LtrdFpczYDhvNzCswFDocMd6VsF?=
 =?us-ascii?Q?7M0F64COg2depkWEJr/X3MG1fhCSji0+NvxME620xACHTXtyAMiwlKcFV/1a?=
 =?us-ascii?Q?gfoo6l29VWSfgiK2tcd0nv+49taPnSK6WOyZ1PH9vkEO7vIsD1rRhbUWvY90?=
 =?us-ascii?Q?9zZswre1Pylptm1Fg20z0ZpducKVifrtSC8r329+O3/elF7qFKmXDZ6m6jXp?=
 =?us-ascii?Q?I0sdu2REufn/4Et5K1vrEGcTl+A0aXeNb8BpP6aOUNjmPrqBAzDkh5rOLM+a?=
 =?us-ascii?Q?3KseDvUkvx7EywWAQCAHoJWvJ2qdtX+aGLTG92inBin3pe5QfENE9R1gwzR/?=
 =?us-ascii?Q?PS/M9XGixYI9WxDMnH32YihoQMfIgicQKa4o6n+Vz0tGtF9KcO3pI9CoHXnx?=
 =?us-ascii?Q?iohCYCweLEERBmFyM4B3D9/dYvX8x+9kr2KPrZfUz8Qf8UQ3ZlJyigmupBAZ?=
 =?us-ascii?Q?OEYZEWTZpVXpHVTz0NB26PLf+m4jRdOcqCNDEURXDs5byDkUqmKsSRnbf92o?=
 =?us-ascii?Q?lLuKDmT7xT6HJcboERZ5zBnykcY6WOsUslO8p5jm/5FDIOtoymcCLC8BOu8Z?=
 =?us-ascii?Q?NQm5me9pLAs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JKAJrFrbIq5ci5Fqoh9j9/v0UJ833TqOCp+R+5xmOClKolPmkfNQrpbFebbz?=
 =?us-ascii?Q?FdrTEANa5pMv165jCaxaSiIZpWFK3AvrWU9NKcxr+43TGdXbz34FHfV2eJhd?=
 =?us-ascii?Q?wzgS/0avKP/rSDoPHma36VVYgsIhDSrNEVQEbZ1rvlNRjlaJTcMJ3Pqjjlu6?=
 =?us-ascii?Q?pB1fZ7c2L8V9vTcebiG1HFdcXWYXGD+QtOXDJt2ZCJwmvuopttvDvJlXJvC7?=
 =?us-ascii?Q?OwAO8emCNLdA+zx1UFm3tNiQN4DpSLLFMy3xvlkS8nOQdXU6BgsJBlKSEWA1?=
 =?us-ascii?Q?ncxCTxcPrkRQRgEFZ3mKZELDZFUwDoOnmT1fdAmvprU57+kulnCuhNDY3jyR?=
 =?us-ascii?Q?oPDyjU01lX7dyK/Pc+Q3KjX/0SDzudBwe2LugfrYUgB200brpSWp6jVn2L2I?=
 =?us-ascii?Q?rmPg8CNMSLfoKK0NTTyg9YB743OnlzmqrL25Fxi3CNJUXbSQ7A2AyhDXel+g?=
 =?us-ascii?Q?smC6iVzP9fxQ9KVEGCAR41Ku/ewxRjdsJ9MHwx3/yKtlTagM9oUscTUvxhEb?=
 =?us-ascii?Q?A/VbDhVfjBmQbo5j+3Rq8RXE/UmcpflA++/TnErpFmWwHodbjqrsX+JQcD8K?=
 =?us-ascii?Q?VaWy6t7fr/1V6MXedYNh7WCtjwr87lkkYO/DeYMcGz3CeNxDnLLrRAE1+E+s?=
 =?us-ascii?Q?o01jCa57Y1PZ6QX71J41d5c+tYY/9iA4ADYHg1hFtGOo5lFB0duKrbTpcyBA?=
 =?us-ascii?Q?/VQNGl2xSUKpdK4gypS8ZXNuKwaoHCtn2Fp/mpjDyGlwa3KQ/+O7iglGod5C?=
 =?us-ascii?Q?96yP3nQ4+KwWnEQLbA0/c8B9NFi+aB1OX7VYJjeUO1A2M/tWF054maHeNxW2?=
 =?us-ascii?Q?q2oeYvggBsJwNOHhe76xyZ3zvv8hFu/AbbckqOq371F1S4x98InAd2A5F21d?=
 =?us-ascii?Q?r63jL9u/fjidmPJSY6oTL+2RAJX8i1UgF3MExTWae4gTmeTJsm1zUBWVKa8l?=
 =?us-ascii?Q?J39VQ8cB+4NTS2CONNt2NZd5dOkjAoOPyUN/F3fbG0vBoEXaxXxZ9FxpQtoM?=
 =?us-ascii?Q?BfCZoYXkC2hN9U80hnoCnGAAUxjds7JqbYvOtZAgEQHGXGmfcM65MSQyLN/E?=
 =?us-ascii?Q?AxCyZJTurPXNaDqHEtQP7jkQwfTIszdZgV/JW/wmJehN3jEEOR/pPSlAxMI1?=
 =?us-ascii?Q?9SBbaQAdHc0YdIhYR38Jv+Wcc7gwd3rR+DBoc1CdlSmP/qBEdCGb7EYCM+iM?=
 =?us-ascii?Q?YEeh1Sp2hSfRgry1LuXbFdjXd3lMbKIO4h06fHXt+IPERe/NmuZ6vKBv8Zwq?=
 =?us-ascii?Q?t8iAA5NAUO/UnzQJ6nh8ZSFaQhvkg2Z2Q83EVqQPT+ANxkmlLd0JEm6x9bU4?=
 =?us-ascii?Q?i1FB/6Ut//msTUwKpx9B0CzeKx/seCw2AorDWd6RhkWfdHGq4kLmLHIOCEHt?=
 =?us-ascii?Q?fIyAzV9z99BBMFJKoY/o3dGPaYLC/TDasWQL2GdgWm2g8WHm5DTP084L0Zxz?=
 =?us-ascii?Q?2APDlhuJm8n4Nb+wawHKugzGXIP2QVid6m1DSifHo4irQ0kVlzzBk4adlhct?=
 =?us-ascii?Q?n9k3+BUX2LMAbvNpW8feGWBXRY0MactyiM+vVzhJftShbue46hZwQEvt878Z?=
 =?us-ascii?Q?5nOoVS8x0m1MR98kOMQ6M6U7Fxu2iPLapOSiByOj9YUXorjFMXbkBFEv3F4t?=
 =?us-ascii?Q?jHH+gAxiNRNlcYZwgU0kzxI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9c76fe-df23-43a1-3260-08ddd2f5ccdf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:30.3783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9qzp6WaJ66/RCjqu2P88RQfprCs3vSipGneBMmMUlqR7qappKI58iJx1W+2DwoBZ/Uo7L2xjRLdXVvxmm2duZmM/0RT4WlLBgoAZrc9zc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7973
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

From: Tingting Meng <tingting.meng@altera.com>

To improve help info for bridge enable/disable command.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/misc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index eb0eeb7bef4..a68ddd9e76b 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -223,8 +223,8 @@ static int do_bridge(struct cmd_tbl *cmdtp, int flag, int argc,
 
 U_BOOT_CMD(bridge, 3, 1, do_bridge,
 	   "SoCFPGA HPS FPGA bridge control",
-	   "enable [mask] - Enable HPS-to-FPGA, FPGA-to-HPS, LWHPS-to-FPGA bridges\n"
-	   "bridge disable [mask] - Enable HPS-to-FPGA, FPGA-to-HPS, LWHPS-to-FPGA bridges\n"
+	   "enable [mask] - Enable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
+	   "bridge disable [mask] - Disable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
 	   ""
 );
 
-- 
2.35.3

