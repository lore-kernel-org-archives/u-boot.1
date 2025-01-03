Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A5BE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F29C8042F;
	Fri,  3 Jan 2025 07:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rejbBBYa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08889800D7; Fri,  3 Jan 2025 07:46:13 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADEF9804B6
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oICFpm3V2LJxaUoE6nbqkGxEvOLkYCs0viOSAf2nlZ11fTRkniBA8Xq1KfkQdumZqNkkP2I0yTtNrM8BCip6+Pcz7Ld4ezZr5QFsza/l8LjDeHkh/7inSBaIWUbOEj69zmaJHB82NMsYWFDz3Yqtao4ErlYJTlzLciixmGNGcE5kkp11rHlAqvZi4wgmSFdM209S3CI6PflMJgM1qGlPSTmbi6u5TMS7Q4dvRJp/blBZqgBoXT4JtiKdFpK2oJjGVf4ErsS2HzaDZuNR1ihWgZpyOpV8Ai+tpfHMMsTZrGhxfMBMP6eL2vegG02thip2EzKO36nCH4ogjOcVXun9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZ27QUNb4XMZA14luYXRGGDYS+j7R3pB5YLFWAgcKe8=;
 b=jQ3BI4BqLQhxjzyfbbY7/uki1ksA4e1tquAzU5LUS6lh3i6RRXn5QG5LU3pMKIf1PUWE/+Vj6keBhEPnr9M1zEZ373DCoqAzoc5qyG+B0AmQsQiR7mOaXKk0q3CmGLS4ZL2HIGQd0PGUyxI70Ykq572JgoFOJsQd20vlQ1nVYEm7kMR9uT1QP7zcZs4Ej4cOvAqWrM1HfSeXk2EzYOPwxgJEuHdzmindx5taiSEmMQTZRuoeDn03xmE3gGHb4OXPtWX9HrFWEERyYffUk5IV6FWvZztGYm3v1s9FhAtbBmNrgKUA0SOOPV+ZH7I8CeprEwsCVV3+v/BCE8Uus1Yw1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ27QUNb4XMZA14luYXRGGDYS+j7R3pB5YLFWAgcKe8=;
 b=rejbBBYaBhAOufPNunviTsh7MsF2Vkmz+k2cXJ+TtQl0FtoJbzRBVl0vtkJ95PytlETPnA7x8+OTL58jr72httlsvYqduRMb//k3M01wAOMKkILsZ1pn0OKr4QV+69x/dUnG7N4ZrE3b2PPMP+GGGZSk3k32Lb4ycrA8JswJzjKB/QxBDGjScbw0lHRVaeNCsJLniaaD1eo2BhZ+UEwzr9Kq+XthHH1g8fheM1zzqnoUm9zLgIkMs5ED5io1Tiz9dUcMvpeKKLTldlnx4M32zoFkncEGe1WIY1tYiQdlyYR6iPmtMZyzRgRzF1Gep5TjXG1dP0lnERupTT8FOITSGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAWPR04MB10054.eurprd04.prod.outlook.com (2603:10a6:102:38b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 06:46:05 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:46:04 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 03 Jan 2025 14:45:39 +0800
Subject: [PATCH v3 04/17] scmi_protocols: add SCMI misc protocol
 protocol_id and message_id for getting the ROM passover data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-imx95-v1-4-6744df5dc020@oss.nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
In-Reply-To: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735886747; l=1124;
 i=alice.guo@oss.nxp.com; s=20250103; h=from:subject:message-id;
 bh=EB3jfllXXxvcutkNsraldgKBWYZpnS1lCbBAdD2GLIY=;
 b=PrIljPHQLDaaQCHOFYBnJqPmQkk/rq78E/7P5+CZTK4ylSD4g6vQgeQxQemAZtHEWIfFs1uJK
 q7LSpzBEqfaDdntP0NOrf4a4gG/7qdM8j6UoRP+aK0Y9EqxRDwF4pH5
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=6RXhk/KbIrPIkIaZWptZot1vwQyfwwp597Dp3Ydq+kA=
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAWPR04MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a56d9cf-4094-4bc5-4c02-08dd2bc24b98
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFFlbTg3Z1FwMGhYc1VvYklId0lqRkJZQTJUODE2UUVFbHpQME9GYms1a252?=
 =?utf-8?B?MFRCbnBGMXpxek9CR1RLMStLUWVsRGNlNWVoeVZUSElZZGJubXNocjVzbm5w?=
 =?utf-8?B?ajljYXJEU2N2ZksvNkkrdEw2VncrWURPVmNhbFBjTVdXR3Z6eFkvdTJnbVBk?=
 =?utf-8?B?SkcvWkptK0pQWWlXT0hDbWdMdWVHV2dsZlMzZEkyVmN0eEVRZThLYXRIcHhp?=
 =?utf-8?B?Z1loeXgxYkRoeldFNlJlVnAxY0UxcCtOeWtVNzUvMVFkL3pHWGxYS1MxeTBG?=
 =?utf-8?B?dnNmRndxZDhSbW9ZL0tTN3pKZ1hKcmV4NFhEQ2laNW0zRWVRUlFkR0RmRUlm?=
 =?utf-8?B?QTlNYlorL0RhVVF2YWFTRVlzZm9nUE1BUFllQlM3SVhpWWZvVDRsWW1zN0Nt?=
 =?utf-8?B?ZDNwM01kVXdkQlBtNlpFMzFnSmJoNXBPOVB0T0d0SGJLdkJHSCt3WklCclc0?=
 =?utf-8?B?QStLdmN6QkppNnpWZEIxaE42aGtPdktWOGxOeWV6QkR0dXo3L0JmMVdOazBJ?=
 =?utf-8?B?YmlTRWFkeGtqTUgxV2JGQVg2cis3NjZjR2Z2citrUGFtd1VMYVoxM2FGUlZz?=
 =?utf-8?B?ZlFPYkxveWpXTzhyVk1FVFFjMDZoV1V6V0ZjSWpRZGVEZzFWcnIzSEhja3dL?=
 =?utf-8?B?NXNPVmJDQzFwU0V0VVpnNDFoS3BITFFsSGJ2bnB2aDNiTWIrM2JoUi81UlJB?=
 =?utf-8?B?bmJnRW4xck5KSXRqRHpoby9rbEVzVWRwMXlmR1QybXFueTdwcjFuYXB4a3pM?=
 =?utf-8?B?cDlMYXdVYTZiYkxMK3NuOFJLQUFVSDZldEFhSGUrRVl5cEtLQmxlQ3kvODBS?=
 =?utf-8?B?QlZIcGM2RHZsSlJwTHJmTWV6T1U3S2krQ0I5YS96MlVqblNLMU50QkJxNkJr?=
 =?utf-8?B?QldMVG5qUTU4d1hyNmRjVXZseGFXVnhtb1lwWWhnUytsNlJqaFhjdEt4Wkgy?=
 =?utf-8?B?K2pRYnMxZlhhVk9Fd2w4aUFEKzBJc2JuK2gzNU1MTzdXbW5mQm5hVWYzK09S?=
 =?utf-8?B?enN6UjVXT3dDbmE3OWQrVS9TVldPR1IwaFI4eGZzOE4vRVpEKzBNZ085ZUx5?=
 =?utf-8?B?VVdKNVpMZ0U0R0hVNmZDaWxJWmtZY0J5bEwzOHhpUVlBWHQra3V6bmp0UTd0?=
 =?utf-8?B?YzlBZ01UeXF4TGtCa2dmenBldVNlZTFlQ21hM1VBb3U2cERzN09mcXh3SE5R?=
 =?utf-8?B?dkJHUDZQcWlzSkZ2YW41OWQ2emEyVWphK2x3VVZnYVZlcVhycDdQbmtrMDZu?=
 =?utf-8?B?bHJEaElrMkwzREtoeHB6enQ5RG5ka3hXdmkyaE5KZmdEakhqbktrcWN4cHBh?=
 =?utf-8?B?L2JqZTl0aStEVmNHNERYeTQ2RGQ3Wjk1MFNvMHlHQ1MwaWpTN1YzU0l5Z3Bl?=
 =?utf-8?B?endaeWh4aWU2MnR2UWRXZnhQK1lLeGtLYnd4cUhYbUdtaTFZNjRLa3grQVBx?=
 =?utf-8?B?WUhSTnBLMVJkMUt3bWwxKzlvWXdjSFpjUWlISC9XYzNVUVVxWUNMT1llVHBk?=
 =?utf-8?B?L2NWeTdkS2V0a0x5SytKUFNSbTFTcEF1alY0NktnNTZIZkNvOEU5WGs3bEMr?=
 =?utf-8?B?TW4wVnR0c1phanZyNjVHTmVUVEZrSlFzUmdxWndtK05BQ0gvYVovS0dtWE56?=
 =?utf-8?B?WVJseURhWDBJdUI4Z2FvYlVBTTA4NEhuNHM0TlF5bm85M29xRXp6WThIMk1S?=
 =?utf-8?B?ZnhkZFN3RU9tcE1mcnE4VlpYa0FjbnQwSlkwcXFYd21PSjBIVGJqZFRjOExY?=
 =?utf-8?B?NFAzYjlnSlREY0IyNmIvSWZrNDF2QkpiT1JaMEg2bDQxZWNrN3V1ZXgwdW5m?=
 =?utf-8?B?S2N3VVNxYXFNbVk0azVBYzlxMVc1b2hVSjhmY21KU1luS1RmYmFaL0phTkdj?=
 =?utf-8?B?RHZIdWlaSk1Jejh5M2Y4V25oNkR4Nmp3WHJNTHlvWmVVZVdpVlVpS2hISUNU?=
 =?utf-8?Q?BVwHPUhUKxneO2CHDiJQMS9V549qJQBX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnYzRDRBTlVqQ3J1dmVuZDZIbWJLWU5NRkgrTDJFSHEvZVhjS2ZHNHpYSFlD?=
 =?utf-8?B?ZmRURCtnTEI0YTRwaW1mUXcvQ0ZnRDBUQ0RLdHNJckhibmFUSDNEeGRvWk9y?=
 =?utf-8?B?a3RBeHpHbDNEbjg1WXZaNUZPMjlETEdYQUNqT1poTWhHWU81WGRESjJFTEc1?=
 =?utf-8?B?eEVTaUNPbWZIcGd5Q3pyREF1MHl2TmlseklCODlBUHk5UEFkSzJZRlVPd0hh?=
 =?utf-8?B?dDdjd2Vrc2E5QURtUWNXQVpOdHNKcEpmYkJGdUZacDZmYXAwUFh3V2hqMG03?=
 =?utf-8?B?MnhIeXNiSW5ReFZIZXE0QjJvWlZZQnNLNDE2a1NQdWthNnJEU2VxU1NHdXJ4?=
 =?utf-8?B?cGpIejJzV3V5UEpFeFBGUjN5cWtENFd1aDVpaEVkK0Qvb0M2WHEydGExZjlm?=
 =?utf-8?B?WDNKdExvRTM3RCt3Tm1KK0M2QjZMUUFNOVFSNm40Sk5pd1g2TUVxT1dQdGdG?=
 =?utf-8?B?WVZzMElKZ2x6NXRkb3dTb3cvQnVoUkRsaFdpTXNrN0dSeDl0cDd0T2ErS2dS?=
 =?utf-8?B?VzZnREpUWm9mdWJCdHY5NmFTSmJ2a055V2tvTVRpZDJFSnhJN1hJWHEzdi9K?=
 =?utf-8?B?UHFPOFlJOXhldzRpdGFLakkyZFVNWU9YMjlGL3RJNlVTdkRvZ3oycWVvRFZX?=
 =?utf-8?B?amx2SWRTVVRYV1ZMTHVnWU9qY0g2SUJxdXpZcnk0ZzkrNXh3cHFaRG5PTElD?=
 =?utf-8?B?V0VCb2ErK0MzaVR2KzlZV3o2TDFLb3VoMjgycmsvVFlQZVpzaXRXeVUwYjlt?=
 =?utf-8?B?UW83YXQyY1I4NVIvMHFsSXhlNjF5VzBscENsNjRjMWVzSUR5Mkc1Q0lmSEJl?=
 =?utf-8?B?QmdQWEJMczJ4cVFZQkhQaFBobGtITlBxcDhNMk12Z1VQTDF1ZE1BS2R2N2h4?=
 =?utf-8?B?OG9BNXpzZlhrUGVQQlB5dmJlTyt0OVRSck8zYXRVS1hZZ3VTd0JKUXhCY0Rv?=
 =?utf-8?B?M2cyeHlaK3NHUUJ0cnZkdE9jckxqM2ZjdHVzMStCWFN5SzVDWFZ1Y21ySXNK?=
 =?utf-8?B?NXp2NUwyQVNNSkgrZXRBVFh2RWczWWR5Q3ErbHcySERETWlMWWQxZUNFdWdZ?=
 =?utf-8?B?SlBPY3dYeDI1RXk1U3ROODFjV3VQREpkbzFOUmVIVVFZTDdwa0dZTkVLR2U2?=
 =?utf-8?B?WlpEKzBNK1p0MlNVcjAxNUUzYndGem1WMUx3TmloZTgxbWNTZ1NMRE52TzFu?=
 =?utf-8?B?bGNYZjJTdEZxNCtzOWxqMDhkZmhFdW1NbXh0aFgyOUh6OUx3TksvaDBuaUF3?=
 =?utf-8?B?bXU0ZDFLTFZvblFjTEpjdm5tUjc3YUhWdDlEYTU5dkdRNGhjLzNPbFo5OWxS?=
 =?utf-8?B?OFJ4NjRYRGpiZWkzdlFMU3ZTMkM1eVhnMnFNQnpPeGJIQzBOUVgvcEIwZnpK?=
 =?utf-8?B?enVjdi9JcUh0a1ZqTjQ4OGN3d3orWFhLajlOZWJpQ2pYYUI5NkJ0N0VnM1Za?=
 =?utf-8?B?L21LSUtKVXJ4RVVmdjZsZTIvU0FjTEl1ZzNFY0EzemphdFVWS2VBamR2Zld2?=
 =?utf-8?B?aXlHdzA0VGFjNFR6bFBMMzlhUWZBVGNiVk1ONWJjODdSUGVVdDVBbEY1UUd1?=
 =?utf-8?B?b0xnWFlqSjNYZzRYSk5McnN4ODFkcUp5c3ovNVJQK2xXZTRXSXdaTDRCM0xu?=
 =?utf-8?B?MTdiUnJyVzhPaTNqVHBKbTBLVDlaSjM2Q1F0VHB6cW82bXVoVWV3N2xrUHVI?=
 =?utf-8?B?NWxFOXNNaDRiWDJja1FnMXkrQ3Q4Q1c0UUlOTk9UNVlRdVN2U1JxenZVYTVh?=
 =?utf-8?B?TzByQ2VLZDErTUZReU1jUUg1S2FUM29YazNQSS83VEFZNGIvZVpOQkM3K3hZ?=
 =?utf-8?B?Vk1BTmpBL3I0SnZCTFpLRDBzRFNidTREbnY4TzMvMTA1ZVVUV0FId083M2Jw?=
 =?utf-8?B?OGJzOC84M3Q2S241ME1WTmZVOXBVYkVVdDJsOFBQYUppTHBSdGhWdUU1azAw?=
 =?utf-8?B?ZXZwZXdza1pVVWUyMVlmZjZZa0dZNlZLRnB5cG14aFE0NFgyaGplOUM0cnlv?=
 =?utf-8?B?SHFLTlhXbG5NU29jYkZtQllneUIrM1VCT21KeGZqTHhqS1hOUm91bkd1enkw?=
 =?utf-8?B?MzVDOTNRbTVlVmpMc2tLbkdJRmZJcDlVeXJGTU10dzFOYm40M1FMcnRUOXJN?=
 =?utf-8?Q?CiQVoXXR5kqZl+y+2YmzVYLsK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a56d9cf-4094-4bc5-4c02-08dd2bc24b98
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:46:04.9406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rQsIBZWBh7YsN/FYa9H4jru9NL4eoTtNE5hYC40wjOp4jJgXwr4xOvqobyXvph3VXmSM/38UZqOunnPqH/w4Q==
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

From: Peng Fan <peng.fan@nxp.com>

SCMI misc protocol is intended for miscellaneous functions which are
device specific and are usually defined to access bit fields. This patch
adds SCMI misc protocol protocol_id and message_id for getting the ROM
passover data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_protocols.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 2367467512a6b65253317e51bea71de396aa96f9..6cda1f00df1f6baf6db65a28b4cab114f8540a4b 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -25,6 +25,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
 	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
+	SCMI_PROTOCOL_ID_IMX_MISC = 0x84,
 };
 
 enum scmi_status_code {
@@ -50,6 +51,10 @@ enum scmi_discovery_id {
 	SCMI_PROTOCOL_MESSAGE_ATTRIBUTES = 0x2,
 };
 
+enum scmi_imx_misc_message_id {
+	SCMI_MISC_ROM_PASSOVER_GET = 0x7
+};
+
 /*
  * SCMI Base Protocol
  */

-- 
2.34.1

