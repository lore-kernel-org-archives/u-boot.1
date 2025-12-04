Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CB4D2444B
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 17:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C046B83A71;
	Thu,  4 Dec 2025 18:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="RXP8zkXs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC0A48413A; Thu,  4 Dec 2025 18:28:42 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C395284127
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 18:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhGvKWNylOxNbwuBJlb3iVS4qoO8Llx7v3mjtLJ5WkdmzHsgEmwv4ruVG4JSztSWsj63UNiBf3yXBgn560p4okGnJR+2xnHfYvzpoYB7C25/W1fgj/IXAnkUkb317Wprlw0YFBExnLz9z7cH1UanpjsA9Xvo9vN4LkCClVRqpwSxKu/WjDUWwC3R0SsA+ThZdRn2wmOx3ceIqs3FE/zudDjt3WUTJe5dAFa4NwmpOyLcjbw6Nhd6W0YbJXLq0x5Iuw0FflXMWCpqf/sQO4UigY3uMFM7RKVnDB288Ks0YfEhbtvfkj16iPbrAkqqq/qZVLcSvUJpAuZHIm0TWZ+n2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EFG+2a5dyNNzfpEkUsr23vMxsr6YQNVyVVfKdJxW9I=;
 b=SG3+PYAWIx8nouktZz+4yrWkyORSTNeRF5h5cZH2HUnKeApc/9bqsxXP+UQwSvFl1HUjeDUiGgsPBVTXLLi26SQvWbYExg53idn2kAVz9MTpFmadGLAK2MZZDViYFhOMQximHN3jJtUs2CiUUfIBmaJVEtxj2Ik5DXDJlKtLjBnziARTrm9/gQuyO/iV6PVvnzvFoeSEYliwR1qe554TpooXlLIbZIgyYvlSznS2/MPMjaF+DVYiiVD/nn0bouzKnroAXR+QbOL+mfywGaKHP1JqLvTWDgpsvg4e9Ju2GoiuttYULhFFMZ7vJhexzgXjitol3gvHm4ij3w2u9uGaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EFG+2a5dyNNzfpEkUsr23vMxsr6YQNVyVVfKdJxW9I=;
 b=RXP8zkXsgyYCQw/othKNpbFP/QduhDfN4VEoXjEG8JlnvwZELM3AmpYL8z9s6qmcG4knItoWx1M227joqBwyr+JpDFF212lZLj1N039nQnc4EctMlf9WNZqYFkuKN0uShFdPL0zf/TegGzO5HrMcOsDY97m99YXhFr0MEhpNRAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS1PR04MB9558.eurprd04.prod.outlook.com (2603:10a6:20b:482::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Thu, 4 Dec
 2025 17:28:36 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 17:28:36 +0000
Message-ID: <36b9d7da-13e7-4620-948f-1b3b3b61a250@cherry.de>
Date: Thu, 4 Dec 2025 18:28:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: single: Add missing free in
 single_allocate_function
To: Tom Rini <trini@konsulko.com>
Cc: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
References: <BESP194MB2805A2491EFE4D94C777F9C5DAD8A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <97a3117c-7bab-47d1-a5ed-1a33e7c2441a@cherry.de>
 <20251203161142.GQ303283@bill-the-cat>
 <e25260e7-70ce-41c0-aa89-a8fb5a406b57@cherry.de>
 <20251203162826.GR303283@bill-the-cat> <20251204171536.GZ303283@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251204171536.GZ303283@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS1PR04MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: 574719f4-f197-40f2-6484-08de335a8e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEVRQTIzSUF6Z0pGUXNjVFR5NUNwZHBsVGRTS3FIWkFubHRybStzY3loZk1I?=
 =?utf-8?B?emlBMU1vcXNLUjlFZERkNmhlTkM1S24xRFA1d0FDdlQvYkZ1Z0xUdXFIeUJB?=
 =?utf-8?B?cW5Sdml5Qng1ZHE4OXRzZTFsRUtlSThaTEx3UEZqeTJOMDNTSFdMbmFrbjFZ?=
 =?utf-8?B?Zk94cmVKWHd4dythdkUxS2lmdktCcm9ML283bWxua0VzalF4ZHZUYklsM01D?=
 =?utf-8?B?dTFHSlJMTEhjVHBVVzhhZzZQVldSVWxBSGkxWHhuQlgxWkJyenErRE05N2N1?=
 =?utf-8?B?VkR3aXBTczNUL0NwZlpOVVdSUGJBeXBGRnpHNG4vYTl2RFN4dXZMbmpTY0Ja?=
 =?utf-8?B?VjY2TDJXWUtZc3V5Mm9Kc05FbHlISzUzbVgzWTVrQm82YzQrYnhHN2YrSkFi?=
 =?utf-8?B?dlZXcSswNXVEK0pBY2lYQXVTR21GYmpPN0RIR3k0WCtzaStPcSt2elhuL1Fv?=
 =?utf-8?B?K1V0dENmODV0NDQ0MGUyQklMSk16R3ZZWFBkN3VnaGYzandzUGNIZzUzbkli?=
 =?utf-8?B?czV0NThLajBYck5Pem1hbHkxb2NXck5BNjh2YWtDNUtUN1N0N0lhVENDd3dH?=
 =?utf-8?B?NmNULzV3S3hNdG83Q2ZOZG5WaWxGcktESC8wL1EweWVmWGRGRGRYVTFkUWpD?=
 =?utf-8?B?SG44U2QxQnpvNVgwWjE4dnhLbTI1OGpQZ2hoNThlZzBhVDBGR01sSDRBSTYv?=
 =?utf-8?B?Nk9VSkdkdlJXUU5qb1NtWmoyempIK3Q4Mk1oNVVKbWtsRlVUUkhmRU80SWxk?=
 =?utf-8?B?R3h6LzNCczBlYzFOWjJ6SG9OTERnbjZha0RZVGt6KzFHTzdxUCs2c0RtQnJq?=
 =?utf-8?B?eTJqU1dkV0E0aHQwTk1NNlRlMXcyWVNQMVpsWmFnR1JYOTNxQWVsbVh5bWVK?=
 =?utf-8?B?TDRKY3VOUWpZdngzaitFK0VOTTErWHVCa2txM0VQRE9ma2pJZDNNb090YmVs?=
 =?utf-8?B?bHRSYnZLeXYwUUpuRlY1OWpYeW1UeTdFc2ZXNUxvNzFxS3lYOVdUUit1bi96?=
 =?utf-8?B?OXhTSktla3dXaUdjQmQzOGRNenFnb3p4YURBTFhaQUtHNVl0SHVPaUthQjF5?=
 =?utf-8?B?WVpwNGxTbmZlZzlqNWpiMnU3aXh4RkU1ckc0d2ptSndyWmRMbXdFeHlDQ0wy?=
 =?utf-8?B?Wm5Ha1N1NGNjT0FHdmp2ZVBnN09nUGl5eTM0cUFGUWZDdTdwWjBpbC85eGwx?=
 =?utf-8?B?MlZleW9QQ1d4ZlhqTGU4eXJIYStLKzB4d3diUVZqWkIwYUVmNDh6RC9TbHdC?=
 =?utf-8?B?a3g0VE9vcGJQb0RIanR0MGpxUnhmTkk4Zm5IbGVMcEdMb3RXcHBPUk5VVTQ3?=
 =?utf-8?B?NHJRVDZOWjhJT2dLTUZVSlZaUUdHV1pIUEs1NGU0a2JuM2FZWUNUU0QzRW5F?=
 =?utf-8?B?cjVVWG04K0hzSENJUkJUNmZoaE1SaFF6bzA1Tm1UbVozenlMYnBKTE1YWWRO?=
 =?utf-8?B?YTdiM0tzUTlIZEIrbEhBMG1pNFdqV2lwd0tqOXhUcmxQY0dnNGNTcTMrNHNC?=
 =?utf-8?B?OEJKaWo4c2tNUitOYXU3ZXJTWU8rWVdyTXV4MUloYXdyMlNMMys4OVROTUIx?=
 =?utf-8?B?QktacnI3Z1preTAremhqZEFPMFJVWFc0VloxQ1VSdjN6azNwVkhFM2IrKzl2?=
 =?utf-8?B?ZVRGY2o4S1REajNLV2VmU3hpK1k0ckd5UTRRU0R0SEsrWndHM2VvNEZHdjdH?=
 =?utf-8?B?djg4dWxmOEtwZ1JGZDNCTkdpQmorYitPTXhZWmdzR0R4ZitabXIzUmlBcFZI?=
 =?utf-8?B?QnpWMEFBKzBGWmYyTEw2b3Z4YW5QZTBBWldDdGhFakhCUmlYVGFUSGtaT0VN?=
 =?utf-8?B?U3d6SWU1dktZcUNKMm9VT1J1Z3kvSGdZc1ZZYmtYbzUwNkpWR0lYbmNSanZv?=
 =?utf-8?B?cmVRaklrazJ5SzJZYnltTmxGK1RjZkZkUjZOdnpFa2VsUnhzNlQ1bTl6aHBv?=
 =?utf-8?Q?NWVqdwdWw0NCaXJVjnd9qhwj7tLcDYtv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2ttakRCOFhydGxEYVFiZXBrTXdpVjNOYUY4UVNnV1Y0STBUZm11S2x2Wnk0?=
 =?utf-8?B?Y3VlejhLQzFRRnF1VTRSSGtuTzRrK2x1RkQ1WXh4eGZkNVYxUnI5YUZmL21V?=
 =?utf-8?B?R2dKeHNoMGNZYXR2cHorSlF1M0FWRHhnY3hteXFXc1R2czB0c0M3Q2ZHMlhD?=
 =?utf-8?B?WWNDZE1EMkdrMk4vS0NRbEVUcXEvOVMyaUV3OGxFb3U1MWFDa1dRdVptV2Vj?=
 =?utf-8?B?c2Z1VjVsOFJSMXQ1N3llMlp3TjRjMUpxNFptYjV5UGRWakt3cHpMdXhTbldu?=
 =?utf-8?B?RDdoQWxkaXI4QlI3TW5VSUhQWEVJV25IZTVXaFRxaDBkSHJxNGl1ZXhmaEt4?=
 =?utf-8?B?amEyTE1GSENUWDZEK2daTUxFUUlMNUUxN1JXZEx1OVBCdldJOXloY2Q2R1c4?=
 =?utf-8?B?S1FvOWJZOUtsZDJNUWYrekNkMFJrL05tcXpIOWZnUzNTZzFIZHRwNnRQbWJ4?=
 =?utf-8?B?MUhaaERONUtCdkZ6ME1DenI1Smc5eE1XZTNuUVBjUEQzdWFFL2t5R2JhOFUz?=
 =?utf-8?B?TUpGdlNyU2MvN2w0emtlc3BFNUEwNTN6WmV3R0hCa2lHTnhsWCtpcUxHemFY?=
 =?utf-8?B?MFpBTjY2UTIvbXJhN0g1OUV4MHNTZEhRTmZ1WlVxWDU1cTdvSlVWYnhrb1RD?=
 =?utf-8?B?bWxXODlVajVmRmF4TkhCZ1g0VkpjRHJpYUNWQ0Zlb3RXRTd1NXpKTkx0NFhC?=
 =?utf-8?B?MUFHMVVqNFhESm9OTnVZUEZTcjVMYWxzZEthOUU2TVFGc3FsUVZRUmp6eW1o?=
 =?utf-8?B?Y242K3Y0Q0tGNU9lYmlKbk1yVWZnZEZjR2VrUlZUM0c5QTY5VmtobjRYeWtC?=
 =?utf-8?B?bklmWWFlVG0rOTg3VzdrOXB4NjZCbDJuN3BVZitZam11QW5ub0o4dGV0c1Zz?=
 =?utf-8?B?RDdhV2VoZ2lPZys2OG91MS9ueXBPbTFaSHNoaEdrY1J0eUNlbDBEenhERXN0?=
 =?utf-8?B?VnhOc2d2Q2VRZ0M0d3hLRDNRUlE5cVlUWVRmblpseVZTY0lsYWt3OFBWTlcy?=
 =?utf-8?B?UnRQa3pNSDZDbDVET2l4U09rU3dGWkZTYW5JZkM0UytDelRwQlRRMGI5NVJG?=
 =?utf-8?B?TEJ5ZTlRaXhBM1E0Y1VTVEN4NXY3TlNFaUJZaWh4eEVhV01jbExiaWRRTDFQ?=
 =?utf-8?B?ZUo5amJTY2M2QTlIR2QxZ3c0b21NUWdMSGJSTitWVC9LRUs2SzA4N1BxQUl0?=
 =?utf-8?B?dXdTYUJYeGNlNml1YStnY3hTeWlaTFN0U2VESnBMNWZiak1NUFlnV1ZBOXla?=
 =?utf-8?B?RUg2Q1EvdHVRY0w2T2p5U1Y4V2JyUmhubUtPbVBNdGwya2dmWFNkbjlHYXdV?=
 =?utf-8?B?M1dVZU1NZWpIUS9GTFR0cVF2cEdWL2xyTUEzcGZhRWE0bDQ0SzBlZllLL0xW?=
 =?utf-8?B?S2tIUTVqQVRpdzVQZlNpekw1MmdPbzVBVzFwOGNsRnNoRytib2NKMUt1a0NQ?=
 =?utf-8?B?bklXTEZ0KzYwNG5mWkdKSjYxUlp0QXpUYTZVQ3phUGVqMmVDdGpoMjlYb3c5?=
 =?utf-8?B?R0s5VVBhekxpR2VndDh3eGZpTW9XWnVmNWQ3VHdlMDI0bklmNzR3WGQ2S1BR?=
 =?utf-8?B?eTNzUFdBK2oyKy8vZ28yVVloVHhla0JxVk1NRWxveFMxRU0xQkl3aHA1SXZG?=
 =?utf-8?B?b2l3TzFLZk9HQkVsRnF5cFJBUkcxYTRCSDMwaHh2N3pHWHVxQWFOaS9YdGND?=
 =?utf-8?B?TGxacUlSRXo4a2dEL3JkM0F6R1FYWHJjcy9RSjdEN2p2c3dTbEtuK0piemVp?=
 =?utf-8?B?czRWb0VvKzZPbHVyd3psUFRUVXlrbFlYUXNLM0RYL1FFOTh1L3QxQ0FUbDI2?=
 =?utf-8?B?eklhNTYvd0xFSUxzMGFDcVUxVDFuNDU0TCtXNFFKVUZBY0RWZFROWUR6THpG?=
 =?utf-8?B?VkdRTmNFYWExaTFlNXRtSlJzVERvZ1E2VW0rTFVNZGFGdE5BRWx3WEJ0bFRO?=
 =?utf-8?B?RmR4RGR3THdTc244R2JQSHQzSkVzSlMrbHN6aG55WkRRakNqNGZ6UHVSd3Rz?=
 =?utf-8?B?eTdIeFdCbm5oWmNTRmhxcWZZZ1prbmhMc0VpNmNyL0RzRWs0a1ZvK0ViVDAw?=
 =?utf-8?B?dGI4c1d5Tm4vRHBhZklKdmxtU0lQbzVzcmJyWjhvQUFPUXBPRUlOVGNnV1hX?=
 =?utf-8?B?Y3RJOGlobG0vOVZ4c1J2VlF2TlM3Z3ZjOG1MOWNEODdCa2wzcHpnVVg5dTYx?=
 =?utf-8?Q?H9TAHtwDr8LLZMiJgyvumQg=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 574719f4-f197-40f2-6484-08de335a8e82
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:28:36.5189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZJLr6ymo6EiCo/IxWy1AIPM4ecHScoVLnnTA349+E5EWXzlTYFK43Z/59V1QuWuAGymq1mW6TmTlXZfrf+PahWudnfk4Y/SSLTYTdpU1ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9558
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

On 12/4/25 6:15 PM, Tom Rini wrote:
> On Wed, Dec 03, 2025 at 10:28:26AM -0600, Tom Rini wrote:
>> On Wed, Dec 03, 2025 at 05:23:47PM +0100, Quentin Schulz wrote:
>>> Hi Tom,
>>>
>>> On 12/3/25 5:11 PM, Tom Rini wrote:
>>>> On Wed, Dec 03, 2025 at 04:36:49PM +0100, Quentin Schulz wrote:
>>>>> Hi François,
>>>>>
>>>>> On 12/2/25 7:39 PM, Francois Berder wrote:
>>>>>> If func->pins could not be allocated, one must also free
>>>>>> func variable that was allocated previously.
>>>>>>
>>>>>
>>>>> Well.... devm_* functions should take care of this when the device is
>>>>> removed (or probe failed), but if and only if CONFIG_DEVRES is enabled.
>>>>> However, in that case, this code may be executed outside of a probe scenario
>>>>> I guess (it is called in set_state() callback from the pinctrl device). This
>>>>> thus makes sense to me here.
>>>>>
>>>>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>>>
>>>>> I'm also wondering if we shouldn't check the return value of
>>>>> single_configure_pins/bits in set_state instead of always returning 0?
>>>>>
>>>>> We probably need to devm_kfree a bunch of other devm_ allocations as well?
>>>>>
>>>>> I see a loop in single_add_gpio_func() we should probably unwind if there's
>>>>> a devm_kzalloc which fails?
>>>>>
>>>>> Maybe we need a .remove callback where we devm_kfree all of functions and
>>>>> gpiofuncs lists from single_priv, in case DEVRES isn't actually set?
>>>>
>>>> I've wondered, but not fired off a build to check, what the growth is
>>>> going to be on default y for DEVRES. There's only a few platforms /
>>>> chips doing it today and I think most drivers are written like the
>>>> kernel where freeing is automatic, so there's lots of cases like this
>>>
>>> I see devm I assume it's automatically freed (or whatever counterpart of the
>>> devm function is) if the device is removed or fails to probe but that's
>>> rarely the actual case.
>>>
>>> The issue here is that DEVRES is not enough, we would need SPL_DEVRES,
>>> TPL_DEVRES, VPL_DEVRES, WHATEVER_DEVRES (added and) enabled as well as we do
>>> compile devres only if $(CONFIG_$(PHASE_)DEVRES) and then surround code with
>>> CONFIG_IS_ENABLED(DEVRES).
>>
>> Yes, we'd also need to see about being concerned with xPL or not, more
>> widely, with respect to DEVRES.
> 
> Checking this out now, and we've already handled the xPL case by
> deciding that we just don't support DEVRES there (and there's likely not
> space to do the work nor reason to, given the lifespan of the runtime).
> 

I assume there's no way to have an issue reusing (if at all possible) 
the malloc pool from xPL in a later stage?

>>>> one here.
>>>>
>>>
>>> I think this one is an exception as the device may still exist if the error
>>> path is taken, so I think it makes sense to explicitly free it here,
>>> regardless of DEVRES compilation state.
>>
>> And then it would only be the case of having to worry about some
>> failure paths rather than how it's leaked today, if I follow things
>> right.
> 
> Here's where it gets more interesting. For the cases where we could be,
> but aren't, enabling DEVRES it's around 500 bytes growth, with the
> reward that we get proper and expected memory management. The challenge
> is that we have some platforms where there's nothing making use of
> devm_kmalloc and friends and so we need to go around and manually select
> DEVRES on functionality that makes use of it.
> 

Don't define devm_* functions for proper + !DEVRES so that it fails to 
build?

Cheers,
Quentin
