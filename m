Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3093ACFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 13:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 769A8844EC;
	Fri, 28 Nov 2025 14:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sFKaelJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA51C844F1; Fri, 28 Nov 2025 14:17:51 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5F8583B27
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 14:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wr/R7iPX+NWmWyfjR0k7/YxiuLbDaTEbxPP8kIOD71XdbiZ6YGWsMvzMzk4bH64/f82H1imZmDkcyL2+UwwdpzX3b2NLyaTBnG5umZJ6luFidZYw3wSPoex61Q4PLDOZZZE6IS9gkEQV26qAUoBIUpe4XP4OhNj/ROvkq2vN9HKLiXV3V1eJ4BYt2oYBY/d0Vj9N88yagXKRT7nxZ5nC4GOQF3wArvSJKHsfJxKnlAdcLPA2mRdUFPX+Igc26WLr7m5916CJleLDiUAga4tfri5NqXEf42pw2ZrVx/fQf8WOvRy7nIYFDOo32+eczIVXtMmglCfvUS9SyV9xfYF1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nvi00Ee8/4/PaADCMymYMd3WczWsck5JlFr99+VciSs=;
 b=XPiD6mSxa614dkYOQOTP9j5DPZKNPuEqYIl5d7iQjF1Mc4syj0EKVs6AET3+psP6QojSWd1ByE17AwBC4NYJMBWnV5qFTKspgfEEVWszCmQ4Ert5RpIA2YLMb35b0OZ5f+ezuUCfmWLILRZBVpahML3dAtDYJWF9S8V93eC9aHmtr2mS3kbrMXKbvhZVKDuGbCc32ptxyTiju23wsNOEtaWbxwvYTL7JHnwlsTkwiFlhMCkiOSBQ8obifshMx2nwrCKMC19L0G/kBgl4B40Q1ZB/59bqkXfFbWCOj3X727rATfcOEGf8gFJYH/sRigy7HrhKcsohDnzBfA7VkC8biw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nvi00Ee8/4/PaADCMymYMd3WczWsck5JlFr99+VciSs=;
 b=sFKaelJdd8o8pAerrFnVxTnejNlWOaUA3SBDH/h+gPpqg5Mj5JYlahBFHV/WkSE315ETbI7kKhQvkxOYj0iJK81M+h4t2IKo3qG2GZsEeOutA+sxlGi3OyA2Y5IM01nzcBt5tTbX2XT1bL/+SpybJCnkZZlkptSzh5o+pbyoVEeiAawNygcvhwuEgmIFNfiOmqYWMmhOiBG8yclRS6eG7RC2FplCPSuvAs2ffgNbskg2VTCzCVQ9VO8SGiP+W/DhbhhJrTciKol3yWouW/4ThTuZTSspi+r3OF7KxDY5+fYzJAEEDXpd9w97GX3Pem1LkgIuvrqlnnuyeCaax0esZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by PA1PR04MB11505.eurprd04.prod.outlook.com (2603:10a6:102:4e3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 13:17:47 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3%6]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 13:17:47 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH 0/4] Enable USB on i.MX8ULP EVK
Date: Fri, 28 Nov 2025 21:16:32 +0800
Message-Id: <20251128-usb2-v1-0-25ec5ac127ff@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALGgKWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQyML3dLiJCNdQyA71TTVODXRwkQJqLSgKDUtswJsTLRSmaFSbG0tAC+
 tvXhaAAAA
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To DU0PR04MB9636.eurprd04.prod.outlook.com
 (2603:10a6:10:320::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9636:EE_|PA1PR04MB11505:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cfb232-6aae-4478-8a37-08de2e8085ca
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czNuVit1Ty9LNWlTQ3ZFM1J5bUhHTWRlays2UVVIM0lqWGR6dHpXbVpZWHFJ?=
 =?utf-8?B?d2tkVVkwbVFCNTljZWtORGwzejJoV0gzQ0hzNDFoaVVMSk1hbzhzU0pWTUtw?=
 =?utf-8?B?YTlrSXVPRWovM1QrdGEvZGE4cWRTZU84YUtIRmxsQ0VrVGNaNXAzQkhIVHQw?=
 =?utf-8?B?K205UjlIaVBTNENJZUMzdjgrN1owRHdCOEFadkg5cjg5azMvSG9veHgrMm1K?=
 =?utf-8?B?Qm5jbDRSd29ROXFHSWhzWjhGcDdNa3hxeEVNa2hRcldQWTJGMFN6Mm9VZ2t3?=
 =?utf-8?B?NnR5bFJiZWFGdlhoQk5vaGUxNktMVnIvVDBOeFEyOEZjYmpjOWtXRDZTNXAy?=
 =?utf-8?B?dWJUK3EvRHdwM2VNVFNqYit3VHQ0cU0yYnlZVTdjUCtsb1p3Nm9PeEVqUzFQ?=
 =?utf-8?B?eHRIRTJyVmVZS1pmTTEzOFFCbGFjN2d0ODFodkdaNWEreUtKQkRONjZvcHUx?=
 =?utf-8?B?c2I5a1hiVWtXYUE1NStBMVkxTmQ1Ni93TmR5UFpZQWhRYXYrMzFPdWdPWmxR?=
 =?utf-8?B?VzdZNGY0SGhoOTc4NWJ6b0RCWGg3KzZQR2M3KzMzTkZvdTNSdzBmUFlaQmEy?=
 =?utf-8?B?cEdISVhGNGhoV29RRE9VdzRtZS9CRGVLOHk2YSs0VG5DTzN2dEIxWi9rMHc4?=
 =?utf-8?B?N3VRaVVCTGZjWmFweXFVc0xTdHlsMGh5b2dhbnp1WUJIRkYvZFUwQVdVK0Ra?=
 =?utf-8?B?ZUxYaUJZcjZtMFdtYjRzanlxTEovMk1iWHhIOHppMXFIY2J1akQ1WlJMa3B4?=
 =?utf-8?B?V1duekpLcVl0cHR4c3o3NkJyYjFwR0JzL3lJMUw4L1dJQTJ4elpuenRPa3hC?=
 =?utf-8?B?TXBCZGh5RWdWRTN0bUExQ3Z4bGpXN0JTVFNUNjJIUU5WOVpXNFRqTDN4LzJv?=
 =?utf-8?B?TGFMTjlZL1ZndUhQS0NuOTN5WTJLVTlqVHdzRkFZdUVPVW9tdWZKVlFSMCtX?=
 =?utf-8?B?bmQ5MEdvbmR3bGRienZEU1Z3RTh6QzZxS3BqaENhOUlBRzlqR0ZBYmtSVi9E?=
 =?utf-8?B?KzVMajQ5RGpzanJGN21WdFBDbE1ScFJidUpSaEh4V2hKUERSQjFudHNFNXNk?=
 =?utf-8?B?MzRxWnNwQ2RYQVV1WmcwbHVhdlFGSlVMdG9KWHQ0WmlMQTd1cDJNOEJHMEZK?=
 =?utf-8?B?OEkveXRndHFlQlE2eUpWcXZVeUpwak1hM05oQk1wUkxpZFFvZHltLzBkczJ2?=
 =?utf-8?B?S1kvRW8wODhLejRJSDlRRVVyeG9sWjdHaTBtVjkwM2k2WGZ2OStmYm85VnpB?=
 =?utf-8?B?b1hhdFNTQXRSQmdsV21VZDZQMzJsMUVQQjF1WGRXclRkaEMvWnJQMEw0Ykov?=
 =?utf-8?B?ZzBlZVlmdkVDSXQrblU2a1F5Y2tJU0wrOXNxQzF3b015d2g4WFVzRk1JbWhE?=
 =?utf-8?B?Tllqdno1UldNNGlJTEhVaDlGRENrYnhCNUlyckhzREVDT3BZakNmRzdsaUZ5?=
 =?utf-8?B?b3IxT3oxaVFqZEt3RzdONVRkaUlZSkxkU01rN2ozREZ2ZEtWS0x1cnpmRnhP?=
 =?utf-8?B?Nml0c3NLRzY0QnZDM0Y4cHE1bThQbGtKZGhmUktpN3pwZ2srUXRSK0VSZzdD?=
 =?utf-8?B?OVlvaEpsa2h1cTkrS1lJNHI5VnBoNmdzdHZEV3FiUWlsOVhiYyt3RGFLblha?=
 =?utf-8?B?OS8xRlFqY05KYjVQaitMM2JjWmlRSTdJaEdobjNqRWdiY294bmhLaU5rZHFV?=
 =?utf-8?B?aE1Yb21aeTFMOXgyYUV1UzgweUlqU2hpUzBVSkVBRXl2V3d0VUtSNTNsdEZH?=
 =?utf-8?B?czlSSzFiK0x3TW9SVG1VNkNTZnpacDV0aUZuUHhVU2lhdzVIczR0SWtRRHVr?=
 =?utf-8?B?Z1NiNTFoc3dvd1JJU3d2b1I0bEwwUHJ6SzYzcklRNjhKQWtWaXd1bTdXcmRT?=
 =?utf-8?B?TjdDd3NwdjM2NGpxSUZoS0IrazNjWnFlcDBRbE92V2Y4eGtNWnhidGZKTjcv?=
 =?utf-8?B?NzlUMHhGUWNqckhNbTAvdkplRndVU1JKMDRaR01ndFRBWjd0OENqb2paZUM1?=
 =?utf-8?B?eWdHTEE3TlNmU0pxcU0zZ1p5Rzh1TG9ETEdDNytTMmJxdkRnUEJuRXdXRWlF?=
 =?utf-8?Q?I2TRMI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9636.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUZEOU9iMklWR28vcU9xaTYyWDZlYlVSUGNmNnhteWptdWxJRUdyTzk2bjZW?=
 =?utf-8?B?SE5DNnlDQWNEOHJ2UW50NlRNLzJCL2UwOTlPTmZXOWxkZWFKeC90eWlIMDJj?=
 =?utf-8?B?bTNZZ2tBYnNzeDJya20vVHc0NzFQTUM4NXA0RHhxaDlld2xEK3UrV0RvYVJy?=
 =?utf-8?B?WE5jVlVMUU9iZVBwOW0wYWxHY0pYWDV1Wnk1cHR1U2xTUXJ1aC92bHQ4MndG?=
 =?utf-8?B?UDJtYVFQZXdGZTBHcldSUVV1T0NIMEhmVGZ6REVHUGlmRGRjZXJ2UTlqdGh4?=
 =?utf-8?B?UnVCMWZBMUVJOWVoalpNR0V0U1FuSGplRVdBdHJwMEdhMVBiSC9YcXVXYzVL?=
 =?utf-8?B?TVFvM3lkUytodDBYSzY0U1ErdGlKNHpWVGNDdTNrUmF3Z0RidU9oUjdiODAz?=
 =?utf-8?B?WXdjL3ZXQ3RBWlhoS1dlaWI0Y2FlY3o1Q08wMU9kWTNEZWZIWHo3TG5ySmE2?=
 =?utf-8?B?RUU2UEU5aktpTjBLVTZpcUo1MGVFOHJvWEIxTjJERlg4THZwRGpwMzk2M3Js?=
 =?utf-8?B?aG91ejd1VEVHVkJNbEROdmRJTWhreGZmVmREUXdxbEdkQW1mZ2RTMFZYc2tu?=
 =?utf-8?B?N1YzTWx5bHdnTjI5dkZtRmdmakwvL2tIWk1zcTYwWUpFUmtXdEhHdXRTUDBx?=
 =?utf-8?B?c0ZyWG9iOHUzUVZjTlRTSnlYUnZQd2dUa1kzSkZWRkliSFB5Wm1KV1E4N3dl?=
 =?utf-8?B?a3l4SzFpZWdndXFMTTF0N0J5blQ1N1NYT05nd1QvbHRBajg0WEJXeTFncEdv?=
 =?utf-8?B?azFjUDVkR1NWMkdOU3BhMGc5aFBsamlmblRPOWR1bjROTnF1aU5rWWdFVlVl?=
 =?utf-8?B?eU9wT1RwU2pWdUFLTHVSUkllZ1V1ZlkxZ0xVYW5yUHlDa3RoYzZPSU1iSnhE?=
 =?utf-8?B?OFFSZ2xseWdMZ2wydTlrRDNuclBhalN4Z2FWVVhDRUVkTzhGZnJjand1Y2Ey?=
 =?utf-8?B?TytlRlZFMVhDdWQxVUoxRzhFSUZhamh3T1d3M09qb1JFSG1seWJXaGlmdkRn?=
 =?utf-8?B?NjZsbjEzdkRhZDA4U3ViNEpoRjVhV005TjZVOWJuZXh5cnhlMHFiUHByTThU?=
 =?utf-8?B?akwyam5WTzB0QzVrR21PY01YdGRvTGJ1akVITXNDRmc0VTVKZXZ0bWpvM1dR?=
 =?utf-8?B?bDZwRERMZk1STFNCVk85bHlNUEtkVzB4c0VxdUR6WkJYUk15WFgzRFdrWGxQ?=
 =?utf-8?B?ZUZoRDRvUXZnZnRobHUxMEpNZW1zcEY3eEJuVHBSb2MyVEJYZnlZYTRxV1Jn?=
 =?utf-8?B?cnZRZldwQTN0UDRWWHljcnBPYUlQaUlSZC94T05jNkoyOUZNUlc3OWNEK3I1?=
 =?utf-8?B?VzlEOWhyNERIMnVNTjVBTy9SVHdnbTNKY0VsZFd6YlQrUTFobnU0RWdNb1pD?=
 =?utf-8?B?OEZQL2xKL0pxNTlSR2JHMWpadzdpUDRRYjVaMGJZRzBtM25ERXhHVGMwbDcw?=
 =?utf-8?B?TkZNRzU0dDVMakZPRjR5ck1mZGRNdEozY1o4bzBMc1lPTEJldEptK1VqVmE3?=
 =?utf-8?B?OXBEUTlYRHdRL1lNUTk4SGZWL3lCWCt4Z1dhZGl0WnlnZGJRMU9yemRqM3dL?=
 =?utf-8?B?SzhRemx5dml3RjR6cVhxMWE1RTVYUjY0MVE0eEUwcU1lVTRjSlNoTWh1T1NN?=
 =?utf-8?B?Z3hUaDdhaVVCbjRzb1BIbEk4ck50bUdVYlU2SG55a0ozd3NTVnVHUXhSOS8x?=
 =?utf-8?B?c0hZZHFmM0ZORUFhdzNPVWQwWGxRM1FQc0poTDc5THhSTDJsVnczM1dETDAx?=
 =?utf-8?B?ZkUwU29FWWxhNE1UL2dqNXY0SjVCVXBRWHZBdm1GSzBaWWhEdUtjL2VsbElz?=
 =?utf-8?B?eW5SeERVZ3lpQ0gwM21Ib0FFVTdXeGg3c1lPemdjNXM5dG5KNkF2WU1pYUNx?=
 =?utf-8?B?eEpyWnZOTXFwL2xhSWJrMDZ6MWZ0TDN3TjhtTHNpTzFyOUNxTmFKSDExdnlH?=
 =?utf-8?B?VzRERkI4TlRtbE5WOWN0d0wrOE5uSG5ocHZDRTQ2bDVUQnYyVUpFRWRkclVN?=
 =?utf-8?B?VndIZHVhSHh4OVZJZUlCeHpQYjdFdVk0QlltNzVTN1B2TmdhZmw4SUJoejlk?=
 =?utf-8?B?UnROaUpVWGVzVnM3NWZCQk5ORXZqRnYzQmZ5b2xaTXNsRElRdTB2bjBHN1Mv?=
 =?utf-8?Q?qNyC4RA9rhtIIiUtz9z71/Tel?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cfb232-6aae-4478-8a37-08de2e8085ca
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 13:17:47.1150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoeVEhCBL7N2Y3nWcVqUpYqpKe0RwRDRUXAEv4I0EIa3VfxaYMlfD2dOVnLxmB/Yb+iDYYcg5D4ztZQTwniciA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11505
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

This patch set is used to enable the second USB controller (base address
0x29920000) on i.MX8ULP EVK in host mode.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (2):
      ehci-mx6: Update USB host driver for iMX8ULP
      imx8ulp: dst: Enable USB controller at 0x29920000 in host mode

Ye Li (2):
      ehci-mx6: Add powerup_fixup implementation
      imx8ulp: clock: Drop CONFIG_USB_MAX_CONTROLLER_COUNT dependency

 arch/arm/dts/imx8ulp-evk-u-boot.dtsi |  4 ++
 arch/arm/dts/imx8ulp-evk.dts         | 27 ++++++++++++++
 arch/arm/dts/imx8ulp.dtsi            | 30 +++++++++++++++
 arch/arm/mach-imx/imx8ulp/clock.c    | 12 ++----
 configs/imx8ulp_evk_defconfig        |  3 ++
 drivers/usb/host/Kconfig             |  2 +-
 drivers/usb/host/ehci-mx6.c          | 71 ++++++++++++++++++++++++++++--------
 7 files changed, 125 insertions(+), 24 deletions(-)
---
base-commit: 610a3eb27ea1e68363fffcb3f14b7fc097ef08b6
change-id: 20251128-usb2-1511e5e3ea84

Best regards,
-- 
Alice Guo <alice.guo@nxp.com>

