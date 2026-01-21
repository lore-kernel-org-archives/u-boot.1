Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F696C44501
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 11:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCF9B83946;
	Wed, 21 Jan 2026 12:16:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Wh6cOpUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 005CD8397D; Wed, 21 Jan 2026 12:16:56 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82CAD8341A
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 12:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yY+3EFKJB6B8QDJaEiV6YPKWiMbb3M4xLE+GuPwuOfOq13baSlH6V/FO97D88qg63MmwXBu+B8TcruVuvGn+g3o1xLCgHXiqV0mKqySjV2oHqhk12PaNOV+rRkYleC7czye+jvhDzw5lFATTlRfzfM7rxsTvuMhL3Xgn1xVjVZ9oLz3EooTXoLYpaEIGD2peg0kah0Xkg8VNyXSBefCEuGJvhl1ScgddnNDR5H4gdfHJLuKjCC/hjRb2dDQ6n/dxESGI+NiZ2bOdPeG0W4j/6risioBJVrVWpmCNEoxbrJlwPZZos4YFCpyUTH7REWdJHxdbSbcf+NVsucCACYF5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4xjVDBWKlGmDLVFiS+bGFmZghc2+mGCQ24YgSHtlqg=;
 b=zAkI/n8andFxb7BgbcuheB5ejQ5PlK8g5tKIqUKjyiu6omWHs9oyDmOjeQRmISd225wbMZ24vfjU2/9dUc6/HLgnaxLk9LBMumE2jb1zLeFZQOrLxBSLz4jcdAbGLCc0hZ4kCcpL1ulPTCt+Syw4sXLs+KZGVLPnI8ClMg1Ob3Qul0CRUQszTIsHBDZii1aVETNU2aIYJ4XFfDQT5wGb8Jvt5TV0VfY7KzlrxSQOMrwQCpYu86k3QHW4J54ctTNRVcbFp+t+pWRAhVFB0PPvkJMKyd8/LoO1G6rhDxhCzzyKN2Hb9e0RN+5cgzZ2uzpXzNve8IvMlff1ynMJ757BWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4xjVDBWKlGmDLVFiS+bGFmZghc2+mGCQ24YgSHtlqg=;
 b=Wh6cOpUZxVyEWL4p8R00YmBitPUq7JLFh8q7ffbM8huA8HuSDxhnZs764v+TECu6jBw7BhwFQL/7ndR/lo71/B0gVHdT1LZKsI9fFAUg0Lh2u1aKEN5aD0ScHjhJhvbIdwADJH0m4KUvonkQ6FPsCOyX4HYubAAfoQ//pFbQHRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB10999.eurprd04.prod.outlook.com (2603:10a6:800:266::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 11:16:48 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 11:16:48 +0000
Message-ID: <1d8efe1e-91d1-4ae4-a680-3e4200042fd9@cherry.de>
Date: Wed, 21 Jan 2026 12:16:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] doc: develop: process: Document using b4 and
 patchwork for custodians
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260120223405.469050-1-trini@konsulko.com>
 <20260120223405.469050-6-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260120223405.469050-6-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::12) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB10999:EE_
X-MS-Office365-Filtering-Correlation-Id: 020a566e-f913-433f-2e31-08de58de91a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|13003099007|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0RGMXphQjVqZ2J2ZHVkWld5QWVXQVVDZjUzeFJ1TnFJdnNDMmN2cTFLSW9S?=
 =?utf-8?B?M2JXZmUwWW0zTWUyZUFkNVJybmU5SlM2QzZFVkNESVZ1aml4UGlBaWVEQ2N4?=
 =?utf-8?B?U2E4Vk81M2FqSHpOTkxqMGEzZ1RlSmpZVWF2MFBsNmVZL3RzS3dGSHRVZnpt?=
 =?utf-8?B?ZWFybXpKZXhlZVFMa013WUJnRVdHMkJtbCs4ZWRhby93OWZwdHlsR21aT2Yz?=
 =?utf-8?B?UGNiSDJYWS81aFVkd3FkZWY5R3hBa0ZtRW9lekhla1M1WFowTXlkSllKTHJl?=
 =?utf-8?B?cEE0dnQ1b2g5NTNDaHFrVmFOZ2kzZW42RVZoMnJEcms4WFZOamEvRjB4NGd1?=
 =?utf-8?B?Ympkb250d2UzcEZSbGFNNCszbVVtTGpUczUxdml2YlV0NXJ6eEptZm13a2d0?=
 =?utf-8?B?MENkcnE0SXJyUUpyYUpnL2lUa2pwMGxMN1EvSUZEZVZ3SDQ3SCtiSXdFTGFH?=
 =?utf-8?B?MkIvOWhRUUE4cFNYdVdJRW96RTV1OTRwZ3FPcCsxOGJXOEwrWDREOTE0MWJJ?=
 =?utf-8?B?enpydzRPVEs1ZHBXOHlWZjBEeFNSN1Avd3dpQmtDY1hQL05jRjk4OE1CWW4x?=
 =?utf-8?B?MFl4VVhlSlNKenhGeXpnejBTNXB4bWd4SFlKZk5vRFlncldSYTZveGtobVo4?=
 =?utf-8?B?SnNiZW1VZCtWQ3JDbkFBK2ZaOWNIM0dYZVE5VDdBQVovK1dDVzdMellBaHNE?=
 =?utf-8?B?WEJlM3pMMWx0UHcrQ0xtV1I5Ky9TVE1qZ3RiWFlDMkZrNysxenFidHR0eE1s?=
 =?utf-8?B?dGYySUN4VnFweW5hcHZFY28rTjBmVy9mYzMxdEFHVmV0WWJ6aDkxOE10T2Fz?=
 =?utf-8?B?L3JOS2IrUmcwT0dwVEt2NFhMdUtxRU5XZlg3Z3hxenNvT1ZpZGV6V3ZzdVZi?=
 =?utf-8?B?NEE4TG9MQUhvaXF2KzU2TnNIM0ltQzYwT1ZkRlpwQytRZk1iakhYdkVGRVFE?=
 =?utf-8?B?NEhsbmVtVjc4OXk5N2JmZUQ0UzVGNE9DbGx1Z0Q2R3ZoMzB3UGI1dU53Vm5S?=
 =?utf-8?B?bXZUd1QreU50SHZzL1M1TU12VWVHaDcwcGU2bEovSE42LzhWY1ZyNi93Wksx?=
 =?utf-8?B?eDRRektTRmE1bVdYSVhDemM3QlZHMThzYUUydHhlY2I1ZTV2SW1OanlWd3ln?=
 =?utf-8?B?NmZVNTlVR2ozNGp3V3VxVlRvOWM0VWdHdU1lRWNDdWZaWWZDY2JrUWVwUmdx?=
 =?utf-8?B?NEVrdTBZYUlwMGkzNTZLZHo5aXNxTCtDYlF2b2gxUDlwV1poa0FQSjBybXBk?=
 =?utf-8?B?aEMyL3c0RFBwMVNWMmNYaUlKZE0wUHFaSnJEWGs3ZVhyUjRYQS9lQlo4UWNJ?=
 =?utf-8?B?WjNrZVhRcUhNRTVJQy9CaFdwcEU0TnhuVzZ5OXRHNm9zMFBONEd4Z3dpTW9H?=
 =?utf-8?B?VDE4VWxIams2eVVxMkJOQUVQcjZyYVN4SzZ2OFdlczlsczFuZzVEbldWbFNG?=
 =?utf-8?B?V1FkZWg4TGljNXFJRWV1ek15ODZUblJidEplQlVVN0xSbFozYXBuZGw5YjM5?=
 =?utf-8?B?ZGEyWTE0czlvVTdSMDdjamZ6Qy9vQ3FLcjAxSndLaUFTYlVCZlpiZ0hjV3gv?=
 =?utf-8?B?b1BNSXZGTWRDc3RtM3VQVnUrR3dFQnFxeWNScGlyZTE3ZDBHbzRPdnlNWGRD?=
 =?utf-8?B?VEFlWFhuMXFTSkxFcktjYlE0aEV1UDdUNXF3KzZMVVRrbldoNEQzc3ExNmxM?=
 =?utf-8?B?ZHYzMi84cnZmZXNocmdTL2FybzAzd1A0c3pySTZtYkVBNWpRUUNhbHNLTEZo?=
 =?utf-8?B?dEkrcGZqRGNCVjUvazFzc0Z0WVJ4OVdVL1RJRDNZUDQrbTcwTG9MZGxWM1Nx?=
 =?utf-8?B?djhaU3NEbFB2N24raWNabHpEZ2JmVTRDS3VvMmdRV2hGc0l1aDMvQmw5OWVx?=
 =?utf-8?B?ZHFFUWdjY05WTEVCc1BDek1CT0hyTUxkdEsyWFlkQ3RwVjRvL2x1MUhqL2lM?=
 =?utf-8?B?clRaMUVOcjNQck5FL2dqQ1RwYUhSdGM0bHFsclNERU5yVWJSbzBEa3NLOFhE?=
 =?utf-8?B?Nnh4QzM1QUVaQ2QxMEpwcDZOUWJyTDVZUURqVDIzemtwYjgxV2dVYllhcUNF?=
 =?utf-8?Q?agLlZT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RklSQm5FNm1XM3dWdmc0TWVGWXRXMVRxRmY1YjdHTzgvSFovMUVQVTJZM2pv?=
 =?utf-8?B?REtGQ2hCWHlxbHZxdnVxUXFOZG16dCtDUU85emQrN053Rmg2aHI4cWR1M0Vo?=
 =?utf-8?B?R3Nhd3J3b09NaDhGV2VTU05JVEVnaEZuT3p3NTdLWlpRQnQvbVNMaVF2MU5I?=
 =?utf-8?B?RktmT1dSck1FZnZITUNZTUNTM3ZGUXc4emRLUVFlRTFPQ000b0RRdTBTT1hZ?=
 =?utf-8?B?MnFzYlJlRmVHWUs3ZWVSOEtHVmxjN0hPT2ZjeWF2M1ZuN1ZzT016SmlaODF1?=
 =?utf-8?B?K3BrTkluVW0wWGRoUWFwYVFpbDE4b3M4YkMxT2JBc3lRUGtxcnI5d0VHVW9G?=
 =?utf-8?B?OEVyYVlHcHE2ZlRtOFU2SGhpYmFZcTIzQUFCdEhNTkYyUWp5U2hLdTgzNzYr?=
 =?utf-8?B?Qlhrc3ZFbnVlOGdwZU5UMlpKbHdTSEhKYjlJV1VHd0tXd0F0L0NkeXBscGRU?=
 =?utf-8?B?ZGhZL0RyTWdhUDVrKy9BRjVna0grbEJDVG9QTk9Sd0pqYm5rcDNCLytvZDA4?=
 =?utf-8?B?N2Zxd3A2S3JBck8rQXlpZ3FBL2JTQmpzRjNhQzlkS252R1hYK3N0L3Azazli?=
 =?utf-8?B?aWIwZHhQNWp6dmFxb2x0RzM3UTlvM1lyT1AvZ2ZMSHlaU1YvMFNzZVZrbkxo?=
 =?utf-8?B?NUFlRjNZcXNETThDQXV5anlrdkNIYys5S0RWVUhzZlZ0ZVBUQTgrbFI5NXlX?=
 =?utf-8?B?alo5QklCT285VlE4aVAvVVlSa3Z3RWdXTFJkblV0VnA3QVllOXJEK1R3cXQr?=
 =?utf-8?B?Qk9qNStiSk41Y2lqVldlN1BURmZvUFJGMWd1REpPNEptL3F4OU9PTHBlT2Yz?=
 =?utf-8?B?UlhPSWFxV1JYdDlCK3p1MmVJS2IxbmVJQW16THlWQW91Ri9jSVFrbml0Q1lt?=
 =?utf-8?B?U3IvTWhPNDFoTUg4Z1AxMkE3eGZoKzJscFl4b0VLajNsVnZZVmNMMVdlMlds?=
 =?utf-8?B?eC9BbE1td0MySHFOa2dmY0NwV1NTTWxJYmc0UUpRZTdya251a3hnQ2RSQUcy?=
 =?utf-8?B?TFk5SW1aQTRxeU5DTUtTUit1aE0yOWRNYTQwVzBqS01rRzZhWUtSTnVBWWtz?=
 =?utf-8?B?RjBtNFBDK1lLc2VjKy84dVMzNFZyMnFGRXU5NXN6bVAzTHFSdUlidms0Wjc1?=
 =?utf-8?B?OTh0T3RVb3BkbFpNS0p6bnRCV0Q1dVY1ejVGenRzdzJ6NGdrUExzQzdtYVpU?=
 =?utf-8?B?ZEpyV2hwQUNVdTlrdTE0b3hHemN3K2U2S0VmYU1RMU9HYTNWVzZYMERWalhG?=
 =?utf-8?B?V1J5SjlvU3ErMmJCMmVCbmRqdGU1S3hOQUNwY1FrRUd4TEwyalpMa1RqZkdx?=
 =?utf-8?B?N0ZVcXZEMEtaQXNub0xRTlE0YWlVWWlGQkxNVjEyZkJyWmsrc3JXTmRCUCtE?=
 =?utf-8?B?SklKK21ZNWZBQjNSak01b0ZYQVFWY3g0MUU4RU52VXhVdm01MUxyNmV2VmRa?=
 =?utf-8?B?cklwa2YzVXlDazJmaE1jQkxmaVJpT3d1Q2d1Zld0Zk9vSHN6aHBPNGxtMHpL?=
 =?utf-8?B?cG1HYWZpYTBsZjNQbUlOK2N0R1hYUWdVejY3V2JQWEhmWVdoRjhLaUZDR2Nq?=
 =?utf-8?B?U1UxaG1td3JqeWVCS3J1d242elVDK2d0TTI5QmM4MEphVUV0Vk1IRFZnUXNn?=
 =?utf-8?B?YURRY0g1UU9XRGtScWtNVjhnTUdwWFJXblRoZ3dtSWJaSXptOTRwYVQ5Q2Z6?=
 =?utf-8?B?bkdxd3l2dHN2Y0R4MTBWTDhrT29hU3lWSE10K3BiREhXbGp5YzI2ZDhWUHUr?=
 =?utf-8?B?Vi9nM1NwdloreExSUk5VOVNKcUJpanhoS0RicUkrYzB0eWNzNElQbjZTTW9n?=
 =?utf-8?B?RWV4dTZwSmlwY0xvczF6cENiTlJkK1VmMnlUMkVJcW1yVkV3SDhraW9zY2FF?=
 =?utf-8?B?VHY3K3dtT1dXdWd2WHN3MytXY0U4MTRMcHlicXE4RjZ6OUtVUDFJUE9haUQ3?=
 =?utf-8?B?bG9za0pFdldPd2lFTkI0L1YrcDYzWm9seVIyVGxwaTcxTlc1bzBxbHpXU00y?=
 =?utf-8?B?bHpWcy9JUHI5NHNMY3NFaitUYVFkUDJMUGFiZjZ1ZjZkQ0ZlWGh1aVN5cFRX?=
 =?utf-8?B?UWFoL1hwc3RSTlBWdXFPQzE3MUgxUnVLbm00Nm1xN09HSHFaZjczOHh2TnpB?=
 =?utf-8?B?OFB3M1dkcDl6K1FRbFkydU5nRkZUSkV5WTBOc0JLQUlsUHpjNE11TVVxbHFK?=
 =?utf-8?B?aks2Unk3R2xsUTVlWFFPNkdYSWpZYTl1Q1FUeUFOZHNWTkpKc2ZvaWNVTUZJ?=
 =?utf-8?B?Wm1kQXJxQ1VaTFZvSkx5a29nU2psVFp3VUVPeVJGVHU5WHI4SWNUOXZWZzFk?=
 =?utf-8?B?b1NrMlVTYmZQb3BkZW0yVnBzbkozTGZFSDFPWjd5eWpXSHhYdWJhMVlrUllB?=
 =?utf-8?Q?QhMx5kXidbeYadGZAXurxzgSbRitPVEa6/hJt?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 020a566e-f913-433f-2e31-08de58de91a8
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 11:16:48.4658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyqIOpt9WO05jvYeiYbG2Mnk1exnEq2Bo7Lg3jwdxFprQv6NxQMbFFQVlGEaFol7OEc8SQW+YemS5ip0GalXVv20lfWFFoczYZrLoAzIVA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10999
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

Hi Tom,

On 1/20/26 11:31 PM, Tom Rini wrote:
> - We already have good custodian documentation for patchwork, add a
>    reference and then link to it here.
> - Add a reference to the existing b4 documentation, and reference it
>    here.
> - Note and link to patchwork integration, am/shazam and ty features of
>    b4 as these are the most likely useful portions. Be specific about
>    keeping the default ${summary} as that includes important information.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!

Additional comments below.

> ---
>   doc/develop/codingstyle.rst     |  2 ++
>   doc/develop/process.rst         | 29 +++++++++++++++++++++++++++++
>   doc/develop/sending_patches.rst |  2 ++
>   3 files changed, 33 insertions(+)
> 
> diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
> index 7304eea0056a..2a69162fa95f 100644
> --- a/doc/develop/codingstyle.rst
> +++ b/doc/develop/codingstyle.rst
> @@ -24,6 +24,8 @@ The following rules apply:
>     <https://peps.python.org/pep-0008/>`_. Use `pylint
>     <https://github.com/pylint-dev/pylint>`_ for checking the code.
>   
> +.. _b4_contrib:
> +
>   * Use the `b4 <https://b4.docs.kernel.org/en/latest/>`__ tool to prepare and
>     send your patches. b4 has become the preferred tool to sending patches for many
>     Linux kernel contributors, and U-Boot ships with a ready-to-use ``.b4-config`` that
> diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> index f436a98433a7..fd81d9c5ebd4 100644
> --- a/doc/develop/process.rst
> +++ b/doc/develop/process.rst
> @@ -232,6 +232,35 @@ feedback to the submitter of a patch about what is going on:
>       work on an individual submitting a patch when something does not
>       apply cleanly.
>   
> +Tooling
> +^^^^^^^
> +
> +There are a number of tools available to help custodians and
> +contributors alike with their contributions. As a project we make use of
> +the Patchwork project hosted at `OzLabs <http://patchwork.ozlabs.org/>`__
> +and more discussion on how it is used from both a contributor as well as
> +custodian point of view can be found :ref:`here <patchwork>`.
> +
> +Another useful tool is `b4 <https://b4.docs.kernel.org/en/latest/>`__
> +and is documented from a contributor point of view :ref:`here
> +<b4_contrib>`. It also has a number of useful features from a custodian
> +point of view:
> +
> +* `Integration with patchwork
> +  <https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-settings>`__
> +  which allows for automatic state tracking.
> +

Can we have this integration added to .b4-config so there's less to do 
for custodians? Ideally also with steps to finish the setup so that 
patchwork is fully working for them?

> +* `"am" and "shazam"
> +  <https://b4.docs.kernel.org/en/latest/maintainer/am-shazam.html>`__
> +  for applying a patch or series of patches. Of note is that with
> +  ``shazam`` review tags can be applied automatically and cover letters
> +  can be integrated as part of merging a series.
> +

Is there any reason for using b4 am? (I only use b4 shazam myself).

Should we hint at --check also?

"""
Tells b4 to run a series of local checks on each patch of the series and 
display any problems. When b4 finds a valid patchwork project definition 
in the configuration settings, it also looks up the CI status of each patch.
"""

We can configure which command to run by setting
b4.am-perpatch-check-cmd in .b4-config 
(https://b4.docs.kernel.org/en/latest/config.html#am-and-shazam-settings)

We should absolutely make clear that both am and shazam fetch the latest 
version of the series, regardless of the link being passed to it (except 
if -v or --use-version is used). At least that's my experience with 
shazam and the docs states it should apply to both am and shazam.

I'm assuming the cover-letter being integrated as a merge commit would 
be behind the --merge option?

We may want to hint at -P or --cherry-pick as ways to only pick specific 
commits out of the patch series.

I'm not sure how much we want to hint at here versus letting custodians 
figure out their workflow on their own.

Cheers,
Quentin
