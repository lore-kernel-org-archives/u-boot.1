Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744C5E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 03:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E718080601;
	Tue,  7 Jan 2025 04:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vS5rNOU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 330168060A; Tue,  7 Jan 2025 04:55:56 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B69D805F5
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 04:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDQCzjwH2Q7ov42/xOeAMkq1yZjYLktcVg2vqHM1q8oOnLrhZop8NA6LAEoabnHc+0Fbs08YuZ3+BuhUK8cuynUqX7uFabuW2fx4k/FrMdP1thLWUiRLWGSIrjdbeadH8fLj5Xg1vruTaJEH1Cw8isNeLiUMOO79WkbF23fAt90SsvopndV74yte79aXv+13swBtofYZT6TUOHu4A/MiWd1xrxLNmYU+PrUrnppyzibUVt9a/buZqixCmNBMgeedfyZ6MR53JxbtrmusnDmDyuGX/QeX7dtN1qf+Jr9V818oB4fF86VuQLZx2dKQofMVbzAkBb4Vp6ft8+54SSvJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgSdfVZNAz/hmChvIaoan8f6ybygC3ra7/60n6E/RwQ=;
 b=ZkX+TBRIB4gXQXecKPZ3oPWeu7aXpQE7cE/alN46/A3ZW08Azds+GijE43/soBIwDRTAdNHUI7XxbRGzNP60FFf7PHOX94BOmDNzwpsoe0wUFd6dU0CQh7g1epAtwqLQohhkpgHbDDtK9dybOdIZTmrbENfHs738eB3rOLQLw3thW+8lPRQyD1Gvt5eu3AlozYfDi2h+jgXbkJKYr3bp5PLgSx6qpBEgXFXUAKRebI/fW9E4odT1Hf/SaMY8R0rQb1jsOUewMD9B1l75rOIo0d6djGilrf0pvwcebzxz6V//I2lN2nBz4AeQwUEHJdOYRbYfSL1Wjbz9Opz3vI0a5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgSdfVZNAz/hmChvIaoan8f6ybygC3ra7/60n6E/RwQ=;
 b=vS5rNOU3F9IJJ23SGMePcCuFmJmN/CPreftlKWsOvUks8lIxuiHGiDilVfpbBG4SrLITsI6KMh69k+7Ph4B2Xi254pEqaRTXAU1I51iB2U8+3kbQtPLLEEO7sKGqHHY1259hboUjKE1US9tXFNZQe6RbRdAI0ANXKzmhtAliB8Iz6HaX063JM4NrhpexA0JhJRBHGqST5OqzxRQi1hjcKdtfCpSwO5PO6pjuLK/3F/Ykj7C3T2fkK/jgyv6966kykk53SiC6M93qDTqTj87wW4LP8pEVngn6V4YR2+elQVww6z4ujrffrsnHGxWK2EMQ3OcbyS1S3kzdhN5pJzIBTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8587.eurprd04.prod.outlook.com (2603:10a6:20b:43a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 03:55:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 03:55:49 +0000
Date: Tue, 7 Jan 2025 13:01:47 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@denx.de>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Peng Fan <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>,
 Ye Li <ye.li@nxp.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BB?= =?utf-8?Q?TCH?= v3
 01/17] mailbox: add i.MX95 Messaging Unit (MU) driver
Message-ID: <20250107044653.GA9383@localhost.localdomain>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-1-6744df5dc020@oss.nxp.com>
 <22f8e29b-1372-4384-a5d4-5316c1f4f160@denx.de>
 <PAXPR04MB96447B0DA009A2730D207B7FE2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <001a00ca-5980-4ffc-8fe7-67267a71615c@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <001a00ca-5980-4ffc-8fe7-67267a71615c@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:3:17::35) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: cfba0495-16c2-44dc-22fb-08dd2ecf2c3b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZThYeDVPTDRETjI2RHQ2Y0xseldRS1dKRHY3NDVEcXlMNjB0V0ZpT1ZHc2Fh?=
 =?utf-8?B?ZytlMk5qMEdIMy9janhhb2kxbzh4WnI2b2c3alRLd1NWUy9hY1crNkFTVzVh?=
 =?utf-8?B?dU91V1cvZFV4S3dxUm0wb21JUStyaWs5VWJyS0Q1cyt5eit4Tmplc2F3dWFN?=
 =?utf-8?B?M25RNm9ZWlpkczdkZ3pKN2o1TWhia2F2TTRCRys3WVJZalgzMldheW1BSDZY?=
 =?utf-8?B?eS9mOTZ4VmVKN0NMa0Jwc243VVFvdmFQQmFaS3JFVFBISXVpR0grNkM2OU9p?=
 =?utf-8?B?amc3Mkg3dWd4c3dXNkYrclhqd1FodTVKRlZqZUVXRmt2L2QwL3JsRUw3WGo4?=
 =?utf-8?B?UzU5S1Iyci8rOHJYajlMa055b3JHRjhIZ0c4REhJOUt6Tmh2eHRWK1d2TTJJ?=
 =?utf-8?B?Lzd6ZVZzckh1Q3Z6c2pacEFuOTd3SnlHSEZvRVdaWXphZWM4a1NIZ0I1Q29W?=
 =?utf-8?B?VUpCeFZPbGQ0N0NvY3N2bFIwUVIzQy9JTm55Q29vdXhsZ0ZGU25VZWpHSTBK?=
 =?utf-8?B?Y245dE1nSWJDNG1KOGljUDROeks4eUdGVGI2bVEvUVRpYUx2UEdyZmZERVQ3?=
 =?utf-8?B?Ujh4WHE5NG9keWhhazdXd2IyWEtpNFhIY1NOOWYrSHRDK0w0ajdtWE0zQ0tJ?=
 =?utf-8?B?aHFSeDJTK0Jqa21pQlV2T1RDVVQwcXBxT1lUNTYrYnZHQXN1WTFEb0xXTU5a?=
 =?utf-8?B?MXI3eXFLRkxnOVdaaUZUSkxoU3JRZHdBckRSQUk3aG9GYmpmdEd6MjBveGJJ?=
 =?utf-8?B?UnpVZVBncnk5TTVTcW9mYlNVdzAzTWtBVlhzSnFPcXhxNzQ4c1Q5MjlVSW82?=
 =?utf-8?B?Rjk2UkZQQUtCTVpsdUtyQzk2SmJGYk0vcjV0VWloa3NqcVRzUThuaW5pR3V3?=
 =?utf-8?B?c0QyKzhla0hETnVwM0YxZWhWSHBmcjBoT284MGdZa1VTQktRWTJtNk1GVElI?=
 =?utf-8?B?eTRiMEQrNGhLcVRmQ2ZIZkZIUGs3L0dtSUZOMmQ3ZjRvZmc1WjlrT1gvY28v?=
 =?utf-8?B?WW1LeU0rZzNZdFZId2RCSFh1WWZqeUhuOEFXbHhZSi9adzdJdWNtMjQxNnBQ?=
 =?utf-8?B?eSszWVBwalNqQ2JGdll3OStJb3VWcXRWWitZZXk3ZkNDR0llRUQ3QzB5Wktu?=
 =?utf-8?B?bHRyMWhaK0dXRUZ1WkVTNng5QllvZTNMc1RHaTdTNHVTaTVhdkUyejZ2YjBI?=
 =?utf-8?B?QS9mSFZybTkvcnBYd09lMTdLRS9RNnB1em5KZ2JvaG0xVjVsSnlwWWZpMTVS?=
 =?utf-8?B?L2J1b1hsbGowYmFwZk5lN202dWNKNThRUzRVcjMwQkdwT1VVa3JSMURvT3E2?=
 =?utf-8?B?ZzFvc0VaNzBrMFVRM1J6QlNTYUVSdldKMXZkZGlXcDYwazFFWC95UWRPRm1l?=
 =?utf-8?B?SW1CdlZsT3hBdXh5YTZKM21YMTRMM2hPWjhHM2hEMEJUa2hSM3VuVzJjQWtl?=
 =?utf-8?B?Y0ZkSk1aWSthUnpMc1g5enhKV3YyUDZoVWpsV0VVNGlhVFpVajV0UjlWOVBC?=
 =?utf-8?B?V3h5RC9WT3ZOb0xFeDlqbGdHbkU0MHgxdy84TmJVZE9MWlVkUDRIdWNuVFk0?=
 =?utf-8?B?VTNIeXhqV1F0dE1zeVNkRFdzODRkMVRMRkdJY1FWc0c5cXFZNTNrSXkzOHBC?=
 =?utf-8?B?dFJVZmhSUHdaeXRvUzR2a3BaS2pjUkN4MVZRWkVrSlErejh5MmpabjZxU1JN?=
 =?utf-8?B?N214VHJtY05GdHZ3MUxTaVFWcVZ6VWF5RlhrZnRKOWRWNkZycThndFNKbWNk?=
 =?utf-8?B?WW81U1RmTDg3L1poT0h4N0ZvWFEzMmpOcXZBUXRnZTkzWXR0U05TVkttS0l3?=
 =?utf-8?B?aDFaVWNSdWo5Y05UelVhS2FEbzhRKzh3bFBWK0pkWHFTbDNoUUFvQVdyZE83?=
 =?utf-8?B?QXhJMkZuMkxxd2U2cW9VV1BLNHJRTlo1SHF1Z0FTS0ptK09JZUFmY1RuSXdM?=
 =?utf-8?Q?BeUJixirkB5ozOGrou2aP7ion9akn04U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0g3c1ZmaFVQaEJIZE52NjZyZExUQzJQOHRsODJ6T1p5WmtXS2NWOG1vYlFW?=
 =?utf-8?B?bk1KVkgyQnhoWjdvdEgvc0ppZkNzaVluSUxnbnVjb204YWRucXl1MFluWXUv?=
 =?utf-8?B?VFk0TjBQOVUxTzA4OHpKQTJxME1IcllXYWtoRTlDbStNaFpWYzY4MTNZMmFM?=
 =?utf-8?B?S016R0U1MGtPRVFmVW14TzBuOFU5M2xqUVFJaTlJL0ZqRXBWNGtkVTczQzEy?=
 =?utf-8?B?eTdWTUZTeURYbm4xNm9mbmw1SHFXNmlPb3NqZmt1SXdCRjg4WlM1djN1TU1O?=
 =?utf-8?B?bnV5M1Uxci9tRDdLdGpEVXdYdzBMdE5KNVc4TG5XNDNQMjg0dnErWG0wbElO?=
 =?utf-8?B?cHpuNTVxa1RJZ0RlSElWamd0cjFHU0lCSklQdktTQUo2ZUJJR2RmeFFYWHBw?=
 =?utf-8?B?YUhEQzUrQ1RaVGdSLzYwbmZ1Zm01SGo2bTVUbnRJNVdjMjM2eEROdmliMDNs?=
 =?utf-8?B?VXRpUm1VV0lGMXBkL1VBQ3djcW9xNWFGaFI1MFFnVFhnY3JIaWo0TFA4MVFy?=
 =?utf-8?B?cWtvNHlrajVVQ0JGbCtSWWZtKzRwQ3ZITnFJZjdqcllyd2ZycHNpSE1Ua2tq?=
 =?utf-8?B?bWovUzA1bTJCOWJReC9MOVJjcGJwMkFtcDJhVHM2L09QSVpZbWZxTFcyQnJw?=
 =?utf-8?B?clF6OUVJNVRTWlhqVWFkeDNER2ltaXlTR3FyV1AxR3dZdDhQZkxEQXNSd2JH?=
 =?utf-8?B?N1o1TVA2dU12NGRGMWR2TWdpYlRqeTdGTFNtek1XU09JWXArQjZEYXdmRWJJ?=
 =?utf-8?B?L1ArUzFOSkFqVU9OWmZYcEpyMWJ0a0VvRmtNb3FLWDRLOVpWOGtXT3lhRUVL?=
 =?utf-8?B?L0VLNTVJUVNlWENGK1hYQS93bTZ5cHpibVVucVA2Y0ZUN01NSTAxb2U5ZjFC?=
 =?utf-8?B?cXlxK1pXL0tFNjdSSkNmajJ5RjlnenRPclRBdGVWRG1zeEdrZXQzRlJuQkxM?=
 =?utf-8?B?bUMwMXpNQ2Z2bEViQW9VOTBEQk9oODU2RFhyTzFmMjJGN2pPcEFKRzh0WHFF?=
 =?utf-8?B?RGhuSzJXOUx5V012VDRzNkkxM21UTlg0SDAwTHlxZHg2cE80UUFMU3ZHWnBr?=
 =?utf-8?B?WTcvZGhFNFhRSTVqL21pU29yanIxYWIraEphZXFlVXVTWmk4UGwrZUJZeW5Z?=
 =?utf-8?B?YkpGcURGR1JMbGRwWkpNYXNWZDJIdjBYZzF6OVNTUGhSbzdIN2kxclEvQmxV?=
 =?utf-8?B?MCtpTHJ2N3FBLzBoTWN5Qm1uckJ2TzJaQXZFZHdRSW5DR1k0WDJhYmZFdDZC?=
 =?utf-8?B?cDBPV3ptN1FocUVkNXdSVVV5enlVZzl0MVU3ajcySXhTYWNTaWhpWDhqbmJZ?=
 =?utf-8?B?b1ArVjdUUVFRTVVLejBkcXhha3pDak5ya1hFRHdXVHBPVjBDTFhBNmc3Qkk0?=
 =?utf-8?B?R2w2SHRMRUhIT1hoOHJkNG9kNGxPNithZm1HYVdabzdRTkFKblFJN253T3cr?=
 =?utf-8?B?bzZZczQ5ZVFxWmVIei9lVFk2MmxRemgwQkphR1g4eDB1clZ6TzVSVUFUWnN1?=
 =?utf-8?B?VkNYWFBsYjV6a1MyTWk2ejJRRXozTkVYV01NRnhsQzZOS1RNQnh2RlE4ZSsz?=
 =?utf-8?B?bWEySFdyUTZwa3VPaVJIU2Q1Qm5UNCthZkE4RGc2WEhldkdmUHFLMU5PRjJh?=
 =?utf-8?B?c2JOVUd4STRzWTFEYTVJRWtnd0dSbHpqaGdYWEwzaXdOL2VBeitJZ1RNME5O?=
 =?utf-8?B?V29nZkVDaGdXems4VkwvYklzenFiQzFnWk5wZEdBdUFySkVxNTF6MUN6d1Q3?=
 =?utf-8?B?aVFuVThCVmZXZUY1cUFOaERpU1ZURjF2dURqN1NmQndJWFU5T0pPVXViZE5o?=
 =?utf-8?B?S1dNaUVsajFqQ2xhRmo2WmRybUovdk1jMjdUU2hYUnFFNlBhM2hUM0lRTGxY?=
 =?utf-8?B?ald4QXcvcjdQdE1rNUp2SEhkMXRjaDVkWjdoVVNubTArd3M5eWNQMVM3bVNy?=
 =?utf-8?B?MENnaDlWRUZOcndtd0szMnlXTUtSd3dMME1vam55TmoyZE1nUVp2c2loTzht?=
 =?utf-8?B?S0E2UEQ2MmUzUzluZGtFaGdicWtTVUNSamw0WXpvaUpveCtNY0l2M2Rnelc1?=
 =?utf-8?B?OFhnQnV6bFBsZTdZQjZmZHl6TDllWC93aERJWS9YUURtMWdUcTZaMkg0VWZI?=
 =?utf-8?Q?lf9UimcQSzgbfp1qO0nfv3KbE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfba0495-16c2-44dc-22fb-08dd2ecf2c3b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:55:49.3837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1ygKEad51kBFTyoAdfPqs9erb5jo93/VvfE2t9IeIsY6oGr99kGXIHTYN6lJvB60qt9BtxN2gMNVnsOnWADEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8587
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

On Mon, Jan 06, 2025 at 09:39:57PM +0100, Marek Vasut wrote:
>On 1/6/25 6:27 AM, Alice Guo (OSS) wrote:
>> > 主题: [EXT] Re: [PATCH v3 01/17] mailbox: add i.MX95 Messaging Unit (MU)
>> > driver
>> > 
>> > Caution: This is an external email. Please take care when clicking links or
>> > opening attachments. When in doubt, report the message using the 'Report this
>> > email' button
>> > 
>> > 
>> > On 1/3/25 7:45 AM, Alice Guo wrote:
>> > > From: Peng Fan <peng.fan@nxp.com>
>> > > 
>> > > i.MX95 Messaging Unit (MU) enables 2 processors on a chip to
>> > > communicate and coordinate by passing messages (e.g. frame
>> > > information, event notices and requests) through the MU interface.
>> > > This patch provides a driver for i.MX95 MU using the common mailbox
>> > > framework. Currently, SCMI exchanges on i.MX95 uses a mailbox
>> > > transport with SMT format, and the hardware used is this MU.
>> > Is this ported from Linux ? If so, as of which mainline Linux kernel commit ?
>> 
>> Yes, u-boot/drivers/mailbox/imx-mailbox.c is ported v6.12.8 Linux.
>
>Please add that information into the commit message, including the kernel
>version and Linux commit ID , in case this driver needs to be updated.
>
>> > Can you add older iMX SoC support while adding this driver ? It seems
>> > imx6..imx95 MU IP look very similar.
>> 
>> This patch-set is only for i.MX95. I can add the older iMX SoC support in the future.
>Maybe you could split off addition of the MU driver into separate series and
>do it for all the SoCs right away instead ?

Adding other SoCs support needs tests, but to tests other platforms, we
need more work. We could not just put code here that not tested for other SoCs.

we are hoping to land i.MX95 in near term, so I would prefer to extend the
driver after we finish i.MX95 patchset.

Thanks,
Peng

