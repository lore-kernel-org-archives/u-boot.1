Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C647FC02197
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 16:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E9C0801BE;
	Wed,  5 Feb 2025 17:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="LT0P02yU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79EE580104; Wed,  5 Feb 2025 17:04:21 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5677280104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 17:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9F4APJWgUarjAO84YYytarEUk1CWHT4QzK4zZzZbIR3Lb7pLsHorCMOkolZMdxEyiwLW3MLRLzPeMhmLqu4ZWt780S3LG9zCG5NiR7KzlNwl2mCaKWpjn4+Og1g+VsU7dp7zAyagKmpwSEOc6hXU68FEaDP0mnqs52wyMecaTDaSgaUPmRkq5TkD4MQgTWkp/7r80F+1VqJycUnEqWwUv9d2sJbHSj0nepGq2aXD8HvMK46uj21QHZsQ8ehgSp+Ti7NIvLnZ3p5r4taxwfb3dF3bTjZAjyKZCkNlIs5JiQXwUDbVs764y9gZLykFAGXQIz7mctEce+V+tdWR5OTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jn0+mHqGYM/YsQJLgD5D7nmOjTabYIQi7uDec2+M9lM=;
 b=vwh52pSJuw0jKt5NrBuMC+ebZcCynsXjyGe5aAGo9A/U21JBRxiMVG0lWLgKxXhwEUyUuR4JaQ0LLWazzZz11Fqf1Ad7PwP+EvTpPMy3lAEDeonVXYC9mCQJewjG9q9YrB598y8fpYms7SMYzfc11UYfkh7kJSjzAo3WfvVj9NYtRWIw1gSumqdoKpoA/iAJuaWAFxUiROGwUetlxrswodKD2w2H5XDMP+G2rt7Q0d6IfKwrucA/Pgv7QrA6tp9kQe1Ug1PZp/JPviju41bwRKxe6ju67h8ZMTKM4HNdiyoMqJvTFU8ZrUWgttbRRYmkXYzcwmvsfcc7GV+cthr0gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn0+mHqGYM/YsQJLgD5D7nmOjTabYIQi7uDec2+M9lM=;
 b=LT0P02yUil1TD7UM6sDkSGc+CJxmomKHS1298z42ng3qOZEe5RLnpI/4keIreUYXJ2FfuF6hZpUVm5ORg0gsI8nfeIwb90Hk8xlFu4vjRil7AMOpr/TATG9jxIAYkgeISTiRPdkNccLjZjySVSQZd25YPN7IVIBsSaOwa3R89/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA2PR04MB10258.eurprd04.prod.outlook.com (2603:10a6:102:404::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 16:04:17 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 16:04:17 +0000
Message-ID: <d50be23f-ef3e-46f6-8862-32bc18903bb2@cherry.de>
Date: Wed, 5 Feb 2025 17:04:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] rockchip: mkimage: Print boot0 and boot1 parameters
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250129223641.1888833-1-jonas@kwiboo.se>
 <20250129223641.1888833-4-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250129223641.1888833-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0171.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::28) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA2PR04MB10258:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a091ea-9980-4971-0d47-08dd45febe4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TU56ZCtmNGpQVm1tNnRoK3JINXI2SFdNRVYzb3YzbmRTSFFmc29Id21wTFlV?=
 =?utf-8?B?bTBGVG03dGJCZHA4Sk03OXNLZjJJRjIzWjJ1QlptdXFoVGh1ais0SDd5aEdB?=
 =?utf-8?B?enNJc1A3MUdGcDIvV3NCWHVaamNhdVJmK015UjM2L0xQY3VySFBiK2pvckJT?=
 =?utf-8?B?Ull2cHdiZkFTak9FdnBhTXhBa1Yvei9VaWk0U2Jjc282RUh6Z090YllFMkNI?=
 =?utf-8?B?Z0lHWXhiUklyWHpPSmFhRzNyc21UU2xWaVNsRlUxaXJzekI1dGRZOWF5NnVH?=
 =?utf-8?B?UzljWTFSc0JnWTNGRlNZdHFHVUVCdUFxTWNzcHM5SFBJVm5aK2xoR1g2MTg4?=
 =?utf-8?B?a3E4NCtkcm4zK0JjczMrNXRubC9NMUszUGNVNEl4VCtldmxCU1FKMiswTFEw?=
 =?utf-8?B?dnZrNTJURyt2SVBpc2lDT2l5QjlIRGEvazBPK2RzMW41SXJJZ2dXR3VmUkIx?=
 =?utf-8?B?MU16ejVndzBYRjU2SjlFOWE3MFMrc3E2eVQ3VjRpK202akhnS0hnNGdJWFB0?=
 =?utf-8?B?KzhxSm9uVEpDZFZZWGVzdm55RGsxVzJFRkhEQTlwaWtTOTM4a3ZtNkx0Q01t?=
 =?utf-8?B?K3gxWFJvYlQ3WFN4SnZDYkNGZllRU2EvZkFJbFlhNVNaTm12S0JFdCt0d2xL?=
 =?utf-8?B?UWRBR0dVMVMyTzE1dnVHMXJELzRGNE1UV1h1SGtvOVV0WjJwYmFmbmhpa092?=
 =?utf-8?B?K2ZoRTNXTlI3Y01QbXdkRENKbEJ3S29PMU12YlVibExUNXRYMWRaRFovUGhI?=
 =?utf-8?B?Y1JLcnpZc3Znb0Yxd2xtVWd0VTNPMko1U0V6MEw1TTY5QTRTUmhFZXdYY1hw?=
 =?utf-8?B?b2I4bVkycVRiK2JzMzdQUkNJcGZsOW9BT096Y1M2R054YndXc2laMllrYWtt?=
 =?utf-8?B?RTRBbUViMzBlY2hQYzR4cDl6ei81RGt3d1JLZlloQ2dlYjZyYTdCZERjdmE3?=
 =?utf-8?B?c3RtMXYyWThFZHV5N2R5MnhKY3AvTEp3TXNDOXRJTU1NN1hRQnloZzVWMmRt?=
 =?utf-8?B?V2pTT09xSU4wS2pueStydUMzelBTVG5pQXUvUThXMm1RZ1J2SERYWWR1d3Aw?=
 =?utf-8?B?KzBPYkpTZExJbWtrZmtxbUJMQ1FDU2pGaFNvMm9qY3RFZy9OVGFNbVlmWXBn?=
 =?utf-8?B?b21MMGMrdkNEZ1lMWVZROTNJZFVlM3hXZjZrUG01OS81cFZaOEttU244eTZ3?=
 =?utf-8?B?Tytld29RQ1NFTnRGcHJGNEZXdEpaWVhtdFpNS1RaNURqQm9mcjhwTEY3REJ1?=
 =?utf-8?B?eWZPQzdmR1R3MHpUTmZlMkVZV04yZE9mT0pmVFd2dkJTbUhqdXJJOS8wSDBC?=
 =?utf-8?B?K3lvTnlFLzlhc0dqR3lndmJlazliSlhscEY1VXA0Sndac3NIT1RkU2JCYTRx?=
 =?utf-8?B?VVhkYTZXZ3VHbnpqWktsa2JJQXNPaVBEdWk5b3UyRGF6UURHUG9Jdm5vWmtK?=
 =?utf-8?B?L0tSbGVTbDNHNFNYSXdpVHFqWDFMQ3dZR3pSUG5XLzNmTExBZWFvT252dEVv?=
 =?utf-8?B?c0dvZHdsUGRkaEd0czU2MkY4dGI4UTducHJiVkcwakFaUkRFRWw3dktQcG1a?=
 =?utf-8?B?K3JYZnZIbVRGTmlRS3JEOUtiODE4bEhwV05sVVY3QUZhb3JLNUljdzd0bWhJ?=
 =?utf-8?B?RUl3MjBGR2I2N2dKb0xJWnoyaEZGN0xyRHNQSnlSYnNMUVdJNkdOeG5wN2Np?=
 =?utf-8?B?SnBOQW1TRldUVzViOEhUREVQNWRHZ2FMejJLSXZFN20yMkNRZ041MERxVDFr?=
 =?utf-8?B?TXVjU1JJbWJENW1BLzIxTUJaT2Y4K1IxdHY3TEpOZGlHSlIvYVJjWmlDWUNq?=
 =?utf-8?B?SVVKamVZcVgzbVgxTXFTNzF1THI5UlpiWTVOeFo0ckYzSDFoN05hRHZXSXM3?=
 =?utf-8?Q?qE2jLiK2wuDKi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWZmU2dOTVNvV1o4b01vZERtaVZtL0V5U1lpM2s3V3p5dnZoU1VXYlJBNTRl?=
 =?utf-8?B?TDdHb2tDQW9KbHBYT1dOK1Jkd05MSE5WTlBGSmF4MUJEaHVwUWRDL3NpTGVJ?=
 =?utf-8?B?eXFlN3F3UnM4d0oyb1l2S1pJQ0ZLeVNpMllPYVdjelV1V1pTekp2eG4zQ3dx?=
 =?utf-8?B?ZFcxMDZSUUpocFRtQ2Z4TjZvUmlwb0haOWFjeXFpdzZEQktSR0VoaG03bU9N?=
 =?utf-8?B?a2RUYkJiL3dOWXZITXVDNE8vdE5CQTF1S3NncEVFOU56YXpjUFY1Y1hDOW4r?=
 =?utf-8?B?U1BJV2c1b3BQTHJsZXE1RjJGcG5Ybko1MjBxeU5jV211N282aDZwcEJ4Z004?=
 =?utf-8?B?UU43dk4rS2dCQVJaV3pVd1pHYm9xTGhJajZFL1Y5eU5zSzZ2MmFSdVptYjBn?=
 =?utf-8?B?UmVQV1JrSGZaNjUxdWMyZmorUHpwbGVoR1RRWklTQS9TdkRJekVDWE9vUHpj?=
 =?utf-8?B?WWpFaWZ1cys4bDBLRlRjYm5UdnVNZkpaNHRxcng3b3M2RC93TURaa1pJK2Fr?=
 =?utf-8?B?TG9uaEdLQnJ6bll6L0EzVTh4a1hvTUNteHFLY1lvWW5TenRhU2pNS2xiNFpa?=
 =?utf-8?B?ZWhXRXk5WVBqSFcyaVFmQXMrSElTMndEUy9HdUJvK0M1WnF4aEpnVW9hM2J4?=
 =?utf-8?B?ckNqSGI1SzRHWDE1angyZGZsWDZpYXR2aC93VXBwS2Q4cjFIaDVSb29CZnlJ?=
 =?utf-8?B?TjgrRVRaWkN2eEJBcm5TeFliVDJiZjhBL0xuMk5NZzN2KzZqeGNaakQwaVhV?=
 =?utf-8?B?SHdSM3pyVnVtR2RNYXVWNVpMNlQwbTRQQjRRWnROalBjZ0d2TldtM2kvdVB6?=
 =?utf-8?B?bTZNWFdFUmFqSW5VQkpCWnhLVytaOUZFOGhsRzZVdkdCZzZ2b3p4bzZlR2RJ?=
 =?utf-8?B?bFFTK1JOWmZIZk1vOWlWcWptcllMVnI1Yjhma1kyVkhSQlpBaW55OThmc2VX?=
 =?utf-8?B?YzFvdUVJL1Z4cWRoeE9FT0cvM1ZhMW9VNHYwQ3djTUpFeGc3RmtSWnQ5ME4z?=
 =?utf-8?B?eE0wZnRMcWZIdUl4UlIxRUowS1Q4MXRnVnBTSld2RUUvWnNHMFdtbUVYZHhk?=
 =?utf-8?B?c09FUHA3L016eXQ4YTFwcHVoYldmd3NaMS9SSWsyRkkrOWtRV2cwZ1BPbzAv?=
 =?utf-8?B?TFVIem5SUU05MjVSZld4bmNFTGplbnc5N2RlS1MvUEVxMXJlMStYcHlVMEtm?=
 =?utf-8?B?dnY3cTRORWtSVkcwWjhwbjJJSGVBZ2lrUkhPY0NvRUVUN2QvYzlnWG9EMmQ2?=
 =?utf-8?B?VHpvOUtRV2lFU2lIVExIMnMxVzRCOHFYMkNHNHZXdmRUZzRVSUpKNklWd0p1?=
 =?utf-8?B?MkxZU25Zb0J5Q2lyZC91cmczVkpBbWQybjdVbitOZkw4cVdYNmxYdm9OWGdP?=
 =?utf-8?B?VnlxNTVwVzdhdjI4ZGtwS1hrVWJFSHpLUWJwR1FmaitwdDMwSnlJNnZ6T09H?=
 =?utf-8?B?WHZ2QkdzRncxTGwzVTZvVTdHSkErNHV1a21saGtSZTRxdGdMWU9KRkxycXNw?=
 =?utf-8?B?VzVNNXFMR3I4OSs4bmpHeWdOWW1GU29Gdkd5akh3NjlKblY4eEl1WnhWVlJI?=
 =?utf-8?B?blBabXQvdDBUZEltaXNVcjNoL0laTDBpVnQ0ZHVqMFB6cHFIdHZzLzUwNVg2?=
 =?utf-8?B?MjRDeXhVNDN4RkZIR3I5eXNieG9kUWtzaEZyWGRCRyt6YlJ4aWVYREdSejI4?=
 =?utf-8?B?WFR2YXNYanZBQnNlc0I4R1p1S3hmS3dNeGRIR1VMaldxYXgwUjhpczR2NHRW?=
 =?utf-8?B?dGd6cnB5NmFUQmx0bjNnNEJyNy9uVCtIWjFmdHdWc2p3WjlMdzVRM0U1a0w0?=
 =?utf-8?B?dG40QmhvbHN5UUUyMkZDZDVUQ2Nsd2xncnBNVzFpU0l3NWRDc0hLd2dzQjJh?=
 =?utf-8?B?b0djOUdnSzFtSERmWDYzdFNhU3lkdTJtenhpaGN1L1VKdmFRWms0QjNkalhi?=
 =?utf-8?B?VHN3NkI0RTVQRTdWY3gvOTFBZmFyNUh4Z3pTMktnMnNNWWNrS3VPdE1mTFZm?=
 =?utf-8?B?VFhLSWRUZW1NQ1BCUk5kcEViSEcrays4QzZvYVN5a2JwTVJRR1VYTlVXK3pY?=
 =?utf-8?B?R2p6Ulduc2lsN1dyMTk1Z055Z1IzdVFDSU56bFhDMjVNQXBzdFlEc2c5cFJZ?=
 =?utf-8?B?ZDl4ZjJoUEttNDJDbTl4azc0Rm5hZWdLU0dkUjlNRVFRU2ZEMjhpb2VvbGxM?=
 =?utf-8?Q?hnJ+eytXhXD5/nT7BTnVgLM=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a091ea-9980-4971-0d47-08dd45febe4d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 16:04:17.4585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ion6sLgdaTjdlDIT7FVAyxad5Jkc6rpNyUEmaYs5e3Chf9n2CIHkQ3MXoI7LIMZd6ObOEJw/flTnjmRtSYvNlTxel/HEeHQ58zpRx15e3Rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10258
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

Hi Jonas,

On 1/29/25 11:36 PM, Jonas Karlman wrote:
> The v2 image format embeds boot0 and boot1 parameters, the vendor tool
> boot_merger may write these parameters based on the rkboot miniall.ini
> files.
> 
> E.g. a RK3576 boot image may contain a boot1 parameter that signals
> BootROM or vendor blobs to use 1 GHz instead of the regular 24 MHz rate
> for the high precision timer.
> 
> Add support for printing boot0 and boot1 parameters, e.g.:
> 
>    > tools/mkimage -l rk3576_idblock_v1.09.107.img
>    Rockchip Boot Image (v2)
>    Boot1 2: 0x100
>    Image 1: 4096 @ 0x1000
>    - Load address: 0x3ffc0000
>    Image 2: 77824 @ 0x2000
>    - Load address: 0x3ff81000
>    Image 3: 262144 @ 0x15000
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   tools/rkcommon.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> index ad239917d2bd..324820717663 100644
> --- a/tools/rkcommon.c
> +++ b/tools/rkcommon.c
> @@ -62,6 +62,8 @@ struct image_entry {
>    * @boot_flag:	[3:0] hash type (0:none, 1:sha256, 2:sha512)
>    * @images:	images
>    * @hash:	hash or signature for header info
> + *
> + * Other fields are not used by U-Boot
>    */
>   struct header0_info_v2 {
>   	uint32_t magic;
> @@ -69,7 +71,9 @@ struct header0_info_v2 {
>   	uint16_t size;
>   	uint16_t num_images;
>   	uint32_t boot_flag;
> -	uint8_t reserved1[104];
> +	uint8_t reserved1[32];
> +	uint32_t boot0_param[10];
> +	uint32_t boot1_param[8];
>   	struct image_entry images[4];
>   	uint8_t reserved2[1064];
>   	uint8_t hash[512];
> @@ -491,6 +495,18 @@ static void rkcommon_print_header_v2(const struct header0_info_v2 *hdr)
>   
>   	printf("Rockchip Boot Image (v2)\n");
>   
> +	for (i = 0; i < ARRAY_SIZE(hdr->boot0_param); i++) {
> +		val = le32_to_cpu(hdr->boot0_param[i]);
> +		if (val)
> +			printf("Boot0 %d: 0x%x\n", i, val);
> +	}
> +

This seems to indicate that there are 10 4B params for boot0, is that 
correct? If that's the case I would at least add "param" before %d, the 
output looked odd to me at first glance.

If they aren't guaranteed to be individual 4B params, what about just 
printing the whole boot0_param in hex format?

> +	for (i = 0; i < ARRAY_SIZE(hdr->boot1_param); i++) {
> +		val = le32_to_cpu(hdr->boot1_param[i]);
> +		if (val)
> +			printf("Boot1 %d: 0x%x\n", i, val);
> +	}
> +

Same remark as for boot0 params instead with 8 4B params for boot1.

Cheers,
Quentin
