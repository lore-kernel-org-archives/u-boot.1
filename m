Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1A2C369CA
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 13:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF4EE8327A;
	Fri, 18 Apr 2025 15:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fYSts738";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F1F88327A; Fri, 18 Apr 2025 15:52:25 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D2FD83276
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 15:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRTxj1yM3CTzOjp47EGPiVQfCXTXR2SvlJvBzQcP1YvSF3cVtSHhkH4P59+mA2vH8WWVwB3wADVfoKmBU0L53mcLQHE8mpnWsbsoMKCe8H+4naJ7bkoVyemS4RXNH5Dajji6QpYUGhd830jkSJaxE+v3gltZ6U8uI4bXl46qJVUJMH63JE3xuR/y94qZPosgYfdaheClMdPFfV5zbi92Ir1WwBIHX+dbMF+OJG0ZgdoTImhNVekHUUqLEWJhicmlTfmlkBstPeJOga2be6tkY4PKhBc9aVyUQVzhE459EMHx4/Ulex+B7WxRj4k0gOiwWrWZCGGoLOU1axsnM/SSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00vP+IlX0ARopWxAQgdh0RtQu19nR1v/PacJB2fTXJo=;
 b=Fnn6T6mSGoGWO+Jtz+KZ1ev/atcaxgv5R9UU7A0OAIouIwRzLmk7tdHitwcdZjptokTg2KSgDBzvD/mop6hPnKwLL08o8lT8yK0VW4TB3T0ktzWeLa+4cVobJN5f/yPHdrRibhTfbZF4kctNGFtv5NsJOWaEuPZe8KxtrHR3rYd/bYj3Xdne6JvYLNyMLmkXR+S7GZNfPzxcP7uFVd0bSRYl5sNh3vCDmOhxNADOYrFNIQV9vzYhxMVRxPtPDxFs4lI3w5W3QeSYsood5/pe25Hhena4Ub/uPqVFDukh+HixjM8MxyVTZOQEPT661YaTw0ExpW4wKvVLDHylrhmkUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00vP+IlX0ARopWxAQgdh0RtQu19nR1v/PacJB2fTXJo=;
 b=fYSts738Bqz/q0c7ywY2qGtGB8R5eS3ah9ichK2fZspEdxcbzJ+DaYOU5SOPWB+VrIIURzl8rTaWnUsSes6lJ33CK8EvOi6QMr5yQVYXBKc9YQTWie8I14J+jE4DgKL11slHgJFaQKtKq+7nYZC9wHi13RaBgKzA1UHETUabvJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA1PR04MB10359.eurprd04.prod.outlook.com (2603:10a6:102:449::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 13:52:20 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%6]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 13:52:20 +0000
Message-ID: <30b1e59f-9a13-40ef-8b46-cae7c70f79bb@cherry.de>
Date: Fri, 18 Apr 2025 15:52:18 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] tools: image-host: Fix potential memory leak
To: ant.v.moryakov@gmail.com, u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
References: <20250418083009.15859-1-ant.v.moryakov@gmail.com>
Content-Language: en-US
In-Reply-To: <20250418083009.15859-1-ant.v.moryakov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0337.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::14) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA1PR04MB10359:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c99e382-fc33-4194-0730-08dd7e803d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WERpcUxhSDRneDY2REQ1dTBxbG1PUGE0NDA4ZUdrSUljeUxIcWE0dk1SNktj?=
 =?utf-8?B?U2ZhQjR3VkpoR0w4SGxtODBkQkxRNG54L1pzdkdmQkV1WklpeFR6WTlKRk9U?=
 =?utf-8?B?NEpyV2tuUVI2VmZibHNvSW9IY2RnVUhNUzgvQTdqbzhRaWRZTFlkQ2dDNm8x?=
 =?utf-8?B?Qms2a2tjRkRJMjJNQ1d3d1dpcWNXeDBXK1ZOYlFwYXRMTGlMQmhqRDB4ZS91?=
 =?utf-8?B?U0dITkFoWk8vVSsxNlU2bzlrR1JzcWd3THBvQ3JPaTBrVWlsSjNhNkNIbE10?=
 =?utf-8?B?eG9WcGhYNkxUVGVRQTdqeDJzVW02bEpENUxHVUplQnpQdmF3ZGNnODMwa2lu?=
 =?utf-8?B?ajQvc0xJcjhtaTI4YnBGb0M4OURjbi9xd2wrOUxhZnFZMWUyZnRET3QzT3BC?=
 =?utf-8?B?dUZmUTJ5S29LM3dhVW03WlJlcjBxL1dLc1lZMldaeFVsTDNHS2NBRTJmcjBF?=
 =?utf-8?B?c0hVcjFHRnA0NGRlMXB5cVVTNC9Pck9LQVFHNkl5SVVieEFmWUlDZnVvSGV6?=
 =?utf-8?B?ZGplYTA5NDFCemFiU3FQc3h3TVFnRXJHcUh5V2o1L0pCMHNZQ21EMzB2VURN?=
 =?utf-8?B?UU0wekxDSHJFYzZqekJDZzYvdzF5QXB5bUFLVmtNQkJ2SmtNVjRsTDFzUEV2?=
 =?utf-8?B?STFJc0pRU05jS3Y2VS9Wdms5ay9qMFhZU2RTNWd1RGtITTIxUThJOW05TnlO?=
 =?utf-8?B?MmRVV2FoOUVUcXcxSzIvbWhHUWJYQlVXTlpiSkNnOXFodkpKWXdyT3NPeWtu?=
 =?utf-8?B?TXRzSEUxT0RFaCtzZGtVZUUvbGpNZ3A5YWJHcmdBMVYxS2tPVnVtRXRRbmtE?=
 =?utf-8?B?SUF2cnd1YVhvU3MxbndQc2RvY3F0dG54RW9RREhCSDZ6bUN5eHZOTUNzTVNl?=
 =?utf-8?B?Rm1CWjBTUDRLYWNubE1xZHFFd0I5SXlDS1FuSXNxWnQ4emtKNjRUdFJxWHhz?=
 =?utf-8?B?SHlDbFVMVVpaNXlvckwwbkFUZ2UzRVVQTjI2NlZBNnNYcUpVak04bHBWUDJi?=
 =?utf-8?B?TEMyLyt2Z1l6WmFxTXk1NnRWd1V0NmpNVmdGbGVwWXBCMCtpVmN6ejFXajlU?=
 =?utf-8?B?RlYwNHVxTVFybXk1ckFIU2tEUXEyc3Y4djdMSzIrWit0WXE5d01MeEQwRXhV?=
 =?utf-8?B?bGpya0RzN0FzaWwyYTZFS0o3dTdHQk5iZ1pxS1R2emgwYnlKbjdyNFBxbFNv?=
 =?utf-8?B?N0xJN0t4OUdGQW00UmlNYk9tMlB4QW9zWldQOEdxNmI1NzAySWJUNk8rN1l5?=
 =?utf-8?B?RTVSOVlpdHRia0o0QU1SR3llY2NzMENWTTJqNWFSMkowbzdoUE5uMEJaQmVN?=
 =?utf-8?B?R0F0dlVhSTZtNG90NjdaUnZMelkzSHk3NlZJVmwrSXlJM0V1VEhobGpCQ2JR?=
 =?utf-8?B?aWtIRTUyVTM4TFJzTlNmTytRQ3FBZEE3Uld1dDlZZEVNRjUzRlRTOFIvKy9Z?=
 =?utf-8?B?emduSWdoN3FzNlRTSytFTzgzRitVam5XRE1lYy9TUnI5czV4TmNBaTdVN2lO?=
 =?utf-8?B?UCsvNVc2SDdxdVlIUFJTOVdhQmVhZnJiLzBGZkFTZTFmY3FzYWlodGlaekRB?=
 =?utf-8?B?b0FOSHE0N3pTZkx3Qnd4cWs4Z3FwSWFwc25JOC9ET0g0QUFydHVlbzhHR2oy?=
 =?utf-8?B?V2hCOWZobi9IWUd3RWRySjVzNS9rd3JzS1ZPUHBDVTV0NXNpYkdyUENVbDJP?=
 =?utf-8?B?RGFUcHAvRFdidHZmdWZwMnZ3RTdqRHBNcUNlbVcvZ0cwMWREaHpQVXRnSWdP?=
 =?utf-8?B?SkdudzgrU3VYSFBrSjFrenFBS0I3QmYrQ1lrKzVoakVhYWhiazNvV2JyUlNU?=
 =?utf-8?B?MEJwTVBQTmVSNzJzczcwenExaXpjcjlZcXROUWU1VGhISitWS2xYdGlnb3Q1?=
 =?utf-8?B?SHdRalNMRExiMkVuVkoyT3FOdVRicmJaZk43Z1VBRm5BU3RwbVVtMHJ6dkJY?=
 =?utf-8?Q?Lr/CVkuSN+Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmpxT0s5QTNoRXpIWU40RTBTNXc3ZUlLMFB1YkNsQzdwUUYvdTVUOGpCQS93?=
 =?utf-8?B?aWFPVW9XUjJ1eXhqd05DbE9BN1VzMXY3UUU2UjVuVVg1MG9WWjR6K3IzbFVX?=
 =?utf-8?B?SlpIOVJWdVA3YUZRaG51eUozcmd1WWw4akpOREprMitpd3kyZnJTNmJhOGds?=
 =?utf-8?B?ejBJRkVFRDJSTXhIaTI5TSt1bW80UURzT3lXWThSZFNrMDR2TUs4SkFxUlpi?=
 =?utf-8?B?V3Jna1lpMTdOZExYRFBvZ2kwVUtzN2Q2bzVTZHVraEJtZkFzSTB3cG9PZTJw?=
 =?utf-8?B?dU9wY1hPRjNkNFhTTkcwbFFkNm5BQXFYVlJuUnRKNWZwTmU3RDZDWGhQNUdO?=
 =?utf-8?B?czl4amNCeHdNcmhFQjMxRlE0K1A2QWZMTlNkejlxODNIbDR5d1FlRFcvalBp?=
 =?utf-8?B?cy9FL3kybHRqUy9EMlR2d1NsOGNKVzVJK0JxSnI5M3h3VERLM3NYVnBCbTB5?=
 =?utf-8?B?YVlPaWxVa21waW1UbkNWWVp0bXBHSHJPZ01ReXZJVVNWd291RzFEYS9UeWFl?=
 =?utf-8?B?c2JLTFZnRXZZcFU4OGRJVnlJMkpwaVFYbmpHc1lSbS8vcE8wa0VJclYwbWUx?=
 =?utf-8?B?ZjVVVTR3YUYzcXpmbk9KVzBldERJYVdIUHdnclJYbmZrZ24rRTNyUWJTQ0pq?=
 =?utf-8?B?NVdoTmNNL1V4czhkRXNVNVQ1M0M0MC9kMnFhUnNOL0h1Qyt1Qkw4QVROTjd0?=
 =?utf-8?B?bVFhRmZwL2xhdXdGUU5KQzlKY1NOR2dxVnQxNFNVZE96aENmYjdlMXB3ZW9i?=
 =?utf-8?B?cXE4QWN1VWxDUzk3bndZWUc5QVluazd1bGRpQmhsWGdQbUhwb1VaM2lQMTEy?=
 =?utf-8?B?VmtVUHJiOVNYbGpqQkc0amlaVEJNUVIvYUkzYlBTcUZNQmxWYzVtV0hqQWVI?=
 =?utf-8?B?ZUI3S0ZiRk4zKys0cUQvKzQxcXJxZ0VHTnY2T0xRZVRRbTNnUldEVVNidkl1?=
 =?utf-8?B?OGR4eUs5dXFlSnBtbFVZV3pwRFlaRFZTaEZKQUo2cm1JYittWFkrYk9kcmRw?=
 =?utf-8?B?TWRJaFcwTXpoa3d1bldhT2QxQ3NUNmovaVFibC9IcGJsNHNXZUwrSVJrTENP?=
 =?utf-8?B?SHpvTW5DWjZ6SmZCc0plUDF4ajI5eGtrQ29WaldyODB3Z09nQXU1NFJvZmJ4?=
 =?utf-8?B?R2tNb3dmSGs1YTRFazcwcm5xZXdQMXBRQ3IxYXYxZDlEY0FwSGRISC9mN1ZT?=
 =?utf-8?B?VEFOKzV5QXhDR3FabnF4WTU0Y01Jc1lPMVVpTWc4MnB3Z3lac2c0cEw5VVdC?=
 =?utf-8?B?U0V5MERKbHJtdHZod25NdytXSk1nR3duYThjM1ZXV1MvRVRZTEtBMnNLc29N?=
 =?utf-8?B?VWY3cmVQK2dxa1N6MHdRQkdFeS9aM3E3Sm1PVGhPTnhsUGt1NjJyUW5GMEtD?=
 =?utf-8?B?Qm1YWXhHYjBvZkRMbGFLVnBYU3JZVmpLOUZ4WFZJVnZxT3NidUI2TkZhUDhE?=
 =?utf-8?B?QUw0WC9SMXVpdVZtVEpUUG80YkVyS2s0MzVWancxSk9tUk5RWEFVYUVsRDhU?=
 =?utf-8?B?Rmh5Y2hkc2E2UE9xT3RVcFdYeXRxNktLc0Y5YUs3WmtyTHEzdkRsUXpGRGN6?=
 =?utf-8?B?VDBqNmJtZlZQcDF2RVh2ZlFTeXppYkdqUDduUUw0N2FIRFNhbjBFTUc1a3Fq?=
 =?utf-8?B?NFZCNWJJbGd5MThieFgvR2xiZlZURSthMStxeWpGQ3VweUFoUjRSYmhQWDRa?=
 =?utf-8?B?NVFhTk5wY2FjUVkydi9KbHIzT1dKYzNUc0JVTVk1azlkenZmWXpvUlNraXhL?=
 =?utf-8?B?enE4M2JWR1loOEk1ZlF1cGhPNEt1VE9Uc1RiQ0M5RkFKNUdHRTlRMDk0REdO?=
 =?utf-8?B?WEdOcEJRQ3BXeEQvZUlBZUg4R3BGT1VkQ2ZJc1pWVTlUMkk2R0EwZ29kNExm?=
 =?utf-8?B?ZjlXcWYyNlZwK3dYY2dJNk1uK0g0K1pPcnBFV3gxdFN4ZURuSjlhQm8vRmpV?=
 =?utf-8?B?RndZcllDS1pGSFg2TFRtRy9vdCt2Q3dldSswV1RlNVptRU9hdmEzeGNxV3Vt?=
 =?utf-8?B?WERGWStnQm9rUE5ZTmpYV3N1U2s2UGVHbTVTRWpreGZjVXlGSjVQbEFyWUJX?=
 =?utf-8?B?TDFteUxxN2JGdEIyWWJQS2ZCZ1FFZHU3R3MwS1Vxck1vNjFYQnBIcjJ5WmJk?=
 =?utf-8?B?b3dMbE5RMmVPeTdhcHNNQVVDODZ3djhMK0Rld1ljYWRWc1dmSmNLbVlRcG82?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c99e382-fc33-4194-0730-08dd7e803d0e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 13:52:20.2903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snk4f6pciO+agA4Um9XQXmkYzeLwEeI7WZ4ftS3AYls667qZ+BAkNduACLtq0Jg41TgAHr8re0GPtcH7bNKxnzkBkz7Ca9JAnyYN+PAwTgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10359
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

Hi,

On 4/18/25 10:30 AM, ant.v.moryakov@gmail.com wrote:
> From: Maks Mishin <maks.mishinFZ@gmail.com>
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>   tools/image-host.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/image-host.c b/tools/image-host.c
> index 4a24dee8..453cd38f 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -1029,10 +1029,13 @@ static int fit_config_process_sig(const char *keydir, const char *keyfile,
>   				   &region_proplen))
>   		return -1;
>   
> -	if (fit_image_setup_sig(&info, keydir, keyfile, fit, conf_name, noffset,
> +	ret = fit_image_setup_sig(&info, keydir, keyfile, fit, conf_name, noffset,
>   				require_keys ? "conf" : NULL, engine_id,
> -				algo_name))
> +				algo_name);
> +	if (ret) {
> +		free(info.name);

Don't we need to free it all the time (i mean in the happy path even, 
after it's not useful anymore?)? When is it not useful anymore?

Please provide some information in the commit log as well, thanks!

Cheers,
Quentin
