Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3D0C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 10:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A190820EB;
	Mon,  2 Jun 2025 12:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VHGap//K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A122482A0A; Mon,  2 Jun 2025 12:37:16 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4932A82045
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 12:37:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dme8+phRZVeP39s3R6lqW+TQa838itESMGv+E/cVttJZcnCl8IGUSKOV5tMkv2KZZz9cJlRXSuxBR/qiq6xj8giZQn9x4X8kEWbPd2ONLHINAOTvlUWGFx3WBccnmXRlIv1mfVxkQRE/CMboOhU/0Q1KGtB5KH6i5vKIvheOaZAlhgPr/9dEojFlDdud7MoUD/9ng4+t6k9FRvVQbCWgIhLYWjhnf+jWkWyEltL5LaVS/LxRxC6vLWFHgw+hGZVkdQ9F1aQYSMkO1O2NnvLA5+H8TR5j0jy8mFgou90wLVnHzXl2NTezojuEJw1fwQ90rUuPLyNi73TV4fOYUfFjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7qBYoloEOwVJDuQjvtRiVy7cSszjWq1VNlZ8iU/618=;
 b=mx1s2t+QiCLqSOo65S0SqTNhoPvX5kNCqyGkGsGBHNyHfh8/NZQs4zfp+TDdYo7esHoAMmAhDalg+oyBpynCvsfHyX1pyeOeE5SaRqV74O8GkT/NpkHVb4lFN+tG18bBUW0WtOsH//ZPthmeYYcFGsiYTpE45h0q/QeImWosIgOnGr0TpI4+T4Ru2RC9qdwqV1HMYRjF2IdeThK2au4VkT3RS1BygRqsIjPj+qYGK9R81addqPJ7/OPEAoFZRSH0PjGeZPR1OeL5Cchoc6G+RPpRIWJS/utTQn0FNLOqRl1xE/fiXUdYi1KW72hXvQbIl2Dy0hjU32XDD0SIBPHEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7qBYoloEOwVJDuQjvtRiVy7cSszjWq1VNlZ8iU/618=;
 b=VHGap//Kje35gn8T5sFA07fgdHBcjWh77JEdCfv3OIXZZdSOcybP6XrweHywR21ikICLJdfpkWo6ytth3komzdQM5cjI18WmJLyrQ4h0L2CJKcb+h/hHRllBMcdpbKJ3Ud1qWZahsQoDkOxLBm89Ja3u/JvBNTK6G4OQyMTjReU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PR3PR04MB7228.eurprd04.prod.outlook.com (2603:10a6:102:8c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Mon, 2 Jun
 2025 10:37:12 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 10:37:11 +0000
Message-ID: <b80d6fe8-d477-430b-bf21-eb7662541c28@cherry.de>
Date: Mon, 2 Jun 2025 12:37:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: armv7: fix a bug that prevents CONFIG_BLOBLIST
 and CONFIG_POSITION_INDEPENDENT to be enabled together
To: forbidden405@outlook.com, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, Mikko Rapeli <mikko.rapeli@linaro.org>
References: <20250531-pie_blob_fix-v1-0-7b4a37987dbc@outlook.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250531-pie_blob_fix-v1-0-7b4a37987dbc@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PR3PR04MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a56832f-7de0-4a8c-526e-08dda1c16ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkMzc0h2S0Zncy80S2dma2xuOUNVeFZFcVY5NnFHaXRkTlFFbFN3WUp1MXRv?=
 =?utf-8?B?RFNsUHlhMWdPWk9LdGFrNjljVzB3UFl2VlppR2t3bzZQNUFURTlFcXg0UXdD?=
 =?utf-8?B?NGZJMDUwd2ZON3ByZDZvZDVKOWordGRwK0FHZHAwTUFKWll1NXA2azlNQlNR?=
 =?utf-8?B?N1hZZkVnK2xzN2FRN0loUHZUV29UQkNUcUgrMk8vYzhSV3l1amladjd3Tml2?=
 =?utf-8?B?VmlMMUdHMDMveU1kcVBOeVJuVHVHdkYxaHlnRjE5V2Rid1dSMld3bUp2bWVT?=
 =?utf-8?B?RjNYRmFHTUJaSm1tV3VTS2FYSlNMc1FDQUdzRlFMa2Jxc1B6NzNEZGg4RXpj?=
 =?utf-8?B?WVg1Uis0SFVMS05nV2R2NGg3NTM1dS93WTJZSW9IZGZBME00dmhrSHJZMzZz?=
 =?utf-8?B?TnVnMkVZYUw5dGRjejBqZ01ZaXMrZ0dsUnVTOVp6NTAwaE0yUnZBK2tSdEt3?=
 =?utf-8?B?L1FLQTZ6NkQ5ZXZVQlA0d3cweWY4em9wS2NlbEdkSjNoMWJBVFRRK1NRbEZD?=
 =?utf-8?B?UG9kdXJ0RVZ5Y05JQXk0L202MkIrSWdPQ0tYTkY4eFJPSlZFODhSak8zdlNl?=
 =?utf-8?B?MHArTEMxTEFWS0U5Rm5WbkR3eEh2RklFZGJkMW9XNklQMWRQUUxqU0t1K0JP?=
 =?utf-8?B?TlBzYzdmakl4OUoxaTJlRFEwNVFmZU5KRW1pckYzOHhDQ2Q5SnZEQnlGK1M3?=
 =?utf-8?B?SVVTT0dWb1lMVGJ4T0svL0NzbkpUOWRxVEZ3dnVjZWpqS0w5UnE0NkNYZHd3?=
 =?utf-8?B?b2hsUGM1Z0wvc2VLaHFBZVRubnRrOW1YYlVtcnlNNTYxeGszSDR6VjI5WmlZ?=
 =?utf-8?B?aExZQVNyUUpTUUZYd1puN2g4Rlhib2VVUnBTbDJNY29yV1ZNeE5TWnM2ZVJ3?=
 =?utf-8?B?OW9iYmxXYVhmNlRzeSsxWmRYUW5NMEJlYnlqRGJYbHB5cGt6TkRCVlVoRjBF?=
 =?utf-8?B?WkdkWmZhMG9MOEVOQXdLcVJ5bHBQRXB1Yit4b2JWUlR6ajJmbzgvL01sWUpG?=
 =?utf-8?B?Mzcva1I3UnJqUzRjcVZEVXkxV1JJTjRENW41aVU0eEN3RUVvZEtybTdyemll?=
 =?utf-8?B?Y1U1cUd5c0x2SWsvL2M1RkZwYTIyN0k4ZGc0VndmZGt0OWEwS3dYa0pMTWIv?=
 =?utf-8?B?NHY3Ymc5U0huVk5uNE1TbzRqbkJBZ0w4b3AxV05RQzVma1c0dDVSWjJsTVMx?=
 =?utf-8?B?OVpwY0Q2Q0V2RGtweXowV0J1cDZJbWVreHFETmM5MmQ3RVc2SFl0N0VMaTJB?=
 =?utf-8?B?aXE1MlhleC9zNUp2WkkrTW9zQWpyNjdCTEthd252bSs0T0pSUnVwOGZvZFFk?=
 =?utf-8?B?eEp3RWlyaXRvdU01Z0NSSEZiem1DVEV0cjJLUDVZRHc4MTlBTXB6NkptM1RW?=
 =?utf-8?B?RThkYXBkRDlnV1hRMHk2Q0laWGQ1RVRGYkRmMXlTNVVFLzFuOWx6UVRPczc1?=
 =?utf-8?B?S2YzQ0thMTZ1dVY4TFFWUHhCN0RCRWEreEF3YjRSRVd6YzhZdkRYVUNxWGQ0?=
 =?utf-8?B?L042UzZHZVU2NnVNeDJTOTZ6ZkV2ci9iaXNmZXVaR2FHcHd6OWRPeFZwVFl6?=
 =?utf-8?B?bXhwQlJqaHR6NThYYThuTjR0VGROaWpTVkpWYjY5SXFiN1h2MVhkd3ErVjNi?=
 =?utf-8?B?bEdGeVYreDAvakZVUTNDN0RaV2l0YmZVZUFCS0t3VERWUjJqbVhaMVVxNGlw?=
 =?utf-8?B?ckdocHlVcTFXeTljencxZHNBWWVKNGpFSTl6SkJ3WGdYUVM5bllaYm1uU3lE?=
 =?utf-8?B?QzJYVlBsa2tpdXdBYjlRLy9DcG80WVhXRW1xUXk4aVI4bTkvSTNyWXhSU1Bl?=
 =?utf-8?B?ZXRVMEFVVFp0TVAxQTZCWWIxVzE4ckRwUTUydWdMM0R4TG0wUVFpOTNZL3ky?=
 =?utf-8?B?aFlLekxVOWs1MmVaQ0I5NE5LNDcyV2RMZ3JBTnY0emhkcWxPdWlUTGVQZ1kw?=
 =?utf-8?Q?F4As6hTc9TY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnBvWThWamsranlRVllmakEzTkVwQUNBbTZEKzBVWXJjeEY5T0l0UTVNaU5z?=
 =?utf-8?B?V2V1a2NBb1JGeWc1WnBRL2ZFQjRmTkJmUWpNVVJOT3o4b2Y2RnJ1WjFOMEJE?=
 =?utf-8?B?MnNWTHB6MzI0QXB3ZGtRZXRSZVNzN2pZeHpSb21VU0c4aVp5cTdvSXRiQjZw?=
 =?utf-8?B?Q2JBMG54MDFmSytCUnhXd0tZYUlXZkpKR0Y1aTlWS3NHZlNqS0tvKzB5VFhN?=
 =?utf-8?B?ZHRWbnpZci91R3VMejNEenp3TWd0UmgvOXVhR0JRbVBqZThsQU5haTBtVTdt?=
 =?utf-8?B?VkkxMk0xVTVIVlh5NlVOQmVQNlJOdEJiMFQrdGQ1Tjh3VGtpQTVqU0FJVFFY?=
 =?utf-8?B?eDVQbHVFVmJXYlFBbFdVcURzUGlZdWRHQ085RFNoVC90YzlFSnY2dWpGR0ZM?=
 =?utf-8?B?blZ3elAyNWxwc1RaRHEvclVkQUs1N0JxbURhcktDUCs2VThieDN0SzNXdWR0?=
 =?utf-8?B?YTFsRHhtRjl3YUxSdWlOK1NkR1AzT3drVUNXSE5tZXAzWW0wR1dUTDJIOGF2?=
 =?utf-8?B?S1FqUGpnWTVZS0VZYVVVSm5IbE9RSkFwNTUyenVOZ2lUZDV0a1gzeGFwSUxo?=
 =?utf-8?B?cnBJK0RLSldQV01QRVMzSFZPUEwvbXhSSnRFdVEyTTNZNERQNUY0a0hIazdF?=
 =?utf-8?B?UklPb1pFa0NwV0tBSklCaGIxY3NyaytRT1ErMzRvVFpNb2k2S01nVG01ekZK?=
 =?utf-8?B?UHp4Y0d4emxJSVV3RFlRWEpXbHQwWllueEFzQldmY1BjL0d2WVpPRHlvcFkr?=
 =?utf-8?B?OEdkbWNnM3VqeVQ4Yk54dmNwdE5HVnBwVkF5RnJzcmcxOW9xSVlmODllM0lz?=
 =?utf-8?B?dm9nSkNXT1RBd2ttdzRYODBZcFJwQlhKNEJ6dExGVXZJM3YydGxoNjZocjNL?=
 =?utf-8?B?cWZNVkdYWFRqOHAvNFlBWEVCWDNucnU1aGFOVFVzQ2V3bDVKdXpiQ0tkK1Iv?=
 =?utf-8?B?M2V3WlBGYWtxL0lWT1hzZlBzaUx0TW5oMncyZXZTKytlcy9UNVlhOUVRQk1T?=
 =?utf-8?B?bTYzZ0FDTndzMCtqenpyZUlqQVlqNFNvMTBSUjJ4bUQ5RWxXU0R6dW5Jb0th?=
 =?utf-8?B?cXF6Z0hUcjRCOVkrRjZITEZvNEx5WkVKR1k3Skgyaml0WnowOW0xeUlNZnd3?=
 =?utf-8?B?aExaTzgweUZ0YUk1WjE3cFk3ZlV4b1Q1YUJ2LzV2c2F0ZGl5Q01LMVB0Rzg5?=
 =?utf-8?B?QUh5b2xmTW1CUzZ1SUg3NVJZY3VXazkvcjdlc2NKYlBjZkNBYWJsU29uYzZj?=
 =?utf-8?B?RUNMSldPdXRTWkc0eG5EZ0FCZTl3THlwQkpKbFNTWVhHVkhtNDNMamNXUHpy?=
 =?utf-8?B?QkltQjQzZzVOMDc0b1grSFVOcncya3l0MlhkRHNzc1hmUlpOLzUzak9VVDVZ?=
 =?utf-8?B?MGViNUI2a2Y3YVNFdUNQNkhaQkVKQ0lENWQ1M1FWWWRpcjJsYVU5VjZwMmZZ?=
 =?utf-8?B?QjNnMlphT1VwVy94RkVwcUhNblA5YWZlcXk1eGhNZXNXSzhJSE1pbnJCaVAy?=
 =?utf-8?B?bEVtNzJYYzdJaTNyalB4dlFHaTAyclloWEJOUllDeW42TVZXMVJoNGRnWFVI?=
 =?utf-8?B?K0hjTUpJT0UrWHNrRVRmOVdqeGhoY2RIWmhqbi92ZFN5NDg4MkRNdmI2UlhX?=
 =?utf-8?B?VFQwTExsQVdVQ3QyOGhUMVFEUkxOMFRGdWpmQnM2QW8rRzJqeGlWTTRZNUpI?=
 =?utf-8?B?VHFPT2FaQ3oyV3VzQmV5alhwZDVycnpaTFZPN2VvUTQzdVFkb3VMeTZTdW9H?=
 =?utf-8?B?cytBZGg3SXhzOHVPam9SNUdRa3lyaG9PSUZWMGMwZlNCekdvenV5RGxtNVlS?=
 =?utf-8?B?dVhubU1MQzBOU0hZbWFlVk5mNkFKTm5UZTF0SkhqK3pxOEF5UDNxcEFvaGhH?=
 =?utf-8?B?Mk01dnpGMFBZZmJxVk1tbll1M3RyRE51cU13OXJEaHBHUGtrdk9UWGh0VmVY?=
 =?utf-8?B?VFUrNzA2ajFIcWF5MHhUL0wrZjcxcllsTVBjR2U0TlRHQUV4a2RJUHkwckxl?=
 =?utf-8?B?SVhDUjlmY29HakpqZVM0OWM0UFVYeGxPelVzcnZlYnFBM3FBdGRrNWRuTWRr?=
 =?utf-8?B?TFJJZktMNkVhb25WYXd1bFBobGlsL2tXVGVLeGFGNnY0dXY1Ukl5cDZpT2V4?=
 =?utf-8?B?cHhUY3ltNTVzUkJ1ZUhVWmF6T09tRTFhak5QTGxXYkExc3lIWmEwL1hXQ3dn?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a56832f-7de0-4a8c-526e-08dda1c16ed7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:37:11.8205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyevr3oWtwdh0SgzkReZJ7+wNU3lH8ZqunHDep0uv+xGoXRPo0kiy9DjOlDANzrDONmjEeDzhq6p+cT+SH4QLNrm1wZ55du3dkb8JqkpmOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7228
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

+Cc Mikko Rapeli who's attempting to patch this in OpenEmbedded-Core

On 5/31/25 3:10 PM, Yang Xiwen via B4 Relay wrote:
> [You don't often get email from devnull+forbidden405.outlook.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> This patchset also enables CONFIG_POSITION_INDEPENDENT for qemu boards
> to avoid similar issues to happen again in the future.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
> Yang Xiwen (2):
>        arm: armv7: restore section to .text after saved_args
>        arm: qemu: Add imply CONFIG_POSITION_INDEPENDENT
> 
>   arch/arm/Kconfig           | 1 +
>   arch/arm/cpu/armv7/start.S | 2 ++
>   2 files changed, 3 insertions(+)
> ---
> base-commit: 93905ab6e7564089f5d7b703b660464d675e5ab0
> change-id: 20250529-pie_blob_fix-a61229c8fcc6
> 
> Best regards,
> --
> Yang Xiwen <forbidden405@outlook.com>
> 
> 

