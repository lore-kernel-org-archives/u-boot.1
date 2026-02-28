Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756A61048925
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 01:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EF5483F59;
	Sat, 28 Feb 2026 02:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AqNBWBwH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C98283F20; Sat, 28 Feb 2026 02:43:40 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CA6E83F4D
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 02:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5ZhQlYrAc0y34ydt4Np3HCLeBUYftHmAlb9kLW4+8ncOP0BaZXxQsjewRdKHKDc5Kr+bE3L0EgGSz7aOSxlZWtjrDEnHFnycSwnuI/JEQwgb8ueB+2O4Vl3P387O0DTybG6V7yYJd183VBxxp6lNLZgAGVrp8D8yUW1JJ/L+d8jhEomf17BpSVVDchfldqNPGHgH5Xa1HmJ/+8dE5IVKrFaiLSorjBQzCYdf/5sV1XKAl0bl9ErR9PpLprPE5zjRyXrlnwrB8B//rdb9nCfdjZdC5xO/iuiYl0M5HiV6wACbRIwoeq3Jdk1XFH9VxUQfj5k9bnf6lItS30i8G/ANw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAbpixsxTHHdYnnm3dJvHbWa0eMRM89uD+OFc7+vWcg=;
 b=nGqJsn/+l4+oWvSbs236Ta8qa56Z66iqLCCEgAu+GaqgJEVRmS4hckPUITnse5k45NB5HTEL7JibIikn0f52WBIxIvON427UhhygRmJj7plrj2rO6LbzazAMuZCB/LlMhOHa7SA25JyVxgQ8Sfz2u7R/yhlAKv0hXUIL79N1oQkMgisx+3JCeaCteqpyNtK2d6vNSB1rCqDL0wnfk9aDO5uf6Hb3mdEtKgkgRWJYwkDPd+XcHsXva26gRSAaXHRZyzdYnyB4hZoh9Kt525ZRAkRY6wv4dHihKAfK4axJXrKHEx7Dh7Ut/1bdTEwhJ4a4u/bVby7q3VEBFhHQ+rr5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAbpixsxTHHdYnnm3dJvHbWa0eMRM89uD+OFc7+vWcg=;
 b=AqNBWBwH60lZD6GAe+KZCkaq8h9vRIvYcQPopkSXe+H/u8dOcICUTcbAMLxqoj8HXd9NsIwffmrf2MFCn5WdBkTuj1kb/UDNhIHTFVjvwioCUZCClXjOA0KvbKN+KXUcCPHRUP6oDVSv2HI3J+JjcSNCncwRS2ZPBp7ux1o/SyUwp6phm5f94RvxobFGieeZYc2eP5fm7NlLbzi8ztLFAP24SvoDkB0/DPMBVof5S+4Fk6yfOwPUutoKVrbWUSOsIQGywFXcloAcG2Qygdm4ufDoawqTaFpsWutN4LOODGWP+cFFIbDQ1L/TQZ6z65gvLz7TKR9vHxm7xiorqtd5XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by MI3PR04MB12440.eurprd04.prod.outlook.com (2603:10a6:290:75::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 01:43:34 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 01:43:34 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 28 Feb 2026 08:22:25 +0800
Subject: [PATCH v2 07/13] arm: imx9: Add i.MX952 SoC support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-imx952-v1-7-0a360e7e8cb7@nxp.com>
References: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
In-Reply-To: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jacky Bai <ping.bai@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Jindong Yue <jindong.yue@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|MI3PR04MB12440:EE_
X-MS-Office365-Filtering-Correlation-Id: 7236ea8d-19c7-449b-1f69-08de766ac913
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: q0cetxpKJUyYSgDQRAMRpwCfskV3xMIu7RpVmKNUBmqOOzlunHikRv3eNcZwd//ouj/twNL99Ua+ACa7/WI6TlLEESmlcWSea8nLct8fkWVR/wowc7pqB5crwijCrqB7axigaCHOQ9SSd4km+KxD9JUx/4yaJRjSlJBHJaZ5o5gHPfITgYPwWc1y4d+/gzp3opwdE9Nhnx3gUmNJil5dFe8exM9r3pVjewU0s8JW7uJaVv/T925ZVpbMO1HYXcePF3RPciy2rkNM2IRi/klLpXvnsWAVGpSZ7A/rTBD78g2Ju6UazXY5Xt1BPapE+DXPAaqwqH8+33McqkrX3yp0TxS4Jy84W6ekaG6M6bUQcvCgqKv52rwJ9dGVfMZJoPFGgDef8zlyhqDhswgEfGof+bikikGLog/6m1QhbYZCEab1lQfLE0ftD2RckLZCX8FEOEE776LJienD8lnVXCYe2alCJdsSjdO4OugalP70SevG80ZvjWX6/gd+VTwrZjTI1sD+pOrgnlh57ON34i9Yu0bpj5ZO9zmbQPJCpYqcxQzV4yk9WfnLuqq6Vvp+TgSnItRRznitk+0uNfP4YejbjHyxFYZwxLK0wVqHqqFP9boaWnU9PgtcPN1awiOsneyZGl6+jt+tQcZC3s1GdGR5/PMwRYu2Np6xDp8FK3tMwbA6F/5emvREMh0ssr3VbxTvkMayCztIsYqNL7Cz4+a4F5w6FbDY9iDxYjeBggNj1C53qmpz/xom3NO0I9ic9NWbqmtRph8lJS7NaqSbXAjvlr/ON8bn0yvtSHa6x9nrhXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clM5VWo4MHVNajV3SmsrMlF3Z3BKc0lIWlgxaW1WUERqKzRjR1NyWU13ckwx?=
 =?utf-8?B?U3l0K0l6N0wySGN1b051Q0pteFhRL3BUQTlvOFNuejByYm9rM0hKVUd6M2Vj?=
 =?utf-8?B?RG4wSFp6TVovdWRpNFhkdTlJZ25wQ0lZN21pSWM3cDJRN1NndFpITFQ5WE1G?=
 =?utf-8?B?VUg4UUFjZHpSZWVsdVQ2aEZPSEYyNUNJZmRFc1Y1a1hRSzhMTFpSb2NXcE5x?=
 =?utf-8?B?QjNUbXNLa1BScXBWc3R2cFRvRVZPN2dpN3VPME9mKy83bFpTdGFSRGJqUU5Q?=
 =?utf-8?B?aXVycmtxNnZKdFVubVhPbFVZcWFqTWNqbWVWeE1QVWd6ZTlDM2FDbnF2dEZO?=
 =?utf-8?B?Q2NIQ0tTK1hHK2VRa01mSy9GMC9HL00vWU56ZW1IajVLV3NvUUl2WWlYR0Rr?=
 =?utf-8?B?cndub3FwbHdaOFlOc05KekxhNGdIeFVEQnUwVHR1UWNyZUJOSDFFT2V1Y2Vo?=
 =?utf-8?B?blZnRWJTTkp3MExtWEQ3UHdhMS94WnJOdTl5d3N3KzVab2prR0NLVmVBdllL?=
 =?utf-8?B?U1Z2T3hnNUFpZFVFTlJjaE9qbThlUitYdHY1UlRUQ0tpTFp2WEQ2UjJxMzNY?=
 =?utf-8?B?Mk9qeElKMU9FZ0lhUm5tdk9RR1pleVRJNnJlZC9kRVR1OFlrOGNqeml2a1Fw?=
 =?utf-8?B?cmpReDdpazBtSVdCRjhCVHE2bkVQYythMmp1Mkx5Sk5iL2V5YTRJV2VhdGE2?=
 =?utf-8?B?UlVIci9qTzdrdEJTT3k1VnVEQzArUGFYREN3V2VWL3NaUUMrUkxqVStSbGty?=
 =?utf-8?B?dGRiWm1CaFB5dlNUZ21YRWVmZXNuRDVNdXY4TjNuNEw0aloveVRqcG04eGhu?=
 =?utf-8?B?cUJQSEFDQmNFTWsrSFlqeENWMk9BRWtOVHdnbEh2RGU4SHBRMFlJR2JPU3NC?=
 =?utf-8?B?QXp2OHJtNXV5QlNmRk03dnFMRW5MQUpUNHlvcnZBcWJQWURTV3Yxa2NYVXZp?=
 =?utf-8?B?ZVFlUmErQmh0TWNlMlJ6QVBRQ25LWWpjZE1helZqb3VTai9Ock10dlFuWSs3?=
 =?utf-8?B?bFNMUUJVc1AvbEdsS0RPUFgwSHJHVmY2QkoxTjFQc3NXWmt6d1ZTQm40cEtV?=
 =?utf-8?B?NTk3Y1V6dmJkZnVOeFRCVENHUmliZ1ZUVWpUd1YxY29USVVPRmY1eU9sekpZ?=
 =?utf-8?B?emNTOWNodXNUT0NCc1FLT3JsaDUvUkpZVk5HMkN5SlBNTzlNbVh1aU1PcWgv?=
 =?utf-8?B?TkhOeWE4M0lwcWZQaEtXZzJHYk1DNVF0M2hzMVgra0oxaXY4UFN5aHNURDBa?=
 =?utf-8?B?SEUyR0RYeEZTVDJDelN0Sks3TE5Xb3REMEVzUkIvb3U4a3hNRjdJV01tYXBr?=
 =?utf-8?B?R2Q0d3RkdnlmL3I5ZDIzWjk2OE9QSG5lOTlSZzVGOFRGcHMyVEZBcVFKNjJy?=
 =?utf-8?B?bWNZTk9xaklYMGpkSGMyQmY0emhPaXVsMjVoWjUyMUtyOG9VV05FOWhYR3Ba?=
 =?utf-8?B?ZWJ5WnNyTy81THhNQy9SM0o0YlRGNFFRUTNyWTZpeFl4dHN2dEZUQXJSN0FS?=
 =?utf-8?B?d29UVDVOcjJWN3R2eTdENnpxK2ZKc3JGbDZIWHFmOXcycUdqSEM3emUzUUd6?=
 =?utf-8?B?ckxHUU5UOGVkaFBXUWhkOUdPcDlsQVIvandZZDFnTEFFVk1FemVhNFZrd21F?=
 =?utf-8?B?aEEwdmZVTER6SXRJTUp5alBuUW9CVWlxV2dBZFJzZTZTdzFuaVdKVDlxejdy?=
 =?utf-8?B?dHVVNndZaEZVY3IrREh2SjlzYlJNUjZIUFkrNE92TzIvWXBTemJsN3B6L29w?=
 =?utf-8?B?L3p1cUlUY3hkSnJLakEzNjVhaW95LzNVVURLeXVLREp5UDBTNUVQcmU2N1ZJ?=
 =?utf-8?B?SFQ5S1pFU1RYbXJLWlkweXVpOHBFZEtmYkRsRWhuZ0dyM1JRSnR1cjA5Q3da?=
 =?utf-8?B?UCs2d0c0eUJUcnIwY2pQdTNva0JBQ1hqMG9hRENKa29ZRTFNSS9wUWhUb24w?=
 =?utf-8?B?RzFNWEFaQWhiQnA1U3ZCSDRabTE3czFPVEtZeG5MZ3k1WkhiWkRzeExhY045?=
 =?utf-8?B?MHh3d1N2NDNMSkRIOEJvTnBZOHdTQ0E1VlA0M2NxR2dFZWVMNmM4VnRKc29y?=
 =?utf-8?B?RHhUQ1JCaGYxTXRaQ0RKTCtrQzBtdHgyYlBMSXJicGFxTE1hY2VGUHpzK0Jt?=
 =?utf-8?B?NFZNZCthOFNYMDZvWW5iQ0JBRjYwVm1WSkNYQ0hkQjBKTHRON0hoZC82cnZJ?=
 =?utf-8?B?OThmSS9CWS95bFZ1S3ZNTnR1YUpoWktvKzJieEs5NWVNTjY3VzduN2VSSm1n?=
 =?utf-8?B?OCtsYks5MmhtTFdtbGRSeEhZM1o4TzRWaENSYm1sbXJEV2xXdWp6am05L1ZH?=
 =?utf-8?B?ZEhNN2NMMjhkcEhXSTY2eUVRMzFsTTBqNjFiV1lGVHdsOWYvd040QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7236ea8d-19c7-449b-1f69-08de766ac913
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 01:43:34.7050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVzPx4eJg+9lbc5u2ci+DzinsPSrOLahbGjQXNJb9B/HHnB6mrmogoEwZ+KwAIYne9ie4fEPjtME5yfp0HlhUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12440
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

Add basic SoC support for i.MX952:
- Add CONFIG_IMX952 Kconfig option
- Include i.MX952 clock and power headers
- Set CPU speed grade to 1.7GHz for i.MX952

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: David Zang <davidzangcs@gmail.com>
---
 arch/arm/mach-imx/imx9/Kconfig       |  9 +++++++++
 arch/arm/mach-imx/imx9/scmi/common.h | 10 ++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c    |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index d9f97e4328c..716940930a6 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -47,6 +47,15 @@ config IMX94
 	select SCMI_FIRMWARE
 	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
 
+config IMX952
+	bool
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select DM_MAILBOX
+	select IMX9
+	select IMX_PQC_SUPPORT
+	select SCMI_FIRMWARE
+	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
+
 config SYS_SOC
 	default "imx9"
 
diff --git a/arch/arm/mach-imx/imx9/scmi/common.h b/arch/arm/mach-imx/imx9/scmi/common.h
index dd4675402c7..c3610127dce 100644
--- a/arch/arm/mach-imx/imx9/scmi/common.h
+++ b/arch/arm/mach-imx/imx9/scmi/common.h
@@ -21,6 +21,16 @@
 
 #define IMX95_PD_M70 IMX95_PD_M7
 #endif
+#ifdef CONFIG_IMX952
+#define IMX_PLAT 952
+#include <imx952-clock.h>
+#include <imx952-power.h>
+
+#define IMX952_CLK_SEL_A55C0 IMX952_CLK_GPR_SEL_A55C0
+#define IMX952_PD_M70 IMX952_PD_M7
+#define IMX952_CLK_FLEXSPI1 IMX952_CLK_XSPI1
+#define IMX952_CLK_24M IMX952_CLK_OSC24M
+#endif
 
 #define IMX_PLAT_STR__(plat) # plat
 #define IMX_PLAT_STR_(IMX_PLAT) IMX_PLAT_STR__(IMX_PLAT)
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 2ac2a93e796..538190e23b7 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -153,6 +153,8 @@ u32 get_cpu_speed_grade_hz(void)
 
 	if (is_imx95())
 		max_speed = 2000000000;
+	if (is_imx952())
+		max_speed = 1700000000;
 
 	/* In case the fuse of speed grade not programmed */
 	if (speed > max_speed)

-- 
2.43.0

