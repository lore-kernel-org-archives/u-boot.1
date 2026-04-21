Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF5DF8FA90
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D59A84368;
	Tue, 21 Apr 2026 17:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bPWasbsk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE5E83A91; Tue, 21 Apr 2026 15:59:52 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0963F83693
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1p56tTiqjjI7WxjMoZawhagyZfDCq2CYOM3jQJr3hAbDdIEjRG8kNC8W2d+JP8YtIaOmWzPSX4DZXymEBQqyRhzq9f/0Gfvgvjb5LkSfsOUAA61BXLh1q/0Dm6y5qTddL1nHB/jQFy90CEFLfhtBNlzM+4FWjA8ONr9YSwmYxdX3h8vyl/KGdwxSMJFYGMsgxxmM+1h7ZyzRkBsLjH7tp8p/oSUyRI078+TVcru7UwtmHcKL81D7vm8zl3BZux1RR1OmTIPNr9oPVyd1ywcb4y3VRC2q6YhUBo6ONY0RFKvGjsGfJdtFw68b52lFkm1Y1Ua9MMYmpVwFYbbchZQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OgPTVyV/i7EmLH+gS5QL2mzx5FGZ7j9uiioZTUBeuM=;
 b=RpSzhWIpxFv8ONl4WSAT8KncdGitv5lJXZ1LqcP0NVsrVDADg+DNZdk4rp+vFRL1QK84l46TCks4FAt8ziiOebvSot1qbvl1XIpIvkkCWejBrmNR1/xRekmibe4n7bwUcIOhm7Jfbzqig2zyjY9yG5A0m/0iOlHbuvuhJkrqjQPW42JmRTvRfWe3VgkcH48EwBxDBmNTtJKsJXqMNXed5ds+lQvPDOxCmI0IMI6AIDlMg3q5z62N5Zjppb/6YLSOPn4cQKDKs/XqszF9pqaEEY0zdcefGGlVE8rBC9HvusZtF7/fEuoLX7MRbhu4S5YVlyxv28zxYmhkjs95ftx6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OgPTVyV/i7EmLH+gS5QL2mzx5FGZ7j9uiioZTUBeuM=;
 b=bPWasbskb1rAeRGRhPRtEY3FH1MXoSBHD4SeGFMbhlwjZhbsi2MAU14rFOacRFVk/e1bmg33yI5HpiKnn35q6PaPOPmzzRIG0UQsoJvIvqPXKX4TLFL8QPnACNdJ3s4rc+rnv4L3A6ETiBjQQTW1a0CvscGRqBvLvGb6dsJfyUjba+bFyS43mVxEgNAf8a7WC2xpEdlXKJBGZlq6CGOymAQ0aURdL9WCgQ93YBRGQDXv99nbsRzVf4Qyg7otGnI4JB7AmCOXtTFYNSeP+3geMAVmiWX9/hpVh6uPOE9n7oe8g4KbM8P5HFWl4kNCrvremk0Jmf0mC2qHWfG806HWUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10426.eurprd04.prod.outlook.com (2603:10a6:150:1cc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 13:59:46 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9818.031; Tue, 21 Apr 2026
 13:59:46 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 21 Apr 2026 22:01:30 +0800
Subject: [PATCH v2 4/5] arm: dts: imx: Enable watchdog driver model support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-wdt-v1-4-0bd01ec6a7c4@nxp.com>
References: <20260421-wdt-v1-0-0bd01ec6a7c4@nxp.com>
In-Reply-To: <20260421-wdt-v1-0-0bd01ec6a7c4@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Fedor Ross <fedor.ross@ifm.com>, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anshul Dalal <anshuld@ti.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Joseph Guo <qijian.guo@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0088.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB10426:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a8420e-195b-4aa8-841c-08de9fae3ed2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|7416014|52116014|376014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: RIHhplhBCyjwIKtLqrOso/BgeWv7rqdYfzQ9DvHRaZocNm+TAX9I+AmtLJiS3gdaVxHTlCrXFWoiyuviPHty+lNDCgbBnK2djK54afUZzs18Z3v+dFEhuQE5SIN52EuwY1Gnb5+5bQdGx9UREFsgLoxP40QdH46Z+nCJtq5DYouhCtgxWNs0TC2jUG67YAgTML+v4wbXoCs9rLDD8ndOd+FuO20bi3kLBdRU/xwhC6MLIYj/f+/hhiA1OijRt6ms6Gg7CpnY+0TyMo9txwfOUOW0YLRmzYuGTf7JUxRW8byC6UZSLhavNKamHMDpzqd/Ja9vijz3U7D1csXMQ9d9KklSYwH4TQilZx8LDOLXp5pjjPmF1CzpHuuETXCWeiA8fVmBXdTschNt6Ci5igjOH17h+02UOnFqRfLLG/nvq9iCRTbMf4mOy/tnnl/f7ElhApqRtVNkP9m6qriFCjk9r+/bW5dm9Ex8nwemVk0foC8zHT9d2XX3r6iChAvZQo6opc481ZkHPRjATgP2tk0yh3MH/bWHbViM6/ISlxwyBqW+AtxDDjYS3FS+WCB/2+uCDW+lhjmbPDsPzrTa1miuywVTUxYqO6LRpfqc2P/JgF4J9afEoFFJkQ0Sy0lWpnGH5Wc/fym49TFdt8Eb4gJWwEfdmG0srZ1YJSa908gJqm18S7N+J9KXxz4PYapJPWAoCdq6jPIz3/8gkZX1hk+sFnHkoxcJeVY3iQHY2WhjfrpCDRxyPwdBp/Z11t/NRrkojAt2iqyAHeec3xvOJbmtTjbUp7VEb5EfyqtyNfJA3VM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(52116014)(376014)(38350700014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFFqNjVjQ1o0ZDJPa01vdXZlY1M1dEF4Qm1xNEtSQVhoS280TFFRVUZscWRt?=
 =?utf-8?B?WGlzR3l4K3pSell1eFhTTlAxNXVxVGxSM0dwQlZueDFFdzV3alhrY0xKN1lN?=
 =?utf-8?B?Um5aMEtHTTdmQVFOVlhTcGVydjJzUCtJUUIzOGgvUlZzc3phZVZGNzd5aHZr?=
 =?utf-8?B?TnRodE95NnNsOEorU0JoTVc4SkpmKzdYMGxnc3JOL284MnkrOVJCdExieDJh?=
 =?utf-8?B?eEZQSXFYTGN4R3ZiWGtiOXJqZ0s4NjBVcWMyblBOejRCR0I1eUh6amNJcGJV?=
 =?utf-8?B?bmNWVGI5OFdMMko4cS9oTTI2MVVYY1JGRHJUVGNUWmw1eTJpTEovVHUrK1Bs?=
 =?utf-8?B?NWtabVJrZmlPS0FSREwvbkVJcURhZkdvVitsKzF1emhORjY0WnFPY3VhWEts?=
 =?utf-8?B?Qjc5SkVOdmFYYjJONUs4RW5tb3UxaGJsSlF0TGxxUDhRV0V4RERWb0xXc2sx?=
 =?utf-8?B?R21FQ2Y3RVpzRGtlKzVxem5KOWVCT2FZSzB4dTFNTS9NdlhSZlBkOHFwUm5x?=
 =?utf-8?B?UlJhR21hbWNOVUlTRS9xTE1SQ0NGSStZWXlyWENEc3pYanA3eHVEdE1nVTdq?=
 =?utf-8?B?KzYweVhTSG5kTW9BdXU2L2NBdmFiZkFyZ0UwU0MxbWJFbklWV2hHYmN2Z1Zu?=
 =?utf-8?B?dnRqZFlpRmduT2J0R1ByekI4Q0RmNXd5amxHU0l3Rkh2Umo5NUt6TmFIYmw4?=
 =?utf-8?B?b2ZPVVhsL3pyMGU1S1JXWjkyVGVOeC9nVGpTZHRkWU5WN2ZYM2wyalRwWG1D?=
 =?utf-8?B?RkN5VmFzUFl2YnlYWm5MdlpxbCtWdzBKTy9FdnVrOE81dC84LzM5MzE0cDlO?=
 =?utf-8?B?YzRDTEJWVzd0Z0xpdkovSjE4SXd1MFNPSFhuNXZ6aU5UeWY1K05vcVBUMVZE?=
 =?utf-8?B?RTBMdWhiSDdJTFZnMkdWVVZWRTF6aG1IWFpWUUhhOXZzUUJnOGZUUkpJZm96?=
 =?utf-8?B?Szd5WXlyZ3lwNFo1d1N3TUQ1SW4rVkZEM1BwckxMcmQyc0xsZDVCZkJkbVRt?=
 =?utf-8?B?V2V2dHEvUHh4WFdpdjZleVNZUmx3NXB1Y1U1c0pYRHcrY1daZ3Z2WGhrQU9L?=
 =?utf-8?B?Sk9Lbzl6b2ZMbnlUY2VvdVpERUZVNUFFWlFMZENnZkVyOTBkTWFISTZHUHBk?=
 =?utf-8?B?YzdHNGpZRXFjSUdMaTFiSE1PdHRYY0duMGdyczM4akZncm4wRDAzRFRWVk85?=
 =?utf-8?B?cWlzTXlnUEtlUU1yeEU4Z0c0K3JyeEZLNEs0Si9DRVNxcWpkUWwzOFE2MnA0?=
 =?utf-8?B?RmttM1E3RjVWdzdMcUlLdzd6U29ocy9uTlAwOTl0R3QwSE1EZEQxN1dPNmRz?=
 =?utf-8?B?Zm93dVdyTmlsMW5ETkl2eEFZV254L2xwN3BNSElkZkhpNXhncmkvQStSblow?=
 =?utf-8?B?Q0V2SFFoWjRHTEx3Rld4VWQrYnhwTytaelhuQWpOS0JyN1k0dzZHUTBseTJB?=
 =?utf-8?B?SDEzK29oeFB5eXpEajRSWVpEQ1B3cEJSdGFlZ05DU29DLzJ2VDduT1ZQMHow?=
 =?utf-8?B?V09ITEtwNHdUaXA1WUQ5YmE5RzZRUjBvSjduUzYwUEFOekRGcGsvKzRqRXNt?=
 =?utf-8?B?NE9hUktnZ3hZNjBPa1VhQnFnTmRWWnQwdDEyNW5VZ09CWlp2ZEg4VXZySE00?=
 =?utf-8?B?NzlPK0RmK2ZNL1EzWHo5a3MxeVRLSmg0Z2VVWEpQYkpFRTdUdGhYYVdnYkxa?=
 =?utf-8?B?RE50bXFJdmc0bjFReTlRbGdSNUF4d0l1UXZrd0VITGxGVFhxbWdSL0lWRGN5?=
 =?utf-8?B?dDhmaWRRbVNVczFJK3Fmb0k0UysyVUtjRkVOeEhFaGNkSnlaY3psZlBTaGJi?=
 =?utf-8?B?b3piU2ppSWxZM0VGRlBNVEdkNS9WMm9Nc1F6MUNvWjA2V21VcVJ6QlNvTGJx?=
 =?utf-8?B?SnV5dHQ0MGNSQVBHR0tYN1FpZ2JNSFlHZS9BcDBSTHJsVXhscFN5VFZFR3lt?=
 =?utf-8?B?OFQrWUJxbm1vcE9HVkJ5NU44ckdoVWhuUGppN0tPMSt3K25qcEFubHpqcSs3?=
 =?utf-8?B?RWxyQjNOYVB2dXRtbm4zWDBoZzg5elNaK3VrdWozNEVCUXMxWXdZV3J0cXNX?=
 =?utf-8?B?WHZLb2FGSGZpeForYW9BRXpPbVFnYm1rWUtaYVQzL2drUUpRaHVxZWRxOXE2?=
 =?utf-8?B?MnhTamhEYytEQlJnRUJiRjZ3cXZmWHVxWlZUb3NvOFdFcm1uZ1hlNkVKcmJU?=
 =?utf-8?B?ZzNmYS8zNUt6TW5rUmh0MlZ3S3BoZCsyako1SzhzK2ZSMXFhRVBEQ2lFWTNH?=
 =?utf-8?B?OVZ5THBiclNicHhFN0ovQ0dodUo5R3R4d3lKSW4rOGcwaHl5WDFsaG5FSWM2?=
 =?utf-8?B?bDdxZnpKU1dkOElCNGVDa2xrdVBtUGZheS9wV1U2NERlQndCbVNMUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a8420e-195b-4aa8-841c-08de9fae3ed2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 13:59:46.3002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNFq/IOVO/5K1RSnTT00ZDGWTXeGRAgL+Tnqt4c0j0K18yJckQk6PEsRxxSGldYNTC6HmRmX9ucY6MWHglsgXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10426
X-Mailman-Approved-At: Tue, 21 Apr 2026 17:12:16 +0200
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

Enable CONFIG_WDT for boards using ULP watchdog to allow reset_cpu() to
use watchdog driver model instead of hardcoded base addresses.

Remove wdog3 status = "disabled" overrides from U-Boot device tree
overlays, as the watchdog device needs to be accessible for driver
model based reset functionality.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi             | 4 ----
 arch/arm/dts/imx943-evk-u-boot.dtsi              | 4 ----
 arch/arm/dts/imx95-15x15-evk-u-boot.dtsi         | 4 ----
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi         | 4 ----
 arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi | 4 ----
 configs/imx8ulp_evk_defconfig                    | 1 +
 configs/imx93-phycore_defconfig                  | 1 +
 configs/imx943_evk_defconfig                     | 1 +
 configs/imx95_15x15_evk_defconfig                | 1 +
 configs/imx95_evk.config                         | 1 +
 configs/mx7ulp_com_defconfig                     | 1 +
 configs/toradex-smarc-imx95_defconfig            | 1 +
 12 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
index 860994129ae..ac130b54738 100644
--- a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
@@ -26,10 +26,6 @@
 	status = "disabled";
 };
 
-&wdog3 {
-	status = "disabled";
-};
-
 &per_bridge4 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index 247a7ed6838..3b3619d2232 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -153,10 +153,6 @@
 	bootph-pre-ram;
 };
 
-&wdog3 {
-	status = "disabled";
-};
-
 &xspi1 {
 	bootph-pre-ram;
 	pinctrl-names = "default";
diff --git a/arch/arm/dts/imx95-15x15-evk-u-boot.dtsi b/arch/arm/dts/imx95-15x15-evk-u-boot.dtsi
index 514dd729be9..34b4073ff35 100644
--- a/arch/arm/dts/imx95-15x15-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx95-15x15-evk-u-boot.dtsi
@@ -44,10 +44,6 @@
 	bootph-pre-ram;
 };
 
-&wdog3 {
-	status = "disabled";
-};
-
 &pinctrl_uart1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
index 8b59831b7ca..1083d863c4d 100644
--- a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
@@ -28,10 +28,6 @@
 	bootph-pre-ram;
 };
 
-&wdog3 {
-	status = "disabled";
-};
-
 &pinctrl_uart1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi b/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
index 97ce7402e50..c30e2d6aaee 100644
--- a/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
@@ -104,7 +104,3 @@
 &usdhc2 {
 	bootph-pre-ram;
 };
-
-&wdog3 {
-	status = "disabled";
-};
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index 41025dc1142..287b066b71d 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -92,3 +92,4 @@ CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_NXP_FSPI=y
 CONFIG_ULP_WATCHDOG=y
+CONFIG_WDT=y
diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
index 6ae6e405fbf..a6897ce13ad 100644
--- a/configs/imx93-phycore_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -156,6 +156,7 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
 CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
 CONFIG_CI_UDC=y
 CONFIG_ULP_WATCHDOG=y
+CONFIG_WDT=y
 # CONFIG_RSA is not set
 # CONFIG_SPL_SHA256 is not set
 CONFIG_LZO=y
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index 6acb49e47e2..d9fbf9566e6 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -151,3 +151,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_SDP_LOADADDR=0x90400000
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_ULP_WATCHDOG=y
+CONFIG_WDT=y
diff --git a/configs/imx95_15x15_evk_defconfig b/configs/imx95_15x15_evk_defconfig
index 38a855417d0..07ffb444e4e 100644
--- a/configs/imx95_15x15_evk_defconfig
+++ b/configs/imx95_15x15_evk_defconfig
@@ -147,5 +147,6 @@ CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_NXP_FSPI=y
 CONFIG_ULP_WATCHDOG=y
+CONFIG_WDT=y
 CONFIG_LZO=y
 CONFIG_BZIP2=y
diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
index e7832d86fe9..fb3566a3a2a 100644
--- a/configs/imx95_evk.config
+++ b/configs/imx95_evk.config
@@ -150,3 +150,4 @@ CONFIG_NXP_FSPI=y
 CONFIG_ULP_WATCHDOG=y
 CONFIG_LZO=y
 CONFIG_BZIP2=y
+CONFIG_WDT=y
diff --git a/configs/mx7ulp_com_defconfig b/configs/mx7ulp_com_defconfig
index a49cb2a728f..48dda17c564 100644
--- a/configs/mx7ulp_com_defconfig
+++ b/configs/mx7ulp_com_defconfig
@@ -63,3 +63,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_ULP_WATCHDOG=y
+CONFIG_WDT=y
diff --git a/configs/toradex-smarc-imx95_defconfig b/configs/toradex-smarc-imx95_defconfig
index 61abeff1afb..77d3b246c74 100644
--- a/configs/toradex-smarc-imx95_defconfig
+++ b/configs/toradex-smarc-imx95_defconfig
@@ -174,6 +174,7 @@ CONFIG_USB_GADGET_OS_DESCRIPTORS=y
 CONFIG_CI_UDC=y
 CONFIG_SDP_LOADADDR=0x90400000
 CONFIG_ULP_WATCHDOG=y
+CONFIG_WDT=y
 # CONFIG_SPL_SHA1 is not set
 CONFIG_LZO=y
 CONFIG_HEXDUMP=y

-- 
2.34.1

