Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3FFE7E36F
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 11:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C79B2840BE;
	Fri,  3 Apr 2026 13:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t+vrOHEx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D7284105; Fri,  3 Apr 2026 13:02:09 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D347F8341A
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 13:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jioFV7BZ/ofiXDjdHzdo0yeIO5tJeDlQ1Z/7RDX629rdom3e0RW74Ny+E1OYaPwUJy1cPezuYwYxcnc6OW/8VqkB43mikL96v0TZdhqu5r0uxHSfVnMTHPpmsbQBWBUjW5sLPPZzCshbGNLDeZ6cC7RaeDIxRNyOfcH+0vumYApd6fC7brG2YPKGkpCuNofdXXZZ+kpt9ji8S9BvNWErv1MNPf5SG0Wqb3b6HeNL8IaE3OFKV7XFaetjv/TCnf/k7wMMtstsBcL17HkGHDTglaPIE8cI73yPAL8MT/OP/P/nz5A8LrAo7cC4w2j98hgylcAxSFEUPe+W1m37pH/6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+UEY382Tz0j7ldUUBmT8HnTG9bYf4fefXdqVo7kndA=;
 b=bTICz/jLZsb9f7Ege3eD0/+EoQh2M3k0TwgH+PXSsHgjfpT7EHH8eGb5V2+/UUMqbCAFgsktL3UslfT+Z3im2S5dKJ36ICxjdE6LOD+NA2Si1zF7be8mpobWmaOa6PLIuU+nV/gyZZ1eSZJD9yW2PLX3/t2EuDfs/pagIxYW2lOE8/hWVvDKa7CgLBtTw9Nk5bWqxc2ni+DBohy850ASrLF8B3FEX0yQQPmkqc1F9REZtn83qsh7lRKwU8QM7SfBu/y/2XXOng3QxI4sf+J/lOCUosbsBmCrc5QC+rhzxWV6Hc3YpvCASdHAFMiO8kWX9fzGqKlH8gEc8o9Xbk/WuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+UEY382Tz0j7ldUUBmT8HnTG9bYf4fefXdqVo7kndA=;
 b=t+vrOHExjG8q65Rgq92CZ9iwtkEJI4tF+o3pgltWPnD+gsdEQ4K2uu+1Y5q1FwNsIRYnRQhLS3NWBzuOkXk25rPp36r2GFYrgTtr2nwtW71jaX1WVzOnVAZ7pwn6oK67fWGfoLE7T9rfEAwiD89Xd3Gpc25pZtF4uAUHHx+bDeRIyGajmRWjnbKUtT8zDJHPJ2sSVGO4xoU8Ajcec2HHxjxgYhnvExnNga13mchoDagSqsyXasUI2MU488xRh6jeF4J7/J0ymahlJDsvxmRhoZVKm1rlZ2A+jX+BNpGvbh51VXkq4CsG3ndNH49e/zzDjAv0s1/VJbG0Nd9oGP4cKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7766.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Fri, 3 Apr
 2026 11:02:03 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 11:02:03 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 03 Apr 2026 17:41:28 +0800
Subject: [PATCH v1 3/3] imx952_evk: Enable ENETC0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-enetc-v1-3-e42ae28ae3fe@nxp.com>
References: <20260403-enetc-v1-0-e42ae28ae3fe@nxp.com>
In-Reply-To: <20260403-enetc-v1-0-e42ae28ae3fe@nxp.com>
To: Marek Vasut <marex@nabladev.com>, Tim Harvey <tharvey@gateworks.com>, 
 Ye Li <ye.li@nxp.com>, u-boot@lists.denx.de, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Thomas Schaefer <thomas.schaefer@kontron.com>, 
 Michael Walle <mwalle@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>, 
 Heiko Thiery <heiko.thiery@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d4b21f-4bcf-414f-8036-08de91706fef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: opxVm0VJx4irsnaO2gvV857hHPxbYpCHBTr708Wy6NbOpfElEI/saRno91D3M2OHJTuQRlExSwTi+9DNjymDSdE0igaKihQx3KJ1FGse4PhwYezo7Stm8Jb4grCQDYjn3TJaJDUUDfURV2i1cZI0/CU1k0MdOGaeg6neP/25FcCty4srkGR9WpQY65V4jUJW74dvTXBtC34BoparLqfDFz/Bwrt593pJ09EP7+if0krPnlFGXpROTkzuja7cPCH7tnzohPkljIMCLpcTXV38tpblJpcIEtkDkpxF1I8569igA11MINKFIG+dRZYIb6uIsl4SKp4l7MdYokaqm6QZglMbiJMc7tug92pzIkNGDF1yCKShaTqaEng/zTmvf5SwVZM59CL41q8MB0uMx/1vYhl6i8tNapaXLPbS2otaot+ftKIUTNRunkqeQIllkJcjeDeF31rw4Ae9ubgvOu6dYvvuMDXofRhnuTXjQbaLgVt4vXaQJBTN0hqHUDIVqhvuHPFIsPwY2YoCj/BZlQKt50PTb5vzSWlIUp+npuAorfDLjjOfqJTOFOzZ2lWg2nTsRCjQ08SAjPXNysQ3NchtArKHhZzt2ms56TrjLMn3WsiUhJS49tAnvkZpiOD+M+1DplZTITFZeOT5JxojmD8MA8hBoEAfwjfaw40arrZjAEwls8zOyP2jjrMKQwwBTF3eW+bFWzfpo33pknqM+IgGM3c/5EN/pnMXxGdTgbLDf4Ljbdk8JroDUKU/MdttrL1857LrAGMKTC7bslyAYQn9+jXvQcpYNitsJ8Wl7JPQsVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHdnaHo3d0VvM0FqbFBkbnFFaDZveFJNYjV6YmgrQkwrOWZPT1ZLbURpR05k?=
 =?utf-8?B?Y21WcldVbmxpQmkxZzBUZjZNQWJLMUl3WSt6WGs3aFpHNy9lVXhmNVIyckFT?=
 =?utf-8?B?c3k1bFNnS3pnM0N2SVdKcHdUR1o2UVVBMnp6MU04aXhlQUxxVm9wazBrU0hF?=
 =?utf-8?B?SjZxdk9rNFYrNCs0cGlVZ2pBWm8rZzhhak1vVjcybUNXRG9XWDBYZ3ZMaklm?=
 =?utf-8?B?dVJNRklmVVI2MERCd3BCYzZXZDVyL2FJTE90QjlFU29mdFRzR1A2aEtFSDZx?=
 =?utf-8?B?VTE0aitobVU2RWJTU3oyT3BwUkQ2cXpCM2JONU4yR0xSUkY3SUFPb01NZ3FH?=
 =?utf-8?B?SURkVkIycmN6a1VETG5ONWJmNEtRbEh2dFMxY2E5RGVEa0plODNjcGhLWXpJ?=
 =?utf-8?B?VEYwRzJkL1FxREZmb0duUWpzMVlRNnJpVWFNdGhIOVBXSTRBdlJXdVYyYllr?=
 =?utf-8?B?cThHcm04MXN4U2RmNzc4NU1VOUxlVWtKd0NORlJmOFh1S3JNS0FTdDcxTzYx?=
 =?utf-8?B?UHFQanRPRmI0RkNXMkZmSTNMY1hkNjhmbnZTVDR2d1VaUmJZUnh0bGdEbUdz?=
 =?utf-8?B?VENnMGJyUmF2Q2E5S2VXc0F1cnVnc2hFMndOdzM5RUxmTWlGSERWVmxValNh?=
 =?utf-8?B?NWhkN2pETjJJTmRLS1pNakozTkQxa3M1cm4wVWpZbGNCMXRpNmVJZ3ZVdTRx?=
 =?utf-8?B?Zm1HQXNJdkpNUFAyUFF0T2ZnWXRvSEp2Rmh5NkdqcGNQdGVQWUdPSWYxMG42?=
 =?utf-8?B?SElPME5UVUxrMDAxd2R1MGg1TThDemtpbTlZMXB3L2J0S0Rpem1oQjA3V3Vx?=
 =?utf-8?B?VDVGdFZwWjN5THNiOWFnMmozdHBrbmNaWHhZbzgyemtLNGZNK1dzZXVQajVN?=
 =?utf-8?B?dUZ1Y0ZDdG5TNUdqS2hwK2dHeEVzRVp1QmI4ZklWTWFrYjFOc2d3V1liNFJn?=
 =?utf-8?B?UERsaW03SGlXd20wN05QaXg4SFRRNTdmMXpXT1JMdEVnRC80YjBDeEU1U3Rj?=
 =?utf-8?B?Y3ZoWml2bk8wOWdyTThXYTdHbXlVS3piKzhOaFBsQUZaVXdJOVdON3p1SU5s?=
 =?utf-8?B?QWxuUXp4c2plSEZoVTlBam0zVitIUlZFOEZhalFjcmlFb2dhVlNhRzFmK2NW?=
 =?utf-8?B?bkJweE1aZlhLQWVQYlQ3OEw4V25KMlpxZEVrQ2lDWk1EZWhRKzZ5UCtxWUZh?=
 =?utf-8?B?WGdQcnF5QXRUNzZ6NkxBQW1TekFXdTJJWm1hYWpwZ0NjL2VSUUhxcndUa0NF?=
 =?utf-8?B?dFFmQzNMS0tQSWN3dktpZmZtY2FOMWN6alFiZWZQeWdBUmMyY2M0MkpJYk56?=
 =?utf-8?B?dkhXRzF1emk2cDE4RHpvTXQyejMyNGFjN09VRW91dW03cEZYL05PM0hMbVho?=
 =?utf-8?B?alVCdlYzUXJMZXFFb1NGdm80bTZCMmd4aWNzRk9PViszM3FIc2plU3ZPcDRp?=
 =?utf-8?B?MDR0UVZwc01yQW93UnRxbGFVQU1DZy9HWGI5K1VuWnZha3NFVDJ3N0xSMUx0?=
 =?utf-8?B?TFRHdi9VVFJwbG5kQmdzN3hmU05sWWVyRHNvUGpaMkxOVUd3OEJkWGJQSWda?=
 =?utf-8?B?ZUlycDgrZEJrb0JjSTd2ZjFtZWFkRTRGYlFQRGxEaE9SSC9hK0wyYzMxOG9J?=
 =?utf-8?B?bGYxNmtzRno0a20wbm1ramxuQklOK3A5VDZndUpqbVIxUWdZSFpGSEc3MVV6?=
 =?utf-8?B?MkI5NHlldXVjem1nSi8wY3pTVHhGakE2b0g0MmREblZmWHZvVGo4Wk01OEVp?=
 =?utf-8?B?cWtnQTlMbTQ1Kys2b1cwd1NTb3NHT2M1RUs4dzk1bW1sZG9UZ2VPbWF1T0JO?=
 =?utf-8?B?Q0djczZwMW1ZSXhVbSs2R1V0OFZNMmpLNzFUZ2JPcUVlRHUrOFlsbkhRR2l5?=
 =?utf-8?B?MFRQWTY5T080akF1NE15dE0xQXo4QTgzcHZGTlNmN3F0RWlSNkNJbnA3bmpt?=
 =?utf-8?B?dG1aZ21JYXJLNFVjQ2pFNUdIY2duTzQ1NE0xaDJsbEZYUHhtRG9HclJlZnM5?=
 =?utf-8?B?SEhPdVY4NXlCMGRLQW1peEtFQ2QwaEtxR2Rld1puOXpuT2VFeXVtRno1Nk90?=
 =?utf-8?B?dUNiVEVYSEpWdTRFS1VobVYyQm9jUUtrcytpR0hNelJWVFA1UlJvMjIvWmF0?=
 =?utf-8?B?d1dSMnlKdDkvdDdhai9Wb1RDRjVhZmY3SHlPTG5TWXVUVEc5TnpWTDBWZmxT?=
 =?utf-8?B?ekZSanIwS3VUOFo4ek1LUHl1ekwrVU5RTkQ0T04ya1Q4anl0TDBMZGtxK29G?=
 =?utf-8?B?MzQ0UzNrdFQwRmZKT0JsMlV4YkpRWTlDaHpYNnRtVzY1b0VuQTBPREJpUXNX?=
 =?utf-8?B?NDNzUDJoS0FtSEZHQ3N0N3J1OHV3RFlkTHVNWkpsV1VGRCt4Zk5VZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d4b21f-4bcf-414f-8036-08de91706fef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 11:02:03.4721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afNZeA4QQ8dxM96hkvoFc9dwqccw0GnjvBN7dPE7ed60MNcflFCIfTCLRzIjGJTPNakBZmibe+6QQIUQrvlTgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7766
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

From: Alice Guo <alice.guo@nxp.com>

Enable ENETC0 functionality on the i.MX952 EVK board.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx952-evk-u-boot.dtsi |  94 +++++++++++++++++++++++++++++++++
 arch/arm/dts/imx952-u-boot.dtsi     | 100 ++++++++++++++++++++++++++++++++++++
 configs/imx952_evk_defconfig        |   3 ++
 3 files changed, 197 insertions(+)

diff --git a/arch/arm/dts/imx952-evk-u-boot.dtsi b/arch/arm/dts/imx952-evk-u-boot.dtsi
index b872c3a7273..2a1770e694a 100644
--- a/arch/arm/dts/imx952-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx952-evk-u-boot.dtsi
@@ -5,6 +5,100 @@
 
 #include "imx952-u-boot.dtsi"
 
+&enetc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enetc0>;
+	phy-handle = <&ethphy0>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&lpi2c6 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c6>;
+	status = "okay";
+
+	pcal6416: gpio@21 {
+		compatible = "nxp,pcal6416";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x21>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6416>;
+		vcc-supply = <&reg_3p3v>;
+	};
+};
+
+&netc_blk_ctrl {
+	status = "okay";
+};
+
+&netc_bus0 {
+	status = "okay";
+};
+
+&netc_emdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_emdio>;
+	status = "okay";
+
+	ethphy0: ethernet-phy@1 {
+		reg = <1>;
+		reset-gpios = <&pcal6416 13 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <80000>;
+		realtek,clkout-disable;
+	};
+};
+
+&netc_timer {
+	status = "okay";
+};
+
 &wdog3 {
 	status = "disabled";
 };
+
+&scmi_iomuxc {
+	pinctrl_lpi2c6: lpi2c6grp {
+		fsl,pins = <
+			IMX952_PAD_GPIO_IO02__WAKEUPMIX_TOP_LPI2C6_SDA		0x40000b9e
+			IMX952_PAD_GPIO_IO03__WAKEUPMIX_TOP_LPI2C6_SCL		0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6416: pcal6416grp {
+		fsl,pins = <
+			IMX952_PAD_GPIO_IO10__WAKEUPMIX_TOP_GPIO2_IO_10		0x31e
+		>;
+	};
+
+	pinctrl_emdio: emdiogrp{
+		fsl,pins = <
+			IMX952_PAD_ENET1_MDC__NETCMIX_TOP_NETC_MDC		0x50e
+			IMX952_PAD_ENET1_MDIO__NETCMIX_TOP_NETC_MDIO		0x90e
+		>;
+	};
+
+	pinctrl_enetc0: enetc0grp {
+		fsl,pins = <
+			IMX952_PAD_ENET1_TD3__NETCMIX_TOP_ETH0_RGMII_TD3	0x50e
+			IMX952_PAD_ENET1_TD2__NETCMIX_TOP_ETH0_RGMII_TD2	0x50e
+			IMX952_PAD_ENET1_TD1__NETCMIX_TOP_ETH0_RGMII_TD1	0x50e
+			IMX952_PAD_ENET1_TD0__NETCMIX_TOP_ETH0_RGMII_TD0	0x50e
+			IMX952_PAD_ENET1_TX_CTL__NETCMIX_TOP_ETH0_RGMII_TX_CTL	0x50e
+			IMX952_PAD_ENET1_TXC__NETCMIX_TOP_ETH0_RGMII_TX_CLK	0x58e
+			IMX952_PAD_ENET1_RX_CTL__NETCMIX_TOP_ETH0_RGMII_RX_CTL	0x50e
+			IMX952_PAD_ENET1_RXC__NETCMIX_TOP_ETH0_RGMII_RX_CLK	0x58e
+			IMX952_PAD_ENET1_RD0__NETCMIX_TOP_ETH0_RGMII_RD0	0x50e
+			IMX952_PAD_ENET1_RD1__NETCMIX_TOP_ETH0_RGMII_RD1	0x50e
+			IMX952_PAD_ENET1_RD2__NETCMIX_TOP_ETH0_RGMII_RD2	0x50e
+			IMX952_PAD_ENET1_RD3__NETCMIX_TOP_ETH0_RGMII_RD3	0x50e
+		>;
+	};
+};
diff --git a/arch/arm/dts/imx952-u-boot.dtsi b/arch/arm/dts/imx952-u-boot.dtsi
index e977014992e..179e287dbf2 100644
--- a/arch/arm/dts/imx952-u-boot.dtsi
+++ b/arch/arm/dts/imx952-u-boot.dtsi
@@ -223,6 +223,106 @@
 
 &{/soc} {
 	bootph-all;
+
+	netc_blk_ctrl: netc-blk-ctrl@4cd20000 {
+		compatible = "nxp,imx952-netc-blk-ctrl";
+		reg = <0x0 0x4cd20000 0x0 0x10000>,
+		      <0x0 0x4cd30000 0x0 0x10000>,
+		      <0x0 0x4c81000c 0x0 0x1c>;
+		reg-names = "ierb", "prb", "netcmix";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		power-domains = <&scmi_devpd IMX952_PD_NETC>;
+		assigned-clocks = <&scmi_clk IMX952_CLK_ENET>,
+				  <&scmi_clk IMX952_CLK_ENETREF>;
+		assigned-clock-parents = <&scmi_clk IMX952_CLK_SYSPLL1_PFD2>,
+					 <&scmi_clk IMX952_CLK_SYSPLL1_PFD0>;
+		assigned-clock-rates = <666666666>, <250000000>;
+		clocks = <&scmi_clk IMX952_CLK_CGC_NETC>;
+		clock-names = "ipg";
+
+		netc_bus0: pcie@4ca00000 {
+			compatible = "pci-host-ecam-generic";
+			reg = <0x0 0x4ca00000 0x0 0x100000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x0 0x0>;
+			msi-map = <0x000 &its 0x60 0x1>, //ENETC0 PF
+				  <0x001 &its 0x62 0x1>, //NETC Timer
+				  <0x002 &its 0x63 0x1>, //EMDIO
+				  <0x040 &its 0x64 0x1>; //ENETC0 VF
+				  /* ENETC0 BAR0 - non-prefetchable memory */
+			ranges = <0x82000000 0x0 0x4cc00000  0x0 0x4cc00000  0x0 0x40000
+				  /* Timer and EMDIO BAR0/2 and ENETC0 VF BAR0 - non-prefetchable memory */
+				  0x82000000 0x0 0x4cc80000  0x0 0x4cc80000  0x0 0x70000
+				  /* ENETC0 VF BAR2 - non-prefetchable memory */
+				  0x82000000 0x0 0x4cd00000  0x0 0x4cd00000  0x0 0x10000>;
+
+			enetc0: ethernet@0,0 {
+				compatible = "pci1131,e101";
+				reg = <0x00000 0 0 0 0>;
+				clocks = <&scmi_clk IMX952_CLK_ENETREF>;
+				clock-names = "ref";
+				status = "disabled";
+			};
+
+			netc_timer: ethernet@0,1 {
+				compatible = "pci1131,ee02";
+				reg = <0x00100 0 0 0 0>;
+				status = "disabled";
+			};
+
+			netc_emdio: mdio@0,2 {
+				compatible = "pci1131,ee00";
+				reg = <0x00200 0 0 0 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			rcec@1,0 {
+				compatible = "pci1131,e001";
+				reg = <0x00800 0 0 0 0>;
+				interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		netc_bus1: pcie@4cb00000 {
+			compatible = "pci-host-ecam-generic";
+			reg = <0x0 0x4cb00000 0x0 0x100000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x1 0x1>;
+			msi-map = <0x100 &its 0x61 0x1>, //ENETC1 PF
+				  <0x140 &its 0x65 0x1>; //ENETC1 VF
+				  /* ENETC1 BAR0 - non-prefetchable memory */
+			ranges = <0x82000000 0x0 0x4cc40000  0x0 0x4cc40000  0x0 0x40000
+				  /* ENETC1: VF BAR0 - non-prefetchable memory */
+				  0x82000000 0x0 0x4ccf0000  0x0 0x4ccf0000  0x0 0x10000
+				  /* ENETC1: VF BAR2 - non-prefetchable memory */
+				  0x82000000 0x0 0x4cd10000  0x0 0x4cd10000  0x0 0x10000>;
+			power-domains = <&scmi_devpd IMX952_PD_NETC>;
+
+			enetc1: ethernet@0,0 {
+				compatible = "pci1131,e101";
+				reg = <0x10000 0 0 0 0>;
+				clocks = <&scmi_clk IMX952_CLK_ENETREF>;
+				clock-names = "ref";
+				status = "disabled";
+			};
+
+			rcec@1,0 {
+				compatible = "pci1131,e001";
+				reg = <0x10800 0 0 0 0>;
+				interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+	};
 };
 
 &sram0 {
diff --git a/configs/imx952_evk_defconfig b/configs/imx952_evk_defconfig
index a700aea67a1..c03f3dec89d 100644
--- a/configs/imx952_evk_defconfig
+++ b/configs/imx952_evk_defconfig
@@ -40,6 +40,7 @@ CONFIG_DEFAULT_FDT_FILE="freescale/imx952-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x30000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_LOAD_IMX_CONTAINER=y
@@ -111,6 +112,8 @@ CONFIG_DM_PCA953X=y
 CONFIG_ADP5585_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
 CONFIG_IMX_MU_MBOX=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_SUPPORT_EMMC_BOOT=y

-- 
2.43.0

