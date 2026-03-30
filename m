Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB9E10D14A2
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 12:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3909284056;
	Mon, 30 Mar 2026 14:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rd10SVZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B850583D17; Mon, 30 Mar 2026 14:48:33 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B71F984056
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 14:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOQQ9Ywz3lip5Yn89WqxDADGUGWIsVeV2mSWLXbXjWfOF4lyqcSZH+sOFbm0s1xnBichsrQDjGeLGkmkENcfP0wDE8m57V8sdmrqE3MtYwuj8wUg7ZPTb/n8b7DGRJ17BbF73flJYvfLLKZgjXrn6OXOXrt8cI55ArWH0axoJMQm8auAcRhtqs5lUiwxiILHEk+JFbIPsnqNbAJyWWr/k89SLmHfbBFhmGbsL1txua7FD2OS42CGTiq+mBgeONAwwbJ2FVLl/7XNxbQUQU6xgyBszq4uBWXPVT0RCnL4AEZyeymXdT6cuLQ+KTcQcvJ/P2LDbQA8WvcaZES4IKGpIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFOu849W6a+kccuGM98h6frY19YANyaM2ivtnC3OQdc=;
 b=smKmb6JBGFQ/5NFUqHl30VTTpbNCshZUvhJGWGYobZaXMIpT2X9UfVWbVTNd9TwD5XocZNYpA8l/YvcHHDaFx47bh1z8PRsD3PJ5TfI+266ifrXddLO9yio0UuzXJUoePMVojS0INIz8pjFOPbjfrpbuTr8WbVNgdxIWsv7v2jsb7UOh1mpDLQJLmzFFqpJ7kubLPcm1H+48eO8g4TUhBOEyQYOY1pmgI9I2namnNAdB95Sz0PL6E3QDrfayN9/sNhEY0/G/ARNgJCtw9mKlHG85HsDpQ8aX95tJzTmM/C942DONKCxZ8JV5HjTUiNkMFniQs/bVq8FZIENymBaKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFOu849W6a+kccuGM98h6frY19YANyaM2ivtnC3OQdc=;
 b=rd10SVZ+R6bJMfBu/7X5cRwKAEtgF8slRNPlkNMTW6QoXsBL1Xz2wlc4eXYSDyEWMFTOMUyKwpqyOjnom8qoPIz4GlcujWRGcLpPKdvCgo+1DGUTnOrAYkUi3uw/Jlued6WUyEfiTrSvFQNOwQic3nZzdkdkzySNI/xpDgi0z07ONv0REkjeBJxM93Kd0XBoxisIGaSWVhVL9TXMQF5xauaeHQVSMETHvEROrVUqi1P19U9agIfgHhC60g7Z/gDB1jTkmm71wwhcCePueDszsmPTfDlKn4U8t1ZkABTIIYoRPI7UedCX9s4Cn3csUQOZdHzvA19SAAoo330FP9W6mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9962.eurprd04.prod.outlook.com (2603:10a6:10:4c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 12:48:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Mon, 30 Mar 2026
 12:48:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 30 Mar 2026 22:04:06 +0800
Subject: [PATCH v2 4/4] imx8mp: icore-edimm2.2: Convert to DM_PMIC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-power-legacy-v2-4-47dde3182a2c@nxp.com>
References: <20260330-power-legacy-v2-0-47dde3182a2c@nxp.com>
In-Reply-To: <20260330-power-legacy-v2-0-47dde3182a2c@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, upstream@lists.phytec.de, 
 u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Teresa Remmet <t.remmet@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>, Yannic Moog <y.moog@phytec.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9962:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb52221-b02a-4c25-62be-08de8e5a931e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|7416014|52116014|366016|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: GEOC5GxbkOXDJUkgo5wblCxjjxolrYwvb46i5vBcXHSlb6XEAAFzNccYzc3XBGR1F4nAfAkttsk1TgAaXWfZ6rQ8hKdUfiJ0cgkImFcbRXlmoK8K1aOVFnJg94kvjsNbINziAcpnejgCtk6oVSS5b5d1EcpLwKyOpufLJk+q+lWpHpDHu/1688AVy4PaXiYMZsWRGmDxPhEXzTNAy9aCOzoD6ogRxEL8IURjV3YTSAnF+BqQ939UO/gzWHXPB4h0Zo2VjPVGN9MbuYmcy/0GjfNf9Dpclv2bTfcYCJtoQviptl101MfOLahztDAVg1c1tk1BNrT4FYiuEkBGCQ5V59ykHWG66urFp8gR8mpK6crvtKdmE7yVh27zEv2UTPe2iUkZS58unpHsbousZwEH+BfqNy/9EG1fnhAwqfu57L+h8li2Z16c9lI+ShRmuhBYvkltkKGDuEVxseFdX2T4eOLJVki2bqr0gwZq5w/7awxWbDThu5qq8x9qH6145zkMaI5yj3fsS81WM6in/NEkkAHUUhpG5CKc5A00UcIVMN5v9L5ny/aaRmqLhqqt9lkuWarEuOTico9hxJcvKlZlMwC6OKwR7KGZybykzKsvLt3XP4UamzTjTR2MveOlXKrhpxYRR1y9ei5gI8EiZoF1zhstJnVukOdh/dUNhMAbyT6HbJmwS+zxyQzUI/BPBiF2l80+1y5SRuzy2VblBFCUS30AZF/idJEYom1QetkDR+gQUckfXwevp2ZPI7CJXixJ5yJUptPEXcZTaecWIZesi9gGa5GxBd8QMJ9wjqas9LE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(52116014)(366016)(56012099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjdUbVlhS2hPbEM4R2IrYTJKcU1uaTlwbjBpeVRuVS94UVJOQk5MdjJCUUNQ?=
 =?utf-8?B?blZQMzlxS0kyNTRuUDJoaXJKeUdVaitqWGpKcTJqMm9vWkEwSXJyZkZmVXRD?=
 =?utf-8?B?UEpxL1YzTEUvdW94eWRtMjFDTy9nSENYRkE0Vm9hNi85bFlLQ0dkK0p4aGdn?=
 =?utf-8?B?R0ZlK2pVb2JvV0RLV0F1OUlJMEpvaUY1N29yUXU2V2JsNWJFL01mRFBvbm03?=
 =?utf-8?B?cjNETHpTYVNwaW9iWXZ2b2UwY2ZhSnk1TkhQaGRxbXlvNEZ1Z0JZSENGalZC?=
 =?utf-8?B?ZnNLODBkUy9Yb0NWcHlCSEkxU3Y0NXNSc3AvMGNwUTJHTy93Z0tkWTFDY05l?=
 =?utf-8?B?Vi92N2RCVkJIWE9LbWlRQ2ZET2pzS1NjVkQzWVd1U0RrZlVQM1l5b2Z2cCtL?=
 =?utf-8?B?RGY0cXRuNzczMERYYUFFMUFYNS96a2NGSGc2MDFxaVpWaTI0S2E2dThTaG1I?=
 =?utf-8?B?bjR3dzVBKzJqZ08yU2tkVUNGQTZYUitsOC9WbG5Td2JkNWlHdmlZdm9tVVY4?=
 =?utf-8?B?NVg3QjRHNTlyK2dQVFkycmdrbnNTMGZPd2NkRi9SNVV0RGRPeGk1QURId3NJ?=
 =?utf-8?B?TXdlM1U3d2tUK2FBaDhibnU0MnlMa1lYeWtYZGxXdlF3R09iazFjSm9yeGlU?=
 =?utf-8?B?M2paWGVLbzFqYUZDaEkzK3RGUE9FSHBWdENkRXdSSDRZUVp0YS9xR2k5ZU1F?=
 =?utf-8?B?YjgvSXA3QkQ0Q2JJekhMM3owQ0ZDck1XMkdkcGRXRzU4YU80M0ZrTzlkTEdY?=
 =?utf-8?B?R2p4NFhWbnlhR3g1K0ZZOElwN1I0OFljZTF1Q2RndCtMQTNtbmRGd1VmTEJ0?=
 =?utf-8?B?c3NHRXF0Q2l0dnhtdUVNdEhTbE9pbDFCRHdNZThMd3JucmpvVUwwejczckRt?=
 =?utf-8?B?eDdnMStXYlNmbmh1bG1BZ25ES0xUbkcyT2kxcGJiOC9qOFJpRmdQUTNEWUZ0?=
 =?utf-8?B?MHc4cDhSSHhMNGh6UnRjREJCbVI3MkliZ0JvSU94R3o3ZHNYTVZRZndlTmE1?=
 =?utf-8?B?eCs1Y25LaXgvSGNYUFpOaWhzSmpieG5wTHhndUJpWTE4SUJuTmVUbEVqZVVC?=
 =?utf-8?B?aWcxZllYRWh4Nk0zWXNuMVdMcXFzQTJ5ZHhtK1ZqM2Iraml2ZnE4RHVldkRY?=
 =?utf-8?B?VVNFSXpaNnJud0FpOWE1aUVIZExlZ3VOanZzY1BneHh3QnloUXBPMktPUXJP?=
 =?utf-8?B?OTRSTnpkYUxJbUJubTVvN3A0WHZUek5tYmk0SXlyYy8yVm1qczkwbit6Nk9p?=
 =?utf-8?B?Nm5PTjRLbjB0S0JGb0RGYjgyQzVYVU1rT2hsU2pjZlpPZ3ZXVE9KSncxUGl3?=
 =?utf-8?B?c1NUWXRSMGdRbmFqRmRySUU0WWlvdU0wbE5ucVp2K3plN290RjRrNCsyem1C?=
 =?utf-8?B?OHNVNWhOdUNXRHYwYVNvcmEyOVkxbTZyVUdqL3I0MjJScDhhelQ4YnVxaHNK?=
 =?utf-8?B?YkcrV2JlMFpFUDhRTk43OUpYSWxZQWVQWkpDNEZkV0RTMWZMazBCbjRlczhp?=
 =?utf-8?B?NTlqTXhGZjZBbmJTd05xcWUvQUhEVmFFRGxnY2daUTNhRFJmeGNLMkhLS0tM?=
 =?utf-8?B?M2lzd2t5VVM4VlJRdkJxM1hDTUo1MnFPMy9kM2tJNHRXTTZCR0NqUzNQWGp6?=
 =?utf-8?B?TS81QzNBdXk4eWNneVJ2eTBENG1rREJYMlRkd1loSHdQTHpwQXRrNks3WDMy?=
 =?utf-8?B?Qy9HWmM3VDM4K3BGUU9HK1YwK0dtV015a0hyakQxc3dLYjd4QzRzc1VyMVFU?=
 =?utf-8?B?aUVWbjFZVmlTcWlRbVlMSml6UFVSRzhTTzlZYllobWVuK1R5RGhJeEhaRzhX?=
 =?utf-8?B?SW5DQk04Q1RuMEVwNWNpNmxleC9LdWRXOW1CcmxUODZzeEdKSkhVTGlSTXlu?=
 =?utf-8?B?SzNEc0NCc1dmaXdGQ043YlJtTkF0eEFkdjFwcFA3RnowUXJ1VGg2aW11bmE5?=
 =?utf-8?B?ZXVYdTNSM3hNK1lFeUhvMndIZ1hmN05WWVhHZ0Q4djdLSWk4OFZRQ29iemhC?=
 =?utf-8?B?bmM4WlB5RGxpSnlqbzRQb1ZoeFowWWhEVndKeVNmNFd2RmlnVkFvYXJPemlG?=
 =?utf-8?B?TmplRlR6UURGT3MzeWFsL0taU2c5V2kvdEdiZFVPTmhPN1V5THQ4bkdPM3VP?=
 =?utf-8?B?c0N0bkJIOHJMc000aUdJRUZGZ1NlWGNVWUdnVi81T0F6Q29YSTNBZ3UvRkIv?=
 =?utf-8?B?ZXdGb2xVVG5NNjhGdDRGWUZaMUJaYTJma0xtSThnZlBKc3pocmdtclpiYmVo?=
 =?utf-8?B?dzRraFhEd0xQYVFBMS9ncTJqemVJbko5bVBPcWlmb3ZrR3JsLzVNVHo3TmI4?=
 =?utf-8?B?M2g4KzZpMWxDVHViRGRBQ2szR0JDRkt3UVpQRCtPcXJiSWwwL21rQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb52221-b02a-4c25-62be-08de8e5a931e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:48:00.1847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOd7OyOzLIS+gHRIXW5zDUJafHQAAOynxzYt0Qh2ddPQUhdnx4pA/WsRh+D/FUnLkfKqomxyEYaTFdj1+w5BPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9962
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

From: Peng Fan <peng.fan@nxp.com>

Convert the board to use DM_PMIC instead of the legacy SPL I2C/PMIC
handling.

Changes include:
- Enable DM_PMIC, DM_PMIC_PCA9450, and SPL_DM_PMIC_PCA9450 in defconfig.
- Drop legacy SPL I2C and PMIC options.
- Remove manual I2C1 pad setup and legacy power_pca9450_init() usage.
- Use DM-based pmic_get() with the DT node "pmic@25".
- Update PMIC register programming to use struct udevice API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi    | 18 +++++++-
 board/engicam/imx8mp/spl.c                         | 53 +++++++---------------
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig      | 12 ++---
 3 files changed, 38 insertions(+), 45 deletions(-)

diff --git a/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi b/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi
index cf2a87a9b90..13e1070c28e 100644
--- a/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi
@@ -22,6 +22,18 @@
 	bootph-pre-ram;
 };
 
+&pca9450 {
+	bootph-all;
+};
+
+&pinctrl_i2c1 {
+	bootph-all;
+};
+
+&pinctrl_pmic {
+	bootph-all;
+};
+
 &pinctrl_uart2 {
 	bootph-pre-ram;
 };
@@ -63,7 +75,7 @@
 };
 
 &i2c1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &i2c2 {
@@ -118,3 +130,7 @@
 	phy-reset-duration = <15>;
 	phy-reset-post-delay = <100>;
 };
+
+&{/soc@0/bus@30800000/i2c@30a20000/pmic@25/regulators} {
+	bootph-all;
+};
diff --git a/board/engicam/imx8mp/spl.c b/board/engicam/imx8mp/spl.c
index c1aa28a17bc..46c581ea51f 100644
--- a/board/engicam/imx8mp/spl.c
+++ b/board/engicam/imx8mp/spl.c
@@ -16,9 +16,6 @@
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
-#include <asm/mach-imx/gpio.h>
-#include <asm/mach-imx/iomux-v3.h>
-#include <asm/mach-imx/mxc_i2c.h>
 #include <asm/arch/ddr.h>
 #include <power/pmic.h>
 #include <power/pca9450.h>
@@ -33,36 +30,22 @@ void spl_dram_init(void)
 	ddr_init(&dram_timing);
 }
 
-#define I2C_PAD_CTRL (PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_PE)
-#define PC MUX_PAD_CTRL(I2C_PAD_CTRL)
-struct i2c_pads_info i2c_pad_info1 = {
-	.scl = {
-		.i2c_mode = MX8MP_PAD_I2C1_SCL__I2C1_SCL | PC,
-		.gpio_mode = MX8MP_PAD_I2C1_SCL__GPIO5_IO14 | PC,
-		.gp = IMX_GPIO_NR(5, 14),
-	},
-	.sda = {
-		.i2c_mode = MX8MP_PAD_I2C1_SDA__I2C1_SDA | PC,
-		.gpio_mode = MX8MP_PAD_I2C1_SDA__GPIO5_IO15 | PC,
-		.gp = IMX_GPIO_NR(5, 15),
-	},
-};
-
-#if CONFIG_IS_ENABLED(POWER_LEGACY)
-#define I2C_PMIC	0
+#if CONFIG_IS_ENABLED(DM_PMIC_PCA9450)
 int power_init_board(void)
 {
-	struct pmic *p;
+	struct udevice *dev;
 	int ret;
 
-	ret = power_pca9450_init(I2C_PMIC, 0x25);
-	if (ret)
-		printf("power init failed");
-	p = pmic_get("PCA9450");
-	pmic_probe(p);
+	ret = pmic_get("pmic@25", &dev);
+	if (ret == -ENODEV) {
+		puts("No pmic@25\n");
+		return 0;
+	}
+	if (ret < 0)
+		return ret;
 
 	/* BUCKxOUT_DVS0/1 control BUCK123 output */
-	pmic_reg_write(p, PCA9450_BUCK123_DVS, 0x29);
+	pmic_reg_write(dev, PCA9450_BUCK123_DVS, 0x29);
 
 #ifdef CONFIG_IMX8M_LPDDR4
 	/*
@@ -73,22 +56,22 @@ int power_init_board(void)
 	 */
 #ifdef CONFIG_IMX8M_VDD_SOC_850MV
 	/* set DVS0 to 0.85v for special case*/
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS0, 0x14);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x14);
 #else
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS0, 0x1C);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x1C);
 #endif
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS1, 0x14);
-	pmic_reg_write(p, PCA9450_BUCK1CTRL, 0x59);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x14);
+	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
 
 	/* Kernel uses OD/OD freq for SOC */
 	/* To avoid timing risk from SOC to ARM,increase VDD_ARM to OD voltage 0.95v */
-	pmic_reg_write(p, PCA9450_BUCK2OUT_DVS0, 0x1C);
+	pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x1C);
 #elif defined(CONFIG_IMX8M_DDR4)
 	/* DDR4 runs at 3200MTS, uses default ND 0.85v for VDD_SOC and VDD_ARM */
-	pmic_reg_write(p, PCA9450_BUCK1CTRL, 0x59);
+	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
 
 	/* Set NVCC_DRAM to 1.2v for DDR4 */
-	pmic_reg_write(p, PCA9450_BUCK6OUT, 0x18);
+	pmic_reg_write(dev, PCA9450_BUCK6OUT, 0x18);
 #endif
 
 	return 0;
@@ -136,8 +119,6 @@ void board_init_f(ulong dummy)
 
 	enable_tzc380();
 
-	setup_i2c(0, CONFIG_SYS_I2C_SPEED, 0x7f, &i2c_pad_info1);
-
 	power_init_board();
 
 	/* DDR initialization */
diff --git a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
index 0649d746907..ee55d804980 100644
--- a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
+++ b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
@@ -7,9 +7,6 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8mp-icore-mx8mp-edimm2.2"
 CONFIG_TARGET_IMX8MP_ICORE_MX8MP=y
@@ -78,8 +75,6 @@ CONFIG_CLK_IMX8MP=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
-# CONFIG_SPL_DM_I2C is not set
-CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -98,12 +93,13 @@ CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-CONFIG_SPL_POWER_LEGACY=y
-CONFIG_POWER_PCA9450=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
+CONFIG_SPL_DM_PMIC_PCA9450=y
 CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PCA9450=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y

-- 
2.51.0

