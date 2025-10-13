Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84B6CCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 07:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F55683936;
	Mon, 13 Oct 2025 09:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EwUAQ4Wa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DD118384E; Mon, 13 Oct 2025 09:00:10 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 718158381D
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 09:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgLlen8+4UtaIPGNgENpB7Bp6PSE0D0Ntyx5Vt3C9CUeBIRSlTJGRg4rrReySN5jhpe2pMepEkOhj1nELvobP5vPd3b2hgSNqkXUUGJtc8gz2CtlWIrq32JW+PveaA1AiFz66xG0tqIgN4JZlaMhmd/0tNm+YeC1ImTKc8/yDtrsJ/LZpu2w+xqRHTbQlKPxLJkTo6iGar6JUpTu8xJ75uV1hcsuEde8PgTzJ4VV9KdNH25zBEFOoVbn/LgL0+juabAmZBnk2BWjbw9DZ3tbLaCeOsxRhFb4gK6o3PssQ5VTivsXp2mxkdHIcndMYYdpqvclXhBDLQU0Q92p33Okyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0KSxBUidr203IiKTsxOnvAjZAHKR7thk2KtnVZEWVM=;
 b=jhlBhnh4ERyKmsKNE/APoS33OEiE7DlG3hzHhrYFfz4/Iux3o7A6P2ywuZO/jHis6G9QOx86wE+h1zSxDRe1HEo14a9Ia51d/rXHmxsVGaGRxS/rAPSJWU7R6PEsdI/VkcyCBnmIaD7MxpERdn9Q7LjduT/xyXyj3HT9IvUgV1H+a7jamjbQqlj6VGxjPo+IKx/RhlMJYOWNwpVsjbQ/YNGwVJu8B39pKEk/NhULzoeHITsow6pcKioRmPlx9iHOqZiU7O8KIZ3OHenY3OmmMauZbf3XDGdEHjV99OoRy5beJdbKONAhkQQ//ACgsonQSgKvKjQMrOz8RvaWYR0dMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0KSxBUidr203IiKTsxOnvAjZAHKR7thk2KtnVZEWVM=;
 b=EwUAQ4WaTf9pOziNa6gF9hLNNStBAjPXY7arNIoDN37hG0nDHruXLgJah3VZ8tJ1F3GddyBEmIgRUnfzK/XfuFo30d3si7aboBw82Z3ckVaR6NxuLpxwHPkeTxaKLh25uA9R0DiOmoyougnkqcTM28oefPQxaw5qjinTAgJGkIOtZf+/TB8kxy+brgrH4ze47HhTmyKfwT/HmT3q2ArH4KKco6vCvj3RZaQwFR5lYXFukknZedY1QrJtVFRoc9z6pHLAc8yy4Sjr+2EhChb4pWQKouwrB0XWk60cpziJSYC1yaZQJBYlJ0WRt09CsT5g0U9KSJd5QiNsw/ttrdeojw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 07:00:06 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 07:00:05 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 13 Oct 2025 14:58:46 +0800
Subject: [PATCH v3 05/10] usb: f_sdp: Update SDP driver to support PQC
 container
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-imx943usb-v1-5-293e79d4bc12@nxp.com>
References: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
In-Reply-To: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff7d1f5-9b96-4671-4fcb-08de0a26233d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDJSY3RJRjBEWWUwbVUzSW10NzQzcHhyRkpHM2R5dFFuajJ5ZHBMOGlDSVpL?=
 =?utf-8?B?bTZTS24rQUtZWCs4eExRbjdNQU0xT3VTVkVJdE1mL3Y3NXNZTy9TZFBDVEpO?=
 =?utf-8?B?eUszQkp1bGlyc2duR1lHa294R1FVRXQ4cnVJY3A0ckhBczY3VjFVdEprLzhk?=
 =?utf-8?B?NmxVM0dBM0FjWURwbWt5c0N4bnhrdmhJaGJPZWs0UlpHcU14TVhZTjFNdFpi?=
 =?utf-8?B?VEI5VTBaVkFiTFAvU3VsdHI2R3E2aW8zcDdKdkUrWXF0TlZzOWVGME5SWmVF?=
 =?utf-8?B?ZzZHQVJ6OHN5MGlVWmxsN2NOaGZDS2xwQmN3SXlwd29aWWpkNEp5TW9Bc3Fv?=
 =?utf-8?B?MDAzZU94L01ucFNOdkowVmNDSERVL0RQMmlGS3AxS2ExUmtLMjJWRXdjMFdw?=
 =?utf-8?B?TFdEOEdiUXhPT2NZbjU5ci9hdC82U2xUdnU5RVMvNmFkR3R0RmQwd24vdlY3?=
 =?utf-8?B?UjJ0Ym5NYWVZdE5vMXNxbk9kUFJYTDBTdGhtaG1UT2VmcS9Gbi92Ny9xQUlr?=
 =?utf-8?B?cVZOdFJoakZpb2NRb01RRURic0xYb0V4N2l2aS9ZQzROL0RRblhWa2RadzZk?=
 =?utf-8?B?S25rUlhxak5TMEpna1JEaExzRXo3d3Y3alUzUjBHNEZPS3Nqa0VqeWRva094?=
 =?utf-8?B?Zzh6MldMNDcwaXFrdnFsdU0zTU5rdVRodFlDcHJTUm04bmhrSXN2OTRxS1VW?=
 =?utf-8?B?eVUvcFRzYkpsNks2OVN2ZVI4ZTQvUnNGenZCbzk0bVV0cjBJbW50NTlwRGdm?=
 =?utf-8?B?MVBHcllCbmc0UDd0SFBtYkZJWmlOdWtBa3hjRXVlcllETFFqQ2J1Sk1LSzBk?=
 =?utf-8?B?WmxjNnp4OVQvc3NKQkNNN3B1Vyt6NC9ROHA3bVFTaUUxd2NpOHZsRzlDOEJx?=
 =?utf-8?B?ZDBoYmdVbzhNSzQxUXY2SUE2RFN5QUpaMExOYmd5VmlDRkFhNytwSTVXWlp5?=
 =?utf-8?B?RlFUaFE3Mzh1M0Q2aDJva0ZjQ0dtc0VGREhtRWFnblp6MVYzeFFRQUFrR3F1?=
 =?utf-8?B?aDFxYUx5WmlnMnkySGJtcjQzZkJiZFo0Q1BhVDdTVzBsYWtrR2lJK0Voanpv?=
 =?utf-8?B?OVMvNEp4TFFrVmZHOHZuenE1cFFoeTZBQmtZMk5EclVLcCtMTDlHWVgwUHNq?=
 =?utf-8?B?UE0vOVN1Mk9VWWZyVy8wTW9EcWlybUZVNkxFZjljY2FLT1ZGL253NnQva3NM?=
 =?utf-8?B?TkhCQTZzdGI1WktjYklJcnhKVTdJZ284MTRNYUlxOVpMcEliZnlzdzBWUW9r?=
 =?utf-8?B?QVcybWErSjJtYm8xSng1eVhLcEZmMzRxR2JvRll4WkNDUzYvYnNxc0pnRm1M?=
 =?utf-8?B?RW1BdUNjQXFqT0wxTHV6WDlzaTVIczdMU1E3TEhUK0o4MEJiN2I3eU81b2Zt?=
 =?utf-8?B?bnMrYytTd3lNM0d5RStaWSs4VE11cHMzUVRqMFVDOUNicnpUMzhreXJDY0dM?=
 =?utf-8?B?Q3pTcHVxL2VqNEhZbXBtbllUZ3JOS0tXNWN0UE1NRTBaTGFQQWo2dmZ0Undm?=
 =?utf-8?B?b09wemFUL2oxUTRFM3IvdmpTQzFCY0FqcE9VM1oySFhxME5BWkY2Q1BxZ3c4?=
 =?utf-8?B?ZTZqenhhaE1zd2VFRUpRL0FqbkdwZnNwNDIreEx5TVRFYUMxUlAwdkh6Q3pO?=
 =?utf-8?B?cjkxM05EV3ovYzZpeC9VTmM3Z01hSm1jNFBEd09qWDNNSWQ5emtRMXJLbHVH?=
 =?utf-8?B?a2dCSE9wME01aUZJSlN3YXY4Z1dzM2hodldtQ2pBTUNTTGxuQnl2aG9NcVU0?=
 =?utf-8?B?cXQvT3FPM3RkaU9McnBwOC9HYk92UGRkZE5qNmhRTTRLRmRsTG1pc1VXMWhM?=
 =?utf-8?B?OHloRmVtLy9NUGY3NXFZMWJhbC9hZ1VtRjYwYm4rbXRXTUNSQXFlVGtpQWEy?=
 =?utf-8?B?azB4VWZsN2c0Wm16dEtZZDQ2YVgwRHAyNmhYMEZMZEdJak9QQUN1anlGMHF0?=
 =?utf-8?B?bTZveFB6T25vMDJ5UW5XdzlScEZrRDVQNkUreG0xcmUwdDNFdHZxaWJRS2FK?=
 =?utf-8?B?bjlJV2lMMWtmUDZrL3dnZTAxbjRmVUtodkNna3NnKzVhbUZWbktCOSt0NFdh?=
 =?utf-8?Q?Qh3jiD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azN3bFFENlROR1FWMjdRdllaYnY0a3Y3bnM2anlVZjFZaHgwNjJrNkhmTWxK?=
 =?utf-8?B?cEdQa2xScUxQOFNKa0dlSElMU3VVVkJvaFNkRXJzMmI2YzZ0dHZrWU1OWWhC?=
 =?utf-8?B?OWpNNm9XTW94TGdtdTVuUlEzVE1NTWhTbHF1RWR0eXlzdW54a0s1b2FjcGls?=
 =?utf-8?B?ekdwU1hCWWhPLzE2czI3ZVZxWUJYWGQ5Y1p1VnRQS3hteGtqTXJJUFJxUUFl?=
 =?utf-8?B?bjl3WHRmR3l5MDNFeGQ0NFJMRkNtWGo3akdNUE1QTjMwWE5YdUxDS1RyNWIv?=
 =?utf-8?B?NTE5bVFPbzlGdStlT2FoejFtb3d0YUxob3dieDVudW1YQmE3ci9JbnA1cUJw?=
 =?utf-8?B?M2RVdzVOdDhUTjhFamphVzAxZ2o5d1l4RW02L3I3bCs1bExZUi92SDdKYkxR?=
 =?utf-8?B?M3V5cFdTUGN1TGhhYVNqeTdaS2dJM3kxQTl5cFhkZlpFQzdIU2h3aTExVGpM?=
 =?utf-8?B?MDFlbVcvMHZTRkt6Q3ViQWlYRSs3YUtrWHZ5MVNsc3RMa21WM2ZDMTljRDhY?=
 =?utf-8?B?eUlFa3VITWVwT3ZnbGJiT2k3ZytPK3JCLy8weVdweTZ6VmZCSE95aFpvblk5?=
 =?utf-8?B?VU94enRYYkVDdWxwSW94MnhyeEN1Rm8xYlZWNDllM21DVmtMRkdITC9OeW5K?=
 =?utf-8?B?RjlSSDhsaFBucGpKNXlWbmFRaEl4WWZ6ZG1GR203THpWTTR3cG9ZK0pqY2tU?=
 =?utf-8?B?cG1UZmdMOTl2YlBxeEwrMDN2RERTT3Y5ay92UXRrd0Mrd2t1VWs3dmJqTytq?=
 =?utf-8?B?ZHowbGd0NEtYaFlDU1pBMlBhVklrbElkRnBXWGFteDRKNytHWmFmVURKK0Ev?=
 =?utf-8?B?U2xuMHlhQzNaWWJvVk02ZDBlcUdPVStFWmpCN1orcFFoeVN0WkdUZGNnS1pw?=
 =?utf-8?B?RHB6UHQ3VmRtM0thdW1IamdGR1BHdEFUc3RRMXlPMUZlVDhnMk1SM1lXOTRM?=
 =?utf-8?B?d0Yxa2hIdU5CYWlleFZXUjV0eG1mQkNndjRyZnFvQ25MeFJqWkYwN0pPbC93?=
 =?utf-8?B?ZDcrMFNYTmVZcG9DOWkybUFsMmpwVUJST1VsUW9Mc1kyY0svUlB4aDA1QU5V?=
 =?utf-8?B?N1NoQkZqUlEwZ0FvbUhHdGtpWUg2M2swY0FOd3RFT1c0Q1lIV2E2akQ3ejhV?=
 =?utf-8?B?L0NGOENnVEpock4zQzJscjBtTWVhNHVSczVhY0J2dzJFYmFDUG5mbE1iZVM0?=
 =?utf-8?B?dVRrRHY2KzFFZWdQSXBSYTQyY3MzV0c4eHRqbDBwdUg5NkdRUnlrem9Ea25j?=
 =?utf-8?B?bytjWEZNWkVsOUd1M25NeXJKTEpBMGdKakxGbGdiTFBHMWthZlJORDZ1WHNr?=
 =?utf-8?B?dGRBZzVZbGNucTlEYjB1elJ4Qk5DVjhtSndIMzJUNDA4TkY5aWtXRUs1S0lM?=
 =?utf-8?B?VzI1TlRET1ZSMlFWUlJwbTdYUlEvbHFFRENYK0pKeDFKbXAycThZV1pZQlQ0?=
 =?utf-8?B?THlpeVNwdzJJNmxvc1NDbm5pcHB5b2pDaFZweVFNcEovaUhsVEd0WTJWN1hJ?=
 =?utf-8?B?dkUrZDUwWHowdEtRY3lhc05NVmloK0Eyc3JmUWZZeEVBUVpvY2Y3eEFCOWM1?=
 =?utf-8?B?REhoWGVCZmpnR1hhNXNOeXZ2aFpHZGNrdnRmc2o5MkFaejk3NWZtd0IvSXNR?=
 =?utf-8?B?R3A4M292ZlVYb0lLVmRNYWhjak0wNCtSYm1vdkNkZmwrTTVhdUpJSXR1SGpC?=
 =?utf-8?B?N0NONE1iSUtuRlQzTXh1eGt2dEVLam5KS0JHc1d2ZjAxbmp5R2ZSa082SUt1?=
 =?utf-8?B?VkRVWktkMkcyTFduRCtSYWkvY1ZneFJIK1hWWUVmczdIUWxVTFk0ZnFtcXg0?=
 =?utf-8?B?S1dlYjc1Z0pRWUZ3RlVuZ2ZRdkFGbVNDUys5a2drdlpCS0o5ZGo3MitBZzZG?=
 =?utf-8?B?VEtTUWcyOEdXTEdNZk9CN1F6TzFSWk84cy93WCtEbGFPTTlkYk8rZjB2T2lO?=
 =?utf-8?B?QUxKS3pFZHhOTUpLMjVpOWtXbFdzR3NnZjcrSSsyeUhOK3dyNmlRVjdxb3I3?=
 =?utf-8?B?N1hUVVg2aTlnRkFkWXRUQXlyNTVEUkd0M1BVbEJYajIwTlY5QVZlQW5WWVRu?=
 =?utf-8?B?VXlxQlMrd0lzdUZ3S0lHTFltRWZzNFZPT1lvN3RuSVlaWFhGNlRuYzh2NDZj?=
 =?utf-8?Q?4vrpn18QL1P5aHOcjwecHpYG7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff7d1f5-9b96-4671-4fcb-08de0a26233d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 07:00:05.1997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8tPDCXcUVqya6kBG8G6vtgRY3DcS5LcNfH+WBWMbLK0vLOvOvpAkfsBuTsbTcGyfdzhAdO3heufcEhtDeqGHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098
X-Mailman-Approved-At: Mon, 13 Oct 2025 09:18:15 +0200
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

From: Ye Li <ye.li@nxp.com>

Since PQC container has changed version to 0x2 in container header,
update the header's check.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/gadget/f_sdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 647001d8dd0..f72e27028b7 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -765,7 +765,7 @@ static ulong search_container_header(ulong p, int size)
 
 	for (i = 0; i < size; i += 4) {
 		hdr = (u8 *)(p + i);
-		if (*(hdr + 3) == 0x87 && *hdr == 0)
+		if (*(hdr + 3) == 0x87 && (*hdr == 0 || *hdr == 2))
 			if (*(hdr + 1) != 0 || *(hdr + 2) != 0)
 				return p + i;
 	}

-- 
2.43.0

