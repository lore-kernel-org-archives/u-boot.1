Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C811E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB3F804CC;
	Fri,  3 Jan 2025 07:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vXsuak9b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE26580447; Fri,  3 Jan 2025 07:46:26 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FB2C804CB
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8Ok9yahr3iGROG18A0k0gyWhOwu/lQkfTOIHjgSBzXGK+0K2l0GiKMeXn2noJaYKzuVVYff4jfGK6oLPhjQYkhRDh/xo8nPZN12R++yK1QMcOtKP5K62iGR6EOLRQjQAOgyNHumvtYlfHrBjqk8f10AkYfM7fY2V+D6itZkJ1UdTNllHB9UuY1Ls4RFoilr2H6q3trtnA7+Yl8MycA9CcLnhxPQAMqONBbb0Y05a2zjPhpfJByBUvLt5hbTug4pn1DaTRqRbTvBU6gnoLFpg/VCkKXHi/0xmTk0LSPLIc8h0dqowPJUE8gnxDd9iflGc7+ou6arGDTBKdNvhDgjBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzEsFRN8/WsAAo3FGxOZp5OOEdGJDZ7FF5unlCQklCs=;
 b=XciHVFvUJlk3GAm6TKxIW32kr73qzEqSduR11erTY4lZBWAMBmatw68pQ8TV2CB7WdcwWN2rSB1qO0je7g9UA0dYkGYMUpZkvOvIeA0Kl7JGU4+/FXfBq4/t/SyuoZ3xG/U6RUxCnueAKccCDI3Oxa4bxtEHQfyiY4kt8zx/nU5soLqAsOvC2rGlLKLPl9IFvIF/9b2jqS5z/UEpGC48r1CIaLIxo5MbQQ6hUPlU0E28mOOmtcIhrCrqruwktpvMkGZhCf6WrP+g7OjHO7EdRdEPXgxbLcVbYX27QHoUV21JnysEngGl+CkSrCx1gO6qXUU/hugf+CUs7uGyvwqBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzEsFRN8/WsAAo3FGxOZp5OOEdGJDZ7FF5unlCQklCs=;
 b=vXsuak9bVjtpX70Kf6/GoyqyMg4eIn7v/Z3mkpijcUryUXh0KhsWSHwXO6JDBUTihC/tnTrNSYBRFuahF4sbdtyofMfnRSzF72bw3BwRlDiIrXiU5i94UUfG8dv1ctkuUWHkVRUWYSES+azrUwglTUOAyYK64wAEBlR1IaEvrrglenmwyegR/AOzXTL2MZa2tLfAzux98n1G7EgmQjJbxH5i9IN7CVlvTiqckKvz1mf8p+XqcfeVlnS8CRrjvComAxNXa9OB6yClZhURC9veDet3F/acSwIpLt8IaacwEyn1OLWYLKc2qTRurzYuj3UmHHPW9sbO3S9S2ceEotfgyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10965.eurprd04.prod.outlook.com (2603:10a6:150:207::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 06:46:18 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:46:17 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 03 Jan 2025 14:45:42 +0800
Subject: [PATCH v3 07/17] clk: scmi: check the clock state/parent/rate
 control permissions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-imx95-v1-7-6744df5dc020@oss.nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
In-Reply-To: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735886747; l=13555;
 i=alice.guo@oss.nxp.com; s=20250103; h=from:subject:message-id;
 bh=9EtclbhDyyQ8wqVWlMiO8WM5PK1BDIAgxKegvbXC1As=;
 b=26QVb5GrxQVZudeOQrmqzqk4/3RCZAv0lv4FVSevKj80gi6SeYwqZV3c8ZkpBDPfaBVlvsQSF
 IFZ0VTSDMqjAxaDq5nxYApsPyFq+ovORWx5EszQ8NFOpn9rbbyCBPQ1
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=6RXhk/KbIrPIkIaZWptZot1vwQyfwwp597Dp3Ydq+kA=
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB10965:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b5fe47-196b-4c48-e1aa-08dd2bc2533c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnhGRGN5OTJROWQ2NXppRjBqLzQxQkdHYWFScitLSlJhMkx2dWxlY2U0bmFt?=
 =?utf-8?B?VVB0V0hCK2FBQk9FYkY4MjhFOTdjcnEraHVNbEttNDcxdWQ4cGxubjZGZ1l0?=
 =?utf-8?B?a1JjTjFod0tUdE83N2FGc0dwZUVwOTdFcDZ6ZEtYTjRob2hacnFDaUN6NGVW?=
 =?utf-8?B?eElVSjBLYmlaYU9ZRkQ5ZHNXMHMya1h3Ym1KbE1adWxEWk9LSE5oY1RwYW9P?=
 =?utf-8?B?WGYvRStDbnZzNDAxUmhhR25weGlXVmhjb0RwUEhLNnJ4bFNiQk81d0ZkRVNP?=
 =?utf-8?B?YzVOYis0OU9qejN6ZUIwYUc3dUpQK3lZZFhLSmFNN1pzUXlxZnJJT0d6V3Vm?=
 =?utf-8?B?M096VlllZytoUW1XbWVyc3JWellrR25pT3FYSTdieXA1Y0JxRDgrQ0FTODc5?=
 =?utf-8?B?aXVxdWFPVzlWVmQwWkZTdHJtd1ZJYnlsZVpEYnBldjk0MkpYZHBlYlQwdmFu?=
 =?utf-8?B?SWtNZ1VkdVVCTElWd3Q4c2NMVmdJUy96eXhMTnNMdWlyeitJY2QwS0h3cXQ3?=
 =?utf-8?B?aUp1TngvQWNkY01LaTMwU2ppNno4SmVxOWo1WGEzQit1dzZqeDRlMFB1cG4w?=
 =?utf-8?B?ZGg4SVNNbVV6cWh4bUdnS1UwUkdtUEFqbmVrSEhSaVZJQjlmRytpa21HWEZZ?=
 =?utf-8?B?WllqM3ovRFd1UVR6WWg2cGZXWHFrdGxHZms0VXNIeUpwdXIyMWN2OFZJNEpS?=
 =?utf-8?B?WkZDSXFNdmZHbS9SYmlJN2Q5cG5ibC9qMFFqWndFeEpNVUFWQ20xQjVCNVBM?=
 =?utf-8?B?UGVqaXU2dWM4Vkl5OVdPQ2hLa3I1cUNXR0VVMHVabFZUbVdpOVpoOEw4WDNC?=
 =?utf-8?B?ODhPWHVOU2k1SEJobWl2b3I0clV3MFkvdlU2eEREYlU0THF0bTh4TUVHbSsw?=
 =?utf-8?B?dndzeHZxYWk1clhmNEtQSHNzU2FJRVBWbXhzT2l3NjJaTFdtUjR4NkNsbVo5?=
 =?utf-8?B?Y1l6dWtWcVMyTVVLaHVCOXRERjRVVVNaZHltY1FaWXlhcmpocysxRHlSSVVR?=
 =?utf-8?B?Z0d6M0VYa0Fua1ZtVy9DcmpUeHZJZ0tlUHAwTm9lN0pYbDZ5cTl2K3VSaUN4?=
 =?utf-8?B?bUFGOFRNcmQrNUl5MEluS0xYRWJLaWFTQmdSNmRzcGpJYjF2VHIySTI5WEg5?=
 =?utf-8?B?ampqNE5Va3hveTlzc0FHQ044L0xKWVNDZG1HVkZ5TDZaVU9WWm82TFFoUjNH?=
 =?utf-8?B?LzI0czJhYWl3OStJSFMyRER1dFVDR1Iyc2Zva1crQUR2UDMyemI3MThMZlBa?=
 =?utf-8?B?MndiZzlXVjI3NXM4U1p3STNQeVI2NWN5WlVqWGVGNXIrR0E5YmxOTWc2UFNR?=
 =?utf-8?B?ZndSK0h3YmhPcjVTNi85aVFYSzAxWFZHYzFKRHgydFpYZ2hqNmo4OERDMzlC?=
 =?utf-8?B?bWNCY1pEVW91S3JrVG0rNWJrVHZ3c29oT0VPSzNhcE9MYVljRUxPR3JudDA3?=
 =?utf-8?B?S3FJUnlpT2RibkJ6Y0xlcXRnb1dkNUlVaWlMVllodWE4dk9sSEJTRjFhb0pi?=
 =?utf-8?B?YWhiK3lEeWJkVERDV2NJL09DdFJrUnV5ekxnODNQcVV3Q2VGUVpXemtPNWtB?=
 =?utf-8?B?MWNpR0tER0UxNDRibE04d3oyeUhObHRyZTN3eDMybHN5dHZnVFhYUllFdXB0?=
 =?utf-8?B?MFJhSHBQVmJsR2EyZkM4aXJxZ0ZIREhRdGZZTEt5Zzdvb3MxaEZiRHBZR0VW?=
 =?utf-8?B?WW5jVVBha2R6UXRwZXN0LytGVS9RdlViTEw0QkYvcUczSUJyd1NETllzYUEv?=
 =?utf-8?B?L1VLdDlYNnR2RVlhdmEvSWtnVHJyeE1IanJteW4xT2FlaUtHNGhlM0U1c2x0?=
 =?utf-8?B?bDZmTlMzN1pXUkNPTjEvNzNpNGhMdll5VDZGYWNMdHdlRkk3QytXU0kzY0Zl?=
 =?utf-8?B?bm9ueldYb09KeEZtTWhEWWZrVGRLcDI4VkVVRjVzT2hyTndsZXdUTVo2cXVi?=
 =?utf-8?Q?VdmD6v9S+SLiyT3YHOBnaXatCUPMEuNv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGVMT1gyUUtEZmNlTG9CWDhxZzZrVGh4YUxld3FlSnR5a0tyTzUzWnd5NmpE?=
 =?utf-8?B?eFZtVDhBTHI2SHdtM0Z5cXN2c3dKb3laZEFkQTk2OUFZV3l5U2hMNTJETnZy?=
 =?utf-8?B?YXh5clBIM2ppTGlwUXNVemFkT0VGY1pCeWQxUjQwS2dFZXdTSjI1N0FCRWNm?=
 =?utf-8?B?WXY2MEoyVjNldVZLZjI2eGlrbTY4TklnV1lkZDhVYWZ0TVRDZGkzSXZzY2xH?=
 =?utf-8?B?MzZjazVtSlcvKzV5clJzeG5qVXFRbC82TCt3Uk50ZHBFSE9NUWF5cWc4bVpu?=
 =?utf-8?B?VUFRNmsvRFRuMU90RG52eEQ2TEF0WTIvSStoaXFmWE93c0Vzanl2aDVnK0FV?=
 =?utf-8?B?eXpXanJ2SnZ1dmkwS1Q2WEFmM2Q3UHNVU245VENFWnR3ZjZKYW1UK1FiUnJx?=
 =?utf-8?B?dDZSVndYMnBHZXFjNHZSNUNqbmt3YUZxNUZIeldRUENmdldPYStlYUNoVVZl?=
 =?utf-8?B?b2FpdHZHWlpwSmdCa0pQdXNIRURIVzRzcDhhZ3p6ZWsvMFVzN2R6ZjVyZDAx?=
 =?utf-8?B?Sk9oZ1VjL3JDSW5yeU9SU3FKa1ZkbDMvRUZ5Rk9VS0hZczVzcmNhaEZoWjZk?=
 =?utf-8?B?cldPRzA0UTdKc1pGLzR5YmpmaWR2YWVvU1FRbmx3ckk4cFFPNEpNRGh0VDJY?=
 =?utf-8?B?bzVlUWpYMmZRejVKZDJwZFBkeDNxNjBTZEJHMDRBOC9XVy90N1EwUlpwTEZB?=
 =?utf-8?B?TlhyemRJRXZ5V2g4Q2phY2l2clZGZkdIMzdaUHhTMW9vd1BXRjlVaUgvRnNs?=
 =?utf-8?B?Wm56aFMwRENvSG9SRG41TU5pSmJKM0VETDNaN2tQRkl1RXRhNVVqMmpGRGhE?=
 =?utf-8?B?T0RSWFo3VG05QzU3YjBHeWcrZHpoeTNTcUNmUUFCbHZzQkpEQVJmVXBWNGcy?=
 =?utf-8?B?Rk4rSjRianNLUnpNVlBLTFJ1eHdseXZyTGxQUkkraENnQTdWd2hTQXNUR29n?=
 =?utf-8?B?WEFwcUdFTURyUllHd1ZLS1JsTkZBV1liU3RvVjlmeHVVY1NYNDZvVVA0VUly?=
 =?utf-8?B?N0NDSlh5RmhKVlhkSGJoSmxkVkIzOTNxUndwdFB1ZExyYVZ3czYzdGVwUksv?=
 =?utf-8?B?Z1lHSTZVU0pjc29xTGtnZDYvRVBqU2RueFhjU1dhSGU5VVZMbkJaUWx5Y2JR?=
 =?utf-8?B?QnVCbXFRbG5SNE9jV2hFRXhHU1ZZK0tldlFqai81ZUR4NURHb0dvQlRBR0Zs?=
 =?utf-8?B?djVObnlmNkJUam01K253U0wzbmdndW8va0dtalhzWWh5dGFmTWhFZzlWc2N6?=
 =?utf-8?B?NnNVejBtUDc4VG9IejZvbC9pcW16VitlblBqU3NCeTlNYW5jZkFnZjdCSXlr?=
 =?utf-8?B?NVEvTlBlbUtCRzJEdUROS1RsdDIyeDNWdit1d3BJbjJwUm56SXppTWErTGVw?=
 =?utf-8?B?Ty9SeHBGdVNtYkxDZ0hZMERZVXhHbVNFVDhqT1lMb3YwZThhdEFXYnpoUzZB?=
 =?utf-8?B?TVJqREFibnFOSTdrNFAzZEE4T2dWdkFHanRBRTVZYld0SkM5UEdHczE1ckt1?=
 =?utf-8?B?REJOYmRTWkJrVjdLS2xaWlBRdk5aSldsOXhNOU1ZcUpxMG9XSTR6M202SzBD?=
 =?utf-8?B?Tm4zb0huanVTT2RiUzljcnlsclFxdGZDUFFydFpoZ1VRQW02SDVQeCt1RUQ3?=
 =?utf-8?B?THV4WVNmL3Vmd0hpais5UWF6MGhEbzZNTVErUjlCT0dkOGsyVkgzc2N2Y2ZY?=
 =?utf-8?B?K0pZMTdVaEhtQ0JJdVlDRjBEWkpOK1VUdUh0L2hiN3orRlhQd292MFIyd2Ns?=
 =?utf-8?B?aW9LNDRpdGZpWGdhUjZ0Tk5GTzFhdXByaVdGQnQ3RXUwWlg3YVNLSlZlSDly?=
 =?utf-8?B?QVQxUlZCYm1rVmcxcnloK3J5L1FUY3E3ZTZEZzB5L1lMNVd6eGNxYnlNZ1hn?=
 =?utf-8?B?S3p3WUFRVGZGVVRzTkVXbUZXdGpxVmxVU29MTG5VVUo5TW5tZkhkQytuYXdT?=
 =?utf-8?B?UU1CQjJlMXR1aWZISmZKSVZVcHBCRytXWFZYUFlmbGtsSTdkK1lHT09oakE0?=
 =?utf-8?B?RWVJZWNNbGxPY0RIcXZFVUhrWnZQTkt4RVpZck52dHJIQkZ3eWxveTM1MFJT?=
 =?utf-8?B?cm0weS82aFVVSjJSMUNvTnhzeFE2aE13TkxrSDIyakRudFltbmFlTFNxUWlZ?=
 =?utf-8?Q?7plfdvfvCzNV8fTJEQg7YFR6M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b5fe47-196b-4c48-e1aa-08dd2bc2533c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:46:17.7628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaiFBQtoM/+SncABiHiHdYiO33DpCMtA/Udh/nOj+Tg1OnldGUdC5aFR5kDjMKT6Y/4v2XmDtn2MPUlqXD1pKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10965
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

SCMI clock management protocol driver in Linux checks clock state,
parent and rate control permissions. To be consistent with the kernel
driver, add this check here.

When using common clock framework (CCF), use the clock signal ID to get
the clock registered by clk_register() in scmi_clk_probe(), and then
obatin the struct clk_scmi variable with container_of().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/sandbox/include/asm/scmi_test.h       |   2 +
 drivers/clk/clk_scmi.c                     | 173 +++++++++++++++++++++++++++--
 drivers/firmware/scmi/sandbox-scmi_agent.c |  56 +++++++++-
 include/scmi_protocols.h                   |  26 ++++-
 4 files changed, 243 insertions(+), 14 deletions(-)

diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
index 619f8f5098cdd82ba2343897166c34c82c753422..b30e536a35771ec3e1439c1e64fd09de3728dc50 100644
--- a/arch/sandbox/include/asm/scmi_test.h
+++ b/arch/sandbox/include/asm/scmi_test.h
@@ -27,10 +27,12 @@ struct sandbox_scmi_pwd {
  * @id:		Identifier of the clock used in the SCMI protocol
  * @enabled:	Clock state: true if enabled, false if disabled
  * @rate:	Clock rate in Hertz
+ * @perm:	Indicating state/parent/rate permission
  */
 struct sandbox_scmi_clk {
 	bool enabled;
 	ulong rate;
+	u32 perm;
 };
 
 /**
diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 84333cdd0ccfe566c269f776f39725c69883c25c..0654f0cbf5fcca9c82b840c2fabd057ce1907979 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -12,6 +12,56 @@
 #include <asm/types.h>
 #include <linux/clk-provider.h>
 
+struct clk_scmi {
+	struct clk clk;
+	u32 ctrl_flags;
+};
+
+static int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 *perm)
+{
+	u32 version;
+	int ret;
+
+	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &version);
+	if (ret) {
+		debug("get SCMI clock management protocol version failed\n");
+		return ret;
+	}
+
+	if (version >= CLOCK_PROTOCOL_VERSION_3_0) {
+		struct scmi_clk_get_permissions_in in = {
+			.clock_id = clkid,
+		};
+		struct scmi_clk_get_permissions_out out;
+		struct scmi_msg msg = {
+			.protocol_id = SCMI_PROTOCOL_ID_CLOCK,
+			.message_id = SCMI_CLOCK_GET_PERMISSIONS,
+			.in_msg = (u8 *)&in,
+			.in_msg_sz = sizeof(in),
+			.out_msg = (u8 *)&out,
+			.out_msg_sz = sizeof(out),
+		};
+
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (ret) {
+			debug("get SCMI clock management protocol permissions failed\n");
+			return ret;
+		}
+
+		ret = scmi_to_linux_errno(out.status);
+		if (ret < 0) {
+			debug("the status code of getting permissions: %d\n", ret);
+			return ret;
+		}
+
+		*perm = out.permissions;
+		return 0;
+	}
+
+	debug("SCMI clock management protocol version is less than 3.0.\n");
+	return -EINVAL;
+}
+
 static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 {
 	struct scmi_clk_protocol_attr_out out;
@@ -32,7 +82,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	return 0;
 }
 
-static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
+static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
+				 u32 *attr)
 {
 	struct scmi_clk_attribute_in in = {
 		.clock_id = clkid,
@@ -53,6 +104,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
 		return ret;
 
 	*name = strdup(out.clock_name);
+	*attr = out.attributes;
 
 	return 0;
 }
@@ -78,11 +130,49 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 
 static int scmi_clk_enable(struct clk *clk)
 {
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+			return scmi_clk_gate(clk, 1);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock cannot be enabled by the agent.\n");
+		return 0;
+	}
+
 	return scmi_clk_gate(clk, 1);
 }
 
 static int scmi_clk_disable(struct clk *clk)
 {
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+			return scmi_clk_gate(clk, 0);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock cannot be disabled by the agent.\n");
+		return 0;
+	}
+
 	return scmi_clk_gate(clk, 0);
 }
 
@@ -108,7 +198,7 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
 }
 
-static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct scmi_clk_rate_set_in in = {
 		.clock_id = clk->id,
@@ -133,9 +223,33 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 	return scmi_clk_get_rate(clk);
 }
 
+static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_RATE_CONTROL)
+			return __scmi_clk_set_rate(clk, rate);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock rate cannot be changed by the agent.\n");
+		return 0;
+	}
+
+	return __scmi_clk_set_rate(clk, rate);
+}
+
 static int scmi_clk_probe(struct udevice *dev)
 {
-	struct clk *clk;
+	struct clk_scmi *clk_scmi;
 	size_t num_clocks, i;
 	int ret;
 
@@ -156,29 +270,44 @@ static int scmi_clk_probe(struct udevice *dev)
 
 	for (i = 0; i < num_clocks; i++) {
 		char *clock_name;
+		u32 attributes;
 
-		if (!scmi_clk_get_attibute(dev, i, &clock_name)) {
-			clk = kzalloc(sizeof(*clk), GFP_KERNEL);
-			if (!clk || !clock_name)
+		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
+			clk_scmi = kzalloc(sizeof(*clk_scmi), GFP_KERNEL);
+			if (!clk_scmi || !clock_name)
 				ret = -ENOMEM;
 			else
-				ret = clk_register(clk, dev->driver->name,
+				ret = clk_register(&clk_scmi->clk, dev->driver->name,
 						   clock_name, dev->name);
 
 			if (ret) {
-				free(clk);
+				free(clk_scmi);
 				free(clock_name);
+				free(&attributes);
 				return ret;
 			}
 
-			clk_dm(i, clk);
+			clk_dm(i, &clk_scmi->clk);
+
+			if (CLK_HAS_RESTRICTIONS(attributes)) {
+				u32 perm;
+
+				ret = scmi_clk_get_permissions(dev, i, &perm);
+				if (ret < 0)
+					clk_scmi->ctrl_flags = 0;
+				else
+					clk_scmi->ctrl_flags = perm;
+			} else {
+				clk_scmi->ctrl_flags = SUPPORT_CLK_STAT_CONTROL | SUPPORT_CLK_PARENT_CONTROL |
+						       SUPPORT_CLK_RATE_CONTROL;
+			}
 		}
 	}
 
 	return 0;
 }
 
-static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct scmi_clk_parent_set_in in = {
 		.clock_id = clk->id,
@@ -197,6 +326,30 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 	return scmi_to_linux_errno(out.status);
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_PARENT_CONTROL)
+			return __scmi_clk_set_parent(clk, parent);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock's parent cannot be changed by the agent.\n");
+		return 0;
+	}
+
+	return -ENOTSUPP;
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 19be280ec44845369d1f46509978ec9b5b59c60b..74a87832dcb14d63550e450f4bea2632844199e9 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -80,9 +80,9 @@ static struct sandbox_scmi_pwd scmi_pwdom[] = {
 };
 
 static struct sandbox_scmi_clk scmi_clk[] = {
-	{ .rate = 333 },
-	{ .rate = 200 },
-	{ .rate = 1000 },
+	{ .rate = 333, .perm = 0xE0000000 },
+	{ .rate = 200, .perm = 0xE0000000 },
+	{ .rate = 1000, .perm = 0xE0000000 },
 };
 
 static struct sandbox_scmi_reset scmi_reset[] = {
@@ -700,6 +700,21 @@ static int sandbox_scmi_pwd_name_get(struct udevice *dev, struct scmi_msg *msg)
 
 /* Clock Protocol */
 
+static int sandbox_scmi_clock_protocol_version(struct udevice *dev,
+					       struct scmi_msg *msg)
+{
+	struct scmi_protocol_version_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_protocol_version_out *)msg->out_msg;
+	out->version = 0x30000;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
 static int sandbox_scmi_clock_protocol_attribs(struct udevice *dev,
 					       struct scmi_msg *msg)
 {
@@ -740,6 +755,9 @@ static int sandbox_scmi_clock_attribs(struct udevice *dev, struct scmi_msg *msg)
 		if (clk_state->enabled)
 			out->attributes = 1;
 
+		/* Restricted clock */
+		out->attributes |= BIT(1);
+
 		ret = snprintf(out->clock_name, sizeof(out->clock_name),
 			       "clk%u", in->clock_id);
 		assert(ret > 0 && ret < sizeof(out->clock_name));
@@ -837,6 +855,34 @@ static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
 	return 0;
 }
 
+static int sandbox_scmi_clock_permissions_get(struct udevice *dev,
+					      struct scmi_msg *msg)
+{
+	struct scmi_clk_get_permissions_in *in = NULL;
+	struct scmi_clk_get_permissions_out *out = NULL;
+	struct sandbox_scmi_clk *clk_state = NULL;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	in = (struct scmi_clk_get_permissions_in *)msg->in_msg;
+	out = (struct scmi_clk_get_permissions_out *)msg->out_msg;
+
+	clk_state = get_scmi_clk_state(in->clock_id);
+	if (!clk_state) {
+		dev_err(dev, "Unexpected clock ID %u\n", in->clock_id);
+
+		out->status = SCMI_NOT_FOUND;
+	} else {
+		out->permissions = clk_state->perm;
+
+		out->status = SCMI_SUCCESS;
+	}
+
+	return 0;
+}
+
 static int sandbox_scmi_rd_attribs(struct udevice *dev, struct scmi_msg *msg)
 {
 	struct scmi_rd_attr_in *in = NULL;
@@ -1193,6 +1239,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_proto_not_supported(msg);
 
 		switch (msg->message_id) {
+		case SCMI_PROTOCOL_VERSION:
+			return sandbox_scmi_clock_protocol_version(dev, msg);
 		case SCMI_PROTOCOL_ATTRIBUTES:
 			return sandbox_scmi_clock_protocol_attribs(dev, msg);
 		case SCMI_CLOCK_ATTRIBUTES:
@@ -1203,6 +1251,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_scmi_clock_rate_get(dev, msg);
 		case SCMI_CLOCK_CONFIG_SET:
 			return sandbox_scmi_clock_gate(dev, msg);
+		case SCMI_CLOCK_GET_PERMISSIONS:
+			return sandbox_scmi_clock_permissions_get(dev, msg);
 		default:
 			break;
 		}
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index d529f8e2697472e60d0cb9c275f34ef0ecaed3ca..9607433c3276f9aa18044c414a5bde3143726cf4 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -731,13 +731,15 @@ int scmi_pwd_name_get(struct udevice *dev, u32 domain_id, u8 **name);
 /*
  * SCMI Clock Protocol
  */
+#define CLOCK_PROTOCOL_VERSION_3_0	0x30000
 
 enum scmi_clock_message_id {
 	SCMI_CLOCK_ATTRIBUTES = 0x3,
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
-	SCMI_CLOCK_PARENT_SET = 0xD
+	SCMI_CLOCK_PARENT_SET = 0xD,
+	SCMI_CLOCK_GET_PERMISSIONS = 0xF
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -776,6 +778,7 @@ struct scmi_clk_attribute_in {
 struct scmi_clk_attribute_out {
 	s32 status;
 	u32 attributes;
+#define CLK_HAS_RESTRICTIONS(x)	((x) & BIT(1))
 	char clock_name[SCMI_CLOCK_NAME_LENGTH_MAX];
 };
 
@@ -858,6 +861,27 @@ struct scmi_clk_parent_set_out {
 	s32 status;
 };
 
+/**
+ * @clock_id:	Identifier for the clock device.
+ */
+struct scmi_clk_get_permissions_in {
+	u32 clock_id;
+};
+
+/**
+ * @status:	Negative 32-bit integers are used to return error status codes.
+ * @permissions:	Bit[31] Clock state control, Bit[30] Clock parent control,
+ * 					Bit[29] Clock rate control, Bits[28:0] Reserved, must be zero
+ */
+struct scmi_clk_get_permissions_out {
+	s32 status;
+	u32 permissions;
+};
+
+#define SUPPORT_CLK_STAT_CONTROL	BIT(31)
+#define SUPPORT_CLK_PARENT_CONTROL	BIT(30)
+#define SUPPORT_CLK_RATE_CONTROL	BIT(29)
+
 /*
  * SCMI Reset Domain Protocol
  */

-- 
2.34.1

