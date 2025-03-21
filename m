Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA73C35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:17:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A45C807D7;
	Fri, 21 Mar 2025 08:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DuXstl8e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB4FD805C8; Fri, 21 Mar 2025 08:16:22 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B080B8141E
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3BdO5oUi/IN2hzv3RwkNZ7SShJecJuJSRqq/XNzukRrzF7RJ1tYfLs8Bbyy5LIULXdaL2+3DtkJ+AvpDXtNWTbailwzU50+OMHCWxrZgD/LuQEvdL168/5NTT+Ve1sFwtAvn6XpOoK5pwRlqc4Dy072EjQIW+meSJwpSmNC9eC42dXDCrb3ldtiFX5f9arHfcpKQ9Xz82vvu6ZK8NlxrXXZpFTav+ulTy/wVOKMT4erK09w8j1KIjlpYKBysjvMH1ehxFlpa4hjd2DrTMt2A9WI8w5XwuowWbmaROoBgIFhAm0W6PxChzjgO/pqbixvJ8ONFbGjv4sqkxGxTruuOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAaAAsTjsZwG1Bbj+fmN2LTXX56e3cIP6iBjVFcKyTg=;
 b=fKFLvPAToZNTMqL7hu8N3F1uA8W5UHrxElH12IgNsQaOANwf4rkVeQ2fkkcop+DsJt94tmF6Xf4GjZjtwQABCy4mjvG4hwpvYOdvxCjmKxjIWtysCd3WJ2Z3rwgS3cASVwTofIOsqgVnGno8x5CcDCvQyra4l1z8tpXdgdQycH53agpfR6o6G7C5+X8Fv3wo2nDxM9ISN+oAUl7YYwdlGtItHRS2fPpJI7lJi0gHsfVwJMxYLgr8sRiNa2KCJ4yxMMeii8a/FN27wMrgUVImutDX/FT8plY7sVy8XqIP81rXoMW+7Z2aeYRGA+T3oKoCtg6YEIGTc0IU3jmSlXOdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAaAAsTjsZwG1Bbj+fmN2LTXX56e3cIP6iBjVFcKyTg=;
 b=DuXstl8efhoO4Vo3ZaYGQta0rBn/5sIFWM6VeuQaaXwynOgsDVFWtEAF+Ud3Bs3y6KEnuiZqbgv+873egtqBqzRSSPh3YkJCNhxkDyDl2lSVTQ6yVSEmYAzjkgzfmp29fbx7RWhN8On4+5gI0F7BQj9kvOWlnKEQiNpQ/BlSltP6BqJ8DQmJ8FUCs+dVCUSH+xegSCFfIeDejkcgMGodsHlmDrlzl5xpIyFRZ+Do585loxrvyUp8M5k/8gL9mwnfrj3HF1v9stsQO99H05LECoOR6Vmo3WCPujoUOgHT4YpPWA8XIPe1MJXl04kQlCwhe5aNWJd7HWJUREeIC45LYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7421.eurprd04.prod.outlook.com (2603:10a6:800:1b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 07:16:18 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:16:17 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:20 +0800
Subject: [PATCH v8 06/19] clk: scmi: add the command CLOCK_PARENT_SET
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-imx95-v1-6-f2c8ba815f89@oss.nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
In-Reply-To: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ad0501-8089-4c90-02c8-08dd6848460c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tlg1TlJpWWV0NmFBbG1JY2ZCL3B3MUI0eXBtSXBBbjNBVXhmVE5sd3RDOHB5?=
 =?utf-8?B?Q0VoWVJFaHBOWCtMYlFqSFFJRm9JL0tveFhta3J3K0hvdjFadU1ockE4aWNq?=
 =?utf-8?B?MGgxS2YwUjlGT3J4OEViZlgzdldNa0JtbnFscnJXZndndGFFZWFHSzZWM2k2?=
 =?utf-8?B?SWF5UVhIek1PaHp4MGZBM1BVamE3S29IYVNubnlvZEo2QmZWeE5iVldxUFVJ?=
 =?utf-8?B?bGFyRUlZT2hOaDFZRFJ5dGZ5bXg0UzlydllEa1Y1M25jaFE0ZCt2ZHBwc2kx?=
 =?utf-8?B?VlF6cWNoRWgwL1I1bE1VQ2wzQmJJcWdmdzhuaHB6NHZQZzRhT3VVVFpFdm14?=
 =?utf-8?B?TWFONDQ5SHZZOVlNS040bXo5VHZITlNIVkZrZGxwYWp6cTk2TFBhbnAvUU1Z?=
 =?utf-8?B?VnBuU216SlNyUlA2d0FLNng3T0dxQkFhVlE2Z3QyY1BGaWhqZElNQnJYZmZz?=
 =?utf-8?B?UjlYZWw2cHZCM0lOOVZWNkdLTDZuRlBKT1RIelJRS0FQZnJ0a3N6R0E5S3J0?=
 =?utf-8?B?ZnJuVUZYREw2THdxSjRYaURTazRCWmxwMlUvRE1yUEVmaisyVjZYNHE5TTlM?=
 =?utf-8?B?aFJzWFJPbHZMQU45azF0TnN3STJ1aXd6ZXNrUExCY2hDRVJLVGRWMmJycHFq?=
 =?utf-8?B?QU56cFZNTVlNQjdYbk4vM2Q1TStUbzczN0wvcE0rY1ZtNkJ5MkVYQUVON01R?=
 =?utf-8?B?Q25YU2hoRlBwc0lpRFBLa2toMVRPT2Z6bVdzajdpV2ZPLzZWTVcwaHRYWGYv?=
 =?utf-8?B?NS9BU2ZSYlk1QmtnRm1jbmpGT0NqZVpCNnNkbTlzUFJvMm1najdVM1BMaDdW?=
 =?utf-8?B?ZXM0MGpVb1FOOTRpWllsZ2E0ZUp0VW5FM0taeE93RElsV2k0YWJUZHY3T3V6?=
 =?utf-8?B?aUNHYk1VeFJ5Tlp4RHlJQ01MZ3p4MFNFUlBua3MxQVRneS9ZWDFTdHBFK0VJ?=
 =?utf-8?B?bnNHVzIyL0dtY0NsZFNUK2ZMZkViVHVzQ0RGS3ZKSkZUblJzQXFaRlV5SWRp?=
 =?utf-8?B?ekc3bkllQVdZcHBuVGRwblFncUo4TnFROTRldTBOSzFqTG5vTjBZdGRMaHpF?=
 =?utf-8?B?azZpcFJZYlF0aVphclM3eUZkNHdQVWhFMlFna2NUNFZJYWFsbVM1TEpqUVQ4?=
 =?utf-8?B?RU5EaEUxTDlwa1dkNXVPWDlsR2RYbHNOKzNINHFNa0k2ZnR2b0RNTFhRQ0pY?=
 =?utf-8?B?L3kvVEZob0FlZnhNNmdPU1piaHVJMlh5YmVtNEVaM3R4QjdVbmppamptWWZP?=
 =?utf-8?B?TTNoQU9WQW1aZTJKZ2tRQmJod0J3YjFja1JnUWVBWms2U254RjRudDE4SFJh?=
 =?utf-8?B?VFhYUVBJc0NiQVN1TFVhRjg2d1dsYkcveVNYdGRibFpEa2N2OEs5b040S3dH?=
 =?utf-8?B?M2syTE91V1VMU2F2QnVnZTk1VUdWYlRYdlozYXNlRFRNUUlON1NjQlR2SytU?=
 =?utf-8?B?bVN3OGx6MEx6V0JvTDNEQm5jc1R2cTJxZGREd1BRbkEwdlB0UjBMSHBjYXBT?=
 =?utf-8?B?dlVCaG1KdUVUQU5CODJjcVNCQXgrL1EwSzI5VmZUTEg5Q25nWkh2U3RoYlJO?=
 =?utf-8?B?b2VsaFg0L0tUUWQ2YVJRMWpERXoxZzR1MTh1eVJPbTliMUVxNTAyT2FqU2U0?=
 =?utf-8?B?NFF5YXlNTjJySE11eDJEUmFLbEdrbkpKS3ZDNU4xbWo4WGxCblNKRlVhM2dF?=
 =?utf-8?B?SnNqZktsOHpQK1h4TnhrNXFQRnNsblVFN2dnS3p4YVZ3U0hWUHR5eGVhMDhk?=
 =?utf-8?B?aEg0L0JWQXR1UDNZSVhTMXpFY3ZyS0NncHcrQzFGckVUczM5UUY5QXVuYXNN?=
 =?utf-8?B?NlVwemdTdzlPdjZHNG5HdXBnY2dGT3lYS0poOHhvUUdTM21TV09QMGZLL21a?=
 =?utf-8?B?R2xiVXhtQ1NjQkpvVVFGUmpVREsyZmhudE5sOFVVV0FOY2pwcXI4NWRMMlZm?=
 =?utf-8?Q?M69Aa+OGd5O8HcIAwwS146mQgVGTAsLI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWg0b0V6dnhudXBwYWZUSkVVMm5sTUREQitNUWdBMHJvTG05OThwVUEzNlBY?=
 =?utf-8?B?THhSSzVUL2orT3NSVThCL3Bud01neStBcmlRdzdKVFdWVUNULzVSSGVDQjQr?=
 =?utf-8?B?OUtyRXBOODdVS09VTXhWSXR1b0FiU3dKUHJnUkFlTUQvQ1FSUkp2YXUzc3VI?=
 =?utf-8?B?L2xPSUY0WGJtQ2pYNGk5bGRlRlFEM2J0MFRqUlFVQ3Z0bGtYZkdMN2xXZmlS?=
 =?utf-8?B?VEdDWTR4MkRQWksyd0N4aDMvKy9lSzdZRWFOTkkvS0lGL3JoWTJHWVpkUmlV?=
 =?utf-8?B?TndPc0lDcVdsVG1tUlhvWUdmVnA2YmlBMkRUcFhHaDRyVDVwd3hGUDZVWU1j?=
 =?utf-8?B?UlErSlJhaytuZmZsaWVvNWVibW9wTUMvZno4VGs5S1MxQkRLYVQyWUZ3c0ZU?=
 =?utf-8?B?RTVoR29MZ0NHN2xLVDFGL0MwN00vZ0VsSzVIVlg4cmdCYWxPNjBnMXozYU16?=
 =?utf-8?B?WWYwZzlHQWtxQ2hCZm1OVkdZMUhkdzJkR0xWVWJRM3FkaVFBOG9tVDBXSVdj?=
 =?utf-8?B?ek5jTGZPcnJlOGx3Q0pUR01aMEZVNFVYcUs4WnNKTnQ3WlNKd291L0RVeGl4?=
 =?utf-8?B?eElZaHRadFlKWTlUaGhqdUJsNnZjR08zNFJpUjRkbS9GZ0ZsSVcvRk9XblZH?=
 =?utf-8?B?STAvaXE5bDRXTGEvMVFBUkdqTkoybWorcS9IVnlBZ1laU3ZmMmJqNjBjOGp2?=
 =?utf-8?B?a2lHb2kxdkJ5ZlB5SXgzY2U2MVd2YlgrUXZQVms4YnRFSytDNjNDOTJ5a0xQ?=
 =?utf-8?B?SHpNL3FjM1RRWDJXYWhLdXJySDhZSnZyWjhocDk1OGZHamRzMUhyK28wME43?=
 =?utf-8?B?amRKbWZRdUxyaUZCUjBYbnZhMzBCa1kwY2RtL2xtbWdZQnNRbzhUU1NRNFUv?=
 =?utf-8?B?bkF4UlYyVjQvSWFNM0JGSVI3NytDY2Q1c21uNTNpNGFjOUIzZ3RzQnNYUlRs?=
 =?utf-8?B?S2t6SW5IaU1uTlZnaTBrVERXSUtwVWZDNTlxWUNZYWxZV1phV3pMUTV6cENz?=
 =?utf-8?B?clJBd1JXM25TSFA0ZWQ2SnFtbEwzYXBwVEplR013NU5hdGxhbzRhSjB0bzdO?=
 =?utf-8?B?K3VucTEvOWduKzBQS2xXOWNVNnJmaDBMVjdUNmRXb0daVFVVNGU1eS9Xbmxu?=
 =?utf-8?B?TTFtMCt6dWpORVVGTjBhTzgrU2R2Z04xcUlUeFFaSDhkam1tcnhkZVdZK1hz?=
 =?utf-8?B?T1ViZlFXUm9RNC9ZSzhXcHBxaDB6emNrN21JQ1V4ZDhvckt3dEdzdmRsK1dF?=
 =?utf-8?B?MUlzTDd0MWk5aDVqdEVPTS9ub1RrZWxFdUplM2RoOUpiRTR2bzRnNWdJVlN0?=
 =?utf-8?B?clkzb1c0NkExTUNaMHcrN3BBOUorVVdlbm1pSjFaQld5SUxiSCt3OEZPbTI4?=
 =?utf-8?B?OHowR0RFTjVOaHFHN1ppSWN2cUhHdFRJRzYvR3B6VzQvc3U1ZWRUeEx2SXRw?=
 =?utf-8?B?Zkh1WWY3cnVhNFBIdmN6WUVxRVNoZXZyN3pIL0xKbUxETm5XV3JqMFVId0py?=
 =?utf-8?B?YXpDVnIweGp5RUxUYUlNNURja2lxK0dqanFTSTBxaFRPQlQyUjZCMXZBWE03?=
 =?utf-8?B?eS81ckJzV3RLMW5LSDNCVUFJcnZ3UDNvaVpiMGI2WlF5b2FlZ2VOT2huemto?=
 =?utf-8?B?QmlEYWo5M0M3U29aUmF1NmhQOC8vT0NOMEdxb3ZyQlZjeEY5eUJpOVVFMWFE?=
 =?utf-8?B?Rm9RL0xMbU0xRVcvdGlRRXdSYkd6TXRqZUUreGs0bVVXQW9CdTNzWUdlRE04?=
 =?utf-8?B?TXU5cUtRL1VvZllWUFRNdld6VE9JWGhNMmNzYStOaHppSjVScjJXczF0WGFX?=
 =?utf-8?B?WG00L1RyZytXU0JNK2EvNEdJd2ZtMVZidjZhR0g2V3YxQlRCbmJvamwxOTUv?=
 =?utf-8?B?NEhicTc0ZGUxZzY1U1FUelJoTi9VNkRzSzZseXpKWVRHTnNkcjFZcWl2SGh0?=
 =?utf-8?B?OUcrczlISE9DWm5YOWhsWXZGS1hQK0JkZ3Rud0o1VjRWd205OFZtMm1nMzZD?=
 =?utf-8?B?SEx6NVEyRkVENHpuL3JEMFZwcU5JV1JOYXpLS2lpM3ZHOW4yd3ZMSG1CV1hr?=
 =?utf-8?B?R2lHR3VHcjdhMUpPSFFXeVRrUFZWMHFJVlpUYXBLMGpvRDZ5YjBac05mcDVE?=
 =?utf-8?Q?PSWufzQh7AtKGOSBMh6rsGrnp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ad0501-8089-4c90-02c8-08dd6848460c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:16:17.9461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiXl3ligpBYT8ne+kg18EoZLa2sOhci1a33b0FGNCPdSgK1byudMUnOws0HmG8s/QE0k55Hfa5Pen0gd/9exoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7421
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

This patch adds the command CLOCK_PARENT_SET that can be used to set the
parent of a clock. ARM SCMI Version 3.2 supports to change the parent of
a clock device.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/clk/clk_scmi.c   | 20 ++++++++++++++++++++
 include/scmi_protocols.h | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index e42d2032d45..84333cdd0cc 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -178,11 +178,31 @@ static int scmi_clk_probe(struct udevice *dev)
 	return 0;
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct scmi_clk_parent_set_in in = {
+		.clock_id = clk->id,
+		.parent_clk = parent->id,
+	};
+	struct scmi_clk_parent_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_PARENT_SET,
+					  in, out);
+	int ret;
+
+	ret = devm_scmi_process_msg(clk->dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	return scmi_to_linux_errno(out.status);
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
 	.get_rate = scmi_clk_get_rate,
 	.set_rate = scmi_clk_set_rate,
+	.set_parent = scmi_clk_set_parent,
 };
 
 U_BOOT_DRIVER(scmi_clock) = {
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 34f272c448c..342a65ae7f4 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -737,6 +737,7 @@ enum scmi_clock_message_id {
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
+	SCMI_CLOCK_PARENT_SET = 0xD,
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -839,6 +840,24 @@ struct scmi_clk_rate_set_out {
 	s32 status;
 };
 
+/**
+ * struct scmi_clk_parent_state_in - Message payload for CLOCK_PARENT_SET command
+ * @clock_id:		SCMI clock ID
+ * @parent_clk:		SCMI clock ID
+ */
+struct scmi_clk_parent_set_in {
+	u32 clock_id;
+	u32 parent_clk;
+};
+
+/**
+ * struct scmi_clk_parent_set_out - Response payload for CLOCK_PARENT_SET command
+ * @status:	SCMI command status
+ */
+struct scmi_clk_parent_set_out {
+	s32 status;
+};
+
 /*
  * SCMI Reset Domain Protocol
  */

-- 
2.43.0

