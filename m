Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE5BEDF17E
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 16:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FA8083AA9;
	Fri, 13 Feb 2026 17:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WPMk/fOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A90783AAB; Fri, 13 Feb 2026 17:55:44 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEB2783015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 17:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zq+a/w20stAGyD2OrYn7s6l1FTC+18G4Jn/KCYVEQdgLWFDe3FNAhqRqsxB+4cPd02ICouEv+K6Is/shTGWycyXOKXtxQbAwPg4U7bGxUmUDogaK6dCD3oQvu304/dJsnnU4yN4G8SHx3TYKvwGrb31T53eRdkspXEqumtGn148l+/YFOt5Zdjic98jRPifg23plflxQfzC8v+n+ItyNB40yREi/EmLWa54JGCzuVQZwY2Y2zCKKq0fQT7mjZAJ2pzM0DLMq4sOr4H2unGbdrfZonq6pYSaH6HXp0goxD3kWS8tKjNEc13I9LbqMM2W+J32tyzsJXGeJ+nNudHZyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTm9MSKMEF4Q+8MDB/vqPS0JmRj313VZ+FJk3vX0qaA=;
 b=KqasSjRJsQ/GtL3EQPdcddfoCpV3I5OnUMYwyOQcDt6apzlG/+EntaDf6jOYhqDT5FxXMIr3Nuekl21N6hE48c5s8sVAYPQ7FEolhVw0Co1TPU103XTd/kENaAufgtSgzP5jQXuRyBnyU7uiSFxausg63FW+hcutNddyYeA6g6RWesXznlybSIsI+/tKtXulUAc+jBCX8JLfPeJqDAJ2ZU9yIcQRFS8WYoKriSQftw/ldksEx7F3/cgtDJamDh6jE+bgArInFU8iB4XIDbNrFLKzXduwAHEUWGWViDc6rd+VhydbknSp2AU4Ck/Eq8HrFo5iJhFtpJ8qb2Ih4xvffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTm9MSKMEF4Q+8MDB/vqPS0JmRj313VZ+FJk3vX0qaA=;
 b=WPMk/fOpqet6Z/+cHuNbUj/+tCwcqQqrrVMGaLkESFQd2vr4UNMPzLUKtQA5KEuNj7e0OCbt2a9T1VMynlSB6qwiFWlS6CSKYHrWyrylW50m9U4hzi8G5S8wB5YZnqsUD7utS6NVbBjgyyypr7acb7gyThSEljlqiKJHnspEg64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU4PR04MB10933.eurprd04.prod.outlook.com (2603:10a6:10:586::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 16:55:39 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 16:55:39 +0000
Message-ID: <3c53dd73-59f0-4473-a1cf-2000206bb730@cherry.de>
Date: Fri, 13 Feb 2026 17:55:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] rockchip: board: qnap-ts433: Rename the board
 code to not be TS433 specific
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
References: <20260114082822.4007128-1-heiko@sntech.de>
 <20260114082822.4007128-12-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260114082822.4007128-12-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::7) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU4PR04MB10933:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfd7418-7aad-4260-02a1-08de6b20b749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjllVHZ3L29PNnR4cTU5RFAzbi84alBkK0JMcHArbytFekF6MCtkd2dwRHhX?=
 =?utf-8?B?QkZKc3ZyQVIwcmhoamo0NXo4T2ZYNUZ0UWNNNFh3WjFSQUcyZ0lZR2dtVlZK?=
 =?utf-8?B?eXZoU1dQNE1uN2xQSmZWZG11UVUwRzJDeTJRNDR6NG5ia3JxMUNLUjBOSDRq?=
 =?utf-8?B?UENSbVk2OVdlTXRubSt1NnVQd2czYXlrWTBpeDlvUGRWWWt4cFJVYUFJQlhO?=
 =?utf-8?B?V2puUDBYakZ3YndLNElzT1paK0IrL1RMeXJXd01hSnhkTUk5VGZDTEFrMTBV?=
 =?utf-8?B?ZVB6UkZ2VG95ZEkybXVwWkVFVWF4dTh2YlZlZHl2YllEYjY1M3hERTMvSUo4?=
 =?utf-8?B?U3I1c0pKZStLTXdqaTBsQjMyaEkvMEg3V2h0TVI4c3lOTVdWcDVCQWtHYnZp?=
 =?utf-8?B?L3RtbFcwU1ZBQkdHZm50UFBsVnVnU3dmeksyUnFkc1d3ckZya1pYSmw1SkNH?=
 =?utf-8?B?cFMyOVNEWUY4aFlJYkYyNElYOFlMNmp4QVVhRm9rYklFWFkxdHY4K05Hc1dR?=
 =?utf-8?B?bGRIUzRPcEhjZkNid1NkMW1DeVZZU1hwRHQxUlpLNWE3WThCTmZhdWh5Tk82?=
 =?utf-8?B?VkpGMVdCV2E4SDM4VERPTmpFSDI3a0cwUU5kdFNBMXZuWGVoYlVUYWxJZ3Jk?=
 =?utf-8?B?WHl5bk9tRmVVRHlJemMwbS9lM2RJWmRHSU9qanRzVm9CbndOQ3F0VnBER0RQ?=
 =?utf-8?B?SUgzdUNwTVVpalB3QlN5QU0rU2FDSG5VRkNqTlhOcHVOb2JZS2s2K1kxOGdt?=
 =?utf-8?B?Mnk5YVVmcFpLb2tLV0RsSXNMbFJoS0QzN1pmVnNGWHFST2wrTXRFMy9KU00y?=
 =?utf-8?B?Q0VMaDhkZjM2OHFLd0p1TWpObmZ1c2ROOExYdU5MOTVRU0ZHM2VpVDFiZW9J?=
 =?utf-8?B?QzgxOHhyaHlYTHZvSjh6NUVONnhqZWcyRFdJOEFPQm9VY3RwYXZFeGpDR0lB?=
 =?utf-8?B?M0d5YnErRDg3clppV0lVZzFqeGFyaFpjVkNFb0FHRzhiV1l5Rnh4R3F6elZI?=
 =?utf-8?B?OXBXL3Urc1Ntckx5UjV2SmorSkRNME1oZDBUd20wSjJjVHByNFRVQlR4bmFh?=
 =?utf-8?B?RDhRcHJqdDNTTmZTcVdLQzlIc3JQcGJteDdTclYwTGpFc3BWOGpqbVgyYlFv?=
 =?utf-8?B?bjB4V0xNK25DcTdlMUN2OWd5UUZ5Q1licUFnTXZtSXpIeFBUOHlUbzc4VU5u?=
 =?utf-8?B?WHJSOTRsZGpYRm0wbTNCbGtWcmR4SHQ0ZVdlZy9vTVkrdHRaZmxzSjYrNmV0?=
 =?utf-8?B?LzVFVkMwdzRjM3h6c3JZVEp1Ny82TEttWithdHhaZlQzeHYxbmJlWkcwMWVQ?=
 =?utf-8?B?cENxWFIyNWs2WDFlWWp4TjdRTENNZzY5OVhKY1M0ZFZEelBMUnQ0UFRzM1J3?=
 =?utf-8?B?MUthT3RocGF5WmxuaUpSY010ZjM4NUtiSThaVm51dUd2eCsrRUZhSHZIeXFJ?=
 =?utf-8?B?QUJ5S1pnYXVKdm94S0dkbjh1dWJTTWpyUlE1L3hrV3hjQzVvdnBXNWZpWUZQ?=
 =?utf-8?B?eXhDWUxyNHhkK0lUWWdZK1pSblpsN1ZSeUgvNnMrMUpELzV1ZEJkTWNZSUM3?=
 =?utf-8?B?YUpEQlo2Q0QwcytZVWJGb2UxVGVwbG81NkdnS1c5TXQyc3haVUJtV0QxNk02?=
 =?utf-8?B?UWVQem9ERUZDelJXTlBYN25WUHA2aWsyREZsSzhQb2w2d1VpWHBGbjJUeW1n?=
 =?utf-8?B?T0dIUGUya0pQMG90YjVwSGIvZzEyQ0R0Y1R1Qzh4NGkyUDNDc3luNVdMSXlk?=
 =?utf-8?B?TDNtbXB6SEpSTHg1VENGVmdhSHhTcjIvc1NJRGJwb1BGTmtoRENSUWpFQ3BV?=
 =?utf-8?B?L1ZaL0QwWFVUZUdnTm9FOTdtTUFDemtkUDZsYjJXaWdPYUJIeE9FaG03Q1VI?=
 =?utf-8?B?OU5pSVphWVdOZ0diRXlvcFpkTmZvTXNmbVF3LzhDZmxwZzdqdm4vNDhhcWUw?=
 =?utf-8?B?Z01HVzVoQjh4emc5RnlsWklMTHdxYmxIUnpwSm0rekgyc2FaL3JTZVpUMlE1?=
 =?utf-8?B?bnpQN1AxOWw0WXhXTjF5WVZ4bld3TDVkU0REMkhpY0VSY3VwdG1hcTdiZ1dy?=
 =?utf-8?B?ZDdUUzlkQWtNOUtrMUNaT0JYM1ppbExRTWRBcDlQOWNwM2xUNi9YM2lPSzRz?=
 =?utf-8?Q?B7Ek=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXhqR0FnQk4zVzhuNG9IMmowTVJ2dXlRTXV2ZEhHd21zWWt5Ly9ycDFBYlYr?=
 =?utf-8?B?ajJMOW5rdlJZTlNuclJnMnp4N3VpQTNZS1BQWVZvQ0E5RThjMldNQk9QazdC?=
 =?utf-8?B?c0RFRUVXQmtsVm9SU0NiaXZPOVhIc01LN0U5dGpXaklqaGQrTG5kQ2lEZ2tF?=
 =?utf-8?B?bmYvY3RyWjNGYzVXNHAxN2NjZEFoUG9NYnh4S2JCQ3poRXg2VTZlVUZBN2w2?=
 =?utf-8?B?L3ZqbHF2RTNLNWVmS3VjZ2JJa2JlNCs3T3dxTER4RHpqMjl5N0J6d2IwVzNE?=
 =?utf-8?B?OWk4bGdVNGlpdyttaHArcHNLVVlmZVNMODBNNExxdy9pSDZ3NGtodVJLTDVW?=
 =?utf-8?B?MG9LQ3RoNmlEUStaOUFwUVNqb2JrWVVVbzdPOVN3YVJPR1Q2MFhiOFZMWmZQ?=
 =?utf-8?B?UmR5QnBlY0RNSEk5TzF1MkNwQXNlWFFmbFVqdFRmamRVdDZmY1VZdTN4N0Fk?=
 =?utf-8?B?ZmxLMWlKOURtN3RndDVCQUkxMG9LckYwdFhTaDM3MCtxMEpUWitsQkxqcm0z?=
 =?utf-8?B?dVpaUS9nNkQ3Q2s5bjQzaWdSQy9FejNzSUdzV09CUVZ4RmFjaXRYOHJoNmlG?=
 =?utf-8?B?djFESlJnY3VKVU5FL2FmZnVPU2QwV0ZDZklQRGtld3Jzdk90dWVvMC8xNmJ0?=
 =?utf-8?B?Vm1ZWUpycitpN20zVTBoUjNXWmdDOTZKVm1SN28wQ2hDdzhFc2FHNXVGVUJH?=
 =?utf-8?B?eGp0MERMWW5OeHQvY0NNZTUrcDlFVFA4MXM5bGw0Q1BSRkU3YTZGUmtHbHp0?=
 =?utf-8?B?TTcyZ1ljUXpzQmxCN3plZkpZZk5nUWY2Y2U0a1NxOEZJTWNsaDVra0hEcW12?=
 =?utf-8?B?L0NxZzF3TXVpb2ZUZHlXNjM5cFVDYk1kN0NyMiszQWEzczl4eUQ4UUNQbndo?=
 =?utf-8?B?YWhEUGhOUENoR2tyaE1salpzWlJEMWVnUnQ3T01DUzh4WUEvWGJralpXdlBm?=
 =?utf-8?B?T3ZUUmxTZjdTUmZZTHFpby9FRmVZblVoTmMwblFvMklkcEZVZVlNWU1nREFF?=
 =?utf-8?B?a0R3bzhKVDVTWG0zbzJqeU5wU1ZMNzY5R2UxUUFZQmFhRGVORE94ekQwY0pI?=
 =?utf-8?B?Z1p6MTdCbWFKamhlYmxYVFIyeHlKQnNMMnNFaW9QRXBsZ0lDTTFQTzFhc2tv?=
 =?utf-8?B?anNIS2Zmd1Y5akJzSlZ5THkvY29YVFoySTBETmttR281SDlaaFhIMDFvYjEv?=
 =?utf-8?B?UkU3V1F2SURxRDZNZzlWRGkyMHdRd1Z6VzN1cHVRZlppaDZ1T0FNREp1dGFm?=
 =?utf-8?B?NUd4RDBLVUcyT21FUEc3cTE4UW9QSDgyTHFKdzE1RFpEcmhmS1lPS25lOStM?=
 =?utf-8?B?ckpjTVQ1QXFsMURoUzY1Sll2amViVTM3Q1VjeC9ZQ0theE9OQnkzTm90Ymlu?=
 =?utf-8?B?UyszM2J6blp3dE5OdzRBYWQ3VytGd00zQ0tCWElEWktKK3h6aElBRnFvbjZR?=
 =?utf-8?B?MkNJT2FqMmJXekQxY1VBOE1SSnhQNnZEandIVHM4Z3RiaFJ4VTdlOE5XYWlT?=
 =?utf-8?B?eTNxd0owQ0ttSXZ5Y1VKT1BPOEgxMGt4MUl2cEZKWjJwZWpaK0xrbVBuaHJY?=
 =?utf-8?B?RWVPN0RLbTdDUkdVbzVvN2MrSDdRcEtzK3VOY2hZYVE5Wno1bFRGc0R6N1Ru?=
 =?utf-8?B?TDBNUVJ3ZVpkMWR5c00xclh2Q0Qrblo2a0RGNUJnN3Q5akRRSVh5YndaZWN1?=
 =?utf-8?B?TU5JK3NLQ1IxeldPSHp4WW9OcUVSTW5uVjg3SUFwM1krWkpFTkUzT0RjUzA4?=
 =?utf-8?B?d2xka1ZuYWZQb2RiNmxMTXRjMGdTUlJqMktraWpGZHpOZngvMWpRV0tYWmtD?=
 =?utf-8?B?WFZjNEhwdjJxeW1oYlJwSTIzS3dGd2RCYkpJK1J3VVpUZWZxemo3Q0N3WUEx?=
 =?utf-8?B?cjBhajloVUw1WnZuQ2V6aFFnYmZ4aDVWQTMyUTg4Si9oZzQwNHNWbS9qSWhP?=
 =?utf-8?B?UGY3V0xjbDBHRGRXdXJWZTQ0c254cEprbHNBMkMyRTNsR1FWVW9YcUpZczJw?=
 =?utf-8?B?WjZsMmR6Q3B5VkVXc0ZRaC8vckppOTFOMVovQjhYRE5sRlpPUVFGd2tsTkhm?=
 =?utf-8?B?eWg5TjE5SFZOY09JbWl4NWlHNGU3dGI3cmdHY3pTQThTWFMwbENBdERXTldP?=
 =?utf-8?B?S3BQMmxxWC9MTEVEakhWRkxWalpPNmQzSzFkUndScHozQUVVVktTallRdlpV?=
 =?utf-8?B?b1dNenpHdFI5TW52ajRpeE1ITmpsQURJeUY2MGpqVUN0VHgzVkNtb2FTd3h1?=
 =?utf-8?B?K2FzenpwYmhzTlZaZkdzZnRBRmZjSW5GVmFwM2lwRytmeC9yWENURXF1Lzhp?=
 =?utf-8?B?Q1pDK21WamdHRDM2ZzZBMkVxVTd1akVzbFFuZG1wek5PSGxCOVE0ektzV00r?=
 =?utf-8?Q?GOSEZ8w1IHZDIUlJdTphy/jYJdraeWkAXyNnu?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfd7418-7aad-4260-02a1-08de6b20b749
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 16:55:39.2932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6LRUjzFKt/pyemP0RX5gpK5UII6H308/A8Kzxc80Nzb9VsFNft1A7CK5pzsB7E7ZUvfi3GWEywzaAbfRvLBtr3lvYZhX01eN2tajcxYkvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10933
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

Hi Heiko,

On 1/14/26 9:28 AM, Heiko Stuebner wrote:
> We can do support at least 2 devices now, so rename the code-side to a
> TSx33 form to not read as specific to the TS433 anymore.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   arch/arm/mach-rockchip/rk3568/Kconfig           | 17 +++++++++--------
>   .../qnap/{ts433_rk3568 => tsx33_rk356x}/Kconfig |  6 +++---
>   .../{ts433_rk3568 => tsx33_rk356x}/MAINTAINERS  |  6 +++---
>   .../{ts433_rk3568 => tsx33_rk356x}/Makefile     |  0
>   .../qnap/{ts433_rk3568 => tsx33_rk356x}/board.c |  0
>   configs/qnap-ts433-rk3568_defconfig             |  2 +-
>   .../configs/{ts433_rk3568.h => tsx33_rk356x.h}  |  0
>   7 files changed, 16 insertions(+), 15 deletions(-)
>   rename board/qnap/{ts433_rk3568 => tsx33_rk356x}/Kconfig (52%)
>   rename board/qnap/{ts433_rk3568 => tsx33_rk356x}/MAINTAINERS (68%)
>   rename board/qnap/{ts433_rk3568 => tsx33_rk356x}/Makefile (100%)
>   rename board/qnap/{ts433_rk3568 => tsx33_rk356x}/board.c (100%)
>   rename include/configs/{ts433_rk3568.h => tsx33_rk356x.h} (100%)
> 
> diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> index 16e14ee4fa7..725c008795d 100644
> --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> @@ -31,18 +31,19 @@ config TARGET_POWKIDDY_X55_RK3566
>   	help
>   	  Powkiddy X55 handheld gaming console with an RK3566 SoC.
>   
> -config TARGET_QNAP_TS433_RK3568
> -	bool "QNAP-TS433"
> +config TARGET_QNAP_TSX33_RK356X
> +	bool "QNAP-TSx33"
>   	help
> -	  Qnap TS433 4-bay NAS with a RK3568 SoC.
> +	  Qnap TSx33 1-to-4-bay NAS with a RK3566/RK3568 SoC.
>   

But TS233 is 2-bay?

Maybe do something like

Qnap TS233/TS433 2/4-bay NAS with a RK3566/RK3568.

Such that we know the former is for TS233 and the latter for TS433 when 
reading below as well?

>   	  It provides the following featureset:
> -	   * 4GB LPDDR4
> +	   * 2-4GB LPDDR4
>   	   * 4GB eMMC
> -	   * 2 SATA ports connected to two RK3568's SATA controllers
> -	   * 2 SATA ports connected to a JMicron JMB58x AHCI SATA controller
> +	   * 1-2 SATA ports connected to two RK3568's SATA controllers
> +	   * On TS433 2 SATA ports connected to a JMicron JMB58x AHCI SATA
> +	     controller
>   	   * 1 1G network controller
> -	   * 1 2.5G Realtek RTL8125 network controller
> +	   * On TS433 1 2.5G Realtek RTL8125 network controller

e.g.
0/1 2.5G Realtek...

I also see QNAP has a TS-216G, so even this TSX33 won't match (if we can 
support it with the same code).

I see the TS233 is still an RK3568 (according to the device tree). I 
also know that the RK3566 and RK3568 have a different DRAM init blob... 
So can we reuse the RK3568 DRAM init blob with RK3566 and it'll work? 
Otherwise, how do you plan on supporting multiple SoC variants? I think 
it'd be quite confusing to have everything the same except the DRAM init 
blob for devices that don't seem to be binary compatible (from the DRAM 
PoV at the very least).


>   
>   config TARGET_QUARTZ64_RK3566
>   	bool "Pine64 Quartz64"
> @@ -76,7 +77,7 @@ source "board/hardkernel/odroid_m1/Kconfig"
>   source "board/hardkernel/odroid_m1s/Kconfig"
>   source "board/pine64/quartz64_rk3566/Kconfig"
>   source "board/powkiddy/x55/Kconfig"
> -source "board/qnap/ts433_rk3568/Kconfig"
> +source "board/qnap/tsx33_rk356x/Kconfig"
>   source "board/radxa/zero3-rk3566/Kconfig"
>   source "board/xunlong/orangepi-3b-rk3566/Kconfig"
>   
> diff --git a/board/qnap/ts433_rk3568/Kconfig b/board/qnap/tsx33_rk356x/Kconfig
> similarity index 52%
> rename from board/qnap/ts433_rk3568/Kconfig
> rename to board/qnap/tsx33_rk356x/Kconfig
> index c5f9db849f2..2f64b9be062 100644
> --- a/board/qnap/ts433_rk3568/Kconfig
> +++ b/board/qnap/tsx33_rk356x/Kconfig
> @@ -1,12 +1,12 @@
> -if TARGET_QNAP_TS433_RK3568
> +if TARGET_QNAP_TSX33_RK356X
>   
>   config SYS_BOARD
> -	default "ts433_rk3568"
> +	default "tsx33_rk356x"
>   
>   config SYS_VENDOR
>   	default "qnap"
>   
>   config SYS_CONFIG_NAME
> -	default "ts433_rk3568"
> +	default "tsx33_rk356x"
>   
>   endif
> diff --git a/board/qnap/ts433_rk3568/MAINTAINERS b/board/qnap/tsx33_rk356x/MAINTAINERS
> similarity index 68%
> rename from board/qnap/ts433_rk3568/MAINTAINERS
> rename to board/qnap/tsx33_rk356x/MAINTAINERS
> index 02ce7ff383c..b91274c7b43 100644
> --- a/board/qnap/ts433_rk3568/MAINTAINERS
> +++ b/board/qnap/tsx33_rk356x/MAINTAINERS
> @@ -1,8 +1,8 @@
> -QNAP-TS433
> +QNAP-TSX33
>   M:	Heiko Stuebner <heiko@sntech.de>
>   S:	Maintained
> -F:	board/qnap/ts433_rk3568/
> +F:	board/qnap/tsx33_rk356x/
>   F:	doc/board/qnap/
> -F:	include/configs/qnap_ts433.h
> +F:	include/configs/qnap_tsx33.h

Doesn't match SYS_CONFIG_NAME.

>   F:	configs/qnap-ts433-rk3568_defconfig

And you don't rename the defconfig? Odd choice :)

Cheers,
Quentin
