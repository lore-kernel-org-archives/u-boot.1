Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A003EC87FDA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B27A83DEB;
	Mon,  4 Aug 2025 03:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="T33CVb1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC50E83D5D; Mon,  4 Aug 2025 03:25:21 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C8C083D5D
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PphO0/4Qwlm1qhw+b3lLA+XDSM7loCDpFbSX0q1222N6q1Quwdi+VO4K4YQaBGuIxrXYh/hCmAtD01A6QvO+SqmRiapDNk73QWoulALvq1j0ebEFq26wdw8dz8RllAwouoLB1oj17Qlv8sH4Z2a8OQX7GWDcr87QTnlEgLhKyQ/ZSL2lH3iFYhfYZW/+1Muk4ZLz2UlbN3LMEDEsHTHS+xavJ7u1czBS/UjDZVqzg7mBVZbJPGS2lxYxB6R7YdP4WZ19R8lZGNbdzphcq6RXE/9GhdPz+YfvMM6Tp31S2tnjcmF84nQ+JLQtalmO/G+jbr4aeOno3RHI7LjCBydo/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAoP6quYIukObC81x0A3cgUraQUyzU0Aemvk4/j6XWE=;
 b=REh1gyu177RJBdKosbCj9g+dN0qbWOkEWrjd66ssMHA2waPMPdPXTWUcDhjIzPMz3uvR83Srprqw3csSqD48a6+RJKTjFV/Dv5D5PC1K5FtQhomBc1prVjm4v58dtCP0t7CjQiD2vKlU4py282tlVRG7JxZTHldBamrugxKZt+ScOt3ZrF09vnOSjild2xk7NQSNVVHAmXYmcURq93IAUF8qez0Cd4EQpmNBCiIUan60oIVnd81l2KdezkrzeW+81M53v0+QeXxgwxC/OPJwGwlptnlgnqMtBA17QmiGnaJCv5Zkn5y+X3RVXlGQKGCDWUVYhaZU9Jej2K1TY+NH4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAoP6quYIukObC81x0A3cgUraQUyzU0Aemvk4/j6XWE=;
 b=T33CVb1EvTCYI6kbXPQCd+38X3btsJPk7R5uruTWbZIZF8zoAl5If7KM65q2bo7AZPxtyQRZPjA3AekTn/PhE+SQr6FcCu76ope0WYyHVtzN2b95PBHszJU9fU9SBmP+weIrRxLVZNveoqWUuKyu62zjpzZYd22XLZup6zuhJi+Al0zAF/lU9DfmbLIDE44pf6yoRG+H+8eAWeJ+kEdYATuqdwjHdKj9AhAqBwGYFXcMfJ8kpSnzDtNgEv4rlbYmyb1Gc5KYiqQKjNAahW3yRdrrOkUp9mQ9x2FcNdh3DaZB6znyIxTxs7toljffItPk5KxZmnCId9lK9CUJymjxeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MW4PR03MB6346.namprd03.prod.outlook.com (2603:10b6:303:11d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 01:25:16 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:16 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 04/34] arm: socfpga: agilex: Probe DT for firewall setup
Date: Sun,  3 Aug 2025 18:24:31 -0700
Message-Id: <20250804012501.21811-5-alif.zakuan.yuslaimi@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5e5ca0f5-dbb5-4235-7a84-08ddd2f5c444
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qOb1fUl77HsTMTn6qvsAfvWKSqW3xusHvPGpXbTdivwGZzy7BFFWjk082NEI?=
 =?us-ascii?Q?Yy0zCmagAqvcO892os9en/zEdS4ubhbmruLriRsL5N7nhW2d1G5tx3GoAK3A?=
 =?us-ascii?Q?KyCB6UAJ9Kcthv+DtLEao/IrTL5mR+oQJANCY3qN9UtBde00u3cSuIKoPD1W?=
 =?us-ascii?Q?Pi1ABMXLg/osiKulWJQUHpMY1AVQ09N5YilqhzYM28pIfJVwnzv7eFq2USTM?=
 =?us-ascii?Q?QHhyHGq8ppVscbktdLmdaEv6FI1/3BW0wwXy2Wdf8ku7DuGaRjFxha1moeDk?=
 =?us-ascii?Q?UqH4+Un9Ia4YTxZJ/s0KrkbKxWuflvi0A6/iWyHrUgZT0Q0EaIGf9K9a0de3?=
 =?us-ascii?Q?0kMnUvG4WLuHhhMqH7djSTN8TelVSSXKn3u7iEAYXtfhNUbEBXjKEZhW0Iyy?=
 =?us-ascii?Q?O0C1sCQfk+FK2suEKCwBZjGX8Rwol3fPFnfX2bYUg9WN+ZtfFNL/gVq1zqIG?=
 =?us-ascii?Q?1sweHYYhwR5MzJN4YZH+n7CI9XBasoOSFDZOrd0RIhlvWuuLXr5XCGREBYNk?=
 =?us-ascii?Q?eNe3AidhtH95G+lflqGMpnmn6l5muy8zC5QrFGTZ1cyXVkJOIAfXb1h6i6rN?=
 =?us-ascii?Q?2G1aGRlc/VKx6gN2gTwk1BB7aALQ0qayqj2xYbHwQbw0A8g2B0FSxouUnmZA?=
 =?us-ascii?Q?05WjBnfjoPVlQUeVoemwXPe0XSsetsy7QM302Sof2i4nN+hC/UYN71+L+ErF?=
 =?us-ascii?Q?FZSae0Nba00HkoELVQJ9SzrEa/QRWlGKLuWnYthbUkXhOagfyVa+QqSKr6s5?=
 =?us-ascii?Q?0J1nZUlySlLy/xJ773GD1uFwAXaZjnrE2lqJvvxyKNFVT8+IWBWVlPmIe+hw?=
 =?us-ascii?Q?nWWu5b4VqIlqlcO9sr+lmA8dUdg6NHVFz0brJBcdbe6aoMYHgJQKmd5n/YBL?=
 =?us-ascii?Q?dJyK4DVXHYxg2FujmqTWqqZxOAgP1HaLcSpNlLwrPMJanEI59ZooD7V4ks8Y?=
 =?us-ascii?Q?zfuhkVbR7Dd0ukYZ/eJuWWe4HqAl2QucD3Sq8HLOk03b4kLFe43AM+uWYiPs?=
 =?us-ascii?Q?IKMq2zIejFPGluzOc4qaolLX8Teh+HY4isExSVbTFP16nZa+3nxVfQgZlEqg?=
 =?us-ascii?Q?+lYzjuqd650xnPH2EXANLMSeVbnN94XNtBwbkGlMpTbZ1dAUw436V9LY3qJx?=
 =?us-ascii?Q?9mZf9FZBeIpbZYd+JIfNdPAIKwVI8UjqC1aWB+EjfgvpZwjDMQj712H13A3H?=
 =?us-ascii?Q?HAWdPMPYxSiNWKNq42J/tM/46lBF3zG1zKhh/ECIe5cUlX/hRayKw8wh+ris?=
 =?us-ascii?Q?XRBmnmuB59eiYGcPiN/Nc+agF8HRyhP9uZgp0ktkDOw/SEoLmso3KtIVjKtt?=
 =?us-ascii?Q?iCbHNydI7j1hEEOjUNZwogwcoGHKr7xbms5Po2kyHrTaVo7cN61tccdvaKEs?=
 =?us-ascii?Q?9FXssQw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nyxi7VAMZ8ECQwHvAx7KH18/tKQ6LqoopRoqc9V3JmwBfsZzaeGOgmFDgnJ+?=
 =?us-ascii?Q?oX9ixDnh11U2GhWRnF/l+SkdGmOuckoHDAqcyatiPXS6HTiD4BTKYZkom++G?=
 =?us-ascii?Q?e8ozdSLYEcDJYD12vd/nWySiYh/0Q9GxZNhBRq6UmP1LuAkfDA2F4UFqG4L6?=
 =?us-ascii?Q?iG4KQ4nwFFXHC17TtxpCik3/kW0b9/aJcZeU4FQnuTly8ETu0ne9y727DVsS?=
 =?us-ascii?Q?IjUoIt7Xo2wLn9iNZ7ovt2iVxG0p2+Jioed7xYnFPOcw3ur2Jv/7sdgwEsIw?=
 =?us-ascii?Q?dJqKToMxVGV1VJSu7B4XhRNZVNEJVP2xrL4RMLFYAytVz1uN+Gjj+nfC17Tv?=
 =?us-ascii?Q?4wwVvNc+bo6DiAYTxAbbBQNq5VA6v11zssAODrV5gSrCO9g4bd7q285NBQn/?=
 =?us-ascii?Q?spyiyUst9l+r0sowQho8b6y3wfYmWfDwVSZhnIVfUI8htIObkitPvHO4bH5H?=
 =?us-ascii?Q?nItcszH/sc24LUGr9Cl21O1SKOcKA4qr5bOzneqt6miJNnhcGoRSafsB9Q1x?=
 =?us-ascii?Q?/g7uch3WcimmqR4dxVmZ+8iYiLVU1n//fX5vAyh7o0fcAjzFi+tEJuRxsBJs?=
 =?us-ascii?Q?NNlWHamjwOD+nO/ziHEfjumCN/WBLNfBW7BAX8cqkcnQVgBxy4XACzC0YMd4?=
 =?us-ascii?Q?GNUyvUCxYzBwisrYNw48cpQTTRk+zqLXPrjPAqiN0k50y8NxnJMOdF8WBrc+?=
 =?us-ascii?Q?R4XsBPSLZaXFb/ARtYp9kQWc0Aacrpw4qRqpBKcjopR5EDXO31x6L5YPJ3wP?=
 =?us-ascii?Q?6Ilus9QZmBgkwUk0GDazvLlqJyKbGJGqpw65s/OrHmN8wgYIDbj810ViSn++?=
 =?us-ascii?Q?F1uLsDBDjF3KOiA4EkanHnZG+t0I3UXOvtXbA/L+oBHPmEeJZVvJtjr2UDWR?=
 =?us-ascii?Q?hRAPSyygsewCKlLkDjBSPP9laXgv+Gf4TX7QVItwEwO4okO4dWkhU7yNQ8L5?=
 =?us-ascii?Q?oRMCmzWnKGSzazbaXrefspmyN+lSrl4wiWeP9Ofixb1yvMC2R3B8fEU6Fksm?=
 =?us-ascii?Q?WKQHBW8UEc8WF/wl6TyATtgegzoJW3P1DnlgpXi+LCNAVQwzMRpuP/LV8Qw1?=
 =?us-ascii?Q?AEkcTFRnGlWbBCe9lObX7Lr/0LK2K5XvFUaTT0NPEvGQe+rIakcYOJkjxZLn?=
 =?us-ascii?Q?DD6WYkabQvUEN7uUo+ZkQfont0nDrHi9Fs98yFFhgJRNGE0+txsmxiPX4tj5?=
 =?us-ascii?Q?jLY6V6wwhSg3+pfPCKVInS1VdRrB0SsUDmODGLBOdqMnzHqYFqI89/WcTzoj?=
 =?us-ascii?Q?HVm08Q1vCbv6tj8HysUHFH4zAPJ9paURc0Dq9hYb+jmTJpmFDLV/ArggEwBK?=
 =?us-ascii?Q?fLWw4860yOoMOOjN1XezeStzOo16f69csR0Xv7Ct3KsrnM3NYWdUjF4VxfP4?=
 =?us-ascii?Q?p5e6JT5hu9Fvp5qZmTRcSSjuHKaZDj87B/fX3rJS1uVC3Kdkj3TVVzeOyXT5?=
 =?us-ascii?Q?HD1JbK4bnhc+PPtT7bW0BEpZh2yLomt1esERSJEZIntJ87QiLRDGhF5V9Sjo?=
 =?us-ascii?Q?M9n4kt7WjTYXWU9S1CfsJdZbnjuY0+0d2cLDb1jnvWLQe4qO915XjXJltGyh?=
 =?us-ascii?Q?9XD1WlMqW0opUJcT9m9vgT4460hY4Ev4QDS+6Z0ds+cdP09mn/EMZePFP3ab?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5ca0f5-dbb5-4235-7a84-08ddd2f5c444
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:15.9875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uA6uvRzYAh2X/42Hp/pbZvx4RtNjqllmze86jyrb9iPYP6pXa2JlfOulvbjDE9A1HUmHWcpLme7jyskR8XraAHWMCOTVUOCFwf294Y2NKQI=
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

Update Agilex SPL code to implement device tree model
for firewall registers setup by using DTreg driver to
probe from device tree for the firewall settings instead
of calling firewall driver function.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/dts/socfpga_agilex-u-boot.dtsi |  75 +++++++++++
 arch/arm/dts/socfpga_soc64_u-boot.dtsi  | 163 ++++++++++++++++++++++++
 arch/arm/mach-socfpga/spl_agilex.c      |  13 +-
 3 files changed, 250 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/socfpga_soc64_u-boot.dtsi

diff --git a/arch/arm/dts/socfpga_agilex-u-boot.dtsi b/arch/arm/dts/socfpga_agilex-u-boot.dtsi
index 4d7680455b7..890ffc5f7c9 100644
--- a/arch/arm/dts/socfpga_agilex-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex-u-boot.dtsi
@@ -3,8 +3,10 @@
  * U-Boot additions
  *
  * Copyright (C) 2019-2020 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
+#include "socfpga_soc64_u-boot.dtsi"
 #include "socfpga_soc64_fit-u-boot.dtsi"
 
 /{
@@ -84,6 +86,79 @@
 	bootph-all;
 };
 
+&socfpga_l3interconnect_firewall {
+	CCU_coh_cpu0_bypass_OC_Firewall_main_Firewall@f7100200 {
+		reg = <0xf7100200 0x00000014>;
+		intel,offset-settings =
+			/* Disable ocram security at CCU for non secure access */
+			<0x0000004 0x8000ffff 0xe003ffff>,
+			<0x0000008 0x8000ffff 0xe003ffff>,
+			<0x000000c 0x8000ffff 0xe003ffff>,
+			<0x0000010 0x8000ffff 0xe003ffff>;
+		bootph-all;
+	};
+
+	soc_noc_fw_mpfe_csr_inst_0_mpfe_scr@f8020000 {
+		reg = <0xf8020000 0x0000001c>;
+		intel,offset-settings =
+			/* Disable MPFE firewall for SMMU */
+			<0x00000000 0x00010101 0x00010101>,
+			/* Disable MPFE firewall for HMC adapter */
+			<0x00000004 0x00000001 0x00010101>;
+		bootph-all;
+	};
+
+	/*
+	 * Below are all fpga2sdram firewall settings with default
+	 * reset value for the sake of easy reference by users.
+	 * Users may choose to remove any of these register
+	 * configurations that they do not require in their specific
+	 * implementation.
+	 */
+	soc_noc_fw_ddr_fpga2sdram_inst_0_ddr_scr@f8020100 {
+		reg = <0xf8020100 0x00000050>;
+		intel,offset-settings =
+			<0x0000000 0x00000000 0x0000000f>,
+			<0x0000004 0x00000000 0x0000000f>,
+			<0x0000008 0x00000000 0x0000000f>,
+			<0x0000010 0x00000000 0xffff0000>,
+			<0x0000014 0x00000000 0x000000ff>,
+			<0x0000018 0x00000000 0xffff0000>,
+			<0x000001c 0x00000000 0x000000ff>,
+			<0x0000020 0x00000000 0xffff0000>,
+			<0x0000024 0x00000000 0x000000ff>,
+			<0x0000028 0x00000000 0xffff0000>,
+			<0x000002c 0x00000000 0x000000ff>,
+			<0x0000030 0x00000000 0xffff0000>,
+			<0x0000034 0x00000000 0x000000ff>,
+			<0x0000038 0x00000000 0xffff0000>,
+			<0x000003c 0x00000000 0x000000ff>,
+			<0x0000040 0x00000000 0xffff0000>,
+			<0x0000044 0x00000000 0x000000ff>,
+			<0x0000048 0x00000000 0xffff0000>,
+			<0x000004c 0x00000000 0x000000ff>;
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
+	soc_mpfe_noc_inst_0_ccu_mem0_I_main_QosGenerator@f8022080 {
+		reg = <0xf8022080 0x0000001c>;
+		intel,offset-settings =
+			<0x0000008 0x00000200 0x00000303>,
+			<0x000000c 0x00000003 0x00000003>,
+			<0x0000010 0x00000BFE 0x00007fff>,
+			<0x0000014 0x00000008 0x000003ff>,
+			<0x0000018 0x00000000 0x0000000f>;
+		bootph-all;
+	};
+};
+
 &sysmgr {
 	compatible = "altr,sys-mgr", "syscon";
 	bootph-all;
diff --git a/arch/arm/dts/socfpga_soc64_u-boot.dtsi b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
new file mode 100644
index 00000000000..0164d1a713c
--- /dev/null
+++ b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+/ {
+	soc {
+		socfpga-system-mgr-firewall {
+			compatible = "intel,socfpga-dtreg";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bootph-all;
+
+			i_sys_mgr_core@ffd12000 {
+				reg = <0xffd12000 0x00000230>;
+				intel,offset-settings =
+					/* Enable non-secure interface to DMA */
+					<0x00000020 0xff010000 0xff010011>,
+					/* Enable non-secure interface to DMA periph */
+					<0x00000024 0xffffffff 0xffffffff>;
+				bootph-all;
+			};
+		};
+
+		socfpga_l3interconnect_firewall:socfpga-l3interconnect-firewall {
+			compatible = "intel,socfpga-dtreg";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bootph-all;
+
+			noc_fw_l4_per_l4_per_scr@ffd21000 {
+				reg = <0xffd21000 0x00000074>;
+				intel,offset-settings =
+					/* Disable L4 periphs firewall */
+					<0x00000000 0x01010001 0x01010001>,
+					<0x00000004 0x01010001 0x01010001>,
+					<0x0000000c 0x01010001 0x01010001>,
+					<0x00000010 0x01010001 0x01010001>,
+					<0x0000001c 0x01010001 0x01010101>,
+					<0x00000020 0x01010001 0x01010101>,
+					<0x00000024 0x01010001 0x01010101>,
+					<0x00000028 0x01010001 0x01010101>,
+					<0x0000002c 0x01010001 0x01010001>,
+					<0x00000030 0x01010001 0x01010001>,
+					<0x00000034 0x01010001 0x01010001>,
+					<0x00000040 0x01010001 0x01010001>,
+					<0x00000044 0x01010001 0x01010101>,
+					<0x00000048 0x01010001 0x01010101>,
+					<0x00000050 0x01010001 0x01010101>,
+					<0x00000054 0x01010001 0x01010101>,
+					<0x00000058 0x01010001 0x01010101>,
+					<0x0000005c 0x01010001 0x01010101>,
+					<0x00000060 0x01010001 0x01010101>,
+					<0x00000064 0x01010001 0x01010101>,
+					<0x00000068 0x01010001 0x01010101>,
+					<0x0000006c 0x01010001 0x01010101>,
+					<0x00000070 0x01010001 0x01010101>;
+				bootph-all;
+			};
+
+			noc_fw_l4_sys_l4_sys_scr@ffd21100 {
+				reg = <0xffd21100 0x00000098>;
+				intel,offset-settings =
+					/* Disable L4 system firewall */
+					<0x00000008 0x01010001 0x01010001>,
+					<0x0000000c 0x01010001 0x01010001>,
+					<0x00000010 0x01010001 0x01010001>,
+					<0x00000014 0x01010001 0x01010001>,
+					<0x00000018 0x01010001 0x01010001>,
+					<0x0000001c 0x01010001 0x01010001>,
+					<0x00000020 0x01010001 0x01010001>,
+					<0x0000002c 0x01010001 0x01010001>,
+					<0x00000030 0x01010001 0x01010001>,
+					<0x00000034 0x01010001 0x01010001>,
+					<0x00000038 0x01010001 0x01010001>,
+					<0x00000040 0x01010001 0x01010001>,
+					<0x00000044 0x01010001 0x01010001>,
+					<0x00000048 0x01010001 0x01010001>,
+					<0x0000004c 0x01010001 0x01010001>,
+					<0x00000054 0x01010001 0x01010001>,
+					<0x00000058 0x01010001 0x01010001>,
+					<0x0000005c 0x01010001 0x01010001>,
+					<0x00000060 0x01010001 0x01010101>,
+					<0x00000064 0x01010001 0x01010101>,
+					<0x00000068 0x01010001 0x01010101>,
+					<0x0000006c 0x01010001 0x01010101>,
+					<0x00000070 0x01010001 0x01010101>,
+					<0x00000074 0x01010001 0x01010101>,
+					<0x00000078 0x01010001 0x03010001>,
+					<0x00000090 0x01010001 0x01010001>,
+					<0x00000094 0x01010001 0x01010001>;
+				bootph-all;
+			};
+
+			noc_fw_soc2fpga_soc2fpga_scr@ffd21200 {
+				reg = <0xffd21200 0x00000004>;
+				/* Disable soc2fpga security access */
+				intel,offset-settings = <0x00000000 0x0ffe0101 0x0ffe0101>;
+				bootph-all;
+			};
+
+			noc_fw_lwsoc2fpga_lwsoc2fpga_scr@ffd21300 {
+				reg = <0xffd21300 0x00000004>;
+				/* Disable lightweight soc2fpga security access */
+				intel,offset-settings = <0x00000000 0x0ffe0101 0x0ffe0101>;
+				bootph-all;
+			};
+
+			noc_fw_tcu_tcu_scr@ffd21400 {
+				reg = <0xffd21400 0x00000004>;
+				/* Disable DMA ECC security access, for SMMU use */
+				intel,offset-settings = <0x00000000 0x01010001 0x01010001>;
+				bootph-all;
+			};
+
+			noc_fw_priv_MemoryMap_priv@ffd24800 {
+				reg = <0xffd24800 0x0000000c>;
+				intel,offset-settings =
+				/* Enable non-prviledged access to various periphs */
+					<0x00000000 0xfff73ffb 0xfff73ffb>;
+				bootph-all;
+			};
+		};
+
+		socfpga_smmu_secure_config: socfpga-smmu-secure-config {
+			compatible = "intel,socfpga-dtreg";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bootph-all;
+
+			/* TCU */
+			noc_fw_tcu_tcu_scr@ffd21400 {
+				reg = <0xffd21400 0x00000004>;
+				intel,offset-settings =
+					<0x00000000 0x01010001 0x01010001>;
+				bootph-all;
+			};
+
+			/* System manager */
+			i_sys_mgt_sysmgr_csr@ffd12000 {
+				reg = <0xffd12000 0x00000500>;
+				intel,offset-settings =
+					/* i_sys_mgr_core_emac0 */
+					<0x00000044 0x0a000000 0xffff0103>,
+					/* i_sys_mgr_core_emac1 */
+					<0x00000048 0x0a000000 0xffff0103>,
+					/* i_sys_mgr_core_emac2 */
+					<0x0000004c 0x0a000000 0xffff0103>,
+					/* i_sys_mgr_core_nand_l3master */
+					<0x00000034 0x00220000 0x007733ff>,
+					/* i_sys_mgr_core_sdmmc_l3master */
+					<0x0000002c 0x00000020 0x03ff03ff>,
+					/* i_sys_mgr_core_usb0_l3master */
+					<0x00000038 0x00000200 0x03ff30ff>,
+					/* i_sys_mgr_core_usb1_l3master */
+					<0x0000003c 0x00000200 0x03ff30ff>;
+				bootph-all;
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-socfpga/spl_agilex.c b/arch/arm/mach-socfpga/spl_agilex.c
index 91c27a5543d..faba0433838 100644
--- a/arch/arm/mach-socfpga/spl_agilex.c
+++ b/arch/arm/mach-socfpga/spl_agilex.c
@@ -66,7 +66,18 @@ void board_init_f(ulong dummy)
 	print_reset_info();
 	cm_print_clock_quick_summary();
 
-	firewall_setup();
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-system-mgr-firewall", &dev);
+	if (ret) {
+		printf("System manager firewall configuration failed: %d\n", ret);
+		hang();
+	}
+
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-l3interconnect-firewall", &dev);
+	if (ret) {
+		printf("L3 interconnect firewall configuration failed: %d\n", ret);
+		hang();
+	}
+
 	ret = uclass_get_device(UCLASS_CACHE, 0, &dev);
 	if (ret) {
 		debug("CCU init failed: %d\n", ret);
-- 
2.35.3

