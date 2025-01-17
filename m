Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9372C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 01:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AC718069D;
	Fri, 17 Jan 2025 02:42:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="kv74eI6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A91F806FB; Fri, 17 Jan 2025 02:42:29 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::71d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04F9880312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:42:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rlm2413fmO+m+ppZWq5shEyTxy/ssSGqm7rtjIVbMduIzdXaD8YQzf7fYVsVFFv6NDX/qnAN3VDiW4uGv5mCW5dIy0U74Jf+FuMo2qSYvK35v/6b0stZFtoXRb7rhK0RwSudNPXX8liQKQKDYFHVpJBc7RAyIdeDNkn5Upih87BhEit5kr3svLz8GLtfjZqxy0FhrdvyorXqW8juOy/0p7Wxzdj6M+9AFuHY8Dw6wu2juGobkfJ7svrw/o5Q2uGoktyvE0GR2VSTygW507Dad03B5wGGfKfGzFylQvNnxg7pRqBnNC5+ll/r8NW4czOvZXNoYQakq3nEcWI+yxDzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mncifQOLNB903LBe5CxqOvWjuJENnbO9SUkLIf5N1iQ=;
 b=QOwbgSGkNQk5c5qS90ZsytRhWQirvp0k1i6gQq+KvmmtRhftYWqBorEfrsZUixNDk9ZKutBHjbvbyJX/dR2oeul1OdQBYcH82e1TIVp6wBxOds4sZSfqkLjxJBaI4RLaZmInknW82Jx1rqDwAm1sQEKFMgqv8iqcDC2N6ahVLD3jYiuertmtxEB1ci4StTcp+bf1zEXzIPJP4wft90JrHD5prqsUwebSKkBwRHnUUUjZptIDH7xofEdkpSJ5rfQh0nA4oibhyc9r01/HlZ/7ifyMP1bSAp8CbtZT2UBqsSXlI8HdgtNoHlpFHacyHqRNW3FON1byZcQCl9fa8QtycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mncifQOLNB903LBe5CxqOvWjuJENnbO9SUkLIf5N1iQ=;
 b=kv74eI6a3ED6yPteN5SbQ5zImOyN7LK+8pjnVKPMEJfDBVyrP8dvM+459K8ljLlhIgj8ShcnsYASAowX3UPuGYTEndgYIyp4VlpfF7ob8n5lxdqIuN/oy0GZ38qQa8MTMSY0pfO4PppeoIiSB7pnSJc3BWW1FDZvpKJZ7IaPAHxMGSQ4hVJfoZp6EYnEch57l9KdBYt5sdsxrBggkJw6Qn1vBEX1rzJNT0up/kXHyCZmpXWTOLRat7Sl+g2RwqLio6L282mnIpVlwpXqIa/QF0jSncdM5nNQPybrVSaiVJhK+Jx8qxi8u0WBNoqWSBdGq4g+KvIiyaYYO/Fb0qw+wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by GV1P195MB1809.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:5c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Fri, 17 Jan
 2025 01:42:23 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 01:42:23 +0000
Message-ID: <48099bba-4c87-4fe0-8499-31086c21218d@phytec.de>
Date: Fri, 17 Jan 2025 08:42:17 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] board: phytec: common: k3: Add missing boot source to
 env
To: Daniel Schultz <d.schultz@phytec.de>, trini@konsulko.com,
 u-boot@lists.denx.de
Cc: d-gole@ti.com, n-francis@ti.com, mkorpershoek@baylibre.com,
 upstream@lists.phytec.de
References: <20250116112932.1983801-1-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250116112932.1983801-1-d.schultz@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:820:c::12) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|GV1P195MB1809:EE_
X-MS-Office365-Filtering-Correlation-Id: 248bd329-837d-4ec9-756f-08dd3698307b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3ZiU000eVlEbXdsbWZHaE5hQ2hKazRzU2NhVStqK1YvTmdvQ3V6K0hHOUlm?=
 =?utf-8?B?bHF6Q3M5QnoxVW1SdlUyb25HYXJKRWdYZEhYWGxjUHB3Kyt6aE5LeFM3Ykxn?=
 =?utf-8?B?dE02ei9FMXFSVzltVURaeitiSFFzZ1c2d0RhNmJGcGtOSjZlYzY2alA0OE93?=
 =?utf-8?B?TlV1am5PU1pIeUdUMGYyMEhvMSs0dUxRVzA1dUJ2aGhNZHdtY0pONlNGWWlC?=
 =?utf-8?B?bHVpeFRrZzdBckhvNTdVejZrb1lZSEppY0xJZmlSS3JEUVJJYm50Z0JJd1pV?=
 =?utf-8?B?VFlMYlVYZWpVcVBXL3pYbG8zQld4UWQzMllidzB4Zi8xZE9OS3pSUUZHTXBq?=
 =?utf-8?B?MXdJeXVOTE4vVEY1ZThFOHBKMGFzUnlHOXY1aG51ZExKdk5sY3BlTmhyS1lm?=
 =?utf-8?B?WjVmc1hUZDhlem0wSG5pRjdacktKekh0T0lBM1NsRjFwTUMrZHh3SlZYcGNk?=
 =?utf-8?B?R1VtU3Zud0dDeHVycDU4Z2JYOGZKbVJkaTJSbjQ5MEJNUm1lY0lqbzdoS2Zh?=
 =?utf-8?B?SW5WbVRpZVpGK05GZzc1UFp1MEVVMmIwcUVKWUxKdWhJQnJVUGFEU2trd1Q3?=
 =?utf-8?B?VU83ckFQK2MyMVhRVGJTZkZGSzBJYjBUdmxzLzVGRzNJQy9HNUp1OXQ3QjRV?=
 =?utf-8?B?N1Bwd2RSYlJtcGNvTE1tRjc1bHpqNE5RL2srZmtLV0FkM3l4MDZ4U21qaGNu?=
 =?utf-8?B?bVhuM1BhSUlzdWx3UXhFVlkwWEY1V1JVUFJVT2Zya0RPRkRpV3JlMkE5Nkky?=
 =?utf-8?B?MVlpUjFzN3ZwQWt5NEFjMjkwbERCOVhzUk1pVmJENlRIVHVvK01TUDVsS1Rs?=
 =?utf-8?B?WGViSXNTMDVWRWRZbVZrMjN6T0tyM1oyaU5tY3pZV1poRklMUEQrOGFsTXIy?=
 =?utf-8?B?Z2pMTkgyL1ZCS3c4VFpLUUlGT2lKN25EVDdpOGhZOCtjWXoyUjE4aTQyZDI3?=
 =?utf-8?B?dVBjZStvR1hCOXpDTXB3RytBN0VRbHFqNEhYdTJONTNYS1BWb3pvek56K3Fs?=
 =?utf-8?B?Qm1WaWdGK0R6cW5kV1ZBNG5QS0ZEY053VTNVVmNBTnZBK1BKSWpsUHVuOUFC?=
 =?utf-8?B?elZ2VmUxY095cmE5aTU2K0UxeU1TdUpqL0pUSTZoS2pqTHZSWk9IMytmWmtN?=
 =?utf-8?B?VjVvQWtEU0hDSWx2VW53K1JNNG4yTlVYQURRRkFQTnhwWjJGSHJBVW9RTnpL?=
 =?utf-8?B?R08vM3g4NGVJMU9XbTViVXFuWlpyRXNEajREZ0tLNDdqRDhOWnRlZVU1WHJY?=
 =?utf-8?B?WE9SS2RlY0FrYmZ3dzZMQWVUUnV5T1lLeHhqbjM0bWRtMTdCSmNuSmpuQnJC?=
 =?utf-8?B?bFJmNUw3Q0FoRkFJT3BPWGtHV1lnd2R0NjlVc3JlWjBiU21LWUVtNnJqd3p0?=
 =?utf-8?B?YU1ETmw4YUc3V0UrTXIrRGptRFlNNE84SHFPRXU4ZnZtWEI2N3owNnM1Y1RZ?=
 =?utf-8?B?Umdwb0h1Y3R1L013UExuS1VuZC8vaDdjemdCM2Vlbm1kcUM3WXlkNzAxZnhG?=
 =?utf-8?B?SW95SmFKQzFLOG9CVC9DWEk1akpmMGFMdEdkNEhlSlJIYlhOb2t0VGhNa0V5?=
 =?utf-8?B?K3BSZWhEZkdLZHRaVFJTSmdEOW01RTVkQllVaW82MW9jRFJaTm0zd05SZzA3?=
 =?utf-8?B?YklRNk5UbUNieHdDaktTUmpnOC9WV1R1OXEwOC9HNytKMGlVaEhxL2FvY04x?=
 =?utf-8?B?MlduS1JJaXo1dkhXWjRUK3dhZGZTelVtWFJRRnAyVEVIUVNaREFIbTg4TU1J?=
 =?utf-8?B?aTdsZTAwUEZhcjVCUnQrTVhCL0c5MW02VXliVHhjeU5UaW1WZ0ZHUmF1UGxQ?=
 =?utf-8?B?bUdJVXg2Z3g0bGNBczZQenBRRWdBVjNzMmFDQ2FoLzhQZnZwV3dwWnJRVlRo?=
 =?utf-8?Q?sLldXjTkrsarj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3ArMlZWQ0F3TXdZcGJFak9ucUJKSStQRk9ra0hFRGhtbjdRdkdYT0YrZjda?=
 =?utf-8?B?OEZNK01jZTV1WWVMSFBiOTc5Ly9Xdkw0S25QSlZrbGJpdmd0ZGE2NG43SE9m?=
 =?utf-8?B?L1RNV2Y1cWRGd1JTWm9udkZOanVjU2g3NCtPSFZhTWFkMkwzR3dRb09sYkxK?=
 =?utf-8?B?dG5aTzBhOW40TmZlTWtQL0FMMDFEM2hCTkVXakwvODBoM1A1QmtMbXBQYllN?=
 =?utf-8?B?WDdROFBXY1RQTjlPcC8wVmg1ci9LaG53K1diendLS0h6M0ZoaGUwZEdGMC8x?=
 =?utf-8?B?SDgvcElueXlCdGs0U2FtNjBZR0hvQmNSUHZPU2JEazViZW5idndhZHRXU2l2?=
 =?utf-8?B?ankrcUlsWXRPYWFwbEIzcjVsNTh1YXVQZEZQSU9rWXJVSkp0K1F4TGg5b0pM?=
 =?utf-8?B?T0FZZkpCcVk1dDI3cG81QU1wUDBuQSsvQnNVaDEwbk90UmNtL29Xb1MvTnVQ?=
 =?utf-8?B?bUVuMkF1VXFXczdhVHBJTlNxcVk2dmxXeTlraDJ1RnBtOUtmTEd5NW4vMXlM?=
 =?utf-8?B?eTE5Yld1cTZXd1pBMXNuMUM1YUJZMk1zY3VBTXAvc0FMU3FZNWNyYVdINU1o?=
 =?utf-8?B?U1ppWGxjQTd6eXBJb3doQzQzOGxBdVUzcHRTL1M4ZWJ0aTRVUzNRK3kvSGR4?=
 =?utf-8?B?OW9HT2NhV3dRZnBHd0FHdEpSc2NmRkVXQThxMDNmZTl3Nk5rMHNNSUFoVng1?=
 =?utf-8?B?bGs5RllBZjBCTGZDKzhxSGQ3bWJTcWQ5c2hZcHpBa0JrNlZpbUxXeFJXZ3pL?=
 =?utf-8?B?ODBiNXZUUThwSHBWZU9MS25MQ0VlWVpvbURlajY2am1oeXVLWXhxclY5bjBj?=
 =?utf-8?B?V0xsNGVlWmdjRTdNZUIrTUJja2h0UkJZM2dLcGZpeDR1T0hGeTRHKzB0dUhw?=
 =?utf-8?B?c3lPS1lhdUpndXVMM0ZyNHQxS2owZUhNQnF6V1YyUHkvM0xXV1dITGNibVdl?=
 =?utf-8?B?WlEvWkkvVmZhWkVnWDBUNnZjSDBOeUxrNTU1bHVlSWFaZUZjR213ZkZRNFA0?=
 =?utf-8?B?cXVscjl6OVFOK1RxeTZZQ2w4aEdITW4xYkI5d29GZ25yTmt2V052T2ltMjZa?=
 =?utf-8?B?YkRSdWZpd3dFUmVMRFRHZ2RWdnFkNHhuUTBZWERpU0JRdFBMVkhxOUd6S0RW?=
 =?utf-8?B?K2g3aVBVZm1ncVFHTTVMRkJPS1BjSk9URWhUWGtQK2NoQy8vbFZSaTk2WHMz?=
 =?utf-8?B?MzI0ckx5b091NXhpNnZkOXVMbUJuTVpIdTBqeWV0M1cxWHJXNzNEOStXSUNo?=
 =?utf-8?B?bVFwSDRnMWpLcVNZRVdNOWo1YXVQNytlU0NQWlZyc3dYYjNsNVJkbW5YVUp0?=
 =?utf-8?B?WUViZ1RSRFVGVFg3dW1xRlpQOWhwT1ZlNzZDUHIwajlNUmZveEp5elJuMU8v?=
 =?utf-8?B?RktFMjMrL2VKelZWRUpVaXJ4cFRvN1AyOTA2SWdSWklSbFFEcTVrNUxxWVJq?=
 =?utf-8?B?V3gzdFpnVk9nTkZyRjRSUEVqTzhrcy9HdmlMelN1Z0E0QXlkSDVXeEhZN0NX?=
 =?utf-8?B?Qlg2cmpvd3gvRE5lV1NOMmJGNkhtWXUyYnE5clBlRHQ1Um90YlMxQ095TXA0?=
 =?utf-8?B?WmJpNW0rRkV3NTg3RnN5bW1EcVZFM0hoNTRzZ2hJZW9wQ1hwWHpQZHc5c2JB?=
 =?utf-8?B?Q1UxVWZBUHNEcTY5cXVhbTcvbXEyb21FM2FOemJDTlp1OW5PMGJyZ1lVWHRa?=
 =?utf-8?B?WFVzZHFWM0NtTGZNWmVJRU9NT3YyT2pQOFhIYzZhQ1pNMEZMV2VXRWs3dHBE?=
 =?utf-8?B?REEyU2p6UFNGaE5XVjE5SFkwWXBsRVRjdU01dkdMck9Ibjkyb1F4RmVINUw5?=
 =?utf-8?B?d3VDR1FleFdaUGRGKzFjdE5OelhUalM4b2lhaUtEekRublJibXlOdjI0M0xo?=
 =?utf-8?B?ZzJTWjgvcWN5YTlFSmpkMmwvQ2dvdVZ2OVgrT2lSaGdTdjQ1L3VSbm01UHV4?=
 =?utf-8?B?dmh0cUNsZWhEOGs2Mk54bVJFbWZicDJwTWdEVHRSVmV6b1lGeWx3ZkFmbWNn?=
 =?utf-8?B?dWloa0xQbytka096MG5HOVIyM0RpMFZ6VXo3RWtRUy9reGVRcGswdXY5OEJD?=
 =?utf-8?B?UHNTSTdBczFlYXZscjFJZWk4L2luODlacmRvWVFkV0FkL2VuTGFGclFicUps?=
 =?utf-8?Q?1wR6b/CiKCFxI++WKlhvAPdhZ?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 248bd329-837d-4ec9-756f-08dd3698307b
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 01:42:23.5482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbKs7L0Rv8MlV77VTQK8ZVgoee6jn6lqYUANixKPu6oyjUrD90+u099OA8/bZaUZxYN5ZydWFczEpyS7kkaMxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1809
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

Am 16.01.25 um 18:29 schrieb Daniel Schultz:
> We set the boot source as environment variable 'boot'.
> Also include 'uart' and 'usbdfu' as possible boot sources.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   board/phytec/common/k3/board.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
> index 9ff861cd3f4..ebdd5fb2abe 100644
> --- a/board/phytec/common/k3/board.c
> +++ b/board/phytec/common/k3/board.c
> @@ -148,6 +148,12 @@ int board_late_init(void)
>   	case BOOT_DEVICE_ETHERNET:
>   		env_set("boot", "net");
>   		break;
> +	case BOOT_DEVICE_UART:
> +		env_set("boot", "uart");
> +		break;
> +	case BOOT_DEVICE_DFU:
> +		env_set("boot", "usbdfu");
> +		break;
>   	};
>   
>   	if (IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS)) {

