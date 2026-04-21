Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF54F8FA66
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFC358431E;
	Tue, 21 Apr 2026 14:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MWuEL+Tk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F029801A9; Tue, 21 Apr 2026 14:26:34 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F15805D7
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inj/Qt06VAIiDOkPuwjI2iNmZaKBOG0do9VlnWA2tPOTtyijiNu0u/Q4/FcvRAitPhDfyjemo4tLYcSXz630/Kku9M2TeGacSzrLQETW4ROMDDGY3O+Lgc1cC+ikPpKw+0LPs//p7+eveF982c50leGnkBKzrjRv1cwHlM6CDYL9EYmSiSf/qQz3jsg5vNeeYEGo3+yU+9y8fgEKRf3WkFjrFYDG4WobMptvSKiNf6nqVttXliaTmtS+Bo9liyd9zgbGO16XWISDNbD56CE5s9JI6dVXy5gJ3SYtRVOa4CFy2c2Xk4+GJ/zhudAUWIQCRVBcDV69swQvcNtdzmf0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxsUyudA7CNqqIy/D0hE2Vc+f5B3aGUkS25h52+OkWo=;
 b=mRsXMPz7v32bFM0a1soiR8fcQFhiRhIyfyAaxdgbLnzUtrWdDNL/KrU82yAVeryT8JNwBF6fkkq/WPzQiacbiZ+WFgP1VL9kX0008p4PUG32ti3mYhxwDRfeP4MF9sovz+LUVv/IEckn9AzoE7HkqdzJyj69CcItG9LfnuKHuprI65FxtTICuUVKJrmGM7kXU6xKUZYPJzZAjrpiAleIAfKnA8OeA7lZwoVxzzG+fpH0Mab61d/f7ugfM7r/T1InRssCNM5zUcvJp8ordwSgaeVCGkveEIgBAj7SfyXXuK/T7U3trMj+527anb1cPIt7cFzJR0k18KONc4qXl/9BUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxsUyudA7CNqqIy/D0hE2Vc+f5B3aGUkS25h52+OkWo=;
 b=MWuEL+TkFC8zfrwpajFIWvRwafLr8dB5fKVd5A4nCab12wMIv6RYuYvBExjCGEoaCycdvgbPHeA7j4v+PwrExkLpc/boJeEu57+bWJgPph5VRdnmunU+RG++DaHoWBt/yE3qaoxd2BCX3CwbHk+J6PB1qQ8ymFpHt0FMOIOu/EBlq7RZk/kW/A8P+hVOY7uhEvKbLChbMyJl3M5SjeVPHB+nbrXG+GOTAUTFZaaQJGcmmeVQZD4oAo85kAM5qkWx5NnE+/IsucAS8r9tSmcN8yxj7lwDfsgcna9WDg0wRsqqS3au/wkapqaPCPHf1MN9sEBEIi3KCQWztaMtb7HrAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA3PR04MB11249.eurprd04.prod.outlook.com (2603:10a6:102:4aa::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 12:26:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:26:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 21 Apr 2026 21:41:27 +0800
Subject: [PATCH 15/15] imx8mq: phanbell: enable SPL DM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx8mq-dm-pmic-v1-15-0e2b490542b1@nxp.com>
References: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
In-Reply-To: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, 
 Ye Li <ye.li@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>, 
 Marek Vasut <marex@denx.de>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Ilko Iliev <iliev@ronetix.at>, Angus Ainslie <angus@akkea.ca>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA3PR04MB11249:EE_
X-MS-Office365-Filtering-Correlation-Id: f704b390-7969-4002-bb64-08de9fa136ef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|52116014|7416014|376014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lo72AIygYKdfT1C8B0N/Jq1ewvq9en8AvswzPMK2gdW4/ssZ8nVUR60WuRNahpEl0sGTfcBK+qWBhP5K1l2kVQlvBtnrOsUI2GjPLAd3NZ2ctIrJ22339lRh+DEcEt9c2g8UXHkPFeh7lbe8FXgLZ6v3R8UiT64iUfnXMxKPHXBeRtrtLgC6mJQMUtxOQi8qzwB/XBLp8xerSl5jE2+rKQYxeewoddZtTnyxcgRmgaAdAbPd5/MvRDRV+GGByS6+fDx5U8GlDmUOLHHYn/x0//PAzDAr+PfNpASDY+EuV0G399VL+BEOzgDiaoFD3Sdf/xKat6FU3Z3MIXthxMi2RKTIWobZezvu/+Hil7dOgGcJfyROLwKE0+jJ2ZUljGFggj7vg7pqpZTEQs5Pc9HFcM8T3P6OuwNb70UZACiSDiVr5ErGnXAYT3nAcd9/yI4Q44zdCPu3YwARJGOzkgUlCNlRs2u0O9nAVWY/orqVHCHf+UDl11wI8xNoHgLJkJnI9BlcmPcrChyn+K00nw2IdEbFI6k7avXdm9EP4S8nwE01aRWiGn6r1MNyYxp4yzyp/rg6MVCM4QN/ambPmvBtED80xmuKslw9BWaLeD6lzFbIRG9DUpmKf5BEZ3SAp2rwetO7r/rNCCyyqdZuE0gvIn3zVdJwKYQIeEHUJXEfBhfD6PomnbYOBTQ61Op56q9DZVk2aU6S6XlbK3sa9YJYdBIB/9u13+4tl58F8STEIe7e2UTV3v6TXQvP1hDpZ5ltnTIa2GosHwSJ51jASzeeHTLnNVVM1ISh60WEu2aOAwg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1IzSnZuYm53WkwwMGlpb3RJa0k0bFVNSEhqbG1JYlp2WWN3OUFkaUFWaUM3?=
 =?utf-8?B?eUJyeHRHVHN3bjVFNXpOcUZVQXZaN05Gd0tyODMrWUNieXYrRlNrbGZWaTlL?=
 =?utf-8?B?d0xOM0hLbjRabWxpZWh0MDhBYjBYdlYzMk5lb3NQSUpUSWluVzIwdTZ0cEM4?=
 =?utf-8?B?czYycnBmM215Y1NWQzlQVndtempMTzV0UU1jYXZMR3NlcHpPRVdFZ2g2ZDdX?=
 =?utf-8?B?RHhMVE1RTHRVWTlXZ1JicWVueEtwd2pjVTIyUjczZktxaVhCYSs0MHJQVy9Q?=
 =?utf-8?B?YTJzMEpWdW5oa2JnSFdTLy9tdFB4aVBnY2xEdFE5SDREK2w5S3pDVDVNRFBw?=
 =?utf-8?B?cVVGZWZJZ1l1WlZIaG50Wm8wSXE0bW0yZnVPaEd2Zko2WDJJY0xjM1RKR2lL?=
 =?utf-8?B?WG45N3lpTExDV1FVWk9MRWJERTR2ZHBBMHlROFNNVGFhVVc2c3dxSERBZ0Zh?=
 =?utf-8?B?cEFzamJucmNjb0l4UGd4L0s2REtrWndZSTNjS3VZTWx5YWs5SXpId3NodXp0?=
 =?utf-8?B?TU5JRlJ4VUxpRlRnRENIdGplWC9wUEJac3liYkZzdHBHR2ZVVmlGamJaVkdD?=
 =?utf-8?B?ZmJabzVGQTRiQ2ZkQVYwcTc3aGZLS08ydUVFQU54WmFnazhVeTZPRGsyMWJz?=
 =?utf-8?B?TmpBcGEzTW1EZjhjTDZqSDBmZGV2dE5GOUxoVjBGTjBrZzVWRXRNK29jMXk5?=
 =?utf-8?B?ZW1WWTNzVWx6YlkrdFBlckdwR1o1SjltYUVvMTB6cVA4YWo3ZVN4VnNkaVBs?=
 =?utf-8?B?dE9mUmxPNlZWdEdYL3NROHZDbUlmZnQ5cTJ4cVJlbWN2MUdsbzBPVEc0RE1k?=
 =?utf-8?B?cEE2VlgrVlhlSUhPT2JPaW0xdFh0RjlncTJCbGlkVnBaY0FCbEFZVDYzdWtK?=
 =?utf-8?B?Vm9nalNOU1BzZjBCK05rL0JDc2V3Mmt1bjZSOFBuR20wMndRWklWRkludlo4?=
 =?utf-8?B?NXZBYzk0VjkxckFpMEhUakx4eUFBeXA3NWs3T0w0NzJtOGo4SFZiYUFTbW14?=
 =?utf-8?B?R2xhV2N0YUt1bzVncEljeXJUeWdTTTJoVFpNajhyZ2ZGQ3IvanhwK1pEL0pN?=
 =?utf-8?B?SjU2TGd6SlZ4R0RUOEwrOXc4WTErM1BlZ2tYV29DbXB6Y3RKVWdwcktOOS9q?=
 =?utf-8?B?NXNKK3dwRSsrVStmbktwaTJZQklrdTRHdi9DRitUeGlOUVJvYkw4RkpEbFJO?=
 =?utf-8?B?dzNhK0lUQmlBbCtTc0J4cWlFUDBoK21oekEzTjg3WG9uYkxxWDVmUlJLM1hz?=
 =?utf-8?B?WmphbWRJWXBrTnZqbm9OeW5YTWVDWWxvUXpCLzlPTGRlUmE0WGNvMU9kRjFp?=
 =?utf-8?B?SVJKRVMzR2RzaHFGL01NYWF6VU9KeEFqQXJRNFR2NzczK2hScStRb3cxd0Jl?=
 =?utf-8?B?SS9kZTBXOUt6T3Z4NURBdVA2WVF0bW1QeG9Cc1VzK1JtZ0d6MTB2aFI5QW0r?=
 =?utf-8?B?dTVScmlKRWpsZkJiYjZlQXIxRjgxRm1mK2tRSktaUkpWMVZ1eEVHWkU3RXlv?=
 =?utf-8?B?OXRDZWEwN3ZLVVV5bVdGV2VKSUhzQ3hRZ2oybWNrWlJFZXozdWRMblozRysz?=
 =?utf-8?B?dmNkTmVoRFpma1NXbkJhTi93WXg2Q1hvREZWSFAyb2JuUG1VSDFTY1I0bTh3?=
 =?utf-8?B?NnR1UmZMZFlVVWhDSkh4QTdlVFdPUW1laXo2SkJzWG1NTGQ3enhGTVMvM29a?=
 =?utf-8?B?N3VwSmU2WUN0RzZ4ZVM3QlQxQUNQZW4yeWJ4cUdtdDl1WlNMZWcxUmFPZXh1?=
 =?utf-8?B?eE9Od2t2bFZYY0JQaHcxYXhsbkNQWHQvbjU0b3ZDWnFIZ0NMcVRSbFVXajRk?=
 =?utf-8?B?Q2lIbHJSazVzeFpQay9EdUp3ZnZNaFdUVGNtc1h6dXhZanRpK0R5djVOSGd5?=
 =?utf-8?B?UTVmUFJyOFNEWUR1WDB4RVQ3aTViYTBnbDJaTlhBb3hZN2txMzFaZXlqWlR3?=
 =?utf-8?B?cWh3TjBSY2JwY244SUQ1Y281bTRHREJtV2tRR3YyN3l2ajlwSnNsYWpGM1Mw?=
 =?utf-8?B?bHFDS1hLUlhtU2N4NEtwOFpubnZYVytnZjEvMTc3bU9LZzdzQTlNVWdBSXh6?=
 =?utf-8?B?cm5NM1ZpcFg3dVFiMTh6L3ZEd3BrM3NZWjV5QjMwckJQTGFVSVpEdHZIZ1Bw?=
 =?utf-8?B?RFRYTDV0SWFyWU5sMUdsd0JMTjJpUG1nN0l0Z0Mzem9NMHo1dVQ5K1NLZjZL?=
 =?utf-8?B?U2FSQmRlZGhKQk9Ub2IyTm9ZQ0hOQVJacXB2QlhFY1NMclNhZS9iRVFsOURa?=
 =?utf-8?B?VWVQd0dzcVhWMWQxNU4ydi9EMWgvYjBsMGxxYnY4cHVUOWNaUjFkV1B2RGs5?=
 =?utf-8?B?SU5WcklwaUZwRlZyazNuMmg0OS9GK3ZNUmxrMEY0LzhBSm56cHpoZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f704b390-7969-4002-bb64-08de9fa136ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:26:29.5637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yE4yWWF/EbNKSfJVKmhBDF2iwe4Ffi4sfDrhdxyVOyBKknC9swS4SYbq2BHxyXKV/vp18Ya/MKlFROu3NUpeKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11249
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

Switch the Phanbell i.MX8MQ SPL to full Driver Model (DM) boot flow by
moving early device initialization into devicetree and enabling the
required SPL DM subsystems.

Mark GPIO, USDHC, pinctrl, and regulator nodes with bootph-pre-ram so
they are available during SPL. With DM handling MMC and power rails,
remove legacy board-specific USDHC, GPIO, and pad setup code from SPL.

Update the SPL initialization sequence to use spl_early_init(), clears
BSS earlier, and explicitly enables USDHC clocks before handing off to
board_init_r().

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx8mq-phanbell-u-boot.dtsi |  41 +++++++++++
 board/google/imx8mq_phanbell/spl.c       | 123 ++-----------------------------
 configs/imx8mq_phanbell_defconfig        |  13 ++--
 3 files changed, 56 insertions(+), 121 deletions(-)

diff --git a/arch/arm/dts/imx8mq-phanbell-u-boot.dtsi b/arch/arm/dts/imx8mq-phanbell-u-boot.dtsi
index 05f809c035d..11b81f0bbb9 100644
--- a/arch/arm/dts/imx8mq-phanbell-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-phanbell-u-boot.dtsi
@@ -2,7 +2,12 @@
 
 #include "imx8mq-u-boot.dtsi"
 
+&gpio2 {
+	bootph-pre-ram;
+};
+
 &reg_usdhc2_vmmc {
+	bootph-pre-ram;
 	u-boot,off-on-delay-us = <20000>;
 };
 
@@ -13,3 +18,39 @@
 &pinctrl_uart1 {
 	bootph-pre-ram;
 };
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
diff --git a/board/google/imx8mq_phanbell/spl.c b/board/google/imx8mq_phanbell/spl.c
index 642167bca59..f3aae9256c1 100644
--- a/board/google/imx8mq_phanbell/spl.c
+++ b/board/google/imx8mq_phanbell/spl.c
@@ -6,22 +6,13 @@
 
 #include <config.h>
 #include <hang.h>
-#include <asm/io.h>
 #include <errno.h>
 #include <init.h>
 #include <log.h>
-#include <asm/io.h>
 #include <asm/arch/ddr.h>
-#include <asm/arch/imx8mq_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/clock.h>
-#include <asm/mach-imx/iomux-v3.h>
-#include <asm/mach-imx/gpio.h>
-#include <asm/mach-imx/mxc_i2c.h>
 #include <asm/sections.h>
-#include <linux/delay.h>
-#include <fsl_esdhc_imx.h>
-#include <mmc.h>
 #include <spl.h>
 
 static void spl_dram_init(void)
@@ -30,107 +21,6 @@ static void spl_dram_init(void)
 	ddr_init(&dram_timing);
 }
 
-#define USDHC2_CD_GPIO	IMX_GPIO_NR(2, 12)
-#define USDHC1_PWR_GPIO IMX_GPIO_NR(2, 10)
-#define USDHC2_PWR_GPIO IMX_GPIO_NR(2, 19)
-
-int board_mmc_getcd(struct mmc *mmc)
-{
-	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
-	int ret = 0;
-
-	switch (cfg->esdhc_base) {
-	case USDHC1_BASE_ADDR:
-		ret = 1;
-		break;
-	case USDHC2_BASE_ADDR:
-		ret = !gpio_get_value(USDHC2_CD_GPIO);
-		return ret;
-	}
-
-	return 1;
-}
-
-#define USDHC_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE | \
-			 PAD_CTL_FSEL2)
-#define USDHC_GPIO_PAD_CTRL (PAD_CTL_PUE | PAD_CTL_DSE1)
-
-static iomux_v3_cfg_t const usdhc1_pads[] = {
-	IMX8MQ_PAD_SD1_CLK__USDHC1_CLK | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_CMD__USDHC1_CMD | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA0__USDHC1_DATA0 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA1__USDHC1_DATA1 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA2__USDHC1_DATA2 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA3__USDHC1_DATA3 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA4__USDHC1_DATA4 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA5__USDHC1_DATA5 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA6__USDHC1_DATA6 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA7__USDHC1_DATA7 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_RESET_B__GPIO2_IO10 | MUX_PAD_CTRL(NO_PAD_CTRL),
-};
-
-static iomux_v3_cfg_t const usdhc2_pads[] = {
-	IMX8MQ_PAD_SD2_CLK__USDHC2_CLK | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
-	IMX8MQ_PAD_SD2_CMD__USDHC2_CMD | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
-	IMX8MQ_PAD_SD2_DATA0__USDHC2_DATA0 | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
-	IMX8MQ_PAD_SD2_DATA1__USDHC2_DATA1 | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
-	IMX8MQ_PAD_SD2_DATA2__USDHC2_DATA2 | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0x16 */
-	IMX8MQ_PAD_SD2_DATA3__USDHC2_DATA3 | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
-	IMX8MQ_PAD_SD2_CD_B__GPIO2_IO12 | MUX_PAD_CTRL(USDHC_GPIO_PAD_CTRL),
-	IMX8MQ_PAD_SD2_RESET_B__GPIO2_IO19 | MUX_PAD_CTRL(USDHC_GPIO_PAD_CTRL),
-};
-
-static struct fsl_esdhc_cfg usdhc_cfg[2] = {
-	{USDHC1_BASE_ADDR},
-	{USDHC2_BASE_ADDR},
-};
-
-int board_mmc_init(struct bd_info *bis)
-{
-	int i, ret;
-	/*
-	 * According to the board_mmc_init() the following map is done:
-	 * (U-Boot device node)    (Physical Port)
-	 * mmc0                    USDHC1
-	 * mmc1                    USDHC2
-	 */
-	for (i = 0; i < CFG_SYS_FSL_USDHC_NUM; i++) {
-		switch (i) {
-		case 0:
-			init_clk_usdhc(0);
-			usdhc_cfg[0].sdhc_clk = mxc_get_clock(USDHC1_CLK_ROOT);
-			usdhc_cfg[0].max_bus_width = 8;
-			imx_iomux_v3_setup_multiple_pads(usdhc1_pads,
-							 ARRAY_SIZE(usdhc1_pads));
-			gpio_request(USDHC1_PWR_GPIO, "usdhc1_reset");
-			gpio_direction_output(USDHC1_PWR_GPIO, 0);
-			udelay(500);
-			gpio_direction_output(USDHC1_PWR_GPIO, 1);
-			break;
-		case 1:
-			init_clk_usdhc(1);
-			usdhc_cfg[1].sdhc_clk = mxc_get_clock(USDHC2_CLK_ROOT);
-			usdhc_cfg[1].max_bus_width = 4;
-			imx_iomux_v3_setup_multiple_pads(usdhc2_pads,
-							 ARRAY_SIZE(usdhc2_pads));
-			gpio_request(USDHC2_PWR_GPIO, "usdhc2_reset");
-			gpio_direction_output(USDHC2_PWR_GPIO, 0);
-			udelay(500);
-			gpio_direction_output(USDHC2_PWR_GPIO, 1);
-			break;
-		default:
-			printf("Warning: you configured more USDHC controllers(%d) than supported by the board\n", i + 1);
-			return -EINVAL;
-		}
-
-		ret = fsl_esdhc_initialize(bis, &usdhc_cfg[i]);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 void spl_board_init(void)
 {
 	puts("Normal Boot\n");
@@ -150,6 +40,9 @@ void board_init_f(ulong dummy)
 {
 	int ret;
 
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
 	arch_cpu_init();
 
 	init_uart_clk(0);
@@ -160,12 +53,9 @@ void board_init_f(ulong dummy)
 
 	preloader_console_init();
 
-	/* Clear the BSS. */
-	memset(__bss_start, 0, __bss_end - __bss_start);
-
-	ret = spl_init();
+	ret = spl_early_init();
 	if (ret) {
-		debug("spl_init() failed: %d\n", ret);
+		debug("spl_early_init() failed: %d\n", ret);
 		hang();
 	}
 
@@ -174,5 +64,8 @@ void board_init_f(ulong dummy)
 	/* DDR initialization */
 	spl_dram_init();
 
+	init_clk_usdhc(0);
+	init_clk_usdhc(1);
+
 	board_init_r(NULL, 0);
 }
diff --git a/configs/imx8mq_phanbell_defconfig b/configs/imx8mq_phanbell_defconfig
index 4c95363ad07..07354a78629 100644
--- a/configs/imx8mq_phanbell_defconfig
+++ b/configs/imx8mq_phanbell_defconfig
@@ -7,9 +7,6 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8mq-phanbell"
 CONFIG_TARGET_IMX8MQ_PHANBELL=y
@@ -18,7 +15,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_STACK=0x187ff0
+CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x180000
@@ -67,16 +64,17 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=1
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
+CONFIG_SPL_DM=y
 CONFIG_SAVED_DRAM_TIMING_BASE=0x40000000
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
 CONFIG_PHYLIB=y
@@ -84,13 +82,16 @@ CONFIG_PHY_GIGE=y
 CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPL_POWER_I2C=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_DM_THERMAL=y

-- 
2.51.0

