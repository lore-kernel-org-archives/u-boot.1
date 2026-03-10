Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C331DFD2D77
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81EC7840C1;
	Tue, 10 Mar 2026 14:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GayLWa6V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E58F83FA7; Tue, 10 Mar 2026 10:15:16 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2813883981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 10:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuAIvEspiCOF6Kh7mQdvu5Vp3dIGzytHHQMmuhUq/tnWGI7ZDOzJBTHmd4qTE8MbIW7gWhDIEx31vLu4idMbKmombSdynTSkmh1PlR4w4UkeTN8mEm65Z4M81OQjlDUiVGY8lwz4wOnyHvqSe5mgwzM5n+AvhBaFPan6zhnl/u293fffsmZ4mMLB9Jz/ovl4iV4DhcOGLLqbDKuPIdahTyYeQAjDTLcsROFS026p8Rp+lYNIsCrQ/qruZlp0fCVff7hcfMXCpNTUHtxF1X+AymwcyUDeMM7txtB04g2WQzKppW7Llf0jI/kVWCFuxF6bDW+Htjpm65CoBOZo5Pim5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vgz1cDFTlyWftsj5QbDpK7WweKCpFFgVw0gYtwj03A=;
 b=t3A/u6T18FUkth5ILmwLuHzKP2OxluYkovChGMhetzBq654pBLbV6AZqJTP0RIOTZHlLtc9ijLOOE3YwyIXBf4XxhsAU/lFz2o11VSPKVCS1mM29FxZ4EOjykABshvQOR2Ivu3c9JQh2u8vRvGOGBA7qrWy3R2SjVfdD1Rd4HJuNxhvFVrZf2YsVAdUWE3LezSwFmZZZj3huUM0yocCd/rbj+Mw538oIXNzJOfGjLEZUXG/0ZhDckiEU3+F4Ueu/nxv3y8hiiM7/ogZfXxQ/7Y9vBMNASsK1CQW/6XQ6A8so741Dl6ys7bZQjYiBoPQJQJlnM51PhP74CN24zbS97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vgz1cDFTlyWftsj5QbDpK7WweKCpFFgVw0gYtwj03A=;
 b=GayLWa6VO55kXtsupZ3v8aXdiG6xxM/QhWeV4FMyKazVmIUbiJQJp2/AKKPSImmzJkSsOsTH+k7Ty7PyFP5ygZvsVHhfnYzLkYgfFfNt+m5emjBteZAv8uePCsArCWipuEPkl04rR6P2CIAXcAH0N0Y0DHVpF2AFzyxMWJiRiozWB5kMTZrmkagWLTUVbTAdh6k3uDgoUzKkFNn51OCmNp5nwRCM0JD0zKscIzpdiMVUG0dsAZHY8T12IMeUs5lBkfK7MuxbtbsKV9/g4q+MPByb/YGJjcmmBPgrqANqKx2dsLNn28NQt2n7rc6b/NYxBjra2ep68Gn7DLQ35MEaDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV2PR04MB11192.eurprd04.prod.outlook.com (2603:10a6:150:279::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 09:15:01 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 09:15:01 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 10 Mar 2026 15:53:43 +0800
Subject: [PATCH v1 09/10] imx95: dtsi: Add wdog3 and wdog4 nodes with aliases
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-wdog-v1-9-2ee21e890634@nxp.com>
References: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
In-Reply-To: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Joseph Guo <qijian.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Primoz Fiser <primoz.fiser@norik.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Mathieu Othacehe <m.othacehe@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Jindong Yue <jindong.yue@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR02CA0071.apcprd02.prod.outlook.com
 (2603:1096:4:54::35) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV2PR04MB11192:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d36a9dd-7979-42b1-c265-08de7e8581ed
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 5cXXJrGk4zNLsydw7EoeyvU/FO4uXKwJM3/8apnzQK03JJsF7qVLvjhwbspL1s/3z2T8X/L1lUSOIVxgVLuxTd3yXRYj2XRReW/2PpryJLUNTNI/ifesQJXeYlwhTujVuI57eMGrePQBxffWJP62CNj2GawDVXJfuLKuPLCKg6JtmsMCgZ1Ne+McDbE5JofIglMqfKqYEg7cnlfTg++eQAHsI4af+dWrWfl9sK/3Y+zz4xYCJ67cEK1NoU5FUC0+ihR0m8tD9o1sjvSqHqn1hL3RclnibnbnhroKK/2IHZTGXiv3M+z3rkeHva0xHFk20EyVIA52NwxFvMC4QNs5IoqD2UZrrVQ5hWBUxsOXGqiywj0ygG9k2S+pFdbdaUcdxGqh58TMCEwpjC4d0eg9MdKN5Jj7keg09OU2YA/M+vg32ufE1PqklD+Q1jPOauIM7tmF6mSa7Ita3wkT0GJ6JCwj3PVSkqrCgzJmdGlNtLE4ocuImhhrfpv/jWH6hsD/+8VK47t2Jv8HPJ/IAzhRwrXMg3wvonU41h45Dd4LA0hOzLx7Svx6gE5WM0I0ZraD3HpFj8b8NQz5boLPKjpFEBZuUxhO8hM4gPie1OU1N/a6bkm/urTdPY1yCoH0ASc8VR+uq4x6k5aTR3PzEnF0M0AgiJG7dZwaNrjvBsHJcdxYveQ+J25xe9bhHa6cCPv171aUie5PBrZM9Tf8bsPupPRbyJBkK2XYansCrTBNLBYNFfeMHEiBzIDrxA55p7+o9ed9sl7RUq8nVwmaSL2p76Xuy7BHloxs5ZNiYL2UeYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlBER28zUHRhT0Z4NnpLeXduV1p1NG94Y2lGbk1kd2VGaXJRSitlQU0xU28y?=
 =?utf-8?B?RXVnYUpkK1RZOE1xYW9NZzVmZDZtbFNvZjdGUFBVQVd1QzV5Zm4wMkd6NFph?=
 =?utf-8?B?UVlpMElpQ0I4VkdKWWhHOW5uWjBidlRMaFp6NkJFdUFodXZ6UXRTYmhEVlNk?=
 =?utf-8?B?RDF3OHdoU0pHeGowU1RCWFpRaDZmYzF1WjVLMFRWTER4cm5mYjVBWEdLYmZF?=
 =?utf-8?B?Z2kyd3YyY2NWaDJwWTR2cXNMaVlHQ3pKWVA1eGVadWlOQmtTeVNyM1h6amlp?=
 =?utf-8?B?YzRpTzQwN2dsWkRRRmRTSkoyZDMrNUtXbEFUUGoxUjM4c29LYzF0Q2lUNzls?=
 =?utf-8?B?RDVVSm9oL0xHK1NaVlRiTmJnZDJybTBsYmRha1k0NTBqZFRXVk95azRTUzNp?=
 =?utf-8?B?SjhIQWd0UUFBay9oQlJjbW9yZXg0b0R5UXZwcG9Vbm1HUksyTTRwMDkrWWE3?=
 =?utf-8?B?KzRLN2l3Y25ja3A4S3loc0owak9iblp5SENEU1NSMnJHMnkrVmxLSXVlM3N1?=
 =?utf-8?B?L1NCL0xVM1lLVmRCdEZObUdtSTJENVZZYSszL29aZmp4MWEybmdacFZvTWVk?=
 =?utf-8?B?T014YzFZNlkrM29PalJEbFJDVTUrWStCYkNlaDJZdVlDKzFINUdIdjExcTZo?=
 =?utf-8?B?UEpXU3VQaHFHSFEvU0s0MkhGY1F2bUdPK2VYTTdteTNveSs2dEZkMkgvUmgw?=
 =?utf-8?B?RE5qZk50bVRJSGExSjJmTEdnMDR5Zlpmd1pBMFVGNENZQk9maXJybmJxSjhp?=
 =?utf-8?B?Ynh4Yk5JUnZjNG9jZzVKVUgyWUpWV0kxbk5HalE0aDlPTm9TQ1JyNXpyK1FH?=
 =?utf-8?B?U01YZXhBMnBCbWNiaU9EVzNVV3JQajVrS3V4dG5nWjFmSE02VVFHMTJRbnRY?=
 =?utf-8?B?YVdhNWZtcm9xemhFOThBRnFCQ2UzcWFjWG02Q2ZyS05ZT25KRjJOSjM4MUVt?=
 =?utf-8?B?NTlDdDU5U2ZQSkNWTE1hcGp5bVdtUFlmY0tlM1pUMnBJRHZNekJyeVl6ZEty?=
 =?utf-8?B?MmlXRkFxL2xZZVhvTVJkRStXSDlCZStjSjJWQ0VpdkpyQlpXSXJzNElTemZq?=
 =?utf-8?B?MHduYXVMT2NKNUJHSGN0a1p0R1ZJQmh0bkVEUXRkb3pZRzYxd0RQUUVVNVhk?=
 =?utf-8?B?MjA3czl4SjB6cVZwQmNtSG8zdGlDWWtQRyt5S2FwTTFMV01lUWpUTTM3R1k1?=
 =?utf-8?B?dXYwVUJoM1BaakxEMGF5S0tOQVBvYWtpSklzTUlOaXk2T0JRRlJ5M3lrYnpk?=
 =?utf-8?B?ODE3cnY2NjFwa0JNVXd0ME40YTFRMGU2d0VZSXRVbWRob2ZuMHJSbUg4YVpO?=
 =?utf-8?B?MERuQW5lZFJSeXZZWExQN1lpUkN2a1Y4d3Y5KzN4MXg5YWlaU1BsaHA2V1da?=
 =?utf-8?B?bDdYMWNGT3BONlJFd0MySTcwN2tBL3FKdjNmSnVBNCtTZzdrOXFJaG9OcmdJ?=
 =?utf-8?B?TjI4OC9WVHcyOUtCRGtCV2JUV0lqRHZycUFIRzZMZTVBS1pTMEZoTVNKUks3?=
 =?utf-8?B?VzdDQnltRnN2OVVLY0dxWmU3aW8zYkd4akN4akhIK09IMVdwQUZweVFjTDJU?=
 =?utf-8?B?djgrTTk0UmpHYXVnbTkvMTBVd2dFS3BjdjBFLy9NeXN2aUxTSkQ1bkpyTWMr?=
 =?utf-8?B?bkViR3diWXhXN3g3OVFVRXVHMVFhZkVhTDNFQzNZZzFteG53MjVQZ3FPNDUw?=
 =?utf-8?B?Q0hJV09Sd3htVHI4YzMxalM3NS9aTjNrMXdKbjR4WE52WXVOTjJFUW1YUUJL?=
 =?utf-8?B?ei9TWVZleUJKb1Y0VDJtOWZiUzB5em5iVnlUZTk4SVM1VVJpSzVvY2I0a3kv?=
 =?utf-8?B?UURic0dvb3prMFhlV0F0bUhWdTNiZWVtUEZrODNVaGVpMDZ5UDhkVWk3MXM3?=
 =?utf-8?B?RzB4STUwZjdrbXZpWFFLZlpuL3ZJQVJFMGpXc2ZnY0RKUllKTVN2enJsQ0Jj?=
 =?utf-8?B?b1hhTFdINjFmQTVidnJ4UCtoV2hISUxVbVd4bGhXQVgzM1YwRzJUbzNNNU5a?=
 =?utf-8?B?RmlIdWV6NXNrVFFCNzdSdTZZb2NDL0VwRjI0dWZoTlRJZm1jSFVXRUZvajB6?=
 =?utf-8?B?eFJoT1FOVmN2SGdGY3RUTkZmWml4c3pGeUdKRWhhVTQ3UEhBRGlrcWFZVThO?=
 =?utf-8?B?MWVEUHpnbXFSdkREbFNZUHF0amlxcXdaRTZOb3N3UkdGRkRTUk9xNTZXcWF2?=
 =?utf-8?B?OWdaTExteGRmTXJGNndTeno4eW1IVlRKUi9KcGg0UVBNd3R1MFZvSWVFQTRQ?=
 =?utf-8?B?dUgrandLSkExY0lJZFpEM2tvM0dacS85SzdnbVkreFE4dU1UenFCOXJqS0xz?=
 =?utf-8?B?U1F1M3pyUysyVTQvbDBmZDRtZ1Bkb3VvNFJ2QXZVUDlqa1RkeGJRUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d36a9dd-7979-42b1-c265-08de7e8581ed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:15:01.0390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5PD1VaOrNWTyH6jRaIUti5Yf4loOzNhzecC537FEWevmBtQALORWvKVd5nJ8S6JGGXuxnxYE2/pWUWW0PlDXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11192
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:11 +0100
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

Add wdog3 and wdog4 watchdog device tree nodes and their aliases to
support dynamic watchdog address lookup.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx95-u-boot.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
index 6dec159752b..f4ce335e471 100644
--- a/arch/arm/dts/imx95-u-boot.dtsi
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -4,6 +4,11 @@
  */
 
 / {
+	aliases {
+		wdog3 = &wdog3;
+		wdog4 = &wdog4;
+	};
+
 	binman {
 		multiple-images;
 
@@ -138,6 +143,16 @@
 
 &aips2 {
 	bootph-all;
+
+	wdog4: watchdog@424a0000 {
+		bootph-all;
+
+		compatible = "fsl,imx93-wdt";
+		reg = <0x424a0000 0x10000>;
+		clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+		timeout-sec = <40>;
+		status = "disabled";
+	};
 };
 
 &aips3 {
@@ -238,3 +253,7 @@
 &scmi_buf1 {
 	bootph-all;
 };
+
+&wdog3 {
+	bootph-all;
+};

-- 
2.43.0

