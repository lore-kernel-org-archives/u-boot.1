Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9F8E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A53180107;
	Fri,  3 Jan 2025 07:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Godn59lN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28C6080196; Fri,  3 Jan 2025 07:45:55 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C598F800D7
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJfn63xNgNTxYrI4pq7mvE3xRruxcxF2jfOr4vpXT9ly03ccrN6/d9j9/BZGpBYZhP41239xIZZ5MEH2cqiXv5irG+cBHwdmVodY9Wmic8K9VWcIo/U3jRkYzarlyR7Bhid+CJx7XZrGNhk318t3aoOrIQHzMzSfwhw4St9n3YXtEh62jmvhR6EB+o/lNNxi96N+7ZHahwU8zhbFKyZ20fkKWDCGktuPudJwxSY4U4hVj7dqxLN/uGZvBtMjXiJw4C90xNNHjU8IAKItnU84iMTcV7GWu6as+/hcfrurCg7iR+zVwbLK3gyOrxU3IixQgKaspzUx6o8LnAPf0sFk9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRRl5O9uQT/wDEpd4NTySgRcUiKKde/bE1WeC/PIMuo=;
 b=a07tt3Ak6VeSLlgxDxN/8MZs/OkjMBnd9ZACPd8B3liqiVbBki4MUVRAW5jksVqcH/lVv1I6T2/gYO8szWy/MD5sT01W5IZx+fyQRjSgkXgx83ZEHpuJ050nZBWVvpQ4EdbQxzjW7ltDRYt58xvNzf5OjbQnimnbJ5cZJ9hGzpx3oVlGi7sRQdSv3CTaqTI7bXAn1GrQbslB4/E2YLKZ1OJxXnVUnuJKNS00h3A9IcffsUxf3xN0Iz2jXxuRrEFDSe8V24Z8YlLyHhT1GlgXWvb0pq5CTaKRcG+gr4meFllAa6Qzuv2oW0cSvD6bje/5mdfikcNQ4Xc//xv46hKsuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRRl5O9uQT/wDEpd4NTySgRcUiKKde/bE1WeC/PIMuo=;
 b=Godn59lNT3wpFDPCLyiJxO5oE0NICvxHYhyw+Ve/ZBrvGmcojgKoayJ7+XV6qpe1mUFutuM5p+vBkDCkcZ2452q4rHA7lSHp0Xzt5XEjHGw5joktpDLzkzVHwjdk3o7vxuMgELeAWBkVhHDeXrtDnRmVosOP3mQ/DJctkSFLeimNL7TbsHTOPc//AknrPmQZS0aKdJJ0ppgFKiehGhCj47V00soUIA6fjMKsuIJk0NXZ5wCLwBgof+Aezj7U5VOSPFmih05bIT5/wSQ98YOqYq1nRWzrVgdit6uMnUGpTBT69qagSADS2NAqB0xMUxyGAaRa6Zp0pVTtJPZ5zH3wlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAWPR04MB10054.eurprd04.prod.outlook.com (2603:10a6:102:38b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 06:45:46 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:45:46 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Subject: [PATCH v3 00/17] imx: add i.MX95 support
Date: Fri, 03 Jan 2025 14:45:35 +0800
Message-Id: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI+Hd2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQwNj3czcCktTXZNEi9S0xCRjsyQjSyWg2oKi1LTMCrA50UplxkqxtbU
 AqPc+J1sAAAA=
X-Change-ID: 20250103-imx95-4a8efab36b29
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com, 
 Peng Fan <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Teo Hall <teo.hall@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735886747; l=4846;
 i=alice.guo@oss.nxp.com; s=20250103; h=from:subject:message-id;
 bh=aLkLYDyvnxQecQ8G0s6tdm1zmXH2znNCM3DZw71VD4E=;
 b=NRs93wndaLeD0wQwjormnzKCLul1mPD9awAIicozIyEANlP1sYANrrzAimi87r0+wCPNanehO
 7jtG5n8qXLFAwMO9LTHEv/2DQ2YJ7SbNZm2oFre9TZVHyVI7/9Jh35I
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=6RXhk/KbIrPIkIaZWptZot1vwQyfwwp597Dp3Ydq+kA=
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAWPR04MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: 93eb1f10-7747-4812-9400-08dd2bc240b5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzNQVUZ0MGZBZ3NjdjU1N2tzSlNSM2x6d1JOcThqRHl5RkVtOWxndnZrR0I1?=
 =?utf-8?B?ZS9heTZDUUJHUEFEMHBCbDNpR2I5V2Z2alVmVFEyd25HaXNkQTdzWWJCaEdU?=
 =?utf-8?B?V2syRFJHNGEvZUdNVVZyalFYN3RuVFJiQWpnaVl0dVE1VFFNdkEwMHV4K0ZI?=
 =?utf-8?B?eG82Um9pVmFYcnduRUdTVlEzQWJnSFhxVHdPR1R4SmhiTUJZRE1CTU1aOVpL?=
 =?utf-8?B?VnQyTkFRdzJKRVBXcURTSzJCazRtZEgzanRKS2F5aWVLaXRhTnRnRUl1L1Zw?=
 =?utf-8?B?Wnl4RkFoNC9GcEp6WnRYaGdJNmxmbWJUYmhoWlpZbFloWW55NSt5dWVobXFa?=
 =?utf-8?B?Wm5RVGVMckJnMFZjcXR3Y0UzSDkwVVFjU1JTdzRwMGdZeXdEMU12RXlpVHNW?=
 =?utf-8?B?Z3N6V2NUOHdoc2lpeHhhZ251WGZXL2p1RVhFVFNNbEJOS3FOeDJzbXg1c0o2?=
 =?utf-8?B?eWx6NWt6Mmo3WWNRVU43VXhVbFVqay9HRFBjM29CRjFIM281WXR5em4xTUxn?=
 =?utf-8?B?RmFtVGw4RU1VWnBCQ1FmOVIvZVRNdUlOZ0twVGxhS0RzTnZIN0VxTUl2eGwv?=
 =?utf-8?B?RG5wUU13TTZGd3hwY3BZTE96bGR2Q0Fkdno4NXZ4dzR4bkVZU2lmekJ2R2Nz?=
 =?utf-8?B?Qjl5SkxZbE9XWjRmRkdMS0tpaVRuMjZxRnllWFBWOGlhYjVDckhzekxGWmJJ?=
 =?utf-8?B?eDFLcDgreUVNTnp6ZVE2QXFhUzZSTTl1VjFvdlFHSVhpSnlpODlWK01wSkR5?=
 =?utf-8?B?NGhEZnlOUzdwUmsxcDRWZHBwYUFmZHpMWjFNcnY4NnFkMDFIeUt2aVFzeVF1?=
 =?utf-8?B?SENwWFVUWVhEcUdYanlMS0I5R2hnblJqemJuYkJ2YWFqTGpLUHVuUHVGMGZ3?=
 =?utf-8?B?aHI0b2FkaU54WVFnUWRDY0FqSStiMjNCL0Z6OEJGalhkbTdmS3FkVDIydGpO?=
 =?utf-8?B?OHFHOE8vTGc5Skp4YnEvekQxQVVJNDdlNVNQNzRvOG4ralViazl4QWtnL0VK?=
 =?utf-8?B?blp5Z0t2KzhvL0dJTWlyQ1M3cWRiUTV0OUpiblBOU2oyNkhwWE1YTDBsUVdo?=
 =?utf-8?B?Q3FKY3lsUVZGZFZGKzdWSTdBWUpyekY3QzgyUnBxYzdVL2REM2N0OXpwUlAw?=
 =?utf-8?B?OTVnaWxWR2pDWHIzUEtLY28vQUJBS0w3bEFwOFlCS1dXVEpKSUQ4RTB2VXQ4?=
 =?utf-8?B?OWtHa0toMUZ2cVg2ZlRzSDAydElyNUhqaXluNjJtbXZzY2lUSmc1RmIranVa?=
 =?utf-8?B?R3JKMDMwZWUwRlVHNTFkcUJtOFBscnJVT0FxbnJ3ZGEvWGpyWmsreTRKNGg3?=
 =?utf-8?B?elNGZ0FPZWxYYURlYzZnQitzN1drSVBmR0prMmxhanR4Q25wZ3Z0MXNjUHlN?=
 =?utf-8?B?eURWeFlOaE1KcGFMRGJVcVlPak43dWhseXZabmdFYzFxWTRlNmoxYk5hT1dF?=
 =?utf-8?B?NGxzNG1qa0kwYkxUTS9sSXdOMVhYSDFPNk5OcjQyS0paMUVWZkFNTmdLSG9X?=
 =?utf-8?B?dFE2TFc4UWtFVGx4QlRyNmVwVURlNmptNGxnRm1FWnpYekttTkVDN3dEcEhk?=
 =?utf-8?B?YzE0WGRWMlJhZEdFZDhBV0ZpK1IxRlVITWE0a0pQeUxtVW9UdFk0UnQxY0M2?=
 =?utf-8?B?YnRkQkxLdGlPSzMvZ3ZFOVUvQWFIb1lwVFNSNU4rMFZIbWRyWEMzdnFJRWIr?=
 =?utf-8?B?VjV2MG1iQjFER0hnN2FDN1hQUXFwbkFFcTRnYXRTMjlpWnQvblgyQ3UxTEpN?=
 =?utf-8?B?V2ZWMm5xYnRxWTBEUk56V0VBMWNtNGd2L3l2aG1ZaFh3bytZN21vR3RBazBp?=
 =?utf-8?B?QzZEVWl2ajVVSkI3OFpkR0lxNTVZMVRvZHJ1T0pSSWxlVHp2Q28wNGFZa01L?=
 =?utf-8?B?czNWaEl1N01kRWd6cmh6YVVBZEZVMTdtQUp4bW1oRGVGelZTWXptdE13UWxw?=
 =?utf-8?Q?K+LXy3sOs+UlZI/X1WLDoEHpGywd49Em?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1Qxa0FiZTNIWkJocDF4SjRLY25wd0tQMDRTSjh0cHVzTzhsT2JOOFNMZllv?=
 =?utf-8?B?enBaaHE3NmRBN1pneTVvRnRIMDJqS2lIR3loYm4zVzFyb1VQMGpZUmF3RVc3?=
 =?utf-8?B?clg1ZGpYN0tsZ1RkUTh6T0sycTBxTE11UHFRNk9DNGIvdjhBK0x3VGNZMkNR?=
 =?utf-8?B?YmRBcG0wZUNLdnI4L2RSRWtibGRvVWVtTW1PRU41OG1hNzZLRzVKVk5tUjlZ?=
 =?utf-8?B?SVBOdG1HcU5yaEJWcG9mUExIYVZ2bVNWTERqSmJuU0Y1cUZER28xRFg5WFpP?=
 =?utf-8?B?YmlCdjZ3dHVIdDZLTWNYNEJlZ3E0SXdSMWNZcE1vZ2RwaDZXa2NpYm0xcTBa?=
 =?utf-8?B?VnVIZHYwNEhJSkJqUWIzeW4yL3FLa2RCeGxVeWhlVWZqbXY5L3ZUY3lGU0hK?=
 =?utf-8?B?cWdlN0s0bXdxYTRkRlpOSzFHRCtxTzNucDlMeWFkMlZkZnlWN2lQVHFXMUxq?=
 =?utf-8?B?aktJWjlLZ0hsYjU4UG0wY3RPVTdaMmI3UFo2blJsbmxpZHlhNjhwNTk5Y1Av?=
 =?utf-8?B?dHJIVFBiRHlCdFFoVzM5ZFdUTXVtQ1I4N1VIMDdMbGUrL0RSc1QzRUtSTXJV?=
 =?utf-8?B?ZktWd0kyaUIxQmlTRzZaQU41QU1sRERxWnA5cEVCbjFuTWFlZVFUcEpMZ3FE?=
 =?utf-8?B?WU9MclVHcGliWVB3NDlLTXlOVjhjYXBlaUU3WVE4QytWMXpVSnpmbng5emhW?=
 =?utf-8?B?dHdPRFJFK2FYWXh1cGNXVWNGVEd4UlBWejlnZHlBbjdBbVQ1VllBRmxUNkFX?=
 =?utf-8?B?UDh0ajRuM0o0aUFPTUtCeUcxN3ZIcVJYb3A1NzBmZ3ZDT0p5V3ZhNDFISEpa?=
 =?utf-8?B?MWZUaVpra2RSaHk4TElwSnNxT3RrcGs1d3ZGcGt3R08wQXZYczlHNWQydE9C?=
 =?utf-8?B?MzBjRWd5QkNZQ3FFL0tZbkVyc3o0SXBSdE52S1UxTG5mVklDaU8rMHB3aWF6?=
 =?utf-8?B?NE5sYlJkZWlUdGc0S1hUNkdlZzdzUDdmdXBJWFprbUNWY0lES1puUXV4WXZy?=
 =?utf-8?B?ZExCMUhPZzR3cXdMb0NqRXErU3VBQ1AyT29ORDN3aWk4Yytackg2U0xVRTlj?=
 =?utf-8?B?Y282V0tacFBWYlZjYkJRVi8vOWk0L3hxL2ljSm9vS3BnQ09MOVJ2WGlaOFZF?=
 =?utf-8?B?L1liSU5sL2drQ0s3N1hCWFF6T292UDVPZ0ZqUklOZy9FdnBKQW1QWWMyTCtU?=
 =?utf-8?B?ZlVlejZ5eU93S2tWRFhzNDdUeG80VlkyQzFjVkd6L0VTd2E0d2F5OEErN0Ix?=
 =?utf-8?B?RGdZOTNnUzkwODk2cDhpbnZkYUFjMTkxTlFTeW9Wb2hiOHBPTGFuTFQrL2Nq?=
 =?utf-8?B?ZDk4VVFSQnVHMXJFcFk5RkZ4M3VPWDdRWVd6dlIwMW1UeWFRNVQ2YnVXQjJz?=
 =?utf-8?B?aEZ3dHNYUE5sNUZKMytJa0g5NWUycFJQL3IxcTdYcWRwdmRTS294UGZGaml2?=
 =?utf-8?B?UThCVTJXZm44T3AxNk1UMm5iZzhCa28ya0l1b3BqUmszZ29DMklDWEpncXNI?=
 =?utf-8?B?R1Nvanhpbk04RzdhVldEVUgxUFhIdEg4blB2b29QNmphR0t4ai9UODcxQ1JN?=
 =?utf-8?B?V1dkaHY5bUQrbTBUd2FNVWZqRlg2R0R6TFJHTDNXcDlOR0krVnRFbEdoZlFs?=
 =?utf-8?B?cGhPYW9GOWxSOHNvOVNBQ3FWNjFaZ3pVeEc1YmQ0Y2FDang3SFM0SjFnSk9H?=
 =?utf-8?B?bGI2Y1pXaXYzcnFQTXNQakN6TzcyVnVNNHZUVjJManlmZWRxa1FOREw5VHVQ?=
 =?utf-8?B?MkdreHZ2MExkZWY4MThpeVVVWUFtWjFLc1pLNHpWckNSTXlWMTVPZGMya0p4?=
 =?utf-8?B?YkhwUXpkbFpYN0lpcjIyMENvUkE2aU1CeHMxRTRUclF0UjB3djNrUTJJWWt1?=
 =?utf-8?B?REIwc3pwODg5VVVrUFZaSHovUHpqbjVWODlhdU9kVUtQZXU2MnJxajQwaDV3?=
 =?utf-8?B?K3h3MkxvaHRhRFhuVkNBVGtyMXhyMjZNRHVkVWlIT2dMblVvODNRRnBUNDlz?=
 =?utf-8?B?MVR3ZDc4M1hjM0Y4aS9wOFNsUWlFYm80dGJRVkhmcHlDVXB0Wml4YTBxTW9l?=
 =?utf-8?B?d05wblV5V3BkQmF2bERsRVhxcEZGMHlCRDlITkNhNXp1a2xnNHM2d1dkd3hV?=
 =?utf-8?Q?EOmwHCHBCOC0u2AkydFn4d1ah?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93eb1f10-7747-4812-9400-08dd2bc240b5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:45:46.7527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etyb8GstVWwuliXlFgH9adqrgY0FrChpKXuljjM6NWlC5eeWKGesmNsEpejplpsiRK2x+8IcbC0DPSiQFSWUcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10054
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

CI: https://dev.azure.com/pengfan/uboot-ci/_build/results?buildId=13&view=results

Changes in v3:
- update the binman etype used to add a header to DDR PHY firmware images
- create a test for the new binman etype
- correct issues in imx95_evk.rst
- factor out the common parts of i.MX95 device tree into an imx95-u-boot.dtsi file
- correct issues in imx95_19x19_evk.env

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (3):
      imx: Kconfig: IMX8_ROMAPI is not configured for i.MX95
      binman: add a new entry type for packing DDR PHY firmware images
      tools: imx8image: add i.MX95 support

Peng Fan (7):
      mailbox: add i.MX95 Messaging Unit (MU) driver
      pinctrl: nxp: add SCMI pin control protocol driver
      scmi_protocols: add SCMI misc protocol protocol_id and message_id for getting the ROM passover data
      scmi_protocols: add SCMI Performance domain management protocol message IDs
      clk: scmi: add the command CLOCK_PARENT_SET
      imx9: scmi: add i.MX95 SoC and clock related code
      scmi: add the macro SCMI_MSG

Teo Hall (1):
      imx: add V2X container support on i.MX95

Viorel Suman (1):
      firmware: scmi: smt: Interrupt communication enable

Ye Li (5):
      clk: scmi: check the clock state/parent/rate control permissions
      scmi_protocols: update struct scmi_base_discover_list_protocols_out
      imx9: add i.MX95 Kconfig and Makefile
      imx9: scmi: soc: Override h_spl_load_read with trampoline buffer
      imx95_evk: add i.MX95 19x19 EVK board basic support

 MAINTAINERS                                   |   1 +
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      |  68 ++
 arch/arm/dts/imx95-u-boot.dtsi                | 173 +++++
 arch/arm/include/asm/arch-imx/cpu.h           |   3 +
 arch/arm/include/asm/arch-imx9/clock.h        |  10 +-
 arch/arm/include/asm/arch-imx9/imx-regs.h     |   7 +-
 arch/arm/include/asm/arch-imx9/sys_proto.h    |   3 +-
 arch/arm/include/asm/mach-imx/sys_proto.h     |  40 ++
 arch/arm/mach-imx/Kconfig                     |   2 +-
 arch/arm/mach-imx/image-container.c           |  63 +-
 arch/arm/mach-imx/imx9/Kconfig                |  12 +
 arch/arm/mach-imx/imx9/Makefile               |  11 +-
 arch/arm/mach-imx/imx9/scmi/Makefile          |   6 +
 arch/arm/mach-imx/imx9/scmi/clock.c           | 328 ++++++++++
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c      | 148 +++++
 arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 +
 arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 +
 arch/arm/mach-imx/imx9/scmi/soc.c             | 873 ++++++++++++++++++++++++++
 arch/sandbox/include/asm/scmi_test.h          |   2 +
 board/freescale/imx95_evk/Kconfig             |  12 +
 board/freescale/imx95_evk/MAINTAINERS         |   6 +
 board/freescale/imx95_evk/Makefile            |  11 +
 board/freescale/imx95_evk/imx95_19x19_evk.env |  90 +++
 board/freescale/imx95_evk/imx95_evk.c         |  54 ++
 board/freescale/imx95_evk/spl.c               |  96 +++
 common/spl/spl_mmc.c                          |   2 +-
 configs/imx95_19x19_evk_defconfig             | 177 ++++++
 doc/board/nxp/imx95_evk.rst                   | 116 ++++
 doc/board/nxp/index.rst                       |   1 +
 drivers/clk/clk_scmi.c                        | 191 +++++-
 drivers/firmware/scmi/sandbox-scmi_agent.c    |  56 +-
 drivers/firmware/scmi/scmi_agent-uclass.c     |  11 +
 drivers/firmware/scmi/smt.c                   |   4 +
 drivers/firmware/scmi/smt.h                   |  10 +
 drivers/mailbox/Kconfig                       |   7 +
 drivers/mailbox/Makefile                      |   1 +
 drivers/mailbox/imx-mailbox.c                 | 417 ++++++++++++
 drivers/pinctrl/nxp/Kconfig                   |  13 +
 drivers/pinctrl/nxp/Makefile                  |   1 +
 drivers/pinctrl/nxp/pinctrl-imx.c             |   7 +-
 drivers/pinctrl/nxp/pinctrl-imx.h             |  11 +
 drivers/pinctrl/nxp/pinctrl-scmi.c            | 136 ++++
 include/configs/imx95_evk.h                   |  30 +
 include/imx8image.h                           |  19 +-
 include/scmi_agent-uclass.h                   |   2 +
 include/scmi_agent.h                          |  11 +
 include/scmi_protocols.h                      | 105 +++-
 tools/binman/entries.rst                      |  10 +
 tools/binman/etype/nxp_header_ddrfw.py        |  32 +
 tools/binman/ftest.py                         |  11 +
 tools/binman/test/346_nxp_ddrfw_imx95.dts     |  24 +
 tools/imx8image.c                             | 143 ++++-
 tools/imx9_image.sh                           |   8 +
 53 files changed, 3536 insertions(+), 64 deletions(-)
---
base-commit: ec9263b4f15c4cf82eb6a211c67baa6385065b8e
change-id: 20250103-imx95-4a8efab36b29

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

