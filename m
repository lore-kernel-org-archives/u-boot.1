Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA65FD8FD8
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 16:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8846983F3F;
	Thu, 26 Feb 2026 17:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="i956bWsc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8862583F53; Thu, 26 Feb 2026 17:59:27 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48D2F83F37
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 17:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8UlqNPhDWBl4hVcGtlr0z24mGE3X0MwIc8HekUgxBhUStMv7NNbIKo3+6LO+MI0mPRk3E0g72Un9f/3subAmY9M0AlkAWrFCs44nXuLqXvv4Uay83roZAX82OX6ho7SmUxoXb+z44K4TTRv1yWIWA+UtABwx05uoCamxQP5U6lkaz0dI2KDsFhnryfpsG6wtwplU/nQkMgnmmSTMLpLPmSqAi2hxEMNF1lPKyb22QWuKVuUjJ59neNf2cnxVVuQZvAdVsDDs7kpA9yMAdnUw1+/5yP1xVDj/n2Rdtt7pYuJEYrlIFy90o7k4ubxH72XlKKc3itBSdOFXD0hAXT99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVi8IdICWVSwy+kyPt5P+Y6DfBS7AnTbDoKzFODhMoM=;
 b=Z4dpQhvDGIHvRrn7Eiruyv1gTX+XUqpC5g/HpNjTMMlGAaf0pX0jSjOU714Guc05zWD4yCP/qytYQOYn+q4h0W+VgGlu8ySwPytM8Z9fvcXiQ6Z2hQDk45xpgkXdWN7ThFDaYayBaFeC3Yn/nitaKoy28mFsFkp0SpBH1yCI/I+I7udCbuevChsbinZzL2i3oy5gCgqXLfVCXOC/b+AJIoKXlwzQ4QmIeRy3tLssKw5L22eSwbDliC0I0gibCHJ+UdpIuV51vYYtHIlpbQWFtCn3CiEJFGMXGFrQqbpo26CMhz8Rw5huhlYSd/mWwO6az4JHKIxlut2pGcqixW4W6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVi8IdICWVSwy+kyPt5P+Y6DfBS7AnTbDoKzFODhMoM=;
 b=i956bWscYMRwBPVPl3ZJJfR6uhuHHROu/Z+EODPh5aTwQPgc0bOS/+K3QjWjrdNunMkl65i38qTZu8/LdjqB1wztUtiC1T7FphWwnIkkpEc1XuDzwFZRagupsqve+lM5tcN3JGEXMtFb6FGkDqFbFtZIZabEFG9SgAk32fGVDRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 16:59:19 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 16:59:19 +0000
Message-ID: <02072824-7144-453e-8a8a-114b649feecd@cherry.de>
Date: Thu, 26 Feb 2026 17:59:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: ns16550: Fix return-type warning
To: Nikita Shubin <nikita.shubin@maquefel.me>, Bin Meng <bmeng.cn@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Aiden Park <aiden.park@intel.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
References: <20260226-serial_ns16550_fix_warning-v2-1-738146c5df53@maquefel.me>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226-serial_ns16550_fix_warning-v2-1-738146c5df53@maquefel.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0086.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB9PR04MB9377:EE_
X-MS-Office365-Filtering-Correlation-Id: 71dc9325-685b-4fee-a14b-08de755861d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: Q5SYxtg5kqeRvGMYZxp+lGlZdL0DvOD05U4vWeFaRfuwRzU+ZjCScozg9A0NaSWVprizeZJwzoVbt6RyXdu2UAMIp9hWGNLPDweqkf1M8Q4YqIY4Lj5FyOdGhCJTaeeDCMhf2r1N0F7s7IgwKazJBavKVuUHVNmgLFLrXQGNykr/gW9Bsk9GxQlksrSujhKxv3dIKxuEOeGI3xHnecmIs57VEEhF+pYjoNbRtHmRSdp2Wp/lXsR8rk7xQKSUFOmO90rRi6MZgiHXE5LHcakPvL0ozYMjNIfHri7Fn3g1hj7hiKp25QNKnLRnRbqTeDSgNVjEW5XagMRL0OFKvlKToflu81lPprCSkdkZW/QQOghqekUNsKr+3qnQRWwPC4g8Obk6Xr6WLc4+8c035HE19TSX5Z1hR1gEsHJlHWxY0VI44U7ig5scL3dsLewP4vo3xl8ob+yamDXMpmsghP6vM38ZxexiruWDr6KUOU8y9KXq9V9Rt4qNkaqTs/G9OquuqY1fRag8jRCmgNtm10uVmoOlePMtduzPZlLMr7a/Ue37tZUvN8mgRxH3Z1s/wjia17xf0mbmxY5qwY4zDmDsigccbmF8gm5GSJkX6tTc8QS73hvIZhT4pG7hROKA/me/cp0TxGCmKZHvwE8hfBVZvBH2LxWkMDs6AqUhdtBo79wJbrbZ54qYPFq5ECaNtg6iVgOC/aShXsz2ITAOnofHIp0YdzhpzhHo+k8+H4aSYgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjNiR1Q5Nm9Vb2xBcmdpdDVUQS9tQThCc0RscHp1NWVINkxSNTdmMktLZkdr?=
 =?utf-8?B?b2lGbUhDcTJwL0ZUU3RLRHNhZFkxcUx4ZzlKcWJ2ai85REZhZmZZbk9LVkVV?=
 =?utf-8?B?cDFKRUxHRFhzcDlyQklqdlhRVjBwZlpkKzRRMXJmVXRNRFZBeGEySXdQRDJY?=
 =?utf-8?B?eHpDRng1Zi9OOUpTL1RsRE5NQi93eE1tcE01dnd3djNHQStqdzZuZEdUU0lX?=
 =?utf-8?B?RW42R0owQXdXMGVwVTZ6SGtpaGhiS2xMUFFGckxGSWc0N3hBbTJ6UHc5d1ZH?=
 =?utf-8?B?QVRrK0FHU3dxRTRhdWJoZGtabmVtREt4RnAxZ0pITEJBQjNlbFVlc1VWclhh?=
 =?utf-8?B?MXBvcGEzczdXRFAxbXYva29OSy96ejEwYTJVWDQzSzd4OG9EUWxpbi9PTWZZ?=
 =?utf-8?B?TGFxT2laMmRwQ05BcXFweEtudWsrckpxdTRKUG5MS2JnTnA2Zzkwb2piR20r?=
 =?utf-8?B?KzZ4bHJiZzVaY2NsR1BQOVpSNXVrWjJjTEVlczlaQmsrUWlhTmVrelV1OUZL?=
 =?utf-8?B?YmVhWXRaend4MHBlWFJKeWl3RjVjWFdEWDh6S3hFaUM0bHdvNHZCNkt0TFB1?=
 =?utf-8?B?QW0ydGZRM0I5YXF3OHorNC9wUUJ4M0s4QkRLUkRNTXdTcjhmNjU5WkpXOHNl?=
 =?utf-8?B?bkZUKzQ2b09uemVDTkhKcnNWTjBsNms4U3JwSHRGMUdWSktDc3ErTEMzVWtt?=
 =?utf-8?B?SUwyQmU4Yldqcy9NUCt2UHpVL1NTajZ1aFdmYTl5R2VNWFBCNU41M2N2aHlL?=
 =?utf-8?B?c0VCaFpNNHhiNEp5T3lhRjllRG1Od1Z1OHJSLzhRazNNM3dBc2VDak1KaWwv?=
 =?utf-8?B?Ykd4QTVEYm83SHJBTEh5d2Z1S2NWWXdmZ29oMXNTMW9KNnpHNlgvOE9CdEp3?=
 =?utf-8?B?NTJsK1A1VkhlR1JYakorWUM5RUxCSGVoa1B3b1dETFZxYlhqWUdmYTl4OTMv?=
 =?utf-8?B?RFpyRVMycXBPY3RMTC9qbXN1YlI0aE9LcjZ4Mkc4MFhXUUZ2K1dQWGx4d3Mv?=
 =?utf-8?B?NXNXUVlUKzh3b1AxSURWMkdBZzhDeW5xU1ZnUFYxS09YUi9Za0JCd2FUajBh?=
 =?utf-8?B?R0JQbjJ0R0ZCMnIyS2RWbmFRRjRrZHFjK0NiYjZZaHFCWEw2dGVuMmVyT05E?=
 =?utf-8?B?T2xXNUJBRVFFQ0w5REgrYzdwOVFYM0I0R1lhQk8veWtjNHlHNW1uZmUwa1NI?=
 =?utf-8?B?ZE9DVTlDV3NQOTNWejlVaFBlNlU3dzNhZjhtMU1YTXJnVnk0YnFVM2ZaSzhq?=
 =?utf-8?B?Y3J0UnQvblBxZXRpTHk2MGJtTXpJNkJJcWM0V3F0L00xTTd4RmpiMGNweG1w?=
 =?utf-8?B?QjN6TUx4SWZsSSt5OUxKZHBIQW1SOGkrNndHVlRkczFRcmtsVzUvYmxsVnc5?=
 =?utf-8?B?cnlmajlRMm85TmZwZmcvbEJvbW9jVW5xRkVHNGhYVEMya0grVUpaOENWNFBw?=
 =?utf-8?B?bEYwbG85cVc2MFZqR3o3Rm5vQU9oRmhSRTRFa1lQNVI2RTRKVkhSZlJyelZD?=
 =?utf-8?B?ZWtXREVGVkVJK0JHQVQxU2ZXRUlGYkJaeURFVGJtOUtjWHVZQ2hWSWJxSXMy?=
 =?utf-8?B?RGZpc0QxTHMyVTZpenJoYWJjdHA1aER1cCtzcDdaSVJ1aWpTUTdhZWlldXMw?=
 =?utf-8?B?ZGVTNkdLNkt0YXNNZXhIaFQyc0J1VlI1V3QrdzlrMzJZL3NCTzA2ZjBZVUdn?=
 =?utf-8?B?dFo2bm1tNzVITE5LNXMyVVNCcVJrZWhta3puUUxWVjJBRDJPQ0RTSGswdkdq?=
 =?utf-8?B?VGFLcGZLeGdyQS9IZSsrTm1Jb3FlMkRqOWFDT0dYVGVkeHUrdWxONm42VytE?=
 =?utf-8?B?dDBSTWJoSTJLLzdIWGJUWHJYZHV6c3FUVDAvK3FES3JDQnVkb215VWNKQ1h0?=
 =?utf-8?B?clNVTlJJVVJFV3FjU0tNN2FONFBXQllqM1EzaC8yeDhiSXZ0UGYrdngwVFRN?=
 =?utf-8?B?b2pRWXVIenNhNEIwUjVXQk83RURLalpvYXUvM2dpWitUb3Foek1tcXdFdG9S?=
 =?utf-8?B?NTNucllwM2xyVTFDSXFrRHgzM2ZWT2FSK0h0dDMzNlNzM29MWDhVMFp3MEMw?=
 =?utf-8?B?QkFEaDBEbkg2aTdMTFRrdGE2eldLVzdrZWw1TDROUGJEYW90allkR2RkbVlW?=
 =?utf-8?B?OUc2WEZNZjNLcjdFbEhaZVI0eEhEM3BMMCtDQjloV3JNdGNMOGtCSzRzS3Bv?=
 =?utf-8?B?SENaZGJqNW9nK3JFUzNNQVFuRTRIR0hBdW5mRGJhWlFJSDlyRGJZRWFVMlZV?=
 =?utf-8?B?aG1LWnZ2TnJ6aHYzbVNYaE1uUnhOci9QVmgyNTBVTU5iOEVUM1VXZWtGT2Fu?=
 =?utf-8?B?SHN1UVk2M2JXVnRaWkQ5cnZLd3o3M3lKQzhnckFHZWxrWi9RMURFUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 71dc9325-685b-4fee-a14b-08de755861d6
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:59:19.3421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igV8pesZAjsjZeW8nGRi1EtEL/Mv84Qo+E/RdS6IYpouYn/faHLOwBFXUnAFQdPwl/zvVatzFRYURIVAUGLCx8NtO46H5XKgojSxGOiURMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9377
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

Hi Nikita,

On 2/26/26 5:39 PM, Nikita Shubin wrote:
> [You don't often get email from nikita.shubin@maquefel.me. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Fix compiler warning:
> 
> drivers/serial/ns16550.c: In function ‘serial_in_dynamic’:
> drivers/serial/ns16550.c:153:1: warning: control reaches end
>      of non-void function [-Wreturn-type]
>    153 | }
>        | ^
> 
> Observed with gcc 15.2.1:
> 
> $ riscv64-unknown-linux-gnu-gcc --version
> riscv64-unknown-linux-gnu-gcc (Gentoo 15.2.1_p20260214 p5) 15.2.1
> 

We also have another one in ns16550_readb that'll trigger the same 
warning I'm assuming. Ditto for ns16550_serial_pending.

Cheers,
Quentin
