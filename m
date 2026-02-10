Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0CCEA3F0F
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 06:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D642D83CEA;
	Tue, 10 Feb 2026 07:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lzHiXIjx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81A698341A; Tue, 10 Feb 2026 07:57:39 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37EAD83CEE
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyjaKvPm52nTS1mAYBVA4gPB55RDpC40sMrA47MMFaGVf1SaqZVlkF5vmp08nVmdusrD0b0+7bTUxDYScU7yKu434GrQ4+/fWJrdkhsRwG2YmQ2bmVGOoCrvwUM47LvWFSwvwUZ24PRhd6JxGokR+qu+3bso7j70kxsMMcEZM7Ri5yGMslWkkg53DN9Vc5ay4bGfWEybEwu1IQclxQreHTCIcXSgVqM9D34hv9PwyoNGs2JBq+VCkBud8MibstycLX+nTx3Qjgw1Z0v/abPkr+wZv4Q/rnhClyL08imlljAYF/LN9D5rIfXpL4fQj6bZH+mkKIRbRhp3oZoGbSt/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2sgJzwm4Nsu0PQDiCpXYhhOOfbmo+aP7C0iT0t7IiM=;
 b=m4A456sC2/Vq70EG5SB3ZjSs3XUy+GvJtjJvP2HXq9WbEaAQxD3khpDF7jtxBPbxs3Q/bv3V2zTBcBgRibgh6D+pa5M+/vHpyUTz/MzvmhoVmEor58DPB9SbRKKLu0xm7B29ukK5PB0qFAWt6ZFZv0A2M+Ao+DZJ6ICbHk+ol3Xi86GWHfET0VPZ95Md2YJPCGQDtRJW/u0M0wm5dpc1dLjYdOGuVRm8KWfb7hUFGvEZ2qrmIrrMTS4+CKAeyNH2FNitwQzrycE46ODpTT8KI3UBPMnFVyURMyKDOBcOg5hEDnK3fggDdFa07lGvt6mcP730hCGZM5imXj1cpjAjqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2sgJzwm4Nsu0PQDiCpXYhhOOfbmo+aP7C0iT0t7IiM=;
 b=lzHiXIjxk4hjLjAO1hnV+L9r/56klv8TwfVD6DNfj8euTTyouty0AAh6ViuH3MvfXdHjn4E33wQJAewixyEsYGph6Dp7a+BEJwGFYoXjcnEJAFDH9bZl4jB+Q/vW5nEtuWgW3uYnD7nTR0NfMtqlXd6xDVGR30okxiHZGgA+IA35PvHTN/IhN937CGdSsYlQdcMs4k8hyFDim4OYCI7d+g6MQi2it5gRK+C8bJx+85j1Gns3gTrd3efe9uXLGxcaFeSMfNa8OHJh2dwSJCX1GsGIcO89FP581IAaxDlFfCrsRmbfx7DTREqun/kiXXCx6EPIOWm713YcuVTGX7zPEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7455.eurprd04.prod.outlook.com (2603:10a6:800:1a1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Tue, 10 Feb
 2026 06:57:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Tue, 10 Feb 2026
 06:57:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 10 Feb 2026 16:12:15 +0800
Subject: [PATCH 2/3] power: domain: Validate device tree node in
 dev_power_domain_ctrl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-scmi-fix-v1-2-0d75f57944de@nxp.com>
References: <20260210-scmi-fix-v1-0-0d75f57944de@nxp.com>
In-Reply-To: <20260210-scmi-fix-v1-0-0d75f57944de@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: e28a4845-9dbd-4a16-2ca4-08de6871ab54
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VndValBKa1FMYmNOd0g2ZWdmeDc5NjU2dGJJaXoySmt5MkdvNmxqR05qU3V4?=
 =?utf-8?B?WllTUHl6MDFJN2Uxb2owNXBRTlRNejlFclhhZThHWFpOdWZXcVQ2Ky9xeVI0?=
 =?utf-8?B?ZlBSSWdKVVFBVjB1dTNoWlhoYjhUQlRpMVNlc3dKem80M0kwa3V1U0ZkMFhl?=
 =?utf-8?B?dEJ0SmtHU1JvYTBsdXU5Z0lFUWw3SGNKcXZVRzhib2x6QWtVaDNhRW5DRWx4?=
 =?utf-8?B?VTBoWHN5Mm9LVzRuOXM2S3pTQlp5dmQ5UVNUNGR4ZllrbEJZb21QNHpKNVhE?=
 =?utf-8?B?MjQ3djhzZk5abmhXZk5oQW9VOEpUeE54OHl1dHVuUDhwNXZidnB5MEI3eHJl?=
 =?utf-8?B?bTZKR0I1LzhpcU1DTHgwQjFlc3VoUW9nZ2NxRDdUOFBma0JwM0JRNHByT0Ey?=
 =?utf-8?B?UUxJNktUTW43c1RDa0l2dUpiNHRPaU9aUkJtY3VRR3lYcXZkczYxaUpHbEFz?=
 =?utf-8?B?bXZBdHgzL3A4elVSTUlqbVlWRzljcmQrS1Y4UzFHVnR5cHFvd3JZYUdrZU5z?=
 =?utf-8?B?TXk5SlZMRkRVSFJ6QnI3YmRkOWVON01BNytwK0RrZGtGMXZEbjVjem5jM0tS?=
 =?utf-8?B?ZGlxV3BWbkxlcDFaOXpEWDdJU3VkeGoxYTNaRG9vWmxUcjVUZldaekF6NzJl?=
 =?utf-8?B?QzgzM2FzdjgyUGJsKzNOQnFudjFWT21PWG1EOERUeSt0MVpBSllDOUljdk1Y?=
 =?utf-8?B?SlJQZGFOUm1GWEdJM2NCNjVsL3FSU1pQV0hMYklVSWZWRURJVzhHZ05hamdN?=
 =?utf-8?B?ODBKbU5pTDB6NW53VFNYdGUrb1MzRVU4Z0FlUGZqQVlYUkNUZUt3T0NKSVIy?=
 =?utf-8?B?ZjJYR3oxcTZwQk16RC9uVWJNbi9QcTl1Vlo2RVdaazJWU3M5UitHV2hjNU1a?=
 =?utf-8?B?THRQd0tORnZIR1o0MldDYzZGZEVPdjNGZTYwWHpIZkdGTHhlaFJDcGRKQVZN?=
 =?utf-8?B?QmdLNytqY0g5RTZFYmt6MllTTEo4MFA2Qi91SWIwTnJRd005KzV4MEhQbFI0?=
 =?utf-8?B?M3dIVGdaK29Ed21WWWkvQWVqMVVJVEJBS2RkN3d2U3J3M01zMEJWcGNWWk1l?=
 =?utf-8?B?S05iR1BxY2FMcHkyTmVTajl5YzQ1MEFqZDhDRko3V2VlL2psVzJwTUUvaGN5?=
 =?utf-8?B?WHppYTE0NlFuVXV2Tm5yUEwrZXZsdklJRjA0TUVNOHBCbTAvZTNoWlIvK3Zh?=
 =?utf-8?B?TDZKTW1oRWVjN0Uxc2owdHpNQnJya2IrSm5yeW9VR2VmU3Rud1V4Ylc3Z2ZF?=
 =?utf-8?B?NlVQRk1hcSswY0VxMkYyYldnM2M2TFE2YVVRU05LRXpYaUtpM3JxUXZPK2J3?=
 =?utf-8?B?dmMyU04zVWlIcy93Y01lRTRkb1Q2eHVQYkJtcHZhWkE4ZUlGU0x6SUFyd0N0?=
 =?utf-8?B?UW81bThPY1ZwYnRIZ000b3JVcjV1eWIzQmZ6bmdlVjM2bGl6YzNFNk1HR01w?=
 =?utf-8?B?RzBBK01WM2VQZHRaQkdvOWFaVmxiMEhKV2l1NmRwZnBFOHR6TXM5TDZKSCtR?=
 =?utf-8?B?MElmRVh2dE9HTys2ZmFMb1M0U2pHUG5IOVRQd21TUzRxVm95L1NIZjM5WW4v?=
 =?utf-8?B?ZElPZ3ZxWmdlam5FSzJ4RTVmRUVTRGozYnBKOTU3Mlprd2ZPRXBoNWJyaEwx?=
 =?utf-8?B?RVNGTjA0OWJLalJySjlqMS9tdGtycElHZURPYTBqcTJ1bjJsL0JyckpXeEFm?=
 =?utf-8?B?RXNNdGNvUWJmSEQwWHdiSlhGTS9aQnpMdTUrRlpqSTh3c0ZmeGw1RnZVdU91?=
 =?utf-8?B?Wml4M3VNRHdSamZoYklZK25YU283YnN2YVJVMkd1VEVKdTZDQlIzMXgwMHBy?=
 =?utf-8?B?M0ZzZE1Pc0ZoZWRueWF4RmtpR1ZLQWNDcWNkWUFlMkFEYUpYNkRVL3Z5U09K?=
 =?utf-8?B?aHYxRDNZaTBodFZHdmRTakZZcUx5VjUyS0dwOFlsN1NmcEVvM2E3RytoY1RN?=
 =?utf-8?B?MmU3ZVl2ZHBqT2VyMk4veTkzcVZrYzdQN1d4OHhzdVBFd3ZJeFBSNTFmdTdX?=
 =?utf-8?B?L2FtWHdjcUNIQXNWV0Y4Vy9UOFVHTWhralZmTjJoWHhoVVVRa2RjNUg4djlX?=
 =?utf-8?B?MlZhL1A5dU5SaTJyc1NxbzQxeXFrM0JzODB3aElyVlVMaS9pVEZWcjZoa05E?=
 =?utf-8?B?dGZrZEQyak9hczlTc3RUanY5ZWdDNDF6ODZ6blp2OHNaMytQS1ZJR2lLWml6?=
 =?utf-8?Q?oft13I+JnoZ8uOVwsso1pvw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2draVkwNUx0OGc1cDJCcmRJN0VPY3ZHcWdPdEFhdEd2MjcyY0hvNUlHMmlY?=
 =?utf-8?B?aEhTRE5qM0UvMGdrckk0K2tzUXRnQWNWU04yYTd2cUZFK293Y05nWXd4dXpY?=
 =?utf-8?B?MW1CbDluMkNsMEF4S2EyVEl2b3NVc2xOckVCbFlFU0ZOWmc2WHVBbnFQQnEx?=
 =?utf-8?B?c3lzNW1wNmhKYVFjYnV0R3l0NGxycWl5MC9rS05LQTY5VVZBY3RjaUVZTGc3?=
 =?utf-8?B?VVVEZEJ2NnA2WlF3YnhXVW5PVjFlcW9kTjI0V0NWWUxjdDRSSFRQUFdsRmkx?=
 =?utf-8?B?cStXUUdsZU9TeDRaV2tzdEExN2xVVk53OXNTRGcvRlVuODUxc2U4U0xCRTRO?=
 =?utf-8?B?SzBtbHdiZnd2YmhvMnFQdnNWZjFjb0JmMVl5alUzdkQ5NHQ2bTk3VXpZYWQ2?=
 =?utf-8?B?dzMzOFpqMld5MlhpdWREV2diK0NNVkVkTzE0bEdtdnQyTUhRaGtZdjkxNnBN?=
 =?utf-8?B?U2lPLzJ5TFJ5VDBrT3ZRZElZZ29tbkk5TGdLSGdPVFRwMENXaHNoeTJWMWt3?=
 =?utf-8?B?K3ZqSUJFYUFqeE9ib2NPNHBuUllIRzA5Z3NCRFRNelhzT0ViSHNGQ0xXWENw?=
 =?utf-8?B?ZjlOZU50WTZ3ZmtvNU1PdTE5bXJXSDBvaVVOZFpURm9nTGYwb0VnQmZrNndx?=
 =?utf-8?B?NGtVRCtvTlM1OGdFVWNyWUdweWMrN1R6WVl6bVdkTWtoeDJ6dW4yVnBDdjRR?=
 =?utf-8?B?MWJHYjBBZEZwQTgrUlRJNzdJUTB6OC9vQklYS1didXYrN0VBU1JJa1ptQmVO?=
 =?utf-8?B?bnlkWnNpSzZuSWg1RGdBNFlodFNMcHlLUFNJc0hObVB0QnFCajVwdXZ0d3Q2?=
 =?utf-8?B?OVV1dUlVTDRjZmt0NXQ2WGRBZm1CSE9lTDNtd0pTUmhQYmdvWW9aL2YwcjRE?=
 =?utf-8?B?Nmg2RmZwd1FHdVFHMkJhclp1OUhwcjNtNGNUZnQrQ1N5UFU0ODJocXBPK3Az?=
 =?utf-8?B?VVlKSzE1Ly85a25MRUJoSVJLSW9SQjBJcEFrczYxSjIycGM5MXd0UHJENUdM?=
 =?utf-8?B?Rm9ieHgxVjdxd0VFV2lWVVFrdHcxUG9ZQ2xZK2c1OWwxSVJHQXBwWWJBV05V?=
 =?utf-8?B?aWIwUUVCd3N3L1RUb1ZZUFNHcXA5YVpPTkdUcjNRUk9vazN6NmJ5V3c2U0lr?=
 =?utf-8?B?YVNFdXd3T05POUc0U3BTTE5XQlplY3hZZ3d2KzZBQnJ5Z004ZnVrazBJK0Nh?=
 =?utf-8?B?cDdZOTdnbTd2TnZFQUp4ektCckIrMmhsdkwwZitUT2dKUUgxMnl2QTZITlpO?=
 =?utf-8?B?OHNHTGMxajRjS2JwMGlXcS82OXY1Zll1NWNrSERGWTRWVTBYWjFGTDMrV2Rj?=
 =?utf-8?B?U29ZeWk2UklWdFltOWs3OEpLRDhhdDlVdlE4eCtKRTVZckE1TjJJaVQ4S21v?=
 =?utf-8?B?TlFiVVk1TFBVd2xjZ3lRT0JTbTlwMkxlOEJOcUhUNkV3Q1JNL1RGaitGSjRJ?=
 =?utf-8?B?VERhcHIvMjQ1NGpOTGo4Zk5IS1h1cUxXTGVXT09KTUJxOWgwdzQ1eGx0YlN5?=
 =?utf-8?B?V3p1MERlcHRuYzc0SUpweGY5cGVwY0N2bmVra29KbkQrelZ4dFVvWTNlOHJr?=
 =?utf-8?B?KzUrV0FDdXR3VTdJWUtzUVg5ZXFhRnNheXZwQXUweWpaL3RLKzEzZmdKckVa?=
 =?utf-8?B?elRtejZVSWtEZnQvUFloemJRT2xsRVEwSkpzZlhyazJ6akNJK0xZbW93alBO?=
 =?utf-8?B?RXE2RGd6RjU3RE1rc0RIRS9EWmV3NHAycXpPWEZISWxab0k0MCtVUXlrUVlB?=
 =?utf-8?B?WENUd3Q2cWdEY1dxaXpsbEFST3J1MG4vNTMrZG9pWmk3ZjFOTjE3cCtGRUVN?=
 =?utf-8?B?RE1QWXVyUGtOVnNNK0pQMk1wUk9ZREZnVjlDTXZvd0h3a0RrOVkzcGE0dE4y?=
 =?utf-8?B?UkNMNlVIRHQ0Ynk4OG9tZmUxM1c4emwremdibTNKemo4eVVpcDc0c3o1a2kv?=
 =?utf-8?B?S240K3h3YjExeHFWWHlHaUlVK3orTHU5N2F2ZjhpaDFUSnEydjdFR28vaHZx?=
 =?utf-8?B?NjZPMHVmdDVLaEtHT0Jhc0NseTR0WjN5UEwzK2pCU3EySnYvNlBQc3h4VWor?=
 =?utf-8?B?SUtYSUp3WlhVQWhNY0tlaW41aU0wbnI2dC9XS1F6bDVaNDdZak9ndUxEdDZn?=
 =?utf-8?B?MkxsTHNEcjBvZmN0TDZKY2pQWDN4Y3NwRkc1aHNFZi84QU1tTjM2QTZVaVBY?=
 =?utf-8?B?KzhnREVFTW5BYVlHTFd4WGRmU3ZZazl4TGRWbFRDdDJjSTROSkFJWVJqaFVQ?=
 =?utf-8?B?eCtpRTZ6SkhjNFhpcFA2cE5RQ3B4Ny9XZVpXRnpkU3ljWFRnUTMvVFNYczVV?=
 =?utf-8?B?dWdhMGZUWUhDLzloMkdPSG1ZRmdQNzBPcmduZlF6TUZmQ096WXVaQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28a4845-9dbd-4a16-2ca4-08de6871ab54
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 06:57:34.9682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAbFsHoRHYZyFCtGHBYd51kwy2HWDxl9n3/MmEuwpKD8/v92ORYI9S/8V4cwYPTPvFiMEkFtbwBaqNeV5PBpig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7455
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

Similar to pinctrl_select_state(), add dev_has_ofnode() check before doing the
real work. Device(scmi_base.0) does not have a real device node, ofnode_null()
is assigned as the device tree node for scmi base protocol device:
'commit 7eb4eb541c14 ("firmware: scmi: install base protocol to SCMI agent")'

However with recent update in
'commit 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")',
SPL panic in fdt_check_node_offset_()->fdt_next_tag(), because offset is -1
and SPL_OF_LIBFDT_ASSUME_MASK is 0xFF.

So need to validate device tree node.

Reported-by: Ye Li <ye.li@nxp.com>
Closes: https://lore.kernel.org/u-boot/939a9696-27fa-45a1-b428-feffe21ac6d5@oss.nxp.com/
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/domain/power-domain-uclass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/domain/power-domain-uclass.c
index d9fa8ad4bd2..cea68945cbd 100644
--- a/drivers/power/domain/power-domain-uclass.c
+++ b/drivers/power/domain/power-domain-uclass.c
@@ -180,6 +180,9 @@ static int dev_power_domain_ctrl(struct udevice *dev, bool on)
 	struct power_domain pd;
 	int i, count, ret = 0;
 
+	if (!dev_has_ofnode(dev))
+		return 0;
+
 	count = dev_count_phandle_with_args(dev, "power-domains",
 					    "#power-domain-cells", 0);
 	for (i = 0; i < count; i++) {

-- 
2.51.0

