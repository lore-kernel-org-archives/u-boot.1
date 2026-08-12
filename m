Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F876C5B572
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 12:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 255C681240;
	Wed, 12 Aug 2026 12:42:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YOM_1HBUZQdp; Wed, 12 Aug 2026 12:42:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F360C81239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786538540;
	bh=HIXL0tQ5j2th5nz450pqGB/5v9h2Nsco/Pa17QV8JU4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I880qzDJ7cwXdS9TDzntSIhf5GykpTH6ujB5iUmg1/hI3PJwjOC9Q3IO98qg5MzZb
	 clx5oFOiPK8WHT44sU+He4YwrANraIGSO2rdX4LE7eXwuqb+dMD8GgTLSFO9xBjmhA
	 ldCsxfZ13TA2NfiI7BynqMm9c5uUaFxUF76sQjBku+vI6piZPYi6b6ukw8Qf1/jup2
	 p7FsKFPmaoIe5pecNFmTpPcuav2LrALuig3CRWAF9OcXkI4A69//zRO21kOolBrd3n
	 4uxc/CQSzzv7qvYK3na59K+wMoDKVWmN/vIbABb0LiFO0hnmyIqrNs0eTSQfszyBnG
	 kVSc1jWPkIyrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F360C81239;
	Wed, 12 Aug 2026 12:42:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F2B9F1B8
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 12:42:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E4D8B608FA
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 12:42:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nPE2XGlNt0qm for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 12:42:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7C6C1608F4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C6C1608F4
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C6C1608F4
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 12:42:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqXHY4ICWYd7OnonNxVgBtOkRC7Jgmho69Zab9/UP/QCgTvz5M9qF8wzMlSYxFXIUOYyNtuJruHtxFB04FQNvFN9RRNDlXwiUlZqxFBxeTa7RbtYeeIOQpxXD8PPZmmRdfqqFjNx5k9tk0sM/f8OVIm9WVzCUdFpvL8zdpQiCtdSgcfb4CsYzLc8BcmMFr1prtUGOnLfPWpPm+LBdRE0i3/edP3a1WIpsM8JTQYT75Zb+5MJF12MiCwox2G3NtfuiWqc9uyhOkrv7peai2+4FFylBwnerXc2pWtiKdTnSUm1EWAJ96P4+GFA6rVWcuF/iczy1eTe902qyDVlcpkYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIXL0tQ5j2th5nz450pqGB/5v9h2Nsco/Pa17QV8JU4=;
 b=GWPUN5Az5VenrVRiSpQb5XNJyPkJXf9za1Ux6CwlOvRWXCT3At/jTpCDrSIBXOnXd510e6DRq9CnosDm/gFk0HFCiEkofKDizYcjITrhz3X2heCPSpNNjxiHogjLmn+3P90piYXJVhjexfjR4av1gIb8yMElHJGNkRuhzOyFT5LjlrsBoSq0S6sTivwV6EeiXu9JFgXwrAU0gQfM7d5TsaS5c1vchLPRgfA/XGNvUanJoLEiZYwPbuaiKbtVV4V6g6myJHWxRef8striwQzWIOXjRd6yVTtcWH+OC6W9aD2KR/Zb1H2YksLr6i6gd8uHiYPTHOp/LSFmkW7mYJBHvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 12:42:06 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 12:42:06 +0000
Message-ID: <fd9af4e6-17f3-4b3e-99c0-b6bb5a1ca79e@cherry.de>
Date: Wed, 12 Aug 2026 14:42:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] clk: rockchip: rk3506: Use FIELD_PREP_WM16 macro
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-6-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260803190946.2259514-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0085.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35c::18) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab1454e-67e6-46b5-1e7c-08def86f1db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|23010399003|22082099003|18002099003|5023799004|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: SCx+T36fqgE0hHcJSabC5kvep4qLzyLF24Opq7XGRAAVCGebi8mfGN+kYxYgA9UzJgh7y0Kul8AfK8qKUJsV5nD4/PIxsrrIlo1ZaFXWERLzTdAHZPpVTgC+3S8igJeSj7jyecLAQhqDLZgNYC9JdnfA3bF35kOs54cGq2G+uI6ki0FjHxiAxKqioSukz1NE9Ft57JJj5nUO72kIHOq11G+7MXPxmg29ajSm7CqtdKL3N+xtvCEg8EDI0RtfdrmS/SXwfHmKB8ZpsAQ90Yi2U7HcZ+hWvEvDWYbdkq7xHh9wtc9O8j2WMr1SmOAnUyhKSRM8QgWvytfgO0MqDs9QBeBpSrrvopTXBv9PAbrvugZrtrM6l2/ZmcJFfEjnNqFYDhz1wq8pxgqEM6VSN5yTUu26LEdMnSJgTGKHQn75GGyE12fwQ8Icqh6UYVo0hdBGQeA3aqxRJueNWqTCR0jrIMta5UBnEeHEAAKDyNknQHm9XgPrTJqyAESl3l6rdvsIT9mm8HhxAfda55QFAa7Rem/NcWM5xkzrijbiCpQsv1iBYfzRg/K2m22sc9QuVSZ1CRHIvi1glJyrhBpzuIKro9CWs3WQt2NFnVuH+JqFwfXjaNydTZM/dZF1cOk6nxFnfZWkYxlm6t4Ee1Xe2jmJWFgPlKgj1rjDQUsH3D6SkYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(23010399003)(22082099003)(18002099003)(5023799004)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm03aWJCSUNZY3hYOEg4aXlMNzRuVW5ZSVV4UHh6Z05XN2hzYVM0SlVpN2lx?=
 =?utf-8?B?V3NIVlc2b3ViSmF2SGprTzlHMVYyV1RoM3J2TEl2N0lIT2hwYTM2bDBJVHBu?=
 =?utf-8?B?cU5NOVdjcmFrMFZlUGpCSitRQ3MzclhNM0p4OUxsRTZxN0tGNzcwbU5EZWwz?=
 =?utf-8?B?Zi9ueFpKOGQ5SjJMaUlwd2hwY0ZwOEdzUlFWR2FwTmszYnhINWlKaVhOcWZS?=
 =?utf-8?B?NDBkTHB3SmVLcjR4NmMzeHhhbmEyTm43azB3OFJIck03RHptTGN3VnRlVGxW?=
 =?utf-8?B?eHdReU1BRUdRUnhndGExejAxQ3AyZXE1eEdLT1VjM05sNENYSFFlajVrRWxk?=
 =?utf-8?B?dG5zQ2ZvUjNBVEc3OEx4L1FkVnlsanJ3Ykc0K0lzQlFmbFVBY1BYSG5wZVdu?=
 =?utf-8?B?VmxMekRWcHlDL09mZ0RwNWJZSjE4aVEybmFxNXM5bUxJNUlLTkpXalJlell6?=
 =?utf-8?B?UFFvYmk3MG16N2N2RmdFazBsbE55clBIVGgydFNWQlBPQTIzaWZyRUJUem40?=
 =?utf-8?B?clhxZ1F3Wk16WnFZcGc5Q1cwNmZ1S2d3QXAyMFBnRFJnbzd0MGMrTzNodFBX?=
 =?utf-8?B?UUFzUjdITmlucy82UnBwNmVxOTNYYmhyQWg5bHozK1J1SVBDbzZ6L2UyQVZt?=
 =?utf-8?B?dUVQeUZLdXh2OVU2eGMzKzN3YzRqN1l0UHE1aE5STDE1bFFJZGtROXlVTXoz?=
 =?utf-8?B?RER0MHhDTnhHbUhkcWkrQlI5SjBheE1LZ1hDWVA3YU1UV0E3cVphWUt0MGJX?=
 =?utf-8?B?SldHejhGcS9venNtM21qbVkyRUVrZ0U2dy9BYldRU2t0Q2E4bFRYWGJoc0Yz?=
 =?utf-8?B?OGRQSmJBR2hhRGVuNTJSeTJNekhDSDRNdTlPTExuQi92ZTBTVElxMnZmR1lS?=
 =?utf-8?B?Z0tZOTBNVHRWSUhleldvQmZvYWJpQzl4TUNmUGxLRW9RdmRaUmp5N0Iyb0M4?=
 =?utf-8?B?ZTk1dlJIVXZXNDA5TFQ5U3pGR2ErZ3VmRXNGRWdPbksxd1pkUmxQNW1IU0l0?=
 =?utf-8?B?ZTY4dE0xTHdjUXFEWGdvc2VEOGtYcGo1Y1E2M0lnQkI5aWN5anNDSU9YWEFt?=
 =?utf-8?B?Zy9iYWxrbzRiUHM3S21NMzZDeVFoeGtLbDNiVkZxcDRLakdUWGZsVVNldjhw?=
 =?utf-8?B?d09hSkZFaEtPK0ZuT1luLzU4WXlJcVo3dTJUZmVzRUxMUXcrdDRaM3MvZXlZ?=
 =?utf-8?B?ZVExdUhEVjRFUGs5bmhEaGVGdWRkeTg3YW5lQ3NDWFlEUlRPWWFYeWZHbjcz?=
 =?utf-8?B?MDRUUnlKRkdHY2NlSlllK2RaNHRQRFhMdmJtZ2dzS1hjWmZXQktBWkMybURk?=
 =?utf-8?B?MlZIZXJibHdjeEdlMHBSdDZXNUJ6eGFLTHBaNWkySjB3dU1WSjJoNHVJZGZO?=
 =?utf-8?B?M1h5dVI4SjdPb2VieEpJVjNPU2FTMFFlcUNHdTZlczBpaE5RT1BBazA1UTB4?=
 =?utf-8?B?NjRMMHhUcDgwZWhjVDJvckorTW9VNDloaEREWlpGSk5uY1lFN3lpOWVXdzJy?=
 =?utf-8?B?eVFCQ3pKaEV3NE1rbTY5TW9mZmhJWEJOZy9TRU1ZdTVQZUtvZkY4NGZsYVVJ?=
 =?utf-8?B?c2xmZ2FDNUdpSkhCUk9tUDZvYm13R2JTQ2ZMUDdnY2V2K1RsdEMrMW44MW51?=
 =?utf-8?B?dVVsanJ1bGwxQStnTGtOK2g3U2JhQjNIdG5SNy9QM0xlZ0l6aEp1bnNjTFdR?=
 =?utf-8?B?eVZ6QWdDNGRYNzhsODZJVUVRMWJ3blk3QS9mVncrblpQU1lZY2lYc081c21J?=
 =?utf-8?B?MnVRTk41emMwZWIzME9SN0pnYmliSTZlRU1MUm9kdDlaMWlKai9MODFheFps?=
 =?utf-8?B?S0ZtMTBJR1lRWDhQSnBkTW04ODlrMkdySGhUeThIYnJLNjNpRDBxbyt1SDhV?=
 =?utf-8?B?RGo4Y1JBQXFBUm1DZnFOVjBPejhRdkhrUUxGZS84dS9ON0dhSElucW9MWE0y?=
 =?utf-8?B?QmRrV3dVZnloWmt0QWNnWnFYNnl2WDVCNDBsdmNoUDFiU3F3amsweFllTVg1?=
 =?utf-8?B?VEhjcmN0MXkyd0VrelE4RmF6N1RGY1MrUGlPMWxYVUh4U3JtU0VleHdkcHc1?=
 =?utf-8?B?OVdnWGt6NVVwYmdGL2d5UEF0c0psMHJUSXdLbDJhQ2hsd292aktIMUtpeGY4?=
 =?utf-8?B?bjlEYWJFTHhBRlhZQXhEZkRkeVVYVEtOcmQ0ZWFWNEQzRTVzeFNQdlA4VEZr?=
 =?utf-8?B?WjFKbU16Y2ZKcXpaY0plK3h2RTBOM3BLYlU2UDJ2QzI5ZEdla1ZValAxSlFY?=
 =?utf-8?B?K0xjNDYyMWRxckZYY3AxcXUvTVVxT1RMS3NlTHR2Zmc1UVhPbVR4U08xUE16?=
 =?utf-8?B?NjlHMzRWMUpUNERteGcrNWE5MW0rWm5CdllSMHpWMW1mdzlYKzBSdDJiSjBQ?=
 =?utf-8?Q?6/a5Qec2p2zry4/FV2a2bMoH2n/C/UsDTodKl8A0pXffA?=
X-MS-Exchange-AntiSpam-MessageData-1: lmlmFcOjsJjKlQ==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab1454e-67e6-46b5-1e7c-08def86f1db3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 12:42:06.1778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPoE3USeA1MPZbjl60Jn2QVzBDvxqodPIykXMhwyY+4ZLMG4uJ+rOuPXX2xptrkOrggWHllEkWwPRMbdzs840vXW5NRlN5mu12TG8YQ2o6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIXL0tQ5j2th5nz450pqGB/5v9h2Nsco/Pa17QV8JU4=;
 b=CtNBBHFMHhViKhSkdHBIdU0N27NiIfSxnu5FLblsXQtqUGHnCtmEtlduAUqCkUxZlhqVk/flrDlUNppRupW2jkOqfN2he3gx/21Wdhc+RhcqFH1NV6NkeLc49w254qa23WyF+JlB72sxX3PFXJJQFwXLeQT34k4cGoxaFCYe/i4=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=CtNBBHFM
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 8/3/26 9:09 PM, Jonas Karlman wrote:
> Change to use writel() together with the FIELD_PREP_WM16() macro
> instead of using the rk_clrsetreg() macro to avoid having to define the
> mask as a parameter to both rk_clrsetreg() and FIELD_PREP(). Also change
> to use u32 variables consistently.
> 
> No change in behavior is expected due to this code style change.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/clk/rockchip/clk_rk3506.c | 195 ++++++++++++++----------------
>   1 file changed, 90 insertions(+), 105 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
> index e156bf19a6b4..7ccab313e6ec 100644
> --- a/drivers/clk/rockchip/clk_rk3506.c
> +++ b/drivers/clk/rockchip/clk_rk3506.c
> @@ -9,10 +9,11 @@
>   #include <clk-uclass.h>
>   #include <asm/arch-rockchip/clock.h>
>   #include <asm/arch-rockchip/cru_rk3506.h>
> -#include <asm/arch-rockchip/hardware.h>
> +#include <asm/io.h>
>   #include <dm/device-internal.h>
>   #include <dm/lists.h>
>   #include <dt-bindings/clock/rockchip,rk3506-cru.h>
> +#include <linux/hw_bitfield.h>
>   
>   #define DIV_TO_RATE(input_rate, div)    ((input_rate) / ((div) + 1))
>   
> @@ -122,10 +123,10 @@ static int rk3506_armclk_set_rate(struct rk3506_clk_priv *priv, ulong new_rate)
>   	 */
>   	old_rate = rk3506_armclk_get_rate(priv);
>   	if (new_rate >= old_rate) {
> -		rk_clrsetreg(RK3506_CLKSEL_CON(15), ACLK_CORE_DIV_MASK,
> -			     FIELD_PREP(ACLK_CORE_DIV_MASK, rate->aclk_div));
> -		rk_clrsetreg(RK3506_CLKSEL_CON(16), PCLK_CORE_DIV_MASK,
> -			     FIELD_PREP(PCLK_CORE_DIV_MASK, rate->pclk_div));
> +		writel(FIELD_PREP_WM16(ACLK_CORE_DIV_MASK, rate->aclk_div),
> +		       RK3506_CLKSEL_CON(15));
> +		writel(FIELD_PREP_WM16(PCLK_CORE_DIV_MASK, rate->pclk_div),
> +		       RK3506_CLKSEL_CON(16));
>   	}
>   
>   	if (new_rate == 589824000 || new_rate == 1179648000) {
> @@ -146,22 +147,22 @@ static int rk3506_armclk_set_rate(struct rk3506_clk_priv *priv, ulong new_rate)
>   	con = readl(RK3506_CLKSEL_CON(15));
>   	old_div = FIELD_GET(CLK_CORE_SRC_DIV_MASK, con);
>   	if (DIV_TO_RATE(prate, old_div) > new_rate) {
> -		rk_clrsetreg(RK3506_CLKSEL_CON(15), CLK_CORE_SRC_DIV_MASK,
> -			     FIELD_PREP(CLK_CORE_SRC_DIV_MASK, div - 1));
> -		rk_clrsetreg(RK3506_CLKSEL_CON(15), CLK_CORE_SRC_SEL_MASK,
> -			     FIELD_PREP(CLK_CORE_SRC_SEL_MASK, sel));
> +		writel(FIELD_PREP_WM16(CLK_CORE_SRC_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(15));
> +		writel(FIELD_PREP_WM16(CLK_CORE_SRC_SEL_MASK, sel),
> +		       RK3506_CLKSEL_CON(15));
>   	} else {
> -		rk_clrsetreg(RK3506_CLKSEL_CON(15), CLK_CORE_SRC_SEL_MASK,
> -			     FIELD_PREP(CLK_CORE_SRC_SEL_MASK, sel));
> -		rk_clrsetreg(RK3506_CLKSEL_CON(15), CLK_CORE_SRC_DIV_MASK,
> -			     FIELD_PREP(CLK_CORE_SRC_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(CLK_CORE_SRC_SEL_MASK, sel),
> +		       RK3506_CLKSEL_CON(15));
> +		writel(FIELD_PREP_WM16(CLK_CORE_SRC_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(15));
>   	}
>   
>   	if (new_rate < old_rate) {
> -		rk_clrsetreg(RK3506_CLKSEL_CON(15), ACLK_CORE_DIV_MASK,
> -			     FIELD_PREP(ACLK_CORE_DIV_MASK, rate->aclk_div));
> -		rk_clrsetreg(RK3506_CLKSEL_CON(16), PCLK_CORE_DIV_MASK,
> -			     FIELD_PREP(PCLK_CORE_DIV_MASK, rate->pclk_div));
> +		writel(FIELD_PREP_WM16(ACLK_CORE_DIV_MASK, rate->aclk_div),
> +		       RK3506_CLKSEL_CON(15));
> +		writel(FIELD_PREP_WM16(PCLK_CORE_DIV_MASK, rate->pclk_div),
> +		       RK3506_CLKSEL_CON(16));
>   	}
>   
>   	return rk3506_armclk_get_rate(priv);
> @@ -209,26 +210,26 @@ static ulong rk3506_pll_div_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>   	case CLK_GPLL_DIV:
>   		div = DIV_ROUND_UP(priv->gpll_hz, rate);
>   		assert(div - 1 <= 15);
> -		rk_clrsetreg(RK3506_CLKSEL_CON(0), CLK_GPLL_DIV_MASK,
> -			     FIELD_PREP(CLK_GPLL_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(CLK_GPLL_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(0));
>   		break;
>   	case CLK_GPLL_DIV_100M:
>   		div = DIV_ROUND_UP(priv->gpll_div_hz, rate);
>   		assert(div - 1 <= 15);
> -		rk_clrsetreg(RK3506_CLKSEL_CON(0), CLK_GPLL_DIV_100M_MASK,
> -			     FIELD_PREP(CLK_GPLL_DIV_100M_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(CLK_GPLL_DIV_100M_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(0));
>   		break;
>   	case CLK_V0PLL_DIV:
>   		div = DIV_ROUND_UP(priv->v0pll_hz, rate);
>   		assert(div - 1 <= 15);
> -		rk_clrsetreg(RK3506_CLKSEL_CON(1), CLK_V0PLL_DIV_MASK,
> -			     FIELD_PREP(CLK_V0PLL_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(CLK_V0PLL_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(1));
>   		break;
>   	case CLK_V1PLL_DIV:
>   		div = DIV_ROUND_UP(priv->v1pll_hz, rate);
>   		assert(div - 1 <= 15);
> -		rk_clrsetreg(RK3506_CLKSEL_CON(1), CLK_V1PLL_DIV_MASK,
> -			     FIELD_PREP(CLK_V1PLL_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(CLK_V1PLL_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(1));
>   		break;
>   	default:
>   		return -ENOENT;
> @@ -293,22 +294,19 @@ static ulong rk3506_bus_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>   
>   	switch (clk_id) {
>   	case ACLK_BUS_ROOT:
> -		rk_clrsetreg(RK3506_CLKSEL_CON(21),
> -			     ACLK_BUS_SEL_MASK | ACLK_BUS_DIV_MASK,
> -			     FIELD_PREP(ACLK_BUS_SEL_MASK, sel) |
> -			     FIELD_PREP(ACLK_BUS_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(ACLK_BUS_SEL_MASK, sel) |
> +		       FIELD_PREP_WM16(ACLK_BUS_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(21));
>   		break;
>   	case HCLK_BUS_ROOT:
> -		rk_clrsetreg(RK3506_CLKSEL_CON(21),
> -			     HCLK_BUS_SEL_MASK | HCLK_BUS_DIV_MASK,
> -			     FIELD_PREP(HCLK_BUS_SEL_MASK, sel) |
> -			     FIELD_PREP(HCLK_BUS_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(HCLK_BUS_SEL_MASK, sel) |
> +		       FIELD_PREP_WM16(HCLK_BUS_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(21));
>   		break;
>   	case PCLK_BUS_ROOT:
> -		rk_clrsetreg(RK3506_CLKSEL_CON(22),
> -			     PCLK_BUS_SEL_MASK | PCLK_BUS_DIV_MASK,
> -			     FIELD_PREP(PCLK_BUS_SEL_MASK, sel) |
> -			     FIELD_PREP(PCLK_BUS_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(PCLK_BUS_SEL_MASK, sel) |
> +		       FIELD_PREP_WM16(PCLK_BUS_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(22));
>   		break;
>   	default:
>   		return -ENOENT;
> @@ -368,16 +366,14 @@ static ulong rk3506_peri_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>   
>   	switch (clk_id) {
>   	case ACLK_HSPERI_ROOT:
> -		rk_clrsetreg(RK3506_CLKSEL_CON(49),
> -			     ACLK_HSPERI_SEL_MASK | ACLK_HSPERI_DIV_MASK,
> -			     FIELD_PREP(ACLK_HSPERI_SEL_MASK, sel) |
> -			     FIELD_PREP(ACLK_HSPERI_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(ACLK_HSPERI_SEL_MASK, sel) |
> +		       FIELD_PREP_WM16(ACLK_HSPERI_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(49));
>   		break;
>   	case HCLK_LSPERI_ROOT:
> -		rk_clrsetreg(RK3506_CLKSEL_CON(29),
> -			     HCLK_LSPERI_SEL_MASK | HCLK_LSPERI_DIV_MASK,
> -			     FIELD_PREP(HCLK_LSPERI_SEL_MASK, sel) |
> -			     FIELD_PREP(HCLK_LSPERI_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(HCLK_LSPERI_SEL_MASK, sel) |
> +		       FIELD_PREP_WM16(HCLK_LSPERI_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(29));
>   		break;
>   	default:
>   		return -ENOENT;
> @@ -429,10 +425,9 @@ static ulong rk3506_sdmmc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>   	}
>   	assert(div - 1 <= 63);
>   
> -	rk_clrsetreg(RK3506_CLKSEL_CON(49),
> -		     CCLK_SDMMC_SEL_MASK | CCLK_SDMMC_DIV_MASK,
> -		     FIELD_PREP(CCLK_SDMMC_SEL_MASK, sel) |
> -		     FIELD_PREP(CCLK_SDMMC_DIV_MASK, div - 1));
> +	writel(FIELD_PREP_WM16(CCLK_SDMMC_SEL_MASK, sel) |
> +	       FIELD_PREP_WM16(CCLK_SDMMC_DIV_MASK, div - 1),
> +	       RK3506_CLKSEL_CON(49));
>   
>   	return rk3506_sdmmc_get_rate(priv, clk_id);
>   }
> @@ -472,10 +467,9 @@ static ulong rk3506_saradc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>   	}
>   	assert(div - 1 <= 15);
>   
> -	rk_clrsetreg(RK3506_CLKSEL_CON(54),
> -		     CLK_SARADC_SEL_MASK | CLK_SARADC_DIV_MASK,
> -		     FIELD_PREP(CLK_SARADC_SEL_MASK, sel) |
> -		     FIELD_PREP(CLK_SARADC_DIV_MASK, div - 1));
> +	writel(FIELD_PREP_WM16(CLK_SARADC_SEL_MASK, sel) |
> +	       FIELD_PREP_WM16(CLK_SARADC_DIV_MASK, div - 1),
> +	       RK3506_CLKSEL_CON(54));
>   
>   	return rk3506_saradc_get_rate(priv, clk_id);
>   }
> @@ -485,6 +479,7 @@ static ulong rk3506_tsadc_get_rate(struct rk3506_clk_priv *priv, ulong clk_id)
>   	u32 con, div;
>   
>   	con = readl(RK3506_CLKSEL_CON(61));
> +
>   	switch (clk_id) {
>   	case CLK_TSADC_TSEN:
>   		div = FIELD_GET(CLK_TSADC_TSEN_DIV_MASK, con);
> @@ -508,14 +503,14 @@ static ulong rk3506_tsadc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>   	case CLK_TSADC_TSEN:
>   		div = DIV_ROUND_UP(OSC_HZ, rate);
>   		assert(div - 1 <= 7);
> -		rk_clrsetreg(RK3506_CLKSEL_CON(61), CLK_TSADC_TSEN_DIV_MASK,
> -			     FIELD_PREP(CLK_TSADC_TSEN_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(CLK_TSADC_TSEN_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(61));
>   		break;
>   	case CLK_TSADC:
>   		div = DIV_ROUND_UP(OSC_HZ, rate);
>   		assert(div - 1 <= 255);
> -		rk_clrsetreg(RK3506_CLKSEL_CON(61), CLK_TSADC_DIV_MASK,
> -			     FIELD_PREP(CLK_TSADC_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(CLK_TSADC_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(61));
>   		break;
>   	default:
>   		return -ENOENT;
> @@ -580,22 +575,19 @@ static ulong rk3506_i2c_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>   
>   	switch (clk_id) {
>   	case CLK_I2C0:
> -		rk_clrsetreg(RK3506_CLKSEL_CON(32),
> -			     CLK_I2C0_SEL_MASK | CLK_I2C0_DIV_MASK,
> -			     FIELD_PREP(CLK_I2C0_SEL_MASK, sel) |
> -			     FIELD_PREP(CLK_I2C0_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(CLK_I2C0_SEL_MASK, sel) |
> +		       FIELD_PREP_WM16(CLK_I2C0_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(32));
>   		break;
>   	case CLK_I2C1:
> -		rk_clrsetreg(RK3506_CLKSEL_CON(32),
> -			     CLK_I2C1_SEL_MASK | CLK_I2C1_DIV_MASK,
> -			     FIELD_PREP(CLK_I2C1_SEL_MASK, sel) |
> -			     FIELD_PREP(CLK_I2C1_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(CLK_I2C1_SEL_MASK, sel) |
> +		       FIELD_PREP_WM16(CLK_I2C1_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(32));
>   		break;
>   	case CLK_I2C2:
> -		rk_clrsetreg(RK3506_CLKSEL_CON(33),
> -			     CLK_I2C2_SEL_MASK | CLK_I2C2_DIV_MASK,
> -			     FIELD_PREP(CLK_I2C2_SEL_MASK, sel) |
> -			     FIELD_PREP(CLK_I2C2_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(CLK_I2C2_SEL_MASK, sel) |
> +		       FIELD_PREP_WM16(CLK_I2C2_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(33));
>   		break;
>   	default:
>   		return -ENOENT;
> @@ -644,8 +636,8 @@ static ulong rk3506_pwm_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>   	case CLK_PWM0:
>   		div = DIV_ROUND_UP(priv->gpll_div_100mhz, rate);
>   		assert(div - 1 <= 15);
> -		rk_clrsetreg(RK3506_PMU_CLKSEL_CON(0), CLK_PWM0_DIV_MASK,
> -			     FIELD_PREP(CLK_PWM0_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(CLK_PWM0_DIV_MASK, div - 1),
> +		       RK3506_PMU_CLKSEL_CON(0));
>   		break;
>   	case CLK_PWM1:
>   		if (priv->v0pll_hz % rate == 0) {
> @@ -659,10 +651,9 @@ static ulong rk3506_pwm_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>   			div = DIV_ROUND_UP(priv->gpll_div_hz, rate);
>   		}
>   		assert(div - 1 <= 15);
> -		rk_clrsetreg(RK3506_CLKSEL_CON(33),
> -			     CLK_PWM1_SEL_MASK | CLK_PWM1_DIV_MASK,
> -			     FIELD_PREP(CLK_PWM1_SEL_MASK, sel) |
> -			     FIELD_PREP(CLK_PWM1_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(CLK_PWM1_SEL_MASK, sel) |
> +		       FIELD_PREP_WM16(CLK_PWM1_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(33));
>   		break;
>   	default:
>   		return -ENOENT;
> @@ -727,16 +718,14 @@ static ulong rk3506_spi_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>   
>   	switch (clk_id) {
>   	case CLK_SPI0:
> -		rk_clrsetreg(RK3506_CLKSEL_CON(34),
> -			     CLK_SPI0_SEL_MASK | CLK_SPI0_DIV_MASK,
> -			     FIELD_PREP(CLK_SPI0_SEL_MASK, sel) |
> -			     FIELD_PREP(CLK_SPI0_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(CLK_SPI0_SEL_MASK, sel) |
> +		       FIELD_PREP_WM16(CLK_SPI0_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(34));
>   		break;
>   	case CLK_SPI1:
> -		rk_clrsetreg(RK3506_CLKSEL_CON(34),
> -			     CLK_SPI1_SEL_MASK | CLK_SPI1_DIV_MASK,
> -			     FIELD_PREP(CLK_SPI1_SEL_MASK, sel) |
> -			     FIELD_PREP(CLK_SPI1_DIV_MASK, div - 1));
> +		writel(FIELD_PREP_WM16(CLK_SPI1_SEL_MASK, sel) |
> +		       FIELD_PREP_WM16(CLK_SPI1_DIV_MASK, div - 1),
> +		       RK3506_CLKSEL_CON(34));
>   		break;
>   	default:
>   		return -ENOENT;
> @@ -770,7 +759,7 @@ static ulong rk3506_fspi_get_rate(struct rk3506_clk_priv *priv)
>   
>   static ulong rk3506_fspi_set_rate(struct rk3506_clk_priv *priv, ulong rate)
>   {
> -	int div, sel;
> +	u32 div, sel;
>   
>   	if (OSC_HZ % rate == 0) {
>   		sel = SCLK_FSPI_SEL_24M;
> @@ -787,10 +776,9 @@ static ulong rk3506_fspi_set_rate(struct rk3506_clk_priv *priv, ulong rate)
>   	}
>   	assert(div - 1 <= 31);
>   

If somehow div = 0, then this will result in an underflow. Because it's 
an unsigned type, it'll wrap around and start at U32_MAX so assert() 
should catch it. However, assert() is a noop when DEBUG constant isn't 
defined, so this actually does nothing.

We should switch those assert to something that actually does something 
otherwise we could still very well attempt to write a divider that's too 
big and have weird behaviors instead of outright fail when we know we 
cannot do something that's requested.

This here doesn't change the logic anyway so this can be done in a 
follow-up patch, thus:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
