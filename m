Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5002C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 12:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D43782145;
	Tue, 29 Apr 2025 14:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="oLsePsHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7A8D80F03; Tue, 29 Apr 2025 11:54:59 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DF99809A5
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 11:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maajHPaUlUdIZiADAoAAejoodtQ8D6xcVx962KKR96jtVAs9Zy2pw35CfTLyoeRvVvrfRX53Eo1OPYzMR7+LPECw+VdqgdSUbe/0JNAgEws+XpnJfvBPiVfkYHhXLyLuDlN2zy80a8KShswR50uVww+KULy8jHWhlUFJWJfRZDneE+3p6wmaQ3Fwyhl0la52dXwzs/bKGafGgbReJd2aWMKoi3sqCLpnzd3evxF2hsthHvM1MBwpPHSPvIy7dqeynwldcCeMicJ2TpA9Huch/PqkgspwGB5R5Ee29HM5U0SsKs8QwJUVcdxytAdrYOdYP/aw1us6S0MGOs3Um9Hh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uxgb+9NP4cXdlV2HrF+thGzxBGm0jzhuhPmwkX4Gyh8=;
 b=hJyZj2zlxg1+EJF7QesuWO6/7BXtvvdgweMgZBuaC+lTM4b+I855pEeAh+j8gHAp5gVPkIHSeaDCHdcZ5/25t50hk/XSMZWaWSdSA4v1kwTIWzJO2boP8aVN4ILhAQrXi7B0VK/O10Ibp+zfFuesb578emxU9iM7eaQOQImT5ps6ylK/bu8tlnCiKUdFjbsMpyh85gkQvboD79CVGhYSajLSw7UtSzP/efJBKYIypSckpj4GqxDkjXlwuGMaV8vfxGuN7Qe1LuI4PZfzsbLpvOKE0mvPRecU77uDr+0wEP3Gge/ibSWuA/F5VU2iuVaAzhEtPUdMhIiaSVOCNNHYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uxgb+9NP4cXdlV2HrF+thGzxBGm0jzhuhPmwkX4Gyh8=;
 b=oLsePsHYdK2V1ow6Qo8dbQPQ22i2qHatuirVOD/nKHXC+Uon/U486P7xENvH7FMUcxVWoadGWJzRxo2faUIJ/APx/+WOeLunxYh5chY+ROe9JuahI6tStlBGA6zuh+4qiLyv6CEhy6Lo5SESYhsqdPYbflBdIj5+JIettGCb7OV91DwNUHXKu+Mote9W3tfs3lz5Cg55DIVcZJ2QSJviCM1bgCtsfuyJUAJkkMmR+sD2asGBOuUouUoB9lm5IuBiZeHSkUjgUNak12zc8KbXUSis4VE24vR5r7/7iWVit2agfFd27vc9se1UpSzxjHI90Vo10z4qky5NcgRJTOOSig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5621.namprd03.prod.outlook.com (2603:10b6:5:2c8::21)
 by BN9PR03MB6041.namprd03.prod.outlook.com (2603:10b6:408:136::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 09:54:54 +0000
Received: from DS7PR03MB5621.namprd03.prod.outlook.com
 ([fe80::5337:db99:bde7:e33b]) by DS7PR03MB5621.namprd03.prod.outlook.com
 ([fe80::5337:db99:bde7:e33b%5]) with mapi id 15.20.8655.033; Tue, 29 Apr 2025
 09:54:54 +0000
From: tingting.meng@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Danish <danish.ahmad.rosdi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v1 1/1] arm: socfpga: agilex5: Sub-device check enabled for
 runtime workaround
Date: Tue, 29 Apr 2025 02:54:42 -0700
Message-Id: <20250429095442.5811-1-tingting.meng@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::11) To DS7PR03MB5621.namprd03.prod.outlook.com
 (2603:10b6:5:2c8::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5621:EE_|BN9PR03MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a8e654-b470-4773-0dfd-08dd8703e46a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sV2Hyap2SwQix6UQ9GohX+kcKnYbjHO6pygexP67MYHVMzTk1r/AKcSueVlv?=
 =?us-ascii?Q?Mj5WhR7SDiIOibhtgzRXbUbD+XdV8qo3zGMTL523MjmU5sOdAxRQYOKZDNda?=
 =?us-ascii?Q?BHA1LdmO90Ytpu8J5x3jWgsd3AuiNhl7Zfx7rsLD7NIcE/meoen1YmT6PqxN?=
 =?us-ascii?Q?j8p+iRUvDnjc79FA6WCnOBRio/VGG7tk/e58c20QKN4wvrIUEjJSdUUkK8Kz?=
 =?us-ascii?Q?retQbSzJTKcaxLGbORDCUe2rEnos/EcbniK0GRrxYPQyDfPpc/DNqinG+wua?=
 =?us-ascii?Q?4+IvQ821vvyiCfkJjefzpdaCx5/DFeCFKurIWITVLspPBT+MwE0+AWzgU69p?=
 =?us-ascii?Q?Ca8o2kLFpimNf3+DyHKcV5czzmAiX7SzWgpFIoCtUCPzs5K6TgBYx/1uliQz?=
 =?us-ascii?Q?R27tFJsZh21pTKTwF8wL08OP9yLX4Ke2KNFwlhv/RNf5vcnW83CL/eUHeo6Z?=
 =?us-ascii?Q?ppT3lTDmZXFxSwiPl8uyyOG9falux4qSMBma2X+9ZYiu5kzDTCQ57QeBLDVc?=
 =?us-ascii?Q?fkDsEjAFmgP+G/zlBQhlYUwigt6u7wT3yXGomip6mAvdcdv6GfEw1H27f9XT?=
 =?us-ascii?Q?zjsd27wxvEi4+o1Sslvj4jFboZKSukoPfWbc0td/NYrF2UItd1e4lz/wHSlp?=
 =?us-ascii?Q?8+uSWjHJ148vfArc8YYjTuMvbOD/dRQq3gaK9N84mfUixlIcTJdZz/qKP8EP?=
 =?us-ascii?Q?nh0g3DySKD9aBYbM+gVdj8AhBPT20SG1sNfDkcs2eg/sEPFstY+UpuHeikK6?=
 =?us-ascii?Q?bzkI1ACCChR+e3ZNLDR5UYjGO9Ig6X1W6uCS1JgQ4Q1a3bNbOlloR48x1be9?=
 =?us-ascii?Q?mizgLPM5B13Yy+p6lKtrx1EwqxhW5n7V6qRlIwB0hdKJ8CdqBQNAk0+JAQKT?=
 =?us-ascii?Q?iZtwdpXm9F7HjFhXuVZ3b2emBH8/KL1LENloqe10RU8Ug91xeQskFgkCBY64?=
 =?us-ascii?Q?MDz53EBCAOWDknXLaQM6T8qMjdbXPnjBPLYK39CbdSGq+dCY+0I6TaLg2SrG?=
 =?us-ascii?Q?X3aTukTj67qmXC/ej4+GY7w83ZmpYoGezE5MxZn7RyCDevaAFGCqPmqQM7x6?=
 =?us-ascii?Q?0vYWju+OvJGaxM0cz+SnjSqOBqH1K4ONMx/cguOSwe6+iRMQwiGn14RP2D4E?=
 =?us-ascii?Q?0gheEvZDefvzGpX4m9/Gwln9jfLEHqWqTuL9NQIYfL1waq8aPLv5+l7t8OPl?=
 =?us-ascii?Q?59pV8vw27/cbUNc9z5bPy5/kArV+KAeyRdZ6PUg8oLIeU+XizEAY6Eo67J40?=
 =?us-ascii?Q?+d7A1GbmTDEDpFrcR38oUaOgvRatanKuSncBTi8/kGmOyI/rIZ4qxO6wR+Ic?=
 =?us-ascii?Q?I5Mz2ttuUVee7GcgK1IV/4I9ELS8KLOp7Brwxv7tS9faid0KFsrDJbCmI8aM?=
 =?us-ascii?Q?ILbmeIAtkbEqNNYnuWE3HMdeydWzE+i+X6q+50P2yP4e6/QB52+ZLiDAH3Oo?=
 =?us-ascii?Q?052FfH85feM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5621.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ynkBahcVT+erfb4cKBK+4wjrMe1D99RxpqFlmVJ94UIBL/kXY6FeBLlcrvfJ?=
 =?us-ascii?Q?wWWsTtJ251eugA5amvfAVhiwTz7lLj0Y7GTDsQ+dwuJ49O+D7QuYKCkx/+hn?=
 =?us-ascii?Q?7E2XdnrYedegUorM17OgBZcXJCvs5EoUiyEnECp+rLMcrzf+lwJSuaK8xPoa?=
 =?us-ascii?Q?Q9KpZ6bKV0BbM8Dbc6vJGKcyK3avMWuyJg45rplrZuohTM84Q/BeDyH2veDt?=
 =?us-ascii?Q?+7wJBXNNSdHSagScspXp874x1lwlddjaEBc9tv0n8oKoEHnMJNyNXw04BHwf?=
 =?us-ascii?Q?5iHIeZ3ohtMS1cZNxxvbOL9A+d4joW4e2ngQ7/HltNadffnDqO94PIh7jWBp?=
 =?us-ascii?Q?uIcE+acinoNtDCcxkVtS/TdT8mqV8dWGU7U+BRl7W3HXHwiwOeWRfOWQmcPR?=
 =?us-ascii?Q?GGMcvcgMB7GXc0FuS/e5RZ0KtOeiIxYiTiIDVsGW7RWHi3Tn2DCSvw58wKar?=
 =?us-ascii?Q?lrD+0cLGyXQj1dLxfB5K8Nu0wA8m0MnUaGPHWc+dPvDRA3ZISS0QKDChDchH?=
 =?us-ascii?Q?X59OoGcHwalYAZTn2OKQnOgBoDa0bDoa/oSYMipNWFVTd3BPHu7huKf2Hh0c?=
 =?us-ascii?Q?qqvEgiUdX5r+6/vh97Y54CSfwlTFBNFCuG8YkM4vuRz01cUvaVlBYgc6Baoy?=
 =?us-ascii?Q?OJA23OO4bkJ84XVTpI9k+8kIKrYjNrPjhTy6d41IbRxIs+Q8XqCksJvkXkbH?=
 =?us-ascii?Q?PcUu9DU/daqfDJnsUasjBbL6hnFHHxYweWpGH6PLxEs2PxV16AYXPC8w+KOX?=
 =?us-ascii?Q?v+PvpBe7eDGSotU1bP/bnpYVQv2sDPM6q3h4rU8YrZmX0gY4rjGp3QBYbb9s?=
 =?us-ascii?Q?FYB6hfd/HR7hbBSwLPU2JTRpzFlJi04EfENCvcXNDyw6MR8U/iDaZKHYAC+3?=
 =?us-ascii?Q?/prWWJKlG/70xK9YVK9zTQLoJuIf6oQD5BqAc34w6ayq064UmU4NbvBfaHcf?=
 =?us-ascii?Q?rDr4eQFUHGXvOzxP64vHbOfFWnAhAWZ74uawZR8vA7ZiBmmu5zjQsim2hHJn?=
 =?us-ascii?Q?FrbYVQ/WjsRf5u8Zs7pD8yDoOXi3w1hwOi44iK9POtq8prHfGd8ErHRKz2W3?=
 =?us-ascii?Q?cpic47yITNfFRphHRcioLO1D0AM8NpVX9VS4dOlPX0L0bp20jUy1emFyssJc?=
 =?us-ascii?Q?qEe1ENi3Yw74KToNQaqVlcb3PKKthQ/9IuNsiWrrfiZCPUdR6OhNr4QTeulf?=
 =?us-ascii?Q?Z9nELUv2ycJ8oW/IHbe/6/6AfAoXXE5I02FGodlEcJY+hTdX9hnJq0OxsJve?=
 =?us-ascii?Q?iHto6uu+j6iya3CMW7n7+YxcTw7ruIay5Kiagt11dXGOY8Mw4/TNkV7eaPWJ?=
 =?us-ascii?Q?vIUXbF7WR6rbFy66/oLMR2HZDlS+O6nWNf5vl3D4vG+WKLoHKR0CrYdtqvwk?=
 =?us-ascii?Q?xCO81i3jzZ/jOfVg+7BR+IIF0e57s8mCAyl6IuJO2UUG7t5tJiLoEyWTP3h0?=
 =?us-ascii?Q?WxvDvHoXY2T+HCS+jaU/kLg8/jr39UZxn1uA+65AnD0b0g+F3IuEgLNIYO/J?=
 =?us-ascii?Q?9aGCSFEfhBll9KPIcJULQ3QwYuG68673JR3wDSD8b03yXkIyRjrKxumbqS0z?=
 =?us-ascii?Q?B1j1tESN3S5Ft1kqBaRTpn2d5sX1e/LaLSULkH4hbx9uqPe9tzlci3MugKjs?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a8e654-b470-4773-0dfd-08dd8703e46a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5621.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 09:54:54.4174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSm1dUK9MaAYt4e4SOFCmp2/7d4mFltEsZCnFzi4S8CG385K43mURuBe/XllBT9DB730qoHHd7Wh6/PGL33Fzubs7GI83dywIlsTW9rKNDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6041
X-Mailman-Approved-At: Tue, 29 Apr 2025 14:26:17 +0200
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

Sub-device information is retrieved from the JTAG ID in Boot Scratch
Cold 4 Register. This interface is introduced to allow device-specific
errata workarounds to be applied in the future, based on the detected
sub-device type.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
---
 arch/arm/mach-socfpga/misc_soc64.c | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-socfpga/misc_soc64.c
index 4f080f4f0b3..5222b384434 100644
--- a/arch/arm/mach-socfpga/misc_soc64.c
+++ b/arch/arm/mach-socfpga/misc_soc64.c
@@ -22,6 +22,22 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+/* Agilex5 Sub Device Jtag ID List */
+#define A3690_JTAG_ID	0x036090DD
+#define A3694_JTAG_ID	0x436090DD
+#define A36C0_JTAG_ID	0x0360C0DD
+#define A36C4_JTAG_ID	0x4360C0DD
+#define A36D0_JTAG_ID	0x0360D0DD
+#define A36D4_JTAG_ID	0x4360D0DD
+#define A36F0_JTAG_ID	0x0360F0DD
+#define A36F4_JTAG_ID	0x4360F0DD
+#define A3610_JTAG_ID	0x036010DD
+#define A3614_JTAG_ID	0x436010DD
+#define A3630_JTAG_ID	0x036030DD
+#define A3634_JTAG_ID	0x436030DD
+
+#define JTAG_ID_MASK	0xCFF0FFFF
+
 /*
  * FPGA programming support for SoC FPGA Stratix 10
  */
@@ -42,6 +58,22 @@ static Altera_desc altera_fpga[] = {
 	},
 };
 
+u32 socfpga_get_jtag_id(void)
+{
+	u32 jtag_id;
+
+	jtag_id = readl(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_BOOT_SCRATCH_COLD4);
+
+	if (!jtag_id) {
+		debug("Failed to read JTAG ID. Default JTAG ID to A36F4_JTAG_ID.\n");
+		jtag_id = A36F4_JTAG_ID;
+	}
+
+	debug("%s: jtag_id: 0x%x\n", __func__, jtag_id);
+
+	return jtag_id;
+}
+
 /*
  * The Agilex5 platform has enabled the bloblist feature, and the bloblist
  * address and size are initialized based on the defconfig settings.
-- 
2.25.1

