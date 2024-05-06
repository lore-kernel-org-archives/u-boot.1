Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E2DC10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 15:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0770C88662;
	Mon,  6 May 2024 17:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="d2ibuiGv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E68BA88684; Mon,  6 May 2024 17:52:36 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20721.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::721])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C20688865B
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 17:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEsyWsuiuui9bM361n1KEBCtGhh/u1VqQ+1B5YGT1pCdlWVUIBAgJx5eSPHciHUI49tINNP5LJ0QPN20ZO9DGxPNClZ3QF3BIRfO1Cy5wijqItELBAPuyyW/WEHWPtql/pYI5D922BEivoJZdvuF7rgekdi/7NJ4YrdESyN7Rigyra2P9cUzw6Mpxdlyt5VI3PDrII7cpXuAe5KKRuIxMgzOTBtF+yAGxJa9P1GYW7Xx1Otw6ee8IL3AkLjADWmfh5R8oNqvb4NCgkIKwYeL/Y2uf8pPtATUtvwsHk0AIzuwODkEh/bAx+ZcXNjNryKsmKfj5NdiblM6tfAH/cHI5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOWaWbG/cY5RFBBOc74cPIUd6dxwO2DhZd4uDevLmKQ=;
 b=Y8jABZ/+Rih4Sj07XnYohRCWITgyLv2wrHMvO90DWxsKRYGEvdOOsrv+A8V6gFpt0YHxrBIIko+VKQGQokpeTOpKWy8zNXWbmYiIv081OpvcW8kfsZDsUY27s1seecQa1XTbBmODIVPAKX4dYJGoc63i3U+vXCIFOiW1UM+T19sBWWz+jvtYjVrHRRt5WaCPst+UOa/oJwbW5RqDyp6zg7/kivEXCjhQ9tPcr+OZ16Ucze8S0on167afSdDpeCXPwCQme92bgUtr2ka7COSePm4esmXk9tqWXlX0bPwSbwWuG8tAs12V2TZv8fJHv/C4/Gd13ZrNHjokDXQ4eH1avQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOWaWbG/cY5RFBBOc74cPIUd6dxwO2DhZd4uDevLmKQ=;
 b=d2ibuiGv8gELR2VmXm4HhG7a+mgI5QEf14cI2nOBBSiMlkOhWcqtkiI5FuKcl1edpbqQ46Y2V8lYC2hKeE69eG+J10x5j/E5JpHw5hDdmj4djatyiILMx1amZ8vTyL80rkWQ0wuZMC3IiquYiBLU9NF96BXi5lLh6YWV3wf0ffQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by AS8PR04MB8753.eurprd04.prod.outlook.com (2603:10a6:20b:42c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 6 May
 2024 15:52:33 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 15:52:31 +0000
Message-ID: <cb0085b5-6a3d-4223-9336-4349854e4a82@cherry.de>
Date: Mon, 6 May 2024 17:52:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/22] clk: rockchip: rk3399: Improve support for
 SCLK_PCIEPHY_REF clock
To: Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20240501162308.875193-1-jonas@kwiboo.se>
 <20240501162308.875193-4-jonas@kwiboo.se>
 <b0152407-ee06-4c5b-ae5c-210a474ad598@cherry.de>
 <baacfde3-e0ee-4bd7-a85e-5945ec2a85e8@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <baacfde3-e0ee-4bd7-a85e-5945ec2a85e8@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::17) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|AS8PR04MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dcbaea3-b194-4798-d3ce-08dc6de48999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWNvbkM1MmppWkZCeFNUT3pvejZGREhHaHNmWUs4L1p2MWN1SUl3bVdjZTFL?=
 =?utf-8?B?Y25zQjl3SksvTVo2NTFleHhhMWhUbFdHbzhrVkFqd0xqemt1dW9tU2k5ZVNQ?=
 =?utf-8?B?d1hwSk1VUkVHckRiY3pDdUJPMVdUVjZpOVdWNjdNM1FJRm9yVGQybk9FellY?=
 =?utf-8?B?SHBKbVcxOTl5bVdqeDJkTzNTanZYc2FYV0ZYMEVkZEtuVkp3UDBRdFVNdU8r?=
 =?utf-8?B?V29DUGVrOG8zVzl6L2xOTk1KZXorWlFaVjFjUnR0QzYya3dVNzQyaGhCUmlX?=
 =?utf-8?B?M0lNazdsWkx4SDlYeU5zUEZHS2kxaWdBOWI2NSs0NHM5cWVWbUhYdzM0TDFW?=
 =?utf-8?B?ckNZc211NjFUcDBXa1FId25nS2I3MWdwVndkTXhsK013THJZV3lKcG5EcTNW?=
 =?utf-8?B?OElYdmwzZDRtME1LUXdIOTZyWmg2VW9OcmNXdkYzMzVpSWEvcjVYRmhLQ0tL?=
 =?utf-8?B?bS9TWjZNL1hrVDE2akFmN2dLY2twbkVNa1RENEFqek1EY3l2dTlPOGNKcEMr?=
 =?utf-8?B?c0JsbU56YjgwUXVaOUhzdTRTVldsTjdFTlV1RHZKd28xVmpkYUZOdzYwSlEv?=
 =?utf-8?B?MVVVNGdUNkViZkxqVFdyZVIyeFNkK0VCZGw5NGgvSzVJUHA0elUxK25VQTdK?=
 =?utf-8?B?WVJtZE1CNFJHM3BvTFBNa2k0QlBPZDJLbXZ3dGwvNnNPRHcrb05EV0NGcFMy?=
 =?utf-8?B?TWU2UFRFamEwMTZMNFlOUWJnejJKaU5OOFZRWEh4SWVIbHBTRWtSNTZiUHRi?=
 =?utf-8?B?Ym95RUJZd3gvK3FqbzlaTU1FN2JlQ3NUOVdiTVMveDhXUHcxcHlXVWc4cFE5?=
 =?utf-8?B?QmRGUnFadkVRN1R2OEg3R1hJSk9sRmJrYlg0Nk9uUUJDaW9xdU1yLzR3b09v?=
 =?utf-8?B?UDdmK3JEdjN1cDRGUVU2cEVvbU1IZGovT1g3dGpaZWF1aUZMVkNSUjlGbHMz?=
 =?utf-8?B?VVNmbTJkdFVUSi9ZTzdobUs2RUJpb0RsUlNpeUYwOHFadHZFcnpISHZWUWJH?=
 =?utf-8?B?MlBZWjlsNTJiQTFSQVdab2dKQjQvREtTN2kvKzlHdGV0ZXc2dWV1bGlESEpZ?=
 =?utf-8?B?UERsMGc5REVMa21mMUw1bHltUERBT2V3S2tFWE1MSzZrcGIwRjVpS3RGU0dn?=
 =?utf-8?B?Sm41VU1lQnJpQUxTMW0xaCs3S3JRUC85NjUrSUxKR1VBTC9MRXlHdUt0dlRG?=
 =?utf-8?B?WjEwY3ZiYkM1b3dSejBIZ2FJL3pONmc5dC9xOHNta3FYUkRzdWM3d2NqQm95?=
 =?utf-8?B?enRHVjRHRjhRenJKd0VQRk9aRnVSYUNObk5Da0Y0MU5xb2NlRWxScStrY2dI?=
 =?utf-8?B?NFg0VCtuc2ZuWUNsczBJNmNtU1krSG1ZR0VvQU5JR25zYlBrY1FkeG9nc3Vk?=
 =?utf-8?B?V0g5WE45UzV5VFE2QlhWOVJqWVNldE9lbko4VGxOR2VLc0N0S0JITUx0QUxI?=
 =?utf-8?B?SG5KZndqNW1RWTJQWXI2YVR3Zkh2S3c5WGhYMjc0eVlOWnhuTVBLckVEWUhv?=
 =?utf-8?B?a3JtQlpwVGZYSmwvVXRqelp4WmNOb2hNNTlmWkdZck9HNE52ekgzU1F1YW5X?=
 =?utf-8?B?NFI1aXhuN1RZeHVxOUI5V1ViT0hFczZCY3U3QjI3b3FuWWNzYzNRci9NMkRO?=
 =?utf-8?B?Rnh6TGlnSWQyclcrK3Q1Qi9wZEJ6ZGZraU1oZGZYZ1dmS1dDOW1EV01GWW5r?=
 =?utf-8?B?TmhrM0t4SnRQZUxEU3ZKUVExQnQ2Qm9CSXh1eEw2VjA2eTdhYXp2elhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnRSdzEyMGhxM1Y2QnRIVnRQcFVuTDRBMEJ6ZzhWMFUrSDUrM0tna1czdE5L?=
 =?utf-8?B?WU93eTIxVXpJamk0Q0pxV1ZWRk8ya2ZsUVJsM0VXTGZIQW9uUytnYXVIZjZF?=
 =?utf-8?B?VnNlTEVTdWU3djB1NFduaENZVjhBRTV5cmN3bFQwaHcxRWVMMmhiOUFQRk1U?=
 =?utf-8?B?K3dxTUd3LzQxV1dvblFtZ1gxTThJRjRxdW4zTDBUNUV4eEhkN2lQYzAxSHM5?=
 =?utf-8?B?K0xTbTMrcXA2U0tiTkZWVEV0aE02V3RueWFEeVNXWnRpbTBrVDdCWnZDb1Yx?=
 =?utf-8?B?Wnd5TEtpbkVFTHJvNG42UnBBajBTck9MUUdvYkpDMklBM0lkTTVRWUVWNjhM?=
 =?utf-8?B?dVh2Q1VRVm13ODFDS2V3eXRXTVlOQTN1Q2Fpa1hzaDViNFpoN1prdjh2K3VP?=
 =?utf-8?B?U2UrMHM0ZDk3a1dmcjF2UVVXVXU3YThrTTMzYXBsM20wb1NaTkJ0NDFWR2ZH?=
 =?utf-8?B?Ukc0cERJTHpPRnRHQWZYMW1aTHRYekFtblMzL3gxZU5oeWJyOXA2cmFvdDJE?=
 =?utf-8?B?dkdFNXg4TzFLdWo4cXJTZGg4ZkFzK3hCSUMvRVZwNEZZRytwSnZhN0VUQ2ND?=
 =?utf-8?B?VFg1RURBK1NmbWhUeFFKd09Fa3M2L0xPdE9VcFhvQUFyZHRYRVVaTnVpTmUy?=
 =?utf-8?B?dCtSc1JnVzA1bjVvSXJORTZxdkxPL3lKVVhjZTU3OXFvSTBIYXJpTlpoRU03?=
 =?utf-8?B?YkhyTTVGbXJMT1l0bUloa2JZWWZ4ajhobW5JUGhzQzU1cm4vUmNScXRHNEtK?=
 =?utf-8?B?eTlLRDdBSEJYTnFONytiako4QWtQMTVkNFhpVUJHUkVDQXJyMFJCMkFQYk5P?=
 =?utf-8?B?WkpnQjdvY0Z3RVBkYVJRaDlVM0p6bjhGUkNpQW5EWVI2VHBDcVFVZ2ZqK0pE?=
 =?utf-8?B?K05UZmx2S1JRYVhIQUIwajhhUDhRUWJYcUlmWmFMcWd1M0RCanRQOTBRVVRv?=
 =?utf-8?B?elBiTitkVnYxRjhvYVE0Q2NxUk1rTVNKTGp4OENQSHFLbG0yTUlBNTV6WHIx?=
 =?utf-8?B?dGY1WEhOazJwTC9Ddk1yeFJtVnNQd3JmUkh4UjBBYW9NSVA1dDZxdXhETnpJ?=
 =?utf-8?B?S3pUYW9iTGpWY3ZpYStpWFB4R0hUVUJNL3A1bHBXeHBDMFFrZXFwV050alBj?=
 =?utf-8?B?TzZPVnE5dVRYb1ZoclE1L3IrWDlocG1GQk9uai8wbUhqeUN2YVBYaVI0OUlw?=
 =?utf-8?B?RStZSTh1Ui9pbVQ3Z0JNNi9kZEFmUHRQYnZKYVJpSnlNNU16bXlteFUrSXY2?=
 =?utf-8?B?RDhtaTY2M0NXMjJ5ci9xZkZ2MG1TY05FaXZWNk0xMjRwTXMwaXZ6WWJsdmta?=
 =?utf-8?B?TE9OVWxZWUF5VUJxR3NlN01VWHhndXJLSGtUOUNKeGRYTHYvTk5uT2c0UCtI?=
 =?utf-8?B?VS83a1g1aDBpZ3g5OTQ5cVQ4eGpZRG9BNmJWRU9vK3ZaYWJ2elNHUWxIODVr?=
 =?utf-8?B?UUZUWjBYSlhTTnZDNnJnanF0N3A0MFZDNTltSWxoYmxmMnhnMXdkdCtUb2o0?=
 =?utf-8?B?YVB1TUxaNFRVWEFaeWlpNEtMaHdvM0pZUkNZaTI0UWxZaWgxNTQzV0cvQVpR?=
 =?utf-8?B?disraktOU3ZhbXh5K2xJYlFkYTZFcytpSFBTWHR1ZUF1VU5BN2QzMWR0cEh0?=
 =?utf-8?B?WDZGczg3YmE5RElBSVJSaGQvWW1zVHc4cUhhbFY1Z2p2TmdtT3g0MHk2M2Yv?=
 =?utf-8?B?aTdabEk5dkkrL20wb3l3U1lHSmNrbEhiVFRqUVlmZVV1eXhXK1FzVkFFV3Yx?=
 =?utf-8?B?b2puZzlSLzMwa3ZmalVEdHNNRUxLR2xSY0pVTmdjQ3UwL21PNU90a2dJQ3l1?=
 =?utf-8?B?ZGMxSTQxc0Z2c0MybU9DTzJNUFQrTUlzSTdhZEN0aGRMa0x4YXZWbVRQeXYr?=
 =?utf-8?B?eS81MkNpWW5JWUlCZ01lZmlVYTlEcFlpYWpwTDgzUnp5S3dzSS9aK3BWN0wr?=
 =?utf-8?B?YmF2UnZCUVZsRWY5eTdlTGtXeDRyWDIwVFFPWTVRZXhLUXE3U2lhU09FaEI0?=
 =?utf-8?B?ZDR2cnNsN2UwSGYyY3ZHaU1YK2tUV29qelduMEQ0Y1hoYXRCWUdpbWpRS2to?=
 =?utf-8?B?dU5NVldGSkw3dFV5bTNiK09wNDVYMFlBM0JYRWtZVXo4K2ZHYXp0eEh5R2lH?=
 =?utf-8?B?WXduV0dHN1dQcEtiYWI5ZE9oZFJpTVlMeTdRbXBobG54N0ErUmZMY0Z6V1NE?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcbaea3-b194-4798-d3ce-08dc6de48999
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 15:52:30.9725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ciYzLY2jecv+oeIGnwWE9V2NzgJtR09oiSoYIQRCZ4Hov+MR3CPXhW+eDGOL+omxzknXxsN6bxKrcGcHJekaC7hwDXcXXrx0lHjPPpiqWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8753
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

On 5/6/24 5:17 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-05-06 13:07, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 5/1/24 6:22 PM, Jonas Karlman wrote:
>>> rk3399-nanopi-4.dtsi try to set parent of and set rate to 100 MHz of the
>>> SCLK_PCIEPHY_REF clock.
>>>
>>> The existing enable/disable ops for SCLK_PCIEPHY_REF currently force
>>> use of 24 MHz parent and rate.
>>>
>>> Add improved support for setting parent and rate of the pciephy refclk
>>> to driver to better support assign-clock props for pciephy refclk in DT.
>>>
>>> This limited implementation only support setting 24 or 100 MHz rate,
>>> and expect npll and clk_pciephy_ref100m divider to use default values.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> v2: Implement partial instead of dummy support for SCLK_PCIEPHY_REF
>>> ---
>>>    drivers/clk/rockchip/clk_rk3399.c | 59 +++++++++++++++++++++++++++++--
>>>    1 file changed, 57 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
>>> index 5934771b4096..0b3223611a32 100644
>>> --- a/drivers/clk/rockchip/clk_rk3399.c
>>> +++ b/drivers/clk/rockchip/clk_rk3399.c
>>> @@ -926,6 +926,26 @@ static ulong rk3399_saradc_set_clk(struct rockchip_cru *cru, uint hz)
>>>    	return rk3399_saradc_get_clk(cru);
>>>    }
>>>    
>>> +static ulong rk3399_pciephy_get_clk(struct rockchip_cru *cru)
>>> +{
>>> +	if (readl(&cru->clksel_con[18]) & BIT(10))
>>> +		return 100 * MHz;
>>> +	else
>>> +		return OSC_HZ;
>>
>> Could avoid the else since all if blocks return, no other logic than the
>> one matching the else can reach that part of the code.
>>
>> Therefore:
>>
>> """
>> if (readl(&cru->clksel_con[18]) & BIT(10))
>>       return 100 * MHz;
>>
>> return OSC_HZ;
>> """
>>
>> works just as well.
> 
> I was considering above format at first, but chose to align return
> statements for some reason.
> 
> I can change to this format in a v3, if needed :-)
> 

Just a matter of taste :)

>>
>> Could also be
>>
>> """
>> return (readl(&cru->clksel_con[18]) & BIT(10)) ? 100 * MHz : OSC_HZ;
>> """
>>
>> [...]
>>> +static int __maybe_unused rk3399_pciephy_set_parent(struct clk *clk,
>>> +						    struct clk *parent)
>>> +{
>>> +	struct rk3399_clk_priv *priv = dev_get_priv(clk->dev);
>>> +	const char *clock_output_name;
>>> +	int ret;
>>> +
>>> +	if (parent->dev == clk->dev && parent->id == SCLK_PCIEPHY_REF100M) {
>>> +		rk_setreg(&priv->cru->clksel_con[18], BIT(10));
>>> +		return 0;
>>> +	}
>>> +
>>> +	ret = dev_read_string_index(parent->dev, "clock-output-names",
>>> +				    parent->id, &clock_output_name);
>>
>> Are you sure this works?
> 
> It should work for the clk reference I tested, <&xin24m>, where the id
> will be 0, it should also work for e.g. <&rk809 1>, id will be 1.
> 
> And if a &cru/&pmucru clk is referenced those nodes do not have the
> clock-output-names prop, so ret should be -EINVAL (or -ENODATA).
> 
>>
>> Considering that parent->id seems to store unique ids, like 167 for
>> SCLK_PCIEPHY_REF100M, I doubt we should be using it for
>> dev_read_string_index????
>>
>> As per documentation:
>>
>> """
>> /**
>>    * dev_read_string_index() - obtain an indexed string from a string list
>>    *
>>    * @dev: device to examine
>>    * @propname: name of the property containing the string list
>>    * @index: index of the string to return
>>    * @outp: return location for the string
>>    *
>>    * Return:
>>    *   length of string, if found or -ve error value if not found
>>    */
>> int dev_read_string_index(const struct udevice *dev, const char *propname,
>> 			  int index, const char **outp);
>> """
>>
>> So index here means the (index+1)'th string in the list of strings under
>> the "propname" DT property, I doubt we have properties with 167+ strings
>> in them?
> 
> I would expect the function to return -EINVAL or -ENODATA if it is called
> with an out-of-bounds index value.
> 

-ENODATA it seems. -EINVAL if the property doesn't exist.

>>
>> I realize that rk3399_gmac_set_parent also uses this, so I'm a bit
>> puzzled right now...
>>
>> Don't you want to use
>>
>> dev_read_stringlist_search(parent->dev, "clock-output-names", "xin24m")
>>
>> instead?
> 
> I think the implementation is correct and is what other rk clk drivers
> do for gmac set parent ops.
> 
> Using dev_read_stringlist_search() could possible match a name for
> "wrong" clock, e.g:
> 
> clk_ref: clock {
> 	#clock-cells = <1>;
> 	clock-output-names = "xin32k", "xin24m";
> };
> 
> here only <&clk_ref 1> should match and not <&clk_ref 0>.
> 

Ah well, one more brain fart :) I somehow mixed things up and was 
thinking about the values in clocks/assigned-clocks in one node needing 
to match the offset in clock-names of that same node, which made no 
sense. But we're talking about different things here :)

I guess it's just a matter of taste between the implementation in your 
patch and the inverted logic which tries to find xin24m in 
clock-output-names and checks its index matches parent->id. Consistency 
is preferred, and the former is already used in other places, so let's 
keep this.

Thanks for taking the time to explain.

This does seem reasonable to me, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
