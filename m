Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7DFCAC5A7
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 09:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62C67833F5;
	Mon, 22 Sep 2025 11:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FRq+vYXr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37F7283335; Mon, 22 Sep 2025 11:29:15 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1EEA83211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 11:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGlXE4T97gXc5Yx+j8UfzzV9mxVmfiLkldEJswrBZMthJSQ3buWTohhCIXfdhx166D+12sXKlwVCbyXSFY41b7v83vp2AD+VwtGC/LxRb1ZDwZNh+VdzpXN6P5u132jiV/Kq3HBBraq3hqIbnDPyeP8L5fq0qQuad+5uCXmYmMr1gamgLy/ORaLDdTH1ZLaDPPmkyZGDb7r5XaxuhTlZ+ZRVfGOdWFQnnkhB0+eoAdqQOXPdhNAxrwWAjzv4ZEydi/hv6ut/vnID/ksT8kMw6M7kbGqJQP/AZndb5lp25ZlB3DdXK/EF7ot1C25bUOVK1Miq1qiYMOUPlHyVY+D5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFQ+z930KQLAj35r4WThP2Iff+1LvVDnOHn6BJo0gd0=;
 b=mNnU4AReOKOaQOLg0iiaotu8T1Mpw87sLYkWTXXJsHgNxeeAEyPirBzln+S6MqKN0PWfp781X+ZTJwASRVitDtDd0Ni7vpAhpRZdcmmP9w5rZeRfTg7uJjTrI2LGe/zmkIo4+pPct4KvstGAtcgxIC+e5RWl520m4V3iIVlprIC+WWV5sDEk3nPvGrpToQCn/TXWvK+UCbPUlNHuj007tWe/CebjoW8PGyxrUZhLHvMNsrhibiz19KoyZ1tTA9JUA48x3xU0eWnFG47HKDrunLYYOS9J1RRHPkhgDnUQjfgUtz8q3mQVn+iKUBkDhcMvy/s3TOowdG35xIxsBA0Ceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFQ+z930KQLAj35r4WThP2Iff+1LvVDnOHn6BJo0gd0=;
 b=FRq+vYXrLKzumeEWqnPeJLlYfTil9s0YYVRgPpCEgya5ZkDAWgsGxB0N4T7p+n8hy8euG5uQ2vIuakRhqihSH2mXJrM60MG74wrGzMlRyGG0VstKku5r8uSY9LCtXLwGlMPy4lybXUHo8Nn3lwbTq6nEwh8b497VYWdDSdxZY0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10694.eurprd04.prod.outlook.com (2603:10a6:10:582::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 09:29:08 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 09:29:08 +0000
Message-ID: <90dbc926-fe8e-47f2-8bb3-abed563742d0@cherry.de>
Date: Mon, 22 Sep 2025 11:29:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] lib: optee: forbid OP-TEE OS loading without adding
 OP-TEE OS reserved-memory nodes
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20250919-tee-env-needs-optee-lib-v1-1-2d52e75f7580@cherry.de>
 <20250919161009.GX124814@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250919161009.GX124814@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10694:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc89a59-9f0f-4c32-32a9-08ddf9ba7b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEJvb2xVcUxLY0ZoSitleGZsT3JFb284OTdqdDhpMURUb3ZHUkRsTk52TzRs?=
 =?utf-8?B?Wjk1bmVjVEdTdEZsU09oL090R2t3bUNOaHhwMUZGRUlGSmlESi9BWGNRZjdG?=
 =?utf-8?B?a1JpU2lwVzMzSVRjSlppYWlsdWF3QUQzbS80ZUF5OW55Q01RZk5OWWVlanVj?=
 =?utf-8?B?M2xvbDB5dGhHWEJtUmNrQVdvNG1sM1ZBUzZzVTY0SkhzSkZ0MENxc0puM25X?=
 =?utf-8?B?eDlvTmJQTzM4b05CRGhNbDFlcFJnQ1BxSXZ5U1hlZkEyREg0Ny9LR3BOcFdT?=
 =?utf-8?B?M0N5VXJ4RjdXdW90K1grMDhVblluRWR0b0p3eW8vYXdiQzFQK3VNNlVNSHdL?=
 =?utf-8?B?MXM2K3BoTGxUb29ycUpET2xrSGZaeVd5YmFDdDNPTTBvWEZQeFE4TDhoYVQr?=
 =?utf-8?B?UlErbk1ucTgwVXJaNDc0SGIrSkJCTldKZjVwN3J1eEFBZHhKdngrT05DOFNB?=
 =?utf-8?B?WDAxQWdhWXVvK3ZDMW1YZ3VFcW1iZEM4bEk2YTJrbnFoWWFSTXZHczkzRXA3?=
 =?utf-8?B?NGlickM5dHBEZGVhZk1VbTNNU2I3bmlUVEs4WkZ1SENqcFZIbjlXS2lDaUlK?=
 =?utf-8?B?WnRKc1RkRkw4UDd4SVNQS0hlV1JuR1RMcmdWOWdKR0ZnT0RYamZxREwrN3NW?=
 =?utf-8?B?K0s5ekZuMDlDRFcxeGt6UExkNHNvdmJwMVlpV1JsZ2tTL3FDcGFnZVNXQzBw?=
 =?utf-8?B?ZGxoV3VQcHhOdkE5eDhONG9Gelg2a1UyaFlkWE1ncUlKekNSSktzNWxCUG5E?=
 =?utf-8?B?bmoyQ3A1Zi8vamxDc3Z4dytOc2hUR2N3NnlyNmpLT3gvbVpwNWZSaXE0VHpr?=
 =?utf-8?B?aUs3a1dqc3RjT0dpSDczS08xNnhpSHRaTVVMVjA5enJ0UVpZMzZyNHVPSjJQ?=
 =?utf-8?B?V0NTVWdsc3RMb0hpQkliUGx4QndabW5rdWlKNGZUNFc1eWJ5QTFNTkVkOE9Z?=
 =?utf-8?B?dXJKODFRdWswMk5sUTZQS2hzK1czV2s3T25GcysyaGVpT0s5K2htZHpPcFhU?=
 =?utf-8?B?Uy9xcHFQSDRsMlVWSFFDK0k0ZERsa2tGaHhBTTdVbTB2cXEzUjgyV1ZDRHhK?=
 =?utf-8?B?V3A3QlRaanZYNmpxaEtudEU5QlFRYkxEcHM1ZVcrT1FCaGNFRXR3d1djZGlR?=
 =?utf-8?B?aHBabFZuV2dMYUQrWHBiQW1jVmdtTWNHa0lUNkFXY3ZVZTBCb2FnaUs5L3dB?=
 =?utf-8?B?b3hoL2ZhZ21wbUxkVnc0ellaeGp6VmlwWEdrdFA2ZVUzbFFHcnBtU1FnWnlL?=
 =?utf-8?B?alNMUEVSWnJaa2RKallrZ1BzaTFvU0FkWnZ0QnZrM1hQajFTM1U0ZzhGQjZ2?=
 =?utf-8?B?WUpFcjVSQ2xoSk1jRmZoUWRuSWtjNFlxOGJQbUpsNG1uS0FqUHM1VnVaR0VQ?=
 =?utf-8?B?WEFoZjRveVJ2WVEwc2VzcDdXMzBRR0tlZDRRa0dVQXNrQ2FPWjg2ZTRxRlo1?=
 =?utf-8?B?RXlFVzdPOFpWb0t0RUk2SXFxQzZvaVYrcWFFNWNzc2M2QWZTYWN5K0lDaVRn?=
 =?utf-8?B?QUdtMjlVRzV6Q0kzL0JjUkdsczRsdElIQTBPRE9DZjFlK0FSK1dqY0RyUVFN?=
 =?utf-8?B?YjUvQmxlejZXMnJ2bnpwWm9lUSs0QVV3QndObURtV0psTE9JdlFkc01uaFU3?=
 =?utf-8?B?RllaSU9OQ05VY3pNalgxSkxLVUZkSFpWakpnZXFBaWphWllDczVFSC9jTEhY?=
 =?utf-8?B?eUora2E3SHNXQ0VHVUQ3SnRTQXZ5cHk3N1NUbkNtZjNqYTdQNVJNRXlRcjNx?=
 =?utf-8?B?OVVMNnNkTlJnWTdXWHc3VFhHOEc3NE0vbHQvM2Fsd2t4Z3RFcHJXMThydC94?=
 =?utf-8?B?QUtSRkZEdjRNWnVMc1F4UGRraC9DQWFpQjU4VlA2UGFCZGpEc2Z6Qzk1RC81?=
 =?utf-8?B?R3I0VEpxVGJTcFB3TFRqOUtRZGlqLzlpTFcxL0s0aFEyaDhqUHh5Rjc5QXR4?=
 =?utf-8?Q?Ly9HBqL0m5k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1hhMFNEdGRSaEZFQ0ord0dhbm55OHQ1RFhVWVNZdDlKTFNwbzJ1VHUxVGZH?=
 =?utf-8?B?alBtRzBSczBPbnFSY2s2a2hlUDNZRHB3OHZ0MHBpbVNpTXM0dUZoemdJNWMx?=
 =?utf-8?B?UDR3YXUyQkdURXh6OUJYNTNJeGhqOG5OUFlpRTg3SWVBNXBheXJFMlpZdG5M?=
 =?utf-8?B?Y2cxeEI4OWtWdVZPSzhubUxtMFZJSUFDNFRaOWVsa1V0MGdJQXhNTmdQZ2F3?=
 =?utf-8?B?NUdYTzVKOHhrdklSZDJ5VU9FN1ltTUI2Vk1qTm9SbGtNdEZ2MTVqRzQrRmpz?=
 =?utf-8?B?bHhkRGpoTkFmaWhURVBOYzRPZGk4NGczdmJlcU0yaFA0SEQ1QkNTMDRzUFJR?=
 =?utf-8?B?b05jOFRtQWtZeEtDaUs4RW9TRGhxUEhsS1ZNcUk1NTRRd3BiVVRqOG9vdm1K?=
 =?utf-8?B?Q2lnczlBc2pjak9rekRtM05oTGord29Wc3lsbTRHc3ptNnZyaUtkRUI4QkZi?=
 =?utf-8?B?UEdvTjhHN3dKSUQ3Q3Btc1VvSDN5cVpRWkkzWEttY2xYL21QeUErSkxMTHla?=
 =?utf-8?B?N0F1c2tsMUtzQ3AvbEVnTWhEVUJudFVXUnJHaDBRYU9hazhXNEhDUjh4MHpn?=
 =?utf-8?B?VEFUUzV0cDFuZXhjZWhpcER5aVV1NmF3dzBYbHdEbXhuSkIzeXk4YXZnVUxx?=
 =?utf-8?B?QjdYTlJzbFltUUk5NVI1S3pQTmlmdnptUzJXL0xhaGFuTjJtcXgvRFdTckwr?=
 =?utf-8?B?NitZcldCMlZSK3hGUnh4QUhJaXFadzQwV1BGaVNGVVVkQzlrODhqU283bnl1?=
 =?utf-8?B?K2pONThBL1A1dVZ2REh3S29PYWNIUFpjNGZwM3pvOWJsK0oremtYQkp1RUFa?=
 =?utf-8?B?ZUQrKy9kNS8vb1NaR0tPSDFTckxJQzhNU241emNGUFNOcHhvQWY3c2xsUGV0?=
 =?utf-8?B?WnBBeERSckMyanR3WGNNdngrTjE5d2JwQW4yUGZEaHhYU0M0QXJhLzgyOTNz?=
 =?utf-8?B?VGVPazgvcWtSaVIrK25hc2RpT2pmT051VDNSVXBuMGRnUXM5MWR1azlsV3B1?=
 =?utf-8?B?Y1hUa1Q1a1RiU2FIaDd0NEpRbU9kNUlSQU1BYk12RlI0d1oxUEtlWW1EMGVu?=
 =?utf-8?B?YkZqeVdqVUFsc2gxM2Y5ZUoyVlJsN3RXSkhqV014bjd2czJvOUlTaFNUNjFH?=
 =?utf-8?B?bmJ6Tk5EQUs0UmVpaFdHdi8rcTNRVm5majhlWElWNG50T3doaFI3aWVHbGhE?=
 =?utf-8?B?MTNqZ1R2VUN5bVNCSWxUYkpxY0J0Wk9uaFlGbWxoaHlETzh3d0pWNjUxY0ow?=
 =?utf-8?B?VStTYXdkQVJsTUR1YWtUUWlYZ25VbjFEd0dhN3Y0Mi9TbVlMVUZURytsY3Yv?=
 =?utf-8?B?WUpHRXhWWnRNQkIyVzYzS25sblVOamxZWDZoQWxNM2tSUnVwL3NQemlHa0RU?=
 =?utf-8?B?RHBOTFg5MnpKdlJCeHRPOUFBa2R0ekI3UFhrYzRiZ1RoeGNjeVdjUlZFenh2?=
 =?utf-8?B?SjFnNGFEN0pzakRPUXFFTVluSTNkQWNpWFhyWWUwRFROVHM2VnV4VXFWeTlN?=
 =?utf-8?B?TThhaFF6NTVjOFlFR3ZacWdhcVNKNlJGNTJWUkgxenp6eWdlN1VzWmg5WWtX?=
 =?utf-8?B?OVdYays2QXZDSDlzMzRvR2E0N0RpK3V0NW10a1lQVS9hRCszWHhYNzVLQWox?=
 =?utf-8?B?YVRYYy91Tms4ckovMDIwaWE4QXNyZWRoVCtNeUVuRExENGhIdGxuSS9XMlBZ?=
 =?utf-8?B?K1JkMXd1RVpNNG9uMGI1MXRYY05YeTU5VlU2a254OGZ1YTVzcFMvZHprOEhJ?=
 =?utf-8?B?cC9LcnRhRHJsbkJ5THR6dithUlNpdnpVVHlsQjM2ZytkNC9seE40RmJncVQw?=
 =?utf-8?B?TjE0REFVMDkxWXBpZ01TYU90WDF4RkU4Z2ZsSGkrYUJHbXo2T2xVUmxoZE03?=
 =?utf-8?B?WEgvWnF3RmpsZTh0eXpJaXFEQjUyY3FtZG5EQlZtaW0vcE5VQVRKNkxkYS8y?=
 =?utf-8?B?OFZqT3JUMktMekdpcUhDSWJiOWQ2cUpWdnMzai9mbVFKVkpVQTBjcHY5QklU?=
 =?utf-8?B?V2R1aEhPdnh0dkt4cXZtMEJxZlFHb0hXN3MwcDBQTzZENjc2Um82MVpNUk5s?=
 =?utf-8?B?RGs4TFo1bG10cUVoVHlNR2YrOHkvYUVJcWMrUEt2NnJIajdadkI4ZmpOVHlF?=
 =?utf-8?B?Nncvb0RNa1pwdkI0SWczak9ET3BiQmQrNDgwSzlWNS9LM0lRNTJOT3BXTlpv?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc89a59-9f0f-4c32-32a9-08ddf9ba7b00
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 09:29:08.1081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFlzo6zBhVKGDsSycBHl8pMdZyc3DrtUVifZmKDYSvma2EZuirWjNYcZSyLztcFbJhbyruHh41t8FO1nXLLCzepUCm7fKltQGSAM1EcwH64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10694
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

On 9/19/25 6:10 PM, Tom Rini wrote:
> On Fri, Sep 19, 2025 at 05:50:21PM +0200, Quentin Schulz wrote:
> 
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> It is currently possible to build an image with an OP-TEE OS (via the
>> TEE environment variable) without OPTEE_LIB. U-Boot will happily load
>> the TEE OS and the next OS (e.g. the Linux kernel).
>>
>> This is an issue because on FDT-enabled devices, OP-TEE OS adds nodes to
>> the reserved-memory FDT node for the memory regions it just reserved for
>> itself. This updated is then passed to U-Boot proper which should know
>> better not to use memory from there. The actual issue is that without
>> OPTEE_LIB and OF_LIBFDT enabled, U-Boot proper will not copy those nodes
>> over to the next OS's FDT before starting it. This results in the next
>> OS's (e.g. Linux kernel) to not be aware of reserved memory, incurring
>> random crashes or device reboots when it tries to access secure reserved
>> memory area.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> I've just lost a day trying to figure out why my board suddenly boot
>> loops when running a specific program in Linux userspace after updating
>> U-Boot. I actually inadvertently had the TEE environment variable set
>> for a device which doesn't actually need to run any TEE OS (so had
>> OPTEE_LIB disabled).
>>
>> This device is Rockchip PX30-based and the image is built with binman
>> like all Rockchip-based devices.
>>
>> The issue is that I built a U-Boot FIT with an OP-TEE OS that reserves
>> some memory regions for itself (via the TEE environment variable) but
>> U-Boot proper "forgot" to propagate those to the Linux kernel's FDT
>> (because of the missing OPTEE_LIB).
>>
>> Unfortunately, binman doesn't seem to have access to Kconfig symbols
>> (grep CONFIG_ doesn't return anything meaningful and binman is either
>>   configured through FDT nodes or via CLI arguments, c.f. cmd_binman in
>>   the root Makefile) so I cannot try to be smart and guide the user to
>> the correct Kconfig option to select if TEE is set. I could add a
>> property based on the presence of OPTEE_LIB in rockchip-u-boot.dtsi for
>> example and have a custom message based on that, the issue is that I
>> assume all FDT-based platforms do actually need to do this dance, and
>> not only Rockchip.
>> Another option could be to add a CLI argument to binman through which
>> we would pass the state of OPTEE_LIB and error out the build in that
>> case, but that feels like opening the door to dirty hacks (though this
>> patch is admittedly another dirty hack :) ).
>>
>> Another option is to propagate the TEE environment variable to the
>> preprocessor of the FDT (via dtc_cpp_flags) and then I can do
>>
>>   #if defined(TEE) && !IS_ENABLED(CONFIG_OPTEE_LIB)
>>   #error "CONFIG_OPTEE_LIB must be enabled!"
>>   #endif
>>
>> but we have the same issue as above, it is then Rockchip specific and
>> also feels bad.
>>
>> Another option is to remove the @tee-SEQ node from the binman FIT
>> description when OPTEE_LIB isn't set but then I would lose the nice
>> message when no TEE is provided:
>>
>> Image 'simple-bin' is missing optional external blobs but is still functional: tee-os
>>
>> and even worse, build without any TEE OS even though I could provide one
>> with the TEE environment variable.
>>
>> Finally, another option could be to move this hack under
>> arch/arm/mach-rockchip/Kconfig to make it Rockchip specific or add a
>> depends on ARCH_ROCKCHIP
>>
>> OP-TEE OS on Aarch32 Rockchip boards doesn't actually need any of that
>> if SPL_OPTEE_IMAGE is set because arch/arm/mach-rockchip/sdram.c then
>> marks some hardcoded memory regions in RAM as holes in DRAM, which has
>> the same effect as reserved memory regions I guess. I assume other
>> platforms may use something different, so it may be casting too wide of
>> a net.
>>
>> Does anyone have something more delicate than this sledgehammer of a
>> solution?
> 
> It looks like on other SoCs there's an ARCH_x wide imply/select OPTEE
> (which in turn gets OPTEE_LIB), so is there a case for ARCH_ROCKCHIP &&
> !ARM64 && !OPTEE ? I see you explained that 32bit has a workaround for
> this already.
> 

The issue is that on Rockchip you don't need OPTEE to be selected for 
the OP-TEE OS to be integrated in the U-Boot FIT image. You simply set 
the TEE environment variable to the path to the bl32 binary and it's 
going to include it in the U-Boot FIT.

I think this is actually a good thing to be allowed to have the OP-TEE 
OS image **without** the OPTEE driver being compiled: if I want OP-TEE 
OS to be loaded in the system, this will be done by the SPL by loading 
the binary at a specific location in RAM, but I may not want to increase 
the attack surface by enabling the OP-TEE driver in U-Boot if I don't 
need to interact with OP-TEE OS from U-Boot at all.

The Aarch64 Rockchip SoCs also do not require OP-TEE OS to work (but I 
**think** Aarch32 SoCs do?). "imply" in that case would not be enough 
because we would still be able to include the OP-TEE OS image in the 
U-Boot FIT without OPTEE driver compiled in (and thus OPTEE_LIB). 
"select" would be too strong, because we really don't need OP-TEE OS (or 
rather its driver, but the latter kind of implies the former) to be in 
the image in order for the kernel to work just fine.

It all boils down to the ability to add OP-TEE OS to U-Boot FIT via the 
TEE environment variable without changing the defconfig (i.e. it's 
optional). We could make the @tee-SEQ node in 
arch/arm/dts/rockchip-u-boot.dtsi presence depend on OPTEE_LIB for 
example, but then we wouldn't be able to tell the user that the TEE OS 
image is missing. Also, this would limit TEE OS to OP-TEE OS (which I 
assume is probably what everybody is using on Rockchip but we could be 
using something else technically?). That may be an acceptable limitation 
though!

As for forcing OPTEE_LIB on Aarch32 Rockchip SoCs on, this OPTEE_LIB 
thing relies on OP-TEE OS patching the DTB passed to U-Boot proper so 
that the reserved memory nodes for OP-TEE are made explicit. I somehow 
doubt this is necessarily handled by OP-TEE blobs from Rockchip? Which 
means that I'm not sure that switching the hardcoded implementation to 
use the logic in OPTEE_LIB will be enough.
This also reminds me that TF-A blobs from Rockchip (used to?) crash for 
some DTBs, which was worked around by simply just no passing the DTB to 
TF-A (see SPL_ATF_NO_PLATFORM_PARAM), which I assume means OP-TEE OS 
doesn't have access to a DTB so cannot patch it. I'm not sure how (if!) 
it is handled by U-Boot in that case.

Cheers,
Quentin
