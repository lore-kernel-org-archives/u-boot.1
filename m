Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5267E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 13:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB7A890D9;
	Fri,  6 Dec 2024 14:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="mHdpiBhl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C76F895EC; Fri,  6 Dec 2024 14:19:44 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C326E88E0A
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  6 Dec 2024 14:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPdabc59Wtbl1hyCzpk3AnKYABuI7HrN7eP72ZkOw0JRNAwP9iHQsACq02ZHBAor/r8YDXZFFvli7K7XR8zOE2Ta0IDlhX0jxRkENsk1fAzzlsuMobOTEvRv5RML4ho+/FcpfphXhh2dgoMvgur7ZlzWhBIfou2JgU/Ok2VlC5nMyZWtUCAUIPN8U995i6LRsEQhElGfl7Sigl2/HypxinFyE3E5YpXiFTsFt8tKpYlciXaqL4A2hghlNu56qT66bX78ncrjM4A1230vi7vDk5WQva4ZINqU8Vs2wZ7BpT2e24+XngNRgLFre+jNJ2mhEzLXTgfDB2EK1g2njoL8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHlq9GS9sv0nPXQHzqzlnzivLlbgN9sLB5Pw9YqZ7xM=;
 b=XxROBIGvNwkoGcEYyd1nzX0/cPzcPKnpa4TI8pGIIytFdpxhx9jBbPPCNkZkHDX1xAEWqk5TUg5O6n1tzhFVc/1Rcmznbm2Vj4dbWaWmayVO6RBv332cfLUrHO3JsHLkWh7BoyGeBrVtsLjZUj+l6NlKl/ZK6OedqOSuMTZQ2fsX6HVdZW/kwF0b7/ngC22UL7Op/oWDKdePGqz0rfOZ+hy+2yAPPBcgwyAmjMbiiJEA7y+DllconLz+YsZndfnIZlR8z3xGMyDW4jUuoZZdf9+SRS4maiuoelZerxNen0bPwjNok1B0yzOU6k0KDDy03gGjC5eMN9dYO5dNR+KKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHlq9GS9sv0nPXQHzqzlnzivLlbgN9sLB5Pw9YqZ7xM=;
 b=mHdpiBhlNfoc9cjuW5SXqRYuJdYmOD2Xk3SRJ3YMQIxKwMiGw7B9B0D3oQ483/k8p3rwyrnRfvfbfHCpDEWKt2obUAzixwTjpCi1H+OU2I1g6FYaZRI6Gz73BbX3AsPLj+QLFNaeI0cUCWIQRnDUvXr3PaNwPzcRKA8MqkXFmI2UeAxbn09mvQG2M8TB27ZpaU6pH/dqL7+xJxsZCtS5Py8fOq34cRwEWBOMCSDunxFR1FAPzSAOR//8iEaTYM3mA5XaFD8tdaEcJSbrkb7BWsSBBXXpKY32IHsH4m99zPKhSz2aUJseqAgJ/Yrh74TmkkcMjoI5cLCBpjSsno4kPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PASP264MB5201.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:43b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 13:19:38 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 13:19:38 +0000
Message-ID: <a40f5c90-9884-4733-818a-bed01b5de099@softathome.com>
Date: Fri, 6 Dec 2024 14:19:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] test: lib: add test for sha256_hamc
To: raymond.mao+nodisclaimer@linaro.org
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20241204175437.185449-1-philippe.reynes@softathome.com>
 <20241204175437.185449-4-philippe.reynes@softathome.com>
 <CAEfUkUJKCVAOS_SjTjQNKhxPqLhUr5AjryJ9krzKWbTZG=LX8A@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CAEfUkUJKCVAOS_SjTjQNKhxPqLhUr5AjryJ9krzKWbTZG=LX8A@mail.gmail.com>
X-ClientProxiedBy: PA7P264CA0103.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::11) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PASP264MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: c63de4de-ae42-471b-0de2-08dd15f8a2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVgvUHB6bVhWaldjbHVtd1RsZXdhNHlEbTBNczE2VHM2N2tsOWhPcmRwNTAv?=
 =?utf-8?B?cElUT2x2OEErN1hGZVRHZzNOWTg5MmE0Y1dyKzNjRU1EMzA1VmRJUy9LRm9j?=
 =?utf-8?B?b1hXVkVmckQvdXg0dGh4c3lMNHI4ekNkZUl6bkFVZFlSd2M4QmF4Rkl6U0pk?=
 =?utf-8?B?QU5RbjJjb3h2WHAxbFhMc2d1REkvcHkvc2JzQ29FVXZvWFc0UzZLN1Awd0hy?=
 =?utf-8?B?b0RTWjVQWkJUTHZkZmpYMlRTQm52NmhuN3h6SUNZZHhTTEg1ZXh6R3R6TkJJ?=
 =?utf-8?B?K1lLSkVTSm9uVGs5clFjeUU3OG11bWdFaVlMQzMwWXl1WWRyZWxNQTQrVDhQ?=
 =?utf-8?B?MXBWam5ucFBQeXNCWENCeVRHSzNCdkJQaDM0RUh0NDVyNVdsZ0poRlZNVytj?=
 =?utf-8?B?VnBPUkxoaXdWRnlyU0lBN1ZCTnYxeEM4OGNlb3ZCcldHd3RPU0E1Ry9EMUtV?=
 =?utf-8?B?WlR5WFJyK3dtb0tkWEFad2dsZElDVnJTRFdmV3dJUFFacDZKRVFUU1RZWEtL?=
 =?utf-8?B?NEViN3BOYjM3Zm9xZEYvcUd5MTlQeCtUR214ZkpxcGJXNmRzRXFjMXkyMUVi?=
 =?utf-8?B?bzI3UXEvK3J4a0lYdEtJYlhWOWd2MFJyck9BbkhqSlQ2ZTJqM3ZlTy96VjRj?=
 =?utf-8?B?dHVnZzRZbGtpRmk5bnVINXZWQ3Ezclc4bkVMeTBXUUxkUERsVjNZWEZEUmM0?=
 =?utf-8?B?a1FRZm44UzdGeWREYW9OdGFzUU50ZVZnZURCWS9zQmkvcjgxOU84RlhYQkVP?=
 =?utf-8?B?RERsUGdkSzgxMnBub3RRRXNFSnFsbXQzWmp1c011Z3lia1dNMGF3WEw1Nld1?=
 =?utf-8?B?YjdzRU1xMnBoQmtMbkxERXNPYUFrM1Q3VUgzU3owNXBRdlpRaFdueGIva2pB?=
 =?utf-8?B?OEtqclhGa3ZjNXBUU2c2R2RGbExGWGZBYjdCMDM5dFh1c3ZXVjhZVVRoNmFz?=
 =?utf-8?B?UHl5MzF6YXJtRkZ5SzRpay95bEM5TVN6V2ljREpEMENBOUR6elpmc1J0RWM1?=
 =?utf-8?B?L2gxSzd2ODlEdVdEWDJ1d0NCRStoNjFFdkg3T2VtM3daN0VUdmN3WEhPbG5z?=
 =?utf-8?B?eGxNKzdrQnNkZlBtM0NKMVBNZ25RQjVBTUhybFM2SEJFdzRJY3dlUkgzTXBE?=
 =?utf-8?B?cjNvL2ptSjJ5U1BTb1RIRlQxRW9EdTR5UzBLb283dkZEZkZIVU1nV1IvUkJt?=
 =?utf-8?B?MkVDTFN5NWR3aHNBa3Q2dGxJcXpaVUl4S2dtQ2hjTUtSbnN2eVcrMWNVNFo2?=
 =?utf-8?B?ZktZRFlVSTBxWklhNGZXRE4rbzdEcS81Y3NLQ2RVeE0xQ25ac3VIdzB4d3Fr?=
 =?utf-8?B?bjhwVnJSSjc2VnF2T0lCOUVPNnpIelFrRnlpY3ZoaUJXMXZ0blh5R3hwREZl?=
 =?utf-8?B?a2l6c28zN1BkaFBoL1VyeEFPQ1VRSEt5czUyK00yQ3FhZ2JiL0dDWjRaMXBa?=
 =?utf-8?B?YWJ6R3F6MEpwTnNMN0g0cWhOekNTVHIyV3hVWUVkTFkyZUlHVFVxUldYUkFR?=
 =?utf-8?B?cGVPaGFOYWtsWEpsWGswRWZBa2NMd2ZMQXdKeGV2ZjlYY004VkgzOEl0TkNo?=
 =?utf-8?B?Rmh4Q014SHNZaUNkRHJ4MzNiUmJhUFFrbDBKV3ptUmoyS1psazlSTWVKK3cz?=
 =?utf-8?B?ekFNVnpqVisrbmxJa2JyVmF2dFJHb0dEcjBxTUQ2M2w3NWVEUkJRZXU1Y2k4?=
 =?utf-8?B?VmxySSsyOWdQbVB5VnppSldlVkpZWmUxeUdjb3J5QWlzNVhFZ0tvY0xNOWUv?=
 =?utf-8?B?dzV4bndJVk45cEk1M3pEd2VBYkNPbXl0VmhlblJYeGxnVFBXYmoyczhOMzRh?=
 =?utf-8?B?dHRkcDNLMkhkMDBrTWtmdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGxyUisxYzNvdXZxM3R4R05aR0kxRSs3R01pWFAvR1FFRFZnbnpvQ0lseFBK?=
 =?utf-8?B?dWJKU0VYS05YQS9OWVYrSndRVFE1amg1VStxWEoxQi80L3FHeVhKb2I4bUVX?=
 =?utf-8?B?S0pyNjBHdjJGZG4rTEtTeWNrcVpLSHZlK3JUV0ZrOSt1UTRyakhjWWRhT1dh?=
 =?utf-8?B?MzV6NE1ZVXBFdzFHcVArWGY2T01HbzJIbE9hOW9sWFJNRTYrcVB5WTh3amxu?=
 =?utf-8?B?djR5Z2pjdGo4TElZYlVBVW13TURzYzBsUzc1ZlBkRUc0UFQ0YWhtOHF0WjFL?=
 =?utf-8?B?V1JOTm56b1JlVEVkQWFBVWYzMTJLaE1QNzlaUDM5dkF5WXJTN3dBNWhFTEpq?=
 =?utf-8?B?Z0grZ3B2M05Ld3RQUmg0bFlObDJiNTgyL242cXNSVFhwS3doZzQ5Z3M3Nzdj?=
 =?utf-8?B?dGxYY1JnSUdrbFg1T3RZNDdrMlEya3FmdCtUT2NvRkJRWnNMc0xRazRZSjhY?=
 =?utf-8?B?b2JlUWVKdjVqTjNOQUc1NDZnOFU0dzJRTFE3dXpiSk1sZjJMVEJFbHd1a21E?=
 =?utf-8?B?Z3VJQW5HLzhyM2h2aWlIWW41REI1Qk4xMDRETnBDRytXbUY2ZGFFSWZCeUNi?=
 =?utf-8?B?RTZBVzZVNUw1dGNsQTc4b2piNjlneTJGejg2WVRlYlovV1Rlc0h4cFU3bS9Y?=
 =?utf-8?B?VDdnN0RWbVQrRzdmakU4RGtPVFRzaC90TWJ1R3NiblcyMDZNN1JHRWFQVzFB?=
 =?utf-8?B?elI2QUxHTlIwc2Q0YXkzamtKd0FDbXM0Ym93a1hZMDdteDdSSE5DZlQvSGdz?=
 =?utf-8?B?V0lYSVJsNHFNRmNhT2N4bWNNN1luSzZhZlV4QkppNCtabVpITkFHOS9DNnE2?=
 =?utf-8?B?L2lUeVlSYnNiUjBROUhvMVAwYTYrem5IVG5sZ1g2TVZPL2t0Y0h1cHJXaWwv?=
 =?utf-8?B?ZnlGaWVpeG5sUnlBWFBLS2VIc0JwRWhUd0x4UFhUa29haklnS0NRUUYwMnJq?=
 =?utf-8?B?MDNCM2lqdWJ1QURKeEluMXN5Y3dXcW90RDBkOWZORG5mRGkrMTlicWxmaU5o?=
 =?utf-8?B?b0N0eHVVT0FseDR5RXVZUXpIaTNpbW01akZkTURkTUFlVVpQTzUrRC9hblpO?=
 =?utf-8?B?NG9CSldNUldqNmVZd1czeWIzZUwwSkEvZG1vamtQUFdoV1BSOGlaZWJNU2xK?=
 =?utf-8?B?YjJDQnVJeFdGRWN5NkJZallpblRXWmhGNkh3TVhoaEdEOWlQVzd6ZUV2MWg2?=
 =?utf-8?B?RG1SblRLQ0p6TGdtRTBtQk1Mc2d0N1lxK1AyaitIR2l5TDh1TGRMaVg3SEFK?=
 =?utf-8?B?dzRvdXE5UG1nQVhrK1I0ajVGdlF2L1Q3WGxkV1pxbzNROUcvSUllZHZNaFNr?=
 =?utf-8?B?YkR4alR6K3dsWlZqNmlpdEZ4Ni9qZmhPNHM0M1E1RUxFNGRrMDVlaUlJVzdz?=
 =?utf-8?B?TXhLdXNTVlZzMlljNit0U0Q4MmRuRERpOWxSOHlIVlBWZE0zL1F2VHNvRTZq?=
 =?utf-8?B?OFk4d0ljTFZiLy85S2IxUDdYM3J1Rk5nby9jMTIrQ0pxQ1NsMDU2OWhKTHc4?=
 =?utf-8?B?UDZsWFpxNnpRblNLbnY3RkMrTG56WjVuVjJ4ODJDOWRFeXRJcmxoc0RWUjlO?=
 =?utf-8?B?b2xpSnFUSWpKb29yUTdacDZpUjFhSGZQWTlBV2tyUWl5aytnUk5hc0lMSmpi?=
 =?utf-8?B?MzlOUWpNSFpqbmFoRzJBV3NSTi9GYXFPNnBWTnllZWFFVDhSTHdzUk1ZRWxx?=
 =?utf-8?B?WWl0ZnJEeWRuTE1UTEJuVUdSUnUvQVpPWmlsK3EwWHF5eUZ1YU8xekdGbFY0?=
 =?utf-8?B?T0czNlVQb3JVUXlDalM0Sk5aclA1b3hmdUxqYmE0Wldja0ZoU0tGV3VpK3Jn?=
 =?utf-8?B?aVZrSDB0TWxma1JKNG93YjVITnBjbmp0UW1UWmF5elAwL2J3b1lua05HcUtG?=
 =?utf-8?B?MFg0eUlyRGNWcFRvWldCTDgrOWZ1eHBudktvUzZ5ZUxBaHQ0WkxOa0JlRmdK?=
 =?utf-8?B?ZUt3VXByZE5uaGZ1SFZZMm9rWjdlemVpSGJlTGZzOWZqbWd3NW9LcGZGdjRC?=
 =?utf-8?B?bU8xT3RKbTAyWXlXS1dpZkFCVDZHT010enBEWE5PZXkzL1FXUTlOOUdrbGti?=
 =?utf-8?B?QnNnMVNMOURZdHN6NVJ6WU1wdXJoajkydXlwV2kycVA0ZkRXM2JVZ2h3aS9j?=
 =?utf-8?B?OGNReHRIdDIvRXQzL0wyVVo1cFRsN1JhVUE0UmJkUWtXVVZrZmJqR3N6TlpY?=
 =?utf-8?B?VGhYU0hnb0lCZlN4SFgzbVVDRDJ2bUFuaVF0Z2NSQy91WTdvbS90ZDZZalBS?=
 =?utf-8?B?elBqcFkxb3ZqSWlQTXowai81NVRnPT0=?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63de4de-ae42-471b-0de2-08dd15f8a2dd
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 13:19:38.6541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XfIc/YUXgV6kovYYI/bKyJj26icV3E7FB2Emnz631XqpbeCovMmR7J/ZBV9r6CBv2qGBe9HxsittSwkxZob+YfPKC7OzXowIXxIR6dMxIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5201
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Raymond,


Le 05/12/2024 à 18:14, Raymond Mao a écrit :
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click 
> links or open attachments unless you recognize the sender and know the 
> content is safe.**
>
> Hi Philippe,
>
> Typo  "sha256_hamc" in the subject line.
>

thanks a lot, I will fix it in v3


> On Wed, 4 Dec 2024 at 12:54, Philippe Reynes 
> <philippe.reynes@softathome.com> wrote:
>
>     Adds a test for the function sha256_hmac
>
>     Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>     ---
>      test/lib/Makefile           |   1 +
>      test/lib/test_sha256_hmac.c | 108
>     ++++++++++++++++++++++++++++++++++++
>      2 files changed, 109 insertions(+)
>      create mode 100644 test/lib/test_sha256_hmac.c
>
>     diff --git a/test/lib/Makefile b/test/lib/Makefile
>     index f516d001747..5aad81d5a8a 100644
>     --- a/test/lib/Makefile
>     +++ b/test/lib/Makefile
>     @@ -24,6 +24,7 @@ obj-$(CONFIG_ERRNO_STR) += test_errno_str.o
>      obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
>      obj-$(CONFIG_UT_LIB_RSA) += rsa.o
>      obj-$(CONFIG_AES) += test_aes.o
>     +obj-$(CONFIG_SHA256_MBEDTLS) += test_sha256_hmac.o
>      obj-$(CONFIG_GETOPT) += getopt.o
>      obj-$(CONFIG_CRC8) += test_crc8.o
>      obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
>     diff --git a/test/lib/test_sha256_hmac.c b/test/lib/test_sha256_hmac.c
>     new file mode 100644
>     index 00000000000..473922bd9b0
>     --- /dev/null
>     +++ b/test/lib/test_sha256_hmac.c
>     @@ -0,0 +1,108 @@
>     +// SPDX-License-Identifier: GPL-2.0+
>     +/*
>     + * Copyright (c) 2024 Philippe Reynes
>     <philippe.reynes@softathome.com>
>     + *
>     + * Unit tests for sha256_hmac functions
>     + */
>     +
>     +#include <command.h>
>     +#include <test/lib.h>
>     +#include <test/test.h>
>     +#include <test/ut.h>
>     +#include <u-boot/sha256.h>
>     +
>     +struct test_sha256_hmac_s {
>     +       unsigned char *key;
>     +       int keylen;
>     +       unsigned char *input;
>     +       int ilen;
>     +       unsigned char *expected;
>     +};
>     +
>     +/*
>     + * data comes from:
>     + * https://datatracker.ietf.org/doc/html/rfc4231
>     <https://datatracker.ietf.org/doc/html/rfc4231>
>     + */
>     +static unsigned char key_test1[] = {
>     +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
>     +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b };
>     +
>     +static unsigned char input_test1[] = {
>     +       0x48, 0x69, 0x20, 0x54, 0x68, 0x65, 0x72, 0x65 };
>     +
>     +static unsigned char expected_test1[] = {
>     +       0xb0, 0x34, 0x4c, 0x61, 0xd8, 0xdb, 0x38, 0x53,
>     +       0x5c, 0xa8, 0xaf, 0xce, 0xaf, 0x0b, 0xf1, 0x2b,
>     +       0x88, 0x1d, 0xc2, 0x00, 0xc9, 0x83, 0x3d, 0xa7,
>     +       0x26, 0xe9, 0x37, 0x6c, 0x2e, 0x32, 0xcf, 0xf7 };
>     +
>     +static unsigned char key_test2[] = { 0x4a, 0x65, 0x66, 0x65 };
>     +
>     +static unsigned char input_test2[] = {
>     +       0x77, 0x68, 0x61, 0x74, 0x20, 0x64, 0x6f, 0x20,
>     +       0x79, 0x61, 0x20, 0x77, 0x61, 0x6e, 0x74, 0x20,
>     +       0x66, 0x6f, 0x72, 0x20, 0x6e, 0x6f, 0x74, 0x68,
>     +       0x69, 0x6e, 0x67, 0x3f };
>     +
>     +static unsigned char expected_test2[] = {
>     +       0x5b, 0xdc, 0xc1, 0x46, 0xbf, 0x60, 0x75, 0x4e,
>     +       0x6a, 0x04, 0x24, 0x26, 0x08, 0x95, 0x75, 0xc7,
>     +       0x5a, 0x00, 0x3f, 0x08, 0x9d, 0x27, 0x39, 0x83,
>     +       0x9d, 0xec, 0x58, 0xb9, 0x64, 0xec, 0x38, 0x43 };
>     +
>     +static struct test_sha256_hmac_s test_sha256_hmac[] = {
>     +       {
>     +               .key = key_test1,
>     +               .keylen = sizeof(key_test1),
>     +               .input = input_test1,
>     +               .ilen = sizeof(input_test1),
>     +               .expected = expected_test1,
>     +       },
>     +       {
>     +               .key = key_test2,
>     +               .keylen = sizeof(key_test2),
>     +               .input = input_test2,
>     +               .ilen = sizeof(input_test2),
>     +               .expected = expected_test2,
>     +       },
>     +};
>     +
>     +static int _lib_test_sha256_hmac_run(struct unit_test_state *uts,
>     +                                    unsigned char *key, int keylen,
>     +                                    unsigned char *input, int ilen,
>     +                                    unsigned char *expected)
>     +{
>     +       unsigned char output[32];
>     +
>     +       sha256_hmac(key, keylen, input, ilen, output);
>     +       ut_asserteq_mem(expected, output, 32);
>     +
>     +       return 0;
>     +}
>     +
>     +static int lib_test_sha256_hmac_run(struct unit_test_state *uts,
>     +                                   struct test_sha256_hmac_s *test)
>     +{
>     +       unsigned char *key = test->key;
>     +       int keylen = test->keylen;
>     +       unsigned char *input = test->input;
>     +       int ilen = test->ilen;
>     +       unsigned char *expected = test->expected;
>     +
>     +       return _lib_test_sha256_hmac_run(uts, key, keylen, input,
>     ilen, expected);
>     +}
>     +
>     +static int lib_test_sha256_hmac(struct unit_test_state *uts)
>     +{
>     +       int i, ret = 0;
>     +
>     +       for (i = 0; i < ARRAY_SIZE(test_sha256_hmac); i++) {
>     +               ret = lib_test_sha256_hmac_run(uts,
>     &test_sha256_hmac[i]);
>     +               if (ret)
>     +                       break;
>     +       }
>     +
>     +       return ret;
>     +}
>     +
>     +LIB_TEST(lib_test_sha256_hmac, 0);
>     -- 
>     2.25.1
>
>
> Regards,
> Raymond


Regards,

Philippe
