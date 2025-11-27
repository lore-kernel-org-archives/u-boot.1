Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7A3CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 09:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E34CF84332;
	Thu, 27 Nov 2025 10:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="fXfkpQK1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD7468435B; Thu, 27 Nov 2025 10:52:52 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 870C98432D
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 10:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0pg168t8jWzsxmy5uZC/e7jOizXTSnBuz6Xrwq32Ddv5TVWZjY3YkdpVDLTtxNqOTmeiOdDjP/M5g4pjoKxxjV817fHj2CnFTalSIOLQXjYDwHVauzuRRAM/U/4nlO5HX/kCowlu/Y55CmAltfsGgAgBE4tsek+22pp/H0Kn6l3TprEsi6w/Lob0cD673wlMB9TaC2cC4IBnS3vPDAhPoZ8XkBRuVSXzQpXPHj1LCNIHO5EobTzYtEKoef1SwLxwl3RLMY3H+gTqYeItGHN7lZh+KWPLjbq8bAWBvRRAiB76feOoW6b71nwREU+4pn7Xmi9QmKbZ91B06M9VyZVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWnZIoES4gL+4C1d1VI5UWbu5E/WAysqvji36ZKQWYw=;
 b=fP8TUpZTroYoaTnb+ghZHAf5h28mQgVaWYKw7yPAeWrOa+8TqSKGYr38ggl+ZPHTeEYVjo3WlGgmWcpsH7dyruwbRIr4og8TQrSbzWVAn6A1RMOcJPxWxL6OGM1d4DpSGHNQh2xRw5DCuNkmpJvBoyv/UWgwsjktsyGG7SzeN6zRO6P0urMXyICxgOq1WpqcKKvR/s/T4AVHXLEWaTdkq2qSwMTqBoKlV/zVRABofsmbnrAUZCDxcr8vsgPJzD9MSpZSHISK9mhCcQAP5SLTkulsnW9Uosr084H3Fn5i6UTXNZUSH2gjqrV/Y4o+FBZmBlGyQ4eJPXbPKGqh7ZlBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWnZIoES4gL+4C1d1VI5UWbu5E/WAysqvji36ZKQWYw=;
 b=fXfkpQK1DqRdnl2EtWaJtDkBEBcssg6ZT65oxtCWmyd9q4z+xpyYUL4uvwtxsly4GV7yEYYBwfbIrsk2QN3DhS783ork38cVhcIBhYEj/x2aqnu8LOVzRArvmnC/+nwGl+GtrzWuV8qUogfer7NDA5aRd2e6+5050msLoZrU9fg6RY1OBOVNpO8pdbQvxbrRNlpK468LUcjLPrmAQaJLqPSoIgWnYcoZBx26866QBHb3HDEKLOgXa5vUJfcR2tJdsgVtm9OVq3IIQT98rrO/fp61MAyo3MQ/Oxmkls0YQvBZC2jVtsRwfFRrsnQYZ3m8D5pFse8+peuZGCzC9+0lHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BY5PR03MB5032.namprd03.prod.outlook.com (2603:10b6:a03:1eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 27 Nov
 2025 09:52:46 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 09:52:46 +0000
Message-ID: <bdbcf8b7-1a1d-43ae-848e-e4d009b1067b@altera.com>
Date: Thu, 27 Nov 2025 15:22:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] mmc: sdhci-cadence: Add reset control support
To: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "marex@denx.de" <marex@denx.de>,
 "tien.fong.chee@altera.com" <tien.fong.chee@altera.com>,
 "balsundar.ponnusamy@altera.com" <balsundar.ponnusamy@altera.com>
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
 <20251110173737.24545-2-tanmay.kathpalia@altera.com>
 <aRv_hIwxZshKJQI1@nxa18884-linux>
 <3668b44b-9525-4bad-8d24-de10311a4df3@altera.com>
 <aSZjLjm7saoeQYBs@nxa18884-linux.ap.freescale.net>
 <77c022a6-0751-468a-aeb0-9d028ad1fd70@altera.com>
 <PAXPR04MB8459B3E517FE7375521DC49E88DFA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <PAXPR04MB8459B3E517FE7375521DC49E88DFA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::18) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BY5PR03MB5032:EE_
X-MS-Office365-Filtering-Correlation-Id: 491779f1-77ca-4c28-5e4e-08de2d9ab7a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTFMcHdKejZyUVZjbUt0ZjdBYjZWOEFKUU5KUWdyenE1Mzl1dXd4Vkdra29i?=
 =?utf-8?B?SGJlOEpGRERWUEwzeWsxRWptZURnTmtuYVVnVXNBNExTaUQyL3AxVHUyNW1Q?=
 =?utf-8?B?QTVqV3AzQTNGOHZTUUxFb1Y5RW9DVmlYUkszNy9rd0tvUnVQMWhmR0c3Tldy?=
 =?utf-8?B?ZGpienFlbVdxa1Vzd3pIZnF1Z0xkUDl3aU9XOEJ0dzFGVkMvTjd4S1RGaG95?=
 =?utf-8?B?SkVtS2ZMTnBOZmIvcWZkSjJtdWhVWGl1TlB5Z1JRNkllYThnY3gzVFc5N00v?=
 =?utf-8?B?ODZoOGk0cjI1b0g2ZHNEN0gxZ2VyUWhTYXhPV1BDSWJXSExIQndFL05iYVps?=
 =?utf-8?B?R1VoSGdua2ZJSmk0K1B3Ky9id0tPTlRGTEdBc2xwU3l2aXIrd2xEVzNoQVJ3?=
 =?utf-8?B?U3dRMENjY3Uwd1JzS3JHNWdtclJzRWcyb2NpQmtXbGFpKzhIN1VVRXE1VndF?=
 =?utf-8?B?WDB1SFBZK05TV2QzUnFPRzFVUkZ3ZExKZkhUMVNYYlBoYjhaOWlkTW9hN2xT?=
 =?utf-8?B?NHUwWkdxMnVMRDlTKzZiZy9zVDl2aUxzSVhoUkhvVERza2txYnNpVW9XT21a?=
 =?utf-8?B?WVNtSFJvNTlDbkM4aXNjMERqTnZabzhqTDV2RmE2eDdFWEFRSmhUR3dYYjBr?=
 =?utf-8?B?KzJKWUtueVBTVmNVNm9MZWQ1bXlLYlNGL0ZmaDJQVkdwOHpmd2p6QkR3Nit3?=
 =?utf-8?B?TDA4WGZOVFRPRHZOaHhNeU4vYml0VzNPZTZqWDlvZVlkQkwvNlE0Mk9xUWRo?=
 =?utf-8?B?RHZCWGpXS1VWTFViZFVYQjcyOFN2NDJndjNzNWJxQUZoeURzNUpWdENtU2NX?=
 =?utf-8?B?Yk5GMFpoNzAzOHlCd2xvcGljdmV2cm1oUEp4VTRoUnVJM0pvQkVFaTFTdzZT?=
 =?utf-8?B?S2V6TXBxSEdxd3hNcms3S3FJSjF0bnBmZWVQaW90UmRXenlZdC9BK2hyR2tj?=
 =?utf-8?B?bWl6K2NQaFQ3RGMvRVUvdmRxY1hEdXdHS2pPUDBIMDdNN2ZIbEFBeFJ3UEEr?=
 =?utf-8?B?YkJlcnFoaENrMXZ6WVJWdVZNdk03T0ZwR1I0SjV1SldNbmNLN2dmNzJMNElw?=
 =?utf-8?B?aVpVMFRqaHRNOXMvN0poeFRMeUtaMDNUTjNlTlFMQTh0alE4aS96dkxYT2s4?=
 =?utf-8?B?b0R4TUtmTmhoMktFcVlBcVg2bDZKN0luRnRUQUNnVGZHVG84bmV3c0lobDJh?=
 =?utf-8?B?dVBQT2JxR29VYmUydTFkU2FZcGd1Y1ZEbzFDYnpnUTBwb3pFTlBtSzVDNmFK?=
 =?utf-8?B?Y3Rsb1pudWZJQk9tVU1scGs4dVVYVEhIK2xsL0tuSElPTE84OFhLZEtZdDJD?=
 =?utf-8?B?OGMvaG5hWDd0SjJORTIybVMzQ090djdyWjN1aGVZa0thMGVUSnIycFZHWis4?=
 =?utf-8?B?UnpSeHdyMHJRTGlBMEFUL1E2R2NNckRDQlExNHAweW0zZ3hYamFYZjY1WVdV?=
 =?utf-8?B?K3lzbGhLMStkTjB6QVU3SmFUd3lNYzE4R0F4eDZiL3lmQWJvTlZIZHhTVlA5?=
 =?utf-8?B?UlZ1emdyLytoamlsODhvUDg3bUdSTUJ4ajlGNmthT1lUYlRFbnlkZWlRUDk0?=
 =?utf-8?B?ZndMQ3VuNWZEMU9TQUxPVEwwN3E2TjNpdHl0MXYvODIzZGZrMTIyRUJOZnNl?=
 =?utf-8?B?Ti9YNmhIUW9kYjZTZXhnSVFKM0NHL29hUms5RndTUFdiRG5NT1FNS3A5N0Ir?=
 =?utf-8?B?bko0SlUrd0J6UW5kOWRoUnJRb3dkMjYwMjgxVnJyRGFQS3lLcmVHSW5kSDI2?=
 =?utf-8?B?RWYzQTBlc0pQZFlCbjkyVC84aUoyMXdZR003NUJmaEloWGgwTmVlaUNpTE00?=
 =?utf-8?B?bEZsMERlR2hEY1o5clVpa2ZLalJRV1lUN1dRbFRLSGpPUVZmUGtGVXVCL0VO?=
 =?utf-8?B?S2kwdE9YNk9OQnJvY09zZllWd2dRNzUyUStlRll3bXJUQkl5alpSbVd0SEh2?=
 =?utf-8?Q?HUa1Z/wUJfG25H/fOxuk51DH/GGsbtHx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXNrZWkvT2dSMFRrdXJnaXlKZ0N1bGlmazVZa2x5YW1vcDFDOVFRWFpHUVpR?=
 =?utf-8?B?YzlGQnUrL0JFWUtuRm5MK1hRby9PTkNqbW9kR3NnM2RJVFhIbUMwNndHZEov?=
 =?utf-8?B?T0w5dGFObDBZNGR5OEtXZExuZkt0NkJSMTYzS3N0enM4SkdwWnNIbHlJOHlO?=
 =?utf-8?B?YS8yYXhiOVcwOWxZa3VHTmlkWGxhYVY5NXJVTnE1R25EaDFpclA2MXNBd1R1?=
 =?utf-8?B?c1dOM0tRMVNyODNweVo4K01sdHIyNGFvU1lsMFluVklFMGpYeW00cFphU3Vk?=
 =?utf-8?B?K1RRTy82OGxKcVRWd1ZRMG9LekNFNk43cDErK1lzblB4UWZsV3F5L2VZSTZj?=
 =?utf-8?B?UWx4bEtlcHJDRUVlenErOWg1U0ZFOThVMnhtMmhEa0dQZEtmQkM5bjB5M25W?=
 =?utf-8?B?TmJTRnVNSnN3RUIrZWRtbzNETExkT3g5cGpPOHh6bjBUWXBKemNmaW85K3F3?=
 =?utf-8?B?OVJNRCtVeUFvWFYrVlNvaEM1djZiSnJxV3Vnc2xmby9qdnBFbkZzdUdDSEE3?=
 =?utf-8?B?UmxrWnhVbGxPSWNySnF6aEd3ZkRaN1NJNXg0RDcwV1cybU9Yb3dnM1hEbVZt?=
 =?utf-8?B?OUo5QUNsSFFBalBNcHBmeG1EUnN3RXROeUNOQ3orZDJkZ1hLTmdEalQrd3ds?=
 =?utf-8?B?Z1pzY3FOZWtEM3dEUngyaU9ISHZNaWN2WXZSVXJWRzdNZlJMTlJQdWpHbkh6?=
 =?utf-8?B?aktyQ0lBWFNIUUFLZTF2aFMvbUJkTTFNc3lELzJyVUFyaEwxY09VWk85c1NF?=
 =?utf-8?B?RWZ1Ung1bTQxbE1HTnFwaHYwNzI4bkV4ZnIwNEdIdlpDTzAxZHpZWXJmMFll?=
 =?utf-8?B?Ni9WeFJwWDJDZlZ3ZlovNm5TR0NGQmpXTnArUTkyV2I1OEJDWHVmK2hsTlUw?=
 =?utf-8?B?cjdnUHJkRXZEbUZ2b0FsNkdJamo0Rm14VDh5K0hKOE9BTDM0d1lsb3NRamg4?=
 =?utf-8?B?V0x6T205Z0FqTWFLZC90T3pSOVBiMUdVUjZKaU5kRXRKOUlFNTF2Qm1ZWHlK?=
 =?utf-8?B?QmtxYTBXTGVoUjNEazd1dmFOTTRod0tYMkZXOXY4Y0NyS0l0cWYwY09GallK?=
 =?utf-8?B?WThYcjluQWc1R01NMTNqTXpod3lFRlJTYWlaNFJoQWMvTHZtUGNFYWtIUmty?=
 =?utf-8?B?aHdkRnkxNXAyRDV6OUxqQWI2azB0ek5MR040dHVCVENybnM1WFBzNTlORllE?=
 =?utf-8?B?N3ZRQkVaYzRHZkhabDdyREI3SVF1dnk1dW9SM3YzMlBwV3pKTGZqYUhubEs4?=
 =?utf-8?B?Um5BbkNxNG9TK0hERW11MjdhOG9hcHdzalZKRG53SFRlbVdoTVVwVnp5c0ZN?=
 =?utf-8?B?amdxUkFScy91WjF2NG9GRCs0b3dLbE4vc0JDM2dOcjlPT0hHdmdzREcvR3Y1?=
 =?utf-8?B?WXpSUHV2Y254cm5OL1NFbVJuVkM5ZVNWSXYxNzQyM2d2eTl5c1VDbm1CRjNk?=
 =?utf-8?B?dVhmQlVrclFOUU13dHNnNWdrTjZ3VVVKWHdseXA1bEk4eW1jODZEZFl0cFNC?=
 =?utf-8?B?S2p1aTUvTDduRHVKSVBiZ1NnMkxhOEdTZEpESThjaWN1c0NMU3N0OEdONXVD?=
 =?utf-8?B?ZTJvS2dDMDErRDB3bTIxdmNpeXVkQzFsUFVoQitoMkpYSHZNcUhJNm5oT29v?=
 =?utf-8?B?MEhiUUVTYXhJYnVCQkNVaHlTam13YWZkaXVManZmaFFhUHdQNjVnNUUvU3Ba?=
 =?utf-8?B?QnRJczdkSmNUOXFkK0NGWVc4UHNEamNYcmVMYWEzWFJCSzFCaW55K0g2OGpy?=
 =?utf-8?B?b25nTjZGMzFFN3JPaFpyK2ZaZi9FQlRramwvMS93NWdGVHZqcUdTQ042NVNM?=
 =?utf-8?B?b3dNVGlYL2RzbmhDSEJYUkI1SVBZUHhCbi9JcVZlekw1L3NObHd2S1BNbDN3?=
 =?utf-8?B?QUoyMFVoRXRmMEg1czl1US8zL0xtb29VdmtTSkNrNUY1VVVIeG1yNFVpUkY1?=
 =?utf-8?B?L1h4UzhiejEzWk1tT0oycThPOHlEdER1K0VKYmZ5N1MzZS91VnVxTEtQUWNI?=
 =?utf-8?B?Y3p4YzFCM1RySnZaUThvMWVIbVl0YnlQV0N3TWJCN1VRL1ZOdFhWUE9ySVF0?=
 =?utf-8?B?NkVDMUdmU3dTbzErajhIS2NwL1FnSzRYbWppbENlam1Fa0UzK1dvUDBaVGw2?=
 =?utf-8?B?eEg1QzR5YjVuNlQyQ1UwbndRSnhyNnN0NFF2Tm0vWlJKZDlFbmRSMmx0RThs?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491779f1-77ca-4c28-5e4e-08de2d9ab7a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 09:52:46.5847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5F3KZ3W6m/Tt+LwPoG2hCGkWTTIgcJATCMhgLv7kn6FtuLuPCUYsqFHHdYpi6LMFANvyL1Dfgm+WuPIROGtUBI3uYGCQOpRwW4lnX64Oik0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5032
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



On 11/27/2025 3:18 PM, Peng Fan wrote:
>> Subject: Re: [PATCH 1/8] mmc: sdhci-cadence: Add reset control
>> support
>>
>> Thanks for the suggestion, Peng.
>>
>> On 11/26/2025 7:47 AM, Peng Fan wrote:
>>> On Thu, Nov 20, 2025 at 08:29:11PM +0530, Tanmay Kathpalia
>> wrote:
>>>> Thanks for your comment, Peng.
>>>>
>>>> On 11/18/2025 10:39 AM, Peng Fan wrote:
>>>>> On Mon, Nov 10, 2025 at 09:37:30AM -0800, Tanmay Kathpalia
>> wrote:
>>>>>> Add reset control functionality to the SDHCI Cadence driver to
>>>>>> properly handle hardware reset sequences during probe. This
>> ensures
>>>>>> the controller is in a known state before initialization.
>>>>>>
>>>>>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>>>>> Reviewed-by: Balsundar Ponnusamy
>> <balsundar.ponnusamy@altera.com>
>>>>>> ---
>>>>>> drivers/mmc/sdhci-cadence.c | 8 ++++++++
>>>>>> 1 file changed, 8 insertions(+)
>>>>>>
>>>>> ....
>>>>>>
>>>>>> @@ -225,6 +227,12 @@ static int sdhci_cdns_probe(struct
>> udevice *dev)
>>>>>> 	if (!plat->hrs_addr)
>>>>>> 		return -ENOMEM;
>>>>>>
>>>>>> +	ret = reset_get_bulk(dev, &reset_bulk);
>>>>>
>>>>> Should this be optional? Some in tree platforms may not have the
>>>>> reset supported.
>>>>>
>>>>
>>>> Yes, you're right-some in-tree platforms may not have reset support.
>>>> In those cases, the code will print a warning message ("Can't get
>>>> reset") and continue the probe process.
>>>> If you prefer, I can remove the warning and let the function fail
>>>> silently instead, or is there any other way you would suggest to
>> make this optional?
>>>
>>> devm_reset_bulk_get_optional() may help.
>>>
>>> Regards
>>> Peng
>>>
>>
>> I looked into devm_reset_bulk_get_optional(), and I see that it
>> dynamically allocates the struct reset_ctl_bulk and adds it to the
>> device resources list if CONFIG_DEVRES is enabled. However, if
>> CONFIG_DEVRES is not enabled, we need to manually free the memory
>> using
>> reset_release_bulk() in the driver's remove function. This means we
>> would need to store a pointer to struct reset_ctl_bulk in the driver's
>> private data, which would require additional changes to the sdhci-
>> cadence driver (since it currently uses the generic struct sdhci_host
>> with .priv_auto = sizeof(struct sdhci_host)).
>>
>> Let me know if you’re okay with this approach, as it would require
>> other changes in the driver, or if you have any further
>> recommendations.
>> Alternatively, I can simplify the implementation as shown below:
>>
>> ret = reset_get_bulk(dev, &reset_bulk);
>> if (!ret)
>> 	reset_deassert_bulk(&reset_bulk);
> 
> For better, an optional API is preferred, since non-devres API
> is not there, I am fine with your above changes.
> 
> Regards
> Peng.
> 

I will make the changes and push the V2 series.

Regards,
Tanmay

>>
>> Please let me know your preference.
>>
>> Regards,
>> Tanmay
>>
>>>>
>>>>> Regards
>>>>> Peng
>>>>
>>>>
> 

